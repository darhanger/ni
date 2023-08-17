if Sirus then
	local t4 = 0
	if ni.player.hasitemequipped(29056) then
		t4 = t4 + 1
	end
	if ni.player.hasitemequipped(29057) then
		t4 = t4 + 1
	end
	if ni.player.hasitemequipped(29058) then
		t4 = t4 + 1
	end
	if ni.player.hasitemequipped(29059) then
		t4 = t4 + 1
	end
	if ni.player.hasitemequipped(29060) then
		t4 = t4 + 1
	end
	if ni.player.hasitemequipped(100440) then
		t4 = t4 + 1
	end
	if ni.player.hasitemequipped(100441) then
		t4 = t4 + 1
	end
	if ni.player.hasitemequipped(100442) then
		t4 = t4 + 1
	end
	if ni.player.hasitemequipped(100443) then
		t4 = t4 + 1
	end
	if ni.player.hasitemequipped(100444) then
		t4 = t4 + 1
	end
	if ni.player.hasitemequipped(101340) then
		t4 = t4 + 1
	end
	if ni.player.hasitemequipped(101341) then
		t4 = t4 + 1
	end
	if ni.player.hasitemequipped(101342) then
		t4 = t4 + 1
	end
	if ni.player.hasitemequipped(101343) then
		t4 = t4 + 1
	end
	if ni.player.hasitemequipped(101344) then
		t4 = t4 + 1
	end
	if t4 > 3 then
		local enables = {
			["target"] = true,
			["pet"] = true,
			["tucha"] = true,
			["kamen"] = true,
			["fd"] = true,
			["aoe"] = true,
			["decurse"] = false,
			["decurse_2"] = false,
			["decurse_3"] = false,
			["debug"] = false,
		}
		local values = {
			osvob = 4,
			pet = 60,
			tucha = 50,
			aoe = 3,
			kamen = 30,
		}
		local inputs = {
			decursee = "",
			decurseee = "Мертвящая чума",
		}
		local menus = {
		}
		local function GUICallback(key, item_type, value)
			if item_type == "enabled" then
				enables[key] = value;
			elseif item_type == "value" then
				values[key] = value;
			elseif item_type == "input" then
				inputs[key] = value;
			elseif item_type == "menu" then
				menus[key] = value;
			end
		end
		local items = {
			settingsfile = "shp_4t4_by_makaren.json",
			callback = GUICallback,
			{ type = "title", text = "shp_4t4 by |c0000CED1Makaren|r" },
			{ type = "separator" },
			{ type = "title", text = "|cffFF7C0AProfile version 2.0.0|r" },
			{ type = "separator" },
			{ type = "page", number = 1, text = "|cffFFFF00Общие настройки|r" },
			{ type = "separator" },
			{ type = "entry", text = ni.spell.icon(69762) .. " Освобожденная магия",
				tooltip = "Количество набираемых стаков Освобожденной магии |cFF00FFFFЦлк(Синдрагоса)|r",
				value = 4, min = 1, max = 10, step = 1, key = "osvob" },
			{ type = "separator" },
			{ type = "entry", text = ni.spell.icon(6603) .. " Авто таргет",
				tooltip = "Автоматически выбирает таргет при его отсутствии",
				enabled = true, key = "target" },
			{ type = "separator" },
			{
				type = "entry",
				text = ni.spell.icon(11729) .. " Камень здоровья",
				tooltip = "Использует Огурец при |cFF00FF00Hp <|r\
Работает в связке с функцией TTD(Time To Die)",
				enabled = true,
				value = 30,
				min = 1,
				max = 100,
				step = 1,
				key = "kamen"
			},
			{ type = "separator" },
			{ type = "entry", text = ni.spell.icon(24803) .. " Дебаг в чат", enabled = false, key = "debug" },
			{ type = "page", number = 2, text = "|cffFFFF00Диспел|r" },
			{ type = "separator" },
			{ type = "entry", text = ni.spell.icon(988) .. " Диспел", tooltip = "Диспелит все что может",
				enabled = false, key = "decurse" },
			{ type = "entry", text = ni.spell.icon(32375) .. " Использовать масс диспел",
				tooltip = "Использует масс диспел при количестве игроков",
				enabled = false, value = 2, min = 2, max = 10, step = 1, width = 40, key = "decurse_3" },
			{ type = "entry", text = " Только конкретный дебаф",
				tooltip = "Диспелит только конкретный дебаф по имени", enabled = false,
				key = "decurse_2" },
			{
				type = "input",
				value = inputs["decursee"],
				width = 140,
				height = 15,
				key = "decursee"
			},
			{ type = "title", text = " Игнорировать дебаф" },
			{
				type = "input",
				value = inputs["decurseee"],
				width = 140,
				height = 15,
				key = "decurseee"
			},
			{ type = "page", number = 3, text = "|cffFFFF00Доп настройки|r" },
			{ type = "separator" },
			{ type = "entry", text = ni.spell.icon(34433) .. " Авто пет",
				tooltip = "Автоматически вызывает пета при мане меньше", enabled = true,
				value = 60, min = 1, max = 90, step = 1, key = "pet" },
			{ type = "entry", text = ni.spell.icon(47585) .. " Авто туча",
				tooltip = "Автоматически использует тучу при мане меньше",
				enabled = true, value = 50, min = 1, max = 80, step = 1, key = "tucha" },
			{ type = "separator" },
			{ type = "entry", text = ni.spell.icon(316466) .. " Фрагмент души по кд",
				tooltip =
				"Постоянно поддерживает баф |cFFFF0000В выключеном режиме используется только под прок перчаток или плаща|r",
				enabled = true, key = "fd" },
			{ type = "separator" },
			{ type = "entry", text = ni.spell.icon(53023) .. " Авто-АОЕ",
				tooltip = "Использует иссушение при количестве противников равному",
				enabled = true, value = 3, min = 3, max = 10, step = 1, width = 40, key = "aoe" },
		};
		local function OnLoad()
			ni.GUI.AddFrame("shp_4t4_by_makaren", items);
		end;
		local function OnUnLoad()
			ni.GUI.DestroyFrame("shp_4t4_by_makaren");
		end;
		local cache = {
			IsMoving = false,
			stopcast = false,
			sindra = false,
			PlayerCombat = false,
			pal = true,
			threat = false,
			info = true,
			aoe = false,
			aoe_p = false,
			iss = false,
			control = false,
		};
		local spells = {
			svd = GetSpellInfo(48158),
			pitka = GetSpellInfo(48156),
			palec = GetSpellInfo(48160),
			razum = GetSpellInfo(48127),
			pain = GetSpellInfo(48125),
			issushenie = GetSpellInfo(53023),
			pet = GetSpellInfo(34433),
			tucha = GetSpellInfo(47585),
			oblik = GetSpellInfo(15473),
			oblik_palec = GetSpellInfo(15286),
			ogon = GetSpellInfo(48168),
			chuma = GetSpellInfo(48300),
			shild = GetSpellInfo(48066),
			ten = GetSpellInfo(586),
			sosred = GetSpellInfo(14751),
			decurse = GetSpellInfo(988),
			decurse_po = GetSpellInfo(528),
			mass = GetSpellInfo(532375),
		};
		local ddebuffs = {
			sindra = GetSpellInfo(69766),
			sindra_metka = GetSpellInfo(70126),
			magik_hm = GetSpellInfo(305131),
		}
		local queue = {
			"info",
			"cache",
			"stop",
			"pause",
			"auto-target",
			"sindra",
			"dispell_mass",
			"dispell",
			"cd",
			"buff",
			"mana",
			"shild",
			"svd",
			"pain",
			"palec",
			"pitka",
			"chuma",
			"issushenie",
			"razum",
			"pitka_2",
		};
		local abilities = {
			-----------------------------------
			["info"] = function()
				if cache.info == true then
					cache.info = false
					print("|cFFFF0000  =========================|r\
|cFFFFFFFFШедоу Прист|r\
|cFFFF5A00Приватный профиль by Makaren|r\
|cFF00FFFFФанпей https://funpay.com/users/7303789/|r\
|cFF00FFFFДс https://discord.com/users/785141640087207966|r\
|cFF00FFFFДс Группы https://discord.gg/eQzcDHbVfm|r\
|cFFFF0000=========================|r")
				end
			end,
			------------------------
			["cache"] = function()
				if ni.objectmanager.contains("Повелитель горнов Игнис") then
					local ignis = ni.objectmanager.objectGUID("Повелитель горнов Игнис")
					local spell, _, _, _, _, endTime = UnitCastingInfo(ignis)
					if spell == ("Струи пламени") then
						cache.stopcast = ni.unit.iscasting(ignis)
					end
				end
				if ni.objectmanager.contains("Фрейя") then
					local freya = ni.objectmanager.objectGUID("Фрейя")
					local spell, _, _, _, _, endTime = UnitCastingInfo(freya)
					if spell == ("Дрожание земли") then
						cache.stopcast = ni.unit.iscasting(freya)
					end
				end
				if ni.objectmanager.contains("Полночь") then
					local polnoch = ni.objectmanager.objectGUID("Полночь")
					local spell, _, _, _, _, endTime = UnitCastingInfo(polnoch)
					if spell == ("Могучий топот") then
						cache.stopcast = ni.unit.iscasting(polnoch)
					end
				end
				if ni.objectmanager.contains("Заклятый страж") then
					local straz = ni.objectmanager.objectGUID("Заклятый страж")
					local spell, _, _, _, _, endTime = UnitCastingInfo(straz)
					if spell == ("Разрушительный крик") then
						cache.stopcast = ni.unit.iscasting(straz)
					end
				end
				cache.IsMoving = ni.player.ismoving() or false;
				cache.PlayerCombat = UnitAffectingCombat("player") or false;
				cache.stopcast = ni.unit.debuffremaining("player", ddebuffs.magik_hm) > 2
						or ni.unit.debuff("player", "Поцелуй Госпожи");
				cache.sindra = ni.unit.debuffstacks("player", ddebuffs.sindra) <= values.osvob;
				cache.threat = ni.unit.threat("player")
				if cache.threat > 2 then
					if ni.spell.available(spells.ten) then
						ni.spell.cast(spells.ten)
					end
				end
				local play = ni.objectmanager.objectGUID("player")
				local spell, _, _, _, _, endTime = UnitCastingInfo(play)
				local spell_, _, _, _, _, endTime = UnitChannelInfo(play)
				if spell == ("Прикосновение вампира") then
					cache.pal = false
				end
				if spell_ == ("Пытка разума")
						or spell_ == ("Иссушение разума") then
					cache.pal = true
				end
				local enemies = ni.unit.enemiesinrange("player", 35)
				local enemies_ = ni.unit.enemiesinrange("target", 9)
				if enables["aoe"] then
					if #enemies > values.aoe - 1
							and #enemies_ > values.aoe - 2 then
						cache.aoe = true
					end
					if #enemies < values.aoe then
						cache.aoe = false
					end
				else
					cache.aoe = false
				end
				if #enemies == 2 then
					cache.aoe_p = true
				else
					cache.aoe_p = false
				end
				for i = 1, #enemies_ do
					local target = enemies_[i].guid
					if ni.unit.debuff(target, "Сглаз")
							or ni.unit.debuff(target, "Устрашающий крик")
							or ni.unit.debuff(target, "Гнев деревьев")
							or ni.unit.debuff(target, "Смерч")
							or ni.unit.debuff(target, "Превращение")
							or ni.unit.debuff(target, "Замораживающая ловушка")
							or ni.unit.debuff(target, "Покаяние")
							or ni.unit.debuff(target, "Ослепление")
							or ni.unit.debuff(target, "Ошеломление")
							or ni.unit.debuff(target, "Вой ужаса")
							or ni.unit.debuff(target, "Изгнание")
							or ni.unit.debuff(target, "Страх")
							or ni.unit.debuff(target, "Спячка")
							or ni.unit.debuff(target, "Отпугивание зверя")
							or ni.unit.debuff(target, "Ментальный крик") then
						cache.aoe = false
					end
				end
				local spell__, _, _, _, _, endTime = UnitChannelInfo("player")
				if spell__ == (spells.issushenie) then
					cache.iss = true
				else
					cache.iss = false
				end
				if ni.unit.debuff("target", "Сглаз")
						or ni.unit.debuff("target", "Устрашающий крик")
						or ni.unit.debuff("target", "Гнев деревьев")
						or ni.unit.debuff("target", "Смерч")
						or ni.unit.debuff("target", "Превращение")
						or ni.unit.debuff("target", "Замораживающая ловушка")
						or ni.unit.debuff("target", "Покаяние")
						or ni.unit.debuff("target", "Ослепление")
						or ni.unit.debuff("target", "Ошеломление")
						or ni.unit.debuff("target", "Вой ужаса")
						or ni.unit.debuff("target", "Изгнание")
						or ni.unit.debuff("target", "Страх")
						or ni.unit.debuff("target", "Спячка")
						or ni.unit.debuff("target", "Отпугивание зверя")
						or ni.unit.debuff("target", "Ментальный крик") then
					cache.control = true
				else
					cache.control = false
				end
				if enables["debug"] then
					ni.vars.debug = true
				else
					ni.vars.debug = false
				end
			end,
			-----------------------------------
			["stop"] = function()
				if cache.stopcast then
					if ni.unit.iscasting("player")
							or ni.unit.ischanneling("player") then
						ni.spell.stopcasting()
					end
				end
			end,
			------------------------
			["pause"] = function()
				if IsMounted()
						or UnitInVehicle("player")
						or UnitIsDeadOrGhost("player")
						or UnitCastingInfo("player")
						or ni.spell.gcd()
						or ni.player.islooting()
						or not cache.sindra then
					return true;
				end
			end,
			-----------------------------------
			["auto-target"] = function()
				local target_ = ni.objects["target"];
				local target__ = target_.guid
				if enables["target"]
						and cache.PlayerCombat then
					if target__ == 0 then
						ni.player.runtext("/startattack")
					end
				end
			end,
			-----------------------------------
			["sindra"] = function()
				if ni.objectmanager.contains("Синдрагоса") then
					if not ni.unit.debuff("player", "Освобожденная магия")
							and ni.unit.debuffstacks("player", ddebuffs.sindra) > 7
							and ni.spell.available(spells.tucha) then
						ni.spell.cast(spells.tucha)
					end
				end
			end,
			-----------------------------------
			["dispell_mass"] = function()
				for i = 1, #ni.members do
					local ally = ni.members[i].unit;
					if enables["decurse"]
							and enables["decurse_3"] then
						if enables["decurse_2"]
								and inputs.decursee ~= "" then
							if ni.healing.candispel(ally)
									and ni.unit.debuff(ally, inputs.decursee)
									and ni.unit.debufftype(ally, "Magic") then
								local ddd = ni.members.inrangewithdebuff(ally, 14, inputs.decursee)
								if #ddd >= values.decurse_3
										and not cache.stopcast then
									ni.spell.castat(spells.mass, ally)
								end
							end
						elseif ni.healing.candispel(ally) then
							local dd = ni.members.inrange(ally, 14);
							local count = 0
							for i = 1, #dd do
								local target = dd[i].guid
								if ni.unit.debufftype(target, "Magic") then
									count = count + 1
									if count >= values.decurse_3
											and not cache.stopcast then
										ni.spell.castat(spells.mass, ally)
									end
								end
							end
						end
					end
				end
			end,
			-----------------------------------
			["dispell"] = function()
				for i = 1, #ni.members do
					local ally = ni.members[i].unit;
					if enables["decurse"] then
						if enables["decurse_2"]
								and inputs.decursee ~= "" then
							if ni.unit.debuff(ally, inputs.decursee)
									and ni.spell.available(spells.decurse)
									and ni.spell.valid(ally, spells.decurse, false, true, true) then
								ni.spell.cast(spells.decurse, ally)
								ni.spell.cast(spells.decurse_po, ally)
							end
						elseif ni.healing.candispel(ally) then
							if ni.spell.valid(ally, spells.decurse, false, true, true)
									and not ni.unit.debuff(ally, inputs.decurseee)
									and ni.spell.available(spells.decurse) then
								ni.spell.cast(spells.decurse, ally)
								ni.spell.cast(spells.decurse_po, ally)
							end
						end
					end
				end
			end,
			--------------------------
			["cd"] = function()
				if cache.sindra
						or ni.spell.available(spells.tucha) then
					if cache.PlayerCombat
							and not cache.stopcast then
						if ni.player.slotcastable(10)
								and ni.player.slotcd(10) == 0
								and not ni.unit.buff("player", spells.tucha) then
							ni.player.useinventoryitem(10)
						end
						if ni.spell.available(319326) then
							ni.spell.cast(319326)
						end
						if ni.spell.available(spells.sosred)
								and ni.spell.available(spells.razum)
								and ni.unit.buffstacks("player", 15258) > 4 then
							ni.spell.cast(spells.sosred)
						end
						if ni.spell.available(316421)
								and ni.power.current("player") < 80 then
							ni.spell.cast(316421)
						end
						if ni.spell.available(316422) then
							ni.spell.cast(316422)
						end
						if ni.spell.available(316295) then
							ni.spell.cast(316295)
						end
						if ni.player.slotcastable(13)
								and ni.player.slotcd(13) == 0
								and not ni.unit.buff("player", spells.tucha) then
							ni.player.useinventoryitem(13)
						end
						if ni.player.slotcastable(14)
								and ni.player.slotcd(14) == 0
								and not ni.unit.buff("player", spells.tucha) then
							ni.player.useinventoryitem(14)
						end
						count = GetItemCount("Фрагмент души")
						if enables["fd"] then
							if ni.spell.available(316466)
									and not ni.unit.buff("player", spells.tucha)
									and not ni.unit.buff("player", 316466) then
								if count > 1
										or ni.unit.hp("target") < 10 then
									ni.spell.cast(316466)
								end
							end
						else
							if ni.spell.available(316466)
									and not ni.unit.buff("player", spells.tucha)
									and not ni.unit.buff("player", 316466) then
								if ni.player.buff(320371)
										or ni.player.buff(55637) then
									if count > 1
											or ni.unit.hp("target") < 10 then
										ni.spell.cast(316466)
									end
								end
							end
						end
						if ni.spell.available(316447) then
							ni.spell.cast("target", 316467)
						end
						if ni.unit.buff("player", 316440)
								and cache.PlayerCombat
								and ni.player.hasitem(50085) then
							ni.player.useitem(50085)
						end
						if ni.spell.available(316396)
								and ni.spell.valid("target", 316396, false, true, true) then
							ni.spell.cast(316396)
						end
						local startTime, duration, enable = GetItemCooldown(36892)
						local startTime_, duration, enable = GetItemCooldown(36893)
						local startTime__, duration, enable = GetItemCooldown(36894)
						if enables["kamen"] then
							if startTime == 0
									and startTime_ == 0
									and startTime__ == 0 then
								if ni.player.hasitem(36892)
										or ni.player.hasitem(36893)
										or ni.player.hasitem(36894) then
									if ni.unit.hp("player") < values.kamen then
										if ni.unit.ttd("player") < 2 then
											ni.player.useitem(36892)
											ni.player.useitem(36893)
											ni.player.useitem(36894)
										end
									end
								end
							end
						end
					end
				end
			end,
			-----------------------------------
			["buff"] = function()
				if cache.sindra
						or ni.spell.available(spells.tucha) then
					if not ni.unit.buff("player", spells.ogon)
							and ni.spell.available(spells.ogon) then
						ni.spell.cast(spells.ogon)
					end
					if not ni.unit.buff("player", spells.oblik)
							and ni.spell.available(spells.oblik) then
						ni.spell.cast(spells.oblik)
					end
					if not ni.unit.buff("player", spells.oblik_palec)
							and ni.spell.available(spells.oblik_palec) then
						ni.spell.cast(spells.oblik_palec)
					end
				end
			end,
			-----------------------------------
			["mana"] = function()
				if enables["pet"]
						and ni.power.current("player") <= values.pet
						and cache.PlayerCombat
						and not ni.objectmanager.contains("Синдрагоса") then
					if ni.spell.available(spells.pet) then
						ni.spell.cast(spells.pet)
						ni.player.runtext("/petattack")
					end
				end
				if enables["tucha"]
						and ni.power.current("player") <= values.tucha
						and cache.PlayerCombat
						and not ni.objectmanager.contains("Синдрагоса")
						and ni.player.slotcd(13) < 75
						and ni.player.slotcd(14) < 75
						and not ni.player.buff(32182)
						and not ni.player.buff(2825)
						and not ni.player.buff(10060)
						and not ni.player.buff(320371)
						and not ni.player.buff(55637) then
					if not ni.spell.available(spells.pet)
							and ni.spell.available(spells.tucha) then
						ni.spell.cast(spells.tucha)
					end
				end
				if enables["pet"]
						and ni.power.current("player") <= values.pet
						and cache.PlayerCombat
						and ni.objectmanager.contains("Синдрагоса") then
					if cache.sindra
							or ni.spell.available(spells.tucha) then
						if ni.spell.available(spells.pet) then
							ni.spell.cast(spells.pet)
							ni.player.runtext("/petattack")
						end
					end
				end
			end,
			-----------------------------------
			["shild"] = function()
				if ni.objectmanager.contains("Принц Малчезар") then
					if ni.player.buff("Слово силы: Щит")
							or ni.player.buff("Божья длань")
							or ni.player.buff("Божественный оберег") then
					elseif not ni.player.debuff("Ослабленная душа") then
						ni.spell.cast(spells.shild)
					end
				end
			end,
			-----------------------------------
			["svd"] = function()
				if cache.sindra
						or ni.spell.available(spells.tucha) then
					if not ni.unit.debuff("target", 319822, "player")
							and not ni.unit.debuff("player", "Ослабление")
							or ni.unit.debuffremaining("target", 319822) < 1.5 then
						if ni.spell.valid("target", spells.svd, false, true, true)
								and cache.iss == false
								and not cache.control
								and cache.PlayerCombat then
							ni.spell.cast(spells.svd, "target")
						end
					end
				end
			end,
			-----------------------------------
			["pain"] = function()
				if cache.aoe_p == false
						and cache.iss == false then
					if cache.sindra
							or ni.spell.available(spells.tucha) then
						if not ni.unit.debuff("target", spells.pain, "player")
								and cache.PlayerCombat
								and ni.spell.available(spells.pain)
								and ni.unit.buffstacks("player", 15258) > 4
								and ni.spell.valid("target", spells.pain, false, true, true) then
							ni.spell.cast(spells.pain, "target")
						end
					end
				else
					local enemies = ni.unit.enemiesinrange("player", 35)
					for i = 1, #enemies do
						local target = enemies[i].guid
						if cache.sindra
								or ni.spell.available(spells.tucha) then
							if not ni.unit.debuff(target, spells.pain, "player")
									and not ni.unit.debuff(target, "Сглаз")
									and not ni.unit.debuff(target, "Устрашающий крик")
									and not ni.unit.debuff(target, "Гнев деревьев")
									and not ni.unit.debuff(target, "Смерч")
									and not ni.unit.debuff(target, "Превращение")
									and not ni.unit.debuff(target, "Замораживающая ловушка")
									and not ni.unit.debuff(target, "Покаяние")
									and not ni.unit.debuff(target, "Ослепление")
									and not ni.unit.debuff(target, "Ошеломление")
									and not ni.unit.debuff(target, "Вой ужаса")
									and not ni.unit.debuff(target, "Изгнание")
									and not ni.unit.debuff(target, "Страх")
									and not ni.unit.debuff(target, "Спячка")
									and not ni.unit.debuff(target, "Отпугивание зверя")
									and not ni.unit.debuff(target, "Ментальный крик")
									and cache.aoe_p == true
									and cache.PlayerCombat
									and ni.spell.available(spells.pain)
									and ni.unit.buffstacks("player", 15258) > 4
									and ni.spell.valid(target, spells.pain, false, true, true) then
								ni.spell.cast(spells.pain, target)
							end
						end
					end
				end
			end,
			--------------------------
			["palec"] = function()
				if cache.aoe_p == false
						and cache.iss == false then
					if cache.sindra
							or ni.spell.available(spells.tucha) then
						if not ni.unit.debuff("target", spells.palec, "player")
								or ni.unit.debuffremaining("target", spells.palec) < 1 then
							if ni.spell.valid("target", spells.palec, false, true, true)
									and not cache.IsMoving
									and cache.PlayerCombat
									and not cache.stopcast
									and cache.pal == true then
								ni.spell.cast(spells.palec, "target")
							end
						end
					end
				else
					local enemies = ni.unit.enemiesinrange("player", 35)
					for i = 1, #enemies do
						local target = enemies[i].guid
						if cache.sindra
								or ni.spell.available(spells.tucha) then
							if not ni.unit.debuff(target, spells.palec, "player")
									or ni.unit.debuffremaining(target, spells.palec) < 1 then
								if ni.spell.valid(target, spells.palec, false, true, true)
										and not ni.unit.debuff(target, "Сглаз")
										and not ni.unit.debuff(target, "Устрашающий крик")
										and not ni.unit.debuff(target, "Гнев деревьев")
										and not ni.unit.debuff(target, "Смерч")
										and not ni.unit.debuff(target, "Превращение")
										and not ni.unit.debuff(target, "Замораживающая ловушка")
										and not ni.unit.debuff(target, "Покаяние")
										and not ni.unit.debuff(target, "Ослепление")
										and not ni.unit.debuff(target, "Ошеломление")
										and not ni.unit.debuff(target, "Вой ужаса")
										and not ni.unit.debuff(target, "Изгнание")
										and not ni.unit.debuff(target, "Страх")
										and not ni.unit.debuff(target, "Спячка")
										and not ni.unit.debuff(target, "Отпугивание зверя")
										and not ni.unit.debuff(target, "Ментальный крик")
										and not cache.IsMoving
										and cache.aoe_p == true
										and cache.PlayerCombat
										and not cache.stopcast
										and cache.pal == true then
									ni.spell.cast(spells.palec, target)
								end
							end
						end
					end
				end
			end,
			-----------------------------------
			["pitka"] = function()
				if cache.sindra
						or ni.spell.available(spells.tucha) then
					if ni.unit.buffstacks("player", 15258) < 4
							and cache.aoe == false
							and not cache.control
							and ni.spell.available(spells.pitka)
							and not cache.stopcast
							and cache.PlayerCombat
							and not cache.IsMoving
							and not ni.unit.ischanneling("player")
							and ni.spell.valid("target", spells.pitka, false, true, true) then
						ni.spell.cast(spells.pitka, "target")
					end
				end
			end,
			-----------------------------------
			["chuma"] = function()
				if cache.sindra
						or ni.spell.available(spells.tucha) then
					if not ni.unit.debuff("target", spells.chuma, "player")
							and cache.PlayerCombat
							and not cache.control
							and cache.iss == false
							and ni.unit.buffstacks("player", 15258) > 4
							and ni.unit.buffstacks("player", 319825) > 2
							and ni.spell.valid("target", spells.chuma, false, true, true) then
						ni.spell.cast(spells.chuma, "target")
					end
				end
			end,
			-----------------------------------
			["issushenie"] = function()
				if cache.sindra
						or ni.spell.available(spells.tucha) then
					if not ni.unit.ischanneling("player")
							and not cache.IsMoving
							and cache.aoe == true
							and cache.PlayerCombat
							and not cache.stopcast
							and ni.spell.available(spells.issushenie)
							and ni.spell.valid("target", spells.issushenie, false, true, true) then
						ni.spell.cast(spells.issushenie, "target")
					end
				end
			end,
			--------------------------
			["razum"] = function()
				if cache.sindra
						or ni.spell.available(spells.tucha) then
					if ni.spell.cd(spells.razum) == 0
							and not cache.control
							and cache.PlayerCombat
							and cache.aoe == false
							and ni.spell.valid("target", spells.razum, false, true, true)
							and ni.unit.buffstacks("player", 15258) > 4 then
						ni.spell.cast(spells.razum, "target")
					end
				end
			end,
			-----------------------------------
			["pitka_2"] = function()
				if cache.sindra
						or ni.spell.available(spells.tucha) then
					if not ni.unit.ischanneling("player")
							and not cache.IsMoving
							and not cache.control
							and cache.aoe == false
							and cache.PlayerCombat
							and not cache.stopcast
							and ni.spell.available(spells.pitka)
							and ni.spell.valid("target", spells.pitka, false, true, true) then
						ni.spell.cast(spells.pitka, "target")
					end
				end
			end,
			--------------------------
		};
		ni.bootstrap.profile("shp_by_makaren_wrath", queue, abilities, OnLoad, OnUnLoad);
	elseif t4 > 1 then
		local enables = {
			["target"] = true,
			["pet"] = true,
			["tucha"] = true,
			["kamen"] = true,
			["fd"] = true,
			["aoe"] = true,
			["decurse"] = false,
			["decurse_2"] = false,
			["decurse_3"] = false,
			["debug"] = false,
		}
		local values = {
			osvob = 4,
			pet = 60,
			tucha = 50,
			aoe = 3,
			kamen = 30,
		}
		local inputs = {
			decursee = "",
			decurseee = "Мертвящая чума",
		}
		local menus = {
		}
		local function GUICallback(key, item_type, value)
			if item_type == "enabled" then
				enables[key] = value;
			elseif item_type == "value" then
				values[key] = value;
			elseif item_type == "input" then
				inputs[key] = value;
			elseif item_type == "menu" then
				menus[key] = value;
			end
		end
		local items = {
			settingsfile = "shp_2t4_by_makaren.json",
			callback = GUICallback,
			{ type = "title", text = "shp_4t4 by |c0000CED1Makaren|r" },
			{ type = "separator" },
			{ type = "title", text = "|cffFF7C0AProfile version 2.0.0|r" },
			{ type = "separator" },
			{ type = "page", number = 1, text = "|cffFFFF00Общие настройки|r" },
			{ type = "separator" },
			{ type = "entry", text = ni.spell.icon(69762) .. " Освобожденная магия",
				tooltip = "Количество набираемых стаков Освобожденной магии |cFF00FFFFЦлк(Синдрагоса)|r",
				value = 4, min = 1, max = 10, step = 1, key = "osvob" },
			{ type = "separator" },
			{ type = "entry", text = ni.spell.icon(6603) .. " Авто таргет",
				tooltip = "Автоматически выбирает таргет при его отсутствии",
				enabled = true, key = "target" },
			{ type = "separator" },
			{
				type = "entry",
				text = ni.spell.icon(11729) .. " Камень здоровья",
				tooltip = "Использует Огурец при |cFF00FF00Hp <|r\
Работает в связке с функцией TTD(Time To Die)",
				enabled = true,
				value = 30,
				min = 1,
				max = 100,
				step = 1,
				key = "kamen"
			},
			{ type = "separator" },
			{ type = "entry", text = ni.spell.icon(24803) .. " Дебаг в чат", enabled = false, key = "debug" },
			{ type = "page", number = 2, text = "|cffFFFF00Диспел|r" },
			{ type = "separator" },
			{ type = "entry", text = ni.spell.icon(988) .. " Диспел", tooltip = "Диспелит все что может",
				enabled = false, key = "decurse" },
			{ type = "entry", text = ni.spell.icon(32375) .. " Использовать масс диспел",
				tooltip = "Использует масс диспел при количестве игроков",
				enabled = false, value = 2, min = 2, max = 10, step = 1, width = 40, key = "decurse_3" },
			{ type = "entry", text = " Только конкретный дебаф",
				tooltip = "Диспелит только конкретный дебаф по имени", enabled = false,
				key = "decurse_2" },
			{
				type = "input",
				value = inputs["decursee"],
				width = 140,
				height = 15,
				key = "decursee"
			},
			{ type = "title", text = " Игнорировать дебаф" },
			{
				type = "input",
				value = inputs["decurseee"],
				width = 140,
				height = 15,
				key = "decurseee"
			},
			{ type = "page", number = 3, text = "|cffFFFF00Доп настройки|r" },
			{ type = "separator" },
			{ type = "entry", text = ni.spell.icon(34433) .. " Авто пет",
				tooltip = "Автоматически вызывает пета при мане меньше", enabled = true,
				value = 60, min = 1, max = 90, step = 1, key = "pet" },
			{ type = "entry", text = ni.spell.icon(47585) .. " Авто туча",
				tooltip = "Автоматически использует тучу при мане меньше",
				enabled = true, value = 50, min = 1, max = 80, step = 1, key = "tucha" },
			{ type = "separator" },
			{ type = "entry", text = ni.spell.icon(316466) .. " Фрагмент души по кд",
				tooltip =
				"Постоянно поддерживает баф |cFFFF0000В выключеном режиме используется только под прок перчаток или плаща|r",
				enabled = true, key = "fd" },
			{ type = "separator" },
			{ type = "entry", text = ni.spell.icon(53023) .. " Авто-АОЕ",
				tooltip = "Использует иссушение при количестве противников равному",
				enabled = true, value = 3, min = 3, max = 10, step = 1, width = 40, key = "aoe" },
		};
		local function OnLoad()
			ni.GUI.AddFrame("shp_2t4_by_makaren", items);
		end;
		local function OnUnLoad()
			ni.GUI.DestroyFrame("shp_2t4_by_makaren");
		end;
		local cache = {
			IsMoving = false,
			stopcast = false,
			sindra = false,
			PlayerCombat = false,
			pal = true,
			threat = false,
			info = true,
			aoe = false,
			aoe_p = false,
			iss = false,
			control = false,
		};
		local spells = {
			svd = GetSpellInfo(48158),
			pitka = GetSpellInfo(48156),
			palec = GetSpellInfo(48160),
			razum = GetSpellInfo(48127),
			pain = GetSpellInfo(48125),
			issushenie = GetSpellInfo(53023),
			pet = GetSpellInfo(34433),
			tucha = GetSpellInfo(47585),
			oblik = GetSpellInfo(15473),
			oblik_palec = GetSpellInfo(15286),
			ogon = GetSpellInfo(48168),
			chuma = GetSpellInfo(48300),
			shild = GetSpellInfo(48066),
			ten = GetSpellInfo(586),
			sosred = GetSpellInfo(14751),
			decurse = GetSpellInfo(988),
			decurse_po = GetSpellInfo(528),
			mass = GetSpellInfo(532375),
		};
		local ddebuffs = {
			sindra = GetSpellInfo(69766),
			sindra_metka = GetSpellInfo(70126),
			magik_hm = GetSpellInfo(305131),
		}
		local queue = {
			"info",
			"cache",
			"stop",
			"pause",
			"auto-target",
			"sindra",
			"dispell_mass",
			"dispell",
			"cd",
			"buff",
			"mana",
			"shild",
			"svd",
			"pain",
			"palec",
			"pitka",
			"chuma",
			"issushenie",
			"razum",
			"pitka_2",
		};
		local abilities = {
			-----------------------------------
			["info"] = function()
				if cache.info == true then
					cache.info = false
					print("|cFFFF0000  =========================|r\
|cFFFFFFFFШедоу Прист|r\
|cFFFF5A00Приватный профиль by Makaren|r\
|cFF00FFFFФанпей https://funpay.com/users/7303789/|r\
|cFF00FFFFДс https://discord.com/users/785141640087207966|r\
|cFF00FFFFДс Группы https://discord.gg/eQzcDHbVfm|r\
|cFFFF0000=========================|r")
				end
			end,
			------------------------
			["cache"] = function()
				if ni.objectmanager.contains("Повелитель горнов Игнис") then
					local ignis = ni.objectmanager.objectGUID("Повелитель горнов Игнис")
					local spell, _, _, _, _, endTime = UnitCastingInfo(ignis)
					if spell == ("Струи пламени") then
						cache.stopcast = ni.unit.iscasting(ignis)
					end
				end
				if ni.objectmanager.contains("Фрейя") then
					local freya = ni.objectmanager.objectGUID("Фрейя")
					local spell, _, _, _, _, endTime = UnitCastingInfo(freya)
					if spell == ("Дрожание земли") then
						cache.stopcast = ni.unit.iscasting(freya)
					end
				end
				if ni.objectmanager.contains("Полночь") then
					local polnoch = ni.objectmanager.objectGUID("Полночь")
					local spell, _, _, _, _, endTime = UnitCastingInfo(polnoch)
					if spell == ("Могучий топот") then
						cache.stopcast = ni.unit.iscasting(polnoch)
					end
				end
				if ni.objectmanager.contains("Заклятый страж") then
					local straz = ni.objectmanager.objectGUID("Заклятый страж")
					local spell, _, _, _, _, endTime = UnitCastingInfo(straz)
					if spell == ("Разрушительный крик") then
						cache.stopcast = ni.unit.iscasting(straz)
					end
				end
				cache.IsMoving = ni.player.ismoving() or false;
				cache.PlayerCombat = UnitAffectingCombat("player") or false;
				cache.stopcast = ni.unit.debuffremaining("player", ddebuffs.magik_hm) > 2
						or ni.unit.debuff("player", "Поцелуй Госпожи");
				cache.sindra = ni.unit.debuffstacks("player", ddebuffs.sindra) <= values.osvob;
				cache.threat = ni.unit.threat("player")
				if cache.threat > 2 then
					if ni.spell.available(spells.ten) then
						ni.spell.cast(spells.ten)
					end
				end
				local play = ni.objectmanager.objectGUID("player")
				local spell, _, _, _, _, endTime = UnitCastingInfo(play)
				local spell_, _, _, _, _, endTime = UnitChannelInfo(play)
				if spell == ("Прикосновение вампира") then
					cache.pal = false
				end
				if spell_ == ("Пытка разума")
						or spell_ == ("Иссушение разума") then
					cache.pal = true
				end
				local enemies = ni.unit.enemiesinrange("player", 35)
				local enemies_ = ni.unit.enemiesinrange("target", 9)
				if enables["aoe"] then
					if #enemies > values.aoe - 1
							and #enemies_ > values.aoe - 1 then
						cache.aoe = true
					end
					if #enemies < values.aoe then
						cache.aoe = false
					end
				else
					cache.aoe = false
				end
				for i = 1, #enemies_ do
					local target = enemies_[i].guid
					if ni.unit.debuff(target, "Сглаз")
							or ni.unit.debuff(target, "Устрашающий крик")
							or ni.unit.debuff(target, "Гнев деревьев")
							or ni.unit.debuff(target, "Смерч")
							or ni.unit.debuff(target, "Превращение")
							or ni.unit.debuff(target, "Замораживающая ловушка")
							or ni.unit.debuff(target, "Покаяние")
							or ni.unit.debuff(target, "Ослепление")
							or ni.unit.debuff(target, "Ошеломление")
							or ni.unit.debuff(target, "Вой ужаса")
							or ni.unit.debuff(target, "Изгнание")
							or ni.unit.debuff(target, "Страх")
							or ni.unit.debuff(target, "Спячка")
							or ni.unit.debuff(target, "Отпугивание зверя")
							or ni.unit.debuff(target, "Ментальный крик") then
						cache.aoe = false
					end
				end
				if #enemies == 2 then
					cache.aoe_p = true
				else
					cache.aoe_p = false
				end
				local spell__, _, _, _, _, endTime = UnitChannelInfo("player")
				if spell__ == (spells.issushenie) then
					cache.iss = true
				else
					cache.iss = false
				end
				if ni.unit.debuff("target", "Сглаз")
						or ni.unit.debuff("target", "Устрашающий крик")
						or ni.unit.debuff("target", "Гнев деревьев")
						or ni.unit.debuff("target", "Смерч")
						or ni.unit.debuff("target", "Превращение")
						or ni.unit.debuff("target", "Замораживающая ловушка")
						or ni.unit.debuff("target", "Покаяние")
						or ni.unit.debuff("target", "Ослепление")
						or ni.unit.debuff("target", "Ошеломление")
						or ni.unit.debuff("target", "Вой ужаса")
						or ni.unit.debuff("target", "Изгнание")
						or ni.unit.debuff("target", "Страх")
						or ni.unit.debuff("target", "Спячка")
						or ni.unit.debuff("target", "Отпугивание зверя")
						or ni.unit.debuff("target", "Ментальный крик") then
					cache.control = true
				else
					cache.control = false
				end
				if enables["debug"] then
					ni.vars.debug = true
				else
					ni.vars.debug = false
				end
			end,
			-----------------------------------
			["stop"] = function()
				if cache.stopcast then
					if ni.unit.iscasting("player")
							or ni.unit.ischanneling("player") then
						ni.spell.stopcasting()
					end
				end
			end,
			------------------------
			["pause"] = function()
				if IsMounted()
						or UnitInVehicle("player")
						or UnitIsDeadOrGhost("player")
						or UnitCastingInfo("player")
						or ni.spell.gcd()
						or ni.player.islooting()
						or not cache.sindra then
					return true;
				end
			end,
			-----------------------------------
			["auto-target"] = function()
				local target_ = ni.objects["target"];
				local target__ = target_.guid
				if enables["target"]
						and cache.PlayerCombat then
					if target__ == 0 then
						ni.player.runtext("/startattack")
					end
				end
			end,
			-----------------------------------
			["sindra"] = function()
				if ni.objectmanager.contains("Синдрагоса") then
					if not ni.unit.debuff("player", "Освобожденная магия")
							and ni.unit.debuffstacks("player", ddebuffs.sindra) > 7
							and ni.spell.available(spells.tucha) then
						ni.spell.cast(spells.tucha)
					end
				end
			end,
			-----------------------------------
			["dispell_mass"] = function()
				for i = 1, #ni.members do
					local ally = ni.members[i].unit;
					if enables["decurse"]
							and enables["decurse_3"] then
						if enables["decurse_2"]
								and inputs.decursee ~= "" then
							if ni.healing.candispel(ally)
									and ni.unit.debuff(ally, inputs.decursee)
									and ni.unit.debufftype(ally, "Magic") then
								local ddd = ni.members.inrangewithdebuff(ally, 14, inputs.decursee)
								if #ddd >= values.decurse_3
										and not cache.stopcast then
									ni.spell.castat(spells.mass, ally)
								end
							end
						elseif ni.healing.candispel(ally) then
							local dd = ni.members.inrange(ally, 14);
							local count = 0
							for i = 1, #dd do
								local target = dd[i].guid
								if ni.unit.debufftype(target, "Magic") then
									count = count + 1
									if count >= values.decurse_3
											and not cache.stopcast then
										ni.spell.castat(spells.mass, ally)
									end
								end
							end
						end
					end
				end
			end,
			-----------------------------------
			["dispell"] = function()
				for i = 1, #ni.members do
					local ally = ni.members[i].unit;
					if enables["decurse"] then
						if enables["decurse_2"]
								and inputs.decursee ~= "" then
							if ni.unit.debuff(ally, inputs.decursee)
									and ni.spell.available(spells.decurse)
									and ni.spell.valid(ally, spells.decurse, false, true, true) then
								ni.spell.cast(spells.decurse, ally)
								ni.spell.cast(spells.decurse_po, ally)
							end
						elseif ni.healing.candispel(ally) then
							if ni.spell.valid(ally, spells.decurse, false, true, true)
									and not ni.unit.debuff(ally, inputs.decurseee)
									and ni.spell.available(spells.decurse) then
								ni.spell.cast(spells.decurse, ally)
								ni.spell.cast(spells.decurse_po, ally)
							end
						end
					end
				end
			end,
			--------------------------
			["cd"] = function()
				if cache.sindra
						or ni.spell.available(spells.tucha) then
					if cache.PlayerCombat
							and not cache.stopcast then
						if ni.player.slotcastable(10)
								and ni.player.slotcd(10) == 0
								and not ni.unit.buff("player", spells.tucha) then
							ni.player.useinventoryitem(10)
						end
						if ni.spell.available(319326) then
							ni.spell.cast(319326)
						end
						if ni.spell.available(spells.sosred)
								and ni.spell.available(spells.razum)
								and ni.unit.buffstacks("player", 15258) > 4 then
							ni.spell.cast(spells.sosred)
						end
						if ni.spell.available(316421)
								and ni.power.current("player") < 80 then
							ni.spell.cast(316421)
						end
						if ni.spell.available(316295) then
							ni.spell.cast(316295)
						end
						if ni.player.slotcastable(13)
								and ni.player.slotcd(13) == 0
								and not ni.unit.buff("player", spells.tucha) then
							ni.player.useinventoryitem(13)
						end
						if ni.player.slotcastable(14)
								and ni.player.slotcd(14) == 0
								and not ni.unit.buff("player", spells.tucha) then
							ni.player.useinventoryitem(14)
						end
						count = GetItemCount("Фрагмент души")
						if enables["fd"] then
							if ni.spell.available(316466)
									and not ni.unit.buff("player", spells.tucha)
									and not ni.unit.buff("player", 316466) then
								if count > 1
										or ni.unit.hp("target") < 10 then
									ni.spell.cast(316466)
								end
							end
						else
							if ni.spell.available(316466)
									and not ni.unit.buff("player", spells.tucha)
									and not ni.unit.buff("player", 316466) then
								if ni.player.buff(320371)
										or ni.player.buff(55637) then
									if count > 1
											or ni.unit.hp("target") < 10 then
										ni.spell.cast(316466)
									end
								end
							end
						end
						if ni.spell.available(316422) then
							ni.spell.cast(316422)
						end
						if ni.spell.available(316447) then
							ni.spell.cast("target", 316467)
						end
						if ni.unit.buff("player", 316440)
								and cache.PlayerCombat
								and ni.player.hasitem(50085) then
							ni.player.useitem(50085)
						end
						if ni.spell.available(316396)
								and ni.spell.valid("target", 316396, false, true, true) then
							ni.spell.cast(316396)
						end
						local startTime, duration, enable = GetItemCooldown(36892)
						local startTime_, duration, enable = GetItemCooldown(36893)
						local startTime__, duration, enable = GetItemCooldown(36894)
						if enables["kamen"] then
							if startTime == 0
									and startTime_ == 0
									and startTime__ == 0 then
								if ni.player.hasitem(36892)
										or ni.player.hasitem(36893)
										or ni.player.hasitem(36894) then
									if ni.unit.hp("player") < values.kamen then
										if ni.unit.ttd("player") < 2 then
											ni.player.useitem(36892)
											ni.player.useitem(36893)
											ni.player.useitem(36894)
										end
									end
								end
							end
						end
					end
				end
			end,
			-----------------------------------
			["buff"] = function()
				if cache.sindra
						or ni.spell.available(spells.tucha) then
					if not ni.unit.buff("player", spells.ogon)
							and ni.spell.available(spells.ogon) then
						ni.spell.cast(spells.ogon)
					end
					if not ni.unit.buff("player", spells.oblik)
							and ni.spell.available(spells.oblik) then
						ni.spell.cast(spells.oblik)
					end
					if not ni.unit.buff("player", spells.oblik_palec)
							and ni.spell.available(spells.oblik_palec) then
						ni.spell.cast(spells.oblik_palec)
					end
				end
			end,
			-----------------------------------
			["mana"] = function()
				if enables["pet"]
						and ni.power.current("player") <= values.pet
						and cache.PlayerCombat
						and not ni.objectmanager.contains("Синдрагоса") then
					if ni.spell.available(spells.pet) then
						ni.spell.cast(spells.pet)
						ni.player.runtext("/petattack")
					end
				end
				if enables["tucha"]
						and ni.power.current("player") <= values.tucha
						and cache.PlayerCombat
						and not ni.objectmanager.contains("Синдрагоса")
						and ni.player.slotcd(13) < 75
						and ni.player.slotcd(14) < 75
						and not ni.player.buff(32182)
						and not ni.player.buff(2825)
						and not ni.player.buff(10060)
						and not ni.player.buff(320371)
						and not ni.player.buff(55637) then
					if not ni.spell.available(spells.pet)
							and ni.spell.available(spells.tucha) then
						ni.spell.cast(spells.tucha)
					end
				end
				if enables["pet"]
						and ni.power.current("player") <= values.pet
						and cache.PlayerCombat
						and ni.objectmanager.contains("Синдрагоса") then
					if cache.sindra
							or ni.spell.available(spells.tucha) then
						if ni.spell.available(spells.pet) then
							ni.spell.cast(spells.pet)
							ni.player.runtext("/petattack")
						end
					end
				end
			end,
			-----------------------------------
			["shild"] = function()
				if ni.objectmanager.contains("Принц Малчезар") then
					if ni.player.buff("Слово силы: Щит")
							or ni.player.buff("Божья длань")
							or ni.player.buff("Божественный оберег") then
					elseif not ni.player.debuff("Ослабленная душа") then
						ni.spell.cast(spells.shild)
					end
				end
			end,
			-----------------------------------
			["svd"] = function()
				if cache.sindra
						or ni.spell.available(spells.tucha) then
					if not ni.unit.debuff("target", 319822, "player")
							and cache.iss == false
							and not ni.unit.debuff("player", "Ослабление")
							or ni.unit.debuffremaining("target", 319822) < 1.5 then
						if ni.spell.valid("target", spells.svd, false, true, true)
								and not cache.control
								and cache.PlayerCombat then
							ni.spell.cast(spells.svd, "target")
						end
					end
				end
			end,
			-----------------------------------
			["pain"] = function()
				if cache.aoe_p == false
						and cache.iss == false then
					if cache.sindra
							or ni.spell.available(spells.tucha) then
						if not ni.unit.debuff("target", spells.pain, "player")
								and cache.PlayerCombat
								and ni.spell.available(spells.pain)
								and ni.unit.buffstacks("player", 15258) > 4
								and ni.spell.valid("target", spells.pain, false, true, true) then
							ni.spell.cast(spells.pain, "target")
						end
					end
				else
					local enemies = ni.unit.enemiesinrange("player", 35)
					for i = 1, #enemies do
						local target = enemies[i].guid
						if cache.sindra
								or ni.spell.available(spells.tucha) then
							if not ni.unit.debuff(target, spells.pain, "player")
									and cache.PlayerCombat
									and not ni.unit.debuff(target, "Сглаз")
									and not ni.unit.debuff(target, "Устрашающий крик")
									and not ni.unit.debuff(target, "Гнев деревьев")
									and not ni.unit.debuff(target, "Смерч")
									and not ni.unit.debuff(target, "Превращение")
									and not ni.unit.debuff(target, "Замораживающая ловушка")
									and not ni.unit.debuff(target, "Покаяние")
									and not ni.unit.debuff(target, "Ослепление")
									and not ni.unit.debuff(target, "Ошеломление")
									and not ni.unit.debuff(target, "Вой ужаса")
									and not ni.unit.debuff(target, "Изгнание")
									and not ni.unit.debuff(target, "Страх")
									and not ni.unit.debuff(target, "Спячка")
									and not ni.unit.debuff(target, "Отпугивание зверя")
									and not ni.unit.debuff(target, "Ментальный крик")
									and cache.aoe_p == true
									and ni.spell.available(spells.pain)
									and ni.unit.buffstacks("player", 15258) > 4
									and ni.spell.valid(target, spells.pain, false, true, true) then
								ni.spell.cast(spells.pain, target)
							end
						end
					end
				end
			end,
			--------------------------
			["palec"] = function()
				if cache.aoe_p == false
						and cache.iss == false then
					if cache.sindra
							or ni.spell.available(spells.tucha) then
						if not ni.unit.debuff("target", spells.palec, "player")
								or ni.unit.debuffremaining("target", spells.palec) < 1 then
							if ni.spell.valid("target", spells.palec, false, true, true)
									and not cache.IsMoving
									and cache.PlayerCombat
									and not cache.stopcast
									and cache.pal == true then
								ni.spell.cast(spells.palec, "target")
							end
						end
					end
				else
					local enemies = ni.unit.enemiesinrange("player", 35)
					for i = 1, #enemies do
						local target = enemies[i].guid
						if cache.sindra
								or ni.spell.available(spells.tucha) then
							if not ni.unit.debuff(target, spells.palec, "player")
									or ni.unit.debuffremaining(target, spells.palec) < 1 then
								if ni.spell.valid(target, spells.palec, false, true, true)
										and not cache.IsMoving
										and not ni.unit.debuff(target, "Сглаз")
										and not ni.unit.debuff(target, "Устрашающий крик")
										and not ni.unit.debuff(target, "Гнев деревьев")
										and not ni.unit.debuff(target, "Смерч")
										and not ni.unit.debuff(target, "Превращение")
										and not ni.unit.debuff(target, "Замораживающая ловушка")
										and not ni.unit.debuff(target, "Покаяние")
										and not ni.unit.debuff(target, "Ослепление")
										and not ni.unit.debuff(target, "Ошеломление")
										and not ni.unit.debuff(target, "Вой ужаса")
										and not ni.unit.debuff(target, "Изгнание")
										and not ni.unit.debuff(target, "Страх")
										and not ni.unit.debuff(target, "Спячка")
										and not ni.unit.debuff(target, "Отпугивание зверя")
										and not ni.unit.debuff(target, "Ментальный крик")
										and cache.aoe_p == true
										and cache.PlayerCombat
										and not cache.stopcast
										and cache.pal == true then
									ni.spell.cast(spells.palec, target)
								end
							end
						end
					end
				end
			end,
			-----------------------------------
			["pitka"] = function()
				if cache.sindra
						or ni.spell.available(spells.tucha) then
					if ni.unit.buffstacks("player", 15258) < 4
							and ni.spell.available(spells.pitka)
							and cache.aoe == false
							and not cache.stopcast
							and cache.PlayerCombat
							and not cache.IsMoving
							and not cache.control
							and not ni.unit.ischanneling("player")
							and ni.spell.valid("target", spells.pitka, false, true, true) then
						ni.spell.cast(spells.pitka, "target")
					end
				end
			end,
			-----------------------------------
			["chuma"] = function()
				if cache.sindra
						or ni.spell.available(spells.tucha) then
					if not ni.unit.debuff("target", spells.chuma, "player")
							and cache.PlayerCombat
							and not cache.control
							and cache.iss == false
							and ni.unit.buffstacks("player", 15258) > 4
							and ni.spell.valid("target", spells.chuma, false, true, true) then
						ni.spell.cast(spells.chuma, "target")
					end
				end
			end,
			-----------------------------------
			["issushenie"] = function()
				if cache.sindra
						or ni.spell.available(spells.tucha) then
					if not ni.unit.ischanneling("player")
							and not cache.IsMoving
							and cache.aoe == true
							and cache.PlayerCombat
							and not cache.stopcast
							and ni.spell.available(spells.issushenie)
							and ni.spell.valid("target", spells.issushenie, false, true, true) then
						ni.spell.cast(spells.issushenie, "target")
					end
				end
			end,
			--------------------------
			["razum"] = function()
				if cache.sindra
						or ni.spell.available(spells.tucha) then
					if ni.spell.cd(spells.razum) == 0
							and cache.PlayerCombat
							and cache.aoe == false
							and not cache.control
							and ni.spell.valid("target", spells.razum, false, true, true)
							and ni.unit.buffstacks("player", 15258) > 4 then
						ni.spell.cast(spells.razum, "target")
					end
				end
			end,

			-----------------------------------
			["pitka_2"] = function()
				if cache.sindra
						or ni.spell.available(spells.tucha) then
					if not ni.unit.ischanneling("player")
							and not cache.IsMoving
							and cache.aoe == false
							and not cache.control
							and cache.PlayerCombat
							and not cache.stopcast
							and ni.spell.available(spells.pitka)
							and ni.spell.valid("target", spells.pitka, false, true, true) then
						ni.spell.cast(spells.pitka, "target")
					end
				end
			end,
			--------------------------
		};
		ni.bootstrap.profile("shp_by_makaren_wrath", queue, abilities, OnLoad, OnUnLoad);
	else
		local enables = {
			["target"] = true,
			["pet"] = true,
			["tucha"] = true,
			["kamen"] = true,
			["fd"] = true,
			["aoe"] = true,
			["decurse"] = false,
			["decurse_2"] = false,
			["decurse_3"] = false,
			["debug"] = false,
		}
		local values = {
			osvob = 4,
			pet = 60,
			tucha = 50,
			aoe = 3,
			kamen = 30,
		}
		local inputs = {
			decursee = "",
			decurseee = "Мертвящая чума",
		}
		local menus = {
		}
		local function GUICallback(key, item_type, value)
			if item_type == "enabled" then
				enables[key] = value;
			elseif item_type == "value" then
				values[key] = value;
			elseif item_type == "input" then
				inputs[key] = value;
			elseif item_type == "menu" then
				menus[key] = value;
			end
		end
		local items = {
			settingsfile = "shp_by_makaren_wrath.json",
			callback = GUICallback,
			{ type = "title", text = "shp_4t4 by |c0000CED1Makaren|r" },
			{ type = "separator" },
			{ type = "title", text = "|cffFF7C0AProfile version 2.0.0|r" },
			{ type = "separator" },
			{ type = "page", number = 1, text = "|cffFFFF00Общие настройки|r" },
			{ type = "separator" },
			{ type = "entry", text = ni.spell.icon(69762) .. " Освобожденная магия",
				tooltip = "Количество набираемых стаков Освобожденной магии |cFF00FFFFЦлк(Синдрагоса)|r",
				value = 4, min = 1, max = 10, step = 1, key = "osvob" },
			{ type = "separator" },
			{ type = "entry", text = ni.spell.icon(6603) .. " Авто таргет",
				tooltip = "Автоматически выбирает таргет при его отсутствии",
				enabled = true, key = "target" },
			{ type = "separator" },
			{
				type = "entry",
				text = ni.spell.icon(11729) .. " Камень здоровья",
				tooltip = "Использует Огурец при |cFF00FF00Hp <|r\
Работает в связке с функцией TTD(Time To Die)",
				enabled = true,
				value = 30,
				min = 1,
				max = 100,
				step = 1,
				key = "kamen"
			},
			{ type = "separator" },
			{ type = "entry", text = ni.spell.icon(24803) .. " Дебаг в чат", enabled = false, key = "debug" },
			{ type = "page", number = 2, text = "|cffFFFF00Диспел|r" },
			{ type = "separator" },
			{ type = "entry", text = ni.spell.icon(988) .. " Диспел", tooltip = "Диспелит все что может",
				enabled = false, key = "decurse" },
			{ type = "entry", text = ni.spell.icon(32375) .. " Использовать масс диспел",
				tooltip = "Использует масс диспел при количестве игроков",
				enabled = false, value = 2, min = 2, max = 10, step = 1, width = 40, key = "decurse_3" },
			{ type = "entry", text = " Только конкретный дебаф",
				tooltip = "Диспелит только конкретный дебаф по имени", enabled = false,
				key = "decurse_2" },
			{
				type = "input",
				value = inputs["decursee"],
				width = 140,
				height = 15,
				key = "decursee"
			},
			{ type = "title", text = " Игнорировать дебаф" },
			{
				type = "input",
				value = inputs["decurseee"],
				width = 140,
				height = 15,
				key = "decurseee"
			},
			{ type = "page", number = 3, text = "|cffFFFF00Доп настройки|r" },
			{ type = "separator" },
			{ type = "entry", text = ni.spell.icon(34433) .. " Авто пет",
				tooltip = "Автоматически вызывает пета при мане меньше", enabled = true,
				value = 60, min = 1, max = 90, step = 1, key = "pet" },
			{ type = "entry", text = ni.spell.icon(47585) .. " Авто туча",
				tooltip = "Автоматически использует тучу при мане меньше",
				enabled = true, value = 50, min = 1, max = 80, step = 1, key = "tucha" },
			{ type = "separator" },
			{ type = "entry", text = ni.spell.icon(316466) .. " Фрагмент души по кд",
				tooltip =
				"Постоянно поддерживает баф |cFFFF0000В выключеном режиме используется только под прок перчаток или плаща|r",
				enabled = true, key = "fd" },
			{ type = "separator" },
			{ type = "entry", text = ni.spell.icon(53023) .. " Авто-АОЕ",
				tooltip = "Использует иссушение при количестве противников равному",
				enabled = true, value = 3, min = 3, max = 10, step = 1, width = 40, key = "aoe" },
		};
		local function OnLoad()
			ni.GUI.AddFrame("shp_by_makaren_wrath", items);
		end;
		local function OnUnLoad()
			ni.GUI.DestroyFrame("shp_by_makaren_wrath");
		end;
		local cache = {
			IsMoving = false,
			stopcast = false,
			sindra = false,
			PlayerCombat = false,
			pal = true,
			threat = false,
			info = true,
			aoe = false,
			aoe_p = false,
			iss = false,
			control = false,
		};
		local spells = {
			svd = GetSpellInfo(48158),
			pitka = GetSpellInfo(48156),
			palec = GetSpellInfo(48160),
			razum = GetSpellInfo(48127),
			pain = GetSpellInfo(48125),
			issushenie = GetSpellInfo(53023),
			pet = GetSpellInfo(34433),
			tucha = GetSpellInfo(47585),
			oblik = GetSpellInfo(15473),
			oblik_palec = GetSpellInfo(15286),
			ogon = GetSpellInfo(48168),
			chuma = GetSpellInfo(48300),
			shild = GetSpellInfo(48066),
			ten = GetSpellInfo(586),
			sosred = GetSpellInfo(14751),
			decurse = GetSpellInfo(988),
			decurse_po = GetSpellInfo(528),
			mass = GetSpellInfo(532375),
		};
		local ddebuffs = {
			sindra = GetSpellInfo(69766),
			sindra_metka = GetSpellInfo(70126),
			magik_hm = GetSpellInfo(305131),
		}
		local queue = {
			"info",
			"cache",
			"stop",
			"pause",
			"auto-target",
			"sindra",
			"dispell_mass",
			"dispell",
			"cd",
			"buff",
			"mana",
			"shild",
			"palec",
			"chuma",
			"razum",
			"pitka",
			"pain",
			"issushenie",
			"pitka_2",
		};
		local abilities = {
			-----------------------------------
			["info"] = function()
				if cache.info == true then
					cache.info = false
					print("|cFFFF0000  =========================|r\
|cFFFFFFFFШедоу Прист|r\
|cFFFF5A00Приватный профиль by Makaren|r\
|cFF00FFFFФанпей https://funpay.com/users/7303789/|r\
|cFF00FFFFДс https://discord.com/users/785141640087207966|r\
|cFF00FFFFДс Группы https://discord.gg/eQzcDHbVfm|r\
|cFFFF0000=========================|r")
				end
			end,
			------------------------
			["cache"] = function()
				if ni.objectmanager.contains("Повелитель горнов Игнис") then
					local ignis = ni.objectmanager.objectGUID("Повелитель горнов Игнис")
					local spell, _, _, _, _, endTime = UnitCastingInfo(ignis)
					if spell == ("Струи пламени") then
						cache.stopcast = ni.unit.iscasting(ignis)
					end
				end
				if ni.objectmanager.contains("Фрейя") then
					local freya = ni.objectmanager.objectGUID("Фрейя")
					local spell, _, _, _, _, endTime = UnitCastingInfo(freya)
					if spell == ("Дрожание земли") then
						cache.stopcast = ni.unit.iscasting(freya)
					end
				end
				if ni.objectmanager.contains("Полночь") then
					local polnoch = ni.objectmanager.objectGUID("Полночь")
					local spell, _, _, _, _, endTime = UnitCastingInfo(polnoch)
					if spell == ("Могучий топот") then
						cache.stopcast = ni.unit.iscasting(polnoch)
					end
				end
				if ni.objectmanager.contains("Заклятый страж") then
					local straz = ni.objectmanager.objectGUID("Заклятый страж")
					local spell, _, _, _, _, endTime = UnitCastingInfo(straz)
					if spell == ("Разрушительный крик") then
						cache.stopcast = ni.unit.iscasting(straz)
					end
				end
				cache.IsMoving = ni.player.ismoving() or false;
				cache.PlayerCombat = UnitAffectingCombat("player") or false;
				cache.stopcast = ni.unit.debuffremaining("player", ddebuffs.magik_hm) > 2
						or ni.unit.debuff("player", "Поцелуй Госпожи");
				cache.sindra = ni.unit.debuffstacks("player", ddebuffs.sindra) <= values.osvob;
				cache.threat = ni.unit.threat("player")
				if cache.threat > 2 then
					if ni.spell.available(spells.ten) then
						ni.spell.cast(spells.ten)
					end
				end
				local play = ni.objectmanager.objectGUID("player")
				local spell, _, _, _, _, endTime = UnitCastingInfo(play)
				local spell_, _, _, _, _, endTime = UnitChannelInfo(play)
				if spell == ("Прикосновение вампира") then
					cache.pal = false
				end
				if spell_ == ("Пытка разума")
						or spell_ == ("Иссушение разума") then
					cache.pal = true
				end
				local enemies = ni.unit.enemiesinrange("player", 35)
				local enemies_ = ni.unit.enemiesinrange("target", 9)
				if enables["aoe"] then
					if #enemies > values.aoe - 1
							and #enemies_ > values.aoe - 1 then
						cache.aoe = true
					end
					if #enemies < values.aoe then
						cache.aoe = false
					end
				else
					cache.aoe = false
				end
				for i = 1, #enemies_ do
					local target = enemies_[i].guid
					if ni.unit.debuff(target, "Сглаз")
							or ni.unit.debuff(target, "Устрашающий крик")
							or ni.unit.debuff(target, "Гнев деревьев")
							or ni.unit.debuff(target, "Смерч")
							or ni.unit.debuff(target, "Превращение")
							or ni.unit.debuff(target, "Замораживающая ловушка")
							or ni.unit.debuff(target, "Покаяние")
							or ni.unit.debuff(target, "Ослепление")
							or ni.unit.debuff(target, "Ошеломление")
							or ni.unit.debuff(target, "Вой ужаса")
							or ni.unit.debuff(target, "Изгнание")
							or ni.unit.debuff(target, "Страх")
							or ni.unit.debuff(target, "Спячка")
							or ni.unit.debuff(target, "Отпугивание зверя")
							or ni.unit.debuff(target, "Ментальный крик") then
						cache.aoe = false
					end
				end
				if #enemies == 2 then
					cache.aoe_p = true
				else
					cache.aoe_p = false
				end
				local spell__, _, _, _, _, endTime = UnitChannelInfo("player")
				if spell__ == (spells.issushenie) then
					cache.iss = true
				else
					cache.iss = false
				end
				if ni.unit.debuff("target", "Сглаз")
						or ni.unit.debuff("target", "Устрашающий крик")
						or ni.unit.debuff("target", "Гнев деревьев")
						or ni.unit.debuff("target", "Смерч")
						or ni.unit.debuff("target", "Превращение")
						or ni.unit.debuff("target", "Замораживающая ловушка")
						or ni.unit.debuff("target", "Покаяние")
						or ni.unit.debuff("target", "Ослепление")
						or ni.unit.debuff("target", "Ошеломление")
						or ni.unit.debuff("target", "Вой ужаса")
						or ni.unit.debuff("target", "Изгнание")
						or ni.unit.debuff("target", "Страх")
						or ni.unit.debuff("target", "Спячка")
						or ni.unit.debuff("target", "Отпугивание зверя")
						or ni.unit.debuff("target", "Ментальный крик") then
					cache.control = true
				else
					cache.control = false
				end
				if enables["debug"] then
					ni.vars.debug = true
				else
					ni.vars.debug = false
				end
			end,
			-----------------------------------
			["stop"] = function()
				if cache.stopcast then
					if ni.unit.iscasting("player")
							or ni.unit.ischanneling("player") then
						ni.spell.stopcasting()
					end
				end
			end,
			------------------------
			["pause"] = function()
				if IsMounted()
						or UnitInVehicle("player")
						or UnitIsDeadOrGhost("player")
						or UnitCastingInfo("player")
						or ni.spell.gcd()
						or ni.player.islooting()
						or not cache.sindra then
					return true;
				end
			end,
			-----------------------------------
			["auto-target"] = function()
				local target_ = ni.objects["target"];
				local target__ = target_.guid
				if enables["target"]
						and cache.PlayerCombat then
					if target__ == 0 then
						ni.player.runtext("/startattack")
					end
				end
			end,
			-----------------------------------
			["sindra"] = function()
				if ni.objectmanager.contains("Синдрагоса") then
					if not ni.unit.debuff("player", "Освобожденная магия")
							and ni.unit.debuffstacks("player", ddebuffs.sindra) > 7
							and ni.spell.available(spells.tucha) then
						ni.spell.cast(spells.tucha)
					end
				end
			end,
			-----------------------------------
			["dispell_mass"] = function()
				for i = 1, #ni.members do
					local ally = ni.members[i].unit;
					if enables["decurse"]
							and enables["decurse_3"] then
						if enables["decurse_2"]
								and inputs.decursee ~= "" then
							if ni.healing.candispel(ally)
									and ni.unit.debuff(ally, inputs.decursee)
									and ni.unit.debufftype(ally, "Magic") then
								local ddd = ni.members.inrangewithdebuff(ally, 14, inputs.decursee)
								if #ddd >= values.decurse_3
										and not cache.stopcast then
									ni.spell.castat(spells.mass, ally)
								end
							end
						elseif ni.healing.candispel(ally) then
							local dd = ni.members.inrange(ally, 14);
							local count = 0
							for i = 1, #dd do
								local target = dd[i].guid
								if ni.unit.debufftype(target, "Magic") then
									count = count + 1
									if count >= values.decurse_3
											and not cache.stopcast then
										ni.spell.castat(spells.mass, ally)
									end
								end
							end
						end
					end
				end
			end,
			-----------------------------------
			["dispell"] = function()
				for i = 1, #ni.members do
					local ally = ni.members[i].unit;
					if enables["decurse"] then
						if enables["decurse_2"]
								and inputs.decursee ~= "" then
							if ni.unit.debuff(ally, inputs.decursee)
									and ni.spell.available(spells.decurse)
									and ni.spell.valid(ally, spells.decurse, false, true, true) then
								ni.spell.cast(spells.decurse, ally)
								ni.spell.cast(spells.decurse_po, ally)
							end
						elseif ni.healing.candispel(ally) then
							if ni.spell.valid(ally, spells.decurse, false, true, true)
									and not ni.unit.debuff(ally, inputs.decurseee)
									and ni.spell.available(spells.decurse) then
								ni.spell.cast(spells.decurse, ally)
								ni.spell.cast(spells.decurse_po, ally)
							end
						end
					end
				end
			end,
			--------------------------
			["cd"] = function()
				if cache.sindra
						or ni.spell.available(spells.tucha) then
					if cache.PlayerCombat
							and not cache.stopcast then
						if ni.player.slotcastable(10)
								and ni.player.slotcd(10) == 0
								and not ni.unit.buff("player", spells.tucha) then
							ni.player.useinventoryitem(10)
						end
						if ni.spell.available(319326) then
							ni.spell.cast(319326)
						end
						if ni.spell.available(316421)
								and ni.power.current("player") < 80 then
							ni.spell.cast(316421)
						end
						if ni.spell.available(316295) then
							ni.spell.cast(316295)
						end
						if ni.spell.available(spells.sosred)
								and ni.spell.available(spells.razum) then
							ni.spell.cast(spells.sosred)
						end
						if ni.player.slotcastable(13)
								and ni.player.slotcd(13) == 0
								and not ni.unit.buff("player", spells.tucha) then
							ni.player.useinventoryitem(13)
						end
						if ni.player.slotcastable(14)
								and ni.player.slotcd(14) == 0
								and not ni.unit.buff("player", spells.tucha) then
							ni.player.useinventoryitem(14)
						end
						count = GetItemCount("Фрагмент души")
						if enables["fd"] then
							if ni.spell.available(316466)
									and not ni.unit.buff("player", spells.tucha)
									and not ni.unit.buff("player", 316466) then
								if count > 1
										or ni.unit.hp("target") < 10 then
									ni.spell.cast(316466)
								end
							end
						else
							if ni.spell.available(316466)
									and not ni.unit.buff("player", spells.tucha)
									and not ni.unit.buff("player", 316466) then
								if ni.player.buff(320371)
										or ni.player.buff(55637) then
									if count > 1
											or ni.unit.hp("target") < 10 then
										ni.spell.cast(316466)
									end
								end
							end
						end
						if ni.spell.available(316422) then
							ni.spell.cast(316422)
						end
						if ni.spell.available(316447) then
							ni.spell.cast("target", 316467)
						end
						if ni.unit.buff("player", 316440)
								and cache.PlayerCombat
								and ni.player.hasitem(50085) then
							ni.player.useitem(50085)
						end
						if ni.spell.available(316396)
								and ni.spell.valid("target", 316396, false, true, true) then
							ni.spell.cast(316396)
						end
						local startTime, duration, enable = GetItemCooldown(36892)
						local startTime_, duration, enable = GetItemCooldown(36893)
						local startTime__, duration, enable = GetItemCooldown(36894)
						if enables["kamen"] then
							if startTime == 0
									and startTime_ == 0
									and startTime__ == 0 then
								if ni.player.hasitem(36892)
										or ni.player.hasitem(36893)
										or ni.player.hasitem(36894) then
									if ni.unit.hp("player") < values.kamen then
										if ni.unit.ttd("player") < 2 then
											ni.player.useitem(36892)
											ni.player.useitem(36893)
											ni.player.useitem(36894)
										end
									end
								end
							end
						end
					end
				end
			end,
			-----------------------------------
			["buff"] = function()
				if cache.sindra
						or ni.spell.available(spells.tucha) then
					if not ni.unit.buff("player", spells.ogon)
							and ni.spell.available(spells.ogon) then
						ni.spell.cast(spells.ogon)
					end
					if not ni.unit.buff("player", spells.oblik)
							and ni.spell.available(spells.oblik) then
						ni.spell.cast(spells.oblik)
					end
					if not ni.unit.buff("player", spells.oblik_palec)
							and ni.spell.available(spells.oblik_palec) then
						ni.spell.cast(spells.oblik_palec)
					end
				end
			end,
			-----------------------------------
			["mana"] = function()
				if enables["pet"]
						and ni.power.current("player") <= values.pet
						and cache.PlayerCombat
						and not ni.objectmanager.contains("Синдрагоса") then
					if ni.spell.available(spells.pet) then
						ni.spell.cast(spells.pet)
						ni.player.runtext("/petattack")
					end
				end
				if enables["tucha"]
						and ni.power.current("player") <= values.tucha
						and cache.PlayerCombat
						and not ni.objectmanager.contains("Синдрагоса")
						and ni.player.slotcd(13) < 75
						and ni.player.slotcd(14) < 75
						and not ni.player.buff(32182)
						and not ni.player.buff(2825)
						and not ni.player.buff(10060)
						and not ni.player.buff(320371)
						and not ni.player.buff(55637) then
					if not ni.spell.available(spells.pet)
							and ni.spell.available(spells.tucha) then
						ni.spell.cast(spells.tucha)
					end
				end
				if enables["pet"]
						and ni.power.current("player") <= values.pet
						and cache.PlayerCombat
						and ni.objectmanager.contains("Синдрагоса") then
					if cache.sindra
							or ni.spell.available(spells.tucha) then
						if ni.spell.available(spells.pet) then
							ni.spell.cast(spells.pet)
							ni.player.runtext("/petattack")
						end
					end
				end
			end,
			-----------------------------------
			["shild"] = function()
				if ni.objectmanager.contains("Принц Малчезар") then
					if ni.player.buff("Слово силы: Щит")
							or ni.player.buff("Божья длань")
							or ni.player.buff("Божественный оберег") then
					elseif not ni.player.debuff("Ослабленная душа") then
						ni.spell.cast(spells.shild)
					end
				end
			end,
			--------------------------
			["palec"] = function()
				if cache.aoe_p == false
						and cache.iss == false then
					if cache.sindra
							or ni.spell.available(spells.tucha) then
						if not ni.unit.debuff("target", spells.palec, "player")
								or ni.unit.debuffremaining("target", spells.palec) < 1 then
							if ni.spell.valid("target", spells.palec, false, true, true)
									and not cache.IsMoving
									and cache.PlayerCombat
									and not cache.stopcast
									and cache.pal == true then
								ni.spell.cast(spells.palec, "target")
							end
						end
					end
				else
					local enemies = ni.unit.enemiesinrange("player", 35)
					for i = 1, #enemies do
						local target = enemies[i].guid
						if cache.sindra
								or ni.spell.available(spells.tucha) then
							if not ni.unit.debuff(target, spells.palec, "player")
									or ni.unit.debuffremaining(target, spells.palec) < 1 then
								if ni.spell.valid(target, spells.palec, false, true, true)
										and not cache.IsMoving
										and not ni.unit.debuff(target, "Сглаз")
										and not ni.unit.debuff(target, "Устрашающий крик")
										and not ni.unit.debuff(target, "Гнев деревьев")
										and not ni.unit.debuff(target, "Смерч")
										and not ni.unit.debuff(target, "Превращение")
										and not ni.unit.debuff(target, "Замораживающая ловушка")
										and not ni.unit.debuff(target, "Покаяние")
										and not ni.unit.debuff(target, "Ослепление")
										and not ni.unit.debuff(target, "Ошеломление")
										and not ni.unit.debuff(target, "Вой ужаса")
										and not ni.unit.debuff(target, "Изгнание")
										and not ni.unit.debuff(target, "Страх")
										and not ni.unit.debuff(target, "Спячка")
										and not ni.unit.debuff(target, "Отпугивание зверя")
										and not ni.unit.debuff(target, "Ментальный крик")
										and cache.aoe_p == true
										and cache.PlayerCombat
										and not cache.stopcast
										and cache.pal == true then
									ni.spell.cast(spells.palec, target)
								end
							end
						end
					end
				end
			end,
			-----------------------------------
			["chuma"] = function()
				if cache.sindra
						or ni.spell.available(spells.tucha) then
					if not ni.unit.debuff("target", spells.chuma, "player")
							and cache.PlayerCombat
							and cache.iss == false
							and not cache.control
							and ni.spell.valid("target", spells.chuma, false, true, true) then
						ni.spell.cast(spells.chuma, "target")
					end
				end
			end,
			--------------------------
			["razum"] = function()
				if cache.sindra
						or ni.spell.available(spells.tucha) then
					if ni.spell.cd(spells.razum) == 0
							and cache.PlayerCombat
							and not cache.control
							and cache.aoe == false
							and ni.spell.valid("target", spells.razum, false, true, true) then
						ni.spell.cast(spells.razum, "target")
					end
				end
			end,
			-----------------------------------
			["pitka"] = function()
				if cache.sindra
						or ni.spell.available(spells.tucha) then
					if ni.unit.buffstacks("player", 15258) < 4
							and cache.aoe == false
							and ni.spell.available(spells.pitka)
							and not cache.stopcast
							and cache.PlayerCombat
							and not cache.control
							and not cache.IsMoving
							and not ni.unit.ischanneling("player")
							and ni.spell.valid("target", spells.pitka, false, true, true) then
						ni.spell.cast(spells.pitka, "target")
					end
				end
			end,
			-----------------------------------
			["pain"] = function()
				if cache.aoe_p == false
						and cache.iss == false then
					if cache.sindra
							or ni.spell.available(spells.tucha) then
						if not ni.unit.debuff("target", spells.pain, "player")
								and cache.PlayerCombat
								and ni.spell.available(spells.pain)
								and ni.spell.valid("target", spells.pain, false, true, true) then
							ni.spell.cast(spells.pain, "target")
						end
					end
				else
					local enemies = ni.unit.enemiesinrange("player", 35)
					for i = 1, #enemies do
						local target = enemies[i].guid
						if cache.sindra
								or ni.spell.available(spells.tucha) then
							if not ni.unit.debuff(target, spells.pain, "player")
									and cache.PlayerCombat
									and not ni.unit.debuff(target, "Сглаз")
									and not ni.unit.debuff(target, "Устрашающий крик")
									and not ni.unit.debuff(target, "Гнев деревьев")
									and not ni.unit.debuff(target, "Смерч")
									and not ni.unit.debuff(target, "Превращение")
									and not ni.unit.debuff(target, "Замораживающая ловушка")
									and not ni.unit.debuff(target, "Покаяние")
									and not ni.unit.debuff(target, "Ослепление")
									and not ni.unit.debuff(target, "Ошеломление")
									and not ni.unit.debuff(target, "Вой ужаса")
									and not ni.unit.debuff(target, "Изгнание")
									and not ni.unit.debuff(target, "Страх")
									and not ni.unit.debuff(target, "Спячка")
									and not ni.unit.debuff(target, "Отпугивание зверя")
									and not ni.unit.debuff(target, "Ментальный крик")
									and cache.aoe_p == true
									and ni.spell.available(spells.pain)
									and ni.spell.valid(target, spells.pain, false, true, true) then
								ni.spell.cast(spells.pain, target)
							end
						end
					end
				end
			end,
			-----------------------------------
			["issushenie"] = function()
				if cache.sindra
						or ni.spell.available(spells.tucha) then
					if not ni.unit.ischanneling("player")
							and not cache.IsMoving
							and cache.aoe == true
							and cache.PlayerCombat
							and not cache.stopcast
							and ni.spell.available(spells.issushenie)
							and ni.spell.valid("target", spells.issushenie, false, true, true) then
						ni.spell.cast(spells.issushenie, "target")
					end
				end
			end,
			-----------------------------------
			["pitka_2"] = function()
				if cache.sindra
						or ni.spell.available(spells.tucha) then
					if not ni.unit.ischanneling("player")
							and cache.aoe == false
							and not cache.IsMoving
							and cache.PlayerCombat
							and not cache.control
							and not cache.stopcast
							and ni.spell.available(spells.pitka)
							and ni.spell.valid("target", spells.pitka, false, true, true) then
						ni.spell.cast(spells.pitka, "target")
					end
				end
			end,
			--------------------------
		};
		ni.bootstrap.profile("shp_by_makaren_wrath", queue, abilities, OnLoad, OnUnLoad);
	end
else
	local queue = {
		"Error",
	};
	local abilities = {
		["Error"] = function()
			ni.vars.profiles.enabled = false;
			if not Sirus then
				ni.frames.floatingtext:message("Only for SIRUS.SU")
			end
		end,
	};
	ni.bootstrap.profile("shp_by_makaren_wrath", queue, abilities);
end;
