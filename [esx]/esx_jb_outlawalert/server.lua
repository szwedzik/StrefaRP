ESX                = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_jb_outlawalert:kolizjaalert')
AddEventHandler('esx_jb_outlawalert:kolizjaalert', function(street1, street2, veh, current_zone, direction, plate, primary, secondary)
	if veh == "NULL" then
		TriggerClientEvent("outlawNotify", -1, "[Centrala]: ^1 10-50 ^7 - Kolizja drogowa | Pojazd ^7"..veh.." (^1" .. plate .. " ^7| ^1".. primary ..", ^7".. secondary .. ") ^7|  ^1Ulica ^7"..street1.."^1 - ^7"..street2 .. " [" .. current_zone .. "] | ^1Kierunek:^7 "..direction)
	else
		TriggerClientEvent("outlawNotify", -1, "[Centrala]: ^1 10-50 ^7 - Kolizja drogowa | Pojazd ^7"..veh.." (^1" .. plate .. " ^7| ^1".. primary ..", ^7".. secondary .. ") ^7|  ^1Ulica ^7"..street1.."^1 - ^7"..street2 .. " [" .. current_zone .. "] | ^1Kierunek:^7 "..direction)
	end
end)
RegisterServerEvent('esx_outlawalert:kolizjaalertS1')
AddEventHandler('esx_outlawalert:kolizjaalertS1', function(street1, veh, current_zone, direction, plate, primary, secondary)
	if veh == "NULL" then
		TriggerClientEvent("outlawNotify", -1, "[Centrala]: ^1 10-50 ^7 - Kolizja drogowa | Pojazd ^7"..veh.." (^1" .. plate .. " ^7| ^1".. primary ..", ^7".. secondary .. ") ^7|  ^1Ulica ^7"..street1 .. " [" .. current_zone .. "] | ^1Kierunek:^7 "..direction)
	else
		TriggerClientEvent("outlawNotify", -1, "[Centrala]: ^1 10-50 ^7 - Kolizja drogowa | Pojazd ^7"..veh.." (^1" .. plate .. " ^7| ^1".. primary ..", ^7".. secondary .. ") ^7|  ^1Ulica ^7"..street1 .. " [" .. current_zone .. "] | ^1Kierunek:^7 "..direction)
	end
end)

ESX.RegisterServerCallback('zrider:carTheftPromtRandomizer',function(source,cb)
	local RandomNum = math.random(1,100)
	if RandomNum > 30 then
		cb(false)
	else
		cb(true)
	end
end)

RegisterServerEvent('thiefInProgress')
AddEventHandler('thiefInProgress', function(street1, street2, veh, sex, current_zone, direction, plate, primary, secondary)

		if veh == "NULL" then
			TriggerClientEvent("outlawNotify", -1, "[Centrala]: ^1Kod 37 ^7 - Kradzież pojazdu | ^3Podejrzany/a ^7"..sex.." ^7| ^1Ulica ^7| ^7"..street1.."^1 - ^7"..street2 .. " [" .. current_zone .. "] | ^1Kierunek:^7 "..direction)
		else
			TriggerClientEvent("outlawNotify", -1, "[Centrala]: ^1Kod 37 ^7 - Kradzież pojazdu | Pojazd ^7"..veh.."(^1" .. plate .. " ^7| ^1".. primary ..", ^7".. secondary .. ") ^7| ^3Podejrzany/a ^1^7"..sex.." ^7| ^1Ulica ^7"..street1.."^1 - ^7"..street2 .. " [" .. current_zone .. "] | ^1Kierunek:^7 "..direction)
		end

end)
RegisterServerEvent('thiefInProgressS1')
AddEventHandler('thiefInProgressS1', function(street1, veh, sex, current_zone, direction, plate, primary, secondary)

		if veh == "NULL" then
			TriggerClientEvent("outlawNotify", -1, "[Centrala]: ^1Kod 37 ^7 - Kradzież pojazdu | ^3Podejrzany/a ^7"..sex.." ^7| ^1Ulica ^7"..street1 .. " [" .. current_zone .. "] | ^1Kierunek:^7 "..direction)
		else
			TriggerClientEvent("outlawNotify", -1, "[Centrala]: ^1Kod 37 ^7 - Kradzież pojazdu | Pojazd ^7"..veh.." (^1" .. plate .. " ^7| ^1".. primary ..", ^7".. secondary .. ") ^7| ^3Podejrzany/a ^1^7"..sex.." ^7| ^1Ulica ^7"..street1 .. " [" .. current_zone .. "] | ^1Kierunek:^7 "..direction)
		end

end)

RegisterServerEvent('thiefInProgressPolice')
AddEventHandler('thiefInProgressPolice', function(street1, street2, veh, sex, current_zone, direction, plate, primary, secondary)

		if veh == "NULL" then
			TriggerClientEvent("outlawNotify", -1, "[Centrala]: ^1Kod 37 ^7 - Kradzież pojazdu | ^3Podejrzany/a ^7"..sex.." ^7| ^1Ulica ^7| ^7"..street1.."^1 - ^7"..street2 .. " [" .. current_zone .. "] | ^1Kierunek:^7 "..direction)
		else
			TriggerClientEvent("outlawNotify", -1, "[Centrala]: ^1Kod 37 ^7 - Kradzież pojazdu | Pojazd ^7"..veh.." (^1" .. plate .. " ^7| ^1".. primary ..", ^7".. secondary .. ") ^7| ^3Podejrzany/a ^1^7"..sex.." ^7| ^1Ulica ^7"..street1.."^1 - ^7"..street2 .. " [" .. current_zone .. "] | ^1Kierunek:^7 "..direction)
		end

end)



RegisterServerEvent('thiefInProgressS1Police')
AddEventHandler('thiefInProgressS1Police', function(street1, veh, sex, current_zone, direction, plate, primary, secondary)
	
		if veh == "NULL" then
			TriggerClientEvent("outlawNotify", -1, "[Centrala]: ^1Kod 37 ^7 - Kradzież pojazdu | ^3Podejrzany/a ^7"..sex.." ^7| ^1Ulica ^7"..street1 .. " [" .. current_zone .. "] | ^1Kierunek:^7 "..direction)
		else
			TriggerClientEvent("outlawNotify", -1, "[Centrala]: ^1Kod 37 ^7 - Kradzież pojazdu | Pojazd ^7"..veh.." (^1" .. plate .. " ^7| ^1".. primary ..", ^7".. secondary .. ") ^7| ^3Podejrzany/a ^1^7"..sex.." ^7| ^1Ulica ^7"..street1 .. " [" .. current_zone .. "] | ^1Kierunek:^7 "..direction)
		end

end)

--------------Broń Biała/Bójka
 RegisterServerEvent('meleeInProgress')
 AddEventHandler('meleeInProgress', function(street1, street2, sex, current_zone, direction)
	 TriggerClientEvent("outlawNotify", -1, "[Centrala]: ^110-34 ^7 - Zgłoszenie bójki | ^3Podejrzany/a ^7"..sex.." ^7| ^1Ulica ^7| ^7"..street1.."^1 - ^7"..street2 .. " [" .. current_zone .. "] | ^1Kierunek:^7 "..direction)
 end)

 RegisterServerEvent('meleeInProgressS1')
 AddEventHandler('meleeInProgressS1', function(street1, sex, current_zone, direction)
	 TriggerClientEvent("outlawNotify", -1, "[Centrala]: ^110-34 ^7 - Zgłoszenie bójki | ^3Podejrzany/a ^7"..sex.." ^7| ^1Ulica ^7| ^7"..street1 .. " [" .. current_zone .. "] | ^1Kierunek:^7 "..direction)
 end)


----------------------długa
RegisterServerEvent('gunshotInProgresslong')
AddEventHandler('gunshotInProgresslong', function(street1, street2, sex, current_zone, direction)
	TriggerClientEvent("outlawNotify", -1, "[Centrala]: ^110-71 ^7 - Strzały! ^2| ^3Podejrzany/a ^7"..sex.." ^2| ^3Broń ^1Klasy II ^2| ^3Ulica ^7"..street1.."^1 - ^7"..street2 .. " [" .. current_zone .. "] ^2| ^3Kierunek:^2 "..direction)
end)

RegisterServerEvent('gunshotInProgressS1long')
AddEventHandler('gunshotInProgressS1long', function(street1, sex, current_zone, direction)
	TriggerClientEvent("outlawNotify", -1, "[Centrala]: ^110-71 ^7 - Strzały! ^2| ^3Podejrzany/a ^7"..sex.." ^2| ^3Broń ^1Klasy II ^2| ^3Ulica ^7"..street1 .. " [" .. current_zone .. "] ^2| ^3Kierunek:^2 "..direction)
end)
-----------------------------------

-----krótka
RegisterServerEvent('gunshotInProgress')
AddEventHandler('gunshotInProgress', function(street1, street2, sex, current_zone, direction)
	TriggerClientEvent("outlawNotify", -1, "[Centrala]: ^110-71 ^7 - Strzały! ^2| ^3Podejrzany/a ^7"..sex.." ^2| ^3Broń ^6Klasy I ^2| ^3Ulica ^7"..street1.."^1 - ^7"..street2 .. " [" .. current_zone .. "] ^2| ^3Kierunek:^2 "..direction)
end)

RegisterServerEvent('gunshotInProgressS1')
AddEventHandler('gunshotInProgressS1', function(street1, sex, current_zone, direction)
	TriggerClientEvent("outlawNotify", -1, "[Centrala]: ^110-71 ^7 - Strzały! ^2| ^3Podejrzany/a ^7"..sex.." ^2| ^3Broń  ^6Klasy I ^2| ^3Ulica ^7"..street1 .. " [" .. current_zone .. "] ^2| ^3Kierunek:^2 "..direction)
end)
--------------------------

--------------------Limit LSPD
RegisterServerEvent('lspdLimit')
AddEventHandler('lspdLimit', function()
	TriggerClientEvent("outlawNotify", -1, "[Centrala]: ^1 Ponad 7 funkcjonariuszy - proszę przejść na sąsiędnią dzielnicę!")
end)
RegisterServerEvent('gunshotInProgressHolding')
AddEventHandler('gunshotInProgressHolding', function(street1, street2, sex, current_zone, direction, whatGun)
	TriggerClientEvent("outlawNotify", -1, "[Centrala]: ^110-32 ^7| ^3Podejrzany/a ^7"..sex.." ^7 | Broń: ".. whatGun .." | ^1Ulica ^7"..street1.."^1 - ^7"..street2 .. " [" .. current_zone .. "] | ^1Kierunek:^7 "..direction)
end)

RegisterServerEvent('gunshotInProgressS1Holding')
AddEventHandler('gunshotInProgressS1Holding', function(street1, sex, current_zone, direction, whatGun)
	TriggerClientEvent("outlawNotify", -1, "[Centrala]: ^110-32 ^7| ^3Podejrzany/a ^7"..sex.." ^7 | Broń: ".. whatGun .." | ^1Ulica ^7"..street1 .. " [" .. current_zone .. "] | ^1Kierunek:^7 "..direction)
end)

RegisterServerEvent('drugInProgress')
AddEventHandler('drugInProgress', function(street1, street2, sex, current_zone, direction)
	TriggerClientEvent("outlawNotify", -1, "[Centrala]: ^110-30 - Narkotyki ^7| ^3Podejrzany/a ^7"..sex.." ^7| ^1Ulica ^7| ^7"..street1.."^1 - ^7"..street2 .. " [" .. current_zone .. "] | ^1Kierunek:^7 "..direction)
end)

RegisterServerEvent('drugInProgressS1')
AddEventHandler('drugInProgressS1', function(street1, sex, current_zone, direction)
	TriggerClientEvent("outlawNotify", -1, "[Centrala]: ^110-30 - Narkotyki ^7| ^3Podejrzany/a ^1^7"..sex.." ^7| ^1Ulica ^7"..street1 .. " [" .. current_zone .. "] | ^1Kierunek:^7 "..direction)
end)

RegisterServerEvent('drugInProgressPos')
AddEventHandler('drugInProgressPos', function(tx, ty, tz)
	TriggerClientEvent('drugPlace', -1, tx, ty, tz)
end)

RegisterServerEvent('thiefInProgressPos')
AddEventHandler('thiefInProgressPos', function(tx, ty, tz)
	TriggerClientEvent('thiefPlace', -1, tx, ty, tz)
end)


RegisterServerEvent('gunshotInProgressPos')
AddEventHandler('gunshotInProgressPos', function(gx, gy, gz, radius)
	TriggerClientEvent('gunshotPlace', -1, gx, gy, gz, radius)
end)

RegisterServerEvent('meleeInProgressPos')
AddEventHandler('meleeInProgressPos', function(mx, my, mz)
	TriggerClientEvent('meleePlace', -1, mx, my, mz)
end)


RegisterServerEvent('npcrobInProgress')
AddEventHandler('npcrobInProgress', function(street1, street2, sex, current_zone, direction)
	TriggerClientEvent("outlawNotify", -1, "[Centrala]: ^1Zgłoszenie o napaści na cywila ^7| ^3Podejrzany/a ^7"..sex.." ^7| ^1Ulica ^7| ^7"..street1.."^1 - ^7"..street2 .. " [" .. current_zone .. "] | ^1Kierunek:^7 "..direction)
end)

RegisterServerEvent('npcrobInProgressS1')
AddEventHandler('npcrobInProgressS1', function(street1, sex, current_zone, direction)
	TriggerClientEvent("outlawNotify", -1, "[Centrala]: ^1Zgłoszenie o napaści na cywila ^7| ^3Podejrzany/a ^1^7"..sex.." ^7| ^1Ulica ^7"..street1 .. " [" .. current_zone .. "] | ^1Kierunek:^7 "..direction)
end)

RegisterServerEvent('npcrobInProgressPos')
AddEventHandler('npcrobInProgressPos', function(tx, ty, tz)
	TriggerClientEvent('npcrobPlace', -1, tx, ty, tz)
end)

ESX.RegisterServerCallback('esx_outlawalert:ownvehicle',function(source,cb, vehicleProps)
	local isFound = false
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local vehicules = getPlayerVehicles(xPlayer.getIdentifier())
	local plate = vehicleProps.plate
	
		for _,v in pairs(vehicules) do
			if(plate == v.plate)then
				isFound = true
				break
			end		
		end
		cb(isFound)
end)

function getPlayerVehicles(identifier)
	
	local vehicles = {}
	local data = MySQL.Sync.fetchAll("SELECT * FROM owned_vehicles WHERE owner=@identifier",{['@identifier'] = identifier})	
	for _,v in pairs(data) do
		local vehicle = json.decode(v.vehicle)
		table.insert(vehicles, {id = v.id, plate = vehicle.plate})
	end
	return vehicles
end