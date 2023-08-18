# Members

> All functions when used will be prepended with `ni.members`.

---
## Iterating with member table
If you don't need them to be sorted by range and hp:

```lua
for i = 1, #ni.members do
    ...
end
```
If you only need sorting by range:

```lua
for i = 1, #ni.members.inrange("player", 40) do
    ...
end
```

If you need to sort by range and hp:
```lua
for i = 1, #ni.members.sort() do
    ...
end
```

## istank

Returns: `boolean`

Returns true if the unit is a tank or has the capability to tank, and false otherwise.

```lua
for i = 1, #ni.members do
	if ni.members[i]:istank() then
		-- The unit is tank, do stuff...
	end
end
```

## ishealer

Returns: `boolean`

Returns true if the unit is a healer or has the capability to healer, and false otherwise.

```lua
for i = 1, #ni.members do
	if ni.members[i]:ishealer() then
		-- The unit is healer, do stuff... 
	end
end
```

## isdps

Returns: `boolean`

Returns true if the unit is a DPS or has the capability to DPS, and false otherwise.

```lua
for i = 1, #ni.members do
	if ni.members[i]:isdps() then
		-- The unit is DPS, do stuff... 
	end
end
```

## iscaster

Returns: `boolean`

Returns true if the unit is a Caster DPS or has the capability to Caster DPS, and false otherwise.

```lua
for i = 1, #ni.members do
	if ni.members[i]:iscaster() then
		-- The unit is Caster DPS, do stuff... 
	end
end
```

## ismelee

Returns: `boolean`

Returns true if the unit is a Melee DPS or has the capability to Melee DPS, and false otherwise.

```lua
for i = 1, #ni.members do
	if ni.members[i]:ismelee() then
		-- The unit is Melee DPS, do stuff... 
	end
end
```

## location

Returns: `number`, `number`, `number`, `number`

Returns the current location of the unit in the game world as four separate values: x, y, z, and r (rotation).

```lua
for i = 1, #ni.members do
	local x, y, z, r = ni.members[i]:location()
	if x and y and z and r then
		-- The unit's location was successfully retrieved
	end
end
```

## combat

Returns: `boolean`

Returns true if the unit is currently in combat, and false otherwise.

```lua
for i = 1, #ni.members do
	if ni.members[i]:combat() then
		-- The unit is in combat
	end
end
```

## aura

Arguments:

- **aura** `number` or `string`

Returns: `boolean`

Returns true if the unit has the specified aura, and false otherwise.

```lua
if ni.members[1]:aura(12345) then
    -- The unit has aura ID 12345
end

if ni.members[1]:aura("Arcane Intellect") then
    -- The unit has the "Arcane Intellect" aura
end
```

Note: You can use either the aura ID or the name of the aura as the argument for this function.

## auras
Arguments:

- **ids** `name|id`
- **filter** `EXACT|PLAYER` _optional_

Returns: `boolean`

Checks if specified unit has certain buffs separated by `&&` or `||`.

```lua
if ni.members[1]:auras("63321&&Fel Armor") then
    -- Unit has both Life Tap and Fel Armor
end

if ni.members[1]:auras("63321||Fel Armor", "EXACT") then
    -- Unit has either Life Tap, or Fel Armor
end
```

Note: You can use either the buff IDs or names as the argument for this function.

## buffs

Arguments:

- **ids** `name|id`
- **filter** `EXACT|PLAYER` _optional_

Returns: `boolean`

Checks if specified unit has certain buffs separated by `&&` or `||`.

```lua
if ni.members[1]:buffs("63321&&Fel Armor", "EXACT") then
    -- Unit has both Life Tap and Fel Armor
end

if ni.members[1]:buffs("63321||Fel Armor") then
   -- Target has either Life Tap, or Fel Armor
end
```

Note: You can use either the buff IDs or names as the argument for this function.

## debuffs

Arguments:

- **ids** `name|id`
- **filter** `EXACT|PLAYER` _optional_

Returns: `boolean`

Checks if specified unit has certain debuffs separated by `&&` or `||`.

```lua
if ni.members[1]:debuffs("Faerie Fire&&Curse of Agony", "PLAYER") then
    -- The unit has both Faerie Fire and Curse of Agony
end

if ni.members[1]:debuffs("Faerie Fire||Curse of Agony") then
    -- The has either Faerie Fire or Curse of Agony
end
```

Note: You can use either the debuff IDs or names as the argument for this function.

## debufftype

Type:

- **function**

Arguments:

- **string** `debuff type`

Returns: `boolean`

Returns true or false if the member accessed has the debuff type passed.

```lua
for i = 1, #ni.members do
	if ni.members[i]:debufftype("Disease") then
		-- This member has a debuff type that is Disease on them
	end
end
```
Note: This function checks for any debuffs of the specified type, regardless of their specific name or ID.

## bufftype

Type:

- **function**

Arguments:

- **string** `buff type`

Returns: `boolean`

Returns true or false if the member accessed has the debuff type passed.

```lua
for i = 1, #ni.members do
	if ni.members[i]:bufftype("Magic") then
		-- This member has a buff type that is Magic on them
	end
end
```

Note: This function checks for any buffs of the specified type, regardless of their specific name or ID.

## buff

Type:

- **function**

Arguments:

- **buff** `name|id`
- **filter** `EXACT|PLAYER` _optional_

Returns: `UnitBuff`

Returns the same results from UnitBuff if they have the buff present.

```lua
for i = 1, #ni.members do
	if ni.members[i]:buff("Power Word: Shield", "PLAYER") then
		-- This member has Power Word: Shield on them cast by the player
	end
end
```

Note: If the `filter` argument is not specified, this function will return the first matching buff it finds, regardless of its type.

## debuff

Type:

- **function**

Arguments:

- **debuff** `name|id`
- **filter** `EXACT|PLAYER` _optional_

Returns: `UnitDebuff`

Returns the same results from UnitDebuff if they have the debuff present.

```lua
for i = 1, #ni.members do
	if ni.members[i]:debuff("Weakend Soul") then
		-- This member has Weakend Soul on them
	end
end
```

Note: If the `filter` argument is not specified, this function will return the first matching debuff it finds, regardless of its type.

## buffstacks

Arguments:

- **buff** `name|id`
- **filter** `EXACT|PLAYER` _optional_

```lua
for i = 1, #ni.members do
	if ni.members[i]:buffstacks("Earth Shield") < 3 then
		-- This member has Earth Shield less then 3 stacks
	end
end
```

Note: If the `filter` argument is not specified, this function will return the first matching debuff it finds, regardless of its type.

## debuffstacks

Arguments:

- **buff** `name|id`
- **filter** `EXACT|PLAYER` _optional_

```lua
for i = 1, #ni.members do
	if ni.members[i]:debuffstacks("Chilled to the Bone") > 5 then
		-- This member has Chilled to the Bone debuff mor then 5 stacks
	end
end
```

Note: If the `filter` argument is not specified, this function will return the first matching debuff it finds, regardless of its type.

## dispel

Type:

- **variable**

Returns: `boolean`

This is the variable that returns true or false of the member accessed if you can dispel them and they have a debuff that requires dispelling.

```lua
for i = 1, #ni.members do
	if ni.members[i]:dispel() then
		-- This member has a debuff that can be dispelled by you
	end
end
```

## cast

Arguments:

- **spell** `id|string`

Returns: `void`

Casts the specified spell on member.

```lua
for i = 1, #ni.members do
	if ni.members[i]:dispel() then
		return ni.members[i]:cast(988) -- Cast Dispel Magic on ally
	end
end

for i = 1, #ni.members do
	if ni.members[i]:buffstacks("Earth Shield") < 3 then
		return ni.members[i]:cast("Earth Shield") -- Cast Earth Shield on ally
	end
end
```

## hpraw

Type:

- **variable**

Returns: `number`

This is the variable that returns the absolute health of the member accessed.

```lua
for i = 1, #ni.members do
	if ni.members[i]:hpraw() < 30000 then
		-- This member has less then 30000 health
	end
end
```

## hpmax

Type:

- **variable**

Returns: `number`

Returns the maximum health of the unit.

```lua
for i = 1, #ni.members do
	local maxHealth = ni.members[i]:hpmax()
		...
end
```

## hp

Type:

- **variable**

Returns: `number`

This is the variable that returns the health percentage of the member accessed.

```lua
for i = 1, #ni.members do
	if ni.members[i]:hp() < 20 then
		-- This member is below 20% health
	end
end
```

## range

Arguments: None

Returns: `boolean`

Returns true if the unit is within 40 yards of the player, false otherwise.

```lua
for i = 1, #ni.members do
	if ni.members[i]:range() then
		-- Unit is within 40 yards of the player
	end
end	
```

## los

Arguments: None

Returns: `boolean`

Returns true if the player has line of sight to the unit, false otherwise.

```lua
for i = 1, #ni.members do
	if ni.members[i]:los() then
		-- Player has line of sight to the unit
	end
end	
```

## facing

Arguments: None

Returns: `boolean`

Returns true if the player is facing the unit, false otherwise.

```lua
for i = 1, #ni.members do
	if ni.members[i]:facing() then
		-- Player is facing the unit
	end
end	
```

## valid

Arguments:

- **spell** `id|string`
- **facing** `boolean` _default: false_
- **los** `boolean` _default: false_

Returns: `boolean`

This functions ensures that a spell can be casted at specific unit. It includes checks such as:

- [`los`](api/members.md#los)
- [`facing`](api/members.md#facing)
- `IsSpellInRange`

```lua
for i = 1, #ni.members do
	if ni.members[i]:valid(48441, false, true) then
		-- All of the critera to be valid
	end
end	

for i = 1, #ni.members do
	if ni.members[i]:valid("Power Word: Shield", false, true) then
		-- All of the critera to be valid
	end
end	
```

## threat

Type:

- **variable**

Returns: `number`

This is the variable that returns the threat (number between -1 and 3) of the member accessed.

```lua
for i = 1, #ni.members do
	if ni.members[i]:threat() == -1 then
		-- This member is not on any mobs threat list (99% chance just out of combat)
	end
end
```

## subgroup

Type:

- **variable**

Returns: `number`

This is the variable that returns subgroup number of raid party.

```lua
for i = 1, #ni.members do
	if ni.members[i]:subgroup == 1
	or ni.members[i]:subgroup == 2 then
		-- Do something only for members with 1 and 2 subgroup from raid (10 ppl)
	end
end
```

## role

Returns the assigned role of the unit in the group.

Returns:

- A string representing the assigned role of the unit in the group.
- Returns an empty string if the unit has no assigned role.

Example:

```lua
for i = 1, #ni.members do
	if ni.members[i].role == "TANK" then
		-- Do something specific for tanks
	elseif ni.members[i].role == "HEALER"
		-- Do something specific for healer
	elseif ni.members[i].role == "CASTER"
		-- Do something specific for caster
	elseif ni.members[i].role == "MELEE"
		-- Do something specific for melee		
	end
end
```

## spec

Returns the class specialization of the unit in the group.

Returns:

- Returns None if the unit has no tallent builds.

Example:

```lua
for i = 1, #ni.members do
	if ni.members[i].spec == "Fire" then
		-- Do something specific for mages with Fire build	
	end
end
```

## below

Arguments:

- **percent** `number`

Returns: `number`

Returns the number of members below the percentage passed as the argument.

```lua
local count = ni.members.below(90); --Count would then be the number of members below 90
if #count >= 3 then
	-- Do something
end
```

## average

Arguments:

- **unit** `guid|token`
- **distance** `number`

Returns: `number`

Calculates the average health percentage of members within a specified distance of a unit.

```lua
local avarage = ni.members.average("player", 20);
if avarage <= 40
	-- Avarage HP of all members in distance with player low then 40%
end
```

## averageof

Arguments:

- **count** `number`
- **unit** `guid|token`
- **distance** `number`

Returns: `number`

The average health percentage of the specified number of members within the specified distance of the unit.

```lua
local averageHealth = ni.members.averageof(5, "focus", 30) 
-- Calculates the average health of the 5 nearest members to the focus within 30 yards.
```

## subgroupbelow

Arguments:

- `percent` (`number`): The percentage of health below which members are considered to have low health.
- `radius` (`number`): The maximum radius (in yards) within which to search for low health members.
- `owngroup` (`boolean`, optional): If `true`, search only within the player's subgroup. Otherwise, search within all subgroups.

Returns: 
- `near` (`number`): The number of members in the subgroup with low health.
- `lowestMember` (`table`): A table containing information about the subgroup member with the lowest health and closest to the player. The table contains the following keys:
    - `unit` (`string`): The name of the unit.
    - `hp` (`number`): The health percentage of the unit.
    - `near` (`number`): The number of other members within the specified radius that also have low health.

```lua
-- Search for the subgroup member with the lowest health below 20% within 10 yards.
local total, lowestMember = ni.members.subgroupbelow(20, 10)

if lowest and total >= 3
and lowest:valid(48072, false, true) then
	spellCast(48072, lowest.unit)
	return true;	
end
```

Note: This function searches for the lowest health member(s) in a player's subgroup and returns the number of members with low health and the one with the lowest health within a certain radius.

## inrange

Arguments:

- **unit** `guid|token`
- **distance** `number`

Returns: `table`

Returns a table of the members that are within the distance specified of the unit specified.

```lua
local members_around_me = ni.members.inrange("player", 10); --Returns a table of all the members within 10 yards of the player
```

## inrangebelow

Arguments:

- **unit** `guid|token`
- **distance** `number`
- **hp** `number`

Returns: `table`

Returns a table of the members that are within the distance specified of the unit and are below the HP threshold passed.

```lua
local members_below = ni.members.inrangebelow("player", 10, 60); --Returns a table of all the members within 10 yards of the player that are below 60% health
```

---

> In addition to the main ni.members functions, ni.members itself is also a table of all the party/raid members of the unit. This is meant for iterating with the purpose of healing profiles or profiles that need access to the members. Below are the accessors, functions, and examples of this table:

## inrangewithbuff

Arguments:

- **unit** `guid|token`
- **distance** `number`
- **buff** `name|id`
- **filter** `EXACT|PLAYER` _optional_

Returns: `table`

Returns a table of the members that are within the distance specified of the unit and also have the buff that is specified.

```lua
local members_with_riptide = ni.members.inrangewithbuff("player", 10, "Riptide", "PLAYER"); --Returns a table of all the members within 10 yards of the player that have the buff Riptide which was cast by the player
```

## inrangewithoutbuff

Arguments:

- **unit** `guid|token`
- **distance** `number`
- **buff** `name|id`
- **filter** `EXACT|PLAYER` _optional_

Returns: `table`

Returns a table of the members that are within the distance specified of the unit and also do not have the buff that is specified.

```lua
local members_without_riptide = ni.members.inrangewithoutbuff("player", 10, "Riptide"); --Returns a table of all the members within 10 yards of the player that do not have the buff Riptide
```

## inrangewithdebufftype

Arguments:

- **unit** `guid|token`
- **distance** `number`
- **str** `string`

Returns: `table`

Returns a table of the members that are within the distance specified of the unit and also have the debuff type that is specified.

```lua
local members_with_poison = ni.members.inrangewithdebufftype("player", 10, "Poison"); --Returns a table of all the members within 10 yards of the player that have a poison debuff
```

## inrangewithbufftype

Arguments:

- **unit** `guid|token`
- **distance** `number`
- **str** `string`

Returns: `table`

Returns a table of the members that are within the distance specified of the unit and also have the buff type that is specified.

```lua
local members_with_magic_buff = ni.members.inrangewithbufftype("player", 10, "Magic"); --Returns a table of all the members within 10 yards of the player that have a magic buff
```

## inrangewithbuffbelow

Arguments:

- **unit** `guid|token`
- **distance** `number`
- **buff** `name|id`
- **hp** `number`
- **filter** `EXACT|PLAYER` _optional_

Returns: `table`

Returns a table of the members that are within the distance specified of the unit, have a health percentage below or equal to `hp`, and also have the buff that is specified.

```lua
local members_with_buff_below_50 = ni.members.inrangewithbuffbelow("player", 10, "Riptide", 50, "PLAYER"); 
-- Returns a table of all the members within 10 yards of the player with a health percentage below 
-- or equal to 50 that have the buff Riptide which was cast by the player
```

## inrangewithoutbuffbelow

Arguments:

- **unit** `guid|token`
- **distance** `number`
- **buff** `name|id`
- **hp** `number`
- **filter** `EXACT|PLAYER` _optional_

Returns: `table`

Returns a table of the members that are within the distance specified of the unit, have a health percentage below or equal to `hp`, and also do not have the buff that is specified.

```lua
local members_without_buff_below_50 = ni.members.inrangewithoutbuffbelow("player", 10, "Riptide", 50); 
--	Returns a table of all the members within 10 yards of the player with a health percentage below 
-- or equal to 50 that do not have the buff Riptide
```

## inrangewithdebuff

Arguments:

- **unit** `guid|token`
- **distance** `number`
- **debuff** `name|id`
- **filter** `EXACT|PLAYER` _optional_

Returns: `table`

Returns a table of the members that are within the distance specified of the unit and also have the debuff that is specified.

```lua
local members_with_scorch = ni.members.inrangewithdebuff("target", 10, "Scorch", "PLAYER"); 
--	Returns a table of all the members within 10 yards of the target that 
-- have the debuff Scorch which was cast by the player
```

## inrangewithdebuffbelow

Arguments:

- **unit** `guid|token`
- **distance** `number`
- **debuff** `name|id`
- **hp** `number`
- **filter** `EXACT|PLAYER` _optional_

Returns: `table`

Returns a table of the members that are within the distance specified of the unit, below the hp percentage specified, and also have the debuff that is specified.

```lua
local members_with_scorch_below_50 = ni.members.inrangewithdebuffbelow("target", 10, "Scorch", 50, "PLAYER"); 
--	Returns a table of all the members within 10 yards of the target that have the debuff 
-- Scorch which was cast by the player and have less than 50% health
```

## inrangewithoutdebuff

Arguments:

- **unit** `guid|token`
- **distance** `number`
- **debuff** `name|id`
- **filter** `EXACT|PLAYER` _optional_

Returns: `table`

Returns a table of members that are within the distance specified of the unit and do not have the debuff that is specified.

```lua
local members_without_curse = ni.members.inrangewithoutdebuff("player", 10, "Curse of Tongues", "PLAYER"); 
-- Returns a table of all the members within 10 yards of the player that 
-- do not have the Curse of Tongues debuff cast by the player
```

## inrangewithoutdebuffbelow

Arguments:

- **unit** `guid|token`
- **distance** `number`
- **debuff** `name|id`
- **hp** `number`
- **filter** `EXACT|PLAYER` _optional_

Returns: `table`

Returns a table of members that are within the distance specified of the unit, have less than or equal to the specified HP percentage, and do not have the debuff that is specified.

```lua
local members_without_curse_below_50_percent_hp = ni.members.inrangewithoutdebuffbelow("player", 10, "Curse of Tongues", 50, "PLAYER"); 
-- Returns a table of all the members within 10 yards of the player that have less than or equal to 50% HP, 
-- and do not have the Curse of Tongues debuff cast by the player
```

## addcustom

Arguments:

- **unit** `string`: the name of the unit to add as a custom member.
- **guid** `string` _optional_: the GUID of the unit to add as a custom member. If not provided, it will be obtained using `UnitGUID(unit)`.

This function adds a custom member to the members table. It creates a new GroupMember object with the provided unit and guid and adds it to the members table. If the custom member was successfully added, the members table is updated using the `updatemembers` function.

## removecustom

Arguments:
- **unit** `string`: the name of the unit to remove from the members table.

This function removes a custom member from the members table. It loops through the members table and removes the first element that matches the provided unit. It also removes the unit from the `cache` table in the `memberssetup` object. If a custom member was successfully removed, the members table is updated using the `updatemembers` function.