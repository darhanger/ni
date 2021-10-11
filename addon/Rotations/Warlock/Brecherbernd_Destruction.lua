local queue = {
	"Dark Intent",
	"Curse of the Elements",
	"Shadowburn",
	"Immolate",
	"Conflagrate2stacks",
	"Chaos Bolt",
	"Conflagrate",
	"Incinerate",
	"Fel Flame"
};
local DarkIntent = GetSpellInfo(109773)
local CurseoftheElements = GetSpellInfo(1490);
local Shadowburn = GetSpellInfo(17877);
local Immolate = GetSpellInfo(348);
local Conflagrate = GetSpellInfo(17962);
local Conflagrate2stacks = GetSpellInfo(17962);
local ChaosBolt = GetSpellInfo(116858);
local Incinerate = GetSpellInfo(29722)
local FelFlame = GetSpellInfo(77799)

local abilities = {
["Dark Intent"] = function()
		if ni.spell.available(DarkIntent) then
			local how = ni.player.buffremaining(DarkIntent);
			if how <= 1 then
				ni.spell.cast(DarkIntent);
				return true;
			end
		end
	end,	

["Immolate"] = function()
		if ni.spell.available(Immolate)
		and ni.unit.debuffremaining("target", "Immolate", "player") <2 then
			ni.spell.cast(Immolate, "target")
			return true
		end
	end,

["Conflagrate2stacks"] = function()
	local Conflagrate, _, _, Conflagrate_stacks = ni.player.buff(17962)
		if ni.spell.available(Conflagrate) 
			and Conflagrate_stacks == 2 then
				ni.spell.cast(Conflagrate, "target")
			return true;
		end
	end,

["Chaos Bolt"] = function()
		if ni.spell.available(ChaosBolt)
		and ni.unit.buffstacks("target", 108647, "player") >3.5 then
			ni.spell.cast(ChaosBolt, "target")
		return true
		end
	end,

["Conflagrate"] = function()
		local Conflagrate, _, _, Conflagrate_stacks = ni.player.buff(17962)
			if ni.spell.available(Conflagrate) 
				and Conflagrate_stacks == 1 then
					ni.spell.cast(Conflagrate, "target")
				return true;
			end
		end,

["Incinerate"] = function()
			if ni.spell.available(Incinerate)
			then ni.spell.cast(Incinerate, "target")
			return true
		end
	end,

};
ni.bootstrap.rotation("Brecherbernd_Destruction", queue, abilities)