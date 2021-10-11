local queue = {
	"Pause",
	"CancelCast",
	"WaterShield",
	"EarthlivingWeapon",
	"Tank Heal",
	"Riptide",
	"ChainHeal",
	"HealingWave",
	"LesserHealingWave",
	"LightningBolt"
}
local enables = {
	["RiptideTank"] = true,
	["LesserHealingWaveTank"] = true,
	["HealingWaveTank"] = true,
	["LightningBolt"] = false,
	["TargetUnit"] = false,
	["CancelCast"] = false
}
local values = {
	["RiptideTank"] = 92,
	["LesserHealingWaveTank"] = 20,
	["HealingWaveTank"] = 75,
	["RiptideHP"] = 92,
	["LesserHealingWave"] = 20,
	["HealingWaveHP"] = 60,
	["ChainHealHP"] = 75,
	["CancelCast"] = 95
}
local inputs = {}
local mainTankText, offTankText, focusText = "|cffFFFF33Main Tank", "|cffFF9900Off Tank", "|cff24E0FBFocus"

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
local items = {
	settingsfile = "Restro_Wrath.xml",
	callback = GUICallback,
	{type = "title", text = "Restro_Wrath"},
	{type = "separator"},
	{type = "title", text = "Earth Shield Target"},
	{
		type = "dropdown",
		menu = {
			{selected = (menus["EarthShieldTar"] == 1), value = 1, text = mainTankText},
			{selected = (menus["EarthShieldTar"] == 2), value = 2, text = offTankText},
			{selected = (menus["EarthShieldTar"] == 3), value = 3, text = focusText}
		},
		key = "EarthShieldTar"
	},
	{type = "separator"},
	{type = "title", text = "Tank Heal"},
	{
		type = "entry",
		text = "Riptide Tank HP",
		enabled = enables["RiptideTank"],
		value = values["RiptideTank"],
		key = "RiptideTank"
	},
	{
		type = "entry",
		text = "Healing Wave Tank HP",
		value = values["HealingWaveTank"],
		enabled = enables["HealingWaveTank"],
		key = "HealingWaveTank"
	},
	{
		type = "entry",
		text = "Lesser Healing Wave Tank HP",
		value = values["LesserHealingWaveTank"],
		enabled = enables["LesserHealingWaveTank"],
		key = "LesserHealingWaveTank"
	},
	{type = "separator"},
	{type = "title", text = "Heals"},
	{
		type = "entry",
		text = "Riptide HP",
		value = values["RiptideHP"],
		key = "RiptideHP"
	},
	{
		type = "entry",
		text = "Lesser Healing Wave",
		value = values["LesserHealingWave"],
		key = "LesserHealingWave"
	},
	{
		type = "entry",
		text = "Healing Wave HP",
		value = values["HealingWaveHP"],
		key = "HealingWaveHP"
	},
	{
		type = "entry",
		text = "Chain Heal HP",
		value = values["ChainHealHP"],
		key = "ChainHealHP"
	},
	{type = "title", text = "Dps"},
	{
		type = "entry",
		text = "Use Lightning Bolt",
		enabled = enables["LightningBolt"],
		key = "LightningBolt"
	},
	{type = "separator"},
	{type = "title", text = "Other"},
	{
		type = "entry",
		text = "Target Units",
		enabled = enables["TargetUnit"],
		key = "TargetUnit"
	},
	{
		type = "entry",
		text = "Cancel Cast",
		enabled = enables["CancelCast"],
		value = values["CancelCast"],
		key = "CancelCast"
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
				(buff ~= nil and not ni.unit.buff(ni.members[i].unit, buff, "player"))
		 then
			table.wipe(temptable)
			if buff ~= nil then
				temptable = ni.members.inrangewithoutbuff(ni.members[i].unit, distance, buff, "player")
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

local spells = {
	--General
	GiftoftheNaaru = {id = 59547, name = GetSpellInfo(59547)},
	AutoAttack = {id = 6603, name = GetSpellInfo(6603)},
	--Elemental Combat
	WindShear = {id = 57994, name = GetSpellInfo(57994)},
	EarthbindTotem = {id = 2484, name = GetSpellInfo(2484)},
	StoneclawTotem = {id = 10428, name = GetSpellInfo(10428)},
	MagmaTotem = {id = 25552, name = GetSpellInfo(25552)},
	FrostShock = {id = 10473, name = GetSpellInfo(10473)},
	CalloftheElements = {id = 66842, name = GetSpellInfo(66842)},
	SearingTotem = {id = 10438, name = GetSpellInfo(10438)},
	FlameShock = {id = 29228, name = GetSpellInfo(29228)},
	CalloftheAncestors = {id = 66843, name = GetSpellInfo(66843)},
	LightningBolt = {id = 25448, name = GetSpellInfo(25448)},
	FireNova = {id = 25546, name = GetSpellInfo(25546)},
	Purge = {id = 8012, name = GetSpellInfo(8012)},
	ChainLightning = {id = 25439, name = GetSpellInfo(25439)},
	CalloftheSpirits = {id = 66844, name = GetSpellInfo(66844)},
	EarthShock = {id = 10414, name = GetSpellInfo(10414)},
	--Enhancement
	FrostResistanceTotem = {id = 10479, name = GetSpellInfo(10479)},
	FlametongueWeapon = {id = 25489, name = GetSpellInfo(25489)},
	GhostWolf = {id = 2645, name = GetSpellInfo(2645)},
	FireResistanceTotem = {id = 10538, name = GetSpellInfo(10538)},
	WindfuryTotem = {id = 8512, name = GetSpellInfo(8512)},
	WrathofAirTotem = {id = 3738, name = GetSpellInfo(3738)},
	LightningShield = {id = 25469, name = GetSpellInfo(25469)},
	FrostbrandWeapon = {id = 25500, name = GetSpellInfo(25500)},
	SentryTotem = {id = 6495, name = GetSpellInfo(6495)},
	WindfuryWeapon = {id = 16362, name = GetSpellInfo(16362)},
	WaterWalking = {id = 546, name = GetSpellInfo(546)},
	EarthElementalTotem = {id = 2062, name = GetSpellInfo(2062)},
	StoneskinTotem = {id = 25508, name = GetSpellInfo(25508)},
	StrengthofEarthTotem = {id = 25528, name = GetSpellInfo(25528)},
	FlametongueTotem = {id = 16387, name = GetSpellInfo(16387)},
	WaterBreathing = {id = 131, name = GetSpellInfo(131)},
	RockbiterWeapon = {id = 10399, name = GetSpellInfo(10399)},
	NatureResistanceTotem = {id = 10601, name = GetSpellInfo(10601)},
	AstralRecall = {id = 556, name = GetSpellInfo(556)},
	FarSight = {id = 6196, name = GetSpellInfo(6196)},
	GroundingTotem = {id = 8177, name = GetSpellInfo(8177)},
	--Restoration
	WaterShield = {id = 24398, name = GetSpellInfo(24398)},
	TremorTotem = {id = 8143, name = GetSpellInfo(8143)},
	TotemicRecall = {id = 36936, name = GetSpellInfo(36936)},
	Riptide = {id = 61295, name = GetSpellInfo(61295)},
	ManaSpringTotem = {id = 25570, name = GetSpellInfo(25570)},
	EarthShield = {id = 32593, name = GetSpellInfo(32593)},
	EarthlivingWeapon = {id = 51992, name = GetSpellInfo(51992)},
	HealingStreamTotem = {id = 10463, name = GetSpellInfo(10463)},
	NaturesSwiftness = {id = 16188, name = GetSpellInfo(16188)},
	CureToxins = {id = 526, name = GetSpellInfo(526)},
	ChainHeal = {id = 25422, name = GetSpellInfo(25422)},
	HealingWave = {id = 25391, name = GetSpellInfo(25391)},
	LesserHealingWave = {id = 25420, name = GetSpellInfo(25420)},
	AncestralSpirit = {id = 20777, name = GetSpellInfo(20777)},
	CleansingTotem = {id = 8170, name = GetSpellInfo(8170)},
	ManaTideTotem = {id = 16190, name = GetSpellInfo(16190)}
}

local lastSpell, lastUnit

local function LosCast(spell, tar)
	if ni.player.los(tar) and IsSpellInRange(spell, tar) == 1 then
		ni.spell.cast(spell, tar)
		lastSpell = spell
		lastUnit = tar
		if enables["TargetUnit"] then
			TargetUnit(tar)
		end
		return true
	end
	return false
end

local function ValidUsable(id, tar)
	if ni.spell.available(id) and ni.spell.valid(tar, id, false, true, true) then
		return true
	end
	return false
end

--GetTotemInfo
local fireSlot, earthSlot, waterSlot, airSlot = 1, 2, 3, 4
local function HasTotem(slot, name)
	local haveTotem, totemName = GetTotemInfo(slot)
	if haveTotem and totemName == name then
		return true
	end
	if haveTotem and totemName == nil then
		return true
	end
	return false
end
local function TotemTimeRemaining(slot, name)
	if not HasTotem(slot, name) then
		return 0
	end
	local _, _, startTime, duration = GetTotemInfo(slot)
	return startTime + duration - GetTime()
end

local abilities = {
	["Pause"] = function()
		if IsMounted() or UnitIsDeadOrGhost("player") then
			return true
		end
	end,
	["CancelCast"] = function()
		local spellName, _, _, _, endTime = UnitCastingInfo("player")
		if enables["CancelCast"] and spellName ~= nil then
			local finish = endTime/1000 - GetTime()
			if ni.unit.exists(lastUnit) and ni.unit.hp(lastUnit) >= values["CancelCast"] and finish >= 0.25 then
				ni.spell.stopcasting()
				return true
			end
		end
	end,
	["WaterShield"] = function()
		if ni.spell.available(spells.WaterShield.name) and not ni.player.buff(spells.WaterShield.name) then
			ni.spell.cast(spells.WaterShield.name)
			return true
		end
	end,
	["EarthlivingWeapon"] = function()
		local enchant = GetWeaponEnchantInfo()
		if
			ni.spell.available(spells.EarthlivingWeapon.name) and enchant ~= 1 and
				not ni.player.buff(spells.EarthlivingWeapon.name)
		 then
			ni.spell.cast(spells.EarthlivingWeapon.name)
			return true
		end
	end,
	["Tank Heal"] = function()
		local mainTank, offTank = ni.tanks()
		--Earthsheild focus
		if menus["EarthShieldTar"] == 3 and ni.unit.exists("focus") then
			local es, _, _, esCount, _, _, esTime = ni.unit.buff("focus", spells.EarthShield.name, "player")
			if
				(not es or esTime - GetTime() < 2) and ValidUsable(spells.EarthShield.name, "focus") and
					LosCast(spells.EarthShield.name, "focus")
			 then
				return true
			end
		end
		if mainTank ~= nil and ni.unit.exists(mainTank) then
			--EarthShield mainTank
			local esM, _, _, esMCount, _, _, esMTime = ni.unit.buff(mainTank, spells.EarthShield.name, "player")
			if
				(not esM or esMCount < 2 or esMTime - GetTime() < 2) and menus["EarthShieldTar"] == 1 and
					ValidUsable(spells.EarthShield.name, mainTank) and
					LosCast(spells.EarthShield.name, mainTank)
			 then
				return true
			end
			--Riptide mainTank
			if
				enables["RiptideTank"] and not ni.unit.buff(mainTank, spells.Riptide.name, "player") and
					ni.unit.hp(mainTank) <= values["RiptideTank"] and
					ValidUsable(spells.Riptide.name, mainTank) and
					LosCast(spells.Riptide.name, mainTank)
			 then
				return true
			end
			--HealingWave mainTank
			if
				enables["HealingWaveTank"] and not ni.player.ismoving() and ni.unit.hp(mainTank) <= values["HealingWaveTank"] and
					ValidUsable(spells.HealingWave.name, mainTank) and
					LosCast(spells.HealingWave.name, mainTank)
			 then
				return true
			end
			--LesserHealingWave mainTank
			if
				enables["LesserHealingWaveTank"] and not ni.player.ismoving() and
					ni.unit.hp(mainTank) <= values["LesserHealingWaveTank"] and
					ValidUsable(spells.LesserHealingWave.name, mainTank) and
					LosCast(spells.LesserHealingWave.name, mainTank)
			 then
				return true
			end
			--offTank
			if offTank ~= nil and ni.unit.exists(offTank) then
				--EarthShield offTank
				local esO, _, _, esOCount, _, _, esOTime = ni.unit.buff(mainTank, spells.EarthShield.name, "player")
				if
					(not esO or esOCount < 2 or esOTime - GetTime() < 2) and menus["EarthShieldTar"] == 2 and
						ValidUsable(spells.EarthShield.name, offTank) and
						LosCast(spells.EarthShield.name, offTank)
				 then
					return true
				end
				--Riptide offTank
				if
					enables["RiptideTank"] and ni.unit.hp(offTank) <= values["RiptideTank"] and
						not ni.unit.buff(offTank, spells.Riptide.name, "player") and
						ValidUsable(spells.Riptide.name, offTank) and
						LosCast(spells.Riptide.name, offTank)
				 then
					return true
				end
				--HealingWave offTank
				if
					enables["HealingWaveTank"] and not ni.player.ismoving() and ni.unit.hp(offTank) <= values["HealingWaveTank"] and
						ValidUsable(spells.HealingWave.name, offTank) and
						LosCast(spells.HealingWave.name, offTank)
				 then
					return true
				end
				--LesserHealingWave offTank
				if
					enables["LesserHealingWaveTank"] and not ni.player.ismoving() and
						ni.unit.hp(offTank) <= values["LesserHealingWaveTank"] and
						ValidUsable(spells.LesserHealingWave.name, offTank) and
						LosCast(spells.LesserHealingWave.name, offTank)
				 then
					return true
				end
			end
		end
	end,
	["Riptide"] = function()
		for i = 1, #ni.members do
			if
				ni.members[i].hp <= values["RiptideHP"] and not ni.unit.buff(ni.members[i].unit, spells.Riptide.name, "player") and
					ValidUsable(spells.Riptide.name, ni.members[i].unit) and
					LosCast(spells.Riptide.name, ni.members[i].unit)
			 then
				return true
			end
		end
	end,
	["LesserHealingWave"] = function()
		if not ni.player.ismoving() then
			for i = 1, #ni.members do
				if
					ni.members[i].hp <= values["LesserHealingWave"] and ValidUsable(spells.LesserHealingWave.name, ni.members[i].unit) and
						LosCast(spells.LesserHealingWave.name, ni.members[i].unit)
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
		if ni.spell.available(spells.ChainHeal.name) then
			GetTableForBestUnit(values["ChainHealHP"], 10, 3)
			if #customtable > 0 then
				if customtable[1].unitsclose >= 3 and ValidUsable(spells.ChainHeal.name, customtable[1].unit) then
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
			enables["LightningBolt"] and UnitExists("target") and UnitCanAttack("player", "target") and
				not UnitIsDeadOrGhost("target") and
				UnitAffectingCombat("player", "target") and
				ni.spell.available(spells.LightningBolt.name) and
				ni.spell.valid("target", spells.LightningBolt.name, true, true)
		 then
			ni.spell.cast(spells.LightningBolt.name, "target")
			return true
		end
	end
}
ni.bootstrap.profile("Restro_Wrath", queue, abilities, OnLoad, OnUnload)
