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
    local e, e, f = GetSpellInfo(47878)
    local e, e, g = GetSpellInfo(48266)
    local e, e, h = GetSpellInfo(49921)
    local e, e, i = GetSpellInfo(51425)
    local e, e, j = GetSpellInfo(50842)
    local e, e, k = GetSpellInfo(49930)
    local e, e, l = GetSpellInfo(51271)
    local e, e, m = GetSpellInfo(45529)
    local e, e, n = GetSpellInfo(55268)
    local e, e, o = GetSpellInfo(57623)
    local e, e, p = GetSpellInfo(47568)
    local e, e, q = GetSpellInfo(45477)
    local e, e, r = GetSpellInfo(51411)
    local e, e, s = GetSpellInfo(47528)
    local e, e, t = GetSpellInfo(47476)
    local e, e, u = GetSpellInfo(22908)
    local e, e, v = GetSpellInfo(49938)
    local e, e, w = GetSpellInfo(48743)
    local e, e, x = GetSpellInfo(48792)
    local e, e, y = GetSpellInfo(45524)
    local e, e, z = GetSpellInfo(48266)
    local e, e, A = GetSpellInfo(48263)
    local e, e, B = GetSpellInfo(48265)
    local C = {}
    hpotionIcon = "Interface\\Icons\\INV_Alchemy_Elixir_05"
    mpotionIcon = "Interface\\Icons\\INV_Alchemy_Elixir_02"
    trinket = "Interface\\Icons\\inv_jewelry_trinket_04"
    bossIcon = "Interface\\Icons\\inv_misc_head_dragon_01"
    pauseIcon = "Interface\\Icons\\inv_misc_pocketwatch_02"
    local D = {
        settingsfile = "FrostDk",
        {type = "title", text = "|cffff0000Frost Dk by WH|r"},
        {type = "separator"},
        {type = "page", number = 1, text = "|cffff0000Важные настройки|r"},
        {type = "separator"},
        {type = "title", text = "Стойки"},
        {
            type = "dropdown",
            menu = {
                {selected = true, value = 48266, text = "\124T" .. z .. ":24:24\124tВласть крови"},
                {selected = false, value = 48263, text = "\124T" .. A .. ":24:24\124tВласть льда"},
                {selected = false, value = 48265, text = "\124T" .. B .. ":24:24\124tВласть нечестивости"}
            },
            key = "Presence"
        },
        {
            type = "entry",
            text = "\124T" .. j .. ":24:24\124t Мор",
            tooltip = "Использовать мор для обновления бафа",
            enabled = true,
            key = "Mor"
        },
        {
            type = "entry",
            text = "\124T" .. o .. ":24:24\124t Использовать зимний горн",
            tooltip = "",
            enabled = true,
            key = "Gorn"
        },
        {
            type = "entry",
            text = "\124T" .. r .. ":24:24\124t Воющий ветер",
            tooltip = "Использовать воющий ветер",
            enabled = true,
            key = "Veter"
        },
        {
            type = "entry",
            text = "\124T" .. v .. ":24:24\124t Смерть и разложение",
            tooltip = "Использовать смерть и разложение в таргетной ротации",
            enabled = true,
            key = "Lyza"
        },
        {
            type = "entry",
            text = "\124T" .. m .. ":24:24\124t Кровотвод",
            tooltip = "Включает кровотвод в бурст, но не отменяет его при использовании рунического удара",
            enabled = true,
            key = "Krov"
        },
        {type = "separator"},
        {type = "title", text = "|cff00ff00Дополнительно|r"},
        {type = "separator"},
        {
            type = "entry",
            text = "\124T" .. bossIcon .. ":24:24\124t Автоматическое определение босса",
            tooltip = "Автоматический использовать бурсты на боссах",
            enabled = true,
            key = "Boss"
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
            text = "\124T" .. u .. ":24:24\124t Автоматический выбор цели",
            enabled = true,
            key = "AutoTarget"
        },
        {type = "separator"},
        {
            type = "entry",
            text = "\124T" .. s .. ":24:24\124t \124T" .. t .. ":24:24\124t Прерывание",
            tooltip = "Использовать прерывания",
            enabled = true,
            key = "Kick"
        },
        {type = "input", enabled = true, value = 70, min = 1, max = 100, step = 1, width = 40, key = "KikcPersent"},
        {type = "page", number = 2, text = "|cffff0000Защитные настройки|r"},
        {type = "separator"},
        {
            type = "entry",
            text = "\124T" .. f .. ":24:24\124t Камень здоровья",
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
        {
            type = "entry",
            text = "\124T" .. w .. ":24:24\124t Смертельный союз",
            tooltip = "Использовать смертельный союз, когда |cff0082FFHP|r < % у персонажа < %.",
            enabled = true,
            value = 25,
            min = 10,
            max = 100,
            step = 1,
            width = 40,
            key = "Union"
        },
        {
            type = "entry",
            text = "\124T" .. x .. ":24:24\124t Незыблемость льда",
            tooltip = "Использовать незыблемость льда, когда |cff0082FFHP|r < % у персонажа < %.",
            enabled = true,
            value = 30,
            min = 10,
            max = 100,
            step = 1,
            width = 40,
            key = "Icebound"
        }
    }
    local function E(F)
        for G, H in ipairs(D) do
            if H.type == "entry" and H.key ~= nil and H.key == F then
                return H.value, H.enabled
            end
            if H.type == "dropdown" and H.key ~= nil and H.key == F then
                for I, J in pairs(H.menu) do
                    if J.selected then
                        return J.value
                    end
                end
            end
            if H.type == "input" and H.key ~= nil and H.key == F then
                return H.value
            end
        end
    end
    local function K()
        ni.GUI.AddFrame("FrostDk", D)
    end
    local function L()
        ni.GUI.DestroyFrame("FrostDk")
    end
    local M = {
        hstone = GetSpellInfo(47878),
        Krovv = GetSpellInfo(48266),
        YdarChumi = GetSpellInfo(49921),
        Ynistozat = GetSpellInfo(51425),
        Mor = GetSpellInfo(50842),
        Ydarkrovi = GetSpellInfo(49930),
        ArmorBurst = GetSpellInfo(51271),
        krovootvod = GetSpellInfo(45529),
        YdarLda = GetSpellInfo(55268),
        Gorn = GetSpellInfo(57623),
        OryzieRun = GetSpellInfo(47568),
        IcyTouch = GetSpellInfo(45477),
        Veter = GetSpellInfo(51411),
        MindFreez = GetSpellInfo(47528),
        Strangulate = GetSpellInfo(47476),
        Lyza = GetSpellInfo(49938),
        Union = GetSpellInfo(48743),
        IceBound = GetSpellInfo(48792),
        okovi = GetSpellInfo(45524),
        Summonpet = GetSpellInfo(46584)
    }
    local N = {
        
        "Pause",
        "Use Presence",
        "Combat specific Pause",
        "Kick",
        "AutoTarget",
        "Healthstone (Use)",
        "Heal Potions (Use)",
        "IceBound",
        "DeathUnion",
        "VeterAoe",
        "Lyza",
        "Trinkets",
        "IcyTouch",
        "Veter",
        "YdarChumi",
        "Mor",
        "Bursts",
        "Krov",
        "Ybitsozat iii krov",
        "YdarLda",
        "Perchi",
        "MorAoe",
        "OryzieRun",
        "Gorn"
    }
    local O = false
    local P = {[GetSpellInfo(51425)] = true}
    local function Q(R, ...)
        local S = UnitGUID("player")
        if R == "COMBAT_LOG_EVENT_UNFILTERED" then
            local e, T, e, U, e, e, e, e, e, e, e, e, V = ...
            if T == "SPELL_MISSED" and U == S then
                if P[V] then
                    O = true
                    return true
                end
            end
            if T == "SPELL_CAST_SUCCESS" and U == S then
                if P[V] then
                    O = false
                end
            end
        end
    end
    local W = 0
    local X = {
        ["Perchi"] = function()
            local e, Y = E("Boss")
            if Y then
                if
                    ni.player.slotcastable(10) and ni.player.slotcd(10) == 0 and ni.unit.isboss("target") and
                        b.spellusablesilence(M.Ynistozat) and
                        ni.spell.valid("target", M.Ynistozat, true, true)
                 then
                    if ni.player.useinventoryitem(10) then
                        return true
                    end
                end
            end
        end,
        ["Use Presence"] = function()
            local Z = E("Presence")
            if not ni.player.buff(Z) and ni.spell.available(Z) then
                ni.spell.cast(Z)
                return true
            end
        end,
        ["Kick"] = function()
            local e, Y = E("Kick")
            if
                Y and ni.spell.shouldinterrupt("target") and ni.spell.available(47528) and
                    GetTime() - data.LastInterrupt > 9 and
                    ni.spell.valid("target", 47528, true, true)
             then
                ni.spell.castinterrupt("target")
                data.LastInterrupt = GetTime()
                return true
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
                    not UnitAffectingCombat("player") and ni.vars.followEnabled
             then
                return true
            end
        end,
        ["Combat specific Pause"] = function()
            if UnitAffectingCombat("player") then
                return false
            end
            for _ = 1, #ni.members do
                if UnitAffectingCombat(ni.members[_].unit) then
                    return false
                end
            end
            return true
        end,
        ["Window"] = function()
            if not d then
                ni.frames.floatingtext:message("Frost dk By WH")
                print("|cffEE4000=======================================|r")
                print("|cffFFFF00Frost Deathknight by whoamiwow|r")
                print("|cff00C957v0.0.1 release|r")
                print("https://discord.gg/6wCgVRhQFs  ----- Wh Project")
                print("• Нажать кнопку АоЕ для переключения режимов")
                print("|cffEE4000=======================================|r")
                d = true
            end
        end,
        ["IceBound"] = function()
            if b.spellusablesilence(M.IceBound) then
                local a0, Y = E("Icebound")
                if Y then
                    if ni.player.hp() <= a0 then
                        ni.spell.cast(M.IceBound)
                    end
                end
            end
        end,
        ["DeathUnion"] = function()
            local a0, Y = E("Union")
            if Y then
                if b.spellusablesilence(M.Union) and b.spellusablesilence(M.Summonpet) then
                    if ni.player.hp() <= a0 then
                        ni.spell.cast(M.Summonpet)
                        ni.spell.cast(M.Union)
                    end
                end
            end
        end,
        ["AutoTarget"] = function()
            local e, Y = E("AutoTarget")
            if Y then
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
        ["Trinkets"] = function()
            local e, Y = E("trinket")
            if Y then
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
        ["Veter"] = function()
            if b.spellusablesilence(M.Veter) then
                local e, Y = E("Veter")
                if Y then
                    if ni.player.buffs("59052&&51129") and ni.spell.valid("target", M.Veter, true, true) then
                        ni.spell.cast(M.Veter, "target")
                    end
                end
            end
        end,
        ["VeterAoe"] = function()
            if b.spellusablesilence(M.Veter) and ni.vars.combat.aoe then
                if ni.spell.valid("target", M.Veter, true, true) then
                    ni.spell.cast(M.Veter, "target")
                end
            end
        end,
        ["Lyza"] = function()
            if b.spellusablesilence(M.Lyza) and ni.vars.combat.aoe then
                local e, Y = E("Lyza")
                if Y then
                    if b.getrange("target", M.IcyTouch) then
                        ni.spell.castat(M.Lyza, "target")
                    end
                end
            end
        end,
        ["Healthstone (Use)"] = function()
            local a0, Y = E("healthstoneuse")
            local a1 = {
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
            if Y and ni.player.hp() < a0 then
                for _ = 1, #a1 do
                    local a2 = a1[_]
                    if ni.player.hasitem(a2) and IsUsableItem(a2) and ni.player.itemcd(a2) == 0 then
                        ni.player.useitem(a2)
                        return true
                    end
                end
            end
        end,
        ["Heal Potions (Use)"] = function()
            local a0, Y = E("healpotionuse")
            local a3 = {43569, 41166, 40087, 39671, 33934, 33447, 28100, 22829, 13446, 4596, 3928, 1710, 929, 858, 118}
            if Y and ni.player.hp() < a0 then
                for _ = 1, #a3 do
                    local a4 = a3[_]
                    if ni.player.hasitem(a4) and IsUsableItem(a4) and ni.player.itemcd(a4) == 0 then
                        ni.player.useitem(a4)
                        return true
                    end
                end
            end
        end,
        ["Mor"] = function()
            if b.spellusablesilence(M.Mor) then
                local e, Y = E("Mor")
                if Y then
                    if
                        ni.unit.debuffremaining("target", 55095, "player") <= 3 and
                            ni.spell.valid("target", M.Mor, true, false, false)
                     then
                        ni.spell.cast(M.Mor, "target")
                        ni.spell.castqueue(M.Ydarkrovi, "target")
                    end
                end
            end
        end,
        ["MorAoe"] = function()
            if b.spellusablesilence(M.Mor) and ni.vars.combat.aoe then
                local C = ni.unit.enemiesinrange("player", 10)
                for _ = 1, #C do
                    local a5 = C[_].guid
                    if not ni.unit.debuff(a5, 55095, "player") and ni.spell.valid(a5, M.Mor, true, false, false) then
                        ni.spell.cast(M.Mor, a5)
                    end
                end
            end
        end,
        ["IcyTouch"] = function()
            if b.spellusablesilence(M.IcyTouch) then
                if not ni.unit.debuff("target", 55095, "player") and ni.spell.valid("target", M.IcyTouch, true, true) then
                    ni.spell.cast(M.IcyTouch, "target")
                end
            end
        end,
        ["YdarChumi"] = function()
            if b.spellusablesilence(M.YdarChumi) then
                if not ni.unit.debuff("target", 55078, "player") and ni.spell.valid("target", M.YdarChumi, true, true) then
                    ni.spell.cast(M.YdarChumi, "target")
                end
            end
        end,
        ["Bursts"] = function()
            if b.spellusablesilence(M.ArmorBurst) then
                local e, Y = E("Boss")
                if Y then
                    if
                        ni.spell.cd(M.ArmorBurst) == 0 and not ni.player.isstunned() and
                            b.spellusablesilence(M.ArmorBurst) and
                            ni.unit.isboss("target") and
                            b.spellusablesilence(M.Ynistozat) and
                            ni.spell.valid("target", M.Ynistozat, true, true)
                     then
                        ni.spell.cast(M.ArmorBurst)
                    end
                end
            end
        end,
        ["Krov"] = function()
            if b.spellusablesilence(M.krovootvod) then
                local e, Y = E("Krov")
                if Y then
                    if
                        ni.spell.cd(M.krovootvod) == 0 and not ni.player.isstunned() and
                            b.spellusablesilence(M.krovootvod) and
                            ni.unit.isboss("target") and
                            ni.spell.valid("target", M.Ynistozat, true, true)
                     then
                        ni.spell.cast(M.krovootvod)
                    end
                end
            end
        end,
        ["OryzieRun"] = function()
            local e, Y = E("Boss")
            if Y then
                if b.spellusablesilence(M.OryzieRun) then
                    if ni.unit.isboss("target") then
                        ni.spell.cast(M.OryzieRun)
                        return true
                    end
                end
            end
        end,
        ["Ybitsozat iii krov"] = function()
            if W > 1 then
                CancelUnitBuff("player", 45529)
                return true
            end
            if b.spellusablesilence(M.Ynistozat) and W ~= 1 then
                if ni.spell.valid("target", M.Ynistozat, true, true) then
                    ni.spell.cast(M.Ynistozat, "target")
                    W = W + 1
                    return true
                end
            end
        end,
        ["Ynistozat"] = function()
            if b.spellusablesilence(M.Ynistozat) and ni.spell.valid("target", M.Ynistozat, true, true) then
                ni.spell.cast(M.Ynistozat, "target")
            end
        end,
        ["YdarLda"] = function()
            if
                b.spellusablesilence(M.YdarLda) and ni.spell.cd(M.Ynistozat) >= 1 and
                    ni.spell.valid("target", M.YdarLda, true, true)
             then
                ni.spell.cast(M.YdarLda, "target")
            end
        end,
        ["Ydarkrovi"] = function()
            if
                b.spellusablesilence(M.Ydarkrovi) and not ni.spell.available(M.YdarLda) and
                    not ni.spell.available(M.Ynistozat) and
                    ni.spell.valid("target", M.Ydarkrovi, true, true)
             then
                ni.spell.cast(M.Ydarkrovi, "target")
            end
        end,
        ["Gorn"] = function()
            if b.spellusablesilence(M.Gorn) then
                local e, Y = E("Gorn")
                if Y then
                    ni.spell.cast(M.Gorn)
                end
            end
        end
    }
    ni.bootstrap.profile("FrostDk", N, X, K, L)
else
    local N = {"Error"}
    local X = {["Error"] = function()
            ni.vars.profiles.enabled = false
            if c > 30300 then
                if GetLocale() == "ruRU" then
                    ni.frames.floatingtext:message("Только для 3.3.5a!")
                else
                    ni.frames.floatingtext:message("This profile for WotLK 3.3.5a!")
                end
            elseif Riot == nil then
                if GetLocale() == "ruRU" then
                    ni.frames.floatingtext:message("Riot-файл поврежден или отсуствует!")
                else
                    ni.frames.floatingtext:message("Riot file is missing or corrupted!")
                end
            end
        end}
    ni.bootstrap.profile("FrostDk", N, X)
end
