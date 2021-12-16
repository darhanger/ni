local queue = {
	"Pause",
	"Cache",
	"WaitForChannel",
	"PowerWordShield",
	"PowerWordFortitude",
	"InnerFire",
	"Shadowform",
	"ShadowWordPain",
	"DevouringPlague",
	"VampiricTouch",
	"MindBlast",
	"ShadowWordDeath",
	"MindFlay",
	"Smite",
	"Wand"
}

local IsSpellInRange,
	IsCurrentSpell,
	IsMounted,
	UnitIsDeadOrGhost,
	UnitExists,
	UnitCanAttack,
	IsUsableSpell,
	GetSpellInfo,
	GetSpellTabInfo,
	UnitChannelInfo,
	UnitCastingInfo =
	IsSpellInRange,
	IsCurrentSpell,
	IsMounted,
	UnitIsDeadOrGhost,
	UnitExists,
	UnitCanAttack,
	IsUsableSpell,
	GetSpellInfo,
	GetSpellTabInfo,
	UnitChannelInfo,
	UnitCastingInfo

local spells = {
	--build == 40300
	--General icon = select(2, GetSpellTabInfo(1))
	ArcaneAffinity = {id = 28877, name = GetSpellInfo(28877), icon = select(3, GetSpellInfo(28877))},
	ArcaneResistance = {id = 822, name = GetSpellInfo(822), icon = select(3, GetSpellInfo(822))},
	ArcaneTorrent = {id = 28730, name = GetSpellInfo(28730), icon = select(3, GetSpellInfo(28730))},
	ArmorSkills = {id = 76279, name = GetSpellInfo(76279), icon = select(3, GetSpellInfo(76279))},
	AutoAttack = {id = 6603, name = GetSpellInfo(6603), icon = select(3, GetSpellInfo(6603))},
	Languages = {id = 79748, name = GetSpellInfo(79748), icon = select(3, GetSpellInfo(79748))},
	Shoot = {id = 5019, name = GetSpellInfo(5019), icon = select(3, GetSpellInfo(5019))},
	WeaponSkills = {id = 76301, name = GetSpellInfo(76301), icon = select(3, GetSpellInfo(76301))},
	ApprenticeRiding = {id = 33388, name = GetSpellInfo(33388), icon = select(3, GetSpellInfo(33388))},
	JourneymanRiding = {id = 33391, name = GetSpellInfo(33391), icon = select(3, GetSpellInfo(33391))},
	Mysticism = {id = 89745, name = GetSpellInfo(89745), icon = select(3, GetSpellInfo(89745))},
	ExpertRiding = {id = 34090, name = GetSpellInfo(34090), icon = select(3, GetSpellInfo(34090))},
	FlightMastersLicense = {id = 90267, name = GetSpellInfo(90267), icon = select(3, GetSpellInfo(90267))},
	ColdWeatherFlying = {id = 54197, name = GetSpellInfo(54197), icon = select(3, GetSpellInfo(54197))},
	ArtisanRiding = {id = 34091, name = GetSpellInfo(34091), icon = select(3, GetSpellInfo(34091))},
	MasterRiding = {id = 90265, name = GetSpellInfo(90265), icon = select(3, GetSpellInfo(90265))},
	Mastery = {id = 86475, name = GetSpellInfo(86475), icon = select(3, GetSpellInfo(86475))},
	--Discipline icon = select(2, GetSpellTabInfo(2))
	InnerFire = {id = 588, name = GetSpellInfo(588), icon = select(3, GetSpellInfo(588))},
	PowerWordShield = {id = 17, name = GetSpellInfo(17), icon = select(3, GetSpellInfo(17))},
	PowerWordFortitude = {id = 21562, name = GetSpellInfo(21562), icon = select(3, GetSpellInfo(21562))},
	DispelMagic = {id = 527, name = GetSpellInfo(527), icon = select(3, GetSpellInfo(527))},
	ShackleUndead = {id = 9484, name = GetSpellInfo(9484), icon = select(3, GetSpellInfo(9484))},
	Levitate = {id = 1706, name = GetSpellInfo(1706), icon = select(3, GetSpellInfo(1706))},
	FearWard = {id = 6346, name = GetSpellInfo(6346), icon = select(3, GetSpellInfo(6346))},
	ManaBurn = {id = 8129, name = GetSpellInfo(8129), icon = select(3, GetSpellInfo(8129))},
	MassDispel = {id = 32375, name = GetSpellInfo(32375), icon = select(3, GetSpellInfo(32375))},
	InnerWill = {id = 73413, name = GetSpellInfo(73413), icon = select(3, GetSpellInfo(73413))},
	--Holy icon = select(2, GetSpellTabInfo(3))
	FlashHeal = {id = 2061, name = GetSpellInfo(2061), icon = select(3, GetSpellInfo(2061))},
	Renew = {id = 139, name = GetSpellInfo(139), icon = select(3, GetSpellInfo(139))},
	Smite = {id = 585, name = GetSpellInfo(585), icon = select(3, GetSpellInfo(585))},
	Resurrection = {id = 2006, name = GetSpellInfo(2006), icon = select(3, GetSpellInfo(2006))},
	Heal = {id = 2050, name = GetSpellInfo(2050), icon = select(3, GetSpellInfo(2050))},
	HolyFire = {id = 14914, name = GetSpellInfo(14914), icon = select(3, GetSpellInfo(14914))},
	CureDisease = {id = 528, name = GetSpellInfo(528), icon = select(3, GetSpellInfo(528))},
	GreaterHeal = {id = 2060, name = GetSpellInfo(2060), icon = select(3, GetSpellInfo(2060))},
	PrayerofHealing = {id = 596, name = GetSpellInfo(596), icon = select(3, GetSpellInfo(596))},
	BindingHeal = {id = 32546, name = GetSpellInfo(32546), icon = select(3, GetSpellInfo(32546))},
	HolyNova = {id = 15237, name = GetSpellInfo(15237), icon = select(3, GetSpellInfo(15237))},
	HymnofHope = {id = 64901, name = GetSpellInfo(64901), icon = select(3, GetSpellInfo(64901))},
	PrayerofMending = {id = 33076, name = GetSpellInfo(33076), icon = select(3, GetSpellInfo(33076))},
	DivineHymn = {id = 64843, name = GetSpellInfo(64843), icon = select(3, GetSpellInfo(64843))},
	LeapofFaith = {id = 73325, name = GetSpellInfo(73325), icon = select(3, GetSpellInfo(73325))},
	--Shadow Magic icon = select(2, GetSpellTabInfo(4))
	MindBlast = {id = 8092, name = GetSpellInfo(8092), icon = select(3, GetSpellInfo(8092))},
	MindFlay = {id = 15407, name = GetSpellInfo(15407), icon = select(3, GetSpellInfo(15407))},
	ShadowOrbs = {id = 95740, name = GetSpellInfo(95740), icon = select(3, GetSpellInfo(95740))},
	ShadowPower = {id = 87327, name = GetSpellInfo(87327), icon = select(3, GetSpellInfo(87327))},
	ShadowWordPain = {id = 589, name = GetSpellInfo(589), icon = select(3, GetSpellInfo(589))},
	PsychicScream = {id = 8122, name = GetSpellInfo(8122), icon = select(3, GetSpellInfo(8122))},
	Fade = {id = 586, name = GetSpellInfo(586), icon = select(3, GetSpellInfo(586))},
	DevouringPlague = {id = 2944, name = GetSpellInfo(2944), icon = select(3, GetSpellInfo(2944))},
	ShadowWordDeath = {id = 32379, name = GetSpellInfo(32379), icon = select(3, GetSpellInfo(32379))},
	MindVision = {id = 2096, name = GetSpellInfo(2096), icon = select(3, GetSpellInfo(2096))},
	MindControl = {id = 605, name = GetSpellInfo(605), icon = select(3, GetSpellInfo(605))},
	ShadowProtection = {id = 27683, name = GetSpellInfo(27683), icon = select(3, GetSpellInfo(27683))},
	MindSoothe = {id = 453, name = GetSpellInfo(453), icon = select(3, GetSpellInfo(453))},
	Shadowfiend = {id = 34433, name = GetSpellInfo(34433), icon = select(3, GetSpellInfo(34433))},
	MindSear = {id = 48045, name = GetSpellInfo(48045), icon = select(3, GetSpellInfo(48045))},
	MindSpike = {id = 73510, name = GetSpellInfo(73510), icon = select(3, GetSpellInfo(73510))},
	VampiricTouch = {id = 34914, name = GetSpellInfo(34914), icon = select(3, GetSpellInfo(34914))},
	Shadowform = {id = 15473, name = GetSpellInfo(15473), icon = select(3, GetSpellInfo(15473))}
}

local IsSpellInRange, IsMounted, UnitIsDeadOrGhost, UnitExists, UnitCanAttack, IsUsableSpell =
	IsSpellInRange,
	IsMounted,
	UnitIsDeadOrGhost,
	UnitExists,
	UnitCanAttack,
	IsUsableSpell

local enables = {
	["PowerWordShield"] = true
}
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
	settingsfile = "shadow_cata.xml",
	callback = GUICallback,
	{type = "title", text = "\124T" .. select(2, GetSpellTabInfo(4)) .. ":20:20\124t Shadow Cata"},
	{type = "separator"},
	{
		type = "entry",
		text = "\124T" .. spells.PowerWordShield.icon .. ":20:20\124t " .. spells.PowerWordShield.name,
		tooltip = "Use " .. spells.PowerWordShield.name,
		enabled = enables["PowerWordShield"],
		key = "PowerWordShield"
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
	ni.combatlog.registerhandler("Shadow-Cata", CombatEventCatcher)
	ni.GUI.AddFrame("Shadow-Cata", items)
end
local function OnUnload()
	ni.combatlog.unregisterhandler("Shadow-Cata")
	ni.GUI.DestroyFrame("Shadow-Cata")
end

local enemies = {}

local function ActiveEnemies()
	table.wipe(enemies)
	enemies = ni.player.enemiesinrange(40)
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

local cache = {
	targets = nil,
	moving = ni.player.ismoving(),
	curchannel = nil,
	iscasting = nil
}

local t, p = "target", "player"
local WeakenedSoul = 6788

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
		cache.targets = ActiveEnemies()
		cache.moving = ni.player.ismoving()
		cache.curchannel = UnitChannelInfo(p)
		cache.iscasting = UnitCastingInfo(p)
	end,
	["WaitForChannel"] = function()
		if cache.curchannel == spells.MindFlay.name then
			return true
		end
	end,
	["InnerFire"] = function()
		if ni.spell.available(spells.InnerFire.id) and not ni.player.buff(spells.InnerFire.id) then
			ni.spell.cast(spells.InnerFire.name)
			return true
		end
	end,
	["PowerWordFortitude"] = function()
		if ni.spell.available(spells.PowerWordFortitude.id) and not ni.player.buff(spells.PowerWordFortitude.id) then
			ni.spell.cast(spells.PowerWordFortitude.name)
			return true
		end
	end,
	["Shadowform"] = function()
		if ni.spell.available(spells.Shadowform.id) and not ni.player.buff(spells.Shadowform.id) then
			ni.spell.cast(spells.Shadowform.name)
			return true
		end
	end,
	["PowerWordShield"] = function()
		if enables["PowerWordShield"] and
			ni.spell.available(spells.PowerWordShield.id) and not ni.player.debuff(WeakenedSoul) and
				not ni.player.buff(spells.PowerWordShield.id)
		 then
			ni.spell.cast(spells.PowerWordShield.name, p)
			return true
		end
	end,
	["ShadowWordPain"] = function()
		if
			ValidUsable(spells.ShadowWordPain.id, t) and ni.unit.debuffremaining(t, spells.ShadowWordPain.id, p) < 2 and
				FacingLosCast(spells.ShadowWordPain.name, t)
		 then
			return true
		end
	end,
	["DevouringPlague"] = function()
		if
			ValidUsable(spells.DevouringPlague.id, t) and ni.unit.debuffremaining(t, spells.DevouringPlague.id, p) < 2 and
				FacingLosCast(spells.DevouringPlague.name, t)
		 then
			return true
		end
	end,
	["VampiricTouch"] = function()
		if
			not cache.moving and ValidUsable(spells.VampiricTouch.id, t) and
				ni.unit.debuffremaining(t, spells.VampiricTouch.id, p) < 2 and
				FacingLosCast(spells.VampiricTouch.name, t)
		 then
			return true
		end
	end,
	["Smite"] = function()
		if not cache.moving and ValidUsable(spells.Smite.id, t) and FacingLosCast(spells.Smite.name, t) then
			return true
		end
	end,
	["MindBlast"] = function()
		if not cache.moving and ValidUsable(spells.MindBlast.id, t) and FacingLosCast(spells.MindBlast.name, t) then
			return true
		end
	end,
	["ShadowWordDeath"] = function()
		if
			IsUsableSpell(spells.ShadowWordDeath.name) and ValidUsable(spells.ShadowWordDeath.id, t) and
				FacingLosCast(spells.ShadowWordDeath.name, t)
		 then
			return true
		end
	end,
	["MindFlay"] = function()
		if not cache.moving and ValidUsable(spells.MindFlay.id, t) and FacingLosCast(spells.MindFlay.name, t) then
			return true
		end
	end,
	["Wand"] = function ()
		local RangedSlot = GetInventorySlotInfo("RangedSlot")
		if RangedSlot ~= nil and not cache.moving and not IsCurrentSpell(spells.Shoot.id) then
			ni.spell.cast(spells.Shoot.name, t)
		end
	end
}
ni.bootstrap.profile("Shadow - Cata", queue, abilities, OnLoad, OnUnload)
