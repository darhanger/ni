local fold = ni.functions.getbasefolder();
local req = ni.require;
local json = req(fold.."addon\\core\\json.lua");
local function secureStuff(randomFunc)
    local safeFunctions = {
        "AttackTarget", "AssistUnit", "AcceptProposal", "AcceptResurrect", "AcceptTrade",
        "CancelShapeshiftForm", "CastShapeshiftForm", "CastSpell", "CastSpellByID", "CastSpellByName",
        "MoveForwardStop", "MoveForwardStart", "StrafeLeftStart", "StrafeRightStart",
        "TargetNearestEnemy", "TargetNearestFriend", "TargetLastTarget", "TargetLastEnemy",
        "SpellStopCasting", "SpellStopTargeting", "ClearTarget", "UseContainerItem",
        "PetAttack", "PetWait", "PetPassiveMode", "ToggleSpellAutocast"
    };
    local secureFunctions = {};
    for _, funcName in pairs(safeFunctions) do
        secureFunctions[funcName..randomFunc] = function(...)
            return ni.functions.callprotected(funcName, ...)
        end
    end
    return secureFunctions;
end;
ni.loadstuff = function()
    local json = req(fold.."addon\\core\\json.lua");
    ni.C_Timer = req(fold.."addon\\core\\c_timer.lua");
	
	local function loadFileSettings(pathFile)
		local content = ni.functions.loadcontent(pathFile)
		if type(content) == "string" then
			if content:match('^{(.*)}$') then
				return json.decode(content)
			elseif content ~= "" then
				ni.C_Timer.After(3, function()
					message("\nThe configuration file was reseted,\nbecause the file was corrupted!")
				end)
			end
		end
		return req(fold.."addon\\core\\vars.lua")
	end
	local pathFile = fold.."addon\\settings\\"..UnitName("player")..".json"
	ni.vars = loadFileSettings(pathFile)
	
	-- ################################################################################
	-- Put here all the ni.vars that are necessary to reset after the loadFileSettings
	-- ################################################################################
	ni.vars.profiles.enabled = false;
	ni.vars.profiles.genericenabled = false;
	ni.vars.profiles.delay = 0;
	ni.vars.combat.started = UnitAffectingCombat("player");
	ni.vars.locale = GetLocale();
	ni.vars.combat.counter = 0; 
	-- ################################################################################
	ni.vars.build = select(4, GetBuildInfo());
	ni.strongrand, ni.utils = req(fold.."addon\\core\\utils.lua");
	ni.debug, ni.memory = req(fold.."addon\\core\\debug.lua");
	ni.rotation = req(fold.."addon\\core\\rotation.lua");
	ni.bootstrap = req(fold.."addon\\core\\bootstrap.lua");
	ni.tables = req(fold.."addon\\core\\tables.lua");
	ni.drtracker = req(fold.."addon\\core\\drtracker.lua");	
	ni.utils.req = req;
	ni.utils.json = json;
	ni.utils.savesetting = function(filename, settings)
		if type(settings) == "table" then
			settings = json.encode(settings);
		end
		ni.functions.savecontent(fold.."addon\\Settings\\"..filename, settings);
	end;
	ni.utils.getsettings = function(filename)
		local content = ni.functions.loadcontent(fold.."addon\\Settings\\"..filename);
		return content and json.decode(content) or {};
	end;
	ni.lib = {};	
	ni.lib.LibStub = req(fold.."addon\\core\\libs\\LibStub.lua");
	ni.lib.CallbackHandler = req(fold.."addon\\core\\libs\\CallbackHandler-1.0.lua");
	ni.lib.LibDataBroker = req(fold.."addon\\core\\libs\\LibDataBroker-1.1.lua");
	ni.lib.LibDBIcon = req(fold.."addon\\core\\libs\\LibDBIcon-1.0.lua");
	
	ni.listener = req(fold.."addon\\core\\listener.lua");
	ni.unit = req(fold.."addon\\core\\unit.lua");
	ni.player = req(fold.."addon\\core\\player.lua");
	ni.spell = req(fold.."addon\\core\\spell.lua");
	ni.frames, ni.combatlog, ni.delayfor, ni.icdtracker, ni.events = req(fold.."addon\\core\\frames.lua");
	
	ni.power, ni.rune = req(fold.."addon\\core\\power.lua");
	ni.healing, ni.tanks = req(fold.."addon\\core\\healing.lua");
	ni.members = req(fold.."addon\\core\\members.lua");
	ni.objects, ni.objectmanager = req(fold.."addon\\core\\objectmanager.lua");
	ni.stopcastingtracker = req(fold.."addon\\core\\stopcastingtracker.lua");
	ni.ttd = req(fold.."addon\\core\\timetodie.lua");
	ni.main = req(fold.."addon\\core\\mainui.lua");
	ni.GUI = req(fold.."addon\\core\\gui.lua");		
	
	local _ = req(fold.."addon\\core\\utils\\ItemID.lua");

	local float = ni.frames.floatingtext;
	local Local = {
		FollowOn = "Auto follow: \124cff00ff00Enabled",
		FollowOff = "Auto follow: \124cffff0000Disabled",
		InterruptOn = "Interrupts: \124cff00ff00Enabled",
		InterruptOff = "Interrupts: \124cffff0000Disabled",
	};
	if ni.vars.locale == "ruRU" then
		Local.FollowOn = "Авто следование: \124cff00ff00Включено"
		Local.FollowOff = "Авто следование: \124cffff0000Выключено"
		Local.InterruptOn = "Прерывание: \124cff00ff00Включено"
		Local.InterruptOff = "Прерывание: \124cffff0000Выключено"
	end;		
	
	ni.showstatus = function(str, enabled)		
		if enabled then
			ni.frames.floatingtext:message("\124cff00ff00" .. str)
		else
			ni.frames.floatingtext:message("\124cffff0000" .. str)
		end
	end;
	ni.toggleprofile = function(str)
		local unload = false;
		if ni.vars.profiles.active == str then
			ni.vars.profiles.enabled = not ni.vars.profiles.enabled;
			if ni.vars.profiles.enabled == false then
				unload = true;
			end
		else
			unload = true;
			ni.vars.profiles.enabled = true;
			ni.vars.profiles.active = str;
		end
		if unload then
			if ni.rotation.profile[ni.rotation.lastprofile] then
				if ni.rotation.profile[ni.rotation.lastprofile].unload then
					ni.rotation.profile[ni.rotation.lastprofile]:unload();
				end
				if ni.rotation.profile[ni.rotation.lastprofile].destroyGUI then
					ni.rotation.profile[ni.rotation.lastprofile]:destroyGUI();
				end
			end
		end
		if ni.vars.profiles.enabled then
			if ni.rotation.profile[str] then
				if ni.rotation.profile[str].load then
					ni.rotation.profile[str]:load();
				end
				if ni.rotation.profile[str].createGUI then
					ni.rotation.profile[str]:createGUI();
				end
			end
		end
		if ni.rotation.lastprofile ~= str then
			ni.rotation.lastprofile = str;
		end
		ni.showstatus(str, ni.vars.profiles.enabled);
	end;

	ni.togglegeneric = function(str)
		local unload = false;
		if ni.vars.profiles.generic == str then
			ni.vars.profiles.genericenabled = not ni.vars.profiles.genericenabled;
			if ni.vars.profiles.genericenabled == false then
				unload = true;
			end
		else
			unload = true;
			ni.vars.profiles.genericenabled = true;
			ni.vars.profiles.generic = str;
		end
		if unload then
			if ni.rotation.profile[ni.rotation.lastgeneric] then
				if ni.rotation.profile[ni.rotation.lastgeneric].unload then
					ni.rotation.profile[ni.rotation.lastgeneric]:unload();
				end
				if ni.rotation.profile[ni.rotation.lastgeneric].destroyGUI then
					ni.rotation.profile[ni.rotation.lastgeneric]:destroyGUI();
				end
			end
		end
		if ni.vars.profiles.genericenabled then
			if ni.rotation.profile[str] then
				if ni.rotation.profile[str].load then
					ni.rotation.profile[str]:load();
				end
				if ni.rotation.profile[str].createGUI then
					ni.rotation.profile[str]:createGUI();
				end
			end
		end
		if ni.rotation.lastgeneric ~= str then
			ni.rotation.lastgeneric = str;
		end
		ni.showstatus(str, ni.vars.profiles.genericenabled);
	end;

	ni.showintstatus = function()
		if ni.vars.profiles.interrupt then
			float:message(Local.InterruptOn);
		else
			loat:message(Local.InterruptOff);
		end
	end;

	ni.updatefollow = function(enabled)
		if enabled then
			float:message(Local.FollowOn);
		else
			float:message(Local.FollowOff);
		end
	end;

	ni.getspellidfromactionbar = function()
		local focus = GetMouseFocus():GetName()
		if string.match(focus, "Button") then
			local button = _G[focus]
			local slot = ActionButton_GetPagedID(button) or ActionButton_CalculateAction(button) or button:GetAttribute("action") or 0
			if HasAction(slot) then
				local aType, aID, _, aMaxID = GetActionInfo(slot)
				if aType == "spell" then
					return aMaxID ~= nil and aMaxID or aID
				end
			end
		end
	end;
	
	local orig_GetSpellInfo = GetSpellInfo;
	local spell_db = {};
	function GetSpellInfo(spell)
		if (type(spell) == "number") then
			if (not spell_db[spell]) then
				local a1,a2,a3,a4,a5,a6,a7,a8,a9 = orig_GetSpellInfo(spell);
				if(a1) then
					spell_db[spell] = {a1, a2, a3, a4, a5, a6, a7, a8, a9};
				else
					return a1, a2, a3, a4, a5, a6, a7, a8, a9;
				end
			end
			local value = spell_db[spell];
			return value[1], value[2], value[3], value[4], value[5], value[6], value[7], value[8], value[9];
		else
			return orig_GetSpellInfo(spell);
		end
	end;
	
	local old_UnitGUID = UnitGUID
	function UnitGUID(unit)
		local guid = old_UnitGUID(unit)
		if not guid and (unit == "player" or unit == "0x0") then
			return "0x0";
		end
		return guid;
	end;

	local _GetFramesRegisteredForEvent = GetFramesRegisteredForEvent;
	function GetFramesRegisteredForEvent(...)
		local result = {_GetFramesRegisteredForEvent(...)};
		local filteredResult = {};
		for i, frame in ipairs(result) do
			local frameName = frame:GetName();
			if frameName ~= nil then
				tinsert(filteredResult, frame);
			end
		end
		if #filteredResult > 0 then
			return unpack(filteredResult);
		else
			return nil;
		end
	end;

	ni.frames.main:SetScript("OnUpdate", ni.frames.OnUpdate);
	ni.frames.main:SetScript("OnEvent", ni.frames.OnEvent);

	secureStuff(ni.utils.rannameforfunc(3, 9));

	if ni.vars["global"] then
		_G[ni.vars["global"]] = ni;
	end

	ni.functions.savecontent(pathFile, json.encode(ni.vars));
end;