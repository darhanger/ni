local queue = {
	"Pause",
	"NimbleBrew",
	"StanceoftheSturdyOx",
	"LegacyoftheEmperor",
	"PurifyingBrew",
	"ElusiveBrew",
	"SpearHandStrike",
	"Guard",
	"SummonBlackOxStatue",
	"TouchofDeath",
	"KegSmash",
	"RushingJadeWind",
	"BreathofFire",
	"BlackoutKick",
	"TigerPalm",
	"ExpelHarm",
	"SpinningCraneKick",
	"ChiWave",
	"Jab",
	"TigerPalmFiller",
	"AutoAttack"
}

--Localize
local IsSpellInRange,
	IsCurrentSpell,
	IsMounted,
	UnitIsDeadOrGhost,
	UnitExists,
	UnitCanAttack,
	GetShapeshiftFormID,
	IsSpellKnown =
	IsSpellInRange,
	IsCurrentSpell,
	IsMounted,
	UnitIsDeadOrGhost,
	UnitExists,
	UnitCanAttack,
	GetShapeshiftFormID,
	IsSpellKnown

local spells = {
	--build == 50400
	--General icon = select(2, GetSpellTabInfo(1))
	AutoAttack = {id = 6603, name = GetSpellInfo(6603), icon = select(3, GetSpellInfo(6603))},
	--Brewmaster icon = select(2, GetSpellTabInfo(2))
	AvertHarm = {id = 115213, name = GetSpellInfo(115213), icon = select(3, GetSpellInfo(115213))},
	BlackoutKick = {id = 100784, name = GetSpellInfo(100784), icon = select(3, GetSpellInfo(100784))},
	BreathofFire = {id = 115181, name = GetSpellInfo(115181), icon = select(3, GetSpellInfo(115181))},
	Clash = {id = 122057, name = GetSpellInfo(122057), icon = select(3, GetSpellInfo(122057))},
	CracklingJadeLightning = {id = 117952, name = GetSpellInfo(117952), icon = select(3, GetSpellInfo(117952))},
	Detox = {id = 115450, name = GetSpellInfo(115450), icon = select(3, GetSpellInfo(115450))},
	Disable = {id = 116095, name = GetSpellInfo(116095), icon = select(3, GetSpellInfo(116095))},
	DizzyingHaze = {id = 115180, name = GetSpellInfo(115180), icon = select(3, GetSpellInfo(115180))},
	ElusiveBrew = {id = 115308, name = GetSpellInfo(115308), icon = select(3, GetSpellInfo(115308))},
	ExpelHarm = {id = 115072, name = GetSpellInfo(115072), icon = select(3, GetSpellInfo(115072))},
	FortifyingBrew = {id = 115203, name = GetSpellInfo(115203), icon = select(3, GetSpellInfo(115203))},
	GrappleWeapon = {id = 117368, name = GetSpellInfo(117368), icon = select(3, GetSpellInfo(117368))},
	Guard = {id = 115295, name = GetSpellInfo(115295), icon = select(3, GetSpellInfo(115295))},
	HealingSphere = {id = 115460, name = GetSpellInfo(115460), icon = select(3, GetSpellInfo(115460))},
	Jab = {id = 100780, name = GetSpellInfo(100780), icon = select(3, GetSpellInfo(100780))},
	KegSmash = {id = 121253, name = GetSpellInfo(121253), icon = select(3, GetSpellInfo(121253))},
	LegacyoftheEmperor = {id = 115921, name = GetSpellInfo(115921), icon = select(3, GetSpellInfo(115921))},
	NimbleBrew = {id = 137562, name = GetSpellInfo(137562), icon = select(3, GetSpellInfo(137562))},
	Paralysis = {id = 115078, name = GetSpellInfo(115078), icon = select(3, GetSpellInfo(115078))},
	Provoke = {id = 115546, name = GetSpellInfo(115546), icon = select(3, GetSpellInfo(115546))},
	PurifyingBrew = {id = 119582, name = GetSpellInfo(119582), icon = select(3, GetSpellInfo(119582))},
	Resuscitate = {id = 115178, name = GetSpellInfo(115178), icon = select(3, GetSpellInfo(115178))},
	Roll = {id = 109132, name = GetSpellInfo(109132), icon = select(3, GetSpellInfo(109132))},
	SpinningCraneKick = {id = 101546, name = GetSpellInfo(101546), icon = select(3, GetSpellInfo(101546))},
	SpearHandStrike = {id = 116705, name = GetSpellInfo(116705), icon = select(3, GetSpellInfo(116705))},
	StanceoftheFierceTiger = {id = 103985, name = GetSpellInfo(103985), icon = select(3, GetSpellInfo(103985))},
	StanceoftheSturdyOx = {id = 115069, name = GetSpellInfo(115069), icon = select(3, GetSpellInfo(115069))},
	SummonBlackOxStatue = {id = 115315, name = GetSpellInfo(115315), icon = select(3, GetSpellInfo(115315))},
	TigerPalm = {id = 100787, name = GetSpellInfo(100787), icon = select(3, GetSpellInfo(100787))},
	TouchofDeath = {id = 115080, name = GetSpellInfo(115080), icon = select(3, GetSpellInfo(115080))},
	Transcendence = {id = 101643, name = GetSpellInfo(101643), icon = select(3, GetSpellInfo(101643))},
	TranscendenceTransfer = {id = 119996, name = GetSpellInfo(119996), icon = select(3, GetSpellInfo(119996))},
	ZenMeditation = {id = 115176, name = GetSpellInfo(115176), icon = select(3, GetSpellInfo(115176))},
	ZenPilgrimage = {id = 126892, name = GetSpellInfo(126892), icon = select(3, GetSpellInfo(126892))},
	BrewingElusiveBrew = {id = 128938, name = GetSpellInfo(128938), icon = select(3, GetSpellInfo(128938))},
	BrewmasterTraining = {id = 117967, name = GetSpellInfo(117967), icon = select(3, GetSpellInfo(117967))},
	DesperateMeasures = {id = 126060, name = GetSpellInfo(126060), icon = select(3, GetSpellInfo(126060))},
	DualWield = {id = 124146, name = GetSpellInfo(124146), icon = select(3, GetSpellInfo(124146))},
	FightingStyle = {id = 115074, name = GetSpellInfo(115074), icon = select(3, GetSpellInfo(115074))},
	GiftoftheOx = {id = 124502, name = GetSpellInfo(124502), icon = select(3, GetSpellInfo(124502))},
	LeatherSpecialization = {id = 120225, name = GetSpellInfo(120225), icon = select(3, GetSpellInfo(120225))},
	MasteryElusiveBrawler = {id = 117906, name = GetSpellInfo(117906), icon = select(3, GetSpellInfo(117906))},
	Parry = {id = 116812, name = GetSpellInfo(116812), icon = select(3, GetSpellInfo(116812))},
	SwiftReflexes = {id = 124334, name = GetSpellInfo(124334), icon = select(3, GetSpellInfo(124334))},
	Vengeance = {id = 120267, name = GetSpellInfo(120267), icon = select(3, GetSpellInfo(120267))},
	WayoftheMonk = {id = 120277, name = GetSpellInfo(120277), icon = select(3, GetSpellInfo(120277))},
	--Talents
	Celerity = {id = 115173, name = GetSpellInfo(115173), icon = select(3, GetSpellInfo(115173))},
	TigersLust = {id = nil, name = GetSpellInfo(nil), icon = select(3, GetSpellInfo(nil))},
	Momentum = {id = nil, name = GetSpellInfo(115174), icon = select(3, GetSpellInfo(115174))},
	ChiWave = {id = 115098, name = GetSpellInfo(115098), icon = select(3, GetSpellInfo(115098))},
	ZenSphere = {id = nil, name = GetSpellInfo(nil), icon = select(3, GetSpellInfo(nil))},
	ChiBurst = {id = nil, name = GetSpellInfo(nil), icon = select(3, GetSpellInfo(nil))},
	PowerStrikes = {id = nil, name = GetSpellInfo(nil), icon = select(3, GetSpellInfo(nil))},
	Ascension = {id = 115396, name = GetSpellInfo(115396), icon = select(3, GetSpellInfo(115396))},
	ChiBrew = {id = nil, name = GetSpellInfo(nil), icon = select(3, GetSpellInfo(nil))},
	RingofPeace = {id = nil, name = GetSpellInfo(nil), icon = select(3, GetSpellInfo(nil))},
	ChargingOxWave = {id = nil, name = GetSpellInfo(nil), icon = select(3, GetSpellInfo(nil))},
	LegSweep = {id = 119381, name = GetSpellInfo(119381), icon = select(3, GetSpellInfo(119381))},
	HealingElixirs = {id = 122280, name = GetSpellInfo(122280), icon = select(3, GetSpellInfo(122280))},
	DampenHarm = {id = nil, name = GetSpellInfo(nil), icon = select(3, GetSpellInfo(nil))},
	DiffuseMagic = {id = nil, name = GetSpellInfo(nil), icon = select(3, GetSpellInfo(nil))},
	RushingJadeWind = {id = 116847, name = GetSpellInfo(116847), icon = select(3, GetSpellInfo(116847))},
	InvokeXuentheWhiteTiger = {id = nil, name = GetSpellInfo(nil), icon = select(3, GetSpellInfo(nil))},
	ChiTorpedo = {id = nil, name = GetSpellInfo(nil), icon = select(3, GetSpellInfo(nil))}
}

local p, t = "player", "target"

local enables = {
	["ElusiveBrew"] = true,
	["SummonBlackOxStatue"] = false
}
local values = {
	["SpinningCraneKick"] = 3,
	["Guard"] = 90,
	["ElusiveBrew"] = 10
}
local inputs = {}
local menus = {}
local function GUICallback(key, item_type, value)
	if item_type == "enabled" then
		enables[key] = value
	elseif item_type == "value" then
		values[key] = value
	elseif item_type == "input" then
		inputs[key] = value
	elseif item_type == "menu" then
		menus[key] = value
	end
end
local items = {
	settingsfile = "BrewNuok.xml",
	callback = GUICallback,
	{type = "separator"},
	{type = "title", text = "\124T" .. select(2, GetSpellTabInfo(2)) .. ":20:20\124t Brewmaster"},
	{type = "separator"},
	{
		type = "entry",
		text = "\124T" .. spells.SpinningCraneKick.icon .. ":26:26\124t Spinning Crane Kick AoE",
		tooltip = "Use Spinning Crane Kick when in range AoE",
		value = values["SpinningCraneKick"],
		key = "SpinningCraneKick"
	},
	{
		type = "entry",
		text = "\124T" .. spells.Guard.icon .. ":26:26\124t Guard Hp",
		value = values["Guard"],
		key = "Guard"
	},
	{
		type = "entry",
		text = "\124T" .. spells.ElusiveBrew.icon .. ":26:26\124t Elusive Brew",
		tooltip = "Use Elusive Brew at x stacks",
		value = values["ElusiveBrew"],
		enabled = enables["ElusiveBrew"],
		key = "ElusiveBrew"
	},
	{
		type = "entry",
		text = "\124T" .. spells.SummonBlackOxStatue.icon .. ":26:26\124t Summon Black Ox Statue",
		enabled = enables["SummonBlackOxStatue"],
		key = "SummonBlackOxStatue"
	}
}

local incombat = false
local disabled = false
local function CombatEventCatcher(event, ...)
	if event == "PLAYER_REGEN_DISABLED" then
		incombat = true
	elseif event == "PLAYER_REGEN_ENABLED" then
		incombat = false
	end
end

local function OnLoad()
	ni.combatlog.registerhandler("Brewmaster", CombatEventCatcher)
	ni.GUI.AddFrame("Brewmaster", items)
end
local function OnUnload()
	ni.combatlog.unregisterhandler("Brewmaster")
	ni.GUI.DestroyFrame("Brewmaster")
end

local enemies = {}

local function ActiveEnemies()
	table.wipe(enemies)
	enemies = ni.player.enemiesinrange(9)
	for k, v in ipairs(enemies) do
		if ni.player.threat(v.guid) == -1 then
			table.remove(enemies, k)
		end
	end
	return #enemies
end

local function FacingLosCast(spell, tar)
	if ni.player.isfacing(tar, 145) and ni.player.los(tar) and IsSpellInRange(spell, tar) == 1 then
		ni.spell.cast(spell, tar)
		return true
	end
	return false
end

local function ValidUsable(id, tar)
	if ni.spell.available(id) and ni.spell.valid(tar, id, true, true) then
		return true
	end
	return false
end

local Shuffle, TigerPower, PowerGuard, DeathNote, ElusiveBrewStacks, SanctuaryoftheOx =
	115307,
	125359,
	118636,
	121125,
	128939,
	126119

local LightStagger, ModerateStagger, HeavyStagger = 124275, 124274, 124273

local abilities = {
	["Pause"] = function()
		if
			IsMounted() or UnitIsDeadOrGhost(p) or not UnitExists(t) or UnitIsDeadOrGhost(t) or
				(UnitExists(t) and not UnitCanAttack(p, t)) or
				ni.player.buff(spells.SpinningCraneKick.id)
		 then
			return true
		end
	end,
	["AutoAttack"] = function()
		if not IsCurrentSpell(spells.AutoAttack.id) and ni.unit.inmelee(p, t) and incombat then
			ni.spell.cast(spells.AutoAttack.name)
		end
	end,
	["StanceoftheSturdyOx"] = function()
		if GetShapeshiftFormID() ~= 23 and ni.spell.available(spells.StanceoftheSturdyOx.name) then
			ni.spell.cast(spells.StanceoftheSturdyOx.name)
		end
	end,
	["SpearHandStrike"] = function()
		if
			ni.spell.shouldinterrupt(t) and ValidUsable(spells.SpearHandStrike.id, t) and
				FacingLosCast(spells.SpearHandStrike.name, t)
		 then
			return true
		end
	end,
	["KegSmash"] = function()
		if ni.player.powerraw("chi") <= 3 and ValidUsable(spells.KegSmash.id, t) and FacingLosCast(spells.KegSmash.name, t) then
			return true
		end
	end,
	["TouchofDeath"] = function()
		if ni.player.buff(DeathNote) and ValidUsable(spells.TouchofDeath.id, t) and FacingLosCast(spells.TouchofDeath.name, t) then
			return true
		end
	end,
	["TigerPalm"] = function()
		if
			(ni.player.buffremaining(TigerPower) < 3 or ni.player.buffremaining(PowerGuard) < 3) and
				ValidUsable(spells.TigerPalm.id, t) and
				FacingLosCast(spells.TigerPalm.name, t) and
				ni.player.buffremaining(Shuffle) > 2
		 then
			return true
		end
	end,
	["TigerPalmFiller"] = function()
		if ValidUsable(spells.TigerPalm.id, t) and FacingLosCast(spells.TigerPalm.name, t) then
			return true
		end
	end,
	["BreathofFire"] = function()
		if
			not ni.unit.debuff(t, spells.BreathofFire.name, p) and ni.spell.available(spells.BreathofFire.name) and
				ni.player.isfacing(t, 90) and
				IsSpellInRange(spells.KegSmash.name, t) == 1 and
				ni.unit.debuff(t, spells.DizzyingHaze.name) and
				ni.player.powerraw("chi") >= 3 and
				(ni.player.buffremaining(Shuffle) > 1.5 or ni.player.hp() > 95)
		 then
			ni.spell.cast(spells.BreathofFire.name)
			return true
		end
	end,
	["BlackoutKick"] = function()
		if
			(ni.player.powerraw("chi") >= 3 or ni.player.buffremaining(Shuffle) < 2) and ValidUsable(spells.BlackoutKick.id, t) and
				FacingLosCast(spells.BlackoutKick.name, t)
		 then
			return true
		end
	end,
	["ChiWave"] = function()
		if ValidUsable(spells.ChiWave.id, t) and FacingLosCast(spells.ChiWave.name, t) then
			return true
		end
	end,
	["Jab"] = function()
		if
			ni.player.power("energy") >= 55 and ni.spell.cd(spells.KegSmash.id) > 1.5 and ValidUsable(spells.Jab.id, t) and
				FacingLosCast(spells.Jab.name, t)
		 then
			return true
		end
	end,
	["ExpelHarm"] = function()
		if
			ni.player.hp() < 95 and ni.player.power("energy") >= 50 and ni.spell.available(spells.ExpelHarm.id) and
				IsSpellInRange(spells.KegSmash.name, t) == 1
		 then
			ni.spell.cast(spells.ExpelHarm.name, p)
			return true
		end
	end,
	["Guard"] = function()
		if
			ni.player.hp() < values["Guard"] and ni.spell.available(spells.Guard.id) and
				IsSpellInRange(spells.KegSmash.name, t) == 1
		 then
			ni.spell.cast(spells.Guard.name, p)
			return true
		end
	end,
	["RushingJadeWind"] = function()
		if
			ActiveEnemies() >= 2 and ni.spell.available(spells.RushingJadeWind.id) and
				ni.spell.cast(spells.RushingJadeWind.name, p)
		 then
			return true
		end
	end,
	["SpinningCraneKick"] = function()
		if
			ActiveEnemies() >= values["SpinningCraneKick"] and ni.player.buffremaining(Shuffle) > 2 and
				ni.spell.available(spells.SpinningCraneKick.id) and
				ni.spell.cast(spells.SpinningCraneKick.name, p)
		 then
			return true
		end
	end,
	["PurifyingBrew"] = function()
		if ni.player.debuff(HeavyStagger) and ni.spell.available(spells.PurifyingBrew.id) then
			ni.spell.cast(spells.PurifyingBrew.name)
		end
	end,
	["LegacyoftheEmperor"] = function()
		if ni.spell.available(spells.LegacyoftheEmperor.id) and not ni.player.buffs("115921||20217||1126||90363") then
			ni.spell.cast(spells.LegacyoftheEmperor.name, p)
			return true
		end
	end,
	["ElusiveBrew"] = function()
		if enables["ElusiveBrew"] then
			if ni.spell.available(spells.ElusiveBrew.id) and ni.player.buffstacks(ElusiveBrewStacks) >= values["ElusiveBrew"] then
				ni.spell.cast(spells.ElusiveBrew.name, p)
				return true
			end
		end
	end,
	["NimbleBrew"] = function()
		if
			IsSpellKnown(spells.NimbleBrew.id) and ni.spell.cd(spells.NimbleBrew.id) == 0 and
				(ni.player.isstunned() or ni.player.isfleeing())
		 then
			ni.spell.cast(spells.NimbleBrew.id)
		end
	end,
	["SummonBlackOxStatue"] = function()
		if enables["SummonBlackOxStatue"] then
			if ni.spell.available(spells.SummonBlackOxStatue.id) and incombat and ni.unit.isboss(t) then
				if not ni.player.buff(SanctuaryoftheOx) then
					ni.spell.castat(spells.SummonBlackOxStatue.name, p)
					return true
				end
				if ni.player.buff(SanctuaryoftheOx) then
					local c = ni.unit.creations(p)
					local guid
					for i = 1, #c do
						local cr = c[i]
						if string.match(cr.name, "Ox") then
							guid = cr.guid
						end
					end
					if guid ~= nil and ni.player.distance(guid) > 38 then
						ni.spell.castat(spells.SummonBlackOxStatue.id, p)
						return true
					end
				end
			end
		end
	end
}
ni.bootstrap.profile("Brewmaster-MoP", queue, abilities, OnLoad, OnUnload)
