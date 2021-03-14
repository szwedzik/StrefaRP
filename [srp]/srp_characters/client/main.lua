--[[
Name: srp_characters
Author: Ezi - Ezi#0001
Version: v0.01.3612
Date: 22/06/2019 - 13:32
]]--

local Keys = {
	["ESC"] = 322, ["BACKSPACE"] = 177, ["E"] = 38, ["X"] = 73, ["ENTER"] = 18,	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173
}

ESX = nil
local HasAlreadyEnteredMarker = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end
end)
--------- Markery
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local coords = GetEntityCoords(GetPlayerPed(-1))
        for k,v in pairs(Config.Zones) do
            for i = 1, #v.Pos, 1 do
                if(Config.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < Config.DrawDistance) then
                    DrawMarker(Config.Type, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
                    if GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, false) <= 2 then
                        DrawText3D(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z+1.2, "~g~[E] ~w~Aby zmienić postać")
                    end
                end
            end
        end
    end
end)
------------------ Blipy
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(-497.83, -335.93, 33.5)
	SetBlipSprite (blip, 480)
	SetBlipDisplay(blip, 2)
	SetBlipScale  (blip, 0.8)
	SetBlipColour (blip, 28)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Operacja Plastyczna")
	EndTextCommandSetBlipName(blip)
end)
-----------Wszedl / Wyszedl z markera
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords = GetEntityCoords(GetPlayerPed(-1))
        local isInMarker = false
        local source = GetPlayerServerId(PlayerId())

		for k,v in pairs(Config.Zones) do
			for i = 1, #v.Pos, 1 do
				if(GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < Config.Size.x) then
                    isInMarker  = true
                    if IsControlJustReleased(0, Keys['E']) then
                        local playerName = GetPlayerName(PlayerId())
                        local getPlayerRadioChannel = exports.tokovoip_script:getPlayerData(playerName, "radio:channel")
                        if getPlayerRadioChannel ~= "nil" then
                            exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
                            exports.tokovoip_script:setPlayerData(playerName, "radio:channel", "nil", true)
                        end
                        exports['mythic_progbar']:Progress({
                            name = "change_character",
                            duration = 15000,
                            label = "Zmiana postaci...",
                            useWhileDead = false,
                            canCancel = true,
                            controlDisables = {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }
                        })
                        --FreezeEntityPosition(GetPlayerPed(-1), true)
                        Citizen.Wait(15000)
                        TriggerServerEvent('srp_charsave', source, coords) 
                        TriggerEvent('kashactersC:ReloadCharacters')
                        --TriggerEvent('kashactersC:Skinchanger', source)
                    end
				end
			end
		end
	end
end)
--------- Tekst 3d nad markerami
function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 90)
end
--[[
RegisterCommand('test', function()
    local coords = GetEntityCoords(GetPlayerPed(-1))
    local source = GetPlayerServerId(PlayerId())
    TriggerServerEvent('srp_charsave', source, coords) 
    TriggerEvent('kashactersC:ReloadCharacters')
end)
--]]

    