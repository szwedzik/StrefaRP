ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local timeInJail = {}

if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'statepolice', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'statepolice', _U('alert_police'), true, true)
TriggerEvent('esx_society:registerSociety', 'statepolice', 'StatePolice', 'society_statepolice', 'society_statepolice', 'society_statepolice', {type = 'public'})

RegisterServerEvent('srp_statepolicejob:confiscatePlayerItem')
AddEventHandler('srp_statepolicejob:confiscatePlayerItem', function(target, itemType, itemName, amount)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	TriggerEvent("esx_discord_bot:confiscatePlayerItemLog", '[' .. _source .. ' | ' .. sourceXPlayer.identifier .. ' | ' .. sourceXPlayer.name .. '] przeszukuje [' .. target .. ' | ' .. targetXPlayer.identifier .. ' | ' .. targetXPlayer.name .. ']')

	if itemType == 'item_standard' then
		local targetItem = targetXPlayer.getInventoryItem(itemName)
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)

		-- does the target player have enough in their inventory?
		if targetItem.count > 0 and targetItem.count <= amount then
		
			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + amount) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
			else
				targetXPlayer.removeInventoryItem(itemName, amount)
				sourceXPlayer.addInventoryItem   (itemName, amount)
				TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated', amount, sourceItem.label, targetXPlayer.name))
				TriggerClientEvent('esx:showNotification', target,  _U('got_confiscated', amount, sourceItem.label, sourceXPlayer.name))
				TriggerEvent("esx_discord_bot:confiscatePlayerItemLog", '[' .. _source .. ' | ' .. sourceXPlayer.identifier .. ' | ' .. sourceXPlayer.name .. '] przeszukuje [' .. target .. ' | ' .. targetXPlayer.identifier .. ' | ' .. targetXPlayer.name .. '] i zabiera mu x' .. amount .. ' ' .. itemName)

			end
		else
			TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
		end

	elseif itemType == 'item_account' then
		targetXPlayer.removeAccountMoney(itemName, amount)
		sourceXPlayer.addAccountMoney   (itemName, amount)

		TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated_account', amount, itemName, targetXPlayer.name))
		TriggerClientEvent('esx:showNotification', target,  _U('got_confiscated_account', amount, itemName, sourceXPlayer.name))
		TriggerEvent("esx_discord_bot:confiscatePlayerItemLog", '[' .. _source .. ' | ' .. sourceXPlayer.identifier .. ' | ' .. sourceXPlayer.name .. '] przeszukuje [' .. target .. ' | ' .. targetXPlayer.identifier .. ' | ' .. targetXPlayer.name .. '] i zabiera mu x' .. amount .. ' ' .. itemName)

	elseif itemType == 'item_weapon' then
		if amount == nil then amount = 0 end
		targetXPlayer.removeWeapon(itemName, amount)
		sourceXPlayer.addWeapon   (itemName, amount)

		TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated_weapon', ESX.GetWeaponLabel(itemName), targetXPlayer.name, amount))
		TriggerClientEvent('esx:showNotification', target,  _U('got_confiscated_weapon', ESX.GetWeaponLabel(itemName), amount, sourceXPlayer.name))
		TriggerEvent("esx_discord_bot:confiscatePlayerItemLog", '[' .. _source .. ' | ' .. sourceXPlayer.identifier .. ' | ' .. sourceXPlayer.name .. '] przeszukuje [' .. target .. ' | ' .. targetXPlayer.identifier .. ' | ' .. targetXPlayer.name .. '] i zabiera mu x' .. amount .. ' ' .. itemName)
	end
end)

RegisterServerEvent('srp_statepolicejob:handcuff')
AddEventHandler('srp_statepolicejob:handcuff', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	local tPlayer = ESX.GetPlayerFromId(target)
	TriggerClientEvent('srp_statepolicejob:handcuff', target)
	TriggerClientEvent('srp_statepolicejob:playAnim', source, 'mp_arresting', 'a_uncuff')
	TriggerClientEvent('srp_statepolicejob:playAnim', target, 'mp_arresting', 'b_uncuff')
	TriggerEvent("esx_discord_bot:log", 'SKUCIE', '[' .. xPlayer.source .. ' | ' .. xPlayer.identifier .. ' | ' .. xPlayer.name .. '] skuwa ' .. '[' .. tPlayer.source .. ' | ' .. tPlayer.identifier .. ' | ' .. tPlayer.name .. ']')
end)

RegisterServerEvent('srp_statepolicejob:drag')
AddEventHandler('srp_statepolicejob:drag', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('srp_statepolicejob:drag', target, source)
end)

RegisterServerEvent('srp_statepolicejob:putInVehicle')
AddEventHandler('srp_statepolicejob:putInVehicle', function(target)
	--TriggerClientEvent('esx:showNotification', source, 'poszo na '..target)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('srp_statepolicejob:putInVehicle', target)
end)

RegisterServerEvent('srp_statepolicejob:OutVehicle')
AddEventHandler('srp_statepolicejob:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('srp_statepolicejob:OutVehicle', target)
end)

RegisterServerEvent('srp_statepolicejob:getStockItem')
AddEventHandler('srp_statepolicejob:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_sheriff', function(inventory)

		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then
		
			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, _U('have_withdrawn', count, inventoryItem.label))
			end
		else
			TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
		end
	end)

end)

RegisterServerEvent('srp_statepolicejob:putStockItems')
AddEventHandler('srp_statepolicejob:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_sheriff', function(inventory)

		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited', count, inventoryItem.label))
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end

	end)

end)

ESX.RegisterServerCallback('srp_statepolicejob:getOtherPlayerData', function(source, cb, target)

	if Config.EnableESXIdentity then

		local xPlayer = ESX.GetPlayerFromId(target)

		local result = MySQL.Sync.fetchAll('SELECT firstname, lastname, sex, dateofbirth, height FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		})

		local firstname = result[1].firstname
		local lastname  = result[1].lastname
		local sex       = result[1].sex
		local dob       = result[1].dateofbirth
		local height    = result[1].height

		local data = {
			name      = GetPlayerName(target),
			job       = xPlayer.job,
			inventory = xPlayer.inventory,
			accounts  = xPlayer.accounts,
			weapons   = xPlayer.loadout,
			firstname = firstname,
			lastname  = lastname,
			sex       = sex,
			dob       = dob,
			height    = height
		}

		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
			if status ~= nil then
				data.drunk = math.floor(status.percent)
			end
		end)

		if Config.EnableLicenses then
			TriggerEvent('esx_license:getLicenses', target, function(licenses)
				data.licenses = licenses
				cb(data)
			end)
		else
			cb(data)
		end

	else

		local xPlayer = ESX.GetPlayerFromId(target)

		local data = {
			name       = GetPlayerName(target),
			job        = xPlayer.job,
			inventory  = xPlayer.inventory,
			accounts   = xPlayer.accounts,
			weapons    = xPlayer.loadout
		}

		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
			if status ~= nil then
				data.drunk = math.floor(status.percent)
			end
		end)

		TriggerEvent('esx_license:getLicenses', target, function(licenses)
			data.licenses = licenses
		end)

		cb(data)

	end

end)

ESX.RegisterServerCallback('srp_statepolicejob:getArmoryWeapons', function(source, cb)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_sheriff', function(store)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		cb(weapons)
	end)

end)

ESX.RegisterServerCallback('srp_statepolicejob:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)

	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
	end

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_sheriff', function(store)

		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = weapons[i].count + 1
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 1
			})
		end

		store.set('weapons', weapons)
		cb()
	end)

end)

ESX.RegisterServerCallback('srp_statepolicejob:removeArmoryWeapon', function(source, cb, weaponName)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addWeapon(weaponName, 500)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_sheriff', function(store)

		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 0
			})
		end

		store.set('weapons', weapons)
		cb()
	end)

end)

ESX.RegisterServerCallback('srp_statepolicejob:buyWeapon', function(source, cb, weaponName, type, componentNum)
	local xPlayer = ESX.GetPlayerFromId(source)
	local authorizedWeapons, selectedWeapon = Config.AuthorizedWeapons3.Shared

	for k,v in ipairs(authorizedWeapons) do
		if v.weapon == weaponName then
			selectedWeapon = v
			break
		end
	end

	if not selectedWeapon then
		print(('srp_statepolicejob: %s attempted to buy an invalid weapon.'):format(xPlayer.identifier))
		cb(false)
	end

	-- Weapon
	if type == 1 then
		if xPlayer.getMoney() >= selectedWeapon.price then
			xPlayer.removeMoney(selectedWeapon.price)
			xPlayer.addWeapon(weaponName, 220)
			
			cb(true)	
		else
			
			cb(false)
		end

	-- Weapon Component
	elseif type == 2 then
		local price = selectedWeapon.components[weaponComponent]
		local weaponNum, weapon = ESX.GetWeapon(weaponName)

		local component = weapon.components[componentNum]

		if component then
			if xPlayer.getMoney() >= selectedWeapon.price then
				xPlayer.removeMoney(selectedWeapon.price)
				xPlayer.addWeaponComponent(weaponName, component.name)

				cb(true)
			else
				cb(false)
			end
		else
			print(('srp_statepolicejob: %s attempted to buy an invalid weapon component.'):format(xPlayer.identifier))
			cb(false)
		end
	end
end)

ESX.RegisterServerCallback('srp_statepolicejob:storeNearbyVehicle', function(source, cb, nearbyVehicles)
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
				print(('srp_statepolicejob: %s has exploited the garage!'):format(xPlayer.identifier))
				cb(false)
			else
				cb(true, foundNum)
			end
		end)
	end

end)

ESX.RegisterServerCallback('srp_statepolicejob:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_sheriff', function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('srp_statepolicejob:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)

AddEventHandler('playerDropped', function()
	-- Save the source in case we lose it (which happens a lot)
	local _source = source
	
	-- Did the player ever join?
	if _source ~= nil then
		local xPlayer = ESX.GetPlayerFromId(_source)
		
		-- Is it worth telling all clients to refresh?
		if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'sheriff' then
			Citizen.Wait(5000)
			TriggerClientEvent('esx_policejob:updateBlip', -1)
		end
	end	
end)

RegisterServerEvent('srp_statepolicejob:spawned')
AddEventHandler('srp_statepolicejob:spawned', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'sheriff' then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_policejob:updateBlip', -1)
	end
end)

RegisterServerEvent('srp_statepolicejob:forceBlip')
AddEventHandler('srp_statepolicejob:forceBlip', function()
	TriggerClientEvent('esx_policejob:updateBlip', -1)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_policejob:updateBlip', -1)
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_phone:removeNumber', 'police')
	end
end)

RegisterServerEvent('srp_statepolicejob:message')
AddEventHandler('srp_statepolicejob:message', function(target, msg)
	TriggerClientEvent('esx:showNotification', target, msg)
end)

RegisterServerEvent('srp_statepolicejob:handcuffPed')
AddEventHandler('srp_statepolicejob:handcuffPed', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('srp_statepolicejob:handcuffPed', -1, target)
	TriggerClientEvent('srp_statepolicejob:playAnim', source, 'mp_arresting', 'a_uncuff')
	TriggerClientEvent('srp_statepolicejob:playAnimPed', -1, 'mp_arresting', 'b_uncuff', target)
end)

RegisterServerEvent('srp_statepolicejob:dragPed')
AddEventHandler('srp_statepolicejob:dragPed', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('srp_statepolicejob:dragPed', -1, target, source)
end)

RegisterServerEvent('srp_statepolicejob:putInVehiclePed')
AddEventHandler('srp_statepolicejob:putInVehiclePed', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('srp_statepolicejob:putInVehiclePed', -1, target)
end)

RegisterServerEvent('srp_statepolicejob:OutVehiclePed')
AddEventHandler('srp_statepolicejob:OutVehiclePed', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('srp_statepolicejob:OutVehiclePed', -1, target)
end)

RegisterServerEvent('srp_statepolicejob:bodySearchPed')
AddEventHandler('srp_statepolicejob:bodySearchPed', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local r = math.random(1,5)
	if r == 2 then
		xPlayer.addInventoryItem('water', 1)
		TriggerClientEvent('esx:showNotification', source, '~g~Obywatel miał przy sobie jedną wodę')
	elseif r == 3 then
		xPlayer.addInventoryItem('bread', 1)
		TriggerClientEvent('esx:showNotification', source, '~g~Obywatel miał przy sobie jeden chleb')
	elseif r == 4 then
		xPlayer.addInventoryItem('blowpipe', 1)
		TriggerClientEvent('esx:showNotification', source, '~g~Obywatel miał przy sobie jeden wytrych')
	else
		TriggerClientEvent('esx:showNotification', source, '~g~Obywatel nic przy sobie nie miał')
	end
end)

RegisterServerEvent('srp_statepolicejob:pay')
AddEventHandler('srp_statepolicejob:pay', function(amount, target, charge, itsJail)
	amount = tonumber(amount)
	local xPlayer = ESX.GetPlayerFromId(target)
	xPlayer.removeBank(amount)
	if itsJail then
		GetRPName(target, function(firstname, lastname)
			TriggerClientEvent('chat:addMessage', -1, { args = { "[NEWS]",  "^4" .. firstname .. " " .. lastname .. "^7 otrzymał mandat w wysokości ^4" .. amount .. "$^7 za ^4" .. charge}, color = { 255, 166, 0 } })
		end)
	end
end)

RegisterServerEvent('srp_statepolicejob:unrestrain')
AddEventHandler('srp_statepolicejob:unrestrain', function(target)
	TriggerClientEvent('srp_statepolicejob:unrestrain', target)
end)
--[[
ESX.RegisterUsableItem('handcuffs', function(source)
	TriggerClientEvent('srp_statepolicejob:openHandcuffsMenu', source)
end)
]]

RegisterServerEvent('srp_statepolicejob:get_item')
AddEventHandler('srp_statepolicejob:get_item', function(itemLabel, itemName, itemCount)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = sourceXPlayer.getInventoryItem(itemName)
	if sourceItem.limit ~= -1 and (sourceItem.count + itemCount) > sourceItem.limit then
		TriggerClientEvent('esx:showNotification', source, '~r~Nie możesz wziąć więcej')
	else
		sourceXPlayer.addInventoryItem(itemName, itemCount)
		TriggerClientEvent('esx:showNotification', source, 'Wziąłeś ~g~x' .. itemCount .. ' ' .. itemLabel)
	end
end)


function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	if identifier == nil then 
		return nil
	end
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]
		return {
			identifier = identifier,
			firstname = identity.firstname,
			lastname = identity.lastname,
			dateofbirth = identity.dateofbirth,	
			sex = identity.sex,
			height = identity.height,
			job = identity.job
		}
	else
		return nil
	end
end

function GetRPName(playerId, data)
	local Identifier = ESX.GetPlayerFromId(playerId).identifier
	MySQL.Async.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)
		data(result[1].firstname, result[1].lastname)
	end)
end