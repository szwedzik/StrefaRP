--[[
 ___________________________________________________________________________________
|																					|
|							Script Created by: Johnny2525							|
|						Mail: johnny2525.contact@gmail.com							|
|		Linked-In: https://www.linkedin.com/in/jakub-barwi%C5%84ski-09617b164/		|
|___________________________________________________________________________________|

--]]

local LicenseList = {}
RegisterNetEvent('showid:loadLicenses')
AddEventHandler('showid:loadLicenses', function (licenses)
	LicenseList = {}
  for i = 1, #licenses, 1 do
    LicenseList[licenses[i].type] = true
  end
end)

RegisterNetEvent('showid:DisplayId')
AddEventHandler('showid:DisplayId', function(id, playerName, license, weapon, job)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent("pNotify:SendNotification", {
      text = "<font style='font-size: 16px'><div style='min-width: 514px; min-height: 274px; background-image: url(https://i.imgur.com/XfSjZOY.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'><div style='position: absolute; top: 100px; left: 160px; color:#46192c'><B>Imię i nazwisko:</b> " ..playerName.." <BR><B>Zawód:</B> ".. job .. "<BR><BR><center>L I C E N C J E</CENTER><BR><B>Prawo jazdy:</b>" ..license.."<BR><B>Pozwolenie na broń:</b> "..weapon.."</div>",
      type = "info",
      queue = "global",
      timeout = 15000,
      layout = "centerLeft"
    }) 
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 2.9999 then
    TriggerEvent("pNotify:SendNotification", {
      text = "<font style='font-size: 16px'><div style='min-width: 514px; min-height: 274px; background-image: url(https://i.imgur.com/XfSjZOY.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'><div style='position: absolute; top: 100px; left: 160px; color:#46192c'><B>Imię i nazwisko:</b> " ..playerName.." <BR><BR><center>L I C E N C J E</CENTER><BR><B>Prawo jazdy:</b>" ..license.."<BR><B>Pozwolenie na broń:</b> "..weapon.."</div>",
      type = "info",
      queue = "global",
      timeout = 15000,
      layout = "centerLeft"
    })
  end
end)

RegisterNetEvent('showid:DisplayLSPD')
AddEventHandler('showid:DisplayLSPD', function(id, playerName, license, weapon, job, badge)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id) 

  if pid == myId then
    TriggerEvent("pNotify:SendNotification", {
      text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/nsBCJh8.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'><div style='position: relative; top:105px; color:#fff; text-shadow: 0px 0px 5px rgba(0, 0, 0, 1); line-height: 20px; font-family: Lato;'><CENTER>" ..playerName.." <BR><B>".. job .. "<BR>Numer odznaki: </b>"..badge.."</CENTER></div></div>",
      type = "info",
      queue = "global",
      timeout = 15000,
      layout = "centerLeft2"
    })
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 2.9999 then
    TriggerEvent("pNotify:SendNotification", {
      text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/nsBCJh8.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'><div style='position: relative; top:105px; color:#fff; text-shadow: 0px 0px 5px rgba(0, 0, 0, 1); line-height: 20px; font-family: Lato;'><CENTER>" ..playerName.." <BR><B>".. job .. "<BR>Numer odznaki: </b>"..badge.."</CENTER></div></div>",
      type = "info",
      queue = "global",
      timeout = 15000,
      layout = "centerLeft2"
    })
  end
end)

RegisterNetEvent('showid:DisplayEMS')
AddEventHandler('showid:DisplayEMS', function(id, playerName, license, weapon, job, badge)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent("pNotify:SendNotification", {
      text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/KTULXPB.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'><div style='position: relative; top:155px; left: 60px; font-size: 24px; text-shadow: 0px 0px 0px rgba(0, 0, 0, 0); text-transform: uppercase; line-height: 20px; font-family: Lato; color: #cf3c56 !important;'><CENTER><B>NR" ..badge.." <BR></B></div><div style='position: relative; top:215px;  font-size: 20px; text-shadow: 0px 0px 0px rgba(0, 0, 0, 0); text-transform: uppercase; line-height: 20px; font-family: Lato; color: #fff !important;'><CENTER><B>".. job .. "<BR><BR><font style='font-family: courier; font-size: 20px;'>"..playerName.."</CENTER></font></div></div>", 
      type = "info",
      queue = "global",
      timeout = 15000,
      layout = "centerLeft2"
    })
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 2.9999 then
    TriggerEvent("pNotify:SendNotification", {
      text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/KTULXPB.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'><div style='position: relative; top:155px; left: 60px; font-size: 24px; text-shadow: 0px 0px 0px rgba(0, 0, 0, 0); text-transform: uppercase; line-height: 20px; font-family: Lato; color: #cf3c56 !important;'><CENTER><B>NR" ..badge.." <BR></B></div><div style='position: relative; top:215px;  font-size: 20px; text-shadow: 0px 0px 0px rgba(0, 0, 0, 0); text-transform: uppercase; line-height: 20px; font-family: Lato; color: #fff !important;'><CENTER><B>".. job .. "<BR><BR><font style='font-family: courier; font-size: 20px;'>"..playerName.."</CENTER></font></div></div>",          
      type = "info",
      queue = "global",
      timeout = 15000,
      layout = "centerLeft2"
    })
  end
end)