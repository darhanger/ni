local dontdispel = { 60814, 69674, 68786, 34916, 34917, 34919, 48159, 48160, 30404, 30405, 31117, 34438, 35183, 43522, 47841, 47843, 65812, 68154, 68155, 68156, 44461, 55359, 55360, 55361, 55362, 61429, 30108, 34914, 74562, 74792, 70867, 70338, 70405 }
for _, v in pairs(dontdispel) do
	ni.healing.debufftoblacklist(v)
end
local InnerFire = GetSpellInfo(48168)
local AntiFear = GetSpellInfo(6346)
local Confession = GetSpellInfo(53007)
local PainSuppression = GetSpellInfo(33206)
local DispellingSpells = GetSpellInfo(988)
local WordShield = GetSpellInfo(48066)
local Weakness = GetSpellInfo(6788)
local FastHealing = GetSpellInfo(48071)
local Renew = GetSpellInfo(48068)
local prayerofmending = GetSpellInfo(33076)
local DespairPrayer = GetSpellInfo(48172)
local Fear = GetSpellInfo(10890)
local LastDispel = 0
local order = {
"Pause",
"Trink2",
"Trink",
"Fearing",
"Mob",
"Ring",
"fastpowerheal",
"Healthstone",
"Buffs",
"InnerFire",
"Empower",
"AntiFear",
"PainSuppression",
"DespairPrayer",
"PrayerOfMending",
"WordShield",
"Cleansing",
"Confession",
"Renew",
"FastHealing",
}
local moves = {
["Pause"] = function()
	if IsMounted()
	or UnitInVehicle("player")
	or ni.player.buff(GetSpellInfo(430))
	or ni.player.buff(GetSpellInfo(433))
	or ni.player.isconfused()
	or ni.player.isfleeing()
	or ni.player.isstunned()
	or UnitIsDeadOrGhost("player")
	or IsLeftShiftKeyDown() then
		return true
	end
end,
["InnerFire"] = function()
    if not ni.player.buff(InnerFire)
    and ni.spell.available(InnerFire) then
		ni.spell.cast(InnerFire)
	end
end,
["Buffs"] = function()
    if not ni.player.buff(48074)
    and ni.spell.available(48074) then
		ni.spell.cast(48074)
	end
    if not ni.player.buff(48162)
    and ni.spell.available(48162) then
		ni.spell.cast(48162)
	end
    if not ni.player.buff(48170)
    and ni.spell.available(48170) then
		ni.spell.cast(48170)
	end
end,
["Empower"] = function()
    if UnitAffectingCombat("player")
	and ni.player.power() <= 70
    and ni.player.power() > 10
	and ni.spell.available(10060) then
		ni.spell.cast(10060)
	end
end,
["fastpowerheal"] = function()
    if UnitAffectingCombat("player")
	and ni.player.hp() <= 40
	and ni.spell.available(14751)
	and ni.spell.available(48063) then
		ni.spell.castspells(14751, 48063, "player")
	end
end,
["AntiFear"] = function()
    if not ni.player.buff(AntiFear)
    and ni.spell.available(AntiFear) then
		ni.spell.cast(AntiFear, "player")
    end
end,
["Ring"] = function()
    if UnitAffectingCombat("player")
	and ni.player.hp() <= 25
    and ni.spell.available(48078) then
		ni.spell.cast(48078)
    end
end,
["WordShield"] = function()
    if ni.spell.available(WordShield) then
		for i = 1, #ni.members do
			if UnitAffectingCombat(ni.members[i].unit)
			and ni.members[i].hp <= 80
   		 	and not ni.unit.debuff(ni.members[i].unit, Weakness)
			and not ni.unit.buff(ni.members[i].unit, WordShield)
			and ni.spell.valid(ni.members[i].unit, WordShield, false, true, true) then
				ni.spell.cast(WordShield, ni.members[i].unit)
			end
		end
	end
end,
["Cleansing"] = function()
	if ni.spell.available(DispellingSpells)
	and GetTime() - LastDispel > 2.3 then
		for i = 1, #ni.members do
			if ni.healing.candispel(ni.members[i].unit)
			and ni.spell.valid(ni.members[i].unit, DispellingSpells, false, true, true) then
				ni.spell.cast(DispellingSpells, ni.members[i].unit)
				LastDispel = GetTime()
			end
		end
	end
end,
["PainSuppression"] = function()
    if ni.spell.available(PainSuppression)
	and UnitAffectingCombat("player")
	and ni.player.hp() <= 50 then
		ni.spell.cast(PainSuppression, "player")
	end
end,
["Confession"] = function()
    if ni.spell.available(Confession)
	and not ni.player.ismoving() then
	    for i = 1, #ni.members do
			if ni.members[i].hp <= 70
			and ni.spell.valid(ni.members[i].unit, Confession, false, true, true) then
				ni.spell.cast(Confession, ni.members[i].unit)
			end
		end
	end
end,
["FastHealing"] = function()
    if ni.spell.available(FastHealing)
	and not ni.player.ismoving() then
		for i = 1, #ni.members do
			if ni.members[i].hp <= 70
			and ni.spell.valid(ni.members[i].unit, FastHealing, false, true, true) then
				ni.spell.cast(FastHealing, ni.members[i].unit)
			end
		end
	end
end,
["Renew"] = function()
    if ni.spell.available(Renew) then
		for i = 1, #ni.members do
			if ni.members[i].hp <= 85
			and not ni.unit.buff(ni.members[i].unit, Renew)
			and ni.spell.valid(ni.members[i].unit, Renew, false, true, true) then
				ni.spell.cast(Renew, ni.members[i].unit)
			end
		end
	end
end,
["PrayerOfMending"] = function()
	if ni.spell.available(prayerofmending) then
		for i = 1, #ni.members do
			if UnitAffectingCombat(ni.members[i].unit)
			and ni.members[i].hp < 85
			and not ni.unit.buff(ni.members[i].unit, prayerofmending, "player")
			and ni.spell.valid(ni.members[i].unit, prayerofmending, false, true, true) then
				ni.spell.cast(prayerofmending, ni.members[i].unit)
			end
		end
	end
end,
["DespairPrayer"] = function()
	if UnitAffectingCombat("player")
    and ni.player.hp() < 35
	and ni.spell.available(DespairPrayer) then
		ni.spell.cast(DespairPrayer)
	end
end,
["Mob"] = function()
	if UnitAffectingCombat("player")
    and ni.player.power() < 65
	and ni.spell.available(34433)
	and ni.spell.valid("target", 48123, false, true, false) then
		ni.spell.cast(34433)
	end
end,
["Healthstone"] = function()
	local hstones = { 36892, 36893, 36894 }
	for i = 1, #hstones do
		if UnitAffectingCombat("player")
		and ni.player.hp() < 50
		and ni.player.hasitem(hstones[i])
		and ni.player.itemcd(hstones[i]) == 0 then
			ni.player.useitem(hstones[i])
		end
	end
end,
["Fearing"] = function()
	local Enemies = ni.player.enemiesinrange(6)
	if ni.spell.available(Fear) then
		for i = 1, #Enemies do
			local ENEMY = Enemies[i].guid
			if not ni.unit.istotem(ENEMY)
			and ni.unit.isplayer(ENEMY) then
				ni.spell.cast(Fear)
			end
		end
	end
end,
["Trink"] = function()
	if UnitAffectingCombat("player")
	and ni.player.hasitem(103400)
	and ni.player.itemcd(103400) == 0
	and ni.player.hp() <= 60 then
		ni.player.useitem(103400, "player")
	end
end,
["Trink2"] = function()
	if UnitAffectingCombat("player")
	and ni.player.hasitem(42122)
	and ni.player.itemcd(42122) == 0
	and (ni.player.isconfused() or ni.player.isfleeing()) then
		ni.player.useitem(42122)
	end
end,
}
ni.bootstrap.rotation("Scripter", order, moves)