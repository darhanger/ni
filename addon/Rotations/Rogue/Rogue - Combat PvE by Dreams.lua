local items = {
	settingsfile = "Rogue - Combat PvE by Dreams.json",
	{ type = "title", text = "Rogue - Combat PvE by |c0000CED1Dreams" },
	{ type = "separator" },
	{ type = "title", text = "|cffFFFF00Settings" },
	{ type = "entry", text = "\124T"..select(3, GetSpellInfo(57934))..":26:26\124t Use Tricks of the Trade on Focus Target", tooltip = "Use Tricks of the Trade on Focus Target, Focus your Main Tank", enabled = true, key = "TricksOfTheTrade" },
	{ type = "entry", text = "\124T"..select(3, GetSpellInfo(6774))..":26:26\124t Use Slice And Dice at Combopoints", tooltip = "Use Slice And Dice at Combopoints", enabled = true, value = 1, key = "SliceAndDice" },
	{ type = "entry", text = "\124T"..select(3, GetSpellInfo(48672))..":26:26\124t Use Rupture at Combopoints", tooltip = "Use Rupture at Combopoints", enabled = true, value = 1, key = "Rupture" },
	{ type = "entry", text = "\124T"..select(3, GetSpellInfo(51690))..":26:26\124t Use Killing Spree (Boss Only)", tooltip = "Use Killing Spree on (Boss Only)", enabled = true, key = "KillingSpree" },
	{ type = "entry", text = "\124T"..select(3, GetSpellInfo(13877))..":26:26\124t Use Blade Flurry (Boss Only)", tooltip = "Use Blade Flurry on (Boss Only)", enabled = true, key = "BladeFlurry" },
	{ type = "entry", text = "\124T"..select(3, GetSpellInfo(13750))..":26:26\124t Use Adrenaline Rush (Boss Only)", tooltip = "Use Adrenaline Rush on (Boss Only)", enabled = true, key = "AdrenalineRush" },
	{ type = "entry", text = "\124T"..select(3, GetSpellInfo(54758))..":26:26\124t Use Hyperspeed Accelerators (Boss Only)", tooltip = "Use Hyperspeed Accelerators (Boss Only)", enabled = true, key = "HyperspeedAccelerators" },
};
 
local function GetSetting(name)
    for k, v in ipairs(items) do
        if v.type == "entry"
         and v.key ~= nil
         and v.key == name then
            return v.value, v.enabled
        end
    end
end;

local function OnLoad()
	ni.GUI.AddFrame("Rogue - Combat PvE by Dreams", items);
end

local function OnUnLoad()  
	ni.GUI.DestroyFrame("Rogue - Combat PvE by Dreams");
end

local spells = {
	TricksOfTheTrade = {id = 57934, name = GetSpellInfo(57934)},
	SliceAndDice = {id = 6774, name = GetSpellInfo(6774)},
	Rupture = {id = 48672, name = GetSpellInfo(48672)},
	Eviscreate = {id = 48668, name = GetSpellInfo(48668)},
	SinisterStrike = {id = 48638, name = GetSpellInfo(48638)},
	KillingSpree = {id = 51690, name = GetSpellInfo(51690)},
	BladeFlurry = {id = 13877, name = GetSpellInfo(13877)},
	AdrenalineRush = {id = 13750, name = GetSpellInfo(13750)},
};

local queue = {
    "Tricks of the Trade",
    "Slice And Dice",
    "Rupture",
    "Eviscreate",
    "Sinister Strike",
    "Hyperspeed Accelerators",
    "Killing Spree",
    "Blade Flurry",
    "Adrenaline Rush"
};
 
local abilities = {
	["Tricks of the Trade"] = function()
	local _, enabled = GetSetting("TricksOfTheTrade")
		if enabled
			and ni.spell.available(spells.TricksOfTheTrade.id)
			and UnitAffectingCombat("player") 
			and ni.unit.exists("focus") then
				ni.spell.cast(spells.TricksOfTheTrade.name, "focus")
				return true;
		end 
	end,

	["Slice And Dice"] = function()
	local value, enabled = GetSetting("SliceAndDice")
		if enabled
			and ni.spell.available(spells.SliceAndDice.id)
			and UnitAffectingCombat("player")
			and GetComboPoints("player", "target") >= value
			and ni.player.buff(spells.SliceAndDice.id) == nil then
				ni.spell.cast(spells.SliceAndDice.name, "target")
				return true;
		end 
	end,

	["Rupture"] = function()
	local value, enabled = GetSetting("Rupture")
		if enabled
			and ni.spell.available(spells.Rupture.id)
			and UnitAffectingCombat("player")
			and GetComboPoints("player", "target") >= value
			and ni.unit.debuff("target", 48672, "player") == nil then -- Rupture --
				ni.spell.cast(spells.Rupture.name, "target")
				return true;
		end 
	end,

	["Eviscreate"] = function()
	if ni.spell.available(spells.Eviscreate.id)
		and UnitAffectingCombat("player")
		and GetComboPoints("player", "target") >= 5 then
			ni.spell.cast(spells.Eviscreate.name, "target")
			return true;
		end 
	end,

	["Sinister Strike"] = function()
	if ni.spell.available(spells.SinisterStrike.id)
		and UnitAffectingCombat("player") then
			ni.spell.cast(spells.SinisterStrike.name, "target")
			return true;
		end 
	end,

	["Hyperspeed Accelerators"] = function()
	local _, enabled = GetSetting("HyperspeedAccelerators")
		if enabled
			and ni.unit.isboss("target")
			and UnitAffectingCombat("player")
			and ni.player.slotcd(10) == 0 then
				ni.player.useinventoryitem(10) -- Hyperspeed Accelerators (Engineering Glove Entchant) --
				return true;
		end
	end,

	["Killing Spree"] = function()
	local _, enabled = GetSetting("KillingSpree")
		if enabled
			and ni.unit.isboss("target") 
			and UnitAffectingCombat("player")
			and ni.spell.available(spells.KillingSpree.id) then
				ni.spell.cast(spells.KillingSpree.name, "target")
				return true;
		end
	end,

	["Blade Flurry"] = function()
	local _, enabled = GetSetting("BladeFlurry")
		if enabled
			and ni.unit.isboss("target") 
			and UnitAffectingCombat("player")
			and ni.spell.available(spells.BladeFlurry.id) then
				ni.spell.cast(spells.BladeFlurry.name, "player")
				return true;
		end
	end,

	["Adrenaline Rush"] = function()
	local _, enabled = GetSetting("AdrenalineRush")
		if enabled
			and ni.unit.isboss("target") 
			and UnitAffectingCombat("player")
			and ni.spell.available(spells.AdrenalineRush.id) then
				ni.spell.cast(spells.AdrenalineRush.name, "player")
				return true;
		end
	end,
};
ni.bootstrap.profile("Rogue - Combat PvE by Dreams", queue, abilities, OnLoad, OnUnLoad);