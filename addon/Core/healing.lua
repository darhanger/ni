local UnitClass, UnitDebuff, UnitHealthMax = UnitClass, UnitDebuff, UnitHealthMax
local select, strlower, tContains, tinsert, wipe, sort, unpack, ipairs = select, strlower, tContains, tinsert, wipe, sort, unpack, ipairs

local class = strlower(select(2, UnitClass("player")));

healing = {};
healing.debufftoblacklist = function(id)
	if not tContains(ni.tables.blacklisteddispels, id) then
		tinsert(ni.tables.blacklisteddispels, id)
	end
end;
healing.dontdispel = function(t)
	for i = 1, #ni.tables.blacklisteddispels do
		local blacklisted = ni.tables.blacklisteddispels[i]
		local debuff = ni.unit.debuff(t, blacklisted)
		if debuff then
			local debufftype = select(5, UnitDebuff(t, debuff))

			if healing.debufftypedispellable(debufftype) then
				return true;
			end
		end
	end
	return false;
end;
healing.candispel = function(t)
	local i = 1
	local debuff = UnitDebuff(t, i)
	if healing.dontdispel(t) then
		return false
	end
	while debuff do
		local debufftype = select(5, UnitDebuff(t, i))
		if healing.debufftypedispellable(debufftype) then
			return true;
		end
		i = i + 1
		debuff = UnitDebuff(t, i)
	end
	return false;
end;

healing.debufftypedispellable = function(debufftype)
	return ni.tables.classes[class].dispel and tContains(ni.tables.classes[class].dispel, debufftype)
end;

local function getObjectByName(tbl, n)
    for _,m in ipairs(tbl) do
        if m.name == n then return m end
    end
end;
local function allTrim(s)
    return type(s) == "string" and s:match("^%s*(.-)%s*$") or ""
end;
local function gettanks()
    local tanks = {};
    local vT = {ni.vars.units.mainTankEnabled and allTrim(ni.vars.units.mainTank) or false,
                ni.vars.units.offTankEnabled and allTrim(ni.vars.units.offTank) or false};   
    local ni_members = ni.members
    for _,name in ipairs(vT) do 
        if name and name ~= "" then
            local m = getObjectByName(ni_members, name)
            if m then
                tinsert(tanks, m)
            end        
        end
    end
    if #tanks < 2 then
        local tempTable, n = {}, 1
        for _,m in ipairs(ni_members) do
            if m.istank() and not getObjectByName(tanks, m.name) then
                m.hpMax = UnitHealthMax(m.unit)
                tinsert(tempTable, m)
            end
        end
        if #tempTable > 1 then table.sort(tempTable, function(x, y) return x.hpMax > y.hpMax end) end
        for i = #tanks + 1, 2 do
            tinsert(tanks, tempTable[n] or {})
            n = n + 1
        end
    end
    -- return the members who are tanks, or have been assigned as tanks
    -- always first those who were assigned manually.    
    return unpack(tanks)
end;
return healing, gettanks;