local a = ni.utils.require("Riot") or ni.utils.require("Riot.enc")
local b, c = select(4, GetBuildInfo()), false
if b == 30300 and a then
    local function d(e, f, g)
        return "\124T" ..
            (select(3, GetSpellInfo(e)) or select(3, GetSpellInfo(24720))) ..
                ":" .. (g or 25) .. ":" .. (f or 25) .. "\124t"
    end
    local function h(i, f, g)
        return "\124T" ..
            (GetItemIcon(i) or select(3, GetSpellInfo(24720))) .. ":" .. (g or 25) .. ":" .. (f or 25) .. "\124t"
    end
    local j, j, k = GetSpellInfo(47893)
    local j, j, l = GetSpellInfo(47865)
    local j, j, m = GetSpellInfo(47867)
    local j, j, n = GetSpellInfo(11719)
    local j, j, o = GetSpellInfo(57946)
    local j, j, p = GetSpellInfo(47878)
    local j, j, q = GetSpellInfo(47888)
    local j, j, r = GetSpellInfo(47847)
    local j, j, s = GetSpellInfo(61290)
    local j, j, t = GetSpellInfo(47820)
    local j, j, u = GetSpellInfo(47836)
    local j, j, v = GetSpellInfo(19028)
    local j, j, w = GetSpellInfo(29858)
    local j, j, x = GetSpellInfo(47811)
    hpotionIcon = "Interface\\Icons\\INV_Alchemy_Elixir_05"
    mpotionIcon = "Interface\\Icons\\INV_Alchemy_Elixir_02"
    local y = {
        settingsfile = "Destr.json",
        {type = "title", text = "|cffFFFFFFDestr warlock by|r |c0010CED1WH|r"},
        {type = "separator"},
        {type = "page", number = 1, text = "|cffFFFF00Основные настройки|r"},
        {type = "separator"},
        {type = "title", text = "Проклятие|r"},
        {
            type = "dropdown",
            menu = {
                {selected = true, value = 1, text = "\124T" .. l .. ":20:20\124t Проклятие стихий"},
                {selected = false, value = 2, text = "\124T" .. m .. ":20:20\124t Проклятие рока"},
                {selected = false, value = 3, text = "\124T" .. n .. ":20:20\124t Проклятие Косноязычия"},
                {selected = false, value = 0, text = "\124t В ручную"}
            },
            key = "Curse"
        },
        {
            type = "entry",
            text = "\124T" .. m .. ":20:20\124t Проклятие рока",
            tooltip = "Автоматический использовать Проклятие рока на боссах",
            enabled = true,
            key = "Boss"
        },
        {
            type = "entry",
            text = "\124T" .. k .. ":20:20\124t Доспех скверны",
            tooltip = "Автоматический накладывать на себя доспех скверны",
            enabled = true,
            key = "FoulArmor"
        },
        {
            type = "entry",
            text = "\124T" .. o .. ":20:20\124t Жизнеотвод",
            tooltip = "Автоматический использовать жизнеотвод",
            enabled = true,
            key = "LifeTap"
        },
        {
            type = "entry",
            text = h(54589) .. "Перчатки бурсты и т.п",
            tooltip = "Автоматический использовать перчатки бурсты и т.п с пулла",
            enabled = true,
            key = "gloves"
        },
        {
            type = "entry",
            text = h(40212) .. "Зелье дикой магии",
            tooltip = "Автоматический использовать Зелье дикой магии под герой",
            enabled = true,
            key = "Bl"
        },
        {
            type = "entry",
            text = "\124T" .. o .. ":20:20\124t Жизнеотвод на ходу",
            tooltip = "Автоматический использовать жизнеотвод на ходу",
            enabled = true,
            key = "LifeTapIsmove"
        },
        {
            type = "entry",
            text = "\124T" .. v .. ":20:20\124t Связка души",
            tooltip = "Автоматический использовать связку души",
            enabled = true,
            key = "CordOfSoul"
        },
        {
            type = "entry",
            text = "\124T" .. q .. ":20:20\124t Создание камня чар",
            tooltip = "Автоматический создавать кмень огня",
            enabled = true,
            key = "FireStone"
        },
        {type = "separator"},
        {type = "title", text = "Настройки АОЕ Заклинаний|r"},
        {type = "separator"},
        {
            type = "entry",
            text = "\124T" .. r .. ":20:20\124t Неистовство тьмы в каст противника",
            tooltip = "Автоматический использовать неистовство тьмы",
            enabled = false,
            key = "FrenzyOfDarkness"
        },
        {
            type = "entry",
            text = "\124T" .. s .. ":20:20\124t Пламя тьмы",
            tooltip = "Автоматический использовать пламя тьмы",
            enabled = true,
            key = "FlameOfDarkness"
        },
        {
            type = "entry",
            text = "\124T" .. t .. ":20:20\124t Огненый ливень",
            tooltip = "Автоматический использовать огненый ливень",
            enabled = true,
            key = "FireShower"
        },
        {type = "page", number = 2, text = "|cff00C957Защитные настройки|r"},
        {type = "separator"},
        {
            type = "entry",
            text = "\124T" .. w .. ":20:20\124t Раскол души",
            tooltip = "Автоматический использовать раскол души",
            enabled = true,
            key = "SoulSplit"
        },
        {
            type = "entry",
            text = "\124T" .. p .. ":24:24\124t Камень здоровья",
            tooltip = "Использовать камень здоровья Чернокнижника, когда |cff00D700HP|r < % у персонажа < %.",
            enabled = true,
            value = 35,
            min = 25,
            max = 65,
            step = 1,
            width = 40,
            key = "healthstoneuse"
        },
        {
            type = "entry",
            text = "\124T" .. hpotionIcon .. ":24:24\124t Зелье здоровья",
            tooltip = "Использовать зелье, когда |cff00D700HP|r < % у персонажа < %.",
            enabled = true,
            value = 30,
            min = 20,
            max = 60,
            step = 1,
            width = 40,
            key = "healpotionuse"
        },
        {
            type = "entry",
            text = "\124T" .. mpotionIcon .. ":24:24\124t Зелье маны",
            tooltip = "Использовать зелье, когда |cff0082FFMP|r < % у персонажа < %.",
            enabled = true,
            value = 25,
            min = 15,
            max = 65,
            step = 1,
            width = 40,
            key = "manapotionuse"
        }
    }
    local function z(A)
        for B, C in ipairs(y) do
            if C.type == "entry" and C.key ~= nil and C.key == A then
                return C.value, C.enabled
            end
            if C.type == "dropdown" and C.key ~= nil and C.key == A then
                for D, E in pairs(C.menu) do
                    if E.selected then
                        return E.value
                    end
                end
            end
            if C.type == "input" and C.key ~= nil and C.key == A then
                return C.value
            end
        end
    end
    local function F()
        ni.GUI.AddFrame("Destr", y)
    end
    local function G()
        ni.GUI.DestroyFrame("Destr")
    end
    local H = {InCombat = false, Controled = false}
    local I = {
        ElemenCurse = GetSpellInfo(47865),
        CurseOfDoom = GetSpellInfo(47867),
        Curseoftongues = GetSpellInfo(11719),
        SacrificialFire = GetSpellInfo(47811),
        Burning = GetSpellInfo(17962),
        Incineration = GetSpellInfo(47838),
        LifeTap = GetSpellInfo(57946),
        Destruction = GetSpellInfo(47813),
        FoulArmor = GetSpellInfo(47893),
        SoulSplit = GetSpellInfo(29858),
        Spoilage = GetSpellInfo(47836),
        FrenzyOfDarkness = GetSpellInfo(47847),
        FlameOfDarkness = GetSpellInfo(61290),
        FireShower = GetSpellInfo(47820),
        CordOfSoul = GetSpellInfo(19028),
        SoulSplit = GetSpellInfo(29858),
        ChaosBolt = GetSpellInfo(59172)
    }
    local J, K = 0, 0
    local L, M, N = {}, {}, {}
    local O = {
        "Cache",
        "Riot",
        "wh",
        "Pause",
        "FoulArmor",
        "SoulSplit",
        "CordOfSoul",
        "Firestone(Create)",
        "Firestone(Use)",
        "Combat specific Pause",
        "Healthstone (Use)",
        "Heal Potions (Use)",
        "Mana Potions (Use)",
        "Life Tap (Glyph Buff)",
        "FrenzyOfDarkness",
        "FlameOfDarkness",
        "LifeTap",
        "BLone",
        "BLtwo",
        "FireShower",
        "Curse",
        "Boss",
        "Destruction",
        "SacrificialFire",
        "ChaosBolt",
        "Trinkets",
        "Use enginer gloves",
        "Burning",
        "Incineration"
    }
    local P = {
        ["Cache"] = function()
            if GetTime() - K > 100 then
                ni.utils.resetlasthardwareaction()
                K = GetTime()
            end
            H.InCombat = UnitAffectingCombat("player") or false
            H.PlayerIsMoving = ni.player.ismoving() or false
            H.Controled =
                ni.player.issilenced() or ni.player.isstunned() or ni.player.isconfused() or ni.player.isfleeing() or
                false
            if H.KnowCleanseSpirit then
                DispelSpell = I.CleanseSpirit
                Type = "Disease|Poison|Curse"
            else
                DispelSpell = I.CureToxins
                Type = "Disease|Poison"
            end
            if H.InCombat and GetTime() - J >= 15 then
                wipe(L)
                wipe(M)
                wipe(N)
                J = GetTime()
            end
        end,
        ["Riot"] = function()
            if not c then
                ni.frames.floatingtext:message("Destr warlock By WH")
                print("|cffEE4000=======================================|r")
                print("|cffFFFF00Destr warlock by whoamiwow|r")
                print("|cff00C957v0.0.1 release|r")
                print("https://discord.gg/6wCgVRhQFs  ----- Wh Project")
                print("• Нажать кнопку АоЕ для переключения режимов")
                print("|cffEE4000=======================================|r")
                c = true
            end
        end,
        ["BLone"] = function()
            local j, Q = z("BL")
            if Q then
                if ni.player.buff(32182) and ni.player.itemcd(40212) == 0 then
                    ni.player.useitem(40212)
                end
            end
        end,
        ["BLtwo"] = function()
            local j, Q = z("BL")
            if Q then
                if ni.player.buff(2825) and ni.player.itemcd(40212) == 0 then
                    ni.player.useitem(40212)
                end
            end
        end,
        ["Use enginer gloves"] = function()
            local j, Q = z("gloves")
            if Q then
                if
                    ni.player.slotcastable(10) and ni.player.slotcd(10) == 0 and
                        (ni.vars.combat.cd or ni.unit.isboss("target"))
                 then
                    ni.player.useinventoryitem(10)
                    return true
                end
            end
        end,
        ["Boss"] = function()
            local j, Q = z("Boss")
            if Q then
                if
                    a.spellusablesilence(I.CurseOfDoom) and ni.spell.available(I.CurseOfDoom) and
                        not ni.unit.isimmune("target") and
                        not ni.unit.debuff("target", I.CurseOfDoom, "player") and
                        ni.spell.valid("target", I.CurseOfDoom, true, false, true)
                 then
                    if ni.unit.isboss("target") then
                        ni.spell.cast(I.CurseOfDoom, "target")
                    end
                end
            end
        end,
        ["Life Tap (Glyph Buff)"] = function()
            if ni.player.hasglyph(63320) and not ni.player.buff(63321) then
                ni.spell.cast(57946)
                return true
            end
        end,
        ["LifeTap"] = function()
            local j, Q = z("LifeTap")
            if Q then
                if ni.player.hp() > 50 and ni.player.power() < 20 and a.spellusablesilence(I.LifeTap) then
                    ni.spell.cast(I.LifeTap)
                end
            end
            local j, Q = z("LifeTapIsmove")
            if Q then
                if
                    ni.player.ismoving() and ni.player.hp() >= 50 and ni.player.power() <= 90 and
                        a.spellusablesilence(I.LifeTap)
                 then
                    ni.spell.cast(I.LifeTap)
                end
            end
        end,
        ["wh"] = function()
            if not c then
                ni.frames.floatingtext:message("Dest lok 3.3.5a create Who am i")
                c = true
            end
        end,
        ["Pause"] = function()
            if a.UniPause() then
                return true
            end
        end,
        ["SoulSplit"] = function()
            local j, Q = z("SoulSplit")
            if Q then
                if
                    #ni.members > 1 and ni.unit.threat("player", "target") >= 1 and ni.spell.available(I.SoulSplit) and
                        a.spellusablesilence(I.SoulSplit) and
                        ni.unit.isboss("target")
                 then
                    ni.spell.cast(I.SoulSplit)
                end
            end
        end,
        ["ChaosBolt"] = function()
            local R = a.warlock.immolate()
            if
                R and not ni.player.ismoving() and ni.spell.available(59172) and
                    ni.spell.valid("target", 59172, true, true)
             then
                ni.spell.cast(59172, "target")
                return true
            end
        end,
        ["Healthstone (Use)"] = function()
            local S, Q = z("healthstoneuse")
            local T = {
                36894,
                36893,
                36892,
                36891,
                36890,
                36889,
                22105,
                22104,
                22103,
                19013,
                19012,
                9421,
                19011,
                19010,
                5510,
                19009,
                19008,
                5509,
                19007,
                19006,
                5511,
                19005,
                19004,
                5512
            }
            if Q and ni.player.hp() < S and not ni.player.isstunned() and UnitAffectingCombat("player") then
                for U = 1, #T do
                    if ni.player.hasitem(T[U]) and ni.player.itemcd(T[U]) == 0 then
                        ni.player.useitem(T[U])
                    end
                end
            end
        end,
        ["Trinkets"] = function()
            local j, Q = z("gloves")
            if Q then
                if
                    ni.player.slotcastable(13) and ni.player.slotcd(13) == 0 and ni.unit.isboss("target") and
                        ni.unit.debuff("target", I.SacrificialFire, "player") or
                        ni.vars.combat.cd
                 then
                    ni.player.useinventoryitem(13)
                elseif
                    ni.player.slotcastable(14) and ni.player.slotcd(14) == 0 and
                        ni.unit.debuff("target", I.SacrificialFire, "player") and
                        ni.unit.isboss("target") or
                        ni.vars.combat.cd
                 then
                    ni.player.useinventoryitem(14)
                end
            end
        end,
        ["Heal Potions (Use)"] = function()
            local S, Q = z("healpotionuse")
            local V = {43569, 41166, 40087, 39671, 33934, 33447, 28100, 22829, 13446, 4596, 3928, 1710, 929, 858, 118}
            if Q and ni.player.hp() < S and not ni.player.isstunned() and UnitAffectingCombat("player") then
                for U = 1, #V do
                    if ni.player.hasitem(V[U]) and ni.player.itemcd(V[U]) == 0 then
                        ni.player.useitem(V[U])
                    end
                end
            end
        end,
        ["Mana Potions (Use)"] = function()
            local S, Q = z("manapotionuse")
            local W = {43570, 42545, 40087, 40067, 33935, 33448, 28101, 22832, 13444, 13443, 6149, 3827, 3385, 2455}
            if Q and ni.player.power(0) < S and not ni.player.isstunned() and UnitAffectingCombat("player") then
                for U = 1, #W do
                    if ni.player.hasitem(W[U]) and ni.player.itemcd(W[U]) == 0 then
                        ni.player.useitem(W[U])
                    end
                end
            end
        end,
        ["Combat specific Pause"] = function()
            if
                a.casterStop("target") or a.PlayerDebuffs("player") or UnitCanAttack("player", "target") == nil or
                    UnitAffectingCombat("target") == nil and ni.unit.isdummy("target") == nil and
                        UnitIsPlayer("target") == nil
             then
                return true
            end
        end,
        ["FoulArmor"] = function()
            local j, Q = z("FoulArmor")
            if Q then
                if not ni.unit.buff("player", I.FoulArmor, "player") and a.spellusablesilence(I.FoulArmor) then
                    ni.spell.cast(I.FoulArmor)
                end
            end
        end,
        ["CordOfSoul"] = function()
            local j, Q = z("CordOfSoul")
            if Q then
                if
                    not ni.unit.buff("player", I.CordOfSoul, "player") and ni.unit.exists("pet") and
                        a.spellusablesilence(I.CordOfSoul)
                 then
                    ni.spell.cast(I.CordOfSoul)
                end
            end
        end,
        ["Firestone(Create)"] = function()
            local j, Q = z("FireStone")
            if Q then
                if
                    ni.player.hasitem(6265) and not ni.player.ismoving() and not UnitAffectingCombat("player") and
                        not ni.player.hasitem(41196)
                 then
                    ni.spell.cast(47888)
                else
                    if not GetWeaponEnchantInfo() and not ni.player.ismoving() then
                        ni.player.useitem(41196)
                        ni.player.useinventoryitem(16)
                        return true
                    end
                end
            end
        end,
        ["FlameOfDarkness"] = function()
            if ni.vars.combat.aoe then
                local j, Q = z("FlameOfDarkness")
                if Q then
                    if
                        a.spellusablesilence(I.FlameOfDarkness) and ni.spell.available(I.FlameOfDarkness) and
                            ni.unit.distance("player", "target") < 6 and
                            not ni.unit.isplayer("target")
                     then
                        ni.spell.cast(I.FlameOfDarkness, "target")
                    end
                end
            end
        end,
        ["Destruction"] = function()
            local X = a.warlock.corruption()
            local Y = a.warlock.seed()
            if
                ni.spell.available(47813) and not X and not Y and ni.spell.valid("target", 47813, false, true, true) and
                    GetTime() - a.warlock.LastCorrupt > 1.5
             then
                ni.spell.cast(47813, "target")
                a.warlock.LastCorrupt = GetTime()
                return true
            end
        end,
        ["Curse"] = function()
            local S = z("Curse")
            if S == 1 then
                if
                    a.spellusablesilence(I.ElemenCurse) and ni.spell.available(I.ElemenCurse) and
                        not ni.unit.isimmune("target") and
                        not ni.unit.debuff("target", I.ElemenCurse, "player") and
                        ni.spell.valid("target", I.ElemenCurse, true, false, true) and
                        not ni.unit.isboss("target")
                 then
                    ni.spell.cast(I.ElemenCurse, "target")
                end
            end
            if S == 2 then
                if
                    a.spellusablesilence(I.CurseOfDoom) and ni.spell.available(I.CurseOfDoom) and
                        not ni.unit.isimmune("target") and
                        not ni.unit.debuff("target", I.CurseOfDoom, "player") and
                        ni.spell.valid("target", I.CurseOfDoom, true, false, true) and
                        not ni.unit.isboss("target")
                 then
                    ni.spell.cast(I.CurseOfDoom, "target")
                end
            end
            if S == 3 then
                if
                    a.spellusablesilence(I.Curseoftongues) and ni.spell.available(I.Curseoftongues) and
                        not ni.unit.isimmune("target") and
                        not ni.unit.debuff("target", I.Curseoftongues, "player") and
                        ni.spell.valid("target", I.Curseoftongues, true, false, true) and
                        not ni.unit.isboss("target")
                 then
                    ni.spell.cast(I.Curseoftongues, "target")
                end
            end
            if S == 0 then
            end
        end,
        ["FireShower"] = function()
            if ni.vars.combat.aoe then
                local j, Q = z("FireShower")
                if Q then
                    if
                        a.spellusablesilence(I.FireShower) and not ni.player.ismoving() and
                            ni.spell.available(I.FireShower)
                     then
                        ni.spell.castat(I.FireShower, "target")
                    end
                end
            end
        end,
        ["FrenzyOfDarkness"] = function()
            if ni.vars.combat.aoe then
                local j, Q = z("FrenzyOfDarkness")
                if Q then
                    if
                        a.spellusablesilence(I.FrenzyOfDarkness) and ni.spell.available(I.FrenzyOfDarkness) and
                            not ni.unit.isplayer("target") and
                            a.getrange("target", 47813)
                     then
                        ni.spell.castat(I.FrenzyOfDarkness, "target")
                    end
                end
            end
        end,
        ["SacrificialFire"] = function()
            if
                not ni.player.ismoving() and
                    ni.unit.debuffremaining("target", 47811, "player") < ni.spell.casttime(47811) and
                    ni.spell.available(47811) and
                    ni.spell.valid("target", 47811, true, true) and
                    GetTime() - a.warlock.Lastimmolate > 2.1
             then
                ni.spell.cast(47811, "target")
                a.warlock.Lastimmolate = GetTime()
                return true
            end
        end,
        ["Burning"] = function()
            local R = a.warlock.immolate()
            if
                R and IsUsableSpell(GetSpellInfo(17962)) and ni.spell.available(17962) and
                    ni.spell.valid("target", 17962, true, true)
             then
                ni.spell.cast(17962, "target")
                return true
            end
        end,
        ["Incineration"] = function()
            if
                a.spellusablesilence(I.Incineration) and ni.spell.cd(I.ChaosBolt) and ni.spell.available(I.Incineration) and
                    not ni.spell.available(I.Burning) and
                    not ni.player.ismoving() and
                    not ni.unit.isimmune("target") and
                    ni.spell.valid("target", I.Incineration, true, false, true)
             then
                ni.spell.cast(I.Incineration, "target")
            end
        end
    }
    ni.bootstrap.profile("Destr", O, P, F, G)
else
    local O = {"Error"}
    local P = {["Error"] = function()
            ni.vars.profiles.enabled = false
            if b > 30300 then
                ni.frames.floatingtext:message("This profile is meant for WotLK 3.3.5a! Sorry!")
            elseif level < 80 then
                ni.frames.floatingtext:message("This profile is meant for level 80! Sorry!")
            elseif data == nil then
                ni.frames.floatingtext:message("Data file is missing or corrupted!")
            end
        end}
    ni.bootstrap.profile("Destr", O, P)
end
