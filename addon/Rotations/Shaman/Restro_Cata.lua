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
local items = {
	settingsfile = "RestroMOP.xml",
	{ type = "title", text = "Restro MOP" },
	{ type = "separator" },
	{ type = "title", text = "Earth Shield Target" },
	{ type = "dropdown", menu = {
		{ selected = true, value = 1, text = "|cffFFFF33Main Tank" },
		{ selected = false, value = 2, text = "|cffFF9900Off Tank" },
		{ selected = false, value = 3, text = "|cff24E0FBFocus" },
	}, key = "EarthShieldTar" },
	{ type = "separator" },
	{ type = "title", text = "Tank Heal" },
	{ type = "entry", text = "Riptide Tank HP", value = 92, enabled = true, key = "RiptideTank" },
	{ type = "entry", text = "Healing Surge Tank HP", value = 85, enabled = true, key = "HealingSurgeTank" },
	{ type = "separator" },
	{ type = "title", text = "Heals" },
	{ type = "entry", text = "Riptide HP", value = 92, key = "RiptideHP" },
	{ type = "entry", text = "Healing Surge HP", value = 70, key = "HealingSurgeHP" },
	{ type = "entry", text = "Healing Wave HP", value = 86, key = "HealingWaveHP" },
	{ type = "entry", text = "Chain Heal HP", value = 75, key = "ChainHealHP" },
	{ type = "separator" },
	{ type = "title", text = "Dps" },
	{ type = "entry", text = "Use Lightning Bolt", enabled = false, key = "LightningBolt" },
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

local incombat = false;
local function CombatEventCatcher(event, ...)
	if event == "PLAYER_REGEN_DISABLED" then
		incombat = true;
	elseif event == "PLAYER_REGEN_ENABLED" then
		incombat = false;
	end
end
local function OnLoad()
	ni.combatlog.registerhandler("RestroMOP", CombatEventCatcher);
	ni.GUI.AddFrame("RestroMOP", items);
end
local function OnUnload()
	ni.combatlog.unregisterhandler("RestroMOP");
	ni.GUI.DestroyFrame("RestroMOP");
end

local temptable = { };
local customtable = { };
local function SortByUnits(x, y)
	return x.unitsclose > y.unitsclose;
end
local function SortByHP(x, y)
	return x.hp < y.hp
end
local function GetTableForBestUnit(health, distance, unitsclose, buff)
	table.wipe(customtable);
	for i = 1, #ni.members do
		if ni.members[i].hp <= health
		 and ni.members[i].range
		 and (buff ~= nil 
		 and not ni.unit.buff(ni.members[i].unit, buff, "player")) then
			table.wipe(temptable);
			if buff ~= nil then
				temptable = ni.members.inrangewithoutbuff(ni.members[i].unit, distance, buff, "player");
				for k, v in ipairs(temptable) do
					if v and v.hp > health then
						tremove(temptable, k);
					end
				end
			else
				temptable = ni.members.inrangebelow(ni.members[i].unit, distance, health);				
			end
			if #temptable >= unitsclose then
				tinsert(customtable, { unit = ni.members[i].unit, hp = ni.members[i].hp, unitsclose = #temptable });
			end
		end
	end
	if #customtable > 0 then
		table.sort(customtable, SortByHP)
	end
end

local spells = {
	--Restoration
AncestralSpirit = {id = 2008, name = GetSpellInfo(2008)}, --Rank: Type:SPELL J:29
EarthShock = {id = 8042, name = GetSpellInfo(8042)}, --Rank: Type:SPELL J:30
FlameShock = {id = 8050, name = GetSpellInfo(8050)}, --Rank: Type:SPELL J:32
GhostWolf = {id = 2645, name = GetSpellInfo(2645)}, --Rank: Type:SPELL J:33
HealingSurge = {id = 8004, name = GetSpellInfo(8004)}, --Rank: Type:SPELL J:34
HealingWave = {id = 331, name = GetSpellInfo(331)}, --Rank: Type:SPELL J:35
LightningBolt = {id = 403, name = GetSpellInfo(403)}, --Rank: Type:SPELL J:36
LightningShield = {id = 324, name = GetSpellInfo(324)}, --Rank: Type:SPELL J:37
PrimalStrike = {id = 73899, name = GetSpellInfo(73899)}, --Rank: Type:SPELL J:38
Purge = {id = 370, name = GetSpellInfo(370)}, --Rank: Type:SPELL J:39
CleanseSpirit = {id = 51886, name = GetSpellInfo(51886)}, --Rank: Type:SPELL J:40
Riptide = {id = 61295, name = GetSpellInfo(61295)}, --Rank: Type:SPELL J:41
WaterShield = {id = 52127, name = GetSpellInfo(52127)}, --Rank: Type:SPELL J:42
WindShear = {id = 57994, name = GetSpellInfo(57994)}, --Rank: Type:SPELL J:44
AncestralFocus = {id = 89920, name = GetSpellInfo(89920)}, --Rank: Type:SPELL J:45
Meditation = {id = 95862, name = GetSpellInfo(95862)}, --Rank: Type:SPELL J:46
NaturesGuardian = {id = 30884, name = GetSpellInfo(30884)}, --Rank: Type:SPELL J:47
Purification = {id = 16213, name = GetSpellInfo(16213)}, --Rank: Type:SPELL J:48
SpiritualInsight = {id = 112858, name = GetSpellInfo(112858)}, --Rank: Type:SPELL J:49
FrostShock = {id = 8056, name = GetSpellInfo(8056)}, --Rank: Type:FUTURESPELL J:50
WaterWalking = {id = 546, name = GetSpellInfo(546)}, --Rank: Type:FUTURESPELL J:51
EarthShield = {id = 974, name = GetSpellInfo(974)}, --Rank: Type:FUTURESPELL J:52
EarthbindTotem = {id = 2484, name = GetSpellInfo(2484)}, --Rank: Type:FUTURESPELL J:53
ChainLightning = {id = 421, name = GetSpellInfo(421)}, --Rank: Type:FUTURESPELL J:54
EarthlivingWeapon = {id = 51730, name = GetSpellInfo(51730)}, --Rank: Type:FUTURESPELL J:55
HealingStreamTotem = {id = 5394, name = GetSpellInfo(5394)}, --Rank: Type:FUTURESPELL J:56
TotemicRecall = {id = 36936, name = GetSpellInfo(36936)}, --Rank: Type:FUTURESPELL J:57
Reincarnation = {id = 20608, name = GetSpellInfo(20608)}, --Rank:Passive Type:FUTURESPELL J:58
AstralRecall = {id = 556, name = GetSpellInfo(556)}, --Rank: Type:FUTURESPELL J:59
LavaBurst = {id = 51505, name = GetSpellInfo(51505)}, --Rank: Type:FUTURESPELL J:60
AncestralAwakening = {id = 51558, name = GetSpellInfo(51558)}, --Rank: Type:FUTURESPELL J:61
FarSight = {id = 6196, name = GetSpellInfo(6196)}, --Rank: Type:FUTURESPELL J:62
MagmaTotem = {id = 8190, name = GetSpellInfo(8190)}, --Rank: Type:FUTURESPELL J:63
GroundingTotem = {id = 8177, name = GetSpellInfo(8177)}, --Rank: Type:FUTURESPELL J:64
BurningWrath = {id = 77747, name = GetSpellInfo(77747)}, --Rank: Type:FUTURESPELL J:65
Resurgence = {id = 16196, name = GetSpellInfo(16196)}, --Rank: Type:FUTURESPELL J:66
ChainHeal = {id = 1064, name = GetSpellInfo(1064)}, --Rank: Type:FUTURESPELL J:67
FrostbrandWeapon = {id = 8033, name = GetSpellInfo(8033)}, --Rank: Type:FUTURESPELL J:68
MailSpecialization = {id = 86529, name = GetSpellInfo(86529)}, --Rank:Passive Type:FUTURESPELL J:69
TidalWaves = {id = 51564, name = GetSpellInfo(51564)}, --Rank: Type:FUTURESPELL J:70
TremorTotem = {id = 8143, name = GetSpellInfo(8143)}, --Rank: Type:FUTURESPELL J:71
ManaTideTotem = {id = 16190, name = GetSpellInfo(16190)}, --Rank: Type:FUTURESPELL J:72
EarthElementalTotem = {id = 2062, name = GetSpellInfo(2062)}, --Rank: Type:FUTURESPELL J:73
GreaterHealingWave = {id = 77472, name = GetSpellInfo(77472)}, --Rank: Type:FUTURESPELL J:74
HealingRain = {id = 73920, name = GetSpellInfo(73920)}, --Rank: Type:FUTURESPELL J:75
CapacitorTotem = {id = 108269, name = GetSpellInfo(108269)}, --Rank: Type:FUTURESPELL J:76
HealingTideTotem = {id = 108280, name = GetSpellInfo(108280)}, --Rank: Type:FUTURESPELL J:77
FireElementalTotem = {id = 2894, name = GetSpellInfo(2894)}, --Rank: Type:FUTURESPELL J:78
Bloodlust = {id = 2825, name = GetSpellInfo(2825)}, --Rank: Type:FUTURESPELL J:79
SpiritLinkTotem = {id = 98008, name = GetSpellInfo(98008)}, --Rank: Type:FUTURESPELL J:80
BindElemental = {id = 76780, name = GetSpellInfo(76780)}, --Rank: Type:FUTURESPELL J:81
Hex = {id = 51514, name = GetSpellInfo(51514)}, --Rank: Type:FUTURESPELL J:82
RockbiterWeapon = {id = 8017, name = GetSpellInfo(8017)}, --Rank: Type:FUTURESPELL J:83
StormlashTotem = {id = 120668, name = GetSpellInfo(120668)}, --Rank: Type:FUTURESPELL J:84
GraceofAir = {id = 116956, name = GetSpellInfo(116956)}, --Rank: Type:FUTURESPELL J:85
MasteryDeepHealing = {id = 77226, name = GetSpellInfo(77226)}, --Rank: Type:FUTURESPELL J:86
UnleashElements = {id = 73680, name = GetSpellInfo(73680)}, --Rank: Type:FUTURESPELL J:87
SpiritwalkersGrace = {id = 79206, name = GetSpellInfo(79206)}, --Rank: Type:FUTURESPELL J:88
Ascendance = {id = 114049, name = GetSpellInfo(114049)}, --Rank: Type:FUTURESPELL J:89
}

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
		if IsMounted() or UnitIsDeadOrGhost("player") then
			return true
		end
	end,

	["WaterShield"]  = function ()
		if ni.spell.available(spells.WaterShield.id)
		and not ni.player.buff(spells.WaterShield.id) then
			ni.spell.cast(spells.WaterShield.name)
			return true;
		end
	end,
	["EarthlivingWeapon"]  = function ()
		local enchant = GetWeaponEnchantInfo()
		if ni.spell.available(spells.EarthlivingWeapon.id)
		and enchant ~= 1
		and not ni.player.buff(spells.EarthlivingWeapon.id) then
			ni.spell.cast(spells.EarthlivingWeapon.name)
			return  true;
		end
	end,
	["Tank Heal"] = function ()
		local mainTank, offTank = ni.tanks()
		local esTar = GetSetting("EarthShieldTar")
		--Earthsheild focus
		if esTar == 3 and ni.unit.exists("focus") then
			local es, _, _, esCount, _, _, esTime = ni.unit.buff("focus", spells.EarthShield.id, "player")
			if (not es
			or esTime - GetTime() < 2)
			and ValidUsable(spells.EarthShield.id, "focus")
			and LosCast(spells.EarthShield.name, "focus") then
				return true
			end
		end
		if mainTank ~= nil and ni.unit.exists(mainTank) then
			--EarthShield mainTank
			local esM, _, _, esMCount, _, _, esMTime = ni.unit.buff(mainTank, spells.EarthShield.id, "player")
			if (not esM
			or esMCount < 2
			or esMTime - GetTime() < 2)
			and esTar == 1
			and ValidUsable(spells.EarthShield.id, mainTank)
			and LosCast(spells.EarthShield.name, mainTank) then
				return true
			end
			--Riptide mainTank
			local rtValue, rtEnabled = GetSetting("RiptideTank")
			if rtEnabled
			and not ni.unit.buff(mainTank, spells.Riptide.id, "player")
			and ni.unit.hp(mainTank) <= rtValue
			and ValidUsable(spells.Riptide.id, mainTank)
			and LosCast(spells.Riptide.name, mainTank) then
				return true
			end
			--HealingSurge mainTank
			local hsValue, hsEnabled = GetSetting("HealingSurgeTank")
			if hsEnabled
			and not ni.player.ismoving()
			and ni.unit.hp(mainTank) <= hsValue
			and ValidUsable(spells.HealingSurge.id, mainTank)
			and LosCast(spells.HealingSurge.name, mainTank) then
				return true
			end
			--offTank
			if offTank ~= nil
			and ni.unit.exists(offTank) then
				--EarthShield offTank
				local esO, _, _, esOCount, _, _, esOTime = ni.unit.buff(mainTank, spells.EarthShield.id, "player")
				if (not esO
				or esOCount < 2
				or esOTime - GetTime() < 2)
				and esTar == 2
				and ValidUsable(spells.EarthShield.id, offTank)
				and LosCast(spells.EarthShield.name, offTank) then
					return true
				end
				--Riptide offTank
				if rtEnabled
				and ni.unit.hp(offTank) <= rtValue
				and not ni.unit.buff(offTank, spells.Riptide.id, "player")
				and ValidUsable(spells.Riptide.id, offTank)
				and LosCast(spells.Riptide.name, offTank) then
					return true
				end
				--HealingSurge offTank
				if hsEnabled
				and not ni.player.ismoving()
				and ni.unit.hp(offTank) <= hsValue
				and ValidUsable(spells.HealingSurge.id, mainTank)
				and LosCast(spells.HealingSurge.name, mainTank) then
					return true
			end
			end
		end
	end,
	["Riptide"] = function()
		local value = GetSetting("RiptideHP")
		  for i = 1, #ni.members do
		   if ni.members[i].hp <= value
		    and not ni.unit.buff(ni.members[i].unit, spells.Riptide.id, "player")
			and ValidUsable(spells.Riptide.id, ni.members[i].unit)
			and LosCast(spells.Riptide.name, ni.members[i].unit) then
					return true
				end
			end
	end,
	["HealingStreamTotem"] = function()
		if not HasTotem(waterSlot)
		and ni.spell.available(spells.HealingStreamTotem.id)
		and #ni.members.inrangebelow("player", 40, 95) >= 1 then
			ni.spell.cast(spells.HealingStreamTotem.name)
		end
	end,
	["HealingSurge"] = function()
		local value = GetSetting("HealingSurgeHP")
		if not ni.player.ismoving() then
		  for i = 1, #ni.members do
		   if ni.members[i].hp <= value
			and ValidUsable(spells.HealingSurge.id, ni.members[i].unit)
			and LosCast(spells.HealingSurge.name, ni.members[i].unit) then
					return true
				end
			end
		end
	end,
	["HealingWave"] = function()
		local value = GetSetting("HealingWaveHP")
		if not ni.player.ismoving() then
		  for i = 1, #ni.members do
		   if ni.members[i].hp <= value
			and ValidUsable(spells.HealingWave.id, ni.members[i].unit)
			and LosCast(spells.HealingWave.name, ni.members[i].unit) then
					return true
				end
			end
		end
	end,
	["ChainHeal"] = function()
		local value = GetSetting("ChainHealHP")
		if ni.spell.available(spells.ChainHeal) then
				GetTableForBestUnit(value, 10, 3);
				if #customtable > 0 then
					if customtable[1].unitsclose >= 3
					 and ValidUsable( spells.ChainHeal.id, customtable[1].unit) then
						if customtable[1].hp <= value then
							LosCast(spells.ChainHeal.name, customtable[1].unit);
							return true;
						end
					end
				end
			end
	end,
	["LightningBolt"] = function()
		local _, enabled = GetSetting("LightningBolt")
		if	enabled
			and UnitExists("target")
		 	and UnitCanAttack("player", "target")
		 	and not UnitIsDeadOrGhost("target")
		 	and UnitAffectingCombat("player", "target") then
				ni.spell.cast(spells.LightningBolt.name, "target")
				return true
		end
	end,
}
ni.bootstrap.profile("Restro_MOP", queue, abilities, OnLoad, OnUnload);
