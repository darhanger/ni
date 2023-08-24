local Sirus = GetItemInfo(100455) ~= nil or false;
if Sirus then
local t4 = 0
if ni.player.hasitemequipped(29071) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(29072) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(29073) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(29074) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(29075) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100455) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100456) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100457) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100458) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100459) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101355) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101356) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101357) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101358) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101359) then
    t4 = t4 + 1
end
if t4 > 3 then
local enables = {
    ["target"] = true,
    ["kamen"] = true,
    ["decurse"] = false,
    ["stan"] = true,
    ["ruki"] = false,
    ["decurse_2"] = false,
    ["debug"] = false,
}
local values = {
    ruki = 30,
    kamen = 30,
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
    settingsfile = "rpal_4T4_by_makaren.json",
    callback = GUICallback,
    { type = "title", text = "Rpal_4T4 by |c0000CED1Makaren|r" },
	{ type = "separator" },
	{ type = "title", text = "|cffFF7C0AProfile beta-version 2.0.0|r" },
	{ type = "separator" },
    { type = "page", number = 1, text = "|cffFFFF00Общие настройки|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(6603).." Авто таргет", tooltip ="Автоматически выбирает таргет при его отсутствии", enabled = true, key = "target" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(10308).." Стан в мк", tooltip ="Автоматически дает стан в мк", enabled = true, key = "stan" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(11729).." Камень здоровья", tooltip ="Использует Огурец при |cFF00FF00Hp <|r\
Работает в связке с функцией TTD(Time To Die)", enabled = true, value = 30, min = 1, max = 100, step = 1, key = "kamen" },
{ type = "entry", text = ni.spell.icon(48788).." Возложение рук", tooltip = "Использует Возложение рук если  |cFF00FF00Hp члена группы/рейда <|r\
Работает в связке с функцией TTD(Time To Die)", enabled = true, value = 30, min = 1, max = 100, step = 1, key = "ruki" },
{ type = "separator" },
    { type = "entry", text = ni.spell.icon(24803).." Дебаг в чат", enabled = false, key = "debug" },
    { type = "page", number = 2, text = "|cffFFFF00Диспел|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(4987).." Диспел", tooltip ="Диспелит все что может", enabled = true, key = "decurse" },
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
};
local function OnLoad()
	ni.GUI.AddFrame("rpal_4T4_by_makaren", items);
end;
local function OnUnLoad()  
	ni.GUI.DestroyFrame("rpal_4T4_by_makaren");
end;
local cache = {
    sindra = false,
    PlayerCombat = false,
    control = false,
    };
local spells = {
    krilya = GetSpellInfo(31884),
    pechat_solo = GetSpellInfo(53736),
    pechat_aoe = GetSpellInfo(20375),
    hotsh = GetSpellInfo(10308),
    dispell = GetSpellInfo(4987),
    ruki = GetSpellInfo(48788),
    djaga = GetSpellInfo(53408),
    luza = GetSpellInfo(48819),
    ekz = GetSpellInfo(48801),
    bog_bur = GetSpellInfo(53385),
    uvs = GetSpellInfo(35395),
    molot = GetSpellInfo(48806),
    };
local queue = {
    "info",
    "cache",
    "pause",
    "auto-target",
    "buff",
    "cd",
    "save",
    "dispell",
    "djaga",
    "luza",
    "ekz",
    "molotok",
    "bog_bur",
    "uvs",
};
local abilities = {
    -----------------------------------
    ["info"] = function()
        if cache.info == true
        and not ni.vars.coin then
            cache.info = false
            print("|cFFFF0000  =========================|r\
|cFFFFFFFFРетри Паладин|r\
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
        cache.sindra = ni.unit.debuffstacks("player", "Пронизывающая стужа") <= 7;
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
    ["buff"] = function()
        if not ni.vars.combat.aoe
        and not ni.unit.buff("player", spells.pechat_solo) then
            ni.spell.cast(spells.pechat_solo)
        elseif ni.vars.combat.aoe
        and not ni.unit.buff("player", spells.pechat_aoe) then
            ni.spell.cast(spells.pechat_aoe)
        end
    end,
    --------------------------
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
            if ni.spell.available(spells.krilya) then
                if ni.unit.isboss("target") 
                or ni.vars.combat.cd then
                    ni.spell.cast(spells.krilya)
                end
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
    ["save"] = function()
        if enables["ruki"]
        and cache.PlayerCombat then
            for i = 1, #ni.members do
                local ally = ni.members[i].unit;
                if ni.spell.available(spells.ruki)
                and ni.unit.hp(ally) <= values.ruki
                and ni.unit.ttd(ally) < 1
                and ni.spell.valid(ally, spells.ruki, false, true, true) then
                    ni.spell.cast(spells.ruki, ally)
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
                    and ni.spell.available(spells.dispell)
                    and ni.spell.valid(ally, spells.dispell, false, true, true) then
                        ni.spell.cast(spells.dispell, ally)
                    end
                elseif ni.healing.candispel(ally) then
                    if ni.spell.valid(ally, spells.dispell, false, true, true)
                    and not ni.unit.debuff(ally, inputs.decurseee)
                    and ni.spell.available(spells.dispell) then
                        ni.spell.cast(spells.dispell, ally)
                    end
                end
            end 
            if enables["stan"] 
            and ni.spell.available(spells.hotsh)
            and ni.spell.valid(ally, spells.hotsh, false, true, true) then
                ni.spell.cast(spells.hotsh, ally)
            end
        end
    end,
    -----------------------------------
    ["djaga"] = function()
        if cache.PlayerCombat
        and not cache.control
        and ni.spell.available(spells.djaga)
        and ni.spell.valid("target", spells.djaga, false, true, true) then
            ni.spell.cast(spells.djaga)
        end
    end,
    -----------------------------------
    ["luza"] = function()
        if cache.PlayerCombat
        and not cache.control
        and ni.spell.available(spells.luza)
        and ni.unit.distance("player", "target") < 10 then
            ni.spell.cast(spells.luza)
        end
    end,
    -----------------------------------
    ["ekz"] = function()
        if cache.PlayerCombat
        and not cache.control
        and ni.spell.available(spells.ekz)
        and ni.player.buff(53488)
        and ni.spell.valid("target", spells.ekz, false, true, true) then
            ni.spell.cast(spells.ekz)
        end
    end,
    -----------------------------------
    ["molotok"] = function()
        if cache.PlayerCombat
        and ni.spell.available(spells.molot) then
            local enemies = ni.unit.enemiesinrange("player", 30)
            for i = 1, #enemies do
                local target = enemies[i].guid
                if ni.unit.hp(target) <= 20
                and not ni.unit.debuff(target, "Сглаз") 
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
                and not ni.unit.debuff(target, "Ментальный крик") 
                and ni.spell.valid(target, spells.molot, false, true, true) then
                    ni.spell.cast(spells.molot, target)
                end
            end
        end
    end,
    -----------------------------------
    ["bog_bur"] = function()
        if cache.PlayerCombat
        and not cache.control
        and ni.spell.available(spells.bog_bur)
        and ni.unit.distance("player", "target") < 8 then
            ni.spell.cast(spells.bog_bur)
        end
    end,
    -----------------------------------
    ["uvs"] = function()
        if cache.PlayerCombat
        and not cache.control
        and ni.spell.available(spells.uvs)
        and ni.spell.valid("target", spells.uvs, false, true, true) then
            ni.spell.cast(spells.uvs)
        end
    end,
    --------------------------
};
    ni.bootstrap.profile("rpal_by_makaren_wrath", queue, abilities, OnLoad, OnUnLoad);
elseif t4 > 1 then
    local enables = {
        ["target"] = true,
        ["kamen"] = true,
        ["decurse"] = false,
        ["stan"] = true,
        ["ruki"] = false,
        ["decurse_2"] = false,
        ["debug"] = false,
    }
    local values = {
        ruki = 30,
    kamen = 30,
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
        settingsfile = "rpal_2T4_by_makaren.json",
        callback = GUICallback,
        { type = "title", text = "Rpal_2T4 by |c0000CED1Makaren|r" },
        { type = "separator" },
        { type = "title", text = "|cffFF7C0AProfile beta-version 2.0.0|r" },
        { type = "separator" },
        { type = "page", number = 1, text = "|cffFFFF00Общие настройки|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(6603).." Авто таргет", tooltip ="Автоматически выбирает таргет при его отсутствии", enabled = true, key = "target" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(10308).." Стан в мк", tooltip ="Автоматически дает стан в мк", enabled = true, key = "stan" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(11729).." Камень здоровья", tooltip ="Использует Огурец при |cFF00FF00Hp <|r\
Работает в связке с функцией TTD(Time To Die)", enabled = true, value = 30, min = 1, max = 100, step = 1, key = "kamen" },
{ type = "entry", text = ni.spell.icon(48788).." Возложение рук", tooltip = "Использует Возложение рук если  |cFF00FF00Hp члена группы/рейда <|r\
Работает в связке с функцией TTD(Time To Die)", enabled = true, value = 30, min = 1, max = 100, step = 1, key = "ruki" },
{ type = "separator" },
    { type = "entry", text = ni.spell.icon(24803).." Дебаг в чат", enabled = false, key = "debug" },
    { type = "page", number = 2, text = "|cffFFFF00Диспел|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(4987).." Диспел", tooltip ="Диспелит все что может", enabled = true, key = "decurse" },
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
};
    local function OnLoad()
        ni.GUI.AddFrame("rpal_2T4_by_makaren", items);
    end;
    local function OnUnLoad()  
        ni.GUI.DestroyFrame("rpal_2T4_by_makaren");
    end;
    local cache = {
        sindra = false,
        PlayerCombat = false,
        control = false,
        };
    local spells = {
        krilya = GetSpellInfo(31884),
        pechat_solo = GetSpellInfo(53736),
        pechat_aoe = GetSpellInfo(20375),
        hotsh = GetSpellInfo(10308),
        dispell = GetSpellInfo(4987),
        ruki = GetSpellInfo(48788),
        djaga = GetSpellInfo(53408),
        luza = GetSpellInfo(48819),
        ekz = GetSpellInfo(48801),
        bog_bur = GetSpellInfo(53385),
        uvs = GetSpellInfo(35395),
        molot = GetSpellInfo(48806),
        };
    local queue = {
        "info",
        "cache",
        "pause",
        "auto-target",
        "buff",
        "cd",
        "save",
        "dispell",
        "djaga",
        "luza",
        "ekz",
        "molotok",
        "bog_bur",
        "uvs",
    };
    local abilities = {
        -----------------------------------
        ["info"] = function()
            if cache.info == true
            and not ni.vars.coin then
                cache.info = false
                print("|cFFFF0000  =========================|r\
|cFFFFFFFFРетри Паладин|r\
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
            cache.sindra = ni.unit.debuffstacks("player", "Пронизывающая стужа") <= 7;
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
        ["buff"] = function()
            if not ni.vars.combat.aoe
            and not ni.unit.buff("player", spells.pechat_solo) then
                ni.spell.cast(spells.pechat_solo)
            elseif ni.vars.combat.aoe
            and not ni.unit.buff("player", spells.pechat_aoe) then
                ni.spell.cast(spells.pechat_aoe)
            end
        end,
        --------------------------
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
                if ni.spell.available(316421)
            and ni.power.current("player") < 80 then
                ni.spell.cast(316421)
            end
            if ni.spell.available(319326) then
                ni.spell.cast(319326)
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
                if ni.spell.available(spells.krilya) then
                    if ni.unit.isboss("target") 
                    or ni.vars.combat.cd then
                        ni.spell.cast(spells.krilya)
                    end
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
        ["save"] = function()
            if enables["ruki"]
            and cache.PlayerCombat then
                for i = 1, #ni.members do
                    local ally = ni.members[i].unit;
                    if ni.spell.available(spells.ruki)
                    and ni.unit.hp(ally) <= values.ruki
                    and ni.unit.ttd(ally) < 1
                    and ni.spell.valid(ally, spells.ruki, false, true, true) then
                        ni.spell.cast(spells.ruki, ally)
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
                        and ni.spell.available(spells.dispell)
                        and ni.spell.valid(ally, spells.dispell, false, true, true) then
                            ni.spell.cast(spells.dispell, ally)
                        end
                    elseif ni.healing.candispel(ally) then
                        if ni.spell.valid(ally, spells.dispell, false, true, true)
                        and not ni.unit.debuff(ally, inputs.decurseee)
                        and ni.spell.available(spells.dispell) then
                            ni.spell.cast(spells.dispell, ally)
                        end
                    end
                end 
                if enables["stan"] 
                and ni.spell.available(spells.hotsh)
                and ni.spell.valid(ally, spells.hotsh, false, true, true) then
                    ni.spell.cast(spells.hotsh, ally)
                end
            end
        end,
        -----------------------------------
        ["djaga"] = function()
            if cache.PlayerCombat
            and not cache.control
            and ni.spell.available(spells.djaga)
            and ni.spell.valid("target", spells.djaga, false, true, true) then
                ni.spell.cast(spells.djaga)
            end
        end,
        -----------------------------------
        ["luza"] = function()
            if cache.PlayerCombat
            and not cache.control
            and ni.spell.available(spells.luza)
            and ni.unit.distance("player", "target") < 10 then
                ni.spell.cast(spells.luza)
            end
        end,
        -----------------------------------
        ["ekz"] = function()
            if cache.PlayerCombat
            and not cache.control
            and ni.spell.available(spells.ekz)
            and ni.player.buff(53488)
            and ni.spell.valid("target", spells.ekz, false, true, true) then
                ni.spell.cast(spells.ekz)
            end
        end,
        -----------------------------------
    ["molotok"] = function()
        if cache.PlayerCombat
        and ni.spell.available(spells.molot) then
            local enemies = ni.unit.enemiesinrange("player", 30)
            for i = 1, #enemies do
                local target = enemies[i].guid
                if ni.unit.hp(target) <= 20
                and not ni.unit.debuff(target, "Сглаз") 
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
                and not ni.unit.debuff(target, "Ментальный крик") 
                and ni.spell.valid(target, spells.molot, false, true, true) then
                    ni.spell.cast(spells.molot, target)
                end
            end
        end
    end,
        -----------------------------------
        ["bog_bur"] = function()
            if cache.PlayerCombat
            and not cache.control
            and ni.spell.available(spells.bog_bur)
            and ni.unit.distance("player", "target") < 8 then
                ni.spell.cast(spells.bog_bur)
            end
        end,
        -----------------------------------
        ["uvs"] = function()
            if cache.PlayerCombat
            and not cache.control
            and ni.spell.available(spells.uvs)
            and ni.spell.valid("target", spells.uvs, false, true, true) then
                ni.spell.cast(spells.uvs)
            end
        end,
        --------------------------
    };
        ni.bootstrap.profile("rpal_by_makaren_wrath", queue, abilities, OnLoad, OnUnLoad);
else
    local enables = {
        ["target"] = true,
        ["kamen"] = true,
        ["decurse"] = false,
        ["stan"] = true,
        ["ruki"] = false,
        ["decurse_2"] = false,
        ["debug"] = false,
    }
    local values = {
        ruki = 30,
    kamen = 30,
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
        settingsfile = "rpal_by_makaren_wrath.json",
        callback = GUICallback,
        { type = "title", text = "Rpal by |c0000CED1Makaren|r" },
        { type = "separator" },
        { type = "title", text = "|cffFF7C0AProfile beta-version 2.0.0|r" },
        { type = "separator" },
        { type = "page", number = 1, text = "|cffFFFF00Общие настройки|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(6603).." Авто таргет", tooltip ="Автоматически выбирает таргет при его отсутствии", enabled = true, key = "target" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(10308).." Стан в мк", tooltip ="Автоматически дает стан в мк", enabled = true, key = "stan" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(11729).." Камень здоровья", tooltip ="Использует Огурец при |cFF00FF00Hp <|r\
Работает в связке с функцией TTD(Time To Die)", enabled = true, value = 30, min = 1, max = 100, step = 1, key = "kamen" },
{ type = "entry", text = ni.spell.icon(48788).." Возложение рук", tooltip = "Использует Возложение рук если  |cFF00FF00Hp члена группы/рейда <|r\
Работает в связке с функцией TTD(Time To Die)", enabled = true, value = 30, min = 1, max = 100, step = 1, key = "ruki" },
{ type = "separator" },
    { type = "entry", text = ni.spell.icon(24803).." Дебаг в чат", enabled = false, key = "debug" },
    { type = "page", number = 2, text = "|cffFFFF00Диспел|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(4987).." Диспел", tooltip ="Диспелит все что может", enabled = true, key = "decurse" },
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
};
    local function OnLoad()
        ni.GUI.AddFrame("rpal_by_makaren_wrath", items);
    end;
    local function OnUnLoad()  
        ni.GUI.DestroyFrame("rpal_by_makaren_wrath");
    end;
    local cache = {
        sindra = false,
        PlayerCombat = false,
        control = false,
        };
    local spells = {
        krilya = GetSpellInfo(31884),
        pechat_solo = GetSpellInfo(53736),
        pechat_aoe = GetSpellInfo(20375),
        hotsh = GetSpellInfo(10308),
        dispell = GetSpellInfo(4987),
        ruki = GetSpellInfo(48788),
        djaga = GetSpellInfo(53408),
        luza = GetSpellInfo(48819),
        ekz = GetSpellInfo(48801),
        bog_bur = GetSpellInfo(53385),
        uvs = GetSpellInfo(35395),
        molot = GetSpellInfo(48806),
        };
    local queue = {
        "info",
        "cache",
        "pause",
        "auto-target",
        "buff",
        "cd",
        "save",
        "dispell",
        "djaga",
        "bog_bur",
        "molotok",
        "uvs",
        "luza",
        "ekz",
    };
    local abilities = {
        -----------------------------------
        ["info"] = function()
            if cache.info == true
            and not ni.vars.coin then
                cache.info = false
                print("|cFFFF0000  =========================|r\
|cFFFFFFFFРетри Паладин|r\
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
            cache.sindra = ni.unit.debuffstacks("player", "Пронизывающая стужа") <= 7;
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
        ["buff"] = function()
            if not ni.vars.combat.aoe
            and not ni.unit.buff("player", spells.pechat_solo) then
                ni.spell.cast(spells.pechat_solo)
            elseif ni.vars.combat.aoe
            and not ni.unit.buff("player", spells.pechat_aoe) then
                ni.spell.cast(spells.pechat_aoe)
            end
        end,
        --------------------------
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
                if ni.spell.available(spells.krilya) then
                    if ni.unit.isboss("target") 
                    or ni.vars.combat.cd then
                        ni.spell.cast(spells.krilya)
                    end
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
        ["save"] = function()
            if enables["ruki"]
            and cache.PlayerCombat then
                for i = 1, #ni.members do
                    local ally = ni.members[i].unit;
                    if ni.spell.available(spells.ruki)
                    and ni.unit.hp(ally) <= values.ruki
                    and ni.unit.ttd(ally) < 1
                    and ni.spell.valid(ally, spells.ruki, false, true, true) then
                        ni.spell.cast(spells.ruki, ally)
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
                        and ni.spell.available(spells.dispell)
                        and ni.spell.valid(ally, spells.dispell, false, true, true) then
                            ni.spell.cast(spells.dispell, ally)
                        end
                    elseif ni.healing.candispel(ally) then
                        if ni.spell.valid(ally, spells.dispell, false, true, true)
                        and not ni.unit.debuff(ally, inputs.decurseee)
                        and ni.spell.available(spells.dispell) then
                            ni.spell.cast(spells.dispell, ally)
                        end
                    end
                end 
                if enables["stan"] 
                and ni.spell.available(spells.hotsh)
                and ni.spell.valid(ally, spells.hotsh, false, true, true) then
                    ni.spell.cast(spells.hotsh, ally)
                end
            end
        end,
        -----------------------------------
        ["djaga"] = function()
            if cache.PlayerCombat
            and not cache.control
            and ni.spell.available(spells.djaga)
            and ni.spell.valid("target", spells.djaga, false, true, true) then
                ni.spell.cast(spells.djaga)
            end
        end,
        -----------------------------------
        ["bog_bur"] = function()
            if cache.PlayerCombat
            and not cache.control
            and ni.spell.available(spells.bog_bur)
            and ni.unit.distance("player", "target") < 8 then
                ni.spell.cast(spells.bog_bur)
            end
        end,
        -----------------------------------
    ["molotok"] = function()
        if cache.PlayerCombat
        and ni.spell.available(spells.molot) then
            local enemies = ni.unit.enemiesinrange("player", 30)
            for i = 1, #enemies do
                local target = enemies[i].guid
                if ni.unit.hp(target) <= 20
                and not ni.unit.debuff(target, "Сглаз") 
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
                and not ni.unit.debuff(target, "Ментальный крик") 
                and ni.spell.valid(target, spells.molot, false, true, true) then
                    ni.spell.cast(spells.molot, target)
                end
            end
        end
    end,
        -----------------------------------
        ["uvs"] = function()
            if cache.PlayerCombat
            and not cache.control
            and ni.spell.available(spells.uvs)
            and ni.spell.valid("target", spells.uvs, false, true, true) then
                ni.spell.cast(spells.uvs)
            end
        end,
        -----------------------------------
        ["luza"] = function()
            if cache.PlayerCombat
            and not cache.control
            and ni.spell.available(spells.luza)
            and ni.unit.distance("player", "target") < 10 then
                ni.spell.cast(spells.luza)
            end
        end,
        -----------------------------------
        ["ekz"] = function()
            if cache.PlayerCombat
            and not cache.control
            and ni.spell.available(spells.ekz)
            and ni.player.buff(53488)
            and ni.spell.valid("target", spells.ekz, false, true, true) then
                ni.spell.cast(spells.ekz)
            end
        end,
        
        
        --------------------------
    };
        ni.bootstrap.profile("rpal_by_makaren_wrath", queue, abilities, OnLoad, OnUnLoad);
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
    ni.bootstrap.profile("rpal_by_makaren_wrath", queue, abilities);
end;