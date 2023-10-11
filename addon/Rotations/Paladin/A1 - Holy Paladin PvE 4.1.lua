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
    TwoT5 = GetSpellInfo(307911),
    Divine_Sacrifice = GetSpellInfo(64205),
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
	settingsfile = "A1 - Holy Paladin PvE4-1.json",
	{ type = "title", text = "|cfff58cbaHoly Paladin PvE |cffcece0cA1 v4.1" },
	{ type = "separator" },
	{ type = "entry", text = "\124T"..hpal_icons.Cleanse..":20:20\124t |cfff58cbaОчищение", enabled = false, key = "gui_Cleanse" },
	{ type = "entry", text = "\124T"..hpal_icons.dps..":20:20\124t |cfff58cbaДПС", enabled = false, key = "gui_dps" },
	{ type = "separator" },
	{ type = "title", text = "|cfff58cbaБаф" },
	{ type = "dropdown", menu = {
			{ selected = false, value = GetSpellInfo(25898), text = "|cfff58cbaКаска" },
			{ selected = false, value = GetSpellInfo(48934), text = "|cfff58cbaКулак" },
			{ selected = false, value = GetSpellInfo(48938), text = "|cfff58cbaКрест" },
			{ selected = true, value = 0, text = "|cffff0063Выключено" },
	}, key = "gui_Great_blessing" },
    { type = "entry", text = "\124T"..hpal_icons.Fear..":20:20\124t |cfff58cbaСтрах", enabled = false, key = "gui_Fear" },
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
	ni.GUI.AddFrame("A1 Holy PvE4-1", hpal_gui)
end
local function gui_unload()
	ni.GUI.DestroyFrame("A1 Holy PvE4-1")
end
local CriticalCast = {"Сожжение", "Ледяное дыхание", "Огненное дыхание", "Священный огонь", "Дыхание Пустоты", "Пожирающее пламя", "Ледяные шипы", "Статический сбой", "Чародейские стрелы"}
local dontdispel = {305347, 38791, 30128, 28169, 38806, 70964, 31803, 60814, 68786, 34916, 34917, 34919, 48159, 48160, 30404, 30405, 31117, 34438, 35183, 43522, 47841, 47843, 65812, 68154, 68155, 68156, 44461, 55359, 55360, 55361, 55362, 61429, 30108, 34914, 74562, 74792, 70867, 70338, 70405 }
local OverHealing = {30423, 66118}
local CriticalDebuff = {67050, 70541, 38801, 43093}
local freedomdebuff = {69649, 45524, 1715, 3408, 59638, 20164, 25809, 31589, 51585, 50040, 50041, 31124, 122, 44614, 339, 45334, 58179, 61391, 19306, 19185, 35101, 5116, 2974, 61394, 54644, 50245, 50271, 54706, 4167, 33395, 55080, 6136, 120, 116, 31589, 20170, 31125, 3409, 26679, 64695, 63685, 8056, 8034, 18118, 18223, 63311, 23694, 1715, 12323, 39965, 55536, 13099, 32859, 32065, 22800, 3604, 33967, 12023, 47698, 38316, 15063, 49717 }
for _, v in pairs(dontdispel) do
    ni.healing.debufftoblacklist(v)
end
local CloseEnemies_guid = {}
local function CloseEnemies()
	table.wipe(CloseEnemies_guid)
	CloseEnemies_guid = ni.player.enemiesinrange(5)
	for k, v in ipairs(CloseEnemies_guid) do
		if
		ni.player.threat(v.guid) == -1
		then
			table.remove(CloseEnemies_guid, k)
		end
	end
	return #CloseEnemies_guid
end
local CloseEnemies_guid2 = {}
local function CloseEnemies2()
    table.wipe(CloseEnemies_guid2)
    CloseEnemies_guid2 = ni.player.enemiesinrange(20)
    for k, v in ipairs(CloseEnemies_guid2) do
        if
        ni.player.threat(v.guid) == -1
        then
            table.remove(CloseEnemies_guid2, k)
        end
    end
    return #CloseEnemies_guid2
end
function Tank(t)
    local _, _, class = UnitClass(t)
	if (class == 11
	and ni.unit.aura(t, 9634))
    or (class == 1
	and ni.unit.aura(t, 71))
    or (class == 2
	and ni.unit.aura(t, 25780))
    or (class == 6
	and ni.unit.aura(t, 48263)) then
		return true
	end
	return false
end
local LastSalavation, LastFearing = 0, 0
local HolyShockHealing = (2800 + 0.8057*GetSpellBonusHealing())*1.3955*0.9
local HolyLightHealing = (5786 + 1.66*GetSpellBonusHealing())*1.4182*0.65*0.9
local HolyLightHealingAOE = HolyLightHealing*0.28
local FlashofLightHealing = (932 + 1*GetSpellBonusHealing())*1.2923*0.9
local hpal_rotation = {
    "Assist",
    "Righteous Fury Check",
    "Pause",
    "Divine Shield",
    "Combat Pause",
    "Health Pot",
    "Mana Pot",
    "Healthstone",
    "Hand of Freedom",
    "Seal of Wisdom",
    "Lay on Hands",
    "Divine Plea",
    --"Avenging Wrath",
    "Trinkets",
    "Divine Illumination",
    "Night Elf (Racial)",
    "Divine Favor",
    --"Cleanse Debuff",
    "Sacred Shield",
    "Cleanse",
    "Judgement",
    "Consecration",
    "ShieldOfRighteousness",
    "Holy Light CriticalCast",
    "Holy Light (Targettarget)",
    "Holy Light (Target)",
    "Holy Shock (AOE)",
    "Holy Light (AOE)",
    "Holy Shock",
    "Holy Light",
    "Flash of Light",
    "Beacon of Light",
    "Hammer of Justice",
    "Holy Wrath",
    "Great blessing",
    "T5 Stack",
    --"Holy Light Grace",
    --"Hand of Salvation",
    "Fear",
    "Holy Light no combat",
}
local hpal_abilities = {
    ["Fear"] = function ()
        local _, FearIsON = GetSetting("gui_Fear")
        if FearIsON
        and GetTime() - LastFearing > 18 then
            if not ni.player.issilenced()
            and ni.spell.available(hpal_skills.Fear)
            and not ni.player.ismoving() then
                for j in pairs(CloseEnemies_guid2) do
                    local UndeadOrDemon = CloseEnemies_guid2[j].guid
                    if ni.spell.valid(UndeadOrDemon, hpal_skills.Fear, false, true, false) then
                        if (ni.unit.creaturetype(UndeadOrDemon) == 6 or ni.unit.creaturetype(UndeadOrDemon) == 3)
                        and not ni.unit.debuff(UndeadOrDemon, hpal_skills.Fear) then
                            LastFearing = GetTime()
                            return ni.spell.cast(hpal_skills.Fear, UndeadOrDemon)
                        end
                    end
                end
            end
        end
    end,
    ["Pause"] = function()
        local framerate = GetFramerate()
        if IsMounted()
        or UnitInVehicle("player")
        or ni.player.buff(430)
        or ni.player.buff(433)
        or UnitIsDeadOrGhost("player")
        or UnitIsAFK("player")
        or ni.player.buff(316254)
        or framerate < 18 then
            return true
        end
		ni.vars.debug = select(2, GetSetting("gui_debug"))
		CloseEnemies()
		CloseEnemies2()
    end,
    ["Combat Pause"] = function()
        if IsLeftShiftKeyDown()
        or ni.player.issilenced()
        or ni.player.isconfused()
		or ni.player.isfleeing()
        or ni.player.isstunned()
        or ni.player.iscasting()
        or ni.player.ischanneling()
        or ni.player.debuffstacks(69766) > 4
		or (ni.player.debuff(305131) and ni.player.debuffremaining(305131) < 2)
        or (ni.player.debuff(69762) and ni.player.debuffremaining(69762) > 5) then
            return true
        end
    end,
    ["Assist"] = function()
        if ni.unit.exists("focus") then
            if UnitAffectingCombat("focus")
            and not ni.unit.exists("target") then
                ni.player.runtext("/target focustarget")
            end
        end
        if UnitAffectingCombat("player")
        and UnitIsDeadOrGhost("target") then
            ni.player.runtext("/cleartarget")
        end
    end,
    ["Seal of Wisdom"] = function ()
        if ni.player.buffremaining(hpal_skills.Seal_of_Wisdom) < 33
        and ni.spell.available(hpal_skills.Seal_of_Wisdom) then
            return ni.spell.cast(hpal_skills.Seal_of_Wisdom)
        end
    end,
    ["Divine Plea"] = function ()
        if UnitAffectingCombat("player")
        and not ni.player.buff(hpal_skills.Divine_Plea)
        and ni.player.power() < 35
        and ni.spell.available(hpal_skills.Divine_Plea) then
            return ni.spell.cast(hpal_skills.Divine_Plea)
        end
    end,
    ["Divine Illumination"] = function ()
        if ni.player.buff(hpal_skills.Divine_Plea)
        and ni.spell.cd(hpal_skills.Divine_Illumination) == 0 then
            return ni.spell.cast(hpal_skills.Divine_Illumination)
        end
    end,
    ["Divine Favor"] = function ()
        if ni.spell.cd(hpal_skills.Divine_Favor) == 0
        and IsUsableSpell(hpal_skills.Divine_Favor)
        and UnitAffectingCombat("player") then
            if ni.members.below(75) >= 9 then
                return ni.spell.cast(hpal_skills.Divine_Favor)
            end
        end
    end,
    ["Cleanse Debuff"] = function ()
        local _, enabled = GetSetting("gui_Cleanse")
        if enabled then
            if ni.spell.available(hpal_skills.Cleanse) then
                for _, member in ipairs(ni.members) do
                    if (ni.unit.debuff(member.unit, raid_debuffs.Necrotic_Plague)
                    and ni.unit.debuffremaining(member.unit, raid_debuffs.Necrotic_Plague) < 11)
                    or (ni.unit.debuff(member.unit, raid_debuffs.Fiery_Combustion)
                    and ni.unit.debuffremaining(member.unit, raid_debuffs.Fiery_Combustion) < 24)
                    or (ni.unit.debuff(member.unit, raid_debuffs.Soul_Consumption)
                    and ni.unit.debuffremaining(member.unit, raid_debuffs.Soul_Consumption) < 24)
                    and ni.spell.valid(member.unit, hpal_skills.Cleanse, false, true, true) then
                        return ni.spell.cast(hpal_skills.Cleanse, member.unit)
                    end
                end
            end
        end
    end,
    ["Holy Light no combat"] = function ()
        if not UnitAffectingCombat("player")
        and ni.spell.available(hpal_skills.Holy_Light)
        and not ni.player.ismoving() then
            if ni.members[1].hp < 25
            and ni.spell.valid(ni.members[1].unit, hpal_skills.Holy_Light, false, true, true) then
                return ni.spell.cast(hpal_skills.Holy_Light, ni.members[1].unit)
            end
        end
    end,
    ["T5 Stack"] = function ()
        if UnitAffectingCombat("player")
        and not ni.player.buff(hpal_skills.TwoT5)
        and not ni.player.ismoving()
        and ni.spell.available(hpal_skills.Flash_of_Light) then
            return ni.spell.cast(hpal_skills.Flash_of_Light, "player")
        end
    end,
    ["Holy Light CriticalCast"] = function ()
        if ni.spell.available(hpal_skills.Holy_Light)
        and not ni.player.ismoving() then
            for _, z in ipairs(OverHealing) do
                for _, x in ipairs(CriticalDebuff) do
                    for _, member in ipairs(ni.members) do
                        if ((ni.unit.debuff(member.unit, z) and ni.members[1].hp <= 90)
                        or ni.unit.debuff(member.unit, x))
                        and ni.spell.valid(member.unit, hpal_skills.Holy_Light, false, true, true) then
                            return ni.spell.cast(hpal_skills.Holy_Light, member.unit)
                        end
                    end
                end
            end
        end
    end,
    ["Holy Light"] = function ()
        if ni.spell.available(hpal_skills.Holy_Light)
        and not ni.player.ismoving() then
            if not ni.unit.debuff(ni.members[1].unit, raid_debuffs.Enfeeble)
            and ni.unit.hpraw(ni.members[1].unit) >= HolyLightHealing
            and ni.spell.valid(ni.members[1].unit, hpal_skills.Holy_Light, false, true, true) then
                return ni.spell.cast(hpal_skills.Holy_Light, ni.members[1].unit)
            end
        end
    end,
    ["Holy Shock"] = function ()
        if ni.spell.available(hpal_skills.Holy_Shock) then
            if not ni.unit.debuff(ni.members[1].unit, raid_debuffs.Enfeeble)
            and ni.unit.hpraw(ni.members[1].unit) >= HolyShockHealing
            and ni.spell.available(hpal_skills.Holy_Shock)
            and ni.spell.valid(ni.members[1].unit, hpal_skills.Holy_Shock, false, true, true) then
                return ni.spell.cast(hpal_skills.Holy_Shock, ni.members[1].unit)
            end
        end
    end,
    ["Flash of Light"] = function ()
        if ni.spell.available(hpal_skills.Flash_of_Light)
        and (not ni.unit.ismoving("player") or ni.player.buff(hpal_skills.Infusion_of_Light)) then
            if not ni.unit.debuff(ni.members[1].unit, raid_debuffs.Enfeeble)
            and ni.spell.valid(ni.members[1].unit, hpal_skills.Flash_of_Light, false, true, true)
            and ni.unit.hpraw(ni.members[1].unit) >= FlashofLightHealing then
                return ni.spell.cast(hpal_skills.Flash_of_Light, ni.members[1].unit)
            end
        end
    end,
    ["Lay on Hands"] = function()
        if ni.spell.available(hpal_skills.Lay_on_Hands)
        and UnitAffectingCombat("player") then
            if not ni.unit.debuff(ni.members[1].unit, raid_debuffs.Enfeeble)
            and not ni.unit.debuff(ni.members[1].unit, hpal_skills.Forbearance)
            and ni.members[1].hp < 20
            and ni.spell.valid(ni.members[1].unit, hpal_skills.Lay_on_Hands, false, true, true) then
                return ni.spell.cast(hpal_skills.Lay_on_Hands, ni.members[1].unit)
            end
        end
    end,
    ["Hammer of Justice"] = function()
        if ni.spell.available(hpal_skills.Hammer_of_Justice) then
            for	j in pairs(CloseEnemies_guid) do
                local caster = CloseEnemies_guid[j].guid
                if (ni.unit.iscasting(caster) or ni.unit.ischanneling(caster))
                and ni.spell.valid(caster, hpal_skills.Hammer_of_Justice, true, true) then
                    return ni.spell.cast(hpal_skills.Hammer_of_Justice, caster)
                end
            end
        end
    end,
    ["Beacon of Light"] = function()
        if ni.unit.exists("focus")
        and UnitAffectingCombat("focus") then
            if ni.unit.buffremaining("focus", hpal_skills.Beacon_of_Light, "player") <= 5
            and ni.spell.available(hpal_skills.Beacon_of_Light)
            and ni.spell.valid("focus", hpal_skills.Beacon_of_Light, false, true, true) then
                return ni.spell.cast(hpal_skills.Beacon_of_Light, "focus")
            end
            if not ni.unit.debuff("focus", raid_debuffs.Enfeeble)
            and ni.unit.buff("focus", hpal_skills.Beacon_of_Light, "player") then
                if ni.unit.hpraw("focus") >= HolyLightHealing
                and ni.spell.available(hpal_skills.Holy_Light)
                and ni.spell.valid("focus", hpal_skills.Beacon_of_Light, false, false, true)
                and not ni.player.ismoving() then
                    return ni.spell.cast(hpal_skills.Holy_Light, "player")
                end
                if ni.unit.hpraw("focus") >= HolyShockHealing
                and ni.spell.available(hpal_skills.Holy_Shock)
                and ni.spell.valid("focus", hpal_skills.Beacon_of_Light, false, false, true) then
                    return ni.spell.cast(hpal_skills.Holy_Shock, "player")
                end
            end
        end
    end,
    ["Sacred Shield"] = function()
        if ni.spell.available(hpal_skills.Sacred_Shield) then
            if ni.unit.exists("focus")
            and UnitAffectingCombat("focus") then
                if not ni.unit.buff("focus", hpal_skills.Sacred_Shield, "player")
                and ni.spell.valid("focus", hpal_skills.Sacred_Shield, false, true, true) then
				    return ni.spell.cast(hpal_skills.Sacred_Shield, "focus")
                end
			end
            if not ni.unit.exists("focus")
            and UnitAffectingCombat("player") then
                if not ni.unit.buff("player", hpal_skills.Sacred_Shield, "player") then
				    return ni.spell.cast(hpal_skills.Sacred_Shield, "player")
                end
			end
        end
    end,
    ["Cleanse"] = function()
        local _, enabled = GetSetting("gui_Cleanse")
        if enabled then
            if ni.spell.available(hpal_skills.Cleanse) then
                for i = 1, #ni.members do
                    if ni.unit.debufftype(ni.members[i].unit, "Magic|Disease|Poison")
                    and ni.healing.candispel(ni.members[i].unit)
                    and ni.spell.valid(ni.members[i].unit, hpal_skills.Cleanse, false, true, true) then
                        return ni.spell.delaycast(hpal_skills.Cleanse, ni.members[i].unit, 1.3)
                    end
                end
            end
        end
	end,
    ["Avenging Wrath"] = function()
		if UnitAffectingCombat("player")
        and ni.player.buff(hpal_skills.Divine_Plea)
        and not ni.unit.debuff("player", hpal_skills.Forbearance)
		and ni.spell.available(hpal_skills.Avenging_Wrath) then
			return ni.spell.cast(hpal_skills.Avenging_Wrath)
		end
    end,
    ["Trinkets"] = function()
		if UnitAffectingCombat("player")
        and ni.members.below(75) >= 9
        and ni.player.slotcastable(13)
        and ni.player.slotcastable(14)
        and ni.player.slotcd(13) == 0
        and ni.player.slotcd(14) == 0 then
            ni.player.useinventoryitem(13)
            return ni.player.useinventoryitem(14)
		end
    end,
	["Holy Wrath"] = function()
        if UnitAffectingCombat("player")
        and ni.spell.available(hpal_skills.Holy_Wrath) then
            for	j in pairs(CloseEnemies_guid) do
                local UndeadOrDemon = CloseEnemies_guid[j].guid
                if (ni.unit.creaturetype(UndeadOrDemon) == 6
                or ni.unit.creaturetype(UndeadOrDemon) == 3)
                and not ni.unit.isboss(UndeadOrDemon)
                and ni.unit.iscasting(UndeadOrDemon) then
                    return ni.spell.cast(hpal_skills.Holy_Wrath)
                end
            end
        end
	end,
    ["Hand of Salvation"] = function()
        if UnitAffectingCombat("player") then
            if ni.unit.threat(ni.members[1].unit) > 1
            and not Tank(ni.members[1].unit)
            and not UnitIsUnit("player", ni.members[1].unit)
            and ni.spell.available(hpal_skills.Hand_of_Salvation)
            and ni.spell.valid(ni.members[1].unit, hpal_skills.Hand_of_Salvation, false, true, true) then
                return ni.spell.cast(hpal_skills.Hand_of_Salvation, ni.members[1].unit)
            end
        end
    end,
    ["Judgement"] = function()
        if ni.spell.available(hpal_skills.Svet)
		and ni.unit.hp("target") <= 99.5
        and ni.spell.valid("target", hpal_skills.Svet, false, true)
        and ni.unit.debuffremaining("target", hpal_skills.Svet, "player") <= 5 then
            return ni.spell.cast((hpal_skills.Svet), "target")
        end
    end,
    ["Great blessing"] = function()
		local CurrentBlessing = GetSetting("gui_Great_blessing")
        if CurrentBlessing == 0 then
            return false
        end
            if ni.spell.available(CurrentBlessing)
            and UnitAffectingCombat("player") then
            for _, member in ipairs(ni.members) do
                if ni.unit.buffremaining(member.unit, CurrentBlessing) < 333
                and ni.spell.valid(member.unit, CurrentBlessing, false, true, true) then
                    return ni.spell.cast(CurrentBlessing, member.unit)
                end
            end
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
    ["Hand of Freedom"] = function()
        if ni.spell.available(hpal_skills.Hand_of_Freedom) then
            for _, x in ipairs(freedomdebuff) do
                if ni.unit.debuff(ni.members[1].unit, x)
                and ni.spell.valid(ni.members[1].unit, hpal_skills.Hand_of_Freedom, false, true, true)
                and ni.unit.ismoving(ni.members[1].unit) then
                    return ni.spell.cast(hpal_skills.Hand_of_Freedom, ni.members[1].unit)
                end
            end
        end
    end,
	["Righteous Fury Check"] = function()
        if ni.player.aura(hpal_skills.Righteous_Fury) then
            return CancelUnitBuff("player", hpal_skills.Righteous_Fury);
        end
        if ni.player.aura(hpal_skills.Divine_Sacrifice) then
            return CancelUnitBuff("player", hpal_skills.Divine_Sacrifice);
        end
	end,
    ["Holy Shock (AOE)"] = function()
        if ni.spell.available(hpal_skills.Holy_Shock)
        and ni.player.buff(hpal_skills.TwoT5) then
            if ni.unit.debuff(ni.members[1].unit, raid_debuffs.Enfeeble) then
                return false
            end
            if ni.members.below(70) >= 4 then
                return ni.spell.cast(hpal_skills.Holy_Shock, "player")
            end
        end
    end,
    ["Holy Light (AOE)"] = function()
        if ni.spell.available(hpal_skills.Holy_Light)
        and not ni.unit.ismoving("player") then
            if not ni.unit.debuff(ni.members[1].unit, raid_debuffs.Enfeeble)
            and #ni.members.inrangebelowraw(ni.members[1].unit, 8, HolyLightHealingAOE) >= 4
            and ni.spell.valid(ni.members[1].unit, hpal_skills.Holy_Light, false, true, true) then
                return ni.spell.cast(hpal_skills.Holy_Light, ni.members[1].unit)
            end
        end
    end,
    ["Holy Light (Target)"] = function()
        if (ni.unit.hp("target") < 100 or (UnitAffectingCombat("player") and ni.unit.buff("target", 47893)))
        and ni.spell.available(hpal_skills.Holy_Light)
        and ni.spell.valid("target", hpal_skills.Holy_Light, false, true, true)
        and not ni.unit.ismoving("player") then
            return ni.spell.cast(hpal_skills.Holy_Light, "target")
        end
    end,
    ["Holy Light (Targettarget)"] = function()
        local cast = UnitCastingInfo("target")
        local channel = UnitChannelInfo("target")
        if ni.unit.exists("target")
        and ni.unit.exists("targettarget") then
            for _, x in ipairs(CriticalCast) do
                if (ni.unit.castingpercent("target") > 65
                or ni.unit.ischanneling("target"))
                and cast == x then
                    if ni.spell.available(hpal_skills.Holy_Light)
                    and ni.spell.valid("targettarget", hpal_skills.Holy_Light, false, true, true)
                    and not ni.unit.ismoving("player") then
                        return ni.spell.cast(hpal_skills.Holy_Light, "targettarget")
                    end
                end
            end
        end
    end,
    ["Night Elf (Racial)"] = function()
        local cast = UnitCastingInfo("target")
        if ni.unit.exists("target") and ni.unit.exists("targettarget") then
            for _, x in ipairs(CriticalCast) do
                if cast == x then
                    if ni.spell.cd(hpal_skills.Racial) == 0
                    and ni.spell.valid("targettarget", hpal_skills.Racial, false, true, true) then
                        return ni.spell.cast(hpal_skills.Racial, "targettarget")
                    end
                end
            end
        end
    end,
	["Health Pot"] = function()
		if UnitAffectingCombat("player")
		and not ni.player.debuff(raid_debuffs.Enfeeble) then
			if ni.player.hp() < 15
            and ni.player.hasitem(pots.Health)
            and ni.player.itemcd(pots.Health) == 0 then
                return ni.player.useitem(pots.Health)
            end
        end
    end,
    ["Mana Pot"] = function()
		if UnitAffectingCombat("player")
        and ni.player.power() < 5
        and ni.player.hasitem(pots.Mana)
        and ni.player.itemcd(pots.Mana) == 0 then
            return ni.player.useitem(pots.Mana)
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
    ["ShieldOfRighteousness"] = function ()
        local _, dpsison = GetSetting("gui_dps")
        if dpsison then
            if not ni.player.isdisarmed() then
                if ni.spell.available(hpal_skills.ShieldOfRighteousness)
                and ni.spell.valid("target", hpal_skills.ShieldOfRighteousness, true, true, false) then
                    return ni.spell.cast(hpal_skills.ShieldOfRighteousness)
                end
            end
        end
    end,
    ["Consecration"] = function ()
        local _, dpsison = GetSetting("gui_dps")
        if dpsison then
            if ni.spell.available(hpal_skills.Consecration)
            and ni.spell.valid("target", hpal_skills.ShieldOfRighteousness, false, true, false) then
                return ni.spell.cast(hpal_skills.Consecration)
            end
        end
    end,
}
ni.bootstrap.profile("A1 - Holy Paladin PvE 4.1", hpal_rotation, hpal_abilities, gui_load, gui_unload)