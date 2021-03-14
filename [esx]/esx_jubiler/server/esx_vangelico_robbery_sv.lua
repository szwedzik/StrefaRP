local rob = false
local robbers = {}
PlayersCrafting    = {}
local CopsConnected  = 0
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

RegisterServerEvent('esx_vangelico_robbery:toofar')
AddEventHandler('esx_vangelico_robbery:toofar', function(robb)
	local source = source
	local xPlayers = ESX.GetPlayers()
	rob = false
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'statepolice' then
			--TriggerClientEvent('esx:showNotification', xPlayers[i], _U('robbery_cancelled_at') .. Stores[robb].nameofstore)
			TriggerClientEvent('mythic_notify:client:SendJobAlert', xPlayers[i], { type = 'error', text = 'Rabunek w ' .. Stores[robb].nameofstore .. ' został przerwany!' })
			TriggerClientEvent('esx_vangelico_robbery:killblip', xPlayers[i])
		end
	end
	if(robbers[source])then
		TriggerClientEvent('esx_vangelico_robbery:toofarlocal', source)
		robbers[source] = nil
		--TriggerClientEvent('esx:showNotification', source, _U('robbery_has_cancelled') .. Stores[robb].nameofstore)
		TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'error', text = 'Rabunek w ' .. Stores[robb].nameofstore .. ' został przerwany!' })
	end
end)

RegisterServerEvent('esx_vangelico_robbery:endrob')
AddEventHandler('esx_vangelico_robbery:endrob', function(robb)
	local source = source
	local xPlayers = ESX.GetPlayers()
	rob = false
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		 if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'statepolice' then
			TriggerClientEvent('mythic_notify:client:SendJobAlert', xPlayers[i], { type = 'error', text = 'Rabunek w ' .. Stores[robb].nameofstore .. ' został zakończony!' })
			--TriggerClientEvent('esx:showNotification', xPlayers[i], _U('end'))
			TriggerClientEvent('esx_vangelico_robbery:killblip', xPlayers[i])
		end
	end
	if(robbers[source])then
		TriggerClientEvent('esx_vangelico_robbery:robberycomplete', source)
		robbers[source] = nil
		TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'error', text = 'Rabunek w ' .. Stores[robb].nameofstore .. ' został zakończony!' })
		--TriggerClientEvent('esx:showNotification', source, _U('robbery_has_ended') .. Stores[robb].nameofstore)
	end
end)


RegisterServerEvent('esx_jubiler:robberyInProgress')
AddEventHandler('esx_jubiler:robberyInProgress', function(street1, street2, sex, current_zone, direction)
	TriggerClientEvent("outlawNotify", -1, "[Centrala]: ^1Kod 90 ^7 - Rabunek u Jubilera | ^3Podejrzany/a ^7"..sex.." ^7| ^1Ulica ^7| ^7"..street1.."^1 - ^7"..street2 .. " [" .. current_zone .. "] | ^1Kierunek:^7 "..direction)
end)

RegisterServerEvent('esx_jubiler:robberyInProgressS1')
AddEventHandler('esx_jubiler:robberyInProgressS1', function(street1, sex, current_zone, direction)
	TriggerClientEvent("outlawNotify", -1, "[Centrala]: ^1Kod 90 ^7 - Rabunek u Jubilera | ^3Podejrzany/a ^7"..sex.." ^7| ^1Ulica ^7| ^7"..street1.. " [" .. current_zone .. "] | ^1Kierunek:^7 "..direction)
end)

RegisterServerEvent('esx_jubiler:zawiadompsy')
AddEventHandler('esx_jubiler:zawiadompsy', function(x, y, z) 
	TriggerClientEvent('esx_jubiler:infodlalspd', -1, x, y, z)
end)

RegisterServerEvent('esx_vangelico_robbery:rob')
AddEventHandler('esx_vangelico_robbery:rob', function(robb)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	
	if Stores[robb] then
		local store = Stores[robb]
		if (os.time() - store.lastrobbed) < 600 and store.lastrobbed ~= 0 then
			TriggerClientEvent('esx_vangelico_robbery:togliblip', source)
			TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Ten jubiler został już obrabowany, odczekaj ' .. (1800 - (os.time() - store.lastrobbed)) .. ' sekund' })
			--TriggerClientEvent('esx:showNotification', source, _U('already_robbed') .. (1800 - (os.time() - store.lastrobbed)) .. _U('seconds'))
			return
		end

		local cops = 0
		for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'statepolice' then
				cops = cops + 1
			end
		end

		if rob == false then
			local random = math.random(1,100)
			if(cops >= Config.RequiredCopsRob)then
				rob = true
				for i=1, #xPlayers, 1 do
					local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
					if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'statepolice' then
						if random >= 5 then
							--TriggerClientEvent('mythic_notify:client:SendJobAlert', xPlayers[i], { type = 'inform', text = 'Rabunek w trakcie: ' .. store.nameofstore })
							--TriggerClientEvent('esx:showNotification', xPlayers[i], _U('rob_in_prog') .. store.nameofstore)
							--TriggerClientEvent('esx_vangelico_robbery:setblip', xPlayers[i], Stores[robb].position)
						elseif random < 5 then
						end
					end
				end
				if random >= 5 then
					TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Pobrano wszystkie dane dotyczące alarmu.' })
					Citizen.Wait(1000)
					TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Próba wyłączenia alarmu zakończyła się niepowodzeniem.' })
					Citizen.Wait(1000)
					TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Gdy zbierzesz wszystkie fanty uciekaj!' })
				elseif random < 5 then
					TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Pobrano wszystkie dane dotyczące alarmu.' })
					Citizen.Wait(1000)
					TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Próba wyłączenia alarmu zakończyła się powodzeniem.' })
					Citizen.Wait(1000)
					TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Gdy zbierzesz wszystkie fanty uciekaj!' })
				end
				--TriggerClientEvent('esx:showNotification', source, _U('started_to_rob') .. store.nameofstore .. _U('do_not_move'))
				--TriggerClientEvent('esx:showNotification', source, _U('alarm_triggered'))
				--TriggerClientEvent('esx:showNotification', source, _U('hold_pos'))
				TriggerClientEvent('esx_jubiler:alertFP', source)
				TriggerClientEvent('esx_vangelico_robbery:currentlyrobbing', source, robb)
				TriggerClientEvent('esx_vangelico_robbery:currentlyrobbingnear', source, robb)
                CancelEvent()
				Stores[robb].lastrobbed = os.time()
			else
				TriggerClientEvent('esx_vangelico_robbery:togliblip', source)
				--TriggerClientEvent('esx:showNotification', source, _U('min_two_police'))
				TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Musi być conajmniej ' .. Config.RequiredCopsRob .. ' Funkcjonariuszy na służbie, aby rozpocząć rabunek'})

			end
		else
			TriggerClientEvent('esx_vangelico_robbery:togliblip', source)
			TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Rabunek jest już w toku!'})
			--TriggerClientEvent('esx:showNotification', source, _U('robbery_already'))
		end
	end
end)

RegisterServerEvent('esx_vangelico_robbery:gioielli1')
AddEventHandler('esx_vangelico_robbery:gioielli1', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem('jewels', math.random(3, 5))
end)

function CountCops()
	local xPlayers = ESX.GetPlayers()
	CopsConnected = 0
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'statepolice' then
			CopsConnected = CopsConnected + 1
		end
	end
	SetTimeout(120 * 1000, CountCops)
end

CountCops()

local function Craft(source)
	SetTimeout(4000, function()
		if PlayersCrafting[source] == true and CopsConnected >= Config.RequiredCopsSell then
			local xPlayer  = ESX.GetPlayerFromId(source)
			local JewelsQuantity = xPlayer.getInventoryItem('jewels').count
			local radomjewels = math.random(1, 5)
			local randompay = math.random(2500, 4000)
			local randomtotalpay = radomjewels*randompay
			if JewelsQuantity < radomjewels then 
				TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Nie posiadasz wystarczająco biżuterii'})
				--TriggerClientEvent('esx:showNotification', source, _U('notenoughgold'))
			else   
                xPlayer.removeInventoryItem('jewels', radomjewels)
                Citizen.Wait(3000)
				xPlayer.addMoney(randomtotalpay)
				Craft(source)
			end
		else
		TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Aby sprzedawac fanty potrzeba jest ' .. Config.RequiredCopsSell .. ' Funkcjonariuszy na służbie.'})
		--TriggerClientEvent('esx:showNotification', source, _U('copsforsell'))
		end
	end)
end
--[[
RegisterServerEvent('lester:vendita')
AddEventHandler('lester:vendita', function()
	local _source = source
	PlayersCrafting[_source] = true
	TriggerClientEvent('esx:showNotification', _source, _U('goldsell'))
	Craft(_source)
end)

RegisterServerEvent('lester:nvendita')
AddEventHandler('lester:nvendita', function()
	local _source = source
	PlayersCrafting[_source] = false
end)
--]]
