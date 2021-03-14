ESX						= nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--------------------
-- zwykła
local wygrana1 = 6000
local wygrana2 = 1500
local wygrana3 = 1000
local wygrana4 = 800
local wygrana5 = 300
local wygrana6 = 200
-- plus
local wygrana1plus = 12000
local wygrana2plus = 6000
local wygrana3plus = 4000
local wygrana4plus = 1500
local wygrana5plus = 700
local wygrana6plus = 400
-- extra
local wygrana1extra = 10000
local wygrana2extra = 4000
local wygrana3extra = 2400
local wygrana4extra = 1200
local wygrana5extra = 600
--------------------
-- zwykła
RegisterServerEvent('ciemina:wygranko1')
AddEventHandler('ciemina:wygranko1', function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local WygranaGotowka = wygrana1
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Wygrałeś/aś ' .. WygranaGotowka..'$' })
    xPlayer.addMoney(WygranaGotowka)
	Wait(500)
end)

RegisterServerEvent('ciemina:wygranko2')
AddEventHandler('ciemina:wygranko2', function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local WygranaGotowka = wygrana2
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Wygrałeś/aś ' .. WygranaGotowka..'$' })
    xPlayer.addMoney(WygranaGotowka)
	Wait(500)
end)

RegisterServerEvent('ciemina:wygranko3')
AddEventHandler('ciemina:wygranko3', function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local WygranaGotowka = wygrana3
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Wygrałeś/aś ' .. WygranaGotowka..'$' })
    xPlayer.addMoney(WygranaGotowka)
	Wait(500)
end)

RegisterServerEvent('ciemina:wygranko4')
AddEventHandler('ciemina:wygranko4', function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local WygranaGotowka = wygrana4
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Wygrałeś/aś ' .. WygranaGotowka..'$' })
    xPlayer.addMoney(WygranaGotowka)
	Wait(500)
end)

RegisterServerEvent('ciemina:wygranko5')
AddEventHandler('ciemina:wygranko5', function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local WygranaGotowka = wygrana5
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Wygrałeś/aś ' .. WygranaGotowka..'$' })
    xPlayer.addMoney(WygranaGotowka)
	Wait(500)
end)

RegisterServerEvent('ciemina:wygranko6')
AddEventHandler('ciemina:wygranko6', function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local WygranaGotowka = wygrana6
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Wygrałeś/aś ' .. WygranaGotowka..'$' })
    xPlayer.addMoney(WygranaGotowka)
	Wait(500)
end)


-- plus
RegisterServerEvent('ciemina:wygranko1plus')
AddEventHandler('ciemina:wygranko1plus', function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local WygranaGotowka = wygrana1plus
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Wygrałeś/aś ' .. WygranaGotowka..'$' })
    xPlayer.addMoney(WygranaGotowka)
	Wait(500)
end)

RegisterServerEvent('ciemina:wygranko2plus')
AddEventHandler('ciemina:wygranko2plus', function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local WygranaGotowka = wygrana2plus
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Wygrałeś/aś ' .. WygranaGotowka..'$' })
    xPlayer.addMoney(WygranaGotowka)
	Wait(500)
end)

RegisterServerEvent('ciemina:wygranko3plus')
AddEventHandler('ciemina:wygranko3plus', function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local WygranaGotowka = wygrana3plus
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Wygrałeś/aś ' .. WygranaGotowka..'$' })
    xPlayer.addMoney(WygranaGotowka)
	Wait(500)
end)

RegisterServerEvent('ciemina:wygranko4plus')
AddEventHandler('ciemina:wygranko4plus', function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local WygranaGotowka = wygrana4plus
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Wygrałeś/aś ' .. WygranaGotowka..'$' })
    xPlayer.addMoney(WygranaGotowka)
	Wait(500)
end)

RegisterServerEvent('ciemina:wygranko5plus')
AddEventHandler('ciemina:wygranko5plus', function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local WygranaGotowka = wygrana5plus
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Wygrałeś/aś ' .. WygranaGotowka..'$' })
    xPlayer.addMoney(WygranaGotowka)
	Wait(500)
end)

RegisterServerEvent('ciemina:wygranko6plus')
AddEventHandler('ciemina:wygranko6plus', function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local WygranaGotowka = wygrana6plus
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Wygrałeś/aś ' .. WygranaGotowka..'$' })
    xPlayer.addMoney(WygranaGotowka)
	Wait(500)
end)

-- extra
RegisterServerEvent('ciemina:wygranko1extra')
AddEventHandler('ciemina:wygranko1extra', function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local WygranaGotowka = wygrana1extra
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Wygrałeś/aś ' .. WygranaGotowka..'$' })
    xPlayer.addMoney(WygranaGotowka)
	Wait(500)
end)

RegisterServerEvent('ciemina:wygranko2extra')
AddEventHandler('ciemina:wygranko2extra', function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local WygranaGotowka = wygrana2extra
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Wygrałeś/aś ' .. WygranaGotowka..'$' })
    xPlayer.addMoney(WygranaGotowka)
	Wait(500)
end)

RegisterServerEvent('ciemina:wygranko3extra')
AddEventHandler('ciemina:wygranko3extra', function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local WygranaGotowka = wygrana3extra
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Wygrałeś/aś ' .. WygranaGotowka..'$' })
    xPlayer.addMoney(WygranaGotowka)
	Wait(500)
end)

RegisterServerEvent('ciemina:wygranko4extra')
AddEventHandler('ciemina:wygranko4extra', function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local WygranaGotowka = wygrana4extra
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Wygrałeś/aś ' .. WygranaGotowka..'$' })
    xPlayer.addMoney(WygranaGotowka)
	Wait(500)
end)

RegisterServerEvent('ciemina:wygranko5extra')
AddEventHandler('ciemina:wygranko5extra', function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local WygranaGotowka = wygrana5extra
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Wygrałeś/aś ' .. WygranaGotowka..'$' })
    xPlayer.addMoney(WygranaGotowka)
	Wait(500)
end)


-- Itemy
ESX.RegisterUsableItem('zdrapka', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('zdrapka', 1)
	TriggerClientEvent("ciemina:zdrapuj", source)
	Wait(500)
end)

ESX.RegisterUsableItem('zdrapkaplus', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('zdrapkaplus', 1)
	TriggerClientEvent("ciemina:zdrapujplus", source)
	Wait(500)
end)

ESX.RegisterUsableItem('zdrapkaextra', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('zdrapkaextra', 1)
	TriggerClientEvent("ciemina:zdrapujextra", source)
	Wait(500)
end)