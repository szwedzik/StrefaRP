--Written by Tościk#9715
--Modified by zrider100z

ESX = nil

local isRobbing = false
local minPolice = 2 -- mininalna ilosc LSPD aby umozliwic napad
local onDuty_Police = 0
local enoughPolice = false



TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

--event sprawdzajacy ilosc LSPD
RegisterServerEvent('zrider:jednostki')
AddEventHandler('zrider:jednostki', function()
	onDuty_Police = 0
	local Players = ESX.GetPlayers()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	for i = 1, #Players do
		local xPlayer = ESX.GetPlayerFromId(Players[i])
		if 	xPlayer["job"]["name"] == "police" 
			or xPlayer["job"]["name"] == "statepolice" 
			or xPlayer["job"]["name"] == "sheriff"  then
           		onDuty_Police = onDuty_Police + 1
		end
	end
	
	if onDuty_Police >= minPolice then
		enoughPolice = true
	else
		enoughPolice = false
	end
end)



RegisterServerEvent('outlaw:robberyInProgress')
AddEventHandler('outlaw:robberyInProgress', function(street1, street2, sex, current_zone, direction)
	TriggerClientEvent("outlawNotify", -1, "[Centrala]: ^1Kod 31 ^7 - Rabunek kasy fiskalnej | ^3Podejrzany/a ^7"..sex.." ^7| ^1Ulica ^7| ^7"..street1.."^1 - ^7"..street2 .. " [" .. current_zone .. "] | ^1Kierunek:^7 "..direction)
end)

RegisterServerEvent('outlaw:robberyInProgressS1')
AddEventHandler('outlaw:robberyInProgressS1', function(street1, sex, current_zone, direction)
	TriggerClientEvent("outlawNotify", -1, "[Centrala]: ^1Kod 31 ^7 - Rabunek kasy fiskalnej | ^3Podejrzany/a ^7"..sex.." ^7| ^1Ulica ^7| ^7"..street1.. " [" .. current_zone .. "] | ^1Kierunek:^7 "..direction)
end)


RegisterServerEvent('tost:robbing')
AddEventHandler('tost:robbing', function(bool)
	isRobbing = bool
end)



ESX.RegisterServerCallback('zrider:jednostkiCheck', function(source, cb)
	cb(enoughPolice)
end)

ESX.RegisterServerCallback('zrider:minLSPD', function(source, cb)
	cb(minPolice)
end)

ESX.RegisterServerCallback('tost:checkForRoob', function(source, cb)
	cb(isRobbing)
end)

RegisterServerEvent('tost:zgarnijsiano')
AddEventHandler('tost:zgarnijsiano', function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local Ilosc = math.random(25000,50000)
	TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'y~Zabierasz ' ..Ilosc.. ' z kasy fiskalnej' })
	TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Następną kasę możesz obrabować za 3600 sekund' })
    xPlayer.addMoney(Ilosc)
	Wait(500)
end)


RegisterServerEvent('tost:zawiadompsy')
AddEventHandler('tost:zawiadompsy', function(x, y, z) 
	TriggerClientEvent('tost:infodlalspd', -1, x, y, z)
	--Citizen.Wait(1500)
	--CancelEvent('tost:infodlalspd')
end)