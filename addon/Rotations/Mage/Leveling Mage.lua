local A1 = ni.utils.require("A1")
local mage_rotation = {
    "Pause",
    "Shield",
    "Arcane Intellect",
    "Arcane Missiles",
}
local mage_functions = {
    ["Pause"] = function()
        if IsMounted()
        or UnitInVehicle("player")
        or ni.player.buff(GetSpellInfo(430))
        or ni.player.buff(GetSpellInfo(433))
        or ni.player.isconfused()
        or ni.player.isstunned()
        or ni.player.iscasting()
        or ni.player.ischanneling()
        or UnitIsDeadOrGhost("player")
        or IsLeftShiftKeyDown() then
            return true
        end
    end,
    ["Shield"] = function()
        if ni.player.buffremaining(A1.mage_skills_lvl.Frost_Armor) < 10
        and ni.spell.available(A1.mage_skills_lvl.Frost_Armor) then
            ni.spell.cast(A1.mage_skills_lvl.Frost_Armor)
        end
    end,
    ["Arcane Missiles"] = function()
        if not ni.player.ismoving()
        and ni.spell.available(A1.mage_skills_lvl.Arcane_Missiles)
        and ni.spell.valid("target", A1.mage_skills_lvl.Arcane_Missiles, true, true) then
            ni.spell.cast(A1.mage_skills_lvl.Arcane_Missiles)
        end
    end,
    ["Arcane Intellect"] = function()
        if ni.player.buffremaining(A1.mage_skills_lvl.ArcaneIntellect) < 10
        and ni.spell.available(A1.mage_skills_lvl.ArcaneIntellect) then
            ni.spell.cast(A1.mage_skills_lvl.ArcaneIntellect)
        end
    end,
    ["Fire Blast"] = function()
        if ni.spell.available(A1.mage_skills_lvl.FrostSpear)
        and ni.spell.valid("target", A1.mage_skills_lvl.FrostSpear, true, true) then
            ni.spell.cast(A1.mage_skills_lvl.FrostSpear)
        end
    end,
}
ni.bootstrap.profile("Leveling Mage", mage_rotation, mage_functions)