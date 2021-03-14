TriggerEvent('es:addCommand', 'carstats', function(source, args, user)
	      TriggerClientEvent('carstats', source, {})
end, {help = "Informacje na temat pojazdu"})
