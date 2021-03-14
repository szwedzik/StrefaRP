ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function getIdentity(identifier)
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],	
			sex = identity['sex'],
			height = identity['height'],
			job = identity['job']
		}
	else
		return nil
	end
end

function getVehicleInfo(plates)
	local result = MySQL.Sync.fetchAll("SELECT * FROM owned_vehicles")
	
	for i=1, #result, 1 do
		
		if(result[i] ~= nil) then
			local ident = result[i]
			local info  = json.decode(ident['vehicle'])
			
			if(info ~= nil) then
				if(info.plate == plates) then
					return {plate = info.plate, model = info.model, owner = ident['owner']}
				end
			else
				return nil
			end
		else
			return nil
		end
	
	end
	
	return nil
end

function getVehicleInfoSteam(plates, steamid)
	local result = MySQL.Sync.fetchAll("SELECT * FROM owned_vehicles WHERE `identifier` = @steam", {['@steam'] = steamid})
	
	for i=1, #result, 1 do
		
		if(result[i] ~= nil) then
			local ident = result[i]
			local info  = json.decode(ident['vehicle'])
			
			if(info ~= nil) then
				if(info.plate == plates) then
					return {plate = info.plate, model = info.model, owner = ident['owner']}
				end
			else
				return nil
			end
		else
			return nil
		end
	
	end
	
	return nil
end

TriggerEvent('es:addCommand', 'pojazd', function(source, args, user)
	CheckPlates(source, args[1])
end)

RegisterServerEvent('policeplates:quickCheck')
AddEventHandler('policeplates:quickCheck', function(arg)
	local _source = source
	CheckPlates(_source, arg)
end)

function CheckPlates(_source, arg)
	local xPlayer = ESX.GetPlayerFromId(_source)
	arg = string.upper(arg)
	if xPlayer ~= nil and (xPlayer.getJob().name == "police" or xPlayer.getJob().name == "statepolice" or xPlayer.getJob().name == "sheriff" or xPlayer.getJob().name == "zwierzako") then
		TriggerClientEvent("plates:showInfo", _source, 'Szukanie pojazdu Nr. ~b~' .. arg, nil)
		local veh = getVehicleInfo(arg)
		Wait(6000)
		if veh ~= nil and getIdentity(veh.owner) ~= nil then
			local name = getIdentity(veh.owner).firstname .. " " .. getIdentity(veh.owner).lastname
			TriggerClientEvent("plates:showInfo", _source, '~b~Właściciel: ~w~' .. name .. '\n~b~Nr. rej: ~w~' .. veh.plate, veh.model)
		else
			TriggerClientEvent("plates:showInfo", _source, 'Pojazd Nr. ~b~' .. arg .. '~w~ został ~r~skradziony~w~ o godz. ' .. os.date("%X"), nil)
		end
	end
end