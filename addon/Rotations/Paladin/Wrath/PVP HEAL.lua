local lastaction = 0;
local spell = {
	Seal = GetSpellInfo(20166),
	Oath = GetSpellInfo(54428),
	DivineEnlightenment = GetSpellInfo(31842),
	DivineApproval = GetSpellInfo(20216),
	LightOfHeaven = GetSpellInfo(48782),
	HolyShock = GetSpellInfo(48825),
	FlashLight = GetSpellInfo(48785),
	HandOfSacrifice = GetSpellInfo(6940),
	LayingOnOfHands = GetSpellInfo(48788),
	HammerOfJustice = GetSpellInfo(10308),
	ParticleOfLight = GetSpellInfo(53563),
	HolyShield = GetSpellInfo(53601),
	Cleansing = GetSpellInfo(4987),
	PunishersWrath = GetSpellInfo(31884),
	TheWrathOfHeaven = GetSpellInfo(48817),
	LightPower = GetSpellInfo(54149),
	Weakness = GetSpellInfo(25771),
	NaksDebuff = GetSpellInfo(55593),
	HandOfSalvation = GetSpellInfo(1038),
	Judjement = GetSpellInfo(20271),
	HandOfProtection = GetSpellInfo(10278),
	GodsShield = GetSpellInfo(642),
	Freedom = GetSpellInfo(1044),
	DivineProtection = GetSpellInfo(498),
	DivineSacrifice = GetSpellInfo(64205),
	FlaskoftheNorth = GetSpellInfo(67016),
	JudgementofJustice = GetSpellInfo(53407),
};
local items = {
	settingsfile = "Paladin_Holy_pvp.json",
	{ type = "title", text = "Holy Paladin PVP" },
	{ type = "separator" },
	{ type = "entry", text = "Debug Printing", tooltip = "Enable for debug if you have problems.", enabled = false, key = "Debug" },
};
local dontdispel = {30128, 28169, 38806, 70964, 31803, 60814, 69674, 68786, 34916, 34917, 34919, 48159, 48160, 30404, 30405, 31117, 34438, 35183, 43522, 47841, 47843, 65812, 68154, 68155, 68156, 44461, 55359, 55360, 55361, 55362, 61429, 30108, 34914, 74562, 74792, 70867, 70338, 70405 };
for k, v in pairs(dontdispel) do
	ni.healing.debufftoblacklist(v);
end
local pvpdispell = {3409, 10890, 14309, 10308, 45524, 45524, 53313, 64695, 4167, 64804, 42917}
local freedomdebuff = { 45524, 1715, 3408, 59638, 20164, 25809, 31589, 51585, 50040, 50041, 31124, 122, 44614, 339, 45334, 58179, 61391, 19306, 19185, 35101, 5116, 2974, 61394, 54644, 50245, 50271, 54706, 4167, 33395, 55080, 6136, 120, 116, 31589, 20170, 31125, 3409, 26679, 64695, 63685, 8056, 8034, 18118, 18223, 63311, 23694, 1715, 12323, 39965, 55536, 13099, 32859, 32065, 22800, 3604, 33967, 12023, 47698, 38316, 15063, 49717 };
local LastDispel = 0;
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

local function OnLoad()
	ni.GUI.AddFrame("Holy_pvp", items);
end
local function OnUnLoad()
	ni.GUI.DestroyFrame("Holy_pvp");
end
local HolyShockHealing = (2800 + 0.8057*GetSpellBonusHealing())*1.3955
local HolyLightHealing = (5786 + 1.66*GetSpellBonusHealing())*1.4182
local FlashofLightHealing = (932 + 1*GetSpellBonusHealing())*1.2923
local queue = {
	"Trink",
	"Flask",
	"GodsShield",
	"Pause",
	"Healthstone",
	--"Potions",
	"HolyShock",
	"Race",
	"Oath",
	"HandOfProtection",
	"HolyShield",
	"Freedom",
	"DivineEnlightenment",
 	"LayingOnOfHands",
	"DivineApproval",
	"DivineSacrifice",
	"Cleanse",
	--"Cleansing_F",
	"LightOfHeaven",
	"FlashLight",
	"Judgement",
	"Check",
	"Seal",
	"ParticleOfLight",
	"Cleansing",
	"HammerOfJustice",
	"TheWrathOfHeaven",
	"HammerOfWrath",
}
local abilities = {
    ["Pause"] = function()
        if IsMounted()
        or ni.player.buff(430)
        or ni.player.buff(433)
        or ni.player.issilenced()
        or ni.player.isstunned()
        or ni.player.iscasting()
        or ni.player.ischanneling()
        or UnitIsDeadOrGhost("player")
		or IsLeftShiftKeyDown()
        or ni.player.buff(316254) then
            return true;
        end
		ni.vars.debug = select(2, GetSetting("Debug"));
    end,
	["Healthstone"] = function()
		local hstones = { 36892, 36893, 36894 }
		for i = 1, #hstones do
			if UnitAffectingCombat("player")
			and ni.player.hp() < 50
			and ni.player.hasitem(hstones[i])
			and ni.player.itemcd(hstones[i]) == 0 then
				ni.player.useitem(hstones[i])
			end
		end
	end,
	["Potions"] = function()
		if UnitAffectingCombat("player")
		and ni.player.hp() < 50
		and ni.player.hasitem(33447)
		and ni.player.itemcd(33447) == 0 then
			ni.player.useitem(33447)
		end
		if ni.player.power() < 50
		and ni.player.hasitem(43570)
		and ni.player.itemcd(43570) == 0 then
			ni.player.useitem(43570)
		end
	end,
    ["Seal"] = function()
        if not ni.player.buff(spell.Seal)
        and ni.spell.available(spell.Seal) then
        ni.spell.cast(spell.Seal)
        end
        if not ni.player.buff(25780)
        and ni.spell.available(25780) then
        ni.spell.cast(25780)
        end
        if not ni.player.buff(25898)
        and ni.spell.available(25898) then
        ni.spell.cast(25898)
        end
    end,
    ["Flask"] = function()
        if not ni.player.buff(67016)
		and ni.player.hasitem(47499)
		and ni.player.itemcd(47499) == 0 then
			ni.player.useitem(47499)
        end
    end,
    ["Oath"] = function()
        if not ni.player.buff(spell.Oath)
        and ni.player.power() <= 33
        and ni.spell.available(spell.Oath) then
        ni.spell.cast(spell.Oath)
        end
    end,
    ["DivineEnlightenment"] = function ()
        if ni.player.buff(spell.Oath)
        and ni.spell.cd(spell.DivineEnlightenment) == 0 then
        ni.spell.cast(spell.DivineEnlightenment)
        end
    end,
    ["DivineApproval"] = function ()
		for i = 1, #ni.members do
            if UnitAffectingCombat("player")
            and ni.unit.hpraw(ni.members[i].unit) >= HolyLightHealing
            and ni.spell.cd(20216) == 0
            and ni.spell.valid(ni.members[i].unit, spell.LightOfHeaven, false, true, true) then
			ni.spell.stopcasting()
            ni.spell.cast(spell.DivineApproval) ni.spell.cast(spell.LightOfHeaven, ni.members[i].unit)
            end
        end
    end,
    ["LightOfHeaven"] = function()
		Enemies = ni.unit.enemiesinrange("player", 10);
		if ni.spell.available(spell.LightOfHeaven)
		and not ni.unit.ismoving("player")
		and #Enemies == 0 then
			for i = 1, #ni.members do
				if ni.unit.hpraw(ni.members[i].unit) >= HolyLightHealing*0.7
				and ni.spell.valid(ni.members[i].unit, spell.LightOfHeaven, false, true, true) then
					ni.spell.cast(spell.LightOfHeaven, ni.members[i].unit)
				end
			end
        end
    end,
    ["HolyShock"] = function()
		if ni.spell.available(spell.HolyShock) then
			for i = 1, #ni.members do
				if ni.unit.hpraw(ni.members[i].unit) >= HolyShockHealing*1.4
				and ni.spell.valid(ni.members[i].unit, spell.HolyShock, false, true, true) then
					ni.spell.cast(spell.HolyShock, ni.members[i].unit)
				end
			end
		end
	end,
    ["FlashLight"] = function()
		if ni.spell.available(spell.FlashLight)
		and (not ni.unit.ismoving("player") or ni.player.buff(spell.LightPower)) then
			for i = 1, #ni.members do
				if ni.unit.hpraw(ni.members[i].unit) >= FlashofLightHealing*0.9
				and ni.spell.valid(ni.members[i].unit, spell.FlashLight, false, true, true) then
					ni.spell.cast(spell.FlashLight, ni.members[i].unit)
				end
			end
        end
    end,
    ["GodsShield"] = function()
		if UnitAffectingCombat("player")
		and not ni.unit.debuff("player", spell.Weakness) then
			if ni.player.hp() <= 40
			and ni.spell.cd(spell.GodsShield) == 0 then
				ni.spell.cast(spell.GodsShield)
			end
			if ni.spell.cd(spell.GodsShield) ~= 0 then
				if ni.player.hp() <= 40
				and ni.spell.cd(spell.DivineProtection) == 0 then
					ni.spell.cast(spell.DivineProtection)
				end
			end
		end
    end,
    ["LayingOnOfHands"] = function()
		for i = 1, #ni.members do
			if UnitAffectingCombat("player")
			and not ni.unit.debuff(ni.members[i].unit, spell.Weakness)
			and not UnitIsUnit("player", ni.members[i].unit)
			and ni.members[i].hp <= 22
			and ni.spell.available(spell.LayingOnOfHands)
			and ni.spell.valid(ni.members[i].unit, spell.LayingOnOfHands, false, true, true) then
				ni.spell.cast(spell.LayingOnOfHands, ni.members[i].unit)
            end
        end
    end,
    ["HandOfProtection"] = function()
		for i = 1, #ni.members do
			local _, _, mateclass = UnitClass(ni.members[i].unit);
            if (mateclass ~= 1 and mateclass ~= 2 and mateclass ~= 3 and mateclass ~= 4 and mateclass ~= 6) then
				if UnitAffectingCombat("player")
				and not ni.unit.debuff(ni.members[i].unit, spell.Weakness)
				and ni.members[i].hp <= 22
				and ni.spell.available(spell.HandOfProtection)
				and ni.spell.valid(ni.members[i].unit, spell.HandOfProtection, false, true, true) then
					ni.spell.cast(spell.HandOfProtection, ni.members[i].unit)
				end
            end
        end
    end,
    ["HammerOfJustice"] = function()
		Enemies = ni.unit.enemiesinrange("player", 8);
		for	i = 1, #Enemies do
			local tar = Enemies[i].guid;
			local intercast = select(9, UnitCastingInfo(tar))
			if ni.spell.available(spell.HammerOfJustice)
			and ((ni.unit.iscasting(tar) and intercast) or ni.unit.hp(tar) <= 20)
			and ni.spell.valid(tar, spell.HammerOfJustice, true, true) then
				ni.spell.cast(spell.HammerOfJustice, tar)
			end
		end
    end,
	["HammerOfWrath"] = function()
	  if UnitAffectingCombat("player")
	  and ni.spell.available(48806) then
	  	Enemies = ni.unit.enemiesinrange("player", 30);
		for	i = 1, #Enemies do
		local tar = Enemies[i].guid;
			if ni.unit.hp(tar) <= 8
			and ni.spell.valid(tar, 48806, true, true) then
				ni.spell.cast(48806, tar)
			end
		end
	  end
	end;
    ["ParticleOfLight"] = function()
		if not UnitAffectingCombat("player") then
			if (not ni.player.buff(spell.ParticleOfLight) or ni.player.buffremaining(spell.ParticleOfLight) <= 134)
			and ni.spell.available(spell.ParticleOfLight) then
				ni.spell.cast(spell.ParticleOfLight, "player")
			end
		end
		if UnitAffectingCombat("player") then
			if (not ni.player.buff(spell.ParticleOfLight) or ni.player.buffremaining(spell.ParticleOfLight) <= 32)
			and ni.spell.available(spell.ParticleOfLight) then
				ni.spell.cast(spell.ParticleOfLight, "player")
			end
		end
    end,
    ["DivineSacrifice"] = function()
        if #ni.members.inrangebelow("player", 30, 90) >= 3
		and ni.spell.available(spell.DivineSacrifice) then
			ni.spell.cast(spell.DivineSacrifice, "player")
        end
    end,
    ["Race"] = function()
        if UnitAffectingCombat("player")
		and ni.spell.cd(55503) == 0
		and ni.player.hp() < 50 then
			ni.spell.cast(55503)
        end
    end,
    ["HolyShield"] = function()
        if ni.player.hp() < 85
		and not ni.player.buff(spell.HolyShield)
		and ni.spell.available(spell.HolyShield) then
			ni.spell.cast(spell.HolyShield, "player")
        end
    end,
    ["Cleanse"] = function()
        if ni.spell.available(spell.Cleansing) then
			for _, x in ipairs(pvpdispell) do
				for _, member in ipairs(ni.members) do
					if not UnitIsUnit("player", member.unit) then
						if ni.unit.debuff(member.unit, x)
						and ni.healing.candispel(member.unit)
						and (ni.unit.hp(member.unit) > 75
						or GetTime() - lastaction > 2.5)
						and ni.spell.valid(member.unit, spell.Cleansing, false, true, true) then
							ni.spell.cast(spell.Cleansing, member.unit)
							lastaction = GetTime()
						end
					end
				end
			end
        end
	end,
	["Cleansing"] = function()
		if ni.spell.available(spell.Cleansing)
		and ni.healing.candispel("player")
		and ni.player.ismoving() then
			ni.spell.cast(spell.Cleansing, "player")
		end
	end;
	["Cleansing_F"] = function()
		if ni.unit.exists("focus") then
			if ni.spell.available(spell.Cleansing)
			and ni.healing.candispel("focus")
			and (GetTime() - lastaction > 2.3
			or ni.player.ismoving())
			and ni.spell.valid("focus", spell.Cleansing, false, true, true) then
				ni.spell.cast(spell.Cleansing, "focus")
				lastaction = GetTime();
			end
		end
	end;
    ["Freedom"] = function()
		if ni.spell.available(spell.Freedom) then
			for _, x in ipairs(freedomdebuff) do
				if ni.player.debuff(x) then
					ni.spell.cast(spell.Freedom, "player")
				end
        	end
      	end
    end;
    ["Judgement"] = function()
        if ni.spell.available(spell.JudgementofJustice)
        and ni.spell.valid("target", spell.JudgementofJustice, true, true) then
        	ni.spell.cast(spell.JudgementofJustice, "target")
        end
    end,
	["TheWrathOfHeaven"] = function()
		if UnitAffectingCombat("player")
		and ni.spell.available(spell.TheWrathOfHeaven)
        and (ni.unit.creaturetype("target") == 6 or ni.unit.creaturetype("target") == 3)
        and ni.player.inmelee("target") then
            ni.spell.cast(spell.TheWrathOfHeaven)
		end
	end,
	["Trink"] = function()
		if ni.player.hasitem(100160)
		and ni.player.itemcd(100160) == 0
    	and (ni.player.isconfused() or ni.player.isfleeing()) then
			ni.player.useitem(100160)
		end
	end,
	["Check"] = function()
        if not ni.player.aura(spell.FlaskoftheNorth)
		and ni.player.hasitem(47499)
		and ni.player.itemcd(47499) == 0 then
            ni.player.useitem(47499)
        end
	end,
};
ni.bootstrap.profile("PVP HEAL", queue, abilities, OnLoad, OnUnLoad);