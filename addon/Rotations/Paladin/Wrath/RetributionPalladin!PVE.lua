
local skills = {
    BlueJudgment = GetSpellInfo(53408),
    YellowJudgment = GetSpellInfo(20271),
    Seal_Solo = GetSpellInfo(53736),
    Seal_AOE = GetSpellInfo(20375),
    DivineStorm = GetSpellInfo(53385),
    LightStrike = GetSpellInfo(35395),
    Cleansing = GetSpellInfo(4987),
    Oath = GetSpellInfo(54428),
    HandOfSalvation = GetSpellInfo(1038),
    HammerOfJustice = GetSpellInfo(10308),
    Consecration = GetSpellInfo(48819),
    GodsShield = GetSpellInfo(642),
    Weakness = GetSpellInfo(25771),
    WCraft = GetSpellInfo(59578),
    Exorcism = GetSpellInfo(48801),
    FlashLight = GetSpellInfo(48785),
    Berserk = GetSpellInfo(59620),
    DivineWrath = GetSpellInfo(31884),
    HeavensWrath = GetSpellInfo(48817),
    HammerofWrath = GetSpellInfo(48806),
	Freedom = GetSpellInfo(1044),
	HandOfProtection = GetSpellInfo(10278),
}
local items = {
  settingsfile = "RetributionPalladinPveV01.json",
	{ type = "title", text = "Retribution Paladin" },
  { type = "separator" },
  { type = "dropdown", menu = {
		{ selected = false, value = skills.YellowJudgment, text = "Правосудие света" },
		{ selected = true, value = skills.BlueJudgment, text = "Правосудие мудрости" },
		{ selected = false, value = 0, text = "Вручную" },
  }, key = "set_judgment" },
  { type = "entry", text = "Автоатака", enabled = true, key = "set_autoattack" },
  { type = "entry", text = "Освящение", enabled = true, key = "set_consecration" },
  { type = "entry", text = "Очищение", enabled = false, key = "set_cleanse" },
  { type = "entry", text = "Хил", enabled = false, key = "set_flashlight" },
  { type = "entry", text = "Тринкеты", enabled = false, key = "set_trinkets" },
  { type = "entry", text = "Рассовая", enabled = true, key = "set_racial" },
  { type = "separator" },
  { type = "entry", text = "Лог", enabled = false, key = "set_debug" },
};
local agressiveenemies = {};
local dontdispel = {30128, 28169, 38806, 70964, 31803, 60814, 69674, 68786, 34916, 34917, 34919, 48159, 48160, 30404, 30405, 31117, 34438, 35183, 43522, 47841, 47843, 65812, 68154, 68155, 68156, 44461, 55359, 55360, 55361, 55362, 61429, 30108, 34914, 74562, 74792, 70867, 70338, 70405 }
local freedomdebuff = { 45524, 1715, 3408, 59638, 20164, 25809, 31589, 51585, 50040, 50041, 31124, 122, 44614, 339, 45334, 58179, 61391, 19306, 19185, 35101, 5116, 2974, 61394, 54644, 50245, 50271, 54706, 4167, 33395, 55080, 6136, 120, 116, 31589, 20170, 31125, 3409, 26679, 64695, 63685, 8056, 8034, 18118, 18223, 63311, 23694, 1715, 12323, 39965, 55536, 13099, 32859, 32065, 22800, 3604, 33967, 12023, 47698, 38316, 15063, 49717 }
for k, v in pairs(dontdispel) do
    ni.healing.debufftoblacklist(v)
end
local function ActiveAgressiveEnemies()
	table.wipe(agressiveenemies);
	agressiveenemies = ni.player.enemiesinrange(4);
	for k, v in ipairs(agressiveenemies) do
		if
		ni.player.threat(v.guid) == -1
		then
			table.remove(agressiveenemies, k);
		end
	end
	return #agressiveenemies;
end
local function GetSetting(name)
  for _, v in ipairs(items) do
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
end;
local function onload()
  ni.GUI.AddFrame("RPPveV01", items);
end
local function onunload()
  ni.GUI.DestroyFrame("RPPveV01");
end
local lastaction = 0
local todolist = {
    "Cache",
    "Pause",
    "Healthstone",
    "GodsShield",
    "EarthPower",
    "Seals",
    "RacialStuff",
    "Judgement",
    "Trinkets",
    "PunishersWrath",
    "Oath",
    "Combat Pause",
    "Attacking",
    "HammerOfWrath",
    "StunningStrike",
    "HeavensWrath",
    "DivineStorm",
    "Consecration",
    "LightStrike",
    "ExorcismOrHeal",
    "Freedom",
    "Cleansing",
}
local mainfunc = {
    ["Pause"] = function()
        if
        IsMounted()
        or UnitInVehicle("player")
        or ni.player.buff(GetSpellInfo(430))
        or ni.player.buff(GetSpellInfo(433))
        or ni.player.isconfused()
        or ni.player.isstunned()
        or ni.player.iscasting()
        or ni.player.ischanneling()
        or UnitIsDeadOrGhost("player")
        or IsLeftShiftKeyDown()
        then
            return true;
        end
        ni.vars.debug = select(2, GetSetting("set_debug"));
    end,
    ["Combat Pause"] = function ()
        if IsLeftShiftKeyDown()
        or GetTime() - lastaction < 0.55
		or ni.player.debuffstacks(70106) >= 4 then
			return true
        end
    end,
	["Cache"] = function()
		ActiveAgressiveEnemies();
	end,
    ["Attacking"] = function()
		local _, autoattack_enabled = GetSetting("set_autoattack");
		if
		autoattack_enabled
		then
			if
            ni.unit.exists("target")
            and UnitCanAttack("player", "target")
            and ni.player.inmelee("target")
            and not IsCurrentSpell(6603)
            then
                ni.player.runtext("/startattack");
            elseif
            UnitAffectingCombat("player")
            and ActiveAgressiveEnemies() >= 1
            and (not ni.unit.exists("target") or (ni.unit.exists("target") and not UnitCanAttack("player", "target")))
            then
                ni.player.runtext("/targetenemy");
            elseif
            ni.unit.exists("target")
            and UnitCanAttack("player", "target")
            and not (ni.player.inmelee("target") or ni.player.isfacing("target"))
            and IsCurrentSpell(6603)
            then
                ni.player.runtext("/stopattack");
            end
        end
    end,
    ["Seals"] = function()
        if
        not ni.unit.isboss("target")
        and not ni.player.buff(skills.Seal_AOE)
        and ni.spell.available(skills.Seal_AOE)
        and ni.spell.valid("target", skills.BlueJudgment, false, true)
        then
            ni.spell.cast(skills.Seal_AOE)
            lastaction = GetTime()
        end
        if
        ni.unit.isboss("target")
        and not ni.player.buff(skills.Seal_Solo)
        and ni.spell.available(skills.Seal_Solo)
        and ni.spell.valid("target", skills.BlueJudgment, false, true) then
            ni.spell.cast(skills.Seal_Solo)
            lastaction = GetTime()
        end
    end,
    ["Judgement"] = function()
        local value = GetSetting("set_judgment");
        if value == 0
        then
            return false
        elseif
        ni.spell.available(value)
        and ni.spell.valid("target", value, true, true)
        then
            ni.spell.cast(value)
            lastaction = GetTime()
        end
    end,
    ["DivineStorm"] = function()
        if
        UnitAffectingCombat("player")
        and ni.spell.available(skills.DivineStorm)
        and ni.spell.valid("target", skills.LightStrike, true, true)
        then
            ni.spell.cast(skills.DivineStorm)
            lastaction = GetTime()
        end
    end,
    ["LightStrike"] = function()
        if
        UnitAffectingCombat("player")
        and ni.spell.available(skills.LightStrike)
        and ni.spell.valid("target", skills.LightStrike, true, true)
        then
            ni.spell.cast(skills.LightStrike)
            lastaction = GetTime()
        end
    end,
    ["ExorcismOrHeal"] = function()
        local _, enabled = GetSetting("set_flashlight");
        if
        UnitAffectingCombat("player")
        and ni.player.buff(skills.WCraft)
        then
            if
            (ni.player.hp() >= 40 or not enabled)
            and ni.spell.available(skills.Exorcism)
            and ni.spell.valid("target", skills.Exorcism, true, true)
            then
                ni.spell.cast(skills.Exorcism)
                lastaction = GetTime()
            elseif
            enabled
            and ni.player.hp() < 40
            and ni.spell.available(skills.FlashLight)
            then
                ni.spell.cast(skills.FlashLight, "player")
                lastaction = GetTime()
            end
        end
    end,
    ["PunishersWrath"] = function()
        if
        ni.player.buff(skills.Berserk)
        and ni.unit.isboss("target")
        and not ni.player.debuff(skills.Weakness)
        and ni.spell.cd(skills.DivineWrath) == 0
        then
            ni.spell.cast(skills.DivineWrath)
            lastaction = GetTime()
        end
    end,
    ["HeavensWrath"] = function()
        for	i = 1, #agressiveenemies
        do
            local nearestenemy = agressiveenemies[i].guid;
            if
            UnitAffectingCombat("player")
            and ni.spell.available(skills.HeavensWrath)
            and (ni.unit.creaturetype(nearestenemy) == 6 or ni.unit.creaturetype(nearestenemy) == 3)
            then
                ni.spell.cast(skills.HeavensWrath)
                lastaction = GetTime()
            end
        end
    end,
    ["HammerOfWrath"] = function()
        if
        UnitAffectingCombat("player")
        and ni.spell.available(skills.HammerofWrath)
        and ni.unit.hp("target") <= 20
        and ni.spell.valid("target", skills.HammerofWrath, true, true)
        then
            ni.spell.cast(skills.HammerofWrath)
            lastaction = GetTime()
        end
    end,
    ["Consecration"] = function()
      local _, enabled = GetSetting("set_consecration");
      if
      enabled
      then
            if UnitAffectingCombat("player")
            and ni.spell.available(skills.Consecration)
            and ni.spell.valid("target", skills.LightStrike, true, true)
            then
                ni.spell.cast(skills.Consecration)
                lastaction = GetTime()
            end
        end
    end,
    ["Cleansing"] = function()
		local _, enabled = GetSetting("set_cleanse")
		if
        enabled
        then
			if ni.healing.candispel("player")
            and ni.player.debufftype("Poison|Disease|Magic")
			and ni.spell.available(skills.Cleansing)
            then
				ni.spell.cast(skills.Cleansing, "player")
                lastaction = GetTime()
			end
		end
    end,
    ["Oath"] = function()
        if
        not ni.player.buff(skills.Oath)
        and ni.player.power() <= 30
        and ni.spell.available(skills.Oath)
        then
            ni.spell.cast(skills.Oath)
            lastaction = GetTime()
        end
    end,
    ["StunningStrike"] = function ()
        if
        ni.unit.iscasting("target")
        or ni.unit.ischanneling("target")
        then
            if
            ni.spell.available(skills.HammerOfJustice)
            and ni.spell.valid("target", skills.HammerOfJustice, true)
            and not ni.unit.isboss("target")
            then
                ni.spell.cast(skills.HammerOfJustice)
                lastaction = GetTime()
            end
        end
    end,
	["GodsShield"] = function()
		if
        ni.player.debuff(30843)
        then
            return false
        elseif
		UnitAffectingCombat("player")
		and not ni.player.debuff(skills.Weakness)
		and ni.player.hp() <= 15
		and ni.spell.available(skills.GodsShield)
        then
			ni.spell.cast(skills.GodsShield)
            lastaction = GetTime()
		end
	end,
    ["Trinkets"] = function()
        local _, enabled = GetSetting("set_trinkets");
        if
        enabled
        and ni.player.buff(skills.Berserk)
        then
            if ni.player.slotcastable(14)
            and ni.player.slotcd(14) == 0
            then
                ni.player.useinventoryitem(14)
            elseif ni.player.slotcastable(13)
            and ni.player.slotcd(13) == 0
            then
                ni.player.useinventoryitem(13)
            end
        end
    end,
    ["Healthstone"] = function()
        local hstones = { 36892, 36893, 36894 }
        for
        i = 1, #hstones
        do
            if
            UnitAffectingCombat("player")
            and ni.player.hp() < 33
            and ni.player.hasitem(hstones[i])
            and ni.player.itemcd(hstones[i]) == 0
            then
                ni.player.useitem(hstones[i])
            end
        end
    end,
    ["EarthPower"] = function()
        if
        ni.player.hp() < 70
        and ni.spell.available(55503)
        then
            ni.spell.cast(55503)
        end
    end,
    ["RacialStuff"] = function()
        local _, enabled = GetSetting("set_racial")
        if
        enabled
        then
            if UnitAffectingCombat("player")
            and ni.spell.cd(316256) == 0 then
                ni.spell.cast(316256, "player")
            end
        end
    end,
    ["Freedom"] = function()
		for
        _, x in ipairs(freedomdebuff)
        do
			for
            i = 1, #ni.members
            do
				if
                ni.spell.available(skills.Freedom)
				and ni.unit.debuff(ni.members[i].unit, x)
				and ni.spell.valid(ni.members[i].unit, skills.Freedom, false, true, true)
                and not ni.unit.buff(ni.members[i].unit, skills.Freedom)
                then
					ni.spell.cast(skills.Freedom, ni.members[i].unit)
                    lastaction = GetTime()
				end
          	end
        end
    end,
    ["OtherStuff"] = function()
        if
        GetCurrentMapAreaID() == nil
        and ni.player.buff(skills.HandOfProtection)
        and ni.player.buffremaining(skills.HandOfProtection) <= 3
        then
            ni.frames.floatingtext:message("Быстро на лужу!")
        end
    end,
}
ni.bootstrap.profile("RetributionPalladin!PVE", todolist, mainfunc, onload, onunload);