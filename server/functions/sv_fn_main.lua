server.functions.initialize = function()
    shared.functions.loadLanguages(function(language)
        server.language = language
    end)
end

server.functions.getVehicles = function()
    return server.vehicles
end

server.functions.getVehicleByPlate = function(plate)
    return server.vehicles[tostring(plate)]
end

server.functions.saveVehicle = function(plate, cb)
    local vehicleObject = server.functions.getVehicleByPlate(tostring(plate))
    if vehicleObject then
        local plate = vehicleObject.functions.getPlate()
        local owned = vehicleObject.functions.getOwned()
        local favourite = json.encode(vehicleObject.functions.getFavourite())
        local history = json.encode(vehicleObject.functions.getHistory())
        if owned then
            MySQL.prepare('UPDATE `self_driving_vehicles` SET `favourite` = ?, `history` = ? WHERE `plate` = ?', {
                favourite,
                history,
                plate
            }, function(result)
                if result then
                    if type(cb) == 'function' then 
                        cb() 
                    else 
                        if config.debug then
                            print('Saved plate: '..plate..' self driving vehicle')
                        end
                    end
                end
            end)
        end
    end
end

server.functions.saveVehicles = function(cb)
    local vehicleObjects = server.functions.getVehicles()
    local parameters = {}
    local time = os.time()
    local count = 0
    for k, v in pairs(vehicleObjects) do
        local owned = vehicleObject.functions.getOwned()
        local favourite = json.encode(vehicleObject.functions.getFavourite())
        local history = json.encode(vehicleObject.functions.getHistory())
        if owned then
            count = count + 1
            parameters[#parameters + 1] = {
                favourite,
                history,
                v.functions.getPlate()
            }
        end
    end
    if (count >= 1) then
        MySQL.prepare('UPDATE `self_driving_vehicles` SET `favourite` = ?, `history` = ? WHERE `plate` = ?', parameters,
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

server.functions.addVehicle = function(plate, owned, favourite, history)
    local vehicleObject = server.functions.createVehicleObject(tostring(plate), owned, favourite, history)
    server.vehicles[tostring(vehicleObject.functions.getPlate())] = vehicleObject
end

server.functions.addVehicleToDatabase = function(plate, favourite, history, cb)
    MySQL.prepare('INSERT INTO `self_driving_vehicles` SET `plate` = ?, `favourite` = ?, `history` = ?', {
        plate,
        json.encode(favourite),
        json.encode(history)
    }, function(result)
        if result then
            server.functions.addVehicle(tostring(plate), true, favourite, history)
            if type(cb) == 'function' then 
                cb() 
            else 
                if config.debug then
                    print('Added plate: '..plate..' self driving vehicle')
                end
            end
        end
    end)
end