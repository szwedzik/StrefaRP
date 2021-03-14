
ESX                       = nil
local PhoneNumbers        = {}
local notifNumber = 1

-- PhoneNumbers = {
--   ambulance = {
--     type  = "ambulance",
--     sources = {
--        ['1'] = true
--     }
--   }
-- }

TriggerEvent('esx:getSharedObject', function(obj)
  ESX = obj
end)

function notifyAlertSMS (number, alert, listSrc)
  if PhoneNumbers[number] ~= nil then
    notifNumber = notifNumber + 1
    notifNumber_str = tostring(notifNumber)
    if notifNumber <10 then
      notifNumber_str = '0000'..notifNumber_str
    elseif notifNumber<100 then
      notifNumber_str = '000'..notifNumber_str
    elseif notifNumber<1000 then
      notifNumber_str = '00'..notifNumber_str
    elseif notifNumber<10000 then
      notifNumber_str = '0'..notifNumber_str
    end
	local mess = 'Zgłoszenie nr '..notifNumber_str..' Treść zgłoszenia: ' .. alert.message
	if alert.coords ~= nil then
		mess = mess .. ' ' .. alert.coords.x .. ', ' .. alert.coords.y 
	end
    for k, _ in pairs(listSrc) do
      getPhoneNumber(tonumber(k), function (n)
        if n ~= nil then
          TriggerEvent('gcPhone:_internalAddMessage', number, n, mess, 0, function (smsMess)
            TriggerClientEvent("gcPhone:receiveMessage", tonumber(k), smsMess)
          end)
          TriggerEvent('gcPhone:_internalAddMessage', alert.numero, n, 'Zgłoszenie nr '..notifNumber_str, 0, function (smsMess)
            TriggerClientEvent("gcPhone:receiveMessage", tonumber(k), smsMess)
          end)
        end
      end)
    end
  end
end

AddEventHandler('esx_phone:registerNumber', function(number, type, sharePos, hasDispatch, hideNumber, hidePosIfAnon)
  --print('= INFO = Rejestracja telefonu ' .. number .. ' => ' .. type)
	local hideNumber    = hideNumber    or false
	local hidePosIfAnon = hidePosIfAnon or false

	PhoneNumbers[number] = {
		type          = type,
    sources       = {},
    alerts        = {}
	}
end)


AddEventHandler('esx:setJob', function(source, job, lastJob)
  if PhoneNumbers[lastJob.name] ~= nil then
    TriggerEvent('esx_addons_gcphone:removeSource', lastJob.name, source)
  end

  if PhoneNumbers[job.name] ~= nil then
    TriggerEvent('esx_addons_gcphone:addSource', job.name, source)
  end
end)
--[[
AddEventHandler('esx_addons_gcphone:addSource', function(number, source)
	PhoneNumbers[number].sources[tostring(source)] = true
end)
--]]
AddEventHandler('esx_addons_gcphone:addSource', function(number, source)
  --TriggerClientEvent('esx:showNotification', source, 'number '..number..' source '..source)
  if number =='police' or number == 'sheriff' or number == 'statepolice' then
    local number2 = 'police'
    --TriggerClientEvent('esx:showNotification', source, '2number '..number2..' source '..source)
    PhoneNumbers[number2].sources[tostring(source)] = true
  else
    PhoneNumbers[number].sources[tostring(source)] = true
  end
end)

AddEventHandler('esx_addons_gcphone:removeSource', function(number, source)
	PhoneNumbers[number].sources[tostring(source)] = nil
end)

RegisterServerEvent('gcPhone:sendMessage')
AddEventHandler('gcPhone:sendMessage', function(number, message)
    local sourcePlayer = tonumber(source)
    if PhoneNumbers[number] ~= nil then
      getPhoneNumber(source, function (phone) 
        notifyAlertSMS(number, {
          message = message,
          numero = phone,
        }, PhoneNumbers[number].sources)
      end)
    end
end)

RegisterServerEvent('esx_addons_gcphone:startCall')
AddEventHandler('esx_addons_gcphone:startCall', function (number, message, coords)
  local source = source
  if PhoneNumbers[number] ~= nil then
    getPhoneNumber(source, function (phone) 
      notifyAlertSMS(number, {
        message = message,
        coords = coords,
        numero = phone,
      }, PhoneNumbers[number].sources)
    end)
  else
    --print('= WARNING = Appels sur un service non enregistre => numero : ' .. number)
  end
end)


AddEventHandler('esx:playerLoaded', function(source)
  if ESX ~= nil then
  local xPlayer = ESX.GetPlayerFromId(source)
  local notify = "police"
  
  MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier',{
    ['@identifier'] = xPlayer.identifier
  }, function(result)

    local phoneNumber = result[1].phone_number
    xPlayer.set('phoneNumber', phoneNumber)

    if PhoneNumbers[xPlayer.job.name] ~= nil then
      TriggerEvent('esx_addons_gcphone:addSource', xPlayer.job.name, source)
    end
  end)
end
end)


AddEventHandler('esx:playerDropped', function(source)
  if ESX ~= nil then
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local notify = "police"
    if PhoneNumbers[xPlayer.job.name] ~= nil then
      TriggerEvent('esx_addons_gcphone:removeSource', xPlayer.job.name, source)
    end
  end
end)


function getPhoneNumber (source, callback) 
  if ESX ~= nil then
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer == nil then
    callback(nil)
  end
  MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier',{
    ['@identifier'] = xPlayer.identifier
  }, function(result)
    --TriggerClientEvent('esx:showNotification', source, 'poszlo '..result[1].phone_number)
    callback(result[1].phone_number)
  end)
end
end



RegisterServerEvent('esx_phone:send')
AddEventHandler('esx_phone:send', function(number, message, _, coords)
  local source = source
  if PhoneNumbers[number] ~= nil then
    getPhoneNumber(source, function (phone) 
      notifyAlertSMS(number, {
        message = message,
        coords = coords,
        numero = phone,
      }, PhoneNumbers[number].sources)
    end)
  else
    -- print('esx_phone:send | Appels sur un service non enregistre => numero : ' .. number)
  end
end)

RegisterCommand('numer', function() 
  for i=1, #PhoneNumbers, 1 do
    print(PhoneNumbers[i].number)
  end 
end, false)