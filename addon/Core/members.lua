local setmetatable, IsInRaid, GetNumGroupMembers, tinsert, GetNumRaidMembers, GetNumPartyMembers, type, UnitClass, select, UnitGroupRolesAssigned, UnitIsDeadOrGhost, UnitHealthMax, UnitName, UnitGUID, tostring, sort, wipe, ipairs, UnitIsUnit, tremove = setmetatable, IsInRaid, GetNumGroupMembers, tinsert, GetNumRaidMembers, GetNumPartyMembers, type, UnitClass, select, UnitGroupRolesAssigned, UnitIsDeadOrGhost, UnitHealthMax, UnitName, UnitGUID, tostring, sort, wipe, ipairs, UnitIsUnit, tremove
local members = {};
local memberssetup = {}
memberssetup.cache = {}
memberssetup.__index = {
	unit = "noob",
	name = "noob",
	class = "noob",
	guid = 0,
	shortguid = 0,
	role = "NOOB",
	range = false,
	dispel = false,
	hp = 100,
	threat = 0,
	target = "noobtarget",
	istank = false
}
memberssetup.cache.__index = {
	guid = 0,
	name = "Unknown",
	type = 0
}
local membersmt = {}
setmetatable(members, membersmt)
membersmt.__call = function(_, ...)
	if ni.vars.build == 50400 then
		local group = IsInRaid() and "raid" or "party"
		local groupSize = IsInRaid() and GetNumGroupMembers() or GetNumGroupMembers() - 1
		if group == "party" then
			tinsert(members, memberssetup:create("player"))
		end
		for i = 1, groupSize do
			local groupUnit = group .. i
			local groupMember = memberssetup:create(groupUnit)
			if groupMember then
				tinsert(members, groupMember)
			end
		end
	else
		local group = GetNumRaidMembers() > 0 and "raid" or "party"
		local groupsize = group == "raid" and GetNumRaidMembers() or GetNumPartyMembers()
		if group == "party" then
			tinsert(members, memberssetup:create("player"))
		end
		for i = 1, groupsize do
			local groupunit = group .. i
			local groupmember = memberssetup:create(groupunit)
			if groupmember then
				tinsert(members, groupmember)
			end
		end
	end
end
membersmt.__index = {
	name = "members",
	author = "bubba"
}

function memberssetup:create(unit)
	if memberssetup.cache[ni.unit.shortguid(unit)] then
		return false
	end
	local o = {}
	setmetatable(o, memberssetup)
	if unit and type(unit) == "string" then
		o.unit = unit
	end
	function o:calculateistank()
		local oclass = select(2, UnitClass(o.unit));
		if oclass == "WARRIOR" and ni.unit.aura(o.guid, 71) then
			return true;
		elseif oclass == "DRUID" and (ni.unit.buff(o.unit, 9634, "EXACT") or ni.unit.buff(o.unit, 5487, "EXACT"))	then
			return true;
		elseif oclass == "PALADIN" and (ni.unit.buff(o.unit, 25780) and ni.power.currentraw(o.unit, 0) < 14000) then
			return true;
		elseif ni.unit.aura(o.guid, 57340) then
			return true;
		elseif UnitGroupRolesAssigned(o.guid) == "TANK" then
			return true;
		end
		return false
	end
	function o:debufftype(str)
		return ni.unit.debufftype(o.guid, str)
	end
	function o:bufftype(str)
		return ni.unit.bufftype(o.guid, str)
	end
	function o:buff(buff, filter)
		return ni.unit.buff(o.guid, buff, filter)
	end
	function o:debuff(debuff, filter)
		return ni.unit.debuff(o.guid, debuff, filter)
	end
	function o:candispel()
		return ni.healing.candispel(o.unit)
	end
	function o:calculatehp()
		local hp = ni.unit.hp(o.unit)
		local hpraw = ni.unit.hpraw(o.unit)

		if o.istank then
			hp = hp - 5
		end
		if UnitIsDeadOrGhost(o.unit) == 1 or ni.unit.debuff(o.unit, 8326) then
			hp = 250
		end
		if o.dispel then
			hp = hp - 2
		end
		for i = 1, #ni.tables.cantheal do
			if ni.unit.debuff(o.unit, ni.tables.cantheal[i]) then
				hp = 100
				hpraw = UnitHealthMax(o.unit)
			end
		end
		for i = 1, #ni.tables.notneedheal do
			if ni.unit.buff(o.unit, ni.tables.notneedheal[i]) then
				hp = 100
				hpraw = UnitHealthMax(o.unit)
			end
		end
		return hp, hpraw
	end
	function o:inrange()
		if ni.unit.exists(o.guid) and ni.player.los(o.guid) then
			local dist = ni.player.distance(o.guid)
			if (dist ~= nil and dist < 40) then
				return true;
			else
				return false;
			end
		end
		return false;
	end
	function o:updatemember()
		o.name = UnitName(o.unit)
		o.class = select(2, UnitClass(o.unit))
		o.guid = UnitGUID(o.unit)
		o.shortguid = ni.unit.shortguid(o.unit)
		o.range = o:inrange()
		o.dispel = o:candispel()
		o.hp = o:calculatehp()
		o.threat = ni.unit.threat(o.unit)
		o.target = tostring(o.unit) .. "target"
		o.istank = o:calculateistank()
		memberssetup.cache[ni.unit.shortguid(o.unit)] = o
	end
	memberssetup.cache[ni.unit.shortguid(o.unit)] = o
	return o
end
local membersrange = { };
local membersbelow = { };
local memberswithbuff = { };
local memberswithbuffbelow = { };
local memberswithoutbuff = { };
local memberswithoutbuffbelow = { };
local memberswithdebuff = { };
local memberswithdebuffbelow = { };
local memberswithoutdebuff = { };
local memberswithoutdebuffbelow = { };

memberssetup.set = function()
	function members:updatemembers()
		for i = 1, #members do
			members[i]:updatemember()
		end

		sort(
			members,
			function(x, y)
				if x.range and y.range then
					return x.hp < y.hp
				elseif x.range then
					return true
				elseif y.range then
					return false
				else
					return x.hp < y.hp
				end
			end
		)
	end
	function members.reset()
		wipe(members)
		wipe(memberssetup.cache)
		memberssetup.set()
	end
	function members.below(percent)
		local total = 0;
		for i = 1, #members do
			if members[i].hp < percent then
				total = total + 1;
			end
		end
		return total;
	end
	function members.average()
		local count = #members;
		local average = 0;
		for i = 1, count do
			average = average + members[i].hp;
		end
		return average/count;
	end
	function members.averageof(count)
		local m = count;
		local average = 0;
		if #members < m then
			for i = m, 0, -1 do
				if #members >= i then
					m = i;
					break;
				end
			end
		end
		for i = 1, m do
			average = average + members[i].hp;
		end
		return average/m;
	end
	function members.inrange(unit, distance)
		wipe(membersrange);
		for _, v in ipairs(members) do
			if not UnitIsUnit(v.unit, unit) then
				local unitdistance = ni.unit.distance(v.unit, unit);
				if unitdistance ~= nil and unitdistance <= distance then
					tinsert(membersrange, v);
				end
			end
		end
		return membersrange;
	end
	function members.inrangebelow(unit, distance, hp)
		wipe(membersbelow);
		members.inrange(unit, distance);
		for _, v in ipairs(membersrange) do
			if v.hp < hp then
				tinsert(membersbelow, v);
			end
		end
		return membersbelow;
	end
	function members.inrangewithbuff(unit, distance, buff, filter)
		wipe(memberswithbuff);
		members.inrange(unit, distance);
		for _, v in ipairs(membersrange) do
			if v:buff(buff, filter) then
				tinsert(memberswithbuff, v);
			end
		end
		return memberswithbuff;
	end
	function members.inrangewithbuffbelow(unit, distance, buff, hp, filter)
		wipe(memberswithbuffbelow);
		members.inrange(unit, distance);
		for _, v in ipairs(membersrange) do
			if v:buff(buff, filter) 
			 and v.hp < hp then
				tinsert(memberswithbuffbelow, v);
			end
		end
		return memberswithbuffbelow;
	end
	function members.inrangewithoutbuff(unit, distance, buff, filter)
		wipe(memberswithoutbuff);
		members.inrange(unit, distance);
		for _, v in ipairs(membersrange) do
			if not v:buff(buff, filter) then
				tinsert(memberswithoutbuff, v);
			end
		end
		return memberswithoutbuff
	end
	function members.inrangewithoutbuffbelow(unit, distance, buff, hp, filter)
		wipe(memberswithoutbuffbelow);
		members.inrange(unit, distance);
		for _, v in ipairs(membersrange) do
			if not v:buff(buff, filter) 
			 and v.hp < hp then
				tinsert(memberswithoutbuffbelow, v);
			end
		end
		return memberswithoutbuffbelow
	end
	function members.inrangewithdebuff(unit, distance, debuff, filter)
		wipe(memberswithdebuff);
		members.inrange(unit, distance);
		for _, v in ipairs(membersrange) do
			if v:debuff(debuff, filter) then
				tinsert(memberswithdebuff, v);
			end
		end
		return memberswithdebuff;
	end
	function members.inrangewithdebuffbelow(unit, distance, debuff, hp, filter)
		wipe(memberswithdebuffbelow);
		members.inrange(unit, distance);
		for _, v in ipairs(membersrange) do
			if v:debuff(debuff, filter) 
			 and v.hp < hp then
				tinsert(memberswithdebuffbelow, v);
			end
		end
		return memberswithdebuffbelow;
	end
	function members.inrangewithoutdebuff(unit, distance, debuff, filter)
		wipe(memberswithoutdebuff);
		members.inrange(unit, distance);
		for _, v in ipairs(membersrange) do
			if not v:debuff(debuff, filter) then
				tinsert(memberswithoutdebuff, v);
			end
		end
		return memberswithoutdebuff
	end
	function members.inrangewithoutdebuffbelow(unit, distance, debuff, hp, filter)
		wipe(memberswithoutdebuffbelow);
		members.inrange(unit, distance);
		for _, v in ipairs(membersrange) do
			if not v:debuff(debuff, filter) 
			 and v.hp < hp then
				tinsert(memberswithoutdebuffbelow, v);
			end
		end
		return memberswithoutdebuffbelow
	end
	function members.addcustom(unit)
		local groupMember = memberssetup:create(unit);
		if groupMember then
			tinsert(members, groupMember);
		end
	end
	function members.removecustom(unit)
		for k, v in ipairs(members) do
			if v.unit == unit then
				memberssetup.cache[ni.unit.shortguid(unit)] = nil;
				tremove(members, k);
			end
		end
	end
	members()
end
memberssetup.set()
return members;