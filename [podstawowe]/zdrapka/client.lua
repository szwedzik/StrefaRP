ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local drapie = false

RegisterNetEvent('ciemina:zdrapuj')
AddEventHandler('ciemina:zdrapuj', function()
	if drapie == false then
		exports['mythic_notify']:DoHudText('inform', 'Zdrapujesz zdrapkę', 3500)
		drapie = true
		local wynik = math.random(1,100)
		TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_PARKING_METER", 0, false)
		Citizen.Wait(4000)
		--print(wynik)
		
		if wynik == 11 then
			PlaySoundFrontend(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0,0,1)
			drapie = false
			TriggerServerEvent("ciemina:wygranko1")
			Citizen.Wait(1500)
			ClearPedTasks(GetPlayerPed(-1))
		elseif wynik >= 94 and wynik <= 98 then 
			PlaySoundFrontend(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0,0,1)
			drapie = false
			TriggerServerEvent("ciemina:wygranko2")
			Citizen.Wait(1500)
			ClearPedTasks(GetPlayerPed(-1))
		elseif wynik >= 88 and wynik <= 93 then 
			PlaySoundFrontend(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0,0,1)
			drapie = false
			TriggerServerEvent("ciemina:wygranko3")
			Citizen.Wait(1500)
			ClearPedTasks(GetPlayerPed(-1))
		elseif  wynik >= 79 and wynik <= 87 then 
			PlaySoundFrontend(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0,0,1)
			drapie = false
			TriggerServerEvent("ciemina:wygranko4")
			Citizen.Wait(1500)
			ClearPedTasks(GetPlayerPed(-1))
		elseif wynik >= 70 and wynik <= 78 then 
			PlaySoundFrontend(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0,0,1)
			drapie = false
			TriggerServerEvent("ciemina:wygranko5")
			Citizen.Wait(1500)
			ClearPedTasks(GetPlayerPed(-1))
		elseif wynik >= 30 and wynik <= 70 then 
			PlaySoundFrontend(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0,0,1)
			drapie = false
			TriggerServerEvent("ciemina:wygranko6")
			Citizen.Wait(1500)
			ClearPedTasks(GetPlayerPed(-1))
		else
			PlaySoundFrontend(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0,0,1)
			drapie = false
			Citizen.Wait(1500)
			exports['mythic_notify']:DoHudText('inform', 'Nic nie wygrałeś')
			ClearPedTasks(GetPlayerPed(-1))
		end
	else
		exports['mythic_notify']:DoHudText('error', 'Poczekaj aż zdrapiesz obecną zdrapkę...', 4000)
	end	
end)
-- plus
RegisterNetEvent('ciemina:zdrapujplus')
AddEventHandler('ciemina:zdrapujplus', function()
	if drapie == false then
		exports['mythic_notify']:DoHudText('inform', 'Zdrapujesz zdrapkę', 3500)
		drapie = true
		local wynik = math.random(1,100)
		TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_PARKING_METER", 0, false)
		Citizen.Wait(4000)
		--print(wynik)
		
		if wynik == 27 then
			PlaySoundFrontend(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0,0,1)
			drapie = false
			TriggerServerEvent("ciemina:wygranko1plus")
			Citizen.Wait(1500)
			ClearPedTasks(GetPlayerPed(-1))
		elseif wynik >= 95 and wynik <= 98 then 
			PlaySoundFrontend(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0,0,1)
			drapie = false
			TriggerServerEvent("ciemina:wygranko2plus")
			Citizen.Wait(1500)
			ClearPedTasks(GetPlayerPed(-1))
		elseif wynik >= 89 and wynik <= 94 then 
			PlaySoundFrontend(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0,0,1)
			drapie = false
			TriggerServerEvent("ciemina:wygranko3plus")
			Citizen.Wait(1500)
			ClearPedTasks(GetPlayerPed(-1))
		elseif  wynik >= 79 and wynik <= 88 then 
			PlaySoundFrontend(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0,0,1)
			drapie = false
			TriggerServerEvent("ciemina:wygranko4plus")
			Citizen.Wait(1500)
			ClearPedTasks(GetPlayerPed(-1))
		elseif wynik >= 71 and wynik <= 79 then 
			PlaySoundFrontend(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0,0,1)
			drapie = false
			TriggerServerEvent("ciemina:wygranko5plus")
			Citizen.Wait(1500)
			ClearPedTasks(GetPlayerPed(-1))
		elseif wynik >= 30 and wynik <= 70 then
			PlaySoundFrontend(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0,0,1)
			drapie = false
			TriggerServerEvent("ciemina:wygranko6plus")
			Citizen.Wait(1500)
			ClearPedTasks(GetPlayerPed(-1))
		else
			PlaySoundFrontend(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0,0,1)
			drapie = false
			Citizen.Wait(1500)
			exports['mythic_notify']:DoHudText('inform', 'Nic nie wygrałeś')
			ClearPedTasks(GetPlayerPed(-1))
		end
	else
		exports['mythic_notify']:DoHudText('error', 'Poczekaj aż zdrapiesz obecną zdrapkę...', 4000)
	end	
end)
-- extra
RegisterNetEvent('ciemina:zdrapujextra')
AddEventHandler('ciemina:zdrapujextra', function()
	if drapie == false then
		exports['mythic_notify']:DoHudText('inform', 'Zdrapujesz zdrapkę', 3500)
		drapie = true
		local wynik = math.random(1,100)
		TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_PARKING_METER", 0, false)
		Citizen.Wait(4000)
		--print(wynik)
		
		if wynik == 2 then
			PlaySoundFrontend(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0,0,1)
			drapie = false
			TriggerServerEvent("ciemina:wygranko1extra")
			Citizen.Wait(1500)
			ClearPedTasks(GetPlayerPed(-1))
		elseif wynik >= 98 and wynik <= 99 then 
			PlaySoundFrontend(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0,0,1)
			drapie = false
			TriggerServerEvent("ciemina:wygranko2extra")
			Citizen.Wait(1500)
			ClearPedTasks(GetPlayerPed(-1))
		elseif wynik >= 94 and wynik <= 97 then 
			PlaySoundFrontend(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0,0,1)
			drapie = false
			TriggerServerEvent("ciemina:wygranko3extra")
			Citizen.Wait(1500)
			ClearPedTasks(GetPlayerPed(-1))
		elseif  wynik >= 90 and wynik <= 93 then 
			PlaySoundFrontend(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0,0,1)
			drapie = false
			TriggerServerEvent("ciemina:wygranko4extra")
			Citizen.Wait(1500)
			ClearPedTasks(GetPlayerPed(-1))
		elseif wynik >= 86 and wynik <= 90 then 
			PlaySoundFrontend(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0,0,1)
			drapie = false
			TriggerServerEvent("ciemina:wygranko5extra")
			Citizen.Wait(1500)
			ClearPedTasks(GetPlayerPed(-1))
		else
			PlaySoundFrontend(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0,0,1)
			drapie = false
			Citizen.Wait(1500)
			exports['mythic_notify']:DoHudText('inform', 'Nic nie wygrałeś')
			ClearPedTasks(GetPlayerPed(-1))
		end
	else
		exports['mythic_notify']:DoHudText('error', 'Poczekaj aż zdrapiesz obecną zdrapkę...', 4000)
	end	
end)