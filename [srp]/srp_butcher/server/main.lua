ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
------------config
local maxZywych = 6					--ile można mieć w EQ żywych kurczaków
local MaxMartweKurczaki = 6			--ile można mieć w EQ martwych kurczaków
local MaxUmytych = 6					--ile można mieć w EQ umytych kurczaków
local MaxZapakowanychKurczakow = 6		--ile można mieć w EQ zapakowanych kurczakow
---------Łapanka Kurczaków
RegisterServerEvent('srp_butcher:catching')
AddEventHandler('srp_butcher:catching', function()
local _source = source
local xPlayer = ESX.GetPlayerFromId(source)
local zywyKurczak = xPlayer.getInventoryItem('alive_chicken').count

if zywyKurczak < maxZywych then
xPlayer.addInventoryItem('alive_chicken', 3)
Wait(1500)
else
--TriggerClientEvent('esx:showNotification', source, '~y~Jednorazowo możesz mieć max ~g~'..maxZywych.. '~y~ kurczaków.')
TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'error', text = 'Jednorazowo możesz mieć max '..MaxMartweKurczaki..' martwych kurczaków.' })

Wait(2500)
end
end)
----------Cała przeróbka (rzeźnia+sprzedaż)
RegisterServerEvent('srp_butcher:butcher')
AddEventHandler('srp_butcher:butcher', function(source, opcja)
	local xPlayer = ESX.GetPlayerFromId(source)
	local zywyKurczak = xPlayer.getInventoryItem('alive_chicken').count
	local UmytyKurczak = xPlayer.getInventoryItem('clean_chicken').count
	local MartwyKurczak = xPlayer.getInventoryItem('slaughtered_chicken').count
	local ZapakowanyKurczak = xPlayer.getInventoryItem('packaged_chicken').count
	local randomPay = ZapakowanyKurczak*math.random(35,45)

	if opcja == 1 then	--Ćwiartowanie
		--if zywyKurczak < 1 then
		--	TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'error', text = 'Nie masz kurczaków.' })
		if zywyKurczak >= 1 then
			xPlayer.removeInventoryItem('alive_chicken', zywyKurczak)
			xPlayer.addInventoryItem('slaughtered_chicken', zywyKurczak)
			Wait(500)
			TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Poćwiartowałeś kurczaki' })
		elseif MartwyKurczak < MaxMartweKurczaki then
			--TriggerClientEvent('esx:showNotification', source, '~y~Jednorazowo możesz mieć max ~g~'..MaxMartweKurczaki.. '~y~ martwych kurczaków.')
			--exports['mythic_notify']:DoCustomHudText('error', 'Jednorazowo możesz mieć max ~g~'..MaxMartweKurczaki.. '~y~ martwych kurczaków.', 3500)
			TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'error', text = 'Jednorazowo możesz mieć max '..MaxMartweKurczaki..' martwych kurczaków.' })
			Wait(500)
			TriggerClientEvent('srp_butcher:krojenietimerstop', source)
		end
	end

	if opcja == 2 then	--Mycie
		--if MartwyKurczak < 1 then
		--	TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'error', text = 'Nie masz poćwiartowanych kurczaków.' })
		if MartwyKurczak >= 1 then
			xPlayer.removeInventoryItem('slaughtered_chicken', MartwyKurczak)
			xPlayer.addInventoryItem('clean_chicken', MartwyKurczak)
			Wait(500)
			TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Umyłeś kurczaki' })
		elseif UmytyKurczak < MaxUmytych then
			--TriggerClientEvent('esx:showNotification', source, '~y~Jednorazowo możesz mieć max ~g~'..MaxMartweKurczaki.. '~y~ martwych kurczaków.')
			TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'error', text = 'Jednorazowo możesz mieć max '..MaxMartweKurczaki..' martwych kurczaków.' })
			Wait(500)
			TriggerClientEvent('srp_butcher:mycietimerstop', source)
		end
	end

	if opcja == 3 then	--Pakowanie
		--if UmytyKurczak < 1 then
		--	TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'error', text = 'Nie masz umytych kurczaków.' })
		if UmytyKurczak >= 1 then
			xPlayer.removeInventoryItem('clean_chicken', UmytyKurczak)
			xPlayer.addInventoryItem('packaged_chicken', UmytyKurczak)
			Wait(500)
			TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Zapakowałeś kurczaki' })
		elseif ZapakowanyKurczak < MaxZapakowanychKurczakow then
			--TriggerClientEvent('esx:showNotification', source, '~y~Jednorazowo możesz mieć max ~g~'..MaxMartweKurczaki.. '~y~ martwych kurczaków.')
			--exports['mythic_notify']:DoCustomHudText('error', 'Jednorazowo możesz mieć max ~g~'..MaxMartweKurczaki.. '~y~ martwych kurczaków.', 3500)
			TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'error', text = 'Jednorazowo możesz mieć max '..MaxMartweKurczaki..' martwych kurczaków.' })
			Wait(500)
			TriggerClientEvent('srp_butcher:pakowanietimerstop', source)
		end
	end

	if opcja == 4 then	--Sprzedaż
		--if ZapakowanyKurczak < 1 then
		--	TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'error', text = 'Nie masz zapakowanych kurczaków.' })
		if ZapakowanyKurczak >= 1 then
			xPlayer.removeInventoryItem('packaged_chicken', ZapakowanyKurczak)
			xPlayer.addMoney(randomPay)
			--TriggerClientEvent('esx:showNotification', source, 'Otrzymujesz ~g~'..randomPay.. '$ za przedaż kurczaków.')
			--exports['mythic_notify']:DoCustomHudText('success', 'Otrzymujesz ~g~'..randomPay.. '$ za przedaż kurczaków.', 3500)
			TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Otrzymujesz '..randomPay..'$ za sprzedaż kurczaków.' })
			Wait(500)
			TriggerClientEvent('srp_butcher:selltimerstop', source)
		end
	end
end)

RegisterServerEvent("srp_butcher:dismemberCheck")
AddEventHandler("srp:butcher:dismemberCheck", function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local alive = xPlayer.getInventoryItem('alive_chicken').count

	if alive >= 1 then
		TriggerClientEvent("srp:butcher:candismember2", source, 1)
	elseif alive < 1 then
		TriggerClientEvent("srp:butcher:candismember2", source, 0)
	end
end)

ESX.RegisterServerCallback('zrider:butcherPass', function(source, cb,args)
	local xPlayer = ESX.GetPlayerFromId(source)
	local alive = xPlayer.getInventoryItem(args)

	local pass_bool
	if alive.count >= 1 then
		pass_bool = true
	elseif alive.count < 1 then
		pass_bool = false
	end

	cb(pass_bool)
end)

