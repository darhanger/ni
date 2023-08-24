local Sirus = GetItemInfo(100455) ~= nil or false;
if Sirus then
local t4 = 0
if ni.player.hasitemequipped(29033) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(29034) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(29035) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(29036) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(29037) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100420) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100421) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100422) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100423) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100424) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101320) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101321) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101322) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101323) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101324) then
    t4 = t4 + 1
end
if t4 > 3 then
local enables = {
    ["totems"] = true,
    ["target"] = true,
    ["kamen"] = true,
    ["buff"] = true,
    ["kick"] = false,
    ["kick_2"] = false,
    ["grom"] = true,
    ["shild_m"] = false,
    ["kick_3"] = false,
    ["debug"] = false,
}
local values = {
    osvob = 4,
    shild_m = 70,
    grom = 60,
    kamen = 30,
}
local inputs = {
    kiick = "",
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
    settingsfile = "elem_4t4_by_makaren.json",
    callback = GUICallback,
    { type = "title", text = "Elem_Shaman_4T4 by |c0000CED1Makaren|r" },
	{ type = "separator" },
	{ type = "title", text = "|cffFF7C0AProfile version 2.0.0|r" },
	{ type = "separator" },
    { type = "page", number = 1, text = "|cffFFFF00Общие настройки|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(69762).." Освобожденная магия", tooltip ="Количество набираемых стаков Освобожденной магии |cFF00FFFFЦлк(Синдрагоса)|r", value = 4, min = 1, max = 10, step = 1, key = "osvob" },    
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(6603).." Авто таргет", tooltip ="Автоматически выбирает таргет при его отсутствии", enabled = true, key = "target" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(58790).." Авто баф оружия", tooltip ="Автоматически бафает оружие", enabled = true, key = "buff" },
    { type = "entry", text = ni.spell.icon(66842).." Авто призыв тотемов", tooltip ="Автоматически призывает тотемы если их нет", enabled = true, key = "totems" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(11729).." Камень здоровья", tooltip ="Использует Огурец при |cFF00FF00Hp <|r\
Работает в связке с функцией TTD(Time To Die)", enabled = true, value = 30, min = 1, max = 100, step = 1, key = "kamen" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(24803).." Дебаг в чат", enabled = false, key = "debug" },
    { type = "page", number = 2, text = "|cffFFFF00Доп настройки|r" },
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
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(57960).." Водный щит", tooltip ="Использует Водный щит при его отсутствии, если мана меньше", enabled = false, value = 70, min = 1, max = 100, step = 1, key = "shild_m" },
    { type = "entry", text = ni.spell.icon(59159).." Гром и молния", tooltip ="Использует Гром и молния, если мана меньше", enabled = true, value = 60, min = 1, max = 100, step = 1, key = "grom" },
};
local function OnLoad()
	ni.GUI.AddFrame("elem_4t4_by_makaren", items);
end;
local function OnUnLoad()  
	ni.GUI.DestroyFrame("elem_4t4_by_makaren");
end;
local cache = {
    IsMoving = false,
    stopcast = false,
    sindra = false,
    PlayerCombat = false,
    info = true,
    control = false,
    };
local spells = {
    shild_mana = GetSpellInfo(57960),
    shild_mo = GetSpellInfo(49281),
    char_rass = GetSpellInfo(316432),
    hex = GetSpellInfo(51514),
    eb_ras = GetSpellInfo(51514),
    totems = GetSpellInfo(66842),
    lava = GetSpellInfo(60043),
    fast = GetSpellInfo(16166),
    dar = GetSpellInfo(316368),
    shok_fire = GetSpellInfo(49233),
    shok_led = GetSpellInfo(49236),
    shok_zemlya = GetSpellInfo(49231),
    molnia = GetSpellInfo(49238),
    molnia_2 = GetSpellInfo(49271),
    kick = GetSpellInfo(57994),
    fire_or = GetSpellInfo(58790),
    grom = GetSpellInfo(59159),
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
    "pause",
    "save",
    "buff",
    "auto-target",
    "kick",
    "kick_1",
    "totems",
    "cd",
    "shok_fire_obnova",
    "shok_zemlya",
    "shok_led",
    "lava",
    "shok_fire",
    "molnia_2",
    "molnia",
    "shok_fire_2",
    "shok_led_2",
    "shok_zemlya_2",
};
local abilities = {
    -----------------------------------
    ["info"] = function()
        if cache.info == true
        and not ni.vars.coin then
            cache.info = false
            print("|cFFFF0000  =========================|r\
|cFFFFFFFFЭлементаль Шаман|r\
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
    ["save"] = function()
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
    end,
    -----------------------------------
    ["buff"] = function()
        if enables["buff"] then
            local hasMainHandEnchant, mainHandExpiration, mainHandCharges, mainHandEnchantID, hasOffHandEnchant, offHandExpiration, offHandCharges, offHandEnchantID = GetWeaponEnchantInfo()
            if hasMainHandEnchant ~= 1 then
                ni.spell.cast(spells.fire_or)
            end
        end
        if enables["shild_m"]
        and ni.power.current("player") <= values.shild_m
        and ni.spell.available(spells.shild_mana)
        and not ni.player.buff(spells.shild_mana) then
            ni.spell.cast(spells.shild_mana)
        end
        if enables["grom"]
        and ni.power.current("player") <= values.grom
        and ni.spell.available(spells.grom) then
            ni.spell.cast(spells.grom)
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
    ["kick_1"] = function()
        for i = 1, #ni.members do
            local ally = ni.members[i].unit;
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
    ["totems"] = function()
        if enables["totems"]
        and cache.PlayerCombat then
            local haveTotem, totemName = GetTotemInfo(3)
            if totemName ~= "Тотем прилива маны" then
                local haveTotem1, totemName1, startTime1, duration1 = GetTotemInfo(4)
                local haveTotem, totemName, startTime, duration = GetTotemInfo(1)
                if duration == 0
                and duration1 == 0 then
                    ni.spell.cast(spells.totems)
                end
                local haveTotem, totemName, startTime, duration = GetTotemInfo(1)
                if duration == 0 then
                    ni.spell.cast(57722)
                end
                local haveTotem, totemName, startTime, duration = GetTotemInfo(4)
                if duration == 0 then
                    ni.spell.cast(3738)
                end
            end
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
            if ni.spell.available(316295) 
            and ni.player.buff("Элементаль бури") then
                ni.spell.cast(316295)
            end
            if ni.spell.available(316421)
            and ni.power.current("player") < 80 then
                ni.spell.cast(316421)
            end
            if ni.spell.available(316422)
            and ni.player.buff("Элементаль бури") then
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
            and ni.player.slotcd(10) == 0 then
                ni.player.useinventoryitem(10)
            end
            if ni.player.slotcastable(13)
            and ni.player.slotcd(13) == 0
            and ni.player.buff("Элементаль бури") then
                ni.player.useinventoryitem(13)
            end
            if ni.player.slotcastable(14)
            and ni.player.slotcd(14) == 0
            and ni.player.buff("Элементаль бури") then
                ni.player.useinventoryitem(14)
            end
            if ni.spell.available(319326)
            and ni.player.buff("Элементаль бури") then
                ni.spell.cast(319326)
            end
            if ni.spell.available(316396)
            and ni.spell.valid("target", 316396, false, true, true) then
                ni.spell.cast(316396)
            end
        end
    end,
    --------------------------
    ["shok_fire_obnova"] = function()
        if cache.PlayerCombat
        and not cache.control
        and ni.unit.debuffremaining("target", spells.shok_fire, "player") < 2
        or not ni.unit.debuff("target", spells.shok_fire) then
            if ni.spell.available(spells.shok_fire)
            and ni.player.buff("Элементаль бури")
            and ni.spell.valid("target", spells.shok_fire, false, true, true) then
                ni.spell.cast(spells.shok_fire)
            end
        end
    end,
    --------------------------
    ["shok_zemlya"] = function()
        if cache.PlayerCombat
        and not cache.control
        and ni.spell.available(spells.shok_zemlya)
        and ni.player.buff(320464)
        and ni.player.buff("Элементаль бури")
        and ni.spell.valid("target", spells.shok_zemlya, false, true, true) then
            ni.spell.cast(spells.shok_zemlya)
        end
    end,
    --------------------------
    ["shok_led"] = function()
        if not cache.control
        and cache.PlayerCombat
        and ni.spell.available(spells.shok_led)
        and ni.player.buff("Элементаль бури")
        and ni.spell.valid("target", spells.shok_led, false, true, true) then
            ni.spell.cast(spells.shok_led)
        end
    end,
    --------------------------
    ["lava"] = function()
        if cache.PlayerCombat
        and not cache.control
        and not cache.stopcast
        and not cache.IsMoving then
            if not ni.player.buff("Элементаль бури") then
                if ni.spell.available(spells.fast)
                and ni.spell.available(spells.lava)
                and not ni.player.buff(32182)
                and not ni.player.buff(2825)
                and not ni.player.buff(10060) then
                    ni.spell.cast(spells.fast)
                elseif ni.spell.available(spells.dar)
                and ni.unit.buffstacks("player", 320461) < 2
                and ni.spell.available(spells.lava) then
                    ni.spell.cast(spells.dar)
                elseif ni.spell.available(spells.lava)
                and ni.spell.valid("target", spells.lava, false, true, true) then
                    ni.spell.cast(spells.lava)
                end
            end
            if ni.unit.buffremaining("player", "Элементаль бури") > 6
            and ni.spell.available(spells.lava)
            and ni.spell.valid("target", spells.lava, false, true, true) then
                ni.spell.cast(spells.lava)
            end
        end
    end,
    --------------------------
    ["shok_fire"] = function()
        if cache.PlayerCombat
        and not cache.control
        and not ni.unit.debuff("target", spells.shok_fire, "player") then
            if ni.spell.available(spells.shok_fire)
            and ni.spell.valid("target", spells.shok_fire, false, true, true) then
                ni.spell.cast(spells.shok_fire)
            end
        end
    end,
    --------------------------
    ["molnia_2"] = function()
        if cache.PlayerCombat
        and not cache.stopcast
        and not cache.control
        and not cache.IsMoving
        and ni.spell.available(spells.molnia_2)
        and ni.player.buff("Элементаль бури")
        and ni.spell.valid("target", spells.molnia_2, false, true, true) then
            ni.spell.cast(spells.molnia_2)
        end
    end,
    --------------------------
    ["molnia"] = function()
        local enemies = ni.unit.enemiesinrange("target", 10)
        if #enemies >= 1 then
            if cache.PlayerCombat
        and not cache.stopcast
        and not cache.control
        and not cache.IsMoving
        and ni.spell.available(spells.molnia_2)
        and ni.spell.valid("target", spells.molnia_2, false, true, true) then
            ni.spell.cast(spells.molnia_2)
        end
        elseif cache.PlayerCombat
        and not cache.stopcast
        and not cache.control
        and not cache.IsMoving
        and ni.spell.available(spells.molnia)
        and ni.spell.valid("target", spells.molnia, false, true, true) then
            if ni.player.buff("Элементаль бури") then
                if ni.spell.cd(spells.shok_led) > 1
                and ni.spell.cd(spells.shok_zemlya) > 1 then
                    ni.spell.cast(spells.molnia)
                end
            else ni.spell.cast(spells.molnia)
            end 
        end
    end,
    --------------------------
    ["shok_fire_2"] = function()
        if cache.PlayerCombat
        and not cache.control
        and ni.spell.available(spells.shok_fire)
        and ni.spell.valid("target", spells.shok_fire, false, true, true) then
            ni.spell.cast(spells.shok_fire)
        end
    end,
    --------------------------
    ["shok_led_2"] = function()
        if cache.PlayerCombat
        and not cache.control
        and ni.spell.available(spells.shok_led)
        and ni.spell.valid("target", spells.shok_led, false, true, true) then
            ni.spell.cast(spells.shok_led)
        end
    end,
    --------------------------
    ["shok_zemlya_2"] = function()
        if cache.PlayerCombat
        and not cache.control
        and ni.spell.available(spells.shok_zemlya)
        and ni.spell.valid("target", spells.shok_zemlya, false, true, true) then
            ni.spell.cast(spells.shok_zemlya)
        end
    end,
    --------------------------
};
ni.bootstrap.profile("elem_by_makaren_wrath", queue, abilities, OnLoad, OnUnLoad);
elseif t4 > 1 then  
    local enables = {
        ["totems"] = true,
        ["target"] = true,
        ["kamen"] = true,
        ["buff"] = true,
        ["kick"] = false,
    ["kick_2"] = false,
    ["grom"] = true,
    ["shild_m"] = false,
    ["kick_3"] = false,
    ["debug"] = false,
    }
    local values = {
        osvob = 4,
        shild_m = 70,
    grom = 60,
    kamen = 30,
    }
    local inputs = {
        kiick = "",
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
        settingsfile = "elem_2t4_by_makaren.json",
        callback = GUICallback,
        { type = "title", text = "Elem_Shaman_2T4 by |c0000CED1Makaren|r" },
        { type = "separator" },
        { type = "title", text = "|cffFF7C0AProfile version 2.0.0|r" },
	{ type = "separator" },
    { type = "page", number = 1, text = "|cffFFFF00Общие настройки|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(69762).." Освобожденная магия", tooltip ="Количество набираемых стаков Освобожденной магии |cFF00FFFFЦлк(Синдрагоса)|r", value = 4, min = 1, max = 10, step = 1, key = "osvob" },    
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(6603).." Авто таргет", tooltip ="Автоматически выбирает таргет при его отсутствии", enabled = true, key = "target" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(58790).." Авто баф оружия", tooltip ="Автоматически бафает оружие", enabled = true, key = "buff" },
    { type = "entry", text = ni.spell.icon(66842).." Авто призыв тотемов", tooltip ="Автоматически призывает тотемы если их нет", enabled = true, key = "totems" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(11729).." Камень здоровья", tooltip ="Использует Огурец при |cFF00FF00Hp <|r\
Работает в связке с функцией TTD(Time To Die)", enabled = true, value = 30, min = 1, max = 100, step = 1, key = "kamen" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(24803).." Дебаг в чат", enabled = false, key = "debug" },
    { type = "page", number = 2, text = "|cffFFFF00Доп настройки|r" },
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
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(57960).." Водный щит", tooltip ="Использует Водный щит при его отсутствии, если мана меньше", enabled = false, value = 70, min = 1, max = 100, step = 1, key = "shild_m" },
    { type = "entry", text = ni.spell.icon(59159).." Гром и молния", tooltip ="Использует Гром и молния, если мана меньше", enabled = true, value = 60, min = 1, max = 100, step = 1, key = "grom" },
};
    local function OnLoad()
        ni.GUI.AddFrame("elem_2t4_by_makaren", items);
    end;
    local function OnUnLoad()  
        ni.GUI.DestroyFrame("elem_2t4_by_makaren");
    end;
    local cache = {
        IsMoving = false,
        stopcast = false,
        sindra = false,
        PlayerCombat = false,
        info = true,
        control = false,
        };
    local spells = {
        shild_mana = GetSpellInfo(57960),
        shild_mo = GetSpellInfo(49281),
        char_rass = GetSpellInfo(316432),
        hex = GetSpellInfo(51514),
        eb_ras = GetSpellInfo(51514),
        totems = GetSpellInfo(66842),
        lava = GetSpellInfo(60043),
        fast = GetSpellInfo(16166),
        dar = GetSpellInfo(316368),
        shok_fire = GetSpellInfo(49233),
        shok_led = GetSpellInfo(49236),
        shok_zemlya = GetSpellInfo(49231),
        molnia = GetSpellInfo(49238),
        molnia_2 = GetSpellInfo(49271),
        kick = GetSpellInfo(57994),
        fire_or = GetSpellInfo(58790),
        grom = GetSpellInfo(59159),
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
        "pause",
        "save",
        "buff",
        "auto-target",
        "kick",
        "kick_1",
        "totems",
        "cd",
        "shok_fire_obnova",
        "lava",
        "shok_fire",
        "molnia_2",
        "molnia",
        "shok_fire_2",
        "shok_led_2",
        "shok_zemlya_2",
    };
    local abilities = {
        -----------------------------------
        ["info"] = function()
            if cache.info == true
            and not ni.vars.coin then
                cache.info = false
                print("|cFFFF0000  =========================|r\
|cFFFFFFFFЭлементаль Шаман|r\
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
    ["save"] = function()
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
    end,
    -----------------------------------
    ["buff"] = function()
        if enables["buff"] then
            local hasMainHandEnchant, mainHandExpiration, mainHandCharges, mainHandEnchantID, hasOffHandEnchant, offHandExpiration, offHandCharges, offHandEnchantID = GetWeaponEnchantInfo()
            if hasMainHandEnchant ~= 1 then
                ni.spell.cast(spells.fire_or)
            end
        end
        if enables["shild_m"]
        and ni.power.current("player") <= values.shild_m
        and ni.spell.available(spells.shild_mana)
        and not ni.player.buff(spells.shild_mana) then
            ni.spell.cast(spells.shild_mana)
        end
        if enables["grom"]
        and ni.power.current("player") <= values.grom
        and ni.spell.available(spells.grom) then
            ni.spell.cast(spells.grom)
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
        ["kick_1"] = function()
            for i = 1, #ni.members do
                local ally = ni.members[i].unit;
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
        ["totems"] = function()
            if enables["totems"]
            and cache.PlayerCombat then
                local haveTotem, totemName = GetTotemInfo(3)
                if totemName ~= "Тотем прилива маны" then
                    local haveTotem1, totemName1, startTime1, duration1 = GetTotemInfo(4)
                    local haveTotem, totemName, startTime, duration = GetTotemInfo(1)
                    if duration == 0
                    and duration1 == 0 then
                        ni.spell.cast(spells.totems)
                    end
                    local haveTotem, totemName, startTime, duration = GetTotemInfo(1)
                    if duration == 0 then
                        ni.spell.cast(57722)
                    end
                    local haveTotem, totemName, startTime, duration = GetTotemInfo(4)
                    if duration == 0 then
                        ni.spell.cast("Тотем гнева воздуха")
                    end
                end
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
            if ni.spell.available(316295)
            and ni.player.buff("Элементаль бури") then
                ni.spell.cast(316295)
            end
                if ni.spell.available(316421)
            and ni.power.current("player") < 80 then
                ni.spell.cast(316421)
            end
                if ni.spell.available(316422)
                and ni.player.buff("Элементаль бури") then
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
                and ni.player.slotcd(10) == 0 then
                    ni.player.useinventoryitem(10)
                end
                if ni.player.slotcastable(13)
                and ni.player.slotcd(13) == 0
                and ni.player.buff("Элементаль бури") then
                    ni.player.useinventoryitem(13)
                end
                if ni.player.slotcastable(14)
                and ni.player.slotcd(14) == 0
                and ni.player.buff("Элементаль бури") then
                    ni.player.useinventoryitem(14)
                end
                if ni.spell.available(319326)
            and ni.player.buff("Элементаль бури") then
                ni.spell.cast(319326)
            end
            if ni.spell.available(316396)
            and ni.spell.valid("target", 316396, false, true, true) then
                ni.spell.cast(316396)
            end
            end
        end,
        --------------------------
        ["shok_fire_obnova"] = function()
            if not cache.control
            and cache.PlayerCombat
            and ni.unit.debuffremaining("target", spells.shok_fire, "player") < 2
            or not ni.unit.debuff("target", spells.shok_fire) then
                if ni.spell.available(spells.shok_fire)
                and ni.player.buff("Элементаль бури")
                and ni.spell.valid("target", spells.shok_fire, false, true, true) then
                    ni.spell.cast(spells.shok_fire)
                end
            end
        end,
        --------------------------
        ["lava"] = function()
            if cache.PlayerCombat
            and not cache.stopcast
            and not cache.control
            and not cache.IsMoving then
                if not ni.player.buff("Элементаль бури") then
                    if ni.spell.available(spells.fast)
                    and ni.spell.available(spells.lava)
                    and not ni.player.buff(32182)
                and not ni.player.buff(2825)
                and not ni.player.buff(10060) then
                        ni.spell.cast(spells.fast)
                    end
                    if ni.spell.available(spells.dar)
                    and ni.unit.buffstacks("player", 320461) < 2
                    and ni.spell.available(spells.lava) then
                        ni.spell.cast(spells.dar)
                    end
                    if ni.spell.available(spells.lava)
                    and ni.spell.valid("target", spells.lava, false, true, true) then
                        ni.spell.cast(spells.lava)
                    end
                end
                if ni.unit.buffremaining("player", "Элементаль бури") > 6
                and ni.spell.available(spells.lava)
                and ni.spell.valid("target", spells.lava, false, true, true) then
                    ni.spell.cast(spells.lava)
                end
            end
        end,
        --------------------------
        ["shok_fire"] = function()
            if cache.PlayerCombat
            and not cache.control
            and not ni.unit.debuff("target", spells.shok_fire, "player") then
                if ni.spell.available(spells.shok_fire)
                and ni.spell.valid("target", spells.shok_fire, false, true, true) then
                    ni.spell.cast(spells.shok_fire)
                end
            end
        end,
        --------------------------
        ["molnia_2"] = function()
            if cache.PlayerCombat
            and not cache.control
            and not cache.stopcast
            and not cache.IsMoving
            and ni.spell.available(spells.molnia_2)
            and ni.player.buff("Элементаль бури")
            and ni.spell.valid("target", spells.molnia_2, false, true, true) then
                ni.spell.cast(spells.molnia_2)
            end
        end,
        --------------------------
        ["molnia"] = function()
            local enemies = ni.unit.enemiesinrange("target", 10)
            if #enemies >= 1 then
                if cache.PlayerCombat
            and not cache.stopcast
            and not cache.control
            and not cache.IsMoving
            and ni.spell.available(spells.molnia_2)
            and ni.spell.valid("target", spells.molnia_2, false, true, true) then
                ni.spell.cast(spells.molnia_2)
            end
            elseif cache.PlayerCombat
            and not cache.stopcast
            and not cache.control
            and not cache.IsMoving
            and ni.spell.available(spells.molnia)
            and ni.spell.valid("target", spells.molnia, false, true, true) then
                if ni.player.buff("Элементаль бури") then
                    if ni.spell.cd(spells.shok_led) > 1
                    and ni.spell.cd(spells.shok_zemlya) > 1 then
                        ni.spell.cast(spells.molnia)
                    end
                else ni.spell.cast(spells.molnia)
                end 
            end
        end,
        --------------------------
        ["shok_fire_2"] = function()
            if cache.PlayerCombat
            and not cache.control
            and ni.spell.available(spells.shok_fire)
            and ni.spell.valid("target", spells.shok_fire, false, true, true) then
                ni.spell.cast(spells.shok_fire)
            end
        end,
        --------------------------
        ["shok_led_2"] = function()
            if cache.PlayerCombat
            and not cache.control
            and ni.spell.available(spells.shok_led)
            and ni.spell.valid("target", spells.shok_led, false, true, true) then
                ni.spell.cast(spells.shok_led)
            end
        end,
        --------------------------
        ["shok_zemlya_2"] = function()
            if cache.PlayerCombat
            and not cache.control
            and ni.spell.available(spells.shok_zemlya)
            and ni.spell.valid("target", spells.shok_zemlya, false, true, true) then
                ni.spell.cast(spells.shok_zemlya)
            end
        end,
        --------------------------
    };
    ni.bootstrap.profile("elem_by_makaren_wrath", queue, abilities, OnLoad, OnUnLoad);
else
    local enables = {
        ["totems"] = true,
        ["target"] = true,
        ["kamen"] = true,
        ["buff"] = true,
        ["kick"] = false,
        ["kick_2"] = false,
        ["grom"] = true,
    ["shild_m"] = false,
    ["kick_3"] = false,
    ["debug"] = false,
    }
    local values = {
        osvob = 4,
        shild_m = 70,
    grom = 60,
    kamen = 30,
    }
    local inputs = {
        kiick = "",
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
        settingsfile = "elem_by_makaren_wrath.json",
        callback = GUICallback,
        { type = "title", text = "Elem_Shaman by |c0000CED1Makaren|r" },
        { type = "separator" },
        { type = "title", text = "|cffFF7C0AProfile version 2.0.0|r" },
	{ type = "separator" },
    { type = "page", number = 1, text = "|cffFFFF00Общие настройки|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(69762).." Освобожденная магия", tooltip ="Количество набираемых стаков Освобожденной магии |cFF00FFFFЦлк(Синдрагоса)|r", value = 4, min = 1, max = 10, step = 1, key = "osvob" },    
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(6603).." Авто таргет", tooltip ="Автоматически выбирает таргет при его отсутствии", enabled = true, key = "target" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(58790).." Авто баф оружия", tooltip ="Автоматически бафает оружие", enabled = true, key = "buff" },
    { type = "entry", text = ni.spell.icon(66842).." Авто призыв тотемов", tooltip ="Автоматически призывает тотемы если их нет", enabled = true, key = "totems" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(11729).." Камень здоровья", tooltip ="Использует Огурец при |cFF00FF00Hp <|r\
Работает в связке с функцией TTD(Time To Die)", enabled = true, value = 30, min = 1, max = 100, step = 1, key = "kamen" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(24803).." Дебаг в чат", enabled = false, key = "debug" },
    { type = "page", number = 2, text = "|cffFFFF00Доп настройки|r" },
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
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(57960).." Водный щит", tooltip ="Использует Водный щит при его отсутствии, если мана меньше", enabled = false, value = 70, min = 1, max = 100, step = 1, key = "shild_m" },
    { type = "entry", text = ni.spell.icon(59159).." Гром и молния", tooltip ="Использует Гром и молния, если мана меньше", enabled = true, value = 60, min = 1, max = 100, step = 1, key = "grom" },
};
    local function OnLoad()
        ni.GUI.AddFrame("elem_by_makaren_wrath", items);
    end;
    local function OnUnLoad()  
        ni.GUI.DestroyFrame("elem_by_makaren_wrath");
    end;
    local cache = {
        IsMoving = false,
        stopcast = false,
        sindra = false,
        PlayerCombat = false,
        info = true,
        control = false,
        };
    local spells = {
        shild_mana = GetSpellInfo(57960),
        shild_mo = GetSpellInfo(49281),
        char_rass = GetSpellInfo(316432),
        hex = GetSpellInfo(51514),
        eb_ras = GetSpellInfo(51514),
        totems = GetSpellInfo(66842),
        lava = GetSpellInfo(60043),
        fast = GetSpellInfo(16166),
        dar = GetSpellInfo(316368),
        shok_fire = GetSpellInfo(49233),
        shok_led = GetSpellInfo(49236),
        shok_zemlya = GetSpellInfo(49231),
        molnia = GetSpellInfo(49238),
        molnia_2 = GetSpellInfo(49271),
        kick = GetSpellInfo(57994),
        fire_or = GetSpellInfo(58790),
        };
    local ddebuffs ={
        sindra = GetSpellInfo(69766),
        mk_ledy = GetSpellInfo(71289),
        curse_ledy = GetSpellInfo(71237),
        curse_grul_hm = GetSpellInfo(305230),
        morouz_kara_hm = GetSpellInfo(305470),
        magik_hm = GetSpellInfo(305131),
        sindra_metka = GetSpellInfo(70126),
        grom = GetSpellInfo(59159),
        }
    local queue = {
        "info",
        "cache",
        "stop",
        "pause",
        "save",
        "buff",
        "auto-target",
        "kick",
        "kick_1",
        "totems",
        "cd",
        "shok_fire",
        "lava",
        "molnia",
        "shok_fire_2",
        "shok_led_2",
        "shok_zemlya_2",
    };
    local abilities = {
        -----------------------------------
        ["info"] = function()
            if cache.info == true
            and not ni.vars.coin then
                cache.info = false
                print("|cFFFF0000  =========================|r\
|cFFFFFFFFЭлементаль Шаман|r\
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
    ["save"] = function()
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
    end,
    -----------------------------------
    ["buff"] = function()
        if enables["buff"] then
            local hasMainHandEnchant, mainHandExpiration, mainHandCharges, mainHandEnchantID, hasOffHandEnchant, offHandExpiration, offHandCharges, offHandEnchantID = GetWeaponEnchantInfo()
            if hasMainHandEnchant ~= 1 then
                ni.spell.cast(spells.fire_or)
            end
        end
        if enables["shild_m"]
        and ni.power.current("player") <= values.shild_m
        and ni.spell.available(spells.shild_mana)
        and not ni.player.buff(spells.shild_mana) then
            ni.spell.cast(spells.shild_mana)
        end
        if enables["grom"]
        and ni.power.current("player") <= values.grom
        and ni.spell.available(spells.grom) then
            ni.spell.cast(spells.grom)
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
        ["kick_1"] = function()
            for i = 1, #ni.members do
                local ally = ni.members[i].unit;
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
        ["totems"] = function()
            if enables["totems"]
            and cache.PlayerCombat then
                local haveTotem, totemName = GetTotemInfo(3)
                if totemName ~= "Тотем прилива маны" then
                    local haveTotem1, totemName1, startTime1, duration1 = GetTotemInfo(4)
                    local haveTotem, totemName, startTime, duration = GetTotemInfo(1)
                    if duration == 0
                    and duration1 == 0 then
                        ni.spell.cast(spells.totems)
                    end
                    local haveTotem, totemName, startTime, duration = GetTotemInfo(1)
                    if duration == 0 then
                        ni.spell.cast(57722)
                    end
                    local haveTotem, totemName, startTime, duration = GetTotemInfo(4)
                    if duration == 0 then
                        ni.spell.cast("Тотем гнева воздуха")
                    end
                end
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
            if ni.spell.available(316295) then
                ni.spell.cast(316295)
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
                if ni.player.slotcastable(10) then
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
                if ni.spell.available(316396)
            and ni.spell.valid("target", 316396, false, true, true) then
                ni.spell.cast(316396)
            end
            end
        end,
        --------------------------
        ["shok_fire"] = function()
            if cache.PlayerCombat
            and not ni.unit.debuff("target", spells.shok_fire, "player") then
                if ni.spell.available(spells.shok_fire)
                and ni.spell.valid("target", spells.shok_fire, false, true, true) then
                    ni.spell.cast(spells.shok_fire)
                end
            end
        end,
        --------------------------
        ["lava"] = function()
            if cache.PlayerCombat
            and not cache.control
            and not cache.stopcast
            and not cache.IsMoving then
                    if ni.spell.available(spells.fast)
                    and ni.spell.available(spells.lava)
                    and not ni.player.buff(32182)
                and not ni.player.buff(2825)
                and not ni.player.buff(10060) then
                        ni.spell.cast(spells.fast)
                    end
                    if ni.spell.available(spells.dar)
                    and ni.unit.buffstacks("player", 320461) < 2
                    and ni.spell.available(spells.lava) then
                        ni.spell.cast(spells.dar)
                    end
                    if ni.spell.available(spells.lava)
                    and ni.spell.valid("target", spells.lava, false, true, true) then
                        ni.spell.cast(spells.lava)
                    end
                end
        end,
        --------------------------
        ["molnia"] = function()
            local enemies = ni.unit.enemiesinrange("target", 10)
            if #enemies >= 1 then
                if cache.PlayerCombat
            and not cache.stopcast
            and not cache.control
            and not cache.IsMoving
            and ni.spell.available(spells.molnia_2)
            and ni.spell.valid("target", spells.molnia_2, false, true, true) then
                ni.spell.cast(spells.molnia_2)
            end
            elseif cache.PlayerCombat
            and not cache.stopcast
            and not cache.control
            and not cache.IsMoving
            and ni.spell.available(spells.molnia)
            and ni.spell.valid("target", spells.molnia, false, true, true) then
                if ni.player.buff("Элементаль бури") then
                    if ni.spell.cd(spells.shok_led) > 1
                    and ni.spell.cd(spells.shok_zemlya) > 1 then
                        ni.spell.cast(spells.molnia)
                    end
                else ni.spell.cast(spells.molnia)
                end 
            end
        end,
        --------------------------
        ["shok_fire_2"] = function()
            if cache.PlayerCombat
            and not cache.control
            and ni.spell.available(spells.shok_fire)
            and ni.spell.valid("target", spells.shok_fire, false, true, true) then
                ni.spell.cast(spells.shok_fire)
            end
        end,
        --------------------------
        ["shok_led_2"] = function()
            if cache.PlayerCombat
            and not cache.control
            and ni.spell.available(spells.shok_led)
            and ni.spell.valid("target", spells.shok_led, false, true, true) then
                ni.spell.cast(spells.shok_led)
            end
        end,
        --------------------------
        ["shok_zemlya_2"] = function()
            if cache.PlayerCombat
            and not cache.control
            and ni.spell.available(spells.shok_zemlya)
            and ni.spell.valid("target", spells.shok_zemlya, false, true, true) then
                ni.spell.cast(spells.shok_zemlya)
            end
        end,
        --------------------------
    };
		ni.bootstrap.profile("elem_by_makaren_wrath", queue, abilities, OnLoad, OnUnLoad);
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
    ni.bootstrap.profile("elem_by_makaren_wrath", queue, abilities);
end;