local vars = {
	latency = 220,
	interrupt = "all",
	debug = false,
	customtarget = "player",
	hotkeys = {
		aoe = "Left Alt",
		cd = "Left Control",
		pause = "Left Shift",
		custom = "None",
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