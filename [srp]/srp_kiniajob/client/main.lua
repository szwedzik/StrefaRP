UsedPlates = {'B0000000'}
PlatesChars = {1,2,3,4,5,6,7,8,9,0,'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','R','S','T','U','W','X','Y','Z'}

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

local HasAlreadyEnteredMarker, LastZone = false, nil
local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local CurrentlyTowedVehicle, Blips, NPCOnJob, NPCTargetTowable, NPCTargetTowableZone = nil, {}, false, nil, nil
local NPCHasSpawnedTowable, NPCLastCancel, NPCHasBeenNextToTowable, NPCTargetDeleterZone = false, GetGameTimer() - 5 * 60000, false, false
local isDead, isBusy = false, false

ESX = nil
local VehicleHoods = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

function SelectRandomTowable()
	local index = GetRandomIntInRange(1,  #Config.Towables)

	for k,v in pairs(Config.Zones) do
		if v.Pos.x == Config.Towables[index].x and v.Pos.y == Config.Towables[index].y and v.Pos.z == Config.Towables[index].z then
			return k
		end
	end
end

function StartNPCJob()
	NPCOnJob = true

	NPCTargetTowableZone = SelectRandomTowable()
	local zone       = Config.Zones[NPCTargetTowableZone]

	Blips['NPCTargetTowableZone'] = AddBlipForCoord(zone.Pos.x,  zone.Pos.y,  zone.Pos.z)
	SetBlipRoute(Blips['NPCTargetTowableZone'], true)

	ESX.ShowNotification(_U('drive_to_indicated'))
end

function StopNPCJob(cancel)
	if Blips['NPCTargetTowableZone'] then
		RemoveBlip(Blips['NPCTargetTowableZone'])
		Blips['NPCTargetTowableZone'] = nil
	end

	if Blips['NPCDelivery'] then
		RemoveBlip(Blips['NPCDelivery'])
		Blips['NPCDelivery'] = nil
	end

	Config.Zones.VehicleDelivery.Type = -1

	NPCOnJob                = false
	NPCTargetTowable        = nil
	NPCTargetTowableZone    = nil
	NPCHasSpawnedTowable    = false
	NPCHasBeenNextToTowable = false

	if cancel then
		ESX.ShowNotification(_U('mission_canceled'))
	else
		--TriggerServerEvent('srp_kiniajob:onNPCJobCompleted')
	end
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

function OpenkiniaActionsMenu()
	local elements = {
		{label = "Pojazdy", value = 'vehicle_list'},--
		{label = "Ubrania robocze", value = 'cloakroom'},--
		{label = "Ubranie cywilne", value = 'cloakroom2'},--
		{label = "Umieść przedmioty", value = 'put_stock'},--
		{label = "Wyciągnij przedmioty", value = 'get_stock'},--
		{label = "Pobierz narzędzia", value = 'take_tools'},--
		{label = "Oddaj narzędzia", value = 'return_tools'},--
	}

	if Config.EnablePlayerManagement and ESX.PlayerData.job and (ESX.PlayerData.job.grade_name == 'chief' or ESX.PlayerData.job.grade_name == 'boss') then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'kinia_actions', {
		title    = _U('mechanic'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'vehicle_list' then
			if Config.EnableSocietyOwnedVehicles then

				local elements = {}

				ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(vehicles)
					for i=1, #vehicles, 1 do
						table.insert(elements, {
							label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']',
							value = vehicles[i]
						})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner', {
						title    = _U('service_vehicle'),
						align    = 'top-left',
						elements = elements
					}, function(data, menu)
						menu.close()
						local vehicleProps = data.current.value

						ESX.Game.SpawnVehicle(vehicleProps.model, Config.Zones.VehicleSpawnPoint.Pos, 70.0, function(vehicle)
							ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
							local playerPed = PlayerPedId()
							TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
						end)

						TriggerServerEvent('esx_society:removeVehicleFromGarage', 'kinia', vehicleProps)
					end, function(data, menu)
						menu.close()
					end)
				end, 'kinia')

			else

				local elements = {
					{label = "Pojazd służbowy", value = '4b'},
					{label = "Holownik", value = 'hdwrecker'},
					{label = "Widlak", value = 'forklift'},
				}

				--[[
				if Config.EnablePlayerManagement and ESX.PlayerData.job and (ESX.PlayerData.job.grade_name == 'boss' or ESX.PlayerData.job.grade_name == 'chief' or ESX.PlayerData.job.grade_name == 'experimente') then
					table.insert(elements, {label = 'Pojazd Usługowy', value = 'utillitruck3'})
				end
				]]

				ESX.UI.Menu.CloseAll()

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_vehicle', {
					title    = _U('service_vehicle'),
					align    = 'top-left',
					elements = elements
				}, function(data, menu)
					if Config.MaxInService == -1 then
						ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 250.17, function(vehicle)
							local playerPed = PlayerPedId()
							TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
							plate = VehiclePlaqueMaker('Carzone')
							SetVehicleNumberPlateText(vehicle, plate)
							AddVehicleKeys(vehicle)
						end)
					else
						ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
							if canTakeService then
								ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 250.17, function(vehicle)
									local playerPed = PlayerPedId()
									TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
									plate = VehiclePlaqueMaker('Carzone')
									SetVehicleNumberPlateText(vehicle, plate)
									AddVehicleKeys(vehicle)
								end)
							else
								ESX.ShowNotification(_U('service_full') .. inServiceCount .. '/' .. maxInService)
							end
						end, 'kinia')
					end

					menu.close()
				end, function(data, menu)
					menu.close()
					OpenkiniaActionsMenu()
				end)

			end
		elseif data.current.value == 'cloakroom' then
			menu.close()
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
				else
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
				end
			end)
		elseif data.current.value == 'cloakroom2' then
			menu.close()
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		elseif data.current.value == 'put_stock' then
			OpenPutStocksMenu()
		elseif data.current.value == 'get_stock' then
			OpenGetStocksMenu()
		elseif data.current.value == 'take_tools' then
			OpenTakeToolsMenu()
		elseif data.current.value == 'return_tools' then
			OpenReturnToolsMenu()
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'kinia', function(data, menu)
				menu.close()
			end)
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'kinia_actions_menu'
		CurrentActionMsg  = _U('open_actions')
		CurrentActionData = {}
	end)
end

---SKLEP Motoryzacyjny

function OpenkiniaActionsMenuShop(source)
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'kinia_actions_menu_shop',
		{
			title    = 'Wybierz Części',
			elements = {
                {label = 'Zestaw naprawczy', value = 'naprawka'}
			}
		},
        function(data, menu)
            if data.current.value == 'naprawka' then
                TriggerServerEvent('srp_kiniajob:buyrepairkitcheck')
                --ESX.UI.Menu.CloseAll()
            end	
            --menu.close()
		end,
		function(data, menu)
			menu.close()
		end)
end


--[[
function OpenMechanicHarvestMenu()
	if Config.EnablePlayerManagement and ESX.PlayerData.job and ESX.PlayerData.job.grade_name ~= 'recrue' then
		local elements = {
			{label = _U('gas_can'), value = 'gaz_bottle'},
			{label = _U('repair_tools'), value = 'fix_tool'},
			{label = _U('body_work_tools'), value = 'caro_tool'}
		}

		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic_harvest', {
			title    = _U('harvest'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			menu.close()

			if data.current.value == 'gaz_bottle' then
				TriggerServerEvent('srp_kiniajob:startHarvest')
			elseif data.current.value == 'fix_tool' then
				TriggerServerEvent('srp_kiniajob:startHarvest2')
			elseif data.current.value == 'caro_tool' then
				TriggerServerEvent('srp_kiniajob:startHarvest3')
			end
		end, function(data, menu)
			menu.close()
			CurrentAction     = 'mechanic_harvest_menu'
			CurrentActionMsg  = _U('harvest_menu')
			CurrentActionData = {}
		end)
	else
		ESX.ShowNotification(_U('not_experienced_enough'))
	end
end

function OpenMechanicCraftMenu()
	if Config.EnablePlayerManagement and ESX.PlayerData.job and ESX.PlayerData.job.grade_name ~= 'recrue' then
		local elements = {
			{label = _U('blowtorch'),  value = 'blow_pipe'},
			{label = _U('repair_kit'), value = 'fix_kit'},
			{label = _U('body_kit'),   value = 'caro_kit'}
		}

		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic_craft', {
			title    = _U('craft'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			menu.close()

			if data.current.value == 'blow_pipe' then
				TriggerServerEvent('srp_kiniajob:startCraft')
			elseif data.current.value == 'fix_kit' then
				TriggerServerEvent('srp_kiniajob:startCraft2')
			elseif data.current.value == 'caro_kit' then
				TriggerServerEvent('srp_kiniajob:startCraft3')
			end
		end, function(data, menu)
			menu.close()

			CurrentAction     = 'mechanic_craft_menu'
			CurrentActionMsg  = _U('craft_menu')
			CurrentActionData = {}
		end)
	else
		ESX.ShowNotification(_U('not_experienced_enough'))
	end
end
]]

function OpenMobilekiniaActionsMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_kinia_actions', {
		title    = _U('mechanic'),
		align    = 'top-left',
		elements = {
			{label = "Otwórz Zamek",     value = 'hijack_vehicle'},--
			{label = "Napraw cały pojazd",       value = 'fix_vehicle'},--
			{label = "Napraw silnik pojazdu",       value = 'fix_vehicle_engine'},--
			{label = "Wyczyść pojazd",      value = 'clean_vehicle'},--
			{label = "Otwórz/Zamknij maskę pojazdu",      value = 'open_hood_vehicle'},--
			--{label = "Sciągnij/Wciągnij pojazd na lawete",      value = 'put_on_flatbed'}--
	}}, function(data, menu)
		if isBusy then return end

		if data.current.value == 'hijack_vehicle' then
			local playerPed = PlayerPedId()
			local vehicle   = ESX.Game.GetVehicleInDirection()
			local coords    = GetEntityCoords(playerPed)

			if IsPedSittingInAnyVehicle(playerPed) then
				exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz otworzyć pojazdu siedząc w środku', 3000)
				return
			end

			if DoesEntityExist(vehicle) then
				isBusy = true
				TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
				Citizen.CreateThread(function()
					exports['mythic_progbar']:Progress({
						name = "firstaid_action",
						duration = 10000,
						label = "Otwieranie pojazdu...",
						useWhileDead = false,
						canCancel = false,
						controlDisables = {
							disableMovement = true,
							disableCarMovement = true,
							disableMouse = false,
							disableCombat = true,
						}
						})
					Citizen.Wait(10000)

					SetVehicleDoorsLocked(vehicle, 1)
					SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					ClearPedTasksImmediately(playerPed)

					exports['mythic_notify']:DoCustomHudText('inform', 'Pojazd został otworzony', 3000)
					isBusy = false
				end)
			else
				exports['mythic_notify']:DoCustomHudText('inform', 'Brak pojazdów w pobliżu', 3000)
			end

		elseif data.current.value == 'fix_vehicle' then
			local playerPed = PlayerPedId()
			local vehicle   = ESX.Game.GetVehicleInDirection()
			local coords    = GetEntityCoords(playerPed)

			if IsPedSittingInAnyVehicle(playerPed) then
				exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz naprawić pojazdu siedząc w środku', 3000)
				return
			end

			if DoesEntityExist(vehicle) then
				isBusy = true
				TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
				Citizen.CreateThread(function()
					exports['mythic_progbar']:Progress({
						name = "firstaid_action",
						duration = 20000,
						label = "Naprawianie pojazdu...",
						useWhileDead = false,
						canCancel = false,
						controlDisables = {
							disableMovement = true,
							disableCarMovement = true,
							disableMouse = false,
							disableCombat = true,
						}
						})
					Citizen.Wait(20000)

					SetVehicleFixed(vehicle)
					SetVehicleDeformationFixed(vehicle)
					SetVehicleUndriveable(vehicle, false)
					SetVehicleEngineOn(vehicle, true, true)
					ClearPedTasksImmediately(playerPed)

					exports['mythic_notify']:DoCustomHudText('inform', 'Pojazd Naprawiony!', 3000)
					isBusy = false
				end)
			else
				exports['mythic_notify']:DoCustomHudText('inform', 'Brak pojazdów w pobliżu!', 3000)
			end

		elseif data.current.value == 'fix_vehicle_engine' then
			local playerPed = PlayerPedId()
			local vehicle   = ESX.Game.GetVehicleInDirection()
			local coords    = GetEntityCoords(playerPed)

			if IsPedSittingInAnyVehicle(playerPed) then
				exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz naprawić silnika siedząc w środku', 3000)
				return
			end

			if DoesEntityExist(vehicle) then
				isBusy = true
				TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
				Citizen.CreateThread(function()
					exports['mythic_progbar']:Progress({
						name = "firstaid_action",
						duration = 20000,
						label = "Naprawianie silnika...",
						useWhileDead = false,
						canCancel = false,
						controlDisables = {
							disableMovement = true,
							disableCarMovement = true,
							disableMouse = false,
							disableCombat = true,
						}
						})
					Citizen.Wait(20000)
					
					SetVehicleEngineHealth(vehicle, 850.0)
					TriggerEvent("EngineToggle:FixEngine", vehicle)
					SetVehicleUndriveable(vehicle, false)
					Citizen.Wait(1500)
					ClearPedTasksImmediately(GetPlayerPed(-1))
					exports['mythic_notify']:DoCustomHudText('inform', 'Silnik naprawiony', 3000)
					isBusy = false
				end)
			else
				exports['mythic_notify']:DoCustomHudText('inform', 'Brak pojazdów w pobliżu!', 3000)
			end

		elseif data.current.value == 'clean_vehicle' then
			local playerPed = PlayerPedId()
			local vehicle   = ESX.Game.GetVehicleInDirection()
			local coords    = GetEntityCoords(playerPed)

			if IsPedSittingInAnyVehicle(playerPed) then
				exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz wyczyścić pojazdu siedząc w środku', 3000)
				return
			end

			if DoesEntityExist(vehicle) then
				isBusy = true
				TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
				Citizen.CreateThread(function()
					exports['mythic_progbar']:Progress({
						name = "firstaid_action",
						duration = 10000,
						label = "Czyszczenie pojazdu...",
						useWhileDead = false,
						canCancel = false,
						controlDisables = {
							disableMovement = true,
							disableCarMovement = true,
							disableMouse = false,
							disableCombat = true,
						}
						})
					Citizen.Wait(10000)

					SetVehicleDirtLevel(vehicle, 0)
					ClearPedTasksImmediately(playerPed)
					exports['mythic_notify']:DoCustomHudText('inform', 'Pojazd wyczyszczony', 3000)
					isBusy = false
				end)
			else
				exports['mythic_notify']:DoCustomHudText('inform', 'Brak pojazdów w pobliżu!', 3000)
			end

		elseif data.current.value == 'put_on_flatbed' then
			TriggerEvent("flatbed:tow")
		
		elseif data.current.value == 'open_hood_vehicle' then
			local playerPed = GetPlayerPed(-1)
			local coords    = GetEntityCoords(playerPed)

			if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
				local vehicle = nil
				if IsPedInAnyVehicle(playerPed, false) then
					vehicle = GetVehiclePedIsIn(playerPed, false)
				else
					vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
				end
				if(VehicleHoods[vehicle] == nil) then
					SetVehicleDoorOpen(vehicle, 4, 0, 0)
					VehicleHoods[vehicle] = 1
					TriggerServerEvent("srp_kiniajob:setVehicleHoodState", vehicle, 1)
					Citizen.Wait(750)
				else
					if(VehicleHoods[vehicle] == 1) then
						SetVehicleDoorShut(vehicle, 4, 0)
						VehicleHoods[vehicle] = 0
						TriggerServerEvent("srp_kiniajob:setVehicleHoodState", vehicle, 0)
						Citizen.Wait(750)
					elseif(VehicleHoods[vehicle] == 0) then
						SetVehicleDoorOpen(vehicle, 4, 0, 0)
						VehicleHoods[vehicle] = 1
						TriggerServerEvent("srp_kiniajob:setVehicleHoodState", vehicle, 1)
						Citizen.Wait(750)
					end
				end
			end

		elseif data.current.value == 'del_vehicle' then
			local playerPed = PlayerPedId()

			if IsPedSittingInAnyVehicle(playerPed) then
				local vehicle = GetVehiclePedIsIn(playerPed, false)

				if GetPedInVehicleSeat(vehicle, -1) == playerPed then
					ESX.ShowNotification(_U('vehicle_impounded'))
					ESX.Game.DeleteVehicle(vehicle)
				else
					ESX.ShowNotification(_U('must_seat_driver'))
				end
			else
				local vehicle = ESX.Game.GetVehicleInDirection()

				if DoesEntityExist(vehicle) then
					ESX.ShowNotification(_U('vehicle_impounded'))
					ESX.Game.DeleteVehicle(vehicle)
				else
					ESX.ShowNotification(_U('must_near'))
				end
			end
		elseif data.current.value == 'object_spawner' then
			local playerPed = PlayerPedId()

			if IsPedSittingInAnyVehicle(playerPed) then
				ESX.ShowNotification(_U('inside_vehicle'))
				return
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_kinia_actions_spawn', {
				title    = _U('objects'),
				align    = 'top-left',
				elements = {
					{label = _U('roadcone'), value = 'prop_roadcone02a'},
					{label = _U('toolbox'),  value = 'prop_toolchest_01'}
			}}, function(data2, menu2)
				local model   = data2.current.value
				local coords  = GetEntityCoords(playerPed)
				local forward = GetEntityForwardVector(playerPed)
				local x, y, z = table.unpack(coords + forward * 1.0)

				if model == 'prop_roadcone02a' then
					z = z - 2.0
				elseif model == 'prop_toolchest_01' then
					z = z - 2.0
				end

				ESX.Game.SpawnObject(model, {x = x, y = y, z = z}, function(obj)
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

function OpenGetStocksMenu()
	ESX.TriggerServerCallback('srp_kiniajob:getStockItems', function(items)
		local elements = {}

		for i=1, #items, 1 do
			table.insert(elements, {
				label = 'x' .. items[i].count .. ' ' .. items[i].label,
				value = items[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = _U('mechanic_stock'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					exports['mythic_notify']:DoCustomHudText('error', 'Nie poprawna ilość', 3000)
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('srp_kiniajob:getStockItem', itemName, count)

					Citizen.Wait(1000)
					OpenGetStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenPutStocksMenu()
	ESX.TriggerServerCallback('srp_kiniajob:getPlayerInventory', function(inventory)
		local elements = {}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type  = 'item_standard',
					value = item.name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = _U('inventory'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					exports['mythic_notify']:DoCustomHudText('error', 'Nie poprawna ilość', 3000)
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('srp_kiniajob:putStockItems', itemName, count)

					Citizen.Wait(1000)
					OpenPutStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function  OpenTakeToolsMenu()
	local elements = {
	{ label = 'Woda', value = 'water', type = 'item' },
    { label = 'Radio', value = 'radio', type = 'item' },    
	{ label = 'Młotek', value = 'WEAPON_HAMMER', type = 'weapon' },
	{ label = 'Klucz Fracuski', value = 'WEAPON_WRENCH', type = 'weapon' },
	{ label = 'Łom', value = 'WEAPON_CROWBAR', type = 'weapon' },
	{ label = 'Latarka', value = 'WEAPON_FLASHLIGHT', type = 'weapon' }
	}
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'take_tools_menu',
	{
		title    = "Pobierz narzędzia",
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
	menu.close()
    if data.current.value == 'water' then
        TriggerServerEvent('srp_kiniajob:get_item', data.current.label, data.current.value, 10)
	elseif data.current.type == 'item' then
      TriggerServerEvent('srp_kiniajob:get_item', data.current.label, data.current.value, 1)
    elseif data.current.type == 'weapon' then
      TriggerServerEvent('srp_kiniajob:giveWeapon', data.current.value)
    end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenReturnToolsMenu()
  ESX.TriggerServerCallback('esx_policejob:getPlayerInventory', function(inventory)
		local elements = {}
		local playerPed  = PlayerPedId()
		local weaponList = ESX.GetWeaponList()
	
		for i=1, #weaponList, 1 do
			local weaponHash = GetHashKey(weaponList[i].name)
			local weapon_for = weaponList[i]
			if HasPedGotWeapon(playerPed, weaponHash, false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
				table.insert(elements, {
					label = weapon_for.label,
					type = 'item_weapon',
					value = weapon_for.name,
					ammo = weapon_for.ammo
				})
			end
		end

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]
			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type = 'item_standard',
					value = item.name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu',
		{
			title    = "Zwracanie narzędzi",
			align    = "center",
			elements = elements
		}, 
		function(data, menu)
		local itemType = data.current.type
			if itemType == "item_standard" then
			
				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
					title = "ilość"
				}, function(data2, menu2)

					local count = tonumber(data2.value)

					if count == nil then
						exports['mythic_notify']:DoCustomHudText('error', 'Nie poprawna ilość', 3000)
					else
						menu2.close()
						menu.close()
						TriggerServerEvent('esx_policejob:putStockItems', data.current.value, count)

						Citizen.Wait(300)
						OpenPutStocksMenu()
					end
				end, function(data2, menu2)
					menu2.close()
				end)
			elseif itemType == "item_weapon" then
				local weaponHash = data.current.value
        menu.close()
        RemoveWeaponFromPed(GetPlayerPed(-1),GetHashKey(string.upper(data.current.value)))
        
      end 
    end)
  end)
end

--[[
RegisterNetEvent('srp_kiniajob:onHijack')
AddEventHandler('srp_kiniajob:onHijack', function()
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
    	local vehicle = nil
		if IsPedInAnyVehicle(playerPed, false) then
      		vehicle = GetVehiclePedIsIn(playerPed, false)
    	else
      		vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end
    	local crochete = math.random(100)
    	local alarm    = math.random(100)
    		if DoesEntityExist(vehicle) then
    		if alarm <= 33 then
        		SetVehicleAlarm(vehicle, true)
        		StartVehicleAlarm(vehicle)
	 			if PlayerData.job.name ~= 'kinia' and PlayerData.job.name  ~= 'police' and PlayerData.job.name  ~= 'sheriff' and PlayerData.job.name  ~= 'statepolice' then
            		TriggerEvent("outlaw:lockpick")
        		end
      		end
      		TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
      		Citizen.CreateThread(function()
				exports['mythic_progbar']:Progress({
					name = "firstaid_action",
					duration = 30000,
					label = "Otwieranie zamka...",
					useWhileDead = false,
					canCancel = false,
					controlDisables = {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					}
					})
        		Citizen.Wait(30000)
				local jobChance = 30
				if PlayerData.job.name == 'kinia' or PlayerData.job.name == 'police' and PlayerData.job.name  ~= 'sheriff' and PlayerData.job.name  ~= 'statepolice' then
					jobChance = 100
				end
        		if crochete <= jobChance then
          			SetVehicleDoorsLocked(vehicle, 1)
          			SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					  ClearPedTasksImmediately(playerPed)
					  exports['mythic_notify']:DoCustomHudText('inform', 'Pojazd został otworzony', 3000)
				else
					exports['mythic_notify']:DoCustomHudText('error', 'Otwieranie pojazdu zakończone niepowodzeniem', 3000)
          			ClearPedTasksImmediately(playerPed)
        		end
      		end)
    	end
	end
end)

RegisterNetEvent('srp_kiniajob:onCarokit')
AddEventHandler('srp_kiniajob:onCarokit', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_HAMMERING', 0, true)
			Citizen.CreateThread(function()
				Citizen.Wait(10000)
				SetVehicleFixed(vehicle)
				SetVehicleDeformationFixed(vehicle)
				ClearPedTasksImmediately(playerPed)
				ESX.ShowNotification(_U('body_repaired'))
			end)
		end
	end
end)

RegisterNetEvent('srp_kiniajob:onFixkit')
AddEventHandler('srp_kiniajob:onFixkit', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
			exports['mythic_notify']:DoCustomHudText('error', 'Musisz wyjść z pojazdu aby naprawić silnik!', 3000)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
			Citizen.CreateThread(function()
				exports['mythic_notify']:DoCustomHudText('inform', 'Użyłeś zestawu naprawczego', 3000)
				print("Zaczynam usuwanie")
				TriggerServerEvent("srp_kiniajob:removeFixTool")
				print("Powinno usunąć")
				TriggerEvent("esx_anims:repair", true)
				exports['mythic_progbar']:Progress({
					name = "firstaid_action",
					duration = 20000,
					label = "Naprawianie silnika...",
					useWhileDead = false,
					canCancel = false,
					controlDisables = {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					}
					})
				Citizen.Wait(20000)
				SetVehicleEngineHealth(vehicle, 850.0)
				TriggerServerEvent("EngineToggle:FixEngines", vehicle)
				SetVehicleUndriveable(vehicle, false)
				TriggerEvent("esx_anims:repair", false)
				ClearPedTasksImmediately(playerPed)
				exports['mythic_notify']:DoCustomHudText('inform', 'Silnik naprawiony', 3000)
			end)
		end
	end
end)

RegisterNetEvent('srp_kiniajob:onPolFixkit')
AddEventHandler('srp_kiniajob:onPolFixkit', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
			exports['mythic_notify']:DoCustomHudText('error', 'Musisz wyjść z pojazdu aby naprawić silnik!', 3000)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
			Citizen.CreateThread(function()
				exports['mythic_notify']:DoCustomHudText('inform', 'Użyłeś zestawu naprawczego', 3000)
				print("Zaczynam usuwanie")
				TriggerServerEvent("srp_kiniajob:removePolFixTool")
				print("Powinno usunąć")
				TriggerEvent("esx_anims:repair", true)
				exports['mythic_progbar']:Progress({
					name = "firstaid_action",
					duration = 20000,
					label = "Naprawianie silnika...",
					useWhileDead = false,
					canCancel = false,
					controlDisables = {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					}
					})
				Citizen.Wait(20000)
				SetVehicleEngineHealth(vehicle, 850.0)
				TriggerServerEvent("EngineToggle:FixEngines", vehicle)
				SetVehicleUndriveable(vehicle, false)
				TriggerEvent("esx_anims:repair", false)
				ClearPedTasksImmediately(playerPed)
				exports['mythic_notify']:DoCustomHudText('inform', 'Silnik naprawiony', 3000)
			end)
		end
	end
end)
]]

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

AddEventHandler('srp_kiniajob:hasEnteredMarker', function(zone)
	if zone == 'NPCJobTargetTowable' then

	elseif zone =='VehicleDelivery' then
		NPCTargetDeleterZone = true
	elseif zone == 'kiniaActions' then
		CurrentAction     = 'kinia_actions_menu'
		CurrentActionMsg  = _U('open_actions')
		CurrentActionData = {}
	elseif zone == 'kiniaActionsShop' then
		CurrentAction     = 'kinia_actions_menu_shop'
		CurrentActionMsg  = _U('open_shop')
		CurrentActionData = {}
	elseif zone == 'Garage' then
		CurrentAction     = 'kinia_harvest_menu'
		CurrentActionMsg  = _U('harvest_menu')
		CurrentActionData = {}
	elseif zone == 'Craft' then
		CurrentAction     = 'kinia_craft_menu'
		CurrentActionMsg  = _U('craft_menu')
		CurrentActionData = {}
	elseif zone == 'VehicleDeleter' then
		local playerPed = PlayerPedId()

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed,  false)

			CurrentAction     = 'delete_vehicle'
			CurrentActionMsg  = _U('veh_stored')
			CurrentActionData = {vehicle = vehicle}
		end
	end
end)

AddEventHandler('srp_kiniajob:hasExitedMarker', function(zone)
	if zone =='VehicleDelivery' then
		NPCTargetDeleterZone = false
	elseif zone == 'Craft' then
		TriggerServerEvent('srp_kiniajob:stopCraft')
		TriggerServerEvent('srp_kiniajob:stopCraft2')
		TriggerServerEvent('srp_kiniajob:stopCraft3')
	elseif zone == 'Garage' then
		TriggerServerEvent('srp_kiniajob:stopHarvest')
		TriggerServerEvent('srp_kiniajob:stopHarvest2')
		TriggerServerEvent('srp_kiniajob:stopHarvest3')
	end

	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

AddEventHandler('srp_kiniajob:hasEnteredEntityZone', function(entity)
	local playerPed = PlayerPedId()

	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'kiniajob' and not IsPedInAnyVehicle(playerPed, false) then
		CurrentAction     = 'remove_entity'
		CurrentActionMsg  = _U('press_remove_obj')
		CurrentActionData = {entity = entity}
	end
end)

AddEventHandler('srp_kiniajob:hasExitedEntityZone', function(entity)
	if CurrentAction == 'remove_entity' then
		CurrentAction = nil
	end
end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = _U('mechanic'),
		number     = 'kinia',
		base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEwAACxMBAJqcGAAAA4BJREFUWIXtll9oU3cUx7/nJA02aSSlFouWMnXVB0ejU3wcRteHjv1puoc9rA978cUi2IqgRYWIZkMwrahUGfgkFMEZUdg6C+u21z1o3fbgqigVi7NzUtNcmsac40Npltz7S3rvUHzxQODec87vfD+/e0/O/QFv7Q0beV3QeXqmgV74/7H7fZJvuLwv8q/Xeux1gUrNBpN/nmtavdaqDqBK8VT2RDyV2VHmF1lvLERSBtCVynzYmcp+A9WqT9kcVKX4gHUehF0CEVY+1jYTTIwvt7YSIQnCTvsSUYz6gX5uDt7MP7KOKuQAgxmqQ+neUA+I1B1AiXi5X6ZAvKrabirmVYFwAMRT2RMg7F9SyKspvk73hfrtbkMPyIhA5FVqi0iBiEZMMQdAui/8E4GPv0oAJkpc6Q3+6goAAGpWBxNQmTLFmgL3jSJNgQdGv4pMts2EKm7ICJB/aG0xNdz74VEk13UYCx1/twPR8JjDT8wttyLZtkoAxSb8ZDCz0gdfKxWkFURf2v9qTYH7SK7rQIDn0P3nA0ehixvfwZwE0X9vBE/mW8piohhl1WH18UQBhYnre8N/L8b8xQvlx4ACbB4NnzaeRYDnKm0EALCMLXy84hwuTCXL/ExoB1E7qcK/8NCLIq5HcTT0i6u8TYbXUM1cAyyveVq8Xls7XhYrvY/4n3gC8C+dsmAzL1YUiyfWxvHzsy/w/dNd+KjhW2yvv/RfXr7x9QDcmo1he2RBiCCI1Q8jVj9szPNixVfgz+UiIGyDSrcoRu2J16d3I6e1VYvNSQjXpnucAcEPUOkGYZs/l4uUhowt/3kqu1UIv9n90fAY9jT3YBlbRvFTD4fw++wHjhiTRL/bG75t0jI2ITcHb5om4Xgmhv57xpGOg3d/NIqryOR7z+r+MC6qBJB/ZB2t9Om1D5lFm843G/3E3HI7Yh1xDRAfzLQr5EClBf/HBHK462TG2J0OABXeyWDPZ8VqxmBWYscpyghwtTd4EKpDTjCZdCNmzFM9k+4LHXIFACJN94Z6FiFEpKDQw9HndWsEuhnADVMhAUaYJBp9XrcGQKJ4qFE9k+6r2+MG3k5N8VQ22TVglbX2ZwOzX2VvNKr91zmY6S7N6zqZicVT2WNLyVSehESaBhxnOALfMeYX+K/S2yv7wmMAlvwyuR7FxQUyf0fgc/jztfkJr7XeGgC8BJJgWNV8ImT+AAAAAElFTkSuQmCC'
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

-- Pop NPC mission vehicle when inside area
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if NPCTargetTowableZone and not NPCHasSpawnedTowable then
			local coords = GetEntityCoords(PlayerPedId())
			local zone   = Config.Zones[NPCTargetTowableZone]

			if GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < Config.NPCSpawnDistance then
				local model = Config.Vehicles[GetRandomIntInRange(1,  #Config.Vehicles)]

				ESX.Game.SpawnVehicle(model, zone.Pos, 0, function(vehicle)
					NPCTargetTowable = vehicle
				end)

				NPCHasSpawnedTowable = true
			end
		end

		if NPCTargetTowableZone and NPCHasSpawnedTowable and not NPCHasBeenNextToTowable then
			local coords = GetEntityCoords(PlayerPedId())
			local zone   = Config.Zones[NPCTargetTowableZone]

			if GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < Config.NPCNextToDistance then
				ESX.ShowNotification(_U('please_tow'))
				NPCHasBeenNextToTowable = true
			end
		end
	end
end)

-- Create Blips
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.kiniaActions.Pos.x, Config.Zones.kiniaActions.Pos.y, Config.Zones.kiniaActions.Pos.z)
	SetBlipSprite (blip, 446)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.7)
	SetBlipColour (blip, 3)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Carzone Garage")
	EndTextCommandSetBlipName(blip)

	local PlayerData = ESX.GetPlayerData()
	if PlayerData.job and PlayerData.job.name == 'kiniajob' then
	local blipshop = AddBlipForCoord(Config.Zones.kiniaActionsShop.Pos.x, Config.Zones.kiniaActionsShop.Pos.y, Config.Zones.kiniaActionsShop.Pos.z)
	SetBlipSprite (blipshop, 225)
	SetBlipDisplay(blipshop, 4)
	SetBlipScale  (blipshop, 0.7)
	SetBlipColour (blipshop, 7)
	SetBlipAsShortRange(blipshop, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Hurtownia Motoryzacyjna")
	EndTextCommandSetBlipName(blipshop)
	end
end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'kiniajob' then
			local coords, letSleep = GetEntityCoords(PlayerPedId()), true

			for k,v in pairs(Config.Zones) do
				if v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end
			end

			if letSleep then
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'kiniajob' then

			local coords      = GetEntityCoords(PlayerPedId())
			local isInMarker  = false
			local currentZone = nil

			for k,v in pairs(Config.Zones) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker  = true
					currentZone = k
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone
				TriggerEvent('srp_kiniajob:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('srp_kiniajob:hasExitedMarker', LastZone)
			end

		end
	end
end)

Citizen.CreateThread(function()
	local trackedEntities = {
		'prop_roadcone02a',
		'prop_toolchest_01'
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
				TriggerEvent('srp_kiniajob:hasEnteredEntityZone', closestEntity)
				LastEntity = closestEntity
			end
		else
			if LastEntity then
				TriggerEvent('srp_kiniajob:hasExitedEntityZone', LastEntity)
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

			if IsControlJustReleased(0, 38) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'kiniajob' then

				if CurrentAction == 'kinia_actions_menu' then
					OpenkiniaActionsMenu()
				elseif CurrentAction == 'kinia_actions_menu_shop' then
					OpenkiniaActionsMenuShop()
				elseif CurrentAction == 'kinia_harvest_menu' then
					OpenkiniaHarvestMenu()
				elseif CurrentAction == 'kinia_craft_menu' then
					OpenkiniaCraftMenu()
				elseif CurrentAction == 'delete_vehicle' then

					if Config.EnableSocietyOwnedVehicles then

						local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
						TriggerServerEvent('esx_society:putVehicleInGarage', 'kinia', vehicleProps)

					else

						if
							GetEntityModel(vehicle) == GetHashKey('flatbed')   or
							GetEntityModel(vehicle) == GetHashKey('towtruck2') or
							GetEntityModel(vehicle) == GetHashKey('slamvan3')
						then
							TriggerServerEvent('esx_service:disableService', 'kinia')
						end

					end

					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)

				elseif CurrentAction == 'remove_entity' then
					DeleteEntity(CurrentActionData.entity)
				end

				CurrentAction = nil
			end
		end

		if IsControlJustReleased(0, Keys['F6']) and not isDead and ESX.PlayerData.job and ESX.PlayerData.job.name == 'kiniajob' then
			OpenMobilekiniaActionsMenu()
		end

		--[[
		if IsControlJustReleased(0, 178) and not isDead and ESX.PlayerData.job and ESX.PlayerData.job.name == 'kinia' then
			if NPCOnJob then
				if GetGameTimer() - NPCLastCancel > 5 * 60000 then
					StopNPCJob(true)
					NPCLastCancel = GetGameTimer()
				else
					ESX.ShowNotification(_U('wait_five'))
				end
			else
				local playerPed = PlayerPedId()

				if IsPedInAnyVehicle(playerPed, false) and IsVehicleModel(GetVehiclePedIsIn(playerPed, false), GetHashKey('flatbed')) then
					StartNPCJob()
				else
					ESX.ShowNotification(_U('must_in_flatbed'))
				end
			end
		end
]]
	end
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)

--[[
RegisterCommand("odholuj",function(source, args)
    if  ESX.PlayerData.job ~= nil and (ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'kinia' or ESX.PlayerData.job.name == 'sheriff' or ESX.PlayerData.job.name == 'statepolice') then
        local coords    = GetEntityCoords(PlayerPedId())
        local vehicle   = GetClosestVehicle(coords.x,  coords.y,  coords.z,  3.0,  0,  71)
		local vehicle2 = GetVehiclePedIsIn(PlayerPedId(), false)
        if vehicle ~= nil and not IsPedInAnyVehicle(PlayerPedId()) then 
			DeleteEntity(vehicle)
		end
		DeleteEntity(vehicle2)				
    end
end, false)
]]