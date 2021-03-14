local playerCount = 0
local list = {}

RegisterServerEvent('hardcap:playerActivated')

AddEventHandler('hardcap:playerActivated', function()
  if not list[source] then
    playerCount = playerCount + 1
    list[source] = true
  end
end)

AddEventHandler('playerDropped', function()
  if list[source] then
    playerCount = playerCount - 1
    list[source] = nil
  end
end)

AddEventHandler('playerConnecting', function(name, setReason)
  local cv = GetConvarInt('sv_maxclients', 64)

  print('Łączenie: ' .. name .. '^7')

  if playerCount >= cv then
    print('Serwer jest pełen.')

    setReason('Serwer jest pełen (' .. tostring(cv) .. ' graczy).')
    CancelEvent()
  end
end)
