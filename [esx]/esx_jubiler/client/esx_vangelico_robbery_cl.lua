local holdingup = false
local store = ""
local blipRobbery = nil
local robinprogress = false
local powiadom = 0

local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }
local directions = { [0] = 'N', [45] = 'NW', [90] = 'W', [135] = 'SW', [180] = 'S', [225] = 'SE', [270] = 'E', [315] = 'NE', [360] = 'N', } 

ESX	= nil
local PlayerData = {}

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) 
            ESX = obj
        end)

        Citizen.Wait(1)
    end

    if ESX.IsPlayerLoaded() then
        ESX.PlayerData = ESX.GetPlayerData()
    end
end) 

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

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

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

RegisterNetEvent('esx_jubiler:alertFP')
AddEventHandler('esx_jubiler:alertFP', function(source)
	if powiadom == 0 then
		powiadom = 1
		PowiadomPsyJub()
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
				TriggerServerEvent('esx_jubiler:robberyInProgressS1',street1, sex, current_zone, direction)
			elseif s2 ~= 0 then
				TriggerServerEvent('esx_jubiler:robberyInProgress',street1, street2, sex, current_zone, direction)
			end
		end)
		Citizen.Wait(10)
	end
end)


RegisterNetEvent('esx_vangelico_robbery:currentlyrobbing')
AddEventHandler('esx_vangelico_robbery:currentlyrobbing', function(robb)
	holdingup = true
	store = robb
end)

RegisterNetEvent('esx_vangelico_robbery:currentlyrobbingnear')
AddEventHandler('esx_vangelico_robbery:currentlyrobbingnear', function(robb, position)
local playersInArea = ESX.Game.GetPlayersInArea(position, 50.0)

for i=1, #playersInArea, 1 do
	if playersInArea[i] ~= PlayerId() then
		holdingup = true
		store = robb
	end
end
end)

RegisterNetEvent('esx_vangelico_robbery:killblip')
AddEventHandler('esx_vangelico_robbery:killblip', function()
	RemoveBlip(blip)
	powiadom = 0
end)

RegisterNetEvent('esx_vangelico_robbery:setblip')
AddEventHandler('esx_vangelico_robbery:setblip', function(position)
    blipRobbery = AddBlipForCoord(position.x, position.y, position.z)
    SetBlipSprite(blipRobbery , 161)
    SetBlipScale(blipRobbery , 2.0)
    SetBlipColour(blipRobbery, 3)
	PulseBlip(blipRobbery)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Napad na jubilera')
    EndTextCommandSetBlipName(blip)
end)

RegisterNetEvent('esx_vangelico_robbery:toofarlocal')
AddEventHandler('esx_vangelico_robbery:toofarlocal', function(robb)
	holdingup = false
	--ESX.ShowNotification(_U('robbery_cancelled'))
	exports['mythic_notify']:DoCustomHudText('error', 'Rabunek został przerwany!', 3500)
	robbingName = ""
	incircle = false
end)

RegisterNetEvent('esx_jubiler:infodlalspd')
AddEventHandler('esx_jubiler:infodlalspd', function(x, y, z)	
	PlayerData = ESX.GetPlayerData()
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' or
	PlayerData.job ~= nil and PlayerData.job.name == 'statepolice' or
	PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' then
		
		local blip = AddBlipForCoord(x, y, z)
		SetBlipSprite(blip, 161)
        SetBlipScale(blip, 1.2)
        SetBlipColour(blip, 75)
        SetBlipAlpha(blip, 180)
        SetBlipHighDetail(blip, true)
	    BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Rabunek u Jubilera')
        EndTextCommandSetBlipName(blip)
        Citizen.Wait(300000)
        RemoveBlip(blip)
	end
end)

function PowiadomPsyJub()
	x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
	playerX = tonumber(string.format("%.2f", x))
    playerY = tonumber(string.format("%.2f", y))
    playerZ = tonumber(string.format("%.2f", z))
	TriggerServerEvent('esx_jubiler:zawiadompsy', playerX, playerY, playerZ)
	Citizen.Wait(500)
end


RegisterNetEvent('esx_vangelico_robbery:robberycomplete')
AddEventHandler('esx_vangelico_robbery:robberycomplete', function(robb)
	holdingup = false

		TriggerEvent('skinchanger:getSkin', function(skin)
	
		if skin.sex == 0 then

		local clothesSkin = {
		['bags_1'] = 41, ['bags_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

		else

		local clothesSkin = {
		['bags_1'] = 41, ['bags_2'] = 0
		}
	    TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

	    end
		end)
		exports['mythic_notify']:DoCustomHudText('error', 'Zebrałeś wszystkie fanty! Teraz uciekaj!', 3500)
	--ESX.ShowNotification(_U('robbery_complete'))
	store = ""
	incircle = false
	robinprogress = false
	powiadom = 0
end)

Citizen.CreateThread(function()
	for k,v in pairs(Stores)do
		local ve = v.position

		local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
		SetBlipSprite(blip, 439)
		SetBlipScale(blip, 0.8)
		SetBlipColour(blip, 28)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('shop_robbery'))
		EndTextCommandSetBlipName(blip)
	end
end)


incircle = false

hasrobbed = false
hasrobbed2 = false
hasrobbed3 = false
hasrobbed4 = false
hasrobbed5 = false
hasrobbed6 = false
hasrobbed7 = false
hasrobbed8 = false
hasrobbed9 = false
hasrobbed10 = false
hasrobbed11 = false
hasrobbed12 = false
hasrobbed13 = false
hasrobbed14 = false
hasrobbed15 = false
hasrobbed16 = false
hasrobbed17 = false
hasrobbed18 = false
hasrobbed19 = false
hasrobbed20 = false

function loadAnimDict( dict )  
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
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
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 90)
end

Citizen.CreateThread(function() 
	while true do 
		Citizen.Wait(5) 
		if (holdingup == true) then
				if hasrobbed == false then 
					local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
					local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, -626.3326, -239.0368, 38.05) 
						if dist <= 2.0  then
							DrawText3D(-626.3626, -238.9968, 38.05, "~g~[E]~w~ Aby rozbić gablote")
						end
				end
				if hasrobbed2 == false then
					local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
					local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, -625.3632, -238.3005, 38.05) 
						if dist <= 2.0  then
							DrawText3D(-625.2732, -238.2705, 38.05, "~g~[E]~w~ Aby rozbić gablote")
						end
				end
				if hasrobbed3 == false then
					local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
					local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, -627.0500, -234.7966, 38.05) 
						if dist <= 2.0  then
							DrawText3D(-627.1100, -234.9466, 38.05, "~g~[E]~w~ Aby rozbić gablote")
						end
				end
				if hasrobbed4 == false then
					local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
					local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, -626.1501, -234.1961, 38.05) 
						if dist <= 2.0  then
							DrawText3D(-626.1401, -234.1961, 38.05, "~g~[E]~w~ Aby rozbić gablote")
						end
				end
				if hasrobbed5 == false then
					local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
					local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, -626.8935, -233.0814, 38.05) 
						if dist <= 2.0  then
							DrawText3D(-626.5635, -233.5514, 38.05, "~g~[E]~w~ Aby rozbić gablote")
						end
				end
				if hasrobbed6 == false then
					local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
					local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, -627.9514, -233.8582, 38.05) 
						if dist <= 2.0  then
							DrawText3D(-627.5114, -234.3042, 38.05, "~g~[E]~w~ Aby rozbić gablote")
						end
				end
				if hasrobbed7 == false then
					local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
					local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, -624.5250, -231.0555, 38.05) 
						if dist <= 2.0  then
							DrawText3D(-624.0550, -230.6555, 38.05, "~g~[E]~w~ Aby rozbić gablote")
						end
				end
				if hasrobbed8 == false then
					local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
					local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, -623.0003, -233.0833, 38.05) 
						if dist <= 2.0  then
							DrawText3D(-622.7203, -232.5833, 38.05, "~g~[E]~w~ Aby rozbić gablote")
						end
				end
				if hasrobbed9 == false then
					local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
					local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, -620.1098, -233.3672, 38.05) 
						if dist <= 2.0  then
							DrawText3D(-620.6098, -232.9172, 38.05, "~g~[E]~w~ Aby rozbić gablote")
						end
				end
				if hasrobbed10 == false then
					local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
					local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, -620.2979, -234.4196, 38.05) 
						if dist <= 2.0  then
							DrawText3D(-619.8279, -234.9296, 38.05, "~g~[E]~w~ Aby rozbić gablote")
						end
				end
				if hasrobbed11 == false then
					local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
					local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, -619.0646, -233.5629, 38.05) 
						if dist <= 2.0  then
							DrawText3D(-618.7646, -234.1529, 38.05, "~g~[E]~w~ Aby rozbić gablote")
						end
				end
				if hasrobbed12 == false then
					local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
					local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, -617.4846, -230.6598, 38.05) 
						if dist <= 2.0  then
							DrawText3D(-617.1346, -230.2598, 38.05, "~g~[E]~w~ Aby rozbić gablote")
						end
				end
				if hasrobbed13 == false then
					local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
					local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, -618.3619, -229.4285, 38.05) 
						if dist <= 2.0  then
							DrawText3D(-617.8519, -229.1785, 38.05, "~g~[E]~w~ Aby rozbić gablote")
						end
				end
				if hasrobbed14 == false then
					local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
					local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, -619.6064, -230.5518, 38.05) 
						if dist <= 2.0  then
							DrawText3D(-620.1664, -230.8518, 38.05, "~g~[E]~w~ Aby rozbić gablote")
						end
				end
				if hasrobbed15 == false then
					local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
					local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, -620.8951, -228.6519, 38.05) 
						if dist <= 2.0  then
							DrawText3D(-621.4151, -228.8719, 38.05, "~g~[E]~w~ Aby rozbić gablote")
						end
				end
				if hasrobbed16 == false then
					local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
					local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, -619.7905, -227.5623, 38.05) 
						if dist <= 2.0  then
							DrawText3D(-619.1805, -227.1623, 38.05, "~g~[E]~w~ Aby rozbić gablote")
						end
				end
				if hasrobbed17 == false then
					local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
					local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, -620.6110, -226.4467, 38.05) 
						if dist <= 2.0  then
							DrawText3D(-619.9910, -226.1467, 38.05, "~g~[E]~w~ Aby rozbić gablote")
						end
				end
				if hasrobbed18 == false then
					local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
					local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, -623.9951, -228.1755, 38.05) 
						if dist <= 2.0  then
							DrawText3D(-623.6351, -228.5555, 38.05, "~g~[E]~w~ Aby rozbić gablote")
						end
				end
				if hasrobbed19 == false then
					local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
					local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, -624.8832, -227.8645, 38.05) 
						if dist <= 2.0  then
							DrawText3D(-625.3132, -227.4445, 38.05, "~g~[E]~w~ Aby rozbić gablote")
						end
				end
				if hasrobbed20 == false then
					local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
					local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, -623.6746,  -227.0025, 38.05) 
						if dist <= 2.0  then
							DrawText3D(-624.3746,  -226.5925, 38.05, "~g~[E]~w~ Aby rozbić gablote")
						end
				end 
			end 
		end
end)

function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end

Citizen.CreateThread(function()

	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for k,v in pairs(Stores)do
			local pos2 = v.position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0) then
				if not holdingup and robinprogress == false then
					DrawMarker(27, v.position.x, v.position.y, v.position.z - 0.99, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 0, 155, 255, 200, 0, 0, 0, 0)

					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 0.5) then
						if (incircle == false) then
						end
						ESX.Game.Utils.DrawText3D(vector3(v.position.x, v.position.y, v.position.z), '~g~[E] ~w~Aby wyłączyć alarm', 0.3)
						incircle = true
						if IsControlJustPressed(0, Keys['E']) then
							robinprogress = true
							SetEntityHeading(GetPlayerPed(-1), 215.0)
							exports['mythic_progbar']:Progress({
								name = "jubiler_action",
								duration = 5000,
								label = "Wyłączanie alarmu...",
								useWhileDead = false,
								canCancel = true,
								controlDisables = {
									disableMovement = true,
									disableCarMovement = true,
									disableMouse = false,
									disableCombat = true,
								},
								animation = {
									animDict = "mp_shipment_steal",
									anim = "hack_loop",
									flags = 49,
								},
							})
							Citizen.Wait(5000)
							ClearPedTasks(GetPlayerPed(-1))
							TriggerServerEvent('esx_vangelico_robbery:rob', k)
                        end
					elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 1.0)then
						incircle = false
					end
				end
			end
		end

		if holdingup then
							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -626.5326, -238.3758, 38.05, true) < 0.5 ) then
								if (hasrobbed == false) then
							
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -626.5326, -238.3758, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								DisplayHelpText(_U('collectinprogress'))
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli1)
								TriggerServerEvent('esx_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								hasrobbed = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -625.6032, -237.5273, 38.05, true) < 0.5 ) then
								if (hasrobbed2 == false) then
							
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -625.6032, -237.5273, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								DisplayHelpText(_U('collectinprogress'))
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli2)
								TriggerServerEvent('esx_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								hasrobbed2 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -626.9178, -235.5166, 38.05, true) < 0.5 ) then
								if (hasrobbed3 == false) then
							
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -626.9178, -235.5166, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								DisplayHelpText(_U('collectinprogress'))
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli3)
								TriggerServerEvent('esx_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								hasrobbed3 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -625.6701, -234.6061, 38.05, true) < 0.5 ) then
								if (hasrobbed4 == false) then
							
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -625.6701, -234.6061, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								DisplayHelpText(_U('collectinprogress'))
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli4)
								TriggerServerEvent('esx_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								hasrobbed4 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -626.8935, -233.0814, 38.05, true) < 0.5 ) then
								if (hasrobbed5 == false) then
							
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -626.8935, -233.0814, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								DisplayHelpText(_U('collectinprogress'))
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli5)
								TriggerServerEvent('esx_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                hasrobbed5 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -627.9514, -233.8582, 38.05, true) < 0.5 ) then
								if (hasrobbed6 == false) then
							
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -627.9514, -233.8582, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								DisplayHelpText(_U('collectinprogress'))
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli6)
								TriggerServerEvent('esx_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                hasrobbed6 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -624.5250, -231.0555, 38.05, true) < 0.5 ) then
								if (hasrobbed7 == false) then
							
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -624.5250, -231.0555, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								DisplayHelpText(_U('collectinprogress'))
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli7)
								TriggerServerEvent('esx_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                hasrobbed7 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -623.0003, -233.0833, 38.05, true) < 0.5 ) then
								if (hasrobbed8 == false) then
							
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -623.0003, -233.0833, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								DisplayHelpText(_U('collectinprogress'))
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli8)
								TriggerServerEvent('esx_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                hasrobbed8 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -620.1098, -233.3672, 38.05, true) < 0.5 ) then
							if (hasrobbed9 == false) then
							
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -620.1098, -233.3672, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								DisplayHelpText(_U('collectinprogress'))
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli9)
								TriggerServerEvent('esx_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                hasrobbed9 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -620.2979, -234.4196, 38.05, true) < 0.5 ) then
							if (hasrobbed10 == false) then
							
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -620.2979, -234.4196, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								DisplayHelpText(_U('collectinprogress'))
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli10)
								TriggerServerEvent('esx_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                hasrobbed10 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -619.0646, -233.5629, 38.05, true) < 0.5 ) then
							if (hasrobbed11 == false) then
							
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -619.0646, -233.5629, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								DisplayHelpText(_U('collectinprogress'))
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli11)
								TriggerServerEvent('esx_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                hasrobbed11 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -617.4846, -230.6598, 38.05, true) < 0.5 ) then
							if (hasrobbed12 == false) then
							
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -617.4846, -230.6598, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								DisplayHelpText(_U('collectinprogress'))
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli12)
								TriggerServerEvent('esx_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                hasrobbed12 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -618.3619, -229.4285, 38.05, true) < 0.5 ) then
							if (hasrobbed13 == false) then
							
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -618.3619, -229.4285, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								DisplayHelpText(_U('collectinprogress'))
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli13)
								TriggerServerEvent('esx_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                hasrobbed13 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -619.6064, -230.5518, 38.05, true) < 0.5 ) then
							if (hasrobbed14 == false) then
							
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -619.6064, -230.5518, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								DisplayHelpText(_U('collectinprogress'))
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli14)
								TriggerServerEvent('esx_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                hasrobbed14 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -620.8951, -228.6519, 38.05, true) < 0.5 ) then
							if (hasrobbed15 == false) then
							
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -620.8951, -228.6519, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								DisplayHelpText(_U('collectinprogress'))
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli15)
								TriggerServerEvent('esx_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                hasrobbed15 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -619.7905, -227.5623, 38.05, true) < 0.5 ) then
							if (hasrobbed16 == false) then
							
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -619.7905, -227.5623, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								DisplayHelpText(_U('collectinprogress'))
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli16)
								TriggerServerEvent('esx_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                hasrobbed16 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -620.6110, -226.4467, 38.05, true) < 0.5 ) then
							if (hasrobbed17 == false) then
							
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -620.6110, -226.4467, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								DisplayHelpText(_U('collectinprogress'))
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli17)
								TriggerServerEvent('esx_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                hasrobbed17 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -623.9951, -228.1755, 38.05, true) < 0.5 ) then
							if (hasrobbed18 == false) then
							
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -623.9951, -228.1755, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								DisplayHelpText(_U('collectinprogress'))
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli18)
								TriggerServerEvent('esx_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                hasrobbed18 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -624.8832, -227.8645, 38.05, true) < 0.5 ) then
							if (hasrobbed19 == false) then
							
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -624.8832, -227.8645, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								DisplayHelpText(_U('collectinprogress'))
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli19)
								TriggerServerEvent('esx_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                hasrobbed19 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -623.6746, -227.0025, 38.05, true) < 0.5 ) then
							if (hasrobbed20 == false) then
							
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -623.6746, -227.0025, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								DisplayHelpText(_U('collectinprogress'))
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli20)
								TriggerServerEvent('esx_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                hasrobbed20 = true
							end
							end
							end

							if (hasrobbed == true) and (hasrobbed2 == true) and (hasrobbed3 == true) and (hasrobbed4 == true) and (hasrobbed5 == true) and (hasrobbed6 == true) and (hasrobbed7 == true) and (hasrobbed8 == true) and (hasrobbed9 == true) and (hasrobbed10 == true) and (hasrobbed11 == true) and (hasrobbed12 == true) and (hasrobbed13 == true) and (hasrobbed14 == true) and (hasrobbed15 == true) and (hasrobbed16 == true) and (hasrobbed17 == true) and (hasrobbed18 == true) and (hasrobbed19 == true) and (hasrobbed20 == true) then
							holdingup = false
							
							hasrobbed = false
                            hasrobbed2 = false
                            hasrobbed3 = false
                            hasrobbed4 = false
                            hasrobbed5 = false
                            hasrobbed6 = false
                            hasrobbed7 = false
                            hasrobbed8 = false
                            hasrobbed9 = false
                            hasrobbed10 = false
                            hasrobbed11 = false
                            hasrobbed12 = false
                            hasrobbed13 = false
                            hasrobbed14 = false
                            hasrobbed15 = false
                            hasrobbed16 = false
                            hasrobbed17 = false
                            hasrobbed18 = false
                            hasrobbed19 = false
                            hasrobbed20 = false
							TriggerServerEvent('esx_vangelico_robbery:endrob', store)
							--ESX.ShowNotification(_U('lester'))
							TriggerEvent('skinchanger:getSkin', function(skin)
	
		                       if skin.sex == 0 then

		                              local clothesSkin = {
		                              ['bags_1'] = 41, ['bags_2'] = 0
		                              }
		                          TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

		                        else

		                              local clothesSkin = {
		                              ['bags_1'] = 41, ['bags_2'] = 0
		                              }
	                              TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

	                           end
	                        end)
							end	

			local pos2 = Stores[store].position

			if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -622.566, -230.183, 38.057, true) > 11.5 ) then
				TriggerServerEvent('esx_vangelico_robbery:toofar', store)
				holdingup = false
				RemoveBlip(gioielli1)
				RemoveBlip(gioielli2)
				RemoveBlip(gioielli3)
				RemoveBlip(gioielli4)
				RemoveBlip(gioielli5)
				RemoveBlip(gioielli6)
				RemoveBlip(gioielli7)
				RemoveBlip(gioielli8)
				RemoveBlip(gioielli9)
				RemoveBlip(gioielli10)
				RemoveBlip(gioielli11)
				RemoveBlip(gioielli12)
				RemoveBlip(gioielli13)
				RemoveBlip(gioielli14)
				RemoveBlip(gioielli15)
				RemoveBlip(gioielli16)
				RemoveBlip(gioielli17)
				RemoveBlip(gioielli18)
				RemoveBlip(gioielli19)
				RemoveBlip(gioielli20)
				
				hasrobbed = false
                hasrobbed2 = false
                hasrobbed3 = false
                hasrobbed4 = false
                hasrobbed5 = false
                hasrobbed6 = false
                hasrobbed7 = false
                hasrobbed8 = false
                hasrobbed9 = false
                hasrobbed10 = false
                hasrobbed11 = false
                hasrobbed12 = false
                hasrobbed13 = false
                hasrobbed14 = false
                hasrobbed15 = false
                hasrobbed16 = false
                hasrobbed17 = false
                hasrobbed18 = false
                hasrobbed19 = false
                hasrobbed20 = false
			end
		end

		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_vangelico_robbery:togliblip')
AddEventHandler('esx_vangelico_robbery:togliblip', function(robb)
	RemoveBlip(gioielli1)
	RemoveBlip(gioielli2)
	RemoveBlip(gioielli3)
	RemoveBlip(gioielli4)
	RemoveBlip(gioielli5)
	RemoveBlip(gioielli6)
	RemoveBlip(gioielli7)
	RemoveBlip(gioielli8)
	RemoveBlip(gioielli9)
	RemoveBlip(gioielli10)
	RemoveBlip(gioielli11)
	RemoveBlip(gioielli12)
	RemoveBlip(gioielli13)
	RemoveBlip(gioielli14)
	RemoveBlip(gioielli15)
	RemoveBlip(gioielli16)
	RemoveBlip(gioielli17)
	RemoveBlip(gioielli18)
	RemoveBlip(gioielli19)
	RemoveBlip(gioielli20)
	robinprogress = false
end)
--[[
RegisterNetEvent("lester:createBlip")
AddEventHandler("lester:createBlip", function(type, x, y, z)
	local blip = AddBlipForCoord(x, y, z)
	SetBlipSprite(blip, type)
	SetBlipColour(blip, 1)
	SetBlipScale(blip, 0.8)
	SetBlipAsShortRange(blip, true)
	if(type == 77)then
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Lester")
		EndTextCommandSetBlipName(blip)
	end
end)

Citizen.CreateThread(function()
		TriggerEvent('lester:createBlip', 77, 706.669, -966.898, 30.413)

    while true do
       Citizen.Wait(0)
       playerPed = GetPlayerPed(-1)
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		
		if pos then
				
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 706.669, -966.898, 30.413, true) <= 5 then
					TriggerServerEvent('lester:vendita')
                    Citizen.Wait(4000)
                    TriggerEvent('skinchanger:getSkin', function(skin)
	
		                       if skin.sex == 0 then

		                              local clothesSkin = {
		                              ['bags_1'] = 0, ['bags_2'] = 0
		                              }
		                          TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

		                        else

		                              local clothesSkin = {
		                              ['bags_1'] = 0, ['bags_2'] = 0
		                              }
	                              TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

	                           end
	                end)
				end	
		end
    end
end)
--]]
