client = {}
client.language = {}
client.playerPed = PlayerPedId()
client.isPlayerAlive = false
client.isInVehicle = false
client.isEnteringVehicle = false
client.isDriving = false
client.currentVehicle = 0
client.target = nil
client.drivingStyle = 0

client.functions = {}

client.functions.loadLanguages = function(cb)
	local language = LoadResourceFile(GetCurrentResourceName(), '/lang/'..config.language..'.json')
    if language then
        jsonLanguage = json.decode(language)
        client.language = jsonLanguage[1]
    end
    if cb then
        cb(true)
    end
end

client.functions.isVehicleAllowed = function(modelHash)
    return config.allowedVehicles[modelHash]
end

client.functions.calculateDrivingStyle = function()
    local binaryValue = ''
    for i = 31, 1, -1 do
        local checked = config.drivingStyle[i].checked and 1 or 0
        binaryValue = binaryValue..checked
    end
    print(binaryValue)
    print(tonumber(binaryValue, 2))
    client.drivingStyle = tonumber(binaryValue, 2)
end

client.functions.isDriver = function(playerVehicle)
    local vehicleDriver = GetPedInVehicleSeat(playerVehicle, -1)
    if (vehicleDriver == 0) then
        config.showNotification(client.language['no_driver'])
        return false
    end
    return true
end

client.functions.startSelfDriving = function(playerPed, playerVehicle, waypointCoords)
    if DoesEntityExist(playerPed) and DoesEntityExist(playerVehicle) then
        client.currentVehicle = playerVehicle
        client.target = waypointCoords
        client.isDriving = true
        local locked = GetVehicleDoorLockStatus(client.currentVehicle)
        TaskVehicleDriveToCoord(playerPed, client.currentVehicle, client.target.x, client.target.y, client.target.z, config.drivingSpeed, 0, GetEntityModel(client.currentVehicl), client.drivingStyle, config.drivingDistanceStop)
        if locked ~= 2 then
            SetVehicleDoorsLocked(client.currentVehicle, 1)
        end
        config.showNotification(client.language['start_self_driving'])
        print('Start Self Driving')
    end
end

client.functions.stopSelfDriving = function(playerPed)
    if DoesEntityExist(playerPed) then
        if IsPedInAnyVehicle(playerPed, false) then
            local playerVehicle = GetVehiclePedIsIn(playerPed, false)
            ClearVehicleTasks(playerVehicle)
            SetVehicleBrake(playerVehicle, true)
            client.currentVehicle = 0
        end
        client.isDriving = false
        client.target = nil
        config.showNotification(client.language['stop_self_driving'])
        print('Stop Self Driving')
    end
end

client.functions.initialize = function()
    client.functions.loadLanguages(function()
        client.functions.calculateDrivingStyle()
    end)
end