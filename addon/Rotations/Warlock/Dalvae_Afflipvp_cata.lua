local build = select(4, GetBuildInfo());
local cata = build == 40300 or false;
if cata then
	local queue   = {
		"Cache",
		"InterruptFocus",
		"InterruptCC",
		"InterruptHeal",
		"InterruptDanger",
		"WaitForChannel",
		"Pause",
		"ShadowBoltST",
		"CorruptAll", --
		"CurseMelees",
		"CurseCasters", --
	}
	local spells  = {
		ArmorSkills = { id = 76277, name = GetSpellInfo(76277), icon = select(3, GetSpellInfo(76277)) },
		AutoAttack = { id = 6603, name = GetSpellInfo(6603), icon = select(3, GetSpellInfo(6603)) },
		ColdWeatherFlying = { id = 54197, name = GetSpellInfo(54197), icon = select(3, GetSpellInfo(54197)) },
		Diplomacy = { id = 20599, name = GetSpellInfo(20599), icon = select(3, GetSpellInfo(20599)) },
		EveryManforHimself = { id = 59752, name = GetSpellInfo(59752), icon = select(3, GetSpellInfo(59752)) },
		FlightMastersLicense = { id = 90267, name = GetSpellInfo(90267), icon = select(3, GetSpellInfo(90267)) },
		Languages = { id = 79738, name = GetSpellInfo(79738), icon = select(3, GetSpellInfo(79738)) },
		MaceSpecialization = { id = 20864, name = GetSpellInfo(20864), icon = select(3, GetSpellInfo(20864)) },
		MasterRiding = { id = 90265, name = GetSpellInfo(90265), icon = select(3, GetSpellInfo(90265)) },
		Mastery = { id = 86478, name = GetSpellInfo(86478), icon = select(3, GetSpellInfo(86478)) },
		Nethermancy = { id = 86091, name = GetSpellInfo(86091), icon = select(3, GetSpellInfo(86091)) },
		Shoot = { id = 5019, name = GetSpellInfo(5019), icon = select(3, GetSpellInfo(5019)) },
		SwordSpecialization = { id = 20597, name = GetSpellInfo(20597), icon = select(3, GetSpellInfo(20597)) },
		TheHumanSpirit = { id = 20598, name = GetSpellInfo(20598), icon = select(3, GetSpellInfo(20598)) },
		WeaponSkills = { id = 76299, name = GetSpellInfo(76299), icon = select(3, GetSpellInfo(76299)) },
		--Affliction icon = select(2, GetSpellTabInfo(2))
		BaneofAgony = { id = 980, name = GetSpellInfo(980), icon = select(3, GetSpellInfo(980)) },
		BaneofDoom = { id = 603, name = GetSpellInfo(603), icon = select(3, GetSpellInfo(603)) },
		Corruption = { id = 172, name = GetSpellInfo(172), icon = select(3, GetSpellInfo(172)) },
		CurseofExhaustion = { id = 18223, name = GetSpellInfo(18223), icon = select(3, GetSpellInfo(18223)) },
		CurseoftheElements = { id = 1490, name = GetSpellInfo(1490), icon = select(3, GetSpellInfo(1490)) },
		CurseofTongues = { id = 1714, name = GetSpellInfo(1714), icon = select(3, GetSpellInfo(1714)) },
		CurseofWeakness = { id = 702, name = GetSpellInfo(702), icon = select(3, GetSpellInfo(702)) },
		DarkIntent = { id = 80398, name = GetSpellInfo(80398), icon = select(3, GetSpellInfo(80398)) },
		DeathCoil = { id = 6789, name = GetSpellInfo(6789), icon = select(3, GetSpellInfo(6789)) },
		DrainLife = { id = 689, name = GetSpellInfo(689), icon = select(3, GetSpellInfo(689)) },
		DrainSoul = { id = 1120, name = GetSpellInfo(1120), icon = select(3, GetSpellInfo(1120)) },
		Fear = { id = 5782, name = GetSpellInfo(5782), icon = select(3, GetSpellInfo(5782)) },
		Haunt = { id = 48181, name = GetSpellInfo(48181), icon = select(3, GetSpellInfo(48181)) },
		HowlofTerror = { id = 5484, name = GetSpellInfo(5484), icon = select(3, GetSpellInfo(5484)) },
		LifeTap = { id = 1454, name = GetSpellInfo(1454), icon = select(3, GetSpellInfo(1454)) },
		SeedofCorruption = { id = 27243, name = GetSpellInfo(27243), icon = select(3, GetSpellInfo(27243)) },
		ShadowMastery = { id = 87339, name = GetSpellInfo(87339), icon = select(3, GetSpellInfo(87339)) },
		SoulSwap = { id = 86121, name = GetSpellInfo(86121), icon = select(3, GetSpellInfo(86121)) },
		UnstableAffliction = { id = 30108, name = GetSpellInfo(30108), icon = select(3, GetSpellInfo(30108)) },
		--Demonology icon = select(2, GetSpellTabInfo(3))
		Banish = { id = 710, name = GetSpellInfo(710), icon = select(3, GetSpellInfo(710)) },
		ControlDemon = { id = 93375, name = GetSpellInfo(93375), icon = select(3, GetSpellInfo(93375)) },
		CreateHealthstone = { id = 6201, name = GetSpellInfo(6201), icon = select(3, GetSpellInfo(6201)) },
		CreateSoulstone = { id = 693, name = GetSpellInfo(693), icon = select(3, GetSpellInfo(693)) },
		DemonArmor = { id = 687, name = GetSpellInfo(687), icon = select(3, GetSpellInfo(687)) },
		DemonSoul = { id = 77801, name = GetSpellInfo(77801), icon = select(3, GetSpellInfo(77801)) },
		DemonicCircleSummon = { id = 48018, name = GetSpellInfo(48018), icon = select(3, GetSpellInfo(48018)) },
		DemonicCircleTeleport = { id = 48020, name = GetSpellInfo(48020), icon = select(3, GetSpellInfo(48020)) },
		EnslaveDemon = { id = 1098, name = GetSpellInfo(1098), icon = select(3, GetSpellInfo(1098)) },
		EyeofKilrogg = { id = 126, name = GetSpellInfo(126), icon = select(3, GetSpellInfo(126)) },
		FelArmor = { id = 28176, name = GetSpellInfo(28176), icon = select(3, GetSpellInfo(28176)) },
		HealthFunnel = { id = 755, name = GetSpellInfo(755), icon = select(3, GetSpellInfo(755)) },
		RitualofSouls = { id = 29893, name = GetSpellInfo(29893), icon = select(3, GetSpellInfo(29893)) },
		RitualofSummoning = { id = 698, name = GetSpellInfo(698), icon = select(3, GetSpellInfo(698)) },
		ShadowWard = { id = 6229, name = GetSpellInfo(6229), icon = select(3, GetSpellInfo(6229)) },
		SoulHarvest = { id = 79268, name = GetSpellInfo(79268), icon = select(3, GetSpellInfo(79268)) },
		SoulLink = { id = 19028, name = GetSpellInfo(19028), icon = select(3, GetSpellInfo(19028)) },
		Soulburn = { id = 74434, name = GetSpellInfo(74434), icon = select(3, GetSpellInfo(74434)) },
		Soulshatter = { id = 29858, name = GetSpellInfo(29858), icon = select(3, GetSpellInfo(29858)) },
		SummonImp = { id = 688, name = GetSpellInfo(688), icon = select(3, GetSpellInfo(688)) },
		SummonVoidwalker = { id = 697, name = GetSpellInfo(697), icon = select(3, GetSpellInfo(697)) },
		SummonFelhunter = { id = 691, name = GetSpellInfo(691), icon = select(3, GetSpellInfo(691)) },
		SummonSuccubus = { id = 712, name = GetSpellInfo(712), icon = select(3, GetSpellInfo(712)) },
		SummonFelguard = { id = 30146, name = GetSpellInfo(30146), icon = select(3, GetSpellInfo(30146)) },
		SummonDoomguard = { id = 18540, name = GetSpellInfo(18540), icon = select(3, GetSpellInfo(18540)) },
		SummonInfernal = { id = 1122, name = GetSpellInfo(1122), icon = select(3, GetSpellInfo(1122)) },
		UnendingBreath = { id = 5697, name = GetSpellInfo(5697), icon = select(3, GetSpellInfo(5697)) },
		--Destruction icon = select(2, GetSpellTabInfo(4))
		FelFlame = { id = 77799, name = GetSpellInfo(77799), icon = select(3, GetSpellInfo(77799)) },
		Hellfire = { id = 1949, name = GetSpellInfo(1949), icon = select(3, GetSpellInfo(1949)) },
		Immolate = { id = 348, name = GetSpellInfo(348), icon = select(3, GetSpellInfo(348)) },
		Incinerate = { id = 29722, name = GetSpellInfo(29722), icon = select(3, GetSpellInfo(29722)) },
		RainofFire = { id = 5740, name = GetSpellInfo(5740), icon = select(3, GetSpellInfo(5740)) },
		SearingPain = { id = 5676, name = GetSpellInfo(5676), icon = select(3, GetSpellInfo(5676)) },
		ShadowBolt = { id = 686, name = GetSpellInfo(686), icon = select(3, GetSpellInfo(686)) },
		Shadowflame = { id = 47897, name = GetSpellInfo(47897), icon = select(3, GetSpellInfo(47897)) },
		SoulFire = { id = 6353, name = GetSpellInfo(6353), icon = select(3, GetSpellInfo(6353)) },
		SpellLock = { id = 19647, name = GetSpellInfo(19647), icon = select(3, GetSpellInfo(19647)) },
	}
	local enables = {
		["Automated"] = true,
		["CorruptAll"] = true,
		["Weakness"] = true,
		["Tongues"] = true,
		["Interrupts"] = true,
		["InterruptAll"] = true,
		["InterruptFocus"] = false,
	}
	local values  = {
	}
	local inputs  = {}
	local menus   = {
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
		settingsfile = "Dalvae_Afflipvp_cata.xml",
		callback = GUICallback,
		{ type = "title",    text = "Dalvae Affliction PVP" },
		{ type = "separator" },
		{
			type = "entry",
			text = "\124T" .. spells.DrainLife.icon .. ":26:26\124tFully automated",
			tooltip = "It will fill with normal rotation",
			enabled = enables["Automated"],
			key = "CombatOnly"
		},
		{
			type = "entry",
			text = "\124T" .. spells.Corruption.icon .. ":26:26\124tCorruptAll",
			tooltip = "It will cast corruption on not CC targets ",
			enabled = enables["CorruptAll"],
			key = "CorruptAll"
		},
		{
			type = "entry",
			text = "\124T" .. spells.CurseofWeakness.icon .. ":26:26\124tWeakness or Exhaustion",
			tooltip = "It will cast curse of Weakness on Melee, if not checked it will cast Exhaustion",
			enabled = enables["Weakness"],
			key = "Weakness"
		},
		{
			type = "entry",
			text = "\124T" .. spells.CurseofTongues.icon .. ":26:26\124tCourse of Tongue on Casters",
			tooltip = "It will cast curse of Tongues on casters",
			enabled = enables["Tongues"],
			key = "Tongues"
		},
		{
			type = "entry",
			text = "\124T" .. spells.SpellLock.icon .. ":26:26\124t Enable interrupts",
			tooltip = "It will enable all interrupts",
			enabled = enables["Interrupts"],
			key = "Interrupts"
		},
		{
			type = "entry",
			text = "\124T" .. spells.SummonFelhunter.icon .. ":26:26\124t Enable interrupts All enemys",
			tooltip = "It will only cast interrupt on All enemys",
			enabled = enables["InterruptAll"],
			key = "InterruptAll"
		},
		{
			type = "entry",
			text = "\124T" .. spells.SummonFelhunter.icon .. ":26:26\124t Enable interrupts on focus",
			tooltip = "It will only cast interrupt on focus",
			enabled = enables["InterruptFocus"],
			key = "InterruptsFocus"
		},

	}
	local frames = {};
	local notfram = ni.utils.generaterandomname();
	frames.especialgui = CreateFrame("frame", notfram, UIParent);
	frames.especialgui.ranH2, frames.especialgui.ranH = random(91, 95), random(31, 38);
	frames.especialgui:SetSize(ChatFrame1:GetWidth(), frames.especialgui.ranH)
	frames.especialgui:Hide()
	frames.especialgui:SetPoint("BOTTOM", ChatFrame1)
	frames.especialgui.text = frames.especialgui:CreateFontString(nil, "OVERLAY", "MovieSubtitleFont")
	frames.especialgui.text:SetAllPoints()
	frames.especialgui.texture = frames.especialgui:CreateTexture()
	frames.especialgui.texture:SetAllPoints()
	frames.especialgui.texture:SetTexture(0, 0, 0, .50)
	function frames.especialgui:message(message)
		local pad = ""
		for i = 1, random(1, 255) do pad = pad .. "\124r" end
		self.text:SetText(pad .. message)
		self:Show()
	end

	local notfram2 = ni.utils.generaterandomname();
	frames.especialgui2 = CreateFrame("frame", notfram2, UIParent);
	frames.especialgui2.ranH2, frames.especialgui2.ranH = random(91, 95), random(31, 38);
	frames.especialgui2:SetSize(ChatFrame1:GetWidth(), frames.especialgui2.ranH)
	frames.especialgui2:Hide()
	frames.especialgui2:SetPoint("BOTTOM", notfram, "TOP")
	frames.especialgui2.text = frames.especialgui2:CreateFontString(nil, "OVERLAY", "MovieSubtitleFont")
	frames.especialgui2.text:SetAllPoints()
	frames.especialgui2.texture = frames.especialgui2:CreateTexture()
	frames.especialgui2.texture:SetAllPoints()
	frames.especialgui2.texture:SetTexture(0, 0, 0, .50)
	function frames.especialgui2:message(message)
		local pad = ""
		for i = 1, random(1, 255) do pad = pad .. "\124r" end
		self.text:SetText(pad .. message)
		self:Show()
	end

	local notfram3 = ni.utils.generaterandomname();
	frames.especialgui3 = CreateFrame("frame", notfram3, UIParent);
	frames.especialgui3.ranH2, frames.especialgui3.ranH = random(91, 95), random(31, 38);
	frames.especialgui3:SetSize(ChatFrame1:GetWidth(), frames.especialgui2.ranH)
	frames.especialgui3:Hide()
	frames.especialgui3:SetPoint("BOTTOM", notfram2, "TOP")
	frames.especialgui3.text = frames.especialgui3:CreateFontString(nil, "OVERLAY", "MovieSubtitleFont")
	frames.especialgui3.text:SetAllPoints()
	frames.especialgui3.texture = frames.especialgui3:CreateTexture()
	frames.especialgui3.texture:SetAllPoints()
	frames.especialgui3.texture:SetTexture(0, 0, 0, .50)
	function frames.especialgui3:message(message)
		local pad = ""
		for i = 1, random(1, 255) do pad = pad .. "\124r" end
		self.text:SetText(pad .. message)
		self:Show()
	end

	local function LosCast(spell, tar)
		if ni.player.los(tar)
				and IsSpellInRange(spell, tar) == 1
		then
			ni.spell.cast(spell, tar)
			return true
		end
		return false
	end
	local function LosCastStand(spell, tar)
		if ni.player.los(tar)
				and IsSpellInRange(spell, tar) == 1
		then
			ni.player.lookat(tar)
			ni.player.stopmoving()
			ni.spell.cast(spell, tar)
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
		if IsSpellKnown(id)
				and ni.spell.available(id)
				and ni.spell.valid(tar, id, false, true, true) then
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


	;
	local function OnLoad()
		ni.combatlog.registerhandler("Dalvae Affliction", CombatEventCatcher)
		ni.GUI.AddFrame("Dalvae Affliction", items)
		print("Rotation \124cFF15E615Dalvae Affliction pvp")
		-- ni.GUI.AddFrame("Tapto Disco", items)
	end
	;
	local function OnUnload()
		ni.combatlog.unregisterhandler("Dalvae Affliction")
		ni.GUI.DestroyFrame("Dalvae Affliction")
		print("Rotation \124cFFE61515stopped!")
	end

	local t, p = "target", "player"

	local function ToggleEnable(enableName)
		if enables[enableName] ~= nil then
			enables[enableName] = not enables[enableName]
			print(enableName .. " has been toggled. New value: " .. tostring(enables[enableName]))
		else
			print("Invalid enable name: " .. enableName)
		end
	end

	SLASH_INTERRUPTENABLES1          = "/interruptenables"
	SlashCmdList["INTERRUPTENABLES"] = function()
		if enables["Interrupts"]
		then
			enables["Interrupts"] = false
			frames.especialgui:Hide()
		else
			enables["Interrupts"] = true
			frames.especialgui:message("\124cFF15E615Interrupt Enable");
		end
	end
	SLASH_INTERRUPTALL1              = "/interruptall"
	SlashCmdList["INTERRUPTALL"]     = function()
		if enables["InterruptAll"]
		then
			enables["InterruptAll"] = false
			frames.especialgui2:Hide()
		else
			enables["InterruptAll"] = true
			frames.especialgui2:message("\124cFF15E615Interrupt EVERYONE");
		end
	end
	SLASH_INTERRUPTFOCUS1            = "/interruptfocus"
	SlashCmdList["INTERRUPTFOCUS"]   = function()
		if enables["InterruptFocus"]
		then
			enables["InterruptFocus"] = false
			frames.especialgui3:Hide()
		else
			enables["InterruptFocus"] = true
			frames.especialgui3:message("\124cFF15E615Interrupt FOCUS");
		end
	end
	-- Here we can add diferent switches

	SLASH_STOPGASTING1               = "/stopgasting"
	SlashCmdList["STOPGASTING"]      = function()
		ni.rotation.delay(2)
	end

	SLASH_BLAH1                      = "/blah"
	SlashCmdList["BLAH"]             = function()
		ni.rotation.delay(5)
	end
	local spellsdanger               = {
		-- Death Knight
		-- Druid
		2912, -- Starfire
		78674, -- Starsurge
		-- Hunter	
		-- Mage
		116, -- Frostbolt	
		11366, -- Pyroblast
		-- Paladin	
		-- Priest
		34914, -- Vampiric Touch
		73510, -- Mind Spike
		-- Rogue	
		-- Shaman
		51505, -- Lava Burst
		-- Warrior	
		-- Warlock
		48181, -- Haunt
		30108, -- Unstable Affliction
		6353, -- Soul Fire
	}

	local spellsheal                 = {
		-- Druid
		8963, -- Regrowth
		50464, -- Nourish
		5185, -- Healing Touch
		-- Paladin	
		19750, -- Flash of Light
		82326, -- Divine Light
		635, -- Holy Light
		82327, -- Holy Radiance
		-- Shaman
		1064, -- Chain Heal
		8004, -- Healing Surge
		77472, -- Greater Healing Wave
		331, -- Healing Wave
		73920, -- Healing Rain
		-- Priest
		47540, -- Pennance
		32546, -- Binding Heal
		2061, -- Flash Heal
		2060, -- Greater Heal
		64843, -- Divine Hymn
		596, -- Prayer Of Healing
	}
	local inmune                     = {
		-- Death Knight
		48707, -- Anti-Magic Shell	
		-- Hunter
		19263, -- Deterrence
		-- Mage
		45438, -- Ice Block
		-- Paladin
		642, -- Divine Shield
		-- Rogue
		31221, -- Cloak of Shadows
	}
	local inmuneinterrupt            = {
		31821, -- Aura Mastery
		-- Priest
		89485, -- Inner Focus
	}
	local interruptcc                = {
		-- Druid
		88010, -- Cyclone
		-- Mage
		118, -- Polymorph	
		--Shamn
		51514, --Hex
		-- Warlock
		5782, -- Fear

	}
	local breakcc                    = {
		-- Death Knight
		49203, -- Hungering Cold
		-- Druid
		88010, -- Cyclone
		-- Hunter
		19503, -- Scatter Shot
		90337, -- Bad Manner
		3355, -- Freezing trap
		1513, -- Scare Beast
		2637, -- Hibernate
		-- Mage
		118, -- Polymorph
		82676, -- Ring Of Frost
		-- Paladin
		10326, -- Turn Evil
		20066, -- Repentance
		-- Rogue
		2094, -- Blind	
		-- Shaman
		51514, --Hex	
		-- Warrior
		5246, -- Intimidating Shout
		-- Warlock
		710, -- Banish
		6358, -- Seduction
		-- Death Knight
		48707, -- Anti-Magic Shell

		-- Druid	
		-- Hunter
		19263, -- Deterrence
		-- Mage
		45438, -- Ice Block

		-- Paladin
		642, -- Divine Shield
		-- Rogue
		2094, -- Blind
		6770, -- Sap
		-- 31221, -- Cloak of Shadows
	}
	local priorityccbuffs            = {
		5782, -- fear Warlock
		118, -- Poly Sheep.
		853, -- Hammer of justice
		6770, -- Sap
		2094, -- Blind


	}

	local Cache                      = {
		targets = nil,
		curchannel = nil,
		iscasting = nil,
		moving = ni.player.ismoving(),
		enemies = ni.unit.enemiesinrange(p, 40),
	}

	-- local talents         = {
	-- 	DoomandGloom = GetTalentInfo(1, 1),            -- (0/2)
	-- 	ImprovedLifeTap = GetTalentInfo(1, 2),         -- (2/2)
	-- 	ImprovedCorruption = GetTalentInfo(1, 3),      -- (3/3)
	-- 	Jinx = GetTalentInfo(1, 4),                    -- (2/2)
	-- 	SoulSiphon = GetTalentInfo(1, 5),              -- (2/2)
	-- 	SiphonLife = GetTalentInfo(1, 6),              -- (2/2)
	-- 	CurseofExhaustion = GetTalentInfo(1, 7),       -- (1/1)
	-- 	ImprovedFear = GetTalentInfo(1, 8),            -- (0/2)
	-- 	Eradication = GetTalentInfo(1, 9),             -- (3/3)
	-- 	ImprovedHowlofTerror = GetTalentInfo(1, 10),   -- (2/2)
	-- 	SoulSwap = GetTalentInfo(1, 11),               -- (1/1)
	-- 	ShadowEmbrace = GetTalentInfo(1, 12),          -- (3/3)
	-- 	DeathsEmbrace = GetTalentInfo(1, 13),          -- (3/3)
	-- 	Nightfall = GetTalentInfo(1, 14),              -- (2/2)
	-- 	SoulburnSeedofCorruption = GetTalentInfo(1, 15), -- (0/1)
	-- 	EverlastingAffliction = GetTalentInfo(1, 16),  -- (3/3)
	-- 	Pandemic = GetTalentInfo(1, 17),               -- (2/2)
	-- 	Haunt = GetTalentInfo(1, 18),                  -- (1/1)
	-- 	--Demonology
	-- 	DemonicEmbrace = GetTalentInfo(2, 1),          -- (3/3)
	-- 	DarkArts = GetTalentInfo(2, 2),                -- (0/3)
	-- 	FelSynergy = GetTalentInfo(2, 3),              -- (2/2)
	-- 	DemonicRebirth = GetTalentInfo(2, 4),          -- (2/2)
	-- 	ManaFeed = GetTalentInfo(2, 5),                -- (0/2)
	-- 	DemonicAegis = GetTalentInfo(2, 6),            -- (2/2)
	-- 	MasterSummoner = GetTalentInfo(2, 7),          -- (0/2)
	-- 	ImpendingDoom = GetTalentInfo(2, 8),           -- (0/3)
	-- 	DemonicEmpowerment = GetTalentInfo(2, 9),      -- (0/1)
	-- 	ImprovedHealthFunnel = GetTalentInfo(2, 10),   -- (0/2)
	-- 	MoltenCore = GetTalentInfo(2, 11),             -- (0/3)
	-- 	HandofGuldan = GetTalentInfo(2, 12),           -- (0/1)
	-- 	AuraofForeboding = GetTalentInfo(2, 13),       -- (0/2)
	-- 	AncientGrimoire = GetTalentInfo(2, 14),        -- (0/2)
	-- 	Inferno = GetTalentInfo(2, 15),                -- (0/1)
	-- 	Decimation = GetTalentInfo(2, 16),             -- (0/2)
	-- 	Cremation = GetTalentInfo(2, 17),              -- (0/2)
	-- 	DemonicPact = GetTalentInfo(2, 18),            -- (0/1)
	-- 	Metamorphosis = GetTalentInfo(2, 19),          -- (0/1)
	-- 	--Destruction
	-- 	Bane = GetTalentInfo(3, 1),                    -- (0/3)
	-- 	ShadowandFlame = GetTalentInfo(3, 2),          -- (0/3)
	-- 	ImprovedImmolate = GetTalentInfo(3, 3),        -- (0/2)
	-- 	Aftermath = GetTalentInfo(3, 4),               -- (0/2)
	-- 	Emberstorm = GetTalentInfo(3, 5),              -- (0/2)
	-- 	ImprovedSearingPain = GetTalentInfo(3, 6),     -- (0/2)
	-- 	ImprovedSoulFire = GetTalentInfo(3, 7),        -- (0/2)
	-- 	Backdraft = GetTalentInfo(3, 8),               -- (0/3)
	-- 	Shadowburn = GetTalentInfo(3, 9),              -- (0/1)
	-- 	BurningEmbers = GetTalentInfo(3, 10),          -- (0/2)
	-- 	SoulLeech = GetTalentInfo(3, 11),              -- (0/2)
	-- 	Backlash = GetTalentInfo(3, 12),               -- (0/3)
	-- 	NetherWard = GetTalentInfo(3, 13),             -- (0/1)
	-- 	FireandBrimstone = GetTalentInfo(3, 14),       -- (0/3)
	-- 	Shadowfury = GetTalentInfo(3, 15),             -- (0/1)
	-- 	NetherProtection = GetTalentInfo(3, 16),       -- (0/2)
	-- 	EmpoweredImp = GetTalentInfo(3, 17),           -- (0/2)
	-- 	BaneofHavoc = GetTalentInfo(3, 18),            -- (0/1)
	-- 	ChaosBolt = GetTalentInfo(3, 19),              -- (0/1)

	-- }
	local abilities                  = {
		["Pause"] = function()
			if
					IsMounted()
					or UnitIsDeadOrGhost(p)
					or not UnitAffectingCombat("player")

					or UnitIsDeadOrGhost(t)
			then
				return true
			end
		end,

		["Cache"] = function()
			-- Cache.targets = ActiveEnemies()
			Cache.moving = ni.player.ismoving()
			Cache.curchannel = UnitChannelInfo(p)
			Cache.enemies = ni.unit.enemiesinrange(p, 40)
			Cache.iscasting = UnitCastingInfo(p)
		end,

		["InterruptCC"] = function()
			if enables["Interrupts"]
					and enables["InterruptAll"]
			then
				if ni.spell.cd(spells.SpellLock.id) == 0
				then
					for i = 1, #Cache.enemies do
						local target = Cache.enemies[i].guid
						if (ni.unit.ischanneling(target)
									or ni.unit.castingpercent(target) >= 85)
								and ni.unit.isplayer(target)
								and ni.player.los(target)
						then
							-- print("pass")
							local castingSpell = select(3, UnitCastingInfo(target))
							for j = 1, #interruptcc do
								if castingSpell == GetSpellInfo(interruptcc[j])
										and ni.unit.ischanneling(target)
										or ni.unit.castingpercent(target) >= 85
								then
									ni.spell.cast(spells.SpellLock.id, target)
								end
							end
						end
					end
				end
			end
		end,
		["InterruptHeal"] = function()
			if enables["Interrupts"]
					and enables["InterruptAll"]
			then
				if ni.spell.cd(spells.SpellLock.id) == 0
				then
					for i = 1, #Cache.enemies do
						local target = Cache.enemies[i].guid
						if (ni.unit.ischanneling(target)
									or ni.unit.castingpercent(target) >= 85)
								and ni.unit.isplayer(target)
						then
							local castingSpell = select(3, UnitCastingInfo(target))
							for j = 1, #spellsheal do
								if castingSpell == GetSpellInfo(spellsheal[j])
										and ni.unit.castingpercent(target) >= 85
								then
									ni.spell.cast(spells.SpellLock.id, target)
								end
							end
						end
					end
				end
			end
		end,

		["InterruptDanger"] = function()
			if enables["Interrupts"]
					and enables["InterruptAll"]
			then
				if ni.spell.cd(spells.SpellLock.id) == 0
				then
					for i = 1, #Cache.enemies do
						local target = Cache.enemies[i].guid
						if (ni.unit.ischanneling(target)
									or ni.unit.castingpercent(target) >= 85)
								and ni.unit.isplayer(target)
						then
							-- print("pass")
							local castingSpell = select(3, UnitCastingInfo(target))
							for j = 1, #spellsdanger do
								if castingSpell == GetSpellInfo(spellsdanger[j])
										and ni.unit.castingpercent(target) >= 85
								then
									ni.spell.cast(spells.SpellLock.id, target)
								end
							end
						end
					end
				end
			end
		end,
		["InterruptFocus"] = function()
			if enables["Interrupts"] then
				if enables["InterruptFocus"] then
					if ni.unit.exists("focus")
							and ni.unit.iscasting("focus")
							and ni.player.los("focus")
							and (ni.unit.ischanneling("focus")
								or ni.unit.castingpercent("focus") >= 85)
					then
						ni.spell.cast(spells.SpellLock.id, "focus")
					end
				end
			end
		end,

		["WaitForChannel"] = function()
			if Cache.curchannel == spells.DrainLife.name
					or
					Cache.curchannel == spells.DrainSoul.name then
				return true
			end
		end,
		["CorruptAll"] = function()
			if enables["CorruptAll"] then
				local hasHunterInParty = false


				for i = 1, GetNumGroupMembers() do
					local unit = "party" .. i
					local _, class = UnitClass(unit)

					if class == "HUNTER" then
						hasHunterInParty = true
					end
				end

				for i = 1, #Cache.enemies do
					local target = Cache.enemies[i].guid
					local hasBreakCC = false
					local class = UnitClass(target)
					for j = 1, #breakcc do
						if ni.unit.debuff(target, breakcc[j])
						then
							hasBreakCC = true
							break
						end
					end

					if not hasBreakCC
							and ni.player.los(target)
							and not ni.unit.istotem(target)
							and not ni.unit.debuff(target, spells.Corruption.id, p)
							and NotInmune(target)
					then
						if class == "MAGE"
								and not ni.unit.isplayer(target)
						then
							break
						else
							if hasHunterInParty then
								if ni.unit.exists("focus")
										and UnitGUID("focus") ~= target
								then --
									ni.spell.delaycast(spells.Corruption.id, target, 1.5)
								end
							else
								ni.spell.delaycast(spells.Corruption.id, target, 1.5)
							end
						end
					end
				end
			end
		end,
		["CurseMelees"] = function()
			for i = 1, #Cache.enemies do
				local target = Cache.enemies[i].guid
				local class = UnitClass(target)

				if class --This could be dangerous if you want to curse pets
						and ni.player.los(target)
						and NotInmune(target)
						and not ni.unit.debuff(target, spells.CurseoftheElements.id, p) then
					if (class == "Druid"
								and ni.unit.buff(target, 24932)) -- Leader of the pack for feral
							or class == "Rogue"
							or class == "Warrior"
							or class == "Deathknight" then
						if enables["Weakness"] then
							if not ni.unit.debuff(target, spells.CurseofWeakness.id, p) then
								ni.spell.cast(spells.CurseofWeakness.id, target)
								print("Weakness on " .. Cache.enemies[i].name)
							end
						else
							if not ni.unit.debuff(target, spells.CurseofExhaustion.id, p) then
								ni.spell.cast(spells.CurseofExhaustion.id, target)
								print("Exhaustion on " .. Cache.enemies[i].name)
							end
						end
					end
				end
			end
		end,

		["CurseCasters"] = function()
			if enables["Tongues"] then
				for i = 1, #Cache.enemies do
					local target = Cache.enemies[i].guid
					local class = UnitClass(target)
					local name = Cache.enemies[i].name


					if class and ni.player.los(target)
							and NotInmune(target)
							and not ni.unit.debuff(target, spells.CurseoftheElements.id, p) then
						if (class == "Druid"
									and not ni.unit.buff(target, 24932))
								or class == "Mage"
								or class == "Warlock"
								or class == "Shaman"
								or class == "Priest"
								or class == "Paladin"
								or class == "Ebon Gargoyle"
						-- or class == "Searing Totem" -- Not worth
						then
							if not ni.unit.debuff(target, spells.CurseofTongues.id, p) then
								ni.spell.cast(spells.CurseofTongues.id, target)
								print("Tongues on " .. Cache.enemies[i].name)
							end
						end
					end
				end
			end
		end,
		["ShadowBoltST"] = function()
			if ni.player.buff(17941)
					and ni.unit.exists(t)
					and ni.player.los(t)
					and NotInmune(t)
			then
				ni.spell.cast(spells.ShadowBolt.id, t)
			end
		end,

	}
	ni.bootstrap.profile("Dalvae_Afflipvp_cata", queue, abilities, OnLoad, OnUnload)
else
	local queue = {
		"Error",
	};
	local abilities = {
		["Error"] = function()
			ni.vars.profiles.enabled = false;
			if not cata then
				ni.frames.floatingtext:message("Only for Cata")
			end
		end,
	};
end
-- TODO
-- One check for "all interrupts", and then nested checks for "interrupt all people" and "interrupt only focus"  The method is done, we neet to apply
-- Find a Way to detect Retrys, Shamnenha, and the same for balance,holy, etc.
-- Interrupts with DeathCoil or Fear
-- Fear Focus? why you dont you ask for a fear on focus?
-- Add fillers to the rotations.
-- Use CD  and Aoe toggler for (totems?)
