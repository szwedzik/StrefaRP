ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
RegisterServerEvent('smerfik:lombardtest') 
AddEventHandler('smerfik:lombardtest', function()
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local liczba = xPlayer.getInventoryItem('jewels').count
    if liczba == 0 or liczba == nil then
        TriggerClientEvent('usunpeda:lobard', _source)
        TriggerClientEvent('srp_notify:businessesInfo', source, { type = 'error', text = 'Nie posiadasz bużuterii!' })
        
    else
        local liczba2 = math.random(1, liczba)
        local cena = 20
        xPlayer.removeInventoryItem('jewels', liczba2)
        xPlayer.addMoney(liczba2 * cena)
        TriggerClientEvent('srp_notify:businessesInfo', source, { type = 'inform', text = 'Sprzedales ' .. liczba2 .. ' biżuterii za: ' .. liczba2 * cena })
        TriggerClientEvent('notif:lombard', _source)
        local liczba3 = xPlayer.getInventoryItem('jewels').count
        if liczba3 > 0 then
            TriggerClientEvent('lombard:again', _source)
        end
    end
end)
