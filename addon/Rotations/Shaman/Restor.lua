local a, b = select(4, GetBuildInfo()), false
local c = UnitLevel("player")
local d = {}
if a == 30300 and c >= 80 then
    local function e(f, g, h)
        return "\124T" ..
            (select(3, GetSpellInfo(f)) or select(3, GetSpellInfo(24720))) ..
                ":" .. (h or 25) .. ":" .. (g or 25) .. "\124t"
    end
    local function i(j, g, h)
        return "\124T" ..
            (GetItemIcon(j) or select(3, GetSpellInfo(24720))) .. ":" .. (h or 25) .. ":" .. (g or 25) .. "\124t"
    end
    local k = {
        settingsfile = "RestorationShaman.js",
        {type = "title", text = "    Шаман Исцеление by |c0010CED1WH   "},
        {type = "separator"},
        {type = "title", text = "|cffFFFF00Главные  настройки"},
        {type = "separator"},
        {
            type = "entry",
            text = ni.spell.icon(57994) .. " Пронизывающий ветер",
            tooltip = "Автоматическое определение и [Прерывание]\nвсех прирываемых заклинаний.",
            enabled = false,
            key = "WindShearInterrupt"
        },
        {type = "separator"},
        {type = "page", number = 1, text = "|cff95f900Важные Заклинания"},
        {type = "separator"},
        {type = "title", text = "|cFFF5DEB3Тотемы|r"},
        {
            type = "dropdown",
            menu = {
                {selected = false, value = 1, text = ni.spell.icon(66842) .. " Зов стихий"},
                {selected = false, value = 2, text = ni.spell.icon(66843) .. " Зов предков"},
                {selected = false, value = 3, text = ni.spell.icon(66844) .. " Зов духов"},
                {selected = false, value = 0, text = "|cffFF0303Ручной режим|r"}
            },
            key = "totem"
        },
        {
            type = "entry",
            text = e(36936) .. "Возвращение тотемов",
            tooltip = "Автоматически убирает  и ставит тотемы во время боя и после боя(Включать только на боссах!!)",
            enabled = true,
            key = "Vozvrat"
        },
        {type = "separator"},
        {type = "title", text = ni.spell.icon(107) .. "|cFFFF4500Щит на себя|r"},
        {
            type = "dropdown",
            menu = {
                {selected = false, value = 1, text = ni.spell.icon(57960) .. "Водный щит"},
                {selected = false, value = 2, text = ni.spell.icon(49284) .. "Щит змели"},
                {selected = false, value = 0, text = "|cffFF0303Без щита|r"}
            },
            key = "Shield"
        },
        {type = "separator"},
        {type = "title", text = ni.spell.icon(49284) .. "|cFFFF4500Орехи|r"},
        {
            type = "dropdown",
            menu = {
                {selected = true, value = 1, text = ni.spell.icon(49284) .. "На МТ"},
                {selected = false, value = 2, text = ni.spell.icon(49284) .. "На ОТ"},
                {selected = false, value = 3, text = "|cffFF0303По фокусу|r"},
                {selected = false, value = 0, text = "|cffFF0303Ручной режим|r"}
            },
            key = "tankXIL"
        },
        {
            type = "entry",
            text = ni.spell.icon(51514) .. " Авто контроль (Союзн.)",
            tooltip = "Автоматически контролирует союзников, которые попали под контроль.",
            enabled = true,
            key = "control"
        },
        {type = "page", number = 2, text = "|cff00C957Важные настройки"},
        {type = "separator"},
        {
            type = "entry",
            text = ni.spell.icon(49233) .. " Огненный шок",
            tooltip = "Использовать заклинание, когда |cff0082FFMP|r персонажа > % \nи.",
            enabled = true,
            value = 70,
            min = 15,
            max = 100,
            step = 1,
            width = 40,
            key = "flame"
        },
        {
            type = "entry",
            text = ni.spell.icon(16188) .. " Природная стремительность",
            tooltip = "Моментальное исцеление союзника по |cff00D700HP|r < %",
            enabled = true,
            value = 40,
            min = 15,
            max = 75,
            step = 1,
            width = 40,
            key = "natureswift"
        },
        {
            type = "entry",
            text = ni.spell.icon(55198) .. " Сила прилива",
            tooltip = "Использовать заклинание для увеличение исцеления.\n\nЗаклинание будет использовано когда среднее |cff00D700HP|r\nуказаного количества союзников будет < %.",
            enabled = true,
            key = "tidal"
        },
        {
            type = "entry",
            text = "HP союзников",
            tooltip = "Настройка среднего значения |cff00D700HP|r < % союзников.",
            value = 37,
            min = 25,
            max = 100,
            step = 1,
            width = 40,
            key = "tidalhp"
        },
        {
            type = "entry",
            text = "Количество союзников",
            tooltip = "Настройка количества союзников в Группе/Рейде.",
            value = 4,
            min = 2,
            max = 20,
            step = 1,
            width = 40,
            key = "tidalcount"
        },
        {
            type = "entry",
            text = ni.spell.icon(16190) .. "Тотем прилива манны",
            tooltip = "Ставим тотем восполенения манны когда прист кастует гимн |cff0082FFMP|r < % у персонажа < %",
            enabled = true,
            value = 40,
            min = 15,
            max = 90,
            step = 1,
            width = 40,
            key = "Manna"
        },
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
            text = i(54589) .. " Тринькеты",
            tooltip = "Использование тринькетов(13 и 14 слот) |cff00D700HP|r < %",
            value = 50,
            min = 15,
            max = 100,
            step = 1,
            width = 40,
            key = "trinket"
        },
        {type = "separator"},
        {type = "title", text = "Рассеивание"},
        {type = "separator"},
        {
            type = "entry",
            text = ni.spell.icon(8012) .. "Развеивание магии",
            tooltip = "Включение заклинания в ротацию.",
            enabled = true,
            key = "purge"
        },
        {type = "separator"},
        {
            type = "entry",
            text = "Задержка для рассеивание",
            tooltip = "Задержка в секундах или милисекундах перед применением заклинаний.",
            value = 1.5,
            min = 0.1,
            max = 5,
            step = 0.1,
            width = 40,
            key = "DispelDelay"
        },
        {
            type = "entry",
            text = ni.spell.icon(51886) .. " Очищение духов (Союзн.) ",
            tooltip = "Автоматически рассеивает вредоносные эффекты с союзников.",
            enabled = true,
            key = "spiritmemb"
        },
        {type = "page", number = 3, text = "|cff95f900Настройки исцеления Группы/Рейда|r"},
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
            text = ni.spell.icon(61301) .. "Быстрина",
            tooltip = "Юзает быстрина по |cff00D700HP|r < %",
            enabled = true,
            value = 70,
            min = 15,
            max = 100,
            step = 1,
            width = 40,
            key = "Bistrina"
        },
        {
            type = "entry",
            text = ni.spell.icon(49273) .. "Волна исцеления",
            tooltip = "Хилит соло таргет по |cff00D700HP|r < %",
            enabled = true,
            value = 70,
            min = 15,
            max = 100,
            step = 1,
            width = 40,
            key = "healingwave"
        },
        {
            type = "entry",
            text = ni.spell.icon(55459) .. "Цепное исцеление",
            tooltip = "Кидает аое хил по |cff00D700HP|r < %",
            enabled = true,
            value = 70,
            min = 15,
            max = 100,
            step = 1,
            width = 40,
            key = "Cepuxa"
        },
        {
            type = "entry",
            text = "Кол-во раненых",
            tooltip = "Использовать Цепное исцеление когда, количество раненых союзников",
            value = 4,
            min = 1,
            max = 4,
            step = 1,
            width = 40,
            key = "Cepuxamembers"
        },
        {type = "page", number = 4, text = "|cFFFA8072Зелья + сейвы|r"},
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
        {type = "separator"}
    }
    local function l(m)
        for n, o in ipairs(k) do
            if o.type == "entry" and o.key ~= nil and o.key == m then
                return o.value, o.enabled
            end
            if o.type == "dropdown" and o.key ~= nil and o.key == m then
                for p, q in pairs(o.menu) do
                    if q.selected then
                        return q.value
                    end
                end
            end
            if o.type == "input" and o.key ~= nil and o.key == m then
                return o.value
            end
        end
    end
    local function r()
        ni.GUI.AddFrame("Restor", k)
    end
    local function s()
        ni.GUI.DestroyFrame("Restor")
    end
    local function t(u, v)
        v = true and v or false
        if tonumber(u) == nil then
            u = ni.spell.id(u)
        end
        local w = false
        if u == nil or u == 0 then
            return false
        end
        if IsSpellKnown(u, v) then
            local m = GetSpellInfo(u)
            if m then
                w = true
            end
        end
        return w
    end
    local function x(u, y)
        if tonumber(u) == nil then
            u = ni.spell.id(u)
        end
        local w = false
        if u == nil or u == 0 then
            return false
        end
        local z = GetSpellInfo(u)
        if not ni.player.isstunned() and not ni.player.issilenced() and ni.spell.available(u, y) and IsUsableSpell(z) then
            w = true
        end
        return w
    end
    local A = {38210, 48068, 48066, 61301, 43039, 43020, 48441, 11841, 43046, 18100}
    local function B(C)
        for D = 1, #A do
            local E = A[D]
            local F = select(8, ni.unit.buff(C, E))
            if F then
                return true
            end
        end
        return false
    end
    local G = {
        PlayerIsMoving = false,
        InCombat = false,
        GlyphChain = false,
        Controled = false,
        KnowCleanseSpirit = false
    }
    local f = {
        WindShear = GetSpellInfo(57994),
        LightningBolt = GetSpellInfo(49238),
        FlameShock = GetSpellInfo(49233),
        EarthlivingWeapon = GetSpellInfo(51994),
        WaterShield = GetSpellInfo(57960),
        LightningShield = GetSpellInfo(49281),
        EarthShield = GetSpellInfo(49284),
        HealingWave = GetSpellInfo(49273),
        LesserHealingWave = GetSpellInfo(49276),
        ChainHeal = GetSpellInfo(55459),
        Riptide = GetSpellInfo(61301),
        TotemicRecall = GetSpellInfo(36936),
        FireElementalTotem = GetSpellInfo(2894),
        NaturesSwiftness = GetSpellInfo(16188),
        TidalForce = GetSpellInfo(55198),
        CleanseSpirit = GetSpellInfo(51886),
        CureToxins = GetSpellInfo(526),
        Purge = GetSpellInfo(8012),
        Hex = GetSpellInfo(51514),
        ChainLightning = GetSpellInfo(49271),
        LavaBurst = GetSpellInfo(60043),
        GhostWolf = GetSpellInfo(2645),
        Manna = GetSpellInfo(16190),
        TidalWaves = GetSpellInfo(53390)
    }
    local H = {
        "Cache",
        "Universal Pause",
        "text",
        "Enchant Weapon",
        "Shield",
        "totem",
        "Manna",
        "Vozvrat",
        "Non Combat Healing",
        "Combat specific Pause",
        "Rassovie",
        "Wind Shear (Interrupt)",
        "Trinkets",
        "Tidal Force",
        "Nature's Swiftness",
        "Tank Heal",
        "Bistrina",
        "Cepuxa",
        "Cepuxa (AoE)",
        "Healing Wave",
        "Flame Shock",
        "Control (Member)",
        "Cleanse Spirit (Member)",
        "Purge"
    }
    local I, J = 0, 0
    local K, L, d = {}, {}, {}
    local M, N, O, P = f.CleanseSpirit, "Poison|Disease|Curse", 0, 0
    local Q = {
        ["Cache"] = function()
            if GetTime() - J > 100 then
                ni.utils.resetlasthardwareaction()
                J = GetTime()
            end
            G.InCombat = UnitAffectingCombat("player") or false
            G.PlayerIsMoving = ni.player.ismoving() or false
            G.GlyphChain = ni.player.hasglyph(55437) or false
            G.Controled =
                ni.player.issilenced() or ni.player.isstunned() or ni.player.isconfused() or ni.player.isfleeing() or
                false
            G.KnowCleanseSpirit = t(f.CleanseSpirit) or false
            if G.KnowCleanseSpirit then
                M = f.CleanseSpirit
                Type = "Disease|Poison|Curse"
            else
                M = f.CureToxins
                Type = "Disease|Poison"
            end
            if G.InCombat and GetTime() - I >= 15 then
                wipe(K)
                wipe(L)
                wipe(d)
                I = GetTime()
            end
            ni.vars.debug = select(2, l("Debug"))
        end,
        ["Universal Pause"] = function()
            if
                IsMounted() or UnitInVehicle("player") or UnitIsDeadOrGhost("player") or UnitChannelInfo("player") or
                    UnitCastingInfo("player") or
                    ni.vars.combat.casting == true or
                    ni.player.buff(GetSpellInfo(430)) or
                    ni.player.buff(GetSpellInfo(433))
             then
                return true
            end
        end,
        ["text"] = function()
            if not b then
                ni.frames.floatingtext:message("Restr PvE FFp Bg")
                print("|cffEE4000=======================================|r")
                print("|cffFFFF00Restor Shaman by WhoamiWoW|r")
                print("|cff00C957v0.0.1 release|r")
                print("https://discord.gg/6wCgVRhQFs  ----- Wh Project")
                print("• Нажать кнопку АоЕ для переключения режимов")
                print("|cffEE4000=======================================|r")
                b = true
            end
        end,
        ["Enchant Weapon"] = function()
            if GetInventoryItemID("player", 16) ~= nil then
                local R = GetWeaponEnchantInfo()
                if not R and x(f.EarthlivingWeapon) then
                    ni.spell.cast(f.EarthlivingWeapon)
                    BindEnchant()
                    return true
                end
            end
        end,
        ["totem"] = function()
            local S = l("totem")
            local T = select(2, GetTotemInfo(2))
            local U = select(2, GetTotemInfo(1))
            local V = select(2, GetTotemInfo(3))
            local W = select(2, GetTotemInfo(4))
            if G.InCombat then
                if S == 1 then
                    x(66842)
                    if T == "" and U == "" and V == "" and W == "" then
                        ni.spell.cast(66842)
                        ni.debug.print("ставим - " .. GetSpellLink(66842))
                        return true
                    end
                end
                if S == 2 then
                    x(66843)
                    if T == "" and U == "" and V == "" and W == "" then
                        ni.spell.cast(66843)
                        ni.debug.print("ставим - " .. GetSpellLink(66843))
                        return true
                    end
                end
                if S == 3 then
                    x(66844)
                    if T == "" and U == "" and V == "" and W == "" then
                        ni.spell.cast(66844)
                        ni.debug.print("ставим - " .. GetSpellLink(66844))
                        return true
                    end
                end
            end
        end,
        ["Vozvrat"] = function()
            local X, Y = l("Vozvrat")
            if not Y then
                return false
            end
            local T = select(2, GetTotemInfo(2))
            local U = select(2, GetTotemInfo(1))
            local V = select(2, GetTotemInfo(3))
            local W = select(2, GetTotemInfo(4))
            if T == "" and U == "" and V == "" and W == "" then
                return false
            end
            if not G.InCombat and (T ~= "" or U ~= "" or V ~= "" or W ~= "") then
                ni.spell.cast(36936)
                ni.debug.print("УБИРАЕМ ВСЕ ТОТЕМЫ " .. GetSpellLink(36936))
                return true
            end
        end,
        ["Shield"] = function()
            local S, Y = l("Shield")
            if not Y then
                if S == 0 then
                    return false
                end
                if S == 1 then
                    if not ni.player.buff(f.WaterShield) and x(f.WaterShield) then
                        ni.spell.cast(f.WaterShield)
                        return true
                    end
                end
                if S == 2 then
                    if not ni.player.buff(f.EarthShield) and x(f.EarthShield) then
                        ni.spell.cast(f.EarthShield)
                        return true
                    end
                end
            end
        end,
        ["Non Combat Healing"] = function()
            local S, Y = l("noncombatheal")
            if not Y or UnitAffectingCombat("player") then
                return false
            end
            if x(f.Riptide) and x(f.HealingWave) then
                for D = 1, #ni.members do
                    local K = ni.members[1]
                    if K:hp() <= S and K:valid(f.Riptide, false, true) then
                        if not ni.unit.buff(K.unit, f.Riptide, "player") then
                            ni.spell.cast(f.Riptide, K.unit)
                            return true
                        end
                        if not G.PlayerIsMoving then
                            ni.spell.cast(f.HealingWave, K.unit)
                            return true
                        end
                    end
                end
            end
        end,
        ["Combat specific Pause"] = function()
            if UnitAffectingCombat("player") then
                return false
            end
            for D = 1, #ni.members do
                if UnitAffectingCombat(ni.members[D].unit) then
                    return false
                end
            end
            return true
        end,
        ["Rassovie"] = function()
            local X, Y = l("Prozimki")
            if not Y then
                return false
            end
            local Z = {33697, 20572, 33702, 26297}
            local _ = {20594, 28880}
            if ni.unit.isfleeing("player") and t(7744) and ni.spell.available(7744) then
                ni.spell.cast(7744)
                return true
            end
            for D = 1, #Z do
                local a0 = Z[D]
                if
                    (ni.vars.combat.cd or ni.unit.isboss("target")) and t(a0) and ni.spell.available(a0) and
                        ni.spell.valid("target", 49238, true, true)
                 then
                    ni.spell.cast(a0)
                    return true
                end
            end
            for D = 1, #_ do
                local a1 = _[D]
                if
                    ni.spell.valid("target", 49238, true, true) and ni.player.hp() < 20 and t(a1) and
                        ni.spell.available(a1)
                 then
                    ni.spell.cast(a1)
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
        ["Wind Shear (Interrupt)"] = function()
            local X, Y = l("WindShearInterrupt")
            if not Y then
                return false
            end
            if x(f.WindShear) then
                local a2 = select(9, GetSpellInfo(f.WindShear))
                local d = ni.player.enemiesinrange(a2)
                for D = 1, #d do
                    local a3 = d[D].guid
                    if ni.spell.shouldinterrupt(a3) and ni.spell.valid(a3, f.WindShear, true, true) then
                        ni.spell.cast(f.WindShear, a3)
                        return true
                    end
                end
            end
        end,
        ["Tank Heal"] = function()
            local a4 = l("tankXIL")
            local a5, a6 = ni.tanks()
            if x(f.EarthShield) then
                if a4 == 0 then
                    return false
                end
                if a4 == 2 then
                    if a5 then
                        if UnitExists(a5.unit) then
                            if ni.spell.valid(a5.unit, f.EarthShield, false, true, true) then
                                if not ni.unit.buff(a5.unit, f.EarthShield, "player") then
                                    ni.spell.cast(f.EarthShield, a5.unit)
                                    return true
                                end
                            end
                        end
                    end
                    if a4 == 1 then
                        if a6 then
                            if UnitExists(a6.unit) then
                                if ni.spell.valid(a6.unit, f.EarthShield, false, true, true) then
                                    if not ni.unit.buff(a6.unit, f.EarthShield, "player") then
                                        ni.spell.cast(f.EarthShield, a6.unit)
                                        return true
                                    end
                                end
                            end
                        end
                        if a4 == 3 then
                            if ni.unit.exists("focus") then
                                if ni.spell.valid("focus", f.EarthShield, false, true, true) then
                                    if not ni.unit.buff("focus", f.EarthShield, "player") then
                                        ni.spell.cast(f.EarthShield, "focus")
                                        return true
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end,
        ["Trinkets"] = function()
            local X, Y = l("Trinkets")
            local S = l("trinket")
            if not Y or G.Controled then
                return false
            end
            if ni.members.averageof(3) <= S then
                if
                    ni.player.slotcastable(13) and ni.player.slotcd(13) == 0 and
                        ni.spell.valid(ni.members[1].unit, f.ChainHeal, false, true, true)
                 then
                    ni.player.useinventoryitem(13)
                    return true
                end
                if
                    ni.player.slotcastable(14) and ni.player.slotcd(14) == 0 and
                        ni.spell.valid(ni.members[1].unit, f.ChainHeal, false, true, true)
                 then
                    ni.player.useinventoryitem(14)
                    return true
                end
            end
            return false
        end,
        ["Tidal Force"] = function()
            local X, Y = l("tidal")
            if not Y then
                return false
            end
            local a7 = l("tidalhp")
            local a8 = l("tidalcount")
            if ni.members.below(a7) >= a8 and x(f.TidalForce) then
                ni.spell.cast(f.TidalForce)
                ni.debug.print("Сила преливов: " .. GetSpellLink(f.TidalForce) .. " на " .. UnitName(FirstMemb))
                return true
            end
        end,
        ["Nature's Swiftness"] = function()
            local S, Y = l("natureswift")
            if not Y then
                return false
            end
            if x(f.NaturesSwiftness) and x(f.HealingWave) then
                for D = 1, #ni.members do
                    local K = ni.members[1]
                    if K:hp() <= S and K:valid(f.HealingWave, false, true) then
                        ni.spell.cast(f.NaturesSwiftness)
                        ni.spell.cast(f.HealingWave, K.unit)
                        return true
                    end
                end
            end
        end,
        ["Bistrina"] = function()
            local S, Y = l("Bistrina")
            if not Y or not x(f.Riptide) then
                return false
            end
            for D = 1, #ni.members do
                local K = ni.members[D]
                if K:hp() <= S and K:valid(f.Riptide, false, true) then
                    ni.spell.cast(f.Riptide, K.unit)
                    return true
                end
            end
        end,
        ["Healing Wave"] = function()
            local S, Y = l("healingwave")
            if not Y or G.PlayerIsMoving or not x(f.HealingWave) then
                return false
            end
            for D = 1, #ni.members do
                local K = ni.members[D]
                if K:hp() <= S then
                    if ni.spell.available(f.HealingWave) and K:valid(f.HealingWave, false, true) then
                        ni.spell.cast(f.HealingWave, K.unit)
                        return true
                    end
                end
            end
        end,
        ["Cleanse Spirit (Member)"] = function()
            local X, Y = l("spiritmemb")
            local a9 = l("DispelDelay")
            if not Y then
                return false
            end
            if x(M) then
                for D = 1, #ni.members do
                    local K = ni.members[D]
                    if
                        K:debufftype("Poison|Disease|Curse") and ni.healing.candispel(K) and GetTime() - O > a9 and
                            K:valid(M, false, true)
                     then
                        ni.spell.cast(M, K)
                        O = GetTime()
                        return true
                    end
                end
            end
        end,
        ["Purge"] = function()
            local X, Y = l("purge")
            if not Y then
                return false
            end
            if B("target") and x(f.Purge) and GetTime() - P > 2.5 and ni.spell.valid("player", f.Purge, true, true) then
                ni.spell.cast(f.Purge, "target")
                P = GetTime()
                ni.debug.print("Диспелю : " .. GetSpellLink(f.Purge) .. " тебя " .. UnitName(target))
                return true
            end
        end,
        ["Cepuxa (AoE)"] = function()
            local S, Y = l("Cepuxa")
            if not Y or G.PlayerIsMoving or not x(f.ChainHeal) then
                return false
            end
            if ni.vars.combat.aoe then
                for D = 1, #ni.members do
                    local aa = ni.members[1]
                    if aa:hp() < S and aa:valid(f.ChainHeal, false, true) then
                        ni.spell.cast(f.ChainHeal, aa.unit)
                        return true
                    end
                end
            end
        end,
        ["Cepuxa"] = function()
            local S, Y = l("Cepuxa")
            local ab = l("Cepuxamembers")
            local ac = ni.members.inrangebelow("player", 15, S)
            if not Y or not ni.player.buff(f.TidalWaves) or G.PlayerIsMoving or not x(f.ChainHeal) then
                return false
            end
            if #ac >= ab then
                if not ni.vars.combat.aoe then
                    for D = 1, #ni.members do
                        local K = ni.members[D]
                        if K:hp() <= S and K:valid(f.ChainHeal, false, true) and K:buff(f.Riptide, "player") then
                            ni.spell.cast(f.ChainHeal, K.unit)
                            return true
                        end
                    end
                end
            end
        end,
        ["Flame Shock"] = function()
            local S, Y = l("flame")
            if not Y then
                return false
            end
            if
                ni.unit.debuffremaining("target", 49233, "player") < 2 and ni.player.power(0) > S and
                    ni.spell.available(49233) and
                    ni.spell.valid("target", 49233, true, true)
             then
                ni.spell.cast(49233, "target")
                return true
            end
        end,
        ["Heal Potions (Use)"] = function()
            local S, Y = l("healpotionuse")
            local ad = {43569, 41166, 40087, 39671, 33934, 33447, 28100, 22829, 13446, 4596, 3928, 1710, 929, 858, 118}
            if Y and ni.player.hp() < S and not cache.Controled and cache.InCombat then
                for D = 1, #ad do
                    local ae = ad[D]
                    if ni.player.hasitem(ae) and IsUsableItem(ae) and ni.player.itemcd(ae) == 0 then
                        ni.player.useitem(ae)
                        return true
                    end
                end
            end
        end,
        ["Healthstone (Use)"] = function()
            local S, Y = l("healthstoneuse")
            local af = {
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
            if Y and ni.player.hp() < S and not cache.Controled and cache.InCombat then
                for D = 1, #af do
                    local ag = af[D]
                    if ni.player.hasitem(ag) and IsUsableItem(ag) and ni.player.itemcd(ag) == 0 then
                        ni.player.useitem(ag)
                        return true
                    end
                end
            end
        end,
        ["Manna"] = function()
            local S, Y = l("Manna")
            if not Y then
                return false
            end
            if x(f.Manna) then
                if ni.player.buff(64904) and ni.player.power(0) <= S then
                    ni.spell.cast(f.Manna)
                    return true
                end
            end
        end,
        ["Mana Potions (Use)"] = function()
            local S, Y = l("manapotionuse")
            local ah = {43570, 42545, 40087, 40067, 33935, 33448, 28101, 22832, 13444, 13443, 6149, 3827, 3385, 2455}
            if Y and ni.player.power(0) < S and not cache.Controled and cache.InCombat then
                for D = 1, #ah do
                    local ai = ah[D]
                    if ni.player.hasitem(ai) and IsUsableItem(ai) and ni.player.itemcd(ai) == 0 then
                        ni.player.useitem(ai)
                        return true
                    end
                end
            end
        end,
        ["Control (Member)"] = function()
            local X, Y = l("control")
            if not Y or G.PlayerIsMoving then
                return false
            end
            if x(f.Hex) then
                for D = 1, #ni.members do
                    local K = ni.members[D]
                    if UnitIsEnemy("player", K.unit) and K:valid(f.Hex, false, true) then
                        ni.spell.cast(f.Hex, K.unit)
                        ni.debug.print("Превращаем: " .. GetSpellLink(f.Hex) .. " тебя! " .. UnitName(FirstMemb))
                        return true
                    end
                end
            end
        end
    }
    ni.bootstrap.profile("Restor", H, Q, r, s)
else
    local H = {"Error"}
    local Q = {["Error"] = function()
            ni.vars.profiles.enabled = false
            if a > 30300 then
                ni.frames.floatingtext:message("This profile is meant for WotLK 3.3.5a! Sorry!")
            elseif c < 80 then
                ni.frames.floatingtext:message("This profile is meant for level 80! Sorry!")
            end
        end}
    ni.bootstrap.profile("Restor", H, Q)
end
