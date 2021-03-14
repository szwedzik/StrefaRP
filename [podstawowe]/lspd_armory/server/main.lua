local ESX = nil

local CachedPedState = false
local TestAnimCache = false

TriggerEvent("esx:getSharedObject", function(response)
    ESX = response
end)

ESX.RegisterServerCallback("qalle_policearmory:pedExists", function(source, cb)
    if CachedPedState then
        cb(true)
    else
        CachedPedState = true

        cb(false)
    end
end)


ESX.RegisterServerCallback("zrider:testExist", function(source, cb)
    if TestAnimCache then
        cb(true)
    else
        TestAnimCache = true

        cb(false)
    end
end)

RegisterServerEvent("qalle_policearmory:giveWeapon")
AddEventHandler("qalle_policearmory:giveWeapon", function(weapon)
    local player = ESX.GetPlayerFromId(source)

    if player then
        player.addWeapon(weapon, Config.ReceiveAmmo)
        --TriggerClientEvent("esx:showNotification", source, "You just received 1x " .. ESX.GetWeaponLabel(weapon) .. " with " .. Config.ReceiveAmmo .. "x ammo.")
    end
end)

--[[
RegisterCommand("test_anim", function(source, args, rawCommand)

    TriggerClientEvent('zrider:anim_test',source,'WEAPON_CARBINERIFLE')
    -- normal function handling here
end, true)
]]
