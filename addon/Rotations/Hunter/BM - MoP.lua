local queue = {
	"Pause",
	"Mend Pet",
	"Healthstone",
	"Fervor",
	"Binding Shot",
	"Wyvern Sting",
	"Intimidation",
	"Rapid Fire",
	"Misdirection",
	"Stampede",
	"Scatter Shot",
	"Freezing Trap",
	"Explosive Trap",
	"Snake Trap",
	"Ice Trap",
	"Tranquilizing Shot",
	"Bestial Wrath",
	"Lynx Rush",
	"Kill Shot",
	"Serpent Sting",
	"Barrage",
	"Kill Command",
	"Glaive Toss",
	"A Murder of Crows",
	"Power Shot",
	"Dire Beast",
	"Readiness",
	"Focus Fire",
	"Arcane Shot",
	"Cobra Shot"
}
local spells = {
	mendpet = { id = 136, name = GetSpellInfo(136) },
	fervor = { id = 82726, name = GetSpellInfo(82726) },
	misdirection = { id = 34477, name = GetSpellInfo(34477) },
	bestialwrath = { id = 19574, name = GetSpellInfo(19574) },
	growl = { id = 2649, name = GetSpellInfo(2649) },
	lynxrush = { id = 1206697, name = GetSpellInfo(1206697) },
	killshot = { id = 53351, name = GetSpellInfo(53351) },
	serpentsting = { id = 1978, name = GetSpellInfo(1978) },
	killcommand = { id = 34026, name = GetSpellInfo(34026) },
	powershot = { id = 109259, name = GetSpellInfo(109259) },
	direbeast = { id = 120679, name = GetSpellInfo(120679) },
	focusfire = { id = 82692, name = GetSpellInfo(82692) },
	arcaneshot = { id = 3044, name = GetSpellInfo(3044) },
	cobrashot = { id = 56641, name = GetSpellInfo(56641) },
}
local function HasSpell(spell)
	if IsSpellKnown(spell) or IsPlayerSpell(spell) then
		return true;
	end
	return false;
end
local function HasResources(spell)
	local name, _, _, cost, _, powertype = GetSpellInfo(spell);
	if name
	 and UnitPower("player", powertype) >= cost then
		return true;
	end
	return false;	
end
local function CanCast(spell, target)
	if HasResources(spell)
	 and IsSpellInRange(spell, target) == 1 then
		return true;
	end
end
local function predictedcast(spell, t)
	t = t or 'target'
	local x1, y1 = ni.unit.location(t);
	local startTime = GetTime();
	ni.delayfor(.1, function()
		if UnitExists(t) then
			local x2, y2, z = ni.unit.location(t);
			local px, py = ni.player.location();
			local endTime = GetTime();
			local dx,dy;
			dx = (x2-x1) / (endTime - startTime)
			dy = (y2-y1) / (endTime - startTime)
			local distance = math.sqrt((x2 - px)^2 + (y2 - py)^2)
			local flightTime  = distance / 25 * cos((30 * 3.1459) /180)

			local x = x2 + dx * flightTime
			local y = y2 + dy * flightTime
			local newz = select(4, ni.unit.los(x,y,1000,x,y,-1000))

			ni.player.cast(spell);
			ni.player.clickat(x, y, newz);
			delayrotation = false;
		end
	end)
end
local delayrotation = false;
local abilities = {
	["Mend Pet"] = function()
		if HasSpell(spells.mendpet.id)
		 and UnitExists("pet")
		 and not UnitIsDead("pet")
		 and ni.player.los("pet")
		 and ni.unit.hp("pet") < 95
		 and ni.unit.buff("pet", 136)
		 and IsSpellInRange(spells.mendpet.name, "pet") == 1 then
			ni.spell.cast(spells.mendpet.name);
			return true;
		end
	end,
	["Pause"] = function()
		if not UnitExists("target")
		 or (UnitExists("target")
		 and (not UnitCanAttack("player", "target")
		 or UnitIsDeadOrGhost("target")))
		 or UnitChannelInfo("player")
		 or UnitIsDeadOrGhost("player")
		 or IsMounted()
		 or delayrotation then
			return true;
		end
	end,
	["Healthstone"] = function()
		if ni.player.hp() < 40
		 and ni.player.hasitem(5512)
		 and ni.player.itemcd(5512) == 0 then
			ni.player.useitem(5512);
			return true;
		end
	end,
	["Fervor"] = function()
		if HasSpell(spells.fervor.id)
		 and UnitPower("player") <= 50
		 and UnitPower("pet") <= 50 then
			ni.spell.cast(spells.fervor.name);
			return true;
		end
	end,
	["Binding Shot"] = function()

	end,
	["Wyvern Sting"] = function()

	end,
	["Intimidation"] = function()

	end,
	["Rapid Fire"] = function()

	end,
	["Misdirection"] = function()
		if HasSpell(spells.misdirection.id) then
			if GetNumGroupMembers() == 0 then
				if UnitExists("pet")
				 and IsSpellInRange(spells.misdirection.name, "pet") == 1
				 and ni.player.los("pet")
				 and ni.unit.threat("pet", "target") ~= 3 then
					ni.spell.cast(spells.misdirection.name, "pet");
					return true;
				end
			else
				local mt = ni.tanks();
				if IsSpellInRange(spells.misdirection.name, mt) == 1
				 and ni.player.los(mt)
				 and ni.unit.threat(mt, "target") ~= 3 then
					ni.spell.cast(spells.misdirection.name, mt);
					return true;
				end
			end
		end
	end,
	["Stampede"] = function()

	end,
	["Scatter Shot"] = function()

	end,
	["Freezing Trap"] = function()

	end,
	["Explosive Trap"] = function()

	end,
	["Snake Trap"] = function()

	end,
	["Ice Trap"] = function()

	end,
	["Tranquilizing Shot"] = function()

	end,
	["Bestial Wrath"] = function()
		if HasSpell(spells.bestialwrath.id)
		 and UnitExists("pet")
		 and UnitPower("player") > 80
		 and IsSpellInRange(spells.growl.name, "pettarget") == 1 then
			ni.spell.cast(spells.bestialwrath.name);
			return true;
		end
	end,
	["Lynx Rush"] = function()
		if HasSpell(spells.lynxrush.id)
		 and UnitExists("pet")
		 and not UnitIsDead("pet")
		 and IsSpellInRange(spells.growl.name, "pettarget") == 1 then
			ni.spell.cast(spells.lynxrush.name);
			return true;
		end
	end,
	["Kill Shot"] = function()
		if HasSpell(spells.killshot.id)
		 and IsUsableSpell(spells.killshot.name)
		 and ni.spell.cd(spells.killshot.id) == 0
		 and IsSpellInRange(spells.killshot.name, "target") == 1
		 and ni.player.los("target")
		 and ni.player.isfacing("target") then
			ni.spell.cast(spells.killshot.name, "target");
			return true;
		end
	end,
	["Serpent Sting"] = function()
		if HasSpell(spells.serpentsting.id)
		 and not ni.unit.debuff("target", 1978, "player")
		 and CanCast(spells.serpentsting.name, "target")
		 and ni.spell.delaycast(spells.serpentsting.name, "target", 1) then
			return true;
		end
	end,
	["Barrage"] = function()

	end,
	["Kill Command"] = function()
		if HasSpell(spells.killcommand.id)
		 and not ni.player.buff(34692)
		 and (not HasSpell(spells.bestialwrath.id)
		 or ni.spell.cd(spells.bestialwrath.id) > 0)
		 and UnitExists("pet")
		 and HasResources(spells.killcommand.id)
		 and ni.spell.cd(spells.killcommand.id) == 0
		 and IsSpellInRange(spells.growl.name, "pettarget") == 1 then
			ni.spell.cast(spells.killcommand.name);
			return true;
		end
	end,
	["Glaive Toss"] = function()

	end,
	["A Murder of Crows"] = function()

	end,
	["Power Shot"] = function()
		if HasSpell(spells.powershot.id)
		 and not ni.player.ismoving() then
			ni.spell.cast(spells.powershot.name);
			return true;
		end
	end,
	["Dire Beast"] = function()
		if HasSpell(spells.direbeast.id)
		 and ni.spell.cd(spells.direbeast.id) == 0 then
			ni.spell.cast(spells.direbeast.name);
			return true;
		end
	end,
	["Readiness"] = function()

	end,
	["Focus Fire"] = function()
		if HasSpell(spells.focusfire.id) then
			if UnitLevel("player") >= 30
			 and ni.player.buffcount(19615) ~= 5 then
				return false;
			end
			if not ni.player.buff(34692)
			 and not ni.player.buff(3045) then
				ni.spell.cast(spells.focusfire.name);
				return true;
			end
		end
	end,
	["Arcane Shot"] = function()
		if HasSpell(spells.arcaneshot.id) then
			local power = UnitPower("player");
			if UnitExists("pet")
			 and not UnitIsDead("pet")
			 and IsSpellInRange(spells.growl.name, "pettarget") == 1 then
				local kc = ni.spell.cd(spells.killcommand.id);
				if kc > 0 and kc < 1
				 and power < 50
				 and ni.player.buff(109306) then
					return false;
				end
				local bw = ni.spell.cd(spells.bestialwrath.id);
				if bw > 0 and bw < 2
				 and not ni.player.buff(34692) then
					return false;
				end
			end
			local toth = ni.player.buff(109306);
			local bw = ni.player.buff(34692);
			if IsSpellInRange(spells.arcaneshot.name, "target") == 1
			 and ((HasSpell(spells.fervor.id)
			 and ni.spell.cd(spells.fervor.id) == 0
			 and power > 30
			 or toth
			 or bw)
			 or (power > 40
			 and toth)
			 or bw
			 or (power > 60
			 or UnitIsDead("pet")
			 or not UnitExists("pet"))) then
				ni.spell.cast(spells.arcaneshot.name);
				return true;
			end 
		end
	end,
	["Cobra Shot"] = function()
		if HasSpell(spells.cobrashot.id)
		 and UnitPower("player") < 75
		 and IsSpellInRange(spells.cobrashot.name, "target") == 1
		 and UnitCastingInfo("player") ~= spells.cobrashot.name
		 and ni.spell.delaycast(spells.cobrashot.name, "target", .5) then
			return true;
		end
	end
}
ni.bootstrap.rotation("BM - MoP", queue, abilities);
