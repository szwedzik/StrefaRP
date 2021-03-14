ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_tattooshop:requestPlayerTattoos', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM playersTattoos WHERE identifier = @identifier', 
	{
		['@identifier'] = xPlayer.identifier
	}, function(result)
		if result[1] ~= nil then
			cb(json.decode(result[1].tattoos))
		else
			local tattooValue = json.encode({})
        MySQL.Async.execute("INSERT INTO playersTattoos (identifier, tattoos) VALUES (@identifier, @tattoos)", {['@identifier'] = xPlayer.identifier, ['@tattoos'] = tattooValue}) 
			cb({})
		end
	end)
end)

ESX.RegisterServerCallback('esx_tattooshop:purchaseTattoo', function(source, cb, tattooList, price, tattoo)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)
		table.insert(tattooList, tattoo)

		MySQL.Async.execute('UPDATE playersTattoos SET tattoos = @tattoos WHERE identifier = @identifier',
		{
			['@tattoos'] = json.encode(tattooList),
			['@identifier'] = xPlayer.identifier
		})

		TriggerClientEvent('esx:showNotification', source, _U('bought_tattoo', price))
		 --TriggerClientEvent('esx:showNotification', source, xPlayer.identifier..json.encode(tattooList) )
		cb(true)
	else
		local missingMoney = price - xPlayer.getMoney()
		TriggerClientEvent('esx:showNotification', source, _U('not_enough_money', missingMoney))
		cb(false)
	end
end)

TriggerEvent('es:addCommand', 'usuntattoo', function(source, args, user)
  	

local xPlayer = ESX.GetPlayerFromId(source)
local xPJob = xPlayer.getJob()
  	
  if(xPJob.name == "ambulance") then
         if args[1] ~= nil and ESX.GetPlayerFromId(args[1]) ~= nil   then
		--local xTarget = ESX.GetPlayerFromId(args[1])
		
  	        TriggerClientEvent('esx_tattooshop:usuntat2', tonumber(args[1]), source, tonumber(args[1]))
		
	--	MySQL.Async.execute('UPDATE playersTattoos SET tattoos = @tattoos WHERE identifier = @identifier',
        --        {
      --                  ['@tattoos'] = json.encode(tattooList),
    --                    ['@identifier'] = xTarget.identifier
  --              })


		
--		TriggerClientEvent("esx:showNotification", tonumber(args[1]), "Twoje dziary zostaly usuniete!")
		-- TriggerClientEvent("esx:showNotification", xPlayer.source, "~y~Zabieg usuwania tatuaży wykonany!")
        else
              -- TriggerClientEvent('esx_tatooshop:usuntat', source)
		TriggerClientEvent("esx:showNotification", xPlayer.source, "~y~Podaj poprawne ID!")
          end
  else
	  TriggerClientEvent("esx:showNotification", xPlayer.source, "~y~Aby usunąć tatuaż udaj się do szpitala!")
  end
 
end)
RegisterNetEvent("esx_tattooshop:distanceNotifySend")
AddEventHandler("esx_tattooshop:distanceNotifySend", function(who, message)
	
	local xPlayer = ESX.GetPlayerFromId(who)
	TriggerClientEvent("esx:showNotification", xPlayer.source, "~y~" .. message)
	

end)

RegisterNetEvent("esx_tattooshop:removeTattoo")
AddEventHandler("esx_tattooshop:removeTattoo", function(who)

        local xPlayer = ESX.GetPlayerFromId(who)
       MySQL.Async.execute('UPDATE playersTattoos SET tattoos = @tattoos WHERE identifier = @identifier',
                {
                        ['@tattoos'] = json.encode(tattooList),
                        ['@identifier'] = xPlayer.identifier
                })
TriggerClientEvent("esx:showNotification", xPlayer.source, "Twoje dziary zostaly usuniete!")
 


end)