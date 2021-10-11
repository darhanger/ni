local queue = {
	"Pause",
	"StanceoftheSturdyOx",
	"LegacyoftheEmperor",
	"PurifyingBrew",
	"SpearHandStrike",
	"Guard",
	"TouchofDeath",
	"KegSmash",
	"BlackoutKick",
	"TigerPalm",
	"BreathofFire",
	"ExpelHarm",
	"SpinningCraneKick",
	"ChiWave",
	"Jab",
	"AutoAttack"
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
	settingsfile = "BrewNuok.xml",
	callback = GUICallback,
	{type = "separator"},
	{type = "title", text = "Brewmaster"},
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
	ni.combatlog.registerhandler("Brewmaster", CombatEventCatcher)
	ni.GUI.AddFrame("Brewmaster", items)
end
local function OnUnload()
	ni.combatlog.unregisterhandler("Brewmaster")
	ni.GUI.DestroyFrame("Brewmaster")
end

local spells = {
	--General 0
AutoAttack = {id = 6603, name = GetSpellInfo(6603)},
QuakingPalm = {id = 107079, name = GetSpellInfo(107079)},
ArmorSkills = {id = 106904, name = GetSpellInfo(106904)},
BattleFatigue = {id = 134732, name = GetSpellInfo(134732)},
Bouncy = {id = 107076, name = GetSpellInfo(107076)},
Epicurean = {id = 107072, name = GetSpellInfo(107072)},
ExpertRiding = {id = 34090, name = GetSpellInfo(34090)},
Gourmand = {id = 107073, name = GetSpellInfo(107073)},
InnerPeace = {id = 107074, name = GetSpellInfo(107074)},
Languages = {id = 143369, name = GetSpellInfo(143369)},
WeaponSkills = {id = 106902, name = GetSpellInfo(106902)},
FlightMastersLicense = {id = 90267, name = GetSpellInfo(90267)},
ColdWeatherFlying = {id = 54197, name = GetSpellInfo(54197)},
ArtisanRiding = {id = 34091, name = GetSpellInfo(34091)},
MasterRiding = {id = 90265, name = GetSpellInfo(90265)},
CloudSerpentRiding = {id = 130487, name = GetSpellInfo(130487)},
WisdomoftheFourWinds = {id = 115913, name = GetSpellInfo(115913)},
--Brewmaster 0
AvertHarm = {id = 115213, name = GetSpellInfo(115213)},
BlackoutKick = {id = 100784, name = GetSpellInfo(100784)},
BreathofFire = {id = 115181, name = GetSpellInfo(115181)},
ChiWave = {id = 115098, name = GetSpellInfo(115098)},
Clash = {id = 122057, name = GetSpellInfo(122057)},
CracklingJadeLightning = {id = 117952, name = GetSpellInfo(117952)},
Detox = {id = 115450, name = GetSpellInfo(115450)},
Disable = {id = 116095, name = GetSpellInfo(116095)},
DizzyingHaze = {id = 115180, name = GetSpellInfo(115180)},
ElusiveBrew = {id = 115308, name = GetSpellInfo(115308)},
ExpelHarm = {id = 115072, name = GetSpellInfo(115072)},
FortifyingBrew = {id = 115203, name = GetSpellInfo(115203)},
GrappleWeapon = {id = 117368, name = GetSpellInfo(117368)},
Guard = {id = 115295, name = GetSpellInfo(115295)},
HealingSphere = {id = 115460, name = GetSpellInfo(115460)},
Jab = {id = 100780, name = GetSpellInfo(100780)},
KegSmash = {id = 121253, name = GetSpellInfo(121253)},
LegSweep = {id = 119381, name = GetSpellInfo(119381)},
LegacyoftheEmperor = {id = 115921, name = GetSpellInfo(115921)},
NimbleBrew = {id = 137562, name = GetSpellInfo(137562)},
Paralysis = {id = 115078, name = GetSpellInfo(115078)},
Provoke = {id = 115546, name = GetSpellInfo(115546)},
Resuscitate = {id = 115178, name = GetSpellInfo(115178)},
Roll = {id = 109132, name = GetSpellInfo(109132)},
SpearHandStrike = {id = 116705, name = GetSpellInfo(116705)},
SpinningCraneKick = {id = 101546, name = GetSpellInfo(101546)},
StanceoftheFierceTiger = {id = 103985, name = GetSpellInfo(103985)},
StanceoftheSturdyOx = {id = 115069, name = GetSpellInfo(115069)},
TigerPalm = {id = 100787, name = GetSpellInfo(100787)},
TouchofDeath = {id = 115080, name = GetSpellInfo(115080)},
ZenPilgrimage = {id = 126892, name = GetSpellInfo(126892)},
Ascension = {id = 115396, name = GetSpellInfo(115396)},
BrewingElusiveBrew = {id = 128938, name = GetSpellInfo(128938)},
BrewmasterTraining = {id = 117967, name = GetSpellInfo(117967)},
DesperateMeasures = {id = 126060, name = GetSpellInfo(126060)},
DualWield = {id = 124146, name = GetSpellInfo(124146)},
FightingStyle = {id = 115074, name = GetSpellInfo(115074)},
GiftoftheOx = {id = 124502, name = GetSpellInfo(124502)},
LeatherSpecialization = {id = 120225, name = GetSpellInfo(120225)},
Momentum = {id = 115174, name = GetSpellInfo(115174)},
Parry = {id = 116812, name = GetSpellInfo(116812)},
SwiftReflexes = {id = 124334, name = GetSpellInfo(124334)},
Vengeance = {id = 120267, name = GetSpellInfo(120267)},
WayoftheMonk = {id = 120277, name = GetSpellInfo(120277)},
SummonBlackOxStatue = {id = 115315, name = GetSpellInfo(115315)},
PurifyingBrew = {id = 119582, name = GetSpellInfo(119582)},
MasteryElusiveBrawler = {id = 117906, name = GetSpellInfo(117906)},
ZenMeditation = {id = 115176, name = GetSpellInfo(115176)},
Transcendence = {id = 101643, name = GetSpellInfo(101643)},
TranscendenceTransfer = {id = 119996, name = GetSpellInfo(119996)},
--Mistweaver 270
--Windwalker 269
--Talents
Celerity = {id = nil, name = GetSpellInfo(nil)},
TigersLust = {id = nil, name = GetSpellInfo(nil)},
ZenSphere = {id = nil, name = GetSpellInfo(nil)},
ChiBurst = {id = nil, name = GetSpellInfo(nil)},
PowerStrikes = {id = nil, name = GetSpellInfo(nil)},
ChiBrew = {id = nil, name = GetSpellInfo(nil)},
RingofPeace = {id = nil, name = GetSpellInfo(nil)},
ChargingOxWave = {id = nil, name = GetSpellInfo(nil)},
HealingElixirs = {id = nil, name = GetSpellInfo(nil)},
DampenHarm = {id = nil, name = GetSpellInfo(nil)},
DiffuseMagic = {id = nil, name = GetSpellInfo(nil)},
RushingJadeWind = {id = nil, name = GetSpellInfo(nil)},
InvokeXuentheWhiteTiger = {id = nil, name = GetSpellInfo(nil)},
ChiTorpedo = {id = nil, name = GetSpellInfo(nil)},
--Glyph
}

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

local Shuffle, TigerPower, PowerGuard, DeathNote, ElusiveBrewStacks, SanctuaryoftheOx = 115307, 125359, 118636, 121125, 128939, 126119

local LightStagger, ModerateStagger, HeavyStagger = 124275, 124274, 124273

local abilities = {
	["Pause"] = function()
		if
			IsMounted() or UnitIsDeadOrGhost("player") or not UnitExists("target") or UnitIsDeadOrGhost("target") or
				(UnitExists("target") and not UnitCanAttack("player", "target"))
		 then
			return true
		end
	end,
	["AutoAttack"] = function()
		if not IsCurrentSpell(spells.AutoAttack.id) then
			ni.spell.cast(spells.AutoAttack.id)
		end
	end,
	["StanceoftheSturdyOx"] = function()
		if not ni.player.buff(spells.StanceoftheSturdyOx.name) and ni.spell.available(spells.StanceoftheSturdyOx.name) then
			ni.spell.cast(spells.StanceoftheSturdyOx.name)
		end
	end,
	["SpearHandStrike"] = function()
		if
			ni.spell.shouldinterrupt("target") and ValidUsable(spells.SpearHandStrike.id, "target") and
				FacingLosCast(spells.SpearHandStrike.name, "target")
		 then
			return true
		end
	end,
	["KegSmash"] = function()
		if
			ni.player.powerraw("chi") <= 3 and ValidUsable(spells.KegSmash.id, "target") and
				FacingLosCast(spells.KegSmash.name, "target")
		 then
			return true
		end
	end,
	["TouchofDeath"] = function()
		if
			ni.player.buff(DeathNote) and ValidUsable(spells.TouchofDeath.id, "target") and
				FacingLosCast(spells.TouchofDeath.name, "target")
		 then
			return true
		end
	end,
	["TigerPalm"] = function()
		if
			(ni.player.buffremaining(TigerPower) < 3 or ni.player.buffremaining(PowerGuard) < 3) and
				ValidUsable(spells.TigerPalm.id, "target") and
				FacingLosCast(spells.TigerPalm.name, "target") and
				ni.player.buffremaining(Shuffle) > 2
		 then
			return true
		end
	end,
	["BreathofFire"] = function()
		if
			not ni.unit.debuff("target", spells.BreathofFire.name, "player") and ni.spell.available(spells.BreathofFire.name) and
				ni.player.isfacing("target", 90) and
				IsSpellInRange(spells.KegSmash.name, "target") == 1 and
				ni.unit.debuff("target", spells.DizzyingHaze.name) and
				ni.player.powerraw(12) >= 3 and
				ni.player.buffremaining(Shuffle) > 2
		 then
			ni.spell.cast(spells.BreathofFire.name)
			return true
		end
	end,
	["BlackoutKick"] = function()
		if
			(ni.player.powerraw("chi") >= 3 or ni.player.buffremaining(Shuffle) < 2) and
				ValidUsable(spells.BlackoutKick.id, "target") and
				FacingLosCast(spells.BlackoutKick.name, "target")
		 then
			return true
		end
	end,
	["ChiWave"] = function()
		if ValidUsable(spells.ChiWave.id, "target") and FacingLosCast(spells.ChiWave.name, "target") then
			return true
		end
	end,
	["Jab"] = function()
		if
			ni.player.power("energy") >= 55 and ni.spell.cd(spells.KegSmash.id) > 1.5 and ValidUsable(spells.Jab.id, "target") and
				FacingLosCast(spells.Jab.name, "target")
		 then
			return true
		end
	end,
	["ExpelHarm"] = function()
		if
			ni.player.hp() < 95 and ni.player.power("energy") >= 50 and ni.spell.available(spells.ExpelHarm.id) and
				IsSpellInRange(spells.KegSmash.name, "target") == 1
		 then
			ni.spell.cast(spells.ExpelHarm.name, "player")
			return true
		end
	end,
	["Guard"] = function()
		if ni.player.hp() < 90 and ni.spell.available(spells.Guard.id) and IsSpellInRange(spells.KegSmash.name, "target") == 1 then
			ni.spell.cast(spells.Guard.name, "player")
			return true
		end
	end,
	["RushingJadeWind"] = function()
		if
			ActiveEnemies() >= 2 and ni.spell.available(spells.RushingJadeWind.id) and
				ni.spell.cast(spells.RushingJadeWind.name, "player")
		 then
			return true
		end
	end,
	["SpinningCraneKick"] = function()
		if
			ActiveEnemies() >= 2 and ni.player.buffremaining(Shuffle) > 2 and ni.spell.available(spells.SpinningCraneKick.id) and
				ni.spell.cast(spells.SpinningCraneKick.name, "player")
		 then
			return true
		end
	end,
	["PurifyingBrew"] = function()
		if ni.player.debuff(HeavyStagger) and ni.spell.available(spells.PurifyingBrew.id) then
			ni.spell.cast(spells.PurifyingBrew.id)
		end
	end,
	["LegacyoftheEmperor"] = function()
		if ni.spell.available(spells.LegacyoftheEmperor.id) and not ni.player.buffs("115921||20217||1126||90363") then
			ni.spell.cast(spells.LegacyoftheEmperor.name, "player")
			return true
		end
	end
}
ni.bootstrap.profile("Brew-Nuok", queue, abilities, OnLoad, OnUnload)
