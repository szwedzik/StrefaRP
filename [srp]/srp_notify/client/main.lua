RegisterNetEvent('srp_notify:Send')
AddEventHandler('srp_notify:Send', function(data)
	DoHudText(data.type, data.text)
end)

RegisterNetEvent('srp_notify:businessesInfo')
AddEventHandler('srp_notify:businessesInfo', function(data)
	DoLongHudText(data.type, data.text)
end)

function DoShortHudText(type, text)
	SendNUIMessage({
		action = 'shortnotif',
		type = type,
		text = text,
		length = 1000
	})
end

function DoHudText(type, text)
	SendNUIMessage({
		action = 'notif',
		type = type,
		text = text,
		length = 2500
	})
end

function DoLongHudText(type, text)
	SendNUIMessage({
		action = 'longnotif',
		type = type,
		text = text,
		length = 5000
	})
end

function DoCustomHudText(type, text, length)
	SendNUIMessage({
		action = 'customnotif',
		type = type,
		text = text,
		length = length
	})
end
