local a = ni.utils.require("Riot") or ni.utils.require("Riot.enc")
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
    local j, j, k = GetSpellInfo(2458)
    local j, j, l = GetSpellInfo(1680)
    local j, j, m = GetSpellInfo(23881)
    local j, j, n = GetSpellInfo(12292)
    local j, j, o = GetSpellInfo(1719)
    local j, j, p = GetSpellInfo(47475)
    local j, j, q = GetSpellInfo(47436)
    local j, j, r = GetSpellInfo(47440)
    local j, j, s = GetSpellInfo(18499)
    local j, j, t = GetSpellInfo(55694)
    local j, j, u = GetSpellInfo(2687)
    local j, j, v = GetSpellInfo(7386)
    local j, j, w = GetSpellInfo(47450)
    local j, j, x = GetSpellInfo(6552)
    local j, j, y = GetSpellInfo(47520)
    local j, j, z = GetSpellInfo(47878)
    local j, j, A = GetSpellInfo(57755)
    local j, j, B = GetSpellInfo(22908)
    hpotionIcon = "Interface\\Icons\\INV_Alchemy_Elixir_05"
    mpotionIcon = "Interface\\Icons\\INV_Alchemy_Elixir_02"
    trinket = "Interface\\Icons\\inv_relics_idolofferocity"
    bossIcon = "Interface\\Icons\\inv_misc_head_dragon_01"
    local C = {
        settingsfile = "Fury.js",
        {type = "title", text = "|cffC69B6DFury warrior by|r |c0010CED1WH|r"},
        {type = "separator"},
        {type = "page", number = 1, text = "|cffFFFF00Главные настройки|r"},
        {type = "separator"},
        {
            type = "entry",
            text = "\124T" .. k .. ":24:24\124t Стойка берсерка",
            tooltip = "Поддержание стойки берсерка",
            enabled = true,
            key = "berserkStance"
        },
        {type = "title", text = "|cffCD661DНастройка бафов|r"},
        {
            type = "dropdown",
            menu = {
                {selected = true, value = 1, text = "\124T" .. r .. ":20:20\124t Командирский крик"},
                {selected = false, value = 2, text = "\124T" .. q .. ":20:20\124t Боевой крик"},
                {selected = false, value = 3, text = "|cffFF0303В ручную|r"}
            },
            key = "Shout"
        },
        {
            type = "entry",
            text = "\124T" .. u .. ":24:24\124t Кровавая ярость",
            tooltip = "Автоиспользование Кровавой ярости, когда |cff00D700RAGE|r < % у персонажа < %.",
            enabled = true,
            value = 15,
            min = 0,
            max = 80,
            step = 1,
            width = 40,
            key = "blodyrage"
        },
        {
            type = "entry",
            text = "\124T" .. s .. ":24:24\124t Ярость берсерка",
            tooltip = "Автоиспользование ярости берсерка, когда |cff00D700RAGE|r < % у персонажа < %.",
            enabled = true,
            value = 15,
            min = 0,
            max = 80,
            step = 1,
            width = 40,
            key = "berserkrage"
        },
        {type = "separator"},
        {type = "title", text = "|cffCD661DДополнительно|r"},
        {
            type = "entry",
            text = "\124T" .. v .. ":24:24\124t Раскол брони",
            tooltip = "В простоях настакивать раскол брони",
            enabled = true,
            key = "sunder"
        },
        {type = "title", text = "|cffCD661DНастройка прерываний|r"},
        {
            type = "entry",
            text = "\124T" .. x .. ":24:24\124t Зуботычина",
            tooltip = "Использовать зуботычину",
            enabled = true,
            key = "interrupt"
        },
        {type = "input", enabled = true, value = 70, min = 1, max = 100, step = 1, width = 40, key = "KikcPersent"},
        {type = "page", number = 2, text = "|cffFFFF00Настройки ротации|r"},
        {type = "separator"},
        {type = "title", text = "|cffCD661DНастройка бурстов|r"},
        {
            type = "entry",
            text = "\124T" .. n .. ":24:24\124t/ \124T" .. o .. ":24:24\124t Бурсты",
            tooltip = "Использовать бусрты на боссах",
            enabled = true,
            key = "Burst"
        },
        {
            type = "entry",
            text = "\124T" .. B .. ":24:24\124t Автоматический выбор цели",
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
            text = "\124T" .. l .. ":24:24\124t Вихрь",
            tooltip = "Использовать вихрь",
            enabled = true,
            key = "storm"
        },
        {
            type = "entry",
            text = "\124T" .. m .. ":24:24\124t Кровожадность",
            tooltip = "Использовать кровожадность",
            enabled = true,
            key = "blodlust"
        },
        {
            type = "entry",
            text = "\124T" .. p .. ":24:24\124t Мощный удар(Прок)",
            tooltip = "Использовать мощный удар под прок",
            enabled = true,
            key = "powerfulStrike"
        },
        {type = "entry", text = "\124T" .. A .. ":24:24\124t Героический бросок", enabled = true, key = "Kiday"},
        {type = "page", number = 3, text = "|cff00C957Защитные настройки|r"},
        {type = "separator"},
        {
            type = "entry",
            text = "\124T" .. t .. ":24:24\124t Безудержное восстановление",
            tooltip = "Автоиспользование безудержного восстановления, когда |cff00D700HP|r < %",
            enabled = true,
            value = 35,
            min = 25,
            max = 65,
            step = 1,
            width = 40,
            key = "unrestrainedrecovery"
        },
        {
            type = "entry",
            text = "\124T" .. s .. ":24:24\124t Ярость берсерка",
            tooltip = "Использование ярости берсерка при устрашении пресонажа",
            enabled = true,
            key = "berserkragefear"
        },
        {type = "separator"},
        {
            type = "entry",
            text = "\124T" .. z .. ":24:24\124t Камень здоровья",
            tooltip = "Использовать камень здоровья Чернокнижника, когда |cff00D700HP|r < %.",
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
        }
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
        ni.GUI.AddFrame("Fury", C)
    end
    local function K()
        ni.GUI.DestroyFrame("Fury")
    end
    local L = {
        BerserkStance = GetSpellInfo(2458),
        Storm = GetSpellInfo(1680),
        Bloodlust = GetSpellInfo(23881),
        DeathWish = GetSpellInfo(12292),
        Recklessness = GetSpellInfo(1719),
        PowefulStrike = GetSpellInfo(47475),
        Battleshout = GetSpellInfo(47436),
        Comandingshout = GetSpellInfo(47440),
        Berserkrage = GetSpellInfo(18499),
        Unrestrainedrecovery = GetSpellInfo(55694),
        Bloodyrage = GetSpellInfo(2687),
        Sunder = GetSpellInfo(7386),
        Herostrike = GetSpellInfo(47450),
        Interrupt = GetSpellInfo(6552),
        Cleave = GetSpellInfo(47520),
        Execute = GetSpellInfo(47471)
    }
    local M = {sirus = false}
    local N = {
        "Cache",
        "Pause",
        "Riot",
        "FuryStance",
        "Shout",
        "AutoTarget",
        "Combat specific Pause",
        "Trinkets",
        "Use enginer gloves",
        "Healthstone (Use)",
        "Heal Potions (Use)",
        "Interrupt",
        "Berserkrage",
        "Bloodyrage",
        "Sunder",
        "Unrestrainedrecovery",
        "Recklessness",
        "DeathWish",
        "Rassovie",
        "Storm",
        "PowerfulStrike",
        "Blodlust",
        "Kiday",
        "Execute",
        "Heroic Strike/Cleave"
    }
    local O = {
        ["Riot"] = function()
            if not c then
                if not M.sirus then
                    ni.frames.floatingtext:message("Fury warrior By WH")
                    print("|cffEE4000=======================================|r")
                    print("|cffFFFF00Fury Warrior by whoamiwow|r")
                    print("|cff00C957v0.0.1 release|r")
                    print("https://discord.gg/6wCgVRhQFs  ----- Wh Project")
                    print("|cffC69B6D• Нажать кнопку АоЕ для переключения режимов;|r")
                    print("|cffEE4000=======================================|r")
                    c = true
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
                    not UnitAffectingCombat("player") and ni.vars.followEnabled
             then
                return true
            end
            ni.vars.debug = select(2, D("Debug"))
        end,
        ["AutoTarget"] = function()
            local j, P = D("AutoTarget")
            if P then
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
        ["Combat specific Pause"] = function()
            if M.InCombat then
                return false
            end
            for Q = 1, #ni.members do
                if UnitAffectingCombat(ni.members[Q].unit) then
                    return false
                end
            end
            return true
        end,
        ["FuryStance"] = function()
            local j, P = D("berserkStance")
            if P then
                if not ni.player.aura(L.BerserkStance) and a.spellusable(L.BerserkStance) then
                    ni.spell.cast(L.BerserkStance)
                end
            end
        end,
        ["Bloodyrage"] = function()
            local R, P = D("blodyrage")
            if P then
                if ni.player.power(1) < R and ni.spell.cd(L.Bloodyrage) == 0 then
                    ni.spell.cast(L.Bloodyrage)
                end
            end
        end,
        ["Trinkets"] = function()
            local j, P = D("trinket")
            if P then
                if
                    (ni.vars.combat.cd or ni.unit.isboss("target")) and ni.player.slotcastable(13) and
                        ni.player.slotcd(13) == 0 and
                        ni.spell.valid("target", L.Bloodlust)
                 then
                    ni.player.useinventoryitem(13)
                else
                    if
                        (ni.vars.combat.cd or ni.unit.isboss("target")) and ni.player.slotcastable(14) and
                            ni.player.slotcd(14) == 0 and
                            ni.spell.valid("target", L.Bloodlust)
                     then
                        ni.player.useinventoryitem(14)
                        return true
                    end
                end
            end
        end,
        ["Rassovie"] = function()
            local j, P = D("Burst")
            if not P then
                return false
            end
            local S = {33697, 20572, 33702, 26297}
            local T = {20594, 28880}
            if ni.unit.isfleeing("player") and a.spellisknown(7744) and ni.spell.available(7744) then
                ni.spell.cast(7744)
                return true
            end
            for Q = 1, #S do
                local U = S[Q]
                if
                    (ni.vars.combat.cd or ni.unit.isboss("target")) and a.spellisknown(U) and ni.spell.available(U) and
                        ni.spell.valid("target", L.Bloodlust, true, true)
                 then
                    ni.spell.cast(U)
                    return true
                end
            end
            for Q = 1, #T do
                local V = T[Q]
                if
                    ni.spell.valid("target", L.Bloodlust, true, true) and ni.player.hp() < 20 and a.spellisknown(V) and
                        ni.spell.available(V)
                 then
                    ni.spell.cast(V)
                    return true
                end
            end
        end,
        ["Execute"] = function()
            if a.spellusable(L.Execute) and ni.player.power() >= 40 and ni.spell.valid("target", L.Execute, true, true) then
                ni.spell.cast(L.Execute, "target")
            end
        end,
        ["Berserkrage"] = function()
            local R, P = D("berserkrage")
            if P then
                if a.spellusable(L.Berserkrage) and (ni.player.power() <= R or ni.player.isfleeing()) then
                    ni.spell.cast(L.Berserkrage)
                end
            end
        end,
        ["Heroic Strike/Cleave"] = function()
            if a.getrange("target", L.Bloodlust) then
                if
                    ni.vars.combat.aoe and not IsCurrentSpell(L.Cleave) and ni.spell.available(L.Cleave, true) and
                        IsUsableSpell(L.Cleave)
                 then
                    ni.spell.cast(L.Cleave, "target")
                elseif
                    not ni.vars.combat.aoe and not IsCurrentSpell(L.Herostrike) and
                        ni.spell.available(L.Herostrike, true) and
                        IsUsableSpell(L.Herostrike)
                 then
                    ni.spell.cast(L.Herostrike, "target")
                end
            end
            if UnitLevel("player") < 75 and a.getrange("target", L.Bloodlust) then
                if
                    ni.vars.combat.aoe and not IsCurrentSpell(L.Cleave) and ni.spell.available(L.Cleave, true) and
                        IsUsableSpell(L.Cleave)
                 then
                    ni.spell.cast(L.Cleave, "target")
                elseif
                    not ni.vars.combat.aoe and not IsCurrentSpell(L.Herostrike) and
                        ni.spell.available(L.Herostrike, true) and
                        IsUsableSpell(L.Herostrike)
                 then
                    ni.spell.cast(L.Herostrike, "target")
                end
            end
        end,
        ["Shout"] = function()
            local R = D("Shout")
            if R == 1 then
                if a.spellusable(L.Comandingshout) and not ni.player.buff(L.Comandingshout) then
                    ni.spell.cast(L.Comandingshout)
                end
            end
            if R == 2 then
                if a.spellusable(L.Battleshout) and not ni.player.buff(L.Battleshout) then
                    ni.spell.cast(L.Battleshout)
                end
            end
            if R == 3 then
            end
        end,
        ["Use enginer gloves"] = function()
            if
                ni.player.slotcastable(10) and ni.player.slotcd(10) == 0 and
                    (ni.vars.combat.cd or ni.unit.isboss("target"))
             then
                ni.player.useinventoryitem(10)
                return true
            end
        end,
        ["Interrupt"] = function()
            local j, P = D("interrupt")
            if P then
                local R = D("KikcPersent")
                if ni.unit.iscasting("target") or ni.unit.ischanneling("target") then
                    if
                        a.spellusable(L.Interrupt) and a.defensivecat("target") and
                            ni.unit.castingpercent("target") >= R and
                            ni.spell.valid("target", L.Interrupt, true, true)
                     then
                        ni.spell.cast(L.Interrupt, "target")
                    else
                        if ni.unit.channelpercent("target") <= R then
                            if a.spellusable(L.Interrupt) and ni.spell.valid("target", L.Interrupt, true, true) then
                                ni.spell.cast(L.Interrupt, "target")
                            end
                        end
                    end
                end
            end
        end,
        ["Unrestrainedrecovery"] = function()
            local R, P = D("unrestrainedrecovery")
            if P then
                if ni.player.hp() < R and not ni.player.isstunned() and UnitAffectingCombat("player") then
                    ni.spell.cast(L.Unrestrainedrecovery)
                end
            end
        end,
        ["DeathWish"] = function()
            local j, P = D("Burst")
            if not P then
                return false
            end
            if a.spellusable(L.DeathWish) then
                if (ni.unit.isboss("target") or ni.vars.combat.cd) and a.getrange("target", L.Bloodlust) then
                    ni.spell.cast(L.DeathWish)
                    return true
                end
            end
        end,
        ["Recklessness"] = function()
            local j, P = D("Burst")
            if not P then
                return false
            end
            if a.spellusable(L.Recklessness) then
                if (ni.unit.isboss("target") or ni.vars.combat.cd) and a.getrange("target", L.Bloodlust) then
                    ni.spell.cast(L.Recklessness)
                    return true
                end
            end
        end,
        ["Blodlust"] = function()
            local j, P = D("blodlust")
            if P then
                if a.spellusable(L.Bloodlust) and ni.spell.valid("target", L.Bloodlust, true, true) then
                    ni.spell.cast(L.Bloodlust, "target")
                end
            end
        end,
        ["Storm"] = function()
            local j, P = D("storm")
            if P then
                if a.spellusable(L.Storm) and a.getrange("target", L.Bloodlust) then
                    ni.spell.cast(L.Storm, "target")
                end
            end
        end,
        ["PowerfulStrike"] = function()
            local j, P = D("powerfulStrike")
            if P then
                if
                    a.spellusable(L.PowefulStrike) and ni.player.buff(46916) and ni.spell.isinstant(L.PowefulStrike) and
                        ni.spell.valid("target", L.PowefulStrike, true, true)
                 then
                    ni.spell.cast(L.PowefulStrike, "target")
                end
            end
        end,
        ["Kiday"] = function()
            local j, P = D("Kiday")
            if not P then
                return false
            end
            if
                a.spellusable(57755) and not ni.unit.debuff("target", 57755, "player") and
                    ni.spell.valid("target", 57755, true, true)
             then
                ni.spell.cast(57755, "target")
                return true
            end
        end,
        ["Sunder"] = function()
            local W, j, j, X = ni.unit.debuff("target", 7386)
            local j, P = D("sunder")
            if not P then
                return false
            end
            if
                ni.unit.isboss("target") and not ni.unit.debuff("target", 8647) and
                    (not W or X < 5 or ni.unit.debuffremaining("target", 7386, "player") < 5) and
                    ni.spell.available(7386) and
                    not ni.spell.available(23881) and
                    not ni.spell.available(1680) and
                    ni.spell.valid("target", 7386, true, true)
             then
                ni.spell.cast(7386, "target")
                return true
            end
        end,
        ["Healthstone (Use)"] = function()
            local R, P = D("healthstoneuse")
            local Y = {
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
            if P and ni.player.hp() < R and not ni.player.isstunned() and UnitAffectingCombat("player") then
                for Q = 1, #Y do
                    if ni.player.hasitem(Y[Q]) and ni.player.itemcd(Y[Q]) == 0 then
                        ni.player.useitem(Y[Q])
                    end
                end
            end
        end,
        ["Heal Potions (Use)"] = function()
            local R, P = D("healpotionuse")
            local Z = {43569, 41166, 40087, 39671, 33934, 33447, 28100, 22829, 13446, 4596, 3928, 1710, 929, 858, 118}
            if P and ni.player.hp() < R and not ni.player.isstunned() and UnitAffectingCombat("player") then
                for Q = 1, #Z do
                    if ni.player.hasitem(Z[Q]) and ni.player.itemcd(Z[Q]) == 0 then
                        ni.player.useitem(Z[Q])
                    end
                end
            end
        end
    }
    ni.bootstrap.profile("Fury", N, O, J, K)
else
    local N = {"Error"}
    local O = {["Error"] = function()
            ni.vars.profiles.enabled = false
            if b > 30300 then
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
    ni.bootstrap.profile("Fury", N, O)
end
