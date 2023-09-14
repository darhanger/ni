local spellCast, spellValid, spellInstant, playerHP, playerPow, playerBuff, playerBuffSta, playerDistance, playerSlot, playerInventory, playerItemR, playerUseIt, playerEnemies, unitDebuff, unitDebuffRem, unitBuffType, unitEnemiesRange, unitDistance, unitBoss, drTrack, unitDebuffs = ni.spell.cast, ni.spell.valid, ni.spell.isinstant, ni.player.hp, ni.player.power, ni.player.buff, ni.player.buffstacks, ni.player.distance, ni.player.slotusable, ni.player.useinventoryitem, ni.player.itemready, ni.player.useitem, ni.player.enemiesinrange, ni.unit.debuff, ni.unit.debuffremaining, ni.unit.bufftype, ni.unit.enemiesinrange, ni.unit.distance, ni.unit.isboss, ni.drtracker.get, ni.unit.debuffs;
local cata = ni.vars.build == 40300 or false;
if cata then
local KnowEngineer = ni.player.getskillinfo(GetSpellInfo(4036)) > 500 or false;
local AntiAFKTime, LastReset = 0, 0;
local enemies = {};
local items = {
	settingsfile = "BloodDKTank_Free_Cata.json",
	{ type = "title", text = ">   Blood DK Tank by |c0000CED1DarhangeR|r   <" },
	{ type = "separator" },
	{ type = "title", text = "|cffffa500Cataclysm Version|r" },
	{ type = "title", text = "|cffC41E3AProfile version 0.0.1|r" },
	{ type = "separator" },
	{ type = "page", number = 1, text = "|cffFFFF00Main Settings" },
	{ type = "separator" },
	{ type = "title", text = "Presence's" },
	{ type = "dropdown", menu = {
		{ selected = true, value = GetSpellInfo(48263), text = ni.spell.icon(48263, 18, 18).." Blood Presence" },
		{ selected = false, value = GetSpellInfo(48266), text = ni.spell.icon(48266, 18, 18).." Frost Presence" },
		{ selected = false, value = GetSpellInfo(48265), text = ni.spell.icon(48265, 18, 18).." Unholy Presence" },
        { selected = false, value = 0, text = "|cffFF0303Manual" },
	}, key = "Presence" },
	{ type = "separator" },	
	{ type = "entry", text = ni.spell.icon(52674, 22, 22).." Auto Buff", tooltip = "Enable Auto Buff Player/ally.", enabled = true, key = "AutoBuff" },	
	{ type = "entry", text = ni.spell.icon(49222, 22, 22).." Bone Shield", tooltip = "Add spell in CR.", enabled = true, key = "boneshield" },
	{ type = "separator" },
	{ type = "title", text = "|cffFFFF00Important Settings" },
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(22888, 22, 22).." Boss Detect", tooltip = "When |cff00D700ENABLED|r - Auto detect Bosses.\nWhen |cffFF0D00DISABLED|r - use CD bottom for Spells.", enabled = true, key = "detect" },	
	{ type = "entry", text = ni.spell.icon(6603, 22, 22).." |cffffa500Auto Target|r", tooltip = "Auto Target and Auto Attack nerest targets.", enabled = true, key = "AutoAttack" },	
	{ type = "entry", text = ni.spell.icon(2382, 22, 22).." |cffffa500Debug Printing|r", tooltip = "Enable for debug if you have problems.\n\nUse the macro |cff00D700/ppause|r to pause CR.\n\nThe value in the seconds field for which the CR will stop.", value = 1.5, min = 1, max = 6, step = 0.1, width = 40, enabled = false, key = "Debug" },
	{ type = "page", number = 2, text = "|cffEE4000Rotation Settings #1|r" },
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(56222, 22, 22).." Dark Command (Auto Agro)", tooltip = "Auto use spell to agro enemies in 30 yard radius.\n\n|cffFF0D00Work always in 5 man dungeon, even if turned OFF.|r", enabled = false, key = "dark" },
	{ type = "entry", text = ni.spell.icon(49576, 22, 22).." Death Grip (Auto Agro)", tooltip = "Auto use spell to agro enemies in 30 yard radius.", enabled = false, key = "grip" },	
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(47528, 22, 22).." Auto Interrupt", tooltip = "Auto check and interrupt all interruptible spells.", enabled = true, key = "autointerrupt" },
	{ type = "entry", text = ni.spell.icon(47568, 22, 22).." Empower Rune Weapon", tooltip = "Enable for quick activate runes when you haven't it.\n\n|cff00D700Work only if Boss Detect enabled\nor activated manual CD mode.|r", enabled = true, key = "emprower" },
	{ type = "separator" },
	{ type = "title", text = "|cffFFFF00AoE Settings|r" },
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(50842, 22, 22).." Pestilence (AoE)", tooltip = "Enable spell spread DOT's.", enabled = true, key = "pestiAoE" },	
	{ type = "entry", text = ni.spell.icon(48721, 22, 22).." Blood Boil", tooltip = "Use spell instead of using "..ni.spell.icon(55050, 14, 14).."[Heart Strike].\n\nWhen |cff00D700ENABLED|r - always use spell when\nACTIVE enemies > value.\n\nWhen |cffFF0D00DISABLED|r - spell will be used \nwith |cff00D700PRESSED CUSTOM BUTTON.|r\nand ignoring enemies value.\n\nThe field indicates the number of ACTIVE enemies >\nthe given value in the field.", enabled = true, value = 3, min = 3, max = 10, step = 1, width = 40, key = "boil" },	
	{ type = "entry", text = ni.spell.icon(43265, 22, 22).." AoE (Auto)", tooltip = "When |cff00D700ENABLED|r automatically changes rotation\ndepending on the enemies count.\n\nWhen |cffFF0D00DISABLED|r to use AoE\npress the AoE mode button.\n\nThe field indicates the number of enemies >=\nthe given value in the field.", enabled = true, value = 2, min = 1, max = 6, step = 1, width = 40, key = "aoe" },
	{ type = "page", number = 3, text = "|cff00C957Defensive Settings|r" },
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(48982, 22, 22).." Rune Tap", tooltip = "Use spell when player |cff00D700HP|r < %.", enabled = true, value = 65, min = 10, max = 100, step = 1, width = 40, key = "runetap" },
	{ type = "entry", text = ni.spell.icon(55233, 22, 22).." Vampiric Blood", tooltip = "Use spell when player |cff00D700HP|r < %.", enabled = true, value = 75, min = 25, max = 100, step = 1, width = 40, key = "vampblood" },
	{ type = "entry", text = ni.spell.icon(48743, 22, 22).." Death Pact", tooltip = "Use spell when player |cff00D700HP|r < %.\n\nAlso use "..ni.spell.icon(46584, 14, 14).."[Raise Dead] for sacrifice pet.", enabled = true, value = 35, min = 20, max = 100, step = 1, width = 40, key = "pact" },	
	{ type = "entry", text = ni.spell.icon(48792, 22, 22).." Icebound Fortitude", tooltip = "Use spell when player |cff00D700HP|r < %.", enabled = true, value = 45, min = 20, max = 100, step = 1, width = 40, key = "iceboundfort" },
	{ type = "separator" },
	{ type = "entry", text = ni.player.itemicon(5512, 22, 22).." Healthstone", tooltip = "Use Warlock Healthstone (if you have) when player |cff00D700HP|r < %.", enabled = true, value = 35, min = 25, max = 65, step = 1, width = 40, key = "healthstoneuse" },	
	{ type = "entry", text = ni.player.itemicon(57191, 22, 22).." Heal Potion", tooltip = "Use Heal Potions (if you have) when player |cff00D700HP|r < %.",  enabled = true, value = 30, min = 20, max = 60, step = 1, width = 40, key = "healpotionuse" },
	{ type = "entry", text = ni.player.itemicon(57192, 22, 22).." Mana Potion", tooltip = "Use Mana Potions (if you have) when player |cff0082FFMP|r < %.", enabled = true, value = 25, min = 15, max = 65, step = 1, width = 40, key = "manapotionuse" },
};
-- Get Setting from GUI -- 
local function GetSetting(name)
	for k, v in ipairs(items) do
		if v.type == "entry"
		and v.key ~= nil
		and v.key == name then
			return v.value, v.enabled;
		end
		if v.type == "dropdown"
		and v.key ~= nil
		and v.key == name then
			for k2, v2 in pairs(v.menu) do
				if v2.selected then
					return v2.value;
				end
			end
		end
		if v.type == "input"
		and v.key ~= nil
		and v.key == name then
			return v.value;
		end
	end
end;
local ZoneText = GetZoneText();
local InstanceName, InstanceType = GetInstanceInfo();
-- Local functions for profile --
--------- Misc ---------
local function PlayerInDungeon()
	return InstanceType == "party";
end;
local function PlayerInRaid()
	return InstanceType == "raid";
end;
local function PlayerZoneText()
	return ZoneText;
end;
local time_ZONE_CHANGED = GetTime()
ni.listener:add("zone_changed", {"CHALLENGE_MODE_START", "ZONE_CHANGED", "ZONE_CHANGED_NEW_AREA", "ZONE_CHANGED_INDOORS", "PLAYER_ENTERING_WORLD"}, function()
	ni.C_Timer.After(1, function()
		local xtime = GetTime()
		if  xtime-time_ZONE_CHANGED > 1 then
			time_ZONE_CHANGED = xtime;
			InstanceName, InstanceType = GetInstanceInfo()
			ZoneText = GetZoneText()
		end
	end)
end)
local function TTDChecker(t, valueTime, valueTTD, hp)
	valueTime = valueTime or 0
	valueTTD = valueTTD or 0
	hp = hp or 0
	if ni.vars.combat.time ~= 0 
	and GetTime() - ni.vars.combat.time > valueTime 
	and ni.unit.ttd(t) > valueTTD
	and ni.unit.hp(t) >= hp then
		return true;
	end
	return false;
end;
local function BossOrCD(t, valueTime, valueTTD, hp, enabled)
	if ni.vars.combat.cd then
		return true;
	end;
	local isboss = false;
	if enabled then
		isboss = unitBoss(t);
		if not isboss then
			return false;
		end
	end
	if TTDChecker(t, valueTime, valueTTD, hp) then
		if enabled then
			if isboss then
				return true;
			end
			return true;
		end
	end
	return false;
end;
--------- Spell Functions ---------
local function UsableSilence(spellid, stutter)
	if tonumber(spellid) == nil then
		spellid = ni.spell.id(spellid)
	end
	local result = false;
	if spellid == nil or spellid == 0 then
		return false;
	end
	local spellName = GetSpellInfo(spellid);
	if not ni.player.isstunned()
	and not ni.player.issilenced()
	and ni.spell.available(spellid, stutter)
	and IsUsableSpell(spellName) then
		result = true;
	end
	return result;
end;
local function UsableStun(spellid, stutter)
	if tonumber(spellid) == nil then
		spellid = ni.spell.id(spellid)
	end
	local result = false;
	if spellid == nil or spellid == 0 then
		return false;
	end
	local spellName = GetSpellInfo(spellid);
	if not ni.player.isstunned()
	and ni.spell.available(spellid, stutter)
	and IsUsableSpell(spellName) then
		result = true;
	end
	return result;
end;
local function IsKnown(spellid, isPetSpell)
	isPetSpell = true and isPetSpell or false
	if tonumber(spellid) == nil then
		spellid = ni.spell.id(spellid)
	end
	local result = false;
	if spellid == nil or spellid == 0 then
		return false;
	end
	if IsSpellKnown(spellid, isPetSpell) then
		local name = GetSpellInfo(spellid)
		if name then
			result = true;
		end
	end
	return result;
end;
local function GetMelee(t, spellid)
	if tonumber(spellid) == nil then
		spellid = ni.spell.id(spellid)
	end
	if ni.player.los(t)
	and ni.player.isfacing(t) then
		if IsKnown(spellid) then
			local spellName = GetSpellInfo(spellid);
			return IsSpellInRange(spellName, t) == 1;	
		else
			return ni.player.inmelee(t);
		end
	end
end;
--------- Usefull Functions ---------
local function CombatStart(value)
    if ni.vars.combat.time ~= 0
	and GetTime() - ni.vars.combat.time > value then
        return true;
    end
	return false;    
end;
local function CombatEnded(value)
    if ni.vars.combat.time == 0 
	and GetTime() - ni.vars.combat.ended > value then
        return true;
    end
	return false;
end;
local function ActiveGhoul()
    local ghoul = ni.player.creations();
    for k, v in ipairs(ghoul) do
		if ni.unit.creaturetype(v.guid) == 6 then
			return true;
		end
	end
end;
-- Spells Table --
local spells = {
BloodStrike = GetSpellInfo(45902),
BoneShield = GetSpellInfo(49222),
HornOfWinter = GetSpellInfo(57330),
MindFreeze = GetSpellInfo(47528),
Outbreak = GetSpellInfo(77575),
IcyTouch = GetSpellInfo(45477),
PlagueStrike = GetSpellInfo(45462),
Pestilence = GetSpellInfo(50842),
DeathAndDecay = GetSpellInfo(43265),
BloodBoil = GetSpellInfo(48721),
DeathStrike = GetSpellInfo(49998),
HeartStrike = GetSpellInfo(55050),
RuneStrike = GetSpellInfo(56815),
EmpowerRuneWeapon = GetSpellInfo(47568),
BloodTap = GetSpellInfo(50034),
	-- Agro --
DarkCommand = GetSpellInfo(56222),
DeathGrip = GetSpellInfo(49576),
	-- Saves --
RuneTap = GetSpellInfo(48982),
DeathPact = GetSpellInfo(48743),
RaiseDead = GetSpellInfo(46584),
VampiricBlood = GetSpellInfo(55233),
IceboundFortitude = GetSpellInfo(48792),
	-- DOTS --
FrostFever = GetSpellInfo(55095),
BloodPlague = GetSpellInfo(55078),
};
-- "Cache" Table -- 
local cache = {
GetRange = false,
PlayerCombat = false,
UnitAttackable = false,
PlayerControled = false,
hasFrostFever = false,
hasBloodPlague = false,
BloodRune = 0,
FrostRune = 0,
UnholyRune = 0,
DeathRune = 0,
};
-- Combat Event --
local function CombatEventCatcher(event, ...)
	-- local pGUID = UnitGUID("player");
    -- local target, castGUID, spellID = ...
	-- if event == "UNIT_SPELLCAST_SUCCEEDED" then
		-- local ptr = ni.memory.objectpointer(sourceGUID)
		-- local destGUID = ni.memory.read("uint64", ptr, 0xA70)
		-- print(spellID)
	-- end
end;
-- Update Cache Events --
local update_cache = {
    "PLAYER_ENTERING_WORLD",
    "GLYPH_UPDATED",
    "ACTIVE_TALENT_GROUP_CHANGED",
    "PLAYER_EQUIPMENT_CHANGED",
    "PLAYER_TALENT_UPDATE",
    "SPELLS_CHANGED",
};
-- Load GUI / Starting Cache -- 
local function OnLoad()
    local last_update_cache_time = 0;
    ni.listener:add("update_cache", update_cache, function()
        local xtime = GetTime()
        if xtime - last_update_cache_time > 1 then
            ni.C_Timer.After(1, function()
				
                last_update_cache_time = xtime + 1;
            end)
        end
    end)
	ni.listener:call("PLAYER_ENTERING_WORLD");
	ni.combatlog.registerhandler("Cata_Blood_DarhangeR", CombatEventCatcher);
	ni.GUI.AddFrame("Cata_Blood_DarhangeR", items);
end;
-- Unload GUI / Wipe Cache -- 
local function OnUnLoad()
	ni.listener:remove("update_cache", update_cache);
	ni.combatlog.unregisterhandler("Cata_Blood_DarhangeR");
	ni.GUI.DestroyFrame("Cata_Blood_DarhangeR");
end;
-- Rotation Priorities --
local queue = {
	"Cache",
	"Universal Pause",
	"AutoTarget",
	"Use Presence",
	"Horn of Winter",
	"Bone Shield",
	"Death Pact",
	"Icebound Fortitude",
	"Rune Tap",
	"Vampiric Blood",
	"Healthstone (Use)",
	"Heal Potions (Use)",
	"Combat specific Pause",
	"Empower Rune Weapon",
	"Dark Command (Ally)",
	"Death Grip (Ally)",	
	"Mind Freeze (Interrupt)",
	"Death and Decay",
	"Outbreak",
	"Icy Touch",
	"Plague Strike",
	"Pestilence (AoE)",
	"Death Strike",	
	"Blood Boil",
	"Heart Strike",
	"Rune Strike",
};
-- Abilities Code Table --
local abilities = {
-----------------------------------
	["Cache"] = function()
		if GetTime() - AntiAFKTime > 80 then
			ni.utils.resetlasthardwareaction();
			AntiAFKTime = GetTime();
		end
		cache.PlayerCombat = ni.player.incombat() or false;
		cache.UnitAttackable = (UnitExists("target") and UnitCanAttack("player", "target")) or false;
		cache.PlayerControled = (ni.player.issilenced() or ni.player.isstunned() or ni.player.isconfused() or ni.player.isfleeing()) or false;
		cache.BloodRune = select(2, ni.rune.bloodrunecd()) or 0;
		cache.FrostRune = select(2, ni.rune.frostrunecd()) or 0;
		cache.UnholyRune = select(2, ni.rune.unholyrunecd()) or 0;
		cache.DeathRune = select(2, ni.rune.deathrunecd()) or 0;		
		if cache.UnitAttackable then
			cache.GetRange = GetMelee("target", spells.BloodStrike) or false;
			local frost_fever = spells.FrostFever;
			local blood_plague = spells.BloodPlague;
			local FFDur = unitDebuffRem("target", frost_fever, "player");
			local BPDur = unitDebuffRem("target", blood_plague, "player");
			if FFDur then
				cache.hasFrostFever = FFDur;
			else
				cache.hasFrostFever = false;
			end	
			if BPDur then
				cache.hasBloodPlague = BPDur;
			else
				cache.hasBloodPlague = false;
			end			
		end
		if cache.PlayerCombat
		and (GetTime() - LastReset >= 15) then
			wipe(enemies);
			LastReset = GetTime();
		end		
	end,
-----------------------------------
	["Universal Pause"] = function()
		local value = GetSetting("Debug");
    	SLASH_PPAUSE1 = "/ppause"
		SlashCmdList.PPAUSE = function()
			ni.spell.stopcasting()
			ni.rotation.delay(value);
		end	
		if IsMounted()
		or UnitInVehicle("player")
		or UnitIsDeadOrGhost("player")
		or UnitChannelInfo("player")
		or UnitCastingInfo("player")
		or ni.player.islooting() then
			return true;
		end
		ni.vars.debug = select(2, GetSetting("Debug"));
	end,
-----------------------------------	
	["AutoTarget"] = function()
		local _, enabled = GetSetting("AutoAttack");
		if not enabled then
			return false;
		end
		if cache.PlayerCombat then
			if not UnitExists("target")
			or ((UnitExists("target")
			and UnitIsDeadOrGhost("target"))
			or not UnitCanAttack("player", "target"))
			and not IsCurrentSpell(GetSpellInfo(6603)) then
				local enemies = ni.player.enemiesinrange(15);
				for i = 1, #enemies do
				local tar = enemies[i].guid;
					if enemies[i].distance <= 15
					and not ni.unit.istotem(tar)
					and ni.player.isfacing(tar) then
						ni.player.target(tar)
						spellCast(GetSpellInfo(6603), tar)
						return true;
					end
				end
			end
		end
	end,
-----------------------------------
	["Use Presence"] = function()
		local presence = GetSetting("Presence");
		if presence == 0 then 
			return false;
		end		
		if not playerBuff(presence)
		and UsableStun(presence) then
			spellCast(presence)
			return true;
		end
	end,
-----------------------------------
	["Bone Shield"] = function()
		local _, enabled = GetSetting("boneshield");
		if not enabled
		or playerBuff(spells.BoneShield) 
		or not UsableSilence(spells.BoneShield) then
			return false;
		end
		spellCast(spells.BoneShield)
		return true;
	end,
-----------------------------------
	["Horn of Winter"] = function()
		local _, enabled = GetSetting("AutoBuff");
		if not enabled
		or playerBuff(spells.HornOfWinter) then 
			return false;
		end
		if UsableSilence(spells.HornOfWinter) then
			spellCast(spells.HornOfWinter)	
			return true;
		end
	end,
-----------------------------------
	["Healthstone (Use)"] = function()
		local hpVal, enabled = GetSetting("healthstoneuse");
		if not enabled then
			return false;
		end
		if not cache.PlayerControled
		and cache.PlayerCombat
		and playerHP() <= hpVal then
			if playerItemR(5512) then
				playerUseIt(5512)
				return true;
			end
		end
	end,
-----------------------------------	
	["Heal Potions (Use)"] = function()
		local hpVal, enabled = GetSetting("healpotionuse");
		if not enabled then
			return false;
		end
		local hpot = { 57191, 43569, 40087, 41166, 33447, 39671, 22829, 33934, 28100, 13446, 3928, 1710, 929, 4596, 858, 118 };
		if not cache.PlayerControled
		and cache.PlayerCombat
		and playerHP() <= hpVal then
			for i = 1, #hpot do
			local a = hpot[i];
				if playerItemR(a) then
					playerUseIt(a)
					return true;
				end
			end
		end
	end,
-----------------------------------
	["Combat specific Pause"] = function()
		if not UnitCanAttack("player", "target")
		or (not ni.unit.incombat("target")
		and not ni.unit.isdummy("target")
		and not ni.unit.isplayer("target")) then
			return true;
		end
	end,
-----------------------------------	
	["Dark Command (Ally)"] = function()	
		if not UsableSilence(spells.DarkCommand) then
			return false;
		end
		local _, DC = GetSetting("dark");
		local AgroSpells = "56222||49576";		
		if CombatStart(5) 
		and (PlayerInDungeon() or DC) then
		local enemies = playerEnemies(30);
			for i = 1, #enemies do
			local threatUnit = enemies[i].guid;
			local _, _, AgrPercent = UnitDetailedThreatSituation("player", threatUnit);
				if (AgrPercent ~= nil and AgrPercent < 100) then
					if drTrack(threatUnit, "Taunts") > 0
					and not unitDebuffs(threatUnit, AgroSpells, "EXACT") 
					and spellValid(threatUnit, spells.DarkCommand, false, true) then
						spellCast(spells.DarkCommand, threatUnit)
						return true;
					end
				end
			end
		end
	end,
-----------------------------------
	["Death Grip (Ally)"] = function()
		local _, Grip = GetSetting("grip");
		if not Grip
		or not UsableSilence(spells.DeathGrip) then
			return false;
		end
		local AgroSpells = "56222||49576";	
		if CombatStart(5) then
		local enemies = playerEnemies(30);				
			for i = 1, #enemies do
			local threatUnit = enemies[i].guid;
			local _, _, AgrPercent = UnitDetailedThreatSituation("player", threatUnit);
				if (AgrPercent ~= nil and AgrPercent < 100) then
					if drTrack(threatUnit, "Taunts") > 0
					and not unitDebuffs(threatUnit, AgroSpells, "EXACT") 
					and spellValid(threatUnit, spells.DeathGrip, true, true) then
						spellCast(spells.DeathGrip, threatUnit)
						return true;
					end
				end
			end
		end
	end,
-----------------------------------
	["Empower Rune Weapon"] = function()
		local _, enabled = GetSetting("emprower");
		if not enabled
		or not UsableSilence(spells.EmpowerRuneWeapon) 
		or not cache.GetRange then
			return false;
		end
		local _, enabled = GetSetting("detect");
		if BossOrCD("target", 5, 5, 1, enabled) then
			if ni.rune.available() == 0 then
				spellCast(spells.EmpowerRuneWeapon)
				return true;
			end
		end
	end,
-----------------------------------	
	["Mind Freeze (Interrupt)"] = function()
		local _, enabled = GetSetting("autointerrupt");
		if not enabled
		or not UsableSilence(spells.MindFreeze) then
			return false;
		end
		local enemies = playerEnemies(7);
		for i = 1, #enemies do
			local InterruptTargets = enemies[i].guid;
			if ni.spell.shouldinterrupt(InterruptTargets)
			and spellValid(InterruptTargets, spells.MindFreeze, true, true) then
				spellCast(spells.MindFreeze, InterruptTargets)
				return true;
			end
		end
	end,
-----------------------------------
	["Rune Tap"] = function()
		local hpVal, enabled = GetSetting("runetap");
		if not enabled 
		or not cache.PlayerCombat then
			return false;
		end
		if ni.player.hp() <= hpVal then
			if (cache.BloodRune >= 1 or cache.DeathRune >= 1)
			and UsableSilence(spells.RuneTap) then 
				spellCast(spells.RuneTap)
				return true;
			end
			if not ni.spell.available(spells.RuneTap)
			and not cache.PlayerControled
			and ni.spell.cd(spells.RuneTap) == 0
			and ni.spell.cd(spells.BloodTap) == 0 then
				spellCast(spells.BloodTap)
				return true;
			end
		end
	end,
-----------------------------------
	["Icebound Fortitude"] = function()
		local hpVal, enabled = GetSetting("iceboundfort");
		if not enabled
		or not cache.PlayerCombat
		or not UsableSilence(spells.IceboundFortitude) then
			return false;
		end
		if ni.player.hp() <= hpVal
		and not playerBuff(spells.IceboundFortitude) then
			spellCast(spells.IceboundFortitude)
			return true;
		end
	end,
-----------------------------------
	["Vampiric Blood"] = function()
		local hpVal, enabled = GetSetting("vampblood");
		if not enabled
		or not cache.PlayerCombat
		or not UsableStun(spells.VampiricBlood) then
			return false;
		end
		if cache.BloodRune >= 1 or cache.DeathRune >= 1 then
			if ni.player.hp() <= hpVal		 
			and not playerBuff(spells.VampiricBlood) then
				spellCast(spells.VampiricBlood)
				return true;
			end
		end
	end,	
-----------------------------------
	["Death Pact"] = function()
		local hpVal, enabled = GetSetting("pact");
		if not enabled
		or not cache.PlayerCombat
		or not UsableSilence(spells.DeathPact) then
			return false;
		end
		if ni.player.hp() <= hpVal
		and ni.power.currentraw("player", 6) >= 40 then
			if UsableSilence(spells.RaiseDead) then
				spellCast(spells.RaiseDead)			
				return true;
			end
			if ActiveGhoul() then
				spellCast(spells.DeathPact)
				return true;
			end
		end 
	end,
-----------------------------------
	["Outbreak"] = function()
		local frost_fever = spells.FrostFever;
		local blood_plague = spells.BloodPlague;
		if not UsableSilence(spells.Outbreak) then
			return false;
		end
		if (not unitDebuff("target", frost_fever, "player")
		and not unitDebuff("target", blood_plague, "player"))
		or ((unitDebuff("target", frost_fever, "player")
		and unitDebuffRem("target", frost_fever, "player") < 2)
		and ni.spell.cd(spells.IcyTouch) > 2)
		or ((unitDebuff("target", blood_plague, "player")
		and unitDebuffRem("target", blood_plague, "player") < 2)
		and ni.spell.cd(spells.PlagueStrike) > 2)
		and spellValid("target", spells.Outbreak, false, true)  then
			spellCast(spells.Outbreak, "target")
			return true;
		end
	end,
-----------------------------------
	["Icy Touch"] = function()
		local icy_touch = spells.IcyTouch;
		local frost_fever = spells.FrostFever;
		if not UsableSilence(icy_touch)
		or not spellValid("target", icy_touch, true, true) then
			return false;
		end
		if (not unitDebuff("target", frost_fever, "player")
		or unitDebuffRem("target", frost_fever, "player") < 2) then
			spellCast(icy_touch, "target")
			return true;
		end
	end,
-----------------------------------
	["Plague Strike"] = function()
		local plague_strike = spells.PlagueStrike;
		local blood_plague = spells.BloodPlague;	
		if not UsableSilence(plague_strike)
		or not cache.GetRange then
			return false;
		end
		if (not unitDebuff("target", blood_plague, "player")
		or unitDebuffRem("target", blood_plague, "player") < 2) then
			spellCast(plague_strike, "target")
			return true;
		end
	end,
-----------------------------------
	["Death and Decay"] = function()
		if not UsableSilence(spells.DeathAndDecay) 
		or not cache.GetRange then
			return false;
		end
		local AoEcount, AoEenabled = GetSetting("aoe");
		local EnemiesCount = #unitEnemiesRange("target", 9);
		if ni.vars.combat.aoe
		or (AoEenabled and EnemiesCount >= AoEcount) then
			ni.spell.castat(spells.DeathAndDecay, "target")
			return true;
		end
	end,
-----------------------------------
	["Pestilence (AoE)"] = function()
		local _, enabled = GetSetting("pestiAoE");
		if not enabled
		or not cache.GetRange then
			return false;
		end
		local frost_fever = spells.FrostFever;
		local blood_plague = spells.BloodPlague;	
		if (unitDebuff("target", frost_fever, "player") and unitDebuff("target", blood_plague, "player"))
		and UsableSilence(spells.Pestilence)
		and ni.spell.lastcast(spells.Pestilence, 5) then
			local enemies = unitEnemiesRange("target", 10);
			if #enemies >= 1 then
				for i = 1, #enemies do
				local tar = enemies[i].guid;
					if ni.unit.creaturetype(tar) ~= 11
					and (not unitDebuff(tar, blood_plague, "player") 
					or not unitDebuff(tar, frost_fever, "player")) then
						spellCast(spells.Pestilence, "target")
						ni.debug.print("|cffC41E3ASpread "..GetSpellLink(frost_fever).." |cffC41E3Aand "..GetSpellLink(blood_plague).." |cffC41E3Afor AoE")
						return true;
					end
				end
			end
		end
	end,
-----------------------------------
	["Blood Boil"] = function()
		if not cache.GetRange 
		or not UsableStun(spells.BloodBoil) then
			return false;
		end
		local count, enabled = GetSetting("boil");
		local EnemiesCount = #unitEnemiesRange("target", 9);
		if ((enabled and EnemiesCount >= count)	
		or ni.rotation.custommod()) then
			if (cache.BloodRune >= 1 or playerBuff(81141))
			and (cache.hasFrostFever > 3.3 and cache.hasBloodPlague > 3.3) then
				spellCast(spells.BloodBoil)
				return true;
			end
		end
		if playerBuff(81141)
		and (cache.hasFrostFever > 3.3 and cache.hasBloodPlague > 3.3) then
			spellCast(spells.BloodBoil)
			return true;
		end		
	end,
-----------------------------------
	["Heart Strike"] = function()
		if not UsableStun(spells.HeartStrike) 
		or not cache.GetRange then
			return false;
		end
		local count, enabled = GetSetting("boil");
		local EnemiesCount = #unitEnemiesRange("target", 9);		
		if (not enabled and not ni.rotation.custommod()) 
		or (enabled and EnemiesCount < count) then
			if cache.BloodRune >= 1
			and (cache.hasFrostFever > 2.3 and cache.hasBloodPlague > 2.3) then
				spellCast(spells.HeartStrike, "target")
				return true;
			end
		end
	end,
-----------------------------------
	["Death Strike"] = function()
		if not cache.GetRange then
			return false;
		end	
		if UsableStun(spells.DeathStrike) then
			spellCast(spells.DeathStrike, "target")
			return true;
		end
	end,
-----------------------------------
	["Rune Strike"] = function()
		if not cache.GetRange then
			return false;
		end
		local hpVal = GetSetting("pact");
		if ni.player.hp() > hpVal
		and UsableStun(spells.RuneStrike) then			
			spellCast(spells.RuneStrike, "target")
			return true;
		end
	end,	
};
	ni.bootstrap.profile("Cata_Blood_DarhangeR", queue, abilities, OnLoad, OnUnLoad);
else -- Debug with comparing WoW Build / Player Level
    local queue = {
        "Error",
    };
    local abilities = {
        ["Error"] = function()
            ni.vars.profiles.enabled = false;
			if not cata then
				ni.frames.floatingtext:message("This profile for Cata!")
            end
        end,
    };
    ni.bootstrap.profile("Cata_Blood_DarhangeR", queue, abilities);
end;	