shared = {}

shared.functions = {}

shared.functions.loadLanguages = function(cb)
	local language = LoadResourceFile(GetCurrentResourceName(), '/lang/'..config.language..'.json')
    if language then
        jsonLanguage = json.decode(language)
        if cb then
            cb(jsonLanguage[1])
        end
    end
end

shared.functions.numberToBoolean = function(number)
    if (type(number) == 'number') then
        if (number == 1) then
            return true
        elseif (number == 0) then
            return false
        end
    end
    return false
end

shared.functions.booleanToNumber = function(boolean)
    if (type(boolean) == 'boolean') then
        if (boolean) then
            return 1
        else
            return 0
        end
    end
    return false
end
