local GetLocale, GetTime, IsLeftShiftKeyDown, GetCurrentKeyBoardFocus, IsLeftControlKeyDown, IsLeftAltKeyDown, IsRightShiftKeyDown, IsRightControlKeyDown, IsRightAltKeyDown = GetLocale, GetTime, IsLeftShiftKeyDown, GetCurrentKeyBoardFocus, IsLeftControlKeyDown, IsLeftAltKeyDown, IsRightShiftKeyDown, IsRightControlKeyDown, IsRightAltKeyDown
local ru = ni.vars.locale == "ruRU" or false;
local togglemod, cdtogglemod = 0, 0;
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
local modKeys = {
	["Left Shift"] = IsLeftShiftKeyDown,
	["Left Control"] = IsLeftControlKeyDown,
	["Left Alt"] = IsLeftAltKeyDown,
	["Right Shift"] = IsRightShiftKeyDown,
	["Right Control"] = IsRightControlKeyDown,
	["Right Alt"] = IsRightAltKeyDown
};
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
		local mod = ni.vars.hotkeys.custom;
		if modKeys[mod] and modKeys[mod]() and not GetCurrentKeyBoardFocus() then
			return true;
		end
		return false;
	end,
	cdmod = function()
		local mod = ni.vars.hotkeys.cd;
		if modKeys[mod] and modKeys[mod]() and not GetCurrentKeyBoardFocus() then
			return true;
		end
		return false;
	end,
	aoemod = function()
		local mod = ni.vars.hotkeys.aoe;
		if modKeys[mod] and modKeys[mod]() and not GetCurrentKeyBoardFocus() then
			return true;
		end
		return false;
	end,
	stopmod = function()
		local mod = ni.vars.hotkeys.pause;
		if modKeys[mod] and modKeys[mod]() and not GetCurrentKeyBoardFocus() then
			return true;
		end
		return false;
	end,
	cdtoggle = function()
		if ni.vars.profiles.enabled then
			if ni.rotation.cdmod() and GetTime() - cdtogglemod > 0.5 then
				cdtogglemod = GetTime()
				ni.vars.combat.cd = not ni.vars.combat.cd;
				if ni.vars.combat.aoe or ni.vars.combat.cd then
					local aoe_str = ni.vars.combat.aoe and Localization.Enabled or Localization.Disabled;
					local cd_str = ni.vars.combat.cd and Localization.Enabled or Localization.Disabled;
					ni.frames.notification:message(format("|cffFFC300AoE: %s |cffFFC300CD: %s", aoe_str, cd_str));
				elseif not ni.vars.combat.aoe and not ni.vars.combat.cd then
					ni.frames.notification:Hide();
				end
			end
		end
	end,
	aoetoggle = function()
		if ni.rotation.aoemod() and GetTime() - togglemod > 0.5 and ni.vars.profiles.enabled then
			togglemod = GetTime()
			ni.vars.combat.aoe = not ni.vars.combat.aoe;
			if ni.vars.combat.aoe or ni.vars.combat.cd then
				local aoe_str = ni.vars.combat.aoe and Localization.Enabled or Localization.Disabled;
				local cd_str = ni.vars.combat.cd and Localization.Enabled or Localization.Disabled;
				ni.frames.notification:message(format("|cffFFC300AoE: %s |cffFFC300CD: %s", aoe_str, cd_str));
			elseif not ni.vars.combat.aoe and not ni.vars.combat.cd then
				ni.frames.notification:Hide();
			end
		end
	end,
};
return rotation;