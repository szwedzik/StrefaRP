Citizen.CreateThread(function()
	while true do
		Citizen.Wait(300000)
		TriggerEvent('esx_status:getStatus', 'hunger', function(status)
			if status.val <= 500000 and status.val >= 250000 then
				exports['mythic_notify']:DoCustomHudText('inform', 'Czujesz się głodny - zjedz coś', 10000)
			end
		end)

		

		TriggerEvent('esx_status:getStatus', 'thirst', function(status)
			if status.val <= 500000 and status.val >= 250000 then
				exports['mythic_notify']:DoCustomHudText('inform', 'Robi ci się sucho w gardle - napij się czegoś', 10000)
			end
		end)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(120000)
		TriggerEvent('esx_status:getStatus', 'hunger', function(status)
			if status.val <= 250000 and status.val >= 0 then
				exports['mythic_notify']:DoCustomHudText('inform', 'Z braku jedzenia niedługo stracisz przytomność', 10000)
			end
		end)

		

		TriggerEvent('esx_status:getStatus', 'thirst', function(status)
			if status.val <= 250000 and status.val >= 0 then
				exports['mythic_notify']:DoCustomHudText('inform', 'Niedługo zemdlejesz z odwodnienia', 10000)
			end
		end)
	end
end)