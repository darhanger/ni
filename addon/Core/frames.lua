local UnitCanAttack, IsInInstance, select, GetTime, UnitGUID, pairs, GetSpellInfo, random, print, UnitName, GetLocale, rawset, UnitExists, UnitAffectingCombat, IsMounted, UnitIsUnit, UnitCastingInfo, UnitChannelInfo, tremove, unpack, tinsert, type = UnitCanAttack, IsInInstance, select, GetTime, UnitGUID, pairs, GetSpellInfo, random, print, UnitName, GetLocale, rawset, UnitExists, UnitAffectingCombat, IsMounted, UnitIsUnit, UnitCastingInfo, UnitChannelInfo, tremove, unpack, tinsert, type
local ru = ni.vars.locale == "ruRU";
local _, pClass = UnitClass("player");

local function ranvalue(minimum, maximum)
    return random()*(maximum-minimum) + minimum;
end;

---DR Tracker
local registeredevents = {
	["SPELL_AURA_APPLIED"] = true,
	["SPELL_AURA_REFRESH"] = true,
	["SPELL_AURA_REMOVED"] = true,
	["PARTY_KILL"] = true,
	["UNIT_DIED"] = true
};
local drtracker_events = function(self, event, ...)
	local timestamp, eventType, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellID, spellName, spellSchool, auraType
	if ni.vars.build == 30300 then
		timestamp, eventType, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellID, spellName, spellSchool, auraType = ...
	elseif ni.vars.build >= 40300 then
		local arg = {...}
		timestamp, eventType, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellID, spellName, spellSchool, auraType = 
		arg[1], arg[2], arg[4], arg[5], arg[6], arg[8], arg[9], arg[10], arg[12], arg[13], arg[14], arg[15];
	end
	
	if (not registeredevents[eventType]) then
		return
	end
	
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		-- Enemy gained a debuff
		if (eventType == "SPELL_AURA_APPLIED") then
			-- Enemy had a debuff refreshed before it faded, so fade + gain it quickly
			if (auraType == "DEBUFF" and ni.tables.dr.spells[spellID]) then
				ni.drtracker.gained(spellID, destName, destGUID, UnitCanAttack("player", destGUID), destGUID)
			end
		elseif (eventType == "SPELL_AURA_REFRESH") then
			-- Buff or debuff faded from an enemy
			if (auraType == "DEBUFF" and ni.tables.dr.spells[spellID]) then
				ni.drtracker.faded(spellID, destName, destGUID, UnitCanAttack("player", destGUID), destGUID)
				ni.drtracker.gained(spellID, destName, destGUID, UnitCanAttack("player", destGUID), destGUID)
			end
		elseif (eventType == "SPELL_AURA_REMOVED") then
			-- Don't use UNIT_DIED inside arenas due to accuracy issues, outside of arenas we don't care too much
			if (auraType == "DEBUFF" and ni.tables.dr.spells[spellID]) then
				ni.drtracker.faded(spellID, destName, destGUID, UnitCanAttack("player", destGUID), destGUID)
			end
		elseif ((eventType == "UNIT_DIED" and select(2, IsInInstance()) ~= "arena") or eventType == "PARTY_KILL") then
			ni.drtracker.wipe(destGUID)
		end
	elseif event == "PLAYER_LEAVING_WORLD" then
		ni.drtracker.wipeall()
	end
end;

local lastclick, totalelapsed, lastEvent, objectPulse = 0, 0, 0, 0;
local instanceType

local ignoreSpells = {
    [GetSpellInfo(6807)] = true,  -- maul
    [GetSpellInfo(845)] = true,   -- cleave
    [GetSpellInfo(78)] = true,    -- heroicstrike
    [GetSpellInfo(56815)] = true, -- runestrike
    [GetSpellInfo(2973)] = true,  -- raptorstrike
    [GetSpellInfo(50581)] = true, -- shadowcleave
};

local function isspelltoignore(spellname)
    return ignoreSpells[spellname] or false;
end;

local events = {};
local delays = {};
local frames = {};
local dnc, mtime, isrange = 1, ranvalue(1, 2), false;

frames.distancecheck = function()
	if (ni.player.caster() or pClass == "HUNTER") then
		isrange = true;
		if ni.vars.combat.melee == true then
			dnc = 1;
			mtime = ranvalue(1, 2);
		else
			dnc = 10;
			mtime = ranvalue(.3, .8);
		end
	else
		isrange = false;
		dnc = 1;
		mtime = ranvalue(1, 2);
	end
end;
frames.distancecheck()

local notfram = ni.utils.generaterandomname();
frames.notification = CreateFrame("frame", notfram, UIParent);
frames.notification.ranH2, frames.notification.ranH = random(91, 95), random(31, 38);
frames.notification:SetSize(ChatFrame1:GetWidth(), frames.notification.ranH)
frames.notification:Hide()
frames.notification:SetPoint("TOP", ChatFrame1, 0, frames.notification.ranH2)
frames.notification.text = frames.notification:CreateFontString(nil, "OVERLAY", "MovieSubtitleFont")
frames.notification.text:SetAllPoints()
frames.notification.texture = frames.notification:CreateTexture()
frames.notification.texture:SetAllPoints()
frames.notification.texture:SetTexture(0, 0, 0, .50)
function frames.notification:message(message)
	local pad = ni.utils.padding(random(1, 350));
	self.text:SetText(pad..message)
	self:Show()
end
local spellqhol = ni.utils.generaterandomname();
frames.spellqueueholder = CreateFrame("Frame", spellqhol)
frames.spellqueueholder.ranW, frames.spellqueueholder.ranH = random(276, 285), random(31, 38);
frames.spellqueueholder:ClearAllPoints()
frames.spellqueueholder:SetHeight(frames.spellqueueholder.ranH)
frames.spellqueueholder:SetWidth(frames.spellqueueholder.ranW)
frames.spellqueueholder:SetMovable(true)
frames.spellqueueholder:EnableMouse(true)
frames.spellqueueholder:RegisterForDrag("LeftButton")
frames.spellqueueholder.texture = frames.spellqueueholder:CreateTexture()
frames.spellqueueholder.texture:SetAllPoints()
frames.spellqueueholder.texture:SetTexture(0, 0, 0, .50)
frames.spellqueueholder:SetBackdropColor(0, 0, 0, 1)
frames.spellqueueholder:SetPoint("CENTER", UIParent, "BOTTOM", 0, 130)
frames.spellqueueholder:Hide()

local spellq = ni.utils.generaterandomname();
frames.spellqueue = CreateFrame("Frame", spellq, frames.spellqueueholder)
frames.spellqueue.ranW, frames.spellqueue.ranH = random(201, 215), random(21, 26);
frames.spellqueue:ClearAllPoints()
frames.spellqueue:SetHeight(frames.spellqueue.ranH)
frames.spellqueue:SetWidth(frames.spellqueue.ranW)
frames.spellqueue:Show()
frames.spellqueue.text = frames.spellqueue:CreateFontString(nil, "OVERLAY", "GameFontNormal")
frames.spellqueue.text:SetAllPoints()
frames.spellqueue.text:SetJustifyV("MIDDLE")
frames.spellqueue.text:SetJustifyH("CENTER")
frames.spellqueue.text:SetText("\124cFFFFFFFFQueued Ability: \124cFF15E615None")
frames.spellqueue:SetPoint("CENTER", frames.spellqueueholder, 0, 0)
function frames.spellqueue.update(str, bool)
	bool = true and bool or false
	if bool then
		if frames.spellqueueholder:IsShown() == nil then
			frames.spellqueueholder:Show()
		end
		frames.spellqueue.text:SetText("\124cFFFFFFFFQueued Ability: \124cFF15E615" .. GetSpellInfo(str))
	else
		frames.spellqueue.text:SetText("\124cFFFFFFFFQueued Ability: \124cFF15E615None")
		if frames.spellqueueholder:IsShown() == 1 then
			frames.spellqueueholder:Hide()
		end
	end
end;

local floattext = ni.utils.generaterandomname();
frames.floatingtext = CreateFrame("Frame", floattext)
frames.floatingtext.ranW, frames.floatingtext.ranH = random(510, 535), random(32, 40);
frames.floatingtext:SetSize(frames.floatingtext.ranW, frames.floatingtext.ranH)
frames.floatingtext:SetAlpha(0)
frames.floatingtext:SetPoint("CENTER", 0, 80)
frames.floatingtext.text = frames.floatingtext:CreateFontString(nil, "OVERLAY", "MovieSubtitleFont")
frames.floatingtext.text:SetAllPoints()
frames.floatingtext.texture = frames.floatingtext:CreateTexture()
frames.floatingtext.texture:SetAllPoints()
local function FadeOut(frame, duration)
    local alpha = 1;
    local start = GetTime();
    frame:SetScript("OnUpdate", function(self, elapsed)
        local now = GetTime();
        local progress = (now - start) / duration;
        alpha = 1 - progress;
        if alpha <= 0 then
            alpha = 0;
            self:SetScript("OnUpdate", nil);
        end
        self:SetAlpha(alpha);
        self.text:SetAlpha(alpha);
    end)
end;
function frames.floatingtext:message(message, fadeTime)
	fadeTime = fadeTime or 2.5;
    local pad = ni.utils.padding(random(1, 150));

	self.text:SetText(pad .. message);
	self:SetAlpha(1);
	self.text:SetAlpha(1);
	FadeOut(self, fadeTime);
end;

local keyevents = {};
local keypress_events = {};
keyevents.registerkeyevent = function(name, callback)
	if not keypress_events[name] then
		keypress_events[name] = callback;
		return true;
	end
	return false;
end;

keyevents.unregisterkeyevent = function(name)
	keypress_events[name] = nil;
end;

local function OnKeyHandler(self, keyType, key)
	local result = false;
	for k, v in pairs(keypress_events) do
		if v(keyType, key) then
			result = true;
		end
	end
	return result;
end;

local function ranvalue(minimum, maximum)
    return random()*(maximum-minimum) + minimum;
end;

ni.functions.registercallback(keyevents, OnKeyHandler);


local startCastEvents = {
	["UNIT_SPELLCAST_SENT"] = true,
	["UNIT_SPELLCAST_CHANNEL_START"] = true
};
local spellCastEvents = {
	["UNIT_SPELLCAST_SUCCEEDED"] = true,
	["UNIT_SPELLCAST_FAILED"] = true,
	["UNIT_SPELLCAST_FAILED_QUIET"] = true,
	["UNIT_SPELLCAST_INTERRUPTED"] = true,
	["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
	["UNIT_SPELLCAST_STOP"] = true
};
local relevantEvents = {
	["PARTY_MEMBERS_CHANGED"] = true,
	["RAID_ROSTER_UPDATE"] = true,
	["GROUP_ROSTER_UPDATE"] = true,
	["PARTY_CONVERTED_TO_RAID"] = true,
	["PLAYER_ENTERING_WORLD"] = true
};
local function handleCombatStart()
	ni.vars.combat.counter = ni.vars.combat.counter + 1;
	ni.vars.combat.started = true;
	ni.vars.combat.time = GetTime();
	ni.vars.combat.ended = 0;
end;
local function handleCombatEnd()
	ni.vars.combat.started = false;
	ni.vars.combat.time = 0;
	ni.vars.combat.ended = GetTime();
end;

local eventsToRegister = {
    -- COMBAT_LOG для DR‑трекера и Vengeful Shade
    "COMBAT_LOG_EVENT_UNFILTERED",
    -- Сохранение/очистка при выходе
    "PLAYER_LEAVING_WORLD",
    -- Касты
    "UNIT_SPELLCAST_SENT",
    "UNIT_SPELLCAST_CHANNEL_START",
    "UNIT_SPELLCAST_SUCCEEDED",
    "UNIT_SPELLCAST_FAILED",
    "UNIT_SPELLCAST_FAILED_QUIET",
    "UNIT_SPELLCAST_INTERRUPTED",
    "UNIT_SPELLCAST_CHANNEL_STOP",
    "UNIT_SPELLCAST_STOP",
    -- Разное
    "ZONE_CHANGED_NEW_AREA",
    -- Реген / бой
    "PLAYER_REGEN_DISABLED",
    "PLAYER_REGEN_ENABLED",
    -- Смена состава группы/рейда/зоны
    "PARTY_MEMBERS_CHANGED",
    "RAID_ROSTER_UPDATE",
    "GROUP_ROSTER_UPDATE",
    "PARTY_CONVERTED_TO_RAID",
    "PLAYER_ENTERING_WORLD",
};

frames.main = CreateFrame("frame");
for _, evt in ipairs(eventsToRegister) do
    frames.main:RegisterEvent(evt);
end;
frames.OnEvent = function(self, event, ...)
	if not ni.functionsregistered() then
		return
	end
	for _, v in pairs(events) do
		v(event, ...);
	end	
	if event == "PLAYER_REGEN_DISABLED" then
		ni.C_Timer.After(0, handleCombatStart)
	elseif event == "PLAYER_REGEN_ENABLED" then
		ni.C_Timer.After(0, handleCombatEnd)
	end;
	if startCastEvents[event] and not ni.vars.combat.casting then
		local unit, spell = ...
		if unit == "player" and not isspelltoignore(spell) then
			ni.vars.combat.casting = true;
		end
	end;
	if spellCastEvents[event] and ni.vars.combat.casting then
		local unit, spell = ...
		if unit == "player" and not isspelltoignore(spell) then
			ni.vars.combat.casting = false;
		end
	end
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local subevent, source, dest, spellID, spellName
		if ni.vars.build == 30300 then
			_, subevent, _, source, _, _, dest, _, spellID, spellName = ...
		elseif ni.vars.build >= 40300 then
			local arg = {...}
			subevent, source, dest, spellID, spellName = arg[2], arg[5], arg[9], arg[12], arg[13];
		end
		lastEvent = GetTime();
		if source == UnitName("player") then
			if subevent == "SPELL_CAST_SUCCESS" or subevent == "SPELL_CAST_FAILED" and not isspelltoignore(spellName) then
				if ni.vars.combat.casting then
					ni.vars.combat.casting = false
				end
			end
		end
	end
	drtracker_events(self, event, ...);
	if relevantEvents[event] then
		ni.members.reset();
	end;
	if event == "ZONE_CHANGED_NEW_AREA" then
		if #ni.utils.name_for_func > 55 then
			local numToDelete = math.min(15, #ni.utils.name_for_func);
			for i = 1, numToDelete do
				tremove(ni.utils.name_for_func, #ni.utils.name_for_func);
			end
		end;
		local type = select(2, IsInInstance())
		if (instanceType and type ~= instanceType) then
			CombatLogClearEntries();
		end
		instanceType = type;
	end
end;
frames.OnUpdate = function(self, elapsed)
	if not ni.functionsregistered() then
		totalelapsed = 0;
		return true;
	end
	if ni.player.debuff(9454) then
		return true;
	end
	local time = GetTime();
	for k, v in pairs(delays) do
		if k <= time then
			v();
			delays[k] = nil;
		end
	end
	local Localization = {
		Enabled = "\124cff00ff00Enabled",
		Disabled = "\124cffff0000Disabled",
	};
	if ru then
		Localization.Enabled = "\124cff00ff00Включено"
		Localization.Disabled = "\124cffff0000Выключено"
	end;
	if ni.vars.profiles.enabled then
		if not ni.vars.stream then
			if ni.vars.combat.aoe or ni.vars.combat.cd and not frames.notification:IsShown() then
				local cd_str = ni.vars.combat.cd and Localization.Enabled or Localization.Disabled;
				local aoe_str = ni.vars.combat.aoe and Localization.Enabled or Localization.Disabled;
				frames.notification:message("\124cffFFC300AoE: "..aoe_str.." \124cffFFC300CD: "..cd_str);
			end
			ni.rotation.aoetoggle();
			ni.rotation.cdtoggle();
		end
	else
		if frames.notification:IsShown() then
			frames.notification:Hide();
		end		
	end;
	if ni.vars.profiles.enabled then
		if ni.vars.stream then
			if ni.vars.combat.aoe or ni.vars.combat.cd then
				local cd_str = ni.vars.combat.cd and Localization.Enabled or Localization.Disabled;
				local aoe_str = ni.vars.combat.aoe and Localization.Enabled or Localization.Disabled;	
			end
			ni.rotation.aoetoggle();
			ni.rotation.cdtoggle();
		end
	end;
	
	local latency = ni.vars.latency
	local randomLatency = ni.utils.ranval(latency, latency * 1.5) / 1000;
	local throttle = randomLatency;
	totalelapsed = totalelapsed + elapsed;
	self.st = elapsed + (self.st or 0);

	if self.st > throttle then
		totalelapsed = totalelapsed - throttle;
		self.st = 0;
		
		if ni.objects then
			local xtime = GetTime();
			local tmp = ni.objectmanager.get();
			for i = 1, #tmp do
				local ob = ni.objects:new(tmp[i].guid, tmp[i].type, tmp[i].name);
				if ob then
					ni.objects[tmp[i].guid] = ob;
				end
			end

			if xtime - objectPulse > .4 then
				ni.objects:updateobjects();
				objectPulse = xtime;
			end
		end
		
		ni.drtracker.updateresettime();
		
		if ni.vars.profiles.interrupt then
			if ni.spell.shouldinterrupt("target") then
				ni.spell.castinterrupt("target");
			end
			if ni.spell.shouldinterrupt("focus") then
				ni.spell.castinterrupt("focus");
			end
		end

		if ni.player.incombat() and (GetTime() - lastEvent >= 1) then
			CombatLogClearEntries();
	    end		
		if ni.vars.units.followEnabled and ni.vars.units.follow ~= nil and ni.vars.units.follow ~= "" then
			if UnitExists(ni.vars.units.follow) or ni.objectmanager.contains(ni.vars.units.follow) then
				local unit = ni.vars.units.follow;
				local uGUID = UnitGUID(unit) or ni.objectmanager.objectGUID(unit);
				local followTar = nil;
				local distance = nil;

				if ni.unit.incombat(uGUID) then
					local oTar = select(6, ni.unit.info(uGUID));
					if oTar ~= nil then
						followTar = oTar;
					end
				end

				distance = ni.player.distance(uGUID)
				if not ni.player.unitisdead() then
					if not IsMounted() then
						if (followTar ~= nil and followTar ~= "0x0000000000000000") then
							if (ni.vars.combat.melee == true and not isrange) then
								distance = ni.player.distance(followTar);
								uGUID = followTar;
							end
						end
					end
					
					if (followTar ~= nil and followTar ~= "0x0000000000000000") then
						if not UnitIsUnit("target", followTar) then
							ni.player.target(followTar);
							if not ni.player.isfacing(followTar) then
								if not isrange then
									ni.player.moveto(followTar);
								end
								ni.player.lookat(followTar);
							end
						end
					end
				end
				
				if not ni.unit.unitisdead(uGUID) then
					if not UnitCastingInfo("player") and not UnitChannelInfo("player") 
					and distance ~= nil and distance > dnc and distance < 45
					and GetTime() - lastclick > tonumber(format("%.1f", mtime)) then
						ni.player.moveto(uGUID);
						lastclick = GetTime();
					end
				end
					
				if distance ~= nil and distance <= dnc and ni.player.ismoving() then
					ni.player.stopmoving();
				end
			end
		end;

		if ni.vars.profiles.enabled or ni.vars.profiles.genericenabled then
			if ni.vars.profiles.delay > GetTime() then
				return true;
			end
			if not ni.rotation.started then
				ni.rotation.started = true;
			end
			if ni.vars.profiles.useEngine then
				ni.members:updatemembers();
			end
			if ni.rotation.stopmod() then
				return true;
			end
			local count = #ni.spell.queue
			local i = 1
			while i <= count do
				local qRec = tremove(ni.spell.queue, i)
				local func = tremove(qRec, 1);
				local args = tremove(qRec, 1);
				local id, tar = unpack(args);
				frames.spellqueue.update(id, true);

				if ni.spell.available(id) and ((not ni.spell.isinstant(id) and not ni.player.ismoving()) or ni.spell.isinstant(id)) and not ni.spell.isqueued() then
					count = count - 1;
					func(id, tar);
				else
					tinsert(ni.spell.queue, i, {func, args});
					i = i + 1;
				end
			end
			if #ni.spell.queue == 0 then
				frames.spellqueue.update();
			end
			if ni.vars.profiles.genericenabled then
				if ni.vars.profiles.generic ~= "none" and ni.vars.profiles.generic ~= "None" then
					if ni.rotation.profile[ni.vars.profiles.generic] then
						ni.rotation.profile[ni.vars.profiles.generic]:execute();
					end
				end
			end
			if ni.vars.profiles.enabled then
				if ni.vars.profiles.active ~= "none" and ni.vars.profiles.active ~= "None" then
					if ni.rotation.profile[ni.vars.profiles.active] then
						ni.rotation.profile[ni.vars.profiles.active]:execute();
					end
				end
			end
		else
			if ni.rotation.started then
				ni.rotation.started = false;
			end
		end
	end
end;

local handlerRegistry = {};
local eventCallbacks = {};
local ProfileEventFrame = CreateFrame("Frame");

ProfileEventFrame:SetScript("OnEvent", function(self, event, ...)
    if eventCallbacks[event] then
        for _, callback in pairs(eventCallbacks[event]) do
            callback(event, ...);
        end
    end
end);

local combatlog = {
    registerhandler = function(profileName, events, callback)
        if handlerRegistry[profileName] then return false end
        
        handlerRegistry[profileName] = {
            events = events,
            callback = callback
        }
        for _, event in ipairs(events) do
            if not eventCallbacks[event] then
                eventCallbacks[event] = {}
                ProfileEventFrame:RegisterEvent(event);
            end
            tinsert(eventCallbacks[event], callback);
        end
        return true;
    end,
    
    unregisterhandler = function(profileName)
        local profile = handlerRegistry[profileName];
        if not profile then return false end
        
        for _, event in ipairs(profile.events) do
            if eventCallbacks[event] then
                for i = #eventCallbacks[event], 1, -1 do
                    if eventCallbacks[event][i] == profile.callback then
                        tremove(eventCallbacks[event], i);
                    end
                end
                if #eventCallbacks[event] == 0 then
                    ProfileEventFrame:UnregisterEvent(event);
                    eventCallbacks[event] = nil;
                end
            end
        end
        handlerRegistry[profileName] = nil;
        return true;
    end
};

local function delayfor(delay, callback)
	if type(delay) ~= "number" or type(callback) ~= "function" then
		return false;
	end
	delays[GetTime() + delay] = callback;
	return true;
end;

return frames, combatlog, delayfor, keyevents;