local items = {
	settingsfile = "Mage - Fire PvE by Dreams.json",
	{ type = "title", text = "Mage - Fire PvE by |c0000CED1Dreams" },
	{ type = "separator" },
	{ type = "title", text = "|cffFFFF00Settings" },
	{ type = "entry", text = "\124T"..GetItemIcon(36799)..":26:26\124t Use Mana Gem < MP%", tooltip = "Use Mana Gem < MP%", enabled = true, value = 70, key = "ManaGem" },
	{ type = "entry", text = "\124T"..select(3, GetSpellInfo(12051))..":26:26\124t Use Evocation < MP%", tooltip = "Use Evocation < MP%", enabled = true, value = 10, key = "Evocation" },
	{ type = "entry", text = "\124T"..select(3, GetSpellInfo(55342))..":26:26\124t Use Mirror Image", tooltip = "Use Mirror Image", enabled = true, key = "MirrorImage" },
	{ type = "entry", text = "\124T"..select(3, GetSpellInfo(11129))..":26:26\124t Use Combustion", tooltip = "Use Combustion", enabled = true, key = "Combustion" },
	{ type = "entry", text = "\124T"..select(3, GetSpellInfo(42859))..":26:26\124t Use Scorch", tooltip = "Use Scorch", enabled = true, key = "Scorch" },
	{ type = "entry", text = "\124T"..select(3, GetSpellInfo(42873))..":26:26\124t Use Fireblast while moving", tooltip = "Use Fireblast", enabled = true, key = "Fireblast" },
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
	ni.GUI.AddFrame("Mage - Fire PvE by Dreams", items);
end

local function OnUnLoad()  
	ni.GUI.DestroyFrame("Mage - Fire PvE by Dreams");
end

local spells = {
	ConjureManaGem = {id = 42985, name = GetSpellInfo(42985)},
	MoltenArmor = {id = 43046, name = GetSpellInfo(43046)},
	ArcaneBrilliance = {id = 43002, name = GetSpellInfo(43002)},
	Evocation = {id = 12051, name = GetSpellInfo(12051)},
	Pyroblast = {id = 42891, name = GetSpellInfo(42891)},
	Scorch = {id = 42859, name = GetSpellInfo(42859)},
	LivingBomb = {id = 55360, name = GetSpellInfo(55360)},
	MirrorImage = {id = 55342, name = GetSpellInfo(55342)},
	Combustion = {id = 11129, name = GetSpellInfo(11129)},
	Fireblast = {id = 42873, name = GetSpellInfo(42873)},
	Fireball = {id = 42833, name = GetSpellInfo(42833)}
};

local queue = {
    "Molten Armor",
    "Arcane Brilliance",
	"Conjure Mana Gem",
	"Mana Gem",
	"Fireblast",
    "Evocation",
    "Pyroblast",
    "Scorch",
    "Living Bomb",
	"Mirror Image",
    "Combustion",
    "Fireball"
};
 
local abilities = {
	["Molten Armor"] = function()
		if ni.spell.available(spells.MoltenArmor.id)
			and not ni.unit.ischanneling("player")
			and not ni.player.buff(spells.MoltenArmor.id) then
				ni.spell.cast(spells.MoltenArmor.name)
				return true;
		end
	end,

	["Arcane Brilliance"] = function()
		if ni.spell.available(spells.ArcaneBrilliance.id) 
			and not ni.player.buff(spells.ArcaneBrilliance.id) then
				ni.spell.cast(spells.ArcaneBrilliance.name)
				return true;
		end
	end, 

	["Conjure Mana Gem"] = function()
		if ni.spell.available(spells.ConjureManaGem.id) 
			and not ni.player.ismoving()
			and not UnitAffectingCombat("player")
			and not ni.player.hasitem(33312) -- Mana Sapphire --
			and not ni.unit.ischanneling("player") then 
				ni.spell.cast(spells.ConjureManaGem.name)
				return true;	
		end 
	end,

	["Mana Gem"] = function()
	local value, enabled = GetSetting("ManaGem")
		if enabled
			and UnitAffectingCombat("player")
			and ni.player.power() <= value
			and not ni.unit.ischanneling("player")
			and ni.player.hasitem(33312) -- Mana Sapphire --
			and ni.player.itemcd(33312) < 1 then -- Mana Sapphire --
				ni.player.useitem(33312) -- Mana Sapphire --
				return true;
		end
	end,

	["Evocation"] = function()
	local value, enabled = GetSetting("Evocation")
		if enabled
			and ni.spell.available(spells.Evocation.id)
			and UnitAffectingCombat("player")
			and ni.player.power() <= value
			and not ni.unit.ischanneling("player") then
				ni.spell.cast(spells.Evocation.name, "player")
				return true;
		end 
	end,

	["Pyroblast"] = function()
		if ni.spell.available(spells.Pyroblast.id)
			and UnitAffectingCombat("player")
			and ni.unit.buff("player", 48108, "player") -- Hot Streak --
			and not ni.unit.ischanneling("player") then
				ni.spell.cast(spells.Pyroblast.name, "target")
				return true;
		end
	end,

	["Scorch"] = function()
	local _, enabled = GetSetting("Scorch")
		if enabled 
			and ni.spell.available(spells.Scorch.id)
			and UnitAffectingCombat("player")
			and ni.unit.isboss("target")
			and ni.unit.debuff("target", 22959, "player") == nil -- Improved Scorch --
			and ni.unit.debuff("target", 17803, "player") == nil -- Improved Shadow Bolt --
			and not ni.unit.ischanneling("player") then
				ni.spell.cast(spells.Scorch.name, "target")
				return true;
		end
	end,

	["Living Bomb"] = function()
		if ni.spell.available(spells.LivingBomb.id)
			and UnitAffectingCombat("player")
			and ni.unit.debuff("target", 55360, "player") == nil -- Living Bomb --
			and not ni.unit.ischanneling("player") then
				ni.spell.cast(spells.LivingBomb.name, "target")
				return true;
		end
	end,

	["Mirror Image"] = function()
	local _, enabled = GetSetting("MirrorImage")
		if enabled
			and ni.unit.isboss("target") 
			and UnitAffectingCombat("player")
			and ni.spell.available(spells.MirrorImage.id) 
			and not ni.unit.ischanneling("player") then
				ni.spell.cast(spells.MirrorImage.name, "player")
				return true;
		end
	end,

	["Combustion"] = function()
	local _, enabled = GetSetting("Combustion")
		if enabled
			and ni.unit.isboss("target") 
			and UnitAffectingCombat("player")
			and ni.spell.available(spells.Combustion.id)  
			and not ni.unit.ischanneling("player") then
				ni.spell.cast(spells.Combustion.name, "player")
				return true;
		end
	end,

	["Fireblast"] = function()
	if ni.spell.available(spells.Fireblast.id) 
			and UnitAffectingCombat("player")
			and not ni.unit.ischanneling("player") 
			and ni.unit.ismoving("player") then
				ni.spell.cast(spells.Fireblast.name, "target")
				return true;
		end
	end,

	["Fireball"] = function()
	if ni.spell.available(spells.Fireball.id) 
			and UnitAffectingCombat("player")
			and not ni.unit.ischanneling("player") then
				ni.spell.cast(spells.Fireball.name, "target")
				return true;
		end
	end,
};
ni.bootstrap.profile("Mage - Fire PvE by Dreams", queue, abilities, OnLoad, OnUnLoad);	
