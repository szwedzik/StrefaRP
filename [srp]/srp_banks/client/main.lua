--[[
Name: srp_banks
Author: Ezi - Ezi#0001 & Smerfik - Smerfik#0069
Version: v0.01.3612
Date: 22/06/2019 - 13:32
]]--

----------- Zdefiniowane klawisze
Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

----------- Globalne zmienne
ESX = nil
local robberyOngoing = false
local MinPolice = 5
local keycard = false
local Cash = 10
local pieniadze = 0
local pieniadze2 = 1
local pieniadze3 = 2
local coldown = 0
local cooldownnotyfication = false
local alarmon = false
local nofp = false
local nocashleft = false
local modelcard = "prop_cs_credit_card"
local cardspawned = nil
local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))


Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) 
            ESX = obj
        end)

        Citizen.Wait(1)
    end

    if ESX.IsPlayerLoaded() then
        ESX.PlayerData = ESX.GetPlayerData()
    end
end) 

----------- Funkcja odpowiedzialna za pobieranie pracy gracza
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

----------- Funkcja odpowiedzialna za cooldown
RegisterNetEvent("set:cooldown")
AddEventHandler("set:cooldown", function(coldown1)
coldown = coldown1
end)

----------- Funkcja odpowiedzialna za pobieranie hajsu z SQL'a
RegisterNetEvent('setbank:moneyreward')
AddEventHandler('setbank:moneyreward', function(mon, mon2, mon3)
    if robberyOngoing == false then
        pieniadze = mon
        pieniadze2 = mon2
        pieniadze3 = mon3
    end
end)

----------- Glowny Config bankow
BankHeists = {
    ["Fleeca_Bank_Highway"] = {

        ["Money"] = pieniadze,

        ["Bank_Vault"] = {
            ["model"] = -63539571,
            ["x"] = -2958.539,
            ["y"] = 482.2706,
            ["z"] = 15.835,
            ["hStart"] = 0.0,
            ["hEnd"] = -79.5
        },

        ["Start_Robbing"] = { 
            ["x"] = -2956.5705566406, 
            ["y"] = 481.70111083984, 
            ["z"] = 15.697088241577, 
            ["h"] = 357.9729309082 
        },

        ["Cash_Pile"] = { 
            ["x"] = -2954.1071777344, 
            ["y"] = 484.38818359375, 
            ["z"] = 16.267852783203, 
            ["h"] = 86.886528015137 
        }

    },

    ["Fleeca_Bank_Center"] = {

        ["Money"] = pieniadze2,

        ["Bank_Vault"] = {
            ["model"] = 2121050683,
            ["x"] = 148.025,
            ["y"] = -1044.364,
            ["z"] = 29.50693,
            ["hStart"] = 249.846,
            ["hEnd"] = -183.599
        },

        ["Start_Robbing"] = { 
            ["x"] = 146.86993408203, 
            ["y"] = -1046.0607910156, 
            ["z"] = 29.368083953857, 
            ["h"] = 218.72334289551
        },

        ["Cash_Pile"] = { ["x"] = 148.67572021484, ["y"] = -1049.197265625, ["z"] = 29.93883895874, ["h"] = 160.95620727539 }


    },

    ["Fleeca_Bank_Top"] = {

        ["Money"] = pieniadze3,

        ["Bank_Vault"] = {
            ["model"] = 2121050683,
            ["x"] = -352.725,
            ["y"] = -53.564,
            ["z"] = 49.50693,
            ["hStart"] = 249.846,
            ["hEnd"] = -183.599
        },

        ["Start_Robbing"] = { 
            ["x"] = -353.85614013672, 
            ["y"] = -55.297225952148, 
            ["z"] = 49.036598205566, 
            ["h"] = 222.63375854492
        },

        ["Cash_Pile"] = { ["x"] = -352.00219726563, ["y"] = -58.390628814697, ["z"] = 49.60733795166, ["h"] = 160.58137512207 }

    },
}

----------- Funkcja odpowiedzialna za Blip dla LSPD
RegisterNetEvent("esx_bankrobbery:alertCops")
AddEventHandler("esx_bankrobbery:alertCops", function(bankId)
    local coords = BankHeists[bankId]["Start_Robbing"]
    blip = AddBlipForCoord(coords["x"], coords["y"], coords["z"])
    SetBlipSprite(blip, 161)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip, 75)
    BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Napad w toku: ")
    EndTextCommandSetBlipName(blip)
    Citizen.Wait(3 * 60 * 1000)
    RemoveBlip(blip)
end)

----------- Sprawdzanie czy gracz posiada Keycard'a
RegisterNetEvent("srp_banks:HasKeycard")
AddEventHandler("srp_banks:HasKeycard", function(count)
    if count > 0 then
        keycard = true
    elseif count == 0 then
        keycard = false 
    end
end)

----------- Funkcja odpowiedzialna za wszystkie banki
Citizen.CreateThread(function()
    ResetDoors()
    while true do
        Citizen.Wait(5)
        local ped = PlayerPedId()
        local pedCoords2 = GetEntityCoords(ped)
        local abank1 = vector3(146.96, -1046.11, 29.80)
        local abank2 = vector3(-353.85, -55.29, 49.03)
        local abank3 = vector3(-2956.57, 481.70, 15.69)
        local acbank1 = GetDistanceBetweenCoords(pedCoords2, abank1["x"], abank1["y"], abank1["z"], true)
        local acbank2 = GetDistanceBetweenCoords(pedCoords2, abank2["x"], abank2["y"], abank2["z"], true)
        local acbank3 = GetDistanceBetweenCoords(pedCoords2, abank3["x"], abank3["y"], abank3["z"], true)
            if acbank1 <= 1.5 or acbank2 <= 1.5 or acbank3 <= 1.5 then
                if not robberyOngoing then
                for bank, values in pairs(BankHeists) do
                    local StartPosition = values["Start_Robbing"]
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    local pedCoords = GetEntityCoords(ped)
                    local distanceCheck = GetDistanceBetweenCoords(pedCoords, StartPosition["x"], StartPosition["y"], StartPosition["z"], true)
                    local timer = math.random(75000, 240000)
                    local timerfaliure = math.random(45000, 180000)
                    local cardtimer = math.random(30000, 120000)
                    local cardfaliure = math.random(35000, 95000)
                    local chance = math.random(0,100)
                    if distanceCheck <= 1.5 then
                        if keycard == true then
                            DrawText3D(StartPosition["x"], StartPosition["y"], StartPosition["z"], "~g~[E]~w~ Aby włamać się do sejfu ~g~[H]~w~ Aby użyć karty magnetycznej")
                        end
                        if keycard == false then
                            DrawText3D(StartPosition["x"], StartPosition["y"], StartPosition["z"], "~g~[E]~w~ Aby włamać się do sejfu")  
                        end
                        if distanceCheck <= 1.5 then
                            TriggerServerEvent("srp_banks:HasKeycard")
                                if IsControlJustPressed(0, Keys["E"]) then
                                    print("Wcisnieto E")
                                    --if closestPlayer ~= -1 and closestDistance > 1.8 then
                                    TriggerServerEvent('esx_bankrobbery:checkcooldown', bank)
                                    Citizen.Wait(500)
                                    if coldown == "0" then
                                        ESX.TriggerServerCallback("esx_bankrobbery:fetchCops", function(IsEnough)
                                            if IsEnough then
                                                if chance <= 25 then
                                                    TriggerServerEvent('set:coldown45', bank)
                                                    --TaskPlayAnim(PlayerPedId(), "mini@safe_cracking", "idle_base", 8.0, -8.0, -1, 1, 0, false, false, false)
                                                    --exports['progressBars']:startUI(timer, "Otwieranie sejfu...")
                                                    exports['mythic_progbar']:Progress({
                                                        name = "banks_door",
                                                        duration = timer,
                                                        label = "Otwieranie sejfu...",
                                                        useWhileDead = false,
                                                        canCancel = true,
                                                        controlDisables = {
                                                            disableMovement = true,
                                                            disableCarMovement = false,
                                                            disableMouse = false,
                                                            disableCombat = true,
                                                        },
                                                        animation = {
                                                            animDict = "mini@safe_cracking",
                                                            anim = "idle_base",
                                                            flags = 49,
                                                        },
                                                    })
                                                    Citizen.Wait(timer)
                                                    ClearPedTasks(ped)
                                                    TriggerServerEvent("esx_bankrobbery:BankAlarm", bank)
                                                    TriggerServerEvent("srp_banks:alert", bank)
                                                    TriggerServerEvent("esx_bankrobbery:startRobbery", bank)
                                                    alarmon = true
                                                    Citizen.Wait(4500)
                                                    alarmon = false
                                                else
                                                    --TaskPlayAnim(ped, "mini@safe_cracking", "idle_base", 8.0, -8.0, -1, 1, 0, false, false, false)
                                                    --exports['progressBars']:startUI(timerfaliure, "Otwieranie sejfu...")
                                                    exports['mythic_progbar']:Progress({
                                                        name = "banks_door",
                                                        duration = timerfaliure,
                                                        label = "Otwieranie sejfu...",
                                                        useWhileDead = false,
                                                        canCancel = true,
                                                        controlDisables = {
                                                            disableMovement = true,
                                                            disableCarMovement = false,
                                                            disableMouse = false,
                                                            disableCombat = true,
                                                        },
                                                        animation = {
                                                            animDict = "mini@safe_cracking",
                                                            anim = "idle_base",
                                                            flags = 49,
                                                        },
                                                    })
                                                    Citizen.Wait(timerfaliure)
                                                    ClearPedTasks(ped)
                                                    TriggerServerEvent("esx_bankrobbery:BankAlarm", bank)
                                                    TriggerServerEvent("srp_banks:alert", bank)
                                                end
                                            else
                                                nofp = true
                                                Citizen.Wait(4500)
                                                nofp = false
                                            end
                                        end, MinPolice)
                                    else
                                        cooldownnotyfication = true
                                        Citizen.Wait(4500)
                                        cooldownnotyfication = false
                                    end
                                --end
                            end
                            if IsControlJustPressed(0, Keys["H"]) and keycard == true then
                                --if closestPlayer ~= -1 and closestDistance > 1.8 then
                                    TriggerServerEvent('esx_bankrobbery:checkcooldown', bank)
                                    Citizen.Wait(500)
                                    if coldown == "0" then
                                        ESX.TriggerServerCallback("esx_bankrobbery:fetchCops", function(IsEnough)
                                            if IsEnough then
                                                if chance < 99 then
                                                    --TriggerServerEvent('set:coldown45', bank)
                                                    --TaskPlayAnim(PlayerPedId(), "mini@safe_cracking", "idle_base", 8.0, -8.0, -1, 1, 0, false, false, false)
                                                    --local lib, anim = 'anim@heists@keycard@', 'idle_a'
                                                    --ESX.Streaming.RequestAnimDict(lib, function()
                                                    --    TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
                                                    --end)
                                                    --cardspawned = CreateObject(GetHashKey(modelcard), x, y, z+0.2,  true,  true, true)
                                                    --AttachEntityToEntity(bagspawned, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.025, 0.38, 0.355, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
                                                    exports['mythic_progbar']:Progress({
                                                        name = "banks_door",
                                                        duration = cardtimer,
                                                        label = "Otwieranie sejfu kartą magnetyczną...",
                                                        useWhileDead = false,
                                                        canCancel = true,
                                                        controlDisables = {
                                                            disableMovement = true,
                                                            disableCarMovement = false,
                                                            disableMouse = false,
                                                            disableCombat = true,
                                                        },
                                                        animation = {
                                                            animDict = "mini@safe_cracking",
                                                            anim = "idle_base",
                                                            flags = 49,
                                                        },
                                                    })
                                                    Citizen.Wait(cardtimer)
                                                    TriggerServerEvent('srp_banks:RemoveKeyCard')
                                                    --FreezeEntityPosition(ped, false)
                                                    --DeleteObject(cardspawned)
                                                    ClearPedTasks(ped)
                                                    TriggerServerEvent("esx_bankrobbery:startRobbery", bank)
                                                    TriggerServerEvent("esx_bankrobbery:BankAlarm", bank)
                                                    TriggerServerEvent("srp_banks:alert", bank)
                                                    alarmon = true
                                                    Citizen.Wait(4500)
                                                    alarmon = false
                                                elseif chance >= 99  then
                                                    --TriggerServerEvent('set:coldown45', bank)
                                                    --TaskPlayAnim(ped, "mini@safe_cracking", "idle_base", 8.0, -8.0, -1, 1, 0, false, false, false)
                                                    --local lib, anim = 'anim@heists@keycard@', 'idle_a'
                                                    --ESX.Streaming.RequestAnimDict(lib, function()
                                                    --    TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
                                                    --end)
                                                    --cardspawned = CreateObject(GetHashKey(modelcard), x, y, z+0.2,  true,  true, true)
                                                    --AttachEntityToEntity(bagspawned, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.025, 0.38, 0.355, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
                                                    exports['mythic_progbar']:Progress({
                                                        name = "banks_door",
                                                        duration = 5000,
                                                        label = "Otwieranie sejfu kartą magnetyczną...",
                                                        useWhileDead = false,
                                                        canCancel = true,
                                                        controlDisables = {
                                                            disableMovement = true,
                                                            disableCarMovement = false,
                                                            disableMouse = false,
                                                            disableCombat = true,
                                                        },
                                                        animation = {
                                                            animDict = "mini@safe_cracking",
                                                            anim = "idle_base",
                                                            flags = 49,
                                                        },
                                                    })
                                                    Citizen.Wait(5000)
                                                -- FreezeEntityPosition(ped, false)
                                                    --DeleteObject(cardspawned)
                                                    ClearPedTasks(ped)
                                                    TriggerServerEvent("esx_bankrobbery:startRobbery", bank)
                                                end 
                                            else
                                                nofp = true
                                                Citizen.Wait(4500)
                                                nofp = false
                                            end
                                        end, MinPolice)
                                    else
                                        cooldownnotyfication = true
                                        Citizen.Wait(4500)
                                        cooldownnotyfication = false
                                    end
                                --end
                            end
                        end
                    end
                end
            end
        end
    end
end)

----------- Reset napadu jezeli gracz wyjdzie z banku
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local pedCoords2 = GetEntityCoords(PlayerPedId())
        local bank1 = vector3(146.96, -1046.11, 29.80)
        local bank2 = vector3(-353.85, -55.29, 49.03)
        local bank3 = vector3(-2956.57, 481.70, 15.69)
        local cbank1 = GetDistanceBetweenCoords(pedCoords2, bank1["x"], bank1["y"], bank1["z"], true)
        local cbank2 = GetDistanceBetweenCoords(pedCoords2, bank2["x"], bank2["y"], bank2["z"], true)
        local cbank3 = GetDistanceBetweenCoords(pedCoords2, bank3["x"], bank3["y"], bank3["z"], true)

        if robberyOngoing == true then
            if cbank1 >= 20 and cbank1 < 100 then
                robberyOngoing = false
                ResetDoors()
                TriggerServerEvent("srp_banks:setcash0", "Fleeca_Bank_Center", Cash)
            end
            if cbank2 >= 20 and cbank2 < 100 then
                robberyOngoing = false
                ResetDoors()
                TriggerServerEvent("srp_banks:setcash0", "Fleeca_Bank_Top", Cash)
            end
            if cbank3 >=20 and cbank3 <100 then
                robberyOngoing = false
                ResetDoors()
                TriggerServerEvent("srp_banks:setcash0", "Fleeca_Bank_Highway", Cash)
            end
        end
    end
end)

----------- Powiadomienie o Cooldownie
Citizen.CreateThread(function()
    while true do
        local pedCoords3 = GetEntityCoords(PlayerPedId())
        local bank1 = vector3(146.96, -1046.11, 29.80)
        local bank2 = vector3(-2956.57, 481.70, 15.69)
        local bank3 = vector3(-353.85, -55.29, 49.03)
        Citizen.Wait(5)
        if cooldownnotyfication == true then
            if tonumber(coldown) <= 120000 then  
                if GetDistanceBetweenCoords(pedCoords3, bank1, false) <= 5 then
                    DrawText3D(146.96, -1046.11, 29.80, "~w~Przed kolejnym napadem musisz odczekać ~r~"  .. math.floor(coldown / 1000) .. " ~w~sekund!")
                end
                if GetDistanceBetweenCoords(pedCoords3, bank2, false) <= 5 then
                    DrawText3D(-2956.57, 481.71, 16.13, "~w~Przed kolejnym napadem musisz odczekać ~r~"  .. math.floor(coldown / 1000) .. " ~w~sekund!")
                end
                if GetDistanceBetweenCoords(pedCoords3, bank3, false) <= 5 then
                    DrawText3D(-353.85, -55.29, 49.53, "~w~Przed kolejnym napadem musisz odczekać ~r~"  .. math.floor(coldown / 1000) .. " ~w~sekund!")
                end

            else
                if GetDistanceBetweenCoords(pedCoords3, bank1, false) <= 5 then
                    DrawText3D(146.96, -1046.11, 29.80, "~w~Przed kolejnym napadem musisz odczekać ~r~"  .. math.floor(coldown / 1000 / 60) .. " ~w~minut/y!")
                end
                if GetDistanceBetweenCoords(pedCoords3, bank2, false) <= 5 then
                    DrawText3D(-2956.57, 481.71, 16.13, "~w~Przed kolejnym napadem musisz odczekać ~r~"  .. math.floor(coldown / 1000 / 60) .. " ~w~minut/y!")
                end
                if GetDistanceBetweenCoords(pedCoords3, bank3, false) <= 5 then
                    DrawText3D(-353.85, -55.29, 49.53, "~w~Przed kolejnym napadem musisz odczekać ~r~"  .. math.floor(coldown / 1000 / 60) .. " ~w~minut/y!")
                end
            end
        end
        if alarmon == true then
            if GetDistanceBetweenCoords(pedCoords3, bank1, false) <= 5 then
                DrawText3D(146.96, -1046.11, 29.80, "~w~Cichy alarm został ~r~Aktywowany~w~!")
            end
            if GetDistanceBetweenCoords(pedCoords3, bank2, false) <= 5 then
                DrawText3D(-2956.57, 481.71, 16.13, "~w~Cichy alarm został ~r~Aktywowany~w~!")
            end
            if GetDistanceBetweenCoords(pedCoords3, bank3, false) <= 5 then
                DrawText3D(-2956.57, 481.71, 49.53, "~w~Cichy alarm został ~r~Aktywowany~w~!")
            end
        end
        if nofp == true then
            if GetDistanceBetweenCoords(pedCoords3, bank1, false) <= 5 then
                DrawText3D(146.96, -1046.11, 29.80, "~w~Brak wymaganych funkcjonarjuszy na wyspie! Potrzeba minimum ~r~" .. MinPolice .." ~w~dostępnych!")
            end
            if GetDistanceBetweenCoords(pedCoords3, bank2, false) <= 5 then
                DrawText3D(-2956.57, 481.71, 16.13, "~w~Brak wymaganych funkcjonarjuszy na wyspie! Potrzeba minimum ~r~" .. MinPolice .." ~w~dostępnych!")
            end
            if GetDistanceBetweenCoords(pedCoords3, bank3, false) <= 5 then
                DrawText3D(-2956.57, 481.71, 49.53, "~w~Brak wymaganych funkcjonarjuszy na wyspie! Potrzeba minimum ~r~" .. MinPolice .." ~w~dostępnych!")
            end
        end
        if nocashleft == true then
            --DrawText3D(148.62, -1049.11, 29.80, "~w~Nic już nie zostało! Uciekaj!")
            --DrawText3D(148.62, -1049.11, 29.80, "~w~Nic już nie zostało! Uciekaj!")
        end
    end
end)

----------- Funkcja odpowiedzialna za text 3d powiadomienia itp
function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 90)
end

----------- Funkcja odpowiedzialna za rozpoczecie
RegisterNetEvent("esx_bankrobbery:startRobbery")
AddEventHandler("esx_bankrobbery:startRobbery", function(bankId)
    StartRobbery(bankId)
end)

----------- Funkcja odpowiedzialna za zakoczonenie napadu
RegisterNetEvent("esx_bankrobbery:endRobbery")
AddEventHandler("esx_bankrobbery:endRobbery", function(bankId)
    robberyOngoing = false
end)

RegisterNetEvent("esx_bankrobbery:changeCash")
AddEventHandler("esx_bankrobbery:changeCash", function(bankId, newCash)
    if newCash <= 0 then
        BankHeists[bankId]["Money"] = 0
    end

    BankHeists[bankId]["Money"] = newCash
end)

----------- Funkcja odpowiedzialna rozpoczecie napadu
function StartRobbery(bankId)
    robberyOngoing = true
    local CashPosition = BankHeists[bankId]["Cash_Pile"]
    loadModel("bkr_prop_bkr_cashpile_04")
    loadAnimDict("anim@heists@ornate_bank@grab_cash_heels")
    local CashPile = CreateObject(GetHashKey("bkr_prop_bkr_cashpile_04"), CashPosition["x"], CashPosition["y"], CashPosition["z"], false)
    PlaceObjectOnGroundProperly(CashPile)
    SetEntityRotation(CashPile, 0, 0, CashPosition["h"], 2)
    FreezeEntityPosition(CashPile, true)
    SetEntityAsMissionEntity(CashPile, true, true)
    Citizen.CreateThread(function()
        while robberyOngoing do
            Citizen.Wait(5)
            if BankHeists[bankId]["Money"] == 0 then
               Cash = pieniadze
            end
            if BankHeists[bankId]["Money"] == 1 then
              Cash = pieniadze2
            end
            if BankHeists[bankId]["Money"] == 2 then
              Cash = pieniadze3
            end 
            local ped = PlayerPedId()
            local pedCoords = GetEntityCoords(ped)
            local distanceCheck = GetDistanceBetweenCoords(pedCoords, CashPosition["x"], CashPosition["y"], CashPosition["z"], false)
            if distanceCheck <= 1.5 then
                DrawText3D(CashPosition["x"], CashPosition["y"], CashPosition["z"], "~g~[E]~w~ Aby pakować hajs do torby (" .. Cash .. " ~g~$~w~)")
                if IsControlJustPressed(0, Keys["E"]) then
                    if Cash > 0 then
                        GrabCash(bankId)
                    else
                        DeleteEntity(CashPile)
                        BankHeists[bankId]["Money"] = 0
                        nocashleft = true
                        Citizen.Wait(4500)
                        nocashleft = false
                        TriggerServerEvent("esx_bankrobbery:endRobbery", bankId)
                    end
                end
            end
            if distanceCheck >= 15 then
                ResetDoors()
            end
            if IsControlJustPressed(0, Keys["X"]) then
                DeleteEntity(CashPile)
            end
        end
    end)
end

----------- Funkcja odpowiedzialna za zbieranie hajsu
function GrabCash(bankId)
    TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 8.0, -8.0, -1, 1, 0, false, false, false)
    local PedCoords = GetEntityCoords(GetPlayerPed(-1))
    torba = CreateObject(GetHashKey('prop_cs_heist_bag_02'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
    AttachEntityToEntity(torba, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.0, 0.0, -0.16, 250.0, -30.0, 0.0, false, false, false, false, 2, true)
    TriggerEvent('skinchanger:getSkin', function(skin) local clothesSkin = { ['bags_1'] = 0, ['bags_2'] = 0 } TriggerEvent('skinchanger:loadClothes', skin, clothesSkin) end)
    Citizen.Wait(7500)
    DeleteEntity(torba)
    TriggerEvent('skinchanger:getSkin', function(skin) local clothesSkin = { ['bags_1'] = 40, ['bags_2'] = 0 } TriggerEvent('skinchanger:loadClothes', skin, clothesSkin) end)
    ClearPedTasks(PlayerPedId())
    local cashRecieved = math.random(2150, 5250)
    TriggerServerEvent("esx_bankrobbery:grabbedCash", bankId, Cash, cashRecieved)
end
----------- Funkcja odpowiedzialna za zmiane wyswietlajacej sie kwoty
RegisterNetEvent("esx_bankrobbery:changeCash")
AddEventHandler("esx_bankrobbery:changeCash", function(bankId, newCash)
    if newCash <= 0 then
        Cash = 0
    end
    Cash = newCash
end)

function loadAnimDict(dict)
    Citizen.CreateThread(function()
        while (not HasAnimDictLoaded(dict)) do
            RequestAnimDict(dict)
            Citizen.Wait(1)
        end
    end)
end

function loadModel(model)
    Citizen.CreateThread(function()
        while not HasModelLoaded(model) do
            RequestModel(model)
          Citizen.Wait(1)
        end
    end)
end