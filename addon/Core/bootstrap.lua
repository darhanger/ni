local wipe, ipairs, pairs, type = wipe, ipairs, pairs, type;
local GetTime = GetTime;
local isFunction = ni.utils.isfunction;

local Rotation = {};
Rotation.__index = Rotation;

function Rotation:execute()
	if not self.loaded then
		if self.data and #self.data > 0 and self.data.key then
			if ni.utils.loaddatafiles(self.data) then
				self.loaded = true;
			end
		else
			self.loaded = true;
		end
	end

	local temp_queue = isFunction(self.queue) and self.queue() or self.queue;
	for i = 1, #temp_queue do
		local ability = temp_queue[i];
		if self.abilities[ability] and self.abilities[ability]() then
			break;
		end
	end
end;

function Rotation:createGUI()
	if self.GUI and #self.GUI > 0 then
		ni.GUI.AddFrame(self.GUI[1], self.GUI[2]);
	end
end;

function Rotation:destroyGUI()
	if self.GUI and #self.GUI > 0 then
		ni.GUI.DestroyFrame(self.GUI[1]);
	end
end;

function Rotation:unload()
	if self.loaded and self.data and self.data.key then
		wipe(ni.data[self.data.key]);
		ni.data[self.data.key] = nil;
		ni.frames.spellqueueholder:Hide();
		self.loaded = false;
	end
end;

local function StartRotation(name, queue, abilities, data, GUI)
	local profile = {
		loaded = false,
		name = name,
		queue = queue,
		abilities = abilities,
		data = data,
		GUI = GUI
	};
	return setmetatable(profile, Rotation);
end

local Profile = {};
Profile.__index = Profile;

function Profile:load()
	if not self.loaded and self.OnLoad and isFunction(self.OnLoad) then
		self.OnLoad();
		self.loaded = true;
	end
end;

function Profile:unload()
	if self.loaded and self.OnUnLoad and isFunction(self.OnUnLoad) then
		self.OnUnLoad();
		ni.frames.spellqueueholder:Hide();
		self.loaded = false;
	end
end;

function Profile:execute()
	local temp_queue = isFunction(self.queue) and self.queue() or self.queue;
	for i = 1, #temp_queue do
		local ability = temp_queue[i];
		if self.abilities[ability] and self.abilities[ability]() then
			break;
		end
	end
end;

local function StartProfile(name, queue, abilities, OnLoad, OnUnLoad)
	local profile = {
		loaded = false,
		name = name,
		queue = queue,
		abilities = abilities,
		OnLoad = OnLoad,
		OnUnLoad = OnUnLoad
	};
	return setmetatable(profile, Profile);
end

local gSettings = gSettings or {};
local last_gset_time = GetTime();

local bootstrap = {
	getseting = function(name, gui)
		local xtime = GetTime();
		if xtime - last_gset_time > 0.5 then
			last_gset_time = xtime;
			wipe(gSettings);
		elseif gSettings[name] then
			return gSettings[name];
		end

		for _, v in ipairs(gui) do
			if (v.type == "entry" or v.type == "input") and v.key == name then
				gSettings[name] = {v.value, v.enabled};
				return gSettings[name];
			elseif v.type == "dropdown" and v.key == name then
				for _, v2 in pairs(v.menu) do
					if v2.selected then
						gSettings[name] = {v2.value, v2.selected};
						return gSettings[name];
					end
				end
			end
		end
		return {};
	end,

	rotation = function(name, queue, abilities, data, GUI)
		GUI = GUI or {};
		data = data or {};
		ni.rotation.profile[name] = StartRotation(name, queue, abilities, data, GUI);
	end,

	profile = function(name, queue, abilities, OnLoad, OnUnLoad)
		ni.rotation.profile[name] = StartProfile(name, queue, abilities, OnLoad, OnUnLoad);
	end
};

return bootstrap;