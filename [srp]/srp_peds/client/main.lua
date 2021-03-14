local Keys = {
	["ESC"] = 322, ["BACKSPACE"] = 177, ["E"] = 38, ["X"] = 73, ["H"] = 74,	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173
}


local pedd = vector3(871.27, -2312.76, 29.58)
local txt1 = false
local cooldown = false


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local coords = GetEntityCoords(PlayerPedId())
            if GetDistanceBetweenCoords(coords, pedd, true) <= 1.2 then
                if cooldown == false then
                    DrawText3D(pedd.x, pedd.y, pedd.z+1.0, "~g~[E] ~w~Aby porozmawiać")
                end
            end
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords = GetEntityCoords(GetPlayerPed(-1))
        local isNearInformator = false

        if GetDistanceBetweenCoords(coords, pedd, true) <= 1.2 then
            if IsControlJustReleased(0, Keys['E']) and cooldown == false then
                txt1 = true
                cooldown = true
                Citizen.Wait(5000)
                txt1 = false
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local pedcoords = GetEntityCoords(PlayerPedId())
        if txt1 == true then
            if GetDistanceBetweenCoords(pedcoords, pedd, false) <= 5 then
                DrawText3D(pedd.x, pedd.y, pedd.z+2.0, "~w~Zdobędę dla Ciebie te informacje...")
                DrawText3D(pedd.x, pedd.y, pedd.z+1.9, "~w~Ale będzie Cię to drogo kosztować... Przynieś mi try tysiące a zobaczę co da się zrobić...")
            end
        end
    end
end)

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

local ped = nil
local pe = nil
function spawnped(x, y, z, h, p)
	pe = p
	RequestModel(GetHashKey(pe))
    while not HasModelLoaded(GetHashKey(pe)) do
	    Wait(155)
    end
    ped =  CreatePed(4, GetHashKey(pe), x, y, z, h, false, true)
	FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	SetEntityHeading(ped, h)
end

Citizen.CreateThread(function()
    --[Funkcja odpowiedzialna za pedy informatorów]--
    spawnped(pedd.x, pedd.y, pedd.z, 26.45, "s_m_m_migrant_01")
end)