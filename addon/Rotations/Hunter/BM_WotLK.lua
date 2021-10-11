local queue = {
	"FeedPet",
	"Pause",
	"Cache",
	"AspectoftheHawk",
	"AspectoftheViper",
	"PetControl",
	"Intimidation",
	"Volley",
	"HuntersMark",
	"BestialWrath",
	"KillCommand",
	"KillShot",
	"SerpentSting",
	"ConcussiveShot",
	"ArcaneShot",
	"MultiShot",
	"SteadyShot",
	"RaptorStrike",
	"MongooseBite",
	"AutoAttack",
}
local enables = {
	["ConcussiveShot"] = false,
	["MultiShot"] = false,
	["Volley"] = true,
	["Intimidation"] = false,
}
local values = {
	["PetFood"] = 0,
	["Volley"]= 4,
}
local inputs = {
}
local menus = {
}
local function GUICallback(key, item_type, value)
	if item_type == "enabled" then
		enables[key] = value;
	elseif item_type == "value" then
		values[key] = value;
	elseif item_type == "input" then
		inputs[key] = value;
	elseif item_type == "menu" then
		menus[key] = value;
	end
end
local items = {
	settingsfile = "BM_WotLK.xml",
	callback = GUICallback,
	{ type = "title", text = "BM WotLK" },
	{ type = "separator" },
	{
		type = "entry",
		text = "Concussive Shot",
		tooltip = "Use Concussive Shot",
		enabled = enables["ConcussiveShot"],
		key = "ConcussiveShot"
	},
	{
		type = "entry",
		text = "Multi Shot",
		tooltip = "Use Multi Shot",
		enabled = enables["MultiShot"],
		key = "MultiShot"
	},
	{
		type = "entry",
		text = "Volley",
		tooltip = "Volley AoE Count",
		enabled = enables["Volley"],
		value = values["Volley"],
		key = "Volley"
	},
	{
		type = "entry",
		text = "Pet Food Id",
		tooltip = "Id of food to feed your pet",
		value = values["PetFood"],
		key = "PetFood"
	},
	{
		type = "entry",
		text = "Intimidation",
		tooltip = "Use Intimidation",
		enabled = enables["Intimidation"],
		key = "Intimidation"
	},
};
local incombat = false;
local function CombatEventCatcher(event, ...)
	if event == "PLAYER_REGEN_DISABLED" then
		incombat = true;
	elseif event == "PLAYER_REGEN_ENABLED" then
		incombat = false;
	end
end
local function OnLoad()
	ni.combatlog.registerhandler("BM_WOTLK", CombatEventCatcher);
	ni.GUI.AddFrame("BM_WOTLK", items);
end
local function OnUnload()
	ni.combatlog.unregisterhandler("BM_WOTLK");
	ni.GUI.DestroyFrame("BM_WOTLK");
end

local spells = {
--General
AutoAttack = {id = 6603, name = GetSpellInfo(6603)},
Throw = {id = 2764, name = GetSpellInfo(2764)},
Berserking = {id = 26297, name = GetSpellInfo(26297)},
--Beast Mastery
MendPet = {id = 13543, name = GetSpellInfo(13543)},
AspectoftheMonkey = {id = 13163, name = GetSpellInfo(13163)},
CallPet = {id = 883, name = GetSpellInfo(883)},
DismissPet = {id = 2641, name = GetSpellInfo(2641)},
AspectoftheHawk = {id = 27044, name = GetSpellInfo(27044)},
TameBeast = {id = 1515, name = GetSpellInfo(1515)},
EyesoftheBeast = {id = 1002, name = GetSpellInfo(1002)},
Intimidation = {id = 19577, name = GetSpellInfo(19577)},
ScareBeast = {id = 1513, name = GetSpellInfo(1513)},
AspectoftheCheetah = {id = 5118, name = GetSpellInfo(5118)},
EagleEye = {id = 6197, name = GetSpellInfo(6197)},
KillCommand = {id = 34026, name = GetSpellInfo(34026)},
FeedPet = {id = 6991, name = GetSpellInfo(6991)},
RevivePet = {id = 982, name = GetSpellInfo(982)},
AspectoftheViper = {id = 34074, name = GetSpellInfo(34074)},
BestialWrath = {id = 19574, name = GetSpellInfo(19574)},
--Marksmanship
Volley = {id = 27022, name = GetSpellInfo(27022)},
MultiShot = {id = 27021, name = GetSpellInfo(27021)},
SteadyShot = {id = 34120, name = GetSpellInfo(34120)},
ConcussiveShot = {id = 5116, name = GetSpellInfo(5116)},
HuntersMark = {id = 14325, name = GetSpellInfo(14325)},
RapidFire = {id = 3045, name = GetSpellInfo(3045)},
AutoShot = {id = 75, name = GetSpellInfo(75)},
ArcaneShot = {id = 14287, name = GetSpellInfo(14287)},
SerpentSting = {id = 27016, name = GetSpellInfo(27016)},
DistractingShot = {id = 20736, name = GetSpellInfo(20736)},
--Survival
Disengage = {id = 781, name = GetSpellInfo(781)},
TrackHumanoids = {id = 19883, name = GetSpellInfo(19883)},
MongooseBite = {id = 14270, name = GetSpellInfo(14270)},
FreezingTrap = {id = 1499, name = GetSpellInfo(1499)},
TrackUndead = {id = 19884, name = GetSpellInfo(19884)},
TrackBeasts = {id = 1494, name = GetSpellInfo(1494)},
WingClip = {id = 2974, name = GetSpellInfo(2974)},
RaptorStrike = {id = 14261, name = GetSpellInfo(14261)},
Deterrence = {id = 19263, name = GetSpellInfo(19263)},
ImmolationTrap = {id = 13795, name = GetSpellInfo(13795)},
ExplosiveTrap = {id = 13813, name = GetSpellInfo(13813)},
FeignDeath = {id = 5384, name = GetSpellInfo(5384)},

PetGrowl = {id = 27047, name = GetSpellInfo(27047)},
}

local lastSpell, lastGuid, lastTime = "", "", 0
local function FacingLosCast(spell, tar)
	if ni.player.isfacing(tar, 145) and ni.player.los(tar) and IsSpellInRange(spell, tar) == 1 then
		ni.spell.cast(spell, tar)
		ni.debug.log(string.format("Casting %s on %s", spell, tar))
		lastSpell = spell
		lastGuid = UnitGUID(tar)
		lastTime = GetTime()
		return true
	end
	return false
end
local function DoubleCast(spell, tar)
		if(lastSpell == spell) then
			if lastGuid == UnitGUID(tar) then
				if GetTime() - lastTime < 2 then
					return true
				end
			end
		end
		return false
end

local function ValidUsable(id, tar)
	if ni.spell.available(id) and ni.spell.valid(tar, id, true, true) then
		return true
	end
	return false
end

local function InRange(tar)
	local melee = IsSpellInRange(spells.MongooseBite.name, tar) == 1
	local ranged = IsSpellInRange(spells.ArcaneShot.name, tar) == 1
	if not melee and ranged then
			return true;
	end
	return false
end

local function PetInRange(tar)
	if UnitExists("pet") then
		if IsSpellInRange(spells.PetGrowl.name, "pettarget") then
			return true
		end
	end
	return false
end

local _petInRange = false
local _playerInRange = false

local abilities = {
	["Pause"] = function()
		if IsMounted()
			or UnitIsDeadOrGhost("player")
			or not UnitExists("target")
			or UnitIsDeadOrGhost("target")
			or (UnitExists("target")
			and not UnitCanAttack("player", "target")) then
			return true
		end
	end,
	["Cache"] = function()
		_petInRange = PetInRange("target")
		_playerInRange = InRange("target")
	end,
	["AutoAttack"] = function()
		if not IsCurrentSpell(6603) and not IsCurrentSpell(75) then
			ni.spell.cast(75)
		end
	end,
	["RaptorStrike"] = function()
		if ValidUsable(spells.RaptorStrike.id, "target")
		and IsSpellInRange(spells.MongooseBite.name, "target") == 1
		and not DoubleCast(spells.RaptorStrike.name, "target")
		and FacingLosCast(spells.RaptorStrike.name, "target") then
				return false
		end
	end,
	["MongooseBite"] = function()
		if ValidUsable(spells.MongooseBite.id, "target")
		and IsSpellInRange(spells.MongooseBite.name, "target") == 1
		and FacingLosCast(spells.MongooseBite.name, "target") then
				return true
		end
	end,
	["HuntersMark"] = function()
		if ValidUsable(spells.HuntersMark.id, "target")
		and ni.unit.debuffremaining("target", spells.HuntersMark.id) <= 2
		and not DoubleCast(spells.HuntersMark.name, "target")
		and FacingLosCast(spells.HuntersMark.name, "target") then
				return true
		end
	end,
	["SerpentSting"] = function()
		if ValidUsable(spells.SerpentSting.id, "target")
		and _playerInRange
		and ni.unit.debuffremaining("target", spells.SerpentSting.id, "player") <= 2
		and not DoubleCast(spells.SerpentSting.name, "target")
		and FacingLosCast(spells.SerpentSting.name, "target") then
				return true
		end
	end,
	["ArcaneShot"] = function()
		if ValidUsable(spells.ArcaneShot.id, "target")
		and _playerInRange
		and FacingLosCast(spells.ArcaneShot.name, "target") then
				return true
		end
	end,
	["MultiShot"] = function()
		if enables["MultiShot"]
		and ValidUsable(spells.MultiShot.id, "target")
		and _playerInRange
		and not ni.player.ismoving()
		and FacingLosCast(spells.MultiShot.name, "target") then
				return true
		end
	end,
	["ConcussiveShot"]= function()
		if enables["ConcussiveShot"]
		and ValidUsable(spells.ConcussiveShot.id, "target")
		and _playerInRange
		and FacingLosCast(spells.ConcussiveShot.name, "target") then
				return true
		end
	end,
	["Intimidation"]= function()
		if enables["Intimidation"]
		and ni.spell.available(spells.Intimidation.id)
		and _petInRange
		and (UnitGUID("player") == UnitGUID("playertargettarget")) then
			ni.spell.cast(spells.Intimidation.name)
			return true
		end
	end,
	["AspectoftheHawk"] = function()
		if ni.player.power("mana") > 80
		and ni.spell.available(spells.AspectoftheHawk.id)
		and not ni.player.buff(spells.AspectoftheHawk.id) then
			ni.spell.cast(spells.AspectoftheHawk.name)
		end
	end,
	["Volley"] = function()
		if enables["Volley"] then
			local nearby = #ni.unit.enemiesinrange("target", 8)
			local n = UnitChannelInfo("player")
			if n ~= nil and n == spells.Volley.name
			and nearby >= values["Volley"] then
				return true
				end
			if ni.spell.available(spells.Volley.id)
			and _playerInRange
			and nearby >= values["Volley"] then
				ni.spell.castat(spells.Volley.name, "target", 1)
				return true
				end
		end
	end,
	["BestialWrath"] = function()
		if ni.spell.available(spells.BestialWrath.id)
		and ni.player.buff(spells.AspectoftheHawk.id)
		and _playerInRange and _petInRange then
			ni.spell.cast(spells.BestialWrath.name)
			return true
			end
	end,
	["KillCommand"] = function()
		if ni.spell.available(spells.KillCommand.id)
		and ni.player.buff(spells.AspectoftheHawk.id)
		and _petInRange then
			ni.spell.cast(spells.KillCommand.name)
			return true
			end
	end,
	--Need to update spells when I get them
	["KillShot"] = function()
			if ValidUsable(61006, "target")
			and _playerInRange
			and FacingLosCast("Kill Shot", "target") then
				return true
				end
	end,
	["SteadyShot"] = function()
		if ValidUsable(spells.SteadyShot.id, "target")
		and _playerInRange
		and not ni.player.ismoving()
		and FacingLosCast(spells.SteadyShot.name, "target") then
			return true
			end
	end,
	["AspectoftheViper"] = function()
		if ni.player.power("mana") < 20
		and ni.spell.available(spells.AspectoftheViper.id)
		and not ni.player.buff(spells.AspectoftheViper.id) then
			ni.spell.cast(spells.AspectoftheViper.name)
		end
	end,

	--Pet Control
	["PetControl"] = function()
			if UnitExists("pet")
			and not UnitIsDeadOrGhost("pet") then
			
					--Attack the same unit as player
					local petTarget = UnitGUID("pettarget")
					local playerTarget = UnitGUID("target")
					if petTarget ~= playerTarget then
						ni.player.runtext("/petattack")
					end
					-- MendPet
					if ni.unit.hp("pet") < 70
					and not ni.unit.buff("pet", spells.MendPet.id)
					and IsSpellInRange(spells.MendPet.name, "pet")
					and ni.spell.available(spells.MendPet.id) then
							ni.spell.cast(spells.MendPet.name)
							return true
					end
			end
	end,
	["FeedPet"] = function()
		if not incombat
		and UnitExists("pet")
		and not UnitIsDeadOrGhost("pet")
		and IsSpellInRange(spells.FeedPet.name, "pet") then
			local happiness = GetPetHappiness()
			local foodId = values["PetFood"]
			if happiness ~= 3
			and foodId ~= 0
			and ni.player.hasitem(foodId)
			and not ni.unit.buff("pet", 1539) then
				local name = GetItemInfo(foodId)
				if(name ~= nil) then
					ni.spell.cast(spells.FeedPet.name)
					ni.player.runtext(string.format("/use %s", name))
				end
			end
		end
	end,
}
ni.bootstrap.profile("BM_WotLK", queue, abilities, OnLoad, OnUnload);
