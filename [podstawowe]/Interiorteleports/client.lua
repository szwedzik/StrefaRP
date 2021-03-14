POS_actual = 1
PED_hasBeenTeleported = false

function teleport(pos)
    local ped = GetPlayerPed(-1)
    Citizen.CreateThread(function()
        PED_hasBeenTeleported = true
        NetworkFadeOutEntity(ped, true, false)
        Citizen.Wait(700)
        SetEntityCoords(ped, pos.x, pos.y, pos.z + 0.3, 1, 0, 0, 1)
        DoScreenFadeOut(20)
        while not IsScreenFadedOut() do
                Citizen.Wait(0)
        end
        Citizen.Wait(900)
        DoScreenFadeIn(1800)
        SetEntityHeading(ped, pos.h)
        NetworkFadeInEntity(ped, 0)
        SetEntityCoords(ped, pos.x, pos.y, pos.z + 0.3, 1, 0, 0, 1)
        PED_hasBeenTeleported = false
    end)
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.50, 0.50)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.016, 0.025+ factor, 0.03, 41, 11, 41, 68)
end
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = GetPlayerPed(-1)
        local playerPos = GetEntityCoords(ped, true)
        for i,pos in pairs(INTERIORS) do
            if (Vdist(playerPos.x, playerPos.y, playerPos.z, pos.x, pos.y, pos.z) < 1.0) and (not PED_hasBeenTeleported) then
                POS_actual = pos.id
               DrawText3Ds(pos.x, pos.y, pos.z+0.5, "[~g~E~w~] Wejdź")
                if not gui_interiors.opened then
                    gui_interiors_OpenMenu()
                end
            end
        end
    end
end)