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

local PoliceGUI               = false
local PlayerData              = {}

ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('projektsantos:mandatnotify')
AddEventHandler('projektsantos:mandatnotify', function(fine, id, powod, przedrostek)

	ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)

		local name = data.firstname .. ' ' .. data.lastname
		--TriggerEvent('chat:addMessage', { args = { przedrostek .. ': ^7^*' .. name .. ' ^7^*otrzymał/a mandat w wysokości: ^2^*' .. fine .. '$ ^7^*Powód: ^2^*' .. powod}, color = { 147, 196, 109 } })

		TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(69, 124, 1, 0.6); border-radius: 3px;"><i class="fas fa-globe"></i> {0}:<br> {1}</div>',
			args = { '^2MANDAT^7^*', (name..' otrzymał/a mandat karny w wysokości: ^2^*'..fine..'$ ^7^*Powód: '..powod) }
		})
		
	end, id)
end)

RegisterNetEvent('projektsantos:jailnotify')
AddEventHandler('projektsantos:jailnotify', function(jailtime, id, powod, przedrostek)

	ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)

		local name = data.firstname .. ' ' .. data.lastname
		--TriggerEvent('chat:addMessage', { args = { przedrostek .. ': ^7^*' .. name .. ' ^7^*został/a skazany/a na: ^2^*' .. jailtime .. ' lat ^7^*Powód: ^2^*' .. powod}, color = { 147, 196, 109 } })
		
		TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(69, 124, 1, 0.6); border-radius: 3px;"><i class="fas fa-globe"></i> {0}:<br> {1}</div>',
			args = { '^2SĘDZIA^7^*', (name..' ^7^*został/a skazany/a na: ^2^*'..jailtime..' lat ^7^*Powód: '..powod) }
		})
	end, id)

end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

Citizen.CreateThread(function()	
	while true do
		Citizen.Wait(1)
		if PlayerData.job ~= nil and (PlayerData.job.name == 'police' or PlayerData.job.name == 'offpolice') then
			if IsControlJustPressed(0, Keys["M"]) then
				if PlayerData.job.name == 'police' then
					if not PoliceGUI then
						SetNuiFocus(true, true)
						SendNUIMessage({type = 'open'})
						PoliceGUI = true
						PhonePlayAnim('text')
					end
				else
					ESX.ShowNotification("~r~Nie jesteś na służbie!")
				end
			end
		end
	end
end)

RegisterNUICallback('NUIFocusOff', function()
	SetNuiFocus(false, false)
	PoliceGUI = false
	PhonePlayAnim('out')
end)

RegisterNUICallback('mandat', function(data, cb)
	local sender = GetPlayerServerId(player)
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent("projektsantos:mandat", GetPlayerServerId(closestPlayer), tonumber(data.mandatamount), data.mandatreason)
		ESX.ShowNotification('Wpłacono ~g~' .. 1000 .. '$ ~s~na twoje konto w banku.')	
		TriggerServerEvent("projektsantos:mandathajs", 1000)
	end	
end)

RegisterNUICallback('jail', function(data, cb)
	local sender = GetPlayerServerId(player)
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent("projektsantos:wiezienie", GetPlayerServerId(closestPlayer), data.jailtime, data.jailreason, tonumber(data.jailgrzywna))
		ESX.ShowNotification('Wpłacono ~g~' .. 1000 .. '$ ~s~na twoje konto w banku.')
		TriggerServerEvent("projektsantos:mandathajs", 1000)
	end
end)

RegisterNUICallback('insertKartoteka', function(data, cb)
	TriggerServerEvent('insertKarto', data)
	Notif('Trwa wstawianie wpisu w kartotece...', '~y~Kartoteka')
	Wait(1000)
	Notif('~y~Opublikowano wpis w kartotece: \nImię:~b~'..data.firstname..'~y~\nNazwisko ~b~'..data.lastname, '~y~Kartoteka')
end)

RegisterNUICallback('checkItemById', function(data, cb)
	ESX.TriggerServerCallback('openKarto', function(cb)	
		if cb ~= "" then
			SendNUIMessage({
				type = 'openKarto', 
				deta = cb
			})
		else
			print('xK3LY-TABELT-ADDON: Nie znaleziono wpisu w kartotece.')
		end
	end, data)
end)

RegisterNUICallback('findCarByPlate', function(data, cb)
	local vehicle = ESX.Game.GetVehicleInDirection()
	if DoesEntityExist(vehicle) then
		local vehicleData = ESX.Game.GetVehicleProperties(vehicle)

		Notif('~y~Trwa przeszukiwanie rejestru... \n\nNr.Rej: ~b~'..vehicleData.plate, '~y~Baza pojazdów')
		Wait(2000)

		ESX.TriggerServerCallback('esx_policejob:getVehicleFromPlate', function(owner, found)
			if found then
				Notif('~y~Właściciel: ~b~'..owner..'\n~y~Nr.Rej: ~b~'..vehicleData.plate, '~y~Baza pojazdów')
			else
				Notif('~r~Nie znaleziono pojazdu w rejestrze.', '~y~Baza pojazdów')
			end
		end, vehicleData.plate)
	else
		ESX.ShowNotification('Brak pojazdu w pobliżu.')
	end
end)

RegisterNUICallback('impoundCar', function(data, cb)
	TriggerEvent('lspd:holowanie')
end)

RegisterNUICallback('findKartoteka', function(data, cb)
	ESX.TriggerServerCallback('findKarto', function(cb)	
		local results = {}		

		if data.firstname == "" or data.lastname == "" then
			Notif('~r~Niepoprawnie wpisane dane osobowe!', '~y~Kartoteka')
			return
		end

		for i=1, #cb, 1 do
			local button = ('<td style="sortingLast"><button type="button" id="open-karto" onclick="OpenKarto(' .. cb[i].id .. ')";">Zobacz</button></td>')

			table.insert(results,
				'<tr style=\"color: #fff; border-bottom: 1px solid white;"><td class="sorting1">' .. cb[i].id .. '</td><td>' .. cb[i].firstname .. '</td><td>' .. cb[i].lastname .. '</td><td>' .. cb[i].dateofbirth .. '</td>'..button..'</tr>'
			)
		end

		Notif('~y~Wyszukiwanie danych...\nImię:~b~'..data.firstname..'~y~\nNazwisko ~b~'..data.lastname, '~y~Kartoteka')
		Wait(1000)

		if table.concat(results) == "" then
			Notif('~r~Nie znaleziono wyników pasujących ~y~\nImię:~b~'..data.firstname..'~y~\nNazwisko ~b~'..data.lastname, '~y~Kartoteka')
			return
		end

		SendNUIMessage({
			type = 'openResults', 
			deta = table.concat(results)
		})
	end, data)
end)


function Notif(msg, header)
	RequestStreamedTextureDict('WEB_LOSSANTOSPOLICEDEPT', true)

	SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
	Citizen.InvokeNative(0x1E6611149DB3DB6B, 'WEB_LOSSANTOSPOLICEDEPT', 'WEB_LOSSANTOSPOLICEDEPT', true, 7, 'LSPD', header, 2.0)
    DrawNotification_4(true, true)
    PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
	Wait(300)
	PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
end

------------------------------------------------------------------------

local myPedId = nil

local phoneProp = 0
local phoneModel = "prop_cs_tablet"
-- OR "prop_npc_phone"
-- OR "prop_npc_phone_02"
-- OR "prop_cs_phone_01"

local currentStatus = 'out'
local lastDict = nil
local lastAnim = nil
local lastIsFreeze = false

local ANIMS = {
	['cellphone@'] = {
		['out'] = {
			['text'] = 'cellphone_text_in',
			['call'] = 'cellphone_call_listen_base',
			
		},
		['text'] = {
			['out'] = 'cellphone_text_out',
			['call'] = 'cellphone_text_to_call',
		},
		['call'] = {
			['out'] = 'cellphone_call_out',
			['text'] = 'cellphone_call_to_text',
		}
	},
	['anim@cellphone@in_car@ps'] = {
		['out'] = {
			['text'] = 'cellphone_text_in',
			['call'] = 'cellphone_call_in',
		},
		['text'] = {
			['out'] = 'cellphone_text_out',
			['call'] = 'cellphone_text_to_call',
		},
		['call'] = {
			['out'] = 'cellphone_horizontal_exit',
			['text'] = 'cellphone_call_to_text',
		}
	}
}

function newPhoneProp()
	deletePhone()
	--(phoneModel)
	--while not HasModelLoaded(phoneModel) do
		--Citizen.Wait(1)
	--end
	phoneProp = CreateObject(GetHashKey('prop_cs_tablet'), 1.0, 1.0, 1.0, 1, 1, 0)
	local bone = GetPedBoneIndex(myPedId, 28422)
	AttachEntityToEntity(phoneProp, myPedId, bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
end

function deletePhone ()
	if phoneProp ~= 0 then
		Citizen.InvokeNative(0xAE3CBE5BF394C9C9 , Citizen.PointerValueIntInitialized(phoneProp))
		phoneProp = 0
	end
end

--[[
	out || text || Call ||
--]]
function PhonePlayAnim (status, freeze)
	if currentStatus == status then
		return
	end
	myPedId = GetPlayerPed(-1)
	local freeze = freeze or false

	local dict = "cellphone@"
	if IsPedInAnyVehicle(myPedId, false) then
		dict = "anim@cellphone@in_car@ps"
	end
	loadAnimDict(dict)

	local anim = ANIMS[dict][currentStatus][status]
	if currentStatus ~= 'out' then
		StopAnimTask(myPedId, lastDict, lastAnim, 1.0)
	end
	local flag = 50
	if freeze == true then
		flag = 14
	end
	TaskPlayAnim(myPedId, dict, anim, 3.0, -1, -1, flag, 0, false, false, false)

	if status ~= 'out' and currentStatus == 'out' then
		Citizen.Wait(380)
		newPhoneProp()
	end

	lastDict = dict
	lastAnim = anim
	lastIsFreeze = freeze
	currentStatus = status

	if status == 'out' then
		Citizen.Wait(180)
		deletePhone()
		StopAnimTask(myPedId, lastDict, lastAnim, 1.0)
	end

end

function PhonePlayOut ()
	PhonePlayAnim('out')
end

function PhonePlayText ()
	PhonePlayAnim('text')
end

function PhonePlayCall (freeze)
	PhonePlayAnim('call', freeze)
end

function PhonePlayIn () 
	if currentStatus == 'out' then
		PhonePlayText()
	end
end

function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(1)
	end
end