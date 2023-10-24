local lastSpell, lastGuid, lastTime = "", "", 0;
local kusbas = { };
--- Эта функция для милишников, по типу воина, роги, друида и их мили заклинаний
kusbas.spellusable = function(id)
	if tonumber(id) == nil then
		id = ni.spell.id(id)
	end
	local result = false
	if not ni.player.isstunned()
	 and ni.spell.available(id)
	 and IsUsableSpell(GetSpellInfo(id)) then
		result = true
	end
	return result
end;
--- Эта функция уже для кастеров, так как проверяет наличие сала
kusbas.spellusablesilence = function(id)
	if tonumber(id) == nil then
		id = ni.spell.id(id)
	end
	local result = false
	if not ni.player.isstunned()
	 and not ni.player.issilenced()
	 and ni.spell.available(id)
	 and IsUsableSpell(GetSpellInfo(id)) then
		result = true
	end
	return result
end;
--- Знаем ли мы заклинание, более прокачаная функция чем стандартная.
kusbas.spellisknown = function(id)
	if tonumber(id) == nil then
		id = ni.spell.id(id)
	end
	local result = false
	if id ~= nil 
	 and id ~= 0 
	 and IsSpellKnown(id) then
	  local name = GetSpellInfo(id)
	   if name then
			result = true
		end
	end
	return result
end;
kusbas.arena = function() 
local isArena, isRegistered = IsActiveBattlefieldArena();
if IsActiveBattlefieldArena(isArena) then
	return true;
end
return false;
end;
kusbas.battleground = function()
local zoneName = GetZoneText()
local position = UnitInBattleground("player")
if UnitInBattleground("player")
	or GetZoneText("Озеро Ледяных Оков") then
	return true;
end;
return false
end;
--- ПОлучение ренжи без проверки ресурсов, используется там где не подходит ni.spell.valid
kusbas.getrange = function(t, id)
	if tonumber(id) == nil then
		id = ni.spell.id(id)
	end
	if ni.player.isfacing(t)
	 and ni.player.los(t)
	 and IsSpellInRange(GetSpellInfo(id), t) == 1 then
		return true;
	end
		return false;
end;
--- Проверка играем ли мы на высрусе или нет;
kusbas.sirusserver = function()
	local itis = false
	if (GetRealmName() == "\83\99\111\117\114\103\101\32\120\50\32\45\32\51\46\51\46\53\97\43"
	 or GetRealmName() == "\78\101\108\116\104\97\114\105\111\110\32\120\51\32\45\32\51\46\51\46\53\97\43"
	 or GetRealmName() == "\65\108\103\97\108\111\110\32\120\52\32\45\32\51\46\51\46\53\97") then
		itis = true;
	end
	return itis
end;
return kusbas;