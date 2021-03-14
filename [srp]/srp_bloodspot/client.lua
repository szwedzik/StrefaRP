local bloodSpots = {}
local bloodSamples = {0, 0, 0, 0, 0, 0, 0, 0}

local shouldSeeMarkers = false

local visibleBlood = {}
local currentBlood = nil

AddEventHandler("gameEventTriggered", 
	function(eventName, list)
	
		local pos = GetEntityCoords(PlayerPedId())
	
		if (eventName == "CEventNetworkEntityDamage") then
        
			if(list[1] == GetPlayerPed(-1)) then
			
				local victim = list[1]
				local attacker = list[2]
				local weapon = list[5]
				local isMelee = list[10]
				
				local rayCas = StartShapeTestRay(pos.x, pos.y, pos.z, pos.x, pos.y, pos.z-10.0, 1, GetPlayerPed(-1), 0)
				local retval, hit, coords, surface, entity = GetShapeTestResult(rayCas)
				
				TriggerServerEvent("srp_bloodspot:saveSpot", coords, weapon, isMelee)
			end
		
		end
	end)


RegisterNetEvent('srp_bloodspot:updateVisibility')
AddEventHandler('srp_bloodspot:updateVisibility', function(shouldSee)

	shouldSeeMarkers = shouldSee

end)
	
RegisterNetEvent('srp_bloodspot:updateBloodSamples')
AddEventHandler('srp_bloodspot:updateBloodSamples', function(samplesArray)

	if(samplesArray ~= nil) then
		bloodSamples = samplesArray
	end

end)

RegisterNetEvent('srp_bloodspot:updatePlayer')
AddEventHandler('srp_bloodspot:updatePlayer', function(bloodArray, samplesArray)

	bloodSpots = bloodArray
	TriggerServerEvent("srp_bloodspot:getBloodSamples")
	TriggerServerEvent("srp_bloodspot:checkJob")

end)


RegisterNetEvent('srp_bloodspot:removeBloodSpot')
AddEventHandler('srp_bloodspot:removeBloodSpot', function(bloodid)

	for i = #bloodSpots, 1, -1 do
	
		if(bloodSpots[i].bloodid == bloodid) then
		
			table.remove(bloodSpots, i)
			currentBlood = nil
			break
		
		end
	
	end
	
end)


RegisterNetEvent('srp_bloodspot:sendNotify')
AddEventHandler('srp_bloodspot:sendNotify', function(msgtype, text, timeout, style)

	if(style == nil) then
		exports['mythic_notify']:DoCustomHudText(msgtype, text, tonumber(timeout))
	else
		exports['mythic_notify']:DoCustomHudText(msgtype, text, tonumber(timeout), style)
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
		
		if(shouldSeeMarkers == true) then
			--SetNuiFocus(false, false)
			
			local pos = GetEntityCoords(PlayerPedId())
			local shouldBeVisible = {}
			for i=1, #bloodSpots, 1 do
				if GetDistanceBetweenCoords(pos, tonumber(bloodSpots[i].position.x), tonumber(bloodSpots[i].position.y), tonumber(bloodSpots[i].position.z), false) <= 15.0 then
					table.insert(shouldBeVisible, i)
				end
			end
			
			 for b=1, #shouldBeVisible, 1 do
				
				local i = shouldBeVisible[b]
			 
				if GetDistanceBetweenCoords(pos, tonumber(bloodSpots[i].position.x), tonumber(bloodSpots[i].position.y), tonumber(bloodSpots[i].position.z), false) < 0.5 then

					currentBlood = i
					
					break
				end
			end
			
			visibleBlood = shouldBeVisible
		else
			visibleBlood = {}
			currentBlood = nil
		end
		
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		
		if(shouldSeeMarkers == true) then
			for b=1, #visibleBlood, 1 do
				local i = visibleBlood[b]
			
				if(bloodSpots[i] ~= nil) then
					DrawMarker(27, bloodSpots[i].position.x, bloodSpots[i].position.y, bloodSpots[i].position.z+0.075, 0, 0, 0, 0, 0, 0, 0.15, 0.15, 0.15, 255, 0, 0, 60, 0, 0, 2, 0, 0, 0, 0)
				end
			end
		end
	end
end)	


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		
		local pos = GetEntityCoords(PlayerPedId())
		
		if(currentBlood ~= nil) then
			if GetDistanceBetweenCoords(pos, tonumber(bloodSpots[currentBlood].position.x), tonumber(bloodSpots[currentBlood].position.y), tonumber(bloodSpots[currentBlood].position.z), false) < 0.5 then
				if IsControlJustReleased(0, Keys['Pickup']) then
					if(shouldSeeMarkers == true) then
						startAnim('amb@medic@standing@tendtodead@idle_a', 'idle_a')
						Citizen.Wait(3000)
						startAnim('amb@medic@standing@tendtodead@exit', 'exit')
						Citizen.Wait(1000)
						
						TriggerServerEvent("srp_bloodspot:pickupBloodSample", bloodSpots[currentBlood].bloodid)
					end
				end
			
			end
		end
		
		local displayType = "show-nobtns"
		
		if IsControlJustReleased(0, Keys['Menu']) then
			for i = 1, #analyzeSpots, 1 do
				if GetDistanceBetweenCoords(pos, tonumber(analyzeSpots[i].x), tonumber(analyzeSpots[i].y), tonumber(analyzeSpots[i].z), false) < 3.0 then
					displayType = "show"
					break
				end
			end
			
			TriggerServerEvent("srp_bloodspot:checkAndOpenMenu", displayType)
		end
	end
end)	


RegisterNetEvent('srp_bloodspot:openMenu')
AddEventHandler('srp_bloodspot:openMenu', function(samplesData, displayType)

	SendNUIMessage({type = displayType, samples = samplesData})
	SetNuiFocus(true, true)
	
end)

RegisterNUICallback('exit', function(data, cb)
	SendNUIMessage({type = 'hide'})
	SetNuiFocus(false, false)
end)

RegisterNUICallback('clearSampleStick', function(data, cb)

	TriggerServerEvent("srp_bloodspot:replaceSampleStick", data.slot, data.id)

	SendNUIMessage({type = 'hide'})
	SetNuiFocus(false, false)
end)

RegisterNUICallback('showSampleData', function(data, cb)

	
	if(bloodSamples[tonumber(data.slot)] ~= 0) then
		if(tonumber(bloodSamples[tonumber(data.slot)].bloodid) == tonumber(data.id)) then
			TriggerEvent("srp_bloodspot:sendNotify", 'error', "Próbka krwi nalezy do: "..bloodSamples[tonumber(data.slot)].character.firstname.." "..bloodSamples[tonumber(data.slot)].character.lastname, 3500, nil)
		end
	else
		TriggerEvent("srp_bloodspot:sendNotify", 'error', "Na tym patyczku nie ma żadnej próbki!", 3500, nil)
	end

	SendNUIMessage({type = 'hide'})
	SetNuiFocus(false, false)
end)

function startAnim(lib, anim)
	Citizen.CreateThread(function()
	  RequestAnimDict(lib)
	  while not HasAnimDictLoaded(lib) do
	    Citizen.Wait(0)
	  end
	  TaskPlayAnim(GetPlayerPed(-1), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
	end)
end