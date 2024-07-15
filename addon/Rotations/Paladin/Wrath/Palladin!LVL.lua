local S = {
    Seal_of_Righteousness = GetSpellInfo("Печать праведности"),
    light_of_heaven = GetSpellInfo("Свет небес"),
    Blessing_of_Might = ("Благословение могущества"),
    Justice_of_the_Light = ("Правосудие света"),
    Divine_Protection = GetSpellInfo("Божественная защита"),
    Ablution = GetSpellInfo("Омовение"),
	HammerOfJustice = GetSpellInfo("Молот правосудия"),
    Automatic_attack = GetSpellInfo(6603),
    Ally_Taunt = GetSpellInfo("Праведная защита"),
    Weakness = GetSpellInfo(25771),
    FullHealing = GetSpellInfo("Возложение рук")
};
local dontdispel = {30128, 28169, 38806, 70964, 31803, 60814, 69674, 68786, 34916, 34917, 34919, 48159, 48160, 30404, 30405, 31117, 34438, 35183, 43522, 47841, 47843, 65812, 68154, 68155, 68156, 44461, 55359, 55360, 55361, 55362, 61429, 30108, 34914, 74562, 74792, 70867, 70338, 70405 };
for _, v in pairs(dontdispel) do
	ni.healing.debufftoblacklist(v)
end;
local R = {
    "HoldRotation",
    "AutoAttack",
    "IfTank",
    "FullHeal",
    "Seal",
    "Blessing",
    "Save",
    "HammerOfJustice",
    "Justice",
    "Ablution",
    "Heal",
};
local RR = {
    ["HoldRotation"] = function ()
        if IsMounted() or UnitInVehicle("player") or ni.player.buff(GetSpellInfo(430)) or ni.player.buff(GetSpellInfo(433)) or ni.player.isconfused()
        or ni.player.isfleeing() or ni.player.isstunned() or UnitIsDeadOrGhost("player") or IsLeftShiftKeyDown() then
            return true;
        end
    end,
    ["AutoAttack"] = function()
        if ni.unit.exists("target")
        and UnitCanAttack("player", "target")
        and ni.unit.inmelee("player", "target")
        and not IsCurrentSpell(S.Automatic_attack) then
            ni.spell.cast(S.Automatic_attack)
        end
    end,
    ["IfTank"] = function ()
		for i = 1, #ni.members do
		    local MATE = ni.members[i].unit;
			if UnitAffectingCombat("player")
            and ni.spell.cd(S.Ally_Taunt) == 0
            and ni.unit.threat(MATE) == 3
			and #ni.unit.unitstargeting(MATE) >= 1
			and ni.unit.isplayer(MATE)
			and not UnitIsUnit(MATE, "player")
			and ni.spell.valid(MATE, S.Ally_Taunt, false, true, true) then
				ni.spell.cast(S.Ally_Taunt, MATE)
				return true
            end
        end
    end,
    ["Blessing"] = function ()
        if ni.player.buffremaining(S.Blessing_of_Might) < 333
        and ni.spell.available(S.Blessing_of_Might) then
            ni.spell.cast(S.Blessing_of_Might, "player")
        end
    end,
    ["Seal"] = function ()
        if ni.player.buffremaining(S.Seal_of_Righteousness) < 333
        and ni.spell.available(S.Seal_of_Righteousness) then
            ni.spell.cast(S.Seal_of_Righteousness)
        end
    end,
    ["Justice"] = function ()
        if ni.spell.available(S.Justice_of_the_Light)
        and ni.spell.valid("target", S.Justice_of_the_Light, false, true) then
            ni.spell.cast(S.Justice_of_the_Light)
        end
    end,
    ["Save"] = function ()
        if ni.player.hp() < 45
        and ni.spell.cd(S.Divine_Protection) == 0 then
            ni.spell.cast(S.Divine_Protection, "player")
        end
    end,
    ["Ablution"] = function ()
        for i = 1, #ni.members do
            local MATE = ni.members[i].unit;
            if ni.unit.debufftype(MATE, "Poison|Disease")
            and ni.healing.candispel(MATE)
            and ni.spell.available(S.Ablution)
            and ni.spell.valid(MATE, S.Ablution, false, true, true) then
                ni.spell.cast(S.Ablution, MATE)
                return true
            end
        end
    end,
    ["HammerOfJustice"] = function()
		local rangedenemies = ni.player.enemiesinrange(10);
        for i = 1, #rangedenemies do
			local caster = rangedenemies[i].guid;
			if ni.spell.available(S.HammerOfJustice)
			and (ni.unit.iscasting(caster) or ni.unit.ischanneling(caster))
			and ni.spell.valid(caster, S.HammerOfJustice, true, true) then
				ni.spell.cast(S.HammerOfJustice, caster)
                return true
			end
		end
    end,
    ["Heal"] = function ()
        if ni.player.hp() < 50
        and ni.spell.available(S.light_of_heaven)
        and not ni.player.ismoving() then
            ni.spell.cast(S.light_of_heaven, "player")
        end
    end,
    ["FullHeal"] = function ()
        for i = 1, #ni.members do
            local MATE = ni.members[i].unit;
            if ni.unit.hp(MATE) < 13
            and ni.spell.available(S.FullHealing)
            and not ni.unit.debuff(MATE, S.Weakness)
            and ni.spell.valid(MATE, S.FullHealing, false, true, true) then
                ni.spell.cast(S.FullHealing, MATE)
                return true
            end
        end
    end,
};
ni.bootstrap.profile("Palladin!LVL", R, RR)