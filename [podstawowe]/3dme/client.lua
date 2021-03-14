local color = {r = 37, g = 175, b = 134, alpha = 255}
local color2 = {r = 37, g = 175, b = 134, alpha = 255}
local font = 0
local time = 15000
local nbrDisplaying = 0

RegisterCommand('me', function(source, args)
    local text = '* '
    for i = 1,#args do
        text = text .. ' ' .. args[i]
    end
    text = text .. ' *'
	 TriggerServerEvent('3dme:shareDisplayMe', text)
end)

RegisterCommand('localooc', function(source, args)
    local text = 'OOC: '
    for i = 1,#args do
        text = text .. ' ' .. args[i]
    end
    text = text
	 TriggerServerEvent('3dme:shareDisplayLocal', text)
end)

RegisterCommand('do', function(source, args)
    local text = '* '
    for i = 1,#args do
        text = text .. ' ' .. args[i]
    end
    text = text .. ' *'
    TriggerServerEvent('3dme:shareDisplayDo', text)
end)

RegisterNetEvent('3dme:triggerDisplayMe')
AddEventHandler('3dme:triggerDisplayMe', function(text, source)
    local offset = 1 + (nbrDisplaying*0.14)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(source)
	if pid == myId then
		DisplayMe(GetPlayerFromServerId(source), text, offset)
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
		DisplayMe(GetPlayerFromServerId(source), text, offset)
	end
end)

RegisterNetEvent('3dme:triggerDisplayDo')
AddEventHandler('3dme:triggerDisplayDo', function(text, source)
    local offset = 1 + (nbrDisplaying*0.14)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(source)
	if pid == myId then
		DisplayDo(GetPlayerFromServerId(source), text, offset)
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
		DisplayDo(GetPlayerFromServerId(source), text, offset)
	end
end)

RegisterNetEvent('3dme:triggerDisplayLocal')
AddEventHandler('3dme:triggerDisplayLocal', function(text, source)
    local offset = 0.2 + (nbrDisplaying*0.14)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(source)
	if pid == myId then
		DisplayMe(GetPlayerFromServerId(source), text, offset)
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
		DisplayMe(GetPlayerFromServerId(source), text, offset)
	end
end)


function DisplayMe(mePlayer, text, offset)
    local displaying = true
    Citizen.CreateThread(function()
        Wait(time)
        displaying = false
    end)
    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        while displaying do
            Wait(0)
            local coords = GetEntityCoords(GetPlayerPed(mePlayer), false)
            DrawText3Dme(coords['x'], coords['y'], coords['z']+offset, text)
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end

function DisplayDo(mePlayer, text, offset)
    local displaying = true
    Citizen.CreateThread(function()
        Wait(time)
        displaying = false
    end)
    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        while displaying do
            Wait(0)
            local coords = GetEntityCoords(GetPlayerPed(mePlayer), false)
            DrawText3Ddo(coords['x'], coords['y'], coords['z']+offset, text)
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end

function DrawText3Dme(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.40, 0.40)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function DrawText3Ddo(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.40, 0.40)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(0, 0, 0, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 255, 255, 255, 68)
end

function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
    N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - 0.1+w, y - 0.02+h)
end

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(color.r, color.g, color.b, color.alpha)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(true)
        AddTextComponentString(text)
        EndTextCommandDisplayText(_x, _y)
    end
end