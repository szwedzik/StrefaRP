--[[
Name: srp_logs
Author: Ezi - Ezi#0001
Version: v0.01.3612
Date: 22/06/2019 - 13:32
]]--

ESX = nil
local car_name_c = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
----------- Funkcja odpowiadajaca za embed wysylany przy uzywaniu komend przez admina.
function adminLog (admin, cmd, discordid, identifier, licenserc, ip)
    local DiscordWebHook = "https://discordapp.com/api/webhooks/588254150953926666/lrA8bsJXz4uJNR3S-Em2G8sknmQgnRrY7m9WeMIr9SmwCE-k-OSbnzKNtTNy7l3qEtzZ"
	local embeds = {
		{
            ["title"] = message,
			["description"] = admin..  " użył komendy ``" ..cmd.."``",
			["type"]="rich",
            ["color"] = 8663865,
            ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S'),
            ["thumbnail"]= {
                ["url"]= "https://i.imgur.com/gSBwBUe.png"
              },
            ["fields"] = {
                {
                    ["name"] = "Nick Discord",
                    ["value"] = "<@" ..discordid.. ">",
                    ["inline"] = true,
                },
                {
                    ["name"] = "SteamID",
                    ["value"] = identifier,
                    ["inline"] = true,
                },
                {
                    ["name"] = "Licencja Rockstar",
                    ["value"] = licenserc,
                    ["inline"] = true,
                },
                {
                    ["name"] = "Adres IP",
                    ["value"] = ip,
                    ["inline"] = true,
                },
            },
			["footer"]=  {
                ["icon_url"] = "https://cdn.discordapp.com/app-icons/554051836114501663/0f4587ca96cc7cd4047ed8f915dae303.png",
				["text"]= "Wiadomość została wygenerowana automatycznie",
		   },
        }
    }
    if admin == nil or admin == '' then 
		return FALSE 
    end
    if cmd == nil or cmd == '' then 
		return FALSE 
    end
    if discordid == nil or discordid == '' then 
		return FALSE 
    end
    if identifier == nil or identifier == '' then 
		return FALSE 
    end
    if licenserc == nil or licenserc == '' then 
		return FALSE 
	end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end
----------- Funkcja odpowiadajaca za embed wysylany przy laczeniu sie gracza z serwerem.
function connectLog (steamname, discordid, identifier, licenserc, ip, serverID)
  local DiscordWebHook = "https://discordapp.com/api/webhooks/588346478968176660/FHW1L0nYRTkAxD05x11A3kvBBYg0wvtKxPkPJJi-4j-waZpj1B5pfmuXOKmsTON6UjNJ"
local embeds = {
  {
          ["title"] = message,
    ["description"] = steamname..  " połączył się z serwerem",
    ["type"]="rich",
          ["color"] = 4777493,
          ["timestamp"] = os.date('%Y-%m-%d %H:%M:%S'),
          ["thumbnail"]= {
              ["url"]= "https://i.imgur.com/gSBwBUe.png"
            },
          ["fields"] = {
              {
                  ["name"] = "Nick Discord",
                  ["value"] = "<@" ..discordid.. ">",
                  ["inline"] = true,
              },
              {
                ["name"] = "ID na serwerze",
                ["value"] = serverID,
                ["inline"] = true,
            },
              {
                  ["name"] = "SteamID",
                  ["value"] = identifier,
                  ["inline"] = true,
              },
              {
                  ["name"] = "Licencja Rockstar",
                  ["value"] = licenserc,
                  ["inline"] = true,
              },
              {
                  ["name"] = "Adres IP",
                  ["value"] = ip,
                  ["inline"] = true,
              },{
                  ["name"] = "Adres IP",
                  ["value"] = ip,
                  ["inline"] = true,
              },
          },
    ["footer"]=  {
              ["icon_url"] = "https://cdn.discordapp.com/app-icons/554051836114501663/0f4587ca96cc7cd4047ed8f915dae303.png",
      ["text"]= "Wiadomość została wygenerowana automatycznie",
     },
      }
  }
  if steamname == nil or steamname == '' then 
  return FALSE 
  end
  if discordid == nil or discordid == '' then 
  return FALSE 
  end
  if identifier == nil or identifier == '' then 
  return FALSE 
  end
  if licenserc == nil or licenserc == '' then 
  return FALSE 
end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end
----------- Funkcja odpowiadajaca za embed wysylany przy rozlaczeniu sie gracza z serwerem.
function disconnectLog (steamname, discordid, identifier, licenserc, ip, reason, serverID)
  local DiscordWebHook = "https://discordapp.com/api/webhooks/588346478968176660/FHW1L0nYRTkAxD05x11A3kvBBYg0wvtKxPkPJJi-4j-waZpj1B5pfmuXOKmsTON6UjNJ"
local embeds = {
  {
          ["title"] = message,
    ["description"] = steamname..  " rozłączył się z serwerem",
    ["type"]="rich",
          ["color"] = 13632027,
          ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S'),
          ["thumbnail"]= {
              ["url"]= "https://i.imgur.com/gSBwBUe.png"
            },
          ["fields"] = {
              {
                  ["name"] = "Nick Discord",
                  ["value"] = "<@" ..discordid.. ">",
                  ["inline"] = true,
              },
              {
                ["name"] = "ID na serwerze",
                ["value"] = serverID,
                ["inline"] = true,
              },
              {
                  ["name"] = "SteamID",
                  ["value"] = identifier,
                  ["inline"] = true,
              },
              {
                  ["name"] = "Licencja Rockstar",
                  ["value"] = licenserc,
                  ["inline"] = true,
              },
              {
                  ["name"] = "Adres IP",
                  ["value"] = ip,
                  ["inline"] = true,
              },
              {
                ["name"] = "Powód",
                ["value"] = "**"..reason.."**",
                ["inline"] = true,
            },
          },
    ["footer"]=  {
              ["icon_url"] = "https://cdn.discordapp.com/app-icons/554051836114501663/0f4587ca96cc7cd4047ed8f915dae303.png",
      ["text"]= "Wiadomość została wygenerowana automatycznie",
     },
      }
  }
  if steamname == nil or steamname == '' then 
  return FALSE 
  end
  if discordid == nil or discordid == '' then 
  return FALSE 
  end
  if identifier == nil or identifier == '' then 
  return FALSE 
  end
  if licenserc == nil or licenserc == '' then 
  return FALSE 
end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end
--------------
function adminTargetLog (admin, cmd, target, discordid, identifier, licenserc, ip, targetdiscordid, targetidentifier, targetlicenserc, targetip)
  local DiscordWebHook = "https://discordapp.com/api/webhooks/588254150953926666/lrA8bsJXz4uJNR3S-Em2G8sknmQgnRrY7m9WeMIr9SmwCE-k-OSbnzKNtTNy7l3qEtzZ"
  local embeds = {
        {
          ["title"] = message,
          ["description"] = admin..  " użył komendy ``" ..cmd.."`` \nNa Użytkowniku ``" ..target.."``",
          ["type"]="rich",
          ["color"] = 8663865,
          ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S'),
          ["thumbnail"]= {
              ["url"]= "https://i.imgur.com/gSBwBUe.png"
            },
          ["fields"] = {
            {
              ["name"] = " ឵឵",
              ["value"] = "Dane Administratora:",
              ["inline"] = false
            },
            {
              ["name"] = "Nick Discord",
              ["value"] = "<@" ..discordid.. ">",
              ["inline"] = true,
            },
            {
              ["name"] = "SteamID",
              ["value"] = identifier,
              ["inline"] = true,
            },
            {
              ["name"] = "Licencja Rockstar",
              ["value"] = licenserc,
              ["inline"] = true,
            },
            {
              ["name"] = "Adres IP",
              ["value"] = ip,
              ["inline"] = true,
            },
            {
              ["name"] = " ឵឵",
              ["value"] = "Dane Gracza:",
              ["inline"] = false
            },
            {
              ["name"] = "Nick Discord",
              ["value"] = "<@" ..targetdiscordid.. ">",
              ["inline"] = true,
            },
            {
              ["name"] = "SteamID",
              ["value"] = targetidentifier,
              ["inline"] = true,
            },
            {
              ["name"] = "Licencja Rockstar",
              ["value"] = targetlicenserc,
              ["inline"] = true,
            },
            {
              ["name"] = "Adres IP",
              ["value"] = targetip,
              ["inline"] = true,
            },
          },
          ["footer"]=  {
            ["icon_url"] = "https://cdn.discordapp.com/app-icons/554051836114501663/0f4587ca96cc7cd4047ed8f915dae303.png",
            ["text"]= "Wiadomość została wygenerowana automatycznie",
          },
        }
      }
  if admin == nil or admin == '' then 
    return FALSE 
  end
  if cmd == nil or cmd == '' then 
    return FALSE 
  end
  if target == nil or target == '' then 
    return FALSE 
  end
  if discordid == nil or discordid == '' then 
    return FALSE 
  end
  if identifier == nil or identifier == '' then 
    return FALSE 
  end
  if ip == nil or ip == '' then 
    return FALSE 
  end
  if targetdiscordid == nil or targetdiscordid == '' then 
    return FALSE 
  end
  if targetidentifier == nil or targetidentifier == '' then 
    return FALSE 
  end
  if targetlicenserc == nil or targetlicenserc == '' then 
    return FALSE 
  end
  if targetip == nil or targetip == '' then 
    return FALSE 
  end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end
----------- Logi donosnie nadania broni
function adminGiveWeaponLog (admin, weaponName, ammo, target, discordid, identifier, licenserc, ip, targetdiscordid, targetidentifier, targetlicenserc, targetip)
  local DiscordWebHook = "https://discordapp.com/api/webhooks/589411622049546256/yPiXJZRmJCrpZ4TZVTL65zM_CwWvQNkwZGngN02FKcYZhol50_xGX_5h0sJsOxknCMDX"
  local embeds = {
        {
          ["title"] = message,
          ["description"] = admin..  " nadał broń użytkownikowi ``" ..target.."`` \n Broń: ``" ..weaponName.. "`` \nAmmo: ``" ..ammo.. "`` szt",
          ["type"]="rich",
          ["color"] = 8663865,
          ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S'),
          ["thumbnail"]= {
              ["url"]= "https://i.imgur.com/gSBwBUe.png"
            },
          ["fields"] = {
            {
              ["name"] = " ឵឵",
              ["value"] = "Dane Administratora:",
              ["inline"] = false
            },
            {
              ["name"] = "Nick Discord",
              ["value"] = "<@" ..discordid.. ">",
              ["inline"] = true,
            },
            {
              ["name"] = "SteamID",
              ["value"] = identifier,
              ["inline"] = true,
            },
            {
              ["name"] = "Licencja Rockstar",
              ["value"] = licenserc,
              ["inline"] = true,
            },
            {
              ["name"] = "Adres IP",
              ["value"] = ip,
              ["inline"] = true,
            },
            {
              ["name"] = " ឵឵",
              ["value"] = "Dane Gracza:",
              ["inline"] = false
            },
            {
              ["name"] = "Nick Discord",
              ["value"] = "<@" ..targetdiscordid.. ">",
              ["inline"] = true,
            },
            {
              ["name"] = "SteamID",
              ["value"] = targetidentifier,
              ["inline"] = true,
            },
            {
              ["name"] = "Licencja Rockstar",
              ["value"] = targetlicenserc,
              ["inline"] = true,
            },
            {
              ["name"] = "Adres IP",
              ["value"] = targetip,
              ["inline"] = true,
            },
          },
          ["footer"]=  {
            ["icon_url"] = "https://cdn.discordapp.com/app-icons/554051836114501663/0f4587ca96cc7cd4047ed8f915dae303.png",
            ["text"]= "Wiadomość została wygenerowana automatycznie",
          },
        }
      }
  if admin == nil or admin == '' then 
    return FALSE 
  end
  if weaponName == nil or weaponName == '' then 
    return FALSE 
  end
  if ammo == nil or ammo == '' then 
    return FALSE 
  end
  if target == nil or target == '' then 
    return FALSE 
  end
  if discordid == nil or discordid == '' then 
    return FALSE 
  end
  if identifier == nil or identifier == '' then 
    return FALSE 
  end
  if ip == nil or ip == '' then 
    return FALSE 
  end
  if targetdiscordid == nil or targetdiscordid == '' then 
    return FALSE 
  end
  if targetidentifier == nil or targetidentifier == '' then 
    return FALSE 
  end
  if targetlicenserc == nil or targetlicenserc == '' then 
    return FALSE 
  end
  if targetip == nil or targetip == '' then 
    return FALSE 
  end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end
--------- Logi nadania przedmiotu
function adminGiveItemLog (admin, item, count, target, discordid, identifier, licenserc, ip, targetdiscordid, targetidentifier, targetlicenserc, targetip)
  local DiscordWebHook = "https://discordapp.com/api/webhooks/589416583194083335/N7HYU-NlPagNL9umHQj3Vw9uZBZzlLIABe_9v2qz6FrLG5FS85HYgA6Hurikj_Vzl8C8"
  local embeds = {
        {
          ["title"] = message,
          ["description"] = admin..  " nadał przedmiot użytkownikowi ``" ..target.."``\nPrzedmiot: ``" ..item.. "`` \nIlość: ``" ..count.. "`` szt",
          ["type"]="rich",
          ["color"] = 8663865,
          ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S'),
          ["thumbnail"]= {
              ["url"]= "https://i.imgur.com/gSBwBUe.png"
            },
          ["fields"] = {
            {
              ["name"] = " ឵឵",
              ["value"] = "Dane Administratora:",
              ["inline"] = false
            },
            {
              ["name"] = "Nick Discord",
              ["value"] = "<@" ..discordid.. ">",
              ["inline"] = true,
            },
            {
              ["name"] = "SteamID",
              ["value"] = identifier,
              ["inline"] = true,
            },
            {
              ["name"] = "Licencja Rockstar",
              ["value"] = licenserc,
              ["inline"] = true,
            },
            {
              ["name"] = "Adres IP",
              ["value"] = ip,
              ["inline"] = true,
            },
            {
              ["name"] = " ឵឵",
              ["value"] = "Dane Gracza:",
              ["inline"] = false
            },
            {
              ["name"] = "Nick Discord",
              ["value"] = "<@" ..targetdiscordid.. ">",
              ["inline"] = true,
            },
            {
              ["name"] = "SteamID",
              ["value"] = targetidentifier,
              ["inline"] = true,
            },
            {
              ["name"] = "Licencja Rockstar",
              ["value"] = targetlicenserc,
              ["inline"] = true,
            },
            {
              ["name"] = "Adres IP",
              ["value"] = targetip,
              ["inline"] = true,
            },
          },
          ["footer"]=  {
            ["icon_url"] = "https://cdn.discordapp.com/app-icons/554051836114501663/0f4587ca96cc7cd4047ed8f915dae303.png",
            ["text"]= "Wiadomość została wygenerowana automatycznie",
          },
        }
      }
  if admin == nil or admin == '' then 
    return FALSE 
  end
  if item == nil or item == '' then 
    return FALSE 
  end
  if count == nil or count == '' then 
    return FALSE 
  end
  if target == nil or target == '' then 
    return FALSE 
  end
  if discordid == nil or discordid == '' then 
    return FALSE 
  end
  if identifier == nil or identifier == '' then 
    return FALSE 
  end
  if ip == nil or ip == '' then 
    return FALSE 
  end
  if targetdiscordid == nil or targetdiscordid == '' then 
    return FALSE 
  end
  if targetidentifier == nil or targetidentifier == '' then 
    return FALSE 
  end
  if targetlicenserc == nil or targetlicenserc == '' then 
    return FALSE 
  end
  if targetip == nil or targetip == '' then 
    return FALSE 
  end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end
--------------- Logi nadawania pracy
function adminSetJobLog (admin, jobName, grade, target, discordid, identifier, licenserc, ip, targetdiscordid, targetidentifier, targetlicenserc, targetip)
  local DiscordWebHook = "https://discordapp.com/api/webhooks/589418898688835595/LoQyxcFdKFEaxXL2-B1_udLoBPZjAVi9emb58i-TmnVRV1FamaUDySqty5ZDoj3WISh9"
  local embeds = {
        {
          ["title"] = message,
          ["description"] = admin..  " nadał użytkownikowi ``" ..target.."`` \n Praca: ``" ..jobName.. "`` \nStopień: ``" ..grade.. "``",
          ["type"]="rich",
          ["color"] = 8663865,
          ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S'),
          ["thumbnail"]= {
              ["url"]= "https://i.imgur.com/gSBwBUe.png"
            },
          ["fields"] = {
            {
              ["name"] = " ឵឵",
              ["value"] = "Dane Administratora:",
              ["inline"] = false
            },
            {
              ["name"] = "Nick Discord",
              ["value"] = "<@" ..discordid.. ">",
              ["inline"] = true,
            },
            {
              ["name"] = "SteamID",
              ["value"] = identifier,
              ["inline"] = true,
            },
            {
              ["name"] = "Licencja Rockstar",
              ["value"] = licenserc,
              ["inline"] = true,
            },
            {
              ["name"] = "Adres IP",
              ["value"] = ip,
              ["inline"] = true,
            },
            {
              ["name"] = " ឵឵",
              ["value"] = "Dane Gracza:",
              ["inline"] = false
            },
            {
              ["name"] = "Nick Discord",
              ["value"] = "<@" ..targetdiscordid.. ">",
              ["inline"] = true,
            },
            {
              ["name"] = "SteamID",
              ["value"] = targetidentifier,
              ["inline"] = true,
            },
            {
              ["name"] = "Licencja Rockstar",
              ["value"] = targetlicenserc,
              ["inline"] = true,
            },
            {
              ["name"] = "Adres IP",
              ["value"] = targetip,
              ["inline"] = true,
            },
          },
          ["footer"]=  {
            ["icon_url"] = "https://cdn.discordapp.com/app-icons/554051836114501663/0f4587ca96cc7cd4047ed8f915dae303.png",
            ["text"]= "Wiadomość została wygenerowana automatycznie",
          },
        }
      }
  if admin == nil or admin == '' then 
    return FALSE 
  end
  if jobName == nil or jobName == '' then 
    return FALSE 
  end
  if grade == nil or grade == '' then 
    return FALSE 
  end
  if target == nil or target == '' then 
    return FALSE 
  end
  if discordid == nil or discordid == '' then 
    return FALSE 
  end
  if identifier == nil or identifier == '' then 
    return FALSE 
  end
  if ip == nil or ip == '' then 
    return FALSE 
  end
  if targetdiscordid == nil or targetdiscordid == '' then 
    return FALSE 
  end
  if targetidentifier == nil or targetidentifier == '' then 
    return FALSE 
  end
  if targetlicenserc == nil or targetlicenserc == '' then 
    return FALSE 
  end
  if targetip == nil or targetip == '' then 
    return FALSE 
  end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end
----------- Logi donosnie crashy
function adminCrashLog (admin, cmd, target, discordid, identifier, licenserc, ip, targetdiscordid, targetidentifier, targetlicenserc, targetip)
  local DiscordWebHook = "https://discordapp.com/api/webhooks/589057250656780288/ZOV5fTDvGa7rD31oIOJVlxC8dLA7mm4zOtn1qgOSIKrydVb3mF1fODweNj1fwsmnRh2H"
  local embeds = {
        {
          ["title"] = message,
          ["description"] = admin..  " użył komendy ``" ..cmd.."`` \n Użytkownik **" ..target.."** dostał crasha!",
          ["type"]="rich",
          ["color"] = 13632027,
          ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S'),
          ["thumbnail"]= {
              ["url"]= "https://i.imgur.com/gSBwBUe.png"
            },
          ["fields"] = {
            {
              ["name"] = " ឵឵",
              ["value"] = "Dane Administratora:",
              ["inline"] = false
            },
            {
              ["name"] = "Nick Discord",
              ["value"] = "<@" ..discordid.. ">",
              ["inline"] = true,
            },
            {
              ["name"] = "SteamID",
              ["value"] = identifier,
              ["inline"] = true,
            },
            {
              ["name"] = "Licencja Rockstar",
              ["value"] = licenserc,
              ["inline"] = true,
            },
            {
              ["name"] = "Adres IP",
              ["value"] = ip,
              ["inline"] = true,
            },
            {
              ["name"] = " ឵឵",
              ["value"] = "Dane Gracza:",
              ["inline"] = false
            },
            {
              ["name"] = "Nick Discord",
              ["value"] = "<@" ..targetdiscordid.. ">",
              ["inline"] = true,
            },
            {
              ["name"] = "SteamID",
              ["value"] = targetidentifier,
              ["inline"] = true,
            },
            {
              ["name"] = "Licencja Rockstar",
              ["value"] = targetlicenserc,
              ["inline"] = true,
            },
            {
              ["name"] = "Adres IP",
              ["value"] = targetip,
              ["inline"] = true,
            },
          },
          ["footer"]=  {
            ["icon_url"] = "https://cdn.discordapp.com/app-icons/554051836114501663/0f4587ca96cc7cd4047ed8f915dae303.png",
            ["text"]= "Wiadomość została wygenerowana automatycznie",
          },
        }
      }
  if admin == nil or admin == '' then 
    return FALSE 
  end
  if cmd == nil or cmd == '' then 
    return FALSE 
  end
  if target == nil or target == '' then 
    return FALSE 
  end
  if discordid == nil or discordid == '' then 
    return FALSE 
  end
  if identifier == nil or identifier == '' then 
    return FALSE 
  end
  if ip == nil or ip == '' then 
    return FALSE 
  end
  if targetdiscordid == nil or targetdiscordid == '' then 
    return FALSE 
  end
  if targetidentifier == nil or targetidentifier == '' then 
    return FALSE 
  end
  if targetlicenserc == nil or targetlicenserc == '' then 
    return FALSE 
  end
  if targetip == nil or targetip == '' then 
    return FALSE 
  end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end
----------- Logi odpowiedzialne za kicki
function adminKickLog (target, admin, reason, discordid, identifier, licenserc, ip, targetdiscordid, targetidentifier, targetlicenserc, targetip)
  local DiscordWebHook = "https://discordapp.com/api/webhooks/589096902012960768/eDzrlhxTAKuDet6HYM0Sc0kWpzFZnFIJ6xCo3H-3k6QlsgIhRZX_wCnh642XhSDhtAjc"
  local embeds = {
        {
          ["title"] = message,
          ["description"] = "Użytwonik **"..target.."** został wyrzucony z serwera \n Powód kicka: ``"..reason.."``",
          ["type"]="rich",
          ["color"] = 8663865,
          ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S'),
          ["thumbnail"]= {
              ["url"]= "https://i.imgur.com/gSBwBUe.png"
            },
          ["fields"] = {
            {
              ["name"] = " ឵឵",
              ["value"] = "Dane Administratora:",
              ["inline"] = false
            },
            {
              ["name"] = "Nick Discord",
              ["value"] = "<@" ..discordid.. ">",
              ["inline"] = true,
            },
            {
              ["name"] = "SteamID",
              ["value"] = identifier,
              ["inline"] = true,
            },
            {
              ["name"] = "Licencja Rockstar",
              ["value"] = licenserc,
              ["inline"] = true,
            },
            {
              ["name"] = "Adres IP",
              ["value"] = ip,
              ["inline"] = true,
            },
            {
              ["name"] = " ឵឵",
              ["value"] = "Dane Gracza:",
              ["inline"] = false
            },
            {
              ["name"] = "Nick Discord",
              ["value"] = "<@" ..targetdiscordid.. ">",
              ["inline"] = true,
            },
            {
              ["name"] = "SteamID",
              ["value"] = targetidentifier,
              ["inline"] = true,
            },
            {
              ["name"] = "Licencja Rockstar",
              ["value"] = targetlicenserc,
              ["inline"] = true,
            },
            {
              ["name"] = "Adres IP",
              ["value"] = targetip,
              ["inline"] = true,
            },
          },
          ["footer"]=  {
            ["icon_url"] = "https://cdn.discordapp.com/app-icons/554051836114501663/0f4587ca96cc7cd4047ed8f915dae303.png",
            ["text"]= "Wiadomość została wygenerowana automatycznie",
          },
        }
      }
  if target == nil or target == '' then 
    return FALSE 
  end
  if admin == nil or admin == '' then 
    return FALSE 
  end
  if reason == nil or reason == '' then 
    return FALSE 
  end
  if discordid == nil or discordid == '' then 
    return FALSE 
  end
  if identifier == nil or identifier == '' then 
    return FALSE 
  end
  if licenserc == nil or licenserc == '' then 
    return FALSE 
  end
  if ip == nil or ip == '' then 
    return FALSE 
  end
  if targetdiscordid == nil or targetdiscordid == '' then 
    return FALSE 
  end
  if targetidentifier == nil or targetidentifier == '' then 
    return FALSE 
  end
  if targetlicenserc == nil or targetlicenserc == '' then 
    return FALSE 
  end
  if targetip == nil or targetip == '' then 
    return FALSE 
  end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end
------------------ Logi tp do koordynatow
function adminTpLog (admin, x, y, z, discordid, identifier, licenserc, ip)
  local DiscordWebHook = "https://discordapp.com/api/webhooks/589501621453586433/nLpfGlXnJf8bkbKdcpXEA6onlnfL7wrDFlLavRDY7J_mBbdJJtuXN82B8kcFCQxbIs1s"
  local embeds = {
        {
          ["title"] = message,
          ["description"] = "Użytowknik **"..admin.."** został przetelportowany na koordynaty \nX:``"..x.."`` Y:``"..y.."`` Z:``"..z.."``",
          ["type"]="rich",
          ["color"] = 8663865,
          ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S'),
          ["thumbnail"]= {
              ["url"]= "https://i.imgur.com/gSBwBUe.png"
            },
          ["fields"] = {
            {
              ["name"] = " ឵឵",
              ["value"] = "Dane Administratora:",
              ["inline"] = false
            },
            {
              ["name"] = "Nick Discord",
              ["value"] = "<@" ..discordid.. ">",
              ["inline"] = true,
            },
            {
              ["name"] = "SteamID",
              ["value"] = identifier,
              ["inline"] = true,
            },
            {
              ["name"] = "Licencja Rockstar",
              ["value"] = licenserc,
              ["inline"] = true,
            },
            {
              ["name"] = "Adres IP",
              ["value"] = ip,
              ["inline"] = true,
            },
          },
          ["footer"]=  {
            ["icon_url"] = "https://cdn.discordapp.com/app-icons/554051836114501663/0f4587ca96cc7cd4047ed8f915dae303.png",
            ["text"]= "Wiadomość została wygenerowana automatycznie",
          },
        }
      }
  if admin == nil or admin == '' then 
    return FALSE 
  end
  if x == nil or x == '' then 
    return FALSE 
  end
  if y == nil or y == '' then 
    return FALSE 
  end
  if z == nil or z == '' then 
    return FALSE 
  end
  if discordid == nil or discordid == '' then 
    return FALSE 
  end
  if identifier == nil or identifier == '' then 
    return FALSE 
  end
  if licenserc == nil or licenserc == '' then 
    return FALSE 
  end
  if ip == nil or ip == '' then 
    return FALSE 
  end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end
---------- Logi Banow
function adminBanLog (target, admin, reason, discordid, identifier, licenserc, ip, targetdiscordid, targetidentifier, targetlicenserc, targetip)
  local DiscordWebHook = "https://discordapp.com/api/webhooks/592310476499845130/1adyq0IyqhMMXA3YdrtLB9UrIK7iuo70VJ8oTHHMmosmHijOk9v0Blb32Q7npC8clohe"
  local embeds = {
        {
          ["title"] = message,
          ["description"] = "Użytwonik **"..target.."** został pernametnie zbanowany na serwerze \n Powód: ``"..reason.."``",
          ["type"]="rich",
          ["color"] = 8663865,
          ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S'),
          ["thumbnail"]= {
              ["url"]= "https://i.imgur.com/gSBwBUe.png"
            },
          ["fields"] = {
            {
              ["name"] = " ឵឵",
              ["value"] = "Dane Administratora:",
              ["inline"] = false
            },
            {
              ["name"] = "Nick Discord",
              ["value"] = "<@" ..discordid.. ">",
              ["inline"] = true,
            },
            {
              ["name"] = "SteamID",
              ["value"] = identifier,
              ["inline"] = true,
            },
            {
              ["name"] = "Licencja Rockstar",
              ["value"] = licenserc,
              ["inline"] = true,
            },
            {
              ["name"] = "Adres IP",
              ["value"] = ip,
              ["inline"] = true,
            },
            {
              ["name"] = " ឵឵",
              ["value"] = "Dane Gracza:",
              ["inline"] = false
            },
            {
              ["name"] = "Nick Discord",
              ["value"] = "<@" ..targetdiscordid.. ">",
              ["inline"] = true,
            },
            {
              ["name"] = "SteamID",
              ["value"] = targetidentifier,
              ["inline"] = true,
            },
            {
              ["name"] = "Licencja Rockstar",
              ["value"] = targetlicenserc,
              ["inline"] = true,
            },
            {
              ["name"] = "Adres IP",
              ["value"] = targetip,
              ["inline"] = true,
            },
          },
          ["footer"]=  {
            ["icon_url"] = "https://cdn.discordapp.com/app-icons/554051836114501663/0f4587ca96cc7cd4047ed8f915dae303.png",
            ["text"]= "Wiadomość została wygenerowana automatycznie",
          },
        }
      }
  if target == nil or target == '' then 
    return FALSE 
  end
  if admin == nil or admin == '' then 
    return FALSE 
  end
  if reason == nil or reason == '' then 
    return FALSE 
  end
  if discordid == nil or discordid == '' then 
    return FALSE 
  end
  if identifier == nil or identifier == '' then 
    return FALSE 
  end
  if licenserc == nil or licenserc == '' then 
    return FALSE 
  end
  if ip == nil or ip == '' then 
    return FALSE 
  end
  if targetdiscordid == nil or targetdiscordid == '' then 
    return FALSE 
  end
  if targetidentifier == nil or targetidentifier == '' then 
    return FALSE 
  end
  if targetlicenserc == nil or targetlicenserc == '' then 
    return FALSE 
  end
  if targetip == nil or targetip == '' then 
    return FALSE 
  end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function adminAutoBanLog (target, discordid, identifier, licenserc, ip)
  local DiscordWebHook = "https://discordapp.com/api/webhooks/593049221150539815/eMKtc3TLyKSUFI5uYR5v1hamUt7LIleMshT4zQj6oMRaHoDYuvou0fE7cVYs_xEZZKIb"
  local embeds = {
        {
          ["title"] = message,
          ["description"] = "Użytwonik **"..target.."** został pernametnie zbanowany na serwerze \n Powód: ``Cheating``",
          ["type"]="rich",
          ["color"] = 8663865,
          ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S'),
          ["thumbnail"]= {
              ["url"]= "https://i.imgur.com/gSBwBUe.png"
            },
          ["fields"] = {
            {
              ["name"] = " ឵឵",
              ["value"] = "Dane Administratora:",
              ["inline"] = false
            },
            {
              ["name"] = "Nick Discord",
              ["value"] = "**AntiCheat**",
              ["inline"] = true,
            },
            {
              ["name"] = " ឵឵",
              ["value"] = "Dane Gracza:",
              ["inline"] = false
            },
            {
              ["name"] = "Nick Discord",
              ["value"] = "<@" ..discordid.. ">",
              ["inline"] = true,
            },
            {
              ["name"] = "SteamID",
              ["value"] = identifier,
              ["inline"] = true,
            },
            {
              ["name"] = "Licencja Rockstar",
              ["value"] = licenserc,
              ["inline"] = true,
            },
            {
              ["name"] = "Adres IP",
              ["value"] = ip,
              ["inline"] = true,
            },
          },
          ["footer"]=  {
            ["icon_url"] = "https://cdn.discordapp.com/app-icons/554051836114501663/0f4587ca96cc7cd4047ed8f915dae303.png",
            ["text"]= "Wiadomość została wygenerowana automatycznie",
          },
        }
      }
  if target == nil or target == '' then 
    return FALSE 
  end
  if discordid == nil or discordid == '' then 
    return FALSE 
  end
  if identifier == nil or identifier == '' then 
    return FALSE 
  end
  if licenserc == nil or licenserc == '' then 
    return FALSE 
  end
  if ip == nil or ip == '' then 
    return FALSE 
  end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name, embeds = embeds, content = "<@217566090073473026>"}), { ['Content-Type'] = 'application/json' })
end

function adminTempBanLog (target, admin, reason, time, discordid, identifier, licenserc, ip, targetdiscordid, targetidentifier, targetlicenserc, targetip)
  local DiscordWebHook = "https://discordapp.com/api/webhooks/592310476499845130/1adyq0IyqhMMXA3YdrtLB9UrIK7iuo70VJ8oTHHMmosmHijOk9v0Blb32Q7npC8clohe"
  local embeds = {
        {
          ["title"] = message,
          ["description"] = "Użytwonik **"..target.."** został tymczasowo zbanowany na serwerze \nDługość bana: ``"..time.."`` godzin. \nPowód: ``"..reason.."``",
          ["type"]="rich",
          ["color"] = 8663865,
          ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S'),
          ["thumbnail"]= {
              ["url"]= "https://i.imgur.com/gSBwBUe.png"
            },
          ["fields"] = {
            {
              ["name"] = " ឵឵",
              ["value"] = "Dane Administratora:",
              ["inline"] = false
            },
            {
              ["name"] = "Nick Discord",
              ["value"] = "<@" ..discordid.. ">",
              ["inline"] = true,
            },
            {
              ["name"] = "SteamID",
              ["value"] = identifier,
              ["inline"] = true,
            },
            {
              ["name"] = "Licencja Rockstar",
              ["value"] = licenserc,
              ["inline"] = true,
            },
            {
              ["name"] = "Adres IP",
              ["value"] = ip,
              ["inline"] = true,
            },
            {
              ["name"] = " ឵឵",
              ["value"] = "Dane Gracza:",
              ["inline"] = false
            },
            {
              ["name"] = "Nick Discord",
              ["value"] = "<@" ..targetdiscordid.. ">",
              ["inline"] = true,
            },
            {
              ["name"] = "SteamID",
              ["value"] = targetidentifier,
              ["inline"] = true,
            },
            {
              ["name"] = "Licencja Rockstar",
              ["value"] = targetlicenserc,
              ["inline"] = true,
            },
            {
              ["name"] = "Adres IP",
              ["value"] = targetip,
              ["inline"] = true,
            },
          },
          ["footer"]=  {
            ["icon_url"] = "https://cdn.discordapp.com/app-icons/554051836114501663/0f4587ca96cc7cd4047ed8f915dae303.png",
            ["text"]= "Wiadomość została wygenerowana automatycznie",
          },
        }
      }
  if target == nil or target == '' then 
    return FALSE 
  end
  if admin == nil or admin == '' then 
    return FALSE 
  end
  if reason == nil or reason == '' then 
    return FALSE 
  end
  if time == nil or time == '' then 
    return FALSE 
  end
  if discordid == nil or discordid == '' then 
    return FALSE 
  end
  if identifier == nil or identifier == '' then 
    return FALSE 
  end
  if licenserc == nil or licenserc == '' then 
    return FALSE 
  end
  if ip == nil or ip == '' then 
    return FALSE 
  end
  if targetdiscordid == nil or targetdiscordid == '' then 
    return FALSE 
  end
  if targetidentifier == nil or targetidentifier == '' then 
    return FALSE 
  end
  if targetlicenserc == nil or targetlicenserc == '' then 
    return FALSE 
  end
  if targetip == nil or targetip == '' then 
    return FALSE 
  end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function autoUnbanLog (target, targetdiscordid, targetidentifier, targetlicenserc, targetip)
  local DiscordWebHook = "https://discordapp.com/api/webhooks/592345924513169408/Yl5sh2t47Q55ZjbGIDqatVDtw9I0zIe-1NupBj2cgDTZloCPeplFsToJFLBijJO7qW6z"
  local embeds = {
        {
          ["title"] = message,
          ["description"] = "Użytwonik **"..target.."** został automatycznie odbanowany po upływie czasu bana.",
          ["type"]="rich",
          ["color"] = 8663865,
          ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S'),
          ["thumbnail"]= {
              ["url"]= "https://i.imgur.com/gSBwBUe.png"
            },
          ["fields"] = {
            {
              ["name"] = " ឵឵",
              ["value"] = "Dane Gracza:",
              ["inline"] = false
            },
            {
              ["name"] = "Nick Discord",
              ["value"] = "<@" ..targetdiscordid.. ">",
              ["inline"] = true,
            },
            {
              ["name"] = "SteamID",
              ["value"] = targetidentifier,
              ["inline"] = true,
            },
            {
              ["name"] = "Licencja Rockstar",
              ["value"] = targetlicenserc,
              ["inline"] = true,
            },
            {
              ["name"] = "Adres IP",
              ["value"] = targetip,
              ["inline"] = true,
            },
          },
          ["footer"]=  {
            ["icon_url"] = "https://cdn.discordapp.com/app-icons/554051836114501663/0f4587ca96cc7cd4047ed8f915dae303.png",
            ["text"]= "Wiadomość została wygenerowana automatycznie",
          },
        }
      }
  if target == nil or target == '' then 
    return FALSE 
  end
  if targetdiscordid == nil or targetdiscordid == '' then 
    return FALSE 
  end
  if targetidentifier == nil or targetidentifier == '' then 
    return FALSE 
  end
  if targetlicenserc == nil or targetlicenserc == '' then 
    return FALSE 
  end
  if targetip == nil or targetip == '' then 
    return FALSE 
  end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function autoBanLog (target, discordid, identifier, licenserc, ip)
  local DiscordWebHook = "https://discordapp.com/api/webhooks/593049221150539815/eMKtc3TLyKSUFI5uYR5v1hamUt7LIleMshT4zQj6oMRaHoDYuvou0fE7cVYs_xEZZKIb"
  local embeds = {
        {
          ["title"] = message,
          ["description"] = "Użytwonik **"..target.."** został automatycznie zbanowany za **Lynx Menu**",
          ["type"]="rich",
          ["color"] = 8663865,
          ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S'),
          ["thumbnail"]= {
              ["url"]= "https://i.imgur.com/gSBwBUe.png"
            },
          ["fields"] = {
            {
              ["name"] = " ឵឵",
              ["value"] = "Dane Gracza:",
              ["inline"] = false
            },
            {
              ["name"] = "Nick Discord",
              ["value"] = "<@" ..discordid.. ">",
              ["inline"] = true,
            },
            {
              ["name"] = "SteamID",
              ["value"] = identifier,
              ["inline"] = true,
            },
            {
              ["name"] = "Licencja Rockstar",
              ["value"] = licenserc,
              ["inline"] = true,
            },
            {
              ["name"] = "Adres IP",
              ["value"] = ip,
              ["inline"] = true,
            },
          },
          ["footer"]=  {
            ["icon_url"] = "https://cdn.discordapp.com/app-icons/554051836114501663/0f4587ca96cc7cd4047ed8f915dae303.png",
            ["text"]= "Wiadomość została wygenerowana automatycznie",
          },
        }
      }
  if target == nil or target == '' then 
    return FALSE 
  end
  if discordid == nil or discordid == '' then 
    return FALSE 
  end
  if identifier == nil or identifier == '' then 
    return FALSE 
  end
  if licenserc == nil or licenserc == '' then 
    return FALSE 
  end
  if ip == nil or ip == '' then 
    return FALSE 
  end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end
--chatLog(name,discordid_duo,identifier,licenserc,ip,log_text,text,type)
function chatLog (target, discordid, identifier, licenserc, ip,log_text,text,type,serverID)
  local DiscordWebHook = "https://discordapp.com/api/webhooks/600621173499363368/ZU__59q0ifX3Zdu16W_ffEhfmhdKOor2Fs4d46gXg9RK4BaYlBuQGBdSiR1UDqZlq7V9"
  local embeds = {
        {
          --["title"] = message,
          ["description"] = "Użytkownik **"..target.."** "..log_text,
          ["type"]="rich",
          ["color"] = 8663865,
          ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S'),
          ["thumbnail"]= {
              ["url"]= "https://i.imgur.com/gSBwBUe.png"
            },
          ["fields"] = {
            {
              ["name"] = "Rodzaj",
              ["value"] = type,
              ["inline"] = false
            },
            {
              ["name"] = "Wiadomość",
              ["value"] = text,
              ["inline"] = false
            },
            {
              ["name"] = " ឵឵",
              ["value"] = "Dane Gracza:",
              ["inline"] = false
            },
            {
              ["name"] = "ID na serwerze",
              ["value"] = serverID,
              ["inline"] = true,
            },
            {
              ["name"] = "Nick Discord",
              ["value"] = "<@" ..discordid.. ">",
              ["inline"] = true,
            },
            {
              ["name"] = "SteamID",
              ["value"] = identifier,
              ["inline"] = true,
            },
            {
              ["name"] = "Licencja Rockstar",
              ["value"] = licenserc,
              ["inline"] = true,
            },
            {
              ["name"] = "Adres IP",
              ["value"] = ip,
              ["inline"] = true,
            },
          },
          ["footer"]=  {
            ["icon_url"] = "https://cdn.discordapp.com/app-icons/554051836114501663/0f4587ca96cc7cd4047ed8f915dae303.png",
            ["text"]= "Wiadomość została wygenerowana automatycznie",
          },
        }
      }
  if target == nil or target == '' then 
    return FALSE 
  end
  if text == nil or text == '' then 
    return FALSE 
  end
  if discordid == nil or discordid == '' then 
    return FALSE 
  end
  if identifier == nil or identifier == '' then 
    return FALSE 
  end
  if licenserc == nil or licenserc == '' then 
    return FALSE 
  end
  if ip == nil or ip == '' then 
    return FALSE 
  end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

--dodane logi przez zrider100z

function cardealerLog (target, discordid, identifier, licenserc, ip, new_car, new_plate, sold_bought,serverID)
  local DiscordWebHook = "https://discordapp.com/api/webhooks/603675903276613662/GYPiK1-NFMFqXmUgV41rqVVVrzc7CPLQMgQOid-KdiaJ0w5IEq2FQoCdiEaofIaXWUMy"
  local embeds = {
    {
      ["title"] = message,
      ["description"] = "Użytkownik **"..target.."** "..sold_bought.." pojazd",
      ["type"]="rich",
      ["color"] = 8663865,
      ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S'),
      ["thumbnail"]= {
          ["url"]= "https://i.imgur.com/gSBwBUe.png"
        },
      ["fields"] = {
        {
          ["name"] = " ឵឵",
          ["value"] = "Dane Gracza:",
          ["inline"] = false
        },
        {
          ["name"] = "Nick Discord",
          ["value"] = "<@" ..discordid.. ">",
          ["inline"] = true,
        },
        {
          ["name"] = "ID na serwerze",
          ["value"] = serverID,
          ["inline"] = true,
        },
        {
          ["name"] = "SteamID",
          ["value"] = identifier,
          ["inline"] = true,
        },
        {
          ["name"] = "Licencja Rockstar",
          ["value"] = licenserc,
          ["inline"] = true,
        },
        {
          ["name"] = "Adres IP",
          ["value"] = ip,
          ["inline"] = true,
        },
        {
          ["name"] = "Pojazd".."("..sold_bought..")",
          ["value"] = new_car,
          ["inline"] = true,
        },
        {
          ["name"] = "Tablice",
          ["value"] = new_plate,
          ["inline"] = true,
        },
      },
      ["footer"]=  {
        ["icon_url"] = "https://cdn.discordapp.com/app-icons/554051836114501663/0f4587ca96cc7cd4047ed8f915dae303.png",
        ["text"]= "Wiadomość została wygenerowana automatycznie",
      },
    }
  }
  	
  if target == nil or target == '' then 
  return FALSE 
  end
  if discordid == nil or discordid == '' then 
  return FALSE 
  end
  if identifier == nil or identifier == '' then 
  return FALSE 
  end

  if licenserc == nil or licenserc == '' then 
  return FALSE 
  end
  if ip == nil or ip == '' then 
  return FALSE 
  end

  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function jobLog (target, discordid, identifier, licenserc, ip, new_job,serverID)
  local DiscordWebHook = "https://discordapp.com/api/webhooks/589418898688835595/LoQyxcFdKFEaxXL2-B1_udLoBPZjAVi9emb58i-TmnVRV1FamaUDySqty5ZDoj3WISh9"
  local embeds = {
    {
      ["title"] = message,
      ["description"] = "Użytkownik **"..target.."** zmienił prace",
      ["type"]="rich",
      ["color"] = 8663865,
      ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S'),
      ["thumbnail"]= {
          ["url"]= "https://i.imgur.com/gSBwBUe.png"
        },
      ["fields"] = {
        {
          ["name"] = " ឵឵",
          ["value"] = "Dane Gracza:",
          ["inline"] = false
        },
        {
          ["name"] = "Nick Discord",
          ["value"] = "<@" ..discordid.. ">",
          ["inline"] = true,
        },
        {
          ["name"] = "ID na serwerze",
          ["value"] = serverID,
          ["inline"] = true,
        },
        {
          ["name"] = "SteamID",
          ["value"] = identifier,
          ["inline"] = true,
        },
        {
          ["name"] = "Licencja Rockstar",
          ["value"] = licenserc,
          ["inline"] = true,
        },
        {
          ["name"] = "Adres IP",
          ["value"] = ip,
          ["inline"] = true,
        },
        {
          ["name"] = "Nowa praca",
          ["value"] = new_job,
          ["inline"] = true,
        }
      },
      ["footer"]=  {
        ["icon_url"] = "https://cdn.discordapp.com/app-icons/554051836114501663/0f4587ca96cc7cd4047ed8f915dae303.png",
        ["text"]= "Wiadomość została wygenerowana automatycznie",
      },
    }
  }
  if target == nil or target == '' then 
  return FALSE 
  end
  if discordid == nil or discordid == '' then 
  return FALSE 
  end
  if identifier == nil or identifier == '' then 
  return FALSE 
  end
  if licenserc == nil or licenserc == '' then 
  return FALSE 
  end
  if ip == nil or ip == '' then 
  return FALSE 
  end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end



function battleLog (target, discordid, identifier, licenserc, ip, deathCausedBy,killedby_target,killedby_discordid,killedby_identifier,killedby_licenserc,killedby_ip,serverID,killer_serverID)
  local DiscordWebHook = "https://discordapp.com/api/webhooks/604061856478527508/vV6gMH-dD0w9sEhj-Uy83OoTPF5ZMNgL1LRL8G1lDXzwJHothohgyZ-Zx2wCOQME6dNW"
  local embeds = {}
  if target~=killedby_target then
  embeds = {
    {
      ["title"] = message,
      ["description"] = "Użytkownik **"..target.."** został zabity",
      ["type"]="rich",
      ["color"] = 8663865,
      ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S'),
      ["thumbnail"]= {
          ["url"]= "https://i.imgur.com/gSBwBUe.png"
        },
      ["fields"] = {
        {
          ["name"] = " ឵឵",
          ["value"] = "Dane Gracza:",
          ["inline"] = false
        },
        {
          ["name"] = "ID na serwerze",
          ["value"] = serverID,
          ["inline"] = true,
        },
        {
          ["name"] = "Nick Discord",
          ["value"] = "<@" ..discordid.. ">",
          ["inline"] = true,
        },
        {
          ["name"] = "SteamID",
          ["value"] = identifier,
          ["inline"] = true,
        },
        {
          ["name"] = "Licencja Rockstar",
          ["value"] = licenserc,
          ["inline"] = true,
        },
        {
          ["name"] = "Adres IP",
          ["value"] = ip,
          ["inline"] = true,
        },
        {
          ["name"] = "Przyczyna śmierci",
          ["value"] = deathCausedBy,
          ["inline"] = true,
        },
        {
          ["name"] = " ឵឵",
          ["value"] = "Dane Zabójcy:",
          ["inline"] = false
        },
        {
          ["name"] = "ID na serwerze",
          ["value"] = killer_serverID,
          ["inline"] = true,
        },
        {
          ["name"] = "Nick Discord",
          ["value"] = "<@" ..killedby_discordid.. ">",
          ["inline"] = true,
        },
        {
          ["name"] = "SteamID",
          ["value"] = killedby_identifier,
          ["inline"] = true,
        },
        {
          ["name"] = "Licencja Rockstar",
          ["value"] = killedby_licenserc,
          ["inline"] = true,
        },
        {
          ["name"] = "Adres IP",
          ["value"] = killedby_ip,
          ["inline"] = true,
        }
      },
      ["footer"]=  {
        ["icon_url"] = "https://cdn.discordapp.com/app-icons/554051836114501663/0f4587ca96cc7cd4047ed8f915dae303.png",
        ["text"]= "Wiadomość została wygenerowana automatycznie",
      },
    }
  }
  else
  embeds = {
    {
      ["title"] = message,
      ["description"] = "Użytkownik **"..target.."** został zabity",
      ["type"]="rich",
      ["color"] = 8663865,
      ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S'),
      ["thumbnail"]= {
          ["url"]= "https://i.imgur.com/gSBwBUe.png"
        },
      ["fields"] = {
        {
          ["name"] = " ឵឵",
          ["value"] = "Dane Gracza:",
          ["inline"] = false
        },
        {
          ["name"] = "Nick Discord",
          ["value"] = "<@" ..discordid.. ">",
          ["inline"] = true,
        },
        {
          ["name"] = "SteamID",
          ["value"] = identifier,
          ["inline"] = true,
        },
        {
          ["name"] = "Licencja Rockstar",
          ["value"] = licenserc,
          ["inline"] = true,
        },
        {
          ["name"] = "Adres IP",
          ["value"] = ip,
          ["inline"] = true,
        },
        {
          ["name"] = "Przyczyna śmierci",
          ["value"] = deathCausedBy,
          ["inline"] = true,
        }
      },
      ["footer"]=  {
        ["icon_url"] = "https://cdn.discordapp.com/app-icons/554051836114501663/0f4587ca96cc7cd4047ed8f915dae303.png",
        ["text"]= "Wiadomość została wygenerowana automatycznie",
      },
    }
  }
  end
  if target == nil or target == '' then 
  return FALSE 
  end
  if discordid == nil or discordid == '' then 
  return FALSE 
  end
  if identifier == nil or identifier == '' then 
  return FALSE 
  end
  if licenserc == nil or licenserc == '' then 
  return FALSE 
  end
  if ip == nil or ip == '' then 
  return FALSE 
  end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end



function policeArmoryLog (target, discordid, identifier, licenserc, ip, org, weap_taken, prompt_string,serverID)
  local DiscordWebHook = nil 
  --wysyla na kanal LSPD, LSSD albo SASP w zaleznosci od tego kto pobral/oddal
  if org == 'police' then
    DiscordWebHook = "https://discordapp.com/api/webhooks/604759437931970560/HVUfzI_SBiuKx4AM1EnNpKhY2zbuFbPKd5iHqnYfJ6tSEowa_xT609GFn200vUgpfFHI"
  elseif org == 'statepolice' then
    DiscordWebHook = "https://discordapp.com/api/webhooks/604759681273167892/j3n3is4o0a-kVU5o6CwqnqKSl3wIr2Wu4PhOLoNJLS1bP9rNrjJJK4xr3bRZbW3vgxRU"
  else
    DiscordWebHook = "https://discordapp.com/api/webhooks/604759573479292998/nAe11FtbPs4Et-XUHkWnW6QPHerSQRGiizaQ5k-apB2aDuWFAQCBdj7zCSmVUVBzUEzs"
  end
   
  local embeds = {
    {
      ["title"] = message,
      ["description"] = "Użytkownik **"..target.."** "..prompt_string.." broń",
      ["type"]="rich",
      ["color"] = 8663865,
      ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S'),
      ["thumbnail"]= {
          ["url"]= "https://i.imgur.com/gSBwBUe.png"
        },
      ["fields"] = {
        {
          ["name"] = " ឵឵",
          ["value"] = "Dane gracza:",
          ["inline"] = false
        },
        {
          ["name"] = "ID na serwerze",
          ["value"] = serverID,
          ["inline"] = true,
        },
        {
          ["name"] = "Nick Discord",
          ["value"] = "<@" ..discordid.. ">",
          ["inline"] = true,
        },
        {
          ["name"] = "SteamID",
          ["value"] = identifier,
          ["inline"] = true,
        },
        {
          ["name"] = "Licencja Rockstar",
          ["value"] = licenserc,
          ["inline"] = true,
        },
        {
          ["name"] = "Adres IP",
          ["value"] = ip,
          ["inline"] = true,
        },{
          ["name"] = "Broń",
          ["value"] = weap_taken,
          ["inline"] = true,
        }
      },
      ["footer"]=  {
        ["icon_url"] = "https://cdn.discordapp.com/app-icons/554051836114501663/0f4587ca96cc7cd4047ed8f915dae303.png",
        ["text"]= "Wiadomość została wygenerowana automatycznie",
      },
    }
  }
  if target == nil or target == '' then 
  return FALSE 
  end
  if discordid == nil or discordid == '' then 
  return FALSE 
  end
  if identifier == nil or identifier == '' then 
  return FALSE 
  end
  if licenserc == nil or licenserc == '' then 
  return FALSE 
  end
  if ip == nil or ip == '' then 
  return FALSE 
  end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function policeGarageLog (target, discordid, identifier, licenserc, ip,org,car_taken,prompt_text,serverID)
  local DiscordWebHook = nil 
  --wysyla na kanal LSPD, LSSD albo SASP w zaleznosci od tego kto pobral/oddal
  if org == 'police' then
    DiscordWebHook = "https://discordapp.com/api/webhooks/604759437931970560/HVUfzI_SBiuKx4AM1EnNpKhY2zbuFbPKd5iHqnYfJ6tSEowa_xT609GFn200vUgpfFHI"
  elseif org == 'statepolice' then
    DiscordWebHook = "https://discordapp.com/api/webhooks/604759681273167892/j3n3is4o0a-kVU5o6CwqnqKSl3wIr2Wu4PhOLoNJLS1bP9rNrjJJK4xr3bRZbW3vgxRU"
  else
    DiscordWebHook = "https://discordapp.com/api/webhooks/604759573479292998/nAe11FtbPs4Et-XUHkWnW6QPHerSQRGiizaQ5k-apB2aDuWFAQCBdj7zCSmVUVBzUEzs"
  end
  local embeds = {
    {
      ["title"] = message,
      ["description"] = "Użytkownik **"..target.."** "..prompt_text.." pojazd",
      ["type"]="rich",
      ["color"] = 8663865,
      ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S'),
      ["thumbnail"]= {
          ["url"]= "https://i.imgur.com/gSBwBUe.png"
        },
      ["fields"] = {
        {
          ["name"] = " ឵឵",
          ["value"] = "Dane Gracza:",
          ["inline"] = false
        },
        {
          ["name"] = "ID na serwerze",
          ["value"] = serverID,
          ["inline"] = true,
        },
        {
          ["name"] = "Nick Discord",
          ["value"] = "<@" ..discordid.. ">",
          ["inline"] = true,
        },
        {
          ["name"] = "SteamID",
          ["value"] = identifier,
          ["inline"] = true,
        },
        {
          ["name"] = "Licencja Rockstar",
          ["value"] = licenserc,
          ["inline"] = true,
        },
        {
          ["name"] = "Adres IP",
          ["value"] = ip,
          ["inline"] = true,
        },
        {
          ["name"] = "Pojazd",
          ["value"] = car_taken,
          ["inline"] = true,
        }
      },
      ["footer"]=  {
        ["icon_url"] = "https://cdn.discordapp.com/app-icons/554051836114501663/0f4587ca96cc7cd4047ed8f915dae303.png",
        ["text"]= "Wiadomość została wygenerowana automatycznie",
      },
    }
  }
  	
  if target == nil or target == '' then 
  return FALSE 
  end
  if discordid == nil or discordid == '' then 
  return FALSE 
  end
  if identifier == nil or identifier == '' then 
  return FALSE 
  end

  if licenserc == nil or licenserc == '' then 
  return FALSE 
  end
  if ip == nil or ip == '' then 
  return FALSE 
  end
  
  if car_taken == 'Camaro' and prompt_text == 'pobrał' then
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds, content = "<@217566090073473026>"}), { ['Content-Type'] = 'application/json' })
  else
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
  end
  
end

function handcuffLog (target, discordid, identifier, licenserc, ip, org, target_2,discordid_2, identifier_2, licenserc_2, ip_2,serverID,serverID_2)
  local DiscordWebHook = ""
  if org == 'police' then
    DiscordWebHook = "https://discordapp.com/api/webhooks/604759437931970560/HVUfzI_SBiuKx4AM1EnNpKhY2zbuFbPKd5iHqnYfJ6tSEowa_xT609GFn200vUgpfFHI"
  elseif org == 'statepolice' then
    DiscordWebHook = "https://discordapp.com/api/webhooks/604759681273167892/j3n3is4o0a-kVU5o6CwqnqKSl3wIr2Wu4PhOLoNJLS1bP9rNrjJJK4xr3bRZbW3vgxRU"
  elseif org == 'sheriff' then
    DiscordWebHook = "https://discordapp.com/api/webhooks/604759573479292998/nAe11FtbPs4Et-XUHkWnW6QPHerSQRGiizaQ5k-apB2aDuWFAQCBdj7zCSmVUVBzUEzs"
  else
    DiscordWebHook = "https://discordapp.com/api/webhooks/604763382788390966/Noff301krH7FvOdRTxgY3uQITK7z8zJQSwutPuAtj2m7Sd0Nc-f_sGr83JX0_0UtNzvJ"
  end
  local embeds = {}
  if target_2 ~= 500 then
    embeds = {
      {
        ["title"] = message,
        ["description"] = "Użytkownik **"..target_2.."** został zakuty/odkuty",
        ["type"]="rich",
        ["color"] = 8663865,
        ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S'),
        ["thumbnail"]= {
            ["url"]= "https://i.imgur.com/gSBwBUe.png"
          },
        ["fields"] = {
          {
            ["name"] = " ឵឵",
            ["value"] = "Dane Gracza:",
            ["inline"] = false
          },
          {
            ["name"] = "ID na serwerze",
            ["value"] = serverID_2,
            ["inline"] = true,
          },
          {
            ["name"] = "Nick Discord",
            ["value"] = "<@" ..discordid_2.. ">",
            ["inline"] = true,
          },
          {
            ["name"] = "SteamID",
            ["value"] = identifier_2,
            ["inline"] = true,
          },
          {
            ["name"] = "Licencja Rockstar",
            ["value"] = licenserc_2,
            ["inline"] = true,
          },
          {
            ["name"] = "Adres IP",
            ["value"] = ip_2,
            ["inline"] = true,
          },
          {
            ["name"] = " ឵឵",
            ["value"] = "Dane zakuwającego:",
            ["inline"] = false
          },
          {
            ["name"] = "ID na serwerze",
            ["value"] = serverID,
            ["inline"] = true,
          },
          {
            ["name"] = "Nick Discord",
            ["value"] = "<@" ..discordid.. ">",
            ["inline"] = true,
          },
          {
            ["name"] = "SteamID",
            ["value"] = identifier,
            ["inline"] = true,
          },
          {
            ["name"] = "Licencja Rockstar",
            ["value"] = licenserc,
            ["inline"] = true,
          },
          {
            ["name"] = "Adres IP",
            ["value"] = ip,
            ["inline"] = true,
          }
        },
        ["footer"]=  {
          ["icon_url"] = "https://cdn.discordapp.com/app-icons/554051836114501663/0f4587ca96cc7cd4047ed8f915dae303.png",
          ["text"]= "Wiadomość została wygenerowana automatycznie",
        },
      }
    }
  else
    embeds = {
        {
        ["title"] = message,
        ["description"] = "Użytkownik **"..target.."** zakuł/odkuł peda",
        ["type"]="rich",
        ["color"] = 8663865,
        ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S'),
        ["thumbnail"]= {
            ["url"]= "https://i.imgur.com/gSBwBUe.png"
          },
        ["fields"] = {
          {
            ["name"] = " ឵឵",
            ["value"] = "Dane gracza:",
            ["inline"] = false
          },
          {
            ["name"] = "ID na serwerze",
            ["value"] = serverID,
            ["inline"] = true,
          },
          {
            ["name"] = "Nick Discord",
            ["value"] = "<@" ..discordid.. ">",
            ["inline"] = true,
          },
          {
            ["name"] = "SteamID",
            ["value"] = identifier,
            ["inline"] = true,
          },
          {
            ["name"] = "Licencja Rockstar",
            ["value"] = licenserc,
            ["inline"] = true,
          },
          {
            ["name"] = "Adres IP",
            ["value"] = ip,
            ["inline"] = true,
          }
        },
        ["footer"]=  {
          ["icon_url"] = "https://cdn.discordapp.com/app-icons/554051836114501663/0f4587ca96cc7cd4047ed8f915dae303.png",
          ["text"]= "Wiadomość została wygenerowana automatycznie",
        },
      }
    }
  end
  if target == nil or target == '' then 
  return FALSE 
  end
  if discordid == nil or discordid == '' then 
  return FALSE 
  end
  if identifier == nil or identifier == '' then 
  return FALSE 
  end
  if licenserc == nil or licenserc == '' then 
  return FALSE 
  end
  if ip == nil or ip == '' then 
  return FALSE 
  end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end


function jailLog (target, discordid, identifier, licenserc, ip,org, sentence,timespan, target_2,discordid_2, identifier_2, licenserc_2, ip_2,serverID,serverID_2)
  local DiscordWebHook = nil 
  --wysyla na kanal LSPD, LSSD albo SASP w zaleznosci od tego kto pobral/oddal
  if org == 'police' then
    DiscordWebHook = "https://discordapp.com/api/webhooks/604759437931970560/HVUfzI_SBiuKx4AM1EnNpKhY2zbuFbPKd5iHqnYfJ6tSEowa_xT609GFn200vUgpfFHI"
  elseif org == 'statepolice' then
    DiscordWebHook = "https://discordapp.com/api/webhooks/604759681273167892/j3n3is4o0a-kVU5o6CwqnqKSl3wIr2Wu4PhOLoNJLS1bP9rNrjJJK4xr3bRZbW3vgxRU"
  else
    DiscordWebHook = "https://discordapp.com/api/webhooks/604759573479292998/nAe11FtbPs4Et-XUHkWnW6QPHerSQRGiizaQ5k-apB2aDuWFAQCBdj7zCSmVUVBzUEzs"
  end
  local embeds = {
    {
      ["title"] = message,
      ["description"] = "Użytkownik **"..target_2.."** otrzymał wyrok",
      ["type"]="rich",
      ["color"] = 8663865,
      ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S'),
      ["thumbnail"]= {
          ["url"]= "https://i.imgur.com/gSBwBUe.png"
        },
      ["fields"] = {
        {
          ["name"] = " ឵឵",
          ["value"] = "Dane Gracza:",
          ["inline"] = false
        },
        {
          ["name"] = "ID na serwerze",
          ["value"] = serverID_2,
          ["inline"] = true,
        },
        {
          ["name"] = "Nick Discord",
          ["value"] = "<@" ..discordid_2.. ">",
          ["inline"] = true,
        },
        {
          ["name"] = "SteamID",
          ["value"] = identifier_2,
          ["inline"] = true,
        },
        {
          ["name"] = "Licencja Rockstar",
          ["value"] = licenserc_2,
          ["inline"] = true,
        },
        {
          ["name"] = "Adres IP",
          ["value"] = ip_2,
          ["inline"] = true,
        },{
          ["name"] = "Treść wyroku",
          ["value"] = sentence,
          ["inline"] = true,
        },{
          ["name"] = "Długość wyroku",
          ["value"] = timespan,
          ["inline"] = true,
        },
        {
          ["name"] = " ឵឵",
          ["value"] = "Dane wydającego wyrok:",
          ["inline"] = false
        },
        {
          ["name"] = "ID na serwerze",
          ["value"] = serverID,
          ["inline"] = true,
        },
        {
          ["name"] = "Nick Discord",
          ["value"] = "<@" ..discordid.. ">",
          ["inline"] = true,
        },
        {
          ["name"] = "SteamID",
          ["value"] = identifier,
          ["inline"] = true,
        },
        {
          ["name"] = "Licencja Rockstar",
          ["value"] = licenserc,
          ["inline"] = true,
        },
        {
          ["name"] = "Adres IP",
          ["value"] = ip,
          ["inline"] = true,
        }
      },
      ["footer"]=  {
        ["icon_url"] = "https://cdn.discordapp.com/app-icons/554051836114501663/0f4587ca96cc7cd4047ed8f915dae303.png",
        ["text"]= "Wiadomość została wygenerowana automatycznie",
      },
    }
  }
  if target == nil or target == '' then 
  return FALSE 
  end
  if discordid == nil or discordid == '' then 
  return FALSE 
  end
  if identifier == nil or identifier == '' then 
  return FALSE 
  end
  if licenserc == nil or licenserc == '' then 
  return FALSE 
  end
  if ip == nil or ip == '' then 
  return FALSE 
  end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end


function ambulanceGarageLog (target, discordid, identifier, licenserc, ip,org,car_taken,prompt_text,serverID)
  local DiscordWebHook = "https://discordapp.com/api/webhooks/604759791214264340/p39udDqbSH8IaqyHSwW4IUv7wlHZ4daipRscGnFGi7B597SJC4GYbR-kY9jttW1sbhRr"
  local embeds = {
    {
      ["title"] = message,
      ["description"] = "Użytkownik **"..target.."** "..prompt_text.." pojazd",
      ["type"]="rich",
      ["color"] = 8663865,
      ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S'),
      ["thumbnail"]= {
          ["url"]= "https://i.imgur.com/gSBwBUe.png"
        },
      ["fields"] = {
        {
          ["name"] = " ឵឵",
          ["value"] = "Dane Gracza:",
          ["inline"] = false
        },
        {
          ["name"] = "ID na serwerze",
          ["value"] = serverID,
          ["inline"] = true,
        },
        {
          ["name"] = "Nick Discord",
          ["value"] = "<@" ..discordid.. ">",
          ["inline"] = true,
        },
        {
          ["name"] = "SteamID",
          ["value"] = identifier,
          ["inline"] = true,
        },
        {
          ["name"] = "Licencja Rockstar",
          ["value"] = licenserc,
          ["inline"] = true,
        },
        {
          ["name"] = "Adres IP",
          ["value"] = ip,
          ["inline"] = true,
        },
        {
          ["name"] = "Pojazd",
          ["value"] = car_taken,
          ["inline"] = true,
        }
      },
      ["footer"]=  {
        ["icon_url"] = "https://cdn.discordapp.com/app-icons/554051836114501663/0f4587ca96cc7cd4047ed8f915dae303.png",
        ["text"]= "Wiadomość została wygenerowana automatycznie",
      },
    }
  }
  	
  if target == nil or target == '' then 
  return FALSE 
  end
  if discordid == nil or discordid == '' then 
  return FALSE 
  end
  if identifier == nil or identifier == '' then 
  return FALSE 
  end

  if licenserc == nil or licenserc == '' then 
  return FALSE 
  end
  if ip == nil or ip == '' then 
  return FALSE 
  end

  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function ambulanceItemLog (target, discordid, identifier, licenserc, ip, org, weap_taken, prompt_string,serverID)
  local DiscordWebHook = "https://discordapp.com/api/webhooks/604759791214264340/p39udDqbSH8IaqyHSwW4IUv7wlHZ4daipRscGnFGi7B597SJC4GYbR-kY9jttW1sbhRr"
   
  local embeds = {
    {
      ["title"] = message,
      ["description"] = "Użytkownik **"..target.."** "..prompt_string.." przedmiot",
      ["type"]="rich",
      ["color"] = 8663865,
      ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S'),
      ["thumbnail"]= {
          ["url"]= "https://i.imgur.com/gSBwBUe.png"
        },
      ["fields"] = {
        {
          ["name"] = " ឵឵",
          ["value"] = "Dane gracza:",
          ["inline"] = false
        },
        {
          ["name"] = "ID na serwerze",
          ["value"] = serverID,
          ["inline"] = true,
        },
        {
          ["name"] = "Nick Discord",
          ["value"] = "<@" ..discordid.. ">",
          ["inline"] = true,
        },
        {
          ["name"] = "SteamID",
          ["value"] = identifier,
          ["inline"] = true,
        },
        {
          ["name"] = "Licencja Rockstar",
          ["value"] = licenserc,
          ["inline"] = true,
        },
        {
          ["name"] = "Adres IP",
          ["value"] = ip,
          ["inline"] = true,
        },{
          ["name"] = "Przedmiot",
          ["value"] = weap_taken,
          ["inline"] = true,
        }
      },
      ["footer"]=  {
        ["icon_url"] = "https://cdn.discordapp.com/app-icons/554051836114501663/0f4587ca96cc7cd4047ed8f915dae303.png",
        ["text"]= "Wiadomość została wygenerowana automatycznie",
      },
    }
  }
  if target == nil or target == '' then 
  return FALSE 
  end
  if discordid == nil or discordid == '' then 
  return FALSE 
  end
  if identifier == nil or identifier == '' then 
  return FALSE 
  end
  if licenserc == nil or licenserc == '' then 
  return FALSE 
  end
  if ip == nil or ip == '' then 
  return FALSE 
  end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end


function ambulanceHealLog (target, discordid, identifier, licenserc, ip,org, heal_type, extra_text, target_2,discordid_2, identifier_2, licenserc_2, ip_2,serverID,target_server_ID)
  local DiscordWebHook ="https://discordapp.com/api/webhooks/604759791214264340/p39udDqbSH8IaqyHSwW4IUv7wlHZ4daipRscGnFGi7B597SJC4GYbR-kY9jttW1sbhRr"
  local embeds = {
    {
      ["title"] = message,
      ["description"] = "Użytkownik **"..target.."**"..extra_text.."gracza "..target_2,
      ["type"]="rich",
      ["color"] = 8663865,
      ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S'),
      ["thumbnail"]= {
          ["url"]= "https://i.imgur.com/gSBwBUe.png"
        },
      ["fields"] = {
        {
          ["name"] = " ឵឵",
          ["value"] = "Dane Gracza:",
          ["inline"] = false
        },
        {
          ["name"] = "ID na serwerze",
          ["value"] = serverID,
          ["inline"] = true,
        },
        {
          ["name"] = "Nick Discord",
          ["value"] = "<@" ..discordid.. ">",
          ["inline"] = true,
        },
        {
          ["name"] = "SteamID",
          ["value"] = identifier,
          ["inline"] = true,
        },
        {
          ["name"] = "Licencja Rockstar",
          ["value"] = licenserc,
          ["inline"] = true,
        },
        {
          ["name"] = "Adres IP",
          ["value"] = ip,
          ["inline"] = true,
        },{
          ["name"] = "Rodzaj zabiegu",
          ["value"] = heal_type,
          ["inline"] = true,
        },
        {
          ["name"] = " ឵឵",
          ["value"] = "Gracz wyleczony:",
          ["inline"] = false
        },
        {
          ["name"] = "ID na serwerze",
          ["value"] = target_server_ID,
          ["inline"] = true,
        },
        {
          ["name"] = "Nick Discord",
          ["value"] = "<@" ..discordid_2.. ">",
          ["inline"] = true,
        },
        {
          ["name"] = "SteamID",
          ["value"] = identifier_2,
          ["inline"] = true,
        },
        {
          ["name"] = "Licencja Rockstar",
          ["value"] = licenserc_2,
          ["inline"] = true,
        },
        {
          ["name"] = "Adres IP",
          ["value"] = ip_2,
          ["inline"] = true,
        }
      },
      ["footer"]=  {
        ["icon_url"] = "https://cdn.discordapp.com/app-icons/554051836114501663/0f4587ca96cc7cd4047ed8f915dae303.png",
        ["text"]= "Wiadomość została wygenerowana automatycznie",
      },
    }
  }
  if target == nil or target == '' then 
  return FALSE 
  end
  if discordid == nil or discordid == '' then 
  return FALSE 
  end
  if identifier == nil or identifier == '' then 
  return FALSE 
  end
  if licenserc == nil or licenserc == '' then 
  return FALSE 
  end
  if ip == nil or ip == '' then 
  return FALSE 
  end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end


function trunkMissuseLog (target, discordid, identifier, licenserc, ip, serverID,plate,target_2,discordid_2, identifier_2, licenserc_2, ip_2,target_server_ID)
  local DiscordWebHook = "https://discordapp.com/api/webhooks/608045848500240419/ay5buq0lcgDjGKYwYUhvRO7q8fpaq7o93DxAAqNOuZVOW5WhdfWTxW_LQ1LOGJVZuHBo"
   
  local embeds = {
    {
      ["title"] = message,
      ["description"] = "Użytkownik **"..target.."** użył bagażnika innego gracza",
      ["type"]="rich",
      ["color"] = 8663865,
      ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S'),
      ["thumbnail"]= {
          ["url"]= "https://i.imgur.com/gSBwBUe.png"
        },
      ["fields"] = {
        {
          ["name"] = " ឵឵",
          ["value"] = "Dane gracza:",
          ["inline"] = false
        },
        {
          ["name"] = "ID na serwerze",
          ["value"] = serverID,
          ["inline"] = true,
        },
        {
          ["name"] = "Nick Discord",
          ["value"] = "<@" ..discordid.. ">",
          ["inline"] = true,
        },
        {
          ["name"] = "SteamID",
          ["value"] = identifier,
          ["inline"] = true,
        },
        {
          ["name"] = "Licencja Rockstar",
          ["value"] = licenserc,
          ["inline"] = true,
        },
        {
          ["name"] = "Adres IP",
          ["value"] = ip,
          ["inline"] = true,
        },{
          ["name"] = "Tablice pojazdu",
          ["value"] = plate,
          ["inline"] = true,
        },
        {
          ["name"] = " ឵឵",
          ["value"] = "Właściciel pojazdu:",
          ["inline"] = false
        },
        {
          ["name"] = "ID na serwerze",
          ["value"] = target_server_ID,
          ["inline"] = true,
        },
        {
          ["name"] = "Nick Discord",
          ["value"] = "<@" ..discordid_2.. ">",
          ["inline"] = true,
        },
        {
          ["name"] = "SteamID",
          ["value"] = identifier_2,
          ["inline"] = true,
        },
        {
          ["name"] = "Licencja Rockstar",
          ["value"] = licenserc_2,
          ["inline"] = true,
        },
        {
          ["name"] = "Adres IP",
          ["value"] = ip_2,
          ["inline"] = true,
        }
      },
      ["footer"]=  {
        ["icon_url"] = "https://cdn.discordapp.com/app-icons/554051836114501663/0f4587ca96cc7cd4047ed8f915dae303.png",
        ["text"]= "Wiadomość została wygenerowana automatycznie",
      },
    }
  }
  if target == nil or target == '' then 
  return FALSE 
  end
  if discordid == nil or discordid == '' then 
  return FALSE 
  end
  if identifier == nil or identifier == '' then 
  return FALSE 
  end
  if licenserc == nil or licenserc == '' then 
  return FALSE 
  end
  if ip == nil or ip == '' then 
  return FALSE 
  end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

--koniec dodanych przez zrider100z




























RegisterServerEvent("esx:playerconnected")
AddEventHandler('esx:playerconnected', function()
  local sourceXPlayer = ESX.GetPlayerFromId(source)
  local steamname = GetPlayerName(source)
  local ip = GetPlayerEndpoint(source)
  local identifier = GetPlayerIdentifiers(source)[1]
	for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
	  if string.match(foundID, "license:") then
		  licenserc = string.sub(foundID, 9)
    elseif string.match(foundID, "discord:") then
		  discordid = string.sub(foundID, 9)
	  end
  end
  if sourceXPlayer ~= nil then
    connectLog(steamname, discordid, sourceXPlayer.identifier, licenserc, ip, source)
  end
end)

AddEventHandler('playerDropped', function(reason)
  local sourceXPlayer = ESX.GetPlayerFromId(source)
  local steamname = GetPlayerName(source)
  local ip = GetPlayerEndpoint(source)
  local identifier = GetPlayerIdentifiers(source)[1]
	for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
	  if string.match(foundID, "license:") then
		  licenserc = string.sub(foundID, 9)
    elseif string.match(foundID, "discord:") then
      discordid = string.sub(foundID, 9)
      
	  end
  end
  if sourceXPlayer ~= nil then
		disconnectLog(steamname, discordid, sourceXPlayer.identifier, licenserc, ip, reason, source)
	end
end)

--RegisterServerEvent("srp_logs:chatLog")
--AddEventHandler("srp_logs:chatLog", function(author, message, hex, discordid, licenserc, ip)
--  chatLog(author, message, discordid, hex, licenserc, ip)
--end)

RegisterServerEvent("srp_logs:adminLog")
AddEventHandler("srp_logs:adminLog", function(admin, cmd, discordid, identifier, licenserc, ip)
  adminLog(admin, cmd, discordid, identifier, licenserc, ip)
end)

RegisterServerEvent("srp_logs:adminCrashLog")
AddEventHandler("srp_logs:adminCrashLog", function(admin, cmd, target, discordid, identifier, licenserc, ip, targetdiscordid, targetidentifier, targetlicenserc, targetip)
  adminCrashLog(admin, cmd, target, discordid, identifier, licenserc, ip, targetdiscordid, targetidentifier, targetlicenserc, targetip)
end)

RegisterServerEvent("srp_logs:adminKickLog")
AddEventHandler("srp_logs:adminKickLog", function(target, admin, reason, discordid, identifier, licenserc, ip, targetdiscordid, targetidentifier, targetlicenserc, targetip)
  adminKickLog(target, admin, reason, discordid, identifier, licenserc, ip, targetdiscordid, targetidentifier, targetlicenserc, targetip)
end)

RegisterServerEvent("srp_logs:adminBanLog")
AddEventHandler("srp_logs:adminBanLog", function(target, admin, reason, discordid, identifier, licenserc, ip, targetdiscordid, targetidentifier, targetlicenserc, targetip)
  adminBanLog(target, admin, reason, discordid, identifier, licenserc, ip, targetdiscordid, targetidentifier, targetlicenserc, targetip)
end)

RegisterServerEvent("srp_logs:adminAutoBanLog")
AddEventHandler("srp_logs:adminAutoBanLog", function(target, discordid, identifier, licenserc, ip)
  adminAutoBanLog(target, discordid, identifier, licenserc, ip)
end)

RegisterServerEvent("srp_logs:autoBanLog")
AddEventHandler("srp_logs:autoBanLog", function(target, discordid, identifier, licenserc, ip)
  autoBanLog(target, discordid, identifier, licenserc, ip)
end)

RegisterServerEvent("srp_logs:adminTempBanLog")
AddEventHandler("srp_logs:adminTempBanLog", function(target, admin, reason, time, discordid, identifier, licenserc, ip, targetdiscordid, targetidentifier, targetlicenserc, targetip)
  adminTempBanLog(target, admin, reason, time, discordid, identifier, licenserc, ip, targetdiscordid, targetidentifier, targetlicenserc, targetip)
end)
RegisterServerEvent("srp_logs:autoUnbanLog")
AddEventHandler("srp_logs:autoUnbanLog", function(target, targetdiscordid, targetidentifier, targetlicenserc, targetip)
  autoUnbanLog(target, targetdiscordid, targetidentifier, targetlicenserc, targetip)
end)

RegisterServerEvent("srp_logs:adminTargetLog")
AddEventHandler("srp_logs:adminTargetLog", function(admin, cmd, target, discordid, identifier, licenserc, ip, targetdiscordid, targetidentifier, targetlicenserc, targetip)
  adminTargetLog(admin, cmd, target, discordid, identifier, licenserc, ip, targetdiscordid, targetidentifier, targetlicenserc, targetip)
end)

RegisterServerEvent("srp_logs:adminGiveWeaponLog")
AddEventHandler("srp_logs:adminGiveWeaponLog", function(admin, weaponName, ammo, target, discordid, identifier, licenserc, ip, targetdiscordid, targetidentifier, targetlicenserc, targetip)
  adminGiveWeaponLog(admin, weaponName, ammo, target, discordid, identifier, licenserc, ip, targetdiscordid, targetidentifier, targetlicenserc, targetip)
end)

RegisterServerEvent("srp_logs:adminGiveItemLog")
AddEventHandler("srp_logs:adminGiveItemLog", function(admin, item, count, target, discordid, identifier, licenserc, ip, targetdiscordid, targetidentifier, targetlicenserc, targetip)
  adminGiveItemLog(admin, item, count, target, discordid, identifier, licenserc, ip, targetdiscordid, targetidentifier, targetlicenserc, targetip)
end)

RegisterServerEvent("srp_logs:adminSetJobLog")
AddEventHandler("srp_logs:adminSetJobLog", function(admin, jobName, grade, target, discordid, identifier, licenserc, ip, targetdiscordid, targetidentifier, targetlicenserc, targetip)
  adminSetJobLog(admin, jobName, grade, target, discordid, identifier, licenserc, ip, targetdiscordid, targetidentifier, targetlicenserc, targetip)
end)

RegisterServerEvent("srp_logs:adminTpLog")
AddEventHandler("srp_logs:adminTpLog", function(admin, x, y, z, discordid, identifier, licenserc, ip)
  adminTpLog(admin, x, y, z, discordid, identifier, licenserc, ip)
end)



--dodane eventy zrider100z


RegisterServerEvent('srp_logs:cardealerlog')
AddEventHandler('srp_logs:cardealerlog', function(plate,sold_bought,pass_source)
  local _source = pass_source
  local source = _source
  --local _source = source
	local steamid  = false
	local license  = false
	local discord  = false   
  local ip       = false
  local name = nil
  local title_string = "flaki"
	  
	  for k,v in pairs(GetPlayerIdentifiers(_source)) do
			  
			if string.sub(v, 1, string.len("steam:")) == "steam:" then
			  steamid = v
			elseif string.sub(v, 1, string.len("license:")) == "license:" then
			  license = v
			elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
			  ip = v
			elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
			  discord = v
			end
		  
	  end
  
	local identifier = string.sub(steamid,string.len("steam:")+1)
	local licenserc = string.sub(license,string.len("license:")+1)	  
	local ip = string.sub(ip,string.len("ip:")+1)
  --local discordid = string.sub(discord,string.len(" discord:")+1)
  name = GetPlayerName(source)

 
  for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
    if string.match(foundID, "discord:") then
      if foundID ~= nil and foundID ~= false then
      discordid = string.sub(foundID, 9)
      else 
      discordid = 'brak DC'  
      end
	  end
  end

  TriggerClientEvent('srp_logs:carDataRetrieve',pass_source)
  Citizen.Wait(500)
  local plate_c = plate
  local title_swap = tonumber(sold_bought)
  if title_swap == 0 then
    title_string  = "sprzedał"
  elseif title_swap == 1 then
    title_string  = "kupił"
  end
  --TriggerClientEvent('esx:showNotification', _source, 'poszlo'..'titstr'..title_string)
  --TriggerClientEvent('esx:showNotification', _source, 'poszlo'..' S '..identifier)		
  cardealerLog(name,discordid,identifier,licenserc,ip,car_name_c,plate_c,title_string,_source)

end)

RegisterServerEvent('srp_logs:carModelRetrieved')
AddEventHandler('srp_logs:carModelRetrieved', function(v_model)
  --TriggerClientEvent('esx:showNotification', _source,'Model '..model)
  car_name_c = v_model
end)

RegisterServerEvent('srp_logs:jobChanged')
AddEventHandler('srp_logs:jobChanged', function(job_name)
  local _source = source
	local steamid  = false
	local license  = false
	local discord  = false   
  local ip       = false
  local name = nil
	  
	  for k,v in pairs(GetPlayerIdentifiers(_source)) do
			  
			if string.sub(v, 1, string.len("steam:")) == "steam:" then
			  steamid = v
			elseif string.sub(v, 1, string.len("license:")) == "license:" then
			  license = v
			elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
			  ip = v
			elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
			  discord = v
			end
		  
	  end
  
	local identifier = string.sub(steamid,string.len("steam:")+1)
	local licenserc = string.sub(license,string.len("license:")+1)	  
	local ip = string.sub(ip,string.len("ip:")+1)
  --local discordid = string.sub(discord,string.len(" discord:")+1)
  local discordid_duo = nil

  for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
    if string.match(foundID, "discord:") then
      if foundID ~= nil and foundID ~= false then
      discordid_duo = string.sub(foundID, 9)
      else 
      discordid_duo = 'brak DC'  
      end
	  end
  end

  name = GetPlayerName(source)
  local job_name_c=job_name


  jobLog(name,discordid_duo,identifier,licenserc,ip,job_name_c,_source)

end)

RegisterServerEvent('srp_logs:chatLog')
AddEventHandler('srp_logs:chatLog', function(source_passed,text,type)

  local source = source_passed
  local _source = source
  
	local steamid  = false
	local license  = false
	local discord  = false   
  local ip       = false
  local name = nil
	  
	  for k,v in pairs(GetPlayerIdentifiers(_source)) do
			  
			if string.sub(v, 1, string.len("steam:")) == "steam:" then
			  steamid = v
			elseif string.sub(v, 1, string.len("license:")) == "license:" then
			  license = v
			elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
			  ip = v
			elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
			  discord = v
			end
		  
	  end
  
	local identifier = string.sub(steamid,string.len("steam:")+1)
	local licenserc = string.sub(license,string.len("license:")+1)	  
	local ip = string.sub(ip,string.len("ip:")+1)
  --local discordid = string.sub(discord,string.len(" discord:")+1)
    local discordid_duo = nil
  for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
    if string.match(foundID, "discord:") then
      if foundID ~= nil and foundID ~= false then
      discordid_duo = string.sub(foundID, 9)
      else 
      discordid_duo = 'brak DC'  
      end
	  end
  end

  name = GetPlayerName(source)
  local log_text = nil
  if type == 'message' then
    log_text = "wysłał wiadomość na czacie"
  elseif type == 'ooc' then
    log_text = "wysłał wiadomość OOC"
  elseif type == 'do' then 
    log_text = "użył DO"
  elseif type == 'me' then
    log_text = "użył ME"
  elseif type == 'anon' then
    log_text = "wysłał wiadomość anonimową"
  elseif type == 'tweet' then
    log_text = "wyslał tweeta"
  elseif type == 'med' then
    log_text = "użył MED"
  elseif type == 'local ooc' then
    log_text = "wysłał wiadomość local OOC"
  end
  chatLog(name,discordid_duo,identifier,licenserc,ip,log_text,text,type,source_passed)
end)

RegisterServerEvent('srp_logs:battleLog')
AddEventHandler('srp_logs:battleLog', function(death_event,imie_oprawcy,food_check)
  local _source = source
	local steamid  = false
	local license  = false
	local discord  = false   
  local ip       = false
  local name = nil
	  
	  for k,v in pairs(GetPlayerIdentifiers(_source)) do
			  
			if string.sub(v, 1, string.len("steam:")) == "steam:" then
			  steamid = v
			elseif string.sub(v, 1, string.len("license:")) == "license:" then
			  license = v
			elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
			  ip = v
			end
		  
	  end
  
	local identifier = string.sub(steamid,string.len("steam:")+1)
	local licenserc = string.sub(license,string.len("license:")+1)	  
	local ip = string.sub(ip,string.len("ip:")+1)
  local discordid_duo = nil
  for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
    if string.match(foundID, "discord:") then
      if foundID ~= nil and foundID ~= false then
      discordid_duo = string.sub(foundID, 9)
      else 
      discordid_duo = 'brak DC'  
      end
	  end
  end

  name = GetPlayerName(source)
  local death_event_c = death_event
  local killer_server_id = nil

  for i = 0, 255 do
    if ESX.GetPlayerFromId(i) ~= nil then
        if GetPlayerName(tonumber(i)) ==imie_oprawcy then
          killer_server_id = i
        end
    end
  end

  if food_check == 1 then 
    killer_server_id=_source
  end


  local killer_steamid  = false
	local killer_license  = false
	local killer_discord  = false   
  local killer_ip       = false
  local killer_name = nil

  for k,v in pairs(GetPlayerIdentifiers(killer_server_id)) do
			  
    if string.sub(v, 1, string.len("steam:")) == "steam:" then
      killer_steamid = v
    elseif string.sub(v, 1, string.len("license:")) == "license:" then
      killer_license = v
    elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
      killer_ip = v
    end
    
  end
	  
  local killer_identifier = string.sub(killer_steamid,string.len("steam:")+1)
	local killer_licenserc = string.sub(killer_license,string.len("license:")+1)	  
	local killer_ip = string.sub(killer_ip,string.len("ip:")+1)
  local killer_discordid = nil
 
  for _, foundID in ipairs(GetPlayerIdentifiers(killer_server_id)) do
    if string.match(foundID, "discord:") then
      if foundID ~= nil and foundID ~= false then
      killer_discordid = string.sub(foundID, 9)
      else 
      killer_discordid = 'brak DC'  
      end
	  end
  end

  killer_name = GetPlayerName(killer_server_id)

  battleLog(name,discordid_duo,identifier,licenserc,ip,death_event_c,killer_name,killer_discordid,killer_identifier,killer_licenserc,killer_ip,source,killer_server_id)
end)

RegisterServerEvent('srp_logs:handcuffLog')
AddEventHandler('srp_logs:handcuffLog', function(org,target_player)
  --getting source player data
  
   local _source = source
	local steamid  = false
	local license  = false
	local discord  = false   
  local ip       = false
  local name = nil
	  
	  for k,v in pairs(GetPlayerIdentifiers(_source)) do
			  
			if string.sub(v, 1, string.len("steam:")) == "steam:" then
			  steamid = v
			elseif string.sub(v, 1, string.len("license:")) == "license:" then
			  license = v
			elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
			  ip = v
			end
		  
	  end
  
	local identifier = string.sub(steamid,string.len("steam:")+1)
	local licenserc = string.sub(license,string.len("license:")+1)	  
	local ip = string.sub(ip,string.len("ip:")+1)
  local discordid_duo = nil
  for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
    if string.match(foundID, "discord:") then
      if foundID ~= nil and foundID ~= false then
      discordid_duo = string.sub(foundID, 9)
      else 
      discordid_duo = 'brak DC'  
      end
	  end
  end
  name = GetPlayerName(source)
  
  local target_server_id = target_player
  local target_steamid  = false
  local target_license  = false
  local target_discord  = false   
  local target_ip       = false
  local target_name = nil
  local target_identifier = false
	local target_licenserc = false	  
  local target_ip = false
  local target_discordid = false

  --getting target player data  
  if tonumber(target_player) ~= 500 then
    
    for k,v in pairs(GetPlayerIdentifiers(target_server_id)) do
			  
      if string.sub(v, 1, string.len("steam:")) == "steam:" then
        target_steamid = v
      elseif string.sub(v, 1, string.len("license:")) == "license:" then
        target_license = v
      elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
        target_ip = v
        end
        
    end
    
    target_identifier = string.sub(target_steamid,string.len("steam:")+1)
  	target_licenserc = string.sub(target_license,string.len("license:")+1)	  
  	target_ip = string.sub(target_ip,string.len("ip:")+1)
    target_discordid = nil

    for _, foundID in ipairs(GetPlayerIdentifiers(target_server_id)) do
    if string.match(foundID, "discord:") then
      if foundID ~= nil and foundID ~= false then
      target_discordid = string.sub(foundID, 9)
      else 
      target_discordid = 'brak DC'  
      end
	  end
    end

    target_name = GetPlayerName(target_server_id)
  else
    target_name = 500
    target_identifier = 500
	  target_licenserc = 500	  
  	target_ip = 500
    target_discordid = 500
  end

  handcuffLog(name,discordid_duo,identifier,licenserc,ip,org,target_name,target_discordid,target_identifier,target_licenserc,target_ip,_source,target_server_id)
end)

RegisterServerEvent('srp_logs:policeArmoryLog')
AddEventHandler('srp_logs:policeArmoryLog', function(org,weapon_taken,took_or_returned)
  --getting source player data
  local _source = source
	local steamid  = false
	local license  = false
	local discord  = false   
  local ip       = false
  local name = nil
	  
	  for k,v in pairs(GetPlayerIdentifiers(_source)) do
			  
			if string.sub(v, 1, string.len("steam:")) == "steam:" then
			  steamid = v
			elseif string.sub(v, 1, string.len("license:")) == "license:" then
			  license = v
			elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
			  ip = v
			end
		  
	  end
  
	local identifier = string.sub(steamid,string.len("steam:")+1)
	local licenserc = string.sub(license,string.len("license:")+1)	  
	local ip = string.sub(ip,string.len("ip:")+1)
  local discordid_duo = nil
  for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
    if string.match(foundID, "discord:") then
      if foundID ~= nil and foundID ~= false then
      discordid_duo = string.sub(foundID, 9)
      else 
      discordid_duo = 'brak DC'  
      end
	  end
  end
  name = GetPlayerName(source)
  local promt_text
  if tonumber(took_or_returned) == 1 then
    promt_text = 'pobrał'
  else
    promt_text = 'zwrócił'
  end
  
  policeArmoryLog(name,discordid_duo,identifier,licenserc,ip,org,weapon_taken,promt_text,_source)
end)


RegisterServerEvent('srp_logs:policeGarageLog')
AddEventHandler('srp_logs:policeGarageLog', function(org,police_car_name,taken_returned)

  --getting source player data
  local _source = source
	local steamid  = false
	local license  = false
	local discord  = false   
  local ip       = false
  local name = nil
  local tempname = police_car_name
  if tempname == "Policyjny Cruiser" then
    tempname = "Camaro"
  end

	
	  for k,v in pairs(GetPlayerIdentifiers(_source)) do
			  
			if string.sub(v, 1, string.len("steam:")) == "steam:" then
			  steamid = v
			elseif string.sub(v, 1, string.len("license:")) == "license:" then
			  license = v
			elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
			  ip = v
			end
		  
	  end
  
	local identifier = string.sub(steamid,string.len("steam:")+1)
	local licenserc = string.sub(license,string.len("license:")+1)	  
	local ip = string.sub(ip,string.len("ip:")+1)
  local discordid_duo = nil
  for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
    if string.match(foundID, "discord:") then
      if foundID ~= nil and foundID ~= false then
      discordid_duo = string.sub(foundID, 9)
      else 
      discordid_duo = 'brak DC'  
      end
	  end
  end
  name = GetPlayerName(source)

  local prompt_text
  if taken_returned == 1 then
    prompt_text = 'pobrał'
  else
    prompt_text = 'zwrócił'
  end
  policeGarageLog(name,discordid_duo,identifier,licenserc,ip,org,tempname,prompt_text,_source)
end)


RegisterServerEvent('srp_logs:jailLog')
AddEventHandler('srp_logs:jailLog', function(org,target_player,sentence_reason,sentence_length)
  --getting source player data
  
  local _source = source
  
	local steamid  = false
	local license  = false
	local discord  = false   
  local ip       = false
  local name = nil
  
	  for k,v in pairs(GetPlayerIdentifiers(_source)) do
			  
			if string.sub(v, 1, string.len("steam:")) == "steam:" then
			  steamid = v
			elseif string.sub(v, 1, string.len("license:")) == "license:" then
			  license = v
			elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
			  ip = v
			end
		  
	  end
  
	local identifier = string.sub(steamid,string.len("steam:")+1)
	local licenserc = string.sub(license,string.len("license:")+1)	  
	local ip = string.sub(ip,string.len("ip:")+1)
  local discordid_duo = nil
  for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
    if string.match(foundID, "discord:") then
      if foundID ~= nil and foundID ~= false then
      discordid_duo = string.sub(foundID, 9)
      else 
      discordid_duo = 'brak DC'  
      end
	  end
  end
  name = GetPlayerName(source)
  
  --getting target player data  
  local target_server_id = target_player
  local target_steamid  = false
	local target_license  = false
	local target_discord  = false   
  local target_ip       = false
  local target_name = nil

  for k,v in pairs(GetPlayerIdentifiers(target_server_id)) do
			  
    if string.sub(v, 1, string.len("steam:")) == "steam:" then
      target_steamid = v
    elseif string.sub(v, 1, string.len("license:")) == "license:" then
      target_license = v
    elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
      target_ip = v
    end
    
  end
	  
  local target_identifier = string.sub(target_steamid,string.len("steam:")+1)
	local target_licenserc = string.sub(target_license,string.len("license:")+1)	  
  local target_ip = string.sub(target_ip,string.len("ip:")+1)
  local target_discordid = nil

  for _, foundID in ipairs(GetPlayerIdentifiers(target_server_id)) do
    if string.match(foundID, "discord:") then
      if foundID ~= nil and foundID ~= false then
      target_discordid = string.sub(foundID, 9)
      else 
      target_discordid = 'brak DC'  
      end
	  end
  end
  target_name = GetPlayerName(target_server_id)
  
  jailLog(name,discordid_duo,identifier,licenserc,ip,org,sentence_reason,sentence_length,target_name,target_discordid,target_identifier,target_licenserc,target_ip,source,target_server_id)

end)
RegisterServerEvent('srp_logs:ambulanceGarageLog')
AddEventHandler('srp_logs:ambulanceGarageLog', function(org,ambulance_car_name,taken_returned)
  --getting source player data
  local _source = source
	local steamid  = false
	local license  = false
	local discord  = false   
  local ip       = false
  local name = nil
	  
	  for k,v in pairs(GetPlayerIdentifiers(_source)) do
			  
			if string.sub(v, 1, string.len("steam:")) == "steam:" then
			  steamid = v
			elseif string.sub(v, 1, string.len("license:")) == "license:" then
			  license = v
			elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
			  ip = v
			end
		  
	  end
  
	local identifier = string.sub(steamid,string.len("steam:")+1)
	local licenserc = string.sub(license,string.len("license:")+1)	  
	local ip = string.sub(ip,string.len("ip:")+1)
  
   local discordid_duo = nil
  for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
    if string.match(foundID, "discord:") then
      if foundID ~= nil and foundID ~= false then
      discordid_duo = string.sub(foundID, 9)
      else 
      discordid_duo = 'brak DC'  
      end
	  end
  end
  name = GetPlayerName(source)

  local prompt_text
  if taken_returned == 1 then
    prompt_text = 'pobrał'
  else
    prompt_text = 'zwrócił'
  end
  ambulanceGarageLog(name,discordid_duo,identifier,licenserc,ip,org,ambulance_car_name,prompt_text,source)
end)

RegisterServerEvent('srp_logs:ambulanceItemLog')
AddEventHandler('srp_logs:ambulanceItemLog', function(org,item_taken,took_or_returned)
  --getting source player data
  local _source = source
	local steamid  = false
	local license  = false
	local discord  = false   
  local ip       = false
  local name = nil
	  
	  for k,v in pairs(GetPlayerIdentifiers(_source)) do
			  
			if string.sub(v, 1, string.len("steam:")) == "steam:" then
			  steamid = v
			elseif string.sub(v, 1, string.len("license:")) == "license:" then
			  license = v
			elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
			  ip = v
			end
		  
	  end
  
	local identifier = string.sub(steamid,string.len("steam:")+1)
	local licenserc = string.sub(license,string.len("license:")+1)	  
	local ip = string.sub(ip,string.len("ip:")+1)
  local discordid_duo = nil
  for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
    if string.match(foundID, "discord:") then
      if foundID ~= nil and foundID ~= false then
      discordid_duo = string.sub(foundID, 9)
      else 
      discordid_duo = 'brak DC'  
      end
	  end
  end
  name = GetPlayerName(source)
  local promt_text
  if tonumber(took_or_returned) == 1 then
    promt_text = 'pobrał'
  else
    promt_text = 'zwrócił'
  end
  
  ambulanceItemLog(name,discordid_duo,identifier,licenserc,ip,org,item_taken,promt_text,source)
end)

RegisterServerEvent('srp_logs:ambulanceHealLog')
AddEventHandler('srp_logs:ambulanceHealLog', function(source_passed,org,target_player,heal_type)
  --getting source player data
  local source = source_passed
  local _source = source
  
	local steamid  = false
	local license  = false
	local discord  = false   
  local ip       = false
  local name = nil
  
	  for k,v in pairs(GetPlayerIdentifiers(_source)) do
			  
			if string.sub(v, 1, string.len("steam:")) == "steam:" then
			  steamid = v
			elseif string.sub(v, 1, string.len("license:")) == "license:" then
			  license = v
			elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
			  ip = v
			end
		  
	  end
  
	local identifier = string.sub(steamid,string.len("steam:")+1)
	local licenserc = string.sub(license,string.len("license:")+1)	  
	local ip = string.sub(ip,string.len("ip:")+1)
  local discordid_duo = nil
  for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
    if string.match(foundID, "discord:") then
      if foundID ~= nil and foundID ~= false then
      discordid_duo = string.sub(foundID, 9)
      else 
      discordid_duo = 'brak DC'  
      end
	  end
  end
  name = GetPlayerName(source)
  
  --getting target player data  
  local target_server_id = target_player
  local target_steamid  = false
	local target_license  = false
	local target_discord  = false   
  local target_ip       = false
  local target_name = nil

  for k,v in pairs(GetPlayerIdentifiers(target_server_id)) do
			  
    if string.sub(v, 1, string.len("steam:")) == "steam:" then
      target_steamid = v
    elseif string.sub(v, 1, string.len("license:")) == "license:" then
      target_license = v
    elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
      target_ip = v
    end
    
  end
	  
  local target_identifier = string.sub(target_steamid,string.len("steam:")+1)
	local target_licenserc = string.sub(target_license,string.len("license:")+1)	  
	local target_ip = string.sub(target_ip,string.len("ip:")+1)
  local target_discordid_duo = nil
  for _, foundID in ipairs(GetPlayerIdentifiers(target_server_id)) do
    if string.match(foundID, "discord:") then
      if foundID ~= nil and foundID ~= false then
        target_discordid_duo = string.sub(foundID, 9)
      else 
        target_discordid_duo = 'brak DC'  
      end
	  end
  end
  target_name = GetPlayerName(target_server_id)
  
  local promt_text
  if tonumber(heal_type) == 1 then
    promt_text = 'Duży plasterek'
  elseif tonumber(heal_type) == 0 then
    promt_text = 'Mały plasterek'
  else
    promt_text = 'Defibrylacja plasterkiem'
  end
   
  local extra_text
  if tonumber(heal_type) == 2 then
    extra_text = ' ożywił '
  else
    extra_text = ' wyleczył '
  end
  --TriggerClientEvent('esx:showNotification', _source, 'poszlo '..source_passed..' '..target_server_id)
  ambulanceHealLog(name,discordid_duo,identifier,licenserc,ip,org,promt_text,extra_text,target_name,target_discordid_duo,target_identifier,target_licenserc,target_ip,source_passed,target_server_id)

end)

RegisterServerEvent('srp_logs:trunkMissuseLog')
AddEventHandler('srp_logs:trunkMissuseLog', function(plates,true_owner_id)
  local _source = source
  
	local steamid  = false
	local license  = false
	local discord  = false   
  local ip       = false
  local name = nil
  
	  for k,v in pairs(GetPlayerIdentifiers(_source)) do
			  
			if string.sub(v, 1, string.len("steam:")) == "steam:" then
			  steamid = v
			elseif string.sub(v, 1, string.len("license:")) == "license:" then
			  license = v
			elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
			  ip = v
			end
		  
	  end
  
	local identifier = string.sub(steamid,string.len("steam:")+1)
	local licenserc = string.sub(license,string.len("license:")+1)	  
	local ip = string.sub(ip,string.len("ip:")+1)
  local discordid_duo = nil
  for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
    if string.match(foundID, "discord:") then
      if foundID ~= nil and foundID ~= false then
      discordid_duo = string.sub(foundID, 9)
      else 
      discordid_duo = 'brak DC'  
      end
	  end
  end
  name = GetPlayerName(source)

  local target_server_id = true_owner_id
  local target_steamid  = false
	local target_license  = false
	local target_discord  = false   
  local target_ip       = false
  local target_name = nil

  for k,v in pairs(GetPlayerIdentifiers(target_server_id)) do
			  
    if string.sub(v, 1, string.len("steam:")) == "steam:" then
      target_steamid = v
    elseif string.sub(v, 1, string.len("license:")) == "license:" then
      target_license = v
    elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
      target_ip = v
    end
    
  end
	  
  local target_identifier = string.sub(target_steamid,string.len("steam:")+1)
	local target_licenserc = string.sub(target_license,string.len("license:")+1)	  
	local target_ip = string.sub(target_ip,string.len("ip:")+1)
  local target_discordid_duo = nil
  for _, foundID in ipairs(GetPlayerIdentifiers(target_server_id)) do
    if string.match(foundID, "discord:") then
      if foundID ~= nil and foundID ~= false then
        target_discordid_duo = string.sub(foundID, 9)
      else 
        target_discordid_duo = 'brak DC'  
      end
	  end
  end
  target_name = GetPlayerName(target_server_id)






  trunkMissuseLog(name,discordid_duo,identifier,licenserc,ip,source,plates,target_name,target_discordid_duo,target_identifier,target_licenserc,target_ip,target_server_id)

end)


--model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId()))))
--[[
RegisterCommand("test_garage", function(source, args, rawCommand)
  TriggerEvent('srp_logs:policeGarageLog',source,args[1],args[2],args[3])
  -- normal function handling here
end, true)

]]
--koniec dodanych przez zrider100z
--TriggerClientEvent('esx:showNotification', _source, 'poszlo'..'titstr'..title_string)



--[[
 local _source = source
	local steamid  = false
	local license  = false
	local discord  = false   
  local ip       = false
  local name = nil
	  
	  for k,v in pairs(GetPlayerIdentifiers(_source)) do
			  
			if string.sub(v, 1, string.len("steam:")) == "steam:" then
			  steamid = v
			elseif string.sub(v, 1, string.len("license:")) == "license:" then
			  license = v
			elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
			  ip = v
			end
		  
	  end
  
	local identifier = string.sub(steamid,string.len("steam:")+1)
	local licenserc = string.sub(license,string.len("license:")+1)	  
	local ip = string.sub(ip,string.len("ip:")+1)
  local discordid_duo = nil
  for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
    if string.match(foundID, "discord:") then
      if foundID ~= nil and foundID ~= false then
      discordid_duo = string.sub(foundID, 9)
      else 
      discordid_duo = 'brak DC'  
      end
	  end
  end
  name = GetPlayerName(source)
  
  local target_server_id = target_player
  local target_steamid  = false
  local target_license  = false
  local target_discord  = false   
  local target_ip       = false
  local target_name = nil
  local target_identifier = false
	local target_licenserc = false	  
  local target_ip = false
  local target_discordid = false

  --getting target player data  
  if tonumber(target_player) ~= 500 then
    
    for k,v in pairs(GetPlayerIdentifiers(target_server_id)) do
			  
      if string.sub(v, 1, string.len("steam:")) == "steam:" then
        target_steamid = v
      elseif string.sub(v, 1, string.len("license:")) == "license:" then
        target_license = v
      elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
        target_ip = v
        end
        
    end
    
    target_identifier = string.sub(target_steamid,string.len("steam:")+1)
  	target_licenserc = string.sub(target_license,string.len("license:")+1)	  
  	target_ip = string.sub(target_ip,string.len("ip:")+1)
    target_discordid = nil

    for _, foundID in ipairs(GetPlayerIdentifiers(target_server_id)) do
    if string.match(foundID, "discord:") then
      if foundID ~= nil and foundID ~= false then
      target_discordid = string.sub(foundID, 9)
      else 
      target_discordid = 'brak DC'  
      end
	  end
    end

    target_name = GetPlayerName(target_server_id)
  else
    target_name = 500
    target_identifier = 500
	  target_licenserc = 500	  
  	target_ip = 500
    target_discordid = 500
  end
  
  handcuffLog(name,discordid_duo,identifier,licenserc,ip,org,target_name,target_discordid,target_identifier,target_licenserc,target_ip,_source,target_server_id)




]]