ESX               = nil
local PlayerData = {} 

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
	PlayerData = ESX.GetPlayerData()
end)


local holstered = true
local waitanim = false
local lastweapon = nil
local weapons = {
	"WEAPON_PISTOL",
    "WEAPON_COMBATPISTOL",
    "WEAPON_APPISTOL",
    "WEAPON_PISTOL50",
    "WEAPON_PISTOL_MK2",
    "WEAPON_VINTAGEPISTOL",
    "WEAPON_HEAVYPISTOL",
    "WEAPON_SNSPISTOL",
    "WEAPON_FLAREGUN",
    "WEAPON_MARKSMANPISTOL",
    "WEAPON_REVOLVER",
    "WEAPON_STUNGUN",
    "WEAPON_MACHINEPISTOL",
    "WEAPON_COMPACTLAUNCHER",
    "WEAPON_SNSPISTOL_MK2",
    "WEAPON_REVOLVER_MK2",
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if PlayerData.job ~= nil and PlayerData.job.name == 'police' or PlayerData.job.name == 'statepolice' or PlayerData.job.name == 'sheriff' then
			if DoesEntityExist( PlayerPedId() ) and not IsEntityDead( PlayerPedId() ) and not IsPedInAnyVehicle(PlayerPedId(), true) and not IsEntityInAir(ped) then
				local tempweap = lastweapon
				if CheckWeapon(PlayerPedId()) then
					if holstered or lastweapon ~= tempweap then
						loadAnimDict( "rcmjosh4" )
						TaskPlayAnim(PlayerPedId(), "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
						waitanim = true
						Citizen.Wait(1000)
						waitanim = false
						ClearPedTasks(PlayerPedId())
						holstered = false
					end
				elseif not CheckWeapon(PlayerPedId()) then
					if not holstered then
						loadAnimDict( "weapons@pistol@" )
						TaskPlayAnim(PlayerPedId(), "weapons@pistol@", "aim_2_holster", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
						waitanim = true
						Citizen.Wait(500)
						waitanim = false
						ClearPedTasks(PlayerPedId())
						holstered = true
					end
				end
				if (IsControlJustPressed(0, 24) or IsControlJustPressed(0, 25)) and IsEntityPlayingAnim(PlayerPedId(), "move_m@intimidation@cop@unarmed", "idle", 3) then
					ClearPedTasks(PlayerPedId())
					waitanim = true
					Citizen.Wait(1000)
					waitanim = false
				end
			end
		else
			if DoesEntityExist( PlayerPedId() ) and not IsEntityDead( PlayerPedId() ) and not IsPedInAnyVehicle(PlayerPedId(), true) and not IsEntityInAir(ped) then
				local tempweap = lastweapon
				if CheckWeapon(PlayerPedId()) then
					if holstered or lastweapon ~= tempweap then
						loadAnimDict( "reaction@intimidation@1h" )
						TaskPlayAnim(PlayerPedId(), "reaction@intimidation@1h", "intro", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
						waitanim = true
						Citizen.Wait(1700)
						waitanim = false
						ClearPedTasks(PlayerPedId())
						holstered = false
					end
				elseif not CheckWeapon(PlayerPedId()) then
					if not holstered then
						loadAnimDict( "reaction@intimidation@1h" )
						TaskPlayAnim(PlayerPedId(), "reaction@intimidation@1h", "outro", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
						waitanim = true
						Citizen.Wait(1500)
						waitanim = false
						ClearPedTasks(PlayerPedId())
						holstered = true
					end
				end
				if (IsControlJustPressed(0, 24) or IsControlJustPressed(0, 25)) and IsEntityPlayingAnim(PlayerPedId(), "move_m@intimidation@cop@unarmed", "idle", 3) then
					ClearPedTasks(PlayerPedId())
					waitanim = true
					Citizen.Wait(1000)
					waitanim = false
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if DoesEntityExist( PlayerPedId() ) and not IsEntityDead( PlayerPedId() ) and not IsPedInAnyVehicle(PlayerPedId(), true) and not IsEntityInAir(PlayerPedId()) then
			if(waitanim) then
				DisableActions(PlayerPedId())
			end
		end
	end
end)

function CheckWeapon(ped)
	for i = 1, #weapons do
		if GetHashKey(weapons[i]) == GetSelectedPedWeapon(ped) then
			lastweapon = GetSelectedPedWeapon(ped)
			return true
		end
	end
	return false
end

function DisableActions(ped)
	DisableControlAction(0, 140, true)
	DisableControlAction(0, 141, true)
	DisableControlAction(0, 142, true)
	DisableControlAction(0, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
	DisablePlayerFiring(ped, true) -- Disable weapon firing
end

function loadAnimDict( dict )
	while ( not HasAnimDictLoaded( dict ) ) do
		RequestAnimDict( dict )
		Citizen.Wait( 10 )
	end
end
