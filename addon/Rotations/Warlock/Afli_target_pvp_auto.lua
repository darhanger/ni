local LastFear, LastAction = 0, 0;
local order = {
    "Pause",
    "CombatPause",
    "SpellStone",
    "makeStone",
    "Healthstone",
    "Щит",
    "Сейв",
    "Петщит",
    "Бурст",
    "FearHeal",
    "Вой",
    "REG",
    "Fear",
    "Проклятие",
    "Порча",
    "Стрела-прок",
    "Пламя",
    "Блуждающий дух",
    "Нестабильное колдовство",
    "ПохищениеЖизни",
    "ПохищениеДуши",
--    "Стрела",
}
local moves = {
    ["Pause"] = function()
        if IsMounted()
        or UnitInVehicle("player")
        or ni.player.buff(430)
        or ni.player.buff(433)
        or ni.player.isfleeing()
        or ni.player.issilenced()
        or ni.player.isstunned()
        or ni.player.iscasting()
        or ni.player.ischanneling()
        or UnitIsDeadOrGhost ("player")
        or IsLeftShiftKeyDown() then
            return true
        end
		ni.vars.debug = "true";
    end,
    ["CombatPause"] = function()
        local BadBuff = {45438, 48707, 642, 31224, 19263};
        for _, v in ipairs(BadBuff) do
            if ni.unit.buff("target", v) then
                return true
            end
        end
    end,
    ["Щит"] = function()
        local Armor = GetSpellInfo(47893);
        if GetTime() - LastAction >= 0.8
				and not ni.player.buff(Armor)
        and ni.spell.available(Armor) then
            ni.spell.cast(Armor)
						LastAction = GetTime()
        end
    end,
    ["Блуждающий дух"] = function ()
		local Enemies = ni.player.enemiesinrange(36);
    local WalkingSoul = GetSpellInfo(59164);
      if GetTime() - LastAction >= 0.8
			and ni.spell.available(WalkingSoul)
			and not ni.player.ismoving() then
        for i = 1, #Enemies do
        local ENEMY = Enemies[i].guid;
					if ni.unit.debuff(ENEMY, 47864, "player")
					and ni.unit.debuff(ENEMY, 47813, "player")
					and ni.spell.valid(ENEMY, WalkingSoul, true, true) then
						ni.spell.cast(WalkingSoul, ENEMY)
						LastAction = GetTime()
					end
        end
			end
    end,
    ["FearHeal"] = function ()
		local Enemies = ni.player.enemiesinrange(36);
      if GetTime() - LastAction >= 0.8
			and ni.player.hp() < 85
      and ni.spell.available(47860) then
				for i = 1, #Enemies do
				local ENEMY = Enemies[i].guid;
					if not ni.unit.debuff(ENEMY, 47860, "player")
					and ni.spell.valid(ENEMY, 47860, true, true) then
						ni.spell.cast(47860, ENEMY)
						LastAction = GetTime()
          end
				end
			end
    end,
    ["Fear"] = function ()
		local Enemies = ni.player.enemiesinrange(24);
      if GetTime() - LastAction >= 0.8
      and GetTime() - LastFear > 6
      and ni.spell.available(6215)
      and not ni.player.ismoving()
			and not (ni.unit.debuff("target", 6215, "player") or ni.unit.debuff("target", 47860, "player"))
      and ni.spell.valid("target", 6215, true, true)   then
        ni.spell.cast(6215)
        LastFear = GetTime()
				LastAction = GetTime()
      end
    end,
    ["Нестабильное колдовство"] = function ()
		local Enemies = ni.player.enemiesinrange(36);
      if GetTime() - LastAction >= 0.8
      and ni.spell.available(47843)
      and not ni.player.ismoving() then
				for i = 1, #Enemies do
				local ENEMY = Enemies[i].guid;
					if ni.unit.debuff(ENEMY, 47864, "player")
					and ni.unit.debuff(ENEMY, 47813, "player")
					and (not ni.unit.debuff(ENEMY, 47843, "player") or ni.unit.debuff(ENEMY, 47843, "player") and ni.unit.debuffremaining(ENEMY, 47843, "player") <= 2)
					and ni.spell.valid(ENEMY, 47843, true, true) then
						ni.spell.cast(47843, ENEMY)
						LastAction = GetTime()
					end
        end
			end
    end,
    ["Проклятие"] = function()
		local Enemies = ni.player.enemiesinrange(36);
      if GetTime() - LastAction >= 0.8
      and ni.spell.available(47864) then
				for i = 1, #Enemies do
				local ENEMY = Enemies[i].guid;
					if not ni.unit.debuff(ENEMY, 47864, "player")
					and ni.spell.valid(ENEMY, 47864, true, true) then
						ni.spell.cast(47864, ENEMY)
						LastAction = GetTime()
					end
        end
			end
    end,
    ["Порча"] = function()
		local Enemies = ni.player.enemiesinrange(36);
      if GetTime() - LastAction >= 0.8
			and ni.spell.available(47813) then
				for i = 1, #Enemies do
				local ENEMY = Enemies[i].guid;
					if ni.unit.debuff(ENEMY, 47864, "player")
					and (not ni.unit.debuff(ENEMY, 47813, "player") or (ni.unit.debuff(ENEMY, 47813, "player") and ni.unit.debuffremaining(ENEMY, 47813, "player") <= 2))
					and ni.spell.valid(ENEMY, 47813, true, true) then
						ni.spell.cast(47813, ENEMY)
						LastAction = GetTime()
					end
				end
			end
    end,
    ["ПохищениеДуши"] = function()
		local Enemies = ni.player.enemiesinrange(36);
      if GetTime() - LastAction >= 0.8
      and ni.spell.available(47855)
      and not ni.player.ismoving() then
				for i = 1, #Enemies do
				local ENEMY = Enemies[i].guid;
					if ni.unit.debuff(ENEMY, 47843, "player")
					and ni.unit.debuff(ENEMY, 47864, "player")
					and ni.unit.debuff(ENEMY, 47813, "player")
					and ni.spell.valid(ENEMY, 47855, true, true)
					and ni.unit.hp(ENEMY) <= 25 then
						ni.spell.cast(47855, ENEMY)
						LastAction = GetTime()
					end
				end
      end
    end,
    ["ПохищениеЖизни"] = function()
		local Enemies = ni.player.enemiesinrange(36);
      if GetTime() - LastAction >= 0.8
      and ni.spell.available(47857)
      and not ni.player.ismoving() then
				for i = 1, #Enemies do
				local ENEMY = Enemies[i].guid;
					if ni.unit.debuff(ENEMY, 47843, "player")
					and ni.unit.debuff(ENEMY, 47864, "player")
					and ni.unit.debuff(ENEMY, 47813, "player")
					and ni.spell.valid(ENEMY, 47857, true, true)
					and ni.player.hp() <= 65 then
						ni.spell.cast(47857, ENEMY)
						LastAction = GetTime()
					end
        end
			end
    end,
    ["Стрела-прок"] = function()
		local Enemies = ni.player.enemiesinrange(30);
      if GetTime() - LastAction >= 0.8
			and ni.spell.available(47809)
			and ni.player.buff(17941) then
				for i = 1, #Enemies do
				local ENEMY = Enemies[i].guid;
					if ni.spell.valid(ENEMY, 47809, true, true) then
            ni.spell.cast(47809, ENEMY)
						LastAction = GetTime()
					end
        end
			end
    end,
    ["Стрела"] = function()
		local Enemies = ni.player.enemiesinrange(30);
      if GetTime() - LastAction >= 0.8
			and ni.spell.available(47809)
			and not ni.player.ismoving() then
				for i = 1, #Enemies do
				local ENEMY = Enemies[i].guid;
					if ni.spell.valid(ENEMY, 47809, true, true) then
            ni.spell.cast(47809, ENEMY)
						LastAction = GetTime()
					end
        end
			end
    end,
    ["Бурст"] = function()
      if GetTime() - LastAction >= 0.8
			and UnitAffectingCombat("player")
      and ni.spell.available(33702) then
        ni.spell.cast(33702)
				LastAction = GetTime()
      end
    end,
    ["Пламя"] = function()
      if GetTime() - LastAction >= 0.8
			and ni.player.inmelee("target")
      and ni.player.isfacing("target")
      and ni.spell.valid("target", 47809, true, true)
      and ni.spell.available(61290) then
        ni.spell.cast(61290)
				LastAction = GetTime()
       end
    end,
    ["Вой"] = function()
    local Enemies = ni.player.enemiesinrange(6);
			if GetTime() - LastAction >= 0.8
			and ni.spell.available(17928) then
        for i = 1, #Enemies do
        local ENEMY = Enemies[i].guid;
          if not ni.unit.istotem(ENEMY)
          and ni.unit.isplayer(ENEMY) then
            ni.spell.cast(17928)
						LastAction = GetTime()
          end
        end
			end
    end,
    ["makeStone"] = function()
      if GetTime() - LastAction >= 0.8
			and not UnitAffectingCombat("player")
      and not ni.player.ismoving()
      and ni.spell.available(47871)
      and ni.player.hasitem(6265)
      and not (ni.player.hasitem(36891) or ni.player.hasitem(36894)) then
				ni.spell.cast(47871)
				LastAction = GetTime()
      end
    end,
	["Healthstone"] = function()
		local hstones = { 36891, 36892, 36893, 36894 }
		for i = 1, #hstones do
			if UnitAffectingCombat("player")
			and ni.player.hp() < 50
			and ni.player.hasitem(hstones[i])
			and ni.player.itemcd(hstones[i]) == 0 then
				ni.player.useitem(hstones[i])
			end
		end
	end,
    ["REG"] = function()
      if GetTime() - LastAction >= 0.8
			and ni.player.power() <= 50
      and ni.player.hp() > 50
      and ni.spell.available(57946)
      and ni.player.ismoving() then
        ni.spell.cast(57946)
				LastAction = GetTime()
      end
      if GetTime() - LastAction >= 0.8
			and ni.player.power() <= 10
      and ni.player.hp() > 50
      and ni.spell.available(57946) then
        ni.spell.cast(57946)
				LastAction = GetTime()
      end
    end,
    ["SpellStone"] = function()
		if not GetWeaponEnchantInfo()
        and ni.player.hasitem(41196)
		 and not ni.player.ismoving()
		 and not UnitAffectingCombat("player") then
		 if not ni.player.hasitem(41196)
		 and IsUsableSpell(GetSpellInfo(47888))
		 and ni.spell.available(47888) then
			ni.spell.cast(47888)
			LastAction = GetTime()
		 else
			ni.player.useitem(41196);
			ni.player.useinventoryitem(16);
            return true
			end
		end
	end,
    ["Петщит"] = function()
    local PetShield = GetSpellInfo(47986);
      if GetTime() - LastAction >= 0.8
			and UnitAffectingCombat("player")
      and ni.unit.exists("playerpet")
      and #ni.player.unitstargeting() >= 1
      and ni.spell.cd(PetShield) == 0 then
        ni.spell.cast(PetShield, "player")
				LastAction = GetTime()
      end
    end,
}
ni.bootstrap.rotation("Afli_target_pvp_auto", order, moves)