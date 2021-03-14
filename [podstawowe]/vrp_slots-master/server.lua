ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("ples-slots:catiLeiBagi")
AddEventHandler("ples-slots:catiLeiBagi", function()
  local user_id = ESX.GetPlayerFromId(source)
  if user_id then
    vRP.prompt({source, "How much you bet ? ( multiple of 50 ): ", "", function(source, amount)
      amount = parseInt(amount)
      if amount % 50 == 0 and amount >= 50 then
        if vRP.tryPayment({user_id, amount}) then
          TriggerClientEvent("ples-slots:bagXLei", source, amount)
        else
          TriggerClientEvent(ESX.ShowNotification(source, {"~r~Not enought money"})))
        end
      else
        vRPclient.notify(source, {"You have to insert a multiple of 50.~n~~y~ex: 100, 350, 2500"})
      end
    end})
  end
end)

RegisterServerEvent("ples-slots:aiCastigat")
AddEventHandler("ples-slots:aiCastigat", function(amount)
  local user_id = vRP.getUserId({source})
  if user_id then
    amount = tonumber(amount)
    if amount > 0 then
      vRP.giveMoney({user_id, amount})
      TriggerClientEvent("chatMessage", source, "^1Slots^7: You won ^2$"..amount.."^7 not bad at all!")
    else
      TriggerClientEvent("chatMessage", source, "^1Slots^7: Unfortunately you've ^1lost ^7all the money, maybe next time.")
    end
  end
end)
