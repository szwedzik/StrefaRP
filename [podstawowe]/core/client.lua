local scopedWeapons = 
{
    100416529,  -- WEAPON_SNIPERRIFLE
    205991906,  -- WEAPON_HEAVYSNIPER
    3342088282, -- WEAPON_MARKSMANRIFLE
	177293209,   -- WEAPON_HEAVYSNIPER MKII
	1785463520  -- WEAPON_MARKSMANRIFLE_MK2
}

function HashInTable( hash )
    for k, v in pairs( scopedWeapons ) do 
        if ( hash == v ) then 
            return true 
        end 
    end 

    return false 
end 

function ManageReticle()
    local ped = GetPlayerPed( -1 )
    local _, hash = GetCurrentPedWeapon( ped, true )
        if not HashInTable( hash ) then 
			HideHudComponentThisFrame( 14 )
		end 
end 
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3)
		ManageReticle()
		DisplayAmmoThisFrame(false)
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3)
		NetworkSetFriendlyFireOption(true)
		SetCanAttackFriendly(PlayerPedId(), true, true)
	end
end)

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(10)
		local ped = PlayerPedId()
		if IsPedArmed(ped, 6) then
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3)
		if GetPlayerWantedLevel(PlayerId()) ~= 0 then
			SetPlayerWantedLevel(PlayerId(), 0, false)
			SetPlayerWantedLevelNow(PlayerId(), false)
			SetPlayerWantedLevelNoDrop(PlayerId(), 0, false)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		for i = 1, 15 do
			EnableDispatchService(i, false)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		SetGarbageTrucks(0)
		SetRandomBoats(0)
		Citizen.Wait(10)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
   end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		DisablePlayerVehicleRewards(PlayerId())	
	end
end)