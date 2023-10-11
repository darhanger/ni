local queue = {
	"pause",
    --"open",
	--"buff",
	"fish"

}
local functionsent = 0
local Fishing = GetSpellInfo(7620)
local offset = 0xBC
local abilities = {
	["pause"] = function()
		if IsMounted()
		 or UnitInVehicle("player")
		 or UnitIsDeadOrGhost("player")
		 or UnitCastingInfo("player")
		 or UnitAffectingCombat("player")
		 or ni.player.ismoving() then
			return true;
		end
	end,
	["open"] = function()
        if ni.player.hasitem(135581) then
			ni.player.useitem(135581)
		end
	end,
	["buff"] = function()
        if IsEquippedItem(33820)
        and IsEquippedItem(135597) then
			local lure_enchant = GetWeaponEnchantInfo()
			if not lure_enchant
			and not UnitChannelInfo("player")
			and ni.player.itemcd(33820) == 0 then
				ni.player.useitem(33820)
				ni.player.useinventoryitem(16)
			end
		end
	end,
	["fish"] = function()
        local lure_enchant = GetWeaponEnchantInfo()
        --if lure_enchant then
        if UnitChannelInfo("player") then
            if GetTime() - functionsent > 4 then
                local playerguid = UnitGUID("player")
                for k, v in pairs(ni.objects) do
                    if type(k) ~= "function" and (type(k) == "string" and type(v) == "table") then
                        if v.name == "Поплавок" then
                            local creator = v:creator()
                            if creator == playerguid then
                                local ptr = ni.memory.objectpointer(v.guid)
                                if ptr then
                                    local result = ni.memory.read("byte", ptr, offset)
                                    if result == 1 then
                                        ni.player.interact(v.guid)
                                        functionsent = GetTime()
                                        return true
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            else
                ni.spell.delaycast(Fishing, nil, math.random(5, 12))
                ni.utils.resetlasthardwareaction()
            end
        --end
	end,
}
ni.bootstrap.profile("Fisher", queue, abilities)