local GetLocale, GetTime, IsLeftShiftKeyDown, GetCurrentKeyBoardFocus, IsLeftControlKeyDown, IsLeftAltKeyDown, IsRightShiftKeyDown, IsRightControlKeyDown, IsRightAltKeyDown = GetLocale, GetTime, IsLeftShiftKeyDown, GetCurrentKeyBoardFocus, IsLeftControlKeyDown, IsLeftAltKeyDown, IsRightShiftKeyDown, IsRightControlKeyDown, IsRightAltKeyDown
local ru = GetLocale() == "ruRU" or false;
local togglemod, cdtogglemod, customtogglemod = 0, 0, 0
local function AddDelay(t)
	ni.vars.profiles.delay = t;
end;
local Localization = {
	Enabled = "\124cff00ff00Enabled",
	Disabled = "\124cffff0000Disabled",
};
if ru then
	Localization.Enabled = "\124cff00ff00Включено"
	Localization.Disabled = "\124cffff0000Выключено"
end;
local rotation = {
	started = false,
	profile = {},
	lastprofile = "",
	lastgeneric = "",
	delay = function(sec)
		local sec = sec or 1;
		local delaytill = GetTime() + sec;
		ni.functions.callprotected(AddDelay, delaytill);
	end,
	custommod = function()
		local mod = ni.vars.hotkeys.custom
		if mod == "Left Shift" then
			if IsLeftShiftKeyDown() and not GetCurrentKeyBoardFocus() then
				return true
			end
		elseif mod == "Left Control" then
			if IsLeftControlKeyDown() and not GetCurrentKeyBoardFocus() then
				return true
			end
		elseif mod == "Left Alt" then
			if IsLeftAltKeyDown() and not GetCurrentKeyBoardFocus() then
				return true
			end
		elseif mod == "Right Shift" then
			if IsRightShiftKeyDown() and not GetCurrentKeyBoardFocus() then
				return true
			end
		elseif mod == "Right Control" then
			if IsRightControlKeyDown() and not GetCurrentKeyBoardFocus() then
				return true
			end
		elseif mod == "Right Alt" then
			if IsRightAltKeyDown() and not GetCurrentKeyBoardFocus() then
				return true
			end
		end
		return false
	end,
	cdmod = function()
		local mod = ni.vars.hotkeys.cd
		if mod == "Left Shift" then
			if IsLeftShiftKeyDown() and not GetCurrentKeyBoardFocus() then
				return true
			end
		elseif mod == "Left Control" then
			if IsLeftControlKeyDown() and not GetCurrentKeyBoardFocus() then
				return true
			end
		elseif mod == "Left Alt" then
			if IsLeftAltKeyDown() and not GetCurrentKeyBoardFocus() then
				return true
			end
		elseif mod == "Right Shift" then
			if IsRightShiftKeyDown() and not GetCurrentKeyBoardFocus() then
				return true
			end
		elseif mod == "Right Control" then
			if IsRightControlKeyDown() and not GetCurrentKeyBoardFocus() then
				return true
			end
		elseif mod == "Right Alt" then
			if IsRightAltKeyDown() and not GetCurrentKeyBoardFocus() then
				return true
			end
		end
		return false
	end,
	cdtoggle = function()
		if ni.vars.profiles.enabled then
			if ni.rotation.cdmod() and GetTime() - cdtogglemod > 0.5 then
				cdtogglemod = GetTime()
				ni.vars.combat.cd = not ni.vars.combat.cd;
				if ni.vars.combat.aoe or ni.vars.combat.cd then
					local aoe_str = ni.vars.combat.aoe and Localization.Enabled or Localization.Disabled;
					local cd_str = ni.vars.combat.cd and Localization.Enabled or Localization.Disabled;
					ni.frames.notification:message("\124cffFFC300AoE: "..aoe_str.." \124cffFFC300CD: "..cd_str);
				elseif not ni.vars.combat.aoe and not ni.vars.combat.cd then
					ni.frames.notification:Hide();
				end
			end
		end
	end,
	aoemod = function()
		local mod = ni.vars.hotkeys.aoe
		if mod == "Left Shift" then
			if IsLeftShiftKeyDown() and not GetCurrentKeyBoardFocus() then
				return true
			end
		elseif mod == "Left Control" then
			if IsLeftControlKeyDown() and not GetCurrentKeyBoardFocus() then
				return true
			end
		elseif mod == "Left Alt" then
			if IsLeftAltKeyDown() and not GetCurrentKeyBoardFocus() then
				return true
			end
		elseif mod == "Right Shift" then
			if IsRightShiftKeyDown() and not GetCurrentKeyBoardFocus() then
				return true
			end
		elseif mod == "Right Control" then
			if IsRightControlKeyDown() and not GetCurrentKeyBoardFocus() then
				return true
			end
		elseif mod == "Right Alt" then
			if IsRightAltKeyDown() and not GetCurrentKeyBoardFocus() then
				return true
			end
		end
		return false
	end,
	aoetoggle = function()
		if ni.rotation.aoemod() and GetTime() - togglemod > 0.5 and ni.vars.profiles.enabled then
			togglemod = GetTime()
			ni.vars.combat.aoe = not ni.vars.combat.aoe;
			if ni.vars.combat.aoe or ni.vars.combat.cd then
				local aoe_str = ni.vars.combat.aoe and Localization.Enabled or Localization.Disabled;
				local cd_str = ni.vars.combat.cd and Localization.Enabled or Localization.Disabled;
				ni.frames.notification:message("\124cffFFC300AoE: "..aoe_str.." \124cffFFC300CD: "..cd_str);
			elseif not ni.vars.combat.aoe and not ni.vars.combat.cd then
				ni.frames.notification:Hide();
			end
		end
	end,
	stopmod = function()
		if ni.vars.hotkeys.pause == "Left Shift" then
			if IsLeftShiftKeyDown() and not GetCurrentKeyBoardFocus() then
				return true
			end
		elseif ni.vars.hotkeys.pause == "Left Control" then
			if IsLeftControlKeyDown() and not GetCurrentKeyBoardFocus() then
				return true
			end
		elseif ni.vars.hotkeys.pause == "Left Alt" then
			if IsLeftAltKeyDown() and not GetCurrentKeyBoardFocus() then
				return true
			end
		elseif ni.vars.hotkeys.pause == "Right Shift" then
			if IsRightShiftKeyDown() and not GetCurrentKeyBoardFocus() then
				return true
			end
		elseif ni.vars.hotkeys.pause == "Right Control" then
			if IsRightControlKeyDown() and not GetCurrentKeyBoardFocus() then
				return true
			end
		elseif ni.vars.hotkeys.pause == "Right Alt" then
			if IsRightAltKeyDown() and not GetCurrentKeyBoardFocus() then
				return true
			end
		end
	end
}
return rotation;