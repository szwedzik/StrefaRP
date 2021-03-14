RegisterCommand("drzwi",function(source, args)
	if args[1] == nil or args[1] == '' then
		TriggerEvent('chatMessage', "Kontrola drzwi pojazdu - /drzwi [n]", {200,0,0} , '\n 0 - Przednie lewe drzwi \n 1 - Przednie prawe drzwi \n 2 - Lewe tylnie drzwi \n 3 - Prawe tylnie drzwi \n 4 - Maska \n 5 - Bagażnik \n 6 - Bagażnik2')
		return
	end
	args[1] = tonumber(args[1])
	if GetVehicleDoorAngleRatio(GetVehiclePedIsIn(PlayerPedId()), args[1]) < .2 then
		SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), args[1], false, false)
	end
	if GetVehicleDoorAngleRatio(GetVehiclePedIsIn(PlayerPedId()), args[1]) > .2 then
		SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), args[1], false)
	end
end, false)