local math_max, tonumber, UnitGUID, pairs, type, tinsert, UnitLevel, UnitThreatSituation, GetUnitSpeed, UnitExists, tostring, strsub, UnitIsDeadOrGhost, UnitCanAttack, UnitHealth, UnitHealthMax, UnitGetIncomingHeals, select, GetTime, math_pow, wipe, UnitReaction, UnitCastingInfo, UnitChannelInfo, UnitBuff, strlower, tContains, GetSpellInfo, strupper, strfind, strlen, UnitDebuff, UnitClass = math.max, tonumber, UnitGUID, pairs, type, tinsert, UnitLevel, UnitThreatSituation, GetUnitSpeed, UnitExists, tostring, strsub, UnitIsDeadOrGhost, UnitCanAttack, UnitHealth, UnitHealthMax, UnitGetIncomingHeals, select, GetTime, math.pow, wipe, UnitReaction, UnitCastingInfo, UnitChannelInfo, UnitBuff, strlower, tContains, GetSpellInfo, strupper, strfind, strlen, UnitDebuff, UnitClass
local creaturetypes = {
	[0] = "Unknown",
	[1] = "Beast",
	[2] = "Dragon",
	[3] = "Demon",
	[4] = "Elemental",
	[5] = "Giant",
	[6] = "Undead",
	[7] = "Humanoid",
	[8] = "Critter",
	[9] = "Mechanical",
	[10] = "NotSpecified",
	[11] = "Totem",
	[12] = "NonCombatPet",
	[13] = "GasCloud"
};

local unitauras = { };
local lastmovedCache = { };
local BehindTime = 0;
local los = ni.functions.los;
local unit = {};

unit.incombat = function(t)
	return UnitAffectingCombat(t) or false;
end;
unit.canattack = function(tar1, tar2)
	return UnitCanAttack(tar1, tar2) or false;
end;
unit.canassist = function(tar1, tar2)
	return UnitCanAssist(tar1, tar2) or false;
end;
unit.isenemy = function(tar1, tar2)
	return UnitIsEnemy(tar1, tar2) or false;
end;
unit.unitisdead = function(t)
	return UnitIsDeadOrGhost(t) or false;
end;
unit.exists = function(t)
    return ni.functions.objectexists(t);
end;
unit.isunit = function(tar1, tar2)
	return UnitIsUnit(tar1, tar2);
end;
unit.itemlvl = function(t)
    local iLevelSum, iCount = 0, 0 
    for i = 1, 18 do 
		if i ~= 4 then 
			local ItemLink = GetInventoryItemLink(t, i) 
			if ItemLink then 
				local _,_,_,l = GetItemInfo(ItemLink) 
				iLevelSum = iLevelSum + l 
				iCount = iCount + 1 
			end 
		end 
	end 
	if iCount > 0 then 
		return (iLevelSum/iCount);
	end
end;
unit.exists = function(t)
    return UnitExists(t) or (ni.functions.objectexists(t) or false);
end;
unit.los = function(...) --target, target/x1,y1,z1,x2,y2,z2 [optional, hitflags]
	local _, t = ...;
	if tonumber(t) == nil then
		local unitid = unit.id(t);
		if unitid then
			if (ni.tables.whitelistedlosunits[unitid]) then
				return true;
			end
		end
		local mapid = ni.functions.getmapid();
		if (ni.tables.whitelistedlosmaps[mapid]) then
			return true;
		end		
	end
	return los(...);
end;
unit.creator = function(t)
	return unit.exists(t) and ni.functions.unitcreator(t) or nil;
end;
unit.creations = function(unit)
	local creationstable = {}
	if unit then
		local guid = UnitGUID(unit)
		for k, v in pairs(ni.objects) do
			if type(k) ~= "function" and (type(k) == "string" and type(v) == "table") then
				if v:creator() == guid then
					tinsert(creationstable, {name = v.name, guid = v.guid});
				end
			end
		end
	end
	return creationstable;
end;
unit.creaturetype = function(t)
	return ni.functions.creaturetype(t) or 0;
end;
unit.istotem = function(t)
	return (unit.exists(t) and unit.creaturetype(t) == 11) or false;
end;
unit.readablecreaturetype = function(t)
	return creaturetypes[unit.creaturetype(t)];
end;
unit.combatreach = function(t)
	return ni.functions.combatreach(t) or 0;
end;
unit.isboss = function(t)
	local bossId = unit.id(t);
	-- useful for non ?? level training dummies
	if ni.tables.dummies[bossId] then
		return true;
	end
	if ni.tables.bosses[bossId] then
		return true;
	end
	if ni.tables.mismarkedbosses[bossId] then
		return false;
	end
	return UnitLevel(t) == -1;
end;
unit.threat = function(t, u)
	local threat;
	if u then
		threat = UnitThreatSituation(t, u);
	else
		threat = UnitThreatSituation(t);
	end
	if threat ~= nil then
		return threat;
	else
		return -1;
	end
end;
unit.ismoving = function(t)
	return GetUnitSpeed(t) ~= 0;
end;
unit.movingtime = function(target)
    target = (target == "player" or target:match("^0x")) and target or unit.guid(target)
    if target == "player" or unit.exists(target) then
        if lastmovedCache[target] then
            local is_moving = GetUnitSpeed(target) > 0 or IsFalling(target)
            if not lastmovedCache[target].is_moving and is_moving then
                lastmovedCache[target].last = GetTime()
                lastmovedCache[target].is_moving = true
                return 0;
            elseif is_moving then
                lastmovedCache[target].last = GetTime()
                lastmovedCache[target].is_moving = true
                return 0;
            elseif not is_moving then
                lastmovedCache[target].is_moving = false
                return GetTime() - lastmovedCache[target].last;
            end
        else
            lastmovedCache[target] = {}
            lastmovedCache[target].last = GetTime()
            lastmovedCache[target].is_moving = GetUnitSpeed(target) > 0 or IsFalling(target)
            return 0;
        end
    end
    return 0;
end;
unit.id = function(t)
    if not unit.exists(t) or not unit.unitis(t) then
        return nil;
    end
	local bitfrom = -7;
	local bitto = -11;
	local id_hex
	if ni.vars.build == 40300 then
		bitfrom = -9;
		bitto = -12;
	elseif ni.vars.build == 50400 then
		bitfrom = 10;
		bitto = 6;
	end
    if tonumber(t) then
        id_hex = string.sub(t, bitto, bitfrom);
    else
        id_hex = string.sub(UnitGUID(t), bitto, bitfrom);
    end
    return tonumber(id_hex, 16);
end;
unit.shortguid = function(t)
	if UnitExists(t) then
		return strsub(tostring(UnitGUID(t)), -5, -1);
	end
	return "";
end;
unit.isdummy = function(t)
	if unit.exists(t) then
		t = unit.id(t)
		return ni.tables.dummies[t]
	end
	return false;
end;
unit.ttd = function(t)
	if unit.isdummy(t) then
		return 999;
	end
	if unit.exists(t) and (not unit.unitisdead(t) and unit.canattack("player", t)) then
		t = UnitGUID(t);
	else
		return -2;
	end
	if ni.objects[t] and ni.objects[t].ttd ~= nil then
		return ni.objects[t].ttd;
	end
	return -1;
end;
unit.hp = function(t)
    if (unit.unitisdead(t) or unit.debuff(t, 8326)) then
        return 100;
    end
	for _, spellId in ipairs(ni.tables.cantheal) do
		if unit.debuff(t, spellId) then return 100	end
	end
	for _, spellId in ipairs(ni.tables.notneedheal) do
		if unit.buff(t, spellId) then return 100 end
	end
	return 100 * UnitHealth(t) / UnitHealthMax(t);
end;	
unit.hpraw = function(t)
    return UnitHealth(t);
end;
unit.hppredicted = function(t)
    local UnitGetIncomingHeals = ni.vars.build >= 40300 and UnitGetIncomingHeals
    return (100 * (UnitHealth(t) + UnitGetIncomingHeals(t)) / UnitHealthMax(t));
end;
unit.power = function(t, type)
	return ni.power.current(t, type);
end;
unit.powerraw = function(t, type)
	return ni.power.currentraw(t, type);
end;
unit.info = function(t)
	if t == nil then
		return;
	end
	local tmp = t
	if tonumber(tmp) == nil then
		t = UnitGUID(tmp)
		if t == nil then
			t = ni.objectmanager.objectGUID(tmp);
		end
	end
	if unit.exists(t) then
		return ni.functions.objectinfo(t);
	end
end;
unit.location = function(t)
	if unit.exists(t) then
		local x, y, z = unit.info(t)
		return x, y, z;
	end
	return 0, 0, 0;
end;
unit.newz = function(...)
	local nArgs = #{...};
	if nArgs == 1 or nArgs == 2 then
		local t, offset = ...;
		offset = offset or 20;
		local x, y, z = unit.location(t);
		return select(4, los(x, y, z + offset, x, y, z - offset));
	elseif nArgs == 3 or nArgs == 4 then
		local x, y, z, offset = ...;
		offset = offset or 20;
		return select(4, los(x, y, z + offset, x, y, z - offset));			
	end
end;
unit.path = function(...)
	local num = #{...};
	local t1x, t1y, t1z;
	local t2x, t2y, t2z;
	local includes, excludes = nil, nil;
	if num == 2 then
		local t1, t2 = ...;
		t1x, t1y, t1z = unit.location(t1);
		t2x, t2y, t2z = unit.location(t2);
	elseif num == 4 then
		local t1, t2, t3, t4 = ...;
		if type(t1) == "string" then
			t1x, t1y, t1z = unit.location(t1);
			t2x, t2y, t2z = t2, t3, t4;
		elseif type(t4) == "string" then
			t1x, t1y, t1z = t1, t2, t3;
			t2x, t2y, t2z = unit.location(t4);
		end
	elseif num == 6 or num == 8 then
		t1x, t1y, t1z, t2x, t2y, t2z = ...;
		if num == 8 then
			includes, excludes = select(7, ...);
		end
	end
	if t1x and t1x ~= 0 and t2x and t2x ~= 0 then
		return ni.functions.getpath(t1x, t1y, t1z, t2x, t2y, t2z, includes, excludes);
	end
end;
unit.castingpercent = function(t)
	local castName, _, _, _, castStartTime, castEndTime = UnitCastingInfo(t)
	if castName then
		local timeSinceStart = (GetTime() * 1000 - castStartTime) / 1000
		local castTime = castEndTime - castStartTime
		local currentPercent = timeSinceStart / castTime * 100000
		return currentPercent;
	end
	return 0;
end;
unit.channelpercent = function(t)
	local channelName, _, _, _, channelStartTime, channelEndTime = UnitChannelInfo(t)
	if channelName then
		local timeSinceStart = (GetTime() * 1000 - channelStartTime) / 1000
		local channelTime = channelEndTime - channelStartTime
		local currentPercent = timeSinceStart / channelTime * 100000
		return currentPercent;
	end
	return 0;
end;
local function buildAurasTable(t)	
    wipe(unitauras);
    unitauras = ni.functions.auras(t) or { };
    return unitauras;
end;
unit.aura = function(t, s)
    if tonumber(s) == nil then
        -- unit.auras(t);
        buildAurasTable(t);
        for k, v in pairs(unitauras) do
            if v.name == s then
                return true;
            end
        end
        return false;
    else
        return ni.functions.hasaura(t, s) or false
    end
end;
unit.auras = function(target, str)
    str = tostring(str)
    local And = str:match("&&")
    local array, counter, id = ni.utils.splitstringbydelimiter(str, And or "||"), 0
    buildAurasTable(target)
    for _, tbl in pairs(unitauras) do
        for _, aura in ipairs(array) do
            id = tonumber(aura)
            counter = (id and tbl.ID == id or tbl.name == aura) and counter + 1 or counter
            if not And and counter > 0 then
                return true
            end
        end
    end
    return And and counter > 0 and counter == #array or false
end;
--- BUFFS ---
unit.buff = function(target, spellID, filter)
	local spellName = type(spellID) == "number" and GetSpellInfo(spellID) or spellID;
	if filter == nil then
		return UnitBuff(target, spellName);
	else
		if strfind(strupper(filter), "EXACT") then
			local caster = strfind(strupper(filter), "PLAYER");
			for i = 1, 40 do
				local _, _, _, _, _, _, _, buffCaster, _, _, buffSpellID = UnitBuff(target, i);
				if buffSpellID ~= nil
				and buffSpellID == spellID
				and (not caster or buffCaster == "player") then
					return UnitBuff(target, i);
				end
			end
		else
			return UnitBuff(target, spellName, nil, filter);
		end
	end
end;
unit.buffs = function(target, spellIDs, filter)
	local ands = ni.utils.findand(spellIDs)
	local results = false
	if ands ~= nil or (ands == nil and strlen(spellIDs) > 0) then
		local tmp
		if ands then
			tmp = ni.utils.splitstringbydelimiter(spellIDs, "&&")
			for i = 0, #tmp do
				if tmp[i] ~= nil then
					local id = tonumber(tmp[i])
					if id ~= nil then
						if not unit.buff(target, id, filter) then
							results = false
							break;
						else
							results = true
						end
					else
						if not unit.buff(target, tmp[i], filter) then
							results = false;
							break;
						else
							results = true;
						end
					end
				end
			end
		else
			tmp = ni.utils.splitstringbydelimiter(spellIDs, "||")
			for i = 0, #tmp do
				if tmp[i] ~= nil then
					local id = tonumber(tmp[i])
					if id ~= nil then
						if unit.buff(target, id, filter) then
							results = true;
							break;
						end
					else
						if unit.buff(target, tmp[i], filter) then
							results = true;
							break;
						end
					end
				end
			end
		end
	end
	return results;
end;
unit.bufftype = function(target, str)
	if not unit.exists(target) then
		return false;
	end
	local st = ni.utils.splitstringtolower(str);
	local has = false;
	local i = 1;
	local buff = UnitBuff(target, i);
	while buff do
		local _, _, _, _, bufftype = UnitBuff(target, i);
		if bufftype ~= nil then
			if bufftype == "" then
				bufftype = "Enrage"
			end
			local dTlwr = strlower(bufftype)
			if tContains(st, dTlwr) then
				has = true;
				break;
			end
		end
		i = i + 1
		buff = UnitBuff(target, i)
	end
	return has;
end;
unit.bufftypetimer = function(target, str)
    if not unit.exists(target) then
        return false;
    end
    local st = ni.utils.splitstringtolower(str);
    local i = 1;
    local debuff = UnitBuff(target, i);
    while debuff do
        local _, _, _, _, debufftype = UnitBuff(target, i);
        if debufftype ~= nil then
            local dTlwr = strlower(debufftype)
            if tContains(st, dTlwr) then
                local _, _, _, _, _, _, expires = UnitBuff(target, i);
                if expires then
                    return (expires - GetTime());
                end
                break;
            end
        end
        i = i + 1
        debuff = UnitBuff(target, i)
    end
    return false;
end;
unit.buffstacks = function(target, spellID, filter)
	local _, _, _, stacks = unit.buff(target, spellID, filter);
	return stacks and stacks or 0;
end;
unit.bufftimer = function(target, spellID, filter)
	local _, _, _, _, _, duration, expires = unit.buff(target, spellID, filter);
	if expires then
		return duration - (expires - GetTime());
	else
		return 0;
	end
end;
unit.buffremaining = function(target, spellID, filter)
	local _, _, _, _, _, _, expires = unit.buff(target, spellID, filter);
	if expires ~= nil then
		return expires - GetTime() - ni.vars.combat.currentcastend;
	else
		return 0;
	end
end;
unit.buffduration = function(target, spellID, filter)
	local name, _, _, _, _, duration = unit.buff(target, spellID, filter);
	if name then
		return duration == 0 and 9999 or duration;
	end
	return 0;
end;
--- DEBUFFS ---
unit.debuff = function(target, spellID, filter)
	local spellName = type(spellID) == "number" and GetSpellInfo(spellID) or spellID;
	if filter == nil then
		return UnitDebuff(target, spellName);
	else
		if strfind(strupper(filter), "EXACT") then
			local caster = strfind(strupper(filter), "PLAYER");
			for i = 1, 40 do
				local _, _, _, _, _, _, _, debuffCaster, _, _, debuffSpellID = UnitDebuff(target, i);
				if debuffSpellID ~= nil
				and debuffSpellID == spellID
				and (not caster or debuffCaster == "player") then
					return UnitDebuff(target, i);
				end
			end
		else
			return UnitDebuff(target, spellName, nil, filter);
		end
	end
end;
unit.debuffs = function(target, spellIDs, filter)
	local ands = ni.utils.findand(spellIDs)
	local results = false
	if ands ~= nil or (ands == nil and strlen(spellIDs) > 0) then
		local tmp
		if ands then
			tmp = ni.utils.splitstringbydelimiter(spellIDs, "&&")
			for i = 0, #tmp do
				if tmp[i] ~= nil then
					local id = tonumber(tmp[i])
					if id ~= nil then
						if not unit.debuff(target, id, filter) then
							results = false;
							break;
						else
							results = true;
						end
					else
						if not unit.debuff(target, tmp[i], filter) then
							results = false;
							break
						else
							results = true;
						end
					end
				end
			end
		else
			tmp = ni.utils.splitstringbydelimiter(spellIDs, "||")
			for i = 0, #tmp do
				if tmp[i] ~= nil then
					local id = tonumber(tmp[i])
					if id ~= nil then
						if unit.debuff(target, id, filter) then
							results = true;
							break;
						end
					else
						if unit.debuff(target, tmp[i], filter) then
							results = true;
							break;
						end
					end
				end
			end
		end
	end
	return results;
end;
unit.debufftype = function(target, str)
	if not unit.exists(target) then
		return false;
	end
	local st = ni.utils.splitstringtolower(str)
	local has = false
	local i = 1
	local debuff = UnitDebuff(target, i)
	while debuff do
		local _, _, _, _, debufftype = UnitDebuff(target, i);
		if debufftype ~= nil then
			local dTlwr = strlower(debufftype)
			if tContains(st, dTlwr) then
				has = true;
				break;
			end
		end
		i = i + 1
		debuff = UnitDebuff(target, i)	
	end
	return has;
end;
unit.debufftypetimer = function(target, str)
    if not unit.exists(target) then
        return false;
    end
    local st = ni.utils.splitstringtolower(str);
    local i = 1;
    local debuff = UnitDebuff(target, i);
    while debuff do
        local _, _, _, _, debufftype = UnitDebuff(target, i);
        if debufftype ~= nil then
            local dTlwr = strlower(debufftype)
            if tContains(st, dTlwr) then
                local _, _, _, _, _, _, expires = UnitDebuff(target, i);
                if expires then
                    return (expires - GetTime());
                end
                break;
            end
        end
        i = i + 1
        debuff = UnitDebuff(target, i)
    end
    return false;
end;
unit.debuffstacks = function(target, spellID, filter)
	local _, _, _, stacks = unit.debuff(target, spellID, filter);
	return stacks and stacks or 0;
end;
unit.debufftimer = function(target, spellID, filter)
	local _, _, _, _, _, duration, expires = unit.debuff(target, spellID, filter);
	if expires then
		return duration - (expires - GetTime());
	else
		return 0;
	end
end;
unit.debuffremaining = function(target, spellID, filter)
	local _, _, _, _, _, _, expires = unit.debuff(target, spellID, filter);
	if expires ~= nil then
		return expires - GetTime() - ni.vars.combat.currentcastend;
	else
		return 0;
	end
end;
unit.debuffduration = function(target, spellID, filter)
	local name, _, _, _, _, duration = unit.debuff(target, spellID, filter);
	if name then
		return duration == 0 and 9999 or duration;
	end
	return 0;
end;
unit.spellstealable = function(t)
    for i = 1, 40 do
        local _, _, _, _, _, _, _, _, stealable = UnitBuff(t, i)
        if stealable then
            return true;
        end
    end
    return false;
end;
unit.isfacing = function(t1, t2, degrees)
	return (t1 ~= nil and t2 ~= nil) and ni.functions.isfacing(t1, t2, degrees) or false
end;
unit.notbehindtarget = function(seconds)
	local seconds = seconds or 2
	if BehindTime + seconds > GetTime() then
		return true;
	else
		return false;
	end
end;
unit.isbehind = function(t1, t2, seconds)
	if unit.notbehindtarget(seconds) then
		return false;
	end
	return (t1 ~= nil and t2 ~= nil) and ni.functions.isbehind(t1, t2) or false;
end;
unit.distance = function(...)
    if #{...} >= 2 then
        return ni.functions.getdistance(...) or 9999;
    end
    return 9999;
end;
unit.distancesqr = function(t1, t2)
	local x1, y1, z1 = unit.location(t1)
	local x2, y2, z2 = unit.location(t2)
	return math_pow(x1 - x2, 2) + math_pow(y1 - y2, 2) + math_pow(z1 - z2, 2);
end;
unit.meleerange = function(t1, t2)
	local cr1 = unit.combatreach(t1)
	local cr2 = unit.combatreach(t2)
	return math_max(5.0, cr1 + cr2 + (4 / 3));
end;
unit.inmelee = function(t1, t2)
	local meleerange = unit.meleerange(t1, t2)
	local distancesqr = unit.distancesqr(t1, t2)
	if distancesqr then
		return distancesqr < meleerange * meleerange;
	end
	return false;
end;
unit.enemiesinrange = function(t, n)
	local enemiestable = {}
	t = true and UnitGUID(t) or t
	if t then
		for k, v in pairs(ni.objects) do
			if type(k) ~= "function" and (type(k) == "string" and type(v) == "table") then
				if k ~= t and v:canattack() and not unit.unitisdead(k) 
				and unit.readablecreaturetype(k) ~= "Critter" then
					local distance = v:distance(t)
					if (distance ~= nil and distance <= n) then
						tinsert(enemiestable, {guid = k, name = v.name, distance = distance});
					end
				end
			end
		end
	end
	return enemiestable;
end;
unit.enemiesinrangewithbufftype = function(t, n, str)
	local enemiestablebufftype = {}
	t = true and UnitGUID(t) or t
	if t then
		for k, v in pairs(ni.objects) do
			if type(k) ~= "function" and (type(k) == "string" and type(v) == "table") then
				if k ~= t and v:canattack() and not unit.unitisdead(k) 
				and unit.bufftype(k, str) and unit.readablecreaturetype(k) ~= "Critter" 
				and unit.readablecreaturetype(k) ~= "Totem" then
					local distance = v:distance(t)
					if (distance ~= nil and distance <= n) then
						tinsert(enemiestablebufftype, {guid = k, name = v.name, distance = distance});
					end
				end
			end
		end
	end
	return enemiestablebufftype;
end;
unit.friendsinrange = function(t, n)
	local friendstable = {}
	t = true and UnitGUID(t) or t
	if t then
		for k, v in pairs(ni.objects) do
			if type(k) ~= "function" and (type(k) == "string" and type(v) == "table") then
				if k ~= t and v:canassist() and not unit.unitisdead(k) then
					local distance = v:distance(t)
					if (distance ~= nil and distance <= n) then
						tinsert(friendstable, {guid = k, name = v.name, distance = distance});
					end
				end
			end
		end
	end
	return friendstable;
end;
unit.unitstargeting = function(t, friendlies)
	t = true and UnitGUID(t) or t
	local f = true and friendlies or false
	local targetingtable = {}

	if t then
		if not f then
			for k, v in pairs(ni.objects) do
				if type(k) ~= "function" and (type(k) == "string" and type(v) == "table") then
					if k ~= t and UnitReaction(t, k) ~= nil and UnitReaction(t, k) <= 4 and not unit.unitisdead(k) then
						local target = v:target()
						if target ~= nil and target == t then
							tinsert(targetingtable, {name = v.name, guid = k});
						end
					end
				end
			end
		else
			for k, v in pairs(ni.objects) do
				if type(k) ~= "function" and (type(k) == "string" and type(v) == "table") then
					if k ~= t and UnitReaction(t, k) ~= nil and UnitReaction(t, k) > 4 then
						local target = v:target()
						if target ~= nil and target == t then
							tinsert(targetingtable, {name = v.name, guid = k});
						end
					end
				end
			end
		end
	end
	return targetingtable;
end;
unit.iscasting = function(t)
	return UnitCastingInfo(t) and true or false;
end;
unit.ischanneling = function(t)
	return UnitChannelInfo(t) and true or false;
end;
unit.target = function(t)
    if unit.exists(t) then
	local _, _, _, _, _, unitTarget = unit.info(t);
        return unitTarget;
    end
end;
unit.incombatwithme = function(t)
    local enemyTarget = unit.target(t)
    if enemyTarget then
        for i = 1, #ni.members do
            local ally = ni.members[i].guid;
            if enemyTarget == ally then
                return true;
            end
        end
    end
end;
unit.flags = function(t)
	return ni.functions.unitflags(t);
end;
unit.dynamicflags = function(t)
	return ni.functions.unitdynamicflags(t);
end;
unit.istappedbyallthreatlist = function(t)
	return (unit.exists(t) and select(2, unit.dynamicflags(t))) or false;
end;
unit.islootable = function(t)
	return (unit.exists(t) and select(3, unit.dynamicflags(t))) or false;
end;
unit.istaggedbyme = function(t)
	return (unit.exists(t) and select(7, unit.dynamicflags(t))) or false;
end;
unit.istaggedbyother = function(t)
	return (unit.exists(t) and select(8, unit.dynamicflags(t))) or false;
end;
unit.canperformaction = function(t)
	return (unit.exists(t) and select(1, unit.flags(t))) or false;
end;
unit.isconfused = function(t)
	return (unit.exists(t) and select(23, unit.flags(t))) or false;
end;
unit.notbleed = function(t)
	return (unit.exists(t) and select(16, unit.flags(t))) or false;
end
unit.isdisarmed = function(t)
	return (unit.exists(t) and select(22, unit.flags(t))) or false;
end;
unit.isfleeing = function(t)
	return (unit.exists(t) and select(24, unit.flags(t))) or false;
end;
unit.islooting = function(t)
	return (unit.exists(t) and select(11, unit.flags(t))) or false;
end;
unit.ismounted = function(t)
	return (unit.exists(t) and select(28, unit.flags(t))) or false;
end;
unit.isnotattackable = function(t)
	return (unit.exists(t) and select(2, unit.flags(t))) or false;
end;
unit.isnotselectable = function(t)
	return (unit.exists(t) and select(26, unit.flags(t))) or false;
end;
unit.ispacified = function(t)
	return (unit.exists(t) and select(18, unit.flags(t))) or false;
end;
unit.ispetinombat = function(t)
	return (unit.exists(t) and select(12, unit.flags(t))) or false;
end;
unit.isplayercontrolled = function(t)
	return (unit.exists(t) and select(4, unit.flags(t))) or false;
end;
unit.ispossessed = function(t)
	return (unit.exists(t) and select(25, unit.flags(t))) or false;
end;
unit.ispreparation = function(t)
	return (unit.exists(t) and select(6, unit.flags(t))) or false;
end;
unit.ispvpflagged = function(t)
	return (unit.exists(t) and select(13, unit.flags(t))) or false;
end;
unit.issilenced = function(t)
	return (unit.exists(t) and select(14, unit.flags(t))) or false;
end;
unit.isskinnable = function(t)
	return (unit.exists(t) and select(27, unit.flags(t))) or false;
end;
unit.isstunned = function(t)
	return (unit.exists(t) and select(19, unit.flags(t))) or false;
end;
unit.isimmune = function(t)
	return (unit.exists(t) and select(32, unit.flags(t))) or false;
end;
unit.isplayer = function(t)
	local _, _, _, _, unittype = unit.info(t);
	if unittype == 4 then
		return true;
	else
		return false;
	end
end;
unit.unitis = function(t)
	local _, _, _, _, unittype = unit.info(t);
	if unittype == 3 then
		return true;
	else
		return false;
	end
end;
unit.transport = function(t)
	return ni.functions.transport(t);
end;
unit.facing = function(t)
	return ni.functions.facing(t);
end;
local function UnitEvents(event, ...)	
	if event == "UI_ERROR_MESSAGE" then
		local errorMessage = ...;
		if errorMessage == SPELL_FAILED_NOT_BEHIND then
			BehindTime = GetTime();
		end
	end
end;
ni.listener:add("Internal Unit Handler", "UI_ERROR_MESSAGE", UnitEvents)
return unit;