local carryingBackInProgress = false
local lifted = false
ESX = nil


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


RegisterCommand("podnies", function(source, args, rawCommand)

	local closestPlayer = GetClosestPlayer(3)
	local targetPed = GetPlayerServerId(closestPlayer)
	local playerPed = GetPlayerName(targetPed)
	local ped = GetPlayerServerId(PlayerId())
	
	if not carryingBackInProgress then
		if closestPlayer ~= nil and closestPlayer ~= -1 then
			exports['mythic_notify']:DoCustomHudText('inform', 'Próbujesz podnieść gracza o id: '..targetPed, 10000)
			TriggerServerEvent('carry:info', playerPed, targetPed)	
		else
			exports['mythic_notify']:DoCustomHudText('error', 'Brak gracza w pobliżu', 10000)
		end
		
		else
	end
	
end, false)

RegisterCommand("pusc", function(source, args, rawCommand)

	local closestPlayer = GetClosestPlayer(3)
	local targetPed = GetPlayerServerId(closestPlayer)
	local playerPed = GetPlayerName(GetPlayerServerId(-1))
	local ped = GetPlayerServerId(PlayerId())

		carryingBackInProgress = false
		ClearPedSecondaryTask(GetPlayerPed(-1))
		DetachEntity(GetPlayerPed(-1), true, false)
		local closestPlayer = GetClosestPlayer(3)
		target = GetPlayerServerId(closestPlayer)
		TriggerServerEvent("cmg2_animations:stop",target)
		
end, false)




RegisterNetEvent('carry:request')
AddEventHandler('carry:request', function()

	playerchoose()
	
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if carryingBackInProgress then
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
    end
  end
end)

choosetime=false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		if choosetime then
			if IsControlJustReleased(1, 86) then
				exports['mythic_notify']:DoCustomHudText('success', 'Zaakceptowano', 10000)
				choosetime=false
				carry()
			end
	
			if IsControlJustReleased(1, 85) then
				exports['mythic_notify']:DoCustomHudText('error', 'Odrzuc', 10000)
				choosetime=false
			end
	
		end
	end
	
end)

function playerchoose()
	choosetime=true
	for i = 10,1,-1 do
	Wait(1000)
	
	-- ESX.ShowNotification(i)
	
	
	if not choosetime then
	break
	end
	
	if i == 1 then
	choosetime=false
	local closestPlayer = GetClosestPlayer(3)
	local targetPed = GetPlayerServerId(closestPlayer)
	TriggerServerEvent('carry:timeup',targetPed)
	break
	end

	end

end

function carry()

	print("carrying")
	
		carryingBackInProgress = true
		local player = PlayerPedId()	
		lib = 'missfinale_c2mcs_1'
		anim1 = 'fin_c2_mcs_1_camman'
		lib2 = 'nm'
		anim2 = 'firemans_carry'
		distans = 0.15
		distans2 = 0.27
		height = 0.63
		spin = 0.0		
		length = 100000
		controlFlagMe = 49
		controlFlagTarget = 33
		animFlagTarget = 1
		local closestPlayer = GetClosestPlayer(3)
		target = GetPlayerServerId(closestPlayer)
		
		
		if closestPlayer ~= nil then
			-- print("triggering cmg2_animations:sync")
			TriggerServerEvent('cmg2_animations:sync', closestPlayer, lib,lib2, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget)
		else
			-- print("[CMG Anim] No player nearby")
		end
end

RegisterNetEvent('cmg2_animations:syncTarget')
AddEventHandler('cmg2_animations:syncTarget', function(target, animationLib, animation2, distans, distans2, height, length,spin,controlFlag)
	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	carryingBackInProgress = true
	-- print("triggered cmg2_animations:syncTarget")
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	if spin == nil then spin = 180.0 end
	AttachEntityToEntity(playerPed, targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
end)

RegisterNetEvent('cmg2_animations:syncMe')
AddEventHandler('cmg2_animations:syncMe', function(animationLib, animation,length,controlFlag,animFlag)
	local playerPed = GetPlayerPed(-1)
	-- print("triggered cmg2_animations:syncMe")
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	Wait(500)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)

	Citizen.Wait(length)
end)

RegisterNetEvent('cmg2_animations:cl_stop')
AddEventHandler('cmg2_animations:cl_stop', function()
	carryingBackInProgress = false
	ClearPedSecondaryTask(GetPlayerPed(-1))
	DetachEntity(GetPlayerPed(-1), true, false)
end)

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

function GetClosestPlayer(radius)
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords['x'], targetCoords['y'], targetCoords['z'], plyCoords['x'], plyCoords['y'], plyCoords['z'], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
	-- print("closest player is dist: " .. tostring(closestDistance))
	if closestDistance <= radius then
		return closestPlayer
	else
		return nil
	end
end

RegisterNetEvent('showNotify')
AddEventHandler('showNotify', function(notify, id)
    if PlayerId() == GetPlayerFromServerId(id) then
	    ShowAboveRadarMessage(notify)
	end
end)

function ShowAboveRadarMessage(message)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0,1)
end

-- MICHU 1/2