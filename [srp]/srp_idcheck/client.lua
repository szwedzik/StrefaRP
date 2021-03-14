RegisterNetEvent('id');
AddEventHandler('id', function()
	local years, months, days, hours, minutes, seconds = Citizen.InvokeNative(0x50C7A99057A69748, Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt())
	TriggerEvent('chatMessage', "", {255, 0, 0}, "^3Twoje ID:^7 " .. GetPlayerServerId(PlayerId()) ..
							"\r\n ^3Obecna data:^7 " .. years .. "." .. months .. "." .. days ..
							"\r\n ^3Obecny czas:^7 " .. hours .. ":" .. minutes .. ":" .. seconds)
end)