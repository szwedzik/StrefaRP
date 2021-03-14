ESX						= nil


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('headbag:closest')
AddEventHandler('headbag:closest', function()
    local name = GetPlayerName(najblizszy)
    TriggerClientEvent('headbag:nalozNa', najblizszy)
end)

RegisterServerEvent('headbag:sendclosest')
AddEventHandler('headbag:sendclosest', function(closestPlayer)
    najblizszy = closestPlayer
end)

RegisterServerEvent('headbag:zdejmij')
AddEventHandler('headbag:zdejmij', function()
    TriggerClientEvent('headbag:zdejmijc', najblizszy)
end)

ESX.RegisterUsableItem('headbag', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('headbag:naloz', _source)
    TriggerEvent('headbag:debugger', source)
end)