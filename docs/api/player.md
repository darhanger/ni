# Player

> All functions when used will be prepended with `ni.player`.

Apart from functions listed below, it's possible to call `ni.player` as a shorthand for calling any function in [Unit](api/unit.md) and passing `player` as the first argument.

```lua
ni.player.buff("Life Tap") -- Same as calling ni.unit.buff("player", "Life Tap")
ni.player.hp() -- Same as calling ni.unit.hp("player")
```

---
## moveto

Arguments:

- **unit** `token|guid|x,y,z`

Returns: `void`

Moves the player to specific target or coordinates.

```lua
ni.player.moveto("target")
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

## stopmoving

Arguments:

Returns: `void`

Stops all movement from the player.

```lua
ni.player.stopmoving()
```

## inparty

Returns: `boolean`

Checks if the player is currently in a party or raid.

```lua
if ni.player.inparty() then
  -- Player is in a party or raid
end
```

## isswimming

Returns: `boolean`

Checks if the player is currently swimming.

```lua
if ni.player.isswimming() then
  -- Player is swimming
end
```

## isoutdoors

Returns: `boolean`

Checks if the player is currently outdoors.

```lua
if ni.player.isoutdoors() then
  -- Player is outdoors
end
```

## ismounted

Returns: `boolean`

Checks if the player is currently mounted.

```lua
if ni.player.ismounted() then
  -- Player is mounted
end
```

## target

Arguments:

- **target** `token|guid`

Returns: `void`

Sets the specified unit to be the player's target.

```lua
ni.player.target("focus") -- Sets the player's target to the focus target
ni.player.target("party1") -- Sets the player's target to the first party membe
```

## runtext

Arguments:

- **text** `string`

Returns: `void`

Runs the passed text as a macro.

```lua
ni.player.runtext("/s Hello") -- writes "Hello" to Say channel.
```

## getspec

Returns: `string`

Determines the player's current specialization based on the talent points distribution.

```lua
local spec = ni.player.getspec()
if spec == "WarriorProtection" then
  -- Player is spec'd into Warrior Protection
end
```

## melee

Returns: `boolean`

Checks if the player's class and specialization are melee-oriented.

```lua
if ni.player.melee() then
  -- Player is a melee class/spec
end
```

## tank

Returns: `boolean`

Checks if the player is currently a tank based on their class, spec, and active auras.

```lua
if ni.player.tank() then
  -- Player is currently tanking
end
```

## caster

Returns: `boolean`

Checks if the player's class and specialization are caster-oriented.

```lua
if ni.player.caster() then
  -- Player is a caster class/spec
end
```

## getskillinfo

Arguments:

- **prof** `string`

Returns: `number`

Gets the skill level of the specified profession.

```lua
local skillLevel = ni.player.getskillinfo("Blacksmithing")
if skillLevel >= 300 then
  -- Player's Blacksmithing skill is at least 300
end

local skillLevel = ni.player.getskillinfo(GetSpellInfo(7411))
if skillLevel >= 300 then
  -- Player's Enchanting skill is at least 300
end
```

## getenchantid

Arguments:

- **slotId** `number`

Returns: `number`

Retrieves the enchantment ID for the item in the specified inventory slot.

```lua
local enchantId = ni.player.getenchantid(16) -- Gets the enchantment ID for the main hand weapon
if enchantId == 2673 then
  -- Player's main hand weapon has the Crusader enchant
end
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

## useinventoryitem

Arguments:

- **item** `id`

Returns: `void`

Uses the item from equipped items.

```lua
ni.player.useinventoryitem(10) -- Activates Gloves on-use
ni.player.useinventoryitem(13) -- Activates First Trinket slot
```

## interact

Arguments:

- **unit** `token|guid`

Returns: `void`

Interacts with the specified unit (e.g. opens a dialog with NPC, loot a container).

```lua
ni.player.interact("target")
```

## hasglyph

Arguments:

- **glyph** `id`

Returns: `boolean`

Checks if a player has equipped a specific glyph.

```lua
if ni.player.hasglyph(42455) then
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

## checkslots

Returns: `number`

Check free slots in player invetory
```lua
if ni.player.checkslots() < 2 then
	-- Player have less the 2 free slots
end
```

## cancelbuff

Arguments:

- **id** `id`

Canceles a specific buff on the player

```lua
if ni.player.buff(48443) then
	ni.player.cancelbuff(48443)
end
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

## ismoving

Returns: `boolean`

Checks if the player is currently moving or falling.

```lua
if ni.player.ismoving() then
  -- Player is moving or falling
end
```

## guid

Returns: `string`

Retrieves the GUID (Globally Unique Identifier) of the player.

```lua
local playerGUID = ni.player.guid()
-- Use playerGUID as needed
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