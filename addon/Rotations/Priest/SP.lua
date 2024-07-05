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
        settingsfile = "sp.json",
        {type = "title", text = "Shadow priest by |c0000CED1WH"},
        {type = "separator"},
        {type = "title", text = "|cffFFFF00Основные настройки"},
        {type = "separator"},
        {
            type = "entry",
            text = f(15473) .. "Автомачиеская форма",
            tooltip = "Использовать автоматически шадоу форму",
            enabled = true,
            key = "autoform"
        },
        {type = "separator"},
        {type = "title", text = ni.spell.icon(6346) .. "|cFFFF4500Защита от страха|r"},
        {
            type = "dropdown",
            menu = {
                {selected = true, value = 1, text = ni.spell.icon(6346) .. "На себя"},
                {selected = false, value = 2, text = ni.spell.icon(6346) .. "По фокусу"},
                {selected = false, value = 0, text = "В ручную"}
            },
            key = "Fireward"
        },
        {
            type = "entry",
            text = f(15487) .. "Сбив каста",
            tooltip = "Автоматическое определение и [Прерывание]\nвсех прирываемых заклинаний",
            enabled = true,
            key = "autointerrupt"
        },
        {type = "separator"},
        {type = "page", number = 1, text = "|cff00C957Защитные настройки"},
        {type = "separator"},
        {type = "entry", text = f(47585) .. "Слияние с тьмой", tooltip = "Enable spell", enabled = true, key = "disp"},
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
        {type = "page", number = 2, text = "|cffEE4000Rotation Settings"},
        {type = "separator"},
        {
            type = "entry",
            text = f(10955) .. "Сковывание нежити (Автом)",
            tooltip = "Автоматическая проверка и использование заклинания на нежити.",
            enabled = false,
            key = "shackundead"
        },
        {
            type = "entry",
            text = f(605) .. "Автомачиески контроль (союзники)",
            tooltip = "Автоматическая проверка и контроль участника, если он находится под контролем разума или т.д.",
            enabled = true,
            key = "control"
        },
        {type = "separator"},
        {type = "title", text = "Диспел"},
        {type = "separator"},
        {
            type = "entry",
            text = f(988) .. "Рассеивание заклинаний(себя)",
            tooltip = "Автоматическое снятие дебаффов с игрока",
            enabled = false,
            key = "dispelmag"
        },
        {
            type = "entry",
            text = f(988) .. "Рассеивание заклинаний(союз.)",
            tooltip = "Автоматическое снятие дебаффов с участников",
            enabled = false,
            key = "dispelmagmemb"
        },
        {
            type = "entry",
            text = f(552) .. "Устрание болезни(себя)",
            tooltip = "Автоматическое снятие дебаффов с игрока",
            enabled = false,
            key = "abolish"
        },
        {
            type = "entry",
            text = f(552) .. "Устрание болезни (союз.)",
            tooltip = "Автоматическое снятие дебаффов с участников",
            enabled = false,
            key = "abolishmb"
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
        ni.GUI.AddFrame("sp", l)
    end
    local function t()
        ni.GUI.DestroyFrame("sp")
    end
    local u = {
        
        "AutoTarget",
        "Universal pause",
        "Inner Fire",
        "Prayer of Fortitude",
        "Prayer of Spirit",
        "Prayer of Shadow Protection",
        "Fear Ward",
        "Vampiric Embrace",
        "Shadowform",
        "Combat specific Pause",
        "Pet Attack/Follow",
        "Healthstone (Use)",
        "Heal Potions (Use)",
        "Mana Potions (Use)",
        "Racial Stuff",
        "Use enginer gloves",
        "Trinkets",
        "Silence (Interrupt)",
        "Fade",
        "Shackle Undead (Auto Use)",
        "Control (Member)",
        "Dispersion",
        "Shadowfiend",
        "Shadow Word: Death",
        "Mind Sear",
        "Shadow Word: Pain",
        "SWP AoE",
        "Dispel Magic (Self)",
        "Abolish Disease (Self)",
        "Dispel Magic (Member)",
        "Abolish Disease (Member)",
        "Vampiric Touch",
        "Devouring Plague",
        "Mind Flay"
    }
    local v = {
        ["Window"] = function()
            if not deb then
                ni.frames.floatingtext:message("Shadow Priset By WH")
                print("|cffEE4000=======================================|r")
                print("|cffFFFF00Shadow priest by whoamiwow|r")
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
            ni.vars.debug = select(2, m("Debug"))
        end,
        ["AutoTarget"] = function()
            if
                UnitAffectingCombat("player") and
                    (ni.unit.exists("target") and UnitIsDeadOrGhost("target") and not UnitCanAttack("player", "target") or
                        not ni.unit.exists("target"))
             then
                ni.player.runtext("/targetenemy")
            end
        end,
        ["Inner Fire"] = function()
            if not ni.player.buff(48168) and ni.spell.available(48168) then
                ni.spell.cast(48168)
                return true
            end
        end,
        ["Prayer of Fortitude"] = function()
            if ni.player.buff(48162) or not IsUsableSpell(GetSpellInfo(48162)) then
                return false
            end
            if ni.spell.available(48162) then
                ni.spell.cast(48162)
                return true
            end
        end,
        ["Prayer of Spirit"] = function()
            if ni.player.buffs("48074||57567") or not IsUsableSpell(GetSpellInfo(48074)) then
                return false
            end
            if ni.spell.available(48074) then
                ni.spell.cast(48074)
                return true
            end
        end,
        ["Prayer of Shadow Protection"] = function()
            if ni.player.buff(48170) or not IsUsableSpell(GetSpellInfo(48170)) then
                return false
            end
            if ni.spell.available(48170) then
                ni.spell.cast(48170)
                return true
            end
        end,
        ["Fear Ward"] = function()
            local w, x = m("Fireward")
            if not x then
                if w == 0 then
                    return false
                end
                if w == 1 then
                    if not ni.player.buff(6346) and ni.spell.available(6346) then
                        ni.spell.cast(6346, "player")
                        return true
                    end
                end
                if w == 2 then
                    if
                        not ni.unit.exists("focus") and not ni.unit.buff("focus", 6346) and ni.spell.available(6346) and
                            ni.spell.valid("focus", 6346, false, true, true)
                     then
                        ni.spell.cast(6346, "focus")
                        return true
                    end
                end
            end
        end,
        ["Vampiric Embrace"] = function()
            if not ni.player.buff(15286) and ni.spell.available(15286) then
                ni.spell.cast(15286)
                return true
            end
        end,
        ["Shadowform"] = function()
            local y, x = m("autoform")
            if x and not ni.player.buff(15473) and ni.spell.available(15473) then
                ni.spell.cast(15473)
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
            if
                a.casterStop("target") or a.PlayerDebuffs("player") or UnitCanAttack("player", "target") == nil or
                    UnitAffectingCombat("target") == nil and ni.unit.isdummy("target") == nil and
                        UnitIsPlayer("target") == nil
             then
                return true
            end
        end,
        ["Healthstone (Use)"] = function()
            local w, x = m("healthstoneuse")
            local z = {36892, 36893, 36894}
            for A = 1, #z do
                if x and ni.player.hp() < w and ni.player.hasitem(z[A]) and ni.player.itemcd(z[A]) == 0 then
                    ni.player.useitem(z[A])
                    return true
                end
            end
        end,
        ["Heal Potions (Use)"] = function()
            local w, x = m("healpotionuse")
            local B = {33447, 43569, 40087, 41166, 40067}
            for A = 1, #B do
                if x and ni.player.hp() < w and ni.player.hasitem(B[A]) and ni.player.itemcd(B[A]) == 0 then
                    ni.player.useitem(B[A])
                    return true
                end
            end
        end,
        ["Mana Potions (Use)"] = function()
            local w, x = m("manapotionuse")
            local C = {33448, 43570, 40087, 42545, 39671}
            for A = 1, #C do
                if x and ni.player.power() < w and ni.player.hasitem(C[A]) and ni.player.itemcd(C[A]) == 0 then
                    ni.player.useitem(C[A])
                    return true
                end
            end
        end,
        ["Racial Stuff"] = function()
            local D = {33697, 20572, 33702, 26297}
            local E = {20594, 28880}
            if a.forsaken("player") and IsSpellKnown(7744) and ni.spell.available(7744) then
                ni.spell.cast(7744)
                return true
            end
            for A = 1, #D do
                if
                    (ni.vars.combat.cd or ni.unit.isboss("target")) and IsSpellKnown(D[A]) and ni.spell.available(D[A]) and
                        a.CDsaverTTD("target") and
                        ni.spell.valid("target", 48125, true, true)
                 then
                    ni.spell.cast(D[A])
                    return true
                end
            end
            for A = 1, #E do
                if
                    ni.spell.valid("target", 48125, true, true) and ni.player.hp() < 20 and IsSpellKnown(E[A]) and
                        ni.spell.available(E[A])
                 then
                    ni.spell.cast(E[A])
                    return true
                end
            end
        end,
        ["Use enginer gloves"] = function()
            if
                ni.player.slotcastable(10) and ni.player.slotcd(10) == 0 and a.CDsaverTTD("target") and
                    (ni.vars.combat.cd or ni.unit.isboss("target")) and
                    ni.spell.valid("target", 48125)
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
                    ni.spell.valid("target", 48125)
             then
                ni.player.useinventoryitem(13)
            else
                if
                    (ni.vars.combat.cd or ni.unit.isboss("target")) and ni.player.slotcastable(14) and
                        ni.player.slotcd(14) == 0 and
                        a.CDsaverTTD("target") and
                        ni.spell.valid("target", 48125)
                 then
                    ni.player.useinventoryitem(14)
                    return true
                end
            end
        end,
        ["Silence (Interrupt)"] = function()
            local y, x = m("autointerrupt")
            if
                x and ni.spell.shouldinterrupt("target") and ni.spell.available(15487) and
                    GetTime() - a.LastInterrupt > 9 and
                    ni.spell.valid("target", 15487, true, true)
             then
                ni.spell.castinterrupt("target")
                a.LastInterrupt = GetTime()
                return true
            end
        end,
        ["Fade"] = function()
            if #ni.members > 1 and ni.unit.threat("player") >= 2 and not ni.player.buff(586) and ni.spell.available(586) then
                ni.spell.cast(586)
                return true
            end
        end,
        ["Dispersion"] = function()
            if (ni.player.power() < 20 or ni.player.hp() < 20) and ni.spell.available(47585) then
                ni.spell.cast(47585)
                return true
            end
        end,
        ["Shadowfiend"] = function()
            if (ni.vars.combat.cd or ni.unit.isboss("target")) and a.CDsaverTTD("target") and ni.spell.available(34433) then
                ni.spell.cast(34433, "target")
                return true
            end
        end,
        ["Shadow Word: Death"] = function()
            if
                ni.unit.hp("target") <= 35 and ni.spell.available(48158) and
                    ni.spell.valid("target", 48158, false, true, true)
             then
                ni.spell.cast(48158, "target")
                return true
            end
        end,
        ["Mind Sear"] = function()
            if ni.vars.combat.aoe and ni.spell.available(53023) and not ni.player.ismoving() then
                ni.spell.cast(53023, "target")
                return true
            end
        end,
        ["Shadow Word: Pain"] = function()
            local F = a.priest.SWP()
            local G, y, y, H = ni.player.buff(15258)
            if
                not F and G and H == 5 and ni.spell.available(48125) and
                    ni.spell.valid("target", 48125, false, true, true) and
                    GetTime() - a.priest.LastSWP > 1
             then
                ni.spell.cast(48125, "target")
                a.priest.LastSWP = GetTime()
                return true
            end
        end,
        ["SWP AoE"] = function()
            if
                ni.rotation.custommod() and ni.unit.exists("target") and ni.spell.available(48125) and
                    UnitCanAttack("player", "target")
             then
                table.wipe(c)
                c = ni.unit.enemiesinrange("target", 15)
                for A = 1, #c do
                    local I = c[A].guid
                    if
                        ni.unit.creaturetype(c[A].guid) ~= 8 and ni.unit.creaturetype(c[A].guid) ~= 11 and
                            not ni.unit.debuffs(I, "23920||35399||69056||10955", "EXACT") and
                            not ni.unit.debuff(I, 48125, "player") and
                            ni.spell.valid(c[A].guid, 48125, false, true, true)
                     then
                        ni.spell.cast(48125, I)
                        return true
                    end
                end
            end
        end,
        ["Shackle Undead (Auto Use)"] = function()
            local y, x = m("shackundead")
            if x and ni.unit.exists("target") and ni.spell.available(10955) and UnitCanAttack("player", "target") then
                table.wipe(c)
                c = ni.unit.enemiesinrange("player", 25)
                local J = false
                for A = 1, #c do
                    local I = c[A].guid
                    if
                        (ni.unit.creaturetype(c[A].guid) == 6 or ni.unit.aura(c[A].guid, 49039)) and
                            ni.unit.debuff(I, 10955, "player")
                     then
                        J = true
                        break
                    end
                end
                if not J then
                    for A = 1, #c do
                        local I = c[A].guid
                        if
                            (ni.unit.creaturetype(c[A].guid) == 6 or ni.unit.aura(c[A].guid, 49039)) and
                                not ni.unit.isboss(I) and
                                not ni.unit.debuffs(I, "23920||35399||69056", "EXACT") and
                                not ni.unit.debuff(I, 10955, "player") and
                                ni.spell.valid(c[A].guid, 10955, false, true, true) and
                                GetTime() - a.priest.LastShackle > 1.5
                         then
                            ni.spell.cast(10955, I)
                            a.priest.LastShackle = GetTime()
                            return true
                        end
                    end
                end
            end
        end,
        ["Vampiric Touch"] = function()
            if
                not ni.player.ismoving() and
                    ni.unit.debuffremaining("target", 48160, "player") < ni.spell.casttime(48160) and
                    ni.spell.available(48160) and
                    ni.spell.valid("target", 48160, false, true, true) and
                    GetTime() - a.priest.LastVamp > 2
             then
                ni.spell.cast(48160, "target")
                a.priest.LastVamp = GetTime()
                return true
            end
        end,
        ["Devouring Plague"] = function()
            if
                ni.spell.available(48300) and ni.unit.debuffremaining("target", 48300, "player") < 2.7 and
                    ni.spell.valid("target", 48300, false, true, true)
             then
                ni.spell.cast(48300, "target")
                return true
            end
        end,
        ["Mind Blast"] = function()
            if not ni.player.ismoving() and ni.spell.available(48127) and ni.spell.valid("target", 48127, true, true) then
                ni.spell.cast(48127, "target")
                return true
            end
        end,
        ["Mind Flay"] = function()
            if
                ni.spell.cd(48127) and not ni.player.ismoving() and ni.spell.available(48156) and
                    ni.spell.valid("target", 48127, true, true)
             then
                ni.spell.cast(48156, "target")
                return true
            end
        end,
        ["Dispel Magic (Self)"] = function()
            local y, x = m("dispelmag")
            if
                x and ni.unit.debufftype("player", "Magic") and ni.spell.available(988) and
                    ni.healing.candispel("player") and
                    GetTime() - a.LastDispel > 1.2 and
                    ni.spell.valid("player", 988, false, true, true)
             then
                ni.spell.cast(988, "player")
                a.LastDispel = GetTime()
                return true
            end
        end,
        ["Dispel Magic (Member)"] = function()
            local y, x = m("dispelmagmemb")
            if x and ni.spell.available(988) then
                for A = 1, #ni.members do
                    if
                        ni.unit.debufftype(ni.members[A].unit, "Magic") and ni.healing.candispel(ni.members[A].unit) and
                            GetTime() - a.LastDispel > 1.2 and
                            ni.spell.valid(ni.members[A].unit, 988, false, true, true)
                     then
                        ni.spell.cast(988, ni.members[A].unit)
                        a.LastDispel = GetTime()
                        return true
                    end
                end
            end
        end,
        ["Abolish Disease (Self)"] = function()
            local y, x = m("abolish")
            if
                x and ni.unit.debufftype("player", "Disease") and ni.spell.available(552) and
                    ni.healing.candispel("player") and
                    GetTime() - a.LastDispel > 1.2 and
                    not ni.unit.buff("player", 552) and
                    ni.spell.valid("player", 552, false, true, true)
             then
                ni.spell.cast(552, "player")
                a.LastDispel = GetTime()
                return true
            end
        end,
        ["Abolish Disease (Member)"] = function()
            local y, x = m("abolishmb")
            if x and ni.spell.available(552) then
                for A = 1, #ni.members do
                    if
                        ni.unit.debufftype(ni.members[A].unit, "Disease") and ni.healing.candispel(ni.members[A].unit) and
                            GetTime() - a.LastDispel > 1.2 and
                            not ni.unit.buff(ni.members[A].unit, 552) and
                            ni.spell.valid(ni.members[A].unit, 552, false, true, true)
                     then
                        ni.spell.cast(552, ni.members[A].unit)
                        a.LastDispel = GetTime()
                        return true
                    end
                end
            end
        end,
        ["Control (Member)"] = function()
            local y, x = m("control")
            if x and ni.spell.available(64044) then
                for A = 1, #ni.members do
                    local K = ni.members[A].unit
                    if a.ControlMember(K) and not a.UnderControlMember(K) and ni.spell.valid(K, 64044, true, true, true) then
                        ni.spell.cast(64044, K)
                        return true
                    end
                end
            end
        end
    }
    ni.bootstrap.profile("sp", u, v, s, t)
else
    local u = {"Error"}
    local v = {["Error"] = function()
            ni.vars.profiles.enabled = false
            if d > 30300 then
                ni.frames.floatingtext:message("This profile is meant for WotLK 3.3.5a! Sorry!")
            elseif e < 80 then
                ni.frames.floatingtext:message("This profile is meant for level 80! Sorry!")
            elseif a == nil then
                ni.frames.floatingtext:message("Riot file is missing or corrupted!")
            end
        end}
    ni.bootstrap.profile("sp", u, v)
end
