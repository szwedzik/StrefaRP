function FindClosestNPC(playerPos)
    local handle, npcPed = FindFirstPed()
    
	repeat success, npcPed = FindNextPed(handle)
		local pedPos = GetEntityCoords(npcPed,  true)
		local distance = GetDistanceBetweenCoords(pedPos, playerPos, true)
		if distance > Config.SearchNPCDistanceMin and distance <= Config.SearchNPCDistanceMax then
			-- just to be sure its npc
			if 	IsPedNPC(npcPed) and 
				IsPedDeadOrDying(npcPed) == false or 
				IsPedInAnyVehicle(npcPed) == false then
				return npcPed
			end
		end
	until not success 
			
    EndFindPed(handle)
    return nil
end

function IsPedNPC(ped)
	return GetPedType(ped) ~= 28 and GetPlayerFromPed(ped) == -1
end

function GetPlayerFromPed(ped)
	for _, player in ipairs(GetActivePlayers()) do
		if GetPlayerPed(player) == ped then
			return player
		end
	end
	return -1
end

function WaitNPCBeforeCallingCops(npcPed)
	local delay = 0
	local plus = 500
	while true do
		Wait(plus)
		delay = delay + plus
		if BreakNPCCallingCops(npcPed, delay) then
			break;
		end
	end
	return delay == Config.CallNPCDuration
end

function BreakNPCCallingCops(npcPed, delay)
	if delay >= Config.CallNPCDuration then
		return true
	elseif IsPedDeadOrDying(npcPed, true) then
		return true
	else
		local npcCalling = IsEntityPlayingAnim(npcPed, "cellphone@", "cellphone_call_listen_base", 3)		
		if npcCalling == false then
			return true
		end
	end
	return false
end

-- is it synchronized?
function NPCMakingPhoneCall(npcPed)
	SetEntityAsMissionEntity(npcPed)
	ClearPedTasks(npcPed)
	loadAnimDict("cellphone@")
	TaskPlayAnim(npcPed, "cellphone@", "cellphone_call_listen_base", 3.0, -1, Config.CallNPCDuration + 2000, 50, 0, false, false, false)
end

function CleanUpNPCWarning(npcPed, npcBlip)
	SetEntityAsNoLongerNeeded(npcPed)
	if npcBlip ~= nil then
		RemoveBlip(npcBlip)
	end
end

function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(1)
	end
end