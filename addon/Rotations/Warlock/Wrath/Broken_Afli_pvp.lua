cancel = "Interface\\Icons\\spell_arcane_portalthunderbluff";
debugprint = "Interface\\Icons\\inv_misc_note_06";
delaypic = "Interface\\Icons\\spell_mage_altertime";
protectionpic = "Interface\\Icons\\spell_nature_enchantarmor";
lootpic = "Interface\\Icons\\inv_misc_bag_felclothbag";
potionpic = "Interface\\Icons\\inv_potion_103";
hstonepic = "Interface\\Icons\\inv_stone_04";
hpotpic = "Interface\\Icons\\inv_potion_106";
local pics = {
    Seed = select(3, GetSpellInfo(47836)),
    Manareg = select(3, GetSpellInfo(57946))
};
local magic = {
    DemonicShield = GetSpellInfo(47889),
    FilthShield = GetSpellInfo(47893),
    DemonSkin = GetSpellInfo(696),
    Agonie = GetSpellInfo(47864),
    BadWord = GetSpellInfo(11719),
    Rock = GetSpellInfo(47867),
    Weak = GetSpellInfo(50511),
    Elements = GetSpellInfo(47865),
    WalkingSpirit = GetSpellInfo(59164),
    Unstable = GetSpellInfo(47843),
    Cursing = GetSpellInfo(47813),
    Seed = GetSpellInfo(47836),
    StealLife = GetSpellInfo(47857),
    StealSoul = GetSpellInfo(47855),
    ShadowBolt = GetSpellInfo(47809),
    Manareg = GetSpellInfo(57946),
    Hellflame = GetSpellInfo(61290),
    Scream = GetSpellInfo(17928),
    FearHeal = GetSpellInfo(47860),
    Ban = GetSpellInfo(18647),
    BoltBuff = GetSpellInfo(17941),
    Fear = GetSpellInfo(6215),
    DarkAbsorb = GetSpellInfo(47891),
    SoulCrush = GetSpellInfo(29858),
		Hunter = GetSpellInfo(691),
		Demon = GetSpellInfo(697),
		Sukkub = GetSpellInfo(712),

};
local items = {
	settingsfile = "Broken_AfliLock_pvp.json",
	{ type = "title", text = "Broken AfliLock PVP" },
    { type = "dropdown", menu = {
        { selected = true, value = magic.FilthShield, text = "Доспех Скверны" },
        { selected = false, value = magic.DemonicShield, text = "Демонический доспех" },
        { selected = false, value = magic.DemonSkin, text = "Шкура Демона" },
    }, key = "shld" },
    { type = "dropdown", menu = {
        { selected = true, value = magic.Hunter, text = "Охотник скверны" },
        { selected = false, value = magic.Demon, text = "Демон бездны" },
        { selected = false, value = magic.Sukkub, text = "Суккуб" },
    }, key = "pete" },
	{ type = "entry", text = "\124T"..pics.Manareg..":24:24\124t Жизнеотвод", enabled = false, key = "ldrn" },
	{ type = "entry", text = "\124T"..hstonepic..":24:24\124t Камень", value = 50, min = 5, max = 95, step = 3, width = 20, enabled = true, key = "hlthstone" },
	{ type = "entry", text = "\124T"..hpotpic..":24:24\124t ХП фласка", value = 50, min = 5, max = 95, step = 3, width = 20, enabled = false, key = "hppot" },
	{ type = "separator" },
	{ type = "entry", text = "\124T"..debugprint..":24:24\124t Лог действий", enabled = false, key = "Debug" },
	{ type = "entry", text = "\124T"..delaypic..":24:24\124t Задержка каста", value = 0, min = 0, max = 2, step = 0.15, width = 30, key = "ddly" }
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
local function OnLoad()
	ni.GUI.AddFrame("Broken_AfliLock_pvp", items);
end
local function OnUnLoad()
	ni.GUI.DestroyFrame("Broken_AfliLock_pvp");
end
local BadBuff = {45438, 642, 19263};
local RenewDebuff = 1.6;
local LastMove, LastFear = 0, 0;
local order = {
    "Pause",
    "Combat Pause",
    "SpellStone",
    "SummonPet",
    "Shield",
    "Manareg",
    "Potions",
    "Healthstone",
--		"DarkAbsorb",
		"Fear",
		"Fear2",
		"FearHeal",
    "Hellflame",
    "Curse",
    "WalkingSpirit",
    "Cursing",
    "UnstableMagic",
    "SoulDrain",
    "ShadowBolt",
		"REG",
};
local moves = {
    ["Pause"] = function()
        if IsMounted()
        or UnitInVehicle("player")
        or ni.player.buff(GetSpellInfo(430))
        or ni.player.buff(GetSpellInfo(433))
        or ni.player.isconfused()
        or ni.player.isstunned()
        or ni.player.iscasting()
        or ni.player.ischanneling()
        or UnitIsDeadOrGhost("player")
        or UnitIsDeadOrGhost("target")
        or IsLeftShiftKeyDown() then
            return true
        end
        ni.vars.debug = select(2, GetSetting("Debug"));
    end;
    ["Combat Pause"] = function()
      for _, v in ipairs(BadBuff) do
        if ni.unit.buff("target", v)
				or ni.unit.buffremaining("target", v) >= 1.5 then
          return true
        end
      end
    end;
    ["REG"] = function()
			local dlay = GetSetting("ddly");
        if GetTime() - LastMove >= dlay
				and ni.player.power() <= 50
        and ni.player.hp() > 50
        and ni.spell.available(57946)
        and ni.player.ismoving() then
            ni.spell.cast(57946)
						LastMove = GetTime()
        end
        if GetTime() - LastMove >= dlay
				and ni.player.power() <= 10
        and ni.player.hp() > 50
        and ni.spell.available(57946) then
            ni.spell.cast(57946)
						LastMove = GetTime()
        end
    end,
	["Healthstone"] = function()
    local value, itison = GetSetting("hlthstone");
		local hstones = { 36892, 36893, 36894 };
		for i = 1, #hstones do
			if itison then
        if UnitAffectingCombat("player")
        and ni.player.hp() < value
        and ni.player.hasitem(hstones[i])
        and ni.player.itemcd(hstones[i]) == 0 then
          ni.player.useitem(hstones[i])
        end
			end
		end
	end;
	["Potions"] = function()
    local value, itison = GetSetting("hppot");
		if itison then
      if UnitAffectingCombat("player")
      and ni.player.hp() < value
      and ni.player.hasitem(33447)
      and ni.player.itemcd(33447) == 0 then
        ni.player.useitem(33447)
      end
		end
	end;
	["FearHeal"] = function ()
	local dlay = GetSetting("ddly");
		if GetTime() - LastMove >= dlay
		and (ni.player.hp() < 85 or UnitIsUnit("targettarget", "player")) then
			if not ni.unit.debuff("target", 47860, "player")
			and ni.spell.available(47860)
			and ni.spell.valid("target", 47860, true, true) then
				ni.spell.cast(47860)
				LastMove = GetTime()
			end
		end
	end,
	["Fear"] = function ()
	local dlay = GetSetting("ddly");
		if GetTime() - LastMove >= dlay
		and ni.spell.available(6215) then
			if not (ni.unit.debuff("target", 6215, "player") or ni.unit.debuff("target", 47860, "player"))
			and ni.spell.valid("target", 6215, true, true)
			and ni.unit.debuff("target", 47813)
			and (ni.unit.debuff("target", 47865) or ni.unit.debuff("target", 11719) or ni.unit.debuff("target", 18223) or ni.unit.debuff("target", 47864))
			and not ni.player.ismoving()
			and GetTime() - LastFear > 6 then
				ni.spell.cast(6215)
				LastFear = GetTime()
				LastMove = GetTime()
			end
		end
	end,
    ["Curse"] = function()
			local dlay = GetSetting("ddly");
			local _, _, EnemyClass = UnitClass("target");
      if GetTime() - LastMove > dlay
      and ni.spell.available(18223)
			and (EnemyClass == 1 or EnemyClass == 4 or EnemyClass == 6) then
				if not ni.unit.debuff("target", 18223, "player")
				and ni.spell.valid("target", 18223, true, true) then
					ni.spell.cast(18223)
					LastMove = GetTime()
				end
      end
      if GetTime() - LastMove > dlay
      and ni.spell.available(11719)
			and (EnemyClass == 5 or EnemyClass == 8 or EnemyClass == 9) then
				if not ni.unit.debuff("target", 11719, "player")
				and ni.spell.valid("target", 11719, true, true) then
					ni.spell.cast(11719)
					LastMove = GetTime()
				end
      end
      if GetTime() - LastMove > dlay
      and ni.spell.available(47864)
			and (EnemyClass == 2 or EnemyClass == 3 or EnemyClass == 7) then
				if not ni.unit.debuff("target", 47864, "player")
				and ni.spell.valid("target", 47864, true, true) then
					ni.spell.cast(47864)
					LastMove = GetTime()
				end
      end
    end;
    ["Fear2"] = function()
        local Enemies = ni.player.enemiesinrange(6);
				if GetTime() - LastMove >= 0.8
				and ni.spell.available(17928) then
        for i = 1, #Enemies do
            local ENEMY = Enemies[i].guid;
            if not ni.unit.istotem(ENEMY)
            and ni.unit.isplayer(ENEMY) then
                ni.spell.cast(17928)
								LastMove = GetTime()
            end
        end
			end
    end,
    ["WalkingSpirit"] = function()
			local dlay = GetSetting("ddly");
      if GetTime() - LastMove > dlay
      and ni.spell.available(magic.WalkingSpirit) then
				if ni.unit.debuff("target", 47813) and (ni.unit.debuff("target", 47865) or ni.unit.debuff("target", 11719) or ni.unit.debuff("target", 18223) or ni.unit.debuff("target", 47864))
				and ni.unit.debuff("target", magic.Unstable)
				and (not ni.unit.debuff("target", magic.WalkingSpirit, "player") or ni.unit.debuffremaining("target", magic.WalkingSpirit, "player") <= RenewDebuff)
				and ni.spell.valid("target", magic.WalkingSpirit, true, true)
				and not ni.player.ismoving() then
					ni.spell.cast(magic.WalkingSpirit)
					LastMove = GetTime()
				end
      end
    end;
    ["UnstableMagic"] = function()
			local dlay = GetSetting("ddly");
      if GetTime() - LastMove > dlay
      and ni.spell.available(magic.Unstable) then
				if ni.unit.debuff("target", 47813) and (ni.unit.debuff("target", 47865) or ni.unit.debuff("target", 11719) or ni.unit.debuff("target", 18223) or ni.unit.debuff("target", 47864))
				and (not ni.unit.debuff("target", magic.Unstable, "player") or ni.unit.debuffremaining("target", magic.Unstable, "player") <= RenewDebuff)
				and ni.spell.valid("target", magic.Unstable, true, true)
				and not ni.player.ismoving() then
					ni.spell.cast(magic.Unstable)
					LastMove = GetTime()
				end
      end
    end;
    ["Cursing"] = function()
			local dlay = GetSetting("ddly");
			if GetTime() - LastMove > dlay
			and ni.spell.available(magic.Cursing) then
				if (not ni.unit.debuff("target", magic.Cursing, "player") or ni.unit.debuffremaining("target", magic.Cursing, "player") <= 0.5)
				and ni.spell.valid("target", magic.Cursing, true, true) then
					ni.spell.cast(magic.Cursing)
					LastMove = GetTime()
				end
       end
    end;
    ["SoulDrain"] = function()
			local dlay = GetSetting("ddly");
      if GetTime() - LastMove > dlay
      and ni.spell.available(magic.StealSoul)
      and ni.unit.hp("target") < 26 then
				if ni.unit.debuff("target", 47813) and (ni.unit.debuff("target", 47865) or ni.unit.debuff("target", 11719) or ni.unit.debuff("target", 18223) or ni.unit.debuff("target", 47864))
				and ni.spell.valid("target", magic.StealSoul, true, true) then
					ni.spell.cast(magic.StealSoul)
       	 LastMove = GetTime()
				end
      end
    end;
    ["ShadowBolt"] = function()
			local dlay = GetSetting("ddly");
      if GetTime() - LastMove > dlay
      and ni.spell.available(magic.ShadowBolt)
      and ni.player.buff(magic.BoltBuff)
      and ni.spell.valid("target", magic.ShadowBolt, true, true) then
        ni.spell.cast(magic.ShadowBolt)
        LastMove = GetTime()
      end
    end;
    ["Manareg"] = function()
			local dlay = GetSetting("ddly");
			local _, itison = GetSetting("ldrn");
      if itison then
        if GetTime() - LastMove > dlay
				and ni.player.power() < 90
        and ni.player.hp() > 50
        and ni.spell.available(magic.Manareg)
        and ni.player.ismoving() then
          ni.spell.cast(magic.Manareg)
          LastMove = GetTime()
				end
       	if GetTime() - LastMove > dlay
				and ni.player.power() < 15
        and ni.player.hp() > 50
        and ni.spell.available(magic.Manareg) then
          ni.spell.cast(magic.Manareg)
          LastMove = GetTime()
        end
      end
    end;
    ["Hellflame"] = function()
			local dlay = GetSetting("ddly");
      if GetTime() - LastMove > dlay
      and ni.spell.available(magic.Hellflame)
      and ni.player.inmelee("target")
      and ni.player.isfacing("target") then
        ni.spell.cast(magic.Hellflame)
        LastMove = GetTime()
      end
    end;
    ["SummonPet"] = function()
			local dlay = GetSetting("ddly");
			local CurrentPet = GetSetting("pete");
      if GetTime() - LastMove > dlay
      and not ni.unit.exists("playerpet")
      and not UnitAffectingCombat("player")
      and ni.spell.available(CurrentPet)
			and not ni.player.buff(61431)
      and not ni.player.ismoving() then
        ni.spell.cast(CurrentPet)
        LastMove = GetTime()
			end
		end;
    ["SpellStone"] = function()
			local dlay = GetSetting("ddly");
			if GetTime() - LastMove > dlay
			and not GetWeaponEnchantInfo()
			and not ni.player.ismoving()
			and not UnitAffectingCombat("player") then
				if not ni.player.hasitem(41196)
				and IsUsableSpell(GetSpellInfo(47888))
				and ni.spell.available(47888)
				and not UnitAffectingCombat("player") then
					ni.spell.cast(47888)
					LastMove = GetTime()
				else
				ni.player.useitem(41196)
				ni.player.useinventoryitem(16)
				LastMove = GetTime()
				end
			end
		end;
    ["Shield"] = function()
			local dlay = GetSetting("ddly");
			local CurrentShield = GetSetting("shld");
      if GetTime() - LastMove > dlay
      and ni.spell.available(CurrentShield)
			and not ni.player.buff(CurrentShield) then
        ni.spell.cast(CurrentShield)
        LastMove = GetTime()
      end
    end;
    ["DarkAbsorb"] = function()
			local dlay = GetSetting("ddly");
      if not ni.player.buff(magic.DarkAbsorb)
      and ni.spell.available(magic.DarkAbsorb)
      and GetTime() - LastMove > dlay then
        ni.spell.cast(magic.DarkAbsorb)
        LastMove = GetTime()
      end
    end;
};
ni.bootstrap.profile("Broken_Afli_pvp", order, moves, OnLoad, OnUnLoad);