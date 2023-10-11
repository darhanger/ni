local hpal_icons = {
	Divine_Plea = select(3, GetSpellInfo(54428)),
	Holy_Light = select(3, GetSpellInfo(48782)),
	Holy_Shock = select(3, GetSpellInfo(48825)),
	Flash_of_Light = select(3, GetSpellInfo(48785)),
	Hand_of_Sacrifice = select(3, GetSpellInfo(6940)),
	Cleanse = select(3, GetSpellInfo(4987)),
	Racial = select(3, GetSpellInfo(316256)),
    Fear = select(3, GetSpellInfo(10326)),
    dps = select(3, GetSpellInfo(25780)),
    Grace = select(3, GetSpellInfo(31834))
}
local hpal_skills = {
	Seal_of_Wisdom = GetSpellInfo(20166),
	Divine_Plea = GetSpellInfo(54428),
	Divine_Illumination = GetSpellInfo(31842),
	Divine_Favor = GetSpellInfo(20216),
	Holy_Light = GetSpellInfo(48782),
	Holy_Shock = GetSpellInfo(48825),
	Flash_of_Light = GetSpellInfo(48785),
	Hand_of_Sacrifice = GetSpellInfo(6940),
	Lay_on_Hands = GetSpellInfo(48788),
	Hammer_of_Justice = GetSpellInfo(10308),
	Beacon_of_Light = GetSpellInfo(53563),
	Sacred_Shield = GetSpellInfo(53601),
	Cleanse = GetSpellInfo(4987),
	Avenging_Wrath = GetSpellInfo(31884),
	Holy_Wrath = GetSpellInfo(48817),
	Infusion_of_Light = GetSpellInfo(54149),
	Forbearance = GetSpellInfo(25771),
	Hand_of_Salvation = GetSpellInfo(1038),
	Hand_of_Protection = GetSpellInfo(10278),
	Divine_Shield = GetSpellInfo(642),
	Hand_of_Freedom = GetSpellInfo(1044),
    Racial = GetSpellInfo(316256),
    Fear = GetSpellInfo(10326),
    Svet = GetSpellInfo(20271),
    Consecration = GetSpellInfo(48819),
    ShieldOfRighteousness = GetSpellInfo(61411),
    Righteous_Fury = GetSpellInfo(25780),
    Grace = GetSpellInfo(31834)
}
local raid_debuffs = {
    Enfeeble = GetSpellInfo(30843),
    Pursued_by_Anub = GetSpellInfo(67574),
    Mutated_Infection = GetSpellInfo(69674),
    Necrotic_Plague = GetSpellInfo(70337),
    Fiery_Combustion = GetSpellInfo(74562),
    Soul_Consumption = GetSpellInfo(74792)
}
local pots = {
    Mana = GetItemInfo(42545),
    Health = GetItemInfo(33447)
}
local hpal_gui = {
	settingsfile = "A1 - Holy Paladin Valitrhia.json",
	{ type = "title", text = "|cfff58cbaHoly Paladin |cffcece0cValitrhia" },
    { type = "separator" },
	{ type = "entry", text = "|cffcece0cЛог", enabled = false, key = "gui_debug" },

}
local function GetSetting(name)
    for k, v in ipairs(hpal_gui) do
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
	ni.GUI.AddFrame("A1 Holy Valitrhia", hpal_gui)
end
local function gui_unload()
	ni.GUI.DestroyFrame("A1 Holy Valitrhia")
end
local hpal_rotation = {
    "Righteous Fury Check",
    "Pause",
    "Divine Shield",
    "Healthstone",
    "Seal of Wisdom",
    "Beacon of Light",
    "Night Elf (Racial)",
    "Trinkets",
    "Holy Light (Target)",
}
local hpal_abilities = {
    ["Pause"] = function()
        if IsMounted()
        or UnitInVehicle("player")
        or ni.player.buff(430)
        or ni.player.buff(433)
        or UnitIsDeadOrGhost("player")
        or UnitIsAFK("player")
        or ni.player.buff(316254) then
            return true
        end
		ni.vars.debug = select(2, GetSetting("gui_debug"))
    end,
    ["Seal of Wisdom"] = function ()
        if ni.player.buffremaining(hpal_skills.Seal_of_Wisdom) < 33
        and ni.spell.available(hpal_skills.Seal_of_Wisdom) then
            return ni.spell.cast(hpal_skills.Seal_of_Wisdom)
        end
    end,
    ["Beacon of Light"] = function()
        local X = GetSetting("coef")
        if ni.unit.exists("focus")
        and UnitAffectingCombat("focus") then
            if ni.unit.buffremaining("focus", hpal_skills.Beacon_of_Light, "player") <= 5
            and ni.spell.available(hpal_skills.Beacon_of_Light)
            and ni.spell.valid("focus", hpal_skills.Beacon_of_Light, false, true, true) then
                return ni.spell.cast(hpal_skills.Beacon_of_Light, "focus")
            end
        end
    end,
    ["Trinkets"] = function()
		if UnitAffectingCombat("player")
        and ni.player.slotcastable(13)
        and ni.player.slotcastable(14)
        and ni.player.slotcd(13) == 0
        and ni.player.slotcd(14) == 0 then
            ni.player.useinventoryitem(13)
            return ni.player.useinventoryitem(14)
		end
    end,
    ["Divine Shield"] = function()
        if not ni.player.debuff(raid_debuffs.Enfeeble)
        and ni.spell.cd(hpal_skills.Avenging_Wrath) ~= 0
        and ni.spell.cd(hpal_skills.Avenging_Wrath) <= 149 then
			if UnitAffectingCombat("player")
			and not ni.unit.debuff("player", hpal_skills.Forbearance)
			and ni.player.hp() < 15
			and ni.spell.available(hpal_skills.Divine_Shield) then
				return ni.spell.cast(hpal_skills.Divine_Shield)
			end
        end
        if (ni.player.buff(hpal_skills.Divine_Shield) or ni.player.buff(498))
        and ni.spell.available(64205) then
            return ni.spell.cast(64205)
        end
    end,
	["Righteous Fury Check"] = function()
        if ni.player.aura(hpal_skills.Righteous_Fury) then
            return CancelUnitBuff("player", hpal_skills.Righteous_Fury);
        end
	end,
    ["Holy Light (Target)"] = function()
        if ni.spell.available(hpal_skills.Holy_Light)
        and ni.spell.valid("target", hpal_skills.Holy_Light, false, true, true)
        and not ni.unit.ismoving("player") then
            return ni.spell.cast(hpal_skills.Holy_Light, "target")
        end
    end,
    ["Night Elf (Racial)"] = function()
        if ni.spell.cd(hpal_skills.Racial) == 0
        and not ni.player.ismoving() then
            return ni.spell.cast(hpal_skills.Racial, "player")
        end
    end,
	["Healthstone"] = function()
		local hstones = { 36892, 36893, 36894 }
		for i = 1, #hstones do
			if UnitAffectingCombat("player")
			and not ni.player.debuff(30843)
			and ni.player.hp() < 33
			and ni.player.hasitem(hstones[i])
			and ni.player.itemcd(hstones[i]) == 0 then
				return ni.player.useitem(hstones[i])
			end
		end
	end,
}
ni.bootstrap.profile("A1 - Holy Paladin Valitrhia", hpal_rotation, hpal_abilities, gui_load, gui_unload)