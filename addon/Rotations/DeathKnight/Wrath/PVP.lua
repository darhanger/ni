local GetSpellInfo,
UnitCanAttack,
IsCurrentSpell,
UnitIsDeadOrGhost,
IsMounted,
IsLeftShiftKeyDown,
UnitClass,
IsUsableSpell =
GetSpellInfo,
UnitCanAttack,
IsCurrentSpell,
UnitIsDeadOrGhost,
IsMounted,
IsLeftShiftKeyDown,
UnitClass,
IsUsableSpell
local magic = {
	RunicStrike = GetSpellInfo(56815),
	Icy = GetSpellInfo(55095),
	IcyTouch = GetSpellInfo(49909),
	Plague = GetSpellInfo(55078),
	PlagueStrike = GetSpellInfo(49921),
	BloodyStrike = GetSpellInfo(49930),
	Pestilence = GetSpellInfo(50842),
	MindFreeze = GetSpellInfo(47528),
	DeathStrike = GetSpellInfo(49924),
	Strangulation = GetSpellInfo(47476),
	WinterHorn = GetSpellInfo(57623),
	BloodDrain = GetSpellInfo(45529),
	DeathCoil = GetSpellInfo(49895),
	EnhancingRuneWeapons = GetSpellInfo(47568),
	Chains = GetSpellInfo(45524),
	FirmnessOfIce = GetSpellInfo(48792),
	AMagicCarapace = GetSpellInfo(48707),
	DeathGrip = GetSpellInfo(49576),
	BoneShield = GetSpellInfo(49222),
	BloodMark = GetSpellInfo(49005),
	CaptureTheRunes = GetSpellInfo(48982),
	Summon = GetSpellInfo(46584),
	Bers = GetSpellInfo(63560),
	Blink = GetSpellInfo(316465),
	Eating = GetSpellInfo(48743)
}
local SaveBuff = {45438, 642, 33786, 19263, 48707}
local function TargetWithoutSave(t)
    for _, v in pairs(SaveBuff) do
		if ni.unit.buff(t, v) then
			return false
		end
	end
	return true;
end;
local order = {
	"Trink",
	"Pause",
	"Shield",
	"BloodDrain",
	"Save",
	"Mark",
	"Pot",
	"HS",
	"Tp1",
	"EnhancingRuneWeapons",
	"Strangulation",
	"MindFreeze",
	"WinterHorn",
	"Attacking",
	"RunicStrike",
	"Pestilence",
	"DeathCoil",
	"IcyTouch",
	"PlagueStrike",
	"DeathStrike",
	"BloodyStrike",
	"Pet"
}
local moves = {
	["Pause"] = function()
		if IsMounted()
		or UnitIsDeadOrGhost("player")
		or ni.player.buff(GetSpellInfo(430))
		or ni.player.buff(GetSpellInfo(433))
		or IsLeftShiftKeyDown() then
			return true;
		end
	end,
	["Attacking"] = function()
		if ni.unit.exists("target")
        and UnitCanAttack("player", "target")
        and ni.unit.inmelee("player", "target")
		and not IsCurrentSpell(6603) then
			ni.player.runtext("/startattack")
			return true;
		end
	end,
	["IcyTouch"] = function()
		if TargetWithoutSave("target") then
			if ni.spell.valid("target", magic.Chains, true, true, false)
			and (not ni.unit.debuff("target", magic.Chains, "player") or ni.unit.debuffremaining("target", magic.Chains, "player") <= 3)
			and ni.spell.available(magic.Chains) then
				ni.spell.cast(magic.Chains)
				return true;
			end
		end
  	end,
	["PlagueStrike"] = function()
		if TargetWithoutSave("target") then
			local _, UR = ni.rune.unholyrunecd()
			if ni.spell.valid("target", magic.PlagueStrike, true, true, false)
			and (not ni.unit.debuff("target", magic.Plague, "player") or (ni.rune.available() == 1 and UR >= 1))
			and ni.spell.available(magic.PlagueStrike) then
				ni.spell.cast(magic.PlagueStrike)
				return true;
			end
		end
	end,
	["BloodyStrike"] = function()
		if TargetWithoutSave("target") then
			if ni.spell.valid("target", magic.PlagueStrike, true, true, false)
			and ni.unit.debuff("target", magic.Icy, "player") and ni.unit.debuff("target", magic.Plague, "player")
			and ni.spell.available(magic.BloodyStrike) then
				ni.spell.cast(magic.BloodyStrike)
				return true;
			end
		end
	end,
	["DeathStrike"] = function()
		if TargetWithoutSave("target") then
			if ni.spell.valid("target", magic.PlagueStrike, true, true, false)
			and ni.unit.debuff("target", magic.Icy, "player") and ni.unit.debuff("target", magic.Plague, "player")
			and ni.spell.available(magic.DeathStrike) then
				ni.spell.cast(magic.DeathStrike)
				return true;
			end
		end
	end,
	["Pestilence"] = function()
		if ni.spell.valid("target", magic.PlagueStrike, true, true, false)
		and ((ni.unit.debuff("target", magic.Plague, "player") and ni.unit.debuffremaining("target", magic.Plague, "player") <= 5)
		or (ni.unit.debuff("target", magic.Icy, "player") and ni.unit.debuffremaining("target", magic.Icy, "player") <= 5))
		and ni.spell.available(magic.Pestilence) then
			ni.spell.cast(magic.Pestilence)
			return true;
		end
	end,
	["MindFreeze"] = function()
		if ni.spell.valid("target", magic.MindFreeze, true, true, false)
		and ni.spell.shouldinterrupt("target")
		and ni.spell.cd(magic.MindFreeze) == 0
		and ni.player.power() >= 20 then
			ni.spell.cast(magic.MindFreeze)
			return true;
		end
	end,
	["Strangulation"] = function()
		if ni.spell.available(magic.Strangulation)
		and ni.spell.valid("target", magic.Strangulation, true, true, false)
		and ni.unit.hasheal("target")
		and ni.spell.shouldinterrupt("target") then
			ni.spell.cast(magic.Strangulation, "target")
			return true;
		end
	end,
	["Save"] = function()
		local _, _, EnemyClass = UnitClass("target")
		local _, BR = ni.rune.bloodrunecd()
		if ni.spell.cd(magic.FirmnessOfIce) == 0
		and ni.player.power() >= 20
		and UnitAffectingCombat("player")
		and ni.player.hp() <= 90
		and ni.unit.exists("target") then
			ni.spell.cast(magic.FirmnessOfIce)
			return true;
		end
		if ni.spell.cd(magic.AMagicCarapace) == 0
		and ni.player.power() >= 20
		and UnitAffectingCombat("player")
		and ni.player.hp() <= 65
		and ni.unit.exists("target") then
			ni.spell.cast(magic.AMagicCarapace)
			return true;
		end
		if UnitAffectingCombat("player")
		and ni.player.buff(magic.AMagicCarapace)
		and BR >= 1
		and ni.spell.cd(magic.CaptureTheRunes) == 0 then
		ni.spell.cast(magic.CaptureTheRunes)
		return true;
		end
		if (EnemyClass == 1 or EnemyClass == 2 or EnemyClass == 4 or EnemyClass == 6) then
			if UnitAffectingCombat("player")
			and ni.player.hp() <= 60
			and ni.spell.cd(magic.CaptureTheRunes) ~= 0
			and ni.spell.available(magic.BloodMark)
			and ni.spell.valid("target", magic.Chains, true, true, false) then
			ni.spell.cast(magic.BloodMark)
			return true;
			end
		end
		if ni.spell.cd(magic.Eating) == 0
		and ni.player.power() >= 40
		and ni.player.hp() <= 35
		and ni.unit.exists("playerpet") then
			ni.spell.cast(magic.Eating)
			return true;
		end
  	end,
	["WinterHorn"] = function()
		if ni.spell.available(magic.WinterHorn)
		and (not ni.player.buff(magic.WinterHorn) or ni.player.buffremaining(magic.WinterHorn) <= 10)
		and not UnitAffectingCombat("player") then
			ni.spell.cast(magic.WinterHorn)
			return true;
		end
	end,
	["RunicStrike"] = function()
		if TargetWithoutSave("target") then
			if ni.spell.valid("target", magic.PlagueStrike, true, true, false)
			and ni.spell.cd(magic.RunicStrike) == 0
			and ni.player.power() >= 20
			and not IsCurrentSpell(magic.RunicStrike)
			and IsUsableSpell(magic.RunicStrike) then
				ni.spell.cast(magic.RunicStrike)
				return true;
			end
		end
	end,
	["BloodDrain"] = function()
		if ni.rune.bloodrunecd() == 2
		and ni.spell.cd(magic.BloodDrain) == 0 then
			ni.spell.cast(magic.BloodDrain)
			return true;
		end
	end,
	["DeathCoil"] = function()
		if TargetWithoutSave("target") then
			if ni.spell.valid("target", magic.DeathCoil, true, true, false)
			and ni.spell.available(magic.DeathCoil)
			and (ni.rune.available() == 0 or not ni.player.inmelee("target"))
			and ni.player.power() >= 41 then
				ni.spell.cast(magic.DeathCoil)
				return true;
			end
		end
	end,
	["EnhancingRuneWeapons"] = function()
		if ni.rune.available() == 0
		and ni.spell.cd(magic.BloodDrain) ~= 0
		and ni.spell.cd(magic.EnhancingRuneWeapons) == 0 then
			ni.spell.cast(magic.EnhancingRuneWeapons)
			return true;
		end
	end,
	["Shield"] = function()
		if ni.spell.available(magic.BoneShield)
		and not ni.player.buff(magic.BoneShield) then
			ni.spell.cast(magic.BoneShield)
			return true;
		end
	end,
	["Pot"] = function()
		if UnitAffectingCombat("player")
		and ni.player.hp() < 65
		and ni.player.hasitem(33447)
		and ni.player.itemcd(33447) == 0 then
			ni.player.useitem(33447)
			return true;
		end
	end,
	["HS"] = function()
		local hstones = { 36892, 36893, 36894 }
		for i = 1, #hstones do
			if UnitAffectingCombat("player")
			and ni.player.hp() < 65
			and ni.player.hasitem(hstones[i])
			and ni.player.itemcd(hstones[i]) == 0 then
				ni.player.useitem(hstones[i])
				return true;
			end
		end
	end,
	["Tp1"] = function()
		if ni.unit.exists("target")
		and ni.spell.cd(magic.Blink) == 0
		and IsFalling()
		and ni.player.distance("target") > 7
		and ni.spell.valid("target", magic.Chains, false, true, false) then
			ni.spell.castat(magic.Blink, "target")
			return true;
		end
	end,
	["Trink"] = function()
		if ni.player.hasitem(42126)
		and ni.player.itemcd(42126) == 0
    	and (ni.player.isconfused() or ni.player.isfleeing()) then
			ni.player.useitem(42126)
			return true;
		end
	end,
	["Pet"] = function()
		local PetAbi = GetSpellInfo(47468)
		local PetStun = GetSpellInfo(47481)
		if ni.unit.exists("playerpet") then
			if UnitCanAttack("player", "target")
			and ni.unit.hp("playerpet") >= 30
			and not UnitIsUnit("target", "pettarget") then
				ni.player.runtext("/petattack")
				return true;
			end
			if ni.spell.available(magic.Bers)
			and not ni.unit.buff("playerpet", magic.Bers)
			and ni.spell.valid("playerpet", magic.Bers, false, true, true)
			and ni.unit.hp("playerpet") <= 30 then
				ni.spell.cast(magic.Bers)
				return true;
			end
			if ni.unit.inmelee("playerpet", "target")
			and ni.player.petcd(PetStun) == 0
			and ni.unit.power("playerpet") >= 35
			and (ni.unit.hp("target") <= 22 or IsLeftAltKeyDown()) then
				ni.spell.cast(PetStun, "target")
				return true;
			end
			if ni.unit.inmelee("playerpet", "target")
			and UnitCanAttack("player", "target")
			and ni.player.petcd(PetAbi) == 0
			and ni.unit.power("playerpet") >= 70 then
				ni.spell.cast(PetAbi, "target")
				return true;
			end
		end
		if not ni.unit.exists("playerpet")
		and not ni.player.buff(61431)
		and ni.spell.available(magic.Summon) then
			ni.spell.cast(magic.Summon)
			return true;
		end
	end
}
ni.bootstrap.profile("PVP", order, moves)