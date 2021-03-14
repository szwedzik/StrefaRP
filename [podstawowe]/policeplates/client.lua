RegisterNetEvent('plates:showInfo')
AddEventHandler('plates:showInfo', function(msg, model)
	local vModel = GetDisplayNameFromVehicleModel(model)
	Citizen.CreateThread(function()	
		SetNotificationTextEntry("STRING")
		if vModel ~= 'CARNOTFOUND' then
			AddTextComponentString(msg .. '\n~b~Model: ~w~' .. vModel)
		else
			AddTextComponentString(msg)
		end
		SetNotificationMessage("CHAR_CALL911", "CHAR_CALL911", true, 4, 'Ewidencja pojazdów', '', 10.0)
		DrawNotification(false, true)
		vModel = nil
	end)
end)





