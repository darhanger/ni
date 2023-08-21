# Player

> All functions when used will be prepended with `ni.player`.

Apart from functions listed below, it's possible to call `ni.player` as a shorthand for calling any function in [Unit](api/unit.md) and passing `player` as the first argument.

```lua
ni.player.buff("Life Tap") -- Same as calling ni.unit.buff("player", "Life Tap")
ni.player.hp() -- Same as calling ni.unit.hp("player")
```

---
## cancelbuff

Arguments:

- **id** `id`

Canceles a specific buff on the player

```lua
if ni.player.buff(48443) then
	ni.player.cancelbuff(48443)
end
```

## clickat

Arguments:

- **unit** `token|guid|x,y,z|mouse`

Returns: `void`

Clicks at the specific location.

```lua
ni.player.clickat("target") --Clicks at the targets x/y/z
ni.player.clickat("mouse") --Clicks at the mouses current location
```

## checkslots

Returns: `number`

Check free slots in player invetory
```lua
if ni.player.checkslots() < 2 then
	-- Player have less the 2 free slots
end
```

## hasglyph

Arguments:

- **glyph** `id`

Returns: `boolean`

Checks if a player has equipped a specific glyph.

```lua
if ni.player.hasglyphWotlk(42455) then
  -- Player has Glyph of Conflagrate
end
```

## hasitem

Arguments:

- **item** `id`

Returns: `boolean`

Checks if a player has a specific item.

```lua
if ni.player.hasitem(51378) then
  -- Player has item Medallion of the Horde
end
```

## hasitemequipped

Arguments:

- **item** `id`

Returns: `boolean`

Checks if a player has equipped a specific item.

```lua
if ni.player.hasitemequipped(51378) then
  -- Player has equipped item Medallion of the Horde
end
```

## hassetequiped

Arguments:

- **table** `id`
- **pieces** `number`


Returns: `boolean`

Checks if a player has equipped a specific set.

```lua
local t8 = {46122, 46121, 46120, 46119, 46118, 45339, 45338, 45337, 45336, 45335};

if ni.player.hassetequiped(t8, 4) then
  -- Player has equipped 4 pieces tier 8
end
```

## interact

Arguments:

- **unit** `token|guid`

Returns: `void`

Interacts with the specified unit (e.g. opens a dialog with NPC, loot a container).

```lua
ni.player.interact("target")
```

## itemicon

- **item** `id`
- **width** `number`
- **height** `number`

Returns: `string`

Uses for drowing item icon in GUI or tooltips.

```lua
	{ type = "entry", text = ni.player.itemicon(57191, 22, 22).." Heal Potion", tooltip = "Use Heal Potions (if you have) when player |cff00D700HP|r < %.",  enabled = true, value = 30, min = 20, max = 60, step = 1, width = 40, key = "healpotionuse" },
```

## itemcd

Arguments:

- **slot** `id`

Returns: `number`

Checks if a specific inventory item is on cooldown and returns the remaining time.

```lua
if ni.player.itemcd(41119) > 0 then
  -- Saronite Bomb is on cooldown
end
```

## itemready

Arguments:

- **slot** `id`

Returns: `boolean`

Checks if a specific inventory item is ready. Player have item, its off cooldown, and can be used.

```lua
if ni.player.itemready(41119) then
  -- Player have bomb and can use it
end
```

## lookat

Arguments:

- **unit** `token|guid`
- **inv** `boolean` _default: false_

Returns: `void`

Looks in the direction of the unit. Can be inversed by passing `true` as second argument.

```lua
ni.player.lookat("target")
ni.player.lookat("target", true) --Looks away from the target
```

## moveto

Arguments:

- **unit** `token|guid|x,y,z`

Returns: `void`

Moves the player to specific target or coordinates.

```lua
ni.player.moveto("target")
```

## petcd

Arguments:

- **spell** `id|name`

Returns: `number`

Checks if a specific inventory item is on cooldown and returns the remaining time.

```lua
if ni.player.petcd("Devour Magic") > 0 then
  -- Devour Magic is on cooldown
end
```

## runtext

Arguments:

- **text** `string`

Returns: `void`

Runs the passed text as a macro.

```lua
ni.player.runtext("/s Hello") -- writes "Hello" to Say channel.
```

## slotcastable

Arguments:

- **slot** `id`

Returns: `boolean`

Checks if the players current slot is a castable spell or not.

```lua
if ni.player.slotcastable(10) then
  -- Player has a Spell on his hands (slot 10)
end
```

## slotcd

Arguments:

- **slot** `id`

Returns: `number`

Checks if a specific equipped slot is on cooldown and returns the remaining time.

```lua
if ni.player.slotcd(10) > 0 then
  -- Gloves on-use is on cooldown
end

if ni.player.slotcd(10) == 0 then
  -- Gloves on-use is off cooldown
end
```

## slotusable

Arguments:

- **slot** `id`

Returns: `boolean`

Checks if the players current slot is a castable spell and it not on cooldown.

```lua
if ni.player.slotusable(10) then
  -- Gloves ready for use
end
```

## stopmoving

Arguments:

Returns: `void`

Stops all movement from the player.

```lua
ni.player.stopmoving()
```

## target

Arguments:

- **unit** `token|guid`

Returns: `void`

Sets the specified unit to be player's target.

```lua
ni.player.target("arena2")
```

## useinventoryitem

Arguments:

- **item** `id`

Returns: `void`

Uses the item from equipped items.

```lua
ni.player.useinventoryitem(10) -- Activates Gloves on-use
ni.player.useinventoryitem(13) -- Activates First Trinket slot
```

## useitem

Arguments:

- **item** `id|name`
- **target** `token|guid`

Returns: `void`

Uses the item from inventory. If unit is specified the item will be used on it.

```lua
ni.player.useitem(36892) -- Uses Healthstone
ni.player.useitem(36895, "focus") -- Places a Demonic Soulstone on focus
```

## movingfor

Arguments:

- **duration** `number`

Returns: `boolean`

Returns true or false if the player has been moving for the duration specified.

```lua
if ni.player.movingfor(2) then
	--The player has been moving for at least 2 seconds
end
```

## getmovingtime

Arguments:

Returns: `number`

Returns the moving time that the player has been moving for.

```lua
if ni.player.getmovingtime() > 60 then
	--The player has been moving for more than 60 seconds
end
```