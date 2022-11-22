server.functions.initialize = function()
    shared.functions.loadLanguages(function(language)
        server.language = language
    end)
end

server.functions.getVehicles = function()
    return server.vehicles
end

server.functions.getVehicleById = function(id)
    for k, v in pairs(server.vehicles) do
        if (tostring(id) == tostring(v.getId())) then
            return v
        end
    end
end

server.functions.getVehicleByPlate = function(plate)
    return server.vehicles[tostring(plate)]
end

server.functions.saveVehicle = function(plate, cb)
    local vehicleObject = server.functions.getVehicleByPlate(tostring(plate))
    if vehicleObject then
        local owned = shared.functions.booleanToNumber(vehicleObject.functions.getOwned())
        local favourite = json.encode(vehicleObject.functions.getFavourite())
        local history = json.encode(vehicleObject.functions.getHistory())
        MySQL.prepare('UPDATE `self_driving_vehicles` SET `owned` = ?, `favourite` = ?, `history` = ? WHERE `plate` = ?', {
            owned,
            favourite,
            history,
            vehicleObject.functions.getPlate()
        }, function(affectedRows)
            if cb then 
                cb()
            end
        end)
    end
end

server.functions.saveVehicles = function(cb)
    local vehicleObjects = server.functions.getVehicles()
    local parameters = {}
    local time = os.time()
    local count = 0
    for k, v in pairs(vehicleObjects) do
        count = count + 1
        parameters[#parameters + 1] = {
            owned,
            favourite,
            history,
            vehicleObject.functions.getPlate()
        }
    end
    if (count >= 1) then
        MySQL.prepare('UPDATE `self_driving_vehicles` SET `owned` = ?, `favourite` = ?, `history` = ? WHERE `plate` = ?', parameters,
        function(results)
            if results then
                if type(cb) == 'function' then 
                    cb() 
                else 
                    if config.debug then
                        print('Saved '..count..' self driving vehicles over '..((os.time() - time)/1000000)..'s')
                    end
                end
            end
        end)
    end
end