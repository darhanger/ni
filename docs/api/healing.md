# Healing

> All functions when used will be prepended with `ni.healing`.

---

## debufftoblacklist

Arguments:

- **id** `number`: the ID of the debuff to add to the blacklist.

Use this function to add a debuff ID to the blacklisteddispels table.

```lua
local bad = { 47867, 47813, 47864 };
for i = 1, #bad
	local badDebuff = bad[i];
	if UnitLevel("player") >= 80 then
		ni.healing.debufftoblacklist(badDebuff)
	end
end
```

## dontdispel

Arguments:

- **t** `string`: the unit to check.

Returns:

- `boolean`: true if the unit's debuff is blacklisted or not dispellable, false otherwise.

Use this function to check if a unit's debuff is blacklisted or not dispellable.

```lua
	if ni.healing.dontdispel("player") then
		-- do stuff
	end
```

## candispel

Arguments:

- **t** `string`: the unit to check.

Returns:

- `boolean`: true if the unit's debuff is dispellable, false otherwise.

Use this function to check if a unit's debuff is dispellable.

```lua
	if ni.healing.candispel("player") then
		-- do stuff
	end
```

## debufftypedispellable

Arguments:

- **debufftype** `string`: the debuff type to check.

Returns:

- `boolean`: true if the debuff type is dispellable for the current class, false otherwise.

Use this function to check if a debuff type is dispellable for a specific class.

```lua
	if healing.debufftypedispellable("Poison") then
		-- Your class can dispel poison debuffs
	end
```

# Tanks

> All functions when used will be prepended with `ni.tanks()`.

---

Returns:

If the main tank and off-tank units have been manually assigned in the game UI, this function will return those units. If not, the function will attempt to find the two tanks based on the units currently in the player's party/raid. If there are not enough tanks in the group, the function will return the two tanks with the highest maximum health.

```lua
local mainTank, offTank = ni.tanks()
```


## Example

Apart from functions listed below, it's possible to call `mainTank` or `offTank` as a shorthand for calling any function in [Members](api/members.md) and passing `mainTank` or `offTank` as the first argument.

```lua
local mainTank, offTank = ni.tanks()
if mainTank then
	if mainTank:combat()
	and mainTank:debufftype("Poison")
	and mainTank:dispel() then
		-- do stuff
	end
end
if offTank then
	if offTank:combat()
	and not offTank:auras("48066||6788") then
		ni.spell.cast(48066, offTank.unit)
	end
end
```

```lua
-- Get the main tank and off-tank units
local mainTank, offTank = ni.tanks()

-- If we were able to determine the tanks, we can use them in combat
if mainTank then
	if UnitExists(mainTank.unit)
	and mainTank:valid(48378, false, true) then -- check valid one time for all healing spells
		if mainTank:hp() < 40
		and not ni.player.ismoving()
		and ni.spell.available(48378) then
			ni.spell.cast(48378, mainTank.unit)
		end			
		if mainTank:hp() < 90 
		and ni.spell.available(48441)
		and not mainTank:buff(48441, "player") then
			ni.spell.cast(48441, mainTank.unit)
		end	
	end
end
if offTank then
	if UnitExists(offTank.unit)
	and offTank:valid(48378, false, true) then -- check valid one time for all healing spells
		if offTank:hp() < 70
		and ni.spell.available(48451) 
		and (not offTank:buff(48451, player) 
		or ni.unit.buffstacks(offTank.unit, 48451, "player") < 3) then
			ni.spell.cast(48451, offTank.unit)
		end			
		if offTank:hp() < 90 
		and ni.spell.available(48441)
		and not offTank:buff(48441, "player") then
			ni.spell.cast(48441, offTank.unit)
		end	
	end
end
```