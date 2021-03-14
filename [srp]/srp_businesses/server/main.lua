--[[
Name: srp_businesses
Author: Ezi - Ezi#0001
Version: v0.1.5
Date: 16/07/2019 - 22:45
]]--
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) 
	ESX = obj 
end)

---- Podstawowe wartosci! NIE RUSZAC!
local DafaultPrice = 150000
local DefaultName = "Biznes"
local DefaultMarker = 20
local DefaultState = 0
local DefaultInterior = "null"
local ppos = ""
local doortxt = ""
local statetxt = ""
local isAdmin = false
local doorsstatetxt = ""
local LockerCoords
local LBizId
local UseCMD
local LBizOwner
local BuyLastBizID
local Biz = {}
local InteriorConfig = {}

---- Ladowanie wszystkich biznesow przy starcie skryptu
AddEventHandler('onResourceStart', function(resource)
    Citizen.Wait(120000)
    if resource == 'srp_businesses' then
        local allBusinesses = MySQL.Sync.fetchScalar("SELECT COUNT(1) FROM srp_businesses")
        print("^1[SRP] Businesses has been started!^0")
        Citizen.Wait(150)
        print("^1[SRP] ^3"..allBusinesses.." ^1businesses has been sucessfully loaded!^0")
        LoadBusinesses()
        Citizen.Wait(200)
        ReloadBusinesses()
    end
end)

--------------------- Komendy
---- Komenda odpowiedzialna za tworzenie biznesu.
TriggerEvent('es:addGroupCommand', 'bizcreate', '_dev', function(source, args, user)
    local name = args[1]
    local marker = tonumber(args[2])
    local price = tonumber(args[3])
    local state = tonumber(args[4])
    local identifier = GetPlayerIdentifiers(source)[1]
    TriggerClientEvent("srp_businesses:getPos", source)

    if not name or not marker or not price or not state then
        name = DefaultName
        marker = DefaultMarker
        price = DafaultPrice
        state = DefaultState
        --if state == 0 then
        --    state = "Do kupienia"
        --elseif state == 1 then
        --    state = "Kupiony"
        --elseif state == 2 then
        --    state = "Wynajęty"
        --end
        TriggerClientEvent('srp_notify:businessesInfo', source, { type = 'error', text = 'Podczas tworzenia biznesu nie podałeś wymaganych wartości! Biznes został stworzony z podstawowymi wartościami.' })
        Citizen.Wait(5000)
        TriggerClientEvent('srp_notify:businessesInfo', source, { type = 'error', text = 'Aby edytować biznes: /bizedit (id)' })
        MySQL.Async.execute("INSERT INTO srp_businesses (id, name, owner, price, x, y, z, interior, owner_zone, locker_zone, garage_zone, doors, state, creation_date, last_modified) VALUES (null, @name, @owner, @price, @x, @y, @z, null, null, null, null, 1, @state, @creation_date, null)", {['@name'] = name, ['@owner'] = identifier, ['@price'] = price, ['@x'] = tonumber(ppos.x), ['@y'] = tonumber(ppos.y), ['@z'] = tonumber(ppos.z), ['@state'] = state, ['@creation_date'] = os.date('%Y-%m-%dT%H:%M:%S')})
        Citizen.Wait(50)
        LoadBusinesses()
        Citizen.Wait(2)
        ReloadBusinesses()
    else
        if string.len(name) < 3 or string.len(name) > 35 then
            TriggerClientEvent('srp_notify:businessesInfo', source, { type = 'error', text = 'Błąd! Nazwa nie może być krótsza niż 3 oraz dłuższa niż 35 znaków!' })
        elseif marker < 0 or marker > 28 then
            TriggerClientEvent('srp_notify:businessesInfo', source, { type = 'error', text = 'Błąd! poprawne wartości to (0-28)' })
        elseif price < 25000 then
            TriggerClientEvent('srp_notify:businessesInfo', source, { type = 'error', text = 'Błąd! Cena nie może być niższa niż 25000$' })
        elseif state > 2 or state < 0 then
            TriggerClientEvent('srp_notify:businessesInfo', source, { type = 'error', text = 'Błąd! Podałeś niewłaściwą wartość statusu! Dostępne statusy: (0 - Na sprzedaż / 1 - Kupiony / 2 - Wynajęty)' })
        else
            --if state == 0 then
            --    state = "Na sprzedaż"
            --elseif state == 1 then
            --    state = "Kupiony"
            --elseif state == 2 then
            --    state = "Wynajęty"
            --end
            TriggerClientEvent('srp_notify:businessesInfo', source, { type = 'inform', text = 'Biznes został pomyślnie stworzony!' })
            Citizen.Wait(5000)
            MySQL.Async.execute("INSERT INTO srp_businesses (id, name, owner, price, x, y, z, interior, owner_zone, locker_zone, garage_zone, doors, state, creation_date, last_modified, modified_by) VALUES (null, @name, @owner, @price, @x, @y, @z, null, null, null, null, 1, @state, @creation_date, null, null)", {['@name'] = name, ['@owner'] = identifier, ['@price'] = price, ['@x'] = tonumber(ppos.x), ['@y'] = tonumber(ppos.y), ['@z'] = tonumber(ppos.z), ['@state'] = state, ['@creation_date'] = os.date('%Y-%m-%dT%H:%M:%S')})
            Citizen.Wait(50)
            LoadBusinesses()
            Citizen.Wait(2)
            ReloadBusinesses()
        end
    end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', '^0Nie masz uprawnień by to wykonać!' } })
end, {help = "Tworzy biznes", params = {{name = "nazwa", help = "Nazwa"}, {name = "id markera", help = "Marker (0-28)"}, {name = "cena", help = "Cena"}, {name = "status", help = "0 - Na sprzedaż / 1 - Kupiony / 2 - Wynajęty"}}})

---- Komenda odpowiedzialna za edytowanie biznesu
TriggerEvent('es:addGroupCommand', 'bizedit', '_dev', function(source, args, user)
    if args[1] then
        local id = tonumber(args[1])
        local type = args[2]
        local variable = args[3] 

        if id and type and variable ~= nil then
            if type == 'name' then
                if string.len(variable) < 3 or string.len(variable) > 35 then
                    TriggerClientEvent('srp_notify:businessesInfo', source, { type = 'error', text = 'Błąd! Nazwa nie może być krótsza niż 3 oraz dłuższa niż 35 znaków!' })
                else
                    MySQL.Async.execute('UPDATE srp_businesses SET name = @name, last_modified = @last_modified, modified_by = @admin WHERE id = @id', {['@name'] = variable, ['@id'] = id, ['@last_modified'] = os.date('%Y-%m-%dT%H:%M:%S'), ['@admin'] = GetPlayerName(source)})
                    TriggerClientEvent('srp_notify:businessesInfo', source, { type = 'inform', text = 'Pomyślnie ustawiono Nazwę: '..variable..' dla Biznesu o ID: '..id })
                    Citizen.Wait(50)
                    LoadBusinesses()
                    Citizen.Wait(2)
                    ReloadBusinesses()
                end
            elseif type == 'owner' then
                TriggerEvent("es:getPlayerFromId", tonumber(variable), function(target)
                    if target then
                        local identifier = GetPlayerIdentifiers(tonumber(variable))[1]
                        MySQL.Async.execute('UPDATE srp_businesses SET owner = @owner, last_modified = @last_modified, modified_by = @admin WHERE id = @id', {['@owner'] = identifier, ['@id'] = id, ['@last_modified'] = os.date('%Y-%m-%dT%H:%M:%S'), ['@admin'] = GetPlayerName(source)})
                        TriggerClientEvent('srp_notify:businessesInfo', source, { type = 'inform', text = 'Nowym właścicielm Biznesu o ID: '..id..' został gracz o ID: '..variable })
                        Citizen.Wait(50)
                        LoadBusinesses()
                        Citizen.Wait(2)
                        ReloadBusinesses()
                    else 
                        TriggerClientEvent('srp_notify:businessesInfo', source, { type = 'error', text = 'Błąd! Nie znaleziono gracza o ID: '..variable })
                    end
                end)
            elseif type == 'price' then
                if tonumber(variable) < 25000 then
                    TriggerClientEvent('srp_notify:businessesInfo', source, { type = 'error', text = 'Błąd! Cena nie może być niższa niż 25000$' })
                else
                    MySQL.Async.execute('UPDATE srp_businesses SET price = @price, last_modified = @last_modified, modified_by = @admin WHERE id = @id', {['@price'] = variable, ['@id'] = id, ['@last_modified'] = os.date('%Y-%m-%dT%H:%M:%S'), ['@admin'] = GetPlayerName(source)})
                    TriggerClientEvent('srp_notify:businessesInfo', source, { type = 'inform', text = 'Cena Biznesu o ID: '..id.." została zmieniona. Nowa cena: "..variable..'$' })
                    Citizen.Wait(50)
                    LoadBusinesses()
                    Citizen.Wait(2)
                    ReloadBusinesses()
                end
            elseif type == 'interior' then
                if tonumber(variable) < 1 or tonumber(variable) > 30 then
                    TriggerClientEvent('srp_notify:businessesInfo', source, { type = 'error', text = 'Błąd! Poprawne wartości to (0/30)' })
                else
                    local result = MySQL.Async.fetchAll('SELECT * FROM srp_businesses WHERE interior=@interior', {['@interior'] = variable}, function(intererror)
                        if intererror[1] then
                            if intererror[1].interior == variable then
                                TriggerClientEvent('srp_notify:businessesInfo', source, { type = 'error', text = 'Błąd! Biznes o ID: '..intererror[1].id..' ma przypisany interior o ID: '..variable})
                            end
                        else
                            MySQL.Async.execute('UPDATE srp_businesses SET interior = @interior, last_modified = @last_modified, modified_by = @admin WHERE id = @id', {['@interior'] = variable, ['@id'] = id, ['@last_modified'] = os.date('%Y-%m-%dT%H:%M:%S'), ['@admin'] = GetPlayerName(source)})
                            TriggerClientEvent('srp_notify:businessesInfo', source, { type = 'inform', text = 'Interior dla Biznesu o ID: '..id.." został zmieniony na ID: "..variable })
                            Citizen.Wait(50)
                            LoadBusinesses()
                            Citizen.Wait(2)
                            ReloadBusinesses()
                        end
                    end)
                end
            elseif type == 'doors' then
                if tonumber(variable) == 0 or tonumber(variable) == 1 then
                    if tonumber(variable) == 0 then
                        doortxt = "otwarte"
                    elseif tonumber(variable) == 1 then
                        doortxt = "zamknięte"
                    end
                    MySQL.Async.execute('UPDATE srp_businesses SET doors = @door, last_modified = @last_modified, modified_by = @admin WHERE id = @id', {['@door'] = variable, ['@id'] = id, ['@last_modified'] = os.date('%Y-%m-%dT%H:%M:%S'), ['@admin'] = GetPlayerName(source)})
                    TriggerClientEvent('srp_notify:businessesInfo', source, { type = 'inform', text = 'Drzwi dla Biznesu o ID: '..id..' Zostały '..doortxt })
                    Citizen.Wait(50)
                    LoadBusinesses()
                    Citizen.Wait(2)
                    ReloadBusinesses()
                else
                    TriggerClientEvent('srp_notify:businessesInfo', source, { type = 'error', text = 'Błąd! Poprawne wartości to (0 - Otwarte / 1 - Zamknięte)' })
                end
            elseif type == 'state' then
                if tonumber(variable) == 0 or tonumber(variable) == 1 or tonumber(variable) == 2 then
                    if tonumber(variable) == 0 then
                        statetxt = "Na sprzedaż"
                    elseif tonumber(variable) == 1 then
                        statetxt = "Kupione"
                    elseif tonumber(variable) == 2 then
                        statetxt = "Wynajęte"
                    end
                    MySQL.Async.execute('UPDATE srp_businesses SET state = @state, last_modified = @last_modified WHERE id = @id', {['@state'] = variable, ['@id'] = id, ['@last_modified'] = os.date('%Y-%m-%dT%H:%M:%S')})
                    TriggerClientEvent('srp_notify:businessesInfo', source, { type = 'inform', text = 'Status Biznesu o ID: '..id..' został na: '..statetxt })
                    Citizen.Wait(50)
                    LoadBusinesses()
                    Citizen.Wait(2)
                    ReloadBusinesses()
                else
                    TriggerClientEvent('srp_notify:businessesInfo', source, { type = 'error', text = 'Błąd! Poprawne wartości to (0 - Na sprzedaż / 1 - Kupiony / 2 - Wynajęty)' })
                end
            end
        else
            TriggerClientEvent('srp_notify:businessesInfo', source, { type = 'error', text = 'Błąd! Któraś z wartości nie została podana! Sprawdź komendę raz jeszcze.' })
        end
    else
        TriggerClientEvent('srp_notify:businessesInfo', source, { type = 'error', text = 'Błąd! Poprawne użycie komendy to: /bizedit (id) (name/owner/price/interior/doors/state) (wartość)' })
    end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1StrefaRP.pl', '^0Nie masz uprawnień by to wykonać!' } })
end, {help = "Edytuje biznes", params = {{name = "id", help = "ID biznesu"}, {name = "typ", help = "Aktualne typy: name, owner, price, interior, doors, state"}, {name = "wartość", help = "Wartości są różne w zależności od typu. Np: W 'nazwie' podajemy literki + cyfry, w 'owner' podajemy ID gracza a w 'price' itd podajemy cyfry. Jeżeli nie wiesz czy podałeś właściwą spróbuj a dostaniesz informacje zwrotną o błędzie :D"}}})

---- Komenda odpowiedzialna za usuwanie biznesu
TriggerEvent('es:addGroupCommand', 'bizdelete', '_dev', function(source, args, user)
    if args[1] then
        local id = tonumber(args[1])
        local result = MySQL.Async.fetchAll('SELECT * FROM srp_businesses WHERE id=@id', {['@id'] = id}, function(idd)
            if idd[1] then
                if idd[1].id == id then
                    MySQL.Async.execute('DELETE FROM srp_businesses WHERE id=@id', {['@id'] = id})
                    TriggerClientEvent('srp_notify:businessesInfo', source, { type = 'inform', text = 'Biznes o ID: '..id..' został usunięty!' })
                    Citizen.Wait(500)
                    LoadBusinesses()
                    Citizen.Wait(500)
                    ReloadBusinesses()
                end
            else
                TriggerClientEvent('srp_notify:businessesInfo', source, { type = 'error', text = 'Błąd! Biznes o ID: '..id..' nie istnieje!' })
            end
        end)
    else
        TriggerClientEvent('srp_notify:businessesInfo', source, { type = 'error', text = 'Błąd! Poprawne użycie komendy to: /bizdelete (id)' })
    end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', '^0Nie masz uprawnień by to wykonać!' } })
end, {help = "Usuwa biznes", params = {{name = "id", help = "ID biznesu",}}})

---- Komenda odpowiedzialna za dodatkowe informacje biznesu
TriggerEvent('es:addGroupCommand', 'bizinfo', '_dev', function(source, args, user)
    isAdmin = not isAdmin
    TriggerClientEvent("srp_businesses:isAdmin", source, isAdmin)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', '^0Nie masz uprawnień by to wykonać!' } })
end, {help = "Dodatkowe informacje na temat biznesu"})

---- Komenda restartujaca wszystkie biznesy z poziomu serwera
TriggerEvent('es:addGroupCommand', 'bizreload', '_dev', function(source, args, user)
    LoadBusinesses()
    Citizen.Wait(300)
    ReloadBusinesses()
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', '^0Nie masz uprawnień by to wykonać!' } })
end, {help = "Dodatkowe informacje na temat biznesu"})

---- Komenda odpowiedzialna za ustawienie szafki w wybranym miejscu przez gracza
TriggerEvent('es:addCommand', 'bizsetlocker', function(source, args, user)
    local identifier = GetPlayerIdentifiers(source)[1]
    if UseCMD == "true" then
        MySQL.Async.fetchAll('SELECT * FROM srp_businesses WHERE id = @id', {['@id'] = LBizId}, function(ownerCheck)
            if ownerCheck[1].owner == identifier then
                MySQL.Async.execute('UPDATE srp_businesses SET locker_zone = @locercoords WHERE id = @id', {['@id'] = LBizId, ['@locercoords'] = '{"x":'..LockerCoords.x..', "y":'..LockerCoords.y..', "z":'..LockerCoords.z..'}'})
                TriggerClientEvent('srp_notify:businessesInfo', source, { type = 'inform', text = 'Ustawiłeś nową pozycje szafki dla swojego biznesu!' })
                Citizen.Wait(50)
                LoadBusinesses()
                Citizen.Wait(50)
                ReloadBusinesses()
            else
                TriggerClientEvent('srp_notify:businessesInfo', source, { type = 'error', text = 'Błąd! Nie jesteś właścicielem tego biznesu!' })
            end
        end)
    elseif UseCMD == "false" then
        TriggerClientEvent('srp_notify:businessesInfo', source, { type = 'error', text = 'Błąd! Szafke możesz ustawić tylko w swoim biznesie!' })
    end
end, {help = "Ustaw szafke dla swojego biznesu"})

---- Komenda odpowiedzialna za kupywanie biznesu przez gracza
TriggerEvent('es:addCommand', 'buybiz', function(source, args, user)
    local identifier = GetPlayerIdentifiers(source)[1]
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent("srp_bussinesses:GetLastBizID", source)
    Citizen.Wait(500)
    if BuyLastBizID ~= nil then
        MySQL.Async.fetchAll('SELECT * FROM srp_businesses WHERE id = @id', {['@id'] = BuyLastBizID}, function(BuyCheck)
            if BuyCheck[1].state == 0 then
                if tonumber(xPlayer.getBank()) >= tonumber(BuyCheck[1].price)  then
                    MySQL.Async.execute('UPDATE srp_businesses SET owner = @owner, state = @state WHERE id = @id', {
                        ['@id'] = BuyLastBizID,
                        ['@owner'] = identifier, 
                        ['@state'] = 1
                    })
                    xPlayer.removeBank(tonumber(BuyCheck[1].price))
                    TriggerClientEvent('srp_notify:businessesInfo', source, { type = 'inform', text = 'Kupiłeś biznes za '..tonumber(BuyCheck[1].price)..'$' })
                    Citizen.Wait(50)
                    LoadBusinesses()
                    Citizen.Wait(50)
                    ReloadBusinesses()
                else
                    TriggerClientEvent('srp_notify:businessesInfo', source, { type = 'error', text = 'Nie masz wymaganej kwoty na swoim koncie bankowym!' })
                end
            else
                TriggerClientEvent('srp_notify:businessesInfo', source, { type = 'error', text = 'Ten biznes jest już zajęty!' })
            end
        end)
    end
end, {help = "Kup biznes"})
--------------------- Funkcje
---- Funkcja odpowiedzialna za ładowanie wszystkich biznesów
function LoadBusinesses()
    Citizen.Wait(500)
    MySQL.Async.fetchAll('SELECT * FROM srp_businesses', {}, function(businesses)
        Biz = {}
        for i=1, #businesses, 1 do
            local lockers  = nil
            if businesses[i].locker_zone ~= nil then
                lockers = json.decode(businesses[i].locker_zone)
            end
            
            table.insert(Biz, {
                id = businesses[i].id,
                name = businesses[i].name,
                owner = businesses[i].owner,
                price = businesses[i].price,
                x = businesses[i].x,
                y = businesses[i].y,
                z = businesses[i].z,
                interior = businesses[i].interior,
                owner_zone = businesses[i].owner_zone,
                locker_zone = lockers,
                garage_zone = businesses[i].garage_zone,
                doors = businesses[i].doors,
                state = businesses[i].state,
                creation_date = os.date('%Y-%m-%d %H:%M:%S', tonumber(businesses[i].creation_date)/1000),
                last_modified = os.date('%Y-%m-%d %H:%M:%S', tonumber(businesses[i].last_modified)/1000),
                modified_by = businesses[i].modified_by
            })
        end
    end)
end

---- Funkcja odpowiedzialna za przeładowanie wszystkich biznesów
function ReloadBusinesses()
    Citizen.Wait(500)
    for i=1, #Biz, 1 do
        TriggerClientEvent("srp_businesses:LoadBusinesses", -1, Biz)
    end
end

---- Pobiranie pozycji
RegisterServerEvent("srp_businesses:sendPos")
AddEventHandler("srp_businesses:sendPos", function(pos)
    ppos = pos
end)

---- Wczytywanie biznesów przy wejsciu gracza na serwer
AddEventHandler('es:playerLoaded', function(source)
    for i=1, #Biz, 1 do
        TriggerClientEvent("srp_businesses:LoadBusinesses", source, Biz)
    end 
end)

---- Pobiranie hexa gracza.
RegisterServerEvent("srp_businesses:GetPlayerIdentifier")
AddEventHandler("srp_businesses:GetPlayerIdentifier", function(source)
    local id = GetPlayerIdentifiers(source)[1]
    TriggerClientEvent("srp_businesses:SendPlayerIdentifier", source, id)
end)

--- Pobieranie ID Biznesu w ktorym stoi gracz.
RegisterServerEvent("srp_businesses:SendLastBizID")
AddEventHandler("srp_businesses:SendLastBizID", function(LastBID)
    BuyLastBizID = LastBID
end)

----
RegisterServerEvent("srp_businesses:SetLocker")
AddEventHandler("srp_businesses:SetLocker", function(coords, canusecommand, lastbizid, lastbizowner)
    UseCMD = tostring(canusecommand)
    LockerCoords = coords
    LBizId = lastbizid
    LBizOwner = lastbizowner
end)
---- Aktualizowanie stanu drzwi dla Biznesu o podanym ID. 
RegisterServerEvent("srp_businesses:SetBusinessesDoors")
AddEventHandler("srp_businesses:SetBusinessesDoors", function(bid, doorsstate)
    if doorsstate == 1 then
        doorsstatetxt = 1
    elseif doorsstate == 0 then
        doorsstatetxt = 0 
    end
    MySQL.Async.execute('UPDATE srp_businesses SET doors = @door WHERE id = @id', {['@door'] = doorsstatetxt, ['@id'] = bid})
    Citizen.Wait(50)
    LoadBusinesses()
    Citizen.Wait(50)
    ReloadBusinesses()
end)