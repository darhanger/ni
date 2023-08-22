local pairs, type = _G.pairs, _G.type
local CreateFrame = _G.CreateFrame

local listener = {};
local tbl = {};

local onEvent = function(_, event, ...)
	if not tbl[event] then return end
	for k in pairs(tbl[event]) do
		tbl[event][k](event, ...);
	end
end;

local frame = CreateFrame('Frame')
frame:SetScript('OnEvent', onEvent)

function listener.add(_, name, event, callback, overwrite)
	if type(event) == "table" then
		for i = 1, #event do
			listener:add(name .. i, event[i], callback);
		end
		return;
	end
	if not tbl[event] then
		frame:RegisterEvent(event)
		tbl[event] = {};
	end
	if tbl[event][name] then
		if not overwrite then
			return;
		end
	end
	tbl[event][name] = callback;
end;

function listener.remove(_, name, event)
	if type(event) == "table" then
		for i = 1, #event do
			listener:remove(name .. i, event[i]);
		end
		return;
	end
	if tbl[event] then
		tbl[event][name] = nil
		if next(tbl[event])==nil then
			tbl[event] = nil;
			frame:UnregisterEvent(event);
		end		
	end
end;

function listener.call(_, event, ...)
	onEvent(nil, event, ...);
end;

return listener;