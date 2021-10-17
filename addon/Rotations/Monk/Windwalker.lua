local queue = {
	"cache",
	"resuscitate",
	"stance of the fierce tiger",
	"legacy of the emperor",
	"legacy of the white tiger",
	"expel harm",
	"detox",
	"defensive",
	"pause",
	"energizing brew",
	"tigereye brew",
	"touch of death",
	"tiger palm",
	"rising sun kick",
	"invoke xuen",
	"fists of fury",
	"chi wave",
	"blackout kick",
	"jab",
	"spinning crane kick"
}
--Localize global functions
local GetSpellInfo, GetShapeshiftFormID = GetSpellInfo, GetShapeshiftFormID
--Spells localized
local blackoutkick = GetSpellInfo(100784)
local chiwave = GetSpellInfo(115098)
local cracklingjadelightning = GetSpellInfo(117952)
local dampenharm = GetSpellInfo(122278)
local disable = GetSpellInfo(116095)
local detox = GetSpellInfo(115450)
local energizingbrew = GetSpellInfo(115288)
local expelharm = GetSpellInfo(115072)
local fistsoffury = GetSpellInfo(113656)
local fortifyingbrew = GetSpellInfo(115203)
local grappleweapon = GetSpellInfo(117368)
local invokexuen = GetSpellInfo(123904)
local jab = GetSpellInfo(108557)
local legacyoftheemperor = GetSpellInfo(115921)
local legsweep = GetSpellInfo(119381)
local legacyofthewhitetiger = GetSpellInfo(116781)
local nimblebrew = GetSpellInfo(137562)
local paralysis = GetSpellInfo(115078)
local provoke = GetSpellInfo(115546)
local quakingpalm = GetSpellInfo(107079)
local resuscitate = GetSpellInfo(115178)
local roll = GetSpellInfo(109132)
local risingsunkick = GetSpellInfo(107428)
local spinningcranekick = GetSpellInfo(101546)
local spinningfireblossom = GetSpellInfo(115073)
local stanceofthefiercetiger = GetSpellInfo(103985)
local tigereyebrew = GetSpellInfo(116740)
local tigerpalm = GetSpellInfo(100787)
local touchofdeath = GetSpellInfo(115080)
local touchofkarma = GetSpellInfo(122470)
local zensphere = GetSpellInfo(124081)

local UnitAffectingCombat, UnitExists, UnitCastingInfo, UnitChannelInfo, UnitIsDeadOrGhost, UnitHealth, UnitHealthMax =
	UnitAffectingCombat,
	UnitExists,
	UnitCastingInfo,
	UnitChannelInfo,
	UnitIsDeadOrGhost,
	UnitHealth,
	UnitHealthMax

local cache = {
	mounted = false,
	coc = false,
	dog = false,
	eod = false,
	combat = false,
	tod = false,
	tigerpower = 0
}

local function TouchOfDeathCheck()
	if UnitExists("target") then
		if
			ni.spell.cd(touchofdeath) == 0 and not UnitIsPlayer("target") and not UnitIsDeadOrGhost("target") and
				UnitCanAttack("player", "target") and
				(ni.player.buff(121125) or UnitHealth("target") < UnitHealthMax("player")) and
				(ni.player.hasglyph(123391) or ni.player.powerraw("chi") >= 3)
		 then
			return true
		end
	end
	return false
end

local abilities = {
	["cache"] = function()
		cache.mounted = IsMounted() or false
		cache.coc = UnitCastingInfo("player") or UnitChannelInfo("player") or false
		cache.dog = UnitIsDeadOrGhost("player") or false
		cache.eod = ni.player.buffs("104934||104269") or false
		cache.combat = UnitAffectingCombat("player") or false
		cache.tod = TouchOfDeathCheck()
		cache.tigerpower = ni.player.buffremaining(125359)
	end,
	["resuscitate"] = function()
		if ni.spell.available(resuscitate) then
			if UnitExists("mouseover") and not cache.coc and ni.spell.valid("mouseover", resuscitate, false, true, true) then
				ni.spell.cast(resuscitate, "mouseover")
				return true
			end
		end
	end,
	["legacy of the emperor"] = function()
		if ni.spell.available(legacyoftheemperor) then
			if
				not cache.mounted and not cache.coc and not cache.dog and not cache.eod and
					not ni.player.buffs("115921||20217||1126||90363")
			 then
				ni.spell.cast(legacyoftheemperor, "player")
				return true
			end
		end
	end,
	["legacy of the white tiger"] = function()
		if ni.spell.available(legacyofthewhitetiger) then
			if
				not cache.mounted and not cache.coc and not cache.dog and not cache.eod and
					not ni.player.buffs("116781||17007||1459||61316||24604||90309||126373||126309")
			 then
				ni.spell.cast(legacyofthewhitetiger, "player")
				return true
			end
		end
	end,
	["stance of the fierce tiger"] = function()
		if ni.spell.available(stanceofthefiercetiger) then
			if not cache.mounted and not cache.coc and not cache.dog and not cache.eod and GetShapeshiftFormID() ~= 24 then
				ni.spell.cast(stanceofthefiercetiger, "player")
				return true
			end
		end
	end,
	["expel harm"] = function()
		if ni.spell.available(expelharm) then
			if
				not cache.mounted and not cache.tod and ni.player.power("energy") >= 40 and ni.player.powerraw("chi") <= 3 and
					ni.player.hp() < 80
			 then
				ni.spell.cast(expelharm)
				return true
			end
		end
	end,
	["detox"] = function()
		if ni.spell.available(detox) then
			if not cache.mounted and ni.healing.candispel("mouseover") and ni.spell.valid("mouseover", detox, false, true, true) then
				ni.spell.cast(detox, "mouseover")
				return true
			end
		end
	end,
	["defensive"] = function()
		if not cache.mounted and not cache.dog then
			local playerhp = ni.player.hp()
			if select(2, GetTalentRowSelectionInfo(2)) == 5 then
				local zensphereremaining = ni.player.buffremaining(124081)
				if zensphereremaining <= 1 and ni.spell.cd(zensphere) == 0 then
					if
						ni.members[1].hp < playerhp and not ni.unit.debuff(ni.members[1].unit, 137341) and
							ni.spell.los(ni.members[1].unit)
					 then
						ni.spell.cast(zensphere, ni.members[1].unit)
						return true
					elseif playerhp <= 75 then
						ni.spell.cast(zensphere, "player")
						return true
					end
				end
			end
			if ni.spell.available(dampenharm) then
				if playerhp <= 75 then
					ni.spell.cast(dampenharm)
					return true
				end
			end
			if ni.spell.available(touchofkarma) then
				if playerhp <= 50 and ni.spell.valid("target", touchofkarma, false, true) then
					ni.spell.cast(touchofkarma, "target")
					return true
				end
			end
			if ni.spell.available(fortifyingbrew, true) then
				if playerhp <= 40 then
					ni.spell.cast(fortifyingbrew)
					return true
				end
			end
			if playerhp < 30 and GetItemCount(5512, false, false) > 0 and ni.player.itemcd(5512) == 0 then
				ni.player.useitem(5512)
				return true
			end
		end
	end,
	["pause"] = function()
		if
			cache.mounted or cache.coc or cache.eod or cache.dog or not cache.combat or not UnitExists("target") or
				UnitIsDeadOrGhost("target") or
				ni.unit.buff("target", 117961)
		 then
			return true
		end
	end,
	["energizing brew"] = function()
		if
			not cache.tod and ni.spell.available(energizingbrew) and
				(UnitPowerMax("player") - UnitPower("player")) * (1.0 / select(2, GetPowerRegen("player"))) > 5
		 then
			ni.spell.cast(energizingbrew)
			return true
		end
	end,
	["tigereye brew"] = function()
		if not cache.tod and ni.spell.available(tigereyebrew, true) then
			local tebr = ni.player.buffremaining(116740, "EXACT")
			local teb = select(4, ni.player.buff(125195)) or 0
			if
				tebr < 1 and ni.spell.cd(risingsunkick) == 0 and ni.unit.buffremaining("target", risingsunkick, "player") > 0 and
					ni.player.powerraw("chi") >= 2 and
					cache.tigerpower > 0 and
					teb > 0
			 then
				ni.spell.cast(tigereyebrew)
				return true
			end
			if tebr < 1 and teb >= 10 then
				ni.spell.cast(tigereyebrew)
				return true
			end
		end
	end,
	["touch of death"] = function()
		if ni.spell.available(touchofdeath) and ni.spell.valid("target", touchofdeath, true, true) then
			if ni.spell.cd(fortifyingbrew) == 0 then
				local targethp = UnitHealth("target")
				local playerhpmax = UnitHealthMax("player")
				if targethp > playerhpmax and targethp <= (playerhpmax * 0.2 + playerhpmax) then
					ni.spell.cast(fortifyingbrew)
					ni.spell.cast(touchofdeath)
					return true
				end
			end
			if cache.tod then
				ni.spell.cast(touchofdeath)
				return true
			end
		end
	end,
	["tiger palm"] = function()
		if ni.spell.available(tigerpalm) then
			if ni.spell.valid("target", tigerpalm, true, true) and not cache.tod then
				local chi = ni.player.powerraw("chi")
				if chi >= 1 and cache.tigerpower <= 3 then
					ni.spell.cast(tigerpalm)
					return true
				end
				local rskremaining = ni.unit.debuffremaining("target", 130320, "player")
				local energy = (UnitPowerMax("player") - UnitPower("player")) * (1.0 / select(2, GetPowerRegen("player")))
				if chi >= 1 and cache.tigerpower == 0 and rskremaining > 1 and energy > 1 then
					ni.spell.cast(tigerpalm)
					return true
				end
				local combatbreaker = ni.player.buffremaining(118864)
				if (combatbreaker > 0 and energy >= 2) or (combatbreaker <= 2 and combatbreaker > 0) then
					ni.spell.cast(tigerpalm)
					return true
				end
			end
		end
	end,
	["rising sun kick"] = function()
		if ni.spell.available(risingsunkick) then
			if not cache.tod and cache.tigerpower > 1 and ni.spell.valid("target", risingsunkick, true, true) then
				ni.spell.cast(risingsunkick)
				return true
			end
		end
	end,
	["invoke xuen"] = function()
		if ni.spell.available(invokexuen) then
			if ni.unit.isboss("target") and IsSpellInRange(jab, "target") == 1 then
				ni.spell.cast(invokexuen)
				return true
			end
		end
	end,
	["fists of fury"] = function()
		if ni.spell.available(fistsoffury) then
			if
				ni.spell.cd(risingsunkick) >= 2 and IsSpellInRange(jab, "target") == 1 and ni.player.powerraw("energy") <= 30 and
					not cache.tod and
					cache.tigerpower > 4 and
					(UnitPowerMax("player") - UnitPower("player")) * (1.0 / select(2, GetPowerRegen("player"))) > 3 and
					not ni.player.buff(energizingbrew) and
					not ni.player.ismoving()
			 then
				ni.spell.cast(fistsoffury)
				return true
			end
		end
	end,
	["chi wave"] = function()
		if ni.spell.available(chiwave) then
			if not cache.tod and ni.spell.valid("target", chiwave, true, true) then
				ni.spell.cast(chiwave)
				return true
			end
		end
	end,
	["blackout kick"] = function()
		if ni.spell.available(blackoutkick) then
			if ni.spell.valid("target", blackoutkick, true, true) and not cache.tod and not ni.vars.combat.aoe then
				local breaker = ni.player.buff(116768)
				if ni.player.powerraw("chi") >= 2 or breaker then
					if breaker then
						ni.spell.cast(blackoutkick)
						return true
					end
					if (UnitPower("player") + (select(2, GetPowerRegen("player")) * ni.spell.cd(risingsunkick))) >= 40 then
						ni.spell.cast(blackoutkick)
						return true
					end
				end
			end
		end
	end,
	["jab"] = function()
		if
			not cache.tod and ni.spell.available(jab) and ni.spell.valid("target", jab, true, true) and UnitPower("player") >= 40
		 then
			local chi = ni.player.powerraw("chi")
			if ni.vars.combat.aoe then
				if chi < 2 and ni.unit.debuffremaining("target", risingsunkick, "player") <= 1 then
					ni.spell.cast(jab)
					return true
				end
				if chi < 1 and cache.tigerpower <= 1 then
					ni.spell.cast(jab)
					return true
				end
			else
				if chi <= 2 and (ni.player.hp() >= 80 or ni.spell.cd(expelharm) ~= 0) then
					ni.spell.cast(jab)
					return true
				end
			end
		end
	end,
	["spinning crane kick"] = function()
		if ni.spell.available(spinningcranekick) then
			if
				ni.vars.combat.aoe and not cache.tod and not ni.player.buff(spinningcranekick) and UnitPower("player") >= 40 and
					IsSpellInRange(jab, "target") == 1 and
					cache.tigerpower > 1 and
					ni.unit.debuffremaining("target", risingsunkick, "player") > 1
			 then
				ni.spell.cast(spinningcranekick)
				return true
			end
		end
	end
}
ni.bootstrap.rotation("Windwalker", queue, abilities)
