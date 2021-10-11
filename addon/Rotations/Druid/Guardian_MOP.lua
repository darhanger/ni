local queue = {
	"Pause",
	"Cache",
	"Rake",
	"FerociousBite",
	"Mangle",
	"Thrash",
	"Swipe",
	"Maul",
	"FaerieFire",
	"Lacerate"
}
local enables = {}
local values = {}
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
	settingsfile = "guardian_mop.xml",
	callback = GUICallback,
	{type = "title", text = "Guardian Druid MoP"}
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
	ni.combatlog.registerhandler("GuardianMoP", CombatEventCatcher)
	ni.GUI.AddFrame("GuardianMoP", items)
end
local function OnUnload()
	ni.combatlog.unregisterhandler("GuardianMoP")
	ni.GUI.DestroyFrame("GuardianMoP")
end

local spells = {
	--Guardian
	BearForm = {id = 5487, name = GetSpellInfo(5487)},
	CatForm = {id = 768, name = GetSpellInfo(768)},
	EntanglingRoots = {id = 339, name = GetSpellInfo(339)},
	FerociousBite = {id = 22568, name = GetSpellInfo(22568)},
	Growl = {id = 6795, name = GetSpellInfo(6795)},
	Mangle = {id = 33917, name = GetSpellInfo(33917)},
	Maul = {id = 6807, name = GetSpellInfo(6807)},
	Moonfire = {id = 8921, name = GetSpellInfo(8921)},
	Prowl = {id = 5215, name = GetSpellInfo(5215)},
	Rake = {id = 1822, name = GetSpellInfo(1822)},
	Rejuvenation = {id = 774, name = GetSpellInfo(774)},
	Revive = {id = 50769, name = GetSpellInfo(50769)},
	SavageDefense = {id = 62606, name = GetSpellInfo(62606)},
	Wrath = {id = 5176, name = GetSpellInfo(5176)},
	FelineGrace = {id = 125972, name = GetSpellInfo(125972)},
	Vengeance = {id = 84840, name = GetSpellInfo(84840)},
	TeleportMoonglade = {id = 18960, name = GetSpellInfo(18960)},
	ThickHide = {id = 16931, name = GetSpellInfo(16931)},
	TravelForm = {id = 783, name = GetSpellInfo(783)},
	AquaticForm = {id = 1066, name = GetSpellInfo(1066)},
	BearHug = {id = 102795, name = GetSpellInfo(102795)},
	Rip = {id = 1079, name = GetSpellInfo(1079)},
	RemoveCorruption = {id = 2782, name = GetSpellInfo(2782)},
	Swipe = {id = 106785, name = GetSpellInfo(106785)},
	Dash = {id = 1850, name = GetSpellInfo(1850)},
	HealingTouch = {id = 5185, name = GetSpellInfo(5185)},
	FaerieFire = {id = 770, name = GetSpellInfo(770)},
	Thrash = {id = 106832, name = GetSpellInfo(106832)},
	PrimalFury = {id = 16961, name = GetSpellInfo(16961)},
	Pounce = {id = 9005, name = GetSpellInfo(9005)},
	ToothandClaw = {id = 135288, name = GetSpellInfo(135288)},
	NurturingInstinct = {id = 33873, name = GetSpellInfo(33873)},
	TrackHumanoids = {id = 5225, name = GetSpellInfo(5225)},
	Lacerate = {id = 33745, name = GetSpellInfo(33745)},
	InfectedWounds = {id = 48484, name = GetSpellInfo(48484)},
	Hurricane = {id = 16914, name = GetSpellInfo(16914)},
	Barkskin = {id = 22812, name = GetSpellInfo(22812)},
	LeaderofthePack = {id = 17007, name = GetSpellInfo(17007)},
	Berserk = {id = 106952, name = GetSpellInfo(106952)},
	LeatherSpecialization = {id = 86096, name = GetSpellInfo(86096)},
	NaturesGrasp = {id = 16689, name = GetSpellInfo(16689)},
	Innervate = {id = 29166, name = GetSpellInfo(29166)},
	Ravage = {id = 6785, name = GetSpellInfo(6785)},
	Rebirth = {id = 20484, name = GetSpellInfo(20484)},
	SurvivalInstincts = {id = 61336, name = GetSpellInfo(61336)},
	FlightForm = {id = 33943, name = GetSpellInfo(33943)},
	Soothe = {id = 2908, name = GetSpellInfo(2908)},
	MarkoftheWild = {id = 1126, name = GetSpellInfo(1126)},
	SkullBash = {id = 106839, name = GetSpellInfo(106839)},
	Hibernate = {id = 2637, name = GetSpellInfo(2637)},
	FrenziedRegeneration = {id = 22842, name = GetSpellInfo(22842)},
	SwiftFlightForm = {id = 40120, name = GetSpellInfo(40120)},
	MightofUrsoc = {id = 106922, name = GetSpellInfo(106922)},
	Tranquility = {id = 740, name = GetSpellInfo(740)},
	Enrage = {id = 5229, name = GetSpellInfo(5229)},
	Cyclone = {id = 33786, name = GetSpellInfo(33786)},
	MasteryNaturesGuardian = {id = 77494, name = GetSpellInfo(77494)},
	Maim = {id = 22570, name = GetSpellInfo(22570)},
	StampedingRoar = {id = 106898, name = GetSpellInfo(106898)},
	Symbiosis = {id = 110309, name = GetSpellInfo(110309)}
}

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

local function FacingLosCast(spellName, tar)
	if ni.player.isfacing(tar, 145) and ni.player.los(tar) and IsSpellInRange(spellName, tar) == 1 then
		ni.spell.cast(spellName, tar)
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

local rage = 0
local ComboPoints = 0

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
		ComboPoints = GetComboPoints("player", "target")
	end,
	["Rake"] = function ()
		if ni.player.buff(spells.CatForm.id) and
		ValidUsable(spells.Rake.name, "target")
		and ni.unit.debuffremaining("target", spells.Rake.id, "player") < 2 and
		FacingLosCast(spells.Rake.name, "target") then
			return true
		end
	end,
	["FerociousBite"] = function ()
		if ni.player.buff(spells.CatForm.id) and
		ValidUsable(spells.FerociousBite.name, "target") and
		ComboPoints == 5 and
		FacingLosCast(spells.FerociousBite.name, "target") then
			return true
		end
	end,
	["Mangle"] = function()
		if ValidUsable(spells.Mangle.name, "target") and FacingLosCast(spells.Mangle.name, "target") then
			return true
		end
	end,
	["Thrash"] = function()
		if
			ValidUsable(spells.Thrash.name, "target") and
				(ni.unit.debuffremaining("target", spells.Thrash.id, "player") < 2 or #enemies > 2) and
				FacingLosCast(spells.Thrash.name, "target")
		 then
			return true
		end
	end,
	["FaerieFire"] = function()
		if
			ValidUsable(spells.FaerieFire.name, "target") and not ni.unit.debuff("target", spells.FaerieFire.id) and
				FacingLosCast(spells.FaerieFire.name, "target")
		 then
			return true
		end
	end,
	["Maul"] = function()
		if
			ValidUsable(spells.Maul.name, "target") and (rage > 80 or ni.player.buff(spells.ToothandClaw.id)) and
				FacingLosCast(spells.Maul.name, "target")
		 then
			return true
		end
	end,
	["Lacerate"] = function()
		if ValidUsable(spells.Lacerate.name, "target") and FacingLosCast(spells.Lacerate.name, "target") then
			return true
		end
	end,
	["Swipe"] = function()
		if ValidUsable(spells.Swipe.name, "target") and #enemies > 2 and FacingLosCast(spells.Swipe.name, "target") then
			return true
		end
	end
}
ni.bootstrap.profile("Guardian_MOP", queue, abilities, OnLoad, OnUnload)
