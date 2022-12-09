local setmetatable, time = setmetatable, time
local mwcexports = {};
local math_floor = math.floor
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
		return a + (y % (b - a + 1))
	end
end;

function multiply_with_carry:randomseed(s)
	if not s then s = 0 end
	self.c = self.ic
	self.x = normalize(s)
end;

function mwc(s)
	local temp = {}
	setmetatable(temp, multiply_with_carry)
	temp.a, temp.c, temp.m = 214013, 2531011, 0x10000 -- constants from msvc
	temp.ic = temp.c
	temp:randomseed(s)
	return temp
end;

local c1 = mwc(0)
c1:randomseed(time())

mwcexports.generate = function(a,b)
	return c1:random(a,b)
end;
return mwcexports;