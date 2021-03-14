ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
--komenda wywolywana jako pierwsza, startuje skrypt dla wsadzającego
--[[
RegisterCommand("putin", function(source,args, raw)
    local src = source
    --print na ekranie wywolujacego komendę, świadczy o tym że się wykonała
    print('Serverside1')
    TriggerClientEvent('Trunk:putin',src)
end)
]]

--event pośredniczący między graczem wsadzającym, a wsadzanym
RegisterServerEvent('Trunk:putin1')
AddEventHandler('Trunk:putin1', function(target)
    -- zapisanie pod zmienne o innych nazwach źródło i cel 
    local src = source
    local targetPlayer = target
    --wyświetla w konsoli serwera kto kogo wsadza
    print ('Serverside src'..src..'target '..targetPlayer)
    -- wywołuje skrypt dla wsadzanego gracza
    TriggerClientEvent('Trunk:putin1', targetPlayer)
end)


