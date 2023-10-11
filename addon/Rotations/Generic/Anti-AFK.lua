local queue = {
	"Anti-AFK",
	"TSM DESTROY",
}
local lastreset = 0;
local abilities = {
	["TSM DESTROY"] = function()
		if (TSMDestroyingFrame ~= nil) then
			if TSMDestroyingFrame:IsVisible() then
				ni.player.runtext("/click TSMDestroyButton")
			end
		end
	end,
	["Anti-AFK"] = function()
		if GetTime() - lastreset > 30 then
			ni.utils.resetlasthardwareaction();
			lastreset = GetTime();
		end
	end,
}
ni.bootstrap.rotation("Anti-AFK", queue, abilities);
