--blip
	local autorepairblipMR = AddBlipForCoord(1150.18, -777.67, 56.60)
	SetBlipSprite (autorepairblipMR, 402)
	SetBlipDisplay(autorepairblipMR, 4)
	SetBlipScale (autorepairblipMR, 1.2)
	SetBlipColour (autorepairblipMR, 4)

	SetBlipAsShortRange(autorepairblipMR, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Auto Repair - Park Mirror')
	EndTextCommandSetBlipName(autorepairblipMR)

	local autorepairblipSS = AddBlipForCoord(1765.59, 3327.85, 41.44)
	SetBlipSprite (autorepairblipSS, 402)
	SetBlipDisplay(autorepairblipSS, 4)
	SetBlipScale (autorepairblipSS, 1.2)
	SetBlipColour (autorepairblipSS, 4)

	SetBlipAsShortRange(autorepairblipSS, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('FlyWheel - Sandy Shores')
	EndTextCommandSetBlipName(autorepairblipSS)

	local autorepairblipPaleto = AddBlipForCoord(110.14, 6626.74, 31.79)
	SetBlipSprite (autorepairblipPaleto, 402)
	SetBlipDisplay(autorepairblipPaleto, 4)
	SetBlipScale (autorepairblipPaleto, 1.2)
	SetBlipColour (autorepairblipPaleto, 4)

	SetBlipAsShortRange(autorepairblipPaleto, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Beeker\'s Garage - Paleto Bay')
	EndTextCommandSetBlipName(autorepairblipPaleto)

	local autorepairblipAirPort = AddBlipForCoord(-1154.09, -2006.90, 13.18)
	SetBlipSprite (autorepairblipAirPort, 402)
	SetBlipDisplay(autorepairblipAirPort, 4)
	SetBlipScale (autorepairblipAirPort, 1.2)
	SetBlipColour (autorepairblipAirPort, 4)

	SetBlipAsShortRange(autorepairblipAirPort, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Los Santos Customs - Airport')
	EndTextCommandSetBlipName(autorepairblipAirPort)

quickKey = 38 --- E
fuel = 0
finishedfuel = 100


local ESX = nil
local PlayerData                = {}
--MR
repairing = false 
stage1 = false 
stage2 = false 
stage3 = false
stage4 = false 
stage5 = false 
stage6 = false 
paynotification = false
locked = false 
unlocked = false 
vehcheck = false 
insidemarkercheck = false
-- SS
repairingSS = false 
stage1SS = false 
stage2SS = false 
stage3SS = false
stage4SS = false 
stage5SS = false 
stage6SS = false 
paynotificationSS = false
lockedSS = false 
unlockedSS = false 
vehcheckSS = false 
insidemarkercheckSS = false
-- PB
repairingPB = false 
stage1PB = false 
stage2PB = false 
stage3PB = false
stage4PB = false 
stage5PB = false 
stage6PB = false 
paynotificationPB = false
lockedPB = false 
unlockedPB = false 
vehcheckPB = false 
insidemarkercheckPB = false
-- AirPort
repairingAirPort = false 
stage1AirPort = false 
stage2AirPort = false 
stage3AirPort = false
stage4AirPort = false 
stage5AirPort = false 
stage6AirPort = false 
paynotificationAirPort = false
lockedAirPort = false 
unlockedAirPort = false 
vehcheckAirPort = false 
insidemarkercheckAirPort = false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while repairing == true or repairing == true do
		SetVehicleUndriveable(vehicle,true)
		Citizen.Wait(0)
	end
end)

RepairStationMP = {
	{1150.18, -777.67, 56.60}
}

RepairStationSS = {
	{1765.59, 3327.85, 40.44}
}

RepairStationPB = {
	{110.14, 6626.74, 30.79}
}

RepairStationAirPort = {
	{-1154.09, -2006.90, 12.18}
}

function DrawSpecialText(m_text, showtime)
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then 
			for i = 1, #RepairStationMP do
				garageCoords2 = RepairStationMP[i]
				DrawMarker(27, garageCoords2[1], garageCoords2[2], garageCoords2[3] + 0.02, 0, 0, 0, 0, 0, 0, 4.0, 4.0, 3.0, 0, 255, 0, 50, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), garageCoords2[1], garageCoords2[2], garageCoords2[3], true ) < 5--[[ and PlayerData.job ~= nil and PlayerData.job.name == 'zwierzako']] then
				Draw3DText(garageCoords2[1], garageCoords2[2], garageCoords2[3] + 1.0, tostring("~w~[~g~E~w~] Aby otworzyć menu warsztatu"))
				--ESX.ShowHelpNotification('Naciśnij ~INPUT_CONTEXT~ aby otworzyć menu warsztatu')
					if(IsControlJustPressed(1, quickKey)) then
						AutoRepair()
						insidemarkercheck = true
					end
				end
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), garageCoords2[1], garageCoords2[2], garageCoords2[3], true ) > 2--[[ and PlayerData.job ~= nil and PlayerData.job.name == 'zwierzako']] then
					    if ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'civrepair_menu') then
       						ESX.UI.Menu.CloseAll()
   					end
				end
			end
			for i = 1, #RepairStationSS do
				garageSS = RepairStationSS[i]
				DrawMarker(27, garageSS[1], garageSS[2], garageSS[3] + 0.02, 0, 0, 0, 0, 0, 0, 4.0, 4.0, 3.0, 0, 255, 0, 50, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), garageSS[1], garageSS[2], garageSS[3], true ) < 5--[[ and PlayerData.job ~= nil and PlayerData.job.name == 'zwierzako']] then
				Draw3DText(garageSS[1], garageSS[2], garageSS[3] + 1.0, tostring("~w~[~g~E~w~] Aby otworzyć menu warsztatu"))
				--ESX.ShowHelpNotification('Naciśnij ~INPUT_CONTEXT~ aby otworzyć menu warsztatu')
					if(IsControlJustPressed(1, quickKey)) then
						AutoRepairSS()
						insidemarkercheckSS = true
					end
				end
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), garageSS[1], garageSS[2], garageSS[3], true ) > 2--[[ and PlayerData.job ~= nil and PlayerData.job.name == 'zwierzako']] then
					    if ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'repairmenu_sandy') then
       						ESX.UI.Menu.CloseAll()
   					end
				end
			end
			for i = 1, #RepairStationPB do
				garagePB = RepairStationPB[i]
				DrawMarker(27, garagePB[1], garagePB[2], garagePB[3] + 0.02, 0, 0, 0, 0, 0, 0, 4.0, 4.0, 3.0, 0, 255, 0, 50, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), garagePB[1], garagePB[2], garagePB[3], true ) < 5--[[ and PlayerData.job ~= nil and PlayerData.job.name == 'zwierzako']] then
				Draw3DText(garagePB[1], garagePB[2], garagePB[3] + 1.0, tostring("~w~[~g~E~w~] Aby otworzyć menu warsztatu"))
				--ESX.ShowHelpNotification('Naciśnij ~INPUT_CONTEXT~ aby otworzyć menu warsztatu')
					if(IsControlJustPressed(1, quickKey)) then
						AutoRepairPB()
						insidemarkercheckPB = true
					end
				end
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), garagePB[1], garagePB[2], garagePB[3], true ) > 2--[[ and PlayerData.job ~= nil and PlayerData.job.name == 'zwierzako']] then
					    if ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'repairmenu_paleto') then
       						ESX.UI.Menu.CloseAll()
   					end
				end
			end
			for i = 1, #RepairStationAirPort do
				garageAirPort = RepairStationAirPort[i]
				DrawMarker(27, garageAirPort[1], garageAirPort[2], garageAirPort[3] + 0.02, 0, 0, 0, 0, 0, 0, 4.0, 4.0, 3.0, 0, 255, 0, 50, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), garageAirPort[1], garageAirPort[2], garageAirPort[3], true ) < 5--[[ and PlayerData.job ~= nil and PlayerData.job.name == 'zwierzako']] then
				Draw3DText(garageAirPort[1], garageAirPort[2], garageAirPort[3] + 1.0, tostring("~w~[~g~E~w~] Aby otworzyć menu warsztatu"))
				--ESX.ShowHelpNotification('Naciśnij ~INPUT_CONTEXT~ aby otworzyć menu warsztatu')
					if(IsControlJustPressed(1, quickKey)) then
						AutoRepairAirPort()
						insidemarkercheckAirPort = true
					end
				end
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), garageAirPort[1], garageAirPort[2], garageAirPort[3], true ) > 2--[[ and PlayerData.job ~= nil and PlayerData.job.name == 'zwierzako']] then
					    if ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'repairmenu_airport') then
       						ESX.UI.Menu.CloseAll()
   					end
				end
			end
		end
	end
end)
local menuEnabled = false 
function ToggleActionMenu()
	menuEnabled = not menuEnabled

	if ( menuEnabled ) then 
		SetNuiFocus( true, true )
		SendNUIMessage({
			showmenu = true 
		})
	else 
		SetNuiFocus( false )
		SendNUIMessage({
			hidemenu = true 
		})
	end 
end 


-- Park Mirror
Citizen.CreateThread(function()
	while true do
			local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local markerPos = { 1153.9860839844, -781.12658691406, 57.798682403564 }
	local distance = Vdist(plyPos.x, plyPos.y, plyPos.z, 1153.9860839844,  -781.12658691406, 57.798682403564)
if distance < 9 then
   insidemarkercheck = true
end

if distance > 9 then
   insidemarkercheck = false
end
if insidemarkercheck == true and stage1 == false and stage2 == false and stage3 == false and stage4 == false and stage5 == false and stage6 == false then

end

if insidemarkercheck == false and stage1 == false and stage2 == false and stage3 == false and stage4 == false and stage5 == false and stage6 == false then

end

if insidemarkercheck == true and stage1 == true and stage2 == false and stage3 == false and stage4 == false and stage5 == false and stage6 == false then
 Draw3DText(1153.9860839844, -781.12658691406, 57.598682403564 + 0.1, tostring("~w~Mechanicy zajmuja się Twoim pojazdem ~o~Poczekaj chwilę"))
  Draw3DText2(1153.9860839844, -781.12658691406, 57.598682403564, tostring("~w~Przybliżony procent naprawy: ~r~25%"))
    Draw3DText2(1153.9860839844, -781.12658691406, 57.598682403564 - 0.1, tostring("~w~Sprawdzanie uszkodzeń Twojego pojazdu.."))
end

if insidemarkercheck == true and stage1 == false and stage2 == true and stage3 == false and stage4 == false and stage5 == false and stage6 == false then
 Draw3DText(1153.9860839844, -781.12658691406, 57.598682403564 + 0.1, tostring("~w~Mechanicy zajmuja się Twoim pojazdem ~o~Poczekaj chwilę"))
 Draw3DText2(1153.9860839844, -781.12658691406, 57.598682403564, tostring("~w~Przybliżony procent naprawy: ~o~45%"))
 Draw3DText2(1153.9860839844, -781.12658691406, 57.598682403564 - 0.1, tostring("~w~Sprawdzanie oraz naprawa silnika.."))
end 

if insidemarkercheck == true and stage1 == false and stage2 == false and stage3 == true and stage4 == false and stage5 == false and stage6 == false then
 Draw3DText(1153.9860839844, -781.12658691406, 57.598682403564 + 0.1, tostring("~w~Mechanicy zajmuja się Twoim pojazdem ~o~Poczekaj chwilę"))
 Draw3DText2(1153.9860839844, -781.12658691406, 57.598682403564, tostring("~w~Przybliżony procent naprawy: ~o~60%"))
 Draw3DText2(1153.9860839844, -781.12658691406, 57.598682403564 - 0.1, tostring("~w~Sprawdzanie oraz naprawa skrzyni biegów.."))
end 


if insidemarkercheck == true and stage1 == false and stage2 == false and stage3 == false and stage4 == true and stage5 == false and stage6 == false then
 Draw3DText(1153.9860839844, -781.12658691406, 57.598682403564 + 0.1, tostring("~w~Mechanicy zajmuja się Twoim pojazdem ~o~Poczekaj chwilę"))
 Draw3DText2(1153.9860839844, -781.12658691406, 57.598682403564, tostring("~w~Przybliżony procent naprawy: ~g~85%"))
 Draw3DText2(1153.9860839844, -781.12658691406, 57.598682403564 - 0.1, tostring("~w~Sprawdzanie poziomu płynów eksploatacyjnych.."))
end 

if insidemarkercheck == true and stage1 == false and stage2 == false and stage3 == false and stage4 == false and stage5 == true and stage6 == false then
 Draw3DText(1153.9860839844, -781.12658691406, 57.598682403564 + 0.1, tostring("~w~Mechanicy zajmuja się Twoim pojazdem ~o~Poczekaj chwilę"))
 Draw3DText2(1153.9860839844, -781.12658691406, 57.598682403564, tostring("~w~Przybliżony procent naprawy: ~g~95%"))
 Draw3DText2(1153.9860839844, -781.12658691406, 57.598682403564 - 0.1, tostring("~w~Wytarcie karoserii z kurzu.."))
end 

if insidemarkercheck == true and stage1 == false and stage2 == false and stage3 == false and stage4 == false and stage5 == false and stage6 == true then
 Draw3DText(1153.9860839844, -781.12658691406, 57.598682403564 + 0.1, tostring("~w~Pojazd został naprawiony ~g~Możesz już odjechać ze stanowiska"))
Draw3DText2(1153.9860839844, -781.12658691406, 57.598682403564, tostring("~w~Przybliżony procent naprawy: ~g~100%"))
--Draw3DText2(1153.9860839844, -781.12658691406, 57.598682403564 - 0.1, tostring("~w~Samochód gotowy do odbioru!"))
end 

		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)

if stage1 == true then
         
     end
if stage2 == true then
	        
	     end
if stage3 == true then

end

if stage4 == true then

end

if locked == true then
--Draw3DText2(plyPos.x, plyPos.y, plyPos.z + 0.2, tostring('~w~Vehicle has been ~r~locked'))
end

if unlocked == true then
--Draw3DText2(plyPos.x, plyPos.y, plyPos.z + 0.2, tostring('~w~Vehicle has been ~g~Unlocked'))
end

if vehcheck == true then
	if IsControlJustPressed(0, 38) then
		SetVehicleDoorsLocked(vehicle, 2)
		stage6 = false
		locked = true
		Citizen.Wait(4000)
		locked = false
	end
end

if stage5 == true then

end

if payalert == true then
Draw3DText2(plyPos.x, plyPos.y, plyPos.z + 0.2, tostring('~w~Mechanicy za chwile zajmą się Twoim pojazdem'))

end

if paynotification == true then

Draw3DText2(plyPos.x, plyPos.y, plyPos.z + 0.2, tostring('~w~Płacenie kartą ~w~za naprawę'))
end

if stage6 == true then
Draw3DText(plyPos.x, plyPos.y, plyPos.z + 0.2, tostring("~w~Twój pojazd jest gotowy do odbioru"))
--Draw3DText2(plyPos.x, plyPos.y, plyPos.z + 0.1, tostring("~w~Nacisnij ~r~E~w~ to lock Your vehicle at the shop"))
end

if stage7 == true then
--Draw3DText(plyPos.x, plyPos.y, plyPos.z, tostring("~r~This is a test message stage 7"))
end
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('srp_repairLSC:success')
AddEventHandler('srp_repairLSC:success', function(price)
	local ped = GetPlayerPed(-1)
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
	local veh = GetClosestVehicle(x, y, z, 4.001, 0, 70)
	local veh2 = GetVehiclePedIsIn (GetPlayerPed (-1), true)
	local lastcar = GetPlayersLastVehicle(GetPlayerPed (-1))
	local theshop = 1153.9686279297, -781.44641113281,57.598697662354
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local seconds = 1000 --- Seconds
	local minute = 60 * seconds -- Minutes
	local stage1period = 40 * seconds
	local stage2period = 3 * seconds
	local stage3period = 40 * seconds
	local stage4period = 6 * seconds
	local stage5period = 3 * seconds
	local stage6period = 5 * seconds
	local stage7period = 10 * seconds

	vehicle = GetVehiclePedIsIn(ped, false)
	SetVehicleDoorsLocked(vehicle, 2)
	TaskLeaveVehicle(ped, vehicle, 1)
	SetVehicleUndriveable(veh2, true)

	paynotification = true
	Citizen.Wait(3000)
	paynotification = false 
	payalert = true 
	Citizen.Wait(3000)
	payalert = false 

	stage1 = true 
    SetVehicleDoorOpen(veh2, 4, false, false)
    Citizen.Wait(stage1period)
    stage1 = false
    stage2 = true
    Citizen.Wait(stage2period)
    stage2 = false 
    stage3 = true
    Citizen.Wait(stage3period)
    stage3 = false 
    stage4 = true  
    Citizen.Wait(stage5period)
    stage4 = false
    stage5 = true
	Citizen.Wait(stage6period)
	
	SetVehicleFixed(veh2)
	SetVehicleDirtLevel(GetVehiclePedIsIn(GetPlayerPed(-1),  false),  0.0000000001)
    SetVehicleEngineHealth( veh2, 1000 )
    SetVehicleEngineOn( veh2, true, true )
    SetVehicleFixed( veh2 ) 
	SetVehicleDoorsLocked(veh2, 1)
	SetVehicleUndriveable(veh, false)
	SetVehicleUndriveable(GetVehiclePedIsUsing(GetPlayerPed(-1)), false)
	stage5 = false
	stage6 = true
	vehcheck = true
	Citizen.Wait(2000)
	exports['mythic_notify']:DoCustomHudText('inform', 'Twój pojazd jest gotowy do odbioru', 4000)
--  stage7 = true
	--Citizen.Wait(stage7period)
	stage6 = false
	vehcheck = false
	DrawSpecialText(msg, 2000)
	Wait(2000)
end)

RegisterNetEvent('srp_repairLSC:successpremium')
AddEventHandler('srp_repairLSC:successpremium', function(price)
local ped = GetPlayerPed(-1)
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
	local veh = GetClosestVehicle(x, y, z, 4.001, 0, 70)
	local veh2 = GetVehiclePedIsIn (GetPlayerPed (-1), true)
	local lastcar = GetPlayersLastVehicle(GetPlayerPed (-1))
	local theshop = 1153.9686279297, -781.44641113281,57.598697662354
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local seconds = 1000 --- Seconds
	local minute = 60 * seconds -- Minutes
	local stage1period = 6 * seconds
	local stage2period = 3 * seconds
	local stage3period = 6 * seconds
	local stage4period = 3 * seconds
	local stage5period = 3 * seconds
	local stage6period = 3 * seconds
	local stage7period = 10 * seconds

	vehicle = GetVehiclePedIsIn(ped, false)
	SetVehicleDoorsLocked(vehicle, 2) 
	TaskLeaveVehicle(ped, vehicle, 1)
	SetVehicleUndriveable(veh2, true)

	paynotification = true
	Citizen.Wait(3000)
	paynotification = false 
	payalert = true 
	Citizen.Wait(3000)
	payalert = false 

	stage1 = true  
    SetVehicleDoorOpen(veh2, 4, false, false) 
    Citizen.Wait(stage1period)
    stage1 = false
    stage2 = true 
    Citizen.Wait(stage2period)
    stage2 = false
    stage3 = true 
    Citizen.Wait(stage3period)
    stage3 = false 
    stage4 = true 
    Citizen.Wait(stage5period)
    stage4 = false 
    stage5 = true 
	Citizen.Wait(stage6period)
	
	SetVehicleFixed(veh2) 
	SetVehicleDirtLevel(GetVehiclePedIsIn(GetPlayerPed(-1),  false),  0.0000000001) 
    SetVehicleEngineHealth( veh2, 1000 )
    SetVehicleEngineOn( veh2, true, true ) 
    SetVehicleFixed( veh2 ) 
	SetVehicleDoorsLocked(veh2, 1) 
	SetVehicleUndriveable(veh, false) 
	SetVehicleUndriveable(GetVehiclePedIsUsing(GetPlayerPed(-1)), false) 
	stage5 = false 
	stage6 = true 
	vehcheck = true 
	Citizen.Wait(2000)
	exports['mythic_notify']:DoCustomHudText('inform', 'Twój pojazd jest gotowy do odbioru', 4000)
	--Citizen.Wait(stage7period)
	stage6 = false 
	vehcheck = false 
	DrawSpecialText(msg, 2000)
	Wait(2000)
end)

RegisterNetEvent('srp_repairLSC:notenoughmoney')
AddEventHandler('srp_repairLSC:notenoughmoney', function(moneyleft)
	exports['mythic_notify']:DoCustomHudText('error', 'Nie masz wystarczająco dużo pieniędzy w banku aby zakupić Pakiet Mini!', 3500)
	DrawSpecialText(msg, 5000)
	Wait(5000)
end)

RegisterNetEvent('srp_repairLSC:notenoughmoneypremium')
AddEventHandler('srp_repairLSC:notenoughmoneypremium', function(moneyleft)
	exports['mythic_notify']:DoCustomHudText('error', 'Nie masz wystarczająco dużo pieniędzy w banku aby kupić Pakiet Premium!', 3500)
	DrawSpecialText(msg, 5000)
	Wait(5000)
end)

function AutoRepair()
    local elements = {
        { label = 'Szybka Naprawa (Pakiet Premium) - <font color="green">$2500</font>', value = "repair_fast" },
        { label = 'Zwykła Naprawa (Pakiet Mini💤) - <font color="green">$500</font>', value = "repair_slow" }
    }
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'civrepair_menu',
        {
            title    = "<font-size='15px'>🔧Auto Repair - Park Mirror🔧</font>",
            align    = 'center',
            elements = elements
        },
    function(data, menu)
        local action = data.current.value
        if action == "repair_fast" then
             TriggerServerEvent('srp_repairLSC:checkmoneypremium')
        elseif action == "repair_slow" then
            TriggerServerEvent('srp_repairLSC:checkmoney')
        end
        menu.close()
    end, function(data, menu)
        menu.close()
    end)
end





--Sandy Shores
Citizen.CreateThread(function()
	while true do
			local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local markerPos = { 1765.49, 3332.63, 41.44 }
	local distance = Vdist(plyPos.x, plyPos.y, plyPos.z, 1765.49, 3332.63, 41.44)
if distance < 9 then
   insidemarkercheckSS = true
end

if distance > 9 then
   insidemarkercheckSS = false
end
if insidemarkercheckSS == true and stage1SS == false and stage2SS == false and stage3SS == false and stage4SS == false and stage5SS == false and stage6SS == false then

end

if insidemarkercheckSS == false and stage1SS == false and stage2SS == false and stage3SS == false and stage4SS == false and stage5SS == false and stage6SS == false then

end

if insidemarkercheckSS == true and stage1SS == true and stage2SS == false and stage3SS == false and stage4SS == false and stage5SS == false and stage6SS == false then
 Draw3DText(1765.49, 3332.63, 41.44 + 0.1, tostring("~w~Mechanicy zajmuja się Twoim pojazdem ~o~Poczekaj chwilę"))
  Draw3DText2(1765.49, 3332.63, 41.44, tostring("~w~Przybliżony procent naprawy: ~r~25%"))
    Draw3DText2(1765.49, 3332.63, 41.44 - 0.1, tostring("~w~Sprawdzanie uszkodzeń Twojego pojazdu.."))
end

if insidemarkercheckSS == true and stage1SS == false and stage2SS == true and stage3SS == false and stage4SS == false and stage5SS == false and stage6SS == false then
 Draw3DText(1765.49, 3332.63, 41.44 + 0.1, tostring("~w~Mechanicy zajmuja się Twoim pojazdem ~o~Poczekaj chwilę"))
 Draw3DText2(1765.49, 3332.63, 41.44, tostring("~w~Przybliżony procent naprawy: ~o~45%"))
 Draw3DText2(1765.49, 3332.63, 41.44 - 0.1, tostring("~w~Sprawdzanie oraz naprawa silnika.."))
end 

if insidemarkercheckSS == true and stage1SS == false and stage2SS == false and stage3SS == true and stage4SS == false and stage5SS == false and stage6SS == false then
 Draw3DText(1765.49, 3332.63, 41.44 + 0.1, tostring("~w~Mechanicy zajmuja się Twoim pojazdem ~o~Poczekaj chwilę"))
 Draw3DText2(1765.49, 3332.63, 41.44, tostring("~w~Przybliżony procent naprawy: ~o~60%"))
 Draw3DText2(1765.49, 3332.63, 41.44 - 0.1, tostring("~w~Sprawdzanie oraz naprawa skrzyni biegów.."))
end 


if insidemarkercheckSS == true and stage1SS == false and stage2SS == false and stage3SS == false and stage4SS == true and stage5SS == false and stage6SS == false then
 Draw3DText(1765.49, 3332.63, 41.44 + 0.1, tostring("~w~Mechanicy zajmuja się Twoim pojazdem ~o~Poczekaj chwilę"))
 Draw3DText2(1765.49, 3332.63, 41.44, tostring("~w~Przybliżony procent naprawy: ~g~85%"))
 Draw3DText2(1765.49, 3332.63, 41.44 - 0.1, tostring("~w~Sprawdzanie poziomu płynów eksploatacyjnych.."))
end 

if insidemarkercheckSS == true and stage1SS == false and stage2SS == false and stage3SS == false and stage4SS == false and stage5SS == true and stage6SS == false then
 Draw3DText(1765.49, 3332.63, 41.44 + 0.1, tostring("~w~Mechanicy zajmuja się Twoim pojazdem ~o~Poczekaj chwilę"))
 Draw3DText2(1765.49, 3332.63, 41.44, tostring("~w~Przybliżony procent naprawy: ~g~95%"))
 Draw3DText2(1765.49, 3332.63, 41.44 - 0.1, tostring("~w~Wytarcie karoserii z kurzu.."))
end 

if insidemarkercheckSS == true and stage1SS == false and stage2SS == false and stage3SS == false and stage4SS == false and stage5SS == false and stage6SS == true then
 Draw3DText(1765.49, 3332.63, 41.44 + 0.1, tostring("~w~Pojazd został naprawiony ~g~Możesz już odjechać ze stanowiska"))
Draw3DText2(1765.49, 3332.63, 41.44, tostring("~w~Przybliżony procent naprawy: ~g~100%"))
--Draw3DText2(1765.49, 3332.63, 41.44 - 0.1, tostring("~w~Samochód gotowy do odbioru!"))
end 

		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)

if stage1SS == true then
         
     end
if stage2SS == true then
	        
	     end
if stage3SS == true then

end

if stage4SS == true then

end

if lockedSS == true then
Draw3DText2(plyPos.x, plyPos.y, plyPos.z + 0.2, tostring('~w~Vehicle has been ~r~locked'))
end

if unlockedSS == true then
Draw3DText2(plyPos.x, plyPos.y, plyPos.z + 0.2, tostring('~w~Vehicle has been ~g~Unlocked'))
end

if vehcheckSS == true then
	if IsControlJustPressed(0, 38) then
		SetVehicleDoorsLocked(vehicle, 2)
		stage6SS = false
		lockedSS = true
		Citizen.Wait(4000)
		lockedSS = false
	end
end

if stage5SS == true then

end

if payalertSS == true then
Draw3DText2(plyPos.x, plyPos.y, plyPos.z + 0.2, tostring('~w~Mechanicy za chwile zajmą się Twoim pojazdem'))

end

if paynotificationSS == true then

Draw3DText2(plyPos.x, plyPos.y, plyPos.z + 0.2, tostring('~w~Płacenie kartą ~w~za naprawę'))
end

if stage6SS == true then
Draw3DText(plyPos.x, plyPos.y, plyPos.z + 0.2, tostring("~w~Twój pojazd jest gotowy do odbioru"))
--Draw3DText2(plyPos.x, plyPos.y, plyPos.z + 0.1, tostring("~w~Nacisnij ~r~E~w~ to lock Your vehicle at the shop"))
end

if stage7SS == true then
--Draw3DText(plyPos.x, plyPos.y, plyPos.z, tostring("~r~This is a test message stage 7"))
end
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('srp_repairLSC:successSS')
AddEventHandler('srp_repairLSC:successSS', function(price)
	local ped = GetPlayerPed(-1)
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
	local veh = GetClosestVehicle(x, y, z, 4.001, 0, 70)
	local veh2 = GetVehiclePedIsIn (GetPlayerPed (-1), true)
	local lastcar = GetPlayersLastVehicle(GetPlayerPed (-1))
	local theshop = 1765.49, 3332.63, 41.44
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local seconds = 1000 --- Seconds
	local minute = 60 * seconds -- Minutes
	local stage1SSperiod = 40 * seconds
	local stage2SSperiod = 3 * seconds
	local stage3SSperiod = 40 * seconds
	local stage4SSperiod = 6 * seconds
	local stage5SSperiod = 3 * seconds
	local stage6SSperiod = 5 * seconds
	local stage7SSperiod = 10 * seconds

	vehicle = GetVehiclePedIsIn(ped, false)
	SetVehicleDoorsLocked(vehicle, 2)
	TaskLeaveVehicle(ped, vehicle, 1)
	SetVehicleUndriveable(veh2, true)

	paynotificationSS = true
	Citizen.Wait(3000)
	paynotificationSS = false 
	payalertSS = true 
	Citizen.Wait(3000)
	payalertSS = false 

	stage1SS = true 
    SetVehicleDoorOpen(veh2, 4, false, false)
    Citizen.Wait(stage1SSperiod)
    stage1SS = false
    stage2SS = true
    Citizen.Wait(stage2SSperiod)
    stage2SS = false 
    stage3SS = true
    Citizen.Wait(stage3SSperiod)
    stage3SS = false 
    stage4SS = true  
    Citizen.Wait(stage5SSperiod)
    stage4SS = false
    stage5SS = true
	Citizen.Wait(stage6SSperiod)
	
	SetVehicleFixed(veh2)
	SetVehicleDirtLevel(GetVehiclePedIsIn(GetPlayerPed(-1),  false),  0.0000000001)
    SetVehicleEngineHealth( veh2, 1000 )
    SetVehicleEngineOn( veh2, true, true )
    SetVehicleFixed( veh2 ) 
	SetVehicleDoorsLocked(veh2, 1)
	SetVehicleUndriveable(veh, false)
	SetVehicleUndriveable(GetVehiclePedIsUsing(GetPlayerPed(-1)), false)
	stage5SS = false
	stage6SS = true
	vehcheckSS = true
	Citizen.Wait(2000)
	exports['mythic_notify']:DoCustomHudText('inform', 'Twój pojazd jest gotowy do odbioru', 4000)
--  stage7SS = true
	--Citizen.Wait(stage7SSperiod)
	stage6SS = false
	vehcheckSS = false
	DrawSpecialText(msg, 2000)
	Wait(2000)
end)

RegisterNetEvent('srp_repairLSC:successpremiumSS')
AddEventHandler('srp_repairLSC:successpremiumSS', function(price)
local ped = GetPlayerPed(-1)
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
	local veh = GetClosestVehicle(x, y, z, 4.001, 0, 70)
	local veh2 = GetVehiclePedIsIn (GetPlayerPed (-1), true)
	local lastcar = GetPlayersLastVehicle(GetPlayerPed (-1))
	local theshop = 1765.49, 3332.63, 41.44
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local seconds = 1000 --- Seconds
	local minute = 60 * seconds -- Minutes
	local stage1SSperiod = 6 * seconds
	local stage2SSperiod = 3 * seconds
	local stage3SSperiod = 6 * seconds
	local stage4SSperiod = 3 * seconds
	local stage5SSperiod = 3 * seconds
	local stage6SSperiod = 3 * seconds
	local stage7SSperiod = 10 * seconds

	vehicle = GetVehiclePedIsIn(ped, false)
	SetVehicleDoorsLocked(vehicle, 2) 
	TaskLeaveVehicle(ped, vehicle, 1)
	SetVehicleUndriveable(veh2, true)

	paynotificationSS = true
	Citizen.Wait(3000)
	paynotificationSS = false 
	payalertSS = true 
	Citizen.Wait(3000)
	payalertSS = false 

	stage1SS = true  
    SetVehicleDoorOpen(veh2, 4, false, false) 
    Citizen.Wait(stage1SSperiod)
    stage1SS = false
    stage2SS = true 
    Citizen.Wait(stage2SSperiod)
    stage2SS = false
    stage3SS = true 
    Citizen.Wait(stage3SSperiod)
    stage3SS = false 
    stage4SS = true 
    Citizen.Wait(stage5SSperiod)
    stage4SS = false 
    stage5SS = true 
	Citizen.Wait(stage6SSperiod)
	
	SetVehicleFixed(veh2) 
	SetVehicleDirtLevel(GetVehiclePedIsIn(GetPlayerPed(-1),  false),  0.0000000001) 
    SetVehicleEngineHealth( veh2, 1000 )
    SetVehicleEngineOn( veh2, true, true ) 
    SetVehicleFixed( veh2 ) 
	SetVehicleDoorsLocked(veh2, 1) 
	SetVehicleUndriveable(veh, false) 
	SetVehicleUndriveable(GetVehiclePedIsUsing(GetPlayerPed(-1)), false) 
	stage5SS = false 
	stage6SS = true 
	vehcheckSS = true 
	Citizen.Wait(2000)
	exports['mythic_notify']:DoCustomHudText('inform', 'Twój pojazd jest gotowy do odbioru', 4000)
	--Citizen.Wait(stage7SSperiod)
	stage6SS = false 
	vehcheckSS = false 
	DrawSpecialText(msg, 2000)
	Wait(2000)
end)

RegisterNetEvent('srp_repairLSC:notenoughmoneySS')
AddEventHandler('srp_repairLSC:notenoughmoneySS', function(moneyleft)
	exports['mythic_notify']:DoCustomHudText('error', 'Nie masz wystarczająco dużo pieniędzy w banku aby zakupić Pakiet Mini!', 3500)
	DrawSpecialText(msg, 5000)
	Wait(5000)
end)

RegisterNetEvent('srp_repairLSC:notenoughmoneypremiumSS')
AddEventHandler('srp_repairLSC:notenoughmoneypremiumSS', function(moneyleft)
	exports['mythic_notify']:DoCustomHudText('error', 'Nie masz wystarczająco dużo pieniędzy w banku aby kupić Pakiet Premium!', 3500)
	DrawSpecialText(msg, 5000)
	Wait(5000)
end)

function AutoRepairSS()
    local elements = {
        { label = 'Szybka Naprawa (Pakiet Premium) - <font color="green">$2500</font>', value = "repair_fastSS" },
        { label = 'Zwykła Naprawa (Pakiet Mini💤) - <font color="green">$500</font>', value = "repair_slowSS" }
    }
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'repairmenu_sandy',
        {
            title    = "<font-size='15px'>🔧FlyWheel - Sandy Shores🔧</font>",
            align    = 'center',
            elements = elements
        },
    function(data, menu)
        local action = data.current.value
        if action == "repair_fastSS" then
             TriggerServerEvent('srp_repairLSC:checkmoneypremiumSS')
        elseif action == "repair_slowSS" then
            TriggerServerEvent('srp_repairLSC:checkmoneySS')
        end
        menu.close()
    end, function(data, menu)
        menu.close()
    end)
end





-- Paleto Bay
Citizen.CreateThread(function()
	while true do
			local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local markerPos = { 106.53, 6628.81, 32.04 }
	local distance = Vdist(plyPos.x, plyPos.y, plyPos.z, 106.53, 6628.81, 32.04)
if distance < 9 then
   insidemarkercheckPB = true
end

if distance > 9 then
	insidemarkercheckPB = false
end
if insidemarkercheckPB == true and stage1PB == false and stage2PB == false and stage3PB == false and stage4PB == false and stage5PB == false and stage6PB == false then

end

if insidemarkercheckPB == false and stage1PB == false and stage2PB == false and stage3PB == false and stage4PB == false and stage5PB == false and stage6PB == false then

end

if insidemarkercheckPB == true and stage1PB == true and stage2PB == false and stage3PB == false and stage4PB == false and stage5PB == false and stage6PB == false then
 Draw3DText(106.53, 6628.81, 32.04 + 0.1, tostring("~w~Mechanicy zajmuja się Twoim pojazdem ~o~Poczekaj chwilę"))
  Draw3DText2(106.53, 6628.81, 32.04, tostring("~w~Przybliżony procent naprawy: ~r~25%"))
    Draw3DText2(106.53, 6628.81, 32.04 - 0.1, tostring("~w~Sprawdzanie uszkodzeń Twojego pojazdu.."))
end

if insidemarkercheckPB == true and stage1PB == false and stage2PB == true and stage3PB == false and stage4PB == false and stage5PB == false and stage6PB == false then
 Draw3DText(106.53, 6628.81, 32.04 + 0.1, tostring("~w~Mechanicy zajmuja się Twoim pojazdem ~o~Poczekaj chwilę"))
 Draw3DText2(106.53, 6628.81, 32.04, tostring("~w~Przybliżony procent naprawy: ~o~45%"))
 Draw3DText2(106.53, 6628.81, 32.04 - 0.1, tostring("~w~Sprawdzanie oraz naprawa silnika.."))
end 

if insidemarkercheckPB == true and stage1PB == false and stage2PB == false and stage3PB == true and stage4PB == false and stage5PB == false and stage6PB == false then
 Draw3DText(106.53, 6628.81, 32.04 + 0.1, tostring("~w~Mechanicy zajmuja się Twoim pojazdem ~o~Poczekaj chwilę"))
 Draw3DText2(106.53, 6628.81, 32.04, tostring("~w~Przybliżony procent naprawy: ~o~60%"))
 Draw3DText2(106.53, 6628.81, 32.04 - 0.1, tostring("~w~Sprawdzanie oraz naprawa skrzyni biegów.."))
end 


if insidemarkercheckPB == true and stage1PB == false and stage2PB == false and stage3PB == false and stage4PB == true and stage5PB == false and stage6PB == false then
 Draw3DText(106.53, 6628.81, 32.04 + 0.1, tostring("~w~Mechanicy zajmuja się Twoim pojazdem ~o~Poczekaj chwilę"))
 Draw3DText2(106.53, 6628.81, 32.04, tostring("~w~Przybliżony procent naprawy: ~g~85%"))
 Draw3DText2(106.53, 6628.81, 32.04 - 0.1, tostring("~w~Sprawdzanie poziomu płynów eksploatacyjnych.."))
end 

if insidemarkercheckPB == true and stage1PB == false and stage2PB == false and stage3PB == false and stage4PB == false and stage5PB == true and stage6PB == false then
 Draw3DText(106.53, 6628.81, 32.04 + 0.1, tostring("~w~Mechanicy zajmuja się Twoim pojazdem ~o~Poczekaj chwilę"))
 Draw3DText2(106.53, 6628.81, 32.04, tostring("~w~Przybliżony procent naprawy: ~g~95%"))
 Draw3DText2(106.53, 6628.81, 32.04 - 0.1, tostring("~w~Wytarcie karoserii z kurzu.."))
end 

if insidemarkercheckPB == true and stage1PB == false and stage2PB == false and stage3PB == false and stage4PB == false and stage5PB == false and stage6PB == true then
 Draw3DText(106.53, 6628.81, 32.04 + 0.1, tostring("~w~Pojazd został naprawiony ~g~Możesz już odjechać ze stanowiska"))
Draw3DText2(106.53, 6628.81, 32.04, tostring("~w~Przybliżony procent naprawy: ~g~100%"))
--Draw3DText2(106.53, 6628.81, 32.04 - 0.1, tostring("~w~Samochód gotowy do odbioru!"))
end 

		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)

if stage1PB == true then
         
     end
if stage2PB == true then
	        
	     end
if stage3PB == true then

end

if stage4PB == true then

end

if lockedPB == true then
Draw3DText2(plyPos.x, plyPos.y, plyPos.z + 0.2, tostring('~w~Vehicle has been ~r~locked'))
end

if unlockedPB == true then
Draw3DText2(plyPos.x, plyPos.y, plyPos.z + 0.2, tostring('~w~Vehicle has been ~g~Unlocked'))
end

if vehcheckPB == true then
	if IsControlJustPressed(0, 38) then
		SetVehicleDoorsLocked(vehicle, 2)
		stage6PB = false
		lockedPB = true
		Citizen.Wait(4000)
		lockedPB = false
	end
end

if stage5PB == true then

end

if payalertPB == true then
Draw3DText2(plyPos.x, plyPos.y, plyPos.z + 0.2, tostring('~w~Mechanicy za chwile zajmą się Twoim pojazdem'))

end

if paynotificationPB == true then

Draw3DText2(plyPos.x, plyPos.y, plyPos.z + 0.2, tostring('~w~Płacenie kartą ~w~za naprawę'))
end

if stage6PB == true then
Draw3DText(plyPos.x, plyPos.y, plyPos.z + 0.2, tostring("~w~Twój pojazd jest gotowy do odbioru"))
--Draw3DText2(plyPos.x, plyPos.y, plyPos.z + 0.1, tostring("~w~Nacisnij ~r~E~w~ to lock Your vehicle at the shop"))
end

if stage7PB == true then
--Draw3DText(plyPos.x, plyPos.y, plyPos.z, tostring("~r~This is a test message stage 7"))
end
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('srp_repairLSC:successPB')
AddEventHandler('srp_repairLSC:successPB', function(price)
	local ped = GetPlayerPed(-1)
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
	local veh = GetClosestVehicle(x, y, z, 4.001, 0, 70)
	local veh2 = GetVehiclePedIsIn (GetPlayerPed (-1), true)
	local lastcar = GetPlayersLastVehicle(GetPlayerPed (-1))
	local theshop = 1765.49, 3332.63, 41.44
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local seconds = 1000 --- Seconds
	local minute = 60 * seconds -- Minutes
	local stage1PBperiod = 40 * seconds
	local stage2PBperiod = 3 * seconds
	local stage3PBperiod = 40 * seconds
	local stage4PBperiod = 6 * seconds
	local stage5PBperiod = 3 * seconds
	local stage6PBperiod = 5 * seconds
	local stage7PBperiod = 10 * seconds

	vehicle = GetVehiclePedIsIn(ped, false)
	SetVehicleDoorsLocked(vehicle, 2)
	TaskLeaveVehicle(ped, vehicle, 1)
	SetVehicleUndriveable(veh2, true)

	paynotificationPB = true
	Citizen.Wait(3000)
	paynotificationPB = false 
	payalertPB = true 
	Citizen.Wait(3000)
	payalertPB = false 

	stage1PB = true 
    SetVehicleDoorOpen(veh2, 4, false, false)
    Citizen.Wait(stage1PBperiod)
    stage1PB = false
    stage2PB = true
    Citizen.Wait(stage2PBperiod)
    stage2PB = false 
    stage3PB = true
    Citizen.Wait(stage3PBperiod)
    stage3PB = false 
    stage4PB = true  
    Citizen.Wait(stage5PBperiod)
    stage4PB = false
    stage5PB = true
	Citizen.Wait(stage6PBperiod)
	
	SetVehicleFixed(veh2)
	SetVehicleDirtLevel(GetVehiclePedIsIn(GetPlayerPed(-1),  false),  0.0000000001)
    SetVehicleEngineHealth( veh2, 1000 )
    SetVehicleEngineOn( veh2, true, true )
    SetVehicleFixed( veh2 ) 
	SetVehicleDoorsLocked(veh2, 1)
	SetVehicleUndriveable(veh, false)
	SetVehicleUndriveable(GetVehiclePedIsUsing(GetPlayerPed(-1)), false)
	stage5PB = false
	stage6PB = true
	vehcheckPB = true
	Citizen.Wait(2000)
	exports['mythic_notify']:DoCustomHudText('inform', 'Twój pojazd jest gotowy do odbioru', 4000)
	--Citizen.Wait(stage7PBperiod)
	stage6PB = false
	vehcheckPB = false
	DrawSpecialText(msg, 2000)
	Wait(2000)
end)

RegisterNetEvent('srp_repairLSC:successpremiumPB')
AddEventHandler('srp_repairLSC:successpremiumPB', function(price)
local ped = GetPlayerPed(-1)
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
	local veh = GetClosestVehicle(x, y, z, 4.001, 0, 70)
	local veh2 = GetVehiclePedIsIn (GetPlayerPed (-1), true)
	local lastcar = GetPlayersLastVehicle(GetPlayerPed (-1))
	local theshop = 1765.49, 3332.63, 41.44
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local seconds = 1000 --- Seconds
	local minute = 60 * seconds -- Minutes
	local stage1PBperiod = 6 * seconds
	local stage2PBperiod = 3 * seconds
	local stage3PBperiod = 6 * seconds
	local stage4PBperiod = 3 * seconds
	local stage5PBperiod = 3 * seconds
	local stage6PBperiod = 3 * seconds
	local stage7PBperiod = 10 * seconds

	vehicle = GetVehiclePedIsIn(ped, false)
	SetVehicleDoorsLocked(vehicle, 2) 
	TaskLeaveVehicle(ped, vehicle, 1)
	SetVehicleUndriveable(veh2, true)

	paynotificationPB = true
	Citizen.Wait(3000)
	paynotificationPB = false 
	payalertPB = true 
	Citizen.Wait(3000)
	payalertPB = false 

	stage1PB = true  
    SetVehicleDoorOpen(veh2, 4, false, false) 
    Citizen.Wait(stage1PBperiod)
    stage1PB = false
    stage2PB = true 
    Citizen.Wait(stage2PBperiod)
    stage2PB = false
    stage3PB = true 
    Citizen.Wait(stage3PBperiod)
    stage3PB = false 
    stage4PB = true 
    Citizen.Wait(stage5PBperiod)
    stage4PB = false 
    stage5PB = true 
	Citizen.Wait(stage6PBperiod)
	
	SetVehicleFixed(veh2) 
	SetVehicleDirtLevel(GetVehiclePedIsIn(GetPlayerPed(-1),  false),  0.0000000001) 
    SetVehicleEngineHealth( veh2, 1000 )
    SetVehicleEngineOn( veh2, true, true ) 
    SetVehicleFixed( veh2 ) 
	SetVehicleDoorsLocked(veh2, 1) 
	SetVehicleUndriveable(veh, false) 
	SetVehicleUndriveable(GetVehiclePedIsUsing(GetPlayerPed(-1)), false) 
	stage5PB = false 
	stage6PB = true 
	vehcheckPB = true 
	Citizen.Wait(2000)
	exports['mythic_notify']:DoCustomHudText('inform', 'Twój pojazd jest gotowy do odbioru', 4000)
	--Citizen.Wait(stage7PBperiod)
	stage6PB = false 
	vehcheckPB = false 
	DrawSpecialText(msg, 2000)
	Wait(2000)
end)

RegisterNetEvent('srp_repairLSC:notenoughmoneyPB')
AddEventHandler('srp_repairLSC:notenoughmoneyPB', function(moneyleft)
	exports['mythic_notify']:DoCustomHudText('error', 'Nie masz wystarczająco dużo pieniędzy w banku aby zakupić Pakiet Mini!', 3500)
	DrawSpecialText(msg, 5000)
	Wait(5000)
end)

RegisterNetEvent('srp_repairLSC:notenoughmoneypremiumPB')
AddEventHandler('srp_repairLSC:notenoughmoneypremiumPB', function(moneyleft)
	exports['mythic_notify']:DoCustomHudText('error', 'Nie masz wystarczająco dużo pieniędzy w banku aby kupić Pakiet Premium!', 3500)
	DrawSpecialText(msg, 5000)
	Wait(5000)
end)

function AutoRepairPB()
    local elements = {
        { label = 'Szybka Naprawa (Pakiet Premium) - <font color="green">$2500</font>', value = "repair_fastPB" },
        { label = 'Zwykła Naprawa (Pakiet Mini💤) - <font color="green">$500</font>', value = "repair_slowPB" }
    }
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'repairmenu_paleto',
        {
            title    = "<font-size='15px'>🔧Beeker\'s Garage - Paleto Bay🔧</font>",
            align    = 'center',
            elements = elements
        },
    function(data, menu)
        local action = data.current.value
        if action == "repair_fastPB" then
             TriggerServerEvent('srp_repairLSC:checkmoneypremiumPB')
        elseif action == "repair_slowPB" then
            TriggerServerEvent('srp_repairLSC:checkmoneyPB')
        end
        menu.close()
    end, function(data, menu)
        menu.close()
    end)
end




-- AirPort
Citizen.CreateThread(function()
	while true do
			local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local markerPos = { -1157.14, -2001.29, 13.18 }
	local distance = Vdist(plyPos.x, plyPos.y, plyPos.z, -1157.14, -2001.29, 13.18)
if distance < 9 then
   insidemarkercheckAirPort = true
end

if distance > 9 then
	insidemarkercheckAirPort = false
end
if insidemarkercheckAirPort == true and stage1AirPort == false and stage2AirPort == false and stage3AirPort == false and stage4AirPort == false and stage5AirPort == false and stage6AirPort == false then

end

if insidemarkercheckAirPort == false and stage1AirPort == false and stage2AirPort == false and stage3AirPort == false and stage4AirPort == false and stage5AirPort == false and stage6AirPort == false then

end

if insidemarkercheckAirPort == true and stage1AirPort == true and stage2AirPort == false and stage3AirPort == false and stage4AirPort == false and stage5AirPort == false and stage6AirPort == false then
 Draw3DText(-1157.14, -2001.29, 13.18 + 0.1, tostring("~w~Mechanicy zajmuja się Twoim pojazdem ~o~Poczekaj chwilę"))
  Draw3DText2(-1157.14, -2001.29, 13.18, tostring("~w~Przybliżony procent naprawy: ~r~25%"))
    Draw3DText2(-1157.14, -2001.29, 13.18 - 0.1, tostring("~w~Sprawdzanie uszkodzeń Twojego pojazdu.."))
end

if insidemarkercheckAirPort == true and stage1AirPort == false and stage2AirPort == true and stage3AirPort == false and stage4AirPort == false and stage5AirPort == false and stage6AirPort == false then
 Draw3DText(-1157.14, -2001.29, 13.18 + 0.1, tostring("~w~Mechanicy zajmuja się Twoim pojazdem ~o~Poczekaj chwilę"))
 Draw3DText2(-1157.14, -2001.29, 13.18, tostring("~w~Przybliżony procent naprawy: ~o~45%"))
 Draw3DText2(-1157.14, -2001.29, 13.18 - 0.1, tostring("~w~Sprawdzanie oraz naprawa silnika.."))
end 

if insidemarkercheckAirPort == true and stage1AirPort == false and stage2AirPort == false and stage3AirPort == true and stage4AirPort == false and stage5AirPort == false and stage6AirPort == false then
 Draw3DText(-1157.14, -2001.29, 13.18 + 0.1, tostring("~w~Mechanicy zajmuja się Twoim pojazdem ~o~Poczekaj chwilę"))
 Draw3DText2(-1157.14, -2001.29, 13.18, tostring("~w~Przybliżony procent naprawy: ~o~60%"))
 Draw3DText2(-1157.14, -2001.29, 13.18 - 0.1, tostring("~w~Sprawdzanie oraz naprawa skrzyni biegów.."))
end 


if insidemarkercheckAirPort == true and stage1AirPort == false and stage2AirPort == false and stage3AirPort == false and stage4AirPort == true and stage5AirPort == false and stage6AirPort == false then
 Draw3DText(-1157.14, -2001.29, 13.18 + 0.1, tostring("~w~Mechanicy zajmuja się Twoim pojazdem ~o~Poczekaj chwilę"))
 Draw3DText2(-1157.14, -2001.29, 13.18, tostring("~w~Przybliżony procent naprawy: ~g~85%"))
 Draw3DText2(-1157.14, -2001.29, 13.18 - 0.1, tostring("~w~Sprawdzanie poziomu płynów eksploatacyjnych.."))
end 

if insidemarkercheckAirPort == true and stage1AirPort == false and stage2AirPort == false and stage3AirPort == false and stage4AirPort == false and stage5AirPort == true and stage6AirPort == false then
 Draw3DText(-1157.14, -2001.29, 13.18 + 0.1, tostring("~w~Mechanicy zajmuja się Twoim pojazdem ~o~Poczekaj chwilę"))
 Draw3DText2(-1157.14, -2001.29, 13.18, tostring("~w~Przybliżony procent naprawy: ~g~95%"))
 Draw3DText2(-1157.14, -2001.29, 13.18 - 0.1, tostring("~w~Wytarcie karoserii z kurzu.."))
end 

if insidemarkercheckAirPort == true and stage1AirPort == false and stage2AirPort == false and stage3AirPort == false and stage4AirPort == false and stage5AirPort == false and stage6AirPort == true then
 Draw3DText(-1157.14, -2001.29, 13.18 + 0.1, tostring("~w~Pojazd został naprawiony ~g~Możesz już odjechać ze stanowiska"))
Draw3DText2(-1157.14, -2001.29, 13.18, tostring("~w~Przybliżony procent naprawy: ~g~100%"))
--Draw3DText2(-1157.14, -2001.29, 13.18 - 0.1, tostring("~w~Samochód gotowy do odbioru!"))
end 

		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)

if stage1AirPort == true then
         
     end
if stage2AirPort == true then
	        
	     end
if stage3AirPort == true then

end

if stage4AirPort == true then

end

if lockedAirPort == true then
Draw3DText2(plyPos.x, plyPos.y, plyPos.z + 0.2, tostring('~w~Vehicle has been ~r~locked'))
end

if unlockedAirPort == true then
Draw3DText2(plyPos.x, plyPos.y, plyPos.z + 0.2, tostring('~w~Vehicle has been ~g~Unlocked'))
end

if vehcheckAirPort == true then
	if IsControlJustPressed(0, 38) then
		SetVehicleDoorsLocked(vehicle, 2)
		stage6AirPort = false
		lockedAirPort = true
		Citizen.Wait(4000)
		lockedAirPort = false
	end
end

if stage5AirPort == true then

end

if payalertAirPort == true then
Draw3DText2(plyPos.x, plyPos.y, plyPos.z + 0.2, tostring('~w~Mechanicy za chwile zajmą się Twoim pojazdem'))

end

if paynotificationAirPort == true then

Draw3DText2(plyPos.x, plyPos.y, plyPos.z + 0.2, tostring('~w~Płacenie kartą ~w~za naprawę'))
end

if stage6AirPort == true then
Draw3DText(plyPos.x, plyPos.y, plyPos.z + 0.2, tostring("~w~Twój pojazd jest gotowy do odbioru"))
--Draw3DText2(plyPos.x, plyPos.y, plyPos.z + 0.1, tostring("~w~Nacisnij ~r~E~w~ to lock Your vehicle at the shop"))
end

if stage7AirPort == true then
--Draw3DText(plyPos.x, plyPos.y, plyPos.z, tostring("~r~This is a test message stage 7"))
end
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('srp_repairLSC:successAirPort')
AddEventHandler('srp_repairLSC:successAirPort', function(price)
	local ped = GetPlayerPed(-1)
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
	local veh = GetClosestVehicle(x, y, z, 4.001, 0, 70)
	local veh2 = GetVehiclePedIsIn (GetPlayerPed (-1), true)
	local lastcar = GetPlayersLastVehicle(GetPlayerPed (-1))
	local theshop = 1765.49, 3332.63, 41.44
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local seconds = 1000 --- Seconds
	local minute = 60 * seconds -- Minutes
	local stage1AirPortperiod = 40 * seconds
	local stage2AirPortperiod = 3 * seconds
	local stage3AirPortperiod = 40 * seconds
	local stage4AirPortperiod = 6 * seconds
	local stage5AirPortperiod = 3 * seconds
	local stage6AirPortperiod = 5 * seconds
	local stage7AirPortperiod = 10 * seconds

	vehicle = GetVehiclePedIsIn(ped, false)
	SetVehicleDoorsLocked(vehicle, 2)
	TaskLeaveVehicle(ped, vehicle, 1)
	SetVehicleUndriveable(veh2, true)

	paynotificationAirPort = true
	Citizen.Wait(3000)
	paynotificationAirPort = false 
	payalertAirPort = true 
	Citizen.Wait(3000)
	payalertAirPort = false 

	stage1AirPort = true 
    SetVehicleDoorOpen(veh2, 4, false, false)
    Citizen.Wait(stage1AirPortperiod)
    stage1AirPort = false
    stage2AirPort = true
    Citizen.Wait(stage2AirPortperiod)
    stage2AirPort = false 
    stage3AirPort = true
    Citizen.Wait(stage3AirPortperiod)
    stage3AirPort = false 
    stage4AirPort = true  
    Citizen.Wait(stage5AirPortperiod)
    stage4AirPort = false
    stage5AirPort = true
	Citizen.Wait(stage6AirPortperiod)
	
	SetVehicleFixed(veh2)
	SetVehicleDirtLevel(GetVehiclePedIsIn(GetPlayerPed(-1),  false),  0.0000000001)
    SetVehicleEngineHealth( veh2, 1000 )
    SetVehicleEngineOn( veh2, true, true )
    SetVehicleFixed( veh2 ) 
	SetVehicleDoorsLocked(veh2, 1)
	SetVehicleUndriveable(veh, false)
	SetVehicleUndriveable(GetVehiclePedIsUsing(GetPlayerPed(-1)), false)
	stage5AirPort = false
	stage6AirPort = true
	vehcheckAirPort = true
	Citizen.Wait(2000)
	exports['mythic_notify']:DoCustomHudText('inform', 'Twój pojazd jest gotowy do odbioru', 4000)
	--Citizen.Wait(stage7AirPortperiod)
	stage6AirPort = false
	vehcheckAirPort = false
	DrawSpecialText(msg, 2000)
	Wait(2000)
end)

RegisterNetEvent('srp_repairLSC:successpremiumAirPort')
AddEventHandler('srp_repairLSC:successpremiumAirPort', function(price)
local ped = GetPlayerPed(-1)
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
	local veh = GetClosestVehicle(x, y, z, 4.001, 0, 70)
	local veh2 = GetVehiclePedIsIn (GetPlayerPed (-1), true)
	local lastcar = GetPlayersLastVehicle(GetPlayerPed (-1))
	local theshop = 1765.49, 3332.63, 41.44
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local seconds = 1000 --- Seconds
	local minute = 60 * seconds -- Minutes
	local stage1AirPortperiod = 6 * seconds
	local stage2AirPortperiod = 3 * seconds
	local stage3AirPortperiod = 6 * seconds
	local stage4AirPortperiod = 3 * seconds
	local stage5AirPortperiod = 3 * seconds
	local stage6AirPortperiod = 3 * seconds
	local stage7AirPortperiod = 10 * seconds

	vehicle = GetVehiclePedIsIn(ped, false)
	SetVehicleDoorsLocked(vehicle, 2) 
	TaskLeaveVehicle(ped, vehicle, 1)
	SetVehicleUndriveable(veh2, true)

	paynotificationAirPort = true
	Citizen.Wait(3000)
	paynotificationAirPort = false 
	payalertAirPort = true 
	Citizen.Wait(3000)
	payalertAirPort = false 

	stage1AirPort = true  
    SetVehicleDoorOpen(veh2, 4, false, false) 
    Citizen.Wait(stage1AirPortperiod)
    stage1AirPort = false
    stage2AirPort = true 
    Citizen.Wait(stage2AirPortperiod)
    stage2AirPort = false
    stage3AirPort = true 
    Citizen.Wait(stage3AirPortperiod)
    stage3AirPort = false 
    stage4AirPort = true 
    Citizen.Wait(stage5AirPortperiod)
    stage4AirPort = false 
    stage5AirPort = true 
	Citizen.Wait(stage6AirPortperiod)
	
	SetVehicleFixed(veh2) 
	SetVehicleDirtLevel(GetVehiclePedIsIn(GetPlayerPed(-1),  false),  0.0000000001) 
    SetVehicleEngineHealth( veh2, 1000 )
    SetVehicleEngineOn( veh2, true, true ) 
    SetVehicleFixed( veh2 ) 
	SetVehicleDoorsLocked(veh2, 1) 
	SetVehicleUndriveable(veh, false) 
	SetVehicleUndriveable(GetVehiclePedIsUsing(GetPlayerPed(-1)), false) 
	stage5AirPort = false 
	stage6AirPort = true 
	vehcheckAirPort = true 
	Citizen.Wait(2000)
	exports['mythic_notify']:DoCustomHudText('inform', 'Twój pojazd jest gotowy do odbioru', 4000)
	--Citizen.Wait(stage7AirPortperiod)
	stage6AirPort = false 
	vehcheckAirPort = false 
	DrawSpecialText(msg, 2000)
	Wait(2000)
end)

RegisterNetEvent('srp_repairLSC:notenoughmoneyAirPort')
AddEventHandler('srp_repairLSC:notenoughmoneyAirPort', function(moneyleft)
	exports['mythic_notify']:DoCustomHudText('error', 'Nie masz wystarczająco dużo pieniędzy w banku aby zakupić Pakiet Mini!', 3500)
	DrawSpecialText(msg, 5000)
	Wait(5000)
end)

RegisterNetEvent('srp_repairLSC:notenoughmoneypremiumAirPort')
AddEventHandler('srp_repairLSC:notenoughmoneypremiumAirPort', function(moneyleft)
	exports['mythic_notify']:DoCustomHudText('error', 'Nie masz wystarczająco dużo pieniędzy w banku aby kupić Pakiet Premium!', 3500)
	DrawSpecialText(msg, 5000)
	Wait(5000)
end)

function AutoRepairAirPort()
    local elements = {
        { label = 'Szybka Naprawa (Pakiet Premium) - <font color="green">$2500</font>', value = "repair_fastAirPort" },
        { label = 'Zwykła Naprawa (Pakiet Mini💤) - <font color="green">$500</font>', value = "repair_slowAirPort" }
    }
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'repairmenu_airport',
        {
            title    = "<font-size='15px'>🔧Los Santos Customs - Airport🔧</font>",
            align    = 'center',
            elements = elements
        },
    function(data, menu)
        local action = data.current.value
        if action == "repair_fastAirPort" then
             TriggerServerEvent('srp_repairLSC:checkmoneypremiumAirPort')
        elseif action == "repair_slowAirPort" then
            TriggerServerEvent('srp_repairLSC:checkmoneyAirPort')
        end
        menu.close()
    end, function(data, menu)
        menu.close()
    end)
end







---Inne Funkcje
function GetClosestVehicleToPlayer()
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local plyOffset = GetOffsetFromEntityInWorldCoords(plyPed, 0.0, 1.0, 0.0)
	local radius = 3.0
	local rayHandle = StartShapeTestCapsule(plyPos.x, plyPos.y, plyPos.z, plyOffset.x, plyOffset.y, plyOffset.z, radius, 10, plyPed, 7)
	local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)
	return vehicle
end

function Draw3DText(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*1
    local fov = (1/GetGameplayCamFov())*100
    local scale = 1.1
   
    if onScreen then
		SetTextScale(0.30, 0.30)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
		--local factor = (string.len(text)) / 370
		--DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 90)
    end
end

function Draw3DText2(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*1
    local fov = (1/GetGameplayCamFov())*100
    local scale = 0.9
   
    if onScreen then
		SetTextScale(0.30, 0.30)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
		--local factor = (string.len(text)) / 370
		--DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 90)
    end
end