ESX = nil
mandatAmount = nil
mozna = true
TriggerEvent('esx:getSharedObject', function(obj)
  ESX = obj
end)
RegisterServerEvent('hospital:price')
AddEventHandler('hospital:price', function()
  	local price = 5000
	print('sever')
	local targetXPlayer = ESX.GetPlayerFromId(source)
	--targetXPlayer.removeBank(price)
	print(price)
	targetXPlayer.removeAccountMoney('bank', price)
end)

RegisterServerEvent('sprawdz:ambulans')
AddEventHandler('sprawdz:ambulans', function()
local xPlayers = ESX.GetPlayers()
local cops = 0
print('1')
for i=1, #xPlayers, 1 do
	 local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
	 if xPlayer.job.name == 'ambulance' then
			cops = cops + 1
	end
end
print('2')
if cops == 0 then
	print('3')
	if mozna == true then
	TriggerClientEvent('smerfik:lekarz', source)
	mozna = false
	Citizen.Wait(60000)
	mozna = true
	else
		TriggerClientEvent('esx:showHelpNotification', source, '~r~Doktor aktualnie jest zajęty, poczekaj na swoją kolej!')
end
else
	TriggerClientEvent('smerfik:zaduzomedykow', source)
end

end)
RegisterServerEvent('esx_ambulancejob:revivel')
AddEventHandler('esx_ambulancejob:revivel', function(target)
    local xPlayer = ESX.GetPlayerFromId(source)

        TriggerClientEvent('esx_ambulancejob:revive', target)

end)
