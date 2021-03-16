local data = {
	"Data_Example.lua"
}

local queue = {
	"Print Hello"
}

local queue2 = {
	"Print Hello World"
}

local abilities = {
	["Print Hello"] = function()
		ni.data.example.ishelloprinted = true
		ni.debug.log("Hello")
	end,
	["Print Hello World"] = function()
		ni.data.example.ishelloprinted = false
		ni.debug.log("Hello World")
	end
}

local dynamicqueue = function()
	if ni.data.example.ishelloprinted then
		return queue
	end

	return queue2
end

ni.bootstrap.rotation("Warlock_Example", dynamicqueue, abilities, data)
