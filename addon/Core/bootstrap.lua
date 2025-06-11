local type, queue, wipe = type, queue, wipe;
local isFunction = ni.utils.isfunction;
local function StartRotation(name, queue, abilities, data, GUI)
	local profile = { };
	profile.loaded = false;
	profile.name = name;
	profile.GUI = GUI;
	profile.data = data;
	function profile.execute(self)
		if not self.loaded then
			if self.data ~= nil 
			and #self.data > 0
			and self.data.key ~= nil then
				if ni.utils.loaddatafiles(self.data) then
					self.loaded = true;
				end
			else
				self.loaded = true;
			end
		end
		local temp_queue;
		if isFunction(queue) then
			temp_queue = queue();
		else
			temp_queue = queue;
		end
		for i = 1, #temp_queue do
			local abilityinqueue = temp_queue[i]
			if abilities[abilityinqueue] ~= nil and abilities[abilityinqueue]() then
				break;
			end
		end
	end;
	function profile.createGUI(self)
		if self.GUI ~= nil and #self.GUI > 0 then
			ni.GUI.AddFrame(self.GUI[1], self.GUI[2]);
		end
	end;
	function profile.destroyGUI(self)
		if self.GUI ~= nil and #self.GUI > 0 then
			ni.GUI.DestroyFrame(self.GUI[1]);
		end
	end;
	function profile.unload(self)
		if self.loaded
		and self.data
		and self.data.key then
			wipe(ni.data[self.data.key])
			ni.data[self.data.key] = nil;
			ni.frames.spellqueueholder:Hide()
			self.loaded = false;
		end
	end;
	return profile;
end;
local function StartProfile(name, queue, abilities, onload, onunload)
	local profile = {};
	profile.loaded = false;
	profile.name = name;
	function profile.load(self)
		if not self.loaded
		and onload ~= nil
		and isFunction(onload) then
			onload();
			self.loaded = true;
		end
	end
	function profile.unload(self)
		if self.loaded
		and onunload ~= nil
		and isFunction(onunload) then
			onunload();
			ni.frames.spellqueueholder:Hide()
			self.loaded = false;
		end
	end
	function profile.execute(self)
		local temp_queue;
		if isFunction(queue) then
			temp_queue = queue();
		else
			temp_queue = queue;
		end
		for i = 1, #temp_queue do
			local abilityinqueue = temp_queue[i]
			if abilities[abilityinqueue] ~= nil and abilities[abilityinqueue]() then
				break;
			end
		end
	end
	return profile;
end;
local bootstrap = {
	rotation = function(profile, queue, abilities, data, GUI)
		GUI = true and GUI or {};
		data = true and data or {};
		ni.rotation.profile[profile] = StartRotation(profile, queue, abilities, data, GUI);
	end,
	profile = function(profile, queue, abilities, onload, onunload)
		ni.rotation.profile[profile] = StartProfile(profile, queue, abilities, onload, onunload);
	end
};
return bootstrap;