if (config.framework == 'qb') then
    QBCore = exports['qb-core']:GetCoreObject()
elseif (config.framework == 'esx') then
    ESX = exports['es_extended']:getSharedObject()
end

server.functions.initialize()

if config.useMySQL then
    MySQL.ready(function()
        local vehicles = MySQL.query.await('SELECT * FROM self_driving_vehicles')
        for k, v in pairs(vehicles) do
            local id = tostring(v.id)
            local plate = tostring(v.plate)
            local owned = shared.functions.numberToBoolean(v.owned)
            local favourite = json.decode(v.favourite)
            local history = json.decode(v.history)
            local vehicleObject = server.functions.createVehicleObject(id, plate, owned, favourite, history)
            server.vehicles[tostring(vehicleObject.functions.getPlate())] = vehicleObject
        end
    end)
end