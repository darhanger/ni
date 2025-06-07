local UnitName, pairs, type, tonumber, UnitGUID, setmetatable, UnitCanAttack, UnitCanAssist, GetFramerate, floor, math_random, format, GetTime = UnitName, pairs, type, tonumber, UnitGUID, setmetatable, UnitCanAttack, UnitCanAssist, GetFramerate, floor, math.random, format, GetTime;
local uniID, uniExi, uniInf, uniHP, uniPow, uniPowM, uniLoS, uniAttack, uniAssist, uniCast, uniCastAt, uniCom, uniBeh, uniFac, uniDis, uniCreat, uniNewZ = ni.unit.id, ni.unit.exists, ni.unit.info, ni.unit.hp, ni.unit.power, ni.power.max, ni.unit.los, ni.unit.canattack, ni.unit.canassist, ni.spell.cast, ni.spell.castat, ni.unit.incombat, ni.unit.isbehind, ni.unit.isfacing, ni.unit.distance, ni.unit.creator, ni.unit.newz;
local locale = ni.vars.locale;
local isFunction, isString, isTable = ni.utils.isfunction, ni.utils.isstring, ni.utils.istable;
local unknown = locale == "ruRU" and "Неизвестно" or "Unknown";
local pla = "player";

local objects = {};
local objectmanager = {};

objectmanager.get = function()
    return ni.functions.getom();
end;

objectmanager.contains = function(o)
    local tmp = UnitName(o);
    if tmp then
        o = tmp;
    end;
    for k, v in pairs(objects) do
        if not isFunction(k)
        and (isString(k) and isTable(v)) then
            if v.name == o then
                return true;
            end
        end
    end
    return false;
end;
objectmanager.objectGUID = function(o)
    if tonumber(o) then
        return o;
    else
        local tmp = UnitName(o);
        if tmp then
            o = tmp;
        end
        for k, v in pairs(objects) do
            if not isFunction(k)
            and (isString(k) and isTable(v)) then
                if v.name == o then
                    return k;
                end
            end
        end
    end
end;
objectmanager.objectCount = function()
    local totalCount = 0;
    for k, v in pairs(objects) do
        if not isFunction(k)
        and (isString(k) and isTable(v)) then
            if objectmanager.contains(v.name) then
                totalCount = totalCount + 1;
            end
        end
    end
    return totalCount;
end;
local objectsetup = {};
objectsetup.cache = {};
objectsetup.cache.__index = {
    guid = 0,
    name = unknown,
    type = 0
};
setmetatable(
    objects,
    {
        __index = function(t, k)
            local guid = true and UnitGUID(k) or ni.objectmanager.objectGUID(k) or nil;
            if guid ~= nil then
                if objectsetup.cache[guid] then
                    return objectsetup.cache[guid];
                end
                local _, _, _, _, otype = uniInf(guid)
                local name = UnitName(guid);
                local ob = objects:get(guid, otype, name);
                return ob;
            end
            return objects:get(0, 0, unknown);
        end
    }
);
function objects:get(objguid, objtype, objname)
    if objectsetup.cache[objguid] then
        return objectsetup.cache[objguid];
    else
        return objects:create(objguid, objtype, objname);
    end
end;
function objects:create(objguid, objtype, objname)
    local o = {};
    setmetatable(o, objectsetup);
    if objguid then
        o.guid = objguid
        o.name = objname
        o.type = objtype
    end;
    local oGuid, oName, oType = o.guid, o.name, o.type;
    function o:exists()
        return uniExi(oGuid);
    end;
    function o:info()
        local z = uniNewZ(oGuid);
        local x, y, _, facing, unittype, target, height = uniInf(oGuid);
        return x, y, z, facing, unittype, target, height;
    end;
    function o:hp()
        return uniHP(oGuid);
    end;
    function o:power(t)
        return uniPow(oGuid, t);
    end;
    function o:powermax(t)
        return uniPowM(oGuid, t);
    end;
    function o:unit()
        return oType == 3;
    end
    function o:player()
        return oType == 4;
    end;
    function o:object()
        return oType == 5;
    end;
    function o:id()
        if oType == 3 then
            return uniID(oGuid);
        elseif oType == 5 and tonumber(oGuid) then
            return tonumber(oGuid:sub(8, 12), 16);
        end
        return nil;
    end;
    function o:canattack(tar)
        local t = true and tar or pla;
        return uniAttack(t, oGuid);
    end;
    function o:canassist(tar)
        local t = true and tar or pla;
        return uniAssist(t, oGuid);
    end;
    function o:los(tar)
        local t = true and tar or pla;
        return uniLoS(oGuid, t);
    end;
    function o:cast(spell)
        uniCast(spell, oGuid);
    end;
    function o:castat(spell)
        local LoS = ni.player.los;
        if LoS(oGuid) then
            uniCastAt(spell, oGuid);
        end
    end;
    function o:combat()
        return uniCom(oGuid);
    end;
    function o:isbehind(tar, rev)
        local t = true and tar or pla;
        if rev then
            return uniBeh(t, oGuid);
        end
        return uniBeh(oGuid, t);
    end;
    function o:isfacing(tar, rev)
        local t = true and tar or pla;
        if rev then
            return uniFac(t, oGuid);
        end
        return uniFac(oGuid, t);
    end;
    function o:distance(tar)
        local t = true and tar or pla;
        return uniDis(oGuid, t);
    end;
    function o:range(tar)
        local dist = o:distance(tar);
        return (dist <= 60) and true or false;
    end;
    function o:creator()
        return uniCreat(oGuid);
    end;
    function o:target()
        local _, _, _, _, _, t = uniInf(oGuid);
        return t;
    end;
    function o:location()
        local z = uniNewZ(oGuid)
        local x, y, _, r = uniInf(oGuid);
        local t = {
            x = x,
            y = y,
            z = z,
            r = r
        };
        return t;
    end;
    function o:calculatettd()
		return ni.ttd.calculate(o);
    end;
    function o:updateobject()
        o.guid = oGuid;
        o.name = (oName ~= unknown and oName ~= "UNKNOWNOBJECT") and oName or UnitName(oGuid);
        o.type = oType;
        o:calculatettd();
    end;
    
    objectsetup.cache[objguid] = o;
    return o;
end;
function objects:new(objguid, objtype, objname)
    local dist = ni.unit.distance;
    if objectsetup.cache[objguid] then
        return false;
    end    
    if dist(pla, objguid) <= 90 then
        return objects:create(objguid, objtype, objname);
    end
end;

local function round(num, idp)
    local mult = 10^(idp or 0);
    return floor(num * mult + 0.5) / mult;
end;

local function UpdateRate()
    local FrameRate = floor(GetFramerate()) or 0;
    if FrameRate >= 0 and FrameRate < 52 then
        return round((60-FrameRate)/60, 2);
    else
        return round(math_random(6, 12)/100, 2);
    end
end;

function objects:updateobjects()
    local xtime = GetTime();
    local objects = objects;
    local cache = objectsetup.cache;
    local currentRate = UpdateRate();

    local isFunction = isFunction;
    local isString = isString;
    local isTable = isTable;

    for GUID, object in pairs(objects) do
        if not isFunction(GUID) and isString(GUID) and isTable(object) then
            if not object.lastupdate or xtime >= (object.lastupdate + currentRate) then
                object.lastupdate = xtime;
                if not object:exists() then
                    cache[GUID] = nil;
                    objects[GUID] = nil;
                else
                    object:updateobject();
                end
            end
        end
    end
end;

return objects, objectmanager;