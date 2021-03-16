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
}
return memory;