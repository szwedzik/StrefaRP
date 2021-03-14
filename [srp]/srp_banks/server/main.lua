--[[
Name: srp_banks
Author: Ezi - Ezi#0001 & Smerfik - Smerfik#0069
Version: v0.01.3612
Date: 22/06/2019 - 13:32
]]--

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) 
	ESX = obj 
end)

local time = 0
local timecool = 0
local hajs = 0
local hajs2 = 0
local hajs3 = 0

RegisterServerEvent("esx_bankrobbery:BankAlarm")
AddEventHandler("esx_bankrobbery:BankAlarm", function(bankId)
    local Players = ESX.GetPlayers()      

    for i = 1, #Players do
    	local xPlayer = ESX.GetPlayerFromId(Players[i])

    	if xPlayer["job"]["name"] == "police" or xPlayer["job"]["name"] == "statepolice" or xPlayer["job"]["name"] == "sheriff" then
    		TriggerClientEvent("esx_bankrobbery:alertCops", xPlayer.source, bankId)
    	end
    end
end)

RegisterServerEvent("esx_bankrobbery:startRobbery")
AddEventHandler("esx_bankrobbery:startRobbery", function(bankId)

    TriggerClientEvent("esx_bankrobbery:openDoor", -1, bankId)
    TriggerClientEvent("esx_bankrobbery:startRobbery", -1, bankId)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.execute('UPDATE banks_robbery SET robbed_by = @identifier1 WHERE bank_name = @name' , {
        ['@identifier1'] = xPlayer.identifier,
        ['@name'] = bankId,
    }, function(rowsChanged)
    end)
end)

RegisterServerEvent("srp_banks:alert")
AddEventHandler("srp_banks:alert", function(bankId)
    local bankname = ""
    if bankId == "Fleeca_Bank_Center" then
        bankname = "Vespucci Boulevard"
    end
    if bankId == "Fleeca_Bank_Highway" then
        bankname = "Great Ocean Highhway"
    end
    if bankId == "Fleeca_Bank_Top" then
        bankname = "Hawick Avenue"
    end

    TriggerClientEvent("outlawNotify", -1, "[Centrala]: ^110-90 ^7 - Zgłoszenie alarmu w banku | ^3na ulicy ^7" ..bankname)
end)

RegisterServerEvent("esx_bankrobbery:checkcooldown")
AddEventHandler("esx_bankrobbery:checkcooldown", function(bankId)
    local result = MySQL.Sync.fetchAll("SELECT * FROM banks_robbery WHERE bank_name = @name",
        {
          ['@name']   = bankId
        })
    
        if result[1] ~= nil then
            timecool = result[1].cooldown
        end
        local timecool2 = tonumber(timecool)
        TriggerClientEvent('set:cooldown', -1, timecool)
end)    

AddEventHandler('onResourceStart', function(resource)
    Citizen.Wait(30000)
    TriggerEvent('pobierz:hajs')
end)

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(300000)
        TriggerEvent('pobierz:hajs')
    end
end)

RegisterServerEvent('pobierz:hajs')
AddEventHandler("pobierz:hajs", function()
    pobierzsiano('Fleeca_Bank_Highway')
    pobierzsiano2('Fleeca_Bank_Center')
    pobierzsiano3('Fleeca_Bank_Top')
    Citizen.Wait(2500)
    TriggerClientEvent('setbank:moneyreward', -1, hajs, hajs2, hajs3)
end)

RegisterServerEvent('set:coldown45')
AddEventHandler('set:coldown45', function(nazwabanku)
    MySQL.Async.execute('UPDATE banks_robbery SET cooldown = @time WHERE bank_name = @x' , {
        ['@time'] = '2700000',
        ['@x'] = nazwabanku,
    }, function(rowsChanged)
    end)
end)

RegisterServerEvent("esx_bankrobbery:moneyup")
AddEventHandler("esx_bankrobbery:moneyup", function(nazwabanku)
    local result = MySQL.Sync.fetchAll("SELECT * FROM banks_robbery WHERE bank_name = @name",
    {
      ['@name']   = nazwabanku
    })
    
    if result[1] ~= nil then
        local hajsik1 = tonumber(result[1].money) 
        local hajsik = hajsik1 + 8000
        
        if hajsik > 200000 then
            hajsik = 200000
        end

        local hajsik3 = tostring(hajsik)

        MySQL.Async.execute('UPDATE banks_robbery SET money = @hajs WHERE bank_name = @x' , {
            ['@hajs'] = hajsik3,
            ['@x'] = nazwabanku,
        }, function(rowsChanged)
        end)
    end
end)

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(120 * 60 * 1000)
        TriggerEvent('esx_bankrobbery:moneyup', 'Fleeca_Bank_Highway')
        TriggerEvent('esx_bankrobbery:moneyup', 'Fleeca_Bank_Center')
        TriggerEvent('esx_bankrobbery:moneyup', 'Fleeca_Bank_Top')
    end
end)

RegisterServerEvent("srp_banks:setcash0")
AddEventHandler("srp_banks:setcash0", function(nazwabanku, money)
    MySQL.Async.execute('UPDATE banks_robbery SET money = @money WHERE bank_name = @x' , {
        ['@money'] = money,
        ['@x'] = nazwabanku,
    }, function(rowsChanged)
    end)
end)

function pobierzsiano(nazwabanku)
local result = MySQL.Sync.fetchAll("SELECT * FROM banks_robbery WHERE bank_name = @name",
    {
      ['@name']   = nazwabanku
    })
    if result[1] ~= nil then
		hajs = result[1].money
	end
end

function pobierzsiano2(nazwabanku)
local result = MySQL.Sync.fetchAll("SELECT * FROM banks_robbery WHERE bank_name = @name",
    {
        ['@name']   = nazwabanku
    })
    if result[1] ~= nil then
        hajs2 = result[1].money
    end
end

function pobierzsiano3(nazwabanku)
local result = MySQL.Sync.fetchAll("SELECT * FROM banks_robbery WHERE bank_name = @name",
    {
        ['@name']   = nazwabanku
    })    
    if result[1] ~= nil then        
        hajs3 = result[1].money
    end
end

RegisterServerEvent("esx_bankrobbery:endRobbery")
AddEventHandler("esx_bankrobbery:endRobbery", function(bankId)
    TriggerClientEvent("esx_bankrobbery:endRobbery", -1, bankId)
end)

RegisterServerEvent("esx_bankrobbery:grabbedCash")
AddEventHandler("esx_bankrobbery:grabbedCash", function(bankId, oldCash, newCash)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if oldCash - newCash < 0 then
        newCash = oldCash+1
    end

    xPlayer.addMoney(newCash)
    TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Spakowałeś '..newCash..' do torby' })
    TriggerClientEvent("esx_bankrobbery:changeCash", -1, bankId, oldCash - newCash)
end)

ESX.RegisterServerCallback("esx_bankrobbery:fetchCops", function(source, cb, minCops)
    local copsOnDuty = 0
    local Players = ESX.GetPlayers()

    for i = 1, #Players do
        local xPlayer = ESX.GetPlayerFromId(Players[i])
        if xPlayer["job"]["name"] == "police" or xPlayer["job"]["name"] == "statepolice" or xPlayer["job"]["name"] == "sheriff" then
            copsOnDuty = copsOnDuty + 1
        end
    end

    if copsOnDuty >= minCops then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent("srp_banks:RemoveKeyCard")
AddEventHandler("srp_banks:RemoveKeyCard", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local rng = math.random(0,100)
    if rng < 40 then
        xPlayer.removeInventoryItem('keycard2', 1)
        TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Twoja karta magnetyczna zacieła się w czytniku...' })
    end
end)


RegisterServerEvent("srp_banks:HasKeycard")
AddEventHandler("srp_banks:HasKeycard", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local keycard = xPlayer.getInventoryItem('keycard2').count

    if keycard > 0 then
        TriggerClientEvent("srp_banks:HasKeycard", source, 1)
    else
        TriggerClientEvent("srp_banks:HasKeycard", source, 0)
    end
end)