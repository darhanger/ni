local queue = {
	"Pause",
	"BloodPresence",
	"Cache",
	"MindFreeze",
	"VampiricBlood",
	"BoneShield",
	"IceboundFortitude",
	"RuneTap",
	"DancingRuneWeapon",
	"DeathandDecay",
	"BloodBoil",
	"Pestilence",
	"Outbreak",
	"IcyTouch",
	"PlagueStrike",
	"DeathStrike",
	"HeartStrike",
	"RuneStrike"
}

local spells = {
	--build == 40300
	--General icon = select(2, GetSpellTabInfo(1))
	AutoAttack = {id = 6603, name = GetSpellInfo(6603), icon = select(3, GetSpellInfo(6603))},
	--Blood icon = select(2, GetSpellTabInfo(2))
	BloodBoil = {id = 48721, name = GetSpellInfo(48721), icon = select(3, GetSpellInfo(48721))},
	BloodPresence = {id = 48263, name = GetSpellInfo(48263), icon = select(3, GetSpellInfo(48263))},
	BloodRites = {id = 50034, name = GetSpellInfo(50034), icon = select(3, GetSpellInfo(50034))},
	BloodStrike = {id = 45902, name = GetSpellInfo(45902), icon = select(3, GetSpellInfo(45902))},
	BoneShield = {id = 49222, name = GetSpellInfo(49222), icon = select(3, GetSpellInfo(49222))},
	DeathStrike = {id = 49998, name = GetSpellInfo(49998), icon = select(3, GetSpellInfo(49998))},
	HeartStrike = {id = 55050, name = GetSpellInfo(55050), icon = select(3, GetSpellInfo(55050))},
	Parry = {id = 82246, name = GetSpellInfo(82246), icon = select(3, GetSpellInfo(82246))},
	Pestilence = {id = 50842, name = GetSpellInfo(50842), icon = select(3, GetSpellInfo(50842))},
	RuneTap = {id = 48982, name = GetSpellInfo(48982), icon = select(3, GetSpellInfo(48982))},
	Strangulate = {id = 47476, name = GetSpellInfo(47476), icon = select(3, GetSpellInfo(47476))},
	VampiricBlood = {id = 55233, name = GetSpellInfo(55233), icon = select(3, GetSpellInfo(55233))},
	Vengeance = {id = 93099, name = GetSpellInfo(93099), icon = select(3, GetSpellInfo(93099))},
	VeteranoftheThirdWar = {id = 50029, name = GetSpellInfo(50029), icon = select(3, GetSpellInfo(50029))},
	BloodTap = {id = 45529, name = GetSpellInfo(45529), icon = select(3, GetSpellInfo(45529))},
	DarkCommand = {id = 56222, name = GetSpellInfo(56222), icon = select(3, GetSpellInfo(56222))},
	DeathPact = {id = 48743, name = GetSpellInfo(48743), icon = select(3, GetSpellInfo(48743))},
	DarkSimulacrum = {id = 77606, name = GetSpellInfo(77606), icon = select(3, GetSpellInfo(77606))},
	DancingRuneWeapon = {id = 49028, name = GetSpellInfo(49028), icon = select(3, GetSpellInfo(49028))},
	--Frost icon = select(2, GetSpellTabInfo(3))
	ChainsofIce = {id = 45524, name = GetSpellInfo(45524), icon = select(3, GetSpellInfo(45524))},
	FrostFever = {id = 59921, name = GetSpellInfo(59921), icon = select(3, GetSpellInfo(59921))},
	FrostPresence = {id = 48266, name = GetSpellInfo(48266), icon = select(3, GetSpellInfo(48266))},
	IceboundFortitude = {id = 48792, name = GetSpellInfo(48792), icon = select(3, GetSpellInfo(48792))},
	IcyTouch = {id = 45477, name = GetSpellInfo(45477), icon = select(3, GetSpellInfo(45477))},
	MindFreeze = {id = 47528, name = GetSpellInfo(47528), icon = select(3, GetSpellInfo(47528))},
	Obliterate = {id = 49020, name = GetSpellInfo(49020), icon = select(3, GetSpellInfo(49020))},
	PathofFrost = {id = 3714, name = GetSpellInfo(3714), icon = select(3, GetSpellInfo(3714))},
	RunicFocus = {id = 61455, name = GetSpellInfo(61455), icon = select(3, GetSpellInfo(61455))},
	FesteringStrike = {id = 85948, name = GetSpellInfo(85948), icon = select(3, GetSpellInfo(85948))},
	HornofWinter = {id = 57330, name = GetSpellInfo(57330), icon = select(3, GetSpellInfo(57330))},
	RuneStrike = {id = 56815, name = GetSpellInfo(56815), icon = select(3, GetSpellInfo(56815))},
	RunicEmpowerment = {id = 81229, name = GetSpellInfo(81229), icon = select(3, GetSpellInfo(81229))},
	EmpowerRuneWeapon = {id = 47568, name = GetSpellInfo(47568), icon = select(3, GetSpellInfo(47568))},
	--Unholy icon = select(2, GetSpellTabInfo(4))
	BloodPlague = {id = 59879, name = GetSpellInfo(59879), icon = select(3, GetSpellInfo(59879))},
	DeathandDecay = {id = 43265, name = GetSpellInfo(43265), icon = select(3, GetSpellInfo(43265))},
	DeathCoil = {id = 47541, name = GetSpellInfo(47541), icon = select(3, GetSpellInfo(47541))},
	DeathGate = {id = 50977, name = GetSpellInfo(50977), icon = select(3, GetSpellInfo(50977))},
	DeathGrip = {id = 49576, name = GetSpellInfo(49576), icon = select(3, GetSpellInfo(49576))},
	PlagueStrike = {id = 45462, name = GetSpellInfo(45462), icon = select(3, GetSpellInfo(45462))},
	RaiseDead = {id = 46584, name = GetSpellInfo(46584), icon = select(3, GetSpellInfo(46584))},
	AntiMagicShell = {id = 48707, name = GetSpellInfo(48707), icon = select(3, GetSpellInfo(48707))},
	UnholyPresence = {id = 48265, name = GetSpellInfo(48265), icon = select(3, GetSpellInfo(48265))},
	RaiseAlly = {id = 61999, name = GetSpellInfo(61999), icon = select(3, GetSpellInfo(61999))},
	ArmyoftheDead = {id = 42650, name = GetSpellInfo(42650), icon = select(3, GetSpellInfo(42650))},
	Outbreak = {id = 77575, name = GetSpellInfo(77575), icon = select(3, GetSpellInfo(77575))},
	NecroticStrike = {id = 73975, name = GetSpellInfo(73975), icon = select(3, GetSpellInfo(73975))}
}

local IsSpellInRange,
	IsCurrentSpell,
	IsMounted,
	UnitIsDeadOrGhost,
	UnitExists,
	UnitCanAttack,
	GetShapeshiftFormID,
	IsSpellKnown =
	IsSpellInRange,
	IsCurrentSpell,
	IsMounted,
	UnitIsDeadOrGhost,
	UnitExists,
	UnitCanAttack,
	GetShapeshiftFormID,
	IsSpellKnown

local enables = {
	["RuneTap"] = true,
	["BoneShield"] = true,
	["VampiricBlood"] = true,
	["IceboundFortitude"] = true,
	["DancingRuneWeapon"] = true
}
local values = {
	["RuneTap"] = 40,
	["VampiricBlood"] = 30,
	["IceboundFortitude"] = 40,
	["DancingRuneWeapon"] = 30
}
local inputs = {}
local menus = {}

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
	settingsfile = "blood_cata.xml",
	callback = GUICallback,
	{type = "title", text = "\124T" .. select(2, GetSpellTabInfo(2)) .. ":20:20\124tBlood DK Cata"},
	{type = "separator"},
	{type = "title", text = "Survival Cooldowns"},
	{
		type = "entry",
		text = "\124T" .. spells.BoneShield.icon .. ":20:20\124t " .. spells.BoneShield.name,
		tooltip = "Use " .. spells.BoneShield.name,
		enabled = enables["BoneShield"],
		key = "BoneShield"
	},
	{
		type = "entry",
		text = "\124T" .. spells.DancingRuneWeapon.icon .. ":20:20\124t " .. spells.DancingRuneWeapon.name,
		tooltip = "Use Dancing Rune Weapon when below this Hp pct",
		value = values["DancingRuneWeapon"],
		enabled = enables["DancingRuneWeapon"],
		key = "DancingRuneWeapon"
	},
	{
		type = "entry",
		text = "\124T" .. spells.IceboundFortitude.icon .. ":20:20\124t " .. spells.IceboundFortitude.name,
		tooltip = "Use Icebound Fortitude when below this Hp pct",
		value = values["IceboundFortitude"],
		enabled = enables["IceboundFortitude"],
		key = "IceboundFortitude"
	},
	{
		type = "entry",
		text = "\124T" .. spells.RuneTap.icon .. ":20:20\124t " .. spells.RuneTap.name,
		tooltip = "Use Rune Tap when below this Hp pct",
		value = values["RuneTap"],
		enabled = enables["RuneTap"],
		key = "RuneTap"
	},
	{
		type = "entry",
		text = "\124T" .. spells.VampiricBlood.icon .. ":20:20\124t " .. spells.VampiricBlood.name,
		tooltip = "Use Vampiric Blood when below this Hp pct",
		value = values["VampiricBlood"],
		enabled = enables["VampiricBlood"],
		key = "VampiricBlood"
	}
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
	ni.combatlog.registerhandler("Prot-Cata", CombatEventCatcher)
	ni.GUI.AddFrame("Prot-Cata", items)
end
local function OnUnload()
	ni.combatlog.unregisterhandler("Prot-Cata")
	ni.GUI.DestroyFrame("Prot-Cata")
end

local enemies = {}

local function ActiveEnemies()
	table.wipe(enemies)
	enemies = ni.player.enemiesinrange(10)
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
		ni.debug.log(string.format("Casting %s on %s", spell, tar))
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

local cache = {
	bloodplauge = 0,
	frostFever = 0,
	targets = nil,
	bloodRune = 0
}

local t, p = "target", "player"

local abilities = {
	["Pause"] = function()
		if
			IsMounted() or UnitIsDeadOrGhost(p) or not UnitExists(t) or UnitIsDeadOrGhost(t) or
				(UnitExists(t) and not UnitCanAttack(p, t))
		 then
			return true
		end
	end,
	["Cache"] = function()
		cache.bloodRune = select(2, ni.rune.bloodrunecd())
		cache.bloodPlauge = ni.unit.debuffremaining(t, 55078, p)
		cache.frostFever = ni.unit.debuffremaining(t, 55095, p)
		cache.targets = ni.unit.enemiesinrange(t, 10)
		ActiveEnemies()
	end,
	["Outbreak"] = function()
		if
			cache.bloodPlauge <= 2 and cache.frostFever <= 2 and ValidUsable(spells.Outbreak.id, t) and
				FacingLosCast(spells.Outbreak.name, t)
		 then
			return true
		end
	end,
	["IcyTouch"] = function()
		if cache.frostFever <= 2 and ValidUsable(spells.IcyTouch.id, t) and FacingLosCast(spells.IcyTouch.name, t) then
			return true
		end
	end,
	["PlagueStrike"] = function()
		if cache.bloodPlauge <= 2 and ValidUsable(spells.PlagueStrike.id, t) and FacingLosCast(spells.PlagueStrike.name, t) then
			return true
		end
	end,
	["DeathStrike"] = function()
		if ValidUsable(spells.DeathStrike.id, t) and FacingLosCast(spells.DeathStrike.name, t) then
			return true
		end
	end,
	["HeartStrike"] = function()
		if ValidUsable(spells.HeartStrike.id, t) and cache.bloodRune >= 1 and FacingLosCast(spells.HeartStrike.name, t) then
			return true
		end
	end,
	["RuneStrike"] = function()
		if ValidUsable(spells.RuneStrike.id, t) and FacingLosCast(spells.RuneStrike.name, t) then
			return true
		end
	end,
	["BoneShield"] = function()
		if
			enables["BoneShield"] and ni.spell.available(spells.BoneShield.id) and not ni.player.buff(spells.BoneShield.id) and
				cache.bloodRune >= 1
		 then
			ni.spell.cast(spells.BoneShield.name)
			return true
		end
	end,
	["BloodPresence"] = function()
		if ni.spell.available(spells.BloodPresence.id) and not ni.player.buff(spells.BloodPresence.id) then
			ni.spell.cast(spells.BloodPresence.name)
			return true
		end
	end,
	["DeathandDecay"] = function()
		if
			ni.spell.available(spells.DeathandDecay.id) and #cache.targets >= 2 and IsSpellInRange(spells.IcyTouch.name, t) == 1
		 then
			ni.spell.castat(spells.DeathandDecay.name, t)
			return true
		end
	end,
	["Pestilence"] = function()
		local castit = false
		if ValidUsable(spells.Pestilence.id, t) and #cache.targets >= 2 and cache.bloodPlauge > 2 and cache.frostFever > 2 then
			for k, v in ipairs(cache.targets) do
				if ni.player.threat(v.guid) ~= -1 then
					if ni.unit.debuffremaining(v.guid, 55078, p) < 2 or ni.unit.debuffremaining(v.guid, 55078, p) < 2 then
						castit = true
						break
					end
				end
			end
			if castit and FacingLosCast(spells.Pestilence.name, t) then
				return true
			end
		end
	end,
	["BloodBoil"] = function()
		local castit = false
		if ValidUsable(spells.BloodBoil.id, t) and #cache.targets >= 2 and cache.bloodPlauge > 2 and cache.frostFever > 2 then
			for k, v in ipairs(cache.targets) do
				if ni.player.threat(v.guid) ~= -1 then
					if ni.unit.debuffremaining(v.guid, 55078, p) > 2 or ni.unit.debuffremaining(v.guid, 55078, p) > 2 then
						castit = true
						break
					end
				end
			end
			if castit and FacingLosCast(spells.BloodBoil.name, t) then
				return true
			end
		end
	end,
	["RuneTap"] = function()
		if enables["RuneTap"] and ni.spell.available(spells.RuneTap.id) and ni.player.hp() <= values["RuneTap"] then
			ni.spell.cast(spells.RuneTap.name)
		end
	end,
	["VampiricBlood"] = function()
		if
			enables["VampiricBlood"] and ni.spell.available(spells.VampiricBlood.id) and
				ni.player.hp() <= values["VampiricBlood"]
		 then
			ni.spell.cast(spells.VampiricBlood.name)
		end
	end,
	["IceboundFortitude"] = function()
		if
			enables["IceboundFortitude"] and ni.spell.available(spells.IceboundFortitude.id) and
				ni.player.hp() <= values["IceboundFortitude"]
		 then
			ni.spell.cast(spells.IceboundFortitude.name)
		end
	end,
	["DancingRuneWeapon"] = function()
		if
			enables["DancingRuneWeapon"] and ni.spell.available(spells.DancingRuneWeapon.id) and
				ni.player.hp() <= values["DancingRuneWeapon"]
		 then
			ni.spell.cast(spells.DancingRuneWeapon.name)
		end
	end,
	["MindFreeze"] = function()
		if ni.spell.shouldinterrupt(t) and ValidUsable(spells.MindFreeze.id, t) and FacingLosCast(spells.MindFreeze.name, t) then
			return true
		end
	end
}
ni.bootstrap.profile("Blood - Cata", queue, abilities, OnLoad, OnUnload)
