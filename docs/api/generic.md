# Generic

> This is for generic functions that don't fit in the categories.

---

## delayfor

Arguments:

- **delay** `number`
- **func** `function`

Returns: `bool`

Delays a call for specified time on a specific function.

```lua
ni.delayfor(2, function()
  ni.spell.cast("Shadow Bolt", "target")
end);
-- Shadow Bolt will be casted 2 seconds from now
```

## require

Arguments:

- **filename** `string`

Returns: `return from file loaded`

Ni's version of lua's require. It's used to load files into another chunk giving access to other functions without being loaded many times as it's cached each initial load (reload will clear out the cache). The string passed for the file can be the filename without the .lua extension, or it can include the .lua extension. It will search in the Data folder for this file. Additionally, you can use absolute paths (for example C:\Some Folder\file.lua).

```lua
local data = ni.utils.require("Example"); --This will load the data file called Example.lua from the data folder into the local variable data

print(example.version()); --In the example file there is already a function called "version", so here it would print the version
```
