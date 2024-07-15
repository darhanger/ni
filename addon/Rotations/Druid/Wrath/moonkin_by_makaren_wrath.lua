local Sirus = GetItemInfo(100455) ~= nil or false;

if Sirus then

local t4 = 0
if ni.player.hasitemequipped(29091) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(29092) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(29093) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(29094) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(29095) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100475) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100476) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100477) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100478) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100479) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101375) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101376) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101377) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101378) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101379) then
    t4 = t4 + 1
end
if t4 > 3 then
local enables = {
    ["target"] = true,
    ["dub_sindra_metka"] = true,
    ["dub_lich"] = true,
    ["dub_tuhliy"] = true,
    ["dub_grull"] = true,
    ["dub_anub"] = true,
    ["dub_koza"] = true,
    ["kamen"] = true,
    ["vo"] = true,
    ["decurse"] = true,
    ["smer"] = true,
    ["decurse_2"] = false,
    ["roy_sol"] = false,
    ["ents"] = false,
}
local values = {
    osvob = 4,
    kamen = 30,
    dub_koza = 40,
}
local inputs = {
    decursee = "",
    decurseee = "Мертвящая чума",
}
local menus = {
    ActionEvent = 1,
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
    settingsfile = "balans_4t4_by_makaren.json",
    callback = GUICallback,
    { type = "title", text = "Balans_Druid_4T4 by |c0000CED1Makaren|r" },
	{ type = "separator" },
	{ type = "title", text = "|cffFF7C0AProfile version 2.0.0|r" },
	{ type = "separator" },
    { type = "page", number = 1, text = "|cffFFFF00Общие настройки|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(69762).." Освобожденная магия", tooltip ="Количество набираемых стаков Освобожденной магии |cFF00FFFFЦлк(Синдрагоса)|r", value = 4, min = 1, max = 10, step = 1, key = "osvob" },    
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(6603).." Авто таргет", tooltip ="Автоматически выбирает таргет при его отсутствии", enabled = true, key = "target" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(770).." Волшебный огонь", tooltip ="Автоматически использует волшебный огонь при его отсутствии", enabled = true, key = "vo" },
    { type = "entry", text = ni.spell.icon(33786).." Смерч в мк", enabled = true, key = "smer" },
    { type = "separator" },
    { type = "dropdown", menu = { 
		{ selected = true, value = 1, text = "|cFF00FF00Опенинг с гнева" },
		{ selected = false, value = 2, text = "|cFF00FFFFОпенинг с ЗО" },
	}, key = "ActionEvent" },
    { type = "entry", text = ni.spell.icon(48468).." Рой под Солнечное затмение", enabled = false, key = "roy_sol" },
    { type = "entry", text = ni.spell.icon(33831).." Энты", enabled = false, key = "ents" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(24803).." Дебаг в чат", enabled = false, key = "debug" },
    { type = "page", number = 2, text = "|cffFFFF00Диспел|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(2782).." Диспел", tooltip ="Диспелит все что может", enabled = true, key = "decurse" },
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
    { type = "page", number = 3, text = "|cFFFF0000Защитные настройки|r" },
    { type = "separator" },
    { type = "title", text = "|cffFFFF00Дубовая кожа|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(22812).." Дубовая кожа", tooltip = "Использует Дубовую кожу при |cFF00FF00Hp <|r\
Работает в связке с функцией TTD(Time To Die)", enabled = true, value = 40, min = 1, max = 100, step = 1, key = "dub_koza" },
    { type = "entry", text = ni.spell.icon(67700).." Пронизывающий холод", tooltip = "Использует дубовую кожу под дебаф на 3 фазе|cFF00FFFF(Ануб ик/ивк)|r", enabled = true, key = "dub_anub" },
    { type = "entry", text = ni.spell.icon(70126).." Ледяная метка", tooltip ="Использует дубовую кожу под дебаф|cFF00FFFF(Синдрагоса цлк)|r", enabled = true, key = "dub_sindra_metka" },
    { type = "entry", text = ni.spell.icon(305185).." Адский удар", tooltip = "Использует дубовую кожу под каст|cFF00FFFF(Грулл хм)|r", enabled = true, key = "dub_grull" },    
    { type = "entry", text = ni.spell.icon(71219).." Едкая гниль", tooltip = "Использует дубовую кожу под каст|cFF00FFFF(Тухлопуз цлк)|r", enabled = true, key = "dub_tuhliy" },
    { type = "entry", text = ni.spell.icon(68980).." Жатва душ", tooltip = "Использует дубовую кожу под дебаф|cFF00FFFF(Лич цлк)|r", enabled = true, key = "dub_lich" },
    { type = "page", number = 4, text = "|cFFFF0000Защитные настройки|r" },
    { type = "separator" },
    { type = "title", text = "|cffFFFF00Предметы|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(11729).." Огурец", tooltip = "Использует Огурец при |cFF00FF00Hp <|r\
Работает в связке с функцией TTD(Time To Die)", enabled = true, value = 30, min = 1, max = 100, step = 1, key = "kamen" },
};
local function OnLoad()
	ni.GUI.AddFrame("balans_4t4_by_makaren", items);
end;
local function OnUnLoad()  
	ni.GUI.DestroyFrame("balans_4t4_by_makaren");
end;
local cache = {
    IsMoving = false,
    stopcast = false,
    sindra = false,
    PlayerCombat = false,
    info = true,
    no_buff = false,
    sme = false,
    cou = 0,
    control = false,
    buff_ = "",
    };
local spells = {
    roy = GetSpellInfo(48468),
    l_ogon = GetSpellInfo(48463),
    star = GetSpellInfo(53201),
    z_ogon = GetSpellInfo(48465),
    gnev = GetSpellInfo(48461),
    forma = GetSpellInfo(24858),
    buff_lun = GetSpellInfo(48518),
    buff_soln = GetSpellInfo(48517),
    dub = GetSpellInfo(22812),
    vo = GetSpellInfo(770),
    smerch = GetSpellInfo(33786),
    decurse = GetSpellInfo(2782),
    decurse_po = GetSpellInfo(2893),
    drev = GetSpellInfo(33831),
    };
local ddebuffs ={
    sindra = GetSpellInfo(69766),
    mk_ledy = GetSpellInfo(71289),
    curse_ledy = GetSpellInfo(71237),
    curse_grul_hm = GetSpellInfo(305230),
    morouz_kara_hm = GetSpellInfo(305470),
    magik_hm = GetSpellInfo(305131),
    sindra_metka = GetSpellInfo(70126),
    };
local queue = {
    "info",
    "cache",
    "stop",
    "pause",
    "save",
    "dispell",
    "auto-target",
    "forma",
    "vo",
    "cd",
    "gnev_start",
    "z_ogon_start",
    "lun_ogon",
    "star",
    "z_ogon",
    "drev",
    "roy_sol",
    "gnev",
    "roy",
};
local abilities = {
    -----------------------------------
    ["info"] = function()
        if cache.info == true
        and not ni.vars.coin then
            cache.info = false
            print("|cFFFF0000  =========================|r\
|cFFFFFFFFБаланс Друид|r\
|cFFFF5A00Приватный профиль by Makaren|r\
|cFF00FFFFФанпей https://funpay.com/users/7303789/|r\
|cFF00FFFFДс https://discord.com/users/785141640087207966|r\
|cFF00FFFFДс Группы https://discord.gg/eQzcDHbVfm|r\
|cFFFF0000=========================|r")
        end
    end,
    ------------------------
    ["cache"] = function()
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
            local spell, _, _, _, _, endTime = UnitCastingInfo(straz)
            if spell == ("Разрушительный крик") then
                cache.stopcast = ni.unit.iscasting(straz)
            end
        end
        cache.IsMoving = ni.player.ismoving() or false;
        cache.PlayerCombat = UnitAffectingCombat("player") or false;
        cache.stopcast = ni.unit.debuffremaining("player", ddebuffs.magik_hm) > 2
        or ni.unit.debuff("player", "Поцелуй Госпожи");
        cache.sindra = ni.unit.debuffstacks("player", ddebuffs.sindra) <= values.osvob;
        if not cache.PlayerCombat then
            if menus.ActionEvent == 1 then
                cache.buff_ = ""
            else
                cache.buff_ = "lun"
            end
        elseif menus.ActionEvent == 1 then
            cache.buff_ = ""
        else
            cache.buff_ = "lun"
        end
        if not ni.player.buff(spells.buff_lun)
        and not ni.player.buff(spells.buff_soln) then
            cache.no_buff = true
        else
            cache.no_buff = false
        end
        if cache.cou == 3 then
            cache.sme = false
            cache.cou = 0
        end
        if ni.unit.debuff("target", "Сглаз") 
        or ni.unit.debuff("target", "Устрашающий крик") 
        or ni.unit.debuff("target", "Гнев деревьев") 
        or ni.unit.debuff("target", "Смерч") 
        or ni.unit.debuff("target", "Превращение") 
        or ni.unit.debuff("target", "Замораживающая ловушка") 
        or ni.unit.debuff("target", "Покаяние") 
        or ni.unit.debuff("target", "Ослепление") 
        or ni.unit.debuff("target", "Ошеломление") 
        or ni.unit.debuff("target", "Вой ужаса") 
        or ni.unit.debuff("target", "Изгнание") 
        or ni.unit.debuff("target", "Страх") 
        or ni.unit.debuff("target", "Спячка") 
        or ni.unit.debuff("target", "Отпугивание зверя") 
        or ni.unit.debuff("target", "Ментальный крик") then
            cache.control = true
        else
            cache.control = false
        end
        if ni.player.buff(spells.buff_lun) then
            cache.buff_ = "lun"
        elseif ni.player.buff(spells.buff_soln) then
            cache.buff_ = "soln"
        end
        
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
    ------------------------
    ["pause"] = function()
        if IsMounted()
		or UnitInVehicle("player")
		or UnitIsDeadOrGhost("player")
		or UnitChannelInfo("player")
		or UnitCastingInfo("player")
		or ni.player.islooting()
        or not cache.sindra then
			return true;
		end
    end,
    -----------------------------------
    ["save"] = function()
            if enables["dub_sindra_metka"]
            and ni.unit.debuff("player", ddebuffs.sindra_metka)
            and ni.unit.debuffremaining("player", ddebuffs.sindra_metka) < 2
            and ni.spell.available(spells.dub) then
                ni.spell.cast(spells.dub, "player")
            end
            if enables["dub_lich"]
            and ni.unit.debuff("player", "Жатва душ")
            or ni.unit.debuff("player", "Великая жатва душ") then
                if ni.spell.available(spells.dub) then
                    ni.spell.cast(spells.dub, "player")
                end
            end
            if enables["dub_tuhliy"]
            and ni.objectmanager.contains("Тухлопуз") then
                local tuhlopuz = ni.objectmanager.objectGUID("Тухлопуз")
                local spell, _, _, _, _, endTime = UnitCastingInfo(tuhlopuz)
                if spell == ("Едкая гниль") then
                    if ni.spell.available(spells.dub) then
                        ni.spell.cast(spells.dub, "player")
                    end
                end
            end
            if enables["dub_grull"]
            and ni.objectmanager.contains("Груул Драконобой") then
                local grull = ni.objectmanager.objectGUID("Груул Драконобой")
                local spell, _, _, _, _, endTime = UnitCastingInfo(grull)
                if spell == ("Адский удар") then
                    if ni.spell.available(spells.dub) then
                        ni.spell.cast(spells.dub, "player")
                    end
                end
            end
            if enables["dub_anub"]
            and ni.unit.debuff("player", "Пронизывающий холод")
            and ni.unit.debuff("player", "Жуки-трупоеды")
            and ni.spell.available(spells.dub) then
                ni.spell.cast(spells.dub, "player")
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
                    if ni.unit.hp("player") < values.kamen then
                        if ni.unit.ttd("player") < 2 then
                            ni.player.useitem(36892)
                            ni.player.useitem(36893)
                            ni.player.useitem(36894)
                        end
                    end
                end
            end
        end
            if enables["dub"] then
                if ni.unit.hp("player") < values.dub_koza then
                    if ni.unit.ttd("player") < 3
                    and ni.spell.available(spells.dub) then
                        ni.spell.cast(spells.dub, "player")
                    end
                end
            end
    end,
    -----------------------------------
    ["dispell"] = function()
        for i = 1, #ni.members do
            local ally = ni.members[i].unit;
            if cache.sme == false then
                if not cache.IsMoving
                and ni.unit.debuffremaining(ally, spells.smerch, "player") < 1
                and ni.spell.available(spells.smerch)
                and ni.spell.lastcast(spells.smerch, 1.2)
                and ni.spell.valid(ally, spells.smerch, false, true, true) then
                    cache.sme = ni.members[i].guid
                    if ni.spell.available(spells.fast_cast) then
                        ni.spell.cast(spells.fast_cast)
                    end
                    ni.spell.cast(spells.smerch, ally)
                    cache.cou = cache.cou + 1
                end
            elseif not cache.IsMoving
            and ni.unit.debuffremaining(cache.sme, spells.smerch, "player") < 1
            and ni.spell.available(spells.smerch)
            and ni.spell.lastcast(spells.smerch, 1.2)
            and ni.spell.valid(cache.sme, spells.smerch, false, true, true) then
                if ni.spell.available(spells.fast_cast) then
                    ni.spell.cast(spells.fast_cast)
                end
                ni.spell.cast(spells.smerch, cache.sme)
                cache.cou = cache.cou + 1
            end
            if enables["decurse"] then
                if enables["decurse_2"]
                and inputs.decursee ~= "" then
                    if ni.healing.candispel(ally)
                    and ni.unit.debuff(ally, inputs.decursee)
                    and ni.spell.available(spells.decurse)
                    and ni.spell.valid(ally, spells.decurse, false, true, true) then
                        ni.spell.cast(spells.decurse, ally)
                    end
                    if ni.healing.candispel(ally)
                    and ni.unit.debuff(ally, inputs.decursee)
                    and ni.spell.valid(ally, spells.decurse_po, false, true, true)
                    and ni.spell.available(spells.decurse_po) then
                        ni.spell.cast(spells.decurse_po, ally)
                    end
                elseif ni.healing.candispel(ally) then
                    if ni.spell.valid(ally, spells.decurse, false, true, true)
                    and not ni.unit.debuff(ally, inputs.decurseee)
                    and ni.spell.available(spells.decurse) then
                        ni.spell.cast(spells.decurse, ally)
                    end
                    if ni.spell.valid(ally, spells.decurse_po, false, true, true)
                    and not ni.unit.debuff(ally, inputs.decurseee)
                    and ni.spell.available(spells.decurse_po) then
                        ni.spell.cast(spells.decurse_po, ally)
                    end
                end
                
            end 
        end 
    end,
    -----------------------------------
    ["auto-target"] = function()
        local target_ = ni.objects["target"];
        local target__ = target_.guid
        if enables["target"]
        and cache.PlayerCombat then
            if target__ == 0 then
                ni.player.runtext("/startattack")
            end
        end
    end,
    -----------------------------------
    ["forma"] = function()
        if not ni.player.buff(spells.forma, "player")then
            ni.spell.cast(spells.forma)
        end
    end,
    -----------------------------------
    ["vo"] = function()
        if enables["vo"]
	and ni.unit.isboss("target")
    and not cache.control
        and cache.PlayerCombat
        and not ni.unit.debuff("target", spells.vo) then
            ni.spell.cast(spells.vo, "target")
        end
    end,
    --------------------------
    ["cd"] = function()
        if cache.PlayerCombat
        and not cache.stopcast then
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
            if ni.spell.available(316422) then
                ni.spell.cast(316422)
            end
            if ni.spell.available(316447) then
                ni.spell.cast("target", 316467)
            end
            if ni.unit.buff("player", 316440)
            and cache.PlayerCombat
            and ni.player.hasitem(50085) then
                ni.player.useitem(50085)
            end
            if ni.player.slotcastable(10)
            and ni.player.buff(spells.buff_lun)
            and ni.spell.cd(spells.star) == 0
            and ni.player.slotcd(10) == 0 then
                ni.player.useinventoryitem(10)
            end
            if ni.player.slotcastable(13)
            and ni.player.slotcd(13) == 0
            and ni.player.buff(spells.buff_lun)
            and ni.spell.cd(spells.star) == 0 then
                ni.player.useinventoryitem(13)
            end
            if ni.player.slotcastable(14)
            and ni.player.slotcd(14) == 0
            and ni.player.buff(spells.buff_lun)
            and ni.spell.cd(spells.star) == 0 then
                ni.player.useinventoryitem(14)
            end
            if ni.spell.available(319326) then
                ni.spell.cast(319326)
            end
            if ni.spell.available(316295) then
                ni.spell.cast(316295)
            end
            if ni.spell.available(316396)
            and ni.spell.valid("target", 316396, false, true, true) then
                ni.spell.cast(316396)
            end
        end
    end,
    -----------------------------------
    ["gnev_start"] = function()
        if cache.buff_ == "soln"
        or cache.buff_ == "" then
            if not cache.stopcast
            and not cache.control
            and cache.no_buff == true
            and not cache.IsMoving
            and cache.PlayerCombat
            and ni.spell.available(spells.gnev)
            and ni.spell.valid("target", spells.gnev, false, true, true) then
                ni.spell.cast(spells.gnev, "target")
        end
        end
    end,
    -----------------------------------
    ["z_ogon_start"] = function()
        if cache.buff_ == "lun" then
            if not cache.IsMoving
        and not cache.control
        and cache.no_buff == true
	and not cache.stopcast
        and cache.PlayerCombat
        and ni.spell.available(spells.z_ogon)
        and ni.spell.valid("target", spells.z_ogon, false, true, true) then
            ni.spell.cast(spells.z_ogon, "target")
        end
        end
    end,
    -----------------------------------
    ["lun_ogon"] = function()
        if cache.PlayerCombat 
        and not cache.control
        and not ni.unit.debuff("target", spells.l_ogon, "player")
        and ni.spell.available(spells.l_ogon)
        and ni.spell.valid("target", spells.l_ogon, false, true, true) then
            ni.spell.cast(spells.l_ogon, "target")
        end
    end,
    -----------------------------------
    ["star"] = function()
        if ni.unit.isboss("target")
        or ni.vars.combat.cd then
            if cache.PlayerCombat
            and not cache.control
            and ni.spell.available(spells.star)
            and ni.spell.valid("target", spells.z_ogon, false, true, true) then
                ni.spell.cast(spells.star, "target")
            end
        end
    end,
    -----------------------------------
    ["z_ogon"] = function()
        if cache.PlayerCombat
	and not cache.stopcast
    and not cache.control
        and not cache.IsMoving
        and ni.spell.available(spells.z_ogon)
        and ni.spell.valid("target", spells.z_ogon, false, true, true) then
            if ni.player.buff(spells.buff_lun) then
                ni.spell.cast(spells.z_ogon, "target")
            end
        end
    end,
     -----------------------------------
    ["drev"] = function()
        if enables["ents"]
        and cache.PlayerCombat
        and not cache.control
	    and ni.spell.available(spells.drev)			
        and ni.player.buff(spells.buff_soln) then
	        if ni.unit.distance("player", "target") < 30 then
		        ni.spell.castat(spells.drev, "target")
	        else
		        ni.spell.castat(spells.drev, "player")
	        end 
        end
    end,
    -----------------------------------
    ["roy_sol"] = function()
        if enables["roy_sol"]
        and not cache.control
        and cache.PlayerCombat
        and not ni.unit.debuff("target", spells.roy, "player")
        and ni.spell.available(spells.roy)
        and ni.spell.valid("target", spells.roy, false, true, true) then
            ni.spell.cast(spells.roy, "target")
        end
    end,
    -----------------------------------
    ["gnev"] = function()
        if cache.PlayerCombat
	and not cache.stopcast
    and not cache.control
        and not cache.IsMoving
        and ni.player.buff(spells.buff_soln)
        and ni.spell.available(spells.gnev)
        and ni.spell.valid("target", spells.gnev, false, true, true) then
            ni.spell.cast(spells.gnev, "target")
        end
    end,
    -----------------------------------
    ["roy"] = function()
        if cache.IsMoving
        and not cache.control
        and cache.PlayerCombat
        and not ni.unit.debuff("target", spells.roy, "player")
        and ni.spell.available(spells.roy)
        and ni.spell.valid("target", spells.roy, false, true, true) then
            ni.spell.cast(spells.roy, "target")
        end
    end,
    --------------------------
};
ni.bootstrap.profile("moonkin_by_makaren_wrath", queue, abilities, OnLoad, OnUnLoad);
elseif t4 > 1 then
    local enables = {
        ["target"] = true,
    ["dub_sindra_metka"] = true,
    ["dub_lich"] = true,
    ["dub_tuhliy"] = true,
    ["dub_grull"] = true,
    ["dub_anub"] = true,
    ["dub_koza"] = true,
    ["kamen"] = true,
    ["vo"] = true,
    ["decurse"] = true,
    ["smer"] = true,
    ["decurse_2"] = false,
    ["roy_sol"] = false,
    ["ents"] = false,
    }
    local values = {
        osvob = 4,
    kamen = 30,
    dub_koza = 40,
    }
    local inputs = {
        decursee = "",
    decurseee = "Мертвящая чума",
    }
    local menus = {
        ActionEvent = 1,
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
        settingsfile = "balans_2t4_by_makaren.json",
        callback = GUICallback,
        { type = "title", text = "Balans_Druid_2T4 by |c0000CED1Makaren|r" },
        { type = "separator" },
	{ type = "title", text = "|cffFF7C0AProfile version 2.0.0|r" },
	{ type = "separator" },
    { type = "page", number = 1, text = "|cffFFFF00Общие настройки|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(69762).." Освобожденная магия", tooltip ="Количество набираемых стаков Освобожденной магии |cFF00FFFFЦлк(Синдрагоса)|r", value = 4, min = 1, max = 10, step = 1, key = "osvob" },    
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(6603).." Авто таргет", tooltip ="Автоматически выбирает таргет при его отсутствии", enabled = true, key = "target" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(770).." Волшебный огонь", tooltip ="Автоматически использует волшебный огонь при его отсутствии", enabled = true, key = "vo" },
    { type = "entry", text = ni.spell.icon(33786).." Смерч в мк", enabled = true, key = "smer" },
    { type = "separator" },
    { type = "dropdown", menu = { 
		{ selected = true, value = 1, text = "|cFF00FF00Опенинг с гнева" },
		{ selected = false, value = 2, text = "|cFF00FFFFОпенинг с ЗО" },
	}, key = "ActionEvent" },
    { type = "entry", text = ni.spell.icon(48468).." Рой под Солнечное затмение", enabled = false, key = "roy_sol" },
    { type = "entry", text = ni.spell.icon(33831).." Энты", enabled = false, key = "ents" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(24803).." Дебаг в чат", enabled = false, key = "debug" },
    { type = "page", number = 2, text = "|cffFFFF00Диспел|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(2782).." Диспел", tooltip ="Диспелит все что может", enabled = true, key = "decurse" },
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
    { type = "page", number = 3, text = "|cFFFF0000Защитные настройки|r" },
    { type = "separator" },
    { type = "title", text = "|cffFFFF00Дубовая кожа|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(22812).." Дубовая кожа", tooltip = "Использует Дубовую кожу при |cFF00FF00Hp <|r\
Работает в связке с функцией TTD(Time To Die)", enabled = true, value = 40, min = 1, max = 100, step = 1, key = "dub_koza" },
    { type = "entry", text = ni.spell.icon(67700).." Пронизывающий холод", tooltip = "Использует дубовую кожу под дебаф на 3 фазе|cFF00FFFF(Ануб ик/ивк)|r", enabled = true, key = "dub_anub" },
    { type = "entry", text = ni.spell.icon(70126).." Ледяная метка", tooltip ="Использует дубовую кожу под дебаф|cFF00FFFF(Синдрагоса цлк)|r", enabled = true, key = "dub_sindra_metka" },
    { type = "entry", text = ni.spell.icon(305185).." Адский удар", tooltip = "Использует дубовую кожу под каст|cFF00FFFF(Грулл хм)|r", enabled = true, key = "dub_grull" },    
    { type = "entry", text = ni.spell.icon(71219).." Едкая гниль", tooltip = "Использует дубовую кожу под каст|cFF00FFFF(Тухлопуз цлк)|r", enabled = true, key = "dub_tuhliy" },
    { type = "entry", text = ni.spell.icon(68980).." Жатва душ", tooltip = "Использует дубовую кожу под дебаф|cFF00FFFF(Лич цлк)|r", enabled = true, key = "dub_lich" },
    { type = "page", number = 4, text = "|cFFFF0000Защитные настройки|r" },
    { type = "separator" },
    { type = "title", text = "|cffFFFF00Предметы|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(11729).." Огурец", tooltip = "Использует Огурец при |cFF00FF00Hp <|r\
Работает в связке с функцией TTD(Time To Die)", enabled = true, value = 30, min = 1, max = 100, step = 1, key = "kamen" },
};
    local function OnLoad()
        ni.GUI.AddFrame("balans_2t4_by_makaren", items);
    end;
    local function OnUnLoad()  
        ni.GUI.DestroyFrame("balans_2t4_by_makaren");
    end;
    local cache = {
        IsMoving = false,
        stopcast = false,
        sindra = false,
        PlayerCombat = false,
        info = true,
        no_buff = false,
        sme = false,
        cou = 0,
        control = false,
        buff_ = "",
        };
    local spells = {
        roy = GetSpellInfo(48468),
        l_ogon = GetSpellInfo(48463),
        star = GetSpellInfo(53201),
        z_ogon = GetSpellInfo(48465),
        gnev = GetSpellInfo(48461),
        forma = GetSpellInfo(24858),
        buff_lun = GetSpellInfo(48518),
        buff_soln = GetSpellInfo(48517),
        dub = GetSpellInfo(22812),
        vo = GetSpellInfo(770),
        smerch = GetSpellInfo(33786),
        decurse = GetSpellInfo(2782),
        decurse_po = GetSpellInfo(2893),
	derev = GetSpellInfo(33831),
        };
    local ddebuffs ={
        sindra = GetSpellInfo(69766),
        mk_ledy = GetSpellInfo(71289),
        curse_ledy = GetSpellInfo(71237),
        curse_grul_hm = GetSpellInfo(305230),
        morouz_kara_hm = GetSpellInfo(305470),
        magik_hm = GetSpellInfo(305131),
        sindra_metka = GetSpellInfo(70126),
        };
    local queue = {
        "info",
        "cache",
        "stop",
        "pause",
        "save",
        "dispell",
        "auto-target",
        "forma",
        "vo",
        "cd",
        "gnev_start",
        "z_ogon_start",
        "lun_ogon",
        "star",
        "z_ogon",
	"drev",
    "roy_sol",
        "gnev",
        "roy",
    };
    local abilities = {
        -----------------------------------
        ["info"] = function()
            if cache.info == true
            and not ni.vars.coin then
                cache.info = false
                print("|cFFFF0000  =========================|r\
|cFFFFFFFFБаланс Друид|r\
|cFFFF5A00Приватный профиль by Makaren|r\
|cFF00FFFFФанпей https://funpay.com/users/7303789/|r\
|cFF00FFFFДс https://discord.com/users/785141640087207966|r\
|cFF00FFFFДс Группы https://discord.gg/eQzcDHbVfm|r\
|cFFFF0000=========================|r")
            end
        end,
        ------------------------
        ["cache"] = function()
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
                local spell, _, _, _, _, endTime = UnitCastingInfo(straz)
                if spell == ("Разрушительный крик") then
                    cache.stopcast = ni.unit.iscasting(straz)
                end
            end
            cache.IsMoving = ni.player.ismoving() or false;
            cache.PlayerCombat = UnitAffectingCombat("player") or false;
            cache.stopcast = ni.unit.debuffremaining("player", ddebuffs.magik_hm) > 2
            or ni.unit.debuff("player", "Поцелуй Госпожи");
            cache.sindra = ni.unit.debuffstacks("player", ddebuffs.sindra) <= values.osvob;
            if not cache.PlayerCombat then
                if menus.ActionEvent == 1 then
                    cache.buff_ = ""
                else
                    cache.buff_ = "lun"
                end
            elseif menus.ActionEvent == 1 then
                cache.buff_ = ""
            else
                cache.buff_ = "lun"
            end
            if not ni.player.buff(spells.buff_lun)
            and not ni.player.buff(spells.buff_soln) then
                cache.no_buff = true
            else
                cache.no_buff = false
            end
            if cache.cou == 3 then
                cache.sme = false
                cache.cou = 0
            end
            if ni.unit.debuff("target", "Сглаз") 
        or ni.unit.debuff("target", "Устрашающий крик") 
        or ni.unit.debuff("target", "Гнев деревьев") 
        or ni.unit.debuff("target", "Смерч") 
        or ni.unit.debuff("target", "Превращение") 
        or ni.unit.debuff("target", "Замораживающая ловушка") 
        or ni.unit.debuff("target", "Покаяние") 
        or ni.unit.debuff("target", "Ослепление") 
        or ni.unit.debuff("target", "Ошеломление") 
        or ni.unit.debuff("target", "Вой ужаса") 
        or ni.unit.debuff("target", "Изгнание") 
        or ni.unit.debuff("target", "Страх") 
        or ni.unit.debuff("target", "Спячка") 
        or ni.unit.debuff("target", "Отпугивание зверя") 
        or ni.unit.debuff("target", "Ментальный крик") then
            cache.control = true
        else
            cache.control = false
        end
        if ni.player.buff(spells.buff_lun) then
            cache.buff_ = "lun"
        elseif ni.player.buff(spells.buff_soln) then
            cache.buff_ = "soln"
        end
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
    ------------------------
    ["pause"] = function()
        if IsMounted()
		or UnitInVehicle("player")
		or UnitIsDeadOrGhost("player")
		or UnitChannelInfo("player")
		or UnitCastingInfo("player")
		or ni.player.islooting()
        or not cache.sindra then
			return true;
		end
    end,
        -----------------------------------
    ["save"] = function()
            if enables["dub_sindra_metka"]
            and ni.unit.debuff("player", ddebuffs.sindra_metka)
            and ni.unit.debuffremaining("player", ddebuffs.sindra_metka) < 2
            and ni.spell.available(spells.dub) then
                ni.spell.cast(spells.dub, "player")
            end
            if enables["dub_lich"]
            and ni.unit.debuff("player", "Жатва душ")
            or ni.unit.debuff("player", "Великая жатва душ") then
                if ni.spell.available(spells.dub) then
                    ni.spell.cast(spells.dub, "player")
                end
            end
            if enables["dub_tuhliy"]
            and ni.objectmanager.contains("Тухлопуз") then
                local tuhlopuz = ni.objectmanager.objectGUID("Тухлопуз")
                local spell, _, _, _, _, endTime = UnitCastingInfo(tuhlopuz)
                if spell == ("Едкая гниль") then
                    if ni.spell.available(spells.dub) then
                        ni.spell.cast(spells.dub, "player")
                    end
                end
            end
            if enables["dub_grull"]
            and ni.objectmanager.contains("Груул Драконобой") then
                local grull = ni.objectmanager.objectGUID("Груул Драконобой")
                local spell, _, _, _, _, endTime = UnitCastingInfo(grull)
                if spell == ("Адский удар") then
                    if ni.spell.available(spells.dub) then
                        ni.spell.cast(spells.dub, "player")
                    end
                end
            end
            if enables["dub_anub"]
            and ni.unit.debuff("player", "Пронизывающий холод")
            and ni.unit.debuff("player", "Жуки-трупоеды")
            and ni.spell.available(spells.dub) then
                ni.spell.cast(spells.dub, "player")
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
                    if ni.unit.hp("player") < values.kamen then
                        if ni.unit.ttd("player") < 2 then
                            ni.player.useitem(36892)
                            ni.player.useitem(36893)
                            ni.player.useitem(36894)
                        end
                    end
                end
            end
        end
            if enables["dub"] then
                if ni.unit.hp("player") < values.dub_koza then
                    if ni.unit.ttd("player") < 3
                    and ni.spell.available(spells.dub) then
                        ni.spell.cast(spells.dub, "player")
                    end
                end
            end
    end,
       -----------------------------------
    ["dispell"] = function()
        for i = 1, #ni.members do
            local ally = ni.members[i].unit;
            if cache.sme == false then
                if not cache.IsMoving
                and ni.unit.debuffremaining(ally, spells.smerch, "player") < 1
                and ni.spell.available(spells.smerch)
                and ni.spell.lastcast(spells.smerch, 1.2)
                and ni.spell.valid(ally, spells.smerch, false, true, true) then
                    cache.sme = ni.members[i].guid
                    if ni.spell.available(spells.fast_cast) then
                        ni.spell.cast(spells.fast_cast)
                    end
                    ni.spell.cast(spells.smerch, ally)
                    cache.cou = cache.cou + 1
                end
            elseif not cache.IsMoving
            and ni.unit.debuffremaining(cache.sme, spells.smerch, "player") < 1
            and ni.spell.available(spells.smerch)
            and ni.spell.lastcast(spells.smerch, 1.2)
            and ni.spell.valid(cache.sme, spells.smerch, false, true, true) then
                if ni.spell.available(spells.fast_cast) then
                    ni.spell.cast(spells.fast_cast)
                end
                ni.spell.cast(spells.smerch, cache.sme)
                cache.cou = cache.cou + 1
            end
            if enables["decurse"] then
                if enables["decurse_2"]
                and inputs.decursee ~= "" then
                    if ni.healing.candispel(ally)
                    and ni.unit.debuff(ally, inputs.decursee)
                    and ni.spell.available(spells.decurse)
                    and ni.spell.valid(ally, spells.decurse, false, true, true) then
                        ni.spell.cast(spells.decurse, ally)
                    end
                    if ni.healing.candispel(ally)
                    and ni.unit.debuff(ally, inputs.decursee)
                    and ni.spell.valid(ally, spells.decurse_po, false, true, true)
                    and ni.spell.available(spells.decurse_po) then
                        ni.spell.cast(spells.decurse_po, ally)
                    end
                elseif ni.healing.candispel(ally) then
                    if ni.spell.valid(ally, spells.decurse, false, true, true)
                    and not ni.unit.debuff(ally, inputs.decurseee)
                    and ni.spell.available(spells.decurse) then
                        ni.spell.cast(spells.decurse, ally)
                    end
                    if ni.spell.valid(ally, spells.decurse_po, false, true, true)
                    and not ni.unit.debuff(ally, inputs.decurseee)
                    and ni.spell.available(spells.decurse_po) then
                        ni.spell.cast(spells.decurse_po, ally)
                    end
                end
                
            end 
        end 
    end,
        -----------------------------------
        ["auto-target"] = function()
            local target_ = ni.objects["target"];
        local target__ = target_.guid
        if enables["target"]
        and cache.PlayerCombat then
            if target__ == 0 then
                ni.player.runtext("/startattack")
            end
        end
        end,
        -----------------------------------
        ["forma"] = function()
            if not ni.player.buff(spells.forma, "player") then
                ni.spell.cast(spells.forma)
            end
        end,
        -----------------------------------
        ["vo"] = function()
            if enables["vo"]
	and ni.unit.isboss("target")
    and not cache.control
            and cache.PlayerCombat
            and not ni.unit.debuff("target", spells.vo) then
                ni.spell.cast(spells.vo, "target")
            end
        end,
        --------------------------
        ["cd"] = function()
            if cache.PlayerCombat
            and not cache.stopcast then
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
                if ni.spell.available(316422) then
                    ni.spell.cast(316422)
                end
                if ni.spell.available(316447) then
                    ni.spell.cast("target", 316467)
                end
                if ni.unit.buff("player", 316440)
                and cache.PlayerCombat
                and ni.player.hasitem(50085) then
                    ni.player.useitem(50085)
                end
                if ni.player.slotcastable(10)
                and ni.player.buff(spells.buff_lun)
                and ni.spell.cd(spells.star) == 0
                and ni.player.slotcd(10) == 0 then
                    ni.player.useinventoryitem(10)
                end
                if ni.player.slotcastable(13)
                and ni.player.slotcd(13) == 0
                and ni.player.buff(spells.buff_lun)
                and ni.spell.cd(spells.star) == 0 then
                    ni.player.useinventoryitem(13)
                end
                if ni.player.slotcastable(14)
                and ni.player.slotcd(14) == 0
                and ni.player.buff(spells.buff_lun)
                and ni.spell.cd(spells.star) == 0 then
                    ni.player.useinventoryitem(14)
                end
                if ni.spell.available(319326) then
                    ni.spell.cast(319326)
                end
                if ni.spell.available(316295) then
                    ni.spell.cast(316295)
                end
                if ni.spell.available(316396)
            and ni.spell.valid("target", 316396, false, true, true) then
                ni.spell.cast(316396)
            end
            end
        end,
        -----------------------------------
    ["gnev_start"] = function()
        if cache.buff_ == "soln"
        or cache.buff_ == "" then
            if not cache.stopcast
            and not cache.control
            and cache.no_buff == true
            and not cache.IsMoving
            and cache.PlayerCombat
            and ni.spell.available(spells.gnev)
            and ni.spell.valid("target", spells.gnev, false, true, true) then
                ni.spell.cast(spells.gnev, "target")
        end
        end
    end,
    -----------------------------------
    ["z_ogon_start"] = function()
        if cache.buff_ == "lun" then
            if not cache.IsMoving
        and not cache.control
        and cache.no_buff == true
	and not cache.stopcast
        and cache.PlayerCombat
        and ni.spell.available(spells.z_ogon)
        and ni.spell.valid("target", spells.z_ogon, false, true, true) then
            ni.spell.cast(spells.z_ogon, "target")
        end
        end
    end,
        -----------------------------------
        ["lun_ogon"] = function()
            if cache.PlayerCombat
            and not cache.control
            and not ni.unit.debuff("target", spells.l_ogon, "player")
            and ni.spell.available(spells.l_ogon)
            and ni.spell.valid("target", spells.l_ogon, false, true, true) then
                ni.spell.cast(spells.l_ogon, "target")
            end
        end,
        -----------------------------------
        ["star"] = function()
            if ni.unit.isboss("target")
            or ni.vars.combat.cd then
                if cache.PlayerCombat
                and not cache.control
                and ni.spell.available(spells.star)
                and ni.spell.valid("target", spells.z_ogon, false, true, true) then
                    ni.spell.cast(spells.star, "target")
                end
            end
        end,
       -----------------------------------
    ["z_ogon"] = function()
        if cache.PlayerCombat
        and not cache.control
	and not cache.stopcast
        and not cache.IsMoving
        and ni.spell.available(spells.z_ogon)
        and ni.spell.valid("target", spells.z_ogon, false, true, true) then
            if ni.player.buff(spells.buff_lun)
            or ni.player.buff(32182)
            or ni.player.buff(2825)
            or ni.player.buff(10060) then
                ni.spell.cast(spells.z_ogon, "target")
            end
        end
    end,
		 -----------------------------------
         ["drev"] = function()
            if enables["ents"]
            and cache.PlayerCombat
            and not cache.control
            and ni.spell.available(spells.drev)			
            and ni.player.buff(spells.buff_soln) then
                if ni.unit.distance("player", "target") < 30 then
                    ni.spell.castat(spells.drev, "target")
                else
                    ni.spell.castat(spells.drev, "player")
                end 
            end
        end,
        -----------------------------------
        ["roy_sol"] = function()
            if enables["roy_sol"]
            and not cache.control
            and cache.PlayerCombat
            and not ni.unit.debuff("target", spells.roy, "player")
            and ni.spell.available(spells.roy)
            and ni.spell.valid("target", spells.roy, false, true, true) then
                ni.spell.cast(spells.roy, "target")
            end
        end,
        -----------------------------------
        ["gnev"] = function()
            if cache.PlayerCombat
	    and not cache.stopcast
        and not cache.control
            and not cache.IsMoving
            and ni.player.buff(spells.buff_soln)
            and ni.spell.available(spells.gnev)
            and ni.spell.valid("target", spells.gnev, false, true, true) then
                ni.spell.cast(spells.gnev, "target")
            end
        end,
        -----------------------------------
        ["roy"] = function()
            if cache.IsMoving
            and cache.PlayerCombat
            and not cache.control
            and not ni.unit.debuff("target", spells.roy, "player")
            and ni.spell.available(spells.roy)
            and ni.spell.valid("target", spells.roy, false, true, true) then
                ni.spell.cast(spells.roy, "target")
            end
        end,
        --------------------------
    };
    ni.bootstrap.profile("moonkin_by_makaren_wrath", queue, abilities, OnLoad, OnUnLoad);
else
    local enables = {
        ["target"] = true,
    ["dub_sindra_metka"] = true,
    ["dub_lich"] = true,
    ["dub_tuhliy"] = true,
    ["dub_grull"] = true,
    ["dub_anub"] = true,
    ["dub_koza"] = true,
    ["kamen"] = true,
    ["vo"] = true,
    ["decurse"] = true,
    ["smer"] = true,
    ["decurse_2"] = false,
    }
    local values = {
        osvob = 4,
    kamen = 30,
    dub_koza = 40,
    }
    local inputs = {
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
        settingsfile = "balans_by_makaren.json",
        callback = GUICallback,
        { type = "title", text = "Balans_Druid by |c0000CED1Makaren|r" },
        { type = "separator" },
        { type = "title", text = "|cffFF7C0AProfile version 2.0.0|r" },
        { type = "separator" },
    { type = "page", number = 1, text = "|cffFFFF00Общие настройки|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(69762).." Освобожденная магия", tooltip ="Количество набираемых стаков Освобожденной магии |cFF00FFFFЦлк(Синдрагоса)|r", value = 4, min = 1, max = 10, step = 1, key = "osvob" },    
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(6603).." Авто таргет", tooltip ="Автоматически выбирает таргет при его отсутствии", enabled = true, key = "target" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(770).." Волшебный огонь", tooltip ="Автоматически использует волшебный огонь при его отсутствии", enabled = true, key = "vo" },
    { type = "entry", text = ni.spell.icon(33786).." Смерч в мк", enabled = true, key = "smer" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(24803).." Дебаг в чат", enabled = false, key = "debug" },
    { type = "page", number = 2, text = "|cffFFFF00Диспел|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(2782).." Диспел", tooltip ="Диспелит все что может", enabled = true, key = "decurse" },
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
    { type = "page", number = 3, text = "|cFFFF0000Защитные настройки|r" },
    { type = "separator" },
    { type = "title", text = "|cffFFFF00Дубовая кожа|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(22812).." Дубовая кожа", tooltip = "Использует Дубовую кожу при |cFF00FF00Hp <|r\
Работает в связке с функцией TTD(Time To Die)", enabled = true, value = 40, min = 1, max = 100, step = 1, key = "dub_koza" },
    { type = "entry", text = ni.spell.icon(67700).." Пронизывающий холод", tooltip = "Использует дубовую кожу под дебаф на 3 фазе|cFF00FFFF(Ануб ик/ивк)|r", enabled = true, key = "dub_anub" },
    { type = "entry", text = ni.spell.icon(70126).." Ледяная метка", tooltip ="Использует дубовую кожу под дебаф|cFF00FFFF(Синдрагоса цлк)|r", enabled = true, key = "dub_sindra_metka" },
    { type = "entry", text = ni.spell.icon(305185).." Адский удар", tooltip = "Использует дубовую кожу под каст|cFF00FFFF(Грулл хм)|r", enabled = true, key = "dub_grull" },    
    { type = "entry", text = ni.spell.icon(71219).." Едкая гниль", tooltip = "Использует дубовую кожу под каст|cFF00FFFF(Тухлопуз цлк)|r", enabled = true, key = "dub_tuhliy" },
    { type = "entry", text = ni.spell.icon(68980).." Жатва душ", tooltip = "Использует дубовую кожу под дебаф|cFF00FFFF(Лич цлк)|r", enabled = true, key = "dub_lich" },
    { type = "page", number = 4, text = "|cFFFF0000Защитные настройки|r" },
    { type = "separator" },
    { type = "title", text = "|cffFFFF00Предметы|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(11729).." Огурец", tooltip = "Использует Огурец при |cFF00FF00Hp <|r\
Работает в связке с функцией TTD(Time To Die)", enabled = true, value = 30, min = 1, max = 100, step = 1, key = "kamen" },
};
    local function OnLoad()
        ni.GUI.AddFrame("balans_by_makaren", items);
    end;
    local function OnUnLoad()  
        ni.GUI.DestroyFrame("balans_by_makaren");
    end;
    local cache = {
        IsMoving = false,
        stopcast = false,
        sindra = false,
        PlayerCombat = false,
        info = true,
        no_buff = false,
        sme = false,
        cou = 0,
        control = false,
        buff_ = "",
        };
    local spells = {
        roy = GetSpellInfo(48468),
        l_ogon = GetSpellInfo(48463),
        star = GetSpellInfo(53201),
        z_ogon = GetSpellInfo(48465),
        gnev = GetSpellInfo(48461),
        forma = GetSpellInfo(24858),
        buff_lun = GetSpellInfo(48518),
        buff_soln = GetSpellInfo(48517),
        dub = GetSpellInfo(22812),
        vo = GetSpellInfo(770),
        smerch = GetSpellInfo(33786),
        decurse = GetSpellInfo(2782),
        decurse_po = GetSpellInfo(2893),
	derev = GetSpellInfo(33831),
        };
    local ddebuffs ={
        sindra = GetSpellInfo(69766),
        mk_ledy = GetSpellInfo(71289),
        curse_ledy = GetSpellInfo(71237),
        curse_grul_hm = GetSpellInfo(305230),
        morouz_kara_hm = GetSpellInfo(305470),
        magik_hm = GetSpellInfo(305131),
        sindra_metka = GetSpellInfo(70126),
        };
    local queue = {
        "info",
        "cache",
        "stop",
        "pause",
        "save",
        "dispell",
        "auto-target",
        "forma",
        "vo",
        "cd",
        "gnev_start",
        "z_ogon_start",
        "lun_ogon",
        "star",
        "z_ogon",
	"drev",
        "roy",
        "gnev",
        
    };
    local abilities = {
        -----------------------------------
        ["info"] = function()
            if cache.info == true
            and not ni.vars.coin then
                cache.info = false
                print("|cFFFF0000  =========================|r\
|cFFFFFFFFБаланс Друид|r\
|cFFFF5A00Приватный профиль by Makaren|r\
|cFF00FFFFФанпей https://funpay.com/users/7303789/|r\
|cFF00FFFFДс https://discord.com/users/785141640087207966|r\
|cFF00FFFFДс Группы https://discord.gg/eQzcDHbVfm|r\
|cFFFF0000=========================|r")
            end
        end,
        ------------------------
        ["cache"] = function()
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
                local spell, _, _, _, _, endTime = UnitCastingInfo(straz)
                if spell == ("Разрушительный крик") then
                    cache.stopcast = ni.unit.iscasting(straz)
                end
            end
            cache.IsMoving = ni.player.ismoving() or false;
            cache.PlayerCombat = UnitAffectingCombat("player") or false;
            cache.stopcast = ni.unit.debuffremaining("player", ddebuffs.magik_hm) > 2
            or ni.unit.debuff("player", "Поцелуй Госпожи");
            cache.sindra = ni.unit.debuffstacks("player", ddebuffs.sindra) <= values.osvob;
            if not cache.PlayerCombat then
                cache.buff_ = ""
            end
            if not ni.player.buff(spells.buff_lun)
            and not ni.player.buff(spells.buff_soln) then
                cache.no_buff = true
            else
                cache.no_buff = false
            end
            if cache.cou == 3 then
                cache.sme = false
                cache.cou = 0
            end
            if ni.unit.debuff("target", "Сглаз") 
        or ni.unit.debuff("target", "Устрашающий крик") 
        or ni.unit.debuff("target", "Гнев деревьев") 
        or ni.unit.debuff("target", "Смерч") 
        or ni.unit.debuff("target", "Превращение") 
        or ni.unit.debuff("target", "Замораживающая ловушка") 
        or ni.unit.debuff("target", "Покаяние") 
        or ni.unit.debuff("target", "Ослепление") 
        or ni.unit.debuff("target", "Ошеломление") 
        or ni.unit.debuff("target", "Вой ужаса") 
        or ni.unit.debuff("target", "Изгнание") 
        or ni.unit.debuff("target", "Страх") 
        or ni.unit.debuff("target", "Спячка") 
        or ni.unit.debuff("target", "Отпугивание зверя") 
        or ni.unit.debuff("target", "Ментальный крик") then
            cache.control = true
        else
            cache.control = false
        end
        if ni.player.buff(spells.buff_lun) then
            cache.buff_ = "lun"
        elseif ni.player.buff(spells.buff_soln) then
            cache.buff_ = "soln"
        end
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
    ------------------------
    ["pause"] = function()
        if IsMounted()
		or UnitInVehicle("player")
		or UnitIsDeadOrGhost("player")
		or UnitChannelInfo("player")
		or UnitCastingInfo("player")
		or ni.player.islooting()
        or not cache.sindra then
			return true;
		end
    end,
        -----------------------------------
    ["save"] = function()
            if enables["dub_sindra_metka"]
            and ni.unit.debuff("player", ddebuffs.sindra_metka)
            and ni.unit.debuffremaining("player", ddebuffs.sindra_metka) < 2
            and ni.spell.available(spells.dub) then
                ni.spell.cast(spells.dub, "player")
            end
            if enables["dub_lich"]
            and ni.unit.debuff("player", "Жатва душ")
            or ni.unit.debuff("player", "Великая жатва душ") then
                if ni.spell.available(spells.dub) then
                    ni.spell.cast(spells.dub, "player")
                end
            end
            if enables["dub_tuhliy"]
            and ni.objectmanager.contains("Тухлопуз") then
                local tuhlopuz = ni.objectmanager.objectGUID("Тухлопуз")
                local spell, _, _, _, _, endTime = UnitCastingInfo(tuhlopuz)
                if spell == ("Едкая гниль") then
                    if ni.spell.available(spells.dub) then
                        ni.spell.cast(spells.dub, "player")
                    end
                end
            end
            if enables["dub_grull"]
            and ni.objectmanager.contains("Груул Драконобой") then
                local grull = ni.objectmanager.objectGUID("Груул Драконобой")
                local spell, _, _, _, _, endTime = UnitCastingInfo(grull)
                if spell == ("Адский удар") then
                    if ni.spell.available(spells.dub) then
                        ni.spell.cast(spells.dub, "player")
                    end
                end
            end
            if enables["dub_anub"]
            and ni.unit.debuff("player", "Пронизывающий холод")
            and ni.unit.debuff("player", "Жуки-трупоеды")
            and ni.spell.available(spells.dub) then
                ni.spell.cast(spells.dub, "player")
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
                    if ni.unit.hp("player") < values.kamen then
                        if ni.unit.ttd("player") < 2 then
                            ni.player.useitem(36892)
                            ni.player.useitem(36893)
                            ni.player.useitem(36894)
                        end
                    end
                end
            end
        end
            if enables["dub"] then
                if ni.unit.hp("player") < values.dub_koza then
                    if ni.unit.ttd("player") < 3
                    and ni.spell.available(spells.dub) then
                        ni.spell.cast(spells.dub, "player")
                    end
                end
            end
    end,
        -----------------------------------
    ["dispell"] = function()
        for i = 1, #ni.members do
            local ally = ni.members[i].unit;
            if cache.sme == false then
                if not cache.IsMoving
                and ni.unit.debuffremaining(ally, spells.smerch, "player") < 1
                and ni.spell.available(spells.smerch)
                and ni.spell.lastcast(spells.smerch, 1.2)
                and ni.spell.valid(ally, spells.smerch, false, true, true) then
                    cache.sme = ni.members[i].guid
                    if ni.spell.available(spells.fast_cast) then
                        ni.spell.cast(spells.fast_cast)
                    end
                    ni.spell.cast(spells.smerch, ally)
                    cache.cou = cache.cou + 1
                end
            elseif not cache.IsMoving
            and ni.unit.debuffremaining(cache.sme, spells.smerch, "player") < 1
            and ni.spell.available(spells.smerch)
            and ni.spell.lastcast(spells.smerch, 1.2)
            and ni.spell.valid(cache.sme, spells.smerch, false, true, true) then
                if ni.spell.available(spells.fast_cast) then
                    ni.spell.cast(spells.fast_cast)
                end
                ni.spell.cast(spells.smerch, cache.sme)
                cache.cou = cache.cou + 1
            end
            if enables["decurse"] then
                if enables["decurse_2"]
                and inputs.decursee ~= "" then
                    if ni.healing.candispel(ally)
                    and ni.unit.debuff(ally, inputs.decursee)
                    and ni.spell.available(spells.decurse)
                    and ni.spell.valid(ally, spells.decurse, false, true, true) then
                        ni.spell.cast(spells.decurse, ally)
                    end
                    if ni.healing.candispel(ally)
                    and ni.unit.debuff(ally, inputs.decursee)
                    and ni.spell.valid(ally, spells.decurse_po, false, true, true)
                    and ni.spell.available(spells.decurse_po) then
                        ni.spell.cast(spells.decurse_po, ally)
                    end
                elseif ni.healing.candispel(ally) then
                    if ni.spell.valid(ally, spells.decurse, false, true, true)
                    and not ni.unit.debuff(ally, inputs.decurseee)
                    and ni.spell.available(spells.decurse) then
                        ni.spell.cast(spells.decurse, ally)
                    end
                    if ni.spell.valid(ally, spells.decurse_po, false, true, true)
                    and not ni.unit.debuff(ally, inputs.decurseee)
                    and ni.spell.available(spells.decurse_po) then
                        ni.spell.cast(spells.decurse_po, ally)
                    end
                end
                
            end 
        end 
    end,
        -----------------------------------
        ["auto-target"] = function()
            local target_ = ni.objects["target"];
        local target__ = target_.guid
        if enables["target"]
        and cache.PlayerCombat then
            if target__ == 0 then
                ni.player.runtext("/startattack")
            end
        end
        end,
        -----------------------------------
        ["forma"] = function()
            if not ni.player.buff(spells.forma, "player") then
                ni.spell.cast(spells.forma)
            end
        end,
        -----------------------------------
        ["vo"] = function()
            if enables["vo"]
	and ni.unit.isboss("target")
    and not cache.control
            and cache.PlayerCombat
            and not ni.unit.debuff("target", spells.vo) then
                ni.spell.cast(spells.vo, "target")
            end
        end,
        --------------------------
        ["cd"] = function()
            if cache.PlayerCombat
            and not cache.stopcast then
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
                if ni.spell.available(316422) then
                    ni.spell.cast(316422)
                end
                if ni.spell.available(316447) then
                    ni.spell.cast("target", 316467)
                end
                if ni.unit.buff("player", 316440)
                and cache.PlayerCombat
                and ni.player.hasitem(50085) then
                    ni.player.useitem(50085)
                end
                if ni.player.slotcastable(10)
                and ni.player.buff(spells.buff_lun)
                and ni.spell.cd(spells.star) == 0
                and ni.player.slotcd(10) == 0 then
                    ni.player.useinventoryitem(10)
                end
                if ni.player.slotcastable(13)
                and ni.player.slotcd(13) == 0
                and ni.player.buff(spells.buff_lun)
                and ni.spell.cd(spells.star) == 0 then
                    ni.player.useinventoryitem(13)
                end
                if ni.player.slotcastable(14)
                and ni.player.slotcd(14) == 0
                and ni.player.buff(spells.buff_lun)
                and ni.spell.cd(spells.star) == 0 then
                    ni.player.useinventoryitem(14)
                end
                if ni.spell.available(319326) then
                    ni.spell.cast(319326)
                end
                if ni.spell.available(316295) then
                    ni.spell.cast(316295)
                end
                if ni.spell.available(316396)
            and ni.spell.valid("target", 316396, false, true, true) then
                ni.spell.cast(316396)
            end
            end
        end,
        -----------------------------------
    ["gnev_start"] = function()
        if cache.buff_ == "soln"
        or cache.buff_ == "" then
            if not cache.stopcast
            and not cache.control
            and cache.no_buff == true
            and not cache.IsMoving
            and cache.PlayerCombat
            and ni.spell.available(spells.gnev)
            and ni.spell.valid("target", spells.gnev, false, true, true) then
                ni.spell.cast(spells.gnev, "target")
        end
        end
    end,
    -----------------------------------
    ["z_ogon_start"] = function()
        if cache.buff_ == "lun" then
            if not cache.IsMoving
        and not cache.control
        and cache.no_buff == true
	and not cache.stopcast
        and cache.PlayerCombat
        and ni.spell.available(spells.z_ogon)
        and ni.spell.valid("target", spells.z_ogon, false, true, true) then
            ni.spell.cast(spells.z_ogon, "target")
        end
        end
    end,
        -----------------------------------
        ["lun_ogon"] = function()
            if cache.PlayerCombat
            and not cache.control
            and not ni.unit.debuff("target", spells.l_ogon, "player")
            and ni.spell.available(spells.l_ogon)
            and ni.spell.valid("target", spells.l_ogon, false, true, true) then
                ni.spell.cast(spells.l_ogon, "target")
            end
        end,
        -----------------------------------
        ["star"] = function()
            if ni.unit.isboss("target")
            or ni.vars.combat.cd then
                if cache.PlayerCombat
                and not cache.control
                and ni.spell.available(spells.star)
                and ni.spell.valid("target", spells.z_ogon, false, true, true) then
                    ni.spell.cast(spells.star, "target")
                end
            end
        end,
        -----------------------------------
    ["z_ogon"] = function()
        if cache.PlayerCombat
	and not cache.stopcast
    and not cache.control
        and not cache.IsMoving
        and ni.spell.available(spells.z_ogon)
        and ni.spell.valid("target", spells.z_ogon, false, true, true) then
            if ni.player.buff(spells.buff_lun)
            or ni.player.buff(32182)
            or ni.player.buff(2825)
            or ni.player.buff(10060) then
                ni.spell.cast(spells.z_ogon, "target")
            end
        end
    end,
		  -----------------------------------
    ["drev"] = function()
        if cache.PlayerCombat
        and not cache.control
	    and ni.spell.available(spells.drev)			
        and ni.player.buff(spells.buff_soln) then
	        if ni.unit.distance("player", "target") < 30 then
		        ni.spell.castat(spells.drev, "target")
	        else
		        ni.spell.castat(spells.drev, "player")
	        end 
        end
    end,
        -----------------------------------
        ["roy"] = function()
            if cache.PlayerCombat
            and not cache.control
            and not ni.unit.debuff("target", spells.roy, "player")
            and ni.spell.available(spells.roy)
            and ni.spell.valid("target", spells.roy, false, true, true) then
                ni.spell.cast(spells.roy, "target")
            end
        end,
        -----------------------------------
        ["gnev"] = function()
            if cache.PlayerCombat
	    and not cache.stopcast
        and not cache.control
            and not cache.IsMoving
            and ni.player.buff(spells.buff_soln)
            and ni.spell.available(spells.gnev)
            and ni.spell.valid("target", spells.gnev, false, true, true) then
                ni.spell.cast(spells.gnev, "target")
            end
        end,
        
        --------------------------
    };
		ni.bootstrap.profile("moonkin_by_makaren_wrath", queue, abilities, OnLoad, OnUnLoad);
	end
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
    ni.bootstrap.profile("moonkin_by_makaren_wrath", queue, abilities);
end;