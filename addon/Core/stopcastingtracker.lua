local UnitCastingInfo, UnitChannelInfo, GetTime, pairs, GetSpellInfo, select = UnitCastingInfo, UnitChannelInfo, GetTime, pairs, GetSpellInfo, select
local stopcastingtracker = {};
stopcastingtracker.shouldstop = function(spell)
	local spellcasttime = ni.spell.casttime(spell);
	local bosscast, _, _, _, bosscastend = UnitCastingInfo("boss1");
	local mycasttime, _, _, _, mycastend = UnitCastingInfo("player");
	if bosscast == nil then
		bosscast, _, _, _, bosscastend = UnitCastingInfo("focus")
	end;
	if bosscast == nil or ni.spell.isinstant(spell) then
		return false
	end;
	if mycasttime == nil then
		mycasttime, _, _, _, mycastend = UnitChannelInfo("player")
	end;
	if mycasttime == nil then
		mycastend = (GetTime() + spellcasttime) * 1000
	end;
	for k, v in pairs(ni.tables.stopcasting.continue) do
		local buff = k

		if ni.player.buff(buff) and ni.player.buffremaining(buff) + 0.1 >= bosscastend then
			return false
		end
	end;
	for k, v in pairs(ni.tables.stopcasting.stop) do
		local casting = k
		if bosscast == select(1, GetSpellInfo(casting)) then
			if mycastend ~= nil and mycastend >= bosscastend then
				return true
			end
		end
	end;
end;
return stopcastingtracker