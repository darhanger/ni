local build = select(4, GetBuildInfo());
local wotlk = build == 30300 or false;
if wotlk then
	local GetSpellInfo,
	UnitCanAttack,
	IsCurrentSpell,
	UnitIsDeadOrGhost,
	IsMounted,
	IsLeftShiftKeyDown,
	GetTime,
	UnitAffectingCombat,
	UnitClass,
	IsLeftControlKeyDown,
	UnitCastingInfo,
	UnitChannelInfo,
	IsUsableSpell =
			GetSpellInfo,
			UnitCanAttack,
			IsCurrentSpell,
			UnitIsDeadOrGhost,
			IsMounted,
			IsLeftShiftKeyDown,
			GetTime,
			UnitAffectingCombat,
			UnitClass,
			IsLeftControlKeyDown,
			UnitCastingInfo,
			UnitChannelInfo,
			IsUsableSpell;
	local S = {
		Crush = GetSpellInfo(47498),
		ShatterArmor = GetSpellInfo(58567),
		ShieldBlock = GetSpellInfo(2565),
		BloodyRage = GetSpellInfo(2687),
		NoStepBack = GetSpellInfo(12975),
		DeepDefence = GetSpellInfo(871),
		Recovery = GetSpellInfo(55694),
		Fury = GetSpellInfo(57516),
		HeroicThrow = GetSpellInfo(57755),
		PowerfulShieldStrike = GetSpellInfo(47488),
		StunningStrike = GetSpellInfo(12809),
		Revenge = GetSpellInfo(57823),
		ShieldStrike = GetSpellInfo(72),
		PowerWave = GetSpellInfo(46968),
		CommandShout = GetSpellInfo(47440),
		BattleShout = GetSpellInfo(47436),
		BerserkersRage = GetSpellInfo(18499),
		Bloody = GetSpellInfo(47465),
		HeroStrike = GetSpellInfo(47450),
		FreeHS = GetSpellInfo(58363),
		DefStance = GetSpellInfo(71),
		Autoattack = GetSpellInfo(6603),
		FearShout = GetSpellInfo(5246),
		Freedom = GetSpellInfo(3411),
		Dizarm = GetSpellInfo(676),
		SplRef = GetSpellInfo(23920),
		Korona = GetSpellInfo(305696),
		Charge = GetSpellInfo(11578),
		Interception = GetSpellInfo(20252),
		ThunderStrike = GetSpellInfo(47502)
	}
	local freedomdebuff = { 45524, 1715, 3408, 25809, 31589, 122, 44614, 339, 45334, 58179, 61391, 19306, 19185, 35101, 5116, 2974, 61394, 54644, 50245, 50271, 54706, 4167, 33395, 55080, 6136, 120, 116, 31589, 20170, 31125, 3409, 26679, 64695, 63685, 8056, 8034, 18118, 18223, 63311, 23694, 1715, 12323, 39965, 55536, 13099, 32859, 32065, 22800, 3604, 33967, 12023, 47698, 38316, 15063, 49717 }
	local SaveBuff = { 45438, 642, 20230, 33786, 47585, 19263 }
	local function TargetWithoutSave()
		for _, v in pairs(SaveBuff) do
			if ni.unit.buff("target", v)
					or ni.unit.debuff("target", 33786) then
				return false
			end
		end
		return true
	end
	local five_range_enemies = {}
	local function FiveRangeEnemies()
		table.wipe(five_range_enemies)
		five_range_enemies = ni.player.enemiesinrange(4)
		for k, v in ipairs(five_range_enemies) do
			if ni.player.threat(v.guid) == -1 then
				table.remove(five_range_enemies, k)
			end
		end
		return #five_range_enemies
	end
	local Rotation = {
		"Altkey",
		"Stance_",
		"BersRage_",
		"Trinket_",
		"Pause_",
		"Cache",
		"ThunderStrike_",
		"AutoAttack_",
		"Healthstone_",
		"Rocket_",
		"Shout",
		"ShiledBlock_",
		"BloodyRage_",
		"Fear_",
		"Saves_",
		"Charge_",
		"Interception_",
		"ShieldStrike_",
		"HeroicThrow_",
		"SplReflect_",
		"PowerWave_",
		"Stun_",
		"Dizarm_",
		"Revenge_",
		"Bleed_",
		"PSS_",
		"HS_",
		"Crush_",
	}
	local Details = {
		["Pause_"] = function()
			if IsMounted()
					or UnitInVehicle("player")
					or ni.player.buff(GetSpellInfo(430))
					or ni.player.buff(GetSpellInfo(433))
					or ni.player.isconfused()
					or ni.player.isfleeing()
					or ni.player.isstunned()
					or UnitIsDeadOrGhost("player")
					or IsLeftShiftKeyDown() then
				return true
			end
			return false
		end,
		["Altkey"] = function()
			if IsLeftAltKeyDown() or IsRightAltKeyDown() then
				print("ALT KEY IS SHIFTED")
			end
		end,
		["Cache"] = function()
			FiveRangeEnemies()
		end,
		["AutoAttack_"] = function()
			if ni.unit.exists("target")
					and UnitCanAttack("player", "target")
					and ni.unit.inmelee("player", "target")
					and not UnitIsDeadOrGhost("target")
					and not IsCurrentSpell(S.Autoattack) then
				ni.spell.cast(S.Autoattack)
			end
		end,
		["Stance_"] = function()
			if not ni.player.aura(S.DefStance)
					and ni.spell.available(S.DefStance) then
				ni.spell.cast(S.DefStance)
			end
		end,
		["Shout"] = function()
			if ni.player.buffremaining(S.CommandShout) < 30
					and ni.spell.available(S.CommandShout) then
				ni.spell.cast(S.CommandShout)
			end
		end,
		["Crush_"] = function()
			if TargetWithoutSave()
					and ni.spell.valid("target", S.Crush, true)
					and ni.spell.available(S.Crush) then
				ni.spell.cast(S.Crush)
			end
		end,
		["ShiledBlock_"] = function()
			if UnitAffectingCombat("player")
					and ni.player.hp() <= 80
					and ni.spell.cd(S.ShieldBlock) == 0
					and ni.unit.exists("target") then
				ni.spell.cast(S.ShieldBlock)
			end
		end,
		["BloodyRage_"] = function()
			if UnitAffectingCombat("player")
					and ni.player.power(1) < 55
					and ni.spell.cd(S.BloodyRage) == 0 then
				ni.spell.cast(S.BloodyRage)
			end
		end,
		["Saves_"] = function()
			if UnitAffectingCombat("player")
					and ni.player.buff(S.Korona) then
				if ni.spell.cd(S.DeepDefence) == 0 then
					ni.spell.cast(S.DeepDefence)
				elseif ni.spell.cd(S.NoStepBack) == 0 then
					ni.spell.cast(S.NoStepBack)
				end
			elseif ni.player.buff(S.DeepDefence)
					or ni.player.buff(S.NoStepBack) then
				if ni.player.buff(S.Fury)
						and ni.spell.available(S.Recovery) then
					ni.spell.cast(S.Recovery)
				end
			end
		end,
		["HeroicThrow_"] = function()
			if TargetWithoutSave()
					and ni.unit.iscasting("target")
					and (ni.spell.cd(S.ShieldStrike) ~= 0 or not ni.spell.valid("target", S.ShieldStrike, true) or (ni.spell.cd(S.Charge) ~= 0 and ni.spell.cd(S.Interception) ~= 0))
					and ni.spell.valid("target", S.HeroicThrow, true)
					and ni.spell.available(S.HeroicThrow) then
				ni.spell.cast(S.HeroicThrow)
			end
		end,
		["ShieldStrike_"] = function()
			if TargetWithoutSave()
					and (ni.spell.shouldinterrupt("target") or ni.unit.hp("target") <= 20)
					and ni.spell.valid("target", S.ShieldStrike, true)
					and ni.spell.cd(S.ShieldStrike) == 0
					and ni.player.power(1) >= 7 then
				ni.spell.cast(S.ShieldStrike)
			end
		end,
		["PSS_"] = function()
			if TargetWithoutSave()
					and ni.spell.valid("target", S.PowerfulShieldStrike, true)
					and ni.spell.available(S.PowerfulShieldStrike) then
				ni.spell.cast(S.PowerfulShieldStrike)
			end
		end,
		["ThunderStrike_"] = function()
			if TargetWithoutSave()
					and ni.unit.debuffremaining("target", S.ThunderStrike) <= 3
					and ni.spell.valid("target", S.PowerfulShieldStrike, true)
					and ni.spell.available(S.ThunderStrike) then
				ni.spell.cast(S.ThunderStrike)
			end
		end,
		["Stun_"] = function()
			if TargetWithoutSave()
					and (not (ni.unit.debuff("target", S.Dizarm) or ni.unit.debuff("target", S.PowerWave)))
					and ni.drtracker.get("target", "Stuns") ~= 0
					and ni.spell.valid("target", S.StunningStrike, true)
					and ni.spell.available(S.StunningStrike) then
				ni.spell.cast(S.StunningStrike)
			end
		end,
		["PowerWave_"] = function()
			if TargetWithoutSave()
					and not (ni.unit.debuff("target", S.StunningStrike) or ni.unit.debuff("target", S.Dizarm))
					and ni.spell.valid("target", S.StunningStrike, true)
					and ni.spell.available(S.PowerWave)
					and ni.player.isfacing("target", 125) then
				ni.spell.cast(S.PowerWave)
			end
		end,
		["Dizarm_"] = function()
			local _, _, EnemyClass = UnitClass("target")
			if TargetWithoutSave()
					and ni.unit.isplayer("target")
					and (EnemyClass == 1 or EnemyClass == 2 or EnemyClass == 3 or EnemyClass == 4 or EnemyClass == 6)
					and (not (ni.unit.debuff("target", S.StunningStrike) or ni.unit.debuff("target", S.PowerWave) or ni.unit.debuff("target", S.Dizarm)))
					and ni.spell.valid("target", S.Dizarm, true)
					and ni.spell.available(S.Dizarm) then
				ni.spell.cast(S.Dizarm)
			end
		end,
		["Revenge_"] = function()
			if TargetWithoutSave()
					and ni.spell.valid("target", S.Revenge, true)
					and IsUsableSpell(S.Revenge)
					and ni.spell.available(S.Revenge) then
				ni.spell.cast(S.Revenge)
			end
		end,
		["BersRage_"] = function()
			if ni.player.isfleeing()
					and ni.spell.available(S.BerserkersRage) then
				ni.spell.cast(S.BerserkersRage)
			end
		end,
		["Bleed_"] = function()
			if TargetWithoutSave()
					and ni.unit.isplayer("target")
					and ni.unit.debuffremaining("target", S.Bloody) <= 3
					and ni.spell.valid("target", S.Bloody, true)
					and ni.spell.available(S.Bloody) then
				ni.spell.cast(S.Bloody)
			end
		end,
		["HS_"] = function()
			if TargetWithoutSave()
					and (ni.player.buff(S.FreeHS) or ni.player.power(1) >= 60)
					and IsCurrentSpell(S.Autoattack)
					and not IsCurrentSpell(S.HeroStrike) then
				ni.spell.cast(S.HeroStrike)
			end
		end,
		["Fear_"] = function()
			if UnitAffectingCombat("player")
					and (ni.player.hp() < 75 or FiveRangeEnemies() >= 3)
					and ni.spell.valid("target", S.FearShout, true)
					and ni.spell.available(S.FearShout) then
				ni.spell.cast(S.FearShout)
			end
		end,
		["SplReflect_"] = function()
			if UnitAffectingCombat("player")
					and ni.unit.iscasting("target")
					and ni.spell.cd(S.HeroicThrow) ~= 0
					and ni.spell.cd(S.Charge) ~= 0
					and ni.spell.cd(S.Interception) ~= 0
					and ni.spell.cd(S.SplRef) == 0
					and ni.player.power(1) >= 15 then
				ni.spell.cast(S.SplRef)
			elseif ni.player.hp() < 75
					and ni.spell.cd(S.SplRef) == 0
					and ni.player.power(1) > 50 then
				ni.spell.cast(S.SplRef)
			end
		end,
		["Healthstone_"] = function()
			local hstones = { 36892, 36893, 36894 }
			for k in pairs(hstones) do
				if (ni.player.buff(S.DeepDefence)
							or ni.player.buff(S.NoStepBack))
						and ni.player.hasitem(hstones[k])
						and ni.player.itemcd(hstones[k]) == 0 then
					ni.player.useitem(hstones[k])
				end
			end
		end,
		["Trinket_"] = function()
			if UnitAffectingCombat("player")
					and (ni.player.isstunned() or ni.player.isconfused() or (ni.player.isfleeing() and ni.spell.cd(S.BerserkersRage) ~= 0))
					and ni.player.slotcastable(13)
					and ni.player.slotcd(13) == 0 then
				ni.player.useinventoryitem(13)
			end
		end,
		["Rocket_"] = function()
			if TargetWithoutSave()
					and ni.spell.valid("target", S.HeroicThrow, true)
					and ni.unit.hp("target") <= 10
					and ni.player.slotcastable(10)
					and ni.player.slotcd(10) == 0 then
				ni.player.useinventoryitem(10)
				ni.player.runtext("/к %t, лови маслину!")
			end
		end,
		["Charge_"] = function()
			if ni.spell.valid("target", S.Charge, true, true)
					and ni.spell.cd(S.Charge) == 0
					and IsFalling() then
				ni.spell.cast(S.Charge)
			end
		end,
		["Interception_"] = function()
			if ni.spell.valid("target", S.Interception, true, true)
					and ni.spell.cd(S.Charge) < 13
					and ni.spell.cd(S.Charge) ~= 0
					and ni.spell.cd(S.Interception) == 0
					and ni.player.power(1) >= 7
					and IsFalling() then
				ni.spell.cast(S.Interception)
			end
		end,
	}
	ni.bootstrap.profile("PROTO PvP A1", Rotation, Details)
end;
