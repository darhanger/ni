local UnitAffectingCombat,
IsLeftAltKeyDown,
IsRightAltKeyDown,
IsLeftShiftKeyDown,
UnitInVehicle,
IsMounted,
GetSpellInfo,
UnitIsDeadOrGhost,
IsCurrentSpell,
UnitCanAttack,
UnitInRaid,
GetRaidTargetIndex,
SetRaidTarget,
GetTime,
IsUsableSpell,
UnitLevel,
UnitCastingInfo,
GetItemCount,
GetNetStats,
UnitClass,
CancelUnitBuff,
GetSpellBonusHealing,
UnitIsUnit =
UnitAffectingCombat,
IsLeftAltKeyDown,
IsRightAltKeyDown,
IsLeftShiftKeyDown,
UnitInVehicle,
IsMounted,
GetSpellInfo,
UnitIsDeadOrGhost,
IsCurrentSpell,
UnitCanAttack,
UnitInRaid,
GetRaidTargetIndex,
SetRaidTarget,
GetTime,
IsUsableSpell,
UnitLevel,
UnitCastingInfo,
GetItemCount,
GetNetStats,
UnitClass,
CancelUnitBuff,
GetSpellBonusHealing,
UnitIsUnit;
local RProtation = {
    "Pause",
    "Seal",
    "Bless",
    "Combat Pause",
    "Auto Attack",
    "Judgement"
};
local RPfunctions = {
    ["Pause"] = function ()
        if IsMounted()
        or UnitInVehicle("player")
        or ni.player.buff(GetSpellInfo(430))
        or ni.player.buff(GetSpellInfo(433))
        or ni.player.isconfused()
        or ni.player.isstunned()
        or UnitIsDeadOrGhost("player") then
			return true
        end
    end,
    ["Combat Pause"] = function ()
        if IsLeftShiftKeyDown()
        or ni.player.iscasting()
        or ni.player.ischanneling() then
			return true
        end
    end,
    ["Auto Attack"] = function()
        NearestAgressiveEnemies = ni.player.enemiesinrange(6)
        if ni.unit.exists("target")
        and not UnitIsDeadOrGhost("target")
        and ni.player.inmelee("target")
        and ni.player.isfacing("target")
        and UnitCanAttack("player", "target")
        and not IsCurrentSpell(6603) then
            ni.spell.cast(6603)
        end
        if ni.unit.exists("target")
        and UnitCanAttack("player", "target")
        and not (ni.player.inmelee("target") or ni.player.isfacing("target"))
        and IsCurrentSpell(6603) then
            ni.player.runtext("/stopattack")
        end
        if UnitAffectingCombat("player")
        and (not ni.unit.exists("target") or (ni.unit.exists("target") and not UnitCanAttack("player", "target"))) then
            if #NearestAgressiveEnemies >= 1 then
                ni.player.runtext("/targetenemy")
            end
        end
    end,
    ["Seal"] = function ()
        local plvl = UnitLevel("player")
        if plvl >= 1
        and plvl <= 10 then
            if not ni.player.buff("Печать праведности") then
                if ni.spell.available("Печать праведности") then
                    ni.spell.cast("Печать праведности")
                end
            end
        end
    end,
    ["Bless"] = function ()
        if not ni.player.buff("Благословение могущества") then
            if ni.spell.available("Благословение могущества") then
                ni.spell.cast("Благословение могущества")
            end
        end
    end,
    ["Judgement"] = function ()
        if UnitAffectingCombat("player") then
            if ni.spell.available("Правосудие света")
            and ni.spell.valid("target", "Правосудие света", false, true, false) then
                ni.spell.cast("Правосудие света")
            end
        end
    end,
}
ni.bootstrap.profile("LEV", RProtation, RPfunctions)