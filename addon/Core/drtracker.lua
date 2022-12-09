local UnitGUID, GetTime, pairs = UnitGUID, GetTime, pairs
local drtracker = {};
drtracker.resettime = 18;
drtracker.units = {};
drtracker.get = function(unit, type)
	-- ni.drtracker.get("target", "Fears")
	-- returns 1, 0.5, 0.25 or 0
	-- 1 -> full duration
	-- 0.5 -> half duration
	-- 0.25 -> quarter duration
	-- 0 -> immune
	if ni.tables.dr.types[type] == nil then
		ni.debug.log("DR type not supported, check https://nhub.app")
		return -1
	end

	unit = UnitGUID(unit)

	if unit == nil then
		return -1
	end

	if drtracker.units[unit] == nil then
		return 1
	end

	if drtracker.units[unit][type] then
		return drtracker.units[unit][type].diminished
	end

	return 1
end;
drtracker.nextdr = function(currentdr)
	if (currentdr == 1) then
		return 0.50
	elseif (currentdr == 0.50) then
		return 0.25
	end

	return 0
end;
drtracker.gained = function(spellID, destName, destGUID, isEnemy, isPlayer)
	local drCat = ni.tables.dr.spells[spellID]
	isPlayer = ni.unit.isplayer(destGUID)
	isPlayer = true

	if not isPlayer and not ni.tables.dr.pve[drCat] then
		return
	end

	local cat = ni.tables.dr.refs[drCat]
	local time = GetTime()

	if not drtracker.units[destGUID] then
		drtracker.units[destGUID] = {}
	end

	if not drtracker.units[destGUID][cat] then
		drtracker.units[destGUID][cat] = {reset = time + drtracker.resettime, diminished = 0.5}
	else
		drtracker.units[destGUID][cat].reset = time + drtracker.resettime
		drtracker.units[destGUID][cat].diminished = drtracker.nextdr(drtracker.units[destGUID][cat].diminished)
	end
end;
drtracker.faded = function(spellID, destName, destGUID, isEnemy, isPlayer)
	local drCat = ni.tables.dr.spells[spellID]
	isPlayer = ni.unit.isplayer(destGUID)
	isPlayer = true

	if (not isPlayer and not ni.tables.dr.pve[drCat]) then
		return
	end

	local cat = ni.tables.dr.refs[drCat]
	local time = GetTime()

	if not drtracker.units[destGUID] then
		drtracker.units[destGUID] = {}
	end

	if not drtracker.units[destGUID][cat] then
		drtracker.units[destGUID][cat] = {reset = 0, diminished = 1}
	end

	drtracker.units[destGUID][cat].reset = time + drtracker.resettime
end;
drtracker.wipe = function(unit)
	if drtracker.units[unit] then
		drtracker.units[unit] = nil
	end
end;
drtracker.wipeall = function()
	for k, v in pairs(drtracker.units) do
		drtracker.units[k] = nil
	end
end;
drtracker.updateresettime = function()
	for k, v in pairs(drtracker.units) do
		for x, y in pairs(v) do
			if y.reset <= GetTime() then
				drtracker.units[k][x].reset = 0
				drtracker.units[k][x].diminished = 1
			end
		end
	end
end
return drtracker;