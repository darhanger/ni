local stqueue = {
	"pause",
	"Start Attack",
	"Debuffs",
	"Horn of Winter",
	"Bone Shield",
	"Blood Boil (Proc)",
	"Rune Tap",
	"Raise Ally",
	"Empower Rune Weapon",
	"Rune Strike",
	"Death Strike",
	"Blood Tap",
	"Heart Strike"
}
local aoequeue = {
	"pause",
	"Start Attack",
	"Debuffs",
	"Horn of Winter",
	"Bone Shield",
	"Blood Boil (Proc)",
	"Rune Tap",
	"Raise Ally",
	"Rune Strike",
	"Death Strike",
	"Pestilence",
	"Blood Boil",
	"Blood Tap"
}

local deathgrip = GetSpellInfo(49576);
local darkcommand = GetSpellInfo(56222);
local outbreak = GetSpellInfo(77575);
local icytouch = GetSpellInfo(45477);
local plaguestrike = GetSpellInfo(45462);
local hornofwinter = GetSpellInfo(57330);
local boneshield = GetSpellInfo(49222);
local bloodboil = GetSpellInfo(48721);
local runetap = GetSpellInfo(48982);
local raiseally = GetSpellInfo(61999);
local runestrike = GetSpellInfo(56815);
local deathstrike = GetSpellInfo(49998);
local bloodtap = GetSpellInfo(45529);
local heartstrike = GetSpellInfo(55050);
local pestilence = GetSpellInfo(50842);
local empowerruneweapon = GetSpellInfo(47568);

local IgnoresDiseases = {
}
local function InRange()
	return IsSpellInRange(plaguestrike, "target") == 1;
end
local function SafeToDeathStrike()
	local offcd = 0;
	for i = 3, 6 do
		if select(3, GetRuneCooldown(i)) == true and GetRuneType(i) ~= 4 then
			offcd = offcd + 1;
		end
	end
	local drcd = select(2, ni.rune.deathrunecd());
	if offcd + drcd > 2 then
		return true;
	elseif offcd + drcd == 2 then
		for i = 3, 6 do
			local st, du = GetRuneCooldown(i);
			local remaining = st + du - GetTime(); 
			if remaining > 0 and remaining <= 1.5 then
				return true;
			end
		end
	end
	return false;
end
local function CanDisease(tar)
	local id = ni.unit.id(tar);
	if IgnoresDiseases[id] then
		return false;
	end
	return true;
end
local function BBOrPest(tar)
	if not IsPlayerSpell(108170) then
		if ni.spell.delaycast(pestilence, tar, 1.5) then
			return true;
		end
	else
		if ni.spell.delaycast(bloodboil, tar, 1.5) then
			return true;
		end
	end
	return false;
end
local function DiseaseSpreadSpellReady()
	if not IsPlayerSpell(108170) then
		if ni.spell.available(pestilence, true) then
			return true;
		end
	else
		if ni.spell.available(bloodboil, true) then
			return true;
		end
	end
	return false;
end
local abilities = {
	["pause"] = function()
		if IsMounted()
		 or not UnitAffectingCombat("player")
		 or UnitIsDeadOrGhost("player") then
			return true;
		end
	end,
	["Start Attack"] = function()
		if UnitExists("target")
		 and UnitCanAttack("player", "target")
		 and not UnitIsDeadOrGhost("target")
		 and UnitAffectingCombat("player", "target")
		 and not IsCurrentSpell(6603) then
			ni.spell.cast(6603);
		end
	end,
	["Debuffs"] = function()
		local ff = ni.unit.debuffremaining("target", 55095, "player");
		local bp = ni.unit.debuffremaining("target", 55078, "player");
		if DiseaseSpreadSpellReady() then
			local noff = ni.unit.debuff("target", 55095);
			local nobp = ni.unit.debuff("target", 55078);
			local enemies = ni.unit.enemiesinrange("target", 7);
			local tartransport = ni.unit.transport("target");
			for k, v in ipairs(enemies) do
				if ni.player.threat(v.guid) ~= -1
				 and CanDisease(v.guid)
				 and (tartransport == nil
				 or (tonumber(v.guid) ~= tonumber(tartransport))) then
					local tff = ni.unit.debuff(v.guid, 55095);
					local tbp = ni.unit.debuff(v.guid, 55078);
					if ni.spell.valid("target", pestilence, true, true) then
						if (noff ~= nil and nobp ~= nil)
						 and (tff == nil or tbp == nil) then
							if BBOrPest("target") then
								return true;
							end
						end
					end
					if ni.spell.valid(v.guid, pestilence, true, true) then
						if (tff ~= nil and tbp ~= nil)
						 and (noff == nil or nobp == nil) then
							if BBOrPest(v.guid) then
								return true;
							end
						end
					end
				end
			end
		end
		if CanDisease("target") then
			if IsSpellKnown(77575)
			 and ni.spell.valid("target", outbreak, true, true) then
				if ni.spell.cd(outbreak) ~= 0 then
					if ff < 3 then
						ni.spell.cast(icytouch, "target");
						return true;
					end
					if bp < 3 then
						ni.spell.cast(plaguestrike, "target");
						return true;
					end
				else
					if ff == 0 or bp == 0 then
						ni.spell.cast(outbreak, "target");
						return true;
					else
						if (ff > 0 and ff < 3)
						 or (bp > 0 and bp < 3) then
							ni.spell.cast(outbreak, "target");
							return true;
						end
					end
				end
			else
				if (ff >= 0 and ff < 3)
				 and ni.spell.available(icytouch)
				 and ni.spell.valid("target", icytouch, true, true) then
					ni.spell.cast(icytouch, "target");
					return true;
				end
				if (bp >= 0 and bp < 3)
				 and ni.spell.available(plaguestrike)
				 and ni.spell.valid("target", plaguestrike, true, true) then
					ni.spell.cast(plaguestrike, "target");
					return true;
				end
			end
		end
	end,
	["Horn of Winter"] = function()
		if ni.spell.available(hornofwinter) then
			local how = ni.player.buffremaining(57330);
			if how <= 3 
			 or (UnitAffectingCombat("player") and UnitPower("player") < 20) then 
				ni.spell.cast(hornofwinter);
				return true;
			end
		end
	end,
	["Bone Shield"] = function()
		if ni.spell.available(boneshield) then
			local bs, _, _, bscount = ni.player.buff(49222);
			if (not bs
			 or (bs
			 and not UnitAffectingCombat("player")
			 and bscount <= 2)) then
				ni.spell.cast(boneshield);
				return true;
			end
		end
	end,
	["Blood Boil (Proc)"] = function()
		if ni.spell.available(bloodboil)
		 and InRange()
		 and ni.unit.debuff("target", 55095, "player")
		 and ni.unit.debuff("target", 55078, "player")
		 and ni.player.buff(81141) then
			ni.spell.cast(bloodboil);
			return true;
		end
	end,
	["Rune Tap"] = function()
		if ni.spell.available(runetap) 
		 and ni.player.hp() <= 50 then
			ni.spell.cast(runetap, "player");
			return true;
		end
	end,
	["Raise Ally"] = function()
		if ni.spell.available(raiseally) and UnitAffectingCombat("player") then
			for i = 1, #ni.members do
				if (UnitIsDead(ni.members[i].unit)
				 or UnitIsCorpse(ni.members[i].unit))
				 and (UnitGroupRoleAssigned(ni.members[i].unit) == "TANK"
				 or UnitGroupRoleAssigned(ni.members[i].unit) == "HEALER")
				 and ni.spell.valid(ni.members[i].unit, raiseally, false, true, true) then
					ni.spell.cast(raiseally, ni.members[i].unit);
					return true;
				end
			end
		end
	end,
	["Empower Rune Weapon"] = function()
		if UnitExists("target")
		 and not ni.player.buff(51460)
		 and ni.spell.available(empowerruneweapon)
		 and UnitPower("player") < select(4, GetSpellInfo(56815))
		 and (ni.unit.isboss("target") or UnitIsUnit("target", "boss1"))
		 and ni.runes.available() == 1 then
			ni.spell.cast(empowerruneweapon);
			return true;
		end
	end,
	["Rune Strike"] = function()
		if ni.spell.available(runestrike)
		 and ni.spell.valid("target", runestrike, true, true) then
			local available = ni.rune.available();
			local power = UnitPower("player");
			if available == 4 and power < 95 then
				return false;
			elseif SafeToDeathStrike() and ni.player.power("runicpower") < 95 then
				return false;
			elseif available >= 2 and ni.player.hp() < 60 then
				return false;
			end
			ni.spell.cast(runestrike, "target");
			return true;
		end
	end,
	["Death Strike"] = function()
		if ni.spell.available(deathstrike)
		 and ni.spell.valid("target", deathstrike, true, true) then
			ni.spell.cast(deathstrike, "target");
			return true;
		end
	end,
	["Blood Tap"] = function()
		if ni.spell.available(bloodtap) 
		 and ni.player.buffremaining(114851) >= 5 
		 and ni.rune.available() + ni.rune.deathrunes() <= 2 then
			ni.spell.cast(bloodtap);
			return true;
		end
	end,
	["Heart Strike"] = function()
		if ni.spell.available(heartstrike)
		 and ni.player.hp() >= 70
		 --and ni.spell.valid("target", heartstrike, true, true)
		 and not UnitIsDeadOrGhost("target")
		 and UnitCanAttack("player", "target")
		 and ni.player.los("target")
		 and ni.player.isfacing("target")
		 and InRange()
		 and ((select(3, GetRuneCooldown(1))
		 and GetRuneType(1) ~= 4)
		 or (select(3, GetRuneCooldown(2))
		 and GetRuneType(2) ~= 4)) then
			ni.spell.cast(heartstrike, "target");
			return true;
		end
	end,
	["Blood Boil"] = function()
		if ni.spell.available(bloodboil)
		 and InRange()
		 and ni.unit.debuff("target", 55095, "player")
		 and ni.unit.debuff("target", 55078, "player")
		 and (select(3, GetRuneCooldown(1))
		 or select(3, GetRuneCooldown(2))
		 or select(2, ni.rune.deathrunecd()) >= 1) then
			ni.spell.cast(bloodboil);
			return true;
		end
	end,
	["Pestilence"] = function()
		if ni.spell.available(pestilence)
		 and InRange()
		 and ni.unit.debuff("target", 55095, "player")
		 and ni.unit.debuff("target", 55078, "player") then
			if select(3, GetRuneCooldown(1))
			 or select(3, GetRuneCooldown(2))
			 or select(2, ni.rune.deathrunecd()) >= 1 then
				if BBOrPest("target") then
					return true;
				end
			end
		end
	end
}
local function queue()
	if ni.vars.combat.aoe then
		return aoequeue;
	end
	return stqueue;
end
ni.bootstrap.rotation("Blood - MoP", queue, abilities);