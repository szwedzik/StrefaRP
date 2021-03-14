ESX = nil
UsedPlates = {'W0000000'}
PlatesChars = {1,2,3,4,5,6,7,8,9,0,'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','R','S','T','U','W','X','Y','Z'}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
--------------UsunPojazd-------------
local delvehX = -1913.55
local delvehY = 2030.59
local delvehZ = 140.75
---
local harvestX1 = -1815.76   --punkt na zbiór 1
local harvestY1 = 2209.01
local harvestZ1 = 90.72
---
local harvestX2 = -1806.08   --punkt na zbiór 2
local harvestY2 = 2209.26
local harvestZ2 = 92.80
---
local harvestX3 = -1816.48   --punkt na zbiór 3
local harvestY3 = 2204.66
local harvestZ3 = 92.47
---
local harvestX4 = -1804.71   --punkt na zbiór 4
local harvestY4 = 2204.70
local harvestZ4 = 94.94
---
local harvestX5 = -1813.64   --punkt na zbiór 5
local harvestY5 = 2200.08
local harvestZ5 = 94.92
---
local harvestX6 = -1803.23   --punkt na zbiór 6
local harvestY6 = 2200.06
local harvestZ6 = 97.27
---
local harvestX7 = -1811.08   --punkt na zbiór 7
local harvestY7 = 2213.81
local harvestZ7 = 90.05
---
local harvestX8 = -1804.68   --punkt na zbiór 8
local harvestY8 = 2213.79
local harvestZ8 = 91.44
---
local harvestX9 = -1798.66  --punkt na zbiór 9
local harvestY9 = 2213.74
local harvestZ9 = 92.95
---
local harvestX10 = -1798.74  --punkt na zbiór 10
local harvestY10 = 2209.03
local harvestZ10 = 94.70
---
local harvestX11 = -1798.66  --punkt na zbiór 11
local harvestY11 = 2204.46
local harvestZ11 = 96.46
---
local harvestX12 = -1797.74  --punkt na zbiór 12
local harvestY12 = 2199.86
local harvestZ12 = 98.51
---
local washgrapesX = -1878.12    -- mycie winogron
local washgrapesY = 2078.13
local washgrapesZ = 141.60
---
local washgrapesX2 = -1875.64    -- mycie winogron
local washgrapesY2 = 2084.14
local washgrapesZ2 = 141.60
---
local washgrapesX3 = -1876.94    -- mycie winogron
local washgrapesY3 = 2081.10
local washgrapesZ3 = 141.60
---
local processingintowineX = 1703.73   --punkt na przetwarzanie na wino
local processingintowineY = 4733.55
local processingintowineZ = 42.15
---
local processingintojusX = 828.50    --punkt przetwarzanie na sok
local processingintojusY = 2191.37
local processingintojusZ = 51.38
--- /tp 2670.98 3283.60 55.24
local sellwineX = -1264.58    --punkt sprzedazy wina
local sellwineY = -1163.4
local sellwineZ = 6.78
---
local selljusX = -1267.23    --punkt sprzedazy soku
local selljusY = -1158.50
local selljusZ = 6.78

---------------------------------------------

local prop
-----
local JobBlips                = {}
local publicBlip = false
local isInService = false
local PlayerData              = nil
local GUI                     = {}
GUI.Time                      = 0
local hasAlreadyEnteredMarker = false
local lastZone                = nil
local Blips                   = {}
-----
local plaquevehicule = ""
local CurrentAction           = nil
local CurrentActionMsg        = ''
-- blokady na E
local timerharvest = false
local timerwash = false
local timerprocessingintojus = false
local timerprocessingintowine = false
local timerselljus = false
local timersellwine = false
--------------
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

--------------------------------------------------------------------------------
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	blips()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	deleteBlips()
	blips()
end)

-- MENU
function MenuCloakRoom()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'cloakroom',
		{
			title    = _U('cloakroom'),
			elements = {
				{label = _U('job_wear'), value = 'job_wear'},
				{label = _U('citizen_wear'), value = 'citizen_wear'}
			}
		},
		function(data, menu)
			if data.current.value == 'citizen_wear' then
				isInService = false
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
			TriggerEvent('skinchanger:loadSkin', skin)
		end)
      end
			if data.current.value == 'job_wear' then
				isInService = true
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					if skin.sex == 0 then
						TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
					else
						TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
					end
				end)
			end	
			menu.close()
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function MenuVehicleSpawner()
	local elements = {}

	for i=1, #Config.Trucks, 1 do
		table.insert(elements, {label = GetLabelText(GetDisplayNameFromVehicleModel(Config.Trucks[i])), value = Config.Trucks[i]})
	end


	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'vehiclespawner',
		{
			title    = _U('vehiclespawner'),
			elements = elements
		},
		function(data, menu)
			if ESX.Game.IsSpawnPointClear(Config.Zones.VehicleSpawnPoint.Pos, 5.2) then
				ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 50.0, function(vehicle)
					local playerPed = GetPlayerPed(-1)
					TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1) 
					platenum = VehiclePlaqueMaker('Winiarz')
					SetVehicleNumberPlateText(vehicle, platenum)             
					plaquevehicule = platenum
				end)
			else
				exports['mythic_notify']:DoCustomHudText('error', 'Wyjazd z garażu zablokowany!', 3000)
			end
			menu.close()
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function IsATruck()
	local isATruck = false
	local playerPed = GetPlayerPed(-1)
	for i=1, #Config.Trucks, 1 do
		if IsVehicleModel(GetVehiclePedIsUsing(playerPed), Config.Trucks[i]) then
			isATruck = true
			break
		end
	end
	return isATruck
end

function IsJobWineMaker()
	if PlayerData ~= nil then
		local IsJobWineMaker = false
		if PlayerData.job.name ~= nil and PlayerData.job.name == 'winemaker' then
			IsJobWineMaker = true
		end
		return IsJobWineMaker
	end
end

----Usuwanie Pojazdów
Citizen.CreateThread(function()
	while true do
       	 Citizen.Wait(0)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, delvehX, delvehY, delvehZ)
---
			if isInService and IsJobWineMaker() and dist <= 50.0 then
			DrawMarker(27, delvehX, delvehY, delvehZ-0.97, 0, 0, 0, 0, 0, 0, 2.50, 2.50, 2.00, 255, 0, 0, 200, 0, 0, 0, 0)
			else
			Citizen.Wait(1500)
			end
			
			if isInService and IsJobWineMaker() and dist <= 2.5 then
			DrawText3D(delvehX, delvehY, delvehZ, "~g~[E]~w~ Aby schować pojazd do garażu")
			end
--
			if isInService and IsJobWineMaker() and dist <= 2.5 then
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					local playerPed = PlayerPedId()
					if IsPedSittingInAnyVehicle(playerPed) then
						local vehicle = GetVehiclePedIsIn(playerPed, false)
						if GetPedInVehicleSeat(vehicle, -1) == playerPed then
							--ESX.ShowNotification("~y~Pojazd został schowany do garażu.")
							exports['mythic_notify']:DoCustomHudText('success', 'Pojazd został schowany do garażu!', 3500)
							ESX.Game.DeleteVehicle(vehicle)
						else
							--ESX.ShowNotification("~y~Musisz być kierowcą aby schować pojazd.")
							exports['mythic_notify']:DoCustomHudText('error', 'Musisz być kierowcą aby schować pojazd!', 3500)
						end
					end			
				end
			end
	end
end)
-----------Text3D
function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
--[[
    local factor = (string.len(text)) / 370
	DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 90)
  ]]
end
----Zrywanie Winogron
Citizen.CreateThread(function()
	while true do
       	 Citizen.Wait(0)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, harvestX1, harvestY1, harvestZ1)
---
			if isInService and IsJobWineMaker() and dist <= 20.0 and timerharvest == false then
				DrawMarker(27, harvestX1, harvestY1, harvestZ1-0.97, 0, 0, 0, 0, 0, 0, 0.70, 0.70, 1.00, 0, 205, 50, 200, 0, 0, 0, 0)
			else
				Citizen.Wait(1500)
			end
			
			if isInService and IsJobWineMaker() and dist <= 2.5 and timerharvest == false then
				DrawText3D(harvestX1, harvestY1, harvestZ1, "~g~[E]~w~ Aby zrywać Winogrona")
			end
--
			if isInService and IsJobWineMaker() and dist <= 2.5 and timerharvest == false then
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					HarvestGrapes(1)
				end	
			end
	end
end)
Citizen.CreateThread(function()
	while true do
       	 Citizen.Wait(0)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, harvestX2, harvestY2, harvestZ2)
---
			if isInService and IsJobWineMaker() and dist <= 20.0 and timerharvest == false then
				DrawMarker(27, harvestX2, harvestY2, harvestZ2-0.97, 0, 0, 0, 0, 0, 0, 0.70, 0.70, 1.00, 0, 205, 50, 200, 0, 0, 0, 0)
			else
				Citizen.Wait(1500)
			end
			
			if isInService and IsJobWineMaker() and dist <= 2.5 and timerharvest == false then
				DrawText3D(harvestX2, harvestY2, harvestZ2, "~g~[E]~w~ Aby zrywać Winogrona")
			end
--
			if isInService and IsJobWineMaker() and dist <= 2.5 and timerharvest == false then
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					HarvestGrapes(1)
				end	
			end
	end
end)
Citizen.CreateThread(function()
	while true do
       	 Citizen.Wait(0)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, harvestX3, harvestY3, harvestZ3)
---
			if isInService and IsJobWineMaker() and dist <= 20.0 and timerharvest == false then
				DrawMarker(27, harvestX3, harvestY3, harvestZ3-0.97, 0, 0, 0, 0, 0, 0, 0.70, 0.70, 1.00, 0, 205, 50, 200, 0, 0, 0, 0)
			else
				Citizen.Wait(1500)
			end
			
			if isInService and IsJobWineMaker() and dist <= 2.5 and timerharvest == false then
				DrawText3D(harvestX3, harvestY3, harvestZ3, "~g~[E]~w~ Aby zrywać Winogrona")
			end
--
			if isInService and IsJobWineMaker() and dist <= 2.5 and timerharvest == false then
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					HarvestGrapes(1)
				end	
			end
	end
end)
Citizen.CreateThread(function()
	while true do
       	 Citizen.Wait(0)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, harvestX4, harvestY4, harvestZ4)
---
			if isInService and IsJobWineMaker() and dist <= 20.0 and timerharvest == false then
				DrawMarker(27, harvestX4, harvestY4, harvestZ4-0.97, 0, 0, 0, 0, 0, 0, 0.70, 0.70, 1.00, 0, 205, 50, 200, 0, 0, 0, 0)
			else
				Citizen.Wait(1500)
			end
			
			if isInService and IsJobWineMaker() and dist <= 2.5 and timerharvest == false then
				DrawText3D(harvestX4, harvestY4, harvestZ4, "~g~[E]~w~ Aby zrywać Winogrona")
			end
--
			if isInService and IsJobWineMaker() and dist <= 2.5 and timerharvest == false then
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					HarvestGrapes(1)
				end	
			end
	end
end)
Citizen.CreateThread(function()
	while true do
       	 Citizen.Wait(0)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, harvestX5, harvestY5, harvestZ5)
---
			if isInService and IsJobWineMaker() and dist <= 20.0 and timerharvest == false then
				DrawMarker(27, harvestX5, harvestY5, harvestZ5-0.97, 0, 0, 0, 0, 0, 0, 0.70, 0.70, 1.00, 0, 205, 50, 200, 0, 0, 0, 0)
			else
				Citizen.Wait(1500)
			end
			
			if isInService and IsJobWineMaker() and dist <= 2.5 and timerharvest == false then
				DrawText3D(harvestX5, harvestY5, harvestZ5, "~g~[E]~w~ Aby zrywać Winogrona")
			end
--
			if isInService and IsJobWineMaker() and dist <= 2.5 and timerharvest == false then
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					HarvestGrapes(1)
				end	
			end
	end
end)
Citizen.CreateThread(function()
	while true do
       	 Citizen.Wait(0)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, harvestX6, harvestY6, harvestZ6)
---
			if isInService and IsJobWineMaker() and dist <= 20.0 and timerharvest == false then
				DrawMarker(27, harvestX6, harvestY6, harvestZ6-0.97, 0, 0, 0, 0, 0, 0, 0.70, 0.70, 1.00, 0, 205, 50, 200, 0, 0, 0, 0)
			else
				Citizen.Wait(1500)
			end
			
			if isInService and IsJobWineMaker() and dist <= 2.5 and timerharvest == false then
				DrawText3D(harvestX6, harvestY6, harvestZ6, "~g~[E]~w~ Aby zrywać Winogrona")
			end
--
			if isInService and IsJobWineMaker() and dist <= 2.5 and timerharvest == false then
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					HarvestGrapes(1)
				end	
			end
	end
end)
Citizen.CreateThread(function()
	while true do
       	 Citizen.Wait(0)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, harvestX7, harvestY7, harvestZ7)
---
			if isInService and IsJobWineMaker() and dist <= 20.0 and timerharvest == false then
				DrawMarker(27, harvestX7, harvestY7, harvestZ7-0.97, 0, 0, 0, 0, 0, 0, 0.70, 0.70, 1.00, 0, 205, 50, 200, 0, 0, 0, 0)
			else
				Citizen.Wait(1500)
			end
			
			if isInService and IsJobWineMaker() and dist <= 2.5 and timerharvest == false then
				DrawText3D(harvestX7, harvestY7, harvestZ7, "~g~[E]~w~ Aby zrywać Winogrona")
			end
--
			if isInService and IsJobWineMaker() and dist <= 2.5 and timerharvest == false then
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					HarvestGrapes(1)
				end	
			end
	end
end)
Citizen.CreateThread(function()
	while true do
       	 Citizen.Wait(0)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, harvestX8, harvestY8, harvestZ8)
---
			if isInService and IsJobWineMaker() and dist <= 20.0 and timerharvest == false then
				DrawMarker(27, harvestX8, harvestY8, harvestZ8-0.97, 0, 0, 0, 0, 0, 0, 0.70, 0.70, 1.00, 0, 205, 50, 200, 0, 0, 0, 0)
			else
				Citizen.Wait(1500)
			end
			
			if isInService and IsJobWineMaker() and dist <= 2.5 and timerharvest == false then
				DrawText3D(harvestX8, harvestY8, harvestZ8, "~g~[E]~w~ Aby zrywać Winogrona")
			end
--
			if isInService and IsJobWineMaker() and dist <= 2.5 and timerharvest == false then
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					HarvestGrapes(1)
				end	
			end
	end
end)
Citizen.CreateThread(function()
	while true do
       	 Citizen.Wait(0)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, harvestX9, harvestY9, harvestZ9)
---
			if isInService and IsJobWineMaker() and dist <= 20.0 and timerharvest == false then
				DrawMarker(27, harvestX9, harvestY9, harvestZ9-0.97, 0, 0, 0, 0, 0, 0, 0.70, 0.70, 1.00, 0, 205, 50, 200, 0, 0, 0, 0)
			else
				Citizen.Wait(1500)
			end
			
			if isInService and IsJobWineMaker() and dist <= 2.5 and timerharvest == false then
				DrawText3D(harvestX9, harvestY9, harvestZ9, "~g~[E]~w~ Aby zrywać Winogrona")
			end
--
			if isInService and IsJobWineMaker() and dist <= 2.5 and timerharvest == false then
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					HarvestGrapes(1)
				end	
			end
	end
end)
Citizen.CreateThread(function()
	while true do
       	 Citizen.Wait(0)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, harvestX10, harvestY10, harvestZ10)
---
			if isInService and IsJobWineMaker() and dist <= 20.0 and timerharvest == false then
				DrawMarker(27, harvestX10, harvestY10, harvestZ10-0.97, 0, 0, 0, 0, 0, 0, 0.70, 0.70, 1.00, 0, 205, 50, 200, 0, 0, 0, 0)
			else
				Citizen.Wait(1500)
			end
			
			if isInService and IsJobWineMaker() and dist <= 2.5 and timerharvest == false then
				DrawText3D(harvestX10, harvestY10, harvestZ10, "~g~[E]~w~ Aby zrywać Winogrona")
			end
--
			if isInService and IsJobWineMaker() and dist <= 2.5 and timerharvest == false then
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					HarvestGrapes(1)
				end	
			end
	end
end)
Citizen.CreateThread(function()
	while true do
       	 Citizen.Wait(0)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, harvestX11, harvestY11, harvestZ11)
---
			if isInService and IsJobWineMaker() and dist <= 20.0 and timerharvest == false then
				DrawMarker(27, harvestX11, harvestY11, harvestZ11-0.97, 0, 0, 0, 0, 0, 0, 0.70, 0.70, 1.00, 0, 205, 50, 200, 0, 0, 0, 0)
			else
				Citizen.Wait(1500)
			end
			
			if isInService and IsJobWineMaker() and dist <= 2.5 and timerharvest == false then
				DrawText3D(harvestX11, harvestY11, harvestZ11, "~g~[E]~w~ Aby zrywać Winogrona")
			end
--
			if isInService and IsJobWineMaker() and dist <= 2.5 and timerharvest == false then
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					HarvestGrapes(1)
				end	
			end
	end
end)
Citizen.CreateThread(function()
	while true do
       	 Citizen.Wait(0)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, harvestX12, harvestY12, harvestZ12)
---
			if isInService and IsJobWineMaker() and dist <= 20.0 and timerharvest == false then
				DrawMarker(27, harvestX12, harvestY12, harvestZ12-0.97, 0, 0, 0, 0, 0, 0, 0.70, 0.70, 1.00, 0, 205, 50, 200, 0, 0, 0, 0)
			else
				Citizen.Wait(1500)
			end
			
			if isInService and IsJobWineMaker() and dist <= 2.5 and timerharvest == false then
				DrawText3D(harvestX12, harvestY12, harvestZ12, "~g~[E]~w~ Aby zrywać Winogrona")
			end
--
			if isInService and IsJobWineMaker() and dist <= 2.5 and timerharvest == false then
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					HarvestGrapes(1)
				end	
			end
	end
end)
------------Mycie Winogron
Citizen.CreateThread(function()
	while true do
       	 Citizen.Wait(0)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, washgrapesX, washgrapesY, washgrapesZ)
---
			if isInService and IsJobWineMaker() and dist <= 20.0 and timerwash == false then
				DrawMarker(27, washgrapesX, washgrapesY, washgrapesZ-0.97, 0, 0, 0, 0, 0, 0, 1.90, 1.90, 1.00, 0, 255, 0, 200, 0, 0, 0, 0)
			else
				Citizen.Wait(1500)
			end
			
			if isInService and IsJobWineMaker() and dist <= 1.5 and timerwash == false then
				DrawText3D(washgrapesX, washgrapesY, washgrapesZ, "~g~[E]~w~ Aby umyć Winogrona")
			end
--
			if isInService and IsJobWineMaker() and dist <= 1.5 and timerwash == false then
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					WashGrapes(1)
				end	
			end
	end
end)
------------Mycie Winogron 2
Citizen.CreateThread(function()
	while true do
       	 Citizen.Wait(0)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, washgrapesX2, washgrapesY2, washgrapesZ2)
---
			if isInService and IsJobWineMaker() and dist <= 20.0 and timerwash == false then
				DrawMarker(27, washgrapesX2, washgrapesY2, washgrapesZ2-0.97, 0, 0, 0, 0, 0, 0, 1.90, 1.90, 1.00, 0, 255, 0, 200, 0, 0, 0, 0)
			else
				Citizen.Wait(1500)
			end
			
			if isInService and IsJobWineMaker() and dist <= 1.5 and timerwash == false then
				DrawText3D(washgrapesX2, washgrapesY2, washgrapesZ2, "~g~[E]~w~ Aby umyć Winogrona")
			end
--
			if isInService and IsJobWineMaker() and dist <= 1.5 and timerwash == false then
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					WashGrapes(1)
				end	
			end
	end
end)
------------Mycie Winogron 3
Citizen.CreateThread(function()
	while true do
       	 Citizen.Wait(0)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, washgrapesX3, washgrapesY3, washgrapesZ3)
---
			if isInService and IsJobWineMaker() and dist <= 20.0 and timerwash == false then
				DrawMarker(27, washgrapesX3, washgrapesY3, washgrapesZ3-0.97, 0, 0, 0, 0, 0, 0, 1.90, 1.90, 1.00, 0, 255, 0, 200, 0, 0, 0, 0)
			else
				Citizen.Wait(1500)
			end
			
			if isInService and IsJobWineMaker() and dist <= 1.5 and timerwash == false then
				DrawText3D(washgrapesX3, washgrapesY3, washgrapesZ3, "~g~[E]~w~ Aby umyć Winogrona")
			end
--
			if isInService and IsJobWineMaker() and dist <= 1.5 and timerwash == false then
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					WashGrapes(1)
				end	
			end
	end
end)
-----------Przeróbka na Wino
Citizen.CreateThread(function()
	while true do
       	 Citizen.Wait(0)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, processingintowineX, processingintowineY, processingintowineZ)
---
			if isInService and IsJobWineMaker() and dist <= 20.0 and timerprocessingintowine == false then
				DrawMarker(27, processingintowineX, processingintowineY, processingintowineZ-0.97, 0, 0, 0, 0, 0, 0, 3.00, 3.00, 1.00, 255, 255, 0, 200, 0, 0, 0, 0)
			else
				Citizen.Wait(1500)
			end
			
			if isInService and IsJobWineMaker() and dist <= 2.5 and timerprocessingintowine == false then
				DrawText3D(processingintowineX, processingintowineY, processingintowineZ, "~g~[E]~w~ Aby przerobić na Wino")
			end
--
			if isInService and IsJobWineMaker() and dist <= 2.5 and timerprocessingintowine == false then
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					Processingintowine(1)
				end	
			end
	end
end)
----------Przeróbka na sok
Citizen.CreateThread(function()
	while true do
       	 Citizen.Wait(0)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, processingintojusX, processingintojusY, processingintojusZ)
---
			if isInService and IsJobWineMaker() and dist <= 20.0 and timerprocessingintojus == false then
				DrawMarker(27, processingintojusX, processingintojusY, processingintojusZ-0.97, 0, 0, 0, 0, 0, 0, 3.00, 3.00, 1.00, 0, 205, 255, 200, 0, 0, 0, 0)
			else
				Citizen.Wait(1500)
			end
			
			if isInService and IsJobWineMaker() and dist <= 2.5 and timerprocessingintojus == false then
				DrawText3D(processingintojusX, processingintojusY, processingintojusZ, "~g~[E]~w~ Aby wymienić Winogrona na Sok Winogronowy")
			end
--
			if isInService and IsJobWineMaker() and dist <= 2.5 and timerprocessingintojus == false then
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					Processingintojus(1)
				end	
			end
	end
end)
---------------------------------
Citizen.CreateThread(function()
	while true do  
	  Citizen.Wait(0)
		if disablecontrols == true then
		  FreezeEntityPosition(GetPlayerPed(-1), true)
          DisableControlAction(0,21,true) -- disable sprint
          DisableControlAction(0,24,true) -- disable attack
          DisableControlAction(0,25,true) -- disable aim
          DisableControlAction(0,47,true) -- disable weapon
          DisableControlAction(0,58,true) -- disable weapon
          DisableControlAction(0,263,true) -- disable melee
          DisableControlAction(0,264,true) -- disable melee
          DisableControlAction(0,257,true) -- disable melee
          DisableControlAction(0,140,true) -- disable melee
          DisableControlAction(0,141,true) -- disable melee
          DisableControlAction(0,142,true) -- disable melee
          DisableControlAction(0,143,true) -- disable melee
          DisableControlAction(0,75,true) -- disable exit vehicle
          DisableControlAction(27,75,true) -- disable exit vehicle
          DisableControlAction(0,32,true) -- move (w)
          DisableControlAction(0,34,true) -- move (a)
          DisableControlAction(0,33,true) -- move (s)
          DisableControlAction(0,35,true) -- move (d)
		  DisableControlAction(0, 142, true) -- MeleeAttackAlternate
		  DisableControlAction(0, 24,  true) -- Shoot 
		  DisableControlAction(0, 92,  true) -- Shoot in car
		  DisableControlAction(0, 24,  true)
		  DisableControlAction(0, 25,  true)
		  DisableControlAction(0, 45,  true)
		  DisableControlAction(0, 76,  true)
		  DisableControlAction(0, 102,  true)
		  DisableControlAction(0, 278,  true)
		  DisableControlAction(0, 279,  true)
		  DisableControlAction(0, 280,  true)
		  DisableControlAction(0, 281,  true)
		  DisableControlAction(0, 140, true) -- Attack
		  DisableControlAction(0, 24, true) -- Attack
		  DisableControlAction(0, 25, true) -- Attack
		  DisableControlAction(2, 24, true) -- Attack
		  DisableControlAction(2, 257, true) -- Attack 2
		  DisableControlAction(2, 25, true) -- Aim
		  DisableControlAction(2, 263, true) -- Melee Attack 1
		  DisableControlAction(2, Keys['R'], true) -- Reload
		  DisableControlAction(2, Keys['LEFTALT'], true)
		  DisableControlAction(2, Keys['TOP'], true) -- Open phone (not needed?)
		  DisableControlAction(2, Keys['Q'], true) -- Cover
		  DisableControlAction(2, Keys['TAB'], true) -- Select Weapon
		  DisableControlAction(2, Keys['F1'], true) -- Disable phone
		  DisableControlAction(2, Keys['F2'], true) -- Inventory
		  DisableControlAction(2, Keys['F3'], true) -- Animations
		  DisableControlAction(2, Keys['F6'], true)
		  DisableControlAction(2, Keys['F7'], true)
		  DisableControlAction(2, Keys['F9'], true)
		  DisableControlAction(2, Keys['F10'], true)
		  DisableControlAction(2, Keys['Y'], true)
		  DisableControlAction(0, Keys['A'], true)
		  DisableControlAction(0, Keys['D'], true)
		  DisableControlAction(0, Keys['W'], true)
		  DisableControlAction(0, Keys['S'], true)
		  DisableControlAction(2, Keys['A'], true)
		  DisableControlAction(2, Keys['D'], true)
		  DisableControlAction(2, Keys['W'], true)
		  DisableControlAction(2, Keys['S'], true)
		  DisableControlAction(2, Keys["~"], true) 
		  DisableControlAction(2, Keys["X"], true)
		  DisableControlAction(0, Keys["X"], true)  
		  DisableControlAction(2, Keys["T"], true)
		  DisableControlAction(0, Keys["T"], true) 
  		end
	end
end)

-------------Zrywanie
function HarvestGrapes(workplace)
	local source = GetPlayerServerId(PlayerId())
	local ped = GetPlayerPed(-1)
	local inveh = IsPedInAnyVehicle(ped, false)
	local dict = 'anim@gangops@facility@servers@'
	local inventory = ESX.GetPlayerData().inventory
	local count = 0
	--[[for i=1, #inventory, 1 do
		if inventory[i].name == 'raisin' then
		count = inventory[i].count
		end
	end]]
	if inveh then
		--ESX.ShowNotification("~r~Nie możesz zrywać winogron siedząc w pojeździe!")
		exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz zrywać winogron siedząc w pojeździe!', 3500)
	else
		timerharvest = true
		TriggerServerEvent('srp_winemaker:harvest', source)
	end
end

RegisterNetEvent("srp_winemaker:harvesttimerstop")
AddEventHandler("srp_winemaker:harvesttimerstop", function(source)
	timerharvest = false
end)

RegisterNetEvent("srp_winemaker:harvestfunction")
AddEventHandler("srp_winemaker:harvestfunction", function(source)
	local ped = GetPlayerPed(-1)
	local dict = 'anim@gangops@facility@servers@'
		--if (count >= 0 and count <= 75) then
		LoadDict(dict)
		TaskPlayAnim(ped, dict, "hotwire", 3.0, -8, -1, 63, 0, 0, 0, 0 )
		if workplace == 1 then
			SetEntityHeading(ped, 178.0)
			FreezeEntityPosition(ped, true)
		end
		exports['mythic_progbar']:Progress({
			name = "firstaid_action",
			duration = 5000,
			label = "Zrywanie Winogron...",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			},
		})
		Citizen.Wait(5000)---------
		ClearPedTasks(ped)
		TriggerServerEvent('srp_winemaker:harvestpay', source)
		FreezeEntityPosition(ped, false)
		timerharvest = false
		--[[elseif (count >= 75 and count <= 99) then
			exports['mythic_notify']:DoCustomHudText('error', 'Nie udźwigniesz więcej winogron!', 3500)]]
		--[[elseif (count > 100) then
			--ESX.ShowNotification("Masz za dużo winogron przy sobie!")
			exports['mythic_notify']:DoCustomHudText('error', 'Masz za dużo winogron przy sobie!', 3500)
		end]]
end)
-------------Mycie
function WashGrapes(workplace)
	local source = GetPlayerServerId(PlayerId())
	local ped = GetPlayerPed(-1)
	local inveh = IsPedInAnyVehicle(ped, false)
	local inventory = ESX.GetPlayerData().inventory
	local count = 0
	--[[for i=1, #inventory, 1 do
		if inventory[i].name == 'raisin' then
		count = inventory[i].count
		end
	end]]
	if inveh then
		--ESX.ShowNotification("~r~Nie możesz myć Winogron siedząc w pojeździe!")
		exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz myć Winogron siedząc w pojeździe!', 3500)
	else
		timerwash = true
		TriggerServerEvent('srp_winemaker:wash', source)
	end
end

RegisterNetEvent("srp_winemaker:washtimerstop")
AddEventHandler("srp_winemaker:washtimerstop", function(source)
	timerwash = false
end)

RegisterNetEvent("srp_winemaker:washfunction")
AddEventHandler("srp_winemaker:washfunction", function()
	local source = GetPlayerServerId(PlayerId())
	local ped = GetPlayerPed(-1)
	local dict = 'anim@gangops@facility@servers@'
		--if (count >= 1 and count <= 100) then	
			--FreezeEntityPosition(GetPlayerPed(-1), true)
			LoadDict('amb@medic@standing@tendtodead@idle_a')
			TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@idle_a', 'idle_a', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
			exports['mythic_progbar']:Progress({
				name = "firstaid_action",
				duration = 5000,
				label = "Mycie Winogron...",
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				},
			})
			Citizen.Wait(5000)
			LoadDict('amb@medic@standing@tendtodead@exit')
			TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@exit', 'exit', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
			Citizen.Wait(1000)
			if workplace == 1 then
				SetEntityHeading(GetPlayerPed(-1), 175.0)
			end
		Citizen.Wait(1000)---------
		TriggerServerEvent('srp_winemaker:washpay', source)
		--FreezeEntityPosition(GetPlayerPed(-1), false)
		ClearPedTasks(GetPlayerPed(-1))
		Citizen.Wait(50)
		timerwash = false
		--[[elseif (count > 100) then
			--ESX.ShowNotification("Masz za dużo winogron przy sobie!")
			exports['mythic_notify']:DoCustomHudText('error', 'Masz za dużo winogron przy sobie!', 3500)
		end]]
end)
-------------Przerabianie na Sok
function Processingintojus(workplace)
	local source = GetPlayerServerId(PlayerId())
	local ped = GetPlayerPed(-1)
	local inveh = IsPedInAnyVehicle(ped, false)
	local inventory = ESX.GetPlayerData().inventory
	local count = 0
	--[[for i=1, #inventory, 1 do
		if inventory[i].name == 'clean_raisin' then
		count = inventory[i].count
		end
	end]]
	if inveh then
		--ESX.ShowNotification("~r~Nie możesz przerabiać winogron na sok siedząc w pojeździe!")
		exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz przerabiać winogron na sok siedząc w pojeździe!', 3500)
	else
		timerprocessingintojus = true
		TriggerServerEvent('srp_winemaker:processingintojus', source)
	end
end

RegisterNetEvent("srp_winemaker:processingintojustimerstop")
AddEventHandler("srp_winemaker:processingintojustimerstop", function(source)
	timerprocessingintojus = false
end)

RegisterNetEvent("srp_winemaker:processingintojusfunction")
AddEventHandler("srp_winemaker:processingintojusfunction", function(source)
	local source = GetPlayerServerId(PlayerId())
	local ped = GetPlayerPed(-1)
	local dict = 'anim@gangops@facility@servers@'
	--if (count >= 20) then
		--FreezeEntityPosition(GetPlayerPed(-1), true)
		LoadDict('amb@medic@standing@tendtodead@idle_a')
		TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@idle_a', 'idle_a', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
		exports['mythic_progbar']:Progress({
			name = "firstaid_action",
			duration = 3000,
			label = "Wytwarzanie Soku...",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			},
		})
		Citizen.Wait(3000)
		LoadDict('amb@medic@standing@tendtodead@exit')
		TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@exit', 'exit', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
		Citizen.Wait(500)
		if workplace == 1 then
			SetEntityHeading(GetPlayerPed(-1), 71.0)
		end
	Citizen.Wait(1500)---------
	--FreezeEntityPosition(GetPlayerPed(-1), false)
	ClearPedTasks(GetPlayerPed(-1))
	TriggerServerEvent('srp_winemaker:processingintojuspay', source)
	Citizen.Wait(50)
	timerprocessingintojus = false
	--[[elseif (count <= 19) then
		--ESX.ShowNotification("~y~Nie masz wystarczającej ilości Winogron do przerobienia.")
		exports['mythic_notify']:DoCustomHudText('error', 'Nie masz wystarczającej ilości Winogron do przerobienia!', 3500)
	end]]
end)

-------------Przerabianie na Wino
function Processingintowine(workplace)
	local source = GetPlayerServerId(PlayerId())
	local ped = GetPlayerPed(-1)
	local inveh = IsPedInAnyVehicle(ped, false)
	local inventory = ESX.GetPlayerData().inventory
	local count = 0
	--[[for i=1, #inventory, 1 do
		if inventory[i].name == 'clean_raisin' then
		count = inventory[i].count
		end
	end]]
	if inveh then
		--ESX.ShowNotification("~r~Nie możesz przerabiać winogron na wino siedząc w pojeździe!")
		exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz przerabiać winogron na wino siedząc w pojeździe!', 3500)
	else
		timerprocessingintowine = true
		TriggerServerEvent('srp_winemaker:processingintowine', source)
	end
end

RegisterNetEvent("srp_winemaker:processingintowinetimerstop")
AddEventHandler("srp_winemaker:processingintowinetimerstop", function(source)
	timerprocessingintowine = false
end)

RegisterNetEvent("srp_winemaker:processingintowinefunction")
AddEventHandler("srp_winemaker:processingintowinefunction", function(source)
	local source = GetPlayerServerId(PlayerId())
	local ped = GetPlayerPed(-1)
	local dict = 'anim@gangops@facility@servers@'
	--if (count >= 20) then
		--FreezeEntityPosition(GetPlayerPed(-1), true)
		LoadDict('amb@medic@standing@tendtodead@idle_a')
		TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@idle_a', 'idle_a', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
		exports['mythic_progbar']:Progress({
			name = "firstaid_action",
			duration = 5000,
			label = "Wytwarzanie Wina...",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			},
		})
		Citizen.Wait(3000)
		LoadDict('amb@medic@standing@tendtodead@exit')
		TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@exit', 'exit', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
		Citizen.Wait(500)
		if workplace == 1 then
			SetEntityHeading(GetPlayerPed(-1), 118.0)
		end
	Citizen.Wait(1500)---------
	--FreezeEntityPosition(GetPlayerPed(-1), false)
	ClearPedTasks(GetPlayerPed(-1))
	TriggerServerEvent('srp_winemaker:processingintowinepay', source)
	Citizen.Wait(50)
	timerprocessingintowine = false
	--[[elseif (count < 20) then
		--ESX.ShowNotification("~y~Nie masz wystarczającej ilości Winogron do przerobienia.")
		exports['mythic_notify']:DoCustomHudText('error', 'Nie masz wystarczającej ilości Winogron do przerobienia!', 3500)
	end]]
end)

----------Sprzedaż Wina
Citizen.CreateThread(function()
    while true do
    Citizen.Wait(5)
	local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
    local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, sellwineX, sellwineY, sellwineZ)
	
	if isInService and IsJobWineMaker() and dist <= 20.0 and timersellwine == false then
		DrawMarker(27, sellwineX, sellwineY, sellwineZ-0.96, 0, 0, 0, 0, 0, 0, 2.00, 2.00, 2.00, 0, 205, 50, 200, 0, 0, 0, 0)
	else
		Citizen.Wait(1000)
	end
	
	if isInService and IsJobWineMaker() and dist <= 2.0 and timersellwine == false then
	DrawText3D(sellwineX, sellwineY, sellwineZ+0.1, "~g~[E]~w~ Aby sprzedać Wino")
		if IsControlJustPressed(0, Keys['E']) then 
		SellWine()
		end	
	end
	
end
end)
function SellWine()
	local source = GetPlayerServerId(PlayerId())
	local ped = GetPlayerPed(-1)
	local inveh = IsPedInAnyVehicle(ped, false)
	local inventory = ESX.GetPlayerData().inventory
	local count = 0
	--[[for i=1, #inventory, 1 do
		if inventory[i].name == 'vine' then
		count = inventory[i].count
		end
	end]]
	if inveh then
		--ESX.ShowNotification("~r~Nie możesz sprzedawać wina siedząc w pojeździe!")
		exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz sprzedawać wina siedząc w pojeździe!', 3500)
	else
		timersellwine = true
		TriggerServerEvent('srp_winemaker:sellwine', source)
	end
end

RegisterNetEvent("srp_winemaker:sellwinetimerstop")
AddEventHandler("srp_winemaker:sellwinetimerstop", function(source)
	timersellwine = false
end)

RegisterNetEvent("srp_winemaker:sellwinefunction")
AddEventHandler("srp_winemaker:sellwinefunction", function(source)
	local source = GetPlayerServerId(PlayerId())
	local ped = GetPlayerPed(-1)
	local dict = 'anim@gangops@facility@servers@'
	--if (count > 0) then
		local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.9, -0.98))
		prop = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z,  true,  true, true)
		SetEntityHeading(prop, GetEntityHeading(GetPlayerPed(-1)))
		LoadDict('amb@medic@standing@tendtodead@idle_a')
		TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@idle_a', 'idle_a', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
		exports['mythic_progbar']:Progress({
			name = "firstaid_action",
			duration = 5000,
			label = "Sprzedaż Wina...",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			},
		})
		Citizen.Wait(5000)
		LoadDict('amb@medic@standing@tendtodead@exit')
		TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@exit', 'exit', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
		Citizen.Wait(1000)
		ClearPedTasks(GetPlayerPed(-1))
		DeleteEntity(prop)
		TriggerServerEvent('srp_winemaker:sellwinepay', source)
		Citizen.Wait(50)
		timersellwine = false
	--[[elseif (count < 0) then
		--ESX.ShowNotification("~r~Nie masz nic na sprzedaż")
		exports['mythic_notify']:DoCustomHudText('error', 'Nie masz nic na sprzedaż!', 3500)
	end]]
end)

----------Sprzedaż Soku
Citizen.CreateThread(function()
    while true do
    Citizen.Wait(5)
	local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
    local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, selljusX, selljusY, selljusZ)
	
	if isInService and IsJobWineMaker() and dist <= 20.0 and timerselljus == false then
		DrawMarker(27, selljusX, selljusY, selljusZ-0.96, 0, 0, 0, 0, 0, 0, 2.00, 2.00, 2.00, 0, 205, 50, 200, 0, 0, 0, 0)
	else
		Citizen.Wait(1000)
	end
	
	if isInService and IsJobWineMaker() and dist <= 2.0 and timerselljus == false then
	DrawText3D(selljusX, selljusY, selljusZ+0.1, "~g~[E]~w~ Aby sprzedać Sok Winogronowy")
		if IsControlJustPressed(0, Keys['E']) then 
		SellJus()
		end	
	end
	
end
end)
function SellJus() 
	local source = GetPlayerServerId(PlayerId())
	local ped = GetPlayerPed(-1)
	local inveh = IsPedInAnyVehicle(ped, false)
	local inventory = ESX.GetPlayerData().inventory
	local count = 0
	--[[for i=1, #inventory, 1 do
		if inventory[i].name == 'jus_raisin' then
		count = inventory[i].count
		end
	end]]
	if inveh then
		--ESX.ShowNotification("~r~Nie możesz sprzedawać soku siedząc w pojeździe!")
		exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz sprzedawać soku siedząc w pojeździe!', 3500)
	else
		timerselljus = true
		TriggerServerEvent('srp_winemaker:selljus', source)
	end
end

RegisterNetEvent("srp_winemaker:selljustimerstop")
AddEventHandler("srp_winemaker:selljustimerstop", function(source)
	timerselljus = false
end)

RegisterNetEvent("srp_winemaker:selljusfunction")
AddEventHandler("srp_winemaker:selljusfunction", function(source)
	local source = GetPlayerServerId(PlayerId())
	local ped = GetPlayerPed(-1)
	local dict = 'anim@gangops@facility@servers@'
	--if (count > 0) then
		local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.9, -0.98))
		prop = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z,  true,  true, true)
		SetEntityHeading(prop, GetEntityHeading(GetPlayerPed(-1)))
		LoadDict('amb@medic@standing@tendtodead@idle_a')
		TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@idle_a', 'idle_a', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
		exports['mythic_progbar']:Progress({
			name = "firstaid_action",
			duration = 5000,
			label = "Sprzedaż Soku...",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			},
		})
		Citizen.Wait(5000)
		LoadDict('amb@medic@standing@tendtodead@exit')
		TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@exit', 'exit', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
		Citizen.Wait(1000)
		ClearPedTasks(GetPlayerPed(-1))
		DeleteEntity(prop)
		TriggerServerEvent('srp_winemaker:selljuspay', source)
		Citizen.Wait(50)
		timerselljus = false
	--[[elseif (count < 0) then
		--ESX.ShowNotification("~r~Nie masz nic na sprzedaż")
		exports['mythic_notify']:DoCustomHudText('error', 'Nie masz nic na sprzedaż!', 3500)
	end]]
end)

-----
function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end

------------------Markery 
AddEventHandler('srp_winemaker:hasEnteredMarker', function(zone)
	local playerPed = GetPlayerPed(-1)

	if zone == 'CloakRoom' then
		MenuCloakRoom()
	end
	if zone == 'VehicleSpawner' then
		if isInService and IsJobWineMaker() then
			MenuVehicleSpawner()
		end
	end
end)

AddEventHandler('srp_winemaker:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()    
    CurrentAction = nil
    CurrentActionMsg = ''
end)

function round(num, numDecimalPlaces)
    local mult = 5^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

Citizen.CreateThread(function()
	while true do
		Wait(0)

		local coords = GetEntityCoords(GetPlayerPed(-1))
		
		for k,v in pairs(Config.Zones) do

			if isInService and (IsJobWineMaker() and v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end

		end

		for k,v in pairs(Config.Cloakroom) do

			if(IsJobWineMaker() and v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end

		end
		
	end
end)

Citizen.CreateThread(function()
	while true do
		
		Wait(0)
		
		if IsJobWineMaker() then

			local coords      = GetEntityCoords(GetPlayerPed(-1))
			local isInMarker  = false
			local currentZone = nil

			for k,v in pairs(Config.Zones) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker  = true
					currentZone = k
				end
			end
			
			for k,v in pairs(Config.Cloakroom) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker  = true
					currentZone = k
				end
			end

			if isInMarker and not hasAlreadyEnteredMarker then
				hasAlreadyEnteredMarker = true
				lastZone                = currentZone
				TriggerEvent('srp_winemaker:hasEnteredMarker', currentZone)
			end

			if not isInMarker and hasAlreadyEnteredMarker then
				hasAlreadyEnteredMarker = false
				TriggerEvent('srp_winemaker:hasExitedMarker', lastZone)
			end

		end

	end
end)

------------------------- BLIPY
function deleteBlips()
	if JobBlips[1] ~= nil then
		for i=1, #JobBlips, 1 do
		RemoveBlip(JobBlips[i])
		JobBlips[i] = nil
		end
	end
end

function blips()
    if PlayerData.job ~= nil and PlayerData.job.name == 'winemaker' then
		local globalblip = AddBlipForCoord(Config.Cloakroom.CloakRoom.Pos.x, Config.Cloakroom.CloakRoom.Pos.y, Config.Cloakroom.CloakRoom.Pos.z)
  
		SetBlipSprite (globalblip, 85)
		SetBlipDisplay(globalblip, 4)
		SetBlipScale  (globalblip, 0.7)
		SetBlipColour (globalblip, 69)

		SetBlipAsShortRange(globalblip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Winiarz')
		EndTextCommandSetBlipName(globalblip)
		table.insert(JobBlips, globalblip)
	end
	
    if PlayerData.job ~= nil and PlayerData.job.name == 'winemaker' then
		local sellblip = AddBlipForCoord(sellwineX, sellwineY, sellwineZ)

		SetBlipSprite (sellblip, 478)
		SetBlipDisplay(sellblip, 4)
		SetBlipScale  (sellblip, 0.7)
		SetBlipColour (sellblip, 69)

		SetBlipAsShortRange(sellblip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Skup Przetworów')
		EndTextCommandSetBlipName(sellblip)
		table.insert(JobBlips, sellblip)
	end

    if PlayerData.job ~= nil and PlayerData.job.name == 'winemaker' then
		local processingintowineblip = AddBlipForCoord(processingintowineX, processingintowineY, processingintowineZ)

		SetBlipSprite (processingintowineblip, 365)
		SetBlipDisplay(processingintowineblip, 4)
		SetBlipScale  (processingintowineblip, 0.7)
		SetBlipColour (processingintowineblip, 69)

		SetBlipAsShortRange(processingintowineblip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Wytwarzanie Wina')
		EndTextCommandSetBlipName(processingintowineblip)
		table.insert(JobBlips, processingintowineblip)
	end

    if PlayerData.job ~= nil and PlayerData.job.name == 'winemaker' then
		local harvestblip = AddBlipForCoord(harvestX1, harvestY1, harvestZ1)

		SetBlipSprite (harvestblip, 365)
		SetBlipDisplay(harvestblip, 4)
		SetBlipScale  (harvestblip, 0.7)
		SetBlipColour (harvestblip, 69)

		SetBlipAsShortRange(harvestblip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Zbiórka Winogron')
		EndTextCommandSetBlipName(harvestblip)
		table.insert(JobBlips, harvestblip)
	end

    if PlayerData.job ~= nil and PlayerData.job.name == 'winemaker' then
		local washgrapblip = AddBlipForCoord(washgrapesX, washgrapesY, washgrapesZ)

		SetBlipSprite (washgrapblip, 365)
		SetBlipDisplay(washgrapblip, 4)
		SetBlipScale  (washgrapblip, 0.7)
		SetBlipColour (washgrapblip, 69)

		SetBlipAsShortRange(washgrapblip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Mycie Winogron')
		EndTextCommandSetBlipName(washgrapblip)
		table.insert(JobBlips, washgrapblip)
	end

    if PlayerData.job ~= nil and PlayerData.job.name == 'winemaker' then
		local processingintojusblip = AddBlipForCoord(processingintojusX, processingintojusY, processingintojusZ)

		SetBlipSprite (processingintojusblip, 365)
		SetBlipDisplay(processingintojusblip, 4)
		SetBlipScale  (processingintojusblip, 0.7)
		SetBlipColour (processingintojusblip, 69)

		SetBlipAsShortRange(processingintojusblip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Wymiana Winogron na Sok')
		EndTextCommandSetBlipName(processingintojusblip)
		table.insert(JobBlips, processingintojusblip)
	end
end

-----------------------Rejestracja
function SavePlaqueVehicule()
	plaquevehicule = GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false))
end

function VehiclePlaqueMaker(job_name)
	local VehPlate = nil
	local pid = GetPlayerServerId(PlayerId())
	local pid_str = tostring(pid)
	if pid <10 then
		pid_str = '000'..pid_str
	elseif pid<100 then
		pid_str = '00'..pid_str
	elseif pid<1000 then
		pid_str = '0'..pid_str	
	end
	local job_name_str = string.upper(string.sub(tostring(job_name),1,1))
	-- 0 0000 000
	local i = math.random(1,#PlatesChars)
	local Plate6 = PlatesChars[i]
	i = math.random(1,#PlatesChars)
	local Plate7 = PlatesChars[i]
	i = math.random(1,#PlatesChars)
	local Plate8 = PlatesChars[i]
	VehPlate = job_name_str..pid_str..Plate6..Plate7..Plate8
	local RepeatCheck = true
		while RepeatCheck do
			for i=1, #UsedPlates,1 do
				if VehPlate == UsedPlates[i] then
					local j = math.random(1,#PlatesChars)
					Plate6 = PlatesChars[j]
					j = math.random(1,#PlatesChars)
					Plate7 = PlatesChars[j]
					j = math.random(1,#PlatesChars)
					Plate8 = PlatesChars[j]
					VehPlate = job_name_str..pid_str..Plate6..Plate7..Plate8
					break
				elseif i==#UsedPlates then
					RepeatCheck = false
				end

			end
		end
	
	table.insert(UsedPlates,VehPlate)
	return(VehPlate)
end

RegisterNetEvent('zrider:showUsedPlates')
AddEventHandler('zrider:showUsedPlates', function()
for i=1, #UsedPlates,1 do
	Citizen.Trace('Tablica ('..i..') '..UsedPlates[i])
end
end)