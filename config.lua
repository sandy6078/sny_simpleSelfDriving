config = {}

config.language = 'eng' -- name of the language file to use

config.framework = 'qb' -- qb, esx, or none (currently only used for notifications)

config.selfDrivingButton = 'U' -- button to toggle on self driving

config.drivingSpeed = 30.0 -- speed at which the car will travel
config.drivingDistanceStop = 10.0 -- distance from the target where self dricing will disable

-- Thanks to TomGrobbe for his work on https://vespura.com/fivem/drivingstyle/; I was able to understand the flags
config.drivingStyle = {
    [1] = true, -- Stop before vehicles
    [2] = true, -- Stop before peds
    [3] = false, -- Avoid vehicles
    [4] = true, -- Avoid empty vehicles
    [5] = true, -- Avoid peds
    [6] = true, -- Avoid objects
    [7] = false, -- Unknown
    [8] = true, -- Stop at traffic lights
    [9] = true, -- Use blinkers
    [10] = false, -- Allow going wrong way (only does it if the correct lane is full, will try to reach the correct lane again a.s.a.p.)
    [11] = false, -- Drive in reverse gear
    [12] = false, -- Unknown
    [13] = false, -- Unknown
    [14] = false, -- Unknown
    [15] = false, -- Unknown
    [16] = false, -- Unknown
    [17] = false, -- Unknown
    [18] = false, -- Unknown
    [19] = true, -- Take shortest path (Removes most pathing limits, the driver even goes on dirt roads)
    [20] = true, -- Reckless (Previously named: Allow overtaking vehicles if possible)
    [21] = false, -- Unknown
    [22] = false, -- Unknown
    [23] = false, -- Ignore roads (Uses local pathing, only works within 200~ meters around the player)
    [24] = false, -- Unknown
    [25] = false, -- Ignore all pathing (Goes straight to destination)
    [26] = false, -- Unknown
    [27] = false, -- Unknown
    [28] = false, -- Unknown
    [29] = false, -- Unknown
    [30] = false, -- Avoid highways when possible (will use the highway if there is no other way to get to the destination)
    [31] = false -- Unknown
}

config.restrictVehicles = true -- will restrict usage of self driving onlu to allowed vehicles listed below

-- list of vehicles which self driving will work for (only works if restrictVehicles is set to true)
config.allowedVehicles = {
    [GetHashKey('cyclone')] = true,
    [GetHashKey('raiden')] = true,
    [GetHashKey('voltic')] = true,
    [GetHashKey('omnisegt')] = true,
    [GetHashKey('imorgon')] = true,
    [GetHashKey('tezeract')] = true
}

config.showNotification = function(message, messageType)
    -- add your notification resource function to show messages here
    -- message args is a string
    if (config.framework == 'qb') then
        QBCore.Functions.Notify(message, messageType, 2500)
    elseif (config.framework == 'esx') then
        ESX.ShowNotification(message, messageType, 2500)
    end
end