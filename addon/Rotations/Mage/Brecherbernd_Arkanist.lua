------- Rewritten for the new ni. Big Credits to Cartman, Darhanger and Scott!

local ConjureManaGem = GetSpellInfo(759)
local arcaneintellect = GetSpellInfo(1459)
local frostarmor = GetSpellInfo(7302)
local magearmor = GetSpellInfo(6117)
local runeofpower = GetSpellInfo(116011)
local livingbomb = GetSpellInfo(44457)
local arcanemissiles = GetSpellInfo(5143)
local arcanebarrage = GetSpellInfo(44425)
local arcaneblast = GetSpellInfo(30451)
local icefloes = GetSpellInfo(108839)
local mirrorimage = GetSpellInfo(55342)
local arcanepower = GetSpellInfo(12042)
local altertime = GetSpellInfo(108978)
local arcaneexplosion = GetSpellInfo(1449)
local lastcast = 0

local items = {
	settingsfile = "Brecherbernd_Arkanist.json",
	{ type = "title", text = "Arkanist by |c0000CED1Brecherbernd" },
	{ type = "separator" },
	{ type = "page", number = 1, text = "|cffFFFF00Main Settings" },
	{ type = "separator" },
	{ type = "entry", text = "\124T"..select(3, GetSpellInfo(1459))..":26:26\124t Arcane Intellect", tooltip = "Arcane Intellect", enabled = true, key = "arcaneintellect" },
	{ type = "separator" },
	{ type = "title", text = "Choose your desired Armor" },
	{ type = "separator" },
	{ type = "entry", text = "\124T"..select(3, GetSpellInfo(7302))..":26:26\124t Frost Armor", tooltip = "Frost Armor", enabled = true, key = "frostarmor" },
	{ type = "entry", text = "\124T"..select(3, GetSpellInfo(6117))..":26:26\124t Mage Armor", tooltip = "Mage Armor", enabled = true, key = "magearmor" },
	-------------------
	{ type = "page", number = 2, text = "|cffFFFF00Utility" },
	{ type = "separator" },
	{ type = "entry", text = "\124T"..select(3, GetSpellInfo(759))..":26:26\124t Mana Gem", tooltip = "Conjure Mana Gem", enabled = true, key = "ConjureManaGem" },
	{ type = "entry", text = "\124T"..GetItemIcon(36799)..":26:26\124t Use Mana Gem < MP%", tooltip = "Mana Gem", enabled = true, value = 50, key = "managem" },
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
	ni.GUI.AddFrame("Brecherbernd_Arkanist", items);
end
local function OnUnLoad()  
	ni.GUI.DestroyFrame("Brecherbernd_Arkanist");
end	

local queue = {
    "Arcane Brilliance",
	"Arcane Intellect",
	"Conjure Mana Gem",
	"Mana Gem",
	"Frost Armor",
	"Mage Armor",
	"Pause",
	"Auto Target",
  	"Ice Floes",
	"Rune of Power",
	"Arcane Power",
	"Alter Time",
  	"Mirror Image",
	"Living Bomb",
	"Arcane Explosion",
	"Arcane Missiles",
	"Arcane Barrage",
	"Arcane Blast"
};
 
local abilities = {

["Arcane Intellect"] = function()
local _, enabled = GetSetting("arcaneintellect")
        if enabled
			and ni.spell.available(arcaneintellect) 
            and not ni.player.buff(arcaneintellect) then
                ni.spell.cast(arcaneintellect)
                return true;
			end
		end, 		

["Conjure Mana Gem"] = function()
local _, enabled = GetSetting("ConjureManaGem")
		 if enabled
		 and ni.spell.available(ConjureManaGem) 
		 and not ni.player.ismoving()
		 and not UnitAffectingCombat("player")
		 and not ni.player.hasitem(36799) then 
			ni.spell.cast(ConjureManaGem)
			return true;	
		end 
	end,	

["Mana Gem"] = function()
local value, enabled = GetSetting("managem")
		 if enabled
		 and ni.player.power() <= value
		 and ni.player.hasitem(36799) then 
			ni.player.useitem(36799)
			return true;	
		end 
	end,	

["Frost Armor"] = function()
local _, enabled = GetSetting("frostarmor")
        if enabled
			and ni.spell.available(frostarmor) 
			and not ni.player.buff(frostarmor) then
				ni.spell.cast(frostarmor)
				return true;
		end
	end, 

["Mage Armor"] = function()
local _, enabled = GetSetting("magearmor")
		if enabled
			and ni.spell.available(magearmor) 
			and not ni.player.buff(magearmor) then
				ni.spell.cast(magearmor)
				return true;
		end
	end, 	

["Pause"] = function()
		if not UnitExists("target")
		 or (UnitExists("target")
		 and (not UnitCanAttack("player", "target")
		 or UnitIsDeadOrGhost("target")))
		 or UnitChannelInfo("player")
		 or UnitIsDeadOrGhost("player")
		 or IsMounted()
		 or delayrotation then
			return true;
		end
	end,

["Auto Target"] = function()
		if UnitAffectingCombat("player")
		 and ((ni.unit.exists("target")
		 and UnitIsDeadOrGhost("target")
		 and not UnitCanAttack("player", "target")) 
		 or not ni.unit.exists("target")) then
			ni.player.runtext("/targetenemy")
		end
	end,
["Ice Floes"] = function()
	if ni.spell.available(icefloes)
      and ni.unit.ismoving("player") 
      and not ni.unit.buff("player", 108839, "player") then
			ni.spell.cast(icefloes, "player")
			return true;
		end
	end,	
  
["Rune of Power"] = function()
      if ni.spell.available(runeofpower)
      and not ni.unit.buff("player", 116014, "player") 
      and not ni.unit.ismoving("player")
      and GetTime() - lastcast > 4
			then lastcast = GetTime()
			ni.spell.castat(runeofpower, "player")
			return true;
		end
	end,

["Arcane Power"] = function()
    if ni.unit.debuffstacks("player", 114664) == 4
		and ni.spell.available(arcanepower)
		and not ni.unit.ismoving("player") then
			  ni.spell.cast(arcanepower)
			  return true;
		end
	end,

["Alter Time"] = function()
    if ni.unit.debuffstacks("player", 114664) == 4
		and ni.spell.available(altertime)
		and not ni.unit.ismoving("player")
		and GetTime() - lastcast > 8
		then lastcast = GetTime()
			  ni.spell.cast(altertime)
			  return true;
		end
	end,

["Mirror Image"] = function()
    if ni.spell.available(mirrorimage) 
      and not ni.unit.ischanneling("player") then
		   ni.spell.cast(mirrorimage, "target")
		   return true
	   end
   end,	  

["Living Bomb"] = function()
		if ni.spell.available(livingbomb)
		and ni.unit.debuffremaining("target", "44461", "player") <= 2 then
			ni.spell.cast(livingbomb, "target")
			return true
		end
	end,
	
["Arcane Missiles"] = function()
    if ni.unit.debuffstacks("player", 114664) == 4
      and ni.unit.buff("player", "79683") 
      and not ni.unit.ischanneling("player") then
			ni.spell.cast(arcanemissiles, "target")
			return true
		end
	end,

["Arcane Barrage"] = function()
	if ni.unit.debuffstacks("player", 114664) == 4
	and not ni.unit.buff("player", 110909)
	and not ni.unit.ischanneling("player") then
			ni.spell.cast(arcanebarrage, "target")
			return true
		end
	end,
-- T16 Bonus needs to be implemented  

["Arcane Blast"] = function()
    if ni.spell.available(arcaneblast) 
      and not ni.unit.ischanneling("player") then
		   ni.spell.cast(arcaneblast, "target")
		   return true
	   end
   end,	
};
ni.bootstrap.profile("Brecherbernd_Arkanist", queue, abilities, OnLoad, OnUnLoad);	
