local build = select(4, GetBuildInfo());
local wotlk = build == 30300 or false;
if wotlk then

	local function onload()
	print("Rotation \124cFF15E615Dalvae Shadow Helper")
end

local function onunload()
	print("Rotation \124cFFE61515stopped!")
end

SLASH_PRIMARY1 = "/rotationprimary"
SlashCmdList["PRIMARY"] = function(msg)
	ni.toggleprofile(ni.vars.profiles.primary)
end

SLASH_SECONDARY1 = "/rotationsecondary"
SlashCmdList["SECONDARY"] = function(msg)
	ni.toggleprofile(ni.vars.profiles.secondary);
end 

SLASH_GUI1 = "/rotationgui"
SlashCmdList["GUI"] = function(msg)
	ni.main_ui.main:Show();
end

SLASH_HEAL = "/heal"
SlashCmdList["heal"] = function(msg)
	return queue2
end
SLASH_DISPERSION1 = "/dispersion"
SlashCmdList["dispersion"] = function(msg)
    if ni.spell.available("47585") then
	ni.spell.cast("47585")
    print("papa")
    end
end
SLASH_FEARE = "/feare"
SlashCmdList["feare"] = function(msg)
	ni.spell.cast("10890")
end

local queue = {
    "Inner Fire",
    "Power Word: Shield",
    "MassDispel",
    "Vampiric Embrace",
    -- "Levitate",
    "Pause Rotation",
    "SWDcontrol",
    "shade",
    "DizarmBurst",
    "Power Word:Shield",
	"Shadow Form",
    "Antireflect",
    "DisarmBlade",
    "Silence",
    "KS",
    "KS2",
    "dispelbuffsPVP",
    "SWP Moving",
    "DVP Moving",
    "Movingdispel",
    "Vampiric Touch",
    "Shadow Word:Pain",
    "Devouring Plague",
    "Mind Blast",
    "Mind Flay",
    "Dispell Magic",
    "Disease",
}
local queue2 = {
    "Renew",
    "Mending",
    "Shield Arena",
    "Nova",
    "Flash Heal",
}
local abilities = {
    ["Inner Fire"] = function()
            if ni.spell.available("Inner Fire")
            and not ni.unit.buff("player", "Inner Fire") then
                ni.spell.cast("Inner Fire")
            end
        
    end,

    ["Vampiric Embrace"] = function()
            if ni.spell.available("Vampiric Embrace")
            and not ni.unit.buff("player", "Vampiric Embrace") then
                ni.spell.cast("Vampiric Embrace")
            end
        
    end,
    
    -- ["Levitate"] = function()
    --     if isFalling("player") 
    --     and ni.spell.available("1706")
    --     then ni.spell.cast("1706")
    --     end
    -- end,

    ["Pause Rotation"] = function()
        if IsMounted()	
        or UnitIsDeadOrGhost("player")
				or not UnitAffectingCombat("player")
				or ni.unit.buff("player", "Drink")
                or ni.unit.iscasting("player")
                or ni.unit.ischanneling("player") then
            return true;
        end
    end,
    ["SWDcontrol"] = function()
        SWDreaction = {
            -- polymorphs
            12826,
            12824,
            118,
            12825,
            61305, -- black cat
            28272, -- pig
            61721, -- rabbit
            61780, -- turkey
            28271, -- turtle
            -- seduces
            31865,
            30850,
            29490,
            20407,
            6359,
            6358
            }
        local enemies = ni.unit.enemiesinrange("player", 36)
        for i, v in ipairs(SWDreaction) do
        for i = 1, #enemies do
        if ni.spell.cd(48158) == 0
        and (UnitCastingInfo(enemies[i].guid)==GetSpellInfo(v)  or UnitChannelInfo(enemies[i].guid)==GetSpellInfo(v) ) then
        ni.spell.cast(48158, enemies[i].guid)
        break
        end
        end
        end
    end,

    ["Power Word:Shield"] = function()
        if not ni.unit.debuff("player", "Weakened Soul", "player")
            and not ni.unit.buff("player", "Power Word: Shield", "player")
             and ni.spell.available("Power Word: Shield") then
            ni.spell.cast("Power Word: Shield", "player")
        end
    end,

    ["Shadow Form"] = function()
        if not ni.unit.buff("15473", "player")
        then ni.delayfor(1.5, function()
            ni.spell.cast("15473", "player")
        end);
        end
    end,
    ["Antireflect"] = function()
        if ni.spell.available("453") -- Mind soothe the warrior
        and ni.unit.buff("23920", "target")
        then ni.spell.stopcasting ()
            ni.spell.cast("453", "target")
        end
    end,
    ["DisarmBlade"] = function()
        if ni.spell.available("64044")
        and ni.unit.buff("46924", "target")
        then ni.spell.cast("64044", "target")
        end
    end,
    -- Silence should be improved

    ["DizarmBurst"] = function()
        local burst = { 49016, 51713, 1719, 46924 }
        local enemies = ni.unit.enemiesinrange("player", 36)
        for d = 1, #burst do
        for i = 1, #enemies do
        if ni.unit.buff(enemies[i].guid, burst[d])   
        and ni.spell.available(spells.Dizarm.name) 
        and ni.spell.valid(enemies[i].guid,spells.Dizarm.name )
        then
        ni.spell.cast(spells.Dizarm.name, enemies[i].guid)
        return true
        end
        end 
        end
        end,
    ["Silence"] = function()
        if ni.spell.available("Silence")
        and (ni.unit.castingpercent("target") >=80
			or ni.unit.ischanneling("target")) then
            ni.spell.cast("Silence", "target")
        end
    end,
    -- Here I need to make a list of spell to interrupts 


    -- ["KS"] = function()
    --         if ni.spell.valid("target", 48518, false, true, true)
    --         and ni.unit.hpraw ("target") <= 3500
    --         -- and not ni.unit.buffs(target, 45438 or 642) 
    --         then ni.player.useinventoryitems(10)
    --             ni.spell.cast(48518, "target")
    --         end
    --     end,

    ["KS"] = function()
        local enemieslow = ni.unit.enemiesinrange("player", 30)
        if ni.spell.available(48518) then
        for i = 1, #enemieslow do
            local target = enemieslow[i].guid
            if ni.spell.valid(target, 48518, true, true, true)
            and ni.unit.hpraw (target) <= 2500
            then ni.player.useinventoryitems(10)
                ni.spell.cast(48518, target)
            end
        end
        end
    end,
        -- ["KS"] = function()
    
        --     if  ni.spell.available(48518)
        --     and ni.unit.hp("target") <= 20
        --     and ni.spell.valid("target", 48518, false, true, true)
        --     then ni.player.useinventoryitems(10)
        --     ni.spell.cast(48518, "target")
        --     print ("executaas")
        --     return true
        --     end
        --     end,
    ["KS2"] = function()
        local enemies = ni.unit.enemiesinrange("player", 30)
        if ni.spell.cd(48518) == 0 then
        for i = 1, #enemies do
            local tar = enemies[i].guid
            if ni.spell.valid(tar, 48518, false, true, true)
            and ni.unit.hpraw (tar) <= 3500
            -- and not ni.unit.buffs(target, 45438 or 642) 
            then ni.player.useinventoryitems(10)
                ni.spell.cast(48518, tar)        
            end
        end
        end
        end,

    ["DevouringPlagueKIll"] = function()
    local enemies;
    if ni.spell.available(spells.DevouringPlague.name)
    and ni.player.ismoving() then
    enemies = ni.unit.enemiesinrange("player", 35)
    for i = 1, #enemies do
    local tar = enemies[i].guid; 
    if ni.unit.hp(tar) <= values
    and not ni.unit.isplayer(enemies[i].guid) 
    and ni.spell.valid(enemies[i].guid, spells.DevouringPlague.id, false, true, true) then
        ni.spell.cast(spells.DevouringPlague.name, tar)
    return true
    end
    end
    end
    end,

    ["dispelbuffsPVP"] = function()
        local buffdisp = { 43242, 31884, 2825, 32182, 1719, 17, 6940, 11426, 29166, 54428,53601,
        29166, 			-- innervation
        10060, 			-- Infusion de puissance
        31842,			-- Illumination divine
        69369,			-- Instant feral
        12472,			-- Veine glaciale
        17116,			-- instant cast drood heal
        16188,			-- istant heal sham
        }
        for d = 1, #buffdisp do
         if ni.unit.buff("target", buffdisp[d])   
            and ni.spell.available(988) 
            and ni.spell.valid("target", 988)
            then
        ni.spell.cast(988, "target")
        return true
        end
        end 
        end,


    ["Movingdispel"] = function()
            local enemies = ni.unit.enemiesinrange("player", 30)
            if ni.unit.ismoving("player") then 
                for i = 1, #enemies do
                    local target = enemies[i].guid
                    if ni.unit.buff(target)
                    and not ni.unit.buffs(target, 45438 or 642) 
                    then  ni.spell.cast(988, target)
                end
            end
        end
            end,
    ["Disease"] = function()
            for i = 1, #ni.members do
                if ni.members[i]:debufftype("Disease")
                    and ni.members[i].range
                    and ni.members[i].hp > 40
                    and ni.spell.available("Cure Disease") then
                    ni.spell.cast("Cure Disease", ni.members[i].unit)
                end
            end
    end,
    ["Dispel Magic"] = function()
            for i = 1, #ni.members do
                if ni.members[i]:debufftype("Magic")
                    and ni.members[i].range
                    and ni.members[i].hp > 40
                    and ni.spell.available("988") then
                    ni.spell.cast("988", ni.members[i].unit)
                end
            end
    end,

    ["SWP Moving"] = function()
        if ni.spell.available("48125")
        and ni.unit.ismoving("player")
        and ni.unit.debuffremaining("target", "48125") <= 3
        then ni.spell.cast("48125", "target")
        end
    end,

    ["DVP Moving"] = function()
        if ni.spell.available("48300")
        and ni.unit.ismoving("player")
        and ni.unit.debuffremaining("target", "48300") <= 3
        then ni.spell.cast("Devouring Plague", "target")
        end
    end,
    ["Vampiric Touch"] = function()
        if ni.spell.available("48160")
        and not ni.unit.ismoving("player")
        and ni.unit.debuffremaining("target", "48160", "player") <= 1.5
        then ni.spell.cast("Vampiric Touch", "target")
            ni.spell.delaycast(48160, "target", 8)
            ni.player.lookat("target")
        end
    end,

    -- ["Vampiric Touch"] = function()
    --     if not ni.player.ismoving()
    --     and ni.spell.available(48160,"target")
    --     and ni.unit.debuffremaining(t, 48160, p) < ni.spell.casttime(48160)
    --     and GetTime() - data.LastVamp > 2
    --     and FacingLosCast(spells.VampiricTouch.name, t)
    --     then  data.LastVamp = GetTime()
    --     return true
    --     end
    --     end,
    ["Shadow Word:Pain"] = function()
        if ni.spell.available("48125")
        and ni.unit.debuffremaining("target","48125" ) <= 1
        then ni.spell.cast("48125", "target")
        end
    end,
    ["Devouring Plague"] = function()
        if ni.spell.available("48300")
        and ni.unit.debuffremaining("target", "48300") <= 0.5
        then ni.spell.cast("Devouring Plague", "target")
        end
    end,
    ["Mind Blast"] = function()
        if ni.spell.available("Mind Blast")
        and not ni.unit.ismoving("player")
        and ni.spell.available ("Mind Blast")
        then ni.spell.cast("Mind Blast", "target")
            ni.player.lookat("target")
        end
    end,
    ["Mind Flay"] = function()
        if ni.spell.available("Mind Flay")
        and not ni.unit.ismoving("player")
        then ni.spell.cast("Mind Flay", "target")
            ni.player.lookat("target")
        end
    end,

    ["MassDispel"] = function()
        local buffdispe = {642, 45438} -- Divine Shield, Ice Block
        local gays = ni.unit.enemiesinrange("player", 36)
        for d = 1, #buffdisp do
        for i = 1, #gays do
        if ni.unit.buff(gays[i].guid, buffdispe[d]) 
        and not ni.player.ismoving() 
        and ni.spell.valid(48125, gays[i].guid, false, true, true)
        then
        print ("dispel")
        ni.spell.castat(32375, gays[i].guid)
        return true
        end
        end 
        end
    end,
    
    ["test"] = function()
local friends = ni.unit.friendsinrange("player", 30)

for i = 1, #friends do
  local target = friends[i].guid
  local name = friends[i].name
  local distance = friends[i].distance
    print(name)
end
        -- local enemies = ni.unit.enemiesinrange("player", 30)

        -- for i = 1, #enemies do
        --   local target = enemies[i].guid
        --     print(target)
        -- end



    --     local gays = ni.unit.enemiesinrange("player", 30)
    --     for i =1, #gays do
    --         local target = gays[i].guid
    --         if not ni.player.ismoving() 
    --         and ni.spell.valid( target, 48125, false, true, true)
    --         then
    --         print ("dispel")
    --         ni.spell.castat(32375, target)
    --     return true
    --     end 
    -- end
    end,

    ["Mending"] = function()
        for i = 1, #ni.members do
        if ni.members[i].range
        and not ni.unit.buff(ni.members[i].unit, "Prayer of Mending", "player")
        and ni.spell.available("Prayer of Mending") then
            ni.spell.cast("Prayer of Mending", ni.members[i].unit)
        end
        end
    end,

    ["Flash Heal"] = function()
        if not ni.player.ismoving() then
        for i = 1, #ni.members do
            if ni.members[i].hp<=70
            and ni.members[i].range
            and ni.spell.available("Flash Heal") then
                ni.spell.cast("Flash Heal", ni.members[i].unit)
            end
        end
    end
    end,



    ["Renew"] = function()
for i = 1, #ni.members do
if ni.members[i].hp <= 85
and ni.spell.available(48068)
and not ni.unit.buff(ni.members[i].unit, 48068, "player")
and ni.spell.valid(ni.members[i].unit, 48068, false, true, true) then
ni.spell.cast(48068, ni.members[i].unit)
return true
end
end
end,
-----------


    ["Nova"] = function()
        if ni.player.ismoving()
        and ni.player.hp() < 85
        then ni.spell.cast(48078)
        end
    end,

    ["Shield Arena"] = function()
            for i = 1, #ni.members do
                if ni.members[i].hp < 95 and ni.members[i].range
                and not ni.unit.debuff(ni.members[i].unit, "Weakened Soul", "player")
                and not ni.unit.buff(ni.members[i].unit, "Power Word: Shield", "player")
                and ni.spell.available("Power Word: Shield") then
                    ni.spell.cast("Power Word: Shield", ni.members[i].unit)
                end
            end
    end,

    ["shade"] = function()
        local slowing slowing  = { 45524, 1715, 3408, 59638, 20164, 25809, 31589, 51585, 50040, 50041, 31126, 31124, 122, 44614, 1604, 45524, 50040, 339, 45334, 58179, 61391, 19306, 19185, 35101, 5116, 61394, 2974, 54644, 50245, 50271, 54706, 4167, 33395, 55080, 11113, 6136, 120, 116, 44614, 31589, 63529, 20170, 31125, 3409, 26679, 64695, 63685, 8056, 8034, 18118, 18223, 23694, 12323, 55536, 13099, 29703 }
        for d = 1, #slowing  do
        if ni.player.debuff( slowing [d])
        and ni.player.hp() < 80
        and ni.spell.available(586) 
        then
        ni.spell.cast(586)
        return true
        end
        end
        end,
}

local dynamicqueue = function()

	if ni.unit.buff("player", 14473, "EXACT") then
	 return queue
	 end

	if ni.player.hp() < 30 then
		return queue2
	end

    if ni.player.hp() >= 90 then
		return queue
	end


	return queue
	end



ni.bootstrap.profile("Dalvae_shadowhelper_wotlk", queue, abilities, onload, onunload);
else
    local queue = {
        "Error",
    };
    local abilities = {
        ["Error"] = function()
            ni.vars.profiles.enabled = false;
			if not wotlk then
				ni.frames.floatingtext:message("This profile for WotLK 3.3.5a!")
            end
        end,
    };
    ni.bootstrap.profile("Dalvae_shadowhelper_wotlk", queue, abilities);
end;
-- Shadow Form = 15487
-- Vampiric Embrace = 15286
-- Physic horror = 64044
-- Mind Flay = 48156
-- Mind Blast = 48127
-- Devoring plague = 48300
-- Shadow word:pain = 48125 
-- shadow word:death = 48158
-- Vampire Touch = 48160
-- Silence = 15487
----------------------------------------------------------------
-- Spells to dispell defensive 
----------------------------------------------------------------
-- Hammer of Justice (Paladin): 853
-- Polymorph (Mage): 118
-- Gouge (Rogue): 1776
-- Entangling Roots (Druid): 339
-- Freezing Trap (Hunter): 3355
-- Fear (Warlock) / Psychic Scream (Priest): 6213 / 10890
-- Frost Nova (Mage): 122
-- Deep Freeze (Mage): 44572
-- 
---------------------------------------------------------------
-- Spells to dispell ofensive
----------------------------------------------------------------
-- Black Draft (Warlock): 63648
-- Avenging Wrath (Paladin): 31884
-- Predatory Swiftness (Druid): 69369
-- Innervate (Druid): 29166
-- Bloodlust (Shaman) / Heroism (Alliance): 2825 / 32182
-- Shadow Word: Shield (Priest): 48066
-- Rejuvenation (Druid): 26982
-- Regrowth (Druid): 8936
-- Fear Ward (Priest): 6346
-- Divine Plea (Paladin): 54428
-- Sacred Shield (Paladin): 53601
-- Icy veins (Mage): 12472

-- TODO 
-- 1.- List of trinketed CC 
-- 2.- Use trinket when hp low
-- 3- Use Fade when inmobilized 
-- 4- List of Dispeleable buffs 
-- 5- Mass dispell bubble and frost cube 
-- 9- Cache Enemies
-- Slash command for heal 
-- Dispell  no funciona
-- SWD for polly y seduce 
-- if is castring then lookat
-- vampiric touch necesita un valid

-- 

-- interrupt
-- ---------------------------------------------------------------
-- if enables["Interrupter"] then
--     for i, v in ipairs(NeedInterrupt) do
--     if ni.spell.cd(15487) == 0
--     and ( UnitCastingInfo(enemyInterrupt)==GetSpellInfo(v)
--     or UnitChannelInfo(enemyInterrupt)==GetSpellInfo(v) 
--     and GetCastingPercent(enemyInterrupt) >= values["Interrupter"] 
--     or GetChannelPercent(enemyInterrupt) >= values["Interrupter"] ) 
--     then
--     ni.spell.cast(15487, enemyInterrupt)
--     break
--     end
--     end
--     end
--     end, 
-- ----------------------------------------------------------------
--     function CacheEnemies()
--         enemies = ni.unit.enemiesinrange("player", 30)
--         for i = 1, #enemies do
--           distance = enemies[i].distance
--           target = enemies[i].guid
--           for j = 1, 40 do
--             local buff      end_name, _, _, _, _, _, buff_exp_time, _, _, buff_id = UnitBuff(target, j)   
--             if buff_id == <ID_DEL_BUFF_A_COMPROBAR> then
--               -- hacer algo si se encuentra el buff
--               print("Se ha encontrado el buff con ID " .. buff_id .. " en " .. UnitName(target))   

-- ----------------------------------------------------------------che Enemies

--               ["CacheEnemies"] = function()
--                 Enemies = ni.unit.enemiesinrange("player", 30)
--                 for i = 1, #enemies do
--                 Distance = enemies[i].distance
--                 Target = enemies[i].guid
--                 end
--                 end,
-- -----------------------------------------------------------------------


-- ["Ofensivedispel"] = function()
--     local enemies = ni.unit.enemiesinrange("player", 30)
--     for i = 1, #enemies do
--         local target = enemies[i].guid
--         if ni.unit.buffs(target, "853||118||1776||339||3355||6213||10890||122||44572")
--         and not ni.unit.buffs(target, "45438||642") 
--         then  ni.spell.cast(32375, target)
--         end
--     end
--     end,



-- ["dispelbuffsPVP"] = function()
--     if enables["dispelbuffsPVP"] then
--     for d = 1, #buffdisp do
--     if ni.unit.buff("target", buffdisp[d])   
--     and ni.spell.available(988) 
--     and ni.spell.valid("target", 988)
--     then
--     ni.spell.cast(988, "target")
--     return true
--     end
--     end 
--     end
--     end,
--     ----------------------------------
--     ["dispcontrolPVP"] = function()
--     for i = 1, #ni.members do
--     for d = 1, #controlt do
--     if enables["dispcontrolPVP"] 
--     and ni.spell.available(988) 
--     and ni.members[i]:debuff(controlt[d]) 
--     and ni.spell.valid(ni.members[i].unit, 988, false, true, true) 
--     then
--     ni.spell.cast(988, ni.members[i].unit)    
--     return true
--     end
--     end
--     end
--     end,
--     -------------------------
--     ["CureDisease"] = function()
--     for i = 1, #ni.members do
--     if enables["CureDisease"] and ni.spell.available(552) 
--     and ni.members[i]:debufftype("Disease") 
--     and not ni.unit.buff(ni.members[i].unit, 552, "player")
--     and ni.spell.valid(ni.members[i].unit, 552, false, true, true) 
--     then
--     ni.spell.cast(552, ni.members[i].unit)    
--     return true
--     end
--     end
--     end,
-- ----------------------------------