local  RarityColorsTable = {
	{ Type = "Useless", 	Color = "999999" },
	{ Type = "Common", 		Color = "FFFFFF" },
	{ Type = "Uncommon", 	Color = "33FF33" },
	{ Type = "Rare", 		Color = "00AAFF" },
};
--Remove Debuffs/Buffs
--667, Aged Yolk
--763, Sear Magic
--835, Eggnog
--941, High Fiber

--Only works if at least one ally is dead
--665, Consume Corpse

-- AoE Attacks to be used only while there are 3 ennemies.
local AoEPunchList = { 
	299, -- Arcane Explosion
	319, -- Magma Wave
	387, -- Tympanic Tantrum
	404, -- Sunlight
	419, -- Tidal Wave
	668, -- Dreadfull Breath
	644, -- Quake
	649, -- BONESTORM
	741, -- Whirlwind
	768, -- Omnislash
	774, -- Rapid Fire
	923, -- Flux
} 
-- Roots and other buffs. These debuff on us will disable Pet Swap.
local BuffNoSwap  = { 
	248, -- Rooted
	294, -- Charging Rocket
	302, -- Planted
	338, -- Webbed
	370, -- Sticky Goo
}  
-- Abilities that give immunity on the next spell
local CantDieList = { 
	284, -- Survival
}
-- Attacks that are stronger if the ennemi have more life than us.
local ComebackList = { 
	253, -- Comeback
	405, -- Early Advantage
}
-- Damage Buffs that we want to cast on us.
local DamageBuffList = { 
	188, -- Accuracy
	197, -- Adrenal Glands
	216, -- Inner Vision
	223, -- Focus Chi
	252, -- Uncanny Luck
	263, -- Crystal Overload
	279, -- Heartbroken
	347, -- Roar
	375, -- Trumpet Strike
	426, -- Focus
	488, -- Amplify Magic
	521, -- Hawk Eye
	536, -- Prowl
	589, -- Arcane Storm
	614, -- Competitive Spirit
	740, -- Frenzyheart Brew
	791, -- Stimpack
	809, -- Roll
	936, -- Caw
}
-- Debuff to cast on ennemy. This list will check for Abilit-1 debuffs.
local DeBuffList = { 
	152, -- Poison Fang
	155, -- Hiss
	167, -- Nut Barrage
	176, -- Volcano
	178, -- Immolate
	179, -- Conflagrate
	204, -- Call Lightning
	206, -- Call Blizzard
	212, -- Siphon Life
	249, -- Grasp
	305, -- Exposed Wounds
	314, -- Mangle
	339, -- Sticky Web
	352, -- Banana Barrage
	359, -- Sting
	369, -- Acidic Goo
	371, -- Sticky Goo
	380, -- Poison Spit
	382, -- Brittle Webbing
	398, -- Poison Lash
	411, -- Woodchipper
	447, -- Corrosion
	463, -- Flash
	497, -- Soothe
	501, -- Flame Breath
	515, -- Flyby 
	524, -- Squawk
	527, -- Stench
	592, -- Wild Magic
	628, -- Rock Barrage
	630, -- Poisoned Branch
	631, -- Super Sticky Goo
	642, -- Egg Barrage
	650, -- Bone Prison
	743, -- Creeping Fungus
	756, -- Acid Touch
	784, -- Shriek
	786, -- Blistering Cold
	803, -- Rip
	811, -- Magma Trap
	909, -- Paralyzing Shock
	919, -- Black Claw
	932, -- Croak
	964, -- Autumn Breeze
}
local SpecialDebuffsList = {
	{ 	Ability = 270, 	Debuff = 271 	}, -- Glowing Toxin
	{	Ability = 362,  Debuff = 542	}, -- Howl
	{ 	Ability = 448, 	Debuff = 781 	}, -- Creeping Ooze
	{	Ability = 468,  Debuff = 469	}, -- Agony
	{	Ability = 522,  Debuff = 738	}, -- Nevermore
	{	Ability = 580,  Debuff = 498    }, -- Food Coma/ Asleep
	{ 	Ability = 632, 	Debuff = 633 	}, -- Confusing Sting	
	{ 	Ability = 657, 	Debuff = 658 	}, -- Plagued Blood
	{ 	Ability = 784, 	Debuff = 494 	}, -- Shriek/ Attack Reduction
	{	Ability = 869,  Debuff = 153	}, -- Darkmoon Curse/ Attack Reduction
	{	Ability = 486,  Debuff = 153	}, -- Drain Power/ Attack Reduction
	{	Ability = 940,  Debuff = 939    }, -- Touch of the Animus
}
-- Abilities used to Deflect
local DeflectorList = { 
	312, -- Dodge
	440, -- Evanescence
	490, -- Deflection
	764, -- Phase Shift
}
local ExecuteList = { 
	538, -- Devour
	802, -- Ravage
	917, -- Bloodfang
}
-- Apocalypse.
local FifteenTurnList = { 
	519, -- Apocalypse
}
local MeteorStrikeList = {
	518, -- Apocalypse
	519, -- Apocalypse
}
local KamikazeList = { 
	282, -- Explode
	321, -- Unholy Ascension
	568, -- Feign Death
	652, -- Haunt
	663, -- Corpse Explosion
}
-- Abilities to be cast to heal ouself instantly.
local HealingList = { 
	123, -- Healing Wave
	168, -- Healing Flame
	173, -- Cautherize
	230, -- Cleansing Rain
	247, -- Hibernate
	273, -- Wish
	278, -- Repair
	298, -- Inspiring Song
	383, -- Leech Life
	533, -- Rebuild
	539, -- Bleat
	573, -- Nature's Touch
	576, -- Perk Up
	578, -- Buried Treasure
	598, -- Emerald Dream
	611, -- Ancient Blessing
	745, -- Leech Seed
	770, -- Restoration
	776, -- Love Potion
	922, -- Healing Stream
	-- Leech
	121, -- Death Coil
	160, -- Consume
	449, -- Absorb
	937, -- Siphon Anima
}
local HighDamageIfBuffedList = {
	{	Ability = 221,  Debuff = 927	}, -- Takedown if Stunned
	{	Ability = 221,  Debuff = 174	}, -- Takedown if Stunned (second stun ID)
	{	Ability = 250,  Debuff = 338	}, -- Spiderling Swarm if Webbed
	{ 	Ability = 423, 	Debuff = 491 	}, -- Blood in the Water if Bleeding.
	{	Ability = 461,  Debuff = 462	}, -- Light if Blinded
	{	Ability = 461,  Debuff = 954	}, -- Light if Blinded (second ID)
	{ 	Ability = 345, 	Debuff = 491 	}, -- Maul if Bleeding.
}
local HighDMGList = { 
	908, -- Jolt
	120, -- Howling Blast
	170, -- Lift-Off
	172, -- Scorched Earth
	179, -- Conflagrate
	158, -- Counterstrike
	186, -- Reckless Strike
	204, -- Call Lightning
	209, -- Ion Cannon
	226, -- Fury of 1,000 Fists
	256, -- Call Darkness
	258, -- Starfall
	330, -- Sons of the Flame
	345, -- Maul
	348, -- Maul (Stun)
	376, -- Headbutt
	400, -- Entangling Roots
	402, -- Stun Seed
	414, -- Frost Nova
	442, -- Spectral Strike
	450, -- Expunge
	453, -- SandStorm
	456, -- Clean-Up
	457, -- Sweep
	460, -- Illuminate
	466, -- Nether Gate
	481, -- Deep Freeze
	493, -- Hoof
	506, -- Cocoon Strike
	508, -- Mosth Dust
	517, -- Nocturnal Strike
	518, -- Predatory Strike
	532, -- Body Slam
	541, -- Chew
	572, -- MudSlide
	586, -- Gift of Winter's Veil
	593, -- Surge of Power
	595, -- Moonfire
	607, -- Cataclysm
	609, -- Instability
	612, -- Proto-Strike
	621, -- Stone Rush
	645, -- Launch
	646, -- Shock and Awe
	649, -- Bone Storm
	669, -- Backflip
	746, -- Spore Shrooms
	752, -- Soulrush
	753, -- Solar Beam
	761, -- Heroic Leap
	762, -- Haymaker
	767, -- Holy Charge
	769, -- Surge of Light
	773, -- Shot Through The Heart
	777, -- Missile
	779, -- Thunderbolt
	788, -- Gauss Rifle
	792, -- Darkflame
	812, -- Sulfuras Smash
	814, -- Rupture
	912, -- QuickSand
	913, -- Spectral Spine
	916, -- Haywire
	942, -- Frying Pan
} 
-- Buffs that heal us.
local HoTBuffList = { 
	267, -- Phytosynthesis
	303, -- Plant
	574, -- Nature's Ward
}
-- Buffs that heal us.
local HoTList = { 
	160, -- Consume
	230, -- Cleansing Waters
	268, -- Phytosynthesis
	302, -- Planted
	820, -- Nature's Ward
}
local ImmunityList = { 
	311, -- Dodge
	331, -- Submerged
	341, -- Flying
	340, -- Burrowed
	505, -- Cocoon Strike
	830, -- Dive
	839, -- Leaping
	852, -- Flying (Launch)
	926, -- Soothe
}
local LastStandList = { 
	283, -- Survival
	568, -- Feign Death
	576, -- Perk Up
	611, -- Ancient Blessing
	794, -- Dark Rebirth
}
local LifeExchangeList = { 
	277, -- Life Exchange
}
-- Attack that will damage next turn.
local OneTurnList = { 
	159, -- Burrow
	407, -- Meteor Strike
	564, -- Dive
	606, -- Elementium Bolt
	645, -- Launch
	828, -- Sons of the Root
}
-- Attacks to be used for Pet Leveling
local PetLevelingList = { 
	-- High Priority
	
	-- Low Priority
	155, -- Hiss
	492, -- Rake
}	
-- Basic attacks
local PunchList = { 
	-- High Priority
	156, -- Vicious Fang
	169, -- Deep Breath
	233, -- Frog Kiss
	293, -- Launch Rocket
	297, -- Pump
	301, -- Lock-On
	323, -- Gravity
	354, -- Barrel Toss
	377, -- Trample
	411, -- Woodchipper
	413, -- Ice Lance
	437, -- Onyx Bite
	459, -- Wind-Up
	471, -- Weakness
	476, -- Dark Simulacrum
	507, -- Moth Balls
	508, -- Moth Dust
	509, -- Surge
	529, -- Belly Slide
	563, -- Quick Attack
	566, -- Powerball
	594, -- Sleeping Gas
	616, -- Blinkstrike
	754, -- Screeching Gears
	765, -- Holy Sword
	775, -- Perfumed Arrow
	778, -- Charge
	849, -- Huge, Sharp Teeth!
	921, -- Hunting Party
	930, -- Huge Fang
	943, -- Chop
	958, -- Trihorn Charge
	-- Normal Priority	
	110, -- Bite
	111, -- Punch
	112, -- Peck
	113, -- Burn
	114, -- Beam
	115, -- Breath
	116, -- Zap
	117, -- Infected Claw
	118, -- Water Jet
	119, -- Scratch
	121, -- Death Coil (Heal)
	122, -- Tail Sweep
	163, -- Stampede 
	184, -- Quills
	193, -- Flank
	202, -- Trash
	210, -- Shadow Slash
	219, -- Jab
	276, -- Swallow You Whole
	347, -- Roar
	349, -- Smash
	355, -- Triple Snap
	356, -- Snap
	360, -- Flurry
	367, -- Chomp
	378, -- Strike
	384, -- Metal Fist
	390, -- Demolish
	393, -- Shadowflame
	406, -- Crush
	420, -- Slicing Wind
	421, -- Arcane Blast
	422, -- Shadow Shock
	424, -- Tail Slap
	429, -- Claw
	432, -- Jade Claw
	445, -- Ooze Touch
	449, -- Absorb
	452, -- Broom
	455, -- Batter
	472, -- Blast of Hatred
	473, -- Focused Beams
	474, -- Interupting Gaze
	477, -- Snowball
	478, -- Magic Hat
	482, -- Laser
	483, -- Psychic Blast
	484, -- Feedback
	492, -- Rake 
	499, -- Diseased Bite
	514, -- Wild Winds
	525, -- Emerald Bite
	528, -- Frost Spit
	608, -- Nether Blast
	617, -- Spark
	626, -- Skitter
	630, -- Poisoned Branch
	648, -- Bone Bite
	668, -- Dreadfull Breath
	712, -- Railgun
	713, -- Blitz
	771, -- Bow Shot
	782, -- Frost Breath
	789, -- U-238 Rounds
	800, -- Impale
	801, -- Stone Shot
	826, -- Weakening Blow
	901, -- Fel Immolate
	910,  -- Sand Bolt
	-- Low Priority
	167, -- Nut Barrage
	253, -- Comeback
	307, -- Kick
	383, -- Leech Life
	389, -- Overtune
	501, -- Flame Breath
	509, -- Surge
	-- Three Turns
	124, -- Rampage
	163, -- Stampede
	198, -- Zergling Rush
	581, -- Flock
	666, -- Rabid Bite
	668, -- Dreadful Breath
	706, -- Swarm
	870, -- Murder
}
-- Attacks that are stronger if we are quicker.
local QuickList = { 
	184, -- Quills
	202, -- Thrash
	228, -- Tongue Lash
	307, -- Kick
	360, -- Flurry
	394, -- Lash
	412, -- Gnaw
	441, -- Rend
	455, -- Batter
	474, -- Interrupting Gaze
	504, -- Alpha Strike
	535, -- Pounce
	571, -- Horn Attack
	617, -- Spark
	789, -- U-238 Rounds
	938, -- Interrupting Jolt
}
-- List of Buffs that we want to cast on us.
local SelfBuffList = { 
	259, -- Invisibility
	318, -- Thorns
	315, -- Spiked Skin
	325, -- Beaver Dam
	366, -- Dazzling Dance
	409, -- Immolation
	426, -- Focus
	444, -- Prismatic Barrier
	479, -- Ice Barrier
	486, -- Drain Power
	488, -- Amplify Magic
	757, -- Lucky Dance
	905, -- Cute Face
	906, -- Lightning Shield
	914, -- Spirit Spikes
	944, -- Heat Up
	962, -- Ironbark
	-- Damage
	188, -- Accuracy
	197, -- Adrenal Glands
	208, -- Supercharge
	216, -- Inner Vision
	263, -- Crystal Overload
	279, -- Heartbroken
	347, -- Roar
	375, -- Trumpet Strike
	488, -- Amplify Magic
	520, -- Hawk Eye
	589, -- Arcane Storm
	791, -- Stimpack
}
local SpecialSelfBuffList = {
	{ 	Ability = 597, 	Buff = 823 	}, -- Emerald Presence
	{	Ability = 851,  Buff = 544	}, -- Vicious Streak
	{	Ability = 364,  Buff = 544	}, -- Leap
	{	Ability = 567,  Buff = 544	}, -- Rush
	{	Ability = 579,  Buff = 735	}, -- Gobble Strike
	{	Ability = 957,  Buff = 485	}, -- Evolution
}
local ShieldBuffList = { 
	165, -- Crouch
	225, -- Staggered Steps
	310, -- Shell Shield
	334, -- Decoy
	392, -- Extra Plating
	431, -- Jadeskin
	436, -- Stoneskin
	465, -- Illusionary Barrier
	751, -- Soul Ward
	760, -- Shield Block
	934, -- Bubble
	960, -- Trihorn Shield
}
local SlowPunchList = {
	228, -- Tongue Lash
	233, -- Frog Kiss
	360, -- Flurry
	377, -- Trample
	390, -- Demolish
	394, -- Lash
	455, -- Batter
	475, -- Eyesurge
	529, -- Belly Slide
}
local SootheList = {
	497, -- Soothe
}
local SpeedBuffList = { 
	162, -- Adrenaline Rush
	194, -- Metabolic Boost
	389, -- Overtune
	838, -- Centrifugal Hooks
}
local SpeedDeBuffList = { 
	357, -- Screech - 25%
	416, -- Frost Shock - 25%
	475, -- Eyeblast
	929, -- Slither
} 
-- Pass Turn
local StunnedDebuffs = {
	498,
	822,
	927,
}
local StunList = { 
	227, -- Blackout Kick
	348, -- Bash
	350, -- Clobber
	569, -- Crystal Prison
	654, -- Ghostly Bite
	670, -- Snap Trap
	766, -- Holy Justice
	772, -- LoveStruck
	780, -- Death Grip
}
local SuicideList = { 
	282, -- Explode
	321, -- Unholy Ascension
	836, -- Baneling Burst
	652, -- Haunt
	663, -- Corpse Explosion
}
local SwapoutDebuffList  = { 
	358, -- 
	379, -- Poison Spit
	822, -- Frog Kiss
}
local TeamDebuffList = { 
	167, -- Nut Barrage
	190, -- Cyclone
	214, -- Death and Decay
	232, -- Swarm of Flies
	503, -- Flamethrower
	575, -- Slippery Ice
	640, -- Toxic Smoke
	642, -- Egg Barrage
	644, -- Rock Barrage
	860, -- Flamethrower
	920, -- Primal Cry
}
-- Attack that will damage in three turns.
local ThreeTurnList = { 
	386, -- XE-321 Boombot
	513, -- Whirlpool
	634, -- Minefield
	418, -- Geyser
	606, -- Elementium Bolt
	647, -- Bombing Run
}
local ThreeTurnHighDamageList = { 
	124, -- Rampage
	218, -- Curse of Doom
	489, -- Mana Surge
	624, -- Ice Tomb
	636, -- Sticky Grenade
	917, -- Bloodfang				
}
-- Attacks to Deflect.
local ToDeflectList = { 
	296, -- Pumped Up
	331, -- Submerged
	340, -- Burrow
	353, -- Barrel Ready
	341, -- Lift-Off
	830, -- Dive
	839, -- Leaping
}
local TeamHealBuffsAbilities = { 
	511, -- Renewing Mists
	539, -- Bleat
	254, -- Tranquility
}
local TeamHealBuffsList = { 
	510, -- Renewing Mists
	255, -- Tranquility
}
local TurretsList = { 
	710, -- Build Turret
}
-- List of Pets to chase.
local MopList = {	
	"Adder",
	"Alpine Chipmunk",
	"Alpine Foxling",
	"Alpine Foxling Kit",
	"Alpine Hare",
	"Amber Moth",
	"Amethyst Spiderling",
	"Anodized Robo Cub",
	"Arctic Fox Kit",
	"Arctic Hare",
	"Ash Lizard",
	"Ash Viper",
	"Baby Ape",
	"Bandicoon",
	"Bandicoon Kit",
	"Bat",
	"Beetle",
	"Biletoad",
	"Black Lamb",
	"Black Rat",
	"Blighted Squirrel",
	"Blighthawk",
	"Borean Marmot",
	"Bucktooth Flapper",
	"Cat",
	"Cheetah Cub",
	"Chicken",
	"Clefthoof Runt",
	"Clouded Hedgehog",
	"Cockroach",
	"Cogblade Raptor",
	"Coral Adder",
	"Coral Snake",
	"Crested Owl",
	"Crimson Geode",
	"Crimson Shale Hatchling",
	"Crystal Beetle",
	"Crystal Spider",
	"Dancing Water Skimmer",
	"Darkshore Cub",
	"Death's Head Cockroach",
	"Desert Spider",
	"Dragonbone Hatchling",
	"Dung Beetle",
	"Effervescent Glowfly",
	"Elder Python",
	"Electrified Razortooth",
	"Elfin Rabbit",
	"Emerald Boa",
	"Emerald Proto-Whelp",
	"Emerald Shale Hatchling",
	"Emerald Turtle",
	"Emperor Crab",
	"Eternal Strider",
	"Fawn",
	"Fel Flame",
	"Festering Maggot",
	"Fire Beetle",
	"Fire-Proof Roach",
	"Fledgling Nether Ray",
	"Fjord Rat",
	"Fjord Worg Pup",
	"Forest Moth",
	"Fluxfire Feline",
	"Frog",
	"Fungal Moth",
	"Gazelle Fawn",
	"Gilded Moth",
	"Giraffe Calf",
	"Gold Beetle",
	"Golden Civet",
	"Golden Civet Kitten",
	"Grasslands Cottontail",
	"Grassland Hopper",
	"Grasslands Cottontail",
	"Grey Moth",
	"Grizzly Squirrel",
	"Grove Viper",
	"Harpy Youngling",
	"Highlands Mouse",
	"Highlands Skunk",
	"Highlands Turkey",
	"Horned Lizard",
	"Horny Toad",
	"Huge Toad",
	"Imperial Eagle Chick",
	"Infected Fawn",
	"Infected Squirrel",
	"Infinite Whelping",
	"Irradiated Roach",
	"Jumping Spider",
	"Jungle Darter",
	"Jungle Grub",
	"King Snake",
	"Kuitan Mongoose",
	"Kun-Lai Runt",
	"Larva",
	"Lava Crab",
	"Leopard Scorpid",
	"Leopard Tree Frog",
	"Little Black Ram",
	"Locust",
	"Lofty Libram",
	"Lost of Lordaeron",
	"Luyu Moth",
	"Mac Frog",
	"Maggot",
	"Malayan Quillrat",
	"Malayan Quillrat Pup",
	"Marsh Fiddler",
	"Masked Tanuki",
	"Masked Tanuki Pup",
	"Mei Li Sparkler",
	"Mirror Strider",
	"Minfernal",
	"Molten Hatchling",
	"Mongoose Pup",
	"Mountain Skunk",
	"Nether Faerie Dragon",
	"Nether Roach",
	"Nexus Whelpling",
	"Nordrassil Wisp",
	"Oasis Moth",
	"Oily Slimeling",
	"Parrot",
	"Plains Monitor",
	"Prairie Dog",
	"Prairie Mouse",
	"Qiraji Guardling",
	"Rabbit",
	"Rabid Nut Varmint 5000",
	"Rapana Whelk",
	"Rat",
	"Rattlesnake",
	"Ravager Hatchling",
	"Red-Tailed Chipmunk",
	"Resilient Roach",
	"Roach",
	"Robo-Chick",
	"Rock Viper",
	"Ruby Sapling",
	"Rusty Snail",
	"Sand Kitten",
	"Sandy Petrel",
	"Savory Beetle",
	"Scarab Hatchling",
	"Scorpid",
	"Scorpling",
	"Scourged Whelpling",
	"Sea Gull",
	"Sidewinder",
	"Shimmershell Snail",
	"Shrine Fly",
	"Shore Crab",
	"Shy Bandicoon",
	"Sifang Otter",
	"Silent Hedgehog",
	"Silithid Hatchling",
	"Silky Moth",
	"Small Frog",
	"Snake",
	"Snow Cub",
	"Snowy Owl",
	"Softshell Snapling",
	"Spawn of Onyxia",
	"Spiky Lizard",
	"Spiny Lizard",
	"Spiny Terrapin",
	"Spirit Crab",
	"Sporeling Sprout",
	"Spotted Bell Frog",
	"Squirrel",
	"Stinkbug",
	"Stormwind Rat",
	"Stripe-Tailed Scorpid",
	"Stunded Shardhorn",
	"Stunted Yeti",
	"Summit Kid",
	"Sumprush Rodent",
	"Swamp Croaker",
	"Tainted Cockroach",
	"Tainted Moth",
	"Tainted Rat",
	"Thundertail Flapper",
	"Tiny Bog Beast",
	"Tiny Twister",
	"Toad",
	"Tolai Hare",
	"Tol'vir Scarab",
	"Topaz Shale Hatchling",
	"Tree Python",
	"Tundra Penguin",
	"Turkey",
	"Turquoise Turtle",
	"Twilight Beetle",
	"Twilight Fiendling",
	"Unborn Val'kyr",
	"Venomspitter Hatchling",
	"Warpstalker Hatchling",
	"Water Snake",
	"Water Waveling",
	"Wild Crimson Hatchling",
	"Wild Golden Hatchling",
	"Wild Jade Hatchling",
	"Yakrat",
	"Yellow-Bellied Marmot",
	"Zooey Snake",
}
local items = {
	settingsfile = "PetBattle.xml",
	{ type = "title", text = "PokeRotation" },
	{ type = "separator" },
	{ type = "title", text = "Pet Battle Type" },
    { type = "dropdown", menu = {
        { selected = true, value = 1, text = "Pet Leveling" },
        { selected = false, value = 2, text = "PvP" },
        { selected = false, value = 3, text = "Beasts of Fables" },
        { selected = false, value = 4, text = "Masters" },
    }, key = "Objective" },
	{ type = "separator" },	
	{ type = "title", text = "Main Settings" },
	{ type = "entry", text = "Pet Healing (In Battle)", value = 70, enabled = true, key = "PetHeal" },
	{ type = "entry", text = "Swap Pets Out of Battle", enabled = true, key = "PetSwap" },
	{ type = "entry", text = "Pet Swap Minimum Level", value = 1, key = "PetSwapMin" },
	{ type = "entry", text = "Pet Swap Maximum Level", value = 25, key = "PetSwapMax" },
	{ type = "entry", text = "Swap Out at Health (In Battle)", value = 25, enabled = true, key = "SwapOut" },
	{ type = "entry", text = "Swap In Minimum Health (In Battle)", value = 35, enabled = true, key = "SwapIn" },
	{ type = "entry", text = "Use Revive Battle Pets (Out of Battle)", enabled = true, value = 70, key = "RevivePets" },
	{ type = "entry", text = "PvP Queue/Pet Slot", value = 1, enabled = false, key = "PvP" },
	{ type = "entry", text = "Auto Start Battles", enabled = false, key = "AutoClicker" },
	{ type = "entry", text = "Max Distance to Pets", enabled = false, value = 30, key = "FollowDistance" },
	{ type = "separator" },
	{ type = "title", text = "Capture Settings" },
	{ type = "entry", text = "Capture Pets", enabled = true, key = "CapturePets" },
	{ type = "title", text = "Capture Quality" },
	{ type = "dropdown", menu = {
		{ selected = false, value = 1 , text = "|cff"..RarityColorsTable[1].Color.."Poor" },
		{ selected = false, value = 2 , text = "|cff"..RarityColorsTable[2].Color.."Common" },
		{ selected = false, value = 3 , text = "|cff"..RarityColorsTable[3].Color.."Uncommon" },
		{ selected = true, value = 4 , text = "|cff"..RarityColorsTable[4].Color.."Rare" },
	}, key = "Capture" },
	{ type = "title", text = "" },
	{ type = "entry", text = "Number of same Pets", value = 1, enabled = true, key = "NumPets" },
	{ type = "separator" },
	{ type = "title", text = "Pet Leveling" },
	{ type = "title", text = "" },
	{ type = "entry", text = "Level first pet", enabled = true, value = 25, key = "LevelPet" },
	{ type = "entry", text = "Out of Battle Rotate Pets For Leveling", enabled = true, key = "RotatePetsEnabled" },
	{ type = "title", text = "" },
	{ type = "title", text = "Leveling Priority" },
	{ type = "dropdown", menu = {
		{ selected = false, value = 1, text = "|cff"..(RarityColorsTable[3].Color).."Low Level" },
		{ selected = false, value = 2, text = "|cffFF0000High Level" },
		{ selected = true, value = 3, text = "|cffFFFFFFNon-Wilds|cff33CCFF/|cff"..(RarityColorsTable[3].Color).."Low Level" },
		{ selected = false, value = 4, text = "|cffFFFFFFNon-Wilds|cff33CCFF/|cffFF0000HighLevel" },
	}, key = "LevelingPriority" },
	{ type = "title", text = "" },
	{ type = "title", text = "Minimum Pet Rarity to Level" },
	{ type = "dropdown", menu = {
		{ selected = false, value = 1 , text = "|cff"..RarityColorsTable[1].Color.."Poor" },
		{ selected = false, value = 2 , text = "|cff"..RarityColorsTable[2].Color.."Common" },
		{ selected = false, value = 3 , text = "|cff"..RarityColorsTable[3].Color.."Uncommon" },
		{ selected = true, value = 4 , text = "|cff"..RarityColorsTable[4].Color.."Rare" },
	}, key = "LevelingRarity" },
	{ type = "title", text = "" },
}
local queue = {
	"Settings",
	"Swap Table",
	"Switcher",
	"Fable Rotation",
	"Normal Rotation",
	"Masters Rotation",
	"PvP Rotation",
	"Follower",
}
local PetAbilitiesTable = {
	{ A1 = 1 , A2 = 1 , A3 = 1 },
	{ A1 = 1 , A2 = 1 , A3 = 1 },
	{ A1 = 1 , A2 = 1 , A3 = 1 }
};
local TypeWeaknessTable = {
	{	Num = 1, 	Type = "Humanoid",	Weak = 8,	Strong = 2, Resist = 5,	Color = "00AAFF"	},
	{	Num = 2, 	Type = "Dragonkin",	Weak = 4,	Strong = 6, Resist = 3,	Color = "33FF33"	},
	{	Num = 3, 	Type = "Flying",	Weak = 2,	Strong = 9, Resist = 8,	Color = "FFFF66"	},
	{	Num = 4, 	Type = "Undead",	Weak = 9,	Strong = 1, Resist = 2,	Color = "663366"	},
	{	Num = 5, 	Type = "Critter",	Weak = 1,	Strong = 4, Resist = 7,	Color = "AA7744"	},
	{	Num = 6, 	Type = "Magic",		Weak = 10,	Strong = 3, Resist = 9,	Color = "CC44DD"	},
	{	Num = 7, 	Type = "Elemental",	Weak = 5,	Strong = 10,Resist = 10,Color = "FF9933"	},
	{	Num = 8, 	Type = "Beast",		Weak = 3,	Strong = 5, Resist = 1,	Color = "DD2200"	},
	{	Num = 9, 	Type = "Aquatic",	Weak = 6,	Strong = 7, Resist = 4,	Color = "33CCFF"	},
	{	Num = 10, 	Type = "Mechanical",Weak = 7,	Strong = 8, Resist = 6,	Color = "999999"	},
};
local activePet = {
	slot = 1,
	HP = 69,
	ID = 1,
	percent = 1,
	speed = 69,
};
local enemyPet = {
	slot = 1,
	ID = 1,
	percent = 1,
	HP = 69,
	speed = 69,
	type = 0,
};
local PetHPTable = {
	[1] = 0,
	[2] = 0,
	[3] = 0
}
local settings = {
	Pet1HP = 69,
	Pet2HP = 69,
	Pet3HP = 69,
	averageHP = 69,
	inPvPBattle = false,
	CanSwapOut = false,
	SwapOutHealthValue = 0,
	SwapOutHealthCheck = false,
	PetLevelingValue = 25,
	PetLevelingCheck = false,
	ObjectiveValue = 1,
	ReviveBattlePetsCheck = false,
	ReviveBattlePetsValue = 70,
	PetHealValue = 70,
	PetHealCheck = false,
	CaptureValue = 4,
	CaptureCheck = false,
	NumberOfPetsValue = 3,
	AutoClickerCheck = false,
	FollowerDistanceValue = 3,
	FollowerDistanceCheck = false,
	LevelingPriorityValue = 1,
	LevelingRarityValue = 1,
	SwapInHealthValue = 1,
	PvPCheck = false,
	PvPSlotValue = 1,
	PetSwapCheck = false,
	PetSwapValue = 1,
	PetSwapMinValue = 1,
	WeatherID = 0,
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
local function OnLoad()
	ni.GUI.AddFrame("PetBattles", items);
end
local function OnUnload()
	ni.GUI.DestroyFrame("PetBattles");
end
-- Local Functions and Variables
local SetManual = false;
local SetTimerScan = 0;
local sTimer = 0;
local zTimer = 0;
local IsSwapping = 0;
local CalmDown = 0;
local LastInteract = 0;
local Pets = { };
local PetTable = { };
local RingersTable = { };
-- AbilitySpam(Ability) - Cast this single ability with checks.	
local function AbilitySpam(Ability)
	if PetAbilitiesTable[activePet.slot].A1 == Ability then
		C_PetBattles.UseAbility(1)		   
	end
	if PetAbilitiesTable[activePet.slot].A2 == Ability then
		C_PetBattles.UseAbility(2)
	end
	if PetAbilitiesTable[activePet.slot].A3 == Ability then
		C_PetBattles.UseAbility(3)
	end
end
local function IsStrongAbility(Poke_Ability, EnemyType)
	if TypeWeaknessTable[select(7,C_PetBattles.GetAbilityInfoByID(Poke_Ability))].Strong == EnemyType then
		return true;
	end
	return false;
end
local function IsWeakAbility(Poke_Ability, EnemyType)
	if TypeWeaknessTable[select(7,C_PetBattles.GetAbilityInfoByID(Poke_Ability))].Weak == EnemyType then
		return true;
	end
	return false;
end
-- Call to check ability vs enemy pet type.
local function AbilityTest(Poke_Ability)
	local IsStrongAbility = IsStrongAbility(Poke_Ability, enemyPet.type);
	local IsWeakAbility = IsWeakAbility(Poke_Ability, enemyPet.type);
	if IsStrongAbility then return 3 end
	if not IsWeakAbility and not IsStrongAbility then return 2 end
	if IsWeakAbility then return 1 end
end
-- AbilityCast(CastList, DmgCheck) - Cast this Ability List. DmgCheck - 1 = Strong  2 = Normal  3 = Weak  4 = all
local function AbilityCast(CastList, DmgCheck)
	for i = 1, #CastList do
		if DmgCheck == nil then
			local Poke_Ability = CastList[i]
			AbilitySpam(Poke_Ability)
		end
		if DmgCheck ~= nil then
			local Poke_Ability = CastList[i];
			local IsStrongAbility = IsStrongAbility(Poke_Ability, enemyPet.type);
			local IsWeakAbility = IsWeakAbility(Poke_Ability, enemyPet.type);
			if DmgCheck == 1 
			  and IsStrongAbility then
				AbilitySpam(Poke_Ability)
			end
			if DmgCheck == 2
			  and not IsStrongAbility 
			  and not IsWeakAbility then
				AbilitySpam(Poke_Ability)
			end
			if DmgCheck == 3
			  and IsWeakAbility then
				AbilitySpam(Poke_Ability)
			end
			if DmgCheck == 4 then
				AbilitySpam(Poke_Ability)
			end
		end
	end
end
-- Return Time in minuts/seconds of the battle.
local function GetBattleTime()
	if sTimer ~= 0 then
		cTimermin =  floor((GetTime() - sTimer)/60)
		cTimersec =  floor((GetTime() - sTimer)) - (60 * cTimermin)
		return cTimermin, cTimersec 
	else
		return 0 
	end
end
-- Return the number of abilities the pet have according to his level.
local function GetNumofPetAbilities(PetSlot)
	local Petlevel = C_PetBattles.GetLevel(1, PetSlot)
	if Petlevel >= 4 then 
		return 3
	elseif Petlevel >= 2 then
		return 2
	else
		return 1
	end
end
-- Return true if the attack is in one of these attacks.
local ToQueryLists = { PunchList, HighDMGList, ThreeTurnHighDamageList };
local function IsPetAttack(PokeAbility)
	for i = 1, #ToQueryLists do
		for j = 1 , #ToQueryLists[i] do
			if ToQueryLists[i][j] == PokeAbility then 
				return true
			end
		end
	end
	return false
end
-- Call to see pet Strengths based on IsPetAttack() lists.
local function GetPetStrength(PetSlot)
	if PetHPTable[PetSlot] ~= 0 then
		local IsPetStrength = 0
		local petGUID, ability1, ability2, ability3, locked = C_PetJournal.GetPetLoadOutInfo(PetSlot)
		local Abilities = { ability1, ability2, ability3 }
		for i = 1, GetNumofPetAbilities(PetSlot) do
			local test = AbilityTest(Abilities[i]);
			local attack = IsPetAttack(Abilities[i]);
			if test == 3 
			  and attack then
				IsPetStrength = ( IsPetStrength + 1 )
			elseif test == 1 
			  and attack then
				IsPetStrength = ( IsPetStrength - 1 )
			end
		end
		return IsPetStrength
	else
		return 0
	end
end
-- IsBuffed(Ability, BuffTarget, ForceID) - Test if Ability - 1 is in List. Can test additional IDs.
local function IsBuffed(Ability, BuffTarget, ForceID)
	if settings.inBattle then
		local found = false
		for i = 1, C_PetBattles.GetNumAuras(BuffTarget, C_PetBattles.GetActivePet(BuffTarget)) do
			local auraID = C_PetBattles.GetAuraInfo(BuffTarget, C_PetBattles.GetActivePet(BuffTarget), i)
			if Ability ~= nil then
				if auraID == ( Ability - 1 ) then     
					found = true       
				end
			end
			if ForceID ~= nil then
				if auraID == ForceID then
					found = true
				end
			end
		end
		return found
	end
end
-- Immunity() - Test if the ennemy pet is Immune.	
local function Immunity()
	for i = 1, #ImmunityList do
		local Poke_Ability = ImmunityList[i]
		if IsBuffed(Poke_Ability,2,Poke_Ability) then -- Si Aura = Buff 
			return true     
		end
	end
	if enemyPet.percent <= 40 then
		for i = 1, #CantDieList do
			local Poke_Ability = CantDieList[i]
			if IsBuffed(Poke_Ability,2,Poke_Ability) then -- Si Aura = Buff 
				return true     
			end
		end
	end
	return false
end
-- IsBuffed(Ability, BuffTarget, ForceID) - Test if Ability - 1 is in List. Can test additional IDs.
local function IsMultiBuffed(Ability, BuffTarget, ForceID)
	if settings.inBattle then
		if ForceID ~= nil then
			if IsBuffed(ForceID, BuffTarget) then
				return true
			end
		end
		for i = 1, #Ability do
			if IsBuffed(Ability[i], BuffTarget) then
				return true
			end
		end
	end
end
-- Health from journal
local function JournalHealth(PetSlot)
	local PetHealth = 100 * (select(1,C_PetJournal.GetPetStats(C_PetJournal.GetPetLoadOutInfo(PetSlot))) / select(2,C_PetJournal.GetPetStats(C_PetJournal.GetPetLoadOutInfo(PetSlot))) )
	if PetHealth == nil then
		return 0
	else
		return PetHealth
	end
end
-- Health from journal by GUID
local function JournalHealthGUID(PetGUID)
	local PetHealth = 100 * (select(1,C_PetJournal.GetPetStats(PetGUID)) / select(2,C_PetJournal.GetPetStats(PetGUID)) )
	if PetHealth == nil then
		return 0
	else
		return PetHealth
	end
end
-- PetLevel
local function PetLevel(PetSlot)
	if settings.inBattle then
		local MyPetLevel = C_PetBattles.GetLevel(1, PetSlot)
		return MyPetLevel
	end
	if not settings.inBattle then
		local MyPetLevel = select(3, C_PetJournal.GetPetInfoByPetID(C_PetJournal.GetPetLoadOutInfo(PetSlot)))
		return MyPetLevel
	end
end	
-- Switch Pet
local function Switch()
	AbilityCast(SuicideList)
	-- Make sure we are not rooted.
	if settings.CanSwapOut then
		if activePet.HP <= settings.SwapOutHealthValue 
		  and settings.SwapOutHealthCheck
		  or settings.PetLevelingCheck and activePet.slot == 1 then
			if activePet.slot == 1 
			  and settings.Pet1HP <= settings.SwapOutHealthValue 
			  or enemyPet.HP < 100 then
				if GetPetStrength(2) > GetPetStrength(3) 
				  and settings.Pet2HP >= settings.SwapInHealthValue then
					C_PetBattles.ChangePet(2)
				elseif settings.Pet3HP >= settings.SwapInHealthValue 
				  or settings.Pet1HP == 0 then
					C_PetBattles.ChangePet(3)
				end
			end
			if activePet.slot == 2 then
				if GetPetStrength(1) > GetPetStrength(3)
				  and settings.Pet1HP >= settings.SwapInHealthValue 
				  and not ( settings.PetLevelingCheck and settings.PetLevelingValue > C_PetBattles.GetLevel(1, 1) ) then
					C_PetBattles.ChangePet(1)
				elseif settings.Pet3HP >= settings.SwapInHealthValue or settings.Pet2HP == 0 then
					C_PetBattles.ChangePet(3)
				end
			end
			if activePet.slot == 3 then
				if GetPetStrength(1) > GetPetStrength(2) 
				  and settings.Pet1HP >= settings.SwapInHealthValue 
				  and not ( settings.PetLevelingCheck and settings.PetLevelingValue > C_PetBattles.GetLevel(1, 1) ) then
					C_PetBattles.ChangePet(1)
				elseif settings.Pet2HP >= settings.SwapInHealthValue or settings.Pet3HP == 0 then
					C_PetBattles.ChangePet(2)
				elseif settings.Pet2HP == 0 and settings.Pet3HP == 0 then
					C_PetBattles.ChangePet(1)
				end
			end
		end
	end
end
-- AoE Attacks to be used only while there are 3 ennemies.
local function AoEPunch()
	if enemyPet.slot == 1 or 2 then
		AbilityCast(AoEPunchList)
	end
end
-- Abilities that are stronger if the enemy have more health than us.
Comeback = nil
local function Comeback()
	if activePet.HP < enemyPet.percent 
	  and not Immunity() then
		AbilityCast(ComebackList)
	end
end
-- Damage Buffs that we want to cast on us.
local function DamageBuff()
	if not IsMultiBuffed(DamageBuffList, 1, 485) then		
		AbilityCast(DamageBuffList)	
	end
end
-- Debuff to cast on ennemy.
local function DeBuff()		
	if enemyPet.percent >= 45 
	  and not Immunity() then
		for i = 1, #DeBuffList do
			if not IsBuffed(DeBuffList[i], 2) then
				AbilitySpam(DeBuffList[i])
			end
		end
		for i = 1, #SpecialDebuffsList do
			if not IsBuffed(nil, 2, SpecialDebuffsList[i].Debuff) then
				AbilitySpam(SpecialDebuffsList[i].Ability)
			end
		end
	end
end	
-- HighDamageIfBuffed to cast on ennemy.
local function HighDamageIfBuffed()
	if not Immunity() then	
		for i = 1, #HighDamageIfBuffedList do
			if IsBuffed(nil, 2, HighDamageIfBuffedList[i].Debuff) then
				AbilitySpam(HighDamageIfBuffedList[i].Ability)
			end
		end
	end
end
-- Abilities to shield ourself to avoid an ability.
local function Deflect()
	if IsMultiBuffed(ToDeflectList, 2) then		
		AbilityCast(DeflectorList)
	end
end
-- Apocalypse
local function DelayFifteenTurn()
	if enemyPet.slot == 1 then 
		AbilityCast(FifteenTurnList)
	end
end
-- Damage in three turn
local function DelayThreeTurn()
	if enemyPet.slot ~= 3 then
		AbilityCast(ThreeTurnList)	
	end
end
-- Damage in one turn.
local function DelayOneTurn()
	if not ( enemyPet.slot == 3 and enemyPet.HP <= 30 ) then
		AbilityCast(OneTurnList)
	end
end
-- Execute if enemy pet is under 30%.
local function Execute()
	if enemyPet.percent <= 60 
	  and not Immunity() then
		AbilityCast(ExecuteList)
	end
end
-- Buffs that heal us.
local function HoTBuff()
	if activePet.HP < ( settings.PetHealValue + 10 )
	  and not ( enemyPet.HP < 40 and enemyPet.slot == 3 ) then
		for i = 1, #HoTList do
			for j = 1, #HoTBuffList do
				local Poke_Ability = HoTBuffList[j]			
				if not IsBuffed(Poke_Ability, 2) then		
					AbilitySpam(Poke_Ability)
				end
			end	
		end
	end
end
-- Suicide if under 20% Health.
local function Kamikaze()
	if activePet.HP < 20 
	  and not Immunity() then
		AbilityCast(KamikazeList)
	end
end
local function LastStand()
	if activePet.HP < 25 then
		AbilityCast(LastStandList)
	end
end
local function LifeExchange()
	if activePet.HP < 35
	  and enemyPet.HP > 70 then
		AbilityCast(LifeExchangeList)	
	end
end
local function PassTurn()
	if IsMultiBuffed(StunnedDebuffs, 1) then -- if we are stunned
		C_PetBattles.SkipTurn() -- skip turn
	end
end
-- Abilities for leveling.
local function PetLeveling(HighDmgCheck)
	AbilityCast(PetLevelingList, HighDmgCheck)
end	
-- Attack that are stronger if we are quicker.
local function QuickPunch() 
	if activePet.speed > enemyPet.speed 
	  and not Immunity() then
		AbilityCast(QuickList)
	end
end
-- List of Buffs that we want to cast on us.
local function SelfBuff()
	if activePet.HP > 15
	  and not ( enemyPet.percent <= 40 and enemyPet.slot == 3 ) then
		if not IsMultiBuffed(SelfBuffList, 1) then		
			AbilityCast(SelfBuffList)
		end
		for i = 1, #SpecialSelfBuffList do
			if not IsBuffed(nil, 1, SpecialSelfBuffList[i].Buff) then
				AbilitySpam(SpecialSelfBuffList[i].Ability)
			end
		end			
	end
end
-- Direct Healing
local function SimpleHealing()
	if activePet.percent < settings.PetHealValue
	  and settings.PetHealCheck then
		AbilityCast(HealingList)
	end	
end
local function SimpleHighPunch(HighDmgCheck)
	if not Immunity() then
		AbilityCast(HighDMGList, HighDmgCheck)
	end
end
-- Basic Attacks.
local function SimplePunch(HighDmgCheck)
	if not Immunity() then
		if HighDmgCheck ~= nil then
			AbilityCast(PunchList, HighDmgCheck)
		else
			AbilityCast(PunchList)
		end
	end
end	
local function ShieldBuff()
	if not ( enemyPet.percent <= 30 
	  and enemyPet.slot == 3 ) then
		if not IsMultiBuffed(ShieldBuffList, 1) then		
			AbilityCast(ShieldBuffList)
		end
	end
end
local function SlowPunch()
	if not Immunity() then
		AbilityCast(SlowPunchList)
	end
end
local function SpeedBuff()
	if activePet.speed < enemyPet.speed then
		for i = 1, #SpeedBuffList do
			if not IsBuffed(SpeedBuffList[i], 1) then		
				AbilitySpam(SpeedBuffList[i])
			end
		end
	end
end
local function SpeedDeBuff()		
	if enemyPet.percent >= 45 
	  and activePet.speed < enemyPet.speed 
	  and activePet.speed > ( 3 * enemyPet.speed / 4 ) then
		for i = 1, #SpeedDeBuffList do
			if not IsBuffed(SpeedDeBuffList[i], 2) then
				AbilitySpam(SpeedDeBuffList[i])
			end
		end
	end
end
local function Stun()
	if not Immunity() then
		AbilityCast(StunList)
	end
end
local function Soothe()
	AbilityCast(SootheList)
end
local function TeamDebuff()
	if not ( enemyPet.slot == 3
	  and enemyPet.percent <= 55 ) then
		for i = 1, #TeamDebuffList do
			local found = false		
			for j = 1, ( C_PetBattles.GetNumAuras(2, 0) or 0 ) do
				local auraID = C_PetBattles.GetAuraInfo(2, 0, j)
				if auraID == ( TeamDebuffList[i] - 1 ) then   
					found = true
					break;
				end
			end
			if not found then		
				AbilitySpam(TeamDebuffList[i])
			end
		end
	end
end
local function TeamHealBuffs()
	if activePet.HP < settings.PetHealValue
	  and not ( enemyPet.HP < 40 and enemyPet.slot == 3 ) then
		for i = 1, #TeamHealBuffsAbilities do
			local found = false		
			for j = 1, #TeamHealBuffsList do
				for k = 1, ( C_PetBattles.GetNumAuras(1,0) or 0 ) do				
					local auraID = C_PetBattles.GetAuraInfo(1, 0, k)
					if auraID == TeamHealBuffsList[j] then   
						found = true       
						break;
					end
				end
			end
			if not found then		
				AbilitySpam(TeamHealBuffsAbilities[i])
			end		
		end
	end
end
-- Abilities that last three turns that does high damage.
local function ThreeTurnHighDamage()
	if activePet.HP > 60 then
		AbilityCast(ThreeTurnHighDamageList)
	end
end
-- Robot Turrets
local function Turrets(HighDmgCheck)
	if settings.WeatherID ~= 454 
	  and not ( enemyPet.slot == 3
	  and enemyPet.percent <= 55 ) then
		AbilityCast(TurretsList, HighDmgCheck)
	end
end
-- CapturePet() - Test for targets to trap.
local function CapturePet()
	if settings.inBattle 
	  and C_PetBattles.GetBreedQuality(2, enemyPet.slot) >= settings.CaptureValue 
	  and C_PetJournal.GetNumCollectedInfo(C_PetBattles.GetPetSpeciesID(2,enemyPet.slot)) < settings.NumberOfPetsValue
	  and settings.CaptureCheck then
		if enemyPet.HP <= 35 
		  and C_PetBattles.IsTrapAvailable() then
			if SimpleHealing ~= nil then SimpleHealing() end
			C_PetBattles.UseTrap()
		elseif enemyPet.HP <= 65 then
			if SimpleHealing ~= nil then SimpleHealing() end
			if Stun ~= nil then Stun() end 
			if SimplePunch ~= nil then SimplePunch(3) end 
			if SimplePunch ~= nil then SimplePunch(2) end 
			if SimplePunch ~= nil then SimplePunch(1) end 
		else
			if SimpleHealing ~= nil then SimpleHealing() end
			if Stun ~= nil then Stun() end 
			if SimplePunch ~= nil then SimplePunch(1) end 
			if SimplePunch ~= nil then SimplePunch(2) end 
			if SimplePunch ~= nil then SimplePunch(3) end 
		end
	end
end
local function PetLevelFunction()
	if settings.PetLevelingCheck 
	  and PetLevel(1) < settings.PetLevelingValue then
		-- If we are trying to level pets.
		if activePet.slot == 1 then		  	
		  	-- Get out as soon as we get a poison debuff on us.
		  	if IsMultiBuffed(SwapoutDebuffList, 1) then
		  		C_PetBattles.ChangePet(2)
		  	end
			-- Swap Pet
			if (activePet.HP < 75 or enemyPet.HP < 100 or enemyPet.slot ~= 1) then
				C_PetBattles.ChangePet(2)
			end
			-- Swap Pet
			if select(2,GetBattleTime()) > 3 then
				C_PetBattles.ChangePet(2)
			end
		  	SimpleHighPunch(1)
			SimplePunch(1)
			PetLeveling(1)
			SimpleHighPunch(2)
			SimplePunch(2)
			PetLeveling(2)
			SimpleHighPunch(3)
			SimplePunch(3)
			PetLeveling(3)
			C_PetBattles.UseAbility(1)
			C_PetBattles.UseAbility(2)
			C_PetBattles.UseAbility(3)
		end
	end
end
local function AverageHealth()
	local count = 0;
	local average = 0;
	for i = 1, 3 do
		local id = C_PetJournal.GetPetLoadOutInfo(i);
		if id ~= nil then
			local health, maxhealth = C_PetJournal.GetPetStats(id);
			average = average + (health / maxhealth * 100);
			count = count + 1;
		end
	end
	if count > 0 then
		return average / count;
	else
		return 100;
	end
end
local abilities = {
	["Settings"] = function()
		settings.inBattle = C_PetBattles.IsInBattle();
		settings.SwapOutHealthValue, settings.SwapOutHealthCheck = GetSetting("SwapOut");
		settings.PetLevelingValue, settings.PetLevelingCheck = GetSetting("LevelPet");
		settings.ObjectiveValue = GetSetting("Objective");
		settings.ReviveBattlePetsValue, settings.ReviveBattlePetsCheck = GetSetting("RevivePets");
		settings.PetHealValue, settings.PetHealCheck = GetSetting("PetHeal");
		settings.CaptureValue = GetSetting("Capture");
		settings.CaptureCheck = select(2, GetSetting("CapturePets"));
		settings.NumberOfPetsValue = GetSetting("NumPets");
		settings.AutoClickerCheck = select(2, GetSetting("AutoClicker"));
		settings.FollowerDistanceValue, settings.FollowerDistanceCheck = GetSetting("FollowDistance");
		settings.LevelingPriorityValue = GetSetting("LevelingPriority");
		settings.LevelingRarityValue = GetSetting("LevelingRarity");
		settings.SwapInHealthValue = GetSetting("SwapIn");
		settings.PvPSlotValue, settings.PvPCheck = GetSetting("PvP");
		-- Pet Swapper
		settings.PetSwapCheck = select(2, GetSetting("PetSwap"));
		settings.PetSwapValue = GetSetting("PetSwapMax");
		settings.PetSwapMinValue = GetSetting("PetSwapMin");

		
		-- In Battle timer
		if settings.inBattle then
			if sTimer == 0 then 
				sTimer = GetTime()
			end
		elseif sTimer ~= 0 then
			sTimer = 0
		end
		-- Out of Battle timer
		if not settings.inBattle then
			if zTimer == 0 then 
				zTimer = GetTime()
			end
		elseif zTimer ~= 0 then
			zTimer = 0
		end
		-------------------------
		-- Battle State & Vars --
		-------------------------
		settings.inPvPBattle = C_PetBattles.GetTurnTimeInfo() or false;
		if settings.inBattle then
			activePet.slot = C_PetBattles.GetActivePet(1)
			settings.CanSwapOut = C_PetBattles.CanActivePetSwapOut() or false;

			PetAbilitiesTable[1].A1 = C_PetBattles.GetAbilityInfo(1, 1, 1);
			PetAbilitiesTable[1].A2 = C_PetBattles.GetAbilityInfo(1, 1, 2);
			PetAbilitiesTable[1].A3 = C_PetBattles.GetAbilityInfo(1, 1, 3);
			PetAbilitiesTable[2].A1 = C_PetBattles.GetAbilityInfo(1, 2, 1);
			PetAbilitiesTable[2].A2 = C_PetBattles.GetAbilityInfo(1, 2, 2);
			PetAbilitiesTable[2].A3 = C_PetBattles.GetAbilityInfo(1, 2, 3);
			PetAbilitiesTable[3].A1 = C_PetBattles.GetAbilityInfo(1, 3, 1);
			PetAbilitiesTable[3].A2 = C_PetBattles.GetAbilityInfo(1, 3, 2);
			PetAbilitiesTable[3].A3 = C_PetBattles.GetAbilityInfo(1, 3, 3);
			
			activePet.HP = (100 * C_PetBattles.GetHealth(1, activePet.slot) / C_PetBattles.GetMaxHealth(1, activePet.slot))
			activePet.ID = C_PetBattles.GetDisplayID(1, activePet.slot)
			activePet.percent = floor(activePet.HP)

			enemyPet.slot = C_PetBattles.GetActivePet(2)
			enemyPet.HP = (100 * C_PetBattles.GetHealth(2, enemyPet.slot) / C_PetBattles.GetMaxHealth(2, enemyPet.slot))
			enemyPet.ID = C_PetBattles.GetDisplayID(1, enemyPet.slot)
			enemyPet.percent = floor(enemyPet.HP)
			enemyPet.type = C_PetBattles.GetPetType(2, enemyPet.slot);
			
			settings.WeatherID = C_PetBattles.GetAuraInfo(0, 0, 1)
			
			local health1 = C_PetBattles.GetHealth(1, 1);
			local maxhealth1 = C_PetBattles.GetMaxHealth(1, 1);
			local health2 = C_PetBattles.GetHealth(1, 2);
			local maxhealth2 = C_PetBattles.GetMaxHealth(1, 2);
			local health3 = C_PetBattles.GetHealth(1, 3);
			local maxhealth3 = C_PetBattles.GetMaxHealth(1, 3);
			settings.Pet1HP = floor((100 * health1 / maxhealth1))
			settings.Pet2HP = floor((100 * health2 / maxhealth2))
			settings.Pet3HP = floor((100 * health3 / maxhealth3))
			PetHPTable[1] = settings.Pet1HP;
			PetHPTable[2] = settings.Pet2HP;
			PetHPTable[3] = settings.Pet3HP;
			
			settings.averageHP = floor(((settings.Pet1HP + settings.Pet2HP + settings.Pet3HP) / 3))
			
			-- Speed Check
			activePet.speed = C_PetBattles.GetSpeed(1, activePet.slot)
			enemyPet.speed = C_PetBattles.GetSpeed(2, enemyPet.slot)
		else
			settings.averageHP = AverageHealth();
		end
		if not settings.inBattle 
		  and settings.ReviveBattlePetsCheck
		  and not UnitCastingInfo("player")
		  and not UnitChannelInfo("player") then			
			if settings.averageHP < settings.ReviveBattlePetsValue then
				if ni.spell.available(125439) then
					settings.Pet1HP = 100
					settings.Pet2HP = 100
					settings.Pet3HP = 100
					settings.averageHP = 100
					ni.spell.cast(GetSpellInfo(125439),"player")
				end
			end	
		end
	end,
	["Swap Table"] = function()
		-- Pet swap table --
		if not settings.inBattle 
		  and settings.PetSwapCheck 
		  and settings.PetLevelingCheck
		  and not settings.PvPCheck 
		  and settings.ObjectiveValue == 1 then
		  
			-- Pet Leveling Slot 1
			if PetLevel(1) >= settings.PetSwapValue or PetLevel(1) < settings.PetSwapMinValue or JournalHealth(1) <= settings.SwapInHealthValue then
				table.wipe(PetTable);
				for i = 1, select(2,C_PetJournal.GetNumPets()) do
					local petID, _, _, _, level, Favorite, _, _, _, _, _, _, _, isWild, canBattle = C_PetJournal.GetPetInfoByIndex(i)
					if petID ~= nil then
						local WildConvert = 0;
						if isWild then
							WildConvert = 1
						end
						local FavoriteConvert = 0;
						if Favorite then
							FavoriteConvert = 1
						end
						if canBattle
						  and ( level < settings.PetSwapValue and JournalHealthGUID(petID) >= settings.SwapInHealthValue )
						  and level >= settings.PetSwapMinValue 
						  and petID ~= C_PetJournal.GetPetLoadOutInfo(1) 
						  and petID ~= C_PetJournal.GetPetLoadOutInfo(2) 
						  and petID ~= C_PetJournal.GetPetLoadOutInfo(3) 
						  and select(5, C_PetJournal.GetPetStats(select (1,C_PetJournal.GetPetInfoByIndex(i)))) >= settings.LevelingRarityValue then
							table.insert(PetTable,{ 
								ID = petID, 
								Level = level, 
								Favorite = FavoriteConvert,
								Wild = WildConvert,
							});
						end
					end
				end
				if #PetTable > 0 then
					table.sort(PetTable, function(x,y) return x.Favorite < y.Favorite end)
					-- Level Sorts
					if settings.LevelingPriorityValue == 1 or  3 then
						table.sort(PetTable, function(x,y) return x.Level < y.Level end)
					end
					if settings.LevelingPriorityValue == 2 or 4 then
						table.sort(PetTable, function(x,y) return x.Level > y.Level end)
					end
					-- Wild Sorts
					if settings.LevelingPriorityValue ==  3 or 4 then
						table.sort(PetTable, function(x,y) return x.Wild < y.Wild end)
					end
					C_PetJournal.SetPetLoadOutInfo(1, PetTable[1].ID)
				end
			end
			
			-- Other pets check health
			for i = 1, 3 do
				if not ( i == 1 and settings.PetLevelingCheck ) then
					if ( JournalHealth(i) <= settings.SwapInHealthValue or PetLevel(i) ~= 25 )then
						table.wipe(RingersTable);
						for j = 1, select(2,C_PetJournal.GetNumPets()) do
							local petID, _, _, _, level, Favorite, _, _, _, _, _, _, _, isWild, canBattle = C_PetJournal.GetPetInfoByIndex(j)
							if petID ~= nil then
								local WildConvert = 0;
								if isWild then
									WildConvert = 1
								end
								local FavoriteConvert = 0;
								if Favorite then
									FavoriteConvert = 1;
								end
								if canBattle
								  and JournalHealthGUID(petID) >= settings.SwapInHealthValue
								  and level >= settings.PetSwapMinValue 
								  and petID ~= C_PetJournal.GetPetLoadOutInfo(1) 
								  and petID ~= C_PetJournal.GetPetLoadOutInfo(2) 
								  and petID ~= C_PetJournal.GetPetLoadOutInfo(3) 
								  and select(5, C_PetJournal.GetPetStats(select (1,C_PetJournal.GetPetInfoByIndex(j)))) >= 4 then
									table.insert(RingersTable,{ 
										ID = petID, 
										Level = level, 
										Favorite = FavoriteConvert,
										Wild = WildConvert,
									});
								end
							end
						end
						if #RingersTable > 0 then
							-- Favorites Sorts
							table.sort(RingersTable, function(x,y) return x.Favorite < y.Favorite end)
							-- Level Sorts
							table.sort(RingersTable, function(x,y) return x.Level > y.Level end)
							-- Switch Pet
							C_PetJournal.SetPetLoadOutInfo(i, RingersTable[1].ID)
						end
					end
				end
			end
		end
	end,
	["Switcher"] = function()
		if settings.PvPCheck then
			if C_PetBattles.GetPVPMatchmakingInfo() == nil and C_PetBattles.IsPlayerNPC(2) == nil then
				C_PetBattles.StartPVPMatchmaking()
			end
			if C_PetBattles.GetPVPMatchmakingInfo() == "proposal" and C_PetBattles.IsPlayerNPC(2) == nil then
				C_PetBattles.AcceptQueuedPVPMatch()
			end
			if C_PetBattles.GetPVPMatchmakingInfo() == nil and C_PetBattles.IsPlayerNPC(2) == false then
				C_PetBattles.ChangePet(settings.PvPSlotValue)
			end
		end
	end,
	["Fable Rotation"] = function()
		-- Rotation
		if C_PetBattles.IsInBattle() 
		  and IsBuffed(nil, 2, 956) 
		  and ( settings.ObjectiveValue == 3 or 4 ) then
			DelayFifteenTurn()
			if activePet.slot == 1 then
				found = false
				for i = 1, C_PetBattles.GetNumAuras(1, 0) or 0 do
					local auraID = C_PetBattles.GetAuraInfo(1, 0, i)
					if auraID == 683 then   
						found = true     
					end
				end	
				-- Get out as soon as we get a Apocalypse Debuff on ennemy team.
				if found then
					C_PetBattles.ChangePet(2)
				end
			end
			if activePet.slot ~= 1 then
				for i = 1, C_PetBattles.GetNumAuras(1, 0) or 0 do
					local auraID = C_PetBattles.GetAuraInfo(1, 0, i)
					if auraID == 683 then   
						if select(3, C_PetBattles.GetAuraInfo(1, 0, i)) < 2 then
							C_PetBattles.ChangePet(1)
						end
					end
				end	
			end
			if activePet.slot == 1 then
				for i = 1, C_PetBattles.GetNumAuras(1, 0) or 0  do
					local auraID = C_PetBattles.GetAuraInfo(1, 0, i)
					if auraID == 683 then   
						if select(3, C_PetBattles.GetAuraInfo(1, 0, i)) < 3 then
						--	print("Survies Caliss")
							AbilitySpam(283)
						end
					end
				end	
			end
			if settings.Pet2HP == 0 then
				if settings.Pet3HP == 0 then
					C_PetBattles.ChangePet(1)
				else
					C_PetBattles.ChangePet(3)
				end
			end
			if settings.Pet1HP == 0 then
				if settings.Pet2HP == 0 then
					C_PetBattles.ChangePet(3)
				else
					C_PetBattles.ChangePet(2)
				end
			end
			if settings.Pet3HP == 0 then
				if settings.Pet2HP == 0 then
					C_PetBattles.ChangePet(1)
				else
					C_PetBattles.ChangePet(2)
				end
			end
			PassTurn()
			if not IsBuffed(496, 2,496) 
			  and not IsBuffed(924, 2,924) then
				Soothe()
			end
			Deflect()
		--	Execute()
			Kamikaze()
			DelayOneTurn()
			LastStand()
			ShieldBuff()
			LifeExchange()
			SimpleHealing()
			
			DelayThreeTurn()
			TeamHealBuffs()
			HoTBuff()
			SelfBuff()
			DamageBuff()
			SpeedDeBuff()
			if IsBuffed(496, 2,496) then -- if NME is soothed(Drowsy)
				if activePet.slot == 2 then
					if settings.Pet3HP > 70 then
						C_PetBattles.ChangePet(3)
						return true
					end
				end		
				C_PetBattles.SkipTurn() -- skip turn 
				return true
			end
			if IsBuffed(926, 2,926) then -- if NME is soothed
				C_PetBattles.SkipTurn() -- skip turn
				return true
			end
			if IsBuffed(236, 2,236) then -- if NME is soothed
				C_PetBattles.SkipTurn() -- skip turn
				return true
			end
			HighDamageIfBuffed()
			AoEPunch()
			ThreeTurnHighDamage()
			SimpleHighPunch(1)
			SimpleHighPunch(2)
			SimpleHighPunch(3)
			SimplePunch(1)
			DeBuff()
			Stun()
			TeamDebuff()
			Turrets(1)
			Turrets(2)
			SpeedBuff()
			QuickPunch()
			Comeback()
			SimplePunch(2)
			Turrets(3)
			
			SimplePunch(3)
			
		--	C_PetBattles.UseAbility(1) -- Attack 1
		--	C_PetBattles.UseAbility(2) -- Attack 2
		--	C_PetBattles.UseAbility(3) -- Attack 3
			C_PetBattles.SkipTurn() -- skip turn.
		end	
	end,
	["Normal Rotation"] = function()
		if settings.inBattle
		 and settings.ObjectiveValue == 1 then
			PetLevelFunction()
			Switch()
			CapturePet()
			PassTurn()
			Deflect()
			Execute()
			Kamikaze()
			LastStand()
			ShieldBuff()
			LifeExchange()
			SimpleHealing()
			DelayFifteenTurn()
			DelayThreeTurn()
			DelayOneTurn()
			TeamHealBuffs()
			HoTBuff()
			HighDamageIfBuffed()
			SelfBuff()
			DamageBuff()
			SpeedDeBuff()
			AoEPunch()
			ThreeTurnHighDamage()
			SimpleHighPunch(1)
			SimplePunch(1)
			SimpleHighPunch(2)
			DeBuff()
			Soothe()
			Stun()
			TeamDebuff()
			Turrets(1)
			Turrets(2)
			SpeedBuff()
			QuickPunch()
			Comeback()
			SimplePunch(2)
			Turrets(3)
			SimpleHighPunch(3)
			SimplePunch(3)
			
			C_PetBattles.UseAbility(1) -- Attack 1
			C_PetBattles.UseAbility(2) -- Attack 2
			C_PetBattles.UseAbility(3) -- Attack 3
			C_PetBattles.SkipTurn() -- skip turn.
		end
	end,
	["Masters Rotation"] = function()
		-- Rotation
		if settings.inBattle
		and settings.ObjectiveValue == 4 then
			if settings.Pet2HP == 0 then
				if settings.Pet3HP == 0 then
					C_PetBattles.ChangePet(1)
				else
					C_PetBattles.ChangePet(3)
				end
			end
			if settings.Pet1HP == 0 then
				if settings.Pet2HP == 0 then
					C_PetBattles.ChangePet(3)
				else
					C_PetBattles.ChangePet(2)
				end
			end
			if settings.Pet3HP == 0 then
				if settings.Pet2HP == 0 then
					C_PetBattles.ChangePet(1)
				else
					C_PetBattles.ChangePet(2)
				end
			end
			PassTurn()
			Deflect()
			Execute()
			Kamikaze()
			LastStand()
			ShieldBuff()
			LifeExchange()
			SimpleHealing()
			DelayFifteenTurn()
			DelayThreeTurn()
			DelayOneTurn()
			TeamHealBuffs()
			HoTBuff()
			HighDamageIfBuffed()
			SelfBuff()
			DamageBuff()
			SpeedDeBuff()
			AoEPunch()
			ThreeTurnHighDamage()
			SimpleHighPunch(1)
			SimplePunch(1)
			SimpleHighPunch(2)
			DeBuff()
			Soothe()
			Stun()
			TeamDebuff()
			Turrets(1)
			Turrets(2)
			SpeedBuff()
			QuickPunch()
			Comeback()
			SimplePunch(2)
			Turrets(3)
			SimpleHighPunch(3)
			SimplePunch(3)
			
			C_PetBattles.UseAbility(1) -- Attack 1
			C_PetBattles.UseAbility(2) -- Attack 2
			C_PetBattles.UseAbility(3) -- Attack 3
			C_PetBattles.SkipTurn() -- skip turn.
		end
	end,
	["PvP Rotation"] = function()
		-- Rotation for PvP
		if settings.inBattle
		 and (settings.inPvPBattle
		 or settings.ObjectiveValue == 2) then
			PassTurn()
			Deflect()
			Execute()
			Kamikaze()
			LastStand()
			ShieldBuff()
			LifeExchange()
			SimpleHealing()
			DelayFifteenTurn()
			DelayThreeTurn()
			DelayOneTurn()
			TeamHealBuffs()
			HoTBuff()
			HighDamageIfBuffed()
			SelfBuff()
			DamageBuff()
			SpeedDeBuff()
			AoEPunch()
			ThreeTurnHighDamage()
			SimpleHighPunch(1)
			SimplePunch(1)
			SimpleHighPunch(2)
			DeBuff()
			Stun()
			TeamDebuff()
			Turrets(1)
			Turrets(2)
			SpeedBuff()
			QuickPunch()
			Comeback()
			SimplePunch(2)
			Turrets(3)
			SimpleHighPunch(3)
			SimplePunch(3)
			
		--	C_PetBattles.UseAbility(1) -- Attack 1
		--	C_PetBattles.UseAbility(2) -- Attack 2
		--	C_PetBattles.UseAbility(3) -- Attack 3
			C_PetBattles.SkipTurn() -- skip turn.
		end
	end,
	["Follower"] = function()
		---- PokeRotation Nav system ---
		ni.functions.resetlasthardwareaction()
		if UnitAffectingCombat("player")
		 and UnitExists("target")
		 and UnitCanAttack("player", "target")
		 and ni.player.threat("target") > -1 then
			if not ni.player.isfacing("target", 45) then
				ni.player.lookat("target");
				return true;
			end
		end
		if settings.averageHP < 33 then
			return true;
		end
		if not settings.inBattle 
		  and settings.ReviveBattlePetsCheck
		  and settings.averageHP < settings.ReviveBattlePetsValue then
			return true;
		end
		if not settings.inBattle
		 and IsSwapping <= GetTime() - 1
		 and settings.AutoClickerCheck
		 and not UnitAffectingCombat("player")
		 and not (settings.PetLevelingCheck and PetLevel == 25) then
			if GetTime() - LastInteract < 1.5 then
				return false;
			end
			table.wipe(Pets);
			for k, v in pairs(ni.objects) do
				if type(v) == "table" and type(k) ~= "function" then
					if tContains(MopList, v.name)
					 and not UnitIsDeadOrGhost(v.guid)
					 and UnitIsWildBattlePet(v.guid)
					 and ni.player.los(v.guid) then
						local distance = ni.player.distance(v.guid);
						if (distance ~= nil and distance <= settings.FollowerDistanceValue)
						 or not settings.FollowerDistanceCheck then
							table.insert(Pets,{
								guid = v.guid,
								dist = distance,
							});
						end
					end
				end
			end
			if #Pets > 0 then
				table.sort(Pets, function(x,y) return x.dist < y.dist end)
				if Pets[1].dist > 15 then
					ni.player.moveto(Pets[1].guid);
				else
					ni.player.interact(Pets[1].guid);
					LastInteract = GetTime();
				end
			end
		end
	end,
}
ni.bootstrap.profile("PokeRotation", queue, abilities, OnLoad, OnUnload);