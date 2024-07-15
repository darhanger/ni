local a = ni.utils.require("Riot") or ni.utils.require("Riot.enc")
local b, c = select(4, GetBuildInfo()), false
if b == 30300 and a then
    local d, d, e = GetSpellInfo(47878)
    local d, d, f = GetSpellInfo(48263)
    local d, d, g = GetSpellInfo(48265)
    local d, d, h = GetSpellInfo(49016)
    local d, d, i = GetSpellInfo(56222)
    local d, d, j = GetSpellInfo(49560)
    local d, d, k = GetSpellInfo(48982)
    local d, d, l = GetSpellInfo(55233)
    local d, d, m = GetSpellInfo(49924)
    local d, d, n = GetSpellInfo(48743)
    local d, d, o = GetSpellInfo(49937)
    local d, d, p = GetSpellInfo(47528)
    local d, d, q = GetSpellInfo(47476)
    hpotionIcon = "Interface\\Icons\\INV_Alchemy_Elixir_05"
    mpotionIcon = "Interface\\Icons\\INV_Alchemy_Elixir_02"
    local r = {
        settingsfile = "GDK.json",
        {type = "title", text = "|cffFFFFFFGdk by WH|r"},
        {type = "separator"},
        {type = "page", number = 1, text = "|cffFFFF00Главные настройки|r"},
        {type = "separator"},
        {type = "title", text = "|cff8788EEСтойки|r"},
        {
            type = "dropdown",
            menu = {
                {selected = false, value = 1, text = "\124T" .. f .. ":20:20\124t Власть льда"},
                {selected = false, value = 2, text = "\124T" .. g .. ":20:20\124t Власть нечестивости"},
                {selected = true, value = 3, text = "|cffFF0303Автоматический режим|r"}
            },
            key = "Stance"
        },
        {type = "title", text = "|cff8788EEИстерия|r"},
        {
            type = "dropdown",
            menu = {
                {selected = true, value = 1, text = "\124T" .. h .. ":20:20\124t По фокусу"},
                {selected = false, value = 2, text = "\124T" .. h .. ":20:20\124t Автоматический"},
                {selected = false, value = 0, text = "|cffFF0303Ручной|r"}
            },
            key = "Isteria"
        },
        {type = "title", text = "|cff8788EEТемная власть|r"},
        {
            type = "dropdown",
            menu = {
                {selected = false, value = 1, text = "\124T" .. i .. ":20:20\124t Темная власть(По таргету)"},
                {
                    selected = true,
                    value = 2,
                    text = "\124T" .. i .. ":20:20\124t Темная власть(Всех противников в радиусе)"
                },
                {selected = false, value = 0, text = "|cffFF0303Ручной режим|r"}
            },
            key = "taunt"
        },
        {type = "title", text = "|cff8788EEХватка смерти|r"},
        {
            type = "dropdown",
            menu = {
                {selected = false, value = 1, text = "\124T" .. j .. ":20:20\124t Хватка смерти(По таргету)"},
                {
                    selected = true,
                    value = 2,
                    text = "\124T" .. j .. ":20:20\124t Хватка смерти(Всех противников в радиусе)"
                },
                {selected = false, value = 0, text = "|cffFF0303Ручной режим|r"}
            },
            key = "grip"
        },
        {
            type = "entry",
            text = "\124T" .. o .. ":24:24\124t Смерть и разложение",
            tooltip = "Использовать смерть и разложение(AOE)",
            enabled = true,
            key = "DaD"
        },
        {type = "separator"},
        {type = "title", text = "|cff8788EEНастройка прерываний|r"},
        {
            type = "entry",
            text = "\124T" .. p .. ":24:24\124t Заморозка Могзгов",
            tooltip = "Использовать заморозку мозгов для прерывания",
            enabled = true,
            key = "MindFreez"
        },
        {
            type = "entry",
            text = "\124T" .. q .. ":24:24\124t Удушение",
            tooltip = "Использовать удушение для перрывания",
            enabled = true,
            key = "MindFreez"
        },
        {type = "input", enabled = true, value = 70, min = 1, max = 100, step = 1, width = 40, key = "KikcPersent"},
        {type = "page", number = 2, text = "|cff00C957Защитные настройки|r"},
        {type = "separator"},
        {
            type = "entry",
            text = "\124T" .. e .. ":24:24\124t Камень здоровья",
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
            text = "\124T" .. k .. ":24:24\124t Захват рун",
            tooltip = "Использовать захват рун, когда |cff0082FFHP|r < % у персонажа < %.",
            enabled = true,
            value = 80,
            min = 15,
            max = 95,
            step = 1,
            width = 40,
            key = "Rune"
        },
        {
            type = "entry",
            text = "\124T" .. l .. ":24:24\124t Кровь вампира",
            tooltip = "Использовать кровь вампира, когда |cff0082FFHP|r < % у персонажа < %.",
            enabled = true,
            value = 25,
            min = 10,
            max = 60,
            step = 1,
            width = 40,
            key = "Vampir"
        },
        {
            type = "entry",
            text = "\124T" .. m .. ":24:24\124t Удар смерти",
            tooltip = "Использовать удар смерти, когда |cff0082FFHP|r < % у персонажа < %.",
            enabled = true,
            value = 75,
            min = 10,
            max = 60,
            step = 1,
            width = 40,
            key = "DeathStrike"
        },
        {
            type = "entry",
            text = "\124T" .. n .. ":24:24\124t Смертельный союз",
            tooltip = "Использовать смертельный союз, когда |cff0082FFHP|r < % у персонажа < %.",
            enabled = true,
            value = 25,
            min = 10,
            max = 75,
            step = 1,
            width = 40,
            key = "Union"
        }
    }
    local function s(t)
        for u, v in ipairs(r) do
            if v.type == "entry" and v.key ~= nil and v.key == t then
                return v.value, v.enabled
            end
            if v.type == "dropdown" and v.key ~= nil and v.key == t then
                for w, x in pairs(v.menu) do
                    if x.selected then
                        return x.value
                    end
                end
            end
            if v.type == "input" and v.key ~= nil and v.key == t then
                return v.value
            end
        end
    end
    local function y()
        ni.GUI.AddFrame("GDK", r)
    end
    local function z()
        ni.GUI.DestroyFrame("GDK")
    end
    local A = {
        Frost = GetSpellInfo(48263),
        Anholy = GetSpellInfo(48265),
        Lp = GetSpellInfo(49904),
        Gorn = GetSpellInfo(57623),
        UdarCumy = GetSpellInfo(49920),
        Grip = GetSpellInfo(49560),
        DeathandDecay = GetSpellInfo(49937),
        Taunt = GetSpellInfo(56222),
        Isteria = GetSpellInfo(49016),
        RunicStrike = GetSpellInfo(56815),
        Uro = GetSpellInfo(47568),
        Krovootvod = GetSpellInfo(45529),
        Udar = GetSpellInfo(55261),
        Mor = GetSpellInfo(50842),
        Vskipanie = GetSpellInfo(48721),
        Vampir = GetSpellInfo(55233),
        Rune = GetSpellInfo(48982),
        DeathStrike = GetSpellInfo(49924),
        MindFreez = GetSpellInfo(47528),
        DreneyRacial = GetSpellInfo(316280),
        MindFreez = GetSpellInfo(47528),
        Udus = GetSpellInfo(47476)
    }
    local B = {sirus = false}
    local C = {
        "ri",
        "Cache",
        "Stance",
        "Pause",
        "Combat specific Pause",
        "Healthstone (Use)",
        "Heal Potions (Use)",
        "Taunt",
        "Grip",
        "Vampir",
        "Union",
        "MindFreez",
        "DreneyRacial",
        "Rune",
        "DeathStrike",
        "Isteria",
        "DeathAndDecay",
        "RunicStrike",
        "Vskipanie",
        "Lp",
        "Crovootvod",
        "Cuma",
        "Mor",
        "Gorn"
    }
    local D = {
        ["ri"] = function()
            if not c then
                ni.frames.floatingtext:message("GDK dk By WH")
                print("|cffEE4000=======================================|r")
                print("|cffFFFF00Gdk Deathknight by whoamiwow|r")
                print("|cff00C957v0.0.5 release|r")
                print("https://discord.gg/6wCgVRhQFs  ----- Wh Project")
                print("• Нажать кнопку АоЕ для переключения режимов")
                print("|cffEE4000=======================================|r")
                c = true
            end
        end,
        ["Cache"] = function()
            B.sirus = a.sirusserver() or false
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
            local F, G = s("healpotionuse")
            local H = {43569, 41166, 40087, 39671, 33934, 33447, 28100, 22829, 13446, 4596, 3928, 1710, 929, 858, 118}
            if G and ni.player.hp() < F and not ni.player.isstunned() and UnitAffectingCombat("player") then
                for E = 1, #H do
                    if ni.player.hasitem(H[E]) and ni.player.itemcd(H[E]) == 0 then
                        ni.player.useitem(H[E])
                    end
                end
            end
        end,
        ["Healthstone (Use)"] = function()
            local F, G = s("healthstoneuse")
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
            if G and ni.player.hp() < F and not ni.player.isstunned() and UnitAffectingCombat("player") then
                for E = 1, #I do
                    if ni.player.hasitem(I[E]) and ni.player.itemcd(I[E]) == 0 then
                        ni.player.useitem(I[E])
                    end
                end
            end
        end,
        ["DreneyRacial"] = function()
            if
                ni.spell.available(A.DreneyRacial) and a.spellusable(A.DreneyRacial) and ni.unit.isboss("target") and
                    ni.spell.valid("target", A.DreneyRacial, true, true)
             then
                ni.spell.cast(A.DreneyRacial, "target")
            end
        end,
        ["RunicStrike"] = function()
            if
                a.spellusable(A.RunicStrike) and ni.spell.available(A.RunicStrike) and
                    ni.spell.valid("target", A.RunicStrike, true, true)
             then
                ni.spell.cast(A.RunicStrike, "target")
            end
        end,
        ["Lp"] = function()
            local J, K = ni.rune.frostrunecd()
            if a.spellusablesilence(A.Lp) and ni.spell.available(A.Lp) and ni.spell.valid("target", A.Lp, true, true) then
                ni.spell.cast(A.Lp, "target")
            end
        end,
        ["Union"] = function()
            local F, G = s("Union")
            if G then
                if ni.spell.available(46584) and ni.player.hp() <= F then
                    ni.spell.cast(46584)
                else
                    if ni.spell.available(48743) and ni.spell.cd(46584) == 0 and ni.player.hp() <= F then
                        ni.spell.cast(48743)
                    end
                end
            end
        end,
        ["Gorn"] = function()
            if a.spellusablesilence(A.Gorn) and ni.spell.available(A.Gorn) then
                ni.spell.cast(A.Gorn)
            end
        end,
        ["Crovootvod"] = function()
            local J, K = ni.rune.frostrunecd()
            if
                ni.spell.cd(A.Krovootvod) and ni.unit.isboss("target") and ni.rune.frostrunecd() >= 2 and
                    not ni.vars.combat.aoe and
                    a.getrange("target", A.Lp) and
                    ni.spell.cd(A.Krovootvod) == 0
             then
                ni.spell.cast(A.Krovootvod)
            end
        end,
        ["MindFreez"] = function()
            local d, G = s("MindFreez")
            local F = s("KikcPersent")
            if G then
                if ni.unit.iscasting("target") or ni.unit.ischanneling("target") then
                    if
                        ni.spell.available(A.MindFreez) and a.spellusable(A.MindFreez) and a.defensivecat("target") and
                            (ni.unit.castingpercent("target") >= F or ni.unit.channelpercent("target") >= F) and
                            ni.spell.valid("target", A.MindFreez, true, true)
                     then
                        ni.spell.cast(A.MindFreez, "target")
                    end
                end
            end
        end,
        ["Udus"] = function()
            local d, G = s("Udus")
            local F = s("KikcPersent")
            if G then
                if ni.unit.iscasting("target") or ni.unit.ischanneling("target") then
                    if
                        ni.spell.available(A.Udus) and a.spellusable(A.Udus) and a.defensivecat("target") and
                            (ni.unit.castingpercent("target") >= F or ni.unit.channelpercent("target") <= F) and
                            ni.spell.valid("target", A.Udus, true, true)
                     then
                        ni.spell.cast(A.Udus, "target")
                    end
                end
            end
        end,
        ["Vampir"] = function()
            local F, G = s("Vampir")
            if G then
                if ni.player.hp() <= F and ni.spell.available(A.Vampir) then
                    ni.spell.cast(A.Vampir)
                end
            end
        end,
        ["Rune"] = function()
            local F, G = s("Rune")
            if G then
                if ni.player.hp() <= F and ni.spell.available(A.Rune) then
                    ni.spell.cast(A.Rune)
                end
            end
        end,
        ["DeathStrike"] = function()
            local F, G = s("DeathStrike")
            if G then
                if
                    a.spellusable(A.DeathStrike) and ni.spell.available(A.DeathStrike) and
                        ni.unit.debuff("target", 59921, "player") and
                        ni.unit.debuff("target", 59879, "player") and
                        ni.player.hp() <= F and
                        ni.spell.valid("target", A.DeathStrike, true, true)
                 then
                    ni.spell.cast(A.DeathStrike, "target")
                end
            end
        end,
        ["Isteria"] = function()
            local F = s("Isteria")
            if F == 2 then
                for E = 1, #ni.members do
                    if ni.members[E].class == "DRUID" then
                        if
                            ni.unit.buff(ni.members[E].unit, 50334) and ni.spell.available(A.Isteria) and
                                not ni.unit.buff(ni.members[E].unit, A.Isteria) and
                                ni.spell.valid(ni.members[E].unit, A.Isteria, false, true, true)
                         then
                            ni.spell.cast(A.Isteria, ni.members[E].unit)
                        end
                    end
                end
                for E = 1, #ni.members do
                    if ni.members[E].class == "WARRIOR" then
                        if
                            not ni.unit.buff(ni.members[E].unit, 12292) and ni.spell.available(A.Isteria) and
                                ni.unit.isboss("target") and
                                not ni.unit.buff(ni.members[E].unit, A.Isteria) and
                                ni.spell.valid(ni.members[E].unit, A.Isteria, false, true, true)
                         then
                            ni.spell.cast(A.Isteria, ni.members[E].unit)
                        end
                    end
                end
                if F == 1 then
                    if
                        not ni.unit.buff("focus", 12292) and ni.spell.available(A.Isteria) and
                            not ni.unit.buff("focus", A.Isteria) and
                            ni.spell.valid("focus", A.Isteria, false, true, true)
                     then
                        ni.spell.cast(A.Isteria, "focus")
                    end
                end
                if
                    ni.unit.buff("focus", 50334) and ni.spell.available(A.Isteria) and
                        not ni.unit.buff("focus", A.Isteria) and
                        ni.spell.valid("focus", A.Isteria, false, true, true)
                 then
                    ni.spell.cast(A.Isteria, "focus")
                end
            end
        end,
        ["Stance"] = function()
            local F = s("Stance")
            if F == 1 then
                if ni.spell.available(A.Frost) and not ni.player.aura(A.Frost) then
                    ni.spell.cast(A.Frost)
                end
            end
            if F == 2 then
                if ni.spell.available(A.Anholy) and not ni.player.aura(A.Anholy) then
                    ni.spell.cast(A.Anholy)
                end
            end
            if F == 3 then
                if not UnitAffectingCombat("player") and ni.spell.available(A.Anholy) and not ni.player.aura(A.Anholy) then
                    ni.spell.cast(A.Anholy)
                end
            end
            if UnitAffectingCombat("player") and ni.spell.available(A.Frost) and not ni.player.aura(A.Frost) then
                ni.spell.cast(A.Frost)
            end
        end,
        ["Taunt"] = function()
            local F = s("taunt")
            if F == 1 then
                if
                    ni.unit.exists("targettarget") and UnitAffectingCombat("target") and a.spellusablesilence(A.Taunt) and
                        ni.unit.threat("player", "target") <= 2 and
                        ni.spell.available(A.Taunt) and
                        ni.spell.valid("target", A.Taunt, true, true)
                 then
                    ni.spell.cast(A.Taunt, "target")
                end
            end
            if F == 2 and ni.spell.available(A.Taunt) then
                local L = ni.unit.enemiesinrange("player", 30)
                for E = 1, #L do
                    local M = L[E].guid
                    if
                        ni.unit.threat("player", M) <= 2 and ni.unit.threat("player", M) ~= nil and
                            ni.spell.available(A.Taunt) and
                            a.spellusablesilence(A.Taunt) and
                            UnitAffectingCombat(M) and
                            ni.spell.valid(M, A.Taunt, true, true)
                     then
                        ni.spell.cast(A.Taunt, M)
                    end
                end
            end
            if F == 0 then
                return false
            end
        end,
        ["Grip"] = function()
            local F = s("grip")
            if F == 1 then
                if
                    ni.unit.exists("targettarget") and UnitAffectingCombat("target") and a.spellusablesilence(A.Grip) and
                        ni.unit.threat("player", "target") <= 2 and
                        ni.spell.available(A.Grip) and
                        not ni.spell.available(A.Taunt) and
                        ni.spell.valid("target", A.Grip, true, true)
                 then
                    ni.spell.cast(A.Grip, "target")
                end
            end
            if F == 2 and ni.spell.available(A.Grip) then
                local L = ni.unit.enemiesinrange("player", 30)
                for E = 1, #L do
                    local M = L[E].guid
                    if
                        ni.unit.threat("player", M) <= 2 and ni.unit.threat("player", M) ~= nil and
                            a.spellusablesilence(A.Grip) and
                            not ni.spell.available(A.Taunt) and
                            UnitAffectingCombat(M) and
                            ni.spell.valid(M, A.Grip, true, true)
                     then
                        ni.spell.cast(A.Grip, M)
                    end
                end
            end
            if F == 0 then
                return false
            end
        end,
        ["Cuma"] = function()
            if
                a.spellusablesilence(A.UdarCumy) and ni.spell.available(A.UdarCumy) and
                    not ni.unit.debuff("target", 59879, "player") and
                    ni.spell.valid("target", A.UdarCumy, true, true)
             then
                ni.spell.cast(A.UdarCumy, "target")
            end
        end,
        ["DeathAndDecay"] = function()
            local d, G = s("DaD")
            if G then
                if
                    ni.spell.available(A.DeathandDecay) and ni.vars.combat.aoe and a.spellusablesilence(A.DeathandDecay) and
                        a.getrange("target", A.Lp)
                 then
                    ni.spell.castat(A.DeathandDecay, "target")
                end
            end
        end,
        ["Mor"] = function()
            local L = ni.unit.enemiesinrange("target", 10)
            for E = 1, #L do
                local N = L[E].guid
                if
                    ni.unit.creaturetype(N) ~= 8 and a.spellusablesilence(A.Mor) and
                        not ni.unit.debuff(N, 59921, "player") and
                        not ni.unit.debuff(N, 59879, "player") or
                        ni.unit.debuffremaining(N, 59879, "player") <= 4 and a.spellusable(A.Mor) and
                            ni.spell.valid("target", A.Mor, true, true)
                 then
                    ni.spell.cast(A.Mor, "target")
                end
            end
        end,
        ["Vskipanie"] = function()
            local L = ni.unit.enemiesinrange("target", 10)
            for E = 1, #L do
                local N = L[E].guid
                if
                    ni.unit.creaturetype(N) ~= 8 and ni.vars.combat.aoe and ni.unit.debuff(N, 59921) and
                        ni.unit.debuff(N, 59879) and
                        ni.spell.available(A.Vskipanie)
                 then
                    ni.spell.cast(A.Vskipanie)
                end
            end
        end
    }
    ni.bootstrap.profile("GDK", C, D, y, z)
else
    local C = {"Error"}
    local D = {["Error"] = function()
            ni.vars.profiles.enabled = false
            if b > 30300 then
                if GetLocale() == "ruRU" then
                    ni.frames.floatingtext:message("Только для 3.3.5a!")
                else
                    ni.frames.floatingtext:message("This profile for WotLK 3.3.5a!")
                end
            elseif a == nil then
                if GetLocale() == "ruRU" then
                    ni.frames.floatingtext:message("riot-файл поврежден или отсуствует!")
                else
                    ni.frames.floatingtext:message("riot file is missing or corrupted!")
                end
            end
        end}
    ni.bootstrap.profile("GDK", C, D)
end
