local queue = {
	"Pause",
	"Cache",
	"Seal",
	"Inquisition",
	"TemplarsVerdict",
	"CrusaderStrike",
	"TemplarsVerdictDP",
	"Exorcism",
	"HammerofWrath",
	"Judgement",
	"HolyWrath",
	"Consecration",
	"AutoAttack"
}

--Localize
local IsSpellInRange, IsCurrentSpell, IsMounted, UnitIsDeadOrGhost, UnitExists, UnitCanAttack, IsUsableSpell =
	IsSpellInRange,
	IsCurrentSpell,
	IsMounted,
	UnitIsDeadOrGhost,
	UnitExists,
	UnitCanAttack,
	IsUsableSpell

local spells = {
	--WoWBuild 40300
	--General
	AutoAttack = {id = 6603, name = GetSpellInfo(6603), icon = select(3, GetSpellInfo(6603))},
	--Holy
	HolyLight = {id = 635, name = GetSpellInfo(635), icon = select(3, GetSpellInfo(635))},
	WordofGlory = {id = 85673, name = GetSpellInfo(85673), icon = select(3, GetSpellInfo(85673))},
	Redemption = {id = 7328, name = GetSpellInfo(7328), icon = select(3, GetSpellInfo(7328))},
	FlashofLight = {id = 19750, name = GetSpellInfo(19750), icon = select(3, GetSpellInfo(19750))},
	LayonHands = {id = 633, name = GetSpellInfo(633), icon = select(3, GetSpellInfo(633))},
	Exorcism = {id = 879, name = GetSpellInfo(879), icon = select(3, GetSpellInfo(879))},
	Consecration = {id = 26573, name = GetSpellInfo(26573), icon = select(3, GetSpellInfo(26573))},
	HolyWrath = {id = 2812, name = GetSpellInfo(2812), icon = select(3, GetSpellInfo(2812))},
	SealofInsight = {id = 20165, name = GetSpellInfo(20165), icon = select(3, GetSpellInfo(20165))},
	Cleanse = {id = 4987, name = GetSpellInfo(4987), icon = select(3, GetSpellInfo(4987))},
	ConcentrationAura = {id = 19746, name = GetSpellInfo(19746), icon = select(3, GetSpellInfo(19746))},
	DivinePlea = {id = 54428, name = GetSpellInfo(54428), icon = select(3, GetSpellInfo(54428))},
	DivineLight = {id = 82326, name = GetSpellInfo(82326), icon = select(3, GetSpellInfo(82326))},
	TurnEvil = {id = 10326, name = GetSpellInfo(10326), icon = select(3, GetSpellInfo(10326))},
	HolyRadiance = {id = 82327, name = GetSpellInfo(82327), icon = select(3, GetSpellInfo(82327))},
	--Protection
	DevotionAura = {id = 465, name = GetSpellInfo(465), icon = select(3, GetSpellInfo(465))},
	Parry = {id = 82242, name = GetSpellInfo(82242), icon = select(3, GetSpellInfo(82242))},
	SealofRighteousness = {id = 20154, name = GetSpellInfo(20154), icon = select(3, GetSpellInfo(20154))},
	RighteousFury = {id = 25780, name = GetSpellInfo(25780), icon = select(3, GetSpellInfo(25780))},
	HammerofJustice = {id = 853, name = GetSpellInfo(853), icon = select(3, GetSpellInfo(853))},
	HandofReckoning = {id = 62124, name = GetSpellInfo(62124), icon = select(3, GetSpellInfo(62124))},
	HandofProtection = {id = 1022, name = GetSpellInfo(1022), icon = select(3, GetSpellInfo(1022))},
	BlessingofKings = {id = 20217, name = GetSpellInfo(20217), icon = select(3, GetSpellInfo(20217))},
	DivineProtection = {id = 498, name = GetSpellInfo(498), icon = select(3, GetSpellInfo(498))},
	RighteousDefense = {id = 31789, name = GetSpellInfo(31789), icon = select(3, GetSpellInfo(31789))},
	DivineShield = {id = 642, name = GetSpellInfo(642), icon = select(3, GetSpellInfo(642))},
	HandofFreedom = {id = 1044, name = GetSpellInfo(1044), icon = select(3, GetSpellInfo(1044))},
	SealofJustice = {id = 20164, name = GetSpellInfo(20164), icon = select(3, GetSpellInfo(20164))},
	HandofSalvation = {id = 1038, name = GetSpellInfo(1038), icon = select(3, GetSpellInfo(1038))},
	ResistanceAura = {id = 19891, name = GetSpellInfo(19891), icon = select(3, GetSpellInfo(19891))},
	HandofSacrifice = {id = 6940, name = GetSpellInfo(6940), icon = select(3, GetSpellInfo(6940))},
	GuardianofAncientKings = {id = 86150, name = GetSpellInfo(86150), icon = select(3, GetSpellInfo(86150))},
	--Retribution
	CrusaderStrike = {id = 35395, name = GetSpellInfo(35395), icon = select(3, GetSpellInfo(35395))},
	Judgement = {id = 20271, name = GetSpellInfo(20271), icon = select(3, GetSpellInfo(20271))},
	JudgementsoftheBold = {id = 89901, name = GetSpellInfo(89901), icon = select(3, GetSpellInfo(89901))},
	SheathofLight = {id = 53503, name = GetSpellInfo(53503), icon = select(3, GetSpellInfo(53503))},
	TemplarsVerdict = {id = 85256, name = GetSpellInfo(85256), icon = select(3, GetSpellInfo(85256))},
	TwoHandedWeaponSpecialization = {id = 20113, name = GetSpellInfo(20113), icon = select(3, GetSpellInfo(20113))},
	RetributionAura = {id = 7294, name = GetSpellInfo(7294), icon = select(3, GetSpellInfo(7294))},
	SealofTruth = {id = 31801, name = GetSpellInfo(31801), icon = select(3, GetSpellInfo(31801))},
	HammerofWrath = {id = 24275, name = GetSpellInfo(24275), icon = select(3, GetSpellInfo(24275))},
	Rebuke = {id = 96231, name = GetSpellInfo(96231), icon = select(3, GetSpellInfo(96231))},
	BlessingofMight = {id = 19740, name = GetSpellInfo(19740), icon = select(3, GetSpellInfo(19740))},
	CrusaderAura = {id = 32223, name = GetSpellInfo(32223), icon = select(3, GetSpellInfo(32223))},
	AvengingWrath = {id = 31884, name = GetSpellInfo(31884), icon = select(3, GetSpellInfo(31884))},
	Inquisition = {id = 84963, name = GetSpellInfo(84963), icon = select(3, GetSpellInfo(84963))}
}

local p, t = "player", "target"

local Truth, Insight, Righteousness = "|cffFFFF33Truth", "|cffFF9900Insight", "|cff24E0FBRighteousness"

local DivinePurpose, TheArtOfWar = 86172, 87138

local enables = {}
local values = {}
local inputs = {}
local menus = {
	["Seal"] = 1
}
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
	settingsfile = "Ret-Cata-Nuok.xml",
	callback = GUICallback,
	{type = "separator"},
	{type = "title", text = "Ret Cata Nuok"},
	{type = "separator"},
	{type = "title", text = "Seal Selection"},
	{
		type = "dropdown",
		menu = {
			{
				selected = (menus["Seal"] == 1),
				value = 1,
				text = "\124T" .. spells.SealofTruth.icon .. ":15:15\124t " .. Truth
			},
			{
				selected = (menus["Seal"] == 2),
				value = 2,
				text = "\124T" .. spells.SealofInsight.icon .. ":15:15\124t " .. Insight
			},
			{
				selected = (menus["Seal"] == 3),
				value = 3,
				text = "\124T" .. spells.SealofRighteousness.icon .. ":15:15\124t " .. Righteousness
			}
		},
		key = "Seal"
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
	ni.combatlog.registerhandler("Ret", CombatEventCatcher)
	ni.GUI.AddFrame("Ret", items)
end
local function OnUnload()
	ni.combatlog.unregisterhandler("Ret")
	ni.GUI.DestroyFrame("Ret")
end

local enemies = {}

local function ActiveEnemies()
	table.wipe(enemies)
	enemies = ni.player.enemiesinrange(9)
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

local cache = {
	holypower = 0,
	inmelee = false
}

local abilities = {
	["Pause"] = function()
		if
			IsMounted() or UnitIsDeadOrGhost(p) or not UnitExists(t) or UnitIsDeadOrGhost(t) or
				(UnitExists(t) and not UnitCanAttack(p, t))
		 then
			return true
		end
	end,
	["Cache"] = function()
		cache.holypower = ni.player.powerraw("holy")
		cache.inmelee = IsSpellInRange(spells.CrusaderStrike.name, t) == 1
	end,
	["AutoAttack"] = function()
		if not IsCurrentSpell(spells.AutoAttack.id) and cache.inmelee and incombat then
			ni.spell.cast(spells.AutoAttack.name)
		end
	end,
	["Seal"] = function()
		local s = menus["Seal"]
		if s == 1 and ni.spell.available(spells.SealofTruth.id) and not ni.player.buff(spells.SealofTruth.id) then
			ni.spell.cast(spells.SealofTruth.name)
			return true
		end
		if s == 2 and ni.spell.available(spells.SealofInsight.id) and not ni.player.buff(spells.SealofInsight.id) then
			ni.spell.cast(spells.SealofInsight.name)
			return true
		end
		if s == 3 and ni.spell.available(spells.SealofRighteousness.id) and not ni.player.buff(spells.SealofRighteousness.id) then
			ni.spell.cast(spells.SealofRighteousness.name)
			return true
		end
	end,
	["Judgement"] = function()
		if ValidUsable(spells.Judgement.id, t) and FacingLosCast(spells.Judgement.name, t) then
			return true
		end
	end,
	["CrusaderStrike"] = function()
		if ValidUsable(spells.CrusaderStrike.id, t) and FacingLosCast(spells.CrusaderStrike.name, t) then
			return true
		end
	end,
	["TemplarsVerdict"] = function()
		if
			ValidUsable(spells.TemplarsVerdict.id, t) and cache.holypower >= 3 and FacingLosCast(spells.TemplarsVerdict.name, t)
		 then
			return true
		end
	end,
	["TemplarsVerdictDP"] = function()
		if
			ValidUsable(spells.TemplarsVerdict.id, t) and ni.player.buff(DivinePurpose) and
				FacingLosCast(spells.TemplarsVerdict.name, t)
		 then
			return true
		end
	end,
	["Exorcism"] = function()
		if ValidUsable(spells.Exorcism.id, t) and ni.player.buff(TheArtOfWar) and FacingLosCast(spells.Exorcism.name, t) then
			return true
		end
	end,
	["HammerofWrath"] = function()
		if
			ValidUsable(spells.HammerofWrath.id, t) and IsUsableSpell(spells.HammerofWrath.id) and
				FacingLosCast(spells.HammerofWrath.name, t)
		 then
			return true
		end
	end,
	["HolyWrath"] = function()
		if ni.spell.available(spells.HolyWrath.id) and cache.inmelee then
			ni.spell.cast(spells.HolyWrath.name)
			return true
		end
	end,
	["Consecration"] = function()
		if ni.spell.available(spells.Consecration.id) and cache.inmelee then
			ni.spell.cast(spells.Consecration.name)
			return true
		end
	end,
	["Inquisition"] = function()
		if
			ni.spell.available(spells.Inquisition.id) and cache.holypower == 3 and
				ni.player.buffremaining(spells.Inquisition.id) <= 3
		 then
			ni.spell.cast(spells.Inquisition.name)
			return true
		end
	end
}
ni.bootstrap.profile("Ret-Cata-Nuok", queue, abilities, OnLoad, OnUnload)
