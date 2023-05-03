local setmetatable, type, select, sort, wipe, ipairs, tremove, tos = setmetatable, type, select, sort, wipe, ipairs, tremove, tostring
local UnitGroupRolesAssigned, UnitIsGhost, UnitHealthMax, UnitName, UnitGUID, UnitIsUnit = UnitGroupRolesAssigned, UnitIsGhost, UnitHealthMax, UnitName, UnitGUID, UnitIsUnit
local IsInRaid, GetNumRaidMembers, GetNumPartyMembers, GetNumGroupMembers, UnitClass, UnitCanAssist = IsInRaid, GetNumRaidMembers, GetNumPartyMembers, GetNumGroupMembers, UnitClass, UnitCanAssist
local UnitAffectingCombat, UnitHealth, UnitHealthMax = UnitAffectingCombat, UnitHealth, UnitHealthMax
local CreateFrame, CanInspect, GetTalentInfo, GetSpellInfo, IsSpellInRange = CreateFrame, CanInspect, GetTalentInfo, GetSpellInfo, IsSpellInRange
local GetNumTalentTabs, GetActiveTalentGroup, GetTalentTabInfo, GetNumTalents = GetNumTalentTabs, GetActiveTalentGroup, GetTalentTabInfo, GetNumTalents
--[[WARNING: Don't put NotifyInspect as local]]

local members = {};
local memberssetup = { cache = { _cache = {} } };
local roster = memberssetup.cache
local _cache = roster._cache
local tankTalents, BuildTalents, inspectFrame, DoInspect
local INSPECT_TIMEOUT = 3 -- If, during this time, we do not obtain the "INSPECT_TALENT_READY" trigger, we skip the unit and increase its INSPECT_DELAY.
local INSPECT_DELAY	= 10  -- NotifyInspect delay per unit.
local wotlk = ni.vars.build == 30300
setmetatable(members, {
	__call = function(_, ...)
		local pGuid = UnitGUID("player");
		members[#members + 1] = memberssetup:create("player", pGuid)
		local groupType, nRaidMembers, nPartyMembers
		if wotlk then
			nRaidMembers = GetNumRaidMembers()
			nPartyMembers = GetNumPartyMembers()
			groupType = nRaidMembers > 0 and "raid" or "party"		
		else
			nRaidMembers = GetNumGroupMembers()
			nPartyMembers = nRaidMembers - 1
			groupType = IsInRaid() and "raid" or "party"
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
	__index = { name = "members", author = "MoRBiDuS", version = "1.1.0a" };
});

local dontCache = {	["updatemember"] = true, ["updatemembers"] = true, ["reset"] = true, ["addcustom"] = true, ["removecustom"] = true };
local function addCache(t)
	for n,v in pairs(t) do
		if type(v) == "function" and not dontCache[n] then
			t[n] = memberssetup.Do(t[n], _cache)
		end
	end
end;
function memberssetup.Do(f, c)
    return function(...)
		local a, res = tos(f);
		for n = 2, select('#', ...) do
			a = a.."»"..tos(select(n,...))
		end
		res = c[a]
        if not res then
            res = { f(...) }
			c[a] = res
        end
		return unpack(res);
    end
end;
setmetatable(memberssetup, { __call = function(_, ...) return Do(...) end });

if wotlk then
	tankTalents = {
		BladeBarrier			= GetSpellInfo(49182),
		Toughness				= GetSpellInfo(49042),
		Anticipation			= GetSpellInfo(55129),
		SurvivalOfTheFittest	= GetSpellInfo(33853),
		ProtectorOfThePack		= GetSpellInfo(57873)
	};
	BuildTalents = function(unit)
		local notMe = unit ~= "player"
		local NumTalentTabs = GetNumTalentTabs(notMe)
		if NumTalentTabs > 0 then
			local group = GetActiveTalentGroup(notMe)
			roster[unit].talents = {}
			local talents = roster[unit].talents
			local maxPointsSpent = 0
			for tab = 1, NumTalentTabs do
				local SpecName = GetTalentTabInfo(tab, notMe)
				talents[SpecName] = {}
				local pointsSpent = 0
				for numTalents = 1, GetNumTalents(tab, notMe) do
					local name, _, tier, column, currentRank, maxRank = GetTalentInfo(tab, numTalents, notMe, nil, group)
					pointsSpent = pointsSpent + currentRank
					talents[SpecName][name] = {
						tier		= tier,
						column		= column,
						currentRank	= currentRank,
						maxRank		= maxRank
					}
				end
				roster[unit]["t"..tab] = pointsSpent
				if pointsSpent>maxPointsSpent then
					maxPointsSpent = pointsSpent
					roster[unit].specName = SpecName
				end
			end
		end
	end;
	hooksecurefunc("NotifyInspect", function(unit)
		if UnitGUID("mouseover") ~= UnitGUID(unit) then
			roster.inspectUnit = unit
			roster.inspectTainted = true
			ni.delayfor(INSPECT_TIMEOUT, function()
				if roster.inspectTainted then
					roster.inspectTainted = false
					roster[unit].lastInspTime = 5*roster[unit].inspAttempts + GetTime()
					if roster[unit].inspAttempts<3 then
						roster[unit].inspAttempts = roster[unit].inspAttempts + 1
					end
				end
			end)
		end
	end)
	
	inspectFrame = CreateFrame("frame")
	DoInspect = function(unit)
		if CanInspect(unit) then
			NotifyInspect(unit)
			inspectFrame:RegisterEvent("INSPECT_TALENT_READY")
		end
	end;

	inspectFrame:SetScript("OnEvent", function(self)
		self:UnregisterEvent("INSPECT_TALENT_READY")
		if roster.inspectTainted then
			BuildTalents(roster.inspectUnit)
			roster[roster.inspectUnit].lastInspTime = GetTime()
			roster[roster.inspectUnit].inspAttempts = 0
			roster.inspectTainted = false
		end
	end)
end;


function memberssetup:create(unit, guid)
	if roster[unit] then return end
	local o = {};
	setmetatable(o, memberssetup)
	
	function o:istank()
		return o.class == "WARRIOR" and o:aura(71)
		or (o.class == "DRUID" and o:auras("9634||5487"))
		or (o.class == "PALADIN" and o:aura(25780) and ni.power.currentraw(o.unit, 0) < 14000)
		or (o.class == "DEATHKNIGHT" and o:aura(48263))
		or (o:aura(57339) or o:aura(57340))
		or (o:role() == "TANK")
		or false;
	end;
	if wotlk then	
		function o:ishealer()
			return o:role() == "HEALER";
		end;
		function o:isdps()
			return o:role() == "DAMAGER";
		end;
	end
	function o:location()
		local x, y, z, r = ni.functions.objectinfo(o.guid);
		if x then
			return x, y, z, r;
		end
		return 0, 0, 0, 0;
	end;
	function o:combat()
		return UnitAffectingCombat(o.unit) == 1;
	end
	function o:aura(auras)
		return ni.unit.aura(o.unit, aura);
	end;	
	function o:auras(auras)
		return ni.unit.auras(o.unit, auras);
	end;	
	function o:buffs(str, filter)
		return ni.unit.buffs(o.unit, str, filter);
	end;
	function o:debuffs(str, filter)
		return ni.unit.debuffs(o.unit, str, filter) or false;
	end;
	function o:debufftype(str)
		return ni.unit.debufftype(o.unit, str) or false;
	end;
	function o:bufftype(str)
		return ni.unit.bufftype(o.unit, str) or false;
	end;
	function o:buff(buff, filter)
		return ni.unit.buff(o.unit, buff, filter)~=nil;
	end;
	function o:debuff(debuff, filter)
		return ni.unit.debuff(o.unit, debuff, filter)~=nil;
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
		local hp = o:hpraw()/o:hpmax() * 100 
		if hp == 100 or hp <= 0 or UnitIsGhost(o.unit) == 1 then
			return 100;
		end
		for _,id in ipairs(ni.tables.cantheal) do
			if o:debuff(id) then return 100	end
		end;
		for _,id in ipairs(ni.tables.notneedheal) do
			if o:buff(id) then return 100	end
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
		if not wotlk then
			return UnitGroupRolesAssigned(o.unit) or "NONE";
		elseif not roster[o.unit].talents then
			return "NONE"
		elseif roster[o.unit].role then
			return roster[o.unit].role
		end
		
		local class, role, t = o.class, "none", tankTalents
		if class == "ROGUE" or class == "HUNTER" or class == "MAGE" or class == "WARLOCK" then
			role = "DAMAGER"
		elseif class == "DEATHKNIGHT" then
			local score = o:talent(t.BladeBarrier) > 0 and 1 or 0
			score = score + (o:talent(t.Toughness) > 0 and 1 or 0)
			score = score + (o:talent(t.Anticipation) > 0 and 1 or 0)
			role = score >= 2 and "TANK" or "DAMAGER"	-- if has 2 of the 3 tanking talents then is a tank
		else
			local t1, t2, t3 = roster[o.unit].t1, roster[o.unit].t2, roster[o.unit].t3
			if class == "PRIEST" then
				role = ((t1 + t2) > t3) and "HEALER" or "DAMAGER"
			elseif class == "WARRIOR" then
				role = (t1 + t2) > t3 and "DAMAGER" or "TANK" 
			else
				local weight = (t1 > t2 and t1 > t3 and 1) or (t2 > t1 and t2 > t3 and 2) or (t3 > t1 and t3 > t2 and 3) or 0
				if class == "PALADIN" then
					role = weight == 1 and "HEALER" or weight == 2 and "TANK" or weight == 3 and "DAMAGER"
				elseif class == "DRUID" then
					if weight == 2 then
						role = o:talent(t.SurvivalOfTheFittest) > 0 and o:talent(t.ProtectorOfThePack) > 0 and "TANK" or "DAMAGER"
					else
						role = weight == 1 and "DAMAGER" or "HEALER"
					end

				elseif class == "SHAMAN" then
					role = weight == 3 and "HEALER" or "DAMAGER"
				end
			end
		end
		roster[o.unit].role = role
		return role
	end;
	if wotlk then
		function o:spec()
			return roster[o.unit] and roster[o.unit].specName or "None"
		end;
		function o:talent(talent) -- Returns the rank of the unit's talent
			if roster[o.unit] and roster[o.unit].talents then
				local talents = roster[o.unit].talents
				for tab,tbl in pairs(talents) do
					if type(tbl) == "table" then
						for k,v in pairs(tbl) do
							if k == talent then
								return v.currentRank
							end
						end
					end
				end
			end
			return 0
		end;
	end

	function o:updatemember()
		o.name = o.name or UnitName(o.unit);
		o.class = o.class or select(2, UnitClass(o.unit));
		
		roster[o.unit].name		= o.name
		roster[o.unit].class	= o.class
		roster[o.unit].guid		= o.guid
		
		if wotlk then
			local now = GetTime()
			if now-roster[o.unit].lastInspTime>INSPECT_DELAY then
				roster[o.unit].role = nil
				if o.unit == "player" then
					BuildTalents("player")
					roster[o.unit].lastInspTime = now
				else
					DoInspect(o.unit)
				end
			end
		end
	end;

	-- Attributes
	o.unit			= unit
	o.guid			= guid
	o.name			= UnitName(unit)
	o.class			= select(2, UnitClass(unit))
	o.target		= unit .. "target"

	roster[unit] = {}
	roster[unit].name			= o.name
	roster[unit].class			= o.class
	roster[unit].guid			= o.guid
	roster[unit].lastInspTime	= 0
	roster[unit].inspAttempts	= 0
	
	addCache(o)
	return o;
end;

memberssetup.set = function()
	function members.updatemembers()
		wipe(_cache)
		for _,o in ipairs(members) do
			o:updatemember()
		end
	end;
	function members.reset()
		wipe(members)
		wipe(roster)
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
			local unitdistance = ni.unit.distance(o.unit, unit) or 999
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
					roster[o.unit] = nil;
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

return members