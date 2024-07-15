local magic = {
    ShieldBlock = GetSpellInfo(2565),
    BloodyRage = GetSpellInfo(2687),
    noStepBack = GetSpellInfo(12975),
    Provoke = GetSpellInfo(355),
    DeppDefence = GetSpellInfo(871),
    HeroicThrow = GetSpellInfo(57755),
    PowerfulShieldStrike = GetSpellInfo(47488),
    StunningStrike = GetSpellInfo(12809),
    Revenge = GetSpellInfo(57823),
    Crushing = GetSpellInfo(47498),
    ShieldStrike = GetSpellInfo(72),
    PowerWave = GetSpellInfo(46968),
    Recovery = GetSpellInfo(55694),
    DismoraleShout = GetSpellInfo(47437),
    CommandShout = GetSpellInfo(47440),
    BattleShout = GetSpellInfo(47436),
    Interception = GetSpellInfo(20252),
    CleaveStrike = GetSpellInfo(47520),
    BerserkersRage = GetSpellInfo(18499),
    Bloody = GetSpellInfo(47465),
    Charge = GetSpellInfo(11578),
    HeroStrike = GetSpellInfo(47450),
    ThunderStrike = GetSpellInfo(47502),
    ThunderStomp = GetSpellInfo(20549),
    Fury = GetSpellInfo(57516),
    ShatterArmor = GetSpellInfo(58567),
    SnS = GetSpellInfo(50227),
    FreeHS = GetSpellInfo(58363),
    Vigilance = GetSpellInfo(50720),
    DefStance = GetSpellInfo(71),
    Autoattack = GetSpellInfo(6603),
    AgroShout = GetSpellInfo(1161),
    ToxicStrike = GetSpellInfo(694),
    FearShout = GetSpellInfo(5246),
    Cut = GetSpellInfo(1715),
    BersStance = GetSpellInfo(2458),
    Freedom = GetSpellInfo(3411),
    Dizarm = GetSpellInfo(676),
    MagicRef = GetSpellInfo(23920),
    PhicicalRef = GetSpellInfo(20230),
    BattleStance = GetSpellInfo(2457),
    Crazy = GetSpellInfo(1719),
    };
    local freedomdebuff = { 45524, 1715, 3408, 59638, 20164, 25809, 31589, 51585, 50040, 50041, 31124, 122, 44614, 339, 45334, 58179, 61391, 19306, 19185, 35101, 5116, 2974, 61394, 54644, 50245, 50271, 54706, 4167, 33395, 55080, 6136, 120, 116, 31589, 20170, 31125, 3409, 26679, 64695, 63685, 8056, 8034, 18118, 18223, 63311, 23694, 1715, 12323, 39965, 55536, 13099, 32859, 32065, 22800, 3604, 33967, 12023, 47698, 38316, 15063, 49717 };
    local BadBuff = {45438, 642, 20230, 33786, 47585, 19263};
    local LastCharge, LastControl, LastAction, LastStance = 0, 0, 0, 0;
    local order = {
        "DefStance",
        "BersStance",
        "Berserkers Rage",
        "Trink",
        "Pause",
        "BattleStance",
        "Shout",
        "Gloves",
        "R_ATTACK",
        "Fear Shout",
        "Potions",
        "Healthstone",
        "Freedom",
        "Shield Block",
        "Deep Defence",
        "NoStepBack",
        "Recovery",
        "Ref",
        "Heroic Throw",
        "Shield Strike",
        "Power Wave",
        "Stunning Strike",
        --"Charge",
        --"Interception",
        --"Boots",
        "Dizarm",
        "Revenge",
        "Strike",
        "Bloody Rage",
        "Bloody",
        "Powerful Shield Strike",
        "Crushing",
    };
    local moves = {
        ["R_ATTACK"] = function()
            if ni.unit.exists("target")
			and UnitCanAttack("player", "target")
			and ni.player.inmelee("target")
            and not IsCurrentSpell(6603) then
                ni.player.runtext("/startattack")
            end
        end,
        ["Pause"] = function()
            if IsMounted()
            or ni.player.buff(430)
            or ni.player.buff(433)
            or ni.player.isconfused()
            or ni.player.isstunned()
            or ni.player.iscasting()
            or ni.player.ischanneling()
            or UnitIsDeadOrGhost("player")
            or UnitIsDeadOrGhost("target")
            or IsLeftShiftKeyDown() then
                return true
            end
        end,
        ["DefStance"] = function()
            if GetTime() - LastStance > 1.3
            and not ni.player.aura(magic.DefStance)
            and ni.spell.available(magic.DefStance) then
                ni.spell.cast(magic.DefStance)
                LastStance = GetTime()
            end
        end,
        ["BattleStance"] = function()
            if ni.spell.valid("target", magic.PowerfulShieldStrike, true)
            and ni.player.hp() <= 70
            and ni.spell.available(magic.PhicicalRef)
            --and GetTime() - LastStance >= 1
            and not ni.player.aura(magic.BattleStance)
            and ni.spell.available(magic.BattleStance) then
                ni.spell.cast(magic.BattleStance)
                LastStance = GetTime()
            end
            if ni.player.aura(magic.BattleStance)
            and ni.spell.available(magic.PhicicalRef)
            and UnitAffectingCombat("player") then
                ni.spell.cast(magic.PhicicalRef)
            end
        end,
        ["BersStance"] = function()
            if #ni.player.enemiesinrange(15) == 1
            and ni.player.hp() > 60
            and ni.spell.valid("target", magic.PowerfulShieldStrike, true)
            and ni.spell.available(magic.Crazy)
            --and GetTime() - LastStance >= 1
            and not ni.player.aura(magic.BersStance)
            and ni.spell.available(magic.BersStance) then
                ni.spell.cast(magic.BersStance)
                LastStance = GetTime()
            end
            if ni.player.aura(magic.BersStance)
            and ni.spell.available(magic.Crazy)
            and UnitAffectingCombat("player") then
                ni.spell.cast(magic.Crazy)
            end
        end,
        ["Shout"] = function()
            if (not ni.player.buff(magic.BattleShout) or ni.player.buffremaining(magic.BattleShout) < 30)
            and not ni.player.buff(48934)
            and ni.spell.available(magic.BattleShout)
            and GetTime() - LastAction >= 0.66 then
                ni.spell.cast(magic.BattleShout)
            end
            if (not ni.player.buff(magic.CommandShout) or ni.player.buffremaining(magic.CommandShout) < 30)
            and ni.player.buff(48934)
            and not ni.player.buff(magic.CommandShout)
            and ni.spell.available(magic.CommandShout)
            and GetTime() - LastAction >= 0.66 then
                ni.spell.cast(magic.CommandShout)
            end
        end,
        ["Berserkers Rage"] = function ()
            if ni.player.isfleeing()
            and ni.spell.available(magic.BerserkersRage) then
                ni.spell.cast(magic.BerserkersRage)
                LastAction = GetTime()
            end
        end,
        ["Shield Block"] = function()
            if UnitAffectingCombat("player")
            and ni.spell.valid("target", magic.HeroicThrow, false, true)
            and ni.player.hp() <= 90
            and ni.spell.available(magic.ShieldBlock)
            and GetTime() - LastAction >= 0.66 then
                ni.spell.cast(magic.ShieldBlock)
                LastAction = GetTime()
            end
        end,
        ["Bloody"] = function ()
            for _, v in ipairs(BadBuff) do
                if ni.unit.buff("target", v) then
                    return false
                end
            end
            if (not ni.unit.debuff("target", magic.Bloody, "player") or ni.unit.debuffremaining("target", magic.Bloody, "player") <= 3)
            and ni.spell.available(magic.Bloody)
            and ni.spell.valid("target", magic.PowerfulShieldStrike, true)
            and GetTime() - LastAction >= 0.66 then
                ni.spell.cast(magic.Bloody)
                LastAction = GetTime()
            end
        end,
        ["Charge"] = function ()
            for _, v in ipairs(BadBuff) do
                if ni.unit.buff("target", v) then
                    return false
                end
            end
            if ni.spell.cd(magic.Charge) == 0
            and ni.spell.valid("target", magic.Charge, true, true) then
                ni.spell.cast(magic.Charge)
                LastCharge = GetTime()
            end
        end,
        ["Interception"] = function ()
            for _, v in ipairs(BadBuff) do
                if ni.unit.buff("target", v) then
                    return false
                end
            end
            if ni.spell.cd(magic.Charge) ~= 0
            and ni.spell.cd(magic.Interception) == 0
            and ni.player.power() >= 15
            and ni.spell.valid("target", magic.Interception, true, true)
            and GetTime() - LastCharge > 0.8 then
                ni.spell.cast(magic.Interception)
                LastCharge = GetTime()
            end
        end,
        ["Dizarm"] = function ()
			local _, _, EnemyClass = UnitClass("target")
            for _, v in ipairs(BadBuff) do
                if ni.unit.buff("target", v) then
                    return false
                end
            end
            if (EnemyClass == 1 or EnemyClass == 2 or EnemyClass == 3 or EnemyClass == 4 or EnemyClass == 6) and ni.unit.isplayer("target") then
                if not ni.unit.debuff("target", magic.Dizarm, "player")
                and not (ni.unit.debuff("target", magic.StunningStrike) or ni.unit.debuff("target", magic.PowerWave))
                and ni.spell.available(magic.Dizarm)
                and ni.spell.valid("target", magic.PowerfulShieldStrike, true)
                and GetTime() - LastAction >= 0.66 then
                    ni.spell.cast(magic.Dizarm)
                    LastAction = GetTime()
                end
            end
        end,
        ["Fear Shout"] = function ()
            if (IsLeftControlKeyDown() or #ni.player.enemiesinrange(5) >= 3)
            and ni.spell.available(magic.FearShout)
            and GetTime() - LastAction >= 0.66 then
                ni.spell.cast(magic.FearShout)
                LastAction = GetTime()
            end
        end,
        ["Power Wave"] = function ()
            for _, v in ipairs(BadBuff) do
                if ni.unit.buff("target", v) then
                    return false
                end
            end
                    if not ni.unit.debuff("target", magic.StunningStrike)
                    and ni.spell.cd(magic.StunningStrike) ~= 0
                    and ni.spell.available(magic.PowerWave)
                    and ni.spell.valid("target", magic.PowerfulShieldStrike, true)
                    and ni.player.isfacing("target", 15)
                    and GetTime() - LastControl > 1 then
                        ni.spell.cast(magic.PowerWave)
                        LastControl = GetTime()
            end
        end,
        ["Shield Strike"] = function ()
            local CastInterrupted = not select(9, UnitCastingInfo("target"));
            local ChannelInterrupted = not select(8, UnitChannelInfo("target"));
            for _, v in ipairs(BadBuff) do
                if ni.unit.buff("target", v) then
                    return false
                end
            end
                    if UnitAffectingCombat("player")
                    and ((ni.unit.iscasting("target") and CastInterrupted) or (ni.unit.ischanneling("target") and ChannelInterrupted) or ni.unit.hp("target") < 10)
                    and ni.spell.cd(magic.ShieldStrike) == 0
                    and ni.player.power(1) >= 10
                    and ni.spell.valid("target", magic.PowerfulShieldStrike, true, true) then
                        ni.spell.cast(magic.ShieldStrike)
                        LastAction = GetTime()
            end
        end,
        ["Ref"] = function()
            if (ni.unit.iscasting("target") or ni.unit.ischanneling("target"))
            and ni.player.power() >= 20
            and (ni.spell.cd(magic.ShieldStrike) == 0 or not ni.player.inmelee("target"))
            and ni.spell.cd(magic.MagicRef) == 0 then
                ni.spell.cast(magic.MagicRef)
            end
        end,
        ["Heroic Throw"] = function ()
            local CastInterrupted = not select(9, UnitCastingInfo("target"));
            local ChannelInterrupted = not select(8, UnitChannelInfo("target"));
            for _, v in ipairs(BadBuff) do
                if ni.unit.buff("target", v) then
                    return false
                end
            end
                    if UnitAffectingCombat("player")
                    and ((ni.unit.iscasting("target") and CastInterrupted) or (ni.unit.ischanneling("target") and ChannelInterrupted))
                    and ni.spell.available(magic.HeroicThrow)
                    and ni.spell.valid("target", magic.HeroicThrow, true, true)
                    and GetTime() - LastAction >= 0.66 then
                        ni.spell.cast(magic.HeroicThrow)
                        LastAction = GetTime()
            end
        end,
        ["Crushing"] = function ()
            for _, v in ipairs(BadBuff) do
                if ni.unit.buff("target", v) then
                    return false
                end
            end
                    if ni.spell.available(magic.Crushing)
                    and (not ni.unit.debuff("target", magic.ShatterArmor, "player") or ni.unit.debuffstacks("target", magic.ShatterArmor, "player") < 5 or ni.unit.debuffremaining("target", magic.ShatterArmor, "player") <= 5 or ni.player.power() >= 65)
                    and ni.spell.valid("target", magic.PowerfulShieldStrike, true)
                    and GetTime() - LastAction >= 0.66 then
                        ni.spell.cast(magic.Crushing)
                        LastAction = GetTime()
            end
        end,
        ["Revenge"] = function ()
            for _, v in ipairs(BadBuff) do
                if ni.unit.buff("target", v) then
                    return false
                end
            end
                    if IsUsableSpell(magic.Revenge)
                    and ni.spell.available(magic.Revenge)
                    and ni.spell.valid("target", magic.PowerfulShieldStrike, true)
                    and GetTime() - LastAction >= 0.66 then
                        ni.spell.cast(magic.Revenge)
                        LastAction = GetTime()
            end
        end,
        ["Stunning Strike"] = function ()
            for _, v in ipairs(BadBuff) do
                if ni.unit.buff("target", v) then
                    return false
                end
            end
                    if not ni.unit.debuff("target", magic.PowerWave)
                    and ni.spell.available(magic.StunningStrike)
                    and ni.spell.valid("target", magic.PowerfulShieldStrike, true)
                    and GetTime() - LastControl > 1 then
                    ni.spell.cast(magic.StunningStrike)
                        LastControl = GetTime()
            end
        end,
        ["Bloody Rage"] = function()
            if UnitAffectingCombat("player")
            and ni.player.power() < 55
            and ni.spell.cd(magic.BloodyRage) == 0 then
                ni.spell.cast(magic.BloodyRage)
            end
        end,
        ["NoStepBack"] = function()
            if ni.player.buff(305696)
            and ni.spell.cd(magic.noStepBack) == 0 then
                ni.spell.cast(magic.noStepBack)
            end
        end,
        ["Recovery"] = function()
            if (ni.player.buff(magic.DeppDefence) or ni.player.buff(magic.noStepBack))
            and ni.player.buff(magic.Fury)
            and ni.spell.cd(magic.Recovery) == 0 then
                ni.spell.cast(magic.Recovery)
                LastAction = GetTime()
            end
        end,
        ["Deep Defence"] = function()
            if ni.player.buff(305696)
            and ni.spell.cd(magic.DeppDefence) == 0 then
                ni.spell.cast(magic.DeppDefence)
            end
        end,
        ["Powerful Shield Strike"] = function ()
            for _, v in ipairs(BadBuff) do
                if ni.unit.buff("target", v) then
                    return false
                end
            end
            if ni.spell.available(magic.PowerfulShieldStrike)
            and ni.spell.valid("target", magic.PowerfulShieldStrike, true)
            and GetTime() - LastAction >= 0.66 then
                ni.spell.cast(magic.PowerfulShieldStrike)
                LastAction = GetTime()
            end
        end,
        ["Strike"] = function ()
            for _, v in ipairs(BadBuff) do
                if ni.unit.buff("target", v)
                or ni.unit.isdisarmed("player") then
                    return false
                end
            end
            if not IsCurrentSpell(magic.HeroStrike)
            and ni.spell.cd(magic.HeroStrike) == 0
            and ni.spell.valid("target", magic.PowerfulShieldStrike, true)
            and (ni.player.buff(magic.FreeHS) or ni.player.power() >= 70) then
                ni.spell.cast(magic.HeroStrike)
            end
        end,
        ["Trinket13"] = function()
            if UnitAffectingCombat("player")
            and ni.player.slotcastable(13)
            and ni.player.slotcd(13) == 0
            and (ni.player.buff(magic.noStepBack or ni.player.hp() <= 75))
            and ni.spell.cd(magic.ShieldBlock) ~= 0 then
                ni.player.useinventoryitem(13)
            end
        end,
        ["Trinket14"] = function()
            if UnitAffectingCombat("player")
            and ni.player.slotcastable(14)
            and ni.player.slotcd(14) == 0
            and ni.player.hp() <= 75 then
                ni.player.useinventoryitem(14)
            end
        end,
        ["Healthstone"] = function()
            local hstones = { 36892, 36893, 36894 }
            for i = 1, #hstones do
                if UnitAffectingCombat("player")
                and ni.player.hp() < 50
                and ni.player.hasitem(hstones[i])
                and ni.player.itemcd(hstones[i]) == 0 then
                    ni.player.useitem(hstones[i])
                end
            end
        end,
        ["Trink"] = function()
            if UnitAffectingCombat("player")
            and ni.player.hasitem(42126)
            and ni.player.itemcd(42126) == 0
            and (ni.player.isconfused() or (ni.player.isfleeing() and ni.spell.cd(magic.BerserkersRage) ~= 0))
            and GetTime() - LastAction >= 0.66 then
                ni.player.useitem(42126)
                LastAction = GetTime()
            end
        end,
        ["Gloves"] = function()
            for _, v in ipairs(BadBuff) do
                if ni.unit.buff("target", v) then
                    return false
                end
            end
            if UnitAffectingCombat("player")
            and ni.player.slotcastable(10)
            and ni.player.slotcd(10) == 0
            and ni.unit.hp("target") <= 15
            and ni.spell.valid("target", magic.Charge, true, true) then
                ni.player.useinventoryitem(10, "target")
            end
        end,
        ["Boots"] = function()
            if UnitAffectingCombat("player")
            and ni.player.slotcastable(8)
            and ni.player.slotcd(8) == 0
            and ni.spell.cd(magic.Charge) ~= 0
            and ni.spell.cd(magic.Interception) ~= 0
            and ni.spell.cd(magic.Freedom) ~= 0  then
                ni.player.useinventoryitem(8)
            end
        end,
        ["Potions"] = function()
            if UnitAffectingCombat("player")
            and ni.player.hp() < 50
            and ni.player.hasitem(33447)
            and ni.player.itemcd(33447) == 0 then
                ni.player.useitem(33447)
            end
        end,
        ["Freedom"] = function()
            if ni.spell.available(magic.Freedom)
            and (ni.spell.cd(magic.Charge) == 0 or ni.spell.cd(magic.Interception) == 0) then
                for _, x in ipairs(freedomdebuff) do
                    for i = 1, #ni.members do
                        if ni.player.debuff(x)
                        and ni.spell.valid(ni.members[i].unit, magic.Freedom, false, true, true)
                        and GetTime() - LastAction > 0.66 then
                            ni.spell.cast(magic.Freedom, ni.members[i].unit)
                            LastAction = GetTime()
                        end
                    end
                end
            end
        end;
    };
    ni.bootstrap.profile("Proto_PVP", order, moves);