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

local PlayerData              = {}
local GUI                     = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local OnJob                   = false
local TargetCoords            = nil
local CurrentlyTowedVehicle   = nil
local Blips                   = {}
local NPCOnJob                = false
local NPCTargetTowable        = nil
local NPCTargetTowableZone    = nil
local NPCHasSpawnedTowable    = false
local NPCLastCancel           = GetGameTimer() - 5 * 60000
local NPCHasBeenNextToTowable = false
local NPCTargetDeleterZone    = false
local IsDead                  = false

local OnDuty				  = false

local VehicleHoods = {}

ESX                           = nil
GUI.Time                      = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
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

  if Blips['NPCTargetTowableZone'] ~= nil then
    RemoveBlip(Blips['NPCTargetTowableZone'])
    Blips['NPCTargetTowableZone'] = nil
  end

  if Blips['NPCDelivery'] ~= nil then
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
    TriggerServerEvent('esx_zwierzakojob:onNPCJobCompleted')
  end

end

function OpenZwierzakoActionsMenu()

  local elements = {
    {label = "Pojazdy", value = 'vehicle_list'},
    {label = "Ubrania robocze", value = 'cloakroom'},
    {label = "Ubranie cywilne", value = 'cloakroom2'},
    {label = "Umieść przedmioty", value = 'put_stock'},
    {label = "Wyciągnij przedmioty", value = 'get_stock'},
    {label = "Pobierz narzędzia", value = 'take_tools'},
    {label = "Oddaj narzędzia", value = 'return_tools'},
  }
  
  --table.insert(elements, {label = "Wyciągnij przedmioty", value = 'get_stock'})
  
  if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.grade_name == 'boss' or PlayerData.job ~= nil and PlayerData.job.grade_name == 'chief' then
    table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
  end

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'zwierzako_actions',
    {
      title    = _U('mechanic'),
      align    = 'bottom-right',
      elements = elements
    },
    function(data, menu)
      if data.current.value == 'vehicle_list' then

        if Config.EnableSocietyOwnedVehicles then

            local elements = {}

            ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(vehicles)

              for i=1, #vehicles, 1 do
                table.insert(elements, {label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']', value = vehicles[i]})
              end

              ESX.UI.Menu.Open(
                'default', GetCurrentResourceName(), 'vehicle_spawner',
                {
                  title    = _U('service_vehicle'),
                  align    = 'bottom-right',
                  elements = elements,
                },
                function(data, menu)

                  menu.close()

                  local vehicleProps = data.current.value

                  ESX.Game.SpawnVehicle(vehicleProps.model, Config.Zones.VehicleSpawnPoint.Pos, 250.17, function(vehicle)
                    ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
					          SetEntityHeading(vehicle, 250.17);
                    local playerPed = GetPlayerPed(-1)
                    TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
                  end)

                  TriggerServerEvent('esx_society:removeVehicleFromGarage', 'zwierzako', vehicleProps)

                end,
                function(data, menu)
                  menu.close()
                end
              )

            end, 'zwierzako')

          else

            local elements = {
              {label = "Laweta", value = 'flatbed'},
              {label = "Laweta K19", value = 'flatbed3'},
              {label = "Samochód służbowy", value = 'burrito2'},
              {label = "Widlak", value = 'forklift'},
            }
			
			if PlayerData.job ~= nil and (PlayerData.job.grade_name == 'boss' or PlayerData.job.grade_name == 'chief' or PlayerData.job.grade_name == 'experimente' or PlayerData.job.grade_name == 'novice') then
              table.insert(elements, {label = 'Pojazd Usługowy', value = 'utillitruck3'})
            end

            ESX.UI.Menu.CloseAll()

            ESX.UI.Menu.Open(
              'default', GetCurrentResourceName(), 'spawn_vehicle',
              {
                title    = _U('service_vehicle'),
                align    = 'bottom-right',
                elements = elements
              },
              function(data, menu)
                for i=1, #elements, 1 do
                  if Config.MaxInService == -1 then
                    ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 250.17, function(vehicle)
                      local playerPed = GetPlayerPed(-1)
                      TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
					  SetVehicleNumberPlateText(vehicle, "JANUSHCS")
                    end)
                    break
                  else
                    ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
                      if canTakeService then
                        ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 250.17, function(vehicle)
                          local playerPed = GetPlayerPed(-1)
                          TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
						  SetVehicleNumberPlateText(vehicle, "JANUSHCS")
                        end)
                      else
                        ESX.ShowNotification(_U('service_full') .. inServiceCount .. '/' .. maxInService)
                      end
                    end, 'zwierzako')
                    break
                  end
                end
                menu.close()
              end,
              function(data, menu)
                menu.close()
                OpenZwierzakoActionsMenu()
              end
            )

          end
      end

      if data.current.value == 'cloakroom' then
        menu.close()
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

            if skin.sex == 0 then
                TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
            else
                TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
            end
			
			OnDuty = true

        end)
      end

      if data.current.value == 'cloakroom2' then
        menu.close()
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

            TriggerEvent('skinchanger:loadSkin', skin)

        end)
		OnDuty = false
      end

      if data.current.value == 'put_stock' then
        OpenPutStocksMenu()
      end

      if data.current.value == 'get_stock' then
        OpenGetStocksMenu()
      end

      if data.current.value == 'boss_actions' then
        TriggerEvent('esx_society:openBossMenu', 'zwierzako', function(data, menu)
          menu.close()
        end)
      end

      --------------------------------------------------------------------
      --  {label = "Pobierz narzędzia", value = 'take_tools'},
      -- {label = "Oddaj narzędzia", value = 'return_tools'},


      if data.current.value == 'take_tools' then
        OpenTakeToolsMenu()
      end

      
      if data.current.value == 'return_tools' then
        OpenReturnToolsMenu()
      end


    end,
    function(data, menu)
      menu.close()
      CurrentAction     = 'zwierzako_actions_menu'
      CurrentActionMsg  = _U('open_actions')
      CurrentActionData = {}
    end
  )
end

function OpenZwierzakoHarvestMenu()

  if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.grade_name ~= 'recrue' then
    local elements = {
      {label = _U('gas_can'), value = 'gaz_bottle'},
      {label = _U('repair_tools'), value = 'fix_tool'},
      {label = _U('body_work_tools'), value = 'caro_tool'}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'zwierzako_harvest',
      {
        title    = _U('harvest'),
        align    = 'bottom-right',
        elements = elements
      },
      function(data, menu)
        if data.current.value == 'gaz_bottle' then
          menu.close()
          TriggerServerEvent('esx_zwierzakojob:startHarvest')
        end

        if data.current.value == 'fix_tool' then
          menu.close()
          TriggerServerEvent('esx_zwierzakojob:startHarvest2')
        end

        if data.current.value == 'caro_tool' then
          menu.close()
          TriggerServerEvent('esx_zwierzakojob:startHarvest3')
        end

      end,
      function(data, menu)
        menu.close()
        CurrentAction     = 'zwierzako_harvest_menu'
        CurrentActionMsg  = _U('harvest_menu')
        CurrentActionData = {}
      end
    )
  else
    ESX.ShowNotification(_U('not_experienced_enough'))
  end
end

function OpenZwierzakoCraftMenu()
  if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.grade_name ~= 'recrue' then

    local elements = {
      {label = _U('blowtorch'), value = 'blow_pipe'},
      {label = _U('repair_kit'), value = 'fix_kit'},
      {label = _U('body_kit'), value = 'caro_kit'}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'zwierzako_craft',
      {
        title    = _U('craft'),
        align    = 'bottom-right',
        elements = elements
      },
      function(data, menu)
        if data.current.value == 'blow_pipe' then
          menu.close()
          TriggerServerEvent('esx_zwierzakojob:startCraft')
        end

        if data.current.value == 'fix_kit' then
          menu.close()
          TriggerServerEvent('esx_zwierzakojob:startCraft2')
        end

        if data.current.value == 'caro_kit' then
          menu.close()
          TriggerServerEvent('esx_zwierzakojob:startCraft3')
        end

      end,
      function(data, menu)
        menu.close()
        CurrentAction     = 'zwierzako_craft_menu'
        CurrentActionMsg  = _U('craft_menu')
        CurrentActionData = {}
      end
    )
  else
    ESX.ShowNotification(_U('not_experienced_enough'))
  end
end

RegisterNetEvent('esx_zwierzakojob:setVehicleHoodStates')
AddEventHandler('esx_zwierzakojob:setVehicleHoodStates', function(vehicle, stat)

	VehicleHoods[vehicle] = stat

end)

function OpenMobileZwierzakoActionsMenu()

  ESX.UI.Menu.CloseAll()

	-- ,
	-- {label = _U('imp_veh'),     value = 'del_vehicle'},
	-- {label = _U('flat_bed'),       value = 'dep_vehicle'},
	-- {label = _U('place_objects'), value = 'object_spawner'}
  local elements = {}
	table.insert(elements, {label = "Otwórz Zamek",     value = 'hijack_vehicle'})
    table.insert(elements, {label = "Napraw cały pojazd",       value = 'fix_vehicle'})
    table.insert(elements, {label = "Napraw silnik pojazdu",       value = 'fix_vehicle_engine'})
    table.insert(elements, {label = "Wyczyść pojazd",      value = 'clean_vehicle'})
    table.insert(elements, {label = "Otwórz/Zamknij maskę pojazdu",      value = 'open_hood_vehicle'})
	table.insert(elements, {label = "Sciągnij/Wciągnij pojazd na lawete",      value = 'put_on_flatbed'})
  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'mobile_zwierzako_actions',
    {
      title    = _U('mechanic'),
      align    = 'bottom-right',
      elements = elements
    },
    function(data, menu)
      if data.current.value == 'billing' then
        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'billing',
          {
            title = _U('invoice_amount')
          },
          function(data, menu)
            local amount = tonumber(data.value)
            if amount == nil or amount < 0 then
              ESX.ShowNotification(_U('amount_invalid'))
            else
              menu.close()
              local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
              if closestPlayer == -1 or closestDistance > 3.0 then
                ESX.ShowNotification(_U('no_players_nearby'))
              else
                TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_zwierzako', _U('mechanic'), amount)
              end
            end
          end,
        function(data, menu)
          menu.close()
        end
        )
      end

      if data.current.value == 'hijack_vehicle' then

        local playerPed = GetPlayerPed(-1)
        local coords    = GetEntityCoords(playerPed)

        if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

          local vehicle = nil

          if IsPedInAnyVehicle(playerPed, false) then
            vehicle = GetVehiclePedIsIn(playerPed, false)
          else
            vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
          end

          if DoesEntityExist(vehicle) then
            TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
            Citizen.CreateThread(function()
              Citizen.Wait(10000)
              SetVehicleDoorsLocked(vehicle, 1)
              SetVehicleDoorsLockedForAllPlayers(vehicle, false)
              ClearPedTasksImmediately(playerPed)
              ESX.ShowNotification(_U('vehicle_unlocked'))
            end)
          end

        end

      end
	  
	  if data.current.value == 'hijack_vehicle_quick' then

        local playerPed = GetPlayerPed(-1)
        local coords    = GetEntityCoords(playerPed)

        if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

          local vehicle = nil

          if IsPedInAnyVehicle(playerPed, false) then
            vehicle = GetVehiclePedIsIn(playerPed, false)
          else
            vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
          end

          if DoesEntityExist(vehicle) then
            TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
            Citizen.CreateThread(function()
              Citizen.Wait(2500)
              SetVehicleDoorsLocked(vehicle, 1)
              SetVehicleDoorsLockedForAllPlayers(vehicle, false)
              ClearPedTasksImmediately(playerPed)
              ESX.ShowNotification(_U('vehicle_unlocked'))
            end)
          end

        end

      end

	  if data.current.value == 'put_on_flatbed' then
		TriggerEvent("flatbed:tow")
	  end

	  if data.current.value == 'open_hood_vehicle' then
		
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
			  TriggerServerEvent("esx_zwierzakojob:setVehicleHoodState", vehicle, 1)
			  Citizen.Wait(750)
		  else
			if(VehicleHoods[vehicle] == 1) then
				SetVehicleDoorShut(vehicle, 4, 0)
				VehicleHoods[vehicle] = 0
				TriggerServerEvent("esx_zwierzakojob:setVehicleHoodState", vehicle, 0)
				Citizen.Wait(750)
			elseif(VehicleHoods[vehicle] == 0) then
				SetVehicleDoorOpen(vehicle, 4, 0, 0)
				VehicleHoods[vehicle] = 1
				TriggerServerEvent("esx_zwierzakojob:setVehicleHoodState", vehicle, 1)
				Citizen.Wait(750)
			end
		  end
		end
	  end
	  
	
      if data.current.value == 'fix_vehicle' then

        local playerPed = GetPlayerPed(-1)
        local coords    = GetEntityCoords(playerPed)

        if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

          local vehicle = nil

          if IsPedInAnyVehicle(playerPed, false) then
            vehicle = GetVehiclePedIsIn(playerPed, false)
          else
            vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
          end

          if DoesEntityExist(vehicle) then
            TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
            Citizen.CreateThread(function()
              Citizen.Wait(20000)
              SetVehicleFixed(vehicle)
              SetVehicleDeformationFixed(vehicle)
              SetVehicleUndriveable(vehicle, false)
              SetVehicleEngineOn(vehicle,  true,  true)
              ClearPedTasksImmediately(playerPed)
              ESX.ShowNotification(_U('vehicle_repaired'))
            end)
          end
        end
      end
	  
	
      if data.current.value == 'fix_vehicle_engine' then

        local playerPed = GetPlayerPed(-1)
        local coords    = GetEntityCoords(playerPed)

        if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

          local vehicle = nil

          if IsPedInAnyVehicle(playerPed, false) then
            vehicle = GetVehiclePedIsIn(playerPed, false)
          else
            vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
          end

          if DoesEntityExist(vehicle) then
			  TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
			  Citizen.CreateThread(function()
				Citizen.Wait(20000)
				--SetVehicleFixed(vehicle)
				--SetVehicleDeformationFixed(vehicle)
				SetVehicleEngineHealth(vehicle, 805.0)
				TriggerEvent("EngineToggle:FixEngine", vehicle)
				SetVehicleUndriveable(vehicle, false)
				Citizen.Wait(1500)
				ClearPedTasksImmediately(GetPlayerPed(-1))
				TriggerEvent("esx:showNotification", "~g~Silnik naprawiony!")
			  end)
			end
        end
      end

      if data.current.value == 'clean_vehicle' then

        local playerPed = GetPlayerPed(-1)
        local coords    = GetEntityCoords(playerPed)

        if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

          local vehicle = nil

          if IsPedInAnyVehicle(playerPed, false) then
            vehicle = GetVehiclePedIsIn(playerPed, false)
          else
            vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
          end

          if DoesEntityExist(vehicle) then
            TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_MAID_CLEAN", 0, true)
            Citizen.CreateThread(function()
              Citizen.Wait(10000)
              SetVehicleDirtLevel(vehicle, 0)
              ClearPedTasksImmediately(playerPed)
              ESX.ShowNotification(_U('vehicle_cleaned'))
            end)
          end
        end
      end
	  
	  if data.current.value == 'fix_vehicle_quick' then

        local playerPed = GetPlayerPed(-1)
        local coords    = GetEntityCoords(playerPed)

        if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

          local vehicle = nil

          if IsPedInAnyVehicle(playerPed, false) then
            vehicle = GetVehiclePedIsIn(playerPed, false)
          else
            vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
          end

          if DoesEntityExist(vehicle) then
            TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
            Citizen.CreateThread(function()
              Citizen.Wait(5000)
              SetVehicleFixed(vehicle)
              SetVehicleDeformationFixed(vehicle)
              SetVehicleUndriveable(vehicle, false)
              SetVehicleEngineOn(vehicle,  true,  true)
              ClearPedTasksImmediately(playerPed)
              ESX.ShowNotification(_U('vehicle_repaired'))
            end)
          end
        end
      end
	  
	
      if data.current.value == 'fix_vehicle_engine_quick' then

        local playerPed = GetPlayerPed(-1)
        local coords    = GetEntityCoords(playerPed)

        if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

          local vehicle = nil

          if IsPedInAnyVehicle(playerPed, false) then
            vehicle = GetVehiclePedIsIn(playerPed, false)
          else
            vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
          end

          if DoesEntityExist(vehicle) then
			  TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
			  Citizen.CreateThread(function()
				Citizen.Wait(5000)
				--SetVehicleFixed(vehicle)
				--SetVehicleDeformationFixed(vehicle)
				SetVehicleEngineHealth(vehicle, 805.0)
				TriggerEvent("EngineToggle:FixEngine", vehicle)
				SetVehicleUndriveable(vehicle, false)
				Citizen.Wait(1500)
				ClearPedTasksImmediately(GetPlayerPed(-1))
				TriggerEvent("esx:showNotification", "~g~Silnik naprawiony!")
			  end)
			end
        end
      end

      if data.current.value == 'clean_vehicle_quick' then

        local playerPed = GetPlayerPed(-1)
        local coords    = GetEntityCoords(playerPed)

        if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

          local vehicle = nil

          if IsPedInAnyVehicle(playerPed, false) then
            vehicle = GetVehiclePedIsIn(playerPed, false)
          else
            vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
          end

          if DoesEntityExist(vehicle) then
            TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_MAID_CLEAN", 0, true)
            Citizen.CreateThread(function()
              Citizen.Wait(2500)
              SetVehicleDirtLevel(vehicle, 0)
              ClearPedTasksImmediately(playerPed)
              ESX.ShowNotification(_U('vehicle_cleaned'))
            end)
          end
        end
      end

      if data.current.value == 'del_vehicle' then

        local ped = GetPlayerPed( -1 )

        if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then
          local pos = GetEntityCoords( ped )

          if ( IsPedSittingInAnyVehicle( ped ) ) then
            local vehicle = GetVehiclePedIsIn( ped, false )

            if ( GetPedInVehicleSeat( vehicle, -1 ) == ped ) then
              ESX.ShowNotification(_U('vehicle_impounded'))
              SetEntityAsMissionEntity( vehicle, true, true )
              deleteCar( vehicle )
            else
              ESX.ShowNotification(_U('must_seat_driver'))
            end
          else
            local playerPos = GetEntityCoords( ped, 1 )
            local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords( ped, 0.0, distanceToCheck, 0.0 )
            local vehicle = GetVehicleInDirection( playerPos, inFrontOfPlayer )

            if ( DoesEntityExist( vehicle ) ) then
              ESX.ShowNotification(_U('vehicle_impounded'))
              SetEntityAsMissionEntity( vehicle, true, true )
              deleteCar( vehicle )
            else
              ESX.ShowNotification(_U('must_near'))
            end
          end
        end
      end

      if data.current.value == 'dep_vehicle' then

        local playerped = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(playerped, true)

        local towmodel = GetHashKey('flatbed')
        local isVehicleTow = IsVehicleModel(vehicle, towmodel)

        if isVehicleTow then

          local coordA = GetEntityCoords(playerped, 1)
          local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 5.0, 0.0)
          local targetVehicle = getVehicleInDirection(coordA, coordB)

          if CurrentlyTowedVehicle == nil then
            if targetVehicle ~= 0 then
              if not IsPedInAnyVehicle(playerped, true) then
                if vehicle ~= targetVehicle then
                  AttachEntityToEntity(targetVehicle, vehicle, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
                  CurrentlyTowedVehicle = targetVehicle
                  ESX.ShowNotification(_U('vehicle_success_attached'))

                  if NPCOnJob then

                    if NPCTargetTowable == targetVehicle then
                      ESX.ShowNotification(_U('please_drop_off'))

                      Config.Zones.VehicleDelivery.Type = 1

                      if Blips['NPCTargetTowableZone'] ~= nil then
                        RemoveBlip(Blips['NPCTargetTowableZone'])
                        Blips['NPCTargetTowableZone'] = nil
                      end

                      Blips['NPCDelivery'] = AddBlipForCoord(Config.Zones.VehicleDelivery.Pos.x,  Config.Zones.VehicleDelivery.Pos.y,  Config.Zones.VehicleDelivery.Pos.z)

                      SetBlipRoute(Blips['NPCDelivery'], true)

                    end

                  end

                else
                  ESX.ShowNotification(_U('cant_attach_own_tt'))
                end
              end
            else
              ESX.ShowNotification(_U('no_veh_att'))
            end
          else

            AttachEntityToEntity(CurrentlyTowedVehicle, vehicle, 20, -0.5, -12.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
            DetachEntity(CurrentlyTowedVehicle, true, true)

            if NPCOnJob then

              if NPCTargetDeleterZone then

                if CurrentlyTowedVehicle == NPCTargetTowable then
                  ESX.Game.DeleteVehicle(NPCTargetTowable)
                  TriggerServerEvent('esx_zwierzakojob:onNPCJobMissionCompleted')
                  StopNPCJob()
                  NPCTargetDeleterZone = false

                else
                  ESX.ShowNotification(_U('not_right_veh'))
                end

              else
                ESX.ShowNotification(_U('not_right_place'))
              end

            end

            CurrentlyTowedVehicle = nil

            ESX.ShowNotification(_U('veh_det_succ'))
          end
        else
          ESX.ShowNotification(_U('imp_flatbed'))
        end
      end

      if data.current.value == 'object_spawner' then

        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'mobile_zwierzako_actions_spawn',
          {
            title    = _U('objects'),
            align    = 'bottom-right',
            elements = {
              {label = _U('roadcone'),     value = 'prop_roadcone02a'},
              {label = _U('toolbox'), value = 'prop_toolchest_01'},
            },
          },
          function(data2, menu2)


            local model     = data2.current.value
            local playerPed = GetPlayerPed(-1)
            local coords    = GetEntityCoords(playerPed)
            local forward   = GetEntityForwardVector(playerPed)
            local x, y, z   = table.unpack(coords + forward * 1.0)

            if model == 'prop_roadcone02a' then
              z = z - 2.0
            elseif model == 'prop_toolchest_01' then
              z = z - 2.0
            end

            ESX.Game.SpawnObject(model, {
              x = x,
              y = y,
              z = z
            }, function(obj)
              SetEntityHeading(obj, GetEntityHeading(playerPed))
              PlaceObjectOnGroundProperly(obj)
            end)

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end

    end,
  function(data, menu)
    menu.close()
  end
  )
end

function OpenGetStocksMenu()

  ESX.TriggerServerCallback('esx_zwierzakojob:getStockItems', function(items)

    local elements = {}

    for i=1, #items, 1 do
      table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'stocks_menu',
      {
        title    = _U('mechanic_stock'),
        align    = 'bottom-right',
        elements = elements
      },
      function(data, menu)

        local itemName = data.current.value

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count',
          {
            title = _U('quantity')
          },
          function(data2, menu2)

            local count = tonumber(data2.value)

            if count == nil then
              ESX.ShowNotification(_U('invalid_quantity'))
            else
              menu2.close()
              menu.close()
              OpenGetStocksMenu()

              TriggerServerEvent('esx_zwierzakojob:getStockItem', itemName, count)
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenPutStocksMenu()

ESX.TriggerServerCallback('esx_zwierzakojob:getPlayerInventory', function(inventory)

    local elements = {}

    for i=1, #inventory.items, 1 do

      local item = inventory.items[i]

      if item.count > 0 then
        table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
      end

    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'stocks_menu',
      {
        title    = _U('inventory'),
        align    = 'bottom-right',
        elements = elements
      },
      function(data, menu)

        local itemName = data.current.value

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count',
          {
            title = _U('quantity')
          },
          function(data2, menu2)

            local count = tonumber(data2.value)

            if count == nil then
              ESX.ShowNotification(_U('invalid_quantity'))
            else
              menu2.close()
              menu.close()
              OpenPutStocksMenu()

              TriggerServerEvent('esx_zwierzakojob:putStockItems', itemName, count)
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end
-------------------------------------------------------------------------------

--[[
function OpenGetItemMenu()
	local elements = {
		{ label = 'Policyjny zestaw naprawczy', value = 'polfixkit' }
	}
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_get_weapon',
	{
		title    = _U('get_weapon_menu'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		menu.close()
		TriggerServerEvent('srp_sheriffjob:get_item', data.current.label, data.current.value, 1)
	end, function(data, menu)
		menu.close()
	end)
end

]]
function  OpenTakeToolsMenu()
	local elements = {
    { label = 'Radio', value = 'radio', type = 'item' },    
		{ label = 'Młotek', value = 'weapon_hammer', type = 'weapon' }
	}
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'take_tools_menu',
	{
		title    = "Pobierz narzędzia",
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
    menu.close()
    if data.current.type == 'item' then
      TriggerServerEvent('esx_zwierzakojob:get_item', data.current.label, data.current.value, 1)
      
    elseif data.current.type == 'weapon' then
      
      TriggerServerEvent('esx_zwierzakojob:giveWeapon', data.current.value)
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
						ESX.ShowNotification("nieprawidłowa ilość")
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

RegisterNetEvent('esx_zwierzakojob:onHijack')
AddEventHandler('esx_zwierzakojob:onHijack', function()
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
	 if PlayerData.job.name ~= 'zwierzako' and PlayerData.job.name  ~= 'mecano' and PlayerData.job.name  ~= 'police' and PlayerData.job.name  ~= 'sheriff' and PlayerData.job.name  ~= 'statepolice' then
                TriggerEvent("outlaw:lockpick")
        end
      end  
      TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
      Citizen.CreateThread(function()
        exports['progressBars']:startUI(30000, "Otwieranie zamka...")
        Citizen.Wait(30000)
	local jobChance = 30
	if PlayerData.job.name == 'zwierzako' or PlayerData.job.name == 'mecano' or PlayerData.job.name == 'police' and PlayerData.job.name  ~= 'sheriff' and PlayerData.job.name  ~= 'statepolice' then
		jobChance = 100
	end
        if crochete <= jobChance then
          SetVehicleDoorsLocked(vehicle, 1)
          SetVehicleDoorsLockedForAllPlayers(vehicle, false)
          ClearPedTasksImmediately(playerPed)
          ESX.ShowNotification(_U('veh_unlocked'))
        else
          ESX.ShowNotification(_U('hijack_failed'))
          ClearPedTasksImmediately(playerPed)
        end
      end)
    end

  end
end)

RegisterNetEvent('esx_zwierzakojob:onCarokit')
AddEventHandler('esx_zwierzakojob:onCarokit', function()
  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)

  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

    local vehicle = nil

    if IsPedInAnyVehicle(playerPed, false) then
      vehicle = GetVehiclePedIsIn(playerPed, false)
    else
      vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
    end

    if DoesEntityExist(vehicle) then
      TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_HAMMERING", 0, true)
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

RegisterNetEvent('esx_zwierzakojob:onFixkit')
AddEventHandler('esx_zwierzakojob:onFixkit', function()
  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)

  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

    local vehicle = nil

    if IsPedInAnyVehicle(playerPed, false) then
	  TriggerEvent("esx:showNotification", "~r~Musisz wyjść z pojazdu aby naprawić silnik!")
    else
      vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
    end

    if DoesEntityExist(vehicle) then
      TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
      Citizen.CreateThread(function()
		TriggerEvent('esx:showNotification', _U('you_used_repair_kit'))
		TriggerServerEvent("esx_zwierzakojob:removeFixTool")
    TriggerEvent("esx_anims:repair", true)
        exports['progressBars']:startUI(20000, "Naprawianie...")
        Citizen.Wait(20000)
		SetVehicleEngineHealth(vehicle, 805.0)
		TriggerServerEvent("EngineToggle:FixEngines", vehicle)
        SetVehicleUndriveable(vehicle, false)
		TriggerEvent("esx_anims:repair", false)
		Citizen.Wait(1500)
		ClearPedTasksImmediately(GetPlayerPed(-1))
		TriggerEvent("esx:showNotification", "~g~Silnik naprawiony!")
      end)
    end
  end
end)

RegisterNetEvent('esx_zwierzakojob:onPolFixkit')
AddEventHandler('esx_zwierzakojob:onPolFixkit', function()
  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)

  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

    local vehicle = nil

    if IsPedInAnyVehicle(playerPed, false) then
	  TriggerEvent("esx:showNotification", "~r~Musisz wyjść z pojazdu aby naprawić silnik!")
    else
      vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
    end

    if DoesEntityExist(vehicle) then
      TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
      Citizen.CreateThread(function()
		TriggerEvent('esx:showNotification', _U('you_used_repair_kit'))
		TriggerServerEvent("esx_zwierzakojob:removePolFixTool")
    TriggerEvent("esx_anims:repair", true)
        exports['progressBars']:startUI(20000, "Naprawianie...")
        Citizen.Wait(20000)
		SetVehicleEngineHealth(vehicle, 805.0)
		TriggerServerEvent("EngineToggle:FixEngines", vehicle)
        SetVehicleUndriveable(vehicle, false)
		TriggerEvent("esx_anims:repair", false)
		Citizen.Wait(1500)
		ClearPedTasksImmediately(GetPlayerPed(-1))
		TriggerEvent("esx:showNotification", "~g~Silnik naprawiony!")
      end)
    end
  end
end)

function setEntityHeadingFromEntity ( vehicle, playerPed )
    local heading = GetEntityHeading(vehicle)
    SetEntityHeading( playerPed, heading )
end

function getVehicleInDirection(coordFrom, coordTo)
  local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
  local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
  return vehicle
end

function deleteCar( entity )
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

AddEventHandler('esx_zwierzakojob:hasEnteredMarker', function(zone)
  if zone == NPCJobTargetTowable then
  end
  if zone =='VehicleDelivery' then
    NPCTargetDeleterZone = true
  end
  if zone == 'ZwierzakoActions' then
    CurrentAction     = 'zwierzako_actions_menu'
    CurrentActionMsg  = _U('open_actions')
    CurrentActionData = {}
  end
  if zone == 'Garage' then
    CurrentAction     = 'zwierzako_harvest_menu'
    CurrentActionMsg  = _U('harvest_menu')
    CurrentActionData = {}
  end
  if zone == 'Craft' then
    CurrentAction     = 'zwierzako_craft_menu'
    CurrentActionMsg  = _U('craft_menu')
    CurrentActionData = {}
  end
  if zone == 'VehicleDeleter' then
    local playerPed = GetPlayerPed(-1)
    if IsPedInAnyVehicle(playerPed,  false) then
      local vehicle = GetVehiclePedIsIn(playerPed,  false)
      CurrentAction     = 'delete_vehicle'
      CurrentActionMsg  = _U('veh_stored')
      CurrentActionData = {vehicle = vehicle}
    end
  end
end)

AddEventHandler('esx_zwierzakojob:hasExitedMarker', function(zone)

  if zone =='VehicleDelivery' then
    NPCTargetDeleterZone = false
  end

  if zone == 'Craft' then
    TriggerServerEvent('esx_zwierzakojob:stopCraft')
    TriggerServerEvent('esx_zwierzakojob:stopCraft2')
    TriggerServerEvent('esx_zwierzakojob:stopCraft3')
  end

  if zone == 'Garage' then
    TriggerServerEvent('esx_zwierzakojob:stopHarvest')
    TriggerServerEvent('esx_zwierzakojob:stopHarvest2')
    TriggerServerEvent('esx_zwierzakojob:stopHarvest3')
  end

  CurrentAction = nil
  ESX.UI.Menu.CloseAll()
end)

AddEventHandler('esx_zwierzakojob:hasEnteredEntityZone', function(entity)

  local playerPed = GetPlayerPed(-1)

  if PlayerData.job ~= nil and PlayerData.job.name == 'zwierzako' and not IsPedInAnyVehicle(playerPed, false) then
    CurrentAction     = 'remove_entity'
    CurrentActionMsg  = _U('press_remove_obj')
    CurrentActionData = {entity = entity}
  end

end)

AddEventHandler('esx_zwierzakojob:hasExitedEntityZone', function(entity)

  if CurrentAction == 'remove_entity' then
    CurrentAction = nil
  end

end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
  local specialContact = {
    name       = _U('mechanic'),
    number     = 'zwierzako',
    base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEwAACxMBAJqcGAAAA4BJREFUWIXtll9oU3cUx7/nJA02aSSlFouWMnXVB0ejU3wcRteHjv1puoc9rA978cUi2IqgRYWIZkMwrahUGfgkFMEZUdg6C+u21z1o3fbgqigVi7NzUtNcmsac40Npltz7S3rvUHzxQODec87vfD+/e0/O/QFv7Q0beV3QeXqmgV74/7H7fZJvuLwv8q/Xeux1gUrNBpN/nmtavdaqDqBK8VT2RDyV2VHmF1lvLERSBtCVynzYmcp+A9WqT9kcVKX4gHUehF0CEVY+1jYTTIwvt7YSIQnCTvsSUYz6gX5uDt7MP7KOKuQAgxmqQ+neUA+I1B1AiXi5X6ZAvKrabirmVYFwAMRT2RMg7F9SyKspvk73hfrtbkMPyIhA5FVqi0iBiEZMMQdAui/8E4GPv0oAJkpc6Q3+6goAAGpWBxNQmTLFmgL3jSJNgQdGv4pMts2EKm7ICJB/aG0xNdz74VEk13UYCx1/twPR8JjDT8wttyLZtkoAxSb8ZDCz0gdfKxWkFURf2v9qTYH7SK7rQIDn0P3nA0ehixvfwZwE0X9vBE/mW8piohhl1WH18UQBhYnre8N/L8b8xQvlx4ACbB4NnzaeRYDnKm0EALCMLXy84hwuTCXL/ExoB1E7qcK/8NCLIq5HcTT0i6u8TYbXUM1cAyyveVq8Xls7XhYrvY/4n3gC8C+dsmAzL1YUiyfWxvHzsy/w/dNd+KjhW2yvv/RfXr7x9QDcmo1he2RBiCCI1Q8jVj9szPNixVfgz+UiIGyDSrcoRu2J16d3I6e1VYvNSQjXpnucAcEPUOkGYZs/l4uUhowt/3kqu1UIv9n90fAY9jT3YBlbRvFTD4fw++wHjhiTRL/bG75t0jI2ITcHb5om4Xgmhv57xpGOg3d/NIqryOR7z+r+MC6qBJB/ZB2t9Om1D5lFm843G/3E3HI7Yh1xDRAfzLQr5EClBf/HBHK462TG2J0OABXeyWDPZ8VqxmBWYscpyghwtTd4EKpDTjCZdCNmzFM9k+4LHXIFACJN94Z6FiFEpKDQw9HndWsEuhnADVMhAUaYJBp9XrcGQKJ4qFE9k+6r2+MG3k5N8VQ22TVglbX2ZwOzX2VvNKr91zmY6S7N6zqZicVT2WNLyVSehESaBhxnOALfMeYX+K/S2yv7wmMAlvwyuR7FxQUyf0fgc/jztfkJr7XeGgC8BJJgWNV8ImT+AAAAAElFTkSuQmCC'
  }
  TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

-- Pop NPC mission vehicle when inside area
Citizen.CreateThread(function()
  while true do

    Wait(20)

    if NPCTargetTowableZone ~= nil and not NPCHasSpawnedTowable then

      local coords = GetEntityCoords(GetPlayerPed(-1))
      local zone   = Config.Zones[NPCTargetTowableZone]

      if GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < Config.NPCSpawnDistance then

        local model = Config.Vehicles[GetRandomIntInRange(1,  #Config.Vehicles)]

        ESX.Game.SpawnVehicle(model, zone.Pos, 0, function(vehicle)
          NPCTargetTowable = vehicle
        end)

        NPCHasSpawnedTowable = true

      end

    end

    if NPCTargetTowableZone ~= nil and NPCHasSpawnedTowable and not NPCHasBeenNextToTowable then

      local coords = GetEntityCoords(GetPlayerPed(-1))
      local zone   = Config.Zones[NPCTargetTowableZone]

      if(GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < Config.NPCNextToDistance) then
        ESX.ShowNotification(_U('please_tow'))
        NPCHasBeenNextToTowable = true
      end

    end

  end
end)

-- Create Blips
Citizen.CreateThread(function()
  local blip = AddBlipForCoord(Config.Zones.ZwierzakoActions.Pos.x, Config.Zones.ZwierzakoActions.Pos.y, Config.Zones.ZwierzakoActions.Pos.z)
  SetBlipSprite (blip, 446)
  SetBlipDisplay(blip, 4)
  SetBlipScale  (blip, 0.7)
  SetBlipColour (blip, 1)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Janusz Customs")
  EndTextCommandSetBlipName(blip)
end)

-- Display markers
Citizen.CreateThread(function()
  while true do
    Wait(10)
    if PlayerData.job ~= nil and PlayerData.job.name == 'zwierzako' then

      local coords = GetEntityCoords(GetPlayerPed(-1))

      for k,v in pairs(Config.Zones) do
        if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
          DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
        end
      end
    end
  end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
  while true do
    Wait(100)
    if PlayerData.job ~= nil and PlayerData.job.name == 'zwierzako' then
      local coords      = GetEntityCoords(GetPlayerPed(-1))
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
        TriggerEvent('esx_zwierzakojob:hasEnteredMarker', currentZone)
      end
      if not isInMarker and HasAlreadyEnteredMarker then
        HasAlreadyEnteredMarker = false
        TriggerEvent('esx_zwierzakojob:hasExitedMarker', LastZone)
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

    Citizen.Wait(100)

    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)

    local closestDistance = -1
    local closestEntity   = nil

    for i=1, #trackedEntities, 1 do

      local object = GetClosestObjectOfType(coords.x,  coords.y,  coords.z,  3.0,  GetHashKey(trackedEntities[i]), false, false, false)

      if DoesEntityExist(object) then

        local objCoords = GetEntityCoords(object)
        local distance  = GetDistanceBetweenCoords(coords.x,  coords.y,  coords.z,  objCoords.x,  objCoords.y,  objCoords.z,  true)

        if closestDistance == -1 or closestDistance > distance then
          closestDistance = distance
          closestEntity   = object
        end

      end

    end

    if closestDistance ~= -1 and closestDistance <= 3.0 then

      if LastEntity ~= closestEntity then
        TriggerEvent('esx_zwierzakojob:hasEnteredEntityZone', closestEntity)
        LastEntity = closestEntity
      end

    else

      if LastEntity ~= nil then
        TriggerEvent('esx_zwierzakojob:hasExitedEntityZone', LastEntity)
        LastEntity = nil
      end

    end

  end
end)

-- Key Controls
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)

        if CurrentAction ~= nil then

          SetTextComponentFormat('STRING')
          AddTextComponentString(CurrentActionMsg)
          DisplayHelpTextFromStringLabel(0, 0, 1, -1)

          if IsControlJustReleased(0, 38) and PlayerData.job ~= nil and PlayerData.job.name == 'zwierzako' then

            if CurrentAction == 'zwierzako_actions_menu' then
                OpenZwierzakoActionsMenu()
            end

            if CurrentAction == 'zwierzako_harvest_menu' then
                OpenZwierzakoHarvestMenu()
            end

            if CurrentAction == 'zwierzako_craft_menu' then
                OpenZwierzakoCraftMenu()
            end

            if CurrentAction == 'delete_vehicle' then

              if Config.EnableSocietyOwnedVehicles then

                local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
                TriggerServerEvent('esx_society:putVehicleInGarage', 'zwierzako', vehicleProps)

              else

                if
                  GetEntityModel(vehicle) == GetHashKey('flatbed')   or
                  GetEntityModel(vehicle) == GetHashKey('towtruck2') or
                  GetEntityModel(vehicle) == GetHashKey('slamvan3')
                then
                  TriggerServerEvent('esx_service:disableService', 'zwierzako')
                end

              end

              ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
            end

            if CurrentAction == 'remove_entity' then
              DeleteEntity(CurrentActionData.entity)
            end

            CurrentAction = nil
          end
        end

        if IsControlJustReleased(0, Keys['F6']) and not IsDead and PlayerData.job ~= nil and PlayerData.job.name == 'zwierzako' then
			OpenMobileZwierzakoActionsMenu()
        end
    end
end)

AddEventHandler('esx:onPlayerDeath', function()
	IsDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	IsDead = false
end)

RegisterCommand("odholuj",function(source, args)
    if  PlayerData.job ~= nil and (PlayerData.job.name == 'police' or PlayerData.job.name == 'mecano' or PlayerData.job.name == 'zwierzako' or PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'statepolice') then
        local coords    = GetEntityCoords(PlayerPedId())
        local vehicle   = GetClosestVehicle(coords.x,  coords.y,  coords.z,  3.0,  0,  71)
		local vehicle2 = GetVehiclePedIsIn(PlayerPedId(), false)
        if vehicle ~= nil and not IsPedInAnyVehicle(PlayerPedId()) then 
			DeleteEntity(vehicle)
		end
		DeleteEntity(vehicle2)				
    end
end, false)
