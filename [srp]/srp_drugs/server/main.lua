--[[
Name: srp_drugs
Edit: Ciemina#0001 & DaMcHm#9706 &zrider100z
Base Author: Ezi - Ezi#0001
Version: v0.01.3612
Date: 01/07/2019 - 20:31
]]--

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) 
	ESX = obj 
end)

RegisterServerEvent("srp_drugs:Hasitems")
AddEventHandler("srp_drugs:Hasitems", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        if xPlayer.getMoney() >= 1500 then
            TriggerClientEvent("srp_drugs:Hasitems", source, 1)
        else
            TriggerClientEvent("srp_drugs:Hasitems", source, 0)
        end
    end
end)

RegisterServerEvent("srp_drugs:checkwiniacz")
AddEventHandler("srp_drugs:checkwiniacz", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        local wine = xPlayer.getInventoryItem('wine').count
        if wine >= 1 then
            TriggerClientEvent("srp_drugs:checkwiniacz", source, 1)
        else
            TriggerClientEvent("srp_drugs:checkwiniacz", source, 0)
        end
    end
end)

RegisterServerEvent("srp_drugs:Hasmoneybaron")
AddEventHandler("srp_drugs:Hasmoneybaron", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        if xPlayer.getMoney() >= 450 then
            TriggerClientEvent("srp_drugs:Hasmoneybaron", source, 1)
        else
            TriggerClientEvent("srp_drugs:Hasmoneybaron", source, 0)
        end
    end
end)
RegisterServerEvent("srp_drugs:Hasmoneybaron2")
AddEventHandler("srp_drugs:Hasmoneybaron2", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        if xPlayer.getMoney() >= 2250 then
            TriggerClientEvent("srp_drugs:Hasmoneybaron2", source, 1)
        else
            TriggerClientEvent("srp_drugs:Hasmoneybaron2", source, 0)
        end
    end
end)
RegisterServerEvent("srp_drugs:Hasmoneybaron3")
AddEventHandler("srp_drugs:Hasmoneybaron3", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        if xPlayer.getMoney() >= 4500 then
            TriggerClientEvent("srp_drugs:Hasmoneybaron3", source, 1)
        else
            TriggerClientEvent("srp_drugs:Hasmoneybaron3", source, 0)
        end
    end
end)
RegisterServerEvent("srp_drugs:Hasmoneybaron4")
AddEventHandler("srp_drugs:Hasmoneybaron4", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        if xPlayer.getMoney() >= 6750 then
            TriggerClientEvent("srp_drugs:Hasmoneybaron4", source, 1)
        else
            TriggerClientEvent("srp_drugs:Hasmoneybaron4", source, 0)
        end
    end
end)
RegisterServerEvent("srp_drugs:Hasmoneybaron5")
AddEventHandler("srp_drugs:Hasmoneybaron5", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        if xPlayer.getMoney() >= 9000 then
            TriggerClientEvent("srp_drugs:Hasmoneybaron5", source, 1)
        else
            TriggerClientEvent("srp_drugs:Hasmoneybaron5", source, 0)
        end
    end
end)
RegisterServerEvent("srp_drugs:Hasmoneybaron6")
AddEventHandler("srp_drugs:Hasmoneybaron6", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        if xPlayer.getMoney() >= 22500 then
            TriggerClientEvent("srp_drugs:Hasmoneybaron6", source, 1)
        else
            TriggerClientEvent("srp_drugs:Hasmoneybaron6", source, 0)
        end
    end
end)
RegisterServerEvent("srp_drugs:Hasmoneybaron7")
AddEventHandler("srp_drugs:Hasmoneybaron7", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        if xPlayer.getMoney() >= 45000 then
            TriggerClientEvent("srp_drugs:Hasmoneybaron7", source, 1)
        else
            TriggerClientEvent("srp_drugs:Hasmoneybaron7", source, 0)
        end
    end
end)

RegisterServerEvent("srp_drugs:Hasitems2")
AddEventHandler("srp_drugs:Hasitems2", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        if xPlayer.getMoney() >= 700 then
            TriggerClientEvent("srp_drugs:Hasitems2", source, 1)
        else
            TriggerClientEvent("srp_drugs:Hasitems2", source, 0)
        end
    end
end)

RegisterServerEvent("srp_drugs:HasitemsCash")
AddEventHandler("srp_drugs:HasitemsCash", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        if xPlayer.getMoney() >= 500 then
            TriggerClientEvent("srp_drugs:HasitemsCash", source, 1)
        else
            TriggerClientEvent("srp_drugs:HasitemsCash", source, 0)
        end
    end
end)

RegisterServerEvent("srp_drugs:HasitemsPackage")
AddEventHandler("srp_drugs:HasitemsPackage", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        local packagedcannabis = xPlayer.getInventoryItem('packaged_cannabis').count
        if packagedcannabis >= 1 then
            TriggerClientEvent("srp_drugs:HasitemsPackage", source, 1)
        else
            TriggerClientEvent("srp_drugs:HasitemsPackage", source, 0)
        end
    end
end)

RegisterServerEvent("srp_drugs:HasitemsWeed")
AddEventHandler("srp_drugs:HasitemsWeed", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        local Cannabis = xPlayer.getInventoryItem('weed_pooch').count
        if Cannabis > 0 then
            TriggerClientEvent("srp_drugs:HasitemsWeed", source, 1)
        else
            TriggerClientEvent("srp_drugs:HasitemsWeed", source, 0)
        end
    end
end)

RegisterServerEvent('srp_drugs:giveitem') 
AddEventHandler('srp_drugs:giveitem', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        if xPlayer.getMoney() >= 450 then
            xPlayer.addInventoryItem('packaged_cannabis', 1)
            xPlayer.removeMoney(450)
        else
            TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'error', text = 'Masz za mało pieniędzy aby kupić paczkę.', lenght = 3000 })
        end
    end
end)
RegisterServerEvent('srp_drugs:giveitem2') 
AddEventHandler('srp_drugs:giveitem2', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        if xPlayer.getMoney() >= 2250 then
            xPlayer.addInventoryItem('packaged_cannabis', 5)
            xPlayer.removeMoney(2250)
        else
            TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'error', text = 'Masz za mało pieniędzy aby kupić paczkę.', lenght = 3000 })
        end
    end
end)
RegisterServerEvent('srp_drugs:giveitem3') 
AddEventHandler('srp_drugs:giveitem3', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        if xPlayer.getMoney() >= 4500 then
            xPlayer.addInventoryItem('packaged_cannabis', 10)
            xPlayer.removeMoney(4500)
        else
            TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'error', text = 'Masz za mało pieniędzy aby kupić paczkę.', lenght = 3000 })
        end
    end
end)
RegisterServerEvent('srp_drugs:giveitem4') 
AddEventHandler('srp_drugs:giveitem4', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        if xPlayer.getMoney() >= 6750 then
            xPlayer.addInventoryItem('packaged_cannabis', 15)
            xPlayer.removeMoney(6750)
        else
            TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'error', text = 'Masz za mało pieniędzy aby kupić paczkę.', lenght = 3000 })
        end
    end
end)
RegisterServerEvent('srp_drugs:giveitem5') 
AddEventHandler('srp_drugs:giveitem5', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        if xPlayer.getMoney() >= 9000 then
            xPlayer.addInventoryItem('packaged_cannabis', 20)
            xPlayer.removeMoney(9000)
        else
            TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'error', text = 'Masz za mało pieniędzy aby kupić paczkę.', lenght = 3000 })
        end
    end
end)
RegisterServerEvent('srp_drugs:giveitem6') 
AddEventHandler('srp_drugs:giveitem6', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        if xPlayer.getMoney() >= 22500 then
            xPlayer.addInventoryItem('packaged_cannabis', 50)
            xPlayer.removeMoney(22500)
        else
            TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'error', text = 'Masz za mało pieniędzy aby kupić paczkę.', lenght = 3000 })
        end
    end
end)
RegisterServerEvent('srp_drugs:giveitem7') 
AddEventHandler('srp_drugs:giveitem7', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        if xPlayer.getMoney() >= 45000 then
            xPlayer.addInventoryItem('packaged_cannabis', 100)
            xPlayer.removeMoney(45000)
        else
            TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'error', text = 'Masz za mało pieniędzy aby kupić paczkę.', lenght = 3000 })
        end
    end
end)

RegisterServerEvent('srp_drugs:setjobbaron') 
AddEventHandler('srp_drugs:setjobbaron', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.setJob("baron", 0)
    --TriggerClientEvent('esx:showNotification', source, 'Pamiętaj! Od teraz pracujesz dla Henika!\nZapamiętaj dobrze gdzie go spotkałeś!')	
end)

RegisterServerEvent('srp_drugs:setjobdealer') 
AddEventHandler('srp_drugs:setjobdealer', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.setJob("dealer", 0)
    --TriggerClientEvent('esx:showNotification', source, 'Dostałeś potrzebne informacje. Zapamiętaj je na zawsze!\nOd teraz pracujesz dla Zbyszka!')	
end)

RegisterServerEvent('srp_drugs:removepackaged') 
AddEventHandler('srp_drugs:removepackaged', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem('packaged_cannabis', 1)
    xPlayer.removeMoney(500)
end)

RegisterServerEvent('srp_drugs:processingdrugs') 
AddEventHandler('srp_drugs:processingdrugs', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addInventoryItem('weed_pooch', 28)
end)

RegisterServerEvent('srp_drugs:removeMoney') 
AddEventHandler('srp_drugs:removeMoney', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        if xPlayer.getMoney() >= 1000 then
            xPlayer.removeMoney(1000)
        else
            TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Nie masz wystarczojąco dużo gotówki przy sobie!' })
        end
    end
end)

RegisterServerEvent('srp_drugs:removeMoney2') 
AddEventHandler('srp_drugs:removeMoney2', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeMoney(700)
end)

RegisterServerEvent('srp_drugs:removecashpackagedcannabis') 
AddEventHandler('srp_drugs:removecashpackagedcannabis', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeMoney(450)
end)

RegisterServerEvent('srp_drugs:removecashpackagedcannabis2') 
AddEventHandler('srp_drugs:removecashpackagedcannabis2', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeMoney(2250)
end)
RegisterServerEvent('srp_drugs:removecashpackagedcannabis3') 
AddEventHandler('srp_drugs:removecashpackagedcannabis3', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeMoney(4500)
end)
RegisterServerEvent('srp_drugs:removecashpackagedcannabis4') 
AddEventHandler('srp_drugs:removecashpackagedcannabis4', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeMoney(6750)
end)
RegisterServerEvent('srp_drugs:removecashpackagedcannabis5') 
AddEventHandler('srp_drugs:removecashpackagedcannabis5', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeMoney(9000)
end)
RegisterServerEvent('srp_drugs:removecashpackagedcannabis6') 
AddEventHandler('srp_drugs:removecashpackagedcannabis6', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeMoney(22500)
end)
RegisterServerEvent('srp_drugs:removecashpackagedcannabis7') 
AddEventHandler('srp_drugs:removecashpackagedcannabis7', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeMoney(45000)
end)



RegisterServerEvent('srp_drugs:selldrugs') 
AddEventHandler('srp_drugs:selldrugs', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local Cannabis = xPlayer.getInventoryItem('weed_pooch').count
    local selldrugsweed = math.random(1,6)
    local princedrugsweed = math.random(90,115)
    local weedstotalmoney = selldrugsweed*princedrugsweed
    local szansa_powiadomienia = math.random(0,100)
    if szansa_powiadomienia <= 25 then
        TriggerClientEvent('zrider:sellerTracker',_source)
    end
    if Cannabis >= selldrugsweed then
        xPlayer.removeInventoryItem('weed_pooch', selldrugsweed)
        xPlayer.addMoney(weedstotalmoney)
        TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Sprzedałeś/aś ' .. selldrugsweed .. ' i zarobiłeś/aś ' .. weedstotalmoney .. ' $' })
    elseif Cannabis < selldrugsweed then
        TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Nie masz wystarczająco dużo towaru!' })
    end
end)

RegisterServerEvent('zrider:infodlalspd') 
AddEventHandler('zrider:infodlalspd', function(x,y,z,playerX,playerY,playerZ,street_name)
    TriggerClientEvent('zrider:infodlalspd',-1,x,y,z,playerX,playerY,playerZ,street_name)
end)

RegisterCommand('drugstest', function (source,args,raw)
    if args[1] == nil then
        TriggerClientEvent('zrider:sellerTracker', source)
    else
        TriggerClientEvent('zrider:sellerTracker', args[1])
    end
    
    --TriggerClientEvent('esx:showNotification', source, 'Source '..source)

end,true)
