local a = ni.utils.require("Riot") or ni.utils.require("Riot.enc")
local b, c = select(4, GetBuildInfo()), false
if b == 30300 and a then
    local d, d, e = GetSpellInfo(2457)
    local d, d, f = GetSpellInfo(46924)
    local d, d, g = GetSpellInfo(47436)
    local d, d, h = GetSpellInfo(47440)
    local d, d, i = GetSpellInfo(20230)
    local d, d, j = GetSpellInfo(18499)
    local d, d, k = GetSpellInfo(55694)
    local d, d, l = GetSpellInfo(47486)
    local d, d, m = GetSpellInfo(47502)
    local d, d, n = GetSpellInfo(2687)
    local d, d, n = GetSpellInfo(2687)
    local d, d, o = GetSpellInfo(7386)
    local d, d, p = GetSpellInfo(47878)
    local d, d, q = GetSpellInfo(12328)
    hpotionIcon = "Interface\\Icons\\INV_Alchemy_Elixir_05"
    mpotionIcon = "Interface\\Icons\\INV_Alchemy_Elixir_02"
    local d, d, r = GetSpellInfo(2382)
    local s = {
        settingsfile = "Arms.json",
        {type = "title", text = "|cffC69B6DArms warrior by|r |c0010CED1WH|r"},
        {type = "separator"},
        {type = "page", number = 1, text = "|cffEE4000Настройка ротации|r"},
        {type = "separator"},
        {
            type = "entry",
            text = "\124T" .. e .. ":24:24\124t Боевая стойка",
            tooltip = "Поддержание боевой стойки",
            enabled = true,
            key = "battlestance"
        },
        {type = "title", text = "|cffCD661DНастройка бафов|r"},
        {
            type = "dropdown",
            menu = {
                {selected = false, value = 1, text = "\124T" .. h .. ":20:20\124t Командирский крик"},
                {selected = false, value = 2, text = "\124T" .. g .. ":20:20\124t Боевой крик"},
                {selected = true, value = 3, text = "|cffFF0303 Автоматический|r"}
            },
            key = "Shout"
        },
        {
            type = "entry",
            text = "\124T" .. n .. ":24:24\124t Кровавая ярость",
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
            text = "\124T" .. l .. ":24:24\124t Использовать смертельный удар",
            enabled = false,
            key = "Motrtalstrike"
        },
        {
            type = "entry",
            text = "\124T" .. m .. ":24:24\124t Удар грома (в одиночную цель)",
            enabled = true,
            key = "Thunderclap"
        },
        {type = "entry", text = "\124T" .. o .. ":24:24\124t Раскол брони ", enabled = true, key = "SunderArmor"},
        {type = "separator"},
        {type = "entry", text = "\124T" .. f .. ":24:24\124t Вихрь клинков(аое)", enabled = true, key = "Bladestorm"},
        {type = "entry", text = "\124T" .. m .. ":24:24\124t Удар грома(аое)", enabled = true, key = "ThunderclapAoe"},
        {
            type = "entry",
            text = "\124T" .. q .. ":24:24\124t Размашистые удары",
            enabled = true,
            key = "SweepingStrikes"
        },
        {type = "page", number = 2, text = "|cff00C957Защитные настройки|r"},
        {type = "separator"},
        {
            type = "entry",
            text = "\124T" .. k .. ":24:24\124t Безудержное восст.",
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
            text = "\124T" .. i .. ":24:24\124t Возмедие",
            tooltip = "Автоиспользование возмездия в критических ситуациях",
            enabled = true,
            value = 58,
            min = 25,
            max = 100,
            step = 1,
            width = 40,
            key = "retribution"
        },
        {
            type = "entry",
            text = "\124T" .. j .. ":24:24\124t Ярость берсерка",
            tooltip = "Использование ярости берсерка при устрашении пресонажа",
            enabled = true,
            key = "berserkrage"
        },
        {type = "separator"},
        {
            type = "entry",
            text = "\124T" .. p .. ":24:24\124t Камень здоровья",
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
    local function t(u)
        for v, w in ipairs(s) do
            if w.type == "entry" and w.key ~= nil and w.key == u then
                return w.value, w.enabled
            end
            if w.type == "dropdown" and w.key ~= nil and w.key == u then
                for x, y in pairs(w.menu) do
                    if y.selected then
                        return y.value
                    end
                end
            end
            if w.type == "input" and w.key ~= nil and w.key == u then
                return w.value
            end
        end
    end
    local function z()
        ni.GUI.AddFrame("Arms", s)
    end
    local function A()
        ni.GUI.DestroyFrame("Arms")
    end
    local B = {
        Battlestance = GetSpellInfo(2457),
        Rend = GetSpellInfo(47465),
        Motrtalstrike = GetSpellInfo(47486),
        Overpower = GetSpellInfo(7384),
        Herostrike = GetSpellInfo(47450),
        Execute = GetSpellInfo(47471),
        Bladestorm = GetSpellInfo(46924),
        Battleshout = GetSpellInfo(47436),
        ComandingShout = GetSpellInfo(47440),
        Demoralizingscream = GetSpellInfo(47437),
        Cleave = GetSpellInfo(47520),
        Thunderclap = GetSpellInfo(47502),
        Sweepingblows = GetSpellInfo(12328),
        Berserkrage = GetSpellInfo(18499),
        DeathWish = GetSpellInfo(12292),
        Bloodyrage = GetSpellInfo(2687),
        Retribution = GetSpellInfo(20230),
        Unrestrainedrecovery = GetSpellInfo(55694),
        VictoryRush = GetSpellInfo(34428),
        Powerfulstrike = GetSpellInfo(47475),
        SunderArmor = GetSpellInfo(7386),
        HeroicThrow = GetSpellInfo(64382),
        Recklessness = GetSpellInfo(1719),
        BlodyrageBurst = GetSpellInfo(316373)
    }
    local C = {sirus = false}
    local D = {
        "Sirus",
        "Cache",
        "wb",
        "Pause",
        "Battlestance",
        "Shout",
        "Combat specific Pause",
        "Healthstone (Use)",
        "Heal Potions (Use)",
        "Retribution",
        "Unrestrainedrecovery",
        "Wand",
        "Berserkrage",
        "BlodyrageBurst",
        "Sweepingblows",
        "DeathWish",
        "Rend(Multidot)",
        "Rend",
        "SunderArmor",
        "Recklessness",
        "Bladestorm",
        "Heroic Strike/Cleave",
        "ThunderclapAoe",
        "Racial",
        "Overpower",
        "Execute",
        "Motrtalstrike",
        "PowerfulStrike",
        "Thunderclap",
        "Bloodyrage"
    }
    local E = {
        ["Cache"] = function()
            C.sirus = a.sirusserver() or false
        end,
        ["Pause"] = function()
            if
                IsMounted() or UnitInVehicle("player") or UnitIsDeadOrGhost("player") or UnitChannelInfo("player") or
                    UnitCastingInfo("player") or
                    ni.vars.combat.casting == true or
                    ni.player.islooting() or
                    ni.player.buff(GetSpellInfo(430)) or
                    ni.player.buff(GetSpellInfo(433)) or
                    ni.player.buff(B.Bladestorm) or
                    not UnitAffectingCombat("player") and ni.vars.followEnabled
             then
                return true
            end
            ni.vars.debug = select(2, t("Debug"))
        end,
        ["Combat specific Pause"] = function()
            if UnitAffectingCombat("player") then
                return false
            end
            for F = 1, #ni.members do
                if UnitAffectingCombat(ni.members[F].unit) then
                    return false
                end
            end
            return true
        end,
        ["Sirus"] = function()
            if not c then
                if C.sirus then
                    ni.frames.floatingtext:message("Режим поддержки сируса")
                    c = true
                end
            end
        end,
        ["Kusbas"] = function()
            if C.sirus then
                return false
            end
            if not c then
                ni.frames.floatingtext:message("KUSBAS SCRIPTS")
                c = true
            end
        end,
        ["DeathWish"] = function()
            if a.spellusable(B.DeathWish) then
                if (ni.unit.isboss("target") or ni.vars.combat.cd) and a.getrange("target", B.Rend) then
                    ni.spell.cast(B.DeathWish)
                end
            end
        end,
        ["Battlestance"] = function()
            local d, G = t("battlestance")
            if G then
                if not ni.player.aura(B.Battlestance) and a.spellusable(B.Battlestance) then
                    ni.spell.cast(B.Battlestance)
                end
            end
        end,
        ["SunderArmor"] = function()
            local d, G = t("SunderArmor")
            if G then
                if a.spellusable(B.SunderArmor) then
                    if
                        (ni.unit.debuffstacks("target", B.SunderArmor) < 5 or
                            ni.unit.debuffremaining("target", B.SunderArmor) <= 2) and
                            ni.unit.isboss("target") and
                            ni.spell.valid("target", B.SunderArmor, true, true)
                     then
                        ni.spell.cast(B.SunderArmor, "target")
                    end
                end
            end
        end,
        ["Recklessness"] = function()
            if
                not ni.player.aura(2458) and ni.spell.cd(B.Recklessness) == 0 and a.spellusable(2458) and
                    a.getrange("target", B.Rend) and
                    ni.unit.isboss("target")
             then
                ni.spell.cast(2458)
            end
            if a.spellusable(B.Recklessness) then
                ni.spell.cast(B.Recklessness)
            end
        end,
        ["HeroicThrow"] = function()
            if a.spellusable(B.HeroicThrow) then
                if
                    ni.unit.debuffstacks("target", B.SunderArmor) == 5 and ni.unit.isboss("target") and
                        ni.spell.valid("target", B.HeroicThrow, true, true) and
                        not ni.player.ismoving()
                 then
                    ni.spell.cast(B.HeroicThrow, "target")
                end
            end
        end,
        ["PowerfulStrike"] = function()
            if a.spellusable(B.Powerfulstrike) and ni.spell.valid("target", B.Powerfulstrike, true, true) then
                ni.spell.cast(B.Powerfulstrike, "target")
            end
        end,
        ["Healthstone (Use)"] = function()
            local H, G = t("healthstoneuse")
            local I = {
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
            if G and ni.player.hp() < H and not ni.player.isstunned() and UnitAffectingCombat("player") then
                for F = 1, #I do
                    if ni.player.hasitem(I[F]) and ni.player.itemcd(I[F]) == 0 then
                        ni.player.useitem(I[F])
                    end
                end
            end
        end,
        ["Heal Potions (Use)"] = function()
            local H, G = t("healpotionuse")
            local J = {43569, 41166, 40087, 39671, 33934, 33447, 28100, 22829, 13446, 4596, 3928, 1710, 929, 858, 118}
            if G and ni.player.hp() < H and not ni.player.isstunned() and UnitAffectingCombat("player") then
                for F = 1, #J do
                    if ni.player.hasitem(J[F]) and ni.player.itemcd(J[F]) == 0 then
                        ni.player.useitem(J[F])
                    end
                end
            end
        end,
        ["Shout"] = function()
            local H = t("Shout")
            if H == 1 then
                if a.spellusable(B.ComandingShout) and not ni.player.buff(B.ComandingShout) then
                    ni.spell.cast(B.ComandingShout)
                end
            end
            if H == 2 then
                if a.spellusable(B.Battleshout) and not ni.player.buff(B.Battleshout) then
                    ni.spell.cast(B.Battleshout)
                end
            end
            if H == 3 then
                if not ni.player.buffs(B.Battleshout, 48932, 48934) then
                    if a.spellusable(B.Battleshout) then
                        ni.spell.cast(B.Battleshout)
                    end
                end
                if
                    ni.player.buffs(B.Battleshout, 48932, 48934) and not ni.player.buff(B.ComandingShout) and
                        not ni.player.buff(B.Battleshout, "player") and
                        a.spellusable(B.ComandingShout)
                 then
                    ni.spell.cast(B.ComandingShout)
                end
            end
        end,
        ["Unrestrainedrecovery"] = function()
            local H, G = t("unrestrainedrecovery")
            if G then
                if
                    ni.player.hp() < H and a.spellusable(B.Unrestrainedrecovery) and
                        not ni.player.buff(B.Unrestrainedrecovery)
                 then
                    ni.spell.cast(B.Unrestrainedrecovery)
                end
            end
        end,
        ["Wand"] = function()
            local K = ni.unit.enemiesinrange("player", 5)
            for F = 1, #K do
                local L = K[F].guid
                if ni.unit.istotem(L) then
                    if ni.spell.available(6603) and ni.spell.valid(L, 6603, true, true) then
                        ni.spell.cast(6603, L)
                    end
                end
            end
        end,
        ["Rend(Multidot)"] = function()
            if a.spellusable(B.Rend) and ni.vars.combat.aoe then
                local K = ni.unit.enemiesinrange("player", 4)
                for F = 1, #K do
                    local M = K[F].guid
                    if not ni.unit.debuff(M, B.Rend, "player") and ni.spell.valid(M, B.Rend, true, true) then
                        ni.spell.cast(B.Rend, M)
                    end
                end
            end
        end,
        ["Heroic Strike/Cleave"] = function()
            if ni.player.power() >= 70 and a.getrange("target", B.Rend) then
                if
                    ni.vars.combat.aoe and not IsCurrentSpell(B.Cleave) and ni.spell.available(B.Cleave, true) and
                        IsUsableSpell(B.Cleave)
                 then
                    ni.spell.cast(B.Cleave, "target")
                elseif
                    not ni.vars.combat.aoe and not IsCurrentSpell(B.Herostrike) and
                        ni.spell.available(B.Herostrike, true) and
                        IsUsableSpell(B.Herostrike)
                 then
                    ni.spell.cast(B.Herostrike, "target")
                end
            end
            if UnitLevel("player") <= 70 and a.getrange("target", B.Rend) then
                if
                    ni.vars.combat.aoe and not IsCurrentSpell(B.Cleave) and ni.spell.available(B.Cleave, true) and
                        IsUsableSpell(B.Cleave)
                 then
                    ni.spell.cast(B.Cleave, "target")
                elseif
                    not ni.vars.combat.aoe and not IsCurrentSpell(B.Herostrike) and
                        ni.spell.available(B.Herostrike, true) and
                        IsUsableSpell(B.Herostrike)
                 then
                    ni.spell.cast(B.Herostrike, "target")
                end
            end
        end,
        ["BlodyrageBurst"] = function()
            if C.sirus then
                if
                    (ni.vars.combat.cd or ni.unit.isboss("target")) and a.spellusable(B.BlodyrageBurst) and
                        a.getrange("target", B.Rend)
                 then
                    ni.spell.cast(B.BlodyrageBurst)
                end
            end
        end,
        ["Berserkrage"] = function()
            local d, G = t("berserkrage")
            if G then
                if ni.spell.available(B.Berserkrage) and ni.unit.isfleeing("player") then
                    ni.spell.cast(B.Berserkrage)
                end
            end
        end,
        ["Retribution"] = function()
            local H, G = t("retribution")
            if G then
                if ni.player.hp() < H and a.spellusable(B.Retribution) then
                    ni.spell.cast(B.Retribution)
                end
            end
        end,
        ["Bloodyrage"] = function()
            local H, G = t("blodyrage")
            if G then
                if ni.player.power(1) < H and ni.spell.cd(B.Bloodyrage) == 0 then
                    ni.spell.cast(B.Bloodyrage)
                end
            end
        end,
        ["Sweepingblows"] = function()
            local d, G = t("SweepingStrikes")
            if G then
                if
                    ni.vars.combat.aoe and not ni.player.buff(B.Sweepingblows) and a.spellusable(B.Sweepingblows) and
                        a.getrange("target", B.Rend)
                 then
                    ni.spell.cast(B.Sweepingblows)
                end
            end
        end,
        ["ThunderclapAoe"] = function()
            local d, G = t("ThunderclapAoe")
            if G then
                if ni.vars.combat.aoe and a.spellusable(B.Thunderclap) and a.getrange("target", B.Rend) then
                    ni.spell.cast(B.Thunderclap)
                end
            end
        end,
        ["Thunderclap"] = function()
            local d, G = t("Thunderclap")
            if G then
                if a.spellusable(B.Thunderclap) and a.getrange("target", B.Rend) then
                    ni.spell.cast(B.Thunderclap)
                end
            end
        end,
        ["Demoralizingscream"] = function()
            if
                ni.unit.exists("target") and ni.player.power(1) > 17 and a.spellusable(B.Demoralizingscream) and
                    a.getrange("target", B.Rend)
             then
                local K = ni.unit.enemiesinrange("target", 6)
                for F = 1, #K do
                    local L = K[F].guid
                    if ni.unit.creaturetype(L) ~= 8 and not ni.unit.debuff(L, B.Demoralizingscream) then
                        ni.spell.cast(B.Demoralizingscream, L)
                        return true
                    end
                end
            end
        end,
        ["Overpower"] = function()
            if a.spellusable(B.Overpower) and ni.spell.valid("target", B.Overpower, true, true) then
                ni.spell.cast(B.Overpower, "target")
            end
        end,
        ["VictoryRush"] = function()
            if a.spellusable(B.VictoryRush) and ni.spell.valid("target", B.VictoryRush, true, true) then
                ni.spell.cast(B.VictoryRush, "target")
            end
        end,
        ["Execute"] = function()
            if a.spellusable(B.Execute) and ni.spell.valid("target", B.Execute, true, true) then
                ni.spell.cast(B.Execute, "target")
            end
        end,
        ["Racial"] = function()
            if C.sirus then
                local N = {
                    316445,
                    316466,
                    316396,
                    316239,
                    316246,
                    316256,
                    316274,
                    316280,
                    316290,
                    316295,
                    316373,
                    316382,
                    316387,
                    316407,
                    316414,
                    316422,
                    316432
                }
                for F = 1, #N do
                    if a.spellusable(N[F]) and a.getrange("target", B.Rend) then
                        ni.spell.cast(N[F])
                    end
                end
            end
        end,
        ["Bladestorm"] = function()
            if ni.vars.combat.cd and a.spellusable(B.Bladestorm) and a.getrange("target", B.Rend) then
                ni.spell.cast(B.Bladestorm)
            else
                local d, G = t("Bladestorm")
                if G then
                    if ni.vars.combat.aoe then
                        if a.spellusable(B.Bladestorm) and a.getrange("target", B.Rend) then
                            ni.spell.cast(B.Bladestorm)
                        end
                    end
                end
            end
        end,
        ["Rend"] = function()
            if
                not ni.unit.debuff("target", B.Rend, "player") and a.spellusable(B.Rend) and ni.unit.isboss("target") and
                    ni.spell.valid("target", B.Rend, true, true)
             then
                ni.spell.cast(B.Rend, "target")
            end
        end,
        ["Motrtalstrike"] = function()
            local d, G = t("Motrtalstrike")
            if G then
                if a.spellusable(B.Motrtalstrike) and ni.spell.valid("target", B.Motrtalstrike, true, true) then
                    ni.spell.cast(B.Motrtalstrike, "target")
                end
            end
        end
    }
    ni.bootstrap.profile("Arms", D, E, z, A)
else
    local D = {"Error"}
    local E = {["Error"] = function()
            ni.vars.profiles.enabled = false
            if b > 30300 then
                if GetLocale() == "ruRU" then
                    ni.frames.floatingtext:message("Только для 3.3.5a!")
                else
                    ni.frames.floatingtext:message("This profile for WotLK 3.3.5a!")
                end
            elseif a == nil then
                if GetLocale() == "ruRU" then
                    ni.frames.floatingtext:message("Riot-файл поврежден или отсуствует!")
                else
                    ni.frames.floatingtext:message("Riot file is missing or corrupted!")
                end
            end
        end}
    ni.bootstrap.profile("Riot", D, E)
end
