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
    local i, i, j = GetSpellInfo(22908)
    local function k(l, m, n)
        return "\124T" ..
            (select(3, GetSpellInfo(l)) or select(3, GetSpellInfo(24720))) ..
                ":" .. (n or 25) .. ":" .. (m or 25) .. "\124t"
    end
    local function o(p, m, n)
        return "\124T" ..
            (GetItemIcon(p) or select(3, GetSpellInfo(24720))) .. ":" .. (n or 25) .. ":" .. (m or 25) .. "\124t"
    end
    local q = {
        settingsfile = "Ppal.js",
        {type = "title", text = "Proto paladin by |c0000CED1WH"},
        {type = "separator"},
        {type = "title", text = "|cffFFFF00Основные настройки"},
        {type = "separator"},
        {
            type = "entry",
            text = ni.spell.icon(54428) .. "Святая клятва",
            tooltip = "Включение/выключение Святой клятвы",
            enabled = true,
            key = "plea"
        },
        {
            type = "entry",
            text = ni.spell.icon(53601) .. "Священный щит",
            tooltip = "Включение/выключение заклинания для применения к игроку",
            enabled = true,
            key = "sacred"
        },
        {type = "separator"},
        {type = "page", number = 1, text = "|cff00C957Защита союзников"},
        {type = "separator"},
        {
            type = "entry",
            text = ni.spell.icon(64205) .. "Священная жертва",
            tooltip = "Включить заклинание",
            enabled = true,
            key = "sacrifice"
        },
        {
            type = "entry",
            text = ni.spell.icon(64205) .. "Священная жертва (Хп созников)",
            tooltip = "Включить использование заклинания, когда пользователь HP < %",
            value = 45,
            key = "sacrificehp"
        },
        {
            type = "entry",
            text = ni.spell.icon(64205) .. "Священная жертва  (Кол-во участников)",
            tooltip = "Используйте заклинание, когда количество участников в отряде / рейде невелико",
            value = 4,
            key = "sacrificecount"
        },
        {
            type = "entry",
            text = ni.spell.icon(10278) .. "Длань зашиты (Союзники)",
            tooltip = "Используйте заклинание, когда HP участника < %. Работайте только с классами заклинателей",
            enabled = true,
            value = 25,
            key = "handofprot"
        },
        {
            type = "entry",
            text = ni.spell.icon(6940) .. "Длань жертвенности (Союзники)",
            tooltip = "Используйте заклинание, когда у участника HP < %",
            enabled = true,
            value = 18,
            key = "handsacrifice"
        },
        {
            type = "entry",
            text = ni.spell.icon(1038) .. "Длань спасения (Союзники)",
            tooltip = "Автоматическая проверка агро участника и использование заклинания",
            enabled = true,
            key = "salva"
        },
        {type = "separator"},
        {type = "page", number = 2, text = "|cffEE4000Настройки ротации"},
        {type = "separator"},
        {type = "title", text = "|cff8788EEПравосудия|r"},
        {
            type = "dropdown",
            menu = {
                {selected = false, value = 1, text = ni.spell.icon(20186) .. "Правосудие мудрости"},
                {selected = false, value = 2, text = ni.spell.icon(20271) .. "Правосудие света"},
                {selected = false, value = 3, text = ni.spell.icon(53407) .. "Правосудие справедливости"},
                {selected = false, value = 0, text = "|cffFF0303Ручной режим|r"}
            },
            key = "Jaga"
        },
        {
            type = "entry",
            text = ni.spell.icon(31884) .. "Молот гнева",
            tooltip = "Включение/выключение заклинания",
            enabled = false,
            key = "wrath"
        },
        {
            type = "entry",
            text = ni.spell.icon(62124) .. "Длань возмездия",
            tooltip = "Автоматическое использование заклинания для уничтожения врагов в радиусе 30 ярдов",
            enabled = false,
            key = "hand"
        },
        {
            type = "entry",
            text = ni.spell.icon(31789) .. "Праведная защита (Авто-Таргет вкл!)",
            tooltip = "Автоматическое использование заклинания для удаления врагов от участника в радиусе 30 ярдов",
            enabled = false,
            key = "def"
        },
        {
            type = "entry",
            text = ni.spell.icon(48819) .. "Освящение",
            tooltip = "Включение/выключение заклинания для использования поочередно",
            enabled = true,
            key = "concentrat"
        },
        {
            type = "entry",
            text = ni.spell.icon(48819) .. "Пороговое значение маны для использования",
            tooltip = "Используйте заклинание освящения, когда у игрока заканчивается мана > %",
            value = 30,
            key = "concentratmana"
        },
        {
            type = "entry",
            text = ni.spell.icon(10326) .. "Изгнание зла (Авто-Таргет)",
            tooltip = "Автоматическая проверка и использование заклинаний на нужных врагах",
            enabled = false,
            key = "turn"
        },
        {
            type = "entry",
            text = "\124T" .. j .. ":24:24\124t Автоматический выбор цели",
            tooltip = "Автоматический выбирает рядом стоящего противника",
            enabled = true,
            key = "AutoTarget"
        },
        {
            type = "entry",
            text = ni.spell.icon(10308) .. "Автоматический контроль (Союзники)",
            tooltip = "Автоматическая проверка и контроль участника, если он находится под контролем разума или т.д.",
            enabled = true,
            key = "control"
        },
        {type = "separator"},
        {type = "title", text = "Dispel"},
        {type = "separator"},
        {
            type = "entry",
            text = ni.spell.icon(4987) .. "Очищение (себя)",
            tooltip = "Автоматическое снятие дебаффов с игрока",
            enabled = true,
            key = "cleans"
        },
        {
            type = "entry",
            text = ni.spell.icon(1044) .. "Фридом (себя)",
            tooltip = "Автоматическое наложение на игрока, когда у вас есть критерии для заклинания",
            enabled = true,
            key = "freedom"
        },
        {type = "page", number = 3, text = "|cFFFA8072Зелья + сейвы|r"},
        {type = "separator"},
        {
            type = "entry",
            text = ni.spell.icon(48788) .. "Возложить на руки",
            tooltip = "Используйте заклинание, когда у игрока есть HP < %",
            enabled = true,
            value = 20,
            key = "layon"
        },
        {
            type = "entry",
            text = ni.spell.icon(498) .. "Божественная защита",
            tooltip = "Использовать спелл если игрока HP < %",
            enabled = true,
            value = 35,
            key = "divineprot"
        },
        {
            type = "entry",
            text = o(36892) .. " Камень здоровья",
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
            text = o(33447) .. " Зелье здоровья",
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
            text = o(33448) .. " Зелье маны",
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
    local function r(s)
        for g, h in ipairs(q) do
            if h.type == "entry" and h.key ~= nil and h.key == s then
                return h.value, h.enabled
            end
            if h.type == "dropdown" and h.key ~= nil and h.key == s then
                for t, u in pairs(h.menu) do
                    if u.selected then
                        return u.value
                    end
                end
            end
            if h.type == "input" and h.key ~= nil and h.key == s then
                return h.value
            end
        end
    end
    local function v()
        ni.GUI.AddFrame("Ppal", q)
    end
    local function w()
        ni.GUI.DestroyFrame("Ppal")
    end
    local x = {JudgmentOfWisdom = GetSpellInfo(53408), Jagaorg = GetSpellInfo(20271), Jagared = GetSpellInfo(53407)}
    local y = {
        
        "Universal pause",
        "AutoTarget",
        "Pechati mchenia",
        "Aoe pechat",
        "Righteous Fury",
        "Sacred Shield",
        "Auto Track Undeads",
        "Combat specific Pause",
        "Healthstone (Use)",
        "Heal Potions (Use)",
        "Mana Potions (Use)",
        "Racial Stuff",
        "Lay on Hands (Self)",
        "Divine Protection",
        "Divine Sacrifice",
        "Divine Plea",
        "Hand of Reckoning (Ally)",
        "Hand of Reckoning",
        "Righteous Defence",
        "Judgements(PRO)",
        "Hand of Sacrifice (Member)",
        "Hand of Protection (Member)",
        "Hand of Salvation (Member)",
        "Turn Evil (Auto Use)",
        "Control (Member)",
        "Avenging Wrath",
        "Holy Wrath",
        "Consecration",
        "Avenger's Shield",
        "Holy Shield",
        "Hammer of the Righteous",
        "Hand of Freedom (Self)",
        "Cleanse (Self)",
        "Shield of Righteousness"
    }
    local z = {
        ["Window"] = function()
            if not deb then
                ni.frames.floatingtext:message("Proto pal By WH")
                print("|cffEE4000=======================================|r")
                print("|cffFFFF00Proto paladin by whoamiwow|r")
                print("|cff00C957v0.0.1 release|r")
                print("https://discord.gg/6wCgVRhQFs  ----- Wh Project")
                print("• Нажать кнопку АоЕ для переключения режимов")
                print("|cffEE4000=======================================|r")
                deb = true
            end
        end,
        ["Universal pause"] = function()
            if a.UniPause() then
                return true
            end
            ni.vars.debug = select(2, r("Debug"))
        end,
        ["AutoTarget"] = function()
            local i, A = r("AutoTarget")
            if A then
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
        ["Auto Track Undeads"] = function()
            if ni.player.hasglyph(57947) then
                if not UnitAffectingCombat("player") and GetTime() - a.paladin.LastTrack > 3 then
                    SetTracking(nil)
                end
                if
                    UnitAffectingCombat("player") and ni.unit.exists("target") and ni.unit.creaturetype("target") == 6 and
                        ni.spell.available(5502) and
                        GetTime() - a.paladin.LastTrack > 3
                 then
                    a.paladin.LastTrack = GetTime()
                    ni.spell.cast(5502)
                end
            end
        end,
        ["Pechati mchenia"] = function()
            local c = #ni.unit.enemiesinrange("target", 5)
            local B = {53736, 31801}
            local C = nil
            for D = 1, #B do
                local E = B[D]
                if IsSpellKnown(E) then
                    C = E
                    break
                end
            end
            if c < 1 and ni.spell.available(C) and not ni.player.buff(C) and GetTime() - a.paladin.LastSeal > 3 then
                ni.spell.cast(C)
                a.paladin.LastSeal = GetTime()
                return true
            end
        end,
        ["Aoe pechat"] = function()
            local c = ni.unit.enemiesinrange("target", 5)
            if
                #c > 1 and ni.vars.combat.aoe and IsSpellKnown(20375) and ni.spell.available(20375) and
                    GetTime() - a.paladin.LastSeal > 3 and
                    not ni.player.buff(20375)
             then
                ni.spell.cast(20375)
                a.paladin.LastSeal = GetTime()
                return true
            end
        end,
        ["Righteous Fury"] = function()
            if not ni.player.buff(25780) and ni.spell.available(25780) then
                ni.spell.cast(25780)
                return true
            end
        end,
        ["Sacred Shield"] = function()
            local i, A = r("sacred")
            if A and not ni.player.buff(53601) and ni.spell.available(53601) then
                ni.spell.cast(53601, "player")
                return true
            end
        end,
        ["Combat specific Pause"] = function()
            if
                a.tankStop("target") or a.PlayerDebuffs("player") or UnitCanAttack("player", "target") == nil or
                    UnitAffectingCombat("target") == nil and ni.unit.isdummy("target") == nil and
                        UnitIsPlayer("target") == nil
             then
                return true
            end
        end,
        ["Healthstone (Use)"] = function()
            local F, A = r("healthstoneuse")
            local G = {36892, 36893, 36894}
            for D = 1, #G do
                if A and ni.player.hp() < F and ni.player.hasitem(G[D]) and ni.player.itemcd(G[D]) == 0 then
                    ni.player.useitem(G[D])
                    return true
                end
            end
        end,
        ["Heal Potions (Use)"] = function()
            local F, A = r("healpotionuse")
            local H = {33447, 43569, 40087, 41166, 40067}
            for D = 1, #H do
                if A and ni.player.hp() < F and ni.player.hasitem(H[D]) and ni.player.itemcd(H[D]) == 0 then
                    ni.player.useitem(H[D])
                    return true
                end
            end
        end,
        ["Mana Potions (Use)"] = function()
            local F, A = r("manapotionuse")
            local I = {33448, 43570, 40087, 42545, 39671}
            for D = 1, #I do
                if A and ni.player.power() < F and ni.player.hasitem(I[D]) and ni.player.itemcd(I[D]) == 0 then
                    ni.player.useitem(I[D])
                    return true
                end
            end
        end,
        ["Racial Stuff"] = function()
            local J = {33697, 20572, 33702, 26297}
            local K = {20594, 28880}
            if a.forsaken("player") and IsSpellKnown(7744) and ni.spell.available(7744) then
                ni.spell.cast(7744)
                return true
            end
            for D = 1, #J do
                if
                    (ni.vars.combat.cd or ni.unit.isboss("target")) and IsSpellKnown(J[D]) and ni.spell.available(J[D]) and
                        ni.spell.valid("target", 53595, true, true)
                 then
                    ni.spell.cast(J[D])
                    return true
                end
            end
            for D = 1, #K do
                if
                    ni.spell.valid("target", 53595, true, true) and ni.player.hp() < 20 and IsSpellKnown(K[D]) and
                        ni.spell.available(K[D])
                 then
                    ni.spell.cast(K[D])
                    return true
                end
            end
        end,
        ["Lay on Hands (Self)"] = function()
            local F, A = r("layon")
            local L = a.paladin.forb()
            if A and ni.player.hp() < F and not L and ni.spell.available(48788) then
                ni.spell.cast(48788)
                return true
            end
        end,
        ["Divine Protection"] = function()
            local F, A = r("divineprot")
            local L = a.paladin.forb()
            if A and ni.player.hp() < F and not L and ni.spell.available(498) and not ni.player.buff(498) then
                ni.spell.cast(498)
                return true
            end
        end,
        ["Divine Sacrifice"] = function()
            local i, A = r("sacrifice")
            local M = r("sacrificehp")
            local N = r("sacrificecount")
            if A and ni.player.hp() > 30 and ni.members.averageof(N) < M and ni.spell.available(64205) then
                ni.spell.cast(64205)
                return true
            end
        end,
        ["Divine Plea"] = function()
            local i, A = r("plea")
            if A and not ni.player.buff(54428) and ni.spell.available(54428) then
                ni.spell.cast(54428)
                return true
            end
        end,
        ["Hand of Reckoning"] = function()
            if
                ni.unit.exists("targettarget") and not UnitIsDeadOrGhost("targettarget") and
                    UnitAffectingCombat("player") and
                    (ni.unit.debuff("targettarget", 72410) or ni.unit.debuff("targettarget", 72411) or
                        ni.unit.threat("player", "target") < 2) and
                    ni.spell.available(62124) and
                    a.youInInstance() and
                    ni.spell.valid("target", 62124, false, true, true)
             then
                ni.spell.cast(62124)
                return true
            end
        end,
        ["Hand of Reckoning (Ally)"] = function()
            local i, A = r("hand")
            if ni.spell.available(62124) and (a.youInInstance() or A) then
                table.wipe(c)
                local c = ni.unit.enemiesinrange("player", 30)
                for D = 1, #c do
                    local O = c[D].guid
                    if
                        ni.unit.threat("player", O) ~= nil and ni.unit.threat("player", O) <= 2 and
                            UnitAffectingCombat(O) and
                            ni.spell.valid(O, 62124, false, true, true)
                     then
                        ni.spell.cast(62124, O)
                        return true
                    end
                end
            end
        end,
        ["Righteous Defence"] = function()
            local i, A = r("def")
            if (a.youInInstance() or A) and ni.spell.available(31789) then
                for D = 1, #ni.members do
                    if not UnitIsDeadOrGhost(ni.members[D].unit) then
                        local P = #ni.unit.unitstargeting(ni.members[D].guid)
                        if
                            P ~= nil and P >= 1 and not ni.members[D].istank and ni.unit.threat(ni.members[D].guid) >= 2 and
                                ni.spell.valid(ni.members[D].unit, 31789, false, true, true)
                         then
                            ni.spell.cast(31789, ni.members[D].unit)
                            return true
                        end
                    end
                end
            end
        end,
        ["Hand of Sacrifice (Member)"] = function()
            local F, A = r("handsacrifice")
            if A and #ni.members > 1 and ni.spell.available(6940) then
                if
                    ni.members[1].range and ni.members[1].hp < F and ni.player.hp() >= 65 and not ni.members[1].istank and
                        not a.paladin.HandActive(ni.members[1].unit) and
                        ni.spell.valid(ni.members[1].unit, 6940, false, true, true)
                 then
                    ni.spell.cast(6940, ni.members[1].unit)
                    return true
                end
            end
        end,
        ["Hand of Protection (Member)"] = function()
            local F, A = r("handofprot")
            if A and #ni.members > 1 and ni.spell.available(10278) then
                if
                    ni.members[1].range and ni.members[1].hp < F and not ni.members[1].istank and
                        ni.members[1].threat >= 2 and
                        ni.members[1].class ~= "DEATHKNIGHT" and
                        not (ni.members[1].class == "DRUID" and ni.unit.buff(ni.members[1].unit, 768)) and
                        ni.members[1].class ~= "HUNTER" and
                        ni.members[1].class ~= "PALADIN" and
                        ni.members[1].class ~= "ROGUE" and
                        ni.members[1].class ~= "WARRIOR" and
                        not a.paladin.HandActive(ni.members[1].unit) and
                        not ni.unit.debuff(ni.members[1].unit, 25771) and
                        ni.spell.valid(ni.members[1].unit, 10278, false, true, true)
                 then
                    ni.spell.cast(10278, ni.members[1].unit)
                    return true
                end
            end
        end,
        ["Hand of Salvation (Member)"] = function()
            local i, A = r("salva")
            if A and #ni.members > 1 and ni.spell.available(1038) then
                if
                    ni.members[1].threat >= 2 and not ni.members[1].istank and
                        not a.paladin.HandActive(ni.members[1].unit) and
                        ni.spell.valid(ni.members[1].unit, 1038, false, true, true)
                 then
                    ni.spell.cast(1038, ni.members[1].unit)
                    return true
                end
            end
        end,
        ["Avenging Wrath"] = function()
            if
                (ni.vars.CD or ni.unit.isboss("target")) and ni.spell.available(31884) and a.CDsaverTTD("target") and
                    ni.spell.valid("target", 35395)
             then
                ni.spell.cast(31884)
                return true
            end
        end,
        ["Hammer of Wrath"] = function()
            local i, A = r("wrath")
            if
                A and (ni.unit.hp("target") <= 20 or IsUsableSpell(GetSpellInfo(48806))) and ni.spell.available(48806) and
                    ni.spell.valid("target", 48806, true, true)
             then
                ni.spell.cast(48806, "target")
                return true
            end
        end,
        ["Holy Wrath"] = function()
            if ni.vars.combat.aoe and ni.spell.available(48817) and ni.spell.valid("target", 53595) then
                ni.spell.cast(48817, "target")
                return true
            end
        end,
        ["Consecration"] = function()
            local i, A = r("concentrat")
            local F = r("concentratmana")
            if A and ni.player.power() > F and ni.spell.available(48819) and ni.spell.valid("target", 53595) then
                ni.spell.cast(48819)
                return true
            end
        end,
        ["Avenger's Shield"] = function()
            if f() > 1 and ni.spell.available(48827) and ni.spell.valid("target", 48827, true, true) then
                ni.spell.cast(48827, "target")
                return true
            end
        end,
        ["Judgements(PRO)"] = function()
            local F, A = r("Jaga")
            if not A then
                if F == 0 then
                    return false
                end
                if F == 1 then
                    if
                        ni.spell.available(x.JudgmentOfWisdom) and IsUsableSpell(x.JudgmentOfWisdom) and
                            not ni.unit.debuff("target", x.JudgmentOfWisdom, "player") and
                            ni.spell.valid("target", x.JudgmentOfWisdom, false, true)
                     then
                        ni.spell.cast(x.JudgmentOfWisdom, "target")
                        return true
                    end
                end
                if F == 2 then
                    if
                        ni.spell.available(x.Jagaorg) and IsUsableSpell(x.Jagaorg) and
                            not ni.unit.debuff("target", x.Jagaorg, "player") and
                            ni.spell.valid("target", x.Jagaorg, false, true)
                     then
                        ni.spell.cast(x.Jagaorg, "target")
                        return true
                    end
                end
                if F == 3 then
                    if
                        ni.spell.available(x.Jagared) and IsUsableSpell(x.Jagared) and
                            not ni.unit.debuff("target", x.Jagared, "player") and
                            ni.spell.valid("target", x.Jagared, false, true)
                     then
                        ni.spell.cast(x.Jagared, "target")
                        return true
                    end
                end
            end
        end,
        ["Holy Shield"] = function()
            if not ni.player.buff(48952) and ni.spell.available(48952) and ni.spell.valid("target", 53595) then
                ni.spell.cast(48952, "target")
                return true
            end
        end,
        ["Hammer of the Righteous"] = function()
            if ni.spell.available(53595) and ni.spell.valid("target", 53595, true, true) then
                ni.spell.cast(53595, "target")
                return true
            end
        end,
        ["Hand of Freedom (Self)"] = function()
            local i, A = r("freedom")
            if
                A and ni.player.ismoving() and a.paladin.FreedomUse("player") and not a.paladin.HandActive("player") and
                    ni.spell.available(1044)
             then
                ni.spell.cast(1044, "player")
                return true
            end
        end,
        ["Cleanse (Self)"] = function()
            local i, A = r("cleans")
            if
                A and ni.player.debufftype("Magic|Disease|Poison") and ni.spell.available(4987) and
                    ni.healing.candispel("player") and
                    GetTime() - a.LastDispel > 1.5 and
                    ni.spell.valid("player", 4987, false, true, true)
             then
                ni.spell.cast(4987, "player")
                a.LastDispel = GetTime()
                return true
            end
        end,
        ["Shield of Righteousness"] = function()
            if ni.spell.available(61411) and ni.spell.valid("target", 61411, true, true) then
                ni.spell.cast(61411, "target")
                return true
            end
        end,
        ["Turn Evil (Auto Use)"] = function()
            local i, A = r("turn")
            if A and ni.unit.exists("target") and ni.spell.available(10326) and UnitCanAttack("player", "target") then
                table.wipe(c)
                c = ni.unit.enemiesinrange("player", 25)
                local Q = false
                for D = 1, #c do
                    local R = c[D].guid
                    if
                        (ni.unit.creaturetype(c[D].guid) == 3 or ni.unit.creaturetype(c[D].guid) == 6 or
                            ni.unit.aura(c[D].guid, 49039)) and
                            ni.unit.debuff(R, 10326, "player")
                     then
                        Q = true
                        break
                    end
                end
                if not Q then
                    for D = 1, #c do
                        local R = c[D].guid
                        if
                            (ni.unit.creaturetype(c[D].guid) == 3 or ni.unit.creaturetype(c[D].guid) == 6 or
                                ni.unit.aura(c[D].guid, 49039)) and
                                not ni.unit.isboss(R) and
                                not ni.unit.debuffs(R, "23920||35399||69056", "EXACT") and
                                not ni.unit.debuff(R, 10326, "player") and
                                ni.spell.valid(c[D].guid, 10326, false, true, true) and
                                GetTime() - a.paladin.LastTurn > 1.5
                         then
                            ni.spell.cast(10326, R)
                            a.paladin.LastTurn = GetTime()
                            return true
                        end
                    end
                end
            end
        end,
        ["Control (Member)"] = function()
            local i, A = r("control")
            if A and ni.spell.available(10308) then
                for D = 1, #ni.members do
                    local S = ni.members[D].unit
                    if
                        a.ControlMember(S) and not a.UnderControlMember(S) and
                            ni.spell.valid(S, 10308, false, true, true)
                     then
                        ni.spell.cast(10308, S)
                        return true
                    end
                end
            end
        end
    }
    ni.bootstrap.profile("Ppal", y, z, v, w)
else
    local y = {"Error"}
    local z = {["Error"] = function()
            ni.vars.profiles.enabled = false
            if d > 30300 then
                ni.frames.floatingtext:message("This profile is meant for WotLK 3.3.5a! Sorry!")
            elseif e < 80 then
                ni.frames.floatingtext:message("This profile is meant for level 80! Sorry!")
            elseif a == nil then
                ni.frames.floatingtext:message("Riot file is missing or corrupted!")
            end
        end}
    ni.bootstrap.profile("Ppal", y, z)
end
