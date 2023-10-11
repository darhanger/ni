local GetSpellBonusHealing, GetSpellInfo, UnitClass = GetSpellBonusHealing, GetSpellInfo, UnitClass
local rdru_ico = {
    Cyclone = select(3, GetSpellInfo(33786)),
    RemoveCurse = select(3, GetSpellInfo(2782)),
    Rebirth = select(3, GetSpellInfo(48477))
}
local rdru_sp = {
    WildGrowth = GetSpellInfo(53251),
    Swiftmend = GetSpellInfo(18562),
    Regrowth = GetSpellInfo(48443),
    GiftOfTheWild = GetSpellInfo(48470),
    TreeOfLife = GetSpellInfo(33891),
    Lifebloom = GetSpellInfo(48451),
    Rejuvenation = GetSpellInfo(48441),
    Nourish = GetSpellInfo(50464),
    NaturesSwiftness = GetSpellInfo(17116),
    RemoveCurse = GetSpellInfo(2782),
    Tranquility = GetSpellInfo(48447),
    AbolishPoison = GetSpellInfo(2893),
    HealingTouch = GetSpellInfo(48378),
    Innervate = GetSpellInfo(29166),
    Barkskin = GetSpellInfo(22812),
    Thorns = GetSpellInfo(53307),
    NaturesGrasp = GetSpellInfo(53312),
    Cyclone = GetSpellInfo(33786),
    Rebirth = GetSpellInfo(48477),
}
local raid_debuffs = {
    Enfeeble = GetSpellInfo(30843),
    Pursued_by_Anub = GetSpellInfo(67574),
    Mutated_Infection = GetSpellInfo(69674),
    Necrotic_Plague = GetSpellInfo(70337)
}
local rdru_gui = {
	settingsfile = "PvE Restoration Druid A1 - 1.0.json",
	{ type = "title", text = "PvE Restoration Druid v1.0" },
	{ type = "separator" },
    { type = "entry", text = "\124T"..rdru_ico.Cyclone..":20:20\124t Смерч", enabled = false, key = "gui_Cyclone" },
    { type = "entry", text = "\124T"..rdru_ico.RemoveCurse..":20:20\124t Диспел", enabled = false, key = "gui_RemoveCurseAndAbolishPoison" },
    { type = "entry", text = "\124T"..rdru_ico.Rebirth..":20:20\124t Батлрес", enabled = false, key = "gui_Rebirth" },
    { type = "separator" },
	{ type = "entry", text = "Лог", enabled = false, key = "gui_Debug" },

}
local function GetSetting(name)
    for k, v in ipairs(rdru_gui) do
        if v.type == "entry"
         and v.key ~= nil
         and v.key == name then
            return v.value, v.enabled
        end
        if v.type == "dropdown"
         and v.key ~= nil
         and v.key == name then
            for k2, v2 in pairs(v.menu) do
                if v2.selected then
                    return v2.value
                end
            end
        end
        if v.type == "input"
         and v.key ~= nil
         and v.key == name then
            return v.value
        end
    end
end
local function gui_load()
	ni.GUI.AddFrame("PRDA1-1", rdru_gui)
end
local function gui_unload()
	ni.GUI.DestroyFrame("PRDA1-1")
end
function Tank(t)
    local _, _, class = UnitClass(t)
	if (class == 11
	and ni.unit.aura(t, 9634))
    or (class == 1
	and ni.unit.aura(t, 71))
    or (class == 2
	and ni.unit.aura(t, 25780)) then
		return true
	end
	return false
end
local controlledplayer = {}
local function PlayerUnderControl()
	table.wipe(controlledplayer)
	controlledplayer = ni.player.enemiesinrange(20)
	for k, v in ipairs(controlledplayer) do
		if ni.player.threat(v.guid) == -1
        and ni.unit.isplayercontrolled(v.guid) then
			table.remove(controlledplayer, k)
		end
	end
	return #controlledplayer
end
local RegrowthHealingPersec = (3469.5 + 0.1878*GetSpellBonusHealing())*0.2717 -- (3469.5+0.1878*2206)*0.2717=1051.5
local RejuvenationHealing = (2305 + 0.376*GetSpellBonusHealing())*0.6095 -- (2305+0.376*2206)*0.6095=1910.5
local WildGrowthHealing = (1655.5 + 0.1151*GetSpellBonusHealing())*0.8 -- (1655.5+0.1151*2206)*0.8=1527.5
local SwiftmendHealing = (((RejuvenationHealing + RegrowthHealingPersec)*5)/2 + GetSpellBonusHealing())*0.7944 -- (((1910.5+1051.5)*5)/2+2206)*0.7944=
local RegrowthHealing = (2600.5 + 0.3*GetSpellBonusHealing())*1.4177 -- (2600.5+0.3*2206)*1.4177=4624.5
local LifebloomHealing = (776 + 0.3857*GetSpellBonusHealing())*2.0285*1.8 -- 5940.13
local NourishHealing = (2238.5 + 0.8057*GetSpellBonusHealing())*1.196*1.3 -- 6243.88
local TranquilityHealing = (3035 + 1.0743*GetSpellBonusHealing())*1.0459 -- 5652.99
local HealingTouchHealing = (4498 + 1.6114*GetSpellBonusHealing())*1.2857 -- 
local rdru_rotation = {
    "Full stop rotation",
    "Cyclone",
    "TreeOfLifeForm",
    "Barkskin",
    "NaturesGrasp",
    --"GiftOfTheWild",
    "Thorns",
    "Rebirth",
    "Combat Pause",
    --"Tranquility",
    "HealingTouch",
    "WildGrowth",
    "Swiftmend",
    "Nourish",
    "Regrowth",
    "Rejuvenation",
    "RemoveCurse",
    "AbolishPoison",
    "Lifebloom",
    --"Rejuvenation in combat",
    "WildGrowth nc",
}
local rdru_functions = {
    ["Full stop rotation"] = function()
        local framerate = GetFramerate()
        if IsLeftShiftKeyDown()
        or IsMounted()
        or UnitInVehicle("player")
        or ni.player.buff(430)
        or ni.player.buff(433)
        or UnitIsDeadOrGhost("player")
        or UnitIsAFK("player")
        or framerate < 18 then
            return true
        end
		ni.vars.debug = select(2, GetSetting("gui_Debug"))
		PlayerUnderControl()
    end,
    ["Combat Pause"] = function()
        local delaystop = (ni.player.debuff(305131) and ni.player.debuffremaining(305131) < 2)
        or (ni.player.debuff(69762) and ni.player.debuffremaining(69762) > 3)
        if ni.player.issilenced()
        or ni.player.isconfused()
		or ni.player.isfleeing()
        or ni.player.isstunned()
        or ni.player.iscasting()
        or ni.player.ischanneling()
        or ni.player.debuffstacks(69766) > 4
		or delaystop then
            return true
        end
    end,
	["TreeOfLifeForm"] = function()
        if ni.spell.available(rdru_sp.TreeOfLife) then
            if not ni.player.aura(rdru_sp.TreeOfLife) then
                return ni.spell.cast(rdru_sp.TreeOfLife)
            end
        end
	end,
	["GiftOfTheWild"] = function()
        if ni.player.hasitem(44605) then
            if ni.spell.available(rdru_sp.GiftOfTheWild) then
                if ni.player.buffremaining(rdru_sp.GiftOfTheWild) < 333 then
                    return ni.spell.cast(rdru_sp.GiftOfTheWild)
                end
            end
        end
	end,
    ["Cyclone"] = function ()
        local _, CycloneActivated = GetSetting("gui_Cyclone")
        if CycloneActivated then
            if not ni.player.issilenced()
            and ni.spell.available(rdru_sp.Cyclone)
            and not ni.player.ismoving() then
                for j in pairs(controlledplayer) do
                    local controlledmate = controlledplayer[j].guid
                    if ni.spell.valid(controlledmate, rdru_sp.Cyclone, false, true)
                    and ni.unit.isplayer(controlledmate) then
                        if not ni.unit.debuff(controlledmate, rdru_sp.Cyclone) then
                            return ni.spell.cast(rdru_sp.Cyclone, controlledmate)
                        end
                    end
                end
            end
        end
    end,
	["Thorns"] = function()
        if ni.spell.available(rdru_sp.Thorns) then
            for _, ally in ipairs(ni.members) do
                if Tank(ally.unit)
                and ni.unit.buffremaining(ally.unit, rdru_sp.Thorns) < 111
                and ni.spell.valid(ally.unit, rdru_sp.Thorns, false, true, true) then
                    return ni.spell.cast(rdru_sp.Thorns, ally.unit)
                end
            end
        end
	end,
	["WildGrowth"] = function()
        if ni.spell.available(rdru_sp.WildGrowth) then
            for _, ally in ipairs(ni.members) do
                if ni.unit.debuff(ally.unit, raid_debuffs.Enfeeble) then
                    return false
                end
                if #ni.members.inrangewithoutbuffbelowraw(ally.unit, 13, WildGrowthHealing, rdru_sp.WildGrowth) >= 3
                and ni.spell.valid(ally.unit, rdru_sp.WildGrowth, false, true, true) then
                    return ni.spell.cast(rdru_sp.WildGrowth, ally.unit)
                end
            end
        end
	end,
	["WildGrowth nc"] = function()
        if not UnitAffectingCombat("player") then
            if ni.spell.available(rdru_sp.WildGrowth) then
                for _, ally in ipairs(ni.members) do
                    if #ni.members.inrangewithoutbuffbelow(ally.unit, 13, rdru_sp.WildGrowth, 94 ) >= 2
                    and ni.spell.valid(ally.unit, rdru_sp.WildGrowth, false, true, true) then
                        return ni.spell.cast(rdru_sp.WildGrowth, ally.unit)
                    end
                end
            end
        end
	end,
	["Regrowth"] = function()
        if ni.spell.available(rdru_sp.Regrowth)
        and not ni.player.ismoving() then
            for _, ally in ipairs(ni.members) do
                if ni.unit.debuff(ally.unit, raid_debuffs.Enfeeble) then
                    return false
                end
                if ni.unit.hpraw(ally.unit) > RegrowthHealing then
                    if not ni.unit.buff(ally.unit, rdru_sp.Regrowth)
                    and ni.spell.valid(ally.unit, rdru_sp.Regrowth, false, true, true) then
                        return ni.spell.cast(rdru_sp.Regrowth, ally.unit)
                    end
                end
            end
        end
	end,
	["Rejuvenation in combat"] = function()
        if ni.spell.available(rdru_sp.Rejuvenation) then
            for _, ally in ipairs(ni.members) do
                if ni.unit.debuff(ally.unit, raid_debuffs.Enfeeble) then
                    return false
                end
                if UnitAffectingCombat(ally.unit)
                and not Tank(ally.unit) then
                    if not ni.unit.buff(ally.unit, rdru_sp.Rejuvenation)
                    and ni.spell.valid(ally.unit, rdru_sp.Rejuvenation, false, true, true) then
                        return ni.spell.cast(rdru_sp.Rejuvenation, ally.unit)
                    end
                end
            end
        end
	end,
	["Rejuvenation"] = function()
        if ni.spell.available(rdru_sp.Rejuvenation) then
            for _, ally in ipairs(ni.members) do
                if ni.unit.debuff(ally.unit, raid_debuffs.Enfeeble) then
                    return false
                end
                if ni.unit.hp(ally.unit) < RejuvenationHealing and UnitAffectingCombat(ally.unit) then
                --if ni.unit.hpraw(ally.unit) > RejuvenationHealing or UnitAffectingCombat(ally.unit) then
                    if not ni.unit.buff(ally.unit, rdru_sp.Rejuvenation)
                    and ni.spell.valid(ally.unit, rdru_sp.Rejuvenation, false, true, true) then
                        return ni.spell.cast(rdru_sp.Rejuvenation, ally.unit)
                    end
                end
            end
        end
	end,
	["Rebirth"] = function()
        local _, RebirthActivated = GetSetting("gui_Rebirth")
        if RebirthActivated then
            if ni.spell.available(rdru_sp.Rebirth)
            and UnitAffectingCombat("player") then
                for _, ally in ipairs(ni.members) do
                    if UnitIsDead(ally.unit) then
                        if ni.spell.valid(ally.unit, rdru_sp.Rebirth, false, true, true) then
                            return ni.spell.cast(rdru_sp.Rebirth, ally.unit)
                        end
                    end
                end
            end
        end
        if not RebirthActivated then
            if ni.spell.available(rdru_sp.Rebirth)
            and UnitAffectingCombat("player") then
                if UnitIsDead("target") then
                    if ni.spell.valid("target", rdru_sp.Rebirth, false, true, true) then
                        return ni.spell.cast(rdru_sp.Rebirth, "target")
                    end
                end
            end
        end
	end,
	["Nourish"] = function()
        if ni.spell.available(rdru_sp.Nourish)
        and not ni.player.ismoving() then
            for _, ally in ipairs(ni.members) do
                if ni.unit.debuff(ally.unit, raid_debuffs.Enfeeble) then
                    return false
                end
                if ni.unit.hpraw(ally.unit) >= NourishHealing
                and ni.unit.buff(ally.unit, rdru_sp.Rejuvenation)
                and ni.unit.buff(ally.unit, rdru_sp.Regrowth) then
                    if ni.spell.valid(ally.unit, rdru_sp.Nourish, false, true, true) then
                        return ni.spell.cast(rdru_sp.Nourish, ally.unit)
                    end
                end
            end
        end
	end,
	["Swiftmend"] = function()
        if ni.spell.available(rdru_sp.Swiftmend) then
            for _, ally in ipairs(ni.members) do
                if ni.unit.debuff(ally.unit, raid_debuffs.Enfeeble) then
                    return false
                end
                if ni.unit.hpraw(ally.unit) >= SwiftmendHealing
                and ni.unit.buff(ally.unit, rdru_sp.Rejuvenation)
                and ni.unit.buff(ally.unit, rdru_sp.Regrowth) then
                    if ni.spell.valid(ally.unit, rdru_sp.Swiftmend, false, true, true) then
                        return ni.spell.cast(rdru_sp.Swiftmend, ally.unit)
                    end
                end
            end
        end
	end,
	["RemoveCurse"] = function()
        local _, DispelActivated = GetSetting("gui_RemoveCurseAndAbolishPoison")
        if DispelActivated then
            if ni.spell.available(rdru_sp.RemoveCurse)
            and not ni.player.ismoving() then
                for _, ally in ipairs(ni.members) do
                    if ni.unit.hp(ally.unit) >= 70 then
                        if ni.unit.debufftype(ally.unit, "Curse")
                        and ni.healing.candispel(ally.unit) then
                            if ni.spell.valid(ally.unit, rdru_sp.RemoveCurse, false, true, true) then
                                return ni.spell.delaycast(rdru_sp.RemoveCurse, ally.unit, 2)
                            end
                        end
                    end
                end
            end
        end
	end,
	["AbolishPoison"] = function()
        local _, DispelActivated = GetSetting("gui_RemoveCurseAndAbolishPoison")
        if DispelActivated then
            if ni.spell.available(rdru_sp.AbolishPoison)
            and not ni.player.ismoving() then
                for _, ally in ipairs(ni.members) do
                    if ni.unit.hp(ally.unit) >= 70
                    and not ni.unit.buff(ally.unit, rdru_sp.AbolishPoison) then
                        if ni.unit.debufftype(ally.unit, "Poison")
                        and ni.healing.candispel(ally.unit) then
                            if ni.spell.valid(ally.unit, rdru_sp.AbolishPoison, false, true, true) then
                                return ni.spell.delaycast(rdru_sp.AbolishPoison, ally.unit, 2)
                            end
                        end
                    end
                end
            end
        end
	end,
	["HealingTouch"] = function()
        if ni.spell.available(rdru_sp.HealingTouch)
        and ni.spell.cd(rdru_sp.NaturesSwiftness) == 0 then
            for _, ally in ipairs(ni.members) do
                if ni.unit.debuff(ally.unit, raid_debuffs.Enfeeble) then
                    return false
                end
                if ni.unit.hpraw(ally.unit) >= HealingTouchHealing*1.2 then
                    if ni.spell.valid(ally.unit, rdru_sp.HealingTouch, false, true, true) then
                        ni.spell.cast(rdru_sp.NaturesSwiftness)
                        ni.spell.cast(rdru_sp.HealingTouch, ally.unit)
                        return true
                    end
                end
            end
        end
	end,
	["Barkskin"] = function()
        if UnitAffectingCombat("player") then
            if ni.spell.cd(rdru_sp.Barkskin) == 0 then
                if ni.player.hp() < 33 then
                    return ni.spell.cast(rdru_sp.Barkskin)
                end
            end
        end
	end,
	["NaturesGrasp"] = function()
        if UnitAffectingCombat("player") then
            if ni.spell.available(rdru_sp.NaturesGrasp) then
                if ni.player.threat() >= 2
                and #ni.player.unitstargeting() >= 1 then
                    return ni.spell.cast(rdru_sp.NaturesGrasp)
                end
            end
        end
	end,
	["Tranquility"] = function()
        if UnitAffectingCombat("player") then
            if ni.spell.available(rdru_sp.Tranquility)
            and not ni.player.ismoving() then
                if #ni.members.inrangebelowraw("player", 30, TranquilityHealing) >= 15 then
                    return ni.spell.cast(rdru_sp.Tranquility)
                end
            end
        end
	end,
	["Lifebloom"] = function()
        if ni.spell.available(rdru_sp.Lifebloom) then
            for _, ally in ipairs(ni.members) do
                if Tank(ally.unit) then
                    if ni.unit.debuff(ally.unit, raid_debuffs.Enfeeble) then
                        return false
                    end
                    if ni.unit.hpraw(ally.unit) >= LifebloomHealing
                    and not ni.unit.buff(ally.unit, rdru_sp.Lifebloom) then
                        if ni.spell.valid(ally.unit, rdru_sp.Lifebloom, false, true, true) then
                            return ni.spell.cast(rdru_sp.Lifebloom, ally.unit)
                        end
                    end
                    if ni.unit.hpraw(ally.unit) >= LifebloomHealing*2
                    and ni.unit.buffstacks(ally.unit, rdru_sp.Lifebloom) == 1 then
                        if ni.spell.valid(ally.unit, rdru_sp.Lifebloom, false, true, true) then
                            return ni.spell.cast(rdru_sp.Lifebloom, ally.unit)
                        end
                    end
                    if ni.unit.hpraw(ally.unit) >= LifebloomHealing*3
                    and ni.unit.buffstacks(ally.unit, rdru_sp.Lifebloom) == 2 then
                        if ni.spell.valid(ally.unit, rdru_sp.Lifebloom, false, true, true) then
                            return ni.spell.cast(rdru_sp.Lifebloom, ally.unit)
                        end
                    end
                end
            end
        end
    end,

}
ni.bootstrap.profile("PvE Restoration Druid v1.0", rdru_rotation, rdru_functions, gui_load, gui_unload)