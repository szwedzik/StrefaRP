----------------off broń dla NPC----------------
local pedindex = {}
function SetWeaponDrops() -- This function will set the closest entity to you as the variable entity.
  local handle, ped = FindFirstPed()
  local finished = false -- FindNextPed will turn the first variable to false when it fails to find another ped in the index
  repeat 
	  if not IsEntityDead(ped) then
		  pedindex[ped] = {}
	  end
	  finished, ped = FindNextPed(handle) -- first param returns true while entities are found
  until not finished
  EndFindPed(handle)

  for peds,_ in pairs(pedindex) do
	  if peds ~= nil then -- set all peds to not drop weapons on death.
		  SetPedDropsWeaponsWhenDead(peds, false) 
	  end
  end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(50)
		SetWeaponDrops()
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(50)
		local playerLocalisation = GetEntityCoords(PlayerPedId())
		ClearAreaOfCops(playerLocalisation.x, playerLocalisation.y, playerLocalisation.z, 400.0)
		ClearAreaOfPeds(1680.07, 2512.8, 45.4649, 100.0001)
		ClearAreaOfPeds(-2080.90, 3258.49, 32.81, 450.0001)
		ClearAreaOfVehicles(-2080.90, 3258.49, 32.81, 450.0001, false, false, false, false, false)
		RemoveVehiclesFromGeneratorsInArea(39.00, -453.49, -222.00, 462.22, -248.49, 85.59);
	end
end)