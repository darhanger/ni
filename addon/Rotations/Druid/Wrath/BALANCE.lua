local queue = {
    "Pause",
    "AutoTarget",
    "sova",
    "skin",
    "smerch",
    "Faerie Fire",
    "groza",
--    "starfall",
    "Swarm",
    "Moonfire",
    "Wrath",
    "Starfire",
}
local abilities = {
    ["AutoTarget"] = function()
		if UnitAffectingCombat("player")
		 and ((ni.unit.exists("target")
		 and UnitIsDeadOrGhost("target")
		 and not UnitCanAttack("player", "target")) 
         or not ni.unit.exists("target"))
         then ni.player.runtext("/targetenemy")
		end
	end,
    ["Pause"] = function()
        if IsMounted ()
        or UnitInVehicle("player")
        or UnitIsDeadOrGhost("player")
        or ni.unit.ischanneling("player")
        or ni.unit.isfleeing("player")
        or ni.unit.issilenced("player")
        or ni.unit.isstunned("player")
        or ni.unit.iscasting("player")
        or ni.player.buff(430)
        or ni.player.buff(433)
        or ni.player.buff(43183)
        or IsLeftShiftKeyDown()
        then return true
        end
    end,
    ["sova"] = function ()
        if not ni.player.buff(24858)
        and ni.spell.available(24858)
        then ni.spell.cast(24858)
        end
    end,
    ["torns"] = function()
        if not ni.player.buff(53307)
        and ni.spell.available(53307)
        then ni.spell.cast(53307, "player")
        end
    end,
    ["skin"] = function ()
        if UnitAffectingCombat("player")
        and ni.unit.hp("player") <= 70
        and ni.spell.available(22812)
        then ni.spell.cast(22812)
        end
    end,
    ["Faerie Fire"] = function()
        if (ni.unit.isboss("target") or UnitLevel("target") >= 82)
        and ni.unit.exists ("target")
        and UnitAffectingCombat("player")
        and (not ni.unit.debuff("target", 770) or ni.unit.debuffremaining("target", 770) < 2)
        and ni.spell.available(770)
        then ni.spell.cast(770)
        end
    end,
    ["groza"] = function()
        if UnitAffectingCombat ("player")
        and not ni.player.ismoving()
        and IsLeftControlKeyDown ()
        and #ni.unit.enemiesinrange ("target", 6) >= 2
        and ni.spell.valid("target", 48461, true, true)
        and ni.spell.available(48467)
        then ni.spell.castat(48467, "target")
        end
    end,
    ["starfall"] = function()
        if UnitAffectingCombat ("player")
        and ni.unit.exists ("target")
        and IsLeftControlKeyDown ()
        and ni.spell.valid ("target", 48461)
        and #ni.unit.enemiesinrange ("target", 6) >= 2
        and ni.spell.available(53201)
        then ni.spell.castat(53201, "target")
        end
    end,
    ["Moonfire"] = function()
        if ni.unit.exists ("target")
        and ni.spell.available (48463)
        and (not ni.unit.debuff ("target", 48463) or ni.unit.debuffremaining ("target", 48463) < 2)
        and ni.spell.valid("target", 48463, true, true)
        then ni.spell.cast(48463, "target")
        end
    end,
    ["Swarm"] = function()
        if UnitAffectingCombat ("player")
        and ni.unit.exists ("target")
        and ni.spell.available (48468)
        and (not ni.unit.debuff ("target", 48468) or (ni.unit.debuff ("target", 48468) and ni.unit.debuffremaining ("target", 48468) < 2))
        and ni.spell.valid("target", 48468, true, true)
        then ni.spell.cast(48468, "target")
        end
    end,
    ["Wrath"] = function()
        if UnitAffectingCombat ("player")
        and ni.unit.exists ("target")
        and not ni.player.ismoving()
        and ni.spell.available(48468)
        and (not ni.player.buff(48518) or ni.player.buffremaining(48518) < 2)
        and ni.spell.valid("target", 48461, true, true)
        then ni.spell.cast(48461, "target")
        end
    end,
    ["Starfire"] = function()
        if UnitAffectingCombat ("player")
        and ni.unit.exists ("target")
        and not ni.player.ismoving()
        and (ni.player.buff (48518) and ni.player.buffremaining (48518) >= 2)
        and ni.spell.available(48465)
        and ni.spell.valid("target", 48465, true, true)
        then ni.spell.cast(48465, "target")
        end
    end,
    ["smerch"] = function()
        if ni.unit.exists("focus") then
            if UnitAffectingCombat("focus")
            and not ni.unit.debuff("focus", 33786)
            and ni.spell.valid("focus", 33786, true, true, false)
            and ni.spell.available(33786)
            and not ni.player.ismoving() then
                    ni.spell.cast(33786, "focus")
            end
        end
    end,
}
ni.bootstrap.rotation("BALANCE", queue, abilities)