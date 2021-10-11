local queue = {
	"Pause",
	"FlametongueWeapon",
	"WindShear",
	"LightningShield",
	"WaterShield",
	"LavaBurst",
	"FlameShock",
	"EarthShock",
	"ChainLightning",
	"LightningBolt"
}
local enables = {
	["EarthShock"] = false,
	["LightningShield"] = false
}
local items = {
	settingsfile = "FElementalWrath.xml",
	{type = "title", text = "Elemental Wrath"},
	{
		type = "entry",
		text = "LightningShield",
		tooltip = "Use Lightning Shield",
		enabled = enables["LightningShield"],
		key = "LightningShield"
	},
	{
		type = "entry",
		text = "Earth Shock",
		tooltip = "Use Earth Shock",
		enabled = enables["EarthShock"],
		key = "EarthShock"
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
	ni.combatlog.registerhandler("ElementalWrath", CombatEventCatcher)
	ni.GUI.AddFrame("ElementalWrath", items)
end
local function OnUnload()
	ni.combatlog.unregisterhandler("ElementalWrath")
	ni.GUI.DestroyFrame("ElementalWrath")
end

local spells = {
	--General
	GiftoftheNaaru = {id = 59547, name = GetSpellInfo(59547)},
	AutoAttack = {id = 6603, name = GetSpellInfo(6603)},
	--Elemental Combat
	WindShear = {id = 57994, name = GetSpellInfo(57994)},
	StoneclawTotem = {id = 58582, name = GetSpellInfo(58582)},
	ElementalMastery = {id = 16166, name = GetSpellInfo(16166)},
	CalloftheElements = {id = 66842, name = GetSpellInfo(66842)},
	FlameShock = {id = 49233, name = GetSpellInfo(49233)},
	FireElementalTotem = {id = 2894, name = GetSpellInfo(2894)},
	Thunderstorm = {id = 59159, name = GetSpellInfo(59159)},
	Purge = {id = 8012, name = GetSpellInfo(8012)},
	CalloftheSpirits = {id = 66844, name = GetSpellInfo(66844)},
	EarthShock = {id = 49231, name = GetSpellInfo(49231)},
	Hex = {id = 51514, name = GetSpellInfo(51514)},
	EarthbindTotem = {id = 2484, name = GetSpellInfo(2484)},
	LavaBurst = {id = 60043, name = GetSpellInfo(60043)},
	LightningBolt = {id = 49238, name = GetSpellInfo(49238)},
	ElementalOath = {id = 51470, name = GetSpellInfo(51470)},
	FrostShock = {id = 49236, name = GetSpellInfo(49236)},
	MagmaTotem = {id = 58734, name = GetSpellInfo(58734)},
	FireNova = {id = 61657, name = GetSpellInfo(61657)},
	CalloftheAncestors = {id = 66843, name = GetSpellInfo(66843)},
	SearingTotem = {id = 58704, name = GetSpellInfo(58704)},
	TotemofWrath = {id = 57722, name = GetSpellInfo(57722)},
	ChainLightning = {id = 49271, name = GetSpellInfo(49271)},
	--Enhancement
	FrostResistanceTotem = {id = 58745, name = GetSpellInfo(58745)},
	FlametongueWeapon = {id = 58790, name = GetSpellInfo(58790)},
	GhostWolf = {id = 2645, name = GetSpellInfo(2645)},
	FireResistanceTotem = {id = 58739, name = GetSpellInfo(58739)},
	Heroism = {id = 32182, name = GetSpellInfo(32182)},
	WindfuryTotem = {id = 8512, name = GetSpellInfo(8512)},
	WrathofAirTotem = {id = 3738, name = GetSpellInfo(3738)},
	LightningShield = {id = 49281, name = GetSpellInfo(49281)},
	FrostbrandWeapon = {id = 58796, name = GetSpellInfo(58796)},
	SentryTotem = {id = 6495, name = GetSpellInfo(6495)},
	WindfuryWeapon = {id = 58804, name = GetSpellInfo(58804)},
	WaterWalking = {id = 546, name = GetSpellInfo(546)},
	EarthElementalTotem = {id = 2062, name = GetSpellInfo(2062)},
	StoneskinTotem = {id = 58753, name = GetSpellInfo(58753)},
	StrengthofEarthTotem = {id = 58643, name = GetSpellInfo(58643)},
	FlametongueTotem = {id = 58656, name = GetSpellInfo(58656)},
	WaterBreathing = {id = 131, name = GetSpellInfo(131)},
	RockbiterWeapon = {id = 10399, name = GetSpellInfo(10399)},
	NatureResistanceTotem = {id = 58749, name = GetSpellInfo(58749)},
	AstralRecall = {id = 556, name = GetSpellInfo(556)},
	FarSight = {id = 6196, name = GetSpellInfo(6196)},
	GroundingTotem = {id = 8177, name = GetSpellInfo(8177)},
	--Restoration
	WaterShield = {id = 57960, name = GetSpellInfo(57960)},
	ManaSpringTotem = {id = 58774, name = GetSpellInfo(58774)},
	TotemicRecall = {id = 36936, name = GetSpellInfo(36936)},
	EarthlivingWeapon = {id = 51994, name = GetSpellInfo(51994)},
	HealingStreamTotem = {id = 58757, name = GetSpellInfo(58757)},
	CureToxins = {id = 526, name = GetSpellInfo(526)},
	ChainHeal = {id = 55459, name = GetSpellInfo(55459)},
	TremorTotem = {id = 8143, name = GetSpellInfo(8143)},
	LesserHealingWave = {id = 49276, name = GetSpellInfo(49276)},
	AncestralSpirit = {id = 49277, name = GetSpellInfo(49277)},
	CleansingTotem = {id = 8170, name = GetSpellInfo(8170)},
	HealingWave = {id = 49273, name = GetSpellInfo(49273)}
}

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
		if
			IsMounted() or UnitIsDeadOrGhost("player") or not UnitExists("target") or UnitIsDeadOrGhost("target") or
				(UnitExists("target") and not UnitCanAttack("player", "target"))
		 then
			return true
		end
	end,
	["LightningShield"] = function()
		if
			enables["LightningShield"] and ni.spell.available(spells.LightningShield.name) and
				not ni.player.buff(spells.LightningShield.name)
		 then
			ni.spell.cast(spells.LightningShield.name)
			return true
		end
	end,
	["WindShear"] = function()
		local cd = ni.spell.cd(spells.WindShear.id)
		if cd == 0 and ni.spell.shouldinterrupt("target") and FacingLosCast(spells.WindShear.name, "target") then
			return true
		end
	end,
	["WaterShield"] = function()
		if
			not enables["LightningShield"] and ni.spell.available(spells.WaterShield.name) and
				not ni.player.buff(spells.WaterShield.name)
		 then
			ni.spell.cast(spells.WaterShield.name)
			return true
		end
	end,
	["FlametongueWeapon"] = function()
		if ni.spell.available(spells.FlametongueWeapon.name) and --not really a great way to check if its present but wtf
				not GetWeaponEnchantInfo() then
			ni.spell.cast(spells.FlametongueWeapon.name)
			return true
		end
	end,
	["FlameShock"] = function()
		if
			incombat and ValidUsable(spells.FlameShock.name, "target") and
				ni.unit.debuffremaining("target", spells.FlameShock.id, "player") <= 2 and
				FacingLosCast(spells.FlameShock.name, "target")
		 then
			return true
		end
	end,
	["LavaBurst"] = function()
		if
			incombat and ValidUsable(spells.LavaBurst.name, "target") and
				ni.unit.debuffremaining("target", spells.FlameShock.id, "player") >= 2 and
				FacingLosCast(spells.LavaBurst.name, "target")
		 then
			return true
		end
	end,
	["EarthShock"] = function()
		if
			enables["EarthShock"] and ValidUsable(spells.EarthShock.name, "target") and
				FacingLosCast(spells.EarthShock.name, "target")
		 then
			return true
		end
	end,
	["ChainLightning"] = function()
		local chain = ni.unit.enemiesinrange("target", 8)
		if
			#chain > 1 and not ni.player.ismoving() and ValidUsable(spells.ChainLightning.id, "target") and
				FacingLosCast(spells.ChainLightning.name, "target")
		 then
			return true
		end
	end,
	["LightningBolt"] = function()
		if
			ValidUsable(spells.LightningBolt.name, "target") and not ni.player.ismoving() and
				FacingLosCast(spells.LightningBolt.name, "target")
		 then
			return true
		end
	end
}
ni.bootstrap.profile("Ele_Wrath", queue, abilities, OnLoad, OnUnload)
