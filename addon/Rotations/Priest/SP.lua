local dontdispel = { 60814, 69674, 68786, 34916, 34917, 34919, 48159, 48160, 30404, 30405, 31117, 34438, 35183, 43522, 47841, 47843, 65812, 68154, 68155, 68156, 44461, 55359, 55360, 55361, 55362, 61429, 30108, 34914, 74562, 74792, 70867, 70338, 70405 };
for _, v in pairs(dontdispel) do
	ni.healing.debufftoblacklist(v)
end
local InnerFire = GetSpellInfo(48168)
local AntiFear = GetSpellInfo(6346)
local WordShield = GetSpellInfo(48066)
local Weakness = GetSpellInfo(6788)
local Renew = GetSpellInfo(48068)
local Fear = GetSpellInfo(10890)
local LastAction, LastVamp = 0, 0;
local dlay = 0.9;
local BadBuff = {45438, 642, 20230, 33786, 47585, 19263};
local order = {
"Pause",
"DARKIN",
--"TargetPidor",
"Trink2",
"Trink",
"inDARKIN",
"Fearing",
"Mob",
"Healthstone",
"Buffs",
"InnerFire",
"AntiFear",
"WordShield",
"olokol",
"Death",
"MindBlow",
"Punish",
"Baaaaad",
"Pain",
"Vamp",
}
local moves = {
["Pause"] = function()
	if IsMounted()
    or ni.player.buff(430)
    or ni.player.buff(433)
    or ni.player.iscasting()
    or ni.player.ischanneling()
    or UnitIsDeadOrGhost("player")
	or IsLeftShiftKeyDown() then
		return true
	end
end,
["InnerFire"] = function()
    if not ni.player.buff(InnerFire)
    and ni.spell.available(InnerFire)
    and GetTime() - LastAction >= dlay then
		ni.spell.cast(InnerFire)
		LastAction = GetTime()
	end
end,
["Buffs"] = function()
    if not ni.player.buff(48074)
    and ni.spell.available(48074)
    and GetTime() - LastAction >= dlay then
		ni.spell.cast(48074)
		LastAction = GetTime()
	end
    if not ni.player.buff(48162)
    and ni.spell.available(48162)
    and GetTime() - LastAction >= dlay then
		ni.spell.cast(48162)
		LastAction = GetTime()
	end
    if not ni.player.buff(48170)
    and ni.spell.available(48170)
    and GetTime() - LastAction >= dlay then
		ni.spell.cast(48170)
		LastAction = GetTime()
	end
    if not ni.player.buff(15286)
    and ni.spell.available(15286)
    and GetTime() - LastAction >= dlay then
		ni.spell.cast(15286)
	    LastAction = GetTime()
    end
end,
["AntiFear"] = function()
    if not ni.player.buff(AntiFear)
    and ni.spell.available(AntiFear)
    and GetTime() - LastAction >= dlay then
		ni.spell.cast(AntiFear, "player")
	    LastAction = GetTime()
    end
end,
["TargetPidor"] = function()
    if not ni.unit.debuff("target", 453)
    and ni.spell.available(453)
	and ni.spell.valid("target", 453, false, true, true)
    and GetTime() - LastAction >= dlay then
		ni.spell.cast(453)
	    LastAction = GetTime()
    end
end,
["WordShield"] = function()
    if ni.spell.available(WordShield)
   	and not ni.player.debuff(Weakness)
   	and not ni.player.buff(WordShield)
    and GetTime() - LastAction >= dlay then
		ni.spell.cast(WordShield, "player")
      	LastAction = GetTime()
	end
end,
["MindBlow"] = function ()
    for _, v in ipairs(BadBuff) do
        if ni.unit.buff("target", v) then
            return false
        end
    end
	if ni.spell.available(48127)
	and ni.unit.debuff("target", 48125, "player")
	and ni.unit.debuff("target", 48300, "player")
	and ni.unit.debuff("target", 48160, "player")
	and ni.spell.valid("target", 48127, false, true, true)
    and GetTime() - LastAction >= dlay
    and not ni.player.ismoving() then
        ni.spell.cast(48127)
        LastAction = GetTime()
    end
end,
["Punish"] = function ()
    for _, v in ipairs(BadBuff) do
        if ni.unit.buff("target", v) then
            return false
        end
    end
	if ni.spell.available(48156)
    and ni.spell.cd(48127) ~= 0
	and ni.unit.debuff("target", 48125, "player")
	and ni.unit.debuff("target", 48300, "player")
	and ni.unit.debuff("target", 48160, "player")
	and ni.spell.valid("target", 48156, false, true, true)
    and GetTime() - LastAction >= dlay
    and not ni.player.ismoving() then
        ni.spell.cast(48156)
        LastAction = GetTime()
    end
end,
["Vamp"] = function ()
    for _, v in ipairs(BadBuff) do
        if ni.unit.buff("target", v) then
            return false
        end
    end
	if ni.spell.available(48160)
	and not ni.unit.debuff("target", 48160, "player")
	and ni.spell.valid("target", 48160, false, true, true)
    and GetTime() - LastAction >= dlay
    and GetTime() - LastVamp >= dlay*2
    and not ni.player.ismoving() then
        ni.spell.cast(48160)
        LastAction = GetTime()
        LastVamp = GetTime()
    end
end,
["Death"] = function ()
    for _, v in ipairs(BadBuff) do
        if ni.unit.buff("target", v) then
            return false
        end
    end
	if ni.spell.available(48158)
	and ni.unit.hp("target") < 8
	and ni.spell.valid("target", 48158, false, true, true)
    and GetTime() - LastAction >= dlay then
        ni.spell.cast(48158)
        LastAction = GetTime()
    end
end,
["Pain"] = function ()
    for _, v in ipairs(BadBuff) do
        if ni.unit.buff("target", v) then
            return false
        end
    end
	if ni.spell.available(48125)
	and not ni.unit.debuff("target", 48125, "player")
	and ni.spell.valid("target", 48125, false, true, true)
    and GetTime() - LastAction >= dlay then
        ni.spell.cast(48125)
        LastAction = GetTime()
    end
end,
["Baaaaad"] = function ()
    for _, v in ipairs(BadBuff) do
        if ni.unit.buff("target", v) then
            return false
        end
    end
	if ni.spell.available(48300)
	and not ni.unit.debuff("target", 48300)
	and ni.spell.valid("target", 48300, false, true, true)
    and GetTime() - LastAction >= dlay then
        ni.spell.cast(48300)
        LastAction = GetTime()
    end
end,
["Mob"] = function()
    for _, v in ipairs(BadBuff) do
        if ni.unit.buff("target", v) then
            return false
        end
    end
	if UnitAffectingCombat("player")
    and ni.player.power() < 65
	and ni.spell.available(34433)
	and ni.spell.valid("target", 48125, false, true, false)
    and GetTime() - LastAction >= dlay then
		ni.spell.cast(34433)
    	LastAction = GetTime()
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
["inDARKIN"] = function()
	if UnitAffectingCombat("player")
	and ni.player.hp() < 35
	and ni.spell.available(47585)
    and GetTime() - LastAction >= dlay then
		ni.spell.cast(47585)
    	LastAction = GetTime()
	end
end,
["DARKIN"] = function()
	if not ni.player.buff(15473)
	and ni.spell.available(15473)
    and GetTime() - LastAction >= dlay then
		ni.spell.cast(15473)
    	LastAction = GetTime()
	end
end,
["olokol"] = function()
	if ni.player.hp() <= 70
	and #ni.player.friendsinrange(16) >= 2
	and ni.spell.available(48113)
    and GetTime() - LastAction >= dlay then
		ni.spell.cast(48113, "player")
    	LastAction = GetTime()
	end
end,
["Fearing"] = function()
	local Enemies = ni.player.enemiesinrange(6)
	if GetTime() - LastAction >= dlay
	and ni.spell.available(Fear) then
		for i = 1, #Enemies do
			local ENEMY = Enemies[i].guid;
			if not ni.unit.istotem(ENEMY)
			and ni.unit.isplayer(ENEMY) then
				ni.spell.cast(Fear)
				LastAction = GetTime()
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
ni.bootstrap.rotation("SP", order, moves)