---DR Tracker
local registeredevents = {
	["SPELL_AURA_APPLIED"] = true,
	["SPELL_AURA_REFRESH"] = true,
	["SPELL_AURA_REMOVED"] = true,
	["PARTY_KILL"] = true,
	["UNIT_DIED"] = true
}

local drtracker_events = function(self, event, ...)
	local timestamp, eventType, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellID, spellName, spellSchool, auraType = ...;
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
end
---ICD Tracker
local icdevents = {
	["SPELL_AURA_APPLIED"] = true
}

local icdtracker = {};
icdtracker.timers = {};
icdtracker.set = function(item, icd)
	icdtracker.timers[item] = {
		icd = icd,
		time = 0
	}
end
icdtracker.get = function(item)
	if icdtracker.timers[item] then
		local remaining = icdtracker.timers[item].time - GetTime();
		if remaining < 1 then
			return 0;
		end
		return remaining;
	end
	return -1;
end

local icdtracker_events = function(self, event, ...)
	local timestamp, eventType, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellID, spellName, spellSchool, auraType = ...;
	if not icdevents[eventType] then
		return
	end
	if sourceGUID == UnitGUID("player") and auraType == "BUFF" then
		for k, v in pairs(icdtracker.timers) do
			if spellName == k then
				icdtracker.timers[k].time = GetTime() + v.icd
			end
		end
	end
end
-------------

local lastclick = 0;
local totalelapsed = 0;

local maul, cleave, heroicstrike, runestrike, raptorstrike, shadowcleave = GetSpellInfo(6807), GetSpellInfo(845), GetSpellInfo(78), GetSpellInfo(56815), GetSpellInfo(2973), GetSpellInfo(50581);

local function isspelltoignore(spellname)
	if spellname == maul
	 or spellname == cleave
	 or spellname == heroicstrike
	 or spellname == raptorstrike
	 or spellname == runestrike 
	 or spellname == shadowcleave then
		return true;
	end
	return false;
end

local events = {};

local delays = {};

local frames = {};
frames.notification = CreateFrame("frame", nil, UIParent);
frames.notification:SetSize(ChatFrame1:GetWidth(), 30)
frames.notification:Hide()
frames.notification:SetPoint("TOP", ChatFrame1, 0, 90)
frames.notification.text = frames.notification:CreateFontString(nil, "OVERLAY", "MovieSubtitleFont")
frames.notification.text:SetAllPoints()
frames.notification.texture = frames.notification:CreateTexture()
frames.notification.texture:SetAllPoints()
frames.notification.texture:SetTexture(0, 0, 0, .50)
function frames.notification:message(message)
	self.text:SetText(message)
	self:Show()
end
frames.spellqueueholder = CreateFrame("Frame")
frames.spellqueueholder:ClearAllPoints()
frames.spellqueueholder:SetHeight(30)
frames.spellqueueholder:SetWidth(275)
frames.spellqueueholder:SetMovable(true)
frames.spellqueueholder:EnableMouse(true)
frames.spellqueueholder:RegisterForDrag("LeftButton")
frames.spellqueueholder:SetBackdrop(
	{
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true,
		tileSize = 16,
		edgeSize = 16,
		insets = {left = 4, right = 4, top = 4, bottom = 4}
	}
)
frames.spellqueueholder:SetBackdropColor(0, 0, 0, 1)
frames.spellqueueholder:SetPoint("CENTER", UIParent, "BOTTOM", 0, 130)
frames.spellqueueholder:Hide()

frames.spellqueue = CreateFrame("Frame", nil, frames.spellqueueholder)
frames.spellqueue:ClearAllPoints()
frames.spellqueue:SetHeight(20)
frames.spellqueue:SetWidth(200)
frames.spellqueue:Show()
frames.spellqueue.text = frames.spellqueue:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
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
end

frames.floatingtext = CreateFrame("Frame")
frames.floatingtext:SetSize(400, 30)
frames.floatingtext:SetAlpha(0)
frames.floatingtext:SetPoint("CENTER", 0, 80)
frames.floatingtext.text = frames.floatingtext:CreateFontString(nil, "OVERLAY", "MovieSubtitleFont")
frames.floatingtext.text:SetAllPoints()
frames.floatingtext.texture = frames.floatingtext:CreateTexture()
frames.floatingtext.texture:SetAllPoints()
function frames.floatingtext:message(message)
	self.text:SetText(message)
	UIFrameFadeOut(self, 2.5, 1, 0)
end

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

ni.functions.registercallback(keyevents, OnKeyHandler);

frames.main = CreateFrame("frame");
frames.main:RegisterAllEvents();
frames.OnEvent = function(self, event, ...)
	if not ni.functionsregistered() then
		return
	end
	for _, v in pairs(events) do
		v(event, ...);
	end
	if event == "PLAYER_LEAVING_WORLD" then
		ni.functions.freemaps();
		ni.utils.savesetting(UnitName("player")..".json", ni.utils.json.encode(ni.vars));
	end
	if event == "PLAYER_REGEN_DISABLED" then
		ni.vars.combat.started = true
		ni.vars.combat.time = GetTime()
		ni.vars.combat.ended = 0
	end
	if event == "PLAYER_REGEN_ENABLED" then
		ni.vars.combat.started = false
		ni.vars.combat.time = 0
		ni.vars.combat.ended = GetTime()
	end
	if (event == "UNIT_SPELLCAST_SENT" or event == "UNIT_SPELLCAST_CHANNEL_START") and ni.vars.combat.casting == false then
		local unit, spell = ...
		if unit == "player" and not isspelltoignore(spell) then
			ni.vars.combat.casting = true
		end
	end
	if (event == "UNIT_SPELLCAST_SUCCEEDED"
	 or event == "UNIT_SPELLCAST_FAILED"
	 or event == "UNIT_SPELLCAST_FAILED_QUIET"
	 or event == "UNIT_SPELLCAST_INTERRUPTED"
	 or event == "UNIT_SPELLCAST_CHANNEL_STOP"
	 or event == "UNIT_SPELLCAST_STOP")
	 and ni.vars.combat.casting == true then
		local unit, spell = ...
		if unit == "player" and not isspelltoignore(spell) then
			if ni.vars.combat.casting then
				ni.vars.combat.casting = false
			end
		end
	end
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local _, subevent, _, source, _, _, dest, _, spellID, spellName = ...
		if source == UnitName("player") then
			if subevent == "SPELL_CAST_SUCCESS" or subevent == "SPELL_CAST_FAILED" and not isspelltoignore(spellName) then
				if ni.vars.combat.casting then
					ni.vars.combat.casting = false
				end
			end
		end
	end
	icdtracker_events(self, event, ...);
	drtracker_events(self, event, ...);
	if (event == "PARTY_MEMBERS_CHANGED" or event == "RAID_ROSTER_UPDATE" or event == "GROUP_ROSTER_UPDATE" or event == "PARTY_CONVERTED_TO_RAID" or event == "ZONE_CHANGED" or event == "PLAYER_ENTERING_WORLD") then
		ni.members.reset();
	end
end;
frames.OnUpdate = function(self, elapsed)
	if not ni.functionsregistered() then
		totalelapsed = 0;
		return true
	end

	if select(11, ni.player.debuff(9454)) == 9454 then
		return true
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
	}
	if (GetLocale() == "ruRU") then
		Localization.Enabled = "\124cff00ff00Включено"
		Localization.Disabled = "\124cffff0000Выключено"
	end

	if ni.vars.profiles.enabled then
		if ni.vars.combat.aoe or ni.vars.combat.cd and not frames.notification:IsShown() then
			local cd_str = ni.vars.combat.cd and Localization.Enabled or Localization.Disabled;
			local aoe_str = ni.vars.combat.aoe and Localization.Enabled or Localization.Disabled;
			frames.notification:message("\124cffFFC300AoE: "..aoe_str.." \124cffFFC300CD: "..cd_str);
		end
		ni.rotation.aoetoggle()
		ni.rotation.cdtoggle()
	else
		if frames.notification:IsShown() then
			frames.notification:Hide();
		end
	end

	local throttle = ni.vars.latency / 1000
	totalelapsed = totalelapsed + elapsed;
	self.st = elapsed + (self.st or 0)

	if self.st > throttle then
		totalelapsed = totalelapsed - throttle;
		self.st = 0;
		
		if ni.objects ~= nil then
			local tmp = ni.objectmanager.get() or {};
			for i = 1, #tmp do
				local ob = ni.objects:new(tmp[i].guid, tmp[i].type, tmp[i].name);
				if ob then
					rawset(ni.objects, tmp[i].guid, ob);
				end
			end
			ni.objects:updateobjects();
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

		if ni.vars.units.followEnabled and ni.vars.units.follow ~= nil and ni.vars.units.follow ~= "" then
			if ni.objectmanager.contains(ni.vars.units.follow) or UnitExists(ni.vars.units.follow) then
				local unit = ni.vars.units.follow
				local uGUID = ni.objectmanager.objectGUID(unit) or UnitGUID(unit)
				local followTar = nil
				local distance = nil

				if UnitAffectingCombat(uGUID) then
					local oTar = select(6, ni.unit.info(uGUID))
					if oTar ~= nil then
						followTar = oTar
					end
				end

				distance = ni.player.distance(uGUID)

				if not IsMounted() then
					if followTar ~= nil and ni.vars.combat.melee == true then
						distance = ni.player.distance(followTar)
						uGUID = followTar
					end
				end

				if followTar ~= nil then
					if not UnitIsUnit("target", followTar) then
						ni.player.target(followTar)
					end
				end

				if not ni.player.isfacing(uGUID) then
					ni.player.lookat(uGUID)
				end

				if
					not UnitCastingInfo("player") and not UnitChannelInfo("player") and distance ~= nil and distance > 1 and
						distance < 50 and
						GetTime() - lastclick > 1.5
				 then
					ni.player.moveto(uGUID)
					lastclick = GetTime()
				end

				if distance ~= nil and distance <= 1 and ni.player.ismoving() then
					ni.player.stopmoving()
				end
			end
		end

		if ni.vars.profiles.enabled or ni.vars.profiles.genericenabled then
			ni.player.registermovement(totalelapsed);
			if ni.vars.profiles.delay > GetTime() then
				return true;
			end
			if not ni.rotation.started then
				ni.rotation.started = true
			end
			if ni.vars.profiles.useEngine then
				ni.members:updatemembers()
			end
			if ni.rotation.stopmod() then
				return true
			end
			local count = #ni.spell.queue
			local i = 1
			while i <= count do
				local qRec = tremove(ni.spell.queue, i)
				local func = tremove(qRec, 1)
				local args = tremove(qRec, 1)
				local id, tar = unpack(args)
				frames.spellqueue.update(id, true)

				if ni.spell.available(id) and ((not ni.spell.isinstant(id) and not ni.player.ismoving()) or ni.spell.isinstant(id)) and not ni.spell.isqueued() then
					count = count - 1
					func(id, tar)
				else
					tinsert(ni.spell.queue, i, {func, args})
					i = i + 1
				end
			end
			if #ni.spell.queue == 0 then
				frames.spellqueue.update()
			end
			if ni.vars.profiles.genericenabled then
				if ni.vars.profiles.generic ~= "none" and ni.vars.profiles.generic ~= "None" then
					if ni.rotation.profile[ni.vars.profiles.generic] then
						ni.rotation.profile[ni.vars.profiles.generic]:execute()
					end
				end
			end
			if ni.vars.profiles.enabled then
				if ni.vars.profiles.active ~= "none" and ni.vars.profiles.active ~= "None" then
					if ni.rotation.profile[ni.vars.profiles.active] then
						ni.rotation.profile[ni.vars.profiles.active]:execute()
					end
				end
			end
		else
			if ni.rotation.started then
				ni.rotation.started = false
			end
		end
	end
end;

local combatlog = {
	registerhandler = function(name, callback)
		if not events[name] then
			events[name] = callback;
			return true;
		end
		return false;
	end,
	unregisterhandler = function(name)
		if events[name] then
			events[name] = nil;
			return true;
		end
		return false;
	end
}
local function delayfor(delay, callback)
	if type(delay) ~= "number" or type(callback) ~= "function" then
		return false
	end
	delays[GetTime() + delay] = callback;
	return true
end

return frames, combatlog, delayfor, icdtracker, keyevents;