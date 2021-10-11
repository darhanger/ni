local queue = {
	"Pause",
	"BloodPresence",
	"Cache",
	"BoneShield",
	"DeathandDecay",
	"Outbreak",
	"IcyTouch",
	"PlagueStrike",
	"DeathStrike",
	"HeartStrike",
	"RuneStrike",
}
local enables =
{
}
local values =
{
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
	settingsfile = "blood_cata.xml",
	callback = GUICallback,
	{ type = "title", text = "Blood DK Cata" },
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
	ni.combatlog.registerhandler("Prot-Cata", CombatEventCatcher);
	ni.GUI.AddFrame("Prot-Cata", items);
end
local function OnUnload()
	ni.combatlog.unregisterhandler("Prot-Cata");
	ni.GUI.DestroyFrame("Prot-Cata");
end

local spells = {
--Blood
BloodBoil = {id = 48721, name = GetSpellInfo(48721)},
BloodPresence = {id = 48263, name = GetSpellInfo(48263)},
BloodStrike = {id = 45902, name = GetSpellInfo(45902)},
BoneShield = {id = 49222, name = GetSpellInfo(49222)},
DeathStrike = {id = 49998, name = GetSpellInfo(49998)},
HeartStrike = {id = 55050, name = GetSpellInfo(55050)},
Pestilence = {id = 50842, name = GetSpellInfo(50842)},
RuneTap = {id = 48982, name = GetSpellInfo(48982)},
VampiricBlood = {id = 55233, name = GetSpellInfo(55233)},
Strangulate = {id = 47476, name = GetSpellInfo(47476)},
BloodTap = {id = 45529, name = GetSpellInfo(45529)},
DarkCommand = {id = 56222, name = GetSpellInfo(56222)},
DeathPact = {id = 48743, name = GetSpellInfo(48743)},
DarkSimulacrum = {id = 77606, name = GetSpellInfo(77606)},
--Frost
FrostPresence = {id = 48266, name = GetSpellInfo(48266)},
IcyTouch = {id = 45477, name = GetSpellInfo(45477)},
MindFreeze = {id = 47528, name = GetSpellInfo(47528)},
ChainsofIce = {id = 45524, name = GetSpellInfo(45524)},
Obliterate = {id = 49020, name = GetSpellInfo(49020)},
PathofFrost = {id = 3714, name = GetSpellInfo(3714)},
IceboundFortitude = {id = 48792, name = GetSpellInfo(48792)},
FesteringStrike = {id = 85948, name = GetSpellInfo(85948)},
HornofWinter = {id = 57330, name = GetSpellInfo(57330)},
RuneStrike = {id = 56815, name = GetSpellInfo(56815)},
EmpowerRuneWeapon = {id = 47568, name = GetSpellInfo(47568)},
--Unholy
DeathandDecay = {id = 43265, name = GetSpellInfo(43265)},
DeathCoil = {id = 47541, name = GetSpellInfo(47541)},
DeathGrip = {id = 49576, name = GetSpellInfo(49576)},
PlagueStrike = {id = 45462, name = GetSpellInfo(45462)},
RaiseDead = {id = 46584, name = GetSpellInfo(46584)},
AntiMagicShell = {id = 48707, name = GetSpellInfo(48707)},
UnholyPresence = {id = 48265, name = GetSpellInfo(48265)},
RaiseAlly = {id = 61999, name = GetSpellInfo(61999)},
ArmyoftheDead = {id = 42650, name = GetSpellInfo(42650)},
Outbreak = {id = 77575, name = GetSpellInfo(77575)},
NecroticStrike = {id = 73975, name = GetSpellInfo(73975)},
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
		ni.debug.log(string.format("Casting %s on %s", spell, tar))
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

local BloodPlauge, FrostFever, targets = 0, 0;

local abilities = {
	["Pause"] = function()
		if IsMounted()
			or UnitIsDeadOrGhost("player")
			or not UnitExists("target")
			or UnitIsDeadOrGhost("target")
			or (UnitExists("target") and not UnitCanAttack("player", "target")) then
			return true
		end
	end,
	["Cache"] = function()
		BloodPlauge = ni.unit.debuffremaining("target", 55078, "player")
		FrostFever = ni.unit.debuffremaining("target", 55095, "player")
		targets = ni.unit.enemiesinrange("target", 10)
	end,
	["Outbreak"]= function()
		if BloodPlauge <= 2
		and FrostFever <= 2
		and ValidUsable(spells.Outbreak.id, "target")
		and FacingLosCast(spells.Outbreak.name, "target") then
				return true
		end
	end,
	["IcyTouch"] = function()
			if FrostFever <= 2
			and ValidUsable(spells.IcyTouch.id, "target")
			and FacingLosCast(spells.IcyTouch.name, "target") then
					return true
			end
	end,
	["PlagueStrike"] = function()
		if BloodPlauge <= 2
		and ValidUsable(spells.PlagueStrike.id, "target")
		and FacingLosCast(spells.PlagueStrike.name, "target") then
				return true
		end
	end,
	["DeathStrike"] = function()
		if ValidUsable(spells.DeathStrike.id, "target")
		and FacingLosCast(spells.DeathStrike.name, "target") then
				return true
		end
	end,
	["HeartStrike"] = function()
		if ValidUsable(spells.HeartStrike.id, "target")
		and ni.rune.bloodruneav() >= 1
		and FacingLosCast(spells.HeartStrike.name, "target") then
				return true
		end
	end,
	["RuneStrike"] = function()
		if ValidUsable(spells.RuneStrike.id, "target")
		and FacingLosCast(spells.RuneStrike.name, "target") then
				return true
		end
	end,
	["BoneShield"] = function()
			if ni.spell.available(spells.BoneShield.id)
			and not ni.player.buff(spells.BoneShield.id)
			and ni.rune.bloodruneav() >= 1 then
					ni.spell.cast(spells.BoneShield.name)
					return true
			end
	end,
	["BloodPresence"] = function()
		if ni.spell.available(spells.BloodPresence.id)
		and not ni.player.buff(spells.BloodPresence.id) then
				ni.spell.cast(spells.BoneShield.name)
				return true
		end
end,
	["DeathandDecay"] = function()
		if ni.spell.available(spells.DeathandDecay.id)
		and #targets >= 2 then
				ni.spell.castat(spells.DeathandDecay.name, "target")
				return true
		end
end,
["Pestilence"] = function()
	if ValidUsable(spells.Pestilence.id, "target")
	and #targets >= 2
	then
		for k, v in ipairs(enemies) do
	end
end
end,

}
ni.bootstrap.profile("Blood - Cata", queue, abilities, OnLoad, OnUnload);
