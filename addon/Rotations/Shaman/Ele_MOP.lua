local queue = {
	"Pause",
	"FlametongueWeapon",
	"LightningShield",
	"Thunderstorm",
	"FlameShock",
	"UnleashElements",
	"LavaBurst",
	"ElementalBlast",
	"EarthShock",
	"SearingTotem",
	"ChainLightning",
	"LightningBolt"
}

local IsSpellInRange,
	IsMounted,
	UnitIsDeadOrGhost,
	UnitExists,
	UnitCanAttack,
	IsUsableSpell,
	GetWeaponEnchantInfo,
	GetTotemInfo =
	IsSpellInRange,
	IsMounted,
	UnitIsDeadOrGhost,
	UnitExists,
	UnitCanAttack,
	IsUsableSpell,
	GetWeaponEnchantInfo,
	GetTotemInfo

local spells = {
	--build == 50400
	--General icon = select(2, GetSpellTabInfo(1))
	AutoAttack = {id = 6603, name = GetSpellInfo(6603), icon = select(3, GetSpellInfo(6603))},
	--Elemental icon = select(2, GetSpellTabInfo(2))
	CapacitorTotem = {id = 108269, name = GetSpellInfo(108269), icon = select(3, GetSpellInfo(108269))},
	GroundingTotem = {id = 8177, name = GetSpellInfo(8177), icon = select(3, GetSpellInfo(8177))},
	StormlashTotem = {id = 120668, name = GetSpellInfo(120668), icon = select(3, GetSpellInfo(120668))},
	SpiritLinkTotem = {id = 98008, name = GetSpellInfo(98008), icon = select(3, GetSpellInfo(98008))},
	WindwalkTotem = {id = 108273, name = GetSpellInfo(108273), icon = select(3, GetSpellInfo(108273))},
	AncestralSpirit = {id = 2008, name = GetSpellInfo(2008), icon = select(3, GetSpellInfo(2008))},
	Ascendance = {id = 114049, name = GetSpellInfo(114049), icon = select(3, GetSpellInfo(114049))},
	AstralRecall = {id = 556, name = GetSpellInfo(556), icon = select(3, GetSpellInfo(556))},
	BindElemental = {id = 76780, name = GetSpellInfo(76780), icon = select(3, GetSpellInfo(76780))},
	Bloodlust = {id = 2825, name = GetSpellInfo(2825), icon = select(3, GetSpellInfo(2825))},
	ChainHeal = {id = 1064, name = GetSpellInfo(1064), icon = select(3, GetSpellInfo(1064))},
	ChainLightning = {id = 421, name = GetSpellInfo(421), icon = select(3, GetSpellInfo(421))},
	CleanseSpirit = {id = 51886, name = GetSpellInfo(51886), icon = select(3, GetSpellInfo(51886))},
	EarthShock = {id = 8042, name = GetSpellInfo(8042), icon = select(3, GetSpellInfo(8042))},
	EarthbindTotem = {id = 2484, name = GetSpellInfo(2484), icon = select(3, GetSpellInfo(2484))},
	EarthgrabTotem = {id = 51485, name = GetSpellInfo(51485), icon = select(3, GetSpellInfo(51485))},
	TremorTotem = {id = 8143, name = GetSpellInfo(8143), icon = select(3, GetSpellInfo(8143))},
	EarthElementalTotem = {id = 2062, name = GetSpellInfo(2062), icon = select(3, GetSpellInfo(2062))},
	StoneBulwarkTotem = {id = 108270, name = GetSpellInfo(108270), icon = select(3, GetSpellInfo(108270))},
	Earthquake = {id = 61882, name = GetSpellInfo(61882), icon = select(3, GetSpellInfo(61882))},
	FarSight = {id = 6196, name = GetSpellInfo(6196), icon = select(3, GetSpellInfo(6196))},
	FireElementalTotem = {id = 2894, name = GetSpellInfo(2894), icon = select(3, GetSpellInfo(2894))},
	MagmaTotem = {id = 8190, name = GetSpellInfo(8190), icon = select(3, GetSpellInfo(8190))},
	SearingTotem = {id = 3599, name = GetSpellInfo(3599), icon = select(3, GetSpellInfo(3599))},
	FlameShock = {id = 8050, name = GetSpellInfo(8050), icon = select(3, GetSpellInfo(8050))},
	FrostShock = {id = 8056, name = GetSpellInfo(8056), icon = select(3, GetSpellInfo(8056))},
	GhostWolf = {id = 2645, name = GetSpellInfo(2645), icon = select(3, GetSpellInfo(2645))},
	HealingRain = {id = 73920, name = GetSpellInfo(73920), icon = select(3, GetSpellInfo(73920))},
	HealingSurge = {id = 8004, name = GetSpellInfo(8004), icon = select(3, GetSpellInfo(8004))},
	Hex = {id = 51514, name = GetSpellInfo(51514), icon = select(3, GetSpellInfo(51514))},
	LavaBurst = {id = 51505, name = GetSpellInfo(51505), icon = select(3, GetSpellInfo(51505))},
	LightningBolt = {id = 403, name = GetSpellInfo(403), icon = select(3, GetSpellInfo(403))},
	LightningShield = {id = 324, name = GetSpellInfo(324), icon = select(3, GetSpellInfo(324))},
	PrimalStrike = {id = 73899, name = GetSpellInfo(73899), icon = select(3, GetSpellInfo(73899))},
	Purge = {id = 370, name = GetSpellInfo(370), icon = select(3, GetSpellInfo(370))},
	ShamanisticRage = {id = 30823, name = GetSpellInfo(30823), icon = select(3, GetSpellInfo(30823))},
	SpiritwalkersGrace = {id = 79206, name = GetSpellInfo(79206), icon = select(3, GetSpellInfo(79206))},
	Thunderstorm = {id = 51490, name = GetSpellInfo(51490), icon = select(3, GetSpellInfo(51490))},
	TotemicRecall = {id = 36936, name = GetSpellInfo(36936), icon = select(3, GetSpellInfo(36936))},
	UnleashElements = {id = 73680, name = GetSpellInfo(73680), icon = select(3, GetSpellInfo(73680))},
	WaterShield = {id = 52127, name = GetSpellInfo(52127), icon = select(3, GetSpellInfo(52127))},
	HealingStreamTotem = {id = 5394, name = GetSpellInfo(5394), icon = select(3, GetSpellInfo(5394))},
	ManaTideTotem = {id = 16190, name = GetSpellInfo(16190), icon = select(3, GetSpellInfo(16190))},
	HealingTideTotem = {id = 108280, name = GetSpellInfo(108280), icon = select(3, GetSpellInfo(108280))},
	WaterWalking = {id = 546, name = GetSpellInfo(546), icon = select(3, GetSpellInfo(546))},
	EarthlivingWeapon = {id = 51730, name = GetSpellInfo(51730), icon = select(3, GetSpellInfo(51730))},
	WindfuryWeapon = {id = 8232, name = GetSpellInfo(8232), icon = select(3, GetSpellInfo(8232))},
	FlametongueWeapon = {id = 8024, name = GetSpellInfo(8024), icon = select(3, GetSpellInfo(8024))},
	FrostbrandWeapon = {id = 8033, name = GetSpellInfo(8033), icon = select(3, GetSpellInfo(8033))},
	RockbiterWeapon = {id = 8017, name = GetSpellInfo(8017), icon = select(3, GetSpellInfo(8017))},
	WindShear = {id = 57994, name = GetSpellInfo(57994), icon = select(3, GetSpellInfo(57994))},
	AncestralFocus = {id = 89920, name = GetSpellInfo(89920), icon = select(3, GetSpellInfo(89920))},
	BurningWrath = {id = 77747, name = GetSpellInfo(77747), icon = select(3, GetSpellInfo(77747))},
	ElementalFocus = {id = 16164, name = GetSpellInfo(16164), icon = select(3, GetSpellInfo(16164))},
	ElementalFury = {id = 60188, name = GetSpellInfo(60188), icon = select(3, GetSpellInfo(60188))},
	ElementalOath = {id = 51470, name = GetSpellInfo(51470), icon = select(3, GetSpellInfo(51470))},
	ElementalPrecision = {id = 30674, name = GetSpellInfo(30674), icon = select(3, GetSpellInfo(30674))},
	ElementalReach = {id = 29000, name = GetSpellInfo(29000), icon = select(3, GetSpellInfo(29000))},
	Fulmination = {id = 88766, name = GetSpellInfo(88766), icon = select(3, GetSpellInfo(88766))},
	GraceofAir = {id = 116956, name = GetSpellInfo(116956), icon = select(3, GetSpellInfo(116956))},
	LavaSurge = {id = 77756, name = GetSpellInfo(77756), icon = select(3, GetSpellInfo(77756))},
	MailSpecialization = {id = 86529, name = GetSpellInfo(86529), icon = select(3, GetSpellInfo(86529))},
	MasteryElementalOverload = {id = 77222, name = GetSpellInfo(77222), icon = select(3, GetSpellInfo(77222))},
	Reincarnation = {id = 20608, name = GetSpellInfo(20608), icon = select(3, GetSpellInfo(20608))},
	RollingThunder = {id = 88764, name = GetSpellInfo(88764), icon = select(3, GetSpellInfo(88764))},
	Shamanism = {id = 62099, name = GetSpellInfo(62099), icon = select(3, GetSpellInfo(62099))},
	SpiritualInsight = {id = 123099, name = GetSpellInfo(123099), icon = select(3, GetSpellInfo(123099))},
	ElementalBlast = {id = 117014, name = GetSpellInfo(117014), icon = select(3, GetSpellInfo(117014))},
}

local enables = {}
local values = {}
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
	settingsfile = "ele_mop.xml",
	callback = GUICallback,
	{type = "title", text = "\124T" .. select(2, GetSpellTabInfo(2)) .. ":20:20\124t " .. GetSpellTabInfo(2)},
	{type = "separator"}
}

local incombat = false
local function CombatEventCatcher(event, ...)
	if event == "PLAYER_REGEN_DISABLED" then
		incombat = true
	elseif event == "PLAYER_REGEN_ENABLED" then
		incombat = false
	end
end
local function OnLoad()
	ni.combatlog.registerhandler("elemop", CombatEventCatcher)
	ni.GUI.AddFrame("elemop", items)
end
local function OnUnload()
	ni.combatlog.unregisterhandler("elemop")
	ni.GUI.DestroyFrame("elemop")
end

local enemies = {}

local function ActiveEnemies(range)
	table.wipe(enemies)
	enemies = ni.player.enemiesinrange(range)
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
		ni.debug.log(spell)
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

--GetTotemInfo
local Totem = {
	Fire = 1,
	Earth = 2,
	Water = 3,
	Air = 4
}
local function HasTotem(slot, name)
	local haveTotem, totemName = GetTotemInfo(slot)
	if haveTotem and totemName == name then
		return true
	end
	return false
end
local function TotemTimeRemaining(slot, name)
	local haveTotem, totemName, startTime, duration = GetTotemInfo(slot)
	if not haveTotem or totemName == nil or totemName ~= name then
		return 0
	end
	return startTime + duration - GetTime()
end

local t, p = "target", "player"

local abilities = {
	["Pause"] = function()
		if
			IsMounted() or UnitIsDeadOrGhost(p) or not UnitExists(t) or UnitIsDeadOrGhost(t) or
				(UnitExists(t) and not UnitCanAttack(p, t))
		 then
			return true
		end
	end,
	["FlameShock"] = function()
		if
			ValidUsable(spells.FlameShock.id, t) and ni.unit.debuffremaining(t, spells.FlameShock.id, p) <= 2 and
				FacingLosCast(spells.FlameShock.name, t)
		 then
			return true
		end
	end,
	["LightningShield"] = function()
		if ni.spell.available(spells.LightningShield.id) and not ni.player.buff(spells.LightningShield.id) then
			ni.spell.cast(spells.LightningShield.name)
			return true
		end
	end,
	["FlametongueWeapon"] = function()
		local enchant = GetWeaponEnchantInfo()
		if ni.spell.available(spells.FlameShock.id) and enchant ~= 1 and not ni.player.buff(spells.FlameShock.id) then
			ni.spell.cast(spells.FlametongueWeapon.name)
			return true
		end
	end,
	["EarthShock"] = function()
		local lsStacks = ni.player.buffstacks(spells.LightningShield.id)
		if lsStacks >= 7 and ValidUsable(spells.EarthShock.id, t) and FacingLosCast(spells.EarthShock.name, t) then
			return true
		end
	end,
	["LavaBurst"] = function()
		if
			ValidUsable(spells.LavaBurst.id, t) and (not ni.player.ismoving() or ni.spell.isinstant(spells.LavaBurst.id)) and
				ni.unit.debuff(t, spells.FlameShock.id, p) and
				FacingLosCast(spells.LavaBurst.name, t)
		 then
			return true
		end
	end,
	["Thunderstorm"] = function()
		if ActiveEnemies(6) >= 1 and ni.spell.available(spells.Thunderstorm.id) then
			ni.spell.cast(spells.Thunderstorm.name)
		end
	end,
	["SearingTotem"] = function()
		if TotemTimeRemaining(Totem.Fire, spells.SearingTotem.name) < 5 and ni.spell.available(spells.SearingTotem.id) then
			ni.spell.cast(spells.SearingTotem.name)
		end
	end,
	["ChainLightning"] = function()
		local chain = ni.unit.enemiesinrange(t, 8)
		if
			#chain > 1 and not ni.player.ismoving() and ValidUsable(spells.ChainLightning.id, t) and
				FacingLosCast(spells.ChainLightning.name, t)
		 then
			return true
		end
	end,
	["LightningBolt"] = function()
		if ValidUsable(spells.LightningBolt.id, t) and FacingLosCast(spells.LightningBolt.name, t) then
			return true
		end
	end,
	["UnleashElements"] = function()
		if ValidUsable(spells.UnleashElements.id, t) and FacingLosCast(spells.UnleashElements.name, t) then
			return true
		end
	end,
	["ElementalBlast"] = function()
		if ValidUsable(spells.ElementalBlast.id, t) and FacingLosCast(spells.ElementalBlast.name, t) then
			return true
		end
	end,
}
ni.bootstrap.profile("Ele_MOP", queue, abilities, OnLoad, OnUnload)
