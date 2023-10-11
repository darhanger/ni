local bdkt_icons = {
    Chains_of_Ice = select(3, GetSpellInfo(45524)),
    Pestilence = select(3, GetSpellInfo(50842)),
    Mind_Freeze = select(3, GetSpellInfo(47528)),
    Vampiric_Blood = select(3, GetSpellInfo(55233)),
    Dark_Command = select(3, GetSpellInfo(56222)),
}
local bdkt_skills = {
    Auto_Attack = GetSpellInfo(6603),
    Icy_Touch = GetSpellInfo(49909),
    Frost_Fever = GetSpellInfo(55095),
    Plague_Strike = GetSpellInfo(49921),
    Blood_Plague = GetSpellInfo(55078),
    Dark_Command = GetSpellInfo(56222),
    Blood_Strike = GetSpellInfo(49930),
    Death_Strike = GetSpellInfo(49924),
    Heart_Strike = GetSpellInfo(55262),
    Pestilence = GetSpellInfo(50842),
    Death_and_Decay = GetSpellInfo(49938),
    Blood_Boil = GetSpellInfo(49941),
    Mind_Freeze = GetSpellInfo(47528),
    Strangulate = GetSpellInfo(47476),
    Rune_Strike = GetSpellInfo(56815),
    Death_Coil = GetSpellInfo(49895),
    Horn_of_Winter = GetSpellInfo(57623),
    Vampiric_Blood = GetSpellInfo(55233),
    Icebound_Fortitude = GetSpellInfo(48792),
    Rune_Tap = GetSpellInfo(48982),
    Blood_Tap = GetSpellInfo(45529),
    Empower_Rune_Weapon = GetSpellInfo(47568),
    Shard = GetSpellInfo(316466),
    Raise_Dead = GetSpellInfo(46584),
    Death_Pact = GetSpellInfo(48743),
    Eredar_Blink = GetSpellInfo(316465),
    Chains_of_Ice = GetSpellInfo(45524),
    Strength_of_Earth = GetSpellInfo(58646),
}
local bdkt_gui = {
	settingsfile = "A1 Blood Death Knight Tank PvE 1.1.json",
	{ type = "title", text = "|cff8b102cBlood Death Knight Tank PvE |cffcece0cA1 v1.1" },
	{ type = "separator" },
    { type = "entry", text = "\124T"..bdkt_icons.Dark_Command..":22:22\124t |cff8b102cТаунт", enabled = true, key = "gui_Taunts" },
	{ type = "entry", text = "\124T"..bdkt_icons.Chains_of_Ice..":22:22\124t |cff8b102cЛедяные оковы", enabled = false, key = "gui_Chains_of_Ice" },
	{ type = "entry", text = "\124T"..bdkt_icons.Mind_Freeze..":22:22\124t |cff8b102cЗаморозка разума", enabled = false, key = "gui_Mind_Freeze" },
	{ type = "entry", text = "\124T"..bdkt_icons.Pestilence..":22:22\124t |cff8b102cМор", enabled = false, value = 3, min = 2, max = 10, step = 1, width = 30, key = "gui_Pestilence" },
	{ type = "entry", text = "\124T"..bdkt_icons.Vampiric_Blood..":22:22\124t |cff8b102cСейвы", enabled = false, value = 20, min = 5, max = 65, step = 1, width = 30, key = "gui_Saves" },
	{ type = "entry", text = "|cff8b102cТринкеты", enabled = false, key = "gui_Trinkets" },
    { type = "separator" },
	{ type = "entry", text = "|cff8b102cЛог", enabled = false, key = "gui_debug" },
}
local function GetSetting(name)
for _, v in ipairs(bdkt_gui) do
  if v.type == "entry"
  and v.key ~= nil
  and v.key == name then
    return v.value, v.enabled
  end
  if v.type == "dropdown"
    and v.key ~= nil
    and v.key == name then
      for _, v2 in pairs(v.menu) do
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
	ni.GUI.AddFrame("A1 BDK Tank", bdkt_gui)
end
local function gui_unload()
	ni.GUI.DestroyFrame("A1 BDK Tank")
end
local guid_enemies = {}
local guid_highrangeenemies = {}
local blacklistedmonster = {17990, 20189, 34605, 34650, 12380, 7370, 11262, 36566, 34813, 35265}
local function BlackListedMonster(t)
	for _, v in pairs(blacklistedmonster) do
		if
		ni.unit.exists(t)
		and v == ni.unit.id(t)
		then
			return true
		end
	end
	return false
end
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
local function ActiveHighRangeEnemies()
	table.wipe(guid_highrangeenemies)
	guid_highrangeenemies = ni.player.enemiesinrange(30)
	for k, v in ipairs(guid_highrangeenemies) do
		if
		ni.player.threat(v.guid) == -1
		then
			table.remove(guid_highrangeenemies, k)
		end
	end
	return #guid_highrangeenemies
end
local lasttaunt = 0
local bdkt_rotation = {
    "Cache",
    "Eredar Blink",
    "Pause",
    "Auto Saves",
    "Mind Freeze",
    "Strangulation",
    "Healthstone",
    "Trinkets",
    "Attacking",
    "Taunt_provoke",
    "Rune Strike",
    "Horn of Winter",
    "Empower Rune Weapon",
    "Death and Decay",
    "Pestilence",
    "Blood Boil",
    "Icy Touch",
    "Plague Strike",
    "Bloody Strike",
    "Heart Strike",
    "Death Strike",
    "Death Coil",
}
local bdkt_functions = {
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
		ni.vars.debug = select(2, GetSetting("gui_debug"))
    end,
	["Cache"] = function()
		GUID_Enemies()
        ActiveHighRangeEnemies()
	end,
	["Attacking"] = function()
		if ni.unit.exists("target")
        and UnitCanAttack("player", "target")
        and ni.player.inmelee("target")
        and not UnitIsDeadOrGhost("target")
		and not IsCurrentSpell(bdkt_skills.Auto_Attack) then
			ni.spell.cast(bdkt_skills.Auto_Attack)
        elseif (ni.unit.exists("target")
		and UnitCanAttack("player", "target")
		and not (ni.player.inmelee("target") or ni.player.isfacing("target")))
        or IsLeftShiftKeyDown() then
			ni.player.runtext("/stopattack")
		elseif UnitAffectingCombat("player")
		--and #guid_enemies >= 1
		and (not ni.unit.exists("target") or (ni.unit.exists("target") and not UnitCanAttack("player", "target"))) then
			ni.player.runtext("/targetenemy")
		end
	end,
	["Icy Touch"] = function()
		local _, ChainsOfIceIsOn = GetSetting("gui_Chains_of_Ice")
		if not ChainsOfIceIsOn then
            if ni.spell.available(bdkt_skills.Icy_Touch)
            and ni.spell.valid("target", bdkt_skills.Icy_Touch, true, true, false)
            and (ni.unit.debuffremaining("target", bdkt_skills.Frost_Fever, "player") < 2
            or (ni.unit.debuffremaining("target", bdkt_skills.Frost_Fever, "player") < 15 and ni.unit.isboss("target"))) then
                return ni.spell.cast(bdkt_skills.Icy_Touch)
            end
        end
        if ChainsOfIceIsOn then
            if ni.spell.available(bdkt_skills.Chains_of_Ice)
            and ni.spell.valid("target", bdkt_skills.Chains_of_Ice, true, true, false)
            and not ni.unit.debuff("target", bdkt_skills.Chains_of_Ice, "player") then
                ni.spell.cast(bdkt_skills.Chains_of_Ice)
            end
        end
	end,
	["Plague Strike"] = function()
		local _, UnholyRune = ni.rune.unholyrunecd()
		if ni.spell.available(bdkt_skills.Plague_Strike)
		and ni.spell.valid("target", bdkt_skills.Plague_Strike, true, true, false)
		and ((not ni.unit.debuff("target", bdkt_skills.Blood_Plague, "player"))
        or (ni.rune.available() == 1 and UnholyRune >= 1)) then
			return ni.spell.cast(bdkt_skills.Plague_Strike)
		end
	end,
	["Bloody Strike"] = function()
		if #guid_enemies == 1
        and ni.spell.available(bdkt_skills.Blood_Strike)
		and ni.spell.valid("target", bdkt_skills.Blood_Strike, true, true, false)
		and ni.unit.debuff("target", bdkt_skills.Frost_Fever, "player")
        and ni.unit.debuff("target", bdkt_skills.Blood_Plague, "player") then
			ni.spell.cast(bdkt_skills.Blood_Strike)
		end
	end,
	["Heart Strike"] = function()
		if #guid_enemies >= 2
        and ni.spell.available(bdkt_skills.Heart_Strike)
		and ni.spell.valid("target", bdkt_skills.Heart_Strike, true, true, false)
		and ni.unit.debuff("target", bdkt_skills.Frost_Fever, "player")
        and ni.unit.debuff("target", bdkt_skills.Blood_Plague, "player") then
			ni.spell.cast(bdkt_skills.Heart_Strike)
		end
	end,
	["Death Strike"] = function()
		if ni.spell.available(bdkt_skills.Death_Strike)
		and ni.spell.valid("target", bdkt_skills.Death_Strike, true, true, false)
		and ni.unit.debuff("target", bdkt_skills.Frost_Fever, "player")
        and ni.unit.debuff("target", bdkt_skills.Blood_Plague, "player") then
			ni.spell.cast(bdkt_skills.Death_Strike)
		end
	end,
    ["Pestilence"] = function()
        local EnemyCount, PestilenceIsOn = GetSetting("gui_Pestilence")
        if PestilenceIsOn then
            for y in ipairs(guid_enemies) do
                local InfestedEnemy = guid_enemies[y].guid
                if ni.spell.available(bdkt_skills.Pestilence)
                and ni.spell.valid("target", bdkt_skills.Plague_Strike, true, true, false)
                and #guid_enemies >= EnemyCount
                and ni.unit.debuff("target", bdkt_skills.Frost_Fever, "player")
                and ni.unit.debuff("target", bdkt_skills.Blood_Plague, "player")
                and not ni.unit.debuff(InfestedEnemy, bdkt_skills.Frost_Fever, "player")
                and not ni.unit.debuff(InfestedEnemy, bdkt_skills.Blood_Plague, "player") then
                    ni.spell.cast(bdkt_skills.Pestilence)
                end
            end
			if ni.spell.available(bdkt_skills.Pestilence)
			and ni.spell.valid("target", bdkt_skills.Plague_Strike, true, true, false)
			and ni.unit.debuff("target", bdkt_skills.Frost_Fever, "player")
            and ni.unit.debuff("target", bdkt_skills.Blood_Plague, "player")
            and (ni.unit.debuffremaining("target", bdkt_skills.Frost_Fever, "player") <= 7
			or ni.unit.debuffremaining("target", bdkt_skills.Blood_Plague, "player") <= 7) then
				ni.spell.cast(bdkt_skills.Pestilence)
			end
        end
    end,
	["Death and Decay"] = function()
		local EnemyCount, DeathandDeacayIsOn = GetSetting("gui_Pestilence")
		if DeathandDeacayIsOn then
            if ni.spell.available(bdkt_skills.Death_and_Decay)
            and #guid_enemies >= EnemyCount-1 then
                ni.spell.castat(bdkt_skills.Death_and_Decay, "player")
            end
        end
	end,
	["Blood Boil"] = function()
		local value, BloodBoilIsOn = GetSetting("gui_Pestilence");
		if BloodBoilIsOn then
            for y in ipairs(guid_enemies) do
                local InfestedEnemy = guid_enemies[y].guid
                if ni.spell.available(bdkt_skills.Blood_Boil)
                and ni.spell.valid("target", bdkt_skills.Plague_Strike, false, true)
                and #guid_enemies >= value
                and ni.unit.debuff(InfestedEnemy, bdkt_skills.Frost_Fever, "player")
                and ni.unit.debuff(InfestedEnemy, bdkt_skills.Blood_Plague, "player") then
                    ni.spell.cast(bdkt_skills.Blood_Boil)
                end
			end
		end
	end,
	["Mind Freeze"] = function()
		local _, MindFreezIsOn = GetSetting("gui_Mind_Freeze");
		if MindFreezIsOn then
            if ni.spell.cd(bdkt_skills.Mind_Freeze) == 0
            and ni.spell.valid("target", bdkt_skills.Mind_Freeze, true, true, false)
            and ni.spell.shouldinterrupt("target") then
                return ni.spell.cast(bdkt_skills.Mind_Freeze)
            end
        end
	end,
	["Strangulation"] = function()
		local _, StrangulationIsOn = GetSetting("gui_Mind_Freeze");
		if StrangulationIsOn then
            if ni.spell.available(bdkt_skills.Strangulation)
            and ni.spell.valid("target", bdkt_skills.Strangulation, true, true, false)
            and ni.unit.iscasting("target") then
                return ni.spell.cast(bdkt_skills.Strangulation)
            end
        end
	end,
	["Rune Strike"] = function()
		if IsUsableSpell(bdkt_skills.Rune_Strike)
        and not IsCurrentSpell(bdkt_skills.Rune_Strike)
        and ni.player.power() > 20
		and ni.spell.valid("target", bdkt_skills.Plague_Strike, true, true, false) then
			ni.spell.cast(bdkt_skills.Rune_Strike)
		end
	end,
    ["Horn of Winter"] = function()
        if ni.player.buff(bdkt_skills.Strength_of_Earth) then
            return false
        end
        if ni.player.buffremaining(bdkt_skills.Horn_of_Winter) < 90 then
            if ni.spell.available(bdkt_skills.Horn_of_Winter) then
                ni.spell.cast(bdkt_skills.Horn_of_Winter)
            end
        end
    end,
	["Death Coil"] = function()
		if ni.spell.available(bdkt_skills.Death_Coil)
    	and ni.spell.valid("target", bdkt_skills.Death_Coil, true, true)
		and (ni.rune.available() == 0
        or not ni.player.inmelee("target")) then
			ni.spell.cast(bdkt_skills.Death_Coil)
		end
	end,
	["Empower Rune Weapon"] = function()
		if ni.rune.available() == 0
		and ni.spell.cd(bdkt_skills.Blood_Tap) ~= 0
		and ni.spell.cd(bdkt_skills.Empower_Rune_Weapon) == 0
		and ni.unit.isboss("target") then
			ni.spell.cast(bdkt_skills.Empower_Rune_Weapon)
		end
	end,
    ["Auto Saves"] = function()
        local SavesHP, SavesisOn = GetSetting("gui_Saves")
        if SavesisOn
        and UnitAffectingCombat("player") then
            if ni.spell.cd(bdkt_skills.Icebound_Fortitude) == 0
            and ni.player.power() >= 20
            and ni.spell.available(bdkt_skills.Vampiric_Blood)
            and ni.player.hp() < SavesHP then
                ni.spell.cast(bdkt_skills.Icebound_Fortitude)
                return ni.spell.cast(bdkt_skills.Vampiric_Blood)
            end
            if ni.spell.available(bdkt_skills.Rune_Tap)
            and (ni.player.buff(bdkt_skills.Icebound_Fortitude)
            or ni.player.buff(bdkt_skills.Vampiric_Blood)) then
                return ni.spell.cast(bdkt_skills.Rune_Tap)
            end
            if not (ni.player.buff(bdkt_skills.Icebound_Fortitude)
            or ni.player.buff(bdkt_skills.Vampiric_Blood))
            and ni.spell.available(bdkt_skills.Rune_Tap)
            and ni.player.hp() <= SavesHP + 30 then
                return ni.spell.cast(bdkt_skills.Rune_Tap)
            end
            if ni.spell.available(bdkt_skills.Raise_Dead)
            and ni.spell.cd(bdkt_skills.Death_Pact) == 0
            and ni.player.power() >= 40
            and ni.spell.cd(bdkt_skills.Vampiric_Blood) ~= 0
            and ni.player.hp() <= SavesHP then
                return ni.spell.cast(bdkt_skills.Raise_Dead)
            end
            if ni.unit.exists("playerpet")
            and ni.player.hp() <= SavesHP then
                return ni.spell.cast(bdkt_skills.Death_Pact)
            end
        end
    end,
	["Eredar Shard"] = function()
		if UnitAffectingCombat("player")
		and ni.spell.valid("target", bdkt_skills.Plague_Strike, false, true)
		and ni.player.hasitem(18)
		and GetItemCount(18) > 1
		and not ni.player.buff(bdkt_skills.Shard)
		and ni.spell.cd(bdkt_skills.Shard) == 0 then
			ni.spell.cast(bdkt_skills.Shard)
		end
	end,
    ["Healthstone"] = function()
        local hstones = { 36892, 36893, 36894 }
        for i = 1, #hstones do
            if UnitAffectingCombat("player")
            and ni.player.hp() < 33
            and ni.player.hasitem(hstones[i])
            and ni.player.itemcd(hstones[i]) == 0 then
                ni.player.useitem(hstones[i])
            end
        end
    end,
    ["Trinkets"] = function()
        local _, enabled = GetSetting("gui_Trinkets")
        if enabled and UnitAffectingCombat("player")
        and ni.player.hp() < 70 then
            if ni.player.slotcastable(13)
            and ni.player.slotcd(13) == 0 then
                return ni.player.useinventoryitem(13)
            end
            if ni.player.slotcastable(14)
            and ni.player.slotcd(14) == 0 then
                ni.player.useinventoryitem(14)
            end
        end
    end,
	["Eredar Blink"] = function()
		if IsLeftControlKeyDown()
		and IsFalling()
		and ni.spell.cd(bdkt_skills.Eredar_Blink) == 0 then
			ni.spell.cast(bdkt_skills.Eredar_Blink)
			ni.player.clickat("mouse")
		end
	end,
    ["Taunt_provoke"] = function()
        local _, taunts_enabled = GetSetting("gui_Taunts")
        for TauntEnemy in ipairs(guid_highrangeenemies) do
            local lowthreatunit = guid_highrangeenemies[TauntEnemy].guid
            if taunts_enabled then
                if not ni.unit.debuff(lowthreatunit, bdkt_skills.Dark_Command)
                and UnitAffectingCombat("player")
                and ni.spell.cd(bdkt_skills.Dark_Command) == 0
                and not UnitIsUnit("focus", lowthreatunit)
                and not BlackListedMonster(lowthreatunit)
                and ni.player.threat(lowthreatunit) ~= 3
                and ni.spell.valid(lowthreatunit, bdkt_skills.Dark_Command, false, true, false) then
                    ni.spell.cast(bdkt_skills.Dark_Command, lowthreatunit)
                    lasttaunt = GetTime()
                    return true
                end
                if GetTime() - lasttaunt > 1
                and not ni.unit.debuff(lowthreatunit, bdkt_skills.Dark_Command)
                and UnitAffectingCombat("player")
                and ni.spell.available(bdkt_skills.Icy_Touch)
                and not UnitIsUnit("focus", lowthreatunit)
                and not BlackListedMonster(lowthreatunit)
                and ni.player.threat(lowthreatunit) ~= 3
                and ni.spell.valid(lowthreatunit, bdkt_skills.Icy_Touch, true, true, false) then
                    ni.spell.cast(bdkt_skills.Icy_Touch, lowthreatunit)
                    lasttaunt = GetTime()
                end
            end
        end
    end,
}
ni.bootstrap.profile("A1 Blood Death Knight Tank PvE", bdkt_rotation, bdkt_functions, gui_load, gui_unload)