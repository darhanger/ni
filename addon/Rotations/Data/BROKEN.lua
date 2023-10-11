local BLACKLISTEDMONSTER = {};
local BLACKLISTEDMONSTERWITHBUFF = {};
local DATA = {};
DATA.LAST_ACTION = 0
DATA.LAST_STUN = 0
DATA.LAST_TAUNT = 0
DATA.CANCAST = function(s)
	if IsUsableSpell(s)
	and ni.spell.available(s) then
		return true
	end
	return false
end
DATA.CANCASTINSTANT = function(s)
	local _, _, _, cost, _, powertype = GetSpellInfo(s)
	if IsUsableSpell(s)
	and ni.spell.cd(s) == 0
	and ((powertype >= 0 and ni.player.powerraw(powertype) >= cost)
	or (powertype == -2 and ni.player.hpraw() >= cost)) then
		return true
	end
	return false
end
DATA.SINGLETARGET = function()
	if #ni.player.enemiesinrange(5) == 1 then
		return true
	end
	return false
end
DATA.NEEDAOE = function()
	if #ni.player.enemiesinrange(5) >= 2 then
		return true
	end
	return false
end
DATA.NEEDMOREAOE = function()
	if #ni.player.enemiesinrange(5) >= 3 then
		return true
	end
	return false
end
DATA.ENEMYWITHDEBUFF = function(t)
	for _, v in pairs(BLACKLISTEDMONSTERWITHBUFF) do
		if ni.unit.istotem(t)
		or ni.unit.buff(t, v) then
			return false
		end
	end
	return true
end
DATA.MONSTERWITHBUFFTOBLACKLIST = function(id)
	if not tContains(BLACKLISTEDMONSTERWITHBUFF, id) then
		tinsert(BLACKLISTEDMONSTERWITHBUFF, id)
	end
end
DATA.MONSTERTOBLACKLIST = function(id)
	if not tContains(BLACKLISTEDMONSTER, id) then
		tinsert(BLACKLISTEDMONSTER, id)
	end
end
DATA.DONTTAUNT = function(t)
	for _, v in pairs(BLACKLISTEDMONSTER) do
		if ni.unit.exists(t)
		and v == ni.unit.id(t) then
			return false
		end
	end
	return true
end
DATA.PAUSE = function()
  if IsMounted()
  or UnitInVehicle("player")
  or ni.player.buff(GetSpellInfo(430))
  or ni.player.buff(GetSpellInfo(433))
  or ni.player.isconfused()
  or ni.player.isfleeing()
  or ni.player.isstunned()
  or ni.player.iscasting()
  or ni.player.ischanneling()
  or UnitIsDeadOrGhost("player")
  or UnitIsDeadOrGhost("target")
  or IsLeftShiftKeyDown() then
		return true
	end
end
return DATA;