--local hospitalCheckin = { x = 291.90, y = -1452.29, z = 29.97, h = 139.74 }
local hospitalCheckin = { x = 308.29, y = -595.38, z = 43.29, h = 194.41 }
local pillboxTeleports = {
    { x = 325.48892211914, y = -598.75372314453, z = 43.291839599609, h = 64.513374328613, text = 'Press ~INPUT_CONTEXT~ ~s~to go to lower Pillbox Entrance' },
    { x = 355.47183227539, y = -596.26495361328, z = 28.773477554321, h = 245.85662841797, text = 'Press ~INPUT_CONTEXT~ ~s~to enter Pillbox Hospital' },
    { x = 359.57849121094, y = -584.90911865234, z = 28.817169189453, h = 245.85662841797, text = 'Press ~INPUT_CONTEXT~ ~s~to enter Pillbox Hospital' },
}

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

local bedOccupying = nil
local bedOccupyingData = nil

local cam = nil

local inBedDict = "anim@gangops@morgue@table@"
local inBedAnim = "ko_front"
local getOutDict = 'switch@franklin@bed'
local getOutAnim = 'sleep_getup_rubeyes'
--local DoctorPed = vector3(290.59, -1454.01, 28.91)
local DoctorPed = vector3(308.54, -596.49, 42.29)
local PressEDoctor = false
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function PrintHelpText(message)
    SetTextComponentFormat("STRING")
    AddTextComponentString(message)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function LeaveBed()
    RequestAnimDict(getOutDict)
    while not HasAnimDictLoaded(getOutDict) do
        Citizen.Wait(0)
    end

    RenderScriptCams(0, true, 200, true, true)
    DestroyCam(cam, false)

    SetEntityHeading(PlayerPedId(), bedOccupyingData.h - 90)
    TaskPlayAnim(PlayerPedId(), getOutDict , getOutAnim ,8.0, -8.0, -1, 0, 0, false, false, false )
    Citizen.Wait(5000)
    ClearPedTasks(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
    TriggerServerEvent('mythic_hospital:server:LeaveBed', bedOccupying)

    bedOccupying = nil
    bedOccupyingData = nil
end

RegisterNetEvent('mythic_hospital:client:RPCheckPos')
AddEventHandler('mythic_hospital:client:RPCheckPos', function()
    TriggerServerEvent('mythic_hospital:server:RPRequestBed', GetEntityCoords(PlayerPedId()))
end)

RegisterNetEvent('mythic_hospital:client:RPSendToBed')
AddEventHandler('mythic_hospital:client:RPSendToBed', function(id, data)
    bedOccupying = id
    bedOccupyingData = data

    SetEntityCoords(PlayerPedId(), data.x, data.y, data.z - 0.5)
    
    RequestAnimDict(inBedDict)
    while not HasAnimDictLoaded(inBedDict) do
        Citizen.Wait(0)
    end

    TaskPlayAnim(PlayerPedId(), inBedDict , inBedAnim ,8.0, -8.0, -1, 1, 0, false, false, false )
    SetEntityHeading(PlayerPedId(), data.h + 180)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
    AttachCamToPedBone(cam, PlayerPedId(), 31085, 0, 0, 1.0 , true)
    SetCamFov(cam, 90.0)
    SetCamRot(cam, -90.0, 0.0, GetEntityHeading(PlayerPedId()) + 180, true)
            

    Citizen.CreateThread(function()
        while bedOccupyingData ~= nil do
            Citizen.Wait(1)
            PrintHelpText('Naciśnij ~INPUT_VEH_DUCK~ aby wstać')
            if IsControlJustReleased(0, 73) then
                LeaveBed()
            end
        end
    end)
end)

RegisterNetEvent('mythic_hospital:client:SendToBed')
AddEventHandler('mythic_hospital:client:SendToBed', function(id, data)
    bedOccupying = id
    bedOccupyingData = data

    SetEntityCoords(PlayerPedId(), data.x, data.y, data.z - 0.3)
    RequestAnimDict(inBedDict)
    while not HasAnimDictLoaded(inBedDict) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), inBedDict , inBedAnim ,8.0, -8.0, -1, 1, 0, false, false, false )
    SetEntityHeading(PlayerPedId(), data.h + 180)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
    AttachCamToPedBone(cam, PlayerPedId(), 31085, 0, 0, 1.0 , true)
    SetCamFov(cam, 90.0)
    SetCamRot(cam, -90.0, 0.0, GetEntityHeading(PlayerPedId()) + 180, true)

    Citizen.CreateThread(function ()
        Citizen.Wait(5)
        local player = PlayerPedId()
        disablecontrols = true
        exports['mythic_notify']:DoHudText('inform', 'Doktor zajmuję się Tobą')
        exports['mythic_progbar']:Progress({
            name = "hospital_bed",
            duration = 30000,
            label = "Doktor zajmuję się Tobą...",
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            }
        })
        Citizen.Wait(30000)
        disablecontrols = false
        TriggerServerEvent('mythic_hospital:server:EnteredBed')
    end)
end)

RegisterNetEvent('mythic_hospital:client:FinishServices')
AddEventHandler('mythic_hospital:client:FinishServices', function()
	SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
    TriggerEvent('mythic_hospital:client:RemoveBleed')
    TriggerEvent('mythic_hospital:client:ResetLimbs')
    exports['mythic_notify']:DoHudText('inform', 'Została udzielona Ci pomoc medyczna')
    LeaveBed()
end)

RegisterNetEvent('mythic_hospital:client:ForceLeaveBed')
AddEventHandler('mythic_hospital:client:ForceLeaveBed', function()
    LeaveBed()
end)
---Make Damage Persistant (Disable Auto-Heal)
SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
			local plyCoords = GetEntityCoords(PlayerPedId(), 0)
            local distance = #(vector3(hospitalCheckin.x, hospitalCheckin.y, hospitalCheckin.z) - plyCoords)
            if distance < 5 then
                --DrawMarker(27, hospitalCheckin.x, hospitalCheckin.y, hospitalCheckin.z - 0.99, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)

                if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
                    if IsPedDeadOrDying(GetPlayerPed(-1)) then
                        if distance < 2 then
                            --if IsControlJustReleased(0, 54) then
                            if not IsPedCuffed(PlayerPedId()) then
                                PressEDoctor = true
                                Citizen.Wait(1000)
                                TriggerEvent('esx_ambulancejob:revive')
                                FreezeEntityPosition(GetPlayerPed(-1), true)
                                Citizen.Wait(1000)
                                FreezeEntityPosition(GetPlayerPed(-1), false)
                                print("DEBUG: Press E BW")
                                helpdoctor()
                            --TriggerServerEvent("mythic_hospital:hascashdoctor")
                            else
                                exports['mythic_notify']:DoCustomHudText('error', 'Musisz być odkuty aby Doktor udzielił Ci pomocy!', 3500)
                            end
                            Citizen.Wait(10000)
                            --return
                        end
                    else
                        if distance < 2 then
                            ESX.Game.Utils.DrawText3D(vector3(hospitalCheckin.x, hospitalCheckin.y, hospitalCheckin.z), '[E] Aby wypełnić formularz', 0.3)
                            if IsControlJustReleased(0, 54) and PressEDoctor == false then
                                if (GetEntityHealth(PlayerPedId() < 180)) or (IsInjuredOrBleeding()) or (IsPedFatallyInjured(PlayerPedId())) then
                                    PressEDoctor = true
                                    print("DEBUG: Press E")
                                    TriggerServerEvent("mythic_hospital:hascashdoctor")
                                else
                                    PressEDoctor = true
                                    exports['mythic_notify']:DoCustomHudText('error', 'Doktor Barbaro uznał że nie potrzebujesz jego pomocy. Jeżeli czujesz się źle, udaj się do apteki przy San Andreas Ave', 3500)
                                    Citizen.Wait(3000)
                                    PressEDoctor = false
                                end
                            end
                        end
                    end
                end
            else
                Citizen.Wait(1000)
            end
    end
end)

function helpdoctor()
    local plyCoords = GetEntityCoords(PlayerPedId(), 0)
    if (GetEntityHealth(PlayerPedId() < 180)) or (IsInjuredOrBleeding()) or (IsPedFatallyInjured(PlayerPedId())) then
        exports['mythic_progbar']:Progress({
            name = "hospital_action",
            duration = 10000,
            label = "Wypełnianie formularza...",
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "missheistdockssetup1clipboard@base",
                anim = "base",
                flags = 49,
            },
            prop = {
                model = "p_amb_clipboard_01",
                bone = 18905,
                coords = { x = 0.10, y = 0.02, z = 0.08 },
                rotation = { x = -80.0, y = 0.0, z = 0.0 },
            },
            propTwo = {
                model = "prop_pencil_01",
                bone = 58866,
                coords = { x = 0.12, y = 0.0, z = 0.001 },
                rotation = { x = -150.0, y = 0.0, z = 0.0 },
            },
        }, function(status)
            if not status then
                TriggerServerEvent('mythic_hospital:server:RequestBed')
            end
            PressEDoctor = false
        end)
    else
        exports['mythic_notify']:DoCustomHudText('error', 'Doktor Barbaro uznał że nie potrzebujesz jego pomocy. Jeżeli czujesz się źle, udaj się do apteki przy San Andreas Ave', 3500)
    end
end

RegisterNetEvent("mythic_hospital:hascashdoctor")
AddEventHandler("mythic_hospital:hascashdoctor", function(count)
    if count >= 1 then
        HasCashDoctor = true
        helpdoctor()
    elseif count == 0 then
        HasCashDoctor = false 
        exports['mythic_notify']:DoCustomHudText('error', 'Nie masz wystarczającej ilości gotówki w portfelu aby zapłacić za usługi medyczne!', 3500)
    end
end)

--[[ 
-- Zjebane pobieranie co sekunda, powoduje lagi w chuj...
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
            local plyCoords = GetEntityCoords(PlayerPedId(), 0)
            local distance = #(vector3(hospitalCheckin.x, hospitalCheckin.y, hospitalCheckin.z) - plyCoords)
            if distance < 1.5 then
                TriggerServerEvent("esx_ambulancejob:hascashdoctor")
            end
    end
end)]]

----------- Funkcja respienia peda
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
	SetEntityHeading(ped, h)
end

Citizen.CreateThread(function()
    spawnped(DoctorPed.x, DoctorPed.y, DoctorPed.z, 17.18, "s_m_m_doctor_01")
end)

Citizen.CreateThread(function()
	while true do  
	  Citizen.Wait(0)
		if disablecontrols == true then
		  FreezeEntityPosition(GetPlayerPed(-1), true)
          DisableControlAction(0,21,true) -- disable sprint
          DisableControlAction(0,24,true) -- disable attack
          DisableControlAction(0,25,true) -- disable aim
          DisableControlAction(0,47,true) -- disable weapon
          DisableControlAction(0,58,true) -- disable weapon
          DisableControlAction(0,263,true) -- disable melee
          DisableControlAction(0,264,true) -- disable melee
          DisableControlAction(0,257,true) -- disable melee
          DisableControlAction(0,140,true) -- disable melee
          DisableControlAction(0,141,true) -- disable melee
          DisableControlAction(0,142,true) -- disable melee
          DisableControlAction(0,143,true) -- disable melee
          DisableControlAction(0,75,true) -- disable exit vehicle
          DisableControlAction(27,75,true) -- disable exit vehicle
          DisableControlAction(0,32,true) -- move (w)
          DisableControlAction(0,34,true) -- move (a)
          DisableControlAction(0,33,true) -- move (s)
          DisableControlAction(0,35,true) -- move (d)
		  DisableControlAction(0, 142, true) -- MeleeAttackAlternate
		  DisableControlAction(0, 24,  true) -- Shoot 
		  DisableControlAction(0, 92,  true) -- Shoot in car
		  DisableControlAction(0, 24,  true)
		  DisableControlAction(0, 25,  true)
		  DisableControlAction(0, 45,  true)
		  DisableControlAction(0, 76,  true)
		  DisableControlAction(0, 102,  true)
		  DisableControlAction(0, 278,  true)
		  DisableControlAction(0, 279,  true)
		  DisableControlAction(0, 280,  true)
		  DisableControlAction(0, 281,  true)
		  DisableControlAction(0, 140, true) -- Attack
		  DisableControlAction(0, 24, true) -- Attack
		  DisableControlAction(0, 25, true) -- Attack
		  DisableControlAction(2, 24, true) -- Attack
		  DisableControlAction(2, 257, true) -- Attack 2
		  DisableControlAction(2, 25, true) -- Aim
		  DisableControlAction(2, 263, true) -- Melee Attack 1
		  DisableControlAction(2, Keys['R'], true) -- Reload
		  DisableControlAction(2, Keys['LEFTALT'], true)
		  DisableControlAction(2, Keys['TOP'], true) -- Open phone (not needed?)
		  DisableControlAction(2, Keys['Q'], true) -- Cover
		  DisableControlAction(2, Keys['TAB'], true) -- Select Weapon
		  DisableControlAction(2, Keys['F1'], true) -- Disable phone
		  DisableControlAction(2, Keys['F2'], true) -- Inventory
		  DisableControlAction(2, Keys['F3'], true) -- Animations
		  DisableControlAction(2, Keys['F6'], true)
		  DisableControlAction(2, Keys['F7'], true)
		  DisableControlAction(2, Keys['F9'], true)
		  DisableControlAction(2, Keys['F10'], true)
		  DisableControlAction(2, Keys['Y'], true)
		  DisableControlAction(0, Keys['A'], true)
		  DisableControlAction(0, Keys['D'], true)
		  DisableControlAction(0, Keys['W'], true)
		  DisableControlAction(0, Keys['S'], true)
		  DisableControlAction(2, Keys['A'], true)
		  DisableControlAction(2, Keys['D'], true)
		  DisableControlAction(2, Keys['W'], true)
		  DisableControlAction(2, Keys['S'], true)
		  DisableControlAction(2, Keys["~"], true) 
		  DisableControlAction(2, Keys["X"], true)
		  DisableControlAction(0, Keys["X"], true)  
		  DisableControlAction(2, Keys["T"], true)
		  DisableControlAction(0, Keys["T"], true) 
  		end
	end
end)