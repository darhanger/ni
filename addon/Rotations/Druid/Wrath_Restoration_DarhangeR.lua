local GetBuildInfo, select, ipairs, pairs, tonumber, GetSpellInfo, IsUsableSpell, GetTime, UnitAffectingCombat, IsMounted, ni_tanks, UnitInVehicle, UnitIsDeadOrGhost, UnitChannelInfo, UnitCastingInfo = GetBuildInfo, select, ipairs, pairs, tonumber, GetSpellInfo, IsUsableSpell, GetTime, UnitAffectingCombat, IsMounted, ni.tanks, UnitInVehicle, UnitIsDeadOrGhost, UnitChannelInfo, UnitCastingInfo
local build = select(4, GetBuildInfo());
local wotlk = build == 30300 or false;
if wotlk then
local AntiAFKTime = 0;
local items = {
	settingsfile = "DruidRestoEN_Free_Darhanger.json",
	{ type = "title", text = "Free Restoration Druid by |c0000CED1DarhangeR|r" },
	{ type = "separator" },
	{ type = "title", text = "|cffFF7C0AProfile version 0.0.2|r" },
	{ type = "separator" },
	{ type = "page", number = 1, text = "|cffFFFF00Main Settings" },
	{ type = "separator" },	
	{ type = "entry", text = ni.spell.icon(33891).." Auto Form", tooltip = "Auto use proper form.", enabled = true, key = "autoform" },	
	{ type = "entry", text = ni.spell.icon(52674).." Auto Buff", tooltip = "Enable Auto Buff player/ally.", enabled = true, key = "AutoBuff" },	
	{ type = "entry", text = ni.spell.icon(2382).." |cffffa500Debug Printing|r", tooltip = "Enable for debug if you have problems.", enabled = false, key = "Debug" },
	{ type = "page", number = 2, text = "|cff95f900CD's and important spells|r" },
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(18562).." Swiftmend", tooltip = "Use spell when ally |cff00D700HP|r < %.", enabled = true, value = 60, min = 10, max = 100, step = 1, width = 40, key = "swift" },
	{ type = "entry", text = ni.spell.icon(17116).." Nature's Swiftness", tooltip = "Use spell when ally |cff00D700HP|r < %.\nWith Nature Swiftness also will be used [Healing Touch].", enabled = true, value = 40, min = 10, max = 100, step = 1, width = 40, key = "natureswift" },	
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(48447).." Tranquility", tooltip = "Spell will be used when average |cff00D700HP|r\nof specified number allies is lower < %.", enabled = true, key = "tranquil" },
	{ type = "entry", text = "Tranquility (Ally HP)", tooltip = "Adjust ally average |cff00D700HP|r < %.", value = 37, min = 25, max = 100, step = 1, width = 40, key = "tranquilhp" },
	{ type = "entry", text = "Tranquility (Ally Count)", tooltip = "Adjust ally count in your party.", value = 4, min = 2, max = 5, step = 1, width = 40, key = "tranquilcount" },
	{ type = "separator" },	
	{ type = "title", text = "Dispel" },
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(2782).." Remove Curse (Ally)", tooltip = "Auto dispel debuffs from ally.", enabled = true, key = "removecurse" },
	{ type = "entry", text = ni.spell.icon(2893).." Abolish Poison (Ally)", tooltip = "Auto dispel debuffs from ally.", enabled = true, key = "ambolishpoison" },	
	{ type = "page", number = 3, text = "|cff95f900Party/Raid Healing Settings|r" },
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(48441).." Rejuvenation", tooltip = "Use spell when ally |cff00D700HP|r < %.", enabled = true, value = 99, min = 10, max = 100, step = 1, width = 40, key = "rejuall" },	
	{ type = "entry", text = ni.spell.icon(48438).." Wild Growth", tooltip = "Use spell when ally |cff00D700HP|r < %.", enabled = true, value = 95, min = 10, max = 100, step = 1, width = 40, key = "growth" },	
	{ type = "entry", text = ni.spell.icon(50464).." Nourish", tooltip = "Use spell when ally |cff00D700HP|r < %.", enabled = true, value = 75, min = 10, max = 100, step = 1, width = 40, key = "nourish" },	
	{ type = "page", number = 4, text = "|cff95f900Tank Settings|r" },
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(2565).." Auto Track Tank", tooltip = "Auto Track Tank and mainly heal him.\nDruid support MAIN TANK and OFF TANK.", enabled = true, key = "healtank" },	
	{ type = "entry", text = ni.spell.icon(48441).." Rejuvenation", tooltip = "Always keeps [Rejuvenation] on Main Tank and Off Tank.", enabled = true, key = "rejuTanks" },	
	{ type = "entry", text = ni.spell.icon(50464).." Nourish", tooltip = "Use spell when tanks |cff00D700HP|r < %.", enabled = true, value = 70, min = 10, max = 100, step = 1, width = 40, key = "nouriTanks" },
	{ type = "page", number = 5, text = "|cff00C957Defensive Settings" },
	{ type = "separator" },	
	{ type = "entry", text = ni.spell.icon(22812).." Barkskin", tooltip = "Use spell when player |cff00D700HP|r < %.", enabled = true, value = 40, min = 15, max = 100, step = 1, width = 40, key = "barkskin" },	
};
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
local function OnLoad()
	ni.GUI.AddFrame("Wrath_Restoration_DarhangeR", items);
end;
local function OnUnLoad()  
	ni.GUI.DestroyFrame("Wrath_Restoration_DarhangeR");
end;
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
local spells = {
MarkOfTheWild = GetSpellInfo(48469),
GiftOfTheWild = GetSpellInfo(48470),
TreeOfLife = GetSpellInfo(33891),
Thorns = GetSpellInfo(53307),
Innervate = GetSpellInfo(29166),
Barkskin = GetSpellInfo(22812),
Lifebloom = GetSpellInfo(48451),
Rejuvenation = GetSpellInfo(48441),
Regrowth = GetSpellInfo(48443),
Nourish = GetSpellInfo(50464),
WildGrowth = GetSpellInfo(53251),
Tranquility = GetSpellInfo(48447),
HealingTouch = GetSpellInfo(48378),
NatureSwiftness = GetSpellInfo(17116),
Swiftmend = GetSpellInfo(18562),
RemoveCurse = GetSpellInfo(2782),
AbolishPoison = GetSpellInfo(2893),
Cyclone = GetSpellInfo(33786),
	-- Proc --
Clearcasting = GetSpellInfo(16870),
};
local cache = {
IsMoving = false,
PlayerCombat = false,
};
local queue = {
"Cache",
"Universal Pause",
"Gift of the Wild",
"Thorns",
"Tree of Life",
"Barkskin",
"Combat Specific Pause",
"Nature's Swiftness",
"Swiftmend",	
"Wild Growth",
"Tank Heal",
"Rejuvenation",	
"Remove Curse (Ally)",
"Abolish Poison (Ally)",
"Nourish",	
};
local abilities = {
-----------------------------------
	["Cache"] = function()
		if GetTime() - AntiAFKTime > 80 then
			ni.utils.resetlasthardwareaction();
			AntiAFKTime = GetTime();
		end
		cache.IsMoving = ni.player.ismoving() or false;
		cache.PlayerCombat = UnitAffectingCombat("player") or false;
	end,
-----------------------------------
	["Universal Pause"] = function()
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
	["Gift of the Wild"] = function()
		local _, enabled = GetSetting("AutoBuff");
		if not enabled then
			return false;
		end
		if cache.PlayerCombat
		or ni.player.buff(spells.MarkOfTheWild)
		or ni.player.buff(spells.GiftOfTheWild) then 
			return false;
		end
		if UsableSilence(spells.GiftOfTheWild) then
			ni.spell.cast(spells.GiftOfTheWild, "player")	
			return true;
		end
		if UsableSilence(spells.MarkOfTheWild)
		and not UsableSilence(spells.GiftOfTheWild) then
			ni.spell.cast(spells.MarkOfTheWild, "player")
			return true;
		end
	end,
-----------------------------------
	["Thorns"] = function()
		local _, enabled = GetSetting("AutoBuff");
		if not enabled then
			return false;
		end
		if cache.PlayerCombat then
			return false;
		end
		if UsableSilence(spells.Thorns)
		and not ni.player.buff(spells.Thorns) then
			ni.spell.cast(spells.Thorns, "player")
			return true;
		end
	end,
-----------------------------------	
	["Tree of Life"] = function()
		local _, enabled = GetSetting("autoform");
		if not enabled then
			return false;
		end
		if UsableSilence(spells.TreeOfLife)
		and not ni.unit.buff("player", 33891, "EXACT") then
			ni.spell.cast(spells.TreeOfLife)
			return true;
		end
	end,
-----------------------------------	
	["Barkskin"] = function()
		local value, enabled = GetSetting("barkskin");
		if not enabled
		or cache.PlayerCombat then
			return false;
		end
		if ni.player.hp() <= value
		and ni.spell.available(spells.Barkskin) 
		and not ni.player.buff(spells.Barkskin) then
			ni.spell.cast(spells.Barkskin)
			return true;
		end
	end,
-----------------------------------	
	["Combat Specific Pause"] = function()
		if cache.PlayerCombat then
			return false;
		end
		for i = 1, #ni.members do
		local ally = ni.members[i];
		if ally:combat() then
				return false;
			end
		end
		return true;
	end,
-----------------------------------
	["Swiftmend"] = function()
		local value, enabled = GetSetting("swift");
		if not enabled then
			return false;
		end
		if ni.spell.available(spells.Swiftmend) then
			for i = 1, #ni.members do
			local ally = ni.members[i];
				if ally:hp() <= value
				and ally.auras(spells.Rejuvenation.."||"..spells.Regrowth)
				and ally:valid(ally, spells.Swiftmend, false, true) then
					ni.spell.cast(spells.Swiftmend, ally.unit)
					return true;				
				end					
			end
		end
	end,
-----------------------------------
	["Nature's Swiftness"] = function()
		local value, enabled = GetSetting("natureswift");
		if not enabled then
			return false;
		end
		if UsableSilence(spells.NatureSwiftness)
		and UsableSilence(spells.HealingTouch) 
		and (ni.spell.cd(spells.Swiftmend) ~= 0 
		and ni.spell.cd(spells.Swiftmend) > 1.5) then
			local allyOne = ni.members[1];
			if allyOne:hp() <= value
			and allyOne:valid(allyOne, spells.HealingTouch, false, true) then
				ni.spell.cast(spells.NatureSwiftness)
				ni.spell.cast(spells.HealingTouch, allyOne.unit)
				return true;
			end
		end
	end,
-----------------------------------			
    ["Tranquility"] = function()
		if not ui("tranquil")[2]
		or cache.IsMoving then 
			return false;
		end
		local value = ui("tranquilhp")[1];
		local total = members.subgroupbelow(value, 30, true);
		if total >= ui("tranquilcount")[1]
		and usableSilence(spells.Tranquility) then
			spellCast(spells.Tranquility)
			return true;
		end
	end,
-----------------------------------		
	["Tank Heal"] = function()
		local mainTank, offTank = ni_tanks();
		local _, enabled = GetSetting("healtank");
		local _, rejEnable = GetSetting("rejuTanks");
		local nourVal, nourEnable = GetSetting("nouriTanks");
		if not enabled then
			return false;
		end
		if mainTank then
			if UnitExists(mainTank.unit)
			and ni.spell.valid(mainTank.unit, spells.HealingTouch, false, true, true) then	
				if nourEnable then
					if not cache.IsMoving
					and ni.unit.hp(mainTank.unit) <= nourVal
					and UsableSilence(spells.Nourish) then
						if (ni.unit.buff(mainTank.unit, spells.Rejuvenation)
						or ni.unit.buff(mainTank.unit, spells.WildGrowth)) then
							ni.spell.cast(spells.Nourish, mainTank.unit) 
							return true;
						end
					end
				end
				if rejEnable then
					if UsableSilence(spells.Rejuvenation)
					and not ni.unit.buff(mainTank.unit, spells.Rejuvenation, "player") then
						ni.spell.cast(spells.Rejuvenation, mainTank.unit)
						return true;
					end
				end
			end
		end
		if offTank then
			if UnitExists(offTank.unit) 
			and ni.spell.valid(offTank.unit, spells.HealingTouch, false, true, true) then	
				if nourEnable then
					if not cache.IsMoving
					and ni.unit.hp(offTank.unit) <= nourVal
					and UsableSilence(spells.Nourish) then
						if (ni.unit.buff(offTank.unit, spells.Rejuvenation)
						or ni.unit.buff(offTank.unit, spells.WildGrowth)) then
							ni.spell.cast(spells.Nourish, offTank.unit) 
							return true;
						end
					end
				end
				if rejEnable then
					if UsableSilence(spells.Rejuvenation)
					and not ni.unit.buff(offTank.unit, spells.Rejuvenation, "player") then
						ni.spell.cast(spells.Rejuvenation, offTank.unit)
						return true;
					end
				end
			end
		end
	end,
-----------------------------------			
	["Remove Curse (Ally)"] = function()
		local _, enabled = GetSetting("removecurse");
		if not enabled
		or not UsableSilence(spells.RemoveCurse) then
			return false;
		end
		for i = 1, #ni.members.sort() do
		local ally = ni.members[i];
			if ally:debufftype("Curse")	 
			and ally:dispel()
			and ni.spell.lastcast(spells.RemoveCurse, 1.8)
			and ally:valid(spells.RemoveCurse, false, true) then
				ni.spell.cast(spells.RemoveCurse, ally.unit)
				return true;
			end
		end
	end,
-----------------------------------	
	["Abolish Poison (Ally)"] = function()
		local _, enabled = GetSetting("removecurse");	
		if not enabled 
		or not UsableSilence(spells.AbolishPoison) then
			return false;
		end
		for i = 1, #ni.members.sort() do
		local ally = ni.members[i];
			if ally:debufftype("Poison")	 
			and ally:dispel()
			and not ally:aura(spells.AbolishPoison)
			and ni.spell.lastcast(spells.AbolishPoison, 1.8)
			and ally:valid(spells.AbolishPoison, false, true) then
				ni.spell.cast(spells.AbolishPoison, ally.unit)
				return true;
			end
		end
	end,
-----------------------------------	
	["Rejuvenation"] = function()
		local value, enabled = GetSetting("rejuall");
		if not enabled then
			return false;
		end
		if UsableSilence(spells.Rejuvenation) then
			for i = 1, #ni.members do
			local ally = ni.members[i];
				if ally:hp() <= value
				and not ally:buff(spells.Rejuvenation, "player")
				and ally:valid(spells.Rejuvenation, false, true) then
					ni.spell.cast(spells.Rejuvenation, ally.unit)
					return true;
				end	
			end
		end
	end,
-----------------------------------	
	["Nourish"] = function()
		local value, enabled = GetSetting("nourish");
		if not enabled
		or cache.IsMoving then
			return false;
		end
		if UsableSilence(spells.Nourish) then
			for i = 1, #ni.members do
			local ally = ni.members[i];
				if ally:hp() <= value
				and ally:auras(spells.Rejuvenation.."||"..spells.Regrowth.."||"..spells.Lifebloom.."||"..spells.WildGrowth)
				and ally:valid(spells.Nourish, false, true) then
					ni.spell.cast(spells.Nourish, ally.unit)
					return true;
				end
			end
		end
	end,
-----------------------------------	
	["Wild Growth"] = function()
		local value, enabled = GetSetting("growth");
		if not enabled
		or not UsableSilence(spells.WildGrowth) then
			return false;
		end
		local allyOne = ni.members[1];
		local ally = ni.members.inrangewithoutbuffbelow(allyOne.unit, 14, spells.WildGrowth, value);
		if #ally >= 3	 
		and allyOne:hp() <= value
		and allyOne:valid(spells.WildGrowth, false, true) then
			ni.spell.cast(spells.WildGrowth, allyOne.unit)
			return true;
		end
	end,
};
	ni.bootstrap.profile("Wrath_Restoration_DarhangeR", queue, abilities, OnLoad, OnUnLoad);
else
    local queue = {
        "Error",
    };
    local abilities = {
        ["Error"] = function()
            ni.vars.profiles.enabled = false;
			if not wotlk then
				ni.frames.floatingtext:message("This profile for WotLK 3.3.5a!")
            end
        end,
    };
    ni.bootstrap.profile("Wrath_Restoration_DarhangeR", queue, abilities);
end;