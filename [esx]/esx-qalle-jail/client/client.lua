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

ESX = nil

PlayerData = {}

local jailTime = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData() == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()

	LoadTeleporters()
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(newData)
	PlayerData = newData

	Citizen.Wait(25000)

	ESX.TriggerServerCallback("esx-qalle-jail:retrieveJailTime", function(inJail, newJailTime)
		if inJail then

			jailTime = newJailTime

			JailLogin()
		end
	end)
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(response)
	PlayerData["job"] = response
end)

RegisterNetEvent("esx-qalle-jail:openJailMenu")
AddEventHandler("esx-qalle-jail:openJailMenu", function()
	OpenJailMenu()
end)

RegisterNetEvent("esx-qalle-jail:jailPlayer")
AddEventHandler("esx-qalle-jail:jailPlayer", function(newJailTime)
	jailTime = tonumber(newJailTime)
	if jailTime == 1 then
		jailTime = 2
	end
	
	Cutscene()

end)

RegisterNetEvent("esx-qalle-jail:unJailPlayer")
AddEventHandler("esx-qalle-jail:unJailPlayer", function()
	jailTime = 0

	UnJail()
end)

function JailLogin()
	local JailPosition = Config.JailPositions["Cell"]
	SetEntityCoords(PlayerPedId(), JailPosition["x"], JailPosition["y"], JailPosition["z"] - 1)

	exports['mythic_notify']:DoLongHudText('error', 'Ostatio kiedy poszedłeś spać byłeś w więzieniu, dlatego znowu tu jesteś!')
	InJail()
end

function UnJail()
	-- InJail()

	ESX.Game.Teleport(PlayerPedId(), Config.Teleports["Boiling Broke"])

	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)

	exports['mythic_notify']:DoHudText('success', 'Zostałeś wypuszczony z więzienia!')
end

function InJail()

	Citizen.CreateThread(function()

		while jailTime > 0 do
			jailTime = jailTime - 1

			--ESX.ShowNotification("Pozostało ~b~" .. jailTime .. "~w~ miesięcy ~r~w więzieniu!")
			exports['mythic_notify']:DoLongHudText('inform', 'Pozostało ' ..jailTime .. ' miesiecy w więzieniu!')
			TriggerServerEvent("esx-qalle-jail:updateJailTime", jailTime)

			if jailTime == 0 then
				UnJail()

				TriggerServerEvent("esx-qalle-jail:updateJailTime", 0)
			end

			Citizen.Wait(60000)
		end

	end)

	--Jail Timer--

	--Prison Work--

	Citizen.CreateThread(function()
		while jailTime > 0 do
			
			local sleepThread = 500

			local Packages = Config.PrisonWork["Packages"]

			local Ped = PlayerPedId()
			local PedCoords = GetEntityCoords(Ped)

			for posId, v in pairs(Packages) do

				local DistanceCheck = GetDistanceBetweenCoords(PedCoords, v["x"], v["y"], v["z"], true)

				if DistanceCheck <= 10.0 then

					sleepThread = 5

					local PackageText = "Paczka"

					if not v["state"] then
						PackageText = "Wzięta"
					end

					--ESX.Game.Utils.DrawText3D(v, "[E] " .. PackageText, 0.4)
					DrawMarker(27, v["x"], v["y"], v["z"]-0.97, 0, 0, 0, 0, 0, 0, 0.70, 0.70, 1.00, 41, 11, 41, 150, 0, 0, 0, 0)
					
					if DistanceCheck <= 0.5 then
						ESX.ShowHelpNotification('Naciśnij ~INPUT_CONTEXT~ aby spakować paczke')
						if IsControlJustPressed(0, 38) then

							if v["state"] then
								PackPackage(posId)
							else
								exports['mythic_notify']:DoHudText('error', 'Już wziąłeś tę paczke')
							end

						end

					end

				end

			end

			Citizen.Wait(sleepThread)

		end
	end)

	--Prison Work--

end

function LoadTeleporters()
	Citizen.CreateThread(function()
		while true do
			
			local sleepThread = 500

			local Ped = PlayerPedId()
			local PedCoords = GetEntityCoords(Ped)

			for p, v in pairs(Config.Teleports) do

				local DistanceCheck = GetDistanceBetweenCoords(PedCoords, v["x"], v["y"], v["z"], true)

				if DistanceCheck <= 7.5 then

					sleepThread = 5

					ESX.Game.Utils.DrawText3D(v, "[E] Otwórz drzwi", 0.4)

					if DistanceCheck <= 1.5 then
						if IsControlJustPressed(0, 38) then
							TeleportPlayer(v)
						end
					end
				end
			end

			Citizen.Wait(sleepThread)

		end
	end)
end

function PackPackage(packageId)
	local Package = Config.PrisonWork["Packages"][packageId]

	LoadModel("prop_cs_cardbox_01")

	local PackageObject = CreateObject(GetHashKey("prop_cs_cardbox_01"), Package["x"], Package["y"], Package["z"], true)

	PlaceObjectOnGroundProperly(PackageObject)

	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, false)

	local Packaging = true
	local StartTime = GetGameTimer()

	while Packaging do
		
		Citizen.Wait(1)

		local TimeToTake = 60000 * 1.20 -- Minutes
		local PackPercent = (GetGameTimer() - StartTime) / TimeToTake * 5000

		if not IsPedUsingScenario(PlayerPedId(), "PROP_HUMAN_BUM_BIN") then
			DeleteEntity(PackageObject)

			ESX.ShowNotification("Anulowano!")

			Packaging = false
		end

		if PackPercent >= 100 then

			Packaging = false

			DeliverPackage(PackageObject)

			Package["state"] = false
		else
			ESX.Game.Utils.DrawText3D(Package, "Pakowanie... " .. math.ceil(tonumber(PackPercent)) .. "%", 0.4)
		end
		
	end
end

function DeliverPackage(packageId)
	if DoesEntityExist(packageId) then
		AttachEntityToEntity(packageId, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0.0, -0.03, 0.0, 5.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)

		ClearPedTasks(PlayerPedId())
	else
		return
	end

	local Packaging = true

	LoadAnim("anim@heists@box_carry@")

	while Packaging do

		Citizen.Wait(5)

		if not IsEntityPlayingAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 3) then
			TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
		end

		if not IsEntityAttachedToEntity(packageId, PlayerPedId()) then
			Packaging = false
			DeleteEntity(packageId)
		else
			local DeliverPosition = Config.PrisonWork["DeliverPackage"]
			local PedPosition = GetEntityCoords(PlayerPedId())
			local DistanceCheck = GetDistanceBetweenCoords(PedPosition, DeliverPosition["x"], DeliverPosition["y"], DeliverPosition["z"], true)
			DrawMarker(2, DeliverPosition["x"], DeliverPosition["y"], DeliverPosition["z"], 0, 0, 0, 0, 0, 0, 0.6001, 1.0001, 0.6, 41, 11, 41, 90, 1,0, 0,1)
			
			
			if DistanceCheck <= 0.5 then
				ESX.ShowHelpNotification('Naciśnij ~INPUT_CONTEXT~ aby oddac paczkę.!')

				if IsControlJustPressed(0, 38) then
					DeleteEntity(packageId)
					ClearPedTasksImmediately(PlayerPedId())
					Packaging = false
					local miesiacMinus = math.random(1,2)
					TriggerServerEvent("esx-qalle-jail:prisonWorkReward")
					jailTime = jailTime - miesiacMinus
					--ESX.ShowNotification("Za ~g~uczynność i pracę~w~ zmniejszamy ci wyrok o ~b~" .. miesiacMinus .. " miesiąc/ce!")
					exports['mythic_notify']:DoLongHudText('success', 'Za uczynność i pracę zmiejszamy ci wyrok o ' .. miesiacMinus .. ' miesiąc/ce')
				end
			end
		end

	end

end

function OpenJailMenu()
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'jail_prison_menu',
		{
			title    = "Prison Menu",
			align    = 'center',
			elements = {
				{ label = "Wyślij do więzienia", value = "jail_closest_player" },
				{ label = "Zwolnij z więzienia", value = "unjail_player" }
			}
		}, 
	function(data, menu)
		local action = data.current.value
		if action == "jail_closest_player" then
			menu.close()
			ESX.UI.Menu.Open(
          		'dialog', GetCurrentResourceName(), 'jail_choose_time_menu',
          		{
            		title = "Czas odsiatki (minutes)"
          		},
          	function(data2, menu2)
            	local jailTime = tonumber(data2.value)
            	if jailTime == nil then
              		ESX.ShowNotification("Czas musi być w minutach!")
            	else
              		menu2.close()
              		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
              		if closestPlayer == -1 or closestDistance > 3.0 then
                		ESX.ShowNotification("Brak ~r~osób w pobliżu!")
					else
						ESX.UI.Menu.Open(
							'dialog', GetCurrentResourceName(), 'jail_choose_reason_menu',
							{
							  title = "Powód"
							},
						function(data3, menu3)
						  	local reason = data3.value
						  	if reason == nil then
								ESX.ShowNotification("Musisz wpisać powód!")
						  	else
								menu3.close()
								local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
								if closestPlayer == -1 or closestDistance > 3.0 then
								  	ESX.ShowNotification("Brak ~r~osób w pobliżu!")
								else
								  	TriggerServerEvent("esx-qalle-jail:jailPlayer", GetPlayerServerId(closestPlayer), jailTime, reason)
								end
						  	end
						end, function(data3, menu3)
							menu3.close()
						end)
              		end
				end
          	end, function(data2, menu2)
				menu2.close()
			end)
		elseif action == "unjail_player" then
			local elements = {}
			ESX.TriggerServerCallback("esx-qalle-jail:retrieveJailedPlayers", function(playerArray)
				if #playerArray == 0 then
					ESX.ShowNotification("Nikogo nie ma w więzieniu!")
					return
				end
				for i = 1, #playerArray, 1 do
					table.insert(elements, {label = "Więzień: " .. playerArray[i].name .. " | Czas odsiatki: " .. playerArray[i].jailTime .. " miesięcy", value = playerArray[i].identifier })
				end
				ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'jail_unjail_menu',
					{
						title = "Zakończ wyrok",
						align = "center",
						elements = elements
					},
				function(data2, menu2)
					local action = data2.current.value
					TriggerServerEvent("esx-qalle-jail:unJailPlayer", action)
					menu2.close()
				end, function(data2, menu2)
					menu2.close()
				end)
			end)
		end
	end, function(data, menu)
		menu.close()
	end)	
end

