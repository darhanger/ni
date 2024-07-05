local build = select(4, GetBuildInfo());
local wotlk = build == 30300 or false;
if wotlk then
	local abilities = {
		["Pause"] = function()
			if IsMounted()
					or UnitIsDeadOrGhost("player")
					or not UnitExists("target")
					or UnitIsDeadOrGhost("target")
					or (UnitExists("target") and not UnitCanAttack("player", "target"))
			then
				return true
			end
			if UnitChannelInfo("player") == spells.MindSear.name
					or UnitChannelInfo("player") == spells.MindFlay.name
			then
				return true
			end
		end,
		["Cache"] = function()
			_shadowweaving = ni.player.buffstacks(15258)
			_targetTTD = ni.unit.ttd("target")
		end,
		["Shadowform"] = function()
			if not ni.player.buff(spells.Shadowform.id)
					and ni.spell.available(spells.Shadowform.id)
			then
				ni.spell.cast(spells.Shadowform.name)
			end
		end,
		["VampiricEmbrace"] = function()
			if not ni.player.buff(spells.VampiricEmbrace.id)
					and ni.spell.available(spells.VampiricEmbrace.id)
			then
				ni.spell.cast(spells.VampiricEmbrace.name)
			end
		end,
		["InnerFire"] = function()
			if not ni.player.buff(spells.InnerFire.id)
					and ni.spell.available(spells.InnerFire.id)
			then
				ni.spell.cast(spells.InnerFire.name)
			end
		end,
		["VampiricTouch"] = function()
			if not DoubleCast(spells.VampiricTouch.name, "target")
					and ni.unit.debuffremaining("target", spells.VampiricTouch.id, "player") < 2
					and not ni.player.ismoving()
					and _targetTTD > 4
					and ValidUsable(spells.VampiricTouch.id, "target")
					and FacingLosCast(spells.VampiricTouch.name, "target") then
				return true
			end
		end,
		["DevouringPlague"] = function()
			if not DoubleCast(spells.DevouringPlague.name, "target")
					and ni.unit.debuffremaining("target", spells.DevouringPlague.id, "player") < 2
					and ValidUsable(spells.DevouringPlague.id, "target")
					and FacingLosCast(spells.DevouringPlague.name, "target") then
				return true
			end
		end,
		["ShadowWordPain"] = function()
			if not DoubleCast(spells.ShadowWordPain.name, "target")
					and ni.unit.debuffremaining("target", spells.ShadowWordPain.id, "player") < 2
					and _shadowweaving == 5
					and _targetTTD > 4
					and ValidUsable(spells.ShadowWordPain.id, "target")
					and FacingLosCast(spells.ShadowWordPain.name, "target") then
				return true
			end
		end,
		["MindBlast"] = function()
			if ValidUsable(spells.MindBlast.id, "target")
					and not ni.player.ismoving()
					and FacingLosCast(spells.MindBlast.name, "target") then
				return true
			end
		end,
		["MindFlay"] = function()
			if ValidUsable(spells.MindFlay.id, "target")
					and not ni.player.ismoving()
					and UnitChannelInfo("player") ~= spells.MindFlay.name
					and FacingLosCast(spells.MindFlay.name, "target") then
				return true
			end
		end,
		["MindSear"] = function()
			if ValidUsable(spells.MindSear.id, "target")
					and not ni.player.ismoving()
					and UnitChannelInfo("player") ~= spells.MindSear.name
					and #ni.unit.enemiesinrange("target", 10) > 4
					and FacingLosCast(spells.MindSear.name, "target") then
				return true
			end
		end,
		["ShadowWordDeath"] = function()
			if ValidUsable(spells.ShadowWordDeath.id, "target")
					and _shadowweaving < 5
					and FacingLosCast(spells.MindSear.name, "target") then
				return true
			end
		end,
		["Dispersion"] = function()
			if enables["Dispersion"]
					and ni.player.power("mana") <= values["Dispersion"]
					and ni.spell.available(spells.Dispersion.id) then
				ni.spell.cast(spells.Dispersion.name)
			end
		end,
		["Shadowfiend"] = function()
			if enables["Shadowfiend"]
					and ni.spell.available(spells.Shadowfiend.id)
					and _targetTTD > 10
					and IsSpellInRange(spells.MindBlast.name, "target") then
				ni.spell.cast(spells.Shadowfiend.name)
				return true
			end
			if UnitExists("pet")
					and not UnitIsDeadOrGhost("pet") then
				--Attack the same unit as player
				local petTarget = UnitGUID("pettarget")
				local playerTarget = UnitGUID("target")
				if petTarget ~= playerTarget then
					ni.player.runtext("/petattack")
				end
			end
		end
	}
	ni.bootstrap.profile("Shadow_WotLK", queue, abilities, OnLoad, OnUnload);
else
	local queue = {
		"Error",
	};
	local abilities = {
		["Error"] = function()
			ni.vars.profiles.enabled = false;
			if not wotlk then
				ni.frames.floatingtext:message("This profile for WotLK 3.3.5a!")
			end
		end,
	};
	ni.bootstrap.profile("Shadow_WotLK", queue, abilities);
end;
