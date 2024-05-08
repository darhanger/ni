ni = ni or {
	functions = {
		moveto = %%MoveTo%%,
		clickat = %%ClickAt%%,
		registercallback = %%RegisterCallback%%,
		auras = %%Auras%%,
		require = %%Require%%,
		getmapid = %%GetMapID%%,
		bestloc = %%BestLoc%%,
		combatreach = %%CombatReach%%,
		objectexists = %%ObjectExists%%,
		getom = %%GetOM%%,
		interact = %%Interact%%,
		item = %%Item%%,
		inventoryitem = %%InventoryItem%%,
		objectinfo = %%ObjectInfo%%,
		isfacing = %%IsFacing%%,
		isbehind = %%IsBehind%%,
		hasaura = %%HasAura%%,
		runtext = %%RunText%%,
		getdistance = %%GetDistance%%,
		lookat = %%LookAt%%,
		unitcreator = %%UnitCreator%%,
		settarget = %%SetTarget%%,
		stopmoving = %%StopMoving%%,
		unitdynamicflags = %%UnitDynamicFlags%%,
		unitflags = %%UnitFlags%%,
		creaturetype = %%CreatureType%%,
		cast = %%Cast%%,
		getspellid = %%GetSpellID%%,
		stopcasting = %%StopCasting%%,
		los = %%LoS%%,
		objectpointer = %%ObjectPointer%%,
		baseaddress = %%BaseAddress%%,
		objecttransport = %%ObjectTransport%%,
		objectfacing = %%ObjectFacing%%,
		resetlasthardwareaction = %%ResetLastHardwareAction%%,
		callprotected = %%CallProtected%%,
		webrequest = %%WebRequest%%,
		getrandomnamefor = %%GetRandomNameFor%%,
		loadcontent = %%LoadContent%%,
		savecontent = %%SaveContent%%,
		getbasefolder = %%GetBaseFolder%%,
		getprofilesfor = %%GetProfilesFor%%,
		getpath = %%GetPath%%,
		freemaps = %%FreeMaps%%,
		getdescriptor = %%GetDescriptor%%,
		setcreaturetracking = %%SetCreatureTracking%%,
		setresourcetracking = %%SetResourceTracking%%,
		readdistance = %%WebRequest%%,
		open = %%Open%%,
		read = %%Read%%,
		toggleconsole = %%ToggleConsole%%,
	}
};
if not ni.loaded then
	local loaded_files = {};
	ni.unpack = function(...)
		local n = select('#', ...)
		return setmetatable({...}, {
			__len = function() return n end,
		})
	end;
	ni.require = function(name)
		if not name:find(".lua") and not name:find(".enc") then
			name = name..".lua"
		end
		if not loaded_files[name] then
			loaded_files[name] = ni.unpack(ni.functions.require(name));
		end
		return unpack(loaded_files[name]);
	end;
    local dir = ni.functions.getbasefolder();
	local _ = ni.require(dir.."addon\\core\\loading.lua");

	ni.functionsregistered = function()
		return %%ToggleConsole%% ~= nil;
	end

	ni.loadstuff();
	ni.loaded = true;
end;	
