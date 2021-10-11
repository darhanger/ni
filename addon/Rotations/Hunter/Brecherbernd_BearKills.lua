local queue = {
  "Pause",
  "Mend Pet",
  "Healthstone",
  "Explosive Shot",
  "Hunters Mark",
  "Black Arrow",
  "Rapid Fire",
  "Misdirection",
  "Stampede",
  "A Murder of Crows",
  "Fervor",
  "Kill Shot", --Needs to be implemented
  "Glaive Toss",
  "Power Shot", --Needs to be implemented
  "Arcane Shot", --Needs to be implemented
  "Multi Shot", --Needs to be implemented
  "Serpent Sting",
  "Cobra Shot"

}

local mendpet = GetSpellInfo(136)
local huntersmark = GetSpellInfo(1130)
local explosiveshot = GetSpellInfo(53301)
local blackarrow = GetSpellInfo(3674)
local rapidfire = GetSpellInfo(3045)
local stampede = GetSpellInfo(121818)
local amoc = GetSpellInfo(131894)
local fervor = GetSpellInfo(82726)
local killshot = GetSpellInfo(53351)
local glaivetoss = GetSpellInfo(117050)
local powershot = GetSpellInfo(109259)
local arcaneshot = GetSpellInfo(3044)
local multishot = GetSpellInfo (2643)
local serpentsting = GetSpellInfo(1978)
local cobrashot = GetSpellInfo (77767)

local abilities = {
["Pause"] = function()
  if not UnitExists("target")
   or (UnitExists("target")
   and (not UnitCanAttack("player", "target")
   or UnitIsDeadOrGhost("target")))
   or UnitChannelInfo("player")
   or UnitIsDeadOrGhost("player")
   or IsMounted()
   or delayrotation then
    return true;
      end
  end,    

  ["Healthstone"] = function()
  if ni.player.hp() < 40
   and ni.player.hasitem(5512)
   and ni.player.itemcd(5512) == 0 then
    ni.player.useitem(5512);
    return true;
  end
  end,
  
["Misdirection"] = function()
  if ni.spell.available(misdirection) then
    if GetNumGroupMembers() == 0 then
      if UnitExists("pet")
       and IsSpellInRange(misdirection, "pet") == 1
       and ni.player.los("pet")
       and ni.unit.threat("pet", "target") ~= 3 then
        ni.spell.cast(misdirection, "pet");
        return true;
      end
    else
      local mt = ni.tanks();
      if IsSpellInRange(misdirection, mt) == 1
       and ni.player.los(mt)
       and ni.unit.threat(mt, "target") ~= 3 then
        ni.spell.cast(misdirection, mt);
        return true;
      end
    end
  end
end,

["Explosive Shot"] = function()
      if ni.spell.available(explosiveshot) then
             ni.spell.cast(explosiveshot, "target")
             return true
      end
end,

["Hunters Mark"] = function()
      if ni.spell.available(huntersmark) 
          and not ni.unit.debuff("target", 1130, "player") then
             ni.spell.cast(huntersmark, "target")
             return true
      end
end,

["Black Arrow"] = function()
      if ni.spell.available(blackarrow) then
             ni.spell.cast(blackarrow, "target")
             return true
      end
end,

["Rapid Fire"] = function()
      if ni.spell.available(rapidfire) then
             ni.spell.cast(rapidfire)
             return true
      end
end,

["Stampede"] = function()
      if ni.spell.available(stampede) then
             ni.spell.cast(stampede)
             return true
      end
end,

["A Murder of Crows"] = function()
      if ni.spell.available(amoc) then
             ni.spell.cast(amoc, "target")
             return true
      end
  end,

["Fervor"] = function()
      if ni.spell.available(fervor) then
             ni.spell.cast(fervor)
             return true
      end
end,

["Glaive Toss"] = function()
      if ni.spell.available(glaivetoss) then
             ni.spell.cast(glaivetoss, "target")
             return true
      end
  end,

["Serpent Sting"] = function()
      if ni.spell.available(serpentsting) 
          and not ni.unit.debuff("target", 1978, "player") then
             ni.spell.cast(serpentsting, "target")
             return true
      end
end,

["Cobra Shot"] = function()
      if ni.spell.available(cobrashot) then
             ni.spell.cast(cobrashot, "target")
             return true
      end
  end,
}
ni.bootstrap.rotation("Brecherbernd_BearKills", queue, abilities);