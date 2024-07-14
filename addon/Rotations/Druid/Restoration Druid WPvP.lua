local GetSpellInfo, print, UnitAffectingCombat, UnitCastingInfo, IsMounted, UnitInVehicle, UnitIsDeadOrGhost, UnitChannelInfo, IsUsableItem, GetItemCooldown, GetInventoryItemID = GetSpellInfo, print, UnitAffectingCombat, UnitCastingInfo, IsMounted, UnitInVehicle, UnitIsDeadOrGhost, UnitChannelInfo, IsUsableItem, GetItemCooldown, GetInventoryItemID;
local spellAvailable, memberRangeBelow, spellCast, debuff, debuffr = ni.spell.available, ni.members.inrangebelow, ni.spell.cast, ni.unit.debuff, ni.unit.debuffremaining;
local enables = {
	["misha"] = false,
	["ten"] = false,
	["poison"] = false,
	["hill_vseh"] = false,
	["ozarenie"] = false,
	["lifeboom"] = false,
	["ogur"] = false,
	["lapa"] = false,
	["root"] = false,
	["smerch"] = false,
	["son"] = false,
	["hvatka"] = false,
	["reshift"] = false,
	["fast_cast"] = false,
	["decurse"] = false,
	["decurse_2"] = false,
	["dub_koza"] = false,
	["hill_pet"] = false,
	["debug"] = false,
	["lifeboom_"] = false,
	["lifeboom__"] = false,
	["vost_"] = false,
	["vost__"] = false,
	["NS"] = false,
	["potion_mp"] = false,
	["potion_hp"] = false,
	["lunniy_ogon"] = false,
	["roy"] = false,
	["gnev"] = false,
	["buyniy_rost_value_hp"] = false,
	["buyniy_rost_value_range"] = false,
	["omolozenie_my"] = false,
	["omolozenie_value_hp"] = false,
	["derevo"] = false,
	["buff"] = false,
	["pokrov"] = false,
	["vostanovlenie"] = false,
	["reflect"] = false,
	["decurse_player"] = false,
	["dispell_poison_player"] = false,
	["bv_value_hp"] = false,
	["warstomp"]  = false,
}
local values = {
	ozarenie = 60,
	ogur = 30,
	lifeboom = 90,
	fast_cast = 30,
	buyniy_rost = 1,
	dub_koza = 70,
	lifeboom_ = 3,
	NS = 30,
	potion_mp = 10,
	potion_hp = 15,
	pokrov = 75,
	vostanovlenie = 55,
	buyniy_rost_value_hp = 99,
	hill_vseh = 70,
	hill_pet = 70,
	bv_value_hp = 75,
	omolozenie_value_hp = 99,
	omolozenie_my_value_hp = 99,
    vost_ = 80,
}
local inputs = {
	decursee = "",
	decurseee = "Мертвящая чума",
	lifeboom___ = "",
	vost___ = "",
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
	settingsfile = "Restoration Druid WPvP.json",
	callback = GUICallback,
	{ type = "title", text = "     |cffFF7C0ARestoration Druid PVP by|r  |c0000CED1Makaren|r |cffFF7C0Aand|r |c0000CED1Ju|r     " },
	{ type = "separator" },
	{ type = "title", text = "|cffFF7C0AProfile version 2.0.0|r" },
	{ type = "separator" },
	{ type = "page", number = 1, text = "|cffFFFF00Общие настройки|r" },
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(20585).." Решифт", tooltip = "Использует " ..ni.spell.icon(33891, 14, 14).."[Древо Жизни] для снятия замедлений ", enabled = false, key = "reshift" },
	{ type = "entry", text = ni.spell.icon(770).." Волшебный огонь", tooltip = "Использует " ..ni.spell.icon(770, 14, 14).."[Волшебный огонь] в разбойника и ферала для невозможности уйти в невидимость ", enabled = false, key = "lapa" },
	{ type = "entry", text = ni.spell.icon(23920).." Отражение заклинания", tooltip = "Использует " ..ni.spell.icon(770, 14, 14).."[Волшебный огонь] для снятия еффекта" ..ni.spell.icon(23920, 14, 14).. " [Отражение заклинания]", enabled = false, key = "reflect" },
	{ type = "entry", text = ni.spell.icon(53312).." Хватка природы", tooltip = "Использует " ..ni.spell.icon(53312, 14, 14).."[Хватка природы] если в враг в мили зоне ", enabled = false, key = "hvatka" },
	{ type = "entry", text = ni.spell.icon(53308).." Гнев деревьев", tooltip = "При зажатой клавише |cffFF0D00SHIFT|r использует "  ..ni.spell.icon(53308, 14, 14).."[Гнев деревьев] |cffFF0D00ПО МАУСОВЕРУ|r \nЕсли нет цели в маусовере - использует " ..ni.spell.icon(53308, 14, 14).."[Гнев деревьев] |cffFF0D00В ЦЕЛЬ|r ", enabled = false, key = "root" },
	{ type = "entry", text = ni.spell.icon(33786).." Смерч", tooltip = "При зажатой клавише |cffFF0D00ALT|r использует "  ..ni.spell.icon(33786, 14, 14).."[Смерч] |cffFF0D00ПО МАУСОВЕРУ|r \nЕсли нет цели в маусовере - использует " ..ni.spell.icon(33786, 14, 14).."[Смерч] |cffFF0D00В ЦЕЛЬ|r ", enabled = false, key = "smerch" },
	{ type = "entry", text = ni.spell.icon(18658).." Спячка", tooltip = "При зажатой клавише |cffFF0D00CONTROL|r использует "  ..ni.spell.icon(18658, 14, 14).."[Спячка] |cffFF0D00ПО МАУСОВЕРУ|r \nЕсли нет цели в маусовере - использует " ..ni.spell.icon(18658, 14, 14).."[Спячка] |cffFF0D00В ЦЕЛЬ|r ", enabled = false, key = "son" },
	{ type = "entry", text = ni.spell.icon(20549).." Громовая поступь", tooltip = "Использует "  ..ni.spell.icon(20549, 14, 14).."[Громовая поступь]|r для сбивания кастов", enabled = false, key = "warstomp" },
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(22812).." Дубовая кожа", tooltip = "Использует " ..ni.spell.icon(22812, 14, 14).."[Дубовая кожа] при |cFF00FF00Hp <|r\
	Работает в связке с функцией TTD(Time To Die)", enabled = false, value = 40, min = 1, max = 100, step = 1, key = "dub_koza" },
	{ type = "entry", text = ni.spell.icon(48470).." Дар дикой природы", tooltip = "Автобафф " ..ni.spell.icon(48470, 14, 14).."[Дар дикой природы] ", enabled = false, key = "buff" },
	{ type = "entry", text = ni.spell.icon(33891).." Древо жизни", tooltip = "Использует " ..ni.spell.icon(33891, 14, 14).."[Древо Жизни] ", enabled = false, key = "derevo" },
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(24803).." Дебаг в чат",  tooltip = "Принт дебаг отчёта в чат ", enabled = false, key = "debug" },
	{ type = "separator" },
	{ type = "title", text = "|cffFF0D00Event catcher|r" },
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(9634).." Ловить дебаффы", tooltip = "Использует " ..ni.spell.icon(9634, 14, 14).."[Облик лютого медведя]", enabled = false, key = "misha" },
	{ type = "entry", text = ni.spell.icon(58984).." Ловить дебаффы", tooltip = "Использует " ..ni.spell.icon(58984, 14, 14).."[Слиться с тенью] ", enabled = false, key = "ten" },
	{ type = "entry", text = ni.spell.icon(19386).." Ловить дебаффы", tooltip = "Использует " ..ni.spell.icon(2893, 14, 14).."[Устранение яда] ", enabled = false, key = "poison" },
	{ type = "page", number = 2, text = "|cFF00FF00Настройки HP|r" },
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(53251).." Буйный рост", tooltip = "Использует " ..ni.spell.icon(53251, 14, 14).."[Буйный рост]\n если  |cFF00FF00Hp игрока/члена группы/рейда <|r", enabled = false, value = 99, min = 1, max = 99, key = "buyniy_rost_value_hp" },
	{ type = "entry", text = ni.spell.icon(53251).." Количество целей", tooltip = "Количество целей для использования заклинания " ..ni.spell.icon(53251, 14, 14).."[Буйный рост] ", enabled = false, value = 1, min = 1, max = 6, key = "buyniy_rost_value_range" },
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(50464).." Покровительство природы", tooltip = "Использует " ..ni.spell.icon(50464, 14, 14).."[Покровительство природы] \n если  |cFF00FF00Hp игрока/члена группы/рейда <|r", enabled = false, value = 75, min = 1, max = 100, key = "pokrov" },
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(18562).." Быстрое восстановление", tooltip = "Использует " ..ni.spell.icon(18562, 14, 14).."[Быстрое восстановление] \n если  |cFF00FF00Hp игрока/члена группы/рейда <|r", enabled = false, value = 75, min = 1, max = 100, key = "bv_value_hp" },
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(48441).." Омоложение ", tooltip = "Использует " ..ni.spell.icon(48441, 14, 14).."[Омоложение] \n если  |cFF00FF00Hp игрока/члена группы/рейда <|r", enabled = false, value = 99, min = 10, max = 100, key = "omolozenie_value_hp" },
	{ type = "entry", text = ni.spell.icon(48441).." Держать Омоложение на себе ", tooltip = "Поддерживает на себе " ..ni.spell.icon(48441, 14, 14).."[Омоложение] \n если  |cFF00FF00Hp игрока <|r", enabled = false, value = 99, min = 10, max = 100, key = "omolozenie_my_value_hp" },
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(48451).." Держать Жизнецвет на себе", tooltip = "Поддерживает на себе " ..ni.spell.icon(48451, 14, 14).."[Жизнецвет] ", enabled = false, value = 3, min = 1, max = 3, step = 1, key = "lifeboom_" },
	{ type = "entry", text = ni.spell.icon(48451).." Держать Жизнецвет по нику" ,tooltip = "Поддерживает по  указанному нику " ..ni.spell.icon(48451, 14, 14).."[Жизнецвет] ", enabled = false, key = "lifeboom__" },
	{
	type = "input",
	value = inputs["lifeboom___"],
	width = 130,
	height = 20,
	key = "lifeboom___"
	},
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(48443).." Восстановление", tooltip = "Использует " ..ni.spell.icon(48443, 14, 14).."[Восстановление] \n если  |cFF00FF00Hp игрока/члена группы/рейда <|r", enabled = false, value = 55, min = 1, max = 100, key = "vostanovlenie" },
	{ type = "entry", text = ni.spell.icon(48443).." Держать Восстановление на себе", tooltip = "Поддерживает на себе " ..ni.spell.icon(48443, 14, 14).."[Восстановление]", enabled = false, value = 80, min = 1, max = 100, key = "vost_" },
	{ type = "entry", text = ni.spell.icon(48443).." Держать Восстановление по нику" ,tooltip = "Поддерживает по указанному нику " ..ni.spell.icon(48443, 14, 14).."[Восстановление]", enabled = false, key = "vost__" },
	{
	type = "input",
	value = inputs["vost___"],
	width = 130,
	height = 20,
	key = "vost___"
	},
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(50464).." Хилить всех игроков", tooltip = "Хилит так же не состоящих в группе/рейде \n" ..ni.spell.icon(48441, 14, 14).."." ..ni.spell.icon(53251, 14, 14).."."  ..ni.spell.icon(18562, 14, 14).."." ..ni.spell.icon(50464, 14, 14)..".", enabled = false, value = 70, min = 1, max = 100, key = "hill_vseh" },
	{ type = "entry", text = ni.spell.icon(50464).." Хилить питомцев    ", tooltip = "Хилит питомцев, с приоритетом ниже игроков \n" ..ni.spell.icon(48441, 14, 14).."." ..ni.spell.icon(53251, 14, 14).."."  ..ni.spell.icon(18562, 14, 14).."." ..ni.spell.icon(50464, 14, 14)..".", enabled = false, value = 70, min = 1, max = 100, key = "hill_pet" },
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(17116).." Природная стремительность", tooltip = "Использует "..ni.spell.icon(17116, 14, 14).."[Природная стремительность] + "..ni.spell.icon(48378, 14, 14).."[Целительное прикосновение]\n если  |cFF00FF00Hp игрока/члена группы/рейда <|r", enabled = false, value = 30, min = 1, max = 100, step = 1, key = "fast_cast" },
	{ type = "entry", text = ni.player.itemicon(33447).." Лечебное зелье", tooltip = " Использует лечебное зелье при |cFF00FF00Hp <|r \n" ..ni.player.itemicon(41166, 14, 14).." [Рунический набор для лечебных инъекций] \n " ..ni.player.itemicon(43569, 14, 14).." |cff0070dd[Бездонный флакон с лечебным зельем]|r \n" ..ni.player.itemicon(33447, 14, 14).." [Рунический флакон с лечебным зельем] " , enabled = false, value = 30, min = 1, max = 100, step = 1, key = "potion_hp" },
	{ type = "entry", text = ni.spell.icon(11729).." Камень здоровья", tooltip = "Использует " ..ni.spell.icon(11729, 14, 14).."[Камень здоровья] при |cFF00FF00Hp <|r\
Работает в связке с функцией TTD(Time To Die)", enabled = false, value = 30, min = 1, max = 100, step = 1, key = "ogur" },
	{ type = "entry", text = ni.player.itemicon(50726).." Подвеска истинной крови", tooltip = "Использует " ..ni.player.itemicon(50726, 14, 14).."|cffa335ee[Подвеска истинной крови] \n|r если |cFF00FF00Hp игрока/члена группы/рейда <|r", enabled = false, value = 30, min = 1, max = 100, step = 1, key = "NS" },
	{ type = "dropdown", menu = { 
	{ selected = true, value = 1, text = "|cFFFF5A00На себя" },
	{ selected = false, value = 2, text = "|cFF00FFFFНа всех союзников" },
	}, key = "ActionEvent" },
	{ type = "page", number = 3, text = "|cff0070ddНастройки MP|r" },
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(29166).." Озарение", tooltip = "Использует " ..ni.spell.icon(29166, 14, 14).."[Озарение] на себя при |cFF00FFFFMp <|r", enabled = false, value = 60, min = 1, max = 100, step = 1, key = "ozarenie" },
	{ type = "entry", text = ni.player.itemicon(33448).."Зелье маны", tooltip = "Использует зелье маны при |cFF00FFFFMp <|r \n" ..ni.player.itemicon(42545, 14, 14).." [Рунический набор для лечебных инъекций] \n " ..ni.player.itemicon(43570, 14, 14).." |cff0070dd[Бездонный флакон с зельем маны]|r \n" ..ni.player.itemicon(33448, 14, 14).." [Рунический флакон с зельем маны] ",  enabled = false, value = 10, min = 1, max = 100, step = 1, key = "potion_mp" },
	{ type = "entry", text = ni.spell.icon(48451).." Жизнецвет", tooltip = "Использует " ..ni.spell.icon(48451, 14, 14).."[Жизнецвет] под прок " ..ni.spell.icon(16870, 14, 14).."[Ясность мысли] при |cFF00FFFFMp <|r", enabled = false, value = 90, min = 1, max = 100, step = 1, key = "lifeboom" },
	{ type = "page", number = 4, text = "|cffa335eeНастройки диспелла|r" },
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(2782).." Диспелл проклятий только с  себя", tooltip = "Включает диспелл проклятий только с себя\n"..ni.spell.icon(2782, 14, 14).."[Снятие проклятия] ", enabled = false, key = "decurse_player" },
	{ type = "entry", text = ni.spell.icon(2893).." Диспелл ядов только с  себя", tooltip = "Включает диспелл ядов только с себя\n"..ni.spell.icon(2893, 14, 14).."[Устранение яда] ", enabled = false, key = "dispell_poison_player" },
	{ type = "entry", text = ni.spell.icon(2782).." Диспелл c союзников", tooltip = "Включает диспелл проклятий и ядов с союзников\n"..ni.spell.icon(2782, 14, 14).."[Снятие проклятия] "..ni.spell.icon(2893, 14, 14).."[Устранение яда]", enabled = false, key = "decurse" },
	{ type = "entry", text = "Диспеллить указанный дебафф", tooltip = " Для диспелла/игнорирования конкретного дебаффа \n вписать НАЗВАНИЕ \n |cffFF0D00Не ID! и нажать ENTER|r ", enabled = false, key = "decurse_2" },
	{
	type = "input",
	value = inputs["decursee"],
	width = 130,
	height = 20,
	key = "decursee"
	},
	{ type = "title", text = "Игнорировать указанный дебафф"},
	{
	type = "input",
	value = inputs["decurseee"],
	width = 130,
	height = 20,
	key = "decurseee"
	},
	{ type = "page", number = 5, text = "|cffFFFF00Настройки боя|r" },
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(48463).." Лунный огонь", tooltip = "Включает в ротацию\n"..ni.spell.icon(48463, 14, 14).."[Лунный огонь] ", enabled = false, key = "lunniy_ogon" },
	{ type = "entry", text = ni.spell.icon(48468).." Рой насекомых", tooltip = "Включает в ротацию\n"..ni.spell.icon(48468, 14, 14).."[Рой насекомых] ", enabled = false, key = "roy" },
	{ type = "entry", text = ni.spell.icon(48461).." Гнев", tooltip = "Включает в ротацию\n"..ni.spell.icon(48461, 14, 14).."[Гнев] ", enabled = false, key = "gnev" },
	{ type = "entry", text = ni.spell.icon(8983).." Оглушить", tooltip = "Использует " ..ni.spell.icon(8983, 14, 14).."[Оглушить] через макросс /bear "},
}
local ssspells = {
	oglush_udar = GetSpellInfo(12809),
	udar_volna = GetSpellInfo(46968),
	molot_prav = GetSpellInfo(10308),
	udar_pochki = GetSpellInfo(8643),
	podliy_truk = GetSpellInfo(1833),
	otgrizt = GetSpellInfo(47481),
	oglushit = GetSpellInfo(8983),
	grom_postup = GetSpellInfo(20549),
	neist_tmi = GetSpellInfo(30283),
	glub_zam = GetSpellInfo(58534),
	glub_uzas = GetSpellInfo(64058),
	oslep = GetSpellInfo(2094),
	haos = GetSpellInfo(59172),
	sedakt = GetSpellInfo(6358),
	skatter = GetSpellInfo(19503),
	usushenie = GetSpellInfo(47476),
	sap = GetSpellInfo(51724),
	viverna = GetSpellInfo(19386),
	pokayanie = GetSpellInfo(20066),
	coil = GetSpellInfo(47860),
	grip = GetSpellInfo(49576),
}
local ten_spells = {
	[ssspells.oslep] = true,
	[ssspells.haos] = true,
	[ssspells.sedakt] = true,
	[ssspells.skatter] = true,
	[ssspells.usushenie] = true,
	[ssspells.molot_prav] = true,
	[ssspells.pokayanie] = true,
	[ssspells.coil] = true,
	[ssspells.grip] = true,
}
local misha_spells = {
	[ssspells.molot_prav] = true,
	[ssspells.oglush_udar] = true,
	[ssspells.udar_volna] = true,
	[ssspells.podliy_truk] = true,
	[ssspells.otgrizt] = true,
	[ssspells.grom_postup] = true,
	[ssspells.neist_tmi] = true,
	[ssspells.glub_zam] = true,
	[ssspells.glub_uzas] = true,
}
local poison_spells = {
	[ssspells.viverna] = true,
}
local function CombatEventCatcher(event, ...)
    if enables["ten"] then
        if spellAvailable(58984) then
            if event == "COMBAT_LOG_EVENT_UNFILTERED" then
                local _, type, _, _, _, _, _, destFlags, _, spellName = ...
                if (type == "SPELL_CAST_SUCCESS")
                and bit.band(destFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) > 0 then
                    if ten_spells[spellName] then
                        spellCast(58984)
                    end
                end
            end
        end
    end
    if enables["misha"] then
        if spellAvailable(9634) then
            if event == "COMBAT_LOG_EVENT_UNFILTERED" then
                local _, type, _, _, _, _, _, destFlags, _, spellName = ...
                if (type == "SPELL_CAST_SUCCESS")
                and bit.band(destFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) > 0 then
                    if misha_spells[spellName] then
                        spellCast(9634)
                    end
                end
            end
        end
    end
	if enables["poison"] then
        if spellAvailable(2893) then
            if event == "COMBAT_LOG_EVENT_UNFILTERED" then
                local _, type, _, _, _, _, _, destFlags, _, spellName = ...
                if (type == "SPELL_CAST_SUCCESS")
                and bit.band(destFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) > 0 then
                    if poison_spells[spellName] then
                        spellCast(2893)
                    end
                end
            end
        end
    end
end
local function OnLoad()
	ni.combatlog.registerhandler("Restoration Druid WPvP", CombatEventCatcher);
	ni.GUI.AddFrame("Restoration Druid WPvP", items);
end;
local function OnUnLoad()  
	ni.combatlog.unregisterhandler("Restoration Druid WPvP");
	ni.GUI.DestroyFrame("Restoration Druid WPvP");
end;
local cache = {
	IsMoving = false,
	PlayerCombat = false,
	double = true,
	info = true,
	cast = true,
	bear = false,
	bear_form = false;
};
local spells = {
omolozenie = GetSpellInfo(48441),
enrage = GetSpellInfo(5229),
bash = GetSpellInfo(8983),
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
lifeboom = GetSpellInfo(48451),
life_prok = GetSpellInfo(16870),
dub = GetSpellInfo(22812),
fast_cast = GetSpellInfo(17116),
prikosnovenie = GetSpellInfo(48378),
vo = GetSpellInfo(770),
sova = GetSpellInfo(24858),
bearform = GetSpellInfo(9634),
warstomp = GetSpellInfo(20549),
hvatka = GetSpellInfo(53312),
smerch = GetSpellInfo(33786),
root = GetSpellInfo(53308),
son = GetSpellInfo(18658),
lapa = GetSpellInfo(770),
lunniy_ogon = GetSpellInfo(48463),
roy = GetSpellInfo(48468),
gnev = GetSpellInfo(48461),
buff = GetSpellInfo(48470),
reflect = GetSpellInfo(23920),
Innervate = GetSpellInfo(29166),
};
local queue = {
	"cache",
	"pause",
	"save",
	"pause2",
	"ns",
	"potion_hp",
	"potion_mp",
	"fast_cast",
	"warstomp",
	"reflect",
	"bear",
	"root",
	"smerch",
	"son",
	"lapa",
	"hvatka",
	"bv",
    "pokrovitelstvo",
	"derevo",
	"vostanovlenie",	
	"dispell_poison_player",
	"decurse_player",
	"dispell",
	"lifeboom",
	"ozarenie",
	"omolozenie_my",
	"lifeboom_o",
	"lifeboom_o_",
	"reshift",
	"buyniy_rost",
	"omolozenie",
	"heal_all",
	"pet_hill",
	"lifeboom_",
	"lifeboom__",
	"vost_",
	"vost__",
	"buff",
	"obodrenie",
	"gnev",
	"lunniy_ogon",
	"roy",
};
local abilities = {
--------------------------------------------------------------------------------
["cache"] = function()
	cache.PlayerCombat = UnitAffectingCombat("player") or false;
	cache.IsMoving = ni.player.ismoving() or false;
	if not cache.PlayerCombat then
		cache.cast = true
	end
	local spell = UnitCastingInfo("player")
	local gcd = {spells.root, spells.son, spells.smerch, spells.decurse_po, spells.lapa};
	for i = 1, #gcd do
		local spelll = gcd[i];
		if spell == (spelll) then
			cache.double = false
		elseif ni.spell.gcd() then
			cache.double = true
		end
	end
end,
--------------------------------------------------------------------------------
["pause"] = function()
	ni.vars.pause = 0.7;
	if IsMounted()
	or UnitInVehicle("player")
	or UnitIsDeadOrGhost("player")
	or UnitChannelInfo("player")
	or UnitCastingInfo("player")
	or ni.player.issilenced()
	or ni.player.buff(40120)
	or ni.player.islooting() then
		return true;
	end
	ni.vars.debug = enables["debug"];
end,
--------------------------------------------------------------------------------
["save"] = function()
	if not cache.PlayerCombat then
		return false;
	end
	if enables["ogur"] then
		local HealthStone, StoneID = ni.stuff.player_best_item(ni.stuff.health_stones);
		if ni.player.hp() < values.ogur then
			if ni.player.itemready(StoneID) then
				ni.player.useitem(HealthStone)
				return true;
			end
		end
	end
	if enables["dub_koza"] then
		if spellAvailable(spells.dub) then
			if ni.player.hp() < values.dub_koza then
				spellCast(spells.dub)
				return true;
			end
		end
	end
end,
--------------------------------------------------------------------------------
["potion_mp"] = function()
    if not enables["potion_mp"]
    or not cache.PlayerCombat then
        return false;
    end
	local ManaPot, ManaID = ni.stuff.player_best_item(ni.stuff.mana_potions);
    if ni.player.power() < values.potion_mp then
        if ni.player.itemready(ManaID) then
			ni.player.useitem(ManaPot)
			return true;
		end
    end
end,
--------------------------------------------------------------------------------
["potion_hp"] = function()
	if not enables["potion_hp"]
	or not cache.PlayerCombat then
		return false;
	end
    local HealPot, PotID = ni.stuff.player_best_item(ni.stuff.heal_potions);
    if ni.player.hp() < values.potion_hp then
        if ni.player.itemready(PotID) then
			ni.player.useitem(HealPot)
			return true;
		end
    end
end,
--------------------------------------------------------------------------------
["pause2"] = function()
	if ni.player.isstunned() then
		return true;
	end
end,
--------------------------------------------------------------------------------
["warstomp"] = function()
    if not enables["warstomp"]
    or cache.IsMoving
    or not cache.PlayerCombat
    or not spellAvailable(spells.warstomp) then
        return false;
    end
	local spellsToInterrupt = {
		[GetSpellInfo(48782)] = true,
	};    
	if not ni.spell.available(20549) then
		return false;
	end
	local enemies = ni.player.enemiesinrange(7.5);
	for i = 1, #enemies do
		local enemie = enemies[i].guid;
		if not ni.unit.isplayer(enemie) then
			return false;
		end
		if #enemie >= 1 then
			local castedSpell = UnitCastingInfo(enemie);
			local channeledSpell = UnitChannelInfo(enemie);
			if spellsToInterrupt[castedSpell]
			or spellsToInterrupt[channeledSpell] then
				spellCast(spells.warstomp)
				return true;
			end
		end
	end
end,
--------------------------------------------------------------------------------
["ns"] = function()
	if not cache.PlayerCombat then
		return false;
	end
	if not ni.spell.gcd() then
		local ns = { 137028, 103400, 137044, 50726, 50354 }
		for i = 1, #ns do
			local nss = ns[i];
			local startTime = GetItemCooldown(nss)
			local itemId1 = GetInventoryItemID("player", 13);
			local itemId2 = GetInventoryItemID("player", 14);
			if itemId1 == nss
			or itemId2 == nss then
				if startTime == 0 then
					if menus.ActionEvent == 2 then
						for i = 1, #ni.members do
							local ally = ni.members[i];
							if ni.unit.distance("player", ally.unit) < 40
							and ally:hp() < values.NS
							and ally:valid(spells.omolozenie, false, true) then
								ni.player.useitem(nss, ally.unit)
								return true;
							end
						end
				elseif ni.player.hp() < values.NS then
						ni.player.useitem(nss, "player")
						return true;
					end
				end
			end
		end
	end
end,
--------------------------------------------------------------------------------
["fast_cast"] = function()
	if not enables["fast_cast"]
	or not cache.PlayerCombat then
		return false;
	end
	if spellAvailable(spells.prikosnovenie) 
	and spellAvailable(spells.fast_cast)
	or spellAvailable(spells.prikosnovenie)
	and ni.player.buff(spells.fast_cast) then
		for i = 1, #ni.members.sort() do
			local ally = ni.members[i];
			if ally:hp() <= values.fast_cast
			and ally:valid(spells.prikosnovenie, false, true) then
				spellCast(spells.fast_cast)
				spellCast(spells.prikosnovenie, ally.unit)
				return true;
			end
		end
	end 
end,
--------------------------------------------------------------------------------
["dispell"] = function()
    if not enables["decurse"] 
	or not cache.PlayerCombat
	or not cache.double then
        return false;
    end
    if not spellAvailable(spells.decurse) then
        return false;
    end
    for i = 1, #ni.members do
        local ally = ni.members[i]
        if ally:dispel() then
            if ally:valid(spells.decurse, false, true) then
                if inputs.decursee ~= "" and ally:debuff(inputs.decursee) then
                    if ally:debufftype("Curse") then
                        spellCast(spells.decurse, ally.unit)
                        return true
                elseif ally:debufftype("Poison") 
					and not ally:buff(spells.decurse_po) then
                        spellCast(spells.decurse_po, ally.unit)
                        return true
                    end
            elseif inputs.decursee == "" and not ally:debuff(inputs.decurseee) then
                    if ally:debufftype("Curse") then
                        spellCast(spells.decurse, ally.unit)
                        return true;
                elseif ally:debufftype("Poison")
					and not ally:buff(spells.decurse_po) then
                        spellCast(spells.decurse_po, ally.unit)
                        return true;
                    end
                end
            end
        end
    end
    return false
end,
--------------------------------------------------------------------------------
["lifeboom"] = function()
	if not enables["lifeboom"] then
		return false;
	end
	if not ni.player.buff(spells.life_prok) then
		return false;
	end
	if spellAvailable(spells.lifeboom) then
		if ni.player.power(0) <= values.lifeboom then
			for i = 1, #ni.members do
				local ally = ni.members[i];
				if ally:valid(spells.lifeboom, false, true) then
					spellCast(spells.lifeboom, ally.unit)
					return true;
				end
			end
		end
	end 
end,
--------------------------------------------------------------------------------
["ozarenie"] = function()
	if not enables["ozarenie"]
	or not cache.PlayerCombat then
		return false;
	end
	if spellAvailable(spells.ozarenie) then
		if ni.player.power(0) <= values.ozarenie then
			spellCast(spells.ozarenie, "player")
			return true;
		end
	end
end,
--------------------------------------------------------------------------------
["derevo"] = function()
	if not enables["derevo"]
	or not cache.cast then
		return false;
	end
	if spellAvailable(spells.derevo) then
		if not ni.player.buff(spells.derevo, "player") then
			spellCast(spells.derevo)
			return true;
		end
	end
end,
--------------------------------------------------------------------------------
["lifeboom_o"] = function()
	if not enables["lifeboom_"] then
		return false;
	end
	if spellAvailable(spells.lifeboom) then
		if ni.unit.hp("player") > 70 then
			if ni.unit.buffremaining("player", spells.lifeboom, "player") < 2
			and ni.unit.buffstacks("player", spells.lifeboom) > 0 then
				spellCast(spells.lifeboom, "player")
				cache.cast = true
				return true;
			end
		end
	end
end,
--------------------------------------------------------------------------------
["lifeboom_o_"] = function()
    if not enables["lifeboom__"] then
        return false;
    end
    if spellAvailable(spells.lifeboom) then
        for i = 1, #ni.members do
            local ally = ni.members[i];
            local tar = ni.objects[ally.unit];
            if inputs.lifeboom__ == tar.name
            and ally:hp() > 70
            and ally:buffremaining(spells.lifeboom, "player") < 2 
            and ni.unit.buffstacks("player", spells.lifeboom) > 0 
            and ally:valid(spells.lifeboom, false, true) then
                spellCast(spells.lifeboom, ally.unit)
                cache.cast = true
                return true;
            end
        end
    end
end,
--------------------------------------------------------------------------------
["buyniy_rost"] = function()
    if not enables["buyniy_rost_value_hp"] then
       return false;
    end
    if spellAvailable(spells.buyniy_rost) then
        for i = 1, #ni.members do
            local ally = ni.members[i];
            local range = memberRangeBelow(ally.unit, 14, 99);
            local BuyniyRange = (values.buyniy_rost_value_range - 1);
            if ally:hp() <= values.buyniy_rost_value_hp
            and #range >= BuyniyRange
            and ally:valid(spells.buyniy_rost, false, true) then
                spellCast(spells.buyniy_rost, ally.unit)
                cache.cast = true
                return true;
            end
        end
    end
end,
--------------------------------------------------------------------------------
["bv"] = function()
	if not enables["bv_value_hp"] then
		return false;
	end
	if not spellAvailable(spells.bv) then
		return false;
	end
    for i = 1, #ni.members.sort() do
        local ally = ni.members[i]
        if ally:hp() <= values.bv_value_hp
		and ally:valid(spells.bv, false, true)
		and (ally:buff(spells.omolozenie)
		or ally:buff(spells.vostanovlenie)) then
            spellCast(spells.bv, ally.unit)
            cache.cast = true
            return true
        end
    end
    if enables["hill_vseh"] then
        local friends = ni.unit.friendsinrange("player", 40)
        for i = 1, #friends do
            local guid = friends[i].guid
            if ni.unit.hp(guid) <= values.bv_value_hp
			and spellAvailable(spells.bv)
			and ni.spell.valid(guid, spells.bv, false, true, true)
			and (ni.unit.buff(guid, spells.omolozenie)
			or ni.unit.buff(guid, spells.vostanovlenie)) then
                spellCast(spells.bv, guid)
                cache.cast = true
                return true
            end
        end
    end
    return false
end,
--------------------------------------------------------------------------------
["omolozenie"] = function()
	if not enables["omolozenie_value_hp"] then
		return false;
	end
	if spellAvailable(spells.omolozenie) then
		for i = 1, #ni.members.sort() do
			local ally = ni.members[i];
			if ally:hp() <= values.omolozenie_value_hp
			and not ally:buff(spells.omolozenie, "player")
			and ally:valid(spells.omolozenie, false, true, true) then
				spellCast(spells.omolozenie, ally.unit)
				cache.cast = true
				return true;
			end
		end
		if enables["hill_vseh"] then
			local friends = ni.unit.friendsinrange("player", 40)
			for i = 1, #friends do
				local guid = friends[i].guid
				if ni.unit.hp(guid) <= values.hill_vseh
				and not ni.unit.buff(guid, spells.omolozenie, "player")
				and ni.spell.valid(guid, spells.omolozenie, false, true, true) then
					spellCast(spells.omolozenie, guid)
					cache.cast = true
					return true;
				end
			end
		end
	end
end,
--------------------------------------------------------------------------------
["heal_all"] = function()
	if cache.IsMoving then
		return false;
	end
	if enables["hill_vseh"] then
		local friends = ni.unit.friendsinrange("player", 40)
		for i = 1, #friends do
			local guid = friends[i].guid
			if ni.unit.hp(guid) <= values.hill_vseh
			and ni.spell.valid(guid, spells.pp, false, true, true) then
				spellCast(spells.pp, guid)
				cache.cast = true
				return true;
			end
		end
	end
end,
--------------------------------------------------------------------------------
["pet_hill"] = function()
    if not enables["hill_pet"] or not cache.PlayerCombat then
        return false;
    end
    for i = 1, #ni.members do
        local ally = ni.members[i].unit;
        local creations = ni.unit.creations(ally);

        for j = 1, #creations do
            local pet = creations[j].guid;
            local pet_hp = ni.unit.hp(pet);

            if pet_hp <= values.hill_pet
			and spellAvailable(spells.omolozenie)
			and not ni.unit.buff(pet, spells.omolozenie, "player")
			and ni.spell.valid(pet, spells.omolozenie, false, true, true) then
                spellCast(spells.omolozenie, pet)
                cache.cast = true
                return true
        elseif not cache.IsMoving and pet_hp <= values.hill_pet
			and spellAvailable(spells.pp)
			and ni.spell.valid(pet, spells.pp, false, true, true) then
                spellCast(spells.pp, pet)
                cache.cast = true
                return true
            end
        end
    end
    return false
end,
--------------------------------------------------------------------------------
["lifeboom_"] = function()
    if not enables["lifeboom_"] then
        return false;
    end
    if spellAvailable(spells.lifeboom) then
        if ni.unit.buffstacks("player", spells.lifeboom) < values.lifeboom_ then
            spellCast(spells.lifeboom, "player")
            cache.cast = true
            return true;
        end
    end
end,
--------------------------------------------------------------------------------
["lifeboom__"] = function()
    if not enables["lifeboom__"] then
        return false;
    end
    if spellAvailable(spells.lifeboom) then
        for i = 1, #ni.members do
            local ally = ni.members[i];
            local tar = ni.objects[ally.unit];
            if inputs.lifeboom___ == tar.name
            and ally:buffstacks(spells.lifeboom, "player") < values.lifeboom_
            and ally:valid(spells.lifeboom, false, true, true) then
                spellCast(spells.lifeboom, ally.unit)
                cache.cast = true
                return true;
            end
        end
    end
end,
--------------------------------------------------------------------------------
["vost_"] = function()
    if not enables["vost_"]
    or cache.IsMoving
    or not cache.double then
        return false;
    end
    if spellAvailable(spells.vostanovlenie) then
		if ni.player.hp() < values.vost_
        and not ni.player.buff(spells.vostanovlenie, "player") then
            spellCast(spells.vostanovlenie, "player")
            cache.cast = true
            return true;
        end
    end
end,
--------------------------------------------------------------------------------
["vost__"] = function()
    if not enables["vost__"]
    or cache.IsMoving
    or not cache.double then
        return false;
    end
    if spellAvailable(spells.vostanovlenie) then
        for i = 1, #ni.members do
            local ally = ni.members[i];
            local tar = ni.objects[ally.unit];
            if inputs.vost___ == tar.name
            and not ally:buff(spells.vostanovlenie, "player")
            and ally:valid(spells.vostanovlenie, false, true, true) then
                spellCast(spells.vostanovlenie, ally.unit)
                cache.cast = true
                return true;
            end
        end
    end
end,
--------------------------------------------------------------------------------
["obodrenie"] = function()
    local meleeAlly, aoeAlly, friends
    if spellAvailable(spells.omolozenie) then
        for i = 1, #ni.members do
            local ally = ni.members[i]
            if ally:ismelee() then
                if not ally:buff(spells.omolozenie, "player")
				and ally:valid(spells.omolozenie, false, true, true) then
                    meleeAlly = ally.unit
                end
            elseif ni.vars.combat.aoe
			and not ally:buff(spells.omolozenie, "player")
			and ally:valid(spells.omolozenie, false, true, true) then
                aoeAlly = ally.unit
            end
        end
        if meleeAlly then
            spellCast(spells.omolozenie, meleeAlly)
            cache.cast = true
            return true
        elseif aoeAlly then
            spellCast(spells.omolozenie, aoeAlly)
            cache.cast = true
            return true
        elseif enables["hill_vseh"] and ni.vars.combat.aoe then
            friends = ni.unit.friendsinrange("player", 40)
            for i = 1, #friends do
                local guid = friends[i].guid
                if not ni.unit.buff(guid, spells.omolozenie, "player")
				and ni.spell.valid(guid, spells.omolozenie, false, true, true) then
                    spellCast(spells.omolozenie, guid)
                    cache.cast = true
                    return true
                end
            end
        end
    end
end,
--------------------------------------------------------------------------------
["reshift"] = function()
	if not enables["reshift"]
	or not cache.PlayerCombat then
		return false;
	end
	local Deb = "45524||53308||53312||42917||5116||2974||42931||17962||4167||55536||64804";
	if ni.player.debuffs(Deb)
	and ni.spell.available(spells.derevo) then
		spellCast(spells.derevo)
	end
end,
--------------------------------------------------------------------------------
["root"] = function()
	if not enables["root"]
    or not cache.double
    or not spellAvailable(spells.root) then
        return false;
	end
    if IsLeftShiftKeyDown() then
        if ni.unit.exists("mouseover")
        and ni.spell.valid("mouseover", spells.root, true, true)
		and debuffr("mouseover", spells.root, "player") < 1.25 then
            spellCast(spells.root, "mouseover")
            return true;
    	elseif ni.unit.exists("target")
		and debuffr("target", spells.root, "player") < 1.25 then
            spellCast(spells.root, "target")
            return true;
        end
    end
end,
--------------------------------------------------------------------------------
["smerch"] = function()
	if not enables["smerch"]
    or not cache.double
	or not spellAvailable(spells.smerch) then
		return false;
	end
	if IsLeftAltKeyDown() then
		if (ni.unit.exists("mouseover")
		and ni.spell.valid("mouseover", spells.smerch, true, true))
		and debuffr("mouseover", spells.smerch, "player") < 1.25 then
            spellCast(spells.smerch, "mouseover")
            return true;
        elseif ni.unit.exists("target")
		and debuffr("target", spells.smerch, "player") < 1.25 then
            spellCast(spells.smerch, "target")
            return true;
		end
	end
end,
--------------------------------------------------------------------------------
["son"] = function()
    if not enables["son"]
	or not cache.double
	or not spellAvailable(spells.son) then
        return false;
    end

    local mouseoverCreatureType = ni.unit.creaturetype("mouseover")
    local targetCreatureType = ni.unit.creaturetype("target")
    local mouseoverHasBuff = ni.unit.buffs("mouseover", 9634, 768, 783, 2645, 5487)
    local targetHasBuff = ni.unit.buffs("target", 9634, 768, 783, 2645, 5487)

    if IsLeftControlKeyDown() then
        if mouseoverCreatureType == 1
		or mouseoverHasBuff then
            if ni.unit.exists("mouseover")
			and ni.spell.valid("mouseover", spells.son, true, true)
			and debuffr("mouseover", spells.son, "player") < 1.25 then
                spellCast(spells.son, "mouseover")
                return true
            end
        elseif targetCreatureType == 1 or targetHasBuff then
            if ni.spell.valid("target", spells.son, true, true)
			and debuffr("target", spells.son, "player") < 1.25 then
                spellCast(spells.son, "target")
                return true
            end
        end
    end
    return false
end,
-------------------------------------------------------------------------------
["hvatka"] = function()
    if not enables["hvatka"]
    or not spellAvailable(spells.hvatka)
    or not cache.PlayerCombat then
        return false;
	end
	if spellAvailable(spells.hvatka)
    and (ni.player.inmelee("target") or ni.player.distance("target") < 6) then
        spellCast(spells.hvatka)
        return true;
    end
end,
--------------------------------------------------------------------------------
["lapa"] = function()
	if not enables["lapa"]
	or not cache.double
	or not spellAvailable(spells.lapa) then
		return false;
	end
	local _, class = UnitClass("target")
	if (class == "ROGUE" or ni.unit.buff("target", 768))
	and not debuff("target", spells.lapa)
	and ni.spell.valid("target", spells.lapa, true, true) then
		spellCast(spells.lapa, "target")
		return true;
	end
end,
--------------------------------------------------------------------------------
["lunniy_ogon"] = function()
	if not enables["lunniy_ogon"]
    or not cache.PlayerCombat then
        return false;
	end
    if spellAvailable(spells.lunniy_ogon) then
        if not debuff("target", spells.lunniy_ogon, "player")
	    and ni.spell.valid("target", spells.lunniy_ogon, false, true, true) then
		    spellCast(spells.lunniy_ogon, "target")
            cache.cast = false
            return true;
	    end
    end
end,
--------------------------------------------------------------------------------
["roy"] = function()
	if not enables["roy"]
    or not cache.PlayerCombat then
        return false;
	end
    if spellAvailable(spells.roy) then
	    if not debuff("target", spells.roy, "player")
	    and ni.spell.valid("target", spells.roy, false, true, true) then
		    spellCast(spells.roy, "target")
            cache.cast = false
            return true;
        end
	end
end,
--------------------------------------------------------------------------------
["gnev"] = function()
	if not enables["gnev"]
    or cache.IsMoving
	or not cache.PlayerCombat then
        return false;
	end	
	if spellAvailable(spells.gnev) then
        if ni.spell.valid("target", spells.gnev, false, true, true) then
            spellCast(spells.gnev, "target")
            cache.cast = false
		    return true;
        end
	end
end,
--------------------------------------------------------------------------------
["omolozenie_my"] = function()
    if not enables["omolozenie_my_value_hp"]
	or not cache.PlayerCombat  then
        return false;
    end
    if spellAvailable(spells.omolozenie) then
		if ni.player.hp() < values.omolozenie_my_value_hp
		and not ni.player.buff(spells.omolozenie, "player") then
            spellCast(spells.omolozenie, "player")
            cache.cast = true
            return true;
        end
    end
end,
--------------------------------------------------------------------------------
["buff"] = function()
    if not enables["buff"] then
		return false;
    end
	if not ni.player.buff(spells.buff)
	and ni.spell.available(spells.buff) then
		spellCast(spells.buff)
		return true;
	end
end,
-------------------------------------------------------------------------------- 
["pokrovitelstvo"] = function()
    if not enables["pokrov"]
    or cache.IsMoving
    or not cache.PlayerCombat then
        return false;
    end
	if spellAvailable(spells.pp) then
        for i = 1, #ni.members.sort() do
            local ally = ni.members[i];
            if ally:hp() <= values.pokrov
            and ally:valid(spells.pp, false, true) then
                spellCast(spells.pp, ally.unit)
				return true;
            end
        end
    end
end,
-------------------------------------------------------------------------------- 
["vostanovlenie"] = function()
    if not enables["vostanovlenie"]
    or cache.IsMoving
    or not cache.PlayerCombat then
        return false;
    end
	if spellAvailable(spells.vostanovlenie) then
        for i = 1, #ni.members.sort() do
            local ally = ni.members[i];
            if ally:hp() <= values.vostanovlenie
			and not ally:buff(spells.vostanovlenie, "player")
            and ally:valid(spells.vostanovlenie, false, true) then
                spellCast(spells.vostanovlenie, ally.unit)
				return true;
            end
        end
    end
end,
-------------------------------------------------------------------------------- 
["bear"] = function()
	ni.player.slashcmd("BEAR", function()
		cache.bear = true;
		cache.bear_form = true;
	end)
	if not cache.bear then
		return false;
	end
	if ni.player.buff(spells.bearform) then
		if ni.spell.available(spells.enrage) then
			spellCast(spells.enrage)
		end
		if ni.spell.available(spells.bash)
		and ni.spell.valid("target", spells.bash, true, true) then
			spellCast(spells.bash)
			cache.bear = false
			return true;
		end
	elseif cache.bear_form then
		spellCast(spells.bearform)
		cache.bear_form = false
	end
end,
-------------------------------------------------------------------------------- 
["reflect"] = function()
	if not enables["reflect"]
	or not spellAvailable(spells.lapa) then
		return false;
	end
	if ni.unit.buff("target", spells.reflect)
	and ni.spell.valid("target", spells.lapa, true, true) then
		spellCast(spells.lapa, "target")
		return true;
	end
end,
-------------------------------------------------------------------------------- 
["decurse_player"] = function()
	if not enables["decurse_player"] 
	or not cache.PlayerCombat then
		return false;
	end
	if not spellAvailable(spells.decurse) then
		return false;
	end
	if ni.player.debufftype("Curse")
		and ni.spell.available(spells.decurse) then
			spellCast(spells.decurse, "player")
		end
end,
-------------------------------------------------------------------------------- 
["dispell_poison_player"] = function()
	if not enables["dispell_poison_player"]
	or not cache.PlayerCombat
	or not cache.double then
		return false;
	end
	if not spellAvailable(spells.decurse_po) then
		return false;
	end
	if ni.player.debufftype("Poison")
	and ni.spell.available(spells.decurse_po)
	and not ni.player.buff(spells.decurse_po) then
		spellCast(spells.decurse_po, "player")
	end
end,
-------------------------------------------------------------------------------- 
};
ni.bootstrap.profile("Restoration Druid WPvP", queue, abilities, OnLoad, OnUnLoad);
