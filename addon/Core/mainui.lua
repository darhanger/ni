local ru = ni.vars.locale == "ruRU" or false;
local build = ni.vars.build;
local playerclass = select(2, UnitClass("player"));
local main_ui = {};
local Localization = {
	Assistant = "Rotation Assistant",
	Support = "Supporting by DarhangeR",
	Expansion = "",
	Primary = "Select primary rotation:",
	Secondary = "Select secondary rotation:",
	GenericProfile = "Select generic rotation:",
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
	Latency = "Ability Delay ("..ni.vars.latency.." ms)",
	LatencySlider = "Ability Delay",
	AreaofEffectToggle = "Area of Effect Toggle:",
	PauseRotationModifier = "Pause Rotation Modifier:",
	CDToggle = "CD Toggle:",
	CustomToggle = "Custom Toggle:",
	MainTankOverride = "Main Tank Override:",
	Enabled = "Enabled:",
	OffTankOverride = "Off Tank Override:",
	IsMelee = "Is Melee:",
	All = "All Classes",
	Coin = "Remove Icon:",
	LeftClick = "|cffC0C0C0Left click:|r Open Main Menu.",
	RightClick = "|cffC0C0C0Right click:|r Check updates.",
	MidleClick = "|cffC0C0C0Midle click:|r Open Discord Server."	
};
if ru then
	Localization.Assistant = "Помошник Ротации"
	Localization.Support = "При поддержке DarhangeR"
	Localization.Primary = "Выберите основную ротацию:"
	Localization.Secondary = "Выберите вторичную ротацию:"
	Localization.GenericProfile = "Выберите общую ротацию:"
	Localization.None = "Нет"
	Localization.Resource = "Отслеживания ресурсов"
	Localization.All = "Всех"
	Localization.Reload = "Перезагрузитe после изменения"
	Localization.Global = "кнопки или глобальной"
	Localization.GUI = "Кнопка меню:"
	Localization.PrimaryKey = "Вкл/Выкл основной ротации:"
	Localization.SecondaryKey = "Вкл/Выкл вторичной ротации:"
	Localization.Generic = "Вкл/Выкл общей ротации:"
	Localization.Interrupt = "Вкл/Выкл прерывания кастов:"
	Localization.Follow = "Авто-Следование и кнопка:"
	Localization.GlobalDev = "Глобальная переменная:"
	Localization.Dev = "Опции разработчика:"
	Localization.ReloadDev = "Перезагрузка"
	Localization.Console = "Консоль"
	Localization.Contact = "Связатся с:"
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
	Localization.Latency = "Обраб. заклинаний ("..ni.vars.latency.." мс)"
	Localization.LatencySlider = "Обраб. заклинаний"
	Localization.AreaofEffectToggle = "Вкл/Выкл АоЕ:"
	Localization.PauseRotationModifier = "Кнопка для паузы ротации:"
	Localization.CDToggle = "Вкл/Выкл КД:"
	Localization.CustomToggle = "Настраиваемая Кнопка:"
	Localization.MainTankOverride = "Ник главного танка:"
	Localization.Enabled = "Включить:"
	Localization.OffTankOverride = "Ник второго танка:"
	Localization.IsMelee = "Ближний бой:"
	Localization.All = "Все Классы"
	Localization.Coin = "Убрать иконку:"
	Localization.LeftClick = "|cffC0C0C0Левый щелчок:|r Открыть основное меню."
	Localization.RightClick = "|cffC0C0C0Правый щелчок щелчок:|r Проверить обновления."
	Localization.MidleClick = "|cffC0C0C0Cредний щелчок:|r Открыть сервер Discord."	
end;

local classIcons = {
	["DEATHKNIGHT"] = "Interface\\Icons\\spell_deathknight_classicon",
	["DRUID"]       = "Interface\\Icons\\ability_druid_maul",
	["HUNTER"]      = "Interface\\Icons\\inv_weapon_bow_07",
	["MAGE"]        = "Interface\\Icons\\inv_staff_13",
	["MONK"]     	= "Interface\\Icons\\classicon_monk",
	["PALADIN"]     = "Interface\\Icons\\ability_thunderbolt",
	["PRIEST"]      = "Interface\\Icons\\inv_staff_30",
	["ROGUE"]       = "Interface\\Icons\\inv_throwingknife_04",
	["SHAMAN"]      = "Interface\\Icons\\spell_nature_bloodlust",
	["WARLOCK"]     = "Interface\\Icons\\spell_nature_drowsy",
	["WARRIOR"]     = "Interface\\Icons\\inv_sword_27",
};
local ClassIcon = classIcons[playerclass];

--- Initialize Icon and UI ---

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
};
if ni.vars.ui then
	ui = ni.vars.ui;
else
	ni.vars.ui = ui;
end;
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
end;
local r, g, b, a, slid = .3,.3,.3,.75, 15;
local mr, mg, mb = 0.2, 0.7, 1;
local uiScale = GetCVar("uiScale") or 1;
local backdrop = {
	bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
	edgeFile = "Interface/Buttons/WHITE8X8", 
	tile = true, tileSize = 16, edgeSize = 3, 
	insets = { left = 2, right = 2, top = 2, bottom = 2 }
};
local mframeran = ni.utils.generaterandomname();
main_ui.main = CreateFrame("frame", mframeran, UIParent);
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
frame:SetHeight(320);
frame:SetBackdrop(backdrop);
frame:SetPoint(ni.vars.ui.main.point, WorldFrame, ni.vars.ui.main.relativePoint, ni.vars.ui.main.x, ni.vars.ui.main.y);
frame:SetBackdropColor(.1,.1,.1, 1);
frame:SetBackdropBorderColor(r,g,b,a);
frame:Hide();

local profiles = {};
local function GetFilename(file)
    return file:match("^.*\\(.*).lua$") or file:match("^.*\\(.*).enc$") or file:match("^.*\\(.*).out$") or file;
end;
if build == 30300 then
	Expansion = "Wrath of the Lich King Mode"
	mr, mg, mb = 0.2, 0.7, 1;
	profiles = ni.functions.getprofilesfor(playerclass.."\\wrath");
elseif build == 40300 then
	mr, mg, mb = 1.00, 0.49, 0.04;
	Expansion = "Cataclysm Mode"
	profiles = ni.functions.getprofilesfor(playerclass.."\\cata");
elseif build > 40300 then
	mr, mg, mb = 0.00, 1.00, 0.60;
	Expansion = "Mists of Pandaria Mode"
	profiles = ni.functions.getprofilesfor(playerclass.."\\mop");
end;
tinsert(profiles, 1, Localization.None);
local generic_profiles = ni.functions.getprofilesfor("Generic") or { };
tinsert(generic_profiles, 1, Localization.None);

--- Draw UI Elements ---

local function CreateText(frame, settext, offset_x, offset_y, r, g, b, a)
	local textran = ni.utils.generaterandomname();	
	local text = CreateFrame("frame", textran, frame);
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
end;

local function CreateMainButton(frame, width, height, text, offset_x, offset_y, gray, func)
	local butDesign, al = "UIPanelButtonTemplate", 1;
	if gray then
		butDesign, al = "UIPanelButtonGrayTemplate", .7;
	end
	local button = CreateFrame("BUTTON", nil, frame, butDesign);
	button:SetWidth(width);
	button:SetHeight(height);
	button:SetText(text);
	button:SetPoint("BOTTOM", frame, offset_x, offset_y);
	button:SetAlpha(al);
	button:SetScript("OnClick", func);

	return button;
end;

local function CreateDropDownText(frame, settext, offset_x, offset_y, position, tooltipText, width)
	position = position or "CENTER";
	local text = CreateFrame("frame", nil, frame);
	text:ClearAllPoints();
	text:SetHeight(20);
	text:SetWidth(width or 150);
	text:SetPoint("TOP", frame, offset_x, offset_y);
	text.text = text:CreateFontString(nil, "BACKGROUND", "GameFontNormal");
	text.text:SetAllPoints();
	text.text:SetJustifyH(position);
	text.text:SetJustifyV("MIDDLE");
	text.text:SetWordWrap(false);
	local pad = ""
    for i = 1, random(1, 255) do pad = pad .. "\124r" end
	text.text:SetText(pad..settext);
    if tooltipText then
		text:EnableMouse(true);
        text:SetScript("OnEnter", function(self)
			local tooltip = GameTooltip;
			tooltip:Hide();	
            tooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT");
			tooltip:ClearLines();
			tooltip:AddLine(tooltipText);
            tooltip:Show();
        end);
        text:SetScript("OnLeave", function(self)
			local tooltip = GameTooltip;
			tooltip:ClearLines();
			tooltip:Hide();
        end);
    end	
	return text;
end;

local function CreateKeyDropDown(frame, keys, offset_x, offset_y, var, wdh)
	local name = ni.utils.generaterandomname();
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
	UIDropDownMenu_SetWidth(dropdown, wdh);
	UIDropDownMenu_SetButtonWidth(dropdown, wdh);
	UIDropDownMenu_JustifyText(dropdown, "CENTER");
	UIDropDownMenu_SetSelectedID(dropdown, setIndex);
	UIDropDownMenu_SetText(dropdown, set);	

	return dropdown;
end;

local function InitializeDropdownMenu(dropdown, profiles, profileType)
    local selected = Localization.None;
    local selectedIndex = 1;
    UIDropDownMenu_Initialize(dropdown, function(self, level)
        local info = UIDropDownMenu_CreateInfo();
        local index = 0;
        for k, v in ipairs(profiles) do
            index = index + 1;
            local file = GetFilename(v);
            local checked = ni.vars.profiles[profileType] == file;
            if checked then
                selected = file;
                selectedIndex = index;
            end
            info.text = file;
            info.value = file;
            info.checked = checked;
            info.func = function(self)
                UIDropDownMenu_SetSelectedID(dropdown, self:GetID());
                ni.vars.profiles[profileType] = self:GetText();
            end
            UIDropDownMenu_AddButton(info, level);
        end
    end)
    UIDropDownMenu_SetWidth(dropdown, 160);
    UIDropDownMenu_SetButtonWidth(dropdown, 140);
    UIDropDownMenu_JustifyText(dropdown, "CENTER");
    UIDropDownMenu_SetSelectedID(dropdown, selectedIndex);
    UIDropDownMenu_SetText(dropdown, selected);
end;

local function CreateDropdown(frame, yOffset, profiles, profileType)
	local nm = ni.utils.generaterandomname();
    local dropdown = CreateFrame("frame", nm, frame, "UIDropDownMenuTemplate");
    dropdown:ClearAllPoints();
    dropdown:SetPoint("TOP", 0, yOffset);
    dropdown:Show();
    InitializeDropdownMenu(dropdown, profiles, profileType);
end;

local function CreateConfigurableEditBox(frame, offsetX, offsetY, var)
    local tab, key
    if strfind(var, "%.") then
        tab, key = strmatch(var, "^(%w+)%.(%w+)$");
        ni.vars[tab] = ni.vars[tab] or {};
    else
        tab = nil;
        key = var;
    end
    local edit = CreateFrame("EditBox", nil, frame);
    edit:SetHeight(20);
    edit:SetWidth(120);
    edit:SetPoint("TOP", frame, offsetX, offsetY);
    edit:SetFontObject("GameFontHighlight");
    edit:SetAutoFocus(false);
    edit:SetJustifyH("CENTER");
    edit:SetJustifyV("CENTER");
    edit:EnableMouse(true);
    edit:SetBackdrop({
        bgFile = "Interface/Buttons/WHITE8X8",
        edgeFile = "Interface/Buttons/WHITE8X8",
        edgeSize = 1,
    })
    edit:SetBackdropColor(0, 0, 0, 0.5)
    edit:SetBackdropBorderColor(0.8, 0.8, 0.8, 0.5)
    edit:SetScript("OnEnterPressed", function(self)
        if tab then
            ni.vars[tab][key] = self:GetText() or "";
        else
            ni.vars[key] = self:GetText() or "";
        end
        self:ClearFocus();
    end)
    edit:SetScript("OnEscapePressed", function(self)
        if tab then
            self:SetText(ni.vars[tab][key] or "");
        else
            self:SetText(ni.vars[key] or "");
        end
        self:ClearFocus();
    end)
    if tab then
        edit:SetText(ni.vars[tab][key] or "");
    else
        edit:SetText(ni.vars[key] or "");
    end
    edit:Show();

    return edit;
end;

local function CreateEditBox(frame, offset_x, offset_y, var)
	local name = ni.utils.generaterandomname();
	local edit = CreateFrame("EditBox", name, frame);
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
	local name = ni.utils.generaterandomname();
	local check = CreateFrame("CheckButton", name, frame, "OptionsBaseCheckButtonTemplate");
	check:SetPoint("TOP", offset_x, offset_y);
	check:SetSize(26, 26);
	check:SetChecked(checked);
	check:SetHitRectInsets(0,0,0,0);
	check:SetScript("OnClick", function(self)
		func(self);
	end);
	check.value = value;
	return check;
end;

local title = CreateText(frame, Localization.Assistant, 0, -8, mr, mg, mb, 1);
local title2 = CreateText(frame, Localization.Support, 0, -25, mr, mg, mb, 1);
local title3 = CreateText(frame, Expansion, 0, -42, mr, mg, mb, 1);
local primary_text = CreateText(frame, Localization.Primary, 0, -65, 0.1, 0.5, 0.8, 1);
local secondary_text = CreateText(frame, Localization.Secondary, 0, -115, 0.1, 0.5, 0.8, 1);
local generic_text = CreateText(frame, Localization.GenericProfile, 0, -165, 0.1, 0.5, 0.8, 1);

local primaryDropdown = CreateDropdown(frame, -85, profiles, "primary");
local secondaryDropdown = CreateDropdown(frame, -135, profiles, "secondary");
local genericDropdown = CreateDropdown(frame, -185, generic_profiles, "generic");

--- Draw UI Frames ---

local msetran = ni.utils.generaterandomname();
local mainsettings = CreateFrame("frame", msetran, frame);
mainsettings:ClearAllPoints();
mainsettings:SetWidth(220);
mainsettings:SetHeight(530);
mainsettings:SetPoint("TOPRIGHT", frame, 220, 0);
mainsettings:SetBackdrop(backdrop);
mainsettings:EnableMouse(true);
mainsettings:SetBackdropColor(.1,.1,.1, 1);
mainsettings:SetBackdropBorderColor(r,g,b,a);
mainsettings:Hide();

local setran = ni.utils.generaterandomname();
local settings = CreateFrame("frame", setran, frame);
settings:ClearAllPoints();
settings:SetWidth(200);
settings:SetHeight(380);
settings:SetPoint("TOPLEFT", frame, -200, 0);
settings:SetBackdrop(backdrop);
settings:EnableMouse(true);
settings:SetBackdropColor(.1,.1,.1, 1);
settings:SetBackdropBorderColor(r,g,b,a);
settings:Hide();

local ressetran = ni.utils.generaterandomname();
local resourcesettings = CreateFrame("frame", ressetran, frame);
resourcesettings:ClearAllPoints();
resourcesettings:SetWidth(320);
resourcesettings:SetHeight(280);
resourcesettings:SetPoint("BOTTOM", frame, 0, -275);
resourcesettings:SetBackdrop(backdrop);
resourcesettings:EnableMouse(true);
resourcesettings:SetBackdropColor(.1,.1,.1, 1);
resourcesettings:SetBackdropBorderColor(r,g,b,a);
resourcesettings:Hide();

local creatsetran = ni.utils.generaterandomname();
local creaturesettings = CreateFrame("frame", creatsetran, frame);
creaturesettings:ClearAllPoints();
creaturesettings:SetWidth(320);
creaturesettings:SetHeight(200);
creaturesettings:SetPoint("BOTTOM", frame, 0, -195);
creaturesettings:SetBackdrop(backdrop);
creaturesettings:EnableMouse(true);
creaturesettings:SetBackdropColor(.1,.1,.1, 1);
creaturesettings:SetBackdropBorderColor(r,g,b,a);
creaturesettings:Hide();

--- Draw Maine Buttons ---

CreateMainButton(frame, 137, 22, Localization.Rotation, -68, 61, false, function()
	if settings:IsShown() then
		settings:Hide();
	else
		settings:Show();
	end
end);
CreateMainButton(frame, 137, 22, Localization.MainSettings, 68, 61, false, function()
	if mainsettings:IsShown() then
		mainsettings:Hide();
	else
		mainsettings:Show();
	end
end);
CreateMainButton(frame, 137, 22, Localization.ResourceTrack, -68, 35, false, function()
	if resourcesettings:IsShown() then
		resourcesettings:Hide();
	else
		if creaturesettings:IsShown() then
			creaturesettings:Hide();
		end
		resourcesettings:Show();
	end
end);
CreateMainButton(frame, 137, 22, Localization.CreatureTrack, 68, 35, false, function()
	if creaturesettings:IsShown() then
		creaturesettings:Hide();
	else
		if resourcesettings:IsShown() then
			resourcesettings:Hide();
		end
		creaturesettings:Show();
	end
end);
CreateMainButton(frame, 62, 22, Localization.Close, 0, 10, false, function()
	if frame:IsShown() then
		frame:Hide();
	end
end);

--- Resource Tracking Menu ---

local bitwise = {};
function bitwise.hasbit(x, p)
	return x % (p + p) >= p;
end;
function bitwise.setbit(x, p)
	return bitwise.hasbit(x, p) and x or x + p;
end;
function bitwise.clearbit(x, p)
	return bitwise.hasbit(x, p) and x - p or x;
end;

CreateText(resourcesettings, Localization.Resource, 0, -8, mr, mg, mb, 1, "CENTER");
local currentresources = ni.vars.currentresources or 0;
ni.functions.setresourcetracking(currentresources);
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
};
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
	ni.vars.currentresources = c_bit;
end;
local function checkbox_clicked(self)
	if self:GetChecked() then
		currentresources = bitwise.setbit(currentresources, self.value);
	else
		currentresources = bitwise.clearbit(currentresources, self.value);
	end
	update_boxes(currentresources);
end;
CreateDropDownText(resourcesettings, Localization.None, -40, -28, "LEFT")
boxes.resource_none = CreateCheckBox(resourcesettings, -130, -26, currentresources == 0, function(self)
	if self:GetChecked() then
		currentresources = 0;
	end
	update_boxes(currentresources);
end, 0);
CreateDropDownText(resourcesettings, Localization.All, -40, -48, "LEFT")
boxes.resource_all = CreateCheckBox(resourcesettings, -130, -46, currentresources == -1, function(self)
	if self:GetChecked() then
		currentresources = -1;
	else
		currentresources = 0;
	end
	update_boxes(currentresources);
end, -1);
CreateDropDownText(resourcesettings, Localization.Lockpicking, -40, -68, "LEFT")
boxes.resource_lockpicking = CreateCheckBox(resourcesettings, -130, -66, bitwise.hasbit(currentresources, 0x1), checkbox_clicked, 0x1);
CreateDropDownText(resourcesettings, Localization.Herbs, -40, -88, "LEFT")
boxes.resource_herbs = CreateCheckBox(resourcesettings, -130, -86, bitwise.hasbit(currentresources, 0x2), checkbox_clicked, 0x2);
CreateDropDownText(resourcesettings, Localization.Minerals, -40, -108, "LEFT")
boxes.resource_minerals = CreateCheckBox(resourcesettings, -130, -106, bitwise.hasbit(currentresources, 0x4), checkbox_clicked, 0x4);
CreateDropDownText(resourcesettings, Localization.DisarmTrap, -40, -128, "LEFT")
boxes.resource_disarmtrap = CreateCheckBox(resourcesettings, -130, -126, bitwise.hasbit(currentresources, 0x8), checkbox_clicked, 0x8);
CreateDropDownText(resourcesettings, Localization.Open, -40, -148, "LEFT")
boxes.resource_open = CreateCheckBox(resourcesettings, -130, -146, bitwise.hasbit(currentresources, 0x10), checkbox_clicked, 0x10);
CreateDropDownText(resourcesettings, Localization.Treasure, -40, -168, "LEFT")
boxes.resource_treasure = CreateCheckBox(resourcesettings, -130, -166, bitwise.hasbit(currentresources, 0x20), checkbox_clicked, 0x20);
CreateDropDownText(resourcesettings, Localization.CloseTrack, -40, -188, "LEFT")
boxes.resource_close = CreateCheckBox(resourcesettings, -130, -186, bitwise.hasbit(currentresources, 0x80), checkbox_clicked, 0x80);
CreateDropDownText(resourcesettings, Localization.ArmTrap, -40, -208, "LEFT")
boxes.resource_armtrap = CreateCheckBox(resourcesettings, -130, -206, bitwise.hasbit(currentresources, 0x100), checkbox_clicked, 0x100);
CreateDropDownText(resourcesettings, Localization.QuickOpen, -40, -228, "LEFT")
boxes.resource_quickopen = CreateCheckBox(resourcesettings, -130, -226, bitwise.hasbit(currentresources, 0x200), checkbox_clicked, 0x200);
CreateDropDownText(resourcesettings, Localization.CalcifiedElvenGems, -40, -248, "LEFT")
boxes.resource_calcifiedelvengems = CreateCheckBox(resourcesettings, -130, -246, bitwise.hasbit(currentresources, 0x40), checkbox_clicked, 0x40);
CreateDropDownText(resourcesettings, Localization.QuickClose, 105, -28, "LEFT")
boxes.resource_quickclose = CreateCheckBox(resourcesettings, 15, -26, bitwise.hasbit(currentresources, 0x400), checkbox_clicked, 0x400);
CreateDropDownText(resourcesettings, Localization.OpenTinkering, 105, -48, "LEFT")
boxes.resource_opentinkering = CreateCheckBox(resourcesettings, 15, -46, bitwise.hasbit(currentresources, 0x800), checkbox_clicked, 0x800);
CreateDropDownText(resourcesettings, Localization.OpenKneeling, 105, -68, "LEFT")
boxes.resource_openkneeling = CreateCheckBox(resourcesettings, 15, -66, bitwise.hasbit(currentresources, 0x1000), checkbox_clicked, 0x1000);
CreateDropDownText(resourcesettings, Localization.OpenAttacking, 105, -88, "LEFT")
boxes.resource_openattacking = CreateCheckBox(resourcesettings, 15, -86, bitwise.hasbit(currentresources, 0x2000), checkbox_clicked, 0x2000);
CreateDropDownText(resourcesettings, Localization.Gahzridian, 105, -108, "LEFT")
boxes.resource_gahzridian = CreateCheckBox(resourcesettings, 15, -106, bitwise.hasbit(currentresources, 0x4000), checkbox_clicked, 0x4000);
CreateDropDownText(resourcesettings, Localization.Blasting, 105, -128, "LEFT")
boxes.resource_blasting = CreateCheckBox(resourcesettings, 15, -126, bitwise.hasbit(currentresources, 0x8000), checkbox_clicked, 0x8000);
CreateDropDownText(resourcesettings, Localization.PvPOpen, 105, -148, "LEFT")
boxes.resource_pvpopen = CreateCheckBox(resourcesettings, 15, -146, bitwise.hasbit(currentresources, 0x10000), checkbox_clicked, 0x10000);
CreateDropDownText(resourcesettings, Localization.PvPClose, 105, -168, "LEFT")
boxes.resource_pvpclose = CreateCheckBox(resourcesettings, 15, -166, bitwise.hasbit(currentresources, 0x20000), checkbox_clicked, 0x20000);
CreateDropDownText(resourcesettings, Localization.Fishing, 105, -188, "LEFT")
boxes.resource_fishing = CreateCheckBox(resourcesettings, 15, -186, bitwise.hasbit(currentresources, 0x40000), checkbox_clicked, 0x40000);
CreateDropDownText(resourcesettings, Localization.Inscription, 105, -208, "LEFT")
boxes.resource_inscription = CreateCheckBox(resourcesettings, 15, -206, bitwise.hasbit(currentresources, 0x80000), checkbox_clicked, 0x80000);
CreateDropDownText(resourcesettings, Localization.OpenFromVehicle, 105, -228, "LEFT")
boxes.resource_openfromvehicle = CreateCheckBox(resourcesettings, 15, -226, bitwise.hasbit(currentresources, 0x100000), checkbox_clicked, 0x100000);

--- NPC Tracking Menu ---

CreateText(creaturesettings, Localization.CreatureTrackingToggles, 0, -8, mr, mg, mb, 1, "CENTER");
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
};
local currentcreatures = ni.vars.currentcreatures or 0;
ni.functions.setcreaturetracking(currentcreatures);
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
	ni.vars.currentcreatures = c_bit;
end;
local function checkbox_clickedc(self)
	if self:GetChecked() then
		currentcreatures = bitwise.setbit(currentcreatures, self.value);
	else
		currentcreatures = bitwise.clearbit(currentcreatures, self.value);
	end
	update_cboxes(currentcreatures);
end;
CreateDropDownText(creaturesettings, Localization.None, -15, -27, "LEFT")
cboxes.none = CreateCheckBox(creaturesettings, -104, -25, currentcreatures == 0, function(self)
	if self:GetChecked() then
		currentcreatures = 0;
	end
	update_cboxes(currentcreatures);
end, 0);
CreateDropDownText(creaturesettings, Localization.All, -15, -47, "LEFT")
cboxes.all = CreateCheckBox(creaturesettings, -104, -45, currentcreatures == -1, function(self)
	if self:GetChecked() then
		currentcreatures = -1;
	else
		currentcreatures = 0;
	end
	update_cboxes(currentcreatures);
end, -1);
CreateDropDownText(creaturesettings, Localization.Beasts, -15, -67, "LEFT")
cboxes.beasts = CreateCheckBox(creaturesettings, -104, -65, bitwise.hasbit(currentcreatures, 0x1), checkbox_clickedc, 0x1);
CreateDropDownText(creaturesettings, Localization.Dragons, -15, -87, "LEFT")
cboxes.dragons = CreateCheckBox(creaturesettings, -104, -85, bitwise.hasbit(currentcreatures, 0x2), checkbox_clickedc, 0x2);
CreateDropDownText(creaturesettings, Localization.Demons, -15, -107, "LEFT")
cboxes.demons = CreateCheckBox(creaturesettings, -104, -105, bitwise.hasbit(currentcreatures, 0x4), checkbox_clickedc, 0x4);
CreateDropDownText(creaturesettings, Localization.Elementals, -15, -127, "LEFT")
cboxes.elementals = CreateCheckBox(creaturesettings, -104, -125, bitwise.hasbit(currentcreatures, 0x8), checkbox_clickedc, 0x8);
CreateDropDownText(creaturesettings, Localization.Giants, -15, -147, "LEFT")
cboxes.giants = CreateCheckBox(creaturesettings, -104, -145, bitwise.hasbit(currentcreatures, 0x10), checkbox_clickedc, 0x10);
CreateDropDownText(creaturesettings, Localization.Undead, -15, -167, "LEFT")
cboxes.undead = CreateCheckBox(creaturesettings, -104, -165, bitwise.hasbit(currentcreatures, 0x20), checkbox_clickedc, 0x20);
CreateDropDownText(creaturesettings, Localization.Humanoids, 85, -27, "LEFT")
cboxes.humanoids = CreateCheckBox(creaturesettings, -2, -25, bitwise.hasbit(currentcreatures, 0x40), checkbox_clickedc, 0x40);
CreateDropDownText(creaturesettings, Localization.Critters, 85, -47, "LEFT")
cboxes.critters = CreateCheckBox(creaturesettings, -2, -45, bitwise.hasbit(currentcreatures, 0x80), checkbox_clickedc, 0x80);
CreateDropDownText(creaturesettings, Localization.Machines, 85, -67, "LEFT")
cboxes.machines = CreateCheckBox(creaturesettings, -2, -65, bitwise.hasbit(currentcreatures, 0x100), checkbox_clickedc, 0x100);
CreateDropDownText(creaturesettings, Localization.Slimes, 85, -87, "LEFT")
cboxes.slimes = CreateCheckBox(creaturesettings, -2, -85, bitwise.hasbit(currentcreatures, 0x200), checkbox_clickedc, 0x200);
CreateDropDownText(creaturesettings, Localization.Totem, 85, -107, "LEFT")
cboxes.totem = CreateCheckBox(creaturesettings, -2, -105, bitwise.hasbit(currentcreatures, 0x400), checkbox_clickedc, 0x400);
CreateDropDownText(creaturesettings, Localization.NonCombatPet, 85, -127, "LEFT")
cboxes.noncombatpet = CreateCheckBox(creaturesettings, -2, -125, bitwise.hasbit(currentcreatures, 0x800), checkbox_clickedc, 0x800);
CreateDropDownText(creaturesettings, Localization.GasCloud, 85, -147, "LEFT")
cboxes.gascloud = CreateCheckBox(creaturesettings, -2, -145, bitwise.hasbit(currentcreatures, 0x1000), checkbox_clickedc, 0x1000);

--- Main Settings Buttons / Dropdowns ---

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
};
CreateText(mainsettings, Localization.Reload, 0, -7, 0.8, 0.1, 0.1, 1);
CreateText(mainsettings, Localization.Global, 0, -22, 0.8, 0.1, 0.1, 1);

CreateDropDownText(mainsettings, Localization.GUI, 0, -44);
CreateKeyDropDown(mainsettings, keys, 0, -63, "gui", 75);

CreateDropDownText(mainsettings, Localization.PrimaryKey, 0, -90);
CreateKeyDropDown(mainsettings, keys, 0, -110, "primary", 75);

CreateDropDownText(mainsettings, Localization.SecondaryKey, 0, -140);
CreateKeyDropDown(mainsettings, keys, 0, -160, "secondary", 75);

CreateDropDownText(mainsettings, Localization.Generic, 0, -190);
CreateKeyDropDown(mainsettings, keys, 0, -210, "generic", 75);

CreateDropDownText(mainsettings, Localization.Interrupt, 0, -240);
CreateKeyDropDown(mainsettings, keys, 0, -260, "interrupt", 75);

CreateDropDownText(mainsettings, Localization.Follow, 0, -290);
local followE = CreateConfigurableEditBox(mainsettings, 0, -310, "units.follow");
CreateKeyDropDown(mainsettings, keys, 0, -335, "follow", 75);
CreateDropDownText(mainsettings, Localization.IsMelee, -10, -365); 
CreateCheckBox(mainsettings, 45, -363, ni.vars.combat.melee, function(self)
	if self:GetChecked() then
		ni.vars.combat.melee = true;
	else
		ni.vars.combat.melee = false;
	end
end);

CreateDropDownText(mainsettings, Localization.GlobalDev, 0, -400);
local globaledit = CreateConfigurableEditBox(mainsettings, 0, -425, "global")

CreateText(mainsettings, Localization.Dev, 0, -385, 0.8, 0.1, 0.1, 1, "CENTER");
CreateMainButton(mainsettings, 97, 22, Localization.ReloadDev, -50, 57, false, function()
	ReloadUI();
end);
CreateMainButton(mainsettings, 97, 22, Localization.Console, 50, 57, false, function()
	message("\n\nUNAVAILABLE");
end);

CreateText(mainsettings, Localization.Contact, 0, -475, 0.8, 0.1, 0.1, 1, "CENTER");
CreateMainButton(mainsettings, 97, 22, "DarhangeR", -50, 10, false, function()
	ni.functions.open("https://discord.com/users/250267265285488641") ;
end);
CreateMainButton(mainsettings, 97, 22, "DISCORD", 50, 10, false, function()
	ni.functions.open("https://discord.gg/ZKFkvrzaU4");
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
};
CreateDropDownText(settings, Localization.Coin, -40, -20); 
CreateCheckBox(settings, 50, -18, ni.vars.coin, function(self)
	if self:GetChecked() then
		ni.vars.coin = true;
		ReloadUI();
	else
		ni.vars.coin = false;
		ReloadUI();
	end
end);
local latency_name = ni.utils.generaterandomname();
local slider = CreateFrame("Slider", latency_name, settings, "OptionsSliderTemplate");
local slider_components = {}
for k, v in pairs(_G) do
	if type(k) == "string" and string.find(k, latency_name) then
		slider_components[k] = v
		_G[k] = nil
	end
end;
slider:SetOrientation("HORIZONTAL");
slider:SetHeight(20);
slider:SetWidth(170);
slider:SetPoint("TOP", settings, 0, -70);
slider:SetMinMaxValues(20, 1000);
slider:SetValueStep(5);
slider:SetValue(ni.vars.latency);
slider_components[latency_name.."Low"]:SetText(20);
slider_components[latency_name.."High"]:SetText(1000);
slider_components[latency_name.."Text"]:SetPoint("TOP", slider, "TOP", 0, slid);
slider_components[latency_name.."Text"]:SetText(Localization.Latency);
slider:SetScript("OnValueChanged", function(self, value)
	slider_components[latency_name.."Text"]:SetText(Localization.LatencySlider.. "("..value.." ms)");	
	ni.vars.latency = value;
end);

CreateDropDownText(settings, Localization.AreaofEffectToggle, 0, -90);
CreateKeyDropDown(settings, mods, 0, -110, "aoe", 100);

CreateDropDownText(settings, Localization.PauseRotationModifier, 0, -138);
CreateKeyDropDown(settings, mods, 0, -158, "pause", 100);

CreateDropDownText(settings, Localization.CDToggle, 0, -186);
CreateKeyDropDown(settings, mods, 0, -206, "cd", 100);

CreateDropDownText(settings, Localization.CustomToggle, 0, -234);
CreateKeyDropDown(settings, mods, 0, -254, "custom", 100);

CreateDropDownText(settings, Localization.MainTankOverride, 0, -282);
local mainTank = CreateConfigurableEditBox(settings, 0, -301, "units.mainTank");
CreateCheckBox(settings, -78, -299, ni.vars.units.mainTankEnabled, function(self)
	if self:GetChecked() then
		ni.vars.units.mainTankEnabled = true;
	else
		ni.vars.units.mainTankEnabled = false;
	end
end);

CreateDropDownText(settings, Localization.OffTankOverride, 0, -322);
local offTank = CreateConfigurableEditBox(settings, 0, -341, "units.offTank");
CreateCheckBox(settings, -78, -339, ni.vars.units.offTankEnabled, function(self)
	if self:GetChecked() then
		ni.vars.units.offTankEnabled = true;
	else
		ni.vars.units.offTankEnabled = false;
	end
end);

local mmb_name = ni.utils.generaterandomname();
local ldb = ni.lib.LibStub:GetLibrary("LibDataBroker-1.1", true)
local MiniMap = MiniMap or {};
local miniMapEnabled = not ni.vars.stream and not ni.vars.coin

local MiniMapLDB = ldb:NewDataObject(mmb_name, {
    icon = "none",
    RegisterForDrag = "LeftButton",
});
main_ui.minimap_toggle = function(bool)
	if bool and ni.vars.profiles.enabled 
	and ((ni.vars.hotkeys.primary and ni.vars.profiles.primary ~= Localization.None) 
	or (ni.vars.hotkeys.secondary and ni.vars.profiles.secondary ~= Localization.None)) then
		MiniMapLDB.icon = ClassIcon; -- Profile Enabled
	elseif bool and ni.vars.profiles.genericenabled 
	and (ni.vars.hotkeys.generic and ni.vars.profiles.generic ~= Localization.None) then
		MiniMapLDB.icon = "Interface\\Icons\\trade_engineering"; -- Other icon when genericenabled is true and enabled is false
	else
		MiniMapLDB.icon = "Interface\\Icons\\achievement_character_orc_male"; -- Default icon when both are false
	end
end;
main_ui.minimap_toggle(ni.vars.profiles.enabled or ni.vars.profiles.genericenabled)
function MiniMapLDB:OnClick(button)
    if button == "LeftButton" then
        if main_ui.main:IsShown() then
            main_ui.main:Hide();
        else
            main_ui.main:Show();
        end
    end
    if button == "RightButton" then
        ni.functions.open("https://github.com/darhanger/ni/releases")
    end 	
    if button == "MiddleButton" then
        ni.functions.open("https://discord.gg/xBFKJc6QRr")
    end        
end;
function MiniMapLDB:OnDragStop()
    ni.vars.ui.iconPos = self.db.minimapPos
end;
function MiniMapLDB:OnTooltipShow()
    self:AddLine("|c0000CED1"..Localization.Assistant.."  v0.0.67")
    self:AddLine(" ")
    self:AddLine(Localization.LeftClick)
	self:AddLine(Localization.RightClick)
    self:AddLine(Localization.MidleClick)
end;
local icon = ni.lib.LibStub("LibDBIcon-1.0", true)
MiniMapLDBIconDB = {
    hide = not miniMapEnabled,
    minimapPos = ni.vars.ui.iconPos or ui.iconPos,
};
icon:Register(mmb_name, MiniMapLDB, MiniMapLDBIconDB)
local function SetClick(key, frame, button)
	if key == Localization.None or key == nil then
		return;
	end
	SetBindingClick(key, frame, button);
end;
local mainkeys_name = ni.utils.generaterandomname();
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
local secondkeys_name = ni.utils.generaterandomname();
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