local items = {
	settingsfile = "Tapto - Fire Mage PVE.json",
	{ type = "title", text = "Mage - Fire PvE by |c0000CED1Tapto" },
	{ type = "separator" },
	{ type = "title", text = "|cffFFFF00Settings" },
	{ type = "entry", text = "\124T"..GetItemIcon(36799)..":26:26\124t Use Mana Gem < MP%", tooltip = "Use Mana Gem < MP%", enabled = true, value = 70, key = "ManaGem" },
	{ type = "entry", text = "\124T"..select(3, GetSpellInfo(12051))..":26:26\124t Use Evocation < MP%", tooltip = "Use Evocation < MP%", enabled = true, value = 10, key = "Evocation" },
	{ type = "entry", text = "\124T"..select(3, GetSpellInfo(55342))..":26:26\124t Use Mirror Image", tooltip = "Use Mirror Image", enabled = true, key = "MirrorImage" },
	{ type = "entry", text = "\124T"..select(3, GetSpellInfo(11129))..":26:26\124t Use Combustion", tooltip = "Use Combustion", enabled = true, key = "Combustion" },
	{ type = "entry", text = "\124T"..select(3, GetSpellInfo(2948))..":26:26\124t Use Scorch", tooltip = "Use Scorch", enabled = true, key = "Scorch" },
	{ type = "entry", text = "\124T"..select(3, GetSpellInfo(2136))..":26:26\124t Use Fireblast while moving", tooltip = "Use Fireblast", enabled = true, key = "Fireblast" },
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
local spells ={
ArcaneResistance = {id = 20592, name = GetSpellInfo(20592), icon = select(3, GetSpellInfo(20592))},
ArmorSkills = {id = 76276, name = GetSpellInfo(76276), icon = select(3, GetSpellInfo(76276))},
AutoAttack = {id = 6603, name = GetSpellInfo(6603), icon = select(3, GetSpellInfo(6603))},
ColdWeatherFlying = {id = 54197, name = GetSpellInfo(54197), icon = select(3, GetSpellInfo(54197))},
EngineeringSpecialization = {id = 20593, name = GetSpellInfo(20593), icon = select(3, GetSpellInfo(20593))},
EscapeArtist = {id = 20589, name = GetSpellInfo(20589), icon = select(3, GetSpellInfo(20589))},
ExpansiveMind = {id = 20591, name = GetSpellInfo(20591), icon = select(3, GetSpellInfo(20591))},
FlightMastersLicense = {id = 90267, name = GetSpellInfo(90267), icon = select(3, GetSpellInfo(90267))},
Languages = {id = 79740, name = GetSpellInfo(79740), icon = select(3, GetSpellInfo(79740))},
MasterRiding = {id = 90265, name = GetSpellInfo(90265), icon = select(3, GetSpellInfo(90265))},
Mastery = {id = 86473, name = GetSpellInfo(86473), icon = select(3, GetSpellInfo(86473))},
Shoot = {id = 5019, name = GetSpellInfo(5019), icon = select(3, GetSpellInfo(5019))},
ShortbladeSpecialization = {id = 92680, name = GetSpellInfo(92680), icon = select(3, GetSpellInfo(92680))},
WeaponSkills = {id = 76298, name = GetSpellInfo(76298), icon = select(3, GetSpellInfo(76298))},
Wizardry = {id = 89744, name = GetSpellInfo(89744), icon = select(3, GetSpellInfo(89744))},
--Arcane icon = select(2, GetSpellTabInfo(2))
ArcaneBlast = {id = 30451, name = GetSpellInfo(30451), icon = select(3, GetSpellInfo(30451))},
ArcaneBrilliance = {id = 1459, name = GetSpellInfo(1459), icon = select(3, GetSpellInfo(1459))},
ArcaneExplosion = {id = 1449, name = GetSpellInfo(1449), icon = select(3, GetSpellInfo(1449))},
ArcaneMissiles = {id = 5143, name = GetSpellInfo(5143), icon = select(3, GetSpellInfo(5143))},
Blink = {id = 1953, name = GetSpellInfo(1953), icon = select(3, GetSpellInfo(1953))},
ConjureManaGem = {id = 759, name = GetSpellInfo(759), icon = select(3, GetSpellInfo(759))},
ConjureRefreshment = {id = 42955, name = GetSpellInfo(42955), icon = select(3, GetSpellInfo(42955))},
Counterspell = {id = 2139, name = GetSpellInfo(2139), icon = select(3, GetSpellInfo(2139))},
Evocation = {id = 12051, name = GetSpellInfo(12051), icon = select(3, GetSpellInfo(12051))},
Invisibility = {id = 66, name = GetSpellInfo(66), icon = select(3, GetSpellInfo(66))},
MageArmor = {id = 6117, name = GetSpellInfo(6117), icon = select(3, GetSpellInfo(6117))},
MageWard = {id = 543, name = GetSpellInfo(543), icon = select(3, GetSpellInfo(543))},
ManaShield = {id = 1463, name = GetSpellInfo(1463), icon = select(3, GetSpellInfo(1463))},
MirrorImage = {id = 55342, name = GetSpellInfo(55342), icon = select(3, GetSpellInfo(55342))},
Polymorph = {id = 118, name = GetSpellInfo(118), icon = select(3, GetSpellInfo(118))},
PortalStormwind = {id = 10059, name = GetSpellInfo(10059), icon = select(3, GetSpellInfo(10059))},
PortalIronforge = {id = 11416, name = GetSpellInfo(11416), icon = select(3, GetSpellInfo(11416))},
PortalDarnassus = {id = 11419, name = GetSpellInfo(11419), icon = select(3, GetSpellInfo(11419))},
PortalTheramore = {id = 49360, name = GetSpellInfo(49360), icon = select(3, GetSpellInfo(49360))},
PortalShattrath = {id = 33691, name = GetSpellInfo(33691), icon = select(3, GetSpellInfo(33691))},
PortalDalaran = {id = 53142, name = GetSpellInfo(53142), icon = select(3, GetSpellInfo(53142))},
PortalExodar = {id = 32266, name = GetSpellInfo(32266), icon = select(3, GetSpellInfo(32266))},
PortalTolBarad = {id = 88345, name = GetSpellInfo(88345), icon = select(3, GetSpellInfo(88345))},
RemoveCurse = {id = 475, name = GetSpellInfo(475), icon = select(3, GetSpellInfo(475))},
RitualofRefreshment = {id = 43987, name = GetSpellInfo(43987), icon = select(3, GetSpellInfo(43987))},
SlowFall = {id = 130, name = GetSpellInfo(130), icon = select(3, GetSpellInfo(130))},
Spellsteal = {id = 30449, name = GetSpellInfo(30449), icon = select(3, GetSpellInfo(30449))},
TeleportStormwind = {id = 3561, name = GetSpellInfo(3561), icon = select(3, GetSpellInfo(3561))},
TeleportIronforge = {id = 3562, name = GetSpellInfo(3562), icon = select(3, GetSpellInfo(3562))},
TeleportDarnassus = {id = 3565, name = GetSpellInfo(3565), icon = select(3, GetSpellInfo(3565))},
TeleportExodar = {id = 32271, name = GetSpellInfo(32271), icon = select(3, GetSpellInfo(32271))},
TeleportTheramore = {id = 49359, name = GetSpellInfo(49359), icon = select(3, GetSpellInfo(49359))},
TeleportShattrath = {id = 33690, name = GetSpellInfo(33690), icon = select(3, GetSpellInfo(33690))},
TeleportDalaran = {id = 53140, name = GetSpellInfo(53140), icon = select(3, GetSpellInfo(53140))},
TeleportTolBarad = {id = 88342, name = GetSpellInfo(88342), icon = select(3, GetSpellInfo(88342))},
TimeWarp = {id = 80353, name = GetSpellInfo(80353), icon = select(3, GetSpellInfo(80353))},
--Fire icon = select(2, GetSpellTabInfo(3))
BlastWave = {id = 11113, name = GetSpellInfo(11113), icon = select(3, GetSpellInfo(11113))},
Combustion = {id = 11129, name = GetSpellInfo(11129), icon = select(3, GetSpellInfo(11129))},
DragonsBreath = {id = 31661, name = GetSpellInfo(31661), icon = select(3, GetSpellInfo(31661))},
FireBlast = {id = 2136, name = GetSpellInfo(2136), icon = select(3, GetSpellInfo(2136))},
FireSpecialization = {id = 84668, name = GetSpellInfo(84668), icon = select(3, GetSpellInfo(84668))},
Fireball = {id = 133, name = GetSpellInfo(133), icon = select(3, GetSpellInfo(133))},
FlameOrb = {id = 82731, name = GetSpellInfo(82731), icon = select(3, GetSpellInfo(82731))},
Flamestrike = {id = 2120, name = GetSpellInfo(2120), icon = select(3, GetSpellInfo(2120))},
FrostfireBolt = {id = 44614, name = GetSpellInfo(44614), icon = select(3, GetSpellInfo(44614))},
LivingBomb = {id = 44457, name = GetSpellInfo(44457), icon = select(3, GetSpellInfo(44457))},
MoltenArmor = {id = 30482, name = GetSpellInfo(30482), icon = select(3, GetSpellInfo(30482))},
Pyroblast = {id = 11366, name = GetSpellInfo(11366), icon = select(3, GetSpellInfo(11366))},
Scorch = {id = 2948, name = GetSpellInfo(2948), icon = select(3, GetSpellInfo(2948))},
--Frost icon = select(2, GetSpellTabInfo(4))
Blizzard = {id = 10, name = GetSpellInfo(10), icon = select(3, GetSpellInfo(10))},
ConeofCold = {id = 120, name = GetSpellInfo(120), icon = select(3, GetSpellInfo(120))},
FrostArmor = {id = 7302, name = GetSpellInfo(7302), icon = select(3, GetSpellInfo(7302))},
FrostNova = {id = 122, name = GetSpellInfo(122), icon = select(3, GetSpellInfo(122))},
Frostbolt = {id = 116, name = GetSpellInfo(116), icon = select(3, GetSpellInfo(116))},
IceBlock = {id = 45438, name = GetSpellInfo(45438), icon = select(3, GetSpellInfo(45438))},
IceLance = {id = 30455, name = GetSpellInfo(30455), icon = select(3, GetSpellInfo(30455))},
RingofFrost = {id = 82676, name = GetSpellInfo(82676), icon = select(3, GetSpellInfo(82676))},
}
local enemies = {}

local function ActiveEnemies(range)
	table.wipe(enemies)
	enemies = ni.player.enemiesinrange(40)
	for k, v in ipairs(enemies) do
		if ni.player.threat(v.guid) == -1 then
			table.remove(enemies, k)
		end
	end
	return #enemies
end

local function FacingLosCast(spell, tar)
	if ni.player.isfacing(tar, 145) and ni.player.los(tar) and IsSpellInRange(spell, tar) == 1 then
		ni.spell.cast(spell, tar)
		ni.debug.log(spell)
		return true
	end
	return false
end

local function ValidUsable(id, tar)
	if ni.spell.available(id) and ni.spell.valid(tar, id, true, true) then
		return true
	end
	return false
end
local queue = {
    "Molten Armor",
    "IceBlock",
    "Arcane Brilliance",
    "Conjure Mana Gem",
    "Poly Focus",
	"Mana Gem",
    "Pause",
    "Pyroblast",
    "Combustion",
    "Living Bomb",
    "Fire Blastproc",
    -- "Living Bomb AOE",
    "BlastWave",
    "Flame Orb",
    "Flame Strike",
    "SorchMoving",
    "Dragon Breath",
    "Combustion",
    "Scorch",
    "Fireball",
}

local abilities = {
    ["Molten Armor"] = function()
        if ni.player.power() <= 10
        and not ni.unit.ischanneling("player")
		and  ni.spell.available(spells.MageArmor.id)
        and not ni.player.buff(spells.MageArmor.id)
        then
            ni.spell.cast(spells.MageArmor.id)
        else 
            if ni.player.power()> 98
            and ni.spell.available(spells.MoltenArmor.id)
			and not ni.unit.ischanneling("player")
			and not ni.player.buff(spells.MoltenArmor.id)
             then
				ni.spell.cast(spells.MoltenArmor.id)
				return true;
		end
    end
	end,


    ["Arcane Brilliance"] = function()
		if ni.spell.available(spells.ArcaneBrilliance.id) 
			and ni.player.buffremaining(spells.ArcaneBrilliance.id) <= 60 then
				ni.spell.cast(spells.ArcaneBrilliance.id)
				return true;
		end
	end,

	["Conjure Mana Gem"] = function()
		if ni.spell.available(spells.ConjureManaGem.id) 
			and not ni.player.ismoving()
			and not UnitAffectingCombat("player")
			and not ni.player.hasitem(36799) -- Mana Sapphire --
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
                and ni.player.hasitem(36799) -- Mana Sapphire --
                and ni.player.itemcd(36799) < 1 then -- Mana Sapphire --
                    ni.player.useitem(36799) -- Mana Sapphire --
                    return true;
            end
        end,
    ["IceBlock"] = function ()
        if ni.spell.available(spells.IceBlock.id)
        and ni.player.hp("player") <=30
        and UnitAffectingCombat("player")
        then
			ni.spell.cast(spells.IceBlock.id)
		end
    end,
    ["Poly Focus"] = function()
        if ni.unit.exists("focus")
        and ni.unit.debuffremaining("focus", "Polymorph", "player") < 2
        -- and ni.drtracker.get("focus", "Polymorph") > 0
        and ni.spell.valid("focus", "Polymorph", false, true)
        then 
            ni.spell.cast("Polymorph", "focus")
        end
    end,
    ["Pause"] = function()
		if IsMounted()
            or ni.player.buff("Drink") 
            or ni.unit.ischanneling("player")
			or UnitIsDeadOrGhost("player")
			or not UnitExists("target")
			or UnitIsDeadOrGhost("target")
            or not UnitAffectingCombat("player")
			or (UnitExists("target") and not UnitCanAttack("player", "target")) then
			return true
		end
	end,
    ["Pyroblast"] = function()
		if UnitAffectingCombat("player")
			and ni.unit.buff("player", 48108, "player") -- Hot Streak --
			and not ni.unit.ischanneling("player") then
				ni.spell.cast(spells.Pyroblast.name, "target")
				return true;
		end
	end,
	["Living Bomb"] = function()
		if  UnitAffectingCombat("player")
			and ni.unit.debuff("target", spells.LivingBomb.id, "player") == nil -- Living Bomb --
			and not ni.unit.ischanneling("player") 
            then
                ni.spell.cast(spells.LivingBomb.id)
                return true
            end
	end,
    ["BlastWave"] = function()
        if ni.vars.combat.aoe 
        and ni.spell.cd(spells.BlastWave.id)== 0
        and ActiveEnemies() > 2 then
            ni.spell.castat(spells.BlastWave.id,"target")
        end
    end,

    ["Flame Strike"] = function()
        if ni.vars.combat.aoe 
        and ActiveEnemies() > 2 then
            ni.spell.delaycast(spells.Flamestrike.id,"target", 8)
            ni.player.clickat("target")
        end
    end,

["Flame Orb"] = function()
    if ni.spell.cd(spells.FlameOrb.id)== 0
    and ni.player.isfacing("player","target")
    then
        ni.spell.cast(spells.FlameOrb.id)
        return true
    end
    end,

    
	["Combustion"] = function()
        local _, enabled = GetSetting("Combustion")
            if enabled
                and ni.vars.combat.cd
                and UnitAffectingCombat("player")
                and ni.spell.cd(spells.Combustion.id) == 0
                and not ni.unit.ischanneling("player")
                and ni.unit.debuff("target", 92315)
                and ni.unit.debuff("target", 44457)
                and ni.unit.debuff("target", 12654) then
                    ni.spell.stopcasting()
                    ni.spell.cast(26297) --Racial Troll
                    ni.player.runtext("/use 13") -- Activable trinket 
                    ni.player.useitem(58091) --Spell potion 
                    ni.spell.cast(spells.Combustion.id, "target")
                    return true;
            end
        end,
    
        ["Fire Blast"] = function()
        if ni.spell.available(spells.FireBlast.id) 
                and UnitAffectingCombat("player")
                and not ni.unit.ischanneling("player") 
                and ni.unit.ismoving("player")
                and ni.player.isfacing("target") then
                    ni.spell.cast(spells.FireBlast.id, "target")
                    return true;
            end
        end,

        ["SorchMoving"] = function()
            if ni.spell.available(spells.Scorch.id) 
                    and UnitAffectingCombat("player")
                    and not ni.unit.ischanneling("player") 
                    and ni.unit.ismoving("player")
                    and ni.player.isfacing("target") then
                        ni.spell.cast(spells.Scorch.id, "target")
                        return true;
                end
            end,
        ["Fire Blastproc"] = function()
            if ni.vars.combat.aoe
            and UnitAffectingCombat("player")
                    and not ni.unit.ischanneling("player") 
                    and ni.player.isfacing("target")
                    and ni.player.buff(64343) 
                    and ni.unit.debuff("target", 44457) --Living BOmb
                    then
                        ni.spell.cast(spells.FireBlast.id, "target")
                        return true;
                end
            end,
        ["Dragon Breath"] = function()
            if ni.spell.available(spells.DragonsBreath.id) 
            and ni.unit.inmelee("player", "target") then
                ni.spell.cast(spells.DragonsBreath.id)
            end
        end,
        ["Fireball"] = function()
        if  UnitAffectingCombat("player")
                and not ni.unit.ischanneling("player") then
                    ni.spell.cast(spells.Fireball.name, "target")
                    return true;
            end
        end,
        ["Scorch"]= function()
            local _, enabled = GetSetting("Scorch")
                if enabled 
                    and ni.spell.available(spells.Scorch.id)
                    and UnitAffectingCombat("player")
                    and ni.unit.isboss("target")
                    and ni.unit.debuff("target", 22959, "player") == nil -- Improved Scorch --
                    and not ni.unit.ischanneling("player") then
                        ni.spell.cast(spells.Scorch.name, "target")
                        return true;
                end
            end,
            -- ["Living Bomb AOE"] = function()
            --     if ni.vars.combat.aoe and ActiveEnemies() > 1 then
            --         local count = 0 -- contador de objetivos afectados por Firebomb
            --         for k, v in ipairs(enemies) do
            --             if count < 3 and ni.unit.debuff(v.guid, spells.LivingBomb.id, "player") == nil 
            --             and ni.unit.unitstargeting(v.guid) then
            --                 if ni.spell.valid(v.guid, spells.LivingBomb.id, false, true) then
            --                     ni.spell.cast(spells.LivingBomb.id, v.guid)
            --                     count = count + 1
            --                     return true
            --                 end
            --             end
            --         end
            --     end
            -- end,

            ["Living Bomb AOE"] = function()
                if ni.vars.combat.aoe and ActiveEnemies() > 1 then 
                        for i = 1, 3 do
                        local targ = enemies[i].guid;
                            if not ni.unit.debuff(targ, spells.LivingBomb.id, "player") 
                            and ni.spell.valid(targ, spells.LivingBomb.id, false, true) then
                                    ni.spell.cast(spells.LivingBomb.id, targ)
                                    return true;
                                end
                            end
                        end
                end,
        }

ni.bootstrap.profile("Tapto - Fire Mage", queue, abilities, OnLoad, OnUnload);


-- Impact despues fireblast 
-- Check para Combustion 
--  92315 and ignite 1265
-- Check for a good ignite
