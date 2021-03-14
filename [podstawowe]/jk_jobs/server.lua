ESX = nil
local lastjobchange = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_jk_jobs:setJobBut')
AddEventHandler('esx_jk_jobs:setJobBut', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("butcher", 0)-- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Zostałeś zatrudniony jako ~g~Rzeźnik')
end)

RegisterServerEvent('esx_jk_jobs:setJobFis')
AddEventHandler('esx_jk_jobs:setJobFis', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("fisher", 0)-- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Zostałeś zatrudniony jako ~g~Rybak')
end)

RegisterServerEvent('esx_jk_jobs:setJobGar')
AddEventHandler('esx_jk_jobs:setJobGar', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("garbage", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Zostałeś zatrudniony jako ~g~Śmieciarz')	
end)

RegisterServerEvent('esx_jk_jobs:setJobTax')
AddEventHandler('esx_jk_jobs:setJobTax', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("taxi", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Zostałeś zatrudniony jako ~g~Taksówkarz')	
end)

RegisterServerEvent('esx_jk_jobs:setJobWin')
AddEventHandler('esx_jk_jobs:setJobWin', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("winemaker", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Zostałeś zatrudniony jako ~g~Winiarz')	
end)