local MiejsceMisji =  {x = 960.71197509766, y = -215.51979064941, z = 76.2552947998} --<< miejsce gdzie jest marker z misją
local dealerCoords =  {x = 960.78, y = -216.25, z = 75.25}  							--<< miejsce gdzie stoi dealer NPC
local pojazdCoords1 = {x = -1327.479736328, y = -86.045326232910, z = 49.31}  		--<< ponizej koordynaty do randomowego respienia się pojazdu
local pojazdCoords2 = {x = -2075.888183593, y = -233.73908996580, z = 21.10}
local pojazdCoords3 = {x = -972.1781616210, y = -1530.9045410150, z = 4.890}
local pojazdCoords4 = {x = 798.18426513672, y = -1799.8173828125, z = 29.33}
local pojazdCoords5 = {x = 1247.0718994141, y = -344.65634155273, z = 69.08}
local BronKierowca = "WEAPON_PISTOL" 		--<< broń w jaką ma być wyposażony kierowca
local BronPasazer = "WEAPON_COMBATPISTOL"  			--<< broń w jaką ma być wyposażony strażnik
local CzasDetonacji = math.random(7000, 25000) 			--<< czas detonacji bomby po podłożeniu, domyślnie 20 sekund
local CzasDetonacjisek = CzasDetonacji/1000
local czasPakowania = math.random(7000, 25000) 			--<< czas pakowania gotówki do torby, domyślnie 30 sekund
----------------------tego nizej nie ruszaj------------------------------
local prop
local wyjebalo = 0
local wysadzony = 0
local oznaczenie
local transport
local zrespione = 0
local ZrespTuPojazd = nil
local dealer
local ostrzezenie = 0
local info1 = false
local info2 = false
local info3 = false
local info4 = false
local bussy = false
local nocops = false
local nodisplay = false
local nomoney = false
--------------------------------------------------------
local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil

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

function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.3, 0.3)
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

----- Pedy
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false) 
        local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, MiejsceMisji.x, MiejsceMisji.y, MiejsceMisji.z)

		if dist <= 25.0  then
			if not DoesEntityExist(dealer) then
				RequestModel("ig_terry")
				while not HasModelLoaded("ig_terry") do
					Wait(10)
				end
				dealer = CreatePed(26, "ig_terry", dealerCoords.x, dealerCoords.y, dealerCoords.z, 7.9422, false, false)
				SetEntityInvincible(dealer, true)
				FreezeEntityPosition(dealer, true)
				SetBlockingOfNonTemporaryEvents(dealer, true)
				TaskStartScenarioInPlace(dealer, "WORLD_HUMAN_AA_SMOKE", 0, false)
			end
		else
			Citizen.Wait(1500)
		end

		if dist <= 1.0 then
			if nodisplay == false then
				DrawText3D(dealerCoords.x, dealerCoords.y, dealerCoords.z+1, "~g~[E]~w~ Aby porozmawiać")
				if IsControlJustPressed(0, Keys['E']) then
				TriggerServerEvent("napadtransport:akceptujto")
				Citizen.Wait(500)
				end
			end
		end
	end
end)
---

function PowiadomPsy()
	x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
	playerX = tonumber(string.format("%.2f", x))
    playerY = tonumber(string.format("%.2f", y))
    playerZ = tonumber(string.format("%.2f", z))
	TriggerServerEvent('napadtransport:zawiadompsy', playerX, playerY, playerZ)
	--TriggerServerEvent('srp_cars:InformBlip', playerX, playerY, playerZ)
	Citizen.Wait(500)
end

RegisterNetEvent('napadtransport:infodlalspd')
AddEventHandler('napadtransport:infodlalspd', function(x, y, z)	
	PlayerData = ESX.GetPlayerData()
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' and PlayerData.job.name == 'sheriff' and PlayerData.job.name == 'statepolice' then
		local blip = AddBlipForCoord(x, y, z)
		SetBlipSprite(blip, 67)
        SetBlipScale(blip, 1.0)
        SetBlipColour(blip, 1)
	    BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Zgłoszenie z furgonetki')
        EndTextCommandSetBlipName(blip)
        Citizen.Wait(180000)
        RemoveBlip(blip)
	end
end)


function NotyfikacjaMisja()
	info1 = true
	Citizen.Wait(4500)
	info1 = false
	info2 = true
	Citizen.Wait(4500)
	info2 = false
	info3 = true
	Citizen.Wait(4500)
	info3 = false
	info4 = true
	Citizen.Wait(4500)
	info4 = false
	nodisplay = false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
		if info1 == true then
			DrawText3D(dealerCoords.x, dealerCoords.y, dealerCoords.z+2, "A więc chcesz dorobić na boku? Dobrze się składa bo mam dla Ciebie robotę...")
		end
		if info2 == true then
			DrawText3D(dealerCoords.x, dealerCoords.y, dealerCoords.z+2, "A więc słuchaj uważnie...")
				DrawText3D(dealerCoords.x, dealerCoords.y, dealerCoords.z+1.89, "Widziałeś pewnie nie raz furgonetki Gruppe6 na mieście, przewożą one dość konkretny szmal...")
		end
		if info3 == true then
			DrawText3D(dealerCoords.x, dealerCoords.y, dealerCoords.z+2, "Więc tak, tutaj dostaniesz namiar na jedną z nich, pozbądź się strażnków a hajs będzie Twój...")
		end
		if info4 == true then
			DrawText3D(dealerCoords.x, dealerCoords.y, dealerCoords.z+2, "Pamiętaj, nie znasz mnie, nigdy mnie nie widziałeś... Powodzenia... Nie daj się zabić...")
		end
		if bussy == true then
			DrawText3D(dealerCoords.x, dealerCoords.y, dealerCoords.z+2, "Wybacz... Ale ktoś już robi dla mnie zlecenie... Wróć innym razem...")
		end
		if nocops == true then
			DrawText3D(dealerCoords.x, dealerCoords.y, dealerCoords.z+2, "Wróć innym razem... Moje kontakty doniosły że nie ma psów... Nie ma psów nie ma zlecenia...")
		end
		if nomoney == true then
			DrawText3D(dealerCoords.x, dealerCoords.y, dealerCoords.z+2, "Gościu co Ty tu do mnie bez grosza przychodzisz...")
			DrawText3D(dealerCoords.x, dealerCoords.y, dealerCoords.z+1.89, "Przynieś mi dwa tysiące amerykańskich bucksów a pogadamy...")
		end
	end
end)
---
--
RegisterNetEvent('srp_cars:nocops')
AddEventHandler('srp_cars:nocops', function()
	nodisplay = true
	nocops = true
	Citizen.Wait(4500)
	nocops = false
	nodisplay = false
end)

RegisterNetEvent('srp_cars:nomoney')
AddEventHandler('srp_cars:nomoney', function()
	nodisplay = true
	nomoney = true
	Citizen.Wait(4500)
	nomoney = false
	nodisplay = false
end)

RegisterNetEvent('srp_cars:bussy')
AddEventHandler('srp_cars:bussy', function()
	nodisplay = true
	bussy = true
	Citizen.Wait(4500)
	bussy = false
	nodisplay = false
end)

RegisterNetEvent('napadtransport:Pozwolwykonac')
AddEventHandler('napadtransport:Pozwolwykonac', function()
	nodisplay = true
	NotyfikacjaMisja()
	ClearPedTasks(dealer)
	local losujCoordy = math.random(1,5)
	if losujCoordy == 1 then
		ZrespTuPojazd = pojazdCoords1
	elseif losujCoordy == 2 then
		ZrespTuPojazd = pojazdCoords2
	elseif losujCoordy == 3 then
		ZrespTuPojazd = pojazdCoords3
	elseif losujCoordy == 4 then
		ZrespTuPojazd = pojazdCoords4
	elseif losujCoordy == 5 then
		ZrespTuPojazd = pojazdCoords5
	end

	RequestModel(GetHashKey('stockade'))
	while not HasModelLoaded(GetHashKey('stockade')) do
		Citizen.Wait(0)
	end

	SetNewWaypoint(ZrespTuPojazd.x, ZrespTuPojazd.y)
	ClearAreaOfVehicles(ZrespTuPojazd.x, ZrespTuPojazd.y, ZrespTuPojazd.z, 15.0, false, false, false, false, false) 
				
	transport = CreateVehicle(GetHashKey('stockade'), ZrespTuPojazd.x, ZrespTuPojazd.y, ZrespTuPojazd.z, -2.436,  996.786, 25.1887, true, true)
	SetEntityAsMissionEntity(transport)
	SetEntityHeading(transport, 52.00)
	oznaczenie = AddBlipForEntity(transport)
	SetBlipSprite(oznaczenie, 57)
	SetBlipColour(oznaczenie, 1)
	SetBlipFlashes(oznaczenie, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Furgonetka z gotówką')
	EndTextCommandSetBlipName(oznaczenie)

	RequestModel("s_m_m_security_01")
	while not HasModelLoaded("s_m_m_security_01") do
		Wait(10)
	end

	local pilot = CreatePedInsideVehicle(transport, 1, "s_m_m_security_01", -1, true, true)
	local nawigator = CreatePedInsideVehicle(transport, 1, "s_m_m_security_01", 0, true, true)
	SetPedFleeAttributes(pilot, 0, 0)
	SetPedCombatAttributes(pilot, 46, 1)
	SetPedCombatAbility(pilot, 100)
	SetPedCombatMovement(pilot, 2)
	SetPedCombatRange(pilot, 2)
	SetPedKeepTask(pilot, true)
	GiveWeaponToPed(pilot, GetHashKey(BronKierowca),250,false,true)
	SetPedAsCop(pilot, true)

	SetPedFleeAttributes(nawigator, 0, 0)
	SetPedCombatAttributes(nawigator, 46, 1)
	SetPedCombatAbility(nawigator, 100)
	SetPedCombatMovement(nawigator, 2)
	SetPedCombatRange(nawigator, 2)
	SetPedKeepTask(nawigator, true)
	TaskEnterVehicle(nawigator,transport,-1,0,1.0,1)
	GiveWeaponToPed(nawigator, GetHashKey(BronPasazer),250,false,true)
	SetPedAsCop(nawigator, true)

	TaskVehicleDriveWander(pilot, transport, 80.0, 443)
	zrespione = 1
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
		if zrespione == 1 then
			local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			local transCoords = GetEntityCoords(transport) 
			local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, transCoords.x+2, transCoords.y+3, transCoords.z)
			local x, y, z = table.unpack(GetEntityCoords(transport, true))
			local street = GetStreetNameAtCoord(x, y, z)
			local location = GetStreetNameFromHashKey(street)

			if dist <= 40.0  then
				DrawMarker(0, transCoords.x, transCoords.y, transCoords.z+4.5, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 135, 31, 35, 100, 1, 0, 0, 0)
				if ostrzezenie == 0 then
					ostrzezenie = 1
					--TriggerServerEvent('srp_cars:SendAllert', location)
					--TriggerServerEvent('srp_cars:InformBlip', -1, transport)
					--ESX.ShowNotification('~y~Pozbądź się ochrony zanim podłożysz ładunek.')
					exports['mythic_notify']:DoCustomHudText('inform', 'Pozbądź się ochrony zanim podłożysz ładunek!', 4000)
				end
			else
			Citizen.Wait(500)
			end
			
			if dist <= 5.5 and wysadzony == 0 then
				hintToDisplay('Wciśnij ~INPUT_VEH_HEADLIGHT~ aby wysadzić tylne drzwi i zabrać forse')
				--DrawText3D(transCoords.x, transCoords.y, transCoords.z+0.7, "~g~[H]~w~ Aby podłożyć ładunek")
				if IsControlJustPressed(0, Keys['H']) then 
					TriggerServerEvent('srp_cars:SendAllert', location)
					PowiadomPsy()
					SprawdzInformacjePojazdowe()
					Citizen.Wait(500)
				end
			end
		else
			Citizen.Wait(1500)
		end
	end
end)

RegisterNetEvent('srp_cars:BlipInfo2')
AddEventHandler('srp_cars:BlipInfo2', function(g6)
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' and PlayerData.job.name == 'sheriff' and PlayerData.job.name == 'statepolice' then
		PlaySoundFrontend(-1, "HACKING_CLICK_GOOD", 0, 1)
		local blip = GetBlipFromEntity(g6)
		if not DoesBlipExist(blip) then -- Add blip and create head display on player
			blip = AddBlipForEntity(g6)
			SetBlipSprite(blip, 67)
			ShowHeadingIndicatorOnBlip(blip, true) -- Player Blip indicator
			SetBlipRotation(blip, math.ceil(GetEntityHeading(g6))) -- update rotation
			SetBlipColour(blip, 1)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Napad na Gruppe6")
			EndTextCommandSetBlipName(blip)
			SetBlipScale(blip, 1.0) -- set scale
			SetBlipAsShortRange(blip, false)
		end
    end
end)
--[[
RegisterNetEvent('srp_cars:BlipInfo2')
AddEventHandler('srp_cars:BlipInfo2', function(g6)
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' or PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'statepolice' then
        blip = AddBlipForEntity(g6)
        SetBlipSprite(blip, 477)
        SetBlipScale(blip, 1.0)
        SetBlipColour(blip, 1)
        SetBlipAlpha(blip, 180)
        SetBlipHighDetail(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Napad na Gruppe6')
        EndTextCommandSetBlipName(blip)
        PlaySoundFrontend(-1, "HACKING_CLICK_GOOD", 0, 1)
        Citizen.Wait(300000)
        RemoveBlip(blip)
    end
end)
--]]


function SprawdzInformacjePojazdowe()
	if IsVehicleStopped(transport) then
		if IsVehicleSeatFree(transport, -1) and IsVehicleSeatFree(transport, 0) and IsVehicleSeatFree(transport, 1) then
			wysadzony = 1
			RequestAnimDict('anim@heists@ornate_bank@thermal_charge_heels')

			while not HasAnimDictLoaded('anim@heists@ornate_bank@thermal_charge_heels') do
				Citizen.Wait(50)
			end
			
			local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
			prop = CreateObject(GetHashKey('prop_c4_final_green'), x, y, z+0.2,  true,  true, true)
			AttachEntityToEntity(prop, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 60309), 0.06, 0.0, 0.06, 90.0, 0.0, 0.0, true, true, false, true, 1, true)
			SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_UNARMED"),true)
			FreezeEntityPosition(GetPlayerPed(-1), true)
			TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@ornate_bank@thermal_charge_heels', "thermal_charge", 3.0, -8, -1, 63, 0, 0, 0, 0 )
			Citizen.Wait(5500)
			ClearPedTasks(GetPlayerPed(-1))
			DetachEntity(prop)
			AttachEntityToEntity(prop, transport, GetEntityBoneIndexByName(transport, 'door_pside_r'), -0.7, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
			--ESX.ShowNotification('~y~Ładunek zostanie zdetonowany za ~g~'..CzasDetonacji..' sekund.')
			exports['mythic_notify']:DoCustomHudText('inform', 'Ładunek zostanie zdetonowany za ' .. CzasDetonacjisek .. ' sekund!', 4000)
			FreezeEntityPosition(GetPlayerPed(-1), false)
			Citizen.Wait(CzasDetonacji)
			local transCoords = GetEntityCoords(transport)
			SetVehicleDoorBroken(transport, 2, false)
			SetVehicleDoorBroken(transport, 3, false)
			AddExplosion(transCoords.x,transCoords.y,transCoords.z, 'EXPLOSION_TANKER', 2.0, true, false, 2.0)
			ApplyForceToEntity(transport, 0, transCoords.x,transCoords.y,transCoords.z, 0.0, 0.0, 0.0, 1, false, true, true, true, true)
			wyjebalo = 1
			--ESX.ShowNotification('~y~Możesz przystąpić do zebrania gotówki.')
			exports['mythic_notify']:DoCustomHudText('inform', 'Możesz przystąpić do zebrania gotówki', 3500)
			RemoveBlip(oznaczenie)
		else
			--ESX.ShowNotification('~y~Pojazd musi być pusty aby podłożyć ładunek')
			exports['mythic_notify']:DoCustomHudText('error', 'Pojazd musi być pusty aby podłożyć ładunek!', 3500)
		end
	else
		--ESX.ShowNotification('~y~Nie obrabujesz pojazdu który się porusza.')
		exports['mythic_notify']:DoCustomHudText('error', 'Nie obrabujesz pojazdu który się porusza!', 3500)
	end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
		
		if wyjebalo == 1 then
			local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			local transCoords = GetEntityCoords(transport) 
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, transCoords.x+2, transCoords.y+3, transCoords.z)

			if dist > 45.0 then
			Citizen.Wait(500)
			end
			
			if dist <= 5.5 then
				hintToDisplay('Wciśnij ~INPUT_PICKUP~ aby zabrać forse')
				--DrawText3D(transCoords.x+2, transCoords.y+3, transCoords.z+1, "~g~[E]~w~ Aby zabrać pieniądze")
				if IsControlJustPressed(0, Keys['E']) then 
				wyjebalo = 0
				ZabieranieSiana()
				Citizen.Wait(500)
				end
			end
		else
		Citizen.Wait(1500)
		end
	end
end)

function ZabieranieSiana()
	RequestAnimDict('anim@heists@ornate_bank@grab_cash_heels')
	while not HasAnimDictLoaded('anim@heists@ornate_bank@grab_cash_heels') do
		Citizen.Wait(50)
	end
	local PedCoords = GetEntityCoords(GetPlayerPed(-1))
	torba = CreateObject(GetHashKey('prop_cs_heist_bag_02'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
	AttachEntityToEntity(torba, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.0, 0.0, -0.16, 250.0, -30.0, 0.0, false, false, false, false, 2, true)
	--TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 8.0, -8.0, -1, 1, 0, false, false, false)
	FreezeEntityPosition(GetPlayerPed(-1), true)
	--ESX.ShowNotification('~y~Pakujesz gotówkę do torby.')
	exports['mythic_progbar']:Progress({
		name = "car_money",
		duration = czasPakowania,
		label = "Pakowanie gotówki...",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "anim@heists@ornate_bank@grab_cash_heels",
			anim = "grab",
			flags = 49,
		},
	})
	Citizen.Wait(czasPakowania)
	DeleteEntity(torba)
	ClearPedTasks(GetPlayerPed(-1))
	FreezeEntityPosition(GetPlayerPed(-1), false)
	SetPedComponentVariation(GetPlayerPed(-1), 5, 45, 0, 2)
	TriggerServerEvent("napadtransport:graczZrobilnapad")
	wyjebalo = 0
	wysadzony = 0
	zrespione = 0
	Citizen.Wait(2500)
end