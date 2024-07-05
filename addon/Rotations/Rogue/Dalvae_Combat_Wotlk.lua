local build = select(4, GetBuildInfo());
local wotlk = build == 30300 or false;
if wotlk then
	local spells = {
		AdrenalineRush = { id = 13750, name = GetSpellInfo(13750), icon = select(3, GetSpellInfo(13750)) },
		TricksOfTheTrade = { id = 57934, name = GetSpellInfo(57934), icon = select(3, GetSpellInfo(57934)) },
		SliceAndDice = { id = 6774, name = GetSpellInfo(6774), icon = select(3, GetSpellInfo(6774)) },
		BladeFlurry = { id = 13877, name = GetSpellInfo(13877), icon = select(3, GetSpellInfo(13877)) },
		Rupture = { id = 48672, name = GetSpellInfo(48672), icon = select(3, GetSpellInfo(48672)) },
		Eviscerate = { id = 48668, name = GetSpellInfo(48668), icon = select(3, GetSpellInfo(48668)) },
		KillingSpree = { id = 51690, name = GetSpellInfo(51690), icon = select(3, GetSpellInfo(51690)) },
		CloakOfShadows = { id = 31224, name = GetSpellInfo(31224), icon = select(3, GetSpellInfo(31224)) },
		Vanish = { id = 1856, name = GetSpellInfo(1856), icon = select(3, GetSpellInfo(1856)) },
		SinisterStrike = { id = 48638, name = GetSpellInfo(48638), icon = select(3, GetSpellInfo(48638)) },
		BladeFan = { id = 51723, name = GetSpellInfo(51723), icon = select(3, GetSpellInfo(51723)) },
		Kick = { id = 1766, name = GetSpellInfo(1766), icon = select(3, GetSpellInfo(1766)) },
		Potr = { id = 48668, name = GetSpellInfo(48668), icon = select(3, GetSpellInfo(48668)) }
	}
	local items = {
		settingsfile = "Dalvae_Combat_wotlk.json",
		{ type = "title",    text = "|cffff0000Combat Rogue by|r Dalvae" },
		{ type = "separator" },
		{ type = "page",     number = 1,                                 text = "|cffFFFF00Ajustes principales|r" },
		{ type = "separator" },
		{ type = "title",    text = "|cffff6060Tricks of the trade|r" },
		{
			type = "dropdown",
			menu = {
				{ selected = true,  value = 1, text = "\124T" .. spells.TricksOfTheTrade.icon .. ":20:20\124t En el tanque principal" },
				{ selected = false, value = 2, text = "\124T" .. spells.TricksOfTheTrade.icon .. ":20:20\124t En el tanque secundario" },
				{ selected = false, value = 3, text = "|cffFF0303En foco|r" },
				{ selected = false, value = 4, text = "|cffFF0303Manualmente|r" }
			},
			key = "TricksOfTheTrade"
		},
		{ type = "separator" },
		{ type = "title",    text = "|cffff6060Finisher|r" },
		{
			type = "dropdown",
			menu = {
				{ selected = false, value = 1, text = "\124T" .. spells.Rupture.icon .. ":20:20\124t Rupture" },
				{ selected = true,  value = 2, text = "\124T" .. spells.Eviscerate.icon .. ":20:20\124t Eviscerate" }
			},
			key = "Finisher"
		},
		{
			type = "entry",
			text = "Usar finalizador con (puntos de combo)",
			tooltip = "Usar finalizador con (puntos de combo)",
			enabled = true,
			value = 5,
			min = 1,
			max = 5,
			step = 1,
			width = 40,
			key = "FinisherSettings"
		},
		{ type = "separator" },
		{
			type = "entry",
			text = "\124T" .. spells.Kick.icon .. ":24:24\124t  Patada",
			tooltip = "Usar patada cuando el objetivo está lanzando un hechizo",
			enabled = false,
			key = "Kick"
		},
		{
			type = "input",
			text = "Usar patada cuando el porcentaje de lanzamiento es",
			tooltip = "Usar patada cuando el porcentaje de lanzamiento es",
			enabled = true,
			value = 70,
			min = 1,
			max = 100,
			step = 1,
			width = 40,
			key = "KickPercent"
		},
		{ type = "separator" },
		{
			type = "entry",
			text = "\124T" .. spells.AdrenalineRush.icon .. ":24:24\124t Descarga de adrenalina",
			tooltip = "Usar descarga de adrenalina (en jefes)",
			enabled = true,
			key = "AdrenalineRush"
		},
		{
			type = "entry",
			text = "\124T" .. spells.SliceAndDice.icon .. ":24:24\124t Hacer Picadillo",
			tooltip = "Usar Hacer Picadillo con (cantidad de puntos de combo)",
			enabled = true,
			value = 1,
			min = 1,
			max = 5,
			step = 1,
			width = 40,
			key = "SliceAndDice"
		},
		{
			type = "entry",
			text = "\124T" .. spells.KillingSpree.icon .. ":24:24\124t Racha de asesinatos",
			tooltip = "Usar Racha de asesinatos (en jefes)",
			enabled = true,
			key = "KillingSpree"
		},
		{
			type = "entry",
			text = "\124T" .. spells.BladeFlurry.icon .. ":24:24\124t Tormenta de hojas",
			tooltip = "Usar Tormenta de hojas (en jefes)",
			enabled = true,
			key = "BladeFlurry"
		},
		{ type = "page",     number = 2, text = "|cff00C957Configuración de defensa|r" },
		{ type = "separator" },
		{
			type = "entry",
			text = "\124T" .. spells.CloakOfShadows.icon .. ":24:24\124t Capa de Sombras",
			tooltip = "Usar Capa de Sombras cuando |cff00D700HP|r < % del personaje < %.",
			enabled = true,
			value = 15,
			min = 25,
			max = 65,
			step = 1,
			width = 40,
			key = "CloakOfShadows"
		},
		{
			type = "entry",
			text = "\124T" .. spells.Vanish.icon .. ":24:24\124t Desaparición",
			tooltip = "Usar Desaparición al perder el agro",
			enabled = true,
			key = "Vanish"
		},
		{
			type = "entry",
			text = "\124T" .. select(3, GetSpellInfo(47878)) .. ":24:24\124t Piedra de Salud",
			tooltip = "Usar Piedra de Salud del Brujo cuando |cff00D700HP|r < % del personaje < %.",
			enabled = true,
			value = 35,
			min = 25,
			max = 65,
			step = 1,
			width = 40,
			key = "healthstoneuse"
		},
		{
			type = "entry",
			text = "\124T" .. "Interface\\Icons\\INV_Alchemy_Elixir_05" .. ":24:24\124t Poción de Salud",
			tooltip = "Usar poción cuando |cff00D700HP|r < % del personaje < %.",
			enabled = true,
			value = 30,
			min = 20,
			max = 60,
			step = 1,
			width = 40,
			key = "healpotionuse"
		}
	}
	local function GetSetting(name)
		for s, t in ipairs(items) do
			if t.type == "entry"
					and t.key ~= nil
					and t.key == name
			then
				return t.value, t.enabled
			end
			if t.type == "dropdown" and
					t.key ~= nil
					and t.key == name then
				for u, v in pairs(t.menu) do
					if v.selected then
						return v.value
					end
				end
			end
			if t.type == "input"
					and t.key ~= nil
					and t.key == name
			then
				return t.value
			end
		end
	end
	local function onLoad()
		print("Rotation \124cFF15E615Combat Dalvae")
		ni.GUI.AddFrame("Dalvae_Combat_wotlk", items)
	end
	local function onUnload()
		print("Rotation \124cFFE61515stopped!")
		ni.GUI.DestroyFrame("Dalvae_Combat_wotlk")
	end
	local queue = {
		"Venenos",
		"Pause",
		"Combat specific Pause",
		"Healthstone (Use)",
		"Heal Potions (Use)",
		"TricksOfTheTrade",
		"CloakOfShadows",
		"Vanish",
		"Guantes",
		"SliceAndDice",
		"BladeFan",
		"BladeFlurry",
		"Finisher",
		"KillingSpree",
		"Kick",
		"SinisterStrike",
		"AdrenalineRush"
	}
	local abilities = {
		["Venenos"] = function()
			local hasMainHandEnchant, mainHandExpiration, mainHandCharges, mainHandEnchantID, hasOffHandEnchant, offHandExpiration, offHandCharges, offHandEnchantID =
					GetWeaponEnchantInfo()

			-- Imprimir los IDs de los encantamientos

			if not hasMainHandEnchant
					and ni.player.hasitem(43231)
			-- and ni.player.buffremainig()
			then
				ni.player.useitem(43231)
				ni.player.runtext("/use 16")
			end
			if not hasOffHandEnchant
					and ni.player.hasitem(43233)
			then
				ni.player.useitem(43233)
				ni.player.runtext("/use 17")
			end
		end,

		["Guantes"] = function()
			if
					ni.player.slotcastable(10)
					and ni.player.slotcd(10) == 0
					and ni.unit.isboss("target") and
					ni.spell.valid("target", spells.SinisterStrike.id, true, true)
			then
				if ni.player.useinventoryitem(10) then
					return true
				end
			end
		end,
		["Pause"] = function()
			if
					IsMounted() or UnitInVehicle("player") or UnitIsDeadOrGhost("player") or UnitChannelInfo("player") or
					UnitCastingInfo("player") or
					ni.vars.combat.casting == true or
					ni.player.islooting() or
					ni.player.buff(GetSpellInfo(430)) or
					ni.player.buff(GetSpellInfo(433)) or
					not UnitAffectingCombat("player")
			then
				return true
			end
		end,
		["Combat specific Pause"] = function()
			if UnitAffectingCombat("player") then
				return false
			end
			for B = 1, #ni.members do
				if UnitAffectingCombat(ni.members[B].unit) then
					return false
				end
			end
			return true
		end,
		["Heal Potions (Use)"] = function()
			local value, enabled = GetSetting("healpotionuse");
			local potions        = { 43569, 41166, 40087, 39671, 33934, 33447, 28100, 22829, 13446, 4596, 3928, 1710, 929, 858, 118 }
			if enabled
					and ni.player.hp() < value
					and not ni.player.isstunned()
					and UnitAffectingCombat("player")
			then
				for i = 1, #potions do
					if ni.player.hasitem(potions[i]) and ni.player.itemcd(potions[i]) == 0 then
						ni.player.useitem(potions[i])
					end
				end
			end
		end,
		["Healthstone (Use)"] = function()
			local value, enabled = GetSetting("healthstoneuse");
			local healthstones = {
				36894,
				36893,
				36892,
				36891,
				36890,
				36889,
				22105,
				22104,
				22103,
				19013,
				19012,
				9421,
				19011,
				19010,
				5510,
				19009,
				19008,
				5509,
				19007,
				19006,
				5511,
				19005,
				19004,
				5512
			}
			if enabled
					and ni.player.hp() < value
					and not ni.player.isstunned()
					and UnitAffectingCombat("player") then
				for i = 1, #healthstones do
					if ni.player.hasitem(healthstones[i]) and ni.player.itemcd(healthstones[i]) == 0 then
						ni.player.useitem(healthstones[i])
					end
				end
			end
		end,
		["Kick"] = function()
			local value, enabled = GetSetting("KickPercent");
			if enabled then
				if ni.unit.iscasting("target") or ni.unit.ischanneling("target") then
					if
							ni.spell.available(spells.Kick.id)
							-- and a.spellusable(spells.Kick.id)
							and ni.spell.getinterrupt("player") and
							(ni.unit.castingpercent("target") >= value
								or ni.unit.channelpercent("target") >= value)
							and
							ni.spell.valid("target", spells.Kick.id, true, true)
					then
						ni.spell.castinterrupt("target")
					end
				end
			end
		end,
		["TricksOfTheTrade"] = function()
			local value = GetSetting("TricksOfTheTrade");
			local G, H = ni.tanks()
			if value == 1 then
				if G then
					if UnitExists(G.unit) then
						if ni.spell.valid(G.unit, spells.TricksOfTheTrade.id, false, true, true) then
							if ni.spell.available(spells.TricksOfTheTrade.id) then
								ni.spell.cast(spells.TricksOfTheTrade.id, G.unit)
								return true
							end
						end
					end
				end
				if value == 2 then
					if H then
						if UnitExists(H.unit) then
							if ni.spell.valid(H.unit, spells.TricksOfTheTrade.id, false, true, true) then
								if ni.spell.available(spells.TricksOfTheTrade.id) then
									ni.spell.cast(spells.TricksOfTheTrade.id, H.unit)
									return true
								end
							end
						end
						if value == 3 then
							if
									ni.unit.isboss("target") and ni.unit.exists("focus") and
									ni.spell.valid("focus", spells.TricksOfTheTrade.id, false, true, true)
							then
								if ni.spell.available(spells.TricksOfTheTrade.id) then
									ni.spell.cast(spells.TricksOfTheTrade.id, "focus")
									return true
								end
							end
						end
						if value == 4 then
						end
					end
				end
			end
		end,
		["BladeFlurry"] = function()
			local _, enabled = GetSetting("BladeFlurry");
			if enabled then
				if ni.unit.isboss("target") or ni.vars.combat.cd then
					if
							ni.spell.available(spells.BladeFlurry.id)
							and ni.player.buff(spells.SliceAndDice.id)
							-- and a.spellusable(spells.BladeFlurry)
							and ni.spell.valid("target", spells.SinisterStrike.id, true, true)
					then
						ni.spell.cast(spells.BladeFlurry.id)
					end
				end
			end
		end,
		["SliceAndDice"] = function()
			local value, enabled = GetSetting("SliceAndDice")
			if enabled then
				if
						GetComboPoints("player", "target") >= value and ni.spell.available(spells.SliceAndDice.id)
						and ni.unit.buffremaining("player", spells.SliceAndDice.id) <= 2
						and ni.spell.valid("target", spells.SliceAndDice.id, false, true)
				then
					ni.spell.cast(spells.SliceAndDice.id, "target")
				end
			end
		end,
		["KillingSpree"] = function()
			local _, enabled = GetSetting("KillingSpree")
			if enabled then
				if
						(ni.unit.isboss("target") or ni.vars.combat.cd) and ni.player.buff(spells.SliceAndDice.id) and
						ni.spell.available(spells.KillingSpree.id)
						and ni.spell.valid("target", spells.SinisterStrike.id, true, true)
				then
					ni.spell.cast(spells.KillingSpree.id, "target")
				end
			end
		end,
		["Finisher"] = function()
			local value, enabled = GetSetting("FinisherSettings")
			local I = GetSetting("Finisher")
			if I == 1 then
				if
						not ni.unit.debuff("target", spells.Rupture.id, "player")
				then
					if
							GetComboPoints("player", "target") >= 5
							and ni.spell.available(spells.Rupture.id)
							and ni.spell.valid("target", spells.Rupture.id, true, true)
					then
						ni.spell.cast(spells.Rupture.id, "target")
					end
				else
					if ni.unit.debuff("target", spells.Rupture.id, "player") then
						if
								GetComboPoints("player", "target") >= 4
								and ni.spell.available(spells.Eviscerate.id)
								and ni.unit.debuffremaining("target", spells.Rupture.id, "player") >= 3 and
								ni.spell.valid("target", spells.Eviscerate.id, true, true)
						then
							ni.spell.cast(spells.Eviscerate.id, "target")
						end
					end
				end
			end
			if I == 2 then
				if
						GetComboPoints("player", "target") >= 4 and ni.spell.available(spells.Potr.id) and
						ni.spell.valid("target", spells.Potr.id, true, true)
				then
					ni.spell.cast(spells.Potr.id, "target")
					return true
				end
			end
		end,
		["BladeFan"] = function()
			if ni.vars.combat.aoe then
				local enemies = ni.unit.enemiesinrange("player", 8)
				if
						ni.spell.available(spells.BladeFan.id)
						and #enemies >= 3
				then
					ni.spell.cast(spells.BladeFan.id)
				end
			end
		end,
		["SinisterStrike"] = function()
			if ni.spell.available(spells.SinisterStrike.id)
					and ni.spell.valid("target", spells.SinisterStrike.id, true, true)
					and GetComboPoints("player", "target") < 5
			then
				ni.spell.cast(spells.SinisterStrike.id, "target")
			end
		end,
		["AdrenalineRush"] = function()
			local _, enabled = GetSetting("AdrenalineRush")
			if enabled then
				if ni.unit.isboss("target")
						or ni.vars.combat.cd then
					if ni.spell.available(spells.AdrenalineRush.id)
							and ni.spell.cd(spells.KillingSpree.id) > 10
							and ni.spell.cd(spells.KillingSpree.id) < 72
					then
						ni.spell.cast(spells.AdrenalineRush.id)
					end
				end
			end
		end,
		["CloakOfShadows"] = function()
			local value, enabled = GetSetting("CloakOfShadows")
			if enabled then
				if ni.player.hp() <= value and ni.spell.available(spells.CloakOfShadows.id) then
					ni.spell.cast(spells.CloakOfShadows.id)
				end
			end
		end,
		["Vanish"] = function()
			local _, enabled = GetSetting("Vanish")
			if enabled then
				if ni.unit.threat("player", "target") >= 2 then
					if ni.spell.available(spells.Vanish.id) and #ni.members >= 2 then
						ni.spell.cast(spells.Vanish.id)
					end
				end
			end
		end
	}

	ni.bootstrap.profile("Dalvae_Combat_Wotlk", queue, abilities, onLoad, onUnload)
end
