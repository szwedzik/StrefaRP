ESX                           = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function GetVehHealthPercent()
	local ped = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsUsing(ped)
	local healthEngineCurrent = GetVehicleEngineHealth(vehicle)
	if (healthEngineCurrent <= 15.0+1) then
		return false;
	else
		return true;
	end
	
end

RegisterNetEvent('EngineToggle:Engine')
RegisterNetEvent('EngineToggle:FixEngine')
RegisterNetEvent('EngineToggle:EngineDamaged')
RegisterNetEvent('EngineToggle:RPDamage')
local vehicles = {}; RPWorking = true

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if UseKey and ToggleKey then
			if IsControlJustReleased(1, ToggleKey) then
				TriggerEvent('EngineToggle:Engine')
			end
		end
		if GetSeatPedIsTryingToEnter(GetPlayerPed(-1)) == -1 and not table.contains(vehicles, GetVehiclePedIsTryingToEnter(GetPlayerPed(-1))) then
			table.insert(vehicles, {GetVehiclePedIsTryingToEnter(GetPlayerPed(-1)), IsVehicleEngineOn(GetVehiclePedIsTryingToEnter(GetPlayerPed(-1))), false})
		elseif IsPedInAnyVehicle(GetPlayerPed(-1), false) and not table.contains(vehicles, GetVehiclePedIsIn(GetPlayerPed(-1), false, false, false)) then
			table.insert(vehicles, {GetVehiclePedIsIn(GetPlayerPed(-1), false), IsVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1), false, false, false)), false})
		end
		for i, vehicle in ipairs(vehicles) do
			if DoesEntityExist(vehicle[1]) then
				if (GetPedInVehicleSeat(vehicle[1], -1) == GetPlayerPed(-1)) or IsVehicleSeatFree(vehicle[1], -1) then
					if RPWorking then
						if not (vehicle[3]) then
							SetVehicleEngineOn(vehicle[1], vehicle[2], false, false)
							SetVehicleJetEngineOn(vehicle[1], vehicle[2])
							if not IsPedInAnyVehicle(GetPlayerPed(-1), false) or (IsPedInAnyVehicle(GetPlayerPed(-1), false) and vehicle[1]~= GetVehiclePedIsIn(GetPlayerPed(-1), false)) then
								if IsThisModelAHeli(GetEntityModel(vehicle[1])) or IsThisModelAPlane(GetEntityModel(vehicle[1])) then
									if vehicle[2] then
										SetHeliBladesFullSpeed(vehicle[1])
									end
								end
							end
						else
							SetVehicleEngineOn(vehicle[1], false, false, false)
							SetVehicleJetEngineOn(vehicle[1], false)
							if not IsPedInAnyVehicle(GetPlayerPed(-1), false) or (IsPedInAnyVehicle(GetPlayerPed(-1), false) and vehicle[1]~= GetVehiclePedIsIn(GetPlayerPed(-1), false)) then
								if IsThisModelAHeli(GetEntityModel(vehicle[1])) or IsThisModelAPlane(GetEntityModel(vehicle[1])) then
									if vehicle[2] then
										SetHeliBladesSpeed(vehicle[1], 0.0)
									end
								end
							end
						end
					end
				end
			else
				table.remove(vehicles, i)
			end
		end
	end
end)

AddEventHandler('EngineToggle:Engine', function()
	local veh
	local StateIndex
	for i, vehicle in ipairs(vehicles) do
		if vehicle[1] == GetVehiclePedIsIn(GetPlayerPed(-1), false) then
			veh = vehicle[1]
			StateIndex = i
		end
	end
	Citizen.Wait(500)
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
		if (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(-1)) then
			if not vehicles[StateIndex][4] then
				if not vehicles[StateIndex][5] then
					if not vehicles[StateIndex][3] then
						vehicles[StateIndex][2] = not GetIsVehicleEngineRunning(veh)
						-- if vehicles[StateIndex][2] then
							-- ESX.ShowNotification("~g~Silnik Włączony")
						-- else
							-- ESX.ShowNotification("~r~Silnik Wyłączony")
						-- end
					else
						ESX.ShowNotification("~r~Silnik jest uszkodzony\nNie mozesz uruchomić silnika!")
					end
				else
					ESX.ShowNotification("~r~W tym pojeździe nie ma paliwa! Nie możesz uruchomić silnika!")
				end
			else
				ESX.ShowNotification("~r~Nie możesz uruchomić silnika podczas tankowania!")
			end
		end 
    end 
end)

local wason = false

AddEventHandler('EngineToggle:EngineStateFuel', function(engine, state)
	local veh
	local StateIndex
	for i, vehicle in ipairs(vehicles) do
		if vehicle[1] == GetVehiclePedIsIn(GetPlayerPed(-1), false) then
			veh = vehicle[1]
			StateIndex = i
		end
	end
	Citizen.Wait(200)
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
		if (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(-1)) then
			if not vehicles[StateIndex][3] then
			
				if not engine and vehicles[StateIndex][2] then
					ESX.ShowNotification("~r~Silnik Wyłączony na czas tankowania")
					vehicles[StateIndex][2] = false
					wason = true
				elseif engine and not vehicles[StateIndex][2] then
					if wason then
						ESX.ShowNotification("~g~Tankowanie zakończone!\nSilnik uruchomiony!")
						vehicles[StateIndex][2] = true
						wason = false
					else
						ESX.ShowNotification("~g~Tankowanie zakończone!\nMożesz uruchomić silnik!")
					end
				end
			else
				ESX.ShowNotification("~r~Silnik jest uszkodzony")
			end
		end 
    end 
end)

AddEventHandler('EngineToggle:EngineFuel', function(engine)
	local veh
	local StateIndex
	for i, vehicle in ipairs(vehicles) do
		if vehicle[1] == GetVehiclePedIsIn(GetPlayerPed(-1), false) then
			veh = vehicle[1]
			StateIndex = i
		end
	end
	Citizen.Wait(200)
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
		if (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(-1)) then
			if not vehicles[StateIndex][3] then
				if engine then
					vehicles[StateIndex][5] = false
				else
					if vehicles[StateIndex][2] == true then
						ESX.ShowNotification("~r~W pojeździe skończyło się paliwo! Silnik się wyłączył!")
					end
				
					vehicles[StateIndex][2] = false
					vehicles[StateIndex][5] = true
				end
			else
			end
		end 
    end 
end)

AddEventHandler('EngineToggle:EngineDamaged', function()
	local veh
	local StateIndex
	for i, vehicle in ipairs(vehicles) do
		if vehicle[1] == GetVehiclePedIsIn(GetPlayerPed(-1), false) then
			veh = vehicle[1]
			StateIndex = i
		end
	end
	Citizen.Wait(500)
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
		if (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(-1)) then
			vehicles[StateIndex][2] = false
			vehicles[StateIndex][3] = true
			if vehicles[StateIndex][2] then
				ESX.ShowNotification("~r~Silnik Uszkodzony")
			else
				ESX.ShowNotification("~r~Silnik Uszkodzony")
			end
		end 
    end 
end)

AddEventHandler('EngineToggle:EngineDamagedStatesFix', function()
	local veh
	local StateIndex
	for i, vehicle in ipairs(vehicles) do
		if vehicle[1] == GetVehiclePedIsIn(GetPlayerPed(-1), false) then
			veh = vehicle[1]
			StateIndex = i
		end
	end
	Citizen.Wait(500)
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
		if (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(-1)) then
			vehicles[StateIndex][3] = false
		end 
    end 
end)

AddEventHandler('EngineToggle:FixEngine', function(cveh)
	local veh = nil
	local StateIndex
	for i, vehicle in ipairs(vehicles) do
		if vehicle[1] == cveh then
			veh = vehicle[1]
			StateIndex = i
		end
	end
	Citizen.Wait(100)
	if(veh ~= nil) then
		Citizen.Wait(1500)
		vehicles[StateIndex][2] = false
		vehicles[StateIndex][3] = false
		ClearPedTasksImmediately(GetPlayerPed(-1))
	end
end)

AddEventHandler('EngineToggle:FixEngineLSCustoms', function(cveh)
	local veh = nil
	local StateIndex
	for i, vehicle in ipairs(vehicles) do
		if vehicle[1] == cveh then
			veh = vehicle[1]
			StateIndex = i
		end
	end
	Citizen.Wait(100)
	if(veh ~= nil) then
		Citizen.Wait(500)
		vehicles[StateIndex][2] = true
		vehicles[StateIndex][3] = false
	end
end)

AddEventHandler('EngineToggle:RPDamage', function(State)
	RPWorking = State
end)

if OnAtEnter then
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(10)
			if GetSeatPedIsTryingToEnter(GetPlayerPed(-1)) == -1 then
				for i, vehicle in ipairs(vehicles) do
					if vehicle[1] == GetVehiclePedIsTryingToEnter(GetPlayerPed(-1)) and not vehicle[2] then
						Citizen.Wait(3500)
						vehicle[2] = true
						ESX.ShowNotification("~g~Silnik Włączony")
					end
				end
			end
		end
	end)
end

function table.contains(table, element)
  for _, value in pairs(table) do
    if value[1] == element then
      return true
    end
  end
  return false
end