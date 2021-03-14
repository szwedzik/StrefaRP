local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local GUI = {}
ESX                           = nil
GUI.Time                      = 0
local PlayerData              = {}
local jobs = {'offambulance','offpolice','police','sheriff','offsheriff','statepolice','offstatepolice','ambulance', 'taxi', 'offtaxi'--[[,'zwierzako','offzwierzako']]}
local show = false

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

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	Citizen.Wait(5000)
end)

AddEventHandler('esx_duty:hasEnteredMarker', function (zone)
	if zone ~= nil then
		--CurrentAction     = 'onoff'
		--CurrentActionMsg = _U('duty')
	end
end)

AddEventHandler('esx_duty:hasExitedMarker', function (zone)
	CurrentAction = nil
end)

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(5)
        if CurrentAction ~= nil then
            for k,v in pairs(jobs) do
				if PlayerData.job ~= nil then
					if PlayerData.job.name == v then
						show = true
					end
				end
            end
		else
			show = false
        end
    end 
end)

RegisterCommand('sluzba', function(source)
	TriggerServerEvent('duty:onoff')
end)

-- RegisterCommand("wyrzucgps",function(source, args)
-- 	if  PlayerData.job ~= nil and (PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'statepolice') then
-- 		local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
-- 		local street = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
-- 		local drogi = GetStreetNameFromHashKey(street)
-- 		TriggerServerEvent('duty:alert', drogi, plyPos.x, plyPos.y, plyPos.z)
-- 		PowiadomPsy()

-- 		TriggerServerEvent('duty:onoff')
--     end
-- end, false)

RegisterNetEvent('duty:infodlalspd')
AddEventHandler('duty:infodlalspd', function(x, y, z)	
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' or PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'statepolice' then
        PlaySoundFrontend(-1, "CHECKPOINT_MISSED", "HUD_MINI_GAME_SOUNDSET", 1)
		local blip = AddBlipForCoord(x, y, z)
		SetBlipSprite(blip, 161)
        SetBlipScale(blip, 1.2)
        SetBlipColour(blip, 75)
        SetBlipAlpha(blip, 180)
        SetBlipHighDetail(blip, true)
	    BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Utracono połączenie  z funkcjonariuszem')
        EndTextCommandSetBlipName(blip)
        Citizen.Wait(60000)
        RemoveBlip(blip)
	end
end)

function PowiadomPsy()
	x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
	playerX = tonumber(string.format("%.2f", x))
    playerY = tonumber(string.format("%.2f", y))
    playerZ = tonumber(string.format("%.2f", z))
	TriggerServerEvent('duty:alert1', playerX, playerY, playerZ)
	Citizen.Wait(500)
end

Citizen.CreateThread(function ()
    while true do
		Citizen.Wait(5)
		if show then
			if IsControlJustPressed(0, Keys['E']) then
				TriggerServerEvent('duty:onoff')
			end
			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(5)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		for k,v in pairs(jobs) do
			if PlayerData.job ~= nil then
				if PlayerData.job.name == v then
					for k,v in pairs(Config.Zones) do
						if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
							--DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z + 0.1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 25, false, true, 2, false, false, false, false)
						end
					end
			end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(5)
		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil
		for k,v in pairs(Config.Zones) do
			if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
				isInMarker  = true
				currentZone = k
			end
		end
		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerEvent('esx_duty:hasEnteredMarker', currentZone)
		end
		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_duty:hasExitedMarker', LastZone)
		end
	end
end)
