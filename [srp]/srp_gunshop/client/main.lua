--[[
Name: srp_gunshop
Author: Ezi - Ezi#0001
Version: v0.01.3612
Date: 20/06/2019 - 19:36
]]--
local Keys = {
	["ESC"] = 322, ["BACKSPACE"] = 177, ["E"] = 38, ["X"] = 73, ["H"] = 74,	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173
}
--[Globalne zmienne]--
ESX = nil
local Hasitems = false
local CoolDownInformator = false
local weaponbuttonH = false
local questinformator = false
local text1bait1 = false
local text1bait2 = false
local text1bait3 = false
local text1bait4 = false
local text1bait5 = false
local text1quest1 = false
local text1quest2 = false
local text1 = false
local text2 = false
local text3 = false
local text4 = false
local text5 = false
local text6 = false
local text7 = false
local text8 = false
local nopolice = false
local CanBuy = false
local Informator1 = vector3(-35.73, -2690.28, 5.01)
local Informator2 = vector3(576.14, -3124.36, 17.77)
local Informator3 = vector3(-1639.21, -1017.09, 5.31)
local Informator4 = vector3(-2.74, -1820.01, 28.54)
local Seller1 = vector3(463.39, 3553.72, 32.24)
local Seller2 = vector3(1508.22, 3573.78, 37.74)
local Seller3 = vector3(1343.02, 4381.86, 43.34)
local Seller4 = vector3(1901.55, 4925.12, 47.86)
local Seller5 = vector3(1524.18, -2139.92, 76.02)
local Seller6 = vector3(66.49, 6661.85, 30.79)
local Seller7 = vector3(-3428.33, 983.27, 7.35)
local Seller8 = vector3(657.32, 1285.38, 359.3)
local Seller9 = vector3(2475.84, 1605.41, 31.72)
local Seller10 = vector3(3819.42, 4445.44, 1.82)
local Seller11 = vector3(3611.65, 5026.76, 10.35)
local Seller12 = vector3(1444.06, 6332.22, 22.93)
local Seller13 = vector3(-681.01, 5802.2, 16.33)
local Seller14 = vector3(262.98, 2592.68, 43.94)
local Seller15 = vector3(846.78, 2121.52, 51.3)

----
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)
--[ Informator ]--
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local coords = GetEntityCoords(GetPlayerPed(-1))
        for k,v in pairs(Config.Zones) do
            for i = 1, #v.Pos, 1 do
                if(Config.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < 5) then
                    nodisplay = true
                    if GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, false) <= 0.7 then
                        if Hasitems == true and weaponbuttonH == true then
                            DrawText3D(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, "~g~[E] ~w~Aby porozmawiać~g~ [H] ~w~Aby wręczyć pieniądzę")
                        end
                        if Hasitems == true and weaponbuttonH == false then
                            DrawText3D(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, "~g~[E] ~w~Aby porozmawiać")
                        end

                        if Hasitems == false and weaponbuttonH == false then
                            DrawText3D(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, "~g~[E] ~w~Aby porozmawiać")
                        end
                        if Hasitems == false and weaponbuttonH == true then
                            DrawText3D(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, "~g~[E] ~w~Aby porozmawiać")
                        end
                    end
                end
            end
        end
    end
end)
---- Sprawdzanie czy gracz jest przy pedzie
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords = GetEntityCoords(GetPlayerPed(-1))
        local isNearInformator = false

		for k,v in pairs(Config.Zones) do
			for i = 1, #v.Pos, 1 do
                if(GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < 1.0) then
                    local inveh = IsPedInAnyVehicle(GetPlayerPed(-1), false)
                    isNearInformator  = true
                    if IsControlJustReleased(0, Keys['E']) and CoolDownInformator == false then
                        local random = math.random(1, 100)
                        if inveh then
                            exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                        elseif CoolDownInformator == true then
                            exports['mythic_notify']:DoCustomHudText('error', 'Nie rozmawiam z tobą, spadaj!', 3500)
                        elseif random >= 1 and random <= 13 then
                            text1bait1 = true
                            Citizen.Wait(4000)
                            text1bait1 = false
                            CoolDownInformator = true
                            Citizen.Wait(900000)
                            CoolDownInformator = false
                        elseif random >= 14 and random <= 27 then
                            text1bait2 = true
                            Citizen.Wait(4000)
                            text1bait2 = false
                            CoolDownInformator = true
                            Citizen.Wait(900000)
                            CoolDownInformator = false
                        elseif random >= 28 and random <= 40 then
                            text1bait3 = true
                            Citizen.Wait(4000)
                            text1bait3 = false
                            CoolDownInformator = true
                            Citizen.Wait(900000)
                            CoolDownInformator = false
                        elseif random >= 41 and random <= 55 then
                            text1bait4 = true
                            Citizen.Wait(4000)
                            text1bait4 = false
                            CoolDownInformator = true
                            Citizen.Wait(900000)
                            CoolDownInformator = false
                        elseif random >= 56 and random <= 69 then
                            text1bait5 = true
                            Citizen.Wait(4000)
                            text1bait5 = false

                            questinformator = true
                            CoolDownInformator = true
                            Citizen.Wait(900000)
                            CoolDownInformator = false
                        elseif random >= 70 then
                        text1 = true
                        Citizen.Wait(5000)
                        text1 = false
                        text2 = true
                        Citizen.Wait(5000)
                        text2 = false
                        text3 = true
                        Citizen.Wait(5000)
                        text3 = false
                        weaponbuttonH = true
                        CoolDownInformator = true
                        Citizen.Wait(900000)
                        CoolDownInformator = false
                        end
                    elseif IsControlJustReleased(0, Keys['H']) and questinformator == true then
                        if inveh then
                            exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                        else
                            text1quest1 = true
                            Citizen.Wait(3000)
                            text1quest1 = false
                            text1quest2 = true
                            Citizen.Wait(3000)
                            text1quest2 = false
                            questinformator = false
                        end
                    elseif IsControlJustReleased(0, Keys['H']) and Hasitems == true and weaponbuttonH == true then
                        if inveh then
                            exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                        else
                        TriggerServerEvent('srp_gunshop:removeMoney')
                        text4 = true
                        Citizen.Wait(5000)
                        text4 = false
                        text5 = true
                        Citizen.Wait(5000)
                        text5 = false
                        text6 = true
                        Citizen.Wait(5000)
                        text6 = false
                        text7 = true
                        Citizen.Wait(5000)
                        text7 = false
                        text8 = true
                        Citizen.Wait(2500)
                        text8 = false
                        CanBuy = true
                        start()
                        Citizen.Wait(900000)
                        CanBuy = false
                        end
                    end
				end
			end
		end
	end
end)
---- Sprawdzanie czy gracz ma wymagane przedmioty
RegisterNetEvent("srp_gunshop:Hasitems")
AddEventHandler("srp_gunshop:Hasitems", function(count)
    if count > 0 then
        Hasitems = true
    elseif count == 0 then
        Hasitems = false 
    end
end)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        TriggerServerEvent("srp_gunshop:Hasitems")
    end
end)

----- Tekts 3d nad glowa peda
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local pedcoords = GetEntityCoords(PlayerPedId())
        if text1bait1 == true then
            if GetDistanceBetweenCoords(pedcoords, Informator1, false) <= 5 then
                DrawText3D(Informator1.x, Informator1.y, Informator1.z+2, "~w~TEXT 1")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator2, false) <= 5 then
                DrawText3D(Informator2.x, Informator2.y, Informator2.z+2, "~w~TEXT 1")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator3, false) <= 5 then
                DrawText3D(Informator3.x, Informator3.y, Informator3.z+2, "~w~TEXT 1")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator4, false) <= 5 then
                DrawText3D(Informator4.x, Informator4.y, Informator4.z+2, "~w~TEXT 1")
            end
        end
        if text1bait2 == true then
            if GetDistanceBetweenCoords(pedcoords, Informator1, false) <= 5 then
                DrawText3D(Informator1.x, Informator1.y, Informator1.z+2, "~w~TEXT 2")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator2, false) <= 5 then
                DrawText3D(Informator2.x, Informator2.y, Informator2.z+2, "~w~TEXT 2")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator3, false) <= 5 then
                DrawText3D(Informator3.x, Informator3.y, Informator3.z+2, "~w~TEXT 2")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator4, false) <= 5 then
                DrawText3D(Informator4.x, Informator4.y, Informator4.z+2, "~w~TEXT 2")
            end
        end
        if text1bait3 == true then
            if GetDistanceBetweenCoords(pedcoords, Informator1, false) <= 5 then
                DrawText3D(Informator1.x, Informator1.y, Informator1.z+2, "~w~TEXT 3")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator2, false) <= 5 then
                DrawText3D(Informator2.x, Informator2.y, Informator2.z+2, "~w~TEXT 3")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator3, false) <= 5 then
                DrawText3D(Informator3.x, Informator3.y, Informator3.z+2, "~w~TEXT 3")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator4, false) <= 5 then
                DrawText3D(Informator4.x, Informator4.y, Informator4.z+2, "~w~TEXT 3")
            end
        end
        if text1bait4 == true then
            if GetDistanceBetweenCoords(pedcoords, Informator1, false) <= 5 then
                DrawText3D(Informator1.x, Informator1.y, Informator1.z+2, "~w~TEXT 4")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator2, false) <= 5 then
                DrawText3D(Informator2.x, Informator2.y, Informator2.z+2, "~w~TEXT 4")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator3, false) <= 5 then
                DrawText3D(Informator3.x, Informator3.y, Informator3.z+2, "~w~TEXT 4")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator4, false) <= 5 then
                DrawText3D(Informator4.x, Informator4.y, Informator4.z+2, "~w~TEXT 4")
            end
        end
        if text1bait5 == true then
            if GetDistanceBetweenCoords(pedcoords, Informator1, false) <= 5 then
                DrawText3D(Informator1.x, Informator1.y, Informator1.z+2, "~w~TEXT 5")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator2, false) <= 5 then
                DrawText3D(Informator2.x, Informator2.y, Informator2.z+2, "~w~TEXT 5")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator3, false) <= 5 then
                DrawText3D(Informator3.x, Informator3.y, Informator3.z+2, "~w~TEXT 5")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator4, false) <= 5 then
                DrawText3D(Informator4.x, Informator4.y, Informator4.z+2, "~w~TEXT 5")
            end
        end
        if text1quest1 == true then
            if GetDistanceBetweenCoords(pedcoords, Informator1, false) <= 5 then
                DrawText3D(Informator1.x, Informator1.y, Informator1.z+2, "~w~TEXT 1")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator2, false) <= 5 then
                DrawText3D(Informator2.x, Informator2.y, Informator2.z+2, "~w~TEXT 1")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator3, false) <= 5 then
                DrawText3D(Informator3.x, Informator3.y, Informator3.z+2, "~w~TEXT 1")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator4, false) <= 5 then
                DrawText3D(Informator4.x, Informator4.y, Informator4.z+2, "~w~TEXT 1")
            end
        end
        if text1quest2 == true then
            if GetDistanceBetweenCoords(pedcoords, Informator1, false) <= 5 then
                DrawText3D(Informator1.x, Informator1.y, Informator1.z+2, "~w~TEXT 2")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator2, false) <= 5 then
                DrawText3D(Informator2.x, Informator2.y, Informator2.z+2, "~w~TEXT 2")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator3, false) <= 5 then
                DrawText3D(Informator3.x, Informator3.y, Informator3.z+2, "~w~TEXT 2")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator4, false) <= 5 then
                DrawText3D(Informator4.x, Informator4.y, Informator4.z+2, "~w~TEXT 2")
            end
        end
        if text1 == true then
            if GetDistanceBetweenCoords(pedcoords, Informator1, false) <= 5 then
                DrawText3D(Informator1.x, Informator1.y, Informator1.z+2, "~w~A więc jesteś zainteresowany bronią? Znam kogoś kto może ją dla Ciebie zdobyć....")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator2, false) <= 5 then
                DrawText3D(Informator2.x, Informator2.y, Informator2.z+2, "~w~A więc jesteś zainteresowany bronią? Znam kogoś kto może ją dla Ciebie zdobyć....")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator3, false) <= 5 then
                DrawText3D(Informator3.x, Informator3.y, Informator3.z+2, "~w~A więc jesteś zainteresowany bronią? Znam kogoś kto może ją dla Ciebie zdobyć....")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator4, false) <= 5 then
                DrawText3D(Informator4.x, Informator4.y, Informator4.z+2, "~w~A więc jesteś zainteresowany bronią? Znam kogoś kto może ją dla Ciebie zdobyć....")
            end
        end
        if text2 == true then
            if GetDistanceBetweenCoords(pedcoords, Informator1, false) <= 5 then
                DrawText3D(Informator1.x, Informator1.y, Informator1.z+2, "~w~Ale nie ma nic za darmo... Najpierw muszisz coś dla mnie zrobić...")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator2, false) <= 5 then
                DrawText3D(Informator2.x, Informator2.y, Informator2.z+2, "~w~Ale nie ma nic za darmo... Najpierw muszisz coś dla mnie zrobić...")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator3, false) <= 5 then
                DrawText3D(Informator3.x, Informator3.y, Informator3.z+2, "~w~Ale nie ma nic za darmo... Najpierw muszisz coś dla mnie zrobić...")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator4, false) <= 5 then
                DrawText3D(Informator4.x, Informator4.y, Informator4.z+2, "~w~Ale nie ma nic za darmo... Najpierw muszisz coś dla mnie zrobić...")
            end
        end
        if text3 == true then
            if GetDistanceBetweenCoords(pedcoords, Informator1, false) <= 5 then
                DrawText3D(Informator1.x, Informator1.y, Informator1.z+2, "~w~Musisz przynieść mi 750.00$ w gotówce... Do zobaczenia...")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator2, false) <= 5 then
                DrawText3D(Informator2.x, Informator2.y, Informator2.z+2, "~w~Musisz przynieść mi 750.00$ w gotówce... Do zobaczenia...")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator3, false) <= 5 then
                DrawText3D(Informator3.x, Informator3.y, Informator3.z+2, "~w~Musisz przynieść mi 750.00$ w gotówce... Do zobaczenia...")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator4, false) <= 5 then
                DrawText3D(Informator4.x, Informator4.y, Informator4.z+2, "~w~Musisz przynieść mi 750.00$ w gotówce... Do zobaczenia...")
            end
        end
        if text4 == true then
            if GetDistanceBetweenCoords(pedcoords, Informator1, false) <= 5 then
                DrawText3D(Informator1.x, Informator1.y, Informator1.z+2, "~w~Przyniosłeś mi pieniądzę... Mam nadzieję że suma się zgadza...")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator2, false) <= 5 then
                DrawText3D(Informator2.x, Informator2.y, Informator2.z+2, "~w~Przyniosłeś mi pieniądzę... Mam nadzieję że suma się zgadza...")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator3, false) <= 5 then
                DrawText3D(Informator3.x, Informator3.y, Informator3.z+2, "~w~Przyniosłeś mi pieniądzę... Mam nadzieję że suma się zgadza...")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator4, false) <= 5 then
                DrawText3D(Informator4.x, Informator4.y, Informator4.z+2, "~w~Przyniosłeś mi pieniądzę... Mam nadzieję że suma się zgadza...")
            end
        end
        if text5 == true then
            if GetDistanceBetweenCoords(pedcoords, Informator1, false) <= 5 then
                DrawText3D(Informator1.x, Informator1.y, Informator1.z+2, "~w~Dobra... To teraz posłuchaj mnie uważnie... Gdzieś pod Paleto Bay")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator2, false) <= 5 then
                DrawText3D(Informator2.x, Informator2.y, Informator2.z+2, "~w~Dobra... To teraz posłuchaj mnie uważnie... Gdzieś pod Paleto Bay")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator3, false) <= 5 then
                DrawText3D(Informator3.x, Informator3.y, Informator3.z+2, "~w~Dobra... To teraz posłuchaj mnie uważnie... Gdzieś pod Paleto Bay")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator4, false) <= 5 then
                DrawText3D(Informator4.x, Informator4.y, Informator4.z+2, "~w~Dobra... To teraz posłuchaj mnie uważnie... Gdzieś pod Paleto Bay")
            end
        end
        if text6 == true then
            if GetDistanceBetweenCoords(pedcoords, Informator1, false) <= 5 then
                DrawText3D(Informator1.x, Informator1.y, Informator1.z+2, "~w~Znajdziesz kolesia który załatwi dla Ciebie to czego potrzebujesz...")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator2, false) <= 5 then
                DrawText3D(Informator2.x, Informator2.y, Informator2.z+2, "~w~Znajdziesz kolesia który załatwi dla Ciebie to czego potrzebujesz...")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator3, false) <= 5 then
                DrawText3D(Informator3.x, Informator3.y, Informator3.z+2, "~w~Znajdziesz kolesia który załatwi dla Ciebie to czego potrzebujesz...")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator4, false) <= 5 then
                DrawText3D(Informator4.x, Informator4.y, Informator4.z+2, "~w~Znajdziesz kolesia który załatwi dla Ciebie to czego potrzebujesz...")
            end
        end
        if text7 == true then
            if GetDistanceBetweenCoords(pedcoords, Informator1, false) <= 5 then
                DrawText3D(Informator1.x, Informator1.y, Informator1.z+2, "~w~Ale pamiętaj... Nigdy Cię nie widziałem i nigdy z Tobą nie rozmawiałem...")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator2, false) <= 5 then
                DrawText3D(Informator2.x, Informator2.y, Informator2.z+2, "~w~Ale pamiętaj... Nigdy Cię nie widziałem i nigdy z Tobą nie rozmawiałem...")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator3, false) <= 5 then
                DrawText3D(Informator3.x, Informator3.y, Informator3.z+2, "~w~Ale pamiętaj... Nigdy Cię nie widziałem i nigdy z Tobą nie rozmawiałem...")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator4, false) <= 5 then
                DrawText3D(Informator4.x, Informator4.y, Informator4.z+2, "~w~Ale pamiętaj... Nigdy Cię nie widziałem i nigdy z Tobą nie rozmawiałem...")
            end
        end
        if text8 == true then
            if GetDistanceBetweenCoords(pedcoords, Informator1, false) <= 5 then
                DrawText3D(Informator1.x, Informator1.y, Informator1.z+2, "~w~Powodzenia...")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator2, false) <= 5 then
                DrawText3D(Informator2.x, Informator2.y, Informator2.z+2, "~w~Powodzenia...")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator3, false) <= 5 then
                DrawText3D(Informator3.x, Informator3.y, Informator3.z+2, "~w~Powodzenia...")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator4, false) <= 5 then
                DrawText3D(Informator4.x, Informator4.y, Informator4.z+2, "~w~Powodzenia...")
            end
        end
        if nopolice == true then
            if GetDistanceBetweenCoords(pedcoords, Informator1, false) <= 5 then
                DrawText3D(Informator1.x, Informator1.y, Informator1.z+2, "~w~Z psami nie rozmawiam... Nie jestem kapusiem...")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator2, false) <= 5 then
                DrawText3D(Informator2.x, Informator2.y, Informator2.z+2, "~w~Z psami nie rozmawiam... Nie jestem kapusiem...")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator3, false) <= 5 then
                DrawText3D(Informator3.x, Informator3.y, Informator3.z+2, "~w~Z psami nie rozmawiam... Nie jestem kapusiem...")
            end
            if GetDistanceBetweenCoords(pedcoords, Informator4, false) <= 5 then
                DrawText3D(Informator4.x, Informator4.y, Informator4.z+2, "~w~Z psami nie rozmawiam... Nie jestem kapusiem...")
            end
        end
    end
end)


--[ Sprzedawca broni ]--
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local coords = GetEntityCoords(GetPlayerPed(-1))
        for k,v in pairs(Config.Seller) do
            for i = 1, #v.Pos, 1 do
                if(Config.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < 5) then
                    if GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, false) <= 1.5 then
                        if CanBuy == true then
                            DrawText3D(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, "~g~[E] ~w~Aby porozmawiać")
                        end
                    end
                end
            end
        end
    end
end)
---- Sprawdzanie czy gracz jest przy sprzedawcy
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		local isNearSeller = false

		for k,v in pairs(Config.Seller) do
			for i = 1, #v.Pos, 1 do
                if(GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < 5) then
                    local inveh = IsPedInAnyVehicle(GetPlayerPed(-1), false)
                    isNearSeller  = true
                    if IsControlJustReleased(0, Keys['E']) then
                        if CanBuy == true then
                            if inveh then
                                exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                            else
                            print("[DEBUG] Znajdujesz sie przy sprzedawcy broni!")
                            OpenBlackWeaponMenu()
                            end
                        end
                    end
				end
			end
		end
	end
end)

function OpenBlackWeaponMenu()
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'gunshop',
		{
			title    = 'Wybierz broń',
			elements = {
                {label = '------🔫 <font color="lime">Pistolety</font> 🔫------', value = 'XD'},
                {label = 'Pukawka - $<font color="orange">2900</font>', value = 'snspistol'},
                {label = 'Pistolet - $<font color="orange">3200</font>', value = 'pistol'},
                {label = 'Pistolet Bojowy - $<font color="orange">4200</font>', value = 'combatpistol'},
                {label = 'Ciężki Pistolet - $<font color="orange">5500</font>', value = 'heavypistol'},
                --{label = 'Desert Eagle - $<font color="orange">10200</font>', value = 'pistol50'},
                {label = '------🔪 <font color="lime">Broń Biała</font> 🔪------', value = 'XD'},
                {label = 'Nóż - $<font color="orange">750</font>', value = 'knife'},
                {label = 'Młotek - $<font color="orange">500</font>', value = 'hammer'},
                {label = 'Kastet - $<font color="orange">450</font>', value = 'knuckle'},
                {label = 'Siekiera - $<font color="orange">850</font>', value = 'hatchet'},
                {label = 'Kij Bejsbolowy - $<font color="orange">350</font>', value = 'bat'},
                {label = 'Maczeta - $<font color="orange">900</font>', value = 'machete'},
                {label = '------🏐 <font color="lime">Broń Miotana</font> 🏐------', value = 'XD'},
                {label = 'Piłka - $<font color="orange">150</font>', value = 'ball'},
                {label = 'Flara - $<font color="orange">100</font>', value = 'flare'}
			}
		},
        function(data, menu)
            if data.current.value == 'snspistol' then
                print("[DEBUG] SNS Pistol")
                exports['mythic_notify']:DoCustomHudText('success', 'Kupiłeś Pukawkę', 3500)
                TriggerServerEvent('srp_gunshop:sellsnspistol')
                RemoveBlip(blip)
                ESX.UI.Menu.CloseAll()
                Citizen.Wait(900000)
                CanBuy = false
            end	
            if data.current.value == 'pistol' then
                print("[DEBUG] Pistol")
                exports['mythic_notify']:DoCustomHudText('success', 'Kupiłeś Pistolet', 3500)
                TriggerServerEvent('srp_gunshop:sellpistol')
                RemoveBlip(blip)
                ESX.UI.Menu.CloseAll()
                Citizen.Wait(900000)
                CanBuy = false
            end
			if data.current.value == 'combatpistol' then
                print("[DEBUG] Combat Pistol")
                exports['mythic_notify']:DoCustomHudText('success', 'Kupiłeś Pistolet Bojowy', 3500)
                TriggerServerEvent('srp_gunshop:sellcombatpistol')
                RemoveBlip(blip)
                ESX.UI.Menu.CloseAll()
                Citizen.Wait(900000)
                CanBuy = false
            end	
            if data.current.value == 'heavypistol' then
                print("[DEBUG] Heavy Pistol")
                exports['mythic_notify']:DoCustomHudText('success', 'Kupiłeś Cięzki Pistolet', 3500)
                TriggerServerEvent('srp_gunshop:sellheavypistol')
                RemoveBlip(blip)
                ESX.UI.Menu.CloseAll()
                Citizen.Wait(900000)
                CanBuy = false
            end	
            if data.current.value == 'pistol50' then
                print("[DEBUG] Desert Eagle")
                exports['mythic_notify']:DoCustomHudText('success', 'Kupiłeś Desert Eagle', 3500)
                TriggerServerEvent('srp_gunshop:sellpistol50')
                RemoveBlip(blip)
                ESX.UI.Menu.CloseAll()
                Citizen.Wait(900000)
                CanBuy = false
            end	
            if data.current.value == 'knife' then
                print("[DEBUG] Nóz")
                exports['mythic_notify']:DoCustomHudText('success', 'Kupiłeś Nóż', 3500)
                TriggerServerEvent('srp_gunshop:sellknife')
                RemoveBlip(blip)
                ESX.UI.Menu.CloseAll()
                Citizen.Wait(900000)
                CanBuy = false
            end	
            if data.current.value == 'hammer' then
                print("[DEBUG] Młotek")
                exports['mythic_notify']:DoCustomHudText('success', 'Kupiłeś Młotek', 3500)
                TriggerServerEvent('srp_gunshop:sellhammer')
                RemoveBlip(blip)
                ESX.UI.Menu.CloseAll()
                Citizen.Wait(900000)
                CanBuy = false
            end	
            if data.current.value == 'knuckle' then
                print("[DEBUG] Kastet")
                TriggerServerEvent('srp_gunshop:sellknuckle')
                exports['mythic_notify']:DoCustomHudText('success', 'Kupiłeś Kastet', 3500)
                RemoveBlip(blip)
                ESX.UI.Menu.CloseAll()
                Citizen.Wait(900000)
                CanBuy = false
            end	
            if data.current.value == 'hatchet' then
                print("[DEBUG] Siekiera")
                TriggerServerEvent('srp_gunshop:sellhatchet')
                exports['mythic_notify']:DoCustomHudText('success', 'Kupiłeś Siekierę', 3500)
                RemoveBlip(blip)
                ESX.UI.Menu.CloseAll()
                Citizen.Wait(900000)
                CanBuy = false
            end	
            if data.current.value == 'bat' then
                print("[DEBUG] Kij Bejsbolowy")
                TriggerServerEvent('srp_gunshop:sellbat')
                exports['mythic_notify']:DoCustomHudText('success', 'Kupiłeś Kij Bejsbolowy', 3500)
                RemoveBlip(blip)
                ESX.UI.Menu.CloseAll()
                Citizen.Wait(900000)
                CanBuy = false
            end	
            if data.current.value == 'machete' then
                print("[DEBUG] Maczeta")
                TriggerServerEvent('srp_gunshop:sellmachete')
                exports['mythic_notify']:DoCustomHudText('success', 'Kupiłeś Maczetę', 3500)
                RemoveBlip(blip)
                ESX.UI.Menu.CloseAll()
                Citizen.Wait(900000)
                CanBuy = false
            end	
            if data.current.value == 'ball' then
                print("[DEBUG] Piłka")
                TriggerServerEvent('srp_gunshop:sellball')
                exports['mythic_notify']:DoCustomHudText('success', 'Kupiłeś Piłkę', 3500)
                RemoveBlip(blip)
                ESX.UI.Menu.CloseAll()
                Citizen.Wait(900000)
                CanBuy = false
            end	
            if data.current.value == 'flare' then
                print("[DEBUG] Flara")
                TriggerServerEvent('srp_gunshop:sellflare')
                exports['mythic_notify']:DoCustomHudText('success', 'Kupiłeś Flarę', 3500)
                RemoveBlip(blip)
                ESX.UI.Menu.CloseAll()
                Citizen.Wait(900000)
                CanBuy = false
            end	
            menu.close()
		end,
		function(data, menu)
			menu.close()
		end
    )
end

--[Inne funkcje]--
---- Tekst 3D
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

---- Funkcja respienia peda
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
function spawnpedoprzyj(x, y, z, h, p)
	pe = p
	RequestModel(GetHashKey(pe))
    while not HasModelLoaded(GetHashKey(pe)) do
	    Wait(155)
    end
    ped =  CreatePed(4, GetHashKey(pe), x, y, z, h, false, true)
    RequestAnimDict('amb@world_human_leaning@female@wall@back@holding_elbow@idle_b')
    TaskPlayAnim(ped, 'amb@world_human_leaning@female@wall@back@holding_elbow@idle_b', 'idle_d', 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
	FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	SetEntityHeading(ped, h)
end
Citizen.CreateThread(function()
    ---- Informator 
    spawnpedoprzyj(Informator1.x, Informator1.y, Informator1.z, 356.01, "s_m_y_xmech_02")
    spawnpedoprzyj(Informator2.x, Informator2.y, Informator2.z, 89.65, "s_m_y_xmech_02")
    spawnped(Informator3.x, Informator3.y, Informator3.z, 99.32, "s_m_y_xmech_02")
    spawnped(Informator4.x, Informator4.y, Informator4.z, 191.92, "s_m_y_xmech_02")
    ---- Sprzedawca Broni
    spawnped(Seller1.x, Seller1.y, Seller1.z, 273.15, "mp_m_exarmy_01") 
    spawnped(Seller2.x, Seller2.y, Seller2.z, 235.91, "mp_m_exarmy_01")
    spawnped(Seller3.x, Seller3.y, Seller3.z, 347.94, "mp_m_exarmy_01")
    spawnped(Seller4.x, Seller4.y, Seller4.z, 194.46, "mp_m_exarmy_01")
    spawnped(Seller5.x, Seller5.y, Seller5.z, 110.78, "mp_m_exarmy_01")
    spawnped(Seller6.x, Seller6.y, Seller6.z, 11.21, "mp_m_exarmy_01")
    spawnped(Seller7.x, Seller7.y, Seller7.z, 235.91, "mp_m_exarmy_01")
    spawnped(Seller8.x, Seller8.y, Seller8.z, 267.03, "mp_m_exarmy_01")
    spawnped(Seller9.x, Seller9.y, Seller9.z, 95.73, "mp_m_exarmy_01")
    spawnped(Seller10.x, Seller10.y, Seller10.z, 182.71, "mp_m_exarmy_01")
    spawnped(Seller11.x, Seller11.y, Seller11.z, 235.91, "mp_m_exarmy_01")
    spawnped(Seller12.x, Seller12.y, Seller12.z, 53.01, "mp_m_exarmy_01")
    spawnped(Seller13.x, Seller13.y, Seller13.z, 153.66, "mp_m_exarmy_01")
    spawnped(Seller14.x, Seller14.y, Seller14.z, 194.22, "mp_m_exarmy_01")
    spawnped(Seller15.x, Seller15.y, Seller15.z, 130.39, "mp_m_exarmy_01")
end)
---- Losowanie w ktorym miejscu zrespi sie ped
function start()
    local random = math.random(1,15)
    if random == 1 then
        SetNewWaypoint(Seller1)
        blip = AddBlipForCoord(Seller1)
        SetBlipSprite(blip, 110)
        SetBlipScale(blip, 1.2)
        SetBlipColour(blip, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Handlarz bronią')
        EndTextCommandSetBlipName(blip)
        Citizen.Wait(900000)
        RemoveBlip(blip)
    elseif random == 2 then
        SetNewWaypoint(Seller2)
        blip = AddBlipForCoord(Seller2)
        SetBlipSprite(blip, 110)
        SetBlipScale(blip, 1.2)
        SetBlipColour(blip, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Handlarz bronią')
        EndTextCommandSetBlipName(blip)
        Citizen.Wait(900000)
        RemoveBlip(blip)
    elseif random == 3 then
        SetNewWaypoint(Seller3)
        blip = AddBlipForCoord(Seller3)
        SetBlipSprite(blip, 110)
        SetBlipScale(blip, 1.2)
        SetBlipColour(blip, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Handlarz bronią')
        EndTextCommandSetBlipName(blip)
        Citizen.Wait(900000)
        RemoveBlip(blip)
    elseif random == 4 then
        SetNewWaypoint(Seller4)
        blip = AddBlipForCoord(Seller4)
        SetBlipSprite(blip, 110)
        SetBlipScale(blip, 1.2)
        SetBlipColour(blip, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Handlarz bronią')
        EndTextCommandSetBlipName(blip)
        Citizen.Wait(900000)
        RemoveBlip(blip)
    elseif random == 5 then
        SetNewWaypoint(Seller5)
        blip = AddBlipForCoord(Seller5)
        SetBlipSprite(blip, 110)
        SetBlipScale(blip, 1.2)
        SetBlipColour(blip, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Handlarz bronią')
        EndTextCommandSetBlipName(blip)
        Citizen.Wait(900000)
        RemoveBlip(blip)
    elseif random == 6 then
        SetNewWaypoint(Seller6)
        blip = AddBlipForCoord(Seller6)
        SetBlipSprite(blip, 110)
        SetBlipScale(blip, 1.2)
        SetBlipColour(blip, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Handlarz bronią')
        EndTextCommandSetBlipName(blip)
        Citizen.Wait(900000)
        RemoveBlip(blip)
    elseif random == 7 then
        SetNewWaypoint(Seller7)
        blip = AddBlipForCoord(Seller7)
        SetBlipSprite(blip, 110)
        SetBlipScale(blip, 1.2)
        SetBlipColour(blip, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Handlarz bronią')
        EndTextCommandSetBlipName(blip)
        Citizen.Wait(900000)
        RemoveBlip(blip)
    elseif random == 8 then
        SetNewWaypoint(Seller8)
        blip = AddBlipForCoord(Seller8)
        SetBlipSprite(blip, 110)
        SetBlipScale(blip, 1.2)
        SetBlipColour(blip, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Handlarz bronią')
        EndTextCommandSetBlipName(blip)
        Citizen.Wait(900000)
        RemoveBlip(blip)
    elseif random == 9 then
        SetNewWaypoint(Seller9)
        blip = AddBlipForCoord(Seller9)
        SetBlipSprite(blip, 110)
        SetBlipScale(blip, 1.2)
        SetBlipColour(blip, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Handlarz bronią')
        EndTextCommandSetBlipName(blip)
        Citizen.Wait(900000)
        RemoveBlip(blip)
    elseif random == 10 then
        SetNewWaypoint(Seller10)
        blip = AddBlipForCoord(Seller10)
        SetBlipSprite(blip, 110)
        SetBlipScale(blip, 1.2)
        SetBlipColour(blip, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Handlarz bronią')
        EndTextCommandSetBlipName(blip)
        Citizen.Wait(900000)
        RemoveBlip(blip)
    elseif random == 11 then
        SetNewWaypoint(Seller11)
        blip = AddBlipForCoord(Seller11)
        SetBlipSprite(blip, 110)
        SetBlipScale(blip, 1.2)
        SetBlipColour(blip, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Handlarz bronią')
        EndTextCommandSetBlipName(blip)
        Citizen.Wait(900000)
        RemoveBlip(blip)
    elseif random == 12 then
        SetNewWaypoint(Seller12)
        blip = AddBlipForCoord(Seller12)
        SetBlipSprite(blip, 110)
        SetBlipScale(blip, 1.2)
        SetBlipColour(blip, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Handlarz bronią')
        EndTextCommandSetBlipName(blip)
        Citizen.Wait(900000)
        RemoveBlip(blip)
    elseif random == 13 then
        SetNewWaypoint(Seller13)
        blip = AddBlipForCoord(Seller13)
        SetBlipSprite(blip, 110)
        SetBlipScale(blip, 1.2)
        SetBlipColour(blip, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Handlarz bronią')
        EndTextCommandSetBlipName(blip)
        Citizen.Wait(900000)
        RemoveBlip(blip)
    elseif random == 14 then
        SetNewWaypoint(Seller14)
        blip = AddBlipForCoord(Seller14)
        SetBlipSprite(blip, 110)
        SetBlipScale(blip, 1.2)
        SetBlipColour(blip, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Handlarz bronią')
        EndTextCommandSetBlipName(blip)
        Citizen.Wait(900000)
        RemoveBlip(blip)
    elseif random == 15 then
        SetNewWaypoint(Seller15)
        blip = AddBlipForCoord(Seller15)
        SetBlipSprite(blip, 110)
        SetBlipScale(blip, 1.2)
        SetBlipColour(blip, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Handlarz bronią')
        EndTextCommandSetBlipName(blip)
        Citizen.Wait(900000)
        RemoveBlip(blip)
    end
end
--[[
RegisterCommand("testxd", function()
TriggerServerEvent('srp_gunshop:weaponRoll')
end)
]]