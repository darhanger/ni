local queue = {
	"Buffs",
	"Pause",
	"Selfless Healer",
	"Seal",
	"Auto Attack",
	"Inquisition",
	"Avenging Wrath",
	"Guardian of Ancient Kings",
	"Holy Avenger",
	"Items",
	"Execution Sentence",
	"Lights Hammer",
	"Divine Storm",
	"Templars Verdict",
	"Hammer of Wrath",
	"Divine Storm (2)",
	"Templars Verdict (2)",
	"Hammer of the Righteous",
	"Crusader Strike",
	"Exorcism",
	"Judgement",
	"Divine Storm (3)",
	"Templars Verdict (3)",
	"Exorcism (2)",
	"Templars Verdict (4)",
	"Divine Storm (4)",
	"Templars Verdict (5)",
	"Holy Prism",
}
local items = {
	settingsfile = "Nrdr_PreRaidRet_MoP.xml",
	{ type = "title", text = "PreRaid/Leveling Ret" },
	{ type = "separator" },
	{ type = "title", text = "Main Settings" },
	{ type = "entry", text = "Auto AoE", enabled = true, key = "AoE" },
	{ type = "entry", text = "Selfless Healer", enabled = true, value = 75, key = "Selfless" },
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
        if v.type == "input"
         and v.key ~= nil
         and v.key == name then
            return v.value
        end
    end
end;
local spells = {
	sealoftruth = { id = 31801, name = GetSpellInfo(31801) },
	sealofrighteousness = { id = 20154, name = GetSpellInfo(20154) },
	inquisition = { id = 84963, name = GetSpellInfo(84963) },
	avengingwrath = { id = 31884, name = GetSpellInfo(31884) },
	goak = { id = 86698, name = GetSpellInfo(86698) },
	divinestorm = { id = 53385, name = GetSpellInfo(53385) },
	templarsverdict = { id = 85256, name = GetSpellInfo(85256) },
	hammerofwrath = { id = 24275, name = GetSpellInfo(24275) },
	hammeroftherighteous = { id = 53595, name = GetSpellInfo(53595) },
	crusaderstrike = { id = 35395, name = GetSpellInfo(35395) },
	exorcism = { id = 879, name = GetSpellInfo(879) },
	judgement = { id = 20271, name = GetSpellInfo(20271) },
	flashoflight = { id = 19750, name = GetSpellInfo(19750) },
	blessingofkings = { id = 20217, name = GetSpellInfo(20217) },
}
local incombat = false;
local function CombatEventCatcher(event, ...)
	if event == "PLAYER_REGEN_DISABLED" then
		incombat = true;
	elseif event == "PLAYER_REGEN_ENABLED" then
		incombat = false;
	end
end
local function OnLoad()
	ni.combatlog.registerhandler("PreRaid Ret", CombatEventCatcher);
	ni.GUI.AddFrame("PreRaid Ret", items);
end
local function OnUnload()
	ni.combatlog.unregisterhandler("PreRaid Ret");
	ni.GUI.DestroyFrame("PreRaid Ret");
end
local maxholy = UnitPowerMax("player", 9);
local enemies = { };
local function ActiveEnemies()
	table.wipe(enemies);
	enemies = ni.player.enemiesinrange(8);
	for k, v in ipairs(enemies) do
		if ni.player.threat(v.guid) == -1 then
			table.remove(enemies, k);
		end
	end
	return #enemies;
end
local function HaveAbility(spell)
	if IsSpellKnown(spell) or IsPlayerSpell(spell) then
		return true;
	end
	return false;
end
local function T15()
	return 0;
end
local function FacingLosCast(spell, tar)
	if ni.player.isfacing(tar, 145)
	 and ni.player.los(tar)
	 and IsSpellInRange(spell, tar) == 1 then
		ni.spell.cast(spell, tar);
		return true;
	end
	return false;
end
local abilities = {
	["Buffs"] = function()
		if incombat
		 and HaveAbility(spells.blessingofkings.id)
		 and not ni.player.buff(spells.blessingofkings.name) then
			ni.spell.cast(spells.blessingofkings.name, "player");
			return true;
		end
	end,
	["Pause"] = function()
		if IsMounted()
		 or UnitIsDeadOrGhost("player")
		 or not UnitExists("target")
		 or UnitIsDeadOrGhost("target")
		 or not UnitAffectingCombat("player")
		 or (UnitExists("target")
		 and not UnitCanAttack("player", "target")) then
			return true;
		end
	end,
	["Seal"] = function()
		local value, enabled = GetSetting("AoE");
		if (ni.vars.combat.aoe
		 or (enabled and ActiveEnemies() >= 4))
		 and HaveAbility(spells.sealofrighteousness.id) then
			if not ni.player.aura(spells.sealofrighteousness.id) then
				ni.spell.cast(spells.sealofrighteousness.name);
				return true;
			end
		else
			if HaveAbility(spells.sealoftruth.id)
			 and not ni.player.aura(spells.sealoftruth.id) then
				ni.spell.cast(spells.sealoftruth.name);
				return true;
			end
		end
	end,
	["Selfless Healer"] = function()
		local value, enabled = GetSetting("Selfless");
		if enabled
		 and select(2, GetTalentRowSelectionInfo(3)) == 7
		 and nxr.player.buffstacks(114250) == 3
		 and ni.members[1].hp <= value
		 and ni.player.los(ni.members[1].unit)
		 and IsSpellInRange(spells.flashoflight.name, ni.members[1].unit) == 1 then
			ni.spell.cast(spells.flashoflight.name, ni.members[1].unit);
			return true;
		end
	end,
	["Auto Attack"] = function()
		if not IsCurrentSpell(6603) then
			ni.spell.cast(6603);
		end
	end,
	["Inquisition"] = function()
		if HaveAbility(spells.inquisition.id) then
			if ni.player.buffremaining(spells.inquisition.name) <= 2 then
				local ttd = ni.unit.ttd("target");
				local holy = ni.player.powerraw("holy");
				if (holy >= 3
				 or (ttd > -1 and ttd < holy * 20)
				 or ni.player.buff("Divine Purpose"))
				 and FacingLosCast(spells.inquisition.name, "target") then
					return true;
				end
			end
		end
	end,
	["Avenging Wrath"] = function()
		if ni.vars.combat.cd and HaveAbility(spells.avengingwrath.id) then
			if ni.player.buff(spells.inquisition.name)
			 and ni.spell.cd(spells.avengingwrath.name) == 0 then
				ni.spell.cast(spells.avengingwrath.name);
				return true;
			end
		end
	end,
	["Guardian of Ancient Kings"] = function()
		if ni.vars.combat.cd and HaveAbility(spells.goak.id) then
			if ni.spell.cd(spells.goak.name) == 0
			 and ni.player.buff(spells.inquisition.name) then
				ni.spell.cast(spells.goak.name);
				return true;
			end
		end
	end,
	["Holy Avenger"] = function()

	end,
	["Items"] = function()

	end,
	["Execution Sentence"] = function()

	end,
	["Lights Hammer"] = function()

	end,
	["Divine Storm"] = function()
		if HaveAbility(spells.divinestorm.id) then
			local holy = ni.player.powerraw("holy");
			if ActiveEnemies() >= 2 then
				if holy == maxholy
				 or ni.player.buff("Divine Purpose")
				 or (ni.player.buff("Holy Avenger")
				 and holy >= 3) then
					ni.spell.cast(spells.divinestorm.name);
					return true;
				end
			end
			if ni.player.buff("Divine Crusader")
			 and holy == maxholy
			 and ni.player.inmelee("target") then
				ni.spell.cast(spells.divinestorm.name);
				return true;
			end
		end
	end,
	["Templars Verdict"] = function()
		if HaveAbility(spells.templarsverdict.id) then
			local holy = ni.player.powerraw("holy");
			if ni.player.isfacing("target", 145)
			 and ni.player.los("target")
			 and IsSpellInRange(spells.templarsverdict.name, "target") == 1 then
				if (holy == maxholy
				 or (ni.player.buff("Holy Avenger")
				 and holy >= 3)) then
					ni.spell.cast(spells.templarsverdict.name);
					return true;
				end
				local dp = ni.player.buffremaining("Divine Purpose");
				if dp > 0 and dp < 4 then
					ni.spell.cast(spells.templarsverdict.name);
					return true;
				end
			end
		end
	end,
	["Hammer of Wrath"] = function()
		if HaveAbility(spells.hammerofwrath.id) then
			if ni.player.isfacing("target")
			 and ni.player.los("target")
			 and IsSpellInRange(spells.hammerofwrath.name, "target") == 1 then
				local cd = ni.spell.cd(spells.hammerofwrath.id);
				if cd == 0
				 and IsUsableSpell(spells.hammerofwrath.name) then
					ni.spell.cast(spells.hammerofwrath.name);
					return true;
				end
				if cd > 0 and cd <= 0.2 then
					return true;
				end
			end
		end
	end,
	["Divine Storm (2)"] = function()
		if HaveAbility(spells.divinestorm.id) then
			if ni.player.buff("Divine Crusader")
			 and ni.player.buff("Avenging Wrath")
			 and ni.player.inmelee("target") then
				ni.spell.cast(spells.divinestorm.name);
				return true;
			end
		end
	end,
	["Templars Verdict (2)"] = function()
		if HaveAbility(spells.templarsverdict.id) then
			if ni.player.buff("Avenging Wrath")
			and FacingLosCast(spells.templarsverdict.name, "target") then
				return true;
			end
		end
	end,
	["Hammer of the Righteous"] = function()
		if HaveAbility(spells.hammeroftherighteous.id)
		 and ni.spell.cd(spells.hammeroftherighteous.id) == 0
		 and ActiveEnemies() >= 4
		 and FacingLosCast(spells.hammeroftherighteous.name, "target") then
			return true;
		end
	end,
	["Crusader Strike"] = function()
		local cs = ni.spell.cd(spells.crusaderstrike.id);
		if cs == 0
		 and ni.spell.valid("target", spells.crusaderstrike.name, true, true) then
			ni.spell.cast(spells.crusaderstrike.name, "target");
			return true;
		end
		if cs > 0 and cs <= 0.2 then
			return true;
		end
	end,
	["Exorcism"] = function()
		if HaveAbility(spells.exorcism.id) then
			local ae = ActiveEnemies();
			if ae >= 2 and ae <= 4
			 and T15() >= 2
			 and false --ni.player.hasglyph(???) --Mass execution
			 and FacingLosCast(spells.exorcism.name, "target") then
				return true;
			end
		end
	end,
	["Judgement"] = function()
		if HaveAbility(spells.judgement.id) then
			local cd = ni.spell.cd(spells.judgement.id);
			if cd == 0
			 and FacingLosCast(spells.judgement.name, "target") then
				return true;
			end
			if cd > 0 and cd <= 0.2 then
				return true;
			end
		end
	end,
	["Divine Storm (3)"] = function()
		if HaveAbility(spells.divinestorm.id) then
			if ni.player.buff("Divine Crusader")
			 and ni.player.inmelee("target") then
				ni.spell.cast(spells.divinestorm.name);
				return true;
			end
		end
	end,
	["Templars Verdict (3)"] = function()
		if HaveAbility(spells.templarsverdict.id) then
			if ni.player.buff("Divine Purpose")
			 and FacingLosCast(spells.templarsverdict.name, "target") then
				return true;
			end
		end
	end,
	["Exorcism (2)"] = function()
		if HaveAbility(spells.exorcism.id) then
			local cd = ni.spell.cd(spells.exorcism.name);
			if cd == 0
			 and FacingLosCast(spells.exorcism.name, "target") then
				return true;
			end
			if cd > 0 and cd <= 0.2 then
				return true;
			end
		end
	end,
	["Templars Verdict (4)"] = function()
		if HaveAbility(spells.templarsverdict.id) then
			if false --t15 4 piece
			 and ActiveEnemies() < 4 
			 and FacingLosCast(spells.templarsverdict.name, "target") then
				return true;
			end
		end
	end,
	["Divine Storm (4)"] = function()
		if HaveAbility(spells.divinestorm.id) then
			if ActiveEnemies() >= 2
			 and ni.player.buffremaining(spells.inquisition.name) > 4
			 and ni.player.inmelee("target") then
				ni.spell.cast(spells.divinestorm.name);
				return true;
			end
		end
	end,
	["Templars Verdict (5)"] = function()
		if HaveAbility(spells.templarsverdict.id) then
			if ni.player.buffremaining(spells.inquisition.name) > 4 
			 and FacingLosCast(spells.templarsverdict.name, "target") then
				return true;
			end
		end
	end,
	["Holy Prism"] = function()

	end
}
ni.bootstrap.profile("PreRaid Ret - MoP", queue, abilities, OnLoad, OnUnload);