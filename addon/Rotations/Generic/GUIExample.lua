-- Try to localize standart WoW Api and other Lua stuff for faster work
local UnitLevel, ipairs, pairs, tostring, GetTime, print = UnitLevel, ipairs, pairs, tostring, GetTime, print
-- Call and draw GUI;
local items1 = {
	settingsfile = "GUIExample.json", -- Add name for file with settings from GUI;
	{ type = "title", text = "Example GUI" }, -- Call title; 
	{ type = "separator" }, -- Call line ("seperator");
	{ type = "entry", text = ni.spell.icon(59646).." Perform Action", tooltip = "Enable for Auto pick-up healthstoneuse from soulwell", enabled = false, value = 2, min = 1.5, max = 10, step = .5, width = 40, key = "Action" },	-- Call entry with field;
	{ type = "title", text = "Input what to print after the action" },
	{ type = "input", value = "", width = 225, height = 65, wordwrap = true, key = "WhatToPrint" }, -- wordwrap - not nessesary 
	{ type = "title", text = "What do you want to do?" },
	{ type = "dropdown", menu = { -- draw dropdown menu
		{ selected = true, value = 1, text = "Jump" },
		{ selected = false, value = 2, text = "Move Forward" },
		{ selected = false, value = 3, text = "Move Backward" },
		{ selected = false, value = 4, text = "Strafe Right" },
        { selected = false, value = 5, text = "Strafe Left" },
	}, key = "ActionEvent" },
};
-- Call and draw GUI #2;
local items2 = {
	settingsfile = "GUIExampleLow.json", -- Add name for file with settings from GUI;
	{ type = "title", text = "Example GUI Low Level" }, -- Call title; 
	{ type = "separator" }, -- Call line ("seperator");
	{ type = "entry", text = ni.player.itemicon(21353).." Perform Action", tooltip = "Enable for Auto pick-up healthstoneuse from soulwell", enabled = false, value = 3, min = 1.5, max = 10, step = .5, width = 40, key = "Action" },	-- Call entry with field;
};
-- You can call multiply GUI's (GUI only loads when you enter the game or /reload)
local function items()
	if UnitLevel("player") >= 80 then
		return items1
	else
		return items2
	end
end;
-- Call Settings from GUI;
local function GetSetting(name)
    for k, v in ipairs(items()) do
        if v.type == "entry"
		and v.key ~= nil
		and v.key == name then
            return v.value, v.enabled;
        end
        if v.type == "dropdown"
		and v.key ~= nil
		and v.key == name then
            for k2, v2 in pairs(v.menu) do
                if v2.selected then
                    return v2.value;
                end
            end
        end
        if v.type == "input"
		and v.key ~= nil
		and v.key == name then
            return v.value;
        end
    end
end;
-- Load GUI when turn on profile;
local function OnLoad()
	ni.GUI.AddFrame("GUIExample", items());
end;
-- Unload GUI when turn off profile;
local function OnUnLoad() 
	ni.GUI.DestroyFrame("GUIExample");
end;
-- Call queue table
local queue = {
	"action",
};
local last_action = 0;
-- Call abilities table
local abilities = {
	["action"] = function()
		local value, enabled = GetSetting("Action");
		local event = GetSetting("ActionEvent");
		local text = tostring(GetSetting("WhatToPrint"));
		if enabled then
			if GetTime() - last_action > value then
				last_action = GetTime();
				if event == 1 then
					ni.functions.callprotected("JumpOrAscendStart");
					if text ~= "" then
						print(text)
					end
				elseif event == 2 then
					ni.functions.callprotected("MoveForwardStart");
					ni.delayfor(0.5, function()
							ni.functions.callprotected("MoveForwardStop")
							if text ~= "" then
								print(text)
							end
						end);
					ni.rotation.delay(1);
				elseif event == 3 then
					ni.functions.callprotected("MoveBackwardStart");
					ni.delayfor(0.5, function()
							ni.functions.callprotected("MoveBackwardStop")
							if text ~= "" then
								print(text)
							end
						end);
					ni.rotation.delay(1);
				elseif event == 4 then
					ni.functions.callprotected("StrafeRightStart");
					ni.delayfor(0.5, function()
							ni.functions.callprotected("StrafeRightStop")
							if text ~= "" then
								print(text)
							end
						end);
					ni.rotation.delay(1);
				elseif event == 5 then
					ni.functions.callprotected("StrafeLeftStart");
					ni.delayfor(0.5, function()
							ni.functions.callprotected("StrafeLeftStop")
							if text ~= "" then
								print(text)
							end
						end);
					ni.rotation.delay(1);
				end
			end
		end
	end,
};
ni.bootstrap.profile("GUIExample", queue, abilities, OnLoad, OnUnload);