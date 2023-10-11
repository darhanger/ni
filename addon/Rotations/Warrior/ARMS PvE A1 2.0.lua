local A1 = ni.utils.require("A1")
local arms_skills = {
    Battle_Shout = GetSpellInfo(47436),
    Commanding_Shout = GetSpellInfo(47440),
    Mortal_Strike = GetSpellInfo(47486),
    Battle_Stance = GetSpellInfo(2457),
    Berserker_Rage = GetSpellInfo(18499),
    DworfRace = GetSpellInfo(316246),
    Overpower = GetSpellInfo(7384),
    Sunden_Armor = GetSpellInfo(7386),
    Rend = GetSpellInfo(47465),
    Demoralizing_Shout = GetSpellInfo(47437),
    Bloodrage = GetSpellInfo(2687),
    Heroic_Strike = GetSpellInfo(47450),
    Cleave = GetSpellInfo(47520),
    Auto_Attack = GetSpellInfo(6603),
    Enrage = GetSpellInfo(57516),
    Enraged_Regeneration = GetSpellInfo(55694),
    Slam = GetSpellInfo(47475),
    Sunder_Armor_Debuff = GetSpellInfo(58567),
    Execute = GetSpellInfo(47471),
    Sweeping_Strikes = GetSpellInfo(12328),
    Shattering_Throw = GetSpellInfo(64382),
    Hamstring = GetSpellInfo(1715),
    Death_Wish = GetSpellInfo(12292),
    Bladestorm = GetSpellInfo(46924),
    Thunderclap = GetSpellInfo(47502),
    Pummel = GetSpellInfo(6552),
    BerserkerStance = GetSpellInfo(2458),
    BlackDworfRace = GetSpellInfo(316162),
}
local arms_icons = {
    Battle_Shout = select (3, GetSpellInfo(47436)),
    Commanding_Shout = select (3, GetSpellInfo(47440)),
    Bloodrage = select (3, GetSpellInfo(2687)),
    Sunden_Armor = select (3, GetSpellInfo(7386)),
    Hamstring = select (3, GetSpellInfo(1715)),
    DworfRace = select (3, GetSpellInfo(316246)),
    Rend = select (3, GetSpellInfo(47465)),
    Battle_Stance = select (3, GetSpellInfo(2457)),
    BlackDworfRace = select(3, GetSpellInfo(316162)),
}
local arms_menu = {
    settingsfile = "A1 - Arms Warrior PvE 2.0.json",
    { type = "title", text = "|cff7f6745Arms Warrior PvE |cffcece0cA1 v2.0" },
    { type = "separator" },
    { type = "entry", text = "\124T"..arms_icons.Battle_Stance..":22:22\124t |cff7f6745Вход в боевую стойку", enabled = true, key = "gui_Stance" },
    --{ type = "entry", text = "\124T"..arms_icons.Bloodrage..":22:22\124t |cff7f6745Кровавая ярость", value = 33, min = 10, max = 99, step = 1, width = 25, enabled = false, key = "gui_Bloodrage" },
    --{ type = "entry", text = "\124T"..arms_icons.Sunden_Armor..":22:22\124t |cff7f6745Раскол брони", enabled = true, key = "gui_SundenArmor" },
    --{ type = "entry", text = "\124T"..arms_icons.Rend..":22:22\124t |cff7f6745Кровотечение", enabled = true, key = "k_rend" },
    { type = "entry", text = "\124T"..arms_icons.Hamstring..":22:22\124t |cff7f6745Сухожилия", enabled = true, key = "gui_Hamstring" },
    --{ type = "entry", text = "\124T"..arms_icons.BlackDworfRace..":22:22\124t |cff7f6745Воодушевляющий клич", enabled = true, key = "gui_race" },
    { type = "dropdown", menu = {
        { selected = true, value = arms_skills.Battle_Shout, text = "|cff7f6745Боевой крик" },
        { selected = false, value = arms_skills.Commanding_Shout, text = "|cff7f6745Командирский крик" },
        { selected = false, value = 0, text = "|cff7f6745Выкл" },
        }, key = "gui_Shout" },
        { type = "separator" },
        { type = "entry", text = "|cffcece0cЛог", enabled = false, key = "gui_debug" },
}
local function GetSetting(name)
  for k, v in ipairs(arms_menu) do
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
end
local function menu_load()
ni.GUI.AddFrame("A1 Arms Warrior PvE ", arms_menu)
end
local function menu_unload()
ni.GUI.DestroyFrame("A1 Arms Warrior PvE ")
end
local NearestAgressiveEnemies = {}
local function NearestEnemies()
	table.wipe(NearestAgressiveEnemies);
	NearestAgressiveEnemies = ni.player.enemiesinrange(6)
	for k, v in ipairs(NearestAgressiveEnemies) do
		if ni.player.threat(v.guid) == -1 then
			table.remove(NearestAgressiveEnemies, k)
		end
	end
    return #NearestAgressiveEnemies
end
local atackspeed = UnitAttackSpeed("player");
local LastBloodrage = 0
local arms_rotation = {
    "Stance",
    "Berserker Rage",
    "Pause",
    "Healthstone",
    "Health Pot",
    "Bloodrage",
    "Enraged Regeneration",
    "Shout",
    "Racial",
    "Burst",
    "Combat Pause",
    --"Pummel",
    "Auto Attack",
    "Hamstring",
    "Rend",
    "Sweeping Strikes",
    "Bladestorm",
    "Strikes",
    "Sunder Armor",
    "Mortal Strike",
    "Execute",
    "Overpower",
    "Thunderclap",
    --"Slam",
}
local arms_functions = {
    ["Pause"] = function ()
        local framerate = GetFramerate()
        if IsMounted()
        or UnitInVehicle("player")
        or ni.player.buff(GetSpellInfo(430))
        or ni.player.buff(GetSpellInfo(433))
        or ni.player.isconfused()
        or ni.player.isfleeing()
        or ni.player.isstunned()
        or UnitIsDeadOrGhost("player")
        or IsLeftShiftKeyDown()
        or framerate < 18 then
            return true
        end
		ni.vars.debug = select(2, GetSetting("gui_debug"))
    end,
    ["Combat Pause"] = function ()
        if IsLeftShiftKeyDown()
        or (ni.player.debuffstacks(70106) >= 4 and ni.player.hp() < 90)
        or (ni.unit.hp("target") == 100 and UnitInRaid("player"))
        or ni.player.buff(arms_skills.Bladestorm) then
            return true
        end
    end,
	["Berserker Rage"] = function ()
		if ni.player.isfleeing() then
            if ni.spell.available(arms_skills.Berserker_Rage) then
                return ni.spell.cast(arms_skills.Berserker_Rage)
            end
        end
	end,
    ["Auto Attack"] = function()
        NearestAgressiveEnemies = ni.player.enemiesinrange(6)
        if A1.PlayerCanAttack()
        and not IsCurrentSpell(arms_skills.Auto_Attack) then
            ni.spell.cast(arms_skills.Auto_Attack)
        end
        if ni.unit.exists("target")
        and UnitCanAttack("player", "target")
        and not (ni.player.inmelee("target") or ni.player.isfacing("target"))
        and IsCurrentSpell(arms_skills.Auto_Attack) then
            ni.player.runtext("/stopattack")
        end
        if UnitAffectingCombat("player")
        and (not ni.unit.exists("target") or (ni.unit.exists("target") and not UnitCanAttack("player", "target"))) then
            if #NearestAgressiveEnemies >= 1 then
                ni.player.runtext("/targetenemy")
            end
        end
    end,
	["Stance"] = function()
		local _, BattleStanceEnabled = GetSetting("gui_Stance")
        if BattleStanceEnabled then
            if not ni.player.aura(arms_skills.Battle_Stance) then
                if ni.spell.available(arms_skills.Battle_Stance) then
                    return ni.spell.cast(arms_skills.Battle_Stance)
                end
            end
        end
	end,
	["Shout"] = function()
		local CurrentShout = GetSetting("gui_Shout")
        if CurrentShout == 0 then
            return false
        end
		if ni.player.buffremaining(CurrentShout) < 7 then
            if ni.spell.available(CurrentShout) then
                return ni.spell.cast(CurrentShout)
            end
        end
	end,
	["Mortal Strike"] = function()
		if ni.spell.available(arms_skills.Mortal_Strike)
		and A1.PlayerCanAttack() then
			return ni.spell.cast(arms_skills.Mortal_Strike)
		end
	end,
	["Pummel"] = function()
		if not ni.player.isdisarmed() then
            if ni.spell.shouldinterrupt("target")
            or ni.unit.ischanneling("target") then
                if ni.spell.cd(arms_skills.Pummel) == 0
                and ni.player.power() >= 10
                and A1.PlayerCanAttack() then
                    ni.spell.cast(arms_skills.BerserkerStance)
                    ni.spell.cast(arms_skills.Pummel)
                    return true
                end
            end
		end
	end,
	["Rend"] = function ()
        NearestAgressiveEnemies = ni.player.enemiesinrange(6)
        if ni.unit.creaturetype("target") ~= 9
        and ni.unit.creaturetype("target") ~= 2 then
            if ni.unit.debuffremaining("target", arms_skills.Rend, "player") <= 3 then
                if ni.spell.available(arms_skills.Rend)
                and A1.PlayerCanAttack() then
                    if #NearestAgressiveEnemies == 1 then
                        return ni.spell.cast(arms_skills.Rend)
                    end
                end
            end
        end
	end,
	["Overpower"] = function()
		if IsUsableSpell(arms_skills.Overpower) then
            if ni.spell.available(arms_skills.Overpower)
            and ni.player.buff(304676)
            and A1.PlayerCanAttack() then
                return ni.spell.cast(arms_skills.Overpower)
            end
        end
	end,
	["Execute"] = function()
		if IsUsableSpell(arms_skills.Execute) then
            if ni.spell.available(arms_skills.Execute)
            and not ni.player.buff(304676)
            and A1.PlayerCanAttack() then
                return ni.spell.cast(arms_skills.Execute)
            end
        end
	end,
	["Racial"] = function ()
        if not ni.player.ispvpflagged()
        and ni.unit.ttd("target") > 10 then
            if UnitAffectingCombat("player")
            and ni.spell.cd(316373) == 0
            and A1.PlayerCanAttack() then
                return ni.spell.cast(316373)
            end
        end
	end,
	["Sunder Armor"] = function()
		--local _, SunderArmorEnabled = GetSetting("gui_SundenArmor")
        if ni.unit.isboss("target") then
            if ni.spell.cd(arms_skills.Mortal_Strike) ~= 0 and not IsUsableSpell(arms_skills.Overpower) then
                if ni.unit.debuffremaining("target", arms_skills.Sunder_Armor_Debuff) < 7
                or ni.unit.debuffstacks("target", arms_skills.Sunder_Armor_Debuff) < 5 then
                    if ni.spell.available(arms_skills.Sunden_Armor)
                    and A1.PlayerCanAttack() then
                        return ni.spell.cast(arms_skills.Sunden_Armor)
                    end
                end
            end
        end
	end,
	["Bloodrage"] = function()
		--local Value, BloodRageEnabled = GetSetting("gui_Bloodrage")
		--if BloodRageEnabled then
            if UnitAffectingCombat("player")
            and ni.player.power() < 35
            and ni.spell.cd(arms_skills.Bloodrage) == 0
            and ni.player.hp() >= 10
            and GetTime() - LastBloodrage > 10 then
                LastBloodrage = GetTime()
                return ni.spell.cast(arms_skills.Bloodrage)
            end
        --end
	end,
	["Strikes"] = function ()
        NearestAgressiveEnemies = ni.player.enemiesinrange(6)
		if not ni.player.isdisarmed() then
            if not IsCurrentSpell(arms_skills.Cleave) then
                if A1.PlayerCanAttack()
                and ni.player.power() >= 75 then
                    if #NearestAgressiveEnemies >= 2 then
                        return ni.spell.cast(arms_skills.Cleave)
                    end
                end
            end
            if not IsCurrentSpell(arms_skills.Heroic_Strike) then
                if A1.PlayerCanAttack()
                and ni.player.power() >= 90 then
                    if #NearestAgressiveEnemies == 1 then
                        return ni.spell.cast(arms_skills.Heroic_Strike)
                    end
                end
            end
		end
	end,
	["Enraged Regeneration"] = function()
		if UnitAffectingCombat("player")
        and ni.player.hp() <= 55
        and ni.spell.available(arms_skills.Enraged_Regeneration)
		and ni.player.buff(arms_skills.Enrage) then
			return ni.spell.cast(arms_skills.Enraged_Regeneration)
		end
	end,
	["Slam"] = function()
		if ni.spell.available(arms_skills.Slam)
		and A1.PlayerCanAttack()
        and not ni.player.ismoving()
        and ni.player.power() >= 99 then
			return ni.spell.cast(arms_skills.Slam)
		end
	end,
	["Thunderclap"] = function()
        NearestAgressiveEnemies = ni.player.enemiesinrange(6)
        if not ni.unit.isboss("target") then
            if UnitAffectingCombat("player")
            and ni.spell.available(arms_skills.Thunderclap)
            and A1.PlayerCanAttack()
            and #NearestAgressiveEnemies >= 3 then
                return ni.spell.cast(arms_skills.Thunderclap)
            end
        end
	end,
	["Sweeping Strikes"] = function()
        NearestAgressiveEnemies = ni.player.enemiesinrange(6)
        if ni.spell.cd(arms_skills.Sweeping_Strikes) == 0
        and A1.PlayerCanAttack() then
            if #NearestAgressiveEnemies >= 2 then
                return ni.spell.cast(arms_skills.Sweeping_Strikes)
            end
        end
	end,
	["Bladestorm old"] = function()
            if ni.spell.available(arms_skills.Bladestorm)
            and A1.PlayerCanAttack() then
                if #NearestAgressiveEnemies >= 3 or (ni.player.buff(307879)
                or ni.player.buff(319949))
                and ni.unit.isboss("target") then
                    return ni.spell.cast(arms_skills.Bladestorm)
                end
            end
	end,
	["Bladestorm"] = function()
        NearestAgressiveEnemies = ni.player.enemiesinrange(6)
            if ni.spell.available(arms_skills.Bladestorm)
            and A1.PlayerCanAttack() then
                --if #NearestAgressiveEnemies >= 3 or
                --ni.unit.isboss("target") then
                    return ni.spell.cast(arms_skills.Bladestorm)
                --end
            end
	end,
	["Burst"] = function()
		if ni.unit.exists("target")
        and ni.unit.isboss("target")
        and (ni.player.buff(45428) or ni.player.buff(59620)) then
            if ni.spell.available(arms_skills.Shattering_Throw)
            and A1.PlayerCanAttack()
            and not ni.player.ismoving() then
                return ni.spell.cast(arms_skills.Shattering_Throw)
            end
            if ni.player.slotcastable(13)
            and ni.player.slotcd(13) == 0 then
                return ni.player.useinventoryitem(13)
            end
        end
	end,
	["Hamstring"] = function()
		local _, slow_enabled = GetSetting("gui_Hamstring")
        if slow_enabled or ni.unit.isplayer("target") then
            if not ni.unit.debuff("target", arms_skills.Hamstring) then
                if ni.spell.available(arms_skills.Hamstring)
                and A1.PlayerCanAttack() then
                    return ni.spell.cast(arms_skills.Hamstring)
                end
            end
        end
	end,
	["Healthstone"] = function()
		local hstones = { 36892, 36893, 36894 }
		for i = 1, #hstones do
            if UnitAffectingCombat("player")
            and ni.player.hp() < 50
            and ni.player.hasitem(hstones[i])
            and ni.player.itemcd(hstones[i]) == 0 then
            	return ni.player.useitem(hstones[i])
            end
		end
	end,
	["Health Pot"] = function()
		if UnitAffectingCombat("player")
		and not ni.player.debuff(30843) then
			if ni.player.hp() < 15
            and ni.player.hasitem(41166)
            and ni.player.itemcd(41166) == 0 then
                return ni.player.useitem(41166)
            end
        end
    end,
}
ni.bootstrap.profile("ARMS PvE A1 2.0", arms_rotation, arms_functions, menu_load, menu_unload)