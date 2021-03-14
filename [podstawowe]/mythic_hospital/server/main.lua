--[[local beds = {
    { x = 325.17, y = -1451.36, z = 37.88, h = 44.65, taken = false },
    { x = 328.16, y = -1447.88, z = 37.88, h = 44.65, taken = false },
    { x = 330.99, y = -1444.47, z = 37.88, h = 44.65, taken = false },
	{ x = 335.54, y = -1443.99, z = 37.88, h = 315.0, taken = false },
    { x = 338.53, y = -1446.55, z = 37.88, h = 315.0, taken = false },
	{ x = 338.73, y = -1449.60, z = 37.88, h = 227.0, taken = false },
	{ x = 335.76, y = -1453.40, z = 37.88, h = 227.0, taken = false },
	{ x = 332.33, y = -1455.72, z = 37.88, h = 227.0, taken = false },
    { x = 329.74, y = -1458.81, z = 37.88, h = 227.0, taken = false },
    { x = 327.22, y = -1461.88, z = 37.88, h = 227.0, taken = false },
	{ x = 323.84, y = -1459.27, z = 37.88, h = 140.0, taken = false },
	{ x = 321.13, y = -1457.06, z = 37.88, h = 140.0, taken = false },
}
]]

local beds = {
    { x = 356.73, y = -585.71, z = 43.11, h = -20.0, taken = false },
    { x = 360.51, y = -586.66, z = 43.11, h = -20.0, taken = false },
    { x = 353.12, y = -584.66, z = 43.50, h = -20.0, taken = false },
	{ x = 349.62, y = -583.53, z = 43.022, h = -20.0, taken = false },
	{ x = 344.80, y = -581.12, z = 43.02, h = 80.0, taken = false },
	{ x = 334.09, y = -578.43, z = 43.01, h = 80.0, taken = false },
	{ x = 323.64, y = -575.16, z = 43.02, h = -20.0, taken = false },
	{ x = 326.97, y = -576.229, z = 43.02, h = -20.0, taken = false },
	{ x = 354.24, y = -592.74, z = 43.11, h = 160.0, taken = false },
	{ x = 357.34, y = -594.45, z = 43.11, h = 160.0, taken = false },
	{ x = 350.80, y = -591.72, z = 43.11, h = 160.0, taken = false },
	{ x = 346.89, y = -591.01, z = 42.58, h = 160.0, taken = false },
}


local bedsTaken = {}
local injuryBasePrice = 80
ESX             = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('playerDropped', function()
    if bedsTaken[source] ~= nil then
        beds[bedsTaken[source]].taken = false
    end
end)

RegisterServerEvent('mythic_hospital:server:RequestBed')
AddEventHandler('mythic_hospital:server:RequestBed', function()
    for k, v in pairs(beds) do
        if not v.taken then
            v.taken = true
            bedsTaken[source] = k
            TriggerClientEvent('mythic_hospital:client:SendToBed', source, k, v)
            return
        end
    end

    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Poczek chwilę ze wzglęgu na brak dostępnych łóżek' })
end)

RegisterServerEvent('mythic_hospital:server:RPRequestBed')
AddEventHandler('mythic_hospital:server:RPRequestBed', function(plyCoords)
    local foundbed = false
    for k, v in pairs(beds) do
        local distance = #(vector3(v.x, v.y, v.z) - plyCoords)
        if distance < 3.0 then
            if not v.taken then
                v.taken = true
                foundbed = true
                TriggerClientEvent('mythic_hospital:client:RPSendToBed', source, k, v)
                return
            else
                --TriggerEvent('mythic_chat:server:System', source, 'That Bed Is Taken')
        --TriggerClientEvent('esx:showNotification', source, '~r~That Bed Is Taken')
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'To łóżko jest zajęte' })
            end
        end
    end

    if not foundbed then
        --TriggerEvent('mythic_chat:server:System', source, 'Not Near A Hospital Bed')
    --TriggerClientEvent('esx:showNotification', source, '~r~Not Near A Hospital Bed')
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'W pobliżu nie ma łózka' })		
    end
end)

RegisterServerEvent('mythic_hospital:server:EnteredBed')
AddEventHandler('mythic_hospital:server:EnteredBed', function()
    local src = source
    local injuries = GetCharsInjuries(src)

    local totalBill = injuryBasePrice

    if injuries ~= nil then
        for k, v in pairs(injuries.limbs) do
            if v.isDamaged then
                totalBill = totalBill + (injuryBasePrice * v.severity)
            end
        end

        if injuries.isBleeding > 0 then
            totalBill = totalBill + (injuryBasePrice * injuries.isBleeding)
        end
    end

	-- YOU NEED TO IMPLEMENT YOUR FRAMEWORKS BILLING HERE
	local xPlayer = ESX.GetPlayerFromId(src)
	xPlayer.removeMoney(totalBill)
        --TriggerClientEvent('esx:showNotification', src, '~w~You Were Billed For ~r~$' .. totalBill .. ' ~w~For Medical Services & Expenses')
    TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 'Zapłaciłeś/aś ' .. totalBill .. ' $ za usługi medyczne' }, 5000)
    TriggerClientEvent('mythic_hospital:client:FinishServices', src)
end)

RegisterServerEvent('mythic_hospital:server:LeaveBed')
AddEventHandler('mythic_hospital:server:LeaveBed', function(id)
    beds[id].taken = false
end)

RegisterServerEvent("mythic_hospital:hascashdoctor")
AddEventHandler("mythic_hospital:hascashdoctor", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local totalBill = injuryBasePrice
    if xPlayer ~= nil then
        if xPlayer.getMoney() >= totalBill then
            TriggerClientEvent("mythic_hospital:hascashdoctor", source, 1)
        else
            TriggerClientEvent("mythic_hospital:hascashdoctor", source, 0)
        end
    end
end)
