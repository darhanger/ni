--Local variables accessed by the functions in this file, but no where else
local version = 1.0;

--Main table to return
local example = {};

--Function to get the version
function example.version()
	return version;
end

--Combat log event handler that gets attached to the main one
function example.combatfilter(event, ...)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local _, subevent, _, source, _, destGUID, dest;
		if ni.vars.build < 30400 then
			_, subevent, _, source, _, destGUID, dest = ...;
		else
			_, subevent, _, _, source, _, _, destGUID, dest = ...;
		end
		if subevent == "UNIT_DIED" then
			if UnitCanAssist("player", destGUID) then
				local name = dest:upper();
				local sex = UnitSex(destGUID);
				local gender = (sex == 2 and "HIM") or (sex == 3 and "HER") or "THEM";
				DoEmote("POINT", name);
				SendChatMessage("HAHA, "..name.." DIED! LETS ALL LAUGH AT "..gender.."!", "YELL");
				DoEmote("POINT", name);
			end
		end
	end
end

--Finished up with everything so we return it now to be used in the profile
return example;