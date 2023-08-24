local Sirus = GetItemInfo(100455) ~= nil or false;

if Sirus then

local t4 = 0
if ni.player.hasitemequipped(29044) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(29047) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(29045) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(29048) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(29046) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100430) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100433) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100431) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100434) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100432) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101330) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101333) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101331) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101334) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101332) then
    t4 = t4 + 1
end
local enables = {
    ["target"] = true,
    ["kamen"] = true,
    ["ik"] = true,
    ["lana"] = true,
    ["napul"] = false,
    ["napul_2"] = false,
    ["kick"] = false,
    ["kick_2"] = false,
    ["yad"] = true,
    ["aoe"] = true,
    ["inviz"] = true,
    ["kick_3"] = false,
    ["debug"] = false,
}
local values = {
    aoe = 3,
    kamen = 30,
}
local inputs = {
    pool = "Name",
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
    settingsfile = "subtlety_by_makaren_wrath.json",
    callback = GUICallback,
    { type = "title", text = "Subtlety by |c0000CED1Makaren|r" },
	{ type = "separator" },
	{ type = "title", text = "|cffFF7C0AProfile version 2.0.0|r" },
	{ type = "separator" },
    { type = "page", number = 1, text = "|cffFFFF00Общие настройки|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(6603).." Авто таргет", tooltip ="Автоматически выбирает таргет при его отсутствии", enabled = true, key = "target" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(1784).." Авто незаметность", tooltip ="Автоматически использует незаметность", enabled = true, key = "inviz" },
    { type = "entry", text = ni.spell.icon(38615).." Авто яд", tooltip ="Автоматически использует яд при его отсутствии", enabled = true, key = "yad" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(11729).." Камень здоровья", tooltip ="Использует Огурец при |cFF00FF00Hp <|r\
Работает в связке с функцией TTD(Time To Die)", enabled = true, value = 30, min = 1, max = 100, step = 1, key = "kamen" },
{ type = "separator" },
    { type = "entry", text = ni.spell.icon(24803).." Дебаг в чат", enabled = false, key = "debug" },
    { type = "page", number = 2, text = "|cffFFFF00Доп настройки|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(57934).." Маленькие хитрости", tooltip ="Использует Маленькие хитрости по имени", enabled = false, key = "napul" },
	{
		type = "input",
		value = inputs["pool"],
		width = 140,
		height = 15,
		key = "pool"
	},
    { type = "entry", text = ni.spell.icon(24803).." Отмена бафа", tooltip ="Отменяет баф на передачу агра", enabled = false, key = "napul_2" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(1766).." Автокик", tooltip ="Прерывает все заклинания", enabled = false, key = "kick" },
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
    { type = "entry", text = ni.spell.icon(51723).." Авто-АОЕ", tooltip = "Использует веер при количестве противников равному", enabled = true, value = 3, min = 2, max = 10, step = 1, width = 40, key = "aoe" },
    { type = "page", number = 3, text = "|cffFFFF00Умный кош|r" },
    { type = "entry", text = ni.spell.icon(31224)},
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(300996).." Пламя легиона", tooltip ="|cFF00FFFFИк/Ивк(Джараксус)|r", enabled = true, key = "ik" },
    { type = "entry", text = ni.spell.icon(71264).." Роящиеся тени", tooltip ="|cFF00FFFFЦлк(Лана'тель)|r", enabled = true, key = "lana" },
};
local function OnLoad()
	ni.GUI.AddFrame("subtlety_by_makaren_wrath", items);
end;
local function OnUnLoad()  
	ni.GUI.DestroyFrame("subtlety_by_makaren_wrath");
end;
local cache = {
    PlayerCombat = false,
    aoe = false,
    sindra = true,
    combo = 0,
    uk = true,
    info = true,
    krov = true,
    control = false,
    };
local spells = {
    char_rass = GetSpellInfo(316432),
    skval = GetSpellInfo(13877),
    inviz = GetSpellInfo(1784),
    um = GetSpellInfo(14183),
    shag = GetSpellInfo(36554),
    dance = GetSpellInfo(51713),
    udar = GetSpellInfo(48691),
    myaso = GetSpellInfo(6774),
    krov = GetSpellInfo(48660),
    veer = GetSpellInfo(51723),
    kosh = GetSpellInfo(31224),
    trix = GetSpellInfo(57934),
    kick = GetSpellInfo(1766),
    pochka = GetSpellInfo(8643),
    vanish = GetSpellInfo(26889),
    potrosh = GetSpellInfo(48668),
    podgot = GetSpellInfo(14185),
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
    "kosh",
    "kick",
    "yad",
    "napul",
    "cd",
    "inviz",
    "um_t",
    "myaso_t",
    "shag_t",
    "potrosh_t",
    "um",
    "udar",
    "dance",
    "myaso",
    "pochka",
    "char_rass",
    "potrosh",
    "veer",
    "krov",
};
local abilities = {
    -----------------------------------
    ["info"] = function()
        if cache.info == true
        and not ni.vars.coin then
            cache.info = false
            print("|cFFFF0000  =========================|r\
|cFFFFFFFFМути Рога|r\
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
        cache.combo = GetComboPoints("player", "target");
        local enemies = ni.unit.enemiesinrange("player", 6)
        if enables["aoe"] then
            if #enemies > values.aoe - 1 then
                cache.aoe = true
            end
            if #enemies < values.aoe then
                cache.aoe = false
            end
        else cache.aoe = false
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
        if not cache.PlayerCombat then
            cache.uk = true
            cache.krov = true
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
    ["kosh"] = function()
        if cache.PlayerCombat
            and enables["ik"]
            and ni.player.debuff("Пламя Легиона") then
                if ni.spell.available(spells.kosh) then
                    ni.spell.cast(spells.kosh)
                end
            end
            if cache.PlayerCombat
            and enables["lana"]
            and ni.player.debuff("Роящиеся тени") then
                if ni.spell.available(spells.kosh) then
                    ni.spell.cast(spells.kosh)
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
    ["yad"] = function()
        if enables["yad"] then
            local hasMainHandEnchant, mainHandExpiration, mainHandCharges, mainHandEnchantID, hasOffHandEnchant, offHandExpiration, offHandCharges, offHandEnchantID = GetWeaponEnchantInfo()
            if hasMainHandEnchant ~= 1
            and ni.player.hasitem(43233)
            and ni.spell.lastcast(43233, 2)
            and ni.spell.lastcast(43231, 2) then
                ni.player.useitem(43233)
                ni.player.runtext("/use 16")
            end
            if mainHandEnchantID ~= 1
            and ni.spell.lastcast(43231, 2)
            and ni.spell.lastcast(43233, 2)
            and ni.player.hasitem(43231) then
                ni.player.useitem(43231)
                ni.player.runtext("/use 17")
            end
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
                and ni.spell.available(spells.trix)
                and ni.spell.valid(ally, spells.trix, false, true, true) then
                    ni.spell.cast(ally, spells.trix)
                end
                if enables["napul_2"]
                and ni.player.buff(spells.trix) then
                    ni.player.runtext("/cancelaura Маленькие хитрости")
                end
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
            if ni.spell.available(316295) then
                ni.spell.cast(316295)
            end
            if ni.spell.available(316419)
            and ni.power.currentraw("player") < 40 then
                ni.spell.cast(316419)
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
            if ni.spell.available(spells.skval) then
                ni.spell.cast(spells.skval)
            end
            if not ni.spell.available(spells.char_rass)
            and not ni.player.buff(spells.char_rass)
            and ni.spell.available(spells.adrenaline) then
                ni.spell.cast(spells.adrenaline)
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
            if ni.spell.available(spells.vanish)
            and ni.spell.cd(spells.dance) > 1
            and cache.combo < 2
            and not ni.player.buff(spells.dance)
            and ni.spell.valid("target", spells.udar, false, true, true)
            and ni.spell.available(spells.udar) then
                ni.spell.cast(spells.vanish)
            end
            if ni.spell.cd(spells.vanish) > 60
            and ni.spell.cd(spells.dance) > 2
            and not ni.player.buff(31665)
            and ni.spell.available(spells.podgot) then
                ni.spell.cast(spells.podgot)
            end
        end
    end,
    -----------------------------------
    ["inviz"] = function()
        if enables["inviz"]
        and not cache.PlayerCombat
        and not ni.player.buff(spells.inviz)
        and ni.spell.available(spells.inviz) then
            ni.spell.cast(spells.inviz)
        end
    end,
    -----------------------------------
    ["um_t"] = function()
        if cache.PlayerCombat
        and not cache.control
        and ni.spell.available(spells.dance)
        and ni.spell.available(spells.um) then
            ni.spell.cast(spells.um)
        end
    end,
    -----------------------------------
    ["myaso_t"] = function()
        if cache.PlayerCombat
        and ni.spell.available(spells.dance)
        and ni.unit.buffremaining("player", spells.myaso) < 2
        and ni.spell.available(spells.myaso) then
            ni.spell.cast(spells.myaso)
        end
    end,
    -----------------------------------
    ["shag_t"] = function()
        if cache.PlayerCombat
        and ni.spell.available(spells.dance)
        and ni.spell.available(spells.shag)
        and ni.spell.valid("target", spells.shag, false, true, true) then
            ni.spell.cast(spells.shag)
        end
    end,
    -----------------------------------
    ["potrosh_t"] = function()
        if cache.PlayerCombat
        and not cache.control
        and ni.player.buff(spells.dance)
        and ni.spell.available(spells.potrosh)
        and cache.combo > 2
        and ni.spell.valid("target", spells.potrosh, false, true, true) then
            ni.spell.cast(spells.potrosh)
        end
    end,
    -----------------------------------
    ["um"] = function()
        if cache.PlayerCombat
        and not cache.control
        and ni.spell.available(spells.um)
        and ni.player.buff(spells.dance)
        and cache.combo < 4 then
            ni.spell.cast(spells.um)
        end
    end,
    -----------------------------------
    ["udar"] = function()
        if cache.PlayerCombat
        and not cache.control
        and ni.spell.available(spells.udar)
        and ni.spell.valid("target", spells.udar, false, true, true) then
            ni.spell.cast(spells.udar)
        end
    end,
    -----------------------------------
    ["dance"] = function()
        if cache.PlayerCombat
        and not cache.control
        and ni.spell.available(spells.dance) then
            if cache.krov == true
            and ni.spell.available(spells.krov)
            and ni.spell.valid("target", spells.krov, false, true, true) then
                ni.spell.cast(spells.krov)
                cache.krov = false
            end
            ni.spell.cast(spells.dance)
            cache.krov = true
        end
    end,
    -----------------------------------
    ["myaso"] = function()
        if cache.PlayerCombat
        and cache.combo > 3
        and not ni.player.buff(spells.dance)
        and ni.unit.buffremaining("player", spells.myaso) < 4
        and ni.spell.available(spells.myaso) then
            ni.spell.cast(spells.myaso)
        end
    end,
    -----------------------------------
    ["pochka"] = function()
        if cache.PlayerCombat
        and t4 > 3
        and not cache.control
        and not ni.player.buff(spells.dance)
        and ni.spell.cd(spells.dance) > 0
        and cache.combo == 4
        and ni.spell.valid("target", spells.pochka, false, true, true)
        and ni.spell.available(spells.pochka) then
            ni.spell.cast(spells.pochka)
        end
    end,
    --------------------------
    ["char_rass"] = function()
        if cache.PlayerCombat
        and not cache.control
        and ni.spell.available(spells.char_rass) then
            ni.spell.cast(spells.char_rass)
          end
    end,
    -----------------------------------
    ["potrosh"] = function()
        if cache.PlayerCombat
        and ni.spell.available(spells.potrosh)
        and not cache.control
        and cache.combo > 4
        and ni.spell.valid("target", spells.potrosh, false, true, true) then
            ni.spell.cast(spells.potrosh)
        end
    end,
    -----------------------------------
    ["veer"] = function()
        if cache.PlayerCombat
        and cache.aoe == true
        and ni.spell.available(spells.veer) then
            if t4 > 1 then
                if ni.player.buff(304726) then
                    ni.spell.cast(spells.veer)
                else
                    ni.spell.cast(spells.krov)
                end
            else
                ni.spell.cast(spells.veer)
            end
            
        end
    end,
     -----------------------------------
     ["krov"] = function()
        if cache.PlayerCombat
        and not cache.control
        and cache.combo ~= 5
        and cache.aoe == false
        and not ni.player.buff(spells.dance)
        and ni.spell.available(spells.krov)
        and ni.spell.valid("target", spells.krov, false, true, true) then
            if ni.player.buff(spells.vanish) then
                ni.spell.cast(spells.udar)
            end
            ni.spell.cast(spells.krov)
        end
    end,
    -----------------------------------
};
	ni.bootstrap.profile("subtlety_by_makaren_wrath", queue, abilities, OnLoad, OnUnLoad);
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
    ni.bootstrap.profile("subtlety_by_makaren_wrath", queue, abilities);
end;