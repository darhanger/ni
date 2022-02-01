local queue = {
	"Pause",
	"Cache",
	"FlametongueWeapon",
	"LightningShield",
	"CalloftheTotems",
	"Thunderstorm",
	"FlameShock",
	"EarthShock",
	"LavaBurst",
	"ChainLightning",
	"LightningBolt"
}

local spells = {
	--build == 40300
	--General icon = select(2, GetSpellTabInfo(1))
	AutoAttack = {id = 6603, name = GetSpellInfo(6603), icon = select(3, GetSpellInfo(6603))},
	--Elemental Combat icon = select(2, GetSpellTabInfo(2))
	EarthShock = {id = 8042, name = GetSpellInfo(8042), icon = select(3, GetSpellInfo(8042))},
	ElementalFury = {id = 60188, name = GetSpellInfo(60188), icon = select(3, GetSpellInfo(60188))},
	LightningBolt = {id = 403, name = GetSpellInfo(403), icon = select(3, GetSpellInfo(403))},
	Shamanism = {id = 62099, name = GetSpellInfo(62099), icon = select(3, GetSpellInfo(62099))},
	Thunderstorm = {id = 51490, name = GetSpellInfo(51490), icon = select(3, GetSpellInfo(51490))},
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
	FlametongueWeapon = {id = 8024, name = GetSpellInfo(8024), icon = select(3, GetSpellInfo(8024))},
	LightningShield = {id = 324, name = GetSpellInfo(324), icon = select(3, GetSpellInfo(324))},
	PrimalStrike = {id = 73899, name = GetSpellInfo(73899), icon = select(3, GetSpellInfo(73899))},
	StrengthofEarthTotem = {id = 8075, name = GetSpellInfo(8075), icon = select(3, GetSpellInfo(8075))},
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
	HealingWave = {id = 331, name = GetSpellInfo(331), icon = select(3, GetSpellInfo(331))},
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
	HealingRain = {id = 73920, name = GetSpellInfo(73920), icon = select(3, GetSpellInfo(73920))}
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

local Callofthe = {
	Elements = 1,
	Ancestors = 2,
	Spirits = 3
}

local enables = {
	["MultiTotem"] = true,
	["TotemicRecall"] = true
}
local values = {
	["TotemicRecall"] = 35
}
local inputs = {}
local menus = {
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

local items = {
	settingsfile = "ele_cata.xml",
	callback = GUICallback,
	{type = "title", text = "\124T" .. select(2, GetSpellTabInfo(2)) .. ":20:20\124t " .. GetSpellTabInfo(2)},
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
	ni.combatlog.registerhandler("e-Cata", CombatEventCatcher)
	ni.GUI.AddFrame("e-Cata", items)
end
local function OnUnload()
	ni.combatlog.unregisterhandler("e-Cata")
	ni.GUI.DestroyFrame("e-Cata")
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

local t, p = "target", "player"

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

local cache = {
	moving = ni.player.ismoving(),
	curchannel = nil,
	iscasting = nil
}

local abilities = {
	["Pause"] = function()
		if
			IsMounted() or UnitIsDeadOrGhost(p) or not UnitExists(t) or UnitIsDeadOrGhost(t) or
				(UnitExists(t) and not UnitCanAttack(p, t))
		 then
			return true
		end
	end,
	["Cache"] = function()
		cache.moving = ni.player.ismoving()
	end,
	["LightningBolt"] = function()
		if not cache.moving and ValidUsable(spells.LightningBolt.id, t) and FacingLosCast(spells.LightningBolt.name, t) then
			return true
		end
	end,
	["FlameShock"] = function()
		if
			ValidUsable(spells.FlameShock.id, t) and ni.unit.debuffremaining(t, spells.FlameShock.id, p) < 2 and
				FacingLosCast(spells.FlameShock.name, t)
		 then
			return true
		end
	end,
	["LavaBurst"] = function()
		if
			not cache.moving and ValidUsable(spells.LavaBurst.name, t) and ni.unit.debuff(t, spells.FlameShock.id, p) and
				FacingLosCast(spells.LavaBurst.name, t)
		 then
			return true
		end
	end,
	["LightningShield"] = function()
		if not ni.player.buff(spells.LightningShield.id) and ni.spell.available(spells.LightningShield.id) then
			ni.spell.cast(spells.LightningShield.name)
		end
	end,
	["FlametongueWeapon"] = function()
		local enchant = GetWeaponEnchantInfo()
		if
			ni.spell.available(spells.FlametongueWeapon.id) and enchant ~= 1 and not ni.player.buff(spells.FlametongueWeapon.id)
		 then
			ni.spell.cast(spells.FlametongueWeapon.name)
			return true
		end
	end,
	["ChainLightning"] = function()
		local chain = ni.unit.enemiesinrange("target", 8)
		if
			not cache.moving and #chain > 1 and not ni.player.ismoving() and ValidUsable(spells.ChainLightning.id, "target") and
				FacingLosCast(spells.ChainLightning.name, "target")
		 then
			return true
		end
	end,
	["Thunderstorm"] = function()
		if ActiveEnemies(9) >= 1 and ni.spell.available(spells.Thunderstorm.id) then
			ni.spell.cast(spells.Thunderstorm.name)
		end
	end,
	["EarthShock"] = function()
		if
			ValidUsable(spells.EarthShock.name, t) and ni.player.buffstacks(spells.LightningShield.id) == 9 and
				select(5, GetTalentInfo(1, 13)) == 1 and
				FacingLosCast(spells.EarthShock.name, t)
		 then
			return true
		end
	end,
	["CalloftheTotems"] = function()
		if enables["TotemicRecall"] then
			if (AnyTotemDistance(t) > values["TotemicRecall"]) and ni.spell.available(spells.TotemicRecall.id) then
				ni.spell.cast(spells.TotemicRecall.name)
				return true
			end
		end
		if enables["MultiTotem"] and IsSpellInRange(spells.LightningBolt.name, t) == 1 then
			if not HasTotem(Totem.Fire) and incombat then
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
	end
}
ni.bootstrap.profile("Ele_Cata", queue, abilities, OnLoad, OnUnload)
