if (config.framework == 'qb') then
    QBCore = exports['qb-core']:GetCoreObject()
elseif (config.framework == 'esx') then
    ESX = exports['es_extended']:getSharedObject()
end

server.functions.initialize()

if config.useMySQL then
    MySQL.ready(function()
        local vehicles = MySQL.query.await('SELECT * FROM `self_driving_vehicles`')
        for k, v in pairs(vehicles) do
            local plate = tostring(v.plate)
            local favourite = json.decode(v.favourite)
            local history = json.decode(v.history)
            server.functions.addVehicle(plate, true, favourite, history)
        end
    end)
end

RegisterServerEvent(GetCurrentResourceName()..':openSelfDriveMenu')
AddEventHandler(GetCurrentResourceName()..':openSelfDriveMenu', function(plate)
	local _source = source
    local vehicleObject = server.functions.getVehicleByPlate(tostring(plate))
    local owned = false
    local favourite = {}
    local history = {}
    if vehicleObject then
        owned = vehicleObject.functions.getOwned()
        favourite = vehicleObject.functions.getFavourite()
        history = vehicleObject.functions.getHistory()
    else
        local selectQuery = ''
        if (config.framework == 'qb') then
            selectQuery = 'SELECT `plate` FROM `player_vehicles` where `plate` = ?'
        elseif (config.framework == 'esx') then
            selectQuery = 'SELECT `plate` FROM `owned_vehicles` where `plate` = ?'
        end
        if (selectQuery ~= '') then
            local vehiclePlate = MySQL.prepare.await(selectQuery, {plate})
            if vehiclePlate then
                owned = true
                server.functions.addVehicleToDatabase(tostring(vehiclePlate), favourite, history)
            end
        end
        if not owned then
            server.functions.addVehicle(plate, false, favourite, history)
        end
    end
    TriggerClientEvent(GetCurrentResourceName()..':openSelfDriveMenu', _source, owned, favourite, history)
end)