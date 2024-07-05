local a = ni.utils.require("Riot") or ni.utils.require("Riot.enc")
local b = false
local c = {}
local d = select(4, GetBuildInfo())
local e = UnitLevel("player")
if d == 30300 and e == 80 and a then
    local function f(g, h, i)
        return "\124T" ..
            (select(3, GetSpellInfo(g)) or select(3, GetSpellInfo(24720))) ..
                ":" .. (i or 25) .. ":" .. (h or 25) .. "\124t"
    end
    local function j(k, h, i)
        return "\124T" ..
            (GetItemIcon(k) or select(3, GetSpellInfo(24720))) .. ":" .. (i or 25) .. ":" .. (h or 25) .. "\124t"
    end
    local l = {
        settingsfile = "Holy.json",
        {type = "title", text = "Holy Priest by |c0000CED1WH"},
        {type = "separator"},
        {type = "title", text = "|cffFFFF00Основные настйроки"},
        {type = "separator"},
        {type = "title", text = "Защита от страха"},
        {
            type = "dropdown",
            menu = {
                {selected = true, value = 1, text = ni.spell.icon(6346) .. "Защита от страха"},
                {selected = false, value = 2, text = ni.spell.icon(6346) .. "Защита от стараха (фокус)"},
                {selected = true, value = 3, text = "вручную"}
            },
            key = "fireward"
        },
        {
            type = "entry",
            text = ni.spell.icon(48161) .. "Авто бафы",
            tooltip = "Автоматическое обновление всех бафов",
            enabled = false,
            key = "Buffss"
        },
        {
            type = "entry",
            text = ni.spell.icon(48168) .. "Внутренний огонь",
            tooltip = "Автоматическое обновление внутреннего огня",
            enabled = false,
            key = "Fire"
        },
        {type = "separator"},
        {type = "page", number = 1, text = "|cff00C957Защитные настройки"},
        {type = "separator"},
        {
            type = "entry",
            text = ni.spell.icon(48173) .. "Молитва отчайния",
            tooltip = "Используйте заклинание, когда HP игрока < %",
            enabled = true,
            value = 25,
            key = "despplayer"
        },
        {
            type = "entry",
            text = j(36892) .. " Камень здоровья",
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
            text = j(33447) .. " Зелье здоровья",
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
            text = j(33448) .. " Зелье маны",
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
        {type = "page", number = 2, text = "|cff95f900Настройки кд и п.р"},
        {type = "separator"},
        {
            type = "entry",
            text = ni.spell.icon(10955) .. "Сковывание нежити(Автоматически)",
            tooltip = "Автоматическая проверка и использование заклинания на подходящих врагах",
            enabled = false,
            key = "shackundead"
        },
        {
            type = "entry",
            text = ni.spell.icon(47788) .. "Оберегающий дух",
            tooltip = "Используйте заклинание, когда |cff00D700HP|r участника < %",
            enabled = true,
            value = 20,
            key = "guard"
        },
        {
            type = "entry",
            text = ni.spell.icon(64843) .. "Внутреннее сосредоточение + Божественный гимн",
            tooltip = "Вкл/выкл",
            enabled = true,
            key = "innerhymn"
        },
        {
            type = "entry",
            text = ni.spell.icon(64843) .. "Внутреннее сосредоточение + Божественный гимн (Members HP)",
            tooltip = "Используйте заклинание, когда |cff00D700HP|r группы/рейда < %",
            value = 35,
            key = "innerhymnhp"
        },
        {
            type = "entry",
            text = ni.spell.icon(64843) .. "Внутреннее сосредоточение + Божественный гимн (Members Count)",
            tooltip = "Используйте заклинание, когда кол-во участников в отряде/рейде имеет низкий уровень здоровья",
            value = 9,
            key = "innerhymncount"
        },
        {type = "separator"},
        {type = "title", text = "Рассеивание"},
        {type = "separator"},
        {
            type = "entry",
            text = ni.spell.icon(988) .. "Рассеивание заклинаний (Member)",
            tooltip = "Автоматическое снятие дебаффов с участников",
            enabled = true,
            key = "dispelmagmemb"
        },
        {
            type = "entry",
            text = ni.spell.icon(552) .. "Устранение болезни (Member)",
            tooltip = "Автоматическое снятие дебаффов с участников",
            enabled = true,
            key = "abolishmb"
        },
        {type = "title", text = "|cFFFF4500Задержка для диспела|r"},
        {type = "input", enabled = true, value = 1, min = 0, max = 100, step = 1, width = 40, key = "DispelDelay"},
        {type = "separator"},
        {type = "page", number = 3, text = "|cff95f900Заклинания исцеления"},
        {type = "separator"},
        {
            type = "entry",
            text = ni.spell.icon(48545) .. "Хилить вне боя",
            tooltip = "Хилит вне боя по |cff00D700HP|r < %",
            enabled = true,
            value = 70,
            min = 15,
            max = 105,
            step = 1,
            width = 40,
            key = "noncombatheal"
        },
        {
            type = "entry",
            text = ni.spell.icon(48089) .. "Круг Исцеления",
            tooltip = "использует заклинание когда |cff00D700HP|r < %",
            enabled = true,
            value = 85,
            key = "circle"
        },
        {
            type = "entry",
            text = "Кол-во раненых",
            tooltip = "Использовать Круг Исцеления когда, количество раненых союзников",
            value = 4,
            min = 1,
            max = 4,
            step = 1,
            width = 40,
            key = "Cricleunit"
        },
        {
            type = "entry",
            text = ni.spell.icon(48068) .. "Обновление(All Members)",
            tooltip = "Использует заклинание когда |cff00D700HP|r < %",
            enabled = true,
            value = 101,
            key = "renewall"
        },
        {
            type = "entry",
            text = ni.spell.icon(48071) .. "Быстрое исцеление (мгновенка)",
            tooltip = "Использует заклинание по проку когда H|cff00D700HP|r < %",
            enabled = true,
            value = 50,
            key = "Flash"
        },
        {
            type = "entry",
            text = ni.spell.icon(48113) .. "Молитва восстановления",
            tooltip = "Использует заклинание когда участики  |cff00D700HP|r < %",
            enabled = true,
            value = 50,
            key = "molis"
        },
        {
            type = "entry",
            text = ni.spell.icon(48066) .. "Щиток",
            tooltip = "использует заклинание на игроке когда |cff00D700HP|r < %",
            enabled = true,
            value = 50,
            key = "Save"
        }
    }
    local function m(n)
        for o, p in ipairs(l) do
            if p.type == "entry" and p.key ~= nil and p.key == n then
                return p.value, p.enabled
            end
            if p.type == "dropdown" and p.key ~= nil and p.key == n then
                for q, r in pairs(p.menu) do
                    if r.selected then
                        return r.value
                    end
                end
            end
            if p.type == "input" and p.key ~= nil and p.key == n then
                return p.value
            end
        end
    end
    local function s()
        ni.GUI.AddFrame("Holy", l)
    end
    local function t()
        ni.GUI.DestroyFrame("Holy")
    end
    local u = {PlayerIsMoving = false, InCombat = false, Controled = false}
    local v = {Bloezn = GetSpellInfo(556), Magic = GetSpellInfo(988)}
    local w = {
        
        "cache",
        "Universal pause",
        "Inner Fire",
        "Prayer of Fortitude",
        "Prayer of Spirit",
        "Prayer of Shadow Protection",
        "Fear Ward",
        "Combat specific Pause",
        "Healthstone (Use)",
        "Heal Potions (Use)",
        "Mana Potions (Use)",
        "Shadowfiend",
        "Desperate Prayer",
        "Shackle Undead (Auto Use)",
        "Inner Focus",
        "Divine Hymn",
        "Circle of Healing",
        "Prayer of Mending",
        "Save",
        "Guardian Spirit",
        "Flash Heal",
        "Renew (All Members)",
        "Abolish Disease",
        "Dispel Magic"
    }
    local x, y = 0, 0
    local z, A, c = {}, {}, {}
    local B = {
        ["Window"] = function()
            if not deb then
                ni.frames.floatingtext:message("Holy priest By WH")
                print("|cffEE4000=======================================|r")
                print("|cffFFFF00Holy Priest by whoamiwow|r")
                print("|cff00C957v0.0.5 release|r")
                print("https://discord.gg/6wCgVRhQFs  ----- Wh Project")
                print("|cffEE4000=======================================|r")
                deb = true
            end
        end,
        ["Cache"] = function()
            if GetTime() - y > 100 then
                ni.utils.resetlasthardwareaction()
                y = GetTime()
            end
            u.InCombat = UnitAffectingCombat("player") or false
            u.PlayerIsMoving = ni.player.ismoving() or false
            u.Controled =
                ni.player.issilenced() or ni.player.isstunned() or ni.player.isconfused() or ni.player.isfleeing() or
                false
            if u.InCombat and GetTime() - x >= 15 then
                wipe(z)
                wipe(A)
                wipe(c)
                x = GetTime()
            end
            ni.vars.debug = select(2, m("Debug"))
        end,
        ["Save"] = function()
            local C, D = m("Save")
            if D then
                if
                    ni.spell.available(48066) and a.spellusablesilence(48066) and ni.player.hp() < C and
                        ni.spell.valid("player", 48066, false, true, true)
                 then
                    ni.spell.cast(48066, "player")
                    return true
                end
            end
        end,
        ["Universal pause"] = function()
            if a.UniPause() or a.PlayerDebuffs("player") then
                return true
            end
            ni.vars.debug = select(2, m("Debug"))
        end,
        ["Inner Fire"] = function()
            local C, D = m("Fire")
            if not D then
                return false
            end
            if not ni.player.buff(48168) and not UnitAffectingCombat("player") and ni.spell.available(48168) then
                ni.spell.cast(48168)
                return true
            end
        end,
        ["Prayer of Fortitude"] = function()
            local C, D = m("Buffss")
            if not D then
                return false
            end
            if not UnitAffectingCombat("player") then
                if ni.player.buff(48162) or not a.spellusablesilence(GetSpellInfo(48162)) then
                    return false
                end
                if ni.spell.available(48162) then
                    ni.spell.cast(48162)
                    return true
                end
            end
        end,
        ["Prayer of Spirit"] = function()
            local C, D = m("Buffss")
            if not D then
                return false
            end
            if not UnitAffectingCombat("player") then
                if ni.player.buffs("48074||57567") or not a.spellusablesilence(GetSpellInfo(48074)) then
                    return false
                end
                if ni.spell.available(48074) then
                    ni.spell.cast(48074)
                    return true
                end
            end
        end,
        ["Prayer of Shadow Protection"] = function()
            local C, D = m("Buffss")
            if not D then
                return false
            end
            if not UnitAffectingCombat("player") then
                if ni.player.buff(48170) or not a.spellusablesilence(GetSpellInfo(48170)) then
                    return false
                end
                if ni.spell.available(48170) then
                    ni.spell.cast(48170)
                    return true
                end
            end
        end,
        ["Fear Ward"] = function()
            local C = m("fireward")
            if C == 1 then
                if not ni.player.buff(6346) and ni.spell.available(6346) then
                    ni.spell.cast(6346, "player")
                    return true
                end
                if C == 2 then
                    if
                        ni.unit.exists("focus") and not ni.unit.buff("focus", 6346) and ni.spell.available(6346) and
                            ni.spell.valid("focus", 6346, false, true, true)
                     then
                        ni.spell.cast(6346, "focus")
                        return true
                    end
                end
                if C == 3 then
                end
            end
        end,
        ["Non Combat Healing"] = function()
            local C, D = m("noncombatheal")
            local z = ni.members[1]
            if D and not UnitAffectingCombat("player") and ni.spell.available(48068) and ni.spell.available(48071) then
                if
                    z:hp() <= C and not ni.unit.buff(ni.members[1].unit, 48068, "player") and
                        z:valid(48068, false, true, true)
                 then
                    ni.spell.cast(48068, z.unit)
                    return true
                end
                if z:hp() <= C and not ni.player.ismoving() and z:valid(48071, false, true, true) then
                    ni.spell.cast(48071, z.unit)
                    return true
                end
            end
        end,
        ["Combat specific Pause"] = function()
            if UnitAffectingCombat("player") then
                return false
            end
            for E = 1, #ni.members do
                if UnitAffectingCombat(ni.members[E].unit) then
                    return false
                end
            end
            return true
        end,
        ["Heal Potions (Use)"] = function()
            local C, D = m("healpotionuse")
            local F = {43569, 41166, 40087, 39671, 33934, 33447, 28100, 22829, 13446, 4596, 3928, 1710, 929, 858, 118}
            if D and ni.player.hp() < C and not cache.Controled and cache.InCombat then
                for E = 1, #F do
                    local G = F[E]
                    if ni.player.hasitem(G) and IsUsableItem(G) and ni.player.itemcd(G) == 0 then
                        ni.player.useitem(G)
                        return true
                    end
                end
            end
        end,
        ["Healthstone (Use)"] = function()
            local C, D = m("healthstoneuse")
            local H = {
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
            if D and ni.player.hp() < C and not u.Controled and u.InCombat then
                for E = 1, #H do
                    local G = H[E]
                    if ni.player.hasitem(G) and IsUsableItem(G) and ni.player.itemcd(G) == 0 then
                        ni.player.useitem(G)
                        return true
                    end
                end
            end
        end,
        ["Mana Potions (Use)"] = function()
            local C, D = m("manapotionuse")
            local I = {43570, 42545, 40087, 40067, 33935, 33448, 28101, 22832, 13444, 13443, 6149, 3827, 3385, 2455}
            if D and ni.player.power(0) < C and not cache.Controled and cache.InCombat then
                for E = 1, #I do
                    local G = I[E]
                    if ni.player.hasitem(G) and IsUsableItem(G) and ni.player.itemcd(G) == 0 then
                        ni.player.useitem(G)
                        return true
                    end
                end
            end
        end,
        ["Desperate Prayer"] = function()
            local C, D = m("despplayer")
            if D and ni.player.hp() < C and IsSpellKnown(48173) and ni.spell.available(48173) then
                ni.spell.cast(48173)
                return true
            end
        end,
        ["Shadowfiend"] = function()
            if ni.player.power() < 40 and ni.spell.available(34433) then
                ni.spell.cast(34433, "target")
                return true
            end
        end,
        ["Shackle Undead (Auto Use)"] = function()
            local J, D = m("shackundead")
            if D and ni.unit.exists("target") and ni.spell.available(10955) and UnitCanAttack("player", "target") then
                table.wipe(c)
                c = ni.unit.enemiesinrange("player", 25)
                local K = false
                for E = 1, #c do
                    local L = c[E].guid
                    if
                        (ni.unit.creaturetype(c[E].guid) == 6 or ni.unit.aura(c[E].guid, 49039)) and
                            ni.unit.debuff(L, 10955, "player")
                     then
                        K = true
                        break
                    end
                end
                if not K then
                    for E = 1, #c do
                        local L = c[E].guid
                        if
                            (ni.unit.creaturetype(c[E].guid) == 6 or ni.unit.aura(c[E].guid, 49039)) and
                                not ni.unit.isboss(L) and
                                not ni.unit.debuffs(L, "23920||35399||69056", "EXACT") and
                                not ni.unit.debuff(L, 10955, "player") and
                                ni.spell.valid(c[E].guid, 10955, false, true, true) and
                                GetTime() - a.priest.LastShackle > 1.5
                         then
                            ni.spell.cast(10955, L)
                            a.priest.LastShackle = GetTime()
                            return true
                        end
                    end
                end
            end
        end,
        ["Inner Focus"] = function()
            local J, D = m("innerhymn")
            local M = m("innerhymnhp")
            local N = m("innerhymncount")
            if
                D and ni.members.averageof(N) < M and ni.spell.available(14751) and ni.spell.available(48066) and
                    ni.spell.available(64843) and
                    not ni.unit.debuff("player", 6788) and
                    not ni.unit.buff("player", 48066, "player")
             then
                ni.spell.cast(48066, "player")
                ni.spell.cast(14751)
                return true
            end
        end,
        ["Divine Hymn"] = function()
            local J, D = m("innerhymn")
            if
                D and ni.player.buff(14751) and not ni.player.ismoving() and ni.spell.available(64843) and
                    UnitChannelInfo("player") == nil
             then
                ni.spell.cast(64843)
                return true
            end
        end,
        ["Prayer of Mending"] = function()
            local C, D = m("molis")
            if D then
                if ni.spell.available(48113) then
                    if a.spellusablesilence(48113) then
                        for E = 1, #ni.members do
                            local z = ni.members[E]
                            if z:hp() <= C and not z:buff(48113, "player") and z:valid(48113, false, true, true) then
                                ni.spell.cast(48113, z.unit)
                                return true
                            end
                        end
                    end
                end
            end
        end,
        ["Guardian Spirit"] = function()
            local C, D = m("guard")
            if D and ni.spell.available(47788) then
                for E = 1, #ni.members do
                    local z = ni.members[E]
                    if z:hp() <= C and z:valid(47788, false, true, true) then
                        ni.spell.cast(47788, z.unit)
                        return true
                    end
                end
            end
        end,
        ["Circle of Healing"] = function()
            local C, D = m("circle")
            local O = m("Cricleunit")
            local P = ni.members.inrangebelow("player", 15, C)
            if not D or not a.spellusablesilence(48089) then
                return false
            end
            if #P >= O then
                if not ni.vars.combat.aoe then
                    for E = 1, #ni.members do
                        local z = ni.members[E]
                        if z:hp() <= C and z:valid(48089, false, true) then
                            ni.spell.cast(48089, z.unit)
                            return true
                        end
                    end
                end
            end
        end,
        ["Renew (All Members)"] = function()
            local C, D = m("renewall")
            if D and ni.spell.available(48068) then
                for E = 1, #ni.members do
                    local z = ni.members[E]
                    if
                        z:hp() <= C and a.spellusablesilence(48068) and not z:buff(48068, "player") and
                            z:valid(48068, false, true, true)
                     then
                        ni.spell.cast(48068, z.unit)
                        return true
                    end
                end
            end
        end,
        ["Abolish Disease (Member)"] = function()
            local J, D = m("abolishmb")
            local Q = m("DispelDelay")
            if D then
                if a.spellusablesilence(v.Bloezn) then
                    for E = 1, #ni.members.sort() do
                        local z = ni.members[E]
                        if z:debufftype("Disease") and z:dispel() and z:valid(v.Bloezn, false, true) then
                            ni.spell.delaycast(v.Bloezn, z.unit, Q)
                            return true
                        end
                    end
                end
            end
        end,
        ["Dispel Magic (Member)"] = function()
            local J, D = m("dispelmagmemb")
            local Q = m("DispelDelay")
            if D then
                if a.spellusablesilence(v.Magic) then
                    for E = 1, #ni.members.sort() do
                        local z = ni.members[E]
                        if z:debufftype("Magic") and z:dispel() and z:valid(v.Magic, false, true) then
                            ni.spell.delaycast(v.Magic, z.unit, Q)
                            return true
                        end
                    end
                end
            end
        end,
        ["Flash Heal"] = function()
            local C, D = m("Flash")
            if D and ni.spell.available(48071) and ni.player.buff(33151) and not ni.player.ismoving() then
                for E = 1, #ni.members do
                    local z = ni.members[E]
                    if z:hp() <= C and z:valid(48071, false, true, true) then
                        ni.spell.cast(48071, z.unit)
                        return true
                    end
                end
            end
        end
    }
    ni.bootstrap.profile("Holy", w, B, s, t)
else
    local w = {"Error"}
    local B = {["Error"] = function()
            ni.vars.profiles.enabled = false
            if d > 30300 then
                ni.frames.floatingtext:message("This profile is meant for WotLK 3.3.5a! Sorry!")
            elseif e < 80 then
                ni.frames.floatingtext:message("This profile is meant for level 80! Sorry!")
            elseif a == nil then
                ni.frames.floatingtext:message("Riot file is missing or corrupted!")
            end
        end}
    ni.bootstrap.profile("Holy", w, B)
end
