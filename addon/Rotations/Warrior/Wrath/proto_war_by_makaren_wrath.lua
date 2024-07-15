local Sirus = GetItemInfo(100455) ~= nil or false;

if Sirus then

local enables = {
    ["krik"] = false,
    ["target"] = true,
    ["grom"] = false,
    ["taunt"] = true,
    ["save"] = true,
    ["reflect"] = true,
    ["kamen"] = true,
    ["debug"] = false,
}
local values = {
    kamen = 30,
}
local inputs = {
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
    settingsfile = "proto_war_by_makaren_wrath.json",
    callback = GUICallback,
    { type = "title", text = "Proto_Warrior by |c0000CED1Makaren|r" },
	{ type = "separator" },
	{ type = "title", text = "|cffFF7C0AProfile version 2.0.0|r" },
	{ type = "separator" },
    { type = "title", text = "|cffFFFF00Общие настройки|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(6603).." Авто таргет", tooltip ="Автоматически выбирает таргет при его отсутствии", enabled = true, key = "target" },
    { type = "separator" },
    { type = "title", text = "Авто крик" },
    { type = "dropdown", menu = { 
		{ selected = true, value = 1, text = "|cFFFF5A00Крик на АП" },
		{ selected = false, value = 2, text = "|cFF00FFFFКрик на ХП" },
        { selected = false, value = 3, text = "|cFFFF0000Ничего" },
	}, key = "ActionEvent" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(47437).." Деморализующий крик", tooltip ="Использует Деморализующий крик", enabled = false, key = "krik" },
    { type = "entry", text = ni.spell.icon(47502).." Удар грома", tooltip ="Использует Удар грома", enabled = false, key = "grom" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(355).." Авто таунт", tooltip ="Автоматически таунтит мобов с рейда", enabled = true, key = "taunt" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(12975).." Авто сейвы", tooltip ="Автоматически использует |cFFFF0000СОЛО|r сейвы", enabled = true, key = "save" },
    { type = "entry", text = ni.spell.icon(23920).." Авто рефлект", tooltip ="Автоматически использует рефлект", enabled = true, key = "reflect" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(11729).." Камень здоровья", tooltip ="Использует Огурец при |cFF00FF00Hp <|r\
Работает в связке с функцией TTD(Time To Die)", enabled = true, value = 30, min = 1, max = 100, step = 1, key = "kamen" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(24803).." Дебаг в чат", enabled = false, key = "debug" },
};
local function OnLoad()
	ni.GUI.AddFrame("proto_war_by_makaren_wrath", items);
end;
local function OnUnLoad()  
	ni.GUI.DestroyFrame("proto_war_by_makaren_wrath");
end;
local cache = {
    PlayerCombat = false,
    aoe = false,
    info = true,
    control = false,
    };
local spells = {
    block = GetSpellInfo(2565),
    udar_shildom = GetSpellInfo(47488),
    revansh = GetSpellInfo(57823),
    sokrush = GetSpellInfo(47498),
    volna = GetSpellInfo(46968),
    krik = GetSpellInfo(47437),
    grom = GetSpellInfo(47502),
    hs = GetSpellInfo(47450),
    rassek = GetSpellInfo(47520),
    taunt = GetSpellInfo(355),
    shag = GetSpellInfo(12975),
    vostanovlenie = GetSpellInfo(55694),
    reflect = GetSpellInfo(23920),
    krov = GetSpellInfo(2687),
    };
local ddebuffs ={
    sindra = GetSpellInfo(69766),
    sindra_metka = GetSpellInfo(70126),
    }
local queue = {
    "info",
    "cache",
    "pause",
    "taunt",
    "auto-target",
    "krik_",
    "cd",
    "ctoika",
    "reflect",
    "aoe-solo",
    "block",
    "grom_aoe",
    "udar_shildom",
    "krik",
    "grom",
    "revansh",
    "sokrush",
    "volna",
    "sokrush_2",
};
local abilities = {
    -----------------------------------
    ["info"] = function()
        if cache.info == true
        and not ni.vars.coin then
            cache.info = false
            print("|cFFFF0000  =========================|r\
|cFFFFFFFFПрото Вар|r\
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
        local enemies = ni.unit.enemiesinrange("player", 8)
        if #enemies > 1 then
            cache.aoe = true
        end
        if #enemies < 2 then
            cache.aoe = false
        end
        for i = 1, #enemies do
            local target = enemies[i].guid
            if ni.unit.debuff(target, "Сглаз") 
            or ni.unit.debuff(target, "Устрашающий крик") 
            or ni.unit.debuff(target, "Гнев деревьев") 
            or ni.unit.debuff(target, "Смерч") 
            or ni.unit.debuff(target, "Превращение") 
            or ni.unit.debuff(target, "Замораживающая ловушка") 
            or ni.unit.debuff(target, "Покаяние") 
            or ni.unit.debuff(target, "Ослепление") 
            or ni.unit.debuff(target, "Ошеломление") 
            or ni.unit.debuff(target, "Вой ужаса") 
            or ni.unit.debuff(target, "Изгнание") 
            or ni.unit.debuff(target, "Страх") 
            or ni.unit.debuff(target, "Спячка") 
            or ni.unit.debuff(target, "Отпугивание зверя") 
            or ni.unit.debuff(target, "Ментальный крик") then
                cache.aoe = false
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
		or ni.player.islooting()
        or not cache.sindra then
			return true;
		end
    end,
    -----------------------------------
    ["taunt"] = function()
        if enables["taunt"]
        and cache.PlayerCombat then
            for i = 1, #ni.members do
                local ally = ni.members[i].unit;
                if ni.members[i].istank then
                    local tank = ni.objectmanager.objectGUID(ally)
                    local enemies = ni.unit.enemiesinrange("player", 30)
                    local pl = ni.objectmanager.objectGUID("player")
                    for i = 1, #enemies do
                        local target = enemies[i].guid
                        local x, y, z, facing, unittype, targett, height = ni.unit.info(target)
                        if targett ~= pl
                        and targett ~= tank then
                            local tar = ni.objects[target];
                            if tar:exists() and tar:los() then
                                tar:cast(spells.taunt);
                            end
                        end
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
    ["krik_"] = function()
        if enables["krik"] then
	   if not ni.player.buff(47440)
	    and ni.spell.available(47440) then
		ni.spell.cast(47440)
	    end 
	elseif not ni.player.buff(47436)
	    and ni.spell.available(47436) then
		if not ni.player.buff("Благословение могущества")
		and not ni.player.buff("Великое благословение могущества") then
		    ni.spell.cast(47436)
		end
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
            if ni.spell.available(316419)
            and ni.power.currentraw("player") < 40 then
                ni.spell.cast(316419)
            end
            if ni.spell.available(316422)
            and ni.unit.hp("player") < 50 then
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
            if ni.spell.available(spells.krov) then
                ni.spell.cast(spells.krov)
            end
            if enables["save"] then
                if ni.player.slotcd(13) == 0
                and ni.player.slotcastable(13)
                and ni.unit.hp("player") < 40
                and ni.unit.ttd("player") < 3 then
                    ni.player.useinventoryitem(13)
                end
                if ni.player.slotcd(14) == 0
                and ni.player.slotcastable(14)
                and ni.unit.hp("player") < 40
                and ni.unit.ttd("player") < 3 then
                    ni.player.useinventoryitem(14)
                end
                if ni.unit.hp("player") < 30
                and ni.unit.ttd("player") < 3
                and ni.spell.available(spells.shag) then
                    ni.spell.cast(spells.shag)
                end
                if ni.unit.hp("player") < 30
                and ni.spell.available(spells.vostanovlenie) then
                    ni.spell.cast(spells.vostanovlenie)
                end
                if ni.spell.available(316162) then
                    ni.spell.cast(316162)
                end
                if ni.spell.available(319326) then
                    ni.spell.cast(319326)
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
        end
    end,
    -----------------------------------
    ["ctoika"] = function()
        if not ni.unit.aura("player", 71) then
            ni.spell.cast(71)
        end
    end,
    -----------------------------------
    ["reflect"] = function()
        if enables["reflect"] then
            local enemies = ni.unit.enemiesinrange("player", 30)
            local pl = ni.objectmanager.objectGUID("player")
            for i = 1, #enemies do
                local target = enemies[i].guid
                local x, y, z, facing, unittype, targett, height = ni.unit.info(target)
                if targett == pl
                and ni.unit.iscasting(target)
                and ni.spell.available(spells.reflect) then
                    ni.spell.cast(spells.reflect)
                end
            end
        end
    end,
    -----------------------------------
    ["aoe-solo"] = function()
        if cache.aoe == true
        and cache.PlayerCombat
        and ni.spell.available(spells.rassek) then
            ni.spell.cast(spells.rassek)
        end
        if cache.aoe == false
        and not cache.control
        and ni.spell.available(spells.hs) then
            ni.spell.cast(spells.hs)
        end
    end,
    -----------------------------------
    ["block"] = function()
        if cache.PlayerCombat
        and ni.spell.available(spells.block) then
            ni.spell.cast(spells.block)
        end
    end,
    -----------------------------------
    ["grom_aoe"] = function()
        if cache.aoe == true
        and cache.PlayerCombat
        and not cache.control
        and ni.spell.available(spells.grom)
        and not ni.unit.debuff("target", spells.grom) then
            ni.spell.cast(spells.grom)
        end
    end,
    -----------------------------------
    ["udar_shildom"] = function()
        if cache.PlayerCombat
        and not cache.control
        and ni.spell.available(spells.udar_shildom) then
            ni.spell.cast(spells.udar_shildom)
        end
    end,
    -----------------------------------
    ["krik"] = function()
        if menus.ActionEvent == 2 then
	        if not ni.player.buff(47440)
	        and ni.spell.available(47440) then
		        ni.spell.cast(47440)
	        end 
	    elseif menus.ActionEvent == 1
        and not ni.player.buff(47436)
	    and ni.spell.available(47436) then
		    if not ni.player.buff("Благословение могущества")
		    and not ni.player.buff("Великое благословение могущества") then
		        ni.spell.cast(47436)
		    end
	    end
    end,
    -----------------------------------
    ["grom"] = function()
        if enables["grom"]
        and not cache.control
        and cache.PlayerCombat
        and ni.spell.available(spells.grom)
        and not ni.unit.debuff("target", spells.grom) then
            ni.spell.cast(spells.grom)
        end
    end,
    -----------------------------------
    ["revansh"] = function()
        if cache.PlayerCombat
        and not cache.control
        and ni.spell.available(spells.revansh) then
            ni.spell.cast(spells.revansh)
        end
    end,
    -----------------------------------
    ["sokrush"] = function()
        if cache.PlayerCombat
        and cache.aoe == false
        and not cache.control
        and ni.spell.available(spells.sokrush) then
            ni.spell.cast(spells.sokrush)
        end
    end,
    -----------------------------------
    ["volna"] = function()
        if cache.PlayerCombat
        and not cache.control
        and ni.spell.available(spells.volna) then
            ni.spell.cast(spells.volna)
        end
    end,
    -----------------------------------
    ["sokrush_2"] = function()
        if cache.PlayerCombat
        and not cache.control
        and ni.spell.available(spells.sokrush) then
            ni.spell.cast(spells.sokrush)
        end
    end,
};
	ni.bootstrap.profile("proto_war_by_makaren_wrath", queue, abilities, OnLoad, OnUnLoad);
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
    ni.bootstrap.profile("proto_war_by_makaren_wrath", queue, abilities);
end;