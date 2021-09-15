local UnitHealth, GetTime, UnitIsDeadOrGhost, UnitHealthMax = UnitHealth, GetTime, UnitIsDeadOrGhost, UnitHealthMax

local ttd = {
	calculate = function(o)
		if (o:unit() or o:player()) and o:canattack() and not UnitIsDeadOrGhost(o.guid) and o:combat() then
			if o.timeincombat == nil then
				o.timeincombat = GetTime()
			end

			local currenthp = UnitHealth(o.guid)
			local maxhp = UnitHealthMax(o.guid)
			local diff = maxhp - currenthp
			local duration = GetTime() - o.timeincombat
			local _dps = diff / duration
			local death = 0

			if _dps ~= 0 then
				death = math.max(0, currenthp) / _dps
			else
				death = 0
			end
			o.dps = math.floor(_dps)

			if death == math.huge then
				o.ttd = -1
			elseif death < 0 then
				o.ttd = 0
			else
				o.ttd = death
			end
			if maxhp - currenthp == 0 then
				o.ttd = -1
			end
		end
	end
}
return ttd;