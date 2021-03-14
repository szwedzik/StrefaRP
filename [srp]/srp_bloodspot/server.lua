
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)

function getIdentity(identifier)
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],	
			sex = identity['sex'],
			height = identity['height'],
			job = identity['job']
		}
	else
		return nil
	end
end

local bloodSpots = {}
local bloodSamples = {}

RegisterNetEvent('srp_bloodspot:checkAndOpenMenu')
AddEventHandler('srp_bloodspot:checkAndOpenMenu', function(displayType)
	
	if(bloodSamples[source] == nil) then bloodSamples[source] = {0, 0, 0, 0, 0, 0, 0, 0} end
	
	local _source = source
	
	local xPlayer = ESX.GetPlayerFromId(source)
	local job = xPlayer.getJob()
	
	if(job ~= nil) then
		for i = 1, #jobsAllowed, 1 do
			if(job.name == jobsAllowed[i]) then
			
				TriggerClientEvent("srp_bloodspot:openMenu", _source, bloodSamples[source], displayType)
				break
			
			end
		end
	end
end)

RegisterNetEvent('srp_bloodspot:saveSpot')
AddEventHandler('srp_bloodspot:saveSpot', function(pos, weapon, melee)

	--print("Victim Pos: "..pos.x.." "..pos.y.." "..pos.z)
	--print("Weapon Hash: "..weapon)
	--print("Melee Attack: "..melee)
	
	local xPlayer = ESX.GetPlayerFromId(source)
	if  xPlayer ~= nil then
	local ident = xPlayer.getIdentifier()
	local player = getIdentity(ident)

	if(player ~= nil) then
	
		local rand = math.random(1,100)
		local randid = math.random(1,99999999999)
		
		if(weapon == GetHashKey("WEAPON_RUN_OVER_BY_CAR") or weapon == GetHashKey("WEAPON_FALL")) then
			if((rand >= 10 and rand <= 15) or (rand >= 80 and rand <= 90)) then
			
				if(pos.x ~= 0.0 and pos.y ~= 0.0 and pos.z ~= 0.0) then
					table.insert(bloodSpots, {bloodid = randid, character = {firstname = player.firstname, lastname = player.lastname, job = player.job, identifier = player.identifier}, src = source, position = pos, weapon = weapon, wasMelee = melee, expires = bloodLifeSpan})
					--print("BLOOD SPAWNED!")
				end
			end
		end
		
		if(weapon ~= GetHashKey("WEAPON_RUN_OVER_BY_CAR") and weapon ~= GetHashKey("WEAPON_FALL")) then
		
			if(melee) then
				if(rand >= 55 and rand <= 65) then
				
					if(pos.x ~= 0.0 and pos.y ~= 0.0 and pos.z ~= 0.0) then
						table.insert(bloodSpots, {bloodid = randid, character = {firstname = player.firstname, lastname = player.lastname, job = player.job, identifier = player.identifier}, src = source, position = pos, weapon = weapon, wasMelee = melee, expires = bloodLifeSpan})
						--print("BLOOD SPAWNED!")
					end
				end
			else
				if(CheckWeapon(hash, allowNonListedDamageSource) ~= "WT_INVALID") then
					if((rand >= 0 and rand <= 35) or (rand >= 75 and rand <= 100)) then
					
						if(pos.x ~= 0.0 and pos.y ~= 0.0 and pos.z ~= 0.0) then
							table.insert(bloodSpots, {bloodid = randid, character = {firstname = player.firstname, lastname = player.lastname, job = player.job, identifier = player.identifier}, src = source, position = pos, weapon = weapon, wasMelee = melee, expires = bloodLifeSpan})
							--print("BLOOD SPAWNED!")
						end
					end
				end
			end
		end
		
	end
end
end)



RegisterNetEvent('srp_bloodspot:anonymize')
AddEventHandler('srp_bloodspot:anonymize', function()

	for i = #bloodSpots, 1, -1 do
		bloodSpots[i].expires = bloodSpots[i].expires-1
		--print("Removing 1 time unit from bloodspot id: "..bloodSpots[i].bloodid.." Time/Health left: "..bloodSpots[i].expires)
	
		if(bloodSpots[i].expires <= 0) then
			--print("Removing bloodspot id: "..bloodSpots[i].bloodid)
			table.remove(bloodSpots, i)
		end
	end
	
end)

RegisterNetEvent('srp_bloodspot:checkJob')
AddEventHandler('srp_bloodspot:checkJob', function()

	local _source = source

	local xPlayer = ESX.GetPlayerFromId(source)
	
	local shouldSee = false
	if xPlayer ~= nil then
		local job = xPlayer.getJob()
		if(job ~= nil) then
			for p = 1, #jobsAllowed, 1 do
				if(job.name == jobsAllowed[p]) then
					shouldSee = true
					break
				end
			end
		end
	end
	TriggerClientEvent('srp_bloodspot:updateVisibility', source, shouldSee)

end)


RegisterNetEvent('srp_bloodspot:getBloodSamples')
AddEventHandler('srp_bloodspot:getBloodSamples', function()

	TriggerClientEvent('srp_bloodspot:updateBloodSamples', source, bloodSamples[source])

end)


RegisterNetEvent('srp_bloodspot:replaceSampleStick')
AddEventHandler('srp_bloodspot:replaceSampleStick', function(stickId, check)

	if(bloodSamples[source] == nil) then bloodSamples[source] = {0, 0, 0, 0, 0, 0, 0, 0} end
	
	if(tonumber(bloodSamples[source][tonumber(stickId)]) ~= 0) then
		bloodSamples[source][tonumber(stickId)] = 0
		TriggerClientEvent('srp_bloodspot:updateBloodSamples', source, bloodSamples[source])
		TriggerClientEvent("srp_bloodspot:sendNotify", source, "success", "Patyczek został wymieniony! ", 3500, nil)
	else
		TriggerClientEvent("srp_bloodspot:sendNotify", source, "error", "Ten patyczek nie został jeszcze użyty!", 3500, nil)
	end

end)

RegisterNetEvent('srp_bloodspot:pickupBloodSample')
AddEventHandler('srp_bloodspot:pickupBloodSample', function(bloodid)

	local _source = source

	local xPlayer = ESX.GetPlayerFromId(source)
	local job = xPlayer.getJob()
	
	if(job ~= nil) then
		for p = 1, #jobsAllowed, 1 do
			if(job.name == jobsAllowed[p]) then
				for i = #bloodSpots, 1, -1 do
				
					if(bloodSpots[i].bloodid == bloodid) then
						
						if(bloodSamples[_source] == nil) then bloodSamples[_source] = {0, 0, 0, 0, 0, 0, 0, 0} end
						
						local canPickup = false
						
						for s = 1, #bloodSamples[_source], 1 do
							if(bloodSamples[_source][s] == 0) then
								canPickup = true
								break
							end
						end
						
						if(canPickup == true) then
							local rand = math.random(1,100)
							local randmi = bloodSpots[i].expires/bloodLifeSpan
							
							local minChance = 100-minChanceToPickup
							
							local randmin = minChance-math.floor(minChance*randmi)
							
							if(rand >= 0 and rand <= 100-randmin) then
								bloodSpots[i].position = nil
								
								for s = 1, #bloodSamples[_source], 1 do
									if(bloodSamples[_source][s] == 0) then
										TriggerClientEvent("srp_bloodspot:sendNotify", _source, "error", "Podniesiono próbkę krwi", 3500, nil)
										bloodSamples[_source][s] = bloodSpots[i]
										break
									end
								end
								
							elseif(rand > 100-randmin) then
								TriggerClientEvent("srp_bloodspot:sendNotify", _source, "error", "Ta próbka krwi nie nadaje się do niczego!", 3500, nil)
							end
						
							table.remove(bloodSpots, i)
							TriggerClientEvent("srp_bloodspot:removeBloodSpot", -1, bloodid)
							
							break
						else
							TriggerClientEvent("srp_bloodspot:sendNotify", _source, "error", "Nie możesz zebrać już więcej próbek!", 3500, nil)
							break
						end
					
					end
				
				end
				
				TriggerClientEvent("srp_bloodspot:updatePlayer", _source, bloodSpots)
				break
			end
		end
	end
end)


Citizen.CreateThread( function()
    while true do
        Wait(5000)
		TriggerClientEvent("srp_bloodspot:updatePlayer", -1, bloodSpots)
	end
end)


Citizen.CreateThread( function()
    while true do
        Wait(bloodExpirationSpeed*1000)
		TriggerEvent("srp_bloodspot:anonymize")
	end
end)

function CheckWeapon(hash, allowNotListed)
    if(type(hash) ~= "string") then
        hash = tostring(hash)
    end

    local label = WEAPONS[hash]
    if label ~= nil then
        return label
    end

    Citizen.Trace("Error reversing weapon hash \"" .. hash .. "\". Maybe it's not been added yet?")
	if(allowNotListed == false or allowNotListed == nil) then
		return "WT_INVALID"
	elseif(allowNotListed == true) then
		return "WT_ALLOW_NONLISTED"
	end
end