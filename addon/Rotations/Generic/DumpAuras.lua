local queue = {
    "DumpPlayer"
    --"DumpTalents",
}


local abilities = {
    ["DumpPlayer"] = function()
        local dumpedPlayer = false
        if not dumpedPlayer then
            CopyChatFrame:Show()
            for i = 1, 400 do
                --/dump UnitAura("player", 1)
                local name, _, texture, stackCount, dispelType, duration, expirationTime, unitCaster, _, _, spellId =  UnitAura("player", i)
                    if name ~= nil and spellId ~= nil then
                        CopyChatFrameEditBox:Insert(string.format("%s - %s (%s)", name, spellId, unitCaster))
                        CopyChatFrameEditBox:Insert("\n")
												dumpedPlayer = true
                    end
            end
						for i = 1, 400 do
							--/dump UnitAura("player", 1)
							local name, _, texture, stackCount, dispelType, duration, expirationTime, unitCaster, _, _, spellId =  UnitDebuff("player", i)
									if name ~= nil and spellId ~= nil then
											CopyChatFrameEditBox:Insert(string.format("%s - %s (%s)", name, spellId, unitCaster))
											CopyChatFrameEditBox:Insert("\n")
											dumpedPlayer = true
									end
					end
        end
    end
}

ni.bootstrap.rotation("DumpAuras", queue, abilities)
