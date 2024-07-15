local Sirus = GetItemInfo(100455) ~= nil or false;

if Sirus then
local enables = {
    ["hex"] = true,
    ["decurs"] = true,
    ["sild_m"] = true,
    ["totem_mana"] = true,
    ["totems"] = true,
    ["ik"] = true,
    ["morouz_kara_hm"] = true,
    ["surok"] = true,
    ["lich"] = true,
    ["valitria"] = false,
    ["kamen"] = true,
    ["buff"] = true,
    ["kick"] = false,
    ["kick_2"] = false,
    ["kick_3"] = false,
    ["lich_"] = true,
    ["decurse_2"] = false,
    ["hill_pet"] = false,
}
local values = {
    osvob = 4,
}
local inputs = {
    kiick = "",
    decursee = "",
    decurseee = "Мертвящая чума",
}
local menus = {
}
local function GUICallback(key, item_type, value)
	if item_type == "enabled" then
		enables[key] = value;
	elseif item_type == "value" then
		values[key] = value;
	elseif item_type == "input" then
		inputs[key] = value;
	elseif item_type == "menu" then
		menus[key] = value;
	end
end
local items = {
    settingsfile = "rsham_by_makaren_wrath.json",
    callback = GUICallback,
    { type = "title", text = "Restoration Shaman by |c0000CED1Makaren|r" },
	{ type = "separator" },
	{ type = "title", text = "|cffFF7C0AProfile version 1.0.0|r" },
	{ type = "separator" },
    { type = "page", number = 1, text = "|cffFFFF00Общие настройки|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(24803).." Хилить петов", tooltip ="Хилит петов, с приоритетом ниже игроков ", enabled = false, key = "hill_pet" },
    { type = "entry", text = ni.spell.icon(51514).." Сглаз", tooltip ="Использует сглаз в |cFFFF0000МК|r", enabled = true, key = "hex" },
    { type = "entry", text = ni.spell.icon(51994).." Авто баф оружия", tooltip ="Автоматически бафает оружие", enabled = true, key = "buff" },
    { type = "entry", text = ni.spell.icon(57960).." Водный щит", tooltip ="Использует Водный щит при его отсутствии", enabled = true, key = "sild_m" },
    { type = "entry", text = ni.spell.icon(16190).." Тотем прилива маны", tooltip ="Использует Тотем прилива маны", enabled = true, key = "totem_mana" },
    { type = "entry", text = ni.spell.icon(66842).." Авто призыв тотемов", tooltip ="Автоматически призывает тотемы если их нет", enabled = true, key = "totems" },
    { type = "entry", text = ni.spell.icon(11729).." Камень здоровья", tooltip ="Использует камень здоровья |cFFFF0000в критические моменты|r", enabled = true, key = "kamen" },
    { type = "page", number = 2, text = "|cffFFFF00Диспел|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(51886).." Диспел", tooltip ="Диспелит все что может", enabled = true, key = "decurse" },
    { type = "entry", text = " Только конкретный дебаф", tooltip ="Диспелит только конкретный дебаф по имени", enabled = false, key = "decurse_2" },
    {
		type = "input",
		value = inputs["decursee"],
		width = 140,
		height = 15,
		key = "decursee"
	},
    { type = "title", text = " Игнорировать дебаф"},
    {
		type = "input",
		value = inputs["decurseee"],
		width = 140,
		height = 15,
		key = "decurseee"
	},
    { type = "page", number = 3, text = "|cffFFFF00Доп настройки|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(57994).." Автокик", tooltip ="Прерывает все заклинания", enabled = false, key = "kick" },
    { type = "entry", text = " Всех в радиусе действия", tooltip ="Прерывает всех в радиуе действия(не только таргет)", enabled = false, key = "kick_2" },
    { type = "entry", text = " Конкретный каст", tooltip ="Прерывает конкретный каст по имени", enabled = false, key = "kick_3" },
    {
		type = "input",
		value = inputs["kiick"],
		width = 140,
		height = 15,
		key = "kiick"
	},
    { type = "page", number = 4, text = "|cffFFFF00Авто-прохил меток|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(67049).." Испепеление плоти", tooltip ="|cFF00FFFFИк/Ивк(Джараксус)|r", enabled = true, key = "ik" },
    { type = "entry", text = ni.spell.icon(305470).." Метка Смерти", tooltip = "|cFF00FFFFКаражан хм(Мороуз)|r", enabled = true, key = "morouz_kara_hm" },	
    { type = "entry", text = ni.spell.icon(72293).." Метка падшего воителя", tooltip = "|cFF00FFFFЦлк(Саурфанк)|r", enabled = true, key = "surok" },
    { type = "entry", text = ni.spell.icon(68980).." Жатва душ", tooltip = "|cFF00FFFFЦлк(Лич)|r", enabled = true, key = "lich" },
    { type = "entry", text = ni.spell.icon(73779).." Заражение", tooltip = "|cFF00FFFFЦлк(Лич)|r", enabled = true, key = "lich_" },
    { type = "page", number = 5, text = "|cffFFFF00Настройки ротации|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(72589).." Исцеление ТОЛЬКО Валитрии", tooltip = "|cFF00FFFFЦлк(Валитрия)|r", enabled = false, key = "valitria" },
    { type = "title", text = "|cff95f900Если функция включена, то|r |cFFFF0000ИГНОРИРУЕТ|r |cff95f900рейд и хилит только Валитрию|r",},
    { type = "page", number = 6, text = "|cffFFFF00Настройки боссов|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(69762).." Освобожденная магия", tooltip ="Количество набираемых стаков Освобожденной магии |cFF00FFFFЦлк(Синдрагоса)|r", value = 4, min = 1, max = 10, step = 1, key = "osvob" },    
};
local function OnLoad()
	ni.GUI.AddFrame("rsham_by_makaren_wrath", items);
end;
local function OnUnLoad()  
	ni.GUI.DestroyFrame("rsham_by_makaren_wrath");
end;
local cache = {
    IsMoving = false,
    stopcast = false,
    sindra = false,
    PlayerCombat = false,
    info = true,
    };
local spells = {
    chaynik = GetSpellInfo(55459),
    orex = GetSpellInfo(49284),
    totem_mana = GetSpellInfo(16190),
    shild_mana = GetSpellInfo(57960),
    bistrina = GetSpellInfo(61301),
    decurse = GetSpellInfo(51886),
    char_rass = GetSpellInfo(316432),
    fast_cast = GetSpellInfo(16188),
    sila_priliva = GetSpellInfo(55198),
    volna = GetSpellInfo(49273),
    volna_malaya = GetSpellInfo(49276),
    hex = GetSpellInfo(51514),
    buf_volni = GetSpellInfo(53390),
    eb_ras = GetSpellInfo(51514),
    totems = GetSpellInfo(66842),
    kick = GetSpellInfo(57994),
    zem_or = GetSpellInfo(51994),
    };
local ddebuffs ={
    sindra = GetSpellInfo(69766),
    mk_ledy = GetSpellInfo(71289),
    curse_ledy = GetSpellInfo(71237),
    curse_grul_hm = GetSpellInfo(305230),
    morouz_kara_hm = GetSpellInfo(305470),
    magik_hm = GetSpellInfo(305131),
    sindra_metka = GetSpellInfo(70126),
    }
local queue = {
    "info",
    "cache",
    "stop",
    "char_rass",
    "save",
    "dispell",
    "kick",
    "buff",
    "spirit_lich",
    "Prohill_metok",
    "mana_shild",
    "totem_mana",
    "totems",
    "valitria",
    "orex",
    "chaynik_buff",
    "chaynik",
    "bistrina",
    "volna_save",
    "volna_tank",
    "malaya_volna",
    "pet_hill",
    "pet_dispell",
    "chaynik_prekast",
    "mana_shild_reset",
};
local abilities = {
    -----------------------------------
    ["info"] = function()
        if cache.info == true
        and not ni.vars.coin then
            cache.info = false
            print("|cFFFF0000  =========================|r\
|cFFFFFFFFРестор Шаман|r\
|cFFFF5A00Приватный профиль by Makaren|r\
|cFF00FFFFФанпей https://funpay.com/users/7303789/|r\
|cFF00FFFFДс https://discord.com/users/785141640087207966|r\
|cFF00FFFFДс Группы https://discord.gg/eQzcDHbVfm|r\
|cFFFF0000=========================|r")
        end
    end,
    ------------------------
    ["cache"] = function()
        cache.stopcast = ni.unit.debuffremaining("player", ddebuffs.magik_hm) > 2
        or ni.unit.debuff("player", "Поцелуй Госпожи") or false;
        if ni.objectmanager.contains("Повелитель горнов Игнис") then
            local ignis = ni.objectmanager.objectGUID("Повелитель горнов Игнис")
            local spell, _, _, _, _, endTime = UnitCastingInfo(ignis)
            if spell == ("Струи пламени") then
                cache.stopcast = ni.unit.iscasting(ignis)
            end
        end
        if ni.objectmanager.contains("Фрейя") then
            local freya = ni.objectmanager.objectGUID("Фрейя")
            local spell, _, _, _, _, endTime = UnitCastingInfo(freya)
            if spell == ("Дрожание земли") then
                cache.stopcast = ni.unit.iscasting(freya)
            end
        end
        if ni.objectmanager.contains("Полночь") then
            local polnoch = ni.objectmanager.objectGUID("Полночь")
            local spell, _, _, _, _, endTime = UnitCastingInfo(polnoch)
            if spell == ("Могучий топот") then
                cache.stopcast = ni.unit.iscasting(polnoch)
            end
        end
        if ni.objectmanager.contains("Заклятый страж") then
            local straz = ni.objectmanager.objectGUID("Заклятый страж")
            local spell, _, _, _, start, endTime = UnitCastingInfo(straz)
            if spell == ("Разрушительный крик") then
                cache.stopcast = ni.unit.iscasting(straz)
            end
        end
        cache.IsMoving = ni.player.ismoving() or false;
        cache.PlayerCombat = UnitAffectingCombat("player") or false;
        cache.sindra = ni.unit.debuffstacks("player", ddebuffs.sindra) <= values.osvob;
    end,
    -----------------------------------
    ["stop"] = function()
        if cache.stopcast then
	    if ni.unit.iscasting("player")
	    or ni.unit.ischanneling("player") then
             	ni.spell.stopcasting()
            end
        end
    end,
    --------------------------
    ["char_rass"] = function()
        if cache.sindra
        and ni.spell.available(spells.char_rass) then
            ni.spell.cast(spells.char_rass, "player")
          end
    end,
    -----------------------------------
    ["save"] = function()
        if cache.sindra
        and cache.PlayerCombat then
            count = GetItemCount("Фрагмент души")
            if ni.spell.available(316466)
            and not ni.unit.buff("player", 316466) then
                if count > 1 
                or ni.unit.hp("target") < 10 then
                    ni.spell.cast(316466)
                end
            end
            if ni.spell.available(316421)
            and ni.power.current("player") < 80 then
                ni.spell.cast(316421)
            end
            if ni.spell.available(316295)
            and ni.members.average() <= 90  then
                ni.spell.cast(316295)
            end
            if ni.spell.available(316422)
            and ni.members.average() <= 90 then
                ni.spell.cast(316422)
            end
            if ni.spell.available(319326)
            and ni.members.average() <= 90 then
                ni.spell.cast(319326)
            end
            for i = 1, #ni.members do
                local ally = ni.members[i].unit;
                if ni.spell.available(316447) then
                    ni.spell.cast(316447, ally)
                end
                if ni.spell.available(316162)
                and ni.members.average() <= 90 then
                    ni.spell.cast(316162, ally)
                end
                if ni.unit.buff("player", 316440)
                and cache.PlayerCombat
                and ni.player.hasitem(50085) then
                    ni.player.useitem(50085)
                end
            end
            if ni.player.buff("Благословение древних королей")
            and ni.player.slotcd(10) == 0
            or ni.player.slotcastable(10)
            and ni.members.average() <= 90
            and ni.player.slotcd(10) == 0 then
                ni.player.useinventoryitem(10)
            end
            if ni.player.buff("Благословение древних королей")
            and ni.player.slotcd(13) == 0
            or ni.player.slotcastable(13)
            and ni.members.average() <= 90
            and ni.player.slotcd(13) == 0 then
                ni.player.useinventoryitem(13)
            end
            if ni.player.buff("Благословение древних королей")
            and ni.player.slotcd(14) == 0
            or ni.player.slotcastable(14)
            and ni.members.average() <= 90
            and ni.player.slotcd(14) == 0 then
                ni.player.useinventoryitem(14)
            end
            if ni.spell.available(316396)
            and ni.spell.valid("target", 316396, false, true, true) then
                ni.spell.cast(316396)
            end
            local startTime, duration, enable = GetItemCooldown(36892)
        local startTime_, duration, enable = GetItemCooldown(36893)
        local startTime__, duration, enable = GetItemCooldown(36894)
        if enables["kamen"] then
            if startTime == 0
            and startTime_ == 0
            and startTime__ == 0 then
                if ni.player.hasitem(36892)
                or ni.player.hasitem(36893)
                or ni.player.hasitem(36894) then
                    if ni.unit.hp("player") < 30 then
                        if ni.unit.ttd("player") < 2 then
                            ni.player.useitem(36892)
                            ni.player.useitem(36893)
                            ni.player.useitem(36894)
                        end
                    end
                end
            end
        end
            if ni.spell.available(spells.sila_priliva)
            and ni.members.average() <= 90 then
                ni.spell.cast(spells.sila_priliva)
            end
            if ni.spell.available(spells.fast_cast)
            and ni.members.average() <= 90 then
                local allyOne = ni.members[1].unit;
                local ally = ni.members.inrangebelow(allyOne, 11, 99);
                if #ally >= 2
                        and ni.unit.buff(allyOne, spells.bistrina, "player")
                        and ni.spell.available(spells.chaynik)
				        and ni.spell.valid(allyOne, spells.chaynik, false, true, true) then
                            ni.spell.cast(spells.fast_cast)
					        ni.spell.cast(spells.chaynik, allyOne)
                end
                if #ally >= 2
                        and ni.spell.available(spells.chaynik)
				        and ni.spell.valid(allyOne, spells.chaynik, false, true, true) then
                            ni.spell.cast(spells.fast_cast)
					        ni.spell.cast(spells.chaynik, allyOne)
                end
            end
        end
    end,
    -----------------------------------
    ["dispell"] = function()
        for i = 1, #ni.members do
            local ally = ni.members[i].unit;
            if enables["decurse"] then
                if enables["decurse_2"]
                and inputs.decursee ~= "" then
                    if ni.healing.candispel(ally)
                    and ni.unit.debuff(ally, inputs.decursee)
                    and ni.spell.available(spells.decurse)
                    and ni.spell.valid(ally, spells.decurse, false, true, true) then
                        ni.spell.cast(spells.decurse, ally)
                    end
                elseif ni.healing.candispel(ally) then
                    if ni.spell.valid(ally, spells.decurse, false, true, true)
                    and not ni.unit.debuff(ally, inputs.decurseee)
                    and ni.spell.available(spells.decurse) then
                        ni.spell.cast(spells.decurse, ally)
                    end
                end
            end 
            if not cache.IsMoving
            and enables["hex"]
            and ni.spell.available(spells.hex)
            and ni.spell.valid(ally, spells.hex, false, true, true) then
                if ni.spell.available(spells.fast_cast) then
                    ni.spell.cast(spells.fast_cast)
                end
                ni.spell.cast(spells.hex, ally)
            end
            if ni.spell.valid(ally, spells.kick, false, true, true)
            and ni.spell.available(spells.kick)
            and ni.unit.iscasting(ally) then
                ni.spell.cast(spells.kick, ally)
            end
            if ni.spell.valid(ally, spells.kick, false, true, true)
            and ni.spell.available("Тотем заземления")
            and ni.unit.iscasting(ally) then
                ni.spell.cast("Тотем заземления")
            end
        end
    end,
    -----------------------------------
    ["kick"] = function()
        if enables["kick_3"] then
            if enables["kick"] then
                if enables["kick_2"] then
                    local enemies = ni.unit.enemiesinrange("player", 25)
                    for i = 1, #enemies do
                        local target = enemies[i].guid
                        if ni.unit.iscasting(target)
                        or ni.unit.ischanneling(target) then
                            local spell, rank, displayName, icon, startTime, endTime, isTradeSkill, castID, interrupt = UnitCastingInfo(target)
                            if inputs.kiick == ""
                            or inputs.kiick == spell then
                                if ni.spell.available(spells.kick)
                            and interrupt == false
                            and ni.spell.valid(target, spells.kick, false, true, true) then
                                ni.spell.cast(spells.kick, target)
                            end
                            end
                        end
                    end 
                elseif ni.unit.iscasting("target")
                or ni.unit.ischanneling("target") then
                    local spell, rank, displayName, icon, startTime, endTime, isTradeSkill, castID, interrupt = UnitCastingInfo("target")
                    if ni.spell.available(spells.kick)
                    and interrupt == false
                    and ni.spell.valid("target", spells.kick, false, true, true) then
                        ni.spell.cast(spells.kick)
                    end
                end
            end
        else
            if enables["kick"] then
                if enables["kick_2"] then
                    local enemies = ni.unit.enemiesinrange("player", 25)
                    for i = 1, #enemies do
                        local target = enemies[i].guid
                        if ni.unit.iscasting(target)
                        or ni.unit.ischanneling(target) then
                            local spell, rank, displayName, icon, startTime, endTime, isTradeSkill, castID, interrupt = UnitCastingInfo(target)
                            if ni.spell.available(spells.kick)
                            and interrupt == false
                            and ni.spell.valid(target, spells.kick, false, true, true) then
                                ni.spell.cast(spells.kick, target)
                            end
                        end
                    end 
                elseif ni.unit.iscasting("target")
                or ni.unit.ischanneling("target") then
                    local spell, rank, displayName, icon, startTime, endTime, isTradeSkill, castID, interrupt = UnitCastingInfo("target")
                    if ni.spell.available(spells.kick)
                    and interrupt == false
                    and ni.spell.valid("target", spells.kick, false, true, true) then
                        ni.spell.cast(spells.kick)
                    end
                end
            end
        end
    end,
    -----------------------------------
    ["buff"] = function()
        if enables["buff"] then
            local hasMainHandEnchant, mainHandExpiration, mainHandCharges, mainHandEnchantID, hasOffHandEnchant, offHandExpiration, offHandCharges, offHandEnchantID = GetWeaponEnchantInfo()
            if hasMainHandEnchant ~= 1 then
                ni.spell.cast(spells.zem_or)
            end
        end
    end,
    -----------------------------------
    ["spirit_lich"] = function()
        if ni.objectmanager.contains("Теренас Менетил") then
            local spirit_lich = ni.objectmanager.objectGUID("Теренас Менетил")
            if ni.player.buff("Приливные волны")
            and not cache.IsMoving then
                if ni.spell.valid(spirit_lich, spells.volna, false, true, true)
                and ni.spell.available(spells.volna) then
                    ni.spell.cast(spells.volna, spirit_lich)
                end
            elseif ni.spell.valid(spirit_lich, spells.chaynik, false, true, true)
            and ni.spell.available(spells.chaynik) then
                ni.spell.cast(spells.chaynik, spirit_lich)
            elseif ni.spell.available(spells.bistrina) then
            ni.spell.cast(spells.bistrina, spirit_lich)
            end
        end
    end,
    -----------------------------------
    ["Prohill_metok"] = function()
        if enables["ik"] then
            if not cache.IsMoving
            and not cache.stopcast then
                for i = 1, #ni.members do
                    local ally = ni.members[i].unit;
                        if ni.members[i]:debuff("Испепеление плоти") then
                            if ni.player.buff("Приливные волны") then
                                if ni.spell.valid(ally, spells.volna, false, true, true)
                                and ni.spell.available(spells.volna) then
                                    ni.spell.cast(spells.volna, ally)
                                end
                            elseif ni.spell.valid(ally, spells.chaynik, false, true, true)
                            and ni.spell.available(spells.chaynik) then
                                ni.spell.cast(spells.chaynik, ally)
                            end
                        end
                end
            end
        end
        if enables["morouz_kara_hm"] then
            if not cache.IsMoving then
                for i = 1, #ni.members do
                    local ally = ni.members[i].unit;
                    if ni.members[i]:debuff(ddebuffs.morouz_kara_hm)
                    and ni.unit.hp(ally) <= 90 then
                        if ni.player.buff("Приливные волны") then
                            if ni.spell.valid(ally, spells.volna, false, true, true)
                            and ni.spell.available(spells.volna) then
                                ni.spell.cast(spells.volna, ally)
                            end
                        elseif ni.spell.valid(ally, spells.chaynik, false, true, true)
                        and ni.spell.available(spells.chaynik) then
                            ni.spell.cast(spells.chaynik, ally)
                        end
                    end
                end
            end
        end
        if enables["surok"] then
            if not cache.IsMoving then
                for i = 1, #ni.members do
                    local ally = ni.members[i].unit;
                    if ni.members[i]:debuff("Метка падшего воителя") then
                        if ni.player.buff("Приливные волны") then
                            if ni.spell.valid(ally, spells.volna, false, true, true)
                            and ni.spell.available(spells.volna) then
                                ni.spell.cast(spells.volna, ally)
                            end
                        elseif ni.spell.valid(ally, spells.chaynik, false, true, true)
                        and ni.spell.available(spells.chaynik) then
                            ni.spell.cast(spells.chaynik, ally)
                        end
                    end
                end
            end
        end
        if enables["lich"] then
            if not cache.IsMoving then
                for i = 1, #ni.members do
                    local ally = ni.members[i].unit;
                    if ni.members[i]:debuff("Жатва душ")
                    or ni.members[i]:debuff("Великая жатва душ") then
                        if ni.player.buff("Приливные волны") then
                            if ni.spell.valid(ally, spells.volna, false, true, true)
                            and ni.spell.available(spells.volna) then
                                ni.spell.cast(spells.volna, ally)
                            end
                        elseif ni.spell.valid(ally, spells.chaynik, false, true, true)
                        and ni.spell.available(spells.chaynik) then
                            ni.spell.cast(spells.chaynik, ally)
                        end
                    end
                end
            end
        end
        if enables["lich_"] then
            if not cache.IsMoving then
                for i = 1, #ni.members do
                    local ally = ni.members[i].unit;
                    if ni.members[i]:debuff("Заражение") then
                        if ni.spell.valid(ally, spells.chaynik, false, true, true)
                        and ni.spell.available(spells.chaynik) then
                            ni.spell.cast(spells.chaynik, ally)
                        end
                    end
                end
            end
        end
	if ni.unit.debuff("player", "Жуки-трупоеды") then
            if not cache.IsMoving then
                for i = 1, #ni.members do
                    local ally = ni.members[i].unit;
                    if ni.members[i]:debuff("Пронизывающий холод") then
                        if ni.spell.valid(ally, spells.chaynik, false, true, true)
                        and ni.spell.available(spells.chaynik) then
                            ni.spell.cast(spells.chaynik, ally)
                        end
                    end
                end
            end
        end
    end,
    -----------------------------------
    ["mana_shild"] = function()
        if enables["sild_m"]
        and cache.sindra
        and not ni.player.buff(spells.shild_mana) then
            ni.spell.cast(spells.shild_mana)
          end
    end,
    -----------------------------------
    ["totem_mana"] = function()
        if enables["totem_mana"]
        and cache.PlayerCombat
        and ni.power.current("player") <= 80
        and ni.spell.available(spells.totem_mana) then
            ni.spell.cast(spells.totem_mana)
          end
    end,
    -----------------------------------
    ["totems"] = function()
        if enables["totems"]
        and cache.PlayerCombat then
            local haveTotem, totemName = GetTotemInfo(3)
            if totemName ~= "Тотем прилива маны" then
                for index=1,4 do
                    local haveTotem, totemName, startTime, duration = GetTotemInfo(index)
                    if duration == 0 then
                        ni.spell.cast(spells.totems)
                    end
                end
            end
        end
    end,
    -----------------------------------
    ["valitria"] = function()
        if ni.objectmanager.contains("Валитрия Сноходица") then
            local valitria = ni.objectmanager.objectGUID("Валитрия Сноходица")
                if enables["valitria"]
                or ni.members.average() > 95 then
                    if ni.player.buff("Приливные волны") then
                        if not cache.IsMoving
                        and ni.spell.valid(valitria, spells.volna, false, true, true)
                        and ni.spell.available(spells.volna) then
                            ni.spell.cast(spells.volna, valitria)
                        end
                    elseif not cache.IsMoving
                    and ni.spell.valid(valitria, spells.chaynik, false, true, true)
                    and ni.spell.available(spells.chaynik) then
                        ni.spell.cast(spells.chaynik, valitria)
                    elseif ni.spell.available(spells.bistrina) then
                        ni.spell.cast(spells.bistrina, valitria)
                    end
                end
    end
end,
-----------------------------------
    ["orex"] = function()
        if cache.sindra
        and ni.spell.valid("focus", spells.orex, false, true, true)
        and not ni.unit.buff("focus", spells.orex)
        and ni.spell.available(spells.orex) then
            ni.spell.cast(spells.orex, "focus")
          end
    end,
    -----------------------------------
    ["chaynik_buff"] = function()
        for i = 1, #ni.members.sort() do
            local ally = ni.members[i].unit;
            local range = ni.members.inrangebelow(ally, 14, 99);
            if ni.unit.hp(ally) <= 99
            and #range >= 1
            and ni.spell.available(spells.chaynik)
			and ni.spell.valid(ally, spells.chaynik, false, true, true)
            and ni.unit.buff(ally, spells.bistrina) then
				ni.spell.cast(spells.chaynik, ally)
            end
        end
    end,
    -----------------------------------
    ["chaynik"] = function()
        for i = 1, #ni.members.sort() do
            local ally = ni.members[i].unit;
            local range = ni.members.inrangebelow(ally, 14, 99);
            if ni.unit.hp(ally) <= 99
            and #range >= 1
            and ni.spell.available(spells.chaynik)
			and ni.spell.valid(ally, spells.chaynik, false, true, true) then
				ni.spell.cast(spells.chaynik, ally)
            end
        end
    end,
    -----------------------------------
    ["bistrina"] = function()
        for i = 1, #ni.members.sort() do
            local ally = ni.members[i].unit;
                if cache.sindra
                and ni.unit.hp(ally) <= 90
                and ni.spell.available(spells.bistrina)
                and ni.spell.valid(ally, spells.bistrina, false, true, true)
                and not ni.unit.buff(ally, spells.bistrina, "player") then
                    if ni.spell.available("Дар Бездны") then
                        ni.spell.cast("Дар Бездны")
                    end
                    ni.spell.cast(spells.bistrina, ally)
                end
        end
    end,
    -----------------------------------
    ["volna_save"] = function()
        for i = 1, #ni.members.sort() do
            local ally = ni.members[i].unit;
            if cache.sindra
            and not cache.IsMoving
            and not cache.stopcast then
                if ni.unit.hp(ally) <= 20
                and ni.unit.buff("player", spells.buf_volni)
                and ni.unit.ttd(ally) < 3
                and ni.spell.available(spells.volna)
                and ni.spell.valid(ally, spells.volna, false, true, true) then
                    ni.spell.cast(spells.volna, ally)
                end
            end
        end
    end,
    -----------------------------------
    ["volna_tank"] = function()
        for i = 1, #ni.members do
            local ally = ni.members[i].unit;
                if cache.sindra
                and not cache.IsMoving
                and not cache.stopcast
                and ni.members[i]:istank()
                and ni.player.buff("Приливные волны")
                and ni.unit.hp(ally) <= 65
                and ni.spell.available(spells.volna)
                and ni.spell.valid(ally, spells.volna, false, true, true) then
                    ni.spell.cast(spells.volna, ally)
                end
        end
    end,
    -----------------------------------
    ["malaya_volna"] = function()
        for i = 1, #ni.members.sort() do
            local ally = ni.members[i].unit;
                if cache.sindra
                and not cache.IsMoving
                and not cache.stopcast
                and ni.unit.hp(ally) <= 90
                and ni.spell.available(spells.volna_malaya)
                and ni.spell.valid(ally, spells.volna_malaya, false, true, true) then
                    ni.spell.cast(spells.volna_malaya, ally)
                end
        end
    end,
    -----------------------------------
    ["pet_hill"] = function()
        if cache.sindra
	and enables["hill_pet"]
        and cache.PlayerCombat
        and not cache.IsMoving
        and not cache.stopcast then
            for i = 1, #ni.members do
                local ally = ni.members[i].unit;
                local creations = ni.unit.creations(ally);
                for i = 1, #creations do
                    local pet = creations[i].guid
                    if ni.unit.hp(pet) <= 20
                    and ni.player.buff("Приливные волны")
                    and ni.spell.valid(pet, spells.volna, false, true, true) then
                        ni.spell.cast(spells.volna, pet)
                    elseif ni.unit.hp(pet) <= 95
                    and not ni.unit.buff(pet, spells.volna_malaya, "player")
                    and ni.spell.valid(pet, spells.volna_malaya, false, true, true) then
                        ni.spell.cast(spells.volna_malaya, pet)
                    end
                end
            end
        end
end,
-----------------------------------
["pet_dispell"] = function()
    if cache.sindra
    and cache.PlayerCombat then
        for i = 1, #ni.members do
            local ally = ni.members[i].unit;
            local creations = ni.unit.creations(ally);
            for i = 1, #creations do
                local pet = creations[i].guid
                if enables["decurse"] then
                    if enables["decurse_2"]
                    and inputs.decursee ~= "" then
                        if ni.unit.debufftype(pet, "Poison|Curse|Disease")
                        and ni.unit.debuff(pet, inputs.decursee)
                        and ni.spell.available(spells.decurse)
                        and ni.spell.valid(pet, spells.decurse, false, true, true) then
                            ni.spell.cast(spells.decurse, pet)
                        end
                    elseif ni.unit.debufftype(pet, "Poison|Curse|Disease")
                    and ni.spell.valid(pet, spells.decurse, false, true, true)
                        and not ni.unit.debuff(pet, inputs.decurseee)
                        and ni.spell.available(spells.decurse) then
                            ni.spell.cast(spells.decurse, pet)
                        end
                    end
            end
        end
    end
end,
    -----------------------------------
    ["chaynik_prekast"] = function()
        for i = 1, #ni.members do
            local ally = ni.members[i].unit;
                if cache.sindra
                and not cache.IsMoving
                and not cache.stopcast
                and ni.vars.combat.aoe
                and ni.spell.valid(ally, spells.chaynik, false, true, true) then
                    ni.spell.cast(spells.chaynik, ally)
                end
        end
    end,
    -----------------------------------
    ["mana_shild_reset"] = function()
        if enables["sild_m"]
        and cache.sindra
        and cache.IsMoving
        and ni.unit.buffstacks("player", spells.shild_mana) < 4 then
            ni.spell.cast(spells.shild_mana)
          end
    end,
    -----------------------------------
};
	ni.bootstrap.profile("rsham_by_makaren_wrath", queue, abilities, OnLoad, OnUnLoad);
else
	local queue = {
        "Error",
    };
    local abilities = {
        ["Error"] = function()
            ni.vars.profiles.enabled = false;
			if not Sirus then
				ni.frames.floatingtext:message("Only for SIRUS.SU")
			end
        end,
    };
    ni.bootstrap.profile("rsham_by_makaren_wrath", queue, abilities);
end;