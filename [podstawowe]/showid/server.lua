--[[
 ___________________________________________________________________________________
|																					|
|							Script Created by: Johnny2525							|
|						Mail: johnny2525.contact@gmail.com							|
|		Linked-In: https://www.linkedin.com/in/jakub-barwi%C5%84ski-09617b164/		|
|___________________________________________________________________________________|

--]]

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
			height = identity['height'],
			job = identity['job']
		}
	else
		return nil
	end
end
function getLSPD(source)
        local identifier = GetPlayerIdentifiers(source)[1]
        local result = MySQL.Sync.fetchAll("SELECT * FROM blachy WHERE identifier = @identifier", {['@identifier'] = identifier})
        if result[1] ~= nil then
                local identity = result[1]

                return {
                        identifier = identity['identifier'],
                        number = identity['number']
                        
                }
        else
                return nil
        end
end

function LoadLicenses (source)
  TriggerEvent('esx_license:getLicenses', source, function (licenses)
    TriggerClientEvent('showid:loadLicenses', source, licenses)
  end)
end

function getJobName(jobname)
	local result = MySQL.Sync.fetchAll("SELECT * FROM jobs WHERE name = @identifier", {['@identifier'] = jobname})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			name = identity['name'],
			label = identity['label'],
		}
	else
		return nil
	end
end

TriggerEvent('es:addCommand', 'showid', function(source, args, user)
	local _source = source
	
	local driving = nil
	local weapon  = nil
	
	--LoadLicenses(_source)
	TriggerEvent('esx_license:checkLicense', _source, "drive", function(stat)
		if (stat) then driving = "TAK" else driving = "NIE" end
	end)
	Citizen.Wait(300)
	
	TriggerEvent('esx_license:checkLicense', _source, "weapon", function(stat)
		if (stat) then weapon = "TAK" else weapon = "NIE" end
	end)
	Citizen.Wait(300)
	
	local xPlayer = ESX.GetPlayerFromId(_source)
	

	local name = getIdentity(_source)
	local rname = name.firstname.. " " ..name.lastname
	local rawjob = xPlayer.getJob()
	local job = getJobName(rawjob.name)
	local addon = ""
	
	if(rawjob.name == "mecano" and rawjob.grade_name == "boss") then
		addon = " Główny"
	end
	
	if(driving ~= nil and weapon ~= nil) then
		TriggerClientEvent("showid:DisplayId", -1, _source, rname, driving, weapon, job.label .. addon)
	else
		TriggerClientEvent("showid:DisplayId", -1, _source, rname, "N/A", "N/A", job.label)
	end
end)

TriggerEvent('es:addCommand', 'dowod', function(source, args, user)
	local _source = source
	
	local driving = nil
	local weapon  = nil
	
	--LoadLicenses(_source)
	TriggerEvent('esx_license:checkLicense', _source, "drive", function(stat)
		if (stat) then driving = "TAK" else driving = "NIE" end
	end)
	Citizen.Wait(300)
	
	TriggerEvent('esx_license:checkLicense', _source, "weapon", function(stat)
		if (stat) then weapon = "TAK" else weapon = "NIE" end
	end)
	Citizen.Wait(300)
	
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	local name = getIdentity(_source)
	local rname = name.firstname.. " " ..name.lastname
	local rawjob = xPlayer.getJob()
	local job = getJobName(rawjob.name)
	local addon = ""
	
	if(rawjob.name == "mecano" and rawjob.grade_name == "boss") then
		addon = " Główny"
	end
	
	if(driving ~= nil and weapon ~= nil) then
		TriggerClientEvent("showid:DisplayId", -1, _source, rname, driving, weapon, job.label .. addon)
	else
		TriggerClientEvent("showid:DisplayId", -1, _source, rname, "N/A", "N/A", job.label)
	end
end)

TriggerEvent('es:addCommand', 'ustawblache', function(source, args, user)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source) 

	local playerId = GetPlayerIdentifiers(args[1])[1] 
	local rawjob = xPlayer.getJob()
	local blacha = tonumber(args[2])	
	if (rawjob.name == "police" and rawjob.grade_name == "boss") then
        MySQL.Async.fetchAll('SELECT * FROM blachy WHERE identifier = @identifier', {
                ['@identifier'] = playerId
        }, function(result)
                if result[1] ~= nil then
                        MySQL.Async.execute("UPDATE blachy  SET number = @blacha WHERE identifier = @identifier", {['@blacha'] = blacha, ['@identifier'] = playerId})
                else
                        
                        MySQL.Async.execute("INSERT INTO blachy (identifier, number) VALUES (@identifier, @blacha)", {['@identifier'] = playerId, ['@blacha'] = blacha})
                       
                end
        end)
	
		
		
	




end

end)








TriggerEvent('es:addCommand', 'odznaka', function(source, args, user)
    local _source = source
    local driving = nil
    local weapon  = nil

    TriggerEvent('esx_license:checkLicense', _source, "drive", function(stat)
        if (stat) then driving = "TAK" else driving = "NIE" end
    end)
    Citizen.Wait(300)

    TriggerEvent('esx_license:checkLicense', _source, "weapon", function(stat)
        if (stat) then weapon = "TAK" else weapon = "NIE" end
    end)
    Citizen.Wait(300)

    local xPlayer = ESX.GetPlayerFromId(_source)
	local badgeNumber = getLSPD(_source)
    local badge = badgeNumber.number

	local name = getIdentity(_source)
    local rname = name.firstname.. " " ..name.lastname
    local rawjob = xPlayer.getJob()
    local job = getJobName(rawjob.name)
    local addon = ""
	local numerOdznaki = ""
	local kodOdznaki = ""
	if rawjob.grade_name == "recruit" then
		kodOdznaki = "Kadet"
	elseif rawjob.grade_name == "oficer1" then
		kodOdznaki = "Funkcjonariusz Pierwszego Stopnia"
	elseif rawjob.grade_name == "oficer2" then
        kodOdznaki = "Funkcjonariusz Drugiego Stopnia"
	elseif rawjob.grade_name == "oficer3" then
        kodOdznaki = "Funkcjonariusz Trzeciego Stopnia"
	elseif rawjob.grade_name == "sergeant1" then
        kodOdznaki = "Sierżant Pierwszego Stopnia"
	elseif rawjob.grade_name == "sergeant2" then
        kodOdznaki = "Sierżant Drugiego Stopnia"
	elseif rawjob.grade_name == "sergeant3" then
        kodOdznaki = "Detektyw"
	elseif rawjob.grade_name == "por1" then
        kodOdznaki = "Porucznik Pierwszego Stopnia"
	elseif rawjob.grade_name == "por2" then
        kodOdznaki = "Porucznik Drugiego Stopnia"
	elseif rawjob.grade_name == "por3" then
        kodOdznaki = "Porucznik Trzeciego Stopnia"
	elseif rawjob.grade_name == "kapitan1" then
        kodOdznaki = "Kapitan Pierwszego Stopnia"
	elseif rawjob.grade_name == "kapitan2" then
        kodOdznaki = "Kapitan Drugiego Stopnia"
	elseif rawjob.grade_name == "kapitan3" then
        kodOdznaki = "Kapitan Trzeciego Stopnia"
	elseif rawjob.grade_name == "boss" and rawjob.name == "police" then
        kodOdznaki = "Szef Policji"
    elseif rawjob.grade_name == "komendant" then
        kodOdznaki = "Komendant"
    elseif rawjob.grade_name == "szef2" then
        kodOdznaki = "Zastępca Szefa Policji"
    elseif rawjob.grade_name == "szef1" then
        kodOdznaki = "Zastępca Komendanta"
    elseif rawjob.grade_name == "ambulance" then
        kodOdznaki = "Rekrut"
    elseif rawjob.grade_name == "boss" and rawjob.name == "ambulance" then
        kodOdznaki = "Dyrektor"
    elseif rawjob.grade_name == "zboss" then
        kodOdznaki = "Zastępca Dyrektora"
    elseif rawjob.grade_name == "medic" then
        kodOdznaki = "Ratownik Medyczny"
    elseif rawjob.grade_name == "doctor" then
        kodOdznaki = "Lekarz Ratownictwa Medycznego"
    elseif rawjob.grade_name == "chief_doctor" then
        kodOdznaki = "Doktor"
    elseif rawjob.grade_name == "" then
        kodOdznaki = ""
	end

	if(rawjob.name == "police") then
        if(driving ~= nil and weapon ~= nil) then
            TriggerClientEvent("showid:DisplayLSPD", -1, _source, rname, driving, weapon, kodOdznaki .. addon, badge)
        else
            TriggerClientEvent("showid:DisplayLSPD", -1, _source, rname, "N/A", "N/A", kodOdznaki, badge)
        end
	end

	if(rawjob.name == "ambulance") then
        if(driving ~= nil and weapon ~= nil) then
            TriggerClientEvent("showid:DisplayEMS", -1, _source, rname, driving, weapon, kodOdznaki .. addon, badge)
        else
            TriggerClientEvent("showid:DisplayEMS", -1, _source, rname, "N/A", "N/A", kodOdznaki, badge)
        end
    end
end)
RegisterNetEvent('showid:buyLicense')
AddEventHandler('showid:buyLicense', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerEvent('esx_license:checkLicense', _source, "tempdrive", function(stat)
        if not(stat) then
            if(xPlayer.getMoney() >= 200) then
                TriggerEvent('esx_license:addLicense', _source, "tempdrive", function() end)
                TriggerEvent('esx_license:addLicense', _source, "drive", function() end)
                TriggerClientEvent("esx:showNotification", _source, "~g~Kupiles/as prawo jazdy!")
                xPlayer.removeMoney(200)
            else
                TriggerClientEvent("esx:showNotification", _source, "~r~Nie masz tyle pieniedzy!")
            end
        else
            TriggerClientEvent("esx:showNotification", _source, "~y~Aby otrzymać nowe prawo jazdy udaj się na nauki jazdy!")
        end
    end)
end)


TriggerEvent('es:addCommand', 'buylicense', function(source, args, user)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerEvent('esx_license:checkLicense', _source, "tempdrive", function(stat)
        if not(stat) then
            if(xPlayer.getMoney() >= 200) then
                TriggerEvent('esx_license:addLicense', _source, "tempdrive", function() end)
                TriggerEvent('esx_license:addLicense', _source, "drive", function() end)
                TriggerClientEvent("esx:showNotification", _source, "~g~Kupiles/as prawo jazdy!")
                xPlayer.removeMoney(200)
            else
                TriggerClientEvent("esx:showNotification", _source, "~r~Nie masz tyle pieniedzy!")
        	end
        else
            TriggerClientEvent("esx:showNotification", _source, "~y~Aby otrzymać nowe prawo jazdy udaj się na nauki jazdy!")
        end
    end)
end)

RegisterNetEvent('showid:ShowId')
AddEventHandler('showid:ShowId', function()
	local _source = source
	
	local driving = nil
	local weapon  = nil
	
	TriggerEvent('esx_license:checkLicense', _source, "drive", function(stat)
		if (stat) then driving = "TAK" else driving = "NIE" end
	end)
	Citizen.Wait(300)
	
	TriggerEvent('esx_license:checkLicense', _source, "weapon", function(stat)
		if (stat) then weapon = "TAK" else weapon = "NIE" end
	end)
	Citizen.Wait(300)
	
	local xPlayer = ESX.GetPlayerFromId(_source)
	local name = getIdentity(_source)
	local rname = name.firstname.. " " ..name.lastname
	local rawjob = xPlayer.getJob()
	local job = getJobName(rawjob.name)
	local addon = ""
	
	if(rawjob.name == "mecano" and rawjob.grade_name == "boss") then
		addon = " Główny"
	end
	
	if(driving ~= nil and weapon ~= nil) then
		TriggerClientEvent("showid:DisplayId", -1, _source, rname, driving, weapon, job.label .. addon)
	else
		TriggerClientEvent("showid:DisplayId", -1, _source, rname, "N/A", "N/A", job.label)
	end
end)

RegisterNetEvent('showid:ShowIdPolice')
AddEventHandler('showid:ShowIdPolice', function(id)
    local _source = source
	local target = id
    local driving = nil
    local weapon  = nil

    --LoadLicenses(_source)
    TriggerEvent('esx_license:checkLicense', target, "drive", function(stat)
        if (stat) then driving = "TAK" else driving = "NIE" end
    end)
    Citizen.Wait(300)

    TriggerEvent('esx_license:checkLicense', target, "weapon", function(stat)
         if (stat) then weapon = "TAK" else weapon = "NIE" end
    end)
    Citizen.Wait(300)

    local xPlayer = ESX.GetPlayerFromId(target)

    local name = getIdentity(target)
    local rname = name.firstname.. " " ..name.lastname
    local rawjob = xPlayer.getJob()
    local job = getJobName(rawjob.name)
    local addon = ""

    if(rawjob.name == "mecano" and rawjob.grade_name == "boss") then
        addon = " Główny"
    end

    if(driving ~= nil and weapon ~= nil) then
        TriggerClientEvent("showid:DisplayId", -1, _source, rname, driving, weapon, job.label .. addon)
    else
        TriggerClientEvent("showid:DisplayId", -1, _source, rname, "N/A", "N/A", job.label)
    end
end)

