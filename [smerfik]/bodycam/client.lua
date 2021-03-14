local PlayerData = {}
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent("bodycam:show")
AddEventHandler("bodycam:show", function(daner, job)
    local year , month, day , hour , minute , second  = GetLocalTime()
    if string.len(tostring(minute)) < 2 then
        minute = '0' .. minute
    end
    if string.len(tostring(second)) < 2 then
        second = '0' .. second
    end
    --print(day .. '/'.. month .. '/' .. year .. ' ' .. hour .. ':' .. minute .. ':' .. second)
    SendNUIMessage({
        date = day .. '/'.. month .. '/' .. year .. ' ' .. hour .. ':' .. minute .. ':' .. second,
        daneosoby = daner,
        ranga = job,
        open = true,
    })
end)

RegisterNetEvent("bodycam:close")
AddEventHandler("bodycam:close", function()
    SendNUIMessage({
        open = false
    })
end)
