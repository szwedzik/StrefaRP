ESX              = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)

  local xPlayer = ESX.GetPlayerFromId(source)
    
end)


ESX.RegisterServerCallback('netr_garages:getOwnedVehicles', function (source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)

  MySQL.Async.fetchAll(
    'SELECT * FROM owned_vehicles WHERE owner = @owner',
    { ['@owner'] = xPlayer.identifier },
    function (result)
      local vehicles = {}

      for i=1, #result, 1 do
        local vehicleData = json.decode(result[i].vehicle)
        table.insert(vehicles, vehicleData)
      end

      cb(vehicles)
    end)
end)

ESX.RegisterServerCallback('netr_garages:getOwnedVehiclesOut', function (source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  MySQL.Async.fetchAll(
    'SELECT * FROM owned_vehicles WHERE owner = @owner AND (state = 0 OR state = 2)',
    { ['@owner'] = xPlayer.identifier },
    function (result)
      local vehicles = {}

      for i=1, #result, 1 do
        local vehicleData = json.decode(result[i].vehicle)
        table.insert(vehicles, vehicleData)
      end

      cb(vehicles)
    end)
end)

local vehhash
RegisterServerEvent("srp_garage:hahscheck")
AddEventHandler("srp_garage:hahscheck", function(vvehhash)
	vehhash = vvehhash
end)

ESX.RegisterServerCallback('netr_garages:checkIfVehicleIsOwned', function (source, cb, model, plate, ppid)
  local xPlayer = ESX.GetPlayerFromId(source)
  local found = nil
  local vehicleData = nil
	if plate == nil then
		plate = model
	end
  MySQL.Async.fetchAll(
    'SELECT * FROM owned_vehicles WHERE owner = @owner',
    { ['@owner'] = xPlayer.identifier },
    function (result)
      local vehicles = {}
      for i=1, #result, 1 do
        vehicleData = json.decode(result[i].vehicle)
		if vehicleData.model == vehhash or vehicleData.plate == plate then
			--if vehicleData.plate == plate then
				found = true
				cb(vehicleData)
				break
			--end
		else
			if i == #result then
			print("Uzycie cheatengine przez: "..xPlayer.identifier.." id "..source)
			--print("ID: "..ppid)
			--TriggerEvent("srp_anticheat:AutoBan", xPlayer.identifier)
			--cb(nil)
			end
		end
	  end

	  if not found then
        cb(nil)
	  end
	  
    end)
end)

RegisterServerEvent('netr_garages:updateOwnedVehicle')
AddEventHandler('netr_garages:updateOwnedVehicle', function(vehicleProps, modelName)
 
 	local _source = source
 	local xPlayer = ESX.GetPlayerFromId(source)
 
 	MySQL.Async.fetchAll(
 		'SELECT * FROM owned_vehicles WHERE owner = @owner',
 		{
 			['@owner'] = xPlayer.identifier
 		},
 		function(result)
 
 			local foundVehicleId = nil
 
 			for i=1, #result, 1 do
 				
 				local vehicle = json.decode(result[i].vehicle)
 				
 				if vehicle.plate == vehicleProps.plate then
 					foundVehicleId = result[i].id
 					break
 				end
 
 			end
 
 			if foundVehicleId ~= nil then
 				MySQL.Async.execute(
 					'UPDATE owned_vehicles SET vehicle = @vehicle, modelName = @modelName WHERE id = @id',
 					{
						['@vehicle'] = json.encode(vehicleProps),
						['@modelName']   = modelName,
						['@id']      = foundVehicleId
 					}
 				)
 
 			end
 
 		end
 	)
 end)


RegisterServerEvent('netr_garages:addCarToParking')
AddEventHandler('netr_garages:addCarToParking', function(vehicleProps)

	local xPlayer = ESX.GetPlayerFromId(source)

	if vehicleProps ~= nil then
		
		MySQL.Async.fetchAll(
		'SELECT * FROM `user_parkings` WHERE `identifier` = @identifier AND plate = @plate LIMIT 1',
		{
			['@identifier'] = xPlayer.identifier,
			['@plate'] = vehicleProps.plate
		},
		function(result)
			if result[1] ~= nil then
			else
				MySQL.Async.execute("UPDATE owned_vehicles SET state = 1 WHERE plate = @plate", {
					['@plate'] = vehicleProps.plate
				})
				MySQL.Async.execute(
				'INSERT INTO `user_parkings` (`identifier`, `plate`, `vehicle`) VALUES (@identifier, @plate, @vehicle)',
				{
					['@identifier']   = xPlayer.identifier,
					['@plate']        = vehicleProps.plate,
					['@vehicle']      = json.encode(vehicleProps)
				}, function(rowsChanged)
					--TriggerClientEvent('mythic_notify:client:SendJobAlert', xPlayer.source, { type = 'inform', text = 'Pojazd został schowany do garażu', lenght=3500 })
					--TriggerClientEvent('esx:showNotification', xPlayer.source, _U('veh_stored'))
				end)
			end
		end)
		MySQL.Async.execute('DELETE n1 FROM user_parkings n1, user_parkings n2 WHERE n1.id > n2.id AND n1.plate = n2.plate',{})

	end

end)

RegisterServerEvent('netr_garages:removeCarFromParking')
AddEventHandler('netr_garages:removeCarFromParking', function(plate)

	local xPlayer = ESX.GetPlayerFromId(source)

	if plate ~= nil then
		
		MySQL.Async.execute("UPDATE owned_vehicles SET state = 0 WHERE plate = @plate", {
			['@plate'] = plate
		})
		MySQL.Async.execute(
			'DELETE FROM `user_parkings` WHERE `identifier` = @identifier AND `plate` = @plate',
			{
				['@identifier'] = xPlayer.identifier,
        ['@plate'] = plate
			}, function(rowsChanged)
				TriggerClientEvent('mythic_notify:client:SendJobAlert', xPlayer.source, { type = 'inform', text = 'Pojazd został wyciągnięty!', lenght=3500 })
				--TriggerClientEvent('esx:showNotification', xPlayer.source, _U('veh_released'))
			end
		)

	end

end)


RegisterServerEvent('netr_garages:getCustomPlate')
AddEventHandler('netr_garages:getCustomPlate', function(plate)

	local xPlayer = ESX.GetPlayerFromId(source)

	if plate ~= nil then

    MySQL.Async.fetchAll(
      'SELECT `plate_name` FROM custom_plate WHERE original_plate = @plate',
      {
        ['@plate'] = plate
      },
      function(result)
        return result[1].plate_name
    end)

	end

end)

local oldV = {}
ESX.RegisterServerCallback('netr_garages:getVehiclesInGarage', function(source, cb)

	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll(
		'SELECT * FROM `user_parkings` WHERE `identifier` = @identifier',
		{
			['@identifier'] = xPlayer.identifier
		},
		function(result)

			local vehicles = {}

			for i=1, #result, 1 do
				local vehicleData = json.decode(result[i].vehicle)
				table.insert(vehicles, vehicleData)
			end
			cb(vehicles)
		end)
end)

--[[ runs everytime the server is restarted]]
--[[ 

  adds all user owned cars into the parking garage table so people can pull their cars out

]]
function parkAllOwnedVehicles()

  MySQL.ready(function ()

    MySQL.Sync.execute(
      'DELETE FROM `user_parkings`',
      {
      }, function(rowsChanged)
      end
    )


    local result = MySQL.Sync.fetchAll(
      'SELECT * FROM owned_vehicles',
      {})

    local foundVehicleId = nil

    for i=1, #result, 1 do
    
      local vehicle = result[i].vehicle
      local identifier = result[i].owner

      MySQL.Sync.execute(
        'INSERT INTO `user_parkings` (`identifier`, `plate`, `vehicle`) VALUES (@identifier, @plate, @vehicle)',
        {
          ['@identifier'] = identifier,
          ['@plate'] = json.decode(vehicle).plate,
          ['@vehicle']     = vehicle
        })

    end
    
  end)


end

parkAllOwnedVehicles()
