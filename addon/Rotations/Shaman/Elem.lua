local a = ni.utils.require("Riot") or ni.utils.require("Riot.enc")
local b = false
local c = {}
local d = select(4, GetBuildInfo())
local e = UnitLevel("player")
local function f()
    table.wipe(c)
    c = ni.unit.enemiesinrange("target", 7)
    for g, h in ipairs(c) do
        if ni.player.threat(h.guid) == -1 then
            table.remove(c, g)
        end
    end
    return #c
end
if d == 30300 and a then
    local function i(j, k, l)
        return "\124T" ..
            (select(3, GetSpellInfo(j)) or select(3, GetSpellInfo(24720))) ..
                ":" .. (l or 25) .. ":" .. (k or 25) .. "\124t"
    end
    local function m(n, k, l)
        return "\124T" ..
            (GetItemIcon(n) or select(3, GetSpellInfo(24720))) .. ":" .. (l or 25) .. ":" .. (k or 25) .. "\124t"
    end
    local o, o, p = GetSpellInfo(59159)
    local o, o, q = GetSpellInfo(59159)
    local o, o, r = GetSpellInfo(59159)
    local o, o, s = GetSpellInfo(22908)
    hpotionIcon = "Interface\\Icons\\INV_Alchemy_Elixir_05"
    mpotionIcon = "Interface\\Icons\\INV_Alchemy_Elixir_02"
    trinket = "Interface\\Icons\\inv_relics_idolofferocity"
    bossIcon = "Interface\\Icons\\inv_misc_head_dragon_01"
    local t = {
        settingsfile = "Elem.js",
        {type = "title", text = "Шаман Элементаль by |c0010CED1WH"},
        {type = "separator"},
        {type = "title", text = "|cffFFFF00Основные настройки"},
        {type = "separator"},
        {
            type = "entry",
            text = "\124T" .. p .. ":24:24\124t Гром и молния (Манна реген)",
            tooltip = "Используйте заклинание, когда |cff0082FFMP|r < % у персонажа < %.",
            enabled = true,
            value = 80,
            key = "thunder"
        },
        {
            type = "entry",
            text = ni.spell.icon(57994) .. " Пронизывающий ветер",
            tooltip = "Автоматическое определение и [Прерывание]\nвсех прирываемых заклинаний.",
            enabled = false,
            key = "WindShearInterrupt"
        },
        {
            type = "entry",
            text = ni.spell.icon(2382) .. " |cffffa500Debug Printing|r",
            tooltip = "Включение дебаг-функции в чате.",
            enabled = false,
            key = "Debug"
        },
        {type = "separator"},
        {type = "page", number = 1, text = "|cff00C957Защитные настройки"},
        {type = "separator"},
        {
            type = "entry",
            text = ni.spell.icon(49273) .. "Волна исцеления",
            tooltip = "Хилим себя когда |cff00D700HP|r < %",
            enabled = true,
            value = 70,
            min = 15,
            max = 100,
            step = 1,
            width = 40,
            key = "wave"
        },
        {type = "separator"},
        {
            type = "entry",
            text = m(36892) .. " Камень здоровья",
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
            text = m(33447) .. " Зелье здоровья",
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
            text = m(33448) .. " Зелье маны",
            tooltip = "Использовать зелье, когда |cff0082FFMP|r < % у персонажа < %.",
            enabled = true,
            value = 25,
            min = 15,
            max = 65,
            step = 1,
            width = 40,
            key = "manapotionuse"
        },
        {type = "separator"},
        {type = "page", number = 2, text = "|cffEE4000Настройки ротации"},
        {type = "separator"},
        {
            type = "entry",
            text = ni.spell.icon(51514) .. " Авто контроль (Союзн.)",
            tooltip = "Автоматически контролирует союзников, которые попали под контроль.",
            enabled = true,
            key = "control"
        },
        {
            type = "entry",
            text = ni.spell.icon(8012) .. "Развеивание магии",
            tooltip = "Включение заклинания в ротацию.",
            enabled = true,
            key = "purge"
        },
        {
            type = "entry",
            text = "\124T" .. s .. ":24:24\124t Автоматический выбор цели",
            tooltip = "Автоматический выбирает рядом стоящего противника",
            enabled = true,
            key = "AutoTarget"
        },
        {
            type = "entry",
            text = "\124T" .. trinket .. ":24:24\124t Тринькеты",
            tooltip = "Автоиспользование тринькетов",
            enabled = true,
            key = "trinket"
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
        {type = "separator"},
        {type = "title", text = ni.spell.icon(107) .. "|cFFFF4500Щит на себя|r"},
        {
            type = "dropdown",
            menu = {
                {selected = false, value = 1, text = ni.spell.icon(57960) .. "Водный щит"},
                {selected = false, value = 2, text = ni.spell.icon(49281) .. "Щит Молний"},
                {selected = false, value = 0, text = "|cffFF0303Без щита|r"}
            },
            key = "Shield"
        },
        {type = "separator"},
        {type = "entry", text = "|cFFF5DEB3Тотемы|r"},
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
            text = i(36936) .. "Возвращение тотемов",
            tooltip = "Автоматически убирает  и ставит тотемы во время боя и после боя(Включать только на боссах!!)",
            enabled = true,
            key = "Vozvrat"
        },
        {type = "separator"},
        {type = "page", number = 3, text = "Диспел"},
        {type = "separator"},
        {
            type = "entry",
            text = ni.spell.icon(8012) .. "Развеивание магии",
            tooltip = "Включение заклинания в ротацию.",
            enabled = true,
            key = "purge"
        },
        {type = "separator"}
    }
    local function u(v)
        for g, h in ipairs(t) do
            if h.type == "entry" and h.key ~= nil and h.key == v then
                return h.value, h.enabled
            end
            if h.type == "dropdown" and h.key ~= nil and h.key == v then
                for w, x in pairs(h.menu) do
                    if x.selected then
                        return x.value
                    end
                end
            end
            if h.type == "input" and h.key ~= nil and h.key == v then
                return h.value
            end
        end
    end
    local function y()
        ni.GUI.AddFrame("Elem", t)
    end
    local function z()
        ni.GUI.DestroyFrame("Elem")
    end
    local function A(B, C)
        C = true and C or false
        if tonumber(B) == nil then
            B = ni.spell.id(B)
        end
        local D = false
        if B == nil or B == 0 then
            return false
        end
        if IsSpellKnown(B, C) then
            local v = GetSpellInfo(B)
            if v then
                D = true
            end
        end
        return D
    end
    local E = {
        oryzie = GetSpellInfo(58790),
        Lightshild = GetSpellInfo(49281),
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
    local F = {
        PlayerIsMoving = false,
        InCombat = false,
        GlyphChain = false,
        Controled = false,
        KnowCleanseSpirit = false
    }
    local G = {
        "Cache",
        "Universal pause",
        
        "AutoTarget",
        "Enchant Weapon",
        "Shield",
        "Thunderstorm (Regen Mana)",
        "Combat specific Pause",
        "Healthstone (Use)",
        "Heal Potions (Use)",
        "Mana Potions (Use)",
        "Racial Stuff",
        "Trinkets",
        "totem",
        "Vozvrat",
        "Wind Shear (Interrupt)",
        "Lava Burst",
        "Elemental Mastery",
        "Control (Member)",
        "Flame Shock",
        "Earth Shock",
        "Healing Wave (Self)",
        "Chain Lightning",
        "Cure Toxins (Member)",
        "Cure Toxins (Self)",
        "Purge",
        "Lightning Bolt"
    }
    local H, I = 0, 0
    local J, K, c = {}, {}, {}
    local L, M, N, O = E.CleanseSpirit, "Poison|Disease|Curse", 0, 0
    local P = {
        ["Cache"] = function()
            if GetTime() - I > 100 then
                ni.utils.resetlasthardwareaction()
                I = GetTime()
            end
            F.InCombat = UnitAffectingCombat("player") or false
            F.PlayerIsMoving = ni.player.ismoving() or false
            F.GlyphChain = ni.player.hasglyph(55437) or false
            F.Controled =
                ni.player.issilenced() or ni.player.isstunned() or ni.player.isconfused() or ni.player.isfleeing() or
                false
            F.KnowCleanseSpirit = A(E.CleanseSpirit) or false
            if F.KnowCleanseSpirit then
                L = E.CleanseSpirit
                Type = "Disease|Poison|Curse"
            else
                L = E.CureToxins
                Type = "Disease|Poison"
            end
            if F.InCombat and GetTime() - H >= 15 then
                wipe(J)
                wipe(K)
                wipe(c)
                H = GetTime()
            end
            ni.vars.debug = select(2, u("Debug"))
        end,
        ["Universal pause"] = function()
            if a.UniPause() then
                return true
            end
            ni.vars.debug = select(2, u("Debug"))
        end,
        ["AutoTarget"] = function()
            local o, Q = u("AutoTarget")
            if Q then
                if
                    UnitAffectingCombat("player") and
                        (ni.unit.exists("target") and UnitIsDeadOrGhost("target") and
                            not UnitCanAttack("player", "target") or
                            not ni.unit.exists("target"))
                 then
                    ni.player.runtext("/targetenemy")
                end
            end
        end,
        ["Enchant Weapon"] = function()
            if GetInventoryItemID("player", 16) ~= nil then
                local R = GetWeaponEnchantInfo()
                if not R and a.spellusablesilence(E.oryzie) then
                    ni.spell.cast(E.oryzie)
                    BindEnchant()
                    return true
                end
            end
        end,
        ["Shield"] = function()
            local S, Q = u("Shield")
            if not Q then
                if S == 0 then
                    return false
                end
                if S == 1 then
                    if not ni.player.buff(E.WaterShield) and a.spellusablesilence(E.WaterShield) then
                        ni.spell.cast(E.WaterShield)
                        return true
                    end
                end
                if S == 2 then
                    if not ni.player.buff(E.Lightshild) and a.spellusablesilence(E.Lightshild) then
                        ni.spell.cast(E.Lightshild)
                        return true
                    end
                end
            end
        end,
        ["Thunderstorm (Regen Mana)"] = function()
            table.wipe(c)
            local c = ni.unit.enemiesinrange("player", 15)
            local S, Q = u("thunder")
            if
                Q and #c == 0 and not UnitAffectingCombat("player") and ni.player.power() < S and
                    ni.spell.available(59159)
             then
                ni.spell.cast(59159)
                return true
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
        ["Healthstone (Use)"] = function()
            local S, Q = u("healthstoneuse")
            local T = {36892, 36893, 36894}
            for U = 1, #T do
                if Q and ni.player.hp() < S and ni.player.hasitem(T[U]) and ni.player.itemcd(T[U]) == 0 then
                    ni.player.useitem(T[U])
                    return true
                end
            end
        end,
        ["Heal Potions (Use)"] = function()
            local S, Q = u("healpotionuse")
            local V = {33447, 43569, 40087, 41166, 40067}
            for U = 1, #V do
                if Q and ni.player.hp() < S and ni.player.hasitem(V[U]) and ni.player.itemcd(V[U]) == 0 then
                    ni.player.useitem(V[U])
                    return true
                end
            end
        end,
        ["Mana Potions (Use)"] = function()
            local S, Q = u("manapotionuse")
            local W = {33448, 43570, 40087, 42545, 39671}
            for U = 1, #W do
                if Q and ni.player.power() < S and ni.player.hasitem(W[U]) and ni.player.itemcd(W[U]) == 0 then
                    ni.player.useitem(W[U])
                    return true
                end
            end
        end,
        ["Racial Stuff"] = function()
            local o, Q = u("Prozimki")
            if not Q then
                return false
            end
            local X = {33697, 20572, 33702, 26297}
            local Y = {20594, 28880}
            if ni.unit.isfleeing("player") and A(7744) and ni.spell.available(7744) then
                ni.spell.cast(7744)
                return true
            end
            for U = 1, #X do
                local Z = X[U]
                if
                    (ni.vars.combat.cd or ni.unit.isboss("target")) and A(Z) and ni.spell.available(Z) and
                        ni.spell.valid("target", 49238, true, true)
                 then
                    ni.spell.cast(Z)
                    return true
                end
            end
            for U = 1, #Y do
                local _ = Y[U]
                if
                    ni.spell.valid("target", 49238, true, true) and ni.player.hp() < 20 and A(_) and
                        ni.spell.available(_)
                 then
                    ni.spell.cast(_)
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
        ["Trinkets"] = function()
            local o, Q = u("trinket")
            if Q then
                if
                    (ni.vars.combat.cd or ni.unit.isboss("target")) and ni.player.slotcastable(13) and
                        ni.player.slotcd(13) == 0 and
                        ni.spell.valid("target", 49238)
                 then
                    ni.player.useinventoryitem(13)
                else
                    if
                        (ni.vars.combat.cd or ni.unit.isboss("target")) and ni.player.slotcastable(14) and
                            ni.player.slotcd(14) == 0 and
                            ni.spell.valid("target", 49238)
                     then
                        ni.player.useinventoryitem(14)
                        return true
                    end
                end
            end
        end,
        ["Wind Shear (Interrupt)"] = function()
            local o, Q = u("WindShearInterrupt")
            if Q then
                return false
            end
            if a.spellusablesilence(E.WindShear) then
                local a0 = select(9, GetSpellInfo(E.WindShear))
                local c = ni.player.enemiesinrange(a0)
                for U = 1, #c do
                    local a1 = c[U].guid
                    if ni.spell.shouldinterrupt(a1) and ni.spell.valid(a1, E.WindShear, true, true) then
                        ni.spell.cast(E.WindShear, a1)
                        return true
                    end
                end
            end
        end,
        ["totem"] = function()
            local S = u("totem")
            local a2 = select(2, GetTotemInfo(2))
            local a3 = select(2, GetTotemInfo(1))
            local a4 = select(2, GetTotemInfo(3))
            local a5 = select(2, GetTotemInfo(4))
            if F.InCombat then
                if S == 1 then
                    a.spellusablesilence(66842)
                    if a2 == "" and a3 == "" and a4 == "" and a5 == "" then
                        ni.spell.cast(66842)
                        ni.debug.print("ставим - " .. GetSpellLink(66842))
                        return true
                    end
                end
                if S == 2 then
                    a.spellusablesilence(66843)
                    if a2 == "" and a3 == "" and a4 == "" and a5 == "" then
                        ni.spell.cast(66843)
                        ni.debug.print("ставим - " .. GetSpellLink(66843))
                        return true
                    end
                end
                if S == 3 then
                    a.spellusablesilence(66844)
                    if a2 == "" and a3 == "" and a4 == "" and a5 == "" then
                        ni.spell.cast(66844)
                        ni.debug.print("ставим - " .. GetSpellLink(66844))
                        return true
                    end
                end
            end
        end,
        ["Vozvrat"] = function()
            local o, Q = u("Vozvrat")
            if not Q then
                return false
            end
            local a2 = select(2, GetTotemInfo(2))
            local a3 = select(2, GetTotemInfo(1))
            local a4 = select(2, GetTotemInfo(3))
            local a5 = select(2, GetTotemInfo(4))
            if a2 == "" and a3 == "" and a4 == "" and a5 == "" then
                return false
            end
            if not F.InCombat and (a2 ~= "" or a3 ~= "" or a4 ~= "" or a5 ~= "") then
                ni.spell.cast(36936)
                ni.debug.print("УБИРАЕМ ВСЕ ТОТЕМЫ " .. GetSpellLink(36936))
                return true
            end
        end,
        ["Elemental Mastery"] = function()
            local a6 = a.shaman.flameshock()
            if
                (ni.vars.CD or ni.unit.isboss("target")) and a6 and not ni.spell.available(60043) and
                    ni.spell.available(16166) and
                    a.CDsaverTTD("target") and
                    ni.spell.valid("target", 49238, true, true)
             then
                ni.spell.castspells("16166|49238")
                return true
            end
        end,
        ["Flame Shock"] = function()
            if
                ni.unit.debuffremaining("target", 49233, "player") < 2 and ni.spell.available(49233) and
                    ni.spell.valid("target", 49233, true, true)
             then
                ni.spell.cast(49233, "target")
                return true
            end
        end,
        ["Earth Shock"] = function()
            local a6 = a.shaman.flameshock()
            if ni.player.ismoving() and a6 and ni.spell.available(49231) and ni.spell.valid("target", 49231, true, true) then
                ni.spell.cast(49231, "target")
                return true
            end
        end,
        ["Lava Burst"] = function()
            local a6 = a.shaman.flameshock()
            if
                a6 and not ni.player.ismoving() and ni.spell.available(60043) and
                    ni.spell.valid("target", 60043, true, true)
             then
                ni.spell.cast(60043, "target")
                return true
            end
        end,
        ["Healing Wave (Self)"] = function()
            local S, Q = u("manapotionuse")
            if Q and ni.player.hp() < S and ni.spell.available(49273) and not ni.player.ismoving() then
                ni.spell.cast(49273, "player")
                return true
            end
        end,
        ["Chain Lightning"] = function()
            if
                (f() > 1 or f() == 1) and ni.spell.available(49271) and not ni.player.ismoving() and
                    ni.spell.valid("target", 49271, true, true)
             then
                ni.spell.cast(49271, "target")
                return true
            end
        end,
        ["Cure Toxins (Self)"] = function()
            local o, Q = u("toxins")
            if
                Q and ni.player.debufftype("Disease|Poison") and ni.spell.available(526) and
                    ni.healing.candispel("player") and
                    GetTime() - a.LastDispel > 1.5 and
                    ni.spell.valid("player", 526, false, true, true)
             then
                ni.spell.cast(526, "player")
                a.LastDispel = GetTime()
                return true
            end
        end,
        ["Cure Toxins (Member)"] = function()
            local o, Q = u("toxinsmemb")
            if Q and ni.spell.available(526) then
                for U = 1, #ni.members do
                    if
                        ni.unit.debufftype(ni.members[U].unit, "Disease|Poison") and
                            ni.healing.candispel(ni.members[U].unit) and
                            GetTime() - a.LastDispel > 1.5 and
                            ni.spell.valid(ni.members[U].unit, 526, false, true, true)
                     then
                        ni.spell.cast(526, ni.members[U].unit)
                        a.LastDispel = GetTime()
                        return true
                    end
                end
            end
        end,
        ["Purge"] = function()
            local o, Q = u("purge")
            if
                Q and a.shaman.canPurge("target") and ni.spell.available(8012) and
                    ni.spell.valid("player", 8012, true, true) and
                    GetTime() - a.shaman.LastPurge > 2.5
             then
                ni.spell.cast(8012, "target")
                a.shaman.LastPurge = GetTime()
                return true
            end
        end,
        ["Lightning Bolt"] = function()
            if ni.spell.available(49238) and not ni.player.ismoving() and ni.spell.valid("target", 49238, true, true) then
                ni.spell.cast(49238, "target")
                return true
            end
        end,
        ["Control (Member)"] = function()
            local o, Q = u("control")
            if Q and ni.spell.available(51514) then
                for U = 1, #ni.members do
                    local J = ni.members[U].unit
                    if
                        a.ControlMember(J) and not a.UnderControlMember(J) and
                            ni.spell.valid(J, 51514, false, true, true)
                     then
                        ni.spell.cast(51514, J)
                        return true
                    end
                end
            end
        end,
        ["Window"] = function()
            if not deb then
                ni.frames.floatingtext:message("shaman Elemental By WH")
                print("|cffEE4000=======================================|r")
                print("|cffFFFF00Shaman Elemental by whoamiwow|r")
                print("|cff00C957v0.0.1 release|r")
                print("https://discord.gg/6wCgVRhQFs  ----- Wh Project")
                print("• Нажать кнопку АоЕ для переключения режимов")
                print("|cffEE4000=======================================|r")
                deb = true
            end
        end
    }
    ni.bootstrap.profile("Elem", G, P, y, z)
else
    local G = {"Error"}
    local P = {["Error"] = function()
            ni.vars.profiles.enabled = false
            if d > 30300 then
                ni.frames.floatingtext:message("This profile is meant for WotLK 3.3.5a! Sorry!")
            elseif e < 80 then
                ni.frames.floatingtext:message("This profile is meant for level 80! Sorry!")
            elseif data == nil then
                ni.frames.floatingtext:message("Data file is missing or corrupted!")
            end
        end}
    ni.bootstrap.profile("Elem", G, P)
end
