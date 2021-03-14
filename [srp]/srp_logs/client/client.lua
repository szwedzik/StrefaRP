--[[
Name: srp_logs
Author: Ezi - Ezi#0001
Version: v0.01.3612
Date: 22/06/2019 - 13:32
]]--

ESX = nil
local PlayerData = {}
local ReasonOfDeath = nil
local KilledBy = nil
local pedIDlist = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	TriggerServerEvent("esx:playerconnected")
	TriggerServerEvent('log:getCurrentServer', GetCurrentServerEndpoint())
end)




RegisterNetEvent('srp_logs:carDataRetrieve')
AddEventHandler('srp_logs:carDataRetrieve', function()
	--local vehicleData = GetVehiclePedIsUsing(GetPlayerPed())
	local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId())))) --GetDisplayNameFromVehicleModel(
	TriggerServerEvent('srp_logs:carModelRetrieved',model)	
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsEntityDead(PlayerPedId()) then
			Citizen.Wait(500)
			local ObjectCheck = GetPedSourceOfDeath(PlayerPedId())
			--ESX.ShowNotification('Ob '..ObjectCheck..'Index '..NetworkGetPlayerIndexFromPed(ObjectCheck))	
			if IsEntityAPed(ObjectCheck) and IsPedAPlayer(ObjectCheck) then
				KilledBy = NetworkGetPlayerIndexFromPed(ObjectCheck)
			elseif IsEntityAVehicle(ObjectCheck) and IsEntityAPed(GetPedInVehicleSeat(ObjectCheck, -1)) and IsPedAPlayer(GetPedInVehicleSeat(ObjectCheck, -1)) then
				KilledBy = NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(ObjectCheck, -1))
			end

			if (KilledBy == PlayerId()) then
				ReasonOfDeath = 'Samobójstwo'
			elseif (KilledBy == nil) then
				ReasonOfDeath = 'Umarł'
			else
				if IsEntityAVehicle(ObjectCheck) then
					ReasonOfDeath = 'Został przejechany przez '..GetPlayerName(KilledBy)
				else
					ReasonOfDeath = 'Został zabity przez '..GetPlayerName(KilledBy)
				end
			end

			local playerPed  = GetPlayerPed(-1)
			local food_check = nil 
			TriggerEvent('esx_status:getStatus', 'hunger', function(status)
				if status.val == 0 then
					ReasonOfDeath = 'Umarł z głodu'
					food_check = 1
				end
			end)

			TriggerEvent('esx_status:getStatus', 'thirst', function(status)
				if status.val == 0 then
					ReasonOfDeath = 'Umarł z braku wody'
					food_check = 1
				end
			end)


		TriggerServerEvent('srp_logs:battleLog',ReasonOfDeath,GetPlayerName(KilledBy),food_check)
		

		end
		while IsEntityDead(PlayerPedId()) do
			Citizen.Wait(0)
		end

	end

end)


