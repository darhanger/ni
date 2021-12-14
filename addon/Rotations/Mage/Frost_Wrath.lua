local queue = {
	"Pause",
	"FrostArmor",
	"ArcaneIntellect",
	"Blizzard",
	"Frostbolt",
	"Fireball"
}
local enables = {
	["Blizzard"] = true,
}
local values = {
	["Blizzard"] = 3,
}
local inputs = {
}
local menus = {
}
local function GUICallback(key, item_type, value)
	if item_type == "enabled" then
		enables[key] = value;
	elseif item_type == "value" then
		values[key] = value;
	elseif item_type == "input" then
		inputs[key] = value;
	elseif item_type == "menu" then
		menus[key] = value;
	end
end
local items = {
	settingsfile = "FrostWrath.xml",
	callback = GUICallback,
	{ type = "title", text = "Frost Wrath" },
	{
		type = "entry",
		text = "Blizzard",
		tooltip = "Blizzard AoE Count",
		enabled = enables["Blizzard"],
		value = values["Blizzard"],
		key = "Blizzard"
	},
};
local incombat = false;
local function CombatEventCatcher(event, ...)
	if event == "PLAYER_REGEN_DISABLED" then
		incombat = true;
	elseif event == "PLAYER_REGEN_ENABLED" then
		incombat = false;
	end
end
local function OnLoad()
	ni.combatlog.registerhandler("FrostWrath", CombatEventCatcher);
	ni.GUI.AddFrame("FrostWrath", items);
end
local function OnUnload()
	ni.combatlog.unregisterhandler("FrostWrath");
	ni.GUI.DestroyFrame("FrostWrath");
end

local spells = {
--General
Shoot = {id = 5019, name = GetSpellInfo(5019)},
ArcaneTorrent = {id = 28730, name = GetSpellInfo(28730)},
AutoAttack = {id = 6603, name = GetSpellInfo(6603)},
--Arcane
ArcaneIntellect = {id = 1459, name = GetSpellInfo(1459)},
ConjureWater = {id = 5504, name = GetSpellInfo(5504)},
--Fire
Fireball = {id = 133, name = GetSpellInfo(133)},
--Frost
Frostbolt = {id = 116, name = GetSpellInfo(116)},
FrostArmor = {id = 168, name = GetSpellInfo(168)},
}

local function FacingLosCast(spell, tar)
	if ni.player.isfacing(tar, 145) and ni.player.los(tar) and IsSpellInRange(spell, tar) == 1 then
		ni.spell.cast(spell, tar)
		ni.debug.log(spell)
		return true
	end
	return false
end

local function ValidUsable(id, tar)
	if ni.spell.available(id) and ni.spell.valid(tar, id, true, true) then
		return true
	end
	return false
end


local abilities = {
	["FrostArmor"]= function()
		if not ni.player.buff(spells.FrostArmor.name)
		and ni.spell.available(spells.FrostArmor.name) then
			ni.spell.cast(spells.FrostArmor.name)
			return true
			end
	end,
	["ArcaneIntellect"]= function()
		if not ni.player.buff(spells.ArcaneIntellect.name)
		and ni.spell.available(spells.ArcaneIntellect.name) then
			ni.spell.cast(spells.ArcaneIntellect.name)
			return true
			end
	end,
	["Pause"] = function()
		if IsMounted()
			or UnitIsDeadOrGhost("player")
			or not UnitExists("target")
			or UnitIsDeadOrGhost("target")
			or (UnitExists("target") and not UnitCanAttack("player", "target")) then
			return true
		end
	end,
	["Blizzard"] = function()
		if enables["Blizzard"]
		and incombat
		and IsSpellInRange(spells.Frostbolt.name, "target") == 1
		and not ni.player.ismoving()
		and ni.player.los("target") then
			local nearby = #ni.unit.enemiesinrange("target", 8)
			local n = UnitChannelInfo("player")
			if n ~= nil and n == spells.Blizzard.name
			and nearby >= values["Blizzard"] then
				return true
				end
			if ni.spell.available(spells.Blizzard.name)
			and nearby >= values["Blizzard"] then
				ni.spell.castat(spells.Blizzard.name, "target", 1)
				return true
				end
		end
	end,
	["Frostbolt"] = function()
		if ValidUsable(spells.Frostbolt.name, "target")
		and not ni.player.ismoving()
		and FacingLosCast(spells.Frostbolt.name, "target") then
			return true
		end
	end,
	["Fireball"] = function()
		if ValidUsable(spells.Fireball.name, "target")
		and not ni.player.ismoving()
		and FacingLosCast(spells.Fireball.name, "target") then
			return true
		end
	end,
}
ni.bootstrap.profile("Frost_Wrath", queue, abilities, OnLoad, OnUnload);
