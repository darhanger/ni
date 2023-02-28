local GetBuildInfo, select, ipairs, pairs, tonumber, GetSpellInfo, IsUsableSpell, GetTime, UnitAffectingCombat, IsMounted, ni_tanks, UnitInVehicle, UnitIsDeadOrGhost, UnitChannelInfo, UnitCastingInfo = GetBuildInfo, select, ipairs, pairs, tonumber, GetSpellInfo, IsUsableSpell, GetTime, UnitAffectingCombat, IsMounted, ni.tanks, UnitInVehicle, UnitIsDeadOrGhost, UnitChannelInfo, UnitCastingInfo
local build = select(4, GetBuildInfo());
local wotlk = build == 30300 or false;
if wotlk then
local AntiAFKTime = 0;
local items = {
	settingsfile = "DruidRestoEN_Free_Darhanger.json",
	{ type = "title", text = "Free Restoration Druid by |c0000CED1DarhangeR|r" },
	{ type = "separator" },
	{ type = "title", text = "|cffFF7C0AProfile version 0.0.1|r" },
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
	ni.GUI.AddFrame("Free_Restoration_DarhangeR", items);
end;
local function OnUnLoad()  
	ni.GUI.DestroyFrame("Free_Restoration_DarhangeR");
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
Barkskin = GetSpellInfo(22812),
Rejuvenation = GetSpellInfo(48441),
Nourish = GetSpellInfo(50464),
WildGrowth = GetSpellInfo(53251),
HealingTouch = GetSpellInfo(48378),
NatureSwiftness = GetSpellInfo(17116),
Swiftmend = GetSpellInfo(18562),
RemoveCurse = GetSpellInfo(2782),
AbolishPoison = GetSpellInfo(2893),
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
		if GetTime() - AntiAFKTime > 100 then
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
		if enabled then
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
		end
	end,
-----------------------------------
	["Thorns"] = function()
		local _, enabled = GetSetting("AutoBuff");
		if enabled then
			if cache.PlayerCombat then
				return false;
			end
			if UsableSilence(spells.Thorns)
			and not ni.player.buff(spells.Thorns) then
				ni.spell.cast(spells.Thorns, "player")
				return true;
			end
		end
	end,
-----------------------------------	
	["Tree of Life"] = function()
		local _, enabled = GetSetting("autoform");
		if enabled then
			if UsableSilence(spells.TreeOfLife)
			and not ni.unit.buff("player", spells.TreeOfLife, "EXACT") then
				ni.spell.cast(spells.TreeOfLife)
				return true;
			end
		end
	end,
-----------------------------------	
	["Barkskin"] = function()
		local value, enabled = GetSetting("barkskin");
		if enabled then
			if cache.PlayerCombat
			and ni.player.hp() <= value
			and ni.spell.available(spells.Barkskin) 
			and not ni.player.buff(spells.Barkskin) then
				ni.spell.cast(spells.Barkskin)
				return true;
			end
		end
	end,
-----------------------------------	
	["Combat Specific Pause"] = function()
		if cache.PlayerCombat then
			return false;
		end
		for i = 1, #ni.members do
		local ally = ni.members[i].unit;
		if UnitAffectingCombat(ally) then
				return false;
			end
		end
		return true;
	end,
-----------------------------------
	["Swiftmend"] = function()
		local value, enabled = GetSetting("swift");
		if enabled then
			if ni.spell.available(spells.Swiftmend) then
				for i = 1, #ni.members do
				local ally = ni.members[i].unit;
					if ni.members[i].hp <= value
					and ni.unit.buff(ally, spells.Rejuvenation)
					and ni.spell.valid(ally, spells.Swiftmend, false, true, true) then
						ni.spell.cast(spells.Swiftmend, ally)
						return true;				
					end					
				end
			end
		end
	end,
-----------------------------------
	["Nature's Swiftness"] = function()
		local value, enabled = GetSetting("natureswift");
		if enabled then
			if UsableSilence(spells.NatureSwiftness)
			and UsableSilence(spells.HealingTouch) 
			and (ni.spell.cd(spells.Swiftmend) ~= 0 
			and ni.spell.cd(spells.Swiftmend) > 1.5) then
				local allyOne = ni.members[1].unit;
				if ni.members[1].hp <= value
				and ni.spell.valid(allyOne, spells.HealingTouch, false, true, true) then
					ni.spell.cast(spells.NatureSwiftness)
					ni.spell.cast(spells.HealingTouch, allyOne)
					return true;
				end
			end
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
		if mainTank ~= nil
		and ni.spell.valid(mainTank, spells.HealingTouch, false, true, true) then	
			if nourEnable then
				if not cache.IsMoving
				and ni.unit.hp(mainTank) <= nourVal
				and UsableSilence(spells.Nourish) then
					if (ni.unit.buff(mainTank, spells.Rejuvenation)
					or ni.unit.buff(mainTank, spells.WildGrowth)) then
						ni.spell.cast(spells.Nourish, mainTank) 
						return true;
					end
				end
			end
			if rejEnable then
				if UsableSilence(spells.Rejuvenation)
				and not ni.unit.buff(mainTank, spells.Rejuvenation, "player") then
					ni.spell.cast(spells.Rejuvenation, mainTank)
					return true;
				end
			end
		end
		if offTank ~= nil
		and ni.spell.valid(offTank, spells.HealingTouch, false, true, true) then	
			if nourEnable then
				if not cache.IsMoving
				and ni.unit.hp(offTank) <= nourVal
				and UsableSilence(spells.Nourish) then
					if (ni.unit.buff(offTank, spells.Rejuvenation)
					or ni.unit.buff(offTank, spells.WildGrowth)) then
						ni.spell.cast(spells.Nourish, offTank) 
						return true;
					end
				end
			end
			if rejEnable then
				if UsableSilence(spells.Rejuvenation)
				and not ni.unit.buff(offTank, spells.Rejuvenation, "player") then
					ni.spell.cast(spells.Rejuvenation, offTank)
					return true;
				end
			end
		end
	end,
-----------------------------------			
	["Remove Curse (Ally)"] = function()
		local _, enabled = GetSetting("removecurse");
		if enabled
		and UsableSilence(spells.RemoveCurse) then
			for i = 1, #ni.members do
			local ally = ni.members[i].unit;
				if ni.unit.debufftype(ally, "Curse")	 
				and ni.healing.candispel(ally)
				and ni.spell.lastcast(spells.RemoveCurse, 1.8)
				and ni.spell.valid(ally, spells.RemoveCurse, false, true, true) then
					ni.spell.cast(spells.RemoveCurse, ally)
					return true;
				end
			end
		end
	end,
-----------------------------------	
	["Abolish Poison (Ally)"] = function()
		local _, enabled = GetSetting("removecurse");	
		if enabled 
		and UsableSilence(spells.AbolishPoison) then
			for i = 1, #ni.members do
			local ally = ni.members[i].unit;
				if ni.unit.debufftype(ally, "Poison")	 
				and ni.healing.candispel(ally)
				and not ni.unit.buff(ally, spells.AbolishPoison)
				and ni.spell.lastcast(spells.AbolishPoison, 1.8)
				and ni.spell.valid(ally, spells.AbolishPoison, false, true, true) then
					ni.spell.cast(spells.AbolishPoison, ally)
					return true;
				end
			end
		end
	end,
-----------------------------------	
	["Rejuvenation"] = function()
		local value, enabled = GetSetting("rejuall");
		if enabled then
			if UsableSilence(spells.Rejuvenation) then
				for i = 1, #ni.members do
				local ally = ni.members[i].unit;
					if ni.members[i].hp <= value
					and not ni.unit.buff(ally, spells.Rejuvenation, "player")
					and ni.spell.valid(ally, spells.Rejuvenation, false, true, true) then
						ni.spell.cast(spells.Rejuvenation, ally)
						return true;
					end	
				end
			end
		end
	end,
-----------------------------------	
	["Nourish"] = function()
		local value, enabled = GetSetting("nourish");
		if enabled then
			if not cache.IsMoving
			and UsableSilence(spells.Nourish) then
				for i = 1, #ni.members do
				local ally = ni.members[i].unit;
					if ni.members[i].hp <= value
					and (ni.unit.buff(ally, spells.Rejuvenation) or ni.unit.buff(ally, spells.WildGrowth))
					and ni.spell.valid(ally, spells.Nourish, false, true, true) then
						ni.spell.cast(spells.Nourish, ally)
						return true;
					end
				end
			end
		end
	end,
-----------------------------------	
	["Wild Growth"] = function()
		local value, enabled = GetSetting("growth");
		if enabled then
			if UsableSilence(spells.WildGrowth) then 
				local allyOne = ni.members[1].unit;
				local ally = ni.members.inrangewithoutbuffbelow(allyOne, 14, spells.WildGrowth, value);
				if #ally >= 3	 
				and ni.members[1].hp <= value
				and ni.spell.valid(allyOne, spells.WildGrowth, false, true, true) then
					ni.spell.cast(spells.WildGrowth, allyOne)
					return true;
				end
			end
		end
	end,
};
	ni.bootstrap.profile("Free_Restoration_DarhangeR", queue, abilities, OnLoad, OnUnLoad);
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
    ni.bootstrap.profile("Free_Restoration_DarhangeR", queue, abilities);
end;