local queue = {
	"Pause",
	"Cache",
	"AutoAttack",
	"Cleave",
	"HeroicStrike",
	"ShieldBash",
	"Revenge",
	"ThunderClap",
	"ShieldSlam",
	"Rend",
	"Devastate",
	"SunderArmor"
}
local enables = {
	["Rend"] = true,
	["HeroicStrike"] = true,
	["Cleave"] = true
}
local values = {
	["HeroicStrike"] = 60,
	["Cleave"] = 50
}
local inputs = {}
local menus = {}

local function GUICallback(key, item_type, value)
	if item_type == "enabled" then
		enables[key] = value
	elseif item_type == "value" then
		values[key] = value
	elseif item_type == "input" then
		inputs[key] = value
	elseif item_type == "menu" then
		menus[key] = value
	end
end

local items = {
	settingsfile = "prot_wrath.xml",
	callback = GUICallback,
	{type = "title", text = "Prot Wrath"},
	{type = "separator"},
	{type = "title", text = "Abilities"},
	{
		type = "entry",
		text = "Cleave",
		tooltip = "Use Cleave when above this rage pct",
		enabled = enables["Cleave"],
		value = values["Cleave"],
		key = "Cleave"
	},
	{
		type = "entry",
		text = "Heroic Strike",
		tooltip = "Use Heroic Strike when above this rage pct",
		enabled = enables["HeroicStrike"],
		value = values["HeroicStrike"],
		key = "HeroicStrike"
	},
	{
		type = "entry",
		text = "Rend",
		tooltip = "Use Rend",
		enabled = enables["Rend"],
		key = "Rend"
	}
}

local spells = {
	--General
	WarStomp = {id = 20549, name = GetSpellInfo(20549)},
	AutoAttack = {id = 6603, name = GetSpellInfo(6603)},
	--Arms
	ThunderClap = {id = 25264, name = GetSpellInfo(25264)},
	Charge = {id = 11578, name = GetSpellInfo(11578)},
	Hamstring = {id = 1715, name = GetSpellInfo(1715)},
	Rend = {id = 11574, name = GetSpellInfo(11574)},
	BattleStance = {id = 2457, name = GetSpellInfo(2457)},
	Retaliation = {id = 20230, name = GetSpellInfo(20230)},
	MockingBlow = {id = 694, name = GetSpellInfo(694)},
	Overpower = {id = 7384, name = GetSpellInfo(7384)},
	HeroicStrike = {id = 29707, name = GetSpellInfo(29707)},
	--Fury
	Recklessness = {id = 1719, name = GetSpellInfo(1719)},
	Cleave = {id = 20569, name = GetSpellInfo(20569)},
	Execute = {id = 25234, name = GetSpellInfo(25234)},
	Whirlwind = {id = 1680, name = GetSpellInfo(1680)},
	DemoralizingShout = {id = 25202, name = GetSpellInfo(25202)},
	VictoryRush = {id = 34428, name = GetSpellInfo(34428)},
	Slam = {id = 25241, name = GetSpellInfo(25241)},
	IntimidatingShout = {id = 5246, name = GetSpellInfo(5246)},
	Pummel = {id = 6552, name = GetSpellInfo(6552)},
	BerserkerRage = {id = 18499, name = GetSpellInfo(18499)},
	ChallengingShout = {id = 1161, name = GetSpellInfo(1161)},
	Intercept = {id = 20252, name = GetSpellInfo(20252)},
	BattleShout = {id = 25289, name = GetSpellInfo(25289)},
	--Protection
	ConcussionBlow = {id = 12809, name = GetSpellInfo(12809)},
	Vigilance = {id = 50720, name = GetSpellInfo(50720)},
	Taunt = {id = 355, name = GetSpellInfo(355)},
	SunderArmor = {id = 7386, name = GetSpellInfo(7386)},
	Disarm = {id = 676, name = GetSpellInfo(676)},
	SpellReflection = {id = 23920, name = GetSpellInfo(23920)},
	Shockwave = {id = 46968, name = GetSpellInfo(46968)},
	ShieldWall = {id = 871, name = GetSpellInfo(871)},
	ShieldSlam = {id = 25258, name = GetSpellInfo(25258)},
	ShieldBlock = {id = 2565, name = GetSpellInfo(2565)},
	Revenge = {id = 25269, name = GetSpellInfo(25269)},
	DefensiveStance = {id = 71, name = GetSpellInfo(71)},
	ShieldBash = {id = 72, name = GetSpellInfo(72)},
	Devastate = {id = 30016, name = GetSpellInfo(30016)},
	LastStand = {id = 12975, name = GetSpellInfo(12975)},
	Bloodrage = {id = 2687, name = GetSpellInfo(2687)}
}

local incombat = false
local playerguid = UnitGUID("player")
local revengeAvalible = false

local function CombatEventCatcher(event, ...)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local _, eventType, _, _, _, destGUID = ...
		if destGUID == playerguid and eventType == "SWING_MISSED" then
			local misstype = select(9, ...)
			if misstype == "BLOCK" or misstype == "DODGE" or misstype == "PARRY" then
				revengeAvalible = true
			end
		end
	end
	if event == "PLAYER_REGEN_DISABLED" then
		incombat = true
	elseif event == "PLAYER_REGEN_ENABLED" then
		incombat = false
	end
end

local function OnLoad()
	ni.combatlog.registerhandler("Prot-Cata", CombatEventCatcher)
	ni.GUI.AddFrame("Prot-Cata", items)
end
local function OnUnload()
	ni.combatlog.unregisterhandler("Prot-Cata")
	ni.GUI.DestroyFrame("Prot-Cata")
end

local enemies = {}
local rage = 0

local function ActiveEnemies()
	table.wipe(enemies)
	enemies = ni.player.enemiesinrange(7)
	for k, v in ipairs(enemies) do
		if ni.player.threat(v.guid) == -1 then
			table.remove(enemies, k)
		end
	end
	return #enemies
end

local function FacingLosCast(spell, tar)
	if ni.player.isfacing(tar, 145) and ni.player.los(tar) then
		ni.spell.cast(spell, tar)
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
	["Pause"] = function()
		if
			IsMounted() or UnitIsDeadOrGhost("player") or not UnitExists("target") or UnitIsDeadOrGhost("target") or
				(UnitExists("target") and not UnitCanAttack("player", "target"))
		 then
			return true
		end
	end,
	["Cache"] = function()
		ActiveEnemies()
		rage = ni.player.power("rage")
	end,
	["AutoAttack"] = function()
		if not IsCurrentSpell(spells.AutoAttack.id) then
			ni.spell.cast(spells.AutoAttack.name)
		end
	end,
	["Revenge"] = function()
		--/dump IsUsableSpell(25288)
		if
			(revengeAvalible or IsUsableSpell(spells.Revenge.id)) and ValidUsable(spells.Revenge.id, "target") and
				FacingLosCast(spells.Revenge.name, "target")
		 then
			revengeAvalible = false
			return true
		end
	end,
	["ShieldSlam"] = function()
		if ValidUsable(spells.ShieldSlam.name, "target") and FacingLosCast(spells.ShieldSlam.name, "target") then
			return true
		end
	end,
	["Rend"] = function()
		if
			enables["Rend"] and ValidUsable(spells.Rend.name, "target") and
				not ni.unit.debuff("target", spells.Rend.name, "player") and
				FacingLosCast(spells.Rend.name, "target")
		 then
			return true
		end
	end,
	["Cleave"] = function()
		if
			enables["Cleave"] and rage > values["Cleave"] and not IsCurrentSpell(spells.Cleave.id) and #enemies > 1 and
				ValidUsable(spells.Cleave.name, "target") and
				FacingLosCast(spells.Cleave.name, "target")
		 then
			return true
		end
	end,
	["SunderArmor"] = function()
		if rage > 40 and ValidUsable(spells.SunderArmor.name, "target") and FacingLosCast(spells.SunderArmor.name, "target") then
			return true
		end
	end,
	["Devastate"] = function()
		if rage > 30 and ValidUsable(spells.Devastate.name, "target") and FacingLosCast(spells.Devastate.name, "target") then
			return true
		end
	end,
	["HeroicStrike"] = function()
		if
			enables["HeroicStrike"] and rage >= values["HeroicStrike"] and not IsCurrentSpell(spells.HeroicStrike.id) and
				ValidUsable(spells.HeroicStrike.name, "target") and
				FacingLosCast(spells.HeroicStrike.name, "target")
		 then
			return true
		end
	end,
	["ThunderClap"] = function()
		if #enemies >= 2 and ni.spell.available(spells.ThunderClap.name) and rage > 20 then
			ni.spell.cast(spells.ThunderClap.name)
			return true
		end
	end,
	["ShieldBash"] = function()
		if
			ValidUsable(spells.ShieldBash.name, "target") and ni.spell.shouldinterrupt("target") and
				FacingLosCast(spells.ShieldBash.name, "target")
		 then
			return true
		end
	end
}
ni.bootstrap.profile("Prot - Wrath", queue, abilities, OnLoad, OnUnload)
