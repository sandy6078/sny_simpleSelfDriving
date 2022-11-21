if (config.framework == 'qb') then
    QBCore = exports['qb-core']:GetCoreObject()
elseif (config.framework == 'esx') then
    ESX = exports['es_extended']:getSharedObject()
end

client.functions.initialize()

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
        client.playerPed = PlayerPedId()
        local forceStop = false
        local distanceInterval = 0
        client.isPlayerAlive = not IsEntityDead(client.playerPed)
        if not client.isInVehicle and client.isPlayerAlive then
            if DoesEntityExist(GetVehiclePedIsTryingToEnter(client.playerPed)) and not client.isEnteringVehicle then
                client.isEnteringVehicle = true
            elseif not DoesEntityExist(GetVehiclePedIsTryingToEnter(client.playerPed)) and not IsPedInAnyVehicle(client.playerPed, true) and client.isEnteringVehicle then
                client.isEnteringVehicle = false
            elseif IsPedInAnyVehicle(client.playerPed, false) then
                client.currentVehicle = GetVehiclePedIsIn(client.playerPed, false)
                client.isEnteringVehicle = false
                client.isInVehicle = true
            end
        elseif client.isInVehicle then
            if client.isDriving then
                if not client.functions.isDriver(client.currentVehicle) then
                    forceStop = true
                end
            end
            if not IsPedInAnyVehicle(client.playerPed, false) or not client.isPlayerAlive then
                forceStop = true
                client.isInVehicle = false
                client.currentVehicle = 0
                if client.isDriving then
                    client.functions.showNotification('left_vehicle', 'error')
                end
            end
        end
        if client.isDriving then
            if client.target then
                local playerCoords = GetEntityCoords(client.playerPed)
                local targetDistance = GetDistanceBetweenCoords(playerCoords, client.target, false)
                if not IsWaypointActive() then
                    forceStop = true
                    client.functions.showNotification('waypoint_not_active', 'error')
                    client.functions.playSound('error')
                end
                if (targetDistance < 31.0) then
                    client.functions.stopSelfDriving(client.playerPed, false)
                    client.functions.showNotification('destination_reached', 'success')
                    client.functions.playSound('destination_reached')
                elseif forceStop then
                    client.functions.stopSelfDriving(client.playerPed, true)
                end
            end
        end
    end
end)

RegisterCommand('toggleselfdriving', function()
    if DoesEntityExist(client.playerPed) then
        if IsPedInAnyVehicle(client.playerPed, false) then
            local playerVehicle = GetVehiclePedIsIn(client.playerPed, false)
            local vehicleModel = GetEntityModel(playerVehicle)
            if client.functions.isDriver(playerVehicle) then
                if (config.restrictVehicles and client.functions.isVehicleAllowed(vehicleModel)) or (not config.restrictVehicles) then
                    if client.isDriving then
                        client.functions.stopSelfDriving(client.playerPed, true)
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
                else
                    client.functions.showNotification('vehicle_not_allowed', 'error')
                    client.functions.playSound('error')
                end
            end
        end
    end
end, false)
RegisterKeyMapping('toggleselfdriving', 'Toggle Self Driving', 'keyboard', config.selfDrivingButton)
