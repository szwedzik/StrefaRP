local potrzebniPolicjanci = 3  		--<< potrzebni policjanci do aktywacji misji
local czastimer = 10000 * 1000	    --<< timer co ile mozna robic misje, domyslnie 2000 sekund
local gotowkaA = 10000 				--<< ile minimum mozesz dostac z rabunku
local gotowkaB = 30000 				--<< ile maximum mozesz dostac z rabunku
local KosztAktywacji = 2000 		--<< ile kosztuje aktywacja misji (czystej z banku)
-----------------------------------
local MisjaAktywna = 0
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

RegisterServerEvent('napadtransport:akceptujto')
AddEventHandler('napadtransport:akceptujto', function()
	local copsOnDuty = 0
	local Players = ESX.GetPlayers()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local money = 0
	money = xPlayer.getMoney()
	if MisjaAktywna == 0 then
		if money < KosztAktywacji then
			--TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'error', text = 'Potrzebujesz '..KosztAktywacji..'$ aby otrzymać informacje o zleceniu' })
			TriggerClientEvent('srp_cars:nomoney', source)
		else
		for i = 1, #Players do
			local xPlayer = ESX.GetPlayerFromId(Players[i])
			if xPlayer["job"]["name"] == "police" or xPlayer["job"]["name"] == "statepolice" or xPlayer["job"]["name"] == "sheriff" then
				copsOnDuty = copsOnDuty + 1
			end
		end
		if copsOnDuty >= potrzebniPolicjanci then
			TriggerClientEvent("napadtransport:Pozwolwykonac", _source)
			xPlayer.removeMoney(KosztAktywacji)
			OdpalTimer()
		else
			--TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'error', text = 'Potrzeba przynajmniej '..potrzebniPolicjanci.. ' Funkcjonariuszy aby aktywować zlecenie.' })
			TriggerClientEvent('srp_cars:nocops', source)
		end
	end
	else
		--TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'error', text = 'Wybacz.. Ale ktoś już dostał to zlecenie..' })
		TriggerClientEvent('srp_cars:bussy', source)
	end
end)

function OdpalTimer()
MisjaAktywna = 1
Wait(czastimer)
MisjaAktywna = 0
end

RegisterServerEvent('srp_cars:InformBlip')
AddEventHandler('srp_cars:InformBlip', function(g6)
	TriggerClientEvent('srp_cars:BlipInfo2', -1, g6)
end)

RegisterServerEvent('napadtransport:zawiadompsy')
AddEventHandler('napadtransport:zawiadompsy', function(x, y, z) 
    TriggerClientEvent('napadtransport:infodlalspd', -1, x, y, z)
end)

RegisterServerEvent('srp_cars:SendAllert')
AddEventHandler('srp_cars:SendAllert', function(location)
	TriggerClientEvent("outlawNotify", -1, "[Centrala]: ^110-90b ^7 - Zgłoszenie z furgonetki Gruppe6 | ^3na ulicy ^7" ..location)
end)

RegisterServerEvent('srp_cars:robberyInProgress')
AddEventHandler('srp_cars:robberyInProgress', function(street1, street2, sex, current_zone, direction)
	TriggerClientEvent("outlawNotify", -1, "[Centrala]: ^110-90b ^7 - Napad na furgonetkę Gruppe6 | ^3Podejrzany/a ^7"..sex.." ^7| ^1Ulica ^7| ^7"..street1.."^1 - ^7"..street2 .. " [" .. current_zone .. "] | ^1Kierunek:^7 "..direction)
end)

RegisterServerEvent('srp_cars:robberyInProgressS1')
AddEventHandler('srp_cars:robberyInProgressS1', function(street1, sex, current_zone, direction)
	TriggerClientEvent("outlawNotify", -1, "[Centrala]: ^110-90b ^7 - Napad na furgonetkę Gruppe6 | ^3Podejrzany/a ^7"..sex.." ^7| ^1Ulica ^7| ^7"..street1.. " [" .. current_zone .. "] | ^1Kierunek:^7 "..direction)
end)

RegisterServerEvent('napadtransport:graczZrobilnapad')
AddEventHandler('napadtransport:graczZrobilnapad', function()
local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
local LosujSiano = math.random(gotowkaA,gotowkaB)
local chance = math.random(0,100)
if chance <= 40 then
	xPlayer.addInventoryItem('keycard2', 1)
end
xPlayer.addMoney(LosujSiano)
--TriggerClientEvent('esx:showNotification', source, 'Zabierasz ~g~'..LosujSiano..'$~w~ z furgonetki')
TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'success', text = 'Zabierasz '..LosujSiano..'$ z furgonetki' })
--Wait(2500)
--MisjaAktywna = 0
end)
