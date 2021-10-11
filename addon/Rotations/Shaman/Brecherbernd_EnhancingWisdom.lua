local lightningbolt = GetSpellInfo(403)
local primalstrike = GetSpellInfo(73899)
local earthshock = GetSpellInfo(8042)
local flametounge = GetSpellInfo(8024)
local lightningshield = GetSpellInfo(324)
local lavalash = GetSpellInfo(60103)
local windfury = GetSpellInfo(8232)
local flameshock = GetSpellInfo(8050)
local healingsurge = GetSpellInfo(8004)
local ghostwolf = GetSpellInfo(2645)
local searingtotem = GetSpellInfo(3599)
local totemicrecall = GetSpellInfo(36936)
local feralspirit = GetSpellInfo(51533)
local elementalmastery = GetSpellInfo(16166)
local firenova = GetSpellInfo(1535)
local chainlightning = GetSpellInfo(421)
local unleashelements = GetSpellInfo(73680)
local lastcast = 0

local items = {
	settingsfile = "Brecherbernd_EnhancingWisdom.json",
	{ type = "title", text = "Ehancing Wisdom by |cff0070DEBrecherbernd" },
	{ type = "separator" },
	{ type = "page", number = 1, text = "|cffFFFF00Main Settings" },
	{ type = "separator" },
	{ type = "entry", text = "\124T"..select(3, GetSpellInfo(403))..":26:26\124t Lightning Bolt", tooltip = "Use Lightning Bolt", enabled = true, key = "lightningbolt" },
	{ type = "entry", text = "\124T"..select(3, GetSpellInfo(16166))..":26:26\124t Elemental Mastery", tooltip = "Use Elemental Mastery", enabled = true, key = "elementalmastery" },
	{ type = "entry", text = "\124T"..select(3, GetSpellInfo(2645))..":26:26\124t Ghostwolf", tooltip = "Use Ghostwolf when moving", enabled = true, value = 1.5, key = "ghostwolf" },
	{ type = "separator" },
	{ type = "title", text = "Choose your desired Armor PLACEHOLDER" },
	{ type = "separator" },
	{ type = "entry", text = "\124T"..select(3, GetSpellInfo(7302))..":26:26\124t Frost Armor PLACEHOLDER", tooltip = "Frost Armor", enabled = true, key = "frostarmor" },
	{ type = "entry", text = "\124T"..select(3, GetSpellInfo(6117))..":26:26\124t Mage Armor PLACEHOLDER", tooltip = "Mage Armor", enabled = true, key = "magearmor" },
	-------------------
	{ type = "page", number = 2, text = "|cffFFFF00Utility" },
	{ type = "separator" },
	{ type = "entry", text = "\124T"..select(3, GetSpellInfo(8004))..":26:26\124t Healing Surge < HP%", tooltip = "Healing Surge", enabled = true, value = 50, key = "Healing Surge" },
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
	ni.GUI.AddFrame("Brecherbernd_EnhancingWisdom", items);
end
local function OnUnLoad()  
	ni.GUI.DestroyFrame("Brecherbernd_EnhancingWisdom");
end	

--GetTotemInfo thx to HBNUK
local fireSlot, earthSlot, waterSlot, airSlot = 1, 2, 3, 4;
local function HasTotem(slot, name)
	local haveTotem, totemName = GetTotemInfo(slot)
	if haveTotem and totemName == name then
		return true
	end
	if haveTotem and totemName == nil then
		return true
	end
	return false
end
local function TotemTimeRemaining(slot, name)
	if not HasTotem(slot, name) then
		return 0
	end
	local _, _, startTime, duration = GetTotemInfo(slot)
	return startTime + duration - GetTime()
end

local queue ={
	"Enchant Weapon",
	"Lightning Shield",
	"Healing Surge",
	"Totemic Recall",
	"Ghost Wolf",
	"Pause",
	"Auto Target",
	"Searing Totem",
	"Elemental Mastery",
	"Auto Attack",
	"Chain Lightning",
	"Lightning Bolt",
	"Feral Spirit",
	"Primal Strike",
	"Flame Shock",
	"Lava Lash",
	"Fire Nova",
	"Unleash Elements",
	"Earth Shock"
}

local abilities = {

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
			AttackTarget("Target");
		end
	end,

["Healing Surge"] = function()
		local value, enabled = GetSetting("Healing Surge")
				 if enabled
				 and ni.unit.hp("player") <= value 
				 and GetTime() - lastcast > 2
				 then lastcast = GetTime()
					ni.spell.cast(healingsurge)
					return true;	
				end 
			end,	

["Totemic Recall"] = function()
local affectingCombat = UnitAffectingCombat("player");  
			 if TotemTimeRemaining(1, searingtotem) > 3
			 and not affectingCombat
			 and not ni.unit.ismounted("player")
			 and ni.spell.available(totemicrecall) then
				ni.spell.cast(totemicrecall)
				return true
			end
		end,

["Ghost Wolf"] = function()
		local affectingCombat = UnitAffectingCombat("player");    
		local value, enabled = GetSetting("ghostwolf")
				 if enabled
				 and not affectingCombat
				 and not ni.unit.ismounted("player")
				 and ni.player.movingfor(value * 15)
				 and not ni.player.buff(ghostwolf) then
					ni.spell.cast(ghostwolf)
					return true;    
				end 
			end,

["Enchant Weapon"] = function()
		local mh, _, _, oh = GetWeaponEnchantInfo()
		if mh == nil 
		 and ni.spell.available(windfury) then
			ni.spell.cast(windfury)
			return true
		end
		if oh == nil
		 and ni.spell.available(flametounge) then
			ni.spell.cast(flametounge)
			return true
		end
	end,
	
["Lightning Shield"] = function()
		if ni.spell.available(lightningshield)
		and not ni.player.buff(lightningshield)
		then ni.spell.cast(lightningshield, "player")
            return true
         end
	end,
	
["Searing Totem"] = function()
	local affectingCombat = UnitAffectingCombat("player");  
		if TotemTimeRemaining(1, searingtotem) < 5
		and affectingCombat
		and ni.spell.available(searingtotem) then
			ni.spell.cast(searingtotem)
		end
	end,

["Fire Nova"] = function()
	local bang = ni.unit.enemiesinrange("target", 7)
		if ni.spell.available(firenova)
		and ni.unit.debuff("target", 8050)
		and #bang >= 2
		then ni.spell.cast(firenova)
            return true
        end
	end,

["Auto Attack"] = function()
	if not IsCurrentSpell(6603) then
		ni.spell.cast(6603);
	end
end,
--- Stormstrike and Primal take the same id, so this works for leveling aswell
["Primal Strike"] = function()
		if ni.spell.available(primalstrike)
		and ni.spell.valid("target", primalstrike)
		then ni.spell.cast(primalstrike, "target")
            return true
         end
	end,

["Feral Spirit"] = function()
		if ni.spell.available(feralspirit)
		then ni.spell.cast(feralspirit)
         end
	end,

["Flame Shock"] = function()
		if ni.spell.available(flameshock)
		and ni.spell.valid("target", flameshock)
		and not ni.unit.debuff("target", 8050)
		or ni.unit.buff("player", 73683)
            then ni.spell.cast(flameshock, "target")
            return true
         end
    end,

["Lava Lash"] = function()
		if ni.spell.available(lavalash)
		and ni.spell.valid("target", lavalash)
		then ni.spell.cast(lavalash, "target")
            return true
         end
	end,
	
["Unleash Elements"] = function()
		if ni.spell.available(unleashelements)
		and ni.spell.valid("target", unleashelements)
            then ni.spell.cast(unleashelements, "target")
            return true
         end
	end,	
	
["Earth Shock"] = function()
		if ni.spell.available(earthshock)
		and ni.spell.valid("target", earthshock)
            then ni.spell.cast(earthshock, "target")
            return true
         end
    end,

["Lightning Bolt"] = function()
	local blitz = ni.unit.enemiesinrange("target", 7)
	local value, enabled = GetSetting("lightningbolt")
		if enabled
		and ni.spell.available(lightningbolt)
		and ni.unit.buffstacks("player", 53817) == 5
		and #blitz <= 2
            then ni.spell.cast(lightningbolt, "target")
            return true
        end
	end,

["Chain Lightning"] = function()
	local chainz = ni.unit.enemiesinrange("target", 7)
		if ni.spell.available(chainlightning)
		and ni.unit.buffstacks("player", 53817) == 5
		and #chainz >= 3
			then ni.spell.cast(chainlightning, "target")
			return true
		end
	end,
	
["Elemental Mastery"] = function()
		local value, enabled = GetSetting("elementalmastery")
			if enabled
			and ni.spell.available(elementalmastery)
				then ni.spell.cast(elementalmastery)
				return true
			end
		end,
}

ni.bootstrap.profile("Brecherbernd_EnhancingWisdom", queue, abilities, OnLoad, OnUnLoad);	