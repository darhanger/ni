# Rune

> All functions when used will be prepended with `ni.rune`.

---

## available

Arguments:

Returns: `number`

Calculates the number of available runes.

```lua
if ni.rune.available() == 6 then
  -- Player has all 6 runes available
end
```

## deathrunes

Arguments:

Returns: `number`

Calculates the number of death runes.

```lua
if ni.rune.deathrunes() == 4 then
  -- Player has 4 of their runes as death runes
end
```

## bloodrunecd

Arguments:

Returns: `number`, `number`

Returns the number of Blood Runes on and off cooldown.

```lua
local offcd, oncd = ni.rune.bloodrunecd()
  -- 1, 1 or 2, 0 or 0, 2
```

## deathrunecd

Arguments:

Returns: `number`, `number`

Returns the number of Death Runes on and off cooldown.

```lua
local offcd, oncd = ni.rune.deathrunecd()
  -- 1, 1 or 2, 0 or 0, 2
```

## frostrunecd

Arguments:

Returns: `number`, `number`

Returns the number of Frost Runes on and off cooldown.

```lua
local offcd, oncd = ni.rune.frostrunecd()
  -- 1, 1 or 2, 0 or 0, 2
```

## unholyrunecd

Arguments:

Returns: `number`, `number`

Returns the number of Unholy Runes on and off cooldown.

```lua
local offcd, oncd = ni.rune.unholyrunecd()
  -- 1, 1 or 2, 0 or 0, 2
```
