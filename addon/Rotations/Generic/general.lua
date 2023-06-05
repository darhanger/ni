local enables = {
	["povorot"] = false,
    ["spam"] = false,
    ["inchant"] = false,
}
local values = {
    ["inchant"] = 179,
    ["spam"] = 1,
    ["glaz"] = 0,
    ["frame"] = 41,
}
local inputs = {
    pool = "",
}
local menus = {
}
local function GUICallback(key, item_type, value)
	if item_type == "enabled" then
		enables[key] = value;
	elseif item_type == "value" then
		values[key] = value;
	elseif item_type == "input" then
		inputs[key] = value;
	elseif item_type == "menu" then
		menus[key] = value;
	end
end
local items = {
    settingsfile = "general.json",
    callback = GUICallback,
    { type = "title", text = "General Profile by |c0000CED1Makaren|r" },
	{ type = "separator" },
    { type = "page", number = 1, text = "|cffFFFF00Доп настройки игры|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(24803).." Доп отдаление камеры", tooltip ="Отдаляет камеру путем рыбьего глаза", value = 0, min = 0, max = 100, step = 1, key = "glaz" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(24803).." Дальность отображения фреймов", tooltip ="Меняет дальносить отображения фреймов(Default: 41)", value = 41, min = 0, max = 10000, width = 50, step = 1, key = "frame" },
    { type = "page", number = 2, text = "|cffFFFF00Автоповорот|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(24803).." Автоповорот", tooltip ="Автоматически поворачивается к таргету", enabled = false, key = "povorot" },
    { type = "title", text = "|cFFFF0000Использовать на свой страх и риск!|r"},
    { type = "page", number = 3, text = "|cffFFFF00Хелпер|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(13262).." Авто распыление предметов", tooltip ="Если поле ввода пустое то атоматически распыляет предметы уровня ниже", enabled = false, value = 179, min = 1, max = 300, step = 1, key = "inchant" },
    {
		type = "input",
		value = inputs["pool"],
		width = 140,
		height = 15,
		key = "pool"
	},
    { type = "page", number = 4, text = "|cffFFFF00Автоспам|r" },
    { type = "separator" },
    { type = "entry", text = ni.spell.icon(24803).." Автосмап макроса", tooltip ="Автоматически спамит макрос", enabled = false,  key = "spam" },
    { type = "entry", text =" Частота", tooltip ="Частота спама в минутах", value = 1,  key = "spam" },
    { type = "separator" },
    { type = "title", text = "Для того чтобы автоспам работал, нужно создать макрос с именем makaren"},

}
local function OnLoad()
	ni.GUI.AddFrame("general", items);
end;
local function OnUnLoad()  
	ni.GUI.DestroyFrame("general");
end;
local cache = {
    IsMoving = false,
    hours = false,
    minutes = false,
    hours_ = false,
    minutes_ = false,
    time = false,
    i = 1,
    ii = 0,
    i_ = 1,
    ii_ = 0,
    text = "/use",
    glaz = 0,
    frame = 41,
}
local queue = {
    "cache",
    "glaz",
    "frame",
    "povorot",
    "inchant",
    "spam",
}
local abilities = {
    ["cache"] = function()
        cache.IsMoving = ni.player.ismoving() or false;
        if cache.ii == 5 then
            cache.ii = 0
        end
        if cache.i == 30 then
            cache.i = 1
            cache.ii = cache.ii + 1
        end
    end,
    ["glaz"] = function()
        if values["glaz"] ~= cache.glaz then
            local text = (string.format('/run SetCVar("cameraFov",  %s', values["glaz"]+100))
            local text = (string.format(text .. "%s", ")"))
            ni.player.runtext(text)
            cache.glaz = values.glaz
        end
    end,
    ["frame"] = function()
        if values["frame"] ~= cache.frame then
            local text = (string.format('/run SetCVar("nameplateDistance",  %s', values["frame"]))
            local text = (string.format(text .. "%s", ")"))
            ni.player.runtext(text)
            cache.frame = values.frame
        end
    end,
    ["povorot"] = function()
        if enables["povorot"] 
        and not cache.IsMoving then
            ni.player.lookat("target")
        end
    end,
    ["inchant"] = function()
        if enables["inchant"]
        and inputs.pool == "" then
            local ItemLink = GetContainerItemLink(cache.ii, cache.i)
            local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType,
            itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(ItemLink)
            cache.i_ = tostring(cache.i)
            cache.ii_ = tostring(cache.ii)
            local text = (string.format("/use %s", cache.ii_))
            cache.text = (string.format(text .. " %s", cache.i_))
            cache.i = cache.i + 1
            if itemLevel <= values["inchant"]
            and ni.spell.available(13262) then
                if itemType == "Оружие" 
                or itemType == "Доспехи" then
                    ni.spell.cast(13262)
                    ni.player.runtext(cache.text)
                end
            end
        elseif enables["inchant"] then
            local ItemLink = GetContainerItemLink(cache.ii, cache.i)
            local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType,
            itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(ItemLink)
            cache.i_ = tostring(cache.i)
            cache.ii_ = tostring(cache.ii)
            local text = (string.format("/use %s", cache.ii_))
            cache.text = (string.format(text .. " %s", cache.i_))
            cache.i = cache.i + 1
            if itemName == inputs.pool
            and ni.spell.available(13262) then
                if itemType == "Оружие" 
                or itemType == "Доспехи" then
                    ni.spell.cast(13262)
                    ni.player.runtext(cache.text)
                end
            end
        end
    end,
    ["spam"] = function()
        if enables["spam"] then
            hours,minutes = GetGameTime();
            cache.hours = hours
            cache.minutes = minutes
            if cache.hours_ == false then
                cache.hours_ = hours
                cache.minutes_ = minutes
            end
            if cache.hours == cache.hours_ then
                cache.time = cache.minutes - cache.minutes_
                if cache.time >= values["spam"] then
                    RunMacro("makaren")
                    cache.hours_ = false
                end
            else 
                cache.time = cache.minutes - cache.minutes_ + 60
                if cache.time >= values["spam"] then
                    RunMacro("makaren")
                    cache.hours_ = false
                end
            end
        end
    end,
}
ni.bootstrap.profile("general", queue, abilities, OnLoad, OnUnLoad);