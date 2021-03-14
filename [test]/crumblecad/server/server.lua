local ESX = nil
local fines = {}

TriggerEvent('esx:getSharedObject',function(obj)
    ESX = obj
end)

----------------------------------------
-----------Register User----------------
----------------------------------------
RegisterNetEvent('cadUser:Register') --Triggered when user first connects and checks if in cad_users. Also triggered by esx_identity
AddEventHandler('cadUser:Register', function()
    
    local identifier = GetPlayerIdentifier(source, 0)
    
    --get rp name and dob from users db
    local user = MySQL.Sync.fetchAll('SELECT firstname, lastname, dateofbirth FROM users WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    })
    
    local firstName = user[1].firstname
    local lastName = user[1].lastname
    local dob = user[1].dateofbirth
    
    --check to see if user is in cad_users
    local cad_user = MySQL.Sync.fetchAll('SELECT name, dob, steamIdentifier FROM cad_users WHERE name = @name AND dob = @dob AND steamIdentifier = @identifier',{
        
        ['@name'] = firstName.." "..lastName,
        ['@dob'] = dob,
        ['@identifier'] = identifier
    })
    
    if next(cad_user) == nil then --they are not in the cad database
        local character = MySQL.Sync.fetchAll('SELECT * FROM characters WHERE FirstName = @firstName AND LastName = @lastName AND dateofbirth = @dob',{
            ['@firstName'] = firstName,
            ['@lastName'] = lastName,
            ['@dob'] = dob,
        })
        
        local profile = {}
        profile['gender'] = character[1].sex
        profile['commercialL'] = "n"
        profile['bikeL'] = "n"
        profile['carL'] = "n"
        profile['height'] = character[1].height
        
        MySQL.Async.execute('INSERT INTO cad_users (steamIdentifier, name, dob, profile) VALUES (@identifier, @name, @dob, @profile)', --insert into cad
        {
            ['@identifier']   = identifier,
            ['@name']   = firstName.." "..lastName,
            ['@dob'] = dob,
            ['@profile'] = json.encode(profile)
        }, function (rowsChanged)
        end)
    end
end)
----------------------------------------
-----------End Register User------------
----------------------------------------

----------------------------------------
--=========Start Callbacks============--
----------------------------------------

----------------------------------------
--===Start of citizen search cb=======--
----------------------------------------

ESX.RegisterServerCallback('crumbleCad:getCitizen', function(source, cb, data) --Pulls all user data from cad_users
    local userInfo = {}
    
    MySQL.Async.fetchAll(
    'SELECT * FROM `cad_users` WHERE `name` = @name and `dob` = @dob',
    {
        ['@name'] = data.firstname .. ' ' .. data.surname,
        ['@dob'] = data.dob
    },
    function(result)
        if result[1] ~= nil then
            userInfo['name'] = result[1].name
            userInfo['dob'] = result[1].dob
            userInfo['identifier'] = result[1].steamIdentifier
            userInfo['profile'] = json.decode(result[1].profile)
            cb(userInfo)
        else
            cb(false)
        end
    end)
end)

ESX.RegisterServerCallback('crumbleCad:getFines', function(source, cb, data) --gets users fines
    
    print(data.name)
    print(data.identifier)
    
    MySQL.Async.fetchAll('SELECT * FROM `cad_fines` WHERE `receiver` = @receiver and `steamIdentifier` = @steamIdentifier',{
        ['@receiver'] = data.name,
        ['@steamIdentifier'] = data.identifier
    },
    function(result)
        if next(result) ~= nil then
            cb(result)
        else
            cb(false)
        end
    end)
end)

ESX.RegisterServerCallback('crumbleCad:getWarrants',function(source, cb, data) --gets users warrants
    MySQL.Async.fetchAll('SELECT * FROM cad_warrants WHERE receiver = @receiver and steamIdentifier = @steamIdentifier',{
        ['@receiver'] = data.name,
        ['@steamIdentifier'] = data.identifier
    },
    function(result)
        if next(result) ~= nil then
            cb(result)
        else
            cb(false)
        end
    end)
end)

ESX.RegisterServerCallback('crumbleCad:GetCitizenIncidents',function(source, cb, data) --gets any reports related to person
    
    local name = {}
    local string = data.name
    
    for w in string:gmatch('%S+') do
        table.insert(name, w)
    end
    
    local firstname = firstToUpper(name[1])
    local lastname = firstToUpper(name[2])
    
    local result = MySQL.Sync.fetchAll('SELECT * FROM cad_reports WHERE steamIdentifier = @steamIdentifier AND suspects_name = @name', {
        ['@steamIdentifier'] = data.identifier,
        ['@name'] = firstname.." "..lastname
    })
    
    if next(result) ~= nil then
        cb(result)
    else
        cb(false)
    end
    
end)

ESX.RegisterServerCallback('crumbleCad:getConvictions', function(source, cb, data) --gets any convictions relaters to person
    
    local name = {}
    local string = data.name
    
    for w in string:gmatch('%S+') do
        table.insert(name, w)
    end
    
    local firstname = firstToUpper(name[1])
    local lastname = firstToUpper(name[2])
    
    local result =
    MySQL.Sync.fetchAll('SELECT * FROM cad_convictions WHERE steamIdentifier = @identifier AND suspect_name = @name',
    {
        ['@identifier'] = data.identifier,
        ['@name'] = firstname.." "..lastname
    })
    
    if next(result) ~= nil then
        cb(result)
    else
        cb(false)
    end
    
end)

----------------------------------------
--=====End of citizen search cb=======--
----------------------------------------
----------------------------------------
--=========Start of reports===========--
----------------------------------------
ESX.RegisterServerCallback('crumbleCad:submitReport',function(source, cb, data) --adds report to db
    
    if data.name ~= nil then
        local name = {}
        local string = data.name
        
        for w in string:gmatch('%S+') do
            table.insert(name, w)
        end
        
        local identifier = GetCharacterIdentifier(name[1], name[2], data.dob)
        
        if identifier then
            local firstname = firstToUpper(name[1])
            local lastname = firstToUpper(name[2])
            
            MySQL.Async.execute('INSERT INTO cad_reports (officer,steamIdentifier,suspects_name,report,date) VALUES (@officer,@steamIdentifier,@suspects_name,@report,@date)',
            {
                ['@officer'] = GetCharacterName(source),
                ['@steamIdentifier'] = identifier,
                ['@suspects_name'] = firstname .. ' ' .. lastname,
                ['@report'] = data.report,
                ['@date'] = convertDate(os.date('%x'))
            },
            function(rowsChanged)
                if rowsChanged > 0 then
                    cb(true)
                else
                    cb(false)
                end
            end)
        else
            cb('notFound')
        end
    else
        MySQL.Async.execute('INSERT INTO cad_reports (officer,report,date) VALUES (@officer,@report, @date)',{
            ['@officer'] = GetCharacterName(source),
            ['@report'] = data.report,
            ['@date'] = convertDate(os.date('%x'))
        },
        function(rowsChanged)
            if rowsChanged > 0 then
                cb(true)
            else
                cb(false)
            end
        end)
    end
end)

ESX.RegisterServerCallback('crumbleCad:editReport', function(source, cb, data) --updates reports
    
    MySQL.Async.execute('UPDATE cad_reports SET report = @newReport WHERE officer = @officer AND report = @oldReport',{
        ['@newReport'] = data.newReport,
        ['@officer'] = data.officer,
        ['@oldReport'] = data.report
    },
    function(rowsChanged)
        if rowsChanged > 0 then
            cb(true)
        else
            cb(false)
        end
    end)
    
end)

ESX.RegisterServerCallback('crumbleCad:getReports',function(source, cb) --gets all reports for view reports page
    local result = MySQL.Sync.fetchAll('SELECT * FROM cad_reports', {})
    
    if next(result) ~= nil then
        cb(result)
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('crumbleCad:deleteReport', function(source, cb, data) --deletes reports from db
    
    MySQL.Async.execute('DELETE FROM cad_reports WHERE officer = @officer AND report = @report AND date = @date',{
        ['@officer'] = data.officer,
        ['@report'] = data.report,
        ['@date'] = data.date
    },
    function(rowsChanged)
        if rowsChanged > 0 then
            cb(true)
        else
            cb(false)
        end
    end)
    
end)
----------------------------------------
--===========End of reports===========--
----------------------------------------

----------------------------------------
--===========Start of fines===========--
----------------------------------------
ESX.RegisterServerCallback('crumbleCad:deleteFine', function(source, cb, data) --deletes fines from db
    
    MySQL.Async.execute('DELETE FROM cad_fines WHERE officer = @officer AND reason = @reason AND date = @date',{
        ['@officer'] = data._officer,
        ['@reason'] = data._reason,
        ['@date'] = data._date
    },
    function(rowsChanged)
        if rowsChanged > 0 then
            cb(true)
        else
            cb(false)
        end
    end)
end)

ESX.RegisterServerCallback('crumbleCad:submitFine', function(source, cb, data) --adds fine to cad db and notifies target
    local issued = false
    
    for _, player in ipairs(ESX.GetPlayers()) do
        local steam = GetPlayerIdentifier(player,0)
        if data.identifier == steam then
            local xTarget = ESX.GetPlayerFromId(player)
            local xPlayer = ESX.GetPlayerFromId(source)
            issued = true
            
            if Config.cadFines then
                
            else
                MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)',
                {
                    ['@identifier']  = data.identifier,
                    ['@sender']      = xPlayer.identifier,
                    ['@target_type'] = 'society',
                    ['@target']      = 'society_police',
                    ['@label']       = data.reason,
                    ['@amount']      = data.amount
                }, function(rowsChanged)
                    TriggerClientEvent('esx:showNotification', xTarget.source, 'you ~g~received~s~ an invoice of ~r~$'..data.amount..'~s~')
                end)
                
                MySQL.Async.execute('INSERT INTO cad_fines (steamIdentifier, officer, receiver, reason, amount, date, paid) VALUES (@steamIdentifier, @officer, @receiver, @reason, @amount, @date, @paid)',
                {
                    ['@steamIdentifier'] = data.identifier,
                    ['@officer'] = data.officer,
                    ['@receiver'] = data.name,
                    ['@reason'] = data.reason,
                    ['@amount'] = data.amount,
                    ['@date'] = convertDate(os.date('%x')),
                    ['@paid'] = 'n'
                })   
            end
            
            break
        end
    end
    
    if issued then
        cb(true)
    else
        cb(false)
    end
end)
----------------------------------------
--=============End of fines===========--
----------------------------------------
----------------------------------------
--========Start of warrants===========--
----------------------------------------
ESX.RegisterServerCallback('crumbleCad:deleteWarrant', function(source, cb, data) --deletes warrants from db
    
    MySQL.Async.execute('DELETE FROM cad_warrants WHERE officer = @officer AND reason = @reason AND date_issued = @date',{
        ['@officer'] = data._officer,
        ['@reason'] = data._reason,
        ['@date'] = data._date
    },
    function(rowsChanged)
        if rowsChanged > 0 then
            cb(true)
        else
            cb(false)
        end
    end)
    
end)
----------------------------------------
--=========End of warrants============--
----------------------------------------
----------------------------------------
--======Start of vehicle stuff========--
----------------------------------------
ESX.RegisterServerCallback('crumbleCad:checkPlate', function(source, cb, data) --checks if vehicle is owned. 
    
    local result = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate',
    {
        ['@plate'] = data.plate
    })
    
    if next(result) ~= nil then
        cb(result[1])
    else
        cb(false)
    end
    
end)
----------------------------------------
--=======End of vehicle stuff=========--
----------------------------------------
----------------------------------------
--====Start of source player stuff====--
----------------------------------------
ESX.RegisterServerCallback('crumbleCad:getOfficerName', function(source, cb) --gets officer name when opening cad
    local name = GetCharacterName(source)
    cb(name)
end)

ESX.RegisterServerCallback('crumbleCad:checkJob', function(source, cb) --checks players job is police
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == "police" then
        cb(true)
    end
end)
----------------------------------------
--======End of source player stuff====--
----------------------------------------
-----------------------------------------
--============Functions================--
-----------------------------------------

function GetCharacterName(source)
    local result =
    MySQL.Sync.fetchAll(
    'SELECT firstname, lastname FROM users WHERE identifier = @identifier',
    {
        ['@identifier'] = GetPlayerIdentifiers(source)[1]
    })
    
    if result[1] and result[1].firstname and result[1].lastname then
        return ('%s %s'):format(result[1].firstname, result[1].lastname)
    end
end

function GetCharacterIdentifier(firstname, lastname, dob)
    firstname = firstToUpper(firstname)
    lastname = firstToUpper(lastname)
    
    local result =
    MySQL.Sync.fetchAll(
    'SELECT identifier FROM users WHERE firstname = @firstname AND lastname = @lastname AND dateofbirth = @dob',
    {
        ['@firstname'] = firstname,
        ['@lastname'] = lastname,
        ['@dob'] = dob
    })
    
    if result[1] then
        return result[1].identifier
    else
        return false
    end
end

function firstToUpper(str)
    return (str:gsub('^%l', string.upper))
end

function convertDate(vardate)
    local d, m, y = string.match(vardate, '(%d+)/(%d+)/(%d+)')
    return string.format('%s/%s/%s', m, d, y)
end