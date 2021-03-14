ESX                  = nil
local IsAlreadyDrunk = false
local DrunkLevel     = -1

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

function Drunk(level, start)
  Citizen.CreateThread(function()
    local playerPed = GetPlayerPed(-1)
    if start then
      DoScreenFadeOut(500)
      Wait(1000)
    end
    if level == 0 then
      ShakeGameplayCam("DRUNK_SHAKE", 0.5)
      --SetPedConfigFlag(GetPlayerPed(-1), 100, true)
    end
    if level == 1 then
      ShakeGameplayCam("DRUNK_SHAKE", 1.5)
      SetPedConfigFlag(GetPlayerPed(-1), 100, true)
    end
    if level == 2 then
      ShakeGameplayCam("DRUNK_SHAKE", 3.0)
      SetPedConfigFlag(GetPlayerPed(-1), 100, true)
      SetPedMovementClipset(playerPed, "move_m@drunk@slightlydrunk", true)
    end
    if level == 3 then
      RequestAnimSet("move_m@drunk@slightlydrunk")
      while not HasAnimSetLoaded("move_m@drunk@slightlydrunk") do
        Citizen.Wait(0)
      end
      SetPedMovementClipset(playerPed, "move_m@drunk@slightlydrunk", true)
      ShakeGameplayCam("DRUNK_SHAKE", 3.0)
      SetPedConfigFlag(GetPlayerPed(-1), 100, true)
    elseif level == 4 then
      RequestAnimSet("move_m@drunk@moderatedrunk")
      while not HasAnimSetLoaded("move_m@drunk@moderatedrunk") do
        Citizen.Wait(0)
      end
      SetPedMovementClipset(playerPed, "move_m@drunk@moderatedrunk", true)
      ShakeGameplayCam("DRUNK_SHAKE", 4.0)
      SetPedConfigFlag(GetPlayerPed(-1), 100, true)
    elseif level == 5 then
      RequestAnimSet("move_m@drunk@verydrunk")
      while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
        Citizen.Wait(0)
      end
      SetPedMovementClipset(playerPed, "move_m@drunk@verydrunk", true)
      ShakeGameplayCam("DRUNK_SHAKE", 5.0)
      ShakeGameplayCam("VIBRATE_SHAKE", 0.5)
      SetPedConfigFlag(GetPlayerPed(-1), 100, true)
      SetPadShake(0, 50, 200)
    end
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedIsDrunk(playerPed, true)
    if start then
      DoScreenFadeIn(800)
    end
  end)
end

function Reality()
  Citizen.CreateThread(function()
    local playerPed = GetPlayerPed(-1)
    DoScreenFadeOut(800)
    Wait(1000)
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(playerPed, 0)
    SetPedIsDrunk(playerPed, false)
    SetPedMotionBlur(playerPed, false)
    ShakeGameplayCam(playerPed, false)
    DoScreenFadeIn(800)
    IsAlreadyDrunk = false
    DrunkLevel = -1
  end)

end

RegisterCommand("resettest",function(source)
	Reality()
end, false)

AddEventHandler('esx_status:loaded', function(status)
  TriggerEvent('esx_status:registerStatus', 'drunk', 0, '#8F15A5', 
    function(status)
      if status.val > 0 then
        return true
      else
        return false
      end
    end,
    function(status)
      status.remove(1500)
    end
  )
	Citizen.CreateThread(function()
		while true do
			Wait(1000)
			TriggerEvent('esx_status:getStatus', 'drunk', function(status)
				if status.val > 0 then
          local start = true
          if IsAlreadyDrunk then
            start = false
          end
          local level = 0
          if status.val <= 90000 then
            level = 0
          elseif status.val <= 180000 then
            level = 1
          elseif status.val <= 250000 then
            level = 2
          elseif status.val <= 500000 then
            level = 3
          elseif status.val <= 750000 then
            level = 4
          else
            level = 5
          end
          if level ~= DrunkLevel then
            Drunk(level, start)
          end
          IsAlreadyDrunk = true
          DrunkLevel     = level
				end
				if status.val == 0 then
          if IsAlreadyDrunk then
            Reality()
          end
          IsAlreadyDrunk = false
          DrunkLevel     = -1
				end
			end)
		end
	end)
end)

RegisterNetEvent('esx_optionalneeds:onDrink')
AddEventHandler('esx_optionalneeds:onDrink', function()
  local playerPed = GetPlayerPed(-1)
  TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_DRINKING", 0, 1)
  Citizen.Wait(1000)
  ClearPedTasksImmediately(playerPed)
end)