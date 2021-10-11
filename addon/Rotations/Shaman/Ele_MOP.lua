local queue = {
	"Pause",
	"FlametongueWeapon",
	"LightningShield",
	"Thunderstorm",
	"FlameShock",
	"LavaBurst",
	"EarthShock",
	"SearingTotem",
	"ChainLightning",
	"LightningBolt",
}
local items = {
	settingsfile = "Fire_MoP.xml",
	{ type = "title", text = "Ele MoP" },
};
local function GetSetting(name)
	for k, v in ipairs(items) do
		if v.type == "entry"
		 and v.key ~= nil
		 and v.key == name then
			return v.value, v.enabled
		end
		if v.type == "dropdown"
		 and v.key ~= nil
		 and v.key == name then
			for k2, v2 in pairs(v.menu) do
				if v2.selected then
					return v2.value
				end
			end
		end
	end
end;

local dumped = false;

local incombat = false;
local function CombatEventCatcher(event, ...)
	if event == "PLAYER_REGEN_DISABLED" then
		incombat = true;
	elseif event == "PLAYER_REGEN_ENABLED" then
		incombat = false;
	end
end
local function OnLoad()
	ni.combatlog.registerhandler("PreRaid Ret", CombatEventCatcher);
	ni.GUI.AddFrame("PreRaid Ret", items);
end
local function OnUnload()
	ni.combatlog.unregisterhandler("PreRaid Ret");
	ni.GUI.DestroyFrame("PreRaid Ret");
end

local spells = {
--General
AutoAttack = {id = 6603, name = GetSpellInfo(6603)}, --Rank ()
Berserking = {id = 26297, name = GetSpellInfo(26297)}, --Rank (Racial)
BattleFatigue = {id = 134732, name = GetSpellInfo(134732)}, --Rank ()
--Elemental
EarthShock = {id = 8042, name = GetSpellInfo(8042)}, --Rank ()
HealingSurge = {id = 8004, name = GetSpellInfo(8004)}, --Rank ()
LightningBolt = {id = 403, name = GetSpellInfo(403)}, --Rank ()
LightningShield = {id = 324, name = GetSpellInfo(324)}, --Rank ()
PrimalStrike = {id = 73899, name = GetSpellInfo(73899)}, --Rank ()
Thunderstorm = {id = 51490, name = GetSpellInfo(51490)}, --Rank ()
HeroicStrike = {id = 78, name = GetSpellInfo(78)}, --Rank ()
AncestralFocus = {id = 89920, name = GetSpellInfo(89920)}, --Rank ()
ElementalFury = {id = 60188, name = GetSpellInfo(60188)}, --Rank ()
ElementalPrecision = {id = 30674, name = GetSpellInfo(30674)}, --Rank ()
ElementalReach = {id = 29000, name = GetSpellInfo(29000)}, --Rank ()
Shamanism = {id = 62099, name = GetSpellInfo(62099)}, --Rank ()
SpiritualInsight = {id = 123099, name = GetSpellInfo(123099)}, --Rank ()
FlameShock = {id = 8050, name = GetSpellInfo(8050)}, --Rank ()
Purge = {id = 370, name = GetSpellInfo(370)}, --Rank ()
AncestralSpirit = {id = 2008, name = GetSpellInfo(2008)}, --Rank ()
GhostWolf = {id = 2645, name = GetSpellInfo(2645)}, --Rank ()
SearingTotem = {id = 3599, name = GetSpellInfo(3599)}, --Rank ()
WindShear = {id = 57994, name = GetSpellInfo(57994)}, --Rank ()
CleanseSpirit = {id = 51886, name = GetSpellInfo(51886)}, --Rank ()
WaterShield = {id = 52127, name = GetSpellInfo(52127)}, --Rank ()
Fulmination = {id = 88766, name = GetSpellInfo(88766)}, --Rank ()
RollingThunder = {id = 88764, name = GetSpellInfo(88764)}, --Rank ()
FrostShock = {id = 8056, name = GetSpellInfo(8056)}, --Rank ()
WaterWalking = {id = 546, name = GetSpellInfo(546)}, --Rank ()
EarthbindTotem = {id = 2484, name = GetSpellInfo(2484)}, --Rank ()
ChainLightning = {id = 421, name = GetSpellInfo(421)}, --Rank ()
HealingStreamTotem = {id = 5394, name = GetSpellInfo(5394)}, --Rank ()
TotemicRecall = {id = 36936, name = GetSpellInfo(36936)}, --Rank ()
AstralRecall = {id = 556, name = GetSpellInfo(556)}, --Rank ()
LavaBurst = {id = 51505, name = GetSpellInfo(51505)}, --Rank ()
FarSight = {id = 6196, name = GetSpellInfo(6196)}, --Rank ()
MagmaTotem = {id = 8190, name = GetSpellInfo(8190)}, --Rank ()
GroundingTotem = {id = 8177, name = GetSpellInfo(8177)}, --Rank ()
BurningWrath = {id = 77747, name = GetSpellInfo(77747)}, --Rank ()
ElementalFocus = {id = 16164, name = GetSpellInfo(16164)}, --Rank ()
ChainHeal = {id = 1064, name = GetSpellInfo(1064)}, --Rank ()
FrostbrandWeapon = {id = 8033, name = GetSpellInfo(8033)}, --Rank ()
LavaSurge = {id = 77756, name = GetSpellInfo(77756)}, --Rank ()
TremorTotem = {id = 8143, name = GetSpellInfo(8143)}, --Rank ()
ElementalOath = {id = 51470, name = GetSpellInfo(51470)}, --Rank ()
EarthElementalTotem = {id = 2062, name = GetSpellInfo(2062)}, --Rank ()
Earthquake = {id = 61882, name = GetSpellInfo(61882)}, --Rank ()
HealingRain = {id = 73920, name = GetSpellInfo(73920)}, --Rank ()
CapacitorTotem = {id = 108269, name = GetSpellInfo(108269)}, --Rank ()
HealingTideTotem = {id = 108280, name = GetSpellInfo(108280)}, --Rank ()
ShamanisticRage = {id = 30823, name = GetSpellInfo(30823)}, --Rank ()
FireElementalTotem = {id = 2894, name = GetSpellInfo(2894)}, --Rank ()
Bloodlust = {id = 2825, name = GetSpellInfo(2825)}, --Rank ()
BindElemental = {id = 76780, name = GetSpellInfo(76780)}, --Rank ()
Hex = {id = 51514, name = GetSpellInfo(51514)}, --Rank ()
RockbiterWeapon = {id = 8017, name = GetSpellInfo(8017)}, --Rank ()
StormlashTotem = {id = 120668, name = GetSpellInfo(120668)}, --Rank ()
GraceofAir = {id = 116956, name = GetSpellInfo(116956)}, --Rank ()
MasteryElementalOverload = {id = 77222, name = GetSpellInfo(77222)}, --Rank ()
UnleashElements = {id = 73680, name = GetSpellInfo(73680)}, --Rank ()
SpiritwalkersGrace = {id = 79206, name = GetSpellInfo(79206)}, --Rank ()
Ascendance = {id = 114049, name = GetSpellInfo(114049)}, --Rank ()
FlametongueWeapon = {id = 8024, name = GetSpellInfo(8024)}, --Rank 
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
local fireSlot, earthSlot, waterSlot, airSlot = 1, 2, 3, 4;
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
	["FlameShock"] = function()
		if ValidUsable(spells.FlameShock.id, "target")
		and ni.unit.debuffremaining("target", spells.FlameShock.id, "player") <= 2
		and FacingLosCast(spells.FlameShock.name) then
			return true
		else
			local cTar = ni.player.enemiesinrange(40)
			for k, v in ipairs(cTar) do
				--/dump aa.player.threat("target")
				if ni.player.threat(v.guid) == -1 then
					table.remove(cTar, k)
				end
			end
			if #cTar > 0 and ni.spell.available(spells.FlameShock.id) then
				for k, v in ipairs(cTar) do
					if ni.unit.debuffremaining(v.guid, spells.FlameShock.id, "player") <= 2 then
						if ni.spell.valid(v.guid, spells.FlameShock.id, true, true) then
							ni.spell.cast(spells.FlameShock.name, v.guid)
							ni.debug.log(string.format("Casting %s on %s", spells.FlameShock.name, v.guid))
							return true
						end
					end
				end
			end
	end
	end,
	["LightningShield"] = function()
		if  ni.spell.available(spells.LightningShield.id)
		and not ni.player.buff(spells.LightningShield.id)
		  then
			ni.spell.cast(spells.LightningShield.name)
			return true
		end
	end,
	["FlametongueWeapon"] = function()
		local enchant = GetWeaponEnchantInfo()
		if ni.spell.available(spells.FlameShock.id)
		and enchant ~= 1
		and not ni.player.buff(spells.FlameShock.id) then
		ni.spell.cast(spells.FlametongueWeapon.name)
			return true
		end
	end,
	["EarthShock"] = function()
		local lsStacks = ni.unit.buffstacks("player", spells.LightningShield.id)
		if  lsStacks >= 7 and ValidUsable(spells.EarthShock.id, "target")
		and FacingLosCast(spells.EarthShock.name, "target") then
			return true
		end
	end,
	["LavaBurst"] = function()
		if ValidUsable(spells.LavaBurst.id, "target")
		and (not ni.player.ismoving() or ni.spell.isinstant(spells.LavaBurst.id))
		and ni.unit.debuff("target", spells.FlameShock.id, "player")
		and FacingLosCast(spells.LavaBurst.name, "target") then
			return true
		end
	end,
	["Thunderstorm"] = function()
		if ActiveEnemies(6) >= 1
		and ni.spell.available(spells.Thunderstorm.id) then
			ni.spell.cast(spells.Thunderstorm.name)
		end
	end,

	["SearingTotem"] = function()
		if TotemTimeRemaining(1, spells.SearingTotem.name) < 5
		and ni.spell.available(spells.SearingTotem.id) then
			ni.spell.cast(spells.SearingTotem.name)
		end
	end,

	["ChainLightning"] = function()
		local chain = ni.unit.enemiesinrange("target", 8)
		if #chain > 1
		and not ni.player.ismoving()
		and ValidUsable(spells.ChainLightning.id, "target")
		and FacingLosCast(spells.ChainLightning.name, "target") then
			return true
		end
	end,

	["LightningBolt"] = function()
		if ValidUsable(spells.LightningBolt.id, "target")
		and FacingLosCast(spells.LightningBolt.name, "target") then
			return true
		end
	end,
}
ni.bootstrap.profile("Ele_MOP", queue, abilities, OnLoad, OnUnload);
