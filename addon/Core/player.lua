local GetGlyphSocketInfo,
	GetContainerNumSlots,
	GetContainerItemID,
	GetItemSpell,
	GetInventoryItemID,
	GetItemCooldown,
	GetSpellCooldown,
	GetTime,
	IsFalling =
	GetGlyphSocketInfo,
	GetContainerNumSlots,
	GetContainerItemID,
	GetItemSpell,
	GetInventoryItemID,
	GetItemCooldown,
	GetSpellCooldown,
	GetTime,
	IsFalling

local CurrentMovingTime, CurrentStationaryTime, ResetMovementTime = 0, 0, 0.5;

local player = {}
player.moveto = function(...) --target/x,y,z
	ni.functions.moveto(...)
end
player.clickat = function(...) --target/x,y,z/mouse
	ni.functions.clickat(...)
end
player.stopmoving = function()
	ni.functions.callprotected(StrafeLeftStop);
	ni.functions.callprotected(StrafeRightStop);
	ni.functions.callprotected(TurnLeftStop);
	ni.functions.callprotected(TurnRightStop);
	ni.functions.stopmoving();
end
player.lookat = function(target, inv) --inv true to look away
	ni.functions.lookat(target, inv)
end
player.target = function(target)
	ni.functions.settarget(target)
end
player.runtext = function(text)
	ni.debug.print(string.format("Running: %s", text))
	ni.functions.runtext(text)
end
player.useitem = function(...) --itemid/name[, target]
	if #{...} > 1 then
		ni.debug.print(string.format("Using item %s on %s", ...))
	else
		ni.debug.print(string.format("Using item %s", ...))
	end
	ni.functions.item(...)
end
player.useinventoryitem = function(slotid)
	ni.debug.print(string.format("Using Inventory Slot %s", slotid))
	ni.functions.inventoryitem(slotid)
end
player.interact = function(target)
	ni.debug.print(string.format("Interacting with %s", target))
	ni.functions.interact(target)
end
player.hasglyph = function(glyphid)
	for i = 1, 6 do
		if GetGlyphSocketInfo(i) then
			if select(3, GetGlyphSocketInfo(i)) == glyphid then
				return true
			end
		end
	end
	return false
end
player.hasitem = function(itemid)
	return GetItemCount(itemid, false, false) > 0
end
player.hasitemequipped = function(id)
	for i = 1, 19 do
		if GetInventoryItemID("player", i) == id then
			return true
		end
	end
	return false
end
player.slotcastable = function(slotnum)
	return GetItemSpell(GetInventoryItemID("player", slotnum)) ~= nil
end
player.slotcd = function(slotnum)
	if not player.slotcastable(slotnum) then
		return 0
	end
	local start, duration, enable = GetItemCooldown(GetInventoryItemID("player", slotnum))
	if (start > 0 and duration > 0) then
		return start + duration - GetTime()
	end
	return 0
end
player.itemcd = function(item)
	local start, duration, enable = GetItemCooldown(item)
	if (start > 0 and duration > 0) then
		return start + duration - GetTime()
	end
	return 0
end
player.petcd = function(spell)
	local start, duration, enable = GetSpellCooldown(spell)
	if (start > 0 and duration > 0) then
		return start + duration - GetTime()
	else
		return 0
	end
end
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
end
player.movingfor = function(duration)
	local duration = duration or 1;
	if CurrentMovingTime >= duration and not ni.unit.buff("player", 98767) then
		return true;
	end
	return false;
end
player.getmovingtime = function()
	return CurrentMovingTime;
end
player.ismoving = function()
	if ni.unit.ismoving("player") or IsFalling() then
		return true
	end
	return false
end

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
)
return player;