ESX = nil
TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

RegisterServerEvent('esx_barbie_lyftupp:lyfter')
AddEventHandler('esx_barbie_lyftupp:lyfter', function(target)
	local targetPlayer = ESX.GetPlayerFromId(target)
	TriggerClientEvent('esx_barbie_lyftupp:upplyft', targetPlayer.source, source)
end)

RegisterServerEvent('esx_barbie_lyftupp:lyfteruppn')
AddEventHandler('esx_barbie_lyftupp:lyfteruppn', function(source)
	TriggerClientEvent('esx:showNotification', source, ('Ktoś próbuje cię podnieść'))
end)
