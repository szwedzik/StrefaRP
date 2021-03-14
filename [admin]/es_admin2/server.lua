ESX = nil
TriggerEvent("es:addGroup", "mod", "user", function(group) end)
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
-- Modify if you want, btw the _admin_ needs to be able to target the group and it will work
local groupsRequired = {
	slay = "admin",
	noclip = "admin",
	crash = "superadmin",
	freeze = "mod",
	bring = "mod",
	["goto"] = "mod",
	slap = "admin",
	slay = "admin",
	kick = "mod",
	ban = "admin"
}
--[[
local banned = ""
local bannedTable = {}

function loadBans()
	banned = LoadResourceFile(GetCurrentResourceName(), "bans.json") or ""
	if banned ~= "" then
		bannedTable = json.decode(banned)
	else
		bannedTable = {}
	end
end

RegisterCommand("refresh_bans", function()
	loadBans()
end, true)

function loadExistingPlayers()
	TriggerEvent("es:getPlayers", function(curPlayers)
		for k,v in pairs(curPlayers)do
			TriggerClientEvent("es_admin:setGroup", v.get('source'), v.get('group'))
		end
	end)
end

loadExistingPlayers()

function removeBan(id)
	bannedTable[id] = nil
	SaveResourceFile(GetCurrentResourceName(), "bans.json", json.encode(bannedTable), -1)
end

function isBanned(id)
	if bannedTable[id] ~= nil then
		if bannedTable[id].expire < os.time() then
			removeBan(id)
			return false
		else
			return bannedTable[id]
		end
	else
		return false
	end
end

function permBanUser(bannedBy, id)
	bannedTable[id] = {
		banner = bannedBy,
		reason = "Permanently banned from this server",
		expire = 0
	}

	SaveResourceFile(GetCurrentResourceName(), "bans.json", json.encode(bannedTable), -1)
end

function banUser(expireSeconds, bannedBy, id, re)
	bannedTable[id] = {
		banner = bannedBy,
		reason = re,
		expire = (os.time() + expireSeconds)
	}

	SaveResourceFile(GetCurrentResourceName(), "bans.json", json.encode(bannedTable), -1)
end

AddEventHandler('playerConnecting', function(user, set)
	for k,v in ipairs(GetPlayerIdentifiers(source))do
		local banData = isBanned(v)
		if banData ~= false then
			set("Banned for: " .. banData.reason .. "\nExpires: " .. (os.date("%c", banData.expire)))
			CancelEvent()
			break
		end
	end
end)
--]]

AddEventHandler('es:incorrectAmountOfArguments', function(source, wantedArguments, passedArguments, user, command)
	if(source == 0)then
		print("Argument count mismatch (passed " .. passedArguments .. ", wanted " .. wantedArguments .. ")")
	else
		TriggerClientEvent('chat:addMessage', source, {
			args = {"^1StrefaRP.pl", "Nieprawidłowa liczba! (" .. passedArguments .. " passed, " .. requiredArguments .. " wanted)"}
		})
	end
end)

RegisterServerEvent('es_admin:all')
AddEventHandler('es_admin:all', function(type)
	local Source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		TriggerEvent('es:canGroupTarget', user.getGroup(), "admin", function(available)
			if available or user.getGroup() == "superadmin" then
				if type == "slay_all" then TriggerClientEvent('es_admin:quick', -1, 'slay') end
				if type == "bring_all" then TriggerClientEvent('es_admin:quick', -1, 'bring', Source) end
				if type == "slap_all" then TriggerClientEvent('es_admin:quick', -1, 'slap') end
			else
				TriggerClientEvent('chat:addMessage', Source, {
					args = {"^1StrefaRP.pl", "Nie masz uprawnień by to wykonać!"}
				})
			end
		end)
	end)
end)

RegisterServerEvent('es_admin:quick')
AddEventHandler('es_admin:quick', function(id, type)
	local Source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		TriggerEvent('es:getPlayerFromId', id, function(target)
			TriggerEvent('es:canGroupTarget', user.getGroup(), groupsRequired[type], function(available)
				TriggerEvent('es:canGroupTarget', user.getGroup(), target.getGroup(), function(canTarget)
					if canTarget and available then
						if type == "slay" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "noclip" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "freeze" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "crash" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "bring" then TriggerClientEvent('es_admin:quick', id, type, Source) end
						if type == "goto" then TriggerClientEvent('es_admin:quick', Source, type, id) end
						if type == "slap" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "slay" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "kick" then DropPlayer(id, 'StrefaRP.pl: Zostałeś/aś wyrzucony/a z serwera\nZapraszamy na nasze forum www.strefarp.pl') end

						if type == "ban" then
							local id
							local ip
							for k,v in ipairs(GetPlayerIdentifiers(source))do
								if string.sub(v, 1, string.len("steam:")) == "steam:" then
									permBanUser(user.identifier, v)
								elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
									permBanUser(user.identifier, v)
								end
							end

							DropPlayer(id, GetConvar("es_admin_banreason", "Zostałeś zbanowany na tym serwerze\nZapraszamy na nasze forum www.strefarp.pl"))
						end
					else
						if not available then
							TriggerClientEvent('chat:addMessage', Source, {
								args = {"^1StrefaRP.pl", "Nie masz uprawnień by to wykonać!"}
							})
						else
							TriggerClientEvent('chat:addMessage', Source, {
								args = {"^1StrefaRP.pl", "Nie masz uprawnień by to wykonać!"}
							})
						end
					end
				end)
			end)
		end)
	end)
end)

AddEventHandler('es:playerLoaded', function(Source, user)
	TriggerClientEvent('es_admin:setGroup', Source, user.getGroup())
end)

RegisterServerEvent('es_admin:set')
AddEventHandler('es_admin:set', function(t, USER, GROUP)
	local Source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		TriggerEvent('es:canGroupTarget', user.getGroup(), "admin", function(available)
			if available then
			if t == "group" then
				if(GetPlayerName(USER) == nil)then
					TriggerClientEvent('chat:addMessage', source, {
						args = {"^1StrefaRP.pl", "Nie znaleziono Gracza"}
					})
				else
					TriggerEvent("es:getAllGroups", function(groups)
						if(groups[GROUP])then
							TriggerEvent("es:setPlayerData", USER, "group", GROUP, function(response, success)
								TriggerClientEvent('es_admin:setGroup', USER, GROUP)
								TriggerClientEvent('chat:addMessage', -1, {
									args = {"^1StrefaRP.pl", "Grupa Gracza ^2^*" .. GetPlayerName(tonumber(USER)) .. "^r^0 została zmieniona na ^2^*" .. GROUP}
								})
							end)
						else
							TriggerClientEvent('chat:addMessage', Source, {
								args = {"^1StrefaRP.pl", "Niepoprawna nazwa Grupy"}
							})
						end
					end)
				end
			elseif t == "level" then
				if(GetPlayerName(USER) == nil)then
					TriggerClientEvent('chat:addMessage', Source, {
						args = {"^1StrefaRP.pl", "Nie znaleziono Gracza"}
					})
				else
					GROUP = tonumber(GROUP)
					if(GROUP ~= nil and GROUP > -1)then
						TriggerEvent("es:setPlayerData", USER, "permission_level", GROUP, function(response, success)
							if(true)then
								TriggerClientEvent('chat:addMessage', -1, {
									args = {"^1StrefaRP.pl", "Poziom Uprawnień Gracza ^2" .. GetPlayerName(tonumber(USER)) .. "^0 został zmieniony na ^2 " .. tostring(GROUP)}
								})
							end
						end)

						TriggerClientEvent('chat:addMessage', Source, {
							args = {"^1StrefaRP.pl", "Poziom Uprawnień Gracza ^2" .. GetPlayerName(tonumber(USER)) .. "^0 został zmieniony na ^2 " .. tostring(GROUP)}
						})
					else
						TriggerClientEvent('chat:addMessage', Source, {
							args = {"^1StrefaRP.pl", "Wprowadzono niepoprawny poziom uprawnień!"}
						})
					end
				end
			elseif t == "money" then
				if(GetPlayerName(USER) == nil)then
					TriggerClientEvent('chat:addMessage', Source, {
						args = {"^1StrefaRP.pl", "Nie znaleziono Gracza"}
					})
				else
					GROUP = tonumber(GROUP)
					if(GROUP ~= nil and GROUP > -1)then
						TriggerEvent('es:getPlayerFromId', USER, function(target)
							target.setMoney(GROUP)
							args = {"^1StrefaRP.pl", "Ilość pieniędzy użytkownika ^2" .. GetPlayerName(tonumber(USER)) .. "^0 został zmieniony na ^2" .. tostring(GROUP)}
						end)
					else
						TriggerClientEvent('chat:addMessage', Source, {
							args = {"^1StrefaRP.pl", "Wprowadzono niepoprawną liczbę!"}
						})
					end
				end
			elseif t == "bank" then
				if(GetPlayerName(USER) == nil)then
					TriggerClientEvent('chat:addMessage', Source, {
						args = {"^1StrefaRP.pl", "Nie znaleziono Gracza"}
					})
				else
					GROUP = tonumber(GROUP)
					if(GROUP ~= nil and GROUP > -1)then
						TriggerEvent('es:getPlayerFromId', USER, function(target)
							target.setBankBalance(GROUP)
							args = {"^1StrefaRP.pl", "Ilość pieniędzy w banku użytkownika ^2" .. GetPlayerName(tonumber(USER)) .. "^0 został zmieniony na ^2" .. tostring(GROUP)}
						end)
					else
						TriggerClientEvent('chat:addMessage', Source, {
							args = {"^1StrefaRP.pl", "Wprowadzono niepoprawną liczbę!"}
						})
					end
				end
			end
			else
				TriggerClientEvent('chat:addMessage', Source, {
					args = {"^1StrefaRP.pl", "Do wykonania tej czynności potrzebne są uprawnienia ^2SuperAdmina"}
				})
			end
		end)
	end)
end)

RegisterCommand('setadmin', function(source, args, raw)
	local player = tonumber(args[1])
	local level = tonumber(args[2])
	if args[1] then
		if (player and GetPlayerName(player)) then
			if level then
				TriggerEvent("es:setPlayerData", tonumber(args[1]), "permission_level", tonumber(args[2]), function(response, success)
					RconPrint(response)
		
					TriggerClientEvent('es:setPlayerDecorator', tonumber(args[1]), 'rank', tonumber(args[2]), true)
					TriggerClientEvent('chat:addMessage', -1, {
						args = {"^1StrefaRP.pl", "Poziom Uprawnień Gracza ^2" .. GetPlayerName(tonumber(args[1])) .. "^0 został ustawiony na ^2 " .. args[2]}
					})
				end)
			else
				RconPrint("Invalid integer\n")
			end
		else
			RconPrint("Player not ingame\n")
		end
	else
		RconPrint("Usage: setadmin [user-id] [permission-level]\n")
	end
end, true)

RegisterCommand('setgroup', function(source, args, raw)
	local player = tonumber(args[1])
	local group = args[2]
	if args[1] then
		if (player and GetPlayerName(player)) then
			TriggerEvent("es:getAllGroups", function(groups)

				if(groups[args[2]])then
					TriggerEvent("es:getPlayerFromId", player, function(user)
						ExecuteCommand('remove_principal identifier.' .. user.getIdentifier() .. " group." .. user.getGroup())

						TriggerEvent("es:setPlayerData", player, "group", args[2], function(response, success)
							TriggerClientEvent('es:setPlayerDecorator', player, 'group', tonumber(group), true)
							TriggerClientEvent('chat:addMessage', -1, {
								args = {"^1StrefaRP.pl", "Grupa gracza ^2^*" .. GetPlayerName(player) .. "^r^0 została ustawiona na ^2^*" .. group}
							})
							ExecuteCommand('add_principal identifier.' .. user.getIdentifier() .. " group." .. user.getGroup())
						end)
					end)
				else
					RconPrint("This group does not exist.\n")
				end
			end)
		else
			RconPrint("Player not ingame\n")
		end
	else
		RconPrint("Usage: setgroup [user-id] [group]\n")
	end
end, true)

RegisterCommand('giverole', function(source, args, raw)
	local player = tonumber(args[1])
	local role = table.concat(args, " ", 2)
	if args[1] then
		if (player and GetPlayerName(player)) then
			if args[2] then
				TriggerEvent("es:getPlayerFromId", player, function(user)
					user.giveRole(role)
					TriggerClientEvent('chat:addMessage', user.get('source'), {
						args = {"^1StrefaRP.pl", "Twoja rola została zmieniona na ^2" .. role}
					})
				end)
			else
				RconPrint("Usage: giverole [user-id] [role]\n")
			end
		else
			RconPrint("Player not ingame\n")
		end
	else
		RconPrint("Usage: giverole [user-id] [role]\n")
	end
end, true)

RegisterCommand('removerole', function(source, args, raw)
	local player = tonumber(args[1])
	local role = table.concat(args, " ", 2)
	if args[1] then
		if (player and GetPlayerName(player)) then
			if args[2] then
				TriggerEvent("es:getPlayerFromId", tonumber(args[1]), function(user)
					user.removeRole(role)
					TriggerClientEvent('chat:addMessage', user.get('source'), {
						args = {"^1StrefaRP.pl", "Usunięto rolę ^2" .. role}
					})
				end)
			else
				RconPrint("Usage: removerole [user-id] [role]\n")
			end
		else
			RconPrint("Player not ingame\n")
		end
	else
		RconPrint("Usage: removerole [user-id] [role]\n")
	end
end, true)
--[[
RegisterCommand('setmoney', function(source, args, raw)
	local player = tonumber(args[1])
	local money = tonumber(args[2])
	local ip = GetPlayerEndpoint(source)
	local targetip = GetPlayerEndpoint(player)
	local targetXPlayer = ESX.GetPlayerFromId(player)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
		if string.match(foundID, "license:") then
			licenserc = string.sub(foundID, 9)
		elseif string.match(foundID, "discord:") then
			discordid = string.sub(foundID, 9)
		end
	end
	local identifier = GetPlayerIdentifiers(player)[1]
	for _, foundID in ipairs(GetPlayerIdentifiers(player)) do
		if string.match(foundID, "license:") then
			targetlicenserc = string.sub(foundID, 9)
		elseif string.match(foundID, "discord:") then
			targetdiscordid = string.sub(foundID, 9)
		end
	end
	if args[1] then
		if (player and GetPlayerName(player)) then
			if money then
				TriggerEvent("es:getPlayerFromId", player, function(user)
					if(user)then
						user.setMoney(money)
						TriggerClientEvent('chat:addMessage', player, {
							args = {"^1SYSTEM", "Your money has been set to: ^2^*$" .. money}
						})
						TriggerEvent('srp_logs:adminTargetLog', GetPlayerName(source), "/setmoney " ..player .. " " ..money, GetPlayerName(player), discordid, sourceXPlayer.identifier, licenserc, ip, targetdiscordid, targetXPlayer.identifier, targetlicenserc, targetip)
					end
				end)
			else
				RconPrint("Invalid integer\n")
			end
		else
			RconPrint("Player not ingame\n")
		end
	else
		RconPrint("Usage: setmoney [user-id] [money]\n")
	end
end, true)
--]]
-- Default commands
TriggerEvent('es:addCommand', 'admin', function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, {
		args = {"^1StrefaRP.pl", "Grupa ^*^2 " .. user.getGroup()}
	})
	TriggerClientEvent('chat:addMessage', source, {
		args = {"^1StrefaRP.pl", "Poziom uprawnień ^*^2 " .. tostring(user.get('permission_level'))}
	})
end, {help = "Komenda pokazuje jaki jest Twój poziom uprawnień oraz posiadaną grupę."})

-- Ban a person
TriggerEvent("es:addGroupCommand", 'ban', "mod", function(source, args, user)
	local Source = source
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)
				TriggerEvent('es:canGroupTarget', user.getGroup(), target.getGroup(), function(canTarget)
					if canTarget then
						local ip = GetPlayerEndpoint(source)
						local targetip = GetPlayerEndpoint(player)
						local targetXPlayer = ESX.GetPlayerFromId(player)
						local sourceXPlayer = ESX.GetPlayerFromId(source)
						local identifier = GetPlayerIdentifiers(source)[1]
						for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
							if string.match(foundID, "license:") then
								licenserc = string.sub(foundID, 9)
							elseif string.match(foundID, "discord:") then
								discordid = string.sub(foundID, 9)
							end
						end
						local identifier = GetPlayerIdentifiers(player)[1]
						for _, foundID in ipairs(GetPlayerIdentifiers(player)) do
							if string.match(foundID, "license:") then
								targetlicenserc = string.sub(foundID, 9)
							elseif string.match(foundID, "discord:") then
								targetdiscordid = string.sub(foundID, 9)
							end
						end
						local steamhex = target.getIdentifier()
						local bannedby = GetPlayerName(source)
						local result = MySQL.Sync.fetchAll("SELECT * FROM srp_whitelist WHERE steamhex = @steamhex",
						{
						  ['@steamhex']   = steamhex
						})
						local reason = args
						table.remove(reason, 1)
						if(#reason == 0)then
							reason = "System: Zostałeś zbanowany. Jeżeli uważasz to za błąd odwołaj się na naszym forum. https://forum.strefarp.pl"
						else
							reason = "" .. table.concat(reason, " ")
						end

						--TriggerClientEvent('chat:addMessage', -1, {
						--	args = {"^1StrefaRP.pl", "Użytkownik ^3" .. GetPlayerName(player) .. "^0 został pernamentnie zbanowany \nprzez ^3 System ^0Powód: ^1" .. reason}
						--})
						if result[1] ~= nil then
							MySQL.Async.execute('UPDATE srp_whitelist SET banreason = @reason, bannedby = @bannedby, bantime = -1  WHERE steamhex = @steamhex' , {
								['@reason'] = reason,
								['@steamhex'] = steamhex,
								['@bannedby'] = bannedby,
							}, function(rowsChanged)
							end)
						end
						TriggerEvent("srp_logs:adminBanLog", GetPlayerName(player), GetPlayerName(source), reason, discordid, sourceXPlayer.identifier, licenserc, ip, targetdiscordid, targetXPlayer.identifier, targetlicenserc, targetip)
						TriggerEvent('srp_logs:adminTargetLog', GetPlayerName(source), "/ban " ..player.. " " ..reason, GetPlayerName(player), discordid, sourceXPlayer.identifier, licenserc, ip, targetdiscordid, targetXPlayer.identifier, targetlicenserc, targetip)
						DropPlayer(player, "Zostałeś zbanowany. \nPowód: "..reason.."\nTyp bana: Pernamentny \nOsoba banująca: "..GetPlayerName(source).."\nJeżeli uważasz to za błąd odwołaj się na forum: https://forum.strefarp.pl")
					else
						TriggerClientEvent('chat:addMessage', source, { args = {"^1StrefaRP.pl", "Akcja niemożliwa"}})
					end
				end)
			end)
		else
			TriggerClientEvent('chat:addMessage', source, { args = {"^1StrefaRP.pl", "Błędne ID użytkownika"}})
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = {"^1StrefaRP.pl", "Błędne ID użytkownika"}})
	end
end, {help = "Komenda służy do wyrzucenia użytkownika z wyspy, pamiętaj aby wpisać powód!", params = {{name = "userid", help = "ID użytkownika"}, {name = "reason", help = "Podaj powód wyrzucenia użytkownika z wyspy."}}})

TriggerEvent("es:addGroupCommand", 'tempban', "mod", function(source, args, user)
	local Source = source
	if args[1] then
	if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
		local player = tonumber(args[1])
		-- User permission check
		TriggerEvent("es:getPlayerFromId", player, function(target)
		TriggerEvent('es:canGroupTarget', user.getGroup(), target.getGroup(), function(canTarget)
			if canTarget then
				local ip = GetPlayerEndpoint(source)
				local targetip = GetPlayerEndpoint(player)
				local targetXPlayer = ESX.GetPlayerFromId(player)
				local sourceXPlayer = ESX.GetPlayerFromId(source)
				local identifier = GetPlayerIdentifiers(source)[1]
				for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
					if string.match(foundID, "license:") then
						licenserc = string.sub(foundID, 9)
					elseif string.match(foundID, "discord:") then
						discordid = string.sub(foundID, 9)
					end
				end
				local identifier = GetPlayerIdentifiers(player)[1]
				for _, foundID in ipairs(GetPlayerIdentifiers(player)) do
					if string.match(foundID, "license:") then
						targetlicenserc = string.sub(foundID, 9)
					elseif string.match(foundID, "discord:") then
						targetdiscordid = string.sub(foundID, 9)
					end
				end
				local steamhex = target.getIdentifier()
				local bannedby = GetPlayerName(source)
				local result = MySQL.Sync.fetchAll("SELECT * FROM srp_whitelist WHERE steamhex = @steamhex",
				{
					['@steamhex']   = steamhex
				})
				local reason = args
				table.remove(reason, 1)
				local time = args[1]
				table.remove(reason, 1)
				if(#reason == 0)then
					reason = "System: Zostałeś zbanowany. Jeżeli uważasz to za błąd odwołaj się na naszym forum. https://forum.strefarp.pl"
				else
					reason = "" .. table.concat(reason, " ")
				end
					--TriggerClientEvent('chat:addMessage', -1, {
					--	args = {"^1StrefaRP.pl", "Użytkownik ^3" .. GetPlayerName(player) .. "^0 został tymczasowo zbanowany \nprzez ^3 System ^0Powód: ^1" .. reason}
					--})
				if result[1] ~= nil then
					MySQL.Async.execute('UPDATE srp_whitelist SET banreason = @reason, bannedby = @bannedby, bantime = @time  WHERE steamhex = @steamhex' , {
						['@reason'] = reason,
						['@steamhex'] = steamhex,
						['@bannedby'] = bannedby,
						['@time'] = time
						}, function(rowsChanged)
					end)
				end
				TriggerEvent("srp_logs:adminTempBanLog", GetPlayerName(player), GetPlayerName(source), reason, time, discordid, sourceXPlayer.identifier, licenserc, ip, targetdiscordid, targetXPlayer.identifier, targetlicenserc, targetip)
				TriggerEvent('srp_logs:adminTargetLog', GetPlayerName(source), "/tempban " ..player.. " "..time.. " " ..reason, GetPlayerName(player), discordid, sourceXPlayer.identifier, licenserc, ip, targetdiscordid, targetXPlayer.identifier, targetlicenserc, targetip)
				DropPlayer(player, "Zostałeś zbanowany. \nPowód: "..reason.."\nTyp bana: Tymczasowy \nPozostało: "..time.." godzin bana. \nOsoba banująca: "..GetPlayerName(source).."\nJeżeli uważasz to za błąd odwołaj się na forum: https://forum.strefarp.pl")		
					else
						TriggerClientEvent('chat:addMessage', source, { args = {"^1StrefaRP.pl", "Akcja niemożliwa"}})
					end
				end)
			end)
		else
			TriggerClientEvent('chat:addMessage', source, { args = {"^1StrefaRP.pl", "Błędne ID użytkownika"}})
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = {"^1StrefaRP.pl", "Błędne ID użytkownika"}})
	end
end, {help = "Komenda służy do banowania.", params = {{name = "player", help = "ID użytkownika"}, {name = "time", help = "Podaj czas w godzinach"}, {name = "reason", help = "Podaj powód bana."}}})

-- Report to admins
TriggerEvent('es:addCommand', 'report', function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, {
		args = {"^1StrefaRP - REPORT", "Użytkownik ^2" .. GetPlayerName(source) .. " ^0| ^2 " .. source .. " ^0napisał: " .. table.concat(args, " ")}
	})

	TriggerEvent("es:getPlayers", function(pl)
		for k,v in pairs(pl) do
			TriggerEvent("es:getPlayerFromId", k, function(user)
				if(user.getPermissions() > 0 and k ~= source)then
					TriggerClientEvent('chat:addMessage', k, {
						args = {"^REPORT", "Użytkownik ^2" .. GetPlayerName(source) .." ^0| ^2 "..source.." ^0napisał: " .. table.concat(args, " ")}
					})
				end
			end)
		end
	end)
end, {help = "Komenda służy do zgłaszania użytkowników lub swoich problemów bezpośrednio do Administracji na wyspie", params = {{name = "Powód", help = "Dokładnie opisz co chcesz zgłosić!"}}})

-- Noclip
TriggerEvent('es:addGroupCommand', 'noclip', "mod", function(source, args, user)
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
	TriggerClientEvent("es_admin:noclip", source)
	TriggerEvent('srp_logs:adminLog', GetPlayerName(source), "/noclip ", discordid, sourceXPlayer.identifier, licenserc, ip)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1StrefaRP.pl", "^0Niewystarczające uprawnienia aby użyć tej komendy!"} })
end, {help = "Komenda służy do włączenia lub wyłączenia NoClip'u"})

-- Kicking
TriggerEvent('es:addGroupCommand', 'kick', "mod", function(source, args, user)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)
				local ip = GetPlayerEndpoint(source)
				local targetip = GetPlayerEndpoint(player)
				local targetXPlayer = ESX.GetPlayerFromId(player)
				local sourceXPlayer = ESX.GetPlayerFromId(source)
				local identifier = GetPlayerIdentifiers(source)[1]
				for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
					if string.match(foundID, "license:") then
						licenserc = string.sub(foundID, 9)
					elseif string.match(foundID, "discord:") then
						discordid = string.sub(foundID, 9)
					end
				end
				local identifier = GetPlayerIdentifiers(player)[1]
				for _, foundID in ipairs(GetPlayerIdentifiers(player)) do
					if string.match(foundID, "license:") then
						targetlicenserc = string.sub(foundID, 9)
					elseif string.match(foundID, "discord:") then
						targetdiscordid = string.sub(foundID, 9)
					end
				end

				local reason = args
				table.remove(reason, 1)
				if(#reason == 0)then
					reason = "StrefaRP.pl: Wyrzucono Cię z serwera"
				else
					reason = "StrefaRP.pl: Wyrzucono Cię z serwera. Powód: " .. table.concat(reason, " ")
				end
				local reasonlog = string.sub(reason, 47)
				--TriggerClientEvent('chat:addMessage', -1, {
				--	args = {"^1StrefaRP.pl", "Użytkownik ^3" .. GetPlayerName(player) .. "^0 został wyrzucony z serwera Powód: ^1" ..reasonlog}
				--})
				TriggerEvent("srp_logs:adminKickLog", GetPlayerName(player), GetPlayerName(source), reasonlog, discordid, sourceXPlayer.identifier, licenserc, ip, targetdiscordid, targetXPlayer.identifier, targetlicenserc, targetip)
				TriggerEvent('srp_logs:adminTargetLog', GetPlayerName(source), "/kick " ..args[1], GetPlayerName(player), discordid, sourceXPlayer.identifier, licenserc, ip, targetdiscordid, targetXPlayer.identifier, targetlicenserc, targetip)
				DropPlayer(player, reason)
			end)
		else
			TriggerClientEvent('chat:addMessage', source, { args = {"^1StrefaRP.pl", "Błędne ID użytkownika"}})
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = {"^1StrefaRP.pl", "Błędne ID użytkownika"}})
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1StrefaRP.pl", "^0Niewystarczające uprawnienia aby użyć tej komendy!"} })
end, {help = "Komenda służy do wyrzucenia użytkownika z wyspy, pamiętaj aby wpisać powód!", params = {{name = "id", help = "ID użytkownika"}, {name = "reason", help = "Podaj powód wyrzucenia użytkownika z wyspy."}}})

-- Announcing
TriggerEvent('es:addGroupCommand', 'announce', "mod", function(source, args, user)
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
	TriggerClientEvent('chat:addMessage', -1, {
		args = {"^1StrefaRP.pl", table.concat(args, " ")}
	})
	TriggerEvent('srp_logs:adminLog', GetPlayerName(source), "/announce " ..args[1], discordid, sourceXPlayer.identifier, licenserc, ip)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1StrefaRP.pl", "^0Niewystarczające uprawnienia aby użyć tej komendy!"} })
end, {help = "Komenda służy do wysyłania ogłoszenia OOC przez Administrację do wszystkich użytkowników", params = {{name = "announcement", help = "Treść ogłoszenia"}}})

-- Freezing
local frozen = {}
TriggerEvent('es:addGroupCommand', 'freeze', "mod", function(source, args, user)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				if(frozen[player])then
					frozen[player] = false
				else
					frozen[player] = true
				end

				TriggerClientEvent('es_admin:freezePlayer', player, frozen[player])

				local state = "odmrożony/a"
				if(frozen[player])then
					state = "zamrożony/a"
				end

				TriggerClientEvent('chat:addMessage', player, { args = {"^1StrefaRP.pl", "Zostałeś/aś ^2" .. state .. " ^0przez ^2" .. GetPlayerName(source)} })
				TriggerClientEvent('chat:addMessage', source, { args = {"^1StrefaRP.pl", "Użytkownyk ^2" .. GetPlayerName(player) .. " ^0został " .. state} })
				local ip = GetPlayerEndpoint(source)
				local targetip = GetPlayerEndpoint(player)
				local targetXPlayer = ESX.GetPlayerFromId(player)
				local sourceXPlayer = ESX.GetPlayerFromId(source)
				local identifier = GetPlayerIdentifiers(source)[1]
				for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
					if string.match(foundID, "license:") then
						licenserc = string.sub(foundID, 9)
					elseif string.match(foundID, "discord:") then
						discordid = string.sub(foundID, 9)
					end
				end
				local identifier = GetPlayerIdentifiers(player)[1]
				for _, foundID in ipairs(GetPlayerIdentifiers(player)) do
					if string.match(foundID, "license:") then
						targetlicenserc = string.sub(foundID, 9)
					elseif string.match(foundID, "discord:") then
						targetdiscordid = string.sub(foundID, 9)
					end
				end
				TriggerEvent('srp_logs:adminTargetLog', GetPlayerName(source), "/freeze " ..args[1], GetPlayerName(player), discordid, sourceXPlayer.identifier, licenserc, ip, targetdiscordid, targetXPlayer.identifier, targetlicenserc, targetip)
			end)
		else
			TriggerClientEvent('chat:addMessage', source, { args = {"^1StrefaRP.pl", "Błędne ID użytkownika"}})
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = {"^1StrefaRP.pl", "Błędne ID użytkownika"}})
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^0Niewystarczające uprawnienia aby użyć tej komendy!"} })
end, {help = "Komenda służy do zamrażania lub odmrażania użytkownika", params = {{name = "userid", help = "ID użytkownika"}}})

-- Bring
TriggerEvent('es:addGroupCommand', 'bring', "mod", function(source, args, user)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])
			local ip = GetPlayerEndpoint(source)
			local targetip = GetPlayerEndpoint(player)
			local targetXPlayer = ESX.GetPlayerFromId(player)
			local sourceXPlayer = ESX.GetPlayerFromId(source)
			local identifier = GetPlayerIdentifiers(source)[1]
			for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
				if string.match(foundID, "license:") then
					licenserc = string.sub(foundID, 9)
				elseif string.match(foundID, "discord:") then
					discordid = string.sub(foundID, 9)
				end
			end
			local identifier = GetPlayerIdentifiers(player)[1]
			for _, foundID in ipairs(GetPlayerIdentifiers(player)) do
				if string.match(foundID, "license:") then
					targetlicenserc = string.sub(foundID, 9)
				elseif string.match(foundID, "discord:") then
					targetdiscordid = string.sub(foundID, 9)
				end
			end

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				TriggerClientEvent('es_admin:teleportUser', target.get('source'), user.getCoords().x, user.getCoords().y, user.getCoords().z)

				TriggerClientEvent('chat:addMessage', player, { args = {"^1StrefaRP.pl", "Zostałeś teleportowany przez ^2" .. GetPlayerName(source)} })
				TriggerClientEvent('chat:addMessage', source, { args = {"^1StrefaRP.pl", "Teleportowałeś ^2" .. GetPlayerName(player) .. "^0 do siebie"} })
				local ip = GetPlayerEndpoint(source)
				local targetip = GetPlayerEndpoint(player)
				local targetXPlayer = ESX.GetPlayerFromId(player)
				local sourceXPlayer = ESX.GetPlayerFromId(source)
				local identifier = GetPlayerIdentifiers(source)[1]
				for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
					if string.match(foundID, "license:") then
						licenserc = string.sub(foundID, 9)
					elseif string.match(foundID, "discord:") then
						discordid = string.sub(foundID, 9)
					end
				end
				local identifier = GetPlayerIdentifiers(player)[1]
				for _, foundID in ipairs(GetPlayerIdentifiers(player)) do
					if string.match(foundID, "license:") then
						targetlicenserc = string.sub(foundID, 9)
					elseif string.match(foundID, "discord:") then
						targetdiscordid = string.sub(foundID, 9)
					end
				end
				TriggerEvent('srp_logs:adminTargetLog', GetPlayerName(source), "/bring " ..args[1], GetPlayerName(player), discordid, sourceXPlayer.identifier, licenserc, ip, targetdiscordid, targetXPlayer.identifier, targetlicenserc, targetip)
			end)
		else
			TriggerClientEvent('chat:addMessage', source, { args = {"^1StrefaRP.pl", "Błędne ID użytkownika"}})
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = {"^1StrefaRP.pl", "Błędne ID użytkownika"}})
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1StrefaRP.pl", "^0Niewystarczające uprawnienia aby użyć tej komendy!"} })
end, {help = "Komenda służy do teleportacji użytkownika do siebie", params = {{name = "userid", help = "ID użytkownika"}}})

-- Slap
TriggerEvent('es:addGroupCommand', 'slap', "admin", function(source, args, user)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				TriggerClientEvent('es_admin:slap', player)

				TriggerClientEvent('chat:addMessage', player, { args = {"^1StrefaRP.pl", "Zostałes uderzony przez ^2" .. GetPlayerName(source)} })
				TriggerClientEvent('chat:addMessage', source, { args = {"^1StrefaRP.pl", "Użytkownik ^2" .. GetPlayerName(player) .. "^0 został uderzony"} })
				local ip = GetPlayerEndpoint(source)
				local targetip = GetPlayerEndpoint(player)
				local targetXPlayer = ESX.GetPlayerFromId(player)
				local sourceXPlayer = ESX.GetPlayerFromId(source)
				local identifier = GetPlayerIdentifiers(source)[1]
				for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
					if string.match(foundID, "license:") then
						licenserc = string.sub(foundID, 9)
					elseif string.match(foundID, "discord:") then
						discordid = string.sub(foundID, 9)
					end
				end
				local identifier = GetPlayerIdentifiers(player)[1]
				for _, foundID in ipairs(GetPlayerIdentifiers(player)) do
					if string.match(foundID, "license:") then
						targetlicenserc = string.sub(foundID, 9)
					elseif string.match(foundID, "discord:") then
						targetdiscordid = string.sub(foundID, 9)
					end
				end
				TriggerEvent('srp_logs:adminTargetLog', GetPlayerName(source), "/slap " ..args[1], GetPlayerName(player), discordid, sourceXPlayer.identifier, licenserc, ip, targetdiscordid, targetXPlayer.identifier, targetlicenserc, targetip)
			end)
		else
			TriggerClientEvent('chat:addMessage', source, { args = {"^1StrefaRP.pl", "Błędne ID użytkownika"}})
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = {"^1StrefaRP.pl", "Błędne ID użytkownika"}})
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1StrefaRP.pl", "^0Niewystarczające uprawnienia aby użyć tej komendy!"} })
end, {help = "Komenda służy do uderzenia użytkownika", params = {{name = "userid", help = "ID użytkownika"}}})

-- Goto
TriggerEvent('es:addGroupCommand', 'goto', "mod", function(source, args, user)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)
				if(target)then

					TriggerClientEvent('es_admin:teleportUser', source, target.getCoords().x, target.getCoords().y, target.getCoords().z)

					TriggerClientEvent('chat:addMessage', player, { args = {"^1StrefaRP.pl", "Administrator ^2" .. GetPlayerName(source) .. " ^0teleportował się do Ciebie"} })
					TriggerClientEvent('chat:addMessage', source, { args = {"^1StrefaRP.pl", "Teleportowałeś się do ^2" .. GetPlayerName(player) .. ""} })
					local ip = GetPlayerEndpoint(source)
					local targetip = GetPlayerEndpoint(player)
					local targetXPlayer = ESX.GetPlayerFromId(player)
					local sourceXPlayer = ESX.GetPlayerFromId(source)
					local identifier = GetPlayerIdentifiers(source)[1]
					for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
						if string.match(foundID, "license:") then
							licenserc = string.sub(foundID, 9)
						elseif string.match(foundID, "discord:") then
							discordid = string.sub(foundID, 9)
						end
					end
					local identifier = GetPlayerIdentifiers(player)[1]
					for _, foundID in ipairs(GetPlayerIdentifiers(player)) do
						if string.match(foundID, "license:") then
							targetlicenserc = string.sub(foundID, 9)
						elseif string.match(foundID, "discord:") then
							targetdiscordid = string.sub(foundID, 9)
						end
					end
					TriggerEvent('srp_logs:adminTargetLog', GetPlayerName(source), "/goto " ..args[1], GetPlayerName(player), discordid, sourceXPlayer.identifier, licenserc, ip, targetdiscordid, targetXPlayer.identifier, targetlicenserc, targetip)
				end
			end)
		else
			TriggerClientEvent('chat:addMessage', source, { args = {"^1StrefaRP.pl", "Błędne ID użytkownika"}})
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = {"^1StrefaRP.pl", "Błędne ID użytkownika"}})
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1StrefaRP.pl", "^0Niewystarczające uprawnienia aby użyć tej komendy!"} })
end, {help = "Komenda służy do teleportacji do użytkownika", params = {{name = "userid", help = "ID użytkownika"}}})

-- Kill yourself
--[[
TriggerEvent('es:addCommand', 'die', function(source, args, user)
	TriggerClientEvent('es_admin:kill', source)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "You killed yourself"} })
end, {help = "Suicide"})
--]]

-- Slay a player
TriggerEvent('es:addGroupCommand', 'slay', "admin", function(source, args, user)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				TriggerClientEvent('es_admin:kill', player)

				TriggerClientEvent('chat:addMessage', player, { args = {"^1StrefaRP.pl", "Zostałeś zabity przez administratora ^2" .. GetPlayerName(source)} })
				TriggerClientEvent('chat:addMessage', source, { args = {"^1StrefaRP.pl", "Użytkownik ^2" .. GetPlayerName(player) .. "^0 został zabity."} })
				local ip = GetPlayerEndpoint(source)
				local targetip = GetPlayerEndpoint(player)
				local targetXPlayer = ESX.GetPlayerFromId(player)
				local sourceXPlayer = ESX.GetPlayerFromId(source)
				local identifier = GetPlayerIdentifiers(source)[1]
				for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
					if string.match(foundID, "license:") then
						licenserc = string.sub(foundID, 9)
					elseif string.match(foundID, "discord:") then
						discordid = string.sub(foundID, 9)
					end
				end
				local identifier = GetPlayerIdentifiers(player)[1]
				for _, foundID in ipairs(GetPlayerIdentifiers(player)) do
					if string.match(foundID, "license:") then
						targetlicenserc = string.sub(foundID, 9)
					elseif string.match(foundID, "discord:") then
						targetdiscordid = string.sub(foundID, 9)
					end
				end
				TriggerEvent('srp_logs:adminTargetLog', GetPlayerName(source), "/slay " ..args[1], GetPlayerName(player), discordid, sourceXPlayer.identifier, licenserc, ip, targetdiscordid, targetXPlayer.identifier, targetlicenserc, targetip)
			end)
		else
			TriggerClientEvent('chat:addMessage', source, { args = {"^1StrefaRP.pl", "Błędne ID użytkownika"}})
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = {"^1StrefaRP.pl", "Błędne ID użytkownika"}})
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1StrefaRP.pl", "^0Niewystarczające uprawnienia aby użyć tej komendy!"} })
end, {help = "Komenda uśmierca użytkownika", params = {{name = "userid", help = "ID użytkownika"}}})

-- Crashing
TriggerEvent('es:addGroupCommand', 'crash', "superadmin", function(source, args, user)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				TriggerClientEvent('es_admin:crash', player)
				TriggerClientEvent('chat:addMessage', source, { args = {"^1StrefaRP.pl", "Crash został wywołany na ^2" .. GetPlayerName(player) .. ""} })
				local ip = GetPlayerEndpoint(source)
				local targetip = GetPlayerEndpoint(player)
				local targetXPlayer = ESX.GetPlayerFromId(player)
				local sourceXPlayer = ESX.GetPlayerFromId(source)
				local identifier = GetPlayerIdentifiers(source)[1]
				for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
					if string.match(foundID, "license:") then
						licenserc = string.sub(foundID, 9)
					elseif string.match(foundID, "discord:") then
						discordid = string.sub(foundID, 9)
					end
				end
				local identifier = GetPlayerIdentifiers(player)[1]
				for _, foundID in ipairs(GetPlayerIdentifiers(player)) do
					if string.match(foundID, "license:") then
						targetlicenserc = string.sub(foundID, 9)
					elseif string.match(foundID, "discord:") then
						targetdiscordid = string.sub(foundID, 9)
					end
				end
				TriggerEvent('srp_logs:adminCrashLog', GetPlayerName(source), "/crash " ..args[1], GetPlayerName(player), discordid, sourceXPlayer.identifier, licenserc, ip, targetdiscordid, targetXPlayer.identifier, targetlicenserc, targetip)
			end)
		else
			TriggerClientEvent('chat:addMessage', source, { args = {"^1StrefaRP.pl", "Błędne ID użytkownika"}})
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = {"^1StrefaRP.pl", "Błędne ID użytkownika"}})
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1StrefaRP.pl", "^0Niewystarczające uprawnienia aby użyć tej komendy!"} })
end, {help = "Wywołuje Crash na użytkowniku", params = {{name = "userid", help = "ID użytkownika"}}})

function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

--loadBans()
RegisterServerEvent("srp_anticheat:AutoBan")
AddEventHandler("srp_anticheat:AutoBan", function(id)
	local ip = GetPlayerEndpoint(id)
	local targetXPlayer = ESX.GetPlayerFromId(id)
	local identifier = GetPlayerIdentifiers(id)[1]
	for _, foundID in ipairs(GetPlayerIdentifiers(id)) do
		if string.match(foundID, "license:") then
			licenserc = string.sub(foundID, 9)
		elseif string.match(foundID, "discord:") then
			discordid = string.sub(foundID, 9)
		end
	end
	local result = MySQL.Sync.fetchAll("SELECT * FROM srp_whitelist WHERE steamhex = @steamhex",
	{
		['@steamhex'] = identifier
	})

	if result[1] ~= nil then
		MySQL.Async.execute('UPDATE srp_whitelist SET banreason = @reason, bannedby = @bannedby, bantime = -1  WHERE steamhex = @steamhex' , {
			['@reason'] = "Cheating",
			['@steamhex'] = identifier,
			['@bannedby'] = "AntiCheat",
			}, function(rowsChanged)
		end)
	end
	TriggerEvent("srp_logs:adminAutoBanLog", GetPlayerName(id), discordid, targetXPlayer.identifier, licenserc, ip)
	DropPlayer(id, "Zostałeś zbanowany. \nPowód: Cheating\nTyp bana: Pernamentny \nOsoba banująca: AntiCheat\nJeżeli uważasz to za błąd odwołaj się na forum: https://forum.strefarp.pl")
end)