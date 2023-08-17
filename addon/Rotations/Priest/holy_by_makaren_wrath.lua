local Sirus = GetItemInfo(100455) ~= nil or false;

if Sirus then
	local enables = {
		["gimn_mp"] = true,
		["gimn_hp"] = true,
		["molitva_save"] = true,
		["duh"] = true,
		["ik"] = true,
		["morouz_kara_hm"] = true,
		["surok"] = true,
		["lich"] = true,
		["pet"] = true,
		["tank_obn"] = true,
		["tank_fle"] = true,
		["kamen"] = true,
		["decurse"] = true,
		["decurse_2"] = false,
		["decurse_3"] = true,
		["hill_pet"] = false,
	}
	local values = {
		osvob = 4,
		decurse_3 = 2,
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
		settingsfile = "holy_4t4_by_makaren.json",
		callback = GUICallback,
		{ type = "title", text = "Holy_Priest by |c0000CED1Makaren|r" },
		{ type = "separator" },
		{ type = "title", text = "|cffFF7C0AProfile version 1.0.0|r" },
		{ type = "separator" },
		{ type = "page", number = 1, text = "|cffFFFF00Общие настройки|r" },
		{ type = "separator" },
		{ type = "entry", text = ni.spell.icon(24803) .. " Хилить петов",
			tooltip = "Хилит петов, с приоритетом ниже игроков ", enabled = false,
			key = "hill_pet" },
		{ type = "entry", text = ni.spell.icon(64901) .. " Гимн надежды",
			tooltip = "Использует Гимн надежды, |cFFFF0000с Тотемом прилива маны|r",
			enabled = true, key = "gimn_mp" },
		{ type = "entry", text = ni.spell.icon(64843) .. " Божественный гимн",
			tooltip = "Использует Божественный гимн, |cFFFF0000в критические моменты|r",
			enabled = true, key = "gimn_hp" },
		{ type = "entry", text = ni.spell.icon(19236) .. " Молитва отчаяния",
			tooltip = "Использует Молитву отчаяния, |cFFFF0000в критические моменты|r",
			enabled = true, key = "molitva_save" },
		{ type = "entry", text = ni.spell.icon(47788) .. " Оберегающий дух",
			tooltip = "Использует Оберегающего духа, |cFFFF0000в критические моменты|r",
			enabled = true, key = "duh" },
		{ type = "entry", text = ni.spell.icon(11729) .. " Камень здоровья",
			tooltip = "Использует камень здоровья |cFFFF0000в критические моменты|r",
			enabled = true, key = "kamen" },
		{ type = "entry", text = ni.spell.icon(34433) .. " Авто пет",
			tooltip = "Автоматически вызывает пета на 60% мп", enabled = true, key = "pet" },
		{ type = "page", number = 2, text = "|cffFFFF00Диспел|r" },
		{ type = "separator" },
		{ type = "entry", text = ni.spell.icon(988) .. " Диспел", tooltip = "Диспелит все что может",
			enabled = true, key = "decurse" },
		{ type = "entry", text = ni.spell.icon(32375) .. " Использовать масс диспел",
			tooltip = "Использует масс диспел при количестве игроков", enabled = true,
			value = 2, min = 2, max = 10, step = 1, width = 40, key = "decurse_3" },
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
		{ type = "page", number = 3, text = "|cffFFFF00Авто-прохил меток|r" },
		{ type = "separator" },
		{ type = "entry", text = ni.spell.icon(67049) .. " Испепеление плоти",
			tooltip = "|cFF00FFFFИк/Ивк(Джараксус)|r", enabled = true, key = "ik" },
		{ type = "entry", text = ni.spell.icon(305470) .. " Метка Смерти",
			tooltip = "|cFF00FFFFКаражан хм(Мороуз)|r", enabled = true, key = "morouz_kara_hm" },
		{ type = "entry", text = ni.spell.icon(72293) .. " Метка падшего воителя",
			tooltip = "|cFF00FFFFЦлк(Саурфанк)|r", enabled = true, key = "surok" },
		{ type = "entry", text = ni.spell.icon(68980) .. " Жатва душ", tooltip = "|cFF00FFFFЦлк(Лич)|r",
			enabled = true, key = "lich" },
		{ type = "page", number = 4, text = "|cffFFFF00Настройки исцеления|r" },
		{ type = "separator" },
		{ type = "entry", text = ni.spell.icon(48068) .. " Обновление по танкам",
			tooltip = "Поддерживает обновление на танках", enabled = true, key = "tank_obn" },
		{ type = "entry", text = ni.spell.icon(48071) .. " Флешка в танка",
			tooltip = "Использует флешку при HP танка < 50%", enabled = true, key = "tank_fle" },
		{ type = "page", number = 5, text = "|cffFFFF00Настройки боссов|r" },
		{ type = "separator" },
		{ type = "entry", text = ni.spell.icon(69762) .. " Освобожденная магия",
			tooltip = "Количество набираемых стаков Освобожденной магии |cFF00FFFFЦлк(Синдрагоса)|r",
			value = 4, min = 1, max = 10, step = 1, key = "osvob" },
	}
	local function OnLoad()
		ni.GUI.AddFrame("holy_4t4_by_makaren", items);
	end;
	local function OnUnLoad()
		ni.GUI.DestroyFrame("holy_4t4_by_makaren");
	end;
	local cache = {
		IsMoving = false,
		stopcast = false,
		sindra = false,
		PlayerCombat = false,
		threat = false,
		info = true,
	};
	local spells = {
		char_rass = GetSpellInfo(316432),
		obnovlenie = GetSpellInfo(48068),
		krug = GetSpellInfo(34861),
		molitva = GetSpellInfo(48113),
		molitva_isceleniya = GetSpellInfo(48072),
		fleshka = GetSpellInfo(48071),
		gimn_hp = GetSpellInfo(64843),
		gimn_mp = GetSpellInfo(64901),
		duh = GetSpellInfo(47788),
		molitva_save = GetSpellInfo(19236),
		sosredotochenie = GetSpellInfo(14751),
		ring = GetSpellInfo(48078),
		ogon = GetSpellInfo(48168),
		pet = GetSpellInfo(34433),
		ten = GetSpellInfo(586),
		decurse = GetSpellInfo(988),
		decurse_po = GetSpellInfo(528),
		mass = GetSpellInfo(532375),
	};
	local ddebuffs = {
		sindra = GetSpellInfo(69766),
		mk_ledy = GetSpellInfo(71289),
		curse_ledy = GetSpellInfo(71237),
		curse_grul_hm = GetSpellInfo(305230),
		morouz_kara_hm = GetSpellInfo(305470),
		magik_hm = GetSpellInfo(305131),
		sindra_metka = GetSpellInfo(70126),
	}
	local queue = {
		"info",
		"cache",
		"stop",
		"buff",
		"save",
		"dispell_mass",
		"dispell",
		"Prohill_metok",
		"gimn_mp",
		"pet",
		"krug",
		"molitva",
		"fleshka_tank",
		"obnovlenie_tank",
		"molitva_isceleniya",
		"flesh_prok",
		"obnovlenie",
		"fleshka",
		"ring",
		"pet_hill",
		"pet_dispell",
		"aoe",
	};
	local abilities = {
		--------------------------
		["info"] = function()
			if cache.info == true then
				cache.info = false
				print("|cFFFF0000  =========================|r\
|cFFFFFFFFХоли прист|r\
|cFFFF5A00Приватный профиль by Makaren|r\
|cFF00FFFFФанпей https://funpay.com/users/7303789/|r\
|cFF00FFFFДс https://discord.com/users/785141640087207966|r\
|cFF00FFFFДс Группы https://discord.gg/eQzcDHbVfm|r\
|cFFFF0000=========================|r")
			end
		end,
		------------------------
		["cache"] = function()
			cache.stopcast = ni.unit.debuffremaining("player", ddebuffs.magik_hm) > 2
					or ni.unit.debuff("player", "Поцелуй Госпожи") or false;
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
			cache.PlayerCombat = UnitAffectingCombat("player") or false;
			cache.IsMoving = ni.player.ismoving() or false;
			cache.sindra = ni.unit.debuffstacks("player", ddebuffs.sindra) <= values.osvob;
			cache.threat = ni.unit.threat("player")
			if cache.threat > 2 then
				if ni.spell.available(spells.ten) then
					ni.spell.cast(spells.ten)
				end
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
		--------------------------
		["buff"] = function()
			if cache.sindra
					and not ni.unit.buff("player", spells.ogon) then
				ni.spell.cast(spells.ogon)
			end
		end,
		--------------------------
		["save"] = function()
			if cache.sindra
					and cache.PlayerCombat then
				count = GetItemCount("Фрагмент души")
				if ni.spell.available(316466)
						and not ni.unit.buff("player", 316466) then
					if count > 1
							or ni.unit.hp("target") < 10 then
						ni.spell.cast(316466)
					end
				end
				if ni.spell.available(316295)
						and ni.members.average() <= 80 then
					ni.spell.cast(316295)
				end
				if ni.spell.available(316421)
						and ni.power.current("player") < 80 then
					ni.spell.cast(316421)
				end
				if ni.spell.available(319326)
						and ni.members.average() <= 80 then
					ni.spell.cast(319326)
				end
				if ni.spell.available(316422)
						and ni.members.average() <= 80 then
					ni.spell.cast(316422)
				end
				if ni.player.slotcastable(10)
						and ni.members.average() <= 80
						and ni.player.slotcd(10) == 0 then
					ni.player.useinventoryitem(10)
				end
				if ni.player.slotcastable(13)
						and ni.members.average() <= 80
						and ni.player.slotcd(13) == 0 then
					ni.player.useinventoryitem(13)
				end
				if ni.player.slotcastable(14)
						and ni.members.average() <= 80
						and ni.player.slotcd(14) == 0 then
					ni.player.useinventoryitem(14)
				end
				if ni.spell.available(spells.char_rass) then
					ni.spell.cast(spells.char_rass)
				end
				if enables["molitva_save"] then
					if ni.unit.hp("player") < 40 then
						if ni.unit.ttd("player") < 3
								and ni.spell.available(spells.molitva_save) then
							ni.spell.cast(spells.molitva_save)
						end
					end
				end
				for i = 1, #ni.members do
					local ally = ni.members[i].unit;
					if ni.spell.available(316447) then
						ni.spell.cast(316447, ally)
					end
					if ni.spell.available(316162)
							and ni.members.average() <= 80 then
						ni.spell.cast(316162, ally)
					end
					if ni.unit.buff("player", 316440)
							and cache.PlayerCombat
							and ni.player.hasitem(50085) then
						ni.player.useitem(50085)
					end
					if enables["duh"] then
						if ni.spell.available(spells.duh)
								and ni.unit.hp(ally) <= 20
								and ni.unit.ttd(ally) < 1
								and ni.spell.valid(ally, spells.duh, false, true, true) then
							ni.spell.cast(spells.duh, ally)
						end
					end
				end
				if enables["gimn_hp"]
						and not cache.IsMoving
						and not cache.stopcast
						and ni.members.average() <= 50
						and ni.spell.available(spells.gimn_hp) then
					if ni.spell.available(spells.sosredotochenie) then
						ni.spell.cast(spells.sosredotochenie)
					end
					ni.spell.cast(spells.gimn_hp)
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
							if ni.unit.hp("player") < 30 then
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
		-----------------------------------
		["Prohill_metok"] = function()
			if enables["ik"] then
				if not cache.IsMoving
						and not cache.stopcast then
					for i = 1, #ni.members do
						local ally = ni.members[i].unit;
						if ni.members[i]:debuff("Испепеление плоти") then
							if ni.spell.valid(ally, spells.fleshka, false, true, true) then
								ni.spell.cast(spells.fleshka, ally)
							end
						end
					end
				end
			end
			if enables["morouz_kara_hm"] then
				if not cache.IsMoving then
					for i = 1, #ni.members do
						local ally = ni.members[i].unit;
						if ni.members[i]:debuff(ddebuffs.morouz_kara_hm)
								and ni.unit.hp(ally) <= 90
								and ni.spell.valid(ally, spells.fleshka, false, true, true) then
							ni.spell.cast(spells.fleshka, ally)
						end
					end
				end
			end
			if enables["surok"] then
				if not cache.IsMoving then
					for i = 1, #ni.members do
						local ally = ni.members[i].unit;
						if ni.members[i]:debuff("Метка падшего воителя") then
							if ni.unit.hp(ally) <= 90
									and ni.spell.valid(ally, spells.fleshka, false, true, true) then
								if ni.spell.available(spells.krug) then
									ni.spell.cast(spells.krug, ally)
								end
								ni.spell.cast(spells.fleshka, ally)
							end
						end
					end
				end
			end
			if enables["lich"] then
				if not cache.IsMoving then
					for i = 1, #ni.members do
						local ally = ni.members[i].unit;
						if ni.members[i]:debuff("Жатва душ")
								or ni.members[i]:debuff("Великая жатва душ") then
							if ni.spell.valid(ally, spells.fleshka, false, true, true) then
								if ni.spell.available(spells.krug) then
									ni.spell.cast(spells.krug, ally)
								end
								ni.spell.cast(spells.fleshka, ally)
							end
						end
					end
				end
			end
		end,
		--------------------------
		["gimn_mp"] = function()
			if ni.objectmanager.contains("Тотем прилива маны")
					and cache.PlayerCombat
					and not cache.IsMoving
					and not cache.stopcast
					and ni.spell.available(spells.gimn_mp) then
				ni.spell.cast(spells.gimn_mp)
			end
		end,
		--------------------------
		["pet"] = function()
			if enables["pet"]
					and cache.PlayerCombat then
				if ni.power.current("player") <= 60
						and ni.spell.available(spells.pet) then
					ni.spell.cast(spells.pet)
					ni.player.runtext("/startattack")
					ni.player.runtext("/petattack")
				end
			end
		end,
		-----------------------------------
		["krug"] = function()
			for i = 1, #ni.members.sort() do
				local ally = ni.members[i].unit;
				local range = ni.members.inrangebelow(ally, 14, 99);
				if ni.unit.hp(ally) <= 99
						and #range >= 1
						and ni.spell.available(spells.krug)
						and ni.spell.valid(ally, spells.krug, false, true, true) then
					ni.spell.cast(spells.krug, ally)
				end
			end
		end,
		-----------------------------------
		["molitva"] = function()
			if cache.sindra
					and cache.PlayerCombat then
				for i = 1, #ni.members.sort() do
					local ally = ni.members[i].unit;
					if ni.members[i]:istank()
							and ni.spell.available(spells.molitva)
							and ni.spell.valid(ally, spells.molitva, false, true, true) then
						ni.spell.cast(spells.molitva, ally)
					end
				end
			end
		end,
		-----------------------------------
		["fleshka_tank"] = function()
			if enables["tank_fle"]
					and cache.sindra
					and not cache.IsMoving
					and not cache.stopcast then
				for i = 1, #ni.members do
					local ally = ni.members[i].unit;
					if ni.unit.hp(ally) <= 90
							and ni.members[i]:istank()
							and ni.spell.available(spells.fleshka)
							and ni.spell.valid(ally, spells.fleshka, false, true, true) then
						ni.spell.cast(spells.fleshka, ally)
					end
				end
			end
		end,
		-----------------------------------
		["obnovlenie_tank"] = function()
			if enables["tank_fle"]
					and cache.sindra then
				for i = 1, #ni.members do
					local ally = ni.members[i].unit;
					if ni.unit.hp(ally) <= 99
							and ni.members[i]:istank()
							and ni.spell.available(spells.obnovlenie)
							and not ni.unit.buff(ally, spells.obnovlenie, "player")
							and ni.spell.valid(ally, spells.obnovlenie, false, true, true) then
						ni.spell.cast(spells.obnovlenie, ally)
					end
				end
			end
		end,
		-----------------------------------
		["molitva_isceleniya"] = function()
			if cache.sindra
					and not cache.IsMoving
					and not cache.stopcast
					and ni.unit.hp("party 1") < 50
					and ni.unit.hp("party 2") < 50
					and ni.unit.hp("party 3") < 50
					and ni.unit.hp("party 4") < 50
					and ni.unit.hp("party 5") < 50
					and ni.spell.available(spells.molitva_isceleniya)
					and ni.spell.valid("party 1", spells.molitva, false, true, true)
					and ni.spell.valid("party 2", spells.molitva, false, true, true)
					and ni.spell.valid("party 3", spells.molitva, false, true, true)
					and ni.spell.valid("party 4", spells.molitva, false, true, true)
					and ni.spell.valid("party 5", spells.molitva, false, true, true) then
				ni.spell.cast(spells.molitva_isceleniya)
			end
		end,
		-----------------------------------
		["flesh_prok"] = function()
			if cache.sindra
					and ni.player.buff("Всплеск Света") then
				for i = 1, #ni.members.sort() do
					local ally = ni.members[i].unit;
					if ni.unit.hp(ally) <= 90
							and ni.spell.available(spells.fleshka)
							and ni.spell.valid(ally, spells.fleshka, false, true, true) then
						ni.spell.cast(spells.fleshka, ally)
					end
				end
			end
		end,
		-----------------------------------
		["obnovlenie"] = function()
			if cache.sindra then
				for i = 1, #ni.members.sort() do
					local ally = ni.members[i].unit;
					if ni.unit.hp(ally) <= 99
							and ni.spell.available(spells.obnovlenie)
							and not ni.unit.buff(ally, spells.obnovlenie, "player")
							and ni.spell.valid(ally, spells.obnovlenie, false, true, true) then
						ni.spell.cast(spells.obnovlenie, ally)
					end
				end
			end
		end,
		-----------------------------------
		["fleshka"] = function()
			if cache.sindra
					and not cache.IsMoving
					and not cache.stopcast then
				for i = 1, #ni.members.sort() do
					local ally = ni.members[i].unit;
					if ni.unit.hp(ally) <= 90
							and ni.spell.available(spells.fleshka)
							and ni.spell.valid(ally, spells.fleshka, false, true, true) then
						ni.spell.cast(spells.fleshka, ally)
					end
				end
			end
		end,
		-----------------------------------
		["pet_hill"] = function()
			if cache.sindra
					and enables["hill_pet"]
					and cache.PlayerCombat
					and not cache.IsMoving
					and not cache.stopcast then
				for i = 1, #ni.members do
					local ally = ni.members[i].unit;
					local creations = ni.unit.creations(ally);
					for i = 1, #creations do
						local pet = creations[i].guid
						if ni.unit.hp(pet) <= 99
								and not ni.unit.buff(pet, spells.obnovlenie, "player")
								and ni.spell.valid(pet, spells.obnovlenie, false, true, true) then
							ni.spell.cast(spells.obnovlenie, pet)
						elseif ni.unit.hp(pet) <= 90
								and not ni.unit.buff(pet, spells.fleshka, "player")
								and ni.spell.valid(pet, spells.fleshka, false, true, true) then
							ni.spell.cast(spells.fleshka, pet)
						end
					end
				end
			end
		end,
		-----------------------------------
		["pet_dispell"] = function()
			if cache.sindra
					and cache.PlayerCombat then
				for i = 1, #ni.members do
					local ally = ni.members[i].unit;
					local creations = ni.unit.creations(ally);
					for i = 1, #creations do
						local pet = creations[i].guid
						if enables["decurse"] then
							if enables["decurse_2"]
									and inputs.decursee ~= "" then
								if ni.unit.debufftype(pet, "Poison|Magic")
										and ni.unit.debuff(pet, inputs.decursee)
										and ni.spell.available(spells.decurse)
										and ni.spell.valid(pet, spells.decurse, false, true, true) then
									ni.spell.cast(spells.decurse, pet)
									ni.spell.cast(spells.decurse_po, pet)
								end
							elseif ni.unit.debufftype(pet, "Poison|Magic")
									and ni.spell.valid(pet, spells.decurse, false, true, true)
									and not ni.unit.debuff(pet, inputs.decurseee)
									and ni.spell.available(spells.decurse) then
								ni.spell.cast(spells.decurse, pet)
								ni.spell.cast(spells.decurse_po, pet)
							end
						end
					end
				end
			end
		end,
		-----------------------------------
		["aoe"] = function()
			if cache.sindra
					and ni.vars.combat.aoe then
				for i = 1, #ni.members.sort() do
					local ally = ni.members[i].unit;
					if not ni.unit.buff(ally, spells.obnovlenie, "player")
							and ni.spell.available(spells.obnovlenie)
							and ni.spell.valid(ally, spells.obnovlenie, false, true, true) then
						ni.spell.cast(spells.obnovlenie, ally)
					end
				end
			end
		end,
		-----------------------------------
	};
	ni.bootstrap.profile("holy_by_makaren_wrath", queue, abilities, OnLoad, OnUnLoad);
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
	ni.bootstrap.profile("holy_by_makaren_wrath", queue, abilities);
end;
