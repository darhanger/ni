local GetSpellCooldown,
	GetTime,
	GetSpellInfo,
	GetNetStats,
	tonumber,
	UnitIsDeadOrGhost,
	UnitCanAttack,
	IsSpellInRange,
	IsSpellKnown,
	UnitClass,
	GetShapeshiftForm,
	UnitCastingInfo,
	UnitChannelInfo,
	tContains,
	random,
	sin,
	cos,
	sqrt,
	tremove,
	tinsert,
	StrafeLeftStart,
	StrafeLeftStop,
	MoveForwardStop,
	MoveForwardStart,
	IsPlayerSpell =
	GetSpellCooldown,
	GetTime,
	GetSpellInfo,
	GetNetStats,
	tonumber,
	UnitIsDeadOrGhost,
	UnitCanAttack,
	IsSpellInRange,
	IsSpellKnown,
	UnitClass,
	GetShapeshiftForm,
	UnitCastingInfo,
	UnitChannelInfo,
	tContains,
	random,
	sin,
	cos,
	sqrt,
	tremove,
	tinsert,
	StrafeLeftStart,
	StrafeLeftStop,
	MoveForwardStop,
	MoveForwardStart,	
	IsPlayerSpell

local _, class = UnitClass("player")
local casts = {}
local los = ni.functions.los

setmetatable(
	casts,
	{
		__index = function(t, k)
			rawset(t, k, {at = 0})
			return t[k]
		end
	}
)
local spell = {}
spell.queue = {}
spell.id = function(s)
	if s == nil then
		return nil
	end
	local id = ni.functions.getspellid(s)
	return (id ~= 0) and id or nil
end
spell.cd = function(id)
	local start, duration = GetSpellCooldown(id)
	local start2 = GetSpellCooldown(61304)

	if start == nil then
		return -1
	end

	if (start > 0 and duration > 0 and start ~= start2) then
		return start + duration - GetTime()
	else
		return 0
	end
end

spell.gcd = function()
	local _, d = GetSpellCooldown(61304)
	return d ~= 0
end
spell.isqueued = function()
	if ni.vars.combat.spellqueueenabled then
		local name, _, _, _, startTimeMS, endTimeMS = UnitCastingInfo("player")

		if name then
			local casttime = (endTimeMS - startTimeMS) / 1000
			local finish = endTimeMS / 1000 - GetTime()
			local spellqueuewindow = casttime - (casttime - ni.vars.combat.spellqueuems)
			if spellqueuewindow <= finish then
				ni.vars.combat.currentcastend = finish
				return true
			else
				ni.vars.combat.queued = false
				ni.vars.combat.currentcastend = finish
				return false
			end
		else
			ni.vars.combat.queued = false
			ni.vars.combat.currentcastend = 0
			return false
		end

		if ni.vars.combat.queued and name then
			return true
		end
	else
		if UnitCastingInfo("player") or ni.vars.combat.casting then
			return true
		end
	end

	return false
end
spell.available = function(id, stutter)
	if not stutter then
		if spell.gcd() or spell.isqueued() then
			return false
		end
	end

	if tonumber(id) == nil then
		id = spell.id(id)
	end

	local result = false

	if id ~= nil and id ~= 0 and (IsSpellKnown(id) or (ni.vars.build >= 50400 and IsPlayerSpell(id))) then
		local name, _, _, cost, _, powertype = GetSpellInfo(id)

		if ni.stopcastingtracker.shouldstop(id) then
			return false
		end

		if
			name and
				((powertype == -2 and ni.player.hpraw() >= cost) or (powertype >= 0 and ni.player.powerraw(powertype) >= cost)) and
				spell.cd(name) == 0
		 then
			result = true
		end
	end
	return result
end
spell.casttime = function(s)
	return select(7, GetSpellInfo(s)) / 1000 + select(3, GetNetStats()) / 1000
end
spell.cast = function(...)
	local i = ...
	if i == nil then
		return
	end
	if #{...} > 1 then
		ni.debug.print(string.format("Casting %s on %s", ...))
	else
		ni.debug.print(string.format("Casting %s", ...))
	end
	ni.vars.combat.queued = true
	ni.functions.cast(...)
end
spell.delaycast = function(s, target, delay)
	if delay then
		if rawget(casts, s) ~= nil then
			if GetTime() - casts[s].at < delay then
				return false
			end
		end
	end
	spell.cast(s, target);
	casts[s].at = GetTime();
	return true;
end
spell.castspells = function(spells, t)
	local items = ni.utils.splitstring(spells)

	for i = 0, #items do
		local st = items[i]
		if st ~= nil then
			local id = tonumber(st)
			if id ~= nil then
				spell.cast(id, t)
			else
				spell.cast(st, t)
			end
		end
	end
end
spell.castat = function(s, t, offset)
	if s then
		if t == "mouse" then
			spell.cast(s)
			ni.player.clickat("mouse")
		elseif ni.unit.exists(t) then
			local offset = true and offset or random()
			local x, y, z = ni.unit.info(t)
			local r = offset * sqrt(random())
			local theta = random() * 360
			local tx = x + r * cos(theta)
			local ty = y + r * sin(theta)
			spell.cast(s)
			ni.player.clickat(tx, ty, z)
		end
	end
end
spell.bestaoeloc = function(unit, distance, radius, friendly, minimumcount, inc, zindex_inc)
	return ni.functions.bestloc(unit, distance, radius, friendly, minimumcount, inc, zindex_inc);
end
spell.casthelpfulatbest = function(s, unit, distance, radius, minimumcount, inc, zindex_inc)
	local x, y, z = spell.bestaoeloc(unit, distance, radius, true, minimumcount, inc, zindex_inc);
	if x and y and z then
		spell.cast(s);
		ni.player.clickat(x, y, z);
	end
end
spell.castharmfulatbest = function(s, unit, distance, radius, minimumcount, inc, zindex_inc)
	local x, y, z = spell.bestaoeloc(unit, distance, radius, false, minimumcount, inc, zindex_inc);
	if x and y and z then
		spell.cast(s);
		ni.player.clickat(x, y, z);
	end
end
spell.castqueue = function(...)
	local id, tar = ...
	if id == nil then
		id = ni.getspellidfromactionbar()
	end
	if id == nil or id == 0 then
		return
	end
	for k, v in pairs(spell.queue) do
		if tContains(v[2], id) then
			ni.frames.spellqueue.update()
			tremove(spell.queue, k)
			return
		end
	end
	tinsert(spell.queue, {spell.cast, {id, tar}})
	ni.frames.spellqueue.update(id, true)
end
spell.castatqueue = function(...)
	local id, tar = ...
	if id == nil then
		id = ni.getspellidfromactionbar()
		tar = "target"
	end
	if id == nil or id == 0 then
		return
	end
	for k, v in pairs(spell.queue) do
		if tContains(v[2], id) then
			ni.frames.spellqueue.update()
			tremove(spell.queue, k)
			return
		end
	end
	if tar ~= nil then
		tinsert(spell.queue, {spell.castat, {id, tar}})
		ni.frames.spellqueue.update(id, true)
	end
end
spell.stopcasting = function()
	ni.functions.stopcasting()   
end
spell.stopchanneling = function()
	MoveForwardStart()
    MoveForwardStart()
end
spell.valid = function(t, spellid, facing, los, friendly)
	friendly = true and friendly or false
	los = true and los or false
	facing = true and facing or false

	if tonumber(spellid) == nil then
		spellid = spell.id(spellid)
		if spellid == 0 then
			return false
		end
	end

	local unitid = ni.unit.id(t)

	if unitid then
		if (ni.tables.whitelistedlosunits[unitid]) then
			ni.debug.log(tostring(ni.player.isfacing(t)) .. " " .. tostring(ni.player.los(t)))
			return true
		end
	end

	local name, _, _, cost, _, powertype = GetSpellInfo(spellid)

	if
		ni.unit.exists(t) and ((not friendly and (not UnitIsDeadOrGhost(t) and UnitCanAttack("player", t) == 1)) or friendly) and
			IsSpellInRange(name, t) == 1 and
			(IsSpellKnown(spellid) or (ni.vars.build >= 50400 and IsPlayerSpell(spellid))) and
			ni.player.powerraw(powertype) >= cost and
			((facing and ni.player.isfacing(t)) or not facing) and
			((los and ni.player.los(t)) or not los)
	 then
		return true
	end

	return false
end
spell.getinterrupt = function()
	local interruptSpell = 0

	if class == "SHAMAN" then
		interruptSpell = 57994
	elseif class == "WARRIOR" then
		if ni.vars.build >= 40300 then
			interruptSpell = 6552
		else
			if GetShapeshiftForm() == 3 then
				interruptSpell = 6552
			elseif GetShapeshiftForm() == 2 then
				interruptSpell = 72
			end
		end
	elseif class == "PRIEST" then
		interruptSpell = 15487
	elseif class == "DEATHKNIGHT" then
		interruptSpell = 47528
	elseif class == "ROGUE" then
		interruptSpell = 1766
	elseif class == "MAGE" then
		interruptSpell = 2139
	elseif class == "HUNTER" then
		interruptSpell = 34490
	elseif class == "MONK" then
		interruptSpell = 116705
	elseif class == "WARLOCK" and IsSpellKnown(19647, true) then
			interruptSpell = 19647
	end

	return interruptSpell
end
spell.castinterrupt = function(t)
	local interruptSpell = spell.getinterrupt()

	if interruptSpell ~= 0 and spell.cd(interruptSpell) == 0 then
		spell.stopcasting()
		spell.stopchanneling()
		spell.cast(interruptSpell, t)
	end
end
spell.getpercent = function()
	return math.random(40, 60)
end
spell.shouldinterrupt = function(t, p)
	local InterruptPercent = p or spell.getpercent()
	local castName, _, _, _, castStartTime, castEndTime, _, _, castinterruptable = UnitCastingInfo(t)
	local channelName, _, _, _, channelStartTime, channelEndTime, _, channelInterruptable = UnitChannelInfo(t)

	if channelName ~= nil then
		castName = channelName
		castStartTime = channelStartTime
		castEndTime = channelEndTime
		castinterruptable = channelInterruptable
	end

	if castName ~= nil then
		if castinterruptable then
			return false
		end

		if UnitCanAttack("player", t) == nil then
			return false
		end
		
		local timeSinceStart = (GetTime() * 1000 - castStartTime) / 1000
		local casttime = castEndTime - castStartTime - select(3, GetNetStats())
		local currentpercent = timeSinceStart / casttime * 100000

		if (currentpercent < InterruptPercent) then
			return false
		end

		if ni.vars.interrupt == "wl" then
			if tContains(ni.vars.interrupts.whitelisted, castName) then
				return true
			else
				return false
			end
		else
			if tContains(ni.vars.interrupts.blacklisted, castName) then
				return false
			end
		end
		return true
	end
	return false
end
spell.isinstant = function(s)
	return select(7, GetSpellInfo(s)) == 0
end
return spell;
