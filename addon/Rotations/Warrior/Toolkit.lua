local abilities = {
	[1] = {
		condition = function()
			if (UnitChannelInfo('player') ~= nil and false) or (UnitChannelInfo('player') == nil) then
				Shield = "Wrathful Gladiator's Shield Wall"--???
rage = UnitPower("player")

function cdRemains(spellid)
	if select(2,GetSpellCooldown(spellid)) + (select(1,GetSpellCooldown(spellid)) - GetTime()) > 0
		then return select(2,GetSpellCooldown(spellid)) + (select(1,GetSpellCooldown(spellid)) - GetTime())
	else return 0
	end
end

function rangeCheck(spellid,unit)
	if IsSpellInRange(GetSpellInfo(spellid),unit) == 1
	then
		return true
	end
	end
function inMelee(c)


	if UnitAffectingCombat("player") ~= nil 
and  IsSpellInRange(GetSpellInfo(47450),c) == 1
	and UnitExists(c) ~= nil 
and UnitCanAttack("player",c) ~= nil
	then return true
	end
end

function _castSpell(spellid,tar)
		if UnitCastingInfo("player") == nil
		and UnitChannelInfo("player") == nil
		--and IsPlayerSpell(spellid) == true
		and cdRemains(spellid) == 0 and
not PQR_IsOutOfSight(tar)
		then
			if tar ~= nil
			and rangeCheck(spellid,tar) == nil
				then
				return false
			elseif tar ~= nil
			and rangeCheck(spellid,tar) == true
				then
				ni.spell.cast(spellid, tar)
				return true
			elseif tar == nil
				then
				ni.spell.cast(spellid)
				return true
			else
		return false
		end
	end	end
			end
			return false
		end,
		execution = function()
		end,
	},
	[2] = {
		condition = function()
			if (UnitChannelInfo('player') ~= nil and false) or (UnitChannelInfo('player') == nil) then
				if not cTar
then
	cTar = {"target","focus","mouseover","arena1","arena2","arena3","arena4","arena5","arenapet1","arenapet2","arenapet3","arenapet4","arenapet5","pettarget"}
end


local InterruptSpells = {	 
						         12826,		-- Polymorph
						12824,		-- Polymorph
						12825,		-- Polymorph
						118,		-- Polymorph
						61305,		-- Polymorph: Black Cat
						28272,		-- Polymorph: Pig
						61721,		-- Polymorph: Rabbit
						61780,		-- Polymorph: Turkey
						28271,		-- Polymorph: Turtle
59172, --Chaos Bolt
51514, --Hex
60043, --Lava burst
33786, --Cyclone
48160, --Vampiric Touch
47843,  --Unstable Affliction
53308, --roots
48465, --starfire
					}

if ni.spell.available(23920) and rage>=14 and (GetShapeshiftForm() == 1 or  GetShapeshiftForm() == 2)  and not PQR_IsOutOfSight(cTar[i]) then
	for i=1, #cTar do
		if UnitExists(cTar[i]) then
		local spellName, _, _, _, _, endCast, _, _, canInterrupt = UnitCastingInfo(cTar[i])
			for _, v in ipairs(InterruptSpells) do
				if GetSpellInfo(v) == spellName  then
					if ((endCast/1000) - GetTime()) < 0.33  then
								ni.spell.cast(23920)
					end
				end
			end
		end
	end
end
			end
			return false
		end,
		execution = function()
		end,
	},
	[3] = {
		condition = function()
			if (UnitChannelInfo('player') ~= nil and false) or (UnitChannelInfo('player') == nil) then
				spell = 72 --????????? ?????
target = "target"
Interupts = {	-- ????? ???? ??? ????????
		---LOCK
                      6215,  --Fear
                      17928, --Howl of terror
                      691,     --Summon felhunter
                      723,     -- Summon succubus
                      59172, --Chaos Bolt
                      47811,   --Immolate
                      47838, --Incinerate
                      47843,  --Unstable Affliction
                      59164,  --Haunt
--SHAMAN
                      49271, --Chain Lightning
                      49238, --Lightning Bolt    
                      49273, --Healing Wave
                      49276, --Lesser Healing Wave
                      51514, --Hex
--PALADIN
                      48785, --Flash of light
                      48782, --Holy Light
--DRUID
                      48461, --Wrath
                      33786, --Cyclone
                      48443, --Regrowth
                      50464, --Nourish
--PRIEST 
                     48063, --Greater Heal
                     48135, --Holy Fire
                     48120, --Binding Heal
                     48071, --Flash Heal
                     48123, --Smite
                     48160, --Vampiric Touch
--MAGE
12826,		-- Polymorph
12824,		-- Polymorph
12825,		-- Polymorph
118,		-- Polymorph
61305,		-- Polymorph: Black Cat
28272,		-- Polymorph: Pig
61721,		-- Polymorph: Rabbit
28271,		-- Polymorph: Turtle
61780,		-- Polymorph: Turkey
42842,                     -- Frostbolt

}
if inMelee(target) and rage>9 and cdRemains(72) == 0 and IsEquippedItemType("Shields") and GetShapeshiftForm() == 1 or  GetShapeshiftForm() == 2  then

for i=1, #Interupts do


if UnitCastingInfo(target) then
	local castName,_,_,_,castStartTime,castEndTime,_,_,castNotInterruptable = UnitCastingInfo(target)
	local timeSinceStart = (GetTime() * 1000 - castStartTime) / 1000
	local castTime = castEndTime - castStartTime	
	local currentPercent = timeSinceStart / castTime * 100000

	if GetSpellInfo(Interupts[i]) == castName and castNotInterruptable == false then
	KickPercent =   random(10,80)

	
	
	if currentPercent >= KickPercent then _castSpell(72,target)

			return true 


		
		


end
end
end
end
end
			end
			return false
		end,
		execution = function()
		end,
	},
	[4] = {
		condition = function()
			if (UnitChannelInfo('player') ~= nil and false) or (UnitChannelInfo('player') == nil) then
				spell = 72 --????????? ?????
target = "focus"
Interupts = {	-- ????? ???? ??? ????????
		---LOCK
                      6215,  --Fear
                      17928, --Howl of terror
                      691,     --Summon felhunter
                      723,     -- Summon succubus
                      59172, --Chaos Bolt
                      47811,   --Immolate
                      47838, --Incinerate
                      47843,  --Unstable Affliction
                      59164,  --Haunt
--SHAMAN
                      49271, --Chain Lightning
                      49238, --Lightning Bolt    
                      49273, --Healing Wave
                      49276, --Lesser Healing Wave
                      51514, --Hex
--PALADIN
                      48785, --Flash of light
                      48782, --Holy Light
--DRUID
                      48461, --Wrath
                      33786, --Cyclone
                      48443, --Regrowth
                      50464, --Nourish
--PRIEST 
                     48063, --Greater Heal
                     48135, --Holy Fire
                     48120, --Binding Heal
                     48071, --Flash Heal
                     48123, --Smite
                     48160, --Vampiric Touch
--MAGE
12826,		-- Polymorph
12824,		-- Polymorph
12825,		-- Polymorph
118,		-- Polymorph
61305,		-- Polymorph: Black Cat
28272,		-- Polymorph: Pig
61721,		-- Polymorph: Rabbit
28271,		-- Polymorph: Turtle
61780,		-- Polymorph: Turkey
42842,                     -- Frostbolt

}
if inMelee(target) and rage>9 and cdRemains(72) == 0 and IsEquippedItemType("Shields") and (GetShapeshiftForm() == 1 or  GetShapeshiftForm() == 2)  then
local spellName, _, _, _, startCast, endCast, _, _, canInterrupt = UnitCastingInfo(target) 
for i=1, #Interupts do

if GetSpellInfo(Interupts[i]) == spellName and canInterrupt == false then
if UnitCastingInfo(target) then
	local castName,_,_,_,castStartTime,castEndTime,_,_,castNotInterruptable = UnitCastingInfo(target)
	local timeSinceStart = (GetTime() * 1000 - castStartTime) / 1000
	local castTime = castEndTime - castStartTime	
	local currentPercent = timeSinceStart / castTime * 100000

	
	KickPercent =   random(15,90)

	
	
	if currentPercent >= KickPercent then _castSpell(72,target)
			return true 


		
		


end
end
end
end
end
			end
			return false
		end,
		execution = function()
		end,
	},
	[5] = {
		condition = function()
			if (UnitChannelInfo('player') ~= nil and false) or (UnitChannelInfo('player') == nil) then
				InteruptSpell = 7384-- This is the spell ID of the interupt you want to use

 InteruptTarget = "target" --This is the target you want to interupt must be in Quotation Marks (Example : "UnitName") 


                                


if inMelee(InteruptTarget) and ni.unit.buff("player",60503) and rage>=4 and GetShapeshiftForm() == 1 then

	local spellName, _, _, _, startCast, endCast, _, _, canInterrupt = UnitChannelInfo(InteruptTarget) 

		if UnitChannelInfo(InteruptTarget) ~= nil
		and ((endCast/1000) - GetTime()) > InteruptDelay  then
				_castSpell(InteruptSpell,InteruptTarget) 
return true
		end

		


end
			end
			return false
		end,
		execution = function()
		end,
	},
	[6] = {
		condition = function()
			if (UnitChannelInfo('player') ~= nil and false) or (UnitChannelInfo('player') == nil) then
				InteruptSpell = 7384-- This is the spell ID of the interupt you want to use
 InteruptDelay = 0.1--This is the time before the end of the cast
 InteruptTarget = "target" --This is the target you want to interupt must be in Quotation Marks (Example : "UnitName") 


                                


if inMelee(InteruptTarget) and ni.unit.buff("player",60503) and rage>=4 and GetShapeshiftForm() == 1 then

	local spellName, _, _, _, startCast, endCast, _, _, canInterrupt = UnitCastingInfo(InteruptTarget) 

		if UnitCastingInfo(InteruptTarget) ~= nil
		and ((endCast/1000) - GetTime()) > InteruptDelay  then
				_castSpell(InteruptSpell,InteruptTarget) 
return true
		end

		


end
			end
			return false
		end,
		execution = function()
		end,
	},
	[7] = {
		condition = function()
			if (UnitChannelInfo('player') ~= nil and false) or (UnitChannelInfo('player') == nil) then
				InteruptSpell = 7384-- This is the spell ID of the interupt you want to use

 InteruptTarget = "focus" --This is the target you want to interupt must be in Quotation Marks (Example : "UnitName") 


                                


if inMelee(InteruptTarget) and ni.unit.buff("player",60503) and rage>=4 and GetShapeshiftForm() == 1 then

	local spellName, _, _, _, startCast, endCast, _, _, canInterrupt = UnitCastingInfo(InteruptTarget) 

		if UnitCastingInfo(InteruptTarget) ~= nil
		and ((endCast/1000) - GetTime()) > InteruptDelay  then
				_castSpell(InteruptSpell,InteruptTarget) 
return true
		end

		


end
			end
			return false
		end,
		execution = function()
		end,
	},
	[8] = {
		condition = function()
			if (UnitChannelInfo('player') ~= nil and false) or (UnitChannelInfo('player') == nil) then
				spell = 6552--????????? ?????
target = "focus"
Interupts = {	-- ????? ???? ??? ????????
		---LOCK
                      6215,  --Fear
                      17928, --Howl of terror
                      691,     --Summon felhunter
                      723,     -- Summon succubus
                      59172, --Chaos Bolt
                      47811,   --Immolate
                      47838, --Incinerate
                      47843,  --Unstable Affliction
                      59164,  --Haunt
--SHAMAN
                      49271, --Chain Lightning
                      49238, --Lightning Bolt    
                      49273, --Healing Wave
                      49276, --Lesser Healing Wave
                      51514, --Hex
--PALADIN
                      48785, --Flash of light
                      48782, --Holy Light
--DRUID
                      48461, --Wrath
                      33786, --Cyclone
                      48443, --Regrowth
                      50464, --Nourish
--PRIEST 
                     48063, --Greater Heal
                     48135, --Holy Fire
                     48120, --Binding Heal
                     48071, --Flash Heal
                     48123, --Smite
                     48160, --Vampiric Touch
--MAGE
12826,		-- Polymorph
12824,		-- Polymorph
12825,		-- Polymorph
118,		-- Polymorph
61305,		-- Polymorph: Black Cat
28272,		-- Polymorph: Pig
61721,		-- Polymorph: Rabbit
28271,		-- Polymorph: Turtle
61780,		-- Polymorph: Turkey
42842,                     -- Frostbolt

}
if inMelee(target) and rage>9 and cdRemains(6552) == 0 and not GetShapeshiftForm() ~= 3 then
local spellName, _, _, _, startCast, endCast, _, _, canInterrupt = UnitCastingInfo(target) 
for i=1, #Interupts do

if GetSpellInfo(Interupts[i]) == spellName and canInterrupt == false then
if UnitCastingInfo(target) then
	local castName,_,_,_,castStartTime,castEndTime,_,_,castNotInterruptable = UnitCastingInfo(target)
	local timeSinceStart = (GetTime() * 1000 - castStartTime) / 1000
	local castTime = castEndTime - castStartTime	
	local currentPercent = timeSinceStart / castTime * 100000

	
	KickPercent =   random(15,70)

	
	
	if currentPercent >= KickPercent then _castSpell(6552,"focus")
			return true 


		
		


end
end
end
end
end
			end
			return false
		end,
		execution = function()
		end,
	},
	[9] = {
		condition = function()
			if (UnitChannelInfo('player') ~= nil and false) or (UnitChannelInfo('player') == nil) then
				spell = 6552--????????? ?????
target = "target"
Interupts = {	-- ????? ???? ??? ????????
		---LOCK
                      6215,  --Fear
                      17928, --Howl of terror
                      691,     --Summon felhunter
                      723,     -- Summon succubus
                      59172, --Chaos Bolt
                      47811,   --Immolate
                      47838, --Incinerate
                      47843,  --Unstable Affliction
                      59164,  --Haunt
--SHAMAN
                      49271, --Chain Lightning
                      49238, --Lightning Bolt    
                      49273, --Healing Wave
                      49276, --Lesser Healing Wave
                      51514, --Hex
--PALADIN
                      48785, --Flash of light
                      48782, --Holy Light
--DRUID
                      48461, --Wrath
                      33786, --Cyclone
                      48443, --Regrowth
                      50464, --Nourish
--PRIEST 
                     48063, --Greater Heal
                     48135, --Holy Fire
                     48120, --Binding Heal
                     48071, --Flash Heal
                     48123, --Smite
                     48160, --Vampiric Touch
--MAGE
12826,		-- Polymorph
12824,		-- Polymorph
12825,		-- Polymorph
118,		-- Polymorph
61305,		-- Polymorph: Black Cat
28272,		-- Polymorph: Pig
61721,		-- Polymorph: Rabbit
28271,		-- Polymorph: Turtle
61780,		-- Polymorph: Turkey
42842,                     -- Frostbolt

}
if inMelee(target) and rage>9 and cdRemains(6552) == 0  then
local spellName, _, _, _, startCast, endCast, _, _, canInterrupt = UnitCastingInfo(target) 
for i=1, #Interupts do

if GetSpellInfo(Interupts[i]) == spellName and canInterrupt == false then
if UnitCastingInfo(target) then
	local castName,_,_,_,castStartTime,castEndTime,_,_,castNotInterruptable = UnitCastingInfo(target)
	local timeSinceStart = (GetTime() * 1000 - castStartTime) / 1000
	local castTime = castEndTime - castStartTime	
	local currentPercent = timeSinceStart / castTime * 100000

	
	KickPercent =   random(15,70)




	if currentPercent >= KickPercent then  _castSpell(6552,"target")
			return true 


		
		


end
end
end
end
end
			end
			return false
		end,
		execution = function()
		end,
	},
	[10] = {
		condition = function()
			if (UnitChannelInfo('player') ~= nil and false) or (UnitChannelInfo('player') == nil) then
				if  not ni.unit.debuff("target", 47465) and rage >= 10 and  inMelee("target") and (GetShapeshiftForm() == 1 or  GetShapeshiftForm() == 2)  then
	_castSpell(47465,"target")

			return true 

end
			end
			return false
		end,
		execution = function()
		end,
	},
	[11] = {
		condition = function()
			if (UnitChannelInfo('player') ~= nil and false) or (UnitChannelInfo('player') == nil) then
				InterveneTarget = { "party1",  "party2"}
local DS = GetShapeshiftForm()
for i=1, #InterveneTarget do
 local aQuienIntervene = InterveneTarget[i]
 if UnitExists(aQuienIntervene) ~= nil
 and ni.unit.debuff(aQuienIntervene,19503) ~= nil 
 and IsSpellInRange(GetSpellInfo(3411), aQuienIntervene) == 1 then
  if DS == 1 or DS == 3 then
   ni.spell.cast(71,"player")
  end
  ni.spell.cast(3411, aQuienIntervene)
 end
end
			end
			return false
		end,
		execution = function()
		end,
	},
}
local executionqueue = { }
local tmpTab = {
	["execute"] = function()
		for i = 1, #executionqueue do
			executionqueue[i]();
			executionqueue[i] = nil;
		end
		local abilities = abilities;
		for i = 1, #abilities do
			if abilities[i].condition() then
				executionqueue[1] = abilities[i].execution;
				break;
			end
		end
	end
}
rawset(ni.rotation.profile, "Toolkit", tmpTab);
