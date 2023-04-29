# Members

> All functions when used will be prepended with `ni.members`.

---

## below

Arguments:

- **percent** `number`

Returns: `number`

Returns the number of members below the percentage passed as the argument.

```lua
local count = ni.members.below(90); --Count would then be the number of members below 90
```

## average

Arguments:

Returns: `number`

Returns the average health of all the members in your group.

```lua
if ni.members.average() < 20 then
	--Cast some raid wide health
end
```

## averageof

Arguments:

- **count** `number`

Returns: `number`

Returns the average health of the lowest members, averaged by the argument passed.

```lua
if ni.members.averageof(4) < 20 then
	--4 of the group members average the hp below 20%
end
```

## inrange

Arguments:

- **unit** `guid|token`
- **distance** `number`

Returns: `table`

Returns a table of the members that are within the distance specified of the unit specified.

```lua
local members_around_me = ni.members.inrange("player", 10); --Returns a table of all the members within 10 yards of the player
```

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

## inrangewithdebuff

Arguments:

- **unit** `guid|token`
- **distance** `number`
- **debuff** `name|id`
- **filter** `EXACT|PLAYER` _optional_

Returns: `table`

Returns a table of the members that are within the distance specified of the unit and also have the debuff that is specified.

```lua
local members_with_weakend_soul = ni.members.inrangewithdebuff("player", 10, "Weakend Soul"); --Returns a table of all the members within 10 yards of the player that have the debuff Weakend Soul
```

## inrangewithoutdebuff

Arguments:

- **unit** `guid|token`
- **distance** `number`
- **debuff** `name|id`
- **filter** `EXACT|PLAYER` _optional_

Returns: `table`

Returns a table of the members that are within the distance specified of the unit and also do not have the debuff that is specified.

```lua
local members_without_weakend_soul = ni.members.inrangewithoutdebuff("player", 10, "Weakend Soul"); --Returns a table of all the members within 10 yards of the player that do not have the debuff Weakend Soul
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

## unit

Type:

- **variable**

Returns: `token`

This is the variable that returns the token of the member accessed.

```lua
for i = 1, #ni.members do
	if UnitIsUnit(ni.members[i].unit, "target") then
		--This member is our target
	end
end
```

## class

Type:

- **variable**

Returns: `string`

This is the variable that returns the unlocalized class string of the member accessed (All uppercase).

```lua
for i = 1, #ni.members do
	if ni.members[i].class == "WARRIOR" then
		--This member is a warrior
	end
end
```

## name

Type:

- **variable**

Returns: `string`

This is the variable that returns the name of the member accessed.

```lua
for i = 1, #ni.members do
	if ni.members[i].name == "ni" then
		--This member is named ni
	end
end
```

## guid

Type:

- **variable**

Returns: `string`

This is the variable that returns the GUID of the member accessed.

```lua
for i = 1, #ni.members do
	if ni.members[i].guid == UnitGUID("target") then
		--This members GUID is the same as our targets GUID
	end
end
```

## range

Type:

- **variable**

Returns: `boolean`

This is the variable that returns true or false of the member accessed if they're within 40 yards and in line of sight.

```lua
for i = 1, #ni.members do
	if ni.members[i]:range() then
		--This member is in range of most spells and in line of sight
	end
end
```

## dispel

Type:

- **variable**

Returns: `boolean`

This is the variable that returns true or false of the member accessed if you can dispel them and they have a debuff that requires dispelling.

```lua
for i = 1, #ni.members do
	if ni.members[i]:dispel() then
		--This member has a debuff that can be dispelled by you
	end
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
		--This member is below 20% health
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
		--This member is not on any mobs threat list (99% chance just out of combat)
	end
end
```

## target

Type:

- **variable**

Returns: `string`

This is the variable that returns the target token of the member accessed.

```lua
for i = 1, #ni.members do
	if UnitExists(ni.members[i].target) and UnitCanAttack("player", ni.members[i].target) then
		--This member has a target we can attack
	end
end
```

## istank

Type:

- **variable**

Returns: `boolean`

This is the variable that returns true or false if the member accessed is a tank (Matches via passive buffs or role assignment).

```lua
for i = 1, #ni.members do
	if ni.members[i]:istank() then
		--This member is a tank
	end
end
```

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
		--This member has a debuff type that is Disease on them
	end
end
```

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
		--This member has a buff type that is Magic on them
	end
end
```

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
		--This member has Power Word: Shield on them cast by the player
	end
end
```

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
		--This member has Weakend Soul on them
	end
end
```