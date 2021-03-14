--[[
Name: srp_businesses
Author: Ezi - Ezi#0001
Version: v0.1.5
Date: 16/07/2019 - 22:45
]]--

local Keys = {
	["E"] = 38, ["L"] = 182
}

---- Globalne zmiennie NIE RUSZAC!
local isAdmin = false
local bbiz = ""
local doorstxt = ""
local statetxt = ""
local modifiedtxt = ""
local editedby = ""
local interiortxt = ""
local identifier = ""
local IsPlayerInside = false
local lastBizId = nil
local visibleBiz = {}


---- Tutaj jest przesylany caly array z biznesami
RegisterNetEvent('srp_businesses:LoadBusinesses')
AddEventHandler('srp_businesses:LoadBusinesses', function(biz)
    bbiz = biz
end)
---- Pobieramy pozycje admina przy tworzeniu biznesu
RegisterNetEvent('srp_businesses:getPos')
AddEventHandler('srp_businesses:getPos', function()
    local coords = GetEntityCoords(PlayerPedId())
    TriggerServerEvent("srp_businesses:sendPos", coords)
end)
---- Pobieramy z serwera czy gracz jest adminem
RegisterNetEvent('srp_businesses:isAdmin')
AddEventHandler('srp_businesses:isAdmin', function(variable)
    isAdmin = variable
end)
---- Pobieranie SteamHex'a z serwera
RegisterNetEvent("srp_businesses:SendPlayerIdentifier")
AddEventHandler("srp_businesses:SendPlayerIdentifier", function(id)
    identifier = id
end)
---- Pobieranie ID Biznesu w ktorym stoi gracz
RegisterNetEvent("srp_bussinesses:GetLastBizID")
AddEventHandler("srp_bussinesses:GetLastBizID", function()
	if(lastBizId ~= nil) then
		local coords = GetEntityCoords(PlayerPedId())
		if GetDistanceBetweenCoords(coords, tonumber(bbiz[lastBizId].x), tonumber(bbiz[lastBizId].y), tonumber(bbiz[lastBizId].z), false) < 1 then
			TriggerServerEvent("srp_businesses:SendLastBizID", bbiz[lastBizId].id)
		end
	end
end)

---- Funkcja odpowiedzialna za ustalenie obok których biznesów znajduje się gracz
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local pos = GetEntityCoords(PlayerPedId())
        local shouldBeVisible = {}
        for i=1, #bbiz, 1 do
            if GetDistanceBetweenCoords(pos, tonumber(bbiz[i].x), tonumber(bbiz[i].y), tonumber(bbiz[i].z), false) <= 3 then
                table.insert(shouldBeVisible, i)
			end
		end
		
		for id, interior in pairs(Interiors) do
			if(GetDistanceBetweenCoords(pos, interior.coords.x, interior.coords.y, interior.coords.z, true) < 1) then
				for i=1, #bbiz, 1 do
					if id == tonumber(bbiz[i].interior) then
                        lastBizId = i
                        break
                    end
                end
                break
            end
        end
        
        for b=1, #shouldBeVisible, 1 do
            local i = shouldBeVisible[b]
            if GetDistanceBetweenCoords(pos, tonumber(bbiz[i].x), tonumber(bbiz[i].y), tonumber(bbiz[i].z), false) < 1 then
                lastBizId = i
                break;
            end
		end
        
		visibleBiz = shouldBeVisible
    end
end)
---- Funkcja odpowiedzialna za pokazanie markerów oraz tekstów 3d na serwerze
Citizen.CreateThread(function()
    while true do
		Citizen.Wait(5)
		local pos = GetEntityCoords(PlayerPedId())
		for p=1, #visibleBiz, 1 do
			local i = visibleBiz[p]
			if GetDistanceBetweenCoords(pos, tonumber(bbiz[i].x), tonumber(bbiz[i].y), tonumber(bbiz[i].z), false) <= 3 then
				if isAdmin == true then
					if bbiz[i].doors == 0 then
						doorstxt = _U('debugdooropen')
					elseif bbiz[i].doors == 1 then
						doorstxt = _U('debugdoorclose')
					end
					if bbiz[i].state == 0 then
						statetxt = _U('debugforsale')
					elseif bbiz[i].state == 1 then
						statetxt = _U('debugsold')
					elseif bbiz[i].state == 2 then
						statetxt = _U('debugrented')
					end
					if bbiz[i].last_modified == nil then
						modifiedtxt = _U('debugmodified')
					elseif bbiz[i].last_modified ~= nil then
						modifiedtxt = bbiz[i].last_modified
					end
					if bbiz[i].modified_by ~= nil then
						editedby = bbiz[i].modified_by
					else
						editedby = _U('debugmodifiedby')
					end
					if bbiz[i].interior == nil then
						interiortxt = _U('debuginteriortxt')
					else
						interiortxt = bbiz[i].interior
					end
					DrawText3D(tonumber(bbiz[i].x), tonumber(bbiz[i].y), tonumber(bbiz[i].z) + 0.7, "ID: ("..bbiz[i].id..")\n".._U('debugname')..bbiz[i].name.."\n".._U('debugprice')..bbiz[i].price.."$\n".._U('debugowner')..bbiz[i].owner)
					DrawText3D(tonumber(bbiz[i].x), tonumber(bbiz[i].y), tonumber(bbiz[i].z) + 0.27, _U('debugcreated')..bbiz[i].creation_date.."\n".._U('debugeditedat')..modifiedtxt.."\n".._U('debueditedby')..editedby)
					DrawText3D(tonumber(bbiz[i].x), tonumber(bbiz[i].y), tonumber(bbiz[i].z) + 0.02, _U('debugdoors')..doorstxt.."\n".._U('debustatus')..statetxt.."\n".._U('debuginterior')..interiortxt)
					if bbiz[i].doors == 0 then
						DrawMarker(20, tonumber(bbiz[i].x), tonumber(bbiz[i].y), tonumber(bbiz[i].z) - 0.3, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 26, 223, 26, 115, false, true, 2, false, false, false, false)
					elseif bbiz[i].doors == 1 then
						DrawMarker(20, tonumber(bbiz[i].x), tonumber(bbiz[i].y), tonumber(bbiz[i].z) - 0.3, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 223, 26, 26, 115, false, true, 2, false, false, false, false)
					end
				else
					DrawMarker(21, tonumber(bbiz[i].locker_x), tonumber(bbiz[i].locker_y), tonumber(bbiz[i].locker_z), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 26, 223, 26, 115, false, true, 2, false, false, false, false)
					if bbiz[i].state == 0 then
							DrawText3D(tonumber(bbiz[i].x), tonumber(bbiz[i].y), tonumber(bbiz[i].z) + 0.5, bbiz[i].name.."~w~\n".._U('debugprice')..bbiz[i].price.."$")
						if bbiz[i].doors == 0 then
							DrawMarker(20, tonumber(bbiz[i].x), tonumber(bbiz[i].y), tonumber(bbiz[i].z), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 26, 223, 26, 115, false, true, 2, false, false, false, false)
						elseif bbiz[i].doors == 1 then
							DrawMarker(20, tonumber(bbiz[i].x), tonumber(bbiz[i].y), tonumber(bbiz[i].z), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 223, 26, 26, 115, false, true, 2, false, false, false, false)
						end
					elseif bbiz[i].state == 1 then
							DrawText3D(tonumber(bbiz[i].x), tonumber(bbiz[i].y), tonumber(bbiz[i].z) + 0.5, bbiz[i].name)
						if bbiz[i].doors == 0 then
							DrawMarker(20, tonumber(bbiz[i].x), tonumber(bbiz[i].y), tonumber(bbiz[i].z), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 26, 223, 26, 115, false, true, 2, false, false, false, false)
						elseif bbiz[i].doors == 1 then
							DrawMarker(20, tonumber(bbiz[i].x), tonumber(bbiz[i].y), tonumber(bbiz[i].z), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 223, 26, 26, 115, false, true, 2, false, false, false, false)
						end
					elseif bbiz[i].state == 2 then
							DrawText3D(tonumber(bbiz[i].x), tonumber(bbiz[i].y), tonumber(bbiz[i].z) + 0.5, bbiz[i].name)
						if bbiz[i].doors == 0 then
							DrawMarker(20, tonumber(bbiz[i].x), tonumber(bbiz[i].y), tonumber(bbiz[i].z), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 26, 223, 26, 115, false, true, 2, false, false, false, false)
						elseif bbiz[i].doors == 1 then
							DrawMarker(20, tonumber(bbiz[i].x), tonumber(bbiz[i].y), tonumber(bbiz[i].z), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 223, 26, 26, 115, false, true, 2, false, false, false, false)
						end
					end
				end
			end
		end
    end
end)
--- Funkcja odpowiedzialna za wyswietlanie sie tekstu od szafek
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local pos = GetEntityCoords(PlayerPedId())
		if(lastBizId ~= nil) then
			if bbiz[lastBizId].locker_zone ~= nil then
				if GetDistanceBetweenCoords(pos, bbiz[lastBizId].locker_zone.x, bbiz[lastBizId].locker_zone.y, bbiz[lastBizId].locker_zone.z, false) <= 3 then
					DrawText3D(bbiz[lastBizId].locker_zone.x, bbiz[lastBizId].locker_zone.y, bbiz[lastBizId].locker_zone.z, "~g~[E] ~w~Aby otworzyć szafke")
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		local ped = PlayerPedId()
		local source = GetPlayerServerId(PlayerId())
		local canOpen = false

		if(lastBizId ~= nil) then
			if GetDistanceBetweenCoords(coords, bbiz[lastBizId].locker_zone.x, bbiz[lastBizId].locker_zone.y, bbiz[lastBizId].locker_zone.z, false) < 1 then
			canOpen = true
			TriggerServerEvent("srp_businesses:GetPlayerIdentifier", source)
				if IsControlJustReleased(0, Keys['E']) and bbiz[lastBizId].owner == identifier then
					exports['srp_notify']:DoCustomHudText('inform', 'Otworzyles!', 3500)
				elseif IsControlJustReleased(0, Keys['E']) then
					exports['srp_notify']:DoCustomHudText('error', 'Nie masz kluczy do tej szafki!', 3500)
				end
			end
		end
	end
end)

---- Funkcja odpowiedzialna za wchodzenie/wychodzenie z interioru
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
        local coords = GetEntityCoords(GetPlayerPed(-1))
        local ped = PlayerPedId()
        local canEnter = false
        local canExit = false
		
		if(lastBizId ~= nil) then
			if(GetDistanceBetweenCoords(coords, tonumber(bbiz[lastBizId].x), tonumber(bbiz[lastBizId].y), tonumber(bbiz[lastBizId].z), true) < 1) then
				local inveh = IsPedInAnyVehicle(GetPlayerPed(-1), false)
				canEnter = true
				if IsControlJustReleased(0, Keys['E']) and bbiz[lastBizId].doors == 0 then
					if inveh then
						exports['srp_notify']:DoCustomHudText('error', _U("notifyinveh"), 3500)
					else
						for id, interior in pairs(Interiors) do
							if tonumber(bbiz[lastBizId].interior) == id then
								SetEntityCoords(ped, interior.coords.x, interior.coords.y, interior.coords.z, false, false, false, false)
								IsPlayerInside = true
							end
						end
					end
				elseif IsControlJustReleased(0, Keys['E']) and bbiz[lastBizId].doors == 1 then
					exports['srp_notify']:DoCustomHudText('error', _U('notifydoorsareclosed'), 3500)
				end
			end
			for id, interior in pairs(Interiors) do
				if(GetDistanceBetweenCoords(coords, interior.coords.x, interior.coords.y, interior.coords.z, true) < 1) then
					canExit = true
					if IsControlJustReleased(0, Keys['E']) and bbiz[lastBizId].doors == 0 then
						if id == tonumber(bbiz[lastBizId].interior) then
							SetEntityCoords(ped, tonumber(bbiz[lastBizId].x), tonumber(bbiz[lastBizId].y), tonumber(bbiz[lastBizId].z), false, false, false, false)
							IsPlayerInside = false
						end
					elseif IsControlJustReleased(0, Keys['E']) and bbiz[lastBizId].doors == 1 then
						if id == tonumber(bbiz[lastBizId].interior) then
							exports['srp_notify']:DoCustomHudText('error', _U('notifydoorsareclosed'), 3500)
						end
					end
				end
			end
		end
	end
end)

---- Funkcja odpowiedzialna za zamykanie/otwieranie drzwi
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local canClose = false
        local canCloseInside = false
        local coords = GetEntityCoords(GetPlayerPed(-1))
        local ped = PlayerPedId()
        local inveh = IsPedInAnyVehicle(GetPlayerPed(-1), false)
        local source = GetPlayerServerId(PlayerId())
		
		if(lastBizId ~= nil) then
			if(GetDistanceBetweenCoords(coords, tonumber(bbiz[lastBizId].x), tonumber(bbiz[lastBizId].y), tonumber(bbiz[lastBizId].z), true) < 1) then
				TriggerServerEvent("srp_businesses:GetPlayerIdentifier", source)
				local canClose = true
				if IsControlJustReleased(0, Keys['L']) and bbiz[lastBizId].doors == 0 then
					if bbiz[lastBizId].owner == identifier then
						if inveh then
							exports['srp_notify']:DoCustomHudText('error', _U("notifyinveh"), 3500)
						else
							TriggerServerEvent("srp_businesses:SetBusinessesDoors", bbiz[lastBizId].id, 1)
							exports['srp_notify']:DoCustomHudText('error', _U("notifydoorsclose"), 3500)
						end
					else
						exports['srp_notify']:DoCustomHudText('error', _U("notifycantclose"), 3500)
					end
				elseif IsControlJustReleased(0, Keys['L']) and bbiz[lastBizId].doors == 1 then
					if bbiz[lastBizId].owner == identifier then
						if inveh then
							exports['srp_notify']:DoCustomHudText('error', _U("notifyinveh"), 3500)
						else
							TriggerServerEvent("srp_businesses:SetBusinessesDoors", bbiz[lastBizId].id, 0)
							exports['srp_notify']:DoCustomHudText('success', _U("notifydoorsopen"), 3500)
						end
					else
						exports['srp_notify']:DoCustomHudText('error', _U("notifycantopen"), 3500)
					end
				end
			end
			for id, interior in pairs(Interiors) do
				if(GetDistanceBetweenCoords(coords, interior.coords.x, interior.coords.y, interior.coords.z, true) < 1) then
					TriggerServerEvent("srp_businesses:GetPlayerIdentifier", source)
					local canCloseInside = true
					if id == tonumber(bbiz[lastBizId].interior) then
						if IsControlJustReleased(0, Keys['L']) and bbiz[lastBizId].doors == 0 then
							if bbiz[lastBizId].owner == identifier then
								TriggerServerEvent("srp_businesses:SetBusinessesDoors", bbiz[lastBizId].id, 1)
								exports['srp_notify']:DoCustomHudText('error', _U("notifydoorsclose"), 3500)
							end
						elseif IsControlJustReleased(0, Keys['L']) and bbiz[lastBizId].doors == 1 then
							if bbiz[lastBizId].owner == identifier then
								TriggerServerEvent("srp_businesses:SetBusinessesDoors", bbiz[lastBizId].id, 0)
								exports['srp_notify']:DoCustomHudText('success', _U("notifydoorsopen"), 3500)
							end
						end
					end
				end
			end
		end
    end
end)

----Funkcja odpowiedzialna za pobieranie koordynatow przy ustawianiu szafki
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		local CanSetLocker = false
		if IsPlayerInside == true then
			CanSetLocker = true
			TriggerServerEvent("srp_businesses:SetLocker", coords, CanSetLocker, bbiz[lastBizId].id, bbiz[lastBizId].owner)
		elseif IsPlayerInside == false then
			CanSetLocker = false
			TriggerServerEvent("srp_businesses:SetLocker", coords, CanSetLocker)
		end
	end
end)

---- Funkcja odpowiedzialna za tekst 3d
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
    local factor = (string.len(text)) / 670
    --DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 90)
end