local queue = {
	"Pause",
	"Cache",
	"Shadowform",
	"InnerFire",
	"VampiricEmbrace",
	"Shadowfiend",
	"VampiricTouch",
	"ShadowWordPain",
	"DevouringPlague",
	"MindBlast",
	"ShadowWordDeath",
	"Dispersion",
	"MindFlay",
}

local enables = {
	["Dispersion"] = true,
	["Shadowfiend"] = true,
}
local values = {
	["Dispersion"] = 30,
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
	settingsfile = "Shadow_WotLK.xml",
	callback = GUICallback,
	{ type = "title", text = "Shadow WotLK" },
	{
		type = "entry",
		text = "Dispersion",
		tooltip = "The mana pct before casting Dispersion",
		enabled = enables["Dispersion"],
		value = values["Dispersion"],
		key = "Dispersion"
	},
	{
		type = "entry",
		text = "Shadowfiend",
		tooltip = "Use Shadowfiend in combat",
		enabled = enables["Shadowfiend"],
		key = "Dispersion"
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
	ni.combatlog.registerhandler("Shadow_WotLK", CombatEventCatcher);
	ni.GUI.AddFrame("Shadow_WotLK", items);
end
local function OnUnload()
	ni.combatlog.unregisterhandler("Shadow_WotLK");
	ni.GUI.DestroyFrame("Shadow_WotLK");
end

local spells = {
--Discipline
PrayerofSpirit = {id = 48074, name = GetSpellInfo(48074)},
ManaBurn = {id = 8129, name = GetSpellInfo(8129)},
Levitate = {id = 1706, name = GetSpellInfo(1706)},
PowerWordFortitude = {id = 48161, name = GetSpellInfo(48161)},
ShackleUndead = {id = 10955, name = GetSpellInfo(10955)},
MassDispel = {id = 32375, name = GetSpellInfo(32375)},
PrayerofFortitude = {id = 48162, name = GetSpellInfo(48162)},
DivineSpirit = {id = 48073, name = GetSpellInfo(48073)},
FearWard = {id = 6346, name = GetSpellInfo(6346)},
PowerWordShield = {id = 48066, name = GetSpellInfo(48066)},
InnerFire = {id = 48168, name = GetSpellInfo(48168)},
DispelMagic = {id = 988, name = GetSpellInfo(988)},
--Holy
Renew = {id = 48068, name = GetSpellInfo(48068)},
PrayerofMending = {id = 48113, name = GetSpellInfo(48113)},
HolyNova = {id = 48078, name = GetSpellInfo(48078)},
FlashHeal = {id = 48071, name = GetSpellInfo(48071)},
Smite = {id = 48123, name = GetSpellInfo(48123)},
Resurrection = {id = 48171, name = GetSpellInfo(48171)},
CureDisease = {id = 528, name = GetSpellInfo(528)},
HymnofHope = {id = 64901, name = GetSpellInfo(64901)},
LesserHeal = {id = 2053, name = GetSpellInfo(2053)},
Heal = {id = 6064, name = GetSpellInfo(6064)},
PrayerofHealing = {id = 48072, name = GetSpellInfo(48072)},
AbolishDisease = {id = 552, name = GetSpellInfo(552)},
HolyFire = {id = 48135, name = GetSpellInfo(48135)},
DivineHymn = {id = 64843, name = GetSpellInfo(64843)},
GreaterHeal = {id = 48063, name = GetSpellInfo(48063)},
BindingHeal = {id = 48120, name = GetSpellInfo(48120)},
--Shadow Magic
MindFlay = {id = 48156, name = GetSpellInfo(48156)},
Fade = {id = 586, name = GetSpellInfo(586)},
VampiricEmbrace = {id = 15286, name = GetSpellInfo(15286)},
MindControl = {id = 605, name = GetSpellInfo(605)},
VampiricTouch = {id = 48160, name = GetSpellInfo(48160)},
MindSoothe = {id = 453, name = GetSpellInfo(453)},
Dispersion = {id = 47585, name = GetSpellInfo(47585)},
MindVision = {id = 10909, name = GetSpellInfo(10909)},
MindBlast = {id = 48127, name = GetSpellInfo(48127)},
PsychicScream = {id = 10890, name = GetSpellInfo(10890)},
PrayerofShadowProtection = {id = 48170, name = GetSpellInfo(48170)},
ShadowWordDeath = {id = 48158, name = GetSpellInfo(48158)},
ShadowWordPain = {id = 48125, name = GetSpellInfo(48125)},
ShadowProtection = {id = 48169, name = GetSpellInfo(48169)},
MindSear = {id = 53023, name = GetSpellInfo(53023)},
Shadowfiend = {id = 34433, name = GetSpellInfo(34433)},
Shadowform = {id = 15473, name = GetSpellInfo(15473)},
DevouringPlague = {id = 48300, name = GetSpellInfo(48300)},
}

local enemies = {}

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
		if(lastSpell == spell)
		and lastGuid == UnitGUID(tar)
		and GetTime() - lastTime < 2 then
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

local _shadowweaving = 0
local _targetTTD = 0

local abilities = {
["Pause"] = function()
	if IsMounted()
	or UnitIsDeadOrGhost("player")
	or not UnitExists("target")
	or UnitIsDeadOrGhost("target")
	or (UnitExists("target") and not UnitCanAttack("player", "target"))
	then return true
		end
	if UnitChannelInfo("player") == spells.MindSear.name
	or UnitChannelInfo("player") == spells.MindFlay.name
	then return true
		end
end,
["Cache"]= function()
	_shadowweaving = ni.player.buffstacks(15258)
	_targetTTD = ni.unit.ttd("target")
end,
["Shadowform"] = function()
		if not ni.player.buff(spells.Shadowform.id)
		and ni.spell.available(spells.Shadowform.id)
		then
			ni.spell.cast(spells.Shadowform.name)
		end
end,
["VampiricEmbrace"] = function()
	if not ni.player.buff(spells.VampiricEmbrace.id)
	and ni.spell.available(spells.VampiricEmbrace.id)
	then
		ni.spell.cast(spells.VampiricEmbrace.name)
	end
end,
["InnerFire"] = function()
	if not ni.player.buff(spells.InnerFire.id)
	and ni.spell.available(spells.InnerFire.id)
	then
		ni.spell.cast(spells.InnerFire.name)
	end
end,
["VampiricTouch"] = function()
		if not DoubleCast(spells.VampiricTouch.name, "target")
		and ni.unit.debuffremaining("target", spells.VampiricTouch.id, "player") < 2
		and not ni.player.ismoving()
		and _targetTTD > 4
		and ValidUsable(spells.VampiricTouch.id, "target")
		and FacingLosCast(spells.VampiricTouch.name, "target") then
			return true
		end
	end,
["DevouringPlague"] = function()
	if not DoubleCast(spells.DevouringPlague.name, "target")
	and ni.unit.debuffremaining("target", spells.DevouringPlague.id, "player") < 2
	and ValidUsable(spells.DevouringPlague.id, "target")
	and FacingLosCast(spells.DevouringPlague.name, "target") then
		return true
	end
end,
["ShadowWordPain"] = function()
	if not DoubleCast(spells.ShadowWordPain.name, "target")
	and ni.unit.debuffremaining("target", spells.ShadowWordPain.id, "player") < 2
	and _shadowweaving == 5
	and _targetTTD > 4
	and ValidUsable(spells.ShadowWordPain.id, "target")
	and FacingLosCast(spells.ShadowWordPain.name, "target") then
		return true
	end
end,
["MindBlast"] = function()
	if ValidUsable(spells.MindBlast.id, "target")
	and not ni.player.ismoving()
	and FacingLosCast(spells.MindBlast.name, "target") then
		return true
	end
end,
["MindFlay"] = function()
	if ValidUsable(spells.MindFlay.id, "target")
	and not ni.player.ismoving()
	and UnitChannelInfo("player") ~= spells.MindFlay.name
	and FacingLosCast(spells.MindFlay.name, "target") then
		return true
	end
end,
["MindSear"] = function()
	if ValidUsable(spells.MindSear.id, "target")
	and not ni.player.ismoving()
	and UnitChannelInfo("player") ~= spells.MindSear.name
	and #ni.unit.enemiesinrange("target", 10) > 4
	and FacingLosCast(spells.MindSear.name, "target") then
		return true
	end
end,
["ShadowWordDeath"] = function()
	if ValidUsable(spells.ShadowWordDeath.id, "target")
	and _shadowweaving < 5
	and FacingLosCast(spells.MindSear.name, "target") then
		return true
	end
end,
["Dispersion"] = function()
	if enables["Dispersion"]
	and ni.player.power("mana") <= values["Dispersion"]
	and ni.spell.available(spells.Dispersion.id) then
			ni.spell.cast(spells.Dispersion.name)
	end
end,
["Shadowfiend"] = function()
	if enables["Shadowfiend"]
	and ni.spell.available(spells.Shadowfiend.id)
	and _targetTTD > 10
	and IsSpellInRange(spells.MindBlast.name, "target") then
		ni.spell.cast(spells.Shadowfiend.name)
		return true
	end
	if UnitExists("pet")
	and not UnitIsDeadOrGhost("pet") then
		--Attack the same unit as player
		local petTarget = UnitGUID("pettarget")
		local playerTarget = UnitGUID("target")
		if petTarget ~= playerTarget then
			ni.player.runtext("/petattack")
		end
	end
end
}
ni.bootstrap.profile("Shadow_WotLK", queue, abilities, OnLoad, OnUnload);
