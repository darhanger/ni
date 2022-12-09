local vars = {
	latency = 225,
	interrupt = "all",
	debug = false,
	icon = true,
	customtarget = "player",
	hotkeys = {
		aoe = "Left Shift",
		cd = "Left Control",
		pause = "None",
		custom = "Left Alt",
		primary = "F1",
		secondary = "F2",
		generic = "F3",
		interrupt = "F4",
		follow = "F5",
		gui = "F10"
	},
	profiles = {
		primary = "None",
		primaryidx = 1,
		secondary = "None",
		secondaryidx = 1,
		active = "None",
		generic = "None",
		genericenabled = false,
		delay = 0,
		interrupt = false,
		enabled = false,
		useEngine = true
	},
	units = {
		follow = "",
		followEnabled = false,
		mainTank = "",
		mainTankEnabled = false,
		offTank = "",
		offTankEnabled = false
	},
	combat = {
		started = false,
		time = 0,
		ended = 0,
		melee = false,
		cd = false,
		aoe = false,
		casting = false,
		queued = false,
		currentcastend = 0,
		spellqueueenabled = false,
		spellqueuems = 0.3
	},
	interrupts = {
		whitelisted = {},
		blacklisted = {}
	}
}
return vars;