local build = select(4, GetBuildInfo());
local cata = build == 40300 or false;
if cata then
local AntiAFKTime, LastReset, LastPurge = 0, 0, 0;
local enemies = {};
local items = {
	settingsfile = "EnchShammy_Free_Cata.json",
	{ type = "title", text = "Cata Enchantment Shaman by |c0000CED1DarhangeR|r" },
	{ type = "separator" },
	{ type = "title", text = "|cff0082FFProfile version 0.0.1|r" },
	{ type = "separator" },
	{ type = "page", number = 1, text = "|cffFFFF00Main Settings" },
	{ type = "separator" },
	{ type = "title", text = "Enchant Main Hand" },	
	{ type = "dropdown", menu = {
 		{ selected = true, value = GetSpellInfo(8232), text = ni.spell.icon(8232, 18, 18).." Windfury Weapon" },      
	    { selected = false, value = GetSpellInfo(8024), text = ni.spell.icon(8024, 18, 18).." Flametongue Weapon" },       
	    { selected = false, value = GetSpellInfo(8033), text = ni.spell.icon(8033, 18, 18).." Frostbrand Weapon" },
		{ selected = false, value = GetSpellInfo(8017), text = ni.spell.icon(8017, 18, 18).." Rockbiter Weapon" },		
    }, key = "mainhand" },
	{ type = "title", text = "Enchant Off Hand" },	
	{ type = "dropdown", menu = {
 		{ selected = false, value = GetSpellInfo(8232), text = ni.spell.icon(8232, 18, 18).." Windfury Weapon" },      
	    { selected = true, value = GetSpellInfo(8024), text = ni.spell.icon(8024, 18, 18).." Flametongue Weapon" },       
	    { selected = false, value = GetSpellInfo(8033), text = ni.spell.icon(8033, 18, 18).." Frostbrand Weapon" }, 
		{ selected = false, value = GetSpellInfo(8017), text = ni.spell.icon(8017, 18, 18).." Rockbiter Weapon" },		
    }, key = "offhand" },
	{ type = "separator" },	
	{ type = "entry", text = ni.spell.icon(324, 22, 22).." Lightning Shield (Max. |cff0082FFMP|r %)", tooltip = "Use spell when player |cff0082FFMP|r > %.", value = 35, min = 15, max = 85, step = 1, width = 40, key = "lshield" },
	{ type = "entry", text = ni.spell.icon(52127, 22, 22).." Water Shield (Min. |cff0082FFMP|r %)", tooltip = "Use spell when player |cff0082FFMP|r < %.", value = 15, min = 15, max = 65, step = 1, width = 40, key = "wshield" },
	{ type = "entry", text = "|cffFF0D00Disable Shields|r", tooltip = "Disabling "..ni.spell.icon(324, 14, 14).."[Lightning Shield] and "..ni.spell.icon(52127, 14, 14).."[Water Shield].", enabled = false, key = "dishield" },
	{ type = "separator" },
	{ type = "title", text = "|cffFFFF00Important Settings|r" },
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(6603).." |cffffa500Auto Target|r", tooltip = "Auto Target and Auto Attack nerest targets.", enabled = true, key = "AutoAttack" },	
	{ type = "entry", text = ni.spell.icon(2382, 22, 22).." |cffffa500Debug Printing|r", tooltip = "Enable for debug if you have problems.\n\nUse the macro |cff00D700/ppause|r to pause CR.\n\nThe value in the seconds field for which the CR will stop.", value = 1.5, min = 1, max = 6, step = 0.1, width = 40, enabled = false, key = "Debug" },
	{ type = "page", number = 2, text = "|cffEE4000Rotation Settings|r" },
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(57994, 22, 22).." Auto Interrupt", tooltip = "Auto check and interrupt all interruptible spells.", enabled = true, key = "autointerrupt" },	
	{ type = "entry", text = ni.spell.icon(370, 22, 22).." Purge", tooltip = "Purge proper buff from enemie.\n\nThe numbers indicate the interval in sec.\nat which the ability will be recast.", value = 2.5, min = 0.1, max = 10, step = 0.1, width = 40, enabled = true, key = "purge" },	
	{ type = "separator" },
	{ type = "title", text = "Dispel" },
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(52798, 22, 22).." Delay For Dispeling", tooltip = "Delay in seconds or ms before you dispel something.", value = 1.5, min = 0.1, max = 5, step = 0.1, width = 40, key = "DispelDelay" },
	{ type = "entry", text = ni.spell.icon(51886, 22, 22).." Cleanse Spirit", tooltip = "Auto dispel debuffs from player.", enabled = true, key = "toxins" },
	{ type = "entry", text = "Cleanse Spirit (Allys)", tooltip = "Auto dispel debuffs from members.", enabled = false, key = "toxinsmemb" },		
};
-- Get Setting from GUI -- 
local function GetSetting(name)
	for k, v in ipairs(items) do
		if v.type == "entry"
		and v.key ~= nil
		and v.key == name then
			return v.value, v.enabled;
		end
		if v.type == "dropdown"
		and v.key ~= nil
		and v.key == name then
			for k2, v2 in pairs(v.menu) do
				if v2.selected then
					return v2.value;
				end
			end
		end
		if v.type == "input"
		and v.key ~= nil
		and v.key == name then
			return v.value;
		end
	end
end;
-- Load GUI -- 
local function OnLoad()
	ni.GUI.AddFrame("Cata_Enhancement_DarhangeR", items);
end;
-- Unload GUI -- 
local function OnUnLoad()  
	ni.GUI.DestroyFrame("Cata_Enhancement_DarhangeR");
end;
-- Local functions for profile -- 
local function UsableSilence(spellid, stutter)
	if tonumber(spellid) == nil then
		spellid = ni.spell.id(spellid)
	end
	local result = false;
	if spellid == nil or spellid == 0 then
		return false;
	end
	local spellName = GetSpellInfo(spellid);
	if not ni.player.isstunned()
	and not ni.player.issilenced()
	and ni.spell.available(spellid, stutter)
	and IsUsableSpell(spellName) then
		result = true;
	end
	return result;
end;
local function IsKnown(spellid, isPetSpell)
	isPetSpell = true and isPetSpell or false
	if tonumber(spellid) == nil then
		spellid = ni.spell.id(spellid)
	end
	local result = false;
	if spellid == nil or spellid == 0 then
		return false;
	end
	if IsSpellKnown(spellid, isPetSpell) then
		local name = GetSpellInfo(spellid)
		if name then
			result = true;
		end
	end
	return result;
end;
local function GetMelee(t, spellid)
	if tonumber(spellid) == nil then
		spellid = ni.spell.id(spellid)
	end
	if ni.player.los(t)
	and ni.player.isfacing(t) then
		if IsKnown(spellid) then
			local spellName = GetSpellInfo(spellid);
			return IsSpellInRange(spellName, t) == 1;	
		else
			return plaMelee(t);
		end
	end
end;
-- Spells Table --
local spells = {
PrimalStrike = GetSpellInfo(73899),
EarthShock = GetSpellInfo(8042),
FlameShock = GetSpellInfo(8050),
WindShear = GetSpellInfo(57994),
LightningShield = GetSpellInfo(324),
WaterShield = GetSpellInfo(52127),
LavaLash = GetSpellInfo(60103),
PurgeSpell = GetSpellInfo(370),

CleanseSpirit = GetSpellInfo(51886),
};
-- "Cache" Table -- 
local cache = {
IsMoving = false,
PlayerCombat = false,
UnitAttackable = false,
PlayerControled = false,
FlameShock = false;
FlameShockT = false;
};
local queue = {
	"Cache",
	"Universal Pause",
	"AutoTarget",
	"Enchant Weapon",
	"Lightning Shield",
	"Combat specific Pause",
	"Wind Shear (Interrupt)",
	"Primal Strike",
	"Lava Lash",
	"Purge",
	"Flame Shock",
	"Earth Shock",
	"Cure Toxins (Self)",
	"Cure Toxins (Ally)",
};
local abilities = {
-----------------------------------
	["Cache"] = function()
		if GetTime() - AntiAFKTime > 80 then
			ni.utils.resetlasthardwareaction();
			AntiAFKTime = GetTime();
		end
		cache.IsMoving = ni.player.ismoving() or false;
		cache.PlayerCombat = ni.player.incombat() or false;
		cache.UnitAttackable = (UnitExists("target") and UnitCanAttack("player", "target")) or false;	
		cache.PlayerControled = (ni.player.issilenced() or ni.player.isstunned() or ni.player.isconfused() or ni.player.isfleeing()) or false;		
		if cache.UnitAttackable then
			cache.GetRange = GetMelee("target", spells.PrimalStrike) or false;
			cache.FlameShock = ni.unit.debuff("target", spells.FlameShock, "player") or false;
			local FST = ni.unit.debuffremaining("target", spells.FlameShock, "player");
			if FST then
				cache.FlameShockT = FST;
			else
				cache.FlameShockT = false;
			end			
		end			
		if cache.PlayerCombat
		and (GetTime() - LastReset >= 15) then
			wipe(enemies);
			LastReset = GetTime()
		end
	end,
-----------------------------------
	["Universal Pause"] = function()
		if IsMounted()
		or UnitInVehicle("player")
		or UnitIsDeadOrGhost("player")
		or UnitChannelInfo("player")
		or UnitCastingInfo("player")
		or ni.player.islooting() then
			return true;
		end
		ni.vars.debug = select(2, GetSetting("Debug"));
	end,
-----------------------------------		
	["AutoTarget"] = function()
		local _, enabled = GetSetting("AutoAttack");
		if not enabled then
			return false;
		end
		if cache.PlayerCombat then
			if not UnitExists("target")
			or ((UnitExists("target")
			and UnitIsDeadOrGhost("target"))
			or not UnitCanAttack("player", "target"))
			and not IsCurrentSpell(GetSpellInfo(6603)) then
				local enemies = ni.player.enemiesinrange(15);
				for i = 1, #enemies do
				local tar = enemies[i].guid;
					if enemies[i].distance <= 15 
					and not ni.unit.istotem(tar)
					and ni.player.isfacing(tar) then
						ni.player.target(tar)
						spellCast(GetSpellInfo(6603), tar) 
						return true;
					end
				end
			end
		end
	end,	
-----------------------------------		
    ["Enchant Weapon"] = function()
		local MainHandSpell = GetSetting("mainhand");
		local OffHandSpell = GetSetting("offhand");
		local enchantMain, _, _, enchantSecond = GetWeaponEnchantInfo();
		if GetInventoryItemID("player", 16) ~= nil then
			if not enchantMain
			and UsableSilence(MainHandSpell) then
				ni.spell.cast(MainHandSpell)
				BindEnchant()
				return true;
			end
		end
		if GetInventoryItemID("player", 17) ~= nil then
			if (select(9, GetItemInfo(GetInventoryItemID("player", 17))) == "INVTYPE_WEAPON" 
			or select(9, GetItemInfo(GetInventoryItemID("player", 17))) == "INVTYPE_WEAPONOFFHAND") then
				if not IsEquippedItemType("Shields") then
					if not enchantSecond
					and UsableSilence(OffHandSpell) then
						ni.spell.cast(OffHandSpell)
						BindEnchant()
						return true;
					end
				end
			end
		end
	end,
-----------------------------------	
	["Lightning Shield"] = function()
		local _, enabled = GetSetting("dishield");
		local value = GetSetting("lshield");
		if enabled
		or ni.player.buff(spells.LightningShield)
		or not UsableSilence(spells.LightningShield) then
			return false;
		end
		if ni.player.power(0) >= value then
			ni.spell.cast(spells.LightningShield)
			return true;
		end
	end,
-----------------------------------
	["Water Shield"] = function()
		local _, enabled = GetSetting("dishield");
		local value = GetSetting("wshield");	
		if enabled
		or ni.player.buff(spells.WaterShield)
		or not UsableSilence(spells.WaterShield) then
			return false;
		end	
		if ni.player.power(0) <= value then
			ni.spell.cast(spells.WaterShield)
			return true;
		end
	end,	
-----------------------------------
	["Combat specific Pause"] = function()
		if not UnitCanAttack("player", "target")
		or (not ni.unit.incombat("target")
		and not ni.unit.isdummy("target")
		and not ni.unit.isplayer("target")) then 
			return true
		end
	end,
-----------------------------------	
	["Wind Shear (Interrupt)"] = function()
		local _, enabled = GetSetting("autointerrupt");
		if not enabled then
			return false;
		end
		if UsableSilence(spells.WindShear) then
		local WindShearRange = select(9, GetSpellInfo(spells.WindShear))
		local enemies = ni.player.enemiesinrange(WindShearRange);
		for i = 1, #enemies do
			local InterruptTargets = enemies[i].guid;
				if ni.spell.shouldinterrupt(InterruptTargets)
				and ni.spell.valid(InterruptTargets, spells.WindShear, true, true)  then
					ni.spell.cast(spells.WindShear, InterruptTargets)
					return true;
				end
			end
		end
	end,
-----------------------------------
	["Primal Strike"] = function()
		if not cache.GetRange then
			return false;
		end
		if UsableSilence(spells.PrimalStrike) then
			ni.spell.cast(spells.PrimalStrike, "target")
			return true;
		end
	end,
-----------------------------------
	["Lava Lash"] = function()
		if not cache.GetRange then
			return false;
		end
		if UsableSilence(spells.LavaLash) then
			ni.spell.cast(spells.LavaLash, "target")
			return true;
		end
	end,
-----------------------------------
	["Flame Shock"] = function()
		if not UsableSilence(spells.FlameShock) then
			return false;
		end
		if (not cache.FlameShock or cache.FlameShockT < 2)
		and ni.spell.valid("target", spells.FlameShock, true, true) then
			ni.spell.cast(spells.FlameShock, "target")
			return true;
		end
	end,	
-----------------------------------
	["Earth Shock"] = function()
		if not UsableSilence(spells.EarthShock) then
			return false;
		end
		if ni.spell.valid("target", spells.EarthShock, true, true) then
			ni.spell.cast(spells.EarthShock, "target")
			return true;
		end
	end,
-----------------------------------
	["Purge"] = function()
		local timer, enabled = GetSetting("purge");
		if not enabled then
			return false;
		end
		if UsableSilence(spells.Purge) then
			if ni.unit.bufftype("target", "Magic")
			and (GetTime() - LastPurge >= timer)
			and ni.spell.valid("target", spells.PurgeSpell, false, true) then
				ni.spell.cast(spells.PurgeSpell, "target")
				LastPurge = GetTime()
				return true;
			end
		end
	end,
-----------------------------------	
	["Cure Toxins (Self)"] = function()
		local _, cure = GetSetting("toxins");
		local _, cureAlly = GetSetting("toxinsmemb");
		local val = GetSetting("DispelDelay"); 
		if (cure and not cureAlly) then
			if UsableSilence(spells.CureToxins) then
				if ni.player.debufftype("Curse")
				and ni.healing.candispel("player")
				and (GetTime() - LastCure >= val) then
					ni.spell.cast(spells.CureToxins, "player")
					LastCure = GetTime()
					return true;
				end
			end
		end
	end,
-----------------------------------
	["Cure Toxins (Ally)"] = function()
		local _, cureAlly = GetSetting("toxinsmemb");
		local val = GetSetting("DispelDelay"); 	
		if not toxinsmemb then
			return false;
		end
		if UsableSilence(spells.CureToxins) then
			for i = 1, #ni.members.sort() do
			local ally = ni.members[i];
				if ally:debufftype("Curse")
				and ally:dispel()
				and (GetTime() - LastCure >= val)
				and ally:valid(spells.CureToxins, false, true) then
					spellCast(spells.CureToxins, ally.unit)
					LastCure = GetTime()
					return true;
				end
			end
		end
	end,
};
	ni.bootstrap.profile("Cata_Enhancement_DarhangeR", queue, abilities, OnLoad, OnUnLoad);
else
    local queue = {
        "Error",
    };
    local abilities = {
        ["Error"] = function()
            ni.vars.profiles.enabled = false;
			if not cata then
				ni.frames.floatingtext:message("This profile for Cata!")
            end
        end,
    };
    ni.bootstrap.profile("Cata_Enhancement_DarhangeR", queue, abilities);
end;