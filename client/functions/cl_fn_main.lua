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

client.functions.isVehicleAllowed = function(modelHash)
    return config.allowedVehicles[modelHash]
end

client.functions.calculateDrivingStyle = function()
    local binaryValue = ''
    for i = 31, 1, -1 do
        local checked = config.drivingStyle[i] and 1 or 0
        binaryValue = binaryValue..checked
    end
    client.drivingStyle = tonumber(binaryValue, 2)
end

client.functions.isDriver = function(playerVehicle)
    local vehicleDriver = GetPedInVehicleSeat(playerVehicle, -1)
    if (vehicleDriver == 0) then
        client.functions.showNotification('no_driver', 'error')
        return false
    end
    return true
end

client.functions.playSound = function(soundName)
    SendNUIMessage({
        action = 'play_sound',
        type = soundName
    })
end

client.functions.showNotification = function(message, messageType)
    if client.language[message] then
        config.showNotification(client.language[message], messageType)
    else
        config.showNotification(client.language['missing_translation']..' : '..message, messageType)
        client.functions.playSound('error')
    end
end

client.functions.startSelfDriving = function(playerPed, playerVehicle, waypointCoords, playSound)
    if DoesEntityExist(playerPed) and DoesEntityExist(playerVehicle) then
        client.currentVehicle = playerVehicle
        client.target = waypointCoords
        client.isDriving = true
        local locked = GetVehicleDoorLockStatus(client.currentVehicle)
        TaskVehicleDriveToCoord(playerPed, client.currentVehicle, client.target.x, client.target.y, client.target.z, config.drivingSpeed, 0, GetEntityModel(client.currentVehicl), client.drivingStyle, config.drivingDistanceStop)
        if locked ~= 2 then
            SetVehicleDoorsLocked(client.currentVehicle, 1)
        end
        client.functions.showNotification('start_self_driving', 'success')
        if playSound then
            client.functions.playSound('enable')
        end
    end
end

client.functions.stopSelfDriving = function(playerPed, brake, playSound)
    if DoesEntityExist(playerPed) then
        if IsPedInAnyVehicle(playerPed, false) then
            local playerVehicle = GetVehiclePedIsIn(playerPed, false)
            ClearVehicleTasks(playerVehicle)
            if brake then
                Citizen.CreateThread(function()
                    while not IsVehicleStopped(playerVehicle) do
                        Citizen.Wait(0)
                        SetVehicleBrake(playerVehicle, true)
                        SetVehicleHandbrake(playerVehicle, true)
                    end
                    SetVehicleBrake(playerVehicle, false)
                    SetVehicleHandbrake(playerVehicle, false)
                end)
            end
            client.currentVehicle = 0
        end
        client.isDriving = false
        client.target = nil
        client.functions.showNotification('stop_self_driving', 'error')
        if playSound then
            client.functions.playSound('disable')
        end
    end
end

client.functions.openSelfDriveMenu = function(owned, favourite, histor)
    --ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_MP_PAUSE', true, -1))
    --[[
    if client.isDriving then
        client.functions.stopSelfDriving(client.playerPed, false, true)
    else
        if IsWaypointActive() then
            local waypoint = GetFirstBlipInfoId(8)
            local waypointCoords = GetBlipInfoIdCoord(waypoint)
            client.functions.startSelfDriving(client.playerPed, playerVehicle, waypointCoords, true)
        else
            client.functions.showNotification('waypoint_not_active', 'error')
            client.functions.playSound('error')
        end
    end
    ]]--
end

client.functions.initialize = function()
    shared.functions.loadLanguages(function(language)
        client.language = language
        client.functions.calculateDrivingStyle()
    end)
end