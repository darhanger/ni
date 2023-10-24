-- Локалки --
local tonumber, GetSpellInfo, IsUsableSpell, IsSpellKnown, IsActiveBattlefieldArena, UnitInBattleground, GetZoneText, IsSpellInRange = tonumber, GetSpellInfo, IsUsableSpell, IsSpellKnown, IsActiveBattlefieldArena, UnitInBattleground, GetZoneText, IsSpellInRange
local lastSpell, lastGuid, lastTime = "", "", 0;
local cbuff = { 30940, 60158, 59301, 642, 31224, 23920, 33786, 19263, 21892, 40733, 45438, 69051, 69056, 20223 };
local mbuff = { 30940, 59301, 45438, 33786, 21892, 40733, 69051 };
local tbuff = { 30940, 59301, 45438, 33786, 21892, 40733, 19263, 1022, 69051 };
local targetdebuff = { 33786, 18647, 10955, 10326, 14327 };
local forsdebuff = { 6215, 8122, 5484, 2637, 5246, 6358, 605, 22686, 74384, 49106, 35280, 36866 };
local pbuff = { 430, 433, 25990, 58984, 11392, 32612, 47585 };
local pdebuff = { 34661, 71289, 33684, 52509, 51750, 35856, 70157, 33173, 33652, 69645 };
local _, class = UnitClass("player");
local control = { 71289, 605 };
local undercontrol = { 33786, 64044, 10890, 12826, 28271, 61025, 61305, 61721, 61780, 20066, 10308, 14311, 47860, 6215, 17928, 51514 };
local purgebuff = { 38210, 48068, 48066, 61301, 43039, 43020, 48441, 11841, 43046, 18100 };
-- Общая переменная --
local ri = {};
-- Общие таймеры
ri.LastDispel = 0
ri.LastInterrupt = 0
-- Функция для проверки доступности заклинания для мили спеков --
ri.spellusable = function(id, stutter)
    if tonumber(id) == nil then
        id = ni.spell.id(id)
    end
    local result = false
    if not ni.player.isstunned()
        and ni.spell.available(id, stutter)
        and IsUsableSpell(GetSpellInfo(id)) then
        result = true
    end
    return result
end;
-- Функция для проверки доступности заклинания для рендж спеков --
ri.spellusablesilence = function(id, stutter)
    if tonumber(id) == nil then
        id = ni.spell.id(id)
    end
    local result = false
    if not ni.player.isstunned()
        and not ni.player.issilenced()
        and ni.spell.available(id, stutter)
        and IsUsableSpell(GetSpellInfo(id)) then
        result = true
    end
    return result
end;
-- Проверка на знание заклинания --
ri.spellisknown = function(id)
    if tonumber(id) == nil then
        id = ni.spell.id(id)
    end
    local result = false
    if id ~= nil
        and id ~= 0
        and IsSpellKnown(id) then
        local name = GetSpellInfo(id)
        if name then
            result = true
        end
    end
    return result
end;
-- Проверка на инстанс --
ri.instance = function()
    if IsInInstance()
        and select(2, GetInstanceInfo()) == "party" then
        return true
    end
    return false
end;
-- Проверка на рейд --
ri.inraid = function()
    if IsInInstance()
        and select(2, GetInstanceInfo()) == "raid" then
        return true
    end
    return false
end;
-- проверка на арену --
ri.arena = function()
    local isArena, isRegistered = IsActiveBattlefieldArena();
    if IsActiveBattlefieldArena(isArena) then
        return true;
    end
    return false;
end;
---проверка на бг или ОЛО --
ri.battleground = function()
    local position = UnitInBattleground("player")
    if UnitInBattleground("player")
        or GetZoneText("Озеро Ледяных Оков") then
        return true;
    end;
    return false
end;
--- Получение ренжи без проверки ресурсов, используется там где не подходит ni.spell.valid
ri.getrange = function(t, id)
    if tonumber(id) == nil then
        id = ni.spell.id(id)
    end
    if ni.player.isfacing(t)
        and ni.player.los(t)
        and IsSpellInRange(GetSpellInfo(id), t) == 1 then
        return true;
    end
    return false;
end;
ri.defensivecat = function(t) -- проверка на то прерываеться ли каст
    local _, _, _, _, _, _, _, _, notInterruptible = UnitCastingInfo(t)
        if UnitCastingInfo(t) and notInterruptible ~= true then
        return 0;
    end;
    ri.doublecast = function(t, id) -- проверка на дабл каст
    local function Times()
        if ni.spell.casttime(id) < 1 then
            return (ni.spell.casttime(id) + 1.5)
        elseif ni.spell.casttime(id) > 1 then
            return (ni.spell.casttime(id) + 1)
        elseif ni.spell.isinstant(id) then
            return select(2, GetSpellCooldown(61304))
        end
    end
    if lastSpell == id
        and lastGuid == UnitGUID(t)
        and GetTime() - lastTime < Times() then
        return true;
    else
        return false;
    end
end;
ri.customspellcast = function(t, id) -- Работает в связке с функцией выше
    if not ni.spell.gcd() then
        ni.spell.cast(id, t)
        lastSpell = id
        lastGuid = UnitGUID(t)
        lastTime = GetTime()
        return true;
    end
    return false;
end
return itis
end;
-- Проверка на сирус --
ri.sirusserver = function()
    local realm_names = {"Scourge", "Legacy", "Sirus", "Algalon", "ОБТ"};
    local realm = GetRealmName();
    local result = false;
    for i = 1, #realm_names do
        local name = realm_names[i];
        if strfind(realm, name) then
            result = true;
        end
    end
    return result
end;
-- Проверьте Начало боя с помощью TTD --
ri.CDsaverTTD = function(unit, valueTime, valueTTD, hp)
	valueTime = valueTime or 0
	valueTTD = valueTTD or 0
	hp = hp or 0
	if ni.vars.combat.time ~= 0 
	 and GetTime() - ni.vars.combat.time > valueTime 
	 and ni.unit.ttd(unit) > valueTTD
	 and ni.unit.hp(unit) >= hp then
		return true;
	end
		return false;
end
ri.CombatStart = function(value)
	if ni.vars.combat.time ~= 0
	 and GetTime() - ni.vars.combat.time > value then
		return true;
	end
		return false;
end
ri.CDorBoss = function(unit, valueTime, valueTTD, hp, enabled)
	if ni.vars.combat.cd then
		return true;
	end
	local isboss = false;
	if enabled then
	isboss = ni.unit.isboss(unit);
	 if not isboss then
		return false;
		end
	end
	if ri.CDsaverTTD(unit, valueTime, valueTTD, hp) then
	 if enabled then
	  if isboss then
		return true;
      end
	return true;
		end
	end
		return false;
end;
-- универсальная пауза -- 
ri.UniPause = function()
		if IsMounted()
	 or UnitInVehicle("player")
	 or UnitIsDeadOrGhost("target") 
	 or UnitIsDeadOrGhost("player")
	 or UnitChannelInfo("player") ~= nil
	 or UnitCastingInfo("player") ~= nil
	 or ni.vars.combat.casting == true
	 or ni.player.islooting()
	 or ri.PlayerBuffs("player")
	 or (not UnitAffectingCombat("player")
	 and ni.vars.followEnabled) then
		 return true;
	end
		 return false;
end
-- Переменные для универсальной паузы --
ri.PlayerBuffs = function(t)
	for _, v in ipairs(pbuff) do
	 if ni.unit.buff(t, v) then 
		return true;
		end
	end
		return false;
end
-- Управление питомцами(ХАНТ ЛОК ФРОСТМАГ АДК) -- 
ri.petFollow = function()
	local pet = ni.objects["pet"]
	if not pet:exists() then
		return
	end
	local oldPetDistance = petDistance;
	petDistance = pet:distance("player")
	local distanceThreshold = 1
	if not oldPetDistance 
	 or petDistance - oldPetDistance > distanceThreshold then
		ni.player.runtext("/petfollow");
	end
end
ri.petAttack = function()
	local pet = ni.objects["pet"]
	if not pet:exists() then
		return
	end
	if not pet:combat() then
		ni.player.runtext("/petattack")
		petDistance = nil
	end

	if pet:combat() then
		ni.player.runtext("/petattack")
		petDistance = nil
	end
end
-- Переменные для боевой паузы --
ri.targetDebuffs = function(t)
	for _, v in ipairs(targetdebuff) do
	 if ni.unit.debuff(t, v) then 
		return true;
		end
	end
		return false;
end
ri.casterStop = function(t)
	for _, v in ipairs(cbuff) do
	 if (ni.unit.buff(t, v) 
	 or ri.targetDebuffs(t)) then 
		return true;
		end
	end
		return false;
end
ri.meleeStop = function(t)
	for _, v in ipairs(mbuff) do
	 if (ni.unit.buff(t, v) 
	 or ri.targetDebuffs(t)) then 
		return true;
		end
	end
		return false;
end
ri.tankStop = function(t)
	for _, v in ipairs(tbuff) do
	 if (ni.unit.buff(t, v) 
	  or ri.targetDebuffs(t)) then 
		return true;
		end
	end
		return false;
end
ri.PlayerDebuffs = function(t)
	for _, v in ipairs(pdebuff) do
	 if (ni.unit.debuff(t, v) 
	  or ni.player.debuffstacks(69766) == 5
	  or (ni.unit.debuff("player", 305131, "EXACT") 
	  and ni.unit.debuffremaining("player", 305131, "EXACT") <= 3)) then 
		return true;
		end
	end
		return false;
end
-- Воля отрекшихся --
ri.forsaken = function(t)
	for _, v in ipairs(forsdebuff) do
	 if ni.unit.debuff(t, v) then 
		return true;
		end
	end
		return false;
end
--Проверrf инста или рейда --
ri.youInInstance = function()
	if IsInInstance()
	 and select(2, GetInstanceInfo()) == "party" then
		return true;
	end
		 return false;
end
ri.youInRaid = function(t)
	if IsInInstance()
	 and select(2, GetInstanceInfo()) == "raid" then
		return true;
	end
		return false;
end
--------------------- надо
-- Specific Class stuff --
local classlower = string.lower(class);
if classlower == "deathknight" then
	classlower = "dk";
end
ri[classlower] = { };
if classlower == "dk" then
	--- GUI Stuff
	ri[classlower].bloodIcon = function()
		return select(3, GetSpellInfo(48266))
	end;
	ri[classlower].frostIcon = function()
		return select(3, GetSpellInfo(48263))
	end;
	ri[classlower].unholyIcon = function()
		return select(3, GetSpellInfo(48265))
	end;
	ri[classlower].deathIcon = function()
		return select(3, GetSpellInfo(49924))
	end;
	ri[classlower].interIcon = function()
		return select(3, GetSpellInfo(47528))
	end;
	ri[classlower].iceboundIcon = function()
		return select(3, GetSpellInfo(48792))
	end;
	ri[classlower].raiseIcon = function()
		return select(3, GetSpellInfo(46584))
	end;
	ri[classlower].nothIcon = function()
		return select(3, GetSpellInfo(53910))
	end;
	ri[classlower].runeIcon = function()
		return select(3, GetSpellInfo(48982))
	end;
	ri[classlower].vampIcon = function()
		return select(3, GetSpellInfo(55233))
	end;
	ri[classlower].markIcon = function()
		return select(3, GetSpellInfo(49005))
	end;
	ri[classlower].bboilIcon = function()
		return select(3, GetSpellInfo(49941))
	end;
	ri[classlower].gripIcon = function()
		return select(3, GetSpellInfo(49576))
	end;
	ri[classlower].commandIcon = function()
		return select(3, GetSpellInfo(56222))
	end;
	ri[classlower].froststIcon = function()
		return select(3, GetSpellInfo(55268))
	end;
	ri[classlower].unarmorIcon = function()
		return select(3, GetSpellInfo(51271))
	end;
	-----------------------------------
	ri[classlower].LastIcy = 0;
	ri[classlower].icy = function()
		return ni.unit.debuffremaining("target", 55095, "player")
	end;
	ri[classlower].plague = function() 
		return ni.unit.debuffremaining("target", 55078, "player")
	end;
	ri[classlower].InRange = function()
	 if IsSpellInRange(GetSpellInfo(49930), "target") == 1 then
			return true;
		end
	end
		-- Sirus Custom T5 --
	ri[classlower].itemsetT5DPS = { 
	81241, 80867, 80861, 80927, 82812, 103491, 103492, 103493, 103494, 103495 
	};
	ri[classlower].itemsetT4tank = { 
	63462, 55792, 56291, 56323, 56435, 100494, 100488, 100491, 100492, 100493 
	}
	ri[classlower].itemsetT4DPS = { 
	55848, 55207, 55254, 55784, 56104, 100489, 100485, 100486, 100487, 100490
	}
elseif classlower == "druid" then
	--- GUI Stuff
	ri[classlower].formIcon = function()
		return select(3, GetSpellInfo(768))
	end;
	ri[classlower].intervateIcon = function()
		return select(3, GetSpellInfo(29166))
	end;
	ri[classlower].barsIcon = function()
		return select(3, GetSpellInfo(22812))
	end;
	ri[classlower].survIcon = function()
		return select(3, GetSpellInfo(61336))
	end;
	ri[classlower].growlIcon = function()
		return select(3, GetSpellInfo(6795))
	end;
	ri[classlower].swiftIcon = function()
		return select(3, GetSpellInfo(18562))
	end;
	ri[classlower].natureIcon = function()
		return select(3, GetSpellInfo(17116))
	end;
	ri[classlower].tranqIcon = function()
		return select(3, GetSpellInfo(48447))
	end;
	ri[classlower].curseIcon = function()
		return select(3, GetSpellInfo(2782))
	end;
	ri[classlower].poisonIcon = function()
		return select(3, GetSpellInfo(2893))
	end;
	ri[classlower].nouIcon = function()
		return select(3, GetSpellInfo(50464))
	end;
	ri[classlower].touchIcon = function()
		return select(3, GetSpellInfo(48378))
	end;
	ri[classlower].rejuIcon = function()
		return select(3, GetSpellInfo(48441))
	end;
	ri[classlower].regroIcon = function()
		return select(3, GetSpellInfo(48443))
	end;
	ri[classlower].lifebloomIcon = function()
		return select(3, GetSpellInfo(48451))
	end;
	-----------------------------------	
	ri[classlower].LastShout = 0;
	ri[classlower].LastRegrowth = 0;
	ri[classlower].LastNourish = 0;	
	ri[classlower].mFaerieFire = function() 
		return ni.unit.debuff("target", 770) 
	end;
	ri[classlower].fFaerieFire = function() 
		return ni.unit.debuff("target", 16857) 
	end
	ri[classlower].iSwarm = function()
		return select(7, ni.unit.debuff("target", 48468, "player")) 
	end
	ri[classlower].mFire = function() 
		return select(7, ni.unit.debuff("target", 48463, "player"))
	end
	ri[classlower].lunar = function() 
		return select(7, ni.unit.buff("player", 48517)) 
	end
	ri[classlower].solar = function() 
		return select(7, ni.unit.buff("player", 48518)) 
	end
	ri[classlower].berserk = function() 
		return ni.unit.buff("player", 50334)
	end
	ri[classlower].lacerate = function() 
		return ni.unit.debuffremaining("target", 48568, "player")
	end
	ri[classlower].rip = function() 
		return ni.unit.debuffremaining("target", 49800, "player")
	end
	ri[classlower].rake = function() 
		return ni.unit.debuffremaining("target", 48574, "player")
	end
	ri[classlower].tiger = function() 
		return ni.unit.buff("player", 50213) 
	end
	ri[classlower].savage = function() 
		return ni.unit.buffremaining("player", 52610) 
	end
	-- Bleed  Buff --
	ri[classlower].BleedBuff = function(t)
		for _, v in ipairs(bleedUp) do
		 if ni.unit.debuff(t, v) then 
		     return true;
			end
		end
		     return false;
	end
	ri[classlower].DruidStuff = function(t)
	for _, v in ipairs(flyform) do
		if ni.unit.buff(t, v) then 
		     return true;
		end
	end
		     return false;
	end
	ri[classlower].InBearRange = function()
	 if IsSpellInRange(GetSpellInfo(48568), "target") == 1 then
			return true;
		end
	end
	ri[classlower].InCatRange = function()
	 if IsSpellInRange(GetSpellInfo(49800), "target") == 1 then
			return true;
		end
	end
elseif classlower == "hunter" then
	--- GUI Stuff
	ri[classlower].dragonIcon = function()
		return select(3, GetSpellInfo(61847))
	end;
	ri[classlower].viperIcon = function()
		return select(3, GetSpellInfo(34074))
	end;
	ri[classlower].mendIcon = function()
		return select(3, GetSpellInfo(48990))
	end;
	ri[classlower].interIcon = function()
		return select(3, GetSpellInfo(34490))
	end;
	ri[classlower].feignIcon = function()
		return select(3, GetSpellInfo(5384))
	end;
	ri[classlower].deterIcon = function()
		return select(3, GetSpellInfo(19263))
	end;
	ri[classlower].scareIcon = function()
		return select(3, GetSpellInfo(14327))
	end;
	ri[classlower].killIcon = function()
		return select(3, GetSpellInfo(61006))
	end;
	-----------------------------------	
	ri[classlower].LastMD = 0;
	ri[classlower].LastScat = 0;
	ri[classlower].LastTrack = 0;
	ri[classlower].LastScare = 0;
	ri[classlower].serpstring = function() 
		return ni.unit.debuffremaining("target", 49001, "player")
	end
	ri[classlower].viperstring = function() 
		return ni.unit.debuffremaining("target", 3034, "player")
	end
	ri[classlower].scorpstring = function() 
		return ni.unit.debuffremaining("target", 3043, "player")
	end
	ri[classlower].exploshot = function() 
		return ni.unit.debuff("target", 60053, "player")
	end
	ri[classlower].setTracking = function() 
	local creaturetype = ni.unit.creaturetype("target")
	local spellid = creaturetypes[creaturetype]
    if spellid ~= nil 
	 and UnitAffectingCombat("player") 
	 and ni.unit.exists("target") 
	 and ni.spell.isinstant(spellid) 
	 and ni.spell.available(spellid) 
	 and GetTime() - ri.hunter.LastTrack > 3 then
			ri.hunter.LastTrack = GetTime()
			ni.spell.cast(spellid)
		end
	end
	ri[classlower].InRange = function()
	 if IsSpellInRange(GetSpellInfo(49052), "target") == 1 then
			return true;
		end
	end
elseif classlower == "mage" then
	--- GUI Stuff	
	ri[classlower].evoIcon = function()
		return select(3, GetSpellInfo(12051))
	end;
	ri[classlower].gemIcon = function()
		return select(3, GetSpellInfo(42985))
	end;
	ri[classlower].iceIcon = function()
		return select(3, GetSpellInfo(45438))
	end;
	ri[classlower].interIcon = function()
		return select(3, GetSpellInfo(2139))
	end;
	ri[classlower].coneIcon = function()
		return select(3, GetSpellInfo(42931))
	end;
	ri[classlower].breathIcon = function()
		return select(3, GetSpellInfo(42950))
	end;
	ri[classlower].stealIcon = function()
		return select(3, GetSpellInfo(30449))
	end;
	ri[classlower].fwardIcon = function()
		return select(3, GetSpellInfo(43010))
	end;
	ri[classlower].frwardIcon = function()
		return select(3, GetSpellInfo(43012))
	end;
	ri[classlower].curseIcon = function()
		return select(3, GetSpellInfo(475))
	end;
	ri[classlower].livingIcon = function()
		return select(3, GetSpellInfo(55360))
	end;
	-----------------------------------		
	ri[classlower].LastScorch = 0;
	ri[classlower].LBomb = function() 
		return ni.unit.debuff("target", 55360, "player") 
	end
	ri[classlower].fnova = function() 
		return ni.unit.debuff("target", 42917, "player") 
	end
	ri[classlower].fbite = function() 
		return ni.unit.debuff("target", 12494, "player") 
	end
	ri[classlower].freeze = function() 
		return ni.unit.debuff("target", 33395, "player") 
	end
	ri[classlower].FoF = function() 
		return ni.player.buff(44545) 
	end
	-- Sirus Custom T4 --
	ri[classlower].itemsetT4 = {
		29076, 29077, 29078, 29079, 29080, 100460, 100461, 100462, 100463, 100464 
	};	
	-- Mages Wards --
	ri[classlower].FireWard = function()
		for _, v in ipairs(firedots) do
		 if ni.player.debuff(v) then 
		     return true;
			end
		end
		     return false;
	end	
	ri[classlower].FrostWard = function()
		for _, v in ipairs(frostdots) do
		 if ni.player.debuff(v) then 
		     return true;
			end
		end
		     return false;
	end
	ri[classlower].isStealable = function(t)
	for i, v in ipairs(stealable) do
		local _,_,_,_,_,_,_,_,StealableSpell = ni.unit.buff(t, v)
		 if StealableSpell then
		     return true;
		end
	end
		     return false;
	end
elseif classlower == "paladin" then
	--- GUI Stuff	
	ri[classlower].pleaIcon = function()
		return select(3, GetSpellInfo(54428))
	end;
	ri[classlower].becIcon = function()
		return select(3, GetSpellInfo(53563))
	end;
	ri[classlower].sacredIcon = function()
		return select(3, GetSpellInfo(53601))
	end;
	ri[classlower].flashIcon = function()
		return select(3, GetSpellInfo(48785))
	end;
	ri[classlower].layIcon = function()
		return select(3, GetSpellInfo(48788))
	end;
	ri[classlower].divineShIcon = function()
		return select(3, GetSpellInfo(642))
	end;
	ri[classlower].divinePrIcon = function()
		return select(3, GetSpellInfo(498))
	end;
	ri[classlower].handProIcon = function()
		return select(3, GetSpellInfo(10278))
	end;
	ri[classlower].handSalIcon = function()
		return select(3, GetSpellInfo(1038))
	end;
	ri[classlower].handSacrIcon = function()
		return select(3, GetSpellInfo(6940))
	end;
	ri[classlower].hamWraIcon = function()
		return select(3, GetSpellInfo(48806))
	end;
	ri[classlower].consIcon = function()
		return select(3, GetSpellInfo(48819))
	end;
	ri[classlower].hwrathIcon = function()
		return select(3, GetSpellInfo(48817))
	end;
	ri[classlower].turnIcon = function()
		return select(3, GetSpellInfo(10326))
	end;
	ri[classlower].cleanIcon = function()
		return select(3, GetSpellInfo(4987))
	end;
	ri[classlower].handFreeIcon = function()
		return select(3, GetSpellInfo(1044))
	end;
	ri[classlower].illumIcon = function()
		return select(3, GetSpellInfo(31842))
	end;
	ri[classlower].aveWrathIcon = function()
		return select(3, GetSpellInfo(31884))
	end;
	ri[classlower].exorIcon = function()
		return select(3, GetSpellInfo(48801))
	end;
	ri[classlower].masteryIcon = function()
		return select(3, GetSpellInfo(31821))
	end;
	ri[classlower].hsockIcon = function()
		return select(3, GetSpellInfo(48825))
	end;
	ri[classlower].lightIcon = function()
		return select(3, GetSpellInfo(48782))
	end;
	ri[classlower].BoKIcon = function()
		return select(3, GetSpellInfo(25898))
	end;
	ri[classlower].divSacrIcon = function()
		return select(3, GetSpellInfo(64205))
	end;
	ri[classlower].HandRecIcon = function()
		return select(3, GetSpellInfo(62124))
	end;
	ri[classlower].RigDefIcon = function()
		return select(3, GetSpellInfo(31789))
	end;
	ri[classlower].SoCRIcon = function()
		return select(3, GetSpellInfo(53736))
	end;
	ri[classlower].SoCIcon = function()
		return select(3, GetSpellInfo(20375))
	end;
	ri[classlower].SoRIcon = function()
		return select(3, GetSpellInfo(21084))
	end;
	ri[classlower].SoLIcon = function()
		return select(3, GetSpellInfo(20165))
	end;
	ri[classlower].SoWIcon = function()
		return select(3, GetSpellInfo(20166))
	end;
	ri[classlower].SoJIcon = function()
		return select(3, GetSpellInfo(20164))
	end;
	-----------------------------------		
	ri[classlower].LastSeal = 0;
	ri[classlower].LastTrack = 0;
	ri[classlower].LastTurn = 0;
	ri[classlower].LastHoly = 0;
	ri[classlower].LastStorm = 0;
	ri[classlower].LastAven = 0;	
	ri[classlower].forb = function() 
		return ni.player.debuff(25771) 
	end
	ri[classlower].aow = function() 
		return ni.player.buff(59578) 
	end
	ri[classlower].itemsetT10 = { 
		51270, 51271, 51272, 51273, 51274, 51165, 51166, 51167, 51168, 51169, 50865, 50866, 50867, 50868, 50869
	};
	-- Sirus Custom T5 (Healer)--
	ri[classlower].itemsetT5Heal = { 
		30134, 30135, 30136, 30137, 30138, 103426, 103427, 103428, 103429, 103430
	};
	ri[classlower].itemsetT5Retri = { 
		30129, 30130, 30131, 30132, 30133, 103423, 103425, 103421, 103422, 103424
	};	
	ri[classlower].HandActive = function(t)
		if ni.unit.buff(t, 1044)
		 or ni.unit.buff(t, 1022)
		 or ni.unit.buff(t, 6940)
		 or ni.unit.buff(t, 1038) then
		     return true;
		end
		     return false;
	end
	ri[classlower].FreedomUse = function(t)
	for _, v in ipairs(freedomdebuff) do
		if ni.unit.debuff(t, v) then 
		     return true;
		end
	end
		     return false;
	end
	ri[classlower].ProtoRange = function()
	 if IsSpellInRange(GetSpellInfo(53595), "target") == 1 then
			return true;
		end
	end
	ri[classlower].RetriRange = function()
	 if IsSpellInRange(GetSpellInfo(35395), "target") == 1 then
			return true;
		end
	end
elseif classlower == "priest" then
	--- GUI Stuff	
	ri[classlower].shadowFIcon = function()
		return select(3, GetSpellInfo(15473))
	end;
	ri[classlower].fearIcon = function()
		return select(3, GetSpellInfo(6346))
	end;
	ri[classlower].interIcon = function()
		return select(3, GetSpellInfo(15487))
	end;
	ri[classlower].disperIcon = function()
		return select(3, GetSpellInfo(47585))
	end;
	ri[classlower].shackIcon = function()
		return select(3, GetSpellInfo(10955))
	end;
	ri[classlower].dispIcon = function()
		return select(3, GetSpellInfo(988))
	end;
	ri[classlower].abolIcon = function()
		return select(3, GetSpellInfo(552))
	end;
	ri[classlower].despPlaIcon = function()
		return select(3, GetSpellInfo(48173))
	end;
	ri[classlower].painIcon = function()
		return select(3, GetSpellInfo(33206))
	end;
	ri[classlower].powerIcon = function()
		return select(3, GetSpellInfo(10060))
	end;
	ri[classlower].innerIcon = function()
		return select(3, GetSpellInfo(14751))
	end;
	ri[classlower].hymnIcon = function()
		return select(3, GetSpellInfo(64843))
	end;
	ri[classlower].pwsIcon = function()
		return select(3, GetSpellInfo(48066))
	end;
	ri[classlower].renewIcon = function()
		return select(3, GetSpellInfo(48068))
	end;
	ri[classlower].penIcon = function()
		return select(3, GetSpellInfo(53007))
	end;
	ri[classlower].flashIcon = function()
		return select(3, GetSpellInfo(48071))
	end;
	ri[classlower].bindIcon = function()
		return select(3, GetSpellInfo(48120))
	end;
	ri[classlower].prayIcon = function()
		return select(3, GetSpellInfo(48072))
	end;
	ri[classlower].guardIcon = function()
		return select(3, GetSpellInfo(47788))
	end;
	ri[classlower].mendIcon = function()
		return select(3, GetSpellInfo(48113))
	end;
	ri[classlower].circIcon = function()
		return select(3, GetSpellInfo(48089))
	end;
	ri[classlower].greatIcon = function()
		return select(3, GetSpellInfo(48063))
	end;
	ri[classlower].painIcon = function()
		return select(3, GetSpellInfo(48125))
	end;
	-----------------------------------		
	ri[classlower].LastVamp = 0;
	ri[classlower].LastSWP = 0;
	ri[classlower].LastPlague = 0;
	ri[classlower].LastShackle = 0;
	ri[classlower].LastGreater = 0;	
	ri[classlower].vamp = function()
		return ni.unit.debuff("target", 48160, "player") 
	end
	ri[classlower].SWP = function() 
		return ni.unit.debuff("target", 48125, "player") 
	end
	ri[classlower].dplague = function() 
		return ni.unit.debuff("target", 48300, "player")
	end
	-- Sirus Custom T4 --
	ri[classlower].itemsetT4DPS = {
		29056, 29057, 29058, 29059, 29060, 100440, 100441, 100442, 100443, 100444 
	};		
		-- Crimson Acolyte's Regalia --
	ri[classlower].itemsetT10 = {
		51255, 51256, 51257, 51258, 51259, 51180, 51181, 51182, 51183, 51184, 50391, 50392, 50393, 50394, 50396
	};
elseif classlower == "rogue" then
	--- GUI Stuff	
	ri[classlower].interIcon = function()
		return select(3, GetSpellInfo(1766))
	end;
	-----------------------------------	
	ri[classlower].SnD = function() 
		return select(7, ni.unit.buff("player", 6774))
	end
	ri[classlower].Hunger = function() 
		return ni.unit.buffremaining("player", 63848)
	end
	ri[classlower].envenom = function() 
		return ni.unit.buff("player", 57993) 
	end
	ri[classlower].Rup = function() 
		return ni.unit.debuffremaining("target", 48672, "player") 
	end
	ri[classlower].OGar = function() 
		return ni.unit.debuff("target", 48676) 
	end
	ri[classlower].InRange = function()
	 if IsSpellInRange(GetSpellInfo(48638), "target") == 1 then
			return true;
		end
	end
elseif classlower == "shaman" then
	--- GUI Stuff
	ri[classlower].lightIcon = function()
		return select(3, GetSpellInfo(49281))
	end;
	ri[classlower].waterIcon = function()
		return select(3, GetSpellInfo(57960))
	end;
	ri[classlower].earthIcon = function()
		return select(3, GetSpellInfo(49284))
	end;
	ri[classlower].interIcon = function()
		return select(3, GetSpellInfo(57994))
	end;
	ri[classlower].thundIcon = function()
		return select(3, GetSpellInfo(59159))
	end;
	ri[classlower].hwaveIcon = function()
		return select(3, GetSpellInfo(49273))
	end;
	ri[classlower].lhwaveIcon = function()
		return select(3, GetSpellInfo(49276))
	end;
	ri[classlower].chainIcon = function()
		return select(3, GetSpellInfo(70809))
	end;
	ri[classlower].purgeIcon = function()
		return select(3, GetSpellInfo(8012))
	end;
	ri[classlower].totemIcon = function()
		return select(3, GetSpellInfo(66842))
	end;
	ri[classlower].cureIcon = function()
		return select(3, GetSpellInfo(526))
	end;
	ri[classlower].cleanIcon = function()
		return select(3, GetSpellInfo(51886))
	end;
	ri[classlower].rageIcon = function()
		return select(3, GetSpellInfo(30823))
	end;
	ri[classlower].novaIcon = function()
		return select(3, GetSpellInfo(61657))
	end;
	ri[classlower].riptIcon = function()
		return select(3, GetSpellInfo(61301))
	end;
	ri[classlower].flshockIcon = function()
		return select(3, GetSpellInfo(49233))
	end;
	ri[classlower].switIcon = function()
		return select(3, GetSpellInfo(16188))
	end;
	ri[classlower].tidalIcon = function()
		return select(3, GetSpellInfo(55198))
	end;
	-----------------------------------		
	ri[classlower].LastPurge = 0;
	ri[classlower].LastWave = 0;	
	ri[classlower].flameshock = function() 
		return ni.unit.debuff("target", 49233, "player") 
	end
	-- Shaman Enchancment T10 --
	ri[classlower].itemsetT10Enc = {
		50830, 50831, 50832, 50833, 50834, 51195, 51196, 51197, 51198, 51199, 51240, 51241, 51242, 51243, 51244
	};
	ri[classlower].canPurge = function(t)
	for i, v in ipairs(purgebuff) do
		local name, icon, _, _, _, _, _, PurgebleSpell = ni.unit.buff(t, v)
		 if PurgebleSpell then
		     return true;
		end
	end
		     return false;
	end
	ri[classlower].InRange = function()
	 if IsSpellInRange(GetSpellInfo(17364), "target") == 1 then
			return true;
		end
	end
elseif classlower == "warlock" then
	--- GUI Stuff
	ri[classlower].impIcon = function()
		return select(3, GetSpellInfo(688))
	end;
	ri[classlower].voidIcon = function()
		return select(3, GetSpellInfo(697))
	end;
	ri[classlower].sucIcon = function()
		return select(3, GetSpellInfo(712))
	end;
	ri[classlower].felhunIcon = function()
		return select(3, GetSpellInfo(691))
	end;
	ri[classlower].felguardIcon = function()
		return select(3, GetSpellInfo(30146))
	end;	
	ri[classlower].felIcon = function()
		return select(3, GetSpellInfo(47893))
	end;
	ri[classlower].demIcon = function()
		return select(3, GetSpellInfo(47889))
	end;
	ri[classlower].ssIcon = function()
		return select(3, GetSpellInfo(47884))
	end;
	ri[classlower].interIcon = function()
		return select(3, GetSpellInfo(19647))
	end;
	ri[classlower].stoneIcon = function()
		return select(3, GetSpellInfo(71905))
	end;
	ri[classlower].coilIcon = function()
		return select(3, GetSpellInfo(47860))
	end;
	ri[classlower].sflameIcon = function()
		return select(3, GetSpellInfo(61290))
	end;
	ri[classlower].banIcon = function()
		return select(3, GetSpellInfo(18647))
	end;
	ri[classlower].sfuryIcon = function()
		return select(3, GetSpellInfo(47847))
	end;
	ri[classlower].sburnIcon = function()
		return select(3, GetSpellInfo(47827))
	end;
	ri[classlower].chargeIcon = function()
		return select(3, GetSpellInfo(54785))
	end;
	ri[classlower].cleaveIcon = function()
		return select(3, GetSpellInfo(50581))
	end;
	ri[classlower].immolAuraIcon = function()
		return select(3, GetSpellInfo(50589))
	end;
	ri[classlower].seedIcon = function()
		return select(3, GetSpellInfo(47836))
	end;
	ri[classlower].rainIcon = function()
		return select(3, GetSpellInfo(47820))
	end;
	-----------------------------------		
	ri[classlower].LastSummon = 0;
	ri[classlower].LastCorrupt = 0;
	ri[classlower].LastCurse = 0;
	ri[classlower].LastShadowbolt = 0;
	ri[classlower].Lastimmolate = 0;
	ri[classlower].LastUA = 0;
	ri[classlower].LastHaunt = 0;
	ri[classlower].LastSeed = 0;
	ri[classlower].LastBanish = 0;	
	ri[classlower].lastAgonyT5 = 0;		
	ri[classlower].CotE = function()
		return ni.unit.debuff("target", 47865)
	end
	ri[classlower].elem = function()
		return ni.unit.debuff("target", 47865, "player")
	end
	ri[classlower].doom = function()
		return ni.unit.debuff("target", 47867, "player")
	end
	ri[classlower].agony = function()
		return ni.unit.debuff("target", 47864, "player")
	end
	ri[classlower].corruption = function()
		return ni.unit.debuff("target", 47813, "player")
	end
	ri[classlower].seed = function()
		return ni.unit.debuff("target", 47836, "player")
	end
	ri[classlower].haunt = function()
		return ni.unit.debuff("target", 59164, "player")
	end
	ri[classlower].ua = function()
		return ni.unit.debuff("target", 47843, "player")
	end
	ri[classlower].immolate = function()
		return ni.unit.debuff("target", 47811, "player")
	end
	ri[classlower].eplag = function() 
		return ni.unit.debuff("target", 51735) 
	end
	ri[classlower].earmoon = function()
		return ni.unit.debuff("target", 60433) 
	end
	-- Sirus Custom T4 --
	ri[classlower].itemsetT4 = {
		28963, 28964, 28966, 28967, 28968, 100400, 100401, 100402, 100403, 100404
	};
	ri[classlower].itemsetT5 = {
		30211, 30212, 30213, 30214, 30215, 103472, 103475, 103474, 103471, 103473
	};
	-- Shadow Ward --
	ri[classlower].ShadowWard = function()
		for _, v in ipairs(shadowdots) do
		 if ni.player.debuff(v) then 
		     return true;
			end
		end
		     return false;
	end
elseif classlower == "warrior" then
	--- GUI Stuff
	ri[classlower].batIcon = function()
		return select(3, GetSpellInfo(47436))
	end;	
	ri[classlower].comIcon = function()
		return select(3, GetSpellInfo(47440))
	end;
	ri[classlower].enraIcon = function()
		return select(3, GetSpellInfo(55694))
	end;
	ri[classlower].bersIcon = function()
		return select(3, GetSpellInfo(18499))
	end;
	ri[classlower].shatIcon = function()
		return select(3, GetSpellInfo(64382))
	end;
	ri[classlower].sweepIcon = function()
		return select(3, GetSpellInfo(12328))
	end;
	ri[classlower].thundIcon = function()
		return select(3, GetSpellInfo(47502))
	end;
	ri[classlower].hamIcon = function()
		return select(3, GetSpellInfo(1715))
	end;
	ri[classlower].heroIcon = function()
		return select(3, GetSpellInfo(47450))
	end;
	ri[classlower].cleaveIcon = function()
		return select(3, GetSpellInfo(47520))
	end;
	ri[classlower].inter1Icon = function()
		return select(3, GetSpellInfo(6552))
	end;
	ri[classlower].inter2Icon = function()
		return select(3, GetSpellInfo(6552))
	end;
	ri[classlower].sundIcon = function()
		return select(3, GetSpellInfo(7386))
	end;
	ri[classlower].rendIcon = function()
		return select(3, GetSpellInfo(47465))
	end;
	ri[classlower].taunIcon = function()
		return select(3, GetSpellInfo(355))
	end;
	ri[classlower].mokingIcon = function()
		return select(3, GetSpellInfo(694))
	end;
	ri[classlower].wallIcon = function()
		return select(3, GetSpellInfo(871))
	end;
	ri[classlower].lastIcon = function()
		return select(3, GetSpellInfo(12975))
	end;
	ri[classlower].intervIcon = function()
		return select(3, GetSpellInfo(3411))
	end;
	ri[classlower].herbIcon = function()
		return select(3, GetSpellInfo(57755))
	end;
		ri[classlower].deafeningIcon = function()
		return select(3, GetSpellInfo(12809))
	end;
		ri[classlower].waveIcon = function()
		return select(3, GetSpellInfo(46968))
	end;
		ri[classlower].demorIcon = function()
		return select(3, GetSpellInfo(47437))
	end;
		ri[classlower].retaIcon = function()
		return select(3, GetSpellInfo(20230))
	end;
	-----------------------------------
	ri[classlower].LastShout = 0;
	ri[classlower].rend = function() 
		return ni.unit.debuffremaining("target", 47465, "player")
	end
	ri[classlower].hams = function() 
		return ni.unit.debuffremaining("target", 1715, "player")
	end
	ri[classlower].Berserk = function()
	for _, v in ipairs(bersrage) do
            if ni.player.debuff(v) then 
		     return true;
		end
	end
		     return false;
	end
	ri[classlower].InRange = function()
	 if IsSpellInRange(GetSpellInfo(47465), "target") == 1 then
			return true;
		end
	end
end

	--- GUI Stuff
ri.debugIcon = function()
	return select(3, GetSpellInfo(2382))
end
ri.stoneIcon = function()
	return select(3, GetSpellInfo(47878))
end
ri.hpotionIcon = function()
	return select(3, GetSpellInfo(53760))
end
ri.mpotionIcon = function()
	return select(3, GetSpellInfo(53755))
end
ri.controlIcon = function()
	return select(3, GetSpellInfo(59752))
end
ri.tankIcon = function()
	return select(3, GetSpellInfo(2565))
end
ri.bossIcon = function()
	return select(3, GetSpellInfo(22888))
end
	
	--- Multitool
ri.lookIcon = function()
	return select(3, GetSpellInfo(1002))
end
ri.LootIcon = function()
	return select(3, GetSpellInfo(58856))
end
ri.ProspectingIcon = function()
	return select(3, GetSpellInfo(31252))
end
ri.MillingIcon = function()
	return select(3, GetSpellInfo(51005))
end
ri.SkinningIcon = function()
	return select(3, GetSpellInfo(8613))
end
ri.FishingIcon = function()
	return select(3, GetSpellInfo(7620))
end
ri.LureIcon = function()
	return select(3, GetSpellInfo(51067))
end
-------------------- заебало тоже надо
-- Shared Control Stuff
ri.ControlMember = function(t)
	for _, v in ipairs(control) do
	 if ni.unit.debuff(t, v) then 
		return true;
		end
	end
		return false;
end
ri.UnderControlMember = function(t)
	for _, v in ipairs(undercontrol) do
	 if ni.unit.debuff(t, v) then 
		return true;
		end
	end
		return false;
end
--- Stuff for Healing (Originaly maded by Scott#1180)
local temptable = { };
local customtable = { };

ri.SortByUnits = function(x, y)
    return x.unitsclose > y.unitsclose;
end

ri.SortByHP = function(x, y)
    return x.hp < y.hp
end

ri.GetTableForBestUnit = function(health, distance, unitsclose, buff)
    table.wipe(customtable);
    for i = 1, #ni.members do
        if ni.members[i].hp <= health
         and ni.members[i].range
         and (buff ~= nil 
         and not ni.unit.buff(ni.members[i].unit, buff, "player")) then
            table.wipe(temptable);
            if buff ~= nil then
                temptable = ni.members.inrangewithoutbuff(ni.members[i].unit, distance, buff, "player");
                for k, v in ipairs(temptable) do
                    if v and v.hp > health then
                        tremove(temptable, k);
                    end
                end
            else
                temptable = ni.members.inrangebelow(ni.members[i].unit, distannce, health);                
            end
            if #temptable >= unitsclose then
                tinsert(customtable, { unit = ni.members[i].unit, hp = ni.members[i].hp, unitsclose = #temptable });
            end
        end
    end
    if #customtable > 0 then
        table.sort(customtable, ri.SortByHP)
    end
end

ri.GroupCount = function(gtype, starting, ending, threshold)
  local count = 0;
  for i = starting, ending do
    if UnitExists(gtype..i)
     and ni.unit.hp(gtype..i) < threshold then
      count = count + 1
    end
  end
  return count;
end

ri.GroupTotal = function(grouping, index, threshold)
  local count = 0;
  if index > 0 and index <= 5 then
    count = ri.GroupCount(grouping, 1, 5, threshold)
  elseif index > 5 and index <= 10 then
    count = ri.GroupCount(grouping, 6, 10, threshold)
  elseif index > 10 and index <= 15 then
    count = ri.GroupCount(grouping, 11, 15, threshold)
  elseif index > 15 and index <= 20 then
    count = ri.GroupCount(grouping, 16, 20, threshold)  
  elseif index > 20 and index <= 25 then
    count = ri.GroupCount(grouping, 21, 25, threshold)  
  elseif index > 25 and index <= 30 then
    count = ri.GroupCount(grouping, 26, 30, threshold)  
  elseif index > 30 and index <= 35 then
    count = ri.GroupCount(grouping, 31, 35, threshold)  
  elseif index > 35 and index <= 40 then
    count = ri.GroupCount(grouping, 36, 40, threshold)  
  end
  return count;
end

ri.GetLowPartyMemberCount = function(unit, threshold)
  local count = 0;
  if unit == "player" then
    count = ri.GroupCount("party", 1, 4, threshold)
  else
    local index = string.sub(unit, -1);
    local grouping = string.sub(unit, 0, 4);
    if grouping == "part" then grouping = "party"
    elseif grouping == "raid" then grouping = "raid" end
    if tonumber(index) ~= nil then
      count = ri.GroupTotal(grouping, tonumber(index), threshold)
    else
      for i = 1, #ni.members do
        if ni.members[i].unit == unit then
          index = string.sub(ni.members[i].unit, -1)
          grouping = string.sub(unit, 0, 4);
          if grouping == "part" then grouping = "party"
          elseif grouping == "raid" then grouping = "raid" end
          break
        end
      end
      count = ri.GroupTotal(grouping, tonumber(index), threshold)
    end
  end
  if grouping == "party" or grouping == "player" then
    if ni.player.hp() < threshold then
      count = count + 1
    end
  end
  return count;
end

return ri;