local queue = {
	"MendPet",
	"Pause",
	"RevivePet",
	"Healthstone",
	"AspectoftheHawk",
	"TrapLauncher",
	"CounterShot",
	"TranquilizingShot",
	"Misdirection",
	"SerpentSting",
	"BestialWrath",
	"Rabid",
	"KillCommand",
	"KillShot",
	"FocusFire",
	"DireBeast",
	"MultiShot",
	--"ExplosiveTrap",
	"ArcaneShot",
	"SteadyShot"
}
local enables = {
	["Misdirection"] = false
}
local values = {}
local inputs = {}
local menus = {
	["MisdirectionTar"] = 4
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
	settingsfile = "BM_MOP.xml",
	callback = GUICallback,
	{type = "title", text = "BM MoP"},
	{type = "separator"},
	{type = "title", text = "Misdirection"},
	{
		type = "entry",
		text = "Enable Misdirection",
		enabled = enables["Misdirection"],
		key = "Misdirection"
	},
	{
		type = "dropdown",
		menu = {
			{
				selected = (menus["MisdirectionTar"] == 1),
				value = 1,
				text = "|cffFFFF33Main Tank"
			},
			{
				selected = (menus["MisdirectionTar"] == 2),
				value = 2,
				text = "|cffFF9900Off Tank"
			},
			{
				selected = (menus["MisdirectionTar"] == 3),
				value = 3,
				text = "|cff24E0FBFocus"
			},
			{
				selected = (menus["MisdirectionTar"] == 4),
				value = 4,
				text = "|cff24E0FBPet"
			}
		},
		key = "MisdirectionTar"
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
	ni.combatlog.registerhandler("BM_MoPN", CombatEventCatcher)
	ni.GUI.AddFrame("BM_MoPN", items)
end
local function OnUnload()
	ni.combatlog.unregisterhandler("BM_MoPN")
	ni.GUI.DestroyFrame("BM_MoPN")
end
local spells = {
	AspectoftheIronHawk = {id = 109260, name = GetSpellInfo(109260)}, --SPELL,
	--General
	AutoAttack = {id = 6603, name = GetSpellInfo(6603)}, --SPELL,
	Berserking = {id = 26297, name = GetSpellInfo(26297)}, --SPELL, Racial
	Fetch = {id = 125050, name = GetSpellInfo(125050)}, --SPELL, Glyph
	Claw = {id = 16827, name = GetSpellInfo(16827)}, --PET
	Cower = {id = 1742, name = GetSpellInfo(1742)}, --PET
	Dash = {id = 61684, name = GetSpellInfo(61684)}, --PET
	ArmorSkills = {id = 76250, name = GetSpellInfo(76250)}, --SPELL, Passive
	BattleFatigue = {id = 134732, name = GetSpellInfo(134732)}, --SPELL,
	Growl = {id = 2649, name = GetSpellInfo(2649)}, --PET
	BeastSlaying = {id = 20557, name = GetSpellInfo(20557)}, --SPELL, Racial Passive
	HeartofthePhoenix = {id = 55709, name = GetSpellInfo(55709)}, --PET
	ColdWeatherFlying = {id = 54197, name = GetSpellInfo(54197)}, --SPELL, Passive
	Rabid = {id = 53401, name = GetSpellInfo(53401)}, --PET
	DaVoodooShuffle = {id = 58943, name = GetSpellInfo(58943)}, --SPELL, Racial Passive
	DeadEye = {id = 26290, name = GetSpellInfo(26290)}, --SPELL, Racial Passive
	TearArmor = {id = 50498, name = GetSpellInfo(50498)}, --PET
	DualWield = {id = 674, name = GetSpellInfo(674)}, --SPELL, Passive
	ExpertRiding = {id = 34090, name = GetSpellInfo(34090)}, --SPELL,
	CombatExperience = {id = 20782, name = GetSpellInfo(20782)}, --PET
	SpikedCollar = {id = 53184, name = GetSpellInfo(53184)}, --PET
	Languages = {id = 79744, name = GetSpellInfo(79744)}, --SPELL, Racial Passive
	Regeneration = {id = 20555, name = GetSpellInfo(20555)}, --SPELL, Racial Passive
	WeaponSkills = {id = 76249, name = GetSpellInfo(76249)}, --SPELL, Passive
	FlightMastersLicense = {id = 90267, name = GetSpellInfo(90267)}, --FUTURESPELL, Passive
	ArtisanRiding = {id = 34091, name = GetSpellInfo(34091)}, --FUTURESPELL,
	MasterRiding = {id = 90265, name = GetSpellInfo(90265)}, --FUTURESPELL,
	CloudSerpentRiding = {id = 130487, name = GetSpellInfo(130487)}, --FUTURESPELL, Passive
	WisdomoftheFourWinds = {id = 115913, name = GetSpellInfo(115913)}, --FUTURESPELL, Passive
	--Beast Mastery
	ArcaneShot = {id = 3044, name = GetSpellInfo(3044)}, --SPELL,
	AspectoftheCheetah = {id = 5118, name = GetSpellInfo(5118)}, --SPELL,
	AspectoftheHawk = {id = 13165, name = GetSpellInfo(13165)}, --SPELL,
	AspectofthePack = {id = 13159, name = GetSpellInfo(13159)}, --SPELL,
	AutoShot = {id = 75, name = GetSpellInfo(75)}, --SPELL,
	BeastLore = {id = 1462, name = GetSpellInfo(1462)}, --SPELL,
	BestialWrath = {id = 19574, name = GetSpellInfo(19574)}, --SPELL,
	BindingShot = {id = 109248, name = GetSpellInfo(109248)}, --SPELL,
	--Flyout index 46 = Call Pet = 5
	CallPet1 = {id = 883, name = GetSpellInfo(883)}, --FLYOUT,
	CallPet2 = {id = 83242, name = GetSpellInfo(83242)}, --FLYOUT,
	CallPet3 = {id = 83243, name = GetSpellInfo(83243)}, --FLYOUT,
	CallPet4 = {id = 83244, name = GetSpellInfo(83244)}, --FLYOUT,
	CallPet5 = {id = 83245, name = GetSpellInfo(83245)}, --FLYOUT,
	ConcussiveShot = {id = 5116, name = GetSpellInfo(5116)}, --SPELL,
	CounterShot = {id = 147362, name = GetSpellInfo(147362)}, --SPELL,
	DireBeast = {id = 120679, name = GetSpellInfo(120679)}, --SPELL,
	Disengage = {id = 781, name = GetSpellInfo(781)}, --SPELL,
	DismissPet = {id = 2641, name = GetSpellInfo(2641)}, --SPELL,
	DistractingShot = {id = 20736, name = GetSpellInfo(20736)}, --SPELL,
	EagleEye = {id = 6197, name = GetSpellInfo(6197)}, --SPELL,
	FeedPet = {id = 6991, name = GetSpellInfo(6991)}, --SPELL,
	FeignDeath = {id = 5384, name = GetSpellInfo(5384)}, --SPELL,
	Flare = {id = 1543, name = GetSpellInfo(1543)}, --SPELL,
	FocusFire = {id = 82692, name = GetSpellInfo(82692)}, --SPELL,
	HuntersMark = {id = 1130, name = GetSpellInfo(1130)}, --SPELL,
	KillCommand = {id = 34026, name = GetSpellInfo(34026)}, --SPELL,
	KillShot = {id = 53351, name = GetSpellInfo(53351)}, --SPELL,
	MastersCall = {id = 53271, name = GetSpellInfo(53271)}, --SPELL,
	MendPet = {id = 136, name = GetSpellInfo(136)}, --SPELL,
	MultiShot = {id = 2643, name = GetSpellInfo(2643)}, --SPELL,
	RapidFire = {id = 3045, name = GetSpellInfo(3045)}, --SPELL,
	RevivePet = {id = 982, name = GetSpellInfo(982)}, --SPELL,
	ScareBeast = {id = 1513, name = GetSpellInfo(1513)}, --SPELL,
	ScatterShot = {id = 19503, name = GetSpellInfo(19503)}, --SPELL,
	SerpentSting = {id = 1978, name = GetSpellInfo(1978)}, --SPELL,
	SteadyShot = {id = 56641, name = GetSpellInfo(56641)}, --SPELL,
	TameBeast = {id = 1515, name = GetSpellInfo(1515)}, --SPELL,
	TranquilizingShot = {id = 19801, name = GetSpellInfo(19801)}, --SPELL,
	TrapLauncher = {id = 77769, name = GetSpellInfo(77769)}, --SPELL,
	--Flyout index 73 = Traps = 5
	ExplosiveTrap = {id = 13813, name = GetSpellInfo(13813)}, --FLYOUT, Fire
	FreezingTrap = {id = 1499, name = GetSpellInfo(1499)}, --FLYOUT, Frost
	IceTrap = {id = 13809, name = GetSpellInfo(13809)}, --FLYOUT, Frost
	ImmolationTrap = {id = 13795, name = GetSpellInfo(13795)}, --FLYOUT, Fire
	SnakeTrap = {id = 34600, name = GetSpellInfo(34600)}, --FLYOUT, Nature
	WidowVenom = {id = 82654, name = GetSpellInfo(82654)}, --SPELL,
	BeastCleave = {id = 115939, name = GetSpellInfo(115939)}, --SPELL,
	CobraStrikes = {id = 53260, name = GetSpellInfo(53260)}, --SPELL,
	ControlPet = {id = 93321, name = GetSpellInfo(93321)}, --SPELL, Passive
	ExoticBeasts = {id = 53270, name = GetSpellInfo(53270)}, --SPELL,
	FocusedAim = {id = 87324, name = GetSpellInfo(87324)}, --SPELL, Passive
	Frenzy = {id = 19623, name = GetSpellInfo(19623)}, --SPELL,
	GofortheThroat = {id = 34954, name = GetSpellInfo(34954)}, --SPELL,
	Invigoration = {id = 53253, name = GetSpellInfo(53253)}, --SPELL,
	KindredSpirits = {id = 56315, name = GetSpellInfo(56315)}, --SPELL,
	MailSpecialization = {id = 86538, name = GetSpellInfo(86538)}, --SPELL, Passive
	Posthaste = {id = 109215, name = GetSpellInfo(109215)}, --SPELL,
	TheBeastWithin = {id = 34692, name = GetSpellInfo(34692)}, --SPELL,
	Tracking = {id = 118424, name = GetSpellInfo(118424)}, --SPELL,
	TrueshotAura = {id = 19506, name = GetSpellInfo(19506)}, --SPELL,
	Misdirection = {id = 34477, name = GetSpellInfo(34477)}, --FUTURESPELL,
	Deterrence = {id = 19263, name = GetSpellInfo(19263)}, --FUTURESPELL,
	MasteryMasterofBeasts = {id = 76657, name = GetSpellInfo(76657)}, --FUTURESPELL,
	CobraShot = {id = 77767, name = GetSpellInfo(77767)}, --FUTURESPELL,
	Camouflage = {id = 51753, name = GetSpellInfo(51753)}, --FUTURESPELL,
	Stampede = {id = 121818, name = GetSpellInfo(121818)} --FUTURESPELL,
}

local function FacingLosCast(spellName, tar)
	if ni.player.isfacing(tar, 145) and ni.player.los(tar) and IsSpellInRange(spellName, tar) == 1 then
		ni.spell.cast(spellName, tar)
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

local abilities = {
	["MendPet"] = function()
		if
			UnitExists("pet") and not UnitIsDead("pet") and ni.player.los("pet") and ni.unit.hp("pet") < 95 and
				not ni.unit.buff("pet", 136) and
				IsSpellInRange(spells.MendPet.name, "pet") == 1
		 then
			ni.spell.cast(spells.MendPet.name)
			return true
		end
	end,
	["RevivePet"] = function()
		if (UnitIsDeadOrGhost("pet") == 1 or UnitIsDead("pet") == 1 or IsPetActive() == false) and not ni.player.ismoving() then
			if ni.player.petcd(spells.HeartofthePhoenix.name) == 0 and GetSpellBookItemInfo(spells.HeartofthePhoenix.name) ~= nil then
				ni.spell.cast(spells.HeartofthePhoenix.name)
				return true
			elseif ni.spell.available(spells.RevivePet.name) then
				ni.spell.cast(spells.RevivePet.name)
				return true
			end
		end
	end,
	["Pause"] = function()
		if
			not UnitExists("target") or
				(UnitExists("target") and (not UnitCanAttack("player", "target") or UnitIsDeadOrGhost("target"))) or
				UnitChannelInfo("player") or
				UnitIsDeadOrGhost("player") or
				IsMounted()
		 then
			return true
		end
	end,
	["Healthstone"] = function()
		if ni.player.hp() < 40 and ni.player.hasitem(5512) and ni.player.itemcd(5512) == 0 then
			ni.player.useitem(5512)
			return true
		end
	end,
	["AspectoftheHawk"] = function()
		if
			not ni.player.buff(spells.AspectoftheHawk.id) and not ni.player.buff(spells.AspectoftheIronHawk.id) and
				ni.spell.available(spells.AspectoftheHawk.id)
		 then
			ni.spell.cast(spells.AspectoftheHawk.id)
			return true
		end
	end,
	["TrapLauncher"] = function()
		if not ni.player.buff(spells.TrapLauncher.id) and ni.spell.available(spells.TrapLauncher.id) then
			ni.spell.cast(spells.TrapLauncher.id)
			return true
		end
	end,
	["ExplosiveTrap"] = function()
		local nearby = #ni.unit.enemiesinrange("target", 10)
		if
			ni.player.buff(spells.TrapLauncher.id) and ni.spell.available(spells.ExplosiveTrap.name) and
				IsSpellInRange(spells.ArcaneShot.name, "target") == 1 and
				ni.player.los("target") and
				nearby > 2
		 then
			ni.spell.castat(spells.ExplosiveTrap.name, "target")
			return true
		end
	end,
	["SnakeTrap"] = function()
		local nearby = #ni.unit.enemiesinrange("target", 10)
		if
			ni.player.buff(spells.TrapLauncher.id) and ni.spell.available(spells.SnakeTrap.name) and
				IsSpellInRange(spells.ArcaneShot.name, "target") == 1 and
				ni.player.los("target") and
				nearby > 2
		 then
			ni.spell.castat(spells.SnakeTrap.name, "target")
			return true
		end
	end,
	["SerpentSting"] = function()
		if
			ValidUsable(spells.SerpentSting.id, "target") and not ni.unit.debuff("target", spells.SerpentSting.id, "player") and
				FacingLosCast(spells.SerpentSting.name, "target")
		 then
			return true
		end
	end,
	["KillCommand"] = function()
		if
			ValidUsable(spells.KillCommand.id, "target") and IsSpellInRange(spells.Growl.name, "pettarget") and
				FacingLosCast(spells.KillCommand.name, "target")
		 then
			return true
		end
	end,
	["KillShot"] = function()
		if
			ValidUsable(spells.KillShot.id, "target") and IsUsableSpell(spells.KillShot.name) == 1 and
				FacingLosCast(spells.KillShot.name)
		 then
			return true
		end
	end,
	["FocusFire"] = function()
		if IsUsableSpell(spells.FocusFire.name) == 1 and ni.unit.buffstacks("pet", spells.Frenzy.name) == 5 then
			ni.spell.cast(spells.FocusFire.name)
			return true
		end
	end,
	["ArcaneShot"] = function()
		if
			ValidUsable(spells.ArcaneShot.id, "target") and UnitPower("player", 2) > 70 and
				FacingLosCast(spells.ArcaneShot.name, "target")
		 then
			return true
		end
	end,
	["SteadyShot"] = function()
		if ValidUsable(spells.SteadyShot.id, "target") and FacingLosCast(spells.SteadyShot.name, "target") then
			return true
		end
	end,
	["MultiShot"] = function()
		local nearby = #ni.unit.enemiesinrange("target", 8)
		if ValidUsable(spells.MultiShot.id, "target") and nearby > 1 and FacingLosCast(spells.MultiShot.name, "target") then
			return true
		end
	end,
	["DireBeast"] = function()
		if ValidUsable(spells.DireBeast.id, "target") and FacingLosCast(spells.DireBeast.name, "target") then
			return true
		end
	end,
	["BestialWrath"] = function()
		if ni.spell.available(spells.BestialWrath.id) and IsSpellInRange(spells.Growl.name, "pettarget") then
			ni.spell.cast(spells.BestialWrath.id)
		end
	end,
	["Rabid"] = function()
		if
			ni.player.petcd(spells.Rabid.id) == 0 and IsSpellInRange(spells.Growl.name, "pettarget") and
				ni.unit.buff("pet", spells.BestialWrath.name) and
				GetSpellBookItemInfo(spells.Rabid.name) ~= nil
		 then
			ni.spell.cast(spells.Rabid.id)
		end
	end,
	["TranquilizingShot"] = function()
		if
			ni.unit.bufftype("target", "Enrage|Magic") and ValidUsable(spells.TranquilizingShot.id, "target") and
				FacingLosCast(spells.TranquilizingShot.name, "target")
		 then
			return true
		end
	end,
	["CounterShot"] = function()
		if
			ni.spell.shouldinterrupt("target") and ValidUsable(spells.CounterShot.id, "target") and
				FacingLosCast(spells.CounterShot.name, "target")
		 then
			return true
		end
	end,
	["Misdirection"] = function()
		if enables["Misdirection"] then
			local misTar = menus["MisdirectionTar"]
			local mainTank, offTank = ni.tanks()
			local s = spells.Misdirection.name
			--Main Tank
			if misTar == 1 and mainTank ~= nil and ni.unit.exists(mainTank) then
				if ni.spell.available(s) and ni.spell.valid(mainTank, s, false, true, true) then
					if ni.player.los(mainTank) and IsSpellInRange(s, mainTank) == 1 then
						ni.spell.cast(s, mainTank)
						return true
					end
				end
			end
			--Off Tank
			if misTar == 2 and offTank ~= nil and ni.unit.exists(offTank) then
				if ni.spell.available(s) and ni.spell.valid(offTank, s, false, true, true) then
					if ni.player.los(offTank) and IsSpellInRange(s, offTank) == 1 then
						ni.spell.cast(s, offTank)
						return true
					end
				end
			end
			--Focus
			if misTar == 3 and ni.unit.exists("focus") then
				if ni.spell.available(s) and ni.spell.valid("focus", s, false, true, true) then
					if ni.player.los("focus") and IsSpellInRange(s, "focus") == 1 then
						ni.spell.cast(s, "focus")
						return true
					end
				end
			end
			--Pet
			if misTar == 4 and ni.unit.exists("pet") then
				if ni.spell.available(s) and ni.spell.valid("pet", s, false, true, true) then
					if ni.player.los("pet") and IsSpellInRange(s, "pet") == 1 then
						ni.spell.cast(s, "pet")
						return true
					end
				end
			end
		end
	end
}
ni.bootstrap.profile("BM - MoP Nuok", queue, abilities, OnLoad, OnUnload)
