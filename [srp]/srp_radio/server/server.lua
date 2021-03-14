ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
--[[
ESX.RegisterUsableItem('radio', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('srp_radio:use', source)
end)
--]]


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
      local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer ~= nil then
          if xPlayer.getInventoryItem('radio').count == 0 then
            local source = xPlayers[i]
            TriggerClientEvent('srp_radio:onRadioDrop', source)
            break
          end
        end
      end
    end
end)


RegisterServerEvent("srp_radio:HasRadio")
AddEventHandler("srp_radio:HasRadio", function()
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer ~= nil then
    local radio = xPlayer.getInventoryItem('radio').count

    if radio > 0 then
      TriggerClientEvent("srp_radio:HasRadio", source, 1)
    else
      TriggerClientEvent("srp_radio:HasRadio", source, 0)
    end
  else
    return
  end
end)

RegisterServerEvent('srp_radio:radioOffOnCuffs')
AddEventHandler('srp_radio:radioOffOnCuffs', function()
  TriggerClientEvent('srp_radio:radioOffOnCuffs',source)
end)