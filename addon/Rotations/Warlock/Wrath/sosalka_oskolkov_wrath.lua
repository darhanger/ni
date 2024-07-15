local cache = {
    info = true,
    };
    local spells = {
        sos = GetSpellInfo(47855),
        };
local queue = {
    "info",
    "sosal",
};

local abilities = {
    -----------------------------------
    ["info"] = function()
        if cache.info == true
        and not ni.vars.coin then
            cache.info = false
            print("|cFFFF0000  =========================|r\
|cFF00FF00Лок Сосун|r\
|cFFFF5A00Приватный профиль by Makaren|r\
|cFF00FFFFФанпей https://funpay.com/users/7303789/|r\
|cFF00FFFFДс https://discord.com/users/785141640087207966|r\
|cFF00FFFFДс Группы https://discord.gg/eQzcDHbVfm|r\
|cFFFF0000=========================|r")
        end
    end,
    ["sosal"] = function()
        if ni.spell.available(spells.sos)
        and not ni.unit.ischanneling("player")
        and ni.spell.valid("target", spells.sos, false, true, true) then
            ni.spell.cast(spells.sos)
        end
    end
};
ni.bootstrap.profile("sosalka_oskolkov_wrath", queue, abilities)