local UnitIsDeadOrGhost, GetTime, math_floor, math_max, UnitHealth, UnitHealthMax = UnitIsDeadOrGhost, GetTime, math.floor, math.max, UnitHealth, UnitHealthMax
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
            o.dps = math_floor(_dps)

            local death = 0
            if _dps ~= 0 then
                death = math_max(0, currenthp) / _dps
            end

            if death == math.huge or maxhp - currenthp == 0 then
                o.ttd = -1
            elseif death < 0 then
                o.ttd = 0
            else
                o.ttd = death
            end
        end
    end
};
return ttd;