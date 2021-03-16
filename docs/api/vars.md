# Vars

> All variables when used will be prepended with `ni.vars`.

---

## general

```lua
ni.vars.latency -- interval between executing the rotation
ni.vars.interrupt -- could be `all` or `wl` or `bl`
ni.vars.build -- build version of currently running client
ni.vars.debug -- true/false to print when using ni.debug.print
ni.vars.customtarget -- token or guid of custom target
```

## hotkeys

```lua
ni.vars.hotkeys.aoe
ni.vars.hotkeys.cd
ni.vars.hotkeys.pause
ni.vars.hotkeys.custom
```

## profiles

```lua
ni.vars.profiles.primary --Name of the primary profile
ni.vars.profiles.secondary --Name of the secondary profile
ni.vars.profiles.active --Name of the active profile
ni.vars.profiles.generic --Name of the generic profile
ni.vars.profiles.genericenabled --Generic profile is enabled
ni.vars.profiles.interrupt --Interrupt engine is enabled
ni.vars.profiles.enabled --Active profile is enabled
ni.vars.profiles.useEngine --Enables/Disables the members table
ni.vars.profiles.delay --Time to delay the profile execution until (should not be set via the variable itself)
```

## units

```lua
ni.vars.units.follow
ni.vars.units.followEnabled
ni.vars.units.mainTank
ni.vars.units.mainTankEnabled
ni.vars.units.offTank
ni.vars.units.offTankEnabled
```

## combat

```lua
ni.vars.combat.started -- true/false for when player regen enabled/disabled (combat)
ni.vars.combat.time -- time since combat started
ni.vars.combat.melee -- true/false for deciding movement using follow feature
ni.vars.combat.cd -- true/false for cooldown toggle enabled
ni.vars.combat.aoe -- true/false for aoe toggle enabled
ni.vars.combat.casting --  true/false for spell sent to server
```
