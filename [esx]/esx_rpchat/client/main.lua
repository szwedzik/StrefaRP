ESX                           = nil
local PlayerData              = {}
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('anonTweet')
AddEventHandler('anonTweet', function(id, name, message, police)
	local myId = PlayerId()
	local pid = GetPlayerFromServerId(id)
	if(pid == myId) then 
		TriggerEvent('chatMessage', "", {30, 144,255}, " Anonim ~> ^7  ".."^7 " .. message)
	elseif(pid ~= myId) then 
		TriggerEvent('chatMessage', "", {30, 144, 255}," Anonim ~> ^7  ".."^7 " .. message) 
	end
end)

function string.starts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

RegisterNetEvent('sendProximityMessage')
AddEventHandler('sendProximityMessage', function(id, name, message, source)
	local myId = PlayerId()
	local pid = GetPlayerFromServerId(id)
	if pid == myId then
		if string.starts(string.lower(message), "xd") then
			TriggerServerEvent("esx_rpchat:kick")
		end
		TriggerEvent('chat:addMessage',  { templateId = 'localooc', multiline = true, args = {  "[ LOCAL OOC ] " .. name, message } })
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
		TriggerEvent('chat:addMessage',  { templateId = 'localooc', multiline = true, args = {  "[ LOCAL OOC ] " .. name, message } })
	end
end)

RegisterNetEvent('sendProximityMessageMe3D')
AddEventHandler('sendProximityMessageMe3D', function(id, message)
	if GetPlayerFromServerId(id) == PlayerId() then
		TriggerServerEvent('3dme:shareDisplayMe', message)
		if string.starts(string.lower(message), "solo") then
			TriggerServerEvent("esx_rpchat:kick")
		end
	end
end)

RegisterNetEvent('sendProximityMessageMe')
AddEventHandler('sendProximityMessageMe', function(id, name, message)
	local myId = PlayerId()
	local pid = GetPlayerFromServerId(id)
	if pid == myId then
		TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6 " .. name .." ".."^6 " .. message)
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
		TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6 " .. name .." ".."^6 " .. message)
	end
end)

RegisterNetEvent('sendProximityMessageDo')
AddEventHandler('sendProximityMessageDo', function(id, name, message)
	local myId = PlayerId()
	local pid = GetPlayerFromServerId(id)
	if pid == myId then
		TriggerEvent('chatMessage', "", {255, 0, 0}, " ^0* " .. name .."  ".."^0  " .. message)
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
		TriggerEvent('chatMessage', "", {255, 0, 0}, " ^0* " .. name .."  ".."^0  " .. message)
	end
end)

RegisterNetEvent('sendProximityMessageMed')
AddEventHandler('sendProximityMessageMed', function(id, name, message)
	local myId = PlayerId()
	local pid = GetPlayerFromServerId(id)
	if pid == myId then
		TriggerEvent('chat:addMessage',  { templateId = 'med', multiline = true, args = {  " [" .. id .."] " .. name.. ":", message } })
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 10.999 then
		TriggerEvent('chat:addMessage',  { templateId = 'med', multiline = true, args = {  " [" .. id .."] " .. name ..":", message } })
	end
end)

RegisterNetEvent('sendProximityCmdMessage')
AddEventHandler('sendProximityCmdMessage', function(id, name, message)
	local myId = PlayerId()
	local pid = GetPlayerFromServerId(id)
	if pid == myId then
		TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6 " .. name .." ".."^6 " .. message)
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
		TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6 " .. name .." ".."^6 " .. message)
	end
end)
