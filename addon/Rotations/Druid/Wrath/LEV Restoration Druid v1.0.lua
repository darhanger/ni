local GetSpellBonusHealing, GetSpellInfo, UnitClass = GetSpellBonusHealing, GetSpellInfo, UnitClass
local rdru_ico = {
    Cyclone = select(3, GetSpellInfo(33786)),
    RemoveCurse = select(3, GetSpellInfo(2782)),
}
local rdru_sp = {
    WildGrowth = GetSpellInfo("Буйный рост"),
    Swiftmend = GetSpellInfo("Быстрое восстановление"),
    Regrowth = GetSpellInfo("Восстановление"),
    GiftOfTheWild = GetSpellInfo("Дар дикой природы"),
    TreeOfLife = GetSpellInfo("Древо Жизни"),
    Lifebloom = GetSpellInfo("Жизнецвет"),
    Rejuvenation = GetSpellInfo("Омоложение"),
    Nourish = GetSpellInfo("Покровительство Природы"),
    NaturesSwiftness = GetSpellInfo("Природная стремительность"),
    RemoveCurse = GetSpellInfo("Снятие проклятия"),
    Tranquility = GetSpellInfo("Спокойствие"),
    AbolishPoison = GetSpellInfo("Устранение яда"),
    HealingTouch = GetSpellInfo("Целительное прикосновение"),
    Innervate = GetSpellInfo("Озарение"),
    Barkskin = GetSpellInfo("Дубовая кожа"),
    Thorns = GetSpellInfo("Шипы"),
    NaturesGrasp = GetSpellInfo("Хватка природы"),
    Cyclone = GetSpellInfo("Смерч"),
}
local raid_debuffs = {
    Enfeeble = GetSpellInfo(30843),
    Pursued_by_Anub = GetSpellInfo(67574),
    Mutated_Infection = GetSpellInfo(69674),
    Necrotic_Plague = GetSpellInfo(70337)
}
local rdru_gui = {
	settingsfile = "LEV Restoration Druid A1 - 1.0.json",
	{ type = "title", text = "LEV Restoration Druid v1.0" },
	{ type = "separator" },
    { type = "entry", text = "\124T"..rdru_ico.Cyclone..":20:20\124t Смерч", enabled = false, key = "gui_Cyclone" },
    { type = "entry", text = "\124T"..rdru_ico.RemoveCurse..":20:20\124t Диспел", enabled = false, key = "gui_RemoveCurseAndAbolishPoison" },
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
	ni.GUI.AddFrame("PRDA1-1lev", rdru_gui)
end
local function gui_unload()
	ni.GUI.DestroyFrame("PRDA1-1lev")
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
local rdru_rotation = {
    "Full stop rotation",
    "Cyclone",
    "TreeOfLifeForm",
    "WildGrowth nc",
    --"Barkskin",
    "NaturesGrasp",
    --"GiftOfTheWild",
    --"Thorns",
    "Combat Pause",
    "RemoveCurse",
    "AbolishPoison",
    "Tranquility",
    "HealingTouch",
    "WildGrowth",
    "Swiftmend",
    "Nourish",
    "Regrowth",
    "Rejuvenation",
    "Lifebloom",
}
local rdru_functions = {
    ["Full stop rotation"] = function()
        if IsMounted()
        or UnitInVehicle("player")
        or ni.player.buff(430)
        or ni.player.buff(433)
        or UnitIsDeadOrGhost("player")
        or UnitIsAFK("player") then
            return true
        end
		ni.vars.debug = select(2, GetSetting("gui_Debug"))
		PlayerUnderControl()
    end,
    ["Combat Pause"] = function()
        local delaystop = (ni.player.debuff(305131) and ni.player.debuffremaining(305131) < 2)
        or (ni.player.debuff(69762) and ni.player.debuffremaining(69762) > 18)
        or (ni.player.debuff(69762) and ni.player.debuffremaining(69762) < 7)
        or ni.player.debuffstacks(69766) > 4
        if IsLeftShiftKeyDown()
        or ni.player.issilenced()
        or ni.player.isconfused()
		or ni.player.isfleeing()
        or ni.player.isstunned()
        or ni.player.iscasting()
        or ni.player.ischanneling()
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
                if #ni.members.inrangewithoutbuffbelow(ally.unit, 13, 85, rdru_sp.WildGrowth) >= 3
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
                    if #ni.members.inrangewithoutbuffbelow(ally.unit, 13, rdru_sp.WildGrowth, 95) >= 2
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
                if ni.unit.hp(ally.unit) < 70 then
                    if not ni.unit.buff(ally.unit, rdru_sp.Regrowth)
                    and ni.spell.valid(ally.unit, rdru_sp.Regrowth, false, true, true) then
                        return ni.spell.cast(rdru_sp.Regrowth, ally.unit)
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
                if ni.unit.hp(ally.unit) < 93 then
                    if not ni.unit.buff(ally.unit, rdru_sp.Rejuvenation)
                    and ni.spell.valid(ally.unit, rdru_sp.Rejuvenation, false, true, true) then
                        return ni.spell.cast(rdru_sp.Rejuvenation, ally.unit)
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
                if ni.unit.hp(ally.unit) < 50
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
                if ni.unit.hp(ally.unit) < 50
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
            if ni.spell.available(rdru_sp.RemoveCurse) then
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
            if ni.spell.available(rdru_sp.AbolishPoison) then
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
	["HealingTouch mod"] = function()
        if ni.spell.available(rdru_sp.HealingTouch)
        and ni.spell.cd(rdru_sp.NaturesSwiftness) == 0 then
            for _, ally in ipairs(ni.members) do
                if ni.unit.debuff(ally.unit, raid_debuffs.Enfeeble) then
                    return false
                end
                if ni.unit.hp(ally.unit) < 33 then
                    if ni.spell.valid(ally.unit, rdru_sp.HealingTouch, false, true, true) then
                        ni.spell.cast(rdru_sp.NaturesSwiftness)
                        ni.spell.cast(rdru_sp.HealingTouch, ally.unit)
                        return true
                    end
                end
            end
        end
	end,
	["HealingTouch"] = function()
        if ni.spell.available(rdru_sp.HealingTouch)
        and not ni.player.ismoving() then
            for _, ally in ipairs(ni.members) do
                if ni.unit.debuff(ally.unit, raid_debuffs.Enfeeble) then
                    return false
                end
                if ni.unit.hp(ally.unit) < 45 then
                    if ni.spell.valid(ally.unit, rdru_sp.HealingTouch, false, true, true) then
                        ni.spell.cast(rdru_sp.HealingTouch, ally.unit)
                        return true
                    end
                end
            end
        end
	end,
	["Barkskin"] = function()
        if UnitAffectingCombat("player") then
            if IsSpellKnown(rdru_sp.Barkskin)
            and ni.spell.cd(rdru_sp.Barkskin) == 0 then
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
                if #ni.members.inrangebelow("player", 30, 60) >= 6 then
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
                    if ni.unit.hp(ally.unit) < 90
                    and not ni.unit.buff(ally.unit, rdru_sp.Lifebloom) then
                        if ni.spell.valid(ally.unit, rdru_sp.Lifebloom, false, true, true) then
                            return ni.spell.cast(rdru_sp.Lifebloom, ally.unit)
                        end
                    end
                    if ni.unit.hp(ally.unit) < 80
                    and ni.unit.buffstacks(ally.unit, rdru_sp.Lifebloom) == 1 then
                        if ni.spell.valid(ally.unit, rdru_sp.Lifebloom, false, true, true) then
                            return ni.spell.cast(rdru_sp.Lifebloom, ally.unit)
                        end
                    end
                    if ni.unit.hp(ally.unit) < 70
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
ni.bootstrap.profile("LEV Restoration Druid v1.0", rdru_rotation, rdru_functions, gui_load, gui_unload)