ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('projektsantos:mandat')
AddEventHandler('projektsantos:mandat', function(source, fine, powod)

		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeAccountMoney('bank', fine)

		TriggerEvent('esx_addonaccount:getSharedAccount', 'society_police', function(account)
			account.addMoney(fine)
		end)
		
		local xPlayers = ESX.GetPlayers()

			for i=1, #xPlayers, 1 do

  				local xPlayerX = ESX.GetPlayerFromId(xPlayers[i])
  				TriggerClientEvent('projektsantos:mandatnotify', xPlayerX.source, fine, source, powod, "^2MANDAT")

			end
end)

RegisterServerEvent('projektsantos:wiezienie')
AddEventHandler('projektsantos:wiezienie', function(source, czas, powod, grzywna)

		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeAccountMoney('bank', grzywna)

		TriggerEvent('esx_addonaccount:getSharedAccount', 'society_police', function(account)
			account.addMoney(grzywna)
		end)
		
		if grzywna > 0 then
		local xPlayers = ESX.GetPlayers()

			for i=1, #xPlayers, 1 do

  				local xPlayerX = ESX.GetPlayerFromId(xPlayers[i])
  				TriggerClientEvent('projektsantos:mandatnotify', xPlayerX.source, grzywna, source, powod, "^2MANDAT")

			end
		end

		--TriggerEvent("esx_jailer:sendToJailPanel", source, czas, powod)
		TriggerEvent('esx-qalle-jail:jailPlayer', source, czas, powod)
		TriggerClientEvent('esx_policejob:unrestrain', source)
		TriggerClientEvent('projektsantos:jailnotify', -1, czas, source, powod, "^2SĘDZIA")
		Citizen.Wait(12500)
		TriggerClientEvent('esx-qalle-jail:checkCharacter', source)
end)

RegisterServerEvent('projektsantos:mandathajs')
AddEventHandler('projektsantos:mandathajs', function(amount)

  local xPlayer = ESX.GetPlayerFromId(source)
  xPlayer.addAccountMoney('bank', 1000)
  
end)



RegisterServerEvent('insertKarto')
AddEventHandler('insertKarto', function(data)
	MySQL.Async.execute('INSERT INTO kartoteka (firstname, lastname, dateofbirth, verdict, cop) VALUES (@firstname, @lastname, @dateofbirth, @verdict, @cop)', {
		['@firstname'] = data.firstname,
		['@lastname'] = data.lastname,
		['@dateofbirth'] = data.dob,
		['@verdict'] = data.verdict,
		['@cop'] = data.cop
	}, function (rowsChanged)
		print('KARTO INSERTED')
	end)
end)  

ESX.RegisterServerCallback('findKarto', function(source, cb, data)
	MySQL.Async.fetchAll('SELECT * FROM kartoteka WHERE firstname = @firstname AND lastname = @lastname', {
		['@firstname'] = data.firstname,
		['@lastname'] = data.lastname
	}, function(results)
		cb(results)
	end)
end)

ESX.RegisterServerCallback('openKarto', function(source, cb, data)
	MySQL.Async.fetchAll('SELECT * FROM kartoteka WHERE id = @id', {
		['@id'] = data.id
	}, function(result)
		cb(result[1])
	end)
end)