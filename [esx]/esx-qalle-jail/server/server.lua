ESX                = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand("jail", function(src, args, raw)
	local xPlayer = ESX.GetPlayerFromId(src)
	if xPlayer["job"]["name"] == "police" then
		local jailPlayer = args[1]
		local jailTime = tonumber(args[2])
		local jailReason = args[3]
		if GetPlayerName(jailPlayer) ~= nil then
			if jailTime ~= nil then
				JailPlayer(jailPlayer, jailTime)
				TriggerClientEvent("esx:showNotification", src, GetPlayerName(jailPlayer) .. " Zostałeś zamknięty za " .. jailTime .. " miesięcy!")
				if args[3] ~= nil then
					GetRPName(jailPlayer, function(Firstname, Lastname)
						TriggerClientEvent('chat:addMessage', -1, { args = { "[NEWS]",  "^4" .. Firstname .. " " .. Lastname .. " został zamknięty w więzieniu na" .. args[3] }, color = { 249, 166, 0 } })
					end)
				end
			else
				TriggerClientEvent("esx:showNotification", src, "This time is invalid!")
			end
		else
			TriggerClientEvent("esx:showNotification", src, "This ID is not online!")
		end
	else
		TriggerClientEvent("esx:showNotification", src, "You are not an officer!")
	end
end)

RegisterCommand("unjail", function(src, args)
	local xPlayer = ESX.GetPlayerFromId(src)
	if xPlayer["job"]["name"] == "police" then
		local jailPlayer = args[1]

		if GetPlayerName(jailPlayer) ~= nil then
			UnJail(jailPlayer)
		else
			TriggerClientEvent("esx:showNotification", src, "This ID is not online!")
		end
	else
		TriggerClientEvent("esx:showNotification", src, "You are not an officer!")
	end
end)

RegisterServerEvent("esx-qalle-jail:jailPlayer")
AddEventHandler("esx-qalle-jail:jailPlayer", function(targetSrc, jailTime, jailReason, jailMoney)
	local src = source
	local targetSrc = tonumber(targetSrc)
	JailPlayer(targetSrc, jailTime)
	GetRPName(targetSrc, function(Firstname, Lastname)
		TriggerClientEvent('chat:addMessage', -1, { args = { "[NEWS]",  "^4" .. Firstname .. " " .. Lastname .. "^7 został aresztowany w więzieniu na ^4" .. jailTime .. "^7 miesięcy za ^4" .. jailReason .. '^7 oraz otrzymał grzywnę w wysokości ^4' .. jailMoney .. '$'}, color = { 255, 166, 0 } })
	end)
end)

RegisterServerEvent("esx-qalle-jail:unJailPlayer")
AddEventHandler("esx-qalle-jail:unJailPlayer", function(targetIdentifier)
	local src = source
	local xPlayer = ESX.GetPlayerFromIdentifier(targetIdentifier)
	if xPlayer ~= nil then
		UnJail(xPlayer.source)
		GetRPName(src, function(Firstname, Lastname)
			TriggerClientEvent('chat:addMessage', -1, { args = { "[NEWS]",  "^4" .. Firstname .. " " .. Lastname .. "^7 został zwolniony z aresztu"}, color = { 255, 166, 0 } })
		end)
	else
		MySQL.Async.execute(
			"UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
			{
				['@identifier'] = targetIdentifier,
				['@newJailTime'] = 0
			}
		)
	end
	TriggerClientEvent("esx:showNotification", src, xPlayer.name .. " zostałeś zwolniony z więzienia!")
end)

RegisterServerEvent("esx-qalle-jail:updateJailTime")
AddEventHandler("esx-qalle-jail:updateJailTime", function(newJailTime)
	local src = source
	EditJailTime(src, newJailTime)
end)

RegisterServerEvent("esx-qalle-jail:prisonWorkReward")
AddEventHandler("esx-qalle-jail:prisonWorkReward", function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	xPlayer.addMoney(math.random(10, 80))
end)

function JailPlayer(jailPlayer, jailTime)
	TriggerClientEvent("esx-qalle-jail:jailPlayer", jailPlayer, jailTime)
	EditJailTime(jailPlayer, jailTime)
end

function UnJail(jailPlayer)
	TriggerClientEvent("esx-qalle-jail:unJailPlayer", jailPlayer)
	EditJailTime(jailPlayer, 0)
end

function EditJailTime(source, jailTime)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier
	MySQL.Async.execute(
       "UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
        {
			['@identifier'] = Identifier,
			['@newJailTime'] = tonumber(jailTime)
		}
	)
end

function GetRPName(playerId, data)
	local Identifier = ESX.GetPlayerFromId(playerId).identifier
	MySQL.Async.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)
		data(result[1].firstname, result[1].lastname)
	end)
end

ESX.RegisterServerCallback("esx-qalle-jail:retrieveJailedPlayers", function(source, cb)
	local jailedPersons = {}
	MySQL.Async.fetchAll("SELECT firstname, lastname, jail, identifier FROM users WHERE jail > @jail", { ["@jail"] = 0 }, function(result)
		for i = 1, #result, 1 do
			table.insert(jailedPersons, { name = result[i].firstname .. " " .. result[i].lastname, jailTime = result[i].jail, identifier = result[i].identifier })
		end
		cb(jailedPersons)
	end)
end)

ESX.RegisterServerCallback("esx-qalle-jail:retrieveJailTime", function(source, cb)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier
	MySQL.Async.fetchAll("SELECT jail FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)
		local JailTime = tonumber(result[1].jail)
		if JailTime > 0 then
			cb(true, JailTime)
		else
			cb(false, 0)
		end
	end)
end)