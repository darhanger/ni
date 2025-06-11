local time, math_floor, string_char, string_gmatch, tinsert, strlower, strmatch, tContains, pairs, PlaySound = time, math.floor, string.char, string.gmatch, tinsert, strlower, strmatch, tContains, pairs, PlaySound
local m = "Master";
local mwcexports = {};
local function normalize(n)
	return n % 0x80000000
end;

local multiply_with_carry = {}
multiply_with_carry.__index = multiply_with_carry

function multiply_with_carry:random(a, b)
	local m = self.m
	local t = self.a * self.x + self.c
	local y = t % m
	self.x = y
	self.c = math_floor(t / m)
	if not a then return y / 0x10000
	elseif not b then
		if a == 0 then return y
		else return 1 + (y % a) end
	else
		return a + (y % (b - a + 1));
	end
end;

function multiply_with_carry:randomseed(s)
	if not s then s = 0 end
	self.c = self.ic
	self.x = normalize(s)
end;

function mwc(s)
	local temp = {};
	setmetatable(temp, multiply_with_carry)
	temp.a, temp.c, temp.m = 214013, 2531011, 0x10000;
	temp.ic = temp.c
	temp:randomseed(s)
	return temp
end;

local c1 = mwc(0)
c1:randomseed(time())

mwcexports.generate = function(a,b)
	return c1:random(a,b)
end;

local utils = { };
utils.splitstringbydelimiter = function(str, sep)
	if sep == nil then
		sep = "%s";
	end
	local t = {};
	for st in string_gmatch(str, "([^" .. sep .. "]+)") do
		tinsert(t, st);
	end
	return t;
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
        local rand = mwcexports.generate(1, 3)
        if rand == 1 then
            res = res .. string_char(mwcexports.generate(97, 122));
        elseif rand == 2 then
            res = res .. string_char(mwcexports.generate(65, 90));
        elseif rand == 3 then
            res = res .. string_char(mwcexports.generate(48, 57));
        end
    end
    return res;
end;
utils.generated_names = {};
utils.generaterandomname = function()
	local v = random(10, 19);
	local name = RandomVariable(v);
	while tContains(utils.generated_names, name) do
		name = RandomVariable(v);
	end
	tinsert(utils.generated_names, name);
	return name;
end;
utils.name_for_func = {}; 
utils.rannameforfunc = function(m, mx)
    local v;
    if not m or not mx then
        v = random(10, 19);
    else
        v = random(m, mx);
    end;
    local name = RandomVariable(v);
    while tContains(utils.name_for_func, name) do
        v = random(m or 10, mx or 19);
        name = RandomVariable(v);
    end
    tinsert(utils.name_for_func, name);
    return name;
end;
utils.mergetables = function(firsttable, secondtable)
    for k, v in pairs(secondtable) do
        firsttable[k] = v;
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
    else
        no = o
    end
    return no;
end;
utils.ranval = function(minimum, maximum)
    return random()*(maximum-minimum) + minimum;
end;
utils.isfunction = function(f)
	return type(f) == "function";
end;
utils.isstring = function(f)
	return type(f) == "string";
end;
utils.istable = function(f)
	return type(f) == "table";
end;

local getPadCache = {};
utils.padding = function(count)
	if not getPadCache[count] then
		local pad = "";
		for i = 1, count do
			pad = pad.."\124r";
		end
		getPadCache[count] = pad;
	end
	return getPadCache[count];
end;

utils.print = function(message)
	local dap = utils.padding(random(1, 255));
	return print(dap..message);
end;

return mwcexports, utils;