ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('payfor:clothesshop')
AddEventHandler('payfor:clothesshop', function()
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
TriggerClientEvent('esx_skin:requestSaveSkin', source)
TriggerClientEvent('esx:showNotification', source, 'debug')
print('debug zapis')
xPlayer.removeMoney(50)

end)