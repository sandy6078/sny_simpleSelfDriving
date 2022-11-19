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
                    config.showNotification(client.language['left_vehicle'])
                end
            end
        end
        if client.isDriving then
            if not IsWaypointActive() then
                forceStop = true
                config.showNotification(client.language['waypoint_not_active'])
            end
            if client.target then
                local playerCoords = GetEntityCoords(client.playerPed)
                local targetDistance = GetDistanceBetweenCoords(playerCoords, client.target, false)
                print(targetDistance)
                if (targetDistance < 10.0) or forceStop then
                    client.functions.stopSelfDriving(client.playerPed)
                    config.showNotification(client.language['destination_reached'])
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
                        client.functions.stopSelfDriving(client.playerPed)
                    else
                        if IsWaypointActive() then
                            local waypoint = GetFirstBlipInfoId(8)
                            local waypointCoords = GetBlipInfoIdCoord(waypoint)
                            client.functions.startSelfDriving(client.playerPed, playerVehicle, waypointCoords)
                        else
                            config.showNotification(client.language['waypoint_not_active'])
                        end
                    end 
                else
                    config.showNotification(client.language['vehicle_not_allowed'])
                end
            end
        end
    end
end, false)
RegisterKeyMapping('toggleselfdriving', 'Toggle Self Driving', 'keyboard', config.selfDrivingButton)
