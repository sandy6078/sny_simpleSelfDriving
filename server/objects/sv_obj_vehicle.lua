server.functions.createVehicleObject = function(id, plate, owned, favourite, history)
    local self = {}

    self.id = id
    self.plate = plate
    self.owned = owned
    self.favourite = favourite
    self.history = history
    self.functions = {}

    self.functions.getId = function()
        return self.id
    end

    self.functions.getPlate = function()
        return self.plate
    end
    
    self.functions.getOwned = function()
        return self.owned
    end

    self.functions.setOwned = function(newOwned)
        self.owned = newOwned
    end

    self.functions.getFavourite = function()
        return self.favourite
    end

    self.functions.setFavourite = function(newFavourite)
        self.favourite = newFavourite
    end

    self.functions.addFavourite = function(id, name, distance, data)
        self.favourite[tostring(id)] = {
            id = id,
            name = name,
            distance = distance,
            data = data
        }
    end

    self.functions.removeFavourite = function(id)
        if self.favourite[tostring(id)] then
            self.favourite[tostring(id)] = nil
        end
    end

    self.functions.getHistory = function()
        return self.history
    end

    self.functions.setHistory = function(newHistory)
        self.history = newHistory
    end

    self.functions.addHistory = function(id, data, distanceTotal, distanceTraveled, date)
        self.history[tostring(id)] = {
            id = id,
            data = data,
            distanceTotal = distanceTotal,
            distanceTraveled = distanceTraveled,
            date = date
        }
    end

    self.functions.removeHistory = function(id)
        if self.history[tostring(id)] then
            self.history[tostring(id)] = nil
        end
    end

    return self
end