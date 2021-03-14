ESX = nil
local playersHealing = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_ambulancejob:revive')
AddEventHandler('esx_ambulancejob:revive', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	--logi
	local org = xPlayer.job.name
	TriggerEvent('srp_logs:ambulanceHealLog',source,org,target,2)

	if xPlayer.job.name == 'ambulance' or xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'statepolice' then
		xPlayer.addMoney(Config.ReviveReward)
		TriggerClientEvent('esx_ambulancejob:revive', target)
		TriggerClientEvent('mythic_hospital:client:RemoveBleed', target)
		TriggerClientEvent('mythic_hospital:client:ResetLimbs', target)
	else
		print(('esx_ambulancejob: %s attempted to revive!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(target, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	--logi
	local type_num = nil
	if type == 'small' then
		type_num = 0
	elseif type == 'big' then
		type_num = 1
	end
	local org = xPlayer.job.name
	TriggerEvent('srp_logs:ambulanceHealLog',source,org,target,type_num)
	--koniec logów

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:heal', target, type)
		TriggerClientEvent('mythic_hospital:client:RemoveBleed', target)
		TriggerClientEvent('mythic_hospital:client:ResetLimbs', target)
	else
		print(('esx_ambulancejob: %s attempted to heal!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:putInVehicle', target)
	else
		print(('esx_ambulancejob: %s attempted to put in vehicle!'):format(xPlayer.identifier))
	end
end)

TriggerEvent('esx_phone:registerNumber', 'ambulance', _U('alert_ambulance'), true, true)

TriggerEvent('esx_society:registerSociety', 'ambulance', 'Ambulance', 'society_ambulance', 'society_ambulance', 'society_ambulance', {type = 'public'})

ESX.RegisterServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if Config.RemoveCashAfterRPDeath then
		if xPlayer.getMoney() > 0 then
			xPlayer.removeMoney(xPlayer.getMoney())
		end

		if xPlayer.getAccount('black_money').money > 0 then
			xPlayer.setAccountMoney('black_money', 0)
		end
	end

	if Config.RemoveItemsAfterRPDeath then
		for i=1, #xPlayer.inventory, 1 do
			if xPlayer.inventory[i].count > 0 then
				xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
			end
		end
	end

	local playerLoadout = {}
	if Config.RemoveWeaponsAfterRPDeath then
		for i=1, #xPlayer.loadout, 1 do
			xPlayer.removeWeapon(xPlayer.loadout[i].name)
		end
	else -- save weapons & restore em' since spawnmanager removes them
		for i=1, #xPlayer.loadout, 1 do
			table.insert(playerLoadout, xPlayer.loadout[i])
		end

		-- give back wepaons after a couple of seconds
		Citizen.CreateThread(function()
			Citizen.Wait(5000)
			for i=1, #playerLoadout, 1 do
				if playerLoadout[i].label ~= nil then
					xPlayer.addWeapon(playerLoadout[i].name, playerLoadout[i].ammo)
				end
			end
		end)
	end

	cb()
end)

if Config.EarlyRespawnFine then
	ESX.RegisterServerCallback('esx_ambulancejob:checkBalance', function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		local bankBalance = xPlayer.getAccount('bank').money

		cb(bankBalance >= Config.EarlyRespawnFineAmount)
	end)

	RegisterServerEvent('esx_ambulancejob:payFine')
	AddEventHandler('esx_ambulancejob:payFine', function()
		local xPlayer = ESX.GetPlayerFromId(source)
		local fineAmount = Config.EarlyRespawnFineAmount

		--TriggerClientEvent('esx:showNotification', xPlayer.source, _U('respawn_bleedout_fine_msg', ESX.Math.GroupDigits(fineAmount)))
		exports['mythic_notify']:DoCustomHudText('inform', 'Zabrano ' .. ESX.Math.GroupDigits(fineAmount) .. ' za leczenie medyczne', 4000)
		xPlayer.removeAccountMoney('bank', fineAmount)
	end)
end

ESX.RegisterServerCallback('esx_ambulancejob:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

ESX.RegisterServerCallback('esx_ambulancejob:buyJobVehicle', function(source, cb, vehicleProps, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)

	-- vehicle model not found
	if price == 0 then
		print(('esx_ambulancejob: %s attempted to exploit the shop! (invalid vehicle model)'):format(xPlayer.identifier))
		cb(false)
	else
		if xPlayer.getMoney() >= price then
			xPlayer.removeMoney(price)
	
			MySQL.Async.execute('INSERT INTO owned_vehicles (owner, vehicle, plate, type, job, `stored`) VALUES (@owner, @vehicle, @plate, @type, @job, @stored)', {
				['@owner'] = xPlayer.identifier,
				['@vehicle'] = json.encode(vehicleProps),
				['@plate'] = vehicleProps.plate,
				['@type'] = type,
				['@job'] = xPlayer.job.name,
				['@stored'] = true
			}, function (rowsChanged)
				cb(true)
			end)
		else
			cb(false)
		end
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:storeNearbyVehicle', function(source, cb, nearbyVehicles)
	local xPlayer = ESX.GetPlayerFromId(source)
	local foundPlate, foundNum

	for k,v in ipairs(nearbyVehicles) do
		local result = MySQL.Sync.fetchAll('SELECT plate FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = v.plate,
			['@job'] = xPlayer.job.name
		})

		if result[1] then
			foundPlate, foundNum = result[1].plate, k
			break
		end
	end

	if not foundPlate then
		cb(false)
	else
		MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = foundPlate,
			['@job'] = xPlayer.job.name
		}, function (rowsChanged)
			if rowsChanged == 0 then
				print(('esx_ambulancejob: %s has exploited the garage!'):format(xPlayer.identifier))
				cb(false)
			else
				cb(true, foundNum)
			end
		end)
	end

end)

function getPriceFromHash(hashKey, jobGrade, type)
	if type == 'helicopter' then
		local vehicles = Config.AuthorizedHelicopters[jobGrade]

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	elseif type == 'car' then
		local vehicles = Config.AuthorizedVehicles[jobGrade]

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	end

	return 0
end

RegisterServerEvent('esx_ambulancejob:removeItem')
AddEventHandler('esx_ambulancejob:removeItem', function(item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem(item, 1)

	if item == 'bandage' then
		TriggerClientEvent('mythic_hospital:client:RemoveBleed', source)
		TriggerClientEvent('mythic_hospital:client:ResetLimbs', source)
		--TriggerClientEvent('esx:showNotification', _source, _U('used_bandage'))
		exports['mythic_notify']:DoCustomHudText('inform', 'Użyłeś 1xBandaż!', 3000)
	elseif item == 'medkit' then
		TriggerClientEvent('mythic_hospital:client:RemoveBleed', source)
		TriggerClientEvent('mythic_hospital:client:ResetLimbs', source)
		--TriggerClientEvent('esx:showNotification', _source, _U('used_medkit'))
		exports['mythic_notify']:DoCustomHudText('inform', 'Użyłeś 1xApteczka!', 3000)
	elseif item == 'medikit' then
		TriggerClientEvent('mythic_hospital:client:RemoveBleed', source)
		TriggerClientEvent('mythic_hospital:client:ResetLimbs', source)
		--TriggerClientEvent('esx:showNotification', _source, _U('used_medikit'))
		exports['mythic_notify']:DoCustomHudText('inform', 'Użyłeś 1xDefibrylator!', 3000)
	elseif item == 'morphine' then
		TriggerClientEvent('mythic_hospital:client:RemoveBleed', source)
		TriggerClientEvent('mythic_hospital:client:ResetLimbs', source)
		exports['mythic_notify']:DoCustomHudText('inform', 'Użyłeś 1xMorfina!', 3000)
	elseif item == 'firstaid' then
		TriggerClientEvent('mythic_hospital:client:RemoveBleed', source)
		exports['mythic_notify']:DoCustomHudText('inform', 'Użyłeś 1xApteczka PP!', 3000)
	end
end)

RegisterServerEvent('esx_ambulancejob:giveItem')
AddEventHandler('esx_ambulancejob:giveItem', function(itemName)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'ambulance' then
		print(('esx_ambulancejob: %s attempted to spawn in an item!'):format(xPlayer.identifier))
		return
	elseif (itemName ~= 'medkit' and itemName ~= 'bandage' and itemName ~= 'medikit' and itemName ~= 'firstaid' and itemName ~= 'morphine' and itemName ~= 'radio' and itemName ~= 'water') then
		print(('esx_ambulancejob: %s attempted to spawn in an item!'):format(xPlayer.identifier))
		return
	end

	local xItem = xPlayer.getInventoryItem(itemName)
	local count = 1

	if xItem.limit ~= -1 then
		count = xItem.limit - xItem.count
	end

	if xItem.count < xItem.limit then
		xPlayer.addInventoryItem(itemName, 1)
	else
		--TriggerClientEvent('esx:showNotification', source, _U('max_item'))
		exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz mieć więcej przedmiotów przy sobie!', 4000)
	end
end)

TriggerEvent('es:addGroupCommand', 'revive', 'admin', function(source, args, user)
	if args[1] ~= nil then
		if GetPlayerName(tonumber(args[1])) ~= nil then
			--print(('esx_ambulancejob: %s użył revive'):format(GetPlayerName(source)[1]))
			TriggerClientEvent('esx_ambulancejob:revive', tonumber(args[1]))
			TriggerClientEvent('mythic_hospital:client:RemoveBleed', tonumber(args[1]))
			TriggerClientEvent('mythic_hospital:client:ResetLimbs', tonumber(args[1]))
		end
	else
		TriggerClientEvent('esx_ambulancejob:revive', source)
		TriggerClientEvent('mythic_hospital:client:RemoveBleed', source)
		TriggerClientEvent('mythic_hospital:client:ResetLimbs', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, { help = _U('revive_help'), params = {{ name = 'id' }} })

ESX.RegisterUsableItem('medkit', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('medkit', 1)
	
		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'medkit')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterUsableItem('medikit', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		--xPlayer.removeInventoryItem('medikit', 1)
	
		--playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'medikit')
		TriggerClientEvent('mythic_hospital:client:RemoveBleed', source)
		TriggerClientEvent('mythic_hospital:client:ResetLimbs', source)

		--Citizen.Wait(10000)
		--playersHealing[source] = nil
	end
end)

ESX.RegisterUsableItem('bandage', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('bandage', 1)
	
		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'bandage')
		TriggerClientEvent('mythic_hospital:client:RemoveBleed', source)
		TriggerClientEvent('mythic_hospital:client:ResetLimbs', source)

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterUsableItem('morphine', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('morphine', 1)
	
		--playersHealing[source] = true
		TriggerClientEvent('mythic_hospital:items:morphine', source, 'morphine')
		TriggerClientEvent('mythic_hospital:client:RemoveBleed', source)
		TriggerClientEvent('mythic_hospital:client:ResetLimbs', source)

		--Citizen.Wait(10000)
		--playersHealing[source] = nil
	end
end)

ESX.RegisterUsableItem('firstaid', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('firstaid', 1)
	
		--playersHealing[source] = true
		TriggerClientEvent('mythic_hospital:items:firstaid', source, 'firstaid')
		TriggerClientEvent('mythic_hospital:client:RemoveBleed', source)
		TriggerClientEvent('mythic_hospital:client:ResetLimbs', source)

		--Citizen.Wait(10000)
		--playersHealing[source] = nil
	end
end)


ESX.RegisterServerCallback('esx_ambulancejob:getDeathStatus', function(source, cb)
	local identifier = GetPlayerIdentifiers(source)[1]

	MySQL.Async.fetchScalar('SELECT is_dead FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(isDead)
		if isDead then
			print(('esx_ambulancejob: %s attempted combat logging!'):format(identifier))
		end

		cb(isDead)
	end)
end)

RegisterServerEvent('esx_ambulancejob:setDeathStatus')
AddEventHandler('esx_ambulancejob:setDeathStatus', function(isDead)
	local identifier = GetPlayerIdentifiers(source)[1]

	if type(isDead) ~= 'boolean' then
		print(('esx_ambulancejob: %s attempted to parse something else than a boolean to setDeathStatus!'):format(identifier))
		return
	end

	MySQL.Sync.execute('UPDATE users SET is_dead = @isDead WHERE identifier = @identifier', {
		['@identifier'] = identifier,
		['@isDead'] = isDead
	})
end)

TriggerEvent('es:addCommand', 'ulecz', function(source, args, user)
	-- print('revive by /revive')
	 local xPlayer = ESX.GetPlayerFromId(source)
	 local xPJob = xPlayer.getJob()
	 
	 if(xPJob.name == "police" or xPJob.name == "ambulance" or xPJob.name == "sheriff" or xPJob.name == "statepolice") then
		 if args[1] ~= nil then
			 local xTarget = ESX.GetPlayerFromId(args[1])
			 TriggerEvent("esx:revivealert",source,"Używa /ulecz na " .. xTarget.name)
		   TriggerClientEvent('esx_ambulancejob:revive2', tonumber(args[1]), xPlayer.source)
		   TriggerClientEvent('mythic_hospital:client:RemoveBleed', tonumber(args[1]), xPlayer.source)
		   TriggerClientEvent('mythic_hospital:client:ResetLimbs', tonumber(args[1]), xPlayer.source)
		 else
		   TriggerEvent("esx:revivealert",source,"Używa /ulecz na sobie")
		   TriggerClientEvent('esx_ambulancejob:revive', source)
		   TriggerClientEvent('mythic_hospital:client:RemoveBleed', source)
		   TriggerClientEvent('mythic_hospital:client:ResetLimbs', source)
		 end
	 end
   end)

   RegisterServerEvent('esx_ambulancejob:reviv')
   AddEventHandler('esx_ambulancejob:reviv', function(src, state)
   
	 local _source = source
	 local xPlayer = ESX.GetPlayerFromId(_source)
	 local xTarget = ESX.GetPlayerFromId(src)
	 
	 if(state == false) then
	   TriggerClientEvent("esx:showNotification", xTarget.source, "Tej osoby nie ma w pobliżu!")
	 else
	   TriggerClientEvent('esx_ambulancejob:revive', xPlayer.source)
	   TriggerClientEvent('mythic_hospital:client:RemoveBleed',  xPlayer.source)
	   TriggerClientEvent('mythic_hospital:client:ResetLimbs',  xPlayer.source)
	 end
   
   end)

-- Tools Station 7
RegisterServerEvent('esx_ambulancejob:givehammer') 
AddEventHandler('esx_ambulancejob:givehammer', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addWeapon('WEAPON_HAMMER', 1)
end)

RegisterServerEvent('esx_ambulancejob:fireextinguisher') 
AddEventHandler('esx_ambulancejob:fireextinguisher', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addWeapon('WEAPON_FIREEXTINGUISHER', 5000)
end)

RegisterServerEvent('esx_ambulancejob:givecrowbar') 
AddEventHandler('esx_ambulancejob:givecrowbar', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addWeapon('WEAPON_CROWBAR', 1)
end)

RegisterServerEvent('esx_ambulancejob:giveflashlight') 
AddEventHandler('esx_ambulancejob:giveflashlight', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addWeapon('WEAPON_FLASHLIGHT', 1)
end)