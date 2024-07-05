--------------------------------
-- TaptoRotations  - Feral Pvp
-- Version - 1.0.3
-- Author - Tapto
--------------------------------
-- Changelog
-- 1.0.0 Initial release
-- 1.0.1  Ported to Ni.V2
-- 1.0.2 Added local spells
-- 1.0.3 Added 3 interrupts
-- 1.0.4 Added Slash commands for better assist
-- 1.0.5 Added Antislow
-- 1.0.6 Added Bear rotation
--------------------------------
-- TODO
-- GUI  for enabled assist or full automatic mode
-- AbolishPoison on low Hp on healer
-- Auto Innervate on slash command

local build = select(4, GetBuildInfo());
local wotlk = build == 30300 or false;
if wotlk then
	local spells = {
		--Cat
		CatForm = { id = 768, name = GetSpellInfo(768), icon = select(3, GetSpellInfo(768)) },
		Manglecat = { id = 48566, name = GetSpellInfo(48566), icon = select(3, GetSpellInfo(48566)) },
		Rip = { id = 49800, name = GetSpellInfo(49800), icon = select(3, GetSpellInfo(49800)) },
		Rake = { id = 48574, name = GetSpellInfo(48574), icon = select(3, GetSpellInfo(48574)) },
		SavageRoar = { id = 52610, name = GetSpellInfo(52610), icon = select(3, GetSpellInfo(52610)) },
		Prowl = { id = 5215, name = GetSpellInfo(5215), icon = select(3, GetSpellInfo(5215)) },
		TigersFury = { id = 50213, name = GetSpellInfo(50213), icon = select(3, GetSpellInfo(50213)) },
		Maim = { id = 49802, name = GetSpellInfo(49802), icon = select(3, GetSpellInfo(49802)) },
		InstantCast = { id = 69369, name = GetSpellInfo(69369), icon = select(3, GetSpellInfo(69369)) },
		FerociusBite = { id = 48577, name = GetSpellInfo(48577), icon = select(3, GetSpellInfo(48577)) },
		Pounce = { id = 49803, name = GetSpellInfo(49803), icon = select(3, GetSpellInfo(49803)) },
		FaerieFire = { id = 16857, name = GetSpellInfo(16857), icon = select(3, GetSpellInfo(16857)) },
		Shred = { id = 48572, name = GetSpellInfo(48572), icon = select(3, GetSpellInfo(48572)) },
		SurvivalInstinct = { id = 61336, name = GetSpellInfo(61336), icon = select(3, GetSpellInfo(61336)) },
		Barkskin = { id = 22812, name = GetSpellInfo(22812), icon = select(3, GetSpellInfo(22812)) },
		Berserk = { id = 50334, name = GetSpellInfo(50334), icon = select(3, GetSpellInfo(50334)) },
		--Bear
		BearForm = { id = 9634, name = GetSpellInfo(9634), icon = select(3, GetSpellInfo(9634)) },
		MangleBear = { id = 48564, name = GetSpellInfo(48564), icon = select(3, GetSpellInfo(48564)) },
		Maul = { id = 48480, name = GetSpellInfo(48480), icon = select(3, GetSpellInfo(48480)) },
		Lacerate = { id = 48568, name = GetSpellInfo(48568), icon = select(3, GetSpellInfo(48568)) },
		Demoralazing = { id = 48560, name = GetSpellInfo(48560), icon = select(3, GetSpellInfo(48560)) },
		Enrage = { id = 5229, name = GetSpellInfo(5229), icon = select(3, GetSpellInfo(5229)) },
		FrenziedRegeneration = { id = 22842, name = GetSpellInfo(22842), icon = select(3, GetSpellInfo(22842)) },
		Charge = { id = 16979, name = GetSpellInfo(16979), icon = select(3, GetSpellInfo(16979)) },
		Bash = { id = 8983, name = GetSpellInfo(8983), icon = select(3, GetSpellInfo(8983)) },
		-- Resto
		Rejuv = { id = 48441, name = GetSpellInfo(48441), icon = select(3, GetSpellInfo(48441)) },
		Lifebloom = { id = 48451, name = GetSpellInfo(48451), icon = select(3, GetSpellInfo(48451)) },
		Regrowth = { id = 48443, name = GetSpellInfo(48443), icon = select(3, GetSpellInfo(48443)) },
		Nourish = { id = 50464, name = GetSpellInfo(50464), icon = select(3, GetSpellInfo(50464)) },
		HealingTouch = { id = 48378, name = GetSpellInfo(48378), icon = select(3, GetSpellInfo(48378)) },
		GOTW = { id = 48470, name = GetSpellInfo(48470), icon = select(3, GetSpellInfo(48470)) },
		Thorns = { id = 26992, name = GetSpellInfo(26992), icon = select(3, GetSpellInfo(26992)) },
		AbolishPoison = { id = 2893, name = GetSpellInfo(2893), icon = select(3, GetSpellInfo(2893)) },
		RemoveCurse = { id = 2782, name = GetSpellInfo(2782), icon = select(3, GetSpellInfo(2782)) },
		Tranquility = { id = 48447, name = GetSpellInfo(48447), icon = select(3, GetSpellInfo(48447)) },
		-- Balance
		Moonfire = { id = 8921, name = GetSpellInfo(8921), icon = select(3, GetSpellInfo(8921)) },
		Inervate = { id = 29166, name = GetSpellInfo(29166), icon = select(3, GetSpellInfo(29166)) },
		Roots = { id = 26989, name = GetSpellInfo(26989), icon = select(3, GetSpellInfo(26989)) },
		Cyclone = { id = 33786, name = GetSpellInfo(33786), icon = select(3, GetSpellInfo(33786)) },
		SoothePet = { id = 588, name = GetSpellInfo(588), icon = select(3, GetSpellInfo(588)) },
		Hibernate = { id = 18658, name = GetSpellInfo(18658), icon = select(3, GetSpellInfo(18658)) },
		ClearCast = { id = 16870, name = GetSpellInfo(16870), icon = select(3, GetSpellInfo(16870)) },
		NatureGrasp = { id = 27009, name = GetSpellInfo(27009), icon = select(3, GetSpellInfo(27009)) },
	}
	local enables = {
	}
	local values = {
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
		settingsfile = "Feral-PVP.json",
		callback = GUICallback,
		{ type = "title",    text = "|cff00ccffFeral-PVP" },
		{ type = "separator" },
		{ type = "separator" },
		{
			type = "entry",
			text = "\124T" .. ":26:26\124t Auto pause when not in Combat",
			tooltip = "It going to auto start a fight if not enable",
			enabled = true,
			key = "getSetting_Pause"
		},
		{
			type = "separator",
		},
		{
			type = "title",
			text = "|cff71C671Cat Settings",
		},
		{
			type = "separator",
		},
		{
			type = "entry",
			text = "\124T" .. select(3, GetSpellInfo(spells.CatForm.id)) .. ":26:26\124t Auto Cat form",
			tooltip = "It will be in catform if its in combat",
			enabled = true,
			key = "getSetting_CatForm"
		},
		{
			type = "entry",
			text = "\124T" .. select(3, GetSpellInfo(spells.Prowl.id)) .. ":26:26\124t Auto Invi",
			tooltip = "It will be using Prowl when possible",
			enabled = true,
			key = "getSetting_Invi"
		},

		{
			type = "separator",
		},
		{
			type = "entry",
			text = "|cFFFF0000\124T" ..
					select(3, GetSpellInfo(spells.FerociusBite.id)) .. ":26:26\124t Full Automated rotation|r",
			tooltip = "It will be automatically do Rip, FB, Savage Roar NOT OPTIMAL!",
			enabled = true,
			key = "getSetting_Automated"
		},

		{
			type = "entry",
			text = "\124T" .. select(3, GetSpellInfo(spells.Berserk.id)) .. ":26:26\124t Berserk Fear",
			tooltip = "Auto Berserk when feared",
			enabled = true,
			key = "getSetting_BerserkFear"
		},

		{
			type = "entry",
			text = "\124T" .. select(3, GetSpellInfo(spells.Charge.id)) .. ":26:26\124t Charge interupt",
			tooltip = "Will Auto use feral chare on any in range target that is casting",
			enabled = true,
			key = "getSetting_ChargeBear"
		},
		{
			type = "entry",
			text = "\124T" .. select(3, GetSpellInfo(spells.Cyclone.id)) .. ":26:26\124t Cyclone interupt",
			tooltip = "Will Auto use cyclone instant cast if someone is casting",
			enabled = true,
			key = "getSetting_CycloneInterupt"
		},
		{
			type = "entry",
			text = "\124T" .. select(3, GetSpellInfo(spells.Cyclone.id)) .. ":26:26\124t Cyclone Focus",
			tooltip = "Will Auto use instant cast to cyclone focus target",
			enabled = true,
			key = "getSetting_CycloneFocus"
		},

	}

	local function GetSetting(name)
		for k, v in ipairs(items) do
			if v.type == "entry"
					and v.key ~= nil
					and v.key == name then
				return v.value, v.enabled
			end
			if v.type == "dropdown"
					and v.key ~= nil
					and v.key == name then
				for k2, v2 in pairs(v.menu) do
					if v2.selected then
						return v2.value
					end
				end
			end
			if v.type == "input"
					and v.key ~= nil
					and v.key == name then
				return v.value
			end
		end
	end
	;


	local function onload()
		ni.GUI.AddFrame("Feral PVP", items)
		print("Rotation \124cFF15E615Feral PVP")
	end

	local function onunload()
		ni.GUI.DestroyFrame("Feral PVP")
		print("Rotation \124cFFE61515stopped!")
	end


	-- Slashcommands
	SLASH_SHRED1 = "/shred"
	SlashCmdList["SHRED"] = function(msg)
		ni.player.lookat("target")
		if ni.unit.isbehind("player", "target")
				and ni.spell.available(spells.Shred.id)
				and GetComboPoints("player", "target") < 5 then
			ni.spell.cast(spells.Shred.id)
			ni.player.lookat("target")
		elseif not ni.unit.isbehind("player", "target")
				and GetComboPoints("player", "target") < 5
				and ni.player.powerraw("energy") >= 45 then
			ni.player.lookat("target")
			ni.spell.cast(spells.Manglecat.id, "target")
		end
	end

	SLASH_CHARGE1 = "/charge"
	SlashCmdList["CHARGE"] = function(msg)
		if ni.spell.cd(spells.Charge.id) == 0 then
			ni.player.runtext("/cast [noform:1] Dire Bear Form")
			ni.player.lookat("mouseover")
			ni.player.runtext("/cast [@mouseover,harm,nodead][]Feral Charge - Bear()")
		end
	end

	SLASH_HEAL1 = "/heal"
	SlashCmdList["HEAL"] = function(msg)
		if ni.player.hp() < 80 then
			if not ni.player.buff(spells.Regrowth.id) then
				ni.spell.cast(spells.Regrowth.id, "player")
			end
			if not ni.player.buff(spells.Rejuv.id) then
				ni.spell.cast(spells.Rejuv.id, "player")
			end
			if not ni.player.buff(spells.Lifebloom.id) then
				ni.spell.cast(spells.Lifebloom.id, "player")
			end
			if ni.player.hp() < 80 then
				ni.spell.cast(spells.Nourish.id, "player")
			end
		end
		return false
	end

	SLASH_BEAR1 = "/bear"
	SlashCmdList["BEAR"] = function(msg)
		ni.player.runtext("/cast !Dire Bear Form(Shapeshift)")
	end

	SLASH_CAT1 = "/cat"
	SlashCmdList["CAT"] = function(msg)
		ni.player.runtext("/cast !Cat Form(Shapeshift)")
	end

	local queue = {
		--buffs
		"cache",
		"GOTW",
		"Thorns",
		"Pounce",
		"INVI",
		"Pause Rotation",
		"Catform",
		"Start Attack",
		"Auto Target",
		"Barkskin",
		"Survival",
		"Tigers Fury",
		"Interrupter",
		"FeralCharge",
		"Berserkfear",
		"Antireflect",
		"Cycloneinterupt",
		"CycloneFocus",
		"Swipesnakes",
		"Faerie fire",
		"Antislow",
		"DispelHEX",
		"AbolishPoison",
		"Ferocious Bite1",
		"Ferocious Bite2",
		"Shreadcc",
		"Shred100",
		"Rake",
		"Shredauto",
		"SavageRoar",
		"Rip",
		--bear
		"FrenziedRegeneration",
		"MangleBear",
		"Demoralazing",
		"Enrage",
		"FaerieFirebear",
		"Maul",
		"Lacerate",
		"Laceratestack",
		"InervateHealer",
		"Hibernate",
	}



	local abilities = {
		-- ["cache"] function ()
		--     local enemies = ni.unit.enemiesinrange("player", 25)
		--     local target = enemies[i].guid
		--     local name = enemies[i].name
		--     local distance = enemies[i].distance
		-- end
		-- local enemies = ni.unit.enemiesinrange("player", 25)
		-- local target = enemies[i].guid
		-- local name = enemies[i].name
		-- local distance = enemies[i].distance

		["Pounce"] = function()
			if ni.spell.available(spells.Pounce.id)
					and ni.unit.buff("player", spells.Prowl.id, "player") then
				ni.spell.cast(spells.Pounce.id)
			end
		end,

		["Pause Rotation"] = function()
			local _, enabled = GetSetting("getSetting_Pause")
			if enabled then
				if IsMounted()
						or UnitIsDeadOrGhost("player")
						or not UnitAffectingCombat("player")
						or ni.unit.buff("player", "Drink") then
					return true;
				end
			end
		end,

		["Catform"] = function()
			local _, enabled = GetSetting("getSetting_CatForm")
			if enabled and ni.spell.available(spells.CatForm.id) then
				if not IsMounted()
						and not ni.player.buff(spells.CatForm.id) and not ni.player.buff(spells.BearForm.id) then
					ni.spell.cast(spells.CatForm.id)
				end
			end
		end,

		["INVI"] = function()
			local _, enabled = GetSetting("getSetting_Invi")
			if enabled then
				if ni.spell.available(spells.Prowl.id)
						and not UnitAffectingCombat("player")
						and ni.unit.buff("player", spells.CatForm.id, "player")
						and not ni.unit.buff("player", spells.Prowl.id, "player") then
					ni.spell.cast(spells.Prowl.id)
				end
			end
		end,

		["Auto Target"] = function()
			if UnitAffectingCombat("player")
					and ((ni.unit.exists("target")
							and UnitIsDeadOrGhost("target")
							and not UnitCanAttack("player", "target"))
						or not ni.unit.exists("target")) then
				ni.player.runtext("/targetenemy")
				return true;
			end
		end,

		["Start Attack"] = function()
			if ni.unit.exists("target")
					and UnitCanAttack("player", "target")
					and not UnitIsDeadOrGhost("target")
					and UnitAffectingCombat("player")
					and ni.unit.buff("player", spells.CatForm.id, "player")
					and not ni.unit.buff("player", spells.Prowl.id, "player")
					and not IsCurrentSpell(6603) then
				ni.spell.cast(6603)
			end
		end,

		["Barkskin"] = function()
			if ni.spell.available(spells.Barkskin.id)
					and UnitAffectingCombat("player")
					and ni.player.hp("player") <= 50 then
				ni.spell.cast(spells.Barkskin.id)
			end
		end,

		["Survival"] = function()
			if ni.spell.available(spells.SurvivalInstinct.id)
					and UnitAffectingCombat("player")
					and ni.player.hp("player") <= 30 then
				ni.spell.cast(spells.SurvivalInstinct.id)
			end
		end,

		["Shreadcc"] = function()
			if ni.spell.available(spells.Shred.id)
					and ni.unit.buffremaining("player", spells.ClearCast.id, "player") >= 1
					and ni.unit.isbehind("player", "target")
			then
				ni.spell.cast(spells.Shred.id)
			end
		end,

		["Shred100"] = function()
			if ni.spell.available(spells.Shred.id)
					and ni.player.powerraw("energy") >= 99
					and ni.unit.isbehind("player", "target") then
				ni.spell.cast(spells.Shred.id)
			end
		end,

		["Tigers Fury"] = function()
			if ni.player.buff(spells.CatForm.id)
					and ni.spell.available(spells.TigersFury.id)
					and ni.player.power() < 35 then
				ni.spell.cast(spells.TigersFury.id)
			end
		end,

		["Faerie fire"] = function()
			if ni.player.buff(spells.CatForm.id)
					and ni.spell.available(spells.FaerieFire.id)
					and not ni.unit.buff("target", spells.FaerieFire.id, "player")
					and ni.player.power() < 17 then
				ni.spell.cast(spells.FaerieFire.id, "target")
				return true;
			end
		end,
		["Rake"] = function()
			if ni.spell.available(spells.Rake.id)
					and GetComboPoints("player", "target") < 5
					and not ni.unit.debuff("target", spells.Rake.id, "player") then
				ni.spell.cast(spells.Rake.id)
			end
		end,

		-- ["InervateHealer"] = function()
		-- 	for i = 1, #ni.members do
		-- 		if ni.members[i].name == "Tapto" --values["Healer"]
		-- 		then
		-- 			ni.spell.cast(spells.Inervate.id, ni.members[i].unit)
		-- 		end
		-- 	end
		-- end,

		["Interrupter"] = function()
			if ni.spell.available(spells.Maim.id)
					and GetComboPoints("player", "target") >= 1
					and ni.unit.iscasting("target")
					and ni.drtracker.get("target", "Controlled stuns") > 0
					and (ni.unit.castingpercent("target") >= 80
						or ni.unit.ischanneling("target")) then
				ni.spell.cast(spells.Maim.id)
			end
		end,
		["Cycloneinterupt"] = function()
			local _, enabled = GetSetting("getSetting_CycloneInterupt")
			if enabled then
				if ni.player.buff(spells.InstantCast.id) then
					local enemies = ni.unit.enemiesinrange("player", 20)
					for i = 1, #enemies do
						local target = enemies[i].guid
						local name = enemies[i].name
						local distance = enemies[i].distance
						if ni.unit.iscasting(target)
								and ni.drtracker.get(target, "Cyclone") > 0
								and ni.spell.valid("focus", spells.Cyclone.id, false, true)
								and (ni.unit.castingpercent(target) >= 80
									or ni.unit.ischanneling(target))
						then
							ni.spell.cast(spells.Cyclone.id, target)
						end
					end
				end
			end
		end,
		["CycloneFocus"] = function()
			local _, enabled = GetSetting("getSetting_CycloneFocus")
			if enabled then
				if ni.player.buff(spells.InstantCast.id)
						and ni.unit.exists("focus")
						and not ni.unit.isstunned("focus")
						and not ni.unit.debuff("focus", spells.Cyclone.id)
						and not ni.unit.debuff("focus", 10890)
						and ni.drtracker.get("focus", "Cyclone") > 0
						and ni.spell.valid("focus", spells.Cyclone.id, false, true)
				then
					ni.spell.cast(spells.Cyclone.id, "socus")
				end
			end
		end,

		["FeralCharge"] = function()
			local _, enabled = GetSetting("getSetting_ChargeBear")
			if enabled then
				if ni.spell.cd(spells.Charge.id) == 0
						and not ni.player.buff(spells.Prowl.id) then
					local enemies = ni.unit.enemiesinrange("player", 25)
					for i = 1, #enemies do
						local target = enemies[i].guid
						local name = enemies[i].name
						local distance = enemies[i].distance
						if distance >= 8
								and ni.spell.valid(target, spells.Charge.id, false, true)
								and #enemies < 4
								and (ni.unit.castingpercent(target) >= 5
									or ni.unit.ischanneling(target))

						then
							ni.spell.cast(spells.BearForm.id)
							ni.player.lookat(target)
							ni.spell.cast(spells.Charge.id, target)
							print(name)
						end
					end
				end
			end
		end,
		["Swipesnakes"] = function()
			local enemies = ni.unit.enemiesinrange("player", 7)
			if ni.player.buff(spells.CatForm.id)
					and #enemies > 4 then
				ni.spell.cast(62078)
			end
		end,
		["Berserkfear"] = function()
			local _, enabled = GetSetting("getSetting_BerserkFear")
			if enabled then
				local fears = { 10890, 20511, 6215, 17928 }
				if ni.spell.cd(spells.Berserk.id) == 0 then
					for d = 1, #fears do
						if ni.player.debuff(fears[d]) then
							ni.spell.cast(spells.Berserk.id)
						end
					end
				end
			end
		end,

		["Ferocious Bite1"] = function()
			if ni.spell.available(spells.FerociusBite.id)
					and ni.unit.hp("target") < 30
					and GetComboPoints("player", "target") >= 4 then
				ni.spell.cast(spells.FerociusBite.id)
				return true;
			end
		end,

		["Ferocious Bite2"] = function()
			if ni.spell.available(spells.FerociusBite.id)
					and ni.unit.hp("target") < 20
					and GetComboPoints("player", "target") >= 3 then
				ni.spell.cast(spells.FerociusBite.id)
				return true;
			end
		end,
		["Antislow"] = function()
			local slows = { 45524, 1715, 3408, 59638, 20164, 25809, 31589, 51585, 50040, 50041, 31126, 31124, 122, 44614, 1604,
				45524, 50040, 339, 45334, 58179, 61391, 19306, 19185, 35101, 5116, 61394, 2974, 54644, 50245, 50271, 54706, 4167,
				33395, 55080, 11113, 6136, 120, 116, 44614, 31589, 63529, 20170, 31125, 3409, 26679, 64695, 63685, 8056, 8034,
				18118, 18223, 23694, 12323, 55536, 13099, 29703 }
			if ni.player.buff(spells.CatForm.id)
					and not ni.unit.inmelee("player", "target") then
				for d = 1, #slows do
					if ni.player.debuff(slows[d])
					then
						ni.spell.cast(spells.CatForm.id)
					end
				end
			end
		end,
		["Antireflect"] = function()
			if ni.player.buff(spells.CatForm.id)
					and ni.unit.buff("target", 23920) then
				ni.spell.cast(spells.Moonfire.id)
			end
		end,
		["DispelHEX"] = function()
			for i = 1, #ni.members do
				if ni.unit.debuff(ni.members[i].unit, 51514)
				then
					ni.spell.cast(spells.RemoveCurse.id, ni.members[i].unit)
				end
			end
		end,
		["Hibernate"] = function()
			local furrys = { 768, 9634, 2645 }
			if ni.player.buff(spells.InstantCast.id) then
				local enemies = ni.unit.enemiesinrange("player", 25)
				for i = 1, #enemies do
					local target = enemies[i].guid
					local name = enemies[i].name
					local distance = enemies[i].distance
					if ni.unit.buffs(target, 769 or 9634 or 26445)
					then
						ni.spell.cast(spells.Hibernate.id, target)
					end
				end
			end
		end,
		["Shredauto"] = function()
			local _, enabled = GetSetting("getSetting_Automated")
			if enabled then
				if ni.player.buff(spells.CatForm.id)
						and GetComboPoints("player", "target") < 5 then
					if ni.unit.isbehind("player", "target")
							and ni.spell.available(spells.Shred.id)
					then
						ni.spell.cast(spells.Shred.id, "target")
					elseif ni.spell.available(spells.Manglecat.id)
							and ni.player.powerraw("energy") >= 50
					then
						ni.spell.cast(spells.Manglecat.id, "target")
					end
				end
			end
		end,

		["SavageRoar"] = function()
			local _, enabled = GetSetting("getSetting_Automated")
			if enabled then
				if ni.player.buff(spells.CatForm.id)
						and not ni.player.buff(spells.SavageRoar.id)
						and GetComboPoints("player", "target") > 0
				then
					ni.spell.cast(spells.SavageRoar.id, "target")
				end
			end
		end,
		["Rip"] = function()
			local _, enabled = GetSetting("getSetting_Automated")
			if enabled then
				if ni.player.buff(spells.CatForm.id)
						and not ni.unit.debuff("target", spells.Rip.id)
						and GetComboPoints("player", "target") > 4
				then
					ni.spell.cast(spells.Rip.id, "target")
				end
			end
		end,



		["FrenziedRegeneration"] = function()
			if ni.player.buff(spells.BearForm.id)
					and ni.player.hp() < 60
			then
				ni.spell.cast(spells.FrenziedRegeneration.id)
			end
		end,
		["MangleBear"] = function()
			if ni.player.buff(spells.BearForm.id)
					and ni.spell.available(spells.MangleBear.id)
			then
				ni.spell.cast(spells.MangleBear.id, "Target")
			end
		end,
		["Demoralazing"] = function()
			if ni.player.buff(spells.BearForm.id)
					and not ni.unit.debuff("target", spells.Demoralazing.id, "player")
					and ni.unit.inmelee("player", "target")
					and ni.spell.available(spells.Demoralazing.id)
			then
				ni.spell.cast(spells.Demoralazing.id)
			end
		end,
		["Maul"] = function()
			if ni.player.buff(spells.BearForm.id)
					and ni.spell.available(spells.Maul.id)
					and ni.player.power() > 50
					and not IsCurrentSpell(spells.Maul.id)
			then
				ni.spell.cast(spells.Maul.id)
			end
		end,
		["Lacerate"] = function()
			if ni.player.buff(spells.BearForm.id)
					and ni.spell.available(spells.Lacerate.id)
					and ni.unit.debuffremaining("target", spells.Lacerate.id, "player") <= 3 then
				ni.spell.cast(spells.Lacerate.id, "target")
			end
		end,

		["Laceratestack"] = function()
			if ni.player.buff(spells.BearForm.id)
					and ni.spell.available(spells.Lacerate.id)
					and ni.unit.debuffstacks("target", spells.Lacerate.id, "player") < 5 then
				ni.spell.cast(spells.Lacerate.id, "target")
			end
		end,
		["FaerieFirebear"] = function()
			if ni.player.buff(spells.BearForm.id)
					and ni.spell.available(spells.FaerieFire.id)
					and ni.unit.exists("target")
					and UnitCanAttack("player", "target")
			then
				ni.spell.cast(spells.FaerieFire.id, "target")
			end
		end,
		-- ["AbolishPoison"] = function()
		--     if ni.spel


	}

	ni.bootstrap.profile("Feral pvp", queue, abilities, onload, onunload)
end

-- #showtooltip Feral Charge
-- /cast [noform:1] Dire Bear Form
-- /cast [@mouseover,harm,nodead][]Feral Charge - Bear()

-----------------------------------------------------------------
-- TOdO
-----------------------------------------------------------------
--Gui
-- Mejorar Feral Charge, hacer un interrupter
-- Auto matar snakes.
-- Auto sacar venenos cuando este en 50% o menos
-- Auto cyclone focus.
-- Tranquility
-- Fully automated rotation
--
--
