local utils = {}
utils.splitstringbydelimiter = function(str, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	for st in string.gmatch(str, "([^" .. sep .. "]+)") do
		table.insert(t, st)
	end
	return t
end;
utils.splitstring = function(str)
	return utils.splitstringbydelimiter(str, "|")
end;
utils.splitstringtolower = function(str)
	str = string.lower(str)
	return utils.splitstring(str)
end;
utils.findand = function(str)
	return str and (string.match(str, "&&") and true) or nil
end;
utils.firstcharacterupper = function(str)
	str = string.lower(str)
	return str:sub(1, 1):upper() .. str:sub(2)
end;
utils.fileexists = function(filename)
	return ni.functions.fileexists(filename);
end;
utils.resetlasthardwareaction = function()
	ni.functions.resetlasthardwareaction();
end;
utils.mergetables = function(firsttable, secondtable)
	local tmp = {}

	for _, v in pairs(firsttable) do
		table.insert(tmp, v)
	end

	for _, v in pairs(secondtable) do
		table.insert(tmp, v)
	end

	return tmp
end;
return utils;