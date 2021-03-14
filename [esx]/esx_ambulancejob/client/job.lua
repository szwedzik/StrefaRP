local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum
local IsBusy = false
local spawnedVehicles, isInShopMenu = {}, false

function OpenAmbulanceActionsMenu()
	local elements = {
		{label = _U('cloakroom'), value = 'cloakroom'}
	}

	if Config.EnablePlayerManagement and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ambulance_actions', {
		title    = _U('ambulance'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'cloakroom' then
			OpenCloakroomMenu()
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'ambulance', function(data, menu)
				menu.close()
			end, {wash = false})
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenAmbulanceActionsMenuDown()
	local elements = {
		{label = _U('cloakroom'), value = 'cloakroom'}
	}

	if Config.EnablePlayerManagement and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ambulance_actions', {
		title    = _U('ambulance'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'cloakroom' then
			OpenCloakroomMenu()
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'ambulance', function(data, menu)
				menu.close()
			end, {wash = false})
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenAmbulanceActionsMenuS7()
	local elements = {
		{label = _U('cloakroom'), value = 'cloakroom'}
	}

	if Config.EnablePlayerManagement and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ambulance_actions', {
		title    = _U('ambulance'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'cloakroom' then
			OpenCloakroomMenuS7()
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'ambulance', function(data, menu)
				menu.close()
			end, {wash = false})
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenBoatsActionsMenu()
	local elements = {
		{label = _U('cloakroom'), value = 'cloakroom'}
	}

	if Config.EnablePlayerManagement and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ambulance_actions', {
		title    = _U('ambulance'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'cloakroom' then
			OpenBoatsActions()
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'ambulance', function(data, menu)
				menu.close()
			end, {wash = false})
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenMobileAmbulanceActionsMenu()

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_ambulance_actions', {
		title    = _U('ambulance'),
		align    = 'top-left',
		elements = {
			{label = _U('ems_menu'), value = 'citizen_interaction'},
			{label = _U('object_spawner'),		value = 'object_spawner'}
		}
	}, function(data, menu)
		if data.current.value == 'citizen_interaction' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				title    = _U('ems_menu_title'),
				align    = 'top-left',
				elements = {
					{label = _U('ems_menu_revive'), value = 'revive'},
					{label = _U('ems_menu_small'), value = 'small'},
					{label = _U('ems_menu_big'), value = 'big'},
					{label = _U('ems_menu_putincar'), value = 'put_in_vehicle'}
				}
			}, function(data, menu)
				if IsBusy then return end

				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

				if closestPlayer == -1 or closestDistance > 1.0 then
					--ESX.ShowNotification(_U('no_players'))
					exports['mythic_notify']:DoCustomHudText('error', 'Brak graczy w pobliżu!', 4000)
				else

					if data.current.value == 'revive' then

						IsBusy = true

						ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
							if quantity > 0 then
								local closestPlayerPed = GetPlayerPed(closestPlayer)

								if IsPedDeadOrDying(closestPlayerPed, 1) then
									local playerPed = PlayerPedId()

									--ESX.ShowNotification(_U('revive_inprogress'))
									exports['mythic_notify']:DoCustomHudText('inform', 'Trwa udzielanie pomocy', 2000)

									local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'

									for i=1, 15, 1 do
										Citizen.Wait(900)
								
										ESX.Streaming.RequestAnimDict(lib, function()
											TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
										end)
									end

									TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
									TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(closestPlayer))

									-- Show revive award?
									if Config.ReviveReward > 0 then
										--ESX.ShowNotification(_U('revive_complete_award', GetPlayerName(closestPlayer), Config.ReviveReward))
										exports['mythic_notify']:DoCustomHudText('success', 'Pierwsza pomoc została udzielona', 3500)
									else
										--ESX.ShowNotification(_U('revive_complete', GetPlayerName(closestPlayer)))
										exports['mythic_notify']:DoCustomHudText('success', 'Pierwsza pomoc została udzielona', 3500)
									end
								else
									--ESX.ShowNotification(_U('player_not_unconscious'))
									exports['mythic_notify']:DoCustomHudText('error', 'Ten gracz nie jest nieprzytomny!', 3500)
								end
							else
								--ESX.ShowNotification(_U('not_enough_medikit'))
								exports['mythic_notify']:DoCustomHudText('error', 'Nie masz przy sobie Defibrylatora!', 3500)
							end

							IsBusy = false

						end, 'medikit')

					elseif data.current.value == 'small' then

						ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
							if quantity > 0 then
								local closestPlayerPed = GetPlayerPed(closestPlayer)
								local health = GetEntityHealth(closestPlayerPed)

								if health > 0 then
									local playerPed = PlayerPedId()

									IsBusy = true
									--ESX.ShowNotification(_U('heal_inprogress'))
									exports['mythic_notify']:DoCustomHudText('inform', 'Sprawdzasz stan pacjenta', 3500)

									TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
									exports['mythic_progbar']:Progress({
										name = "firstaid_action",
										duration = 10000,
										label = "Sprawdzanie stanu pacjenta...",
										useWhileDead = false,
										canCancel = true,
										controlDisables = {
											disableMovement = false,
											disableCarMovement = false,
											disableMouse = false,
											disableCombat = true,
										}
										})
									Citizen.Wait(10000)
									ClearPedTasks(playerPed)

									TriggerServerEvent('esx_ambulancejob:removeItem', 'bandage')
									TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'small')
									--ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
									--exports['mythic_notify']:DoCustomHudText('success', 'xxx', 3500)
									IsBusy = false
								else
									--ESX.ShowNotification(_U('player_not_conscious'))
									exports['mythic_notify']:DoCustomHudText('error', 'Ten gracz nie jest świadomy!', 3500)
								end
							else
								--ESX.ShowNotification(_U('not_enough_bandage'))
								exports['mythic_notify']:DoCustomHudText('error', 'Nie masz przy sobie Bandaży!', 3500)
							end
						end, 'bandage')

					elseif data.current.value == 'big' then

						ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
							if quantity > 0 then
								local closestPlayerPed = GetPlayerPed(closestPlayer)
								local health = GetEntityHealth(closestPlayerPed)

								if health > 0 then
									local playerPed = PlayerPedId()

									IsBusy = true
									--ESX.ShowNotification(_U('heal_inprogress'))
									exports['mythic_notify']:DoCustomHudText('inform', 'Sprawdzasz stan pacjenta', 3500)
									exports['mythic_progbar']:Progress({
										name = "firstaid_action",
										duration = 10000,
										label = "Sprawdzanie stanu pacjenta...",
										useWhileDead = false,
										canCancel = true,
										controlDisables = {
											disableMovement = false,
											disableCarMovement = false,
											disableMouse = false,
											disableCombat = true,
										}
										})
									TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
									Citizen.Wait(10000)
									ClearPedTasks(playerPed)

									TriggerServerEvent('esx_ambulancejob:removeItem', 'medkit')
									TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'big')
									--ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
									--exports['mythic_notify']:DoCustomHudText('error', 'xxx', 3500)
									IsBusy = false
								else
									--ESX.ShowNotification(_U('player_not_conscious'))
									exports['mythic_notify']:DoCustomHudText('error', 'Ten gracz nie jest świadomy!', 3500)
								end
							else
								--ESX.ShowNotification(_U('not_enough_medikit'))
								exports['mythic_notify']:DoCustomHudText('error', 'Nie masz przy sobie Apteczki!', 3500)
							end
						end, 'medkit')

					elseif data.current.value == 'put_in_vehicle' then
						TriggerServerEvent('esx_ambulancejob:putInVehicle', GetPlayerServerId(closestPlayer))
					end
				end
			end, function(data, menu)
				menu.close()
			end)
		elseif data.current.value == 'object_spawner' then
			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'citizen_interaction',
			{
				title    = _U('traffic_interaction'),
				align    = 'top-left',
				elements = {
					{label = _U('cone'),		value = 'prop_roadcone02a'},
					{label = _U('barrier'),		value = 'prop_barrier_work05'},
					{label = _U('box'),			value = 'prop_boxpile_07d'}
				}
			}, function(data2, menu2)
				local model     = data2.current.value
				local playerPed = PlayerPedId()
				local coords    = GetEntityCoords(playerPed)
				local forward   = GetEntityForwardVector(playerPed)
				local x, y, z   = table.unpack(coords + forward * 1.0)

				if model == 'prop_roadcone02a' then
					z = z - 2.0
				end

				ESX.Game.SpawnObject(model, {
					x = x - 1.0,
					y = y,
					z = z + 1.0
				}, function(obj)
					SetEntityHeading(obj, GetEntityHeading(playerPed))
					PlaceObjectOnGroundProperly(obj)
				end)

			end, function(data2, menu2)
				menu2.close()
			end)
		end
	end, function(data, menu)
		menu.close()
	end)
end

function FastTravel(coords, heading)
	local playerPed = PlayerPedId()

	DoScreenFadeOut(800)

	while not IsScreenFadedOut() do
		Citizen.Wait(500)
	end

	ESX.Game.Teleport(playerPed, coords, function()
		DoScreenFadeIn(800)

		if heading then
			SetEntityHeading(playerPed, heading)
		end
	end)
end

-- Draw markers & Marker logic
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords = GetEntityCoords(PlayerPedId())
		local letSleep, isInMarker, hasExited = true, false, false
		local currentHospital, currentPart, currentPartNum

		for hospitalNum,hospital in pairs(Config.Hospitals) do
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
			-- Ambulance Actions
			for k,v in ipairs(hospital.AmbulanceActions) do
				local distance = GetDistanceBetweenCoords(playerCoords, v.Spawner, true)

				if distance < Config.DrawDistance then
					DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
					letSleep = false
				end

				if distance < v.Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'AmbulanceActions', k
				end
			end

			-- Ambulance Actions Dwon
			for k,v in ipairs(hospital.AmbulanceActionsDown) do
				local distance = GetDistanceBetweenCoords(playerCoords, v.Spawner, true)

				if distance < Config.DrawDistance then
					DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
					letSleep = false
				end

				if distance < v.Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'AmbulanceActionsDown', k
				end
			end

			-- Ambulance Actions Station 7
			for k,v in ipairs(hospital.AmbulanceActionsS7) do
				local distance = GetDistanceBetweenCoords(playerCoords, v.Spawner, true)

				if distance < Config.DrawDistance then
					DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
					letSleep = false
				end

				if distance < v.Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'AmbulanceActionsS7', k
				end
			end

			-- Boats Actions
			for k,v in ipairs(hospital.BoatsActions) do
				local distance = GetDistanceBetweenCoords(playerCoords, v.Spawner, true)

				if distance < Config.DrawDistance then
					DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
					letSleep = false
				end

				if distance < v.Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'BoatsActions', k
				end
			end

			-- Pharmacies
			for k,v in ipairs(hospital.Pharmacies) do
				local distance = GetDistanceBetweenCoords(playerCoords, v.Spawner, true)

				if distance < Config.DrawDistance then
					DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
					letSleep = false
				end

				if distance < v.Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Pharmacy', k
				end
			end

			-- Pharmacies Down
			for k,v in ipairs(hospital.PharmaciesDown) do
				local distance = GetDistanceBetweenCoords(playerCoords, v.Spawner, true)

				if distance < Config.DrawDistance then
					DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
					letSleep = false
				end

				if distance < v.Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'PharmacyDown', k
				end
			end

			-- Pharmacies Station 7
			for k,v in ipairs(hospital.PharmaciesS7) do
				local distance = GetDistanceBetweenCoords(playerCoords, v.Spawner, true)

				if distance < Config.DrawDistance then
					DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
					letSleep = false
				end

				if distance < v.Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'PharmacyS7', k
				end
			end

			-- Tools Station 7
			for k,v in ipairs(hospital.ToolsS7) do
				local distance = GetDistanceBetweenCoords(playerCoords, v.Spawner, true)

				if distance < Config.DrawDistance then
					DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
					letSleep = false
				end

				if distance < v.Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'ToolsS7', k
				end
			end

			-- DelHeli
			for k,v in ipairs(hospital.DelHeli) do
				local distance = GetDistanceBetweenCoords(playerCoords, v.Spawner, true)

				if distance < Config.DrawDistance then
					DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
					letSleep = false
				end

				if distance < v.Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'DelHeli', k
				end
			end

			-- DelVeh
			for k,v in ipairs(hospital.DelVeh) do
				local distance = GetDistanceBetweenCoords(playerCoords, v.Spawner, true)

				if distance < Config.DrawDistance then
					DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
					letSleep = false
				end

				if distance < v.Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'DelVeh', k
				end
			end

			-- DelVeh Station 7
			for k,v in ipairs(hospital.DelVehS7) do
				local distance = GetDistanceBetweenCoords(playerCoords, v.Spawner, true)

				if distance < Config.DrawDistance then
					DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
					letSleep = false
				end

				if distance < v.Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'DelVehS7', k
				end
			end

			-- Boat Del Veh
			for k,v in ipairs(hospital.BoatsDel) do
				local distance = GetDistanceBetweenCoords(playerCoords, v.Spawner, true)

				if distance < Config.DrawDistance then
					DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
					letSleep = false
				end

				if distance < v.Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'BoatsDel', k
				end
			end

			-- Vehicle Spawners
			for k,v in ipairs(hospital.Vehicles) do
				local distance = GetDistanceBetweenCoords(playerCoords, v.Spawner, true)

				if distance < Config.DrawDistance then
					DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
					letSleep = false
				end

				if distance < v.Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Vehicles', k
				end
			end

			-- Vehicle Spawners Station 7
			for k,v in ipairs(hospital.VehiclesS7) do
				local distance = GetDistanceBetweenCoords(playerCoords, v.Spawner, true)

				if distance < Config.DrawDistance then
					DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
					letSleep = false
				end

				if distance < v.Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'VehiclesS7', k
				end
			end

			-- Boats spawners
			for k,v in ipairs(hospital.Boats) do
				local distance = GetDistanceBetweenCoords(playerCoords, v.Spawner, true)

				if distance < Config.DrawDistance then
					DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
					letSleep = false
				end

				if distance < v.Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Boats', k
				end
			end

			-- Helicopter Spawners
			for k,v in ipairs(hospital.Helicopters) do
				local distance = GetDistanceBetweenCoords(playerCoords, v.Spawner, true)

				if distance < Config.DrawDistance then
					DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
					letSleep = false
				end

				if distance < v.Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Helicopters', k
				end
			end
--[[
			-- Fast Travels
			for k,v in ipairs(hospital.FastTravels) do
				local distance = GetDistanceBetweenCoords(playerCoords, v.From, true)

				if distance < Config.DrawDistance then
					DrawMarker(v.Marker.type, v.From, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
					letSleep = false
				end


				if distance < v.Marker.x then
					FastTravel(v.To.coords, v.To.heading)
				end
			end
]]
			-- Fast Travels (Prompt)
			for k,v in ipairs(hospital.FastTravelsPrompt) do
				local distance = GetDistanceBetweenCoords(playerCoords, v.From, true)

				if distance < Config.DrawDistance then
					DrawMarker(v.Marker.type, v.From, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
					letSleep = false
				end

				if distance < v.Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'FastTravelsPrompt', k
				end
			end
			end
		end

		-- Logic for exiting & entering markers
		if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastHospital ~= currentHospital or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then

			if
				(LastHospital ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
				(LastHospital ~= currentHospital or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
			then
				TriggerEvent('esx_ambulancejob:hasExitedMarker', LastHospital, LastPart, LastPartNum)
				hasExited = true
			end

			HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum = true, currentHospital, currentPart, currentPartNum

			TriggerEvent('esx_ambulancejob:hasEnteredMarker', currentHospital, currentPart, currentPartNum)

		end

		if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_ambulancejob:hasExitedMarker', LastHospital, LastPart, LastPartNum)
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

AddEventHandler('esx_ambulancejob:hasEnteredMarker', function(hospital, part, partNum)
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
		if part == 'AmbulanceActions' then
			CurrentAction = part
			CurrentActionMsg = _U('actions_prompt')
			CurrentActionData = {}
		elseif part == 'AmbulanceActionsDown' then
			CurrentAction = part
			CurrentActionMsg = _U('actions_prompt')
			CurrentActionData = {}
		elseif part == 'AmbulanceActionsS7' then
			CurrentAction = part
			CurrentActionMsg = _U('actions_prompt')
			CurrentActionData = {}
		elseif part == 'BoatsActions' then
			CurrentAction = part
			CurrentActionMsg = _U('actions_prompt')
			CurrentActionData = {}
		elseif part == 'Pharmacy' then
			CurrentAction = part
			CurrentActionMsg = _U('open_pharmacy')
			CurrentActionData = {}
		elseif part == 'PharmacyDown' then
			CurrentAction = part
			CurrentActionMsg = _U('open_pharmacy')
			CurrentActionData = {}
		elseif part == 'PharmacyS7' then
			CurrentAction = part
			CurrentActionMsg = _U('open_pharmacy')
			CurrentActionData = {}
		elseif part == 'ToolsS7' then
			CurrentAction = part
			CurrentActionMsg = _U('open_tools')
			CurrentActionData = {}
		elseif part == 'DelHeli' then
			CurrentAction = part
			CurrentActionMsg = _U('open_delheli')
			urrentActionData = {hospital = hospital, partNum = partNum}
		elseif part == 'DelVeh' then
			CurrentAction = part
			CurrentActionMsg = _U('open_delveh')
			urrentActionData = {hospital = hospital, partNum = partNum}
		elseif part == 'DelVehS7' then
			CurrentAction = part
			CurrentActionMsg = _U('open_delveh')
			urrentActionData = {hospital = hospital, partNum = partNum}
		elseif part == 'BoatsDel' then
			CurrentAction = part
			CurrentActionMsg = _U('open_delveh')
			urrentActionData = {hospital = hospital, partNum = partNum}
		elseif part == 'Vehicles' then
			CurrentAction = part
			CurrentActionMsg = _U('garage_prompt')
			CurrentActionData = {hospital = hospital, partNum = partNum}
		elseif part == 'VehiclesS7' then
			CurrentAction = part
			CurrentActionMsg = _U('garage_prompt')
			CurrentActionData = {hospital = hospital, partNum = partNum}
		elseif part == 'Boats' then
			CurrentAction = part
			CurrentActionMsg = _U('garage_prompt')
			CurrentActionData = {hospital = hospital, partNum = partNum}
		elseif part == 'Helicopters' then
			CurrentAction = part
			CurrentActionMsg = _U('helicopter_prompt')
			CurrentActionData = {hospital = hospital, partNum = partNum}
		elseif part == 'FastTravelsPrompt' then
			local travelItem = Config.Hospitals[hospital][part][partNum]

			CurrentAction = part
			CurrentActionMsg = travelItem.Prompt
			CurrentActionData = {to = travelItem.To.coords, heading = travelItem.To.heading}
		end



		
	end
end)

AddEventHandler('esx_ambulancejob:hasExitedMarker', function(hospital, part, partNum)
	if not isInShopMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)

AddEventHandler('esx_ambulancejob:hasEnteredEntityZone', function(entity)
	local playerPed = PlayerPedId()

	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' and IsPedOnFoot(playerPed) then
		CurrentAction     = 'remove_entity'
		CurrentActionMsg  = _U('remove_prop')
		CurrentActionData = {entity = entity}
	end

	if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed)

			for i=0, 7, 1 do
				SetVehicleTyreBurst(vehicle, i, true, 1000)
			end
		end
	end
end)

AddEventHandler('esx_ambulancejob:hasExitedEntityZone', function(entity)
	if CurrentAction == 'remove_entity' then
		CurrentAction = nil
	end
end)

-- Enter / Exit entity zone events
Citizen.CreateThread(function()
	local trackedEntities = {
		'prop_roadcone02a',
		'prop_barrier_work05',
		'p_ld_stinger_s',
		'prop_boxpile_07d',
		'hei_prop_cash_crate_half_full'
	}

	while true do
		Citizen.Wait(500)

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		local closestDistance = -1
		local closestEntity   = nil

		for i=1, #trackedEntities, 1 do
			local object = GetClosestObjectOfType(coords, 3.0, GetHashKey(trackedEntities[i]), false, false, false)

			if DoesEntityExist(object) then
				local objCoords = GetEntityCoords(object)
				local distance  = GetDistanceBetweenCoords(coords, objCoords, true)

				if closestDistance == -1 or closestDistance > distance then
					closestDistance = distance
					closestEntity   = object
				end
			end
		end

		if closestDistance ~= -1 and closestDistance <= 3.0 then
			if LastEntity ~= closestEntity then
				TriggerEvent('esx_ambulancejob:hasEnteredEntityZone', closestEntity)
				LastEntity = closestEntity
			end
		else
			if LastEntity ~= nil then
				TriggerEvent('esx_ambulancejob:hasExitedEntityZone', LastEntity)
				LastEntity = nil
			end
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) then

				if CurrentAction == 'AmbulanceActions' then
					OpenAmbulanceActionsMenu()
				elseif CurrentAction == 'AmbulanceActionsDown' then
					OpenAmbulanceActionsMenuDown()
				elseif CurrentAction == 'AmbulanceActionsS7' then
					OpenAmbulanceActionsMenuS7()
				elseif CurrentAction == 'BoatsActions' then
					OpenBoatsActions()
				elseif CurrentAction == 'Pharmacy' then
					OpenPharmacyMenu()
				elseif CurrentAction == 'PharmacyDown' then
					OpenPharmacyMenu()
				elseif CurrentAction == 'PharmacyS7' then
					OpenPharmacyMenuS7()
				elseif CurrentAction == 'ToolsS7' then
					OpenToolsMenuS7()
				elseif CurrentAction == 'DelHeli' then
					DelHeliFCN(CurrentActionData.hospital, CurrentActionData.partNum)
				elseif CurrentAction == 'DelVeh' then
					DelVehFCN(CurrentActionData.hospital, CurrentActionData.partNum)
				elseif CurrentAction == 'DelVehS7' then
					DelVehFCN(CurrentActionData.hospital, CurrentActionData.partNum)
				elseif CurrentAction == 'BoatsDel' then
					DelVehFCN(CurrentActionData.hospital, CurrentActionData.partNum)
				elseif CurrentAction == 'Vehicles' then
					OpenVehicleSpawnerMenu(CurrentActionData.hospital, CurrentActionData.partNum)
				elseif CurrentAction == 'VehiclesS7' then
					OpenVehicleSpawnerMenuS7(CurrentActionData.hospital, CurrentActionData.partNum)
				elseif CurrentAction == 'Boats' then
					OpenBoatSpawnerMenu(CurrentActionData.hospital, CurrentActionData.partNum)
				elseif CurrentAction == 'Helicopters' then
					OpenHelicopterSpawnerMenu(CurrentActionData.hospital, CurrentActionData.partNum)
				elseif CurrentAction == 'FastTravelsPrompt' then
					FastTravel(CurrentActionData.to, CurrentActionData.heading)
				elseif CurrentAction == 'remove_entity' then
					DeleteEntity(CurrentActionData.entity)
				end

				CurrentAction = nil

			end

		elseif ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' and not IsDead then
			if IsControlJustReleased(0, Keys['F6']) then
				OpenMobileAmbulanceActionsMenu()
			end
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
			end
		end
	end
end)


function OpenCloakroomMenu()

	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'cloakroom',
	  {
		title    = _U('cloakroom'),
		align    = 'top-left',
		elements = {
			{label = _U('ems_clothes_civil'), value = 'citizen_wear'},
			{label = "Paramedic mundur krótki", value = 'ambulance_wear'},
			{label = "Paramedic mundur długi", value = 'ambulance_wear_def'},
			{label = "Paramedic Kurtka", value = 'ambulance_wear7'},
			{label = "Luźny Paramedic", value = 'ambulance_wear5'},
			{label = "Lekarz niebieski krótki", value = 'ambulance_wear_3'},
			{label = "Lekarz niebieski długi", value = 'ambulance_wear_2'},
			{label = "Lekarz Kurtka", value = 'ambulance_wear6'},
			{label = "Luźny Lekarz", value = 'ambulance_wear4'},
			{label = "Strój pilota", value = 'skin-diver'},
			{label = "Strój koronera", value = 'skin-polarz'},

		},
	  },
	  function(data, menu)
  
		menu.close()
  
		if data.current.value == 'citizen_wear' then
  
			  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				TriggerEvent('skinchanger:loadSkin', skin)
			  end)
		end

  
		if data.current.value == 'ambulance_wear_def' then
  
		  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
		  
			  local skinm = {tshirt_1 = 15, tshirt_2 = 0, torso_1 = 249, torso_2 = 1, arms = 86, decals_1 = 57, pants_1 = 48, pants_2 = 1, shoes_1 = 25, shoes_2 = 0, bproof_1 = 2}
			  local skinfm = {tshirt_1 = 17, tshirt_2 = 0, torso_1 = 257, torso_2 = 1, arms = 101,decals_1 = 65, pants_1 = 41, pants_2 = 3, shoes_1 = 25, shoes_2 = 0, bproof_1 = 2}
		  
			  if skin.sex == 0 then
				TriggerEvent('skinchanger:loadClothes', skin, skinm)
			  else
				TriggerEvent('skinchanger:loadClothes', skin, skinfm)
		  end
		end)
	  end
		
		
		if data.current.value == 'ambulance_wear' then
  
		  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
  
			  local skinm = {tshirt_1 = 15, tshirt_2 = 0, torso_1 = 74, torso_2 = 0, decals_1 = 54, decals_2 = 0, arms = 85, pants_1 = 48, pants_2 = 1, shoes_1 = 25, shoes_2 = 0, bproof_1 = 2}
			  local skinfm = {tshirt_1 = 59, tshirt_2 = 0, torso_1 = 25, torso_2 = 0, decals_1 = 0, decals_2 = 0, arms = 109, pants_1 = 41, pants_2 = 3, shoes_1 = 25, shoes_2 = 0, bproof_1 = 2}
		  
			  if skin.sex == 0 then
				TriggerEvent('skinchanger:loadClothes', skin, skinm)
			  else
				TriggerEvent('skinchanger:loadClothes', skin, skinfm)
		  end
		end)
	  end
		
		if data.current.value == 'ambulance_wear_2' then
  
		  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
  
			  local skinm = {tshirt_1 = 15, tshirt_2 = 0, torso_1 = 118, torso_2 = 6, arms = 86, pants_1 = 24, pants_2 = 2, shoes_1 = 7, shoes_2 = 0, chain_1 = 126}
			  local skinfm = {tshirt_1 = 15, tshirt_2 = 0, torso_1 = 18, torso_2 = 6, arms = 101, pants_1 = 112, pants_2 = 2, shoes_1 = 1, shoes_2 = 0, chain_1 = 96}

		  if skin.sex == 0 then
			TriggerEvent('skinchanger:loadClothes', skin, skinm)
		  else
			TriggerEvent('skinchanger:loadClothes', skin, skinfm)
	  end
	end)
  end
		
		if data.current.value == 'ambulance_wear_3' then
  
		  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
  
			local skinm = {tshirt_1 = 15, tshirt_2 = 0, torso_1 = 74, torso_2 = 6, arms = 85, pants_1 = 24, pants_2 = 2, shoes_1 = 7, shoes_2 = 0, chain_1 = 126}
			  local skinfm = {tshirt_1 = 15, tshirt_2 = 0, torso_1 = 25, torso_2 = 6, arms = 109, pants_1 = 112, pants_2 = 2, shoes_1 = 1, shoes_2 = 0, chain_1 = 96}
		  
			  if skin.sex == 0 then
				TriggerEvent('skinchanger:loadClothes', skin, skinm)
			  else
				TriggerEvent('skinchanger:loadClothes', skin, skinfm)
		  end
		end)
	end
		if data.current.value == 'ambulance_wear4' then
  
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
	
			  local skinm = {tshirt_1 = 87, tshirt_2 = 0, torso_1 = 73, torso_2 = 15, arms = 85, pants_1 = 59, pants_2 = 0, shoes_1 = 25, shoes_2 = 0, chain_1 = 30, chain_2 = 0, bproof_1 = 29, bproof_2 = 0}
				local skinfm = {tshirt_1 = 6, tshirt_2 = 0, torso_1 = 224, torso_2 = 23, arms = 109, pants_1 = 61, pants_2 = 0, shoes_1 = 25, shoes_2 = 0, chain_1 = 14, chain_2 = 2, bproof_1 = 33, bproof_2 = 0}
			
				if skin.sex == 0 then
				  TriggerEvent('skinchanger:loadClothes', skin, skinm)
				else
				  TriggerEvent('skinchanger:loadClothes', skin, skinfm)
			end
		  end)
		end
		  if data.current.value == 'ambulance_wear5' then
  
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
	
				local skinm = {tshirt_1 = 87, tshirt_2 = 0, torso_1 = 73, torso_2 = 14, arms = 85, pants_1 = 59, pants_2 = 0, shoes_1 = 25, shoes_2 = 0, bproof_1 = 29, bproof_2 = 0}
				local skinfm = {tshirt_1 = 6, tshirt_2 = 0, torso_1 = 224, torso_2 = 21, arms = 109, pants_1 = 61, pants_2 = 0, shoes_1 = 25, shoes_2 = 0, bproof_1 = 33, bproof_2 = 0}
			
				if skin.sex == 0 then
				  TriggerEvent('skinchanger:loadClothes', skin, skinm)
				else
				  TriggerEvent('skinchanger:loadClothes', skin, skinfm)
			end
		  end)
	  end
	  if data.current.value == 'ambulance_wear6' then
  
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

			local skinm = {tshirt_1 = 66, tshirt_2 = 9, torso_1 = 151, torso_2 = 5, arms = 86, pants_1 = 35, pants_2 = 0, shoes_1 = 25, shoes_2 = 0, chain_1 = 30}
			local skinfm = {tshirt_1 = 46, tshirt_2 = 9, torso_1 = 148, torso_2 = 5, arms = 109, pants_1 = 34, pants_2 = 4, shoes_1 = 25, shoes_2 = 0, chain_1 = 14}
		
			if skin.sex == 0 then
			  TriggerEvent('skinchanger:loadClothes', skin, skinm)
			else
			  TriggerEvent('skinchanger:loadClothes', skin, skinfm)
		end
	  end)
  end
  if data.current.value == 'ambulance_wear7' then
  
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

		local skinm = {tshirt_1 = 66, tshirt_2 = 8, torso_1 = 151, torso_2 = 2, arms = 86, pants_1 = 35, pants_2 = 0, shoes_1 = 25, shoes_2 = 0}
		local skinfm = {tshirt_1 = 46, tshirt_2 = 8, torso_1 = 148, torso_2 = 2, arms = 109, pants_1 = 34, pants_2 = 0, shoes_1 = 25, shoes_2 = 0}
	
		if skin.sex == 0 then
		  TriggerEvent('skinchanger:loadClothes', skin, skinm)
		else
		  TriggerEvent('skinchanger:loadClothes', skin, skinfm)
	end
  end)
end
			  
			  if data.current.value == 'skin-diver' then
  
		  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
  
			local skinm = {tshirt_1 = 15, tshirt_2 = 0, torso_1 = 249, torso_2 = 0, arms = 85, decals_1 = 57, pants_1 = 48, pants_2 = 1, shoes_1 = 25, shoes_2 = 0, bproof_1 = 2, helmet_1 = 79}
			local skinfm = {tshirt_1 = 17, tshirt_2 = 0, torso_1 = 257, torso_2 = 1, arms = 101,decals_1 = 65, pants_1 = 41, pants_2 = 3, shoes_1 = 25, shoes_2 = 0, bproof_1 = 2, helmet_1 = 78}
		  
			if skin.sex == 0 then
				TriggerEvent('skinchanger:loadClothes', skin, skinm)
			  else
				TriggerEvent('skinchanger:loadClothes', skin, skinfm)
		  end
		end)
	  end
	  
		if data.current.value == 'skin-polarz' then
  
		  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
  
			  local skinm = {tshirt_1 = 76, tshirt_2 = 1, torso_1 = 35, torso_2 = 6, arms = 39, pants_1 = 4, pants_2 = 4, shoes_1 = 26, shoes_2 = 1}
			  local skinfm = {tshirt_1 = 59, tshirt_2 = 1, torso_1 = 179, torso_2 = 6, arms = 39, pants_1 = 3, pants_2 = 2, shoes_1 = 27, shoes_2 = 0}
		  
				if skin.sex == 0 then
				  TriggerEvent('skinchanger:loadClothes', skin, skinm)
				else
				  TriggerEvent('skinchanger:loadClothes', skin, skinfm)
			end
		  end)
		end
		  menu.close()
	  end,function(data, menu)
		  menu.close()
	  end)
  end

  function OpenBoatsActions()

	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'cloakroom',
	  {
		title    = _U('cloakroom'),
		align    = 'top-left',
		elements = {
			{label = _U('ems_clothes_civil'), value = 'citizen_wear'},
			{label = 'Strój Nurka', value = 'scubba'}
		},
	  },
	  function(data, menu)
  
		menu.close()
  
		if data.current.value == 'citizen_wear' then
  
			  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				TriggerEvent('skinchanger:loadSkin', skin)
			  end)
		end

  
		if data.current.value == 'scubba' then
  
		  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
		  
			  local skinm = {tshirt_1 = 123, tshirt_2 = 4, torso_1 = 243, torso_2 = 4, arms = 38, pants_1 = 94, pants_2 = 4, shoes_1 = 67, shoes_2 = 4, mask_1 = 52, mask_2 = 0, glasses_1 = 22, glasses_2 = 0, face = 0, hair_1 = 0, hair_2 = 0}
			  local skinfm = {tshirt_1 = 153, tshirt_2 = 4, torso_1 = 251, torso_2 = 4, arms = 40, pants_1 = 97, pants_2 = 4, shoes_1 = 70, shoes_2 = 4, mask_1 = 52, mask_2 = 0, glasses_1 = 23, glasses_2 = 0, face = 0, hair_1 = 0, hair_2 = 0}
		  
			  if skin.sex == 0 then
				TriggerEvent('skinchanger:loadClothes', skin, skinm)
			  else
				TriggerEvent('skinchanger:loadClothes', skin, skinfm)
		  end
		end)
	  end

		  menu.close()
	  end,function(data, menu)
		  menu.close()
	  end)
  end

  function OpenCloakroomMenuS7()

	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'cloakroom',
	  {
		title    = _U('cloakroom'),
		align    = 'top-left',
		elements = {
			{label = _U('ems_clothes_civil'), value = 'citizen_wear'},
			{label = "Paramedic mundur krótki", value = 'ambulance_wear'},
			{label = "Paramedic mundur długi", value = 'ambulance_wear_def'},
			{label = "Pełny mundur strażacki", value = 'skinstrazak'},
			{label = "Luźny mundur strażacki", value = 'skinstrazak2'},
			{label = "Strój pilota", value = 'skin-diver'}
		},
	  },
	  function(data, menu)
  
		menu.close()
  
		if data.current.value == 'citizen_wear' then
  
			  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				TriggerEvent('skinchanger:loadSkin', skin)
			  end)
		end

  
		if data.current.value == 'ambulance_wear_def' then
  
		  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
		  
			  local skinm = {tshirt_1 = 15, tshirt_2 = 0, torso_1 = 249, torso_2 = 1, arms = 86, decals_1 = 57, pants_1 = 48, pants_2 = 1, shoes_1 = 25, shoes_2 = 0, bproof_1 = 2}
			  local skinfm = {tshirt_1 = 17, tshirt_2 = 0, torso_1 = 257, torso_2 = 1, arms = 101,decals_1 = 65, pants_1 = 41, pants_2 = 3, shoes_1 = 25, shoes_2 = 0, bproof_1 = 2}
		  
			  if skin.sex == 0 then
				TriggerEvent('skinchanger:loadClothes', skin, skinm)
			  else
				TriggerEvent('skinchanger:loadClothes', skin, skinfm)
		  end
		end)
	  end
		
		
		if data.current.value == 'ambulance_wear' then
  
		  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
  
			  local skinm = {tshirt_1 = 15, tshirt_2 = 0, torso_1 = 74, torso_2 = 0, decals_1 = 54, decals_2 = 0, arms = 85, pants_1 = 48, pants_2 = 1, shoes_1 = 25, shoes_2 = 0, bproof_1 = 2}
			  local skinfm = {tshirt_1 = 59, tshirt_2 = 0, torso_1 = 25, torso_2 = 0, decals_1 = 0, decals_2 = 0, arms = 109, pants_1 = 41, pants_2 = 3, shoes_1 = 25, shoes_2 = 0, bproof_1 = 2}
		  
			  if skin.sex == 0 then
				TriggerEvent('skinchanger:loadClothes', skin, skinm)
			  else
				TriggerEvent('skinchanger:loadClothes', skin, skinfm)
		  end
		end)
	  end
			  
			  if data.current.value == 'skin-diver' then
  
		  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
  
			local skinm = {tshirt_1 = 15, tshirt_2 = 0, torso_1 = 249, torso_2 = 1, arms = 85, decals_1 = 57, pants_1 = 48, pants_2 = 1, shoes_1 = 25, shoes_2 = 0, bproof_1 = 2, helmet_1 = 79}
			local skinfm = {tshirt_1 = 17, tshirt_2 = 0, torso_1 = 257, torso_2 = 1, arms = 101,decals_1 = 65, pants_1 = 41, pants_2 = 3, shoes_1 = 25, shoes_2 = 0, bproof_1 = 2, helmet_1 = 78}
		  
			if skin.sex == 0 then
				TriggerEvent('skinchanger:loadClothes', skin, skinm)
			  else
				TriggerEvent('skinchanger:loadClothes', skin, skinfm)
		  end
		end)
	  end
	  
		if data.current.value == 'skinstrazak' then
  
		  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
  
			  local skinm = {tshirt_1 = 15, tshirt_2 = 0, torso_1 = 77, torso_2 = 0, arms = 39, pants_1 = 43, pants_2 = 0, shoes_1 = 13, shoes_2 = 0, decals_1 = 16, decals_2 = 0, helmet_1 = 45, helmet_2 = 0}
			  local skinfm = {tshirt_1 = 15, tshirt_2 = 0, torso_1 = 64, torso_2 = 0, arms = 55, pants_1 = 48, pants_2 = 1, shoes_1 = 25, shoes_2 = 0, decals_1 = 15, decals_2 = 0, helmet_1 = 44, helmet_2 = 0}
		  
				if skin.sex == 0 then
				  TriggerEvent('skinchanger:loadClothes', skin, skinm)
				else
				  TriggerEvent('skinchanger:loadClothes', skin, skinfm)
			end
		  end)
		end

		if data.current.value == 'skinstrazak2' then
  
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
	
				local skinm = {tshirt_1 = 15, tshirt_2 = 0, torso_1 = 74, torso_2 = 1, decals_1 = 0, decals_2 = 0, arms = 85, pants_1 = 48, pants_2 = 1, shoes_1 = 25, shoes_2 = 0, bproof_1 = 2, bproof_2 = 2}
				local skinfm = {tshirt_1 = 59, tshirt_2 = 0, torso_1 = 25, torso_2 = 1, decals_1 = 0, decals_2 = 0, arms = 109, pants_1 = 41, pants_2 = 3, shoes_1 = 25, shoes_2 = 0, bproof_1 = 2, bproof_2 = 2}
			
				  if skin.sex == 0 then
					TriggerEvent('skinchanger:loadClothes', skin, skinm)
				  else
					TriggerEvent('skinchanger:loadClothes', skin, skinfm)
			  end
			end)
		  end

		  menu.close()
	  end,function(data, menu)
		  menu.close()
	  end)
  end

function OpenVehicleSpawnerMenu()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'garage_title',
      {
        title    = _U('garage_title'),
        align    = 'top-left',
        elements = {
          --{label = 'Chevrolet Tahoe',  value = 'Tahoefire'},
		  {label = 'Vapid V-450',  value = 'ambulance33'},
		  {label = 'Dodge Charger', value = 'dodgefire'}
        },
      },
      function(data, menu)
        ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 299.0, function(vehicle)
			TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
			SetVehicleMaxMods(vehicle)
			SetVehicleExtra(vehicle, 1, extras)
			SetVehicleExtra(vehicle, 2, extras)
			SetVehicleExtra(vehicle, 3, extras)
			SetVehicleExtra(vehicle, 4, extras)
			SetVehicleExtra(vehicle, 5, extras)
			SetVehicleExtra(vehicle, 6, extras)
			SetVehicleExtra(vehicle, 7, extras)
			SetVehicleExtra(vehicle, 8, extras)
			SetVehicleExtra(vehicle, 9, extras)
			SetVehicleExtra(vehicle, 10, extras)
			SetVehicleExtra(vehicle, 11, extras)
			SetVehicleExtra(vehicle, 12, extras)
			SetVehicleExtra(vehicle, 13, extras)
			SetVehicleExtra(vehicle, 14, extras)
			SetVehicleExtra(vehicle, 15, extras)
			SetVehicleExtra(vehicle, 16, extras)
			SetVehicleExtra(vehicle, 17, extras)
			local rand = math.random(1000,9999)
			SetVehicleNumberPlateText(vehicle, "LSFD"..rand)
			AddVehicleKeys(vehicle)
			TriggerEvent('ambulancelog_send')
		end)
		
        menu.close()
      end,
      function(data, menu)
        CurrentAction     = 'vehicle_spawner_menu'
        CurrentActionMsg  = _U('veh_spawn')
        CurrentActionData = {}
	  end)	
end

function OpenVehicleSpawnerMenuS7()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'garage_title',
      {
        title    = _U('garage_title'),
        align    = 'top-left',
        elements = {
		  {label = 'MTL Fire Truck',  value = 'firetruk'},
		  {label = 'Vapid V-450',  value = 'ambulance33'},
		  {label = 'Chevrolet Tahoe',  value = 'Tahoefire'}
        },
      },
      function(data, menu)
        ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPointS7.Pos, 360.0, function(vehicle)
			TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
			SetVehicleMaxMods(vehicle)
			SetVehicleExtra(vehicle, 1, extras)
			SetVehicleExtra(vehicle, 2, extras)
			SetVehicleExtra(vehicle, 3, extras)
			SetVehicleExtra(vehicle, 4, extras)
			SetVehicleExtra(vehicle, 5, extras)
			SetVehicleExtra(vehicle, 6, extras)
			SetVehicleExtra(vehicle, 7, extras)
			SetVehicleExtra(vehicle, 8, extras)
			SetVehicleExtra(vehicle, 9, extras)
			SetVehicleExtra(vehicle, 10, extras)
			SetVehicleExtra(vehicle, 11, extras)
			SetVehicleExtra(vehicle, 12, extras)
			SetVehicleExtra(vehicle, 13, extras)
			SetVehicleExtra(vehicle, 14, extras)
			SetVehicleExtra(vehicle, 15, extras)
			SetVehicleExtra(vehicle, 16, extras)
			SetVehicleExtra(vehicle, 17, extras)
			local rand = math.random(1000,9999)
			SetVehicleNumberPlateText(vehicle, "LSFD"..rand)
			AddVehicleKeys(vehicle)
			TriggerEvent('ambulancelog_send')
		end)
		
        menu.close()
      end,
      function(data, menu)
        CurrentAction     = 'vehicle_spawner_menu'
        CurrentActionMsg  = _U('veh_spawn')
        CurrentActionData = {}
	  end)	
end

function OpenBoatSpawnerMenu()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'garage_title',
      {
        title    = 'Motorówki',
        align    = 'top-left',
        elements = {
		  {label = 'Motorówka',  value = 'dinghy'},
        },
      },
      function(data, menu)
        ESX.Game.SpawnVehicle(data.current.value, Config.Zones.BoatSpawnPoint.Pos, 130.0, function(vehicle)
			TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
			SetVehicleMaxMods(vehicle)
			SetVehicleExtra(vehicle, 1, extras)
			SetVehicleExtra(vehicle, 2, extras)
			SetVehicleExtra(vehicle, 3, extras)
			SetVehicleExtra(vehicle, 4, extras)
			SetVehicleExtra(vehicle, 5, extras)
			SetVehicleExtra(vehicle, 6, extras)
			SetVehicleExtra(vehicle, 7, extras)
			SetVehicleExtra(vehicle, 8, extras)
			SetVehicleExtra(vehicle, 9, extras)
			SetVehicleExtra(vehicle, 10, extras)
			SetVehicleExtra(vehicle, 11, extras)
			SetVehicleExtra(vehicle, 12, extras)
			SetVehicleExtra(vehicle, 13, extras)
			SetVehicleExtra(vehicle, 14, extras)
			SetVehicleExtra(vehicle, 15, extras)
			SetVehicleExtra(vehicle, 16, extras)
			SetVehicleExtra(vehicle, 17, extras)
			local rand = math.random(1000,9999)
			SetVehicleNumberPlateText(vehicle, "LSFD"..rand)
			AddVehicleKeys(vehicle)
			TriggerEvent('ambulancelog_send')
		end)
		
        menu.close()
      end,
      function(data, menu)
        CurrentAction     = 'vehicle_spawner_menu'
        CurrentActionMsg  = _U('veh_spawn')
        CurrentActionData = {}
	  end)	
end

AddEventHandler('ambulancelog_send',function ()
 --logi
 local Player = ESX.GetPlayerData()
 local org = Player.job.name	
 Citizen.Wait(100)
 local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId()))))
	 if model == "NULL" then
		 model = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId())))
	 end
 TriggerServerEvent('srp_logs:ambulanceGarageLog',org,model,1)
end)

function SetVehicleMaxMods(vehicle)

	local props = {
	  modEngine       = 2,
	  modBrakes       = 2,
	  modTransmission = 2,
	  modXenon   = 1,
	  modTurbo        = true,
	}
  
	ESX.Game.SetVehicleProperties(vehicle, props)
  
  end

function OpenHelicopterSpawnerMenu()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'heli_spawner',
	  {
		title    = 'Helikopter',
		align    = 'bottom-right',
		elements = {
			{label = 'SAMS Maverick',  value = 'vcpdmav22'},
			{label = 'SAMS Ratunkowy',  value = 'seasparrow'},
		},
	  },
	  function(data, menu)
		ESX.Game.SpawnVehicle(data.current.value, Config.Zones.HelicopterSpawner.Pos, 319.0, function(vehicle)
		  TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
		  SetVehicleLivery(vehicle, 1)
		end)
		TriggerEvent('ambulancelog_send')
		menu.close()
	  end, function(data, menu)
		CurrentAction     = 'heli_spawner'
		CurrentActionMsg  = 'Naciśnij ~INPUT_CONTEXT~ aby wyciągnąć helikopter'
		CurrentActionData = {}
	  end)
end

----Usuwanie Helikoptera
--[[Citizen.CreateThread(function()
	while true do
       	 Citizen.Wait(0)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, 349.58, -593.99, 74.55-0.97)
---
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' and dist <= 20.0 then
				DrawMarker(27, 349.58, -593.99, 74.55-0.97, 0, 0, 0, 0, 0, 0, 2.50, 2.50, 2.00, 255, 0, 0, 200, 0, 0, 0, 0)
			else
				Citizen.Wait(1500)
			end
			--
			--if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' and dist <= 2.5 then
				--DrawText3D(349.58, -593.99, 74.55-0.97, "~g~~h~[E]~h~~w~ Aby schować helikopter do garażu")
			--end

			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' and dist <= 2.5 then
				CurrentAction     = 'heli_spawner'
				CurrentActionMsg  = 'Naciśnij ~INPUT_CONTEXT~ aby schować helikopter'
				CurrentActionData = {}
			elseif dist >= 2.5 then
				ESX.UI.Menu.CloseAll()
			end
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' and dist <= 2.5 then
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					local playerPed = PlayerPedId()
					if IsPedSittingInAnyVehicle(playerPed) then
						local vehicle = GetVehiclePedIsIn(playerPed, false)
						if GetPedInVehicleSeat(vehicle, -1) == playerPed then
							ESX.ShowNotification("~y~Pojazd został schowany do garażu.")
							ESX.Game.DeleteVehicle(vehicle)
						else
							ESX.ShowNotification("~y~Musisz siedzieć za sterami aby schować helikopter!")
						end
					end			
				end
			end
	end
end)
]]

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if isInShopMenu then
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		else
			Citizen.Wait(500)
		end
	end
end)



function drawLoadingText(text, red, green, blue, alpha)
	SetTextFont(4)
	SetTextScale(0.0, 0.5)
	SetTextColour(red, green, blue, alpha)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)

	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.5, 0.5)
end

function DelHeliFCN()
	local playerPed = PlayerPedId()
	if IsPedSittingInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if GetPedInVehicleSeat(vehicle, -1) == playerPed then
			--ESX.ShowNotification("~w~Pojazd został schowany do garażu.")
			exports['mythic_notify']:DoCustomHudText('success', 'Pojazd został schowany do garażu!', 3000)
			--logi
			local Player = ESX.GetPlayerData()
			local org = Player.job.name	
			Citizen.Wait(100)
			local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId()))))
				if model == "NULL" then
					model = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId())))
				end
			TriggerServerEvent('srp_logs:ambulanceGarageLog',org,model,0)
			ESX.Game.DeleteVehicle(vehicle)
		else
			--ESX.ShowNotification("~w~Musisz siedzieć za ~r~sterami ~w~aby schować helikopter!")
			exports['mythic_notify']:DoCustomHudText('error', 'Musisz siedzieć za sterami aby schować helikopter!', 3000)
		end
	end	
end
function DelVehFCN()
	local playerPed = PlayerPedId()
	if IsPedSittingInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if GetPedInVehicleSeat(vehicle, -1) == playerPed then
			--ESX.ShowNotification("~w~Pojazd został schowany do garażu.")
			exports['mythic_notify']:DoCustomHudText('success', 'Pojazd został schowany do garażu!', 3000)
				--logi
			local Player = ESX.GetPlayerData()
			local org = Player.job.name	
			Citizen.Wait(100)
			local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId()))))
				if model == "NULL" then
					model = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId())))
				end
			TriggerServerEvent('srp_logs:ambulanceGarageLog',org,model,0)
			ESX.Game.DeleteVehicle(vehicle)
		else
			--ESX.ShowNotification("~w~Musisz siedzieć na miejscu ~r~kierowcy ~w~aby schować pojazd!")
			exports['mythic_notify']:DoCustomHudText('error', 'Musisz siedzieć na miejscu kierowcy aby schować pojazd!', 3000)
		end
	end	
end

function OpenPharmacyMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pharmacy', {
		title    = _U('pharmacy_menu_title'),
		align    = 'top-left',
		elements = {
			{label = _U('pharmacy_take', _U('medikit')), value = 'medikit'},
			{label = _U('pharmacy_take', _U('medkit')), value = 'medkit'},
			{label = _U('pharmacy_take', _U('bandage')), value = 'bandage'},
			{label = _U('pharmacy_take', _U('radio')), value = 'radio'},
			{label = _U('pharmacy_take', _U('water')), value = 'water'}
		}
	}, function(data, menu)
		TriggerServerEvent('esx_ambulancejob:giveItem', data.current.value)
		TriggerEvent('ambulanceItem_pass',data.current.value)		
	end, function(data, menu)
		menu.close()
	end)
end

function OpenPharmacyMenuS7()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pharmacy', {
		title    = _U('pharmacy_menu_title'),
		align    = 'top-left',
		elements = {
			{label = _U('pharmacy_take', _U('medikit')), value = 'medikit'},
			{label = _U('pharmacy_take', _U('medkit')), value = 'medkit'},
			{label = _U('pharmacy_take', _U('bandage')), value = 'bandage'},
			{label = _U('pharmacy_take', _U('radio')), value = 'radio'},
			{label = _U('pharmacy_take', _U('water')), value = 'water'}
		}
	}, function(data, menu)
		TriggerServerEvent('esx_ambulancejob:giveItem', data.current.value)
		TriggerEvent('ambulanceItem_pass',data.current.value)		
	end, function(data, menu)
		menu.close()
	end)
end

function OpenToolsMenuS7()
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'tools', {
		title = _U('tools_menu_title'),
		align = 'top-left',
		elements = {
			{label = 'Gaśnica', value = 'fireextinguisher'},
			{label = 'Młotek', value = 'hammer'},
			{label = 'Łom', value = 'crowbar'},
			{label = 'Latarka', value = 'flashlight'}
		}
	}, function(data, menu)
		if data.current.value == 'fireextinguisher' then
			exports['mythic_notify']:DoCustomHudText('success', 'Pobrałeś Gaśnicę', 3000)
			TriggerServerEvent('esx_ambulancejob:fireextinguisher')
			ESX.UI.Menu.CloseAll()
		end
		if data.current.value == 'hammer' then
			exports['mythic_notify']:DoCustomHudText('success', 'Pobrałeś Młotek', 3000)
			TriggerServerEvent('esx_ambulancejob:givehammer')
			ESX.UI.Menu.CloseAll()
		end
		if data.current.value == 'crowbar' then
			exports['mythic_notify']:DoCustomHudText('success', 'Pobrałeś Łom', 3000)
			TriggerServerEvent('esx_ambulancejob:givecrowbar')
			ESX.UI.Menu.CloseAll()
		end
		if data.current.value == 'flashlight' then
			exports['mythic_notify']:DoCustomHudText('success', 'Pobrałeś Latarkę', 3000)
			TriggerServerEvent('esx_ambulancejob:giveflashlight')
			ESX.UI.Menu.CloseAll()
		end
		end, function(data, menu)
			menu.close()
		end)
end

AddEventHandler('ambulanceItem_pass', function(item_name)
	local Player = ESX.GetPlayerData()
	local org = Player.job.name
	local item_name_pass = item_name
	TriggerServerEvent('srp_logs:ambulanceItemLog',org,item_name_pass,1)
end)


function WarpPedInClosestVehicle(ped)
	local coords = GetEntityCoords(ped)

	local vehicle, distance = ESX.Game.GetClosestVehicle(coords)

	if distance ~= -1 and distance <= 5.0 then
		local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

		for i=maxSeats - 1, 0, -1 do
			if IsVehicleSeatFree(vehicle, i) then
				freeSeat = i
				break
			end
		end

		if freeSeat then
			TaskWarpPedIntoVehicle(ped, vehicle, freeSeat)
		end
	else
		--ESX.ShowNotification(_U('no_vehicles'))
		exports['mythic_notify']:DoCustomHudText('error', 'Brak pojazdów w pobliżu!', 3000)
	end
end

RegisterNetEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(healType, quiet)
	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)
		

	if healType == 'small' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
		SetEntityHealth(playerPed, newHealth)
		TriggerEvent(playerPed ,'mythic_hospital:client:RemoveBleed')
		TriggerEvent(playerPed ,'mythic_hospital:client:ResetLimbs')
	elseif healType == 'big' then
		SetEntityHealth(playerPed, maxHealth)
		TriggerEvent(playerPed ,'mythic_hospital:client:RemoveBleed')
		TriggerEvent(playerPed ,'mythic_hospital:client:ResetLimbs')
	end

	if not quiet then
		--ESX.ShowNotification(_U('healed'))
		exports['mythic_notify']:DoCustomHudText('inform', 'Zostałeś obandażowany!', 3000)
	end
end)


function AddVehicleKeys(vehicle)
	local localVehPlateTest = GetVehicleNumberPlateText(vehicle)
	if localVehPlateTest ~= nil then
		local localVehPlate = string.lower(localVehPlateTest)
		TriggerEvent('ls:newVehicle', localVehPlate, nil, nil)
	end
end