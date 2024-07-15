local A1 = ni.utils.require("A1")
local weapon = {
    OneHanded = 42286,
    TwoHanded = 33492,
    Shield = 42561
}
local magic = {
    ShieldBlock = GetSpellInfo(2565),
    Bloodrage = GetSpellInfo(2687),
    LastStand = GetSpellInfo(12975),
    Taunt = GetSpellInfo(355), --
    ShieldWall = GetSpellInfo(871),
    HeroicThrow = GetSpellInfo(57755),
    ShieldSlam = GetSpellInfo(47488),
    ConcussionBlow = GetSpellInfo(12809),
    Revenge = GetSpellInfo(57823),
    Devastate = GetSpellInfo(47498), --
    ShieldBash = GetSpellInfo(72),
    Shockwave = GetSpellInfo(46968), --
    EnragedRegeneration = GetSpellInfo(55694),
    DemoralizingShout = GetSpellInfo(47437), --
    CommandingShout = GetSpellInfo(47440),
    BattleShout = GetSpellInfo(47436),
    Intercept = GetSpellInfo(20252),
    Cleave = GetSpellInfo(47520), --
    BerserkerRage = GetSpellInfo(18499),
    Rend = GetSpellInfo(47465),
    Charge = GetSpellInfo(11578),
    HeroicStrike = GetSpellInfo(47450),
    ThunderClap = GetSpellInfo(47502), --
    SunderArmor = GetSpellInfo(58567), --
    SwordAndBoard = GetSpellInfo(50227), --
    GlyphOfRevenge = GetSpellInfo(58363),
    Vigilance = GetSpellInfo(50720),
    DefensiveStance = GetSpellInfo(71),
    AutoAttack = GetSpellInfo(6603),
    ChallengingShout = GetSpellInfo(1161), --
    MockingBlow = GetSpellInfo(694), --
    IntimidatingShout = GetSpellInfo(5246),
    Hamstring = GetSpellInfo(1715),
    BerserkerStance = GetSpellInfo(2458),
    Intervene = GetSpellInfo(3411),
    MortalStrike = GetSpellInfo(47486),
	BattleStance = GetSpellInfo(2457),
    Overpower = GetSpellInfo(7384),
    Execute = GetSpellInfo(47471),
    PiercingHowl = GetSpellInfo(12323),
    Retaliation = GetSpellInfo(20230),
    ShatteringThrow = GetSpellInfo(64382),
    Bladestorm = GetSpellInfo(46924),
    DworfsConcussionBlow = GetSpellInfo(316161),
    Throw = GetSpellInfo(2764),
    Disarm = GetSpellInfo(676),
    Enrage = GetSpellInfo(57516),
    Pummel = GetSpellInfo(6552),
    }
    local freedomdebuff = { 45524, 1715, 3408, 59638, 20164, 25809, 31589, 51585, 50040, 50041, 31124, 122, 44614, 339, 45334, 58179, 61391, 19306, 19185, 35101, 5116, 2974, 61394, 54644, 50245, 50271, 54706, 4167, 33395, 55080, 6136, 120, 116, 31589, 20170, 31125, 3409, 26679, 64695, 63685, 8056, 8034, 18118, 18223, 63311, 23694, 12323, 39965, 55536, 13099, 32859, 32065, 22800, 3604, 33967, 12023, 47698, 38316, 15063, 49717 }
    local BadBuff = {45438, 642, 20230, 33786, 47585, 19263}
    local LastStance, lastbugbers, lastbugslow = 0, 0, 0
    local order = {
        "BerserkerRage",
        "Pause",
        "Stance",
        "Weapons",
        "EnragedRegeneration",
        "Trink",
        "StunTrink",
        "Shout",
        "Potions",
        "Healthstone",
        "ShieldBlock",
        "ShieldWall",
        "LastStand",
        "Ref",
        "Retaliation",
        "Unbuff",
        "Battle Pause",
        "Pummel",
        "R_ATTACK",
        "Gloves",
        "Stun_dworfsConcussionBlow",
        "Bladestorm",
        "IntimidatingShout",
        "HeroicThrow",
        "ShieldBash",
        "Charge",
        "Intercept",
        "Execute",
        "Revenge",
        "MortalStrike",
        "Slowcow",
        "Disarm",
        "Strike",
        "Bloodrage",
        "Rend",
        "ShieldSlam",
    }
    local moves = {
        ["R_ATTACK"] = function()
            if A1.PlayerCanAttack()
            and not IsCurrentSpell(magic.AutoAttack) then
                return ni.player.runtext("/startattack")
            end
            if ni.unit.exists("target")
			and UnitCanAttack("player", "target")
			and not ni.unit.inmelee("player", "target")
            and ni.spell.valid("target", magic.Throw, true, true)
            and ni.spell.available(magic.Throw)
            and not ni.unit.ismoving("player") then
                return ni.spell.cast(magic.Throw)
            end
        end,
        ["Pause"] = function ()
            if ni.player.buff(GetSpellInfo(430))
            or ni.player.buff(GetSpellInfo(433))
            or ni.player.isconfused()
            or ni.player.isfleeing()
            or ni.player.isstunned()
            or UnitIsDeadOrGhost("player") then
                return true
            end
        end,
        ["Battle Pause"] = function ()
            for _, v in ipairs(BadBuff) do
                if ni.unit.buff("target", v)
                or ni.player.buff(magic.Bladestorm) then
                    return true
                end
            end
        end,
        ["Stance"] = function()
            if GetTime() - LastStance > 1
            and ni.unit.hp("player") >= 33
            and (not ni.unit.aura("player", magic.BattleStance) or ni.unit.aura("player", magic.BerserkerStance))
            and ni.spell.available(magic.BattleStance) then
                LastStance = GetTime()
                return ni.spell.cast(magic.BattleStance)
            end
            if GetTime() - LastStance > 5
            and ni.unit.hp("player") <= 30
            --and ni.spell.cd(magic.Retaliation) ~= 0
            and (not ni.unit.aura("player", magic.DefensiveStance) or ni.unit.aura("player", magic.BerserkerStance))
            and ni.spell.available(magic.DefensiveStance) then
                LastStance = GetTime()
                return ni.spell.cast(magic.DefensiveStance)
            end
        end,
        ["Stun_dworfsConcussionBlow"] = function ()
            if ni.spell.cd(magic.DworfsConcussionBlow) == 0 then
                if (ni.unit.iscasting("target") or ni.unit.ischanneling("target")) or ni.unit.hp("target") < 20 then
                    if ni.spell.valid("target", magic.DworfsConcussionBlow, false, true) then
                        return ni.spell.cast(magic.DworfsConcussionBlow, "target")
                    end
                end
                if ni.unit.exists("focus") then
                    if ni.unit.iscasting("focus") or ni.unit.ischanneling("focus") then
                        if ni.spell.valid("focus", magic.DworfsConcussionBlow, false, true) then
                            return ni.spell.cast(magic.DworfsConcussionBlow, "focus")
                        end
                    end
                end
            end
        end,
        ["Unbuff"] = function ()
            if not ni.player.isdisarmed() then
                if ni.player.aura(magic.BattleStance) then
                    if ni.spell.available(magic.ShatteringThrow) then
                        if ni.unit.buff("target", 45438)
                        or ni.unit.buff("target", 642) then
                            if ni.spell.valid("target", magic.ShatteringThrow, true, true)
                            and not ni.player.ismoving() then
                                return ni.spell.cast(magic.ShatteringThrow)
                            end
                            if ni.spell.valid("target", magic.ShatteringThrow, true, true)
                            and ni.player.isfacing("target") then
                                ni.player.stopmoving()
                                return ni.frames.floatingtext:message("Сбить сейв!")
                            end
                        end
                    end
                end
            end
        end,
        ["Weapons"] = function()
            if ni.unit.aura("player", magic.BattleStance)
            and not IsEquippedItem(weapon.TwoHanded) then
                EquipItemByName(weapon.TwoHanded)
                return true
            end
            if ni.unit.aura("player", magic.DefensiveStance)
            and not IsEquippedItem(weapon.OneHanded)
            and not IsEquippedItem(weapon.Shield) then
                EquipItemByName(weapon.OneHanded)
                EquipItemByName(weapon.Shield)
                return true
            end
        end,
        ["Bladestorm"] = function()
            if not ni.player.isdisarmed() then
                if ni.unit.aura("player", magic.BattleStance)
                and ni.player.hp() >= 70 then
                    if ni.spell.cd(magic.MortalStrike) ~= 0
                    and ni.spell.available(magic.Bladestorm)
                    and A1.PlayerCanAttack() then
                        return ni.spell.cast(magic.Bladestorm)
                    end
                end
            end
        end,
        ["Shout"] = function()
            if (not ni.unit.buff("player", magic.BattleShout) or ni.unit.buffremaining("player", magic.BattleShout) < 30)
            and not ni.unit.buff("player", 48934)
            and ni.spell.available(magic.BattleShout) then
                return ni.spell.cast(magic.BattleShout)
            end
            if (not ni.unit.buff("player", magic.CommandingShout) or ni.unit.buffremaining("player", magic.CommandingShout) < 30)
            and (ni.unit.buff("player", 48934) or ni.unit.buff("player", 48932))
            and not ni.unit.buff("player", magic.CommandingShout)
            and ni.spell.available(magic.CommandingShout) then
                return ni.spell.cast(magic.CommandingShout)
            end
        end,
        ["BerserkerRage"] = function ()
            if UnitAffectingCombat("player")
            and ni.player.isfleeing()
            and ni.spell.available(magic.BerserkerRage) then
                return ni.spell.cast(magic.BerserkerRage)
            end
            if ni.player.aura(magic.Bladestorm)
            and #ni.player.enemiesinrange(5) == 0 then
                return CancelUnitBuff("player", magic.Bladestorm);
            end
        end,
        ["ShieldBlock"] = function()
            if ni.unit.aura("player", magic.DefensiveStance) then
                if UnitAffectingCombat("player")
                and IsEquippedItem(weapon.Shield)
                and ni.spell.available(magic.ShieldBlock) then
                    return ni.spell.cast(magic.ShieldBlock)
                end
            end
        end,
        ["Rend"] = function ()
            if ni.unit.aura("player", magic.BattleStance) then
                if not ni.player.isdisarmed() then
                    if ni.unit.debuffremaining("target", magic.Rend, "player") <= 3
                    and ni.spell.available(magic.Rend)
                    and A1.PlayerCanAttack() then
                        return ni.spell.cast(magic.Rend)
                    end
                end
            end
        end,
        ["Charge"] = function ()
            if ni.unit.aura("player", magic.BattleStance) then
                if ni.spell.cd(magic.Charge) == 0
                and ni.spell.valid("target", magic.Charge, true, true)
                and ni.player.distance("target") ~= nil
                and ni.player.distance("target") <= 28 then
                    return ni.spell.cast(magic.Charge)
                end
            end
        end,
        ["Intercept"] = function ()
            if ni.unit.aura("player", magic.BerserkerStance) then
                if ni.spell.cd(magic.Intercept) == 0
                and ni.player.power() >= 15
                and ni.spell.valid("target", magic.Intercept, true, true)
                and ni.player.distance("target") ~= nil
                and ni.player.distance("target") <= 23 then
                    return ni.spell.cast(magic.Intercept)
                end
            end
        end,
        ["Pummel"] = function ()
            if ni.player.aura(magic.BerserkerStance) then
                if ni.spell.cd(magic.Pummel) == 0
                and ni.player.power() >= 11
                and A1.PlayerCanAttack()
                and (ni.unit.iscasting("target") or ni.unit.ischanneling("target")) then
                    return ni.spell.cast(magic.Pummel)
                end
            end
        end,
        ["Disarm"] = function ()
			local _, _, EnemyClass = UnitClass("target")
            if ni.unit.aura("player", magic.DefensiveStance) then
                if (EnemyClass == 1 or EnemyClass == 2 or EnemyClass == 3 or EnemyClass == 4 or EnemyClass == 6) then
                    if ni.spell.cd(magic.Retaliation) ~= 0 then
                        if ni.spell.available(magic.Disarm)
                        and A1.PlayerCanAttack() then
                            return ni.spell.cast(magic.Disarm)
                        end
                    end
                end
            end
        end,
        ["Retaliation"] = function ()
			local _, _, EnemyClass = UnitClass("target")
            if ni.unit.aura("player", magic.BattleStance) then
                if (EnemyClass == 1 or EnemyClass == 2 or EnemyClass == 3 or EnemyClass == 4 or EnemyClass == 6) then
                    if UnitAffectingCombat("player")
                    and ni.spell.available(magic.Retaliation)
                    and ni.unit.hp("player") <= 93 then
                        return ni.spell.cast(magic.Retaliation)
                    end
                end
            end
        end,
        ["Execute"] = function ()
            if not ni.player.isdisarmed() then
                if ni.unit.aura("player", magic.BattleStance) then
                    if ni.spell.available(magic.Execute)
                    and ni.unit.hp("target") <= 20
                    and A1.PlayerCanAttack() then
                        return ni.spell.cast(magic.Execute)
                    end
                end
            end
        end,
        ["Slowcow"] = function ()
            if not ni.player.isdisarmed() then
                if ni.player.aura(magic.BattleStance) then
                    if #ni.player.enemiesinrange(9) == 1 then
                        if not (ni.unit.debuff("target", magic.Hamstring) or ni.unit.debuff("target", magic.PiercingHowl))
                        and ni.spell.available(magic.Hamstring)
                        and A1.PlayerCanAttack()
                        and GetTime() - lastbugslow > 7 then
                            lastbugslow = GetTime()
                            return ni.spell.cast(magic.Hamstring)
                        end
                    end
                    if #ni.player.enemiesinrange(9) > 1 then
                        if not (ni.unit.debuff("target", magic.Hamstring) or ni.unit.debuff("target", magic.PiercingHowl))
                        and ni.spell.available(magic.PiercingHowl)
                        and A1.PlayerCanAttack()
                        and GetTime() - lastbugslow > 7 then
                            lastbugslow = GetTime()
                            return ni.spell.cast(magic.PiercingHowl)
                        end
                    end
                end
            end
        end,
        ["IntimidatingShout"] = function ()
            if #ni.player.enemiesinrange(5) >= 3
            and ni.spell.available(magic.IntimidatingShout) then
                return ni.spell.cast(magic.IntimidatingShout)
            end
        end,
        ["MortalStrike"] = function ()
            if not ni.player.isdisarmed() then
                if ni.spell.available(magic.MortalStrike)
                and A1.PlayerCanAttack() then
                    return ni.spell.cast(magic.MortalStrike)
                end
            end
        end,
        ["ShieldBash"] = function ()
            local CastInterrupted = not select(9, UnitCastingInfo("target"))
            local ChannelInterrupted = not select(8, UnitChannelInfo("target"))
            if ni.player.aura(magic.DefensiveStance) then
                if IsEquippedItem(weapon.Shield)
                and ((ni.unit.iscasting("target") and CastInterrupted) or (ni.unit.ischanneling("target") and ChannelInterrupted))
                and ni.spell.cd(magic.ShieldBash) == 0
                and ni.player.power(1) >= 10
                and A1.PlayerCanAttack() then
                    return ni.spell.cast(magic.ShieldBash)
                end
            end
        end,
        ["HeroicThrow"] = function ()
            if ni.unit.hp("target") <= 18
            and ni.spell.available(magic.HeroicThrow)
            and ni.spell.valid("target", magic.HeroicThrow, true, true) then
                return ni.spell.cast(magic.HeroicThrow)
            end
        end,
        ["Revenge"] = function ()
            if not ni.player.isdisarmed() then
                if ni.player.aura(magic.DefensiveStance) then
                    if IsUsableSpell(magic.Revenge)
                    and ni.spell.available(magic.Revenge)
                    and A1.PlayerCanAttack() then
                        return ni.spell.cast(magic.Revenge)
                    end
                end
                if ni.player.aura(magic.BattleStance) then
                    if IsUsableSpell(magic.Overpower)
                    and ni.spell.available(magic.Overpower)
                    and A1.PlayerCanAttack() then
                        return ni.spell.cast(magic.Overpower)
                    end
                end
            end
        end,
        ["Bloodrage"] = function()
            if UnitAffectingCombat("player")
            and ni.player.power() < 65
            and ni.spell.cd(magic.Bloodrage) == 0
            and GetTime() - lastbugbers > 7 then
                lastbugbers = GetTime()
                return ni.spell.cast(magic.Bloodrage)
            end
        end,
        ["LastStand"] = function()
            if UnitAffectingCombat("player")
            and ni.player.aura(magic.DefensiveStance)
            and ni.spell.available(magic.LastStand) then
                return ni.spell.cast(magic.LastStand)
            end
        end,
        ["ShieldWall"] = function()
            if UnitAffectingCombat("player")
            and IsEquippedItem(weapon.Shield)
            and ni.player.aura(magic.DefensiveStance)
            and ni.spell.cd(magic.ShieldWall) == 0 then
                return ni.spell.cast(magic.ShieldWall)
            end
        end,
        ["ShieldSlam"] = function ()
            if ni.player.aura(magic.DefensiveStance) then
                if IsEquippedItem(weapon.Shield)
                and ni.spell.available(magic.ShieldSlam)
                and ni.spell.valid("target", magic.ShieldSlam, true) then
                    return ni.spell.cast(magic.ShieldSlam)
                end
            end
        end,
        ["Strike"] = function ()
            if not ni.player.isdisarmed() then
                if not IsCurrentSpell(magic.HeroicStrike)
                and (ni.player.buff(magic.GlyphOfRevenge) or ni.player.power() >= 65)
                and ni.spell.valid("target", magic.ShieldSlam, true) then
                    return ni.spell.cast(magic.HeroicStrike)
                end
            end
        end,
        ["Healthstone"] = function()
            local hstones = { 36892, 36893, 36894 }
            for i = 1, #hstones do
                if UnitAffectingCombat("player")
                and ni.player.hp() < 33
                and ni.player.hasitem(hstones[i])
                and ni.player.itemcd(hstones[i]) == 0 then
                    return ni.player.useitem(hstones[i])
                end
            end
        end,
        ["Trink"] = function()
            if UnitAffectingCombat("player")
            and ni.player.hasitem(51378)
            and ni.player.itemcd(51378) == 0
            and (ni.player.isstunned() or ni.player.isconfused() or (ni.player.isfleeing() and ni.spell.cd(magic.BerserkerRage) ~= 0)) then
                return ni.player.useitem(51378)
            end
        end,
        ["StunTrink"] = function()
            if UnitAffectingCombat("player")
            and ni.player.hasitem(51378)
            and ni.player.itemcd(51378) == 0
            and (ni.player.debuff(10308) or ni.player.debuff(magic.Shockwave) or ni.player.debuff(magic.ConcussionBlow)) then
                ni.player.useitem(51378)
                return true
            end
        end,
        ["Gloves"] = function()
            if UnitAffectingCombat("player")
            and ni.player.slotcastable(10)
            and ni.player.slotcd(10) == 0
            and UnitHealth("target") <= 3100
            and ni.player.distance("target") ~= nil
            and ni.player.distance("target") <= 24 then
                return ni.player.useinventoryitem(10, "target")
            end
        end,
        ["Ref"] = function()
            if UnitAffectingCombat("player")
            and ni.unit.aura("player", magic.DefensiveStance)
            and ni.spell.cd(23920) == 0 then
                return ni.spell.cast(23920)
            end
        end,
        ["Potions"] = function()
            if UnitAffectingCombat("player")
            and ni.player.hp() < 50
            and ni.player.hasitem(33447)
            and ni.player.itemcd(33447) == 0 then
                return ni.player.useitem(33447)
            end
        end,
        ["EnragedRegeneration"] = function()
            if UnitAffectingCombat("player")
            and ni.player.hp() <= 60
            and ni.player.buff(magic.Enrage)
            and ni.spell.available(magic.EnragedRegeneration)
            and ni.player.power() > 15 then
                return ni.spell.cast(magic.EnragedRegeneration)
            end
        end,
    }
    ni.bootstrap.profile("ARMS PvP A1 2.0", order, moves)