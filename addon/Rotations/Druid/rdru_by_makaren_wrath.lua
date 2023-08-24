local Sirus = GetItemInfo(100455) ~= nil or false;

if Sirus then

local enables = {
    ["hill_vseh"] = false,
    ["pp_tank"] = true,
    ["ozarenie"] = true,
    ["lifeboom"] = false,
    ["trin1"] = true,
    ["trin2"] = true,
    ["perch"] = true,
    ["ogur"] = true,
    ["trin1m"] = false,
    ["trin2m"] = false,
    ["banka"] = false,
    ["fast_cast"] = true,
    ["decurse"] = false,
    ["decurse_2"] = false,
    ["ik"] = true,
    ["morouz_kara_hm"] = true,
    ["surok"] = true,
    ["sindra_metka"] = true,
    ["lich"] = true,
    ["sindra_obmorozenie"] = false,
    ["fizruk"] = true,
    ["kopito_kara_hm"] = true,
    ["dub_koza"] = true,
    ["smerch"] = true,
    ["hill_pet"] = true,
    ["debug"] = false,
}
local values = {
    osvob = 4,
    pp_tank = 50,
    ozarenie = 60,
    trin1 = 80,
    trin2 = 80,
    trin1m = 80,
    trin2m = 80,
    ogur = 30,
    perch = 80,
    banka = 20,
    lifeboom = 90,
    fast_cast = 30,
    buyniy_rost = 3,
    dub_koza = 40,
}
local inputs = {
    ignor1 = "",
    ignor2 = "",
    ignor3 = "",
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
    settingsfile = "rdru_by_makaren_wrath.json",
    callback = GUICallback,
    { type = "title", text = "Restoration Druid by |c0000CED1Makaren|r" },
	{ type = "separator" },
	{ type = "title", text = "|cffFF7C0AProfile version 2.0.0|r" },
	{ type = "separator" },
    { type = "page", number = 1, text = "|cffFFFF00Общие настройки|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(69762).." Освобожденная магия", tooltip ="Количество набираемых стаков Освобожденной магии |cFF00FFFFЦлк(Синдрагоса)|r", value = 4, min = 1, max = 10, step = 1, key = "osvob" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(24803).." Хилить всех игроков", tooltip = "Хилит так же не состоящих в группе/рейде", enabled = false, key = "hill_vseh" },
    { type = "entry", text = ni.spell.icon(24803).." Хилить петов", tooltip ="Хилит петов, с приоритетом ниже игроков ", enabled = true, key = "hill_pet" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(33786).." Смерч в мк", enabled = true, key = "smerch" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(24803).." Дебаг в чат", enabled = false, key = "debug" },
    { type = "page", number = 2, text = "|cFF00FF00Настройки исцеления|r" },
    { type = "separator" },
    { type = "title", text = "|cffFFFF00Тринькеты и предметы|r" },
    { type = "separator" },
    { type = "title", text = "|cFF00FF00Hp|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(24803).." Тринькет №1", tooltip = "Использует Тринькет №1 при |cFF00FF00Hp рейда <|r", enabled = true, value = 80, min = 1, max = 100, step = 1, key = "trin1" },
    { type = "entry", text = ni.spell.icon(24803).." Тринькет №2", tooltip = "Использует Тринькет №2 при |cFF00FF00Hp рейда <|r", enabled = true, value = 80, min = 1, max = 100, step = 1, key = "trin2" },
    { type = "entry", text = ni.spell.icon(24803).." Перчатки", tooltip = "Использует Перчатки при |cFF00FF00Hp рейда <|r", enabled = true, value = 80, min = 1, max = 100, step = 1, key = "perch" },
    { type = "separator" },
    { type = "title", text = "|cFF00FFFFMp|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(24803).." Тринькет №1", tooltip = "Использует Тринькет №1 при |cFF00FFFFMp <|r", enabled = false, value = 80, min = 1, max = 100, step = 1, key = "trin1m" },
    { type = "entry", text = ni.spell.icon(24803).." Тринькет №2", tooltip = "Использует Тринькет №2 при |cFF00FFFFMp <|r", enabled = false, value = 80, min = 1, max = 100, step = 1, key = "trin2m" },
    { type = "entry", text = ni.spell.icon(24803).." Банка с маной", tooltip = "Использует Банку с маной при |cFF00FFFFMp <|r", enabled = false, value = 20, min = 1, max = 100, step = 1, key = "banka" },
    { type = "page", number = 3, text = "|cFF00FF00Настройки исцеления|r" },
    { type = "separator" },
    { type = "title", text = "|cffFFFF00Способности|r" },
    { type = "separator" },
    { type = "title", text = "|cFF00FFFFMp|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(29166).." Озарение", tooltip = "Использует Озарение при |cFF00FFFFMp <|r", enabled = true, value = 60, min = 1, max = 100, step = 1, key = "ozarenie" },
    { type = "entry", text = ni.spell.icon(48451).." Жизнецвет", tooltip = "Использует Жизнецвет под прок Ясной мысли при |cFF00FFFFMp <|r", enabled = false, value = 90, min = 1, max = 100, step = 1, key = "lifeboom" },
    { type = "separator" },
    { type = "title", text = "|cFF00FF00Hp|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(53251).." Буйный рост", tooltip = "Количество таргетов для использования буйного роста", value = 3, min = 2, max = 6, step = 1, key = "buyniy_rost" },
    { type = "entry", text = ni.spell.icon(50464).." ПП в танка", tooltip = "Использует ПП в танка при |cFF00FF00Hp <|r", enabled = true, value = 50, min = 1, max = 100, step = 1, key = "pp_tank" },
    { type = "entry", text = ni.spell.icon(17116).." Пс + Цп", tooltip = "Использует Пс + Цп если  |cFF00FF00Hp члена группы/рейда <|r\
Работает в связке с функцией TTD(Time To Die)", enabled = true, value = 30, min = 1, max = 100, step = 1, key = "fast_cast" },
    { type = "page", number = 4, text = "|cFF00FF00Настройки исцеления|r" },
    { type = "separator" },
    { type = "title", text = "|cffFFFF00Диспел|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(2782).." Диспел", enabled = false, key = "decurse" },
    { type = "entry", text = "Конкретный дебаф", enabled = false, key = "decurse_2" },
    {
		type = "input",
		value = inputs["decursee"],
		width = 140,
		height = 15,
		key = "decursee"
	},
    { type = "title", text = "Игнорировать дебаф"},
    {
		type = "input",
		value = inputs["decurseee"],
		width = 140,
		height = 15,
		key = "decurseee"
	},
    { type = "page", number = 5, text = "|cFF00FF00Настройки исцеления|r" },
    { type = "separator" },
    { type = "title", text = "|cffFFFF00Прохилл дебафов|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(72293).." Метка падшего воителя", enabled = true, key = "surok" },
    { type = "entry", text = ni.spell.icon(312590).." Гравитационная бомба ", enabled = true, key = "fizruk" },
    { type = "entry", text = ni.spell.icon(70107).." Пронизывающая стужа ", enabled = true, key = "sindra_obmorozenie" },
    { type = "entry", text = ni.spell.icon(67049).." Испепеление плоти       ", enabled = true, key = "ik" },
    { type = "entry", text = ni.spell.icon(70126).." Ледяная метка                 ", enabled = true, key = "sindra_metka" },
    { type = "entry", text = ni.spell.icon(305470).." Метка Смерти                 ", enabled = true, key = "morouz_kara_hm" },	
    { type = "entry", text = ni.spell.icon(305351).." Метка демона                 ", enabled = true, key = "kopito_kara_hm" },
    { type = "entry", text = ni.spell.icon(68980).." Жатва душ                         ", enabled = true, key = "lich" },
    { type = "page", number = 6, text = "|cFF00FF00Настройки исцеления|r" },
    { type = "separator" },
    { type = "title", text = "|cffFFFF00Игнорирование исцеления|r" },
    { type = "separator" },
    {
        type = "input",
        value = inputs["ignor1"],
        width = 140,
        height = 15,
        key = "ignor1"
    },
    {
        type = "input",
        value = inputs["ignor2"],
        width = 140,
        height = 15,
        key = "ignor2"
    },
    {
        type = "input",
        value = inputs["ignor3"],
        width = 140,
        height = 15,
        key = "ignor3"
    },
    { type = "page", number = 7, text = "|cFFFF0000Защитные настройки|r" },
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
    { type = "page", number = 8, text = "|cFFFF0000Защитные настройки|r" },
    { type = "separator" },
    { type = "title", text = "|cffFFFF00Предметы|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(11729).." Огурец", tooltip = "Использует Огурец при |cFF00FF00Hp <|r\
Работает в связке с функцией TTD(Time To Die)", enabled = true, value = 30, min = 1, max = 100, step = 1, key = "ogur" },
    { type = "page", number = 9, text = "|cffFFFF00Настройки боссов|r" },
    { type = "separator" },
    { type = "title", text ="Валитрия",},
    { type = "dropdown", menu = { 
		{ selected = true, value = 1, text = "|cFF00FF00Хилл Рейда + Валитрии" },
		{ selected = false, value = 2, text = "|cFFFF5A00Хилл Рейда" },
        { selected = false, value = 3, text = "|cFFFF0000Хилл Валитрии" },
	}, key = "ActionEvent" },
}

local function OnLoad()
	ni.GUI.AddFrame("rdru_by_makaren_wrath", items);
end;
local function OnUnLoad()  
	ni.GUI.DestroyFrame("rdru_by_makaren_wrath");
end;
local cache = {
    IsMoving = false,
    sindra = false,
    PlayerCombat = false,
    double = true,
    info = true,
    stopcast = false,
    sme = false,
    cou = 0,
    };
local spells = {
omolozenie = GetSpellInfo(48441),
vostanovlenie = GetSpellInfo(48443),
derevo = GetSpellInfo(33891),
buyniy_rost = GetSpellInfo(53251),
pp = GetSpellInfo(50464),
bv = GetSpellInfo(18562),
cat = GetSpellInfo(768),
ozarenie = GetSpellInfo(29166),
char_rass = GetSpellInfo(316432),
decurse = GetSpellInfo(2782),
decurse_po = GetSpellInfo(2893),
smerch = GetSpellInfo(33786),
lifeboom = GetSpellInfo(48451),
life_prok = GetSpellInfo(16870),
dub = GetSpellInfo(22812),
fast_cast = GetSpellInfo(17116),
prikosnovenie = GetSpellInfo(48378),
vo = GetSpellInfo(770),
sova = GetSpellInfo(24858),
mishka = GetSpellInfo(9634),
};
local rass = {
    eredar = GetSpellInfo(316466),
    volshev_potok = GetSpellInfo(316421),
    magiya_krovi = GetSpellInfo(316422),
    boevaia_regen = GetSpellInfo(319326),
    goblin = GetSpellInfo(316396),
    tainaya_runa = GetSpellInfo(316295),
    panda_hill = GetSpellInfo(316447),
    shlak = GetSpellInfo(316162),
    char_rass = GetSpellInfo(316432),
    };
local ddebuffs ={
    sindra = GetSpellInfo(69766),
    morouz_kara_hm = GetSpellInfo(305470),
    magik_hm = GetSpellInfo(305131),
    sindra_metka = GetSpellInfo(70126),
}
local queue = {
    "test",
    "info",
    "cache",
    "stopcast",
    "pause",
    "cd",
    "save",
    "fast_cast",
    "smerch",
    "dispell",
    "lifeboom",
    "ozarenie",
    "derevo",
    "valitria",
    "prof_hots",
    "prohill_metok",
    "buyniy_rost",
    "bv",
    "pp_tank",
    "omolozenie_tank",
    "omolozenie",
    "pp_reid",
    "vostanovlenie_prof",
    "vostanovlenie_tank",
    "pet_hill",
    "obodrenie",
};
local abilities = {
    ------------------------
    ["test"] = function()
        function EnableAddon()
        end
        SlashCmdList["EnableAddon"] = EnableAddon
        SLASH_EnableAddon1 = "/spoof"
    end,
    ------------------------
    ["info"] = function()
        if cache.info == true
        and not ni.vars.coin then
            cache.info = false
            print("|cFFFF0000  =========================|r\
|cFFFFFFFFРестор Друид|r\
|cFFFF5A00Приватный профиль by Makaren|r\
|cFF00FFFFФанпей https://funpay.com/users/7303789/|r\
|cFF00FFFFДс https://discord.com/users/785141640087207966|r\
|cFF00FFFFДс Группы https://discord.gg/eQzcDHbVfm|r\
|cFFFF0000=========================|r")
        end
    end,
    ------------------------
    ["cache"] = function()
        cache.stopcast = ni.unit.debuffremaining("player", ddebuffs.magik_hm) > 2
        or ni.unit.debuff("player", "Поцелуй Госпожи") or false;
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
        cache.PlayerCombat = UnitAffectingCombat("player") or false;
        cache.IsMoving = ni.player.ismoving() or false;
        cache.sindra = ni.unit.debuffstacks("player", ddebuffs.sindra) <= values.osvob;
        local spell, _, _, _, _, endTime = UnitCastingInfo("player")
        if spell == ("Восстановление") then
            cache.double = false
        elseif spell ~= nil then
            cache.double = true
        end
        if cache.cou == 3 then
            cache.sme = false
            cache.cou = 0
        end
        if enables["debug"] then
            ni.vars.debug = true
        else
            ni.vars.debug = false
        end
    end,
    ------------------------
    ["stopcast"] = function()
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
    ------------------------
    ["cd"] = function()
        if cache.PlayerCombat then
            local startTime, duration, enable = GetItemCooldown(42545)
            local startTime_, duration, enable = GetItemCooldown(33448)
            if enables["banka"]
            and ni.power.current("player") <  values.banka
            and startTime == 0
            and startTime_ == 0 then
                if ni.player.hasitem(42545) then
                    ni.player.useitem(42545)
                elseif ni.player.hasitem(33448) then
                    ni.player.useitem(33448)
                end
            end
            if enables["perch"]
            and ni.player.slotcastable(10)
            and ni.members.average() <= values.perch
            and ni.player.slotcd(10) == 0 then
                ni.player.useinventoryitem(10)
            end
            if enables["trin1"]
            and ni.player.slotcastable(13)
            and ni.members.average() <= values.trin1
            and ni.player.slotcd(13) == 0 then
                ni.player.useinventoryitem(13)
            end
            if enables["trin2"]
            and ni.player.slotcastable(14)
            and ni.members.average() <= values.trin2
            and ni.player.slotcd(14) == 0 then
                ni.player.useinventoryitem(14)
            end
            if enables["trin1m"]
            and ni.player.slotcastable(13)
            and ni.power.current("player") <  values.trin1m
            and ni.player.slotcd(13) == 0 then
                ni.player.useinventoryitem(13)
            end
            if enables["trin2m"]
            and ni.player.slotcastable(14)
            and ni.power.current("player") <  values.trin2m
            and ni.player.slotcd(14) == 0 then
                ni.player.useinventoryitem(14)
            end
            count = GetItemCount("Фрагмент души")
            if ni.spell.available(rass.eredar)
            and not ni.unit.buff("player", rass.eredar) then
                if count > 1 
                or ni.unit.hp("target") < 10 then
                    ni.spell.cast(rass.eredar)
                end
            end
            if ni.spell.available(rass.char_rass)then
                ni.spell.cast(rass.char_rass)
            end
            if ni.spell.available(rass.volshev_potok)
            and ni.power.current("player") < 80 then
                ni.spell.cast(rass.volshev_potok)
            end
            if ni.spell.available(rass.magiya_krovi)
            and ni.members.average() <= 90 then
                ni.spell.cast(rass.magiya_krovi)
            end
            if ni.spell.available(rass.boevaia_regen)
            and ni.members.average() <= 90 then
                ni.spell.cast(rass.boevaia_regen)
            end
            if ni.spell.available(rass.goblin)
            and ni.spell.valid("target", rass.goblin, false, true, true) then
                ni.spell.cast(rass.goblin)
            end
            for i = 1, #ni.members.sort() do
                local ally = ni.members[i].unit;
                if ni.members[i]:istank() 
                and ni.spell.available(rass.tainaya_runa)
                and ni.spell.valid(ally, rass.tainaya_runa, false, true, true) then
                    ni.spell.cast(rass.tainaya_runa, ally)
                end
                if ni.spell.available(rass.panda_hill)
                and ni.spell.valid(ally, rass.panda_hill, false, true, true) then
                    ni.spell.cast(rass.panda_hill, ally)
                end
                if ni.spell.available(rass.shlak)
                and ni.spell.valid(ally, rass.shlak, false, true, true)
                and ni.members.average() <= 90 then
                    ni.spell.cast(rass.shlak, ally)
                end
                if ni.unit.buff("player", 316440) -- портвейн 
                and ni.player.hasitem(50085) then
                    ni.player.useitem(50085)
                end
            end
        end
    end,
    -----------------------------------
    ["save"] = function()
        if cache.PlayerCombat then
            if enables["ogur"] then
                local startTime, duration, enable = GetItemCooldown(36892)
                local startTime_, duration, enable = GetItemCooldown(36893)
                local startTime__, duration, enable = GetItemCooldown(36894)
                if startTime == 0
                and startTime_ == 0
                and startTime__ == 0 then
                    if ni.player.hasitem(36892)
                    or ni.player.hasitem(36893)
                    or ni.player.hasitem(36894) then
                        if ni.unit.hp("player") < values.ogur then
                            if ni.unit.ttd("player") < 2 then
                                ni.player.useitem(36892)
                                ni.player.useitem(36893)
                                ni.player.useitem(36894)
                            end
                        end
                    end
                end
            end
            if enables["dub_koza"] then
                if ni.unit.hp("player") < values.dub_koza then
                    if ni.unit.ttd("player") < 2 then
                        if ni.spell.available(spells.dub) then
                            ni.spell.cast(spells.dub)
                        end
                    end
                end
            end
        end
    end,
    -----------------------------------
    ["fast_cast"] = function()
        if enables["fast_cast"]
        and cache.PlayerCombat then
            for i = 1, #ni.members.sort() do
                local ally = ni.members[i].unit;
                if ni.player.buff(spells.fast_cast)
                and ni.spell.available(spells.prikosnovenie)
                and ni.spell.valid(ally, spells.prikosnovenie, false, true, true) then
                    ni.spell.cast(spells.prikosnovenie, ally)
                end
                if ni.spell.available(spells.fast_cast)
                and ni.unit.hp(ally) <= values.fast_cast
                and ni.unit.ttd(ally) < 2
                and ni.spell.valid(ally, spells.prikosnovenie, false, true, true) then
                    ni.spell.cast(spells.fast_cast)
                    ni.spell.cast(spells.prikosnovenie, ally)
                end
            end
        end 
    end,
    -----------------------------------
    ["smerch"] = function()
        if enables["smerch"]
        and cache.PlayerCombat then
            for i = 1, #ni.members do
                local ally = ni.members[i].unit;
                if cache.sme == false then
                    if not cache.IsMoving
                    and ni.unit.debuffremaining(ally, spells.smerch, "player") < 1
                    and ni.spell.available(spells.smerch)
                    and ni.spell.lastcast(spells.smerch, 1.2)
                    and ni.spell.valid(ally, spells.smerch, false, true, true) then
                        cache.sme = ni.members[i].guid
                        if ni.spell.available(spells.fast_cast)
                        and ni.members[i]:ismelee() then
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
                    if ni.spell.available(spells.fast_cast)
                    and ni.members[i]:ismelee() then
                        ni.spell.cast(spells.fast_cast)
                    end
                    ni.spell.cast(spells.smerch, cache.sme)
                    cache.cou = cache.cou + 1
                end
            end
        end 
    end,
    -----------------------------------
    ["dispell"] = function()
        if cache.PlayerCombat then
            for i = 1, #ni.members do
                local ally = ni.members[i].unit;
                if enables["decurse"] then
                    if enables["decurse_2"]
                    and inputs.decursee ~= "" then
                        if ni.healing.candispel(ally)
                        and ni.unit.debuff(ally, inputs.decursee)
                        and ni.spell.available(spells.decurse)
                        and ni.spell.valid(ally, spells.decurse, false, true, true) then
                            ni.spell.cast(spells.decurse, ally)
                            ni.spell.cast(spells.decurse_po, ally)
                        end
                    elseif ni.healing.candispel(ally) then
                        if ni.spell.valid(ally, spells.decurse, false, true, true)
                        and not ni.unit.debuff(ally, inputs.decurseee)
                        and ni.spell.available(spells.decurse) then
                            ni.spell.cast(spells.decurse, ally)
                            ni.spell.cast(spells.decurse_po, ally)
                        end
                    end
                end 
            end
        end
    end,
    -----------------------------------
    ["lifeboom"] = function()
        if enables["lifeboom"]
        and ni.power.current("player") <= values.lifeboom then
            for i = 1, #ni.members.sort() do
                local ally = ni.members[i].unit;
                if ni.unit.buff("player", spells.life_prok)
                and ni.spell.available(spells.lifeboom)
                and ni.spell.valid(ally, spells.lifeboom, false, true, true) then
                    ni.spell.cast(spells.lifeboom, ally)
                end
            end
        end 
    end,
    -----------------------------------
    ["ozarenie"] = function()
        if enables["ozarenie"]
        and cache.PlayerCombat then
            if ni.power.current("player") <= values.ozarenie
            and ni.spell.available(spells.ozarenie) then
                ni.spell.cast(spells.ozarenie, "player")
            end
        end
    end,
    -----------------------------------
    ["derevo"] = function()
        if not ni.player.buff(spells.derevo, "player")
        and ni.spell.available(spells.derevo) then
            ni.spell.cast(spells.derevo)
        end
    end,
    -----------------------------------
    ["valitria"] = function()
        if menus.ActionEvent ~= 2 then
            if ni.objectmanager.contains("Валитрия Сноходица") then
                local valitria = ni.objectmanager.objectGUID("Валитрия Сноходица")     
                if menus.ActionEvent == 3 then
                    if ni.spell.available(spells.bv)
                    and ni.spell.valid(valitria, spells.bv, false, true, true) then
                        if ni.unit.buff(valitria, spells.omolozenie)
                        or ni.unit.buff(valitria, spells.vostanovlenie) then
                            ni.spell.cast(spells.bv, valitria)
                        end
                    elseif not cache.IsMoving
                    and ni.spell.available(spells.vostanovlenie)
                    and not ni.unit.buff(valitria, spells.vostanovlenie, "player")
                    and ni.spell.valid(valitria, spells.vostanovlenie, false, true, true)
                    and cache.double == true then
                        ni.spell.cast(spells.vostanovlenie, valitria)
                    elseif not cache.IsMoving
                    and ni.spell.available(spells.pp)
                    and ni.spell.valid(valitria, spells.pp, false, true, true) then
                        ni.spell.cast(spells.pp, valitria)
                    elseif not ni.unit.buff(valitria, spells.omolozenie, "player")
                    and ni.spell.available(spells.omolozenie)
                    and ni.spell.valid(valitria, spells.omolozenie, false, true, true) then
                        ni.spell.cast(spells.omolozenie, valitria)
                    elseif ni.spell.valid(valitria, spells.lifeboom, false, true, true)
                    and ni.spell.available(spells.lifeboom) then
                        ni.spell.cast(spells.lifeboom, valitria)
                    end
                end
                if menus.ActionEvent == 1
                and ni.members.average() > 99 then
                    if ni.spell.available(spells.bv)
                    and ni.spell.valid(valitria, spells.bv, false, true, true) then
                        if ni.unit.buff(valitria, spells.omolozenie)
                        or ni.unit.buff(valitria, spells.vostanovlenie) then
                            ni.spell.cast(spells.bv, valitria)
                        end
                    elseif not cache.IsMoving
                    and ni.spell.available(spells.vostanovlenie)
                    and not ni.unit.buff(valitria, spells.vostanovlenie, "player")
                    and ni.spell.valid(valitria, spells.vostanovlenie, false, true, true)
                    and cache.double == true then
                        ni.spell.cast(spells.vostanovlenie, valitria)
                    elseif not cache.IsMoving
                    and ni.spell.available(spells.pp)
                    and ni.spell.valid(valitria, spells.pp, false, true, true) then
                        ni.spell.cast(spells.pp, valitria)
                    elseif not ni.unit.buff(valitria, spells.omolozenie, "player")
                    and ni.spell.available(spells.omolozenie)
                    and ni.spell.valid(valitria, spells.omolozenie, false, true, true) then
                        ni.spell.cast(spells.omolozenie, valitria)
                    elseif ni.spell.valid(valitria, spells.lifeboom, false, true, true)
                    and ni.spell.available(spells.lifeboom) then
                        ni.spell.cast(spells.lifeboom, valitria)
                    end
                end
            end
        end
    end,
    -----------------------------------
    ["prof_hots"] = function()
        for i = 1, #ni.members do
            local ally = ni.members[i].unit;
            local creations = ni.unit.creations(ally);
            for i = 1, #creations do
                local pet = creations[i].guid
                local tar = ni.objects[pet];
                if tar.name == "Мутировавшее поганище" then
                    if not ni.unit.buff(pet, spells.omolozenie, "player")
                    and ni.spell.available(spells.omolozenie)
                    and ni.spell.valid(pet, spells.omolozenie, false, true, true) then
                        ni.spell.cast(spells.omolozenie, pet)
                    end
                end
            end
        end
    end,
    -----------------------------------
    ["prohill_metok"] = function()
        for i = 1, #ni.members.sort() do
            local ally = ni.members[i].unit;
            if enables["ik"] then
                if not cache.IsMoving then
                    if ni.members[i]:debuffs("Испепеление плоти") then
                        if ni.spell.valid(ally, spells.pp, false, true, true)
                        and not cache.stopcast
                        and ni.spell.available(spells.pp) then
                            ni.spell.cast(spells.pp, ally) 
                        end
                    end
                end
            end
            if enables["morouz_kara_hm"] then
                if not cache.IsMoving then
                    if ni.members[i]:debuffs(ddebuffs.morouz_kara_hm)
                    and ni.members[i].hp <= 90
                    and ni.spell.available(spells.pp)
                    and ni.spell.valid(ally, spells.pp, false, true, true) then
                        ni.spell.cast(spells.pp, ally)
                    end
                end
            end
            if enables["surok"] then
                if not cache.IsMoving then
                    if ni.members[i]:debuffs("Метка падшего воителя") then
                        if not ni.unit.buff(ally, spells.vostanovlenie, "player")
                        and ni.spell.available(spells.vostanovlenie)
                        and ni.spell.valid(ally, spells.vostanovlenie, false, true, true)
                        and cache.double == true then
                            ni.spell.cast(spells.vostanovlenie, ally)
                        elseif ni.members[i].hp <= 90
                        and ni.spell.available(spells.pp)
                        and ni.spell.valid(ally, spells.pp, false, true, true) then
                            ni.spell.cast(spells.pp, ally)
                        end
                    end
                end
            end
            if enables["sindra_metka"] then
                    if ni.members[i]:debuffs(ddebuffs.sindra_metka)
                    and not ni.unit.buff(ally, spells.omolozenie, "player")
                    and ni.spell.available(spells.omolozenie)
                    and ni.spell.valid(ally, spells.omolozenie, false, true, true) then
                        ni.spell.cast(spells.omolozenie, ally)
                end
            end
            if enables["sindra_obmorozenie"] then
                    if ni.members[i]:debuffs("Пронизывающая стужа")
                    and not ni.unit.buff(ally, spells.omolozenie, "player")
                    and ni.spell.available(spells.omolozenie)
                    and ni.spell.valid(ally, spells.omolozenie, false, true, true) then
                        ni.spell.cast(spells.omolozenie, ally)
                end
            end
            if enables["lich"] then
                if not cache.IsMoving then
                    if ni.members[i]:debuffs("Жатва душ||Великая жатва душ") then
                        if not ni.unit.buff(ally, spells.vostanovlenie, "player")
                        and ni.spell.available(spells.vostanovlenie)
                        and ni.spell.valid(ally, spells.vostanovlenie, false, true, true)
                        and cache.double == true then
                            ni.spell.cast(spells.vostanovlenie, ally)
                        elseif ni.spell.valid(ally, spells.pp, false, true, true)
                        and ni.spell.available(spells.pp) then
                            ni.spell.cast(spells.pp, ally)
                        end
                    end
                end
            end
            if enables["fizruk"] then
                if ni.members[i]:debuffs("Гравитационная бомба") then
                    if not cache.IsMoving
                    and not ni.unit.buff(ally, spells.vostanovlenie, "player")
                    and ni.spell.available(spells.vostanovlenie)
                    and ni.spell.valid(ally, spells.vostanovlenie, false, true, true)
                    and cache.double == true then
                        ni.spell.cast(spells.vostanovlenie, ally)
                    elseif not ni.unit.buff(ally, spells.omolozenie, "player")
                    and ni.spell.available(spells.omolozenie)
                    and ni.spell.valid(ally, spells.omolozenie, false, true, true) then
                        ni.spell.cast(spells.omolozenie, ally)
                    end
                end
            end
            if enables["kopito_kara_hm"] then
                if ni.members[i]:debuff("Метка демона") then
                    if not cache.IsMoving
                    and ni.spell.available(spells.vostanovlenie)
                    and not ni.unit.buff(ally, spells.vostanovlenie, "player")
                    and ni.spell.valid(ally, spells.vostanovlenie, false, true, true)
                    and cache.double == true then
                        ni.spell.cast(spells.vostanovlenie, ally)
                    end
                end
            end
        end
    end,
    -----------------------------------
    ["buyniy_rost"] = function()
        for i = 1, #ni.members.sort() do
            local ally = ni.members[i].unit;
            local range = ni.members.inrangebelow(ally, 14, 99);
            if ni.unit.hp(ally) <= 99
            and #range >= values.buyniy_rost - 1
            and ni.spell.available(spells.buyniy_rost)
			and ni.spell.valid(ally, spells.buyniy_rost, false, true, true) then
				ni.spell.cast(spells.buyniy_rost, ally)
            end
        end
    end,
    -----------------------------------
    ["bv"] = function()
            for i = 1, #ni.members.sort() do
                local ally = ni.members[i].unit;
                local tar = ni.objects[ally];
                    if ni.unit.hp(ally) <= 80
                    and ni.spell.available(spells.bv)
                    and ni.spell.valid(ally, spells.bv, false, true, true) then
                        if ni.unit.buff(ally, spells.omolozenie)
                        or ni.unit.buff(ally, spells.vostanovlenie) then
                            if tar.name ~= inputs.ignor1
                        and tar.name ~= inputs.ignor2
                        and tar.name ~= inputs.ignor3 then
                            ni.spell.cast(spells.bv, ally)
                        end
                        end
                end
            end
            if enables["hill_vseh"] then
                local friends = ni.unit.friendsinrange("player", 40)
                for i = 1, #friends do
                    local guid = friends[i].guid
                    local tar = ni.objects[guid];
                    if ni.unit.hp(guid) <= 80
                    and ni.spell.available(spells.bv)
                    and ni.spell.valid(guid, spells.bv, false, true, true) then
                        if ni.unit.buff(guid, spells.omolozenie)
                        or ni.unit.buff(guid, spells.vostanovlenie) then
                            if tar.name ~= inputs.ignor1
                        and tar.name ~= inputs.ignor2
                        and tar.name ~= inputs.ignor3 then
                            ni.spell.cast(spells.bv, guid)
                        end
                        end
                    end
                end
            end
    end,
    -----------------------------------
    ["pp_tank"] = function()
        if enables["pp_tank"]
        and not cache.stopcast
        and not cache.IsMoving then
            for i = 1, #ni.members.sort() do
                local ally = ni.members[i].unit;
                local tar = ni.objects[ally];
                    if ni.unit.hp(ally) <= values.pp_tank
                    and ni.members[i]:istank()
                    and ni.spell.available(spells.pp)
                    and ni.spell.valid(ally, spells.pp, false, true, true) then
                        if tar.name ~= inputs.ignor1
                        and tar.name ~= inputs.ignor2
                        and tar.name ~= inputs.ignor3 then
                            ni.spell.cast(spells.pp, ally)
                        end
                    end
            end
        end
    end,
    ------------------------
    ["omolozenie_tank"] = function()
            for i = 1, #ni.members do
                local ally = ni.members[i].unit;
                local tar = ni.objects[ally];
                    if ni.members[i]:istank()
                    and not ni.unit.buff(ally, spells.omolozenie, "player")
                    and ni.spell.available(spells.omolozenie)
                    and ni.spell.valid(ally, spells.omolozenie, false, true, true) then
                        if tar.name ~= inputs.ignor1
                        and tar.name ~= inputs.ignor2
                        and tar.name ~= inputs.ignor3 then
                            ni.spell.cast(spells.omolozenie, ally)
                        end
                end
            end
    end,
    ------------------------
    ["omolozenie"] = function()
            for i = 1, #ni.members.sort() do
                local ally = ni.members[i].unit;
                local tar = ni.objects[ally];
                    if ni.unit.hp(ally) <= 99
                    and not ni.unit.buff(ally, spells.omolozenie, "player")
                    and ni.spell.available(spells.omolozenie)
                    and ni.spell.valid(ally, spells.omolozenie, false, true, true) then
                        if tar.name ~= inputs.ignor1
                        and tar.name ~= inputs.ignor2
                        and tar.name ~= inputs.ignor3 then
                            ni.spell.cast(spells.omolozenie, ally)
                        end
                end
            end
            if enables["hill_vseh"] then
                local friends = ni.unit.friendsinrange("player", 40)
                for i = 1, #friends do
                    local guid = friends[i].guid
                    local tar = ni.objects[guid];
                    if ni.unit.hp(guid) <= 99
                    and not ni.unit.buff(guid, spells.omolozenie, "player")
                    and ni.spell.available(spells.omolozenie)
                    and ni.spell.valid(guid, spells.omolozenie, false, true, true) then
                        if tar.name ~= inputs.ignor1
                        and tar.name ~= inputs.ignor2
                        and tar.name ~= inputs.ignor3 then
                            ni.spell.cast(spells.omolozenie, guid)
                        end
                    end
                end
            end
    end,
    -----------------------------------
    ["pp_reid"] = function()
        if not cache.IsMoving
        and not cache.stopcast then
            for i = 1, #ni.members.sort() do
                local ally = ni.members[i].unit;
                local tar = ni.objects[ally];
                    if ni.unit.hp(ally) <= 90
                    and ni.spell.available(spells.pp)
                    and ni.spell.valid(ally, spells.pp, false, true, true) then
                        if tar.name ~= inputs.ignor1
                        and tar.name ~= inputs.ignor2
                        and tar.name ~= inputs.ignor3 then
                            ni.spell.cast(spells.pp, ally)
                        end
                    end
            end
            if enables["hill_vseh"] then
                local friends = ni.unit.friendsinrange("player", 40)
                for i = 1, #friends do
                    local guid = friends[i].guid
                    local tar = ni.objects[guid];
                    if ni.unit.hp(guid) <= 90
                    and ni.spell.available(spells.pp)
                    and ni.spell.valid(guid, spells.pp, false, true, true) then
                        if tar.name ~= inputs.ignor1
                        and tar.name ~= inputs.ignor2
                        and tar.name ~= inputs.ignor3 then
                            ni.spell.cast(spells.pp, guid)
                        end
                      end
                end
            end
        end
    end,
    -----------------------------------
    ["vostanovlenie_prof"] = function()
        for i = 1, #ni.members do
            local ally = ni.members[i].unit;
            local creations = ni.unit.creations(ally);
            for i = 1, #creations do
                local pet = creations[i].guid
                local tar = ni.objects[pet];
                if tar.name == "Мутировавшее поганище" then
                    if not ni.unit.buff(pet, spells.vostanovlenie, "player")
                    and cache.double == true
                    and not cache.IsMoving
                    and ni.spell.available(spells.vostanovlenie)
                    and ni.spell.valid(pet, spells.vostanovlenie, false, true, true) then
                        ni.spell.cast(spells.vostanovlenie, pet)
                    end
                end
            end
        end
    end,
    -----------------------------------
    ["vostanovlenie_tank"] = function()
        if not cache.IsMoving 
        and cache.PlayerCombat
        and not cache.stopcast
        and cache.double == true then
            for i = 1, #ni.members do
                local ally = ni.members[i].unit;
                if ni.members[i]:istank()
                and not ni.unit.buff(ally, spells.vostanovlenie, "player")
                and ni.spell.available(spells.vostanovlenie)
                and ni.spell.valid(ally, spells.vostanovlenie, false, true, true) then
                    ni.spell.cast(spells.vostanovlenie, ally)
                end
            end
        end
    end,
    -----------------------------------
    ["pet_hill"] = function()
        if enables["hill_pet"]
        and cache.PlayerCombat then
            for i = 1, #ni.members do
                local ally = ni.members[i].unit;
                local creations = ni.unit.creations(ally);
                for i = 1, #creations do
                    local pet = creations[i].guid
                    if ni.unit.hp(pet) <= 99
                    and not ni.unit.buff(pet, spells.omolozenie, "player")
                    and ni.spell.available(spells.omolozenie)
                    and ni.spell.valid(pet, spells.omolozenie, false, true, true) then
                        ni.spell.cast(spells.omolozenie, pet)
                    end
                end
            end
        end
end,
    -----------------------------------
    ["obodrenie"] = function()
            for i = 1, #ni.members do
                local ally = ni.members[i].unit;
                if ni.members[i]:ismelee()
                and not ni.unit.buff(ally, spells.omolozenie, "player")
                and ni.spell.available(spells.omolozenie)
                and ni.spell.valid(ally, spells.omolozenie, false, true, true) then
                    ni.spell.cast(spells.omolozenie, ally)
                elseif ni.vars.combat.aoe 
                and not ni.unit.buff(ally, spells.omolozenie, "player")
                and ni.spell.available(spells.omolozenie)
                and ni.spell.valid(ally, spells.omolozenie, false, true, true) then
                    ni.spell.cast(spells.omolozenie, ally)
                elseif enables["hill_vseh"]
                and ni.vars.combat.aoe then
                    local friends = ni.unit.friendsinrange("player", 40)
                        for i = 1, #friends do
                            local guid = friends[i].guid
                            if not ni.unit.buff(guid, spells.omolozenie, "player")
                            and ni.spell.available(spells.omolozenie)
                            and ni.spell.valid(guid, spells.omolozenie, false, true, true) then
                                ni.spell.cast(spells.omolozenie, guid)
                            end
                        end
                end
            end
    end,
    -----------------------------------
};
	ni.bootstrap.profile("rdru_by_makaren_wrath", queue, abilities, OnLoad, OnUnLoad);
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
    ni.bootstrap.profile("rdru_by_makaren_wrath", queue, abilities);
end;