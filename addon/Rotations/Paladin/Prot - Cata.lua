local queue = {
	"Crusader Aura",
	"Pause",
	"Rebuke",
	"Seal",
	"Devotion Aura",
	"Fury",
	"ArdentDefender",
	"GuardianofAncientKings",
	"DivineProtection",
	"Holy Sheild",
	"Divine Plea",
	"Cleanse",
	"Word of Glory",
	"Inquisition",
	"Hammer of the Righteous",
	"Shield of the Righteous",
	"Hammer of Wrath",
	"Avengers Shield",
	"Crusader Strike",
	"Judgement",
	"Holy Wrath"
}

local spells = {
	--build == 40300
	--General icon = select(2, GetSpellTabInfo(1))
	ArmorSkills = {id = 76271, name = GetSpellInfo(76271), icon = select(3, GetSpellInfo(76271))},
	ArtisanRiding = {id = 34091, name = GetSpellInfo(34091), icon = select(3, GetSpellInfo(34091))},
	AutoAttack = {id = 6603, name = GetSpellInfo(6603), icon = select(3, GetSpellInfo(6603))},
	ColdWeatherFlying = {id = 54197, name = GetSpellInfo(54197), icon = select(3, GetSpellInfo(54197))},
	Diplomacy = {id = 20599, name = GetSpellInfo(20599), icon = select(3, GetSpellInfo(20599))},
	EveryManforHimself = {id = 59752, name = GetSpellInfo(59752), icon = select(3, GetSpellInfo(59752))},
	FlightMastersLicense = {id = 90267, name = GetSpellInfo(90267), icon = select(3, GetSpellInfo(90267))},
	Languages = {id = 79738, name = GetSpellInfo(79738), icon = select(3, GetSpellInfo(79738))},
	MaceSpecialization = {id = 20864, name = GetSpellInfo(20864), icon = select(3, GetSpellInfo(20864))},
	Mastery = {id = 86474, name = GetSpellInfo(86474), icon = select(3, GetSpellInfo(86474))},
	PlateSpecialization = {id = 86525, name = GetSpellInfo(86525), icon = select(3, GetSpellInfo(86525))},
	SwordSpecialization = {id = 20597, name = GetSpellInfo(20597), icon = select(3, GetSpellInfo(20597))},
	TheHumanSpirit = {id = 20598, name = GetSpellInfo(20598), icon = select(3, GetSpellInfo(20598))},
	WeaponSkills = {id = 76294, name = GetSpellInfo(76294), icon = select(3, GetSpellInfo(76294))},
	MasterRiding = {id = 90265, name = GetSpellInfo(90265), icon = select(3, GetSpellInfo(90265))},
	--Holy icon = select(2, GetSpellTabInfo(2))
	Cleanse = {id = 4987, name = GetSpellInfo(4987), icon = select(3, GetSpellInfo(4987))},
	ConcentrationAura = {id = 19746, name = GetSpellInfo(19746), icon = select(3, GetSpellInfo(19746))},
	Consecration = {id = 26573, name = GetSpellInfo(26573), icon = select(3, GetSpellInfo(26573))},
	DivineLight = {id = 82326, name = GetSpellInfo(82326), icon = select(3, GetSpellInfo(82326))},
	DivinePlea = {id = 54428, name = GetSpellInfo(54428), icon = select(3, GetSpellInfo(54428))},
	Exorcism = {id = 879, name = GetSpellInfo(879), icon = select(3, GetSpellInfo(879))},
	FlashofLight = {id = 19750, name = GetSpellInfo(19750), icon = select(3, GetSpellInfo(19750))},
	HolyLight = {id = 635, name = GetSpellInfo(635), icon = select(3, GetSpellInfo(635))},
	HolyRadiance = {id = 82327, name = GetSpellInfo(82327), icon = select(3, GetSpellInfo(82327))},
	HolyWrath = {id = 2812, name = GetSpellInfo(2812), icon = select(3, GetSpellInfo(2812))},
	LayonHands = {id = 633, name = GetSpellInfo(633), icon = select(3, GetSpellInfo(633))},
	Redemption = {id = 7328, name = GetSpellInfo(7328), icon = select(3, GetSpellInfo(7328))},
	SealofInsight = {id = 20165, name = GetSpellInfo(20165), icon = select(3, GetSpellInfo(20165))},
	TurnEvil = {id = 10326, name = GetSpellInfo(10326), icon = select(3, GetSpellInfo(10326))},
	WordofGlory = {id = 85673, name = GetSpellInfo(85673), icon = select(3, GetSpellInfo(85673))},
	--Protection icon = select(2, GetSpellTabInfo(3))
	ArdentDefender = {id = 31850, name = GetSpellInfo(31850), icon = select(3, GetSpellInfo(31850))},
	AvengersShield = {id = 31935, name = GetSpellInfo(31935), icon = select(3, GetSpellInfo(31935))},
	BlessingofKings = {id = 20217, name = GetSpellInfo(20217), icon = select(3, GetSpellInfo(20217))},
	DevotionAura = {id = 465, name = GetSpellInfo(465), icon = select(3, GetSpellInfo(465))},
	DivineGuardian = {id = 70940, name = GetSpellInfo(70940), icon = select(3, GetSpellInfo(70940))},
	DivineProtection = {id = 498, name = GetSpellInfo(498), icon = select(3, GetSpellInfo(498))},
	DivineShield = {id = 642, name = GetSpellInfo(642), icon = select(3, GetSpellInfo(642))},
	GuardianofAncientKings = {id = 86150, name = GetSpellInfo(86150), icon = select(3, GetSpellInfo(86150))},
	HammerofJustice = {id = 853, name = GetSpellInfo(853), icon = select(3, GetSpellInfo(853))},
	HammeroftheRighteous = {id = 53595, name = GetSpellInfo(53595), icon = select(3, GetSpellInfo(53595))},
	HandofFreedom = {id = 1044, name = GetSpellInfo(1044), icon = select(3, GetSpellInfo(1044))},
	HandofProtection = {id = 1022, name = GetSpellInfo(1022), icon = select(3, GetSpellInfo(1022))},
	HandofReckoning = {id = 62124, name = GetSpellInfo(62124), icon = select(3, GetSpellInfo(62124))},
	HandofSacrifice = {id = 6940, name = GetSpellInfo(6940), icon = select(3, GetSpellInfo(6940))},
	HandofSalvation = {id = 1038, name = GetSpellInfo(1038), icon = select(3, GetSpellInfo(1038))},
	HolyShield = {id = 20925, name = GetSpellInfo(20925), icon = select(3, GetSpellInfo(20925))},
	JudgementsoftheWise = {id = 31878, name = GetSpellInfo(31878), icon = select(3, GetSpellInfo(31878))},
	Parry = {id = 82242, name = GetSpellInfo(82242), icon = select(3, GetSpellInfo(82242))},
	ResistanceAura = {id = 19891, name = GetSpellInfo(19891), icon = select(3, GetSpellInfo(19891))},
	RighteousDefense = {id = 31789, name = GetSpellInfo(31789), icon = select(3, GetSpellInfo(31789))},
	RighteousFury = {id = 25780, name = GetSpellInfo(25780), icon = select(3, GetSpellInfo(25780))},
	SealofJustice = {id = 20164, name = GetSpellInfo(20164), icon = select(3, GetSpellInfo(20164))},
	SealofRighteousness = {id = 20154, name = GetSpellInfo(20154), icon = select(3, GetSpellInfo(20154))},
	ShieldoftheRighteous = {id = 53600, name = GetSpellInfo(53600), icon = select(3, GetSpellInfo(53600))},
	TouchedbytheLight = {id = 53592, name = GetSpellInfo(53592), icon = select(3, GetSpellInfo(53592))},
	Vengeance = {id = 84839, name = GetSpellInfo(84839), icon = select(3, GetSpellInfo(84839))},
	--Retribution icon = select(2, GetSpellTabInfo(4))
	AvengingWrath = {id = 31884, name = GetSpellInfo(31884), icon = select(3, GetSpellInfo(31884))},
	BlessingofMight = {id = 19740, name = GetSpellInfo(19740), icon = select(3, GetSpellInfo(19740))},
	CrusaderAura = {id = 32223, name = GetSpellInfo(32223), icon = select(3, GetSpellInfo(32223))},
	CrusaderStrike = {id = 35395, name = GetSpellInfo(35395), icon = select(3, GetSpellInfo(35395))},
	HammerofWrath = {id = 24275, name = GetSpellInfo(24275), icon = select(3, GetSpellInfo(24275))},
	Inquisition = {id = 84963, name = GetSpellInfo(84963), icon = select(3, GetSpellInfo(84963))},
	Judgement = {id = 20271, name = GetSpellInfo(20271), icon = select(3, GetSpellInfo(20271))},
	Rebuke = {id = 96231, name = GetSpellInfo(96231), icon = select(3, GetSpellInfo(96231))},
	RetributionAura = {id = 7294, name = GetSpellInfo(7294), icon = select(3, GetSpellInfo(7294))},
	SealofTruth = {id = 31801, name = GetSpellInfo(31801), icon = select(3, GetSpellInfo(31801))}
}

local enables = {
	["HolyWrath"] = false,
	["DivinePlea"] = true,
	["WordofGlory"] = true,
	["HolyShield"] = true,
	["Cleanse"] = false,
	["GuardianofAncientKings"] = true,
	["ArdentDefender"] = true,
	["DivineProtection"] = true
}
local values = {
	["HolyWrath"] = 1,
	["DivinePlea"] = 60,
	["WordofGlory"] = 75,
	["HolyShield"] = 80,
	["DivineProtection"] = 75,
	["GuardianofAncientKings"] = 50,
	["ArdentDefender"] = 25
}
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
	settingsfile = "prot_cata.xml",
	callback = GUICallback,
	{type = "title", text = "\124T" .. select(2, GetSpellTabInfo(3)) .. ":20:20\124t Prot Pala Cata"},
	{type = "separator"},
	{type = "title", text = "Seal Selection"},
	{
		type = "dropdown",
		menu = {
			{
				selected = (menus["Seal"] == 1),
				value = 1,
				text = "\124T" .. spells.SealofTruth.icon .. ":20:20\124t " .. spells.SealofTruth.name
			},
			{
				selected = (menus["Seal"] == 2),
				value = 2,
				text = "\124T" .. spells.SealofInsight.icon .. ":20:20\124t " .. spells.SealofInsight.name
			},
			{
				selected = (menus["Seal"] == 3),
				value = 3,
				text = "\124T" .. spells.SealofRighteousness.icon .. ":20:20\124t " .. spells.SealofRighteousness.name
			}
		},
		key = "Seal"
	},
	{type = "separator"},
	{type = "title", text = "Defensive CD's"},
	{
		type = "entry",
		text = "\124T" .. spells.ArdentDefender.icon .. ":20:20\124t " .. spells.ArdentDefender.name,
		tooltip = "The players health pct before using Ardent Defender",
		enabled = enables["ArdentDefender"],
		value = values["ArdentDefender"],
		key = "ArdentDefender"
	},
	{
		type = "entry",
		text = "\124T" .. spells.DivineProtection.icon .. ":20:20\124t " .. spells.DivineProtection.name,
		tooltip = "The players health pct before using Ardent Defender",
		enabled = enables["DivineProtection"],
		value = values["DivineProtection"],
		key = "DivineProtection"
	},
	{
		type = "entry",
		text = "\124T" .. spells.GuardianofAncientKings.icon .. ":20:20\124t " .. spells.GuardianofAncientKings.name,
		tooltip = "The players health pct before using Guardian of Ancient Kings",
		enabled = enables["GuardianofAncientKings"],
		value = values["GuardianofAncientKings"],
		key = "GuardianofAncientKings"
	},
	{
		type = "entry",
		text = "\124T" .. spells.HolyShield.icon .. ":20:20\124t " .. spells.HolyShield.name,
		tooltip = "The players health pct before using Holy Sheild",
		enabled = enables["HolyShield"],
		value = values["HolyShield"],
		key = "HolyShield"
	},
	{type = "separator"},
	{
		type = "entry",
		text = "\124T" .. spells.HolyWrath.icon .. ":20:20\124t " .. spells.HolyWrath.name,
		tooltip = "Controls how many mobs should be close before casting Holy Wrath",
		enabled = enables["HolyWrath"],
		value = values["HolyWrath"],
		key = "HolyWrath"
	},
	{type = "separator"},
	{
		type = "entry",
		text = "\124T" .. spells.WordofGlory.icon .. ":20:20\124t " .. spells.WordofGlory.name,
		tooltip = "The players health pct before using Word of Glory",
		enabled = enables["WordofGlory"],
		value = values["WordofGlory"],
		key = "WordofGlory"
	},
	{type = "separator"},
	{
		type = "entry",
		text = "\124T" .. spells.DivinePlea.icon .. ":20:20\124t " .. spells.DivinePlea.name,
		tooltip = "The players mana pct before using Divine Plea",
		enabled = enables["DivinePlea"],
		value = values["DivinePlea"],
		key = "DivinePlea"
	},
	{
		type = "entry",
		text = "\124T" .. spells.Cleanse.icon .. ":20:20\124t " .. spells.Cleanse.name,
		tooltip = "Cleanse the player",
		enabled = enables["Cleanse"],
		key = "Cleanse"
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
	ni.combatlog.registerhandler("ret-Cata", CombatEventCatcher)
	ni.GUI.AddFrame("ret-Cata", items)
end
local function OnUnload()
	ni.combatlog.unregisterhandler("ret-Cata")
	ni.GUI.DestroyFrame("ret-Cata")
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

local abilities = {
	["Pause"] = function()
		if
			IsMounted() or UnitIsDeadOrGhost("player") or not UnitExists("target") or UnitIsDeadOrGhost("target") or
				(UnitExists("target") and not UnitCanAttack("player", "target"))
		 then
			return true
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
	["Divine Plea"] = function()
		if
			not enables["DivinePlea"] and ni.spell.available(spells.DivinePlea.id) and
				ni.player.power("mana") <= values["DivinePlea"]
		 then
			ni.spell.cast(spells.DivinePlea.name)
			return true
		end
	end,
	["Devotion Aura"] = function()
		if not ni.player.buff(spells.DevotionAura.id) and ni.spell.available(spells.DevotionAura.id) then
			ni.spell.cast(spells.DevotionAura.name)
			return true
		end
	end,
	["Crusader Aura"] = function()
		if IsMounted() and not ni.player.buff(spells.CrusaderAura.id) then
			ni.spell.cast(spells.CrusaderAura.name)
			return true
		end
	end,
	["Fury"] = function()
		if not ni.player.buff(spells.RighteousFury.id) and ni.spell.available(spells.RighteousFury.id) then
			ni.spell.cast(spells.RighteousFury.name)
			return true
		end
	end,
	["Auto Attack"] = function()
		if not IsCurrentSpell(6603) then
			ni.spell.cast(6603)
		end
	end,
	["Rebuke"] = function()
		local cd = ni.spell.cd(spells.Rebuke.id)
		if cd == 0 and ni.spell.shouldinterrupt("target") and FacingLosCast(spells.Rebuke.name, "target") then
			return true
		end
	end,
	["Word of Glory"] = function()
		local holy = ni.player.powerraw("holy")
		local cd = ni.spell.cd(spells.WordofGlory.id)
		if enables["WordofGlory"] and cd == 0 and holy == 3 and ni.player.hp() <= values["WordofGlory"] then
			ni.spell.cast(spells.WordofGlory.name, "player")
			return true
		end
		if cd > 0 and cd <= 0.2 then
			return true
		end
	end,
	["Holy Sheild"] = function()
		if
			enables["HolyShield"] and ni.spell.available(spells.HolyShield.id) and incombat and
				ni.player.hp() <= values["HolyShield"] and
				ActiveEnemies() >= 1
		 then
			ni.spell.cast(spells.HolyShield.name)
			return true
		end
	end,
	["GuardianofAncientKings"] = function()
		if
			enables["GuardianofAncientKings"] and ni.spell.available(spells.GuardianofAncientKings.id) and incombat and
				ni.player.hp() <= values["GuardianofAncientKings"] and
				ActiveEnemies() >= 1
		 then
			ni.spell.cast(spells.GuardianofAncientKings.name)
			return true
		end
	end,
	["ArdentDefender"] = function()
		if
			enables["ArdentDefender"] and ni.spell.available(spells.ArdentDefender.id) and incombat and
				ni.player.hp() <= values["ArdentDefender"] and
				ActiveEnemies() >= 1
		 then
			ni.spell.cast(spells.ArdentDefender.name)
			return true
		end
	end,
	["DivineProtection"] = function()
		if
			enables["DivineProtection"] and incombat and ni.spell.available(spells.DivineProtection.id) and
				ni.player.hp() <= values["DivineProtection"] and
				ActiveEnemies() >= 1
		 then
			ni.spell.cast(spells.DivineProtection.name)
			return true
		end
	end,
	["Shield of the Righteous"] = function()
		local holy = ni.player.powerraw("holy")
		local cd = ni.spell.cd(spells.WordofGlory.id)
		if
			ValidUsable(spells.ShieldoftheRighteous.id, "target") and holy == 3 and
				(not enables["WordofGlory"] or ni.player.hp() >= values["WordofGlory"] or cd > 0) and
				FacingLosCast(spells.ShieldoftheRighteous.name, "target")
		 then
			return true
		end
	end,
	["Inquisition"] = function()
		local holy = ni.player.powerraw("holy")
		local cd = ni.spell.cd(spells.WordofGlory.id)
		if
			holy == 3 and ni.spell.available(spells.Inquisition.id) and
				(not enables["WordofGlory"] or cd > 0 or ni.player.hp() >= values["WordofGlory"]) and
				ni.player.buffremaining(spells.Inquisition.id) < 2 and
				ActiveEnemies() >= 2
		 then
			ni.spell.cast(spells.Inquisition.name)
			return true
		end
	end,
	["Hammer of the Righteous"] = function()
		if
			ValidUsable(spells.HammeroftheRighteous.id, "target") and ActiveEnemies() >= 2 and
				FacingLosCast(spells.HammeroftheRighteous.name, "target")
		 then
			return true
		end
	end,
	["Avengers Shield"] = function()
		if ValidUsable(spells.AvengersShield.id, "target") and FacingLosCast(spells.AvengersShield.name, "target") then
			return true
		end
	end,
	["Hammer of Wrath"] = function()
		if
			ValidUsable(spells.HammerofWrath.id, "target") and IsUsableSpell(spells.HammerofWrath.name) and
				ni.unit.hp("target") < 20 and
				FacingLosCast(spells.HammerofWrath.name, "target")
		 then
			return true
		end
	end,
	["Crusader Strike"] = function()
		if ValidUsable(spells.CrusaderStrike.id, "target") and FacingLosCast(spells.CrusaderStrike.name, "target") then
			return true
		end
	end,
	["Judgement"] = function()
		if ValidUsable(spells.Judgement.id, "target") and FacingLosCast(spells.Judgement.name, "target") then
			return true
		end
	end,
	["Holy Wrath"] = function()
		local cd = ni.spell.cd(spells.HolyWrath.id)
		if
			enables["HolyWrath"] and cd == 0 and incombat and ni.spell.available(spells.HolyWrath.id) and
				ActiveEnemies() >= values["HolyWrath"]
		 then
			ni.spell.cast(spells.HolyWrath.name)
			return true
		end
	end,
	["Cleanse"] = function()
		if enables["Cleanse"] and ni.spell.available(spells.Cleanse.id) and ni.healing.candispel("player") then
			ni.spell.cast(spells.Cleanse.name)
			return true
		end
	end
}
ni.bootstrap.profile("Prot - Cata", queue, abilities, OnLoad, OnUnload)
