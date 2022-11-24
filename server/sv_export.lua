exports('getVehicles', function()
	return server.functions.getVehicles()
end)

exports('getVehicleById', function(id)
	return server.functions.getVehicleById(id)
end)

exports('getVehicleByPlate', function(plate)
	return server.functions.getVehicleByPlate(plate)
end)

exports('addVehicle', function(plate, owned, favourite, history)
	return server.functions.addVehicle(plate, owned, favourite, history)
end)

exports('addVehicleToDatabase', function(plate, favourite, history, cb)
	return server.functions.addVehicleToDatabase(plate, favourite, history, cb)
end)