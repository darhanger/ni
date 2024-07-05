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
    local v = {}
    local w = {
        settingsfile = "Rdru.json",
        {type = "title", text = "Restor Druid by WH"},
        {type = "separator"},
        {type = "page", number = 1, text = "|cff00ff00Важные настройки|r"},
        {type = "separator"},
        {type = "entry", text = e(33891) .. " Автоматическая форма", enabled = true, key = "Form"},
        {type = "checkiconbutton", text = e(48451, 20, 20), enabled = true, key = "1245"},
        {type = "checkiconbutton", text = ni.spell.icon(48451, 20, 20), enabled = true, key = "1245"},
        {type = "checkiconbutton", text = e(48451, 20, 20), enabled = true, key = "1245"},
        {type = "title", text = "|cFFFF4500Жизнецвет|r"},
        {
            type = "dropdown",
            menu = {
                {selected = false, value = 1, text = ni.spell.icon(48451, 20, 20) .. " На обеих танков"},
                {selected = false, value = 2, text = e(48451, 20, 20) .. " На главного танка"},
                {selected = false, value = 3, text = e(48451, 20, 20) .. " На офф танка"},
                {selected = true, value = 4, text = e(48451, 20, 20) .. " Умный режим"},
                {selected = false, value = 0, text = "|cffFF0303Не использовать жизнецвет|r"}
            },
            key = "Lifebloom"
        },
        {type = "title", text = "|cFFFF4500Восстановление|r"},
        {
            type = "dropdown",
            menu = {
                {selected = true, value = 1, text = e(48443, 20, 20) .. " На обеих танков"},
                {selected = false, value = 2, text = e(48443, 20, 20) .. " На главного танка"},
                {selected = false, value = 3, text = e(48443, 20, 20) .. " На офф танка"},
                {selected = false, value = 4, text = e(48443, 20, 20) .. " По фокусу"},
                {selected = false, value = 5, text = e(48443, 20, 20) .. " Только на себя"},
                {selected = false, value = 0, text = "|cffFF0303Не использовать восстановление|r"}
            },
            key = "Regrowtn"
        },
        {
            type = "input",
            text = ni.spell.icon(48451),
            enabled = true,
            value = 85,
            min = 0,
            max = 100,
            step = 1,
            width = 40,
            key = "Regrowtn(Hp)"
        },
        {
            type = "entry",
            text = e(48447) .. " Спокойствие",
            tooltip = "Использовать спокойствие когда, количество раненых союзников",
            enabled = true,
            value = 4,
            min = 1,
            max = 40,
            step = 1,
            width = 40,
            key = "TranquilityMembers"
        },
        {type = "title", text = "Количество здоровья, у раненых союзников|r"},
        {type = "input", enabled = true, value = 55, min = 0, max = 100, step = 1, width = 40, key = "TranquilityHp"},
        {
            type = "entry",
            text = e(53251) .. " Буйный рост",
            tooltip = "Использовать буйный рост когда, количество раненых союзников в одной точке",
            enabled = true,
            value = 3,
            min = 1,
            max = 5,
            step = 1,
            width = 40,
            key = "WildGrowthMembers"
        },
        {type = "title", text = "Количество здоровья, у раненых союзников|r"},
        {type = "input", enabled = true, value = 85, min = 0, max = 100, step = 1, width = 40, key = "WildGrowthHp"},
        {type = "separator"},
        {type = "title", text = "|cff00ff00Дополнительно|r"},
        {type = "separator"},
        {
            type = "entry",
            text = ni.spell.icon(2382) .. "Прожимки на боссах",
            tooltip = "Автоматически использует инжу рассовые и другие прожимки(кроме фласок)",
            enabled = true,
            min = 15,
            max = 95,
            step = 1,
            width = 40,
            key = "Prozimki"
        },
        {
            type = "entry",
            text = i(54589) .. " Тринькеты",
            tooltip = "Автоиспользование тринькетов |cff00D700HP|r < %",
            enabled = true,
            key = "Trinkets"
        },
        {
            type = "entry",
            text = i(54589) .. "",
            tooltip = "Использование тринькетов(13 и 14 слот) |cff00D700HP|r < %",
            value = 50,
            min = 15,
            max = 100,
            step = 1,
            width = 40,
            key = "trinket"
        },
        {type = "entry", text = e(33786) .. " Автоматический контроль союзников", enabled = true, key = "Cyclone"},
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
                {selected = false, value = 9, text = e(33786) .. "Авто-контроль на леди"},
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
        {type = "page", number = 2, text = "|cff00ff00Настройки исцеления|r"},
        {type = "separator"},
        {
            type = "entry",
            text = ni.spell.icon(48545) .. "Хилить вне боя",
            tooltip = "Хилит вне боя по |cff00D700HP|r < %",
            enabled = true,
            value = 70,
            min = 15,
            max = 95,
            step = 1,
            width = 40,
            key = "noncombatheal"
        },
        {
            type = "entry",
            text = e(17116) .. " Природная стремительность",
            enabled = true,
            value = 55,
            min = 0,
            max = 100,
            step = 1,
            width = 40,
            key = "NaturesSwiftness"
        },
        {
            type = "entry",
            text = e(18562) .. " Быстрое восстановление",
            enabled = true,
            value = 75,
            min = 0,
            max = 100,
            step = 1,
            width = 40,
            key = "Swiftmend"
        },
        {
            type = "entry",
            text = e(48441) .. " Омоложение",
            enabled = true,
            value = 98,
            min = 0,
            max = 100,
            step = 1,
            width = 40,
            key = "Rejuvenation"
        },
        {
            type = "entry",
            text = e(48443) .. " Умное Восстановление",
            tooltip = "Использует когда средний процент здоровья рейда высок",
            enabled = true,
            value = 70,
            min = 0,
            max = 100,
            step = 1,
            width = 40,
            key = "RegrowtnParty"
        },
        {
            type = "entry",
            text = e(50464) .. " Покровительство природы",
            enabled = true,
            value = 85,
            min = 0,
            max = 100,
            step = 1,
            width = 40,
            key = "Nourish"
        },
        {
            type = "entry",
            text = e(50464) .. " Покровительство природы(Танки)",
            enabled = true,
            value = 75,
            min = 0,
            max = 100,
            step = 1,
            width = 40,
            key = "Nourish(tanks)"
        },
        {type = "entry", text = e(48441) .. "Хотаем без боя", enabled = true, key = "Xoting"},
        {type = "separator"},
        {type = "entry", text = e(2893) .. " Снятие ядов ", tooltip = "", enabled = true, key = "CurePoison"},
        {type = "entry", text = e(2782) .. " Рассеивание проклятий ", enabled = true, key = "RemoveCurse"},
        {type = "title", text = "|cFFFF4500Задержка для диспела|r"},
        {type = "input", enabled = true, value = 1, min = 0, max = 100, step = 1, width = 40, key = "DispelDelay"},
        {type = "page", number = 3, text = "|cffff0000Защитные настройки|r"},
        {type = "separator"},
        {
            type = "entry",
            text = e(22812) .. " Дубовая кожа",
            tooltip = "Использовать дубовую кожу, когда |cff00D700HP|r < % у персонажа < %.",
            enabled = true,
            value = 30,
            min = 20,
            max = 60,
            step = 1,
            width = 40,
            key = "Barskin"
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
        {type = "page", number = 4, text = "|cffff0000Бафы|r"},
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
    local function x(y)
        for z, A in ipairs(w) do
            if A.type == "entry" and A.key ~= nil and A.key == y then
                return A.value, A.enabled
            end
            if A.type == "dropdown" and A.key ~= nil and A.key == y then
                for B, C in pairs(A.menu) do
                    if C.selected then
                        return C.value
                    end
                end
            end
            if A.type == "input" and A.key ~= nil and A.key == y then
                return A.value
            end
        end
    end
    local function D(E, F)
        F = true and F or false
        if tonumber(E) == nil then
            E = ni.spell.id(E)
        end
        local G = false
        if E == nil or E == 0 then
            return false
        end
        if IsSpellKnown(E, F) then
            local y = GetSpellInfo(E)
            if y then
                G = true
            end
        end
        return G
    end
    local function H()
        ni.GUI.AddFrame("Rdru", w)
    end
    local function I()
        ni.GUI.DestroyFrame("Rdru")
    end
    local J = {
        MarkOfTheWild = GetSpellInfo(48469),
        TreeOfLife = GetSpellInfo(33891),
        CurePoison = GetSpellInfo(2893),
        RemoveCurse = GetSpellInfo(2782),
        LifeBloom = GetSpellInfo(48451),
        Regrowtn = GetSpellInfo(48443),
        Rejuvenation = GetSpellInfo(48441),
        Nourish = GetSpellInfo(50464),
        NaturesSwiftness = GetSpellInfo(17116),
        HealingTouch = GetSpellInfo(48378),
        Swiftmend = GetSpellInfo(18562),
        Tranquility = GetSpellInfo(48447),
        WildGrowth = GetSpellInfo(53251),
        Cyclone = GetSpellInfo(33786),
        Barskin = GetSpellInfo(22812),
        Inner = GetSpellInfo(29166),
        Thorns = GetSpellInfo(53307),
        Lapa = GetSpellInfo(48470)
    }
    local K = {PlayerIsMoving = false, InCombat = false, Controled = false, Moved = false}
    local L = {
        
        "Cache",
        "Pause",
        "Non Combat Healing",
        "Ship",
        "Lapa",
        "Xoting",
        "Combat specific Pause",
        "Form",
        "Healthstone (Use)",
        "Heal Potions (Use)",
        "Mana Potions (Use)",
        "Cyclone_members",
        "Cyclone",
        "Barskin",
        "Innervate",
        "Rassovie",
        "Trinkets",
        "Tranquility",
        "Racial",
        "NaturesSwiftness",
        "Rerow",
        "Swiftmend",
        "WildGrowth",
        "Nourish(Tank)",
        "Nourish(Low)",
        "Nourish",
        "LifeBloom",
        "Regrowtn(Tank)",
        "Rejuvenation",
        "Regrowtn",
        "RemoveCurse",
        "CurePoison"
    }
    local M, N = 0, 0
    local s, t, u = {}, {}, {}
    local O = {67229, 37162, 35280, 36866, 51503, 37122, 38626, 7645, 14515, 63042, 20604, 15859, 29546}
    local M, N = 0, 0
    local P = {
        ["Cyclone_members"] = function()
            local Q, R = x("Cyclone")
            local S = x("CycloneForMark")
            if R then
                if not K.Moved then
                    if S == 9 then
                        if b.spellusablesilence(J.Cyclone) then
                            for T = 1, #ni.members do
                                local s = ni.members[T]
                                if UnitIsEnemy("player", s.unit) and s:valid(J.Cyclone, false, true) then
                                    ni.spell.cast(J.Cyclone, s.unit)
                                    return true
                                end
                            end
                        end
                    end
                end
            end
        end,
        ["Window"] = function()
            if not d then
                if not K.sirus then
                    ni.frames.floatingtext:message("Restor Druid By WH")
                    print("|cffEE4000=======================================|r")
                    print("|cffFFFF00Restor Druid by whoamiwow|r")
                    print("|cff00C957v0.0.1 release|r")
                    print("https://discord.gg/6wCgVRhQFs  ----- Wh Project")
                    print("• Нажать кнопку АоЕ для переключения режимов")
                    print("|cffEE4000=======================================|r")
                    d = true
                end
            end
        end,
        ["Non Combat Healing"] = function()
            local S, R = x("noncombatheal")
            if not R or UnitAffectingCombat("player") then
                return false
            end
            if b.spellusablesilence(J.Nourish) and b.spellusablesilence(J.Rejuvenation) then
                local s = ni.members[1]
                if
                    s:hp() <= S and s:valid(J.Nourish, false, true) and
                        not ni.unit.buff(s.unit, J.Rejuvenation, "player")
                 then
                    ni.spell.cast(J.Rejuvenation, s.unit)
                    return true
                end
                if s:hp() <= S and not K.Moved then
                    ni.spell.cast(J.Nourish, s.unit)
                    return true
                end
            end
        end,
        ["Ship"] = function()
            local Q, R = x("Ship")
            if not R or UnitAffectingCombat("player") then
                return false
            end
            if b.spellusablesilence(J.Thorns) and not ni.player.buff(J.Thorns) then
                ni.spell.cast(J.Thorns, "player")
                return true
            end
        end,
        ["Lapa"] = function()
            local Q, R = x("Lapa")
            if not R or UnitAffectingCombat("player") then
                return false
            end
            if not ni.player.buff(48470) and ni.player.power(0) > 30 then
                ni.spell.cast(48470)
                return true
            end
        end,
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
                ni.player.issilenced() or ni.player.isstunned() or ni.player.isconfused() or
                ni.player.isfleeing() or
                false
            K.Moved = ni.player.ismoving() or false
            K.sirus = b.sirusserver() or false
        end,
        ["Racial"] = function()
            if K.sirus then
                local U = {
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
                for T = 1, #U do
                    if
                        b.spellusable(U[T]) and (b.instance() or b.inraid()) and
                            ni.spell.valid(ni.members[1].unit, J.Rejuvenation, false, true, true)
                     then
                        ni.spell.cast(U[T], "player")
                        return true
                    end
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
        ["Nourish(Low)"] = function()
            for T = 1, #ni.members do
                local s = ni.members[T]
                if s:hp() <= 35 and b.spellusablesilence(J.Nourish) and s:valid(J.Nourish, false, true) then
                    ni.spell.cast(J.Nourish, s.unit)
                end
            end
        end,
        ["Nourish(Tank)"] = function()
            local V, W = a()
            local S, R = x("Nourish(tanks)")
            if not R then
                return false
            end
            if V then
                if UnitExists(V.unit) and ni.spell.valid(V.unit, J.Nourish, false, true, true) then
                    if not K.Moved and ni.unit.hp(V.unit) <= S and b.spellusablesilence(J.Nourish) then
                        if ni.unit.buff(V.unit, J.Rejuvenation) or ni.unit.buff(V.unit, J.WildGrowth) then
                            ni.spell.cast(J.Nourish, V.unit)
                            return true
                        end
                    end
                end
                if UnitExists(W.unit) and ni.spell.valid(W.unit, J.Nourish, false, true, true) then
                    if not K.Moved and ni.unit.hp(W.unit) <= S and b.spellusablesilence(J.Nourish) then
                        if ni.unit.buff(W.unit, J.Rejuvenation) or ni.unit.buff(W.unit, J.WildGrowth) then
                            ni.spell.cast(J.Nourish, W.unit)
                            return true
                        end
                    end
                end
            end
        end,
        ["Combat specific Pause"] = function()
            if K.InCombat then
                return false
            end
            for T = 1, #ni.members do
                if UnitAffectingCombat(ni.members[T].unit) then
                    return false
                end
            end
            return true
        end,
        ["Cyclone"] = function()
            local Q, R = x("Cyclone")
            local S = x("CycloneForMark")
            if R then
                if not K.Moved and b.spellusablesilence(J.Cyclone) then
                    local u = ni.unit.enemiesinrange("player", 25)
                    for T = 1, #u do
                        local X = u[T].guid
                        for Y = 1, #O do
                            if ni.unit.debuff(X, O[Y]) then
                                if
                                    not ni.unit.debuff(X, J.Cyclone, "player") and ni.unit.isplayer(X) and
                                        ni.drtracker.get(X, "Cyclone") >= 0.5 and
                                        ni.spell.valid(X, J.Cyclone, false, true, true)
                                 then
                                    ni.spell.cast(J.Cyclone, X)
                                    return true
                                end
                            end
                        end
                        if S == nil then
                            return false
                        end
                        if S == 1 and GetRaidTargetIndex(X) == 1 then
                            if
                                not ni.unit.debuff(X, J.Cyclone, "player") and
                                    ni.drtracker.get(X, "Cyclone") >= 0.5 and
                                    ni.spell.valid(X, J.Cyclone, false, true, true)
                             then
                                ni.spell.cast(J.Cyclone, X)
                                return true
                            end
                        end
                        if S == 2 and GetRaidTargetIndex(X) == 2 then
                            if
                                not ni.unit.debuff(X, J.Cyclone, "player") and
                                    ni.drtracker.get(X, "Cyclone") >= 0.5 and
                                    ni.spell.valid(X, J.Cyclone, false, true, true)
                             then
                                ni.spell.cast(J.Cyclone, X)
                                return false
                            end
                        end
                        if S == 3 and GetRaidTargetIndex(X) == 3 then
                            if
                                not ni.unit.debuff(X, J.Cyclone, "player") and
                                    ni.drtracker.get(X, "Cyclone") >= 0.5 and
                                    ni.spell.valid(X, J.Cyclone, false, true, true)
                             then
                                ni.spell.cast(J.Cyclone, X)
                                return false
                            end
                        end
                        if S == 4 and GetRaidTargetIndex(X) == 4 then
                            if
                                not ni.unit.debuff(X, J.Cyclone, "player") and
                                    ni.drtracker.get(X, "Cyclone") >= 0.5 and
                                    ni.spell.valid(X, J.Cyclone, false, true, true)
                             then
                                ni.spell.cast(J.Cyclone, X)
                                return false
                            end
                        end
                        if S == 5 and GetRaidTargetIndex(X) == 5 then
                            if
                                not ni.unit.debuff(X, J.Cyclone, "player") and
                                    ni.drtracker.get(X, "Cyclone") >= 0.5 and
                                    ni.spell.valid(X, J.Cyclone, false, true, true)
                             then
                                ni.spell.cast(J.Cyclone, X)
                                return false
                            end
                        end
                        if S == 6 and GetRaidTargetIndex(X) == 6 then
                            if
                                not ni.unit.debuff(X, J.Cyclone, "player") and
                                    ni.drtracker.get(X, "Cyclone") >= 0.5 and
                                    ni.spell.valid(X, J.Cyclone, false, true, true)
                             then
                                ni.spell.cast(J.Cyclone, X)
                                return false
                            end
                        end
                        if S == 7 and GetRaidTargetIndex(X) == 7 then
                            if
                                not ni.unit.debuff(X, J.Cyclone, "player") and
                                    ni.drtracker.get(X, "Cyclone") >= 0.5 and
                                    ni.spell.valid(X, J.Cyclone, false, true, true)
                             then
                                ni.spell.cast(J.Cyclone, X)
                                return false
                            end
                        end
                        if S == 8 and GetRaidTargetIndex(X) == 8 then
                            if
                                not ni.unit.debuff(X, J.Cyclone, "player") and
                                    ni.drtracker.get(X, "Cyclone") >= 0.5 and
                                    ni.spell.valid(X, J.Cyclone, false, true, true)
                             then
                                ni.spell.cast(J.Cyclone, X)
                                return false
                            end
                        end
                    end
                end
            end
        end,
        ["Innervate"] = function()
            local Z = x("InnervateMp")
            local S = x("Innervatevalue")
            if S == 0 then
                return false
            end
            if b.spellusablesilence(J.Inner) then
                if Z == 1 then
                    if
                        ni.power.current("focus", 0) <= S and not ni.unit.buff("focus", J.Inner) and
                            ni.spell.valid("focus", J.Inner, false, true, true)
                     then
                        ni.spell.cast(J.Inner, "focus")
                        return true
                    end
                end
                if Z == 2 then
                    if ni.player.power(0) <= S and not ni.player.buff(J.Inner) then
                        ni.spell.cast(J.Inner)
                        return true
                    end
                end
                if Z == 3 then
                    for T = 1, #ni.members do
                        local _ = ni.members[T].guid
                        if ni.unit.hasheal(_) then
                            if
                                ni.power.current(_, 0) <= S and not ni.unit.buff(_.unit, J.Inner) and
                                    ni.spell.valid(_, J.Inner, false, true, true)
                             then
                                ni.spell.cast(J.Inner, _)
                                return true
                            end
                        end
                    end
                end
            end
        end,
        ["Barskin"] = function()
            local S, R = x("Barskin")
            if R then
                if
                    ni.player.hp() <= S and not ni.player.buff(30843) and
                        ni.spell.available(J.Barskin)
                 then
                    ni.spell.cast(J.Barskin)
                    return true
                end
            end
        end,
        ["Heal Potions (Use)"] = function()
            local S, R = x("healpotionuse")
            local a0 = {43569, 41166, 40087, 39671, 33934, 33447, 28100, 22829, 13446, 4596, 3928, 1710, 929, 858, 118}
            if R and ni.player.hp() < S and not K.Controled and K.InCombat then
                for T = 1, #a0 do
                    local a1 = a0[T]
                    if ni.player.hasitem(a1) and IsUsableItem(a1) and ni.player.itemcd(a1) == 0 then
                        ni.player.useitem(a1)
                        return true
                    end
                end
            end
        end,
        ["Healthstone (Use)"] = function()
            local S, R = x("healthstoneuse")
            local a2 = {
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
            if R and ni.player.hp() < S and not K.Controled and K.InCombat then
                for T = 1, #a2 do
                    local a1 = a2[T]
                    if ni.player.hasitem(a1) and IsUsableItem(a1) and ni.player.itemcd(a1) == 0 then
                        ni.player.useitem(a1)
                        return true
                    end
                end
            end
        end,
        ["Mana Potions (Use)"] = function()
            local S, R = x("manapotionuse")
            local a3 = {43570, 42545, 40087, 40067, 33935, 33448, 28101, 22832, 13444, 13443, 6149, 3827, 3385, 2455}
            if R and ni.player.power(0) < S and not K.Controled and K.InCombat then
                for T = 1, #a3 do
                    local a1 = a3[T]
                    if ni.player.hasitem(a1) and IsUsableItem(a1) and ni.player.itemcd(a1) == 0 then
                        ni.player.useitem(a1)
                        return true
                    end
                end
            end
        end,
        ["Trinkets"] = function()
            local Q, R = x("Trinkets")
            local S = x("trinket")
            if R and not K.Controled then
                if ni.members.averageof(3) <= S then
                    if
                        ni.player.slotcastable(13) and ni.player.slotcd(13) == 0 and
                            ni.spell.valid(ni.members[1].unit, J.Regrowtn, false, true, true)
                     then
                        ni.player.useinventoryitem(13)
                        return true
                    end
                    if
                        ni.player.slotcastable(14) and ni.player.slotcd(14) == 0 and
                            ni.spell.valid(ni.members[1].unit, J.Regrowtn, false, true, true)
                     then
                        ni.player.useinventoryitem(14)
                        return true
                    end
                end
            end
        end,
        ["Regrowtn"] = function()
            local S, R = x("RegrowtnParty")
            local a4 = ni.members.average("player", 20)
            local a5 = x("Nourish")
            local s = ni.members[1]
            if R then
                if b.spellusablesilence(J.Regrowtn) then
                    if
                        s:hp() <= S and a4 <= 40 and not K.Moved and not ni.unit.debuff(s.unit, 30843) and
                            not s:buff(J.Regrowtn) and
                            s:valid(s, J.Regrowtn, false, true)
                     then
                        ni.spell.cast(J.Regrowtn, s.unit)
                        return true
                    end
                end
            end
        end,
        ["Tranquility"] = function()
            local S = x("TranquilityHp")
            local a6, R = x("TranquilityMembers")
            local a7 = ni.members.inrangebelow("player", 13, S)
            if R then
                if #a7 >= a6 and not K.Moved and b.spellusablesilence(J.Tranquility) then
                    ni.spell.cast(J.Tranquility)
                    return true
                end
            end
        end,
        ["NaturesSwiftness"] = function()
            local S, R = x("NaturesSwiftness")
            local s = ni.members[1]
            if R then
                if
                    b.spellusablesilence(J.HealingTouch) and s:hp() <= S and s:valid(J.HealingTouch, false, true) and
                        b.spellusablesilence(J.NaturesSwiftness)
                 then
                    ni.spell.cast(J.NaturesSwiftness)
                    ni.spell.cast(J.HealingTouch, s.unit)
                    return true
                end
            end
        end,
        ["Swiftmend"] = function()
            local S, R = x("Swiftmend")
            if R then
                for T = 1, #ni.members do
                    local s = ni.members[T]
                    if
                        s:hp() <= S and not K.Controled and ni.spell.available(J.Swiftmend) and
                            not ni.unit.debuff(s.unit, 30843) and
                            s:buff(J.Rejuvenation, "player") and
                            s:valid(J.Swiftmend, false, true)
                     then
                        ni.spell.cast(J.Swiftmend, s.unit)
                        return true
                    end
                end
            end
        end,
        ["Rejuvenation"] = function()
            local S, R = x("Rejuvenation")
            for T = 1, #ni.members do
                local s = ni.members[T]
                if s:hp() <= S then
                    if R then
                        if b.spellusablesilence(J.Rejuvenation) then
                            if
                                not ni.vars.combat.aoe and not s:debuff(30843) and not s:buff(J.Rejuvenation) and
                                    s:valid(J.Rejuvenation, false, true)
                             then
                                ni.spell.cast(J.Rejuvenation, s.unit)
                                return true
                            end
                        end
                        if ni.vars.combat.aoe then
                            if
                                not s:buff(J.Rejuvenation) and not s:debuff(30843) and
                                    s:valid(J.Rejuvenation, false, true)
                             then
                                ni.spell.cast(J.Rejuvenation, s.unit)
                                return true
                            else
                                if s:buff(70308) and not s:buff(J.Rejuvenation) and s:valid(J.Rejuvenation, false, true) then
                                    ni.spell.cast(J.Rejuvenation, s.unit)
                                    return true
                                end
                            end
                        end
                    end
                end
            end
        end,
        ["Xoting"] = function()
            local Q, R = x("Xoting")
            if
                R and ni.spell.available(J.Rejuvenation) and b.spellusablesilence(J.Rejuvenation) and
                    UnitAffectingCombat("player") == nil
             then
                for T = 1, #ni.members do
                    local s = ni.members[T]
                    if
                        s:hp() <= 100 and not UnitIsDeadOrGhost(s.unit) and not s:buff(J.Rejuvenation, "player") and
                            s:valid(J.Rejuvenation, false, true, true)
                     then
                        ni.spell.cast(J.Rejuvenation, s.unit)
                        return true
                    end
                end
            end
        end,
        ["Nourish"] = function()
            local S, R = x("Nourish")
            if R then
                for T = 1, #ni.members do
                    local s = ni.members[T]
                    if
                        s:hp() <= S and not K.Moved and b.spellusablesilence(J.Nourish) and
                            (s:buff(J.Rejuvenation, "player") or s:buff(J.Regrowtn, "player") or
                                s:buff(J.LifeBloom, "player") and not ni.unit.debuff(s.unit, 30843) or
                                s:buff(J.WildGrowth, "player")) and
                            s:valid(J.Nourish, false, true)
                     then
                        ni.spell.cast(J.Nourish, s.unit)
                        return true
                    end
                end
            end
        end,
        ["RemoveCurse"] = function()
            local Q, R = x("RemoveCurse")
            local a8 = x("DispelDelay")
            if R then
                if b.spellusablesilence(J.RemoveCurse) then
                    for T = 1, #ni.members.sort() do
                        local s = ni.members[T]
                        if s:debufftype("Curse") and s:dispel() and s:valid(J.RemoveCurse, false, true) then
                            ni.spell.delaycast(J.RemoveCurse, s.unit, a8)
                            return true
                        end
                    end
                end
            end
        end,
        ["CurePoison"] = function()
            local Q, R = x("CurePoison")
            local a8 = x("DispelDelay")
            if R then
                if b.spellusablesilence(J.CurePoison) then
                    for T = 1, #ni.members.sort() do
                        local s = ni.members[T]
                        if
                            s:debufftype("Poison") and s:dispel() and not s:aura(J.CurePoison) and
                                s:valid(J.CurePoison, false, true)
                         then
                            ni.spell.delaycast(J.CurePoison, s.unit, a8)
                            return true
                        end
                    end
                end
            end
        end,
        ["WildGrowth"] = function()
            local S = x("WildGrowthHp")
            local a9, R = x("WildGrowthMembers")
            if R then
                for T = 1, #ni.members do
                    local s = ni.members[1]
                    local a6 = ni.members.inrangebelow(s.unit, 15, S)
                    if
                        #a6 >= a9 and b.spellusablesilence(J.WildGrowth) and not ni.unit.debuff(s.unit, 30843) and
                            not s:buff(J.WildGrowth) and
                            s:valid(J.WildGrowth, false, true)
                     then
                        ni.spell.cast(J.WildGrowth, s.unit)
                        return true
                    end
                end
            end
        end,
        ["Rassovie"] = function()
            local Q, R = x("Prozimki")
            if not R then
                return false
            end
            local aa = {33697, 20572, 33702, 26297}
            local ab = {20594, 28880}
            if ni.unit.isfleeing("player") and D(7744) and ni.spell.available(7744) then
                ni.spell.cast(7744)
                return true
            end
            for T = 1, #aa do
                local ac = aa[T]
                if
                    (ni.vars.combat.cd or ni.unit.isboss("target")) and D(ac) and
                        ni.spell.available(ac) and
                        ni.spell.valid("target", 49238, true, true)
                 then
                    ni.spell.cast(ac)
                    return true
                end
            end
            for T = 1, #ab do
                local ad = ab[T]
                if
                    ni.spell.valid("target", 49238, true, true) and ni.player.hp() < 20 and D(ad) and
                        ni.spell.available(ad)
                 then
                    ni.spell.cast(ad)
                    return true
                end
                if
                    ni.player.slotcastable(10) and ni.player.slotcd(10) == 0 and
                        (ni.vars.combat.cd or ni.unit.isboss("target"))
                 then
                    ni.player.useinventoryitem(10)
                    return true
                end
            end
        end,
        ["LifeBloom"] = function()
            local S = x("Lifebloom")
            local a5 = x("Nourish")
            local ae, af = a()
            if S == 0 then
                return false
            end
            if b.spellusablesilence(J.LifeBloom) then
                if S == 1 or S == 2 then
                    if
                        ae ~= nil and ni.unit.buffstacks(ae.unit, J.LifeBloom, "player") < 3 and
                            ni.spell.valid(ae.unit, J.LifeBloom, false, true, true)
                     then
                        ni.spell.cast(J.LifeBloom, ae.unit)
                        return true
                    end
                end
                if S == 1 or S == 3 then
                    if
                        af ~= nil and ni.unit.buffstacks(af.unit, J.LifeBloom, "player") < 3 and
                            ni.spell.valid(af.unit, J.LifeBloom, false, true, true)
                     then
                        ni.spell.cast(J.LifeBloom, af.unit)
                        return true
                    end
                end
                if S == 4 then
                    if
                        ae ~= nil and ni.player.buff(16870) and ni.members.average() >= a5 and
                            ni.unit.buffstacks(ae.unit, J.LifeBloom, "player") < 3 and
                            ni.spell.valid(ae.unit, J.LifeBloom, false, true, true)
                     then
                        ni.spell.cast(J.LifeBloom, ae.unit)
                        return true
                    end
                    if
                        af ~= nil and ni.player.buff(16870) and ni.members.average() >= a5 and
                            ni.unit.buffstacks(af.unit, J.LifeBloom, "player") < 3 and
                            ni.spell.valid(af.unit, J.LifeBloom, false, true, true)
                     then
                        ni.spell.cast(J.LifeBloom, af.unit)
                        return true
                    end
                end
            end
        end,
        ["Regrowtn(Tank)"] = function()
            local S = x("Regrowtn")
            local a5 = x("Regrowtn(Hp)")
            local V, W = a()
            if S == 0 then
                return false
            end
            if b.spellusablesilence(J.Regrowtn) and not K.Moved then
                if S == 1 or S == 2 then
                    if V then
                        if
                            UnitExists(V.unit) and not ni.unit.buff(V.unit, J.Regrowtn, "player") and
                                ni.unit.hp(V.unit) <= a5 and
                                ni.spell.valid(V.unit, J.Regrowtn, false, true, true)
                         then
                            ni.spell.cast(J.Regrowtn, V.unit)
                            return true
                        end
                    end
                    if S == 1 or S == 3 then
                        if W then
                            if
                                UnitExists(W.unit) and not ni.unit.buff(W.unit, J.Regrowtn, "player") and
                                    ni.unit.hp(W.unit) <= a5 and
                                    ni.spell.valid(W.unit, J.Regrowtn, false, true, true)
                             then
                                ni.spell.cast(J.Regrowtn, W.unit)
                                return true
                            end
                        end
                    end
                end
            end
        end,
        ["Rerow"] = function()
            local S = x("Regrowtn")
            local a5 = x("Regrowtn(Hp)")
            if S == 0 then
                return false
            end
            if b.spellusablesilence(J.Regrowtn) and not K.Moved then
                if S == 4 then
                    if
                        not ni.unit.buff("focus", J.Regrowtn, "player") and ni.unit.hp("focus") <= a5 and
                            ni.spell.valid("focus", J.Regrowtn, false, true, true)
                     then
                        ni.spell.cast(J.Regrowtn, "focus")
                        return true
                    end
                end
                if S == 5 then
                    if
                        not ni.player.buff(J.Regrowtn) and ni.player.hp() <= a5 and
                            ni.spell.valid("player", J.Regrowtn, false, true, true)
                     then
                        ni.spell.cast(J.Regrowtn, "player")
                        return true
                    end
                end
            end
        end
    }
    ni.bootstrap.profile("Rdru", L, P, H, I)
else
    local L = {"Error"}
    local P = {["Error"] = function()
            ni.vars.profiles.enabled = false
            if c > 30300 then
                ni.frames.floatingtext:message("This profile is meant for WotLK 3.3.5a! Sorry!")
            elseif level < 80 then
                ni.frames.floatingtext:message("This profile is meant for level 80! Sorry!")
            end
        end}
    ni.bootstrap.profile("Rdru", L, P)
end
