local queue = {
	"DumpBook",
	"DumpTalents"
}
local dumped = false
local dumpedTalents = false
local abilities = {
	["DumpBook"] = function()
		if not dumped then
			local sb = {}
			CopyChatFrame:Show()
			local tabs = GetNumSpellTabs()
			CopyChatFrameEditBox:Insert(string.format("--build == %s", ni.vars.build))
			CopyChatFrameEditBox:Insert("\n")
			for i = 1, tabs do
				local name, tabicon, offset, numSpells, isGuild, offspecID = GetSpellTabInfo(i)
				CopyChatFrameEditBox:Insert(string.format("--%s icon = select(2, GetSpellTabInfo(%s))", name, i))
				CopyChatFrameEditBox:Insert("\n")
				local tabEnd = offset + numSpells
				if offspecID == nil or offspecID == 0 then
					for j = offset + 1, tabEnd do
						ni.debug.log(string.format("j %s", j))
						if ni.vars.build == 30300 then
							local spellName, spellRank = GetSpellName(j, BOOKTYPE_SPELL)
							if spellRank ~= "Passive" and spellRank ~= "Racial Passive" then
								ni.debug.log(string.format("spellName %s", spellName))
								spellName = string.gsub(spellName, "%s+", "")
								spellName = string.gsub(spellName, "'", "")
								spellName = string.gsub(spellName, "-", "")
								spellName = string.gsub(spellName, ":", "")
								spellName = string.gsub(spellName, ",", "")
								GameTooltip:SetSpell(j, BOOKTYPE_SPELL)
								local spellID = select(3, GameTooltip:GetSpell())
								ni.debug.log(string.format("spellID %s", spellID))
								dumped = true
							end
						end
						if ni.vars.build > 30300 then
							local type, id = GetSpellBookItemInfo(j, "player")
							if type == "FLYOUT" then
								local _, _, numSlots = GetFlyoutInfo(id)
								for o = 1, numSlots do
									local flyoutID = GetFlyoutSlotInfo(id, o)
									local sname = GetSpellInfo(flyoutID)
									sname = string.gsub(sname, "%s+", "")
									sname = string.gsub(sname, "'", "")
									sname = string.gsub(sname, "-", "")
									sname = string.gsub(sname, ":", "")
									sname = string.gsub(sname, ",", "")
									local text =
										string.format(
										"%s = {id = %s, name = GetSpellInfo(%s), icon = select(3, GetSpellInfo(%s))},",
										sname,
										flyoutID,
										flyoutID,
										flyoutID
									)
									CopyChatFrameEditBox:Insert(text)
									CopyChatFrameEditBox:Insert("\n")
								end
							end
							if (type == "SPELL" or type == "FUTURESPELL") then
								local sname, rank = GetSpellInfo(id)
								if not string.match(rank, "Guild") then
									if (string.match(rank, "Cat")) then
										sname = sname .. "Cat"
									end
									if (string.match(rank, "Bear")) then
										sname = sname .. "Bear"
									end
									sname = string.gsub(sname, "%s+", "")
									sname = string.gsub(sname, "'", "")
									sname = string.gsub(sname, "-", "")
									sname = string.gsub(sname, ":", "")
									sname = string.gsub(sname, ",", "")
									local text =
										string.format(
										"%s = {id = %s, name = GetSpellInfo(%s), icon = select(3, GetSpellInfo(%s))},",
										sname,
										id,
										id,
										id
									)
									CopyChatFrameEditBox:Insert(text)
									CopyChatFrameEditBox:Insert("\n")
									dumped = true
								end
								--Dump Pet Book
								local type, id = GetSpellBookItemInfo(j, "pet")
								if (type == "SPELL" or type == "FUTURESPELL") then
									local sname, rank = GetSpellInfo(id)
									if (not string.match(rank, "Passive")) then
										sname = string.gsub(sname, "%s+", "")
										sname = string.gsub(sname, "'", "")
										sname = string.gsub(sname, "-", "")
										sname = string.gsub(sname, ":", "")
										sname = string.gsub(sname, ",", "")
										if not sb[name] then
											sb[name] = id
										end
										dumped = true
									end
								end
							end
						end
					end
				end
			end
			for k, v in pairs(sb) do
				local text =
					string.format("%s = {id = %s, name = GetSpellInfo(%s), icon = select(3, GetSpellInfo(%s))},", k, v, v, v)
				CopyChatFrameEditBox:Insert(text)
				CopyChatFrameEditBox:Insert("\n")
			end
		end
	end,
	["DumpTalents"] = function()
		if not dumpedTalents then
			CopyChatFrameEditBox:Insert("--Talents")
			CopyChatFrameEditBox:Insert("\n")
			if ni.vars.build <= 40300 then
				local numTabs = GetNumTalentTabs()
				ni.debug.log(string.format("%s", numTabs))
				for t = 1, numTabs do
					local _, tabName = GetTalentTabInfo(t)
					CopyChatFrameEditBox:Insert(string.format("--%s", tabName))
					CopyChatFrameEditBox:Insert("\n")
					local numTalents = GetNumTalents(t)
					local active = GetActiveTalentGroup(false, false)
					for i = 1, numTalents do
						local nameTalent, _, _, _, currRank, maxRank = GetTalentInfo(t, i)
						if nameTalent ~= nil then
							nameTalent = string.gsub(nameTalent, "%s+", "")
							nameTalent = string.gsub(nameTalent, "'", "")
							nameTalent = string.gsub(nameTalent, "-", "")
							nameTalent = string.gsub(nameTalent, ":", "")
							nameTalent = string.gsub(nameTalent, ",", "")
							CopyChatFrameEditBox:Insert(
								string.format("%s = GetTalentInfo(%s, %s), -- (%s/%s)", nameTalent, t, i, currRank, maxRank)
							)
							CopyChatFrameEditBox:Insert("\n")
						end
						dumpedTalents = true
					end
				end
			end
			--Three trees
			if ni.vars.build == 50400 then
				for t = 1, 18 do
					local sname = GetTalentInfo(t)
					local link = tostring(GetSpellLink(sname))
					local sid = tostring(link:match("spell:(%d+)"))
					sname = string.gsub(sname, "%s+", "")
					sname = string.gsub(sname, "'", "")
					sname = string.gsub(sname, ",", "")
					sname = string.gsub(sname, "-", "")
					sname = string.gsub(sname, ":", "")
					local text =
						string.format(
						"%s = {id = %s, name = GetSpellInfo(%s), icon = select(3, GetSpellInfo(%s))},",
						sname,
						sid,
						sid,
						sid
					)
					CopyChatFrameEditBox:Insert(text)
					CopyChatFrameEditBox:Insert("\n")
					dumpedTalents = true
				end
			end
			CopyChatFrameEditBox:Insert("--Glyph")
			CopyChatFrameEditBox:Insert("\n")
			for index = 1, GetNumGlyphSockets() do
				local enabled, glyphType, glyphTooltipIndex, glyphSpell, icon = GetGlyphSocketInfo(index)
				if glyphSpell ~= nil then
					local name = GetSpellInfo(glyphSpell)
					CopyChatFrameEditBox:Insert(string.format("%s %s %s", name, glyphSpell, enabled))
					CopyChatFrameEditBox:Insert("\n")
				end
			end
			dumpedTalents = true
		end
	end
}

ni.bootstrap.rotation("DumpSpells", queue, abilities)
