local players = {}
local waiting = {}
local connecting = {}
local prePoints = Config.Points
local EmojiList = Config.EmojiList

AddEventHandler("playerConnecting", function(name, reject, def)
	local _source = source
	local steamID = GetSteamID(_source)
	if not steamID then
		reject(Config.NoSteam)
		CancelEvent()
		return 
	end
	if not Rocade(steamID, def, _source) then
		CancelEvent()
	end
end)

function Rocade(steamID, def, source)
	local identifier = GetPlayerIdentifiers(source)[1]
	for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
		if string.match(foundID, "ip:") then
			ip = string.sub(foundID, 4)
		elseif string.match(foundID, "license:") then
			licenserc = string.sub(foundID, 9)
		elseif string.match(foundID, "discord:") then
			discordid = string.sub(foundID, 9)
		end
	end
	MySQL.Async.fetchAll('SELECT * FROM srp_whitelist WHERE ip = @ip OR steamhex = @identifier LIMIT 1',{
		['@identifier'] = identifier,
		['@ip'] = ip
	}, function(result)
		if result[1] ~= nil then
			if result[1].bantime ~= nil then
				if result[1].bantime ~= '' then
					if result[1].bantime == 0 then
						TriggerEvent("srp_logs:autoUnbanLog",GetPlayerName(source), discordid, steamID, licenserc, ip)
						MySQL.Async.execute("UPDATE srp_whitelist SET banreason = null, bantime = null, bannedby = null WHERE steamhex ='" .. identifier .. "' LIMIT 1",{})
					else
						if result[1].bantime == -1 then
							def.done('Zostałeś zbanowany. \nPowód: ' .. result[1].banreason .. '. \nTyp bana: Permanentny \nOsoba banująca: '..result[1].bannedby..'\nJeżeli uważasz to za błąd odwołaj się na forum: https://forum.strefarp.pl')
						else
							def.done('Zostałeś zbanowany. \nPowód: ' .. result[1].banreason .. '. \nTyp bana: Tymczasowy \nPozostało: ' .. result[1].bantime .. ' godzin bana. \nOsoba banująca: '..result[1].bannedby.. '\nJeżeli uważasz to za błąd odwołaj się na forum: https://forum.strefarp.pl')
						end
					end
				end
			end
		end
	end)
	def.defer()
	AntiSpam(def, steamID)
	Purge(steamID)
	AddPlayer(steamID, source)
	table.insert(waiting, steamID)
	local stop = false
	repeat
		for i,p in ipairs(connecting) do
			if p == steamID then 
				stop = true 
				break
			end
		end
    for j,sid in ipairs(waiting) do
		for i,p in ipairs(players) do
			if sid == p[1] and p[1] == steamID and (GetPlayerPing(p[3]) == 0) then
				Purge(steamID)
				def.done(Config.Accident)
				return false
			end
		end
    end
		def.update(GetMessage(steamID))
		Citizen.Wait(Config.TimerRefreshClient * 1000)
	until stop
	def.done()
	return true
end

Citizen.CreateThread(function()
	local maxServerSlots = GetConvarInt('sv_maxclients', 128)
	while true do
		Wait(Config.TimerCheckPlaces * 1000)
		CheckConnecting()
		if #waiting > 0 and #connecting + #GetPlayers() < maxServerSlots then
			ConnectFirst()
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		UpdatePoints()
		Wait(Config.TimerUpdatePoints * 1000)
	end
end)

RegisterServerEvent("rocademption:playerKicked")
AddEventHandler("rocademption:playerKicked", function(src, points)
	local sid = GetSteamID(src)
	Purge(sid)
	for i,p in ipairs(prePoints) do
		if p[1] == sid then
			p[2] = p[2] - points
			return
		end
	end
	local initialPoints = GetInitialPoints(sid)
	table.insert(prePoints, {sid, initialPoints - points})
end)

RegisterServerEvent("rocademption:playerConnected")
AddEventHandler("rocademption:playerConnected", function()
	local sid = GetSteamID(source)
	Purge(sid)
end)

AddEventHandler("playerDropped", function(reason)
	local steamID = GetSteamID(source)
	Purge(steamID)
end)

function CheckConnecting()
	for i,sid in ipairs(connecting) do
		for j,p in ipairs(players) do
			if p[1] == sid and (GetPlayerPing(p[3]) == 500) then
				table.remove(connecting, i)
				break
			end
		end
	end
end

function ConnectFirst()
	if #waiting == 0 then return end
	local maxPoint = 0
	local maxSid = waiting[1][1]
	local maxWaitId = 1
	for i,sid in ipairs(waiting) do
		local points = GetPoints(sid)
		if points > maxPoint then
			maxPoint = points
			maxSid = sid
			maxWaitId = i
		end
	end
	table.remove(waiting, maxWaitId)
	table.insert(connecting, maxSid)
end

function GetPoints(steamID)
	for i,p in ipairs(players) do
		if p[1] == steamID then
			return p[2]
		end
	end
end

function UpdatePoints()
	for i,p in ipairs(players) do
		local found = false
		for j,sid in ipairs(waiting) do
			if p[1] == sid then
				p[2] = p[2] + Config.AddPoints
				found = true
				break
			end
		end
		if not found then
			for j,sid in ipairs(connecting) do
				if p[1] == sid then
					found = true
					break
				end
			end
			if not found then
				p[2] = p[2] - Config.RemovePoints
				if p[2] < GetInitialPoints(p[1]) - Config.RemovePoints then
					Purge(p[1])
					table.remove(players, i)
				end
			end
		end
	end
end

function AddPlayer(steamID, source)
	for i,p in ipairs(players) do
		if steamID == p[1] then
			players[i] = {p[1], p[2], source}
			return
		end
	end
	local initialPoints = GetInitialPoints(steamID)
	table.insert(players, {steamID, initialPoints, source})
end

function GetInitialPoints(steamID)
	local points = Config.RemovePoints + 1
	for n,p in ipairs(prePoints) do
		if p[1] == steamID then
			points = p[2]
		end
	end
	return points
end

function GetPlace(steamID)
	points = GetPoints(steamID)
	place = 1
	for i,sid in ipairs(waiting) do
		for j,p in ipairs(players) do
			if p[1] == sid and p[2] > points then
				place = place + 1
			end
		end
	end
	return place
end


function GetMessage(steamID) 
	local msg = ""
	if GetPoints(steamID) ~= nil then
		msg = msg .. Config.Position .. GetPlace(steamID) .. "/".. #waiting .. " w kolejce " .. ".\n"
		msg = msg .. "[ " .. Config.EmojiMsg
		local e1 = RandomEmojiList()
		local e2 = RandomEmojiList()
		local e3 = RandomEmojiList()
		local emojis = e1 .. e2 .. e3
		msg = msg .. emojis .. " ]"
	else
		msg = Config.Error
	end
	return msg
end

function Purge(steamID)
	for n,sid in ipairs(connecting) do
		if sid == steamID then
			table.remove(connecting, n)
		end
	end
	for n,sid in ipairs(waiting) do
		if sid == steamID then
			table.remove(waiting, n)
		end
	end
end

function AntiSpam(def)
	for i=Config.AntiSpamTimer,0,-1 do
		def.update(Config.PleaseWait_1 .. i .. Config.PleaseWait_2)
		Citizen.Wait(1000)
	end
end

function RandomEmojiList()
	randomEmoji = EmojiList[math.random(#EmojiList)]
	return randomEmoji
end

function GetSteamID(src)
	local sid = GetPlayerIdentifiers(src)[1] or false
	if (sid == false or sid:sub(1,5) ~= "steam") then
		return false
	end 
	return sid
end