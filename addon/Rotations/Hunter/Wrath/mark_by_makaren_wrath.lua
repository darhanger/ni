local Sirus = GetItemInfo(100455) ~= nil or false;

if Sirus then

local t4 = 0
if ni.player.hasitemequipped(29081) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(29084) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(29082) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(29085) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(29083) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100465) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100468) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100466) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100469) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100467) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101365) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101368) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101366) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101369) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101367) then
    t4 = t4 + 1
end
if t4 > 3 then
local enables = {
    ["target"] = true,
    ["duh"] = true,
    ["aura"] = true,
    ["napul"] = false,
    ["meta"] = true,
    ["smert"] = false,
    ["pet"] = true,
    ["kamen"] = true,
    ["debug"] = false,
}
local values = {
    kamen = 30,
}
local inputs = {
    pool = "Name",
    meta1 = "",
    meta2 = "",
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
    settingsfile = "mark_4t4_by_makaren.json",
    callback = GUICallback,
    { type = "title", text = "Mark 4T4 by |c0000CED1Makaren|r" },
	{ type = "separator" },
	{ type = "title", text = "|cffFF7C0AProfile beta-version 2.0.0|r" },
	{ type = "separator" },
    { type = "page", number = 1, text = "|cffFFFF00Общие настройки|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(6603).." Авто таргет", tooltip ="Автоматически выбирает таргет при его отсутствии", enabled = true, key = "target" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(883).." Авто призыв пета", tooltip ="Автоматически призывает пета при его отсутствии", enabled = true, key = "pet" },
    { type = "entry", text = ni.spell.icon(61847).." Авто Дух дракондора", tooltip ="Автоматически использует Дух дракондора при его отсутствии", enabled = true, key = "duh" },
    { type = "entry", text = ni.spell.icon(19506).." Авто Аура меткого выстрела", tooltip ="Автоматически использует Ауру меткого выстрела при его отсутствии", enabled = true, key = "aura" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(11729).." Камень здоровья", tooltip ="Использует Огурец при |cFF00FF00Hp <|r\
Работает в связке с функцией TTD(Time To Die)", enabled = true, value = 30, min = 1, max = 100, step = 1, key = "kamen" },
{ type = "separator" },
    { type = "entry", text = ni.spell.icon(24803).." Дебаг в чат", enabled = false, key = "debug" },
    { type = "page", number = 2, text = "|cffFFFF00Доп настройки|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(34477).." Перенаправление", tooltip ="Использует Перенаправление по имени", enabled = false, key = "napul" },
	{
		type = "input",
		value = inputs["pool"],
		width = 140,
		height = 15,
		key = "pool"
	},
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(53434).." Зов дикой природы под бафы", tooltip ="Использует зов дикой приироды при наличии бафов(id)", enabled = true, key = "meta" },
    {
		type = "input",
		value = inputs["meta1"],
		width = 140,
		height = 15,
		key = "meta1"
	},
    {
		type = "input",
		value = inputs["meta2"],
		width = 140,
		height = 15,
		key = "meta2"
	},
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(5384).." Авто Притвориться мертвым", tooltip ="Использует Притвориться мертвым для сброса агра", enabled = false, key = "smert" },
};
local function OnLoad()
	ni.GUI.AddFrame("mark_4t4_by_makaren", items);
end;
local function OnUnLoad()  
	ni.GUI.DestroyFrame("mark_4t4_by_makaren");
end;
local cache = {
    sindra = false,
    PlayerCombat = false,
    aoe = false,
    info = true,
    p = false,
    threat = 0,
    pet = true,
    control = false,
    };
local spells = {
    duh = GetSpellInfo(61847),
    aura = GetSpellInfo(19506),
    metka = GetSpellInfo(53338),
    ukus = GetSpellInfo(49001),
    pricel = GetSpellInfo(49050),
    himera = GetSpellInfo(53209),
    vera = GetSpellInfo(49052),
    bs = GetSpellInfo(3045),
    napul = GetSpellInfo(34477),
    fas = GetSpellInfo(34026),
    gotov = GetSpellInfo(23989),
    kick = GetSpellInfo(34490),
    volsheb = GetSpellInfo(49045),
    killshot = GetSpellInfo(61006),
    petbuff = GetSpellInfo(53434),
    smert = GetSpellInfo(5384),
    pet = GetSpellInfo(883),
    eb = GetSpellInfo(316368),
    };
local ddebuffs ={
    sindra = GetSpellInfo(69766),
    sindra_metka = GetSpellInfo(70126),
    }
local queue = {
    "info",
    "cache",
    "pause",
    "auto-target",
    "buff",
    "cd",
    "metka",
    "napul",
    "pricel",
    "killshot",
    "ukus",
    "himera",
    "gotov",
    "vera",
    "volsheb",
};
local abilities = {
    -----------------------------------
    ["info"] = function()
        if cache.info == true
        and not ni.vars.coin then
            cache.info = false
            print("|cFFFF0000  =========================|r\
|cFFFFFFFFХант Стрелок|r\
|cFFFF5A00Приватный профиль by Makaren|r\
|cFF00FFFFФанпей https://funpay.com/users/7303789/|r\
|cFF00FFFFДс https://discord.com/users/785141640087207966|r\
|cFF00FFFFДс Группы https://discord.gg/eQzcDHbVfm|r\
|cFFFF0000=========================|r")
        end
    end,
    ------------------------
    ["cache"] = function()
        cache.PlayerCombat = UnitAffectingCombat("player") or false;
        cache.IsMoving = ni.player.ismoving() or false;
        cache.threat = ni.unit.threat("player")
        if enables["smert"]
        and cache.threat > 2 then
            if ni.spell.available(spells.smert) then
                ni.spell.cast(spells.smert)
            end
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
        if enables["debug"] then
            ni.vars.debug = true
        else
            ni.vars.debug = false
        end
        if ni.spell.cd(spells.himera) ~= 0 then
            cache.p = false
            cache.pet = true
        end
    end,
    ------------------------
    ["pause"] = function()
        if IsMounted()
		or UnitInVehicle("player")
		or UnitIsDeadOrGhost("player")
		or UnitChannelInfo("player")
		or UnitCastingInfo("player")
		or ni.player.islooting() then
			return true;
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
            if ni.objectmanager.contains("Король-лич") then
                local lich = ni.objectmanager.objectGUID("Король-лич")
                local spell, _, _, _, _, endTime = UnitChannelInfo(lich)
                if spell == ("Беспощадность зимы") then
                    ni.player.runtext("/petfollow")
                elseif cache.pet == true then
                    ni.player.runtext("/закл Укус\
/petattack")
                    cache.pet = false
                end
            elseif cache.control then
                ni.player.runtext("/petfollow")
            elseif cache.pet == true then
                ni.player.runtext("/закл Укус\
/petattack")
cache.pet = false
            end
        end
    end,
    -----------------------------------
    ["buff"] = function()
        if enables["duh"]
        and ni.spell.available(spells.duh)
        and not ni.player.buff(spells.duh) then
            ni.spell.cast(spells.duh)
        end
        if enables["aura"]
        and ni.spell.available(spells.aura)
        and not ni.player.buff(spells.aura) then
            ni.spell.cast(spells.aura)
        end
        if enables["pet"]
        and ni.unit.creator("playerpet") == nil
        and ni.spell.available(spells.pet) then
            ni.spell.cast(spells.pet)
        end
    end,
    -----------------------------------
    ["cd"] = function()
        if cache.PlayerCombat then
            count = GetItemCount("Фрагмент души")
            if ni.spell.available(316466)
            and not ni.unit.buff("player", 316466) then
                if count > 1 
                or ni.unit.hp("target") < 10 then
                    ni.spell.cast(316466)
                end
            end
            if ni.spell.available(316295) then
                ni.spell.cast(316295)
            end
            if ni.spell.available(316419)
            and ni.power.currentraw("player") < 40 then
                ni.spell.cast(316419)
            end
            if ni.spell.available(316422) then
                ni.spell.cast(316422)
            end
            if ni.spell.available(316445) then
                ni.spell.cast(316445)
            end
            if ni.unit.buff("player", 316440)
            and cache.PlayerCombat
            and ni.player.hasitem(50085) then
                ni.player.useitem(50085)
            end
            if ni.player.slotcastable(10)
            and ni.player.slotcd(10) == 0 then
                ni.player.useinventoryitem(10)
            end
            if ni.player.slotcastable(13)
            and ni.player.slotcd(13) == 0 then
                ni.player.useinventoryitem(13)
            end
            if ni.player.slotcastable(14)
            and ni.player.slotcd(14) == 0 then
                ni.player.useinventoryitem(14)
            end
            if ni.spell.available(319326) then
                ni.spell.cast(319326)
            end
            if ni.spell.available(spells.bs)
            and not ni.player.buff(spells.bs) then
                ni.spell.cast(spells.bs)
            end
            if ni.spell.available(spells.fas) then
                ni.spell.cast(spells.fas)
            end
            if enables["meta"] then
                if ni.player.buff(inputs.meta1)
                and ni.player.buff(inputs.meta2) then
                    ni.player.runtext("/закл Зов дикой природы")
                elseif ni.player.buff(inputs.meta1)
                    and inputs.meta2 == "" then
                    ni.player.runtext("/закл Зов дикой природы")
                elseif ni.player.buff(inputs.meta2)
                and inputs.meta1 == "" then
                    ni.player.runtext("/закл Зов дикой природы")
                elseif inputs.meta1 == ""
                and inputs.meta2 == "" then
                    ni.player.runtext("/закл Зов дикой природы")
                end
            else
                ni.player.runtext("/закл Зов дикой природы")
            end
            if ni.spell.available(316396)
            and ni.spell.valid("target", 316396, false, true, true) then
                ni.spell.cast(316396)
            end
            if ni.spell.available(spells.kick)
            and ni.spell.valid("target", spells.kick, false, true, true) then
                ni.spell.cast(spells.kick)
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
        end
    end,
    -----------------------------------
    ["metka"] = function()
        if cache.PlayerCombat
        and ni.spell.available(spells.metka)
        and ni.spell.valid("target", spells.metka, false, true, true)
        and not ni.unit.debuff("target", spells.metka) then
            ni.spell.cast(spells.metka)
            cache.pet = true
        end
    end,
    -----------------------------------
    ["napul"] = function()
        if cache.PlayerCombat
        and enables["napul"] then
            for i = 1, #ni.members do
                local ally = ni.members[i].unit;
                local tar = ni.objects[ally];
                if inputs.pool == tar.name
                and ni.spell.available(spells.napul)
                and ni.spell.valid(ally, spells.napul, false, true, true) then
                    ni.spell.cast(ally, spells.napul)
                    cache.pet = true
                end
            end
        end
    end,
    -----------------------------------
    ["pricel"] = function()
        if cache.PlayerCombat
        and not cache.control
        and ni.spell.available(spells.pricel)
        and ni.spell.valid("target", spells.pricel, false, true, true) then
            ni.spell.cast(spells.pricel)
            cache.pet = true
            cache.p = true
        end
    end,
    -----------------------------------
    ["killshot"] = function()
        if cache.PlayerCombat
        and not cache.control
        and ni.spell.available(spells.killshot)
        and ni.spell.valid("target", spells.killshot, false, true, true) then
            ni.spell.cast(spells.killshot)
            cache.pet = true
        end
    end,
    -----------------------------------
    ["ukus"] = function()
        if cache.PlayerCombat
        and not cache.control
        and ni.spell.available(spells.ukus)
        and ni.spell.valid("target", spells.ukus, false, true, true)
        and not ni.unit.debuff("target", spells.ukus, "player") then
            ni.spell.cast(spells.ukus)
            cache.pet = true
        end
    end,
    -----------------------------------
    ["himera"] = function()
        if cache.PlayerCombat
        and not cache.control
        and ni.spell.available(spells.himera)
        and ni.spell.valid("target", spells.himera, false, true, true) then
            if cache.p == true then
                if ni.spell.available(spells.eb) then
                    ni.spell.cast(spells.eb)
                end
                ni.spell.cast(spells.himera)
            elseif ni.player.buff(spells.eb) then
                ni.spell.cast(spells.himera)
            end
        end
    end,
    -----------------------------------
    ["gotov"] = function()
        if cache.PlayerCombat
        and not cache.control
        and ni.spell.available(spells.gotov) then
            ni.spell.cast(spells.gotov)
            cache.pet = true
        end
    end,
    -----------------------------------
    ["vera"] = function()
        if cache.PlayerCombat
        and ni.spell.cd(spells.pricel) > 1
        and not cache.control
        and not cache.IsMoving
        and ni.spell.available(spells.vera)
        and ni.spell.valid("target", spells.vera, false, true, true) then
            ni.spell.cast(spells.vera)
            cache.pet = true
        end
    end,
    -----------------------------------
    ["volsheb"] = function()
        if cache.PlayerCombat
        and cache.IsMoving
        and not cache.control
        and ni.spell.available(spells.volsheb)
        and ni.spell.valid("target", spells.volsheb, false, true, true) then
            ni.spell.cast(spells.volsheb)
            cache.pet = true
        end
    end,
    -----------------------------------
};
ni.bootstrap.profile("mark_by_makaren_wrath", queue, abilities, OnLoad, OnUnLoad);
elseif t4 > 1 then
    local enables = {
        ["target"] = true,
        ["duh"] = true,
        ["aura"] = true,
        ["napul"] = false,
        ["meta"] = true,
        ["smert"] = false,
        ["pet"] = true,
        ["kamen"] = true,
        ["debug"] = false,
    }
    local values = {
        kamen = 30,
    }
    local inputs = {
        pool = "Name",
        meta1 = "",
    meta2 = "",
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
        settingsfile = "mark_2t4_by_makaren.json",
        callback = GUICallback,
        { type = "title", text = "Mark 2T4 by |c0000CED1Makaren|r" },
        { type = "separator" },
        { type = "title", text = "|cffFF7C0AProfile beta-version 2.0.0|r" },
        { type = "separator" },
        { type = "page", number = 1, text = "|cffFFFF00Общие настройки|r" },
        { type = "separator" },
        { type = "entry", text = ni.spell.icon(6603).." Авто таргет", tooltip ="Автоматически выбирает таргет при его отсутствии", enabled = true, key = "target" },
        { type = "separator" },
        { type = "entry", text = ni.spell.icon(883).." Авто призыв пета", tooltip ="Автоматически призывает пета при его отсутствии", enabled = true, key = "pet" },
        { type = "entry", text = ni.spell.icon(61847).." Авто Дух дракондора", tooltip ="Автоматически использует Дух дракондора при его отсутствии", enabled = true, key = "duh" },
        { type = "entry", text = ni.spell.icon(19506).." Авто Аура меткого выстрела", tooltip ="Автоматически использует Ауру меткого выстрела при его отсутствии", enabled = true, key = "aura" },
        { type = "separator" },
        { type = "entry", text = ni.spell.icon(11729).." Камень здоровья", tooltip ="Использует Огурец при |cFF00FF00Hp <|r\
Работает в связке с функцией TTD(Time To Die)", enabled = true, value = 30, min = 1, max = 100, step = 1, key = "kamen" },
{ type = "separator" },
    { type = "entry", text = ni.spell.icon(24803).." Дебаг в чат", enabled = false, key = "debug" },
        { type = "page", number = 2, text = "|cffFFFF00Доп настройки|r" },
        { type = "separator" },
        { type = "entry", text = ni.spell.icon(34477).." Перенаправление", tooltip ="Использует Перенаправление по имени", enabled = false, key = "napul" },
        {
            type = "input",
            value = inputs["pool"],
            width = 140,
            height = 15,
            key = "pool"
        },
        { type = "separator" },
        { type = "entry", text = ni.spell.icon(53434).." Зов дикой природы под бафы", tooltip ="Использует зов дикой приироды при наличии бафов(id)", enabled = true, key = "meta" },
    {
		type = "input",
		value = inputs["meta1"],
		width = 140,
		height = 15,
		key = "meta1"
	},
    {
		type = "input",
		value = inputs["meta2"],
		width = 140,
		height = 15,
		key = "meta2"
	},
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(5384).." Авто Притвориться мертвым", tooltip ="Использует Притвориться мертвым для сброса агра", enabled = false, key = "smert" },
    };
    local function OnLoad()
        ni.GUI.AddFrame("mark_2t4_by_makaren", items);
    end;
    local function OnUnLoad()  
        ni.GUI.DestroyFrame("mark_2t4_by_makaren");
    end;
    local cache = {
        sindra = false,
        PlayerCombat = false,
        aoe = false,
        info = true,
        p = false,
        threat = 0,
        pet = true,
        control = false,
        };
    local spells = {
        duh = GetSpellInfo(61847),
        aura = GetSpellInfo(19506),
        metka = GetSpellInfo(53338),
        ukus = GetSpellInfo(49001),
        pricel = GetSpellInfo(49050),
        himera = GetSpellInfo(53209),
        vera = GetSpellInfo(49052),
        bs = GetSpellInfo(3045),
        napul = GetSpellInfo(34477),
        fas = GetSpellInfo(34026),
        gotov = GetSpellInfo(23989),
        kick = GetSpellInfo(34490),
        volsheb = GetSpellInfo(49045),
        killshot = GetSpellInfo(61006),
        petbuff = GetSpellInfo(53434),
        smert = GetSpellInfo(5384),
        eb = GetSpellInfo(316368),
        };
    local ddebuffs ={
        sindra = GetSpellInfo(69766),
        sindra_metka = GetSpellInfo(70126),
        }
    local queue = {
        "info",
        "cache",
        "pause",
        "auto-target",
        "buff",
        "cd",
        "metka",
        "napul",
        "pricel",
        "killshot",
        "ukus",
        "himera",
        "gotov",
        "vera",
        "volsheb",
    };
    local abilities = {
        -----------------------------------
        ["info"] = function()
            if cache.info == true
            and not ni.vars.coin then
                cache.info = false
                print("|cFFFF0000  =========================|r\
|cFFFFFFFFХант Стрелок|r\
|cFFFF5A00Приватный профиль by Makaren|r\
|cFF00FFFFФанпей https://funpay.com/users/7303789/|r\
|cFF00FFFFДс https://discord.com/users/785141640087207966|r\
|cFF00FFFFДс Группы https://discord.gg/eQzcDHbVfm|r\
|cFFFF0000=========================|r")
            end
        end,
        ------------------------
        ["cache"] = function()
            cache.PlayerCombat = UnitAffectingCombat("player") or false;
            cache.IsMoving = ni.player.ismoving() or false;
            if enables["smert"]
        and cache.threat > 2 then
            if ni.spell.available(spells.smert) then
                ni.spell.cast(spells.smert)
            end
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
        if enables["debug"] then
            ni.vars.debug = true
        else
            ni.vars.debug = false
        end
        if ni.spell.cd(spells.himera) ~= 0 then
            cache.p = false
            cache.pet = true
        end
        end,
        ------------------------
    ["pause"] = function()
        if IsMounted()
		or UnitInVehicle("player")
		or UnitIsDeadOrGhost("player")
		or UnitChannelInfo("player")
		or UnitCastingInfo("player")
		or ni.player.islooting() then
			return true;
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
                if ni.objectmanager.contains("Король-лич") then
                    local lich = ni.objectmanager.objectGUID("Король-лич")
                    local spell, _, _, _, _, endTime = UnitChannelInfo(lich)
                    if spell == ("Беспощадность зимы") then
                        ni.player.runtext("/petfollow")
                    elseif cache.pet == true then
                        ni.player.runtext("/закл Укус\
    /petattack")
                        cache.pet = false
                    end
                elseif cache.control then
                    ni.player.runtext("/petfollow")
                elseif cache.pet == true then
                    ni.player.runtext("/закл Укус\
    /petattack")
    cache.pet = false
                end
            end
        end,
        -----------------------------------
        ["buff"] = function()
            if enables["duh"]
            and ni.spell.available(spells.duh)
            and not ni.player.buff(spells.duh) then
                ni.spell.cast(spells.duh)
            end
            if enables["aura"]
            and ni.spell.available(spells.aura)
            and not ni.player.buff(spells.aura) then
                ni.spell.cast(spells.aura)
            end
            if enables["pet"]
        and ni.unit.creator("playerpet") == nil
        and ni.spell.available(spells.pet) then
            ni.spell.cast(spells.pet)
        end
        end,
        -----------------------------------
        ["cd"] = function()
            if cache.PlayerCombat then
                count = GetItemCount("Фрагмент души")
                if ni.spell.available(316466)
                and not ni.unit.buff("player", 316466) then
                    if count > 1 
                    or ni.unit.hp("target") < 10 then
                        ni.spell.cast(316466)
                    end
                end
                if ni.spell.available(316295) then
                    ni.spell.cast(316295)
                end
                if ni.spell.available(316419)
                and ni.power.currentraw("player") < 40 then
                    ni.spell.cast(316419)
                end
                if ni.spell.available(316422) then
                    ni.spell.cast(316422)
                end
                if ni.spell.available(316445) then
                    ni.spell.cast(316445)
                end
                if ni.unit.buff("player", 316440)
                and cache.PlayerCombat
                and ni.player.hasitem(50085) then
                    ni.player.useitem(50085)
                end
                if ni.player.slotcastable(10)
                and ni.player.slotcd(10) == 0 then
                    ni.player.useinventoryitem(10)
                end
                if ni.player.slotcastable(13)
                and ni.player.slotcd(13) == 0 then
                    ni.player.useinventoryitem(13)
                end
                if ni.player.slotcastable(14)
                and ni.player.slotcd(14) == 0 then
                    ni.player.useinventoryitem(14)
                end
                if ni.spell.available(319326) then
                    ni.spell.cast(319326)
                end
                if ni.spell.available(spells.bs)
                and not ni.player.buff(spells.bs) then
                    ni.spell.cast(spells.bs)
                end
                if ni.spell.available(spells.fas) then
                    ni.spell.cast(spells.fas)
                end
                if enables["meta"] then
                    if ni.player.buff(inputs.meta1)
                    and ni.player.buff(inputs.meta2) then
                        ni.player.runtext("/закл Зов дикой природы")
                    elseif ni.player.buff(inputs.meta1)
                        and inputs.meta2 == "" then
                        ni.player.runtext("/закл Зов дикой природы")
                    elseif ni.player.buff(inputs.meta2)
                    and inputs.meta1 == "" then
                        ni.player.runtext("/закл Зов дикой природы")
                    elseif inputs.meta1 == ""
                    and inputs.meta2 == "" then
                        ni.player.runtext("/закл Зов дикой природы")
                    end
                else
                    ni.player.runtext("/закл Зов дикой природы")
                end
                if ni.spell.available(316396)
            and ni.spell.valid("target", 316396, false, true, true) then
                ni.spell.cast(316396)
            end
                if ni.spell.available(spells.kick)
            and ni.spell.valid("target", spells.kick, false, true, true) then
                ni.spell.cast(spells.kick)
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
            end
        end,
        -----------------------------------
        ["metka"] = function()
            if cache.PlayerCombat
            and ni.spell.available(spells.metka)
            and ni.spell.valid("target", spells.metka, false, true, true)
            and not ni.unit.debuff("target", spells.metka) then
                ni.spell.cast(spells.metka)
                cache.pet = true
            end
        end,
        -----------------------------------
        ["napul"] = function()
            if cache.PlayerCombat
            and enables["napul"] then
                for i = 1, #ni.members do
                    local ally = ni.members[i].unit;
                    local tar = ni.objects[ally];
                    if inputs.pool == tar.name
                    and ni.spell.available(spells.napul)
                    and ni.spell.valid(ally, spells.napul, false, true, true) then
                        ni.spell.cast(ally, spells.napul)
                        cache.pet = true
                    end
                end
            end
        end,
        -----------------------------------
    ["pricel"] = function()
        if cache.PlayerCombat
        and not cache.control
        and ni.spell.available(spells.pricel)
        and ni.spell.valid("target", spells.pricel, false, true, true) then
            ni.spell.cast(spells.pricel)
            cache.pet = true
            cache.p = true
        end
    end,
    -----------------------------------
    ["killshot"] = function()
        if cache.PlayerCombat
        and not cache.control
        and ni.spell.available(spells.killshot)
        and ni.spell.valid("target", spells.killshot, false, true, true) then
            ni.spell.cast(spells.killshot)
            cache.pet = true
        end
    end,
    -----------------------------------
    ["ukus"] = function()
        if cache.PlayerCombat
        and not cache.control
        and ni.spell.available(spells.ukus)
        and ni.spell.valid("target", spells.ukus, false, true, true)
        and not ni.unit.debuff("target", spells.ukus, "player") then
            ni.spell.cast(spells.ukus)
            cache.pet = true
        end
    end,
    -----------------------------------
    ["himera"] = function()
        if cache.PlayerCombat
        and not cache.control
        and ni.spell.available(spells.himera)
        and ni.spell.valid("target", spells.himera, false, true, true) then
            if cache.p == true then
                if ni.spell.available(spells.eb) then
                    ni.spell.cast(spells.eb)
                end
                ni.spell.cast(spells.himera)
            elseif ni.player.buff(spells.eb) then
                ni.spell.cast(spells.himera)
            end
        end
    end,
        -----------------------------------
        ["gotov"] = function()
            if cache.PlayerCombat
            and not cache.control
            and ni.spell.available(spells.gotov) then
                ni.spell.cast(spells.gotov)
                cache.pet = true
            end
        end,
        -----------------------------------
        ["vera"] = function()
            if cache.PlayerCombat
            and not cache.IsMoving
            and not cache.control
            and ni.spell.available(spells.vera)
            and ni.spell.cd(spells.pricel) > 1
            and ni.spell.valid("target", spells.vera, false, true, true) then
                ni.spell.cast(spells.vera)
                cache.pet = true
            end
        end,
        -----------------------------------
        ["volsheb"] = function()
            if cache.PlayerCombat
            and cache.IsMoving
            and not cache.control
            and ni.spell.available(spells.volsheb)
            and ni.spell.valid("target", spells.volsheb, false, true, true) then
                ni.spell.cast(spells.volsheb)
                cache.pet = true
            end
        end,
        -----------------------------------
    };
    ni.bootstrap.profile("mark_by_makaren_wrath", queue, abilities, OnLoad, OnUnLoad);
else
    local enables = {
        ["target"] = true,
        ["duh"] = true,
        ["aura"] = true,
        ["napul"] = false,
        ["meta"] = true,
        ["smert"] = false,
        ["pet"] = true,
        ["kamen"] = true,
        ["debug"] = false,
    }
    local values = {
        kamen = 30,
    }
    local inputs = {
        pool = "Name",
        meta1 = "",
    meta2 = "",
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
        settingsfile = "mark_by_makaren_wrath.json",
        callback = GUICallback,
        { type = "title", text = "Mark by |c0000CED1Makaren|r" },
        { type = "separator" },
        { type = "title", text = "|cffFF7C0AProfile beta-version 2.0.0|r" },
        { type = "separator" },
        { type = "page", number = 1, text = "|cffFFFF00Общие настройки|r" },
        { type = "separator" },
        { type = "entry", text = ni.spell.icon(6603).." Авто таргет", tooltip ="Автоматически выбирает таргет при его отсутствии", enabled = true, key = "target" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(883).." Авто призыв пета", tooltip ="Автоматически призывает пета при его отсутствии", enabled = true, key = "pet" },
    { type = "entry", text = ni.spell.icon(61847).." Авто Дух дракондора", tooltip ="Автоматически использует Дух дракондора при его отсутствии", enabled = true, key = "duh" },
    { type = "entry", text = ni.spell.icon(19506).." Авто Аура меткого выстрела", tooltip ="Автоматически использует Ауру меткого выстрела при его отсутствии", enabled = true, key = "aura" },
    { type = "separator" },
        { type = "entry", text = ni.spell.icon(11729).." Камень здоровья", tooltip ="Использует Огурец при |cFF00FF00Hp <|r\
Работает в связке с функцией TTD(Time To Die)", enabled = true, value = 30, min = 1, max = 100, step = 1, key = "kamen" },
{ type = "separator" },
    { type = "entry", text = ni.spell.icon(24803).." Дебаг в чат", enabled = false, key = "debug" },
        { type = "page", number = 2, text = "|cffFFFF00Доп настройки|r" },
        { type = "separator" },
        { type = "entry", text = ni.spell.icon(34477).." Перенаправление", tooltip ="Использует Перенаправление по имени", enabled = false, key = "napul" },
        {
            type = "input",
            value = inputs["pool"],
            width = 140,
            height = 15,
            key = "pool"
        },
        { type = "separator" },
        { type = "entry", text = ni.spell.icon(53434).." Зов дикой природы под бафы", tooltip ="Использует зов дикой приироды при наличии бафов(id)", enabled = true, key = "meta" },
    {
		type = "input",
		value = inputs["meta1"],
		width = 140,
		height = 15,
		key = "meta1"
	},
    {
		type = "input",
		value = inputs["meta2"],
		width = 140,
		height = 15,
		key = "meta2"
	},
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(5384).." Авто Притвориться мертвым", tooltip ="Использует Притвориться мертвым для сброса агра", enabled = false, key = "smert" },
    };
    local function OnLoad()
        ni.GUI.AddFrame("mark_by_makaren_wrath", items);
    end;
    local function OnUnLoad()  
        ni.GUI.DestroyFrame("mark_by_makaren_wrath");
    end;
    local cache = {
        sindra = false,
        PlayerCombat = false,
        aoe = false,
        info = true,
        threat = 0,
        pet = true,
        control = false,
        };
    local spells = {
        duh = GetSpellInfo(61847),
        aura = GetSpellInfo(19506),
        metka = GetSpellInfo(53338),
        ukus = GetSpellInfo(49001),
        pricel = GetSpellInfo(49050),
        himera = GetSpellInfo(53209),
        vera = GetSpellInfo(49052),
        bs = GetSpellInfo(3045),
        napul = GetSpellInfo(34477),
        fas = GetSpellInfo(34026),
        gotov = GetSpellInfo(23989),
        kick = GetSpellInfo(34490),
        volsheb = GetSpellInfo(49045),
        killshot = GetSpellInfo(61006),
        petbuff = GetSpellInfo(53434),
        smert = GetSpellInfo(5384),
        eb = GetSpellInfo(316368),
        };
    local ddebuffs ={
        sindra = GetSpellInfo(69766),
        sindra_metka = GetSpellInfo(70126),
        }
    local queue = {
        "info",
        "cache",
        "pause",
        "auto-target",
        "buff",
        "cd",
        "metka",
        "napul",
        "killshot",
        "ukus",
        "himera",
        "pricel",
        "gotov",
        "vera",
        "volsheb",
    };
    local abilities = {
        -----------------------------------
        ["info"] = function()
            if cache.info == true
            and not ni.vars.coin then
                cache.info = false
                print("|cFFFF0000  =========================|r\
|cFFFFFFFFХант Стрелок|r\
|cFFFF5A00Приватный профиль by Makaren|r\
|cFF00FFFFФанпей https://funpay.com/users/7303789/|r\
|cFF00FFFFДс https://discord.com/users/785141640087207966|r\
|cFF00FFFFДс Группы https://discord.gg/eQzcDHbVfm|r\
|cFFFF0000=========================|r")
            end
        end,
        ------------------------
        ["cache"] = function()
            cache.PlayerCombat = UnitAffectingCombat("player") or false;
            cache.IsMoving = ni.player.ismoving() or false;
            if enables["smert"]
        and cache.threat > 2 then
            if ni.spell.available(spells.smert) then
                ni.spell.cast(spells.smert)
            end
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
        if enables["debug"] then
            ni.vars.debug = true
        else
            ni.vars.debug = false
        end
        end,
        ------------------------
    ["pause"] = function()
        if IsMounted()
		or UnitInVehicle("player")
		or UnitIsDeadOrGhost("player")
		or UnitChannelInfo("player")
		or UnitCastingInfo("player")
		or ni.player.islooting() then
			return true;
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
                if ni.objectmanager.contains("Король-лич") then
                    local lich = ni.objectmanager.objectGUID("Король-лич")
                    local spell, _, _, _, _, endTime = UnitChannelInfo(lich)
                    if spell == ("Беспощадность зимы") then
                        ni.player.runtext("/petfollow")
                    elseif cache.pet == true then
                        ni.player.runtext("/закл Укус\
    /petattack")
                        cache.pet = false
                    end
                elseif cache.control then
                    ni.player.runtext("/petfollow")
                elseif cache.pet == true then
                    ni.player.runtext("/закл Укус\
    /petattack")
    cache.pet = false
                end
            end
        end,
        -----------------------------------
        ["buff"] = function()
            if enables["duh"]
            and ni.spell.available(spells.duh)
            and not ni.player.buff(spells.duh) then
                ni.spell.cast(spells.duh)
            end
            if enables["aura"]
            and ni.spell.available(spells.aura)
            and not ni.player.buff(spells.aura) then
                ni.spell.cast(spells.aura)
            end
            if enables["pet"]
        and ni.unit.creator("playerpet") == nil
        and ni.spell.available(spells.pet) then
            ni.spell.cast(spells.pet)
        end
        end,
        -----------------------------------
        ["cd"] = function()
            if cache.PlayerCombat then
                count = GetItemCount("Фрагмент души")
                if ni.spell.available(316466)
                and not ni.unit.buff("player", 316466) then
                    if count > 1 
                    or ni.unit.hp("target") < 10 then
                        ni.spell.cast(316466)
                    end
                end
                if ni.spell.available(316419)
                and ni.power.currentraw("player") < 40 then
                    ni.spell.cast(316419)
                end
                if ni.spell.available(316295) then
                    ni.spell.cast(316295)
                end
                if ni.spell.available(316422) then
                    ni.spell.cast(316422)
                end
                if ni.spell.available(316445) then
                    ni.spell.cast(316445)
                end
                if ni.unit.buff("player", 316440)
                and cache.PlayerCombat
                and ni.player.hasitem(50085) then
                    ni.player.useitem(50085)
                end
                if ni.player.slotcastable(10)
                and ni.player.slotcd(10) == 0 then
                    ni.player.useinventoryitem(10)
                end
                if ni.player.slotcastable(13)
                and ni.player.slotcd(13) == 0 then
                    ni.player.useinventoryitem(13)
                end
                if ni.player.slotcastable(14)
                and ni.player.slotcd(14) == 0 then
                    ni.player.useinventoryitem(14)
                end
                if ni.spell.available(319326) then
                    ni.spell.cast(319326)
                end
                if ni.spell.available(spells.bs)
                and not ni.player.buff(spells.bs) then
                    ni.spell.cast(spells.bs)
                end
                if ni.spell.available(spells.fas) then
                    ni.spell.cast(spells.fas)
                end
                if enables["meta"] then
                    if ni.player.buff(inputs.meta1)
                    and ni.player.buff(inputs.meta2) then
                        ni.player.runtext("/закл Зов дикой природы")
                    elseif ni.player.buff(inputs.meta1)
                        and inputs.meta2 == "" then
                        ni.player.runtext("/закл Зов дикой природы")
                    elseif ni.player.buff(inputs.meta2)
                    and inputs.meta1 == "" then
                        ni.player.runtext("/закл Зов дикой природы")
                    elseif inputs.meta1 == ""
                    and inputs.meta2 == "" then
                        ni.player.runtext("/закл Зов дикой природы")
                    end
                else
                    ni.player.runtext("/закл Зов дикой природы")
                end
                if ni.spell.available(316396)
            and ni.spell.valid("target", 316396, false, true, true) then
                ni.spell.cast(316396)
            end
                if ni.spell.available(spells.kick)
            and ni.spell.valid("target", spells.kick, false, true, true) then
                ni.spell.cast(spells.kick)
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
            end
        end,
        -----------------------------------
        ["metka"] = function()
            if cache.PlayerCombat
            and ni.spell.available(spells.metka)
            and ni.spell.valid("target", spells.metka, false, true, true)
            and not ni.unit.debuff("target", spells.metka) then
                ni.spell.cast(spells.metka)
                cache.pet = true
            end
        end,
        -----------------------------------
        ["napul"] = function()
            if cache.PlayerCombat
            and enables["napul"] then
                for i = 1, #ni.members do
                    local ally = ni.members[i].unit;
                    local tar = ni.objects[ally];
                    if inputs.pool == tar.name
                    and ni.spell.available(spells.napul)
                    and ni.spell.valid(ally, spells.napul, false, true, true) then
                        ni.spell.cast(ally, spells.napul)
                        cache.pet = true
                    end
                end
            end
        end,
        -----------------------------------
    ["killshot"] = function()
        if cache.PlayerCombat
        and not cache.control
        and ni.spell.available(spells.killshot)
        and ni.spell.valid("target", spells.killshot, false, true, true) then
            ni.spell.cast(spells.killshot)
            cache.pet = true
        end
    end,
        -----------------------------------
        ["ukus"] = function()
            if cache.PlayerCombat
            and not cache.control
            and ni.spell.available(spells.ukus)
            and ni.spell.valid("target", spells.ukus, false, true, true)
            and not ni.unit.debuff("target", spells.ukus, "player") then
                ni.spell.cast(spells.ukus)
                cache.pet = true
            end
        end,
        -----------------------------------
        ["himera"] = function()
            if cache.PlayerCombat
            and not cache.control
            and ni.spell.available(spells.himera)
            and ni.spell.valid("target", spells.himera, false, true, true) then
                if ni.spell.available(spells.eb) then
                    ni.spell.cast(spells.eb)
                end
                ni.spell.cast(spells.himera)
                cache.pet = true
            end
        end,
        -----------------------------------
        ["pricel"] = function()
            if cache.PlayerCombat
            and not cache.control
            and ni.spell.available(spells.pricel)
            and ni.spell.valid("target", spells.pricel, false, true, true) then
                ni.spell.cast(spells.pricel)
                cache.pet = true
            end
        end,
        -----------------------------------
        ["gotov"] = function()
            if cache.PlayerCombat
            and not cache.control
            and ni.spell.available(spells.gotov) then
                ni.spell.cast(spells.gotov)
                cache.pet = true
            end
        end,
        -----------------------------------
        ["vera"] = function()
            if cache.PlayerCombat
            and not cache.IsMoving
            and not cache.control
            and ni.spell.cd(spells.pricel) > 1
            and ni.spell.available(spells.vera)
            and ni.spell.valid("target", spells.vera, false, true, true) then
                ni.spell.cast(spells.vera)
                cache.pet = true
            end
        end,
        -----------------------------------
        ["volsheb"] = function()
            if cache.PlayerCombat
            and cache.IsMoving
            and not cache.control
            and ni.spell.available(spells.volsheb)
            and ni.spell.valid("target", spells.volsheb, false, true, true) then
                ni.spell.cast(spells.volsheb)
                cache.pet = true
            end
        end,
        -----------------------------------
    };
		ni.bootstrap.profile("mark_by_makaren_wrath", queue, abilities, OnLoad, OnUnLoad);
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
    ni.bootstrap.profile("mark_by_makaren_wrath", queue, abilities);
end;