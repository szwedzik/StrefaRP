RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')

AddEventHandler('_chat:messageEntered', function(author, color, message)
    local ip = GetPlayerEndpoint(source)
    local identifier = GetPlayerIdentifiers(source)[1]
	for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
	  if string.match(foundID, "license:") then
		  licenserc = string.sub(foundID, 9)
    elseif string.match(foundID, "discord:") then
      discordid = string.sub(foundID, 9)
    elseif string.match(foundID, "steam:") then
      hex = string.sub(foundID, 1)
	  end
  end
    if not message or not author then
        return
    end
    TriggerEvent('chatMessage', source, author, message)
    if not WasEventCanceled() then
        TriggerClientEvent('chatMessage', -1, author,  { 255, 255, 255 }, message)
    end
    print(author .. ': ' .. message)
    --TriggerEvent("srp_logs:chatLog", author, message, hex, discordid, licenserc, ip)
end)

AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = GetPlayerName(source)
    TriggerEvent('chatMessage', source, name, '/' .. command)
    if not WasEventCanceled() then
       TriggerClientEvent('chatMessage', -1, name, { 255, 255, 255 }, '/' .. command) 
    end
    CancelEvent()
end)

AddEventHandler('chat:init', function()
	-- player join messages
end)

AddEventHandler('playerDropped', function(reason)
	-- player dropped messages
end)

-- RegisterCommand('say', function(source, args, rawCommand)
    -- TriggerClientEvent('chatMessage', -1, (source == 0) and 'BÓG' or GetPlayerName(source), { 255, 255, 0 }, rawCommand:sub(5))
-- end)

local function refreshCommands(player)
    if GetRegisteredCommands then
        local registeredCommands = GetRegisteredCommands()
        local suggestions = {}
        for _, command in ipairs(registeredCommands) do
            if IsPlayerAceAllowed(player, ('command.%s'):format(command.name)) then
                table.insert(suggestions, {
                    name = '/' .. command.name,
                    help = ''
                })
            end
        end
        TriggerClientEvent('chat:addSuggestions', player, suggestions)
    end
end

AddEventHandler('chat:init', function()
    refreshCommands(source)
end)

AddEventHandler('onServerResourceStart', function(resName)
    Wait(500)
    for _, player in ipairs(GetPlayers()) do
        refreshCommands(player)
    end
end)