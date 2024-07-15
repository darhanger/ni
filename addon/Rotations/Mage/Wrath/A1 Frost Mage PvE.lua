local fm_skill = {
    FrostShield = GetSpellInfo(7301),
    FireBall = GetSpellInfo(47610),
    ArcaneIntellect = GetSpellInfo(43002),
    FrostBolt = GetSpellInfo(42842),
    FrostSpear = GetSpellInfo(42914),
    FrostRing = GetSpellInfo(42917),
    Sheep = GetSpellInfo(12826),
    ASurgeOfStrength = GetSpellInfo(12051),
    Decurse = GetSpellInfo(475),
    Blizzard = GetSpellInfo(42940),
    Blink = GetSpellInfo("Скачок"),
    IceShield = GetSpellInfo(43008),
    IceCone = GetSpellInfo(42931),
    ArcaneShield = GetSpellInfo(43024),
    Empower = GetSpellInfo(43017),
    FrostBlock = GetSpellInfo(43039),
    ColdBlood = GetSpellInfo(12472),
    FrostHand = GetSpellInfo(11957),
    VeryCold = GetSpellInfo(12497),
    Coolant = GetSpellInfo("Глубокая заморозка"),
    Lump = GetSpellInfo(45438),
    WaterGolem = GetSpellInfo(31687),
    ManaStone = GetSpellInfo(42985),
    IceProtect = GetSpellInfo(43012),
    FireProtect = GetSpellInfo(43010),
}
local fm_skills_ico = {
    FrostShield = select(3, GetSpellInfo("Морозный доспех")),
    Sheep = select(3, GetSpellInfo("Превращение")),
    ASurgeOfStrength = select(3, GetSpellInfo("Прилив сил")),
    Decurse = select(3, GetSpellInfo("Снятие проклятия")),
    IceShield = select(3, GetSpellInfo("Ледяной доспех")),
    ArcaneShield = select(3, GetSpellInfo("Магический доспех")),
    Empower = select(3, GetSpellInfo("Усиление магии")),
    IceProtect = select(3, GetSpellInfo("Защита от магии льда")),
    FireProtect = select(3, GetSpellInfo("Защита от огня")),
}
local fm_gui = {
	settingsfile = "A1 Frost Mage PvE.json",
	{ type = "title", text = "|cff3a8099Mage Frost PvE |cffcece0cA1 v1.1" },
	{ type = "separator" },
    { type = "dropdown", menu = {
        { selected = true, value = fm_skill.FrostShield, text = "\124T"..fm_skills_ico.FrostShield..":21:21\124t |cff3a8099Морозный доспех" },
        { selected = false, value = fm_skill.IceShield, text = "\124T"..fm_skills_ico.IceShield..":21:21\124t |cff3a8099Ледяной доспех" },
        { selected = false, value = fm_skill.ArcaneShield, text = "\124T"..fm_skills_ico.ArcaneShield..":21:21\124t |cff3a8099Чародейский доспех" },
        { selected = false, value = 0, text = "|cffb30000Выкл" },
    }, key = "set_armor" },
    { type = "dropdown", menu = {
        { selected = true, value = fm_skill.IceProtect, text = "\124T"..fm_skills_ico.IceProtect..":21:21\124t |cff3a8099Защита ото льда" },
        { selected = false, value = fm_skill.FireProtect, text = "\124T"..fm_skills_ico.FireProtect..":21:21\124t |cff3a8099Защита от огня" },
        { selected = false, value = 0, text = "|cffb30000Выкл" },
    }, key = "set_protect" },
	{ type = "entry", text = "\124T"..fm_skills_ico.Decurse..":21:21\124t |cff3a8099Снятие проклятий", enabled = true, key = "set_decurse" },
	{ type = "entry", text = "\124T"..fm_skills_ico.ASurgeOfStrength..":21:21\124t |cff3a8099Прилив сил", enabled = true, value = 50, min = 5, max = 45, step = 5, width = 30, key = "set_tide" },
	{ type = "entry", text = "\124T"..fm_skills_ico.Sheep..":21:21\124t |cff3a8099Овца", enabled = true, key = "set_sheeping" },
	{ type = "entry", text = "\124T"..fm_skills_ico.Empower..":21:21\124t |cff3a8099Усиление", enabled = true, key = "set_empower" },
	{ type = "entry", text = "|cff3a8099Триньки", enabled = false, key = "set_trinkets" },
	{ type = "separator" },
	{ type = "entry", text = "Лог", enabled = false, key = "set_log" },
}
local function GetSetting(name)
    for k, v in ipairs(fm_gui) do
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
end;
local function OnLoad()
	ni.GUI.AddFrame("A1 Frost Mage PvE", fm_gui)
end
local function OnUnLoad()
	ni.GUI.DestroyFrame("A1 Frost Mage PvE")
end
local BadBuff = {69051, 48294, 42354}
local NeedToCancelBuffs = {10278, 19753}
local fm_rotation = {
    "Pause",
    "Shield",
    "Protect",
    "Empower",
    "Arcane Intellect",
    "Sheeping",
    "Save",
    "Manastone",
    "Healthstone",
    "Potions",
    "Mana",
    "Rase",
    "Decurse",
    "BuffSteal",
    "Blink",
    "Trinkets",
    "Combat Pause",
    "Frost Block",
    "Cold Blood",
    "Frost Hand",
    "Golem",
    "Frost Ring",
    "Ice Cone",
    "Blizzard",
    "Prok",
    "Coolant",
    "FrostSpear",
    "Bolt",
}
local fm_functions = {
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
        ni.vars.debug = select(2, GetSetting("set_log"))
    end,
    ["Combat Pause"] = function()
        for _, v in ipairs(BadBuff) do
            if ni.unit.buff("target", v)
            or ni.unit.debuff("target", v)
            or ni.unit.hp("target") > 99.7
            then
                return true
            end
        end
    end,
    ["Shield"] = function()
		local CurrentArmor = GetSetting("set_armor")
        if CurrentArmor == 0 then
            return false
        end
        if ni.player.buffremaining(CurrentArmor) < 10
        and ni.spell.available(CurrentArmor) then
            ni.spell.cast(CurrentArmor)
        end
    end,
    ["Protect"] = function()
		local CurrentProtection = GetSetting("set_protect")
        if CurrentProtection == 0 then
            return false
        end
        if ni.player.buffremaining(CurrentProtection) < 10
        and ni.spell.available(CurrentProtection) then
            ni.spell.cast(CurrentProtection)
        end
    end,
    ["Save"] = function()
        if UnitAffectingCombat("player")
        and ni.player.hp() < 20
        and ni.spell.available(fm_skill.Lump) then
            ni.spell.cast(fm_skill.Lump)
        end
        if ni.player.hp() > 75
        and ni.player.buff(fm_skill.Lump) then
            CancelUnitBuff("player", "Ледяная глыба")
        end
    end,
    ["Frost Hand"] = function()
        if ni.player.buffremaining(fm_skill.ColdBlood) < 1
        and ni.spell.available(fm_skill.FrostHand)
        and ni.spell.cd(fm_skill.ColdBlood) ~= 0 then
            ni.spell.cast(fm_skill.FrostHand)
        end
    end,
    ["Empower"] = function()
		local _, enabled = GetSetting("set_empower")
        if enabled then
            if ni.player.buffremaining(fm_skill.Empower) < 10
            and ni.spell.available(fm_skill.Empower) then
                ni.spell.cast(fm_skill.Empower, "player")
            end
        end
    end,
    ["Cold Blood"] = function()
        if UnitAffectingCombat("player")
        and ni.unit.isboss("target")
        and ni.unit.hp("target") < 98
        and ni.player.buffremaining(fm_skill.ColdBlood) < 1
        and ni.spell.available(fm_skill.ColdBlood)
        and ni.spell.valid("target", fm_skill.FrostBolt, true, true) then
            ni.spell.cast(fm_skill.ColdBlood)
        end
    end,
    ["Frost Block"] = function()
        if UnitAffectingCombat("player")
        and #ni.player.unitstargeting() >= 1
        and not ni.player.buff(fm_skill.FrostBlock)
        and ni.spell.available(fm_skill.FrostBlock) then
            ni.spell.cast(fm_skill.FrostBlock)
        end
    end,
    ["Arcane Intellect"] = function()
        if ni.player.buffremaining(fm_skill.ArcaneIntellect) < 10
        and ni.spell.available(fm_skill.ArcaneIntellect) then
            ni.spell.cast(fm_skill.ArcaneIntellect)
        end
    end,
    ["Mana"] = function()
		local value, enabled = GetSetting("set_tide")
        if enabled then
            if not ni.player.ismoving()
            and ni.player.power() <= value
            and ni.spell.available(fm_skill.ASurgeOfStrength) then
                ni.spell.cast(fm_skill.ASurgeOfStrength)
            end
        end
    end,
    ["Decurse"] = function()
		local _, enabled = GetSetting("set_decurse")
        if enabled then
            if ni.player.debufftype("Curse")
            and ni.healing.candispel("player")
            and ni.spell.available(fm_skill.Decurse) then
                ni.spell.cast(fm_skill.Decurse, "player")
            end
            for i = 1, #ni.members do
                local teammate = ni.members[i].unit
                if ni.unit.debufftype(teammate, "Curse")
                and ni.healing.candispel(teammate)
                and ni.spell.available(fm_skill.Decurse)
                and ni.spell.valid(teammate, fm_skill.Decurse, false, true, true) then
                    ni.spell.cast(fm_skill.Decurse, teammate)
                end
            end
        end
    end,
    ["Coolant"] = function()
        if IsUsableSpell(fm_skill.Coolant)
        and ni.spell.available(fm_skill.Coolant)
        and ni.spell.valid("target", fm_skill.Coolant, true, true) then
            ni.spell.cast(fm_skill.Coolant)
        end
    end,
    ["FrostSpear"] = function()
        if ni.spell.available(fm_skill.FrostSpear)
        and ni.spell.valid("target", fm_skill.FrostSpear, true, true)
        and (ni.unit.debuff("target", 44572, "player") or ni.player.buff(74396) or ni.player.ismoving()) then
            ni.spell.cast(fm_skill.FrostSpear)
        end
    end,
    ["Bolt"] = function()
        if not ni.player.ismoving()
        and ni.spell.available(fm_skill.FrostBolt)
        and ni.spell.valid("target", fm_skill.FrostBolt, true, true) then
            ni.spell.cast(fm_skill.FrostBolt)
        end
    end,
    ["Blizzard"] = function()
        if not ni.player.ismoving()
        and #ni.unit.enemiesinrange("target", 5) >= 2
        and ni.spell.available(fm_skill.Blizzard)
        and ni.spell.valid("target", fm_skill.FrostBolt, false, true)
        and IsLeftControlKeyDown() then
            ni.spell.castat(fm_skill.Blizzard, "target")
        end
    end,
    ["BuffSteal"] = function()
        if ni.unit.exists("focus") then
            if not ni.unit.bufftype("focus", "Magic")
            and ni.spell.available(fm_skill.BuffSteal)
            and ni.spell.valid("focus", fm_skill.BuffSteal, true, true) then
                ni.spell.cast(fm_skill.BuffSteal, "focus")
            end
        end
    end,
    ["Prok"] = function()
        if ni.spell.available(fm_skill.FireBall)
        and ni.spell.valid("target", fm_skill.FireBall, true, true)
        and ni.player.buff(57761) then
            ni.spell.cast(fm_skill.FireBall)
        end
    end,
    ["Sheeping"] = function()
		local _, enabled = GetSetting("set_sheeping")
        if ni.unit.exists("focus") and enabled then
            if not ni.player.ismoving()
            and (ni.unit.creaturetype("focus") == 1 or ni.unit.creaturetype("focus") == 7)
            and (not ni.unit.debuff("focus", fm_skill.Sheep) or ni.unit.debuffremaining("focus", fm_skill.Sheep) <= 2)
            and ni.spell.available(fm_skill.Sheep)
            and ni.spell.valid("focus", fm_skill.Sheep, true, true) then
                ni.spell.cast(fm_skill.Sheep, "focus")
            end
        end
    end,
    ["Frost Ring"] = function()
        if #ni.player.enemiesinrange(1) >= 1
        and UnitAffectingCombat("player")
        and ni.spell.available(fm_skill.FrostRing) then
            ni.spell.cast(fm_skill.FrostRing)
        end
    end,
    ["Ice Cone"] = function()
        if ni.player.inmelee("target")
        and ni.player.isfacing("target", 45)
        and UnitAffectingCombat("player")
        and ni.spell.available(fm_skill.IceCone) then
                ni.spell.cast(fm_skill.IceCone)
        end
    end,
    ["Trinkets"] = function()
		local _, enabled = GetSetting("set_trinkets")
            if enabled then
                if ni.player.slotcastable(13)
                and ni.player.slotcd(13) == 0 then
                    ni.player.useinventoryitem(13)
                end
                if ni.player.slotcastable(14)
                and ni.player.slotcd(14) == 0 then
                    ni.player.useinventoryitem(14)
                end
            end
    end,
	["Manastone"] = function()
		if UnitAffectingCombat("player")
		and ni.player.power() < 70
		and ni.player.hasitem(33312)
		and ni.player.itemcd(33312) == 0 then
			ni.player.useitem(33312)
		end
        if not ni.player.hasitem(33312)
        and ni.spell.available(fm_skill.ManaStone)
        and not ni.player.ismoving() then
            ni.spell.cast(fm_skill.ManaStone)
		end
	end,
	["Healthstone"] = function()
		local hstones = { 36892, 36893, 36894 }
		for i = 1, #hstones do
			if UnitAffectingCombat("player")
			and ni.player.hp() < 50
			and ni.player.hasitem(hstones[i])
			and ni.player.itemcd(hstones[i]) == 0 then
				ni.player.useitem(hstones[i])
			end
		end
	end,
	["Potions"] = function()
		if UnitAffectingCombat("player")
		and ni.player.hp() < 50
		and ni.player.hasitem(33447)
		and ni.player.itemcd(33447) == 0 then
			ni.player.useitem(33447)
		end
	end,
    ["Rase"] = function()
        if UnitAffectingCombat("player")
        and ni.player.power() < 10
        and ni.spell.cd(316432) == 0 then
            ni.spell.cast(316432)
        end
    end,
    ["Golem"] = function()
        if UnitAffectingCombat("player")
        and ni.unit.isboss("target")
        and ni.unit.hp("target") < 98
        and not ni.unit.exists("pet")
        and ni.spell.available(fm_skill.WaterGolem)
        and ni.spell.valid("target", fm_skill.FrostBolt, true, true) then
            ni.spell.cast(fm_skill.WaterGolem)
        end
    end,
}
ni.bootstrap.profile("A1 Frost Mage PvE", fm_rotation, fm_functions, OnLoad, OnUnLoad)