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
if d == 30300 and e == 80 and a then
    local function i(j, k, l)
        return "\124T" ..
            (select(3, GetSpellInfo(j)) or select(3, GetSpellInfo(24720))) ..
                ":" .. (l or 25) .. ":" .. (k or 25) .. "\124t"
    end
    local function m(n, k, l)
        return "\124T" ..
            (GetItemIcon(n) or select(3, GetSpellInfo(24720))) .. ":" .. (l or 25) .. ":" .. (k or 25) .. "\124t"
    end
    local o, o, p = GetSpellInfo(49276)
    local o, o, q = GetSpellInfo(49273)
    local o, o, r = GetSpellInfo(22908)
    local s = {
        settingsfile = "Enx.js",
        {type = "title", text = "Enx shaman by |c0000CED1Who am i"},
        {type = "separator"},
        {type = "title", text = "|cffFFFF00Основные настройки"},
        {type = "separator"},
        {
            type = "entry",
            text = ni.spell.icon(57994) .. "Пронизывающий ветер",
            tooltip = "Автоматическое определение и [Прерывание]\nвсех прирываемых заклинаний.",
            enabled = false,
            key = "WindShearInterrupt"
        },
        {type = "separator"},
        {type = "page", number = 1, text = "|cff00C957Защитные настройки"},
        {type = "separator"},
        {
            type = "entry",
            text = i(30823) .. "Ярость шамана (Mp)",
            tooltip = "Используйте заклинание, когда у игрока |cff0082FFMP|r < %",
            enabled = true,
            value = 35,
            key = "rage"
        },
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
        {type = "page", number = 2, text = "|cffEE4000Основные настройки"},
        {type = "separator"},
        {
            type = "entry",
            text = "\124T" .. r .. ":24:24\124t Автоматический выбор цели",
            tooltip = "Автоматический выбирает рядом стоящего противника",
            enabled = true,
            key = "AutoTarget"
        },
        {
            type = "entry",
            text = ni.spell.icon(51514) .. " Авто контроль (Союзн.)",
            tooltip = "Автоматически контролирует союзников, которые попали под контроль.",
            enabled = true,
            "control"
        },
        {
            type = "entry",
            text = i(8012) .. "Развеивание магии",
            tooltip = "Снимает почтив все магические эффекты",
            enabled = true,
            key = "purge"
        },
        {type = "entry", text = i(61657) .. "Кольцо огня", enabled = true, key = "firenova"},
        {
            type = "entry",
            text = i(66842) .. "Автоматические тотемы",
            tooltip = "Ставит тотемы Зова стихий во время боя(Включать только на боссах!!)",
            enabled = true,
            key = "totem"
        },
        {
            type = "entry",
            text = i(36936) .. "Возвращение тотемов",
            tooltip = "Автоматически убирает тотемы после боя",
            enabled = true,
            key = "Vozvrat"
        },
        {type = "separator"},
        {type = "title", text = "Диспел"},
        {type = "separator"},
        {
            type = "entry",
            text = i(526) .. "Оздоровление",
            tooltip = "Автоматически снимает все отрицательные эффекты с игрока",
            enabled = true,
            key = "toxins"
        },
        {
            type = "entry",
            text = i(526) .. "Оздоровление (Союзн.)",
            tooltip = "Автоматически снимает все отрицательные эффекты с участников",
            enabled = false,
            key = "toxinsmemb"
        }
    }
    local function t(u)
        for g, h in ipairs(s) do
            if h.type == "entry" and h.key ~= nil and h.key == u then
                return h.value, h.enabled
            end
            if h.type == "dropdown" and h.key ~= nil and h.key == u then
                for v, w in pairs(h.menu) do
                    if w.selected then
                        return w.value
                    end
                end
            end
            if h.type == "input" and h.key ~= nil and h.key == u then
                return h.value
            end
        end
    end
    local function x()
        ni.GUI.AddFrame("Enx", s)
    end
    local function y()
        ni.GUI.DestroyFrame("Enx")
    end
    local function z(A, B)
        B = true and B or false
        if tonumber(A) == nil then
            A = ni.spell.id(A)
        end
        local C = false
        if A == nil or A == 0 then
            return false
        end
        if IsSpellKnown(A, B) then
            local u = GetSpellInfo(A)
            if u then
                C = true
            end
        end
        return C
    end
    local function D(A, E)
        if tonumber(A) == nil then
            A = ni.spell.id(A)
        end
        local C = false
        if A == nil or A == 0 then
            return false
        end
        local F = GetSpellInfo(A)
        if not ni.player.isstunned() and not ni.player.issilenced() and ni.spell.available(A, E) and IsUsableSpell(F) then
            C = true
        end
        return C
    end
    local G = {38210, 48068, 48066, 61301, 43039, 43020, 48441, 11841, 43046, 18100}
    local function H(I)
        for J = 1, #G do
            local K = G[J]
            local L = select(8, ni.unit.buff(I, K))
            if L then
                return true
            end
        end
        return false
    end
    local M = {
        PlayerIsMoving = false,
        InCombat = false,
        GlyphChain = false,
        Controled = false,
        KnowCleanseSpirit = false
    }
    local j = {
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
    local N = {
        
        "Cache",
        "Universal pause",
        "AutoTarget",
        "Enchant Weapon",
        "Lightning Shield",
        "Combat specific Pause",
        "Pet Attack/Follow",
        "Healthstone (Use)",
        "Heal Potions (Use)",
        "Mana Potions (Use)",
        "Racial Stuff",
        "Use enginer gloves",
        "Trinkets",
        "Wind Shear (Interrupt)",
        "Totem",
        "Magma Totem",
        "Vozvrat",
        "Feral Spirit",
        "Shamanistic Rage",
        "Purge",
        "Control (Member)",
        "Cure Toxins (Member)",
        "Cure Toxins (Self)",
        "Chain Lightning/Bolt",
        "Fire Nova",
        "Stormstrike",
        "Flame Shock",
        "Earth Shock",
        "Lava Lash"
    }
    local O, P = 0, 0
    local Q, R, c = {}, {}, {}
    local S, T, U, V = j.CleanseSpirit, "Poison|Disease|Curse", 0, 0
    local W = {
        ["Vozvrat"] = function()
            local o, X = t("Vozvrat")
            if not X then
                return false
            end
            local Y = select(2, GetTotemInfo(2))
            local fireTotem = select(2, GetTotemInfo(1))
            local Z = select(2, GetTotemInfo(3))
            local _ = select(2, GetTotemInfo(4))
            if Y == "" and fireTotem == "" and Z == "" and _ == "" then
                return false
            end
            if not M.InCombat and (Y ~= "" or fireTotem ~= "" or Z ~= "" or _ ~= "") then
                ni.spell.cast(36936)
                ni.debug.print("УБИРАЕМ ВСЕ ТОТЕМЫ " .. GetSpellLink(36936))
                return true
            end
        end,
        ["Cache"] = function()
            if GetTime() - P > 100 then
                ni.utils.resetlasthardwareaction()
                P = GetTime()
            end
            M.InCombat = UnitAffectingCombat("player") or false
            M.PlayerIsMoving = ni.player.ismoving() or false
            M.Controled =
                ni.player.issilenced() or ni.player.isstunned() or ni.player.isconfused() or ni.player.isfleeing() or
                false
            if M.InCombat and GetTime() - O >= 15 then
                wipe(Q)
                wipe(R)
                wipe(c)
                O = GetTime()
            end
            ni.vars.debug = select(2, t("Debug"))
        end,
        ["Universal pause"] = function()
            if a.UniPause() then
                return true
            end
            ni.vars.debug = select(2, t("Debug"))
        end,
        ["AutoTarget"] = function()
            local o, X = t("AutoTarget")
            if not X then
                return false
            end
            if
                UnitAffectingCombat("player") and
                    (ni.unit.exists("target") and UnitIsDeadOrGhost("target") and not UnitCanAttack("player", "target") or
                        not ni.unit.exists("target"))
             then
                ni.player.runtext("/targetenemy")
            end
        end,
        ["Enchant Weapon"] = function()
            local a0, o, o, a1 = GetWeaponEnchantInfo()
            if not a0 and ni.spell.available(58804) then
                ni.spell.cast(58804)
                return true
            end
            if not a1 and ni.spell.available(58790) then
                ni.spell.cast(58790)
                return true
            end
        end,
        ["Lightning Shield"] = function()
            local a2, o, o, a3 = ni.player.buff(49281)
            if not a2 or a3 < 2 and ni.spell.available(49281) then
                ni.spell.cast(49281)
                return true
            end
        end,
        ["Pet Attack/Follow"] = function()
            if
                ni.unit.hp("playerpet") < 20 and ni.unit.exists("playerpet") and ni.unit.exists("target") and
                    UnitIsUnit("target", "pettarget") and
                    not UnitIsDeadOrGhost("playerpet")
             then
                a.petFollow()
            else
                if
                    UnitAffectingCombat("player") and ni.unit.exists("playerpet") and ni.unit.hp("playerpet") > 60 and
                        ni.unit.exists("target") and
                        not UnitIsUnit("target", "pettarget") and
                        not UnitIsDeadOrGhost("playerpet")
                 then
                    a.petAttack()
                end
            end
        end,
        ["Combat specific Pause"] = function()
            if UnitAffectingCombat("player") then
                return false
            end
            for J = 1, #ni.members do
                if UnitAffectingCombat(ni.members[J].unit) then
                    return false
                end
            end
            return true
        end,
        ["Heal Potions (Use)"] = function()
            local a4, X = t("healpotionuse")
            local a5 = {43569, 41166, 40087, 39671, 33934, 33447, 28100, 22829, 13446, 4596, 3928, 1710, 929, 858, 118}
            if X and ni.player.hp() < a4 and not cache.controled and cache.InCombat then
                for J = 1, #a5 do
                    local a6 = a5[J]
                    if ni.player.hasitem(a6) and IsUsableItem(a6) and ni.player.itemcd(a6) == 0 then
                        ni.player.useitem(a6)
                        return true
                    end
                end
            end
        end,
        ["Healthstone (Use)"] = function()
            local a4, X = t("healthstoneuse")
            local a7 = {
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
            if X and ni.player.hp() < a4 and not cache.Controled and cache.InCombat then
                for J = 1, #a7 do
                    local a8 = a7[J]
                    if ni.player.hasitem(a8) and IsUsableItem(a8) and ni.player.itemcd(a8) == 0 then
                        ni.player.useitem(a8)
                        return true
                    end
                end
            end
        end,
        ["Mana Potions (Use)"] = function()
            local a4, X = t("manapotionuse")
            local a9 = {43570, 42545, 40087, 40067, 33935, 33448, 28101, 22832, 13444, 13443, 6149, 3827, 3385, 2455}
            if X and ni.player.power(0) < a4 and not cache.Controled and cache.InCombat then
                for J = 1, #a9 do
                    local aa = a9[J]
                    if ni.player.hasitem(aa) and IsUsableItem(aa) and ni.player.itemcd(aa) == 0 then
                        ni.player.useitem(aa)
                        return true
                    end
                end
            end
        end,
        ["Racial Stuff"] = function()
            local ab = {33697, 20572, 33702, 26297}
            local ac = {20594, 28880}
            if a.forsaken("player") and IsSpellKnown(7744) and ni.spell.available(7744) then
                ni.spell.cast(7744)
                return true
            end
            for J = 1, #ab do
                if
                    (ni.vars.combat.cd or ni.unit.isboss("target")) and IsSpellKnown(ab[J]) and
                        ni.spell.available(ab[J]) and
                        a.CDsaverTTD("target") and
                        ni.spell.valid("target", 17364)
                 then
                    ni.spell.cast(ab[J])
                    return true
                end
            end
            for J = 1, #ac do
                if
                    ni.spell.valid("target", 17364) and ni.player.hp() < 20 and IsSpellKnown(ac[J]) and
                        ni.spell.available(ac[J])
                 then
                    ni.spell.cast(ac[J])
                    return true
                end
            end
        end,
        ["Use enginer gloves"] = function()
            if
                ni.player.slotcastable(10) and ni.player.slotcd(10) == 0 and a.CDsaverTTD("target") and
                    (ni.vars.combat.cd or ni.unit.isboss("target")) and
                    ni.spell.valid("target", 17364)
             then
                ni.player.useinventoryitem(10)
                return true
            end
        end,
        ["Trinkets"] = function()
            if
                (ni.vars.combat.cd or ni.unit.isboss("target")) and ni.player.slotcastable(13) and
                    ni.player.slotcd(13) == 0 and
                    a.CDsaverTTD("target") and
                    ni.spell.valid("target", 17364)
             then
                ni.player.useinventoryitem(13)
            else
                if
                    (ni.vars.combat.cd or ni.unit.isboss("target")) and ni.player.slotcastable(14) and
                        ni.player.slotcd(14) == 0 and
                        a.CDsaverTTD("target") and
                        ni.spell.valid("target", 17364)
                 then
                    ni.player.useinventoryitem(14)
                    return true
                end
            end
        end,
        ["Wind Shear (Interrupt)"] = function()
            local o, X = t("WindShearInterrupt")
            if not X then
                return false
            end
            if D(j.WindShear) then
                local ad = select(9, GetSpellInfo(j.WindShear))
                local c = ni.player.enemiesinrange(ad)
                for J = 1, #c do
                    local ae = c[J].guid
                    if ni.spell.shouldinterrupt(ae) and ni.spell.valid(ae, j.WindShear, true, true) then
                        ni.spell.cast(j.WindShear, ae)
                        return true
                    end
                end
            end
        end,
        ["Totem"] = function()
            local o, X = t("totem")
            if not X then
                return false
            end
            if not tContains(UnitName("target"), ni.IgnoreUnits) then
                local Y = select(2, GetTotemInfo(2))
                local af = ni.unit.distance("target", "totem1")
                local ag = ni.player.distance("target")
                if
                    ni.spell.valid("target", 17364) and
                        (Y == "" or Y ~= "" and ag ~= nil and ag < 6 and af ~= nil and af > 10) and
                        not ni.player.ismoving()
                 then
                    ni.spell.cast(66842)
                    return true
                end
            end
        end,
        ["Magma Totem"] = function()
            if not tContains(UnitName("target"), ni.IgnoreUnits) then
                local fireTotem = select(2, GetTotemInfo(1))
                local af = ni.unit.distance("target", "totem1")
                local ag = ni.player.distance("target")
                if
                    ni.spell.valid("target", 17364) and
                        (fireTotem == "" or fireTotem ~= "" and ag ~= nil and ag < 6 and af ~= nil and af > 10) and
                        not ni.player.ismoving()
                 then
                    ni.spell.cast(58734)
                    return true
                end
            end
        end,
        ["Shamanistic Rage"] = function()
            local a4, X = t("rage")
            if
                a.checkforSet(a.shaman.itemsetT10Enc, 2) and (ni.vars.CD or ni.unit.isboss("target")) and
                    ni.spell.available(30823) and
                    ni.spell.valid("target", 17364)
             then
                ni.spell.cast(30823, "target")
                return true
            end
            if X and ni.player.power() < a4 and ni.spell.available(30823) and ni.spell.valid("target", 17364) then
                ni.spell.cast(30823, "target")
                return true
            end
        end,
        ["Feral Spirit"] = function()
            if
                (ni.vars.CD or ni.unit.isboss("target")) and not ni.unit.exists("playerpet") and
                    ni.spell.available(51533) and
                    a.CDsaverTTD("target") and
                    ni.spell.valid("target", 17364)
             then
                ni.spell.cast(51533)
                return true
            end
        end,
        ["Chain Lightning/Bolt"] = function()
            local ah, o, o, ai = ni.player.buff(53817)
            if ai == 5 then
                if
                    (f() > 1 or f() == 1) and ni.spell.isinstant(49271) and ni.spell.available(49271) or
                        not ni.spell.valid("target", 17364) and ni.spell.valid("target", 49271, true, true)
                 then
                    ni.spell.cast(49271, "target")
                    return true
                end
                if
                    not ni.spell.available(49271) and ni.spell.isinstant(49238) and ni.spell.available(49238) and
                        ni.spell.valid("target", 49238, true, true)
                 then
                    ni.spell.cast(49238, "target")
                    return true
                end
                if
                    f() < 1 and ni.spell.isinstant(49238) and ni.spell.available(49238) or
                        not ni.spell.valid("target", 17364) and ni.spell.valid("target", 49238, true, true)
                 then
                    ni.spell.cast(49238, "target")
                    return true
                end
            end
        end,
        ["Fire Nova"] = function()
            local af = ni.unit.distance("target", "totem1")
            local ag = ni.player.distance("target")
            local o, X = t("firenova")
            if
                X and ni.spell.available(61657) and not ni.spell.available(49231) and not ni.spell.available(17364) and
                    not ni.spell.available(60103) and
                    fireTotem ~= "" and
                    ag < 7 and
                    af < 7 and
                    ni.spell.valid("target", 17364)
             then
                ni.spell.cast(61657)
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
            if
                ni.unit.debuffremaining("target", 49233, "player") > 4 and ni.spell.available(49231) and
                    ni.spell.valid("target", 49231, true, true)
             then
                ni.spell.cast(49231, "target")
                return true
            end
        end,
        ["Stormstrike"] = function()
            local ah, o, o, ai = ni.player.buff(53817)
            if (not ah or ai < 5) and ni.spell.available(17364) and ni.spell.valid("target", 17364, true, true) then
                ni.spell.cast(17364, "target")
                return true
            end
        end,
        ["Lava Lash"] = function()
            local ah, o, o, ai = ni.player.buff(53817)
            if (not ah or ai < 5) and ni.spell.available(60103) and ni.spell.valid("target", 60103, true, true) then
                ni.spell.cast(60103, "target")
                return true
            end
        end,
        ["Cure Toxins (Self)"] = function()
            local o, X = t("toxins")
            if
                X and ni.player.debufftype("Disease|Poison") and ni.spell.available(526) and
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
            local o, X = t("toxinsmemb")
            if X and ni.spell.available(526) then
                for J = 1, #ni.members do
                    if
                        ni.unit.debufftype(ni.members[J].unit, "Disease|Poison") and
                            ni.healing.candispel(ni.members[J].unit) and
                            GetTime() - a.LastDispel > 1.5 and
                            ni.spell.valid(ni.members[J].unit, 526, false, true, true)
                     then
                        ni.spell.cast(526, ni.members[J].unit)
                        a.LastDispel = GetTime()
                        return true
                    end
                end
            end
        end,
        ["Purge"] = function()
            local o, X = t("purge")
            if not X then
                return false
            end
            if H("target") and D(j.Purge) and GetTime() - V > 2.5 and ni.spell.valid("player", j.Purge, true, true) then
                ni.spell.cast(j.Purge, "target")
                V = GetTime()
                ni.debug.print("Диспелю : " .. GetSpellLink(j.Purge) .. " тебя " .. UnitName(target))
                return true
            end
        end,
        ["Control (Member)"] = function()
            local o, X = t("control")
            if X or M.PlayerIsMoving then
                return false
            end
            if D(j.Hex) then
                for J = 1, #ni.members do
                    local Q = ni.members[J].unit
                    if UnitIsEnemy("player", Q) and ni.spell.valid(Q, j.Hex, false, true, true) then
                        ni.spell.cast(j.Hex, Q)
                        ni.debug.print("Превращаем: " .. GetSpellLink(j.Hex) .. " тебя! " .. UnitName(FirstMemb))
                        return true
                    end
                end
            end
        end,
        ["Window"] = function()
            if not deb then
                ni.frames.floatingtext:message("Shaman Enx by WH")
                print("|cffEE4000=======================================|r")
                print("|cffFFFF00Enhancement Shaman by WhoamiWoW|r")
                print("|cff00C957v0.0.1 release|r")
                print("https://discord.gg/6wCgVRhQFs  ----- Wh Project")
                print("• Нажать кнопку АоЕ для переключения режимов")
                print("|cffEE4000=======================================|r")
                deb = true
            end
        end
    }
    ni.bootstrap.profile("Enx", N, W, x, y)
else
    local N = {"Error"}
    local W = {["Error"] = function()
            ni.vars.profiles.enabled = false
            if d > 30300 then
                ni.frames.floatingtext:message("This profile is meant for WotLK 3.3.5a! Sorry!")
            elseif e < 80 then
                ni.frames.floatingtext:message("This profile is meant for level 80! Sorry!")
            elseif a == nil then
                ni.frames.floatingtext:message("Riot file is missing or corrupted!")
            end
        end}
    ni.bootstrap.profile("Enx", N, W)
end
