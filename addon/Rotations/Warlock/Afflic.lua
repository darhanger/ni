local a = ni.utils.require("riot") or ni.utils.require("riot.enc")
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
    local j, j, y = GetSpellInfo(47864)
    hpotionIcon = "Interface\\Icons\\INV_Alchemy_Elixir_05"
    mpotionIcon = "Interface\\Icons\\INV_Alchemy_Elixir_02"
    local z = {
        settingsfile = "Affliction.json",
        {type = "title", text = "|cffFFFFFFAffliction warlock by WH|r"},
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
                {selected = false, value = 4, text = "\124T" .. y .. ":20:20\124t Проклятие агонии"},
                {selected = false, value = 0, text = "\124t В ручную"}
            },
            key = "Curse"
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
            text = "\124T" .. s .. ":20:20\124t Пламя тьмы",
            tooltip = "Автоматический использовать пламя тьмы",
            enabled = true,
            key = "FlameOfDarkness"
        },
        {type = "title", text = "Основное аое Заклинание|r"},
        {
            type = "dropdown",
            menu = {
                {selected = true, value = 1, text = "\124T" .. u .. ":20:20\124t Семя порчи"},
                {selected = false, value = 2, text = "\124T" .. t .. ":20:20\124t Огненный Ливень"},
                {selected = false, value = 0, text = "\124t В ручную"}
            },
            key = "Aoe"
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
            text = h(36892) .. " Камень здоровья",
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
            text = h(33447) .. " Зелье здоровья",
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
            text = h(33448) .. " Зелье маны",
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
    local function A(B)
        for C, D in ipairs(z) do
            if D.type == "entry" and D.key ~= nil and D.key == B then
                return D.value, D.enabled
            end
            if D.type == "dropdown" and D.key ~= nil and D.key == B then
                for E, F in pairs(D.menu) do
                    if F.selected then
                        return F.value
                    end
                end
            end
            if D.type == "input" and D.key ~= nil and D.key == B then
                return D.value
            end
        end
    end
    local function G()
        ni.GUI.AddFrame("Afflic", z)
    end
    local function H()
        ni.GUI.DestroyFrame("Afflic")
    end
    local I = {PlayerIsMoving = false, InCombat = false, Controled = false}
    local J = {
        ElemenCurse = GetSpellInfo(47865),
        CurseOfDoom = GetSpellInfo(47867),
        Curseoftongues = GetSpellInfo(11719),
        LifeTap = GetSpellInfo(57946),
        Destruction = GetSpellInfo(47813),
        FoulArmor = GetSpellInfo(47893),
        SoulSplit = GetSpellInfo(29858),
        Spoilage = GetSpellInfo(47836),
        FlameOfDarkness = GetSpellInfo(61290),
        FireShower = GetSpellInfo(47820),
        CordOfSoul = GetSpellInfo(19028),
        SoulSplit = GetSpellInfo(29858),
        WanderingSpirits = GetSpellInfo(59164),
        Incantation = GetSpellInfo(47843),
        CurseofAgony = GetSpellInfo(47864),
        ShadowBolt = GetSpellInfo(47809),
        StolenSoul = GetSpellInfo(47855)
    }
    local K = {
        
        "Cache",
        "Pause",
        "FoulArmor",
        "SoulSplit",
        "CordOfSoul",
        "StoneCharm(Create)",
        "Firestone(Use)",
        "Combat specific Pause",
        "Burning(AoE)",
        "AOE",
        "Healthstone (Use)",
        "Heal Potions (Use)",
        "Mana Potions (Use)",
        "FrenzyOfDarkness",
        "FlameOfDarkness",
        "LifeTap",
        "SoulSplit",
        "FireCurse",
        "Curse",
        "Incantation",
        "WanderingSpirits",
        "Destruction",
        "StolenSoul",
        "ShadowBolt"
    }
    local L, M = 0, 0
    local N, O, P = {}, {}, {}
    local Q = {
        ["Cache"] = function()
            if GetTime() - M > 100 then
                ni.utils.resetlasthardwareaction()
                M = GetTime()
            end
            I.InCombat = UnitAffectingCombat("player") or false
            I.PlayerIsMoving = ni.player.ismoving() or false
            I.Controled =
                ni.player.issilenced() or ni.player.isstunned() or ni.player.isconfused() or ni.player.isfleeing() or
                false
            if I.InCombat and GetTime() - L >= 15 then
                wipe(N)
                wipe(O)
                wipe(P)
                L = GetTime()
            end
            ni.vars.debug = select(2, A("Debug"))
        end,
        ["Window"] = function()
            if not c then
                ni.frames.floatingtext:message("Afli warlock By WH")
                print("|cffEE4000=======================================|r")
                print("|cffFFFF00Afflication warlock by whoamiwow|r")
                print("|cff00C957v0.0.1 release|r")
                print("https://discord.gg/6wCgVRhQFs  ----- Wh Project")
                print("• Нажать кнопку АоЕ для переключения режимов")
                print("|cffEE4000=======================================|r")
                c = true
            end
        end,
        ["LifeTap"] = function()
            local j, enabled = A("LifeTap")
            if enabled then
                if ni.player.hp() > 50 and ni.player.power() < 20 and a.spellusablesilence(J.LifeTap) then
                    ni.spell.cast(J.LifeTap)
                end
            end
            local j, enabled = A("LifeTapIsmove")
            if enabled then
                if
                    ni.player.ismoving() and ni.player.hp() >= 50 and ni.player.power() <= 90 and
                        a.spellusablesilence(J.LifeTap)
                 then
                    ni.spell.cast(J.LifeTap)
                end
            end
        end,
        ["Pause"] = function()
            if
                IsMounted() or UnitInVehicle("player") or UnitIsDeadOrGhost("player") or UnitChannelInfo("player") or
                    UnitCastingInfo("player") or
                    ni.vars.combat.casting == true or
                    ni.player.islooting() or
                    ni.player.buff(GetSpellInfo(430)) or
                    ni.player.buff(GetSpellInfo(433)) or
                    not UnitAffectingCombat("player") and ni.vars.followEnabled
             then
                return true
            end
        end,
        ["SoulSplit"] = function()
            local j, enabled = A("SoulSplit")
            if enabled then
                if
                    #ni.members > 1 and ni.unit.threat("player", "target") >= 1 and ni.spell.available(J.SoulSplit) and
                        a.spellusablesilence(J.SoulSplit) and
                        not ni.unit.isboss("target")
                 then
                    ni.spell.cast(J.SoulSplit)
                end
            end
        end,
        ["AOE"] = function()
            local R = A("Aoe")
            if not enabled then
                if R == 0 then
                    return false
                end
                if R == 1 then
                    if ni.spell.available(J.Spoilage) and ni.vars.combat.aoe and a.spellusablesilence(J.Spoilage) then
                        local P = ni.unit.enemiesinrange("player", 30)
                        for S = 1, #P do
                            local T = P[S].guid
                            if
                                ni.spell.valid(T, J.Spoilage, true, true) and
                                    not ni.unit.debuff(T, J.Spoilage, "player") and
                                    not ni.unit.isimmune(T) and
                                    UnitAffectingCombat(T)
                             then
                                ni.spell.cast(J.Spoilage, T)
                            end
                        end
                    end
                    if R == 2 then
                        if ni.vars.combat.aoe and ni.spell.available(47820) then
                            ni.spell.cast(47820, "target")
                            return true
                        end
                    end
                end
            end
        end,
        ["Burning(AoE)"] = function()
            if ni.spell.available(J.Burning) and a.spellusablesilence(J.Burning) and ni.vars.combat.aoe then
                local P = ni.unit.enemiesinrange("player", 30)
                for S = 1, #P do
                    local T = P[S].guid
                    if
                        ni.unit.creaturetype(T) ~= 8 and ni.unit.creaturetype(T) ~= 11 and UnitAffectingCombat(T) and
                            not ni.unit.debuffs(T, "23920||35399||69056", "EXACT") and
                            ni.spell.valid(T, J.Burning, true, true)
                     then
                        ni.spell.cast(J.Burning, T)
                    end
                end
            end
        end,
        ["Healthstone (Use)"] = function()
            local R, enabled = A("healthstoneuse")
            local U = {
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
            if enabled and ni.player.hp() < R and I.InCombat then
                for S = 1, #U do
                    local V = U[S]
                    if ni.player.hasitem(V) and IsUsableItem(V) and ni.player.itemcd(V) == 0 then
                        ni.player.useitem(V)
                        return true
                    end
                end
            end
        end,
        ["Trinkets"] = function()
            if
                ni.player.slotcastable(13) and ni.player.slotcd(13) == 0 and ni.unit.isboss("target") and
                    ni.unit.debuff("target", J.SacrificialFire, "player") or
                    ni.vars.combat.cd
             then
                ni.player.useinventoryitem(13)
            elseif
                ni.player.slotcastable(14) and ni.player.slotcd(14) == 0 and
                    ni.unit.debuff("target", J.SacrificialFire, "player") and
                    ni.unit.isboss("target") or
                    ni.vars.combat.cd
             then
                ni.player.useinventoryitem(14)
            end
        end,
        ["Heal Potions (Use)"] = function()
            local R, enabled = A("healpotionuse")
            local W = {43569, 41166, 40087, 39671, 33934, 33447, 28100, 22829, 13446, 4596, 3928, 1710, 929, 858, 118}
            if enabled and ni.player.hp() < R and I.InCombat then
                for S = 1, #W do
                    local X = W[S]
                    if ni.player.hasitem(X) and IsUsableItem(X) and ni.player.itemcd(X) == 0 then
                        ni.player.useitem(X)
                        return true
                    end
                end
            end
        end,
        ["Mana Potions (Use)"] = function()
            local R, enabled = A("manapotionuse")
            local Y = {43570, 42545, 40087, 40067, 33935, 33448, 28101, 22832, 13444, 13443, 6149, 3827, 3385, 2455}
            if enabled and ni.player.power(0) < R and I.InCombat then
                for S = 1, #Y do
                    local Z = Y[S]
                    if ni.player.hasitem(Z) and IsUsableItem(Z) and ni.player.itemcd(Z) == 0 then
                        ni.player.useitem(Z)
                        return true
                    end
                end
            end
        end,
        ["Combat specific Pause"] = function()
            if UnitAffectingCombat("player") then
                return false
            end
        end,
        ["FoulArmor"] = function()
            local j, enabled = A("FoulArmor")
            if enabled then
                if not ni.unit.buff("player", J.FoulArmor, "player") and a.spellusablesilence(J.FoulArmor) then
                    ni.spell.cast(J.FoulArmor)
                end
            end
        end,
        ["CordOfSoul"] = function()
            local j, enabled = A("CordOfSoul")
            if enabled then
                if
                    not ni.unit.buff("player", J.CordOfSoul, "player") and ni.unit.exists("pet") and
                        a.spellusablesilence(J.CordOfSoul)
                 then
                    ni.spell.cast(J.CordOfSoul)
                end
            end
        end,
        ["StoneCharm(Create)"] = function()
            local j, enabled = A("FireStone")
            if enabled then
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
                local j, enabled = A("FlameOfDarkness")
                if enabled then
                    if
                        a.spellusablesilence(J.FlameOfDarkness) and ni.spell.available(J.FlameOfDarkness) and I.InCombat and
                            ni.unit.distance("player", "target") < 6 and
                            not ni.unit.isplayer("target")
                     then
                        ni.spell.cast(J.FlameOfDarkness, "target")
                    end
                end
            end
        end,
        ["Curse"] = function()
            local R = A("Curse")
            if R == 1 then
                if
                    a.spellusablesilence(J.ElemenCurse) and ni.spell.available(J.ElemenCurse) and
                        not ni.unit.debuff("target", J.ElemenCurse, "player") and
                        ni.spell.valid("target", J.ElemenCurse, true, false, true)
                 then
                    ni.spell.cast(J.ElemenCurse, "target")
                end
            end
            if R == 2 then
                if
                    a.spellusablesilence(J.CurseOfDoom) and ni.spell.available(J.CurseOfDoom) and
                        not ni.unit.debuff("target", J.CurseOfDoom, "player") and
                        ni.spell.valid("target", J.CurseOfDoom, true, false, true)
                 then
                    ni.spell.cast(J.CurseOfDoom, "target")
                end
            end
            if R == 3 then
                if
                    a.spellusablesilence(J.Curseoftongues) and ni.spell.available(J.Curseoftongues) and
                        not ni.unit.debuff("target", J.Curseoftongues, "player") and
                        ni.spell.valid("target", J.Curseoftongues, true, false, true)
                 then
                    ni.spell.cast(J.Curseoftongues, "target")
                end
            end
            if R == 4 then
                if
                    a.spellusablesilence(J.CurseofAgony) and ni.spell.available(J.CurseofAgony) and
                        not ni.unit.debuff("target", J.CurseofAgony, "player") and
                        ni.spell.valid("target", J.CurseofAgony, true, false, true)
                 then
                    ni.spell.cast(J.CurseofAgony, "target")
                end
            end
            if R == 0 then
            end
        end,
        ["Racial"] = function()
            if cache.sirus then
                local _ = {
                    316445,
                    316466,
                    316396,
                    316239,
                    316246,
                    316256,
                    316274,
                    316280,
                    316290,
                    316295,
                    316373,
                    316382,
                    316387,
                    316407,
                    316414,
                    316422,
                    316432
                }
                for S = 1, #_ do
                    if a.spellusable(_[S]) then
                        ni.spell.cast(_[S])
                    end
                end
            end
        end,
        ["WanderingSpirits"] = function()
            if
                not ni.player.ismoving() and ni.spell.available(59164) and ni.spell.valid("target", 59164, true, true) and
                    ni.unit.debuffremaining("target", 59164, "player") < 5 and
                    GetTime() - a.warlock.LastHaunt > 6
             then
                ni.spell.cast(59164, "target")
                a.warlock.LastHaunt = GetTime()
                return true
            end
        end,
        ["Incantation"] = function()
            if
                not ni.player.ismoving() and ni.unit.debuffremaining("target", 47843, "player") < 4 and
                    ni.spell.available(47843) and
                    ni.spell.valid("target", 47843, false, true, true) and
                    GetTime() - a.warlock.LastUA > 2
             then
                ni.spell.cast(47843, "target")
                a.warlock.LastUA = GetTime()
                return true
            end
        end,
        ["Destruction"] = function()
            if a.spellusablesilence(J.Destruction) and ni.spell.available(J.Destruction) then
                if
                    not ni.unit.debuff("target", J.Destruction, "player") and
                        ni.spell.valid("target", J.Destruction, true, false, true)
                 then
                    ni.spell.cast(J.Destruction, "target")
                end
            end
        end,
        ["ShadowBolt"] = function()
            if a.spellusablesilence(J.ShadowBolt) and ni.spell.available(J.ShadowBolt) then
                if
                    not ni.player.ismoving() and ni.unit.hp("target") >= 25 and
                        ni.spell.valid("target", J.ShadowBolt, true, false, true)
                 then
                    ni.spell.cast(J.ShadowBolt, "target")
                end
            end
        end,
        ["StolenSoul"] = function()
            if a.spellusablesilence(J.StolenSoul) and ni.spell.available(J.StolenSoul) then
                if
                    not ni.player.ismoving() and ni.unit.hp("target") <= 25 and
                        ni.spell.valid("target", J.StolenSoul, true, false, true)
                 then
                    ni.spell.cast(J.StolenSoul, "target")
                end
            end
        end
    }
    ni.bootstrap.profile("Afflic", K, Q, G, H)
else
    local K = {"Error"}
    local Q = {["Error"] = function()
            ni.vars.profiles.enabled = false
            if b > 30300 then
                if GetLocale() == "ruRU" then
                    ni.frames.floatingtext:message("Только для 3.3.5a!")
                else
                    ni.frames.floatingtext:message("This profile for WotLK 3.3.5a!")
                end
            elseif ri == nil then
                if GetLocale() == "ruRU" then
                    ni.frames.floatingtext:message("Riot-файл поврежден или отсуствует!")
                else
                    ni.frames.floatingtext:message("Riot file is missing or corrupted!")
                end
            end
        end}
    ni.bootstrap.profile("Afflic", K, Q)
end
