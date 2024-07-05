local a = ni.utils.require("Riot") or ni.utils.require("Riot.enc")
local b, c = select(4, GetBuildInfo()), false
if b == 30300 and a then
	local d, d, e = GetSpellInfo(47878)
	local d, d, f = GetSpellInfo(13750)
	local d, d, g = GetSpellInfo(57934)
	local d, d, h = GetSpellInfo(6774)
	local d, d, i = GetSpellInfo(13877)
	local d, d, j = GetSpellInfo(1943)
	local d, d, k = GetSpellInfo(2098)
	local d, d, l = GetSpellInfo(51690)
	local d, d, m = GetSpellInfo(31224)
	local d, d, n = GetSpellInfo(1856)
	local d, d, o = GetSpellInfo(1766)
	hpotionIcon = "Interface\\Icons\\INV_Alchemy_Elixir_05"
	local p = {
		settingsfile = "Combat_Rogue.json",
		{ type = "title", text = "|cffff0000Combat Rogue by|r WH" },
		{ type = "separator" },
		{ type = "page", number = 1, text = "|cffFFFF00Главные настройки|r" },
		{ type = "separator" },
		{ type = "title", text = "|cffff6060Маленькие хитрости|r" },
		{
			type = "dropdown",
			menu = {
				{ selected = true, value = 1, text = "\124T" .. g .. ":20:20\124t На главного танка" },
				{ selected = false, value = 2, text = "\124T" .. g .. ":20:20\124t На офф танка" },
				{ selected = false, value = 3, text = "|cffFF0303По фокусу|r" },
				{ selected = false, value = 4, text = "|cffFF0303В ручную|r" }
			},
			key = "TricksOfTheTrade"
		},
		{ type = "separator" },
		{ type = "title", text = "|cffff6060Финишер|r" },
		{
			type = "dropdown",
			menu = {
				{ selected = true, value = 1, text = "\124T" .. j .. ":20:20\124t Рванная рана" },
				{ selected = false, value = 2, text = "\124T" .. k .. ":20:20\124t Потрошение" }
			},
			key = "Finisher"
		},
		{
			type = "entry",
			text = "Использовать финишер при (кол-во комбопоинтов)",
			tooltip = "Использовать финишер при (кол-во комбопоинтов)",
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
			text = "\124T" .. o .. ":24:24\124t Пинок",
			tooltip = "Исользовать пинок когда цель кастует",
			enabled = false,
			key = "Kick"
		},
		{
			type = "input",
			text = "Использовать кик когда процент каста",
			tooltip = "Использовать кик когда процент каста",
			enabled = true,
			value = 70,
			min = 1,
			max = 100,
			step = 1,
			width = 40,
			key = "KikcPersent"
		},
		{ type = "separator" },
		{
			type = "entry",
			text = "\124T" .. f .. ":24:24\124t Выброс адреналина",
			tooltip = "Исользовать выброс адреналина(На боссах)",
			enabled = true,
			key = "AdrenalineRush"
		},
		{
			type = "entry",
			text = "\124T" .. h .. ":24:24\124t Мясорубка",
			tooltip = "Использовать мясорубку при (кол-во комбопоинтов)",
			enabled = true,
			value = 1,
			min = 1,
			max = 5,
			step = 1,
			width = 40,
			key = "SliseAndDice"
		},
		{
			type = "entry",
			text = "\124T" .. l .. ":24:24\124t Череда убийств",
			tooltip = "Исользовать череду убийств (на боссах)",
			enabled = true,
			key = "KillingSpree"
		},
		{
			type = "entry",
			text = "\124T" .. i .. ":24:24\124t Шквал клинков",
			tooltip = "Исользовать шквал клинков (на боссах)",
			enabled = true,
			key = "BladeFlury"
		},
		{ type = "page", number = 2, text = "|cff00C957Защитные настройки|r" },
		{ type = "separator" },
		{
			type = "entry",
			text = "\124T" .. m .. ":24:24\124t Плащ теней",
			tooltip = "Использовать плащ теней, когда |cff00D700HP|r < % у персонажа < %.",
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
			text = "\124T" .. n .. ":24:24\124t Исчезновение",
			tooltip = "Исользовать исчезновение при срыве агро",
			enabled = true,
			key = "Vanish"
		},
		{
			type = "entry",
			text = "\124T" .. e .. ":24:24\124t Камень здоровья",
			tooltip = "Использовать камень здоровья Чернокнижника, когда |cff00D700HP|r < % у персонажа < %.",
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
			text = "\124T" .. hpotionIcon .. ":24:24\124t Зелье здоровья",
			tooltip = "Использовать зелье, когда |cff00D700HP|r < % у персонажа < %.",
			enabled = true,
			value = 30,
			min = 20,
			max = 60,
			step = 1,
			width = 40,
			key = "healpotionuse"
		}
	}
	local function q(r)
		for s, t in ipairs(p) do
			if t.type == "entry" and t.key ~= nil and t.key == r then
				return t.value, t.enabled
			end
			if t.type == "dropdown" and t.key ~= nil and t.key == r then
				for u, v in pairs(t.menu) do
					if v.selected then
						return v.value
					end
				end
			end
			if t.type == "input" and t.key ~= nil and t.key == r then
				return t.value
			end
		end
	end
	local function w()
		ni.GUI.AddFrame("Combat_Rogue_PvE", p)
	end
	local function x()
		ni.GUI.DestroyFrame("Combat_Rogue_PvE")
	end
	local spells = {
		AdrenalineRush = { id = 13750, name = GetSpellInfo(13750), icon = select(3, GetSpellInfo(13750)) },
		TricksOfTheTrade = GetSpellInfo(57934),
		SliseAndDice = GetSpellInfo(6774),
		BladeFlury = GetSpellInfo(13877),
		Rupture = GetSpellInfo(48672),
		Eviscrate = GetSpellInfo(48668),
		KillingSpree = GetSpellInfo(51690),
		CloakOfShadows = GetSpellInfo(31224),
		Vanish = GetSpellInfo(1856),
		SinisterStrike = GetSpellInfo(48638),
		BladeFan = GetSpellInfo(51723),
		Kick = GetSpellInfo(1766),
		potr = GetSpellInfo(48668)
	}
	local z = {
		"Riot",
		"Pause",
		"Combat specific Pause",
		"Healthstone (Use)",
		"Heal Potions (Use)",
		"TricksOfTheTrade",
		"CloakOfShadows",
		"Vanish",
		"Perchi",
		"BladeFan",
		"BladeFlury",
		"Finisher",
		"SliceAndDice",
		"KillingSpree",
		"Kick",
		"SinisterStrike",
		"AdrenalineRush"
	}
	local abilities = {
		["Riot"] = function()
			if not c then
				ni.frames.floatingtext:message("Cobat rogue By WH")
				print("|cffEE4000=======================================|r")
				print("|cffFFFF00Combat Rogue by whoamiwow|r")
				print("|cff00C957v0.0.1 release|r")
				print("https://discord.gg/6wCgV<RhQFs  ----- Wh Project")
				print("• Нажать кнопку АоЕ для переключения режимов")
				print("|cffEE4000=======================================|r")
				c = true
			end
		end,
		["Perchi"] = function()
			if
					ni.player.slotcastable(10) and ni.player.slotcd(10) == 0 and ni.unit.isboss("target") and
					ni.spell.valid("target", spells.SinisterStrike, true, true)
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
					not UnitAffectingCombat("player") and ni.vars.followEnabled
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
			local C, D = q("healpotionuse")
			local E = { 43569, 41166, 40087, 39671, 33934, 33447, 28100, 22829, 13446, 4596, 3928, 1710, 929, 858, 118 }
			if D and ni.player.hp() < C and not ni.player.isstunned() and UnitAffectingCombat("player") then
				for B = 1, #E do
					if ni.player.hasitem(E[B]) and ni.player.itemcd(E[B]) == 0 then
						ni.player.useitem(E[B])
					end
				end
			end
		end,
		["Healthstone (Use)"] = function()
			local C, D = q("healthstoneuse")
			local F = {
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
			if D and ni.player.hp() < C and not ni.player.isstunned() and UnitAffectingCombat("player") then
				for B = 1, #F do
					if ni.player.hasitem(F[B]) and ni.player.itemcd(F[B]) == 0 then
						ni.player.useitem(F[B])
					end
				end
			end
		end,
		["Kick"] = function()
			local d, D = q("Kick")
			local C = q("KikcPersent")
			if D then
				if ni.unit.iscasting("target") or ni.unit.ischanneling("target") then
					if
							ni.spell.available(spells.Kick) and a.spellusable(spells.Kick) and ni.spell.getinterrupt("player") and
							(ni.unit.castingpercent("target") >= C or ni.unit.channelpercent("target") >= C) and
							ni.spell.valid("target", spells.Kick, true, true)
					then
						ni.spell.castinterrupt("target")
					end
				end
			end
		end,
		["TricksOfTheTrade"] = function()
			local C = q("TricksOfTheTrade")
			local G, H = ni.tanks()
			if C == 1 then
				if G then
					if UnitExists(G.unit) then
						if ni.spell.valid(G.unit, spells.TricksOfTheTrade, false, true, true) then
							if ni.spell.available(spells.TricksOfTheTrade) then
								ni.spell.cast(spells.TricksOfTheTrade, G.unit)
								return true
							end
						end
					end
				end
				if C == 2 then
					if H then
						if UnitExists(H.unit) then
							if ni.spell.valid(H.unit, spells.TricksOfTheTrade, false, true, true) then
								if ni.spell.available(spells.TricksOfTheTrade) then
									ni.spell.cast(spells.TricksOfTheTrade, H.unit)
									return true
								end
							end
						end
						if C == 3 then
							if
									ni.unit.isboss("target") and ni.unit.exists("focus") and
									ni.spell.valid("focus", spells.TricksOfTheTrade, false, true, true)
							then
								if ni.spell.available(spells.TricksOfTheTrade) then
									ni.spell.cast(spells.TricksOfTheTrade, "focus")
									return true
								end
							end
						end
						if C == 4 then
						end
					end
				end
			end
		end,
		["BladeFlury"] = function()
			local d, D = q("BladeFlury")
			if D then
				if ni.unit.isboss("target") or ni.vars.combat.cd then
					if
							ni.spell.available(spells.BladeFlury) and a.spellusable(spells.BladeFlury) and
							ni.spell.valid("target", spells.SinisterStrike, true, true)
					then
						ni.spell.cast(spells.BladeFlury)
					end
				end
			end
		end,
		["SliceAndDice"] = function()
			local C, D = q("SliseAndDice")
			if D then
				if
						GetComboPoints("player", "target") >= C and ni.spell.available(spells.SliseAndDice) and
						not ni.vars.combat.aoe and
						ni.unit.buffremaining("player", spells.SliseAndDice) <= 1 and
						a.spellusable(spells.SliseAndDice) and
						ni.spell.valid("target", spells.SliseAndDice, true, true)
				then
					ni.spell.cast(spells.SliseAndDice, "target")
				end
			end
		end,
		["KillingSpree"] = function()
			local d, D = q("KillingSpree")
			if D then
				if
						(ni.unit.isboss("target") or ni.vars.combat.cd) and ni.player.buff(spells.SliseAndDice) and
						ni.spell.available(spells.KillingSpree) and
						a.spellusable(spells.KillingSpree) and
						ni.spell.valid("target", spells.SinisterStrike, true, true)
				then
					ni.spell.cast(spells.KillingSpree)
				end
			end
		end,
		["Finisher"] = function()
			local C = q("FinisherSettings")
			local I = q("Finisher")
			if I == 1 then
				if GetComboPoints("player", "target") >= C then
					if
							ni.spell.available(spells.Rupture) and a.spellusable(spells.Rupture) and
							not ni.unit.debuff("target", spells.Rupture, "player") and
							ni.spell.valid("target", spells.Rupture, true, true)
					then
						ni.spell.cast(spells.Rupture, "target")
					else
						if ni.unit.debuff("target", spells.Rupture, "player") then
							if
									GetComboPoints("player", "target") >= C and ni.spell.available(spells.Eviscrate) and
									a.spellusable(spells.Eviscrate) and
									ni.unit.debuffremaining("target", spells.Rupture, "player") >= 3 and
									ni.spell.valid("target", spells.Eviscrate, true, true)
							then
								ni.spell.cast(spells.Eviscrate, "target")
							end
						end
					end
				end
			end
			if I == 2 then
				if
						GetComboPoints("player", "target") >= C and ni.spell.available(spells.potr) and a.spellusable(spells.potr) and
						ni.spell.valid("target", spells.potr, true, true)
				then
					ni.spell.cast(spells.potr, "target")
					return true
				end
			end
		end,
		["BladeFan"] = function()
			if ni.vars.combat.aoe then
				if
						ni.spell.available(spells.BladeFan) and a.spellusable(spells.BladeFan) and
						a.getrange("target", spells.SinisterStrike) and
						ni.spell.valid("target", spells.SinisterStrike, true, true)
				then
					ni.spell.cast(spells.BladeFan, "target")
				end
			end
		end,
		["SinisterStrike"] = function()
			if
					a.spellusable(spells.SinisterStrike) and ni.spell.available(spells.SinisterStrike) and
					ni.spell.valid("target", spells.SinisterStrike, true, true)
			then
				ni.spell.cast(spells.SinisterStrike, "target")
			end
		end,
		["AdrenalineRush"] = function()
			local d, D = q("AdrenalineRush")
			if D then
				if ni.unit.isboss("target") or ni.vars.combat.cd then
					if ni.spell.available(spells.AdrenalineRush) and a.spellusable(spells.AdrenalineRush) then
						ni.spell.cast(spells.AdrenalineRush)
					end
				end
			end
		end,
		["CloakOfShadows"] = function()
			local C, D = q("CloakOfShadows")
			if D then
				if ni.player.hp() <= C and a.spellusable(spells.CloakOfShadows) and ni.spell.available(spells.CloakOfShadows) then
					ni.spell.cast(spells.CloakOfShadows)
				end
			end
		end,
		["Vanish"] = function()
			local d, D = q("Vanish")
			if D then
				if ni.unit.threat("player", "target") >= 2 then
					if ni.spell.available(spells.Vanish) and #ni.members >= 2 and a.spellusable(spells.Vanish) then
						ni.spell.cast(spells.Vanish)
					end
				end
			end
		end
	}
	ni.bootstrap.profile("Combat_Rogue_PvE", z, A, w, x)
else
	local z = { "Error" }
	local A = {
		["Error"] = function()
			ni.vars.profiles.enabled = false
			if b > 30300 then
				if GetLocale() == "ruRU" then
					ni.frames.floatingtext:message("Только для 3.3.5a!")
				else
					ni.frames.floatingtext:message("This profile for WotLK 3.3.5a!")
				end
			elseif Riot == nil then
				if GetLocale() == "ruRU" then
					ni.frames.floatingtext:message("Riot-файл поврежден или отсуствует!")
				else
					ni.frames.floatingtext:message("Riot file is missing or corrupted!")
				end
			end
		end
	}
	ni.bootstrap.profile("Combat_Rogue_PvE", z, A)
end
