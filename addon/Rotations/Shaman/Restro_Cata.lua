local queue = {
	"Pause",
	"Cache",
	"WaterShield",
	"EarthlivingWeapon",
	"Tank Heal",
	"CleanseSpirit",
	"CalloftheTotems",
	"Riptide",
	"ChainHeal",
	"HealingSurge",
	"GreaterHealingWave",
	"HealingWave",
	"PauseCombat",
	"FlametongueWeapon",
	"LavaBurst",
	"FlameShock",
	"EarthShock",
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
	IsSpellKnown,
	UnitGUID,
	GetSpellInfo,
	UnitDebuff,
	GetTalentInfo =
	IsSpellInRange,
	IsMounted,
	UnitIsDeadOrGhost,
	UnitExists,
	UnitCanAttack,
	IsUsableSpell,
	GetWeaponEnchantInfo,
	GetTotemInfo,
	IsSpellKnown,
	UnitGUID,
	GetSpellInfo,
	UnitDebuff,
	GetTalentInfo

local spells = {
	--build == 40300
	--General icon = select(2, GetSpellTabInfo(1))
	AutoAttack = {id = 6603, name = GetSpellInfo(6603), icon = select(3, GetSpellInfo(6603))},
	--Elemental Combat icon = select(2, GetSpellTabInfo(2))
	EarthShock = {id = 8042, name = GetSpellInfo(8042), icon = select(3, GetSpellInfo(8042))},
	LightningBolt = {id = 403, name = GetSpellInfo(403), icon = select(3, GetSpellInfo(403))},
	SearingTotem = {id = 3599, name = GetSpellInfo(3599), icon = select(3, GetSpellInfo(3599))},
	Purge = {id = 370, name = GetSpellInfo(370), icon = select(3, GetSpellInfo(370))},
	FlameShock = {id = 8050, name = GetSpellInfo(8050), icon = select(3, GetSpellInfo(8050))},
	WindShear = {id = 57994, name = GetSpellInfo(57994), icon = select(3, GetSpellInfo(57994))},
	EarthbindTotem = {id = 2484, name = GetSpellInfo(2484), icon = select(3, GetSpellInfo(2484))},
	FrostShock = {id = 8056, name = GetSpellInfo(8056), icon = select(3, GetSpellInfo(8056))},
	ChainLightning = {id = 421, name = GetSpellInfo(421), icon = select(3, GetSpellInfo(421))},
	FireNova = {id = 1535, name = GetSpellInfo(1535), icon = select(3, GetSpellInfo(1535))},
	CalloftheElements = {id = 66842, name = GetSpellInfo(66842), icon = select(3, GetSpellInfo(66842))},
	LavaBurst = {id = 51505, name = GetSpellInfo(51505), icon = select(3, GetSpellInfo(51505))},
	MagmaTotem = {id = 8190, name = GetSpellInfo(8190), icon = select(3, GetSpellInfo(8190))},
	CalloftheAncestors = {id = 66843, name = GetSpellInfo(66843), icon = select(3, GetSpellInfo(66843))},
	CalloftheSpirits = {id = 66844, name = GetSpellInfo(66844), icon = select(3, GetSpellInfo(66844))},
	StoneclawTotem = {id = 5730, name = GetSpellInfo(5730), icon = select(3, GetSpellInfo(5730))},
	BindElemental = {id = 76780, name = GetSpellInfo(76780), icon = select(3, GetSpellInfo(76780))},
	FireElementalTotem = {id = 2894, name = GetSpellInfo(2894), icon = select(3, GetSpellInfo(2894))},
	Hex = {id = 51514, name = GetSpellInfo(51514), icon = select(3, GetSpellInfo(51514))},
	SpiritwalkersGrace = {id = 79206, name = GetSpellInfo(79206), icon = select(3, GetSpellInfo(79206))},
	--Enhancement icon = select(2, GetSpellTabInfo(3))
	LightningShield = {id = 324, name = GetSpellInfo(324), icon = select(3, GetSpellInfo(324))},
	PrimalStrike = {id = 73899, name = GetSpellInfo(73899), icon = select(3, GetSpellInfo(73899))},
	StrengthofEarthTotem = {id = 8075, name = GetSpellInfo(8075), icon = select(3, GetSpellInfo(8075))},
	FlametongueWeapon = {id = 8024, name = GetSpellInfo(8024), icon = select(3, GetSpellInfo(8024))},
	FlametongueTotem = {id = 8227, name = GetSpellInfo(8227), icon = select(3, GetSpellInfo(8227))},
	GhostWolf = {id = 2645, name = GetSpellInfo(2645), icon = select(3, GetSpellInfo(2645))},
	WaterWalking = {id = 546, name = GetSpellInfo(546), icon = select(3, GetSpellInfo(546))},
	FrostbrandWeapon = {id = 8033, name = GetSpellInfo(8033), icon = select(3, GetSpellInfo(8033))},
	AstralRecall = {id = 556, name = GetSpellInfo(556), icon = select(3, GetSpellInfo(556))},
	WindfuryTotem = {id = 8512, name = GetSpellInfo(8512), icon = select(3, GetSpellInfo(8512))},
	WindfuryWeapon = {id = 8232, name = GetSpellInfo(8232), icon = select(3, GetSpellInfo(8232))},
	FarSight = {id = 6196, name = GetSpellInfo(6196), icon = select(3, GetSpellInfo(6196))},
	GroundingTotem = {id = 8177, name = GetSpellInfo(8177), icon = select(3, GetSpellInfo(8177))},
	WrathofAirTotem = {id = 3738, name = GetSpellInfo(3738), icon = select(3, GetSpellInfo(3738))},
	WaterBreathing = {id = 131, name = GetSpellInfo(131), icon = select(3, GetSpellInfo(131))},
	StoneskinTotem = {id = 8071, name = GetSpellInfo(8071), icon = select(3, GetSpellInfo(8071))},
	EarthElementalTotem = {id = 2062, name = GetSpellInfo(2062), icon = select(3, GetSpellInfo(2062))},
	ElementalResistanceTotem = {id = 8184, name = GetSpellInfo(8184), icon = select(3, GetSpellInfo(8184))},
	Bloodlust = {id = 2825, name = GetSpellInfo(2825), icon = select(3, GetSpellInfo(2825))},
	RockbiterWeapon = {id = 8017, name = GetSpellInfo(8017), icon = select(3, GetSpellInfo(8017))},
	UnleashElements = {id = 73680, name = GetSpellInfo(73680), icon = select(3, GetSpellInfo(73680))},
	--Restoration icon = select(2, GetSpellTabInfo(4))
	EarthShield = {id = 974, name = GetSpellInfo(974), icon = select(3, GetSpellInfo(974))},
	HealingWave = {id = 331, name = GetSpellInfo(331), icon = select(3, GetSpellInfo(331))},
	Meditation = {id = 95862, name = GetSpellInfo(95862), icon = select(3, GetSpellInfo(95862))},
	Purification = {id = 16213, name = GetSpellInfo(16213), icon = select(3, GetSpellInfo(16213))},
	AncestralSpirit = {id = 2008, name = GetSpellInfo(2008), icon = select(3, GetSpellInfo(2008))},
	CleanseSpirit = {id = 51886, name = GetSpellInfo(51886), icon = select(3, GetSpellInfo(51886))},
	HealingStreamTotem = {id = 5394, name = GetSpellInfo(5394), icon = select(3, GetSpellInfo(5394))},
	HealingSurge = {id = 8004, name = GetSpellInfo(8004), icon = select(3, GetSpellInfo(8004))},
	WaterShield = {id = 52127, name = GetSpellInfo(52127), icon = select(3, GetSpellInfo(52127))},
	Reincarnation = {id = 20608, name = GetSpellInfo(20608), icon = select(3, GetSpellInfo(20608))},
	TotemicRecall = {id = 36936, name = GetSpellInfo(36936), icon = select(3, GetSpellInfo(36936))},
	ChainHeal = {id = 1064, name = GetSpellInfo(1064), icon = select(3, GetSpellInfo(1064))},
	ManaSpringTotem = {id = 5675, name = GetSpellInfo(5675), icon = select(3, GetSpellInfo(5675))},
	TremorTotem = {id = 8143, name = GetSpellInfo(8143), icon = select(3, GetSpellInfo(8143))},
	EarthlivingWeapon = {id = 51730, name = GetSpellInfo(51730), icon = select(3, GetSpellInfo(51730))},
	GreaterHealingWave = {id = 77472, name = GetSpellInfo(77472), icon = select(3, GetSpellInfo(77472))},
	TotemofTranquilMind = {id = 87718, name = GetSpellInfo(87718), icon = select(3, GetSpellInfo(87718))},
	HealingRain = {id = 73920, name = GetSpellInfo(73920), icon = select(3, GetSpellInfo(73920))},
	Riptide = {id = 61295, name = GetSpellInfo(61295), icon = select(3, GetSpellInfo(61295))}
}

local enables = {
	["RiptideTank"] = true,
	["HealingSurgeTank"] = true,
	["LightningBolt"] = false,
	["OnlyCombat"] = false,
	["ChainHealHP"] = true,
	["LavaBurst"] = false,
	["FlameShock"] = false,
	["EarthShock"] = false,
	["SearingTotem"] = false,
	["MultiTotem"] = true,
	["CleanseSpirit"] = false,
	["TotemicRecall"] = true,
	["HealingSurge"] = true,
	["HealingWave"] = true,
	["GreaterHealingWave"] = true
}
local values = {
	["RiptideTank"] = 92,
	["HealingSurgeTank"] = 85,
	["RiptideHP"] = 92,
	["HealingSurgeHP"] = 70,
	["HealingWaveHP"] = 86,
	["ChainHealHP"] = 75,
	["GreaterHealingWave"] = 60,
	["TotemicRecall"] = 30
}
local inputs = {}
local menus = {
	["EarthShieldTar"] = 1,
	["Callofthe"] = 1
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

local Callofthe = {
	Elements = 1,
	Ancestors = 2,
	Spirits = 3
}

local items = {
	settingsfile = "RestroCata.xml",
	callback = GUICallback,
	{type = "title", text = "\124T" .. select(2, GetSpellTabInfo(4)) .. ":15:15\124t " .. GetSpellTabInfo(4)},
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
		text = "Healing Surge Tank HP",
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
		enabled = enables["HealingSurge"],
		key = "HealingSurgeHP"
	},
	{
		type = "entry",
		text = "\124T" .. spells.HealingWave.icon .. ":15:15\124t Healing Wave HP",
		value = values["HealingWaveHP"],
		enabled = enables["HealingWave"],
		key = "HealingWaveHP"
	},
	{
		type = "entry",
		text = "\124T" .. spells.GreaterHealingWave.icon .. ":15:15\124t Greater Healin gWave HP",
		value = values["GreaterHealingWave"],
		enabled = enables["GreaterHealingWave"],
		key = "GreaterHealingWave"
	},
	{
		type = "entry",
		text = "\124T" .. spells.ChainHeal.icon .. ":15:15\124t Chain Heal HP",
		value = values["ChainHealHP"],
		enabled = enables["ChainHealHP"],
		key = "ChainHealHP"
	},
	{
		type = "entry",
		text = "\124T" .. spells.CleanseSpirit.icon .. ":15:15\124t Cleanse Spirit",
		enabled = enables["CleanseSpirit"],
		key = "CleanseSpirit"
	},
	{type = "separator"},
	{type = "title", text = "Totems"},
	{
		type = "entry",
		text = "Use Call of the Totems",
		enabled = enables["MultiTotem"],
		key = "MultiTotem"
	},
	{type = "title", text = "Call Totem Set"},
	{
		type = "dropdown",
		menu = {
			{
				selected = (menus["Callofthe"] == Callofthe.Elements),
				value = Callofthe.Elements,
				text = "\124T" .. spells.CalloftheElements.icon .. ":15:15\124t " .. spells.CalloftheElements.name
			},
			{
				selected = (menus["Callofthe"] == Callofthe.Ancestors),
				value = Callofthe.Ancestors,
				text = "\124T" .. spells.CalloftheAncestors.icon .. ":15:15\124t " .. spells.CalloftheAncestors.name
			},
			{
				selected = (menus["Callofthe"] == Callofthe.Spirits),
				value = Callofthe.Ancestors,
				text = "\124T" .. spells.CalloftheSpirits.icon .. ":15:15\124t " .. spells.CalloftheSpirits.name
			}
		},
		key = "Callofthe"
	},
	{
		type = "entry",
		text = "\124T" .. spells.TotemicRecall.icon .. ":15:15\124t " .. spells.TotemicRecall.name,
		enabled = enables["TotemicRecall"],
		value = values["TotemicRecall"],
		key = "TotemicRecall"
	},
	{type = "separator"},
	{type = "title", text = "Dps"},
	{
		type = "entry",
		text = "\124T" .. spells.LightningBolt.icon .. ":15:15\124t Use Lightning Bolt",
		enabled = enables["LightningBolt"],
		key = "LightningBolt"
	},
	{
		type = "entry",
		text = "\124T" .. spells.LavaBurst.icon .. ":15:15\124t Use Lava Burst",
		enabled = enables["LavaBurst"],
		key = "LavaBurst"
	},
	{
		type = "entry",
		text = "\124T" .. spells.FlameShock.icon .. ":15:15\124t Use Flame Shock",
		enabled = enables["FlameShock"],
		key = "FlameShock"
	},
	{
		type = "entry",
		text = "\124T" .. spells.EarthShock.icon .. ":15:15\124t Use Earth Shock",
		enabled = enables["EarthShock"],
		key = "EarthShock"
	}
}
local t, p, f = "target", "player", "focus"
local incombat = false
local function CombatEventCatcher(event, ...)
	if event == "PLAYER_REGEN_DISABLED" then
		incombat = true
	elseif event == "PLAYER_REGEN_ENABLED" then
		incombat = false
	end
end
local function OnLoad()
	ni.combatlog.registerhandler("RestroCata", CombatEventCatcher)
	ni.GUI.AddFrame("RestroCata", items)
end
local function OnUnload()
	ni.combatlog.unregisterhandler("RestroCata")
	ni.GUI.DestroyFrame("RestroCata")
end

local temptable = {}
local customtable = {}
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

local lastSpell, lastUnit, lastTime

local function LosCast(spell, tar)
	if ni.player.los(tar) and IsSpellInRange(spell, tar) == 1 then
		ni.spell.cast(spell, tar)
		lastSpell = spell
		lastUnit = UnitGUID(tar)
		lastTime = GetTime()
		ni.debug.log(string.format("Casting %s on %s", spell, tar))
		return true
	end
	return false
end

local function FacingLosCast(spell, tar)
	if ni.player.isfacing(tar, 145) and ni.player.los(tar) and IsSpellInRange(spell, tar) == 1 then
		ni.spell.cast(spell, tar)
		lastSpell = spell
		lastUnit = UnitGUID(tar)
		lastTime = GetTime()
		return true
	end
	return false
end

local function DobuleCast(spell, tar)
	if lastSpell == spell and UnitGUID(tar) == lastUnit and (GetTime() - lastTime) < 3 then
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
local function ValidUsableEnemy(id, tar)
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
local function HasTotem(slot)
	local _, _, startTime = GetTotemInfo(slot)
	if startTime ~= 0 then
		return true
	end
	return false
end
local function HasTotemName(slot, name)
	local _, totemName, startTime = GetTotemInfo(slot)
	if totemName ~= nil and totemName == name then
		return true
	end
	return false
end
local function TotemDistance(name, target)
	local c = ni.unit.creations(p)
	local guid
	for i = 1, #c do
		local cr = c[i]
		if string.match(cr.name, name) then
			guid = cr.guid
		end
	end
	if guid ~= nil and ni.player.distance(guid) then
		return ni.unit.distance(target, guid)
	end
	return -1
end
local function AnyTotemDistance(target)
	local c = ni.unit.creations(p)
	local guid
	for i = 1, #c do
		local cr = c[i]
		if string.match(cr.name, "Totem") then
			guid = cr.guid
		end
	end
	if guid ~= nil and ni.player.distance(guid) then
		return ni.unit.distance(target, guid)
	end
	return -1
end

local Cache = {
	moving = ni.player.ismoving(),
	members = ni.members
}

local abilities = {
	["Pause"] = function()
		if IsMounted() or UnitIsDeadOrGhost(p) then
			return true
		end
	end,
	["Cache"] = function()
		Cache.moving = ni.player.ismoving()
		Cache.members = ni.members
		if #Cache.members > 0 then
			table.sort(Cache.members, SortByHP)
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
	["FlametongueWeapon"] = function()
		local enchant = GetWeaponEnchantInfo()
		if
			ni.spell.available(spells.FlametongueWeapon.id) and not ni.spell.available(spells.EarthlivingWeapon.id) and
				enchant ~= 1 and
				not ni.player.buff(spells.FlametongueWeapon.id)
		 then
			ni.spell.cast(spells.FlametongueWeapon.name)
			return true
		end
	end,
	["Tank Heal"] = function()
		local mainTank, offTank = ni.tanks()
		--Earthsheild focus
		if (menus["EarthShieldTar"] == 3) and ni.unit.exists(f) then
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
				(not esM or esMCount < 2 or esMTime - GetTime() < 2) and (menus["EarthShieldTar"] == 1) and
					ValidUsable(spells.EarthShield.id, mainTank) and
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
				enables["HealingSurgeTank"] and not Cache.moving and ni.unit.hp(mainTank) <= values["HealingSurgeTank"] and
					ValidUsable(spells.HealingSurge.id, mainTank) and
					LosCast(spells.HealingSurge.name, mainTank)
			 then
				return true
			end
			--offTank
			if offTank ~= nil and ni.unit.exists(offTank) then
				--EarthShield offTank
				local esO, _, _, esOCount, _, _, esOTime = ni.unit.buff(offTank, spells.EarthShield.id, p)
				if
					(menus["EarthShieldTar"] == 2) and not Cache.moving and (not esO or esOCount < 2 or esOTime - GetTime() < 2) and
						ValidUsable(spells.EarthShield.id, offTank) and
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
					enables["HealingSurgeTank"] and not Cache.moving and ni.unit.hp(offTank) <= values["HealingSurgeTank"] and
						ValidUsable(spells.HealingSurge.id, offTank) and
						LosCast(spells.HealingSurge.name, offTank)
				 then
					return true
				end
			end
		end
	end,
	["Riptide"] = function()
		if ni.spell.available(spells.Riptide.id) then
			for i = 1, #Cache.members do
				if
					Cache.members[i].hp <= values["RiptideHP"] and not ni.unit.buff(Cache.members[i].unit, spells.Riptide.id, p) and
						ValidUsable(spells.Riptide.id, Cache.members[i].unit) and
						LosCast(spells.Riptide.name, Cache.members[i].unit)
				 then
					return true
				end
			end
		end
	end,
	["HealingSurge"] = function()
		if enables["HealingSurge"] and not Cache.moving and ni.spell.available(spells.HealingSurge.id) then
			for i = 1, #Cache.members do
				if
					Cache.members[i].hp <= values["HealingSurgeHP"] and ValidUsable(spells.HealingSurge.id, Cache.members[i].unit) and
						LosCast(spells.HealingSurge.name, Cache.members[i].unit)
				 then
					return true
				end
			end
		end
	end,
	["HealingWave"] = function()
		if enables["HealingWave"] and not Cache.moving and ni.spell.available(spells.HealingWave.id) then
			for i = 1, #Cache.members do
				if
					Cache.members[i].hp <= values["HealingWaveHP"] and ValidUsable(spells.HealingWave.id, Cache.members[i].unit) and
						LosCast(spells.HealingWave.name, Cache.members[i].unit)
				 then
					return true
				end
			end
		end
	end,
	["GreaterHealingWave"] = function()
		if enables["GreaterHealingWave"] and not Cache.moving and ni.spell.available(spells.GreaterHealingWave.id) then
			for i = 1, #Cache.members do
				if
					ValidUsable(spells.GreaterHealingWave.id, Cache.members[i].unit) and
						LosCast(spells.GreaterHealingWave.name, Cache.members[i].unit)
				 then
					return true
				end
			end
		end
	end,
	["ChainHeal"] = function()
		if ni.spell.available(spells.ChainHeal.id) and not Cache.moving then
			GetTableForBestUnit(values["ChainHealHP"], 12, 2)
			if #customtable > 0 then
				if customtable[1].unitsclose >= 2 and ValidUsable(spells.ChainHeal.id, customtable[1].unit) then
					LosCast(spells.ChainHeal.name, customtable[1].unit)
					return true
				end
			end
		end
	end,
	["PauseCombat"] = function()
		if
			IsMounted() or UnitIsDeadOrGhost(p) or not UnitExists(t) or UnitIsDeadOrGhost(t) or
				(UnitExists(t) and not UnitCanAttack(p, t))
		 then
			return true
		end
	end,
	["LightningBolt"] = function()
		if
			enables["LightningBolt"] and not Cache.moving and ValidUsableEnemy(spells.LightningBolt.id, t) and
				FacingLosCast(spells.LightningBolt.name, t)
		 then
			return true
		end
	end,
	["EarthShock"] = function()
		if enables["EarthShock"] and ValidUsableEnemy(spells.EarthShock.id, t) and FacingLosCast(spells.EarthShock.name, t) then
			return true
		end
	end,
	["LavaBurst"] = function()
		if
			enables["LavaBurst"] and not Cache.moving and ValidUsableEnemy(spells.LavaBurst.id, t) and
				ni.unit.debuffremaining(t, spells.FlameShock.id, p) > 2 and
				FacingLosCast(spells.LavaBurst.name, t)
		 then
			return true
		end
	end,
	["FlameShock"] = function()
		if
			enables["FlameShock"] and ValidUsableEnemy(spells.FlameShock.id, t) and
				ni.unit.debuffremaining(t, spells.FlameShock.id, p) < 2 and
				FacingLosCast(spells.FlameShock.name, t)
		 then
			return true
		end
	end,
	["CalloftheTotems"] = function()
		if enables["TotemicRecall"] then
			if (AnyTotemDistance(p) > values["TotemicRecall"]) and ni.spell.available(spells.TotemicRecall.id) then
				ni.spell.cast(spells.TotemicRecall.name)
				return true
			end
		end
		if enables["MultiTotem"] then
			if not HasTotem(Totem.Water) and incombat then
				if menus.Callofthe == Callofthe.Elements and ni.spell.available(spells.CalloftheElements.id) then
					ni.spell.cast(spells.CalloftheElements.name)
					return true
				end
				if menus.Callofthe == Callofthe.Ancestors and ni.spell.available(spells.CalloftheAncestors.id) then
					ni.spell.cast(spells.CalloftheAncestors.name)
					return true
				end
				if menus.Callofthe == Callofthe.Spirits and ni.spell.available(spells.CalloftheSpirits.id) then
					ni.spell.cast(spells.CalloftheSpirits.name)
					return true
				end
			end
		end
	end,
	["CleanseSpirit"] = function()
		if enables["CleanseSpirit"] and ni.spell.available(spells.CleanseSpirit.id) then
			local ImprovedCleanseSpirit = (select(5, GetTalentInfo(3, 12)) == 1)
			for c = 1, #Cache.members do
				local tar = Cache.members[c].unit
				local i = 1
				local debuff = UnitDebuff(tar, i)
				while debuff do
					local debufftype = select(5, UnitDebuff(tar, i))
					if debufftype == "Curse" or (ImprovedCleanseSpirit and debufftype == "Magic") then
						if ValidUsable(spells.CleanseSpirit.id, tar) and LosCast(spells.CleanseSpirit.name, tar) then
							return true
						end
					end
					i = i + 1
					debuff = UnitDebuff(t, i)
				end
			end
		end
	end
}
ni.bootstrap.profile("Restro_Cata", queue, abilities, OnLoad, OnUnload)
