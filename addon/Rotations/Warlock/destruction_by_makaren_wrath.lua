local Sirus = GetItemInfo(100455) ~= nil or false;

if Sirus then

local t4 = 0
if ni.player.hasitemequipped(28963) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(28967) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(28964) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(28968) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(28966) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100400) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100403) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100401) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100404) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100402) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101300) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101303) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101301) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101304) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101302) then
    t4 = t4 + 1
end
local enables = {
    ["target"] = true,
    ["kamen"] = true,
    ["dospeh"] = true,
    ["pet"] = true,
    ["zizn"] = true,
    ["stih"] = true,
    ["shild_f"] = false,
    ["debug"] = false,
}
local values = {
    osvob = 4,
    zizn = 33,
    kamen = 30,
}
local inputs = {
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
    settingsfile = "destruction_by_makaren_wrath.json",
    callback = GUICallback,
    { type = "title", text = "Destruction by |c0000CED1Makaren|r" },
	{ type = "separator" },
	{ type = "title", text = "|cffFF7C0AProfile version 1.0.0|r" },
	{ type = "separator" },
    { type = "page", number = 1, text = "|cffFFFF00Общие настройки|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(69762).." Освобожденная магия", tooltip ="Количество набираемых стаков Освобожденной магии |cFF00FFFFЦлк(Синдрагоса)|r", value = 4, min = 1, max = 10, step = 1, key = "osvob" },    
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(6603).." Авто таргет", tooltip ="Автоматически выбирает таргет при его отсутствии", enabled = true, key = "target" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(688).." Авто призыв Беса", tooltip ="Автоматически призывает Беса при его отсутствии", enabled = true, key = "pet" },
    { type = "entry", text = ni.spell.icon(47893).." Авто Доспех скверны", tooltip ="Автоматически использует Доспех скверны при его отсутствии", enabled = true, key = "dospeh" },
    { type = "entry", text = ni.spell.icon(47983).." Авто Огненный щит", tooltip ="Автоматически использует Огненный щит при его отсутствии", enabled = false, key = "shild_f" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(11729).." Камень здоровья", tooltip ="Использует Огурец при |cFF00FF00Hp <|r\
Работает в связке с функцией TTD(Time To Die)", enabled = true, value = 30, min = 1, max = 100, step = 1, key = "kamen" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(24803).." Дебаг в чат", enabled = false, key = "debug" },
    { type = "page", number = 2, text = "|cffFFFF00Доп настройки|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(47865).." Авто Проклятие стихий", tooltip ="Автоматически использует Проклятие стихий при его отсутствии", enabled = true, key = "stih" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(57946).." Авто Жизнеотвод", tooltip ="Автоматически использует Жизнеотвод, если мана меньше", enabled = true, value = 33, min = 1, max = 90, step = 1, key = "zizn" },
};
local function OnLoad()
	ni.GUI.AddFrame("destruction_by_makaren_wrath", items);
end;
local function OnUnLoad()  
	ni.GUI.DestroyFrame("destruction_by_makaren_wrath");
end;
local cache = {
    IsMoving = false,
    stopcast = false,
    sindra = false,
    PlayerCombat = false,
    info = true,
    move = true,
    pet = true,
    control = false,
    };
local spells = {
    kamen = GetSpellInfo(60220),
    dospeh = GetSpellInfo(47893),
    ogur = GetSpellInfo(47878),
    pet = GetSpellInfo(688),
    strela = GetSpellInfo(59172),
    pogjog = GetSpellInfo(17962),
    porcha = GetSpellInfo(47813),
    isp = GetSpellInfo(47838),
    zizn = GetSpellInfo(57946),
    stih = GetSpellInfo(47865),
    rok = GetSpellInfo(47867),
    ogon = GetSpellInfo(47811)

    
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
    "cd",
    "mana",
    "stih",
    "strela",
    "pogjog",
    "ogon",
    "isp",
    "porcha",
    
    
};
local abilities = {
    -----------------------------------
    ["info"] = function()
        if cache.info == true
        and not ni.vars.coin then
            cache.info = false
            print("|cFFFF0000  =========================|r\
|cFFFFFFFFЛок Разрушение|r\
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
        if cache.IsMoving then
            cache.move = true
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
        count = GetItemCount("Осколок души")
        if enables["kamen"]
        and not cache.PlayerCombat
        and count > 0
        and ni.spell.available(spells.ogur) then
            if ni.player.hasitem(36892)
            or ni.player.hasitem(36893)
            or ni.player.hasitem(36894) then
            else
                ni.spell.cast(spells.ogur)
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
    end,
    -----------------------------------
    ["buff"] = function()
        count = GetItemCount("Осколок души")
        local hasMainHandEnchant, mainHandExpiration, mainHandCharges, mainHandEnchantID, hasOffHandEnchant, offHandExpiration, offHandCharges, offHandEnchantID = GetWeaponEnchantInfo()
        if hasMainHandEnchant ~= 1 then
            if not ni.player.hasitem(41174)
            and count > 0
            and ni.spell.available(spells.kamen) then
                ni.spell.cast(spells.kamen)
            end
            if hasMainHandEnchant ~= 1
            and ni.spell.lastcast(41174, 1.5) then
                ni.player.useitem(41174)
                ni.player.runtext("/use 16")
            end
        end
        if enables["dospeh"]
        and ni.spell.available(spells.dospeh)
        and not ni.player.buff(spells.dospeh) then
            ni.spell.cast(spells.dospeh)
        end
        if enables["pet"]
        and ni.unit.creator("playerpet") == nil
        and ni.spell.available(spells.pet) then
            ni.spell.cast(spells.pet)
        end
	if enables["shild_f"]
    and ni.unit.creator("playerpet") ~= nil
	and not ni.player.buff(47983) then
	    ni.player.runtext("/cast [target=player] Огненный щит")
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
                    ni.player.runtext("/petattack")
                    cache.pet = false
                end
            elseif cache.control then
                ni.player.runtext("/petfollow")
            elseif cache.pet == true then
                ni.player.runtext("/petattack")
                cache.pet = false
            end
        end
    end,
    --------------------------
    ["cd"] = function()
        if t4 > 1 then
            if cache.sindra
            and cache.PlayerCombat
            and not cache.stopcast then
                count = GetItemCount("Фрагмент души")
                if ni.spell.available(316466)
                and count > 1
                and not ni.unit.buff("player", 316466) then
                    ni.spell.cast(316466)
                end
                if ni.player.buff(304785) then
                if ni.spell.available(319326) then
                    ni.spell.cast(319326)
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
                if ni.spell.available(316162) then
                    ni.spell.cast(316162)
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
                if ni.spell.available(316396)
            and ni.spell.valid("target", 316396, false, true, true) then
                ni.spell.cast(316396)
            end
            end
        end
        else
            if cache.sindra
            and cache.PlayerCombat
            and not cache.stopcast then
                count = GetItemCount("Фрагмент души")
                if ni.spell.available(316466)
                and count > 1
                and not ni.unit.buff("player", 316466) then
                    ni.spell.cast(316466)
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
                if ni.spell.available(316447) then
                    ni.spell.cast("target", 316467)
                end
                if ni.unit.buff("player", 316440)
                and cache.PlayerCombat
                and ni.player.hasitem(50085) then
                    ni.player.useitem(50085)
                end
                if ni.player.slotcd(13) == 0 then
                    ni.player.useinventoryitem(13)
                end
                if ni.player.slotcd(14) == 0 then
                    ni.player.useinventoryitem(14)
                end
                if ni.spell.available(316396)
            and ni.spell.valid("target", 316396, false, true, true) then
                ni.spell.cast(316396)
            end
            end
        end
        
    end,
    --------------------------
    ["mana"] = function()
        if enables["zizn"]
        and cache.sindra
        and cache.PlayerCombat
        and ni.spell.available(spells.zizn)
        and ni.power.current("player") <= values.zizn then
            ni.spell.cast(spells.zizn)
            cache.pet = true
        end
    end,
    --------------------------
    ["stih"] = function()
        if enables["stih"] then
            if cache.sindra
            and cache.PlayerCombat
            and not cache.IsMoving
            and not cache.control
            and not cache.stopcast
            and not ni.unit.debuff("target", spells.stih)
            and ni.spell.available(spells.stih)
            and ni.spell.valid("target", spells.stih, false, true, true) then
                ni.spell.cast(spells.stih)
                cache.pet = true
            end
        elseif cache.sindra
        and cache.PlayerCombat
        and not cache.control
        and cache.IsMoving
        and not ni.unit.debuff("target", spells.rok, "player")
        and ni.spell.available(spells.rok)
        and ni.spell.valid("target", spells.rok, false, true, true) then
            ni.spell.cast(spells.rok)
            cache.pet = true
        end
    end,
    --------------------------
    ["strela"] = function()
        if cache.sindra
        and cache.PlayerCombat
        and not cache.control
        and not cache.IsMoving
        and not cache.stopcast
        and ni.spell.available(spells.strela)
        and ni.spell.valid("target", spells.strela, false, true, true) then
            ni.spell.cast(spells.strela)
            cache.pet = true
        end
    end,
    --------------------------
    ["pogjog"] = function()
        if cache.sindra
        and cache.PlayerCombat
        and not cache.control
        and ni.spell.available(spells.pogjog)
        and ni.spell.valid("target", spells.pogjog, false, true, true) then
            ni.spell.cast(spells.pogjog)
            cache.pet = true
        end
    end,
    --------------------------
    ["ogon"] = function()
        if cache.sindra
        and cache.PlayerCombat
        and not cache.IsMoving
        and not cache.control
        and not cache.stopcast
        and not ni.player.buff(54277)
        and not ni.player.buff(304785)
        and not ni.unit.debuff("target", spells.ogon, "player")
        and ni.spell.available(spells.ogon)
        and ni.spell.valid("target", spells.ogon, false, true, true) then
            ni.spell.cast(spells.ogon)
            cache.pet = true
        end
    end,
    --------------------------
    ["isp"] = function()
        if cache.sindra
        and cache.PlayerCombat
        and not cache.IsMoving
        and not cache.control
        and not cache.stopcast
        and ni.player.buff(54277)
        and ni.spell.available(spells.isp)
        and ni.spell.valid("target", spells.isp, false, true, true) then
            ni.spell.cast(spells.isp)
            cache.pet = true
        end
    end,
    --------------------------
    ["porcha"] = function()
        if cache.sindra
        and cache.PlayerCombat
        and cache.IsMoving
        and not cache.control
        and ni.spell.available(spells.porcha)
        and not ni.unit.debuff("target", spells.porcha, "player")
        and ni.spell.valid("target", spells.porcha, false, true, true) then
            ni.spell.cast(spells.porcha)
            cache.pet = true
        end
    end,
    --------------------------
};
	ni.bootstrap.profile("destruction_by_makaren_wrath", queue, abilities, OnLoad, OnUnLoad);
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
    ni.bootstrap.profile("destruction_by_makaren_wrath", queue, abilities);
end;