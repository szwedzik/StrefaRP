local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local GUI                     = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentGarage           = nil
local PlayerData              = {}
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local IsInShopMenu            = false
local Categories              = {}
local Vehicles                = {}
local LastVehicles            = {}
local CurrentVehicleData      = nil
local closest                 = 0
local delay = 0

ESX                           = nil
GUI.Time                      = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

-- Create Blips
Citizen.CreateThread(function()
	for k,v in pairs(Config.Garages) do
		local blip = AddBlipForCoord(v.Marker.x, v.Marker.y, v.Marker.z)
		SetBlipSprite (blip, 473)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.7)
		SetBlipColour (blip, 82)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Parking")
		EndTextCommandSetBlipName(blip)
	end
	for k,v in pairs(Config.Impound) do
		local blip = AddBlipForCoord(v.Marker.x, v.Marker.y, v.Marker.z)
		SetBlipSprite (blip, 473)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.7)
		SetBlipColour (blip, 1)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Zwrot pojazdu")
		EndTextCommandSetBlipName(blip)
	end
end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Wait(10)
		local playerPed = GetPlayerPed(-1)
		local coords    = GetEntityCoords(playerPed)
		for k,v in pairs(Config.Garages) do
			if(GetDistanceBetweenCoords(coords, v.Marker.x, v.Marker.y, v.Marker.z, true) < Config.DrawDistance) then
				DrawMarker(Config.MarkerType, v.Marker.x, v.Marker.y, v.Marker.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, false, 2, false, false, false, false)
			end
		end
		for k,v in pairs(Config.Impound) do
			if --[[PlayerData.job ~= nil and PlayerData.job.name == 'police' and ]](GetDistanceBetweenCoords(coords, v.Marker.x, v.Marker.y, v.Marker.z, true) < Config.DrawDistance) then
				DrawMarker(Config.MarkerType, v.Marker.x, v.Marker.y, v.Marker.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			end
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function ()
	while true do
		Wait(100)
		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil
		
		for k,v in pairs(Config.Garages) do
			if(GetDistanceBetweenCoords(coords, v.Marker.x, v.Marker.y, v.Marker.z, true) < v.Size.x) then
				isInMarker  = true
				currentZone = k
				CurrentGarage = v
			end
		end

		for k,v in pairs(Config.Impound) do
			if --[[PlayerData.job ~= nil and PlayerData.job.name == 'police' and ]](GetDistanceBetweenCoords(coords, v.Marker.x, v.Marker.y, v.Marker.z, true) < v.Size.x) then
				isInMarker  = true
				currentZone = k
				CurrentGarage = v
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerEvent('netr_garages:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('netr_garages:hasExitedMarker', LastZone)
		end
	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if CurrentAction ~= nil then
			local playerPed  = GetPlayerPed(-1)
			if IsPedInAnyVehicle(playerPed) then
				if(GetVehicleEngineHealth(GetVehiclePedIsIn(playerPed)) >= 950.0) then
					DisplayHelpText("Wcisnij ~INPUT_CONTEXT~ aby ~g~SCHOWAĆ~w~ ten pojazd")
				else
					--exports['mythic_notify']:DoCustomHudText('error', 'Aby schować ten pojazd musisz go najpierw naprawić u mechanika', 3500)
					--DisplayHelpText("~r~Aby schować ten pojazd musisz go najpierw naprawić u mechanika!")
				end
			else
				DisplayHelpText("Wciśnij ~INPUT_CONTEXT~ aby ~b~wyciągnąć~w~ pojazd")
			end
			if IsControlJustPressed(0, Keys['E']) then
				if CurrentAction == 'parking_menu' then
					local coords      = GetEntityCoords(GetPlayerPed(-1))
					for k,v in pairs(Config.Garages) do
						if(GetDistanceBetweenCoords(coords, v.Marker.x, v.Marker.y, v.Marker.z, true) < v.Size.x * 2) then
							if IsPedInAnyVehicle(playerPed) then
								local vehicle       = GetVehiclePedIsIn(playerPed)
								if(GetVehicleEngineHealth(GetVehiclePedIsIn(playerPed)) >= 950.0) then
									local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
									local name          = GetDisplayNameFromVehicleModel(vehicleProps.model)
									local plate         = vehicleProps.plate
									local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId()))))
									local vehhash = GetHashKey(model)
									TriggerServerEvent("srp_garage:hahscheck", vehhash)
									ESX.TriggerServerCallback('netr_garages:checkIfVehicleIsOwned', function (owned, vehhash)
										if owned ~= nil then                    
											local vehPed = GetPedInVehicleSeat(vehicle, -1)
											if(vehPed ~= GetPlayerPed(-1)) then
												exports['mythic_notify']:DoCustomHudText('error', 'Musisz być kierowcą aby schować pojazd!', 3500)
												--ESX.ShowNotification("~r~Nie jestes kierowcą!\n~b~Aby schować pojazd musisz być na miejscu kierowcy!")
											else
												TriggerServerEvent("netr_garages:updateOwnedVehicle", vehicleProps, name)
												TriggerServerEvent("netr_garages:addCarToParking", vehicleProps)
												TaskLeaveVehicle(playerPed, vehicle, 16)
												ESX.Game.DeleteVehicle(vehicle)
												TriggerServerEvent("ls:removeOwner", vehicleProps.plate)
												exports['mythic_notify']:DoCustomHudText('inform', 'Pojazd został schowany do garażu!', 3500)
											end
										else
											exports['mythic_notify']:DoCustomHudText('error', 'Ten pojazd nie należy do Ciebie!', 3500)
											--ESX.ShowNotification("~r~Ten pojazd nie należy do Ciebie!")
										end
									end, vehicleProps.plate)
								else
									exports['mythic_notify']:DoCustomHudText('error', 'Aby schować ten pojazd musisz go najpierw naprawić u mechanika!', 3500)
									--ESX.ShowNotification("~r~Aby schować ten pojazd musisz go najpierw naprawić u mechanika!\n~y~LS Customs")
								end
							else
								SendNUIMessage({
									clearme = true
								})
								ESX.TriggerServerCallback('netr_garages:getVehiclesInGarage', function (vehicles)
									for i=1, #vehicles, 1 do
										SendNUIMessage({
											addcar = true,
											number = i,
											model = vehicles[i].plate,
											name = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' ' .. vehicles[i].plate
										})
									end
								end)
								openGui()
							end
						end
					end
				elseif CurrentAction == 'impound_menu' and delay <= 0 then
						ReturnVehicleMenu()
				--else
					--riggerEvent('esx:showNotification', 'Wróć za ~b~' .. delay .. '~w~ minut')
				end
				CurrentAction = nil
			end
		end
	end
end)

function ReturnVehicleMenu()
	ESX.TriggerServerCallback('netr_garages:getOwnedVehiclesOut', function (vehicles)
		local elements = {}
		for _,v in pairs(vehicles) do
			local hashVehicule = v.model
			local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
			local vehicleProps = ESX.Game.GetVehicleProperties(v.vehicle)
			table.insert(elements, {label = vehicleName..': ZWROĆ' , value = v})
		end
		ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'spawn_vehicle',
		{
			title    = 'ZWROĆ POJAZD',
			align    = 'top-left',
			elements = elements,
		},
		function(data, menu)
			local spawnCoords  = {
				x = CurrentGarage.Marker.x,
				y = CurrentGarage.Marker.y,
				z = CurrentGarage.Marker.z,
			}
			ESX.Game.SpawnVehicle(data.current.value.model, spawnCoords, 20, function(vehicle)
				TaskWarpPedIntoVehicle(PlayerPedId(),  vehicle,  -1)
				ESX.Game.SetVehicleProperties(vehicle, data.current.value)
			end)
			exports['mythic_notify']:DoCustomHudText('inform', 'Pojazd został zwrócony!', 3500)
			--TriggerEvent('esx:showNotification', '~g~Pojazd zostal zwrócony.')
			delay = 30
			ESX.UI.Menu.CloseAll()
		end,function(data, menu)
			menu.close()
		end)
	end)
end

RegisterNetEvent('netr_garages:removeDriver')
AddEventHandler('netr_garages:removeDriver', function (vehicle)
	TaskLeaveVehicle(GetPlayerPed(-1), vehicle, 16)
end)

function openGui()
	SetNuiFocus(true, true)
	SendNUIMessage({openBank = true})
end

function closeGui()
	SetNuiFocus(false)
	SendNUIMessage({openBank = false})
	bankOpen = false
	atmOpen = false
end

RegisterNUICallback('close', function(data, cb)
	closeGui()
	cb('ok')
end)

RegisterNUICallback('pullCar', function(data, cb)
	local playerPed  = GetPlayerPed(-1)
	local vehhash = GetHashKey(data.model)
	TriggerServerEvent("srp_garage:hahscheck", vehhash)
	ESX.TriggerServerCallback('netr_garages:checkIfVehicleIsOwned', function (owned)
		local spawnCoords  = {
			x = CurrentGarage.Marker.x,
			y = CurrentGarage.Marker.y,
			z = CurrentGarage.Marker.z,
		}
		TriggerServerEvent("netr_garages:removeCarFromParking", owned.plate)
		ESX.Game.SpawnVehicle(owned.model, spawnCoords, 20, function(vehicle)
			TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
			ESX.Game.SetVehicleProperties(vehicle, owned)
		end)
	end, data.model)
	closeGui()
	cb('ok')
end)

function DisplayHelpText(str)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentScaleform(str)
	EndTextCommandDisplayHelp(0, 0, 1, -1)
end

AddEventHandler('netr_garages:hasEnteredMarker', function (zone)
	if zone ~= 'I1' then
		CurrentAction     = 'parking_menu'
	else
		CurrentAction     = 'impound_menu'
	end
end)

AddEventHandler('netr_garages:hasExitedMarker', function (zone)
	if IsInShopMenu then
		IsInShopMenu = false
		CurrentGarage = nil
	end
	CurrentAction = nil
end)
