--[[
Name: srp_whitelist
Author: Ezi - Ezi#0001
Version: v0.01.3612
Date: 21/06/2019 - 12:16
]]--
function whiteListCheck(steamhex)
    local identifier = "null"
    local result = MySQL.Sync.fetchAll('SELECT steamhex FROM srp_whitelist WHERE LOWER(steamhex) = @steamhex', 
    {
        ['@steamhex'] = steamhex
    })
    Wait(250)
    if result[1] ~= nil then
        local identity = result[1]
        return {identifier = identity['steamhex']}
    else
        return {identifier = 'null'}
    end
end

AddEventHandler("playerConnecting", function(Nickname, setKickReason, deferrals)
    deferrals.defer()
    local _source = source
    local joined = false
    local sid = GetPlayerIdentifiers( _source)[1]
	for _, foundID in ipairs(GetPlayerIdentifiers( _source)) do
		if string.match(foundID, "ip:") then
			ip = string.sub(foundID, 4)
		end
	end
    deferrals.update(Config.Messages.wlcheck)
    --Wait(30000)
    --local cd = math.random(15000, 60000)
    Wait(1000)
    for myId, identifier in pairs(GetPlayerIdentifiers(_source)) do
        local hex = whiteListCheck(string.lower(identifier))
        if(string.lower(hex.identifier) == string.lower(identifier)) then
            for _, foundID in ipairs(GetPlayerIdentifiers(_source)) do
                if string.match(foundID, "ip:") then
                    ip = string.sub(foundID, 4)
                end
            end
            local shouldwait = true
            MySQL.Async.execute('UPDATE srp_whitelist SET nickname = @nickname WHERE steamhex = @identifier',
            {
                ['@nickname'] = Nickname,
                ['@identifier'] = hex.identifier
            })
            MySQL.Async.execute('UPDATE srp_whitelist SET last_join = NOW() where steamhex = @identifier',
            {
                ['@identifier'] = hex.identifier
            })
            MySQL.Async.execute('UPDATE srp_whitelist SET ip = @ip where steamhex = @identifier',
            {
                ['@identifier'] = hex.identifier,
                ['@ip'] = ip
            })

            if shouldwait then
                deferrals.update(Config.Messages.wlcheck)
            end

            deferrals.done()
            joined = true
            break
        end
        deferrals.update(Config.Messages.wlcheck)
        Wait(1)
    end
    if joined then
        return
    end
    deferrals.done(Config.Messages.notwhitelisted)
end)

Citizen.CreateThread(function()
    if Config.DisableHardCap then
        print("^1[SRP] Hardcap has been disabled. ^7")
        AddEventHandler("onResourceStarting", function(resource)
            if resource == "hardcap" then CancelEvent() return end
        end)
        StopResource("hardcap")
    end
end)
