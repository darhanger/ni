local queue = {
	"Pause",
	"Cache",
	"BladeFlurry",
	"SliceandDice",
	"Eviscerate",
	"RevealingStrike",
	"SinisterStrike"
}
local IsSpellInRange, IsMounted, UnitIsDeadOrGhost, UnitExists, UnitCanAttack, IsUsableSpell, CancelUnitBuff =
	IsSpellInRange,
	IsMounted,
	UnitIsDeadOrGhost,
	UnitExists,
	UnitCanAttack,
	IsUsableSpell,
	CancelUnitBuff

local spells = {
	--build == 40300
	--General icon = select(2, GetSpellTabInfo(1))
	ArmorSkills = {id = 76273, name = GetSpellInfo(76273), icon = select(3, GetSpellInfo(76273))},
	AutoAttack = {id = 6603, name = GetSpellInfo(6603), icon = select(3, GetSpellInfo(6603))},
	AxeSpecialization = {id = 20574, name = GetSpellInfo(20574), icon = select(3, GetSpellInfo(20574))},
	BloodFury = {id = 20572, name = GetSpellInfo(20572), icon = select(3, GetSpellInfo(20572))},
	Command = {id = 21563, name = GetSpellInfo(21563), icon = select(3, GetSpellInfo(21563))},
	DualWield = {id = 674, name = GetSpellInfo(674), icon = select(3, GetSpellInfo(674))},
	Hardiness = {id = 20573, name = GetSpellInfo(20573), icon = select(3, GetSpellInfo(20573))},
	Languages = {id = 79743, name = GetSpellInfo(79743), icon = select(3, GetSpellInfo(79743))},
	Shoot = {id = 3018, name = GetSpellInfo(3018), icon = select(3, GetSpellInfo(3018))},
	Throw = {id = 2764, name = GetSpellInfo(2764), icon = select(3, GetSpellInfo(2764))},
	WeaponSkills = {id = 76297, name = GetSpellInfo(76297), icon = select(3, GetSpellInfo(76297))},
	ApprenticeRiding = {id = 33388, name = GetSpellInfo(33388), icon = select(3, GetSpellInfo(33388))},
	JourneymanRiding = {id = 33391, name = GetSpellInfo(33391), icon = select(3, GetSpellInfo(33391))},
	LeatherSpecialization = {id = 86531, name = GetSpellInfo(86531), icon = select(3, GetSpellInfo(86531))},
	ExpertRiding = {id = 34090, name = GetSpellInfo(34090), icon = select(3, GetSpellInfo(34090))},
	FlightMastersLicense = {id = 90267, name = GetSpellInfo(90267), icon = select(3, GetSpellInfo(90267))},
	ColdWeatherFlying = {id = 54197, name = GetSpellInfo(54197), icon = select(3, GetSpellInfo(54197))},
	ArtisanRiding = {id = 34091, name = GetSpellInfo(34091), icon = select(3, GetSpellInfo(34091))},
	MasterRiding = {id = 90265, name = GetSpellInfo(90265), icon = select(3, GetSpellInfo(90265))},
	Mastery = {id = 86476, name = GetSpellInfo(86476), icon = select(3, GetSpellInfo(86476))},
	--Assassination icon = select(2, GetSpellTabInfo(2))
	Poisons = {id = 2842, name = GetSpellInfo(2842), icon = select(3, GetSpellInfo(2842))},
	Eviscerate = {id = 2098, name = GetSpellInfo(2098), icon = select(3, GetSpellInfo(2098))},
	Ambush = {id = 8676, name = GetSpellInfo(8676), icon = select(3, GetSpellInfo(8676))},
	SliceandDice = {id = 5171, name = GetSpellInfo(5171), icon = select(3, GetSpellInfo(5171))},
	CheapShot = {id = 1833, name = GetSpellInfo(1833), icon = select(3, GetSpellInfo(1833))},
	KidneyShot = {id = 408, name = GetSpellInfo(408), icon = select(3, GetSpellInfo(408))},
	ExposeArmor = {id = 8647, name = GetSpellInfo(8647), icon = select(3, GetSpellInfo(8647))},
	Dismantle = {id = 51722, name = GetSpellInfo(51722), icon = select(3, GetSpellInfo(51722))},
	Garrote = {id = 703, name = GetSpellInfo(703), icon = select(3, GetSpellInfo(703))},
	Rupture = {id = 1943, name = GetSpellInfo(1943), icon = select(3, GetSpellInfo(1943))},
	Envenom = {id = 32645, name = GetSpellInfo(32645), icon = select(3, GetSpellInfo(32645))},
	DeadlyThrow = {id = 26679, name = GetSpellInfo(26679), icon = select(3, GetSpellInfo(26679))},
	--Combat icon = select(2, GetSpellTabInfo(3))
	SinisterStrike = {id = 1752, name = GetSpellInfo(1752), icon = select(3, GetSpellInfo(1752))},
	Evasion = {id = 5277, name = GetSpellInfo(5277), icon = select(3, GetSpellInfo(5277))},
	Parry = {id = 82245, name = GetSpellInfo(82245), icon = select(3, GetSpellInfo(82245))},
	Recuperate = {id = 73651, name = GetSpellInfo(73651), icon = select(3, GetSpellInfo(73651))},
	Kick = {id = 1766, name = GetSpellInfo(1766), icon = select(3, GetSpellInfo(1766))},
	Gouge = {id = 1776, name = GetSpellInfo(1776), icon = select(3, GetSpellInfo(1776))},
	Sprint = {id = 2983, name = GetSpellInfo(2983), icon = select(3, GetSpellInfo(2983))},
	Backstab = {id = 53, name = GetSpellInfo(53), icon = select(3, GetSpellInfo(53))},
	Feint = {id = 1966, name = GetSpellInfo(1966), icon = select(3, GetSpellInfo(1966))},
	Shiv = {id = 5938, name = GetSpellInfo(5938), icon = select(3, GetSpellInfo(5938))},
	FanofKnives = {id = 51723, name = GetSpellInfo(51723), icon = select(3, GetSpellInfo(51723))},
	CombatReadiness = {id = 74001, name = GetSpellInfo(74001), icon = select(3, GetSpellInfo(74001))},
	RevealingStrike = {id = 84617, name = GetSpellInfo(84617), icon = select(3, GetSpellInfo(84617))},
	BladeFlurry = {id = 13877, name = GetSpellInfo(13877), icon = select(3, GetSpellInfo(13877))},
	--Subtlety icon = select(2, GetSpellTabInfo(4))
	Stealth = {id = 1784, name = GetSpellInfo(1784), icon = select(3, GetSpellInfo(1784))},
	PickPocket = {id = 921, name = GetSpellInfo(921), icon = select(3, GetSpellInfo(921))},
	Sap = {id = 6770, name = GetSpellInfo(6770), icon = select(3, GetSpellInfo(6770))},
	PickLock = {id = 1804, name = GetSpellInfo(1804), icon = select(3, GetSpellInfo(1804))},
	Vanish = {id = 1856, name = GetSpellInfo(1856), icon = select(3, GetSpellInfo(1856))},
	Distract = {id = 1725, name = GetSpellInfo(1725), icon = select(3, GetSpellInfo(1725))},
	DetectTraps = {id = 2836, name = GetSpellInfo(2836), icon = select(3, GetSpellInfo(2836))},
	Blind = {id = 2094, name = GetSpellInfo(2094), icon = select(3, GetSpellInfo(2094))},
	DisarmTrap = {id = 1842, name = GetSpellInfo(1842), icon = select(3, GetSpellInfo(1842))},
	SafeFall = {id = 1860, name = GetSpellInfo(1860), icon = select(3, GetSpellInfo(1860))},
	CloakofShadows = {id = 31224, name = GetSpellInfo(31224), icon = select(3, GetSpellInfo(31224))},
	TricksoftheTrade = {id = 57934, name = GetSpellInfo(57934), icon = select(3, GetSpellInfo(57934))},
	Redirect = {id = 73981, name = GetSpellInfo(73981), icon = select(3, GetSpellInfo(73981))},
	SmokeBomb = {id = 76577, name = GetSpellInfo(76577), icon = select(3, GetSpellInfo(76577))}
}

local enables = {}
local values = {
	["Eviscerate"] = 5
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
	settingsfile = "combat_cata.xml",
	callback = GUICallback,
	{type = "title", text = "\124T" .. select(2, GetSpellTabInfo(3)) .. ":20:20\124t Combat Rouge Cata"},
	{type = "separator"},
	{
		type = "entry",
		text = "\124T" .. spells.Eviscerate.icon .. ":20:20\124t " .. spells.Eviscerate.name,
		tooltip = "Use " .. spells.Eviscerate.name,
		value = values["Eviscerate"],
		key = "Eviscerate"
	}
}
local incombat = false
local function CombatEventCatcher(event, ...)
	if event == "PLAYER_REGEN_DISABLED" then
		incombat = true
	elseif event == "PLAYER_REGEN_ENABLED" then
		incombat = false
	end
end
local function OnLoad()
	ni.combatlog.registerhandler("combat-Cata", CombatEventCatcher)
	ni.GUI.AddFrame("combat-Cata", items)
end
local function OnUnload()
	ni.combatlog.unregisterhandler("combat-Cata")
	ni.GUI.DestroyFrame("combat-Cata")
end

local enemies = {}

local function ActiveEnemies()
	table.wipe(enemies)
	enemies = ni.player.enemiesinrange(10)
	for k, v in ipairs(enemies) do
		if ni.player.threat(v.guid) == -1 then
			table.remove(enemies, k)
		end
	end
	return #enemies
end

local function FacingLosCast(spell, tar)
	if ni.player.isfacing(tar, 145) and ni.player.los(tar) and IsSpellInRange(spell, tar) == 1 then
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

local t, p = "target", "player"

local cache = {
	energy = 0,
	combatpoints = GetComboPoints(p, t),
	aoe = ActiveEnemies()
}

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
		cache.energy = ni.player.powerraw("energy")
		cache.combatpoints = GetComboPoints(p, t)
	end,
	["SinisterStrike"] = function()
		if ValidUsable(spells.SinisterStrike.id, t) and FacingLosCast(spells.SinisterStrike.name, t) then
			return true
		end
	end,
	["Eviscerate"] = function()
		if
			cache.combatpoints >= values["Eviscerate"] and ValidUsable(spells.Eviscerate.id, t) and
				FacingLosCast(spells.Eviscerate.name, t)
		 then
			return true
		end
	end,
	["SliceandDice"] = function()
		if
			cache.combatpoints == 5 and ni.spell.available(spells.SliceandDice.id) and
				ni.player.buffremaining(spells.SliceandDice.name) < 5
		 then
			ni.spell.cast(spells.SliceandDice.name)
			return true
		end
	end,
	["RevealingStrike"] = function()
		if
			cache.combatpoints == 4 and ValidUsable(spells.RevealingStrike.id, t) and
				ni.player.buffremaining(spells.SliceandDice.name) > 5 and
				FacingLosCast(spells.RevealingStrike.name, t)
		 then
			return true
		end
	end,
	["BladeFlurry"] = function()
		if cache.aoe > 2 and not ni.player.buff(spells.BladeFlurry.name) and ni.spell.available(spells.BladeFlurry.name) then
			ni.spell.cast(spells.BladeFlurry.name)
			return true
		end
		if cache.aoe < 2 and ni.player.buff(spells.BladeFlurry.name) then
			CancelUnitBuff(p, spells.BladeFlurry.name)
			return true
		end
	end
}
ni.bootstrap.profile("Combat - Cata", queue, abilities, OnLoad, OnUnload)
