local queue = {
	"Anti-AFK"
}
local lastreset = 0;
local abilities = {
	["Anti-AFK"] = function()
		if GetTime() - lastreset > 30 then
			ni.utils.resetlasthardwareaction();
			lastreset = GetTime();
		end
	end,
}
ni.bootstrap.rotation("Anti-AFK", queue, abilities);