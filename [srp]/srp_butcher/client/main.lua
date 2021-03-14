ESX = nil
UsedPlates = {'B0000000'}
PlatesChars = {1,2,3,4,5,6,7,8,9,0,'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','R','S','T','U','W','X','Y','Z'}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

----------------Łapanie Kurczaków--------------------
local startX = 1444.51  --miejsce lapania kurczakow
local startY = 1078.75
local startZ = 114.33
-- /tp 1444.51 1078.75 114.33
------------------UsunPojazd-------------
local usunX = 1423.07
local usunY = 1109.65
local usunZ = 114.55
---------------------------------------------
local przetworniaX = -96.01   --punkt na przetwarzanie 1
local przetworniaY = 6207.20
local przetworniaZ = 31.02
---
local przetworniaX2 = -98.3   --punkt na przetwarzanie 2
local przetworniaY2 = 6205.4
local przetworniaZ2 = 31.12
---
local przetworniaX3 = -99.55   --punkt na przetwarzanie 3
local przetworniaY3 = 6206.46
local przetworniaZ3 = 31.13
---
local mycieX1 = -100.25   --punkt na przetwarzanie 2
local mycieY1 = 6202.71
local mycieZ1 = 31.02
---
local pakowanieX = -106.44    --punkt pakowania 1
local pakowanieY = 6204.29
local pakowanieZ = 31.02
---
local pakowanieX2 = -104.20   --punkt pakowania 2
local pakowanieY2 = 6206.45
local pakowanieZ2 = 31.02
---
local pakowanieX3 = -102.47   --punkt pakowania 3
local pakowanieY3 = 6208.44
local pakowanieZ3 = 31.02
---
local pakowanieX4 = -100.13   --punkt pakowania 4
local pakowanieY4 = 6210.51
local pakowanieZ4 = 31.02
---
local pakowanieX5 = -98.23   --punkt pakowania 5
local pakowanieY5 = 6212.52
local pakowanieZ5 = 31.02
---
local sellX = 152.33    --punkt sprzedazy
local sellY = -1478.67
local sellZ = 29.40

---------------------------------------------

--- BLOKADA na E
local timermycie = false
local timerpakowanie = false
local timerporcja = false
local timersell = false


local kurczak1
local kurczak2
local kurczak3
local Zlapany1 = 0
local Zlapany2 = 0
local Zlapany3 = 0
local Ilosczlapanych = 0
local akcja = false
local prop
local zapakowaneDoauta = false
local karton
local mieso
local pakuje = 0
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
				ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 270.0, function(vehicle)
					local playerPed = GetPlayerPed(-1)
					TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1) 
					platenum = VehiclePlaqueMaker('Butcher')
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

function IsJobbutcher()
	if PlayerData ~= nil then
		local IsJobbutcher = false
		if PlayerData.job.name ~= nil and PlayerData.job.name == 'butcher' then
			IsJobbutcher = true
		end
		return IsJobbutcher
	end
end
----Chwytanie kruczaka
Citizen.CreateThread(function()
	while true do
       	 Citizen.Wait(0)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, startX, startY, startZ)
---
			if isInService and IsJobbutcher() and dist <= 20.0 and akcja == false then
			DrawMarker(27, startX, startY, startZ-0.97, 0, 0, 0, 0, 0, 0, 1.20, 1.20, 1.20, 0, 205, 50, 200, 0, 0, 0, 0)
			else
			Citizen.Wait(1500)
			end
			
			if dist <= 2.5 and akcja == false then
			DrawText3D(startX, startY, startZ, "~g~[E]~w~ Aby rozpocząć łapanie kurczaków")
			end
--
			if isInService and IsJobbutcher() and dist <= 0.5 and akcja == false then
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					LapKurczaka()
				end			
			end
	end
end)

----Usuwanie Pojazdów
Citizen.CreateThread(function()
	while true do
       	 Citizen.Wait(0)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, usunX, usunY, usunZ)
---
			if isInService and IsJobbutcher() and dist <= 20.0 then
			DrawMarker(27, usunX, usunY, usunZ-0.97, 0, 0, 0, 0, 0, 0, 2.50, 2.50, 2.00, 255, 0, 0, 200, 0, 0, 0, 0)
			else
			Citizen.Wait(1500)
			end
			
			if isInService and IsJobbutcher() and dist <= 2.5 then
			DrawText3D(usunX, usunY, usunZ, "~g~[E]~w~ Aby schować pojazd do garażu")
			end
--
			if isInService and IsJobbutcher() and dist <= 2.5 then
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					local playerPed = PlayerPedId()
					if IsPedSittingInAnyVehicle(playerPed) then
						local vehicle = GetVehiclePedIsIn(playerPed, false)
						if GetPedInVehicleSeat(vehicle, -1) == playerPed then
							--ESX.ShowNotification("~y~Pojazd został schowany do garażu.")
							exports['mythic_notify']:DoCustomHudText('inform', 'Pojazd został schowany do garażu', 3500)
							ESX.Game.DeleteVehicle(vehicle)
						else
							--ESX.ShowNotification("~y~Musisz być kierowcą aby schować pojazd.")
							exports['mythic_notify']:DoCustomHudText('error', 'Musisz być kierowcą aby schować pojazd', 3500)
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
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 90)
end
---------------Rzeźnia CAŁA
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, przetworniaX, przetworniaY, przetworniaZ)
			local dist2 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, przetworniaX2, przetworniaY2, przetworniaZ2)
			local dist3 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, przetworniaX3, przetworniaY3, przetworniaZ3)
			local distM1 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, mycieX1, mycieY1, mycieZ1)
			local distP = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pakowanieX, pakowanieY, pakowanieZ)
			local distP2 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pakowanieX2, pakowanieY2, pakowanieZ2)
			local distP3 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pakowanieX3, pakowanieY3, pakowanieZ3)
			local distP4 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pakowanieX4, pakowanieY4, pakowanieZ4)
			local distP5 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pakowanieX5, pakowanieY5, pakowanieZ5)

			if isInService and IsJobbutcher() and dist <= 25.0 and timerporcja == false then
			DrawMarker(27, przetworniaX, przetworniaY, przetworniaZ-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 0, 205, 50, 200, 0, 0, 0, 0)
			DrawMarker(27, przetworniaX2, przetworniaY2, przetworniaZ2-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 0, 205, 50, 200, 0, 0, 0, 0)
			DrawMarker(27, przetworniaX3, przetworniaY3, przetworniaZ3-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 0, 205, 50, 200, 0, 0, 0, 0)
			else
				Citizen.Wait(500)
			end
			if isInService and IsJobbutcher() and dist <= 25.0 and timermycie == false then
			DrawMarker(27, mycieX1, mycieY1, mycieZ1-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 0, 200, 0, 0, 0, 0)
			else
				Citizen.Wait(500)
			end
			if isInService and IsJobbutcher() and dist <= 25.0 and timerpakowanie == false then
			DrawMarker(27, pakowanieX, pakowanieY, pakowanieZ-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 0, 205, 255, 200, 0, 0, 0, 0)
			DrawMarker(27, pakowanieX2, pakowanieY2, pakowanieZ2-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 0, 205, 255, 200, 0, 0, 0, 0)
			DrawMarker(27, pakowanieX3, pakowanieY3, pakowanieZ3-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 0, 205, 255, 200, 0, 0, 0, 0)
			DrawMarker(27, pakowanieX4, pakowanieY4, pakowanieZ4-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 0, 205, 255, 200, 0, 0, 0, 0)
			DrawMarker(27, pakowanieX5, pakowanieY5, pakowanieZ5-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 0, 205, 255, 200, 0, 0, 0, 0)
			else
				Citizen.Wait(500)
			end
------------------------- Porcjowanie
			if isInService and IsJobbutcher() and dist <= 2.5 and timerporcja == false then
			DrawText3D(przetworniaX, przetworniaY, przetworniaZ, "~g~[E]~w~ Aby porcjować kurczaka")
			end

            if isInService and IsJobbutcher() and dist <= 0.5 and timerporcja == false then
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					timerporcja = true
				PorcjujKurczaka(1)
				end			
            end
			
			if isInService and IsJobbutcher() and dist2 <= 2.5 and timerporcja == false then
			DrawText3D(przetworniaX2, przetworniaY2, przetworniaZ2, "~g~[E]~w~ Aby porcjować kurczaka")
			end

			if isInService and IsJobbutcher() and dist2 <= 0.5 and timerporcja == false then
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					timerporcja = true
				PorcjujKurczaka(2)
				end			
			end

			if isInService and IsJobbutcher() and dist3 <= 2.5 and timerporcja == false then
				DrawText3D(przetworniaX3, przetworniaY3, przetworniaZ3, "~g~[E]~w~ Aby porcjować kurczaka")
				end
	
				if isInService and IsJobbutcher() and dist3 <= 0.5 and timerporcja == false then
					if IsControlJustPressed(0, Keys['E']) then -- "E"
						timerporcja = true
					PorcjujKurczaka(3)
					end			
				end
------------------------- Mycie
			if isInService and IsJobbutcher() and distM1 <= 2.5 and timermycie == false then
				DrawText3D(mycieX1, mycieY1, mycieZ1, "~g~[E]~w~ Aby umyć kurczaka")
				end
				
				if isInService and IsJobbutcher() and distM1 <= 0.5 and timermycie == false then
					if IsControlJustPressed(0, Keys['E']) then -- "E"
						timermycie = true
						MyjKurczaka(1)
					end			
				end
------------------------- Pakowanie
			if isInService and IsJobbutcher() and distP <= 2.5 and pakuje == 0 and timerpakowanie == false then
			DrawText3D(pakowanieX, pakowanieY, pakowanieZ, "~g~[E]~w~ Aby pakować kurczaka")
			elseif isInService and IsJobbutcher() and distP <= 2.5 and pakuje == 1 and timerpakowanie == false then
			DrawText3D(pakowanieX, pakowanieY, pakowanieZ, "~g~[G]~w~ Aby przerwać pakowanie")
			DrawText3D(pakowanieX, pakowanieY, pakowanieZ+0.1, "~g~[E]~w~ Aby pakować dalej")
			end

			if isInService and IsJobbutcher() and distP <= 0.5 and timerpakowanie == false then
				if IsControlJustPressed(0, Keys['E']) then 
					timerpakowanie = true
				PakujKurczaka(1)
				elseif IsControlJustPressed(0, Keys['G']) then
				PrzestanPakowac(1)
				end			
            end
			
			if isInService and IsJobbutcher() and distP2 <= 2.5 and pakuje == 0 and timerpakowanie == false then
			DrawText3D(pakowanieX2, pakowanieY2, pakowanieZ2, "~g~[E]~w~ Aby pakować kurczaka")
			elseif isInService and IsJobbutcher() and distP2 <= 2.5 and pakuje == 1 and timerpakowanie == false then
			DrawText3D(pakowanieX2, pakowanieY2, pakowanieZ2, "~g~[G]~w~ Aby przerwać pakowanie")
			DrawText3D(pakowanieX2, pakowanieY2, pakowanieZ2+0.1, "~g~~h~[E]~h~~w~ Aby pakować dalej")
			end

			if isInService and IsJobbutcher() and distP2 <= 0.5 and timerpakowanie == false then
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					timerpakowanie = true
				PakujKurczaka(2)
				elseif IsControlJustPressed(0, Keys['G']) then
				PrzestanPakowac(2)
				end		
			end
			
			if isInService and IsJobbutcher() and distP3 <= 2.5 and pakuje == 0 and timerpakowanie == false then
				DrawText3D(pakowanieX3, pakowanieY3, pakowanieZ3, "~g~[E]~w~ Aby pakować kurczaka")
				elseif isInService and IsJobbutcher() and distP3 <= 2.5 and pakuje == 1 and timerpakowanie == false then
				DrawText3D(pakowanieX3, pakowanieY3, pakowanieZ3, "~g~[G]~w~ Aby przerwać pakowanie")
				DrawText3D(pakowanieX3, pakowanieY3, pakowanieZ3+0.1, "~g~[E]~w~ Aby pakować dalej")
				end
	
			if isInService and IsJobbutcher() and distP3 <= 0.5 and timerpakowanie == false then
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					timerpakowanie = true
				PakujKurczaka(3)
				elseif IsControlJustPressed(0, Keys['G']) then
				PrzestanPakowac(3)
				end		
			end
			
			if isInService and IsJobbutcher() and distP4 <= 2.5 and pakuje == 0 and timerpakowanie == false then
				DrawText3D(pakowanieX4, pakowanieY4, pakowanieZ4, "~g~[E]~w~ Aby pakować kurczaka")
				elseif isInService and IsJobbutcher() and distP4 <= 2.5 and pakuje == 1 and timerpakowanie == false then
				DrawText3D(pakowanieX4, pakowanieY4, pakowanieZ4, "~g~[G]~w~ Aby przerwać pakowanie")
				DrawText3D(pakowanieX4, pakowanieY4, pakowanieZ4+0.1, "~g~[E]~w~ Aby pakować dalej")
				end

			if isInService and IsJobbutcher() and distP4 <= 0.5 and timerpakowanie == false then
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					timerpakowanie = true
				PakujKurczaka(4)
				elseif IsControlJustPressed(0, Keys['G']) then
				PrzestanPakowac(4)
				end		
			end

			if isInService and IsJobbutcher() and distP5 <= 2.5 and pakuje == 0 and timerpakowanie == false then
				DrawText3D(pakowanieX5, pakowanieY5, pakowanieZ5, "~g~[E]~w~ Aby pakować kurczaka")
				elseif isInService and IsJobbutcher() and distP5 <= 2.5 and pakuje == 1 and timerpakowanie == false then
				DrawText3D(pakowanieX5, pakowanieY5, pakowanieZ5, "~g~[G]~w~ Aby przerwać pakowanie")
				DrawText3D(pakowanieX5, pakowanieY5, pakowanieZ5+0.1, "~g~[E]~w~ Aby pakować dalej")
				end

			if isInService and IsJobbutcher() and distP5 <= 0.5 and timerpakowanie == false then
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					timerpakowanie = true
				PakujKurczaka(5)
				elseif IsControlJustPressed(0, Keys['G']) then
				PrzestanPakowac(5)
				end		
			end
				
end
end)

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

----------------Pakowanie
function PrzestanPakowac(stanowisko)
	FreezeEntityPosition(GetPlayerPed(-1), false)
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	prop = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z+0.2,  true,  true, true)
	AttachEntityToEntity(prop, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
	pakuje = 0
	--ESX.ShowNotification("~y~Zanieś karton do pojazdu.")
	exports['mythic_notify']:DoCustomHudText('inform', 'Zanieś karton do pojazdu', 3500)
	zapakowaneDoauta = true
	while zapakowaneDoauta do
	Citizen.Wait(500)
	local vehicle   = ESX.Game.GetVehicleInDirection()
	local coords    = GetEntityCoords(GetPlayerPed(-1))
	LoadDict('anim@heists@box_carry@')

	if not IsEntityPlayingAnim(GetPlayerPed(-1), "anim@heists@box_carry@", "idle", 3 ) and zapakowaneDoauta == true then
		TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@box_carry@', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
	end
	if DoesEntityExist(vehicle) then
		zapakowaneDoauta = false
		--ESX.ShowNotification("Jesteś przy pojeździe. Teraz możesz włożyć kurczaki do auta.")
		exports['mythic_notify']:DoCustomHudText('inform', 'Jesteś przy pojeździe. Teraz możesz włożyć kurczaki do auta.', 3500)
		LoadDict('anim@heists@narcotics@trash')
		TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@narcotics@trash', "throw_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
		Citizen.Wait(900)
		ClearPedTasks(GetPlayerPed(-1))
		DeleteEntity(prop)
	end
end
end

RegisterNetEvent("srp_butcher:pakowanietimerstop")
AddEventHandler("srp_butcher:pakowanietimerstop", function(source)
	timerpakowanie = false
end)

function PakujKurczaka(stanowisko)
ESX.TriggerServerCallback('zrider:butcherPass', function(pass_bool)
	if pass_bool then
	local source = GetPlayerServerId(PlayerId())
	--local inventory = ESX.GetPlayerData().inventory
	--local count = 0
	--for i=1, #inventory, 1 do
	--	if inventory[i].name == 'clean_chicken' then
	--	count = inventory[i].count
	--	end
	--end
	--if (count >= 1 and count <= 6) then
		--disablecontrols = true
		FreezeEntityPosition(GetPlayerPed(-1), true)
		SetEntityHeading(GetPlayerPed(-1), 40.0)
		local PedCoords = GetEntityCoords(GetPlayerPed(-1))
		mieso = CreateObject(GetHashKey('prop_cs_steak'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
		AttachEntityToEntity(mieso, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0x49D9), 0.15, 0.0, 0.01, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
		karton = CreateObject(GetHashKey('prop_cs_clothes_box'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
		AttachEntityToEntity(karton, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.13, 0.0, -0.16, 250.0, -30.0, 0.0, false, false, false, false, 2, true)
		pakuje = 0
		LoadDict("anim@heists@ornate_bank@grab_cash_heels")
		TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 8.0, -8.0, -1, 1, 0, false, false, false)
		--exports['progressBars']:startUI(5000, "Pakowanie Drobiu...")
		exports['mythic_progbar']:Progress({
			name = "butcher_action",
			duration = 5000,
			label = "Pakowanie Drobiu...",
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
		TriggerServerEvent("srp_butcher:butcher", source, 3)
		--ESX.ShowNotification("~y~Pakowanie zakończone.")
		--exports['mythic_notify']:DoCustomHudText('inform', 'Pakowanie zakończone', 3500)
		ClearPedTasks(GetPlayerPed(-1))
		DeleteEntity(karton)
		DeleteEntity(mieso)
		zapakowaneDoauta = false
		FreezeEntityPosition(GetPlayerPed(-1), false)
		Citizen.Wait(50)
		timerpakowanie = false
		--disablecontrols = false
	--elseif (count < 1) then
		--ESX.ShowNotification("~y~Nie masz nic do zapakowania.")
	--	exports['mythic_notify']:DoCustomHudText('error', 'Nie masz nic do zapakowania', 3500)
	--end
	else
		exports['mythic_notify']:DoCustomHudText('error', 'Nie masz umytych kurczaków', 3500)
		timerpakowanie = false
	end
end,'clean_chicken')
	
end


-------------Mycie
RegisterNetEvent("srp_butcher:mycietimerstop")
AddEventHandler("srp_butcher:mycietimerstop", function(source)
	timermycie = false
end)


function MyjKurczaka(stanowisko)
	ESX.TriggerServerCallback('zrider:butcherPass', function(pass_bool)
	if pass_bool then
	local source = GetPlayerServerId(PlayerId())
	--local inventory = ESX.GetPlayerData().inventory
	--local count = 0
	--for i=1, #inventory, 1 do
	--	if inventory[i].name == 'slaughtered_chicken' then
	--	count = inventory[i].count
	--	end
	--end
	--if (count >= 1 and count <= 6) then	
		--disablecontrols = true
		FreezeEntityPosition(GetPlayerPed(-1),true)
		local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
		LoadDict(dict)
		TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
		if stanowisko == 1 then
			SetEntityHeading(GetPlayerPed(-1), 225.0)
			kurczak = CreateObject(GetHashKey('prop_int_cf_chick_01'),-100.5, 6201.8, 29.99, true, true, true)
			SetEntityRotation(kurczak,90.0, 0.0, -45.0, 1,true)
		end
	--exports['progressBars']:startUI(5000, "Mycie Drobiu...")
	exports['mythic_progbar']:Progress({
		name = "butcher_action",
		duration = 5000,
		label = "Mycie Drobiu...",
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
	--ESX.ShowNotification("~g~Umyłeś kurczaka.")
	--exports['mythic_notify']:DoCustomHudText('inform', 'Umyłeś kurczaka', 3500)
	FreezeEntityPosition(GetPlayerPed(-1),false)
	DeleteEntity(kurczak)
	ClearPedTasks(GetPlayerPed(-1))
	TriggerServerEvent("srp_butcher:butcher", source, 2)
	Citizen.Wait(50)
	timermycie = false
	--disablecontrols = false
	--elseif (count < 1) then
		--ESX.ShowNotification("~y~Nie masz kurczaków do umycia.")
		--exports['mythic_notify']:DoCustomHudText('error', 'Nie masz kurczaków do umycia', 3500)
	--end
	
			
else
	exports['mythic_notify']:DoCustomHudText('error', 'Nie masz poćwiartowanych kurczaków', 3500)
	timermycie = false
end
end,'slaughtered_chicken')
end
---------Porcjowanie
RegisterNetEvent("srp_butcher:krojenietimerstop")
AddEventHandler("srp_butcher:krojenietimerstop", function(source)
	timerporcja = false
end)

function PorcjujKurczaka(stanowisko)
	--TriggerServerEvent("srp:butcher:dismemberCheck", source)
ESX.TriggerServerCallback('zrider:butcherPass', function(dismember)
	local source = GetPlayerServerId(PlayerId())
	Citizen.Wait(250)
	if dismember then
		FreezeEntityPosition(GetPlayerPed(-1),true)
		local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
		LoadDict(dict)
		TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
		local PedCoords = GetEntityCoords(GetPlayerPed(-1))
		nozyk = CreateObject(GetHashKey('prop_knife'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
		AttachEntityToEntity(nozyk, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0xDEAD), 0.13, 0.14, 0.09, 40.0, 0.0, 0.0, false, false, false, false, 2, true)
		if stanowisko == 1 then
			SetEntityHeading(GetPlayerPed(-1), 311.0)
			kurczak = CreateObject(GetHashKey('prop_int_cf_chick_01'),-95.15, 6207.15, 30.08, true, true, true)
			SetEntityRotation(kurczak,90.0, 0.0, 45.0, 1,true)
		elseif stanowisko == 2 then
			SetEntityHeading(GetPlayerPed(-1), 45.0)
			kurczak = CreateObject(GetHashKey('prop_int_cf_chick_01'),-99.3, 6205.15, 30.04, true, true, true)
			SetEntityRotation(kurczak,90.0, 0.0, -45.0, 1,true)
		elseif stanowisko == 3 then
			SetEntityHeading(GetPlayerPed(-1), 222.0)
			kurczak = CreateObject(GetHashKey('prop_int_cf_chick_01'),-99.6, 6205.6, 30.04, true, true, true)
			SetEntityRotation(kurczak,90.0, 0.0, -45.0, 1,true)
		end
	--exports['progressBars']:startUI(5000, "Krojenie Drobiu...")
	exports['mythic_progbar']:Progress({
		name = "butcher_action",
		duration = 5000,
		label = "Krojenie Drobiu...",
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
	--ESX.ShowNotification("~g~Poćwiartowałeś kurczaka.")
	--exports['mythic_notify']:DoCustomHudText('inform', 'Poćwiartowałeś kurczaka', 3500)
	FreezeEntityPosition(GetPlayerPed(-1),false)
	DeleteEntity(kurczak)
	DeleteEntity(nozyk)
	ClearPedTasks(GetPlayerPed(-1))
	--disablecontrols = false
	TriggerServerEvent("srp_butcher:butcher", source, 1)
	--elseif (count < 1) then
	--ESX.ShowNotification("~y~Nie masz kurczaków.")
	--exports['mythic_notify']:DoCustomHudText('error', 'Nie masz kurczaków', 3500)
	--end
	timerporcja = false
	elseif not dismember then
	exports['mythic_notify']:DoCustomHudText('error', 'Nie masz kurczaków', 3500)
	timerporcja = false
	end
end,'alive_chicken')
end
----------TP z zagrody
function TepnijWyjscie()
	local maxHealth = GetEntityMaxHealth(GetPlayerPed(-1))
	DoScreenFadeOut(500)
	Citizen.Wait(500)
	SetEntityCoordsNoOffset(GetPlayerPed(-1), startX+2, startY+2, startZ, 0, 0, 1)
	if DoesEntityExist(kurczak1) or DoesEntityExist(kurczak2) or DoesEntityExist(kurczak3) then
		DeleteEntity(kurczak1)
		DeleteEntity(kurczak2)
		DeleteEntity(kurczak3)
	end
	SetEntityHealth(GetPlayerPed(-1), maxHealth)
	Citizen.Wait(500)
	DoScreenFadeIn(500)
	TriggerServerEvent("srp_butcher:catching")

	--[[local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	prop = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z+0.2,  true,  true, true)
	AttachEntityToEntity(prop, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
						
	local dajdoAuta = true

	while dajdoAuta do
	Citizen.Wait(250)
	local vehicle   = ESX.Game.GetVehicleInDirection()
	local coords    = GetEntityCoords(GetPlayerPed(-1))
	LoadDict('anim@heists@box_carry@')

	if not IsEntityPlayingAnim(GetPlayerPed(-1), "anim@heists@box_carry@", "idle", 3 ) and dajdoAuta == true then
		TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@box_carry@', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
	end
	
	if DoesEntityExist(vehicle) then
		dajdoAuta = false
		ESX.ShowNotification("~y~Wkładasz kurczaki do samochodu.")
		LoadDict('anim@heists@narcotics@trash')
		TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@narcotics@trash', "throw_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
		Citizen.Wait(900)
		ClearPedTasks(GetPlayerPed(-1))
		DeleteEntity(prop)
		TriggerServerEvent("srp_butcher:catching")
	end
end]]
end
--------Tp do zagrody
function LapKurczaka()
	local source = GetPlayerServerId(PlayerId())
	local inventory = ESX.GetPlayerData().inventory
	local count = 0
	for i=1, #inventory, 1 do
		if inventory[i].name == 'alive_chicken' then
		count = inventory[i].count
		end
	end
	if (count < 4) then
		DoScreenFadeOut(500)
		Citizen.Wait(500)
		SetEntityCoordsNoOffset(GetPlayerPed(-1), 1445.74, 1076.05, 114.33, 0, 0, 1)
		RequestModel(GetHashKey('a_c_hen'))
		while not HasModelLoaded(GetHashKey('a_c_hen')) do
			Wait(1)
		end
		kurczak1 = CreatePed(26, "a_c_hen", 1457.42, 1070.60, 114.33, 268.9422, true, false)
		kurczak2 = CreatePed(26, "a_c_hen", 1453.88, 1062.06, 114.33, 122.9422, true, false)
		kurczak3 = CreatePed(26, "a_c_hen", 1447.24, 1060.12, 114.33, 6.211257, true, false)
		TaskReactAndFleePed(kurczak1, GetPlayerPed(-1))
		TaskReactAndFleePed(kurczak2, GetPlayerPed(-1))
		TaskReactAndFleePed(kurczak3, GetPlayerPed(-1))
		Citizen.Wait(500)
		DoScreenFadeIn(500)
		akcja = true
	elseif (count >= 4) then
			--ESX.ShowNotification("Masz za dużo kurczaków przy sobie by zacząć pracę!")
			exports['mythic_notify']:DoCustomHudText('error', 'Masz za dużo kurczaków przy sobie by zacząć pracę!', 3500)
	end
end
-----
function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end
---------Łapanie Kurczaków
Citizen.CreateThread(function()
    while true do
    Citizen.Wait(5)
	
if akcja == true then
	local kurczak1Coords = GetEntityCoords(kurczak1)
	local kurczak2Coords = GetEntityCoords(kurczak2)
	local kurczak3Coords = GetEntityCoords(kurczak3)
	local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
    local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, kurczak1Coords.x, kurczak1Coords.y, kurczak1Coords.z)
	local dist2 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, kurczak2Coords.x, kurczak2Coords.y, kurczak2Coords.z)
	local dist3 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, kurczak3Coords.x, kurczak3Coords.y, kurczak3Coords.z)
	
	if Ilosczlapanych == 3 then
	Zlapany1 = 0
	Zlapany2 = 0
	Zlapany3 = 0
	Ilosczlapanych = 0
	akcja = false
	--ESX.ShowNotification("~g~Udaj się z kurczakami do pojazdu.")
	exports['mythic_notify']:DoCustomHudText('inform', 'Udaj się z kurczakami do pojazdu!', 3500)
	TepnijWyjscie()
	end
	
	if dist <= 1.0 then
	DrawText3D(kurczak1Coords.x, kurczak1Coords.y, kurczak1Coords.z+0.5, "~o~[E]~b~ Złap kurczaka")
		if IsControlJustPressed(0, Keys['E']) then 
		Zlapany1 = 1
		ZostalZlapany()
		end	
	elseif dist2 <= 1.0 then
		DrawText3D(kurczak2Coords.x, kurczak2Coords.y, kurczak2Coords.z+0.5, "~o~[E]~b~ Złap kurczaka")
		if IsControlJustPressed(0, Keys['E']) then 
		Zlapany2 = 1
		ZostalZlapany()
		end	
	elseif dist3 <= 1.0 then
		DrawText3D(kurczak3Coords.x, kurczak3Coords.y, kurczak3Coords.z+0.5, "~o~[E]~b~ Złap kurczaka")
		if IsControlJustPressed(0, Keys['E']) then 
		Zlapany3 = 1
		ZostalZlapany()
		end	
	end
else
Citizen.Wait(500)
end	
end
end)

function ZostalZlapany()
	LoadDict('move_jump')
	TaskPlayAnim(GetPlayerPed(-1), 'move_jump', 'dive_start_run', 8.0, -8.0, -1, 0, 0.0, 0, 0, 0)
	Citizen.Wait(600)
	SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
	local szansaZlapania = math.random(1,100)
	if szansaZlapania <= 60 then
		--ESX.ShowNotification("~g~Udało się złapać kurczaka!")
		exports['mythic_notify']:DoCustomHudText('inform', 'Udało się złapać kurczaka!', 3500)
	if Zlapany1 == 1 then
		DeleteEntity(kurczak1)
		Zlapany1 = 0
		Ilosczlapanych = Ilosczlapanych +1
	elseif Zlapany2 == 1 then
		DeleteEntity(kurczak2)
		Zlapany2 = 0
		Ilosczlapanych = Ilosczlapanych +1
	elseif Zlapany3 == 1 then
		DeleteEntity(kurczak3)
		Zlapany3 = 0
		Ilosczlapanych = Ilosczlapanych +1
	end
else
--ESX.ShowNotification("~r~Kurczak ci uciekł")
exports['mythic_notify']:DoCustomHudText('inform', 'Kurczak ci uciekł!', 3500)
end
end



Citizen.CreateThread(function()
	
    while true do
    Citizen.Wait(5)
	local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
    local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, startX+2, startY+2, startZ)
	
	if isInService and IsJobbutcher() and dist <= 20.0 and akcja == true then
		DrawMarker(27, startX+2, startY+2, startZ-0.96, 0, 0, 0, 0, 0, 0, 1.50, 1.50, 3.00, 0, 205, 50, 200, 0, 0, 0, 0)
	else
		Citizen.Wait(1000)
	end
	
	if isInService and IsJobbutcher() and dist <= 2.0 and akcja == true then
	DrawText3D(startX+2, startY+2, startZ+0.1, "~g~[X]~w~ Aby anulować łapanie kurczaków")
		if IsControlJustPressed(0, Keys['X']) then 
			konieclapania()
		end
	end
end
end)

function konieclapania()
	DeleteEntity(kurczak1)
	Zlapany1 = 0
	DeleteEntity(kurczak2)
	Zlapany2 = 0
	DeleteEntity(kurczak3)
	Zlapany3 = 0
	Ilosczlapanych = 0
	akcja = false
	exports['mythic_notify']:DoCustomHudText('inform', 'Łapanie anulowane, wszystkie kurczaki zostały wypuszczone', 3500)
end


----------Sprzedaż Kurczaków
Citizen.CreateThread(function()
	
    while true do
    Citizen.Wait(5)
	local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
    local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, sellX, sellY, sellZ)
	
	if isInService and IsJobbutcher() and dist <= 20.0 and timersell == false then
		DrawMarker(27, sellX, sellY, sellZ-0.96, 0, 0, 0, 0, 0, 0, 2.00, 2.00, 2.00, 0, 205, 50, 200, 0, 0, 0, 0)
	else
		Citizen.Wait(1000)
	end
	
	if isInService and IsJobbutcher() and dist <= 2.0 and timersell == false then
	DrawText3D(sellX, sellY, sellZ+0.1, "~o~[E]~b~ Sprzedaj zapakowane kurczaki")
		if IsControlJustPressed(0, Keys['E']) then 
			timersell = true
			SellKurczaki()
		end
	end
end
end)

RegisterNetEvent("srp_butcher:selltimerstop")
AddEventHandler("srp_butcher:selltimerstop", function(source)
	timersell = false
end)


function SellKurczaki()
	ESX.TriggerServerCallback('zrider:butcherPass', function(pass_bool)
		if pass_bool then
	local source = GetPlayerServerId(PlayerId())
	local postac = GetPlayerPed(-1)
	local waucie = IsPedInAnyVehicle(postac, false)
	--local inventory = ESX.GetPlayerData().inventory
	--local count = 0
	--for i=1, #inventory, 1 do
	--	if inventory[i].name == 'packaged_chicken' then
	--	count = inventory[i].count
	--	end
	--end
	if waucie then
		--ESX.ShowNotification("~r~Nie możesz sprzedawać kurczaków siedząc w pojeździe!")
		exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz sprzedawać kurczaków siedząc w pojeździe!', 3500)
	else
		--if (count >= 1) then
			--disablecontrols = true
			local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.9, -0.98))
			prop = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z,  true,  true, true)
			SetEntityHeading(prop, GetEntityHeading(GetPlayerPed(-1)))
			LoadDict('amb@medic@standing@tendtodead@idle_a')
			TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@idle_a', 'idle_a', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
			--exports['progressBars']:startUI(6500, "Sprzedaż Drobiu...")
			exports['mythic_progbar']:Progress({
				name = "butcher_action",
				duration = 6500,
				label = "Sprzedaż Drobiu...",
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				},
			})
			Citizen.Wait(6500)
			LoadDict('amb@medic@standing@tendtodead@exit')
			TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@exit', 'exit', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
			Citizen.Wait(2000)
			ClearPedTasks(GetPlayerPed(-1))
			DeleteEntity(prop)
			TriggerServerEvent("srp_butcher:butcher",source,4)
			Citizen.Wait(50)
			timersell = false
			--disablecontrols = false
		--elseif (count < 1) then
			--ESX.ShowNotification("~r~Nie masz nic na sprzedaż")
			--exports['mythic_notify']:DoCustomHudText('error', 'Nie masz nic na sprzedaż!', 3500)
		--end
	end
		
else
	exports['mythic_notify']:DoCustomHudText('error', 'Nie masz kurczaków', 3500)
	timersell = false
	Citizen.Wait(1000)
end
end,'packaged_chicken')
end
------------------Markery 
AddEventHandler('srp_butcher:hasEnteredMarker', function(zone)

	local playerPed = GetPlayerPed(-1)

	if zone == 'CloakRoom' then
		MenuCloakRoom()
	end

	if zone == 'VehicleSpawner' then
		if isInService and IsJobbutcher() then
			MenuVehicleSpawner()
		end
	end
end)

AddEventHandler('srp_butcher:hasExitedMarker', function(zone)
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

			if isInService and (IsJobbutcher() and v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end

		end

		for k,v in pairs(Config.Cloakroom) do

			if(IsJobbutcher() and v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end

		end
		
	end
end)

Citizen.CreateThread(function()
	while true do
		
		Wait(0)
		
		if IsJobbutcher() then

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
				TriggerEvent('srp_butcher:hasEnteredMarker', currentZone)
			end

			if not isInMarker and hasAlreadyEnteredMarker then
				hasAlreadyEnteredMarker = false
				TriggerEvent('srp_butcher:hasExitedMarker', lastZone)
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
    if PlayerData.job ~= nil and PlayerData.job.name == 'butcher' then
		local blip = AddBlipForCoord(Config.Cloakroom.CloakRoom.Pos.x, Config.Cloakroom.CloakRoom.Pos.y, Config.Cloakroom.CloakRoom.Pos.z)
  
		SetBlipSprite (blip, 479)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.7)
		SetBlipColour (blip, 5)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Ferma Drobiu')
		EndTextCommandSetBlipName(blip)
		table.insert(JobBlips, blip)
	end
	
    if PlayerData.job ~= nil and PlayerData.job.name == 'butcher' then
		local skupk = AddBlipForCoord(sellX, sellY, sellZ)

		SetBlipSprite (skupk, 478)
		SetBlipDisplay(skupk, 4)
		SetBlipScale  (skupk, 0.7)
		SetBlipColour (skupk, 46)

		SetBlipAsShortRange(skupk, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Skup Kurczaków')
		EndTextCommandSetBlipName(skupk)
		table.insert(JobBlips, skupk)
	end

    if PlayerData.job ~= nil and PlayerData.job.name == 'butcher' then
		local rzeznia = AddBlipForCoord(przetworniaX, przetworniaY, przetworniaZ)

		SetBlipSprite (rzeznia, 154)
		SetBlipDisplay(rzeznia, 4)
		SetBlipScale  (rzeznia, 0.7)
		SetBlipColour (rzeznia, 46)

		SetBlipAsShortRange(rzeznia, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Rzeźnia')
		EndTextCommandSetBlipName(rzeznia)
		table.insert(JobBlips, rzeznia)
	end

    if PlayerData.job ~= nil and PlayerData.job.name == 'butcher' then
		local lapanie = AddBlipForCoord(startX, startY, startZ)

		SetBlipSprite (lapanie, 365)
		SetBlipDisplay(lapanie, 4)
		SetBlipScale  (lapanie, 0.7)
		SetBlipColour (lapanie, 46)

		SetBlipAsShortRange(lapanie, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Łapanie Kurczaków')
		EndTextCommandSetBlipName(lapanie)
		table.insert(JobBlips, lapanie)
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
	-- W 0000 xxx 
	-- W - first letter of job name
	-- 0000 - player server ID 
	-- xxx - random plate end consisting of chars from PlatesChars
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

