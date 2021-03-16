# Memory

> This is for the memory reading functions. Each function is prepended with `ni.memory`.

---

## baseaddress

Arguments:

Returns: `number, string`

Returns the base address of the client. Return 1 is the numeric value, return 2 is the string formatted value.

```lua
local base = ni.memory.baseaddress();
if ni.memory.read("byte", base + 0x12345678) == 0xCC then
	--Value at base + 0x12345678 is 0xCC
end
```

## objectpointer

Arguments:

- **object** `token|guid`

Returns: `number, string`

Returns the objects pointer. Return 1 is the numeric value, return 2 is the string formatted value.

```lua
local ptr = ni.memory.objectpointer("player");
```

## read

Arguments:

- **readtype** `string (see below)`
- **address** `number`
- **...** `offsets to add to the address to read off of` _optional_

Returns: `readtype value`

Returns the memory value in the type specified from the first argument.

```lua
local ptr = ni.memory.objectpointer("player");
local height = ni.memory.read("float", ptr, 0x8F8); --Gets the players height (MoP offset)
```

---

> The following strings are the accepted read type arguments for the read function.

## read types

```lua
"bool" --true/false formatted
"byte" --number formatted
"string" --string formatted
"float" --number formatted
"double" --number formatted
"int16"/"short" --number formatted
"int32"/"int" --number formatted
"int64" --string formatted formatted
"uint16"/"ushort" --number formatted
"uint"/"uint32" --number formatted
"uint64"/"GUID" --string formatted
```