local build = select(4, GetBuildInfo());
local wotlk = build == 30300 or false;
if wotlk then
	local queue = {
		-- "Interact",
		"AutoLoot",
		"SummonImp",
		"SummonVoidwalker",
		"DemonSkin",
		"Pause",
		"PetAttack",
		"Immolate",
		"CurseofAgony",
		"Corruption",
		"ShadowBolt",
		"Wand"
	}
	local ImpC, VoidC = "|cff00ff00Imp", "|cFF800080Voidwalker"

	local enables = {
		["Wand"] = false,
		["AutoLoot"] = true,
	}
	local values = {}
	local inputs = {}
	local menus = {
		["Summon"] = 1
	}
	local function GUICallback(key, item_type, value)
		if item_type == "enabled" then
			enables[key] = value
		elseif item_type == "value" then
			values[key] = value
		elseif item_type == "input" then
			inputs[key] = value
		elseif item_type == "menu" then
			menus[key] = value
		end
	end
	local items = {
		settingsfile = "AffWrath.xml",
		callback = GUICallback,
		{ type = "title",    text = "Afflction Wrath" },
		{ type = "separator" },
		{ type = "title",    text = "Summon Selection" },
		{
			type = "dropdown",
			menu = {
				{
					selected = (menus["Summon"] == 1),
					value = 1,
					text = ImpC
				},
				{
					selected = (menus["Summon"] == 2),
					value = 2,
					text = VoidC
				}
			},
			key = "Summon"
		},
		{ type = "separator" },
		{
			type = "entry",
			text = "Wand",
			tooltip = "Use Wand not shadowbolt",
			enabled = enables["Wand"],
			key = "Wand"
		},
		{
			type = "entry",
			text = "Autoloot",
			tooltip = "Autoloot Corpses",
			enabled = enables["AutoLoot"],
			key = "Wand"
		},
	}

	local incombat = false

	local function CombatEventCatcher(event, ...)
		if event == "PLAYER_REGEN_DISABLED" then
			incombat = true
		elseif event == "PLAYER_REGEN_ENABLED" then
			incombat = false
		end
	end
	local function OnLoad()
		ni.combatlog.registerhandler("Affliction_Wrath", CombatEventCatcher)
		ni.GUI.AddFrame("Affliction_Wrath", items)
	end
	local function OnUnload()
		ni.combatlog.unregisterhandler("Affliction_Wrath")
		ni.GUI.DestroyFrame("Affliction_Wrath")
	end

	local function BagSpace()
		local c = 0
		for bag = 0, NUM_BAG_SLOTS do
			local freeSlots = GetContainerNumFreeSlots(bag)
			c = c + freeSlots
		end
		return c
	end
	local looting
	local LootedUnits = {}
	local movingToCorpse
	function Loot(guid)
		ni.player.interact(guid)
		if _G.LootFrame:IsShown() then
			for i = 1, GetNumLootItems() do
				looting = true
				LootSlot(i)
			end
			if looting then
				ni.delayfor(1, function()
					looting = false
					LootedUnits[guid] = true
					CloseLoot()
				end)
			end
		end
		return looting
	end

	local function npcinrange(t, n)
		local npctable = {}
		t = true and UnitGUID(t) or t
		if t then
			for k, v in pairs(ni.objects) do
				if type(k) ~= "function" and (type(k) == "string" and type(v) == "table") then
					if k ~= t and not UnitIsPlayer(k) and not UnitIsDeadOrGhost(k) then
						local distance = v:distance(t)
						if (distance ~= nil and distance <= n) then
							tinsert(npctable, { guid = k, name = v.name, distance = distance });
						end
					end
				end
			end
		end
		return npctable;
	end;
	local spells = {
		--General
		Shoot = { id = 5019, name = GetSpellInfo(5019) },
		ArcaneTorrent = { id = 28730, name = GetSpellInfo(28730) },
		AutoAttack = { id = 6603, name = GetSpellInfo(6603) },
		--Affliction
		Corruption = { id = 172, name = GetSpellInfo(172) },
		DrainSoul = { id = 1120, name = GetSpellInfo(1120) },
		LifeTap = { id = 1454, name = GetSpellInfo(1454) },
		CurseofWeakness = { id = 702, name = GetSpellInfo(702) },
		CurseofAgony = { id = 980, name = GetSpellInfo(980) },
		Fear = { id = 5782, name = GetSpellInfo(5782) },
		--Demonology
		SummonImp = { id = 688, name = GetSpellInfo(688) },
		CreateHealthstone = { id = 6201, name = GetSpellInfo(6201) },
		DemonSkin = { id = 696, name = GetSpellInfo(696) },
		SummonVoidwalker = { id = 697, name = GetSpellInfo(697) },
		--Destruction
		Immolate = { id = 707, name = GetSpellInfo(707) },
		ShadowBolt = { id = 695, name = GetSpellInfo(695) }
	}

	local lastSpell, lastTarget = "", ""

	local function DoubleCast(spell, tar)
		if lastSpell == spell and lastTarget == UnitGUID(tar) then
			return true
		end
		return false
	end

	local function FacingLosCast(spell, tar)
		if ni.player.isfacing(tar, 145) and ni.player.los(tar) and IsSpellInRange(spell, tar) == 1 then
			ni.spell.cast(spell, tar)
			lastSpell = spell
			lastTarget = UnitGUID(tar)
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

	local abilities = {
		["AutoLoot"] = function()
			if enables["AutoLoot"]
					and not looting
					and (EvenInCombat or not UnitAffectingCombat("player"))
					and BagSpace() > 0
					and not ni.player.ismounted()
					and not ni.player.iscasting()
					and not ni.player.ischanneling() then
				for g, o in pairs(ni.objects) do
					if type(g) ~= "function" and type(g) == "string" and type(o) == "table" then
						if not LootedUnits[g] and o:unit() and UnitIsDead(g) and ni.unit.islootable(g) then
							if o:distance() < 3.9 then
								return Loot(g)
							end
						end
					end
				end
			end
		end,
		["Interact"] = function()
			local friends = npcinrange("player", 1)
			for i = 1, #friends do
				local guid = friends[i].name
				local tar = ni.objects[guid];
				ni.player.interact(guid)
			end
		end,
		["Pause"] = function()
			if
					IsMounted()
					or UnitIsDeadOrGhost("player")
					or not UnitExists("target")
					or UnitIsDeadOrGhost("target")
					or not UnitAffectingCombat("player") or
					(UnitExists("target") and not UnitCanAttack("player", "target"))
			then
				return true
			end
		end,
		["PetAttack"] = function()
			if UnitExists("pet") and not UnitIsDeadOrGhost("pet") then
				--Attack the same unit as player
				local petTarget = UnitGUID("pettarget")
				local playerTarget = UnitGUID("target")
				if petTarget ~= playerTarget then
					ni.player.runtext("/petattack")
				end
			end
		end,
		["DemonSkin"] = function()
			if not ni.player.buff(spells.DemonSkin.name) and ni.spell.available(spells.DemonSkin.name) then
				ni.spell.cast(spells.DemonSkin.name)
				return true
			end
		end,
		["SummonImp"] = function()
			if
					menus["Summon"] == 1 and (not (UnitExists("pet") == 1) or UnitIsDeadOrGhost("pet")) and
					ni.spell.available(spells.SummonImp.name) and
					not ni.player.ismoving()
			then
				ni.spell.cast(spells.SummonImp.name)
				return true
			end
		end,
		["SummonVoidwalker"] = function()
			if
					menus["Summon"] == 2 and (not (UnitExists("pet") == 1) or UnitIsDeadOrGhost("pet")) and ni.player.hasitem(6263) and
					ni.spell.available(spells.SummonVoidwalker.name) and
					not ni.player.ismoving()
			then
				ni.spell.cast(spells.SummonVoidwalker.name)
				return true
			end
		end,
		["Immolate"] = function()
			if
					ValidUsable(spells.Immolate.name, "target") and not ni.player.ismoving() and
					ni.unit.debuffremaining("target", spells.Immolate.name, "player") <= 2 and
					not DoubleCast(spells.Immolate.name, "target") and
					FacingLosCast(spells.Immolate.name, "target")
			then
				return true
			end
		end,
		["Corruption"] = function()
			if
					ValidUsable(spells.Corruption.name, "target") and
					ni.unit.debuffremaining("target", spells.Corruption.id, "player") <= 2 and
					not DoubleCast(spells.Corruption.name, "target") and
					FacingLosCast(spells.Corruption.name, "target")
			then
				return true
			end
		end,
		["CurseofAgony"] = function()
			if
					ValidUsable(spells.CurseofAgony.name, "target") and
					ni.unit.debuffremaining("target", spells.CurseofAgony.name, "player") <= 2 and
					not DoubleCast(spells.CurseofAgony.name, "target") and
					FacingLosCast(spells.CurseofAgony.name, "target")
			then
				return true
			end
		end,
		["ShadowBolt"] = function()
			if not enables["Wand"] and
					ValidUsable(spells.ShadowBolt.name, "target") and not ni.player.ismoving() and
					FacingLosCast(spells.ShadowBolt.name, "target")
			then
				return true
			end
		end,
		["Wand"] = function()
			local hasWand = GetInventoryItemID("player", 18)
			if enables["Wand"] and
					hasWand ~= nil and
					not IsCurrentSpell(spells.Shoot.id)
					and not ni.player.ismoving() then
				ni.spell.cast(spells.Shoot.id, "target")
				lastSpell = spells.Shoot.name
				lastTarget = UnitGUID("target")
			end
		end
	}
	ni.bootstrap.profile("Affliction_Wrath", queue, abilities, OnLoad, OnUnload)
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
	ni.bootstrap.profile("Free_Restoration_DarhangeR", queue, abilities);
end;
