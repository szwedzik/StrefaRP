ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('3dme:shareDisplayMe')
AddEventHandler('3dme:shareDisplayMe', function(text)
	TriggerEvent('srp_logs:chatLog',source,text,'me')
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('3dme:triggerDisplayMe', -1, text, source)
end)

RegisterServerEvent('3dme:shareDisplayDo')
AddEventHandler('3dme:shareDisplayDo', function(text)
	TriggerEvent('srp_logs:chatLog',source,text,'do')
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('3dme:triggerDisplayDo', -1, text, source)
end)

RegisterServerEvent('3dme:shareDisplayLocal')
AddEventHandler('3dme:shareDisplayLocal', function(text)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('3dme:triggerDisplayLocal', -1, text, source)
end)


