local enables = {
	["Action"] = false,
}
local values = {
	["Action"] = 1.5,
}
local inputs = {
	["WhatToPrint"] = ""
}
local menus = {
	["Action Event"] = 1
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
	callback = GUICallback,
	{ type = "title", text = "Example GUI" },
	{ type = "separator" },
	{
		type = "entry",
		text = "Perform Action",
		value = values["Action"],
		min = 1.5,
		max = 10,
		step = 0.5,
		enabled = enables["Action"],
		width = 40, --The width specified for entries is the editbox width
		tooltip = "Enable this to have the action you select from the dropdown execute at the value specified",
		key = "Action",
	},
	{ type = "title", text = "Input what to print after the action" },
	{
		type = "input",
		value = inputs["WhatToPrint"],
		width = 150,
		height = 100,
		wordwrap = true,
		key = "WhatToPrint"
	},
	{ type = "title", text = "What do you want to do?" },
	{
		type = "dropdown",
		menu = {
			{ selected = (menus["Action Event"] == 1), value = 1, text = "Jump" },
			{ selected = (menus["Action Event"] == 2), value = 2, text = "Move Forward" },
			{ selected = (menus["Action Event"] == 3), value = 3, text = "Move Backward" },
			{ selected = (menus["Action Event"] == 4), value = 4, text = "Strafe Right" },
			{ selected = (menus["Action Event"] == 5), value = 5, text = "Strafe Left" },
		},
		key = "Action Event"
	}		
}
local function OnLoad()
	ni.GUI.AddFrame("GUIExample", items);
end
local function OnUnload()
	ni.GUI.DestroyFrame("GUIExample");
end
local queue = {
	"action",
}
local last_action = 0;
local abilities = {
	["action"] = function()
		if enables["Action"] then
			if GetTime() - last_action > values["Action"] then
				last_action = GetTime();
				if menus["Action Event"] == 1 then
					ni.functions.safeexec("JumpOrAscendStart()");
					local text = inputs["WhatToPrint"];
					if text ~= "" then
						print(text)
					end
				elseif menus["Action Event"] == 2 then
					ni.functions.safeexec("MoveForwardStart()");
					ni.delayfor(0.5, function()
							ni.functions.safeexec("MoveForwardStop()")
							local text = inputs["WhatToPrint"];
							if text ~= "" then
								print(text)
							end
						end);
					ni.rotation.delay(1);
				elseif menus["Action Event"] == 3 then
					ni.functions.safeexec("MoveBackwardStart()");
					ni.delayfor(0.5, function()
							ni.functions.safeexec("MoveBackwardStop()")
							local text = inputs["WhatToPrint"];
							if text ~= "" then
								print(text)
							end
						end);
					ni.rotation.delay(1);
				elseif menus["Action Event"] == 4 then
					ni.functions.safeexec("StrafeRightStart()");
					ni.delayfor(0.5, function()
							ni.functions.safeexec("StrafeRightStop()")
							local text = inputs["WhatToPrint"];
							if text ~= "" then
								print(text)
							end
						end);
					ni.rotation.delay(1);
				elseif menus["Action Event"] == 5 then
					ni.functions.safeexec("StrafeLeftStart()");
					ni.delayfor(0.5, function()
							ni.functions.safeexec("StrafeLeftStop()")
							local text = inputs["WhatToPrint"];
							if text ~= "" then
								print(text)
							end
						end);
					ni.rotation.delay(1);
				end
			end
		end
	end,
}
ni.bootstrap.profile("GUIExample", queue, abilities, OnLoad, OnUnload);