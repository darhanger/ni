local queue = {
	"Pause",
	"MoonkinForm",
	"Starsurge",
	--"Aoe Taged",
	"Moonfire",
--	"Sunfire",
	"InsectSwarm",
	"Wrath",
	"Starfire"
}

local spells = {
--Balance
EntanglingRoots = {id = 339, name = GetSpellInfo(339)},
FaerieFire = {id = 770, name = GetSpellInfo(770)},
Innervate = {id = 29166, name = GetSpellInfo(29166)},
InsectSwarm = {id = 5570, name = GetSpellInfo(5570)},
Moonfire = {id = 8921, name = GetSpellInfo(8921)},
Moonfury = {id = 16913, name = GetSpellInfo(16913)},
MoonkinForm = {id = 24858, name = GetSpellInfo(24858)},
Soothe = {id = 2908, name = GetSpellInfo(2908)},
Starfire = {id = 2912, name = GetSpellInfo(2912)},
Starsurge = {id = 78674, name = GetSpellInfo(78674)},
Thorns = {id = 467, name = GetSpellInfo(467)},
Wrath = {id = 5176, name = GetSpellInfo(5176)},
Hurricane = {id = 16914, name = GetSpellInfo(16914)},
Hibernate = {id = 2637, name = GetSpellInfo(2637)},
NaturesGrasp = {id = 16689, name = GetSpellInfo(16689)},
Barkskin = {id = 22812, name = GetSpellInfo(22812)},
Cyclone = {id = 33786, name = GetSpellInfo(33786)},
WildMushroom = {id = 88747, name = GetSpellInfo(88747)},
WildMushroomDetonate = {id = 88751, name = GetSpellInfo(88751)},
--Restoration
Nourish = {id = 50464, name = GetSpellInfo(50464)},
Regrowth = {id = 8936, name = GetSpellInfo(8936)},
Rejuvenation = {id = 774, name = GetSpellInfo(774)},
Revive = {id = 50769, name = GetSpellInfo(50769)},
Rebirth = {id = 20484, name = GetSpellInfo(20484)},
RemoveCorruption = {id = 2782, name = GetSpellInfo(2782)},
MarkoftheWild = {id = 1126, name = GetSpellInfo(1126)},
Lifebloom = {id = 33763, name = GetSpellInfo(33763)},
Tranquility = {id = 740, name = GetSpellInfo(740)},
HealingTouch = {id = 5185, name = GetSpellInfo(5185)},
}

local enemies = {}

local function ActiveEnemies(range)
	table.wipe(enemies)
	enemies = ni.player.enemiesinrange(range)
	for k, v in ipairs(enemies) do
		if ni.player.threat(v.guid) == -1 then
			table.remove(enemies, k)
		end
	end
	return #enemies
end

local function FacingLosCast(spell, tar)
	if ni.player.isfacing(tar, 145) and ni.player.los(tar) and IsSpellInRange(spell, tar) == 1 then
		ni.spell.cast(spell, tar)
		return true
	end
	return false
end

local function ValidUsable(id, tar)
	if ni.spell.available(id) and ni.spell.valid(tar, id, true, true) then
		return true
	end
	return false
end

local solar = "Solar";
local lunar = "Lunar"
local current = solar;

local function GetEclipse()
	if ni.player.buff(48517) and current ~= solar then -- Eclipse solar
		current = solar
	elseif ni.player.buff(48518) and current ~= lunar then -- Eclipse lunar
		current = lunar
	end
	return current
end

local abilities = {
	["Pause"] = function()
		if	IsMounted() or
			UnitIsDeadOrGhost("player")
			or not UnitExists("target")
			or UnitIsDeadOrGhost("target")
			or (UnitExists("target")
			and not UnitCanAttack("player", "target"))
		 then
			return true
		end
	end,
	["MoonkinForm"] = function()
		if not ni.player.buff(spells.MoonkinForm.id)
		 then
			ni.spell.cast(spells.MoonkinForm.name)
			return true;
		end
	end,
	["Starsurge"] = function()
		if ValidUsable(spells.Starsurge.id, "target")
		and not ni.player.ismoving()
		and FacingLosCast(spells.Starsurge.name, "target") then
			return true;
		end
	end,
	["Wrath"] = function()
		if ValidUsable(spells.Wrath.id, "target")
		and not ni.player.ismoving()
		and GetEclipse() == solar
		and FacingLosCast(spells.Wrath.name, "target") then
			return true;
		end
	end,
	["Starfire"] = function()
		if ValidUsable(spells.Starfire.id, "target")
		and not ni.player.ismoving()
		and GetEclipse() == lunar
		and FacingLosCast(spells.Starfire.name, "target") then
			return true;
		end
	end,
	["Aoe Taged"] = function()
		if ActiveEnemies() > 0 then
			for k, v in ipairs(enemies) do
				if ni.unit.debuffremaining(v.guid, spells.Moonfire.id, "player") <= 2 then
					if ni.spell.valid(v.guid, spells.Moonfire.id, true, true) then
						ni.spell.cast(spells.Moonfire.name, v.guid)
						ni.debug.log(string.format("Casting %s on %s", spells.Moonfire.name, v.guid))
						return true
					end
				end
				if ni.unit.debuffremaining(v.guid, spells.InsectSwarm.id, "player") <= 2 then
					if ni.spell.valid(v.guid, spells.InsectSwarm.id, true, true) then
						ni.spell.cast(spells.InsectSwarm.name, v.guid)
						ni.debug.log(string.format("Casting %s on %s", spells.InsectSwarm.name, v.guid))
						return true
					end
				end
			end
		end
	end,
	["Moonfire"] = function()
		local db = ni.unit.debuffremaining("target", spells.Moonfire.name, "PLAYER")
		if ValidUsable(spells.Moonfire.id, "target")
		and db <= 2
		and FacingLosCast(spells.Moonfire.name, "target")
		 then
			return true;
		end
	end,
	["Sunfire"] = function()
		local db = ni.unit.debuffremaining("target", spells.Sunfire.name, "PLAYER")
		if ValidUsable(spells.Sunfire.id, "target")
		and (db <= 2)
		and FacingLosCast(spells.Sunfire.name, "target")
		 then
			return true;
		end
	end,
	["InsectSwarm"] = function()
		local db = ni.unit.debuffremaining("target", spells.InsectSwarm.name, "PLAYER")
		if ValidUsable(spells.InsectSwarm.id, "target")
		and (db <= 2)
		and FacingLosCast(spells.InsectSwarm.name, "target")
		 then
			return true;
		end
	end,
}
ni.bootstrap.rotation("Balance_Cata", queue, abilities)
