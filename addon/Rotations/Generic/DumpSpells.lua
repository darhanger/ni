local queue = {
    "DumpBook",
    --"DumpTalents",
}
local dumped = false
local dumpedTalents = false
local abilities = {
    ["DumpBook"] = function()
        if not dumped then
            CopyChatFrame:Show()
            local tabs = GetNumSpellTabs();
            for i = 1, tabs do
							local name, _, offset, numSpells = GetSpellTabInfo(i);
							CopyChatFrameEditBox:Insert(string.format("--%s", name))
							CopyChatFrameEditBox:Insert("\n")
							local tabEnd = offset + numSpells
							local sb ={}
							for j = offset + 1, tabEnd do
									ni.debug.log(string.format("j %s", j))
									-- /dump n.vars.build
									if ni.vars.build == 30300 then			
										local spellName, spellRank = GetSpellName(j, BOOKTYPE_SPELL)
										if spellRank ~= "Passive"
										and spellRank~= "Racial Passive" then
											ni.debug.log(string.format("spellName %s", spellName))
											spellName =  string.gsub(spellName, "%s+", "")
											spellName =  string.gsub(spellName,"'","")
											spellName =  string.gsub(spellName,"-","")
											GameTooltip:SetSpell(j, BOOKTYPE_SPELL)
											local spellID = select(3, GameTooltip:GetSpell())
											sb[spellName] = spellID
											ni.debug.log(string.format("spellID %s", spellID))
											dumped = true
										end
									end
									if ni.vars.build > 30300 then
									local type, id = GetSpellBookItemInfo(j, "player")
									if (type == "SPELL" or type == "FUTURESPELL") then
										local sname, rank = GetSpellInfo(id)
										if(rank ~= "Passive") then
											sname =  string.gsub(sname, "%s+", "")
											sname =  string.gsub(sname,"'","")
											sname =  string.gsub(sname,"-","")
											local text = string.format("%s = {id = %s, name = GetSpellInfo(%s)},", sname, id, id)
											CopyChatFrameEditBox:Insert(text)
											CopyChatFrameEditBox:Insert("\n")
											dumped = true
										end
								end
							end
						end
						for k, v in pairs(sb) do
							local text = string.format("%s = {id = %s, name = GetSpellInfo(%s)},", k, v, v)
							CopyChatFrameEditBox:Insert(text)
							CopyChatFrameEditBox:Insert("\n")
						end
					end
				end
			end,
    ["DumpTalents"] = function ()
        if not dumpedTalents then
            CopyChatFrameEditBox:Insert("--Talents")
            CopyChatFrameEditBox:Insert("\n")
            --pre MoP has different talent system
            ni.debug.log(string.format("ni.vars.build %s", ni.vars.build))
            if ni.vars.build <= 40300 then
                local numTabs = GetNumTalentTabs();
								ni.debug.log(string.format("%s", numTabs))
                for t = 1, numTabs do
                    local _, tabName = GetTalentTabInfo(t)
                    CopyChatFrameEditBox:Insert(string.format("--%s", tabName));
                    CopyChatFrameEditBox:Insert("\n")
                    local numTalents = GetNumTalents(t);
                    local active = GetActiveTalentGroup(false, false)
                    for i = 1, numTalents do
                        local nameTalent, _, _, _, currRank, maxRank = GetTalentInfo(t,i);
                        CopyChatFrameEditBox:Insert(string.format("%s (%s/%s) = GetTalentInfo(%s, %s)", nameTalent, currRank, maxRank, t, i))
                        CopyChatFrameEditBox:Insert("\n")
                        dumpedTalents = true
                    end
                end
            end
            if ni.vars.build >= 50300 then
                for t = 1, 18 do
                    ni.debug.log(string.format("%s", GetTalentInfo(t, "player")))
                    local n, _, _, _, s = GetTalentInfo(t, "player");
                    ni.debug.log(string.format("%s %s", n, s))
                    CopyChatFrameEditBox:Insert(string.format("%s Selected %s = select(5, GetTalentInfo(%s))", n, s, t))
                    CopyChatFrameEditBox:Insert("\n")
                    dumpedTalents = true
                end
            end
        end
        for index=1, GetNumGlyphSockets() do
            local enabled, glyphType, glyphTooltipIndex, glyphSpell, icon = GetGlyphSocketInfo(index);
            if glyphSpell ~= nil then
                local name = GetSpellInfo(glyphSpell)
                CopyChatFrameEditBox:Insert(string.format("%s %s %s", name, glyphSpell, enabled))
                CopyChatFrameEditBox:Insert("\n")
            end
        end

    end,
}

ni.bootstrap.rotation("DumpSpells", queue, abilities)
