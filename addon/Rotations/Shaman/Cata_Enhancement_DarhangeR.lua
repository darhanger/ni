local build = select(4, GetBuildInfo());
local cata = build == 40300 or false;
if cata then
local AntiAFKTime, LastReset, LastPurge = 0, 0, 0;
local fto, eto, wto, ato = nil, nil, nil, nil;
local enemies = {};
local items = {
	settingsfile = "EnchShammy_Free_Cata.json",
	{ type = "title", text = "Cata Enchantment Shaman by |c0000CED1DarhangeR|r" },
	{ type = "separator" },
	{ type = "title", text = "|cff0082FFProfile version 0.0.2|r" },
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
	{ type = "title", text = "|cffFFFF00AoE Settings|r" },
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(1535, 22, 22).." Fire Nova (AoE)", tooltip = "When |cff00D700ENABLED|r automatically changes rotation\ndepending on the enemies count.\n\nWhen |cffFF0D00DISABLED|r to use AoE\npress the AoE mode button.\n\nThe field indicates the number of enemies >=\nthe given value in the field.", value = 2, min = 1, max = 6, step = 1, width = 40, enabled = true, key = "firenovaAoE" },	
	{ type = "separator" },
	{ type = "title", text = "Dispel" },
	{ type = "separator" },
	{ type = "entry", text = ni.spell.icon(52798, 22, 22).." Delay For Dispeling", tooltip = "Delay in seconds or ms before you dispel something.", value = 1.5, min = 0.1, max = 5, step = 0.1, width = 40, key = "DispelDelay" },
	{ type = "entry", text = ni.spell.icon(51886, 22, 22).." Cleanse Spirit", tooltip = "Auto dispel debuffs from player.", enabled = true, key = "toxins" },
	{ type = "entry", text = "Cleanse Spirit (Allys)", tooltip = "Auto dispel debuffs from members.", enabled = false, key = "toxinsmemb" },		
	{ type = "page", number = 3, text = "|cff95f900Totem Settings" },
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
	{ type = "page", number = 4, text = "|cff00C957Defensive Settings|r" },
	{ type = "separator" },
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
-- Load GUI -- 
local function OnLoad()
	ni.GUI.AddFrame("Cata_Enhancement_DarhangeR", items);
end;
-- Unload GUI -- 
local function OnUnLoad()  
	ni.GUI.DestroyFrame("Cata_Enhancement_DarhangeR");
end;
-- Local functions for profile -- 
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
EarthShock = GetSpellInfo(8042),
FlameShock = GetSpellInfo(8050),
WindShear = GetSpellInfo(57994),
LightningShield = GetSpellInfo(324),
WaterShield = GetSpellInfo(52127),
LavaLash = GetSpellInfo(60103),
PurgeSpell = GetSpellInfo(370),
CleanseSpirit = GetSpellInfo(51886),
FireNova = GetSpellInfo(1535),
TotemicRecall = GetSpellInfo(36936),
};
-- "Cache" Table -- 
local cache = {
IsMoving = false,
PlayerCombat = false,
UnitAttackable = false,
PlayerControled = false,
FlameShock = false;
FlameShockT = false;
fireTotem = false;
earthTotem = false;
waterTotem = false;
airTotem = false;
HasFireNovaGlyph = false;
};
local queue = {
	"Cache",
	"Get Totems ID",
	"Universal Pause",
	"AutoTarget",
	"Purge",
	"Enchant Weapon",
	"Lightning Shield",
	"Totemic Recall",
	"Heal Potions (Use)",
	"Mana Potions (Use)",
	"Combat specific Pause",
	"Wind Shear (Interrupt)",
	"Pull Totems (Auto)",
	"Fire Totems",
	"Put Totems Back",
	"Totemic Recall (Fight)",
	"Fire Nova (AoE)",
	"Storm Strike",
	"Flame Shock",
	"Lava Lash",
	"Purge",
	"Cure Toxins (Self)",
	"Cure Toxins (Ally)",
	"Earth Shock",
};
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
		cache.fireTotem = select(2, GetTotemInfo(1)) or false;
		cache.earthTotem = select(2, GetTotemInfo(2)) or false;
		cache.waterTotem = select(2, GetTotemInfo(3)) or false;
		cache.airTotem = select(2, GetTotemInfo(4)) or false;
		cache.HasFireNovaGlyph = ni.player.hasglyph(55450) or false;
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
	["Combat specific Pause"] = function()
		if not UnitCanAttack("player", "target")
		or (not ni.unit.incombat("target")
		and not ni.unit.isdummy("target")
		and not ni.unit.isplayer("target")) then
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
		local dist = nil;
		if cache.HasFireNovaGlyph then
			dist = 14;
		else
			dist = 9;
		end
		local count, enabled = GetSetting("firenovaAoE");
		local EnemiesCount = #ni.unit.enemiesinrange("target", dist);
		if UsableSilence(spells.FireNova)
		and (cache.FlameShock and cache.FlameShockT > 2) then
			if ni.vars.combat.aoe
			or (enabled and EnemiesCount >= count) then
				ni.spell.cast(spells.FireNova)
				return true;
			end
		end
	end,
-----------------------------------	
	["Storm Strike"] = function()
		if not cache.GetRange then
			return false;
		end
		if UsableSilence(spells.StormStrike) then
			ni.spell.cast(spells.StormStrike, "target")
			return true;
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
				and ni.healing.candispel("player")
				and (GetTime() - LastCure >= val) then
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