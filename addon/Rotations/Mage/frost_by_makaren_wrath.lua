local Sirus = GetItemInfo(100455) ~= nil or false;

if Sirus then

local t4 = 0
if ni.player.hasitemequipped(29076) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(29077) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(29078) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(29079) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(29080) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100460) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100461) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100462) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100463) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100464) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101360) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101361) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101362) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101363) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101364) then
    t4 = t4 + 1
end
if t4 > 3 then
local enables = {
    ["target"] = true,
    ["kamen"] = true,
    ["dospeh"] = true,
    ["mag"] = false,
    ["kop"] = true,
    ["char"] = false,
    ["decurs"] = false,
    ["priliv"] = true,
    ["debug"] = false,
}
local values = {
    osvob = 4,
    priliv = 33,
    kamen = 30,
}
local inputs = {
    pool = "Name"
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
    settingsfile = "frost_4T4_by_makaren.json",
    callback = GUICallback,
    { type = "title", text = "Frost 4T4 by |c0000CED1Makaren|r" },
	{ type = "separator" },
	{ type = "title", text = "|cffFF7C0AProfile version 2.0.0|r" },
	{ type = "separator" },
    { type = "page", number = 1, text = "|cffFFFF00Общие настройки|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(69762).." Освобожденная магия", tooltip ="Количество набираемых стаков Освобожденной магии |cFF00FFFFЦлк(Синдрагоса)|r", value = 4, min = 1, max = 10, step = 1, key = "osvob" },    
        { type = "separator" },
        { type = "entry", text = ni.spell.icon(6603).." Авто таргет", tooltip ="Автоматически выбирает таргет при его отсутствии", enabled = true, key = "target" },
        { type = "separator" },
        { type = "entry", text = ni.spell.icon(43046).." Раскаленный доспех", tooltip ="Использует Раскаленный доспех при его отсутствии", enabled = true, key = "dospeh" },
        { type = "separator" },
    { type = "entry", text = ni.spell.icon(11729).." Камень здоровья", tooltip ="Использует Огурец при |cFF00FF00Hp <|r\
Работает в связке с функцией TTD(Time To Die)", enabled = true, value = 30, min = 1, max = 100, step = 1, key = "kamen" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(24803).." Дебаг в чат", enabled = false, key = "debug" },{ type = "page", number = 2, text = "|cffFFFF00Доп настройки|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(54646).." Магическая концентрация", tooltip ="Использует Магическую концентрация по имени", enabled = false, key = "mag" },
	{
		type = "input",
		value = inputs["pool"],
		width = 140,
		height = 15,
		key = "pool"
	},
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(55342).." Авто копии", tooltip ="Автоматически использует копии для сброса агра", enabled = true, key = "kop" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(30449).." Авто чарокрад", tooltip ="Автоматически использует чарокрад", enabled = false, key = "char" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(475).." Авто декурс", tooltip ="Автоматически декурсит рейд", enabled = false, key = "decurs" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(12051).." Авто Прилив сил", tooltip ="Автоматически использует Прилив сил, если мана меньше", enabled = true, value = 33, min = 1, max = 66, step = 1, key = "priliv" },
};
local function OnLoad()
	ni.GUI.AddFrame("frost_4T4_by_makaren", items);
end;
local function OnUnLoad()  
	ni.GUI.DestroyFrame("frost_4T4_by_makaren");
end;
local cache = {
    IsMoving = false,
    stopcast = false,
    sindra = false,
    PlayerCombat = false,
    info = true,
    threat = 0,
    ffb = true,
    control = false,
    };
local spells = {
    strela_og = GetSpellInfo(47610),
    strela_led = GetSpellInfo(42842),
    konus = GetSpellInfo(42931),
    zamorozka = GetSpellInfo(44572),
    krov = GetSpellInfo(12472),
    mana = GetSpellInfo(12051),
    kamen = GetSpellInfo(42985),
    kop = GetSpellInfo(55342),
    dospeh = GetSpellInfo(43046),
    mag = GetSpellInfo(54646),
    char = GetSpellInfo(30449),
    decurse = GetSpellInfo(475),
    hvatka = GetSpellInfo(11958),
    
    };
local ddebuffs ={
    sindra = GetSpellInfo(69766),
    sindra_metka = GetSpellInfo(70126),
    magik_hm = GetSpellInfo(305131),
    }
local queue = {
    "info",
    "cache",
    "stop",
    "pause",
    "auto-target",
    "cd",
    "decurs",
    "buff",
    "konus",
    "zamorozka",
    "strela_og",
    "strela_og_obn",
    "strela_led",
};
local abilities = {
    -----------------------------------
    ["info"] = function()
        if cache.info == true
        and not ni.vars.coin then
            cache.info = false
            print("|cFFFF0000  =========================|r\
|cFFFFFFFFФрост Маг|r\
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
        cache.threat = ni.unit.threat("player")
        if enables["kop"]
        and cache.threat >= 2 then
            if ni.spell.available(spells.kop) then
                ni.spell.cast(spells.kop)
            end
        end
        cache.IsMoving = ni.player.ismoving() or false;
        cache.PlayerCombat = UnitAffectingCombat("player") or false;
        cache.stopcast = ni.unit.debuffremaining("player", ddebuffs.magik_hm) > 2
        or ni.unit.debuff("player", "Поцелуй Госпожи");
        cache.sindra = ni.unit.debuffstacks("player", ddebuffs.sindra) <= values.osvob;
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
    ["stop"] = function()
        if cache.stopcast then
	    if ni.unit.iscasting("player")
	    or ni.unit.ischanneling("player") then
             	ni.spell.stopcasting()
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
    --------------------------
    ["cd"] = function()
        if cache.PlayerCombat
        and not cache.stopcast then
            if ni.player.slotcastable(10)
            and ni.player.slotcd(10) == 0 then
                ni.player.useinventoryitem(10)
            end
            if ni.spell.available(316295) then
                ni.spell.cast(316295)
            end
            if ni.spell.available(319326) then
                ni.spell.cast(319326)
            end
            if ni.spell.available(316421)
            and ni.power.current("player") < 80 then
                ni.spell.cast(316421)
            end
            if ni.spell.available(316422) then
                ni.spell.cast(316422)
            end
            if ni.player.slotcd(13) == 0 then
                ni.player.useinventoryitem(13)
            end
            if ni.player.slotcd(14) == 0 then
                ni.player.useinventoryitem(14)
            end
            count = GetItemCount("Фрагмент души")
            if ni.spell.available(316466)
            and not ni.unit.buff("player", 316466) then
                if count > 1 
                or ni.unit.hp("target") < 10 then
                    ni.spell.cast(316466)
                end
            end
            if ni.spell.available(316447) then
                ni.spell.cast("target", 316467)
            end
            if ni.unit.buff("player", 316440)
            and cache.PlayerCombat
            and ni.player.hasitem(50085) then
                ni.player.useitem(50085)
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
            if ni.spell.available(spells.krov)
            and not ni.player.buff(32182)
            and not ni.player.buff(2825)
            and not ni.player.buff(10060)
            and not ni.player.buff(spells.krov) then
                ni.spell.cast(spells.krov)
            end
            if enables["priliv"]
            and ni.power.current("player") <= values.priliv
            and ni.unit.hp("target") > 10
            and ni.spell.available(spells.mana) then
                ni.spell.cast(spells.mana)
            end
            local startTime_, duration_, enable_ = GetItemCooldown(33312)
            if ni.power.current("player") <= 85
            and ni.player.hasitem(33312)
            and startTime_ == 0 then
                ni.player.useitem(33312)
            end
            if ni.spell.available(316162) then
                ni.spell.cast(316162)
            end
            if ni.spell.available(spells.hvatka)
            and ni.spell.cd(spells.zamorozka) > 0 then
                if ni.unit.isboss("target")
                or ni.vars.combat.cd then
                    ni.spell.cast(spells.hvatka)
                end
            end
            if ni.spell.available(316396)
            and ni.spell.valid("target", 316396, false, true, true) then
                ni.spell.cast(316396)
            end
        end
    end,
    -----------------------------------
    ["decurs"] = function()
        if cache.PlayerCombat then
            if enables["decurs"] then
                for i = 1, #ni.members do
                    local ally = ni.members[i].unit;
                    if ni.healing.candispel(ally)
                    and ni.spell.valid(ally, spells.decurse, false, true, true) then
                        ni.spell.cast(spells.decurse, ally)
                    end
                end
            end
            if enables["char"]
            and ni.unit.bufftype("target", "Magic")
            and ni.spell.available(spells.char)
            and ni.spell.valid("target", spells.char, false, true, true) then
                ni.spell.cast(spells.char)
            end
        end
    end,
    -----------------------------------
    ["buff"] = function()
            if not cache.PlayerCombat
            and not ni.player.hasitem(33312)
            and ni.spell.available(spells.kamen) then
                ni.spell.cast(spells.kamen)
            end
            if enables["dospeh"]
            and not ni.player.buff(spells.dospeh)
            and ni.spell.available(spells.dospeh) then
                ni.spell.cast(spells.dospeh)
            end
            if enables["mag"] then
                for i = 1, #ni.members do
                    local ally = ni.members[i].unit;
                    local tar = ni.objects[ally];
                    if inputs.pool == tar.name
                    and ni.spell.available(spells.mag)
                    and not ni.unit.buff(ally, spells.mag)
                    and ni.spell.valid(ally, spells.mag, false, true, true) then
                        ni.spell.cast(ally, spells.mag)
                    end
                end
            end
    end,
    -----------------------------------
    ["konus"] = function()
        if not cache.control
        and cache.PlayerCombat
        and ni.spell.available(spells.konus)
        and ni.spell.valid("target", spells.strela_led, false, true, true) then
            ni.player.lookat("target")
            ni.spell.cast(spells.konus)
            cache.ffb = true
        end
    end,
    -----------------------------------
    ["zamorozka"] = function()
        if not cache.control
        and cache.PlayerCombat
        and ni.unit.debuffremaining("target", spells.zamorozka, "player") < 0.1
        and ni.player.buff(74396)
        and ni.unit.buffstacks("player", 321467) > 5
        and ni.spell.available(spells.zamorozka)
        and ni.spell.valid("target", spells.zamorozka, false, true, true) then
            ni.spell.cast(spells.zamorozka)
            cache.ffb = true
        end
    end,
    -----------------------------------
    ["strela_og"] = function()
        if not cache.control
        and cache.PlayerCombat
        and ni.player.buff(57761)
        and ni.spell.available(spells.strela_og)
        and ni.spell.valid("target", spells.strela_og, false, true, true) then
            ni.spell.cast(spells.strela_og)
            cache.ffb = true
        end
    end,
    -----------------------------------
    ["strela_og_obn"] = function()
        if not cache.control
        and cache.PlayerCombat
        and cache.ffb == true
        and not cache.stopcast
        and ni.unit.debuffremaining("target", 47610, "player") < 2
        and ni.spell.available(spells.strela_og)
        and ni.spell.valid("target", spells.strela_og, false, true, true) then
            ni.spell.cast(spells.strela_og)
            cache.ffb = false
        end
    end,
    -----------------------------------
    ["strela_led"] = function()
        if not cache.control
        and cache.PlayerCombat
        and not cache.IsMoving
        and not cache.stopcast
        and ni.spell.available(spells.strela_led)
        and ni.spell.valid("target", spells.strela_led, false, true, true) then
            ni.spell.cast(spells.strela_led)
            cache.ffb = true
        end
    end,
    -----------------------------------
};
ni.bootstrap.profile("frost_by_makaren_wrath", queue, abilities, OnLoad, OnUnLoad);
elseif t4 > 1 then
    local enables = {
        ["target"] = true,
        ["kamen"] = true,
        ["dospeh"] = true,
        ["mag"] = false,
        ["kop"] = true,
        ["char"] = false,
        ["decurs"] = false,
        ["priliv"] = true,
        ["debug"] = false,
    }
    local values = {
        osvob = 4,
        priliv = 33,
        kamen = 30,
    }
    local inputs = {
        pool = "Name"
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
        settingsfile = "frost_2T4_by_makaren.json",
        callback = GUICallback,
        { type = "title", text = "Frost 2T4 by |c0000CED1Makaren|r" },
        { type = "separator" },
        { type = "title", text = "|cffFF7C0AProfile version 2.0.0|r" },
        { type = "separator" },
        { type = "page", number = 1, text = "|cffFFFF00Общие настройки|r" },
        { type = "separator" },
        { type = "entry", text = ni.spell.icon(69762).." Освобожденная магия", tooltip ="Количество набираемых стаков Освобожденной магии |cFF00FFFFЦлк(Синдрагоса)|r", value = 4, min = 1, max = 10, step = 1, key = "osvob" },    
        { type = "separator" },
        { type = "entry", text = ni.spell.icon(6603).." Авто таргет", tooltip ="Автоматически выбирает таргет при его отсутствии", enabled = true, key = "target" },
        { type = "separator" },
        { type = "entry", text = ni.spell.icon(43046).." Раскаленный доспех", tooltip ="Использует Раскаленный доспех при его отсутствии", enabled = true, key = "dospeh" },
        { type = "separator" },
    { type = "entry", text = ni.spell.icon(11729).." Камень здоровья", tooltip ="Использует Огурец при |cFF00FF00Hp <|r\
Работает в связке с функцией TTD(Time To Die)", enabled = true, value = 30, min = 1, max = 100, step = 1, key = "kamen" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(24803).." Дебаг в чат", enabled = false, key = "debug" },{ type = "page", number = 2, text = "|cffFFFF00Доп настройки|r" },
        { type = "separator" },
        { type = "entry", text = ni.spell.icon(54646).." Магическая концентрация", tooltip ="Использует Магическую концентрация по имени", enabled = false, key = "mag" },
        {
            type = "input",
            value = inputs["pool"],
            width = 140,
            height = 15,
            key = "pool"
        },
        { type = "separator" },
        { type = "entry", text = ni.spell.icon(55342).." Авто копии", tooltip ="Автоматически использует копии для сброса агра", enabled = true, key = "kop" },
        { type = "separator" },
        { type = "entry", text = ni.spell.icon(30449).." Авто чарокрад", tooltip ="Автоматически использует чарокрад", enabled = false, key = "char" },
        { type = "separator" },
        { type = "entry", text = ni.spell.icon(475).." Авто декурс", tooltip ="Автоматически декурсит рейд", enabled = false, key = "decurs" },
        { type = "separator" },
    { type = "entry", text = ni.spell.icon(12051).." Авто Прилив сил", tooltip ="Автоматически использует Прилив сил, если мана меньше", enabled = true, value = 33, min = 1, max = 66, step = 1, key = "priliv" },
};
    local function OnLoad()
        ni.GUI.AddFrame("frost_2T4_by_makaren", items);
    end;
    local function OnUnLoad()  
        ni.GUI.DestroyFrame("frost_2T4_by_makaren");
    end;
    local cache = {
        IsMoving = false,
        stopcast = false,
        sindra = false,
        PlayerCombat = false,
        info = true,
        threat = 0,
        ffb = true,
        control = false,
        };
    local spells = {
        strela_og = GetSpellInfo(47610),
        strela_led = GetSpellInfo(42842),
        konus = GetSpellInfo(42931),
        zamorozka = GetSpellInfo(44572),
        krov = GetSpellInfo(12472),
        mana = GetSpellInfo(12051),
        kamen = GetSpellInfo(42985),
        kop = GetSpellInfo(55342),
        dospeh = GetSpellInfo(43046),
        mag = GetSpellInfo(54646),
        char = GetSpellInfo(30449),
        decurse = GetSpellInfo(475),
        hvatka = GetSpellInfo(11958),
        
        };
    local ddebuffs ={
        sindra = GetSpellInfo(69766),
        sindra_metka = GetSpellInfo(70126),
        magik_hm = GetSpellInfo(305131),
        }
    local queue = {
        "info",
        "cache",
        "stop",
        "pause",
        "auto-target",
        "cd",
        "decurs",
        "buff",
        "konus",
        "zamorozka",
        "strela_og",
        "strela_og_obn",
        "strela_led",
    };
    local abilities = {
        -----------------------------------
        ["info"] = function()
            if cache.info == true
            and not ni.vars.coin then
                cache.info = false
                print("|cFFFF0000  =========================|r\
|cFFFFFFFFФрост Маг|r\
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
            cache.threat = ni.unit.threat("player")
            if enables["kop"]
            and cache.threat >= 2 then
                if ni.spell.available(spells.kop) then
                    ni.spell.cast(spells.kop)
                end
            end
            cache.IsMoving = ni.player.ismoving() or false;
            cache.PlayerCombat = UnitAffectingCombat("player") or false;
            cache.stopcast = ni.unit.debuffremaining("player", ddebuffs.magik_hm) > 2
            or ni.unit.debuff("player", "Поцелуй Госпожи");
            cache.sindra = ni.unit.debuffstacks("player", ddebuffs.sindra) <= values.osvob;
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
    ["stop"] = function()
        if cache.stopcast then
	    if ni.unit.iscasting("player")
	    or ni.unit.ischanneling("player") then
             	ni.spell.stopcasting()
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
        --------------------------
        ["cd"] = function()
            if cache.PlayerCombat
            and not cache.stopcast then
                if ni.player.slotcastable(10)
                and ni.player.slotcd(10) == 0 then
                    ni.player.useinventoryitem(10)
                end
                if ni.spell.available(316421)
                and ni.power.current("player") < 80 then
                    ni.spell.cast(316421)
                end
                if ni.spell.available(316295) then
                    ni.spell.cast(316295)
                end
                if ni.spell.available(319326) then
                    ni.spell.cast(319326)
                end
                if ni.spell.available(316422) then
                    ni.spell.cast(316422)
                end
                if ni.player.slotcd(13) == 0 then
                    ni.player.useinventoryitem(13)
                end
                if ni.player.slotcd(14) == 0 then
                    ni.player.useinventoryitem(14)
                end
                count = GetItemCount("Фрагмент души")
            if ni.spell.available(316466)
            and not ni.unit.buff("player", 316466) then
                if count > 1 
                or ni.unit.hp("target") < 10 then
                    ni.spell.cast(316466)
                end
            end
                if ni.spell.available(316447) then
                    ni.spell.cast("target", 316467)
                end
                if ni.unit.buff("player", 316440)
                and cache.PlayerCombat
                and ni.player.hasitem(50085) then
                    ni.player.useitem(50085)
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
                if ni.spell.available(spells.krov)
                and not ni.player.buff(32182)
                and not ni.player.buff(2825)
                and not ni.player.buff(10060)
                and not ni.player.buff(spells.krov) then
                    ni.spell.cast(spells.krov)
                end
                if enables["priliv"]
            and ni.power.current("player") <= values.priliv
            and ni.unit.hp("target") > 10
            and ni.spell.available(spells.mana) then
                ni.spell.cast(spells.mana)
            end
                local startTime_, duration_, enable_ = GetItemCooldown(33312)
                if ni.power.current("player") <= 85
                and ni.player.hasitem(33312)
                and startTime_ == 0 then
                    ni.player.useitem(33312)
                end
                if ni.spell.available(316162) then
                    ni.spell.cast(316162)
                end
                if ni.spell.available(spells.hvatka)
                and ni.spell.cd(spells.zamorozka) > 0 then
                    if ni.unit.isboss("target")
                    or ni.vars.combat.cd then
                        ni.spell.cast(spells.hvatka)
                    end
                end
                if ni.spell.available(316396)
            and ni.spell.valid("target", 316396, false, true, true) then
                ni.spell.cast(316396)
            end
            end
        end,
        -----------------------------------
        ["decurs"] = function()
            if cache.PlayerCombat then
                if enables["decurs"] then
                    for i = 1, #ni.members do
                        local ally = ni.members[i].unit;
                        if ni.healing.candispel(ally)
                        and ni.spell.valid(ally, spells.decurse, false, true, true) then
                            ni.spell.cast(spells.decurse, ally)
                        end
                    end
                end
                if enables["char"]
                and ni.unit.bufftype("target", "Magic")
                and ni.spell.available(spells.char)
                and ni.spell.valid("target", spells.char, false, true, true) then
                    ni.spell.cast(spells.char)
                end
            end
        end,
        -----------------------------------
        ["buff"] = function()
                if not cache.PlayerCombat
                and not ni.player.hasitem(33312)
                and ni.spell.available(spells.kamen) then
                    ni.spell.cast(spells.kamen)
                end
                if enables["dospeh"]
                and not ni.player.buff(spells.dospeh)
                and ni.spell.available(spells.dospeh) then
                    ni.spell.cast(spells.dospeh)
                end
                if enables["mag"] then
                    for i = 1, #ni.members do
                        local ally = ni.members[i].unit;
                        local tar = ni.objects[ally];
                        if inputs.pool == tar.name
                        and ni.spell.available(spells.mag)
                        and not ni.unit.buff(ally, spells.mag)
                        and ni.spell.valid(ally, spells.mag, false, true, true) then
                            ni.spell.cast(ally, spells.mag)
                        end
                    end
                end
        end,
        -----------------------------------
        ["konus"] = function()
            if not cache.control
            and cache.PlayerCombat
            and ni.spell.available(spells.konus)
            and ni.spell.valid("target", spells.strela_led, false, true, true) then
                ni.player.lookat("target")
                ni.spell.cast(spells.konus)
                cache.ffb = true
            end
        end,
        -----------------------------------
        ["zamorozka"] = function()
            if not cache.control
            and cache.PlayerCombat
            and ni.unit.debuffremaining("target", spells.zamorozka, "player") < 0.1
            and ni.player.buff(74396)
            and ni.spell.available(spells.zamorozka)
            and ni.spell.valid("target", spells.zamorozka, false, true, true) then
                ni.spell.cast(spells.zamorozka)
                cache.ffb = true
            end
        end,
        -----------------------------------
        ["strela_og"] = function()
            if not cache.control
            and cache.PlayerCombat
            and ni.player.buff(57761)
            and ni.spell.available(spells.strela_og)
            and ni.spell.valid("target", spells.strela_og, false, true, true) then
                ni.spell.cast(spells.strela_og)
                cache.ffb = true
            end
        end,
        -----------------------------------
    ["strela_og_obn"] = function()
        if not cache.control
        and cache.PlayerCombat
        and ni.unit.debuffremaining("target", 47610, "player") < 2
        and not cache.stopcast
        and cache.ffb == true
        and ni.spell.available(spells.strela_og)
        and ni.spell.valid("target", spells.strela_og, false, true, true) then
            ni.spell.cast(spells.strela_og)
            cache.ffb = false
        end
    end,
        -----------------------------------
        ["strela_led"] = function()
            if not cache.control
            and cache.PlayerCombat
            and not cache.IsMoving
            and not cache.stopcast
            and ni.spell.available(spells.strela_led)
            and ni.spell.valid("target", spells.strela_led, false, true, true) then
                ni.spell.cast(spells.strela_led)
                cache.ffb = true
            end
        end,
        -----------------------------------
    };
    ni.bootstrap.profile("frost_by_makaren_wrath", queue, abilities, OnLoad, OnUnLoad);
else
    local enables = {
        ["target"] = true,
        ["kamen"] = true,
        ["dospeh"] = true,
        ["mag"] = false,
        ["kop"] = true,
        ["char"] = false,
        ["decurs"] = false,
        ["priliv"] = true,
        ["debug"] = false,
    }
    local values = {
        osvob = 4,
        priliv = 33,
        kamen = 30,
    }
    local inputs = {
        pool = "Name"
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
        settingsfile = "frost_by_makaren_wrath.json",
        callback = GUICallback,
        { type = "title", text = "Frost by |c0000CED1Makaren|r" },
        { type = "separator" },
        { type = "title", text = "|cffFF7C0AProfile version 2.0.0|r" },
        { type = "separator" },
        { type = "page", number = 1, text = "|cffFFFF00Общие настройки|r" },
        { type = "separator" },
        { type = "entry", text = ni.spell.icon(69762).." Освобожденная магия", tooltip ="Количество набираемых стаков Освобожденной магии |cFF00FFFFЦлк(Синдрагоса)|r", value = 4, min = 1, max = 10, step = 1, key = "osvob" },    
        { type = "separator" },
        { type = "entry", text = ni.spell.icon(6603).." Авто таргет", tooltip ="Автоматически выбирает таргет при его отсутствии", enabled = true, key = "target" },
        { type = "separator" },
        { type = "entry", text = ni.spell.icon(43046).." Раскаленный доспех", tooltip ="Использует Раскаленный доспех при его отсутствии", enabled = true, key = "dospeh" },
        { type = "separator" },
    { type = "entry", text = ni.spell.icon(11729).." Камень здоровья", tooltip ="Использует Огурец при |cFF00FF00Hp <|r\
Работает в связке с функцией TTD(Time To Die)", enabled = true, value = 30, min = 1, max = 100, step = 1, key = "kamen" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(24803).." Дебаг в чат", enabled = false, key = "debug" },{ type = "page", number = 2, text = "|cffFFFF00Доп настройки|r" },
        { type = "separator" },
        { type = "entry", text = ni.spell.icon(54646).." Магическая концентрация", tooltip ="Использует Магическую концентрация по имени", enabled = false, key = "mag" },
        {
            type = "input",
            value = inputs["pool"],
            width = 140,
            height = 15,
            key = "pool"
        },
        { type = "separator" },
        { type = "entry", text = ni.spell.icon(55342).." Авто копии", tooltip ="Автоматически использует копии для сброса агра", enabled = true, key = "kop" },
        { type = "separator" },
        { type = "entry", text = ni.spell.icon(30449).." Авто чарокрад", tooltip ="Автоматически использует чарокрад", enabled = false, key = "char" },
        { type = "separator" },
        { type = "entry", text = ni.spell.icon(475).." Авто декурс", tooltip ="Автоматически декурсит рейд", enabled = false, key = "decurs" },
        { type = "separator" },
    { type = "entry", text = ni.spell.icon(12051).." Авто Прилив сил", tooltip ="Автоматически использует Прилив сил, если мана меньше", enabled = true, value = 33, min = 1, max = 66, step = 1, key = "priliv" },
};
    local function OnLoad()
        ni.GUI.AddFrame("frost_by_makaren_wrath", items);
    end;
    local function OnUnLoad()  
        ni.GUI.DestroyFrame("frost_by_makaren_wrath");
    end;
    local cache = {
        IsMoving = false,
        stopcast = false,
        sindra = false,
        PlayerCombat = false,
        info = true,
        threat = 0,
        control = false,
        };
    local spells = {
        strela_og = GetSpellInfo(47610),
        strela_led = GetSpellInfo(42842),
        konus = GetSpellInfo(42931),
        zamorozka = GetSpellInfo(44572),
        krov = GetSpellInfo(12472),
        mana = GetSpellInfo(12051),
        kamen = GetSpellInfo(42985),
        kop = GetSpellInfo(55342),
        dospeh = GetSpellInfo(43046),
        mag = GetSpellInfo(54646),
        char = GetSpellInfo(30449),
        decurse = GetSpellInfo(475),
        hvatka = GetSpellInfo(11958),
        
        };
    local ddebuffs ={
        sindra = GetSpellInfo(69766),
        sindra_metka = GetSpellInfo(70126),
        magik_hm = GetSpellInfo(305131),
        }
    local queue = {
        "info",
        "cache",
        "stop",
        "pause",
        "auto-target",
        "cd",
        "decurs",
        "buff",
        "zamorozka",
        "strela_og",
        "strela_led",
    };
    local abilities = {
        -----------------------------------
        ["info"] = function()
            if cache.info == true
            and not ni.vars.coin then
                cache.info = false
                print("|cFFFF0000  =========================|r\
|cFFFFFFFFФрост Маг|r\
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
            cache.threat = ni.unit.threat("player")
            if enables["kop"]
            and cache.threat >= 2 then
                if ni.spell.available(spells.kop) then
                    ni.spell.cast(spells.kop)
                end
            end
            cache.IsMoving = ni.player.ismoving() or false;
            cache.PlayerCombat = UnitAffectingCombat("player") or false;
            cache.stopcast = ni.unit.debuffremaining("player", ddebuffs.magik_hm) > 2
            or ni.unit.debuff("player", "Поцелуй Госпожи");
            cache.sindra = ni.unit.debuffstacks("player", ddebuffs.sindra) <= values.osvob;
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
    ["stop"] = function()
        if cache.stopcast then
	    if ni.unit.iscasting("player")
	    or ni.unit.ischanneling("player") then
             	ni.spell.stopcasting()
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
        --------------------------
        ["cd"] = function()
            if cache.PlayerCombat
            and not cache.stopcast then
                if ni.player.slotcastable(10)
                and ni.player.slotcd(10) == 0 then
                    ni.player.useinventoryitem(10)
                end
                if ni.spell.available(316421)
                and ni.power.current("player") < 80 then
                    ni.spell.cast(316421)
                end
                if ni.spell.available(316295) then
                    ni.spell.cast(316295)
                end
                if ni.spell.available(319326) then
                    ni.spell.cast(319326)
                end
                if ni.spell.available(316422) then
                    ni.spell.cast(316422)
                end
                if ni.player.slotcd(13) == 0 then
                    ni.player.useinventoryitem(13)
                end
                if ni.player.slotcd(14) == 0 then
                    ni.player.useinventoryitem(14)
                end
                count = GetItemCount("Фрагмент души")
            if ni.spell.available(316466)
            and not ni.unit.buff("player", 316466) then
                if count > 1 
                or ni.unit.hp("target") < 10 then
                    ni.spell.cast(316466)
                end
            end
                if ni.spell.available(316447) then
                    ni.spell.cast("target", 316467)
                end
                if ni.unit.buff("player", 316440)
                and cache.PlayerCombat
                and ni.player.hasitem(50085) then
                    ni.player.useitem(50085)
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
                if ni.spell.available(spells.krov)
                and not ni.player.buff(32182)
                and not ni.player.buff(2825)
                and not ni.player.buff(10060)
                and not ni.player.buff(spells.krov) then
                    ni.spell.cast(spells.krov)
                end
                if enables["priliv"]
            and ni.power.current("player") <= values.priliv
            and ni.unit.hp("target") > 10
            and ni.spell.available(spells.mana) then
                ni.spell.cast(spells.mana)
            end
                local startTime_, duration_, enable_ = GetItemCooldown(33312)
                if ni.power.current("player") <= 85
                and ni.player.hasitem(33312)
                and startTime_ == 0 then
                    ni.player.useitem(33312)
                end
                if ni.spell.available(316162) then
                    ni.spell.cast(316162)
                end
                if ni.spell.available(spells.hvatka)
                and ni.spell.cd(spells.zamorozka) > 0 then
                    if ni.unit.isboss("target")
                    or ni.vars.combat.cd then
                        ni.spell.cast(spells.hvatka)
                    end
                end
                if ni.spell.available(316396)
            and ni.spell.valid("target", 316396, false, true, true) then
                ni.spell.cast(316396)
            end
            end
        end,
        -----------------------------------
        ["decurs"] = function()
            if cache.PlayerCombat then
                if enables["decurs"] then
                    for i = 1, #ni.members do
                        local ally = ni.members[i].unit;
                        if ni.healing.candispel(ally)
                        and ni.spell.valid(ally, spells.decurse, false, true, true) then
                            ni.spell.cast(spells.decurse, ally)
                        end
                    end
                end
                if enables["char"]
                and ni.unit.bufftype("target", "Magic")
                and ni.spell.available(spells.char)
                and ni.spell.valid("target", spells.char, false, true, true) then
                    ni.spell.cast(spells.char)
                end
            end
        end,
        -----------------------------------
        ["buff"] = function()
                if not cache.PlayerCombat
                and not ni.player.hasitem(33312)
                and ni.spell.available(spells.kamen) then
                    ni.spell.cast(spells.kamen)
                end
                if enables["dospeh"]
                and not ni.player.buff(spells.dospeh)
                and ni.spell.available(spells.dospeh) then
                    ni.spell.cast(spells.dospeh)
                end
                if enables["mag"] then
                    for i = 1, #ni.members do
                        local ally = ni.members[i].unit;
                        local tar = ni.objects[ally];
                        if inputs.pool == tar.name
                        and ni.spell.available(spells.mag)
                        and not ni.unit.buff(ally, spells.mag)
                        and ni.spell.valid(ally, spells.mag, false, true, true) then
                            ni.spell.cast(ally, spells.mag)
                        end
                    end
                end
        end,
        -----------------------------------
        ["zamorozka"] = function()
            if not cache.control
            and cache.PlayerCombat
            and ni.unit.debuffremaining("target", spells.zamorozka, "player") < 0.1
            and ni.player.buff(74396)
            and ni.spell.available(spells.zamorozka)
            and ni.spell.valid("target", spells.zamorozka, false, true, true) then
                ni.spell.cast(spells.zamorozka)
            end
        end,
        -----------------------------------
        ["strela_og"] = function()
            if not cache.control
            and cache.PlayerCombat
            and not cache.stopcast
            and ni.spell.available(spells.strela_og)
            and ni.spell.valid("target", spells.strela_og, false, true, true) then
                if ni.player.buff(57761)
                or ni.player.buff(74396) then
                    ni.spell.cast(spells.strela_og)
                end
            end
        end,
        -----------------------------------
        ["strela_led"] = function()
            if not cache.control
            and cache.PlayerCombat
            and not cache.IsMoving
            and not cache.stopcast
            and ni.spell.available(spells.strela_led)
            and ni.spell.valid("target", spells.strela_led, false, true, true) then
                ni.spell.cast(spells.strela_led)
            end
        end,
        -----------------------------------
    };
		ni.bootstrap.profile("frost_by_makaren_wrath", queue, abilities, OnLoad, OnUnLoad);
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
    ni.bootstrap.profile("frost_by_makaren_wrath", queue, abilities);
end;