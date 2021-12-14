local queue = {
	"Pause",
	"WaterShield",
	"EarthlivingWeapon",
	"Tank Heal",
	"HealingStreamTotem",
	"Riptide",
	"ChainHeal",
	"HealingSurge",
	"HealingWave",
	"LightningBolt"
}

local IsSpellInRange,
	IsMounted,
	UnitIsDeadOrGhost,
	UnitExists,
	UnitCanAttack,
	IsUsableSpell,
	GetWeaponEnchantInfo,
	GetTotemInfo,
	IsSpellKnown =
	IsSpellInRange,
	IsMounted,
	UnitIsDeadOrGhost,
	UnitExists,
	UnitCanAttack,
	IsUsableSpell,
	GetWeaponEnchantInfo,
	GetTotemInfo,
	IsSpellKnown

local enables = {
	["RiptideTank"] = true,
	["HealingSurgeTank"] = true,
	["LightningBolt"] = false,
	["OnlyCombat"] = false
}
local values = {
	["RiptideTank"] = 92,
	["HealingSurgeTank"] = 85,
	["RiptideHP"] = 92,
	["HealingSurgeHP"] = 70,
	["HealingWaveHP"] = 86,
	["ChainHealHP"] = 75
}
local inputs = {}
local menus = {
	["EarthShieldTar"] = 1
}

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

local spells = {
	--build == 50400
	--General icon = select(2, GetSpellTabInfo(1))
	AutoAttack = {id = 6603, name = GetSpellInfo(6603), icon = select(3, GetSpellInfo(6603))},
	--Restoration icon = select(2, GetSpellTabInfo(2))
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
	EarthShield = {id = 974, name = GetSpellInfo(974), icon = select(3, GetSpellInfo(974))},
	EarthShock = {id = 8042, name = GetSpellInfo(8042), icon = select(3, GetSpellInfo(8042))},
	EarthbindTotem = {id = 2484, name = GetSpellInfo(2484), icon = select(3, GetSpellInfo(2484))},
	EarthgrabTotem = {id = 51485, name = GetSpellInfo(51485), icon = select(3, GetSpellInfo(51485))},
	TremorTotem = {id = 8143, name = GetSpellInfo(8143), icon = select(3, GetSpellInfo(8143))},
	EarthElementalTotem = {id = 2062, name = GetSpellInfo(2062), icon = select(3, GetSpellInfo(2062))},
	StoneBulwarkTotem = {id = 108270, name = GetSpellInfo(108270), icon = select(3, GetSpellInfo(108270))},
	FarSight = {id = 6196, name = GetSpellInfo(6196), icon = select(3, GetSpellInfo(6196))},
	FireElementalTotem = {id = 2894, name = GetSpellInfo(2894), icon = select(3, GetSpellInfo(2894))},
	MagmaTotem = {id = 8190, name = GetSpellInfo(8190), icon = select(3, GetSpellInfo(8190))},
	SearingTotem = {id = 3599, name = GetSpellInfo(3599), icon = select(3, GetSpellInfo(3599))},
	FlameShock = {id = 8050, name = GetSpellInfo(8050), icon = select(3, GetSpellInfo(8050))},
	FrostShock = {id = 8056, name = GetSpellInfo(8056), icon = select(3, GetSpellInfo(8056))},
	GhostWolf = {id = 2645, name = GetSpellInfo(2645), icon = select(3, GetSpellInfo(2645))},
	GreaterHealingWave = {id = 77472, name = GetSpellInfo(77472), icon = select(3, GetSpellInfo(77472))},
	HealingRain = {id = 73920, name = GetSpellInfo(73920), icon = select(3, GetSpellInfo(73920))},
	HealingSurge = {id = 8004, name = GetSpellInfo(8004), icon = select(3, GetSpellInfo(8004))},
	HealingWave = {id = 331, name = GetSpellInfo(331), icon = select(3, GetSpellInfo(331))},
	Hex = {id = 51514, name = GetSpellInfo(51514), icon = select(3, GetSpellInfo(51514))},
	LavaBurst = {id = 51505, name = GetSpellInfo(51505), icon = select(3, GetSpellInfo(51505))},
	LightningBolt = {id = 403, name = GetSpellInfo(403), icon = select(3, GetSpellInfo(403))},
	LightningShield = {id = 324, name = GetSpellInfo(324), icon = select(3, GetSpellInfo(324))},
	PrimalStrike = {id = 73899, name = GetSpellInfo(73899), icon = select(3, GetSpellInfo(73899))},
	Purge = {id = 370, name = GetSpellInfo(370), icon = select(3, GetSpellInfo(370))},
	CleanseSpirit = {id = 51886, name = GetSpellInfo(51886), icon = select(3, GetSpellInfo(51886))},
	Riptide = {id = 61295, name = GetSpellInfo(61295), icon = select(3, GetSpellInfo(61295))},
	SpiritwalkersGrace = {id = 79206, name = GetSpellInfo(79206), icon = select(3, GetSpellInfo(79206))},
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
	AncestralAwakening = {id = 51558, name = GetSpellInfo(51558), icon = select(3, GetSpellInfo(51558))},
	AncestralFocus = {id = 89920, name = GetSpellInfo(89920), icon = select(3, GetSpellInfo(89920))},
	BurningWrath = {id = 77747, name = GetSpellInfo(77747), icon = select(3, GetSpellInfo(77747))},
	GraceofAir = {id = 116956, name = GetSpellInfo(116956), icon = select(3, GetSpellInfo(116956))},
	MailSpecialization = {id = 86529, name = GetSpellInfo(86529), icon = select(3, GetSpellInfo(86529))},
	MasteryDeepHealing = {id = 77226, name = GetSpellInfo(77226), icon = select(3, GetSpellInfo(77226))},
	Meditation = {id = 95862, name = GetSpellInfo(95862), icon = select(3, GetSpellInfo(95862))},
	Purification = {id = 16213, name = GetSpellInfo(16213), icon = select(3, GetSpellInfo(16213))},
	Reincarnation = {id = 20608, name = GetSpellInfo(20608), icon = select(3, GetSpellInfo(20608))},
	Resurgence = {id = 16196, name = GetSpellInfo(16196), icon = select(3, GetSpellInfo(16196))},
	SpiritualInsight = {id = 112858, name = GetSpellInfo(112858), icon = select(3, GetSpellInfo(112858))},
	TidalWaves = {id = 51564, name = GetSpellInfo(51564), icon = select(3, GetSpellInfo(51564))},
}

local items = {
	settingsfile = "RestroMOP.xml",
	callback = GUICallback,
	{type = "title", text = "\124T" .. select(2, GetSpellTabInfo(2)) .. ":20:20\124t " .. GetSpellTabInfo(2)},
	{type = "separator"},
	{
		type = "entry",
		text = "Combat Only",
		enabled = enables["OnlyCombat"],
		key = "OnlyCombat"
	},
	{type = "separator"},
	{type = "title", text = "\124T" .. spells.EarthShield.icon .. ":15:15\124t Earth Shield Target"},
	{
		type = "dropdown",
		menu = {
			{selected = (menus["EarthShieldTar"] == 1), value = 1, text = "|cffFFFF33Main Tank"},
			{selected = (menus["EarthShieldTar"] == 2), value = 2, text = "|cffFF9900Off Tank"},
			{selected = (menus["EarthShieldTar"] == 2), value = 3, text = "|cff24E0FBFocus"}
		},
		key = "EarthShieldTar"
	},
	{type = "separator"},
	{type = "title", text = "Tank Heal"},
	{
		type = "entry",
		text = "\124T" .. spells.Riptide.icon .. ":15:15\124t Riptide Tank HP",
		value = values["RiptideTank"],
		enabled = enables["RiptideTank"],
		key = "RiptideTank"
	},
	{
		type = "entry",
		text = "\124T" .. spells.HealingSurge.icon .. ":15:15\124t Healing Surge Tank HP",
		value = values["HealingSurgeTank"],
		enabled = enables["HealingSurgeTank"],
		key = "HealingSurgeTank"
	},
	{type = "separator"},
	{type = "title", text = "Heals"},
	{
		type = "entry",
		text = "\124T" .. spells.Riptide.icon .. ":15:15\124t Riptide HP",
		value = values["RiptideHP"],
		key = "RiptideHP"
	},
	{
		type = "entry",
		text = "\124T" .. spells.HealingSurge.icon .. ":15:15\124t Healing Surge HP",
		value = values["HealingSurgeHP"],
		key = "HealingSurgeHP"
	},
	{
		type = "entry",
		text = "\124T" .. spells.HealingWave.icon .. ":15:15\124t Healing Wave HP",
		value = values["HealingWaveHP"],
		key = "HealingWaveHP"
	},
	{
		type = "entry",
		text = "\124T" .. spells.ChainHeal.icon .. ":15:15\124t Chain Heal HP",
		value = values["ChainHealHP"],
		key = "ChainHealHP"
	},
	{type = "separator"},
	{type = "title", text = "Dps"},
	{
		type = "entry",
		text = "\124T" .. spells.LightningBolt.icon .. ":15:15\124t Use Lightning Bolt",
		enabled = enables["LightningBolt"],
		key = "LightningBolt"
	}
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
	ni.combatlog.registerhandler("RestroMOP", CombatEventCatcher)
	ni.GUI.AddFrame("RestroMOP", items)
end
local function OnUnload()
	ni.combatlog.unregisterhandler("RestroMOP")
	ni.GUI.DestroyFrame("RestroMOP")
end

local temptable = {}
local customtable = {}
local function SortByUnits(x, y)
	return x.unitsclose > y.unitsclose
end
local function SortByHP(x, y)
	return x.hp < y.hp
end
local function GetTableForBestUnit(health, distance, unitsclose, buff)
	table.wipe(customtable)
	for i = 1, #ni.members do
		if
			ni.members[i].hp <= health and ni.members[i].range and
				(buff ~= nil and not ni.unit.buff(ni.members[i].unit, buff, p))
		 then
			table.wipe(temptable)
			if buff ~= nil then
				temptable = ni.members.inrangewithoutbuff(ni.members[i].unit, distance, buff, p)
				for k, v in ipairs(temptable) do
					if v and v.hp > health then
						tremove(temptable, k)
					end
				end
			else
				temptable = ni.members.inrangebelow(ni.members[i].unit, distance, health)
			end
			if #temptable >= unitsclose then
				tinsert(customtable, {unit = ni.members[i].unit, hp = ni.members[i].hp, unitsclose = #temptable})
			end
		end
	end
	if #customtable > 0 then
		table.sort(customtable, SortByHP)
	end
end

local lastSpell, lastUnit

local function LosCast(spell, tar)
	if ni.player.los(tar) and IsSpellInRange(spell, tar) == 1 then
		ni.spell.cast(spell, tar)
		lastSpell = spell
		lastUnit = tar
		ni.debug.log(string.format("Casting %s on %s", spell, tar))
		return true
	end
	return false
end

local function ValidUsable(id, tar)
	if IsSpellKnown(id) and ni.spell.available(id) and ni.spell.valid(tar, id, false, true, true) then
		return true
	end
	return false
end

local t, p, f = "target", "player", "focus"

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
local function TotemDistance(name, target)
	local c = ni.unit.creations(p)
	local guid
	for i = 1, #c do
		local cr = c[i]
		ni.vars.debug = true
		ni.debug.log(cr.name .. cr.guid)
		ni.vars.debug = false
		if string.match(cr.name, name) then
			guid = cr.guid
		end
	end
	if guid ~= nil and ni.player.distance(guid) then
		return ni.unit.distance(target, guid)
	end
	return -1
end

local abilities = {
	["Pause"] = function()
		if IsMounted() or UnitIsDeadOrGhost(p) or (enables["OnlyCombat"] and not incombat) then
			return true
		end
	end,
	["WaterShield"] = function()
		if ni.spell.available(spells.WaterShield.id) and not ni.player.buff(spells.WaterShield.id) then
			ni.spell.cast(spells.WaterShield.name)
			return true
		end
	end,
	["EarthlivingWeapon"] = function()
		local enchant = GetWeaponEnchantInfo()
		if
			ni.spell.available(spells.EarthlivingWeapon.id) and enchant ~= 1 and not ni.player.buff(spells.EarthlivingWeapon.id)
		 then
			ni.spell.cast(spells.EarthlivingWeapon.name)
			return true
		end
	end,
	["Tank Heal"] = function()
		local mainTank, offTank = ni.tanks()
		local esTar = menus["EarthShieldTar"]
		--Earthsheild focus
		if esTar == 3 and ni.unit.exists(f) then
			local es, _, _, esCount, _, _, esTime = ni.unit.buff(f, spells.EarthShield.id, p)
			if
				(not es or esTime - GetTime() < 2) and ValidUsable(spells.EarthShield.id, f) and LosCast(spells.EarthShield.name, f)
			 then
				return true
			end
		end
		if mainTank ~= nil and ni.unit.exists(mainTank) then
			--EarthShield mainTank
			local esM, _, _, esMCount, _, _, esMTime = ni.unit.buff(mainTank, spells.EarthShield.id, p)
			if
				(not esM or esMCount < 2 or esMTime - GetTime() < 2) and esTar == 1 and ValidUsable(spells.EarthShield.id, mainTank) and
					LosCast(spells.EarthShield.name, mainTank)
			 then
				return true
			end
			--Riptide mainTank
			if
				enables["RiptideTank"] and not ni.unit.buff(mainTank, spells.Riptide.id, p) and
					ni.unit.hp(mainTank) <= values["RiptideTank"] and
					ValidUsable(spells.Riptide.id, mainTank) and
					LosCast(spells.Riptide.name, mainTank)
			 then
				return true
			end
			--HealingSurge mainTank
			if
				enables["HealingSurgeTank"] and not ni.player.ismoving() and ni.unit.hp(mainTank) <= values["HealingSurgeTank"] and
					ValidUsable(spells.HealingSurge.id, mainTank) and
					LosCast(spells.HealingSurge.name, mainTank)
			 then
				return true
			end
			--offTank
			if offTank ~= nil and ni.unit.exists(offTank) then
				--EarthShield offTank
				local esO, _, _, esOCount, _, _, esOTime = ni.unit.buff(mainTank, spells.EarthShield.id, p)
				if
					(not esO or esOCount < 2 or esOTime - GetTime() < 2) and esTar == 2 and ValidUsable(spells.EarthShield.id, offTank) and
						LosCast(spells.EarthShield.name, offTank)
				 then
					return true
				end
				--Riptide offTank
				if
					enables["RiptideTank"] and ni.unit.hp(offTank) <= values["RiptideTank"] and
						not ni.unit.buff(offTank, spells.Riptide.id, p) and
						ValidUsable(spells.Riptide.id, offTank) and
						LosCast(spells.Riptide.name, offTank)
				 then
					return true
				end
				--HealingSurge offTank
				if
					enables["HealingSurgeTank"] and not ni.player.ismoving() and ni.unit.hp(offTank) <= values["HealingSurgeTank"] and
						ValidUsable(spells.HealingSurge.id, mainTank) and
						LosCast(spells.HealingSurge.name, mainTank)
				 then
					return true
				end
			end
		end
	end,
	["Riptide"] = function()
		for i = 1, #ni.members do
			if
				ni.members[i].hp <= values["RiptideHP"] and not ni.unit.buff(ni.members[i].unit, spells.Riptide.id, p) and
					ValidUsable(spells.Riptide.id, ni.members[i].unit) and
					LosCast(spells.Riptide.name, ni.members[i].unit)
			 then
				return true
			end
		end
	end,
	["HealingStreamTotem"] = function()
		if
			not HasTotem(Totem.Water) and ni.spell.available(spells.HealingStreamTotem.id) and
				#ni.members.inrangebelow(p, 40, 95) >= 1
		 then
			ni.spell.cast(spells.HealingStreamTotem.name)
		end
	end,
	["HealingSurge"] = function()
		if not ni.player.ismoving() then
			for i = 1, #ni.members do
				if
					ni.members[i].hp <= values["HealingSurgeHP"] and ValidUsable(spells.HealingSurge.id, ni.members[i].unit) and
						LosCast(spells.HealingSurge.name, ni.members[i].unit)
				 then
					return true
				end
			end
		end
	end,
	["HealingWave"] = function()
		if not ni.player.ismoving() then
			for i = 1, #ni.members do
				if
					ni.members[i].hp <= values["HealingWaveHP"] and ValidUsable(spells.HealingWave.id, ni.members[i].unit) and
						LosCast(spells.HealingWave.name, ni.members[i].unit)
				 then
					return true
				end
			end
		end
	end,
	["ChainHeal"] = function()
		if ni.spell.available(spells.ChainHeal) then
			GetTableForBestUnit(values["ChainHealHP"], 10, 3)
			if #customtable > 0 then
				if customtable[1].unitsclose >= 3 and ValidUsable(spells.ChainHeal.id, customtable[1].unit) then
					if customtable[1].hp <= values["ChainHealHP"] then
						LosCast(spells.ChainHeal.name, customtable[1].unit)
						return true
					end
				end
			end
		end
	end,
	["LightningBolt"] = function()
		if
			enables["LightningBolt"] and UnitExists(t) and UnitCanAttack(p, t) and not UnitIsDeadOrGhost(t) and
				UnitAffectingCombat(p, t) and ni.spell.available(spells.LightningBolt.id)
		 then
			ni.spell.cast(spells.LightningBolt.name, t)
			return true
		end
	end
}
ni.bootstrap.profile("Restro_MOP", queue, abilities, OnLoad, OnUnload)
