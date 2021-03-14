ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('cmg2_animations:sync')
AddEventHandler('cmg2_animations:sync', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget)
	TriggerClientEvent('cmg2_animations:syncTarget', source, targetSrc, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget)
	TriggerClientEvent('cmg2_animations:syncMe', targetSrc, animationLib, animation,length,controlFlagSrc,animFlagTarget)
end)

RegisterServerEvent('cmg2_animations:stop')
AddEventHandler('cmg2_animations:stop', function(targetSrc)
	TriggerClientEvent('cmg2_animations:cl_stop', targetSrc)
end)

RegisterServerEvent('carry:info')
AddEventHandler('carry:info', function(source,player)
	TriggerClientEvent('mythic_notify:client:SendJobAlert', player, { type = 'inform', text = 'Ktoś prubuje cię podnieść...' })
	TriggerClientEvent('mythic_notify:client:SendJobAlert', player, { type = 'inform', text = 'Kliknij E aby zaakceptować lub Q aby odrzucić' })
	TriggerClientEvent('carry:request',player)
end)


RegisterServerEvent('carry:timeup')
AddEventHandler('carry:timeup', function(source)
	--TriggerClientEvent('showNotify', -1,"Czas upłynął", source)
	TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Czas upłynął' })
end)


-- MICHU 2/2