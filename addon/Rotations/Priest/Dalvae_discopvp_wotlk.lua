local build = select(4, GetBuildInfo());
local wotlk = build == 30300 or false;
if wotlk then
	local spells = {
		--Discipline icon = select(2, GetSpellTabInfo(2))
		InnerFire = { id = 588, name = GetSpellInfo(588), icon = select(3, GetSpellInfo(588)) },
		PowerWordShield = { id = 48066, name = GetSpellInfo(48066), icon = select(3, GetSpellInfo(48066)) },
		PowerWordFortitude = { id = 48162, name = GetSpellInfo(48162), icon = select(3, GetSpellInfo(48162)) },
		PowerInfusion = { id = 10060, name = GetSpellInfo(10060), icon = select(3, GetSpellInfo(10060)) },

		dispelmagic = { id = 988, name = GetSpellInfo(988), icon = select(3, GetSpellInfo(988)) },
		ShackleUndead = { id = 9484, name = GetSpellInfo(9484), icon = select(3, GetSpellInfo(9484)) },
		MassDispel = { id = 32375, name = GetSpellInfo(32375), icon = select(3, GetSpellInfo(32375)) },
		PrayerofSpirit = { id = 48074, name = GetSpellInfo(48074), icon = select(3, GetSpellInfo(48074)) },
		PrayerofFortitude = { id = 48162, name = GetSpellInfo(48162), icon = select(3, GetSpellInfo(48162)) },
		PrayerofShadowProtection = { id = 48170, name = GetSpellInfo(48170), icon = select(3, GetSpellInfo(48170)) },
		DesesperatePrayer = { id = 48173, name = GetSpellInfo(48173), icon = select(3, GetSpellInfo(48173)) },
		Penance = { id = 53006, name = GetSpellInfo(53006), icon = select(3, GetSpellInfo(53006)) },
		ManaBurn = { id = 8129, name = GetSpellInfo(8129), icon = select(3, GetSpellInfo(8129)) },


		--Holy icon = select(2, GetSpellTabInfo(3))
		FlashHeal = { id = 48071, name = GetSpellInfo(48071), icon = select(3, GetSpellInfo(48071)) },
		Renew = { id = 48068, name = GetSpellInfo(48068), icon = select(3, GetSpellInfo(48068)) },
		PrayerofHealing = { id = 48072, name = GetSpellInfo(48072), icon = select(3, GetSpellInfo(48072)) },
		CureDisease = { id = 528, name = GetSpellInfo(528), icon = select(3, GetSpellInfo(552)) },
		BindingHeal = { id = 32546, name = GetSpellInfo(32546), icon = select(3, GetSpellInfo(32546)) },
		PrayerofMending = { id = 48113, name = GetSpellInfo(48113), icon = select(3, GetSpellInfo(48113)) },
		DivineHymn = { id = 64843, name = GetSpellInfo(64843), icon = select(3, GetSpellInfo(64843)) },
		Nova = { id = 48007, name = GetSpellInfo(48007), icon = select(3, GetSpellInfo(48007)) },
		HolyFire = { id = 48135, name = GetSpellInfo(48135), icon = select(3, GetSpellInfo(48135)) },
		Smite = { id = 48123, name = GetSpellInfo(48123), icon = select(3, GetSpellInfo(48123)) },

		--Shadow Magic icon = select(2, GetSpellTabInfo(4))
		DevouringPlague = { id = 48300, name = GetSpellInfo(48300), icon = select(3, GetSpellInfo(48300)) },
		MindBlast = { id = 8092, name = GetSpellInfo(8092), icon = select(3, GetSpellInfo(8092)) },
		MindFlay = { id = 48156, name = GetSpellInfo(48156), icon = select(3, GetSpellInfo(48156)) },
		ShadowWordDeath = { id = 48158, name = GetSpellInfo(48158), icon = select(3, GetSpellInfo(48158)) },
		MindSear = { id = 53023, name = GetSpellInfo(53023), icon = select(3, GetSpellInfo(53023)) },
		ShadowWordPain = { id = 48125, name = GetSpellInfo(48125), icon = select(3, GetSpellInfo(48125)) },
		VampiricTouch = { id = 48160, name = GetSpellInfo(48160), icon = select(3, GetSpellInfo(48160)) },
		Dizarm = { id = 64044, name = GetSpellInfo(64044), icon = select(3, GetSpellInfo(64044)) },
		SilenceInterrupt = { id = 15487, name = GetSpellInfo(15487), icon = select(3, GetSpellInfo(15487)) },
		VampiricEmbrace = { id = 15286, name = GetSpellInfo(15286), icon = select(3, GetSpellInfo(15286)) },
		Dispersion = { id = 47585, name = GetSpellInfo(47585), icon = select(3, GetSpellInfo(47585)) },
		Shadowfiend = { id = 34433, name = GetSpellInfo(34433), icon = select(3, GetSpellInfo(34433)) },
		ShadowProtection = { id = 27683, name = GetSpellInfo(27683), icon = select(3, GetSpellInfo(27683)) },
		Fade = { id = 586, name = GetSpellInfo(586), icon = select(3, GetSpellInfo(586)) },
		PsychicScream = { id = 10890, name = GetSpellInfo(10890), icon = select(3, GetSpellInfo(10890)) },
		Shadowform = { id = 15473, name = GetSpellInfo(15473), icon = select(3, GetSpellInfo(15473)) },
		-- Engineering and others
	}
	local enables = {
		["Interrupter"] = true,
		["AntiInterupt"] = true,
		["antiCC"] = true,
		["CureDisease"] = true,
		["DefensiveDispel"] = true,
		["OfensiveDispel"] = true,
		["MassDispel"] = true,
		["Showinvis"] = true,
		["PsychicScream"] = true,
		["KS"] = true,
		["Shadowfiend"] = true,
		["PowerWordShield"] = true,
		["burst"] = true,
		["PowerWordFortitude"] = true,
		["ShadowProtection"] = true,
		["Spirit"] = true,
		["Renew"] = true,
		["InnerFire"] = true,
		["PrayerofMending"] = true,
		["BindingHeal"] = true,
		["FlashHeal"] = true,
		["DevouringPlagueKIll"] = true,
		["Mana Burn"] = true,
	}
	local values = {
		["TrinketsPVP1"]          = 30,
		["Dispersion"]            = 30,
		["DevouringPlagueKIll"]   = 25,
		["Shadowfiend"]           = 67,
		["Renew"]                 = 77,
		["PrayerofHealing"]       = 88,
		["Interrupter"]           = 66,
		["PrayerME"]              = 100,
		["Useenginergloves"]      = 40,
		["PowerWordFortitude"]    = 90,
		["Duh"]                   = 90,
		["ShadowProtection"]      = 90,
		["PowerWordShield"]       = 90,
		["PowerWordShieldFriend"] = 90,
		["Dizarm"]                = 20,
		["MindSear"]              = 4,
		["PsychicScream"]         = 2,
		["ShadowWordDeath"]       = 25,
		["SWDcontrol"]            = 66,
		["Healthstone"]           = 30,
		["BindingHeal"]           = 88,
		["shade"]                 = 66,
		["PrayerofMending"]       = 88,
		["Dispersionmana"]        = 5,
		["FlashHeal"]             = 80


	}
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
		settingsfile = "dalvae_discopvp_wotlk.xml",
		callback = GUICallback,
		{ type = "title",    text = "|cff00ccffDalvae Disco" },
		{ type = "separator" },
		{ type = "page",     number = 1,                     text = "|cffFFFF00Heal settings|r" },
		{ type = "separator" },
		{
			type = "entry",
			text = "\124T" .. spells.PowerWordShield.icon .. ":26:26\124t Shield friend",
			tooltip = "Use " .. spells.PowerWordShield.name,
			enabled = enables["PowerWordShieldFriend"],
			value = values["PowerWordShieldFriend"],
			key = "PowerWordShieldFriend"
		},
		{
			type = "entry",
			text = "\124T" .. spells.PowerWordShield.icon .. ":26:26\124t Shield me",
			tooltip = "Use " .. spells.PowerWordShield.name,
			enabled = enables["PowerWordShield"],
			value = values["PowerWordShield"],
			key = "PowerWordShield"
		},
		{
			type = "entry",
			text = "\124T" .. spells.PrayerofMending.icon .. ":26:26\124t Prayer of Mending friend %hp",
			tooltip = "Use " .. spells.PrayerofMending.name,
			enabled = enables["PrayerofMending"],
			value = values["PrayerofMending"],
			key = "PrayerofMending"
		},
		{
			type = "entry",
			text = "\124T" .. spells.PrayerofMending.icon .. ":26:26\124t Prayer of Mending me %hp",
			tooltip = "Use " .. spells.PrayerofMending.name,
			enabled = enables["PrayerME"],
			value = values["PrayerME"],
			key = "PrayerME"
		},
		{
			type = "entry",
			text = "\124T" .. spells.BindingHeal.icon .. ":26:26\124t Binding heal %hp",
			tooltip = "Use " .. spells.BindingHeal.name,
			enabled = enables["BindingHeal"],
			value = values["BindingHeal"],
			key = "BindingHeal"
		},
		{
			type = "entry",
			text = "\124T" .. spells.Renew.icon .. ":20:20\124t Renew %hp",
			tooltip = "Use " .. spells.Renew.name,
			enabled = enables["Renew"],
			value = values["Renew"],
			key = "Renew"
		},
		{
			type = "entry",
			text = "\124T" .. spells.FlashHeal.icon .. ":20:20\124t  Flash %hp",
			tooltip = "Use " .. spells.FlashHeal.name,
			enabled = enables["FlashHeal"],
			value = values["FlashHeal"],
			key = "FlashHeal"
		},
		{ type = "title",    text = "|cff00ccffDalvae Disco pvp" },
		{ type = "separator" },
		{ type = "page",     number = 2,                         text = "|cffFFFF00PVP settings|r" },
		{ type = "separator" },
		{
			type = "entry",
			text = "\124T" .. spells.MassDispel.icon .. ":20:20\124t  MassDisp buble iceBlock",
			tooltip = "Use " .. spells.MassDispel.name,
			enabled = enables["MassDispel"],
			key = "MassDispel"
		},
		{
			type = "entry",
			text = "\124T" .. spells.dispelmagic.icon .. ":20:20\124t  Dispel pvp buffs enemy",
			tooltip = "Use " .. spells.dispelmagic.name,
			enabled = enables["OfensiveDispel"],
			key = "OfensiveDispel"
		},
		{
			type = "entry",
			text = "\124T" .. spells.dispelmagic.icon .. ":20:20\124t Dispel friend debuffs ",
			tooltip = "Use " .. spells.dispelmagic.name,
			enabled = enables["DefensiveDispel"],
			key = "DefensiveDispel"
		},
		{
			type = "entry",
			text = "\124T" .. spells.CureDisease.icon .. ":20:20\124t Disease",
			tooltip = "Use " .. spells.CureDisease.name,
			enabled = enables["CureDisease"],
			key = "CureDisease"
		},
		{
			type = "entry",
			text = "\124T" .. spells.Shadowfiend.icon .. ":20:20\124t Summoning a dog for % mana",
			tooltip = "Use " .. spells.Shadowfiend.name,
			enabled = enables["Shadowfiend"],
			value = values["Shadowfiend"],
			key = "Shadowfiend"
		},
		{
			type = "entry",
			text = "\124t Rocket",
			tooltip = "Use Gloves ",
			enabled = enables["Useenginergloves"],
			value = values["Useenginergloves"],
			key = "Useenginergloves"
		},
		{
			type = "entry",
			text = "\124T" .. spells.DevouringPlague.icon .. ":20:20\124t Spam plague from %;hp",
			tooltip = "Use " .. spells.DevouringPlague.name,
			value = values["DevouringPlagueKIll"],
			enabled = enables["DevouringPlagueKIll"],
			key = "DevouringPlagueKIll"
		},
		{
			type = "entry",
			text = "\124T" .. spells.Dizarm.icon .. ":20:20\124t Disarm by %hp",
			tooltip = "по хп" .. spells.Dizarm.name,
			enabled = enables["Dizarm"],
			value = values["Dizarm"],
			key = "Dizarm"
		},
		{
			type = "entry",
			text = "\124T" .. spells.Dizarm.icon .. ":20:20\124t Disarm burst",
			tooltip = "Dizarm burst" .. spells.Dizarm.name,
			enabled = enables["DizarmBurst"],
			key = "DizarmBurst"
		},
		{
			type = "entry",
			text = "\124T" .. spells.Fade.icon .. ":20:20\124t Release from slowing down %hp",
			tooltip = "Freedom" .. spells.Fade.name,
			enabled = enables["shade"],
			value = values["shade"],
			key = "shade"
		},
		{
			type = "entry",
			text = "\124T" .. spells.PsychicScream.icon .. ":20:20\124t Scream at enemies",
			tooltip = "по хп" .. spells.PsychicScream.name,
			enabled = enables["PsychicScream"],
			value = values["PsychicScream"],
			key = "PsychicScream"
		},
		{
			type = "entry",
			text = "\124T" .. spells.ShadowWordDeath.icon .. ":20:20\124t SwD at %hp",
			tooltip = "Use " .. spells.ShadowWordDeath.name,
			enabled = enables["ShadowWordDeath"],
			value = values["ShadowWordDeath"],
			key = "ShadowWordDeath"
		},
		{
			type = "entry",
			text = "\124T" .. spells.MindBlast.icon .. ":20:20\124t Use blast",
			tooltip = "Use " .. spells.MindBlast.name,
			enabled = enables["MindBlast"],
			key = "MindBlast"
		},
		{
			type = "entry",
			text = "\124T" .. spells.SilenceInterrupt.icon .. ":20:20\124t Sielince % caste",
			tooltip = "Use " .. spells.SilenceInterrupt.name,
			enabled = enables["Interrupter"],
			value = values["Interrupter"],
			key = "Interrupter"
		},
		{ type = "title",    text = "|cff00ccffDalvae PVP Disco" },
		{ type = "separator" },
		{ type = "page",     number = 3,                         text = "|cffFFFF00Buffs and PvE|r" },
		{ type = "separator" },

		{
			type = "entry",
			text = "\124T" .. spells.PowerWordFortitude.icon .. ":20:20\124t " .. spells.PowerWordFortitude.name,
			tooltip = "Use " .. spells.PowerWordFortitude.name,
			enabled = enables["PowerWordFortitude"],
			value = values["PowerWordFortitude"],
			key = "PowerWordFortitude"
		},
		{
			type = "entry",
			text = "\124T" .. spells.ShadowProtection.icon .. ":20:20\124t " .. spells.ShadowProtection.name,
			tooltip = "Use " .. spells.ShadowProtection.name,
			enabled = enables["ShadowProtection"],
			value = values["ShadowProtection"],
			key = "ShadowProtection"
		},
		{
			type = "entry",
			text = "\124T" .. spells.ShadowProtection.icon .. ":20:20\124t Racical and trinket in 1 time",
			tooltip = "Burst",
			enabled = enables["TrinketsPVE2"],
			key = "TrinketsPVE2"
		},
		{
			type = "entry",
			text = "\124T" .. spells.MindSear.icon .. ":20:20\124t Use AOE with of opponents",
			tooltip = "Use " .. spells.MindSear.name,
			enabled = enables["MindSear"],
			value = values["MindSear"],
			key = "MindSear"
		},
		{
			type = "entry",
			text = "\124T" .. spells.ShadowWordPain.icon .. ":20:20\124t AOE pain when moving",
			tooltip = "Use " .. spells.ShadowWordPain.name,
			enabled = enables["ShadowWordPainAOE"],
			key = "ShadowWordPainAOE"
		},
	}
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
			if v.type == "input"
					and v.key ~= nil
					and v.key == name then
				return v.value
			end
		end
	end
	;

	local function OnLoad()
		ni.combatlog.registerhandler("Tapto Disco", CombatEventCatcher)
		print("Rotation \124cFF15E615Dalvae Disco pvp")
		ni.GUI.AddFrame("Tapto Disco", items)
	end
	local function OnUnload()
		ni.combatlog.unregisterhandler("Tapto Disco")
		print("Rotation \124cFFE61515stopped!")
		ni.GUI.DestroyFrame("Tapto Disco")
	end

	local t, p = "target", "player"
	local cache = {
		-- enemies = false,
		-- friends = false,
		moving = false,
		curchannel = false,
		iscasting = false,
	};
	local function LosCast(spell, tar)
		if ni.player.los(tar) and IsSpellInRange(spell, tar) == 1 then
			ni.spell.cast(spell, tar)
			return true
		end
		return false
	end
	local function LosCastStand(spell, tar)
		if ni.player.los(tar) and IsSpellInRange(spell, tar) == 1 then
			ni.player.lookat(tar)
			ni.player.stopmoving()
			ni.spell.cast(spell, tar)
			return true
		end
		return false
	end
	-- local function LosCastStand(spell, tar)
	-- 	if ni.player.los(tar) and IsSpellInRange(spell, tar) == 1 then
	-- 			ni.player.stopmoving()  -- Detiene el movimiento del jugador
	-- 			ni.player.lookat(tar)  -- Hace que el jugador mire al objetivo
	-- 			ni.spell.cast(spell, tar)  -- Comienza a lanzar el hechizo
	-- 			-- Espera hasta que el jugador haya terminado de castear el hechizo
	-- 			while ni.player.iscasting() do
	-- 					-- Espera un corto período de tiempo antes de verificar nuevamente
	-- 					-- para evitar bloquear innecesariamente el hilo de ejecución.
	-- 					ni.sleep(0.1)
	-- 			end
	-- 			return true
	-- 	end
	-- 	return false
	-- end


	local function ValidUsable(id, tar)
		if IsSpellKnown(id) and ni.spell.available(id) and ni.spell.valid(tar, id, false, true, true) then
			return true
		end
		return false
	end


	local queue = {
		"Cache",
		"Universal pause",
		"Drink",
		"InnerFire",
		"PowerWordFortitude",
		"PrayerofSpirit",
		"PrayerofShadowProtection",
		"AntiInterupt",
		"Desesperate Prayer",
		"Shieldlow",
		"POMlow",
		"Lookatcasting",
		"Penancelow",
		"Shieldme",
		"Power infusion",
		"ShadowFiend",
		"KS",
		"Antiinvi",
		"Showinvis",
		"Pause",
		"Mending",
		-- "Pain Supresion",
		"PsychicScream",
		"MassDispel",
		"Antipoly",
		"Shackle Gargoyle",
		"DefensiveDispelpriority",
		"Shield",
		"Penance",
		-- "Binding Heal",
		"FlashHeal",
		"RenewMe",
		"Burn mana",
		"Penancelowpriority",
		"DefensiveDispel",
		"OfensiveDispel",
		-- "Rebuff",
		-- "CureDisease",
		-- "Ofensive Dispel2",
		"DOTS",
		"HolyFire",
		"Smite",
		"MindBlast",
	}
	local abilities = {
		["Universal Pause"] = function()
			if IsMounted()
					or UnitIsDeadOrGhost("player")
					or ni.unit.buff("player", "Drink")
					or cache.curchannel
			then
				return true;
			end
		end,

		["Drink"] = function()
			if ni.player.hasitem(43236)
					and ni.player.power("mana") < 95
					and not UnitAffectingCombat("player")
					and not IsMounted()
					and not ni.unit.buff("player", 43183)
					and not ni.unit.ischanneling("player")
			then
				ni.player.useitem(43236)
			end
		end,

		["Cache"] = function()
			-- cache.targets = ni.unit.enemiesinrange(p, 30) or false
			-- cache.friends = ni.unit.friendsinrange(p, 40) or false
			cache.moving = ni.player.ismoving() or false;
			cache.iscasting = ni.player.iscasting() or false;
			cache.curchannel = ni.unit.ischanneling("player") or false;
		end,
		["Lookatcasting"] = function()
			if ni.player.iscasting() or ni.unit.ischanneling("player") then
				ni.player.stopmoving()
				ni.player.lookat("target")
				return false
			end
		end,


		["InnerFire"] = function()
			if not ni.player.buff(spells.InnerFire.id)
					and ni.player.hp() then
				ni.spell.cast(spells.InnerFire.name)
				return true
			end
		end,

		["PowerWordFortitude"] = function()
			if not ni.player.buff(spells.PowerWordFortitude.id)
					and ni.player.hasitem(44615)
					and not UnitAffectingCombat("player")
					and ni.player.power("mana") > 80
			then
				ni.spell.cast(spells.PowerWordFortitude.id)
			end
		end,
		["PrayerofSpirit"] = function()
			if not ni.player.buff(spells.PrayerofSpirit.id)
					and ni.player.hasitem(44615)
					and not UnitAffectingCombat("player")
					and ni.player.power("mana") > 80
			then
				ni.spell.cast(spells.PrayerofSpirit.id)
			end
		end,
		["PrayerofShadowProtection"] = function()
			if not ni.player.buff(spells.PrayerofShadowProtection.id)
					and ni.player.hasitem(44615)
					and not UnitAffectingCombat("player")
					and ni.player.power("mana") > 80
			then
				ni.spell.cast(spells.PrayerofShadowProtection.id)
			end
		end,

		["Antiinvi"] = function()
			if ni.player.hp() > 50 then
				local enemies = ni.unit.enemiesinrange("player", 30)
				for i = 1, #enemies do
					local target = enemies[i].guid
					if ni.player.los(target)
							and (select(2, UnitClass(enemies[i].guid)) == "DRUID" or
								select(2, UnitClass(enemies[i].guid)) == "ROGUE")
							and not ni.unit.debuff(target, spells.ShadowWordPain.id, "player")
					then
						ni.spell.cast(spells.ShadowWordPain.id, target)
					end
				end
			end
		end,
		["KS"] = function()
			if ni.spell.cd(spells.ShadowWordDeath.id) == 0 then
				local enemies = ni.unit.enemiesinrange("player", 30)
				for i = 1, #enemies do
					local target = enemies[i].guid
					-- if ni.spell.valid(spells.ShadowWordDeath.id, target, false, true, false)
					if ni.player.los(target)
							and ni.unit.isplayer(target)
							and ni.unit.hp(target) <= 17
					then
						ni.spell.cast(spells.ShadowWordDeath.id, target)
						ni.player.target(target)
						ni.player.runtext("/use 10")
					end
				end
			end
		end,

		-- no a pets!
		["Showinvis"] = function()
			local enemies = ni.unit.enemiesinrange("player", 9)
			local invisibledet = { 1784, 5215, 58984 }
			for d = 1, #invisibledet do
				for i = 1, #enemies do
					if ni.unit.buff(enemies[i].guid, invisibledet[d])
							and ni.player.los(enemies[i].guid) then
						ni.spell.cast(48078) -- Holy nova
					end
				end
			end
		end,

		["AntiInterupt"] = function()
			local interruptID = {
				1766, --Kick
				19647, --Spell Lock
				2139, --Counterspell
				47476, --Strangulate
				57994, --Wind Shear
				6552, --Pummel
				72, --Shield Bash
				31935, --Avenger's Shield
				34490, --Silencing Shot
				47528, --Mind Freeze
				53550 }

			for i, v in ipairs(interruptID) do
				local enemies = ni.unit.enemiesinrange("player", 36)
				for i = 1, #enemies do
					if ni.spell.cd(48158) == 0
							and (UnitCastingInfo(enemies[i].guid) == GetSpellInfo(v) or UnitChannelInfo(enemies[i].guid) == GetSpellInfo(v)) then
						ni.spell.stopcasting()
						ni.spell.stopcasting()
						ni.spell.stopcasting()
					end
				end
			end
		end,
		["Shieldlow"] = function()
			for i = 1, #ni.members.inrange("player", 40) do
				if ni.members[i]:hp() <= 40
						and not ni.unit.debuff(ni.members[i].unit, 6788, t) and
						ValidUsable(spells.PowerWordShield.id, ni.members[i].unit) and
						LosCast(spells.PowerWordShield.name, ni.members[i].unit)
				then
					return true
				end
			end
		end,
		["Penancelow"] = function()
			if ni.spell.cd(spells.Penance.id) == 0 then
				for i = 1, #ni.members.inrange("player", 40) do
					if ni.members[i]:hp() <= 40
							and
							ValidUsable(spells.Penance.id, ni.members[i].unit) and
							LosCastStand(spells.Penance.name, ni.members[i].unit)
					then
						return true
					end
				end
			end
		end,
		["POMlow"] = function()
			if ni.spell.cd(spells.PrayerofMending.id) == 0 then
				for i = 1, #ni.members.inrange("player", 40) do
					if ni.members[i]:hp() <= 40 and ni.player.los(ni.members[i].unit)
							and
							ValidUsable(spells.PrayerofMending.id, ni.members[i].unit)
							and ni.spell.valid(ni.members[i].unit, 48113, false, true, true)
					then
						ni.spell.cast(48113, ni.members[i].unit)
						return true
					end
				end
			end
		end,

		["Shieldme"] = function()
			local _, enabled = GetSetting("PowerWordShield")
			if enabled then
				if ni.spell.available(spells.PowerWordShield.id, p)
						and not IsMounted()
						and not ni.player.debuff(6788)
				then
					ni.spell.cast(spells.PowerWordShield.id, p)
				end
			end
		end,
		-- DPS Burst Secction
		["Power infusion"] = function()
			if ni.vars.combat.cd
					and ni.spell.cd(spells.PowerInfusion.id) == 0
			then
				ni.spell.cast(spells.PowerInfusion.name)
				return true
			end
		end,

		["Pause"] = function()
			if IsMounted()
					or UnitIsDeadOrGhost("player")
					or not UnitAffectingCombat("player")
					or ni.unit.buff("player", "Drink")
					or cache.curchannel
			then
				return true;
			end
		end,

		["Mending"] =
				function()
					if ni.spell.cd(48113) == 0
					then
						local renewActive = false
						for i = 1, #ni.members.inrange("player", 40) do
							if ni.unit.buff(ni.members[i].unit, 48113, "player") then
								renewActive = true
								break
							end
						end
						-- No sé si funciona, tambien hay que agregarle una condicional para targetar aquel que tenga agro
						if not renewActive then
							for i = 1, #ni.members.inrange("player", 40) do
								if ni.members[i]:hp() < 99
										and not ni.unit.buff(ni.members[i].unit, 48113, "player")
										and ni.spell.valid(ni.members[i].unit, 48113, false, true, true) then
									ni.spell.cast(48113, ni.members[i].unit)
									return true
								end
							end
						end
					end
				end,
		["Mending2"] = function()
			local allyOne = ni.members[1];
			local friends = ni.members.inrangewithoutbuffbelow(allyOne.unit, 30, spells.PrayerofMending.id, 70);
			if #friends >= 2
					and allyOne:hp() <= 70
					and allyOne:valid(spells.PrayerofMending.id, false, true) then
				ni.spell.cast(spells.PrayerofMending.id, allyOne.unit)
			end
		end,
		["PsychicScream"] = function()
			local value, enabled = GetSetting("PsychicScream")
			if enabled then
				if ni.spell.cd(spells.PsychicScream.id) == 0
				then
					local enemies = ni.unit.enemiesinrange("player", 8)
					if #enemies >= value then
						-- Checkear para ver si target esta en debuff cyclone u otro cc, o inmunidad
						ni.spell.cast(spells.PsychicScream.id)
					end
				end
			end
		end,

		["Desesperate Prayer"] = function()
			if ni.spell.cd(spells.DesesperatePrayer.id) == 0
					and ni.player.hp() < 33
			then
				ni.spell.cast(spells.DesesperatePrayer.id)
			end
		end,
		["MassDispel"] = function()
			local buffdispe = { 642, 45438 } -- Divine Shield, Ice Block
			local targets = ni.unit.enemiesinrange("player", 30)
			for i = 1, #targets do
				for _, buffId in pairs(buffdispe) do
					if not cache.moving
							and ni.unit.buff(targets[i].guid, buffId) then
						print("massdispel")
						ni.spell.castat(spells.MassDispel.id, targets[i].unit)
						return true
					end
				end
			end
		end,
		["Antipoly"] = function()
			SWDreaction = {
				-- polymorphs
				12826,
				12824,
				118,
				12825,
				61305, -- black cat
				28272, -- pig
				61721, -- rabbit
				61780, -- turkey
				28271, -- turtle
				-- seduces
				31865,
				30850,
				29490,
				20407,
				6359,
				6358
			}
			local enemies = ni.unit.enemiesinrange("player", 36)
			for i, v in ipairs(SWDreaction) do
				for i = 1, #enemies do
					if ni.spell.cd(48158) == 0
							and (UnitCastingInfo(enemies[i].guid) == GetSpellInfo(v) or UnitChannelInfo(enemies[i].guid) == GetSpellInfo(v)) then
						ni.spell.cast(48158, enemies[i].guid)
						break
					end
				end
			end
		end,
		["Shackle Gargoyle"] = function()
			local enemies = ni.unit.enemiesinrange("player", 35)
			for i = 1, #enemies do
				local target = enemies[i].guid
				local name = enemies[i].name
				if name == "Ebon Gargoyle" and not ni.unit.debuff(target, spells.ShackleUndead.id) then
					ni.spell.cast(spells.ShackleUndead.id, target)
				end
			end
		end,
		["DefensiveDispelpriority"] = function()
			local controlt = {
				44572,                              -- Deep Freeze
				12826,                              -- Polymorph
				12824,                              -- Polymorph
				12825,                              -- Polymorph
				118,                                -- Polymorph
				61305,                              -- Polymorph: Black Cat
				28272,                              -- Polymorph: Pig
				61721,                              -- Polymorph: Rabbit
				61780,                              -- Polymorph: Turkey
				28271,                              -- Polymorph: Turtle
				42917,
				15487,                              -- Silence
				10890,                              -- Psychic Scream
				47847,                              -- Shadowfury
				6215,                               -- Fear
				47860,                              -- Death Coil
				31865, 30850, 29490, 20407, 6359, 6358, -- Seduction
				53308,                              -- Enchantment roots
				47476,                              -- Strangulate
				14309, 60210,                       -- Freezing Trap
				34490,                              -- Silencing Shot
				20066,
				10308, 10326, 49203
			, 53338          -- hunt mark
			, 64803          -- snakes
			, 53547          -- crab immo
			, 64695          -- serments sham
			, 24259          -- cs pet lock
			, 17928          -- fear group lock
			, 53308, 53313, 770 -- serment drood
			, 3355           -- Freezing Trap
			, 5484,          -- Howl of Terror
				5782,          -- Fear
				64044,         -- Psychic Horror
				122,           -- Frost Nova
			}
			local friends = ni.unit.friendsinrange("player", 36)
			for i = 1, #friends do
				for _, v in pairs(controlt) do
					if ni.player.los(friends[i].guid)
							and ni.unit.debuff(friends[i].guid, v) then
						ni.spell.cast(spells.dispelmagic.id, friends[i].guid)
					end
				end
			end
		end,
		["OfensiveDispel"] = function()
			local buffoffensive = {
				-- Druid
				48470, -- Great Gift of the Wild
				48469, -- Mark  of the Wild
				17116, -- Nature's Swiftness
				69369, -- Predatory Swiftness
				8936, -- Regrowth
				774, -- Rejuvenation
				-- Paladin
				20217, -- Blessing of Kings
				19740, -- Blessing of Might
				25895, -- Greater Blessing of Kings
				25782, -- Greater Blessing of Might
				642, -- Divine Shield
				1042, -- Blessing of Protection
				54428, -- Divine Plea
				-- Hay que generar una lista de bufos prioritaos
			}

			local enemies = ni.unit.enemiesinrange("player", 30)
			for i = 1, #enemies do
				local target = enemies[i].guid
				for j = 1, #buffoffensive do
					if ni.unit.buff(target, buffoffensive[j])
							and ni.player.los(target) then
						ni.spell.cast(spells.dispelmagic.id, target)
						break -- Romper el bucle interno para no disipar el mismo buff varias veces
					end
				end
			end
		end,

		["Burn mana"] = function()
			local target = "target" -- Reemplaza "target" con el nombre o la variable del objetivo real

			if ni.unit.hasheal(target)
					and UnitManaMax(target) > 18000
					and ni.unit.power(target, "mana") > 3
			then
				ni.spell.cast(spells.ManaBurn.id, target)
			end
		end,
		["Shield"] = function()
			for i = 1, #ni.members do
				if ni.members[i]:hp() <= 90 and not ni.unit.debuff(ni.members[i].unit, 6788, t) and
						ValidUsable(spells.PowerWordShield.id, ni.members[i].unit) and
						LosCast(spells.PowerWordShield.name, ni.members[i].unit)
				then
					return true
				end
			end
		end,
		["Penance"] = function()
			if not cache.moving then
				for i = 1, #ni.members do
					if ni.members[i]:hp() <= 70 and
							ValidUsable(spells.Penance.id, ni.members[i].unit) and
							LosCastStand(spells.Penance.name, ni.members[i].unit)
					then
						return true
					end
				end
			end
		end,
		["Penancelowpriority"] = function()
			if not ni.player.ismoving() then
				for i = 1, #ni.members do
					if ni.members[i]:hp() <= 80 and
							ValidUsable(spells.Penance.id, ni.members[i].unit) and
							LosCastStand(spells.Penance.name, ni.members[i].unit)
					then
						return true
					end
				end
			end
		end,

		["FlashHeal"] = function()
			if not cache.moving then
				for i = 1, #ni.members do
					if
							ni.members[i]:hp() <= 70 and
							ValidUsable(spells.FlashHeal.id, ni.members[i].unit) and
							LosCast(spells.FlashHeal.name, ni.members[i].unit)
					then
						return true
					end
				end
			end
		end,

		["RenewMe"] = function()
			if ni.player.power("mana") > 45
					and ni.player.hp() <= 80
					and not ni.player.buff(spells.Renew.id, p)
			then
				ni.spell.cast(spells.Renew.id, p)
			end
		end,
		["DOTS"] = function()
			if ni.player.los(t) then
				if not ni.unit.debuff("target", spells.ShadowWordPain.id, "player") then
					ni.spell.cast(spells.ShadowWordDeath.id, "target")
				else
					if not ni.unit.debuff("target", spells.DevouringPlague.id, "player") then
						ni.spell.cast(spells.DevouringPlague.id, "target")
					end
				end
			end
		end,
		["ShadowFiend"] = function()
			if ni.vars.combat.cd
					and ni.spell.cd(spells.Shadowfiend.id) == 0
					and ni.player.los("target")
			then
				ni.spell.cast(spells.Shadowfiend.id, "target")
				return true
			end
		end,
		["HolyFire"] = function()
			if ni.spell.cd(spells.HolyFire.id) == 0
					and not ni.player.ismoving()
					and LosCastStand(spells.HolyFire.name, t)
			then
				return true
			end
		end,
		["MindBlast"] = function()
			if ni.spell.cd(spells.MindBlast.id) == 0
					and not ni.player.ismoving()
					and LosCastStand(spells.MindBlast.name, t)
			then
				return true
			end
		end,
		["Smite"] = function()
			if not ni.player.ismoving()
					and LosCastStand(spells.Smite.name, "target")
			then
				return true
			end
		end,
	}
	ni.bootstrap.profile("Dalvae_discopvp_wotlk", queue, abilities, OnLoad, OnUnload);
else
	local queue = {
		"Error",
	};
	local abilities = {
		["Error"] = function()
			ni.vars.profiles.enabled = false;
			if not wotlk then
				ni.frames.floatingtext:message("This profile for WotLK 3.3.5a!")
			end
		end,
	};
	ni.bootstrap.profile("Dalvae_discopvp_wotlk", queue, abilities);
end
;
--TODO:
-- Buffer against dispe
-- Crear defensive dispel
-- valid ahora es :valid
-- inrange below en vez de inrange
-- Power infusion + mana Burn
-- Shadowfiend + Power infusion +  Holy fire, dots ¿que seria lo más logico? dots primero?
-- Power infusion defensivamente o ofensivamente?	

-- Como hacer un script de power infusion, siendo que no hay ninguna variable que me permita medirlo.-- Se hace manual no mas.
