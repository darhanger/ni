
local skills = {
}
local items = {
  settingsfile = "PandaPal.json",
	{ type = "title", text = "Panda Pal" },
  { type = "separator" },
  { type = "entry", text = "Автоатака", enabled = true, key = "set_autoattack" },
  { type = "separator" },
  { type = "entry", text = "Лог", enabled = false, key = "set_debug" },
};
local agressiveenemies = {};
local dontdispel = {30128, 28169, 38806, 70964, 31803, 60814, 69674, 68786, 34916, 34917, 34919, 48159, 48160, 30404, 30405, 31117, 34438, 35183, 43522, 47841, 47843, 65812, 68154, 68155, 68156, 44461, 55359, 55360, 55361, 55362, 61429, 30108, 34914, 74562, 74792, 70867, 70338, 70405 }
local freedomdebuff = { 45524, 1715, 3408, 59638, 20164, 25809, 31589, 51585, 50040, 50041, 31124, 122, 44614, 339, 45334, 58179, 61391, 19306, 19185, 35101, 5116, 2974, 61394, 54644, 50245, 50271, 54706, 4167, 33395, 55080, 6136, 120, 116, 31589, 20170, 31125, 3409, 26679, 64695, 63685, 8056, 8034, 18118, 18223, 63311, 23694, 1715, 12323, 39965, 55536, 13099, 32859, 32065, 22800, 3604, 33967, 12023, 47698, 38316, 15063, 49717 }
for k, v in pairs(dontdispel) do
    ni.healing.debufftoblacklist(v)
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
  ni.GUI.AddFrame("pandapal", items);
end
local function onunload()
  ni.GUI.DestroyFrame("pandapal");
end
local todolist = {
    "Pause",
    "Holy Light",
    "Combat Pause",
    "Stop Attack",
    "Target Enemy",
    "Attack",
    "Seal",
}
local mainfunc = {
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
            return true;
        end
        ni.vars.debug = select(2, GetSetting("set_debug"));
    end,
    ["Combat Pause"] = function ()
        if IsLeftShiftKeyDown() then
			return true;
        end
    end,
    ["Attack"] = function()
		local _, autoattack_enabled = GetSetting("set_autoattack");
		if autoattack_enabled then
			if ni.unit.exists("target")
            and UnitCanAttack("player", "target")
            and ni.player.inmelee("target")
            and not IsCurrentSpell(6603) then
                ni.player.runtext("/startattack");
            end
        end
    end,
    ["Target Enemy"] = function()
		local _, autoattack_enabled = GetSetting("set_autoattack");
		if autoattack_enabled then
            if UnitAffectingCombat("player")
            and ni.vars.combat.aoe
            and (not ni.unit.exists("target") or (ni.unit.exists("target") and not UnitCanAttack("player", "target"))) then
                ni.player.runtext("/targetenemy");
            end
        end
    end,
    ["Stop Attack"] = function()
        if ni.unit.exists("target")
        and UnitCanAttack("player", "target")
        and not (ni.player.inmelee("target") or ni.player.isfacing("target"))
        and IsCurrentSpell(6603) then
            ni.player.runtext("/stopattack");
        end
    end,
    ["Seal"] = function()
        if not ni.player.buff("Печать праведности") then
            if ni.spell.available("Печать праведности") then
                ni.spell.cast("Печать праведности");
                return true;
            end
        end
    end,
    ["Holy Light"] = function()
        if ni.player.hp() < 40 then
            if ni.spell.available("Свет небес") then
                ni.spell.cast("Свет небес", "player");
                return true;
            end
        end
    end,
}
ni.bootstrap.profile("PandaPal", todolist, mainfunc, onload, onunload);