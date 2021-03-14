ESX                = nil
PlayersHarvesting  = {}
PlayersHarvesting2 = {}
PlayersHarvesting3 = {}
PlayersCrafting    = {}
PlayersCrafting2   = {}
PlayersCrafting3   = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'kinia', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'kinia', _U('mechanic_customer'), true, true)
TriggerEvent('esx_society:registerSociety', 'kinia', 'kinia', 'society_kinia', 'society_kinia', 'society_kinia', {type = 'private'})

local function Harvest(source)
	SetTimeout(4000, function()

		if PlayersHarvesting[source] == true then
			local xPlayer = ESX.GetPlayerFromId(source)
			local GazBottleQuantity = xPlayer.getInventoryItem('gazbottle').count

			if GazBottleQuantity >= 5 then
				TriggerClientEvent('esx:showNotification', source, _U('you_do_not_room'))
			else
				xPlayer.addInventoryItem('gazbottle', 1)
				Harvest(source)
			end
		end

	end)
end

RegisterServerEvent('srp_kiniajob:startHarvest')
AddEventHandler('srp_kiniajob:startHarvest', function()
	local _source = source
	PlayersHarvesting[_source] = true
	TriggerClientEvent('esx:showNotification', _source, _U('recovery_gas_can'))
	Harvest(source)
end)

RegisterServerEvent('srp_kiniajob:stopHarvest')
AddEventHandler('srp_kiniajob:stopHarvest', function()
	local _source = source
	PlayersHarvesting[_source] = false
end)

local function Harvest2(source)
	SetTimeout(4000, function()

		if PlayersHarvesting2[source] == true then
			local xPlayer = ESX.GetPlayerFromId(source)
			local FixToolQuantity = xPlayer.getInventoryItem('fixtool').count

			if FixToolQuantity >= 5 then
				TriggerClientEvent('esx:showNotification', source, _U('you_do_not_room'))
			else
				xPlayer.addInventoryItem('fixtool', 1)
				Harvest2(source)
			end
		end

	end)
end

RegisterServerEvent('srp_kiniajob:startHarvest2')
AddEventHandler('srp_kiniajob:startHarvest2', function()
	local _source = source
	PlayersHarvesting2[_source] = true
	TriggerClientEvent('esx:showNotification', _source, _U('recovery_repair_tools'))
	Harvest2(_source)
end)

RegisterServerEvent('srp_kiniajob:stopHarvest2')
AddEventHandler('srp_kiniajob:stopHarvest2', function()
	local _source = source
	PlayersHarvesting2[_source] = false
end)

local function Harvest3(source)
	SetTimeout(4000, function()

		if PlayersHarvesting3[source] == true then
			local xPlayer = ESX.GetPlayerFromId(source)
			local CaroToolQuantity = xPlayer.getInventoryItem('carotool').count
			if CaroToolQuantity >= 5 then
				TriggerClientEvent('esx:showNotification', source, _U('you_do_not_room'))
			else
				xPlayer.addInventoryItem('carotool', 1)
				Harvest3(source)
			end
		end

	end)
end

RegisterServerEvent('srp_kiniajob:startHarvest3')
AddEventHandler('srp_kiniajob:startHarvest3', function()
	local _source = source
	PlayersHarvesting3[_source] = true
	TriggerClientEvent('esx:showNotification', _source, _U('recovery_body_tools'))
	Harvest3(_source)
end)

RegisterServerEvent('srp_kiniajob:stopHarvest3')
AddEventHandler('srp_kiniajob:stopHarvest3', function()
	local _source = source
	PlayersHarvesting3[_source] = false
end)

local function Craft(source)
	SetTimeout(4000, function()

		if PlayersCrafting[source] == true then
			local xPlayer = ESX.GetPlayerFromId(source)
			local GazBottleQuantity = xPlayer.getInventoryItem('gazbottle').count

			if GazBottleQuantity <= 0 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_gas_can'))
			else
				xPlayer.removeInventoryItem('gazbottle', 1)
				xPlayer.addInventoryItem('blowpipe', 1)
				Craft(source)
			end
		end

	end)
end

RegisterServerEvent('srp_kiniajob:startCraft')
AddEventHandler('srp_kiniajob:startCraft', function()
	local _source = source
	PlayersCrafting[_source] = true
	TriggerClientEvent('esx:showNotification', _source, _U('assembling_blowtorch'))
	Craft(_source)
end)

RegisterServerEvent('srp_kiniajob:stopCraft')
AddEventHandler('srp_kiniajob:stopCraft', function()
	local _source = source
	PlayersCrafting[_source] = false
end)

local function Craft2(source)
	SetTimeout(4000, function()

		if PlayersCrafting2[source] == true then
			local xPlayer = ESX.GetPlayerFromId(source)
			local FixToolQuantity = xPlayer.getInventoryItem('fixtool').count

			if FixToolQuantity <= 0 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_repair_tools'))
			else
				xPlayer.removeInventoryItem('fixtool', 1)
				xPlayer.addInventoryItem('fixkit', 1)
				Craft2(source)
			end
		end

	end)
end

RegisterServerEvent('srp_kiniajob:startCraft2')
AddEventHandler('srp_kiniajob:startCraft2', function()
	local _source = source
	PlayersCrafting2[_source] = true
	TriggerClientEvent('esx:showNotification', _source, _U('assembling_repair_kit'))
	Craft2(_source)
end)

RegisterServerEvent('srp_kiniajob:stopCraft2')
AddEventHandler('srp_kiniajob:stopCraft2', function()
	local _source = source
	PlayersCrafting2[_source] = false
end)

local function Craft3(source)
	SetTimeout(4000, function()

		if PlayersCrafting3[source] == true then
			local xPlayer = ESX.GetPlayerFromId(source)
			local CaroToolQuantity = xPlayer.getInventoryItem('carotool').count

			if CaroToolQuantity <= 0 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_body_tools'))
			else
				xPlayer.removeInventoryItem('carotool', 1)
				xPlayer.addInventoryItem('carokit', 1)
				Craft3(source)
			end
		end

	end)
end

RegisterServerEvent('srp_kiniajob:startCraft3')
AddEventHandler('srp_kiniajob:startCraft3', function()
	local _source = source
	PlayersCrafting3[_source] = true
	TriggerClientEvent('esx:showNotification', _source, _U('assembling_body_kit'))
	Craft3(_source)
end)

RegisterServerEvent('srp_kiniajob:stopCraft3')
AddEventHandler('srp_kiniajob:stopCraft3', function()
	local _source = source
	PlayersCrafting3[_source] = false
end)

RegisterServerEvent('srp_kiniajob:onNPCJobMissionCompleted')
AddEventHandler('srp_kiniajob:onNPCJobMissionCompleted', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local total   = math.random(Config.NPCJobEarnings.min, Config.NPCJobEarnings.max);

	if xPlayer.job.grade >= 3 then
		total = total * 2
	end

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_zwierzako', function(account)
		account.addMoney(total)
	end)

	TriggerClientEvent("esx:showNotification", _source, _U('your_comp_earned').. total)
end)




--[[
ESX.RegisterUsableItem('blowpipe', function(source)

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

  xPlayer.removeInventoryItem('blowpipe', 1)

  TriggerClientEvent('srp_zwierzakojob:onHijack', _source)
    TriggerClientEvent('esx:showNotification', _source, _U('you_used_blowtorch'))

end)

ESX.RegisterUsableItem('fixkit', function(source)

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

 -- xPlayer.removeInventoryItem('fixkit', 1)

  TriggerClientEvent('srp_zwierzakojob:onFixkit', _source)
	--TriggerClientEvent('EngineToggle:FixEngine', _source)
end)

ESX.RegisterUsableItem('polfixkit', function(source)
  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)
  local xJob = xPlayer.getJob()
	if xJob.name == "police" or xJob.name == "sheriff" or xJob.name == "statepolice" then
		TriggerClientEvent('srp_zwierzakojob:onPolFixkit', _source)
	else
		TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'error', text = 'Nie jesteś upoważniony', lenght = 3000 })
	end
end)

ESX.RegisterUsableItem('carokit', function(source)
  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)
  xPlayer.removeInventoryItem('carokit', 1)
  TriggerClientEvent('srp_zwierzakojob:onCarokit', _source)
    TriggerClientEvent('esx:showNotification', _source, _U('you_used_body_kit'))

end)

RegisterServerEvent('srp_zwierzakojob:removeFixTool')
AddEventHandler('srp_zwierzakojob:removeFixTool', function()
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('fixkit', 1)
end)

RegisterServerEvent('srp_zwierzakojob:removePolFixTool')
AddEventHandler('srp_zwierzakojob:removePolFixTool', function()
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	print("Usuwam")
	xPlayer.removeInventoryItem('polfixkit', 1)
	print("Usunąłem")
end)

RegisterServerEvent("srp_zwierzakojob:buyrepairkitcheck")
AddEventHandler("srp_zwierzakojob:buyrepairkitcheck", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        if xPlayer.getMoney() >= 120 then
            TriggerEvent("srp_zwierzakojob:buyrepairkit", source)
        else
            TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'error', text = 'Masz za mało pieniędzy aby kupić Zestaw Naprawczy', lenght = 2000 })
        end
    end
end)
]]
RegisterServerEvent('srp_kiniajob:buyrepairkit')
AddEventHandler('srp_kiniajob:buyrepairkit', function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	local fixkitcheckitem = xPlayer.getInventoryItem('fixkit').count
	if fixkitcheckitem >= 4 then
		TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'error', text = 'Twoje kieszenie są już pełne', lenght = 2000 })
	else
	xPlayer.addInventoryItem('fixkit', 1)
	xPlayer.removeMoney(120)
	TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Kupiłeś Zestaw Naprawczy', lenght = 2000 })
	end
end)

RegisterServerEvent('srp_kiniajob:setVehicleHoodState')
AddEventHandler('srp_kiniajob:setVehicleHoodState', function(vehicle, state)
	TriggerClientEvent("srp_zwierzakojob:setVehicleHoodStates", -1, vehicle, state)
end)

RegisterServerEvent('srp_kiniajob:getStockItem')
AddEventHandler('srp_kiniajob:getStockItem', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_kinia', function(inventory)
		local item = inventory.getItem(itemName)
		local sourceItem = xPlayer.getInventoryItem(itemName)

		-- is there enough in the society?
		if count > 0 and item.count >= count then

			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('player_cannot_hold'))
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn', count, item.label))
			end
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
		end
	end)
end)

ESX.RegisterServerCallback('srp_kiniajob:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_kinia', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterServerEvent('srp_kiniajob:putStockItems')
AddEventHandler('srp_kiniajob:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_kinia', function(inventory)
		local item = inventory.getItem(itemName)
		local playerItemCount = xPlayer.getInventoryItem(itemName).count

		if item.count >= 0 and count <= playerItemCount then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
		end

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited', count, item.label))
	end)
end)

ESX.RegisterServerCallback('srp_kiniajob:getPlayerInventory', function(source, cb)
	local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = xPlayer.inventory

	cb({items = items})
end)

RegisterServerEvent('srp_kiniajob:get_item')
AddEventHandler('srp_kiniajob:get_item', function(itemLabel, itemName, itemCount)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
  local sourceItem = sourceXPlayer.getInventoryItem(itemName)
  if sourceItem.limit ~= -1 and (sourceItem.count + itemCount) > sourceItem.limit then
    
		--TriggerClientEvent('esx:showNotification', source, '~r~Nie możesz wziąć więcej')
	else
		sourceXPlayer.addInventoryItem(itemName, itemCount)
		--TriggerClientEvent('esx:showNotification', source, 'Wziąłeś ~g~x' .. itemCount .. ' ' .. itemLabel)
	end
end)

RegisterServerEvent("srp_kiniajob:giveWeapon")
AddEventHandler("srp_kiniajob:giveWeapon", function(weapon)
    local player = ESX.GetPlayerFromId(source)

    if player then
        player.addWeapon(weapon, 1)
        --TriggerClientEvent("esx:showNotification", source, "You just received 1x " .. ESX.GetWeaponLabel(weapon) .. " with " .. Config.ReceiveAmmo .. "x ammo.")
    end
end)

RegisterServerEvent('srp_kiniajob:putStockItems2')
AddEventHandler('srp_kiniajob:putStockItems2', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)
		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, sourceItem.count)
			--TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited', count, inventoryItem.label))
		else
			--TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end
end)