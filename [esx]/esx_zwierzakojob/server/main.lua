ESX                = nil
PlayersHarvesting  = {}
PlayersHarvesting2 = {}
PlayersHarvesting3 = {}
PlayersCrafting    = {}
PlayersCrafting2   = {}
PlayersCrafting3   = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
  TriggerEvent('esx_service:activateService', 'zwierzako', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'zwierzako', _U('mechanic_customer'), true, true)
TriggerEvent('esx_society:registerSociety', 'zwierzako', 'Zwierzako', 'society_zwierzako', 'society_zwierzako', 'society_zwierzako', {type = 'private'})
local function Harvest(source)

  SetTimeout(4000, function()

    if PlayersHarvesting[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
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

RegisterServerEvent('esx_zwierzakojob:startHarvest')
AddEventHandler('esx_zwierzakojob:startHarvest', function()
  local _source = source
  PlayersHarvesting[_source] = true
  TriggerClientEvent('esx:showNotification', _source, _U('recovery_gas_can'))
  Harvest(source)
end)

RegisterServerEvent('esx_zwierzakojob:stopHarvest')
AddEventHandler('esx_zwierzakojob:stopHarvest', function()
  local _source = source
  PlayersHarvesting[_source] = false
end)

local function Harvest2(source)

  SetTimeout(4000, function()

    if PlayersHarvesting2[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local FixToolQuantity  = xPlayer.getInventoryItem('fixtool').count
      if FixToolQuantity >= 5 then
        TriggerClientEvent('esx:showNotification', source, _U('you_do_not_room'))
      else
                xPlayer.addInventoryItem('fixtool', 1)

        Harvest2(source)
      end
    end
  end)
end

RegisterServerEvent('esx_zwierzakojob:startHarvest2')
AddEventHandler('esx_zwierzakojob:startHarvest2', function()
  local _source = source
  PlayersHarvesting2[_source] = true
  TriggerClientEvent('esx:showNotification', _source, _U('recovery_repair_tools'))
  Harvest2(_source)
end)

RegisterServerEvent('esx_zwierzakojob:stopHarvest2')
AddEventHandler('esx_zwierzakojob:stopHarvest2', function()
  local _source = source
  PlayersHarvesting2[_source] = false
end)

local function Harvest3(source)

  SetTimeout(4000, function()

    if PlayersHarvesting3[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local CaroToolQuantity  = xPlayer.getInventoryItem('carotool').count
            if CaroToolQuantity >= 5 then
        TriggerClientEvent('esx:showNotification', source, _U('you_do_not_room'))
      else
                xPlayer.addInventoryItem('carotool', 1)

        Harvest3(source)
      end
    end
  end)
end

RegisterServerEvent('esx_zwierzakojob:startHarvest3')
AddEventHandler('esx_zwierzakojob:startHarvest3', function()
  local _source = source
  PlayersHarvesting3[_source] = true
  TriggerClientEvent('esx:showNotification', _source, _U('recovery_body_tools'))
  Harvest3(_source)
end)

RegisterServerEvent('esx_zwierzakojob:stopHarvest3')
AddEventHandler('esx_zwierzakojob:stopHarvest3', function()
  local _source = source
  PlayersHarvesting3[_source] = false
end)

local function Craft(source)

  SetTimeout(4000, function()

    if PlayersCrafting[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
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

RegisterServerEvent('esx_zwierzakojob:startCraft')
AddEventHandler('esx_zwierzakojob:startCraft', function()
  local _source = source
  PlayersCrafting[_source] = true
  TriggerClientEvent('esx:showNotification', _source, _U('assembling_blowtorch'))
  Craft(_source)
end)

RegisterServerEvent('esx_zwierzakojob:stopCraft')
AddEventHandler('esx_zwierzakojob:stopCraft', function()
  local _source = source
  PlayersCrafting[_source] = false
end)

local function Craft2(source)

  SetTimeout(4000, function()

    if PlayersCrafting2[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local FixToolQuantity  = xPlayer.getInventoryItem('fixtool').count
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

RegisterServerEvent('esx_zwierzakojob:startCraft2')
AddEventHandler('esx_zwierzakojob:startCraft2', function()
  local _source = source
  PlayersCrafting2[_source] = true
  TriggerClientEvent('esx:showNotification', _source, _U('assembling_blowtorch'))
  Craft2(_source)
end)

RegisterServerEvent('esx_zwierzakojob:stopCraft2')
AddEventHandler('esx_zwierzakojob:stopCraft2', function()
  local _source = source
  PlayersCrafting2[_source] = false
end)
----------------- Craft kit Carosserie ----------------
local function Craft3(source)

  SetTimeout(4000, function()

    if PlayersCrafting3[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local CaroToolQuantity  = xPlayer.getInventoryItem('carotool').count
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

RegisterServerEvent('esx_zwierzakojob:startCraft3')
AddEventHandler('esx_zwierzakojob:startCraft3', function()
  local _source = source
  PlayersCrafting3[_source] = true
  TriggerClientEvent('esx:showNotification', _source, _U('assembling_body_kit'))
  Craft3(_source)
end)

RegisterServerEvent('esx_zwierzakojob:stopCraft3')
AddEventHandler('esx_zwierzakojob:stopCraft3', function()
  local _source = source
  PlayersCrafting3[_source] = false
end)

---------------------------- NPC Job Earnings ------------------------------------------------------

RegisterServerEvent('esx_zwierzakojob:onNPCJobMissionCompleted')
AddEventHandler('esx_zwierzakojob:onNPCJobMissionCompleted', function()

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

---------------------------- register usable item --------------------------------------------------
ESX.RegisterUsableItem('blowpipe', function(source)

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

  xPlayer.removeInventoryItem('blowpipe', 1)

  TriggerClientEvent('esx_zwierzakojob:onHijack', _source)
    TriggerClientEvent('esx:showNotification', _source, _U('you_used_blowtorch'))

end)

ESX.RegisterUsableItem('fixkit', function(source)

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

 -- xPlayer.removeInventoryItem('fixkit', 1)

  TriggerClientEvent('esx_zwierzakojob:onFixkit', _source)
	--TriggerClientEvent('EngineToggle:FixEngine', _source)
end)

ESX.RegisterUsableItem('polfixkit', function(source)
  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)
  local xJob = xPlayer.getJob()
  if xJob.name == "police" or xJob.name == "sheriff" or xJob.name == "statepolice" then
      TriggerClientEvent('esx_zwierzakojob:onPolFixkit', _source)
  else
     TriggerClientEvent('esx:showNotification', _source, "Nie jesteś upoważniony")
  end
end)

ESX.RegisterUsableItem('carokit', function(source)
  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)
  xPlayer.removeInventoryItem('carokit', 1)
  TriggerClientEvent('esx_zwierzakojob:onCarokit', _source)
    TriggerClientEvent('esx:showNotification', _source, _U('you_used_body_kit'))

end)

RegisterServerEvent('esx_zwierzakojob:removeFixTool')
AddEventHandler('esx_zwierzakojob:removeFixTool', function()
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('fixkit', 1)
end)

RegisterServerEvent('esx_zwierzakojob:removePolFixTool')
AddEventHandler('esx_zwierzakojob:removePolFixTool', function()
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('polfixkit', 1)
end)

RegisterServerEvent('esx_zwierzakojob:setVehicleHoodState')
AddEventHandler('esx_zwierzakojob:setVehicleHoodState', function(vehicle, state)
	TriggerClientEvent("esx_zwierzakojob:setVehicleHoodStates", -1, vehicle, state)
end)

RegisterServerEvent('esx_zwierzakojob:getStockItem')
AddEventHandler('esx_zwierzakojob:getStockItem', function(itemName, count)
  local xPlayer = ESX.GetPlayerFromId(source)
  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_zwierzako', function(inventory)
    local item = inventory.getItem(itemName)
    if item.count >= count then
      inventory.removeItem(itemName, count)
      xPlayer.addInventoryItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
    end
    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_removed') .. count .. ' ' .. item.label)
  end)
end)

ESX.RegisterServerCallback('esx_zwierzakojob:getStockItems', function(source, cb)
  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_zwierzako', function(inventory)
    cb(inventory.items)
  end)
end)

RegisterServerEvent('esx_zwierzakojob:putStockItems')
AddEventHandler('esx_zwierzakojob:putStockItems', function(itemName, count)
  local xPlayer = ESX.GetPlayerFromId(source)
  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_zwierzako', function(inventory)
    local item = inventory.getItem(itemName)
    local playerItemCount = xPlayer.getInventoryItem(itemName).count
    if item.count >= 0 and count <= playerItemCount then
      xPlayer.removeInventoryItem(itemName, count)
      inventory.addItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
    end
    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_added') .. count .. ' ' .. item.label)
  end)
end)

ESX.RegisterServerCallback('esx_zwierzakojob:getPlayerInventory', function(source, cb)
  local xPlayer    = ESX.GetPlayerFromId(source)
  local items      = xPlayer.inventory
  cb({
    items      = items
  })
end)


RegisterServerEvent('esx_zwierzakojob:get_item')
AddEventHandler('esx_zwierzakojob:get_item', function(itemLabel, itemName, itemCount)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
  local sourceItem = sourceXPlayer.getInventoryItem(itemName)
  if sourceItem.limit ~= -1 and (sourceItem.count + itemCount) > sourceItem.limit then
    
		--TriggerClientEvent('esx:showNotification', source, '~r~Nie możesz wziąć więcej')
	else
		sourceXPlayer.addInventoryItem(itemName, itemCount)
		--TriggerClientEvent('esx:showNotification', source, 'Wziąłeś ~g~x' .. itemCount .. ' ' .. itemLabel)
	end
end)

RegisterServerEvent("esx_zwierzakojob:giveWeapon")
AddEventHandler("esx_zwierzakojob:giveWeapon", function(weapon)
    local player = ESX.GetPlayerFromId(source)

    if player then
        player.addWeapon(weapon, 1)
        --TriggerClientEvent("esx:showNotification", source, "You just received 1x " .. ESX.GetWeaponLabel(weapon) .. " with " .. Config.ReceiveAmmo .. "x ammo.")
    end
end)

RegisterServerEvent('esx_zwierzakojob:putStockItems2')
AddEventHandler('esx_zwierzakojob:putStockItems2', function(itemName, count)
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