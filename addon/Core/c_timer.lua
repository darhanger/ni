-- ###################################################################################
-- #####################################  C_Timer  ###################################
-- ###################################################################################
local CreateFrame, pairs, tonumber, setmetatable = CreateFrame, pairs, tonumber, setmetatable;
local TickerPrototype = {};
local TickerMetatable = {
	__index = TickerPrototype,
	__metatable = true
};

local C_Timer = {
	Schedule_After = {},
	Schedule_idx = {n=0},
	Frame = CreateFrame("Frame")
};
local timers_after = C_Timer.Schedule_After;
local idx = C_Timer.Schedule_idx;

C_Timer.Frame:SetScript("OnUpdate", function(_, elapsed)
	for keyIndex, tbl in pairs(timers_after) do
		tbl.next = tbl.next - elapsed
		if (tbl.next <= 0) then
			tbl.callback()
			timers_after[keyIndex] = nil
		end
	end
end);

C_Timer.After = function(duration, callback)
	timers_after[idx.n] = {callback = callback, next = duration};
	idx.n = idx.n + 1;
end;

function C_Timer.NewTicker(duration, callback, iterations, name)
	local ticker = setmetatable({}, TickerMetatable)
	local limit = 1*10^-10
	duration = tonumber(duration)
	ticker._duration = duration < limit and limit or duration
	ticker._name = name or ""
	ticker._remainingIterations = iterations or false
	ticker._callback = function()
		if (not ticker._cancelled) then
			callback(ticker)
			if (not ticker._cancelled) then
				if (ticker._remainingIterations) then
					ticker._remainingIterations = ticker._remainingIterations - 1
				end
				if (not ticker._remainingIterations or ticker._remainingIterations > 0) then
					C_Timer.After(ticker._duration, ticker._callback, ticker._name);
				end
			end
		end
	end
	C_Timer.After(ticker._duration, ticker._callback, ticker._name);
	return ticker;
end;

function C_Timer.NewTimer(duration, callback, name)
	return C_Timer.NewTicker(duration, callback, 1, name);
end;
function TickerPrototype:Cancel()
	self._cancelled = true;
end;
function TickerPrototype:IsCancelled()
	return self._cancelled;
end;
function TickerPrototype:UpdateTicker(duration)
	self._duration = duration or self._duration
	return self._duration;
end;

return C_Timer;