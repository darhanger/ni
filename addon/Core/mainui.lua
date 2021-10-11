local main_ui = {};

local Localization = {
	Assistant = "Rotation Assistant",
	Primary = "Select your primary rotation:",
	Secondary = "Select your secondary rotation:",
	Generic = "Select your generic rotation:",
	None = "None",
	Resource = "Resource Tracking Toggles",
	All = "All",
	Reload = "Reload after changing",
	Global = "toggle or global",
	GUI = "GUI Toggle:",
	PrimaryKey = "Primary Toggle:",
	SecondaryKey = "Secondary Toggle:",
	Generic = "Generic Toggle:",
	Interrupt = "Interrupt Toggle:",
	Follow = "Follow Unit & Toggle:",
	GlobalDev = "Global variable:",
	Dev = "Dev Tools:",
	ReloadDev = "Reload",
	Console = "Console",
	Contact = "Contact:",
	Rotation = "Rotation Settings",
	MainSettings = "Main Settings",
	ResourceTrack = "Resource Track",
	CreatureTrack = "Creature Track",
	Close = "Close",
	Lockpicking = "Lockpicking",
	Herbs = "Herbs",
	Minerals = "Minerals",
	DisarmTrap = "Disarm Trap",
	Open = "Open",
	Treasure = "Treasure",
	CloseTrack = "Close",
	ArmTrap = "Arm Trap",
	QuickOpen = "Quick Open",
	CalcifiedElvenGems = "Calcified Elven Gems",
	QuickClose = "Quick Close",
	OpenTinkering = "Open Tinkering",
	OpenKneeling = "Open Kneeling",
	OpenAttacking = "Open Attacking",
	Gahzridian = "Gahzridian",
	Blasting = "Blasting",
	PvPOpen = "PvP Open",
	PvPClose = "PvP Close",
	Fishing = "Fishing",
	Inscription = "Inscription",
	OpenFromVehicle = "Open From Vehicle",
	CreatureTrackingToggles = "Creature Tracking Toggles",
	Beasts = "Beasts",
	Dragons = "Dragons",
	Demons = "Demons",
	Elementals = "Elementals",
	Giants = "Giants",
	Undead = "Undead",
	Humanoids = "Humanoids",
	Critters = "Critters",
	Machines = "Machines",
	Slimes = "Uncategorized",
	Totem = "Totem",
	NonCombatPet = "Non Combat Pet",
	GasCloud = "Gas Cloud",
	Latency = "Latency ("..ni.vars.latency.." ms)",
	AreaofEffectToggle = "Area of Effect Toggle:",
	PauseRotationModifier = "Pause Rotation Modifier:",
	CDToggle = "CD Toggle:",
	CustomToggle = "Custom Toggle:",
	MainTankOverride = "Main Tank Override:",
	Enabled = "Enabled:",
	OffTankOverride = "Off Tank Override:",
	IsMelee = "Is Melee:",
}
if (GetLocale() == "ruRU") then
	Localization.Assistant = "Помощник для Ротации"
	Localization.Primary = "Выберите свою основную ротацию:"
	Localization.Secondary = "Выберите второстепенную ротацию:"
	Localization.Generic = "Выберите свою общую ротацию:"
	Localization.None = "Нету"
	Localization.Resource = "Отслеживания ресурсов"
	Localization.All = "Всех"
	Localization.Reload = "Перезагрузитe после изменения"
	Localization.Global = "кнопки или глобальной"
	Localization.GUI = "Кнопка меню:"
	Localization.PrimaryKey = "Кнопка для основной:"
	Localization.SecondaryKey = "Кнопка для второстепенной:"
	Localization.Generic = "Кнопка для общей:"
	Localization.Interrupt = "Кнопка для прерывания:"
	Localization.Follow = "Авто-Следование и кнопка:"
	Localization.GlobalDev = "Глобальная переменная:"
	Localization.Dev = "Опции разработчика:"
	Localization.ReloadDev = "Перезагрузка"
	Localization.Console = "Консоль"
	Localization.Contact = "Контакты:"
	Localization.Rotation = "Настройки Ротаций"
	Localization.MainSettings = "Настройки"
	Localization.ResourceTrack = "Поиск Ресурсов"
	Localization.CreatureTrack = "Поиск НПЦ"
	Localization.Close = "Закрыть"
	Localization.Lockpicking = "Вскрытие замков"
	Localization.Herbs = "Травы"
	Localization.Minerals = "Минералы"
	Localization.DisarmTrap = "Обезв. Ловушки"
	Localization.Open = "Открываемые"
	Localization.Treasure = "Сокровища"
	Localization.CloseTrack = "Закрытые"
	Localization.ArmTrap = "Заряж. Ловушки"
	Localization.QuickOpen = "Быстрое открытие"
	Localization.CalcifiedElvenGems = "Эльфийский камень"
	Localization.QuickClose = "Быстрое закрытие"
	Localization.OpenTinkering = "Откр. ремеслом"
	Localization.OpenKneeling = "Открытие /kneel"
	Localization.OpenAttacking = "Открытие атакой"
	Localization.Gahzridian = "Газ'рилл"
	Localization.Blasting = "Взрываемое"
	Localization.PvPOpen = "Открытие в PvP"	
	Localization.PvPClose = "Закрытие в PvP"
	Localization.Fishing = "Рыбная ловля"
	Localization.Inscription = "Начертание"
	Localization.OpenFromVehicle = "Открытие с транс."
	Localization.CreatureTrackingToggles = "Поиск НПЦ"
	Localization.Beasts = "Звери"
	Localization.Dragons = "Драконы"
	Localization.Demons = "Демоны"
	Localization.Elementals = "Элементали"
	Localization.Giants = "Великаны"
	Localization.Undead = "Нежить"
	Localization.Humanoids = "Гуманоиды"
	Localization.Critters = "Существа"
	Localization.Machines = "Механизмы"
	Localization.Slimes = "Разное"
	Localization.Totem = "Тотемы"
	Localization.NonCombatPet = "Спутник"
	Localization.GasCloud = "Облако газа"
	Localization.Latency = "Задержка ("..ni.vars.latency.." мс)"
	Localization.AreaofEffectToggle = "Кнопка включения АоЕ:"
	Localization.PauseRotationModifier = "Кнопка для паузы ротации:"
	Localization.CDToggle = "Кнопка включения КД:"
	Localization.CustomToggle = "Настраиваемая Кнопка:"
	Localization.MainTankOverride = "Имя главного танка:"
	Localization.Enabled = "Включить:"
	Localization.OffTankOverride = "Имя второго танка:"
	Localization.IsMelee = "Ближний бой:"
end

local ui = {
	icon = {
		x = 75.70,
		y = -6.63
	},
	main = {
		point = "CENTER",
		relativePoint = "CENTER",
		x = 300,
		y = 180
	}
}

if ni.vars.ui then
	ui = ni.vars.ui;
else
	ni.vars.ui = ui;
end

local function moveIcon(self)
	local centerX, centerY = Minimap:GetCenter();
	local x, y = GetCursorPosition();
	x, y = x / self:GetEffectiveScale() - centerX, y / self:GetEffectiveScale() - centerY;
	centerX, centerY = math.abs(x), math.abs(y);
	centerX, centerY = (centerX / math.sqrt(centerX^2 + centerY^2)) * 76, (centerY / math.sqrt(centerX^2 + centerY^2)) * 76
	centerX = x < 0 and -centerX or centerX;
	centerY = y < 0 and -centerY or centerY;
	self:ClearAllPoints();
	self:SetPoint("CENTER", centerX, centerY);
	ni.vars.ui.icon.x = centerX;
	ni.vars.ui.icon.y = centerY;
end

local uiScale = GetCVar("uiScale") or 1;
local backdrop = {
	bgFile = "Interface/DialogFrame/UI-DialogBox-Background", 
	edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
	tile = true, tileSize = 16, edgeSize = 18, 
	insets = { left = 4, right = 4, top = 4, bottom = 4 }
};

main_ui.main = CreateFrame("frame", nil, UIParent);
local frame = main_ui.main;
frame:ClearAllPoints();
frame:SetMovable(true);
frame:EnableMouse(true);
frame:SetFrameStrata("HIGH");
frame:RegisterForDrag("LeftButton");
frame:SetScript("OnMouseDown", function(self) self:StartMoving() end);
frame:SetScript("OnMouseUp", function()
    local point, _, relativePoint, offset_x, offset_y = frame:GetPoint();
    ni.vars.ui.main.point = point;
    ni.vars.ui.main.relativePoint = relativePoint;
    ni.vars.ui.main.x = offset_x;
    ni.vars.ui.main.y = offset_y;
    frame:StopMovingOrSizing();
end);
frame:SetWidth(320);
frame:SetHeight(230);
frame:SetBackdrop(backdrop);
frame:SetPoint(ni.vars.ui.main.point, WorldFrame, ni.vars.ui.main.relativePoint, ni.vars.ui.main.x, ni.vars.ui.main.y);
frame:SetBackdropColor(0,0,0,1);
frame:Hide();

local function CreateText(frame, settext, offset_x, offset_y, r, g, b, a)
	local text = CreateFrame("frame", nil, frame);
	text:ClearAllPoints();
	text:SetHeight(20);
	text:SetWidth(200);
	text:SetPoint("TOP", frame, offset_x, offset_y);
	text.text = text:CreateFontString(nil, "BACKGROUND", "GameFontNormal");
	text.text:SetAllPoints();
	text.text:SetJustifyH("CENTER");
	text.text:SetJustifyV("MIDDLE");
	local pad = ""
	for i= 1, math.random(1,255) do pad = pad .. "\124r" end
	text.text:SetText(pad .. settext);
	text.text:SetTextColor(r, g, b, a);
	return text;
end

local title = CreateText(frame, Localization.Assistant, 0, -5, 0.2, 0.7, 1, 1);
local primary_text = CreateText(frame, Localization.Primary, 0, -18, 0.1, 0.5, 0.8, 1);
local secondary_text = CreateText(frame, Localization.Secondary, 0, -63, 0.1, 0.5, 0.8, 1);
local generic_text = CreateText(frame, Localization.Generic, 0, -108, 0.1, 0.5, 0.8, 1);

local function GetFilename(file)
	return file:match("^.*\\(.*).lua$") or file:match("^.*\\(.*).enc$") or file:match("^.*\\(.*).out$") or file
end

local profiles = ni.functions.getprofilesfor(select(2, UnitClass("player"))) or { };
tinsert(profiles, 1, Localization.None);
local generic_profiles = ni.functions.getprofilesfor("Generic") or { };
tinsert(generic_profiles, 1, Localization.None);

local ddm_name = ni.utils.GenerateRandomName();
local dropdownmenu = CreateFrame("frame", ddm_name, frame, "UIDropDownMenuTemplate");
dropdownmenu:ClearAllPoints();
dropdownmenu:SetPoint("TOP", 0, -36);
dropdownmenu:Show();
local primary = Localization.None;
local primaryIndex = 1;
UIDropDownMenu_Initialize(dropdownmenu, function(self, level)
	local info = UIDropDownMenu_CreateInfo();
	local index = 0;
	for k, v in ipairs(profiles) do
		index = index + 1;
		local file = GetFilename(v);
		local checked = false;
		if ni.vars.profiles.primary == file then
			primary = file;
			primaryIndex = index;
			checked = true;
		end
		info.text = file;
		info.value = file;
		info.checked = checked;
		info.func = function(self)
			UIDropDownMenu_SetSelectedID(dropdownmenu, self:GetID());
			ni.vars.profiles.primary = self:GetText();
		end;
		UIDropDownMenu_AddButton(info, level);
	end
end)
UIDropDownMenu_SetWidth(dropdownmenu, 150);
UIDropDownMenu_SetButtonWidth(dropdownmenu, 174);
UIDropDownMenu_JustifyText(dropdownmenu, "CENTER");	
UIDropDownMenu_SetSelectedID(dropdownmenu, primaryIndex);
UIDropDownMenu_SetText(dropdownmenu, primary);

local ddm2_name = ni.utils.GenerateRandomName();
local dropdownmenu2 = CreateFrame("frame", ddm2_name, frame, "UIDropDownMenuTemplate");
dropdownmenu2:ClearAllPoints();
dropdownmenu2:SetPoint("TOP", 0, -81);
dropdownmenu2:Show();
local secondary = Localization.None;
local secondaryIndex = 1;
UIDropDownMenu_Initialize(dropdownmenu2, function(self, level)
	local info = UIDropDownMenu_CreateInfo();
	local index = 0;
	for k, v in ipairs(profiles) do
		index = index + 1;
		local file = GetFilename(v);
		local checked = false;
		if ni.vars.profiles.secondary == file then
			secondary = file;
			secondaryIndex = index;
			checked = true;
		end
		info.text = file;
		info.value = file;
		info.checked = checked;
		info.func = function(self)
			UIDropDownMenu_SetSelectedID(dropdownmenu2, self:GetID());
			ni.vars.profiles.secondary = self:GetText();
		end;
		UIDropDownMenu_AddButton(info, level);
	end
end)
UIDropDownMenu_SetWidth(dropdownmenu2, 150);
UIDropDownMenu_SetButtonWidth(dropdownmenu2, 174);
UIDropDownMenu_JustifyText(dropdownmenu2, "CENTER");	
UIDropDownMenu_SetSelectedID(dropdownmenu2, secondaryIndex);
UIDropDownMenu_SetText(dropdownmenu2, secondary);

local ddm3_name = ni.utils.GenerateRandomName();
local dropdownmenu3 = CreateFrame("frame", ddm3_name, frame, "UIDropDownMenuTemplate");
dropdownmenu3:ClearAllPoints();
dropdownmenu3:SetPoint("TOP", 0, -126);
dropdownmenu3:Show();
local generic = Localization.None;
local genericIndex = 1;
UIDropDownMenu_Initialize(dropdownmenu3, function(self, level)
	local info = UIDropDownMenu_CreateInfo();
	local index = 0;
	for k, v in ipairs(generic_profiles) do
		index = index + 1;
		local file = GetFilename(v);
		local checked = false;
		if ni.vars.profiles.generic == file then
			generic = file;
			genericIndex = index;
			checked = true;
		end
		info.text = file;
		info.value = file;
		info.checked = checked;
		info.func = function(self)
			UIDropDownMenu_SetSelectedID(dropdownmenu3, self:GetID());
			ni.vars.profiles.generic = self:GetText();
		end;
		UIDropDownMenu_AddButton(info, level);
	end
end)
UIDropDownMenu_SetWidth(dropdownmenu3, 150);
UIDropDownMenu_SetButtonWidth(dropdownmenu3, 215);
UIDropDownMenu_JustifyText(dropdownmenu3, "CENTER");	
UIDropDownMenu_SetSelectedID(dropdownmenu3, genericIndex);
UIDropDownMenu_SetText(dropdownmenu3, generic);

local mainsettings = CreateFrame("frame", nil, frame);
mainsettings:ClearAllPoints();
mainsettings:SetWidth(220);
mainsettings:SetHeight(460);
mainsettings:SetPoint("TOPRIGHT", frame, 215, 0);
mainsettings:SetBackdrop(backdrop);
mainsettings:EnableMouse(true);
mainsettings:SetBackdropColor(0,0,0,1);
mainsettings:Hide();

local settings = CreateFrame("frame", nil, frame);
settings:ClearAllPoints();
settings:SetWidth(200);
settings:SetHeight(365);
settings:SetPoint("TOPLEFT", frame, -195, 0);
settings:SetBackdrop(backdrop);
settings:EnableMouse(true);
settings:SetBackdropColor(0,0,0,1);
settings:Hide();

local resourcesettings = CreateFrame("frame", nil, frame);
resourcesettings:ClearAllPoints();
resourcesettings:SetWidth(320);
resourcesettings:SetHeight(280);
resourcesettings:SetPoint("BOTTOM", frame, 0, -275);
resourcesettings:SetBackdrop(backdrop);
resourcesettings:EnableMouse(true);
resourcesettings:SetBackdropColor(0, 0, 0, 1);
resourcesettings:Hide();

local creaturesettings = CreateFrame("frame", nil, frame);
creaturesettings:ClearAllPoints();
creaturesettings:SetWidth(320);
creaturesettings:SetHeight(200);
creaturesettings:SetPoint("BOTTOM", frame, 0, -195);
creaturesettings:SetBackdrop(backdrop);
creaturesettings:EnableMouse(true);
creaturesettings:SetBackdropColor(0, 0, 0, 1);
creaturesettings:Hide();

local function CreateMainButton(frame, width, height, text, offset_x, offset_y, func)
	local button = CreateFrame("BUTTON", nil, frame, "UIPanelButtonTemplate");
	button:SetWidth(width);
	button:SetHeight(height);
	button:SetText(text);
	button:SetPoint("BOTTOM", frame, offset_x, offset_y);
	button:SetAlpha(1);
	button:SetScript("OnClick", func);
	return button;
end

CreateMainButton(frame, 137, 22, Localization.Rotation, -68, 51, function()
	if settings:IsShown() then
		settings:Hide();
	else
		settings:Show();
	end
end);
CreateMainButton(frame, 137, 22, Localization.MainSettings, 68, 51, function()
	if mainsettings:IsShown() then
		mainsettings:Hide();
	else
		mainsettings:Show();
	end
end);
CreateMainButton(frame, 137, 22, Localization.ResourceTrack, -68, 28, function()
	if resourcesettings:IsShown() then
		resourcesettings:Hide();
	else
		if creaturesettings:IsShown() then
			creaturesettings:Hide();
		end
		resourcesettings:Show();
	end
end);
CreateMainButton(frame, 137, 22, Localization.CreatureTrack, 68, 28, function()
	if creaturesettings:IsShown() then
		creaturesettings:Hide();
	else
		if resourcesettings:IsShown() then
			resourcesettings:Hide();
		end
		creaturesettings:Show();
	end
end);
CreateMainButton(frame, 62, 22, Localization.Close, 0, 5, function()
	if frame:IsShown() then
		frame:Hide();
	end
end);

local function CreateDropDownText(frame, settext, offset_x, offset_y, position)
	position = position or "CENTER";
	local text = CreateFrame("frame", nil, frame);
	text:ClearAllPoints();
	text:SetHeight(20);
	text:SetWidth(200);
	text:SetPoint("TOP", frame, offset_x, offset_y);
	text.text = text:CreateFontString(nil, "BACKGROUND", "GameFontNormal");
	text.text:SetAllPoints();
	text.text:SetJustifyH(position);
	text.text:SetJustifyV("MIDDLE");
	text.text:SetText(settext);
	return text;
end

local function CreateKeyDropDown(frame, keys, offset_x, offset_y, var)
	local name = ni.utils.GenerateRandomName();
	local dropdown = CreateFrame("frame", name, frame, "UIDropDownMenuTemplate");
	dropdown:ClearAllPoints();
	dropdown:SetPoint("TOP", frame, offset_x, offset_y);
	dropdown:Show();
	local set = Localization.None;
	local setIndex = 1;
	UIDropDownMenu_Initialize(dropdown, function(self, level)
		local info = UIDropDownMenu_CreateInfo();
		local index = 0;
		for k, v in pairs(keys) do
			index = index + 1;
			local checked = false;
			if ni.vars.hotkeys[var] == v then
				set = v;
				setIndex = index;
				checked = true;
			end
			info.text = v;
			info.value = v;
			info.checked = checked;
			info.func = function(self)
				UIDropDownMenu_SetSelectedID(dropdown, self:GetID());
				ni.vars.hotkeys[var] = self:GetText();
			end
			UIDropDownMenu_AddButton(info, level);
		end
	end);
	UIDropDownMenu_SetWidth(dropdown, 100);
	UIDropDownMenu_SetButtonWidth(dropdown, 124);
	UIDropDownMenu_JustifyText(dropdown, "CENTER");
	UIDropDownMenu_SetSelectedID(dropdown, setIndex);
	UIDropDownMenu_SetText(dropdown, set);
	return dropdown
end

local function CreateEditBox(frame, offset_x, offset_y, var)
	local edit = CreateFrame("EditBox", nil, frame);
	edit:SetHeight(20)
	edit:SetWidth(124);
	edit:SetPoint("TOP", frame, offset_x, offset_y)
	edit:SetFontObject("GameFontHighlight");
	edit:SetAutoFocus(false);
	edit:SetJustifyH("CENTER");
	edit:SetJustifyV("CENTER");
	edit:EnableMouse(true);
	edit:SetBackdrop({
		bgFile = "Interface/Buttons/WHITE8X8",
		edgeFile = "Interface/Buttons/WHITE8X8",
		edgeSize = 1,
	});
	edit:SetBackdropColor(0,0,0,0.5);
	edit:SetBackdropBorderColor(0.8, 0.8, 0.8, 0.5);
	edit:SetScript("OnEnterPressed", function(self)
		ni.vars.units[var] = self:GetText() or "";
		self:ClearFocus();
	end);
	edit:SetScript("OnEscapePressed", function(self)
		self:SetText(ni.vars.units[var]);
		self:ClearFocus();
	end);
	edit:SetText(ni.vars.units[var]);
	edit:Show();
	return edit;
end

local function CreateCheckBox(frame, offset_x, offset_y, checked, func, value)
	local check = CreateFrame("CheckButton", nil, frame, "OptionsBaseCheckButtonTemplate");
	check:SetPoint("TOP", offset_x, offset_y);
	check:SetSize(26, 26);
	check:SetChecked(checked);
	check:SetHitRectInsets(0,0,0,0);
	check:SetScript("OnClick", function(self)
		func(self);
	end);
	check.value = value;
	return check;
end

local bitwise = {};
function bitwise.hasbit(x, p)
	return x % (p + p) >= p;
end

function bitwise.setbit(x, p)
	return bitwise.hasbit(x, p) and x or x + p;
end

function bitwise.clearbit(x, p)
	return bitwise.hasbit(x, p) and x - p or x;
end

--Resource tracking menu
CreateText(resourcesettings, Localization.Resource, 0, -5, 0.2, 0.7, 1, 1);
local currentresources = 0;
local boxes = {
	resource_none,
	resource_all,
	resource_lockpicking,
	resource_herbs,
	resource_minerals,
	resource_disarmtrap,
	resource_open,
	resource_treasure,
	resource_calcifiedelvengems,
	resource_close,
	resource_armtrap,
	resource_quickopen,
	resource_quickclose,
	resource_opentinkering,
	resource_openkneeling,
	resource_openattacking,
	resource_gahzridian,
	resource_blasting,
	resource_pvpopen,
	resource_pvpclose,
	resource_fishing,
	resource_inscription,
	resource_openfromvehicle
}
local function update_boxes(c_bit)
	for k, v in pairs(boxes) do
		if c_bit == -1 and v.value ~= 0 then
			v:SetChecked(true);
		elseif c_bit == 0 and v.value == 0 then
			v:SetChecked(true);
		elseif v.value ~= -1 and bitwise.hasbit(c_bit, v.value) then
			v:SetChecked(true);
		else
			v:SetChecked(false);
		end
	end
	ni.functions.setresourcetracking(c_bit);
end
local function checkbox_clicked(self)
	if self:GetChecked() then
		currentresources = bitwise.setbit(currentresources, self.value);
	else
		currentresources = bitwise.clearbit(currentresources, self.value);
	end
	update_boxes(currentresources);
end

CreateDropDownText(resourcesettings, Localization.None, -15, -27, "LEFT")
boxes.resource_none = CreateCheckBox(resourcesettings, -130, -25, currentresources == 0, function(self)
	if self:GetChecked() then
		currentresources = 0;
	end
	update_boxes(currentresources);
end, 0);
CreateDropDownText(resourcesettings, Localization.All, -15, -47, "LEFT")
boxes.resource_all = CreateCheckBox(resourcesettings, -130, -45, currentresources == -1, function(self)
	if self:GetChecked() then
		currentresources = -1;
	else
		currentresources = 0;
	end
	update_boxes(currentresources);
end, -1);
CreateDropDownText(resourcesettings, Localization.Lockpicking, -15, -67, "LEFT")
boxes.resource_lockpicking = CreateCheckBox(resourcesettings, -130, -65, bitwise.hasbit(currentresources, 0x1), checkbox_clicked, 0x1);
CreateDropDownText(resourcesettings, Localization.Herbs, -15, -87, "LEFT")
boxes.resource_herbs = CreateCheckBox(resourcesettings, -130, -85, bitwise.hasbit(currentresources, 0x2), checkbox_clicked, 0x2);
CreateDropDownText(resourcesettings, Localization.Minerals, -15, -107, "LEFT")
boxes.resource_minerals = CreateCheckBox(resourcesettings, -130, -105, bitwise.hasbit(currentresources, 0x4), checkbox_clicked, 0x4);
CreateDropDownText(resourcesettings, Localization.DisarmTrap, -15, -127, "LEFT")
boxes.resource_disarmtrap = CreateCheckBox(resourcesettings, -130, -125, bitwise.hasbit(currentresources, 0x8), checkbox_clicked, 0x8);
CreateDropDownText(resourcesettings, Localization.Open, -15, -147, "LEFT")
boxes.resource_open = CreateCheckBox(resourcesettings, -130, -145, bitwise.hasbit(currentresources, 0x10), checkbox_clicked, 0x10);
CreateDropDownText(resourcesettings, Localization.Treasure, -15, -167, "LEFT")
boxes.resource_treasure = CreateCheckBox(resourcesettings, -130, -165, bitwise.hasbit(currentresources, 0x20), checkbox_clicked, 0x20);
CreateDropDownText(resourcesettings, Localization.CloseTrack, -15, -187, "LEFT")
boxes.resource_close = CreateCheckBox(resourcesettings, -130, -185, bitwise.hasbit(currentresources, 0x80), checkbox_clicked, 0x80);
CreateDropDownText(resourcesettings, Localization.ArmTrap, -15, -207, "LEFT")
boxes.resource_armtrap = CreateCheckBox(resourcesettings, -130, -205, bitwise.hasbit(currentresources, 0x100), checkbox_clicked, 0x100);
CreateDropDownText(resourcesettings, Localization.QuickOpen, -15, -227, "LEFT")
boxes.resource_quickopen = CreateCheckBox(resourcesettings, -130, -225, bitwise.hasbit(currentresources, 0x200), checkbox_clicked, 0x200);
CreateDropDownText(resourcesettings, Localization.CalcifiedElvenGems, -15, -247, "LEFT")
boxes.resource_calcifiedelvengems = CreateCheckBox(resourcesettings, -130, -245, bitwise.hasbit(currentresources, 0x40), checkbox_clicked, 0x40);
CreateDropDownText(resourcesettings, Localization.QuickClose, 130, -27, "LEFT")
boxes.resource_quickclose = CreateCheckBox(resourcesettings, 15, -25, bitwise.hasbit(currentresources, 0x400), checkbox_clicked, 0x400);
CreateDropDownText(resourcesettings, Localization.OpenTinkering, 130, -47, "LEFT")
boxes.resource_opentinkering = CreateCheckBox(resourcesettings, 15, -45, bitwise.hasbit(currentresources, 0x800), checkbox_clicked, 0x800);
CreateDropDownText(resourcesettings, Localization.OpenKneeling, 130, -67, "LEFT")
boxes.resource_openkneeling = CreateCheckBox(resourcesettings, 15, -65, bitwise.hasbit(currentresources, 0x1000), checkbox_clicked, 0x1000);
CreateDropDownText(resourcesettings, Localization.OpenAttacking, 130, -87, "LEFT")
boxes.resource_openattacking = CreateCheckBox(resourcesettings, 15, -85, bitwise.hasbit(currentresources, 0x2000), checkbox_clicked, 0x2000);
CreateDropDownText(resourcesettings, Localization.Gahzridian, 130, -107, "LEFT")
boxes.resource_gahzridian = CreateCheckBox(resourcesettings, 15, -105, bitwise.hasbit(currentresources, 0x4000), checkbox_clicked, 0x4000);
CreateDropDownText(resourcesettings, Localization.Blasting, 130, -127, "LEFT")
boxes.resource_blasting = CreateCheckBox(resourcesettings, 15, -125, bitwise.hasbit(currentresources, 0x8000), checkbox_clicked, 0x8000);
CreateDropDownText(resourcesettings, Localization.PvPOpen, 130, -147, "LEFT")
boxes.resource_pvpopen = CreateCheckBox(resourcesettings, 15, -145, bitwise.hasbit(currentresources, 0x10000), checkbox_clicked, 0x10000);
CreateDropDownText(resourcesettings, Localization.PvPClose, 130, -167, "LEFT")
boxes.resource_pvpclose = CreateCheckBox(resourcesettings, 15, -165, bitwise.hasbit(currentresources, 0x20000), checkbox_clicked, 0x20000);
CreateDropDownText(resourcesettings, Localization.Fishing, 130, -187, "LEFT")
boxes.resource_fishing = CreateCheckBox(resourcesettings, 15, -185, bitwise.hasbit(currentresources, 0x40000), checkbox_clicked, 0x40000);
CreateDropDownText(resourcesettings, Localization.Inscription, 130, -207, "LEFT")
boxes.resource_inscription = CreateCheckBox(resourcesettings, 15, -205, bitwise.hasbit(currentresources, 0x80000), checkbox_clicked, 0x80000);
CreateDropDownText(resourcesettings, Localization.OpenFromVehicle, 130, -227, "LEFT")
boxes.resource_openfromvehicle = CreateCheckBox(resourcesettings, 15, -225, bitwise.hasbit(currentresources, 0x100000), checkbox_clicked, 0x100000);

--Creature tracking menu
CreateText(creaturesettings, Localization.CreatureTrackingToggles, 0, -5, 0.2, 0.7, 1, 1);
local cboxes = {
	none,
	beasts,
	dragons,
	demons,
	elementals,
	giants,
	undead,
	humanoids,
	critters,
	machines,
	slimes,
	totem,
	noncombatpet,
	gascloud,
	all
}
local currentcreatures = 0;
local function update_cboxes(c_bit)
	for k, v in pairs(cboxes) do
		if c_bit == -1 and v.value ~= 0 then
			v:SetChecked(true);
		elseif c_bit == 0 and v.value == 0 then
			v:SetChecked(true);
		elseif v.value ~= -1 and bitwise.hasbit(c_bit, v.value) then
			v:SetChecked(true);
		else
			v:SetChecked(false);
		end
	end
	ni.functions.setcreaturetracking(c_bit);
end
local function checkbox_clickedc(self)
	if self:GetChecked() then
		currentcreatures = bitwise.setbit(currentcreatures, self.value);
	else
		currentcreatures = bitwise.clearbit(currentcreatures, self.value);
	end
	update_cboxes(currentcreatures);
end
CreateDropDownText(creaturesettings, Localization.None, 8, -27, "LEFT")
cboxes.none = CreateCheckBox(creaturesettings, -104, -25, currentcreatures == 0, function(self)
	if self:GetChecked() then
		currentcreatures = 0;
	end
	update_cboxes(currentcreatures);
end, 0);
CreateDropDownText(creaturesettings, Localization.All, 8, -47, "LEFT")
cboxes.all = CreateCheckBox(creaturesettings, -104, -45, currentcreatures == -1, function(self)
	if self:GetChecked() then
		currentcreatures = -1;
	else
		currentcreatures = 0;
	end
	update_cboxes(currentcreatures);
end, -1);
CreateDropDownText(creaturesettings, Localization.Beasts, 8, -67, "LEFT")
cboxes.beasts = CreateCheckBox(creaturesettings, -104, -65, bitwise.hasbit(currentcreatures, 0x1), checkbox_clickedc, 0x1);
CreateDropDownText(creaturesettings, Localization.Dragons, 8, -87, "LEFT")
cboxes.dragons = CreateCheckBox(creaturesettings, -104, -85, bitwise.hasbit(currentcreatures, 0x2), checkbox_clickedc, 0x2);
CreateDropDownText(creaturesettings, Localization.Demons, 8, -107, "LEFT")
cboxes.demons = CreateCheckBox(creaturesettings, -104, -105, bitwise.hasbit(currentcreatures, 0x4), checkbox_clickedc, 0x4);
CreateDropDownText(creaturesettings, Localization.Elementals, 8, -127, "LEFT")
cboxes.elementals = CreateCheckBox(creaturesettings, -104, -125, bitwise.hasbit(currentcreatures, 0x8), checkbox_clickedc, 0x8);
CreateDropDownText(creaturesettings, Localization.Giants, 8, -147, "LEFT")
cboxes.giants = CreateCheckBox(creaturesettings, -104, -145, bitwise.hasbit(currentcreatures, 0x10), checkbox_clickedc, 0x10);
CreateDropDownText(creaturesettings, Localization.Undead, 8, -167, "LEFT")
cboxes.undead = CreateCheckBox(creaturesettings, -104, -165, bitwise.hasbit(currentcreatures, 0x20), checkbox_clickedc, 0x20);
CreateDropDownText(creaturesettings, Localization.Humanoids, 110, -27, "LEFT")
cboxes.humanoids = CreateCheckBox(creaturesettings, -2, -25, bitwise.hasbit(currentcreatures, 0x40), checkbox_clickedc, 0x40);
CreateDropDownText(creaturesettings, Localization.Critters, 110, -47, "LEFT")
cboxes.critters = CreateCheckBox(creaturesettings, -2, -45, bitwise.hasbit(currentcreatures, 0x80), checkbox_clickedc, 0x80);
CreateDropDownText(creaturesettings, Localization.Machines, 110, -67, "LEFT")
cboxes.machines = CreateCheckBox(creaturesettings, -2, -65, bitwise.hasbit(currentcreatures, 0x100), checkbox_clickedc, 0x100);
CreateDropDownText(creaturesettings, Localization.Slimes, 110, -87, "LEFT")
cboxes.slimes = CreateCheckBox(creaturesettings, -2, -85, bitwise.hasbit(currentcreatures, 0x200), checkbox_clickedc, 0x200);
CreateDropDownText(creaturesettings, Localization.Totem, 110, -107, "LEFT")
cboxes.totem = CreateCheckBox(creaturesettings, -2, -105, bitwise.hasbit(currentcreatures, 0x400), checkbox_clickedc, 0x400);
CreateDropDownText(creaturesettings, Localization.NonCombatPet, 110, -127, "LEFT")
cboxes.noncombatpet = CreateCheckBox(creaturesettings, -2, -125, bitwise.hasbit(currentcreatures, 0x800), checkbox_clickedc, 0x800);
CreateDropDownText(creaturesettings, Localization.GasCloud, 110, -147, "LEFT")
cboxes.gascloud = CreateCheckBox(creaturesettings, -2, -145, bitwise.hasbit(currentcreatures, 0x1000), checkbox_clickedc, 0x1000);

--Main Settings drop downs
local keys = {
	Localization.None,
	"F1",
	"F2",
	"F3",
	"F4",
	"F5",
	"F6",
	"F7",
	"F8",
	"F9",
	"F10",
	"F11",
	"F12"
}
CreateText(mainsettings, Localization.Reload, 0, -5, 0.8, 0.1, 0.1, 1);
CreateText(mainsettings, Localization.Global, 0, -20, 0.8, 0.1, 0.1, 1);

CreateDropDownText(mainsettings, Localization.GUI, 0, -40);
CreateKeyDropDown(mainsettings, keys, 0, -60, "gui");

CreateDropDownText(mainsettings, Localization.PrimaryKey, 0, -85);
CreateKeyDropDown(mainsettings, keys, 0, -105, "primary");

CreateDropDownText(mainsettings, Localization.SecondaryKey, 0, -130);
CreateKeyDropDown(mainsettings, keys, 0, -150, "secondary");

CreateDropDownText(mainsettings, Localization.Generic, 0, -175);
CreateKeyDropDown(mainsettings, keys, 0, -195, "generic");

CreateDropDownText(mainsettings, Localization.Interrupt, 0, -220);
CreateKeyDropDown(mainsettings, keys, 0, -240, "interrupt");

CreateDropDownText(mainsettings, Localization.Follow, 0, -265);
CreateEditBox(mainsettings, 0, -282, "follow");
CreateKeyDropDown(mainsettings, keys, 0, -305, "follow");

CreateDropDownText(mainsettings, Localization.GlobalDev, 0, -330);
local globaledit = CreateFrame("EditBox", nil, mainsettings);
globaledit:SetHeight(20)
globaledit:SetWidth(124);
globaledit:SetPoint("TOP", mainsettings, 0, -348)
globaledit:SetFontObject("GameFontHighlight");
globaledit:SetAutoFocus(false);
globaledit:SetJustifyH("CENTER");
globaledit:SetJustifyV("CENTER");
globaledit:EnableMouse(true);
globaledit:SetBackdrop({
	bgFile = "Interface/Buttons/WHITE8X8",
	edgeFile = "Interface/Buttons/WHITE8X8",
	edgeSize = 1,
});
globaledit:SetBackdropColor(0,0,0,0.5);
globaledit:SetBackdropBorderColor(0.8, 0.8, 0.8, 0.5);
globaledit:SetScript("OnEnterPressed", function(self)
	ni.vars.global = self:GetText() or "";
	self:ClearFocus();
end);
globaledit:SetScript("OnEscapePressed", function(self)
	self:SetText(ni.vars.global or "");
	self:ClearFocus();
end);
globaledit:SetText(ni.vars.global or "");
globaledit:Show();

CreateText(mainsettings, Localization.Dev, 0, -370, 0.8, 0.1, 0.1, 1);

local reloadbutton = CreateFrame("BUTTON", nil, mainsettings, "UIPanelButtonTemplate");
reloadbutton:SetWidth(96);
reloadbutton:SetHeight(22);
reloadbutton:SetText(Localization.ReloadDev);
reloadbutton:SetPoint("BOTTOMLEFT", mainsettings, 15, 48);
reloadbutton:SetAlpha(1);
reloadbutton:SetScript("OnClick", function()
	ReloadUI();
end);

local consolebutton = CreateFrame("BUTTON", nil, mainsettings, "UIPanelButtonTemplate");
consolebutton:SetWidth(90);
consolebutton:SetHeight(22);
consolebutton:SetText(Localization.Console);
consolebutton:SetPoint("BOTTOMRIGHT", mainsettings, -15, 48);
consolebutton:SetAlpha(1);
consolebutton:SetScript("OnClick", function()
	ni.functions.toggleconsole();
end);

CreateText(mainsettings, Localization.Contact, 0, -410, 0.8, 0.1, 0.1, 1);

local consolebutton = CreateFrame("BUTTON", nil, mainsettings, "UIPanelButtonTemplate");
consolebutton:SetWidth(82);
consolebutton:SetHeight(22);
consolebutton:SetText("Dimonskiy");
consolebutton:SetPoint("BOTTOMRIGHT", mainsettings, -26, 9);
consolebutton:SetAlpha(1);
consolebutton:SetScript("OnClick", function()
	ni.functions.open("https://discord.com/users/649003031391633438") 
end);

local consolebutton = CreateFrame("BUTTON", nil, mainsettings, "UIPanelButtonTemplate");
consolebutton:SetWidth(82);
consolebutton:SetHeight(22);
consolebutton:SetText("DarhangeR");
consolebutton:SetPoint("BOTTOMLEFT", mainsettings, 26, 9);
consolebutton:SetAlpha(1);
consolebutton:SetScript("OnClick", function()
	ni.functions.open("https://discord.com/users/250267265285488641") 
end);
--Rotation Settings drop downs
local mods = {
	Localization.None,
	"Left Alt",
	"Left Control",
	"Left Shift",
	"Right Alt",
	"Right Control",
	"Right Shift"
}
local latency_name = ni.utils.GenerateRandomName();
local slider = CreateFrame("Slider", latency_name, settings, "OptionsSliderTemplate");
slider:SetOrientation("HORIZONTAL");
slider:SetHeight(15);
slider:SetWidth(175);
slider:SetPoint("TOP", settings, 0, -20);
slider:SetMinMaxValues(20, 1000);
slider:SetValueStep(5);
slider:SetValue(ni.vars.latency);
_G[latency_name.."Low"]:SetText(20);
_G[latency_name.."High"]:SetText(1000);
_G[latency_name.."Text"]:SetText(Localization.Latency);
slider:SetScript("OnValueChanged", function(self, value)
	_G[latency_name.."Text"]:SetText("Latency ("..value.." ms)");	
	ni.vars.latency = value;
end);

CreateDropDownText(settings, Localization.AreaofEffectToggle, 0, -40);
CreateKeyDropDown(settings, mods, 0, -60, "aoe");

CreateDropDownText(settings, Localization.PauseRotationModifier, 0, -85);
CreateKeyDropDown(settings, mods, 0, -105, "pause");

CreateDropDownText(settings, Localization.CDToggle, 0, -130);
CreateKeyDropDown(settings, mods, 0, -150, "cd");

CreateDropDownText(settings, Localization.CustomToggle, 0, -175);
CreateKeyDropDown(settings, mods, 0, -195, "custom");

CreateDropDownText(settings, Localization.MainTankOverride, 0, -220);
CreateEditBox(settings, 0, -238, "mainTank");

CreateDropDownText(settings, Localization.Enabled, -10, -258);
CreateCheckBox(settings, 35, -256, ni.vars.units.mainTankEnabled, function(self)
	if self:GetChecked() then
		ni.vars.units.mainTankEnabled = true;
	else
		ni.vars.units.mainTankEnabled = false;
	end
end);

CreateDropDownText(settings, Localization.OffTankOverride, 0, -276);
CreateEditBox(settings, 0, -294, "offTank");

CreateDropDownText(settings, Localization.Enabled, -10, -314);
CreateCheckBox(settings, 35, -312, ni.vars.units.offTankEnabled, function(self)
	if self:GetChecked() then
		ni.vars.units.offTankEnabled = true;
	else
		ni.vars.units.offTankEnabled = false;
	end
end);


CreateCheckBox(settings, 45, -334, ni.vars.combat.melee, function(self)
	if self:GetChecked() then
		ni.vars.combat.melee = true;
	else
		ni.vars.combat.melee = false;
	end
end);
CreateDropDownText(settings, Localization.IsMelee, -10, -336); 

local mmb_name = ni.utils.GenerateRandomName();
main_ui.minimap_icon = CreateFrame("Button", mmb_name, Minimap);
local mm = main_ui.minimap_icon;
mm:SetHeight(25);
mm:SetWidth(25);
mm:SetFrameStrata("MEDIUM");
mm:SetMovable(true);
mm:SetUserPlaced(true);
main_ui.minimap_toggle = function(bool)
	if bool then
		mm:SetNormalTexture("Interface\\BUTTONS\\UI-GroupLoot-Pass-Up.blp");
		mm:SetPushedTexture("Interface\\BUTTONS\\UI-GroupLoot-Pass-Down.blp");
	else
		mm:SetNormalTexture("Interface\\BUTTONS\\UI-GroupLoot-Coin-Up.blp");
		mm:SetPushedTexture("Interface\\BUTTONS\\UI-GroupLoot-Coin-Down.blp");
	end
end
main_ui.minimap_toggle(ni.vars.profiles.enabled or ni.vars.profiles.genericenabled);
mm:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-Background.blp");
mm:SetPoint("CENTER", ni.vars.ui.icon.x, ni.vars.ui.icon.y);
mm:SetScript("OnMouseDown", function(self, button)
	if button == "LeftButton" then
		if main_ui.main:IsShown() then
			main_ui.main:Hide();
		else
			main_ui.main:Show();
		end
	elseif button == "RightButton" then
		self:SetScript("OnUpdate", moveIcon);
	end
end);
mm:SetScript("OnMouseUp", function(self)
	self:SetScript("OnUpdate", nil);
end);

local function SetClick(key, frame, button)
	if key == Localization.None or key == nil then
		return;
	end
	SetBindingClick(key, frame, button);
end

local mainkeys_name = ni.utils.GenerateRandomName();
local mainkeys = CreateFrame("BUTTON", mainkeys_name, UIParent);
SetClick(ni.vars.hotkeys.primary, mainkeys_name, "LeftButton");
SetClick(ni.vars.hotkeys.secondary, mainkeys_name, "RightButton");
SetClick(ni.vars.hotkeys.generic, mainkeys_name, "MiddleButton");
mainkeys:SetScript("OnClick", function(self, button)
	if button == "LeftButton" then
		ni.toggleprofile(ni.vars.profiles.primary);
		main_ui.minimap_toggle(ni.vars.profiles.enabled or ni.vars.profiles.genericenabled);
	elseif button == "RightButton" then
		ni.toggleprofile(ni.vars.profiles.secondary);
		main_ui.minimap_toggle(ni.vars.profiles.enabled or ni.vars.profiles.genericenabled);
	elseif button == "MiddleButton" then
		ni.togglegeneric(ni.vars.profiles.generic);
		main_ui.minimap_toggle(ni.vars.profiles.enabled or ni.vars.profiles.genericenabled);
	end
end);
mainkeys:Show();
local secondkeys_name = ni.utils.GenerateRandomName();
local secondkeys = CreateFrame("BUTTON", secondkeys_name, UIParent);
SetClick(ni.vars.hotkeys.interrupt, secondkeys_name, "LeftButton");
SetClick(ni.vars.hotkeys.follow, secondkeys_name, "RightButton");
SetClick(ni.vars.hotkeys.gui, secondkeys_name, "MiddleButton");
secondkeys:SetScript("OnClick", function(self, button)
	if button == "LeftButton" then
		ni.vars.profiles.interrupt = not ni.vars.profiles.interrupt;
		ni.showintstatus();
	elseif button == "RightButton" then
		ni.vars.units.followEnabled = not ni.vars.units.followEnabled;
		ni.updatefollow(ni.vars.units.followEnabled);
	elseif button == "MiddleButton" then
		if main_ui.main:IsShown() then
			main_ui.main:Hide();
		else
			main_ui.main:Show();
		end
	end
end);
secondkeys:Show();

return main_ui;
