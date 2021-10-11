local queue = {
	"Pause",
	"KegSmash",
	"RushingJadeWind",
	"TigerPalm",
	"SpinningCraneKick",
	"BlackoutKick",
	"ExpelHarm",
	"Jab"
}
local items = {
	settingsfile = "BrewNuok.xml",
	{ type = "separator" },
	{ type = "title", text = "Brewmaster" },
	{ type = "separator" },
};

local Shuffle = 115307;

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
	ni.combatlog.registerhandler("Brewmaster", CombatEventCatcher);
	ni.GUI.AddFrame("Brewmastert", items);
end
local function OnUnload()
	ni.combatlog.unregisterhandler("Brewmaster");
	ni.GUI.DestroyFrame("Brewmaster");
end

local spells = {
--Brewmaster
BlackoutKick = {id = 100784, name = GetSpellInfo(100784)},
DizzyingHaze = {id = 115180, name = GetSpellInfo(115180)},
Jab = {id = 100780, name = GetSpellInfo(100780)},
KegSmash = {id = 121253, name = GetSpellInfo(121253)},
Roll = {id = 109132, name = GetSpellInfo(109132)},
StanceoftheFierceTiger = {id = 103985, name = GetSpellInfo(103985)},
StanceoftheSturdyOx = {id = 115069, name = GetSpellInfo(115069)},
TigerPalm = {id = 100787, name = GetSpellInfo(100787)},
DualWield = {id = 124146, name = GetSpellInfo(124146)},
FightingStyle = {id = 115074, name = GetSpellInfo(115074)},
Parry = {id = 116812, name = GetSpellInfo(116812)},
Vengeance = {id = 120267, name = GetSpellInfo(120267)},
WayoftheMonk = {id = 120277, name = GetSpellInfo(120277)},
Provoke = {id = 115546, name = GetSpellInfo(115546)},
BreathofFire = {id = 115181, name = GetSpellInfo(115181)},
Clash = {id = 122057, name = GetSpellInfo(122057)},
Resuscitate = {id = 115178, name = GetSpellInfo(115178)},
Detox = {id = 115450, name = GetSpellInfo(115450)},
ZenPilgrimage = {id = 126892, name = GetSpellInfo(126892)},
LegacyoftheEmperor = {id = 115921, name = GetSpellInfo(115921)},
TouchofDeath = {id = 115080, name = GetSpellInfo(115080)},
SwiftReflexes = {id = 124334, name = GetSpellInfo(124334)},
FortifyingBrew = {id = 115203, name = GetSpellInfo(115203)},
ExpelHarm = {id = 115072, name = GetSpellInfo(115072)},
Guard = {id = 115295, name = GetSpellInfo(115295)},
Disable = {id = 116095, name = GetSpellInfo(116095)},
NimbleBrew = {id = 137562, name = GetSpellInfo(137562)},
SpearHandStrike = {id = 116705, name = GetSpellInfo(116705)},
BrewmasterTraining = {id = 117967, name = GetSpellInfo(117967)},
ElusiveBrew = {id = 115308, name = GetSpellInfo(115308)},
BrewingElusiveBrew = {id = 128938, name = GetSpellInfo(128938)},
Paralysis = {id = 115078, name = GetSpellInfo(115078)},
DesperateMeasures = {id = 126060, name = GetSpellInfo(126060)},
SpinningCraneKick = {id = 101546, name = GetSpellInfo(101546)},
AvertHarm = {id = 115213, name = GetSpellInfo(115213)},
LeatherSpecialization = {id = 120225, name = GetSpellInfo(120225)},
CracklingJadeLightning = {id = 117952, name = GetSpellInfo(117952)},
GiftoftheOx = {id = 124502, name = GetSpellInfo(124502)},
HealingSphere = {id = 115460, name = GetSpellInfo(115460)},
GrappleWeapon = {id = 117368, name = GetSpellInfo(117368)},
SummonBlackOxStatue = {id = 115315, name = GetSpellInfo(115315)},
PurifyingBrew = {id = 119582, name = GetSpellInfo(119582)},
MasteryElusiveBrawler = {id = 117906, name = GetSpellInfo(117906)},
ZenMeditation = {id = 115176, name = GetSpellInfo(115176)},
Transcendence = {id = 101643, name = GetSpellInfo(101643)},
TranscendenceTransfer = {id = 119996, name = GetSpellInfo(119996)},
RushingJadeWind = {id = 116847, name = GetSpellInfo(116847)},
}

local enemies = {}

local function ActiveEnemies()
	table.wipe(enemies)
	enemies = ni.player.enemiesinrange(10)
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

local abilities = {
	["Pause"] = function()
		if
			IsMounted() or UnitIsDeadOrGhost("player") or not UnitExists("target") or UnitIsDeadOrGhost("target") or
				(UnitExists("target") and not UnitCanAttack("player", "target"))
		 then
			return true
		end
	end,
	["Auto Attack"] = function()
		if not IsCurrentSpell(6603) then
			ni.spell.cast(6603)
		end
	end,
	["KegSmash"] = function()
		if ni.player.powerraw("chi") < 3
		and ValidUsable(spells.KegSmash.id, "target")
		and FacingLosCast(spells.KegSmash.name, "target")
		then
			return true
		end
	end,
	["TigerPalm"] = function()
		if ni.player.buffremaining(125359) < 3
		and ValidUsable(spells.TigerPalm.id, "target")
		and FacingLosCast(spells.TigerPalm.name, "target")
		then
			return true
		end
	end,
	["BlackoutKick"] = function()
		if ValidUsable(spells.BlackoutKick.id, "target")
		and FacingLosCast(spells.BlackoutKick.name, "target")
		then
			return true
		end
	end,
	["Jab"] = function()
		if ni.player.power("energy") >= 60
		and ValidUsable(spells.Jab.id, "target")
		and FacingLosCast(spells.Jab.name, "target")
		then
			return true
		end
	end,
	["ExpelHarm"] = function()
		if ni.player.hp() < 90
		and ni.player.power("energy") >= 50
		and ni.spell.available(spells.ExpelHarm.id)
		and ni.spell.cast(spells.ExpelHarm.name, "player")
		then
			return true
		end
	end,
	["RushingJadeWind"] = function()
		if ActiveEnemies() >= 2
		and ni.spell.available(spells.RushingJadeWind.id)
		and ni.spell.cast(spells.RushingJadeWind.name, "player")
		then
			return true
		end
	end,
	["SpinningCraneKick"] = function()
		if ActiveEnemies() >= 2
		and ni.player.buffremaining(Shuffle) > 2
		and ni.spell.available(spells.SpinningCraneKick.id)
		and ni.spell.cast(spells.SpinningCraneKick.name, "player")
		then
			return true
		end
	end,

	--and ni.player.power("energy") >= 40 and ni.player.powerraw("chi") <= 3
}
ni.bootstrap.profile("Brew-Nuok", queue, abilities, OnLoad, OnUnload);
