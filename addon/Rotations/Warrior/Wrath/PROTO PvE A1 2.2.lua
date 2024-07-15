local UnitAffectingCombat,
IsLeftAltKeyDown,
IsRightAltKeyDown,
IsLeftShiftKeyDown,
UnitInVehicle,
IsMounted,
GetSpellInfo,
UnitIsDeadOrGhost,
IsCurrentSpell,
UnitCanAttack,
UnitInRaid,
GetRaidTargetIndex,
SetRaidTarget,
GetTime,
IsUsableSpell,
UnitLevel,
UnitCastingInfo,
GetItemCount,
GetNetStats,
UnitClass =
UnitAffectingCombat,
IsLeftAltKeyDown,
IsRightAltKeyDown,
IsLeftShiftKeyDown,
UnitInVehicle,
IsMounted,
GetSpellInfo,
UnitIsDeadOrGhost,
IsCurrentSpell,
UnitCanAttack,
UnitInRaid,
GetRaidTargetIndex,
SetRaidTarget,
GetTime,
IsUsableSpell,
UnitLevel,
UnitCastingInfo,
GetItemCount,
GetNetStats,
UnitClass

local A1 = ni.utils.require("A1")
local PWmenu = {
    settingsfile = "A1-ProtWar2.2.json",
    { type = "title", text = "|cff7f6745Protection Warrior PvE |cffcece0cA1 v2.2" },
    { type = "separator" },
    { type = "entry", text = "\124T"..A1.PWicons.Provoke..":22:22\124t |cff7f6745Таунт", enabled = true, key = "k_taunts" },
    { type = "entry", text = "\124T"..A1.PWicons.StnningStrike..":22:22\124t |cff7f6745Станы", enabled = true, key = "k_stuns" },
    { type = "entry", text = "\124T"..A1.PWicons.ShieldBash..":22:22\124t |cff7f6745Кик", enabled = true, key = "k_kick" },
    --{ type = "entry", text = "\124T"..A1.PWicons.RampantRecovery..":22:22\124t |cff7f6745Прожимки", enabled = false, key = "k_saves" },
    --{ type = "entry", text = "\124T"..A1.PWicons.trink13..":22:22\124t |cff7f6745Тринкеты", enabled = false, key = "k_trinket" },
    { type = "dropdown", menu = {
        { selected = true, value = A1.PWtalents.BattleSout, text = "|cff7f6745Боевой крик" },
        { selected = false, value = A1.PWtalents.CommandShout, text = "|cff7f6745Командирский крик" },
        { selected = false, value = 0, text = "|cffff0063Выкл" },
        }, key = "k_shout" },
    { type = "separator" },
    { type = "entry", text = "|cffcece0cЛог", enabled = false, key = "gui_debug" },
}
local function GetSetting(name)
  for k, v in ipairs(PWmenu) do
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
local function OnLoad()
ni.GUI.AddFrame("A1-ProtWar2-2", PWmenu)
end
local function OnUnLoad()
ni.GUI.DestroyFrame("A1-ProtWar2-2")
end
local highrangeenemies = {}
local agressiveenemies = {}
local friendlyunit = {28676}
local function ActiveHighRangeEnemies()
	table.wipe(highrangeenemies)
	highrangeenemies = ni.player.enemiesinrange(30)
	for k, v in ipairs(highrangeenemies) do
		if ni.player.threat(v.guid) == -1
        and UnitAffectingCombat(v.guid) then
			table.remove(highrangeenemies, k)
		end
	end
	return #highrangeenemies
end
local function ActiveAgressiveEnemies()
	table.wipe(agressiveenemies)
	agressiveenemies = ni.player.enemiesinrange(3)
	for k, v in ipairs(agressiveenemies) do
		if ni.player.threat(v.guid) == -1
        and UnitAffectingCombat(v.guid) then
			table.remove(agressiveenemies, k)
		end
	end
	return #agressiveenemies
end
function Tank(t)
    local _, _, class = UnitClass(t)
	if (class == 11
	and ni.unit.aura(t, 9634))
    or (class == 1
	and ni.unit.aura(t, 71))
    or (class == 2
	and ni.unit.aura(t, 25780))
    or (class == 6
	and ni.unit.aura(t, 48263)) then
		return true
	end
	return false
end
local BadBuff = {9438}
local lasttaunt, lastvigi, lastreset, lastrace = 0, 0, 0, 0
local ControlDebuff = {}
local PWrotation = {
    "clean",
    "Stance",
    "Cache",
	"Pause",
    "Altkey",
    "Buff_shout",
    "Defensive_healthstone",
    "Defensive_healtpotion",
    "Defensive_berserker",
    --"Defensive_trinkets",
    "Defensive_shieldblock",
    --"Defensive_fullprotection",
    --"Defensive_dontfallback",
    "Defensive_SpellReflection",
    "Combat Pause",
    --"Offensive_thunderclap",
    "Taunt_massagro",
    "Taunt_vigilance",
    "Taunt_teasingstrike",
    "Taunt_provoke",
    "Taunt_heroicthrow",
    "Offensive_shieldbash",
    "Stun_stunningstrike",
    --"Stun_shockwave",
    "Offensive_autoattack",
    "Offensive_cleavestrike",
    "Offensive_herostrike",
    "Offensive_crush (debuff stack)",
    "Offensive_shockwave",
    "Offensive_thunderclap",
    "Offensive_powerfulshieldbash",
    "Offensive_granades",
    "Offensive_race",
    "Offensive_bloodfury",
    --"Offensive_shockwave",
    --"Offensive_thunderclap",
    --"Offensive_bloodletting",
    "Offensive_demoralizingshout",
    "Offensive_revenge",
    "Offensive_crush",
}
local PWfunctions = {
	["Cache"] = function()
		if (GetTime() - lastreset >= 15) then
			table.wipe(highrangeenemies)
			table.wipe(agressiveenemies)
			lastreset = GetTime()
		end
	end,
	["Altkey"] = function()
		if IsLeftAltKeyDown() or IsRightAltKeyDown() then
            print("ALT KEY IS SHIFTED")
        end
	end,
    ["Pause"] = function ()
        if IsMounted()
        or UnitInVehicle("player")
        or ni.player.buff(GetSpellInfo(430))
        or ni.player.buff(GetSpellInfo(433))
        or ni.player.isconfused()
        or ni.player.isstunned()
        or UnitIsDeadOrGhost("player") then
			return true
        end
		ni.vars.debug = select(2, GetSetting("gui_debug"))
    end,
    ["Combat Pause"] = function ()
        for _, v in ipairs(BadBuff) do
            if IsLeftShiftKeyDown()
            or ni.player.iscasting()
            or ni.player.ischanneling()
            or ni.unit.buff("target", v) then
                return true
            end
        end
    end,
	["Offensive_autoattack"] = function()
        if UnitAffectingCombat("player") then
            agressiveenemies = ni.player.enemiesinrange(3)
            if A1.PlayerCanAttack() then
                if not IsCurrentSpell(A1.PWtalents.AutomaticAttack) then
                    return ni.spell.cast(A1.PWtalents.AutomaticAttack)
                end
            end
        end
        if ni.unit.exists("target")
        and (not ni.player.inmelee("target") or not ni.player.isfacing("target"))
        and UnitCanAttack("player", "target") then
            if IsCurrentSpell(A1.PWtalents.AutomaticAttack) then
                return ni.player.runtext("/stopattack")
            end
        end
		if UnitAffectingCombat("player")
		and (not ni.unit.exists("target") or (ni.unit.exists("target") and not UnitCanAttack("player", "target")) or UnitIsDeadOrGhost("target")) then
            if #agressiveenemies >= 1 then
                return ni.player.runtext("/targetenemy")
            end
        end
		--if UnitAffectingCombat("player")
        --and not UnitInRaid("player") then
        --    local icon=GetRaidTargetIndex("target")
		--if icon == nil
        --and not ni.unit.isboss("target") then
        --        return SetRaidTarget("target", 3)
        --    end
        --end
	end,
	["Buff_shout"] = function()
		local current_shout = GetSetting("k_shout")
        if current_shout == 0 then
            return false
        end
        if ni.spell.available(current_shout) then
            if ni.player.buffremaining(current_shout) < 25 then
                return ni.spell.cast(current_shout)
            end
        end
	end,
	["Stance"] = function()
        if ni.spell.available(A1.PWtalents.DefensiveStance) then
            if not ni.player.aura(A1.PWtalents.DefensiveStance) then
                return ni.spell.cast(A1.PWtalents.DefensiveStance)
            end
        end
	end,
	["Defensive_berserker"] = function ()
        if ni.spell.available(A1.PWtalents.FuryOfTheBerserker) then
            if ni.player.isfleeing()
            or ni.player.isconfused()
            or ni.player.ispossessed()then
                return ni.spell.cast(A1.PWtalents.FuryOfTheBerserker)
            end
        end
	end,
	["Defensive_shieldblock"] = function()
        if ni.spell.cd(A1.PWtalents.ShieldBlock) == 0 then
            if ni.player.hp() < 85
            and UnitAffectingCombat("player") then
                return ni.spell.cast(A1.PWtalents.ShieldBlock)
            end
		end
	end,
	["Defensive_trinkets"] = function()
		local _, trinket_enabled = GetSetting("k_trinket")
		if trinket_enabled then
            if ni.spell.cd(A1.PWtalents.ShieldBlock) ~= 0
            and not ni.player.buff(A1.PWtalents.ShieldBlock) then
                if ni.player.slotcastable(13)
                and ni.player.slotcd(13) == 0 then
                    if UnitAffectingCombat("player")
                    and ni.player.hp() < 85 then
                        return ni.player.useinventoryitem(13)
                    end
                end
            end
        end
	end,
	["Defensive_fullprotection"] = function()
		local _, saves_enabled = GetSetting("k_saves")
		if saves_enabled then
            if ni.spell.cd(A1.PWtalents.FullProtection) == 0 then
                if UnitAffectingCombat("player")
                and ni.player.hp() <= 15 then
					return ni.spell.cast(A1.PWtalents.FullProtection)
				end
			end
		end
        if ni.spell.cd(A1.PWtalents.FullProtection) == 0
        and ni.unit.buff("target", 22857) then
            return ni.spell.cast(A1.PWtalents.FullProtection)
        end
	end,
	["Defensive_dontfallback"] = function()
		local _, saves_enabled = GetSetting("k_saves")
		if saves_enabled then
            if not ni.player.buff(A1.PWtalents.FullProtection)
            and ni.spell.cd(A1.PWtalents.FullProtection) ~= 0 then
				if ni.spell.available(A1.PWtalents.DontFallBack)
				and ni.spell.cd(A1.PWtalents.RampantRecovery) == 0
				and ni.player.power() >= 15
				and ni.player.buff(A1.PWtalents.Enrage) then
                    if UnitAffectingCombat("player")
                    and ni.player.hp() <= 15 then
						ni.spell.cast(A1.PWtalents.DontFallBack)
						ni.spell.cast(A1.PWtalents.RampantRecovery)
                        return true
					end
				end
			end
		end
	end,
	["Defensive_healtpotion"] = function()
		if UnitAffectingCombat("player")
		and not ni.player.debuff(30843) then
			if ni.player.hp() < 25
            and ni.player.hasitem(41166)
            and ni.player.itemcd(41166) == 0 then
                return ni.player.useitem(41166)
            end
        end
    end,
	["Defensive_healthstone"] = function()
		local hstones = { 36892, 36893, 36894, 33447 }
		for i = 1, #hstones do
            if ni.player.hasitem(hstones[i])
            and ni.player.itemcd(hstones[i]) == 0 then
                if UnitAffectingCombat("player")
                and ni.player.hp() < 33 then
                    return ni.player.useitem(hstones[i])
                end
            end
		end
	end,
	["Offensive_granades"] = function()
        if UnitAffectingCombat("player")
        and not ni.unit.isboss("target") then
            agressiveenemies = ni.player.enemiesinrange(3)
            if ni.player.slotcastable(6)
            and ni.player.slotcd(6) == 0 then
                if #agressiveenemies >= 3 then
                        ni.player.useinventoryitem(6)
                        ni.player.clickat("player")
                        return true
                    end
                end
            if ni.player.hasitem(40771)
            and ni.player.itemcd(40771) == 0 then
                if ni.spell.cd(A1.PWtalents.StunningStrike) ~= 0
                and ni.spell.cd(A1.PWtalents.ShockWave) ~= 0 then
                    if ni.spell.shouldinterrupt("target") then
                        ni.player.useitem(40771)
                        ni.player.clickat("target")
                        return true
                    end
                end
            end
        end
	end,
	["Offensive_race"] = function ()
        if GetTime() - lastrace > 15 then
            if not ni.player.ispvpflagged()
            and ni.spell.cd(316373) == 0
            and ni.unit.ttd("target") > 15 then
                if UnitAffectingCombat("player")
                and A1.PlayerCanAttack()
                and not ni.player.ismoving() then
                    lastrace = GetTime()
                    return ni.spell.cast(316373)
                end
            end
        end
	end,
	["Offensive_thunderclap_old2"] = function()
        if not ni.unit.isboss("target") then
            agressiveenemies = ni.player.enemiesinrange(4)
            if UnitAffectingCombat("player")
            and ni.spell.available(A1.PWtalents.Thunderclap)
            and #agressiveenemies >= 2 then
                return ni.spell.cast(A1.PWtalents.Thunderclap)
            end
        end
        if ni.unit.isboss("target") then
            if ni.spell.cd(A1.PWtalents.PowerfulShieldBash) ~= 0 and (not IsUsableSpell(A1.PWtalents.Revenge) or ni.spell.cd(A1.PWtalents.Revenge) ~= 0) then
                if ni.unit.debuffremaining("target", A1.PWtalents.Thunderclap) < 5
                or #agressiveenemies >= 4 then
                    if UnitAffectingCombat("player")
                    and ni.spell.available(A1.PWtalents.Thunderclap)
                    and ni.unit.exists("target")
                    and not UnitIsDeadOrGhost("target")
                    and ni.player.inmelee("target")
                    and UnitCanAttack("player", "target") then
                        return ni.spell.cast(A1.PWtalents.Thunderclap)
                    end
                end
            end
        end
	end,
	["Offensive_thunderclap"] = function()
        agressiveenemies = ni.player.enemiesinrange(3)
        if UnitAffectingCombat("player")
        and ni.spell.available(A1.PWtalents.Thunderclap)
        and (#agressiveenemies >= 2
        or (ni.player.buffremaining(321491) <= 3
        and ni.player.inmelee("target")
        and UnitCanAttack("player", "target"))) then
            return ni.spell.cast(A1.PWtalents.Thunderclap)
        end
	end,
	["Offensive_thunderclap old"] = function()
        if not ni.unit.isboss("target") then
            if UnitAffectingCombat("player")
            and ni.spell.available(A1.PWtalents.Thunderclap)
            and ni.unit.exists("target")
            and not UnitIsDeadOrGhost("target")
            and ni.player.inmelee("target")
            and UnitCanAttack("player", "target") then
                return ni.spell.cast(A1.PWtalents.Thunderclap)
            end
        end
        if ni.unit.isboss("target") then
            if ni.spell.cd(A1.PWtalents.PowerfulShieldBash) ~= 0 and (not IsUsableSpell(A1.PWtalents.Revenge) or ni.spell.cd(A1.PWtalents.Revenge) ~= 0) then
                if ni.unit.debuffremaining("target", A1.PWtalents.Thunderclap) < 5 then
                    if UnitAffectingCombat("player")
                    and ni.spell.available(A1.PWtalents.Thunderclap)
                    and ni.unit.exists("target")
                    and not UnitIsDeadOrGhost("target")
                    and ni.player.inmelee("target")
                    and UnitCanAttack("player", "target") then
                        return ni.spell.cast(A1.PWtalents.Thunderclap)
                    end
                end
            end
        end
	end,
	["Offensive_powerfulshieldbash"] = function()
        if not ni.player.isdisarmed() then
            if ni.spell.available(A1.PWtalents.PowerfulShieldBash)
            and A1.PlayerCanAttack() then
                return ni.spell.cast(A1.PWtalents.PowerfulShieldBash)
            end
        end
	end,
	["Offensive_shieldbash"] = function()
		local _, kick_enabled = GetSetting("k_kick")
		if kick_enabled then
			if not ni.player.isdisarmed() then
                if ni.spell.shouldinterrupt("target")
                or ni.unit.ischanneling("target") then
                    if ni.spell.cd(A1.PWtalents.ShieldBash) == 0
                    and ni.player.power() >= 10
                    and A1.PlayerCanAttack() then
                        return ni.spell.cast(A1.PWtalents.ShieldBash)
                    end
                end
            end
		end
	end,
	["Companion"] = function()
        local creatureID, creatureName, creatureSpellID, icon, issummoned, mountTypeID = GetCompanionInfo("CRITTER", 68658);
		--if issummoned == nil then
            if not ni.spell.gcd() then
                return CallCompanion("CRITTER", 135268)
            end
        --end
	end,
	["Offensive_revenge"] = function()
		if IsUsableSpell(A1.PWtalents.Revenge) then
            if ni.spell.available(A1.PWtalents.Revenge)
            and A1.PlayerCanAttack() then
                return ni.spell.cast(A1.PWtalents.Revenge)
            end
        end
	end,
	["Offensive_crush (debuff stack)"] = function()
        if ni.unit.isboss("target") then
            if ni.spell.cd(A1.PWtalents.ShockWave) ~= 0
            and ni.spell.cd(A1.PWtalents.PowerfulShieldBash) ~= 0 then
                if (ni.unit.debuffremaining("target", A1.PWtalents.SunderArmor) < 12
                or ni.unit.debuffstacks("target", A1.PWtalents.SunderArmor) < 5) then
                    if ni.spell.available(A1.PWtalents.Crush)
                    and A1.PlayerCanAttack() then
                        return ni.spell.cast(A1.PWtalents.Crush)
                    end
                end
            end
        end
	end,
	["Offensive_crush"] = function()
        if ni.spell.available(A1.PWtalents.Crush)
        and A1.PlayerCanAttack() then
            return ni.spell.cast(A1.PWtalents.Crush)
        end
	end,
	["Offensive_bloodletting"] = function ()
		if ni.unit.debuffstacks("target", A1.PWtalents.SunderArmor) == 5 then
			if ni.unit.creaturetype("target") ~= 9 and #agressiveenemies == 1 then
                if ni.spell.available(A1.PWtalents.Bloodletting) then
                    if (not ni.unit.debuff("target", A1.PWtalents.Bloodletting) or ni.unit.debuffremaining("target", A1.PWtalents.Bloodletting) <= 3)
                    and A1.PlayerCanAttack() then
                        return ni.spell.cast(A1.PWtalents.Bloodletting)
                    end
                end
            end
		end
	end,
	["Offensive_demoralizingshout"] = function ()
		if ni.unit.isboss("target") then
            if ni.spell.available(A1.PWtalents.DemoralizingShout)
			and A1.PlayerCanAttack() then
                if not ni.unit.debuff("target", A1.PWtalents.DemoralizingShout) or ni.unit.debuffremaining("target", A1.PWtalents.DemoralizingShout) <= 5 then
                    return ni.spell.cast(A1.PWtalents.DemoralizingShout)
                end
            end
		end
	end,
	["Offensive_bloodfury"] = function()
        if ni.spell.cd(A1.PWtalents.Bloodfury) == 0 and ni.player.hp() >= 20
		and A1.PlayerCanAttack() then
            if UnitAffectingCombat("player")
            and ni.player.power() < 65 then
                return ni.spell.cast(A1.PWtalents.Bloodfury)
            end
		end
	end,
	["Offensive_cleavestrike"] = function ()
		if not ni.player.isdisarmed() then
            if not IsCurrentSpell(A1.PWtalents.CleaveStrike) then
                if ni.player.power() >= 30
                and A1.PlayerCanAttack() then
                    if #agressiveenemies >= 2 then
                        return ni.spell.cast(A1.PWtalents.CleaveStrike)
                    end
                end
            end
        end
	end,
	["Offensive_herostrike"] = function ()
		if not ni.player.isdisarmed() then
            if not IsCurrentSpell(A1.PWtalents.HeroStrike) then
                if (ni.player.buff(A1.PWtalents.FreeHeroStrikeBuff) or ni.player.power() >= 40)
                and A1.PlayerCanAttack() then
                    if #agressiveenemies == 1  then
                        return ni.spell.cast(A1.PWtalents.HeroStrike)
                    end
                end
            end
        end
	end,
	["Taunt_provoke"] = function()
		local _, taunts_enabled = GetSetting("k_taunts")
        if ni.spell.cd(A1.PWtalents.Provoke) == 0
        and UnitAffectingCombat("player") then
            highrangeenemies = ni.player.enemiesinrange(29)
            for _, ProtectFriend in ipairs(ni.members) do
                for TauntEnemy in ipairs(highrangeenemies) do
                    local lowthreatunit = highrangeenemies[TauntEnemy].guid
                    if taunts_enabled then
                        --if ni.drtracker.get(lowthreatunit, "Taunts") ~= 0 then
                            if not Tank(ProtectFriend.unit)
                            --and ni.player.threat(lowthreatunit) ~= 3
                            --and ni.unit.threat("focus", lowthreatunit) ~= 3
                            and UnitAffectingCombat(lowthreatunit)
                            --and not (UnitIsUnit(ProtectFriend.unit, "focus") or UnitIsUnit(lowthreatunit, "focus"))
                            and ni.unit.threat(ProtectFriend.unit, lowthreatunit) == 3
                            --and not ni.unit.isplayer(lowthreatunit)
                            and (not (ni.unit.buff(lowthreatunit, 12021) or ni.unit.debuff(lowthreatunit, A1.PWtalents.TeasingStrike) or ni.unit.debuff(lowthreatunit, A1.PWtalents.MassAgro) or ni.unit.debuff(lowthreatunit, A1.PWtalents.Provoke)))
                            and BlackListedMonster(lowthreatunit)
                            and BlackListedMonsterWithDebuff(lowthreatunit) then
                                if ni.spell.valid(lowthreatunit, A1.PWtalents.Provoke, false, true, false) then
                                    lasttaunt = GetTime()
                                    ni.spell.cast(A1.PWtalents.Provoke, lowthreatunit)
                                    return true
                                end
                            end
                        --end
                    end
                end
			end
		end
	end,
	["Defensive_SpellReflection"] = function()
        if UnitAffectingCombat("player")
        and ni.spell.cd(A1.PWtalents.SpellReflection) == 0
        and ni.player.power() > 35 then
            highrangeenemies = ni.player.enemiesinrange(29)
            for CastingEnemy in ipairs(highrangeenemies) do
                local refunit = highrangeenemies[CastingEnemy].guid
                if ni.unit.castingpercent(refunit) > 50
                and ni.unit.unitstargeting(refunit, "player")
                and not UnitIsUnit(refunit, "target") then
                    ni.spell.cast(A1.PWtalents.SpellReflection)
                    return true
                end
			end
		end
	end,
	["Taunt_heroicthrow"] = function()
		local _, taunts_enabled = GetSetting("k_taunts")
		if ni.spell.cd(A1.PWtalents.Provoke) ~= 0
        and GetTime() - lasttaunt > 1 then
            if ni.spell.available(A1.PWtalents.HeroicThrow)
            and UnitAffectingCombat("player") then
                highrangeenemies = ni.player.enemiesinrange(29)
                for _, ProtectFriend in ipairs(ni.members) do
                    for TauntEnemy in ipairs(highrangeenemies) do
                        local lowthreatunit = highrangeenemies[TauntEnemy].guid
                        if taunts_enabled then
                            --if ni.drtracker.get(lowthreatunit, "Taunts") ~= 0 then
                                if not Tank(ProtectFriend.unit)
                                --and ni.player.threat(lowthreatunit) ~= 3
                                --and ni.unit.threat("focus", lowthreatunit) ~= 3
                                and UnitAffectingCombat(lowthreatunit)
                                --and not (UnitIsUnit(ProtectFriend.unit, "focus") or UnitIsUnit(lowthreatunit, "focus"))
                                --and not ni.unit.isplayer(lowthreatunit)
                                and ni.unit.threat(ProtectFriend.unit, lowthreatunit) == 3
                                and (not (ni.unit.buff(lowthreatunit, 12021) or ni.unit.debuff(lowthreatunit, A1.PWtalents.TeasingStrike) or ni.unit.debuff(lowthreatunit, A1.PWtalents.MassAgro) or ni.unit.debuff(lowthreatunit, A1.PWtalents.Provoke)))
                                and BlackListedMonster(lowthreatunit)
                                and BlackListedMonsterWithDebuff(lowthreatunit) then
                                    if ni.spell.valid(lowthreatunit, A1.PWtalents.HeroicThrow, true, true, false) then
                                        lasttaunt = GetTime()
                                        ni.spell.cast(A1.PWtalents.HeroicThrow, lowthreatunit)
                                        return true
                                    end
                                end
                            --end
                        end
                    end
                end
            end
        end
	end,
	["Taunt_teasingstrike"] = function()
		local _, taunts_enabled = GetSetting("k_taunts")
		if ni.spell.cd(A1.PWtalents.Provoke) ~= 0
        and GetTime() - lasttaunt > 1 then
            if ni.spell.available(A1.PWtalents.TeasingStrike)
            and UnitAffectingCombat("player") then
                agressiveenemies = ni.player.enemiesinrange(3)
                for _, ProtectFriend in ipairs(ni.members) do
                    for TauntEnemy in ipairs(agressiveenemies) do
                        local lowthreatunit = agressiveenemies[TauntEnemy].guid
                        if taunts_enabled then
                            --if ni.drtracker.get(lowthreatunit, "Taunts") ~= 0 then
                                if not Tank(ProtectFriend.unit)
                                --and ni.player.threat(lowthreatunit) ~= 3
                                --and ni.unit.threat("focus", lowthreatunit) ~= 3
                                and UnitAffectingCombat(lowthreatunit)
                                --and not (UnitIsUnit(ProtectFriend.unit, "focus") or UnitIsUnit(lowthreatunit, "focus"))
                                --and not ni.unit.isplayer(lowthreatunit)
                                and ni.unit.threat(ProtectFriend.unit, lowthreatunit) == 3
                                and (not (ni.unit.buff(lowthreatunit, 12021) or ni.unit.debuff(lowthreatunit, A1.PWtalents.TeasingStrike) or ni.unit.debuff(lowthreatunit, A1.PWtalents.MassAgro) or ni.unit.debuff(lowthreatunit, A1.PWtalents.Provoke)))
                                and BlackListedMonster(lowthreatunit)
                                and BlackListedMonsterWithDebuff(lowthreatunit) then
                                    if A1.PlayerCanAttack() then
                                        lasttaunt = GetTime()
                                        ni.spell.cast(A1.PWtalents.TeasingStrike, lowthreatunit)
                                        return true
                                    end
                                end
                            --end
                        end
                    end
                end
            end
        end
	end,
	["Taunt_vigilance"] = function ()
		if UnitAffectingCombat("player")
		and ni.spell.available(A1.PWtalents.Vigilance)
        and ni.spell.cd(A1.PWtalents.PowerfulShieldBash) ~= 0
        and ni.spell.cd(A1.PWtalents.ShockWave) ~= 0
        and ni.spell.cd(A1.PWtalents.Thunderclap) ~= 0 then
			for _, ProtectFriend in ipairs(ni.members) do
				if not Tank(ProtectFriend.unit)
                and ni.unit.threat(ProtectFriend.unit) >= 1
				and ni.unit.isplayer(ProtectFriend.unit) then
                    if not ni.unit.buff(ProtectFriend.unit, A1.PWtalents.Vigilance) then
                        if ni.spell.valid(ProtectFriend.unit, A1.PWtalents.Vigilance, false, true, true) then
                            ni.spell.cast(A1.PWtalents.Vigilance, ProtectFriend.unit)
                            return true
                        end
                    end
				end
			end
		end
	end,
	["Taunt_massagro"] = function ()
		local _, taunts_enabled = GetSetting("k_taunts")
		if taunts_enabled then
			if ni.spell.available(A1.PWtalents.MassAgro) then
                if #agressiveenemies >= 12 then
				    return ni.spell.cast(A1.PWtalents.MassAgro)
                end
			end
		end
	end,
	["Stun_stunningstrike"] = function ()
		local _, stuns_enabled = GetSetting("k_stuns")
		if stuns_enabled then
            if ni.spell.available(A1.PWtalents.StunningStrike) then
                if (ni.unit.iscasting("target") or ni.unit.ischanneling("target")) then
                    if A1.PlayerCanAttack() then
                        return ni.spell.cast(A1.PWtalents.StunningStrike)
                    end
                end
            end
		end
	end,
	["Stun_shockwave"] = function ()
		local _, stuns_enabled = GetSetting("k_stuns")
		if stuns_enabled then
            if ni.spell.available(A1.PWtalents.ShockWave)
            and ni.spell.cd(A1.PWtalents.StunningStrike) ~= 0 then
                if not ni.unit.isboss("target")
                and UnitLevel("target") < 83 then
                    if (ni.unit.iscasting("target") or ni.unit.ischanneling("target"))
                    and A1.PlayerCanAttack() then
                        return ni.spell.cast(A1.PWtalents.ShockWave)
                    end
                end
            end
		end
	end,
	["Offensive_shockwave"] = function ()
		local _, stuns_enabled = GetSetting("k_stuns")
		if stuns_enabled then
            if ni.spell.available(A1.PWtalents.ShockWave)
            and ni.spell.cd(A1.PWtalents.Thunderclap) ~= 0 then
                if A1.PlayerCanAttack() then
                    return ni.spell.cast(A1.PWtalents.ShockWave)
                end
			end
		end
	end,
	["OIL"] = function()
        if UnitInRaid("player")
        and not UnitAffectingCombat("player") then
            if not ni.player.ismoving()
            and not ni.player.buff(317728)
            and not UnitCastingInfo("player") then
                if ni.player.hasitem(154170)
                and GetItemCount(154170, false, false) > 10
                and ni.player.itemcd(154170) == 0 then
                    ni.player.useitem(154170)
                    ni.player.useinventoryitem(5)
                    return true
                end
            end
        end
	end,
    ["fish"] = function ()
        local cast, _, _, _, castStartTime, castEndTime = UnitCastingInfo("player")
        if ni.player.iscasting()
        and cast == "Рыбный пир" then
            local timeSinceStart = (GetTime() * 1000 - castStartTime) / 1000
            local casttime = castEndTime - castStartTime - select(3, GetNetStats())
            local currentpercent = timeSinceStart / casttime * 100000
            if currentpercent > 80
            and currentpercent < 97 then
                return ni.player.runtext("/с Садитесъ жратъ, пожалуйста!")
            end
        end
    end,
    ["Defib"] = function ()
        local cast, _, _, _, castStartTime, castEndTime = UnitCastingInfo("player")
        if ni.player.iscasting()
        and cast == "Дефибриллировать" then
            local timeSinceStart = (GetTime() * 1000 - castStartTime) / 1000
            local casttime = castEndTime - castStartTime - select(3, GetNetStats())
            local currentpercent = timeSinceStart / casttime * 100000
            if currentpercent > 1
            and currentpercent < 8 then
                ni.player.runtext("/с Пытаюсь вернуть в чувства %t !")
            end
            if currentpercent > 25
            and currentpercent < 29 then
                ni.player.runtext("/с 3 !")
            end
            if currentpercent > 50
            and currentpercent < 54 then
                ni.player.runtext("/с 2 !")
            end
            if currentpercent > 75
            and currentpercent < 79 then
                ni.player.runtext("/с 1 !")
            end
            if currentpercent > 96
            and currentpercent < 100 then
                ni.player.runtext("/с Разряд !!!")
            end
        end
    end,
    ["backing"] = function ()
        local cast, _, _, _, castStartTime, castEndTime = UnitCastingInfo("player")
        if ni.player.iscasting()
        and cast == "Камень возвращения" then
            local timeSinceStart = (GetTime() * 1000 - castStartTime) / 1000
            local casttime = castEndTime - castStartTime - select(3, GetNetStats())
            local currentpercent = timeSinceStart / casttime * 100000
            if currentpercent > 1
            and currentpercent < 3 then
                ni.player.runtext("/с Попытка покинуть локацию...")
                return true
            end
            if currentpercent > 60
            and currentpercent < 62 then
                ni.player.runtext("/с 3...")
                return true
            end
            if currentpercent > 70
            and currentpercent < 72 then
                ni.player.runtext("/с 2...")
                return true
            end
            if currentpercent > 80
            and currentpercent < 82 then
                ni.player.runtext("/с 1...")
                return true
            end
            if currentpercent > 93
            and currentpercent < 95 then
                ni.player.runtext("/с Пока...")
                return true
            end
        end
    end,
	["clean"] = function()
        if not UnitAffectingCombat("player")
        and ni.player.hp() >= 99 then
            if ni.player.aura(48441) then
                return CancelUnitBuff("player", 48441)
            end
            if ni.player.aura(48443) then
                return CancelUnitBuff("player", 48443)
            end
            if ni.player.aura(48451) then
                return CancelUnitBuff("player", 48451)
            end
        end
	end,
}
ni.bootstrap.profile("PROTO PvE A1 2.2", PWrotation, PWfunctions, OnLoad, OnUnLoad)