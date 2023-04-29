-- $Id: LibStub.lua 103 2014-10-16 03:02:50Z mikk $
local LibStub = {libs = {}, minors = {}};

function LibStub:NewLibrary(major, minor)
	assert(type(major) == "string", "Bad argument #2 to `NewLibrary' (string expected)")
	minor = assert(tonumber(strmatch(minor, "%d+")), "Minor version must either be a number or contain a number.")
	local oldminor = self.minors[major]
	if oldminor and oldminor >= minor then return nil end
	self.minors[major], self.libs[major] = minor, self.libs[major] or {}
	return self.libs[major], oldminor
end

function LibStub:GetLibrary(major, silent)
	if not self.libs[major] and not silent then
		error(("Cannot find a library instance of %q."):format(tostring(major)), 2)
	end
	return self.libs[major], self.minors[major]
end

function LibStub:IterateLibraries() 
	return pairs(self.libs) 
end

setmetatable(LibStub, { __call = LibStub.GetLibrary })

return LibStub;