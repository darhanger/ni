local queue = {
	"Pause",
	"Cache",
	--cat
	"RavageCat",
	"MangleCatDebuff",
	"RipCat",
	"SavageRoarCat",
	"FerociousBiteCat",
	"RakeCat",
	"ShredCat",
	"MangleCat",
	"ClawCat",
	--bear
	"MangleBear",
	"ThrashBear",
	"SwipeBear",
	"LacerateBear",
	"Pulverize",
	"LacerateBear3",
	"MaulBear",
	"LacerateBearFiller",
	--No Form
	"Moonfire",
	"Wrath",
	"AutoAttack"
}

local IsSpellInRange,
	IsCurrentSpell,
	IsMounted,
	UnitIsDeadOrGhost,
	UnitExists,
	UnitCanAttack,
	GetShapeshiftFormID,
	IsSpellKnown,
	IsUsableSpell =
	IsSpellInRange,
	IsCurrentSpell,
	IsMounted,
	UnitIsDeadOrGhost,
	UnitExists,
	UnitCanAttack,
	GetShapeshiftFormID,
	IsSpellKnown,
	IsUsableSpell

local spells = {
	--build == 40300
	--General icon = select(2, GetSpellTabInfo(1))
	ArmorSkills = {id = 76275, name = GetSpellInfo(76275), icon = select(3, GetSpellInfo(76275))},
	AutoAttack = {id = 6603, name = GetSpellInfo(6603), icon = select(3, GetSpellInfo(6603))},
	Cultivation = {id = 20552, name = GetSpellInfo(20552), icon = select(3, GetSpellInfo(20552))},
	Endurance = {id = 20550, name = GetSpellInfo(20550), icon = select(3, GetSpellInfo(20550))},
	Languages = {id = 79746, name = GetSpellInfo(79746), icon = select(3, GetSpellInfo(79746))},
	NatureResistance = {id = 20551, name = GetSpellInfo(20551), icon = select(3, GetSpellInfo(20551))},
	WarStomp = {id = 20549, name = GetSpellInfo(20549), icon = select(3, GetSpellInfo(20549))},
	WeaponSkills = {id = 76300, name = GetSpellInfo(76300), icon = select(3, GetSpellInfo(76300))},
	ApprenticeRiding = {id = 33388, name = GetSpellInfo(33388), icon = select(3, GetSpellInfo(33388))},
	JourneymanRiding = {id = 33391, name = GetSpellInfo(33391), icon = select(3, GetSpellInfo(33391))},
	LeatherSpecialization = {id = 86530, name = GetSpellInfo(86530), icon = select(3, GetSpellInfo(86530))},
	ExpertRiding = {id = 34090, name = GetSpellInfo(34090), icon = select(3, GetSpellInfo(34090))},
	FlightMastersLicense = {id = 90267, name = GetSpellInfo(90267), icon = select(3, GetSpellInfo(90267))},
	ColdWeatherFlying = {id = 54197, name = GetSpellInfo(54197), icon = select(3, GetSpellInfo(54197))},
	ArtisanRiding = {id = 34091, name = GetSpellInfo(34091), icon = select(3, GetSpellInfo(34091))},
	MasterRiding = {id = 90265, name = GetSpellInfo(90265), icon = select(3, GetSpellInfo(90265))},
	Mastery = {id = 86470, name = GetSpellInfo(86470), icon = select(3, GetSpellInfo(86470))},
	--Balance icon = select(2, GetSpellTabInfo(2))
	Moonfire = {id = 8921, name = GetSpellInfo(8921), icon = select(3, GetSpellInfo(8921))},
	Thorns = {id = 467, name = GetSpellInfo(467), icon = select(3, GetSpellInfo(467))},
	Wrath = {id = 5176, name = GetSpellInfo(5176), icon = select(3, GetSpellInfo(5176))},
	EntanglingRoots = {id = 339, name = GetSpellInfo(339), icon = select(3, GetSpellInfo(339))},
	Starfire = {id = 2912, name = GetSpellInfo(2912), icon = select(3, GetSpellInfo(2912))},
	TeleportMoonglade = {id = 18960, name = GetSpellInfo(18960), icon = select(3, GetSpellInfo(18960))},
	InsectSwarm = {id = 5570, name = GetSpellInfo(5570), icon = select(3, GetSpellInfo(5570))},
	FaerieFire = {id = 770, name = GetSpellInfo(770), icon = select(3, GetSpellInfo(770))},
	Innervate = {id = 29166, name = GetSpellInfo(29166), icon = select(3, GetSpellInfo(29166))},
	Soothe = {id = 2908, name = GetSpellInfo(2908), icon = select(3, GetSpellInfo(2908))},
	Hurricane = {id = 16914, name = GetSpellInfo(16914), icon = select(3, GetSpellInfo(16914))},
	Hibernate = {id = 2637, name = GetSpellInfo(2637), icon = select(3, GetSpellInfo(2637))},
	NaturesGrasp = {id = 16689, name = GetSpellInfo(16689), icon = select(3, GetSpellInfo(16689))},
	Barkskin = {id = 22812, name = GetSpellInfo(22812), icon = select(3, GetSpellInfo(22812))},
	Cyclone = {id = 33786, name = GetSpellInfo(33786), icon = select(3, GetSpellInfo(33786))},
	WildMushroom = {id = 88747, name = GetSpellInfo(88747), icon = select(3, GetSpellInfo(88747))},
	WildMushroomDetonate = {id = 88751, name = GetSpellInfo(88751), icon = select(3, GetSpellInfo(88751))},
	--Feral icon = select(2, GetSpellTabInfo(3))
	Aggression = {id = 84735, name = GetSpellInfo(84735), icon = select(3, GetSpellInfo(84735))},
	CatForm = {id = 768, name = GetSpellInfo(768), icon = select(3, GetSpellInfo(768))},
	ClawCat = {id = 1082, name = GetSpellInfo(1082), icon = select(3, GetSpellInfo(1082))},
	FeralInstinct = {id = 87335, name = GetSpellInfo(87335), icon = select(3, GetSpellInfo(87335))},
	FerociousBiteCat = {id = 22568, name = GetSpellInfo(22568), icon = select(3, GetSpellInfo(22568))},
	MangleBear = {id = 33878, name = GetSpellInfo(33878), icon = select(3, GetSpellInfo(33878))},
	MangleCat = {id = 33876, name = GetSpellInfo(33876), icon = select(3, GetSpellInfo(33876))},
	RakeCat = {id = 1822, name = GetSpellInfo(1822), icon = select(3, GetSpellInfo(1822))},
	Vengeance = {id = 84840, name = GetSpellInfo(84840), icon = select(3, GetSpellInfo(84840))},
	ProwlCat = {id = 5215, name = GetSpellInfo(5215), icon = select(3, GetSpellInfo(5215))},
	BearForm = {id = 5487, name = GetSpellInfo(5487), icon = select(3, GetSpellInfo(5487))},
	DemoralizingRoarBear = {id = 99, name = GetSpellInfo(99), icon = select(3, GetSpellInfo(99))},
	GrowlBear = {id = 6795, name = GetSpellInfo(6795), icon = select(3, GetSpellInfo(6795))},
	MaulBear = {id = 6807, name = GetSpellInfo(6807), icon = select(3, GetSpellInfo(6807))},
	AquaticForm = {id = 1066, name = GetSpellInfo(1066), icon = select(3, GetSpellInfo(1066))},
	TravelForm = {id = 783, name = GetSpellInfo(783), icon = select(3, GetSpellInfo(783))},
	SwipeBear = {id = 779, name = GetSpellInfo(779), icon = select(3, GetSpellInfo(779))},
	EnrageBear = {id = 5229, name = GetSpellInfo(5229), icon = select(3, GetSpellInfo(5229))},
	RavageCat = {id = 6785, name = GetSpellInfo(6785), icon = select(3, GetSpellInfo(6785))},
	SkullBashCat = {id = 80965, name = GetSpellInfo(80965), icon = select(3, GetSpellInfo(80965))},
	SkullBashBear = {id = 80964, name = GetSpellInfo(80964), icon = select(3, GetSpellInfo(80964))},
	FaerieFireFeral = {id = 16857, name = GetSpellInfo(16857), icon = select(3, GetSpellInfo(16857))},
	TigersFuryCat = {id = 5217, name = GetSpellInfo(5217), icon = select(3, GetSpellInfo(5217))},
	CowerCat = {id = 8998, name = GetSpellInfo(8998), icon = select(3, GetSpellInfo(8998))},
	DashCat = {id = 1850, name = GetSpellInfo(1850), icon = select(3, GetSpellInfo(1850))},
	FelineGrace = {id = 20719, name = GetSpellInfo(20719), icon = select(3, GetSpellInfo(20719))},
	ChallengingRoarBear = {id = 5209, name = GetSpellInfo(5209), icon = select(3, GetSpellInfo(5209))},
	BashBear = {id = 5211, name = GetSpellInfo(5211), icon = select(3, GetSpellInfo(5211))},
	PounceCat = {id = 9005, name = GetSpellInfo(9005), icon = select(3, GetSpellInfo(9005))},
	SwipeCat = {id = 62078, name = GetSpellInfo(62078), icon = select(3, GetSpellInfo(62078))},
	SavageDefense = {id = 62600, name = GetSpellInfo(62600), icon = select(3, GetSpellInfo(62600))},
	ShredCat = {id = 5221, name = GetSpellInfo(5221), icon = select(3, GetSpellInfo(5221))},
	FrenziedRegenerationBear = {id = 22842, name = GetSpellInfo(22842), icon = select(3, GetSpellInfo(22842))},
	RipCat = {id = 1079, name = GetSpellInfo(1079), icon = select(3, GetSpellInfo(1079))},
	FlightForm = {id = 33943, name = GetSpellInfo(33943), icon = select(3, GetSpellInfo(33943))},
	MaimCat = {id = 22570, name = GetSpellInfo(22570), icon = select(3, GetSpellInfo(22570))},
	LacerateBear = {id = 33745, name = GetSpellInfo(33745), icon = select(3, GetSpellInfo(33745))},
	SwiftFlightForm = {id = 40120, name = GetSpellInfo(40120), icon = select(3, GetSpellInfo(40120))},
	SavageRoarCat = {id = 52610, name = GetSpellInfo(52610), icon = select(3, GetSpellInfo(52610))},
	ThrashBear = {id = 77758, name = GetSpellInfo(77758), icon = select(3, GetSpellInfo(77758))},
	Pulverize = {id = 80313, name = GetSpellInfo(80313), icon = select(3, GetSpellInfo(80313))},
	StampedingRoarCat = {id = 77764, name = GetSpellInfo(77764), icon = select(3, GetSpellInfo(77764))},
	StampedingRoarBear = {id = 77761, name = GetSpellInfo(77761), icon = select(3, GetSpellInfo(77761))},
	--Restoration icon = select(2, GetSpellTabInfo(4))
	Rejuvenation = {id = 774, name = GetSpellInfo(774), icon = select(3, GetSpellInfo(774))},
	Nourish = {id = 50464, name = GetSpellInfo(50464), icon = select(3, GetSpellInfo(50464))},
	Regrowth = {id = 8936, name = GetSpellInfo(8936), icon = select(3, GetSpellInfo(8936))},
	Revive = {id = 50769, name = GetSpellInfo(50769), icon = select(3, GetSpellInfo(50769))},
	OmenofClarity = {id = 16864, name = GetSpellInfo(16864), icon = select(3, GetSpellInfo(16864))},
	Rebirth = {id = 20484, name = GetSpellInfo(20484), icon = select(3, GetSpellInfo(20484))},
	RemoveCorruption = {id = 2782, name = GetSpellInfo(2782), icon = select(3, GetSpellInfo(2782))},
	MarkoftheWild = {id = 1126, name = GetSpellInfo(1126), icon = select(3, GetSpellInfo(1126))},
	Lifebloom = {id = 33763, name = GetSpellInfo(33763), icon = select(3, GetSpellInfo(33763))},
	Tranquility = {id = 740, name = GetSpellInfo(740), icon = select(3, GetSpellInfo(740))},
	HealingTouch = {id = 5185, name = GetSpellInfo(5185), icon = select(3, GetSpellInfo(5185))}
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
	settingsfile = "Feral_cata.xml",
	callback = GUICallback,
	{type = "title", text = "\124T" .. select(2, GetSpellTabInfo(3)) .. ":20:20\124t " .. GetSpellTabInfo(3)},
	{type = "separator"}
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
	ni.combatlog.registerhandler("f-Cata", CombatEventCatcher)
	ni.GUI.AddFrame("f-Cata", items)
end
local function OnUnload()
	ni.combatlog.unregisterhandler("f-Cata")
	ni.GUI.DestroyFrame("f-Cata")
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
	if ni.spell.available(id) and ni.spell.valid(tar, id, true, true) and IsUsableSpell(id) then
		return true
	end
	return false
end

local t, p = "target", "player"

local cache = {
	energy = 0,
	combatpoints = GetComboPoints(p, t),
	rage = 0,
	form = GetShapeshiftFormID() or 0,
	behind = false,
	aoecount = 0
}

local ss = {
	none = 0,
	cat = 1,
	bear = 5
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
		cache.rage = ni.player.powerraw("rage")
		cache.combatpoints = GetComboPoints(p, t)
		cache.form = GetShapeshiftFormID() or 0
		cache.behind = ni.unit.isbehind("player", "target")
		cache.aoecount = ActiveEnemies()
	end,
	--#region Cat
	["RakeCat"] = function()
		if
			cache.form == ss.cat and ValidUsable(spells.RakeCat.id, t) and ni.unit.debuffremaining(t, spells.RakeCat.id, p) < 2 and
				FacingLosCast(spells.RakeCat.name, t)
		 then
			return true
		end
	end,
	["MangleCat"] = function()
		if
			cache.form == ss.cat and cache.combatpoints < 5 and ValidUsable(spells.MangleCat.id, t) and
				FacingLosCast(spells.MangleCat.name, t)
		 then
			return true
		end
	end,
	["ShredCat"] = function()
		if
			cache.form == ss.cat and cache.combatpoints < 5 and cache.behind and ValidUsable(spells.ShredCat.id, t) and
				FacingLosCast(spells.ShredCat.name, t)
		 then
			return true
		end
	end,
	["MangleCatDebuff"] = function()
		if
			cache.form == ss.cat and ni.unit.debuffremaining(t, spells.MangleCat.name) < 2 and
				ValidUsable(spells.MangleCat.id, t) and
				FacingLosCast(spells.MangleCat.name, t)
		 then
			return true
		end
	end,
	["ClawCat"] = function()
		if
			cache.form == ss.cat and not IsSpellKnown(spells.MangleCat.id) and cache.combatpoints < 5 and
				ValidUsable(spells.ClawCat.id, t) and
				FacingLosCast(spells.ClawCat.name, t)
		 then
			return true
		end
	end,
	["FerociousBiteCat"] = function()
		if
			cache.form == ss.cat and cache.combatpoints == 5 and ValidUsable(spells.FerociousBiteCat.id, t) and
				FacingLosCast(spells.FerociousBiteCat.name, t)
		 then
			return true
		end
	end,
	["SavageRoarCat"] = function()
		if
			cache.form == ss.cat and cache.combatpoints == 5 and ni.player.buffremaining(spells.SavageRoarCat.name) < 5 and
				ValidUsable(spells.SavageRoarCat.id, t) and
				FacingLosCast(spells.SavageRoarCat.name, t)
		 then
			return true
		end
	end,
	["RipCat"] = function()
		if
			cache.form == ss.cat and cache.combatpoints == 5 and ValidUsable(spells.RipCat.id, t) and
				FacingLosCast(spells.RipCat.name, t)
		 then
			return true
		end
	end,
	["RavageCat"] = function()
		if
			cache.form == ss.cat and cache.combatpoints < 5 and cache.behind and ValidUsable(spells.RavageCat.id, t) and
				FacingLosCast(spells.RavageCat.name, t)
		 then
			return true
		end
	end,
	["SwipeCat"] = function()
		if
			cache.form == ss.cat and cache.combatpoints < 5 and cache.aoecount > 3 and ValidUsable(spells.SwipeCat.id, t) and
				FacingLosCast(spells.SwipeCat.name, t)
		 then
			return true
		end
	end,
	--#region Bear
	["MangleBear"] = function()
		if cache.form == ss.bear and ValidUsable(spells.MangleBear.id, t) and FacingLosCast(spells.MangleBear.name, t) then
			return true
		end
	end,
	["MaulBear"] = function()
		if cache.form == ss.bear and ValidUsable(spells.MaulBear.id, t) and cache.rage > 70 and FacingLosCast(spells.MaulBear.name, t) then
			return true
		end
	end,
	["LacerateBear"] = function()
		if
			cache.form == ss.bear and ni.unit.debuffremaining(t, spells.LacerateBear.id, p) < 2 and
				ValidUsable(spells.LacerateBear.id, t) and
				FacingLosCast(spells.LacerateBear.name, t)
		 then
			return true
		end
	end,
	["LacerateBear3"] = function()
		if
			cache.form == ss.bear and ni.unit.debuffstacks(t, spells.LacerateBear.id, p) < 3 and
				ValidUsable(spells.LacerateBear.id, t) and
				FacingLosCast(spells.LacerateBear.name, t)
		 then
			return true
		end
	end,
	["LacerateBearFiller"] = function()
		if cache.form == ss.bear and ValidUsable(spells.LacerateBear.id, t) and FacingLosCast(spells.LacerateBear.name, t) then
			return true
		end
	end,
	["Pulverize"] = function()
		if
			cache.form == ss.bear and ni.unit.debuffstacks(t, spells.LacerateBear.id, p) > 2 and
				ValidUsable(spells.Pulverize.id, t) and
				FacingLosCast(spells.Pulverize.name, t)
		 then
			return true
		end
	end,
	["ThrashBear"] = function()
		if cache.form == ss.bear and ValidUsable(spells.ThrashBear.id, t) and FacingLosCast(spells.ThrashBear.name, t) then
			return true
		end
	end,
	["SwipeBear"] = function()
		if
			cache.form == ss.bear and cache.aoecount > 3 and ValidUsable(spells.SwipeBear.id, t) and
				FacingLosCast(spells.SwipeBear.name, t)
		 then
			return true
		end
	end,
	--#endregion
	--#region No Forms
	["Wrath"] = function()
		if cache.form == ss.none and ValidUsable(spells.Wrath.id, t) and FacingLosCast(spells.Wrath.name, t) then
			return true
		end
	end,
	["Moonfire"] = function()
		if
			cache.form == ss.none and ValidUsable(spells.Moonfire.id, t) and
				ni.unit.debuffremaining(t, spells.Moonfire.id, p) < 2 and
				FacingLosCast(spells.Moonfire.name, t)
		 then
			return true
		end
	end,
	--#endregion
	["AutoAttack"] = function()
		if not IsCurrentSpell(spells.AutoAttack.id) and ni.unit.inmelee(p, t) and incombat then
			ni.spell.cast(spells.AutoAttack.name)
		end
	end
}
ni.bootstrap.profile("Feral - Cata", queue, abilities, OnLoad, OnUnload)
