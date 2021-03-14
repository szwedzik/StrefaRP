local PlayerData = {}
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


RegisterNetEvent('smerfik:weaponshopon')
AddEventHandler('smerfik:weaponshopon', function()
	print(ESX.GetPlayerData().money)
	SetNuiFocus( true, true )
	SendNUIMessage({
		ativa = true,
		pieniadze = ESX.GetPlayerData().money,
	})
end)

RegisterCommand('testujsklep', function()
	print('1')
	TriggerEvent('smerfik:weaponshopon')
end, false)


RegisterNUICallback('1', function(data, cb) 
	cb('ok')
	ESX.ShowNotification('Kupiles pistolet vintage')
	TriggerServerEvent('smerfik:giveweaponshop', 'WEAPON_VINTAGEPISTOL', 1000)
end)

RegisterNUICallback('2', function(data, cb) 
	cb('ok')
	TriggerServerEvent('smerfik:giveweaponshop', 'WEAPON_PISTOL', 5000)
	ESX.ShowNotification('Kupiles pistolet zwykły')
end)

RegisterNUICallback('3', function(data, cb)
	TriggerServerEvent('smerfik:giveweaponshop', 'WEAPON_PISTOL', 3000)
  	cb('ok')
	  ESX.ShowNotification('Kupiles pistolet useless')
end)

RegisterNUICallback('4', function(data, cb)
	ESX.ShowNotification('Kupiles smg')
end)

RegisterNUICallback('5', function(data, cb)

	RegisterNUICallback('7', function(data, cb)

		cb('ok')
		ESX.ShowNotification('Kupiles uzi')
	end)
	cb('ok')
end)

RegisterNUICallback('6', function(data, cb)

	cb('ok')
	ESX.ShowNotification('Kupiles rpg')
end)



RegisterNUICallback('zamknij', function(data, cb)
	SetNuiFocus( false )
	SendNUIMessage({
	ativa = false
	})
  	cb('ok')
end)

