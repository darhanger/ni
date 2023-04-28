local setmetatable, type, select, sort, wipe, ipairs, tremove = setmetatable, type, select, sort, wipe, ipairs, tremove
local UnitGroupRolesAssigned, UnitIsGhost, UnitHealthMax, UnitName, UnitGUID, UnitIsUnit = UnitGroupRolesAssigned, UnitIsGhost, UnitHealthMax, UnitName, UnitGUID, UnitIsUnit
local IsInRaid, GetNumRaidMembers, GetNumPartyMembers, GetNumGroupMembers, UnitClass, UnitCanAssist = IsInRaid, GetNumRaidMembers, GetNumPartyMembers, GetNumGroupMembers, UnitClass, UnitCanAssist
local UnitAffectingCombat, UnitHealth, UnitHealthMax = UnitAffectingCombat, UnitHealth, UnitHealthMax

local members = {};
local memberssetup = { cache = { _cache = {} } };
local _cache = memberssetup.cache._cache
setmetatable(members, {
	__call = function(_, ...)
		local pGuid = UnitGUID("player");
		members[#members + 1] = memberssetup:create("player", pGuid)
		local groupType, nRaidMembers, nPartyMembers
		if ni.vars.build == 50400 then
			nRaidMembers = GetNumGroupMembers()
			nPartyMembers = nRaidMembers - 1
			groupType = IsInRaid() and "raid" or "party"
		else
			nRaidMembers = GetNumRaidMembers()
			nPartyMembers = GetNumPartyMembers()
			groupType = nRaidMembers > 0 and "raid" or "party"
		end
		local groupsize = groupType == "raid" and nRaidMembers or nPartyMembers
		for i = 1, groupsize do
			local unit = groupType .. i
			local guid = UnitGUID(unit)
			if guid and guid ~= pGuid then
				local o = memberssetup:create(unit, guid)
				if o then
					members[#members+1] = o;
				end
			end
		end
	end,
	__index = { name = "members", author = "MoRBiDuS", version = "1.0.5a" };
});

local dontCache = {
	["updatemember"]	= true,
	["updatemembers"]	= true,
	["reset"]			= true,
	["addcustom"]		= true,
	["removecustom"]	= true
};
local function addCache(t)
	for n,v in pairs(t) do
		if type(v) == "function" and not dontCache[n] then
			t[n] = memberssetup.Do(t[n], _cache)
		end
	end
end;
local function take(c, args)
	local n = c
	for _,a in ipairs(args) do
		n = n[a]
		if not n then return end
	end
	return n.res;
end;
local function give(c, args, res)
	local n, param = c
	for _,a in ipairs(args) do
		n[a] = n[a] or {}
		n = n[a]
	end
	n.res = res;
end;
function memberssetup.Clean(c)
	for k,a in pairs(c) do
		if type(a) == "table" then
			if k == "res" then
				c.res = nil
			else
				memberssetup.Clean(a)
			end
		end
	end
end;
function memberssetup.Do(f, c)
	return function (...)
		c[f] = c[f] or {}
		local args = {...}
		local res = take(c[f], args)
		if not res then
			res = { f(...) }
			give(c[f], args, res)
		end
		return unpack(res);
	end
end;
setmetatable(memberssetup, { __call = function(_, ...) return Do(...) end });

function memberssetup:create(unit, guid)
	if memberssetup.cache[unit] then return end
	local o = {}
	setmetatable(o, memberssetup)
	
	function o:istank()
		return (o.class == "WARRIOR" and o:aura(71))
		or (o.class == "DRUID" and o:auras("9634||5487"))
		or (o.class == "PALADIN" and o:aura(25780) and ni.power.currentraw(o.unit, 0) < 14000)
		or (o.class == "DEATHKNIGHT" and o:aura(48263))
		or (o:aura(57339) or o:aura(57340))
		or (o:role() == "TANK")
		or false
	end;
	function o:location()
		local x, y, z, r = ni.functions.objectinfo(o.guid);
		if x then
			return x, y, z, r;
		end
		return 0, 0, 0, 0;
	end;
	function o:distanceto(o2)
		local x1, y1, z1 = o:location()
		local x2, y2, z2
		if type(o2) == "string" then
			x2, y2, z2 = ni.functions.objectinfo(o2)
		else
			x2, y2, z2 = o2:location()
		end
		if x1 and x2 then
			return (x1 - x2)^2 + (y1 - y2)^2 + (z1 - z2)^2
		end
		return 999;
	end;
	function o:combat()
		return UnitAffectingCombat(o.unit) == 1;
	end
	function o:aura(aura)
		return ni.unit.aura(o.unit, aura);
	end;	
	function o:auras(auras)
		return ni.unit.auras(o.unit, auras);
	end;	
	function o:buffs(buffs, filter)
		return ni.unit.buffs(o.unit, buffs, filter);
	end;
	function o:debuffs(debuffs, filter)
		return ni.unit.debuffs(o.unit, debuffs, filter);
	end;
	function o:debufftype(str)
		return ni.unit.debufftype(o.unit, str);
	end;
	function o:bufftype(str)
		return ni.unit.bufftype(o.unit, str);
	end;
	function o:buff(buff, filter)
		return ni.unit.buff(o.unit, buff, filter) or false;
	end;
	function o:debuff(debuff, filter)
		return ni.unit.debuff(o.unit, debuff, filter) or false;
	end;
	function o:dispel()
		return ni.healing.candispel(o.unit) or false;
	end;
	function o:hpraw()
		return UnitHealth(o.unit);
	end;		
	function o:hpmax()
		return UnitHealthMax(o.unit);
	end;
	function o:hp()
		local hp = o:hpraw()/o:hpmax() * 100 or ni.unit.hppredicted(o.unit)
		local val = random(16, 24);
		if hp == 100 or hp <= 0 or UnitIsGhost(o.unit) == 1 then
			return 100;
		end	
		for _,id in ipairs(ni.tables.cantheal) do
			if o:debuff(id) then return 100	end
		end;
		for _,id in ipairs(ni.tables.notneedheal) do
			if o:buff(id) then return 100 end
		end;
		hp = o:istank() and (hp - 5) or hp;
		hp = o:dispel() and (hp - 2) or hp;
		return hp;
	end;
	function o:range()
		local dist = ni.player.distance(o.unit) or 999;
		return dist < 40 or false;
	end;
	function o:los()
		return ni.player.los(o.unit) == true;
	end;
	function o:facing()
		return ni.player.facing(o.unit) == true;
	end;
	function o:valid(spell, facing, los)
		local spellid = tonumber(spell)
		spellid = spellid or ni.spell.id(spell)
		return (spellid > 0
		and IsSpellInRange(GetSpellInfo(spellid), o.unit) == 1
		and (not facing or o:facing())
		and (not los or o:los()))
		or false
	end;
	function o:threat()
		return ni.unit.threat(o.unit) or false;
	end;
	function o:role()
		return UnitGroupRolesAssigned(o.unit) or "";
	end;
	function o:updatemember()
		o.name = o.name or UnitName(o.unit);
		o.class = o.class or select(2, UnitClass(o.unit));
		memberssetup.cache[o.unit] = true;
	end;

	-- Attributes
	o.unit		= unit
	o.guid		= guid
	o.name		= UnitName(unit)
	o.class		= select(2, UnitClass(unit))
	o.target	= unit .. "target"
	
	memberssetup.cache[unit] = true
	addCache(o)
	return o;
end;

memberssetup.set = function()
	function members.updatemembers()
		memberssetup.Clean(_cache)
		for _,o in ipairs(members) do
			o:updatemember()
		end
	end;
	function members.reset()
		wipe(members)
		wipe(memberssetup.cache)
		memberssetup.set()
	end;
	function members.sort()
		if #members > 1 then
			sort(members, function(a,b) return a:range() and not b:range() or a:range() == b:range() and a:hp() < b:hp() end)
		end
		return members;
	end;
	function members.below(percent)
		local total = 0;
		for _,o in ipairs(members) do
			if o:hp() < percent then
				total = total + 1;
			end
		end
		return total;
	end;
	function members.average(unit, distance)
		unit = unit or "player"
		distance = distance or 40
		local average = 0;
		for _,o in ipairs(members.inrange(unit, distance)) do
			average = average + o:hp()
		end
		return average / #members;
	end;
	function members.averageof(count, unit, distance)
		if not count or count <= 0 then return 0 end
		unit = unit or "player"
		distance = distance or 40		
		local n, average = 0, 0
		for i, o in ipairs(members.inrange(unit, distance)) do
			average = average + o:hp()
			if i >= count then n = i break end	
		end
		return n > 0 and average/n or 0;
	end;
	function members.inrange(unit, distance)
		local tmp = {};
		if type(unit) ~= "string" then return tmp end
		for _,o in ipairs(members) do
			local unitdistance = o:distanceto(unit)
			if unitdistance <= distance then
				tmp[#tmp + 1] = o;
			end
		end
		return tmp;
	end;
	function members.inrangebelow(unit, distance, hp)
		local tmp = {};
		for _,o in ipairs(members.inrange(unit, distance)) do
			local aux = o:hp()
			if aux < hp then
				local idx = #tmp + 1
				tmp[idx] = o;
				tmp[idx].aux = aux;
			end
		end
		if #tmp > 1 then
			sort(tmp, function(a,b) return a.aux < b.aux end)
		end
		return tmp;
	end;
	function members.inrangewithbuff(unit, distance, buff, filter)
		local tmp = {};
		for _,o in ipairs(members.inrange(unit, distance)) do
			if o:buff(buff, filter) then
				tmp[#tmp + 1] = o;
			end
		end
		return tmp;
	end;
	function members.inrangewithdebufftype(unit, distance, str)
        local tmp = {};
        for _,o in ipairs(members.inrange(unit, distance)) do
            if o:debufftype(str) then
                tmp[#tmp + 1] = o;
            end
        end
        return tmp;
    end;
	function members.inrangewithbufftype(unit, distance, str)
        local tmp = {};
        for _,o in ipairs(members.inrange(unit, distance)) do
            if o:bufftype(str) then
                tmp[#tmp + 1] = o;
            end
        end
        return tmp;
    end;
	function members.inrangewithoutbuff(unit, distance, buff, filter)
		local tmp = {};
		for _,o in ipairs(members.inrange(unit, distance)) do
			if not o:buff(buff, filter) then
				tmp[#tmp + 1] = o;
			end
		end
		return tmp;
	end;
	function members.inrangewithbuffbelow(unit, distance, buff, hp, filter)
		local tmp = {};
		for _,o in ipairs(members.inrangebelow(unit, distance, hp)) do
			if o:buff(buff, filter) then
				tmp[#tmp + 1] = o;
			end
		end
		return tmp;
	end;
	function members.inrangewithoutbuffbelow(unit, distance, buff, hp, filter)
		local tmp = {};
		for _,o in ipairs(members.inrangebelow(unit, distance, hp)) do
			if not o:buff(buff, filter) then
				tmp[#tmp + 1] = o;
			end
		end
		return tmp;
	end;
	function members.inrangewithdebuff(unit, distance, debuff, filter)
		local tmp = {};
		for _,o in ipairs(members.inrange(unit, distance)) do
			if o:debuff(debuff, filter) then
				tmp[#tmp + 1] = o;
			end
		end
		return tmp;
	end;
	function members.inrangewithdebuffbelow(unit, distance, debuff, hp, filter)
		local tmp = {};
		for _,o in ipairs(members.inrangebelow(unit, distance, hp)) do
			if o:debuff(debuff, filter) then
				tmp[#tmp + 1] = o;
			end
		end
		return tmp;
	end;
	function members.inrangewithoutdebuff(unit, distance, debuff, filter)
		local tmp = {};
		for _,o in ipairs(members.inrange(unit, distance)) do
			if not o:debuff(debuff, filter) then
				tmp[#tmp + 1] = o;
			end
		end
		return tmp;
	end;
	function members.inrangewithoutdebuffbelow(unit, distance, debuff, hp, filter)
		local tmp = {};
		for _,o in ipairs(members.inrangebelow(unit, distance, hp)) do
			if not o:debuff(debuff, filter) then
				tmp[#tmp + 1] = o;
			end
		end
		return tmp;
	end;
	function members.addcustom(unit, guid)
		if type(unit) == "string" then
			local groupMember = memberssetup:create(unit, guid or UnitGUID(unit));
			if groupMember then
				members[#members + 1] = groupMember;
				members:updatemembers()
			end
		end
	end;
	function members.removecustom(unit)
		if type(unit) == "string" then
			for i,o in ipairs(members) do
				if o.unit == unit then
					memberssetup.cache[o.unit] = nil;
					tremove(members, i)
					members:updatemembers()
				end
			end
		end
	end
	members()
end;
memberssetup.set()
addCache(members)

return members, memberssetup.cache;