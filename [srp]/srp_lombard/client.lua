local Keys = {
	["ESC"] = 322, ["BACKSPACE"] = 177, ["E"] = 38, ["ENTER"] = 18,	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173
}

ESX	= nil
local PlayerData = {}
local kordy1 = vector3(216.53, -1523.72, 28.29)
local kordy2 = vector3(-27.01, -1489.77, 29.36)
local kordy3 = vector3(-150.36, -1621.16, 32.65)
local kordy4 = vector3(54.39, -1873.13, 21.81)
local kordy5 = vector3(50.75, -1744.54, 29.01)
local kordy6 = vector3(330.09, -2095.36, 17.24)
local kordy7 = vector3(437.05, -1705.01, 28.26)
local kordy8 = vector3(254.71, -1722.05, 28.65)
local kordy9 = vector3(175.31, -1685.41, 28.66)
local kordy10 = vector3(43.59, -1600.86, 28.58)
local kordy11 = vector3(182.46, -1319.190, 28.30)
local ped = nil
local blip = nil
local lom1 = false
local lom2 = false
local lom3 = false
local lom4 = false
local lom5 = false
local deny_message = false
local seller_message = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	Citizen.Wait(5000)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(GetPlayerPed(-1))
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(10)
		if lom1 == true then
		local coords = GetEntityCoords(GetPlayerPed(-1))
		if(GetDistanceBetweenCoords(coords, kordy1, true) < 5.0) then
			ESX.ShowAdvancedNotification('Kupiec', '~y~Biżuteria', 'Użyj ~g~[~w~E~g~]~w~ aby sprzedać biżuterie! ', 'CHAR_ARTHUR', 3)
			local coords = GetEntityCoords(GetPlayerPed(-1))
				if IsControlJustReleased(0, Keys['E']) then
					lomb()
					--ESX.ShowNotification('Debug lombard')
					lom1 = false
					print('lombard 1')
					FreezeEntityPosition(ped, false)
					SetEntityInvincible(ped, false)
					RemoveBlip(blip)
				end	
		end -- od getdistance
	end -- od while
	
	if lom2 == true then
		local coords = GetEntityCoords(GetPlayerPed(-1))		
		if(GetDistanceBetweenCoords(coords, kordy2, true) < 5.0) then
			ESX.ShowAdvancedNotification('Kupiec', '~y~Biżuteria', 'Użyj ~g~[~w~E~g~]~w~ aby sprzedać biżuterie! ', 'CHAR_ARTHUR', 3)
			local coords = GetEntityCoords(GetPlayerPed(-1))
				if IsControlJustReleased(0, Keys['E']) then
					lomb()
					print('lombard 2')
					lom2 = false
					FreezeEntityPosition(ped, false)
					SetEntityInvincible(ped, false)
					RemoveBlip(blip)
				end		
		end -- od getdistance
	end -- od while
	
	if lom3 == true then
		local coords = GetEntityCoords(GetPlayerPed(-1))		
		if(GetDistanceBetweenCoords(coords, kordy3, true) < 5.0) then
			ESX.ShowAdvancedNotification('Kupiec', '~y~Biżuteria', 'Użyj ~g~[~w~E~g~]~w~ aby sprzedać biżuterie! ', 'CHAR_ARTHUR', 3)
			local coords = GetEntityCoords(GetPlayerPed(-1))
				if IsControlJustReleased(0, Keys['E']) then
					lomb()
					print('lombard 3')
					lom3 = false
					FreezeEntityPosition(ped, false)
					SetEntityInvincible(ped, false)
					RemoveBlip(blip)
				end			
		end -- od getdistance
	end -- od while
	
	if lom4 == true then
		local coords = GetEntityCoords(GetPlayerPed(-1))		
		if(GetDistanceBetweenCoords(coords, kordy4, true) < 5.0) then
			ESX.ShowAdvancedNotification('Kupiec', '~y~Biżuteria', 'Użyj ~g~[~w~E~g~]~w~ aby sprzedać biżuterie! ', 'CHAR_ARTHUR', 3)
			local coords = GetEntityCoords(GetPlayerPed(-1))
				if IsControlJustReleased(0, Keys['E']) then
					lomb()
					print('lombard 4')
					lom4 = false
					FreezeEntityPosition(ped, false)
					SetEntityInvincible(ped, false)
					RemoveBlip(blip)
				end	
		end -- od getdistance
	end -- od while

		if lom5 == true then
			local coords = GetEntityCoords(GetPlayerPed(-1))		
				if(GetDistanceBetweenCoords(coords, kordy5, true) < 5.0) then
					ESX.ShowAdvancedNotification('Kupiec', '~y~Biżuteria', 'Użyj ~g~[~w~E~g~]~w~ aby sprzedać biżuterie! ', 'CHAR_ARTHUR', 3)
					local coords = GetEntityCoords(GetPlayerPed(-1))
						if IsControlJustReleased(0, Keys['E']) then
							lomb()
							print('lombard 5')
							lom5 = false
							FreezeEntityPosition(ped, false)
							SetEntityInvincible(ped, false)
							RemoveBlip(blip)
						end
				end -- od getdistance
		end -- od while
	
	if lom6 == true then
		local coords = GetEntityCoords(GetPlayerPed(-1))
		if(GetDistanceBetweenCoords(coords, kordy6, true) < 5.0) then
			ESX.ShowAdvancedNotification('Kupiec', '~y~Biżuteria', 'Użyj ~g~[~w~E~g~]~w~ aby sprzedać biżuterie! ', 'CHAR_ARTHUR', 3)
			local coords = GetEntityCoords(GetPlayerPed(-1))
				if IsControlJustReleased(0, Keys['E']) then
					lomb()
					ESX.ShowNotification('Debug lombard')
					lom6 = false
					print('lombard 6')
					FreezeEntityPosition(ped, false)
					SetEntityInvincible(ped, false)
					RemoveBlip(blip)
				end		
		end -- od getdistance
	end -- od while
	
	if lom7 == true then
		local coords = GetEntityCoords(GetPlayerPed(-1))		
		if(GetDistanceBetweenCoords(coords, kordy7, true) < 5.0) then
			ESX.ShowAdvancedNotification('Kupiec', '~y~Biżuteria', 'Użyj ~g~[~w~E~g~]~w~ aby sprzedać biżuterie! ', 'CHAR_ARTHUR', 3)
			local coords = GetEntityCoords(GetPlayerPed(-1))
				if IsControlJustReleased(0, Keys['E']) then
					lomb()
					print('lombard 7')
					lom7 = false
					FreezeEntityPosition(ped, false)
					SetEntityInvincible(ped, false)
					RemoveBlip(blip)
				end		
		end -- od getdistance
	end -- od while
	
	if lom8 == true then
		local coords = GetEntityCoords(GetPlayerPed(-1))		
		if(GetDistanceBetweenCoords(coords, kordy8, true) < 5.0) then
			ESX.ShowAdvancedNotification('Kupiec', '~y~Biżuteria', 'Użyj ~g~[~w~E~g~]~w~ aby sprzedać biżuterie! ', 'CHAR_ARTHUR', 3)
			local coords = GetEntityCoords(GetPlayerPed(-1))
				if IsControlJustReleased(0, Keys['E']) then
					lomb()
					print('lombard 8')
					lom8 = false
					FreezeEntityPosition(ped, false)
					SetEntityInvincible(ped, false)
					RemoveBlip(blip)
				end		
		end -- od getdistance
	end -- od while
	
	if lom9 == true then
		local coords = GetEntityCoords(GetPlayerPed(-1))		
		if(GetDistanceBetweenCoords(coords, kordy9, true) < 5.0) then
			ESX.ShowAdvancedNotification('Kupiec', '~y~Biżuteria', 'Użyj ~g~[~w~E~g~]~w~ aby sprzedać biżuterie! ', 'CHAR_ARTHUR', 3)
			local coords = GetEntityCoords(GetPlayerPed(-1))
				if IsControlJustReleased(0, Keys['E']) then
					lomb()
					print('lombard 9')
					lom9 = false
					FreezeEntityPosition(ped, false)
					SetEntityInvincible(ped, false)
					RemoveBlip(blip)
			end		
		end -- od getdistance
	end -- od while

		if lom10 == true then
			local coords = GetEntityCoords(GetPlayerPed(-1))		
				if(GetDistanceBetweenCoords(coords, kordy10, true) < 5.0) then
					ESX.ShowAdvancedNotification('Kupiec', '~y~Biżuteria', 'Użyj ~g~[~w~E~g~]~w~ aby sprzedać biżuterie! ', 'CHAR_ARTHUR', 3)
					local coords = GetEntityCoords(GetPlayerPed(-1))
						if IsControlJustReleased(0, Keys['E']) then
							lomb()
							print('lombard 10')
							lom10 = false
							FreezeEntityPosition(ped, false)
							SetEntityInvincible(ped, false)
							RemoveBlip(blip)
						end
				end -- od getdistance
		end -- od while
	
	if lom11 == true then
		local coords = GetEntityCoords(GetPlayerPed(-1))		
			if(GetDistanceBetweenCoords(coords, kordy11, true) < 5.0) then
				ESX.ShowAdvancedNotification('Kupiec', '~y~Biżuteria', 'Użyj ~g~[~w~E~g~]~w~ aby sprzedać biżuterie! ', 'CHAR_ARTHUR', 3)
				local coords = GetEntityCoords(GetPlayerPed(-1))
					if IsControlJustReleased(0, Keys['E']) then
						lomb()
						print('lombard 11')
						lom11 = false
						FreezeEntityPosition(ped, false)
						SetEntityInvincible(ped, false)
						RemoveBlip(blip)
					end
			end -- od getdistance
		end-- od while
	end
end)


Citizen.CreateThread(function()
    while true do
        Wait(5)
        local coords = GetEntityCoords(GetPlayerPed(-1))
            local coords = GetEntityCoords(GetPlayerPed(-1))
            if (GetDistanceBetweenCoords(coords, 182.46, -1319.190, 28.70, true) < 1.5)  then
                --ESX.Game.Utils.DrawText3D({ x = 182.46, y = -1319.35, z = 28.45 }, '~y~[E] ~w~Lombard', 0.6)
				DrawText3D(182.46, -1319.190, 29.35, "~g~[E]~w~ Lombard")
                if(GetDistanceBetweenCoords(coords, 182.46, -1319.190, 28.70, true) < 2.0) then
                    if IsControlJustReleased(0, Keys['E']) then
                        if lom1 == false and lom2 == false and lom3 == false and lom4 == false and lom5 == false then
                            start()
                        end
                    end
                end
        end -- od getdistance
    end -- od while
end)

Citizen.CreateThread(function()
    while true do
        Wait(5)
        local coords = GetEntityCoords(GetPlayerPed(-1))
            local coords = GetEntityCoords(GetPlayerPed(-1))
            if textnadlomb == true then
				if(GetDistanceBetweenCoords(coords, 182.46, -1319.190, 28.70, true) < 2.0) then
					deny_message = true
					Citizen.Wait(4500)
					deny_message = false
					seller_message = true
					Citizen.Wait(2500)
					seller_message = false
				end                   
        end -- od getdistance
    end -- od while
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if deny_message == true then
            DrawText3D(182.46, -1319.190, 30.25, "~w~Spierdalaj nie chce tego gowna, ale znam kogos kto je kupi")
		end
		if seller_message == true then
			DrawText3D(182.46, -1319.190, 30.25, "~w~Trzymaj namiar")
		end
    end
end)

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

function start()	
local losowanko = math.random(1,11)
	if losowanko == 1 then

	--ESX.ShowNotification('Jedź do miejsca zaznaczonego na gps')
	exports['mythic_notify']:DoCustomHudText('inform', 'Jedź do miejsca zaznaczonego na GPS', 4000)
	SetNewWaypoint(kordy1)
	blip = AddBlipForCoord(kordy1)
	SetBlipSprite(blip, 480)
	SetBlipScale(blip, 1.0)

	SetBlipColour(blip, 70)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Lombard")
	spawnped(kordy1, 273.15, "a_m_m_rurmeth_01")
	EndTextCommandSetBlipName(blip)
	lom1 = true
	textnadlomb = true
	Citizen.Wait(8000)

	textnadlomb = false
	elseif losowanko == 2 then

		--ESX.ShowNotification('Jedź do miejsca zaznaczonego na gps')
		exports['mythic_notify']:DoCustomHudText('inform', 'Jedź do miejsca zaznaczonego na GPS', 4000)
			SetNewWaypoint(kordy2)
			blip = AddBlipForCoord(kordy2)
			SetBlipSprite(blip, 480)
			SetBlipScale(blip, 1.0)
			SetBlipColour(blip, 70)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Lombard")
				EndTextCommandSetBlipName(blip)
				spawnped(kordy2, 163.81, "a_m_y_soucent_02")
				lom2 = true
				textnadlomb = true
				Citizen.Wait(8000)
			
				textnadlomb = false
	elseif losowanko == 3 then

		--ESX.ShowNotification('Jedź do miejsca zaznaczonego na gps')
		exports['mythic_notify']:DoCustomHudText('inform', 'Jedź do miejsca zaznaczonego na GPS', 4000)
			SetNewWaypoint(kordy3)
			blip = AddBlipForCoord(kordy3)
			SetBlipSprite(blip, 480)
			SetBlipScale(blip, 1.0)
			SetBlipColour(blip, 70)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Lombard")
				EndTextCommandSetBlipName(blip)
				lom3 = true
				spawnped(kordy3, 163.81, "g_m_y_azteca_01")
				textnadlomb = true
				Citizen.Wait(8000)
			
				textnadlomb = false
	elseif losowanko == 4 then



		--ESX.ShowNotification('Jedź do miejsca zaznaczonego na gps')
		exports['mythic_notify']:DoCustomHudText('inform', 'Jedź do miejsca zaznaczonego na GPS', 4000)
			SetNewWaypoint(kordy4)
			blip = AddBlipForCoord(kordy4)
			SetBlipSprite(blip, 480)
			SetBlipScale(blip, 1.0)
			SetBlipColour(blip, 70)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Lombard")
				EndTextCommandSetBlipName(blip)
				lom4 = true
				spawnped(kordy4, 163.81, "g_m_y_ballaorig_01")
				textnadlomb = true
				Citizen.Wait(8000)
			
				textnadlomb = false
	elseif losowanko == 5 then

		--ESX.ShowNotification('Jedź do miejsca zaznaczonego na gps')
		exports['mythic_notify']:DoCustomHudText('inform', 'Jedź do miejsca zaznaczonego na GPS', 4000)
			SetNewWaypoint(kordy5)
			blip = AddBlipForCoord(kordy5)
			SetBlipSprite(blip, 480)
			SetBlipScale(blip, 1.0)
			SetBlipColour(blip, 70)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Lombard")
				EndTextCommandSetBlipName(blip)
				lom5 = true
				spawnped(kordy5, 46.08, "g_m_y_strpunk_02")
				textnadlomb = true
				Citizen.Wait(8000)
			
				textnadlomb = false
	
elseif losowanko == 6 then

	--ESX.ShowNotification('Jedź do miejsca zaznaczonego na gps')
	exports['mythic_notify']:DoCustomHudText('inform', 'Jedź do miejsca zaznaczonego na GPS', 4000)
		SetNewWaypoint(kordy6)
		blip = AddBlipForCoord(kordy6)
		SetBlipSprite(blip, 480)
		SetBlipScale(blip, 1.0)
		SetBlipColour(blip, 70)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Lombard")
			EndTextCommandSetBlipName(blip)
			spawnped(kordy6, 30.31, "g_m_y_salvagoon_03")
			lom6 = true
			textnadlomb = true
			Citizen.Wait(8000)
		
			textnadlomb = false
elseif losowanko == 7 then

	--ESX.ShowNotification('Jedź do miejsca zaznaczonego na gps')
	exports['mythic_notify']:DoCustomHudText('inform', 'Jedź do miejsca zaznaczonego na GPS', 4000)
		SetNewWaypoint(kordy7)
		blip = AddBlipForCoord(kordy7)
		SetBlipSprite(blip, 480)
		SetBlipScale(blip, 1.0)
		SetBlipColour(blip, 70)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Lombard")
			EndTextCommandSetBlipName(blip)
			lom7 = true
			spawnped(kordy7, 30.31, "mp_m_exarmy_01")
			textnadlomb = true
			Citizen.Wait(8000)
		
			textnadlomb = false
elseif losowanko == 8 then

	--ESX.ShowNotification('Jedź do miejsca zaznaczonego na gps')
	exports['mythic_notify']:DoCustomHudText('inform', 'Jedź do miejsca zaznaczonego na GPS', 4000)
		SetNewWaypoint(kordy8)
		blip = AddBlipForCoord(kordy8)
		SetBlipSprite(blip, 480)
		SetBlipScale(blip, 1.0)
		SetBlipColour(blip, 70)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Lombard")
			EndTextCommandSetBlipName(blip)
			lom8 = true
			spawnped(kordy8, 30.31, "s_m_m_autoshop_01")
			textnadlomb = true
			Citizen.Wait(8000)
		
			textnadlomb = false
elseif losowanko == 9 then

	--ESX.ShowNotification('Jedź do miejsca zaznaczonego na gps')
	exports['mythic_notify']:DoCustomHudText('inform', 'Jedź do miejsca zaznaczonego na GPS', 4000)
		SetNewWaypoint(kordy9)
		blip = AddBlipForCoord(kordy9)
		SetBlipSprite(blip, 480)
		SetBlipScale(blip, 1.0)
		SetBlipColour(blip, 70)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Lombard")
			EndTextCommandSetBlipName(blip)
			lom9 = true
			spawnped(kordy9, 219.71, "s_m_y_doorman_01")
			textnadlomb = true
			Citizen.Wait(8000)
		
			textnadlomb = false
		elseif losowanko == 10 then

			--ESX.ShowNotification('Jedź do miejsca zaznaczonego na gps')
			exports['mythic_notify']:DoCustomHudText('inform', 'Jedź do miejsca zaznaczonego na GPS', 4000)
				SetNewWaypoint(kordy10)
				blip = AddBlipForCoord(kordy10)
				SetBlipSprite(blip, 480)
				SetBlipScale(blip, 1.0)
				SetBlipColour(blip, 70)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString("Lombard")
					EndTextCommandSetBlipName(blip)
					lom10 = true
					spawnped(kordy10, 142.37, "s_m_y_xmech_02")
					textnadlomb = true
					Citizen.Wait(8000)
				
					textnadlomb = false
				elseif losowanko == 11 then

					--ESX.ShowNotification('Jedź do miejsca zaznaczonego na gps')
					exports['mythic_notify']:DoCustomHudText('inform', 'Jedź do miejsca zaznaczonego na GPS', 4000)
						SetNewWaypoint(kordy11)
						blip = AddBlipForCoord(kordy11)
						SetBlipSprite(blip, 480)
						SetBlipScale(blip, 1.0)
						SetBlipColour(blip, 70)
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString("Lombard")
							EndTextCommandSetBlipName(blip)
							lom11 = true
							spawnped(kordy11,210.05 )
							textnadlomb = true
							Citizen.Wait(8000)
						
							textnadlomb = false
end

end

RegisterNetEvent('delete:pedlombard')
AddEventHandler('delete:pedlombard', function()
	DeleteObject(ped)
end)


function lomb()
	TriggerServerEvent('smerfik:lombardtest')
end

RegisterNetEvent('lombard:again')
AddEventHandler('lombard:again', function()
	start()
end)

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(10)
	end
end

local ped = nil
local pe = nil
function spawnped(x, y, z, h, p)

		pe = p


	RequestModel(GetHashKey(pe))
while not HasModelLoaded(GetHashKey(pe)) do
	Wait(155)
end
	
 ped =  CreatePed(4, GetHashKey(pe), x, y, z, h, false, true)
	FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	print("spawned ped2")

	SetEntityHeading(ped, h)

end

RegisterNetEvent('notif:lombard')
AddEventHandler('notif:lombard', function()
	Citizen.Wait(10000)
	ESX.ShowAdvancedNotification('Kupiec', '~y~Biżuteria','Jedź do kolejnego sprzedawcy (zaznaczono na gps)! ', 'CHAR_ARTHUR', 3)
end)

RegisterNetEvent('usunpeda:lobard')
AddEventHandler('usunpeda:lobard', function()
	FreezeEntityPosition(ped, false)
	TaskPedSlideToCoord(ped, 100, 100, 50, 50, true)
	Citizen.Wait(15000)
	DeleteEntity(ped)
end)

Citizen.CreateThread(function()
	RequestModel(GetHashKey("a_m_m_og_boss_01"))
	while not HasModelLoaded(GetHashKey("a_m_m_og_boss_01")) do
		Wait(155)
	end

	local pedz =  CreatePed(4, GetHashKey("a_m_m_og_boss_01"), 182.46, -1319.35, 28.40, 202.95, false, true)
	FreezeEntityPosition(pedz, true)
	SetEntityInvincible(pedz, true)
	SetBlockingOfNonTemporaryEvents(pedz, true)
end)