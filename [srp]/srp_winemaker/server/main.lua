--[[
raisin			Winogrona
jus_raisin		Sok z Winogron
grand_cru		Stare Wino (lepszy zarobek)
clean_raisin	Umyte Winogrono
vine			Wino
]]

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

------------config
local maxraisin = 100			--ile można mieć w EQ Winogron
local MaxClean = 100			--ile można mieć w EQ umytych Winogron
local MaxJusRaisin = 20			--ile można mieć w EQ Soku Winogronowego
--local MaxOldVine = 30			--ile można mieć w EQ Starego Wina
local MaxVine = 10				--ile można mieć w EQ Wina




---------Zbieranie
RegisterServerEvent('srp_winemaker:harvest')
AddEventHandler('srp_winemaker:harvest', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local raisin = xPlayer.getInventoryItem('raisin').count

		if raisin < maxraisin then
			TriggerClientEvent("srp_winemaker:harvestfunction", source)
			Wait(500)
		elseif raisin >= 75 and raisin <= 99 then
			TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'error', text = 'Nie możesz mieć przy sobie więcej winogron!' })
			Wait(500)
			TriggerClientEvent("srp_winemaker:harvesttimerstop", source)
		elseif raisin >= 100 then
			TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'error', text = 'Przy sobie możesz mieć maksymalnie ' ..maxraisin.. ' Winogron.' })
			Wait(500)
			TriggerClientEvent("srp_winemaker:harvesttimerstop", source)
		end
end)

RegisterServerEvent('srp_winemaker:harvestpay')
AddEventHandler('srp_winemaker:harvestpay', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local raisin = xPlayer.getInventoryItem('raisin').count

	xPlayer.addInventoryItem('raisin', 25)
	TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'success', text = 'Zebrano 25 Winogron' })
	Wait(500)
end)




----------Mycie
RegisterServerEvent('srp_winemaker:wash')
AddEventHandler('srp_winemaker:wash', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local raisin = xPlayer.getInventoryItem('raisin').count
	local CleanRaisin = xPlayer.getInventoryItem('clean_raisin').count

		if raisin > 0 and CleanRaisin < MaxClean then
			TriggerClientEvent("srp_winemaker:washfunction", source)
			Wait(500)
		elseif raisin < 0 then
			TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'error', text = 'Masz za mało winogron do mycia!' })
			Wait(500)
			TriggerClientEvent("srp_winemaker:washtimerstop", source)
		elseif raisin >= 75 and raisin <= 99 then
			TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'error', text = 'Nie możesz mieć przy sobie więcej winogron!' })
			Wait(500)
			TriggerClientEvent("srp_winemaker:washtimerstop", source)
		elseif CleanRaisin >= 75 and CleanRaisin <= 99 then
			TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'error', text = 'Nie możesz mieć przy sobie więcej umytych winogron!' })
			Wait(500)
			TriggerClientEvent("srp_winemaker:washtimerstop", source)
		elseif CleanRaisin >= 100 then
			TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'error', text = 'Przy sobie możesz mieć maksymalnie ' ..MaxClean.. ' umytych Winogron!' })
			Wait(500)
			TriggerClientEvent("srp_winemaker:washtimerstop", source)
		end
end)

RegisterServerEvent('srp_winemaker:washpay')
AddEventHandler('srp_winemaker:washpay', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local raisin = xPlayer.getInventoryItem('raisin').count
	local CleanRaisin = xPlayer.getInventoryItem('clean_raisin').count

	xPlayer.removeInventoryItem('raisin', raisin)
	xPlayer.addInventoryItem('clean_raisin', raisin)
	TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'success', text = 'Umyto ' .. raisin .. ' Winogron' })
	Wait(500)
end)





----------- Jus
RegisterServerEvent('srp_winemaker:processingintojus')
AddEventHandler('srp_winemaker:processingintojus', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local CleanRaisin = xPlayer.getInventoryItem('clean_raisin').count
	local JusRaisin = xPlayer.getInventoryItem('jus_raisin').count

		if CleanRaisin >= 20 and JusRaisin < MaxJusRaisin then
			TriggerClientEvent("srp_winemaker:processingintojusfunction", source)
			Wait(500)
		elseif CleanRaisin < 20 then
			TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'error', text = 'Masz za mało czystych winogron!' })
			Wait(500)
			TriggerClientEvent("srp_winemaker:processingintojustimerstop", source)
		elseif JusRaisin >= 20 then
			TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'error', text = 'Przy sobie możesz mieć maksymalnie ' ..MaxJusRaisin.. ' butelek soku Winogronowego!' })
			Wait(500)
			TriggerClientEvent("srp_winemaker:processingintojustimerstop", source)
		end
end)

RegisterServerEvent('srp_winemaker:processingintojuspay')
AddEventHandler('srp_winemaker:processingintojuspay', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local CleanRaisin = xPlayer.getInventoryItem('clean_raisin').count
	local JusRaisin = xPlayer.getInventoryItem('jus_raisin').co

	xPlayer.removeInventoryItem('clean_raisin', 20)
	xPlayer.addInventoryItem('jus_raisin', 4)
	TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'success', text = 'Przetworzono 20 Winogron' })
	TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'success', text = 'Otrzymano 4 butelki Soku Winogronowego' })
	Wait(500)
end)




----------WIne
RegisterServerEvent('srp_winemaker:processingintowine')
AddEventHandler('srp_winemaker:processingintowine', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local CleanRaisin = xPlayer.getInventoryItem('clean_raisin').count
	local Vine = xPlayer.getInventoryItem('vine').count

		if CleanRaisin >= 20 and Vine < MaxVine then
			TriggerClientEvent("srp_winemaker:processingintowinefunction", source)
			Wait(500)
		elseif CleanRaisin < 20 then
			TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'success', text = 'Masz za mało czystych winogron!' })
			Wait(500)
			TriggerClientEvent("srp_winemaker:processingintowinetimerstop", source)
		elseif Vine >= 10 then
			TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'success', text = 'Przy sobie możesz mieć maksymalnie ' ..MaxVine.. ' butelek wina!' })
			Wait(500)
			TriggerClientEvent("srp_winemaker:processingintowinetimerstop", source)
		end
end)

RegisterServerEvent('srp_winemaker:processingintowinepay')
AddEventHandler('srp_winemaker:processingintowinepay', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local CleanRaisin = xPlayer.getInventoryItem('clean_raisin').count
	local Vine = xPlayer.getInventoryItem('vine').count

	xPlayer.removeInventoryItem('clean_raisin', 20)
	xPlayer.addInventoryItem('vine', 2)
	TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'success', text = 'Przetworzono 20 Winogron' })
	TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'success', text = 'Otrzymano 2 butelki Wina' })
	Wait(500)
end)





---- SELL WINE
RegisterServerEvent('srp_winemaker:sellwine')
AddEventHandler('srp_winemaker:sellwine', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local Vine = xPlayer.getInventoryItem('vine').count

		if Vine >= 1 then
			TriggerClientEvent("srp_winemaker:sellwinefunction", source)
			Wait(500)
		elseif Vine <= 0 then
			TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'error', text = 'Nie masz nic na sprzedaż' })
			TriggerClientEvent("srp_winemaker:sellwinetimerstop", source)
			Wait(500)
		end
end)

RegisterServerEvent('srp_winemaker:sellwinepay')
AddEventHandler('srp_winemaker:sellwinepay', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local Vine = xPlayer.getInventoryItem('vine').count
	local randomPayVine = Vine*math.random(30,40)
	xPlayer.removeInventoryItem('vine', Vine)
	xPlayer.addMoney(randomPayVine)
	TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'success', text = 'Otrzymujesz ' ..randomPayVine.. '$ za ' ..Vine.. ' butelek Wina!' })
	Wait(500)
end)





-- SEL JUS
RegisterServerEvent('srp_winemaker:selljus')
AddEventHandler('srp_winemaker:selljus', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local JusRaisin = xPlayer.getInventoryItem('jus_raisin').count

		if JusRaisin >= 0 then
			TriggerClientEvent("srp_winemaker:selljusfunction", source)
			Wait(500)
		elseif JusRaisin <= 0 then
			TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'error', text = 'Nie masz nic na sprzedaż' })
			TriggerClientEvent("srp_winemaker:selljustimerstop", source)
			Wait(500)
		end
end)

RegisterServerEvent('srp_winemaker:selljuspay')
AddEventHandler('srp_winemaker:selljuspay', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local JusRaisin = xPlayer.getInventoryItem('jus_raisin').count
	local randomPayJus = JusRaisin*math.random(20,35)

	xPlayer.removeInventoryItem('jus_raisin', JusRaisin)
	xPlayer.addMoney(randomPayJus)
	TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'success', text = 'Otrzymujesz '..randomPayJus.. '$ za ' ..JusRaisin.. ' butelek soku Winogronowego!' })
	Wait(500)
end)
--[[
RegisterCommand("pokaztablice", function(source, args, rawCommand)
	TriggerClientEvent('zrider:showUsedPlates',source)
	-- normal function handling here
end, true)
]]