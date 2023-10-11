local hpal_skills = {
	Seal_of_Wisdom = GetSpellInfo(20166),
	Divine_Plea = GetSpellInfo(54428),
	Divine_Illumination = GetSpellInfo(31842),
	Divine_Favor = GetSpellInfo(20216),
	Holy_Light = GetSpellInfo(48782),
	Holy_Shock = GetSpellInfo(48825),
	Flash_of_Light = GetSpellInfo(48785),
	Hand_of_Sacrifice = GetSpellInfo(6940),
	Lay_on_Hands = GetSpellInfo(48788),
	Hammer_of_Justice = GetSpellInfo(10308),
	Beacon_of_Light = GetSpellInfo(53563),
	Sacred_Shield = GetSpellInfo(53601),
	Cleanse = GetSpellInfo(4987),
	Avenging_Wrath = GetSpellInfo(31884),
	Holy_Wrath = GetSpellInfo(48817),
	Infusion_of_Light = GetSpellInfo(54149),
	Forbearance = GetSpellInfo(25771),
	Hand_of_Salvation = GetSpellInfo(1038),
	Hand_of_Protection = GetSpellInfo(10278),
	Divine_Shield = GetSpellInfo(642),
	Hand_of_Freedom = GetSpellInfo(1044),
    Racial = GetSpellInfo(316256),
}
local menus = {
    ["Blessing"] = GetSpellInfo(25898)
}
local items = {
    {
        type = "title",
        text = "|cfff58cbaHoly Paladin PvE |cffcece0cA1 v1.3"
    },
    {
        type = "separator"
    },
{type = "title", text = "Blessing Selection"},
{
    type = "dropdown",
    menu = {
        {
            selected = (menus["Blessing"] == GetSpellInfo(25898)),
            value = GetSpellInfo(25898),
            text = "|cfff58cbaКаска"
        },
        {
            selected = (menus["Blessing"] == GetSpellInfo(48934)),
            value = GetSpellInfo(48934),
            text = "|cfff58cbaКулак"
        },
        {
            selected = (menus["Blessing"] == GetSpellInfo(48938)),
            value = GetSpellInfo(48938),
            text = "|cfff58cbaКрест"
        },
        {
            selected = (menus["Blessing"] == GetSpellInfo(25898)),
            value = 0,
            text = "|cffff0063Выключено"
        },
    },
    key = "Blessing"
},
settingsfile = "Ed_Holy_Paladin323123123.xml",
callback = GUICallback
}

local function GetSetting(name)
for k, v in ipairs(items) do
    if v.type == "entry" and v.key ~= nil and v.key == name then
        return v.value, v.enabled
    end
    if v.type == "dropdown" and v.key ~= nil and v.key == name then
        for k2, v2 in pairs(v.menu) do
            if v2.selected then
                return v2.value
            end
        end
    end
    if v.type == "input" and v.key ~= nil and v.key == name then
        return v.value
    end
end
end

local function OnLoad()
ni.GUI.AddFrame("Protection_Paladin", items)
end
local function OnUnLoad()
ni.GUI.DestroyFrame("Protection_Paladin")
end
local queue = {
    "Blessing",
}
local abilities = {
    ["Blessing"] = function()
        local selectedBlessing = menus["Blessing"]

        if ni.spell.available(selectedBlessing)
        and not ni.player.buff(selectedBlessing)
        and IsUsableSpell(selectedBlessing) then
            ni.spell.cast(selectedBlessing, "player")
            return true
        end
    end,
}
ni.bootstrap.profile("hpaltestet", queue, abilities, OnLoad, OnUnLoad)