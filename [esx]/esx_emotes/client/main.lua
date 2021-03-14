ESX = nil
local lastProps = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx_emotes:playAnim')
AddEventHandler('esx_emotes:playAnim', function(ad, anim)
    if (DoesEntityExist(PlayerPedId()) and not IsEntityDead(PlayerPedId())) then 
        loadAnimDict(ad)
        if (IsEntityPlayingAnim(PlayerPedId(), ad, anim, 3)) then 
            TaskPlayAnim(PlayerPedId(), ad, "exit", 8.0, 1.0, -1, 48, 0, 0, 0, 0)
            Wait (600)
            ClearPedSecondaryTask(PlayerPedId())
        else
            TaskPlayAnim( PlayerPedId(), ad, anim, 8.0, 1.0, -1, 48, 0, 0, 0, 0 )
            Wait(500)
        end     
    end
end)
                 
RegisterNetEvent('esx_emotes:play')
AddEventHandler('esx_emotes:play', function(type, anim)
    for theId,theItems in pairs(anims) do
        RequestAnimDict(theItems.dic)
    end    
    local ped = PlayerPedId()
    local pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0, -0.5, -0.5) --do siadania potrzeba skrócic zeby nie siadal w powietrzu ped
    local x = pos
    local heading = GetEntityHeading(ped)
    if type == 0 then
        pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0, 0, 0)
        TaskStartScenarioInPlace(ped, anim, 0, true)
        
    elseif type == 1 then
        TaskStartScenarioAtPosition(ped, anim, pos.x, pos.y, pos.z, heading, -1, true, false);
    elseif type == 2 then
        print("") 
        pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0, 0, 0)
        TaskStartScenarioInPlace(ped, anim, 0, false)
    end
    for theId,theItems in pairs(scens) do
        if theItems.label == anim then
            TaskStartScenarioInPlace(ped, theItems.scen, 0, true)
        end
    end
    for theId,theItems in pairs(anims) do
        if theItems.label == anim then
                TaskPlayAnim(ped, theItems.dic, theItems.anim, 8.0, -1, -1, looped, 1, 0, 0, 0)
        end
    end     

end)

local holdingcam = false
local cammodel = "prop_pap_camera_01"
local cam_net = nil

local holdingsign = false
local signmodel = "prop_beggers_sign_01"
local sign_net = nil

local holdingwand = false
local wandmodel = "prop_parking_wand_01"
local wand_net = nil

local holdingbong = false
local bongmodel = "hei_heist_sh_bong_01"
local bong_net = nil

local holdingphoneR = false
local phoneRmodel = "prop_amb_phone"
local phoneR_net = nil

local holdingpad = false
local padmodel = "prop_notepad_02"
local pad_net = nil

local holdingumb = false
local umbmodel = "p_amb_brolly_01"
local umb_net = nil

local holdingbox = false
local boxmodel = "hei_prop_heist_box"
local box_net = nil

function Notification(message)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(0, 0)
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do 
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function DrawMissionText2(m_text, showtime)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(m_text)
    DrawSubtitleTimed(showtime, 1)
end

RegisterNetEvent('esx_emotes:umbrella')
AddEventHandler('esx_emotes:umbrella', function()
local ad1 = "amb@code_human_wander_drinking@beer@male@base"
    local ad1a = "static"
    local player = GetPlayerPed(-1)
    local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
    local umbspawned = CreateObject(GetHashKey(umbmodel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
    local netid = ObjToNet(umbspawned)

    if (DoesEntityExist(player) and not IsEntityDead(player)) then 
        loadAnimDict(ad1)
        RequestModel(GetHashKey(umbmodel))
        if holdingumb then
            Wait(100)
            ClearPedSecondaryTask(GetPlayerPed(-1))
            DetachEntity(NetToObj(umb_net), 1, 1)
            DeleteEntity(NetToObj(umb_net))
            umb_net = nil
            holdingumb = false
        else
            TaskPlayAnim(player, ad1, ad1a, 8.0, 1.0, -1, 49, 0, 0, 0, 0)
            Wait(500)
            SetNetworkIdExistsOnAllMachines(netid, true)
            SetNetworkIdCanMigrate(netid, false)
            AttachEntityToEntity(umbspawned,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),0.0,0.0,0.0,0.0,0.0,0.0,1,1,0,1,0,1)
            Wait(120)
            umb_net = netid
            holdingumb = true
        end

    end
    while holdingumb do
    Wait(0)
        if IsControlJustPressed(0, 73) then
            ClearPedSecondaryTask(GetPlayerPed(-1))
            DetachEntity(NetToObj(umb_net), 1, 1)
            DeleteEntity(NetToObj(umb_net))
        end
    end
end)

RegisterNetEvent('esx_emotes:box')
AddEventHandler('esx_emotes:box', function()
    local ad = "anim@heists@box_carry@"
    local player = PlayerPedId()
	local prop_name = prop_name or 'hei_prop_heist_box'
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
			AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
			TaskPlayAnim( player, ad, "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
			
		end 
	end
end)

RegisterNetEvent('esx_emotes:salute')
AddEventHandler('esx_emotes:salute', function()
    local ad = "anim@mp_player_intuppersalute"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle_a", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:fu2')
AddEventHandler('esx_emotes:fu2', function()
    local ad = "anim@mp_player_intupperfinger"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle_a", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
            Wait (100)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:palm')
AddEventHandler('esx_emotes:palm', function()
    local ad = "anim@mp_player_intupperface_palm"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle_a", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
            Wait (100)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:fu')
AddEventHandler('esx_emotes:fu', function()
    local ad = "anim@mp_player_intselfiethe_bird"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle_a", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
            Wait (100)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:ticket')
AddEventHandler('esx_emotes:ticket', function()
    local player = GetPlayerPed(-1)
    local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
    local padspawned = CreateObject(GetHashKey(padmodel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
    local netid = ObjToNet(padspawned)
    local ad = "amb@medic@standing@timeofdeath@enter"
    local ad2 = "amb@medic@standing@timeofdeath@base"
    local ad3 = "amb@medic@standing@timeofdeath@exit"
    local ad4 = "amb@medic@standing@timeofdeath@idle_a"
    if (DoesEntityExist(player) and not IsEntityDead(player)) then
        loadAnimDict(ad)
        loadAnimDict(ad2)
        loadAnimDict(ad3)
        loadAnimDict(ad4)
        if holdingpad then
            TaskPlayAnim(player, ad3, "exit", 8.0, 1.0, -1, 50, 0, 0, 0, 0)
            Wait(5330)
            DetachEntity(NetToObj(pad_net), 1, 1)
            DeleteEntity(NetToObj(pad_net))
            Wait(2500)
            ClearPedSecondaryTask(GetPlayerPed(-1))
            pad_net = nil
            holdingpad = false
        else
            Wait(500)
            SetNetworkIdExistsOnAllMachines(netid, true)
            SetNetworkIdCanMigrate(netid, false)
            TaskPlayAnim( player, ad, "enter", 8.0, 1.0, -1, 50, 0, 0, 0, 0 )
            Wait (3000)                                                                                         --28422
            AttachEntityToEntity(padspawned,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),0.0,0.0,0.0,0.0,360.0,0.0,1,1,0,1,0,1)
            Wait(1310)
            DetachEntity(NetToObj(pad_net), 1, 1)
            DeleteEntity(NetToObj(pad_net))
            AttachEntityToEntity(padspawned,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 18905),0.1,0.0,0.0,360.0,360.0,0.0,1,1,0,1,0,1)
            pad_net = netid
            holdingpad = true
        end
    end

    while holdingpad do
        Wait(0)
        if IsControlJustPressed(0, 73) then
            DetachEntity(NetToObj(pad_net), 1, 1)
            DeleteEntity(NetToObj(pad_net))
        end
    end

end)

RegisterNetEvent('esx_emotes:toolbox')
AddEventHandler('esx_emotes:toolbox', function()
	local player = PlayerPedId()
	local ad = "rcmepsilonism8"	
	local prop_name = prop_name or 'prop_tool_box_04'
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
	table.insert(lastProps, prop)
end)

RegisterNetEvent('esx_emotes:toolbox2')
AddEventHandler('esx_emotes:toolbox2', function()
	local player = PlayerPedId()
	local ad = "rcmepsilonism8"	
	local prop_name = prop_name or 'prop_tool_box_01'
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
			AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 57005), 0.5, 0.0, 0.01, -100.0, 0.0, 90.0, true, true, false, true, 1, true)
			TaskPlayAnim( player, ad, "bag_handler_idle_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
		end 
	end
	table.insert(lastProps, prop)
end)

RegisterNetEvent('esx_emotes:toolbox3')
AddEventHandler('esx_emotes:toolbox3', function()
	local player = PlayerPedId()
	local ad = "rcmepsilonism8"	
	local prop_name = prop_name or 'prop_toolchest_01'
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
			AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 57005), 0.5, 0.0, 0.05, -100.0, 0.0, 90.0, true, true, false, true, 1, true)
			TaskPlayAnim( player, ad, "bag_handler_idle_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
		end 
	end
	table.insert(lastProps, prop)
end)

RegisterNetEvent('esx_emotes:suitcase')
AddEventHandler('esx_emotes:suitcase', function()
	local player = PlayerPedId()
	local ad = "anim@heists@narcotics@trash"
	local prop_name = prop_name or 'prop_suitcase_03'
	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, "walk", 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 49, 0, 0, 0, 0 )
			DetachEntity(prop, 1, 1)
			DeleteObject(prop)
			Wait(1000)
			ClearPedSecondaryTask(PlayerPedId())
		else
			local x,y,z = table.unpack(GetEntityCoords(player))
			prop = CreateObject(GetHashKey(prop_name), x, y, z,  true,  true, true)
			AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 57005), 0.36, -0.5, 0.0, -50.0, -60.0, 15.0, true, true, false, true, 1, true)
			TaskPlayAnim( player, ad, "walk", 1.0, 1.0, -1, 50, 0, 0, 0, 0 )
		end 
	end
	table.insert(lastProps, prop)
end)


-- STASIEK EDIT HERE
local interactionEnabled = false
local iteraction = nil
RegisterNetEvent('esx_emotes:wiertarka')
AddEventHandler('esx_emotes:wiertarka', function()
	interactionEnabled = false
	local ad = "anim@heists@fleeca_bank@drilling"
	local prop_name = prop_name or 'prop_tool_drill'
	interaction = 'wiertarka' 
	if ( DoesEntityExist( PlayerPedId() ) and not IsEntityDead( PlayerPedId() )) then 
		if ( IsEntityPlayingAnim( PlayerPedId(), ad, "drill_straight_start", 3 ) ) then 
			DetachEntity(prop, 1, 1)
			DeleteObject(prop)
			Wait(1000)
			ClearPedSecondaryTask(PlayerPedId())
		else
			local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
			prop = CreateObject(GetHashKey(prop_name), x, y, z,  true,  true, true)
			table.insert(lastProps, prop)
			AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.1, 0.04, -0.03, -90.0, 180.0, 0.0, true, true, false, true, 1, true)
		end 
	end
	ESX.ShowHelpNotification('Naciśnij ~INPUT_VEH_HEADLIGHT~ aby wiercić')
end)

RegisterNetEvent('esx_emotes:klucz')
AddEventHandler('esx_emotes:klucz', function()
	local prop_name = prop_name or 'prop_tool_wrench'
	if ( DoesEntityExist( PlayerPedId() ) and not IsEntityDead( PlayerPedId() )) then 
		TaskPlayAnim( PlayerPedId(), ad, "exit", 3.0, 1.0, -1, 49, 0, 0, 0, 0 )
		DetachEntity(prop, 1, 1)
		DeleteObject(prop)
		Wait(1000)
		ClearPedSecondaryTask(PlayerPedId())
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		prop = CreateObject(GetHashKey(prop_name), x, y, z,  true,  true, true)
		table.insert(lastProps, prop)
		AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.1, -0.1, -0.07, -60.0, 0.0, 0.0, true, true, false, true, 1, true)
	end
end)

RegisterNetEvent('esx_emotes:walizka')
AddEventHandler('esx_emotes:walizka', function()
	local ad = "rcmepsilonism8"
	local prop_name = prop_name or 'prop_ld_case_01'

	if ( DoesEntityExist( PlayerPedId() ) and not IsEntityDead( PlayerPedId() )) then 
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( PlayerPedId(), ad, "bag_handler_idle_a", 3 ) ) then 
			TaskPlayAnim( PlayerPedId(), ad, "exit", 3.0, 1.0, -1, 49, 0, 0, 0, 0 )
			DetachEntity(prop, 1, 1)
			DeleteObject(prop)
			Wait(1000)
			ClearPedSecondaryTask(PlayerPedId())
		else
			local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
			prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
			table.insert(lastProps, prop)
			AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.13, 0.0, -0.02, -90.0, 0.0, 90.0, true, true, false, true, 1, true)
			TaskPlayAnim( PlayerPedId(), ad, "bag_handler_idle_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
		end 
	end
end)

RegisterNetEvent('esx_emotes:walizka2')
AddEventHandler('esx_emotes:walizka2', function()
	local ad = "rcmepsilonism8"
	local prop_name = prop_name or 'prop_ld_suitcase_01'
	if ( DoesEntityExist( PlayerPedId() ) and not IsEntityDead( PlayerPedId() )) then 
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( PlayerPedId(), ad, "bag_handler_idle_a", 3 ) ) then 
			TaskPlayAnim( PlayerPedId(), ad, "exit", 3.0, 1.0, -1, 49, 0, 0, 0, 0 )
			DetachEntity(prop, 1, 1)
			DeleteObject(prop)
			Wait(1000)
			ClearPedSecondaryTask(PlayerPedId())
		else
			local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
			prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
			table.insert(lastProps, prop)
			AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.36, 0.0, -0.02, -90.0, 0.0, 90.0, true, true, false, true, 1, true)
			TaskPlayAnim( PlayerPedId(), ad, "bag_handler_idle_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
		end 
	end
end)

local player = PlayerPedId()
RegisterNetEvent('esx_emotes:kawa')
AddEventHandler('esx_emotes:kawa', function()
	local ad = "amb@world_human_aa_coffee@idle_a"
	local prop_name = prop_name or 'ng_proc_coffee_01a'
	if ( DoesEntityExist( PlayerPedId() ) and not IsEntityDead( PlayerPedId() )) then 
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( PlayerPedId(), ad, "amb@world_human_drinking_fat@coffee@female@idle_a", 3 ) ) then 
			TaskPlayAnim( PlayerPedId(), ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
			Wait (100)
			ClearPedSecondaryTask(PlayerPedId())
			DetachEntity(prop, 1, 1)
			DeleteObject(prop)
		else
			local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
			prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
			table.insert(lastProps, prop)
			AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.15, -0.07, -0.05, 90.0, 0.0, -180.0, true, true, false, true, 1, true)
			TaskPlayAnim( PlayerPedId(), ad, "idle_b", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
		end 
	end		
end)

RegisterNetEvent('esx_emotes:siku')
AddEventHandler('esx_emotes:siku', function()
	local ad = "missbigscore1switch_trevor_piss"
	if ( DoesEntityExist( PlayerPedId() ) and not IsEntityDead( PlayerPedId() )) then 
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( PlayerPedId(), ad, "piss_outro", 3 ) ) then 
			TaskPlayAnim( PlayerPedId(), ad, "piss_outro", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
			Wait (100)
			ClearPedSecondaryTask(PlayerPedId())
		else
			TaskPlayAnim( PlayerPedId(), ad, "piss_loop", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
		end 
	end		
end)

RegisterNetEvent('esx_emotes:modlitwa')
AddEventHandler('esx_emotes:modlitwa', function()
	local ad = "pro_mcs_7_concat-7"
	if ( DoesEntityExist( PlayerPedId() ) and not IsEntityDead( PlayerPedId() )) then 
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( PlayerPedId(), ad, "cs_priest_dual-7", 3 ) ) then 
			TaskPlayAnim( PlayerPedId(), ad, "cs_priest_dual-7", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
			Wait (100)
			ClearPedSecondaryTask(PlayerPedId())
		else
			TaskPlayAnim( PlayerPedId(), ad, "cs_priest_dual-7", 8.0, 1.0, -1, 54, 0, 0, 0, 0 )
		end 
	end		
end)

RegisterNetEvent('esx_emotes:modlitwa2')
AddEventHandler('esx_emotes:modlitwa2', function()
	local ad = "pro_mcs_7_concat-1"
	if ( DoesEntityExist( PlayerPedId() ) and not IsEntityDead( PlayerPedId() )) then 
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( PlayerPedId(), ad, "cs_priest_dual-1", 3 ) ) then 
			TaskPlayAnim( PlayerPedId(), ad, "cs_priest_dual-1", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
			Wait (100)
			ClearPedSecondaryTask(PlayerPedId())
		else
			TaskPlayAnim( PlayerPedId(), ad, "cs_priest_dual-1", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
		end 
	end		
end)

RegisterNetEvent('esx_emotes:oprzyj')
AddEventHandler('esx_emotes:oprzyj', function()
	local ad = "amb@world_human_leaning@female@wall@back@holding_elbow@idle_b"
	if ( DoesEntityExist( PlayerPedId() ) and not IsEntityDead( PlayerPedId() )) then 
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( PlayerPedId(), ad, "idle_d", 3 ) ) then 
			TaskPlayAnim( PlayerPedId(), ad, "exit", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (100)
			ClearPedSecondaryTask(PlayerPedId())
		else
			TaskPlayAnim( PlayerPedId(), ad, "idle_d", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
		end 
	end		
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if interaction ~= '' and IsControlJustReleased(0, 74) then
			if interactionEnabled == false then
				if interaction == 'wiertarka' and not IsEntityPlayingAnim( PlayerPedId(), "anim@heists@fleeca_bank@drilling", "drill_straight_start", 3 ) then
					interactionEnabled = true
					loadAnimDict("anim@heists@fleeca_bank@drilling")
					TaskPlayAnim( PlayerPedId(), "anim@heists@fleeca_bank@drilling", "drill_straight_start", 1.0, 1.0, -1, 63, 0, 0, 0, 0 )
				end
			else
				TriggerEvent('esx_emotes:wiertarka')
			end
		end
	end
end)

RegisterNetEvent('esx_emotes:cam')
AddEventHandler('esx_emotes:cam', function()
    local ad1 = "amb@world_human_paparazzi@male@enter"
    local ad2 = "amb@world_human_paparazzi@male@idle_a"
    local ad3 = "amb@world_human_paparazzi@male@base"
    local ad4 = "amb@world_human_paparazzi@male@exit"
    local ad1a = "enter"
    local ad2a = "idle_a"
    local ad2b = "idle_b"
    local ad2c = "idle_c"
    local ad3a = "base"
    local ad4a = "exit"
    local player = GetPlayerPed(-1)
    local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
    local camspawned = CreateObject(GetHashKey(cammodel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
    local netid = ObjToNet(camspawned)
    local camani = {
        ad2a,
        ad2b,
        ad2c
    }
    local camaniRnd = math.random(1, 3)
    local pd = "core" 
    local pn = "ent_anim_paparazzi_flash"

    if (DoesEntityExist(player) and not IsEntityDead(player)) then ---------------------If playing then cancel
        loadAnimDict(ad1)
        loadAnimDict(ad2)
        loadAnimDict(ad3)
        loadAnimDict(ad4)
        RequestModel(GetHashKey(cammodel))
        if (IsEntityPlayingAnim(player, ad3, ad3a, 3)) then
            TaskPlayAnim(player, ad4, ad4a, 8.0, 1.0, -1, 49, 0, 0, 0, 0)
            Wait(100)
            ClearPedSecondaryTask(GetPlayerPed(-1))
            DetachEntity(NetToObj(cam_net), 1, 1)
            DeleteEntity(NetToObj(cam_net))
            cam_net = nil
            holdingcam = false
        else
            TaskPlayAnim(player, ad1, ad1a, 8.0, 1.0, -1, 49, 0, 0, 0, 0)
            Wait(520)
            SetNetworkIdExistsOnAllMachines(netid, true)
            SetNetworkIdCanMigrate(netid, false)
            AttachEntityToEntity(camspawned,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),-0.005,0.0,0.0,360.0,360.0,0.0,1,1,0,1,0,1)
            Wait(120)
            TaskPlayAnim(player, ad3, ad3a, 8.0, 1.0, -1, 49, 0, 0, 0, 0)
            Notification("Press ~r~[E]~w~ to take photos.")
            cam_net = netid
            holdingcam = true
        end
    end

    local camnoti = {
        "~g~Smile~w~!",
        "Say ~y~cheese~w~!",
        "~y~Cheeeeeeeeese~w~!!!",
        "You look ~g~great~w~!",
        "~g~F~b~u~r~n~y~n~g~y ~g~f~b~a~r~c~g~e~w~!!!"
    }
    local camnotiRnd = math.random(1, 5)
    while holdingcam do
        Wait(0)
        if IsControlJustPressed(0, 38) then
            Wait(100)
            Notification(camnoti[camnotiRnd])
            Wait(100)
            TaskPlayAnim(player, ad2, camani[camaniRnd], 8.0, -8, -1, 49, 0, 0, 0, 0)
            Wait(100)
            if IsEntityPlayingAnim(player, ad2, ad2a, 49) then
                RequestPtfxAsset( pd )
                Wait(880)
                UseParticleFxAssetNextCall(pd)
                StartParticleFxNonLoopedOnEntity(pn, camspawned, 0.1, -0.1, 0.0, 0.0, 0.0, 0.0, 2.0, 0.0, 0.0, 0.0)
                Wait(1300)
                UseParticleFxAssetNextCall(pd)
                StartParticleFxNonLoopedOnEntity(pn, camspawned, 0.1, -0.1, 0.0, 0.0, 0.0, 0.0, 2.0, 0.0, 0.0, 0.0)
                Wait(2140)
                UseParticleFxAssetNextCall(pd)
                StartParticleFxNonLoopedOnEntity(pn, camspawned, 0.1, -0.1, 0.0, 0.0, 0.0, 0.0, 2.0, 0.0, 0.0, 0.0)
                Wait(1580)
                UseParticleFxAssetNextCall(pd)
                StartParticleFxNonLoopedOnEntity(pn, camspawned, 0.1, -0.1, 0.0, 0.0, 0.0, 0.0, 2.0, 0.0, 0.0, 0.0)
                Wait(2700)
            elseif IsEntityPlayingAnim(player, ad2, ad2b, 49) then
                RequestPtfxAsset( pd )
                Wait(2550)
                UseParticleFxAssetNextCall(pd)
                StartParticleFxNonLoopedOnEntity(pn, camspawned, 0.1, -0.1, 0.0, 0.0, 0.0, 0.0, 2.0, 0.0, 0.0, 0.0)
                Wait(2410)
                UseParticleFxAssetNextCall(pd)
                StartParticleFxNonLoopedOnEntity(pn, camspawned, 0.1, -0.1, 0.0, 0.0, 0.0, 0.0, 2.0, 0.0, 0.0, 0.0)
                Wait(200)
                UseParticleFxAssetNextCall(pd)
                StartParticleFxNonLoopedOnEntity(pn, camspawned, 0.1, -0.1, 0.0, 0.0, 0.0, 0.0, 2.0, 0.0, 0.0, 0.0)
                Wait(100)
                UseParticleFxAssetNextCall(pd)
                StartParticleFxNonLoopedOnEntity(pn, camspawned, 0.1, -0.1, 0.0, 0.0, 0.0, 0.0, 2.0, 0.0, 0.0, 0.0)
                Wait(3340)
            elseif IsEntityPlayingAnim(player, ad2, ad2c, 49) then
                RequestPtfxAsset( pd )
                Wait(500)
                UseParticleFxAssetNextCall(pd)
                StartParticleFxNonLoopedOnEntity(pn, camspawned, 0.1, -0.1, 0.0, 0.0, 0.0, 0.0, 2.0, 0.0, 0.0, 0.0)
                Wait(4150)
                UseParticleFxAssetNextCall(pd)
                StartParticleFxNonLoopedOnEntity(pn, camspawned, 0.1, -0.1, 0.0, 0.0, 0.0, 0.0, 2.0, 0.0, 0.0, 0.0)
                Wait(100)
                UseParticleFxAssetNextCall(pd)
                StartParticleFxNonLoopedOnEntity(pn, camspawned, 0.1, -0.1, 0.0, 0.0, 0.0, 0.0, 2.0, 0.0, 0.0, 0.0)
                Wait(200)
                UseParticleFxAssetNextCall(pd)
                StartParticleFxNonLoopedOnEntity(pn, camspawned, 0.1, -0.1, 0.0, 0.0, 0.0, 0.0, 2.0, 0.0, 0.0, 0.0)
                Wait(1620)
            end
            TaskPlayAnim(player, ad3, ad3a, 8.0, 1.0, -1, 49, 0, 0, 0, 0)
        end
    end
end)

RegisterNetEvent('esx_emotes:detachEntity')
AddEventHandler('esx_emotes:detachEntity', function()
	DetachEntity(prop, false, true)
	table.insert(lastProps, prop)
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
			DetachEntity(prop, false, true)
			table.insert(lastProps, prop)
			prop = nil
			ClearPedTasks(PlayerPedId())
			interaction = ''
		end
		if IsControlJustReleased(0, 38) and not IsPedSittingInAnyVehicle(PlayerPedId()) and not IsEntityDead(PlayerPedId()) and not IsEntityInAir(PlayerPedId()) and not IsEntityInWater(PlayerPedId()) then
			interaction = ''
			local coords = GetEntityCoords(PlayerPedId())
			if prop ~= nil then
				ClearPedTasks(PlayerPedId())
				RequestAnimDict("anim@mp_fireworks")
				while not HasAnimDictLoaded("anim@mp_fireworks") do
					Citizen.Wait(10)
				end
				TaskPlayAnim(PlayerPedId(), "anim@mp_fireworks", "place_firework_3_box", 8.0, 8.0, -1, 0, 0, false, false, false)
				Wait(1400)
				DetachEntity(prop, false, true)
				Wait(2100)
				StopAnimPlayback(PlayerPedId(), 0, 0)
				table.insert(lastProps, prop)
				prop = nil
			end
		end
	end
end)

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

RegisterNetEvent('esx_emotes:aku')
AddEventHandler('esx_emotes:aku', function()
    local ad = "anim@heists@box_carry@"
    local player = PlayerPedId()
	local prop_name = prop_name or 'prop_car_battery_01'
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
			AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 60309), 0.025, 0.08, 0.255, 290.0, 290.0, 0.0, true, true, false, true, 1, true)
			TaskPlayAnim( player, ad, "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
			
		end 
	end
end)

RegisterNetEvent('esx_emotes:drzwi')
AddEventHandler('esx_emotes:drzwi', function()
    local ad = "anim@heists@box_carry@"
    local player = PlayerPedId()
	local prop_name = prop_name or 'prop_car_door_01'
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
			AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 60309), -0.075, -0.10, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
			TaskPlayAnim( player, ad, "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
			
		end 
	end
end)

RegisterNetEvent('esx_emotes:wydech')
AddEventHandler('esx_emotes:wydech', function()
    local ad = "anim@heists@box_carry@"
    local player = PlayerPedId()
	local prop_name = prop_name or 'prop_car_exhaust_01'
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
			AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 60309), 0.025, -0.10, 0.255, 200.0, 260.0, 0.0, true, true, false, true, 1, true)
			TaskPlayAnim( player, ad, "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
			
		end 
	end
end)

RegisterNetEvent('esx_emotes:pacholek')
AddEventHandler('esx_emotes:pacholek', function()
    local ad = "anim@heists@box_carry@"
    local player = PlayerPedId()
	local prop_name = prop_name or 'prop_roadcone02a'
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
			AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 60309), 0.230, 0, 0.210, -240.0, 400.0, -160.0, true, true, false, true, 1, true)
			TaskPlayAnim( player, ad, "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
			
		end 
	end
end)

RegisterNetEvent('esx_emotes:maska')
AddEventHandler('esx_emotes:maska', function()
    local ad = "anim@heists@box_carry@"
    local player = PlayerPedId()
	local prop_name = prop_name or 'prop_car_bonnet_02'
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
			AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 60309), -0.075, 0.10, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
			TaskPlayAnim( player, ad, "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
			
		end 
	end
end)

RegisterNetEvent('esx_emotes:pomoc')
AddEventHandler('esx_emotes:pomoc', function()
    local ad = "anim@heists@box_carry@"
    local player = PlayerPedId()
	local prop_name = prop_name or 'xm_prop_smug_crate_s_medical'
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
			AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 60309), 0.025, 0.08, 0.255, 250.0, 290.0, 0.0, true, true, false, true, 1, true)
			TaskPlayAnim( player, ad, "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
			
		end 
	end
end)

RegisterNetEvent('esx_emotes:beczka')
AddEventHandler('esx_emotes:beczka', function()
    local ad = "anim@heists@box_carry@"
    local player = PlayerPedId()
	local prop_name = prop_name or 'prop_barrel_01a'
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
			AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 60309), 0.050, 0.4, 0.255, 130.0, 290.0, 0.0, true, true, false, true, 1, true)
			TaskPlayAnim( player, ad, "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
			
		end 
	end
end)

RegisterNetEvent('esx_emotes:metal')
AddEventHandler('esx_emotes:metal', function()
    local ad = "anim@heists@box_carry@"
    local player = PlayerPedId()
	local prop_name = prop_name or 'prop_rub_scrap_07'
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
			AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 60309), 0.050, 0, 0.255, 150.0, 290.0, 0.0, true, true, false, true, 1, true)
			TaskPlayAnim( player, ad, "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
			
		end 
	end
end)

RegisterNetEvent('esx_emotes:deska')
AddEventHandler('esx_emotes:deska', function()
    local ad = "anim@heists@box_carry@"
    local player = PlayerPedId()
	local prop_name = prop_name or 'prop_rub_planks_01'
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
			AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 60309), 0.17, -0.10, 0.255, -100.0, 290.0, 220.0, true, true, false, true, 1, true)
			TaskPlayAnim( player, ad, "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
			
		end 
	end
end)

RegisterNetEvent('esx_emotes:fiolki')
AddEventHandler('esx_emotes:fiolki', function()
    local ad = "anim@heists@box_carry@"
    local player = PlayerPedId()
	local prop_name = prop_name or 'v_med_testtubes'
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
			AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 60309), 0.1, -0.12, 0.255, -145.0, -255.0, 0.0, true, true, false, true, 1, true)
			TaskPlayAnim( player, ad, "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
			
		end 
	end
end)

RegisterNetEvent('esx_emotes:opona')
AddEventHandler('esx_emotes:opona', function()
    local ad = "anim@heists@box_carry@"
    local player = PlayerPedId()
	local prop_name = prop_name or 'prop_rub_tyre_01'
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
			AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 60309), -0.020, 0.3, 0.255, 130.0, 290.0, 0.0, true, true, false, true, 1, true)
			TaskPlayAnim( player, ad, "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
			
		end 
	end
end)

RegisterNetEvent('esx_emotes:zderzak')
AddEventHandler('esx_emotes:zderzak', function()
    local ad = "anim@heists@box_carry@"
    local player = PlayerPedId()
	local prop_name = prop_name or 'prop_bumper_02'
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
			AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 60309), 0.17, 0.10, 0.255, 90.0, -230.0, 190.0, true, true, false, true, 1, true)
			TaskPlayAnim( player, ad, "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
			
		end 
	end
end)


RegisterNetEvent('esx_emotes:tarcza')
AddEventHandler('esx_emotes:tarcza', function()
	interactionEnabled = false
	local ad = "anim@heists@fleeca_bank@drilling"
	local prop_name = prop_name or 'prop_ballistic_shield'
	interaction = 'wiertarka' 
	if ( DoesEntityExist( PlayerPedId() ) and not IsEntityDead( PlayerPedId() )) then 
		if ( IsEntityPlayingAnim( PlayerPedId(), ad, "drill_straight_start", 3 ) ) then 
			DetachEntity(prop, 1, 1)
			DeleteObject(prop)
			Wait(1000)
			ClearPedSecondaryTask(PlayerPedId())
		else
			local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
			prop = CreateObject(GetHashKey(prop_name), x, y, z,  true,  true, true)
			table.insert(lastProps, prop)
			AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.40, 0.10, -0.03, 80.0, 250.0, 175.0, true, true, false, true, 1, true)
		end 
	end
	ESX.ShowHelpNotification('Naciśnij ~INPUT_VEH_HEADLIGHT~ aby użć tarczy')
end)

RegisterNetEvent('esx_emotes:taniec1')
AddEventHandler('esx_emotes:taniec1', function()
    local ad = "mp_safehouse"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "lap_dance_girl", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "lap_dance_girl", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:taniec2')
AddEventHandler('esx_emotes:taniec2', function()
    local ad = "special_ped@mountain_dancer@monologue_1@monologue_1a"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "mtn_dnc_if_you_want_to_get_to_heaven", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "mtn_dnc_if_you_want_to_get_to_heaven", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:taniec3')
AddEventHandler('esx_emotes:taniec3', function()
    local ad = "special_ped@mountain_dancer@monologue_2@monologue_2a"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "mnt_dnc_angel", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "mnt_dnc_angel", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:taniec4')
AddEventHandler('esx_emotes:taniec4', function()
    local ad = "special_ped@mountain_dancer@monologue_3@monologue_3a"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "mnt_dnc_buttwag", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "mnt_dnc_buttwag", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:taniec5')
AddEventHandler('esx_emotes:taniec5', function()
    local ad = "anim@amb@nightclub@dancers@black_madonna_entourage@"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "hi_dance_facedj_09_v2_male^5", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "hi_dance_facedj_09_v2_male^5", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:taniec6')
AddEventHandler('esx_emotes:taniec6', function()
    local ad = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "hi_dance_facedj_09_v1_male^4", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "hi_dance_facedj_09_v1_male^4", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:taniec7')
AddEventHandler('esx_emotes:taniec7', function()
    local ad = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "hi_dance_facedj_09_v1_female^1", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "hi_dance_facedj_09_v1_female^1", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:taniec8')
AddEventHandler('esx_emotes:taniec8', function()
    local ad = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "hi_dance_facedj_09_v1_female^2", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "hi_dance_facedj_09_v1_female^2", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:taniec9')
AddEventHandler('esx_emotes:taniec9', function()
    local ad = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "hi_dance_facedj_09_v1_female^3", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "hi_dance_facedj_09_v1_female^3", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:taniec10')
AddEventHandler('esx_emotes:taniec10', function()
    local ad = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "hi_dance_facedj_09_v1_female^4", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "hi_dance_facedj_09_v1_female^4", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:taniec11')
AddEventHandler('esx_emotes:taniec11', function()
    local ad = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "hi_dance_facedj_09_v1_female^5", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "hi_dance_facedj_09_v1_female^5", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:taniec12')
AddEventHandler('esx_emotes:taniec12', function()
    local ad = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "hi_dance_facedj_09_v1_female^6", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "hi_dance_facedj_09_v1_female^6", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:taniec13')
AddEventHandler('esx_emotes:taniec13', function()
    local ad = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "mi_dance_facedj_09_v1_female^1", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "mi_dance_facedj_09_v1_female^1", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:taniec14')
AddEventHandler('esx_emotes:taniec14', function()
    local ad = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "hi_dance_crowd_09_v1_female^1", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "hi_dance_crowd_09_v1_female^1", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:taniec15')
AddEventHandler('esx_emotes:taniec15', function()
    local ad = "anim@amb@nightclub@lazlow@hi_podium@"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "danceidle_hi_06_base_laz", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "danceidle_hi_06_base_laz", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:taniec16')
AddEventHandler('esx_emotes:taniec16', function()
    local ad = "anim@amb@nightclub@lazlow@hi_podium@"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "danceidle_hi_11_buttwiggle_f_laz", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "danceidle_hi_11_buttwiggle_f_laz", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:taniec17')
AddEventHandler('esx_emotes:taniec17', function()
    local ad = "anim@amb@nightclub@lazlow@hi_podium@"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "danceidle_hi_11_turnaround_laz", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "danceidle_hi_11_turnaround_laz", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:taniec18')
AddEventHandler('esx_emotes:taniec18', function()
    local ad = "anim@amb@nightclub@lazlow@hi_podium@"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "danceidle_hi_17_smackthat_laz", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "danceidle_hi_17_smackthat_laz", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:taniec19')
AddEventHandler('esx_emotes:taniec19', function()
    local ad = "anim@amb@nightclub@lazlow@hi_podium@"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "danceidle_mi_13_enticing_laz", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "danceidle_mi_13_enticing_laz", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:taniec20')
AddEventHandler('esx_emotes:taniec20', function()
    local ad = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "hi_dance_prop_09_v1_male^3", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "hi_dance_prop_09_v1_male^3", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:taniec21')
AddEventHandler('esx_emotes:taniec21', function()
    local ad = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "hi_dance_prop_09_v1_male^1", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "hi_dance_prop_09_v1_male^3", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:taniec22')
AddEventHandler('esx_emotes:taniec22', function()
    local ad = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "hi_dance_prop_11_v1_male^4", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "hi_dance_prop_09_v1_male^3", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:taniec23')
AddEventHandler('esx_emotes:taniec23', function()
    local ad = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "high_center", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "high_center", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:taniec24')
AddEventHandler('esx_emotes:taniec24', function()
    local ad = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "med_center", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "med_center", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:taniec25')
AddEventHandler('esx_emotes:taniec25', function()
    local ad = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "high_center", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "high_center", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:taniec26')
AddEventHandler('esx_emotes:taniec26', function()
    local ad = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "med_center", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "med_center", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:taniec27')
AddEventHandler('esx_emotes:taniec27', function()
    local ad = "anim@mp_player_intcelebrationmale@banging_tunes"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "banging_tunes", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "banging_tunes", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:taniec28')
AddEventHandler('esx_emotes:taniec28', function()
    local ad = "anim@mp_player_intcelebrationmale@cats_cradle"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "cats_cradle", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "cats_cradle", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:taniec29')
AddEventHandler('esx_emotes:taniec29', function()
    local ad = "anim@mp_player_intcelebrationmale@find_the_fish"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "find_the_fish", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "find_the_fish", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:taniec30')
AddEventHandler('esx_emotes:taniec30', function()
    local ad = "anim@mp_player_intcelebrationmale@heart_pumping"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "heart_pumping", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "heart_pumping", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:taniec31')
AddEventHandler('esx_emotes:taniec31', function()
    local ad = "anim@mp_player_intcelebrationmale@oh_snap"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "oh_snap", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "oh_snap", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:taniec32')
AddEventHandler('esx_emotes:taniec32', function()
    local ad = "anim@mp_player_intcelebrationmale@raise_the_roof"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "raise_the_roof", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "raise_the_roof", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:taniec33')
AddEventHandler('esx_emotes:taniec33', function()
    local ad = "anim@mp_player_intcelebrationmale@salsa_roll"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "salsa_roll", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "salsa_roll", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:taniec34')
AddEventHandler('esx_emotes:taniec34', function()
    local ad = "anim@mp_player_intcelebrationmale@uncle_disco"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "uncle_disco", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "uncle_disco", 8.0, 1.0, -1, 15 , 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:taniec35')
AddEventHandler('esx_emotes:taniec35', function()
    local ad = "amb@world_human_partying@female@partying_beer@idle_a"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle_b", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle_b", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:strach')
AddEventHandler('esx_emotes:strach', function()
    local ad = "amb@code_human_cower@female@base"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "base", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "base", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:strach2')
AddEventHandler('esx_emotes:strach2', function()
    local ad = "anim@heists@fleeca_bank@hostages@ped_d@"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "flinch_under_fire_outro", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "flinch_under_fire_outro", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:wkrecanie')
AddEventHandler('esx_emotes:wkrecanie', function()
    local ad = "amb@prop_human_movie_bulb@base"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "base", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "base", 8.0, 1.0, -1, 15 , 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:zul')
AddEventHandler('esx_emotes:zul', function()
    local ad = "amb@world_human_bum_slumped@male@laying_on_left_side@base"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "base", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "base", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:pochyl')
AddEventHandler('esx_emotes:pochyl', function()
    local ad = "amb@world_human_bum_wash@male@high@base"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "base", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "base", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:mechanik')
AddEventHandler('esx_emotes:mechanik', function()
    local ad = "amb@world_human_vehicle_mechanic@male@idle_a"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle_a", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:szperanie')
AddEventHandler('esx_emotes:szperanie', function()
    local ad = "anim@gangops@facility@servers@"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "hotwire", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "hotwire", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:szperanie2')
AddEventHandler('esx_emotes:szperanie2', function()
    local ad = "amb@prop_human_movie_studio_light@idle_a"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle_b", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle_b", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:murek')
AddEventHandler('esx_emotes:murek', function()
    local ad = "anim@amb@board_room@diagram_blueprints@"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "base_amy_skater_01", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "base_amy_skater_01", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:buzi')
AddEventHandler('esx_emotes:buzi', function()
    local ad = "mini@hookers_sp"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle_a", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:buzi2')
AddEventHandler('esx_emotes:buzi2', function()
    local ad = "anim@mp_player_intcelebrationmale@blow_kiss"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "blow_kiss", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "blow_kiss", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:buzi3')
AddEventHandler('esx_emotes:buzi3', function()
    local ad = "anim@mp_player_intcelebrationmale@finger_kiss"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "finger_kiss", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "finger_kiss", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:rozgrzewka')
AddEventHandler('esx_emotes:rozgrzewka', function()
    local ad = "mini@triathlon"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle_a", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:tlumacz')
AddEventHandler('esx_emotes:tlumacz', function()
    local ad = "misscarsteal4@actor"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "actor_berating_assistant", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "actor_berating_assistant", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:tlumacz2')
AddEventHandler('esx_emotes:tlumacz2', function()
    local ad = "mini@prostitutespimp_demands_money"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "pimp_demands_money_pimp", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "pimp_demands_money_pimp", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:tlumacz3')
AddEventHandler('esx_emotes:tlumacz3', function()
    local ad = "anim@mp_player_intupperv_sign"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle_a", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:tam')
AddEventHandler('esx_emotes:tam', function()
    local ad = "missmartin1@pointing_sky1@enter"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "enter", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "enter", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:podaj')
AddEventHandler('esx_emotes:podaj', function()
    local ad = "misstrevor2ig_2"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:narka')
AddEventHandler('esx_emotes:narka', function()
    local ad = "mp_player_intsalute"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "mp_player_int_salute", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "mp_player_int_salute", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:spokoj')
AddEventHandler('esx_emotes:spokoj', function()
    local ad = "oddjobs@assassinate@construction@"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "cs_getinlift", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "cs_getinlift", 8.0, 1.0, -1, 15 , 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:medytuj')
AddEventHandler('esx_emotes:medytuj', function()
    local ad = "rcmepsilonism3"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "base_loop", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "base_loop", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:wygrana')
AddEventHandler('esx_emotes:wygrana', function()
    local ad = "rcmfanatic1celebrate"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "celebrate", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "celebrate", 8.0, 1.0, -1, 15 , 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:jaskolka')
AddEventHandler('esx_emotes:jaskolka', function()
    local ad = "rcmfanatic1maryann_stretchidle_b"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle_e", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle_e", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:ocieranie')
AddEventHandler('esx_emotes:ocieranie', function()
    local ad = "mini@hookers_spcokehead"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle_a", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:ocieranie2')
AddEventHandler('esx_emotes:ocieranie2', function()
    local ad = "mini@hookers_spcokehead"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle_b", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle_b", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:ocieranie3')
AddEventHandler('esx_emotes:ocieranie3', function()
    local ad = "mini@hookers_spcokehead"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle_c", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle_c", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:wynocha')
AddEventHandler('esx_emotes:wynocha', function()
    local ad = "mini@strip_club@idles@bouncer@go_away"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "go_away", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "go_away", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:zapraszam')
AddEventHandler('esx_emotes:zapraszam', function()
    local ad = "mini@strip_club@idles@bouncer@side_enter"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "side_enter", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "side_enter", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:hej')
AddEventHandler('esx_emotes:hej', function()
    local ad = "mini@strip_club@idles@stripper"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "stripper_idle_02", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "stripper_idle_02", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:udo')
AddEventHandler('esx_emotes:udo', function()
    local ad = "mini@strip_club@idles@stripper"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "stripper_idle_04", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "stripper_idle_04", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:cyce')
AddEventHandler('esx_emotes:cyce', function()
    local ad = "mini@strip_club@idles@stripper"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "stripper_idle_05", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "stripper_idle_05", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:upadek')
AddEventHandler('esx_emotes:upadek', function()
    local ad = "melee@hatchet@streamed_core"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "victim_rear_takedown", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "victim_rear_takedown", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:skok')
AddEventHandler('esx_emotes:skok', function()
    local ad = "explosions"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "react_blown_forwards", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "react_blown_forwards", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:skok2')
AddEventHandler('esx_emotes:skok2', function()
    local ad = "explosions"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "react_blown_backwards", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "react_blown_backwards", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:nana')
AddEventHandler('esx_emotes:nana', function()
    local ad = "anim@mp_player_intupperthumb_on_ears"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle_a_fp", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle_a_fp", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:nana2')
AddEventHandler('esx_emotes:nana2', function()
    local ad = "anim@mp_player_intcelebrationmale@thumb_on_ears"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "thumb_on_ears", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "thumb_on_ears", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:naprawa2')
AddEventHandler('esx_emotes:naprawa2', function()
    local ad = "mini@repair"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "fixing_a_player", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "fixing_a_player", 8.0, 1.0, -1, 15 , 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:tam2')
AddEventHandler('esx_emotes:tam2', function()
    local ad = "amb@world_human_security_shine_torch@male@idle_a"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle_b", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle_b", 8.0, 1.0, -1, 15 , 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:lezenie2')
AddEventHandler('esx_emotes:lezenie2', function()
    local ad = "amb@world_human_sunbathe@female@back@idle_a"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle_a", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:lezenie3')
AddEventHandler('esx_emotes:lezenie3', function()
    local ad = "amb@world_human_picnic@female@idle_a"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle_a", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:lezenie4')
AddEventHandler('esx_emotes:lezenie4', function()
    local ad = "amb@world_human_sunbathe@female@front@idle_a"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle_c", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle_c", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:facepalm2')
AddEventHandler('esx_emotes:facepalm2', function()
    local ad = "anim@mp_player_intcelebrationfemale@face_palm"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "face_palm", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "face_palm", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:spierdalaj')
AddEventHandler('esx_emotes:spierdalaj', function()
    local ad = "anim@mp_player_intcelebrationfemale@finger"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "finger", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "finger", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:spierdalaj2')
AddEventHandler('esx_emotes:spierdalaj2', function()
    local ad = "anim@mp_player_intcelebrationmale@finger"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "finger", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "finger", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:gleba')
AddEventHandler('esx_emotes:gleba', function()
    local ad = "anim@heists@ornate_bank@hostages@hit"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "hit_react_a_ped_a", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "hit_react_a_ped_a", 8.0, 1.0, -1, 15 , 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:racja')
AddEventHandler('esx_emotes:racja', function()
    local ad = "anim@heists@ornate_bank@chat_manager"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "average_clothes", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "average_clothes", 8.0, 1.0, -1, 15 , 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:brawo')
AddEventHandler('esx_emotes:brawo', function()
    local ad = "anim@mp_player_intcelebrationfemale@slow_clap"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "slow_clap", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "slow_clap", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:hulk')
AddEventHandler('esx_emotes:hulk', function()
    local ad = "anim@mp_fm_event@intro"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "beast_transform", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "beast_transform", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:hulk2')
AddEventHandler('esx_emotes:hulk2', function()
    local ad = "anim@mp_player_intcelebrationmale@freakout"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "freakout", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "freakout", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:hulk3')
AddEventHandler('esx_emotes:hulk3', function()
    local ad = "anim@mp_player_intcelebrationmale@rock"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "rock", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "rock", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:sila')
AddEventHandler('esx_emotes:sila', function()
    local ad = "amb@world_human_muscle_flex@arms_at_side@base"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "base", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "base", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:sila2')
AddEventHandler('esx_emotes:sila2', function()
    local ad = "amb@world_human_muscle_flex@arms_at_side@idle_a"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle_a", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:idz')
AddEventHandler('esx_emotes:idz', function()
    local ad = "amb@world_human_power_walker@female@base"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "base", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "base", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:idz2')
AddEventHandler('esx_emotes:idz2', function()
    local ad = "move_m@non_chalant"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "walk", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "walk", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:czekanie4')
AddEventHandler('esx_emotes:czekanie4', function()
    local ad = "move_franklin@sneak"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:idz3')
AddEventHandler('esx_emotes:idz3', function()
    local ad = "move_m@power"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "walk", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "walk", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:idz4')
AddEventHandler('esx_emotes:idz4', function()
    local ad = "move_m@strung_out@"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "walk", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "walk", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:idz5')
AddEventHandler('esx_emotes:idz5', function()
    local ad = "move_slipping"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "slip_face_downhill_long", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "slip_face_downhill_long", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:swietnie')
AddEventHandler('esx_emotes:swietnie', function()
    local ad = "anim@mp_player_intcelebrationmale@thumbs_up"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "thumbs_up", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "thumbs_up", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:swietnie2')
AddEventHandler('esx_emotes:swietnie2', function()
    local ad = "anim@mp_player_intcelebrationpaired@f_m_sarcastic"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "sarcastic_left", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "sarcastic_left", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:swietnie3')
AddEventHandler('esx_emotes:swietnie3', function()
    local ad = "anim@mp_player_intcelebrationpaired@f_m_sarcastic"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "sarcastic_right", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "sarcastic_right", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:swietnie4')
AddEventHandler('esx_emotes:swietnie4', function()
    local ad = "anim@mp_player_intcelebrationpaired@m_m_sarcastic"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "sarcastic_left", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "sarcastic_left", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:swietnie5')
AddEventHandler('esx_emotes:swietnie5', function()
    local ad = "anim@mp_player_intcelebrationpaired@m_m_sarcastic"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "sarcastic_right", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "sarcastic_right", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:gitara')
AddEventHandler('esx_emotes:gitara', function()
    local ad = "anim@mp_player_intcelebrationfemale@air_guitar"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "air_guitar", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "air_guitar", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:gitara2')
AddEventHandler('esx_emotes:gitara2', function()
    local ad = "anim@mp_player_intupperair_guitar"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle_a", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:dojebalem')
AddEventHandler('esx_emotes:dojebalem', function()
    local ad = "anim@mp_player_intcelebrationpaired@f_m_bro_hug"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "bro_hug_right", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "bro_hug_right", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:dojebalem2')
AddEventHandler('esx_emotes:dojebalem2', function()
    local ad = "anim@mp_player_intcelebrationpaired@f_m_cowering"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "cowering_left", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "cowering_left", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:czekanie')
AddEventHandler('esx_emotes:czekanie', function()
    local ad = "amb@world_human_prostitute@cokehead@base"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "base", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "base", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:czekanie2')
AddEventHandler('esx_emotes:czekanie2', function()
    local ad = "amb@world_human_prostitute@crackhooker@base"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "base", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "base", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:czekanie3')
AddEventHandler('esx_emotes:czekanie3', function()
    local ad = "amb@world_human_prostitute@hooker@base"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "base", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "base", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:czekanie4')
AddEventHandler('esx_emotes:czekanie4', function()
    local ad = "amb@world_human_prostitute@crackhooker@idle_a"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle_c", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle_c", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:otak')
AddEventHandler('esx_emotes:otak', function()
    local ad = "anim@mp_player_intupperuncle_disco"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle_a_fp", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle_a_fp", 8.0, 1.0, -1, 15 , 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:cicho')
AddEventHandler('esx_emotes:cicho', function()
    local ad = "anim@mp_player_intcelebrationmale@shush"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "shush", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "shush", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:pieniadze')
AddEventHandler('esx_emotes:pieniadze', function()
    local ad = "anim@mp_player_intcelebrationmale@raining_cash"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "raining_cash", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "raining_cash", 8.0, 1.0, -1, 15 , 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:nice')
AddEventHandler('esx_emotes:nice', function()
    local ad = "anim@mp_player_intupperthumbs_up"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle_a_fp", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle_a_fp", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:piano')
AddEventHandler('esx_emotes:piano', function()
    local ad = "anim@mp_player_intupperair_synth"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle_a_fp", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle_a_fp", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:piano2')
AddEventHandler('esx_emotes:piano2', function()
    local ad = "anim@mp_player_intcelebrationmale@air_synth"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "air_synth", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "air_synth", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)RegisterNetEvent('esx_emotes:ruchanie')
AddEventHandler('esx_emotes:ruchanie', function()
    local ad = "anim@mp_player_intcelebrationfemale@dock"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "dock", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "dock", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:ruchanie2')
AddEventHandler('esx_emotes:ruchanie2', function()
    local ad = "anim@mp_player_intcelebrationmale@dock"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "dock", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "dock", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)RegisterNetEvent('esx_emotes:sio')
AddEventHandler('esx_emotes:sio', function()
    local ad = "anim@mp_player_intcelebrationpaired@f_f_cowering"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "cowering_left", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "cowering_left", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:krolowa')
AddEventHandler('esx_emotes:krolowa', function()
    local ad = "anim@mp_player_intcelebrationmale@wave"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "wave", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "wave", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:bugi')
AddEventHandler('esx_emotes:bugi', function()
    local ad = "anim@mp_player_intcelebrationmale@air_shagging"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "air_shagging", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "air_shagging", 8.0, 1.0, -1, 15 , 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:niestrzelaj')
AddEventHandler('esx_emotes:niestrzelaj', function()
    local ad = "anim@mp_player_intuppersurrender"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle_a_fp", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle_a_fp", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:kac')
AddEventHandler('esx_emotes:kac', function()
    local ad = "amb@world_human_bum_standing@depressed@idle_a"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle_a", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:wlala')
AddEventHandler('esx_emotes:wlala', function()
    local ad = "anim@mp_player_intcelebrationpaired@f_f_sarcastic"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "sarcastic_left", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "sarcastic_left", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:wlala2')
AddEventHandler('esx_emotes:wlala2', function()
    local ad = "anim@mp_player_intcelebrationpaired@f_f_sarcastic"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "sarcastic_right", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "sarcastic_right", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:tada')
AddEventHandler('esx_emotes:tada', function()
    local ad = "anim@mp_player_intcelebrationfemale@jazz_hands"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "jazz_hands", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "jazz_hands", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)RegisterNetEvent('esx_emotes:tada2')
AddEventHandler('esx_emotes:tada2', function()
    local ad = "anim@mp_player_intcelebrationmale@jazz_hands"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "jazz_hands", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "jazz_hands", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:siad')
AddEventHandler('esx_emotes:siad', function()
    local ad = "amb@world_human_stupor@male@base"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "base", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "base", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:rozwale')
AddEventHandler('esx_emotes:rozwale', function()
    local ad = "anim@mp_player_intcelebrationfemale@knuckle_crunch"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "knuckle_crunch", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "knuckle_crunch", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:siad2')
AddEventHandler('esx_emotes:siad2', function()
    local ad = "anim@heists@fleeca_bank@ig_7_jetski_owner"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "owner_idle", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "owner_idle", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:piesci')
AddEventHandler('esx_emotes:piesci', function()
    local ad = "anim@heists@heist_corona@single_team"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "single_team_intro_two", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "single_team_intro_two", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:opieranie')
AddEventHandler('esx_emotes:opieranie', function()
    local ad = "anim@mp_ferris_wheel"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle_a_player_one", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle_a_player_one", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:opieranie2')
AddEventHandler('esx_emotes:opieranie2', function()
    local ad = "anim@amb@yacht@rail@standing@male@variant_01@"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "base", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "base", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:opieranie3')
AddEventHandler('esx_emotes:opieranie3', function()
    local ad = "anim@amb@nightclub@gt_idle@"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "base", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "base", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:opieranie4')
AddEventHandler('esx_emotes:opieranie4', function()
    local ad = "anim@mp_ferris_wheel"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle_a_player_two", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle_a_player_two", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:dlubanie')
AddEventHandler('esx_emotes:dlubanie', function()
    local ad = "anim@mp_player_intcelebrationfemale@nose_pick"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "nose_pick", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "nose_pick", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:dlubanie2')
AddEventHandler('esx_emotes:dlubanie2', function()
    local ad = "anim@mp_player_intcelebrationmale@nose_pick"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "nose_pick", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "nose_pick", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:zarowka')
AddEventHandler('esx_emotes:zarowka', function()
    local ad = "anim@mp_player_intselfiejazz_hands"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle_a", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)

RegisterNetEvent('esx_emotes:zwariowany')
AddEventHandler('esx_emotes:zwariowany', function()
    local ad = "anim@mp_player_intupperyou_loco"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle_a", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 15 , 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:zwariowany2')
AddEventHandler('esx_emotes:zwariowany2', function()
    local ad = "anim@mp_player_intcelebrationmale@you_loco"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "you_loco", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "you_loco", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:dj2')
AddEventHandler('esx_emotes:dj2', function()
    local ad = "mini@strip_club@idles@dj@idle_02"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle_02", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle_02", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
RegisterNetEvent('esx_emotes:dj3')
AddEventHandler('esx_emotes:dj3', function()
    local ad = "mini@strip_club@idles@dj@idle_04"
    local player = GetPlayerPed( -1 )
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "idle_04", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 0, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(GetPlayerPed(-1))
        else
            TaskPlayAnim( player, ad, "idle_04", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
            Wait (500)
        end     
    end
end)
