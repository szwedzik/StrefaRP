--[[
Name: srp_gunshop
Author: Ezi - Ezi#0001
Version: v0.01.3612
Date: 20/06/2019 - 19:36
]]--

ESX = nil

local weapon1 = GetHashKey("WEAPON_PISTOL") 
local weapon2 = GetHashKey("WEAPON_COMBATPISTOL")
local weapon3 = GetHashKey("WEAPON_HEAVYPISTOL")
local weapon4 = GetHashKey("WEAPON_VINTAGEPISTOL") 
local weapon5 = GetHashKey("WEAPON_PISTOL50") 
local weapon6 = GetHashKey("WEAPON_SNSPISTOL")

TriggerEvent('esx:getSharedObject', function(obj) 
	ESX = obj 
end)

RegisterServerEvent("srp_gunshop:Hasitems")
AddEventHandler("srp_gunshop:Hasitems", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    --local keycard = xPlayer.getInventoryItem('keycard2').count
    if xPlayer ~= nil then
        if xPlayer.getMoney() >= 750 then
            TriggerClientEvent("srp_gunshop:Hasitems", source, 1)
        else
            TriggerClientEvent("srp_gunshop:Hasitems", source, 0)
        end
    end
end)

RegisterServerEvent('srp_gunshop:removeMoney') 
AddEventHandler('srp_gunshop:removeMoney', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeMoney(750)
end)

RegisterServerEvent('srp_gunshop:buyWeapon')
AddEventHandler('srp_gunshop:removeMoney', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

end)

RegisterServerEvent('srp_gunshop:weaponRoll')
AddEventHandler('srp_gunshop:weaponRoll', function()
    rollWeapon()
    Citizen.Wait(1000)
    rollWeapon()
    Citizen.Wait(1000)
    rollWeapon()
end)

function rollWeapon()
    local weaponroll = math.random(1,6)
    local weaponamount = math.random(1,2)
    if weaponroll == 1 then
        print("DEBUG: Wylosowalem "..weapon1)
        if weaponamount == 1 then
            print("DEBUG: Wylosowalem "..weapon1..' 1 szt')
        elseif weaponamount == 2 then
            print("DEBUG: Wylosowalem "..weapon1..' 2 szt')
        end
    elseif weaponroll == 2 then
        print("DEBUG: Wylosowalem "..weapon2)
        if weaponamount == 1 then
            print("DEBUG: Wylosowalem "..weapon2..' 1 szt')
        elseif weaponamount == 2 then
            print("DEBUG: Wylosowalem "..weapon2..' 2 szt')
        end
    elseif weaponroll == 3 then
        print("DEBUG: Wylosowalem "..weapon3)
        if weaponamount == 1 then
            print("DEBUG: Wylosowalem "..weapon3..' 1 szt')
        elseif weaponamount == 2 then
            print("DEBUG: Wylosowalem "..weapon3..' 2 szt')
        end
    elseif weaponroll == 4 then
        print("DEBUG: Wylosowalem "..weapon4)
        if weaponamount == 1 then
            print("DEBUG: Wylosowalem "..weapon4..' 1 szt')
        elseif weaponamount == 2 then
            print("DEBUG: Wylosowalem "..weapon4..' 2 szt')
        end
    elseif weaponroll == 5 then
        print("DEBUG: Wylosowalem "..weapon5)
        if weaponamount == 1 then
            print("DEBUG: Wylosowalem "..weapon5..' 1 szt')
        elseif weaponamount == 2 then
            print("DEBUG: Wylosowalem "..weapon5..' 2 szt')
        end
    elseif weaponroll == 6 then
        print("DEBUG: Wylosowalem "..weapon6)
        if weaponamount == 1 then
            print("DEBUG: Wylosowalem "..weapon6..' 1 szt')
        elseif weaponamount == 2 then
            print("DEBUG: Wylosowalem "..weapon6..' 2 szt')
        end
    end
end

RegisterServerEvent('srp_gunshop:sellsnspistol') 
AddEventHandler('srp_gunshop:sellsnspistol', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getMoney() >= 2900 then
        xPlayer.removeMoney(2900)
        xPlayer.addWeapon('WEAPON_SNSPISTOL', 100)
    else
        exports['mythic_notify']:DoCustomHudText('error', 'Chcesz to kupić nie dając mi kasy? Spadaj', 3500)
    end
end)

RegisterServerEvent('srp_gunshop:sellpistol') 
AddEventHandler('srp_gunshop:sellpistol', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getMoney() >= 3200 then
    xPlayer.removeMoney(3200)
    xPlayer.addWeapon('WEAPON_PISTOL', 100)
        else
        exports['mythic_notify']:DoCustomHudText('error', 'Chcesz to kupić nie dając mi kasy? Spadaj', 3500)
    end
end)

RegisterServerEvent('srp_gunshop:sellcombatpistol') 
AddEventHandler('srp_gunshop:sellcombatpistol', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getMoney() >= 4200 then
    xPlayer.removeMoney(4200)
    xPlayer.addWeapon('WEAPON_COMBATPISTOL', 100)
else
    exports['mythic_notify']:DoCustomHudText('error', 'Chcesz to kupić nie dając mi kasy? Spadaj', 3500)
end
end)

RegisterServerEvent('srp_gunshop:sellheavypistol') 
AddEventHandler('srp_gunshop:sellheavypistol', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getMoney() >= 5500 then
    xPlayer.removeMoney(5500)
    xPlayer.addWeapon('WEAPON_HEAVYPISTOL', 100)
else
    exports['mythic_notify']:DoCustomHudText('error', 'Chcesz to kupić nie dając mi kasy? Spadaj', 3500)
end
end)

RegisterServerEvent('srp_gunshop:sellpistol50') 
AddEventHandler('srp_gunshop:sellpistol50', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getMoney() >= 10200 then
    xPlayer.removeMoney(10200)
    xPlayer.addWeapon('WEAPON_PISTOL50', 100)
else
    exports['mythic_notify']:DoCustomHudText('error', 'Chcesz to kupić nie dając mi kasy? Spadaj', 3500)
end
end)

RegisterServerEvent('srp_gunshop:sellknife') 
AddEventHandler('srp_gunshop:sellknife', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getMoney() >= 750 then
    xPlayer.removeMoney(750)
    xPlayer.addWeapon('WEAPON_KNIFE', 1)
else
    exports['mythic_notify']:DoCustomHudText('error', 'Chcesz to kupić nie dając mi kasy? Spadaj', 3500)
end
end)

RegisterServerEvent('srp_gunshop:sellhammer') 
AddEventHandler('srp_gunshop:sellhammer', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getMoney() >= 500 then
    xPlayer.removeMoney(500)
    xPlayer.addWeapon('WEAPON_HAMMER', 1)
else
    exports['mythic_notify']:DoCustomHudText('error', 'Chcesz to kupić nie dając mi kasy? Spadaj', 3500)
end
end)

RegisterServerEvent('srp_gunshop:sellknuckle') 
AddEventHandler('srp_gunshop:sellknuckle', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getMoney() >= 450 then
    xPlayer.removeMoney(450)
    xPlayer.addWeapon('WEAPON_KNUCKLE', 1)
else
    exports['mythic_notify']:DoCustomHudText('error', 'Chcesz to kupić nie dając mi kasy? Spadaj', 3500)
end
end)

RegisterServerEvent('srp_gunshop:sellhatchet') 
AddEventHandler('srp_gunshop:sellhatchet', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getMoney() >= 850 then
    xPlayer.removeMoney(850)
    xPlayer.addWeapon('WEAPON_HATCHET', 1)
else
    exports['mythic_notify']:DoCustomHudText('error', 'Chcesz to kupić nie dając mi kasy? Spadaj', 3500)
end
end)

RegisterServerEvent('srp_gunshop:sellbat') 
AddEventHandler('srp_gunshop:sellbat', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getMoney() >= 350 then
    xPlayer.removeMoney(350)
    xPlayer.addWeapon('WEAPON_BAT', 1)
else
    exports['mythic_notify']:DoCustomHudText('error', 'Chcesz to kupić nie dając mi kasy? Spadaj', 3500)
end
end)

RegisterServerEvent('srp_gunshop:sellmachete') 
AddEventHandler('srp_gunshop:sellmachete', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getMoney() >= 900 then
    xPlayer.removeMoney(900)
    xPlayer.addWeapon('WEAPON_MACHETE', 1)
else
    exports['mythic_notify']:DoCustomHudText('error', 'Chcesz to kupić nie dając mi kasy? Spadaj', 3500)
end
end)

RegisterServerEvent('srp_gunshop:sellball') 
AddEventHandler('srp_gunshop:sellball', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getMoney() >= 150 then
    xPlayer.removeMoney(150)
    xPlayer.addWeapon('WEAPON_BALL', 25)
else
    exports['mythic_notify']:DoCustomHudText('error', 'Chcesz to kupić nie dając mi kasy? Spadaj', 3500)
end
end)

RegisterServerEvent('srp_gunshop:sellflare') 
AddEventHandler('srp_gunshop:sellflare', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getMoney() >= 400 then
    xPlayer.removeMoney(400)
    xPlayer.addWeapon('WEAPON_FLARE', 25)
else
    exports['mythic_notify']:DoCustomHudText('error', 'Chcesz to kupić nie dając mi kasy? Spadaj', 3500)
end
end)