exports('getVehicles', function()
	return server.functions.getVehicles()
end)

exports('getVehicleById', function(id)
	return server.functions.getVehicleById(id)
end)

exports('getVehicleByPlate', function(plate)
	return server.functions.getVehicleByPlate(plate)
end)
