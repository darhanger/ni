local build = select(4, GetBuildInfo());
local cata = build == 40300 or false;
if cata then
local KnowEngineer = ni.player.getskillinfo(GetSpellInfo(4036)) > 500 or false;
local AntiAFKTime, LastReset, LastPurge = 0, 0, 0;
local fto, eto, wto, ato = nil, nil, nil, nil;
local UsePots = false;
local enemies = {};
local items = {
	settingsfile = "EnchShammy_Free_Cata.json",
	{ type = "title", text = "Enchantment Shaman by |c0000CED1DarhangeR|r" },
	{ type = "separator" },
	{ type = "title", text = "|cffffa500Cataclysm Version|r" },
	{ type = "title", text = "|cff0082FFProfile version 0.0.3|r" },
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
	{ type = "entry", text = ni.spell.icon(30823, 22, 22).." Shamanistic Rage (|cff0082FFMP|r)", tooltip = "Use spell when player |cff0082FFMP|r < %.", enabled = true, value = 35, min = 15, max = 65, step = 1, width = 40, key = "rage" },			
	{ type = "separator" },
	{ type = "title", text = "|cffFFFF00Important Settings|r" },
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(22888, 22, 22).." Boss Detect", tooltip = "When |cff00D700ENABLED|r - Auto detect Bosses.\nWhen |cffFF0D00DISABLED|r - use CD bottom for Spells.", enabled = true, key = "detect" },	
	{ type = "entry", text = ni.spell.icon(6603, 22, 22).." |cffffa500Auto Target|r", tooltip = "Auto Target and Auto Attack nerest targets.", enabled = true, key = "AutoAttack" },	
	{ type = "entry", text = ni.spell.icon(2382, 22, 22).." |cffffa500Debug Printing|r", tooltip = "Enable for debug if you have problems.\n\nUse the macro |cff00D700/ppause|r to pause CR.\n\nThe value in the seconds field for which the CR will stop.", value = 1.5, min = 1, max = 6, step = 0.1, width = 40, enabled = false, key = "Debug" },
	{ type = "page", number = 2, text = "|cffEE4000Rotation Settings #1|r" },
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(57994, 22, 22).." Auto Interrupt", tooltip = "Auto check and interrupt all interruptible spells.", enabled = true, key = "autointerrupt" },	
	{ type = "entry", text = ni.spell.icon(370, 22, 22).." Purge", tooltip = "Purge proper buff from enemie.\n\nThe numbers indicate the interval in sec.\nat which the ability will be recast.", value = 2.5, min = 0.1, max = 10, step = 0.1, width = 40, enabled = true, key = "purge" },	
	{ type = "entry", text = ni.spell.icon(76780, 22, 22).." Bind Elemental (Auto Use)", tooltip = "Auto check and use spell on proper enemies.", enabled = false, key = "bindelem" },
	{ type = "entry", text = ni.spell.icon(51514, 22, 22).." Auto Control (Allys)", tooltip = "Auto check and control member if he mindcontrolled or etc.", enabled = true, key = "control" },	
	{ type = "separator" },
	{ type = "title", text = "|cffFFFF00Bursts|r" },
	{ type = "separator" },
	{ type = "entry", text = ni.player.itemicon(40211, 22, 22).." Using Potions", tooltip = "Enabling the use of potions.\n\nTo work, enter the ID of the potion.\n\nUsing: \n|cff00D700• Work only if Boss Detect enabled\nor activated manual CD mode.|r\n• You can also use the macro |cff00D700/usepot.|r", enabled = false, value = 0, min = 0, width = 60, key = "usePots" },	
	{ type = "entry", text = ni.spell.icon(51533, 22, 22).." Feral Spirit", tooltip = "Add spell in CR.\n\n|cff00D700Work only if Boss Detect enabled\nor activated manual CD mode|r.", enabled = true, key = "feral" },	
	{ type = "page", number = 3, text = "|cffEE4000Rotation Settings #2|r" },
	{ type = "separator" },	
	{ type = "title", text = "|cffFFFF00AoE Settings|r" },
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(421, 22, 22).." Chain Lightning", tooltip = "Enable spell for auto AoE.\n\nThe field indicates the number of enemies >=\nthe given value in the field.", enabled = true, value = 1, min = 1, max = 4, step = 1, width = 40, key = "chain" },
	{ type = "entry", text = "Use Chanin Always", tooltip = "Always use the spell, regardless\nof number of enemies.", enabled = false, key = "chainAlways" },	
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(1535, 22, 22).." Fire Nova (AoE)", tooltip = "When |cff00D700ENABLED|r automatically changes rotation\ndepending on the enemies count.\n\nWhen |cffFF0D00DISABLED|r to use AoE\npress the AoE mode button.\n\nThe field indicates the number of enemies >=\nthe given value in the field.", value = 2, min = 1, max = 6, step = 1, width = 40, enabled = true, key = "firenovaAoE" },	
	{ type = "separator" },
	{ type = "title", text = "Dispel" },
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(52798, 22, 22).." Delay For Dispeling", tooltip = "Delay in seconds or ms before you dispel something.", value = 1.5, min = 0.1, max = 5, step = 0.1, width = 40, key = "DispelDelay" },
	{ type = "entry", text = ni.spell.icon(51886, 22, 22).." Cleanse Spirit", tooltip = "Auto dispel debuffs from player.", enabled = true, key = "toxins" },
	{ type = "entry", text = "Cleanse Spirit (Allys)", tooltip = "Auto dispel debuffs from members.", enabled = false, key = "toxinsmemb" },		
	{ type = "page", number = 4, text = "|cff95f900Totem Settings" },
	{ type = "separator" },
	{ type = "title", text = "Auto Call Totems" },	
	{ type = "dropdown", menu = {
		{ selected = true, value = GetSpellInfo(66842), text = ni.spell.icon(66842, 18, 18).." Call of the Elements" },
		{ selected = false, value = GetSpellInfo(66843), text = ni.spell.icon(66843, 18, 18).." Call of the Ancestors" },
		{ selected = false, value = GetSpellInfo(66844), text = ni.spell.icon(66844, 18, 18).." Call of the Spirits" },
		{ selected = false, value = 0, text = "|cffFF0303No Totems" },	
	}, key = "totempull" },
	{ type = "entry", text = "Call Totems (On Bosses)", tooltip = "When |cff00D700ENABLED|r, use totems only on BOSSES.", enabled = false, key = "totemcallBoss" },	
	{ type = "separator" },	
	{ type = "entry", text = ni.spell.icon(36936, 22, 22).." Totemic Recall", tooltip = "Recall totem when you left combat.", enabled = true, key = "totemrecall" },
	{ type = "separator" },
	{ type = "title", text = "Fire Totem Settings" },	
	{ type = "dropdown", menu = {
		{ selected = false, value = GetSpellInfo(8190), text = ni.spell.icon(8190, 18, 18).." Magma Totem" },
		{ selected = true, value = GetSpellInfo(3599), text = ni.spell.icon(3599, 18, 18).." Searing Totem" },
		{ selected = false, value = 0, text = "|cffFF0303No Fire Totems" },	
	}, key = "FTotem" },
	{ type = "page", number = 5, text = "|cff00C957Defensive Settings|r" },
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(77472, 22, 22).."Greaete Healing Wave (Self)", tooltip = "Use spell when player |cff00D700HP|r < %.\n\n|cffFF0D00Work only in open world!|r", enabled = true, value = 65, min = 15, max = 85, step = 1, width = 40, key = "waves" },
	{ type = "entry", text = "Enable Everywhere", tooltip = "After enable igonore settings and use spell everywhere.", enabled = false, key = "wavesevery" }, 	
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(5730, 22, 22).." Stoneclaw Totem", tooltip = "Use "..ni.spell.icon(5730, 14, 14).."[Stoneclaw Totem] when player |cff00D700HP|r <%\nand have "..ni.player.itemicon(45778, 14, 14).."[Glyph of Stoneclaw Totem].", enabled = true, value = 25, min = 1, max = 100, step = 1, width = 40, key = "stoneclaw" },
	{ type = "entry", text = ni.spell.icon(30823, 22, 22).." Shamanistic Rage", tooltip = "Use spell when player |cff00D700HP|r < %.", enabled = true, value = 40, min = 15, max = 100, step = 1, width = 40, key = "rageSave" },		
	{ type = "separator" },
	{ type = "entry", text = ni.player.itemicon(5512, 22, 22).." Healthstone", tooltip = "Use Warlock Healthstone (if you have) when player |cff00D700HP|r < %.", enabled = true, value = 35, min = 25, max = 65, step = 1, width = 40, key = "healthstoneuse" },	
	{ type = "entry", text = ni.player.itemicon(57191, 22, 22).." Heal Potion", tooltip = "Use Heal Potions (if you have) when player |cff00D700HP|r < %.",  enabled = true, value = 30, min = 20, max = 60, step = 1, width = 40, key = "healpotionuse" },
	{ type = "entry", text = ni.player.itemicon(57192, 22, 22).." Mana Potion", tooltip = "Use Mana Potions (if you have) when player |cff0082FFMP|r < %.", enabled = true, value = 25, min = 15, max = 65, step = 1, width = 40, key = "manapotionuse" },
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
local ZoneText = GetZoneText()
local InstanceName, InstanceType = GetInstanceInfo();
-- Local functions for profile --
--------- Misc ---------
local function PlayerInDungeon()
	return InstanceType == "party";
end;
local function PlayerInRaid()
	return InstanceType == "raid";
end;
local function PlayerZoneText()
	return ZoneText;
end;
local time_ZONE_CHANGED = GetTime()
ni.listener:add("zone_changed", {"CHALLENGE_MODE_START", "ZONE_CHANGED", "ZONE_CHANGED_NEW_AREA", "ZONE_CHANGED_INDOORS", "PLAYER_ENTERING_WORLD"}, function()
	ni.C_Timer.After(1, function()
		local xtime = GetTime()
		if  xtime-time_ZONE_CHANGED > 1 then
			time_ZONE_CHANGED = xtime;
			InstanceName, InstanceType = GetInstanceInfo()
			ZoneText = GetZoneText()
		end
	end)
end)
local function TTDChecker(t, valueTime, valueTTD, hp)
	valueTime = valueTime or 0
	valueTTD = valueTTD or 0
	hp = hp or 0
	if ni.vars.combat.time ~= 0 
	and GetTime() - ni.vars.combat.time > valueTime 
	and ni.unit.ttd(t) > valueTTD
	and ni.unit.hp(t) >= hp then
		return true;
	end
	return false;
end;
local function BossOrCD(t, valueTime, valueTTD, hp, enabled)
	if ni.vars.combat.cd then
		return true;
	end;
	local isboss = false;
	if enabled then
		isboss = ni.unit.isboss(t);
		if not isboss then
			return false;
		end
	end
	if TTDChecker(t, valueTime, valueTTD, hp) then
		if enabled then
			if isboss then
				return true;
			end
			return true;
		end
	end
	return false;
end;
--------- Spell Functions ---------
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
local function UsableStun(spellid, stutter)
	if tonumber(spellid) == nil then
		spellid = ni.spell.id(spellid)
	end
	local result = false;
	if spellid == nil or spellid == 0 then
		return false;
	end
	local spellName = GetSpellInfo(spellid);
	if not ni.player.isstunned()
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
--------- Usefull Functions ---------
local function CombatStart(value)
    if ni.vars.combat.time ~= 0
	and GetTime() - ni.vars.combat.time > value then
        return true;
    end
	return false;    
end;
local function CombatEnded(value)
    if ni.vars.combat.time == 0 
	and GetTime() - ni.vars.combat.ended > value then
        return true;
    end
	return false;
end;
-- Spells Table --
local spells = {
StormStrike = GetSpellInfo(17364),
PrimalStrike = GetSpellInfo(73899),
LavaLash = GetSpellInfo(60103),
UnleashElements = GetSpellInfo(73680),
EarthShock = GetSpellInfo(8042),
FlameShock = GetSpellInfo(8050),
LightningBolt = GetSpellInfo(403),
ChainLightning = GetSpellInfo(421),
WindShear = GetSpellInfo(57994),
LightningShield = GetSpellInfo(324),
WaterShield = GetSpellInfo(52127),
FeralSpirit = GetSpellInfo(51533),
PurgeSpell = GetSpellInfo(370),
CleanseSpirit = GetSpellInfo(51886),
FireNova = GetSpellInfo(1535),
TotemicRecall = GetSpellInfo(36936),
StoneclawTotem = GetSpellInfo(5730),
ShamanisticRage = GetSpellInfo(30823),
Hex = GetSpellInfo(51514),
BindElemental = GetSpellInfo(76780),
GreaterHealingWave = GetSpellInfo(77472),
	-- Procs --
Maelstorm = GetSpellInfo(53817),
};
-- "Cache" Table -- 
local cache = {
IsMoving = false,
PlayerCombat = false,
UnitAttackable = false,
PlayerControled = false,
ActiveEnemies = 0,
FlameShock = false;
FlameShockT = false;
fireTotem = false;
earthTotem = false;
waterTotem = false;
airTotem = false;
NoMaelstrom = false;
Dungeon = false;
HasFireNovaGlyph = false;
GlyphOfStoneclawTotem = false,
};
-- Update Cache Events --
local update_cache = {
    "PLAYER_ENTERING_WORLD",
    "GLYPH_UPDATED",
    "ACTIVE_TALENT_GROUP_CHANGED",
    "PLAYER_EQUIPMENT_CHANGED",
    "PLAYER_TALENT_UPDATE",
    "SPELLS_CHANGED",
};
-- Load GUI / Starting Cache -- 
local function OnLoad()
    local last_update_cache_time = 0;
    ni.listener:add("update_cache", update_cache, function()
        local xtime = GetTime()
        if xtime - last_update_cache_time > 1 then
            ni.C_Timer.After(1, function()
				cache.Dungeon = (PlayerInRaid() or PlayerInDungeon()) or false;
				cache.HasFireNovaGlyph = ni.player.hasglyph(55450) or false;
				cache.GlyphOfStoneclawTotem = ni.player.hasglyph(63298) or false;
                last_update_cache_time = xtime + 1;
            end)
        end
    end)
	ni.listener:call("PLAYER_ENTERING_WORLD");
	ni.GUI.AddFrame("Cata_Enhancement_DarhangeR", items);
end;
-- Unload GUI / Wipe Cache -- 
local function OnUnLoad()
	ni.listener:remove("update_cache", update_cache);
	ni.GUI.DestroyFrame("Cata_Enhancement_DarhangeR");
end;
-- Rotation Priorities --
local AoEQueu = {
	"Cache",
	"Get Totems ID",
	"Universal Pause",
	"AutoTarget",
	"Purge",
	"Enchant Weapon",
	"Lightning Shield",
	"Totemic Recall",
	"Healthstone (Use)",
	"Heal Potions (Use)",
	"Mana Potions (Use)",
	"Shamanistic Rage",
	"Stoneclaw Totem",
	"Use Pots",
	"Combat specific Pause",
	"Use Castable Items",
	"Racial Stuff",
	"Wind Shear (Interrupt)",
	"Pull Totems (Auto)",
	"Fire Totems",
	"Put Totems Back",
	"Totemic Recall (Fight)",
	"Control (Ally)",
	"Bind Elemental (Auto Use)",
	"Greater Healing Wave (Self)",
	"Feral Spirit",
	"Unleash Elements",
	"Flame Shock",
	"Lava Lash",
	"Fire Nova (AoE)",
	"Chain Lightning/Bolt",
	"Stormstrike",
	"Purge",
	"Cure Toxins (Self)",
	"Cure Toxins (Ally)",
	"Earth Shock",
};
local SoloQueu = {
	"Cache",
	"Get Totems ID",
	"Universal Pause",
	"AutoTarget",
	"Purge",
	"Enchant Weapon",
	"Lightning Shield",
	"Totemic Recall",
	"Healthstone (Use)",
	"Heal Potions (Use)",
	"Mana Potions (Use)",
	"Shamanistic Rage",
	"Stoneclaw Totem",
	"Use Pots",
	"Combat specific Pause",
	"Use Castable Items",
	"Racial Stuff",
	"Wind Shear (Interrupt)",
	"Pull Totems (Auto)",
	"Fire Totems",
	"Put Totems Back",
	"Totemic Recall (Fight)",
	"Control (Ally)",
	"Bind Elemental (Auto Use)",
	"Greater Healing Wave (Self)",
	"Feral Spirit",
	"Chain Lightning/Bolt",
	"Unleash Elements",
	"Flame Shock",
	"Lava Lash",
	"Stormstrike",
	"Purge",
	"Cure Toxins (Self)",
	"Cure Toxins (Ally)",
	"Earth Shock",
};
-- Abilities Code Table --
local abilities = {
-----------------------------------
	["Get Totems ID"] = function()
		local CallTotem = GetSetting("totempull");
		if CallTotem == 0 then
			return false;
		end
		if CallTotem == GetSpellInfo(66842) then
			fto = 133
			eto = 134
			wto = 135
			ato = 136
		elseif CallTotem == GetSpellInfo(66843) then
			fto = 137
			eto = 138
			wto = 139
			ato = 140
		elseif CallTotem == GetSpellInfo(66844) then
			fto = 141
			eto = 142
			wto = 143
			ato = 144
		end
	end,
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
		cache.ActiveEnemies = #ni.unit.enemiesinrange("target", 8) or 0;
		cache.fireTotem = select(2, GetTotemInfo(1)) or false;
		cache.earthTotem = select(2, GetTotemInfo(2)) or false;
		cache.waterTotem = select(2, GetTotemInfo(3)) or false;
		cache.airTotem = select(2, GetTotemInfo(4)) or false;
		cache.NoMaelstrom = ni.player.buffstacks(spells.Maelstorm) < 5 or false;
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
			LastReset = GetTime();
		end
		SLASH_USEPOT1 = "/usepot"
		SlashCmdList.USEPOT = function()
			UsePots = true;
		end;		
	end,
-----------------------------------
	["Universal Pause"] = function()
		local value = GetSetting("Debug");
    	SLASH_PPAUSE1 = "/ppause"
		SlashCmdList.PPAUSE = function()
			ni.spell.stopcasting()
			ni.rotation.delay(value);
		end	
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
						ni.spell.cast(GetSpellInfo(6603), tar)
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
		if enabled
		or ni.player.buff(spells.LightningShield)
		or not UsableSilence(spells.LightningShield) then
			return false;
		end
		local value = GetSetting("lshield");
		if ni.player.power(0) >= value then
			ni.spell.cast(spells.LightningShield)
			return true;
		end
	end,
-----------------------------------
	["Water Shield"] = function()
		local _, enabled = GetSetting("dishield");	
		if enabled
		or ni.player.buff(spells.WaterShield)
		or not UsableSilence(spells.WaterShield) then
			return false;
		end
		local value = GetSetting("wshield");	
		if ni.player.power(0) <= value then
			ni.spell.cast(spells.WaterShield)
			return true;
		end
	end,
-----------------------------------
	["Healthstone (Use)"] = function()
		local hpVal, enabled = GetSetting("healthstoneuse");
		if not enabled then
			return false;
		end
		if not cache.PlayerControled
		and cache.PlayerCombat
		and ni.player.hp() <= hpVal then
			if ni.player.itemready(5512) then
				ni.player.useitem(5512)
				return true;
			end
		end
	end,
-----------------------------------	
	["Heal Potions (Use)"] = function()
		local hpVal, enabled = GetSetting("healpotionuse");
		if not enabled then
			return false;
		end
		local hpot = { 57191, 43569, 40087, 41166, 33447, 39671, 22829, 33934, 28100, 13446, 3928, 1710, 929, 4596, 858, 118 };
		if not cache.PlayerControled
		and cache.PlayerCombat
		and ni.player.hp() <= hpVal then
			for i = 1, #hpot do
			local a = hpot[i];
				if ni.player.itemready(a) then
					ni.player.useitem(a)
					return true;
				end
			end
		end
	end,
-----------------------------------
	["Mana Potions (Use)"] = function()
		local mpVal, enabled = GetSetting("manapotionuse");
		if not enabled then
			return false;
		end
		local mpot = { 43570, 40087, 42545, 33448, 40067, 22832, 33935, 28101, 13444, 13443, 6149, 3827, 3385, 2455 };
		if not cache.PlayerControled
		and cache.PlayerCombat
		and ni.player.power(0) <= mpVal then
			for i = 1, #mpot do
			local a = mpot;
				if ni.player.itemready(a) then
					ni.player.useitem(a)
					return true;
				end
			end
		end
	end,
-----------------------------------
	["Use Pots"] = function()
		if cache.PlayerControled then
			return false;
		end
		local PotID, PotEnabled = GetSetting("usePots");
		local _, enabled = GetSetting("detect");
		if PotEnabled then
			if PotID ~= 0 then
				local PotSpell = GetItemSpell(PotID);
				if ni.player.itemready(PotID)
				and not ni.player.buff(PotSpell)
				and (BossOrCD("target", 1, 5, 1, enabled) or UsePots) then
					ni.player.useitem(PotID)
					UsePots = false;
					return true;
				end
			end
		end
	end,
-----------------------------------
	["Combat specific Pause"] = function()
		if not UnitCanAttack("player", "target")
		or (not ni.unit.incombat("target")
		and not ni.unit.isdummy("target")
		and not ni.unit.isplayer("target")) then
			return true;
		end
	end,
-----------------------------------	
	["Racial Stuff"] = function()
		local _, enabled = GetSetting("detect");
		local hBuffs = {26297, 33697};
		if ni.player.hp() <= 25 then
			if UsableStun(20524)
			and not ni.player.buff(20524) then
				ni.spell.cast(20524)
				return true;
			end
			if UsableStun(59547)
			and not ni.player.buff(59547) then
				ni.spell.cast(59547)
				return true;
			end
		end
		if UsableStun(69041)
		and ni.spell.valid("target", 69041, true, true) then
			ni.spell.cast(69041, "target")
			return true;
		end
		if BossOrCD("target", 5, 5, 1, enabled)
		and cache.GetRange then
			for i = 1, #hBuffs do
				local b = hBuffs[i];
				if UsableStun(b) then
					ni.spell.cast(b)
					return true;
				end
			end
		end
	end,	
-----------------------------------		
	["Use Castable Items"] = function()
		if cache.PlayerControled
		or not cache.GetRange then
			return false;
		end
		local _, enabled = GetSetting("detect");
		if BossOrCD("target", 5, 5, 1, enabled) then
			local trinket_slots = { 13, 14 };
			for _, slot_id in ipairs(trinket_slots) do
				local trinket_id = GetInventoryItemID("player", slot_id)
				if trinket_id 
				and ni.player.slotusable(slot_id) then
					ni.player.useinventoryitem(slot_id)
					return true;
				end
			end
			if KnowEngineer then
				if ni.player.slotusable(10) then
					ni.player.useinventoryitem(10, "target")
					return true;
				end		
			end
		end
	end,	
-----------------------------------	
	["Feral Spirit"] = function()
		local _, sum = GetSetting("feral");
		if not sum 
		or cache.HavePet then
			return false;
		end
		local _, enabled = GetSetting("detect");
		if UsableSilence(spells.FeralSpirit) 
		and BossOrCD("target", 5, 5, 1, enabled)
		and cache.GetRange then
			ni.spell.cast(spells.FeralSpirit)
			return true;
		end
	end,
-----------------------------------	
	["Wind Shear (Interrupt)"] = function()
		local _, enabled = GetSetting("autointerrupt");
		if not enabled then
			return false;
		end
		if UsableSilence(spells.WindShear) then
		local WindShearRange = select(9, GetSpellInfo(spells.WindShear));
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
	["Shamanistic Rage"] = function()
		local rageHP, hpEnabled = GetSetting("rageSave");
		local rageMP, mpEnabled =  GetSetting("rage");		
		if not cache.PlayerCombat
		or not ni.spell.available(spells.ShamanisticRage) then
			return false;
		end
		if hpEnabled
		and ni.player.hp() <= rageHP then
			ni.spell.cast(spells.ShamanisticRage)
			return true;
		end
		if mpEnabled
		and ni.player.power(0) <= rageMP
		and cache.GetRange then
			ni.spell.cast(spells.ShamanisticRage)
			return true;
		end
	end,
-----------------------------------	
	["Pull Totems (Auto)"] = function()
		local CallTotem = GetSetting("totempull");
		if CallTotem == 0 then
			return false;
		end
		if cache.earthTotem ~= "" and cache.fireTotem ~= ""
		and cache.waterTotem ~= "" and cache.airTotem ~= "" then
			return false;
		end
		local _, enabled = GetSetting("totemcallBoss");
		if enabled
		and not ni.unit.isboss("target") then
			return false;
		end
		if UsableSilence(CallTotem)
		and cache.GetRange
		and (cache.earthTotem == "" and cache.fireTotem == ""
		and cache.waterTotem == "" and cache.airTotem == ""
		or (cache.earthTotem ~= "" and cache.fireTotem ~= ""
		and cache.waterTotem ~= "" and cache.airTotem ~= "")) then
			ni.spell.cast(CallTotem)
			return true;
		end
	end,
-----------------------------------	
	["Put Totems Back"] = function()
		local CallTotem = GetSetting("totempull");	
		if CallTotem == 0 then
			return false;
		end
		if cache.earthTotem ~= "" and cache.fireTotem ~= "" 
		and cache.waterTotem ~= "" and cache.airTotem ~= "" then
			return false;
		end
		local _, enabled = GetSetting("totemcallBoss");
		if enabled
		and not ni.unit.isboss("target") then
			return false;
		end
		local _, EarthTotem = GetActionInfo(eto);
		local _, WaterTotem = GetActionInfo(wto);
		local _, AirTotem = GetActionInfo(ato);
		if CombatStart(4) then
			if cache.earthTotem == "" then
				if UsableSilence(EarthTotem) then
					ni.spell.cast(EarthTotem)
					return true;
				end
			end
			if cache.waterTotem == "" then
				if UsableSilence(WaterTotem) then
					ni.spell.cast(WaterTotem)
					return true;
				end
			end
			if cache.airTotem == "" then
				if UsableSilence(AirTotem) then
					ni.spell.cast(AirTotem)
					return true;
				end
			end
		end
	end,
-----------------------------------
	["Totemic Recall"] = function()	
		local _, enabled = GetSetting("totemrecall");
		if not enabled then
			return false;
		end
		if cache.earthTotem == "" and cache.fireTotem == ""
		and cache.waterTotem == "" and cache.airTotem == ""
		or cache.PlayerCombat then
			return false;
		end
		if ni.vars.combat.counter > 0
		and CombatEnded(3)
		and UsableSilence(spells.TotemicRecall) then
			if (cache.earthTotem ~= "" or cache.fireTotem ~= ""
			or cache.waterTotem ~= "" or cache.airTotem ~= "")
			or (GetTotemTimeLeft(1) < 30
			and GetTotemTimeLeft(2) < 30
			and GetTotemTimeLeft(3) < 30
			and GetTotemTimeLeft(4) < 30) then
				ni.spell.cast(spells.TotemicRecall)
				ni.vars.combat.counter = 0;
				return true;
			end
		end
	end,
-----------------------------------
	["Totemic Recall (Fight)"] = function()
		local _, enabled = GetSetting("totemrecall");
		if not enabled then
			return false;
		end
		if cache.earthTotem == "" and cache.fireTotem == ""
		and cache.waterTotem == "" and cache.airTotem == "" then
			return false;
		end
		if UsableSilence(spells.TotemicRecall) then
			for a = 1, 4 do
			for b = 1, 4 do
				local totemN = "totem"..a
				local totemN2 = "totem"..b
				local totem_distance = ni.unit.distance(totemN, "target");	
				local totem2_player_distance = ni.player.distance(totemN2);
					if (cache.fireTotem ~= ""
					and UnitName(totemN) == cache.fireTotem
					and totem_distance and totem_distance > 12)
					and (cache.earthTotem ~= ""
					and UnitName(totemN2) == cache.earthTotem
					and totem2_player_distance and totem2_player_distance > 30)
					or (cache.waterTotem ~= "" and cache.airTotem ~= ""
					and (GetTotemTimeLeft(2) < 30
					and GetTotemTimeLeft(3) < 30
					and GetTotemTimeLeft(4) < 30)) then
						ni.spell.cast(spells.TotemicRecall)
						return true;
					end
				end
			end
		end
	end,
-----------------------------------	
	["Fire Totems"] = function()
		local FTotem = GetSetting("FTotem");
		if FTotem == 0 then
			return false;
		end
		if UsableSilence(FTotem)
		and cache.GetRange then
			for i = 1, 4 do
			local totemN = "totem"..i
			local totem_distance = ni.unit.distance(totemN, "target");
				if (cache.fireTotem == ""
				or (cache.fireTotem ~= "" and UnitName(totemN) == cache.fireTotem
				and totem_distance and totem_distance > 10)) then
					ni.spell.cast(FTotem)
					return true;
				end
			end
		end
	end,
-----------------------------------
	["Fire Nova (AoE)"] = function()	
		if not ni.spell.valid("target", spells.FlameShock, true, true) then
			return false;
		end
		local dist, UseNova = nil, false;
		if cache.HasFireNovaGlyph then
			dist = 14;
		else
			dist = 9;
		end
		local count, enabled = GetSetting("firenovaAoE");
		local EnemiesCount = ni.unit.enemiesinrange("target", dist);
		for i = 1, #EnemiesCount do
		local tar = EnemiesCount[i].guid;
			if ni.unit.debuff(tar, spells.FlameShock, "player") then
				UseNova = true;
				break;
			end
		end
		if (UseNova 
		or (cache.FlameShock and cache.FlameShockT > 2))
		and UsableSilence(spells.FireNova) then
			ni.spell.cast(spells.FireNova)
			return true;
		end
	end,
-----------------------------------	
	["Unleash Elements"] = function()
		if not cache.NoMaelstrom then
			return false;
		end
		if UsableStun(spells.UnleashElements) 
		and ni.spell.valid("target", spells.UnleashElements, false, true) then
			ni.spell.cast(spells.UnleashElements, "target")
			return true;
		end
	end,
-----------------------------------	
	["Stormstrike"] = function()
		if not cache.NoMaelstrom
		or not cache.GetRange then
			return false;
		end
		if UsableStun(spells.StormStrike) then
			ni.spell.cast(spells.StormStrike, "target")
			return true;
		end
	end,
-----------------------------------
	["Lava Lash"] = function()
		if not cache.NoMaelstrom
		or not cache.GetRange then
			return false;
		end	
		if UsableStun(spells.LavaLash) then
			ni.spell.cast(spells.LavaLash, "target")
			return true;
		end
	end,
-----------------------------------
	["Flame Shock"] = function()
		if not UsableSilence(spells.FlameShock) then
			return false;
		end
		if (ni.player.buff(73683) or not ni.player.buff(73683)) then
			if (not cache.FlameShock or cache.FlameShockT < 2)
			and ni.spell.valid("target", spells.FlameShock, true, true) then
				ni.spell.cast(spells.FlameShock, "target")
				return true;
			end
		end
	end,
-----------------------------------
	["Earth Shock"] = function()
		if not UsableSilence(spells.EarthShock) then
			return false;
		end
		if (cache.FlameShock and cache.FlameShockT > 2)
		and ni.spell.valid("target", spells.EarthShock, true, true) then
			ni.spell.cast(spells.EarthShock, "target")
			return true;
		end
	end,
-----------------------------------
	["Chain Lightning/Bolt"] = function()
		if cache.NoMaelstrom then
			return false;
		end
		local ChainCount, ChainEnabled = GetSetting("chain");
		local _, ChainAlways = GetSetting("chainAlways");
		if ni.spell.isinstant(spells.LightningBolt)
		and ni.spell.valid("target", spells.LightningBolt, true, true) 
		or (not cache.GetRange 
		and ni.spell.valid("target", spells.LightningBolt, true, true)) then
			if (not UsableSilence(spells.ChainLightning) or not ChainEnabled) then
				if UsableSilence(spells.LightningBolt) then 
					ni.spell.cast(spells.LightningBolt, "target")
					return true;
				end
			end
			if ChainEnabled then	
				if cache.ActiveEnemies < 1 then
					if UsableSilence(spells.LightningBolt) then 
						ni.spell.cast(spells.LightningBolt, "target")
						return true;
					end
				end	
				if (cache.ActiveEnemies >= ChainCount or ChainAlways) then
					if UsableSilence(spells.ChainLightning) then 
						ni.spell.cast(spells.ChainLightning, "target")
						return true;
					end
				end
			end
		end
	end,	
-----------------------------------
	["Purge"] = function()
		local timer, enabled = GetSetting("purge");
		if not enabled then
			return false;
		end
		if UsableSilence(spells.PurgeSpell) then
			if ni.unit.bufftype("target", "Magic")
			and (GetTime() - LastPurge >= timer)
			and ni.spell.valid("target", spells.PurgeSpell, false, true) then
				ni.spell.cast(spells.PurgeSpell, "target")
				LastPurge = GetTime();
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
				and (GetTime() - LastCure >= val) then
					print("Ворк на мне")
					ni.spell.cast(spells.CureToxins, "player")
					LastCure = GetTime();
					return true;
				end
			end
		end
	end,
-----------------------------------
	["Cure Toxins (Ally)"] = function()
		local _, cureAlly = GetSetting("toxinsmemb");
		if not cureAlly then
			return false;
		end
		local val = GetSetting("DispelDelay");	
		if UsableSilence(spells.CureToxins) then
			for i = 1, #ni.members.sort() do
			local ally = ni.members[i];
				if ally:debufftype("Curse")
				and (GetTime() - LastCure >= val)
				and ally:valid(spells.CureToxins, false, true) then
					print("Ворк на союзниках")
					ni.spell.cast(spells.CureToxins, ally.unit)
					LastCure = GetTime()
					return true;
				end
			end
		end
	end,
-----------------------------------
	["Greater Healing Wave (Self)"] = function()
		local hpVal, waveEnabled = GetSetting("waves");
		local _, always = GetSetting("wavesevery");
		if not waveEnabled then
			return false;
		end
		if (not cache.Dungeon or always) then
			if not cache.NoMaelstrom 
			and ni.player.hp() <= hpVal
			and ni.spell.isinstant(spells.GreaterHealingWave) then
				if UsableSilence(spells.GreaterHealingWave) then
					ni.spell.cast(spells.GreaterHealingWave, "player")
					return true;
				end
			end
		end
	end,
-----------------------------------
	["Stoneclaw Totem"] = function()
		if not cache.GlyphOfStoneclawTotem then
			return false;
		end
		local valHP, enabled = GetSetting("stoneclaw");
		if not enabled
		or not cache.PlayerCombat then
			return false;
		end
		if ni.player.hp() <= valHP
		and UsableStun(spells.StoneclawTotem) then 
			ni.spell.cast(spells.StoneclawTotem)
			return true;
		end
	end,
-----------------------------------
    ["Bind Elemental (Auto Use)"] = function()
		local _, bind = GetSetting("bindelem");
        if not bind
		or not UsableSilence(spells.BindElemental)
		or cache.IsMoving then
			return false;
		end
		local BindElemRange = select(9, GetSpellInfo(76780));
		local enemies = ni.player.enemiesinrange(BindElemRange);
		local NotUseBind = false
			for i = 1, #enemies do
			local tar = enemies[i].guid; 
				if ni.unit.creaturetype(tar) == 4
				and (ni.unit.isboss(tar)
				or ni.unit.debuff(tar, spells.BindElemental)
				or ni.drtracker.get(tar, "Disorients") == 0) then
					NotUseBind = true;
					break;
				end
			if not NotUseBind then
				if ni.drtracker.get(tar, "Disorients") >= 0.5
				and ni.spell.valid(tar, spells.BindElemental, false, true) then
					ni.spell.cast(spells.BindElemental, tar)
					return true;
				end
			end
		end
    end,
-----------------------------------
	["Control (Ally)"] = function()
		local _, control = GetSetting("control");
		if not control
		or cache.IsMoving then
			return false;
		end
		if ni.spell.isinstant(spells.Hex)
		and UsableSilence(spells.Hex) then
			for i = 1, #ni.members do
			local ally = ni.members[i];
				if ally:unfriendly()
				and not ally:buffs("768||5487", "EXACT")then
					if ni.drtracker.get(ally.unit, "Disorients") >= 0.5				
					and ally:valid(spells.Hex, false, true) then
						ni.spell.cast(spells.Hex, ally.unit)
						return true;
					end
				end
			end
		end
	end,
};
local function queue()
	local dist = nil;
	if cache.HasFireNovaGlyph then
		dist = 14;
	else
		dist = 9;
	end
	local count, enabled = GetSetting("firenovaAoE");
	local EnemiesCount = ni.unit.enemiesinrange("target", dist);
	if (cache.PlayerCombat and UnitIsEnemy("player", "target"))
	and ni.vars.combat.aoe or (enabled and #EnemiesCount >= count) then
		return AoEQueu;
	end
	return SoloQueu;
end;
	ni.bootstrap.profile("Cata_Enhancement_DarhangeR", queue, abilities, OnLoad, OnUnLoad);
else -- Debug with comparing WoW Build / Player Level
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