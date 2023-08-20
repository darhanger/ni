local build = select(4, GetBuildInfo());
local cata = build == 40300 or false;
if cata then
	local queue = {
		"RallyingCry",
		"Pause",
		-- "BattleStance",
		"BattleShout",
		"Cache",
		"Pummel",
		"VictoryRush",
		"Rend",
		"BerserkerStance",
		"ThunderClap",
		"Bladestorm",
		"Whirlwind",
		"Cleave",
		"HeroicStrike",
		"Sweeping",
		"HeroicStrikeBT",
		"MortalStrike",
		"ColossusSmash",
		"Execute",
		-- "OverpowerColossus",
		-- "Overpowersecond",
		"Overpower",
		"MortalStrikeSpam",
		"Slam",
		-- "Strike",
		"AutoAttack"
	}

	--Localize
	local IsSpellInRange,
	IsCurrentSpell,
	IsMounted,
	UnitIsDeadOrGhost,
	UnitExists,
	UnitCanAttack,
	IsUsableSpell =
			IsSpellInRange,
			IsCurrentSpell,
			IsMounted,
			UnitIsDeadOrGhost,
			UnitExists,
			UnitCanAttack,
			IsUsableSpell

	local spells = {
		--ni.vars.build == 40300
		--General
		Attack = { id = 88163, name = GetSpellInfo(88163), icon = select(3, GetSpellInfo(88163)) },
		AutoAttack = { id = 6603, name = GetSpellInfo(6603), icon = select(3, GetSpellInfo(6603)) },
		--Arms
		AngerManagement = { id = 12296, name = GetSpellInfo(12296), icon = select(3, GetSpellInfo(12296)) },
		BattleStance = { id = 2457, name = GetSpellInfo(2457), icon = select(3, GetSpellInfo(2457)) },
		Charge = { id = 100, name = GetSpellInfo(100), icon = select(3, GetSpellInfo(100)) },
		MortalStrike = { id = 12294, name = GetSpellInfo(12294), icon = select(3, GetSpellInfo(12294)) },
		Rend = { id = 772, name = GetSpellInfo(772), icon = select(3, GetSpellInfo(772)) },
		Strike = { id = 88161, name = GetSpellInfo(88161), icon = select(3, GetSpellInfo(88161)) },
		ThunderClap = { id = 6343, name = GetSpellInfo(6343), icon = select(3, GetSpellInfo(6343)) },
		TwoHandedWeaponSpecialization = { id = 12712, name = GetSpellInfo(12712), icon = select(3, GetSpellInfo(12712)) },
		HeroicStrike = { id = 78, name = GetSpellInfo(78), icon = select(3, GetSpellInfo(78)) },
		HeroicThrow = { id = 57755, name = GetSpellInfo(57755), icon = select(3, GetSpellInfo(57755)) },
		Overpower = { id = 7384, name = GetSpellInfo(7384), icon = select(3, GetSpellInfo(7384)) },
		Hamstring = { id = 1715, name = GetSpellInfo(1715), icon = select(3, GetSpellInfo(1715)) },
		Retaliation = { id = 20230, name = GetSpellInfo(20230), icon = select(3, GetSpellInfo(20230)) },
		ShatteringThrow = { id = 64382, name = GetSpellInfo(64382), icon = select(3, GetSpellInfo(64382)) },
		ColossusSmash = { id = 86346, name = GetSpellInfo(86346), icon = select(3, GetSpellInfo(86346)) },
		--Fury
		VictoryRush = { id = 34428, name = GetSpellInfo(34428), icon = select(3, GetSpellInfo(34428)) },
		Execute = { id = 5308, name = GetSpellInfo(5308), icon = select(3, GetSpellInfo(5308)) },
		BattleShout = { id = 6673, name = GetSpellInfo(6673), icon = select(3, GetSpellInfo(6673)) },
		Cleave = { id = 845, name = GetSpellInfo(845), icon = select(3, GetSpellInfo(845)) },
		BerserkerStance = { id = 2458, name = GetSpellInfo(2458), icon = select(3, GetSpellInfo(2458)) },
		Whirlwind = { id = 1680, name = GetSpellInfo(1680), icon = select(3, GetSpellInfo(1680)) },
		Pummel = { id = 6552, name = GetSpellInfo(6552), icon = select(3, GetSpellInfo(6552)) },
		IntimidatingShout = { id = 5246, name = GetSpellInfo(5246), icon = select(3, GetSpellInfo(5246)) },
		Slam = { id = 1464, name = GetSpellInfo(1464), icon = select(3, GetSpellInfo(1464)) },
		ChallengingShout = { id = 1161, name = GetSpellInfo(1161), icon = select(3, GetSpellInfo(1161)) },
		Intercept = { id = 20252, name = GetSpellInfo(20252), icon = select(3, GetSpellInfo(20252)) },
		DemoralizingShout = { id = 1160, name = GetSpellInfo(1160), icon = select(3, GetSpellInfo(1160)) },
		BerserkerRage = { id = 18499, name = GetSpellInfo(18499), icon = select(3, GetSpellInfo(18499)) },
		InnerRage = { id = 1134, name = GetSpellInfo(1134), icon = select(3, GetSpellInfo(1134)) },
		Recklessness = { id = 1719, name = GetSpellInfo(1719), icon = select(3, GetSpellInfo(1719)) },
		CommandingShout = { id = 469, name = GetSpellInfo(469), icon = select(3, GetSpellInfo(469)) },
		EnragedRegeneration = { id = 55694, name = GetSpellInfo(55694), icon = select(3, GetSpellInfo(55694)) },
		RallyingCry = { id = 97462, name = GetSpellInfo(97462), icon = select(3, GetSpellInfo(97462)) },
		HeroicLeap = { id = 6544, name = GetSpellInfo(6544), icon = select(3, GetSpellInfo(6544)) },
		--Protection
		DefensiveStance = { id = 71, name = GetSpellInfo(71), icon = select(3, GetSpellInfo(71)) },
		Parry = { id = 3127, name = GetSpellInfo(3127), icon = select(3, GetSpellInfo(3127)) },
		Taunt = { id = 355, name = GetSpellInfo(355), icon = select(3, GetSpellInfo(355)) },
		SunderArmor = { id = 7386, name = GetSpellInfo(7386), icon = select(3, GetSpellInfo(7386)) },
		ShieldBlock = { id = 2565, name = GetSpellInfo(2565), icon = select(3, GetSpellInfo(2565)) },
		Disarm = { id = 676, name = GetSpellInfo(676), icon = select(3, GetSpellInfo(676)) },
		Revenge = { id = 6572, name = GetSpellInfo(6572), icon = select(3, GetSpellInfo(6572)) },
		ShieldWall = { id = 871, name = GetSpellInfo(871), icon = select(3, GetSpellInfo(871)) },
		StanceMastery = { id = 12678, name = GetSpellInfo(12678), icon = select(3, GetSpellInfo(12678)) },
		SpellReflection = { id = 23920, name = GetSpellInfo(23920), icon = select(3, GetSpellInfo(23920)) },
		Intervene = { id = 3411, name = GetSpellInfo(3411), icon = select(3, GetSpellInfo(3411)) }
	}
	local p, t = "player", "target"

	local enables = {
		["interrupt"] = true,
		["battleshout"] = true
	}
	local values = {
		["HeroicStrike"] = 70,
		["Slam"] = 40
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
		settingsfile = "Dalvae_armspve_cata.xml",
		callback = GUICallback,
		{ type = "separator" },
		{ type = "title",    text = "Dalvae Cata Pve" },
		{ type = "separator" },
		{
			type = "entry",
			text = "\124T" .. spells.Pummel.icon .. ":26:26\124t Interrupt",
			tooltip = "Use Pummel on target",
			enable = enables["interrupt"],
			key = "interrupt"
		},
		{
			type = "entry",
			text = "\124T" .. spells.BattleShout.icon .. ":26:26\124t Battle Shout",
			tooltip = "Use Battle Shout or commanding shout",
			enable = enables["battleshout"],
			key = "battleshout"
		},
		{
			type = "entry",
			text = "\124T" .. spells.HeroicStrike.icon .. ":26:26\124t Heroic Strike",
			tooltip = "Use Heroic Strike when above this rage pct",
			value = values["HeroicStrike"],
			key = "HeroicStrike"
		},
		{ type = "separator" },
		{
			type = "entry",
			text = "\124T" .. spells.Slam.icon .. ":26:26\124t Slam",
			tooltip = "Use Slam when above this rage pct",
			value = values["Slam"],
			key = "Slam"
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
		ni.combatlog.registerhandler("Dalvae_armspve_cata", CombatEventCatcher)
		ni.GUI.AddFrame("Dalvae_armspve_cata", items)
	end
	local function OnUnload()
		ni.combatlog.unregisterhandler("Dalvae_armspve_cata")
		ni.GUI.DestroyFrame("Dalvae_armspve_cata")
	end

	local enemies = {}

	local function ActiveEnemies()
		table.wipe(enemies)
		enemies = ni.player.enemiesinrange(8)
		for k, v in ipairs(enemies) do
			if ni.player.threat(v.guid) == -1 then
				table.remove(enemies, k)
			end
		end
		return #enemies
	end

	local function FacingLosCast(spell, tar)
		if ni.player.isfacing(tar, 145) then
			ni.spell.cast(spell, tar)
			return true
		end
		return false
	end

	local function FacingLosCastBattle(spell, tar)
		if ni.player.isfacing(tar, 145) then
			if GetShapeshiftFormID() ~= 17
			-- and ni.player.powerraw("rage")<75
			then
				ni.player.runtext("/cast Battle Stance")
				ni.spell.cast(spell, tar)
			else
				ni.spell.cast(spell, tar)
			end
			return true
		end
		return false
	end

	local function FacingLosCastBerserk(spell, tar)
		if ni.player.isfacing(tar, 145) then
			if GetShapeshiftFormID() ~= 19
					and ni.player.powerraw("rage") < 75
			then
				ni.player.runtext("/cast Berserker Stance")
				ni.spell.cast(spell, tar)
			else
				ni.spell.cast(spell, tar)
			end
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
		rage = 0,
		inmelee = false,
		activeenemies = 0
	}

	local BattleTrance = 85742

	SLASH_LEAP1 = "/leap"
	SlashCmdList["LEAP"] = function(msg)
		if ni.spell.cd(spells.HeroicLeap.id) == 0
		then
			ni.spell.cast(spells.HeroicLeap.id)
			ni.player.clickat("mouse")
		end
	end

	local abilities = {
		["RallyingCry"] = function()
			local members_below = ni.members.inrangebelow("player", 30, 10);
			if # members_below > 0
			then
				ni.spell.cast(spells.RallyingCry.id)
			end
		end,

		["Pause"] = function()
			if
					IsMounted()
					or UnitIsDeadOrGhost(p)
					or not UnitExists(t)
					or UnitIsDeadOrGhost(t) or
					(UnitExists(t)
						and not UnitCanAttack(p, t))
			then
				return true
			end
		end,
		["Cache"] = function()
			cache.rage = ni.player.powerraw("rage")
			cache.inmelee = IsSpellInRange(spells.Strike.name, t) == 1
			cache.activeenemies = ActiveEnemies()
		end,
		["BerserkStance"] = function()
			if GetShapeshiftFormID() ~= 19
					and not ni.player.buff(60503) -- what buff its?
					and ni.unit.debuff(t, "Rend")
			then
				ni.spell.cast(spells.BerserkerStance.id)
			end
		end,
		["BattleShout"] = function()
			if ni.spell.available(spells.CommandingShout.id)
					and not ni.player.buff(spells.CommandingShout.id)
			then
				ni.spell.cast(spells.CommandingShout.id)
				return true
			end
		end,
		["AutoAttack"] = function()
			if not IsCurrentSpell(spells.AutoAttack.id)
					and cache.inmelee
					and incombat then
				ni.spell.cast(spells.AutoAttack.name)
			end
		end,
		["Strike"] = function()
			if ValidUsable(spells.Strike.id, t)
					and FacingLosCastBerserk(spells.Strike.name, t)
			then
				return true
			end
		end,
		["MortalStrike"] = function()
			if ValidUsable(spells.MortalStrike.id, t)
					and ni.spell.available(spells.MortalStrike.id)
					and (ni.player.buffstacks(84586) < 3 --Slaugther something
						or ni.player.buffremaining(84586) < 4)
					and FacingLosCastBerserk(spells.MortalStrike.name, t) then
				return true
			end
		end,

		["MortalStrikeSpam"] = function()
			if ValidUsable(spells.MortalStrike.id, t)
					and not IsUsableSpell(spells.Execute.name)
					and ni.spell.available(spells.MortalStrike.id)
					and (ni.spell.cd(86346) > 4
						or ni.unit.debuff(t, 86346, p))
					-- and (ni.player.buffstacks(84586) < 3
					-- or ni.player.buffremaining(84586)< 3)
					and FacingLosCastBerserk(spells.MortalStrike.name, t) then
				return true
			end
		end,
		["VictoryRush"] = function()
			if ValidUsable(spells.VictoryRush.id, t)
					and ni.player.hp() < 30
					and IsUsableSpell(spells.VictoryRush.name)
					and
					FacingLosCast(spells.VictoryRush.name, t)
			then
				return true
			end
		end,
		["Rend"] = function()
			if ValidUsable(spells.Rend.id, t)
					and not ni.unit.debuff(t, spells.Rend.id, p)
					and FacingLosCastBattle(spells.Rend.name, t)
			then
				return true
			end
		end,
		["ColossusSmash"] = function()
			if ValidUsable(spells.ColossusSmash.id, t)
					and not ni.unit.debuff(t, spells.ColossusSmash.id, p) --C
					and ni.player.buffremaining(spells.ColossusSmash.id) < 2
					and FacingLosCastBerserk(spells.ColossusSmash.name, t) then
				return true
			end
		end,

		["OverpowerColossus"] = function()
			if
			-- and IsUsableSpell(spells.Overpower.name)
					ni.player.buff(60503)
					and ni.unit.debuff(t, spells.ColossusSmash.id, p) --Coloss samsh
					and FacingLosCastBattle(spells.Overpower.name, t)
			then
				return true
			end
		end,
		["Overpower"] = function()
			if
			-- and IsUsableSpell(spells.Overpower.name)
					ni.player.buff(60503) --
					and (ni.spell.cd(spells.ColossusSmash.id) > 4
						or ni.unit.debuff(t, spells.ColossusSmash.id, p))
					and FacingLosCastBattle(spells.Overpower.name, t)
			then
				return true
			end
		end,
		["Execute"] = function()
			if IsUsableSpell(spells.Execute.name)
					and FacingLosCastBerserk(spells.Execute.name, t)
			then
				return true
			end
		end,
		["HeroicStrike"] = function()
			if ni.spell.cd(spells.HeroicStrike.id) == 0
					and (ni.spell.cd(spells.ColossusSmash.id) > 3
						or ni.unit.debuff(t, spells.ColossusSmash.id, p))

			then
				if ni.vars.combat.aoe
						and cache.rage >= 50
						and cache.activeenemies > 2
				then
					ni.spell.cast(spells.Cleave.id)
					print("Cleave")
				else
					if not IsUsableSpell(spells.Execute.name)
							and (ni.player.buff(BattleTrance) or cache.rage >= values["HeroicStrike"])
					then
						ni.spell.cast(spells.HeroicStrike.id)
						print("Heroic")
					end
				end
			end
		end,

		-- ["Cleave"] = function()
		-- 	if cache.activeenemies > 2
		-- 		and ni.unit.inmelee(p,t)
		-- 		and ni.spell.cd(spells.HeroicStrike.id) ==0
		-- 		and (ni.player.buff(BattleTrance) or cache.rage >= 50
		-- 		and IsSpellInRange(spells.HeroicStrike.id, "target") == 1
		-- 		then
		-- 				ni.spell.cast(spells.Cleave.id)
		-- 				print("cleave")
		-- 		end

		-- end,
		["HeroicStrikeBT"] = function()
			if
					ni.unit.inmelee(p, t)
					and ni.spell.cd(spells.HeroicStrike.id) == 0
					and ni.player.buff(BattleTrance)
					and (ni.spell.cd(86346) > 2
						or ni.unit.debuff(t, 86346, p))
			then
				ni.spell.cast(spells.HeroicStrike.name)
				return true
			end
		end,
		["Slam"] = function()
			if ValidUsable(spells.Slam.id, t)
					and ((cache.rage >= values["Slam"])
						or ni.unit.debuff(t, 86346, p))
					and FacingLosCastBerserk(spells.Slam.name, t) then
				return true
			end
		end,
		["ThunderClap"] = function()
			if ni.vars.combat.aoe
					and ni.spell.cd(spells.ThunderClap.id) == 0
					and cache.activeenemies >= 3
					and ni.unit.debuff(t, 94009, p)
					and cache.rage >= 30 then
				if GetShapeshiftFormID() ~= 17 then
					ni.spell.cast(spells.BattleStance.id)
					ni.spell.cast(spells.ThunderClap.name)
				else
					ni.spell.cast(spells.ThunderClap.name)
					return true
				end
			end
		end,
		["Pummel"] = function()
			if enables["Interrupt"]
			then
				if ValidUsable(spells.Pummel.name, "target")
						and ni.spell.shouldinterrupt("target") and
						FacingLosCast(spells.Pummel.name, "target")
				then
					return true
				end
			end
		end,
		["Sweeping"] = function()
			if ni.vars.combat.aoe
					and ni.vars.combat.cd
					and ni.spell.available(12328)
					and cache.activeenemies >= 2 then
				ni.spell.cast(12328)
				print("Sweeping")
				return true
			end
		end,
		["Cleave"] = function()
			if ni.vars.combat.aoe
					and ni.spell.available(spells.Cleave.id)
					and cache.activeenemies >= 4
					and cache.rage >= 50 then
				if GetShapeshiftFormID() ~= 19 then
					ni.spell.cast(spells.BerserkerStance.id)
					ni.spell.cast(spells.Cleave.id)
				else
					ni.spell.cast(spells.Cleave.id)
					return true
				end
			end
		end,
		["Bladestorm"] = function()
			if ni.vars.combat.aoe
					and ni.vars.combat.cd
					and ni.spell.available(46924)
					and cache.activeenemies >= 3 then
				if GetShapeshiftFormID() ~= 19 then
					ni.player.runtext("/use 10")
					ni.spell.cast(spells.BerserkerStance.id)
					ni.spell.cast(46924)
				else
					ni.spell.cast(46924)
					return true
				end
			end
		end,
		["Whirlwind"] = function()
			if ni.vars.combat.aoe
					and ni.spell.available(spells.Whirlwind.id)
					and cache.activeenemies >= 4 then
				if GetShapeshiftFormID() ~= 19 then
					ni.spell.cast(spells.BerserkerStance.id)
					ni.spell.cast(spells.Whirlwind.id)
				else
					ni.spell.cast(spells.Whirlwind.id)
					return true
				end
			end
		end,
	}
	ni.bootstrap.profile("Dalvae_armspve_cata", queue, abilities, OnLoad, OnUnload)
else
	local queue = {
		"Error",
	};
	local abilities = {
		["Error"] = function()
			ni.vars.profiles.enabled = false;
			if not cata then
				ni.frames.floatingtext:message("Only for Cata")
			end
		end,
	};
	ni.bootstrap.profile("fury_war_by_makaren", queue, abilities);
end
;
--- Mortal no pega mas que el eslam
-- Mortal solo para mantener el bufo
-- Hacer settings para el shout
