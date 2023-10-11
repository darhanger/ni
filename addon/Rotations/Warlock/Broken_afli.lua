local spell = {
    DemonicShield = GetSpellInfo(47889),
    FilthShield = GetSpellInfo(47893),
    DemonSkin = GetSpellInfo(696),
    Agonie = GetSpellInfo(47864),
    BadWord = GetSpellInfo(11719),
    Rock = GetSpellInfo(47867),
    Weak = GetSpellInfo(50511),
    Elements = GetSpellInfo(47865),
    WalkingSpirit = GetSpellInfo(59164),
    Unstable = GetSpellInfo(47843),
    Cursing = GetSpellInfo(47813),
    Seed = GetSpellInfo(47836),
    StealLife = GetSpellInfo(47857),
    StealSoul = GetSpellInfo(47855),
    ShadowBolt = GetSpellInfo(47809),
    Manareg = GetSpellInfo(57946),
    Hellflame = GetSpellInfo(61290),
    Scream = GetSpellInfo(17928),
    FearHeal = GetSpellInfo(47860),
    Ban = GetSpellInfo(18647),
};
local items = {
	settingsfile = "Aflik.json",
	{ type = "title", text = "Warlock Afli Broken" },
	{ type = "separator" },
    { type = "dropdown", menu = {
        { selected = true, value = spell.FilthShield, text = "Доспех Скверны" },
        { selected = false, value = spell.DemonicShield, text = "Демонический доспех" },
        { selected = false, value = spell.DemonSkin, text = "Шкура Демона" },
    }, key = "shld" },
    { type = "dropdown", menu = {
        { selected = true, value = spell.Elements, text = "Проклятие стихий" },
        { selected = false, value = spell.Agonie, text = "Проклятие агонии" },
        { selected = false, value = spell.BadWord, text = "Проклятие косноязычия" },
        { selected = false, value = spell.Weak, text = "Проклятие слабости" },
        { selected = false, value = spell.Rock, text = "Проклятие рока" },
    }, key = "crs" },
	{ type = "entry", text = "Семя порчи", tooltip = "", enabled = true, key = "seed" },
	{ type = "separator" },
	{ type = "entry", text = "Debug Printing", tooltip = "Enable for debug if you have problems.", enabled = false, key = "Debug" },	
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
	ni.GUI.AddFrame("Aflik", items);
end
local function OnUnLoad()  
	ni.GUI.DestroyFrame("Aflik");
end
local BadBuff = {38759, 22857, 69051, 48294, 42354};
local enemies = { };
local LastReset, LastCharge, LastControl, LastTaunt = 0, 0, 0, 0;
local cache = {
	InCombat = false,
};
local order = {
    "Cache",
    "Pause",
    "Combat Pause",
    "FocusBan",
    "Buff",
    "SpellStone",
    "Potions",
    "Healthstone",
    "Burst",
    "Scream",
    "FearHeal",
    "Manareg",
    "Shield",
    "Curse",
    "Seed",
    "Cursing",
    "StealLife",
    "StealSoul",
    "UnstableMagic",
    "WalkingSpirit",
    "Hellflame",
    "ShadowBolt",
};
local moves = {
    ["Cache"] = function()
		if (GetTime() - LastReset >= 15) then
			table.wipe(enemies);
			LastReset = GetTime()
		end
		cache.InCombat = UnitAffectingCombat("player") or false;
    end,
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
        or UnitIsDeadOrGhost("target") then
            return true
        end
        ni.vars.debug = select(2, GetSetting("Debug"));
    end,
    ["Combat Pause"] = function()
        for _, v in ipairs(BadBuff) do
            if ni.unit.buff("target", v)
            or ni.unit.debuff("target", v) then
                return true
            end
        end
    end,
	["Healthstone"] = function()
		local hstones = { 36892, 36893, 36894 }
		for i = 1, #hstones do
			if cache.InCombat
			and ni.player.hp() < 50
			and ni.player.hasitem(hstones[i])
			and ni.player.itemcd(hstones[i]) == 0 then
				ni.player.useitem(hstones[i])
			end
		end
	end,
	["Potions"] = function()
		if cache.InCombat
		and ni.player.hp() < 50
		and ni.player.hasitem(33447)
		and ni.player.itemcd(33447) == 0 then
			ni.player.useitem(33447)
		end
	end,
    ["Shield"] = function()
		local CurrentShield = GetSetting("shld");
        if not ni.player.buff(CurrentShield)
        and ni.spell.available(CurrentShield) then
            ni.spell.cast(CurrentShield)
        end
    end,
    ["Curse"] = function()
		local CurrentCurse = GetSetting("crs");
        if not ni.unit.debuff("target", CurrentCurse, "player")
        and ni.spell.available(CurrentCurse)
        and ni.spell.valid("target", CurrentCurse, true, true) then
            ni.spell.cast(CurrentCurse)
        end
    end,
    ["WalkingSpirit"] = function ()
        if not ni.unit.debuff("target", spell.WalkingSpirit, "player")
        and ni.spell.available(spell.WalkingSpirit)
        and ni.spell.valid("target", spell.WalkingSpirit, true, true)
        and not ni.player.ismoving() then
            ni.spell.cast(spell.WalkingSpirit)
        end
    end,
    ["UnstableMagic"] = function ()
        if (not ni.unit.debuff("target", spell.Unstable, "player") or ni.unit.debuff("target", spell.Unstable, "player") and ni.unit.debuffremaining("target", spell.Unstable, "player") <= 2)
        and ni.spell.available(spell.Unstable)
        and ni.spell.valid("target", spell.Unstable, true, true)
        and not ni.player.ismoving() then
            ni.spell.cast(spell.Unstable)
        end
    end,
    ["Cursing"] = function()
        if #ni.unit.enemiesinrange("target", 4) == 0
        and not ni.unit.debuff("target", spell.Cursing, "player")
        and ni.spell.available(spell.Cursing)
        and ni.spell.valid("target", spell.Cursing, true, true) then
            ni.spell.cast(spell.Cursing)
        end
    end,
    ["Seed"] = function()
		local _, enabled = GetSetting("seed");
        if enabled then 
            if #ni.unit.enemiesinrange("target", 4) >= 2
            and not ni.unit.debuff("target", spell.Seed, "player")
            and ni.spell.available(spell.Seed)
            and ni.spell.valid("target", spell.Seed, true, true)
            and not ni.player.ismoving() then
                ni.spell.cast(spell.Seed)
            end
        end
    end,
    ["StealSoul"] = function()
        if ni.unit.debuff("target", spell.Unstable, "player")
        and ni.unit.debuff("target", spell.Cursing, "player")
        and ni.spell.available(spell.StealSoul)
        and ni.spell.valid("target", spell.StealSoul, true, true)
        and ni.unit.hp("target") <= 25
        and not ni.player.ismoving() then
            ni.spell.cast(spell.StealSoul)
        end
    end,
    ["StealLife"] = function()
        if ni.unit.debuff("target", spell.Unstable, "player")
        and ni.unit.debuff("target", spell.Cursing, "player")
        and ni.spell.available(spell.StealLife)
        and ni.spell.valid("target", spell.StealLife, true, true)
        and ni.player.hp() <= 55
        and not ni.player.ismoving() then
            ni.spell.cast(spell.StealLife)
        end
    end,
    ["ShadowBolt"] = function()
        if (ni.unit.debuff("target", spell.Unstable, "player") or ni.player.buff(17941))
        and ni.spell.valid("target", spell.ShadowBolt, true, true)
        and ni.spell.available(spell.ShadowBolt)
        and not ni.player.ismoving() then
            ni.spell.cast(spell.ShadowBolt)
        end
    end,
    ["FocusBan"] = function()
        if ni.unit.exists("focus") then
            if not ni.unit.debuff("focus", spell.Ban, "player")
            and ni.spell.valid("focus", spell.Ban, true, true)
            and ni.spell.available(spell.Ban)
            and not ni.player.ismoving() then
                ni.spell.cast(spell.Ban, "focus")
            end
        end
    end,
    ["Manareg"] = function()
        if ni.player.power() <= 90
        and ni.player.hp() > 50
        and ni.spell.available(spell.Manareg)
        and ni.player.ismoving() then
            ni.spell.cast(spell.Manareg)
        end
    end,
    ["Hellflame"] = function()
        if ni.player.inmelee("target")
        and ni.player.isfacing("target")
        and ni.spell.valid("target", 47809, true, true)
        and ni.spell.available(spell.Hellflame) then
            ni.spell.cast(spell.Hellflame)
        end
    end,
    ["Scream"] = function()
        local enemies = ni.player.enemiesinrange(6);
        for i = 1, #enemies do
            local ENEMY = enemies[i].guid;
            if ni.player.threat(ENEMY) == 3
            and not ni.unit.istotem(ENEMY)
            and ni.spell.available(spell.Scream) then
                ni.spell.cast(spell.Scream)
            end
        end
    end,
    ["FearHeal"] = function ()
        local enemies = ni.player.enemiesinrange(30);
        for i = 1, #enemies do
            local ENEMY = enemies[i].guid;
            if ni.player.threat(ENEMY) == 3
            and ni.spell.available(spell.FearHeal)
            and ni.spell.valid(ENEMY, spell.FearHeal, true, true) then
                ni.spell.cast(spell.FearHeal)
            end
        end
    end,
    ["SpellStone"] = function()
		if not GetWeaponEnchantInfo()
		 and not ni.player.ismoving()
		 and not UnitAffectingCombat("player") then
		 if not ni.player.hasitem(41196)
		 and IsUsableSpell(GetSpellInfo(47888))
		 and ni.spell.available(47888) then
			ni.spell.cast(47888);
		 else
			ni.player.useitem(41196);
			ni.player.useinventoryitem(16);
			end
		end
	end,
    ["Burst"] = function()
        if UnitAffectingCombat("player")
        and ni.player.buff(60064)
        and ni.spell.available(33702) then
            ni.spell.cast(33702)
        end
    end,
    ["Buff"] = function()
        if (not ni.player.buff(63321) or ni.player.buffremaining(63321) <= 5)
        and ni.spell.available(57946)
        and ni.player.hp() >= 30 then
            ni.spell.cast(57946)
        end
    end,
};
ni.bootstrap.profile("Broken_afli", order, moves, OnLoad, OnUnLoad);