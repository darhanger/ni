# Unit

> All functions when used will be prepended with `ni.unit`.

---

## creaturetypes

A table mapping numeric creature type IDs to their corresponding creature type names.

### Table:

| ID  | Creature Type  |
|-----|----------------|
| 0   | Unknown        |
| 1   | Beast          |
| 2   | Dragon         |
| 3   | Demon          |
| 4   | Elemental      |
| 5   | Giant          |
| 6   | Undead         |
| 7   | Humanoid       |
| 8   | Critter        |
| 9   | Mechanical     |
| 10  | NotSpecified   |
| 11  | Totem          |
| 12  | NonCombatPet   |
| 13  | GasCloud       |

```lua
local creatureTypeID = 3
local creatureTypeName = creaturetypes[creatureTypeID]
print(creatureTypeName)  -- Outputs: Demon
```

## ismoving

Arguments:

- **unit** `guid|token`

Returns: `boolean`

Checks if unit is moving or not.

```lua
if ni.unit.ismoving("player") then
  -- Do something
end
```

## movingtime

Arguments:

- **target** `token|guid|string`

Returns: `number`

Calculates the amount of time a unit has been stationary since the last movement.

```lua
local timeStopped = ni.unit.movingtime("target")
print("Time the target has been stationary: " .. timeStopped .. " seconds.")
```

## incombat

Arguments:

- **t** `token|guid`

Returns: `boolean`

Checks if the specified unit is currently in combat.

```lua
if ni.unit.incombat("target") then
  print("The target is in combat.")
end
```

## canattack

Arguments:

- **tar1** `token|guid`
- **tar2** `token|guid`

Returns: `boolean`

Checks if the first unit can attack the second unit.

```lua
if ni.unit.canattack("player", "target") then
  print("The player can attack the target.")
end
```

## canassist

Arguments:

- **tar1** `token|guid`
- **tar2** `token|guid`

Returns: `boolean`

Checks if the first unit can assist the second unit.

```lua
if ni.unit.canassist("player", "target") then
  print("The player can assist the target.")
end
```

## isenemy

Arguments:

- **tar1** `token|guid`
- **tar2** `token|guid`

Returns: `boolean`

Checks if the first unit is an enemy of the second unit.

```lua
if ni.unit.isenemy("player", "target") then
  print("The player considers the target an enemy.")
end
```

## unitisdead

Arguments:

- **t** `token|guid`

Returns: `boolean`

Checks if the specified unit is dead or a ghost.

```lua
if ni.unit.unitisdead("target") then
  print("The target is dead or a ghost.")
end
```

## exists

Arguments:

- **target** `guid|token`

Returns: `boolean`

Checks if specified unit exists in viewable world. If you want to check if unit exists overall, you can use WoW's `UnitExists` function.

```lua
if ni.unit.exists("target") then
  -- Do something
end
```

## isunit

Arguments:

- **tar1** `token|guid`
- **tar2** `token|guid`

Returns: `boolean`

Checks if the first unit is the same as the second unit.

```lua
if ni.unit.isunit("player", "target") then
  print("The player is the target.")
end
```

## itemlvl

Arguments:

- **unit** `guid|token`

Returns: `number`

Returns avarage item level.

```lua
if ni.unit.itemlvl("player") >= 245 then
	-- Player have avarage 245 ilvl equiped
end
```

## los

Arguments:

- **targetfrom** `guid|token|x,y,z`
- **targetto** `guid|token|x,y,z`
- **hitflags** `number` _optional_

Returns: `boolean, x, y, z`

Checks if units have line of sight on each other and returns the hit point of collision.

```lua
if ni.unit.los("player", "target") then
  -- Do something
end
local bool, x, y, z = ni.unit.los(100, 200, -10000, 100, 200, 10000);
if not bool then
	--We now have the z axis of collision from those points stored in the variable z`
end
```

## LoS Bit Values

These are the following hit flags that can be passed to the los function if you don't want to use the default HitTestGroundAndStructures value.

```lua
HitTestNothing = 0x0,
HitTestBoundingModels = 0x1,
HitTestWMO = 0x10,
HitTestUnknown = 0x40,
HitTestGround = 0x100,
HitTestLiquid = 0x10000,
HitTestUnknown2 = 0x20000,
HitTestMovableObjects = 0x100000,
HitTestLOS = HitTestWMO | HitTestBoundingModels | HitTestMovableObjects,
HitTestGroundAndStructures = HitTestLOS | HitTestGround
```

To calculate a bitwise value you'd want, you can use wow's function bit.bor or just simply add the values.
```lua
local hit_ground_and_liquid = 0x100 + 0x10000;
if ni.unit.los("player", "target", hit_ground_and_liquid) then
	--Do because we didn't hit either ground or water
end
```

## facing

Arguments:

- **unit** `guid|token`

Returns: `number`

Returns the units facing in radians.

```lua
if ni.unit.facing("target") == 0 then
	--The unit is facing true north
end
```

## creator

Arguments:

- **target** `guid|token`

Returns: `guid|nil`

Returns a `guid` if specified unit has a creator or `nil` if it doesn't.

```lua
local creator = ni.unit.creator("playerpet");

if UnitGUID("player") == creator then
  -- We're the creator of the checked unit
end
```

## creations

Arguments:

- **target** `guid|token`

Returns: `table|nil`

Table of all the units checked creations (i.e. totems, pets) or nil if there is none.

```lua
local creations = ni.unit.creations("player");

for i = 1, #creations do
  local creature = creations[i]
  -- Do something
end
```

## creaturetype

Arguments:

- **target** `guid|token`

Returns: `number`

Numerical type of the unit checked.

```lua
local type = ni.unit.creaturetype("playerpet")

if type == 3 then
  --Our pet is a demon
end
```

## istotem

Arguments:

- **target** `guid|token`

Returns: `boolean`

Checks whether the creature is a totem. Shorthand function for [creaturetype](api/unit.md#creaturetype).

```lua
if ni.unit.istotem("target") then
  -- Do something
end
```

## readablecreaturetype

Arguments:

- **target** `guid|token`

Returns: `string`

Readable creature string of the unit checked.

```lua
local type = ni.unit.readablecreaturetype("playerpet")

if type == "Demon" then
  -- Do something
end
```

## combatreach

Arguments:

- **target** `guid|token`

Returns: `number`

The combat reach of the unit checked (default return of 0).

```lua
local combatreach = ni.unit.combatreach("player");
-- Would most likely print 1.5 as the combat reach of the player unit
```

## isboss

Arguments:

- **target** `guid|token`

Returns: `boolean`

Checks if specific unit is a boss.

```lua
if ni.unit.isboss("target") then
  -- Do something
end
```

## threat

Arguments:

- **unit** `guid|token`
- **unittargeted** `guid|token` _optional_

Returns: `number`

Calculates a threat of `unit`. If second argument is passed threat is calculated according to `unittargeted`.

```lua
local threat = ni.unit.threat("player", "target")
```

## id

Arguments:

- **unit** `guid|token`

Returns: `number`

Retrieves unitd id.

```lua
if ni.unit.id("target") == 36597 then
  -- Unit is Lich King
end
```

## shortguid

Arguments:

- **t** `token|guid|string`

Returns: `string`

Retrieves the last 5 characters of the GUID for a given unit.

```lua
local shortGuid = ni.unit.shortguid("target")
print("Short GUID of the target: " .. shortGuid)
```

## isdummy

Arguments:

- **unit** `guid|token`

Returns: `boolean`

Checks whether or not the unit is a dummy.

```lua
if ni.unit.isdummy("target") then
  -- Do something
end
```

## ttd

Arguments:

- **unit** `guid|token`

Returns: `number`

Retrieves time to die of specified unit in seconds. If unit doesn't exist it returns `-2`, if the unit is a dummy or if the unit somehow skipped the ttd calculation returns `99`.

```lua
if ni.unit.ttd("target") > 10 then
  -- Do something
end
```

## hp

Arguments:

- **unit** `guid|token`

Returns: `number`

Calculates and returns current percent of the unit's health.

```lua
if ni.unit.hp("target") > 90 then
  -- Unit has more than 90% hp
end
```

## hpraw

Arguments:

- **unit** `guid|token`

Returns: `number`

Calculates and returns current unit's health.

```lua
if ni.unit.hpraw("target") > 20000 then
  -- Unit has more than 20k hp
end
```

## hppredicted

Arguments:

- **unit** `guid|token`

Returns: `number`

Supported: `4.3.4` and `5.4.8`

Calculates and returns predicted unit's health. It calculates current health with incoming heal and calculates the percent.

```lua
if ni.unit.hppredicted("target") < 30 > then
  -- Unit will have less than 30% after getting healed
end
```

## power

Arguments:

- **unit** `guid|token`
- **type** `string` _optional_

Returns: `number`

Calculates and returns current percent of the unit's power (e.g. mana, energy, focus, etc.).

```lua
if ni.unit.power("target") > 90 then
  -- Unit has more than 90% power
end
```

## powerraw

Arguments:

- **unit** `guid|token`
- **type** `string` _optional_

Returns: `number`

Calculates and returns current of unit's power (e.g. mana, energy, focus, etc.).

```lua
if ni.unit.powerraw("target") > 10000 then
  -- Unit has more than 10000 power
end
```

## info

Arguments:

- **unit** `guid|token`

Returns: `number`

Retrieves detailed information about the unit.

```lua
local x, y, z, facing, unittype, target, height = ni.unit.info("target")
```

## location

Arguments:

- **unit** `guid|token`

Returns: `x, y, z`

Returns value 1 being the units x, value 2 being the units y and value 3 being the units z.

```lua
local x, y, z = ni.unit.location("target");
--Do something with the x, y, and z'second
```

## castingpercent

Arguments:

- **t** `token|guid|string`

Returns: `number`

Calculates the percentage of completion for a unit's current casting spell.

```lua
local castingPercent = ni.unit.castingpercent("target")
print("Casting percentage of the target: " .. castingPercent .. "%")
```

## channelpercent

Arguments:

- **t** `token|guid|string`

Returns: `number`

Calculates the percentage of completion for a unit's current channeled spell.

```lua
local channelingPercent = ni.unit.channelpercent("target")
print("Channeling percentage of the target: " .. channelingPercent .. "%")
```

## aura

Arguments:

- **unit** `guid|token`
- **aura** `id|name`

Returns: `boolean`

Checks if specified unit has aura (this check is more than wow's UnitAura as it can return true for passive auras not seen by the normal client).

```lua
if ni.unit.aura("player", 32223) then
  -- Player has Crusader Aura
end
if ni.unit.aura("player", "Crusader Aura") then
	--Player has Crusader Aura
end
```

## auras

Arguments:

- **unit** `guid|token`

Returns: `table`

Returns a table of all the auras on the unit with their ID and name (able to see auras that are not normally seen by the client with this, this function is more for developers to get a list of all auras on a unit to use with the aura function).

```lua
local auras = ni.unit.auras("target");
for k, v in ipairs(auras) do
	if v.name == "Crusader Aura" then
		--The unit has the aura Crusader Aura by name check
	end
	if v.ID == 32223 then
		--The unit has the aura Crusader Aura by ID check
	end
end
```

## buff

Arguments:

- **target** `guid|token`
- **id** `name|id`
- **filter** `EXACT|PLAYER` _optional_

Returns: `UnitBuff`

Checks if specified unit has certain buff.

```lua
if ni.unit.buff("target", "Life Tap", "player") then
  -- Target has Life Tap active
end
if ni.unit.buff("player", 533, "exact") then
  -- Player has the buff that exactly matches ID 533
end
```

## buffs

Arguments:

- **target** `guid|token`
- **ids** `name|id`
- **filter** `EXACT|PLAYER` _optional_

Returns: `boolean`

Checks if specified unit has certain buffs separated by `&&` or `||`.

```lua
if ni.unit.buffs("target", "63321&&Fel Armor", "player") then
  -- Target has both Life Tap and Fel Armor
end
if ni.unit.buffs("target", "63321||Fel Armor") then
  -- Target has either Life Tap, or Fel Armor
end
```

## bufftype

Arguments:

- **target** `guid|token`
- **types** `string|string`

Returns: `boolean`

Checks if specified unit has certain buff types. Multiple types can be passed by using the pipe character (`|`).

| Type   |
| ------ |
| Magic  |
| Enrage |

```lua
if ni.unit.bufftype("target", "Enrage|Magic") then
        -- Target has either a Enrage or Magic debuff present
end
```

## bufftypetimer

Arguments:

- **target** `token|guid|string`
- **str** `string`

Returns: `number|boolean`

Returns the remaining time of a buff on a unit based on the buff type.

```lua
local remainingTime = ni.unit.bufftypetimer("target", "Magic")
print("Remaining time of Magic buff: " .. remainingTime .. " seconds")
```

## buffstacks

Arguments:

- **target** `guid|token`
- **id** `name|id`
- **filter** `EXACT|PLAYER` _optional_

Returns: `number`

Obtains the number of buff stacks on target.

```lua
if ni.unit.buffstacks("target", 1234) < 5 then
  -- Target has less than 5 stacks of 1234 on them
end
```

## bufftimer

Arguments:

- **target** `token|guid|string`
- **spellID** `number|string`
- **filter** `string` _optional_

Returns: `number`

Returns the remaining duration of a specific buff on a unit.

```lua
local remainingDuration = ni.unit.bufftimer("target", 12345)
print("Remaining duration of buff: " .. remainingDuration .. " seconds")
```

## buffremaining

Arguments:

- **target** `guid|token`
- **id** `name|id`
- **filter** `EXACT|PLAYER` _optional_

Returns: `boolean`

Calculates the remaining time of the buff on target in seconds.

```lua
if ni.unit.buffremaining("target", 48441, "player") < 5 then
  -- Target has Rejuvenation for less than 5 seconds
end
```

## buffduration

Arguments:

- **target** `token|guid|string`
- **spellID** `number|string`
- **filter** `string` _optional_

Returns: `number`

Returns the duration of a specific buff on a unit.

```lua
local buffDuration = ni.unit.buffduration("target", 12345)
print("Duration of buff: " .. buffDuration .. " seconds")
```

## debuff

Arguments:

- **target** `guid|token`
- **id** `name|id`
- **filter** `EXACT|PLAYER` _optional_

Returns: `UnitDebuff`

Checks if specified unit has certain debuff.

```lua
if ni.unit.debuff("target", "Unstable Affliction", "player") then
  -- Target has Unstable Affliction
end
if ni.unit.debuff("target", 1234, "exact|player") then
  -- Target has debuff matching the spell ID 1234 cast by the player
end
```

## debuffs

Arguments:

- **target** `guid|token`
- **ids** `name|id`
- **filter** `EXACT|PLAYER` _optional_

Returns: `boolean`

Checks if specified unit has certain debuffs separated by `&&` or `||`.

```lua
if ni.unit.debuffs("target", "Faerie Fire&&Curse of Agony", "player") then
  -- Target has both Faerie Fire and Curse of Agony
end
if ni.unit.debuffs("target", "Faerie Fire||Curse of Agony") then
  -- Target has either Faerie Fire or Curse of Agony
end
```

## debufftype

Arguments:

- **target** `guid|token`
- **types** `string|string`

Returns: `boolean`

Checks if specified unit has certain debuff types. Multiple types can be passed by using the pipe character (`|`).

| Type    |
| ------- |
| Magic   |
| Poison  |
| Curse   |
| Disease |

```lua
if ni.unit.debufftype("target", "Poison|Magic") then
        -- Target has either a poison or magic debuff present
end
```

## debufftypetimer

Arguments:

- **target** `token|guid|string`
- **str** `string`

Returns: `number|boolean`

Returns the remaining time of a buff on a unit based on the buff type.

```lua
local remainingTime = ni.unit.debufftypetimer("target", "Magic")
print("Remaining time of Magic buff: " .. remainingTime .. " seconds")
```

## debuffstacks

Arguments:

- **target** `guid|token`
- **id** `name|id`
- **filter** `EXACT|PLAYER` _optional_

Returns: `number`

Obtains the number of debuff stacks on target.

```lua
if ni.unit.debuffstacks("target", 1234) < 5 then
  -- Target has less than 5 stacks of 1234 on them
end
```

## debufftimer

Arguments:

- **target** `token|guid|string`
- **spellID** `number|string`
- **filter** `string` _optional_

Returns: `number`

Returns the remaining duration of a specific buff on a unit.

```lua
local remainingDuration = ni.unit.debufftimer("target", 1234)
print("Remaining duration of buff: " .. remainingDuration .. " seconds")
```

## debuffremaining

Arguments:

- **target** `guid|token`
- **id** `name|id`
- **filter** `EXACT|PLAYER` _optional_

Returns: `boolean`

Calculates the remaining time of the debuff on target in seconds.

```lua
if ni.unit.debuffremaining("target", 1234, "player") < 5 then
  -- Target has spell of ID 1234 for less than 5 seconds
end
```

## debuffduration

Arguments:

- **target** `token|guid|string`
- **spellID** `number|string`
- **filter** `string` _optional_

Returns: `number`

Returns the duration of a specific buff on a unit.

```lua
local debuffDuration = ni.unit.debuffduration("target", 1234)
print("Duration of buff: " .. debuffDuration .. " seconds")
```

## spellstealable

Arguments:

- **t** `token|guid|string`

Returns: `boolean`

Checks if the target has any stealable buffs.

```lua
local canSteal = ni.unit.spellstealable("target")
if canSteal then
    print("The target has stealable buffs.")
else
    print("The target does not have any stealable buffs.")
end
```

## isfacing

Arguments:

- **unit** `guid|token`
- **target** `guid|token`
- **degrees** `number` _optional_

Returns: `boolean`

Checks if `unit` is facing `target`, degrees is defaulted to 180.

```lua
if ni.unit.isfacing("player", "target") then
  -- Player is facing the target
end
if ni.unit.isfacing("player", "target", 90) then
  -- Player is facing the target with a 90 degree precision (45 degrees both left and right)
end
```

## isbehind

Arguments:

- **unit** `guid|token`
- **target** `guid|token`

Returns: `boolean`

Checks if `unit` is behind `target`.

```lua
if ni.unit.isbehind("player", "target") then
  -- Player is behind the target
end
```

## distance

Arguments:

- **unit** `guid|token`
- **target** `guid|token`

Returns: `number|nil`

Calculates the distance between `unit` and `target` in yards. If any of the arguments are not passed this function will return `nil`.

```lua
if ni.unit.distance("player", "target") < 40 then
  -- Target is closer than 40 yards
end
```

## distancesqr

Arguments:

- **t1** `token|guid|string`
- **t2** `token|guid|string`

Returns: `number`

Calculates the squared distance between two units.

```lua
local distanceSquared = ni.unit.distancesqr("player", "target")
print("Squared distance between player and target:", distanceSquared)
```

## meleerange

Arguments:

- **unit1** `token|guid`
- **unit2** `token|guid`

Returns: `boolean`

Calculates melee range of `unit1` to `unit2`. If you want to check if unit is in melee range use [`inmelee`](api/unit.md#inmelee)

```lua
ni.unit.meleerange("player", "target")
```

## inmelee

Arguments:

- **unit1** `token|guid`
- **unit2** `token|guid`

Returns: `boolean`

Checks if `unit1` is in melee range of `unit2`.

```lua
if ni.unit.inmelee("player", "target") then
  -- Target is in melee range of player
end
```

## enemiesinrange

Arguments:

- **unit** `guid|token`
- **range** `number`

Returns: `table`

Returns a table of all enemies which are in range of specified unit. Each enemy has `guid`, `name` and `distance` properties.

```lua
local enemies = ni.unit.enemiesinrange("player", 30)

for i = 1, #enemies do
  local target = enemies[i].guid
  local name = enemies[i].name
  local distance = enemies[i].distance
  -- Do something with the enemy target
end
```

## enemiesinrangewithbufftype

Arguments:

- **t** `guid|token` – The unit for which enemies' distances are calculated.
- **n** `number` – The maximum range to consider.
- **str** `string` – The buff type to check for on enemies.

Returns: `table`

Returns a table of all enemies within a specified range of the given unit that have a specific buff type. Each enemy has `guid`, `name`, and `distance` properties.

```lua
local enemies = ni.unit.enemiesinrangewithbufftype("player", 30, "Magic")

for i = 1, #enemies do
  -- Do something with the enemy target with buffs
end
```

## friendsinrange

Arguments:

- **unit** `guid|token`
- **range** `number`

Returns: `table`

Returns a table of all friendlies which are in range of specified unit. Each friendly has `guid`, `name` and `distance` properties.

```lua
local friends = ni.unit.friendsinrange("player", 30)

for i = 1, #friends do
  local target = friends[i].guid
  local name = friends[i].name
  local distance = friends[i].distance
  -- Do something with the friendly target
end
```

## unitstargeting

Arguments:

- **unit** `guid|token`
- **friendlies** `boolean` _default: false_

Returns: `table`

Returns a table of all units which are in range of specified unit. Each unit has `guid`, `name` and `distance` properties.

```lua
local units = ni.unit.unitstargeting("player")

for i = 1, #units do
  local target = units[i].guid
  local name = units[i].name
  local distance = units[i].distance
  -- Do something with the units targeting the player
end
```

## iscasting

Arguments:

- **unit** `guid|token`

Returns: `boolean`

Checks if specified unit is casting.

```lua
if ni.unit.iscasting("target") then
  -- Target is casting
end
```

## ischanneling

Arguments:

- **unit** `guid|token`

Returns: `boolean`

Checks if specified unit is channeling.

```lua
if ni.unit.ischanneling("target") then
  -- Target is channeling
end
```

## target

Arguments:

- **t** `guid|token` – The unit to get the target of.

Returns: `guid|nil`

Returns the GUID of the target of the specified unit. If the unit does not exist, the function returns `nil`.

```lua
local target = ni.unit.target("player")
if target then
    print("The target GUID is: " .. target)
else
    print("Unit does not exist or has no target.")
end
```

## incombatwithme

Arguments:

- **t** `guid|token` – The unit to check for combat status.

Returns: `boolean`

Returns `true` if the specified unit’s target is one of the player's allies. Otherwise, returns `nil` if the unit does not have a target or the target is not an ally.

```lua
if ni.unit.incombatwithme("player") then
    print("The target of the specified unit is in combat with one of your allies.")
else
    print("The target of the specified unit is not in combat with your allies or has no target.")
end
```

## transport

Arguments:

- **unit** `guid|token`

Returns: `string or nil`

Returns the GUID of the units transport if they have one (Like being on an elevator or vehicle, or unit on top of another unit), or nil.

```lua
local transport = ni.unit.transport("target")
if transport then
	--The target has a transport, maybe we need to kill that instead now?
end
```

## flags

Arguments:

- **t** `guid|token` – The unit to retrieve flags for.

Returns: `table`

Returns the flags associated with the specified unit. 

```lua
local flags = ni.unit.flags("target")
print(flags)
```

## dynamicflags

Arguments:

- **t** `guid|token` – The unit to retrieve dynamic flags for.

Returns: `table`

Returns the dynamic flags associated with the specified unit.

```lua
local dynamicFlags = ni.unit.dynamicflags("target")
print(dynamicFlags)
```

## istappedbyallthreatlist

Arguments:

- **t** `guid|token` – The unit to check.

Returns: `boolean`

Returns `true` if the unit is tapped by all threat list, otherwise `false`.

```lua
if ni.unit.istappedbyallthreatlist("target") then
    print("The unit is tapped by all threat list.")
end
```

## islootable

Arguments:

- **t** `guid|token` – The unit to check.

Returns: `boolean`

Returns `true` if the unit is lootable, otherwise `false`.

```lua
if ni.unit.islootable("target") then
    print("The unit is lootable.")
end
```

## istaggedbyme

Arguments:

- **t** `guid|token` – The unit to check.

Returns: `boolean`

Returns `true` if the unit is tagged by the player, otherwise `false`.

```lua
if ni.unit.istaggedbyme("target") then
    print("The unit is tagged by me.")
end
```

## istaggedbyother

Arguments:

- **t** `guid|token` – The unit to check.

Returns: `boolean`

Returns `true` if the unit is tagged by another player, otherwise `false`.

```lua
if ni.unit.istaggedbyother("target") then
    print("The unit is tagged by another player.")
end
```

## canperformaction

Arguments:

- **t** `guid|token` – The unit to check.

Returns: `boolean`

Returns `true` if actions can be performed on the unit, otherwise `false`.

```lua
if ni.unit.canperformaction("target") then
    print("You can perform actions on this unit.")
end
```

## isconfused

Arguments:

- **t** `guid|token` – The unit to check.

Returns: `boolean`

Returns `true` if the unit is confused, otherwise `false`.

```lua
if ni.unit.isconfused("target") then
    print("The unit is confused.")
end
```

## notbleed

Arguments:

- **t** `guid|token` – The unit to check.

Returns: `boolean`

Returns `true` if the unit is not affected by bleed effects, otherwise `false`.

```lua
if ni.unit.notbleed("target") then
    print("The unit is not affected by bleed effects.")
end
```

## isdisarmed

Arguments:

- **t** `guid|token` – The unit to check.

Returns: `boolean`

Returns `true` if the unit is disarmed, otherwise `false`.

```lua
if ni.unit.isdisarmed("target") then
    print("The unit is disarmed.")
end
```

## isfleeing

Arguments:

- **t** `guid|token` – The unit to check.

Returns: `boolean`

Returns `true` if the unit is fleeing, otherwise `false`.

```lua
if ni.unit.isfleeing("target") then
    print("The unit is fleeing.")
end
```

## islooting

Arguments:

- **t** `guid|token` – The unit to check.

Returns: `boolean`

Returns `true` if the unit is currently looting, otherwise `false`.

```lua
if ni.unit.islooting("target") then
    print("The unit is looting.")
end
```

## ismounted

Arguments:

- **t** `guid|token` – The unit to check.

Returns: `boolean`

Returns `true` if the unit is mounted, otherwise `false`.

```lua
if ni.unit.ismounted("target") then
    print("The unit is mounted.")
end
```

## isnotattackable

Arguments:

- **t** `guid|token` – The unit to check.

Returns: `boolean`

Returns `true` if the unit is not attackable, otherwise `false`.

```lua
if ni.unit.isnotattackable("target") then
    print("The unit is not attackable.")
end
```

## isnotselectable

Arguments:

- **t** `guid|token` – The unit to check.

Returns: `boolean`

Returns `true` if the unit is not selectable, otherwise `false`.

```lua
if ni.unit.isnotselectable("target") then
    print("The unit is not selectable.")
end
```

## ispacified

Arguments:

- **t** `guid|token` – The unit to check.

Returns: `boolean`

Returns `true` if the unit is pacified, otherwise `false`.

```lua
if ni.unit.ispacified("target") then
    print("The unit is pacified.")
end
```

## ispetinombat

Arguments:

- **t** `guid|token` – The unit to check.

Returns: `boolean`

Returns `true` if the unit is a pet in combat, otherwise `false`.

```lua
if ni.unit.ispetinombat("target") then
    print("The unit is a pet in combat.")
end
```

## isplayercontrolled

Arguments:

- **t** `guid|token` – The unit to check.

Returns: `boolean`

Returns `true` if the unit is player-controlled, otherwise `false`.

```lua
if ni.unit.isplayercontrolled("target") then
    print("The unit is player-controlled.")
end
```

## ispossessed

Arguments:

- **t** `guid|token` – The unit to check.

Returns: `boolean`

Returns `true` if the unit is possessed, otherwise `false`.

```lua
if ni.unit.ispossessed("target") then
    print("The unit is possessed.")
end
```

## ispreparation

Arguments:

- **t** `guid|token` – The unit to check.

Returns: `boolean`

Returns `true` if the unit is in preparation mode, otherwise `false`.

```lua
if ni.unit.ispreparation("target") then
    print("The unit is in preparation mode.")
end
```

## ispvpflagged

Arguments:

- **t** `guid|token` – The unit to check.

Returns: `boolean`

Returns `true` if the unit is PvP flagged, otherwise `false`.

```lua
if ni.unit.ispvpflagged("target") then
    print("The unit is PvP flagged.")
end
```

## issilenced

Arguments:

- **t** `guid|token` – The unit to check.

Returns: `boolean`

Returns `true` if the unit is silenced, otherwise `false`.

```lua
if ni.unit.issilenced("target") then
    print("The unit is silenced.")
end
```

## isskinnable

Arguments:

- **t** `guid|token` – The unit to check.

Returns: `boolean`

Returns `true` if the unit is skinnable, otherwise `false`.

```lua
if ni.unit.isskinnable("target") then
    print("The unit is skinnable.")
end
```

## isstunned

Arguments:

- **t** `guid|token` – The unit to check.

Returns: `boolean`

Returns `true` if the unit is stunned, otherwise `false`.

```lua
if ni.unit.isstunned("target") then
    print("The unit is stunned.")
end
```

## isimmune

Arguments:

- **t** `guid|token` – The unit to check.

Returns: `boolean`

Returns `true` if the unit is immune to effects, otherwise `false`.

```lua
if ni.unit.isimmune("target") then
    print("The unit is immune.")
end
```