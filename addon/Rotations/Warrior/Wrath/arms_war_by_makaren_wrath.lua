local Sirus = GetItemInfo(100455) ~= nil or false;

if Sirus then

local t4 = 0
if ni.player.hasitemequipped(29019) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(29020) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(29021) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(29022) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(29023) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100410) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100411) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100412) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100413) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100414) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101310) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101311) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101312) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101313) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101314) then
    t4 = t4 + 1
end
local enables = {
    ["target"] = true,
    ["kamen"] = true,
    ["shild"] = true,
    ["chardhs"] = true,
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
    settingsfile = "arms_war_4t4_by_makaren.json",
    callback = GUICallback,
    { type = "title", text = "Arms 4T4 by |c0000CED1Makaren|r" },
	{ type = "separator" },
	{ type = "title", text = "|cffFF7C0AProfile beta-version 2.0.0|r" },
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
    { type = "entry", text = ni.spell.icon(11578).." Авто рывок", tooltip ="Автоматически использует рывок", enabled = true, key = "chardhs" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(13047).." Авто снятие шилда", tooltip ="Автоматически снимает шилд если Hp > 70%", enabled = true, key = "shild" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(11729).." Камень здоровья", tooltip ="Использует Огурец при |cFF00FF00Hp <|r\
Работает в связке с функцией TTD(Time To Die)", enabled = true, value = 30, min = 1, max = 100, step = 1, key = "kamen" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(24803).." Дебаг в чат", enabled = false, key = "debug" },
};
local function OnLoad()
	ni.GUI.AddFrame("arms_war_4t4_by_makaren", items);
end;
local function OnUnLoad()  
	ni.GUI.DestroyFrame("arms_war_4t4_by_makaren");
end;
local cache = {
    sindra = false,
    PlayerCombat = false,
    aoe = false,
    aoe_g = false,
    info = true,
    burst = false,
    control = false,
    };
local spells = {
    hs = GetSpellInfo(47450),
    rassek = GetSpellInfo(47520),
    bezrassubstvo = GetSpellInfo(1719),
    yar = GetSpellInfo(18499),
    raskol = GetSpellInfo(7386),
    krov = GetSpellInfo(2687),
    razmah = GetSpellInfo(12328),
    grom = GetSpellInfo(47502),
    vihr = GetSpellInfo(46924),
    krovv = GetSpellInfo(47465),
    smert = GetSpellInfo(47486),
    prev = GetSpellInfo(7384),
    chardsh = GetSpellInfo(11578),
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
    "krik",
    "cd",
    "start",
    "auto-shild",
    "ctoika",
    "aoe-solo",
    "smert",
    "vihr",
    "grom",
    "prev",
    "krovv",
};
local abilities = {
    -----------------------------------
    ["info"] = function()
        if cache.info == true
        and not ni.vars.coin then
            cache.info = false
            print("|cFFFF0000  =========================|r\
|cFFFFFFFFАрмс Вар|r\
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
        local enemies = ni.unit.enemiesinrange("player", 2)
        if #enemies > 1 then
            cache.aoe = true
            if ni.spell.available(spells.razmah) then
                ni.spell.cast(spells.razmah)
            end
        end
        if #enemies < 2 then
            cache.aoe = false
        end
        if #enemies > 3 then
            cache.aoe_g = true
        else
            cache.aoe_g = false
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
                cache.aoe_g = false
            end
        end
        if ni.unit.debuff("target", spells.krovv) then
            cache.burst = true
        end
        if not cache.PlayerCombat then
            cache.burst = false
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
    --------------------------
    ["cd"] = function()
        if cache.sindra
        and cache.burst == true
        and cache.PlayerCombat then
            count = GetItemCount("Фрагмент души")
            if ni.spell.available(316466)
            and not ni.unit.buff("player", 316466) then
                if count > 1 
                or ni.unit.hp("target") < 10 then
                    ni.spell.cast(316466)
                end
            end
            if ni.spell.available(319326) then
                ni.spell.cast(319326)
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
            if ni.spell.available(spells.krov)
            and ni.power.current("player") < 60 then
                ni.spell.cast(spells.krov)
            end
            if ni.player.slotcastable(13)
            and ni.player.slotcd(13) == 0
	    and ni.spell.available(spells.vihr) then
                ni.player.useinventoryitem(13)
            end
            if ni.player.slotcastable(14)
            and ni.player.slotcd(14) == 0
	    and ni.spell.available(spells.vihr) then
                ni.player.useinventoryitem(14)
            end
            if ni.spell.available(316162) then
                ni.spell.cast(316162)
            end
            if ni.spell.available(12292) then
                ni.spell.cast(12292)
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
    ["start"] = function()
        if ni.spell.cd(spells.bezrassubstvo) == 0 then
            if not cache.PlayerCombat
            and not ni.unit.aura("player", 2458) then
                ni.spell.cast(2458)
            end
            if ni.spell.available(spells.bezrassubstvo)
            and cache.PlayerCombat then
                ni.spell.cast(spells.bezrassubstvo)
            end
        end
        if enables["chardhs"]
        and cache.PlayerCombat
        and not cache.control
        and ni.spell.valid("target", spells.chardsh, false, true, true)
        and ni.spell.available(spells.chardsh) then
            ni.spell.cast(spells.chardsh)
        end
    end,
    -----------------------------------
    ["auto-shild"] = function()
        if enables["shild"]
        and ni.unit.hp("player") >= 70 then
            if ni.player.buff("Слово силы: Щит") then
                ni.player.runtext("/cancelaura Слово силы: Щит")
            end
            if ni.player.buff("Божья длань") then
                ni.player.runtext("/cancelaura Божья длань")
            end
            if ni.player.buff("Божественный оберег") then
                ni.player.runtext("/cancelaura Божественный оберег")
            end
        end
    end,
    -----------------------------------
    ["ctoika"] = function()
        if not ni.unit.aura("player", 2457)
        and ni.spell.cd(spells.bezrassubstvo) > 0
        and cache.PlayerCombat then
            ni.spell.cast(2457)
        end
    end,
    -----------------------------------
    ["aoe-solo"] = function()
        if cache.aoe == true
        and ni.power.current("player") >= 75
        and cache.PlayerCombat
        and ni.spell.available(spells.rassek) then
            ni.spell.cast(spells.rassek)
        end
        if cache.aoe == false
        and not cache.control
        and ni.power.current("player") >= 75
        and ni.spell.available(spells.hs) then
            ni.spell.cast(spells.hs)
        end
    end,
    -----------------------------------
    ["smert"] = function()
        if cache.sindra
        and not cache.control
        and cache.PlayerCombat
	and not ni.player.buff(304676)
        and ni.spell.valid("target", spells.smert, false, true, true)
        and ni.spell.available(spells.smert) then
            ni.spell.cast(spells.smert)
        end
    end,
    -----------------------------------
    ["vihr"] = function()
        if cache.sindra
        and not cache.control
        and cache.burst == true
        and cache.PlayerCombat
        and ni.spell.available(spells.vihr) then
            if ni.unit.isboss("target")
            or ni.vars.combat.cd then
                ni.spell.cast(spells.vihr)
            end
        end
    end,
    -----------------------------------
    ["grom"] = function()
        if cache.sindra
        and not cache.control
        and cache.PlayerCombat
        and cache.burst == true
        and cache.aoe_g == true
        and ni.spell.available(spells.grom) then
            ni.spell.cast(spells.grom)
        end
    end,
    -----------------------------------
    ["prev"] = function()
        if cache.sindra
        and not cache.control
        and cache.burst == true
        and cache.PlayerCombat
        and ni.spell.valid("target", spells.prev, false, true, true)
        and ni.spell.available(spells.prev) then
            ni.spell.cast(spells.prev)
        end
    end,
    -----------------------------------
    ["krovv"] = function()
        if cache.sindra
        and not cache.control
        and cache.PlayerCombat
        and not ni.unit.debuff("target", spells.krovv, "player")
        and ni.spell.valid("target", spells.krovv, false, true, true)
        and ni.spell.available(spells.krovv) then
            if ni.spell.cd(spells.smert) > 0.5
            or ni.power.current("player") < 30 then
                if cache.burst == true then
                    if not ni.player.buff(60503)
                    and not ni.player.buff(304676) then
                        ni.spell.cast(spells.krovv)
                    end
                elseif ni.spell.cd(spells.smert) > 0 then
                    ni.spell.cast(spells.krovv)	
                end 
            end
        end
    end,
    -----------------------------------
};
	ni.bootstrap.profile("arms_war_by_makaren_wrath", queue, abilities, OnLoad, OnUnLoad);
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
    ni.bootstrap.profile("arms_war_by_makaren_wrath", queue, abilities);
end;