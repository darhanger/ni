local string_char, string_gmatch, tinsert, strlower, strmatch, tContains, pairs = string.char, string.gmatch, tinsert, strlower, strmatch, tContains, pairs
local utils = { };
utils.splitstringbydelimiter = function(str, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	for st in string_gmatch(str, "([^" .. sep .. "]+)") do
		tinsert(t, st)
	end
	return t
end;
utils.splitstring = function(str)
	return utils.splitstringbydelimiter(str, "|")
end;
utils.splitstringtolower = function(str)
	str = strlower(str)
	return utils.splitstring(str)
end;
utils.findand = function(str)
	return str and (strmatch(str, "&&") and true) or nil
end;
utils.firstcharacterupper = function(str)
	str = strlower(str)
	return str:sub(1, 1):upper() .. str:sub(2)
end;
utils.fileexists = function(filename)
	return ni.functions.fileexists(filename);
end;
utils.resetlasthardwareaction = function()
	ni.functions.resetlasthardwareaction();
end;
local function RandomVariable(length)
	local res = ""
	for i = 1, length do
		res = res .. string_char(ni.strongrand.generate(97, 122))
	end
	return res
end;
local generated_names = { };
utils.generaterandomname = function()
	local name = RandomVariable(20);
	while tContains(generated_names, name) do
		name = RandomVariable(20);
	end
	tinsert(generated_names, name);
	return name;
end;
utils.mergetables = function(firsttable, secondtable)
    for k, v in pairs(secondtable) do
        firsttable[k] = v
    end
end;
utils.deepcopytable = function(o, seen)
    seen = seen or {};
    if o == nil then return nil end
    if seen[o] then return seen[o] end
    local no
    if type(o) == 'table' then
        no = {}
        seen[o] = no
        for k, v in next, o, nil do
            no[utils.deepcopytable(k, seen)] = utils.deepcopytable(v, seen)
        end
        setmetatable(no, utils.deepcopytable(getmetatable(o), seen))
    else -- number, string, boolean, etc
        no = o
    end
    return no;
end;
return utils;