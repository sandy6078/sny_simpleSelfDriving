config = {}

config.language = 'eng' -- name of the language file to use

config.selfDrivingButton = 'U' -- button to toggle on self driving

config.drivingSpeed = 30.0 -- speed at which the car will travel
config.drivingDistanceStop = 10.0 -- distance from the target where self dricing will disable

-- Thanks to TomGrobbe for his work on https://vespura.com/fivem/drivingstyle/; I was able to understand the flags
config.drivingStyle = {
    [1] = {label = 'Stop before vehicles', checked = true},
    [2] = {label = 'Stop before peds', checked = true},
    [3] = {label = 'Avoid vehicles', checked = false},
    [4] = {label = 'Avoid empty vehicles', checked = true},
    [5] = {label = 'Avoid peds', checked = true},
    [6] = {label = 'Avoid objects', checked = true},
    [7] = {label = 'Unknown', checked = false},
    [8] = {label = 'Stop at traffic lights', checked = true},
    [9] = {label = 'Use blinkers', checked = true},
    [10] = {label = 'Allow going wrong way (only does it if the correct lane is full, will try to reach the correct lane again a.s.a.p.)', checked = false},
    [11] = {label = 'Drive in reverse gear', checked = false},
    [12] = {label = 'Unknown', checked = false},
    [13] = {label = 'Unknown', checked = false},
    [14] = {label = 'Unknown', checked = false},
    [15] = {label = 'Unknown', checked = false},
    [16] = {label = 'Unknown', checked = false},
    [17] = {label = 'Unknown', checked = false},
    [18] = {label = 'Unknown', checked = false},
    [19] = {label = 'Take shortest path (Removes most pathing limits, the driver even goes on dirt roads)', checked = true},
    [20] = {label = 'Reckless (Previously named: Allow overtaking vehicles if possible)', checked = true},
    [21] = {label = 'Unknown', checked = false},
    [22] = {label = 'Unknown', checked = false},
    [23] = {label = 'Ignore roads (Uses local pathing, only works within 200~ meters around the player)', checked = false},
    [24] = {label = 'Unknown', checked = false},
    [25] = {label = 'Ignore all pathing (Goes straight to destination)', checked = false},
    [26] = {label = 'Unknown', checked = false},
    [27] = {label = 'Unknown', checked = false},
    [28] = {label = 'Unknown', checked = false},
    [29] = {label = 'Unknown', checked = false},
    [30] = {label = 'Avoid highways when possible (will use the highway if there is no other way to get to the destination)', checked = false},
    [31] = {label = 'Unknown', checked = false}
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

config.showNotification = function(message)
    -- add your notification resource function to show messages here
    -- message args is a string
    print(message)
end