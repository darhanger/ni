local items = {
	settingsfile = "Nrdr_Prot_MoP.xml",
	{ type = "title", text = "Prot Pally" },
	{ type = "separator" },
	{ type = "page", number = 1, text = "Main Options" },
	{ type = "separator" },
	{ type = "entry", text = "Combat Check", enabled = true, key = "Combat" },
	{ type = "entry", text = "Auto Eat Feasts", enabled = false, key = "Feasts" },
	{ type = "entry", text = "Active Cooldowns", enabled = false, key = "Cooldowns" },
	{ type = "entry", text = "Debug Printing", enabled = false, key = "Debug" },
	{ type = "separator" },
	{ type = "entry", text = "Cast Seal", enabled = true, key = "Seal" },
	{ type = "dropdown", menu = {
		{ selected = true, value = 1, text = "|cffFF0066Auto" },
		{ selected = false, value = 2, text = "|cffFFFF33Truth" },
		{ selected = false, value = 3, text = "|cffFF9900Insight" },
		{ selected = false, value = 4, text = "|cff24E0FBRighteousness" },
	}, key = "ActiveSeal" },
	{ type = "separator" },
	{ type = "entry", text = "Auto Blessing", enabled = true, key = "Blessing" },
	{ type = "dropdown", menu = {
		{ selected = true, value = 1, text = "|cffFF0066Auto" },
		{ selected = false, value = 2, text = "|cff24E0FBKings" },
		{ selected = false, value = 3, text = "|cffFF9900Might" },
	}, key = "ActiveBlessing" },
	{ type = "separator" },
	{ type = "entry", text = "Righteous Fury", enabled = true, key = "Righteous" },
	{ type = "entry", text = "Execution Sentence", enabled = true, key = "Execution" },
	{ type = "title", text = "Execution Sentence Vengeance Threshold" },
	{ type = "input", value = "75000", key = "ExecutionVengeance" },
	{ type = "separator" },
	{ type = "entry", text = "Sacred Shield Vengeance", enabled = true, key = "Sacred" },
	{ type = "title", text = "Vengeance to overwrite SS/EF" },
	{ type = "input", value = "75000", key = "SacredVengeance" },
	{ type = "separator" },
	{ type = "page", number = 2, text = "Healing Options" },
	{ type = "separator" },
	{ type = "entry", text = "Active Healing", enabled = true, key = "GroupHeal" },
	{ type = "entry", text = "Eternal Flame (Self)", enabled = true, value = 70, key = "EternalFlame" },
	{ type = "entry", text = "Word of Glory", enabled = true, value = 60, key = "WoG" },
	{ type = "entry", text = "Lay on Hands", enabled = true, value = 17, key = "LoH" },
	{ type = "entry", text = "Holy Prism", enabled = true, value = 32, key = "HolyPrism" },
	{ type = "entry", text = "Flash of Light", enabled = true, value = 70, key = "FoL" },
	{ type = "entry", text = "Healthstone", enabled = true, value = 25, key = "Healthstone" },
	{ type = "entry", text = "Selfless Healer", enabled = true, value = 60, key = "SelflessHealer" },
	{ type = "page", number = 3, text = "Utility Options" },
	{ type = "separator" },
	{ type = "entry", text = "Hand of Sacrifice", enabled = true, value = 35, key = "HandOfSac" },
	{ type = "entry", text = "Hand of Salvation", enabled = true, value = 80, key = "HandofSalv" },
	{ type = "entry", text = "Hand of Protection", enabled = true, value = 45, key = "HandOfProt" },
	{ type = "entry", text = "Hand of Freedom (Self)", enabled = false, key = "HandOfFreedom" },
	{ type = "entry", text = "Ardent Defender", enabled = true, value = 12, key = "ArdentDefender" },
	{ type = "page", number = 4, text = "Utility Options #2" },
	{ type = "separator" },
	{ type = "entry", text = "Divine Protection", enabled = false, value = 45, key = "DivineProtection" },
	{ type = "entry", text = "Guardian of Ancient Kings", enabled = false, value = 30, key = "GoAK" },
	{ type = "entry", text = "Sacred Shield", enabled = false, value = 100, key = "SacredShield" },
	{ type = "title", text = "Shield of the Righteous" },
	{ type = "dropdown", menu = {
		{ selected = false, value = 1, text = "Manual" },
		{ selected = false, value = 2, text = "3 HP" },
		{ selected = false, value = 3, text = "4 HP" },
		{ selected = false, value = 4, text = "5 HP" },
		{ selected = true, value = 5, text = "Wise Mode" },
	}, key = "ActiveSoTR" },
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
end;
local lastJudgementGUID = 0;
local playerName = UnitName("player");
local function CombatEventCatcher(event, ...)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local _, subevent, _, sourceGUID, sourceName, _, _, destGUID, destName = ...;
		if subevent == "SPELL_DAMAGE" then
			if select(12, ...) == 20271
			 and sourceName == playerName then
				lastJudgementGUID = destGUID;
			end
		end
	end
end
local function OnLoad()
	ni.GUI.AddFrame("Prot - MoP", items);
	ni.combatlog.registerhandler("Prot - MoP", CombatEventCatcher);
end
local function OnUnload()
	ni.GUI.DestroyFrame("Prot - MoP");
	ni.combatlog.unregisterhandler("Prot - MoP");
end
local spells = {
	ArdentDefender = { id =	31850, name = GetSpellInfo(31850) },
	AvengersShield = { id =	31935, name = GetSpellInfo(31935) },
	AvengingWrath =	{ id = 31884, name = GetSpellInfo(31884) },
	BeaconOfLight = { id = 53563, name = GetSpellInfo(53563) },	
	Berserking = { id =	26297, name = GetSpellInfo(26297) },  
	BlessingOfKings	= { id = 20217, name = GetSpellInfo(20217) },
	BlessingOfMight	= { id = 19740, name = GetSpellInfo(19740) },
	BlindingLight =	{ id = 115750, name = GetSpellInfo(115750) },
	BloodFury = { id = 20572, name = GetSpellInfo(20572) }, 
	Cleanse	= { id = 4987, name = GetSpellInfo(4987) },
	Consecration = { id = 26573, name = GetSpellInfo(26573) },
	CrusaderStrike = { id =	35395, name = GetSpellInfo(35395) },
	Denounce = { id = 2812, name = GetSpellInfo(2812) },
	DevotionAura = { id = 31821, name = GetSpellInfo(31821) },
	DivineLight	= { id = 82326, name = GetSpellInfo(82326) },
	DivinePlea = { id =	54428, name = GetSpellInfo(54428) },
	DivineProtection = { id = 498, name = GetSpellInfo(498) },
	DivineShield = { id = 642, name = GetSpellInfo(642) },
	DivineStorm = { id = 53385, name = GetSpellInfo(53385) },
	EternalFlame = { id = 114163, name = GetSpellInfo(114163) },
	ExecutionSentence =	{ id = 114157, name = GetSpellInfo(114157) },
	Exorcism = { id = 879, name = GetSpellInfo(879) },
	FistOfJustice =	{ id = 105593, name = GetSpellInfo(105593) },
	FlashOfLight = { id = 19750, name = GetSpellInfo(19750) },
	HandOfFreedom =	{ id = 1044, name = GetSpellInfo(1044) },
	HandOfProtection = { id = 1022, name = GetSpellInfo(1022) },
	HandOfPurity = { id = 114039, name = GetSpellInfo(114039) },
	HandOfSacrifice	= { id = 6940, name = GetSpellInfo(6940) },
	HandOfSalvation	= { id = 1038, name = GetSpellInfo(1038) },
	HammerOfJustice = { id = 853, name = GetSpellInfo(853) },
	HammerOfTheRighteous = { id = 53595, name = GetSpellInfo(53595) },
	HammerOfWrath =	{ id = 24275, name = GetSpellInfo(24275) },
	HolyAvenger	= { id = 105809, name = GetSpellInfo(105809) },
	HolyLight =	{ id = 635, name = GetSpellInfo(635) },
	HolyPrism =	{ id = 114165, name = GetSpellInfo(114165) },
	HolyRadiance = { id = 82327, name = GetSpellInfo(82327) },
	HolyShock = { id = 20473, name = GetSpellInfo(20473) },
	HolyWrath = { id = 119072, name = GetSpellInfo(119072) },
	GiftOfTheNaaru = { id =	59542, name = GetSpellInfo(59542) },
	GuardianOfAncientKings = { id =	86659, name = GetSpellInfo(86659) },
	Inquisition	= { id = 84963, name = GetSpellInfo(84963) },
	Judgement =	{ id = 20271, name = GetSpellInfo(20271) },
	LayOnHands = { id =	633, name = GetSpellInfo(633) },
	LightOfDawn = { id = 85222, name = GetSpellInfo(85222) },
	LightsHammer = { id = 114158, name = GetSpellInfo(114158) },
	MassExorcism = { id = 122032, name = GetSpellInfo(122032) },
	MassResurection = { id = 83968, name = GetSpellInfo(83968) },
	Reckoning =	{ id = 62124, name = GetSpellInfo(62124) },
	Redemption = { id =	7328, name = GetSpellInfo(7328) },
	RighteousFury =	{ id = 25780, name = GetSpellInfo(25780) },			
	Repentance = { id =	20066, name = GetSpellInfo(20066) },
	SacredShield = { id = 20925, name = GetSpellInfo(20925) },
	SealOfInsight =	{ id = 20165, name = GetSpellInfo(20165) },
	SealOfRighteousness = { id = 20154, name = GetSpellInfo(20154) },
	SealOfThruth = { id = 31801, name = GetSpellInfo(31801) },
	ShieldOfTheRighteous = { id = 53600, name = GetSpellInfo(53600) },
	SpeedOfLight = { id = 85499, name = GetSpellInfo(85499) },
	TemplarsVerdict = { id = 85256, name = GetSpellInfo(85256) },
	TurnEvil = { id = 10326, name = GetSpellInfo(10326) },
	WordOfGlory = { id = 85673, name = GetSpellInfo(85673) }
}
local function HaveAbility(spell)
	if IsSpellKnown(spell) or IsPlayerSpell(spell) then
		return true;
	end
	return false;
end
local function HolyPower()
	return UnitPower("player", 9)
end
local function available(spell)
	return ni.spell.available(spell, true)
end
local function CanHeal(unit)
	if UnitIsUnit("player", unit) ~= nil then
		return true;
	end
	if UnitIsCharmed(unit) ~= 1
	 and UnitInRange(unit) == true
	 and ni.unit.exists(unit)
	 and UnitCanCooperate("player", unit) ~= nil
	 and UnitIsDeadOrGhost(unit) ~= 1
	 and ni.player.los(unit)
	 and not ni.unit.debuff(unit, 104451)
	 and not ni.unit.debuff(unit, 76577)
	 and not ni.unit.debuff(unit, 121949)
	 and not ni.unit.debuff(unit, 122784)
	 and not ni.unit.debuff(unit, 122370)
	 and not ni.unit.debuff(unit, 123184)
	 and not ni.unit.debuff(unit, 123255)
	 and not ni.unit.debuff(unit, 123596)
	 and not ni.unit.debuff(unit, 128353) then
		if ni.player.debuff(116260) then
			if ni.unit.debuff(unit, 116260) then
				return true;
			else
				return false;
			end
		elseif ni.player.debuff(116161) then
			if ni.unit.debuff(116161) then
				return true;
			else
				return false;
			end
		else
			if ni.unit.debuff(unit, 116260) or ni.unit.debuff(unit, 116161) then
				return false;
			else
				return true;
			end
		end
	else
		return false;
	end
end
local targets = {
	"target",
	"mouseover",
	"focus",
	"focustarget",
	"targettarget"
}
local melee_spell = GetSpellInfo(35395);
local function MeleeTarget(facing)
	for _, v in ipairs(targets) do
		if UnitExists(v)
		 and UnitCanAttack("player", v) then
			if (facing == false or ni.player.isfacing(v, 90))
			 and IsSpellInRange(melee_spell, v) == 1 then
				return v, true;
			end
		end
	end
	return "target", false;
end
local function SixHolyPoW()
	local holypower = HolyPower();
	if (ni.spell.cd(35395) < 1
	 or ni.spell.cd(20271) < 1
	 or ni.player.buff(85416))
	 and (holypower == 5
	 or (ni.player.buff(90174)
	 and holypower > 2)) then
		return true;
	end
	return false;
end
local function HandActive(unit)
	if ni.unit.buff(unit, spells.HandOfFreedom.name)
	 or ni.unit.buff(unit, spells.HandOfProtection.name)
	 or ni.unit.buff(unit, spells.HandOfPurity.name)
	 or ni.unit.buff(unit, spells.HandOfSacrifice.name)
	 or ni.unit.buff(unit, spells.HandOfSalvation.name) then
		return true;
	end
	return false;
end
local bufftimer = 0;
local LastVengeance = 0;
local vengeance_aura = GetSpellInfo(93098);
local function GetVengeance()
	if ni.player.buff(93098) then
		local _, _, _, _, _, _, VengeanceTimer, _, _, _, _, _, _, _, Vengeance = UnitAura("player", vengeance_aura);
		local VengeanceFade = VengeanceTimer - GetTime();
		return Vengeance, VengeanceFade;
	else
		return 0, 0;
	end
end
local t16 = {
	99126,
	99127,
	99128,
	99129,
	99130,
}
local function TierEquipped(set, pieces)
	local equipped = 0;
	for i = 1, 19 do
		local id = GetInventoryItemID("player", i);
		if id
		 and tContains(set, id) then
			equipped = equipped + 1;
		end
	end
	if pieces then
		if equipped >= pieces then
			return true;
		else
			return false;
		end
	else
		return equipped;
	end
end
local settings = {
	active_healing = true,
}
local NoLoHBosses = {
	68036,
	68078,
	68476
}
local FreedomDebuffs = {

}
local queue = {
	"pause",
	"selfless healer",
	"eternal flame (active)",
	"shield of the righteous",
	"gift of the naaru",
	"righteous fury",
	"seal",
	"blessings",
	"defensive cds",
	"lay on hands",
	"hand of salvation",
	"hand of protection",
	"hand of sacrifice",
	"hand of freedom",
	"sacred shield",
	"flash of light",
	"eternal flame",
	"word of glory",
	"combat check",
	"healthstone",
	"goak",
	"active cooldowns",
	"eternal flame (self)",
	"avengers shield",
	"crusader strike/hammer of the righteous",
	"judgement",
	"execution sentence",
	"hammer of wrath",
	"avengers shield #2",
	"consecration",
	"holy wrath",
	"holy prism"
}
local abilities = {
	["pause"] = function()
		if SpellIsTargeting()
		 or ni.player.buff(104934)
		 or ni.player.buff(80169)
		 or ni.player.buff(87959)
		 or ni.player.buff(11392)
		 or ni.player.buff(3680)
		 or UnitChannelInfo("player")
		 or UnitIsDeadOrGhost("player")
		 or UnitIsDeadOrGhost("target")
		 or IsMounted() then
			return true;
		end
		ni.vars.debug = select(2, GetSetting("Debug"));
	end,
	["selfless healer"] = function()
		local value, enabled = GetSetting("SelflessHealer");
		if enabled
		 and HaveAbility(spells.FlashOfLight.id)
		 and ni.player.buffstacks(114250) == 3 then
			if ni.player.hp() <= value then
				ni.spell.cast(spells.FlashOfLight.name, "player");
				return true;
			elseif ni.members[1].hp <= value
			 and ni.members[1].range then
				ni.spell.cast(spells.FlashOfLight.name, ni.members[1].unit);
				return true;
			end
		end
	end,
	["eternal flame (active)"] = function()
		settings.active_healing = select(2, GetSetting("GroupHeal"));
		local value, enabled = GetSetting("WoG");
		if enabled
		 and settings.active_healing
		 and available(spells.EternalFlame.id) then
			local holypower = HolyPower();
			if holypower >= 3 or ni.player.buff(90174) then
				for i = 1, #ni.members do
					if CanHeal(ni.members[i].unit)
					 and ni.members[i].hp <= value
					 and not ni.unit.buff(ni.members[i].unit, 114163) then
						ni.spell.cast(spells.EternalFlame.name, ni.members[i].unit);
						return true;
					end
				end
			end
			if holypower == 5 or ni.player.buff(90174) then
				if not ni.player.buff(114163) then
					ni.spell.cast(spells.EternalFlame.name, "player");
					return true;
				end
				for i = 1, #ni.members do
					if CanHeal(ni.members[i].unit)
					 and not ni.unit.buff(ni.members[i].unit, 114163) then
						ni.spell.cast(spells.EternalFlame.name, ni.members[i].unit);
						return true;
					end
				end
			end
		end		
	end,
	["shield of the righteous"] = function()
		if available(spells.ShieldOfTheRighteous.id) then
			local value = GetSetting("ActiveSoTR");
			local holypower = HolyPower();
			local target = MeleeTarget();
			if ni.player.buff(105809)
			 or ni.player.buff(90174)
			 and holypower >= 3 then
				ni.spell.cast(spells.ShieldOfTheRighteous.name, target);
				return true;
			end
			if (value == 5 and SixHolyPoW())
			 or (value == 4 and holypower == 5)
			 or (value == 3 and holypower >= 4)
			 or (value == 2 and holypower >= 3) then
				ni.spell.cast(spells.ShieldOfTheRighteous.name, target);
				return true;
			end
		end
	end,
	["gift of the naaru"] = function()
		if available(spells.GiftOfTheNaaru.id)
		 and ni.members[1].hp < 30
		 and CanHeal(ni.members[1].unit) then
			ni.spell.cast(spells.GiftOfTheNaaru.name, ni.members[1].unit);
			return true;
		end
	end,
	["righteous fury"] = function()
		local enabled = select(2, GetSetting("Righteous"));
		if enabled 
		 and available(spells.RighteousFury.id) 
		 and not ni.player.buff(spells.RighteousFury.name) then
			ni.spell.cast(spells.RighteousFury.name);
			return true;
		end
	end,
	["seal"] = function()
		local enabled = select(2, GetSetting("Seal"));
		if enabled then
			local value = GetSetting("ActiveSeal");
			if value == 1 then
				if not ni.player.aura(20165) then
					ni.spell.cast(20165);
					return true;
				end
			elseif value == 2 then
				if not ni.player.aura(31801) then
					ni.spell.cast(31801);
					return true;
				end
			elseif value == 3 then
				if not ni.player.aura(20165) then
					ni.spell.cast(20165);
					return true;
				end
			elseif value == 4 then
				if not ni.player.aura(20154) then
					ni.spell.cast(20154);
					return true;
				end
			elseif value == 5 then
				if not ni.player.aura(20165) then
					ni.spell.cast(20165);
					return true;
				end
			end
		end
	end,
	["blessings"] = function()
		local enabled = select(2, GetSetting("Blessing"));
		if enabled
		 and (available(spells.BlessingOfKings.id)
		 or available(spells.BlessingOfMight.id)) then
			if ni.player.buff(144051) then
				return false;
			end
			if bufftimer >= GetTime() then
				return false;
			end
			local value = GetSetting("ActiveBlessing");
			local blessing = spells.BlessingOfKings.name;
			if value == 1 then
				local count = 0;
				for i = 1, #ni.members do
					if UnitExists(ni.members[i].unit) then
						local class = ni.members[i].class;
						if class == "DRUID" then
							count = count + 1;
						elseif class == "MONK" then
							count = count + 1;
						elseif class == "PALADIN" then
							count = count + 50;
						elseif class == "SHAMAN" then
							count = count + 1000;
						end
					end
				end
				if count > 50 and count < 1000 then
					blessing = spells.BlessingOfMight.name;
				end
			elseif value == 3 then
				blessing = spells.BlessingOfMight.name;
			end
			if blessing == spells.BlessingOfMight.name
			 and not HaveAbility(spells.BlessingOfMight.id) then
				blessing = spells.BlessingOfKings.name;
			end
			if blessing == spells.BlessingOfKings.name
			 and not HaveAbility(spells.BlessingOfKings.id) then
				bufftimer = GetTime() + 600;
				return false;
			end
			for i = 1, #ni.members do
				if not ni.unit.buff(ni.members[i].unit, blessing)
				 and (UnitInParty(ni.members[i].unit) ~= nil
				 or UnitInRaid(ni.members[i].unit) ~= nil) then
					if available(blessing)
					 and CanHeal(ni.members[i].unit) then
						ni.spell.cast(blessing, "player");
						bufftimer = GetTime() + random(15,30);
						return true;
					end
				end
			end
		end
	end,
	["defensive cds"] = function()
		local hp = ni.player.hp();
		local ardval, arden = GetSetting("ArdentDefender");
		if arden
		 and available(spells.ArdentDefender.id)
		 and hp <= ardval then
			ni.spell.cast(spells.ArdentDefender.name, "player");
			return true;
		end
		local dpval, dpen = GetSetting("DivineProtection");
		if dpen
		 and available(spells.DivineProtection.id)
		 and hp <= dpval then
			ni.spell.cast(spells.DivineProtection.name, "player");
			return true;
		end
		local goakval, goaken = GetSetting("GoAK");
		if goaken
		 and available(spells.GuardianOfAncientKings.id)
		 and hp <= goakval then
			ni.spell.cast(spells.GuardianOfAncientKings.name, "player");
			return true;
		end
	end,
	["lay on hands"] = function()
		local value, enabled = GetSetting("LoH");
		if enabled
		 and available(spells.LayOnHands.id) then
			local matchedboss = false;
			for i = 1, #NoLoHBosses do
				if ni.unit.id("boss1") == NoLoHBosses[i] then
					matchedboss = true;
					break;
				end
			end
			if not matchedboss
			 and ni.player.hp() <= value then
				ni.spell.cast(spells.LayOnHands.name, "player");
				return true;
			end
			if ni.members[1].hp < value
			 and not UnitIsUnit(ni.members[1].unit, "player")
			 and CanHeal(ni.members[1].unit) then
				ni.spell.cast(spells.LayOnHands.name, ni.members[1].unit);
				return true;
			end
		end
	end,
	["hand of salvation"] = function()
		local value, enabled = GetSetting("HandOfSalv");
		if enabled
		 and ni.members[1].hp < value
		 and available(spells.HandOfSalvation.id)
		 and UnitThreatSituation(ni.members[1].unit) == 3
		 and not ni.members[1].istank
		 and not (UnitIsUnit("player", ni.members[1].unit)
		 and GetSpecialization() == 2)
		 and not HandActive(ni.members[1].unit)
		 and CanHeal(ni.members[1].unit) then
			ni.spell.cast(spells.HandOfSalvation.name, ni.members[1].unit);
			return true;
		end
	end,
	["hand of protection"] = function()
		local value, enabled = GetSetting("HandOfProt");
		if enabled 
		 and ni.members[1].hp < value
		 and available(spells.HandOfProtection.id)
		 and UnitThreatSituation(ni.members[1].unit) == 3
		 and not ni.members[1].istank
		 and ni.members[1].class ~= "DEATHKNIGHT"
		 and not (ni.members[1].class == "DRUID"
		 and ni.unit.buff(ni.members[1].unit, 768))
		 and ni.members[1].class ~= "HUNTER"
		 and ni.members[1].class ~= "PALADIN"
		 and ni.members[1].class ~= "ROGUE"
		 and ni.members[1].class ~= "WARRIOR"
		 and not HandActive(ni.members[1].unit)
		 and not ni.unit.debuff(ni.members[1].unit, 25771)
		 and CanHeal(ni.members[1].unit)
		 and not (UnitIsUnit("player", ni.members[1].unit) 
		 and GetSpecialization() == 2)
		 and IsSpellInRange(spells.HandOfProtection.name, ni.members[1].unit) ~= nil then
			ni.spell.cast(spells.HandOfProtection.name, ni.members[1].unit);
			return true;
		end
	end,
	["hand of sacrifice"] = function()
		local value, enabled = GetSetting("HandOfSac");
		if enabled
		 and ni.members[1].hp < value
		 and ni.player.hp() >= 65
		 and available(spells.HandOfSacrifice.id)
		 and UnitThreatSituation(ni.members[1].unit) == 3
		 and not HandActive(ni.members[1].unit)
		 and CanHeal(ni.members[1].unit) then
			ni.spell.cast(spells.HandOfSacrifice.name, ni.members[1].unit);
			return true;
		end
	end,
	["hand of freedom"] = function()
		local enabled = select(2, GetSetting("HandOfFreedom"));
		if enabled then
			for i = 1, #FreedomDebuffs do
				if ni.player.debuff(FreedomDebuffs[i])
				 and CanHeal("player")
				 and UnitIsPlayer("player") == 1
				 and not HandActive("player")
				 and available(spells.HandOfFreedom.id) then
					ni.spell.cast(spells.HandOfFreedom.name, "player");
					return true;
				end
			end
		end
	end,
	["sacred shield"] = function()
		local value, enabled = GetSetting("SacredShield");
		if enabled
		 and available(spells.SacredShield.id)
		 and ni.player.hp() <= value then
			local vengeance = GetVengeance();
			local sacvengeance = GetSetting("SacredVengeance");
			if ((ni.player.ismoving()
			 or UnitAffectingCombat("player"))
			 and not ni.player.buff(20925))
			 or (vengeance > sacvengeance + LastVengeance) then
				LastVengeance = vengeance;
				ni.spell.cast(spells.SacredShield.name, "player");
				return true;
			end
			if ni.player.buffremaining(20925) <= 3 then
				ni.spell.cast(spells.SacredShield.name, "player");
				return true;
			end			
		end
	end,
	["flash of light"] = function()
		if settings.active_healing then
			local value, enabled = GetSetting("FoL");
			if enabled then
				if select(2, MeleeTarget()) == true then
					return false;
				end
				if available(spells.FlashOfLight.id)
				 and not ni.player.ismoving()
				 and ni.members[1].hp <= value
				 and ni.power.current("player", "mana") >= 20
				 and CanHeal(ni.members[1].unit) then
					ni.spell.cast(spells.FlashOfLight.name, ni.members[1].unit);
					return true;
				end
			end
		end
	end,
	["eternal flame"] = function()
		if settings.active_healing then
			local value, enabled = GetSetting("WoG");
			if enabled
			 and available(spells.EternalFlame.id)
			 and (HolyPower() >= 3
			 or ni.player.buff(90174)) then
				local flamescan = 0;
				if #ni.members > 5 then
					flamescan = 5;
				else
					flamescan = #ni.members;
				end
				for i = 1, flamescan do
					if ni.members[i].hp <= value
					 and not ni.unit.buff(ni.members[i].unit, 114163) then
						ni.spell.cast(spells.EternalFlame.name, ni.members[i].unit);
						return true;
					end
				end
			end
		end
	end,
	["word of glory"] = function()
		if settings.active_healing then
			local value, enabled = GetSetting("WoG");
			if enabled
			 and available(spells.WordOfGlory.id)
			 and (HolyPower() >= 3
			 or ni.player.buff(90174))
			 and not HaveAbility(spells.EternalFlame.id)
			 and CanHeal(ni.members[1].unit)
			 and ni.members[1].hp <= value then
				ni.spell.cast(spells.WordOfGlory.name, ni.members[1].unit);
				return true;
			end
		end
	end,
	["combat check"] = function()
		local enabled = select(2, GetSetting("Combat"));
		if enabled
		 and not UnitAffectingCombat("player") then
			return true;
		end
	end,
	["healthstone"] = function()
		local value, enabled = GetSetting("Healthstone");
		if enabled
		 and ni.player.hp() <= value
		 and select(2,GetItemCooldown(5512)) == 0 
		 and GetItemCount(5512,false,true) > 0 then 
			ni.player.useitem(5512)
			return true
		end
	end,
	["goak"] = function()
		local value, enabled = GetSetting("GoAK");
		if enabled
		 and ni.player.hp() <= value
		 and available(spells.GuardianOfAncientKings.id) then
			ni.spell.cast(spells.GuardianOfAncientKings.name, "player");
			return true;
		end
	end,
	["active cooldowns"] = function()
		local enabled = select(2, GetSetting("Cooldowns"));
		local target, en = MeleeTarget();
		if enabled 
		 and en then
			--Cast Berserking
			if available(spells.Berserking.id) then
				ni.spell.cast(spells.Berserking.name);
			end
			--Cast Blood Fury
			if available(spells.BloodFury.id) then
				ni.spell.cast(spells.BloodFury.name);
			end
			if ni.player.slotcastable(10)
			 and ni.player.slotcd(10) == 0 then
				ni.player.useinventoryitem(10);
			end
			if ni.player.slotcastable(13)
			 and ni.player.slotcd(13) == 0 then
				ni.player.useinventoryitem(13);
			end
			if ni.player.slotcastable(14)
			 and ni.player.slotcd(14) == 0 then
				ni.player.useinventoryitem(14);
			end
			if available(spells.AvengingWrath.id) then
				ni.spell.cast(spells.AvengingWrath.name, "player")
			end
			if available(spells.HolyAvenger.id) then
				ni.spell.cast(spells.HolyAvenger.name);
			end
			if available(spells.GuardianOfAncientKings.id) then
				ni.spell.cast(spells.GuardianOfAncientKings.name);
			end
			if available(spells.ExecutionSentence.id)
			 and (ni.player.buffremaining(spells.AvengingWrath.name) > 2
			 or ni.player.buffremaining(spells.GuardianOfAncientKings.name) > 2)
			 and en then
				ni.spell.cast(spells.ExecutionSentence.name, target);
			end
		end
	end,
	["eternal flame (self)"] = function()
		local value, enabled = GetSetting("EternalFlame");
		if enabled
		 and available(spells.EternalFlame.id) then
			local bogstacks = ni.player.buffstacks(114637);
			local holypower = HolyPower();
			if (bogstacks >= 5
			 and (holypower >= 3
			 or ni.player.buff(86172)))
			 or (TierEquipped(t16, 4)
			 and bogstacks >= 3) then
				local hp = ni.player.hp();
				if hp <= value
				 and not ni.player.buff(114163) then
					ni.spell.cast(spells.EternalFlame.name, "player");
					return true;
				end
				if hp <= value - 30 then
					ni.spell.cast(spells.EternalFlame.name, "player");
					return true;
				end
				local sacvengeance = GetSetting("SacredVengeance");
				if LastVengeance <= GetVengeance() + sacvengeance then
					ni.spell.cast(spells.EternalFlame.name, "player");
					return true;
				end
			end
		end
	end,
	["avengers shield"] = function()
		if available(spells.AvengersShield.id)
		 and ni.player.buff(98057) then
			ni.spell.cast(spells.AvengersShield.name, "target");
			return true;
		end
	end,
	["crusader strike/hammer of the righteous"] = function()
		local strike = ni.vars.combat.aoe and spells.HammerOfTheRighteous.id or spells.CrusaderStrike.id;
		local strike_name = ni.vars.combat.aoe and spells.HammerOfTheRighteous.name or spells.CrusaderStrike.name;
		if available(strike) then
			local tar, en = MeleeTarget();
			if en then
				ni.spell.cast(strike_name, tar);
				return true;
			end			
		end
	end,
	["judgement"] = function()
		if available(spells.Judgement.id) then
			--Double Jeopardy
			if ni.player.buff(121027) then
				if lastJudgementGUID == UnitGUID("target") then
					for i = 1, #targets do
						if UnitExists(targets[i]) == 1
						 and lastJudgementGUID ~= UnitGUID(targets[i])
						 and IsSpellInRange(spells.Judgement.name, targets[i]) == 1 then
							ni.spell.cast(spells.Judgement.id, targets[i]);
							return true;
						end
					end
				end
			end
			ni.spell.cast(spells.Judgement.id, MeleeTarget(false));
			return true;
		end
	end,
	["execution sentence"] = function()
		if available(spells.ExecutionSentence.id) then
			local veng = GetVengeance();
			local execveng = GetSetting("ExecutionVengeance");
			local tar, en = MeleeTarget();
			if veng > execveng
			 and en then
				if ni.player.slotcastable(10)
				 and ni.player.slotcd(10) == 0 then
					ni.player.useinventoryitem(10);
				end
				ni.spell.cast(spells.ExecutionSentence.name, tar);
				return true;
			end
		end
	end,
	["hammer of wrath"] = function()
		if available(spells.HammerOfWrath.id)
		 and ni.unit.hp("target") <= 20 then
			ni.spell.cast(spells.HammerOfWrath.name, "target");
			return true;
		end
	end,
	["avengers shield #2"] = function()
		if available(spells.AvengersShield.id) then
			ni.spell.cast(spells.AvengersShield.name, "target");
			return true;
		end
	end,
	["consecration"] = function()
		
	end,
	["holy wrath"] = function()
		if available(spells.HolyWrath.id) then
			local tar, en = MeleeTarget();
			if en then
				ni.spell.cast(spells.HolyWrath.name, "player");
				return true;
			end
		end
	end,
	["holy prism"] = function()
		if available(spells.HolyPrism.id) then
			local tar, en = MeleeTarget();
			if en then
				if ni.vars.combat.aoe then
					ni.spell.cast(spells.HolyPrism.name, "player");
					return true;
				else
					ni.spell.cast(spells.HolyPrism.name, tar);
					return true;
				end
			else
				if select(2, MeleeTarget(false)) then
					ni.spell.cast(spells.HolyPrism.name, "player");
					return true;
				end
			end
		end
	end
}
ni.bootstrap.profile("Prot - MoP", queue, abilities, OnLoad, OnUnload);