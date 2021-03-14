ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('smerfik:giveweaponshop')
AddEventHandler('smerfik:giveweaponshop', function(weapon, mon)
local xPlayer = ESX.GetPlayerFromId(source)
xPlayer.addWeapon(weapon, 42)
xPlayer.removeMoney(mon)
end)