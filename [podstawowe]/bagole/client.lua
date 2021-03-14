local player = PlayerPedId()
local PlayerData = {}
local inside = false
local odpal = false
ESX = nil

local 	cars_bagaznik = {
	--suvy(w komentarzach usunięte te które mają zbyt mały bagażnik)
	GetHashKey("burrito"),
	--GetHashKey("bjxl"),
	GetHashKey("baller"),
	GetHashKey("baller2"),
	GetHashKey("baller3"),
	GetHashKey("baller4"),
	GetHashKey("baller5"),
	GetHashKey("baller6"),
	GetHashKey("cavalcade"),
	GetHashKey("cavalcade2"),
	GetHashKey("contender"),
	GetHashKey("dubsta"),
	GetHashKey("dubsta2"),
	GetHashKey("fq2"),
	GetHashKey("granger"),
	GetHashKey("gresley"),
	GetHashKey("habanero"),
	GetHashKey("huntley"),
	GetHashKey("landstalker"),
	--GetHashKey("mesa"),
	--GetHashKey("mesa2"),
	GetHashKey("patriot"),
	GetHashKey("stretch"),
	GetHashKey("radi"),
	GetHashKey("rocoto"),
	GetHashKey("seminole"),
	GetHashKey("serrano"),
	--GetHashKey("toros"),
	GetHashKey("xls"),
	GetHashKey("xls2"),
	--furgony
	GetHashKey("rumpo3"),
	GetHashKey("minivan"),
}
--wczytanie postaci gracza?
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	player = PlayerPedId()
	PlayerData = ESX.GetPlayerData()
end)



--funkcja streamująca animację
function Streaming(animDict, cb)
	if not HasAnimDictLoaded(animDict) then
		RequestAnimDict(animDict)

		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(1)
		end
	end

	if cb ~= nil then
		cb()
	end
end	
-- funkcja wyszukująca auto w określonej odległości PRZED graczem
function VehicleInFront()
    --koordy gracza, rayhandle znajduje co jest w linii przed i zwraca jako result pierwsze co znajdzie
    local pos = GetEntityCoords(player)
    local entityWorld = GetOffsetFromEntityInWorldCoords(player, 0.0, 15.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, player, 0)
    local _, _, _, _, result = GetRaycastResult(rayHandle)
    return result
end


--skrypt dla wsadzającego, sprawdza pojazd, pobiera ID najbliższego gracza
RegisterNetEvent('Trunk:putin')
AddEventHandler('Trunk:putin', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	local vehicle = VehicleInFront()
	local czyauto = 0;
	local rightveh = false;
    --pętla - sprawdza czy pojazd jest na liście i czy jest ktoś obok
if closestPlayer == -1 or closestDistance > 3.0 then
    ESX.ShowNotification('Nikogo tu nie ma')
else
	for i = 1,#cars_bagaznik do
		rightveh = IsVehicleModel(vehicle, cars_bagaznik[i])
		if rightveh then
			--jak pojazd jest na liście:
			--  - wyświetla powiadomienie i wywołuje skrypt serwera
			--  - przekazuje ID najbliższego gracza do skryptu serverside
			ESX.ShowNotification('Wsadzasz/wyciągasz '..GetPlayerName(closestPlayer))
			TriggerServerEvent('Trunk:putin1', GetPlayerServerId(closestPlayer))
            czyauto=2;
            SetVehicleDoorOpen(vehicle, 5, 0, 0)
            Citizen.SetTimeout(2000, function()
                SetVehicleDoorShut(vehicle, 5, false)
            end) 
            
			break
		else
			if czyauto==2 then
			elseif czyauto == 0 then
				czyauto=1;
			else
				--Takie rzeczy nie maja miejsca
			end
		end
	end
	--jak auta nie ma na liście to pojawia się inny komunikat
	if czyauto==1 then
		ESX.ShowNotification('~r~To auto ma zbyt mały bagażnik, żeby '..GetPlayerName(closestPlayer).." zmieścił się w środku")
    end
end
end)


--skrypt dla wsadzanego gracza
RegisterNetEvent('Trunk:putin1')
AddEventHandler('Trunk:putin1', function()
			-- zbiór danych wywoływanych dalej w skrypcie
			local player = PlayerPedId()
            local playerPed = PlayerPedId()
           	local plyCoords = GetEntityCoords(player, false)
            local vehicle = VehicleInFront()
            local odpal = true
            -- jeżeli uruchamiamy skrypt to wykonuje się pętla wsadzająca lub wyciągająca
			-- zmienna odpal warunkuje wykonanie tylko jednej czynności (albo wsadź albo wyciągnij)
			if odpal and GetVehiclePedIsIn(player, false) == 0 then
                SetVehicleDoorOpen(vehicle, 5, 0, 0)
                if not inside then
					-- jeśli auta miały bagażniki w innych miejscach punkt zaczepienia został przeniesiony
					-- dla wygody otwartym kodem to opisałem, widać co się dzieje, łatwo zmienić, można skrócić
					if IsVehicleModel(vehicle, GetHashKey("fq2")) then
						AttachEntityToEntity(player, vehicle, -1, 0.0, -2.1, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)		
						RaiseConvertibleRoof(vehicle, false)
					elseif IsVehicleModel(vehicle, GetHashKey("dubsta")) then
						AttachEntityToEntity(player, vehicle, -1, 0.0, -2.0, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)	
						RaiseConvertibleRoof(vehicle, false)
					elseif IsVehicleModel(vehicle, GetHashKey("dubsta2")) then
						AttachEntityToEntity(player, vehicle, -1, 0.0, -2.0, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)	
						RaiseConvertibleRoof(vehicle, false)
					elseif	IsVehicleModel(vehicle, GetHashKey("habanero")) then 	
						AttachEntityToEntity(player, vehicle, -1, 0.0, -2.05, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)	
						RaiseConvertibleRoof(vehicle, false)
					elseif	IsVehicleModel(vehicle, GetHashKey("huntley")) then 	
						AttachEntityToEntity(player, vehicle, -1, 0.0, -1.9, 0.8, 0.0, 0.0, 0.0, false, false, false, false, 20, true)	
						RaiseConvertibleRoof(vehicle, false)
					elseif	IsVehicleModel(vehicle, GetHashKey("landstalker")) then 	
						AttachEntityToEntity(player, vehicle, -1, 0.0, -2.2, 0.85, 0.0, 0.0, 0.0, false, false, false, false, 20, true)	
						RaiseConvertibleRoof(vehicle, false)
					elseif	IsVehicleModel(vehicle, GetHashKey("radi")) then 	
						AttachEntityToEntity(player, vehicle, -1, 0.0, -2.0, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)	
						RaiseConvertibleRoof(vehicle, false)
					elseif	IsVehicleModel(vehicle, GetHashKey("rocoto")) then 	
						AttachEntityToEntity(player, vehicle, -1, 0.0, -2.1, 0.2, 0.0, 0.0, 0.0, false, false, false, false, 20, true)	
						RaiseConvertibleRoof(vehicle, false)
					elseif	IsVehicleModel(vehicle, GetHashKey("seminole")) then 	
						AttachEntityToEntity(player, vehicle, -1, 0.0, -2.1, 0.8, 0.0, 0.0, 0.0, false, false, false, false, 20, true)	
						RaiseConvertibleRoof(vehicle, false)
					elseif	IsVehicleModel(vehicle, GetHashKey("serrano")) then 	
						AttachEntityToEntity(player, vehicle, -1, 0.0, -2.1, 0.7, 0.0, 0.0, 0.0, false, false, false, false, 20, true)	
						RaiseConvertibleRoof(vehicle, false)
					elseif IsVehicleModel(vehicle, GetHashKey("rumpo3")) then
						AttachEntityToEntity(player, vehicle, -1, 0.0, -2.5, 0.1, 0.0, 0.0, 0.0, false, false, false, false, 20, true)		       		
					 RaiseConvertibleRoof(vehicle, false)
					elseif IsVehicleModel(vehicle, GetHashKey("minivan")) then
					AttachEntityToEntity(player, vehicle, -1, 0.0, -2.15, 0.25, 0.0, 0.0, 0.0, false, false, false, false, 20, true)		       		
					RaiseConvertibleRoof(vehicle, false)
					else
				   	AttachEntityToEntity(player, vehicle, -1, 0.0, -2.2, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)		       		
						RaiseConvertibleRoof(vehicle, false)
					end
					-- po wsadzeniu powiadomienie dla wsadzonego, że go ktoś wsadził
					  if IsEntityAttached(player) then
						
						ESX.ShowNotification('~r~Zostałeś wsadzony do bagażnika')
					   ClearPedTasksImmediately(player)
					   Citizen.Wait(500)
					   -- akcja animacja, gracz leży w bagażniku w pozycji embrionalnej	       			
					   TaskPlayAnim(player, 'timetable@floyd@cryingonbed@base', 'base', 1.0, -1, -1, 1, 0, 0, 0, 0)	
					   if not (IsEntityPlayingAnim(player, 'timetable@floyd@cryingonbed@base', 'base', 3) == 1) then
							 Streaming('timetable@floyd@cryingonbed@base', function()
							 TaskPlayAnim(playerPed, 'timetable@floyd@cryingonbed@base', 'base', 1.0, -1, -1, 49, 0, 0, 0, 0)
						  end)
				   end    
				   --jak wsadzili to true
				   inside = true 						         		
				   else
					-- jak sie coś zwaliło na pętli i nie wsadzili to false
				   inside = false
				   end   			
				   --jak gracz jest w bagażniku a nie poza to go wyjmij zamiast wsadzać
			   elseif inside and odpal then
				   DetachEntity(player, true, true)
				   SetEntityVisible(player, true, true)
				  	ClearPedTasks(player)   
				   inside = false
				   ClearAllHelpMessages()		    	
				   ESX.ShowNotification('~r~Zostałeś wyjęty z bagaznika')
			   end
			   Citizen.Wait(2000)
			   SetVehicleDoorShut(vehicle, 5, false)   
			   odpal = false	
		   end

		   Citizen.CreateThread(function()
			while true do
				Citizen.Wait(5)
	
				player = PlayerPedId()
				local plyCoords = GetEntityCoords(player, false)
				local vehicle = VehicleInFront()

			  
			  -- zablokowanie części interakcji dla osoby w bagażniku
			  if DoesEntityExist(vehicle) and inside then
					  car = GetEntityAttachedTo(player)
					  carxyz = GetEntityCoords(car, 0)
						 local visible = true
						 DisableAllControlActions(0)
						 DisableAllControlActions(1)
						 DisableAllControlActions(2)
						 EnableControlAction(0, 0, true) --- V - camera
					  EnableControlAction(0, 249, true) --- N - push to talk
					  EnableControlAction(0,245,true)	--- T chat
						 EnableControlAction(2, 1, true) --- camera moving
						 EnableControlAction(2, 2, true) --- camera moving	
						 EnableControlAction(0, 177, true) --- BACKSPACE
						 EnableControlAction(0, 200, true) --- ESC					
						     			
			  end  	
			end
		end)
		   
end)