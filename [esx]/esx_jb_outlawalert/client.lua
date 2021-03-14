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

local timer = 1 --in minutes - Set the time during the player is outlaw
local showOutlaw = true --Set if show outlaw act on map
local gunshotAlert = true --Set if show alert when player use gun
local drugAlert = true --Set if show alert when player use gun
local carJackingAlert = true --Set if show when player do carjacking
local meleeAlert = true --Set if show when player fight in melee
local blipGunTime = 180 --in second
local blipMeleeTime = 7 --in second
local blipJackingTime = 180 -- in second
local showcopsmisbehave = false  --show notification when cops steal to
local timing = timer * 60000 --Don't touche it
local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }
local closestNpc = nil
local directions = { [0] = 'N', [45] = 'NW', [90] = 'W', [135] = 'SW', [180] = 'S', [225] = 'SE', [270] = 'E', [315] = 'NE', [360] = 'N', } 
local guns = {
  ['weapon_knife'] = 'knife',
  ['weapon_crowbar'] = 'crow bar',
  ['weapon_pistol'] = 'pistol',
  ['weapon_combatpistol'] = 'combat pistol',
  ['weapon_appistol'] = 'ap pistol',
  ['weapon_pistol50'] = 'pistol .50',
  ['weapon_microsmg'] = 'micro smg',
  ['weapon_smg'] = 'smg',
  ['weapon_assaultsmg'] = 'assault smg',
  ['weapon_assaultrifle'] = 'assault rifle',
  ['weapon_carbinerifle'] = 'carbine rifle',
  ['weapon_advancedrifle'] = 'advanced rifle',
  ['weapon_mg'] = 'mg',
  ['weapon_combatmg'] = 'combat mg',
  ['weapon_pumpshotgun'] = 'pump shotgun',
  ['weapon_sawnoffshotgun'] = 'sawed off shotgun',
  ['weapon_assaultshotgun'] = 'assault shotgun',
  ['weapon_bullpupshotgun'] = 'bullpup shotgun',
  ['weapon_stungun'] = 'taser',
  ['weapon_sniperrifle'] = 'sniper rifle',
  ['weapon_heavysniper'] = 'heavy sniper',
  ['weapon_remotesniper'] = 'remote sniper',
  ['weapon_grenadelauncher'] = 'grenade launcher',
  ['weapon_rpg'] = 'rocket launcher',
  ['weapon_stinger'] = 'stinger',
  ['weapon_minigun'] = 'minigun',
  ['weapon_grenade'] = 'grenade',
  ['weapon_stickybomb'] = 'sticky bomb',
  ['weapon_smokegrenade'] = 'smoke grenade',
  ['weapon_bzgas'] = 'bz gas',
  ['weapon_molotov'] = 'molotov cocktail',
  ['weapon_digiscanner'] = 'digiscanner',
  ['weapon_snspistol'] = 'sns pistol',
  ['weapon_gusenberg'] = 'gusenberg sweeper',
  ['weapon_specialcarbine'] = 'special carbine',
  ['weapon_heavypistol'] = 'heavy pistol',
  ['weapon_bullpuprifle'] = 'bullpup rifle',
  ['weapon_dagger'] = 'dagger',
  ['weapon_vintagepistol'] = 'vintage pistol',
  ['weapon_firework'] = 'firework',
  ['weapon_musket'] = 'musket',
  ['weapon_heavyshotgun'] = 'heavy shotgun',
  ['weapon_marksmanrifle'] = 'marksman rifle',
  ['weapon_hominglauncher'] = 'homing launcher',
  ['weapon_proxmine'] = 'proximity mine',
  ['weapon_flaregun'] = 'flaregun',
  ['weapon_garbagebag'] = 'garbage bag',
  ['weapon_handcuffs'] = 'handcuffs',
  ['weapon_combatpdw'] = 'combat pdw',
  ['weapon_marksmanpistol'] = 'marksman pistol',
  ['weapon_knuckle'] = 'knuckledusters',
  ['weapon_hatchet'] = 'hatchet',
  ['weapon_railgun'] = 'railgun',
  ['weapon_machete'] = 'machete',
  ['weapon_machinepistol'] = 'machine pistol',
  ['weapon_switchblade'] = 'switchblade',
  ['weapon_revolver'] = 'heavy revolver',
  ['weapon_dbshotgun'] = 'double barrel shotgun',
  ['weapon_compactrifle'] = 'compact rifle',
  ['weapon_autoshotgun'] = 'auto shotgun',
  ['weapon_battleaxe'] = 'battle axe',
  ['weapon_compactlauncher'] = 'compact launcher',
  ['weapon_minismg'] = 'mini smg',
  ['weapon_pipebomb'] = 'pipe bomb',
  ['weapon_poolcue'] = 'pool cue',
  ['gadget_nightvision'] = 'night vision',
  ['gadget_parachute'] = 'parachute',
  ['weapon_flare'] = 'flare gun',
  ['weapon_snspistol_mk2'] = 'SNS Pistol Mk II',
  ['weapon_revolver_mk2'] = 'Heavy Revolver Mk II',
  ['weapon_doubleaction'] = 'Double-Action Revolver',
  ['weapon_specialcarabine_mk2'] = 'Special Carbine Mk II',
  ['weapon_bullpruprifle_mk2'] = 'Bullpup Rifle Mk II',
  ['weapon_pumpshotgun_mk2'] = 'Pump Shotgun Mk II',
  ['weapon_marksmanrifle_mk2'] = 'Marksman Rifle Mk II',
  ['weapon_assaultrifle_mk2'] = 'Assault Rifle Mk II ',
  ['weapon_carbinerifle_mk2'] = 'Carbine Rifle Mk II ',
  ['weapon_combatmg_mk2'] = 'Combat MG Mk II',
  ['weapon_heavysniper_mk2'] = 'Heavy Sniper Mk II',
  ['weapon_pistol_mk2'] = 'Pistol Mk II',
  ['weapon_smg_mk2'] = 'SMG Mk II' }
local colorNames = {
    ['0'] = "Metallic Black",
    ['1'] = "Metallic Graphite Black",
    ['2'] = "Metallic Black Steal",
    ['3'] = "Metallic Dark Silver",
    ['4'] = "Metallic Silver",
    ['5'] = "Metallic Blue Silver",
    ['6'] = "Metallic Steel Gray",
    ['7'] = "Metallic Shadow Silver",
    ['8'] = "Metallic Stone Silver",
    ['9'] = "Metallic Midnight Silver",
    ['10'] = "Metallic Gun Metal",
    ['11'] = "Metallic Anthracite Grey",
    ['12'] = "Matte Black",
    ['13'] = "Matte Gray",
    ['14'] = "Matte Light Grey",
    ['15'] = "Util Black",
    ['16'] = "Util Black Poly",
    ['17'] = "Util Dark silver",
    ['18'] = "Util Silver",
    ['19'] = "Util Gun Metal",
    ['20'] = "Util Shadow Silver",
    ['21'] = "Worn Black",
    ['22'] = "Worn Graphite",
    ['23'] = "Worn Silver Grey",
    ['24'] = "Worn Silver",
    ['25'] = "Worn Blue Silver",
    ['26'] = "Worn Shadow Silver",
    ['27'] = "Metallic Red",
    ['28'] = "Metallic Torino Red",
    ['29'] = "Metallic Formula Red",
    ['30'] = "Metallic Blaze Red",
    ['31'] = "Metallic Graceful Red",
    ['32'] = "Metallic Garnet Red",
    ['33'] = "Metallic Desert Red",
    ['34'] = "Metallic Cabernet Red",
    ['35'] = "Metallic Candy Red",
    ['36'] = "Metallic Sunrise Orange",
    ['37'] = "Metallic Classic Gold",
    ['38'] = "Metallic Orange",
    ['39'] = "Matte Red",
    ['40'] = "Matte Dark Red",
    ['41'] = "Matte Orange",
    ['42'] = "Matte Yellow",
    ['43'] = "Util Red",
    ['44'] = "Util Bright Red",
    ['45'] = "Util Garnet Red",
    ['46'] = "Worn Red",
    ['47'] = "Worn Golden Red",
    ['48'] = "Worn Dark Red",
    ['49'] = "Metallic Dark Green",
    ['50'] = "Metallic Racing Green",
    ['51'] = "Metallic Sea Green",
    ['52'] = "Metallic Olive Green",
    ['53'] = "Metallic Green",
    ['54'] = "Metallic Gasoline Blue Green",
    ['55'] = "Matte Lime Green",
    ['56'] = "Util Dark Green",
    ['57'] = "Util Green",
    ['58'] = "Worn Dark Green",
    ['59'] = "Worn Green",
    ['60'] = "Worn Sea Wash",
    ['61'] = "Metallic Midnight Blue",
    ['62'] = "Metallic Dark Blue",
    ['63'] = "Metallic Saxony Blue",
    ['64'] = "Metallic Blue",
    ['65'] = "Metallic Mariner Blue",
    ['66'] = "Metallic Harbor Blue",
    ['67'] = "Metallic Diamond Blue",
    ['68'] = "Metallic Surf Blue",
    ['69'] = "Metallic Nautical Blue",
    ['70'] = "Metallic Bright Blue",
    ['71'] = "Metallic Purple Blue",
    ['72'] = "Metallic Spinnaker Blue",
    ['73'] = "Metallic Ultra Blue",
    ['74'] = "Metallic Bright Blue",
    ['75'] = "Util Dark Blue",
    ['76'] = "Util Midnight Blue",
    ['77'] = "Util Blue",
    ['78'] = "Util Sea Foam Blue",
    ['79'] = "Uil Lightning blue",
    ['80'] = "Util Maui Blue Poly",
    ['81'] = "Util Bright Blue",
    ['82'] = "Matte Dark Blue",
    ['83'] = "Matte Blue",
    ['84'] = "Matte Midnight Blue",
    ['85'] = "Worn Dark blue",
    ['86'] = "Worn Blue",
    ['87'] = "Worn Light blue",
    ['88'] = "Metallic Taxi Yellow",
    ['89'] = "Metallic Race Yellow",
    ['90'] = "Metallic Bronze",
    ['91'] = "Metallic Yellow Bird",
    ['92'] = "Metallic Lime",
    ['93'] = "Metallic Champagne",
    ['94'] = "Metallic Pueblo Beige",
    ['95'] = "Metallic Dark Ivory",
    ['96'] = "Metallic Choco Brown",
    ['97'] = "Metallic Golden Brown",
    ['98'] = "Metallic Light Brown",
    ['99'] = "Metallic Straw Beige",
    ['100'] = "Metallic Moss Brown",
    ['101'] = "Metallic Biston Brown",
    ['102'] = "Metallic Beechwood",
    ['103'] = "Metallic Dark Beechwood",
    ['104'] = "Metallic Choco Orange",
    ['105'] = "Metallic Beach Sand",
    ['106'] = "Metallic Sun Bleeched Sand",
    ['107'] = "Metallic Cream",
    ['108'] = "Util Brown",
    ['109'] = "Util Medium Brown",
    ['110'] = "Util Light Brown",
    ['111'] = "Metallic White",
    ['112'] = "Metallic Frost White",
    ['113'] = "Worn Honey Beige",
    ['114'] = "Worn Brown",
    ['115'] = "Worn Dark Brown",
    ['116'] = "Worn straw beige",
    ['117'] = "Brushed Steel",
    ['118'] = "Brushed Black steel",
    ['119'] = "Brushed Aluminium",
    ['120'] = "Chrome",
    ['121'] = "Worn Off White",
    ['122'] = "Util Off White",
    ['123'] = "Worn Orange",
    ['124'] = "Worn Light Orange",
    ['125'] = "Metallic Securicor Green",
    ['126'] = "Worn Taxi Yellow",
    ['127'] = "police car blue",
    ['128'] = "Matte Green",
    ['129'] = "Matte Brown",
    ['130'] = "Worn Orange",
    ['131'] = "Matte White",
    ['132'] = "Worn White",
    ['133'] = "Worn Olive Army Green",
    ['134'] = "Pure White",
    ['135'] = "Hot Pink",
    ['136'] = "Salmon pink",
    ['137'] = "Metallic Vermillion Pink",
    ['138'] = "Orange",
    ['139'] = "Green",
    ['140'] = "Blue",
    ['141'] = "Mettalic Black Blue",
    ['142'] = "Metallic Black Purple",
    ['143'] = "Metallic Black Red",
    ['144'] = "hunter green",
    ['145'] = "Metallic Purple",
    ['146'] = "Metaillic V Dark Blue",
    ['147'] = "MODSHOP BLACK1",
    ['148'] = "Matte Purple",
    ['149'] = "Matte Dark Purple",
    ['150'] = "Metallic Lava Red",
    ['151'] = "Matte Forest Green",
    ['152'] = "Matte Olive Drab",
    ['153'] = "Matte Desert Brown",
    ['154'] = "Matte Desert Tan",
    ['155'] = "Matte Foilage Green",
    ['156'] = "DEFAULT ALLOY COLOR",
    ['157'] = "Epsilon Blue",
}

GetPlayerName()
RegisterNetEvent('outlawNotify')
AddEventHandler('outlawNotify', function(alert)
	local ambulance10_13 = string.sub(alert,1 ,string.len('[^7Centrala]: ^810-13 ^7 - Rann'))
	if ambulance10_13 == '[^7Centrala]: ^810-13 ^7 - Rann' and ESX.GetPlayerData().job.name == 'ambulance' then
		TriggerEvent("chatMessage", "", {255,255,255}, alert)
	end
    if ESX.GetPlayerData().job ~= nil and  (ESX.GetPlayerData().job.name == 'police' or ESX.GetPlayerData().job.name == 'sheriff' or ESX.GetPlayerData().job.name == 'statepolice') then
        TriggerEvent("chatMessage", "", {255,255,255}, alert)
    end
end)

RegisterNetEvent('outlawNotifyLSFD')
AddEventHandler('outlawNotifyLSFD', function(alert)
    if ESX.GetPlayerData().job ~= nil and  (ESX.GetPlayerData().job.name == 'ambulance') then
        TriggerEvent("chatMessage", "", {255,255,255}, alert)
    end
end)

RegisterNetEvent('outlawNotifyJC')
AddEventHandler('outlawNotifyJC', function(alert)
    if ESX.GetPlayerData().job ~= nil and  (ESX.GetPlayerData().job.name == 'zwierzako') then
        TriggerEvent("chatMessage", "", {255,255,255}, alert)
    end
end)

function Notify(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, false)
end

Citizen.CreateThread(function()
    while true do
        Wait(10)
        if NetworkIsSessionStarted() then
            DecorRegister("IsOutlaw",  3)
            DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 1)
            return
        end
    end
end)

RegisterNetEvent('thiefPlace')
AddEventHandler('thiefPlace', function(tx, ty, tz)
	if ESX.GetPlayerData().job ~= nil and  (ESX.GetPlayerData().job.name == 'police' or ESX.GetPlayerData().job.name == 'sheriff' or ESX.GetPlayerData().job.name == 'statepolice') then
		SetBlipAlert(carJackingAlert, 'Kradzież', blipJackingTime, 10, 1, -1, tx, ty, tz)
	end
end)

RegisterNetEvent('drugPlace')
AddEventHandler('drugPlace', function(gx, gy, gz)
	if ESX.GetPlayerData().job ~= nil and  (ESX.GetPlayerData().job.name == 'police' or ESX.GetPlayerData().job.name == 'sheriff' or ESX.GetPlayerData().job.name == 'statepolice') then
		SetBlipAlert(drugAlert, 'Sprzedaż dragów', blipGunTime, 10, 1, -1, gx, gy, gz)
	end
end)

RegisterNetEvent('gunshotPlace')
AddEventHandler('gunshotPlace', function(gx, gy, gz, radius)
	if ESX.GetPlayerData().job ~= nil and  (ESX.GetPlayerData().job.name == 'police' or ESX.GetPlayerData().job.name == 'sheriff' or ESX.GetPlayerData().job.name == 'statepolice') then
		local transG = 250
		local gunshotBlip = AddBlipForRadius(gx, gy, gz, radius) 
		SetBlipAlpha(gunshotBlip,transG)
		SetBlipSprite(gunshotBlip, 9)
		SetBlipColour(gunshotBlip, 1)

		local gunshotBlip2 = AddBlipForCoord(gx, gy, gz)
		SetBlipSprite(gunshotBlip2,  119)
		SetBlipColour(gunshotBlip2,  1)
		SetBlipAlpha(gunshotBlip2,  transG)
		SetBlipScale(gunshotBlip2, 1.1)
		SetBlipAsShortRange(gunshotBlip2,  1)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Strzelanina')
		EndTextCommandSetBlipName(gunshotBlip2)
		while transG ~= 0 do
			Wait(blipGunTime * 2)
			--Wait(100)
			transG = transG - 1
			SetBlipAlpha(gunshotBlip,  transG)
			SetBlipAlpha(gunshotBlip2,  transG)
			if transG == 0 then
				SetBlipSprite(gunshotBlip,  9)
				SetBlipSprite(gunshotBlip2,  9)
				return;
			end
		end
	end
end)

RegisterNetEvent('npcrobPlace')
AddEventHandler('npcrobPlace', function(gx, gy, gz)
	if ESX.GetPlayerData().job ~= nil and  (ESX.GetPlayerData().job.name == 'police' or ESX.GetPlayerData().job.name == 'sheriff' or ESX.GetPlayerData().job.name == 'statepolice') then
		SetBlipAlert(drugAlert, 'Rabunek na obywatela', blipGunTime, 110, 1, -1, gx, gy, gz)	
	end
end)

function SetBlipAlert(blipEnabled, textComponent, blipTime, blipSprite, blipColour, blipScale, blipx, blipy, blipz)
	if blipEnabled then
		local transG = 250
		local blip = AddBlipForCoord(blipx, blipy, blipz)
		SetBlipSprite(blip,  blipSprite)
		SetBlipColour(blip,  blipColour)
		SetBlipAlpha(blip,  transG)
		if blipScale ~= -1 then
			SetBlipScale(gunshotBlip, blipScale)
		end
		SetBlipAsShortRange(blip,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(textComponent)
		EndTextCommandSetBlipName(blip)
		while transG ~= 0 do
			Wait(100)
			--Wait(blipTime * 4)
			transG = transG - 1
			SetBlipAlpha(blip,  transG)
			if transG == 0 then
				SetBlipSprite(blip,  2)
				return
			end
		end
	end
end

Citizen.CreateThread( function()
    while true do
        Wait(10)
        if DecorGetInt(GetPlayerPed(-1), "IsOutlaw") == 2 then
            Wait( math.ceil(timing) )
            DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 1)
        end
    end
end)

RegisterNetEvent('outlaw:npcrob')
AddEventHandler('outlaw:npcrob', function()
	local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
	local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
	local street1 = GetStreetNameFromHashKey(s1)
	local street2 = GetStreetNameFromHashKey(s2)
	local current_zone = zones[GetNameOfZone(plyPos.x, plyPos.y, plyPos.z)]
	for k,v in pairs(directions)do
		direction = GetEntityHeading(GetPlayerPed(-1))
		if(math.abs(direction - k) < 22.5)then
			direction = v
			break;
		end
	end
	Wait(1000)
	DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 2)
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
		local sex = nil
		if skin.sex == 0 then
			sex = "Mężczyzna"
		else
			sex = "Kobieta"
		end
		TriggerServerEvent('npcrobInProgressPos', plyPos.x, plyPos.y, plyPos.z)
		if s2 == 0 then
			TriggerServerEvent('npcrobInProgressS1', street1, sex, current_zone, direction)
		elseif s2 ~= 0 then
			TriggerServerEvent('npcrobInProgress', street1, street2, sex, current_zone, direction)
		end
	end)
end)

RegisterNetEvent('outlaw:lockpick')
AddEventHandler('outlaw:lockpick', function()
	local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
	local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
	local street1 = GetStreetNameFromHashKey(s1)
	local street2 = GetStreetNameFromHashKey(s2)
	local current_zone = zones[GetNameOfZone(plyPos.x, plyPos.y, plyPos.z)]
	for k,v in pairs(directions)do
		direction = GetEntityHeading(GetPlayerPed(-1))
		if(math.abs(direction - k) < 22.5)then
			direction = v
			break;
		end
	end
	Wait(3000)
	DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 2)
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)
	local vehicle =GetVehiclePedIsIn(playerPed,false)
	local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
	if closestNpc ~= nil then
		local pos = GetEntityCoords(closestNpc)
		local playerloc = GetEntityCoords(PlayerPedId())
		local distanceToPed = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, playerloc.x, playerloc.y, playerloc.z, true)
		if distanceToPed >= 50 then
		elseif distanceToPed < 50 then
			if PlayerData.job ~= nil and PlayerData.job.name == 'police' and showcopsmisbehave == false then
			elseif PlayerData.job ~= nil and PlayerData.job.name == 'police' and showcopsmisbehave then
				ESX.TriggerServerCallback('esx_outlawalert:ownvehicle',function(valid)
				if (valid) then
				else
					ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
						local sex = nil
						if skin.sex == 0 then
							sex = "Mężczyzna"
						else
							sex = "Kobieta"
						end
						ESX.ShowNotification('powinno wyslac')
						ESX.TriggerServerCallback('zrider:carTheftPromtRandomizer', function (inform)
							if inform then
								TriggerServerEvent('thiefInProgressPos', plyPos.x, plyPos.y, plyPos.z)
								local veh = GetClosestVehicle(plyPos.x, plyPos.y, plyPos.z, 4.0, 0)
								if not(IsEntityAVehicle(veh)) then veh = nil 
								end
								local vehName = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
								local vehName2 = GetLabelText(vehName)
								local plate = GetVehicleNumberPlateText(veh)
								local primary, secondary = GetVehicleColours(veh)
								primary = colorNames[tostring(primary)]
								secondary = colorNames[tostring(secondary)]
								if s2 == 0 then
									if IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) then
										TriggerServerEvent('thiefInProgressS1Police', street1, vehName2, sex, current_zone, direction, plate, primary, secondary)
									else
										TriggerServerEvent('thiefInProgressS1', street1, vehName2, sex, current_zone, direction, plate, primary, secondary)
									end
								elseif s2 ~= 0 then
									if IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) then
										TriggerServerEvent('thiefInProgressPolice', street1, street2, vehName2, sex, current_zone, direction, plate, primary, secondary)
									else
										TriggerServerEvent('thiefInProgress', street1, street2, vehName2, sex, current_zone, direction, plate, primary, secondary)
									end
								end
							end
						end)	
					end)
				end
			end, vehicleProps)
		end
	end
	else
		ESX.TriggerServerCallback('esx_outlawalert:ownvehicle',function(valid)
			if (valid) then
			else
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					local sex = nil
					if skin.sex == 0 then
						sex = "Mężczyzna"
					else
						sex = "Kobieta"
					end
					ESX.TriggerServerCallback('zrider:carTheftPromtRandomizer', function(notify)
					if notify then
					TriggerServerEvent('thiefInProgressPos', plyPos.x, plyPos.y, plyPos.z)
					local veh = GetClosestVehicle(plyPos.x, plyPos.y, plyPos.z, 4.0, 0)
					if not(IsEntityAVehicle(veh)) then veh = nil end
					local vehName = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
					local vehName2 = GetLabelText(vehName)
					local plate = GetVehicleNumberPlateText(veh)
					local primary, secondary = GetVehicleColours(veh)
					primary = colorNames[tostring(primary)]
					secondary = colorNames[tostring(secondary)]
					if s2 == 0 then
						TriggerServerEvent('thiefInProgressS1', street1, vehName2, sex, current_zone, direction, plate, primary, secondary)
					elseif s2 ~= 0 then
						TriggerServerEvent('thiefInProgress', street1, street2, vehName2, sex, current_zone, direction, plate, primary, secondary)
					end
					end
					end)
				end)
			end
		end,vehicleProps)
	end
end)

RegisterNetEvent('outlaw:drugs')
AddEventHandler('outlaw:drugs', function()
	local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
	local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
	local street1 = GetStreetNameFromHashKey(s1)
	local street2 = GetStreetNameFromHashKey(s2)
	local current_zone = zones[GetNameOfZone(plyPos.x, plyPos.y, plyPos.z)]
	for k,v in pairs(directions)do
		direction = GetEntityHeading(GetPlayerPed(-1))
		if(math.abs(direction - k) < 22.5)then
			direction = v
			break;
		end
	end
	Wait(3000)
	DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 2)
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' and showcopsmisbehave == false then
	elseif PlayerData.job ~= nil and PlayerData.job.name == 'police' and showcopsmisbehave then
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
			local sex = nil
			if skin.sex == 0 then
				sex = "Mężczyzna"
			else
				sex = "Kobieta"
			end
			TriggerServerEvent('drugInProgressPos', plyPos.x, plyPos.y, plyPos.z)
			if s2 == 0 then
				TriggerServerEvent('drugInProgressS1', street1, sex, current_zone, direction)
			elseif s2 ~= 0 then
				TriggerServerEvent('drugInProgress', street1, street2, sex, current_zone, direction)
			end
		end)
	else
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
			local sex = nil
			if skin.sex == 0 then
				sex = "Mężczyzna"
			else
				sex = "Kobieta"
			end
			TriggerServerEvent('drugInProgressPos', plyPos.x, plyPos.y, plyPos.z)
			if s2 == 0 then
				TriggerServerEvent('drugInProgressS1', street1, sex, current_zone, direction)
			elseif s2 ~= 0 then
				TriggerServerEvent('drugInProgress', street1, street2, sex, current_zone, direction)
			end
		end)
	end
end)

Citizen.CreateThread( function()
	while true do
		Wait(1500)
		if ( IsPedTryingToEnterALockedVehicle(GetPlayerPed(-1)) or IsPedJacking(GetPlayerPed(-1)) )  then
			local chanceCarJack = math.random(0,100)
			if chanceCarJack > 80 then  
				local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
				local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
				local street1 = GetStreetNameFromHashKey(s1)
				local street2 = GetStreetNameFromHashKey(s2)
				local current_zone = zones[GetNameOfZone(plyPos.x, plyPos.y, plyPos.z)]
				for k,v in pairs(directions)do
					direction = GetEntityHeading(GetPlayerPed(-1))
					if(math.abs(direction - k) < 22.5)then
						direction = v
						break
					end
				end
				Wait(3000)
				DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 2)
				local playerPed = GetPlayerPed(-1)
				local coords    = GetEntityCoords(playerPed)
				local vehicle = GetVehiclePedIsIn(playerPed,false)
				local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
				if PlayerData.job ~= nil and PlayerData.job.name == 'police' and showcopsmisbehave == false then
				elseif PlayerData.job ~= nil and PlayerData.job.name == 'police' and showcopsmisbehave then
					ESX.TriggerServerCallback('esx_outlawalert:ownvehicle',function(valid)
						if (valid) then
						else
							ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
								local sex = nil
								if skin.sex == 0 then
									sex = "Mężczyzna"
								else
									sex = "Kobieta"
								end
								ESX.TriggerServerCallback('zrider:carTheftPromtRandomizer', function(notify)
									if notify then
								TriggerServerEvent('thiefInProgressPos', plyPos.x, plyPos.y, plyPos.z)
								local veh = GetClosestVehicle(plyPos.x, plyPos.y, plyPos.z, 4.0, 0, 71)
								local vehName = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
								local vehName2 = GetLabelText(vehName)
								local plate = GetVehicleNumberPlateText(veh)
								local primary, secondary = GetVehicleColours(veh)
								primary = colorNames[tostring(primary)]
								secondary = colorNames[tostring(secondary)]
								if s2 == 0 then
									if IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) then
										TriggerServerEvent('thiefInProgressS1Police', street1, vehName2, sex, current_zone, direction, plate, primary, secondary)
									else
										TriggerServerEvent('thiefInProgressS1', street1, vehName2, sex, current_zone, direction, plate, primary, secondary)
									end
								elseif s2 ~= 0 then
									if IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) then
										TriggerServerEvent('thiefInProgressPolice', street1, street2, vehName2, sex, current_zone, direction, plate, primary, secondary)
									else
										TriggerServerEvent('thiefInProgress', street1, street2, vehName2, sex, current_zone, direction, plate, primary, secondary)
									end
								end
								end
								end)
							end)
						end
					end,vehicleProps)
				else
					ESX.TriggerServerCallback('esx_outlawalert:ownvehicle',function(valid)
						if (valid) then
						else
							ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
								local sex = nil
								if skin.sex == 0 then
									sex = "Mężczyzna"
								else
									sex = "Kobieta"
								end

								ESX.TriggerServerCallback('zrider:carTheftPromtRandomizer', function(notify)
									if notify then
								TriggerServerEvent('thiefInProgressPos', plyPos.x, plyPos.y, plyPos.z)
								local veh = GetClosestVehicle(plyPos.x, plyPos.y, plyPos.z, 4.0, 0, 71)
								local vehName = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
								local vehName2 = GetLabelText(vehName)
								local plate = GetVehicleNumberPlateText(veh)
								local primary, secondary = GetVehicleColours(veh)
								primary = colorNames[tostring(primary)]
								secondary = colorNames[tostring(secondary)]
								if s2 == 0 then
									TriggerServerEvent('thiefInProgressS1', street1, vehName2, sex, current_zone, direction, plate, primary, secondary)
								elseif s2 ~= 0 then
									TriggerServerEvent('thiefInProgress', street1, street2, vehName2, sex, current_zone, direction, plate, primary, secondary)
								end
								end
								end)
							end)
						end
					end,vehicleProps)
				end
			end
		end
	end
end)

-- Melee - Disabled
-- local melCount = 0
-- Citizen.CreateThread( function()
	-- while true do
		-- Wait(100)
		-- if IsPedInMeleeCombat(GetPlayerPed(-1)) and not IsControlPressed(0, 25) then
			-- melCount = melCount + 1
			-- local chanceMelee = math.random(0,100)
			-- if chanceMelee > 15 then
				-- melCount = 0
			-- end
			-- local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
			-- local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
			-- local street1 = GetStreetNameFromHashKey(s1)
			-- local street2 = GetStreetNameFromHashKey(s2)
			-- local current_zone = zones[GetNameOfZone(plyPos.x, plyPos.y, plyPos.z)]
			-- for k,v in pairs(directions)do
				-- direction = GetEntityHeading(GetPlayerPed(-1))
				-- if(math.abs(direction - k) < 22.5)then
					-- direction = v
					-- break
				-- end
			-- end
             -- DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 2)
			 -- if melCount == 1 and PlayerData.job ~= nil and PlayerData.job.name == 'police' and showcopsmisbehave == false then
			 -- elseif  melCount == 1 and PlayerData.job ~= nil and PlayerData.job.name == 'police' and showcopsmisbehave then
				 -- ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					 -- local sex = nil
					 -- if skin.sex == 0 then
						 -- sex = "Mężczyzna"
					 -- else
						 -- sex = "Kobieta"
					 -- end
					 -- TriggerServerEvent('meleeInProgressPos', plyPos.x, plyPos.y, plyPos.z)
					 -- if s2 == 0 then
						 -- TriggerServerEvent('meleeInProgressS1', street1, sex, current_zone, direction)
					 -- elseif s2 ~= 0 then
						 -- TriggerServerEvent("meleeInProgress", street1, street2, sex, current_zone, direction)
					 -- end
					 -- melCount = 0
				 -- end)
				 -- Wait(3000)
			 -- else
			 	-- if  melCount == 1 then
				 -- ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					 -- local sex = nil
					 -- if skin.sex == 0 then
						 -- sex = "Mężczyzna"
					 -- else
						 -- sex = "Kobieta"
					 -- end
					 -- TriggerServerEvent('meleeInProgressPos', plyPos.x, plyPos.y, plyPos.z)
					 -- if s2 == 0 then
						 -- TriggerServerEvent('meleeInProgressS1', street1, sex, current_zone, direction)
					 -- elseif s2 ~= 0 then
						 -- TriggerServerEvent("meleeInProgress", street1, street2, sex, current_zone, direction)
					 -- end
					 -- melCount = 0
				 -- end)
				-- end
				 -- Wait(3000)
			 -- end
         -- end
     -- end
 -- end)

---Bronie Krótkie
Citizen.CreateThread( function()
    while true do
		Wait(10)
		if PlayerData.job ~= nil and PlayerData.job.name == 'police' and IsPedShooting(GetPlayerPed(-1)) then
			-- ignore cops
		elseif IsPedShooting(GetPlayerPed(-1)) 
		--Broń Biała
		and IsWeaponMelee(GetPlayerPed(-1)) == false
		--SMG
		and IsWeaponSMG(GetPlayerPed(-1)) == false
		--Szturmowe (długie)
		and IsWeaponRifle(GetPlayerPed(-1)) == false
		--Karabiny Snajperskie
		and IsWeaponSniper(GetPlayerPed(-1)) == false
		--Shotgun
		and IsWeaponShotgun(GetPlayerPed(-1)) == false
		--Broń Ciężka
		and IsWeaponHeavy(GetPlayerPed(-1)) == false
		--Broń Miotana
		and IsWeaponRanged(GetPlayerPed(-1)) == false
		then
			CallServerEventToSendShootNotification('gunshotInProgressPos','gunshotInProgressS1','gunshotInProgress')
		end
	end
end)
---Bronie Długie
Citizen.CreateThread( function()
    while true do
        Wait(10)
		if PlayerData.job ~= nil and PlayerData.job.name == 'police' and IsPedShooting(GetPlayerPed(-1)) then
			-- ignore cops
		elseif IsPedShooting(GetPlayerPed(-1)) 
		--Pistolety
		and IsWeaponPistol(GetPlayerPed(-1)) == false
		--Broń Biała
		and IsWeaponMelee(GetPlayerPed(-1)) == false
		--Broń Miotana
		and IsWeaponRanged(GetPlayerPed(-1)) == false
		then
			CallServerEventToSendShootNotification('gunshotInProgressPos','gunshotInProgressS1long','gunshotInProgresslong')
        end
    end
end)

local warnedNPCPed = nil

function CallServerEventToSendShootNotification(inProgressPosEvent, inProgressS1, inProgress)
	DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 2)
	local playerPos = GetEntityCoords(GetPlayerPed(-1),  true)
	local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, playerPos.x, playerPos.y, playerPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
	local street1 = GetStreetNameFromHashKey(s1)
	local street2 = GetStreetNameFromHashKey(s2)
	local current_zone = zones[GetNameOfZone(playerPos.x, playerPos.y, playerPos.z)]

	for k,v in pairs(directions)do
	  direction = GetEntityHeading(GetPlayerPed(-1))
	  if(math.abs(direction - k) < 22.5)then
		direction = v
		break;
	  end
	end
	local sleep = 3000
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
			local sex = nil
			if skin.sex == 0 then
				sex = "Mężczyzna"
			else
				sex = "Kobieta"
			end
			-- move position
			local shootPos = ShiftPos(playerPos)

			warnedNPCPed = FindClosestNPC(playerPos)
			if warnedNPCPed ~= nil and IsPedDeadOrDying(warnedNPCPed) == false then
				NPCMakingPhoneCall(warnedNPCPed)
				SetEntityMaxSpeed(warnedNPCPed, Config.WarnedNPCSpeed)
				local warnCops = WaitNPCBeforeCallingCops(warnedNPCPed)
				if warnCops then
					local warnedNPCPos = GetEntityCoords(warnedNPCPed,  true)
					-- send notification, npc escaped
					SendShootNotification(inProgressPosEvent, inProgressS1, inProgress, s1, s2, street1, street2, sex, current_zone, direction, shootPos, Config.ShiftBlipRadius)
					CleanUpNPCWarning(warnedNPCPed)
				else
					-- send notification, npc disposed
					if IsPedDeadOrDying(warnedNPCPed, true) then
						sleep = 0
					end
					CleanUpNPCWarning(warnedNPCPed)
				end
			end
		end)
		Wait(sleep)
end

function SendShootNotification(inProgressPosEvent, inProgressS1, inProgress, s1, s2, street1, street2, sex, current_zone, direction, shootPos, radius)
	TriggerServerEvent(inProgressPosEvent, shootPos.x, shootPos.y, shootPos.z, radius)
	if s2 == 0 then
		TriggerServerEvent(inProgressS1, street1, sex, current_zone, direction)
	elseif s2 ~= 0 then
		TriggerServerEvent(inProgress, street1, street2, sex, current_zone, direction)
	end
end

function ShiftPos(basePos)
	local shiftMin = Config.ShiftCoordsMin
	local shiftMax = Config.ShiftBlipRadius / 2
	if shiftMin > shiftMax then
		shiftMax = shiftMin
	end

	local ShiftX = math.random(shiftMin,shiftMax) * 1.0
	local ShiftY = math.random(shiftMin,shiftMax) * 1.0

	local addShift = true
	if math.random(1,2) == 2 then
		addShift = false
	end
	
	local pos = {x=0, y=0, z=basePos.z}
	if addShift then
		pos.x = basePos.x + ShiftX
		pos.y = basePos.y + ShiftY
	else
		pos.x = basePos.x - ShiftX
		pos.y = basePos.y - ShiftY
	end
	return pos
end
