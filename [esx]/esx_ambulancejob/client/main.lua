Keys = {
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

local FirstSpawn, PlayerLoaded = true, false

IsDead = false
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerLoaded = true
	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)
--[[
AddEventHandler('playerSpawned', function()
	IsDead = false

	if FirstSpawn then
		exports.spawnmanager:setAutoSpawn(false) -- disable respawn
		FirstSpawn = false

		ESX.TriggerServerCallback('esx_ambulancejob:getDeathStatus', function(isDead)
			if isDead and Config.AntiCombatLog then
				while not PlayerLoaded do
					Citizen.Wait(1000)
				end

				--ESX.ShowNotification(_U('combatlog_message'))
				exports['mythic_notify']:DoCustomHudText('error', 'Jesteś w szpitalu ponieważ podczas udaru jednostki medyczne przetransportowały Cię na szpital.', 5500)
				RemoveItemsAfterRPDeath()
			end
		end)
	end
end)
--]]

RegisterNetEvent('esx_ambulancejob:multicharacter')
AddEventHandler('esx_ambulancejob:multicharacter', function()
	IsDead = false

		ESX.TriggerServerCallback('esx_ambulancejob:getDeathStatus', function(isDead)
			if isDead and Config.AntiCombatLog then
				--ESX.ShowNotification(_U('combatlog_message'))
				exports['mythic_notify']:DoCustomHudText('error', 'Jesteś w szpitalu ponieważ podczas udaru jednostki medyczne przetransportowały Cię na szpital.', 5500)
				RemoveItemsAfterRPDeath()
			end
		end)
end)

-- Create blips
Citizen.CreateThread(function()
	for k,v in pairs(Config.Hospitals) do
		local blip = AddBlipForCoord(v.Blip.coords)

		SetBlipSprite(blip, v.Blip.sprite)
		SetBlipScale(blip, v.Blip.scale)
		SetBlipColour(blip, v.Blip.color)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(_U('hospital'))
		EndTextCommandSetBlipName(blip)

		local blipFD = AddBlipForCoord(v.Blip2.coords)

		SetBlipSprite(blipFD, v.Blip2.sprite)
		SetBlipScale(blipFD, v.Blip2.scale)
		SetBlipColour(blipFD, v.Blip2.color)
		SetBlipAsShortRange(blipFD, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName("LSFD - Station 7")
		EndTextCommandSetBlipName(blipFD)
	end
end)

--[[
-- Disable most inputs when dead
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsDead then
			-- DisableAllControlActions(0)
			EnableControlAction(0, Keys["E"], true)
			EnableControlAction(0, 46, true)
			EnableControlAction(0, 51, true)
			EnableControlAction(0, 46, true)
			-- EnableControlAction(0, Keys["T"], true)
			-- EnableControlAction(0, Keys["Z"], true)
			-- EnableControlAction(0, Keys["X"], true)
			-- EnableControlAction(0, Keys["ESC"], true)
			-- EnableControlAction(0, 1, true)
			-- EnableControlAction(0, 2, true)
			DisableControlAction(0, 142, true) 
			DisableControlAction(0, 24,  true)
			DisableControlAction(0, 92,  true)
			DisableControlAction(0, 25,  true)
			DisableControlAction(0, 45,  true)
			DisableControlAction(0, 76,  true)
			DisableControlAction(0, 102,  true)
			DisableControlAction(0, 278,  true)
			DisableControlAction(0, 279,  true)
			DisableControlAction(0, 280,  true)
			DisableControlAction(0, 281,  true)
			DisableControlAction(0, 140, true) -- Attack
			DisableControlAction(2, 24, true) -- Attack
			DisableControlAction(2, 257, true) -- Attack 2
			DisableControlAction(2, 25, true) -- Aim
			DisableControlAction(2, 263, true) -- Melee Attack 1
			DisableControlAction(2, Keys['R'], true) -- Reload
			DisableControlAction(2, Keys['LEFTALT'], true)
			DisableControlAction(2, Keys['TOP'], true) -- Open phone (not needed?)
			DisableControlAction(2, Keys['Q'], true) -- Cover
			DisableControlAction(2, Keys['TAB'], true) -- Select Weapon
			DisableControlAction(2, Keys['F1'], true) -- Disable phone
			DisableControlAction(2, Keys['F2'], true) -- Inventory
			--DisableControlAction(2, Keys['F3'], true) -- Animations
			DisableControlAction(2, Keys['F6'], true)
			DisableControlAction(2, Keys['F7'], true)
			DisableControlAction(2, Keys['F9'], true)
			DisableControlAction(2, Keys['F10'], true)
			DisableControlAction(2, Keys['Y'], true)
			DisableControlAction(0, Keys['A'], true)
			DisableControlAction(0, Keys['D'], true)
			DisableControlAction(2, Keys["~"], true) 
 

		else
			Citizen.Wait(500)
		end
	end
end)
]]


-- Disable most inputs when dead
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsDead then
			DisableAllControlActions(0)
			EnableControlAction(0, Keys['Z'], true)
			EnableControlAction(0, Keys['X'], true)
			EnableControlAction(0, Keys['T'], true)
			EnableControlAction(0, Keys['E'], true)
		else
			Citizen.Wait(500)
		end
	end
end)


function OnPlayerDeath()
	IsDead = true
	ESX.UI.Menu.CloseAll()
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', true)

	StartDeathTimer()

	StartScreenEffect('DeathFailOut', 0, false)
end

RegisterNetEvent('esx_ambulancejob:useItem')
AddEventHandler('esx_ambulancejob:useItem', function(itemName)
	ESX.UI.Menu.CloseAll()

	if itemName == 'medkit' then
		local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
		local playerPed = PlayerPedId()

		exports['mythic_progbar']:Progress({
			name = "firstaid_action",
			duration = 20000,
			label = "Używanie Apteczki...",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
				disableMovement = false,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			},
			animation = {
				animDict = "missheistdockssetup1clipboard@idle_a",
				anim = "idle_a",
				flags = 49,
			},
			prop = {
				model = "prop_ld_health_pack"
			},
		})

		--[[ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

			Citizen.Wait(500)
			while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
				Citizen.Wait(0)
				DisableAllControlActions(0)
			end]]
	
			TriggerEvent('esx_ambulancejob:heal', 'big', true)
			exports['mythic_notify']:DoCustomHudText('inform', 'Użyłes 1xApteczka', 3500)
			--ESX.ShowNotification(_U('used_medikit'))
		--end)

	elseif itemName == 'bandage' then
		local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
		local playerPed = PlayerPedId()
		exports['mythic_progbar']:Progress({
			name = "firstaid_action",
			duration = 5000,
			label = "Bandażowanie ran...",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
				disableMovement = false,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			},
			animation = {
				animDict = "missheistdockssetup1clipboard@idle_a",
				anim = "idle_a",
				flags = 49,
			},
			prop = {
				model = "prop_paper_bag_small",
			}
		})
		Citizen.Wait(100)
		--ESX.Streaming.RequestAnimDict(lib, function()
			--TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
			--exports['progressBars']:startUI(11500, "Zakładanie opatrunku...")
			--Citizen.Wait(100)
			--[[while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
				Citizen.Wait(0)
				DisableAllControlActions(0)
			end]]

			TriggerEvent('esx_ambulancejob:heal', 'small', true)
			exports['mythic_notify']:DoCustomHudText('inform', 'Użyłeś 1xBandaż', 3500)
			--ESX.ShowNotification(_U('used_bandage'))

	elseif itemName == 'medikit' then
		local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
		local playerPed = PlayerPedId()

		--[[ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
			Citizen.Wait(500)
			while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
				Citizen.Wait(0)
				DisableAllControlActions(0)
			end]]
	
			--TriggerEvent('esx_ambulancejob:heal', 'revive', true)
			exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz uzyć defibrylatora na sobie!', 3500)
			--ESX.ShowNotification(_U('used_medikit'))
		--end)

	elseif itemName == 'firstaid' then
		local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
		local playerPed = PlayerPedId()

	    exports['mythic_progbar']:Progress({
			name = "firstaid_action",
			duration = 10000,
			label = "Używanie Apteczki PP...",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
				disableMovement = false,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			},
			animation = {
				animDict = "missheistdockssetup1clipboard@idle_a",
				anim = "idle_a",
				flags = 49,
			},
			prop = {
				model = "prop_stat_pack_01"
			},
		})
			TriggerClientEvent('mythic_hospital:items:firstaid')
			TriggerServerEvent('esx_ambulancejob:removeItem', 'firstaid')
			exports['mythic_notify']:DoCustomHudText('success', 'Użyłeś 1xApteczka Pierwszej Pomocy', 3500)

	elseif itemName == 'morphine' then
		local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
		local playerPed = PlayerPedId()

		exports['mythic_progbar']:Progress({
			name = "firstaid_action",
			duration = 5000,
			label = "Zażywasz Morfinę...",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
				disableMovement = false,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			},
			animation = {
				animDict = "mp_suicide",
				anim = "pill",
				flags = 49,
			},
			prop = {
				model = "prop_cs_pills",
				bone = 58866,
				coords = { x = 0.1, y = 0.0, z = 0.001 },
				rotation = { x = -60.0, y = 0.0, z = 0.0 },
			},
		})
			TriggerClientEvent('mythic_hospital:items:morphine')
			TriggerServerEvent('esx_ambulancejob:removeItem', 'morphine')
			exports['mythic_notify']:DoCustomHudText('success', 'Użyłeś 1xMorfina', 3500)
	end
end)

function StartDistressSignal()
	Citizen.CreateThread(function()
		local timer = Config.BleedoutTimer

		while timer > 0 and IsDead do
			Citizen.Wait(2)
			timer = timer - 30

			SetTextFont(4)
			SetTextScale(0.45, 0.45)
			SetTextColour(185, 185, 185, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			BeginTextCommandDisplayText('STRING')
			AddTextComponentSubstringPlayerName(_U('distress_send'))
			EndTextCommandDisplayText(0.175, 0.805)

			if IsControlPressed(0, Keys['G']) then
				SendDistressSignal()

				Citizen.CreateThread(function()
					Citizen.Wait(1000 * 60 * 5)
					if IsDead then
						StartDistressSignal()
					end
				end)

				break
			end
		end
	end)
end

-- function SendDistressSignal()
-- 	local playerPed = PlayerPedId()
-- 	local coords = GetEntityCoords(playerPed)

-- 	--ESX.ShowNotification(_U('distress_sent'))
-- 	exports['mythic_notify']:DoCustomHudText('error', 'Syngał alarmowy nie możliwy ponieważ nie ma żadnych jednostek!', 5000)
-- 	TriggerServerEvent('esx_phone:send', 'ambulance', _U('distress_message'), false, {
-- 		x = coords.x,
-- 		y = coords.y,
-- 		z = coords.z
-- 	})
-- end

function SendDistressSignal()
	local playerPed = PlayerPedId()
	PedPosition		= GetEntityCoords(playerPed)
	local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }
	exports['mythic_notify']:DoCustomHudText('error', 'Syngał alarmowy nie możliwy ponieważ nie ma żadnych jednostek!', 5000)
    TriggerServerEvent('esx_addons_gcphone:startCall', 'ambulance', _U('distress_message'), PlayerCoords, {
		PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z },
	})
end



function DrawGenericTextThisFrame()
	SetTextFont(4)
	SetTextScale(0.0, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)
end

function secondsToClock(seconds)
	local seconds, hours, mins, secs = tonumber(seconds), 0, 0, 0

	if seconds <= 0 then
		return 0, 0
	else
		local hours = string.format("%02.f", math.floor(seconds / 3600))
		local mins = string.format("%02.f", math.floor(seconds / 60 - (hours * 60)))
		local secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60))

		return mins, secs
	end
end

function StartDeathTimer()
	local canPayFine = false

	if Config.EarlyRespawnFine then
		ESX.TriggerServerCallback('esx_ambulancejob:checkBalance', function(canPay)
			canPayFine = canPay
		end)
	end

	local earlySpawnTimer = ESX.Math.Round(Config.EarlyRespawnTimer / 1000)
	local bleedoutTimer = ESX.Math.Round(Config.BleedoutTimer / 1000)

	Citizen.CreateThread(function()
		-- early respawn timer
		while earlySpawnTimer > 0 and IsDead do
			Citizen.Wait(1000)

			if earlySpawnTimer > 0 then
				earlySpawnTimer = earlySpawnTimer - 1
			end
		end

		-- bleedout timer
		while bleedoutTimer > 0 and IsDead do
			Citizen.Wait(1000)

			if bleedoutTimer > 0 then
				bleedoutTimer = bleedoutTimer - 1
			end
		end
	end)

	Citizen.CreateThread(function()
		local text, timeHeld

		-- early respawn timer
		while earlySpawnTimer > 0 and IsDead do
			Citizen.Wait(0)
			text = _U('respawn_available_in', secondsToClock(earlySpawnTimer))

			DrawGenericTextThisFrame()

			SetTextEntry("STRING")
			AddTextComponentString(text)
			DrawText(0.5, 0.8)
		end

		-- bleedout timer
		while bleedoutTimer > 0 and IsDead do
			Citizen.Wait(0)
			text = _U('respawn_bleedout_in', secondsToClock(bleedoutTimer))

			if not Config.EarlyRespawnFine then
				text = text .. _U('respawn_bleedout_prompt')

				if IsControlPressed(0, Keys['E']) and timeHeld > 60 then
					RemoveItemsAfterRPDeath()
					break
				end
			elseif Config.EarlyRespawnFine and canPayFine then
				text = text .. _U('respawn_bleedout_fine', ESX.Math.GroupDigits(Config.EarlyRespawnFineAmount))

				if IsControlPressed(0, Keys['E']) and timeHeld > 60 then
					TriggerServerEvent('esx_ambulancejob:payFine')
					RemoveItemsAfterRPDeath()
					break
				end
			end

			if IsControlPressed(0, Keys['E']) then
				timeHeld = timeHeld + 1
			else
				timeHeld = 0
			end

			DrawGenericTextThisFrame()

			SetTextEntry("STRING")
			AddTextComponentString(text)
			DrawText(0.5, 0.8)
		end
			
		if bleedoutTimer < 1 and IsDead then
			RemoveItemsAfterRPDeath()
		end
	end)
end

function RemoveItemsAfterRPDeath()
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(10)
		end

		ESX.TriggerServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function()
			local formattedCoords = {
				x = Config.RespawnPoint.coords.x,
				y = Config.RespawnPoint.coords.y,
				z = Config.RespawnPoint.coords.z
			}

			ESX.SetPlayerData('lastPosition', formattedCoords)
			ESX.SetPlayerData('loadout', {})

			TriggerServerEvent('esx:updateLastPosition', formattedCoords)
			RespawnPed(PlayerPedId(), formattedCoords, Config.RespawnPoint.heading)

			StopScreenEffect('DeathFailOut')
			DoScreenFadeIn(800)
		end)
	end)
end
--[[
function RespawnPed(ped, coords, heading)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z)
	ClearPedBloodDamage(ped)

	ESX.UI.Menu.CloseAll()
end
--]]

function RespawnPed(ped, coords, heading)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	TriggerEvent('esx_ambulancejob:multicharacter', coords.x, coords.y, coords.z)
	ClearPedBloodDamage(ped)

	ESX.UI.Menu.CloseAll()
end

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = 'Los Santos Fire Department',
		number     = 'ambulance',
		base64Icon = 'data:image/png;base64,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'
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	OnPlayerDeath()
end)

RegisterNetEvent('esx_ambulancejob:revive')
AddEventHandler('esx_ambulancejob:revive', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(50)
		end

		local formattedCoords = {
			x = ESX.Math.Round(coords.x, 1),
			y = ESX.Math.Round(coords.y, 1),
			z = ESX.Math.Round(coords.z, 1)
		}

		ESX.SetPlayerData('lastPosition', formattedCoords)

		TriggerServerEvent('esx:updateLastPosition', formattedCoords)
		TriggerEvent(playerPed ,'mythic_hospital:client:RemoveBleed')
		TriggerEvent(playerPed ,'mythic_hospital:client:ResetLimbs')
		RespawnPed(playerPed, formattedCoords, 0.0)

		StopScreenEffect('DeathFailOut')
		DoScreenFadeIn(800)
	end)
end)

-- Load unloaded IPLs
if Config.LoadIpl then
	Citizen.CreateThread(function()
		RequestIpl('Coroner_Int_on') -- Morgue
	end)
end

RegisterNetEvent('esx_ambulancejob:revive2')
AddEventHandler('esx_ambulancejob:revive2', function(from)

  local playerPed = GetPlayerPed(-1)
  local targetPed = GetPlayerPed(GetPlayerFromServerId(from))
  local coords    = GetEntityCoords(playerPed)
  local coords2   = GetEntityCoords(targetPed)
  
  if(GetDistanceBetweenCoords(coords, coords2.x, coords2.y, coords2.z) <= 18) then
	  TriggerServerEvent('esx_ambulancejob:reviv', from, true)
	  Citizen.Trace(GetPlayerName(-1) .. " EMS/PD REVIVE (true) => ".. GetPlayerName(GetPlayerFromServerId(from)))
  else
	  TriggerServerEvent('esx_ambulancejob:reviv', from, false)
	  Citizen.Trace(GetPlayerName(-1) .. " EMS/PD REVIVE (false) => ".. GetPlayerName(GetPlayerFromServerId(from)))
  end

end)
