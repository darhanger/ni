# Debug

> All functions when used will be prepended with `ni.debug`.

---

## print

Arguments:

- **message** `string`

Returns: `void`

Prints the message if `ni.vars.debug` is set to true.

```lua
ni.debug.print("Test") -- Won't print
ni.vars.debug = true
ni.debug.print("Test") -- Will print
```

## log

Arguments:

- **message** `string`
- **error** `boolean` _optional_

Returns: `void`

Prints the message in the console of ni's application. Error is optional, true for error message and empty or false or normal.

```lua
ni.debug.log("Test")
```
