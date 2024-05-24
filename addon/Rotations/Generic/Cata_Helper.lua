local cata = ni.vars.build == 40300 or false;
if cata then
local LastInteract, LastLoot = 0, 0;
local items = {
	settingsfile = "Cata_Helper.json",
	{ type = "title", text = ">   Cataclysm Helper by |c0000CED1DarhangeR|r   <" },
	{ type = "separator" },
	{ type = "title", text = "|cff00C957Profile version 0.0.1|r" },
	{ type = "separator" },
	{ type = "title", text = "|cffFFFF00Main Settings|r" },
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(58856, 22, 22).." Auto Loot", tooltip = "Automatic loot without clicking on corpse.\nOnly works with defeated (killed) enemies.\n|cffFF0D00Does not work on chests, etc.|r", enabled = false, key = "AutoLoot" },
	{ type = "entry", text = ni.spell.icon(8613, 22, 22).." Skinning (Auto)", tooltip = "Automatically skinning slain enemies. (If available).", enabled = false, key = "AutoSkin", },
	{ type = "separator" },
	{ type = "entry", text = "Use Item (By Name)", tooltip = "Use multiple items by name. NOT BY ID!\nUseful when you have a large number of recipes or faction tokens in your inventory.\n|cffFF0D00Leave this field blank after use.|r", enabled = false, key = "useitem", },
	{ type = "input", value = "", width = 160, height = 20, key = "typename" },
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(2382, 22, 22).." |cffffa500Debug Printing|r", tooltip = "Enable for debug if you have problems.", enabled = false, key = "Debuging" },
};
-- Get Setting from GUI -- 
local function GetSetting(name)
	for k, v in ipairs(items) do
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
-- Load GUI / Starting Cache -- 
local function OnLoad()
	ni.GUI.AddFrame("Cata_Helper", items);
end;
-- Unload GUI / Wipe Cache -- 
local function OnUnLoad()
	ni.GUI.DestroyFrame("Cata_Helper");
end;
local spells = {
Skinning = GetSpellInfo(8613),
};
local cache = {
in_combat = false,
is_stuned = false;
is_feared = false;
is_confused = false;
auto_loot_on = false;
is_moving = false;
};
local queue = {
"Cache",
"Universal pause",
"Use Item (By Name)",
"Auto-Loot",
"Skinning",
};
local abilities = {
-----------------------------------
	["Cache"] = function()
		cache.in_combat = UnitAffectingCombat("player") or false;
		cache.is_stuned = ni.player.isstunned() or false;
		cache.is_feared = ni.player.isfleeing() or false;
		cache.is_confused = ni.player.isconfused() or false;
		cache.auto_loot_on = GetCVar("autoLootDefault") == "1" or false;
		cache.is_moving = ni.player.ismoving() or false;
	end,
-----------------------------------
	["Universal pause"] = function()
		if IsMounted()
		or UnitInVehicle("player")
		or UnitIsDeadOrGhost("player")
		or UnitChannelInfo("player")
		or UnitCastingInfo("player")
		or ni.vars.combat.casting == true then
			return true;
		end
		ni.vars.debug = select(2, GetSetting("Debuging"));
	end,
-----------------------------------
	["Use Item (By Name)"] = function()
		local _, enabled = GetSetting("useitem"); 
		if not enabled then
			return false;
		end
		local value = GetSetting("typename");
		if value == "" then
			return false;
		end
		if value ~= "" then
			if not cache.in_combat then
				if GetTime() - LastUse > 5.1 then 
					for b = 0, 4 do 
					for s = 1, 32 do
						local ItemLink = GetContainerItemLink(b, s);
							if ItemLink
							and strfind(ItemLink, value) then
								ni.functions.callprotected("UseContainerItem", b, s);
								LastUse = GetTime()
								return true
							end
						end
					end
				end
			end
		end
    end,
-----------------------------------
	["Auto-Loot"] = function()
		local _, enabled = GetSetting("AutoLoot"); 
		if not enabled then
			return false;
		end
		if (cache.in_combat or ni.player.ismoving() or ni.player.checkslots() < 2) then
			return false;
		end
		if ni.player.islooting() 
		and GetNumLootItems() > 0 then
			local slots = GetNumLootItems();
			for i = slots, 1, -1 do
				local _, _, _, _, locked, questItem = GetLootSlotInfo(i);
				if not locked then
					LootSlot(i);
					ConfirmLootSlot(i);
					return true;
				end
			end
		end
		for k, v in pairs(ni.objects) do
			if type(k) == "string" 
			and type(v) == "table" then
				if ni.unit.islootable(k)
				and v:distance() < 2
				and GetTime() - LastLoot > 0.5 then
					ni.player.interact(k);
					LastLoot = GetTime();
					return true;
				end
			end
		end
	end,
-----------------------------------
	["Skinning"] = function()
		local _, enabled = GetSetting("AutoSkin"); 
		if not enabled then
			return false;
		end
		if (cache.in_combat or ni.player.ismoving() or ni.player.checkslots() < 2) then
			return false;
		end
		if GetNumLootItems() > 0 then
		   local slots = GetNumLootItems();
		   for i = slots, 1, -1 do
				local _, _, _, _, locked, questItem = GetLootSlotInfo(i);
				if not locked then
					LootSlot(i);
					ConfirmLootSlot(i);
					return true;
				end
			end
		end

		local SkinCT = (ni.spell.casttime(spells.Skinning)*1.5);
		if ni.spell.available(spells.Skinning) then	
			for k, v in pairs(ni.objects) do
				if type(k) == "string" 
				and type(v) == "table" then
					if ni.unit.isskinnable(k)
					and v:distance() < 3.8
					and GetTime() - LastInteract > SkinCT then
						ni.player.interact(k);
						LastInteract = GetTime();
						return true;
					end
				end
			end
		end
	end,
};
	ni.bootstrap.profile("Cata_Helper", queue, abilities, OnLoad, OnUnLoad);
else -- Debug with comparing WoW Build / Player Level
    local queue = {
        "Error",
    };
    local abilities = {
        ["Error"] = function()
            ni.vars.profiles.enabled = false;
			if not cata then
				ni.frames.floatingtext:message("This profile for Cata!")
            end
        end,
    };
    ni.bootstrap.profile("Cata_Helper", queue, abilities);
end;