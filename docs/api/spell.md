# Spell

> All functions when used will be prepended with `ni.spell`.

---

## available

Arguments:

- **spell** `id|string`
- **stutter** `boolean` _default: true_

Returns: `boolean`

Checks if specified spell is available to use. Includes checks such as:

- [`ni.spell.gcd`](api/spell.md#gcd)
- [`ni.vars.combar.casting`](api/vars.md)
- [`ni.spell.cd`](api/spell.md#cd)
- [`ni.stopcastingtracker.shouldstop`](api/stopcasting.md)
- [`ni.player.powerraw`](api/player.md)
- [`ni.player.hpraw`](api/player.md)

!> [`ni.spell.available`](api/spell.md#available) is not the same as [`ni.spell.valid`](api/spell.md#valid).

```lua
if ni.spell.available("Fear") then
  -- Fear passess all the checks and is available
end
```

## cast

Arguments:

- **spell** `id|string`
- **target** `token|guid`

Returns: `void`

Casts the specified spell. If the target is provided it'll cast on that target, otherwise spell wll be casted on self.

```lua
ni.spell.cast("Shadow Bolt", "target")
```

## delaycast

Arguments:

- **spell** `id|string`
- **target** `token|guid`
- **delay** `number` _optional_

Returns: `boolean`

Just like cast, however you can specify delay, and if the time since it's last cast was over the delay, it'll cast the spell along with returning true. If it's under the delay, the function will return false.

```lua
if ni.spell.delaycast("Shadow Bolt", "target", 1.5) then
	--It's been more than 1.5 seconds since we last cast 1.5, so it cast
else
	--Spell did not cast because it's been less than 1.5 seconds since last cast
end
--Other usage just like normal cast, just to ensure it doesn't cast if under the delay time
if true then
	ni.spell.delaycast("Shadow Bolt", "target", 1.5)
end
```

## bestaoeloc

- **distance** `number`
- **radius** `number`
- **friendly** `boolean` _optional_
- **minimumcount** `number` _optional_
- **inc** `number` _optional_
- **zindex_inc** `number` _optional_

Returns: `X/Y/Z`

This function uses the internal check for sweeping around the player to search for the best X/Y/Z coordinate to place an AoE at. The distance and radius are the only two required, the rest are optional. Friendly is to check for units you can assist if true, or that you can attack if false (default: false). minimumcount is the minimum number of units within the radius to be counted as a good location (default: 2). inc is for the incremental looping that is done, the higher the number the less efficient the scan is, but the quicker it is done; for example if a distance of 30 is passed and the increment is 1.5 it would go -30, -28.5, -27, -25.5 ... to +30 (default: 1). zindex_inc is for the readjustment to obtain a new Z for each position checked, meaning the point where the ground actually is, each point uses +increment and -increment from the players Z and uses the hit location as the new z (default: 20).

```lua
local x, y, z = ni.spells.bestaoeloc(30, 4, false, 6);
--This would return nil if there is no good location, otherwise x, y, z will be the best location to hit at least 6 mobs within a location that is at least 30 yards from the player and has a splash radius of 4 yards
```

## castharmfulatbest

- **spell** `id|string`
- **distance** `number`
- **radius** `number`
- **minimumcount** `number` _optional_
- **inc** `number` _optional_
- **zindex_inc** `number` _optional_

Returns: `void`

This function will cast the spell specified at the best location matching the requirements. See above for what each argument is.

```lua
ni.spell.cast("Hurricane", 36, 4, 4); --On a druid this would cast hurricane at the best location within 36 yards of the player that has at least 4 mobs to be hit
```

## casthelpfulatbest

- **spell** `id|string`
- **distance** `number`
- **radius** `number`
- **minimumcount** `number` _optional_
- **inc** `number` _optional_
- **zindex_inc** `number` _optional_

Returns: `void`

This function will cast the spell specified at the best location matching the requirements. See above for what each argument is.

```lua
ni.spell.cast("Healing Rain", 36, 4, 5); --On a shaman this would cast healing rain at the best location within 36 yards of the player that has at least 5 friendlies to be hit by the heal
```

## castat

Arguments:

- **spell** `id|string`
- **target** `token|guid|mouse`
- **offset** `number`

Returns: `void`

Casts specified spell which required click on the ground (e.g. Death and Decay, Rain of Fire, Blizzard).

```lua
ni.spell.castat("Rain of Fire", "target")
```

## castatqueue

Arguments:

- **spell** `id|string`
- **target** `token|guid|mouse`

Returns: `void`

Queues a specified spell to be casted on the ground once it's available.

```lua
ni.spell.castatqueue("Blizzard", "target")
```

## castqueue

Arguments:

- **spell** `id|string`
- **target** `token|guid`

Returns: `void`

Queues a specified spell to be casted once it's available.

```lua
ni.spell.castqueue("Fear", "target")
```

## castspells

Arguments:

- **spell** `id|string`
- **target** `token|guid`

Returns: `void`

Casts specified spells separated by pipe (`|`). If the target is provided it'll cast on that target, otherwise spells wll be casted on self. Does not work if spells more than one spell triggers global cooldown.

```lua
ni.spell.castspells("Heroic Strike|Bloodthirst", "target")
```

## casttime

Arguments:

- **spell** `id|string`

Returns: `number`

Calculates the cast time of specified spell.

```lua
local casttime = ni.spell.casttime("Immolate") -- 1.25
```

## cd

Arguments:

- **spell** `id|string`

Returns: `number`

Calculates specified spell's cooldown. If the spell is not on cooldown returns 0.

```lua
if not ni.spell.cd(47891) then
  -- Shadow Ward is not on cooldown
end
```

## gcd

Arguments:

Returns: `boolean`

Checks if global cooldown is triggered.

```lua
if not ni.spell.gcd() then
  -- Global cooldown is not active, we can do something
end
```

## id

Arguments:

- **spellname** `string`

Returns: `number|nil`

Converts spell's name into spell id. If spell doesn't exist returns nil.

```lua
local spellid = ni.spell.id("Life Tap") -- 57946
```

## isinstant

Arguments:

- **spell** `string|id`

Returns: `boolean`

Checks if passed spell is instant cast.

```lua
if ni.spell.isinstant(57946) then
  -- Life Tap is instant spell
end
```

## stopcasting

Arguments:

Returns: `void`

Stops casting.

```lua
ni.spell.stopcasting()
```

## stopchanneling

Arguments:

Returns: `void`

Stops channeling.

```lua
ni.spell.stopchanneling()
```

## valid

Arguments:

- **spell** `id|string`
- **target** `token|guid`
- **facing** `boolean` _default: false_
- **los** `boolean` _default: false_
- **friendly** `boolean` _default: false_

Returns: `boolean`

This functions ensures that a spell can be casted at specific target. It includes checks such as:

!> [`ni.spell.valid`](api/spell.md#valid) is not the same as [`ni.spell.available`](api/spell.md#available).

- [`ni.unit.exists`](api/unit.md#exists)
- [`ni.player.los`](api/player.md#los)
- [`ni.player.isfacing`](api/player.md#isfacing)
- `IsSpellInRange`

```lua
if ni.spell.valid("Fear", "target") then
  -- Fear meets all of the critera to be valid
end
```
