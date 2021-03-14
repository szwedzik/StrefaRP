Citizen.CreateThread(function()
	local dict = "missminuteman_1ig_2"
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
    local handsup = false
	while true do
		Citizen.Wait(3)
		if IsControlJustPressed(1, 289) then --Start holding X
            if not handsup then
                TaskPlayAnim(GetPlayerPed(-1), dict, "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
                handsup = true
            else
                handsup = false
                ClearPedTasks(GetPlayerPed(-1))
            end
        end
	end
end)
------------------------------------ Kucanie ----------------------------------------------
local crouched = false
Citizen.CreateThread( function()
    while true do 
        Citizen.Wait(10)
        if DoesEntityExist(PlayerPedId()) and not IsEntityDead(PlayerPedId()) then 
            DisableControlAction(0, 36, true)
            if not IsPauseMenuActive() then 
                if IsDisabledControlJustPressed(0, 36) then 
                    RequestAnimSet("move_ped_crouched")
                    while not HasAnimSetLoaded("move_ped_crouched") do 
                        Citizen.Wait(300)
                    end 
                    if crouched then
						ClearPedTasks(PlayerPedId())
						Wait(500)
                        ResetPedMovementClipset(PlayerPedId(), 0)
                        crouched = false 
                    else
                        SetPedMovementClipset(PlayerPedId(), "move_ped_crouched", 0.25)
                        crouched = true 
                    end 
                end
            end 
        end 
    end
end)
--------------------------------- Shuff --------------------------------------------
local disableShuffle = true
function disableSeatShuffle(flag)
	disableShuffle = flag
end

RegisterNetEvent("SeatShuffle")
AddEventHandler("SeatShuffle", function()
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		disableSeatShuffle(false)
		Citizen.Wait(5000)
		disableSeatShuffle(true)
	else
		CancelEvent()
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) and disableShuffle then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
				if GetIsTaskActive(GetPlayerPed(-1), 165) then
					SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
				end
			end
		end
	end
end)

RegisterCommand("shuff", function(source, args, raw)
    TriggerEvent("SeatShuffle")
end, false)

---------------------palec grzebalec-----------------------
local mp_pointing = false
local keyPressed = false
local function startPointing()
    local ped = GetPlayerPed(-1)
    RequestAnimDict("anim@mp_point")
    while not HasAnimDictLoaded("anim@mp_point") do
        Wait(0)
    end
    SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
    SetPedConfigFlag(ped, 36, 1)
    Citizen.InvokeNative(0x2D537BA194896636, ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
    RemoveAnimDict("anim@mp_point")
end

local function stopPointing()
    local ped = GetPlayerPed(-1)
    Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
    if not IsPedInjured(ped) then
        ClearPedSecondaryTask(ped)
    end
    if not IsPedInAnyVehicle(ped, 1) then
        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
    end
    SetPedConfigFlag(ped, 36, 0)
    ClearPedSecondaryTask(PlayerPedId())
end

local once = true
local oldval = false
local oldvalped = false

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if once then
            once = false
        end

        if not keyPressed then
            if IsControlPressed(0, 29) and not mp_pointing and IsPedOnFoot(PlayerPedId()) then
                Wait(200)
                if not IsControlReleased(0, 29) then
                    keyPressed = true
                    startPointing()
                    mp_pointing = true
                else
                    keyPressed = true
                    while IsControlPressed(0, 29) do
                        Wait(50)
                    end
                end

            elseif (IsControlReleased(0, 29) and mp_pointing) or (not IsPedOnFoot(PlayerPedId()) and mp_pointing) then
                keyPressed = true
                mp_pointing = false
                stopPointing()
            end
        end

        if keyPressed then
            if not IsControlPressed(0, 29) then
                keyPressed = false
            end
        end

        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) and not mp_pointing then
            stopPointing()
        end

        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) then
            if not IsPedOnFoot(PlayerPedId()) then
                stopPointing()
            else
                local ped = GetPlayerPed(-1)
                local camPitch = GetGameplayCamRelativePitch()
                if camPitch < -70.0 then
                    camPitch = -70.0
                elseif camPitch > 42.0 then
                    camPitch = 42.0
                end
                camPitch = (camPitch + 70.0) / 112.0
                local camHeading = GetGameplayCamRelativeHeading()
                local cosCamHeading = Cos(camHeading)
                local sinCamHeading = Sin(camHeading)
                if camHeading < -180.0 then
                    camHeading = -180.0
                elseif camHeading > 180.0 then
                    camHeading = 180.0
                end
                camHeading = (camHeading + 180.0) / 360.0
                local blocked = 0
                local nn = 0
                local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7);
                nn,blocked,coords,coords = GetRaycastResult(ray)
                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Pitch", camPitch)
                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Heading", camHeading * -1.0 + 1.0)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isBlocked", blocked)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)
            end
        end
    end
end)

----------------------ZAKŁADANIE RĄK-----------------
local handsup = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if IsControlJustPressed(1, 47) then
			if not IsEntityPlayingAnim(PlayerPedId(), 'amb@world_human_hang_out_street@female_arms_crossed@enter', "enter", 3) then
				 handsup = false
			end
            if not handsup then
				RequestAnimDict('amb@world_human_hang_out_street@female_arms_crossed@enter')
				while not HasAnimDictLoaded('amb@world_human_hang_out_street@female_arms_crossed@enter') do
					Citizen.Wait(1)
				end
                TaskPlayAnim(GetPlayerPed(-1), 'amb@world_human_hang_out_street@female_arms_crossed@enter', "enter", 8.0, 1.0, -1, 50, 0, false, false, false)
                handsup = true
            else
				ClearPedTasks(PlayerPedId())
                handsup = false
            end
        end
    end
end)

-------------------STEROWANIE POJAZDEM W LOCIE----------------------
local blacklistedModels = {
	"deluxo",
}

local turnEngineOn = false
Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
		
		local ped = GetPlayerPed(-1)
		local veh = GetVehiclePedIsIn(ped)
		if DoesEntityExist(veh) then
			disableAirControl(ped, veh)
			disableVehicleRoll(ped, veh)
		end
	end
end)

function disableAirControl(ped, veh)
	if not IsThisModelBlacklisted(veh) then
		if IsPedSittingInAnyVehicle(ped) then
			if GetPedInVehicleSeat(veh, -1) == ped then
				if IsEntityInAir(veh) then
					DisableControlAction(0, 59)
					DisableControlAction(0, 60)
				end
			end
		end
	end
end

function disableVehicleRoll(ped, veh)
	local roll = GetEntityRoll(veh)

	if not IsThisModelBlacklisted(veh) then
		if GetPedInVehicleSeat(veh, -1) == ped then
			if (roll > 75.0 or roll < -75.0) then
				DisableControlAction(2,59,true)
				DisableControlAction(2,60,true)
			end
		end
	end
end

function IsThisModelBlacklisted(veh)
	local model = GetEntityModel(veh)

	for i = 1, #blacklistedModels do
		if model == GetHashKey(blacklistedModels[i]) then
			return true
		end
	end
	return false
end