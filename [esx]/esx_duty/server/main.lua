ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('duty:onoff')
AddEventHandler('duty:onoff', function(job)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade
    if job == 'police' or job == "sheriff" or job == "statepolice" or job == 'ambulance' or job == 'taxi' --[[or job == "zwierzako"]] then
        xPlayer.setJob('off' ..job, grade)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Kończysz służbę' })
        --TriggerClientEvent('esx:showNotification', _source, _U('offduty'))
		return
	end
    if job == 'offpolice' then
        xPlayer.setJob('police', grade)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Rozpoczynasz służbę' })
        --TriggerClientEvent('esx:showNotification', _source, _U('onduty'))
    end
    if job == 'offsheriff' then
        xPlayer.setJob('sheriff', grade)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Rozpoczynasz służbę' })
    end
    if job == 'offstatepolice' then
        xPlayer.setJob('statepolice', grade)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Rozpoczynasz służbę' })
	end
    if job == 'offambulance' then
        xPlayer.setJob('ambulance', grade)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Rozpoczynasz służbę' })
    end
    if job == 'offtaxi' then
        xPlayer.setJob('taxi', grade)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Rozpoczynasz służbę' })
	end
    --[[if job == 'offzwierzako' then
        xPlayer.setJob('zwierzako', grade)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Rozpoczynasz służbę' })
	end]]
end)

RegisterServerEvent("duty:alert")
AddEventHandler("duty:alert", function(drogi)
	TriggerClientEvent("outlawNotify", -1, "[^2Centrala^7]: ^110-43 ^7 - ^1Utracono połączenie z funkcjonariuszem^7 | ^3na ulicy ^7" ..drogi)
end)

RegisterServerEvent("duty:alert1")
AddEventHandler("duty:alert1", function(x, y, z) 
    TriggerClientEvent('duty:infodlalspd', -1, x, y, z)
end)