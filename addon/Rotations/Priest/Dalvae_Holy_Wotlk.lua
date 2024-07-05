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
		InnerFocus = { id = 14751, name = GetSpellInfo(14751), icon = select(3, GetSpellInfo(14751)) },


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
		CircleofHealing = { id = 48089, name = GetSpellInfo(48089), icon = select(3, GetSpellInfo(48089)) },
		GuardianSpirit = { id = 47788, name = GetSpellInfo(47788), icon = select(3, GetSpellInfo(47788)) },
		GreaterHeal = { id = 48063, name = GetSpellInfo(48063), icon = select(3, GetSpellInfo(48063)) },



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
	local items = {
	}
	local function GetSetting(name)
		for s, t in ipairs(items) do
			if t.type == "entry"
					and t.key ~= nil
					and t.key == name
			then
				return t.value, t.enabled
			end
			if t.type == "dropdown" and
					t.key ~= nil
					and t.key == name then
				for u, v in pairs(t.menu) do
					if v.selected then
						return v.value
					end
				end
			end
			if t.type == "input"
					and t.key ~= nil
					and t.key == name
			then
				return t.value
			end
		end
	end
	local function onLoad()
		print("Rotation \124cFF15E615Holy Dalvae")
		-- ni.GUI.AddFrame("Dalvae_Holy_Wotlk", items)
	end
	local function onUnload()
		print("Rotation \124cFFE61515stopped!")
		-- ni.GUI.DestroyFrame("Dalvae_Holy_Wotlk")
	end

	local cache = {
		-- enemies = false,
		-- friends = false,
		moving = false,
		curchannel = false,
		iscasting = false,
	};

	local queue = {
		"Cache",
		"Universal pause",
		"InnerFire",
		"PowerWordFortitude",
		"PrayerofSpirit",
		"PrayerofShadowProtection",
		"DesesperatePrayer",
		"Combat specific Pause",
		"GuardianSpirit",
		"Shadowfiend",
		"InnerFocus",
		"DivineHymn",
		"PrayerofHealing",
		"GreaterHeal",
		"FlashHealSurge",
		"Mending",
		"CircleofHealing",
		"FlashHeal",
		"Renew (All Members)"
	}
	local abilities = {


		["Cache"] = function()
			-- cache.targets = ni.unit.enemiesinrange(p, 30) or false
			-- cache.friends = ni.unit.friendsinrange(p, 40) or false
			cache.moving = ni.player.ismoving() or false;
			cache.iscasting = ni.player.iscasting() or false;
			cache.curchannel = ni.unit.ischanneling("player") or false;
		end,

		["Universal Pause"] = function()
			if IsMounted()
					or UnitIsDeadOrGhost("player")
					or ni.unit.buff("player", "Drink")
					or cache.curchannel
			then
				return true;
			end
		end,



		["InnerFire"] = function()
			if not ni.player.buff(spells.InnerFire.id)
			then
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
		["Combat specific Pause"] = function()
			if UnitAffectingCombat("player") then
				return false
			end
			for E = 1, #ni.members do
				if UnitAffectingCombat(ni.members[E].unit) then
					return false
				end
			end
			return true
		end,

		["DesesperatePrayer"] = function()
			if ni.spell.cd(spells.DesesperatePrayer.id) == 0
					and ni.player.hp() < 33
			then
				ni.spell.cast(spells.DesesperatePrayer.id)
			end
		end,
		["Shadowfiend"] = function()
			if ni.player.power() < 40 and ni.spell.available(34433) then
				ni.spell.cast(34433, "target")
				return true
			end
		end,
		["InnerFocus"] = function()
			if ni.members.average("player", 30) < 40 -- Importante ajustar este numero
					and ni.spell.available(spells.InnerFocus.id)
					and ni.spell.available(spells.PowerWordShield.id)
					and ni.spell.available(spells.DivineHymn.id)
					and not ni.unit.debuff("player", 6788)
					and not ni.unit.buff("player", spells.PowerWordShield.id, "player")
			then
				ni.spell.cast(spells.PowerWordShield.id, "player")
				ni.spell.cast(spells.InnerFocus.id)
				return true
			end
		end,
		["DivineHymn"] = function()
			if ni.player.buff(spells.InnerFocus.id)
					and not ni.player.ismoving()
					and ni.spell.available(spells.DivineHymn.id)
					and UnitChannelInfo("player") == nil
			then
				ni.spell.cast(spells.DivineHymn.id)
				return true
			end
		end,
		["Mending"] =
				function()
					if ni.spell.cd(spells.PrayerofMending.id) == 0
					then
						local renewActive = false
						for i = 1, #ni.members.inrange("player", 40) do
							if ni.unit.buff(ni.members[i].unit, spells.PrayerofMending.id, "player") then
								renewActive = true
								break
							end
						end
						-- No sé si funciona, tambien hay que agregarle una condicional para targetar aquel que tenga agro
						if not renewActive then
							for i = 1, #ni.members.inrange("player", 40) do
								if ni.members[i]:hp() < 99
										and not ni.unit.buff(ni.members[i].unit, spells.PrayerofMending.id, "player")
										and ni.spell.valid(ni.members[i].unit, spells.PrayerofMending.id, false, true, true) then
									ni.spell.cast(spells.PrayerofMending.id, ni.members[i].unit)
									return true
								end
							end
						end
					end
				end,
		["GuardianSpirit"] = function()
			if ni.spell.available(spells.GuardianSpirit.id)
			then
				for E = 1, #ni.members do
					local z = ni.members[E]
					if z:hp() <= 10 and z:valid(spells.GuardianSpirit.id, false, true, true) then
						ni.spell.cast(spells.GuardianSpirit.id, z.unit)
						return true
					end
				end
			end
		end,
		["CircleofHealing"] = function()
			if ni.spell.available(spells.CircleofHealing.id) then
				local P = ni.members.inrangebelow("player", 30, 97)
				if #P >= 2 then
					for E = 1, #ni.members do
						local z = ni.members[E]
						if z:hp() <= 96 and z:valid(spells.CircleofHealing.id, false, true) then
							ni.spell.cast(spells.CircleofHealing.id, z.unit)
							return true
						end
					end
				end
			end
		end,
		["Renew (All Members)"] = function()
			if ni.spell.available(spells.Renew.id) then
				for E = 1, #ni.members do
					local z = ni.members[E]
					if
							z:hp() <= 98 and not z:buff(spells.Renew.id, "player") and
							z:valid(spells.Renew.id, false, true, true)
					then
						ni.spell.cast(spells.Renew.id, z.unit)
						return true
					end
				end
			end
		end,
		-- 6725  el buffo de instant
		["FlashHeal"] = function()
			if ni.spell.available(spells.FlashHeal.id)
					and not ni.player.ismoving() then
				for E = 1, #ni.members do
					local z = ni.members[E]
					if z:hp() <= 85 and z:valid(spells.FlashHeal.id, false, true, true) then
						ni.spell.cast(spells.FlashHeal.id, z.unit)
						return true
					end
				end
			end
		end,
		["FlashHealSurge"] = function()
			if ni.spell.available(spells.FlashHeal.id)
					and ni.player.buff(33151) -- Surge of light
			then
				for E = 1, #ni.members do
					local z = ni.members[E]
					if z:hp() <= 8 and z:valid(spells.FlashHeal.id, false, true, true) then
						ni.spell.cast(spells.FlashHeal.id, z.unit)
						return true
					end
				end
			end
		end,
		["PrayerofHealing"] = function()
			if ni.unit.buffstacks("player", 63734) > 2 --Serendipity
					and not ni.player.ismoving()
			then
				local P = ni.members.inrangebelow("player", 30, 97)
				if #P >= 2 then
					for E = 1, #ni.members do
						local z = ni.members[E]
						if z:hp() <= 95 and z:valid(spells.PrayerofHealing.id, false, true) then
							ni.spell.cast(spells.PrayerofHealing.id, z.unit)
							return true
						end
					end
				end
			end
		end,
		["GreaterHeal"] = function()
			if ni.spell.available(spells.GreaterHeal.id)
					and ni.unit.buffstacks("player", 63734) > 2 --Serendipity
					and not ni.player.ismoving() then
				for E = 1, #ni.members do
					local z = ni.members[E]
					if z:hp() <= 68
							and z:valid(spells.GreaterHeal.id, false, true, true)
					then
						ni.spell.cast(spells.GreaterHeal.id, z.unit)
						return true
					end
				end
			end
		end,
	}

	ni.bootstrap.profile("Dalvae_Holy_Wotlk", queue, abilities, onLoad, onUnload)
end
