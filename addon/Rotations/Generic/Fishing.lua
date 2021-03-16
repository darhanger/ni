local queue = {
	"action check",
	"combat check",
	"lure check",
	"pause",
	"fish"
}
local enables = {
	lure = false,
	weapon_swap = false,
	pole_check = false,
}
local values = {
	lure = 6532,
}
local inputs = {
	pole = "6256",
	main = "",
	off = "",
	bobber = "Fishing Bobber",
	pool = "School"
}
local menus = {
	full_bags = "AFK",
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
	settingsfile = "ni_fishing.xml",
	callback = GUICallback,
	{ type = "title", text = "Fish Bot" },
	{ type = "separator" },
	{ 
		type = "entry",
		text = "Auto Lure",
		enabled = enables["lure"],
		tooltip = "Enable/Disable to automatically use the lure id specified",
		value = values["lure"],
		width = 50,
		key = "lure",
	},
	{ 
		type = "entry", 
		text = "Auto Swap Weapons for Combat",
		enabled = enables["weapon_swap"],
		tooltip = "Enable/Disable this for the profile to swap weapons to the id's you specifiy below",
		key = "weapon_swap"
	},
	{ type = "title", text = "Fishing Pool/School Name" },
	{
		type = "input",
		value = inputs["pool"],
		width = 140,
		height = 15,
		key = "pool"
	},
	{ type = "title", text = "Fishing Bobber Name" },
	{
		type = "input",
		value = inputs["bobber"],
		width = 140,
		height = 15,
		key = "bobber"
	},
	{
		type = "entry",
		text = "Check if pole equipped",
		tooltip = "This is for checking if you have the pole equipped before trying to cast the fishing spell",
		enabled = enables["pole_check"],
		key = "pole_check"
	},
	{ type = "title", text = "Fishing Pole ID" },
	{
		type = "input",
		value = inputs["pole"],
		widht = 100,
		height = 15,
		key = "pole"
	},
	{ type = "title", text = "Main Hand ID" },
	{
		type = "input",
		value = inputs["main"],
		widht = 100,
		height = 15,
		key = "main"
	},
	{ type = "title", text = "Off Hand ID" },
	{
		type = "input",
		value = inputs["off"],
		widht = 100,
		height = 15,
		key = "off"
	},
	{ type = "title", text = "What to do on full bags?" },
	{
		type = "dropdown",
		menu = {
			{ selected = (menus["full_bags"] == "AFK"), value = "AFK" },
			{ selected = (menus["full_bags"] == "Hearthstone"), value = "Hearthstone" },
			{ selected = (menus["full_bags"] == "Logout"), value = "Logout" },
		},
		key = "full_bags",
	},
}
local function OnLoad()
	ni.GUI.AddFrame("Fishing", items);
end
local function OnUnload()
	ni.GUI.DestroyFrame("Fishing");
end
local function FullBags()
	local fullbags = 0;
	for i = 0, 4 do
		if GetContainerNumFreeSlots(i) == 0 then
			fullbags = fullbags + 1
		end
	end
	return fullbags == 5
end
local Fishing = GetSpellInfo(7620);
local offset;
if ni.vars.build == 40300 then
	offset = 0xD4;
elseif ni.vars.build > 40300 then
	offset = 0xCC;
else
	offset = 0xBC;
end
local functionsent = 0;
local lure_applied = 0;
local abilities = {
	["action check"] = function()
		if FullBags() then
			local action = menus["full_bags"];
			if action == "AFK" then
				ni.frames.floatingtext:message("Bags are full, time to AFK!");
				ni.vars.profiles.enabled = false;
			elseif action == "Hearthstone" then
				if not UnitAffectingCombat("player")
				 and not UnitCastingInfo("player")
				 and not UnitChannelInfo("player") then
					ni.player.useitem(6948);
					ni.frames.floatingtext:message("Bags are full, time to go home!");
					ni.vars.profiles.enabled = false;
				end
			elseif action == "Logout" then
				if not UnitAffectingCombat("player") then
					ni.player.runtext("/logout");
					ni.frames.floatingtext:message("Bags are full, time to logout!");
					ni.vars.profiles.enabled = false;
				end
			end
		end
	end,
	["combat check"] = function()
		if enables["weapon_swap"] and not UnitIsDeadOrGhost("player") then
			local pole = tonumber(inputs["pole"]);
			local mh = tonumber(inputs["main"]);
			local oh = tonumber(inputs["off"]);
			if pole and mh then
				if UnitAffectingCombat("player") then
					if IsEquippedItem(pole) then
						EquipItemByName(mh);
						if oh then
							EquipItemByName(oh);
						end
						return true;
					end
				else
					if not IsEquippedItem(pole) then
						EquipItemByName(pole);
						return true;
					end
				end
			end
		end
	end,
	["lure check"] = function()
		local pole = tonumber(inputs["pole"]);
		if enables["lure"] and pole then
			if GetTime() - lure_applied < 4 then
				return false;
			end
			local lure_enchant = GetWeaponEnchantInfo();
			if IsEquippedItem(pole)
			 and not lure_enchant
			 and not UnitAffectingCombat("player")
			 and ni.player.hasitem(values["lure"]) then
				lure_applied = GetTime();
				ni.spell.stopcasting();
				ni.spell.stopchanneling();
				ni.player.useitem(values["lure"]);
				ni.player.useinventoryitem(16);
				ni.player.runtext("/click StaticPopup1Button1");
				return true;
			end
		end
	end,
	["pause"] = function()
		if IsMounted()
		 or UnitInVehicle("player")
		 or UnitIsDeadOrGhost("player")
		 or UnitCastingInfo("player")
		 or UnitAffectingCombat("player")
		 or ni.player.ismoving() then
			return true;
		end
	end,
	["fish"] = function()
		if enables["pole_check"] then
			local pole = tonumber(inputs["pole"]);
			if not IsEquippedItem(pole) then
				return;
			end
		end
		if ni.player.islooting() then
			return
		end
		if UnitChannelInfo("player") then
			if GetTime() - functionsent > 1 then
				local playerguid = UnitGUID("player");
				for k, v in pairs(ni.objects) do
					if type(k) ~= "function" and (type(k) == "string" and type(v) == "table") then
						if v.name == inputs["bobber"] then
							local creator = v:creator();
							if creator == playerguid then
								local ptr = ni.memory.objectpointer(v.guid);
								if ptr then
									local result = ni.memory.read("byte", ptr, offset);
									if result == 1 then
										ni.player.interact(v.guid);
										functionsent = GetTime();
										return true;
									end
								end
							end 
						end
					end
				end
			end
		else
			for k, v in pairs(ni.objects) do
				if type(v) ~= "function" and v.name ~= nil and string.match(v.name, inputs["pool"]) then
					local dist = ni.player.distance(k);
					if dist ~= nil and dist < 20 then
						ni.player.lookat(k);
						break;
					end
				end
			end
			ni.spell.delaycast(Fishing, nil, 1.5);
			ni.utils.resetlasthardwareaction();
		end
	end,
}
ni.bootstrap.profile("Fishing", queue, abilities, OnLoad, OnUnload);