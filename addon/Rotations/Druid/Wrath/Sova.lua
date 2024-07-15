local GetBuildInfo,
    select,
    GetSpellInfo,
    GetItemIcon,
    ipairs,
    pairs,
    GetLocale,
    message,
    IsMounted,
    a,
    UnitInVehicle,
    UnitIsDeadOrGhost,
    UnitChannelInfo,
    UnitCastingInfo,
    UnitAffectingCombat,
    GetRaidTargetIndex,
    IsUsableItem =
    GetBuildInfo,
    select,
    GetSpellInfo,
    GetItemIcon,
    ipairs,
    pairs,
    GetLocale,
    message,
    IsMounted,
    ni.tanks,
    UnitInVehicle,
    UnitIsDeadOrGhost,
    UnitChannelInfo,
    UnitCastingInfo,
    UnitAffectingCombat,
    GetRaidTargetIndex,
    IsUsableItem
local b = ni.utils.require("Riot") or ni.utils.require("Riot.enc")
local c, d = select(4, GetBuildInfo()), false
if c == 30300 and b then
    local function e(f, g, h)
        return "\124T" ..
            (select(3, GetSpellInfo(f)) or select(3, GetSpellInfo(24720))) ..
                ":" .. (h or 25) .. ":" .. (g or 25) .. "\124t"
    end
    local function i(j, g, h)
        return "\124T" ..
            (GetItemIcon(j) or select(3, GetSpellInfo(24720))) .. ":" .. (h or 25) .. ":" .. (g or 25) .. "\124t"
    end
    local k = "Interface\\TARGETINGFRAME\\UI-RaidTargetingIcon_1"
    local l = "Interface\\TARGETINGFRAME\\UI-RaidTargetingIcon_2"
    local m = "Interface\\TARGETINGFRAME\\UI-RaidTargetingIcon_3"
    local n = "Interface\\TARGETINGFRAME\\UI-RaidTargetingIcon_4"
    local o = "Interface\\TARGETINGFRAME\\UI-RaidTargetingIcon_5"
    local p = "Interface\\TARGETINGFRAME\\UI-RaidTargetingIcon_6"
    local q = "Interface\\TARGETINGFRAME\\UI-RaidTargetingIcon_7"
    local r = "Interface\\TARGETINGFRAME\\UI-RaidTargetingIcon_8"
    local s = {}
    local t = {}
    local u = {}
    local v = {
        settingsfile = "Sova.json",
        {type = "title", text = "Balance Druid by WH"},
        {type = "separator"},
        {
            type = "entry",
            text = i(49076) .. " Остановка ротации",
            tooltip = "На значение секунд через макрос /rpause",
            enabled = true,
            value = 5,
            min = 0,
            max = 100,
            step = 1,
            width = 40,
            key = "rpause"
        },
        {type = "separator"},
        {type = "page", number = 1, text = "|cff00ff00Важные настройки|r"},
        {type = "separator"},
        {
            type = "entry",
            text = e(24858) .. " Автоматическая форма",
            tooltip = "Автоматичеси использование форм",
            enabled = true,
            key = "Form"
        },
        {
            type = "entry",
            text = e(48463) .. " Лунный огонь",
            tooltip = "Поддержание на боссе лунного огня",
            enabled = true,
            key = "Moonfire"
        },
        {
            type = "entry",
            text = e(48468) .. " Рой насекомых",
            tooltip = "Поддержание на боссе роя насекомых",
            enabled = true,
            key = "InsectSwarm"
        },
        {
            type = "entry",
            text = e(770) .. " Волшебный огонь",
            tooltip = "В начале боя кидаем волшебный огонь",
            enabled = true,
            key = "FaerieFire"
        },
        {
            type = "entry",
            text = e(33831) .. " Сила природы",
            tooltip = "Вызываем пеньков под удобный случай",
            enabled = false,
            key = "ForceOfNature"
        },
        {
            type = "entry",
            text = e(61384) .. " Тафун",
            tooltip = "Откидываем противников(ОСТОРОЖНО МОЖНО ПОЛУЧИТЬ ПИЗДЫ ОТ РЛА!)",
            enabled = false,
            key = "Typhoon"
        },
        {type = "separator"},
        {type = "title", text = "|cFFFF4500Звездопад|r"},
        {
            type = "dropdown",
            menu = {
                {selected = true, value = 1, text = e(53201, 20, 20) .. " По кнопке CD"},
                {selected = false, value = 2, text = e(53201, 20, 20) .. " Автоматический на боссе"},
                {selected = false, value = 3, text = e(53201, 20, 20) .. " В ручную"}
            },
            key = "Starfall"
        },
        {
            type = "entry",
            text = e(53201) .. " Звездопад в АОЕ",
            tooltip = "Включает звездопал в аое ротацию",
            enabled = false,
            key = "StarfallAoe"
        },
        {type = "separator"},
        {type = "title", text = "|cff00ff00Дополнительно|r"},
        {type = "separator"},
        {
            type = "entry",
            text = i(40713) .. " Тринькеты",
            tooltip = "Использование тринькетов которые можно прожать",
            tooltip = "Автоиспользование тринькетов",
            enabled = true,
            key = "trinket"
        },
        {
            type = "entry",
            text = e(33786) .. " Автоматический контроль союзников",
            tooltip = "Кидаем смерч в союзника РАБОТАЕТ ТОЛЬКО ПО МЕТКАМ",
            enabled = true,
            key = "Cyclone"
        },
        {type = "title", text = "|cFFFF4500Циклон по метке|r"},
        {
            type = "dropdown",
            menu = {
                {selected = true, value = 1, text = "\124T" .. k .. ":22:22\124t Звезда"},
                {selected = false, value = 2, text = "\124T" .. l .. ":22:22\124t Круг"},
                {selected = false, value = 3, text = "\124T" .. m .. ":22:22\124t Ромб"},
                {selected = false, value = 4, text = "\124T" .. n .. ":22:22\124t Треугольник"},
                {selected = false, value = 5, text = "\124T" .. o .. ":22:22\124t Луна"},
                {selected = false, value = 6, text = "\124T" .. p .. ":22:22\124t Квадрат"},
                {selected = false, value = 7, text = "\124T" .. q .. ":22:22\124t Крест"},
                {selected = false, value = 8, text = "\124T" .. r .. ":22:22\124t Череп"},
                {selected = false, value = nil, text = "Никого"}
            },
            key = "CycloneForMark"
        },
        {type = "separator"},
        {type = "title", text = "|cFFFF4500Озарение|r"},
        {
            type = "dropdown",
            menu = {
                {selected = false, value = 1, text = e(29166, 20, 20) .. " По фокусу"},
                {selected = true, value = 2, text = e(29166, 20, 20) .. "  По себе"},
                {selected = true, value = 3, text = e(29166, 20, 20) .. "  По хилерам"},
                {selected = false, value = 0, text = "|cffFF0303Ручной режим|r"}
            },
            key = "InnervateMp"
        },
        {type = "title", text = "|cFFFF4500Количество маны при котором использовать озарение|r"},
        {type = "input", enabled = true, value = 35, min = 0, max = 100, step = 1, width = 40, key = "Innervatevalue"},
        {type = "page", number = 2, text = "|cffff0000Защитные настройки|r"},
        {type = "separator"},
        {
            type = "entry",
            text = e(22812) .. "\124t Дубовая кожа",
            tooltip = "Автоматичеси жмет едиснтвенную деф прожимку",
            value = 40,
            min = 0,
            max = 100,
            step = 1,
            width = 40,
            enabled = true,
            key = "Barskin"
        },
        {
            type = "entry",
            text = e(48441) .. "\124t Омоложение",
            tooltip = "",
            value = 55,
            min = 0,
            max = 100,
            step = 1,
            width = 40,
            enabled = true,
            key = "Rejuvenation"
        },
        {type = "separator"},
        {
            type = "entry",
            text = i(36892) .. " Камень здоровья",
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
            text = i(33447) .. " Зелье здоровья",
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
            text = i(33448) .. " Зелье маны",
            tooltip = "Использовать зелье, когда |cff0082FFMP|r < % у персонажа < %.",
            enabled = true,
            value = 25,
            min = 15,
            max = 65,
            step = 1,
            width = 40,
            key = "manapotionuse"
        },
        {type = "page", number = 3, text = "|cFF00FFFFБафы|r"},
        {type = "separator"},
        {
            type = "entry",
            text = e(53307) .. "Шипы",
            tooltip = "Автоматичеси обновление шипов на пресонаже",
            enabled = true,
            key = "Ship"
        },
        {
            type = "entry",
            text = e(48470) .. "Дар дикой природы",
            tooltip = "Автоиспользование бафа если его нет на игроке",
            enabled = true,
            key = "Lapa"
        },
        {type = "separator"}
    }
    local function w(x)
        for y, z in ipairs(v) do
            if z.type == "entry" and z.key ~= nil and z.key == x then
                return z.value, z.enabled
            end
            if z.type == "dropdown" and z.key ~= nil and z.key == x then
                for A, B in pairs(z.menu) do
                    if B.selected then
                        return B.value
                    end
                end
            end
            if z.type == "input" and z.key ~= nil and z.key == x then
                return z.value
            end
        end
    end
    local function C()
        ni.GUI.AddFrame("Sova", v)
    end
    local function D()
        ni.GUI.DestroyFrame("Sova")
    end
    local function E(F, G)
        if tonumber(F) == nil then
            F = ni.spell.id(F)
        end
        local H = false
        if F == nil or F == 0 then
            return false
        end
        local I = GetSpellInfo(F)
        if not ni.player.isstunned() and not ni.player.issilenced() and ni.spell.available(F, G) and IsUsableSpell(I) then
            H = true
        end
        return H
    end
    local J = {
        Form = GetSpellInfo(24858),
        Moonfire = GetSpellInfo(48463),
        InsectSwarm = GetSpellInfo(48468),
        FaerieFire = GetSpellInfo(770),
        ForceOfNature = GetSpellInfo(33831),
        Barskin = GetSpellInfo(22812),
        Cyclone = GetSpellInfo(33786),
        Innervate = GetSpellInfo(29166),
        Hurricane = GetSpellInfo(48467),
        Wrath = GetSpellInfo(48461),
        Starfire = GetSpellInfo(48465),
        Starfall = GetSpellInfo(53201),
        Typhoon = GetSpellInfo(61384),
        Rejuvenation = GetSpellInfo(48441),
        Ship = GetSpellInfo(53307),
        Lapa = GetSpellInfo(48470)
    }
    local K = {InCombat = false, Controled = false, Moved = false, sirus = false}
    local L = {
        "Text",
        "Cache",
        "Pause",
        "Form",
        "Ship",
        "Lapa",
        "Eclipse",
        "Combat specific Pause",
        "Healthstone (Use)",
        "Heal Potions (Use)",
        "Mana Potions (Use)",
        "Barskin",
        "Innervate",
        "Cyclone",
        "Racial",
        "Starfall(Aoe)",
        "ForceOfNature",
        "Typhoon",
        "Hurricane",
        "Starfall",
        "FaerieFire",
        "Moonfire",
        "InsectSwarm",
        "Rotation"
    }
    local M, N = 0, 0
    local O = {67229, 37162, 35280, 36866, 51503, 37122, 38626, 7645, 14515, 63042, 20604, 15859}
    local P = {
        ["Cache"] = function()
            if K.InCombat and GetTime() - M >= 15 then
                wipe(s)
                wipe(t)
                wipe(u)
                M = GetTime()
            end
            if GetTime() - N > 100 then
                ni.utils.resetlasthardwareaction()
                N = GetTime()
            end
            K.InCombat = UnitAffectingCombat("player") or false
            K.Controled =
                ni.player.issilenced() or ni.player.isstunned() or ni.player.isconfused() or ni.player.isfleeing() or
                false
            K.Moved = ni.player.ismoving() or false
            K.sirus = b.sirusserver() or false
        end,
        ["Racial"] = function()
            if K.sirus then
                local Q = {
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
                    316432,
                    320554
                }
                for R = 1, #Q do
                    if b.spellusable(Q[R]) and b.getrange("target", J.Wrath) then
                        ni.spell.cast(Q[R])
                    end
                end
            end
        end,
        ["Innervate"] = function()
            local S = w("InnervateMp")
            local T = w("Innervatevalue")
            if T == 0 then
                return false
            end
            if b.spellusablesilence(J.Innervate) then
                if S == 1 then
                    if
                        ni.power.current("focus", 0) <= T and not ni.unit.buff("focus", J.Innervate) and
                            ni.spell.valid("focus", J.Innervate, false, true, true)
                     then
                        ni.spell.cast(J.Inner, "focus")
                        return true
                    end
                end
                if S == 2 then
                    if ni.player.power(0) <= T and not ni.player.buff(J.Innervate) then
                        ni.spell.cast(J.Innervate)
                        return true
                    end
                end
                if S == 3 then
                    for R = 1, #ni.members do
                        local U = ni.members[R].guid
                        if ni.unit.hasheal(U) then
                            if
                                ni.power.current(U, 0) <= T and not ni.unit.buff(U, J.Innervate) and
                                    ni.spell.valid(U, J.Innervate, false, true, true)
                             then
                                ni.spell.cast(J.Innervate, U)
                                return true
                            end
                        end
                    end
                end
            end
        end,
        ["text"] = function()
            if not d then
                if not K.sirus then
                    ni.frames.floatingtext:message("Balance Druid By WH")
                    print("|cffEE4000=======================================|r")
                    print("|cffFFFF00Balance Druid by whoamiwow|r")
                    print("|cff00C957v0.0.1 release|r")
                    print("https://discord.gg/6wCgVRhQFs  ----- Wh Project")
                    print("• Нажать кнопку АоЕ для переключения режимов")
                    print("|cffEE4000=======================================|r")
                    d = true
                end
            end
        end,
        ["Rotation Pause"] = function()
            local T, enabled = w("rpause")
            if enabled then
                SLASH_PAUSE1 = "/rpause"
                SlashCmdList.PAUSE = function()
                    ni.rotation.delay(T)
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
                    ni.player.aura(40120) or
                    ni.player.aura(783) or
                    not K.InCombat and ni.vars.followEnabled
             then
                return true
            end
        end,
        ["Form"] = function()
            local V, enabled = w("Form")
            if enabled then
                if b.spellusablesilence(J.Form) and not ni.player.aura(J.Form) then
                    ni.spell.cast(J.Form)
                end
            end
        end,
        ["Ship"] = function()
            local V, enabled = w("Ship")
            if enabled then
                if not ni.player.buff(53307) and E(53307) then
                    ni.spell.cast(53307)
                    return true
                end
            end
        end,
        ["Lapa"] = function()
            local V, enabled = w("Lapa")
            if enabled then
                if not ni.player.buff(48470) and E(48470) then
                    ni.spell.cast(48470)
                    return true
                end
            end
        end,
        ["Eclipse"] = function()
            if not eclipse then
                eclipse = "solar"
            end
            if ni.player.buff(48517) then
                eclipse = "solar"
            elseif ni.player.buff(48518) then
                eclipse = "lunar"
            elseif not K.InCombat then
                eclipse = "solar"
            end
        end,
        ["Combat specific Pause"] = function()
            if K.InCombat then
                return false
            end
            for R = 1, #ni.members do
                if UnitAffectingCombat(ni.members[R].unit) then
                    return false
                end
            end
            return true
        end,
        ["Heal Potions (Use)"] = function()
            local T, enabled = w("healpotionuse")
            local W = {43569, 41166, 40087, 39671, 33934, 33447, 28100, 22829, 13446, 4596, 3928, 1710, 929, 858, 118}
            if enabled and ni.player.hp() < T and not K.Controled and K.InCombat then
                for R = 1, #W do
                    local X = W[R]
                    if ni.player.hasitem(X) and IsUsableItem(X) and ni.player.itemcd(X) == 0 then
                        ni.player.useitem(X)
                        return true
                    end
                end
            end
        end,
        ["Healthstone (Use)"] = function()
            local T, enabled = w("healthstoneuse")
            local Y = {
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
            if enabled and ni.player.hp() < T and not K.Controled and K.InCombat then
                for R = 1, #Y do
                    local X = Y[R]
                    if ni.player.hasitem(X) and IsUsableItem(X) and ni.player.itemcd(X) == 0 then
                        ni.player.useitem(X)
                        return true
                    end
                end
            end
        end,
        ["Mana Potions (Use)"] = function()
            local T, enabled = w("manapotionuse")
            local Z = {43570, 42545, 40087, 40067, 33935, 33448, 28101, 22832, 13444, 13443, 6149, 3827, 3385, 2455}
            if enabled and ni.player.power(0) < T and not K.Controled and K.InCombat then
                for R = 1, #Z do
                    local X = Z[R]
                    if ni.player.hasitem(X) and IsUsableItem(X) and ni.player.itemcd(X) == 0 then
                        ni.player.useitem(X)
                        return true
                    end
                end
            end
        end,
        ["Cyclone"] = function()
            local V, enabled = w("Cyclone")
            local T = w("CycloneForMark")
            if enabled then
                if not K.Moved and b.spellusablesilence(J.Cyclone) then
                    local u = ni.unit.enemiesinrange("player", 25)
                    for R = 1, #u do
                        local _ = u[R].guid
                        for a0 = 1, #O do
                            if ni.unit.debuff(_, O[a0]) then
                                if
                                    not ni.unit.debuff(_, J.Cyclone, "player") and ni.unit.isplayer(_) and
                                        ni.unit.exists(_) and
                                        ni.drtracker.get(_, "Cyclone") >= 0.5 and
                                        ni.spell.valid(_, J.Cyclone, false, true, true)
                                 then
                                    ni.spell.cast(J.Cyclone, _)
                                    return false
                                end
                            end
                        end
                        if GetRaidTargetIndex(_) == T then
                            if
                                not ni.unit.debuff(_, J.Cyclone, "player") and ni.drtracker.get(_, "Cyclone") >= 0.5 and
                                    ni.spell.valid(_, J.Cyclone, false, true, true)
                             then
                                ni.spell.cast(J.Cyclone, _)
                                return false
                            end
                        end
                    end
                end
            end
        end,
        ["Barskin"] = function()
            local T
            enebled = GetSpellInfo("Barskin")
            if enabled then
                if ni.spell.cd(J.Barskin) == 0 and ni.player.hp() <= T then
                    ni.spell.cast(J.Barskin)
                end
            end
        end,
        ["Starfall(Aoe)"] = function()
            local V, enabled = w("StarfallAoe")
            if enabled then
                if b.spellusablesilence(J.Starfall) and ni.vars.combat.aoe and b.getrange("target", J.Wrath) then
                    ni.spell.cast(J.Starfall)
                end
            end
        end,
        ["FaerieFire"] = function()
            local V, enabled = w("FaerieFire")
            if enabled then
                if
                    b.spellusablesilence(J.FaerieFire) and ni.unit.isboss("target") and
                        not ni.unit.debuff("target", J.FaerieFire) and
                        ni.spell.valid("target", J.FaerieFire, true, true)
                 then
                    ni.spell.cast(J.FaerieFire, "target")
                end
            end
        end,
        ["InsectSwarm"] = function()
            local V, enabled = w("InsectSwarm")
            if enabled then
                if
                    b.spellusablesilence(J.InsectSwarm) and not ni.player.buff(48518) and
                        not ni.unit.debuff("target", J.InsectSwarm, "player") and
                        ni.spell.valid("target", J.InsectSwarm, true, true)
                 then
                    ni.spell.cast(J.InsectSwarm, "target")
                end
            end
        end,
        ["Moonfire"] = function()
            local V, enabled = w("Moonfire")
            if enabled then
                if
                    b.spellusablesilence(J.Moonfire) and not ni.player.buff(48518) and
                        not ni.unit.debuff("target", J.Moonfire, "player") and
                        ni.spell.valid("target", J.Moonfire, true, true)
                 then
                    ni.spell.cast(J.Moonfire, "target")
                end
            end
        end,
        ["Starfall"] = function()
            local T = w("Starfall")
            if T == 1 then
                if b.spellusablesilence(J.Starfall) and ni.vars.combat.cd and b.getrange("target", J.Wrath) then
                    ni.spell.cast(J.Starfall)
                end
            end
            if T == 2 then
                if
                    b.spellusablesilence(J.Starfall) and ni.unit.isboss("target") and
                        (ni.player.buff(48518) or ni.player.buff(48517)) and
                        b.getrange("target", J.Wrath)
                 then
                    ni.spell.cast(J.Starfall)
                end
            end
            if T == 3 then
            end
        end,
        ["ForceOfNature"] = function()
            local V, enabled = w("ForceOfNature")
            if enabled then
                if
                    b.spellusablesilence(J.ForceOfNature) and b.getrange("target", J.Wrath) and
                        (ni.unit.isboss("target") or ni.vars.combat.cd)
                 then
                    ni.spell.castat(J.ForceOfNature, "target")
                end
            end
        end,
        ["Typhoon"] = function()
            local V, enabled = w("Typhoon")
            if enabled then
                if
                    b.spellusablesilence(J.Typhoon) and ni.vars.combat.aoe and ni.unit.exists("target") and
                        ni.unit.distance("player", "target") <= 10
                 then
                    ni.spell.cast(J.Typhoon)
                end
            end
        end,
        ["Hurricane"] = function()
            if
                b.spellusablesilence(J.Hurricane) and ni.vars.combat.aoe and not K.Moved and
                    b.getrange("target", J.Wrath)
             then
                ni.spell.castat(J.Hurricane, "target")
            end
        end,
        ["Rotation"] = function()
            if eclipse == "lunar" then
                if b.spellusablesilence(J.Starfire) and not K.Moved and ni.spell.valid("target", J.Starfire, true, true) then
                    ni.spell.cast(J.Starfire, "target")
                end
            end
            if eclipse == "solar" then
                if b.spellusablesilence(J.Wrath) and not K.Moved and ni.spell.valid("target", J.Wrath, true, true) then
                    ni.spell.cast(J.Wrath, "target")
                end
            end
        end
    }
    ni.bootstrap.profile("Sova", L, P, C, D)
else
    local L = {"Error"}
    local P = {["Error"] = function()
            ni.vars.profiles.enabled = false
            if c > 30300 then
                if GetLocale() == "ruRU" then
                    ni.frames.floatingtext:message("Только для 3.3.5a!")
                else
                    ni.frames.floatingtext:message("This profile for WotLK 3.3.5a!")
                end
            elseif b == nil then
                if GetLocale() == "ruRU" then
                    ni.frames.floatingtext:message("Riot-файл поврежден или отсуствует!")
                else
                    ni.frames.floatingtext:message("Riot file is missing or corrupted!")
                end
            end
        end}
    ni.bootstrap.profile("Sova", L, P)
end
