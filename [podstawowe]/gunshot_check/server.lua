ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local FiredPlayers = {}

RegisterNetEvent('gunshot:fired')
AddEventHandler('gunshot:fired', function(weapon)
	local _source = source
	--print("[GUNSHOT] Player fired: ".. _source)
	if(FiredPlayers[_source] ~= nil) then
		--FiredPlayers[_source].weapon = weapon
		FiredPlayers[_source].shotexpire = 16
	else
		--table.insert(FiredPlayers, {shotexpire = 16})
		FiredPlayers[_source] = {shotexpire = 16}
		--Citizen.Wait(100)
		--print("[GUNSHOT] Added to table: ".. FiredPlayers[_source].shotexpire)
	end
end)

RegisterNetEvent('gunshot:progress')
AddEventHandler('gunshot:progress', function()
	local _source = source
	if(FiredPlayers[_source] ~= nil) then
		if(FiredPlayers[_source].shotexpire > 0) then
			FiredPlayers[_source].shotexpire = FiredPlayers[_source].shotexpire - 1
			if(FiredPlayers[_source].shotexpire == 0) then
				FiredPlayers[_source] = nil
			end
		else
			FiredPlayers[_source] = nil
		end
	end
end)

RegisterNetEvent('gunshot:check')
AddEventHandler('gunshot:check', function(target)
	local _source = source
	local sname = ESX.GetPlayerFromId(_source)
	local sjob = sname.getJob()
	Citizen.Wait(100)
	
	if(sname ~= nil) then
		if(sjob.name == "police") then
			if(FiredPlayers[target] ~= nil) then
				TriggerClientEvent("gunshot:showInfo", _source, tonumber(FiredPlayers[target].shotexpire), target)
			else
				TriggerClientEvent("gunshot:showInfo", _source, -1, target)
			end
		end
	end
end)

TriggerEvent('es:addCommand', 'proch', function(source, args, user)
	local _source = source
	local sname = ESX.GetPlayerFromId(_source)
	local sjob = sname.getJob()
	
	local target = tonumber(args[1])
	Citizen.Wait(500)
	
	if(sname ~= nil) then
		if(sjob.name == "police") then
			if(FiredPlayers[target] ~= nil) then
				TriggerClientEvent("gunshot:showInfo", _source, tonumber(FiredPlayers[target].shotexpire), target)
			else
				TriggerClientEvent("gunshot:showInfo", _source, -1, target)
			end
		end
	end
end)