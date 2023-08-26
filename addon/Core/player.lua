local GetInventoryItemLink, strsplit, tonumber, format, GetGlyphSocketInfo, select, GetItemCount, GetInventoryItemID, GetItemSpell, GetItemCooldown, GetTime, GetContainerNumFreeSlots, GetContainerFreeSlots, GetItemIcon, GetSpellInfo, GetSpellCooldown, GetUnitSpeed, IsFalling, rawset, setmetatable = GetInventoryItemLink, strsplit, tonumber, format, GetGlyphSocketInfo, select, GetItemCount, GetInventoryItemID, GetItemSpell, GetItemCooldown, GetTime, GetContainerNumFreeSlots, GetContainerFreeSlots, GetItemIcon, GetSpellInfo, GetSpellCooldown, GetUnitSpeed, IsFalling, rawset, setmetatable
local CurrentMovingTime, CurrentStationaryTime, ResetMovementTime = 0, 0, 0.5;
local build = ni.vars.build;
local player = {};
player.moveto = function(...) --target/x,y,z
	ni.functions.moveto(...)
end;
player.clickat = function(...) --target/x,y,z/mouse
	ni.functions.clickat(...)
end;
player.stopmoving = function()
	ni.functions.callprotected(StrafeLeftStop);
	ni.functions.callprotected(StrafeRightStop);
	ni.functions.callprotected(TurnLeftStop);
	ni.functions.callprotected(TurnRightStop);
	ni.functions.stopmoving();
end;
player.lookat = function(target, inv) --inv true to look away
	ni.debug.print(format("Look on %s", target))
	ni.functions.lookat(target, inv)
end;
player.target = function(target)
	ni.functions.settarget(target)
end;
player.runtext = function(text)
	ni.debug.print(format("Running: %s", text))
	ni.functions.runtext(text)
end;
player.getskillinfo = function(prof)
    if build >= 40300 then
        for i = 1, 6 do
            local skillName, _, skillRank = GetProfessionInfo(i)
            if skillName == prof then
                return skillRank;
            end
        end
    else
		for i = 1, GetNumSkillLines() do
            local name, _, _, skillRank = GetSkillLineInfo(i)
            if name == prof then
                return skillRank;
            end
        end
    end
    return 0;
end;
player.getenchantid = function(slotId)
	local link = GetInventoryItemLink("player", slotId)
	local itemId, enchantId = link:match("item:(%d+):(%d+):(%d+):(%d+):(%d+):(%d+)");
	return enchantId;
end;
player.useitem = function(...) --itemid/name[, target]
	if #{...} > 1 then
		ni.debug.print(format("Using item %s on %s", ...))
	else
		ni.debug.print(format("Using item %s", ...))
	end
	ni.functions.item(...)
end;
player.useinventoryitem = function(...) --slotid[, target]
	if #{...} > 1 then
		ni.debug.print(format("Using Inventory Slot %s on %s", ...))
	else
		ni.debug.print(format("Using Inventory Slot %s", ...))
	end
	ni.functions.inventoryitem(...)
end;
player.interact = function(target)
	ni.debug.print(format("Interacting with %s", target))
	ni.functions.interact(target)
end;
player.hasglyph = function(glyphid)
	for slot = 1, GetNumGlyphSockets() do
	local enabled, glyph_id
		if build >= 40300 then
			enabled, _, _, glyph_id = GetGlyphSocketInfo(slot)
		else
			enabled, _, glyph_id = GetGlyphSocketInfo(slot)
		end
		if enabled and glyph_id == glyphid then
			return true;
		end
	end
	return false;
end;
player.hasitem = function(itemid)
	return GetItemCount(itemid, false, false) > 0
end;
player.hasitemequipped = function(id)
	for i = 1, 19 do
		if GetInventoryItemID("player", i) == id then
			return true
		end
	end
	return false
end;
player.hassetequiped = function(tbl, pieces)
	local count = 0;
	for i = 1, #tbl do
		local ids = tbl[i];
		if IsEquippedItem(ids) then
			count = count + 1
			if count >= pieces then
				return true;
			end
		end
	end
	return false;
end;
player.slotcastable = function(slotnum)
	if select(1, GetItemSpell(GetInventoryItemID("player", slotnum))) ~= "SpellName0" then
		return GetItemSpell(GetInventoryItemID("player", slotnum)) ~= nil
	end
end;
player.slotcd = function(slotnum)
	if not player.slotcastable(slotnum) then
		return 0
	end
	local start, duration, enable = GetItemCooldown(GetInventoryItemID("player", slotnum))
	if (start > 0 and duration > 0) then
		return start + duration - GetTime()
	end
	return 0
end;
player.slotusable = function(slotnum)
	return player.slotcastable(slotnum) and player.slotcd(slotnum) == 0
end;
player.checkslots = function()
	local freeslots = 0;
	for i = 0, 4 do
		if GetContainerNumFreeSlots(i) ~= 0 then
			freeslots = freeslots + #GetContainerFreeSlots(i)
		end
	end
	return freeslots;
end;
player.cancelbuff = function(spellid)
	local spellName = GetSpellInfo(spellid);
	if ni.player.buff(spellid) then
		ni.functions.callprotected("CancelUnitBuff", "player", spellName)
		return true;
	end
	return false;
end;
player.itemicon = function(itemid, width, height)
    return "\124T"..(GetItemIcon(itemid) or select(3, GetSpellInfo(24720)))..":"..(height or 25)..":"..(width or 25).."\124t"	
end;	
player.itemcd = function(item)
	local start, duration, enable = GetItemCooldown(item)
	if (start > 0 and duration > 0) then
		return start + duration - GetTime()
	end
	return 0
end;
player.itemready = function(item)
	return player.hasitem(item) and IsUsableItem(item) and player.itemcd(item) == 0
end;
player.petcd = function(spell)
	local start, duration, enable = GetSpellCooldown(spell)
	if (start > 0 and duration > 0) then
		return start + duration - GetTime()
	else
		return 0
	end
end;
player.registermovement = function(elapsed)
	local speed = GetUnitSpeed("player");
	if speed ~= 0 then
		CurrentMovingTime = CurrentMovingTime + elapsed;
		CurrentStationaryTime = 0;
	else
		if CurrentStationaryTime < ResetMovementTime then
			CurrentStationaryTime = CurrentStationaryTime + elapsed;
		elseif CurrentStationaryTime > ResetMovementTime then
			CurrentMovingTime = 0;
		end
	end
end;
player.movingfor = function(duration)
	local duration = duration or 1;
	if CurrentMovingTime >= duration and not ni.unit.buff("player", 98767) then
		return true;
	end
	return false;
end;
player.getmovingtime = function()
	return CurrentMovingTime;
end;
player.ismoving = function()
	if ni.unit.ismoving("player") or IsFalling() then
		return true
	end
	return false
end;
player.guid = function()
	local p = ni.objects["player"]
	if p then
		return p.guid;
	end
	return p and p.guid or UnitGUID("player");
end;

setmetatable(
	player,
	{
		__index = function(t, k)
			if ni.unit[k] then
				rawset(t, k, function(...)
					return ni.unit[k]("player", ...);
				end);
				return t[k];
			end
		end
	}
);
return player;