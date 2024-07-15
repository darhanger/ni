local build = select(4, GetBuildInfo());
local wotlk = build == 30300 or false;
if wotlk then
	local function GetSetting(name)
		for k, v in ipairs(items) do
			if v.type == "entry"
					and v.key ~= nil
					and v.key == name then
				return v.value, v.enabled
			end
		end
	end;


	local spells = {
		ConjureManaGem = { id = 42985, name = GetSpellInfo(42985) },
		MoltenArmor = { id = 43046, name = GetSpellInfo(43046) },
		ArcaneBrilliance = { id = 43002, name = GetSpellInfo(43002) },
		Evocation = { id = 12051, name = GetSpellInfo(12051) },
		Pyroblast = { id = 42891, name = GetSpellInfo(42891) },
		Scorch = { id = 42859, name = GetSpellInfo(42859) },
		LivingBomb = { id = 55360, name = GetSpellInfo(55360) },
		MirrorImage = { id = 55342, name = GetSpellInfo(55342) },
		Combustion = { id = 11129, name = GetSpellInfo(11129) },
		Fireblast = { id = 42873, name = GetSpellInfo(42873) },
		Fireball = { id = 42833, name = GetSpellInfo(42833) }
	};
	local Cache = {
		enemies = ni.unit.enemiesinrange("player", 40),
	}
	local queue = {
		"Cache",
		"Molten Armor",
		"Living Bomb",
	};

	local abilities = {
		["Cache"] = function()
			Cache.enemies = ni.unit.enemiesinrange("player", 40)
		end,
		["Molten Armor"] = function()
			if ni.spell.available(spells.MoltenArmor.id)
					and not ni.unit.ischanneling("player")
					and not ni.player.buff(spells.MoltenArmor.id) then
				ni.spell.cast(spells.MoltenArmor.name)
				return true;
			end
		end,


		["Living Bomb"] = function()
			for i = 1, #Cache.enemies do
				local target = Cache.enemies[i].guid
				local targetOfTarget = UnitGUID(target .. "target") -- Obtener el GUID del "target del target".
				local pl = ni.objectmanager.objectGUID("player")
				local x, y, z, facing, unittype, targett, height = ni.unit.info(target)
				if ni.spell.available(spells.LivingBomb.id)
						and ni.unit.exists(targett)
						and targett ~= pl
						and ni.unit.debuff(target, 55360, "player") == nil -- Living Bomb --
						and ni.spell.valid(target, spells.LivingBomb.id, false, true)
						and not ni.unit.ischanneling("player")
				then
					ni.spell.cast(spells.LivingBomb.name, target)
					return true
				end
			end
		end,


	};
	ni.bootstrap.profile("Bunny - Fire Mage", queue, abilities);
else
	local queue = {
		"Error",
	};
	local abilities = {
		["Error"] = function()
			ni.vars.profiles.enabled = false;
			if not wotlk then
				ni.frames.floatingtext:message("This profile for WotLK 3.3.5a!")
			end
		end,
	};
	ni.bootstrap.profile("Bunny - Fire Mage", queue, abilities);
end;
