RegisterNetEvent('carstats');
AddEventHandler('carstats', function()
local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped, false) then
		local veh = GetVehiclePedIsIn(ped, false)
		local model = GetEntityModel(veh, false)
		local hash = GetHashKey(model)
		TriggerEvent('chatMessage', "", {255, 0, 0}, " ^3Nazwa pojazdu:^7 ".. GetDisplayNameFromVehicleModel(model) ..
									"\r\n ^3Maksymalna prędkość:^7 ".. round(GetVehicleMaxSpeed(model) * 3.98777777,1) .."km/h" .. 
									"\r\n ^3Przyśpieszenie:^7 ".. round(GetVehicleModelAcceleration(model),1) ..
                  "\r\n ^3Biegi:^7 ".. GetVehicleHighGear(veh) ..
                  "\r\n ^3Miejsc:^7 ".. GetVehicleMaxNumberOfPassengers(veh) + 1)
	end
end)

function round(num, numDecimalPlaces)
  local mult = 100^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end