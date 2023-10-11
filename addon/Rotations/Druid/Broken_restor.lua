local CelPrik = GetSpellInfo(48378);
local ZDP = GetSpellInfo(48470);
local MoonFire = GetSpellInfo("Лунный огонь");
local Molod = GetSpellInfo(48441);
local Vost = GetSpellInfo(48443);
local Gnev = GetSpellInfo("Гнев");
local Torns = GetSpellInfo(53307);
local Apoison = GetSpellInfo(2893);
local Acurse = GetSpellInfo(2782);
local Roy = GetSpellInfo("Рой насекомых");
local Iner = GetSpellInfo(29166);
local Fosage = GetSpellInfo(17116);
local Chill = GetSpellInfo(48447);
local fVost = GetSpellInfo(18562);
local Tree = GetSpellInfo(33981);
local Rost = GetSpellInfo(53251);
local lb = GetSpellInfo(48451);
local Nourish = GetSpellInfo(50464);
local TreeForm = GetSpellInfo(33891);
local dontdispel = {60814, 69674, 68786, 34916, 34917, 34919, 48159, 48160, 30404, 30405, 31117, 34438, 35183, 43522, 47841, 47843, 65812, 68154, 68155, 68156, 44461, 55359, 55360, 55361, 55362, 61429, 30108, 34914, 74562, 74792, 70867, 70338, 70405 };
local items = {
	settingsfile = "Druide.json",
	{ type = "title", text = "Restoration Druid_E" },
	{ type = "separator" },
    { type = "entry", text = "Форма: Полено", enabled = true, key = "trfrm" },
    { type = "entry", text = "Дар дикой природы", enabled = true, key = "bzdp" },
    { type = "entry", text = "Хил танка", value = 95, enabled = true, key = "fcshl" },
	{ type = "entry", text = "Буйный рост", value = 90, enabled = true, key = "rst" },
	{ type = "entry", text = "Спокойствие", value = 60, enabled = true, key = "chl" },
	{ type = "entry", text = "Целительное прикосновение (мгновенное)", value = 35, enabled = true, key = "fstcelprk" },
	{ type = "entry", text = "Целительное прикосновение", value = 45, enabled = true, key = "celprk" },
    { type = "entry", text = "Омоложение", value = 95, enabled = true, key = "mld" },
    { type = "entry", text = "Быстрое восстановение", value = 65, enabled = true, key = "fvst" },
    { type = "entry", text = "Восстановление", value = 75, enabled = true, key = "vst" },
    { type = "entry", text = "Сниятие дебафов", enabled = true, key = "dbff" },
};
local function GetSetting(name)
    for k, v in ipairs(items) do
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
	ni.GUI.AddFrame("Druide", items);
end
local function OnUnLoad()  
	ni.GUI.DestroyFrame("Druide");
end
local queue = {
    "Pause",
    "Form",
    "ZDP",
    "MyTorns",
    "Torns",
    "skin",
    "Apoison",
    "Acurse",
    "chill",
    "rost",
    "fCelPrik",
    "fVost",
    "CelPrik",
    "Focus Heal",
    "Vost",
    "Molod",
    "Nour",
};
local abilities = {
    ["Pause"] = function()
        if IsMounted()
        or UnitInVehicle("player")
        or ni.player.buff(430)
        or ni.player.buff(433)
        or ni.player.isconfused()
        or ni.player.isstunned()
        or ni.player.issilenced()
        or ni.player.iscasting()
        or ni.player.ischanneling()
        or UnitIsDeadOrGhost("player")
        or IsLeftShiftKeyDown() then
            return true
        end
    end,
    ["Form"] = function()
		local _, enabled = GetSetting("trfrm");
        if enabled then
            if not ni.player.buff(TreeForm)
            and ni.spell.available(TreeForm) then
                ni.spell.cast(TreeForm)
            end
        end
    end,
    ["Focus Heal"] = function()
		local value, enabled = GetSetting("fcshl");
        if enabled and ni.unit.exists("focus")
        and UnitAffectingCombat("focus") then
        local lbtank, _, _, lbtank_count, _, _, lbtank_time = ni.unit.buff("focus", lb, "player")
        local rgtank, _, _, _, _, _, rgtank_time = ni.unit.buff("focus", Vost, "player")
        local rjtank, _, _, _, _, _, rjtank_time = ni.unit.buff("focus", Molod, "player")
        if ni.spell.available(Molod)
        and not rjtank
        and ni.unit.hp("focus") < (value - 10)
        and ni.spell.valid("focus", Molod, false, true, true)
        then ni.spell.cast(Molod, "focus")
        end
        if ni.spell.available(lb)
        and not lbtank
        and ni.unit.hp("focus") < (value - 10)
        and ni.spell.valid("focus", lb, false, true, true)
        then ni.spell.cast(lb, "focus")
        end
        if ni.spell.available(Vost)
        and not rgtank
        and ni.unit.hp("focus") < (value - 27)
        and not ni.player.ismoving()
        and ni.spell.valid("focus", Vost, false, true, true)
        then ni.spell.cast(Vost, "focus")
        end
        if ni.spell.available(lb)
        and lbtank_count == 1
        and ni.unit.hp("focus") < (value - 22)
        and ni.spell.valid("focus", lb, false, true, true)
        then ni.spell.cast(lb, "focus")
        end
        if ni.spell.available(lb)
        and lbtank and lbtank_count == 2
        and ni.unit.hp("focus") < (value - 33)
        and ni.spell.valid("focus", lb, false, true, true)
        then ni.spell.cast(lb, "focus")
        end
        end
    end,
    ["iner"] = function ()
        if UnitAffectingCombat("player")
        and ni.player.power() <= 10
        and ni.spell.available(Iner) then
            ni.spell.cast(Iner)
        end
    end,
    ["skin"] = function ()
        if UnitAffectingCombat("player")
        and ni.unit.hp("player") <= 70
        and ni.spell.available (22812)
        then ni.spell.cast (22812)
        end
    end,
    ["Gnev"] = function()
        if not ni.player.buff(Tree)
        and ni.spell.available(Gnev)
        and ni.spell.valid("target", Gnev, true, true)
        and not ni.player.ismoving() then
            ni.spell.cast(Gnev)
        end
    end,
    ["MoonFire"] = function()
        if not ni.player.buff(Tree)
        and ni.spell.available(MoonFire)
        and (not ni.unit.debuff("target", MoonFire, "player") or ni.unit.debuffremaining("target", MoonFire, "player") < 3)
        and ni.spell.valid("target", MoonFire, true, true) then
            ni.spell.cast(MoonFire)
        end
    end,
    ["Roy"] = function()
        if not ni.player.buff(Tree)
        and ni.spell.available(Roy)
        and (not ni.unit.debuff("target", Roy, "player") or ni.unit.debuffremaining("target", Roy, "player") < 3)
        and ni.spell.valid("target", Roy, true, true) then
            ni.spell.cast(Roy)
        end
    end,
    ["rost"] = function()
		local value, enabled = GetSetting("rst");
        if enabled then 
            if UnitAffectingCombat("player")
            and ni.members.below(value) >= 4
            and ni.spell.available(Rost) then
                ni.spell.cast(Rost)
            end
        end
    end,
    ["chill"] = function()
		local value, enabled = GetSetting("chl");
        if enabled then
            if UnitAffectingCombat("player")
            and ni.members.below(value) >= 4
            and ni.spell.available(Chill)
            and not ni.player.ismoving() then
                ni.spell.cast(Chill)
            end
        end
    end,
    ["fCelPrik"] = function ()
		local value, enabled = GetSetting("fstcelprk");
        for i = 1, #ni.members do
            if enabled then
                if not ni.members[i].debuff(ni.members[i].unit, 30843) then
                    if UnitAffectingCombat("player")
                    and not UnitIsDeadOrGhost(ni.members[i].unit)
                    and (ni.members[i].hp <= value or ni.unit.debuff(ni.members[i].unit, 67050) or (ni.members[i].debuff(ni.members[i].unit, 66118) and ni.members[i].debuff(ni.members[i].unit, 66013)) or (ni.members[i].debuff(ni.members[i].unit, 66118) and ni.members[i].debuff(ni.members[i].unit, 68510)))
                    and ni.spell.available(Fosage)
                    and ni.spell.available(CelPrik)
                    and ni.spell.valid(ni.members[i].unit, CelPrik, false, true, true) then
                        ni.spell.cast(Fosage) ni.spell.cast(CelPrik, ni.members[i].unit)
                    end
                end
            end
        end
    end,
    ["CelPrik"] = function()
		local value, enabled = GetSetting("celprk");
        for i = 1, #ni.members do
            if enabled then
                if not ni.members[i].debuff(ni.members[i].unit, 30843) then
                    if (ni.members[i].hp <= value or ni.unit.debuff(ni.members[i].unit, 67050) or ni.unit.debuff(ni.members[i].unit, 38801) or (ni.members[i].debuff(ni.members[i].unit, 66118) and ni.members[i].debuff(ni.members[i].unit, 66013)) or (ni.members[i].debuff(ni.members[i].unit, 66118) and ni.members[i].debuff(ni.members[i].unit, 68510)))
                    and ni.spell.available(CelPrik)
                    and ni.spell.valid(ni.members[i].unit, CelPrik, false, true, true)
                    and not ni.player.ismoving() then
                        ni.spell.cast(CelPrik, ni.members[i].unit)
                    end
                end
            end
        end
    end,
    ["Molod"] = function()
		local value, enabled = GetSetting("mld");
        for i = 1, #ni.members do
            if enabled then
                if not ni.members[i].debuff(ni.members[i].unit, 30843) then
                    if ni.members[i].hp < value
                    and ni.spell.available(Molod)
                    and not ni.unit.buff(ni.members[i].unit, Molod, "player")
                    and ni.spell.valid(ni.members[i].unit, Molod, false, true, true) then
                        ni.spell.cast(Molod, ni.members[i].unit)
                    end
                end
            end
        end
    end,
    ["fVost"] = function ()
		local value, enabled = GetSetting("fvst");
        for i = 1, #ni.members do
            if enabled then
                if not ni.members[i].debuff(ni.members[i].unit, 30843) then
                    if UnitAffectingCombat ("player")
                    and ni.unit.buff(ni.members[i].unit, Vost, "player")
                    and ni.unit.buff(ni.members[i].unit, Molod, "player")
                    and (ni.members[i].hp <= value or ni.unit.debuff(ni.members[i].unit, 67050) or (ni.members[i].debuff(ni.members[i].unit, 66118) and ni.members[i].debuff(ni.members[i].unit, 66013)) or (ni.members[i].debuff(ni.members[i].unit, 66118) and ni.members[i].debuff(ni.members[i].unit, 68510)))
                    and ni.spell.available(fVost)
                    and ni.spell.valid(ni.members[i].unit, fVost, false, true, true) then
                        ni.spell.cast(fVost, ni.members[i].unit)
                    end
                end
            end
        end
    end,
    ["Vost"] = function()
		local value, enabled = GetSetting("vst");
        for i = 1, #ni.members do
            if enabled then
                if not ni.members[i].debuff(ni.members[i].unit, 30843) then
                    if (ni.members[i].hp <= value or ni.unit.debuff(ni.members[i].unit, 67050) or (ni.members[i].debuff(ni.members[i].unit, 66118) and ni.members[i].debuff(ni.members[i].unit, 66013)) or (ni.members[i].debuff(ni.members[i].unit, 66118) and ni.members[i].debuff(ni.members[i].unit, 68510)))
                    and ni.spell.available(Vost)
                    and not ni.unit.buff(ni.members[i].unit, Vost, "player")
                    and ni.spell.valid(ni.members[i].unit, Vost, false, true, true)
                    and not ni.player.ismoving() then
                        ni.spell.cast(Vost, ni.members[i].unit)
                    end
                end
            end
        end
    end,
    ["Nour"] = function()
		local value, enabled = GetSetting("fvst");
        for i = 1, #ni.members do
            if enabled then
                if not ni.members[i].debuff(ni.members[i].unit, 30843) then
                    if (ni.members[i].hp <= value or ni.unit.debuff(ni.members[i].unit, 67050) or (ni.members[i].debuff(ni.members[i].unit, 66118) and ni.members[i].debuff(ni.members[i].unit, 66013)) or (ni.members[i].debuff(ni.members[i].unit, 66118) and ni.members[i].debuff(ni.members[i].unit, 68510)))
                    and ni.spell.available(Nourish)
                    and ni.unit.buff(ni.members[i].unit, Vost, "player")
                    and ni.unit.buff(ni.members[i].unit, Molod, "player")
                    and ni.spell.valid(ni.members[i].unit, Nourish, false, true, true)
                    and not ni.player.ismoving() then
                        ni.spell.cast(Nourish, ni.members[i].unit)
                    end
                end
            end
        end
    end,
    ["ZDP"] = function()
		local _, enabled = GetSetting("bzdp");
        if enabled then
            if not ni.player.buff(ZDP)
            and ni.spell.available(ZDP) then
                ni.spell.cast(ZDP)
            end
        end
    end,
    ["Apoison"] = function()
		local _, enabled = GetSetting("dbff");
        for _, x in ipairs(dontdispel) do
            for i = 1, #ni.members do
                if enabled then 
                    if ni.unit.debufftype(ni.members[i].unit, "Poison")
                    and not ni.unit.debuff(ni.members[i].unit, x)
                    and not ni.unit.buff(ni.members[i].unit, Apoison, "player")
                    and ni.spell.available(Apoison)
                    and ni.spell.valid(ni.members[i].unit, Apoison, false, true, true) then
                        ni.spell.cast(Apoison, ni.members[i].unit)
                    end
                end
            end
        end
    end,
    ["Acurse"] = function()
		local _, enabled = GetSetting("dbff");
        for _, x in ipairs(dontdispel) do
            for i = 1, #ni.members do
                if enabled then
                    if ni.unit.debufftype(ni.members[i].unit, "Curse")
                    and not ni.unit.debuff(ni.members[i].unit, x)
                    and ni.spell.available(Acurse)
                    and ni.spell.valid(ni.members[i].unit, Acurse, false, true, true) then
                        ni.spell.cast(Acurse, ni.members[i].unit)
                    end
                end
            end
        end
    end,
    ["Torns"] = function()
        if ni.unit.exists("focus")
        and not ni.unit.buff("focus", Torns)
        and ni.spell.available(Torns)
        and ni.spell.valid("focus", Torns, false, true, true) then
            ni.spell.cast(Torns, "focus")
        end
    end,
    ["MyTorns"] = function()
        if not ni.player.buff(Torns)
        and ni.spell.available(Torns) then
            ni.spell.cast(Torns, "player")
        end
    end,
}
ni.bootstrap.profile("Broken_restor", queue, abilities, OnLoad, OnUnLoad);