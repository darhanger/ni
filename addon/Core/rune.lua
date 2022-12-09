local GetTime, GetRuneCooldown, GetRuneType = GetTime, GetRuneCooldown, GetRuneType
local rune = {};
rune.available = function()
	local runesavailable = 0
	local cur_time = GetTime();
	for i = 1, 6 do
		local start, duration, ready = GetRuneCooldown(i);
		if start == 0 or cur_time - start > duration then
			runesavailable = runesavailable + 1
		end
	end
	return runesavailable
end;
rune.deathrunes = function()
	local dr = 0;
	for i = 1, 6 do
		if GetRuneType(i) == 4 then
			dr = dr + 1;
		end
	end
	return dr;
end;
rune.cd = function(r)
	local runesoncd = 0
	local runesoffcd = 0
	local cur_time = GetTime();
	
	for i = 1, 6 do
		local start, duration, ready = GetRuneCooldown(i);
		if GetRuneType(i) == r then
			if start ~= 0 and cur_time - start <= duration then
				runesoncd = runesoncd + 1
			else
				runesoffcd = runesoffcd + 1
			end
		end
	end
	return runesoncd, runesoffcd
end;
rune.deathrunecd = function()
	return rune.cd(4)
end;
rune.frostrunecd = function()
	return rune.cd(3)
end;
rune.unholyrunecd = function()
	return rune.cd(2)
end;
rune.bloodrunecd = function()
	return rune.cd(1)
end;
return rune;