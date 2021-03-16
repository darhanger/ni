local items = {
	settingsfile = "Nrdr_Mistweaver.xml",
	{ type = "title", text = "Mistweaver" },
	{ type = "separator" },
	{ type = "title", text = "Main Settings" },
	{ type = "entry", text = "Enveloping Mist", enabled = true, value = 60, key = "emist" },
	{ type = "entry", text = "Mana Tea Count", value = 2, key = "manateacount" },
	{ type = "entry", text = "Mana Tea", enabled = true, value = 90, key = "manatea" },
	{ type = "entry", text = "Renewing Mist", enabled = true, value = 95, key = "rmist" },
	{ type = "entry", text = "Renewing Mist (Tank)", enabled = true, value = 90, key = "rmisttank" },
	{ type = "entry", text = "Soothing Mist", enabled = true, value = 71, key = "soothmist" },
	{ type = "entry", text = "Soothing Mist (4 Chi)", enabled = true, value = 95, key = "soothmist4chi" },
	{ type = "entry", text = "Surging Mist (Instant)", enabled = true, value = 70, key = "surgmistinst" },
	{ type = "entry", text = "Surging Mist", enabled = true, value = 40, key = "surgmist" },
	{ type = "entry", text = "TFT Surging Mist", enabled = true, value = 20, key = "tftsurgmist" },
	{ type = "entry", text = "TFT Renewing Mist", enabled = true, value = 6, key = "tftrmist" },
	{ type = "entry", text = "Life Cocoon", enabled = true, value = 20, key = "lifecocoon" },
	{ type = "entry", text = "Spinning Crane Kick", enabled = true, value = 70, key = "sck" },
	{ type = "entry", text = "Spinning Crane Kick Count", enabled = nil, value = 3, key = "sckcount" },
	{ type = "entry", text = "Low Mana", enabled = true, value = 20, key = "lowmana" },
	{ type = "entry", text = "Detox", enabled = true, value = 60, key = "detox" },
	{ type = "entry", text = "DPS", enabled = true, key = "DPS" },
	{ type = "separator" },
	{ type = "page", number = 1, text = "Non Instance Settings" },
	{ type = "separator" },
	{ type = "entry", text = "Uplift Count", enabled = nil, value = 3, key = "mainupliftcount" },
	{ type = "entry", text = "Uplift", enabled = true, value = 90, key = "mainuplift" },
	{ type = "entry", text = "TFT Uplift", enabled = true, value = 4, key = "maintftuplift" },
	{ type = "entry", text = "Chi Burst Count", enabled = nil, value = 3, key = "mainchiburstcount" },
	{ type = "entry", text = "Chi Burst", enabled = true, value = 80, key = "mainchiburst" },
	{ type = "entry", text = "Zen Sphere Count", enabled = nil, value = 1, key = "mainzenspherecount" },
	{ type = "entry", text = "Zen Sphere", enabled = true, value = 85, key = "mainzensphere" },
	{ type = "entry", text = "Chi Wave Count", enabled = nil, value = 2, key = "mainchiwavecount" },
	{ type = "entry", text = "Chi Wave", enabled = true, value = 85, key = "mainchiwave" },
	{ type = "entry", text = "Revival Count", enabled = nil, value = 4, key = "mainrevivalcount" },
	{ type = "entry", text = "Revival", enabled = true, value = 60, key = "mainrevival" },
	{ type = "page", number = 2, text = "Party Settings" },
	{ type = "separator" },
	{ type = "entry", text = "Uplift Count", value = 3, key = "partyupliftcount" },
	{ type = "entry", text = "Uplift", enabled = true, value = 90, key = "partyuplift" },
	{ type = "entry", text = "TFT Uplift", enabled = true, value = 4, key = "partytftuplift" },
	{ type = "entry", text = "Chi Burst Count", value = 3, key = "partychiburstcount" },
	{ type = "entry", text = "Chi Burst", enabled = true, value = 80, key = "partychiburst" },
	{ type = "entry", text = "Zen Sphere Count", value = 1, key = "partyzenspherecount" },
	{ type = "entry", text = "Zen Sphere", enabled = true, value = 85, key = "partyzensphere" },
	{ type = "entry", text = "Chi Wave Count", value = 2, key = "partychiwavecount" },
	{ type = "entry", text = "Chi Wave", enabled = true, value = 85, key = "partychiwave" },
	{ type = "entry", text = "Revival Count", value = 4, key = "partyrevivalcount" },
	{ type = "entry", text = "Revival", enabled = true, value = 60, key = "partyrevival" },
	{ type = "page", number = 3, text = "Raid 10 Settings" },
	{ type = "separator" },
	{ type = "entry", text = "Uplift Count", value = 3, key = "raidupliftcount" },
	{ type = "entry", text = "Uplift", enabled = true, value = 85, key = "raiduplift" },
	{ type = "entry", text = "TFT Uplift", enabled = true, value = 4, key = "raidtftuplift" },
	{ type = "entry", text = "Chi Burst Count", value = 4, key = "raidchiburstcount" },
	{ type = "entry", text = "Chi Burst", enabled = true, value = 85, key = "raidchiburst" },
	{ type = "entry", text = "Zen Sphere Count", value = 2, key = "raidzenspherecount" },
	{ type = "entry", text = "Zen Sphere", enabled = true, value = 85, key = "raidzensphere" },
	{ type = "entry", text = "Chi Wave Count", value = 3, key = "raidchiwavecount" },
	{ type = "entry", text = "Chi Wave", enabled = true, value = 85, key = "raidchiwave" },
	{ type = "entry", text = "Revival Count", value = 8, key = "raidrevivalcount" },
	{ type = "entry", text = "Revival", enabled = true, value = 60, key = "raidrevival" },
	{ type = "page", number = 4, text = "Raid 25 Settings" },
	{ type = "separator" },
	{ type = "entry", text = "Uplift Count", value = 3, key = "raid25upliftcount" },
	{ type = "entry", text = "Uplift", enabled = true, value = 90, key = "raid25uplift" },
	{ type = "entry", text = "TFT Uplift", enabled = true, value = 4, key = "raid25tftuplift" },
	{ type = "entry", text = "Chi Burst Count", value = 5, key = "raid25chiburstcount" },
	{ type = "entry", text = "Chi Burst", enabled = true, value = 85, key = "raid25chiburst" },
	{ type = "entry", text = "Zen Sphere Count", value = 2, key = "raid25zenspherecount" },
	{ type = "entry", text = "Zen Sphere", enabled = true, value = 85, key = "raid25zensphere" },
	{ type = "entry", text = "Chi Wave Count", value = 3, key = "raid25chiwavecount" },
	{ type = "entry", text = "Chi Wave", enabled = true, value = 85, key = "raid25chiwave" },
	{ type = "entry", text = "Revival Count", value = 16, key = "raid25revivalcount" },
	{ type = "entry", text = "Revival", enabled = true, value = 60, key = "raid25revival" },
};
local function GetSetting(name)
	for k, v in ipairs(items) do
		if v.type == "entry"
		 and v.key ~= nil
		 and v.key == name then
			return v.value, v.enabled
		end
		if v.type == "dropdown"
		 and v.key ~= nil
		 and v.key == name then
			for k2, v2 in pairs(v.menu) do
				if v2.selected then
					return v2.value
				end
			end
		end
	end
end
local settings = {
	group_type = "main",
	emist = GetSetting("emist"),
	manatealimit = GetSetting("manateacount"),
	manatea = GetSetting("manatea"),
	rmist = GetSetting("rmist"),
	rmisttank = GetSetting("rmisttank"),
	smist = GetSetting("soothmist"),
	smist4chi = GetSetting("soothmist4chi"),
	surmistinst = GetSetting("surgmistinst"),
	surmist = GetSetting("surgmist"),
	tftsurmist = GetSetting("tftsurgmist"),
	tftrmist = GetSetting("tftrmist"),
	lifecocoon = GetSetting("lifecocoon"),
	sck = GetSetting("sck"),
	scklimit = GetSetting("sckcount"),
	lowmana = GetSetting("lowmana"),
	detox = GetSetting("detox"),
	--Group Dependant settings here
	upliftcount = GetSetting("mainupliftcount"),
	uplift = GetSetting("mainuplift"),
	tfteauplift = GetSetting("maintftuplift"),
	chiburstlimit = GetSetting("mainchiburstcount"),
	chiburst = GetSetting("mainchiburst"),
	zenspherelimit = GetSetting("mainzenspherecount"),
	zensphere = GetSetting("mainzensphere"),
	chiwavelimit = GetSetting("mainchiwavecount"),
	chiwave = GetSetting("mainchiwave"),
	revivallimit = GetSetting("mainrevivalcount"),
	revival = GetSetting("mainrevival"),
	dps = GetSetting("DPS"),
};
local mainqueue = {
	"settings",
	"add to members",
	"pause",
	"stopcasting",
	"Stance Of The Wise Serpent",
	"Legacy Of The Emperor",
	"Jade Serpent Statue",
	"Self Survival",
	"Life Cocoon",
	"Revival",
	"Mana Tea",
	"Detox Mouseover",
	"Renewing Mist",
	"Chi Burst",
	"Zen Sphere",
	"Chi Wave",
	"Uplift",
	"Spinning Crane Kick",
	"Surging Mist",
	"Enveloping Mist",
	"Soothing Mist",
	"Expel Harm",
	"DPS: SM",
	"DPS: RM",
	"DPS: BoK",
	"DPS: TP",
	"DPS: Jab",
};
local raidqueue = {
	"settings",
	"add to members",
	"pause",
	"stopcasting",
	"Stance Of The Wise Serpent",
	"Legacy Of The Emperor",
	"Jade Serpent Statue",
	"Self Survival",
	"Life Cocoon",
	"Revival",
	"Mana Tea",
	"Tsulong Heal",
	"Detox Mouseover",
	"Renewing Mist",
	"Chi Burst",
	"Zen Sphere",
	"Chi Wave",
	"Uplift",
	"Spinning Crane Kick",
	"Surging Mist",
	"Enveloping Mist",
	"Soothing Mist",
	"Expel Harm",
	"DPS: SM",
	"DPS: RM",
	"DPS: BoK",
	"DPS: TP",
	"DPS: Jab",
};
local IsInInstance,
		GetInstanceInfo,
		UnitIsDeadOrGhost,
		UnitCastingInfo,
		UnitAffectingCombat,
		SpellIsTargeting,
		UnitChannelInfo,
		GetSpellInfo,
		UnitGetIncomingHeals,
		UnitHealth,
		UnitHealthMax =
		IsInInstance,
		GetInstanceInfo,
		UnitIsDeadOrGhost,
		UnitCastingInfo,
		UnitAffectingCombat,
		SpellIsTargeting,
		UnitChannelInfo,
		GetSpellInfo,
		UnitGetIncomingHeals,
		UnitHealth,
		UnitHealthMax;

local temptable = { };
local customtable = { };
local function SortByUnits(x, y)
	return x.unitsclose > y.unitsclose;
end
local function SortByHP(x, y)
	return x.hp < y.hp
end
local function GetTableForBestUnit(health, distance, unitsclose, buff)
	table.wipe(customtable);
	for i = 1, #ni.members do
		if ni.members[i].hp <= health
		 and ni.members[i].range
		 and (buff ~= nil 
		 and not ni.unit.buff(ni.members[i].unit, buff, "player")) then
			table.wipe(temptable);
			if buff ~= nil then
				temptable = ni.members.inrangewithoutbuff(ni.members[i].unit, distance, buff, "player");
				for k, v in ipairs(temptable) do
					if v and v.hp > health then
						tremove(temptable, k);
					end
				end
			else
				temptable = ni.members.inrangebelow(ni.members[i].unit, distannce, health);				
			end
			if #temptable >= unitsclose then
				tinsert(customtable, { unit = ni.members[i].unit, hp = ni.members[i].hp, unitsclose = #temptable });
			end
		end
	end
	if #customtable > 0 then
		table.sort(customtable, SortByHP)
	end
end
local function CalculateStopHealing(tar)
	local myincheal = UnitGetIncomingHeals(tar, "player") or 0;
	local allincheal = UnitGetIncomingHeals(tar) or 0;
	local overheal = 0;
	if myincheal >= allincheal then
		overheal = 0;
	else
		overheal = allincheal - myincheal;
	end
	local curshield = UnitHealth(tar);
	if ni.player.debuff(142861) then
		curshield = select(15, ni.unit.debuff(tar, 142863)) or select(15, ni.unit.debuff(tar, 142864)) or select(15, ni.unit.debuff(tar, 142865)) or (UnitHealthMax(tar) / 2) or 400000;
		overheal = 0;
	end
	local overhealth = 100 * (curshield + overheal) / UnitHealthMax(tar);
	if overhealth and overheal then
		return overhealth, overheal;
	else
		return 0, 0;
	end
end
local function available(spell)
	return ni.spell.available(spell, true);
end
local soothingmist = GetSpellInfo(115175);
local surgingmist = GetSpellInfo(116694);
local envelopingmist = GetSpellInfo(124682);
local zenmeditation = GetSpellInfo(131523);
local cracklingjadelightning = GetSpellInfo(117952);
local jab = GetSpellInfo(115693);
local blackoutkick = GetSpellInfo(100784);
local tigerpalm = GetSpellInfo(100787);
local spinningcranekick = GetSpellInfo(101546);
local manatea = GetSpellInfo(115294);
local jadeserpentstatue = GetSpellInfo(115313);
local stanceofthewiseserpent = GetSpellInfo(115070);
local legacyoftheemperor = GetSpellInfo(115921);
local dampenharm = GetSpellInfo(122278);
local fortifyingbrew = GetSpellInfo(115203);
local lifecocoon = GetSpellInfo(116849);
local revival = GetSpellInfo(115310);
local detox = GetSpellInfo(115450);
local renewingmist = GetSpellInfo(115151);
local chiwave = GetSpellInfo(115098);
local uplift = GetSpellInfo(116670);
local cast = ni.spell.delaycast

local abilities = {
	["settings"] = function()
		settings.emist = GetSetting("emist");
		settings.manatealimit = GetSetting("manateacount");
		settings.manatea = GetSetting("manatea");
		settings.rmist = GetSetting("rmist");
		settings.rmisttank = GetSetting("rmisttank");
		settings.smist = GetSetting("soothmist");
		settings.smist4chi = GetSetting("soothmist4chi");
		settings.surmistinst = GetSetting("surgmistinst");
		settings.surmist = GetSetting("surgmist");
		settings.tftsurmist = GetSetting("tftsurgmist");
		settings.tftrmist = GetSetting("tftrmist");
		settings.lifecocoon = GetSetting("lifecocoon");
		settings.sck = GetSetting("sck");
		settings.scklimit = GetSetting("sckcount");
		settings.lowmana = GetSetting("lowmana");
		settings.detox = GetSetting("detox");
		if settings.group_type == "main" then
			settings.upliftcount = GetSetting("mainupliftcount");
			settings.uplift = GetSetting("mainuplift");
			settings.tfteauplift = GetSetting("maintftuplift");
			settings.chiburstlimit = GetSetting("mainchiburstcount");
			settings.chiburst = GetSetting("mainchiburst");
			settings.zenspherelimit = GetSetting("mainzenspherecount");
			settings.zensphere = GetSetting("mainzensphere");
			settings.chiwavelimit = GetSetting("mainchiwavecount");
			settings.chiwave = GetSetting("mainchiwave");
			settings.revivallimit = GetSetting("mainrevivalcount");
			settings.revival = GetSetting("mainrevival");
		elseif settings.group_type == "party" then
			settings.upliftcount = GetSetting("partyupliftcount");
			settings.uplift = GetSetting("partyuplift");
			settings.tfteauplift = GetSetting("partytftuplift");
			settings.chiburstlimit = GetSetting("partychiburstcount");
			settings.chiburst = GetSetting("partychiburst");
			settings.zenspherelimit = GetSetting("partyzenspherecount");
			settings.zensphere = GetSetting("partyzensphere");
			settings.chiwavelimit = GetSetting("partychiwavecount");
			settings.chiwave = GetSetting("partychiwave");
			settings.revivallimit = GetSetting("partyrevivalcount");
			settings.revival = GetSetting("partyrevival");	
		elseif settings.group_type == "raid10" then
			settings.upliftcount = GetSetting("raidupliftcount");
			settings.uplift = GetSetting("raiduplift");
			settings.tfteauplift = GetSetting("raidtftuplift");
			settings.chiburstlimit = GetSetting("raidchiburstcount");
			settings.chiburst = GetSetting("raidchiburst");
			settings.zenspherelimit = GetSetting("raidzenspherecount");
			settings.zensphere = GetSetting("raidzensphere");
			settings.chiwavelimit = GetSetting("raidchiwavecount");
			settings.chiwave = GetSetting("raidchiwave");
			settings.revivallimit = GetSetting("raidrevivalcount");
			settings.revival = GetSetting("raidrevival");
		elseif settings.group_type == "raid25" then
			settings.upliftcount = GetSetting("raid25upliftcount");
			settings.uplift = GetSetting("raid25uplift");
			settings.tfteauplift = GetSetting("raid25tftuplift");
			settings.chiburstlimit = GetSetting("raid25chiburstcount");
			settings.chiburst = GetSetting("raid25chiburst");
			settings.zenspherelimit = GetSetting("raid25zenspherecount");
			settings.zensphere = GetSetting("raid25zensphere");
			settings.chiwavelimit = GetSetting("raid25chiwavecount");
			settings.chiwave = GetSetting("raid25chiwave");
			settings.revivallimit = GetSetting("raid25revivalcount");
			settings.revival = GetSetting("raid25revival");
		end
	end,
	["add to members"] = function()
		if GetCurrentKeyBoardFocus() then
			return;
		end
		if not IsRightShiftKeyDown() and ni.functions.keypressed(0x52) then
			if UnitExists("mouseover") and UnitCanAssist("player", "mouseover") then
				ni.members.addcustom(UnitGUID("mouseover"));
				return true;
			end
		elseif IsRightShiftKeyDown() and ni.functions.keypressed(0x52) then
			if UnitExists("mouseover") and UnitCanAssist("player", "mouseover") then
				ni.members.removecustom(UnitGUID("mouseover"));
				return true;
			end
		end
	end,
	["pause"] = function()
		if UnitIsDeadOrGhost("player")
		 or IsMounted()
		 or ni.player.buff(104269) then
			return true;
		end
	end,
	["stopcasting"] = function()
		if SpellIsTargeting() then
			ni.spell.stopcasting();
		elseif UnitChannelInfo("player") == soothingmist
		 and ni.player.powerraw("chi") >= 4 then
			for i = 1, #ni.members do
				if ni.unit.buff(ni.members[i].unit, 115175, "player")
				 and (IsSpellInRange(soothingmist, ni.members[i].unit) ~= 1
				 or CalculateStopHealing(ni.members[i].unit) > settings.smist4chi) then
					ni.spell.stopcasting();
					return true;
				end
			end
		end
		local curcast = UnitCastingInfo("player");
		if curcast == surgingmist then
			ni.spell.stopcasting();
			return true;
		elseif curcast == envelopingmist then
			ni.spell.stopcasting();
			return true;
		end
	end,
	["Stance Of The Wise Serpent"] = function()
		if GetShapeshiftForm() ~= 1
		 and not UnitCastingInfo("player") then
			cast(stanceofthewiseserpent, nil, 1);
		end
	end,
	["Legacy Of The Emperor"] = function()
		if not ni.player.buff(1126)
		 and not ni.player.buff(20217)
		 and not ni.player.buff(90363)
		 and not ni.player.buff(legacyoftheemperor)
		 and ni.spell.available(legacyoftheemperor)
		 and not UnitCastingInfo("player") then
				ni.spell.cast(legacyoftheemperor, "player");
				return true;
		 end
	end,
	["Jade Serpent Statue"] = function()
		if not GetCurrentKeyBoardFocus() and ni.functions.keypressed(0x47) then
			if not UnitChannelInfo("player")
			 and not UnitCastingInfo("player")
			 and available(jadeserpentstatue) then
				ni.spell.castat(jadeserpentstatue, "mouse");
				return true;
			end
		end
	end,
	["Self Survival"] = function()
		if ni.player.hp() <= 20
		 and UnitAffectingCombat("player") then
			local curchannel = UnitChannelInfo("player");
			local iscasting = UnitCastingInfo("player");
			if GetItemCount(5512, false, true) > 0
			 and ni.player.itemcd(5512) == 0
			 and curchannel ~= zenmeditation then
				if iscasting then
					ni.spell.stopcasting();
				end
				ni.player.useitem(5512);
				return true;
			elseif available(dampenharm)
			 and curchannel ~= zenmeditation
			 and select(2, GetTalentRowSelectionInfo(5)) == 14 then
				if iscasting then
					ni.spell.stopcasting();
				end
				ni.spell.cast(dampenharm);
				return true;
			elseif available(fortifyingbrew)
			 and curchannel ~= zenmeditation
			 and not ni.player.buff(122278) then
				if iscasting then
					ni.spell.stopcasting();
				end
				ni.spell.cast(fortifyingbrew);
				return true;
			end
		end
	end,
	["Life Cocoon"] = function()
		if available(lifecocoon)
		 and UnitChannelInfo("player") ~= zenmeditation
		 and UnitAffectingCombat("player")
		 and ni.members[1].hp < settings.lifecocoon
		 and ni.members[1].threat == 3
		 and ni.spell.valid(ni.members[1].unit, lifecocoon, false, true, true) then
			if UnitCastingInfo("player") then
				ni.spell.stopcasting();
			end
			ni.spell.cast(lifecocoon, ni.members[1].unit);
			return true;
		end
	end,
	["Revival"] = function()
		if available(revival)
		 and UnitChannelInfo("player") ~= zenmeditation
		 and UnitAffectingCombat("player") then
			local count = settings.revivallimit;
			if settings.revivallimit > #ni.members then
				count = #ni.members
			end
			if #ni.members.inrangebelow("player", 100, settings.revival) >= count then
				if UnitCastingInfo("player") then
					ni.spell.stopcasting();
				end
				ni.spell.cast(revival);
				return true;
			end
		end
	end,
	["Mana Tea"] = function()
		local curchannel = UnitChannelInfo("player");
		if available(manatea)
		 and not ni.player.buff(101546)
		 and not ni.player.ismoving()
		 and curchannel ~= zenmeditation
		 and curchannel ~= cracklingjadelightning
		 and not UnitCastingInfo("player") then
			local manatea, _, _, count = ni.player.buff(115867);
			if manatea
			 and ((count >= settings.manatealimit
			 and ni.player.power("mana") <= settings.manatea)
			 or ni.player.buff(64904)
			 or ni.player.power("mana") <= settings.lowmana) then
				ni.spell.cast(manatea, "player");
				return true;
			end
		end
	end,
	["Tsulong Heal"] = function()
		if UnitExists("boss1") then
			if ni.unit.id("boss1") == 62442 then
				if available(115175)
				 and ni.spell.valid("boss1", 115175, false, true, true) then
					if ni.unit.hp("boss1") < 100 then
						local isbil = false;
						local bathedinlight = GetSpellInfo(122858);
						if UnitCastingInfo("boss1") == bathedinlight then
							isbil = true;
						end
						local iscasting = UnitCastingInfo("player");
						--Renewing Mist
						if available(115151)
						 and not ni.unit.buff("boss1", 115151, "player")
						 and ni.spell.valid("boss1", 115151, false, true, true)
						 and not iscasting then
							ni.spell.cast(115151, "boss1");
							return true;
						end
						local channeling = UnitChannelInfo("player");
						--Enveloping Mist
						if available(124682)
						 and ni.spell.valid("boss1", 124682, false, true, true)
						 and channeling == GetSpellInfo(115175)
						 and ni.unit.buff("boss1", 115175, "player")
						 and not ni.unit.buff("boss1", 124682, "player") then
							local chi = ni.player.powerraw("chi");
							if chi >= 3 then
								ni.spell.cast(124682, "boss1");
								return true;
							elseif chi == 0
							 and select(2, GetTalentRowSelection(3)) == 9 then
								ni.spell.cast(115339);
								ni.spell.cast(124682, "boss1");
								return true;
							end
						end
						--Surging Mist
						if available(116694)
						 and ni.spell.valid("boss1", 116694, false, true, true) then
							local vitalmists, _, _, vmcount = ni.player.buff(118674);
							if vitalmists and vmcount == 5
							 and not iscasting then
								ni.spell.cast(116694, "boss1");
								return true;
							end
							if ni.player.power("mana") > 70
							 or UnitDebuff("player", "Bathed in Light") then
								if channeling == GetSpellInfo(115175)
								 and ni.unit.buff("boss1", 115175, "player")
								 and not iscasting then
									if available(116680)
									 and not ni.player.buff(116680)
									 and ni.player.powerraw("chi") >= 3 then
										ni.spell.cast(116680);
									end
									ni.spell.cast(116694, "boss1");
									return true;
								end
							end
						end
						--Soothing mist
						if ni.members[1].hp > 30
						 and ni.members.below(80) < 10 then
							if available(115175)
							 and not ni.player.ismoving()
							 and not iscasting
							 and ni.spell.valid("boss1", 115175, false, true, true)
							 and not ni.unit.buff("boss1", 115175, "player") then
								ni.spell.cast(115175, "boss1");
								return true;
							end
						end
					end
				end
			end
		end
	end,
	["Detox Mouseover"] = function()
		if available(detox) then
			local curchannel = UnitChannelInfo("player");
			if UnitExists("mouseover")
			 and not ni.player.buff(101546)
			 and not UnitCastingInfo("player")
			 and curchannel ~= zenmeditation
			 and curchannel ~= cracklingjadelightning
			 and ni.spell.valid("mouseover", detox, false, true, true)
			 and ni.healing.candispel("mouseover") then 
				ni.spell.cast(detox, "mouseover");
				return true;
			end
		end
	end,
	["Renewing Mist"] = function()
		if available(renewingmist) then
			local curchannel = UnitChannelInfo("player");
		 	if not ni.player.buff(101546)
			 and curchannel ~= zenmeditation
			 and curchannel ~= cracklingjadelightning then
				GetTableForBestUnit(settings.rmisttank, 40, 2, renewingmist);
				if #customtable > 0 then
					if customtable[1].unitsclose >= 2
					 and ni.spell.valid(customtable[1].unit, renewingmist, false, true, true) then
						if UnitThreatSituation(customtable[1].unit) == 3
						 or customtable[1].hp <= settings.rmist then
							ni.spell.cast(renewingmist, customtable[1].unit);
							return true;
						end
					end
				end
			end
		end
	end,
	["Chi Burst"] = function()
		
	end,
	["Zen Sphere"] = function()
		
	end,
	["Chi Wave"] = function()
		if select(2, GetTalentRowSelectionInfo(2)) == 4 and available(chiwave) then
			local curchannel = UnitChannelInfo("player");
			if not ni.player.buff(101546)
			 and curchannel ~= zenmeditation
			 and curchannel ~= cracklingjadelightning
			 and UnitAffectingCombat("player")
			 and ni.members.averageof(settings.chiwavelimit) <= settings.chiwave then
				for i = 1, 4 do
					local boss = "boss"..i;
					if UnitExists(boss) and ni.unit.shortguid(boss) == 60708 then
						for i = 1, #ni.members do
							if ni.unit.debuff(ni.members[i].unit, 117708) then
								return false;
							end
						end
					end
				end
				GetTableForBestUnit(settings.chiwave, 20, settings.chiwavelimit);
				if #customtable > 0 then
					if ni.spell.valid(customtable[1].unit, chiwave, false, true, true) then
						ni.spell.cast(chiwave, customtable[1].unit);
						return true;
					end
				end
			end
		end
	end,
	["Uplift"] = function()
		local curchannel = UnitChannelInfo("player");
		if available(uplift)
		 and not ni.player.buff(101546)
		 and not UnitCastingInfo("player")
		 and curchannel ~= zenmeditation
		 and curchannel ~= cracklingjadelightning then
			local upliftcount = 0;
			local rmcount = 0;
			for i = 1, #ni.members do
				if ni.unit.buff(ni.members[i].unit, 115151, "player") then
					rmcount = rmcount + 1;
					if ni.members[i].hp <= settings.uplift then
						upliftcount = upliftcount + 1;
					end
				end
			end
			local chi = ni.player.powerraw("chi");
			if chi >= 2 then
				if (upliftcount >= settings.upliftcount
				 and (chi >= 2 and ni.player.power("mana") < settings.lowmana))
				 or (chi >= 4
				 and (upliftcount >= (settings.upliftcount -1))) then
					if available(116680)
					 and not ni.player.buff(116680)
					 and chi >= 3
					 and ((upliftcount >= settings.tfteauplift)
					 or (rmcount >= settings.tftrmist)) then
						ni.spell.cast(116680);
					end
					ni.spell.cast(uplift);
					return true;
				end
			end
		end
	end,
	["Spinning Crane Kick"] = function()
		if ni.spell.available(spinningcranekick) then
			if not ni.player.buff(139597)
			 and ni.player.power("mana") >= 20
			 and ni.player.powerraw("chi") <= 3
			 and not UnitCastingInfo("player")
			 and #ni.members.inrangebelow("player", 8, settings.sck) >= settings.scklimit then
				ni.spell.cast(spinningcranekick);
				return true;
			end
		end
	end,
	["Surging Mist"] = function()
		local curchannel = UnitChannelInfo("player");
		if available(116694)
		 and not ni.player.buff(101546)
		 and not UnitCastingInfo("player")
		 and curchannel ~= zenmeditation
		 and curchannel ~= cracklingjadelightning
		 and ni.spell.valid(ni.members[1].unit, 116694, false, true, true) then
			local vm, _, _, count = ni.player.buff(118674);
			if ni.members[1].hp < settings.surmistinst
			 and vm and count == 5 then
				if available(116680)
				 and not ni.player.buff(116680)
				 and ni.player.powerraw("chi") >= 1
				 and ni.members[1].hp <= settings.tftsurmist then
					ni.spell.cast(116680);
				end
				ni.spell.cast(116694, ni.members[1].unit);
				return true;
			end
			if ni.members[1].hp < settings.surmist
			 and ni.player.power("mana") > settings.lowmana - 5 then
				if curchannel == soothingmist
				 and ni.unit.buff(ni.members[1].unit, 115175) then
					if available(116680)
					 and not ni.player.buff(116680)
					 and ni.player.powerraw("chi") >= 1
					 and ni.members[1].hp <= settings.tftsurmist then
					  ni.spell.cast(116680);
				  end
				  ni.spell.cast(116694, ni.members[1].unit);
				  return true;
				end
			end
		end
	end,
	["Enveloping Mist"] = function()
		local curchannel = UnitChannelInfo("player");
		if available(124682)
		 and ni.members[1].hp < settings.emist
		 and not ni.player.buff(101546)
		 and not UnitCastingInfo("player")
		 and curchannel ~= zenmeditation
		 and curchannel ~= cracklingjadelightning
		 and curchannel == soothingmist
		 and ni.spell.valid(ni.members[1].unit, 124682, false, true, true)
		 and ni.unit.buff(ni.members[1].unit, 115175, "player")
		 and not ni.unit.buff(ni.members[1].unit, 124682, "player") then
			local chi = ni.player.powerraw("chi");
			if chi >= 3 then
				ni.spell.cast(124682, ni.members[1].unit);
				return true;
			elseif chi == 0
			 and select(2, GetTalentRowSelectionInfo(3)) == 9
			 and ni.spell.cd(115399) == 0 then
				ni.spell.cast(115399);
				ni.spell.cast(124682, ni.members[1].unit);
				return true;
			end
		end
	end,
	["Soothing Mist"] = function()
		settings.dps = select(2, GetSetting("DPS"));
		if settings.dps and ni.spell.valid("target", jab, true, true) or ni.player.ismoving() then
			return false;
		end
		local curchannel = UnitChannelInfo("player");
		if available(115175)
		 and not ni.player.buff(101546)
		 and not UnitCastingInfo("player")
		 and curchannel ~= zenmeditation
		 and curchannel ~= cracklingjadelightning
		 and not ni.player.ismoving()
		 and not ni.player.buff(131523)
		 and not ni.members[1]:buff(115175, "player")
		 and ni.spell.valid(ni.members[1].unit, 115175, false, true, true) then
			local chi = ni.player.powerraw("chi");
			if ni.members[1].hp <= settings.smist 
			 and chi >= 4 then
				ni.spell.cast(soothingmist, ni.members[1].unit);
				return true;
			elseif ni.members[1].hp <= settings.smist4chi
			 and ni.player.power("mana") >= 15
			 and chi < 4 then
				ni.spell.cast(soothingmist, ni.members[1].unit);
				return true;
			end
		end
	end,
	["Expel Harm"] = function()
		if ni.spell.available(115072) then
			local curchannel = UnitChannelInfo("player");
			if ni.player.powerraw("chi") < 4
			 and ni.player.hp() <= 90
			 and not ni.player.buff(101546)
			 and not UnitCastingInfo("player")
			 and curchannel ~= zenmeditation
			 and curchannel ~= cracklingjadelightning then
				ni.spell.cast(115072);
				return true;
			end
		end
	end,
	["DPS: SM"] = function()
		if not settings.dps then
			return true;
		end
		if ni.spell.available(116694) then
			local curchannel = UnitChannelInfo("player");
			if not ni.player.buff(101546)
			 and not UnitCastingInfo("player")
			 and curchannel ~= zenmeditation
			 and curchannel ~= cracklingjadelightning
			 and ni.player.powerraw("chi") >= 1
			 and UnitAffectingCombat("player") then
				local vitalmists, _, _, count = ni.player.buff(118674);
				if vitalmists and count == 5 then
					if ni.spell.valid(ni.members[1].unit, surgingmist, false, true, true) then
						ni.spell.cast(surgingmist, ni.members[1].unit);
						return true;
					else
						ni.spell.cast(surgingmist, "player");
						return true;
					end
				end
			end
		end
	end,
	["DPS: RM"] = function()
		if ni.spell.available(115151) then
			local curchannel = UnitChannelInfo("player");
			if not ni.unit.buff(ni.members[1].unit, 115151, "player")
			 and not ni.player.buff(101546)
			 and not UnitCastingInfo("player")
			 and curchannel ~= zenmeditation
			 and curchannel ~= cracklingjadelightning
			 and ni.player.powerraw("chi") >= 1
			 and UnitAffectingCombat("player") then
				if ni.spell.valid(ni.members[1].unit, 115151, false, true, true) then
					ni.spell.cast(115151, ni.members[1].unit);
					return true;
				end
			end
		end
	end,
	["DPS: BoK"] = function()
		if ni.spell.available(100784) then
			local curchannel = UnitChannelInfo("player");
			if UnitAffectingCombat("player")
			 and not ni.player.buff(101546)
			 and not UnitCastingInfo("player")
			 and curchannel ~= zenmeditation
			 and curchannel ~= cracklingjadelightning
			 and ni.spell.valid("target", 100784, true, true)
			 and ni.player.powerraw("chi") >= 2 then
				local serpentszeal, _, _, _, _, _, sztime = ni.player.buff(127722);
				if not serpentszeal then
					ni.spell.cast(blackoutkick, "target");
					return true;
				else
					if sztime - GetTime() <= 2 then
						ni.spell.cast(blackoutkick, "target");
						return true;
					elseif ni.spell.available(100787) then
						ni.spell.cast(tigerpalm, "target");
					end
				end
			end
		end
	end,
	["DPS: TP"] = function()
		if ni.spell.available(100787) then
			local curchannel = UnitChannelInfo("player");
			if UnitAffectingCombat("player")
			 and not ni.player.buff(101546)
			 and not UnitCastingInfo("player")
			 and curchannel ~= zenmeditation
			 and curchannel ~= cracklingjadelightning
			 and ni.spell.valid("target", 100787, true, true) then
				ni.spell.cast(tigerpalm, "target");
				return true;
			end
		end
	end,
	["DPS: Jab"] = function()
		if ni.spell.available(jab) then
			local curchannel = UnitChannelInfo("player");
			if UnitAffectingCombat("player")
			 and not ni.player.buff(101546)
			 and not UnitCastingInfo("player")
			 and curchannel ~= zenmeditation
			 and curchannel ~= cracklingjadelightning
			 and ni.player.powerraw("chi") < 1
			 and ni.spell.valid("target", jab, true, true) then
				ni.spell.cast(jab, "target");
				return true;
			end
		end
	end,
};
local function queue()
	local info1, info2, info3 = GetInstanceInfo();
	if IsInInstance() then
		if info2 == "party" then
			settings.group_type = "party";
			return mainqueue;
		elseif info2 == "raid" and (info3 == 3 or info3 == 5) then
			settings.group_type = "raid10";
			return raidqueue;
		elseif info2 == "raid" and (info3 == 4 or info3 == 6 or info3 == 7) then
			settings.group_type = "raid25";
			return raidqueue;
		end
	end
	settings.group_type = "main";
	return mainqueue;
end
ni.bootstrap.rotation("Mistweaver", queue, abilities, nil, { [1] = "Mistweaver", [2] = items });