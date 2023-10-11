local A1 = {
mage_skills_lvl = {
    Fireball = GetSpellInfo("Огненный шар"),
    Arcane_Missiles = GetSpellInfo("Чародейские стрелы"),
    Frost_Armor = GetSpellInfo("Морозный доспех"),
    Fire_Blast = GetSpellInfo("Огненный взрыв"),
    ArcaneIntellect = GetSpellInfo("Чародейский интеллект"),
};
ench_skills = {
    Rockbiter_Weapon = GetSpellInfo(10933),
    Flametongue_Weapon = GetSpellInfo(58790),
    Lightning_Bolt = GetSpellInfo(49238),
    AutomaticAttack = GetSpellInfo(6603),
    Earth_Shock = GetSpellInfo(49231),
    Fire_Shock = GetSpellInfo(49233),
    Lightning_Shield = GetSpellInfo(49281),
    Water_Shield = GetSpellInfo(57960),
    Fire_Nova = GetSpellInfo(61657),
    Purge = GetSpellInfo(8012),
    Cure_Toxins = GetSpellInfo(526),
    Wind_Shear = GetSpellInfo(57994),
    Totemic_Recall = GetSpellInfo(36936),
    Lesser_Healing_Wave = GetSpellInfo(49276),
    Windfury_Weapon = GetSpellInfo(58804),
    Stormstrike = GetSpellInfo(17364),
    Maelstrom_Weapon = GetSpellInfo(53817),
    Chain_Lightning = GetSpellInfo(49271),
    Feral_Spirit = GetSpellInfo(51533),
    Zandalar = GetSpellInfo(319326),
    Shamanistic_Rage = GetSpellInfo(30823),
    Call_of_the_Elements = GetSpellInfo(66842),
    Hex = GetSpellInfo(51514),
    Lava_Lash = GetSpellInfo(60103),
    MagmaTotem = GetSpellInfo(58734),
    ench1 = GetSpellInfo(58804),
    ench2 = GetSpellInfo(58790),
};
ench_icons = {
    Rockbiter_Weapon = select (3, GetSpellInfo(10399)),
    AutomaticAttack = select(3, GetSpellInfo(6603)),
    Purge = select(3, GetSpellInfo(8012)),
    Cure_Toxins = select(3, GetSpellInfo(526)),
    Wind_Shear = select(3, GetSpellInfo(57994)),
    Hex = select(3, GetSpellInfo(51514)),
    Call_of_the_Elements = select(3, GetSpellInfo(66842)),
    trink13 = select(10, GetItemInfo(GetInventoryItemID("player", 13))),
};
PWtalents = {
    BattleSout = GetSpellInfo(47436),
    CommandShout = GetSpellInfo(47440),
    DefensiveStance = GetSpellInfo(71),
    Thunderclap = GetSpellInfo(47502),
    PowerfulShieldBash = GetSpellInfo(47488),
    ShieldBash = GetSpellInfo(72),
    FuryOfTheBerserker = GetSpellInfo(18499),
    DworfRace = GetSpellInfo(316246),
    BlackDworfRace = GetSpellInfo(316162),
    ShieldBlock = GetSpellInfo(2565),
    Revenge = GetSpellInfo(57823),
    Crush = GetSpellInfo(47498),
    SunderArmor = GetSpellInfo(58567),
    Bloodletting = GetSpellInfo(47465),
    DemoralizingShout = GetSpellInfo(47437),
    Bloodfury = GetSpellInfo(2687),
    HeroStrike = GetSpellInfo(47450),
    CleaveStrike = GetSpellInfo(47520),
    AutomaticAttack = GetSpellInfo(6603),
    FreeHeroStrikeBuff = GetSpellInfo(58363),
    FullProtection = GetSpellInfo(871),
    DontFallBack = GetSpellInfo(12975),
    Enrage = GetSpellInfo(57516),
    RampantRecovery = GetSpellInfo(55694),
    Provoke = GetSpellInfo(355),
	HeroicThrow = GetSpellInfo(57755),
	TeasingStrike = GetSpellInfo(694),
	Vigilance = GetSpellInfo(50720),
	StunningStrike = GetSpellInfo(12809),
	DworfsStunningStrike = GetSpellInfo(316161),
	ShockWave = GetSpellInfo(46968),
	PowerfulStrike = GetSpellInfo(47475),
	SpellReflection = GetSpellInfo(23920),
	MassAgro = GetSpellInfo(1161)
};
PWicons = {
    BattleSout = select(3, GetSpellInfo(47436)),
    CommandShout = select(3, GetSpellInfo(47440)),
    DefensiveStance = select(3, GetSpellInfo(71)),
    Thunderclap = select(3, GetSpellInfo(47502)),
    PowerfulShieldBash = select(3, GetSpellInfo(47488)),
    ShieldBash = select(3, GetSpellInfo(72)),
    FuryOfTheBerserker = select(3, GetSpellInfo(18499)),
    DworfRace = select(3, GetSpellInfo(316246)),
    BlackDworfRace = select(3, GetSpellInfo(316162)),
    ShieldBlock = select(3, GetSpellInfo(2565)),
    Revenge = select(3, GetSpellInfo(57823)),
    Crush = select(3, GetSpellInfo(47498)),
    SunderArmor = select(3, GetSpellInfo(58567)),
    Bloodletting = select(3, GetSpellInfo(47465)),
    DemoralizingShout = select(3, GetSpellInfo(47437)),
    Bloodfury = select(3, GetSpellInfo(2687)),
    HeroStrike = select(3, GetSpellInfo(47450)),
    CleaveStrike = select(3, GetSpellInfo(47520)),
    AutomaticAttack = select(3, GetSpellInfo(6603)),
    FreeHeroStrikeBuff = select(3, GetSpellInfo(58363)),
    RampantRecovery = select(3, GetSpellInfo(55694)),
    Provoke = select(3, GetSpellInfo(355)),
	Vigilance = select(3, GetSpellInfo(50720)),
	StnningStrike = select(3, GetSpellInfo(12809)),
    trink13 = select(10, GetItemInfo(GetInventoryItemID("player", 13))),
    oil = select(10, GetItemInfo(154170))
};
DruidSkills = {
    BearForm = GetSpellInfo(9634),
    Maul = GetSpellInfo(48480),
    DemoralizingRoar = GetSpellInfo(48560),
    Growl = GetSpellInfo(6795),
    FaerieFire_Feral = GetSpellInfo(16857),
    Swipe_Bear = GetSpellInfo(48562),
    Mangle_Bear = GetSpellInfo(48564),
    Berserk = GetSpellInfo(50334),
    CatForm = GetSpellInfo(768),
    Rip = GetSpellInfo(49800),
    Rake = GetSpellInfo(48574),
};
DruidIcons = {
    HealingTouch = select(3, GetSpellInfo("Целительное прикосновение")),
    Growl = select(3, GetSpellInfo(6795))
};
restorsham_skills = {
    Earthliving_Weapon = GetSpellInfo(51994),
    Healing_Wave = GetSpellInfo(49273),
    Chain_Heal = GetSpellInfo(55459),
    Water_Shield = GetSpellInfo(57960),
    Purge = GetSpellInfo(8012),
    Cleanse_Spirit = GetSpellInfo(51886),
    Wind_Shear = GetSpellInfo(57994),
    Totemic_Recall = GetSpellInfo(36936),
    Lesser_Healing_Wave = GetSpellInfo(49276),
    Zandalar = GetSpellInfo(319326),
    Shamanistic_Rage = GetSpellInfo(30823),
    Call_of_the_Elements = GetSpellInfo(66842),
    Hex = GetSpellInfo(51514),
    Mana_Tide_Totem = GetSpellInfo(16190),
    Earth_Shield = GetSpellInfo(49284),
    Riptide = GetSpellInfo(61301),
    Nature_Swiftness = GetSpellInfo(16188),
    Tidal_Force = GetSpellInfo(55198),
};
restorsham_icons = {
    Earthliving_Weapon = select (3, GetSpellInfo(51994)),
    Healing_Wave = select (3, GetSpellInfo(49273)),
    Lesser_Healing_Wave = select (3, GetSpellInfo(49276)),
    Chain_Heal = select (3, GetSpellInfo(55459)),
    Riptide = select (3, GetSpellInfo(61301)),
    Purge = select(3, GetSpellInfo(8012)),
    Cleanse_Spirit = select(3, GetSpellInfo(51886)),
    Wind_Shear = select(3, GetSpellInfo(57994)),
    Hex = select(3, GetSpellInfo(51514)),
    Call_of_the_Elements = select(3, GetSpellInfo(66842)),
    trink13 = select(10, GetItemInfo(GetInventoryItemID("player", 13))),
};
pal_skills = {
    Divine_Storm = GetSpellInfo(53385),
    Avenging_Wrath = GetSpellInfo(31884),
    Sacred_Shield = GetSpellInfo(53601),
    Hammer_of_Wrath = GetSpellInfo(48806),
    Seal_of_Command = GetSpellInfo(20375),
    Seal_of_Corruption = GetSpellInfo(53736),
    Repentance = GetSpellInfo(20066),
    Judgement_of_Wisdom = GetSpellInfo(53408),
    Judgement_of_Light = GetSpellInfo(20271),
    Crusader_Strike = GetSpellInfo(35395),
    Divine_Protection = GetSpellInfo(498),
    Divine_Shield = GetSpellInfo(642),
    Hand_of_Sacrifice = GetSpellInfo(6940),
    Hand_of_Protection = GetSpellInfo(10278),
    Hand_of_Freedom = GetSpellInfo(1044),
    Hand_of_Salvation = GetSpellInfo(1038),
    Hammer_of_Justice = GetSpellInfo(10308),
    Righteous_Fury = GetSpellInfo(25780),
    Lay_on_Hands = GetSpellInfo(48788),
    Flash_of_Light = GetSpellInfo(48785),
    Holy_Light = GetSpellInfo(48782),
    Holy_Wrath = GetSpellInfo(48817),
    Consecration = GetSpellInfo(48819),
    Cleanse = GetSpellInfo(4987),
    Divine_Plea = GetSpellInfo(54428),
    Exorcism = GetSpellInfo(48801),
    Greater_Blessing_of_Kings = GetSpellInfo(25898),
    Greater_Blessing_of_Might = GetSpellInfo(48934),
    Greater_Blessing_of_Wisdom = GetSpellInfo(48938),
    The_Art_of_War = GetSpellInfo(59578),
};
pal_debuff = {
	Forbearance = GetSpellInfo(25771),
};
pal_icons = {
    Repentance = select (3, GetSpellInfo(20066)),
    Flash_of_Light = select (3, GetSpellInfo(48785)),
    Cleanse = select (3, GetSpellInfo(4987)),
    Seal_of_Command = select (3, GetSpellInfo(20375)),
};
raid_debuff = {
    Enfeeble = GetSpellInfo(30843),
    Pursued_by_Anub = GetSpellInfo(67574),
    Mutated_Infection = GetSpellInfo(69674),
    Necrotic_Plague = GetSpellInfo(70337),
    Fiery_Combustion = GetSpellInfo(74562),
    Soul_Consumption = GetSpellInfo(74792),
};
};
local PlayerNearestAgressiveEnemies = {};
function PlayerNearestEnemies()
	table.wipe(PlayerNearestAgressiveEnemies);
	PlayerNearestAgressiveEnemies = ni.player.enemiesinrange(5);
	for k, v in ipairs(PlayerNearestAgressiveEnemies) do
		if ni.player.threat(v.guid) == -1 then
			table.remove(PlayerNearestAgressiveEnemies, k);
		end
	end
    return #PlayerNearestAgressiveEnemies;
end
local blacklistedmonsterwithdebuff = {18647};
local blacklistedmonster = {36619, 21508, 19920, 38712, 37007, 36954, 19221, 20869, 16809, 20481, 36633, 37863, 34800, 100509, 17990, 20189, 34605, 34650, 12380, 7370, 11262, 36566, 34813, 35265, 38454, 24858, 18431, 17096, 16544, 36980, 37799, 17167}
function BlackListedMonster(t)
	for _, v in pairs(blacklistedmonster) do
		if ni.unit.exists(t)
		and v == ni.unit.id(t) then
			return false
		end
	end
	return true
end
function BlackListedMonsterWithDebuff(t)
	for _, v in pairs(blacklistedmonsterwithdebuff) do
		if ni.unit.exists(t)
		and ni.unit.debuff(t, v) then
			return false
		end
	end
	return true
end
A1.PlayerCanAttack = function()
	if ni.unit.exists("target")
    and not UnitIsDeadOrGhost("target")
    and ni.player.inmelee("target")
    and ni.player.isfacing("target")
    and UnitCanAttack("player", "target") then
        return true
    end
    return false
end
function Tank(t)
    local _, _, class = UnitClass(t)
	if (class == 11
	and ni.unit.aura(t, 9634))
    or (class == 1
	and ni.unit.aura(t, 71))
    or (class == 2
	and ni.unit.aura(t, 25780))
    or (class == 6
	and ni.unit.aura(t, 48263)) then
		return true
	end
	return false
end
return A1;