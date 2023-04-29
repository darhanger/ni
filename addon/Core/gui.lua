local ipairs, random, pairs, tinsert, tremove, wipe, tonumber, tostring, rawset = ipairs, random, pairs, tinsert, tremove, wipe, tonumber, tostring, rawset 
local GUIRan = ni.utils.generaterandomname();
local GUI = CreateFrame("frame", GUIRan, UIParent);
-----------------------------------------------
----- Necessary tables for below functions ----
-----------------------------------------------
local frames = { };
local storedframes = { };
local framenames = { };
-----------------------------------------------
------- Local variables for the GUI -----------
-----------------------------------------------
local main_width = 60;
local main_original_width = main_width;
local main_height = 70;
local main_original_height = main_height;
local main_y = 55;
local main_original_y = main_y;
local original_offset = 45;
local offset = original_offset;
local current_frame;
local current_frame_name;
-----------------------------------------------
----- Local functions for movement/sizing -----
-----------------------------------------------
local function ApplyLayout()
	local distance = main_y;
	if GUI.isOpen then
		distance = distance - offset;
	end
	GUI:ClearAllPoints();
	GUI:SetPoint("TOP", UIParent, "TOP", 0, distance);
end
local function PopOut(self, ...)
	self.PopTimer = 0.5;
	self.PopDirection = 1;
end
local function PopBack(self, ...)
	self.PopTimer = 0.5;
	self.PopDirection = -1;
end
local function PerformOpen()
	GUI.PopDirection = nil;
	GUI:ClearAllPoints();
	GUI.isOpen = true;
	ApplyLayout();
end
local function PerformClose()
	GUI.PopDirection = nil;
	GUI:ClearAllPoints();
	GUI.isOpen = false
	ApplyLayout();
end
local function Popper(self, ...)
	local duration = ...;
	if self.PopDirection then
		self.PopTimer = self.PopTimer - duration;
		if self.PopTimer < 0 then
			if self.PopDirection > 0 then
				PerformOpen();
			else
				PerformClose();
			end
		end
	end
end
local function GUI_OnLeave(self, ...)
	PopBack(GUI, ...);
end;
local function GUI_OnEnter(self, ...)
	PopOut(GUI, ...);
end;
local function ResizeEntries(frame)
	local width = GUI:GetWidth() - 16;
	for k, v in ipairs(frames[frame].items) do
		if v.isentry then
			if v.text then
				local button = v.checkbutton;
				local text = v.text;
				local editbox = v.editbox;
				local _, _, _, _, yOfs = text:GetPoint();
				local newpoint = (width/2) - (text:GetWidth()/2) - (editbox:GetWidth()/2) + button:GetWidth()/2;
				text:SetPoint("LEFT", newpoint, yOfs); 
			end
		end
	end
	if frames[frame].pages ~= nil and #frames[frame].pages > 0 then
		if frames[frame].pages[frames[frame].currentpage].items then
			for k, v in ipairs(frames[frame].pages[frames[frame].currentpage].items) do
				if v.isentry then
					local button = v.checkbutton;
					local text = v.text;
					local editbox = v.editbox;
					local _, _, _, _, yOfs = text:GetPoint();
					local newpoint = (width/2) - (text:GetWidth()/2) - (editbox:GetWidth()/2) + button:GetWidth()/2;
					text:SetPoint("LEFT", newpoint, yOfs); 
				end
			end
		end
	end
end
local function Resize(frame, reset)
	local reset = reset and true or false;
	if frames[frame] ~= nil and frames[frame]:IsShown() then
		local width = main_width;
		local height = 12;
		for k, v in ipairs(frames[frame].items) do
			height = height + v:GetHeight() + 4
			if v.isentry then
				local temp = v.checkbutton:GetWidth() + v.text:GetStringWidth() + v.editbox:GetWidth() + 16;
				if temp > width then
					width = temp;
				end
			elseif v.ismenu then
				local temp = v.menu:GetWidth() + 16;
				if temp > width then
					width = temp;
				end
			elseif v.istext then
				local temp = 0;
				if v.text then
					temp = v.text:GetStringWidth() + 64;
				end
				if temp > width then
					width = temp;
				end
			end
		end
		if frames[frame].pages ~= nil and #frames[frame].pages > 0 then
			for k, v in ipairs(frames[frame].pages) do
				local temp = v:GetPageWidth();
				if temp > width then
					width = temp;
				end
			end
			local page_height = 16;
			if frames[frame].pages[frames[frame].currentpage].items then
				for k, v in ipairs(frames[frame].pages[frames[frame].currentpage].items) do
					page_height = page_height + v:GetHeight() + 4;
					if v.isentry then
						local temp = v.checkbutton:GetWidth() + v.text:GetStringWidth() + v.editbox:GetWidth() + 16;
						if temp > width then
							width = temp;
						end
					elseif v.ismenu then
						local temp = v.menu:GetWidth() + 16;
						if temp > width then
							width = temp;
						end
					elseif v.istext then
						local temp = 0;
						if v.text then
							temp = v.text:GetStringWidth() + 64;
						end
						if temp > width then
							width = temp;
						end
					end
				end
			end
			frames[frame].pages[frames[frame].currentpage]:SetHeight(page_height);
			height = height + page_height;
		end
		height = height + 16;
		main_height = height;
		main_width = width;
		main_y = height - 15;
		offset = height - 25;
		GUI:SetWidth(width);
		frames[frame]:SetHeight(height);
		GUI:SetHeight(height);
		ResizeEntries(frame);
		if reset then
			GUI:SetPoint("TOP", UIParent, "TOP", 0, main_y);
		else
			ApplyLayout();
		end
	else
		main_height = main_original_height;
		main_width = main_original_width;
		main_y = main_original_y;
		offset = original_offset;
		GUI:SetWidth(main_original_width);
		GUI:SetHeight(main_original_height);	
		if reset then
			GUI:SetPoint("TOP", UIParent, "TOP", 0, main_original_y);
		else
			ApplyLayout();
		end
	end
end
local function NumberOfFrames()
	local num_frames = 0;
	for k, v in pairs(frames) do
		num_frames = num_frames + 1;
	end
	return num_frames;
end
local function ChangeMainPageBack()
	local num_frames = NumberOfFrames();
	if num_frames > 1 then
		for k, v in pairs(frames) do
			if k ~= current_frame then
				frames[current_frame]:Hide();
				current_frame = k;
				v:Show();
				main_height = main_original_height;
				main_width = main_original_width;
				main_y = main_orignal_y;
				Resize(current_frame);
				return;
			end
		end
	end
end
local function ChangeMainPageForward()
	local num_frames = NumberOfFrames();
	if num_frames > 1 then
		for k, v in pairs(frames) do
			if k ~= current_frame then
				frames[current_frame]:Hide();
				current_frame = k;
				v:Show();
				main_height = main_original_height;
				main_width = main_original_width;
				main_y = main_orignal_y;
				Resize(current_frame);
				return;
			end
		end	
	end
end
local function ChangePageBack(frame, page)
	local num_pages = #frame.pages;
	if num_pages >= page then
		local next_page = page-1;
		if next_page == 0 then
			next_page = num_pages;
		end
		frame.pages[next_page]:Show();
		frame.pages[page]:Hide();
		frame.currentpage = next_page;
		Resize(frame.name);
	end
end
local function ChangePageForward(frame, page)
	local num_pages = #frame.pages;
	if num_pages >= page then
		local next_page = page+1;
		if next_page > num_pages then
			next_page = 1;
		end
		frame.pages[next_page]:Show();
		frame.pages[page]:Hide();
		frame.currentpage = next_page;
		Resize(frame.name);
	end
end
-----------------------------------------------
----- Local functions to create the frames ----
-----------------------------------------------
local function CreateText(frame, text)
	local textran = ni.utils.generaterandomname();
	local TextFrame = frame:CreateFontString(textran, "OVERLAY", "GameFontHighlight");
	TextFrame:SetPoint("CENTER", 0, 0);
	local pad = ""
	for i = 1, random(1,255) do pad = pad .. "\124r" end
	TextFrame:SetText(pad .. text);
	TextFrame:SetTextHeight(12);
	TextFrame:SetJustifyH("CENTER");
	TextFrame:SetJustifyV("CENTER");
	return TextFrame;
end
local function CreateCheckBox(frame, t, settings, callback)
	local buttran = ni.utils.generaterandomname()
	local CheckButton = CreateFrame("CheckButton", buttran, frame, "OptionsBaseCheckButtonTemplate");
	CheckButton:SetPoint("LEFT", 0, 0);
	CheckButton:SetSize(26, 26);
	CheckButton:SetChecked(t.enabled);
	CheckButton:SetHitRectInsets(0,0,0,0);
	CheckButton:SetScript("OnClick", function(self)
			if self:GetChecked() then
				t.enabled = true;
			else
				t.enabled = false;
			end
			if settings ~= nil and t.key ~= nil then
				frames[current_frame].settings[t.key.."_enabled"] = t.enabled;
				ni.utils.savesetting(settings, frames[current_frame].settings);
			end
			if callback ~= nil and t.key ~= nil then
				callback(t.key, "enabled", t.enabled);
			end
		end);
	return CheckButton;
end
local function CreateBlankSquare(frame)
	local blankran = ni.utils.generaterandomname();
	local Frame = CreateFrame("frame", blankran, frame);
	Frame:SetSize(26, 26);
	Frame:Show();
	return Frame;
end;
local function CreateEditBox(frame, t, settings, callback)
	local editran = ni.utils.generaterandomname();
	local EditBox = CreateFrame("EditBox", editran, frame);
	if t.width then
		EditBox:SetSize(t.width, 14);
	else
		EditBox:SetSize(30, 14);
	end
	EditBox:SetAutoFocus(false);
	EditBox:EnableMouseWheel(1);
	EditBox:SetFontObject("GameFontHighlight");
	EditBox:SetPoint("RIGHT", -4, 0);
	EditBox:SetJustifyH("CENTER");
	EditBox:SetJustifyV("CENTER");
	EditBox:EnableMouse(true);
	EditBox:SetBackdrop({
		bgFile = "Interface/Buttons/WHITE8X8",
		edgeFile = "Interface/Buttons/WHITE8X8",
		edgeSize = 1,
	});
    EditBox:SetBackdropColor(0,0,0,0.5)
    EditBox:SetBackdropBorderColor(.8,.8,.8,.5)
	EditBox:SetMultiLine(false);
	EditBox:SetText(t.value);
	EditBox:SetScript("OnMouseWheel", function(self, arg)
		if t.max and t.min then
			local step = t.step or 1;
			local temp = tonumber(self:GetText()) or t.min or 0;
			if arg == 1 then
				if temp == t.max then
					return;
				end
				temp = temp + step;
			elseif arg == -1 then
				if temp == t.min then
					return;
				end
				temp = temp - step;
			end
			if temp > t.max then
				temp = t.max;
			elseif temp < t.min then
				temp = t.min;
			end
			t.value = temp;
			self:SetText(t.value);
			self:ClearFocus();
			if settings ~= nil and t.key ~= nil then
				frames[current_frame].settings[t.key.."_value"] = t.value;
				ni.utils.savesetting(settings, frames[current_frame].settings);
			end
			if callback ~= nil and t.key ~= nil then
				callback(t.key, "value", t.value);
			end
		end
	end)
	EditBox:SetScript("OnEnterPressed", function(self)
		local temp = tonumber(self:GetText()) or t.min or 0;
		if t.max then
			if temp > t.max then
				t.value = t.max;
				self:SetText(t.value);
				self:ClearFocus();
				if settings ~= nil and t.key ~= nil then
					frames[current_frame].settings[t.key.."_value"] = t.value;
					ni.utils.savesetting(settings, frames[current_frame].settings);
				end			
				if callback ~= nil and t.key ~= nil then
					callback(t.key, "value", t.value);
				end
				return;
			end
		end
		if t.min then
			if temp < t.min then
				t.value = t.min;
				self:SetText(t.value);
				self:ClearFocus();
				if settings ~= nil and t.key ~= nil then
					frames[current_frame].settings[t.key.."_value"] = t.value;
					ni.utils.savesetting(settings, frames[current_frame].settings);
				end
				if callback ~= nil and t.key ~= nil then
					callback(t.key, "value", t.value);
				end
				return;
			end
		end
		t.value = temp;
		if settings ~= nil and t.key ~= nil then
			frames[current_frame].settings[t.key.."_value"] = t.value;
			ni.utils.savesetting(settings, frames[current_frame].settings);
		end
		if callback ~= nil and t.key ~= nil then
			callback(t.key, "value", t.value);
		end
		self:ClearFocus();
	end)
	EditBox:SetScript("OnEscapePressed", function(self)
		self:SetText(t.value);
		self:ClearFocus();
	end)
	return EditBox;
end
local function CreateInput(frame, t, settingsfile, callback)
	local f;
	local distance = -16;
	if frames[frame].currentpage then
		f = frames[frame].pages[frames[frame].currentpage];
		distance = -22;
	else
		f = frames[frame];
	end
	if t.height then
		distance = distance + 18 - t.height;
	end
	if not f.items then
		f.items = { };
	end
	local id = #f.items + 1;
	local tempran = ni.utils.generaterandomname();
	local TempFrame = CreateFrame("frame", tempran, f);
	TempFrame:SetPoint("CENTER");
	if t.height then
		TempFrame:SetHeight(t.height + 2);
	else
		TempFrame:SetHeight(16);
	end
	local width = 70;
	if t.width then
		width = t.width;
	end
	TempFrame:SetWidth(width + 16);
	TempFrame:Show();
	local Box;
	local scroll_frame;
	local scroll_frame_name;
	local up;
	local down;
	if t.wordwrap then
		scroll_frame_name = ni.utils.generaterandomname();
		scroll_frame = CreateFrame("ScrollFrame", scroll_frame_name, TempFrame, "UIPanelScrollFrameTemplate");
		scroll_frame:SetHeight(TempFrame:GetHeight());
		scroll_frame:SetWidth(width);
		local bar = _G[scroll_frame_name.."ScrollBar"];
		up = _G[scroll_frame_name.."ScrollBarScrollUpButton"];
		down = _G[scroll_frame_name.."ScrollBarScrollDownButton"];
		bar:UnregisterAllEvents();
		bar:SetScript("OnShow", bar.Hide);
		Box = CreateFrame("EditBox", nil, TempFrame);
	else
		Box = CreateFrame("EditBox", nil, TempFrame);
	end
	if t.height then
		Box:SetHeight(t.height);
	else
		Box:SetHeight(14);
	end
	Box:SetAutoFocus(false);
	Box:SetFontObject("GameFontHighlight");
	Box:EnableMouse(true);
	Box:EnableMouseWheel(1);
	if t.wordwrap then
		Box:SetMultiLine(true);
		Box:SetWidth(width + 14);
		scroll_frame:SetAllPoints(TempFrame);
		scroll_frame:SetScrollChild(Box);
		scroll_frame:SetBackdrop({
			bgFile = "Interface/Buttons/WHITE8X8",
			edgeFile = "Interface/Buttons/WHITE8X8",
			edgeSize = 1,
		});
		scroll_frame:SetBackdropColor(0,0,0,0.5);
		scroll_frame:SetBackdropBorderColor(.8,.8,.8,.5);
		Box:ClearAllPoints();
		Box:SetPoint("TOP", TempFrame, "TOP", 0, 0);
		Box:SetPoint("BOTTOM", TempFrame, "BOTTOM", 0, 0);
		Box:SetTextInsets(5, 5, 3, 3);
	else
		Box:SetWidth(width);
		Box:SetPoint("CENTER");
		Box:SetJustifyH("CENTER");
		Box:SetJustifyV("CENTER");
		Box:SetBackdrop({
			bgFile = "Interface/Buttons/WHITE8X8",
			edgeFile = "Interface/Buttons/WHITE8X8",
			edgeSize = 1,
		});
		Box:SetBackdropColor(0,0,0,0.5);
		Box:SetBackdropBorderColor(.8,.8,.8,.5);
	end
	Box:SetText(t.value);
	Box:SetScript("OnMouseWheel", function(self, arg)
		if t.wordwrap then
			if arg == 1 then
				up:Click();
			else
				down:Click();
			end
		elseif t.max and t.min then
			local step = t.step or 1;
			local temp = tonumber(self:GetText()) or t.min or 0;
			if arg == 1 then
				if temp == t.max then
					return;
				end
				temp = temp + step;
			elseif arg == -1 then
				if temp == t.min then
					return;
				end
				temp = temp - step;
			end
			if temp > t.max then
				temp = t.max;
			elseif temp < t.min then
				temp = t.min;
			end
			t.value = temp;
			self:SetText(t.value);
			self:ClearFocus();
			if settingsfile ~= nil and t.key ~= nil then
				frames[current_frame].settings[t.key] = t.value;
				ni.utils.savesetting(settingsfile, frames[current_frame].settings);
			end
			if callback ~= nil and t.key ~= nil then
				callback(t.key, "input", t.value)
			end
		end
	end)
	Box:SetScript("OnEnterPressed", function(self)
		if t.min and t.max then
			local temp = tonumber(self:GetText()) or t.min or 0;
			if t.max then
				if temp > t.max then
					t.value = t.max;
					self:SetText(t.value);
					self:ClearFocus();
					if settingsfile ~= nil and t.key ~= nil then
						frames[current_frame].settings[t.key] = t.value;
						ni.utils.savesetting(settingsfile, frames[current_frame].settings);
					end					
					if callback ~= nil and t.key ~= nil then
						callback(t.key, "input", t.value)
					end
					return;
				end
			end
			if t.min then
				if temp < t.min then
					t.value = t.min;
					self:SetText(t.value);
					self:ClearFocus();
					if settingsfile ~= nil and t.key ~= nil then
						frames[current_frame].settings[t.key] = t.value;
						ni.utils.savesetting(settingsfile, frames[current_frame].settings);
					end					
					if callback ~= nil and t.key ~= nil then
						callback(t.key, "input", t.value)
					end
					return;
				end
			end
			t.value = temp;
			if settingsfile ~= nil and t.key ~= nil then
				frames[current_frame].settings[t.key] = t.value;
				ni.utils.savesetting(settingsfile, frames[current_frame].settings);
			end
			if callback ~= nil and t.key ~= nil then
				callback(t.key, "input", t.value)
			end
			self:ClearFocus();
		else
			t.value = self:GetText();
			if settingsfile ~= nil and t.key ~= nil then
				frames[current_frame].settings[t.key] = t.value;
				ni.utils.savesetting(settingsfile, frames[current_frame].settings);
			end
			if callback ~= nil and t.key ~= nil then
				callback(t.key, "input", t.value)
			end
			self:ClearFocus();
		end
	end)
	Box:SetScript("OnEscapePressed", function(self)
		self:SetText(t.value);
		self:ClearFocus();
	end)
	Box:SetScript("OnEnter", function(self, ...)
		PopOut(GUI, ...);
	end);
	Box:SetScript("OnLeave", function(self, ...) 
		PopBack(GUI, ...);
	end);
	if t.key then
		Box.key = t.key;
	end
	TempFrame.editbox = Box;
	TempFrame.isinput = true;
	f.items[id] = TempFrame;
	if id > 1 then
		TempFrame:SetPoint("TOP", f.items[id-1], "BOTTOM", 0, -4);
	else
		TempFrame:SetPoint("TOP", 0, distance);
	end
end
local function CreateRadial(frame, t, k, settings, callback)
	local checkran = ni.utils.generaterandomname();
	local CheckButton = CreateFrame("CheckButton", checkran, frame, "OptionsBaseCheckButtonTemplate");
	CheckButton:SetSize(0.1, 16);
	CheckButton:SetChecked(t.menu[k].selected);
	CheckButton:SetScript("OnEnter", GUI_OnEnter);
	CheckButton:SetScript("OnLeave", GUI_OnLeave);
	CheckButton:Show();
	function CheckButton.Check(bool)
		t.menu[k].selected = bool;
		CheckButton:SetChecked(bool);
	end;
	CheckButton:SetScript("OnClick", function(self)
		for k, v in pairs(frame:GetParent().items) do
			v.selected.Check(false);
		end
		self.Check(true);
		local text;
		if t.menu[k].text ~= nil then
			text = t.menu[k].text;
		else
			text = tostring(t.menu[k].value);
		end
		if settings ~= nil and t.key ~= nil then
				frames[current_frame].settings[t.key] = text;
				ni.utils.savesetting(settings, frames[current_frame].settings);
		end
		if callback ~= nil and t.key ~= nil then
			callback(t.key, "menu", t.menu[k].value);
		end
		frame:GetParent():GetParent().text:SetText(text);
		frame:GetParent().isshown = false;
		frame:GetParent():Hide();
	end);
	return CheckButton;
end
local function CreateMenuFrame(frame, t, settings, callback)
	local menran = ni.utils.generaterandomname();
	local Frame = CreateFrame("frame", menran, frame);
	Frame:SetBackdrop({
		bgFile = "Interface/Buttons/WHITE8X8",
		edgeFile = "Interface/Buttons/WHITE8X8",
		edgeSize = 0.5,
	});
	Frame:SetPoint("TOP", frame, "BOTTOM");
    Frame:SetBackdropColor(0,0,0,1);
    Frame:SetBackdropBorderColor(.8,.8,.8,1);
	Frame.items = { };
	Frame.isshown = false;
	local height = 0;
	for k, v in ipairs(t.menu) do
		local itran = ni.utils.generaterandomname();
		local id = #Frame.items + 1;
		local item = CreateFrame("frame", itran, Frame);
		item:SetHeight(16);
		local text;
		if v.text == nil then
			text = v.value;
		else
			text = v.text;
		end
		item.text = CreateText(item, text);
		item.text:SetPoint("CENTER");
		item.text:SetJustifyH("CENTER");
		item.text:SetJustifyV("CENTER");
		item.selected = CreateRadial(item, t, k, settings, callback);
		item.selected:SetPoint("LEFT", 0, 0);
		item.selected:SetCheckedTexture(nil)
		item.selected:SetDisabledCheckedTexture(nil);
		local width = item.text:GetStringWidth() + 8;
		item:SetWidth(width);
		Frame.items[id] = item;
		if v.selected then
			frame.text:SetText(text);
		end
		if id > 1 then
			item:SetPoint("TOP", Frame.items[id-1], "BOTTOM", 0, -2);
			height = height + 2;
		else
			item:SetPoint("TOP", 0, -4);
			height = height + 4
		end
		height = height + item:GetHeight();
	end
	local width = 0;
	for k, v in pairs(Frame.items) do
		local temp = v:GetWidth() + 16;
		if temp > width then
			width = temp;
		end
	end
	for k, v in pairs(Frame.items) do
		v:SetWidth(width);
	end
	Frame:SetSize(width, height + 4);
	Frame:SetScript("OnEnter", GUI_OnEnter);
	Frame:SetScript("OnLeave", GUI_OnLeave);
	Frame:Hide();
	return Frame;
end
local function CreateMenu(frame, t, settings, callback)
	local dropran = ni.utils.generaterandomname();
	local DropDownMenu = CreateFrame("Button", dropran, frame);
	local ONUPDATE_INTERVAL = 1;
	local TimeSinceLastUpdate = 0;
	DropDownMenu:SetBackdrop({
		bgFile = "Interface/Buttons/WHITE8X8",
		edgeFile = "Interface/Buttons/WHITE8X8",
		edgeSize = 1,
	});
    DropDownMenu:SetBackdropColor(0,0,0,0.5);
    DropDownMenu:SetBackdropBorderColor(.8,.8,.8,.5);
	DropDownMenu:Show();
	DropDownMenu.text = CreateText(DropDownMenu, "");
	local submenu = CreateMenuFrame(DropDownMenu, t, settings, callback);
	DropDownMenu:SetScript("OnEnter", GUI_OnEnter);
	DropDownMenu:SetScript("OnLeave", GUI_OnLeave);
	DropDownMenu:SetScript("OnClick", function(self, ...)
		if submenu.isshown then
			PopOut(GUI, ...);
			submenu.isshown = false;
			submenu:Hide();		
		else
			PopBack(GUI, ...);
			submenu.isshown = true;
			submenu:Show();	
		end
	end);
	DropDownMenu:SetScript("OnUpdate", function(self, elapsed)
		TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
		if TimeSinceLastUpdate >= ONUPDATE_INTERVAL then
			if submenu.isshown
			and not GUI.isOpen then
				submenu.isshown = false;
				submenu:Hide();	
				TimeSinceLastUpdate = 0;						
			end
		end
	end);	
	local width = 0;
	for k, v in pairs(submenu.items) do
		local temp = v:GetWidth();
		if temp > width then
			width = temp;
		end
	end
	DropDownMenu:SetSize(width, 25);
	return DropDownMenu;
end;
local function CreateEntry(frame, t, settingsfile, callback)
	local f;
	local distance = -16;
	if frames[frame].currentpage then
		f = frames[frame].pages[frames[frame].currentpage];
		distance = -22;
	else
		f = frames[frame];
	end
	if not f.items then
		f.items = { };
	end
	local id = #f.items + 1;
	local entrran = ni.utils.generaterandomname();
	local TempFrame = CreateFrame("frame", entrran, f);
	TempFrame:SetHeight(22);
	TempFrame:SetPoint("LEFT", 6, 0);
	TempFrame:SetPoint("RIGHT", -6, 0);
	TempFrame:Show();
	local combwidth;
	if t.menu == nil then
		local EditBox;
		local CheckButton;
		if t.enabled ~= nil then
			CheckButton = CreateCheckBox(TempFrame, t, settingsfile, callback)
			TempFrame.hascheck = true;
		else
			CheckButton = CreateBlankSquare(TempFrame);
			TempFrame.hascheck = false;
		end
		local cbwidth = CheckButton:GetWidth();
		local cbheight = CheckButton:GetHeight();
		CheckButton:SetPoint("LEFT", 0, -(12-(cbheight/2)));
		CheckButton:SetScript("OnEnter", GUI_OnEnter);
		CheckButton:SetScript("OnLeave", GUI_OnLeave);
		TempFrame.checkbutton = CheckButton;
		local Text = CreateText(TempFrame, t.text);
		TempFrame.text = Text;
		TempFrame.text.istext = true;
		if t.tooltip ~= nil then
			TempFrame:EnableMouse(true);
			TempFrame:SetScript("OnEnter", function(self, ...)
				PopOut(GUI, ...);
				local tooltip = GameTooltip;
				tooltip:Hide();
				tooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT");
				tooltip:ClearLines();
				tooltip:AddLine(t.tooltip);
				tooltip:Show();
			end);
			TempFrame:SetScript("OnLeave", function(self, ...)
				PopBack(GUI, ...);
				local tooltip = GameTooltip;
				tooltip:ClearLines();
				tooltip:Hide();
			end);
		end
		if t.value ~= nil then
			EditBox = CreateEditBox(TempFrame, t, settingsfile, callback);
		else
			EditBox = CreateBlankSquare(TempFrame);
			EditBox:SetPoint("RIGHT", -4, 0);
		end
		EditBox:SetScript("OnEnter", function(self, ...)
			PopOut(GUI, ...);
		end);
		EditBox:SetScript("OnLeave", function(self, ...) 
			PopBack(GUI, ...);
		end);
		TempFrame.editbox = EditBox;
		local twidth = Text:GetWidth();
		local ebwidth = EditBox:GetWidth();
		local theight = Text:GetStringHeight();
		combwidth = cbwidth + twidth + ebwidth + 48;
		Text:SetPoint("LEFT", cbwidth, 0.5);
		TempFrame.isentry = true;
	else
		local Menu = CreateMenu(TempFrame, t, settingsfile, callback);
		Menu:SetPoint("CENTER");
		combwidth = Menu:GetWidth() + 48;
		TempFrame.menu = Menu;
		TempFrame.ismenu = true;
	end
	TempFrame:SetWidth(combwidth);
	f.items[id] = TempFrame;
	if id > 1 then
		TempFrame:SetPoint("TOP", f.items[id-1], "BOTTOM", 0, -4);
	else
		TempFrame:SetPoint("TOP", 0, distance);
	end
end
local function CreateCenteredText(frame, t)
	local f;
	local distance = -16;
	if frames[frame].currentpage then
		f = frames[frame].pages[frames[frame].currentpage];
		distance = -22;
	else
		f = frames[frame];
	end
	if not f.items then
		f.items = { };
	end
	local cenran = ni.utils.generaterandomname();
	local id = #f.items + 1;
	local TempFrame = CreateFrame("frame", cenran, f);
	TempFrame:SetPoint("LEFT", 4, 0);
	TempFrame:SetPoint("RIGHT", -4, 0);
	local text = CreateText(TempFrame, t.text)
	TempFrame.text = text;
	TempFrame.istext = true;
	text:SetPoint("LEFT", 0, 0);
	text:SetPoint("RIGHT", 0, 0);
	if t.tooltip ~= nil then
		TempFrame:SetScript("OnEnter", function(self, ...)
			PopOut(GUI, ...);
			local tooltip = GameTooltip;
			tooltip:Hide();
			tooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT");
			tooltip:ClearLines();
			tooltip:AddLine(t.tooltip);
			tooltip:Show();
		end);
		TempFrame:SetScript("OnLeave", function(self, ...)
			PopBack(GUI, ...);
			local tooltip = GameTooltip;
			tooltip:ClearLines();
			tooltip:Hide();
		end);
	end
	TempFrame:SetHeight(16);
	TempFrame:SetWidth(text:GetWidth() + 16);
	TempFrame:Show();
	f.items[id] = TempFrame;
	if id > 1 then
		TempFrame:SetPoint("TOP", f.items[id-1], "BOTTOM", 0, -4);
	else
		TempFrame:SetPoint("TOP", 0, distance);
	end
end
local function NewFrame(frame)
	local newran = ni.utils.generaterandomname();
	frames[frame] = CreateFrame("frame", newran, GUI);
	frames[frame].name = frame;
	frames[frame]:SetHeight(16);
	frames[frame]:SetPoint("LEFT", 0, 0);
	frames[frame]:SetPoint("RIGHT", 0, 0);
	frames[frame].Close = function(self)
		self:Hide();
		Resize(frame, true);
	end
	frames[frame].Open = function(self)
		self:Show();
		Resize(frame, true);
	end
	frames[frame]:Show();
end
local function CreatePage(frame, page, t)
	local pagran = ni.utils.generaterandomname();
	local Frame = CreateFrame("frame", pagran, frames[frame]);
	Frame.page = page;
	Frame.ispage = true;
	Frame:SetHeight(16);
	Frame:SetPoint("LEFT", 0, 0);
	Frame:SetPoint("RIGHT", 0, 0);
	local lefran = ni.utils.generaterandomname();
	local LeftButton = CreateFrame("Button", lefran, Frame);
	LeftButton:RegisterForClicks("LeftButtonUp");
	LeftButton:SetSize(24, 24);
	LeftButton:SetPoint("TOPLEFT", 4, -1);
	LeftButton:SetNormalTexture("Interface/Buttons/UI-SpellbookIcon-PrevPage-Up");	
	LeftButton:SetPushedTexture("Interface/Buttons/UI-SpellbookIcon-PrevPage-Down");
	LeftButton:SetDisabledTexture("Interface/Buttons/UI-SpellbookIcon-PrevPage-Disabled");
	LeftButton:SetHighlightTexture("Interface/Buttons/UI-Common-MouseHilight", "ADD");
	LeftButton:SetScript("OnClick", function(...)
		ChangePageBack(frames[frame], Frame.page);
	end);
	LeftButton:SetScript("OnEnter", function(self, ...)
		PopOut(GUI, ...);
	end);
	LeftButton:SetScript("OnLeave", function(self, ...)
		PopBack(GUI, ...);
	end);
	Frame.leftbutton = LeftButton;
	local rigthran = ni.utils.generaterandomname();
	local RightButton = CreateFrame("Button", ni.rigthran, Frame);
	RightButton:RegisterForClicks("LeftButtonUp");
	RightButton:SetSize(24, 24);
	RightButton:SetPoint("TOPRIGHT", -4, -1);
	RightButton:SetNormalTexture("Interface/Buttons/UI-SpellbookIcon-NextPage-Up");	
	RightButton:SetPushedTexture("Interface/Buttons/UI-SpellbookIcon-NextPage-Down");
	RightButton:SetDisabledTexture("Interface/Buttons/UI-SpellbookIcon-NextPage-Disabled");
	RightButton:SetHighlightTexture("Interface/Buttons/UI-Common-MouseHilight", "ADD");
	RightButton:SetScript("OnClick", function(...)
		ChangePageForward(frames[frame], Frame.page);
	end);
	RightButton:SetScript("OnEnter", function(self, ...)
		PopOut(GUI, ...);
	end);
	RightButton:SetScript("OnLeave", function(self, ...)
		PopBack(GUI, ...);
	end);
	Frame.rightbutton = RightButton;
	local TextFrame;
	if t.text ~= nil then
		TextFrame = CreateText(Frame, t.text);
		TextFrame:SetPoint("TOPLEFT", 0, -6);
		TextFrame:SetPoint("TOPRIGHT", 0, -6);
	end
	Frame.text = TextFrame;
	Frame.GetPageWidth = function(self)
		local width = 0;
		if self.text ~= nil then
			width = width + self.text:GetStringWidth();
		end
		width = width + self.leftbutton:GetWidth() + self.rightbutton:GetWidth() + 16;
		return width;
	end
	local id = #frames[frame].items;
	if id > 1 then
		Frame:SetPoint("TOP", frames[frame].items[id-1], "BOTTOM", 0, -4);
	else
		Frame:SetPoint("TOP", 0, -16);
	end
	if page == 1 then
		Frame:Show();
	else
		Frame:Hide();
	end
	frames[frame].pages[page] = Frame;
end
local function CreateIconFormator(frame)
	local f;
	local distance = -16;
	if frames[frame].currentpage then
		f = frames[frame].pages[frames[frame].currentpage];
		distance = -22;
	else
		f = frames[frame];
	end
	if not f.items then
		f.items = { };
	end
	local id = #f.items + 1;
	local iconran = ni.utils.generaterandomname();
	local iconformator = CreateFrame("frame", iconran, f);
	iconformator:SetHeight(1);
	iconformator:Show();
	iconformator.texture = iconformator:CreateTexture();
	iconformator.texture:SetTexture(0,0,0,0);
	iconformator.texture:SetPoint("LEFT", 0, 0);
	iconformator.texture:SetPoint("RIGHT", 0, 0);
	iconformator.texture:SetHeight(2);
	iconformator:SetPoint("LEFT", 4, 0);
	iconformator:SetPoint("RIGHT", -4, 0);
	f.items[id] = iconformator;
	if id > 1 then
		iconformator:SetPoint("TOP", f.items[id-1], "BOTTOM", 0, -4);
	else
		iconformator:SetPoint("TOP", 0, distance);
	end
end
local function CreateSeparator(frame)
	local f;
	local distance = -16;
	if frames[frame].currentpage then
		f = frames[frame].pages[frames[frame].currentpage];
		distance = -22;
	else
		f = frames[frame];
	end
	if not f.items then
		f.items = { };
	end
	local id = #f.items + 1;
	local sepran = ni.utils.generaterandomname();
	local separator = CreateFrame("frame", sepran, f);
	separator:SetHeight(4);
	separator:Show();
	separator.texture = separator:CreateTexture();
	separator.texture:SetTexture(.8,.8,.8,.5);
	separator.texture:SetPoint("LEFT", 0, 0);
	separator.texture:SetPoint("RIGHT", 0, 0);
	separator.texture:SetHeight(2);
	separator:SetPoint("LEFT", 4, 0);
	separator:SetPoint("RIGHT", -4, 0);
	f.items[id] = separator;
	if id > 1 then
		separator:SetPoint("TOP", f.items[id-1], "BOTTOM", 0, -4);
	else
		separator:SetPoint("TOP", 0, distance);
	end
end
local function ToggleFrame(frame)
	if frames[frame]:IsShown() then
		frames[frame]:Hide();
	else
		frames[frame]:Show();
	end
end
local next = next
local function UpdateSettings(name, t)
	if t.settingsfile then
		local settings = ni.utils.getsettings(t.settingsfile);
		frames[name].settings = settings;
		if next(settings) then
			for k, v in ipairs(t) do
				if v.type == "entry" and v.key ~= nil then
					if v.enabled ~= nil then
						local bool = settings[v.key.."_enabled"];
						if bool ~= nil then
							v.enabled = bool;
							if t.callback then
								t.callback(v.key, "enabled", v.enabled)
							end
						end
					end
					if v.value ~= nil then
						local value = settings[v.key.."_value"];
						if value ~= nil then
							v.value = value;
							if t.callback then
								t.callback(v.key, "value", v.value)
							end
						end
					end
				elseif v.type == "dropdown" and v.key ~= nil then
					local value = settings[v.key];
					if value ~= nil then
						local selected;
						for _, v2 in ipairs(v.menu) do
							local text;
							if v2.text ~= nil then
								text = v2.text;
							else
								text = v2.value;
							end
							if tostring(text) == value then
								v2.selected = true;
								selected = v2.value;
							else
								v2.selected = false;
							end
						end
						if t.callback then
							t.callback(v.key, "menu", selected)
						end
					end
				elseif v.type == "input" and v.key ~= nil then
					local value = settings[v.key];
					if value ~= nil then
						v.value = value;
						if t.callback then
							t.callback(v.key, "input", v.value)
						end
					end
				end
			end
		end
	end
end
local function ApplySettings(name, t)
	if t.settingsfile then
		UpdateSettings(name, t);
	end
	for k, v in ipairs(t) do
		if v.type == "title" then
			CreateCenteredText(name, v);
		elseif v.type == "separator" then
			CreateSeparator(name);
		elseif v.type == "formator" then
			CreateIconFormator(name);
		elseif v.type == "entry" then
			CreateEntry(name, v, t.settingsfile, t.callback);
		elseif v.type == "dropdown" then
			CreateEntry(name, v, t.settingsfile, t.callback);
		elseif v.type == "input" then
			CreateInput(name, v, t.settingsfile, t.callback);
		elseif v.type == "page" then
			if frames[name].pages == nil then
				frames[name].pages = { };
			end
			CreatePage(name, v.number, v);
			frames[name].currentpage = v.number;
		end
	end
end
local function HideMainPages()
	GUI.leftbutton:Hide();
	GUI.rightbutton:Hide();
end
local function ShowMainPages()
	GUI.leftbutton:Show();
	GUI.rightbutton:Show();
end
local function CreatedFramesByName()
	table.wipe(framenames);
	for k, v in pairs(frames) do
		if v.name then
			table.insert(framenames, v.name);
		end
	end
	return framenames;
end
local function GetStoredTable(name)
	for k, v in pairs(storedframes) do
		if v.name == name then
			return k;
		end
	end
	return nil;
end
GUI:ClearAllPoints();
GUI:SetFrameLevel(0);
GUI:SetWidth(main_width);
GUI:SetHeight(main_height);
GUI:EnableMouse(true);
GUI:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
				edgeFile = "Interface/Buttons/WHITE8X8", 
				tile = true, tileSize = 16, edgeSize = 2, 
				insets = { left = 2, right = 2, top = 2, bottom = 2 }});
GUI:SetBackdropColor(.1,.1,.1,1);
GUI:SetBackdropBorderColor(.3,.3,.3,.75, 15)
GUI:SetPoint("TOP", UIParent, "TOP", 0, main_y);
GUI:SetScript("OnEnter", function(self, ...)
	PopOut(self, ...);
end);
GUI:SetScript("OnLeave", function(self, ...) 
	PopBack(self, ...);
end);
GUI:SetScript("OnUpdate", function(self, ...)
	Popper(self, ...);
end);
local LeftButton = CreateFrame("Button", nil, GUI);
LeftButton:RegisterForClicks("LeftButtonUp");
LeftButton:SetSize(24, 24);
LeftButton:SetPoint("TOPLEFT", 4, -9);
LeftButton:SetNormalTexture("Interface/Buttons/UI-SpellbookIcon-PrevPage-Up");	
LeftButton:SetPushedTexture("Interface/Buttons/UI-SpellbookIcon-PrevPage-Down");
LeftButton:SetDisabledTexture("Interface/Buttons/UI-SpellbookIcon-PrevPage-Disabled");
LeftButton:SetHighlightTexture("Interface/Buttons/UI-Common-MouseHilight", "ADD");
LeftButton:SetScript("OnClick", function(...)
	ChangeMainPageBack();
end);
LeftButton:SetScript("OnEnter", function(self, ...)
	PopOut(GUI, ...);
end);
LeftButton:SetScript("OnLeave", function(self, ...)
	PopBack(GUI, ...);
end);
LeftButton:Hide();
GUI.leftbutton = LeftButton;
local RightButton = CreateFrame("Button", nil, GUI);
RightButton:RegisterForClicks("LeftButtonUp");
RightButton:SetSize(24, 24);
RightButton:SetPoint("TOPRIGHT", -4, -9);
RightButton:SetNormalTexture("Interface/Buttons/UI-SpellbookIcon-NextPage-Up");	
RightButton:SetPushedTexture("Interface/Buttons/UI-SpellbookIcon-NextPage-Down");
RightButton:SetDisabledTexture("Interface/Buttons/UI-SpellbookIcon-NextPage-Disabled");
RightButton:SetHighlightTexture("Interface/Buttons/UI-Common-MouseHilight", "ADD");
RightButton:SetScript("OnClick", function(...)
	ChangeMainPageForward();
end);
RightButton:SetScript("OnEnter", function(self, ...)
	PopOut(GUI, ...);
end);
RightButton:SetScript("OnLeave", function(self, ...)
	PopBack(GUI, ...);
end);
RightButton:Hide();
GUI.rightbutton = RightButton;
GUI:SetFrameLevel(100);
GUI:Show();
CreatedFramesByName()
if #framenames == 0 then
	GUI:Hide();
else
	GUI:Show();
end
GUI.GetFrame = function(name)
	return frames[name];
end
GUI.AddFrame = function(name, t)
	local k = GetStoredTable(name);
	if k == nil then
		NewFrame(name);
		ApplySettings(name, t);
		if frames[name].pages and #frames[name].pages > 0 then
			frames[name].currentpage = 1;
		end
	else
		local f = table.remove(storedframes, k);
		rawset(frames, name, f);
	end
	local num_frames = NumberOfFrames();
	if num_frames == 0 then
		GUI:Hide();
	else
		main_height = main_original_height;
		main_width = main_original_width;
		main_y = main_orignal_y;
		if num_frames > 1 then
			ShowMainPages();
			frames[name]:Hide();
			Resize(current_frame);
			frames[current_frame]:Show();
		else
			HideMainPages();
			current_frame = name;
			frames[name]:Show();
			Resize(name, true);
		end
		GUI:Show();
	end
end;
GUI.DestroyFrame = function(name)
	local temp = GUI.GetFrame(name);
	if temp ~= nil then
		temp:Hide();
		table.insert(storedframes, temp);
		frames[name] = nil;
	end
	CreatedFramesByName()
	if #framenames == 0 then
		GUI:Hide();
	else
		main_width = main_original_width;
		main_height = main_original_height;
		main_y = main_original_y;
		if #framenames > 1 then
			ShowMainPages();
		else
			HideMainPages();
		end
		if current_frame == name then
			for k, v in pairs(frames) do
				current_frame = k;
				break;
			end
		end
		frames[current_frame]:Show();
		Resize(current_frame);
		GUI:Show();
	end
end
return GUI;
