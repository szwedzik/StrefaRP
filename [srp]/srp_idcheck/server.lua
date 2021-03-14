TriggerEvent('es:addCommand', 'id', function(source, args, user)
	TriggerClientEvent('id', source, {})
end, {help = "Sprawdzanie swojego ID, obecnej daty oraz godziny"})

