local build = select(4, GetBuildInfo());
local cata = build == 40300 or false;
if cata then
	local queue = {
		"InnerFire",
		"Cache",
		"PowerWordFortitude",
		"PrayerofShadowProtection",
		"VampiricEmbrace",

		"Drink",
		"Antiinvi",
		"Showinvis",
		-- "DesesperatePrayer",
		"KS",
		-- "ShieldEveryone", --Aoe toggler
		-- "PainSupression",
		"Archangel",
		"ShieldLow",
		-- "POMlow",
		-- "PenanceLow",
		"MassDispel",
		-- "Lookatcasting",
		-- "PrayerOfMendingMyself",
		-- "RenewMe",
		"ShadowFiend",
		"ShieldMe",
		"Pause Rotation",
		"ShadowForm",
		-- "PrayerOfMending",
		"Shackle Gargoyle",
		-- "Burst", -- CD Toggller
		-- "Shield",
		-- "Penance",
		-- "FlashHeal",
		"Burn mana",
		-- "AttonementHolyFire", --CD Toggller
		-- "PenanceAttornament", -- CD Toggller
		-- "PenanceOnTank",
		-- "ShieldOnTank",
		-- "AttonementHolySmite", -- CD toggler
		-- "PrayerofHealing",
		-- "Renew",
		-- "Penancelowpriority",
		-- "Heal",
		"AttonementMindBlast",
		"DOTS",
		"MindFlay",
		-- "ManaRegen",
		"VampiricTouch", --CD Toggllwer
		"MovingDispel",

	}

	local spells = {
		Renew = { id = 139, name = GetSpellInfo(139) },
		Heal = { id = 2050, name = GetSpellInfo(2050) },
		HolyWordSerenity = { id = 88684, name = GetSpellInfo(88684) },
		FlashHeal = { id = 2061, name = GetSpellInfo(2061) },
		GreaterHeal = { id = 2060, name = GetSpellInfo(2060) },
		PrayerOfMending = { id = 33076, name = GetSpellInfo(33076) },
		Penance = { id = 47540, name = GetSpellInfo(47540) },
		PowerWordShield = { id = 17, name = GetSpellInfo(17) },
		Smite = { id = 585, name = GetSpellInfo(585) },
		HolyFire = { id = 14914, name = GetSpellInfo(14914) },
		PrayerofHealing = { id = 596, name = GetSpellInfo(596) },
		Archangel = { id = 87151, name = GetSpellInfo(87151) },
		InnerFire = { id = 588, name = GetSpellInfo(588) },
		PowerInfusion = { id = 10060, name = GetSpellInfo(10060) },
		PowerWordFortitude = { id = 21562, name = GetSpellInfo(21562) },
		PainSuprersion = { id = 21562, name = GetSpellInfo(21562) },
		MindBlast = { id = 8092, name = GetSpellInfo(8092) },
		DesesperatePrayer = { id = 19236, name = GetSpellInfo(19236) },
		ShadowWordPain = { id = 589, name = GetSpellInfo(589) },
		HolyNova = { id = 15237, name = GetSpellInfo(15237) },
		ShadowWordDeath = { id = 32379, name = GetSpellInfo(32379) },
		DevouringPlague = { id = 2944, name = GetSpellInfo(2944) },
		PrayerofShadowProtection = { id = 27683, name = GetSpellInfo(27683) },
		ShadowFiend = { id = 34433, name = GetSpellInfo(34433) },
		ShadowForm = { id = 15473, name = GetSpellInfo(15473) },
		VampiricEmbrace = { id = 15286, name = GetSpellInfo(15286) },
		VampiricTouch = { id = 34914, name = GetSpellInfo(34914) },
		MindFlay = { id = 15407, name = GetSpellInfo(15407) },
	}

	local values = {
	}
	local cache = {
		enemies = nil,
		friends = nil,
		moving = ni.player.ismoving(),
		curchannel = nil,
		iscasting = nil
	}

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

	local function NotInmune(tar)
		if not ni.unit.buff(tar, 48707)       -- Anti
				and not ni.unit.buff(tar, 19263)  --Deterrence
				and not ni.unit.buff(tar, 45438)  -- Iceblck
				and not ni.unit.buff(tar, 642)    -- divine Shield
				and not ni.unit.buff(tar, 31221) then -- Cloack of Shadows
			return true
		end
		return false
	end
	local lastSpell, lastTarget = "", ""

	local function DoubleCast(spell, tar)
		if lastSpell == spell and lastTarget == UnitGUID(tar) then
			return true
		end
		return false
	end
	local function CombatEventCatcher(event, ...)
		if event == "PLAYER_REGEN_DISABLED" then
			incombat = true
		elseif event == "PLAYER_REGEN_ENABLED" then
			incombat = false
		end
	end
	local function ValidUsable(id, tar)
		if IsSpellKnown(id) and ni.spell.available(id) and ni.spell.valid(tar, id, false, true, true) then
			return true
		end
		return false
	end
	local function OnLoad()
		ni.combatlog.registerhandler("Tapto shadow", CombatEventCatcher)
		print("Rotation \124cFF15E615Dalvae shadow pvp")
		-- ni.GUI.AddFrame("Tapto shadow", items)
	end
	;
	local function OnUnload()
		ni.combatlog.unregisterhandler("Tapto shadow")
		print("Rotation \124cFFE61515stopped!")
		-- ni.GUI.DestroyFrame("Tapto shadow")
	end

	local t, p = "target", "player"

	local dispelableBuffs = {
		-- Paladin
		79062, -- Blessing of Kings
		79101, -- Blessing of Might
		53563, -- Beacon of Light
		1022, -- Hand Of protection

		-- Priest
		17,  -- Power Word: Shield
		139, -- Renew
		6346, -- Fear Ward
		79104, -- Power Word Fortitud
		79106, -- Shadow protection
		41635, -- Prayer of PrayerOfMending
		-- Shaman
		52127, -- Water Shield
		974, -- Earth Shield
		324, -- Lightning Shield
		-- Druid
		1126, -- Mark of the Wild
		774, -- Rejuvenation
		467, -- Thorns
		--
		-- Mage
		1459, -- Arcane Brilliance
		7302, -- Ice Armor
		30482, --
		-- Warlock
		687, -- Demon Armor
		-- Añade más bufos dispeleables de Brujo aquí
		-- Añade más bufos dispeleables de otras clases aquí

	}
	local priorityccbuffs = {
		5782, -- fear Warlock
		118, -- Poly Sheep.
		853, -- Hammer of justice
		6770, -- Sap
		2094, -- Blind


	}
	local Cache = {
		moving = ni.player.ismoving(),
		members = ni.members.sort(),
		targets = ni.unit.enemiesinrange(p, 30),
	}
	local abilities = {
		["Cache"] = function()
			Cache.targets = ni.unit.enemiesinrange(p, 30)
			Cache.moving = ni.player.ismoving()
			Cache.members = ni.members.sort()
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
		["DesesperatePrayer"] = function()
			if UnitAffectingCombat(p)
					and ni.player.hp() <= 20
			then
				ni.spell.cast(spells.DesesperatePrayer.id)
			end
		end,

		["PowerWordFortitude"] = function()
			if not UnitAffectingCombat("player")
					and not ni.player.buff(spells.PowerWordFortitude.id) then
				ni.spell.cast(spells.PowerWordFortitude.name)
				return true
			end
		end,
		["PrayerofShadowProtection"] = function()
			if not ni.player.buff(spells.PrayerofShadowProtection.id)
					and not UnitAffectingCombat("player")
					and ni.player.power("mana") > 80
			then
				ni.spell.cast(spells.PrayerofShadowProtection.id)
			end
		end,
		["VampiricEmbrace"] = function()
			if not ni.player.buff(spells.VampiricEmbrace.id)
					and not UnitAffectingCombat("player")
					and ni.player.power("mana") > 80
			then
				ni.spell.cast(spells.VampiricEmbrace.id)
			end
		end,
		["ShadowForm"] = function()
			if not ni.player.buff(spells.ShadowForm.id)
					and ni.player.hp() > 40
			then
				ni.spell.cast(spells.ShadowForm.id)
			end
		end,
		["Burst"] = function()
			if ni.vars.combat.cd
					and ni.spell.cd(spells.PowerInfusion.id) == 0 then
				ni.spell.cast(spells.PowerInfusion.name)
				return true
			end
		end,
		["PenanceAttornament"] = function()
			if ni.vars.combat.cd
					and not cache.moving
					and ni.spell.cd(spells.Penance.id) == 0
					and ni.spell.valid(spells.Penance.id, t, false, true, false)
					and
					LosCastStand(spells.Penance.name, t)
			then
				return true
			end
		end,
		["Drink"] = function()
			if ni.player.power("mana") < 95
					and not UnitAffectingCombat("player")
					and not IsMounted()
					and not ni.unit.ischanneling("player")
					and not ni.unit.buff("player", 25990)
					and not ni.unit.ischanneling("player")
			then
				ni.player.useitem(101001)
			end
		end,

		["AttonementHolyFire"] = function()
			if ni.vars.combat.cd
					and not ni.player.ismoving()
					and ni.spell.cd(spells.HolyFire.id) == 0
					and ni.player.los(t)
					and LosCast(spells.HolyFire.name, t)
			then
				return true
			end
		end,
		["AttonementHolySmite"] = function()
			if ni.vars.combat.cd
					and not ni.player.ismoving()
					and ni.player.los(t)
					and LosCast(spells.Smite.name, t)
			then
				return true
			end
		end,
		["AttonementMindBlast"] = function()
			if not ni.player.ismoving()
					and ni.player.los(t)
					and LosCast(spells.MindBlast.name, t)
			then
				return true
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
					end
				end
			end
		end,
		["MovingDispel"] = function()
			if ni.player.ismoving() then
				for d = 1, #dispelableBuffs do
					if ni.unit.buff(t, dispelableBuffs[d])
							and ni.spell.valid(t, 527) then
						ni.spell.cast(527, t)
					end
				end
			end
		end,
		["POMlow"] = function()
			if ni.spell.cd(spells.PrayerOfMending.id) == 0 then
				for i = 1, #Cache.members do
					if Cache.members[i].hp() <= 40 and ni.player.los(Cache.members[i].unit)
							and
							ValidUsable(spells.PrayerOfMending.id, Cache.members[i].unit)
							and ni.spell.valid(33076, Cache.members[i].unit, false, true, true)
					then
						ni.spell.cast(spells.PrayerOfMending.id, Cache.members[i].unit)
						return true
					end
				end
			end
		end,
		["Pause Rotation"] = function()
			if IsMounted()
					or UnitIsDeadOrGhost("player")
					or not UnitAffectingCombat("player")
					or ni.unit.buff("player", "Drink")
					or ni.unit.ischanneling("player") then
				return true;
			end
		end,


		["MassDispel"] = function()
			local buffdispe = { 642, 45438 } -- Divine Shield, Ice Block
			for d = 1, #buffdispe do
				for i = 1, #Cache.targets do
					if ni.unit.buff(Cache.targets[i].guid, buffdispe[d])
							and not ni.player.ismoving()
					-- and ni.spell.valid(spells.HolyFire, Cache.targets[i].guid, false, true, true)
					then
						print("dispel")
						ni.spell.castat(32375, Cache.targets[i].guid)
						return true
					end
				end
			end
		end,


		-- ["PainSupression"] = function ()
		--     local friends = ni.unit.friendsinrange("player", 30)
		--     if ni spell.available(spells.PainSuprersion.id) then

		["PenanceOnTank"] = function()
			for i = 1, #ni.members.inrange("player", 40) do
				if ni.members[i]:istank() and
						ni.members.inrange("player", 40)[i].hp() <= 90 and
						ValidUsable(spells.Penance.id, ni.members[i].unit) and
						LosCast(spells.Penance.name, ni.members[i].unit)
				then
					return true
				end
			end
		end,

		["DefensiveDispelpriority"] = function()
			for i = 1, #Cache.members do
				for _, v in pairs(priorityccbuffs) do
					if ni.player.los(Cache.members[i].guid)
							and ni.unit.debuff(Cache.members[i].guid, v) then
						ni.spell.cast(spells.dispelmagic.id, Cache.members[i].guid)
					end
				end
			end
		end,
		["ShieldOnTank"] = function()
			for i = 1, #ni.members.inrange("player", 40) do
				if ni.members[i]:istank() and
						ni.members.inrange("player", 40)[i].hp() <= 100 and
						not ni.unit.debuff(ni.members[i].unit, 6788, t) and
						ValidUsable(spells.PowerWordShield.id, ni.members[i].unit) and
						LosCast(spells.PowerWordShield.name, ni.members[i].unit)
				then
					return true
				end
			end
		end,
		["Heal"] = function()
			if not ni.player.ismoving()
					and not ni.player.ismoving() then
				for i = 1, #Cache.members do
					if
							Cache.members[i].hp() <= 80 and
							ValidUsable(spells.Heal.id, ni.members[i].unit) and
							LosCast(spells.Heal.name, ni.members[i].unit)
					then
						return true
					end
				end
			end
		end,
		["FlashHeal"] = function()
			if not ni.player.ismoving() then
				for i = 1, #Cache.members do
					if
							Cache.members[i].hp() <= 70 and
							ValidUsable(spells.FlashHeal.id, ni.members[i].unit) and
							LosCast(spells.FlashHeal.name, ni.members[i].unit)
					then
						return true
					end
				end
			end
		end,
		["PenanceLow"] = function()
			if not ni.player.ismoving()
					and ni.spell.cd(spells.Penance.id) == 0 then
				for i = 1, #Cache.members do
					if Cache.members[i].hp() <= 30 and
							ValidUsable(spells.Penance.id, ni.members[i].unit) and
							LosCastStand(spells.Penance.name, ni.members[i].unit)
					then
						return true
					end
				end
			end
		end,
		["Penance"] = function()
			if not ni.player.ismoving()
					and ni.spell.cd(spells.Penance.id) == 0 then
				for i = 1, #Cache.members do
					if Cache.members[i].hp() <= 69 and
							ValidUsable(spells.Penance.id, ni.members[i].unit) and
							LosCastStand(spells.Penance.name, ni.members[i].unit)
					then
						return true
					end
				end
			end
		end,
		["Penancelowpriority"] = function()
			if not ni.player.ismoving()
					and ni.spell.cd(spells.Penance.id) == 0 then
				for i = 1, #Cache.members do
					if Cache.members[i].hp() <= 80 and
							ValidUsable(spells.Penance.id, ni.members[i].unit) and
							LosCastStand(spells.Penance.name, ni.members[i].unit)
					then
						return true
					end
				end
			end
		end,
		["Shield"] = function()
			for i = 1, #Cache.members do
				if Cache.members[i].hp() <= 99 and not ni.unit.debuff(Cache.members[i].unit, 6788, t) and
						ValidUsable(spells.PowerWordShield.id, Cache.members[i].unit) and
						LosCast(spells.PowerWordShield.name, Cache.members[i].unit)
				then
					return true
				end
			end
		end,
		["ShieldLow"] = function()
			for i = 1, #Cache.members do
				if Cache.members[i].hp() <= 40 and not ni.unit.debuff(Cache.members[i].unit, 6788, t) and
						ValidUsable(spells.PowerWordShield.id, Cache.members[i].unit) and
						LosCast(spells.PowerWordShield.name, Cache.members[i].unit)
				then
					return true
				end
			end
		end,
		["Renew"] = function()
			if ni.player.power("mana") > 65 then
				for i = 1, #Cache.members do
					if Cache.members[i].hp() <= 95 and not ni.unit.buff(ni.members[i].unit, 139, p) and
							ValidUsable(spells.Renew.id, ni.members[i].unit) and
							LosCast(spells.Renew.name, ni.members[i].unit)
					then
						return true
					end
				end
			end
		end,
		["RenewMe"] = function()
			if ni.player.power("mana") > 45
					and ni.player.hp() <= 80
					and not ni.player.buff(139)
			then
				ni.spell.cast(139, p)
			end
		end,

		["ShieldMe"] = function()
			if ni.vars.combat.cd then
				if ni.spell.cd(spells.PowerWordShield.id) == 0
						and not ni.player.debuff(6788)
						and not ni.player.buff(17)
						and LosCast(spells.PowerWordShield.id, "player")
				then
					return true
				end
			end
		end,

		["ShieldEveryone"] = function()
			if ni.vars.combat.aoe then
				for i = 1, #Cache.members do
					local ally = Cache.members[i]
					if not ni.unit.debuff(ally.guid, 6788, "player") and
							ValidUsable(spells.PowerWordShield.id, ally.guid) and
							LosCast(spells.PowerWordShield.name, ally.guid)
					then
						return true
					end
				end
			end
		end,
		["PrayerOfMending"] = function()
			if ni.spell.cd(spells.PrayerOfMending.id) == 0
			then
				local renewActive = false
				for i = 1, #ni.members.inrange("player", 40) do
					if ni.unit.buff(ni.members[i].unit, spells.PrayerOfMending.id, "player") then
						renewActive = true
						break
					end
				end
				-- No sé si funciona, tambien hay que agregarle una condicional para targetar aquel que tenga agro
				if not renewActive then
					for i = 1, #ni.members.inrange("player", 40) do
						if ni.members[i].hp() < 99
								and not ni.unit.buff(ni.members[i].unit, spells.PrayerOfMending.id, "player")
								and ni.spell.valid(ni.members[i].unit, spells.PrayerOfMending.id, false, true, true) then
							ni.spell.cast(spells.PrayerOfMending.id, ni.members[i].unit)
							return true
						end
					end
				end
			end
		end,

		["PrayerOfMendingMyself"] = function()
			if ni.spell.cd(spells.PrayerOfMending.id) == 0
					and ni.player.hp() <= 60
			then
				ni.spell.cast(spells.PrayerOfMending.id, "player")
			end
		end,
		["PrayerofHealing"] = function()
			local members = ni.members.inrangebelow("player", 40, 50)
			if
					#members >= 4 and ValidUsable(spells.CircleOfHealing.id, members[1].unit) and
					LosCast(spells.CircleOfHealing.name, members[1].unit)
			then
				return true
			end
		end,
		["GreaterHeal"] = function()
			for i = 1, #Cache.members do
				if
						Cache.members[i].hp() <= 70 and
						ValidUsable(spells.GreaterHeal.id, ni.members[i].unit) and
						LosCast(spells.GreaterHeal.name, ni.members[i].unit)
				then
					return true
				end
			end
		end,
		["Archangel"] = function()
			if ni.player.buffstacks(81661) == 5      -- Evangelism
					and ni.spell.cd(spells.Archangel.id) == 0 -- Arcangel
			then
				print("entro xd")
				ni.spell.cast(87151)
				return true
			end
		end,
		["ShadowFiend"] = function()
			if ni.vars.combat.cd
					and ni.spell.cd(spells.ShadowFiend.id) == 0
					and ni.player.los("target")
			then
				ni.spell.cast(spells.ShadowFiend.id, "target")
				return true
			end
		end,
		["DOTS"] = function()
			if ni.player.los(t) then
				if not ni.unit.debuff("target", spells.ShadowWordPain.id, "player") then
					ni.spell.cast(spells.ShadowWordPain.id, "target")
				else
					if not ni.unit.debuff("target", spells.DevouringPlague.id, "player") then
						ni.spell.cast(spells.DevouringPlague.id, "target")
					end
				end
			end
		end,
		["VampiricTouch"] = function()
			local enemies = ni.unit.enemiesinrange("player", 40)
			for i = 1, #enemies do
				local target = enemies[i].guid
				-- if ni.spell.valid(spells.ShadowWordDeath.id, target, false, true, false)
				if ni.player.los(target)
						and not ni.unit.debuff(target, spells.VampiricTouch.id, p)
				then
					ni.spell.cast(spells.VampiricTouch.id, target)
				end
			end
		end,
		["MindFlay"] = function()
			if not ni.player.ismoving()
					and ni.player.los(t)
			then
				ni.spell.cast(spells.MindBlast.id, t)
			end
		end,
	}

	ni.bootstrap.profile("Dalvae_shadowpvp_cata", queue, abilities, OnLoad, OnUnload)
else
	local queue = {
		"Error",
	};
	local abilities = {
		["Error"] = function()
			ni.vars.profiles.enabled = false;
			if not cata then
				ni.frames.floatingtext:message("This profile for Cata!")
			end
		end,
	};
	ni.bootstrap.profile("Dalvae_shadowpvp_cata", queue, abilities);
end
;
-- Evitar doble cast
-- Auto cache	
--Aoe o target
---

--- 40 yards Radians Los escudos
--Renew
-- Dispel Defensivo
--Combustion
-- Fear
---ONplayer buff
-- Anarphet - Chest

-- pantalones, hacer la quest https://cata-twinhead.twinstar.cz/?quest=28133
-- En gim battol cae de trash
-- Isseset bota unos



--Hands

-- --     Magos:
-- Polymorph (Polimorfia): 118, 12824, 12825, 12826, 28271, 28272, 61025
-- Slow (Lentitud): 31589

-- Brujos:
-- Fear (Miedo): 5782, 6213, 6215, 5484, 17928
-- Howl of Terror (Aullido de terror): 5484

-- Cazadores:
-- Freezing Trap (Trampa congelante): 3355, 14309, 14310
-- Wyvern Sting (Picadura de víbora): 19386, 24132, 24133
-- Scatter Shot (Disparo disperso): 19503

-- Caballeros de la Muerte:
-- Mind Freeze (Congelación mental): 47528

-- Paladines:
-- Repentance (Arrepentimiento): 20066
-- Hammer of Justice (Martillo de justicia): 853, 5588, 5589, 10308, 10326

-- Sacerdotes:
-- Psychic Scream (Grito psíquico): 8122, 8124, 10888, 10890
-- Silence (Silencio): 15487, 19985, 19989

-- Ladrones:
-- Sap (Seducción): 6770, 2070, 11297
