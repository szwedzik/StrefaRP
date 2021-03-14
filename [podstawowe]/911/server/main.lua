ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname']
		}
	else
		return nil
	end
end

--- LSPD/LSSD/SASP
RegisterServerEvent('srp:911')
AddEventHandler('srp:911', function(location, msg)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	local xJob = xPlayer.getJob()
	local playername = GetPlayerName(source)

	local name = getIdentity(_source)
	local rname = name.firstname.. " " ..name.lastname
	TriggerClientEvent("outlawNotify", -1,  "[Centrala]: ^1911 ^7 - Zgłoszenie | ^3Imie i nazwisko ^7".. rname .. " ^7| ^1Ulica ^7| ^7".. location .. '^*^4 | Treść: ^r' .. msg)
end)

RegisterServerEvent('srp:a911')
AddEventHandler('srp:a911', function(location, msg)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	local xJob = xPlayer.getJob()
	local playername = GetPlayerName(source)

	local name = getIdentity(_source)
	local rname = name.firstname.. " " ..name.lastname
	TriggerClientEvent("outlawNotify", -1,  "[Centrala]: ^1911 ^7 - Zgłoszenie | ^3Anonim ^7| ^1Ulica ^7| ^7".. location .. '^*^4 | Treść: ^r' .. msg)
end)

RegisterServerEvent('srp:911check')
AddEventHandler('srp:911check', function(x, y, z) 
	TriggerClientEvent('srp:911', -1, x, y, z)
end)

--- Ambulance
RegisterServerEvent('srp:101')
AddEventHandler('srp:101', function(location, msg)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	local xJob = xPlayer.getJob()
	local playername = GetPlayerName(source)

	local name = getIdentity(_source)
	local rname = name.firstname.. " " ..name.lastname
	TriggerClientEvent("outlawNotifyLSFD", -1,  "[Centrala]: ^1LSFD ^7 - Zgłoszenie | ^3Imie i nazwisko ^7".. rname .. " ^7| ^1Ulica ^7| ^7".. location .. '^*^4 | Treść: ^r' .. msg)
end)

RegisterServerEvent('srp:101check')
AddEventHandler('srp:101check', function(x, y, z) 
	TriggerClientEvent('srp:101', -1, x, y, z)
end)

--- Zwierzak
RegisterServerEvent('srp:0700')
AddEventHandler('srp:0700', function(location, msg)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	local xJob = xPlayer.getJob()
	local playername = GetPlayerName(source)

	local name = getIdentity(_source)
	local rname = name.firstname.. " " ..name.lastname
	TriggerClientEvent("outlawNotifyJC", -1,  "[Centrala]: ^1Janush Customs ^7 - Zgłoszenie | ^3Imie i nazwisko ^7".. rname .. " ^7| ^1Ulica ^7| ^7".. location .. '^*^4 | Treść: ^r' .. msg)
end)

RegisterServerEvent('srp:0700check')
AddEventHandler('srp:0700check', function(x, y, z) 
	TriggerClientEvent('srp:0700', -1, x, y, z)
end)

--- Kinia
RegisterServerEvent('srp:0800')
AddEventHandler('srp:0800', function(location, msg)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	local xJob = xPlayer.getJob()
	local playername = GetPlayerName(source)

	local name = getIdentity(_source)
	local rname = name.firstname.. " " ..name.lastname
	TriggerClientEvent("outlawNotifyJC", -1,  "[Centrala]: ^1Carzone Garage ^7 - Zgłoszenie | ^3Imie i nazwisko ^7".. rname .. " ^7| ^1Ulica ^7| ^7".. location .. '^*^4 | Treść: ^r' .. msg)
end)

RegisterServerEvent('srp:0800check')
AddEventHandler('srp:0800check', function(x, y, z) 
	TriggerClientEvent('srp:0800', -1, x, y, z)
end)

--- Taxi
RegisterServerEvent('srp:taxi')
AddEventHandler('srp:taxi', function(location, msg)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	local xJob = xPlayer.getJob()
	local playername = GetPlayerName(source)

	local name = getIdentity(_source)
	local rname = name.firstname.. " " ..name.lastname
	TriggerClientEvent("outlawNotifyJC", -1,  "[Centrala]: ^1TAXI ^7 - Zgłoszenie | ^3Imie i nazwisko ^7".. rname .. " ^7| ^1Ulica ^7| ^7".. location .. '^*^4 | Treść: ^r' .. msg)
end)

RegisterServerEvent('srp:taxicheck')
AddEventHandler('srp:taxicheck', function(x, y, z) 
	TriggerClientEvent('srp:taxi', -1, x, y, z)
end)