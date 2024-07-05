local a = ni.utils.require("Riot") or ni.utils.require("Riot.enc")
local b, c = select(4, GetBuildInfo()), false
if b == 30300 and a then
    local d, d, e = GetSpellInfo(48785)
    local d, d, f = GetSpellInfo(48782)
    local d, d, g = GetSpellInfo(53654)
    local d, d, h = GetSpellInfo(20186)
    local d, d, i = GetSpellInfo(48821)
    local d, d, j = GetSpellInfo(48788)
    local d, d, k = GetSpellInfo(47878)
    local d, d, l = GetSpellInfo(31821)
    local d, d, m = GetSpellInfo(6940)
    local d, d, n = GetSpellInfo(1038)
    local d, d, o = GetSpellInfo(31884)
    local d, d, p = GetSpellInfo(1022)
    local d, d, q = GetSpellInfo(4987)
    local d, d, r = GetSpellInfo(54428)
    local d, d, s = GetSpellInfo(642)
    local d, d, t = GetSpellInfo(31842)
    local d, d, u = GetSpellInfo(53601)
    local d, d, v = GetSpellInfo(53563)
    local d, d, w = GetSpellInfo(498)
    local d, d, x = GetSpellInfo(64205)
    hpotionIcon = "Interface\\Icons\\INV_Alchemy_Elixir_05"
    mpotionIcon = "Interface\\Icons\\INV_Alchemy_Elixir_02"
    local y = {osvob = 4}
    local z = {
        settingsfile = "HolyPaladin.js",
        {type = "title", text = "|cffFF6EB4Holy paladin by WH|r"},
        {type = "separator"},
        {type = "page", number = 1, text = "|cffFFFF00Важные CD|r"},
        {type = "separator"},
        {
            type = "entry",
            text = "\124T" .. o .. ":24:24\124t Гнев Карателя",
            tooltip = "Использовать гнев карателя когда, количество раненых союзников",
            enabled = true,
            value = 4,
            min = 1,
            max = 40,
            step = 1,
            width = 40,
            key = "AvengingWrathMembers"
        },
        {type = "title", text = "Количество здоровья, у раненых союзников|r"},
        {
            type = "input",
            enabled = true,
            value = 55,
            min = 0,
            max = 100,
            step = 1,
            width = 40,
            key = "AvengingWrathMembersHP"
        },
        {type = "separator"},
        {
            type = "entry",
            text = "\124T" .. l .. ":24:24\124t Мастер аур",
            tooltip = "Использовать мастер аур когда, количество раненых союзников",
            enabled = true,
            value = 4,
            min = 1,
            max = 40,
            step = 1,
            width = 40,
            key = "AuraMasteryMembers"
        },
        {type = "title", text = "Количество здоровья, у раненых союзников|r"},
        {
            type = "input",
            enabled = true,
            value = 45,
            min = 0,
            max = 100,
            step = 1,
            width = 40,
            key = "AuraMasteryMembersHP"
        },
        {type = "separator"},
        {type = "title", text = "|cffFFFF00Сейвы союзников|r"},
        {type = "separator"},
        {
            type = "entry",
            text = "\124T" .. x .. ":24:24\124t Священная жертва",
            tooltip = "Использовать священную жертву когда, количество раненых союзников",
            enabled = true,
            value = 5,
            min = 1,
            max = 40,
            step = 1,
            width = 40,
            key = "MassSacra"
        },
        {type = "title", text = "Количество здоровья, у раненых союзников|r"},
        {
            type = "input",
            enabled = true,
            value = 35,
            min = 0,
            max = 100,
            step = 1,
            width = 40,
            key = "MassSacraMembersHP"
        },
        {
            type = "entry",
            text = "\124T" .. m .. ":24:24\124t Длань жертвености",
            tooltip = "Использовать длань жертвенности, когда уровень здоровья союзника <=",
            enabled = true,
            value = 20,
            min = 5,
            max = 100,
            step = 1,
            width = 40,
            key = "HandOfSacrifice"
        },
        {
            type = "entry",
            text = "\124T" .. p .. ":24:24\124t Длань защиты",
            tooltip = "Использовать длань защиты, когда уровень здоровья союзника(Кроме танка) <=",
            enabled = true,
            value = 25,
            min = 5,
            max = 100,
            step = 1,
            width = 40,
            key = "HandOfProtectionn"
        },
        {
            type = "entry",
            text = "\124T" .. j .. ":24:24\124t Возложение рук",
            tooltip = "Использовать возложение рук, когда |cff00D700HP|r < % у танка < %.",
            enabled = true,
            value = 25,
            min = 10,
            max = 50,
            step = 1,
            width = 40,
            key = "LayingonOfHands"
        },
        {type = "title", text = "|cff8788EEДлань спасения|r"},
        {
            type = "dropdown",
            menu = {
                {selected = true, value = 1, text = "|cffADFF2F\124T" .. n .. ":20:20\124t Автоматический"},
                {selected = false, value = 2, text = "|cff00FF7F\124T" .. n .. ":20:20\124t По фокусу"},
                {selected = false, value = 0, text = "|cffFF0303Ручной режим|r"}
            },
            key = "Salva"
        },
        {type = "page", number = 2, text = "|cff00ff00Настройки исцеления|r"},
        {type = "separator"},
        {type = "title", text = "|cff8788EEСвященный щит|r"},
        {
            type = "dropdown",
            menu = {
                {selected = false, value = 1, text = "|cffffffff\124T" .. u .. ":20:20\124t На ОТ"},
                {selected = true, value = 2, text = "|cffffffff\124T" .. u .. ":20:20\124t На МТ"},
                {selected = true, value = 4, text = "|cffffffff\124T" .. u .. ":20:20\124t На себя"},
                {selected = false, value = 3, text = "|cffFF0303По фокусу|r"},
                {selected = false, value = 0, text = "|cffFF0303Ручной режим|r"}
            },
            key = "SacredShield"
        },
        {type = "title", text = "|cff8788EEЧастица света|r"},
        {
            type = "dropdown",
            menu = {
                {selected = false, value = 1, text = "|cffffffff\124T" .. v .. ":20:20\124t На ОТ"},
                {selected = true, value = 2, text = "|cffffffff\124T" .. v .. ":20:20\124t На МТ"},
                {selected = false, value = 3, text = "|cffFF0303По фокусу|r"},
                {selected = false, value = 0, text = "|cffFF0303Ручной режим|r"}
            },
            key = "Beacons"
        },
        {
            type = "entry",
            text = ni.spell.icon(48545) .. "Хилить вне боя",
            tooltip = "Хилит вне боя по |cff00D700HP|r < %",
            enabled = true,
            value = 70,
            min = 15,
            max = 95,
            step = 1,
            width = 40,
            key = "noncombatheal"
        },
        {
            type = "entry",
            text = "\124T" .. f .. ":24:24\124t Свет небес",
            tooltip = "Использовать свет небес, когда |cff00D700HP|r < % у персонажа < %.",
            enabled = true,
            value = 90,
            min = 25,
            max = 102,
            step = 1,
            width = 40,
            key = "LightOfHeaven"
        },
        {
            type = "entry",
            text = "Кол-во раненых",
            tooltip = "Использовать Свет небес когда, количество раненых союзников",
            value = 4,
            min = 0,
            max = 4,
            step = 1,
            width = 40,
            key = "Svetmembers"
        },
        {
            type = "entry",
            text = "\124T" .. i .. ":24:24\124t Шок небес",
            tooltip = "Использовать шок небес, когда |cff00D700HP|r < % у персонажа < %.",
            enabled = true,
            value = 75,
            min = 25,
            max = 100,
            step = 1,
            width = 40,
            key = "Shock"
        },
        {
            type = "entry",
            text = "\124T" .. e .. ":24:24\124t Вспышка света",
            tooltip = "Использовать вспышку света, когда |cff00D700HP|r < % у персонажа < %.",
            enabled = true,
            value = 95,
            min = 25,
            max = 100,
            step = 1,
            width = 40,
            key = "Holylight"
        },
        {
            type = "entry",
            text = "\124T" .. e .. ":24:24\124t Вспышка света на танка",
            tooltip = "Использовать вспышку света, для бафа на танке у которого священный щит",
            enabled = true,
            key = "HolylightBuff"
        },
        {type = "separator"},
        {
            type = "entry",
            text = "\124T" .. q .. ":24:24\124t Очищение",
            tooltip = "Использовать очищение",
            enabled = true,
            key = "Cleanse"
        },
        {type = "title", text = "|cffFFFFFFЗадержка для диспела|r"},
        {type = "input", enabled = true, value = 1, min = 0, max = 100, step = 1, width = 40, key = "Dispel"},
        {type = "page", number = 3, text = "|cff0000ffЗащитные настройки|r"},
        {type = "separator"},
        {
            type = "entry",
            text = "\124T" .. s .. ":24:24\124t Божественный щит",
            tooltip = "Использовать Божественный щит, когда |cff00D700HP|r < % у персонажа < %.",
            enabled = true,
            value = 25,
            min = 10,
            max = 60,
            step = 1,
            width = 40,
            key = "Buble"
        },
        {
            type = "entry",
            text = ni.spell.icon(25780) .. "Праведное неистовство",
            tooltip = "Использовать Праведное неистовство чтобы уменьшить получаемый урон(работает только если взят талант)",
            enabled = true,
            key = "Save"
        },
        {
            type = "entry",
            text = "\124T" .. w .. ":24:24\124t Половинка",
            tooltip = "Использовать половинку, когда был использован массовый сейв",
            enabled = true,
            key = "Polovinka"
        },
        {
            type = "entry",
            text = "\124T" .. k .. ":24:24\124t Камень здоровья",
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
            text = "\124T" .. mpotionIcon .. ":24:24\124t Зелье маны",
            tooltip = "Использовать зелье, когда |cff0082FFMP|r < % у персонажа < %.",
            enabled = true,
            value = 25,
            min = 15,
            max = 65,
            step = 1,
            width = 40,
            key = "manapotionuse"
        },
        {type = "page", number = 4, text = "|cff00C957Общие настройки|r"},
        {type = "separator"},
        {type = "title", text = "|cff8788EEПравосудия|r"},
        {
            type = "dropdown",
            menu = {
                {selected = false, value = 1, text = "\124T" .. h .. ":24:24\124t Правосудие мудрости"},
                {selected = false, value = 2, text = ni.spell.icon(20271) .. "Правосудие света"},
                {selected = false, value = 3, text = ni.spell.icon(53407) .. "Правосудие справедливости"},
                {selected = false, value = 0, text = "|cffFF0303Ручной режим|r"}
            },
            key = "Jaga"
        },
        {type = "separator"},
        {
            type = "entry",
            text = "\124T" .. r .. ":24:24\124t Святая клятва",
            tooltip = "Использовать святую клятву, когда |cff00D700MP|r < % у персонажа < %.",
            enabled = true,
            value = 40,
            min = 10,
            max = 65,
            step = 1,
            width = 40,
            key = "plea"
        },
        {
            type = "entry",
            text = "\124T" .. t .. ":24:24\124t Божественное просветление",
            tooltip = "Использовать святую клятву, когда |cff00D700MP|r < % у персонажа < %.",
            enabled = true,
            value = 25,
            min = 10,
            max = 90,
            step = 1,
            width = 40,
            key = "illumination"
        },
        {
            type = "entry",
            text = ni.spell.icon(69762) .. " Освобожденная магия",
            tooltip = "Количество набираемых стаков Освобожденной магии |cFF00FFFFЦлк(Синдрагоса)|r",
            value = 4,
            min = 1,
            max = 10,
            step = 1,
            key = "osvob"
        }
    }
    local function A(B)
        for C, D in ipairs(z) do
            if D.type == "entry" and D.key ~= nil and D.key == B then
                return D.value, D.enabled
            end
            if D.type == "dropdown" and D.key ~= nil and D.key == B then
                for E, F in pairs(D.menu) do
                    if F.selected then
                        return F.value
                    end
                end
            end
            if D.type == "input" and D.key ~= nil and D.key == B then
                return D.value
            end
        end
    end
    local function G()
        ni.GUI.AddFrame("HolyPaladin", z)
    end
    local function H()
        ni.GUI.DestroyFrame("HolyPaladin")
    end
    local I = {
        PlayerIsMoving = false,
        InCombat = false,
        GlyphChain = false,
        Controled = false,
        KnowCleanseSpirit = false,
        Sindra = false,
        Sindra = false,
        double = true,
        info = true,
        stopcast = false
    }
    local J = {
        Holylight = GetSpellInfo(48785),
        LightOfHeaven = GetSpellInfo(48782),
        ParticleOfLlight = GetSpellInfo(53654),
        JudgmentOfWisdom = GetSpellInfo(53408),
        HeavenShock = GetSpellInfo(48821),
        LayingonOfHandss = GetSpellInfo(48788),
        hstone = GetSpellInfo(47878),
        AuraMastery = GetSpellInfo(31821),
        HandOfSacrifice = GetSpellInfo(6940),
        HandOfSalvation = GetSpellInfo(1038),
        HandOfProtection = GetSpellInfo(10278),
        AvengingWrath = GetSpellInfo(31884),
        DivinePlea = GetSpellInfo(54428),
        Buble = GetSpellInfo(642),
        DivineIllumination = GetSpellInfo(31842),
        SacredShield = GetSpellInfo(53601),
        Beaconn = GetSpellInfo(53563),
        Polovinka = GetSpellInfo(498),
        MassSacra = GetSpellInfo(64205),
        HandOfFreedom = GetSpellInfo(1044),
        Cleanse = GetSpellInfo(4987),
        Jagaorg = GetSpellInfo(20271),
        Jagared = GetSpellInfo(53407),
        dobro = GetSpellInfo(20216),
        Shock = GetSpellInfo(48825),
        svet = GetSpellInfo(48782)
    }
    local K = {
        Sindra = GetSpellInfo(69766),
        morouz_kara_hm = GetSpellInfo(305470),
        magik_hm = GetSpellInfo(305131),
        Sindra_metka = GetSpellInfo(70126)
    }
    local L = {
        
        "Cache",
        "Pause",
        "Save",
        "Seal",
        "Non Combat Healing",
        "Combat specific Pause",
        "Healthstone (Use)",
        "Heal Potions (Use)",
        "Mana Potions (Use)",
        "Buble",
        "MassSacra",
        "Polovinka",
        "LayingonOfHands",
        "HandOfSacrifice",
        "HandOfProtection",
        "AvengingWrath",
        "AuraMastery",
        "HandOfSalvation",
        "DivineIllumination",
        "DivinePlea",
        "valitria",
        "Prohill_metok",
        "Low",
        "ShockOfHeaven",
        "LightofheavenLow",
        "Cleanse",
        "Jaga",
        "LightOfHeaven",
        "Beacon",
        "SacredShield",
        "FlashLight"
    }
    local M, N = 0, 0
    local O, P, Q = {}, {}, {}
    local R = {
        ["valitria"] = function()
            if ni.objectmanager.contains("Валитрия Сноходица") then
                local S = ni.objectmanager.objectGUID("Валитрия Сноходица")
                if
                    ni.spell.valid(S, J.chastitca, false, true, true) and not ni.unit.buff(S, J.chastitca, "player") and
                        ni.spell.available(J.chastitca)
                 then
                    ni.spell.cast(J.chastitca, S)
                else
                    if not I.PlayerIsMoving then
                        for T = 1, #ni.members.sort() do
                            local O = ni.members[T].unit
                            if not O:buff(J.chastitca, "player") then
                                local U = ni.members.inrangebelow(O, 7, 100)
                                if ni.spell.available(J.svet) and O:valid(J.svet, false, true, true) then
                                    if #U >= 3 then
                                        ni.spell.cast(J.svet, O)
                                        print("Валька 1")
                                    elseif #U >= 2 then
                                        ni.spell.cast(J.svet, O)
                                        print("Валька 2")
                                    elseif #U >= 1 then
                                        ni.spell.cast(J.svet, O)
                                        print("Валька 3")
                                    else
                                        ni.spell.cast(J.svet, O)
                                        print("Валька 4")
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end,
        ["Prohill_metok"] = function()
            if not I.PlayerIsMoving then
                for T = 1, #ni.members.sort() do
                    local O = ni.members[T].unit
                    if
                        O:debuff("Испепеление плоти") or
                            O:debuff("Пронизывающий холод") and ni.unit.debuff("player", "Жуки-трупоеды") or
                            O:debuff("Заражение")
                     then
                        if O:valid(J.Shock, false, true, true) and ni.spell.available(J.Shock) then
                            if ni.spell.available(J.dobro) then
                                ni.spell.cast(J.dobro, O)
                                print("прохил меток1")
                            end
                            if ni.player.buff(304704) then
                                ni.spell.cast(J.Shock, O)
                            elseif O:valid(J.svet, false, true, true) and ni.spell.available(J.svet) and not I.stopcast then
                                ni.spell.cast(J.svet, O)
                                print("Прохил меток 2")
                            end
                        end
                    end
                end
            end
            if ni.spell.available(J.dobro) or ni.player.buff(304704) then
                for T = 1, #ni.members do
                    local O = ni.members[T].unit
                    if
                        O:debuff(K.Sindra_metka) and not O:buff(319166) and O:valid(J.Shock, false, true, true) and
                            ni.spell.available(J.Shock)
                     then
                        if ni.spell.available(J.dobro) then
                            ni.spell.cast(J.dobro, O)
                        end
                        ni.spell.cast(J.Shock, O)
                        print("Прохил меток 3")
                    end
                end
            end
        end,
        ["Window"] = function()
            if not c then
                ni.frames.floatingtext:message("Holy pal By WH")
                print("|cffEE4000=======================================|r")
                print("|cffFFFF00Holy paladin by whoamiwow|r")
                print("|cff00C957v0.0.6 release|r")
                print("https://discord.gg/6wCgVRhQFs  ----- Wh Project")
                print("• Нажать кнопку АоЕ для переключения режимов")
                print("|cffEE4000=======================================|r")
                c = true
            end
        end,
        ["Cache"] = function()
            if GetTime() - N > 100 then
                ni.utils.resetlasthardwareaction()
                N = GetTime()
            end
            I.InCombat = UnitAffectingCombat("player") or false
            I.PlayerIsMoving = ni.player.ismoving() or false
            I.GlyphChain = ni.player.hasglyph(55437) or false
            I.Controled =
                ni.player.issilenced() or ni.player.isstunned() or ni.player.isconfused() or ni.player.isfleeing() or
                false
            I.stopcast =
                ni.unit.debuffremaining("player", 305131) > 2 or ni.unit.debuff("player", "Поцелуй Госпожи") or false
            if ni.objectmanager.contains("Повелитель горнов Игнис") then
                local V = ni.objectmanager.objectGUID("Повелитель горнов Игнис")
                local W, d, d, d, d, X = UnitCastingInfo(V)
                if W == "Струи пламени" then
                    I.stopcast = ni.unit.iscasting(V)
                end
            end
            if ni.objectmanager.contains("Фрейя") then
                local Y = ni.objectmanager.objectGUID("Фрейя")
                local W, d, d, d, d, X = UnitCastingInfo(Y)
                if W == "Дрожание земли" then
                    I.stopcast = ni.unit.iscasting(Y)
                end
            end
            if ni.objectmanager.contains("Полночь") then
                local Z = ni.objectmanager.objectGUID("Полночь")
                local W, d, d, d, d, X = UnitCastingInfo(Z)
                if W == "Могучий топот" then
                    I.stopcast = ni.unit.iscasting(Z)
                end
            end
            if ni.objectmanager.contains("Заклятый страж") then
                local _ = ni.objectmanager.objectGUID("Заклятый страж")
                local W, d, d, d, d, X = UnitCastingInfo(_)
                if W == "Разрушительный крик" then
                    I.stopcast = ni.unit.iscasting(_)
                end
            end
            I.Sindra = ni.unit.debuffstacks("player", 69766) <= y.osvob
            local W, d, d, d, d, X = UnitCastingInfo("player")
            if W == "Свет небес" then
                I.double = false
            elseif W ~= nil then
                I.double = true
            end
            if I.InCombat and GetTime() - M >= 15 then
                wipe(O)
                wipe(P)
                wipe(Q)
                M = GetTime()
            end
        end,
        ["Non Combat Healing"] = function()
            local a0, a1 = A("noncombatheal")
            if not a1 or UnitAffectingCombat("player") then
                return false
            end
            if a.spellusablesilence(J.Shock) and a.spellusablesilence(J.svet) then
                for T = 1, #ni.members do
                    local O = ni.members[1]
                    if O:hp() <= a0 and O:valid(J.svet, false, true, true) then
                        ni.spell.cast(J.Shock, O.unit)
                        return true
                    end
                    if not I.PlayerIsMoving then
                        ni.spell.cast(J.svet, O.unit)
                        return true
                    end
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
                    not UnitAffectingCombat("player") and ni.vars.followEnabled or
                    not I.Sindra
             then
                return true
            end
        end,
        ["Combat specific Pause"] = function()
            if UnitAffectingCombat("player") then
                return false
            end
            for T = 1, #ni.members do
                if UnitAffectingCombat(ni.members[T].unit) then
                    return false
                end
            end
            return true
        end,
        ["Heal Potions (Use)"] = function()
            local a0, a1 = A("healpotionuse")
            local a2 = {43569, 41166, 40087, 39671, 33934, 33447, 28100, 22829, 13446, 4596, 3928, 1710, 929, 858, 118}
            if a1 and ni.player.hp() < a0 and not ni.player.isstunned() and UnitAffectingCombat("player") then
                for T = 1, #a2 do
                    if ni.player.hasitem(a2[T]) and ni.player.itemcd(a2[T]) == 0 then
                        ni.player.useitem(a2[T])
                    end
                end
            end
        end,
        ["Low"] = function()
            local O = ni.members[1]
            if a.spellusablesilence(J.dobro) and O:hp() <= 45 and not ni.player.buff(J.dobro) then
                ni.spell.cast(J.dobro)
                return true
            end
        end,
        ["Healthstone (Use)"] = function()
            local a0, a1 = A("healthstoneuse")
            local a3 = {
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
            if a1 and ni.player.hp() < a0 and not ni.player.isstunned() and UnitAffectingCombat("player") then
                for T = 1, #a3 do
                    if ni.player.hasitem(a3[T]) and ni.player.itemcd(a3[T]) == 0 then
                        ni.player.useitem(a3[T])
                        return true
                    end
                end
            end
        end,
        ["Mana Potions (Use)"] = function()
            local a0, a1 = A("manapotionuse")
            local a4 = {43570, 42545, 40087, 40067, 33935, 33448, 28101, 22832, 13444, 13443, 6149, 3827, 3385, 2455}
            if a1 and ni.player.power(0) < a0 and not ni.player.isstunned() and UnitAffectingCombat("player") then
                for T = 1, #a4 do
                    if ni.player.hasitem(a4[T]) and ni.player.itemcd(a4[T]) == 0 then
                        ni.player.useitem(a4[T])
                    end
                end
            end
        end,
        ["Buble"] = function()
            local a0, a1 = A("Buble")
            if a1 then
                if
                    ni.spell.available(J.Buble) and a.spellusablesilence(J.Buble) and ni.player.hp() <= a0 and
                        not ni.player.debuff(25771)
                 then
                    ni.spell.cast(J.Buble)
                    return true
                end
            end
        end,
        ["DivineIllumination"] = function()
            local a0, a1 = A("illumination")
            if a1 then
                if
                    not ni.player.buff(J.DivineIllumination) and ni.player.power() <= a0 and
                        a.spellusablesilence(J.DivineIllumination) and
                        ni.spell.available(J.DivineIllumination)
                 then
                    ni.spell.cast(J.DivineIllumination)
                    return true
                end
            end
        end,
        ["DivinePlea"] = function()
            local a0, a1 = A("plea")
            if a1 then
                if not ni.player.buff(J.DivinePlea) and ni.player.power() <= a0 and ni.spell.available(J.DivinePlea) then
                    ni.spell.cast(J.DivinePlea)
                    return true
                end
            end
        end,
        ["Seal"] = function()
            if ni.spell.available(20166) and ni.player.hasglyph(54940) and not ni.player.buff(20166) then
                ni.spell.cast(20166)
                return true
            end
            if ni.spell.available(20165) and ni.player.hasglyph(54943) and not ni.player.buff(20165) then
                ni.spell.cast(20165)
                return true
            end
        end,
        ["LayingonOfHands"] = function()
            local a0, a1 = A("LayingonOfHands")
            if a1 then
                if a.spellusablesilence(J.LayingonOfHandss) then
                    for T = 1, #ni.members do
                        local O = ni.members[T]
                        if O:hp() <= a0 and not O:debuff(25771) and O:valid(J.LayingonOfHandss, false, true, true) then
                            ni.spell.cast(J.LayingonOfHandss, ni.members[T].unit)
                            return true
                        end
                    end
                end
            end
        end,
        ["AvengingWrath"] = function()
            local a0, a1 = A("AvengingWrathMembersHP")
            local a5 = A("AvengingWrathMembers")
            local a6 = ni.members.inrangebelow("player", 15, a0)
            if not a1 or not a.spellusablesilence(J.AvengingWrath) then
                return false
            end
            if #a6 >= a5 then
                for T = 1, #ni.members do
                    local O = ni.members[T]
                    if O:hp() <= a0 and O:valid(J.AvengingWrath, false, true) then
                        ni.spell.cast(J.AvengingWrath)
                        return true
                    end
                end
            end
        end,
        ["AuraMastery"] = function()
            local a0, a1 = A("AuraMasteryMembersHP")
            local a5 = A("AuraMasteryMembers")
            local a6 = ni.members.inrangebelow("player", 15, a0)
            if not a1 or not a.spellusablesilence(J.AuraMastery) then
                return false
            end
            if #a6 >= a5 then
                for T = 1, #ni.members do
                    local O = ni.members[T]
                    if O:hp() <= a0 and O:valid(J.AuraMastery, false, true) then
                        ni.spell.cast(J.AuraMastery)
                        return true
                    end
                end
            end
        end,
        ["Polovinka"] = function()
            local d, a1 = A("Polovinka")
            if a1 then
                for T = 1, #ni.members do
                    if ni.unit.buff("player", J.MassSacra, "player") then
                        if
                            ni.spell.available(J.Polovinka) and a.spellusablesilence(J.Polovinka) and
                                not ni.player.debuff(25771)
                         then
                            ni.spell.cast(J.Polovinka)
                            return true
                        end
                    end
                end
            end
        end,
        ["MassSacra"] = function()
            local a0, a1 = A("MassSacraMembersHP")
            local a5 = A("MassSacra")
            local a6 = ni.members.inrangebelow("player", 15, a0)
            if not a1 or not a.spellusablesilence(J.MassSacra) then
                return false
            end
            if #a6 >= a5 then
                for T = 1, #ni.members do
                    local O = ni.members[T]
                    if O:hp() <= a0 and O:valid(J.MassSacra, false, true) then
                        ni.spell.cast(J.MassSacra)
                        return true
                    end
                end
            end
        end,
        ["HandOfSacrifice"] = function()
            local a0, a1 = A("HandOfSacrifice")
            if a1 then
                for T = 1, #ni.members do
                    local O = ni.members[1]
                    if
                        O:hp() < a0 and not UnitIsUnit("player", O.unit) and not O:buff(1038) and not O:buff(6940) and
                            not O:buff(10278) and
                            ni.spell.available(J.HandOfSacrifice) and
                            a.spellusablesilence(J.HandOfSacrifice) and
                            O:valid(J.HandOfSacrifice, false, true, true)
                     then
                        ni.spell.cast(J.HandOfSacrifice, O.unit)
                        return true
                    end
                end
            end
        end,
        ["HandOfSalvation"] = function()
            local a0 = A("Salva")
            if a0 == 1 then
                for T = 1, #ni.members do
                    local O = ni.members[T]
                    if
                        O:threat() >= 1.5 and not ni.members[T].istank and not UnitIsUnit("player", O.unit) and
                            a.spellusablesilence(J.HandOfSalvation) and
                            not O:buff(1038) and
                            not O:buff(6940) and
                            not O:buff(10278) and
                            ni.spell.available(J.HandOfSalvation) and
                            O:valid(J.HandOfSalvation, false, true, true)
                     then
                        ni.spell.cast(J.HandOfSalvation, O.unit)
                        return true
                    end
                end
            end
            if a0 == 2 then
                if
                    ni.unit.threat("focus") >= 2 and not ni.unit.buff("focus", 1038) and not ni.unit.buff("focus", 6940) and
                        not ni.unit.buff("focus", 10278) and
                        a.spellusablesilence(J.HandOfSalvation) and
                        ni.spell.available(J.HandOfSalvation) and
                        ni.spell.valid("focus", J.HandOfSalvation, false, false, true)
                 then
                    ni.spell.cast(J.HandOfSalvation, "focus")
                end
                if a0 == 0 then
                    return false
                end
            end
        end,
        ["HandOfProtection"] = function()
            local a0, a1 = A("HandOfProtectionn")
            if a1 then
                if a.spellusablesilence(J.HandOfProtection) then
                    for T = 1, #ni.members do
                        local O = ni.members[T]
                        if O:hp() < a0 and not O.istank then
                            if
                                O:valid(J.HandOfProtection, false, true, true) and not O:debuff(25771) and
                                    not UnitIsUnit("player", O.unit) and
                                    not O:buff(1038) and
                                    not O:buff(6940) and
                                    not O:buff(10278) and
                                    not O:debuff(25771)
                             then
                                ni.spell.cast(J.HandOfProtection, O.unit)
                                return true
                            end
                        end
                    end
                end
            end
        end,
        ["Jaga"] = function()
            local a0, a1 = A("Jaga")
            if not a1 then
                if a0 == 0 then
                    return false
                end
                if a0 == 1 then
                    if
                        ni.spell.available(J.JudgmentOfWisdom) and a.spellusablesilence(J.JudgmentOfWisdom) and
                            not ni.unit.debuff("target", J.JudgmentOfWisdom, "player") and
                            ni.spell.valid("target", J.JudgmentOfWisdom, false, true)
                     then
                        ni.spell.cast(J.JudgmentOfWisdom, "target")
                        return true
                    end
                end
                if a0 == 2 then
                    if
                        ni.spell.available(J.Jagaorg) and a.spellusablesilence(J.Jagaorg) and
                            not ni.unit.debuff("target", J.Jagaorg, "player") and
                            ni.spell.valid("target", J.Jagaorg, false, true)
                     then
                        ni.spell.cast(J.Jagaorg, "target")
                        return true
                    end
                end
                if a0 == 3 then
                    if
                        ni.spell.available(J.Jagared) and a.spellusablesilence(J.Jagared) and
                            not ni.unit.debuff("target", J.Jagared, "player") and
                            ni.spell.valid("target", J.Jagared, false, true)
                     then
                        ni.spell.cast(J.Jagared, "target")
                        return true
                    end
                end
            end
        end,
        ["Save"] = function()
            local d, a1 = A("Save")
            if not a1 then
                return false
            end
            if not ni.player.buff(25780) and ni.spell.available(25780) then
                ni.spell.cast(25780)
                return true
            end
        end,
        ["Beacon"] = function()
            local a7 = A("Beacons")
            local a8, a9 = ni.tanks()
            if a.spellusablesilence(J.Beaconn) then
                if a7 == 0 then
                    return false
                end
                if a7 == 2 then
                    if a8 then
                        if UnitExists(a8.unit) then
                            if ni.spell.valid(a8.unit, J.Beaconn, false, true, true) then
                                if not ni.unit.buff(a8.unit, J.Beaconn, "player") then
                                    ni.spell.cast(J.Beaconn, a8.unit)
                                    return true
                                end
                            end
                        end
                    end
                    if a7 == 1 then
                        if a9 then
                            if UnitExists(a9.unit) then
                                if ni.spell.valid(a9.unit, J.Beaconn, false, true, true) then
                                    if not ni.unit.buff(a9.unit, J.Beaconn, "player") then
                                        ni.spell.cast(J.Beaconn, a9.unit)
                                        return true
                                    end
                                end
                            end
                        end
                        if a7 == 3 then
                            if ni.unit.exists("focus") then
                                if ni.spell.valid("focus", J.Beaconn, false, true, true) then
                                    if not ni.unit.buff("focus", J.Beaconn, "player") then
                                        ni.spell.cast(J.Beaconn, "focus")
                                        return true
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end,
        ["SacredShield"] = function()
            local aa = A("SacredShield")
            local a8, a9 = ni.tanks()
            if a.spellusablesilence(J.SacredShield) then
                if aa == 0 then
                    return false
                end
                if aa == 2 then
                    if a8 then
                        if UnitExists(a8.unit) then
                            if ni.spell.valid(a8.unit, J.SacredShield, false, true, true) then
                                if not ni.unit.buff(a8.unit, J.SacredShield, "player") then
                                    ni.spell.cast(J.SacredShield, a8.unit)
                                    return true
                                end
                            end
                        end
                    end
                    if aa == 1 then
                        if a9 then
                            if UnitExists(a9.unit) then
                                if ni.spell.valid(a9.unit, J.SacredShield, false, true, true) then
                                    if not ni.unit.buff(a9.unit, J.SacredShield, "player") then
                                        ni.spell.cast(J.SacredShield, a9.unit)
                                        return true
                                    end
                                end
                            end
                        end
                        if aa == 3 then
                            if ni.unit.exists("focus") then
                                if ni.spell.valid("focus", J.SacredShield, false, true, true) then
                                    if not ni.unit.buff("focus", J.SacredShield, "player") then
                                        ni.spell.cast(J.SacredShield, "focus")
                                        return true
                                    end
                                end
                            end
                        end
                        if aa == 4 then
                            if ni.unit.exists("player") then
                                if not ni.unit.buff("player", J.SacredShield) then
                                    ni.spell.cast(J.SacredShield, "player")
                                    return true
                                end
                            end
                        end
                    end
                end
            end
        end,
        ["Cleanse"] = function()
            local d, a1 = A("Cleanse")
            local a0 = A("Dispel")
            if a1 then
                if a.spellusablesilence(J.Cleanse) then
                    for T = 1, #ni.members.sort() do
                        local O = ni.members[T]
                        if
                            O:debufftype("Magic|Disease|Poison") and O:dispel() and not O:aura(J.Cleanse) and
                                O:valid(J.Cleanse, false, true)
                         then
                            ni.spell.delaycast(J.Cleanse, O.unit, delay)
                            return true
                        end
                    end
                end
            end
        end,
        ["LightOfHeaven"] = function()
            local a0, a1 = A("LightOfHeaven")
            local a5 = A("Svetmembers")
            local a6 = ni.members.inrangebelow("player", 15, a0)
            if not a1 or I.PlayerIsMoving or not a.spellusablesilence(J.svet) then
                return false
            end
            if #a6 >= a5 then
                for T = 1, #ni.members do
                    local O = ni.members[T]
                    if O:hp() <= a0 and O:valid(J.svet, false, true) then
                        ni.spell.cast(J.svet, O.unit)
                        return true
                    end
                end
            end
        end,
        ["ShockOfHeaven"] = function()
            local a0, a1 = A("Shock")
            if a1 then
                if ni.spell.available(J.HeavenShock) then
                    for T = 1, #ni.members do
                        local O = ni.members[T]
                        if
                            O:hp() < a0 and a.spellusablesilence(J.HeavenShock) and
                                O:valid(J.HeavenShock, false, true, true)
                         then
                            ni.spell.cast(J.HeavenShock, O.unit)
                            return true
                        end
                    end
                end
            end
        end,
        ["FlashLight"] = function()
            local a0, a1 = A("Holylight")
            if a1 then
                if a.spellusablesilence(J.Holylight) then
                    for T = 1, #ni.members do
                        local O = ni.members[T]
                        if O:hp() < a0 and not ni.player.ismoving() and O:valid(J.Holylight, false, true, true) then
                            ni.spell.cast(J.Holylight, O.unit)
                        end
                    end
                    local d, a1 = A("HolylightBuff")
                    if a1 then
                        for T = 1, #ni.members do
                            local O = ni.members[T]
                            if
                                a.spellusablesilence(J.Holylight) and O:buff(J.SacredShield) and
                                    not O:buff(J.Holylight, "player") and
                                    O:valid(J.Holylight, false, true, true)
                             then
                                ni.spell.cast(J.Holylight, O.unit)
                            end
                        end
                    end
                end
            end
        end,
        ["LightofheavenLow"] = function()
            if a.spellusablesilence(J.LightOfHeaven) then
                for T = 1, #ni.members do
                    local O = ni.members[T]
                    if O:hp() < 30 and not ni.player.ismoving() and O:valid(J.LightOfHeaven, false, true, true) then
                        ni.spell.cast(J.LightOfHeaven, O.unit)
                        return true
                    end
                end
            end
        end
    }
    ni.bootstrap.profile("HolyPaladin", L, R, G, H)
else
    local L = {"Error"}
    local R = {["Error"] = function()
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
    ni.bootstrap.profile("HolyPaladin", L, R)
end
