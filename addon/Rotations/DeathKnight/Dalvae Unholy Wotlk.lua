local enables = {
	["target"] = true,
	["shield"] = true,
	["horn"] = true,
	["pet"] = true,
	["stoika"] = true,
	["ik"] = true,
	["lana"] = true,
	["nii"] = true,
	["deathpact"] = true,
	["kamen"] = true,
	["pestilence"] = true,
	["pestilence_aoe"] = true,
	["kick"] = false,
	["kick_2"] = false,
	["kick_3"] = false,
	["debug"] = false,
}
local values = {
	kamen = 30,
	deathpact = 20,
	nii = 30,
}
local inputs = {
	kiick = "",
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
	settingsfile = "dalvae unholy.json",
	callback = GUICallback,
	{ type = "title", text = "Unholy by |c0000CED1Dalvae|r" },
	{ type = "separator" },
	{ type = "title", text = "|cffFF7C0AProfile version 2.0.0|r" },
	{ type = "separator" },
	{ type = "page", number = 1, text = "|cffFFFF00ОбSettings|r" },
	{ type = "separator" },
	{
		type = "entry",
		text = ni.spell.icon(6603) .. " Аuto target",
		tooltip = "Аutomatic select target when absent",
		enabled = true,
		key = "target"
	},
	{ type = "separator" },
	{
		type = "entry",
		text = ni.spell.icon(48265) .. " Аuto stance switch",
		tooltip = "Automacaly switch stances",
		enabled = true,
		key = "stance"
	},
	{ type = "separator" },
	{
		type = "entry",
		text = ni.spell.icon(57623) .. " Аuto horn",
		tooltip = "Automaticaly  use horn of winter",
		enabled = true,
		key = "horn"
	},
	{
		type = "entry",
		text = ni.spell.icon(49222) .. " Аuto bone shield",
		tooltip = "Automatically use the bone shield when is abasent",
		enabled = true,
		key = "shield"
	},
	{ type = "separator" },
	{
		type = "entry",
		text = ni.spell.icon(46584) .. " Аuto summon pet",
		tooltip = "Аutomatically summon pet",
		enabled = true,
		key = "pet"
	},
	{ type = "separator" },
	{
		type = "entry",
		text = ni.spell.icon(24803) .. " Debug in chat",
		enabled = false,
		key =
		"debug"
	},
	{ type = "page",     number = 2, text = "|cffFFFF00Aditional settings|r" },
	{ type = "separator" },
	{
		type = "entry",
		text = ni.spell.icon(50842) .. " Авто мор",
		tooltip = "Автоматически обновляет доты мором",
		enabled = true,
		key = "pestilence"
	},
	{
		type = "entry",
		text = ni.spell.icon(50842) .. " Auto Pestilence",
		tooltip = "Automatically refreshes dots with pestilence",
		enabled = true,
		key = "pestilence"
	},
	{ type = "separator" },
	{
		type = "entry",
		text = ni.spell.icon(47528) .. " Аuto-kick",
		tooltip = "Interrupt all spells",
		enabled = false,
		key = "kick"
	},
	{
		type = "entry",
		text = "Everyone within range",
		tooltip = "Interrupts everyone within range (not only the target)",
		enabled = false,
		key = "kick_2"
	},
	{
		type = "entry",
		text = "Specific cast",
		tooltip = "Interrupts a specific cast by name",
		enabled = false,
		key = "kick_3"
	},

	{
		type = "input",
		value = inputs["kiick"],
		width = 140,
		height = 15,
		key = "kiick"
	},
	{ type = "page",     number = 3,                 text = "|cffFFFF00Smart shield|r" },
	{ type = "entry",    text = ni.spell.icon(48707) },
	{ type = "separator" },
	{
		type = "entry",
		text = ni.spell.icon(300996) .. " Flame of the Legion",
		tooltip = "|cFF00FFFFIC/IVC(Jaraxxus)|r",
		enabled = true,
		key = "ik"
	},
	{
		type = "entry",
		text = ni.spell.icon(71264) .. " Swarming Shadows",
		tooltip = "|cFF00FFFFICC(Lana'thel)|r",
		enabled = true,
		key = "lana"
	},
	{ type = "page",     number = 4, text = "|cffFFFF00Autosaves|r" },
	{ type = "separator" },
	{
		type = "entry",
		text = ni.spell.icon(48792) .. " Icebound Fortitude",
		tooltip = "Uses Icebound Fortitude when |cFF00FF00Hp < |r\
		Works in conjunction with the TTD (Time To Die) function",
		enabled = true,
		value = 40,
		min = 1,
		max = 100,
		step = 1,
		key = "nii"
	},

	{
		type = "entry",
		text = ni.spell.icon(48743) .. " Death Pact",
		tooltip = "Uses Death Pact when |cFF00FF00Hp < |r\
		Works in conjunction with the TTD (Time To Die) function",
		enabled = true,
		value = 20,
		min = 1,
		max = 100,
		step = 1,
		key = "deathpact"
	},

	{
		type = "entry",
		text = ni.spell.icon(11729) .. " Health Stone",
		tooltip = "Uses Health Stone when |cFF00FF00Hp < |r\
		Works in conjunction with the TTD (Time To Die) function",
		enabled = true,
		value = 30,
		min = 1,
		max = 100,
		step = 1,
		key = "hs"
	},

};
local function OnLoad()
	ni.GUI.AddFrame("dalvae_unholy", items);
end;
local function OnUnLoad()
	ni.GUI.DestroyFrame("dalvae_unholy");
end;
local cache = {
	sindra = false,
	PlayerCombat = false,
	aoe = false,
	info = true,
	dots = false,
	dots_obnov = false,
	pet = true,
	control = false,
};
local spells = {
	horn = GetSpellInfo(57623),
	shield = GetSpellInfo(49222),
	pet = GetSpellInfo(46584),
	icytouch = GetSpellInfo(49909),
	plaguestrike = GetSpellInfo(49921),
	plet = GetSpellInfo(55271),
	deathanddecay = GetSpellInfo(49938),
	garga = GetSpellInfo(49206),
	deathcoil = GetSpellInfo(49895),
	bloodstrike = GetSpellInfo(49930),
	pestilence = GetSpellInfo(50842),
	char_rass = GetSpellInfo(316432),
	empowerrune = GetSpellInfo(47568),
	bloodpresence = GetSpellInfo(48266),
	unholypresence = GetSpellInfo(48265),
	bloodtap = GetSpellInfo(45529),
	antimagic = GetSpellInfo(48707),
	icebornfortitude = GetSpellInfo(48792),
	deathpact = GetSpellInfo(48743),
	kick = GetSpellInfo(47528),

};
local ddebuffs = {
	sindra = GetSpellInfo(69766),
	sindra_mark = GetSpellInfo(70126),
}
local queue = {
	"cache",
	"pause",
	"auto-target",
	"kick",
	"cd",
	"unholypresence",
	"save",
	"antimagic",
	"pestilence",
	"pestilence_aoe",
	"buff",
	"icytouch",
	"plaguestrike",
	"bloodstrike",
	"plet",
	"char_radeathpact",
	"deathcoil_buf",
	"gargola",
	"empowerrune",
	"bloodpresence",
	"deathcoil",
};
local abilities = {

	["cache"] = function()
		cache.PlayerCombat = UnitAffectingCombat("player") or false;

		if ni.unit.debuff("target", 55078, "player")
				and ni.unit.debuff("target", 55095, "player") then
			cache.dots = true
		else
			cache.dots = false
		end
		if ni.unit.debuffremaining("target", 55095, "player") < 2
				or ni.unit.debuffremaining("target", 55078, "player") < 2 then
			cache.dots_obnov = true
		else
			cache.dots_obnov = false
		end
		if ni.unit.debuff("target", "Intimidating Shout")
				or ni.unit.debuff("target", "Nature's Grasp")
				or ni.unit.debuff("target", "Cyclone")
				or ni.unit.debuff("target", "Polymorph")
				or ni.unit.debuff("target", "Freezing Trap")
				or ni.unit.debuff("target", "Repentance")
				or ni.unit.debuff("target", "Blind")
				or ni.unit.debuff("target", "Daze")
				or ni.unit.debuff("target", "Howl of Terror")
				or ni.unit.debuff("target", "Banish")
				or ni.unit.debuff("target", "Fear")
				or ni.unit.debuff("target", "Hibernate")
				or ni.unit.debuff("target", "Scare Beast")
				or ni.unit.debuff("target", "Psychic Scream") then
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
	------------------------
	["pause"] = function()
		if IsMounted()
				or UnitInVehicle("player")
				or UnitIsDeadOrGhost("player")
				or UnitChannelInfo("player")
				or UnitCastingInfo("player")
				or ni.player.islooting() then
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
			if cache.control then
				ni.player.runtext("/petfollow")
			elseif cache.pet == true then
				ni.player.runtext("/petattack")
				cache.pet = false
			end
		end
	end,
	-----------------------------------
	["kick"] = function()
		if enables["kick_3"] then
			if enables["kick"] then
				if enables["kick_2"] then
					local enemies = ni.unit.enemiesinrange("player", 25)
					for i = 1, #enemies do
						local target = enemies[i].guid
						if ni.unit.iscasting(target)
								or ni.unit.ischanneling(target) then
							local spell, rank, displayName, icon, startTime, endTime, isTradeSkill, castID, interrupt =
									UnitCastingInfo(target)
							if inputs.kiick == ""
									or inputs.kiick == spell then
								if ni.spell.available(spells.kick)
										and interrupt == false
										and ni.spell.valid(target, spells.kick, false, true, true) then
									ni.spell.cast(spells.kick, target)
								end
							end
						end
					end
				elseif ni.unit.iscasting("target")
						or ni.unit.ischanneling("target") then
					local spell, rank, displayName, icon, startTime, endTime, isTradeSkill, castID, interrupt = UnitCastingInfo(
						"target")
					if ni.spell.available(spells.kick)
							and interrupt == false
							and ni.spell.valid("target", spells.kick, false, true, true) then
						ni.spell.cast(spells.kick)
					end
				end
			end
		else
			if enables["kick"] then
				if enables["kick_2"] then
					local enemies = ni.unit.enemiesinrange("player", 25)
					for i = 1, #enemies do
						local target = enemies[i].guid
						if ni.unit.iscasting(target)
								or ni.unit.ischanneling(target) then
							local spell, rank, displayName, icon, startTime, endTime, isTradeSkill, castID, interrupt =
									UnitCastingInfo(target)
							if ni.spell.available(spells.kick)
									and interrupt == false
									and ni.spell.valid(target, spells.kick, false, true, true) then
								ni.spell.cast(spells.kick, target)
							end
						end
					end
				elseif ni.unit.iscasting("target")
						or ni.unit.ischanneling("target") then
					local spell, rank, displayName, icon, startTime, endTime, isTradeSkill, castID, interrupt = UnitCastingInfo(
						"target")
					if ni.spell.available(spells.kick)
							and interrupt == false
							and ni.spell.valid("target", spells.kick, false, true, true) then
						ni.spell.cast(spells.kick)
					end
				end
			end
		end
	end,
	--------------------------
	["cd"] = function()
		if cache.PlayerCombat then
			count = GetItemCount("Health Stone")
			if ni.spell.available(316466)
					and not ni.unit.buff("player", 316466) then
				if count > 1
						or ni.unit.hp("target") < 10 then
					ni.spell.cast(316466)
				end
			end
			if ni.spell.available(316419)
					and ni.power.currentraw("player") < 40 then
				ni.spell.cast(316419)
			end
			if ni.spell.available(316422) then
				ni.spell.cast(316422)
			end
			if ni.spell.available(316445) then
				ni.spell.cast(316445)
			end
			if ni.spell.available(316295) then
				ni.spell.cast(316295)
			end
			if ni.unit.buff("player", 316440)
					and cache.PlayerCombat
					and ni.player.hasitem(50085) then
				ni.player.useitem(50085)
			end
			if ni.player.slotcastable(10)
					and ni.player.slotcd(10) == 0 then
				ni.player.useinventoryitem(10)
			end
			if ni.player.slotcastable(13)
					and ni.player.slotcd(13) == 0 then
				ni.player.useinventoryitem(13)
			end
			if ni.player.slotcastable(14)
					and ni.player.slotcd(14) == 0 then
				ni.player.useinventoryitem(14)
			end
			if ni.spell.available(319326) then
				ni.spell.cast(319326)
			end
			if ni.spell.available(316396)
					and ni.spell.valid("target", 316396, false, true, true) then
				ni.spell.cast(316396)
			end
		end
	end,
	--------------------------
	["unholypresence"] = function()
		if enables["stoika"]
				and not cache.PlayerCombat
				and not ni.player.buff(48265) then
			if ni.spell.available(spells.unholypresence) then
				ni.spell.cast(spells.unholypresence)
				cache.pet = true
			end
		end
	end,
	--------------------------
	["save"] = function()
		if cache.PlayerCombat then
			if enables["nii"]
					and ni.unit.hp("player") <= values.nii then
				if ni.unit.ttd("player") < 3
						and ni.spell.available(spells.ni) then
					ni.spell.cast(spells.ni)
				end
			end
			if enables["deathpact"]
					and ni.unit.hp("player") <= values.deathpact then
				local creator = ni.unit.creator("playerpet")
				if ni.unit.ttd("player") < 2
						and creator ~= nil
						and ni.spell.available(spells.deathpact) then
					ni.spell.cast(spells.deathpact)
				end
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
						if ni.unit.hp("player") <= values.kamen then
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
	--------------------------
	["antimagic"] = function()
		if cache.PlayerCombat
				and enables["ik"]
				and ni.player.debuff("Пламя Легиона") then
			if ni.spell.available(spells.antimagic) then
				ni.spell.cast(spells.antimagic)
			end
		end
		if cache.PlayerCombat
				and enables["lana"]
				and ni.player.debuff("Роящиеся тени") then
			if ni.spell.available(spells.antimagic) then
				ni.spell.cast(spells.antimagic)
			end
		end
	end,
	--------------------------
	["pestilence"] = function()
		if enables["pestilence"]
				and not cache.control
				and cache.PlayerCombat
				and cache.dots == true
				and cache.dots_obnov then
			local offcd, oncd = ni.rune.bloodrunecd()
			if offcd == 2
					and ni.spell.available(spells.bloodtap) then
				ni.spell.cast(spells.bloodtap)
				cache.pet = true
			end
			if ni.spell.available(spells.pestilence)
					and ni.spell.valid("target", spells.pestilence, false, true, true) then
				ni.spell.cast(spells.pestilence, "target")
				cache.pet = true
			end
		end
	end,
	--------------------------
	["pestilence_aoe"] = function()
		if enables["pestilence_aoe"]
				and not cache.control
				and cache.PlayerCombat
				and cache.dots == true then
			local enemies = ni.unit.enemiesinrange("player", 10)
			for i = 1, #enemies do
				local target = enemies[i].guid
				if ni.unit.hpraw(target) > 100000
						and not ni.unit.debuff(target, 55078, "player")
						or not ni.unit.debuff(target, 55095, "player") then
					if ni.spell.available(spells.pestilence)
							and ni.spell.valid("target", spells.pestilence, false, true, true) then
						ni.spell.cast(spells.pestilence, "target")
						cache.pet = true
					end
				end
			end
		end
	end,
	-----------------------------------
	["buff"] = function()
		if enables["horn"]
				and not ni.player.buff(spells.horn)
				and ni.spell.available(spells.horn) then
			ni.spell.cast(spells.horn)
		end
		if enables["shield"]
				and not ni.player.buff(spells.shield)
				and ni.spell.available(spells.shield) then
			ni.spell.cast(spells.shield)
		end
		if enables["pet"] then
			local creator = ni.unit.creator("playerpet")
			if creator == nil
					and ni.spell.available(spells.pet) then
				ni.spell.cast(spells.pet)
			end
		end
	end,
	--------------------------
	["icytouch"] = function()
		if cache.PlayerCombat
				and not cache.control
				and not ni.unit.debuff("target", 55095, "player")
				and ni.spell.valid("target", spells.icytouch, false, true, true)
				and ni.spell.available(spells.icytouch) then
			ni.spell.cast(spells.icytouch, "target")
			cache.pet = true
		end
	end,
	--------------------------
	["plaguestrike"] = function()
		if not cache.control
				and cache.PlayerCombat
				and not ni.unit.debuff("target", 55078, "player")
				and ni.spell.valid("target", spells.plaguestrike, false, true, true)
				and ni.spell.available(spells.plaguestrike) then
			ni.spell.cast(spells.plaguestrike, "target")
			cache.pet = true
		end
	end,
	--------------------------
	["bloodstrike"] = function()
		if cache.PlayerCombat
				and not cache.control
				and cache.dots == true
				and ni.unit.buffremaining("player", 66803) < 1
				and ni.spell.valid("target", spells.bloodstrike, false, true, true)
				and ni.spell.available(spells.bloodstrike) then
			ni.spell.cast(spells.bloodstrike, "target")
			cache.pet = true
		end
	end,
	--------------------------
	["plet"] = function()
		if cache.PlayerCombat
				and not cache.control
				and cache.dots == true
				and ni.unit.buffremaining("player", 304806) < 1
				and ni.spell.valid("target", spells.plet, false, true, true)
				and ni.spell.available(spells.plet) then
			ni.spell.cast(spells.plet, "target")
			cache.pet = true
		end
	end,
	--------------------------
	["char_rass"] = function()
		if cache.PlayerCombat
				and not cache.control
				and cache.dots == true
				and ni.spell.available(spells.char_rass) then
			ni.spell.cast(spells.char_rass, "player")
			cache.pet = true
		end
	end,
	--------------------------
	["deathcoil_buf"] = function()
		if cache.PlayerCombat
				and not cache.control
				and cache.dots == true
				and not ni.player.buff(304809)
				and ni.spell.valid("target", spells.deathcoil, false, true, true)
				and ni.spell.available(spells.deathcoil) then
			ni.spell.cast(spells.deathcoil, "target")
			cache.pet = true
		end
	end,
	--------------------------
	["garga"] = function()
		if cache.PlayerCombat
				and not cache.control
				and cache.dots == true then
			if ni.unit.isboss("target")
					or ni.vars.combat.cd then
				if ni.spell.valid("target", spells.garga, false, true, true)
						and ni.spell.available(spells.garga) then
					ni.spell.cast(spells.garga, "target")
					cache.pet = true
				end
			end
		end
	end,
	--------------------------
	["empowerrune"] = function()
		if cache.PlayerCombat
				and not cache.control
				and cache.dots == true
				and ni.power.current("player") < 80 then
			if ni.unit.isboss("target")
					or ni.vars.combat.cd then
				if ni.spell.available(spells.empowerrune) then
					ni.spell.cast(spells.empowerrune)
					cache.pet = true
				end
			end
		end
	end,
	--------------------------
	["bloodpresence"] = function()
		if enables["stances"]
				and cache.PlayerCombat
				and cache.dots == true
				and not ni.player.buff(48266) then
			local offcd, oncd = ni.rune.bloodrunecd()
			if offcd == 2
					and ni.spell.available(spells.bloodtap) then
				ni.spell.cast(spells.bloodtap)
				cache.pet = true
			end
			if ni.spell.available(spells.bloodpresence) then
				ni.spell.cast(spells.bloodpresence)
				cache.pet = true
			end
		end
	end,
	--------------------------
	["deathcoil"] = function()
		if cache.PlayerCombat
				and not cache.control
				and ni.spell.valid("target", spells.deathcoil, false, true, true)
				and ni.spell.available(spells.deathcoil) then
			ni.spell.cast(spells.deathcoil, "target")
			cache.pet = true
		end
	end,
	--------------------------
};
ni.bootstrap.profile("Dalvae Unholy Wotlk", queue, abilities, OnLoad, OnUnLoad);
