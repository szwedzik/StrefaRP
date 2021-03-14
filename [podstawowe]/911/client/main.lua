ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)


Citizen.CreateThread(function()
  TriggerEvent('chat:addSuggestion', '/911', 'Wyślij zgłoszenie do LSPD/LSSD/SASP!', {
  { name="Treść zgłoszenia", help="" }
})
TriggerEvent('chat:addSuggestion', '/a911', 'Wyślij anonimowe zgłoszenie do LSPD/LSSD/SASP!', {
  { name="Treść zgłoszenia", help="" }
})
TriggerEvent('chat:addSuggestion', '/101', 'Wyślij zgłoszenie do Los Santos Fire Department!', {
  { name="Treść zgłoszenia", help="" }
})
TriggerEvent('chat:addSuggestion', '/0700', 'Wyślij zgłoszenie do Janush Customs!', {
  { name="Treść zgłoszenia", help="" }
})
TriggerEvent('chat:addSuggestion', '/0800', 'Wyślij zgłoszenie do CarZone Garage!', {
  { name="Treść zgłoszenia", help="" }
})
TriggerEvent('chat:addSuggestion', '/taxi', 'Wyślij zgłoszenie do Taksówkarzy!', {
  { name="Treść zgłoszenia", help="" }
})
end)

-- LSPD/LSSD/SASP
RegisterCommand('911', function(source, args)
  local ped = GetPlayerPed(-1)
  local x, y, z = table.unpack(GetEntityCoords(ped, true))
  local street = GetStreetNameAtCoord(x, y, z)
  local location = GetStreetNameFromHashKey(street)
  local msg = table.concat(args, ' ')
  TriggerServerEvent('srp:911', location, msg)
  PowiadomPsy()
  exports['mythic_notify']:DoCustomHudText('inform', 'Wysłałeś zgłoszenie!', 5000)
end)

RegisterCommand('a911', function(source, args)
  local ped = GetPlayerPed(-1)
  local x, y, z = table.unpack(GetEntityCoords(ped, true))
  local street = GetStreetNameAtCoord(x, y, z)
  local location = GetStreetNameFromHashKey(street)
  local msg = table.concat(args, ' ')
  TriggerServerEvent('srp:a911', location, msg)
  PowiadomPsy()
  exports['mythic_notify']:DoCustomHudText('inform', 'Wysłałeś zgłoszenie!', 5000)
end)

RegisterNetEvent('srp:911')
AddEventHandler('srp:911', function(x, y, z)	
	PlayerData = ESX.GetPlayerData()
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' or
	PlayerData.job ~= nil and PlayerData.job.name == 'statepolice' or
	PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' then
		

        PlaySoundFrontend(-1, "HACKING_CLICK_GOOD", 0, 1)

		local blip = AddBlipForCoord(x, y, z)
		SetBlipSprite(blip, 280)
        SetBlipScale(blip, 1.0)
        SetBlipColour(blip, 1)
        SetBlipAlpha(blip, 180)
        SetBlipHighDetail(blip, true)
	    BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Zgłoszenie obywatela')
        EndTextCommandSetBlipName(blip)
        Citizen.Wait(420000)
        RemoveBlip(blip)
	end
end)

function PowiadomPsy()
	x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
	playerX = tonumber(string.format("%.2f", x))
    playerY = tonumber(string.format("%.2f", y))
    playerZ = tonumber(string.format("%.2f", z))
	TriggerServerEvent('srp:911check', playerX, playerY, playerZ)
	Citizen.Wait(500)
end

-- Ambulance
RegisterCommand('101', function(source, args)
  local ped = GetPlayerPed(-1)
  local x, y, z = table.unpack(GetEntityCoords(ped, true))
  local street = GetStreetNameAtCoord(x, y, z)
  local location = GetStreetNameFromHashKey(street)
  local msg = table.concat(args, ' ')
  TriggerServerEvent('srp:101', location, msg)
  PowiadomLSFD()
  exports['mythic_notify']:DoCustomHudText('inform', 'Wysłałeś zgłoszenie!', 5000)
end)

RegisterNetEvent('srp:101')
AddEventHandler('srp:101', function(x, y, z)	
	PlayerData = ESX.GetPlayerData()
	if PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' then
        PlaySoundFrontend(-1, "HACKING_CLICK_GOOD", 0, 1)
		local blip = AddBlipForCoord(x, y, z)
		SetBlipSprite(blip, 280)
        SetBlipScale(blip, 1.0)
        SetBlipColour(blip, 1)
        SetBlipAlpha(blip, 180)
        SetBlipHighDetail(blip, true)
	    BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Zgłoszenie obywatela')
        EndTextCommandSetBlipName(blip)
        Citizen.Wait(420000)
        RemoveBlip(blip)
	end
end)

function PowiadomLSFD()
	x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
	playerX = tonumber(string.format("%.2f", x))
    playerY = tonumber(string.format("%.2f", y))
    playerZ = tonumber(string.format("%.2f", z))
	TriggerServerEvent('srp:101check', playerX, playerY, playerZ)
	Citizen.Wait(500)
end

-- Zwierzak
RegisterCommand('0700', function(source, args)
  local ped = GetPlayerPed(-1)
  local x, y, z = table.unpack(GetEntityCoords(ped, true))
  local street = GetStreetNameAtCoord(x, y, z)
  local location = GetStreetNameFromHashKey(street)
  local msg = table.concat(args, ' ')
  TriggerServerEvent('srp:0700', location, msg)
  PowiadomJanush()
  exports['mythic_notify']:DoCustomHudText('inform', 'Wysłałeś zgłoszenie!', 5000)
end)

RegisterNetEvent('srp:0700')
AddEventHandler('srp:0700', function(x, y, z)	
	PlayerData = ESX.GetPlayerData()
	if PlayerData.job ~= nil and PlayerData.job.name == 'zwierzako' then
        PlaySoundFrontend(-1, "HACKING_CLICK_GOOD", 0, 1)
		local blip = AddBlipForCoord(x, y, z)
		SetBlipSprite(blip, 280)
        SetBlipScale(blip, 1.0)
        SetBlipColour(blip, 1)
        SetBlipAlpha(blip, 180)
        SetBlipHighDetail(blip, true)
	    BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Zgłoszenie obywatela')
        EndTextCommandSetBlipName(blip)
        Citizen.Wait(420000)
        RemoveBlip(blip)
	end
end)

function PowiadomJanush()
	x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
	playerX = tonumber(string.format("%.2f", x))
    playerY = tonumber(string.format("%.2f", y))
    playerZ = tonumber(string.format("%.2f", z))
	TriggerServerEvent('srp:0700check', playerX, playerY, playerZ)
	Citizen.Wait(500)
end

-- Kinia
RegisterCommand('0800', function(source, args)
  local ped = GetPlayerPed(-1)
  local x, y, z = table.unpack(GetEntityCoords(ped, true))
  local street = GetStreetNameAtCoord(x, y, z)
  local location = GetStreetNameFromHashKey(street)
  local msg = table.concat(args, ' ')
  TriggerServerEvent('srp:0800', location, msg)
  PowiadomCarzone()
  exports['mythic_notify']:DoCustomHudText('inform', 'Wysłałeś zgłoszenie!', 5000)
end)

RegisterNetEvent('srp:0800')
AddEventHandler('srp:0800', function(x, y, z)	
	PlayerData = ESX.GetPlayerData()
	if PlayerData.job ~= nil and PlayerData.job.name == 'kiniajob' then
        PlaySoundFrontend(-1, "HACKING_CLICK_GOOD", 0, 1)
		local blip = AddBlipForCoord(x, y, z)
		SetBlipSprite(blip, 280)
        SetBlipScale(blip, 1.0)
        SetBlipColour(blip, 1)
        SetBlipAlpha(blip, 180)
        SetBlipHighDetail(blip, true)
	    BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Zgłoszenie obywatela')
        EndTextCommandSetBlipName(blip)
        Citizen.Wait(420000)
        RemoveBlip(blip)
	end
end)

function PowiadomCarzone()
	x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
	playerX = tonumber(string.format("%.2f", x))
    playerY = tonumber(string.format("%.2f", y))
    playerZ = tonumber(string.format("%.2f", z))
	TriggerServerEvent('srp:0800check', playerX, playerY, playerZ)
	Citizen.Wait(500)
end

-- Taxi
RegisterCommand('taxi', function(source, args)
  local ped = GetPlayerPed(-1)
  local x, y, z = table.unpack(GetEntityCoords(ped, true))
  local street = GetStreetNameAtCoord(x, y, z)
  local location = GetStreetNameFromHashKey(street)
  local msg = table.concat(args, ' ')
  TriggerServerEvent('srp:taxi', location, msg)
  PowiadomTaxi()
  exports['mythic_notify']:DoCustomHudText('inform', 'Wysłałeś zgłoszenie!', 5000)
end)

RegisterNetEvent('srp:taxi')
AddEventHandler('srp:taxi', function(x, y, z)	
	PlayerData = ESX.GetPlayerData()
	if PlayerData.job ~= nil and PlayerData.job.name == 'taxi' then
        PlaySoundFrontend(-1, "HACKING_CLICK_GOOD", 0, 1)
		local blip = AddBlipForCoord(x, y, z)
		SetBlipSprite(blip, 280)
        SetBlipScale(blip, 1.0)
        SetBlipColour(blip, 1)
        SetBlipAlpha(blip, 180)
        SetBlipHighDetail(blip, true)
	    BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Zgłoszenie obywatela')
        EndTextCommandSetBlipName(blip)
        Citizen.Wait(420000)
        RemoveBlip(blip)
	end
end)

function PowiadomTaxi()
	x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
	playerX = tonumber(string.format("%.2f", x))
    playerY = tonumber(string.format("%.2f", y))
    playerZ = tonumber(string.format("%.2f", z))
	TriggerServerEvent('srp:taxicheck', playerX, playerY, playerZ)
	Citizen.Wait(500)
end