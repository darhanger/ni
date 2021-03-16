# Object Manager

> All functions when used will be prepended with `ni.objectmanager`.

---

## contains

Arguments:

- **object** `token|guid|name`

Returns: `boolean`

Returns true or false if the value passed is within the object manager table (The object is around you).

```lua
if ni.objectmanager.contains("The Lich King") then
	--The Lich King is within our memory scope distance
end
```

## objectGUID

Arguments:

- **object** `token|guid|name`

Returns: `string`

Returns the objects GUID of the value passed, as long as they're within the object manager table.

```lua
local lich_king = ni.objectmanager.objectGUID("The Lich King");
if lich_king ~= nil then
	--The Lich King is within our memory scope distance, and we now have his GUID to work with on other functions.
end
```

---

> The object manager also features a set of functions and special way to provide an object oriented type programming for the lua. All of the way to access this feature is via `ni.objects`. Functions, variables and examples are as follows:

## guid

Type:

- **variable**

Returns: `string`

This is the variable that returns the GUID of the object accessed.

```lua
local tar = ni.objects["target"];
if tar:exists() then
	print(tar.guid) --Would print the GUID of the target
end
```

## name

Type:

- **variable**

Returns: `string`

This is the variable that returns the name of the object accessed.

```lua
local tar = ni.objects["target"];
if tar:exists() then
	print(tar.name) --Would print the name of the target
end
```

## type

Type:

- **variable**

Returns: `number`

This is the variable that returns the object type of the object accessed.

```lua
local tar = ni.objects["target"];
if tar:exists() then
	if tar.type == 3 then
		--The object is a unit
	elseif tar.type == 4 then
		--The object is a player
	elseif tar.type == 5 then
		--The object is a game object
	elseif tar.type == 6 then
		--The object is a dynamic object
	end
end
```

## exists

Type:

- **function**

Arguments:

Returns: `boolean`

Returns true or false if the object is within your memory scope.

```lua
local tar = ni.objects["focus"];
if tar:exists() then
	--focus object exists
end
```

## info

Type:

- **function**

Arguments:

Returns: `multi-ret`

Returns detailed information about the object.

```lua
local tar = ni.objects["focus"];
if tar:exists() then
	local x, y, z, facing, type, target, height = tar:info()
	if target ~= 0 then
		--We have the target GUID of the object.
	end
end
```

## hp

Type:

- **function**

Arguments:

Returns: `number`

Returns the objects health percentage.

```lua
local tar = ni.objects["The Lich King"];
if tar:exists() and tar:hp() < 20 then
	--Object has less than 20% health
end
```

## power

Type:

- **function**

Arguments:

- **type** `string` _optional_

Returns: `number`

Returns the current percent of the objects power (e.g. mana, energy, focus, etc.).

```lua
local tar = ni.objects["target"];
if tar:exists() and tar:power("mana") >= 80 then
	--Target has, or has more than, 80% mana
end
```

## powermax

Type:

- **function**

Arguments:

- **type** `string` _optional_

Returns: `number`

Returns the maximum of the objects power (e.g. mana, energy, focus, etc.).

```lua
local tar = ni.objects["target"];
if tar:exists() and tar:powermax("mana") >= 20000 then
	--Target has, or has more than, 20k mana
end
```

## unit

Type:

- **function**

Arguments:

Returns: `boolean`

Returns true or false if the object is a unit.

```lua
local tar = ni.objects["target"];
if tar:exists() and tar:unit() then
	--Object is a unit.
end
```

## player

Type:

- **function**

Arguments:

Returns: `boolean`

Returns true or false if the object is a player.

```lua
local tar = ni.objects["target"];
if tar:exists() and tar:player() then
	--Object is a player.
end
```

## canattack

Type:

- **function**

Arguments:

- **string** `token|guid` _optional_

Returns: `boolean`

Returns true or false if the object can attack the token specified, or player if empty.

```lua
local tar = ni.objects["target"];
if tar:exists() and tar:canattack() then
	--Object can attack the player.
end
```

## canassist

Type:

- **function**

Arguments:

- **string** `token|guid` _optional_

Returns: `boolean`

Returns true or false if the object can assist the token specified, or player if empty.

```lua
local tar = ni.objects["target"];
if tar:exists() and tar:canassist() then
	--Object can assist the player (They're friendly).
end
```

## los

Type:

- **function**

Arguments:

- **string** `token|guid` _optional_

Returns: `boolean`

Returns true or false if the object is in line of sight to the token specified, or player if empty.

```lua
local tar = ni.objects["target"];
if tar:exists() and tar:los() then
	--Object is in line of sight to the player.
end
```

## cast

Type:

- **function**

Arguments:

- **string or number** `name|id`

Returns: `void`

Function to cast a spell onto the object.

```lua
local tar = ni.objects["The Lich King"];
if tar:exists() and tar:los() then
	tar:cast("Frost Bolt");
end
```

## castat

Type:

- **function**

Arguments:

- **string or number** `name|id`

Returns: `void`

Function to cast a spell at the location of the object if they're in line of sight.

```lua
local tar = ni.objects["The Lich King"];
if tar:exists() then
	tar:cast("Blizzard");
end
```

## combat

Type:

- **function**

Arguments:

Returns: `boolean`

Returns true or false if the object is in combat.

```lua
local tar = ni.objects["The Lich King"];
if tar:exists() and tar:combat() then
	--Object is in combat.
end
```

## isbehind

Type:

- **function**

Arguments:

- **target** `token|guid` _optional_
- **reverse** `boolean` _optional_

Returns: `boolean`

Returns true or false if the object is behind the token specified, or player if empty. If reverse is specified as true, it's the opposite direction (i.e. the player is behind the object).

```lua
local tar = ni.objects["target"];
if tar:exists() then
	if tar:isbehind("player", true) then
		--The player is behind the object.
	end
	if tar:isbehind() then
		--The object is behind the player
	end
end
```

## isfacing

Type:

- **function**

Arguments:

- **target** `token|guid` _optional_
- **reverse** `boolean` _optional_

Returns: `boolean`

Returns true or false if the object is facing the token specified, or player if empty. If reverse is specified as true, it's the opposite direction (i.e. the player is facing the object).

```lua
local tar = ni.objects["target"];
if tar:exists() then
	if tar:isfacing("player", true) then
		--The player is facing the object.
	end
	if tar:isfacing() then
		--The object is facing the player
	end
end
```

## distance

Type:

- **function**

Arguments:

- **string** `token|guid` _optional_

Returns: `number`

Returns the distance of the object to the token specified, or player if empty.

```lua
local tar = ni.objects["target"];
if tar:exists() and tar:distance() < 3 then
	--Object is within 3 yards of the player.
end
```

## range

Type:

- **function**

Arguments:

- **string** `token|guid` _optional_

Returns: `boolean`

Returns true or false if the object is within 40 yards to the token specified, or player if empty.

```lua
local tar = ni.objects["target"];
if tar:exists() and tar:range() then
	--Object is within 40 yards of the player.
end
```

## creator

Type:

- **function**

Arguments:

Returns: `string`

Returns the GUID of the objects creator if they have one.

```lua
local tar = ni.objects["target"];
if tar:exists() then
	local creator = tar:creator();
	if creator then
		--The object has a creator, and now we have their GUID
	end
end
```

## target

Type:

- **function**

Arguments:

Returns: `string`

Returns the GUID of the objects target if they have one, otherwise "0x0000000000000000".

```lua
local tar = ni.objects["target"];
if tar:exists() then
	local target = tar:target();
	if UnitExists(target) then
		--The object has a target, and now we have their GUID
	end
end
```

## location

Type:

- **function**

Arguments:

Returns: `table`

Returns a table of the objects location along with their facing.

```lua
local tar = ni.objects["target"];
if tar:exists() then
	local location = tar:location();
	--Do something with the location.x, location.y, location.z and location.r of the object
end
```

---

> Another example of iterating the objects can be like what is within the fishing script. While iterating it this way, you can access all the above listed variables and functions the same. Example as follows:

```lua
local playerguid = UnitGUID("player");
for k, v in pairs(ni.objects) do
	if type(k) ~= "function" and (type(k) == "string" and type(v) == "table") then
		if v.name == "Fishing Bobber" then
			local creator = v:creator();
			if creator == playerguid then
				local ptr = ni.memory.objectpointer(v.guid);
				if ptr then
					local result = ni.memory.read("byte", ptr, offset);
					if result == 1 then
						ni.player.interact(v.guid);
						return true;
					end
				end
			end 
		end
	end
end
```