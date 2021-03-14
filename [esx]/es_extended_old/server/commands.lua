TriggerEvent('es:addGroupCommand', 'tp', 'admin', function(source, args, user)
	local x = tonumber(args[1])
	local y = tonumber(args[2])
	local z = tonumber(args[3])
	local ip = GetPlayerEndpoint(source)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local identifier = GetPlayerIdentifiers(source)[1]
		for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
			if string.match(foundID, "license:") then
				licenserc = string.sub(foundID, 9)
			elseif string.match(foundID, "discord:") then
				discordid = string.sub(foundID, 9)
			end
		end
	
	if x and y and z then
		TriggerClientEvent('esx:teleport', source, {
			x = x,
			y = y,
			z = z
		})
		TriggerEvent('srp_logs:adminLog', GetPlayerName(source), "/tp "..x.." "..y.." "..z, discordid, sourceXPlayer.identifier, licenserc, ip)
		TriggerEvent('srp_logs:adminTpLog', GetPlayerName(source), x, y, z, discordid, sourceXPlayer.identifier, licenserc, ip)
	else
		TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Invalid coordinates!")
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Teleport to coordinates", params = {{name = "x", help = "X coords"}, {name = "y", help = "Y coords"}, {name = "z", help = "Z coords"}}})

TriggerEvent('es:addGroupCommand', 'setjob', 'superadmin', function(source, args, user)
	if tonumber(args[1]) and args[2] and tonumber(args[3]) then
		local xPlayer = ESX.GetPlayerFromId(args[1])
		local ip = GetPlayerEndpoint(source)
		local targetip = GetPlayerEndpoint(args[1])
		local targetXPlayer = ESX.GetPlayerFromId(args[1])
		local sourceXPlayer = ESX.GetPlayerFromId(source)
		local identifier = GetPlayerIdentifiers(source)[1]
		for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
			if string.match(foundID, "license:") then
				licenserc = string.sub(foundID, 9)
			elseif string.match(foundID, "discord:") then
				discordid = string.sub(foundID, 9)
			end
		end
		local identifier = GetPlayerIdentifiers(args[1])[1]
		for _, foundID in ipairs(GetPlayerIdentifiers(args[1])) do
			if string.match(foundID, "license:") then
				targetlicenserc = string.sub(foundID, 9)
			elseif string.match(foundID, "discord:") then
				targetdiscordid = string.sub(foundID, 9)
			end
		end

		if xPlayer then
			if ESX.DoesJobExist(args[2], args[3]) then
				xPlayer.setJob(args[2], args[3])
				TriggerEvent('srp_logs:adminTargetLog', GetPlayerName(source), "/setjob " ..args[1].. " " ..args[2].. " " ..args[3], GetPlayerName(args[1]), discordid, sourceXPlayer.identifier, licenserc, ip, targetdiscordid, targetXPlayer.identifier, targetlicenserc, targetip)
				TriggerEvent('srp_logs:adminSetJobLog',GetPlayerName(source), args[2], args[3], GetPlayerName(args[1]), discordid, sourceXPlayer.identifier, licenserc, ip, targetdiscordid, targetXPlayer.identifier, targetlicenserc, targetip)
			else
				TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'That job does not exist.' } })
			end

		else
			TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player not online.' } })
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Invalid usage.' } })
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('setjob'), params = {{name = "id", help = _U('id_param')}, {name = "job", help = _U('setjob_param2')}, {name = "grade_id", help = _U('setjob_param3')}}})

TriggerEvent('es:addGroupCommand', 'loadipl', 'admin', function(source, args, user)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local ip = GetPlayerEndpoint(source)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local ip = GetPlayerEndpoint(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
		if string.match(foundID, "license:") then
			licenserc = string.sub(foundID, 9)
		elseif string.match(foundID, "discord:") then
			discordid = string.sub(foundID, 9)
		end
	end
	TriggerClientEvent('esx:loadIPL', -1, args[1])
	TriggerEvent('srp_logs:adminLog', GetPlayerName(source), "/loadipl " ..args[1], discordid, sourceXPlayer.identifier, licenserc, ip)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('load_ipl')})

TriggerEvent('es:addGroupCommand', 'unloadipl', 'admin', function(source, args, user)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local ip = GetPlayerEndpoint(source)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local ip = GetPlayerEndpoint(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
		if string.match(foundID, "license:") then
			licenserc = string.sub(foundID, 9)
		elseif string.match(foundID, "discord:") then
			discordid = string.sub(foundID, 9)
		end
	end
	TriggerClientEvent('esx:unloadIPL', -1, args[1])
	TriggerEvent('srp_logs:adminLog', GetPlayerName(source), "/unloadipl " ..args[1], discordid, sourceXPlayer.identifier, licenserc, ip)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('unload_ipl')})

TriggerEvent('es:addGroupCommand', 'playanim', 'admin', function(source, args, user)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local ip = GetPlayerEndpoint(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
		if string.match(foundID, "license:") then
			licenserc = string.sub(foundID, 9)
		elseif string.match(foundID, "discord:") then
			discordid = string.sub(foundID, 9)
		end
	end
	TriggerClientEvent('esx:playAnim', -1, args[1], args[3])
	TriggerEvent('srp_logs:adminLog', GetPlayerName(source), "/playanim " ..args[1], discordid, sourceXPlayer.identifier, licenserc, ip)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('play_anim')})

TriggerEvent('es:addGroupCommand', 'playemote', 'admin', function(source, args, user)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local ip = GetPlayerEndpoint(source)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local ip = GetPlayerEndpoint(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
		if string.match(foundID, "license:") then
			licenserc = string.sub(foundID, 9)
		elseif string.match(foundID, "discord:") then
			discordid = string.sub(foundID, 9)
		end
	end
	TriggerClientEvent('esx:playEmote', -1, args[1])
	TriggerEvent('srp_logs:adminLog', GetPlayerName(source), "/playemote " ..args[1], discordid, sourceXPlayer.identifier, licenserc, ip)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('play_emote')})

TriggerEvent('es:addGroupCommand', 'car', 'admin', function(source, args, user)
	TriggerClientEvent('esx:spawnVehicle', source, args[1])
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local ip = GetPlayerEndpoint(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
		if string.match(foundID, "license:") then
			licenserc = string.sub(foundID, 9)
		elseif string.match(foundID, "discord:") then
			discordid = string.sub(foundID, 9)
		end
	end
	Citizen.Wait(500)
	TriggerEvent('srp_logs:adminLog', GetPlayerName(source), "/car " ..args[1], discordid, sourceXPlayer.identifier, licenserc, ip)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('spawn_car'), params = {{name = "car", help = _U('spawn_car_param')}}})

TriggerEvent('es:addGroupCommand', 'mod', 'admin', function(source, args, user)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local ip = GetPlayerEndpoint(source)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local ip = GetPlayerEndpoint(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
		if string.match(foundID, "license:") then
			licenserc = string.sub(foundID, 9)
		elseif string.match(foundID, "discord:") then
			discordid = string.sub(foundID, 9)
		end
	end
	TriggerClientEvent('esx:deleteVehicle', source)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('delete_vehicle')})

TriggerEvent('es:addGroupCommand', 'mod', 'admin', function(source, args, user)
	TriggerClientEvent('esx:deleteVehicle', source)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local ip = GetPlayerEndpoint(source)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local ip = GetPlayerEndpoint(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
		if string.match(foundID, "license:") then
			licenserc = string.sub(foundID, 9)
		elseif string.match(foundID, "discord:") then
			discordid = string.sub(foundID, 9)
		end
	end
	TriggerEvent('srp_logs:adminLog', GetPlayerName(source), "/dv", discordid, sourceXPlayer.identifier, licenserc, ip)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('delete_vehicle')})

TriggerEvent('es:addGroupCommand', 'spawnped', 'admin', function(source, args, user)
	TriggerClientEvent('esx:spawnPed', source, args[1])
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local ip = GetPlayerEndpoint(source)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local ip = GetPlayerEndpoint(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
		if string.match(foundID, "license:") then
			licenserc = string.sub(foundID, 9)
		elseif string.match(foundID, "discord:") then
			discordid = string.sub(foundID, 9)
		end
	end
	TriggerEvent('srp_logs:adminLog', GetPlayerName(source), "/spawnped " ..args[1], discordid, sourceXPlayer.identifier, licenserc, ip)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('spawn_ped'), params = {{name = "name", help = _U('spawn_ped_param')}}})

TriggerEvent('es:addGroupCommand', 'spawnobject', 'admin', function(source, args, user)
	TriggerClientEvent('esx:spawnObject', source, args[1])
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local ip = GetPlayerEndpoint(source)
	
	TriggerEvent('srp_logs:adminLog', GetPlayerName(source), "/spawnobject " ..args[1], discordid, sourceXPlayer.identifier, licenserc, ip)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('spawn_object'), params = {{name = "name"}}})

TriggerEvent('es:addGroupCommand', 'setmoney', 'admin', function(source, args, user)
	local _source = source
	local target = tonumber(args[1])
	local money_type = args[2]
	local money_amount = tonumber(args[3])
	local ip = GetPlayerEndpoint(source)
	local targetip = GetPlayerEndpoint(args[1])
	local targetXPlayer = ESX.GetPlayerFromId(args[1])
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
		if string.match(foundID, "license:") then
			licenserc = string.sub(foundID, 9)
		elseif string.match(foundID, "discord:") then
			discordid = string.sub(foundID, 9)
		end
	end
	local identifier = GetPlayerIdentifiers(args[1])[1]
	for _, foundID in ipairs(GetPlayerIdentifiers(args[1])) do
		if string.match(foundID, "license:") then
			targetlicenserc = string.sub(foundID, 9)
		elseif string.match(foundID, "discord:") then
			targetdiscordid = string.sub(foundID, 9)
		end
	end
	
	local xPlayer = ESX.GetPlayerFromId(target)

	if target and money_type and money_amount and xPlayer ~= nil then
		if money_type == 'cash' then
			xPlayer.setMoney(money_amount)
			TriggerEvent('srp_logs:adminTargetLog', GetPlayerName(source), "/setmoney " ..money_type.. " " ..money_amount, GetPlayerName(target), discordid, sourceXPlayer.identifier, licenserc, ip, targetdiscordid, targetXPlayer.identifier, targetlicenserc, targetip)
		elseif money_type == 'bank' then
			xPlayer.setAccountMoney('bank', money_amount)
			TriggerEvent('srp_logs:adminTargetLog', GetPlayerName(source), "/setmoney " ..money_type.. " " ..money_amount, GetPlayerName(target), discordid, sourceXPlayer.identifier, licenserc, ip, targetdiscordid, targetXPlayer.identifier, targetlicenserc, targetip)
		elseif money_type == 'black' then
			xPlayer.setAccountMoney('black_money', money_amount)
			TriggerEvent('srp_logs:adminTargetLog', GetPlayerName(source), "/setmoney " ..money_type.. " " ..money_amount, GetPlayerName(target), discordid, sourceXPlayer.identifier, licenserc, ip, targetdiscordid, targetXPlayer.identifier, targetlicenserc, targetip)
		else
			TriggerClientEvent('chatMessage', _source, "SYSTEM", {255, 0, 0}, "^2" .. money_type .. " ^0 is not a valid money type!")
			return
		end
	else
		TriggerClientEvent('chatMessage', _source, "SYSTEM", {255, 0, 0}, "Invalid arguments.")
		return
	end
	
	--print('es_extended: ' .. GetPlayerName(source) .. ' just set $' .. money_amount .. ' (' .. money_type .. ') to ' .. xPlayer.name)
	
	if xPlayer.source ~= _source then
		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('money_set', money_amount, money_type))
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('setmoney'), params = {{name = "id", help = _U('id_param')}, {name = "money type", help = _U('money_type')}, {name = "amount", help = _U('money_amount')}}})

--[[
TriggerEvent('es:addGroupCommand', 'giveaccountmoney', 'admin', function(source, args, user)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(args[1])
	local account = args[2]
	local amount  = tonumber(args[3])

	if amount ~= nil then
		if xPlayer.getAccount(account) ~= nil then
			xPlayer.addAccountMoney(account, amount)
			TriggerEvent('srp_logs:adminTargetLog', GetPlayerName(source), "/giveaccountmoney " ..money_type.. " " ..money_amount, GetPlayerName(target), discordid, sourceXPlayer.identifier, licenserc, ip, targetdiscordid, targetXPlayer.identifier, targetlicenserc, targetip)
		else
			TriggerClientEvent('esx:showNotification', _source, _U('invalid_account'))
		end
	else
		TriggerClientEvent('esx:showNotification', _source, _U('amount_invalid'))
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('giveaccountmoney'), params = {{name = "id", help = _U('id_param')}, {name = "account", help = _U('account')}, {name = "amount", help = _U('money_amount')}}})
--]]

TriggerEvent('es:addGroupCommand', 'giveitem', 'admin', function(source, args, user)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(args[1])
	local item    = args[2]
	local count   = (args[3] == nil and 1 or tonumber(args[3]))
	local ip = GetPlayerEndpoint(source)
	local targetip = GetPlayerEndpoint(args[1])
	local targetXPlayer = ESX.GetPlayerFromId(args[1])
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
		if string.match(foundID, "license:") then
			licenserc = string.sub(foundID, 9)
		elseif string.match(foundID, "discord:") then
			discordid = string.sub(foundID, 9)
		end
	end
	local identifier = GetPlayerIdentifiers(args[1])[1]
	for _, foundID in ipairs(GetPlayerIdentifiers(args[1])) do
		if string.match(foundID, "license:") then
			targetlicenserc = string.sub(foundID, 9)
		elseif string.match(foundID, "discord:") then
			targetdiscordid = string.sub(foundID, 9)
		end
	end

	if count ~= nil then
		if xPlayer.getInventoryItem(item) ~= nil then
			xPlayer.addInventoryItem(item, count)
			TriggerEvent('srp_logs:adminTargetLog', GetPlayerName(source), "/giveitem " ..args[1].. " " ..item.. " " ..count, GetPlayerName(args[1]), discordid, sourceXPlayer.identifier, licenserc, ip, targetdiscordid, targetXPlayer.identifier, targetlicenserc, targetip)
			TriggerEvent('srp_logs:adminGiveItemLog',GetPlayerName(source), item, count, GetPlayerName(args[1]), discordid, sourceXPlayer.identifier, licenserc, ip, targetdiscordid, targetXPlayer.identifier, targetlicenserc, targetip)
		else
			TriggerClientEvent('esx:showNotification', _source, _U('invalid_item'))
		end
	else
		TriggerClientEvent('esx:showNotification', _source, _U('invalid_amount'))
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('giveitem'), params = {{name = "id", help = _U('id_param')}, {name = "item", help = _U('item')}, {name = "amount", help = _U('amount')}}})

TriggerEvent('es:addGroupCommand', 'giveweapon', 'admin', function(source, args, user)
	local xPlayer    = ESX.GetPlayerFromId(args[1])
	local weaponName = string.upper(args[2])
	local ip = GetPlayerEndpoint(source)
	local targetip = GetPlayerEndpoint(args[1])
	local targetXPlayer = ESX.GetPlayerFromId(args[1])
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
		if string.match(foundID, "license:") then
			licenserc = string.sub(foundID, 9)
		elseif string.match(foundID, "discord:") then
			discordid = string.sub(foundID, 9)
		end
	end
	local identifier = GetPlayerIdentifiers(args[1])[1]
	for _, foundID in ipairs(GetPlayerIdentifiers(args[1])) do
		if string.match(foundID, "license:") then
			targetlicenserc = string.sub(foundID, 9)
		elseif string.match(foundID, "discord:") then
			targetdiscordid = string.sub(foundID, 9)
		end
	end

	xPlayer.addWeapon(weaponName, tonumber(args[3]))
	TriggerEvent('srp_logs:adminTargetLog', GetPlayerName(source), "/giveweapon " ..args[1].. " " ..weaponName.. " " ..args[3], GetPlayerName(args[1]), discordid, sourceXPlayer.identifier, licenserc, ip, targetdiscordid, targetXPlayer.identifier, targetlicenserc, targetip)
	TriggerEvent('srp_logs:adminGiveWeaponLog',GetPlayerName(source), weaponName, args[3], GetPlayerName(args[1]), discordid, sourceXPlayer.identifier, licenserc, ip, targetdiscordid, targetXPlayer.identifier, targetlicenserc, targetip)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('giveweapon'), params = {{name = "id", help = _U('id_param')}, {name = "weapon", help = _U('weapon')}, {name = "ammo", help = _U('amountammo')}}})

TriggerEvent('es:addGroupCommand', 'disc', 'admin', function(source, args, user)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local ip = GetPlayerEndpoint(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
		if string.match(foundID, "license:") then
			licenserc = string.sub(foundID, 9)
		elseif string.match(foundID, "discord:") then
			discordid = string.sub(foundID, 9)
		end
	end
	DropPlayer(source, 'You have been disconnected')
	TriggerEvent('srp_logs:adminLog', GetPlayerName(source), "/disc ", discordid, sourceXPlayer.identifier, licenserc, ip)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end)

TriggerEvent('es:addGroupCommand', 'disconnect', 'admin', function(source, args, user)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local ip = GetPlayerEndpoint(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
		if string.match(foundID, "license:") then
			licenserc = string.sub(foundID, 9)
		elseif string.match(foundID, "discord:") then
			discordid = string.sub(foundID, 9)
		end
	end
	DropPlayer(source, 'You have been disconnected')
	TriggerEvent('srp_logs:adminLog', GetPlayerName(source), "/disconnect ", discordid, sourceXPlayer.identifier, licenserc, ip)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('disconnect')})

TriggerEvent('es:addGroupCommand', 'clear', 'user', function(source, args, user)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local ip = GetPlayerEndpoint(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
		if string.match(foundID, "license:") then
			licenserc = string.sub(foundID, 9)
		elseif string.match(foundID, "discord:") then
			discordid = string.sub(foundID, 9)
		end
	end
	TriggerClientEvent('chat:clear', source)
	TriggerEvent('srp_logs:adminLog', GetPlayerName(source), "/clear ", discordid, sourceXPlayer.identifier, licenserc, ip)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('chat_clear')})

TriggerEvent('es:addGroupCommand', 'cls', 'user', function(source, args, user)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local ip = GetPlayerEndpoint(source)
	TriggerClientEvent('chat:clear', source)
	TriggerEvent('srp_logs:adminLog', GetPlayerName(source), "/cls ", discordid, sourceXPlayer.identifier, licenserc, ip)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end)

TriggerEvent('es:addGroupCommand', 'clsall', 'admin', function(source, args, user)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local ip = GetPlayerEndpoint(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
		if string.match(foundID, "license:") then
			licenserc = string.sub(foundID, 9)
		elseif string.match(foundID, "discord:") then
			discordid = string.sub(foundID, 9)
		end
	end
	TriggerClientEvent('chat:clear', -1)
	TriggerEvent('srp_logs:adminLog', GetPlayerName(source), "/clsall ", discordid, sourceXPlayer.identifier, licenserc, ip)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end)

TriggerEvent('es:addGroupCommand', 'clearall', 'admin', function(source, args, user)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local ip = GetPlayerEndpoint(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
		if string.match(foundID, "license:") then
			licenserc = string.sub(foundID, 9)
		elseif string.match(foundID, "discord:") then
			discordid = string.sub(foundID, 9)
		end
	end
	TriggerClientEvent('chat:clear', -1)
	TriggerEvent('srp_logs:adminLog', GetPlayerName(source), "/clearall ", discordid, sourceXPlayer.identifier, licenserc, ip)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('chat_clear_all')})

TriggerEvent('es:addGroupCommand', 'clearinventory', 'admin', function(source, args, user)
	local xPlayer
	local ip = GetPlayerEndpoint(source)
	local targetip = GetPlayerEndpoint(args[1])
	local targetXPlayer = ESX.GetPlayerFromId(args[1])
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
		if string.match(foundID, "license:") then
			licenserc = string.sub(foundID, 9)
		elseif string.match(foundID, "discord:") then
			discordid = string.sub(foundID, 9)
		end
	end
	local identifier = GetPlayerIdentifiers(args[1])[1]
	for _, foundID in ipairs(GetPlayerIdentifiers(args[1])) do
		if string.match(foundID, "license:") then
			targetlicenserc = string.sub(foundID, 9)
		elseif string.match(foundID, "discord:") then
			targetdiscordid = string.sub(foundID, 9)
		end
	end

	if args[1] then
		xPlayer = ESX.GetPlayerFromId(args[1])
	else
		xPlayer = ESX.GetPlayerFromId(source)
	end

	if not xPlayer then
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player not online.' } })
		return
	end

	for i=1, #xPlayer.inventory, 1 do
		if xPlayer.inventory[i].count > 0 then
			xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
			TriggerEvent('srp_logs:adminTargetLog', GetPlayerName(source), "/clearinventory " ..args[1], GetPlayerName(args[1]), discordid, sourceXPlayer.identifier, licenserc, ip, targetdiscordid, targetXPlayer.identifier, targetlicenserc, targetip)
		end
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('command_clearinventory'), params = {{name = "playerId", help = _U('command_playerid_param')}}})

TriggerEvent('es:addGroupCommand', 'clearloadout', 'admin', function(source, args, user)
	local xPlayer
	local ip = GetPlayerEndpoint(source)
	local targetip = GetPlayerEndpoint(args[1])
	local targetXPlayer = ESX.GetPlayerFromId(args[1])
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
		if string.match(foundID, "license:") then
			licenserc = string.sub(foundID, 9)
		elseif string.match(foundID, "discord:") then
			discordid = string.sub(foundID, 9)
		end
	end
	local identifier = GetPlayerIdentifiers(args[1])[1]
	for _, foundID in ipairs(GetPlayerIdentifiers(args[1])) do
		if string.match(foundID, "license:") then
			targetlicenserc = string.sub(foundID, 9)
		elseif string.match(foundID, "discord:") then
			targetdiscordid = string.sub(foundID, 9)
		end
	end

	if args[1] then
		xPlayer = ESX.GetPlayerFromId(args[1])
	else
		xPlayer = ESX.GetPlayerFromId(source)
	end

	if not xPlayer then
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player not online.' } })
		return
	end

	for i=#xPlayer.loadout, 1, -1 do
		xPlayer.removeWeapon(xPlayer.loadout[i].name)
		TriggerEvent('srp_logs:adminTargetLog', GetPlayerName(source), "/clearloadout " ..args[1], GetPlayerName(args[1]), discordid, sourceXPlayer.identifier, licenserc, ip, targetdiscordid, targetXPlayer.identifier, targetlicenserc, targetip)
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('command_clearloadout'), params = {{name = "playerId", help = _U('command_playerid_param')}}})
