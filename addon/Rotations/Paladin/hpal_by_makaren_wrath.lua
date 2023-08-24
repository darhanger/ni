local Sirus = GetItemInfo(100455) ~= nil or false;

if Sirus then

local t4 = 0
if ni.player.hasitemequipped(29061) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(29062) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(29063) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(29064) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(29065) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100445) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100446) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100447) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100448) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(100449) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101345) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101346) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101347) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101348) then
    t4 = t4 + 1
end
if ni.player.hasitemequipped(101349) then
    t4 = t4 + 1
end
local enables = {
    ["hill_vseh"] = false,
    ["pp_tank"] = true,
    ["klyatva"] = true,
    ["trin1"] = false,
    ["trin2"] = false,
    ["trin1k"] = true,
    ["trin2k"] = true,
    ["perch"] = true,
    ["ogur"] = true,
    ["trin1m"] = false,
    ["trin2m"] = false,
    ["banka"] = false,
    ["ruki"] = true,
    ["decurse"] = false,
    ["decurse_2"] = false,
    ["stan"] = true,
    ["hill_pet"] = true,
    ["debug"] = false,
    ["chas"] = true,
    ["shild"] = true,
    ["babl"] = true,
    ["z_50"] = true,
    ["krl"] = true,
    ["krl_k"] = true,
}
local values = {
    osvob = 4,
    klyatva = 91,
    trin1 = 80,
    trin2 = 80,
    trin1m = 80,
    trin2m = 80,
    ogur = 30,
    perch = 80,
    banka = 20,
    ruki = 30,
    z_50 = 30,
    babl = 30,
    krl = 90,
}
local inputs = {
    ignor1 = "",
    ignor2 = "",
    ignor3 = "",
    decursee = "",
    decurseee = "Мертвящая чума",
    chas = "",
    shild = "",
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
    settingsfile = "hpal_by_makaren_wrath.json",
    callback = GUICallback,
    { type = "title", text = "Holy Pal by |c0000CED1Makaren|r" },
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
    { type = "entry", text = ni.spell.icon(10308).." Стан в мк", enabled = true, key = "stan" },
    { type = "entry", text = ni.spell.icon(1038).." Авто сальва", enabled = true, key = "salva" },
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
    { type = "separator" },
    { type = "title", text = "|cFF00FFFFКлятва|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(54428).." Тринькет №1", tooltip = "Использует Тринькет №1 под Клятву", enabled = true, key = "trin1k" },
    { type = "entry", text = ni.spell.icon(54428).." Тринькет №2", tooltip = "Использует Тринькет №2 под Клятву", enabled = true, key = "trin2k" },
    { type = "page", number = 3, text = "|cFF00FF00Настройки исцеления|r" },
    { type = "separator" },
    { type = "title", text = "|cffFFFF00Способности|r" },
    { type = "separator" },
    { type = "title", text = "|cFF00FFFFMp|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(54428).." Клятва", tooltip = "Использует Клятву при |cFF00FFFFMp <|r", enabled = true, value = 91, min = 1, max = 100, step = 1, key = "klyatva" },
    { type = "entry", text = ni.spell.icon(31884).." Крылья с клятвой", tooltip = "Использует Гнев карателя вместе с клятвой", enabled = true, key = "krl_k" },
    { type = "separator" },
    { type = "title", text = "|cFF00FF00Hp|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(31884).." Крылья", tooltip = "Использует Гнев карателя если  |cFF00FF00Hp группы/рейда <|r", enabled = true, value = 90, min = 1, max = 100, step = 1, key = "krl" },
    { type = "entry", text = ni.spell.icon(48788).." Возложение рук", tooltip = "Использует Возложение рук если  |cFF00FF00Hp члена группы/рейда <|r\
Работает в связке с функцией TTD(Time To Die)", enabled = true, value = 30, min = 1, max = 100, step = 1, key = "ruki" },
    { type = "page", number = 4, text = "|cFF00FF00Настройки исцеления|r" },
    { type = "separator" },
    { type = "title", text = "|cffFFFF00Частица + Священный щит|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(53563).." Частица света", tooltip ="Использует Частицу света по имени\
Если поле пустое, то использует по фокусу", enabled = true, key = "chas" },
{
    type = "input",
    value = inputs["chas"],
    width = 140,
    height = 15,
    key = "chas"
},
{ type = "entry", text = ni.spell.icon(53601).." Священный щит", tooltip ="Использует Священный щит по имени\
Если поле пустое, то использует по фокусу", enabled = true, key = "shild" },
{
    type = "input",
    value = inputs["shild"],
    width = 140,
    height = 15,
    key = "shild"
},
    { type = "page", number = 5, text = "|cFF00FF00Настройки исцеления|r" },
    { type = "separator" },
    { type = "title", text = "|cffFFFF00Диспел|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(4987).." Диспел", enabled = false, key = "decurse" },
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
    { type = "title", text = "|cffFFFF00Способности|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(642).." Бабл", tooltip = "Использует Бабл при |cFF00FF00Hp <|r\
Работает в связке с функцией TTD(Time To Die)", enabled = true, value = 30, min = 1, max = 100, step = 1, key = "babl" },
    { type = "entry", text = ni.spell.icon(498).." 50/50", tooltip = "Использует 50/50 при |cFF00FF00Hp <|r\
Работает в связке с функцией TTD(Time To Die)", enabled = true, value = 30, min = 1, max = 100, step = 1, key = "z_50" },
    { type = "page", number = 8, text = "|cFFFF0000Защитные настройки|r" },
    { type = "separator" },
    { type = "title", text = "|cffFFFF00Предметы|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(11729).." Огурец", tooltip = "Использует Огурец при |cFF00FF00Hp <|r\
Работает в связке с функцией TTD(Time To Die)", enabled = true, value = 30, min = 1, max = 100, step = 1, key = "ogur" },
};

local function OnLoad()
	ni.GUI.AddFrame("hpal_by_makaren_wrath", items);
end;
local function OnUnLoad()  
	ni.GUI.DestroyFrame("hpal_by_makaren_wrath");
end;
local cache = {
    IsMoving = false,
    sindra = false,
    PlayerCombat = false,
    double = true,
    info = true,
    stopcast = false,
    };
local spells = {
    svet_nebes = GetSpellInfo(48782),
    fleska = GetSpellInfo(48785),
    shok = GetSpellInfo(48825),
    shild = GetSpellInfo(53601),
    chastitca = GetSpellInfo(53563),
    djaga = GetSpellInfo(20271),
    krilya = GetSpellInfo(31884),
    babl = GetSpellInfo(642),
    sakra = GetSpellInfo(64205),
    freedom = GetSpellInfo(1044),
    salva = GetSpellInfo(1038),
    zertva = GetSpellInfo(6940),
    bog_def = GetSpellInfo(498),
    ma = GetSpellInfo(31821),
    hotsh = GetSpellInfo(10308),
    dlan_def = GetSpellInfo(10278),
    bog = GetSpellInfo(20216),
    ruki = GetSpellInfo(48788),
    mp_50 = GetSpellInfo(31842),
    dispell = GetSpellInfo(4987),
    klyatva = GetSpellInfo(54428),
    pechat_mud = GetSpellInfo(20166),
    pechat_sv = GetSpellInfo(20165),
    char_rass = GetSpellInfo(316432),
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
    "info",
    "cache",
    "stopcast",
    "pause",
    "cd",
    "save",
    "Prohill_metok",
    "bog",
    "salva",
    "pechats",
    "dispell",
    "djaga",
    "valitria",
    "smart t4",
    "chastitca",
    "auto-target",
    "svet_buff",
    "svet_nebes",
    "shok",
    "fleshka",
    "svet_tank",
    "fleshka_tank",
    "pet_hill",
    "shild",
    "djaga_obnov",
    "fleska_hots",
    "dd",
};
local abilities = {
    ------------------------
    ["info"] = function()
        if cache.info == true
        and not ni.vars.coin then
            cache.info = false
            print("|cFFFF0000  =========================|r\
|cFFFFFFFFХоли Пал|r\
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
        if spell == ("Свет небес") then
            cache.double = false
        elseif spell ~= nil then
            cache.double = true
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
            if enables["trin1k"]
            and ni.player.slotcastable(13)
            and ni.player.buff(spells.klyatva)
            and ni.player.slotcd(13) == 0 then
                ni.player.useinventoryitem(13)
            end
            if enables["trin2k"]
            and ni.player.slotcastable(14)
            and ni.player.buff(spells.klyatva)
            and ni.player.slotcd(14) == 0 then
                ni.player.useinventoryitem(14)
            end
            if enables["krl"]
            and ni.spell.available(spells.krilya)
            and ni.members.average() <= values.krl then
                ni.spell.cast(spells.krilya)
            end
            if enables["klyatva"]
            and not ni.player.buff(rass.char_rass)
            and ni.spell.available(spells.klyatva)
            and ni.power.current("player") <= values.klyatva then
                ni.spell.cast(spells.klyatva)
            end
            if enables["krl_k"]
            and ni.player.buff(spells.klyatva)
            and ni.spell.available(spells.krilya) then
                ni.spell.cast(spells.krilya)
            end
            count = GetItemCount("Фрагмент души")
            if ni.spell.available(rass.eredar)
            and not ni.unit.buff("player", rass.eredar) then
                if count > 1 
                or ni.unit.hp("target") < 10 then
                    ni.spell.cast(rass.eredar)
                end
            end
            if ni.spell.available(rass.char_rass)
            and not ni.player.buff(spells.klyatva) then
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
            if enables["babl"]
            and ni.unit.hp("player") < values.babl then
                if ni.unit.ttd("player") < 2
                and ni.spell.available(spells.babl)
                and not ni.player.debuff(25771) then
                    ni.spell.cast(spells.babl)
                end
            end
            if enables["z_50"]
            and ni.unit.hp("player") < values.z_50 then
                if ni.unit.ttd("player") < 3
                and ni.spell.available(spells.bog_def)
                and not ni.player.debuff(25771) then
                    ni.spell.cast(spells.bog_def)
                end
            end
            if enables["ruki"] then
                for i = 1, #ni.members.sort() do
                    local ally = ni.members[i].unit;
                    if ni.unit.hp(ally) < values.ruki
                    and ni.spell.available(spells.ruki)
                    and ni.spell.valid(ally, spells.ruki, false, true, true)
                    and ni.unit.ttd(ally) < 2 then
                        ni.spell.cast(spells.ruki, ally)
                    end
                end
            end
            
        end
    end,
    --------------------------
    ["Prohill_metok"] = function()
        if not cache.IsMoving then
            for i = 1, #ni.members.sort() do
                local ally = ni.members[i].unit;
                if ni.members[i]:debuff("Испепеление плоти")
		        or ni.members[i]:debuff("Пронизывающий холод")
                and ni.unit.debuff("player", "Жуки-трупоеды")
                or ni.members[i]:debuff("Заражение") then
		            if ni.spell.valid(ally, spells.shok, false, true, true)
                    and ni.spell.available(spells.shok) then
                        if ni.spell.available(spells.bog) then
                            ni.spell.cast(spells.bog, ally)
                        end
			            if ni.player.buff(304704) then
			                ni.spell.cast(spells.shok, ally)
			            elseif ni.spell.valid(ally, spells.svet_nebes, false, true, true)
                        and ni.spell.available(spells.svet_nebes)
			            and not cache.stopcast then
                            ni.spell.cast(spells.svet_nebes, ally)
			            end
                    end
                end
            end  
        end
        if ni.spell.available(spells.bog)
        or ni.player.buff(304704) then
            for i = 1, #ni.members do
                local ally = ni.members[i].unit;
                if ni.members[i]:debuff(ddebuffs.sindra_metka)
                and not ni.unit.buff(ally, 319166)
                and ni.spell.valid(ally, spells.shok, false, true, true)
                and ni.spell.available(spells.shok) then
                    if ni.spell.available(spells.bog) then
                        ni.spell.cast(spells.bog, ally)
                    end
                    ni.spell.cast(spells.shok, ally)
                end
            end
        end
    end,
    --------------------------
    ["bog"] = function()
        if ni.player.buff(304704) then
            for i = 1, #ni.members.sort() do
                local ally = ni.members[i].unit;
                if ni.spell.valid(ally, spells.shok, false, true, true)
                and ni.spell.available(spells.shok) then
                    if tar.name ~= inputs.ignor1
                    and tar.name ~= inputs.ignor2
                    and tar.name ~= inputs.ignor3 then
                        ni.spell.cast(spells.shok, ally)
                    end
                end
            end
        end
    end,
    -----------------------------------
    ["salva"] = function()
        if cache.PlayerCombat
        and enables["salva"] then
            for i = 1, #ni.members.sort() do
                local ally = ni.members[i].unit;
                if ni.unit.threat(ally) > 2
                and not ni.members[i]:istank() then
                    if ni.spell.available(spells.salva)
                    and ni.spell.valid(ally, spells.salva, false, true, true) then
                        if tar.name ~= inputs.ignor1
                        and tar.name ~= inputs.ignor2
                        and tar.name ~= inputs.ignor3 then
                            ni.spell.cast(spells.salva, ally)
                        end
                    end
                end
            end
        end
    end,
    -----------------------------------
    ["pechats"] = function()
        if not ni.player.buff(spells.pechat_mud)
        and not ni.player.buff(spells.pechat_sv) then
            for i = 1, NUM_GLYPH_SLOTS do
                local enabled, glyphType, glyphTooltipIndex, glyphSpellID, icon = GetGlyphSocketInfo(i);
                if glyphTooltipIndex == 54940 then
                    ni.spell.cast(spells.pechat_mud)
                end
                if glyphTooltipIndex == 54943 then
                    ni.spell.cast(spells.pechat_sv)
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
--------------------------
["djaga"] = function()
    if cache.PlayerCombat then
        if not ni.unit.debuff("target", 20185)
        or not ni.player.buff(54153) then
            if ni.spell.valid("target", spells.djaga, false, true, true)
            and ni.spell.available(spells.djaga) then
                ni.spell.cast(spells.djaga, "target")
                cache.pal = true
            end
        end
    end
end,
 -----------------------------------
 ["valitria"] = function()
    if ni.objectmanager.contains("Валитрия Сноходица") then
        local valitria = ni.objectmanager.objectGUID("Валитрия Сноходица")
        if ni.spell.valid(valitria, spells.chastitca, false, true, true)
        and not ni.unit.buff(valitria, spells.chastitca, "player")
        and ni.spell.available(spells.chastitca) then
            ni.spell.cast(spells.chastitca, valitria)
        else  
            if not cache.IsMoving then
                for i = 1, #ni.members.sort() do
                    local ally = ni.members[i].unit;
                    if not ni.unit.buff(ally, spells.chastitca, "player") then
                        local range = ni.members.inrangebelow(ally, 7, 100);
                        if ni.spell.available(spells.svet_nebes)
			            and ni.spell.valid(ally, spells.svet_nebes, false, true, true) then
                            if #range >= 3 then
                                ni.spell.cast(spells.svet_nebes, ally)
                            elseif #range >= 2 then
                                ni.spell.cast(spells.svet_nebes, ally)
                            elseif #range >= 1 then
                                ni.spell.cast(spells.svet_nebes, ally)
                            else 
                                ni.spell.cast(spells.svet_nebes, ally)
                            end
                        end
                    end
                end
            end
        end
    end
end,
--------------------------
["smart t4"] = function()
    if cache.PlayerCombat
    and ni.spell.available(spells.bog)
    and ni.spell.available(spells.svet_nebes) then
        ni.spell.cast(spells.bog)
    end
end,
--------------------------
["chastitca"] = function()
    if not ni.objectmanager.contains("Валитрия Сноходица") then
        if enables["chas"]
        and inputs.chas ~= "" then
            for i = 1, #ni.members do
                local ally = ni.members[i].unit;
                local tar = ni.objects[ally];
                if inputs.chas == tar.name
                and cache.PlayerCombat
                and ni.spell.available(spells.chastitca)
                and not ni.unit.buff(ally, spells.chastitca, "player")
                and ni.spell.valid(ally, spells.chastitca, false, true, true) then
                    ni.spell.cast(spells.chastitca, ally)
                end
            end
        elseif cache.PlayerCombat
        and ni.spell.valid("focus", spells.chastitca, false, true, true)
        and not ni.unit.buff("focus", spells.chastitca, "player")
        and ni.spell.available(spells.chastitca) then
            ni.spell.cast(spells.chastitca, "focus")
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
["svet_buff"] = function()
    if cache.PlayerCombat
    and not cache.stopcast
    and not cache.IsMoving
    and cache.pal == true then
        for i = 1, #ni.members.sort() do
            local ally = ni.members[i].unit;
            if ni.unit.buffremaining("player", 31834) < 3
            and ni.spell.available(spells.svet_nebes) then
                if tar.name ~= inputs.ignor1
                and tar.name ~= inputs.ignor2
                and tar.name ~= inputs.ignor3 then
                    ni.spell.cast(spells.svet_nebes, ally)
                end
            end
        end
    end
end,
--------------------------
["svet_nebes"] = function()
    if not cache.stopcast
    and not cache.IsMoving then
        for i = 1, #ni.members.sort() do
            local ally = ni.members[i].unit;
            if not ni.unit.buff(ally, spells.chastitca, "player") then
                local range = ni.members.inrangebelow(ally, 7, 99);
                if ni.unit.hp(ally) <= 99
                and #range >= 1
                and ni.spell.available(spells.svet_nebes)
			    and ni.spell.valid(ally, spells.svet_nebes, false, true, true) then
                    if tar.name ~= inputs.ignor1
                    and tar.name ~= inputs.ignor2
                    and tar.name ~= inputs.ignor3 then
				        ni.spell.cast(spells.svet_nebes, ally)
                    end
                end
            end
        end
    end
    if enables["hill_vseh"] then
        local friends = ni.unit.friendsinrange("player", 40)
        for i = 1, #friends do
            local guid = friends[i].guid
            local tar = ni.objects[guid];
            if ni.unit.hp(guid) <= 99
            and not ni.unit.buff(guid, spells.svet_nebes, "player")
            and ni.spell.available(spells.svet_nebes)
            and ni.spell.valid(guid, spells.svet_nebes, false, true, true) then
                if tar.name ~= inputs.ignor1
                and tar.name ~= inputs.ignor2
                and tar.name ~= inputs.ignor3 then
                    ni.spell.cast(spells.svet_nebes, guid)
                end
            end
        end
    end
end,
--------------------------
["shok"] = function()
    for i = 1, #ni.members.sort() do
        local ally = ni.members[i].unit;
        if ni.unit.hp(ally) <= 90
        and ni.spell.available(spells.shok)
        and ni.spell.valid(ally, spells.shok, false, true, true) then
            if tar.name ~= inputs.ignor1
            and tar.name ~= inputs.ignor2
            and tar.name ~= inputs.ignor3 then
                ni.spell.cast(spells.shok, ally)
                cache.pal = true
            end
        end
    end
end,
--------------------------
["fleshka"] = function()
    if ni.player.buff(54149)
    or not cache.IsMoving
    and not cache.stopcast then
        for i = 1, #ni.members.sort() do
            local ally = ni.members[i].unit;
            if not ni.unit.buff(ally, spells.chastitca, "player")
            and ni.unit.hp(ally) <= 95
            and ni.spell.available(spells.fleska)
            and ni.spell.valid(ally, spells.fleska, false, true, true) then
                if tar.name ~= inputs.ignor1
                and tar.name ~= inputs.ignor2
                and tar.name ~= inputs.ignor3 then
                    ni.spell.cast(spells.fleska, ally)
                    cache.pal = true
                end
            end
        end
    end
end,
--------------------------
["svet_tank"] = function()
    if not cache.stopcast then
        for i = 1, #ni.members.sort() do
            local ally = ni.members[i].unit;
            if ni.unit.hp(ally) <= 70
            and ni.spell.available(spells.svet_nebes)
            and ni.spell.valid(ally, spells.svet_nebes, false, true, true) then
                if tar.name ~= inputs.ignor1
                and tar.name ~= inputs.ignor2
                and tar.name ~= inputs.ignor3 then
                    ni.spell.cast(spells.svet_nebes, ally)
                    cache.pal = true
                end
            end
        end
    end
end,
--------------------------
["fleshka_tank"] = function()
    if not cache.stopcast then
        for i = 1, #ni.members.sort() do
            local ally = ni.members[i].unit;
            if ni.unit.hp(ally) <= 95
            and ni.spell.available(spells.fleska)
            and ni.spell.valid(ally, spells.fleska, false, true, true) then
                if tar.name ~= inputs.ignor1
                and tar.name ~= inputs.ignor2
                and tar.name ~= inputs.ignor3 then
                    ni.spell.cast(spells.fleska, ally)
                    cache.pal = true
                end
            end
        end
    end
end,
-----------------------------------
["pet_hill"] = function()
    if enables["hill_pet"]
    and cache.PlayerCombat
    and not cache.IsMoving
    and not cache.stopcast then
        for i = 1, #ni.members do
            local ally = ni.members[i].unit;
            local creations = ni.unit.creations(ally);
            for i = 1, #creations do
                local pet = creations[i].guid
                if ni.unit.hp(pet) <= 60
                and ni.spell.valid(pet, spells.svet_nebes, false, true, true) then
                    ni.spell.cast(spells.svet_nebes, pet)
                elseif ni.unit.hp(pet) <= 95
                and not ni.unit.buff(pet, spells.fleska, "player")
                and ni.spell.valid(pet, spells.fleska, false, true, true) then
                    ni.spell.cast(spells.fleska, pet)
                end
            end
        end
    end
end,
--------------------------
["shild"] = function()
        if enables["shild"]
        and inputs.shild ~= "" then
            for i = 1, #ni.members do
                local ally = ni.members[i].unit;
                local tar = ni.objects[ally];
                if inputs.shil == tar.name
                and cache.PlayerCombat
                and ni.spell.available(spells.shild)
                and not ni.unit.buff(ally, spells.shild, "player")
                and ni.spell.valid(ally, spells.shild, false, true, true) then
                    ni.spell.cast(spells.shild, ally)
                end
            end
        elseif cache.PlayerCombat
        and ni.spell.valid("focus", spells.shild, false, true, true)
        and not ni.unit.buff("focus", spells.shild, "player")
        and ni.spell.available(spells.shild) then
            ni.spell.cast(spells.shild, "focus")
        end
end,
--------------------------
["djaga_obnov"] = function()
    if cache.PlayerCombat
    and ni.unit.debuffremaining("target", 20185) < 5
    and ni.spell.valid("target", spells.djaga, false, true, true)
    and ni.spell.available(spells.djaga) then
        ni.spell.cast(spells.djaga, "target")
    end
end,
--------------------------
["fleska_hots"] = function()
    if not cache.IsMoving
    and not cache.stopcast
    or ni.player.buff(54149) then
        for i = 1, #ni.members do
            local ally = ni.members[i].unit;
            if ni.unit.buff(ally, spells.shild)
            and not ni.unit.buff(ally, 66922)
            and ni.spell.available(spells.fleska)
            and ni.spell.valid(ally, spells.fleska, false, true, true) then
                ni.spell.cast(spells.fleska, ally)
            end
        end
    end
end,
--------------------------
["dd"] = function()
    if cache.PlayerCombat then
        if ni.spell.available(61411)
        and ni.spell.valid("target", 61411, false, true, true) then
            ni.spell.cast(61411, "target")
        elseif ni.spell.available(spells.djaga)
        and ni.spell.valid("target", spells.djaga, false, true, true) then
            ni.spell.cast(spells.djaga, "target")
        end
    end   
end,
    -----------------------------------
};
	ni.bootstrap.profile("hpal_by_makaren_wrath", queue, abilities, OnLoad, OnUnLoad);
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
    ni.bootstrap.profile("hpal_by_makaren_wrath", queue, abilities);
end;