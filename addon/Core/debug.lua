local print = print;
local debug = {
	print = function(string)
		if ni.vars.debug then
			ni.utils.print("\124cffff0000" .. string);
		end
	end,
	log = function(string)
	
	end
};
local memory = {
	baseaddress = function()
		return ni.functions.baseaddress();
	end,
	objectpointer = function(object)
		return ni.functions.objectpointer(object);
	end,
	read = function(readtype, address, ...)
		return ni.functions.read(readtype, address, ...);
	end
};
return debug, memory;