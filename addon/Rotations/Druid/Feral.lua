local a = ni.utils.require("Kusbas") or ni.utils.require("Kusbas.enc") or ni.utils.require("DarhangeR.lua")
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
    local j, j, k = GetSpellInfo(48570)
    local j, j, l = GetSpellInfo(48572)
    local j, j, m = GetSpellInfo(48566)
    local j, j, n = GetSpellInfo(48535)
    local j, j, o = GetSpellInfo(29166)
    local j, j, p = GetSpellInfo(47878)
    local j, j, q = GetSpellInfo(33786)
    local j, j, r = GetSpellInfo(48575)
    local j, j, s = GetSpellInfo(61336)
    local j, j, t = GetSpellInfo(22812)
    local j, j, u = GetSpellInfo(48443)
    local j, j, v = GetSpellInfo(48378)
    local j, j, w = GetSpellInfo(768)
    local j, j, x = GetSpellInfo(33786)
    local j, j, m = GetSpellInfo(48566)
    local j, j, y = GetSpellInfo(16857)
    local j, j, z = GetSpellInfo(22908)
    local j, j, A = GetSpellInfo(49800)
    local j, j, B = GetSpellInfo(48574)
    hpotionIcon = "Interface\\Icons\\INV_Alchemy_Elixir_05"
    mpotionIcon = "Interface\\Icons\\INV_Alchemy_Elixir_02"
    trinket = "Interface\\Icons\\inv_relics_idolofferocity"
    bossIcon = "Interface\\Icons\\inv_misc_head_dragon_01"
    local C = {
        settingsfile = "Feral.json",
        {type = "title", text = "Feral druid by WH"},
        {type = "separator"},
        {
            type = "entry",
            text = h(49076) .. " Остановка ротации",
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
        {type = "page", number = 1, text = "|cff00ff00Настройки ротации|r"},
        {type = "separator"},
        {type = "entry", text = d(768) .. "Облик кошки", tooltip = "Автоформа", enabled = true, key = "form"},
        {type = "entry", text = d(48566) .. "Увечье", tooltip = "Использовать Увечье", enabled = true, key = "mungle"},
        {
            type = "entry",
            text = "\124T" .. A .. ":24:24\124t \124T" .. B .. ":24:24\124t Кровотечения",
            tooltip = "Накладывать эффекты кровотечения",
            enabled = true,
            key = "Bleed"
        },
        {
            type = "entry",
            text = d(48577) .. "Свирепый укус",
            tooltip = "Добавляет Свирепый укус в ротацию",
            enabled = true,
            key = "Kus"
        },
        {
            type = "entry",
            text = d(16857) .. "Волшебный огонь",
            tooltip = "Использовать волшебный огонь",
            enabled = true,
            key = "Magicfire"
        },
        {type = "title", text = "|cFFFF4500Основной атакующий спелл|r"},
        {
            type = "dropdown",
            menu = {
                {selected = false, value = 2, text = d(48570) .. "Цапнуть"},
                {selected = true, value = 1, text = d(48572) .. "Полоснуть"},
                {selected = false, value = 3, text = d(48566) .. "Увечье"},
                {selected = false, value = 0, text = "|cffFF0303Автоматический режим|r"}
            },
            key = "atackspells"
        },
        {type = "separator"},
        {type = "title", text = "|cff00ff00Дополнительно|r"},
        {type = "separator"},
        {
            type = "entry",
            text = "\124T" .. trinket .. ":24:24\124t Тринькеты",
            tooltip = "Автоиспользование тринькетов",
            enabled = true,
            key = "trinket"
        },
        {
            type = "entry",
            text = "\124T" .. bossIcon .. ":24:24\124t Автоматическое определение босса",
            tooltip = "Автоматический использовать бурсты на боссах",
            enabled = true,
            key = "Boss"
        },
        {
            type = "entry",
            text = "\124T" .. z .. ":24:24\124t Автоматический выбор цели",
            tooltip = "Автоматический выбирает рядом стоящего противника",
            enabled = true,
            key = "AutoTarget"
        },
        {
            type = "entry",
            text = d(33786) .. "Автоматический контроль союзников",
            tooltip = "Автоматический кидает вихри союзникам по выбранной метки ниже",
            enabled = true,
            key = "Cyclone"
        },
        {type = "title", text = "|cFFFF4500Циклон по метке|r"},
        {
            type = "dropdown",
            menu = {
                {selected = true, value = 1, text = "|cffffff00Звезда"},
                {selected = false, value = 2, text = "|cFFFFA500Круг"},
                {selected = false, value = 3, text = "|cFF800080Ромб"},
                {selected = false, value = 4, text = "|cff00ff00Треугольник"},
                {selected = false, value = 5, text = "|cffbbbbbbЛуна"},
                {selected = false, value = 6, text = "|cff0000ffКвадрат"},
                {selected = false, value = 7, text = "|cffFF0303Крест"},
                {selected = false, value = 8, text = "Череп"},
                {selected = false, value = nil, text = "Никого"}
            },
            key = "CycloneForMark"
        },
        {type = "separator"},
        {type = "title", text = "|cFFFF4500Озарение|r"},
        {
            type = "dropdown",
            menu = {
                {selected = false, value = 1, text = d(29166) .. "По фокусу"},
                {selected = true, value = 2, text = d(29166) .. "По себе"},
                {selected = true, value = 3, text = d(29166) .. "По хилерам"},
                {selected = false, value = 0, text = "|cffFF0303Ручной режим|r"}
            },
            key = "InnervateMp"
        },
        {type = "title", text = "|cFFFF4500Количество маны при котором использовать озарение|r"},
        {type = "input", enabled = true, value = 35, min = 0, max = 100, step = 1, width = 40, key = "Innervatevalue"},
        {type = "page", number = 2, text = "|cff00ff00Настройки исцеления|r"},
        {type = "separator"},
        {type = "page", number = 2, text = "|cffff0000Защитные настройки|r"},
        {type = "separator"},
        {
            type = "entry",
            text = d(48575) .. "Попятиться ",
            tooltip = "Включите чтобы сбрасывать агро",
            enabled = true,
            key = "agr"
        },
        {
            type = "entry",
            text = d(61336) .. "Инстинкты выживания",
            tooltip = "Использовать, когда |cff00D700HP|r < % у персонажа < %.",
            enabled = true,
            value = 30,
            min = 20,
            max = 60,
            step = 1,
            width = 40,
            key = "Instinkts"
        },
        {
            type = "entry",
            text = d(22812) .. "Дубовая кожа",
            tooltip = "Использовать дубовую кожу, когда |cff00D700HP|r < % у персонажа < %.",
            enabled = true,
            value = 30,
            min = 20,
            max = 60,
            step = 1,
            width = 40,
            key = "Barskin"
        },
        {
            type = "entry",
            text = d(48443) .. "Восстановление",
            tooltip = "Использовать восстановление, когда |cff00D700HP|r < % у персонажа < %.",
            enabled = true,
            value = 80,
            min = 20,
            max = 95,
            step = 1,
            width = 40,
            key = "Heal"
        },
        {type = "separator"},
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
        {type = "page", number = 3, text = "|cffff0000Бафы|r"},
        {type = "separator"},
        {
            type = "entry",
            text = d(53307) .. "Шипы",
            tooltip = "Автоматичеси обновление шипов на пресонаже",
            enabled = true,
            key = "Ship"
        },
        {
            type = "entry",
            text = d(48470) .. "Дар дикой природы",
            tooltip = "Автоиспользование бафа если его нет на игроке",
            enabled = true,
            key = "Lapa"
        },
        {type = "separator"}
    }
    local function D(E)
        for F, G in ipairs(C) do
            if G.type == "entry" and G.key ~= nil and G.key == E then
                return G.value, G.enabled
            end
            if G.type == "dropdown" and G.key ~= nil and G.key == E then
                for H, I in pairs(G.menu) do
                    if I.selected then
                        return I.value
                    end
                end
            end
            if G.type == "input" and G.key ~= nil and G.key == E then
                return G.value
            end
        end
    end
    local function J()
        ni.GUI.AddFrame("Feral", C)
    end
    local function K()
        ni.GUI.DestroyFrame("Feral")
    end
    local L = {
        Magicfire = GetSpellInfo(16857),
        Deeprana = GetSpellInfo(48574),
        Mungle = GetSpellInfo(48566),
        Razor = GetSpellInfo(49800),
        Cap = GetSpellInfo(48570),
        Ukus = GetSpellInfo(48577),
        Polosovanie = GetSpellInfo(48572),
        Agrosbros = GetSpellInfo(48575),
        Tiger = GetSpellInfo(50213),
        Instinkts = GetSpellInfo(61336),
        Berserk = GetSpellInfo(50334),
        Rev = GetSpellInfo(52610),
        Razmax = GetSpellInfo(62078),
        Yasnost = GetSpellInfo(16870),
        Arg = GetSpellInfo(48575),
        Instinkts = GetSpellInfo(61336),
        Barskin = GetSpellInfo(22812),
        Inner = GetSpellInfo(29166),
        Bystrota = GetSpellInfo(69369),
        Vostanovlenie = GetSpellInfo(48443),
        Form = GetSpellInfo(768),
        Adrenaline = GetSpellInfo(316239),
        Veter = GetSpellInfo(33786),
        Mk = GetSpellInfo(35280),
        VorgenRacial = GetSpellInfo(316290),
        DworfRacial = GetSpellInfo(316246),
        Nak = GetSpellInfo(48579),
        Cyclone = GetSpellInfo(33786),
        Ship = GetSpellInfo(53307),
        Lapa = GetSpellInfo(48470)
    }
    local M = {sirus = false, InCombat = false, Controled = false, Moved = false}
    local N = {
        "Riot",
        "Cache",
        "Pause",
        "Ship",
        "Lapa",
        "Form",
        "Combat specific Pause",
        "AutoTarget",
        "Cyclone",
        "Inner",
        "Agrosbros",
        "Instinkts",
        "Barskin",
        "Trinkets",
        "Healthstone (Use)",
        "Heal Potions (Use)",
        "Magicfire",
        "Adrenaline",
        "VorgenRacial",
        "DworfRacial",
        "Nak",
        "Tiger",
        "Razor",
        "Rev",
        "Mungle",
        "Ukus",
        "Deeprana",
        "Berserk",
        "Perchi",
        "Mainspell",
        "Heal",
        "Polosovanie",
        "Cap",
        "Razmax",
        "Yasnost"
    }
    local O, P = 0, 0
    local Q, R, S = {}, {}, {}
    local T = {67229, 37162, 35280, 36866, 51503, 37122, 38626, 7645, 14515, 63042, 20604, 15859}
    local U = {
        ["Riot"] = function()
            if not c then
                if not M.sirus then
                    ni.frames.floatingtext:message("Feral Druid By WH")
                    print("|cffEE4000=======================================|r")
                    print("|cffFFFF00Feral Druid by whoamiwow|r")
                    print("|cff00C957v0.0.1 release|r")
                    print("https://discord.gg/6wCgVRhQFs  ----- Wh Project")
                    print("• Нажать кнопку АоЕ для переключения режимов")
                    print("|cffEE4000=======================================|r")
                    c = true
                end
            end
        end,
        ["Cache"] = function()
            if M.InCombat and GetTime() - O >= 15 then
                wipe(Q)
                wipe(R)
                wipe(S)
                O = GetTime()
            end
            if GetTime() - P > 100 then
                ni.utils.resetlasthardwareaction()
                P = GetTime()
            end
            M.InCombat = UnitAffectingCombat("player") or false
            M.Controled =
                ni.player.issilenced() or ni.player.isstunned() or ni.player.isconfused() or ni.player.isfleeing() or
                false
            M.Moved = ni.player.ismoving() or false
            M.sirus = a.sirusserver() or false
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
                    not UnitAffectingCombat("player") and ni.vars.followEnabled
             then
                return true
            end
        end,
        ["Combat specific Pause"] = function()
            if UnitAffectingCombat("player") then
                return false
            end
            for V = 1, #ni.members do
                if UnitAffectingCombat(ni.members[V].unit) then
                    return false
                end
            end
            return true
        end,
        ["Cyclone"] = function()
            if a.spellusablesilence(L.Cyclone) then
                local j, W = D("Cyclone")
                if W then
                    local S = ni.unit.enemiesinrange("player", 25)
                    for V = 1, #S do
                        local X = S[V].guid
                        for Y = 1, #T do
                            if ni.unit.debuff(X, T[Y]) then
                                if
                                    not ni.unit.debuff(X, L.Cyclone, "player") and ni.unit.isplayer(X) and
                                        not ni.player.ismoving() and
                                        ni.drtracker.get(X, L.Cyclone) ~= 0 and
                                        ni.spell.valid(X, L.Cyclone, false, true, true)
                                 then
                                    ni.spell.cast(L.Cyclone, X)
                                end
                            end
                            if ni.unit.debuff(X, T[Y]) then
                                if
                                    not ni.unit.debuff(X, L.Cyclone, "player") and ni.unit.isplayer(X) and
                                        ni.player.buff(69369) and
                                        ni.drtracker.get(X, L.Cyclone) ~= 0 and
                                        ni.spell.valid(X, L.Cyclone, false, true, true)
                                 then
                                    ni.spell.cast(L.Cyclone, X)
                                end
                            end
                            local Z = D("CycloneForMark")
                            if Z == 1 and GetRaidTargetIndex(X) == 1 then
                                if
                                    a.spellusablesilence(L.Cyclone) and not ni.player.ismoving() and
                                        not ni.unit.debuff(X, L.Cyclone, "player") and
                                        ni.drtracker.get(X, L.Cyclone) ~= 0 and
                                        ni.spell.valid(X, L.Cyclone, false, true, true)
                                 then
                                    ni.spell.cast(L.Cyclone, X)
                                    return false
                                end
                            end
                            if Z == 2 and GetRaidTargetIndex(X) == 2 then
                                if
                                    a.spellusablesilence(L.Cyclone) and not ni.player.ismoving() and
                                        not ni.unit.debuff(X, L.Cyclone, "player") and
                                        ni.drtracker.get(X, L.Cyclone) ~= 0 and
                                        ni.spell.valid(X, L.Cyclone, false, true, true)
                                 then
                                    ni.spell.cast(L.Cyclone, X)
                                    return false
                                end
                            end
                            if Z == 3 and GetRaidTargetIndex(X) == 3 then
                                if
                                    a.spellusablesilence(L.Cyclone) and not ni.player.ismoving() and
                                        not ni.unit.debuff(X, L.Cyclone, "player") and
                                        ni.drtracker.get(X, L.Cyclone) ~= 0 and
                                        ni.spell.valid(X, L.Cyclone, false, true, true)
                                 then
                                    ni.spell.cast(L.Cyclone, X)
                                    return false
                                end
                            end
                            if Z == 4 and GetRaidTargetIndex(X) == 4 then
                                if
                                    a.spellusablesilence(L.Cyclone) and not ni.player.ismoving() and
                                        not ni.unit.debuff(X, L.Cyclone, "player") and
                                        ni.drtracker.get(X, L.Cyclone) ~= 0 and
                                        ni.spell.valid(X, L.Cyclone, false, true, true)
                                 then
                                    ni.spell.cast(L.Cyclone, X)
                                    return false
                                end
                            end
                            if Z == 5 and GetRaidTargetIndex(X) == 5 then
                                if
                                    a.spellusablesilence(L.Cyclone) and not ni.player.ismoving() and
                                        not ni.unit.debuff(X, L.Cyclone, "player") and
                                        ni.drtracker.get(X, L.Cyclone) ~= 0 and
                                        ni.spell.valid(X, L.Cyclone, false, true, true)
                                 then
                                    ni.spell.cast(L.Cyclone, X)
                                    return false
                                end
                            end
                            if Z == 6 and GetRaidTargetIndex(X) == 6 then
                                if
                                    a.spellusablesilence(L.Cyclone) and not ni.player.ismoving() and
                                        not ni.unit.debuff(X, L.Cyclone, "player") and
                                        ni.drtracker.get(X, L.Cyclone) ~= 0 and
                                        ni.spell.valid(X, L.Cyclone, false, true, true)
                                 then
                                    ni.spell.cast(L.Cyclone, X)
                                    return false
                                end
                            end
                            if Z == 7 and GetRaidTargetIndex(X) == 7 then
                                if
                                    a.spellusablesilence(L.Cyclone) and not ni.player.ismoving() and
                                        not ni.unit.debuff(X, L.Cyclone, "player") and
                                        ni.drtracker.get(X, L.Cyclone) ~= 0 and
                                        ni.spell.valid(X, L.Cyclone, false, true, true)
                                 then
                                    ni.spell.cast(L.Cyclone, X)
                                    return false
                                end
                            end
                            if Z == 8 and GetRaidTargetIndex(X) == 8 then
                                if
                                    a.spellusablesilence(L.Cyclone) and not ni.player.ismoving() and
                                        not ni.unit.debuff(X, L.Cyclone, "player") and
                                        ni.drtracker.get(X, L.Cyclone) ~= 0 and
                                        ni.spell.valid(X, L.Cyclone, false, true, true)
                                 then
                                    ni.spell.cast(L.Cyclone, X)
                                    return false
                                end
                            end
                            if Z == nil then
                                return false
                            end
                        end
                    end
                end
            end
        end,
        ["Healthstone (Use)"] = function()
            local Z, W = D("healthstoneuse")
            local _ = {
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
            if W and ni.player.hp() < Z and not ni.player.isstunned() and UnitAffectingCombat("player") then
                for V = 1, #_ do
                    if ni.player.hasitem(_[V]) and ni.player.itemcd(_[V]) == 0 then
                        ni.player.useitem(_[V])
                    end
                end
            end
        end,
        ["Barskin"] = function()
            local Z, W = D("Barskin")
            if W then
                if
                    a.spellusable(L.Barskin) and UnitAffectingCombat("player") and ni.player.hp() < Z and
                        not ni.player.buff(L.Barskin)
                 then
                    ni.spell.cast(L.Barskin)
                end
            end
        end,
        ["Heal Potions (Use)"] = function()
            local Z, W = D("healpotionuse")
            local a0 = {43569, 41166, 40087, 39671, 33934, 33447, 28100, 22829, 13446, 4596, 3928, 1710, 929, 858, 118}
            if W and ni.player.hp() < Z and not ni.player.isstunned() and UnitAffectingCombat("player") then
                for V = 1, #a0 do
                    if ni.player.hasitem(a0[V]) and ni.player.itemcd(a0[V]) == 0 then
                        ni.player.useitem(a0[V])
                    end
                end
            end
        end,
        ["Magicfire"] = function()
            local j, W = D("Magicfire")
            if W then
                if
                    a.spellusable(L.Magicfire) and not ni.vars.combat.aoe and ni.unit.isboss("target") and
                        not ni.unit.debuff("target", L.Magicfire) and
                        not ni.unit.debuff("target", 770) and
                        ni.spell.valid("target", L.Magicfire, true, true)
                 then
                    ni.spell.cast(L.Magicfire, "target")
                end
            end
        end,
        ["Perchi"] = function()
            local j, W = D("Boss")
            if W then
                if
                    ni.player.slotcastable(10) and ni.player.slotcd(10) == 0 and ni.unit.isboss("target") and
                        ni.player.buff(L.Rev) and
                        ni.player.power() >= 45
                 then
                    if ni.player.useinventoryitem(10) then
                        return true
                    end
                end
            end
        end,
        ["Berserk"] = function()
            local j, W = D("Boss")
            if W then
                if
                    ni.spell.available(L.Berserk) and ni.unit.isboss("target") and a.getrange("target", L.Ukus) and
                        ni.player.buff(L.Rev) and
                        ni.unit.hp("target") >= 5 and
                        ni.player.power() >= 45
                 then
                    ni.spell.cast(L.Berserk)
                    return true
                end
            end
            if ni.vars.combat.cd then
                if
                    ni.spell.available(L.Berserk) and a.getrange("target", L.Ukus) and ni.player.buff(L.Rev) and
                        ni.unit.hp("target") >= 5 and
                        ni.player.power() >= 45
                 then
                    ni.spell.cast(L.Berserk)
                end
            end
        end,
        ["AutoTarget"] = function()
            local j, W = D("AutoTarget")
            if W then
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
        ["Instinkts"] = function()
            local Z, W = D("Instinkts")
            if W then
                if
                    ni.spell.available(L.Instinkts) and UnitAffectingCombat("player") and ni.player.hp() < Z and
                        not ni.player.buff(L.Instinkts)
                 then
                    ni.spell.cast(L.Instinkts)
                end
            end
        end,
        ["Adrenaline"] = function()
            if M.sirus then
                if a.spellisknown(L.Adrenaline) then
                    if
                        (ni.vars.combat.cd or ni.unit.isboss("target")) and a.spellusable(L.Adrenaline) and
                            a.getrange("target", L.Ukus)
                     then
                        ni.spell.cast(L.Adrenaline)
                    end
                end
            end
        end,
        ["VorgenRacial"] = function()
            if M.sirus then
                if a.spellusable(L.VorgenRacial) and a.getrange("target", L.Ukus) then
                    ni.spell.cast(L.VorgenRacial)
                end
            end
        end,
        ["DworfRacial"] = function()
            if M.sirus then
                if a.spellusable(L.DworfRacial) and a.getrange("target", L.Ukus) then
                    ni.spell.cast(L.DworfRacial)
                end
            end
        end,
        ["Trinkets"] = function()
            local j, W = D("trinket")
            if W then
                if
                    (ni.vars.combat.cd or ni.unit.isboss("target")) and ni.player.slotcastable(13) and
                        ni.player.slotcd(13) == 0 and
                        ni.spell.valid("target", 48570)
                 then
                    ni.player.useinventoryitem(13)
                else
                    if
                        (ni.vars.combat.cd or ni.unit.isboss("target")) and ni.player.slotcastable(14) and
                            ni.player.slotcd(14) == 0 and
                            ni.spell.valid("target", 48570)
                     then
                        ni.player.useinventoryitem(14)
                        return true
                    end
                end
            end
        end,
        ["Tiger"] = function()
            if
                ni.spell.available(L.Tiger, true) and a.spellusable(L.Tiger) and not ni.player.buff(L.Tiger) and
                    ni.unit.power("player") <= 30
             then
                ni.spell.cast(L.Tiger)
            end
        end,
        ["Heal"] = function()
            local Z, W = D("Heal")
            if W then
                if
                    ni.spell.available(L.Vostanovlenie) and UnitAffectingCombat("player") and ni.player.buff(L.Bystrota) and
                        ni.player.hp() < Z
                 then
                    ni.spell.cast(L.Vostanovlenie)
                end
            end
        end,
        ["Form"] = function()
            local j, W = D("form")
            if W then
                if not ni.player.aura(L.Form) and a.spellusable(L.Form) then
                    ni.spell.cast(L.Form)
                end
            end
        end,
        ["Rev"] = function()
            if
                ni.spell.available(L.Rev) and a.spellusable(L.Rev) and not ni.player.buff(L.Rev) and
                    not ni.player.buff(L.Yasnost) and
                    GetComboPoints("player", "target") >= 1 and
                    ni.spell.valid("target", L.Rev, false, false, true)
             then
                ni.spell.cast(L.Rev, "target")
                return true
            end
        end,
        ["Agrosbros"] = function()
            local j, W = D("agr")
            if W then
                if
                    a.spellusable(L.Agrosbros) and #ni.members >= 2 and ni.spell.available(L.Agrosbros) and
                        a.getrange("target", L.Ukus) and
                        ni.unit.threat("player", "target") >= 1
                 then
                    ni.spell.cast(L.Agrosbros, "target")
                end
            end
        end,
        ["Ukus"] = function()
            local j, W = D("Kus")
            if W then
                if
                    a.spellusable(L.Ukus) and not ni.player.buff(L.Yasnost) and
                        ni.unit.debuffremaining("target", L.Razor, "player") >= 10 and
                        GetComboPoints("player", "target") == 5 and
                        ni.spell.valid("target", L.Ukus, false, false, true)
                 then
                    ni.spell.cast(L.Ukus, "target")
                    return true
                end
            end
        end,
        ["Razor"] = function()
            local j, W = D("Bleed")
            if W then
                if
                    ni.drtracker.get("target", L.Razor) ~= 0 and ni.spell.available(L.Razor) and a.spellusable(L.Razor) and
                        not ni.player.buff(L.Yasnost) and
                        not ni.unit.debuff("target", L.Razor, "player") and
                        GetComboPoints("player", "target") == 5 and
                        ni.spell.valid("target", L.Razor, false, false, true)
                 then
                    ni.spell.cast(L.Razor, "target")
                    return true
                end
            end
        end,
        ["Mungle"] = function()
            local j, W = D("mungle")
            if W then
                if
                    ni.spell.available(L.Mungle) and a.spellusable(L.Mungle) and not ni.vars.combat.aoe and
                        not UnitIsTrivial("target") and
                        not ni.player.buff(L.Yasnost) and
                        not ni.unit.debuff("target", L.Mungle) and
                        not ni.unit.debuff("target", 48564) and
                        not ni.unit.debuff("target", 46857) and
                        ni.spell.valid("target", L.Mungle, false, false, true)
                 then
                    ni.spell.cast(L.Mungle, "target")
                    return false
                end
            end
            if
                ni.spell.available(L.Mungle) and a.spellusable(L.Mungle) and ni.vars.combat.aoe and
                    not ni.player.buff(L.Yasnost) and
                    not ni.player.buff(L.Rev) and
                    ni.spell.valid("target", L.Mungle, false, false, true)
             then
                ni.spell.cast(L.Mungle, "target")
                return false
            end
        end,
        ["Deeprana"] = function()
            local j, W = D("Bleed")
            if W then
                if
                    ni.drtracker.get("target", L.Deeprana) ~= 0 and ni.spell.available(L.Deeprana) and
                        a.spellusable(L.Deeprana) and
                        not ni.player.buff(L.Yasnost) and
                        not ni.unit.debuff("target", L.Deeprana, "player") and
                        not ni.vars.combat.aoe and
                        ni.spell.valid("target", L.Deeprana, false, false, true)
                 then
                    ni.spell.cast(L.Deeprana, "target")
                    return true
                end
            end
        end,
        ["Innervate"] = function()
            local a1 = D("InnervateMp")
            local Z = D("Innervatevalue")
            if a.spellusablesilence(L.Inner) then
                if Z == 0 then
                    return false
                end
                if a1 == 1 then
                    if ni.unit.power("focus") <= Z and ni.spell.valid("focus", L.Inner, false, true, true) then
                        ni.spell.cast(L.Inner, "focus")
                        return true
                    end
                end
                if a1 == 2 then
                    if not ni.player.buff(L.Inner) and ni.player.power() <= Z then
                        ni.spell.cast(L.Inner)
                        return true
                    end
                end
                if a1 == 3 then
                    for V = 1, #ni.members do
                        local a2 = ni.members[V].guid
                        if ni.unit.hasheal(a2) then
                            if ni.unit.power(a2) <= Z and ni.spell.valid(a2, L.Inner, false, true, true) then
                                ni.spell.cast(L.Inner, a2)
                                return true
                            end
                        end
                    end
                end
            end
        end,
        ["Veterok"] = function()
            if ni.unit.exists("target") and ni.spell.available(L.Veterok) and ni.player.buff(L.Bystrota) then
                local S = ni.unit.enemiesinrange("target", 18)
                for V = 1, #S do
                    local a3 = S[V].guid
                    if
                        ni.unit.creaturetype(a3) ~= 8 and not ni.unit.debuff(a3, L.Veterok) and not ni.unit.isimmune(a3) and
                            ni.spell.valid(a3, L.Veterok, false, true) and
                            not ni.unit.isplayercontrolled(a3)
                     then
                        ni.spell.cast(L.Veterok, a3)
                        return true
                    end
                end
            end
        end,
        ["Nak"] = function()
            if
                a.spellusable(L.Nak) and not ni.player.buff(L.Yasnost) and not ni.unit.isfacing("target", "player") and
                    ni.spell.valid("target", L.Nak, false, true)
             then
                ni.spell.cast(L.Nak, "target")
            end
        end,
        ["Rotation Pause"] = function()
            local Z, W = D("rpause")
            if W then
                SLASH_PAUSE1 = "/rpause"
                SlashCmdList.PAUSE = function()
                    ni.rotation.delay(Z)
                end
            end
        end,
        ["Mainspell"] = function()
            local Z = D("atackspells")
            if Z == 1 then
                if
                    a.spellusable(L.Polosovanie) and not ni.vars.combat.aoe and ni.spell.available(L.Polosovanie) and
                        not ni.unit.isfacing("target", "player") and
                        ni.spell.valid("target", L.Polosovanie, false, true)
                 then
                    ni.spell.cast(L.Polosovanie, "target")
                    return false
                end
            end
            if Z == 2 then
                if
                    a.spellusable(L.Cap) and ni.spell.available(L.Cap) and not ni.vars.combat.aoe and
                        ni.spell.valid("target", L.Cap, false, true)
                 then
                    ni.spell.cast(L.Cap, "target")
                    return false
                end
            end
            if Z == 3 then
                if
                    a.spellusable(L.Mungle) and not ni.vars.combat.aoe and ni.spell.available(L.Cap) and
                        ni.spell.valid("target", L.Mungle, false, true)
                 then
                    ni.spell.cast(L.Mungle, "target")
                    return false
                end
            end
            if Z == 0 then
                if not ni.unit.isfacing("target", "player") then
                    if
                        a.spellusable(L.Polosovanie) and not ni.vars.combat.aoe and ni.spell.available(L.Polosovanie) and
                            ni.spell.valid("target", L.Polosovanie, false, true)
                     then
                        ni.spell.cast(L.Polosovanie, "target")
                    end
                end
                if Z == 0 then
                    if ni.unit.isfacing("player", "target") then
                        if
                            a.spellusable(L.Cap) and not ni.vars.combat.aoe and ni.spell.available(L.Mungle) and
                                ni.unit.isfacing("target", "player") and
                                ni.spell.valid("target", L.Mungle, false, true)
                         then
                            ni.spell.cast(L.Mungle, "target")
                            return true
                        end
                    end
                end
            end
        end,
        ["Ship"] = function()
            local j, W = D("Ship")
            if not W then
                return false
            end
            if not ni.player.buff(53307) then
                ni.spell.cast(53307)
                return true
            end
        end,
        ["Lapa"] = function()
            local j, W = D("Lapa")
            if not W then
                return false
            end
            if not ni.player.buff(48470) then
                ni.spell.cast(48470)
                return true
            end
        end,
        ["Razmax"] = function()
            if
                ni.vars.combat.aoe and ni.spell.available(L.Razmax) and not IsCurrentSpell(48480) and
                    a.getrange("target", L.Ukus)
             then
                ni.spell.cast(L.Razmax, "target")
            end
        end
    }
    ni.bootstrap.profile("Feral", N, U, J, K)
else
    local N = {"Error"}
    local U = {["Error"] = function()
            ni.vars.profiles.enabled = false
            if b > 30300 then
                if GetLocale() == "ruRU" then
                    ni.frames.floatingtext:message("Только для 3.3.5a!")
                else
                    ni.frames.floatingtext:message("This profile for WotLK 3.3.5a!")
                end
            elseif a == nil then
                if GetLocale() == "ruRU" then
                    ni.frames.floatingtext:message("Kusbas-файл поврежден или отсуствует!")
                else
                    ni.frames.floatingtext:message("Kusbas file is missing or corrupted!")
                end
            end
        end}
    ni.bootstrap.profile("Feral", N, U)
end
