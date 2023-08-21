-----------------------------------------------
--------------- Spell & Item ID ---------------
-----------------------------------------------
local ru = GetLocale() == "ruRU" or false;
local build = ni.vars.build;
local hooksecurefunc, select, UnitBuff, UnitDebuff, UnitAura, UnitGUID, GetGlyphSocketInfo, tonumber, strfind =
	  hooksecurefunc, select, UnitBuff, UnitDebuff, UnitAura, UnitGUID, GetGlyphSocketInfo, tonumber, strfind
local types = {
	spell       = "SpellID:",
	aplied		= "Applied by:",
	item        = "ItemID:",
	unit        = "NPC ID:",
	quest       = "QuestID:",
	achievement = "AchievementID:",
	glyph 		= "Glyph ID:",
};
if ru then
	types.spell       = "ID заклинания:"
	types.aplied      = "Наложено:"
	types.item        = "ID предмета:"
	types.unit        = "ID НПЦ:"
	types.quest       = "ID задания:"
	types.achievement = "ID достижения:"
	types.glyph		  = "ID символа:"
end;
local function addLine(tooltip, id, type)
	local found = false
	for i = 1, 15 do
		local frame = _G[tooltip:GetName() .. "TextLeft" .. i]
		local text
		if frame then text = frame:GetText() end
		if text and text == type then found = true break end
	end
	if not found then
		tooltip:AddDoubleLine(type, "|cffffffff" .. id)
		tooltip:Show()
	end	
end;
-- For Linked Tooltips --------------------------------------------------------
local function onSetHyperlink(self, link)
	local type, id = string.match(link,"^(%a+):(%d+)")
	if not type or not id then return end
	if type == "spell" or type == "enchant" or type == "trade" then
		addLine(self, id, types.spell)
	elseif type == "glyph" then
		addLine(self, id, types.glyph)		
	elseif type == "quest" then
		addLine(self, id, types.quest)
	elseif type == "achievement" then
		addLine(self, id, types.achievement)
	elseif type == "item" then
		addLine(self, id, types.item)
	end
end;
hooksecurefunc(ItemRefTooltip, "SetHyperlink", onSetHyperlink)
hooksecurefunc(GameTooltip, "SetHyperlink", onSetHyperlink)
-- Spell Hooks ----------------------------------------------------------------
hooksecurefunc(GameTooltip, "SetUnitBuff", function(self, ...)
	local id = select(11, UnitBuff(...))
	local name = select(8, UnitBuff(...))
	if id then addLine(self, id, types.spell) end
	if name then 
		local exactname = UnitName(name);
		addLine(self, exactname, types.aplied, true);
	end	
end);
hooksecurefunc(GameTooltip, "SetUnitDebuff", function(self,...)
	local id = select(11, UnitDebuff(...))
	local name = select(8, UnitDebuff(...))
	if id then addLine(self, id, types.spell) end
	if name then 
		local exactname = UnitName(name);
		addLine(self, exactname, types.aplied, true);
	end	
end);
hooksecurefunc(GameTooltip, "SetUnitAura", function(self,...)
	local id = select(11, UnitAura(...))
	local name = select(8, UnitAura(...))
	if id then addLine(self, id, types.spell) end
	if name then 
		local exactname = UnitName(name);
		addLine(self, exactname, types.aplied, true);
	end	
end);
hooksecurefunc("SetItemRef", function(link, ...)
	local id = tonumber(link:match("spell:(%d+)"))
	if id then addLine(ItemRefTooltip, id, types.spell) end
end);
GameTooltip:HookScript("OnTooltipSetSpell", function(self)
	local id = select(3, self:GetSpell())
	if id then addLine(self, id, types.spell) end
end);
-- NPCs Hooks ----------------------------------------------------------------
GameTooltip:HookScript("OnTooltipSetUnit", function(self)
	local unit = select(2, self:GetUnit())
	if unit then
		local guid = UnitGUID(unit) or ""
		local id   = ni.unit.id(unit)
		if id and guid:match("%a+") ~= "Player" then addLine(GameTooltip, id, types.unit) end
	end
end);
-- Items Hooks ----------------------------------------------------------------
local function attachItemTooltip(self)
	local link = select(2, self:GetItem())
	if link then
		local id = select(3, strfind(link, "^|%x+|Hitem:(%-?%d+):(%d+):(%d+).*"))
		if id then addLine(self, id, types.item) end
	end
end;
GameTooltip:HookScript("OnTooltipSetItem", attachItemTooltip)
ItemRefTooltip:HookScript("OnTooltipSetItem", attachItemTooltip)
ItemRefShoppingTooltip1:HookScript("OnTooltipSetItem", attachItemTooltip)
ItemRefShoppingTooltip2:HookScript("OnTooltipSetItem", attachItemTooltip)
ShoppingTooltip1:HookScript("OnTooltipSetItem", attachItemTooltip)
ShoppingTooltip2:HookScript("OnTooltipSetItem", attachItemTooltip)
-- Glyphs Hooks ----------------------------------------------------------------
hooksecurefunc(GameTooltip, "SetGlyph", function(self, ...)
	local enabled, id
	if build >= 40300 then
		enabled, _, _, id = GetGlyphSocketInfo(...)
	else
		enabled, _, id = GetGlyphSocketInfo(...)
	end	
	if enabled and id then addLine(self, id, types.glyph) end
end)
-- Achievement Frame Hooks -----------------------------------------------------
local f = CreateFrame("frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(_, _, what)
	if what == "Blizzard_AchievementUI" then
		for i,button in ipairs(AchievementFrameAchievementsContainer.buttons) do
			button:HookScript("OnEnter", function()
				GameTooltip:SetOwner(button, "ANCHOR_NONE")
				GameTooltip:SetPoint("TOPLEFT", button, "TOPRIGHT", 0, 0)
				addLine(GameTooltip, button.id, types.achievement)
				GameTooltip:Show()
			end)
			button:HookScript("OnLeave", function() GameTooltip:Hide() end)
		end
	end
end)