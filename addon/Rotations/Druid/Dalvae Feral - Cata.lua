local build = select(4, GetBuildInfo());
local cata = build == 40300 or false;
if cata then
	local spells = {
		--build == 40300
		--General icon = select(2, GetSpellTabInfo(1))
		ArmorSkills = { id = 76275, name = GetSpellInfo(76275), icon = select(3, GetSpellInfo(76275)) },
		AutoAttack = { id = 6603, name = GetSpellInfo(6603), icon = select(3, GetSpellInfo(6603)) },
		Cultivation = { id = 20552, name = GetSpellInfo(20552), icon = select(3, GetSpellInfo(20552)) },
		Endurance = { id = 20550, name = GetSpellInfo(20550), icon = select(3, GetSpellInfo(20550)) },
		Languages = { id = 79746, name = GetSpellInfo(79746), icon = select(3, GetSpellInfo(79746)) },
		NatureResistance = { id = 20551, name = GetSpellInfo(20551), icon = select(3, GetSpellInfo(20551)) },
		WarStomp = { id = 20549, name = GetSpellInfo(20549), icon = select(3, GetSpellInfo(20549)) },
		WeaponSkills = { id = 76300, name = GetSpellInfo(76300), icon = select(3, GetSpellInfo(76300)) },
		ApprenticeRiding = { id = 33388, name = GetSpellInfo(33388), icon = select(3, GetSpellInfo(33388)) },
		JourneymanRiding = { id = 33391, name = GetSpellInfo(33391), icon = select(3, GetSpellInfo(33391)) },
		LeatherSpecialization = { id = 86530, name = GetSpellInfo(86530), icon = select(3, GetSpellInfo(86530)) },
		ExpertRiding = { id = 34090, name = GetSpellInfo(34090), icon = select(3, GetSpellInfo(34090)) },
		FlightMastersLicense = { id = 90267, name = GetSpellInfo(90267), icon = select(3, GetSpellInfo(90267)) },
		ColdWeatherFlying = { id = 54197, name = GetSpellInfo(54197), icon = select(3, GetSpellInfo(54197)) },
		ArtisanRiding = { id = 34091, name = GetSpellInfo(34091), icon = select(3, GetSpellInfo(34091)) },
		MasterRiding = { id = 90265, name = GetSpellInfo(90265), icon = select(3, GetSpellInfo(90265)) },
		Mastery = { id = 86470, name = GetSpellInfo(86470), icon = select(3, GetSpellInfo(86470)) },
		--Balance icon = select(2, GetSpellTabInfo(2))
		Moonfire = { id = 8921, name = GetSpellInfo(8921), icon = select(3, GetSpellInfo(8921)) },
		Thorns = { id = 467, name = GetSpellInfo(467), icon = select(3, GetSpellInfo(467)) },
		Wrath = { id = 5176, name = GetSpellInfo(5176), icon = select(3, GetSpellInfo(5176)) },
		EntanglingRoots = { id = 339, name = GetSpellInfo(339), icon = select(3, GetSpellInfo(339)) },
		Starfire = { id = 2912, name = GetSpellInfo(2912), icon = select(3, GetSpellInfo(2912)) },
		TeleportMoonglade = { id = 18960, name = GetSpellInfo(18960), icon = select(3, GetSpellInfo(18960)) },
		InsectSwarm = { id = 5570, name = GetSpellInfo(5570), icon = select(3, GetSpellInfo(5570)) },
		FaerieFire = { id = 770, name = GetSpellInfo(770), icon = select(3, GetSpellInfo(770)) },
		Innervate = { id = 29166, name = GetSpellInfo(29166), icon = select(3, GetSpellInfo(29166)) },
		Soothe = { id = 2908, name = GetSpellInfo(2908), icon = select(3, GetSpellInfo(2908)) },
		Hurricane = { id = 16914, name = GetSpellInfo(16914), icon = select(3, GetSpellInfo(16914)) },
		Hibernate = { id = 2637, name = GetSpellInfo(2637), icon = select(3, GetSpellInfo(2637)) },
		NaturesGrasp = { id = 16689, name = GetSpellInfo(16689), icon = select(3, GetSpellInfo(16689)) },
		Barkskin = { id = 22812, name = GetSpellInfo(22812), icon = select(3, GetSpellInfo(22812)) },
		Cyclone = { id = 33786, name = GetSpellInfo(33786), icon = select(3, GetSpellInfo(33786)) },
		WildMushroom = { id = 88747, name = GetSpellInfo(88747), icon = select(3, GetSpellInfo(88747)) },
		WildMushroomDetonate = { id = 88751, name = GetSpellInfo(88751), icon = select(3, GetSpellInfo(88751)) },
		--Feral icon = select(2, GetSpellTabInfo(3))
		Aggression = { id = 84735, name = GetSpellInfo(84735), icon = select(3, GetSpellInfo(84735)) },
		CatForm = { id = 768, name = GetSpellInfo(768), icon = select(3, GetSpellInfo(768)) },
		ClawCat = { id = 1082, name = GetSpellInfo(1082), icon = select(3, GetSpellInfo(1082)) },
		FeralInstinct = { id = 87335, name = GetSpellInfo(87335), icon = select(3, GetSpellInfo(87335)) },
		FerociousBiteCat = { id = 22568, name = GetSpellInfo(22568), icon = select(3, GetSpellInfo(22568)) },
		MangleBear = { id = 33878, name = GetSpellInfo(33878), icon = select(3, GetSpellInfo(33878)) },
		MangleCat = { id = 33876, name = GetSpellInfo(33876), icon = select(3, GetSpellInfo(33876)) },
		RakeCat = { id = 1822, name = GetSpellInfo(1822), icon = select(3, GetSpellInfo(1822)) },
		Vengeance = { id = 84840, name = GetSpellInfo(84840), icon = select(3, GetSpellInfo(84840)) },
		ProwlCat = { id = 5215, name = GetSpellInfo(5215), icon = select(3, GetSpellInfo(5215)) },
		BearForm = { id = 5487, name = GetSpellInfo(5487), icon = select(3, GetSpellInfo(5487)) },
		DemoralizingRoarBear = { id = 99, name = GetSpellInfo(99), icon = select(3, GetSpellInfo(99)) },
		GrowlBear = { id = 6795, name = GetSpellInfo(6795), icon = select(3, GetSpellInfo(6795)) },
		MaulBear = { id = 6807, name = GetSpellInfo(6807), icon = select(3, GetSpellInfo(6807)) },
		AquaticForm = { id = 1066, name = GetSpellInfo(1066), icon = select(3, GetSpellInfo(1066)) },
		TravelForm = { id = 783, name = GetSpellInfo(783), icon = select(3, GetSpellInfo(783)) },
		SwipeBear = { id = 779, name = GetSpellInfo(779), icon = select(3, GetSpellInfo(779)) },
		EnrageBear = { id = 5229, name = GetSpellInfo(5229), icon = select(3, GetSpellInfo(5229)) },
		RavageCat = { id = 6785, name = GetSpellInfo(6785), icon = select(3, GetSpellInfo(6785)) },
		SkullBashCat = { id = 80965, name = GetSpellInfo(80965), icon = select(3, GetSpellInfo(80965)) },
		SkullBashBear = { id = 80964, name = GetSpellInfo(80964), icon = select(3, GetSpellInfo(80964)) },
		FaerieFireFeral = { id = 16857, name = GetSpellInfo(16857), icon = select(3, GetSpellInfo(16857)) },
		TigersFuryCat = { id = 5217, name = GetSpellInfo(5217), icon = select(3, GetSpellInfo(5217)) },
		CowerCat = { id = 8998, name = GetSpellInfo(8998), icon = select(3, GetSpellInfo(8998)) },
		DashCat = { id = 1850, name = GetSpellInfo(1850), icon = select(3, GetSpellInfo(1850)) },
		FelineGrace = { id = 20719, name = GetSpellInfo(20719), icon = select(3, GetSpellInfo(20719)) },
		ChallengingRoarBear = { id = 5209, name = GetSpellInfo(5209), icon = select(3, GetSpellInfo(5209)) },
		BashBear = { id = 5211, name = GetSpellInfo(5211), icon = select(3, GetSpellInfo(5211)) },
		PounceCat = { id = 9005, name = GetSpellInfo(9005), icon = select(3, GetSpellInfo(9005)) },
		SwipeCat = { id = 62078, name = GetSpellInfo(62078), icon = select(3, GetSpellInfo(62078)) },
		SavageDefense = { id = 62600, name = GetSpellInfo(62600), icon = select(3, GetSpellInfo(62600)) },
		ShredCat = { id = 5221, name = GetSpellInfo(5221), icon = select(3, GetSpellInfo(5221)) },
		FrenziedRegenerationBear = { id = 22842, name = GetSpellInfo(22842), icon = select(3, GetSpellInfo(22842)) },
		RipCat = { id = 1079, name = GetSpellInfo(1079), icon = select(3, GetSpellInfo(1079)) },
		FlightForm = { id = 33943, name = GetSpellInfo(33943), icon = select(3, GetSpellInfo(33943)) },
		MaimCat = { id = 22570, name = GetSpellInfo(22570), icon = select(3, GetSpellInfo(22570)) },
		LacerateBear = { id = 33745, name = GetSpellInfo(33745), icon = select(3, GetSpellInfo(33745)) },
		SwiftFlightForm = { id = 40120, name = GetSpellInfo(40120), icon = select(3, GetSpellInfo(40120)) },
		SavageRoarCat = { id = 52610, name = GetSpellInfo(52610), icon = select(3, GetSpellInfo(52610)) },
		ThrashBear = { id = 77758, name = GetSpellInfo(77758), icon = select(3, GetSpellInfo(77758)) },
		Pulverize = { id = 80313, name = GetSpellInfo(80313), icon = select(3, GetSpellInfo(80313)) },
		StampedingRoarCat = { id = 77764, name = GetSpellInfo(77764), icon = select(3, GetSpellInfo(77764)) },
		StampedingRoarBear = { id = 77761, name = GetSpellInfo(77761), icon = select(3, GetSpellInfo(77761)) },
		--Restoration icon = select(2, GetSpellTabInfo(4))
		Rejuvenation = { id = 774, name = GetSpellInfo(774), icon = select(3, GetSpellInfo(774)) },
		Nourish = { id = 50464, name = GetSpellInfo(50464), icon = select(3, GetSpellInfo(50464)) },
		Regrowth = { id = 8936, name = GetSpellInfo(8936), icon = select(3, GetSpellInfo(8936)) },
		Revive = { id = 50769, name = GetSpellInfo(50769), icon = select(3, GetSpellInfo(50769)) },
		OmenofClarity = { id = 16864, name = GetSpellInfo(16864), icon = select(3, GetSpellInfo(16864)) },
		Rebirth = { id = 20484, name = GetSpellInfo(20484), icon = select(3, GetSpellInfo(20484)) },
		RemoveCorruption = { id = 2782, name = GetSpellInfo(2782), icon = select(3, GetSpellInfo(2782)) },
		MarkoftheWild = { id = 1126, name = GetSpellInfo(1126), icon = select(3, GetSpellInfo(1126)) },
		Lifebloom = { id = 33763, name = GetSpellInfo(33763), icon = select(3, GetSpellInfo(33763)) },
		Tranquility = { id = 740, name = GetSpellInfo(740), icon = select(3, GetSpellInfo(740)) },
		HealingTouch = { id = 5185, name = GetSpellInfo(5185), icon = select(3, GetSpellInfo(5185)) }
	}

	local enables = {
		["FullAutomated"] = true,
		["CycloneFocus"] = true,
		["CatForm"] = true,
		["Invi"] = true,
		["Ravage"] = true,
		["CatAoe"] = true,
		["BearAoe"] = true,
		["FrenziedRegen"] = true,
		["Taunt"] = false,
		["InterruptBear"] = true,
		["InterruptPVP"] = true,
	}
	local values = {
		["CatAoe"] = 3,
		["BearAoe"] = 3,
		["FrenziedRegen"] = 40,
	}
	local inputs = {}
	local menus = {

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
		settingsfile = "feral-cata.xml",
		callback = GUICallback,
		{ type = "title",    text = "|cff00ccffFeral-Cata" },
		{ type = "separator" },
		-- {type = "page", number = 1, text = "|cffFFFF00General Settings|r"},
		-- {
		-- type = "entry",
		-- text = "\124T"..":26:26\124t Auto loot",
		-- tooltip = "Auto loot out of combat",
		-- enabled = true,
		-- key = "getSetting_AutoLoot"
		-- },

		-- {
		-- type = "entry",
		-- text = "\124T"..":26:26\124t Auto loot even in Combat",
		-- tooltip = "Auto loot out in combat",
		-- enabled = true,
		-- key = "getSetting_EvenInCombat"
		-- },
		-- {
		-- 	type = "separator",
		-- },
		-- {
		-- 	type = "entry",
		-- 	text = "\124T" .. ":26:26\124t Auto pause when not in Combat",
		-- 	tooltip = "It going to auto start a fight if not enable",
		-- 	enabled = true,
		-- 	key = "getSetting_Pause"
		-- },
		-- {
		-- 	type = "separator",
		-- },

		-- {
		-- 	type = "entry",
		-- 	text = "\124T" .. select(3, GetSpellInfo(spells.Wrath.id)).. ":26:26\124t Auto cast for leveling",
		-- 	tooltip = "It will cast spells pre cat form",
		-- 	enabled = true,
		-- 	key = "getSetting_Castlevel"
		-- 	},
		-- {type = "page", number = 2, text = "\124T" .. select(3, GetSpellInfo(spells.CatForm.id))..":26:26\124t|cffFFFF00Cat Settings|r"},

		{
			type = "title",
			text = "|cff71C671Cat Settings",
		},
		{
			type = "separator",
		},
		{
			type = "entry",
			text = "\124T" .. select(3, GetSpellInfo(spells.CatForm.id)) .. ":26:26\124t Full Automated",
			tooltip = "It will cast Rip, Rake, Shred automatic",
			enabled = enables["FullAutomated"],
			key = "FullAutomated"
		},
		{
			type = "entry",
			text = "\124T" .. select(3, GetSpellInfo(spells.Cyclone.id)) .. ":26:26\124t Cyclone Focus",
			tooltip = "Will Auto use instant cast to cyclone focus target",
			enabled = enables["CycloneFocus"],
			key = "CycloneFocus"
		},


		{
			type = "separator",
		},
		{
			type = "entry",
			text = "\124T" .. select(3, GetSpellInfo(spells.RakeCat.id)) .. ":26:26\124t Auto Cat form",
			tooltip = "It will be in catform if its in combat",
			enabled = enables["CatForm"],
			key = "CatForm"
		},
		{
			type = "entry",
			text = "\124T" .. select(3, GetSpellInfo(spells.ProwlCat.id)) .. ":26:26\124t Auto Invi",
			tooltip = "It will be using Prowl when possible",
			enabled = enables["Invi"],
			key = "Invi"
		},
		{
			type = "entry",
			text = "\124T" .. select(3, GetSpellInfo(spells.RavageCat.id)) .. ":26:26\124t Ravage opener",
			tooltip = "It will will use ravage for opening if not Pounce",
			enabled = enables["Ravage"],
			key = "Ravage"
		},
		{
			type = "entry",
			text = "\124T" .. select(3, GetSpellInfo(spells.BashBear.id)) .. ":26:26\124t Interrupt for pvp",
			tooltip = "It will will use everything to interrupt players",
			enabled = enables["InterruptPVP"],
			key = "Ravage"
		},
		{
			type = "entry",
			text = "\124T" .. select(3, GetSpellInfo(spells.SwipeCat.id)) .. ":26:26\124t Cat AOE ",
			tooltip = "Swipe on mobspack",
			enabled = enables["CatAoe"],
			value = values["CatAoe"],
			key = "CatAoe"
		},

		-- {type = "page", number = 3, text = "\124T" .. select(3, GetSpellInfo(spells.BearForm.id))..":26:26\124t|cff71C671Bear Settings|r"},
		{
			type = "separator",
		},
		{
			type = "entry",
			text = "\124T" .. select(3, GetSpellInfo(spells.ThrashBear.id)) .. ":26:26\124t Bear AOE ",
			tooltip = "AOE rotation Tharsh and Swipe",
			enabled = enables["BearAoe"],
			value = values["BearAoe"],
			key = "BearAoe"
		},
		{
			type = "entry",
			text = "\124T" .. select(3, GetSpellInfo(spells.FrenziedRegenerationBear.id)) .. ":26:26\124t Frenzied Regen",
			tooltip = "Auto use Frenzied Regeneration",
			enabled = enables["FrenziedRegen"],
			value = values["FrenziedRegen"],
			key = "FrenziedRegen"
		},
		{
			type = "entry",
			text = "\124T" .. select(3, GetSpellInfo(spells.GrowlBear.id)) .. ":26:26\124t Auto Taunt",
			tooltip = "Auto use taunt when no agro",
			enabled = enables["Taunt"],
			key = "Taunt"
		},
		{
			type = "entry",
			text = "\124T" .. select(3, GetSpellInfo(spells.SkullBashBear.id)) .. ":26:26\124t Auto interrupt bear",
			tooltip = "Auto interrupt",
			enabled = enables["InterruptBear"],
			key = "InterruptBear"
		},

	}

	local function onload()
		ni.GUI.AddFrame("feral-cata", items)
		print("Rotation \124cFF15E615feral cata")
	end
	local function onunload()
		ni.GUI.DestroyFrame("feral-cata ")
		print("Rotation \124cFFE61515stopped!")
	end

	SLASH_STUNT1 = "/STUNT"
	SlashCmdList["STUNT"] = function(msg)
		if ni.spell.cd(spells.BashBear.id) == 0
		then
			ni.spell.castqueue(spells.BashBear.id, "target")
		end
	end

	SLASH_CHARGES1 = "/charges"
	SlashCmdList["CHARGES"] = function(msg)
		if ni.spell.cd(16979) == 0
				and ni.player.buff(spells.BearForm.id) then
			-- ni.spell.cast(16979, "mouseover")
			-- ni.spell.cast(16979, "target")
			-- ni.player.lookat("mouseover")
			ni.player.runtext("/cast [@mouseover,harm,nodead][]Feral Charge(Bear Form)")
		else
			if ni.spell.cd(49376) == 0
					and ni.player.buff(spells.CatForm.id) then
				-- ni.spell.cast(49376, "mouseover")
				-- ni.spell.cast(16979, "target")
				-- ni.player.lookat("mouseover")
				ni.player.runtext("/cast [@mouseover,harm,nodead][]Feral Charge(Cat Form)")
			end
		end
	end
	SLASH_SB1 = "/sb"
	SlashCmdList["SB"] = function(msg)
		if ni.spell.cd(spells.SkullBashCat.id) == 0 then
			local enemies = ni.unit.enemiesinrange("player", 13)
			for i = 1, #enemies do
				local target = enemies[i].guid
				local name = enemies[i].name
				if ni.spell.shouldinterrupt(target)
						and (ni.unit.castingpercent(target) >= 70
							or ni.unit.ischanneling(target))
				then
					if ni.player.buff(spells.CatForm.id) then
						ni.player.lookat(target)
						ni.spell.cast(spells.SkullBashCat.id, target)
						print("skullbash " .. name)
					else
						if
								ni.player.buff(spells.BearForm.id) then
							ni.player.lookat(target)
							ni.spell.cast(spells.SkullBashBear.id, target)
							print("skullbash " .. name)
						end
					end
				end
			end
		end
	end

	SLASH_SHREDS1 = "/shreds"
	SlashCmdList["SHREDS"] = function(msg)
		if not ni.player.buff(spells.CatForm.id) then
			ni.spell.cast(spells.CatForm.id)
		else
			ni.player.lookat("target")
			if ni.unit.isbehind("player", "target")
					and IsUsableSpell(spells.ShredCat.name) then
				ni.player.lookat("target")
				ni.spell.cast(spells.ShredCat.id)
			elseif not ni.unit.isbehind("player", "target")
					and ni.player.powerraw("energy") >= 45 then
				ni.player.lookat("target")
				ni.spell.cast(spells.MangleCat.id, "target")
			end
		end
	end

	SLASH_BOMB1 = "/bomb"
	SlashCmdList["BOMB"] = function(msg)
		if ni.player.itemcd(63396) == 0
		then
			ni.player.useitem(63396)
			ni.player.clickat("target")
		end
	end


	-- local function BagSpace()
	--     local c = 0
	--     for bag = 0, NUM_BAG_SLOTS do
	--         local freeSlots = GetContainerNumFreeSlots(bag)
	--         c = c + freeSlots
	--     end
	--     return c
	-- end
	-- local looting
	-- local LootedUnits = {}
	-- function Loot(guid)
	--     ni.player.interact(guid)
	--     if _G.LootFrame:IsShown() then
	--         for i=1, GetNumLootItems() do
	--             looting = true
	--             LootSlot(i)
	--         end
	--         if looting then
	--             ni.delayfor(1, function()
	--                 looting = false
	--                 LootedUnits[guid] = true
	--                 CloseLoot()
	--             end)
	--         end
	--     end
	--     return looting
	-- end

	local t, p = "target", "player"

	local queue = {
		-- "test",
		"GOW",
		-- "AutoLook",
		-- "AutoLoot",
		"Auto Target",
		-- "Noggenfogger",
		"INVI",
		"Ravage",
		"Pause Rotation",
		"test",
		"Potion",
		"Healthstone",
		"Start Attack",
		"AutoAttack",
		"CycloneFocus",
		"InterruptPVP",
		-- "Jump",
		"Primal Madness",
		"CatForm",
		"RavageJump",
		"Tigers",
		"FaerieFire",
		"SwipeCat",
		-- "FBL",
		"FB25R",
		"FB25",
		"ShredCC",
		-- "MangleBuff4tier",
		"MangleDebuff",
		"Shred100",
		"ShredCC",
		"Rip",
		"SavageRoar",
		"Ingrediente Secreto",
		"Rake",
		"Shred",
		-- "SkullBash",
		"FB",
		--bear
		-- "InterruptBear",
		-- "SkullBashBear",
		"FrenziedRegenerationBear",
		"Taunt",
		"Thrash",
		"MangleBerserk",
		"MangleBear",
		"SwipeBear",
		"Pulverize",
		"MaulBear",
		"Demoralazing",
		"LacerateBear",
		"LacerateBear3",
		"LacerateBearFiller",
		--leveling
		-- "Moonfire",
		-- "Wrath",
		-- "AutoAttack"
	}


	local abilities = {
		-- ["test"] = function()
		-- 	if select(5, GetTalentInfo(2, 19)) == 2 then
		-- 		print("caca")
		-- 	end
		-- end,

		["Potion"] = function()
			if ni.player.hasitem(57191)
					and IsUsableItem(57191)
					and ni.player.itemcd(57191) < 1
					and UnitAffectingCombat("player")
					and ni.player.hp() < 14
			then
				ni.player.useitem(57191)
			end
		end,
		["Healthstone"] = function()
			if ni.player.hasitem(5512)
					and ni.player.itemcd(5512) < 1
					and UnitAffectingCombat("player")
					and ni.player.hp() < 30
			then
				ni.player.useitem(5512)
			end
		end,



		["Noggenfogger"] = function()
			if ni.player.buffremaining(16591, "EXACT") < 100
					and not UnitAffectingCombat("player")
					and not IsMounted()
					and ni.player.itemcd(8529) == 0
			then
				ni.player.useitem(8529)
			end
		end,

		["GOW"] = function()
			if not ni.player.buff(79060)
					and not ni.player.buff(79063)
					and not UnitAffectingCombat("player")
					and ni.spell.available(spells.MarkoftheWild.name) then
				ni.spell.cast(spells.MarkoftheWild.name, p)
				print("Bufo")
			end
		end,

		["Pause Rotation"] = function()
			if IsMounted()
					or UnitIsDeadOrGhost(p)
					or ni.unit.iscasting("player")
					or not UnitAffectingCombat(p)
					or ni.unit.buff(p, "Drink") then
				return true;
			end
		end,

		["Start Attack"] = function()
			if UnitAffectingCombat("player")
					and ((ni.unit.exists("target")
							and UnitIsDeadOrGhost("target")
							and not UnitCanAttack("player", "target"))
						or not ni.unit.exists("target")) then
				ni.player.runtext("/targetenemy")
				return true;
			end
		end,
		-- ["Wrath"] = function ()
		-- 	local _, enabled = GetSetting("getSetting_Castlevel")
		-- 	if enabled then
		-- 	if not ni.player.buff(spells.CatForm.id)
		-- 	and not ni.player.buff(spells.BearForm.id)
		-- 	and ni.spell.available(spells.Wrath.id) then
		--    ni.spell.cast(spells.Wrath.id, t)
		-- 	end
		-- end
		-- end,

		-- ["Moonfire"] = function()
		-- 	local _, enabled = GetSetting("getSetting_Castlevel")
		-- 	if enabled then
		-- 	if not ni.player.buff(spells.CatForm.id)
		-- 	and not ni.player.buff(spells.BearForm.id)
		-- 	and ni.spell.available(spells.Moonfire.id, t) and
		-- 			ni.unit.debuffremaining(t, spells.Moonfire.id, p) < 2
		-- 	 then ni.spell.cast(spells.Moonfire.id, t)
		-- 	end
		-- end
		-- end,
		["AutoAttack"] = function()
			if UnitExists(t)
					and ni.unit.inmelee(p, t)
					and not UnitIsDeadOrGhost("target")
					and UnitAffectingCombat("player")
					and ni.unit.buff("player", spells.CatForm.id, "player")
					and not ni.unit.buff("player", spells.ProwlCat.id, "player")
					and not IsCurrentSpell(6603) then
				ni.spell.cast(spells.AutoAttack.name)
			end
		end,
		["AutoLook"] = function()
			if UnitExists(t)
					and ni.unit.inmelee(p, t)
			then
				ni.player.lookat(t)
			end
		end,
		["Auto Target"] = function()
			if UnitAffectingCombat("player")
					and ((UnitExists(t)
							and UnitIsDeadOrGhost("target")
							and not UnitCanAttack("player", "target"))
						or not ni.unit.exists("target")) then
				ni.player.runtext("/targetenemy")
				ni.player.lookat(t)
				return true;
			end
		end,

		["CatForm"] = function()
			if enables["CatForm"] then
				if not ni.player.buffs(spells.CatForm.id) and ni.spell.available(spells.CatForm.id) then
					if not ni.player.buff(spells.BearForm.id) then
						ni.spell.cast(spells.CatForm.id)
					elseif ni.player.buffs(spells.BearForm.id) then
					end
				end
			end
		end,
		["CycloneFocus"] = function()
			if enables["CycloneFocus"] then
				if ni.player.buff(69369)
						and ni.unit.exists("focus")
						and not ni.unit.debuff("focus", spells.Cyclone.name)
						and ni.unit.los("player", "focus")
						and ni.unit.distance("player", "focus") < 21
				then
					ni.spell.cast(spells.Cyclone.name, "focus")
					print("Cyclone")
				end
			end
		end,

		["INVI"] = function()
			if enables["Invi"] then
				if ni.spell.available(spells.ProwlCat.id)
						and ni.player.buff(spells.CatForm.id)
						and not UnitAffectingCombat(p)
						and not ni.unit.buff(p, spells.ProwlCat.id, p)
				then
					ni.spell.cast(spells.ProwlCat.id)
				end
			end
		end,
		["Ravage"] = function()
			if enables["Ravage"] then
				if ni.player.buff(spells.ProwlCat.id)
						and ni.player.buff(spells.CatForm.id)
						and ni.spell.available(spells.RavageCat.id)
						and ni.spell.valid(t, spells.RavageCat.id, true, true)

						and ni.unit.isbehind(p, t)
				then
					ni.spell.cast(spells.RavageCat.name)
					print("Ravage")
				end
			else
				if ni.player.buff(spells.ProwlCat.id)
						and ni.spell.valid(t, spells.PounceCat.id, true, true)
				then
					ni.spell.cast(spells.PounceCat.name)
					print("Pounce")
				end
			end
		end,

		["RavageJump"] = function()
			if ni.player.buff(81022)
					and ni.player.buff(spells.CatForm.id)
					and ni.spell.cd(spells.RavageCat.id) == 0
					and ni.unit.inmelee(p, t)
			then
				ni.spell.cast(spells.RavageCat.name)
				print("Ravage")
			end
		end,
		["Jump"] = function()
			local tar = ni.objects["target"];
			if tar:exists() and tar:distance() > 8
					and tar:distance() < 25
					and ni.player.buff(spells.CatForm.id)
					and UnitExists(t)
					and ni.spell.available(49376)
			then
				ni.player.stopmoving()
				ni.player.lookat(t)
				ni.spell.cast(49376)
				print("Saltanding")
				return true
			end
		end,
		["InterruptBear"] = function()
			if enables["InterruptBear"] then
				if ni.spell.cd(16979) == 0
						and ni.player.buff(spells.BearForm.id)
				then
					local enemies = ni.unit.enemiesinrange("player", 25)
					for i = 1, #enemies do
						local target = enemies[i].guid
						local name = enemies[i].name
						local distance = enemies[i].distance
						if ni.unit.isplayer(target)
								and distance >= 8
								and ni.spell.shouldinterrupt(target)
								and (ni.unit.castingpercent(target) >= 80
									or ni.unit.ischanneling(target))
								and ni.spell.valid(target, 16979, false, true)
						then
							ni.player.lookat(target)
							ni.spell.cast(16979, target)
							print("Charge " .. name)
						end
					end
				end
			end
		end,

		["InterruptPVP"] = function()
			if enables["InterruptPVP"] then
				if ni.player.buff(spells.CatForm.id)
						and not ni.player.buff(spells.ProwlCat.id)
				then
					if ni.spell.cd(spells.SkullBashCat.id) == 0 -- SKullbash from cat
					then
						local enemies = ni.unit.enemiesinrange("player", 13)
						for i = 1, #enemies do
							local target = enemies[i].guid
							local name = enemies[i].name
							if ni.unit.isplayer(target)
									and ni.unit.iscasting(target)
									and (ni.unit.ischanneling(target)
										or ni.unit.castingpercent(target) >= 60)
									and ni.player.los(target)
									and ni.player.powerraw("energy") > 5
							then
								ni.player.lookat(target)
								ni.spell.cast(spells.SkullBashCat.id, target)
								print("SkullBash PVPINTERRUPT " .. name)
							end
						end
					else
						if GetComboPoints(p, t) >= 1
								and ni.unit.isplayer(t)
								and ni.unit.iscasting(t)
								and (ni.unit.ischanneling(t)
									or ni.unit.castingpercent(t) >= 70)
						then
							ni.player.lookat(t)
							ni.spell.cast(spells.MaimCat.id, t)
							print("MAIM PVPINTERRUPT " .. t)
						end
					end
				else
					if ni.player.buff(spells.BearForm.id)
					then
						if ni.spell.cd(spells.SkullBashBear.id) == 0
						then
							local enemies = ni.unit.enemiesinrange("player", 13)
							for i = 1, #enemies do
								local target = enemies[i].guid
								local name = enemies[i].name
								local distance = enemies[i].distance
								if ni.unit.isplayer(target)
										and ni.unit.iscasting
										and (ni.unit.ischanneling(target)
											or ni.unit.castingpercent(target) >= 60)
										and ni.player.los(target)
										and ni.spell.valid(target, spells.SkullBashBear.id, false, true)
								then
									ni.player.lookat(target)
									ni.spell.cast(spells.SkullBashBear.id, target)
									print("SkullBash PVPINTERRUPT " .. name)
								end
							end
						elseif ni.spell.cd(16979) == 0
						then
							local enemies = ni.unit.enemiesinrange("player", 25)
							for i = 1, #enemies do
								local target = enemies[i].guid
								local name = enemies[i].name
								local distance = enemies[i].distance
								if ni.unit.isplayer(target)
										and distance >= 8
										and ni.unit.iscasting
										and (ni.unit.ischanneling(target)
											or ni.unit.castingpercent(target) >= 30)
										and ni.player.los(target)
										and ni.spell.valid(target, 16979, false, true)
								then
									ni.player.lookat(target)
									ni.spell.cast(16979, target)
									print("Charge PVPINTERRUPT " .. name)
								end
							end
						else
							if ni.spell.cd(spells.BashBear.id) == 0
							then
								local enemies = ni.unit.enemiesinrange("player", 3)
								for i = 1, #enemies do
									local target = enemies[i].guid
									local name = enemies[i].name
									if ni.unit.isplayer(target)
											and ni.unit.iscasting
											and (ni.unit.ischanneling(target)
												or ni.unit.castingpercent(target) >= 50)
											and ni.player.power("rage") >= 10
											and ni.player.inmelee(target)
									then
										ni.player.lookat(target)
										ni.spell.cast(spells.BashBear.id, target)
										print("Bashed PVPINTERRUPT " .. name)
									end
								end
							end
						end
					end
				end
			end
		end,

		["SkullBashBear"] = function()
			if enables["InterruptBear"] then
				if ni.spell.cd(spells.SkullBashBear.id) == 0
						and ni.player.buff(spells.BearForm.id)
				then
					local enemies = ni.unit.enemiesinrange("player", 15)
					for i = 1, #enemies do
						local target = enemies[i].guid
						local name = enemies[i].name
						local distance = enemies[i].distance

						if ni.unit.creaturetype(target) ~= 11
								and distance < 11
								and ni.spell.shouldinterrupt(target)
								and (ni.unit.castingpercent(target) >= 80
									or ni.unit.ischanneling(target))
						then
							ni.spell.cast(spells.SkullBashBear.id, target)
							print("skullbash " .. name)
						end
					end
				end
			end
		end,

		["MangleDebuff"] = function()
			if enables["FullAutomated"] then
				if ni.player.buff(spells.CatForm.id)
						and ni.unit.debuffremaining(t, spells.MangleCat.name) < 2.5
						and not ni.unit.debuff(t, spells.MangleBear.name)
						and not ni.unit.debuff(t, 46857)
						and UnitExists(t)
						and ni.unit.inmelee(p, t)
						and ni.player.powerraw("energy") >= 35
				then
					ni.spell.cast(spells.MangleCat.id)
				end
			end
		end,
		["MangleBuff4tier"] = function()
			if ni.player.buff(spells.CatForm.id)
					and GetComboPoints("player", "target") < 5
					and ni.player.powerraw("energy") >= 35
					and (ni.player.buffstacks(90166) < 3
						or ni.player.buffremaining(90166) < 3)
			then
				ni.spell.cast(spells.MangleCat.id)
			end
		end,
		["FaerieFire"] = function()
			if ni.spell.cd(spells.FaerieFireFeral.name) == 0
					and not ni.player.buff(spells.ProwlCat.id)
					and not ni.unit.debuff(t, 91565)
					and (ni.player.powerraw("energy") < 20
						or not ni.unit.inmelee(p, t)
						and UnitExists(t))
			then
				ni.spell.cast(spells.FaerieFireFeral.name, t)
			end
		end,

		["Rake"] = function()
			if enables["FullAutomated"] then
				if ni.player.buff(spells.CatForm.id)
						and not ni.unit.debuff(t, spells.RakeCat.id, p)
						and UnitExists(t)
						and GetComboPoints("player", "target") < 5
				then
					ni.spell.cast(spells.RakeCat.id)
				end
			end
		end,
		["Shred"] = function()
			if enables["FullAutomated"] then
				if ni.player.buff(spells.CatForm.id)
						and ni.unit.inmelee(p, t)
						and IsUsableSpell(spells.ShredCat.name)
						and GetComboPoints("player", "target") < 5
				then
					if ni.unit.isbehind("player", "target") then
						ni.spell.cast(spells.ShredCat.id)
					elseif not ni.unit.isbehind("player", "target")
							and ni.player.powerraw("energy") >= 50
					then
						ni.spell.cast(spells.MangleCat.id, "target")
					end
				end
			end
		end,
		["Shred100"] = function()
			if ni.player.buff(spells.CatForm.id)
					and ni.unit.debuffremaining(t, spells.RipCat.id, p) >= 3
					and ni.player.powerraw("energy") >= 98
					and ni.unit.inmelee(p, t)
			then
				if ni.unit.isbehind("player", "target")
				then
					ni.spell.cast(spells.ShredCat.id)
				elseif not ni.unit.isbehind("player", "target")
				then
					ni.spell.cast(spells.MangleCat.id, "target")
				end
			end
		end,

		["ShredCC"] = function()
			if ni.player.buff(spells.CatForm.id)
					and ni.player.buff(16870)
					and ni.unit.inmelee(p, t)
					and GetComboPoints("player", "target") < 5
			then
				if ni.unit.isbehind("player", "target")
				then
					ni.spell.cast(spells.ShredCat.id)
				elseif not ni.unit.isbehind("player", "target")
				then
					ni.spell.cast(spells.MangleCat.id, "target")
				end
			end
		end,
		["SavageRoar"] = function()
			if enables["FullAutomated"] then
				if ni.player.buff(spells.CatForm.id)
						and ni.player.buffremaining(spells.SavageRoarCat.name) < 3
						and GetComboPoints("player", "target") > 1 then
					ni.spell.cast(spells.SavageRoarCat.name, t)
				end
			end
		end,

		["Ingrediente Secreto"] = function()
			if enables["FullAutomated"] then
				if ni.player.buff(spells.CatForm.id) then
					local sr_remains = ni.player.buffremaining(spells.SavageRoarCat.name)
					local rip_remains = ni.unit.debuffremaining(t, spells.RipCat.id, p)
					if rip_remains > 0
							and sr_remains > 0
							and (rip_remains - sr_remains) < 3
							and rip_remains < 13 and sr_remains < 13
							and rip_remains > sr_remains then
						ni.spell.cast(spells.SavageRoarCat.name, t)
					elseif sr_remains < 3 and GetComboPoints("player", "target") > 1 then
						ni.spell.cast(spells.SavageRoarCat.name, t)
					end
				end
			end
		end,
		["Tigers"] = function()
			if enables["FullAutomated"] then
				if ni.player.buff(spells.CatForm.id)
						and ni.unit.inmelee("player", "target")
						and ni.spell.cd(spells.TigersFuryCat.id) == 0
						and (ni.player.power() < 40 or
							(ni.unit.debuffremaining(t, spells.RipCat.id, p) < 3
								and ni.player.power() < 55)) then
					ni.spell.cast(spells.TigersFuryCat.id)
				end
			end
		end,

		["Primal Madness"] = function()
			if ni.player.buff(80886)
					and ni.player.power() < 15 then
				ni.player.runtext("/cancelaura Primal Madness")
			end
		end,
		["Rip"] = function()
			if enables["FullAutomated"] then
				if ni.player.buff(spells.CatForm.id)
						and ni.unit.inmelee(p, t)
						and (ni.spell.cd(spells.TigersFuryCat.id) >= 3
							or ni.player.powerraw("energy") >= 97)
						and ni.unit.debuffremaining(t, spells.RipCat.id, p) < 2
						and GetComboPoints(p, t) == 5
						and ni.spell.available(spells.RipCat.id)
				then
					if ni.vars.combat.cd
							and ni.spell.cd(50334) > 61 then
						ni.player.runtext("/use 10")
						ni.spell.cast(spells.RipCat.id, t)
						print("Guantes")
					else
						ni.spell.cast(spells.RipCat.id, t)
						print("sin guantes")
					end
				end
			end
		end,
		-- ["FBL"] = function()
		-- 	if ni.player.buff(spells.CatForm.id)
		-- 	and not ni.unit.isboss (t)
		-- 	and  ni.unit.ttd(t) > 20
		-- 	and ni.unit.hpraw(t)< 20000
		-- 	and GetComboPoints(p, t)> 3
		-- 	then
		-- 		ni.spell.cast (spells.FerociousBiteCat.id, t)
		-- 		print ("sd")
		-- 	end
		-- end,
		["FB"] = function()
			if ni.player.buff(spells.CatForm.id)
					and ni.unit.inmelee(p, t)
					and ni.unit.debuffremaining(t, spells.RipCat.id, p) > 10
					and ni.player.buffremaining(spells.SavageRoarCat.id) > 10
					and GetComboPoints(p, t) == 5
			then
				ni.spell.cast(spells.FerociousBiteCat.id, t)
			end
		end,
		["FB25"] = function()
			local Bloodonwater = select(5, GetTalentInfo(2, 19))
			if ni.player.buff(spells.CatForm.id)
					and Bloodonwater == 2
					and ni.unit.inmelee(p, t)
					and ni.unit.debuff(t, spells.RipCat.id, p)
					and ni.unit.hp(t) < 25
					and GetComboPoints(p, t) == 5
			then
				ni.spell.cast(spells.FerociousBiteCat.id, t)
			end
		end,
		["FB25R"] = function()
			local Bloodonwater = select(5, GetTalentInfo(2, 19)) == 2
			if ni.player.buff(spells.CatForm.id)
					and Bloodonwater == 2
					and ni.unit.inmelee(p, t)
					and ni.unit.hp(t) < 25
					and ni.unit.debuff(t, spells.RipCat.id, p)
					and ni.unit.debuffremaining(t, spells.RipCat.id, p) < 3
					and GetComboPoints(p, t) >= 1
			then
				ni.spell.cast(spells.FerociousBiteCat.id, t)
				return true
			end
		end,
		["FrenziedRegenerationBear"] = function()
			if enables["FrenziedRegen"]
					and ni.spell.cd(spells.FrenziedRegenerationBear.name) == 0
					and ni.player.buff(spells.BearForm.id)
					and ni.player.hp() < values["FrenziedRegen"]
			then
				ni.spell.cast(spells.FrenziedRegenerationBear.name)
			end
		end,
		["Taunt"] = function()
			if enables["Taunt"] then
				if ni.spell.cd(spells.GrowlBear.name) == 0
						and ni.player.buff(spells.BearForm.id)
						and UnitExists(t)
						and UnitAffectingCombat("player")
						and ni.unit.exists("target")
						and not UnitIsUnit("player", "targetta")
				then
					ni.spell.cast(spells.GrowlBear.name, "target")
				end
			end
		end,
		["Demoralazing"] = function()
			if ni.player.buff(spells.BearForm.id)
					and not UnitIsDeadOrGhost(t)
					and ni.unit.inmelee(p, t)
					and not ni.unit.debuff("target", spells.DemoralizingRoarBear.id)
					and not ni.unit.debuff("target", 81130) -- Scarlet Feever
					and not ni.unit.debuff("target", 26017) --vindication
					and not ni.unit.debuff("target", 1160) -- Demo Shout
					and ni.spell.available(spells.DemoralizingRoarBear.id)
			then
				ni.spell.cast(spells.DemoralizingRoarBear.id)
			end
		end,

		["Thrash"] = function()
			local enemies = ni.unit.enemiesinrange("player", 8)
			if enables["BearAoe"]
					and ni.vars.combat.aoe
					and #enemies >= values["BearAoe"]
					and ni.player.buff(spells.BearForm.id)
					and ni.spell.available(spells.ThrashBear.name) then
				ni.spell.cast(spells.ThrashBear.name)
			end
		end,
		["SwipeBear"] = function()
			local enemies = ni.unit.enemiesinrange("player", 7)
			if enables["BearAoe"]
					and ni.vars.combat.aoe
					and #enemies >= values["BearAoe"]
					and ni.player.buff(spells.BearForm.id)
					and ni.spell.available(spells.SwipeBear.name) then
				ni.spell.cast(spells.SwipeBear.id)
			end
		end,
		["SwipeCat"] = function()
			local enemies = ni.unit.enemiesinrange("player", 7)
			if enables["CatAoe"]
					and ni.vars.combat.aoe
					and #enemies >= values["CatAoe"]
					and ni.player.buff(spells.CatForm.id)
			then
				ni.player.runtext("/starattack")
				ni.spell.cast(spells.SwipeCat.id)
				return true;
			end
		end,

		["MangleBerserk"] = function()
			if ni.player.buff(spells.BearForm.id)
					and ni.player.buff('50334')
					and ni.unit.inmelee(p, t)
			then
				ni.spell.cast(spells.MangleBear.id, t)
			end
		end,
		["MangleBear"] = function()
			if ni.spell.cd(spells.MangleBear.id) == 0
					and ni.player.buff(spells.BearForm.id)
					and ni.unit.inmelee(p, t)
			then
				ni.spell.cast(spells.MangleBear.id, t)
			end
		end,

		["LacerateBear"] = function()
			if ni.player.buff(spells.BearForm.id)
					and ni.unit.debuffremaining(t, spells.LacerateBear.id, p) < 2
					and ni.spell.available(spells.LacerateBear.id)
					and ni.unit.inmelee(p, t)
			then
				ni.spell.cast(spells.LacerateBear.id, t)
			end
		end,

		["LacerateBear3"] = function()
			if ni.player.buff(spells.BearForm.id)
					and ni.unit.debuffstacks(t, spells.LacerateBear.id, p) < 3
					and ni.spell.available(spells.LacerateBear.id)
					and ni.unit.inmelee(p, t)
			then
				ni.spell.cast(spells.LacerateBear.id, t)
			end
		end,

		["MaulBearFiller"] = function()
			if ni.player.buff(spells.BearForm.id)
					and ni.player.powerraw("rage") > 30
					and ni.unit.inmelee(p, t) then
				if ni.spell.cd(spells.MaulBear.id) == 0 then
					ni.spell.cast(spells.MaulBear.id)
				else
					if
							ni.spell.cd(spells.ThrashBear.id) == 0 then
						ni.spell.cast(spells.ThrashBear.id)
						return true
					end
				end
			end
		end,

		["LacerateBearFiller"] = function()
			if ni.player.buff(spells.BearForm.id)
					and ni.spell.available(spells.LacerateBear.id)
					and ni.unit.inmelee(p, t)
			then
				ni.spell.cast(spells.LacerateBear.id, t)
			end
		end,
		["Pulverize"] = function()
			local Pulverizetalent = select(5, GetTalentInfo(2, 21))
			if ni.player.buff(spells.BearForm.id)
					and Pulverizetalent == 1
					and ni.unit.debuffstacks(t, spells.LacerateBear.id, p) > 2
					and ni.player.buffremaining(80951) < 3
					and ni.spell.available(spells.Pulverize.id)
					and ni.unit.inmelee(p, t) then
				ni.spell.cast(spells.Pulverize.id)
			end
		end,

		["MaulBear"] = function()
			if ni.player.buff(spells.BearForm.id)
					and ni.player.powerraw("rage") > 60
					and ni.unit.inmelee(p, t) then
				if ni.spell.cd(spells.MaulBear.id) == 0 then
					ni.spell.cast(spells.MaulBear.id)
				else
					if
							ni.spell.cd(spells.ThrashBear.id) == 0 then
						ni.spell.cast(spells.ThrashBear.id)
						return true
					end
				end
			end
		end,
		-- Shredcc skullbash
	}
	ni.bootstrap.profile("Dalvae Feral - Cata", queue, abilities, onload, onunload);
else
	local queue = {
		"Error",
	};
	local abilities = {
		["Error"] = function()
			ni.vars.profiles.enabled = false;
			if not cata then
				ni.frames.floatingtext:message("This profile for Cata")
			end
		end,
	};
	ni.bootstrap.profile("Dalvae Feral - Cata", queue, abilities);
end
;
---------------------------------------------------------------------------------------------[[
-- TODO
-- local units = ni.unit.unitstargeting("player")

-- for i = 1, #units do
--   local target = units[i].guid
--   local name = units[i].name
--   local distance = units[i].distance
--   -- Do something with the units targeting the player
-- end


-- Optimizar los loops

--Autoatack , auto target mas safe sumado al fairy fire
-- Arreglar la gui
-- Arreglar Healing potion
-- Arreglar comparten reduccion de atack
