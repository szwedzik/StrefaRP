DensityMultiplier = 0.03
DensityMultiplier1 = 0.00
DensityMultiplier2 = 0.03
DensityMultiplier111 = 0.1
local ped = GetPlayerPed(-1)



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedInAnyVehicle(PlayerPedId(), false) then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == ped then
				SetVehicleDensityMultiplierThisFrame(DensityMultiplier2)
				SetPedDensityMultiplierThisFrame(DensityMultiplier111)
				SetRandomVehicleDensityMultiplierThisFrame(DensityMultiplier2)
				SetParkedVehicleDensityMultiplierThisFrame(DensityMultiplier2)
				SetScenarioPedDensityMultiplierThisFrame(DensityMultiplier2, DensityMultiplier2)
			else
				SetVehicleDensityMultiplierThisFrame(DensityMultiplier1)
				SetPedDensityMultiplierThisFrame(DensityMultiplier111)
				SetRandomVehicleDensityMultiplierThisFrame(DensityMultiplier1)
				SetParkedVehicleDensityMultiplierThisFrame(DensityMultiplier1)
				SetScenarioPedDensityMultiplierThisFrame(DensityMultiplier1, DensityMultiplier1)
			end
		else
			SetVehicleDensityMultiplierThisFrame(DensityMultiplier)
			SetPedDensityMultiplierThisFrame(DensityMultiplier111)
			SetRandomVehicleDensityMultiplierThisFrame(DensityMultiplier)
			SetParkedVehicleDensityMultiplierThisFrame(DensityMultiplier)
			SetScenarioPedDensityMultiplierThisFrame(DensityMultiplier, DensityMultiplier)
		end
	end
end)