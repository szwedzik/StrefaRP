ESX          = nil
local IsDead = false
local IsAnimated = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('esx_basicneeds:resetStatus', function()
	TriggerEvent('esx_status:set', 'hunger', 500000)
	TriggerEvent('esx_status:set', 'thirst', 500000)
end)

AddEventHandler('playerSpawned', function()
	if IsDead then
		TriggerEvent('esx_basicneeds:resetStatus')
	end
	IsDead = false
end)

AddEventHandler('esx_status:loaded', function(status)
	TriggerEvent('esx_status:registerStatus', 'hunger', 1000000, '#CFAD0F',
		function(status)
			return true
		end,
		function(status)
			status.remove(100)
		end)
	TriggerEvent('esx_status:registerStatus', 'thirst', 1000000, '#0C98F1',
		function(status)
			return true
		end,
		function(status)
			status.remove(125)
		end)
	Citizen.CreateThread(function()
		while true do
			Wait(1000)
			local playerPed  = GetPlayerPed(-1)
			local prevHealth = GetEntityHealth(playerPed)
			local health     = prevHealth
			TriggerEvent('esx_status:getStatus', 'hunger', function(status)
				if status.val == 0 then
					if prevHealth <= 150 then
						health = health - 5
					else
						health = health - 1
					end
				end
			end)

			TriggerEvent('esx_status:getStatus', 'thirst', function(status)
				if status.val == 0 then
					if prevHealth <= 150 then
						health = health - 5
					else
						health = health - 1
					end
				end
			end)
			if health ~= prevHealth then
				SetEntityHealth(playerPed,  health)
			end
		end
	end)

	Citizen.CreateThread(function()
		while true do
			Wait(1000)
			local playerPed = GetPlayerPed(-1)
			if IsEntityDead(playerPed) and not IsDead then
				IsDead = true
			end
		end
	end)
end)

AddEventHandler('esx_basicneeds:isEating', function(cb)
	cb(IsAnimated)
end)

RegisterNetEvent('esx_basicneeds:onEat')
AddEventHandler('esx_basicneeds:onEat', function(prop_name)
    if not IsAnimated then
		local prop_name = prop_name or 'prop_cs_burger_01'
    	IsAnimated = true
	    local playerPed = GetPlayerPed(-1)
	    Citizen.CreateThread(function()
	        local x,y,z = table.unpack(GetEntityCoords(playerPed))
	        prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
	        AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
	        RequestAnimDict('mp_player_inteat@burger')
	        while not HasAnimDictLoaded('mp_player_inteat@burger') do
	            Wait(0)
	        end
	        TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
	        Wait(3000)
	        IsAnimated = false
	        ClearPedSecondaryTask(playerPed)
	        DeleteObject(prop)
	    end)
	end
end)

RegisterNetEvent('esx_basicneeds:onDrink')
AddEventHandler('esx_basicneeds:onDrink', function(prop_name)
	if not IsAnimated then
		local prop_name = prop_name or 'prop_ld_flow_bottle'
		IsAnimated = true
		local playerPed = GetPlayerPed(-1)
		Citizen.CreateThread(function()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)			
	        AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
			RequestAnimDict('mp_player_intdrink')  
			while not HasAnimDictLoaded('mp_player_intdrink') do
				Wait(0)
			end
			TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)
			Wait(3000)
	        IsAnimated = false
	        ClearPedSecondaryTask(playerPed)
			DeleteObject(prop)
		end)
	end
end)


RegisterNetEvent('esx_basicneeds:onArmorUse')
AddEventHandler('esx_basicneeds:onArmorUse', function(source)
	local playerPed = GetPlayerPed(-1)
	exports['progressBars']:startUI(5000, "Zakladanie Kamizelki...")
	LoadAnim("clothingshirt")
	if not IsEntityPlayingAnim(PlayerPedId(), 'clothingshirt' , 'try_shirt_positive_a', 3) then
		TaskPlayAnim(PlayerPedId(), 'clothingshirt', 'try_shirt_positive_a', 3.0, 1.0, -1, 49, 0, 0, 0, 0 )
	end
	SetPedArmour(playerPed, 100)
end)

RegisterNetEvent('esx_basicneeds:onDonut')
AddEventHandler('esx_basicneeds:onDonut', function()
	startAttitude("move_m@fat@a", "move_m@fat@a")
end)

function startAttitude(lib, anim)
 	Citizen.CreateThread(function()
	    local playerPed = GetPlayerPed(-1)
	    RequestAnimSet(anim)
	    while not HasAnimSetLoaded(anim) do
	        Citizen.Wait(0)
	    end
	    SetPedMovementClipset(playerPed, anim, true)
	end)
end

local effect_coke = false
local effect_weed = false
local effect_meth = false
local effect_lsd = false
local effect_heroina = false
local make_hungry = false

RegisterNetEvent('esx_basicneeds:drug_effect')
AddEventHandler('esx_basicneeds:drug_effect', function(drug)
	if drug == 'coke_pooch' then
		loadAnimDict('mp_suicide')
		TaskPlayAnim(PlayerPedId(), 'mp_suicide', 'pill', 8.0, 1.0, -1, 0, 0, 0, 0, 0)
		Wait(3000)
		ClearPedTasks(PlayerPedId())
		Wait(1000 * 30)
		effect_coke = true
		ScreenFade("DrugsMichaelAliensFight")
		Wait(1000 * 30)
		StopAll()
		effect_coke = false
	end
	if drug == 'weed_pooch' then
		TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_SMOKING_POT", 0, true)
		Wait(1000 * 30)
		effect_weed = true
		ScreenFade("DrugsTrevorClownsFight")
		Wait(1000 * 30)
		StopAll()
		effect_weed = false
		make_hungry = true
		Wait(1000 * 90)
		make_hungry = false
	end
	if drug == 'meth_pooch' then
		loadAnimDict('mp_suicide')
		TaskPlayAnim(PlayerPedId(), 'mp_suicide', 'pill', 8.0, 1.0, -1, 0, 0, 0, 0, 0)
		Wait(3000)
		ClearPedTasks(PlayerPedId())
		Wait(1000 * 30)
		effect_meth = true
		ScreenFade("MP_Celeb_Preload_Fade")
		Wait(1000 * 30)
		StopAll()
		effect_meth = false
	end
	if drug == 'lsd_pooch' then
		loadAnimDict('mp_suicide')
		TaskPlayAnim(PlayerPedId(), 'mp_suicide', 'pill', 8.0, 1.0, -1, 0, 0, 0, 0, 0)
		Wait(3000)
		ClearPedTasks(PlayerPedId())
		Wait(1000 * 30)
		effect_lsd = true
		Wait(1000)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'lsd_effect', 0.5)
		ScreenFade("DMT_flight")
		Wait(1000 * 30)
		StopAll()
		effect_lsd = false
	end
	if drug == 'heroina_pooch' then
		TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_SMOKING_POT", 0, true)
		Wait(1000 * 30)
		effect_heroina = true
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'heroina_effect', 0.2)
		ScreenFade("RaceTurbo")
		ShakeGameplayCam('SKY_DIVING_SHAKE', 1.0)
		Wait(1000 * 30)
		StopAll()
		effect_heroina = false
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000 * 10)
		if effect_coke then
			startAttitude("move_p_m_zero_slow", "move_p_m_zero_slow")
			ResetPlayerStamina(PlayerId())
		end
		if effect_weed then
			startAttitude("move_p_m_zero_slow", "move_p_m_zero_slow")
			TriggerEvent('esx_status:add', 'hunger', 35000)
			TriggerEvent('esx_status:add', 'thirst', 35000)
		end
		if effect_meth then
			startAttitude("move_m@gangster@var_e", "move_m@gangster@var_e")
			SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 5)
		end
		if effect_lsd then
			startAttitude("MOVE_M@DRUNK@SLIGHTLYDRUNK", "MOVE_M@DRUNK@SLIGHTLYDRUNK")
		end
		if effect_heroina then
			startAttitude("move_p_m_zero_slow", "move_p_m_zero_slow")
		end
		if make_hungry then
			TriggerEvent('esx_status:add', 'hunger', -36000)
			TriggerEvent('esx_status:add', 'thirst', -36000)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(2000)
		if effect_lsd then
			ShakeGameplayCam('VIBRATE_SHAKE', 1.0)
		end
	end
end)

function ScreenFade(effect)
	DoScreenFadeOut(1000)
	ShakeGameplayCam("LARGE_EXPLOSION_SHAKE", 1.0)
	Wait(2000)
	StartScreenEffect(effect, 1.0, true)
	ShakeGameplayCam("LARGE_EXPLOSION_SHAKE", 1.0)
	DoScreenFadeIn(1000)
end

function ScreenFadeOut()
	ShakeGameplayCam("LARGE_EXPLOSION_SHAKE", 1.0)
	DoScreenFadeOut(1000)
	Wait(1000)
end

function ScreenFadeIn()
	Wait(1000)
	DoScreenFadeIn(1000)
	ShakeGameplayCam("LARGE_EXPLOSION_SHAKE", 1.0)
end

function StopAll()
	ScreenFade("")
	StopAllScreenEffects()
	startAttitude("MOVE_P_M_ONE", "MOVE_P_M_ONE")
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do 
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

RegisterCommand("c",function(source, args)
	StopAllScreenEffects()
	StartScreenEffect(args[1], 1.0, true)
end, false)

RegisterCommand("s",function(source, args)
	ShakeGameplayCam("LARGE_EXPLOSION_SHAKE", 1.0)
	Wait(1000)
	ShakeGameplayCam(args[1], 1.0)
end, false)

RegisterCommand("m",function(source, args)
	startAttitude(args[1], args[1])
end, false)

--[[
Citizen.CreateThread(function()
	while true do
        Wait(1)
        x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
        RequestModel("prop_gascyl_01a")
        while not HasModelLoaded("prop_gascyl_01a") do
           Wait(1)
        end
        local butla = CreateObject("prop_gascyl_01a", x, y, z, true, true, true)
		PlaceObjectOnGroundProperly(butla)
	end
end)
]]
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		DeleteEntity(prop)
		for i in pairs(lastProps) do
			DeleteEntity(lostbox[i])
			lastProps[i] = nil
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000 * 60 * 10)
		DeleteLastProps()
	end
end)

function DeleteLastProps()
	for i in pairs(lastProps) do
		DeleteObject(lastProps[i])
	end
end

RegisterNetEvent('esx_emotes:detachEntity')
AddEventHandler('esx_emotes:detachEntity', function()
	DetachEntity(prop, false, true)
	--table.insert(lastProps, prop)
	for i in pairs(lastProps) do 
		if prop == lastProps[i] then
			DeleteEntity(prop)
		end
	end
	prop = nil
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if IsControlJustReleased(0, 73) then
			if prop ~= nil then
				DetachEntity(prop, false, true)
				prop = nil
				ClearPedTasks(PlayerPedId())
				interaction = ''
			end
		end
	end
end)

--[[
LoadModel = function(model)
	while not HasModelLoaded(model) do
		RequestModel(model)
		
		Citizen.Wait(1)
	end
end

RegisterNetEvent('esx_basicneeds:butla')
AddEventHandler('esx_basicneeds:butla', function()
	loadAnimDict('anim@mp_fireworks')
	TaskPlayAnim(PlayerPedId(), 'anim@mp_fireworks', 'place_firework_3_box', 8.0, 1.0, -1, 0, 0, 0, 0, 0)
	LoadModel('prop_gascyl_01a')
	local butla = CreateObject(GetHashKey('prop_gascyl_01a'), GetEntityCoords(PlayerPedId()), true)
	Wait(3000)
	ClearPedTasks(PlayerPedId())
end)
]]

RegisterNetEvent('esx_basicneeds:butla')
AddEventHandler('esx_basicneeds:butla', function()
	local player = PlayerPedId()
	local ad = "rcmepsilonism8"	
	local prop_name = prop_name or 'prop_gascyl_01a'
	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, "bag_handler_idle_a", 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 49, 0, 0, 0, 0 )
			DetachEntity(prop, 1, 1)
			DeleteObject(prop)
			Wait(1000)
			ClearPedSecondaryTask(PlayerPedId())
		else
			local x,y,z = table.unpack(GetEntityCoords(player))
			prop = CreateObject(GetHashKey(prop_name), x, y, z,  true,  true, true)
			AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 57005), 0.43, 0.0, -0.02, -90.0, 0.0, 90.0, true, true, false, true, 1, true)
			TaskPlayAnim( player, ad, "bag_handler_idle_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
		end 
	end
	--table.insert(lastProps, prop)
end)

RegisterNetEvent('esx_basicneeds:grill')
AddEventHandler('esx_basicneeds:grill', function()
    local ad = "anim@heists@box_carry@"
    local player = PlayerPedId()
	local prop_name = prop_name or 'prop_bbq_4'
	if holdingbox == true then
		DetachEntity(prop, 1, 1)
		DeleteObject(prop)
		holdingbox = false
	end
	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, "idle", 3 ) ) then 
			holdingbox = false
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 49, 0, 0, 0, 0 )
			DetachEntity(prop, 1, 1)
			DeleteObject(prop)
			Wait(1000)
			ClearPedSecondaryTask(PlayerPedId())
		else
			local x,y,z = table.unpack(GetEntityCoords(player))
			holdingbox = true
			prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
			AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 60309), 0.5, -0.5, 0.1, -50.0, 290.0, 0.0, true, true, false, true, 1, true)
			TaskPlayAnim( player, ad, "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
		end 
	end
end)
