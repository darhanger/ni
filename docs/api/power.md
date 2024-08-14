# Power

> All functions when used will be prepended with `ni.power`.

If you only need to get unit's current power percent - there are two shorthand functions such as:

- [`ni.unit.power`](api/unit.md#power)
- [`ni.unit.powerraw`](api/unit.md#powerraw)
- [`ni.player.power`](api/player.md).
- [`ni.player.powerraw`](api/player.md).

By default power type will match specialization's current power type.

---

## types

A table that maps various power types to their corresponding numeric IDs.

| Power Type       | ID  |
|------------------|-----|
| `mana`           | 0   |
| `rage`           | 1   |
| `focus`          | 2   |
| `energy`         | 3   |
| `combopoints`    | 4   |
| `runes`          | 5   |
| `runicpower`     | 6   |
| `soulshards`     | 7   |
| `eclipse`        | 8   |
| `holy`           | 9   |
| `alternate`      | 10  |
| `darkforce`      | 11  |
| `chi`            | 12  |
| `shadoworbs`     | 13  |
| `burningembers`  | 14  |
| `demonicfury`    | 15  |

## current

Arguments:

- **unit** `guid|token`
- **type** `name|id`

Returns: `number`

Calculates unit's current power percent.

```lua
local power = ni.power.current("player") -- 90%
```

## currentraw

Arguments:

- **unit** `guid|token`
- **type** `name|id`

Returns: `number`

Calculates unit's current power.

```lua
local power = ni.power.currentraw("player") -- 20000 mana
```

## max

Arguments:

- **unit** `guid|token`
- **type** `name|id`

Returns: `number`

Calculates unit's maximum power.

```lua
local maxpower = ni.power.max("target")
```

## ismax

Arguments:

- **unit** `guid|token`
- **type** `name|id`

Returns: `boolean`

Checks if unit's power is at its maximum.

```lua
if ni.power.ismax("player") then
  -- Player's power is at 100%
end
```

## gettype

Arguments:

- **t** `token|guid` 

Returns: `number`

Retrieves the power type of the specified unit.

```lua
local powerType = ni.power.gettype("player")
if powerType == 0 then
  -- Player is using mana
elseif powerType == 1 then
  -- Player is using rage
end
```