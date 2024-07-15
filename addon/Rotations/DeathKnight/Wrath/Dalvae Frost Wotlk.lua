local build = select(4, GetBuildInfo());
local wotlk = build == 30300 or false;
if wotlk then
	local spells = {
		ArmorSkills = { id = 76282, name = GetSpellInfo(76282), icon = select(3, GetSpellInfo(76282)) },
		AutoAttack = { id = 6603, name = GetSpellInfo(6603), icon = select(3, GetSpellInfo(6603)) },
		Cultivation = { id = 20552, name = GetSpellInfo(20552), icon = select(3, GetSpellInfo(20552)) },
		DualWield = { id = 674, name = GetSpellInfo(674), icon = select(3, GetSpellInfo(674)) },
		Endurance = { id = 20550, name = GetSpellInfo(20550), icon = select(3, GetSpellInfo(20550)) },
		JourneymanRiding = { id = 33391, name = GetSpellInfo(33391), icon = select(3, GetSpellInfo(33391)) },
		Languages = { id = 79746, name = GetSpellInfo(79746), icon = select(3, GetSpellInfo(79746)) },
		NatureResistance = { id = 20551, name = GetSpellInfo(20551), icon = select(3, GetSpellInfo(20551)) },
		PlateSpecialization = { id = 86524, name = GetSpellInfo(86524), icon = select(3, GetSpellInfo(86524)) },
		Runeforging = { id = 53428, name = GetSpellInfo(53428), icon = select(3, GetSpellInfo(53428)) },
		WarStomp = { id = 20549, name = GetSpellInfo(20549), icon = select(3, GetSpellInfo(20549)) },
		WeaponSkills = { id = 76292, name = GetSpellInfo(76292), icon = select(3, GetSpellInfo(76292)) },
		ExpertRiding = { id = 34090, name = GetSpellInfo(34090), icon = select(3, GetSpellInfo(34090)) },
		FlightMastersLicense = { id = 90267, name = GetSpellInfo(90267), icon = select(3, GetSpellInfo(90267)) },
		ColdWeatherFlying = { id = 54197, name = GetSpellInfo(54197), icon = select(3, GetSpellInfo(54197)) },
		ArtisanRiding = { id = 34091, name = GetSpellInfo(34091), icon = select(3, GetSpellInfo(34091)) },
		MasterRiding = { id = 90265, name = GetSpellInfo(90265), icon = select(3, GetSpellInfo(90265)) },
		Mastery = { id = 86471, name = GetSpellInfo(86471), icon = select(3, GetSpellInfo(86471)) },
		--Blood icon = select(2, GetSpellTabInfo(2))
		BloodBoil = { id = 49941, name = GetSpellInfo(49941), icon = select(3, GetSpellInfo(49941)) },
		BloodPresence = { id = 48266, name = GetSpellInfo(48266), icon = select(3, GetSpellInfo(48266)) },
		BloodStrike = { id = 49930, name = GetSpellInfo(49930), icon = select(3, GetSpellInfo(49930)) },
		DeathStrike = { id = 49998, name = GetSpellInfo(49998), icon = select(3, GetSpellInfo(49998)) },
		HeartStrike = { id = 55050, name = GetSpellInfo(55050), icon = select(3, GetSpellInfo(55050)) },
		Parry = { id = 82246, name = GetSpellInfo(82246), icon = select(3, GetSpellInfo(82246)) },
		Pestilence = { id = 50842, name = GetSpellInfo(50842), icon = select(3, GetSpellInfo(50842)) },
		RuneTap = { id = 48982, name = GetSpellInfo(48982), icon = select(3, GetSpellInfo(48982)) },
		Strangulate = { id = 47476, name = GetSpellInfo(47476), icon = select(3, GetSpellInfo(47476)) },
		VampiricBlood = { id = 55233, name = GetSpellInfo(55233), icon = select(3, GetSpellInfo(55233)) },
		BloodTap = { id = 45529, name = GetSpellInfo(45529), icon = select(3, GetSpellInfo(45529)) },
		DarkCommand = { id = 56222, name = GetSpellInfo(56222), icon = select(3, GetSpellInfo(56222)) },
		DeathPact = { id = 48743, name = GetSpellInfo(48743), icon = select(3, GetSpellInfo(48743)) },
		DarkSimulacrum = { id = 77606, name = GetSpellInfo(77606), icon = select(3, GetSpellInfo(77606)) },
		--Frost icon = select(2, GetSpellTabInfo(3))
		ChainsofIce = { id = 45524, name = GetSpellInfo(45524), icon = select(3, GetSpellInfo(45524)) },
		FrostFever = { id = 48263, name = GetSpellInfo(48263), icon = select(3, GetSpellInfo(48263)) },
		FrostStrike = { id = 55268, name = GetSpellInfo(55268), icon = select(3, GetSpellInfo(55268)) },
		FrostPresence = { id = 59921, name = GetSpellInfo(59921), icon = select(3, GetSpellInfo(59921)) },
		IceboundFortitude = { id = 48792, name = GetSpellInfo(48792), icon = select(3, GetSpellInfo(48792)) },
		IcyTouch = { id = 49909, name = GetSpellInfo(49909), icon = select(3, GetSpellInfo(49909)) },
		HowlingBlast = { id = 51411, name = GetSpellInfo(51411), icon = select(3, GetSpellInfo(51411)) },
		MindFreeze = { id = 47528, name = GetSpellInfo(47528), icon = select(3, GetSpellInfo(47528)) },
		Obliterate = { id = 51425, name = GetSpellInfo(51425), icon = select(3, GetSpellInfo(51425)) },
		PathofFrost = { id = 3714, name = GetSpellInfo(3714), icon = select(3, GetSpellInfo(3714)) },
		RunicFocus = { id = 61455, name = GetSpellInfo(61455), icon = select(3, GetSpellInfo(61455)) },
		HornofWinter = { id = 57623, name = GetSpellInfo(57623), icon = select(3, GetSpellInfo(57623)) },
		RuneStrike = { id = 56815, name = GetSpellInfo(56815), icon = select(3, GetSpellInfo(56815)) },
		RunicEmpowerment = { id = 81229, name = GetSpellInfo(81229), icon = select(3, GetSpellInfo(81229)) },
		EmpowerRuneWeapon = { id = 47568, name = GetSpellInfo(47568), icon = select(3, GetSpellInfo(47568)) },
		--Unholy icon = select(2, GetSpellTabInfo(4))
		BloodPlague = { id = 59879, name = GetSpellInfo(59879), icon = select(3, GetSpellInfo(59879)) },
		DeathandDecay = { id = 49938, name = GetSpellInfo(49938), icon = select(3, GetSpellInfo(49938)) },
		DeathCoil = { id = 49895, name = GetSpellInfo(49895), icon = select(3, GetSpellInfo(49895)) },
		DeathGate = { id = 50977, name = GetSpellInfo(50977), icon = select(3, GetSpellInfo(50977)) },
		DeathGrip = { id = 49576, name = GetSpellInfo(49576), icon = select(3, GetSpellInfo(49576)) },
		PlagueStrike = { id = 49921, name = GetSpellInfo(49921), icon = select(3, GetSpellInfo(49921)) },
		RaiseDead = { id = 46584, name = GetSpellInfo(46584), icon = select(3, GetSpellInfo(46584)) },
		AntiMagicShell = { id = 48707, name = GetSpellInfo(48707), icon = select(3, GetSpellInfo(48707)) },
		UnholyPresence = { id = 48265, name = GetSpellInfo(48265), icon = select(3, GetSpellInfo(48265)) },
		RaiseAlly = { id = 61999, name = GetSpellInfo(61999), icon = select(3, GetSpellInfo(61999)) },
		ArmyoftheDead = { id = 42650, name = GetSpellInfo(42650), icon = select(3, GetSpellInfo(42650)) },
		Outbreak = { id = 77575, name = GetSpellInfo(77575), icon = select(3, GetSpellInfo(77575)) },
		NecroticStrike = { id = 73975, name = GetSpellInfo(73975), icon = select(3, GetSpellInfo(73975)) },
	}
	local queue = {
		"Pause",
		"BloodPresence",
		"Cache",
		"MindFreeze",
		"IceboundFortitude",
		"RuneTap",
		"DeathandDecay",
		"Pestilencesingle",
		"BloodBoil",
		"Pestilenceaoe",
		"Outbreak",
		"IcyTouch",
		"PlagueStrike",
		"HowlingBlast",
		-- "RuneStrike",
		"Froststrike",
		"Obliterate",
		"BlodStrike"
	}
	--


	local IsSpellInRange,
	IsCurrentSpell,
	IsMounted,
	UnitIsDeadOrGhost,
	UnitExists,
	UnitCanAttack,
	GetShapeshiftFormID,
	IsSpellKnown =
			IsSpellInRange,
			IsCurrentSpell,
			IsMounted,
			UnitIsDeadOrGhost,
			UnitExists,
			UnitCanAttack,
			GetShapeshiftFormID,
			IsSpellKnown

	local enables = {
		["RuneTap"] = true,
		["IceboundFortitude"] = true,
	}
	local values = {
		["RuneTap"] = 40,
		["IceboundFortitude"] = 40,

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
		settingsfile = "frostwotlk.json",
		callback = GUICallback,
		{ type = "title",    text = "\124T" .. select(2, GetSpellTabInfo(2)) .. ":20:20\124tFrost DK Wotlk" },
		{ type = "separator" },
		{ type = "title",    text = "Survival Cooldowns" },


		{
			type = "entry",
			text = "\124T" .. spells.IceboundFortitude.icon .. ":20:20\124t " .. spells.IceboundFortitude.name,
			tooltip = "Use Icebound Fortitude when below this Hp pct",
			value = values["IceboundFortitude"],
			enabled = enables["IceboundFortitude"],
			key = "IceboundFortitude"
		},
		{
			type = "entry",
			text = "\124T" .. spells.RuneTap.icon .. ":20:20\124t " .. spells.RuneTap.name,
			tooltip = "Use Rune Tap when below this Hp pct",
			value = values["RuneTap"],
			enabled = enables["RuneTap"],
			key = "RuneTap"
		},

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
		ni.combatlog.registerhandler("frost-wotlk", CombatEventCatcher)
		ni.GUI.AddFrame("Frost-Wotlk", items)
	end
	local function OnUnload()
		ni.combatlog.unregisterhandler("frost-wotlk")
		ni.GUI.DestroyFrame("Frost-Wotlk")
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
			ni.debug.log(string.format("Casting %s on %s", spell, tar))
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
		bloodplauge = 0,
		frostFever = 0,
		targets = nil,
		bloodRune = 0
	}

	local t, p = "target", "player"

	local abilities = {
		["Pause"] = function()
			if
					IsMounted()
					or UnitIsDeadOrGhost(p)
					or not UnitExists(t)
					or UnitIsDeadOrGhost(t)
					-- or not UnitAffectingCombat("player")
					or (UnitExists(t) and not UnitCanAttack(p, t))
			then
				return true
			end
		end,
		["Cache"] = function()
			cache.bloodRune = select(2, ni.rune.bloodrunecd())
			cache.bloodPlauge = ni.unit.debuffremaining(t, 55078, p)
			cache.frostFever = ni.unit.debuffremaining(t, 55095, p)
			cache.targets = ni.unit.enemiesinrange(t, 10)
			ActiveEnemies()
		end,

		["IcyTouch"] = function()
			if cache.frostFever <= 2 and ValidUsable(spells.IcyTouch.id, t) and FacingLosCast(spells.IcyTouch.name, t) then
				return true
			end
		end,
		["PlagueStrike"] = function()
			if cache.bloodPlauge <= 2 and ValidUsable(spells.PlagueStrike.id, t) and FacingLosCast(spells.PlagueStrike.name, t) then
				return true
			end
		end,

		["RuneStrike"] = function()
			if ValidUsable(spells.RuneStrike.id, t) and FacingLosCast(spells.RuneStrike.name, t) then
				return true
			end
		end,

		["Obliterate"] = function()
			if ValidUsable(spells.Obliterate.id, t)
					and FacingLosCast(spells.Obliterate.name, t)
			then
				return true
			end
		end,
		["HowlingBlast"] = function()
			if ValidUsable(spells.HowlingBlast.id, t)
					and ni.player.buff(59052) -- Rime
					and FacingLosCast(spells.HowlingBlast.name, t)
			then
				return true
			end
		end,
		["Froststrike"] = function()
			if ValidUsable(spells.FrostStrike.id, t)
					and FacingLosCast(spells.FrostStrike.name, t)
			then
				return true
			end
		end,

		["BloodPresence"] = function()
			if ni.spell.available(spells.BloodPresence.id) and not ni.player.buff(spells.BloodPresence.id) then
				ni.spell.cast(spells.BloodPresence.name)
				return true
			end
		end,
		["DeathandDecay"] = function()
			if
					ni.spell.available(spells.DeathandDecay.id) and #cache.targets >= 5 and IsSpellInRange(spells.IcyTouch.name, t) == 1
			then
				ni.spell.castat(spells.DeathandDecay.name, t)
				return true
			end
		end,
		["Pestilenceaoe"] = function()
			local castit = false
			if ValidUsable(spells.Pestilence.id, t)
					and cache.bloodPlauge > 1 and
					cache.frostFever > 1 then
				for k, v in ipairs(cache.targets) do
					if ni.player.threat(v.guid) ~= -1 then
						if (ni.unit.debuffremaining(v.guid, 55078, p) < 4 or ni.unit.debuffremaining(v.guid, 55095, p) < 4)
						then
							castit = true
							break
						end
					end
				end
				if castit and FacingLosCast(spells.Pestilence.name, t) then
					return true
				end
			end
		end,
		["Pestilencesingle"] = function()
			if ValidUsable(spells.Pestilence.id, t)
					and ni.unit.debuff(t, 55095, p)
					and ni.unit.debuff(t, 55078, p)
					and (cache.frostFever < 4
						or cache.bloodPlauge < 4)
					and FacingLosCast(spells.Pestilence.name, t) then
				return true
			end
		end,
		["BloodBoil"] = function()
			local castit = false
			if ValidUsable(spells.BloodBoil.id, t) and #cache.targets >= 2 and cache.bloodPlauge > 2 and cache.frostFever > 2 then
				for k, v in ipairs(cache.targets) do
					if ni.player.threat(v.guid) ~= -1 then
						if ni.unit.debuffremaining(v.guid, 55078, p) > 2 or ni.unit.debuffremaining(v.guid, 55078, p) > 2 then
							castit = true
							break
						end
					end
				end
				if castit and FacingLosCast(spells.BloodBoil.name, t) then
					return true
				end
			end
		end,
		["RuneTap"] = function()
			if enables["RuneTap"] and ni.spell.available(spells.RuneTap.id) and ni.player.hp() <= values["RuneTap"] then
				ni.spell.cast(spells.RuneTap.name)
			end
		end,

		["IceboundFortitude"] = function()
			if
					enables["IceboundFortitude"] and ni.spell.available(spells.IceboundFortitude.id) and
					ni.player.hp() <= values["IceboundFortitude"]
			then
				ni.spell.cast(spells.IceboundFortitude.name)
			end
		end,

		["MindFreeze"] = function()
			if ni.spell.shouldinterrupt(t) and ValidUsable(spells.MindFreeze.id, t) and FacingLosCast(spells.MindFreeze.name, t) then
				return true
			end
		end
	}
	ni.bootstrap.profile("Dalvae Frost Wotlk", queue, abilities, OnLoad, OnUnload)
else
	local queue = {
		"Error",
	};
	local abilities = {
		["Error"] = function()
			ni.vars.profiles.enabled = false;
			if not wotlk then
				ni.frames.floatingtext:message("This profile for wotlk")
			end
		end,
	};
	ni.bootstrap.profile("Dalvae Frost Wotlk", queue, abilities);
end;
