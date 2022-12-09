local print = print
local debug = {
	print = function(string)
		if ni.vars.debug then
			print("\124cffff0000" .. string);
		end
	end,
	log = function(string)
	
	end
}
return debug;