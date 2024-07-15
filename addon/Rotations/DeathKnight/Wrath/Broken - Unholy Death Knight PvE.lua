local udk_icons = {
    Chains_of_Ice = select(3, GetSpellInfo(45524)),
    Pestilence = select(3, GetSpellInfo(50842)),
    Mind_Freeze = select(3, GetSpellInfo(47528)),
}
local udk_skills = {
    Auto_Attack = GetSpellInfo(6603),
    Rune_Strike = GetSpellInfo(56815),
    Frost_Fever = GetSpellInfo(55095),
    Icy_Touch = GetSpellInfo(49909),
    Blood_Plague = GetSpellInfo(55078),
    Plague_Strike = GetSpellInfo(49921),
    Scourge_Strike = GetSpellInfo(55271),
    Blood_Strike = GetSpellInfo(49930),
    Pestilence = GetSpellInfo(50842),
    Death_and_Decay = GetSpellInfo(49938),
    Mind_Freeze = GetSpellInfo(47528),
    Death_Strike = GetSpellInfo(49924),
    Strangulate = GetSpellInfo(47476),
    Horn_of_Winter = GetSpellInfo(57623),
    Strength_of_Earth = GetSpellInfo(58646),
    Blood_Tap = GetSpellInfo(45529),
    Death_Coil = GetSpellInfo(49895),
    Empower_Rune_Weapon = GetSpellInfo(47568),
    Summon_Gargoyle = GetSpellInfo(49206),
    Shard = GetSpellInfo(316466),
    Chains_of_Ice = GetSpellInfo(45524),
    Blood_Boil = GetSpellInfo(49941),
    Icebound_Fortitude = GetSpellInfo(48792),
    Raise_Dead = GetSpellInfo(46584),
    Eredar_Blink = GetSpellInfo(316465),
}
local udk_gui = {
    settingsfile = "Broken - Unholy Death Knight PvE.json",
{
    type = "title",
    text = "|cff00ccffBroken |cffffffff- Unholy Death Knight PvE - |cff888888v0.0.1",
},
{
    type = "separator",
},
{
    type = "entry",
    text = "\124T"..udk_icons.Chains_of_Ice..":22:22\124t |cffdc0a17Ледяные оковы",
    enabled = false,
    key = "gui_Chains_of_Ice",
},
{
    type = "entry",
    text = "\124T"..udk_icons.Pestilence..":22:22\124t |cffdc0a17Мор",
    enabled = false,
    value = 3,
    min = 2,
    max = 10,
    step = 1,
    width = 30,
    key = "gui_Pestilence",
},
{
    type = "entry",
    text = "\124T"..udk_icons.Mind_Freeze..":22:22\124t |cffdc0a17Заморозка разума",
    enabled = false,
    key = "gui_Mind_Freeze",
},
{
    type = "entry",
    text = "|cffdc0a17Тринкеты",
    enabled = false,
    key = "gui_Trinkets",
},
{
    type = "separator",
},
{
    type = "entry",
    text = "|cffdc0a17Лог",
    enabled = false,
    key = "gui_debug",
},
}

local function GetSetting(name)
for k, v in ipairs(udk_gui) do
    if v.type == "entry"
    and v.key ~= nil
    and v.key == name then
        return v.value, v.enabled
    end
end
end

local function gui_load()
ni.GUI.AddFrame("Broken - Unholy Death Knight PvE", udk_gui);
end

local function gui_unload()
ni.GUI.DestroyFrame("Broken - Unholy Death Knight PvE");
end
local guid_enemies = {}
local function GUID_Enemies()
	table.wipe(guid_enemies)
	guid_enemies = ni.player.enemiesinrange(6)
	for k, v in ipairs(guid_enemies) do
		if ni.player.threat(v.guid) == -1 then
			table.remove(guid_enemies, k)
		end
	end
	return #guid_enemies
end
local lastaction = 0
local udk_rotation = {
    "Cache",
    "Eredar Blink",
    "Pause",
    "Raise Dead",
    "Mind Freeze",
    "Strangulation",
    "Eredar Shard",
    "Icebound Fortitude",
    "Healthstone",
    "Horn of Winter",
    "Combat Pause",
    "Attacking",
    "Trinkets",
    "Death and Decay",
    "Rune Strike",
    "Summon Gargoyle",
    "Empower Rune Weapon",
    "Blood Tap",
    "Pestilence",
    "Blood Boil",
    "Icy Touch",
    "Plague Strike",
    "Death Strike",
    "Scourge Strike",
    "Bloody Strike",
    "Death Coil",
}
local udk_functions = {
    ["Pause"] = function()
        if IsMounted()
        or UnitInVehicle("player")
        or ni.player.buff(430)
        or ni.player.buff(433)
        or UnitIsDeadOrGhost("player")
		or IsLeftShiftKeyDown() then
            return true
        end
		ni.vars.debug = select(2, GetSetting("gui_debug"))
    end,
    ["Combat Pause"] = function ()
        if IsLeftShiftKeyDown()
        or ni.player.issilenced()
        or ni.player.isconfused()
		or ni.player.isfleeing()
        or ni.player.isstunned()
        or ni.player.iscasting()
        or ni.player.ischanneling()
        or GetTime() - lastaction < 0.3
		or ni.player.debuffstacks(70106) > 4
        or ni.unit.hp("target") > 99.7 then
			return true
        end
    end,
	["Cache"] = function()
		GUID_Enemies()
	end,
	["Attacking"] = function()
		if ni.unit.exists("target")
        and UnitCanAttack("player", "target")
        and ni.player.inmelee("target")
        and not UnitIsDeadOrGhost("target")
		and not IsCurrentSpell(udk_skills.Auto_Attack) then
			ni.spell.cast(udk_skills.Auto_Attack)
		end
		if (ni.unit.exists("target")
		and UnitCanAttack("player", "target")
		and not (ni.player.inmelee("target") or ni.player.isfacing("target"))
		and IsCurrentSpell(udk_skills.Auto_Attack))
        or IsLeftShiftKeyDown() then
			ni.player.runtext("/stopattack")
		end
		if UnitAffectingCombat("player")
		and #guid_enemies >= 1
		and (not ni.unit.exists("target") or (ni.unit.exists("target") and not UnitCanAttack("player", "target"))) then
			ni.player.runtext("/targetenemy")
		end
	end,
	["Rune Strike"] = function()
		if IsUsableSpell(udk_skills.Rune_Strike)
        and not IsCurrentSpell(udk_skills.Rune_Strike)
        and ni.player.power() > 20
		and ni.spell.valid("target", udk_skills.Plague_Strike, true, true, false) then
			return ni.spell.cast(udk_skills.Rune_Strike)
		end
	end,
	["Icy Touch"] = function()
		local _, ChainsOfIceIsOn = GetSetting("gui_Chains_of_Ice")
		if not ChainsOfIceIsOn then
            if ni.spell.available(udk_skills.Icy_Touch)
            and ni.spell.valid("target", udk_skills.Icy_Touch, true, true, false)
            and ni.unit.debuffremaining("target", udk_skills.Frost_Fever, "player") < 2 then
                lastaction = GetTime()
                return ni.spell.cast(udk_skills.Icy_Touch)
            end
        end
        if ChainsOfIceIsOn then
            if ni.spell.available(udk_skills.Chains_of_Ice)
            and ni.spell.valid("target", udk_skills.Chains_of_Ice, true, true, false)
            and not ni.unit.debuff("target", udk_skills.Chains_of_Ice, "player") then
                lastaction = GetTime()
                return ni.spell.cast(udk_skills.Chains_of_Ice)
            end
        end
	end,
	["Plague Strike"] = function()
		local _, UnholyRune = ni.rune.unholyrunecd()
		if ni.spell.available(udk_skills.Plague_Strike)
		and ni.spell.valid("target", udk_skills.Plague_Strike, true, true, false)
		and ((not ni.unit.debuff("target", udk_skills.Blood_Plague, "player"))
        or (ni.rune.available() == 1 and UnholyRune >= 1)) then
            lastaction = GetTime()
			return ni.spell.cast(udk_skills.Plague_Strike)
		end
	end,
	["Scourge Strike"] = function()
		if ni.spell.available(udk_skills.Scourge_Strike)
		and ni.spell.valid("target", udk_skills.Scourge_Strike, true, true, false)
		and ni.unit.debuff("target", udk_skills.Frost_Fever, "player")
        and ni.unit.debuff("target", udk_skills.Blood_Plague, "player") then
            lastaction = GetTime()
			return ni.spell.cast(udk_skills.Scourge_Strike)
		end
	end,
	["Bloody Strike"] = function()
		if ni.spell.available(udk_skills.Blood_Strike)
		and ni.spell.valid("target", udk_skills.Blood_Strike, true, true, false)
		and ni.unit.debuff("target", udk_skills.Frost_Fever, "player")
        and ni.unit.debuff("target", udk_skills.Blood_Plague, "player") then
            lastaction = GetTime()
			return ni.spell.cast(udk_skills.Blood_Strike)
		end
	end,
	["Death Strike"] = function()
		if ni.player.hp() < 75
		and ni.spell.available(udk_skills.Death_Strike)
		and ni.spell.valid("target", udk_skills.Death_Strike, true, true, false)
		and ni.unit.debuff("target", udk_skills.Frost_Fever, "player")
        and ni.unit.debuff("target", udk_skills.Blood_Plague, "player") then
            lastaction = GetTime()
			return ni.spell.cast(udk_skills.Death_Strike)
		end
	end,
    ["Pestilence"] = function()
        local EnemyCount, PestilenceIsOn = GetSetting("gui_Pestilence")
        if PestilenceIsOn then
            for y in ipairs(guid_enemies) do
                local InfestedEnemy = guid_enemies[y].guid
                if ni.spell.available(udk_skills.Pestilence)
                and ni.spell.valid("target", udk_skills.Plague_Strike, true, true, false)
                and #guid_enemies >= EnemyCount
                and not UnitIsUnit("target", InfestedEnemy)
                and not ni.unit.debuff(InfestedEnemy, udk_skills.Frost_Fever, "player")
                and not ni.unit.debuff(InfestedEnemy, udk_skills.Blood_Plague, "player") then
                    lastaction = GetTime()
                    return ni.spell.cast(udk_skills.Pestilence)
                end
            end
			if ni.spell.available(udk_skills.Pestilence)
			and ni.spell.valid("target", udk_skills.Plague_Strike, true, true, false)
			and ((ni.unit.debuff("target", udk_skills.Frost_Fever, "player") and ni.unit.debuffremaining("target", udk_skills.Frost_Fever, "player") <= 7)
			or (ni.unit.debuff("target", udk_skills.Blood_Plague, "player") and ni.unit.debuffremaining("target", udk_skills.Blood_Plague, "player") <= 7)) then
                lastaction = GetTime()
				return ni.spell.cast(udk_skills.Pestilence)
			end
        end
    end,
	["Death and Decay"] = function()
		local EnemyCount, DeathandDeacayIsOn = GetSetting("gui_Pestilence")
		if DeathandDeacayIsOn then
            if ni.spell.available(udk_skills.Death_and_Decay)
            and #guid_enemies >= EnemyCount then
                lastaction = GetTime()
                return ni.spell.castat(udk_skills.Death_and_Decay, "player")
            end
        end
	end,
	["Blood Tap"] = function()
		if ni.rune.bloodrunecd() == 2
        and ni.spell.cd(udk_skills.Blood_Tap) == 0 then
			return ni.spell.cast(udk_skills.Blood_Tap)
		end
	end,
	["Mind Freeze"] = function()
		local _, MindFreezIsOn = GetSetting("gui_Mind_Freeze");
		if MindFreezIsOn then
            if ni.spell.cd(udk_skills.Mind_Freeze) == 0
            and ni.spell.valid("target", udk_skills.Mind_Freeze, true, true, false)
            and ni.spell.shouldinterrupt("target") then
                return ni.spell.cast(udk_skills.Mind_Freeze)
            end
        end
	end,
	["Strangulation"] = function()
		local _, StrangulationIsOn = GetSetting("gui_Mind_Freeze");
		if StrangulationIsOn then
            if ni.spell.available(udk_skills.Strangulation)
            and ni.spell.valid("target", udk_skills.Strangulation, true, true, false)
            and ni.unit.iscasting("target") then
                return ni.spell.cast(udk_skills.Strangulation)
            end
        end
	end,
    ["Horn of Winter"] = function()
        if ni.player.buff(udk_skills.Strength_of_Earth) then
            return false
        end
        if ni.spell.available(udk_skills.Horn_of_Winter)
        and (not ni.player.buff(udk_skills.Horn_of_Winter)
        or ni.player.buffremaining(udk_skills.Horn_of_Winter) <= 10) then
            return ni.spell.cast(udk_skills.Horn_of_Winter)
        end
        if ni.spell.available(udk_skills.Horn_of_Winter)
        and ni.rune.available() == 0 then
            return ni.spell.cast(udk_skills.Horn_of_Winter)
        end
    end,
	["Death Coil"] = function()
		if ni.spell.available(udk_skills.Death_Coil)
    	and ni.spell.valid("target", udk_skills.Death_Coil, true, true)
		and (ni.rune.available() == 0
        or not ni.player.inmelee("target")) then
            lastaction = GetTime()
			return ni.spell.cast(udk_skills.Death_Coil)
		end
	end,
	["Empower Rune Weapon"] = function()
		if ni.rune.available() == 0
		and ni.spell.cd(udk_skills.Blood_Tap) ~= 0
		and ni.spell.cd(udk_skills.Empower_Rune_Weapon) == 0
		and ni.unit.isboss("target") then
			return ni.spell.cast(udk_skills.Empower_Rune_Weapon)
		end
	end,
	["Summon Gargoyle"] = function()
		if ni.spell.available(udk_skills.Summon_Gargoyle)
		and ni.unit.isboss("target") then
			return ni.spell.cast(udk_skills.Summon_Gargoyle)
		end
	end,
	["Eredar Shard"] = function()
		if UnitAffectingCombat("player")
		and ni.spell.valid("target", udk_skills.Plague_Strike, false, true)
		and ni.player.hasitem(18)
		and GetItemCount(18) > 1
		and not ni.player.buff(udk_skills.Shard)
		and ni.spell.cd(udk_skills.Shard) == 0 then
			return ni.spell.cast(udk_skills.Shard)
		end
	end,
	["Eredar Blink"] = function()
		if IsLeftControlKeyDown()
		and IsFalling()
		and ni.spell.cd(udk_skills.Eredar_Blink) == 0 then
			ni.spell.cast(udk_skills.Eredar_Blink)
			return ni.player.clickat("mouse")
		end
	end,
	["Blood Boil"] = function()
		local value, BloodBoilIsOn = GetSetting("gui_Pestilence");
		if BloodBoilIsOn then
            for y in ipairs(guid_enemies) do
                local InfestedEnemy = guid_enemies[y].guid
                if ni.spell.available(udk_skills.Blood_Boil)
                and ni.spell.valid("target", udk_skills.Plague_Strike, false, true)
                and #guid_enemies >= value
                and not UnitIsUnit("target", InfestedEnemy)
                and ni.unit.debuff(InfestedEnemy, udk_skills.Frost_Fever, "player")
                and ni.unit.debuff(InfestedEnemy, udk_skills.Blood_Plague, "player") then
                    lastaction = GetTime()
                    return ni.spell.cast(udk_skills.Blood_Boil)
                end
			end
		end
	end,
    ["Icebound Fortitude"] = function()
        if UnitAffectingCombat("player") then
            if ni.spell.cd(udk_skills.Icebound_Fortitude) == 0
            and ni.player.power() > 20
            and ni.player.hp() <= 33 then
                return ni.spell.cast(udk_skills.Icebound_Fortitude)
            end
        end
    end,
    ["Healthstone"] = function()
        local hstones = { 36892, 36893, 36894 }
        for i = 1, #hstones do
            if UnitAffectingCombat("player")
            and ni.player.hp() < 33
            and ni.player.hasitem(hstones[i])
            and ni.player.itemcd(hstones[i]) == 0 then
                return ni.player.useitem(hstones[i])
            end
        end
    end,
    ["Trinkets"] = function()
        local _, enabled = GetSetting("gui_Trinkets")
        if enabled and UnitAffectingCombat("player")
        and ni.player.buff(53365) then
            if ni.player.slotcastable(13)
            and ni.player.slotcd(13) == 0 then
                return ni.player.useinventoryitem(13)
            end
            if ni.player.slotcastable(14)
            and ni.player.slotcd(14) == 0 then
                return ni.player.useinventoryitem(14)
            end
        end
    end,
	["Raise Dead"] = function()
		if not ni.unit.exists("playerpet")
		and not ni.player.buff(61431)
		and ni.spell.available(udk_skills.Raise_Dead) then
			return ni.spell.cast(udk_skills.Raise_Dead)
		end
	end,
}
ni.bootstrap.profile("Broken - Unholy Death Knight PvE", udk_rotation, udk_functions, gui_load, gui_unload)