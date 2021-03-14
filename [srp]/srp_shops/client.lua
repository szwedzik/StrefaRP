local Keys = {["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil

local playerCoords = GetEntityCoords(GetPlayerPed(-1))
local objectCoords = nil
local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }
local directions = { [0] = 'N', [45] = 'NW', [90] = 'W', [135] = 'SW', [180] = 'S', [225] = 'SE', [270] = 'E', [315] = 'NE', [360] = 'N', } 

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

function LoadAnimationDictionary(animationD)
	while(not HasAnimDictLoaded(animationD)) do
		RequestAnimDict(animationD)
		Citizen.Wait(1)
	end
end

function Animacja()
	local dict = "oddjobs@shop_robbery@rob_till"
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	Citizen.Wait(10)
	end
	TaskPlayAnim(GetPlayerPed(-1), dict, "loop", 8.0, 8.0, -1, 1, 0, false, false, false)
end
--------------------
local Oczekiwanie = 0
local Kradne = 0
--obie zakomentowane zmienne powtorzone w kodzie z uwagi na fakt, iż poprzednia składnia powodowała ujemne %
--local procent = 100
--local procent_pozostaly = 100 
local uciek = 0
local cooldown = 0
local powiadom = 0
local minPolice = 1
--------------------
local infoPolicja = 30 -- przy ilu pozostalych PROCENTACH ma dawac info na policje
local czasCooldown = ((60 * 1000) * 60) -- 90 = tyle sekund trwa cooldown przed kolejnym rabunkiem
--------------------

function NaliczCooldown()
	cooldown = 1
	Citizen.Wait(czasCooldown)
	cooldown = 0
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Oczekiwanie)

        local pedCoords = GetEntityCoords(PlayerPedId())
        local objectId = GetClosestObjectOfType(pedCoords, 2.5, GetHashKey("prop_till_01"), false)
        local objectCoords = GetEntityCoords(objectId)
        local dist = Vdist(pedCoords.x, pedCoords.y, pedCoords.z, objectCoords.x, objectCoords.y, objectCoords.z)

        local forward   = GetEntityForwardVector(objectId)
        xD, yD, zD   = table.unpack(objectCoords + forward * -0.5)
		
		local distV = Vdist(pedCoords.x, pedCoords.y, pedCoords.z, xD, yD, zD)

		if dist <= 10.0 then
		Oczekiwanie = 0
		else
		Oczekiwanie = 500
		end
		
		if dist <= 0.8 and cooldown == 0 then

				DrawText3D(objectCoords.x, objectCoords.y, objectCoords.z,'~g~[H] ~w~Aby okraść kasę fiskalną')
		end
		
		if DoesEntityExist(objectId)  and IsControlJustPressed(0, Keys['H']) and cooldown == 0 and dist <= 1.5 and cooldown == 0 and distV <= 0.5 then
			TriggerServerEvent('zrider:jednostki')
			Citizen.Wait(500)
			
			ESX.TriggerServerCallback('zrider:jednostkiCheck', function(jednostki_check_srv)
				local jednostki_check_cl = jednostki_check_srv

			

				if jednostki_check_cl then

					
					local playerCoords = GetEntityCoords(GetPlayerPed(-1))
					if Kradne == 0 then
					  ESX.TriggerServerCallback('tost:checkForRoob', function(result)
					  if not result then
							SetEntityCoords(GetPlayerPed(-1), xD, yD, zD-0.3, 0.0, 0.0, 0.0, false)
							local heading = GetEntityHeading(objectId)
							local newheading = 0
							if(heading >= 180) then
								newheading = heading + 360.0
							else
								newheading = heading - 360.0
							end
						SetEntityHeading(GetPlayerPed(-1), newheading)
						exports['mythic_notify']:DoCustomHudText('inform', 'Okradasz kasę fiskalną', 4000)
						Kradne = 1
						TriggerServerEvent('tost:robbing', true)
						Animacja()

						local procent = 100
						local procent_pozostaly = procent

						for i=1, 5000, 1 do

							
							local pedCoords = GetEntityCoords(PlayerPedId())
							local dist = Vdist(pedCoords.x, pedCoords.y, pedCoords.z, objectCoords.x, objectCoords.y, objectCoords.z)
							if dist <= 2.0 then
								Citizen.Wait(8)
								local pedCoords = GetEntityCoords(GetPlayerPed(-1))
								procent = procent - 0.02
								--dolozona zmienna zeby procent wyswietlany nie spadl ponizej zero i zeby nie manipulowac wartoscia procenta
								procent_pozostaly = math.floor(procent)
								if procent_pozostaly < 0 then
									procent_pozostaly = 0
								end
								DrawText3D(pedCoords.x, pedCoords.y, pedCoords.z + 0.98, 'Pozostało:~g~ '..procent_pozostaly..' procent.')

								if powiadom == 0 and math.floor(procent) < infoPolicja then
									powiadom = 1
									PowiadomPsy()
									--powiadomienie przez esx_jb_outlawalert
									local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
									local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
									local street1 = GetStreetNameFromHashKey(s1)
									local street2 = GetStreetNameFromHashKey(s2)
									local current_zone = zones[GetNameOfZone(plyPos.x, plyPos.y, plyPos.z)]
									local direction = nil
									for k,v in pairs(directions)do
										direction = GetEntityHeading(GetPlayerPed(-1))
										if(math.abs(direction - k) < 22.5)then
											direction = v
											break;
										end
									end

									ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
										local sex = nil
										if skin.sex == 0 then
											sex = "Mężczyzna"
										else
											sex = "Kobieta"
										end
										if s2 == 0 then
											--ESX.ShowNotification("0 Podejrzany/a "..sex.." Ulica "..street1.. " [" .. current_zone .. "] Kierunek: "..direction)
											TriggerServerEvent('outlaw:robberyInProgressS1',street1, sex, current_zone, direction)
										elseif s2 ~= 0 then
											--ESX.ShowNotification("1 Podejrzany/a "..sex.." Ulica "..street1..' - '..street2.. " [" .. current_zone .. "] Kierunek: "..direction)
											TriggerServerEvent('outlaw:robberyInProgress',street1, street2, sex, current_zone, direction)
										end
									end)
									Citizen.Wait(10)
								end
							else
								uciek = 1
								exports['mythic_notify']:DoCustomHudText('inform', 'Uciekłeś, rabunek przerwany', 4000)
								exports['mythic_notify']:DoCustomHudText('inform', 'Następną kasę możesz obrabować za 25 min', 4000)
								TriggerServerEvent('tost:robbing', false)
							end
						end

						Kradne = 0
						ClearPedTasks(GetPlayerPed(-1))

						if uciek == 0 then
							TriggerServerEvent("tost:zgarnijsiano")
							TriggerServerEvent('tost:robbing', false)
						end
						uciek = 0

						powiadom = 0
						NaliczCooldown()
					else
						exports['mythic_notify']:DoCustomHudText('inform', 'Na wyspie trwa rabunek, odczekaj chwilę', 4000)
					end
					end)
					
					else
						exports['mythic_notify']:DoCustomHudText('inform', 'Nie tak szybko', 4000)
					end
				else
					ESX.TriggerServerCallback('zrider:minLSPD', function(minLspd)
					minPolice = minLspd
					exports['mythic_notify']:DoCustomHudText('inform', 'Nie ma wystarczająco dużo jednostek LSPD, wymagane jest minimum ' ..minPolice.. ' funkcjonariuszy', 4000)
					end)
				end
			end)
			end
    	end
end)

RegisterNetEvent('tost:infodlalspd')
AddEventHandler('tost:infodlalspd', function(x, y, z)	
	PlayerData = ESX.GetPlayerData()
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' or
	PlayerData.job ~= nil and PlayerData.job.name == 'statepolice' or
	PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' then
		
		--[[
		local street = GetStreetNameAtCoord(x, y, z)
        local droga = GetStreetNameFromHashKey(street)
        ESX.ShowNotification('~r~Doniesiono o rabunku kasy fiskalnej w okolicy ~y~'..droga..'!')
        PlaySoundFrontend(-1, "HACKING_CLICK_GOOD", 0, 1)
        ]]
		local blip = AddBlipForCoord(x, y, z)
		SetBlipSprite(blip, 161)
        SetBlipScale(blip, 1.2)
        SetBlipColour(blip, 75)
        SetBlipAlpha(blip, 180)
        SetBlipHighDetail(blip, true)
	    BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Rabunek kasy fiskalnej')
        EndTextCommandSetBlipName(blip)
        Citizen.Wait(30000)
        RemoveBlip(blip)
	end
end)

function PowiadomPsy()
	x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
	playerX = tonumber(string.format("%.2f", x))
    playerY = tonumber(string.format("%.2f", y))
    playerZ = tonumber(string.format("%.2f", z))
	TriggerServerEvent('tost:zawiadompsy', playerX, playerY, playerZ)
	Citizen.Wait(500)
end

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
    --local factor = (string.len(text)) / 370
    --DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 173, 98, 0, 90)
end