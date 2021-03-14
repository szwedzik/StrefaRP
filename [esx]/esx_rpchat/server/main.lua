ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
		}
	else
		return nil
	end
end
--source_passed,text,type
AddEventHandler('chatMessage', function(source, name, message)
	local args = stringsplit(message, " ")
	
	if string.sub(message, 1, string.len("/")) ~= "/" then
		TriggerClientEvent("sendProximityMessage", -1, source, name, message)
		TriggerEvent('srp_logs:chatLog',source,message,'local ooc')
		--TriggerClientEvent('esx:showNotification', source, 'ten event dziala '..source..' '..message)
	end

	--if args[1] == '/tweet' then
		--obcinam tu zeby sie nie bawic poźniej
		--[[
		CancelEvent('chatMessage')
		local messToPass =  string.sub(message, string.len("/tweet")+2, #message)
		TriggerEvent('srp_logs:chatLog',source,messToPass,'tweet')
		local _source = source
		local xPlayer = ESX.GetPlayerFromId(_source)
		local phone = xPlayer.getInventoryItem("phone")
		if(phone.count <= 0) then
		else
			local msg = args
			table.remove(msg, 1)
			local test = table.concat(msg, " ")
			test = test:gsub("%^1", "")
			test = test:gsub("%^2", "")
			test = test:gsub("%^3", "")
			test = test:gsub("%^4", "")
			test = test:gsub("%^5", "")
			test = test:gsub("%^6", "")
			test = test:gsub("%^7", "")
			test = test:gsub("%^8", "")
			test = test:gsub("%^9", "")
			local name = getIdentity(source)
			--TriggerClientEvent('chat:addMessage', -1, { templateId = 'tweet', multiline = true, args = { name.firstname .. " " .. name.lastname, test } })
		end
		]]
	--elseif args[1] == '/anon' then
		--[[
		local messToPass =  string.sub(message, string.len("/anon")+2, #message)
		TriggerEvent('srp_logs:chatLog',source,messToPass,'anon')
			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)
			local phone = xPlayer.getInventoryItem("phone")
			if(phone.count <= 0) then
				TriggerClientEvent("esx:showNotification", source, "~y~Nie możesz korzystac z DarkWebu!\n~r~Nie posiadasz telefonu!")
			else
				if(xPlayer.get('money') >= 100) then
					local msg = args
					table.remove(msg, 1)
					local name = getIdentity(source)
					TriggerClientEvent("anonTweet", -1, source, name.firstname .. " " .. name.lastname, table.concat(msg, " "),xPlayer.job.name)
					xPlayer.removeMoney(100)
				else
					TriggerClientEvent("esx:showNotification", source, "~y~Nie masz gotówki!\n~r~Koszt wiadomości: 100$!")
				end
			end
			]]
	if args[1] == '/me' then
		local messToPass =  string.sub(message, string.len("/me")+2, #message)
		TriggerEvent('srp_logs:chatLog',source,messToPass,'me')
		local msg = args
		table.remove(msg, 1)
		local name = getIdentity(source)
		TriggerClientEvent("sendProximityMessageMe", -1, source, name.firstname .. " " .. name.lastname, table.concat(msg, " "))
	elseif args[1] == '/do' then
		local messToPass =  string.sub(message, string.len("/do")+2, #message)
		TriggerEvent('srp_logs:chatLog',source,messToPass,'do')
		local msg = args
		table.remove(msg, 1)
		local name = getIdentity(source)
		TriggerClientEvent("sendProximityMessageDo", -1, source, name.firstname .. " " .. name.lastname, table.concat(msg, " "))
	--elseif args[1] == '/ooc' then
		--local messToPass =  string.sub(message, string.len("/ooc")+2, #message)
		--TriggerEvent('srp_logs:chatLog',source,messToPass,'ooc')
		--local msg = args
		--table.remove(msg, 1)
		--TriggerClientEvent('chat:addMessage', -1, { templateId = 'ooc', multiline = true, args = {  "OOC | " .. GetPlayerName(source), table.concat(msg, " ") } })
	elseif args[1] == '/med' then
		CancelEvent('chatMessage')
		local messToPass =  string.sub(message, string.len("/med")+2, #message)
		TriggerEvent('srp_logs:chatLog',source,messToPass,'med')
		local msg = args
		table.remove(msg, 1)
		local name = getIdentity(source)
		TriggerClientEvent("sendProximityMessageMed", -1, source, name.firstname .. " " .. name.lastname, table.concat(msg, " "))
	else
		--TriggerEvent('srp_logs:chatLog',source,message,'local ooc')
	end
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	-- print(args[1] .. ' [' .. xPlayer.identifier .. '][' .. _source .. '] - ' .. args[2])
	CancelEvent()
end)

RegisterServerEvent('srvsendProximityCmdMessage')
AddEventHandler('srvsendProximityCmdMessage', function(name, message)
	TriggerClientEvent("sendProximityCmdMessage", -1, source, name, message)
end)
RegisterServerEvent('esx_rpchat:kick')
AddEventHandler('esx_rpchat:kick', function()
	DropPlayer(source, 'AutoKick: Nadużywanie local ooc.')
end)
RegisterServerEvent('srvsendnoPoliceDark')
AddEventHandler('srvsendnoPoliceDark', function(name, message)
    TriggerClientEvent("noPoliceDark", -1, source, name, message,police)
end)

function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end
