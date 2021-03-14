ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--[Zdeklarowane bronie]--
local SNSPistol = GetHashKey("WEAPON_SNSPISTOL")
local Pistol = GetHashKey("WEAPON_PISTOL")
local ApPistol = GetHashKey("WEAPON_APPISTOL")
local VintagePistol = GetHashKey("WEAPON_VINTAGEPISTOL")
local CombatPistol = GetHashKey("WEAPON_COMBATPISTOL")
local HeavyPistol = GetHashKey("WEAPON_HEAVYPISTOL")
local MarksmanPistol = GetHashKey("WEAPON_MARKSMANPISTOL")
local DesertEagle = GetHashKey("WEAPON_PISTOL50")
--[Zdeklarowane Skrzynie z bronia]--

--[Zdeklarowane walizki z bronia]--


--[Nadanie pracy poprzez pedy]--
RegisterServerEvent('srp_blackmarket:SetJobBaronGun') 
AddEventHandler('srp_blackmarket:SetJobBaronGun', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.setJob("barongun", 0)
end)

RegisterServerEvent('srp_blackmarket:SetJobDealerGun') 
AddEventHandler('srp_blackmarket:SetJobDealerGun', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.setJob("dealergun", 0)
end)

--[Usuwanie przedmiotów z EQ]--
RegisterServerEvent('srp_blackmarket:RemoveMoneyBaronGun') 
AddEventHandler('srp_blackmarket:RemoveMoneyBaronGun', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        if xPlayer.getMoney() >= 1000 then
            xPlayer.removeMoney(1000)
        else
            exports['mythic_notify']:DoCustomHudText('error', 'Nie masz wystarczojąco dużo gotówki przy sobie!', 3500)
        end
    end
end)

RegisterServerEvent('srp_blackmarket:RemoveMoneyDealerGun') 
AddEventHandler('srp_blackmarket:RemoveMoneyDealerGun', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        if xPlayer.getMoney() >= 2000 then
            xPlayer.removeMoney(2000)
        else
            exports['mythic_notify']:DoCustomHudText('error', 'Nie masz wystarczojąco dużo gotówki przy sobie!', 3500)
        end
    end
end)


--[Sprawdzanie czy gracz ma dany item przy sobie]--
--Informator o Baron
RegisterServerEvent("srp_blackmarket:HasCashInformator")
AddEventHandler("srp_blackmarket:HasCashInformator", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        if xPlayer.getMoney() >= 1000 then
            TriggerClientEvent("srp_blackmarket:HasCashInformator", source, 1)
        else
            TriggerClientEvent("srp_blackmarket:HasCashInformator", source, 0)
        end
    end
end)
RegisterServerEvent("srp_blackmarket:QuestItemInformator")
AddEventHandler("srp_blackmarket:QuestItemInformator", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        local wodka = xPlayer.getInventoryItem('vodka').count
        if wodka >= 2 then
            TriggerClientEvent("srp_blackmarket:QuestItemInformator", source, 1)
        else
            TriggerClientEvent("srp_blackmarket:QuestItemInformator", source, 0)
        end
    end
end)

--Test Baron
RegisterServerEvent("srp_blackmarket:CashSNSPistol")
AddEventHandler("srp_blackmarket:CashSNSPistol", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        if xPlayer.getMoney() >= 50000 then
            TriggerClientEvent("srp_blackmarket:CashSNSPistol2", source, 1)
        else
            TriggerClientEvent("srp_blackmarket:CashSNSPistol2", source, 0)
        end
    end
end)

RegisterServerEvent("srp_blackmarket:CashPistol")
AddEventHandler("srp_blackmarket:CashPistol", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        if xPlayer.getMoney() >= 40000 then
            TriggerClientEvent("srp_blackmarket:CashPistol", source, 1)
        else
            TriggerClientEvent("srp_blackmarket:CashPistol", source, 0)
        end
    end
end)
RegisterServerEvent("srp_blackmarket:CashCombatPistol")
AddEventHandler("srp_blackmarket:CashCombatPistol", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        if xPlayer.getMoney() >= 40000 then
            TriggerClientEvent("srp_blackmarket:CashCombatPistol", source, 1)
        else
            TriggerClientEvent("srp_blackmarket:CashCombatPistol", source, 0)
        end
    end
end)

-- Zaliczony TEST
RegisterServerEvent("srp_blackmarket:GiveItemSNSTest")
AddEventHandler("srp_blackmarket:GiveItemSNSTest", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem('snscrate', 1)
    xPlayer.addInventoryItem('snscase', 1)
    xPlayer.removeMoney(50000)
end)
RegisterServerEvent("srp_blackmarket:GiveItemPistoltest")
AddEventHandler("srp_blackmarket:GiveItemPistoltest", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem('pistolcrate', 1)
    xPlayer.addInventoryItem('pistolcase', 1)
    xPlayer.removeMoney(40000)
end)
RegisterServerEvent("srp_blackmarket:GiveItemApPistolTest")
AddEventHandler("srp_blackmarket:GiveItemApPistolTest", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem('appistolcrate', 1)
    xPlayer.addInventoryItem('appistolcase', 1)
end)
RegisterServerEvent("srp_blackmarket:GiveItemVintagePistolTest")
AddEventHandler("srp_blackmarket:GiveItemVintagePistolTest", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem('vintagepistolcrate', 1)
    xPlayer.addInventoryItem('vintagepistolcase', 1)
end)
RegisterServerEvent("srp_blackmarket:GiveItemCombatPistoltest")
AddEventHandler("srp_blackmarket:GiveItemCombatPistoltest", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem('combatpistolcrate', 1)
    xPlayer.addInventoryItem('combatpistolcase', 1)
    xPlayer.removeMoney(40000)
end)
RegisterServerEvent("srp_blackmarket:GiveItemHeavyPistolTest")
AddEventHandler("srp_blackmarket:GiveItemHeavyPistolTest", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem('heavypistolcrate', 1)
    xPlayer.addInventoryItem('heavypistolcase', 1)
end)
RegisterServerEvent("srp_blackmarket:GiveItemMarksmanPistolTest")
AddEventHandler("srp_blackmarket:GiveItemMarksmanPistolTest", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem('marksmanpistolcrate', 1)
    xPlayer.addInventoryItem('marksmanpistolcase', 1)
end)
RegisterServerEvent("srp_blackmarket:GiveItemDesertEagleTest")
AddEventHandler("srp_blackmarket:GiveItemDesertEagleTest", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem('desertpistolcrate', 1)
    xPlayer.addInventoryItem('desertpistolcase', 1)
end)



--Informator Dealer
RegisterServerEvent("srp_blackmarket:HasCashInformatorDealer")
AddEventHandler("srp_blackmarket:HasCashInformatorDealer", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        if xPlayer.getMoney() >= 1000 then
            TriggerClientEvent("srp_blackmarket:HasCashInformatorDealer", source, 1)
        else
            TriggerClientEvent("srp_blackmarket:HasCashInformatorDealer", source, 0)
        end
    end
end)

--[Rózna Questy - wykonywanie...]--
RegisterServerEvent("srp_blackmarket:QuestUseVodka")
AddEventHandler("srp_blackmarket:QuestUseVodka", function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('vodka', 1)
	TriggerClientEvent('esx_status:add', source, 'drunk', 250000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)
end)