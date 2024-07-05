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
        settingsfile = "dc.json",
        {type = "title", text = "Dc Priest autdor by |c0000CED1Who am i"},
        {type = "separator"},
        {type = "title", text = "|cffFFFF00основные настройки"},
        {type = "separator"},
        {
            type = "entry",
            text = f(48173) .. "Молитва отчаяния",
            tooltip = "юзаем если HP < %",
            enabled = true,
            value = 25,
            key = "despplayer"
        },
        {
            type = "entry",
            text = f(33206) .. "Зубы",
            tooltip = "юзаем на себя если HP < %",
            enabled = true,
            value = 20,
            key = "painsupp"
        },
        {type = "separator"},
        {type = "title", text = "|cff95f900Щиты"},
        {type = "separator"},
        {
            type = "entry",
            text = f(48066) .. "спам щитов",
            tooltip = "постоянно спамим щиты",
            enabled = false,
            key = "pwsbeforecombat"
        },
        {type = "separator"}
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
        ni.GUI.AddFrame("Dc", l)
    end
    local function t()
        ni.GUI.DestroyFrame("Dc")
    end
    local u = {
        
        "Universal pause",
        "Divine Hymn",
        "Inner Fire",
        "Prayer of Fortitude",
        "Prayer of Spirit",
        "Prayer of Shadow Protection",
        "Racial Stuff",
        "Desperate Prayer",
        "Pain Suppression",
        "Prayer of Mending",
        "Power Word: Shield (Before Combat)",
        "Combat specific Pause",
        "Power Word: Shield (Emergency)",
        "Power Word: Shield (All)",
        "Shadowfiend"
    }
    local v = {
        ["Universal pause"] = function()
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
        ["Inner Fire"] = function()
            if not ni.player.buff(48168) and not ni.player.buff(27827) and ni.spell.available(48168) then
                ni.spell.cast(48168)
                return true
            end
        end,
        ["Prayer of Fortitude"] = function()
            if ni.player.buff(48162) and not ni.player.buff(27827) or not IsUsableSpell(GetSpellInfo(48162)) then
                return false
            end
            if ni.spell.available(48162) then
                ni.spell.cast(48162)
                return true
            end
        end,
        ["Prayer of Spirit"] = function()
            if ni.player.buffs("48074||57567") and not ni.player.buff(27827) or not IsUsableSpell(GetSpellInfo(48074)) then
                return false
            end
            if ni.spell.available(48074) then
                ni.spell.cast(48074)
                return true
            end
        end,
        ["Prayer of Shadow Protection"] = function()
            if ni.player.buff(48170) and not ni.player.buff(27827) or not IsUsableSpell(GetSpellInfo(48170)) then
                return false
            end
            if ni.spell.available(48170) then
                ni.spell.cast(48170)
                return true
            end
        end,
        ["Power Word: Shield (Before Combat)"] = function()
            local w, x = m("pwsbeforecombat")
            if x and ni.spell.available(48066) and UnitAffectingCombat("player") == nil then
                for y = 1, #ni.members do
                    local z = ni.members[y]
                    if ni.members[y].range and not UnitIsDeadOrGhost(z.unit) then
                        local A, w, w, w, w, w, B = ni.unit.buff(z.unit, 48066, "player")
                        local C = ni.unit.debuff(z.unit, 6788)
                        if
                            z.hp() <= 100 and not C and not (A or A and B - GetTime() < 0.7) and
                                z:valid(48066, false, true, true)
                         then
                            ni.spell.cast(48066, z.unit)
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
            for y = 1, #ni.members do
                if UnitAffectingCombat(ni.members[y].unit) then
                    return false
                end
            end
            return true
        end,
        ["Racial Stuff"] = function()
            local D = {33697, 20572, 33702, 26297}
            local E = {20594, 28880}
            if ni.unit.isfleeing("player") and a.spellisknown(7744) and ni.spell.available(7744) then
                ni.spell.cast(7744)
                return true
            end
            for y = 1, #D do
                local F = D[y]
                if
                    (ni.vars.combat.cd or ni.unit.isboss("target")) and a.spellisknown(F) and ni.spell.available(F) and
                        ni.spell.valid("target", 49238, true, true)
                 then
                    ni.spell.cast(F)
                    return true
                end
            end
            for y = 1, #E do
                local G = E[y]
                if
                    ni.spell.valid("target", 49238, true, true) and ni.player.hp() < 20 and a.spellisknown(G) and
                        ni.spell.available(G)
                 then
                    ni.spell.cast(G)
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
        ["Desperate Prayer"] = function()
            local H, x = m("despplayer")
            if x and ni.player.hp() < H and a.spellisknown(48173) and ni.spell.available(48173) then
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
        ["Pain Suppression"] = function()
            local H, x = m("painsupp")
            if x then
                if ni.player.hp() <= H and ni.spell.available(33206) then
                    ni.spell.cast(33206)
                    return true
                end
            end
        end,
        ["Power Word: Shield (Emergency)"] = function()
            if ni.spell.available(48066) then
                for y = 1, #ni.members do
                    local z = ni.members[y]
                    if ni.members[y].range and not UnitIsDeadOrGhost(z.unit) then
                        local I = #ni.unit.unitstargeting(z.guid)
                        local A, w, w, w, w, w, B = ni.unit.buff(z.unit, 48066, "player")
                        local C = ni.unit.debuff(z.unit, 6788)
                        if
                            I ~= nil and I >= 1 and not C and not (A or A and B - GetTime() < 0.7) and
                                ni.unit.threat(z.guid) >= 2 and
                                z:valid(48066, false, true, true)
                         then
                            ni.spell.cast(48066, z.unit)
                            return true
                        end
                    end
                end
            end
        end,
        ["Prayer of Mending"] = function()
            if ni.spell.available(48113) then
                for y = 1, #ni.members do
                    local z = ni.members[y]
                    if
                        z:hp() < 70 and not ni.unit.buff(ni.members[y].unit, 48113, "player") and
                            z:valid(48113, false, true, true)
                     then
                        ni.spell.cast(48113, z.unit)
                        return true
                    end
                end
            end
        end,
        ["Power Word: Shield (All)"] = function()
            if ni.spell.available(48066) then
                for y = 1, #ni.members do
                    local z = ni.members[y]
                    if ni.members[y].range and not UnitIsDeadOrGhost(z.unit) then
                        local A, w, w, w, w, w, B = ni.unit.buff(z.unit, 48066, "player")
                        local C = ni.unit.debuff(z.unit, 6788)
                        if
                            z.hp() < 100 and not C and not (A or A and B - GetTime() < 0.7) and
                                z:valid(48066, false, true, true)
                         then
                            ni.spell.cast(48066, z.unit)
                            return true
                        end
                    end
                end
            end
        end,
        ["Prayer of Healing"] = function()
            if ni.spell.available(48066) and not ni.player.ismoving() then
                if
                    ni.members.averageof(3) < 75 and ni.members[1].hp < 75 and
                        ni.spell.valid(ni.members[1].unit, 48066, false, true, true)
                 then
                    ni.spell.cast(48066, ni.members[1].unit)
                    return true
                end
                if
                    a.youInRaid() and ni.members.averageof(4) < 75 and ni.members[1].hp < 75 and
                        ni.spell.valid(ni.members[1].unit, 48066, false, true, true)
                 then
                    ni.spell.cast(48066, ni.members[1].unit)
                    return true
                end
            end
        end,
        ["Divine Hymn"] = function()
            if
                ni.player.buff(14751) and not ni.player.ismoving() and ni.spell.available(64843) and
                    UnitChannelInfo("player") == nil
             then
                ni.spell.cast(64843)
                return true
            end
        end,
        ["Window"] = function()
            if not deb then
                ni.frames.floatingtext:message("Dc autdor by Who am i")
                print("|cffEE4000=======================================|r")
                print("|cffFFFF00Dc prist autdor WhoamiWoW|r")
                print("|cff00C957v0.0.3 release|r")
                print("|cffEE4000=======================================|r")
                deb = true
            end
        end
    }
    ni.bootstrap.profile("Dc", u, v, s, t)
else
    local u = {"Error"}
    local v = {["Error"] = function()
            ni.vars.profiles.enabled = false
            if d > 30300 then
                ni.frames.floatingtext:message("This profile is meant for WotLK 3.3.5a! Sorry!")
            elseif e < 80 then
                ni.frames.floatingtext:message("This profile is meant for level 80! Sorry!")
            elseif data == nil then
                ni.frames.floatingtext:message("Data file is missing or corrupted!")
            end
        end}
    ni.bootstrap.profile("Dc", u, v)
end
