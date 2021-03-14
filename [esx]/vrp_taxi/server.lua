ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


local taxiMeter = {}

-- HELPER FUNCTIONS
function round(num, numDecimalPlaces)
  local mult = 5^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function splitString(str, sep)
  if sep == nil then sep = "%s" end

  local t={}
  local i=1

  for str in string.gmatch(str, "([^"..sep.."]+)") do
    t[i] = str
    i = i + 1
  end

  return t
end


RegisterServerEvent('vrp_taxi:setTaxi')
AddEventHandler('vrp_taxi:setTaxi', function(job,grade)
  local xPlayer = ESX.GetPlayerFromId(source)
  xPlayer.setJob(job,grade)
end)

--if testMode then
  AddEventHandler('chatMessage', function(source, n, message)
    local args = stringsplit(message, " ")
    if (args[1] == "/spawn") then
      CancelEvent()
      if (args[2] ~= nil) then
        local playerID = tonumber(source)
        local vehicleName = tostring(args[2])
        TriggerClientEvent('VehicleSpawn', playerID, vehicleName)
      else
        local event = 'chatMessage'
        local eventTarget = source
        local messageSender = "SYSTEM"
        local messageSenderColor = {200, 0, 0}
        local message = "Usage: /spawn <Vehicle_Name>  (for example /spawn polmav)"
        TriggerClientEvent(event, eventTarget, messageSender, messageSenderColor, message)
      end
    end
  end)
--end
AddEventHandler('chatMessage', function(from,name,message)
  if(string.sub(message,1,1) == "/") then

    local args = splitString(message)
    local cmd = args[1]

    if(cmd == "/taxioplata")then
      CancelEvent()

      local subCmd = string.lower(tostring(args[2]))
      if(subCmd == nil)then
        TriggerClientEvent('chatMessage', from, "TaxoMetrr -- Opcje", {218,176,15} , "Usage: /taxioplata pomoc")
        return
      end
      if subCmd == "pomoc" then
        TriggerClientEvent('chatMessage', from, "TaxoMetr -- Help", {218,176,15} , "Opcje: wejscie, km, min, pokaz. \nWejście - opłata za wejście do taxi (domyślnie: $20).\nkm - opłata za kilometr jazdy (domyślnie: $5). \nmin - opłata za minutę jazdy (domyślnie: $100). \npokaz - Pokaż obecne ustawienia")
        return
      end
      if subCmd == "pokaz" then
        TriggerClientEvent("vRP_taxi:user_settings", from, subCmd, nil)
        return
      end
      if args[3] ~= nil then
--	print(args[3])
	value = tonumber(string.format('%.2f', tonumber(args[3])))
	--tonumber(args[3])
        --value = parseDouble(args[3])
	--print(value)
        if subCmd == "wejscie" then
          TriggerClientEvent("vRP_taxi:user_settings", from, subCmd, value)
          return
        end
        if subCmd == "km" then
          TriggerClientEvent("vRP_taxi:user_settings", from, subCmd, value)
          return
        end
        if subCmd == "min" then
          TriggerClientEvent("vRP_taxi:user_settings", from, subCmd, value)
          return
        end
      else
        TriggerClientEvent('chatMessage', from, "TaxoMetr -- Ustawienia", {218,176,15} , "Użycie: /taxioplata pomoc")
        return
      end
    elseif cmd == "/taxihire" then
      TriggerClientEvent('taxi:toggleHire',from)
    elseif cmd == "/taxireset" then
      TriggerClientEvent('taxi:resetMeter',from)
    elseif cmd == "/taxishow" then
      TriggerClientEvent('taxi:toggleDisplay',from)
    end
  end
end)

function stringsplit(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t={}
  i=1
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    t[i] = str i = i + 1
  end
  return t
end
