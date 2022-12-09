local tonumber, UnitPower, UnitPowerMax = tonumber, UnitPower, UnitPowerMax
local power = { };
power.types = {
	mana = 0,
	rage = 1,
	focus = 2,
	energy = 3,
	combopoints = 4,
	runes = 5,
	runicpower = 6,
	soulshards = 7,
	eclipse = 8,
	holy = 9,
	alternate = 10,
	darkforce = 11,
	chi = 12,
	shadoworbs = 13,
	burningembers = 14,
	demonicfury = 15
};
power.current = function(t, type)
	if tonumber(type) == nil then
		type = power.types[type]
	end

	return 100 * UnitPower(t, type) / UnitPowerMax(t, type)
end;
power.currentraw = function(t, type)
	if tonumber(type) == nil then
		type = power.types[type]
	end

	return UnitPower(t, type)
end;
power.max = function(t, type)
	if tonumber(type) == nil then
		type = power.types[type]
	end

	return UnitPowerMax(t, type)
end;
power.ismax = function(t, type)
	if tonumber(type) == nil then
		type = power.types[type]
	end

	return UnitPower(t, type) == UnitPowerMax(t, type)
end;
return power;