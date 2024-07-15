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
    ["so"] = false,
    ["kamen"] = true,
    ["debug"] = false,
}
local values = {
    so = 33,
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
    settingsfile = "beastmaster_4t4_by_makaren.json",
    callback = GUICallback,
    { type = "title", text = "Beastmaster 4T4 by |c0000CED1Makaren|r" },
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
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(322472).." Авто Стрела Охоты", tooltip ="Использует Стрелу Охоты, если мана меньше", enabled = false, value = 33, min = 1, max = 100, step = 1, key = "so" },
};
local function OnLoad()
	ni.GUI.AddFrame("beastmaster_4t4_by_makaren", items);
end;
local function OnUnLoad()  
	ni.GUI.DestroyFrame("beastmaster_4t4_by_makaren");
end;
local cache = {
    sindra = false,
    PlayerCombat = false,
    aoe = 0,
    info = true,
    threat = 0,
    aa = false,
    p = true,
    c = true,
    control = false,
    };
local spells = {
    duh = GetSpellInfo(61847),
    aura = GetSpellInfo(19506),
    metka = GetSpellInfo(53338),
    zalp = GetSpellInfo(49048),
    ukus = GetSpellInfo(49001),
    vera = GetSpellInfo(49052),
    bs = GetSpellInfo(3045),
    napul = GetSpellInfo(34477),
    fas = GetSpellInfo(34026),
    gotov = GetSpellInfo(23989),
    kick = GetSpellInfo(34490),
    petbuff = GetSpellInfo(53434),
    smert = GetSpellInfo(5384),
    pet = GetSpellInfo(883),
    so = GetSpellInfo(322472),
    zg = GetSpellInfo(19574),
    eb = GetSpellInfo(316368)
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
    "so",
    "zalp",
    "ukus",
    "ukus_aoe",
    "vera",
};
local abilities = {
    -----------------------------------
    ["info"] = function()
        if cache.info == true
        and not ni.vars.coin then
            cache.info = false
            print("|cFFFF0000  =========================|r\
|cFFFFFFFFХант БМ|r\
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
        if ni.player.buffstacks(319308) == 2
        and ni.spell.cd(spells.zalp) < 1 then
            cache.aa = true
        elseif cache.aa == true
        and ni.player.buffstacks(321487) < 4 then
            cache.aa = false
        end
        local enemies = ni.unit.enemiesinrange("player", 35)
        cache.aoe = 0
        for i = 1, #enemies do
            local target = enemies[i].guid
            if ni.unit.debuff(target, spells.ukus, "player") then
                cache.aoe = cache.aoe + 1
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
            if ni.player.buffstacks(321487) >= 4
            and cache.aa == true then
                ni.player.runtext("/petstay")
                cache.c = false
            elseif ni.objectmanager.contains("Король-лич") then
                local lich = ni.objectmanager.objectGUID("Король-лич")
                local spell, _, _, _, _, endTime = UnitChannelInfo(lich)
                if spell == ("Беспощадность зимы") then
                    ni.player.runtext("/petfollow")
                else
                    if cache.p == true then
                        ni.player.runtext("/petfollow\
/закл Укус\
/petattack")
                        cache.p = false
                        cache.c = true
                    end
                end
            elseif cache.control then
                ni.player.runtext("/petfollow")
            else
                if cache.p == true then
                    ni.player.runtext("/petfollow\
/закл Укус\
/petattack")
                    cache.p = false
                    cache.c = true
                end
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
            cache.p = true
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
                    cache.p = true
                end
            end
        end
    end,
    -----------------------------------
    ["so"] = function()
        if enables["so"]
        and ni.power.current("player") <= values.so
        and cache.PlayerCombat
        and not cache.control
        and ni.spell.available(spells.so)
        and ni.spell.valid("target", spells.so, false, true, true) then
            ni.spell.cast(spells.so)
            cache.p = true
        end
    end,
    -----------------------------------
    ["zalp"] = function()
        if cache.PlayerCombat
        and not cache.control
        and ni.spell.available(spells.zalp)
        and ni.spell.valid("target", spells.zalp, false, true, true) then
            if cache.c == true
            and ni.player.buffstacks(319308) == 2
            and ni.spell.cd(spells.zalp) < 1
            and ni.spell.available(spells.zg) then
                ni.spell.cast(spells.zg)
            end
            if ni.spell.available(spells.eb) then
                ni.spell.cast(spells.eb)
            end
            ni.spell.cast(spells.zalp)
            cache.p = true
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
            cache.p = true
        end
    end,
    -----------------------------------
    ["ukus_aoe"] = function()
        if ni.spell.available(spells.ukus)
        and cache.aoe < 4 then
            local enemies = ni.unit.enemiesinrange("player", 35)
            for i = 1, #enemies do
                local target = enemies[i].guid
                if not ni.unit.debuff(target, "Сглаз") 
                and not ni.unit.debuff(target, "Устрашающий крик") 
                and not ni.unit.debuff(target, "Гнев деревьев") 
                and not ni.unit.debuff(target, "Смерч") 
                and not ni.unit.debuff(target, "Превращение") 
                and not ni.unit.debuff(target, "Замораживающая ловушка") 
                and not ni.unit.debuff(target, "Покаяние") 
                and not ni.unit.debuff(target, "Ослепление") 
                and not ni.unit.debuff(target, "Ошеломление") 
                and not ni.unit.debuff(target, "Вой ужаса") 
                and not ni.unit.debuff(target, "Изгнание") 
                and not ni.unit.debuff(target, "Страх") 
                and not ni.unit.debuff(target, "Спячка") 
                and not ni.unit.debuff(target, "Отпугивание зверя") 
                and not ni.unit.debuff(target, "Ментальный крик") then
                    if not ni.unit.debuff(target, spells.ukus, "player") then
                        if cache.PlayerCombat
                        and ni.spell.valid(target, spells.ukus, false, true, true) then
                            ni.spell.cast(spells.ukus, target)
                            cache.p = true
                        end
                    end
                end
            end
        end
    end,
    -----------------------------------
    ["vera"] = function()
        if cache.PlayerCombat
        and not cache.control
        and not cache.IsMoving
        and ni.spell.available(spells.vera)
        and ni.spell.cd(spells.zalp) > 1
        and ni.spell.valid("target", spells.vera, false, true, true) then
            ni.spell.cast(spells.vera)
            cache.p = true
        end
    end,
    -----------------------------------
};
ni.bootstrap.profile("beastmaster_by_makaren_wrath", queue, abilities, OnLoad, OnUnLoad);
elseif t4 > 1 then
    local enables = {
        ["target"] = true,
        ["duh"] = true,
        ["aura"] = true,
        ["napul"] = false,
        ["meta"] = true,
        ["smert"] = false,
        ["pet"] = true,
        ["so"] = false,
        ["kamen"] = true,
        ["debug"] = false,
    }
    local values = {
        so = 33,
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
        settingsfile = "beastmaster_2t4_by_makaren.json",
        callback = GUICallback,
        { type = "title", text = "Beastmaster 2T4 by |c0000CED1Makaren|r" },
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
        { type = "separator" },
        { type = "entry", text = ni.spell.icon(322472).." Авто Стрела Охоты", tooltip ="Использует Стрелу Охоты, если мана меньше", enabled = false, value = 33, min = 1, max = 100, step = 1, key = "so" },
    };
    local function OnLoad()
        ni.GUI.AddFrame("beastmaster_2t4_by_makaren", items);
    end;
    local function OnUnLoad()  
        ni.GUI.DestroyFrame("beastmaster_2t4_by_makaren");
    end;
    local cache = {
        sindra = false,
        PlayerCombat = false,
        aoe = false,
        info = true,
        threat = 0,
        p = true,
        control = false,
        };
    local spells = {
        duh = GetSpellInfo(61847),
        aura = GetSpellInfo(19506),
        metka = GetSpellInfo(53338),
        zalp = GetSpellInfo(49048),
        ukus = GetSpellInfo(49001),
        vera = GetSpellInfo(49052),
        bs = GetSpellInfo(3045),
        napul = GetSpellInfo(34477),
        fas = GetSpellInfo(34026),
        gotov = GetSpellInfo(23989),
        kick = GetSpellInfo(34490),
        petbuff = GetSpellInfo(53434),
        smert = GetSpellInfo(5384),
        pet = GetSpellInfo(883),
        so = GetSpellInfo(322472),
        volsheb = GetSpellInfo(49045),
        zg = GetSpellInfo(19574),
        eb = GetSpellInfo(316368)
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
        "so",
        "zalp",
        "volsheb",
        "ukus",
        "vera",
    };
    local abilities = {
        -----------------------------------
        ["info"] = function()
            if cache.info == true
            and not ni.vars.coin then
                cache.info = false
                print("|cFFFF0000  =========================|r\
|cFFFFFFFFХант БМ|r\
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
                    elseif cache.p == true then
                        ni.player.runtext("/закл Укус\
/petattack")
                        cache.p = false
                    end
                elseif cache.control then
                    ni.player.runtext("/petfollow")
                elseif cache.p == true then
                    ni.player.runtext("/закл Укус\
/petattack")
cache.p = false
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
                if ni.player.buffstacks(319308) == 2
        and ni.spell.cd(spells.zalp) < 1 then
            if ni.spell.available(spells.zg) then
                ni.spell.cast(spells.zg)
            end
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
                cache.p = true
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
                        cache.p = true
                    end
                end
            end
        end,
        -----------------------------------
        ["so"] = function()
            if enables["so"]
            and not cache.control
            and ni.power.current("player") <= values.so
            and cache.PlayerCombat
            and ni.spell.available(spells.so)
            and ni.spell.valid("target", spells.so, false, true, true) then
                ni.spell.cast(spells.so)
                cache.p = true
            end
        end,
        -----------------------------------
        ["zalp"] = function()
            if cache.PlayerCombat
            and not cache.control
            and ni.spell.available(spells.zalp)
            and ni.spell.valid("target", spells.zalp, false, true, true) then
                if ni.spell.available(spells.eb) then
                    ni.spell.cast(spells.eb)
                end
                ni.spell.cast(spells.zalp)
                cache.p = true
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
                cache.p = true
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
                cache.p = true
            end
        end,
        -----------------------------------
        ["vera"] = function()
            if cache.PlayerCombat
            and not cache.IsMoving
            and not cache.control
            and ni.spell.available(spells.vera)
            and ni.spell.cd(spells.zalp) > 1
            and ni.spell.valid("target", spells.vera, false, true, true) then
                ni.spell.cast(spells.vera)
                cache.p = true
            end
        end,
        -----------------------------------
    };
    ni.bootstrap.profile("beastmaster_by_makaren_wrath", queue, abilities, OnLoad, OnUnLoad);
else
    local enables = {
        ["target"] = true,
        ["duh"] = true,
        ["aura"] = true,
        ["napul"] = false,
        ["meta"] = true,
        ["smert"] = false,
        ["pet"] = true,
        ["so"] = false,
        ["kamen"] = true,
        ["debug"] = false,
    }
    local values = {
        so = 33,
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
        settingsfile = "beastmaster_by_makaren_wrath.json",
        callback = GUICallback,
        { type = "title", text = "Beastmaster by |c0000CED1Makaren|r" },
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
        { type = "separator" },
        { type = "entry", text = ni.spell.icon(322472).." Авто Стрела Охоты", tooltip ="Использует Стрелу Охоты, если мана меньше", enabled = false, value = 33, min = 1, max = 100, step = 1, key = "so" },
    };
    local function OnLoad()
        ni.GUI.AddFrame("beastmaster_by_makaren_wrath", items);
    end;
    local function OnUnLoad()  
        ni.GUI.DestroyFrame("beastmaster_by_makaren_wrath");
    end;
    local cache = {
        sindra = false,
        PlayerCombat = false,
        aoe = false,
        info = true,
        threat = 0,
        p = true,
        control = false,
        };
    local spells = {
        duh = GetSpellInfo(61847),
        aura = GetSpellInfo(19506),
        metka = GetSpellInfo(53338),
        zalp = GetSpellInfo(49048),
        ukus = GetSpellInfo(49001),
        vera = GetSpellInfo(49052),
        bs = GetSpellInfo(3045),
        napul = GetSpellInfo(34477),
        fas = GetSpellInfo(34026),
        gotov = GetSpellInfo(23989),
        kick = GetSpellInfo(34490),
        petbuff = GetSpellInfo(53434),
        smert = GetSpellInfo(5384),
        pet = GetSpellInfo(883),
        so = GetSpellInfo(322472),
        volsheb = GetSpellInfo(49045),
        zg = GetSpellInfo(19574),
        pricel = GetSpellInfo(49050),
        eb = GetSpellInfo(316368)
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
        "so",
        "volsheb",
        "zalp",
        "ukus",
        "vera",
    };
    local abilities = {
        -----------------------------------
        ["info"] = function()
            if cache.info == true
            and not ni.vars.coin then
                cache.info = false
                print("|cFFFF0000  =========================|r\
|cFFFFFFFFХант БМ|r\
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
                    elseif cache.p == true then
                        ni.player.runtext("/закл Укус\
/petattack")
                        cache.p = false
                    end
                elseif cache.control then
                    ni.player.runtext("/petfollow")
                elseif cache.p == true then
                    ni.player.runtext("/закл Укус\
/petattack")
cache.p = false
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
                if ni.spell.available(spells.zg) then
                    ni.spell.cast(spells.zg)
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
                cache.p = true
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
                        cache.p = true
                    end
                end
            end
        end,
        -----------------------------------
        ["so"] = function()
            if enables["so"]
            and not cache.control
            and ni.power.current("player") <= values.so
            and cache.PlayerCombat
            and ni.spell.available(spells.so)
            and ni.spell.valid("target", spells.so, false, true, true) then
                ni.spell.cast(spells.so)
                cache.p = true
            end
        end,
        -----------------------------------
        ["volsheb"] = function()
            if cache.PlayerCombat
            and not cache.control
            and cache.IsMoving
            and ni.spell.available(spells.volsheb)
            and ni.spell.valid("target", spells.volsheb, false, true, true) then
                ni.spell.cast(spells.volsheb)
                cache.p = true
            end
        end,
        -----------------------------------
        ["zalp"] = function()
            if cache.PlayerCombat
            and not cache.control then
                local enemies_ = ni.unit.enemiesinrange("target", 6)
                local name, iconPath, tier, column, currentRank, maxRank, isExceptional, meetsPrereq = GetTalentInfo(2, 9);
                if #enemies_ >= 1 then
                    if ni.spell.available(spells.zalp)
                    and ni.spell.valid("target", spells.zalp, false, true, true) then
                        if ni.spell.available(spells.eb) then
                            ni.spell.cast(spells.eb)
                        end
                        ni.spell.cast(spells.zalp)
                        cache.p = true
                    end
                elseif isExceptional == 1 then
                if ni.spell.available(spells.pricel)
                    and ni.spell.valid("target", spells.pricel, false, true, true) then
                        if ni.spell.available(spells.eb) then
                            ni.spell.cast(spells.eb)
                        end
                        ni.spell.cast(spells.pricel)
                        cache.p = true
                    end
                elseif ni.spell.available(spells.zalp)
                and ni.spell.valid("target", spells.zalp, false, true, true) then
                    if ni.spell.available(spells.eb) then
                        ni.spell.cast(spells.eb)
                    end
                    ni.spell.cast(spells.zalp)
                    cache.p = true
                end
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
                cache.p = true
            end
        end,
        -----------------------------------
        ["vera"] = function()
            if cache.PlayerCombat
            and not cache.control
            and not cache.IsMoving
            and ni.spell.available(spells.vera)
            and ni.spell.cd(spells.zalp) > 1
            and ni.spell.valid("target", spells.vera, false, true, true) then
                ni.spell.cast(spells.vera)
                cache.p = true
            end
        end,
        -----------------------------------
    };
		ni.bootstrap.profile("beastmaster_by_makaren_wrath", queue, abilities, OnLoad, OnUnLoad);
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
    ni.bootstrap.profile("beastmaster_by_makaren_wrath", queue, abilities);
end;