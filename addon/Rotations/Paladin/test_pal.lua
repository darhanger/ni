local a = {
    "Pause",
    "test_",
}
local b = {
    ["Pause"] = function()
        if IsMounted()
        or UnitInVehicle("player")
        or ni.player.buff(430)
        or ni.player.buff(433)
        or ni.player.issilenced()
        or ni.player.isconfused()
		or ni.player.isfleeing()
        or ni.player.isstunned()
        or ni.player.iscasting()
        or ni.player.ischanneling()
        or UnitIsDeadOrGhost("player")
		or IsLeftShiftKeyDown() then
            return true
        end
    end,
    ["test_"] = function ()
        if ni.members.inrangebelow(ni.members[1].unit, 2, 10)
        and ni.spell.available(48785)
        and ni.spell.valid(ni.members[1].unit, 48785, false, true, true) then
            ni.spell.cast(48785, ni.members[1].unit)
        end
    end
}
ni.bootstrap.profile("test_pal", a, b)