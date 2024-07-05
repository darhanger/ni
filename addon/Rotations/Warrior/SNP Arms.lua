local abilities = {
	[1] = {
		condition = function()
			if ni.spell.available(2457) then
			if (UnitChannelInfo('player') ~= nil and false) or (UnitChannelInfo('player') == nil) then
				local DS = GetShapeshiftForm()
local unithealth = 100 * UnitHealth("player") / UnitHealthMax("player")

if DS == 1
and unithealth > 60
and not ni.unit.buff("player", 23920)
and not ni.unit.buff("player", 871) then
ni.player.runtext("/equip Relentless Gladiator's Decapitator")
end
			end
			return false
			end
		end,
		execution = function()
			ni.spell.cast(2457, "target")
		end,
	},
	[2] = {
		condition = function()
			if ni.spell.available(71) then
			if (UnitChannelInfo('player') ~= nil and false) or (UnitChannelInfo('player') == nil) then
				local DS = GetShapeshiftForm()
local unithealth = 100 * UnitHealth("player") / UnitHealthMax("player")

if DS ~= 2 and unithealth < 30 then
ni.player.runtext("/equip Relentless Gladiator's Cleaver")
ni.player.runtext("/equip Relentless Gladiator's Shield Wall")
return true
end
			end
			return false
			end
		end,
		execution = function()
			ni.spell.cast(71, "player")
		end,
	},
	[3] = {
		condition = function()
			if (UnitChannelInfo('player') ~= nil and false) or (UnitChannelInfo('player') == nil) then
				if not DEFINED then DEFINED = true
	print("www.snpexploits.com - Sapphire PVP Combat Routine")
															   
												   
													  
														
																				  
	-- Parameters
	Params = { 
		HEALTH_FOR_INTERRUPT = 85,	-- In percent
		ENABLE_RANDOM_INTERRUPT = true, -- Enable or not the random % for interrupt
		INTERRUPT_TIME = 35, -- Cast-Interrupt time if random-cancel disabled, In percent
		REFLECT_TIME = 80, -- Reflect time, In percent
		SHIELD_TYPE_NAME = "Shields", -- Depends on ur client's language
		CHARGE_FORCE_TIME = 0.5, -- Force time for charges in seconds (commands)
		CHECK_EVERYWHERE = false, -- Enable reflect/cancel in ffa checking all persons
		MANUAL_DEFENSE = false -- reflect/interrupt on shield/berkserk stance only
	}
	
	-- Weapons
	Weapons = {
		SHIELD = "Relentless Gladiator's Shield Wall",
		ONE_HAND = "Relentless Gladiator's Cleaver",
		TWO_HANDS = "Relentless Gladiator's Decapitator",
		ALL = "null"
	}
	
	-- Succubus var
	succubus = nil
	-- Autorebuff timer
	lastRebuff = 0
	-- Autoswap battle
	swapBattle = false
	-- Autoswap weapon
	swapWeapon = false
	-- Kick canalized spells
	canalized = 0
	canalizer = nil
	-- Commands
	lastCharged = nil
	safeCharges = 0
	commandString = nil
	commandTimeout = 1
	-- Priorities: stop rotation for keep rage
	prioritReflect = nil
	prioritInstant = nil
	prioritInterrupt = nil
	prioritDisarm = nil
	prioritHelp = nil
	prioritHeal = nil
	priorityOp = nil
	
	-- Cache random percent
	randomPercent = nil
	randomTime = 0
	
	-- Real target
	realTargets = {}
	realTimeout = 0
	realLastTarget = nil
	activeTarget = nil
	
	-- Casting targets
	warningCasts = {}
		
	-- Units
	player = "player"
	friend = "friend"
	enemy = "enemy" 
	-- Friend Units
	Friends = {
		"player", "party1", "party2", "party3"
	}
	-- Arena Enemy Units
	ArenaEnemies = {
		"focus", "arena1", "arena1pet", "arena2", "arena2pet", "arena3", "arena3pet", "mouseover"
	}
	-- Other Enemy Units
	Enemies = {
		"target", "focus", "mouseover"
	}
	
	-- Enemy spell types
	Types = {
		HEAL = 1,
		INTERRUPT = 2,
		REFLECT = 3,
		REFLECT_AND_INTERRUPT = 4
	}
	
	-- Cancelable and reflectable spells with interrupt time
	EnemySpells = {
		[47811] = { 							-- Lock: Immolate
			TYPE = Types.INTERRUPT,
			INTERRUPT = Params.INTERRUPT_TIME,
			REFLECT = nil,
			MANUAL = false
		},		
		[47838] = { 							-- Lock: Incinerate
			TYPE = Types.INTERRUPT, 
			INTERRUPT = Params.INTERRUPT_TIME,
			REFLECT = Params.REFLECT_TIME,
			MANUAL = false
		}, 	
		[47825] = { 							-- Lock: Soul Fire
			TYPE = Types.REFLECT_AND_INTERRUPT, 
			INTERRUPT = Params.INTERRUPT_TIME,
			REFLECT = Params.REFLECT_TIME,
			MANUAL = false
		}, 			
		[59172] = { 							-- Lock: Chaos bolt
			TYPE = Types.REFLECT_AND_INTERRUPT, 
			INTERRUPT = Params.INTERRUPT_TIME,
			REFLECT = Params.REFLECT_TIME,
			MANUAL = false
		},	
		[6215] = { 								-- Lock: Fear
			TYPE = Types.REFLECT_AND_INTERRUPT, 
			INTERRUPT = Params.INTERRUPT_TIME,
			REFLECT = Params.REFLECT_TIME,
			MANUAL = false
		},
		[712] = { 								-- Lock: Summon Succubus
			TYPE = Types.INTERRUPT,
			INTERRUPT = nil,
			REFLECT = nil,
			MANUAL = false
		},					
		[697] = { 								-- Lock: Summon Voidwalker
			TYPE = Types.INTERRUPT,
			INTERRUPT = nil,
			REFLECT = nil,
			MANUAL = false
		},					
		[691] = { 								-- Lock: Summon Felhunter
			TYPE = Types.INTERRUPT,
			INTERRUPT = nil,
			REFLECT = nil,
			MANUAL = false
		},					
		[18647] = {	 							-- Lock: Banish
			TYPE = Types.INTERRUPT,
			INTERRUPT = Params.INTERRUPT_TIME,
			REFLECT = nil,
			MANUAL = false
		},
		[47843] = { 							-- Lock: Unstable Affliction
			TYPE = Types.REFLECT_AND_INTERRUPT, 
			INTERRUPT = Params.INTERRUPT_TIME,
			REFLECT = Params.REFLECT_TIME,
			MANUAL = false
		},	
		[6358] = { 								-- Lock: Pet Seduction
			TYPE = Types.REFLECT_AND_INTERRUPT, 
			INTERRUPT = nil,
			REFLECT = nil,
			MANUAL = false
		},	
		[605] = { 								-- Priest: Mind Control
			TYPE = Types.REFLECT_AND_INTERRUPT, 
			INTERRUPT = Params.INTERRUPT_TIME,
			REFLECT = Params.REFLECT_TIME,
			MANUAL = false
		},		
		[48071] = { 							-- Priest: Flash Health
			TYPE = Types.HEAL, 
			INTERRUPT = Params.INTERRUPT_TIME,
			REFLECT = nil,
			MANUAL = false
		},					
		[48063] = { 							-- Priest: Greater Heal
			TYPE = Types.HEAL, 
			INTERRUPT = Params.INTERRUPT_TIME,
			REFLECT = nil,
			MANUAL = false
		},					
		[48120] = { 							-- Priest: Binding Heal
			TYPE = Types.HEAL, 
			INTERRUPT = Params.INTERRUPT_TIME,
			REFLECT = nil,
			MANUAL = false
		},		
		[10955] = { 							-- Priest: Shackle Undead
			TYPE = Types.INTERRUPT,
			INTERRUPT = Params.INTERRUPT_TIME,
			REFLECT = nil,
			MANUAL = false
		},				
		[48160] = { 							-- Priest: Vampiric Touch
			TYPE = Types.REFLECT_AND_INTERRUPT, 
			INTERRUPT = Params.INTERRUPT_TIME,
			REFLECT = Params.REFLECT_TIME,
			MANUAL = false
		},
		[42891] = { 							-- Mage: Pyroclast
			TYPE = Types.REFLECT_AND_INTERRUPT, 
			INTERRUPT = Params.INTERRUPT_TIME,
			REFLECT = Params.REFLECT_TIME,
			MANUAL = false
		},
		[42897] = { 							-- Mage: Arcane Blast
			TYPE = Types.REFLECT_AND_INTERRUPT, 
			INTERRUPT = Params.INTERRUPT_TIME,
			REFLECT = Params.REFLECT_TIME,
			MANUAL = false
		},
		[118] = { 								-- Mage: Polymorph (rank 1)
			TYPE = Types.REFLECT_AND_INTERRUPT, 
			INTERRUPT = Params.INTERRUPT_TIME,
			REFLECT = Params.REFLECT_TIME,
			MANUAL = false
		},		
		[12826] = { 							-- Mage: Polymorph (rank 4)
			TYPE = Types.REFLECT_AND_INTERRUPT, 
			INTERRUPT = Params.INTERRUPT_TIME,
			REFLECT = Params.REFLECT_TIME,
			MANUAL = false
		},
		[61305] = { 							-- Mage: Polymorph (Black Cat)
			TYPE = Types.REFLECT_AND_INTERRUPT, 
			INTERRUPT = Params.INTERRUPT_TIME,
			REFLECT = Params.REFLECT_TIME,
			MANUAL = false
		},	
		[61721] = { 							-- Mage: Polymorph (Rabbit)
			TYPE = Types.REFLECT_AND_INTERRUPT, 
			INTERRUPT = Params.INTERRUPT_TIME,
			REFLECT = Params.REFLECT_TIME,
			MANUAL = false
		},	
		[28272] = { 							-- Mage: Polymorph (Pig)
			TYPE = Types.REFLECT_AND_INTERRUPT, 
			INTERRUPT = Params.INTERRUPT_TIME,
			REFLECT = Params.REFLECT_TIME,
			MANUAL = false
		},	
		[28271] = { 							-- Mage: Polymorph (Turtle)
			TYPE = Types.REFLECT_AND_INTERRUPT, 
			INTERRUPT = Params.INTERRUPT_TIME,
			REFLECT = Params.REFLECT_TIME,
			MANUAL = false
		},	
		[61025] = { 							-- Mage: Polymorph (Serpent)
			TYPE = Types.REFLECT_AND_INTERRUPT, 
			INTERRUPT = Params.INTERRUPT_TIME,
			REFLECT = Params.REFLECT_TIME,
			MANUAL = false
		},	
		[61780] = { 							-- Mage: Polymorph (Turkey)
			TYPE = Types.REFLECT_AND_INTERRUPT, 
			INTERRUPT = Params.INTERRUPT_TIME,
			REFLECT = Params.REFLECT_TIME,
			MANUAL = false
		},		
		[48785] = { 							-- Paladin: Flash of Light
			TYPE = Types.HEAL, 
			INTERRUPT = Params.INTERRUPT_TIME,
			REFLECT = nil,
			MANUAL = false
		},					
		[48782] = { 							-- Paladin: Holy Light
			TYPE = Types.HEAL, 
			INTERRUPT = Params.INTERRUPT_TIME,
			REFLECT = nil,
			MANUAL = false
		},					
		[53308] = { 							-- Druid: Entangling Roots
			TYPE = Types.INTERRUPT,
			INTERRUPT = Params.INTERRUPT_TIME,
			REFLECT = nil,
			MANUAL = false
		},				
		[33786] = { 							-- Druid: Cyclone
			TYPE = Types.REFLECT_AND_INTERRUPT, 
			INTERRUPT = Params.INTERRUPT_TIME,
			REFLECT = Params.REFLECT_TIME,
			MANUAL = false
		},	
		[50464] = { 							-- Druid: Nourish
			TYPE = Types.HEAL, 
			INTERRUPT = Params.INTERRUPT_TIME,
			REFLECT = nil,
			MANUAL = false
		},					
		[48443] = { 							-- Druid: Regrowth
			TYPE = Types.HEAL, 
			INTERRUPT = Params.INTERRUPT_TIME,
			REFLECT = nil,
			MANUAL = false
		},					
		[48378] = { 							-- Druid: Healin Touch
			TYPE = Types.HEAL, 
			INTERRUPT = Params.INTERRUPT_TIME,
			REFLECT = nil,
			MANUAL = false
		},								
		[49273] = { 							-- Shaman: Healing Wave
			TYPE = Types.HEAL, 
			INTERRUPT = Params.INTERRUPT_TIME,
			REFLECT = nil,
			MANUAL = false
		},					
		[49276] = { 							-- Shaman: Lesser Healing Wave
			TYPE = Types.HEAL, 
			INTERRUPT = Params.INTERRUPT_TIME,
			REFLECT = nil,
			MANUAL = false
		},					
		[60043] = { 							-- Shaman: Lava Burst
			TYPE = Types.REFLECT,
			INTERRUPT = nil,
			REFLECT = Params.REFLECT_TIME,
			MANUAL = false
		},
		[51514] =  { 							-- Shaman: Hex
			TYPE = Types.REFLECT_AND_INTERRUPT,
			INTERRUPT = Params.INTERRUPT_TIME,
			REFLECT = Params.REFLECT_TIME,
			MANUAL = false
		}
	}

	
	-- Spells canalizing
	CanalizeSpells = {
		-- [52985] = {								 -- Priest: Penance (rank4)
		--	TYPE = Types.HEAL,
		--	INTERRUPT = nil,
		--	REFLECT = nil
		--},
		[47750] = {								 -- Priest: Penance (rank1)
			TYPE = Types.HEAL,
			INTERRUPT = nil,
			REFLECT = nil
		},
		[42846] = {								 -- Mage: Arcane missiles
			TYPE = Types.HEAL, -- ignored, so dont care
			INTERRUPT = nil,
			REFLECT = nil
		},
		[64901] = {								 -- Priest: Hymn of Hope
			TYPE = Types.HEAL,
			INTERRUPT = nil,
			REFLECT = nil
		},
		[64843] = {								 -- Priest: Divine Hymne
			TYPE = Types.HEAL, -- ignored, so dont care
			INTERRUPT = nil,
			REFLECT = nil
		}
	}
	
	-- Auras
	Auras = {
		DIVINE_SHIELD = 642,
		AURA_MASTERY = 31821,
		HAND_PROTECTION = 10278,
		BURNING_DETERMINATION = 54748,
		OVERPOWER_PROC = 60503,
		FAKE_DEATH = 5384,
		SCATTER = 19503,
		REPENTANCE = 20066,
		BLIND = 2094,
		HOJ = 10308,
		SEDUCTION = 6358,
		SEDUCTION2 = 6359,
		STEALTH = 1784,
		VANISH = 26889,
		SHADOWMELD = 58984,
		PROWL = 5215,
		BLADESTORM = 46924,
		SHADOW_DANCE = 51713,
		AVENGING_WRATH = 31884,
		HUNT_DISARM = 53359,
		WAR_DISARM = 676,
		ROGUE_DISARM = 51722,
		SP_DISARM = 64058,
		FEAR = 6215,
		PSYCHIC_SCREAM = 10890,
		HOWL_OF_TERROR = 17928,
		GOUGE = 1776,
		ENRAGED_REGENERATION = 55694,
		SHAMAN_NATURE_SWIFTNESS = 16188,
		DRUID_NATURE_SWIFTNESS = 17116,
		ELEMENTAL_MASTERY = 16166,
		PRESENCE_OF_MIND = 12043,
		CYCLONE = 33786,
		DETERRENCE = 19263,
		PIERCING_HOWL = 12323,
		HAND_FREEDOM = 1044,
		MASTER_CALL = 54216,
		DEEP = 44572,
		ICEBLOCK = 45438,
		HOT_STREAK = 48108,
		COILE = 47860
	}
	
	-- Stances
	Stances = {
		BATTLE = 1,
		DEFENSIVE = 2,
		BERSERKER = 3
	}
	
	-- Warn
	Warns = {
		WARNING_CAST = 
			{TEXT = " ", SOUND = "", PARTY = false},
		WARNING_HEAL =
			{TEXT = " ", SOUND = "", PARTY = false},
		WARNING_MATE =
			{TEXT = " ", SOUND = "", PARTY = false},
		WARNING_SUCUBUS =
			{TEXT = " ", SOUND = "", PARTY = false},
		WARNING_DISARM = 
			{TEXT = " ", SOUND = "", PARTY = false},
		WARNING_PROTECTED = 
			{TEXT = " ", SOUND = "", PARTY = false},
		WARNING_CD_NOT_REMAINS = 
			{TEXT = " ", SOUND = "", PARTY = false},
		WARNING_BOP =
			{TEXT = " ", SOUND = "", PARTY = false},
		WARNING_NOOB =
			{TEXT = " ", SOUND = "", PARTY = false}
	}
	
	-- Profiles: SpelL id, weapon, stances (1:battle, 2:defensive, 3:berserker)
	Spells = {
		SHIELD_BASH = {ID = 72, WEAPON = Weapons.SHIELD, 
			STANCES = {true, true, false}}, 
		PUMMEL = {ID = 6552, WEAPON = Weapons.ALL, 
			STANCES = {false, false, true}},
		THUNDER_CLAP = {ID = 47502, WEAPON = Weapons.ALL, 
			STANCES = {true, true, false}},
		REFLECT = {ID = 23920, WEAPON = Weapons.SHIELD, 
			STANCES = {true, true, false}},
		CHARGE = {ID = 11578, WEAPON = Weapons.ALL, 
			STANCES = {true, false, false}},
		INTERCEPT = {ID = 20252, WEAPON = Weapons.ALL,
			STANCES = {false, false, true}},
		OVERPOWER = {ID = 7384, WEAPON = Weapons.ALL, 
			STANCES = {true, false, false}},
		BLOODRAGE = {ID = 2687, WEAPON = Weapons.ALL, 
			STANCES = {true, true, true}},
		BERSERKER_RAGE = {ID = 18499, WEAPON = Weapons.ALL, 
			STANCES = {true, true, true}},
		INTERVENE = {ID = 3411, WEAPON = Weapons.ALL,
			STANCES = {false, true, false}},
		DEMORALIZING = {ID = 47437, WEAPON = Weapons.ALL,
			STANCES = {true, true, true}},
		DISARM = {ID = 676, WEAPON = Weapons.ALL,
			STANCES = {false, true, false}},
		BATTLE_SHOUT = {ID = 47436, WEAPON = Weapons.ALL,
			STANCES = {true, true, true}},
		COMMANDING_SHOUT = {ID = 47440, WEAPON = Weapons.ALL,
			STANCES = {true, true, true}},
		HEROIC_STRIKE = {ID = 47450, WEAPON = Weapons.ALL,
			STANCES = {true, true, true}},
		EXECUTE = {ID = 47471, WEAPON = Weapons.ALL,
			STANCES = {true, false, true}},
		MORTAL_STRIKE = {ID = 47486, WEAPON = Weapons.ALL,
			STANCES = {true, true, true}},
		BATTLE_STANCE = {ID = 2457, WEAPON = Weapons.ALL,
			STANCES = {true, true, true}},
		REND = {ID = 47465, WEAPON = Weapons.ALL,
			STANCES = {true, true, false}},
		HAMSTRING = {ID = 1715, WEAPON = Weapons.ALL,
			STANCES = {true, false, true}}
	}
	
	-- Classes
	Classes = {
		None = 0, Warrior = 1, Paladin = 2, Hunter = 3, Rogue = 4, Priest = 5,
		DeathKnight = 6, Shaman = 7, Mage = 8, Warlock = 9, Monk = 10, Druid = 11
	}
	
	-- Array cache
	overpowerArray = {Classes.Shaman, Classes.Priest, Classes.Paladin}
	rogueArray = {Classes.Rogue}
	druidArray = {Classes.Druid}
		
	-- Return true if the player is playing in Arena
	function IsArena()
		return select(1, IsActiveBattlefieldArena()) == 1
	end
	
	-- Return the current player stance
	function GetStance()
		return GetShapeshiftForm()
	end
	
	-- Return an enemy array depending on the current area of the player
	function GetEnemies()
		if IsArena() then
			return ArenaEnemies
		else
			return Enemies
		end
	end
	
	-- Return true if the player has a shield equiped
	function GetPlayerWeapon()
		if IsEquippedItemType(Params.SHIELD_TYPE_NAME) then
			return Weapons.SHIELD
		else 
			return Weapons.TWO_HANDS
		end
	end
	
	-- Return true if a given name is a party member
	function IsPartyMember(name)
		for _, unit in ipairs(Friends) do
			if UnitExists(unit) then
				local member,_ = UnitName(unit)
				if member == name then
					return true
				end
			end
		end
		return false
	end
	
	-- Return true if a given unit is targeting the player
	function IsTargettingPlayer(unit)
		realTarget = realTargets[UnitName(unit)]
		
		return realTarget ~= nil and realTarget["real"] == "done"
	end
	
	-- Return true if rotations have to be stopped for keep rage
	function Attempt()
		return prioritDisarm ~= nil
			or prioritHelp ~= nil
			or prioritInterrupt ~= nil
			or prioritReflect ~= nil
			or prioritInstant ~= nil
			or prioritHeal ~= nil
	end	
	
	-- Check priority fields for reset them
	function CheckAttempt(priority, unit)
		if priority == "prioritDisarm" 
		and prioritDisarm == UnitName(unit) then 
			prioritDisarm = nil
		elseif priority == "prioritHelp" 
		and prioritHelp == UnitName(unit) then 
			prioritHelp = nil
		elseif priority == "prioritInterrupt" 
		and prioritInterrupt == UnitName(unit) then 
			prioritInterrupt = nil
		elseif priority == "prioritReflect" 
		and prioritReflect == UnitName(unit) then 
			prioritReflect = nil
		elseif priority == "prioritInstant" 
		and prioritInstant == UnitName(unit) then 
			prioritInstant = nil
		elseif priority == "prioritHeal" 
		and prioritHeal == UnitName(unit) then 
			prioritHeal = nil
		end
	end
	
	-- Return true if a given unit is targeting a party member
	function IsTargetingParty(unit)
		targeting = false
		
		for _, member in ipairs(Friends) do
			if UnitName(unit.."target") == UnitName(member) then
				targeting = true
				break
			end
		end
		
		return targeting
	end
	
	-- Return true if a given type is checked
	function ValidUnitType(unitType, unit)
		local isEnemyUnit = UnitCanAttack(player, unit) == 1
		return (isEnemyUnit and unitType == enemy)
			or (not isEnemyUnit and unitType == friend)
	end
	
	-- Return if a given unit exists, isn't dead
	function ValidUnit(unit, unitType) 
		return UnitExists(unit)==1 and ValidUnitType(unitType, unit)
	end
	
	-- Return true if a given unit health is under a given percent
	function HealthIsUnder(unit, percent)
		return (((100 * UnitHealth(unit) / UnitHealthMax(unit))) < percent)
	end

	-- Return true if the whole party has health > x
	function HealthTeamNotUnder(percent) 	
		for _, unit in ipairs(Friends) do
			if UnitExists(unit) and HealthIsUnder(unit, percent) then
				return false	
			end
		end
	
		return true
	end
	
	-- Return true if a given unit isn't overpower protected
	function IsOverpowerProtected(unit)
		return HasAura(Auras.DIVINE_SHIELD, unit)
			or HasAura(Auras.HAND_PROTECTION, unit)
			or HasAura(Auras.CYCLONE, unit)
			or HasAura(Auras.ICEBLOCK, unit)
	end
	
	-- Return true if a given unit isn't dmg protected
	function IsDamageProtected(unit)
		return IsOverpowerProtected(unit) or HasAura(Auras.DETERRENCE, unit)
	end
	
	-- Return true if a given spell is in range
	function SpellInRange(spellProfile, unit)
		return IsSpellInRange(GetSpellInfo(spellProfile.ID), unit) == 1
	end
	
	-- Return true if an usable item is in range
	function ItemInRange(id, unit)
		return IsItemInRange("item:" .. id .. ":0:0:0:0:0:0:0:0:0:0", unit) == 1
	end
	
	-- Return true if the player can overpower
	function CanOverpower(unit)
		return not IsOverpowerProtected(unit) and select(1, IsUsableSpell(GetSpellInfo(Spells.OVERPOWER.ID))) == 1
	end
	
	-- Return true if the player can execute
	function CanExecute()
		local stance = GetStance()
		
		return (stance == Stances.BATTLE or stance == Stances.BERSERKER)
		and select(1, IsUsableSpell(GetSpellInfo(Spells.EXECUTE.ID))) == 1
	end

	-- Return true if the Cooldown of a given spell is reset (with gcd or not) 
	function CdRemains(spellId, gcd)
		if gcd == nil then gcd = true end
		local duration = select(2, GetSpellCooldown(spellId))
		
		if gcd then
			return not (duration
				+ (select(1, GetSpellCooldown(spellId)) - GetTime()) >= 0)
		else
			return 2 - duration >= 0
		end
	end

	-- Return the current player rage
	function GetRage()
		return UnitPower(player, 1)
	end
	
	-- Check if the player has enought rage for reflect/kicks..
	function CheckForRage(rage, casting)		
		local id = Spells.BLOODRAGE.ID
		local remains = CdRemains(id)
		
		if GetRage() < rage and not remains then
			return false
		elseif remains and casting then
			CastSpell(Spells.BLOODRAGE)
		end
		
		return true
	end
	
	-- Try to switch, if needed, the weapon to a given weapon
	function TrySwitchWeapon(weapon)
		if weapon == Weapons.ALL then return end
		
		local playerWeapon = GetPlayerWeapon()
		
		if (weapon == Weapons.ONE_HAND or weapon == Weapons.SHIELD) 
				and playerWeapon == Weapons.TWO_HANDS then
			ni.player.runtext("/equipslot 16 "..Weapons.ONE_HAND)
			ni.player.runtext("/equipslot 17 "..Weapons.SHIELD)
		elseif weapon == Weapons.TWO_HANDS and playerWeapon == Weapons.SHIELD then
			EquipItemByName(Weapons.TWO_HANDS)	
		end
	end
	
	-- Try to switch, if needed, the stance to a given spell profile
	function TrySwitchStanceFor(stances, weapon)
		-- Check Weapons
		TrySwitchWeapon(weapon)
	
		local id = nil
		local battle = false
		
		-- Check stances
		for index, stance in ipairs(stances) do
			if stance then
				if index == GetStance() then
					id = nil
					break
				else
					if not battle then
						id = index
					end
					if index == Stances.BATTLE then
						battle = true
					end
				end
			end
		end
		
		if id ~= nil then
			CastShapeshiftForm(id)
		end
	end
	
	-- Return true if a given star/end time is reached (in percent)
	function TimeReachTo(startTime, endTime, percent)
		time = GetTime()*1000
		return time >= (startTime + 
			(((endTime - startTime)*percent)/100.0))
		and (startTime + 
			(((endTime - startTime)*85)/100.0)) > time -- limit
	end
	
	-- Return true if has range and cd's cooldown up
	function InRangeAndCd(spellProfile, unit, gcd)
		unit = unit or player
		gcd = gcd or true
		
		return CdRemains(spellProfile.ID, gcd) and (unit == player 
				or SpellInRange(spellProfile, unit))
	end

	--[[ Return true if a given spell is casted checking (unitType), range and cooldown.
		 Note that the sight isn't checked ]]--
	function CastSpell(spellProfile, unit, gcd, a, b, reach)
		unit = unit or player
		
		local id = spellProfile.ID
		
		local rage = nil
			
		-- Check if enought rage first
		if spellProfile == Spells.REFLECT
		or spellProfile == Spells.DISARM then
			rage = 15
		elseif spellProfile == Spells.SHIELD_BASH 
		or	   spellProfile == Spells.PUMMEL
		or	   spellProfile == Spells.DEMORALIZING
		or	   spellProfile == Spells.INTERVENE
		or	   spellProfile == Spells.INTERCEPT then
			rage = 10
		end
		
		-- Do nothing if not rage
		local notRageProblem = rage == nil or CheckForRage(rage, false)
		local notReachProblem = reach == nil or TimeReachTo(a, b, reach)

		if InRangeAndCd(spellProfile, unit, gcd) then
			-- Reflect, equip shield before to be quicklest
			if not notReachProblem then
				if spellProfile == Spells.REFLECT 
						and TimeReachTo(a,b,reach-30) then
					TrySwitchWeapon(spellProfile.WEAPON)
					CheckForRage(rage, true)
				end
				return true, notReachProblem, notRageProblem
			end
			
			-- Do nothing if not rage
			if rage ~= nil and not CheckForRage(rage, true) then
				return true, notReachProblem, notRageProblem
			end
			
			-- Change the stance 
			TrySwitchStanceFor(spellProfile.STANCES, spellProfile.WEAPON)
			
			-- Cast-Interrupt
			ni.spell.cast(id, unit)
			return true, true, true
		else
			return false, notReachProblem, notRageProblem
		end
	end
	
	-- Notice fields: last saved message + timeout of 2 seconds
	lastNoticed = nil 
	timeout = 0
	
	-- Notice the player with a center red message and a sound
	function NoticePlayer(notice)
		local message = notice.TEXT
		local sound = notice.SOUND
		local party = notice.PARTY
		
		if message ~= lastNoticed or (GetTime() - timeout) > 2 then
			PlaySound(sound, "Master")
			
			if not party then
				RaidNotice_AddMessage(RaidWarningFrame, message, ChatTypeInfo["RAID_WARNING"])
			else
				SendChatMessage(message,"PARTY", GetDefaultLanguage("player"), 1)
			end
			
			lastNoticed = message
			timeout = GetTime()
		end
	end
	
	-- Return true if a given aura is present on a given unit
	function HasAura(id, unit)
		unit = unit or player
		return UnitDebuff(unit, GetSpellInfo(id)) ~= nil 
			or select(11, UnitAura(unit, GetSpellInfo(id))) == id
	end
	
	-- Return random cancel %
	function RandomPercent()
		if GetTime() - randomTime > 4 then
			randomPercent = math.random(15, 75)
			randomTime = GetTime()
													 
		end
		return randomPercent
	end
	
	-- Return true if a given unit isn't cast-cancelable
	function IsProtectedUnit(unit)
		return IsDamageProtected(unit)
			or HasAura(Auras.AURA_MASTERY, unit) 
			or HasAura(Auras.BURNING_DETERMINATION, unit)
	end
	
	-- Return true if a given the player is able to interrupt
	function CanInterrupt(unit)
		if IsProtectedUnit(unit) then
			return false
		end
		
		local stance = GetStance()
		
		return ( stance == Stances.BERSERKER 
			and CdRemains(Spells.PUMMEL.ID, false) )
			or ( (stance == Stances.BATTLE or stance == Stances.DEFENSIVE)
			and CdRemains(Spells.SHIELD_BASH.ID, false) )
	end
	
	-- In range of 25 yards
	function InRangeForNotice(unit)
		return SpellInRange(Spells.INTERCEPT, unit)
	end
	
	-- Interrupt a given unit
	function Interrupt(unit, a, b, c)
		if GetPlayerWeapon() == Weapons.TWO_HANDS then
			return CastSpell(Spells.PUMMEL, unit, true, 
					a, b, c)
		else
			return CastSpell(Spells.SHIELD_BASH, unit, true, 
					a, b, c)
		end
	end
	
	-- Return true if a given class array contains the player's class 
	function IsClassOf(unit, array)
		for _, id in ipairs(array) do
			if id == Classes[UnitClass(unit)] then
				return true
			end
		end
		return false
	end	
	
	-- Try to charge a given unit
	function ChargeUnit(unit)
		local stance = GetStance()
		local spellProfile = nil
		local charge = CdRemains(Spells.CHARGE.ID, false)
		local intercept = CdRemains(Spells.INTERCEPT.ID, false)
		local canRage = CdRemains(Spells.BLOODRAGE.ID)
		local hasRage = GetRage() >= 10
		local priority = unit == "focus"
		
		if priority then
			if intercept and stance == Stances.BERSERKER then
				if hasRage or canRage then
					spellProfile = Spells.INTERCEPT
				end
			elseif intercept and stance ~= Stances.BERSERKER then
				if hasRage or canRage then
					spellProfile = Spells.INTERCEPT
				elseif charge then
					spellProfile = Spells.CHARGE
				end
			end
		end
		
		
		if spellProfile == nil then
			if charge and stance == Stances.BATTLE then
				spellProfile = Spells.CHARGE
			elseif intercept and stance == Stances.BERSERKER then
				if hasRage or canRage then
					spellProfile = Spells.INTERCEPT
				end
			elseif charge and stance ~= Stances.BATTLE then
				spellProfile = Spells.CHARGE
			elseif intercept and stance ~= Stances.BERSERKER then
				if hasRage or canRage then
					spellProfile = Spells.INTERCEPT
				elseif charge then
					spellProfile = Spells.CHARGE
				end
			end
		end
		
		return spellProfile ~= nil and CastSpell(spellProfile, unit)
	end
	
	-- Try Mortal Strike
	function CastRotation()
		local mortal = select(7, UnitDebuff("target", GetSpellInfo(Spells.MORTAL_STRIKE.ID)))
		local rend = select(7, UnitDebuff("target", GetSpellInfo(Spells.REND.ID)))
		local hamstring = select(7, UnitDebuff("target", GetSpellInfo(Spells.HAMSTRING.ID)))
		local hasntMortal = mortal == nil or GetTime() - mortal > -2
		local canCast = (HealthIsUnder("target", 80)
								and not hasntMortal) or not HealthIsUnder("target", 80)
		
		-- Special rogue, dot first
		if canCast and (rend == nil or GetTime() - rend > -1)
		and IsClassOf("target", rogueArray)
		and not HealthIsUnder("target", 50) then
			CastSpell(Spells.REND, "target")
			return true
		end
		
		-- Fulgu = priority
		if canCast and priorityOp then return true end
		
		-- Root
		if canCast
		and not HasAura(Auras.HAND_FREEDOM, "target")
		and not HasAura(Auras.MASTER_CALL, "target")
		and not HasAura(Auras.PIERCING_HOWL, "target")
		and not IsClassOf("target", druidArray)
		and (hamstring == nil or GetTime() - hamstring > -1) then
			if GetRage() >= 10 then
				CastSpell(Spells.HAMSTRING, "target")
				return true
			end
			
		-- Dot
		elseif canCast and (rend == nil or GetTime() - rend > -1) then 
			if GetRage() >= 10 then
				CastSpell(Spells.REND, "target")
				return true
			end
		
		-- Reduce heal
		elseif CdRemains(Spells.MORTAL_STRIKE.ID)
		and hasntMortal then
			if GetRage() >= 30 then
				CastSpell(Spells.MORTAL_STRIKE, "target")
			end
			return true
		end
		return false
	end
end

if not LISTENERS then LISTENERS = true
	-- Listen auras of a given unit
	function ListenAuras(unit)
		if not ValidUnit(unit, enemy) then return end
	
		-- Check for spot rogue
		if HasAura(Auras.VANISH, unit)
		or HasAura(Auras.STEALTH, unit)
		or HasAura(Auras.PROWL, unit)
		or HasAura(Auras.SHADOWMELD, unit) then
			if ItemInRange(30651, unit) then -- 15 Yards item
				CastSpell(Spells.DEMORALIZING)
			else
				ChargeUnit(unit)
			end
		end
		
		-- Check for interrupt succubus
		if succubus ~= nil and unit == "focus" then
			if not CanInterrupt(unit) or not Interrupt(unit) then
				ChargeUnit(unit)
			end
		end
		
		-- Check for disarm
		if (not HasAura(Auras.WAR_DISARM)
		and not HasAura(Auras.ROGUE_DISARM)
		and not HasAura(Auras.HUNT_DISARM)
		and not HasAura(Auras.SP_DISARM))
		and (HasAura(Auras.BLADESTORM, unit)
		or HasAura(Auras.AVENGING_WRATH, unit)
		or HasAura(Auras.SHADOW_DANCE, unit))
		and UnitPowerMax(unit , 0) < 10000 then -- checks if hpal
			local cdAndRange, reach, rage = CastSpell(Spells.DISARM, unit)
			
			if CdRemains(Spells.DISARM.ID) then
				NoticePlayer(Warns.WARNING_DISARM)
			end
			
			if not CheckForRage(55, false) and cdAndRange then
				prioritDisarm = UnitName(unit)
			elseif not cdAndRange then
				CheckAttempt("prioritDisarm", unit)
			end
			
			if not SpellInRange(Spells.DISARM, unit) then
				CastSpell(Spells.INTERVENE, "party1")
			end
		else
			CheckAttempt("prioritDisarm", unit)
		end
		
		-- Reflect if instant aura and targeting player
		if UnitName(unit.."target") == UnitName(player) and (
		HasAura(Auras.SHAMAN_NATURE_SWIFTNESS, unit)
		or HasAura(Auras.HOT_STREAK, unit)
		or HasAura(Auras.DRUID_NATURE_SWIFTNESS, unit)
		or HasAura(Auras.ELEMENTAL_MASTERY, unit)
		or HasAura(Auras.PRESENCE_OF_MIND, unit)) then
			local cdAndRange, reach, rage = CastSpell(Spells.REFLECT)
			
			if not CheckForRage(60, false) and cdAndRange then
				prioritInstant = UnitName(unit)
			elseif HasAura(Spells.REFLECT.ID) then
				CheckAttempt("prioritInstant", unit)
			end
		else 
			CheckAttempt("prioritInstant", unit)
		end
	end
	
	-- Return casting infos
	function GetCastingInfos(unit)
		local spell, _, _, _, a, b, _, _, _ = UnitCastingInfo(unit)
		local id = nil
		local spellType = nil
		local interruptTime = 0
		local reflectTime = 0
		local manual = false
		
		
		if spell ~= nil then
			if CanOverpower(unit) then
				CastSpell(Spells.OVERPOWER, unit)
			end
			
			for k,v in pairs(EnemySpells) do
				if GetSpellInfo(k) == spell then
					id = k
					spellType = v.TYPE
					interruptTime = v.INTERRUPT
					reflectTime = v.REFLECT
					manual = v.MANUAL
					break
				end
			end
		end
		
		return id, a, b, spellType, interruptTime, reflectTime, manual
	end
	
	-- Listen canalized spells for cancel/overpower
	function ListenHealingSpells(unit, a, b, interruptTime)
		local kick = false
		
		-- Check for kick
		for _, enmy in ipairs(GetEnemies()) do
			if HealthIsUnder(enmy, Params.HEALTH_FOR_INTERRUPT)	then
				kick = true
				break
			end
		end
		
		if Params.ENABLE_RANDOM_INTERRUPT
		and interruptTime == Params.INTERRUPT_TIME then
			interruptTime = RandomPercent()
		end
		
		if kick and CanInterrupt(unit) then 
			local rangeAndCd, reach, rage = Interrupt(unit, a, b, interruptTime)
			
			if not CheckForRage(60, false) and rangeAndCd then
				prioritHeal = UnitName(unit)
			elseif not rangeAndCd then
				CheckAttempt("prioritHeal", unit)
			end
		end
	end
	
	-- Listen casts of a given unit
	function ListenCasts(unit, id, a, b, spellType, interruptTime, reflectTime, event, manual)
		if id ~= nil and spellType ~= nil then
			local manual_defense = Params.MANUAL_DEFENSE
			
			-- Check for manual
			if manual and manual_defense then
				if spellType == Types.REFLECT then
					if GetPlayerWeapon() == Weapons.TWO_HANDS then
						return
					end
				elseif spellType == Types.INTERRUPT then
					if GetStance() ~= Stances.BERSERKER
					or GetPlayerWeapon() == Weapons.TWO_HANDS then
						return
					end
				elseif spellType == Types.REFLECT_AND_INTERRUPT then
					if not CdRemains(Spells.REFLECT) then
						if GetStance() ~= Stances.BERSERKER
						or GetPlayerWeapon() == Weapons.TWO_HANDS then
							return
						end
					else
						if GetPlayerWeapon() == Weapons.TWO_HANDS then
							return
						end
					end
				end
			end
			
			if spellType ~= Types.HEAL then
				if not event or (event and InRangeForNotice(unit)) then
					NoticePlayer(Warns.WARNING_CAST)
				end
				
				local reflect = spellType == Types.REFLECT
				local interrupt = spellType == Types.INTERRUPT
				local interruptAndReflect = spellType == Types.REFLECT_AND_INTERRUPT
				
				-- No waiting time
				if ((reflect or interruptAndReflect) and reflectTime == nil)
				or ((interrupt or interruptAndReflect) and interruptTime == nil) then
					a = nil
					b = nil
				end
				
				-- If reflectable, cast if cd remains
				if IsTargettingPlayer(unit) 
						and (reflect or interruptAndReflect) then 
					local profile = Spells.REFLECT
					local rangeAndCd, reach, rage = 
					CastSpell(profile, player, false, a, b, reflectTime)
					
					if not CheckForRage(60, false) and rangeAndCd then
						prioritReflect = UnitName(unit)
					elseif HasAura(Spells.REFLECT.ID) then
						CheckAttempt("prioritReflect", unit)
					end
					
					if rangeAndCd or HasAura(profile.ID) 
						then return end
				end
				
				-- If random cancel enabled, then change default values
				if Params.ENABLE_RANDOM_INTERRUPT
				and interruptTime == Params.INTERRUPT_TIME then
					interruptTime = RandomPercent()
				end
				
				if IsTargetingParty(unit) and not reflect and CanInterrupt(unit) then 
					local rangeAndCd, reach, rage = Interrupt(unit, a, b, interruptTime)
					
					if not CheckForRage(60, false) and rangeAndCd then
						prioritInterrupt = UnitName(unit)
					elseif not rangeAndCd then
						CheckAttempt("prioritInterrupt", unit)
					end
					
					-- If cant reflect, interrupt if cd remains
					if rangeAndCd then return end
				end
				
				if succubus and id == Auras.SEDUCTION
					or id == Auras.SEDUCTION2 then
					ChargeUnit(unit)
				end
			-- If heal spell
			else 
				if not event or (event and InRangeForNotice(unit)) then
					NoticePlayer(Warns.WARNING_HEAL)
				end
				
				ListenHealingSpells(unit, a, b, interruptTime)
			end
		else
			CheckAttempt("prioritReflect", unit)
			CheckAttempt("prioritInterrupt", unit)
			
			if spellType == Types.HEAL then
				CheckAttempt("prioritHeal", unit)
			end
		end
	end
end

-- Check enemies
for _, unit in ipairs(GetEnemies()) do
	if ValidUnit(unit, enemy) then
		ListenAuras(unit)
		
		local id, a, b, spellType, interruptTime, reflectTime, manual = GetCastingInfos(unit)
		local spellNames, _, _, _, _, endCasts, _, protecteds, _ = UnitChannelInfo(unit)
		
		if id ~= nil or spellNames ~= nil then
			if CanOverpower(unit) then
				CastSpell(Spells.OVERPOWER, unit)
			end
		end
		
		if spellNames ~= nil then
			for u,v in pairs(CanalizeSpells) do
				if GetSpellInfo(u) == spellNames then
					if not CanInterrupt(unit)
					or not Interrupt(unit) then
						NoticePlayer(Warns.WARNING_CD_NOT_REMAINS)
					end
				end
			end
		end
		
		if (id == nil) then
			local named  = UnitName(unit)
	
			if realTargets[named] ~= nil then
				realTargets[named] = nil
			end
		end
		
		ListenCasts(unit, id, a, b, spellType, interruptTime, reflectTime, false, manual)
		
		if select(1, UnitName(unit)) == canalizer and
				canalized - GetTime() > 0 then
			ListenHealingSpells(unit)
		else
			CheckAttempt("prioritHeal", unit)
		end
	end
end

-- Define frames
if not FRAMES then FRAMES = true
	-- FakeDeath fields
	mytar = nil
	dead = nil
	interveneTimeout = 0
	
	
	local fightLogFrame = CreateFrame("FRAME", nil, UIParent)
	fightLogFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	fightLogFrame:SetScript("OnEvent", 
		function(self, event, _, type,  sourceGUID, sourceNAME, _, 
					destGUID, destNAME, _, spellID)
			
			-- Fake death hunt check
			if type == "UNIT_DIED" and destNAME == mytar then
				dead = destNAME
				
			if spellID == Spells.BATTLE_STANCE.ID 
				and (type == "SPELL_AURA_APPLIED"
					or type == "SPELL_CAST_SUCCESS") then
					swapBattle = false
			end
				
			-- Sucube create unit for check
			elseif type == "SPELL_AURA_APPLIED"
					and spellID == Auras.SEDUCTION
					and IsPartyMember(destNAME) then
				local last = UnitName("target")
				
				ni.player.runtext("/cast Overpower ")
				ni.player.runtext("/focus")
				ni.player.runtext("/cast Overpower ")
			
			-- Auto reswap battle stance
			elseif sourceNAME == select(1, UnitName(player)) then
				local success = type == "SPELL_CAST_SUCCESS"
				
				if spellID == Spells.SHIELD_BASH.ID
				and success then
					commandString = nil
				elseif spellID == Spells.INTERVENE.ID then
					interveneTimeout = 0
				elseif spellID == Spells.CHARGE.ID
				and success then
					commandString = nil
				elseif (spellID == Spells.PUMMEL.ID 
				or spellID == Spells.INTERCEPT.ID) and success then
					swapBattle = true
					if success then
						commandString = nil
					end
				elseif spellID == Spells.BATTLE_STANCE.ID 
				and type == "SPELL_AURA_APPLIED" then
					swapBattle = false
				elseif spellID == Spells.REFLECT.ID then
					if type == "SPELL_AURA_REMOVED" then
						swapWeapon = true
					elseif success then
						commandString = nil
					end
				end
			
			elseif not IsArena() and type == "SPELL_CAST_START" 
			and Params.CHECK_EVERYWHERE then
				local last = nil
				
				if UnitExists("target")then
					last = select(1, UnitName("target"))
				else
					last = "none"
				end
				
				ni.player.runtext("/cast Overpower ")
				
				if UnitExists("target") then
					ni.player.runtext("/focus")
				end
				
				if last ~= "none" then
					ni.player.runtext("/cast Overpower ")
				end
				
				if not ValidUnit("focus", enemy)
				or not IsTargetingParty("focus") then
					return
				end
				
				-- Looking for find the spell id
				local value = EnemySpells[spellID]
				
				if value ~= nil then
					local _, _, _, _, a, b, _, _, _ = UnitCastingInfo("focus")

					local spellType = value.TYPE
					local interruptTime = value.INTERRUPT
					local reflectTime = value.REFLECT
					local manual = value.MANUAL
					ListenCasts("focus", spellID, a, b, 
								spellType, interruptTime, reflectTime, true, manual)
				end
			end
		end
	)
	
	-- Parse a recevied command (/lua are listened)
	function ParseCommand(command)
		if string.match(command, "/test") == nil then return end
		local action = string.gsub(command, "/test ", "")
		
		if string.find(action, "charge") ~= nil then
			local unit = string.gsub(action, "charge ", "")
			if not IsDamageProtected(unit) then  
				CastRotation()
				ChargeUnit(unit)
				
				if not (commandTimeout - GetTime() >= -Params.CHARGE_FORCE_TIME) then 
					commandTimeout = GetTime()
					commandString = command
				end
			else
				NoticePlayer(Warns.WARNING_PROTECTED)
			end
		elseif string.find(action, "interrupt") ~= nil then
			local unit = string.gsub(action, "interrupt ", "")
			if not IsProtectedUnit(unit) then
				if not CanInterrupt(unit)
				or not Interrupt(unit) then
					NoticePlayer(Warns.WARNING_CD_NOT_REMAINS)
				end
					
				
				if not (commandTimeout - GetTime() >= -0.5) then 
					commandTimeout = GetTime()
					commandString = command
				end
			else
				NoticePlayer(Warns.WARNING_PROTECTED)
			end
		elseif string.find(action, "reflect") ~= nil then
			if not CastSpell(Spells.REFLECT) then
				NoticePlayer(Warns.WARNING_CD_NOT_REMAINS)
			end
			
			if not (commandTimeout - GetTime() >= -0.5) then 
				commandTimeout = GetTime()
				commandString = command
			end
		elseif string.find(action, "rotation") ~= nil then
			CastRotation()
		elseif string.find(action, "disarm") ~= nil then
			local unit = "target"
			local class = select(1, UnitClass(unit))
			
			if (class == "Paladin" and (-(UnitMana(unit))) > -8000) or
			class == "Priest" or
			(class == "Shaman" and not HasAura(30809, unit)) or
			class == "Mage" or
			class == "Druid" or class == "Warlock" then
				NoticePlayer(Warns.WARNING_NOOB)
			else
				CastSpell(Spells.DISARM, unit)
			end
		end
	end
	
	-- Checking macro commands
	local commandFrame = CreateFrame("FRAME", nil, UIParent)
	commandFrame:RegisterEvent("EXECUTE_CHAT_LINE")
	commandFrame:SetScript("OnEvent", 
		function(self, event, ...)
			ParseCommand(arg1)
		end
	)
end

-- Force for commands
if commandTimeout - GetTime() >= -Params.CHARGE_FORCE_TIME and commandString ~= nil then
	ParseCommand(commandString)
end

-- Force for intervene
if interveneTimeout - GetTime() >= -0.5 then
	local spell = Spells.INTERVENE
	local done = false
	
	if not UnitExists("party1") 
	and InRangeAndCd(spell, "party1") then
		CastSpell(spell, "party1")
		done = true
	elseif not UnitExists("party1") 
	and InRangeAndCd(spell, "party1") then
		CastSpell(spell, "party1")
		done = true
	end
	
	if done then 
		-- Protection stance
		TrySwitchStanceFor({false, true, false})
		-- Reflect if possible
		CastSpell(Spells.REFLECT)
	end
end

-- Fake Death bypass
if UnitExists("target") then
	name, _ = UnitName("target")
	mytar = name
end

-- Fake Death bypass
if dead ~= nil then
	ni.player.runtext("/target " .. dead)
	
	if UnitExists("target") then
		local name, _ = UnitName("target")
		if name == dead then
			if not ni.unit.buff("target", 5384)
				then ClearTarget()
			end
		end
		dead = nil
	end
end

-- Check for auto-overpower
if ValidUnit("target", enemy) then
	if CanOverpower("target") then
		local endTime = 
			select(7, UnitAura(player, GetSpellInfo(Auras.OVERPOWER_PROC)))
		
		if not IsClassOf("target", overpowerArray) 
		or (endTime ~=nil and GetTime() - endTime > -5)
			   or not HasAura(Auras.OVERPOWER_PROC) then
			
			priorityOp = true
			CastSpell(Spells.OVERPOWER, "target")
		else
			priorityOp = false
		end
	else
		priorityOp = false
	end
end

-- Check for party
for _, unit in ipairs(Friends) do
	if ValidUnit(unit, friend) and unit ~= player then
		name,_ = UnitName(unit)
		
		-- Intervene on scatter
		if HasAura(Auras.SCATTER, unit) then
			NoticePlayer(Warns.WARNING_MATE)
			local cdAndRange, reach, rage = CastSpell(Spells.INTERVENE, unit)
			
			if not CheckForRage(55, false) and cdAndRange then
				prioritHelp = UnitName(unit)
			elseif not cdRandRange or HasAura(Spells.INTERVENE.ID) then
				CheckAttempt("prioritHelp", unit)
			end
		
		-- removed Notice when mate is under seduction
		--elseif HasAura(Auras.SEDUCTION, unit) then
		--	NoticePlayer(Warns.WARNING_SUCUBUS)
		--	succubus = name
		--elseif succubus == name then
		--	succubus = nil
		else
			CheckAttempt("prioritHelp", unit)
		end
	end
end

-- Check for tremor break
if ValidUnit("mouseover", enemy) 
		and UnitName("mouseover") == "Tremor Totem" then
	ni.spell.cast(2764, "mouseover") -- Throw
end

-- Notice party if the player is disarmed
if HasAura(Auras.ROGUE_DISARM)
or HasAura(Auras.SP_DISARM)
or HasAura(Auras.WAR_DISARM) then
	if (UnitExists("party1") 
	and IsClassOf("party1", {Classes.Paladin}))
	or (UnitExists("party2") 
	and IsClassOf("party2", {Classes.Paladin})) then
		NoticePlayer(Warns.WARNING_BOP)
	end
-- CancelAura on BOP
elseif HasAura(Auras.HAND_PROTECTION) then
	ni.player.runtext("/cancelaura "..GetSpellInfo(Auras.HAND_PROTECTION))
end

-- Assist DPS
if ValidUnit("target", enemy) then
	if not Attempt() then
		if not IsDamageProtected("target") then 
			if GetRage() > 60 then
				CastSpell(Spells.HEROIC_STRIKE, "target")
			end
		end
	end
end

-- THUNDER
if HasAura(34655, "player") then
	CastSpell(Spells.THUNDER_CLAP)
end

-- Autoswap weapon and battle stance
if swapBattle then
	TrySwitchStanceFor({true, false, false}, Weapons.ALL)
elseif swapWeapon then
	if not HealthIsUnder(player, 60) and GetPlayerWeapon() ~= Weapons.TWO_HANDS then
		TrySwitchWeapon(Weapons.TWO_HANDS)
	elseif GetPlayerWeapon() == Weapons.TWO_HANDS then
		swapWeapon = false
	end
end
			end
			return false
		end,
		execution = function()
		end,
	},
	[4] = {
		condition = function()
			if (UnitChannelInfo('player') ~= nil and false) or (UnitChannelInfo('player') == nil) then
				if not FuncLoaded then
	FuncLoaded = true
	
	function BurstModeText()
		if AutoBurstMode then
			return "|cffFFBE69BurstMode: |cFF00FF00Enabled"
		else
			return "|cffFFBE69BurstMode: |cffb73737Disabled" 
		end
	end	



	function IsTwoHanderEquiped()
		if IsEquippedItem(TwoHander) then
			return true
		end
	end

	function IsOneHandAndShieldEquiped()
		if IsEquippedItem(OneHander) 
		and IsEquippedItem(Shield) then
			return true
		end
	end

	function EquipTwoHander()
		EquipItemByName(TwoHander)
		return
	end

	function EquipOneHandAndShield()
		EquipItemByName(OneHander)
		EquipItemByName(Shield)
		return
	end	

	function StringSplicer(s,sep)
	  sep=sep or","
	  local table={}
	  local i=1;
	  for s in string.gmatch(s,"([^"..sep.."!%s]+)")do 
	    table[i]=s;
	    i=i+1 
	  end 
	  return table 
	end 
	

	function DebugPrint(s)
		if debug then
			print(s)
		end
	end
	
	function CalculateHP(t)
		local ActualWithIncoming = 100 * UnitHealth(t) / UnitHealthMax(t)
		if ActualWithIncoming then
			return ActualWithIncoming
		else
			return 100
		end
	end
		
	function CanHeal(t)
		if not UnitIsCharmed(t) 
		and not UnitIsDeadOrGhost(t) 
		and not ni.unit.debuff(t, 33786) then --Clone
			return true 
		end 
	end

	--New Healing Engine
	function SheuronEngine(MO, TARGETHEAL, LOWHP, HEALPET)
		local MouseoverCheck = MO or false
		local LowHPTarget = LOWHP or 80
		local TargetHealCheck = TARGETHEAL or false
		local HEALPET = HEALPET or true
		lowhpmembers = 0
		
		playerHP = CalculateHP("player")
			
		members = { { 	
			Unit = "player", 
			HP = playerHP, 
			GUID = UnitGUID("player"), 
			IsPlayer = true, 
			} } 
			
		--Adding player to low hp table
		if playerHP < LowHPTarget then
			lowhpmembers = lowhpmembers + 1
		end	
			
			
		local group = "party"
		local groupmembers = GetNumPartyMembers()

		if GetNumRaidMembers() > 0 then
			group = "raid"
			groupmembers = GetNumRaidMembers()
		end
				
		for i = 1, groupmembers do 
			local member, memberhp, uidmember = group..i, CalculateHP(group..i), UnitGUID(group..i)	
			-- Checking all Party/Raid Members for Range/Health
			if ((UnitExists(member) and CanHeal(member)) or UnitIsUnit("player",member))
			and member ~= nil and memberhp ~= nil and uidmember ~= nil then 	
				table.insert( members,{ Unit = member, HP = memberhp, GUID = uidmember, IsPlayer = true } ) 
					
				-- Setting Low HP Members variable for AoE Healing
				if memberhp < LowHPTarget then
					lowhpmembers = lowhpmembers + 1
				end	
			end 
				
			-- Checking Pets in the group
			if HEALPET and lowhpmembers == 0 and UnitExists(group..i.."pet") and CanHeal(group..i.."pet") then
				local memberpet, memberpethp,  uidmemberpet = nil, nil, nil
				memberpet = group..i.."pet" 
				memberpethp = CalculateHP(memberpet)		
				uidmemberpet = UnitGUID(memberpet)
						
				if memberpet ~= nil and memberpethp ~= nil and uidmemberpet ~= nil then
					table.insert(members, { Unit = memberpet, HP = memberpethp, GUID = uidmemberpet, IsPlayer = false } )
				end			
			end
		end

		-- Checking Priority Targeting
		if TargetHealCheck and CanHeal("target") then
			table.sort(members, function(x) return UnitIsUnit("target",x.Unit) end)
		elseif MouseoverCheck and CanHeal("mouseover") and GetMouseFocus() ~= WorldFrame then
			table.sort(members, function(x) return UnitIsUnit("mouseover",x.Unit) end)
		end
	end

	--CastSpell--
	function _castSpell(spellid,tar)
		if UnitCastingInfo("player") == nil
		and UnitChannelInfo("player") == nil
		--and IsPlayerSpell(spellid) == true
		and cdRemains(spellid) == 0
		then
			if tar ~= nil
			and rangeCheck(spellid,tar) == nil
				then
				return false
			elseif tar ~= nil
			and rangeCheck(spellid,tar) == true
				then
				ni.spell.cast(spellid, tar)
				return true
			elseif tar == nil
				then
				ni.spell.cast(spellid)
				return true
			else
		return false
		end
	end
	end
	
	--Combat Check--
	function inCombat()
	if UnitAffectingCombat("player") ~= nil
		then
			return true
		end
	end
	
	--Get HP simple--
	function getHp(unit)
	if UnitExists(unit) ~= nil
		then
			return 100 * UnitHealth(unit) / UnitHealthMax(unit)
		end
	end
	
	--Range Check Simple--
	function rangeCheck(spellid,unit)
	if IsSpellInRange(GetSpellInfo(spellid),unit) == 1
	then
		return true
	end
	end
	
	
--Amount of Cooldown that remains--
function cdRemains(spellid)
	if select(2,GetSpellCooldown(spellid)) + (select(1,GetSpellCooldown(spellid)) - GetTime()) > 0
		then return select(2,GetSpellCooldown(spellid)) + (select(1,GetSpellCooldown(spellid)) - GetTime())
	else return 0
	end
end


function inMelee()
	if UnitAffectingCombat("player") ~= nil
	and IsSpellInRange(GetSpellInfo(47450),"target") == 1
	and UnitExists("target") ~= nil
	and UnitCanAttack("player","target") ~= nil
	then return true
	end
end

	 --Function Check Snares--
	local PvPslows 			= {
		45524,			-- Chains of Ice
		50435,			-- Chilblains
		50259,			-- Dazed 
		58180,			-- Infected Wounds
		5116,			-- Concussive Shot
		120,				-- Cone of Cold
		116,				-- Frostbolt
		44614,			-- Frostfire Bolt
		3409,			-- Crippling Poison
		8056,			-- Frost Shock
		51490,			-- Thunderstorm
		1715,			-- Hamstring
		1604,			-- Dazed 
		12323,          -- Piercing Howl
					}
	function isSlowed(unit)
	for i=1,#PvPslows do
		if ni.unit.debuff(unit,PvPslows[i]) ~= nil
			then
				return true
			end
		end
	end
--End for FuncLoad
end
			end
			return false
		end,
		execution = function()
		end,
	},
	[5] = {
		condition = function()
			if (UnitChannelInfo('player') ~= nil and false) or (UnitChannelInfo('player') == nil) then
				rage = UnitPower("player")
debug = false

--This makes the Bot Determine when to burst
AutoBurstMode = true

function CastClick()
  if IsMouseButtonDown(1) and MainMenuBar:IsShown() then 

    return true 
  end
end

--OPTIONS
-- Opcions START
InteruptSpell = 72 -- Azorte de escudo
ReflectSpell = 23920 -- Reflejo de hechizos
ReflectDelay = .3	-- Tiempo antes de que acabe de castear para tirar reflect
InteruptDelay = 0.1   -- Tiempo antes de que acabe de castear para cortar
InteruptTarget = {	"focus",
		"arena1",
		"arena2",
		"arena3",
		"arenapet1",
		"arenapet2",
		"arenapet3",	-- Objetivos a los que queremos reflectar y cortar
		"target"
}

InterveneTarget = {	"party1",
		"party3",	-- Objetivos a los que queremos intervenir
		"party2"
}
--OPTIONS

OneHander = "Relentless Gladiator's Shield Wall"
Shield = "Relentless Gladiator's Cleaver"
TwoHander = "Relentless Gladiator's Decapitator"

--Do not edit below here



if OneHander == nil
or Shield == nil
or TwoHander == nil then
print("www.snpexploits.com")

print("www.snpexploits.com")
end
			end
			return false
		end,
		execution = function()
		end,
	},
	[6] = {
		condition = function()
			if (UnitChannelInfo('player') ~= nil and false) or (UnitChannelInfo('player') == nil) then
				-- Actitud actual
local DS = GetShapeshiftForm()

if not frame then
	-- Create our frame and bind combat log events
	 frame = CreateFrame("Frame", nil, UIParent)
	print("SNPExploits FrameWork Loaded")
end
 
-- Spell event table
spellIds = {

	[47860] = {"Spell Reflection"},
	[10308] = {"Spell Reflection"},
	[44572] = {"Spell Reflection"}, --deep freeze
	[44549] = {"Spell Reflection"}, --mind freeze
	[57761] = {"Spell Reflection"}, --mind freeze
	[44572] = {"Spell Reflection"},
	[6215] = {"Spell Reflection"},
	[12826] = {"Spell Reflection"},
	[51514] = {"Spell Reflection"},
	[2094] = {"Bladestorm"},--blind
	[20066] = {"Bladestorm"},--Repetance
	[10308] = {"Bladestorm"},--hjusticeFinal
	[853] = {"Bladestorm"},--hjustice
	[6789] = {"Bladestorm"},--Deadcoil1
	[47860] = {"Bladestorm"},--Deadcoil6
	[8643] = {"Bladestorm"},--Kidney
	[20252] = {"Bladestorm"}--Intercept

}
  frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
  frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
  frame:SetScript("OnEvent", EventHandler)

-- Create our event handler function
function EventHandler(self, event, ...)
 	-- No refleja si ya tiene activado el reflejo de escudo -- DIABLED

	 if event == "COMBAT_LOG_EVENT_UNFILTERED" then
 		local type,  sourceGUID, sourceNAME, _, destGUID, destNAME, _, sid = select(2, ...)
 		if type == "SPELL_CAST_SUCCESS"
  		and sourceGUID == UnitGUID("target") or sourceGUID == UnitGUID("focus")  then
  			-- print("www.snpexploits.com")
   			local sid = select(9, ...)
   			local sname = spellIds[sid]
   			if sname ~= nil then
    				for _,v in ipairs(sname) do
    				print("casting"..v)
     				ni.spell.cast(v)           
				return end
   			end
		end
    	 end
end
			end
			return false
		end,
		execution = function()
		end,
	},
	[7] = {
		condition = function()
			if (UnitChannelInfo('player') ~= nil and false) or (UnitChannelInfo('player') == nil) then
				if not cTar
then
	cTar = {"target","focus","mouseover","arena1","arena2","arena3","arena4","arena5","arenapet1","arenapet2","arenapet3","arenapet4","arenapet5","pettarget"}
end


local InterruptSpells = {	 
						         12826,		-- Polymorph
						12824,		-- Polymorph
						12825,		-- Polymorph
						118,		-- Polymorph
						61305,		-- Polymorph: Black Cat
						28272,		-- Polymorph: Pig
						61721,		-- Polymorph: Rabbit
						61780,		-- Polymorph: Turkey
						28271,		-- Polymorph: Turtle
59172, --Chaos Bolt
51514, --Hex
60043, --Lava burst
33786, --Cyclone
48160, --Vampiric Touch
47843,  --Unstable Affliction
53308, --roots
48465, --starfire
					}

if ni.spell.available(23920) and rage>=14 and (GetShapeshiftForm() == 1 or  GetShapeshiftForm() == 2)  and not PQR_IsOutOfSight(cTar[i]) then
	for i=1, #cTar do
		if UnitExists(cTar[i]) then
		local spellName, _, _, _, _, endCast, _, _, canInterrupt = UnitCastingInfo(cTar[i])
			for _, v in ipairs(InterruptSpells) do
				if GetSpellInfo(v) == spellName  then
					if ((endCast/1000) - GetTime()) < 0.33  then
								ni.spell.cast(23920)
					end
				end
			end
		end
	end
end
			end
			return false
		end,
		execution = function()
		end,
	},
	[8] = {
		condition = function()
			if (UnitChannelInfo('player') ~= nil and false) or (UnitChannelInfo('player') == nil) then
				local cd = GetSpellCooldown(871)
local unithealth = 100 * UnitHealth("player") / UnitHealthMax("player")

if actitud == 1 then
if cdRemains(72) ~= 0 and unithealth > 60 then
if not IsTwoHanderEquiped() then
	EquipTwoHander()
		end
ni.player.runtext("/equip Relentless Gladiator's Decapitator")
	end
end

if actitud == 1 then
if not ni.unit.buff("player", 23920) and unithealth > 60 then
if not IsTwoHanderEquiped() then
	EquipTwoHander()
		end
ni.player.runtext("/equip Relentless Gladiator's Decapitator")
	end
end

if actitud == 2
and unithealth < 50 then
_castSpell(55694)
	return true
end
if actitud == 2
and unithealth < 20
and cd == 0 then 
_castSpell(871)
	return true
end


if actitud == 2
and rage >= 5  then
--Revenge
if cdRemains(57823) == 0
and IsUsableSpell("Revenge") then
	_castSpell(57823,"target")
	return true
end
end
			end
			return false
		end,
		execution = function()
		end,
	},
	[9] = {
		condition = function()
			if (UnitChannelInfo('player') ~= nil and false) or (UnitChannelInfo('player') == nil) then
				local op, _, _, _, _, _, optimer = ni.unit.buff("player", 60503)
local playerhp = 100 * UnitHealth("player") / UnitHealthMax("player")
if inMelee() and op
and cdRemains(7384) == 0 
and ni.unit.buff("player",60503)  
and rage >= 10  then
	
	if optimer - GetTime() <= 5
                  and not opCount
                  then
if not ni.unit.buff("player", 23920) and playerhp > 50 then
ni.player.runtext("/cast Overpower")
end
                  ni.spell.cast("7384","target")
                  opCount = 1
--opCount = nil
                  end
                  
                  if opCount == 1
	and cdRemains(7384) == 0 
	and ni.unit.buff("player",60503)  
                  then
ni.player.runtext("/cast Battle Stance")
ni.player.runtext("/cast Overpower")
	_castSpell(7384,"target")
                  opCount = nil
	end
end
			end
			return false
		end,
		execution = function()
		end,
	},
	[10] = {
		condition = function()
			if (UnitChannelInfo('player') ~= nil and false) or (UnitChannelInfo('player') == nil) then
				if inMelee()
and cdRemains(1715) == 0 
and not isSlowed("target")
and not ni.unit.buff("target", 1044) 
and rage >= 7 then
	_castSpell(1715,"target")
	return true
end
			end
			return false
		end,
		execution = function()
		end,
	},
	[11] = {
		condition = function()
			if (UnitChannelInfo('player') ~= nil and false) or (UnitChannelInfo('player') == nil) then
				if inMelee()
and cdRemains(47465) == 0 
and not ni.unit.debuff("focus", 47465) 
and rage >= 10 then
	_castSpell(47465,"focus")
end
if inMelee()
and cdRemains(47465) == 0 
and not ni.unit.debuff("target", 47465) 
and rage >= 10 then
	_castSpell(47465,"target")
	return true
end
			end
			return false
		end,
		execution = function()
		end,
	},
	[12] = {
		condition = function()
			if (UnitChannelInfo('player') ~= nil and false) or (UnitChannelInfo('player') == nil) then
				if inMelee() and not StopRota
and cdRemains(47486) == 0 
and rage >= 30  then
	_castSpell(47486,"target")
	return true

end
			end
			return false
		end,
		execution = function()
		end,
	},
	[13] = {
		condition = function()
			if (UnitChannelInfo('player') ~= nil and false) or (UnitChannelInfo('player') == nil) then
				local unithealth = 100 * UnitHealth("target") / UnitHealthMax("target")
if not actitud == 2 and not StopRota
and AutoBurstMode then
	BladeStormCD = cdRemains(46924)
	SweepingStrikesCD = cdRemains(12328)
	ReckCD = cdRemains(1719)
	
	if not Def()
	and BladeStormCD == 0 
	and SweepingStrikesCD == 0 
	and isSlowed("target") 
	and inMelee() 
	and ni.unit.buff("player", 57522) --Enrage
	then 
	
		--Pooling
		if rage < 55 then
			_castSpell(2687)
			return true
		end
		
		--Going ham
		if unithealth < 50
		and ni.unit.debuff("target", 47465)--rend
		and ni.unit.debuff("target", 47486)--mortal
		and isSlowed("target") then
			if not IsTwoHanderEquiped() then
				EquipTwoHander()
			end
			_castSpell(46924)
		end
	end
end
			end
			return false
		end,
		execution = function()
		end,
	},
	[14] = {
		condition = function()
			if (UnitChannelInfo('player') ~= nil and false) or (UnitChannelInfo('player') == nil) then
				local DS = GetShapeshiftForm()
for i=1, #InterveneTarget do
	local aQuienIntervene = InterveneTarget[i]
	if UnitExists(aQuienIntervene) ~= nil
	and ni.unit.debuff(aQuienIntervene,19503) ~= nil 
	and IsSpellInRange(GetSpellInfo(3411), aQuienIntervene) == 1 then
		if DS == 1 or DS == 3 then
			ni.spell.cast(71,"player")
		end
		ni.spell.cast(3411, aQuienIntervene)
	end
end

if rage < 55 and not StopRota
and IsCurrentSpell(GetSpellInfo(47450)) then
	ni.spell.stopcasting()
end


if rage >= 65  and not StopRota then

--Heroic Strike
if cdRemains(47450) == 0  
and inMelee()
and not IsCurrentSpell(GetSpellInfo(47450)) then
	_castSpell(47450,"target")
	return true

end
end
if rage >= 85 and not StopRota  then
--Sunder Armor
if cdRemains(7386) == 0
and ni.unit.debuff("target",1715) 
and ni.unit.debuff("target",47465)
and ni.unit.debuff("target", 47486)
and inMelee()  then
	_castSpell(7386)
	return true

end
end
			end
			return false
		end,
		execution = function()
		end,
	},
	[15] = {
		condition = function()
			if (UnitChannelInfo('player') ~= nil and false) or (UnitChannelInfo('player') == nil) then
				if cdRemains(47436) == 0
and not ni.unit.buff("player", 47436)
and rage >= 10 then
	_castSpell(47436)
end
if cdRemains(18499) == 0 then
	if ni.unit.debuff("player", 10890) then
	_castSpell(18499)
	end
	if ni.unit.debuff("player", 5246) then
	_castSpell(18499)
	end
	if ni.unit.debuff("player", 6215) then
	_castSpell(18499)
	end
end
			end
			return false
		end,
		execution = function()
		end,
	},
	[16] = {
		condition = function()
			if (UnitChannelInfo('player') ~= nil and false) or (UnitChannelInfo('player') == nil) then
				if not UnitExists("target") and not UnitCanAttack("player","target") then
TargetNearestEnemyPlayer()
ni.player.runtext("/startattack")
end
			end
			return false
		end,
		execution = function()
		end,
	},
	[17] = {
		condition = function()
			if (UnitChannelInfo('player') ~= nil and false) or (UnitChannelInfo('player') == nil) then
				if ni.unit.buff("player", 52437)
and rage >= 50  then
	_castSpell(47471,"target")
	return true

end
			end
			return false
		end,
		execution = function()
		end,
	},
	[18] = {
		condition = function()
			if ni.spell.available(55694) then
			if (UnitChannelInfo('player') ~= nil and false) or (UnitChannelInfo('player') == nil) then
				local enraged = ni.unit.buff("player", 14202)
local unithealth = 100 * UnitHealth("player") / UnitHealthMax("player")
                
if enraged ~= nil and unithealth < 30 then
        return true
end
			end
			return false
			end
		end,
		execution = function()
			ni.spell.cast(55694, "player")
		end,
	},
	[19] = {
		condition = function()
			if (UnitChannelInfo('player') ~= nil and false) or (UnitChannelInfo('player') == nil) then
				if cdRemains(47436) == 0
and not ni.unit.buff("player", 47436)
and rage >= 10 then
	_castSpell(47436)
end
if cdRemains(18499) == 0 then
	if ni.unit.debuff("player", 10890) then
	_castSpell(18499)
	end
	if ni.unit.debuff("player", 5246) then
	_castSpell(18499)
	end
	if ni.unit.debuff("player", 6215) then
	_castSpell(18499)
	end
end
			end
			return false
		end,
		execution = function()
		end,
	},
	[20] = {
		condition = function()
			if ni.spell.available(2457) then
			if (UnitChannelInfo('player') ~= nil and false) or (UnitChannelInfo('player') == nil) then
				local DS = GetShapeshiftForm()

if DS == 3
and GetSpellCooldown(20252) ~= 0 then
return true
end
			end
			return false
			end
		end,
		execution = function()
			ni.spell.cast(2457, "target")
		end,
	},
	[21] = {
		condition = function()
			if ni.spell.available(46924) then
			if (UnitChannelInfo('player') ~= nil and false) or (UnitChannelInfo('player') == nil) then
				if not leftkeydown then leftkeydown = 0 end
if IsLeftControlKeyDown()  and GetTime() - leftkeydown > 1 then
        return true
end
			end
			return false
			end
		end,
		execution = function()
			ni.spell.cast(46924, "player")
		end,
	},
	[22] = {
		condition = function()
			if ni.spell.available(64382) then
			if (UnitChannelInfo('player') ~= nil and false) or (UnitChannelInfo('player') == nil) then
				if not leftkeydown then leftkeydown = 0 end
if IsLeftAltKeyDown()  and GetTime() - leftkeydown > 1 then
        return true
end
			end
			return false
			end
		end,
		execution = function()
			ni.spell.cast(64382, "target")
		end,
	},
}
local executionqueue = { }
local tmpTab = {
	["execute"] = function()
		for i = 1, #executionqueue do
			executionqueue[i]();
			executionqueue[i] = nil;
		end
		local abilities = abilities;
		for i = 1, #abilities do
			if abilities[i].condition() then
				executionqueue[1] = abilities[i].execution;
				break;
			end
		end
	end
}
rawset(ni.rotation.profile, "SNP Arms", tmpTab);
