local script = [[
-- Zdeklarowane klawisze--
local Keys = {
	["ESC"] = 322, ["BACKSPACE"] = 177, ["E"] = 38, ["X"] = 73, ["H"] = 74,	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173
}
--Globalna zmienna ESX'a--
ESX = nil
local PlayerData = {}
--Wczytywanie ESX'a--
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

--Globalne zmienne--
local DisplayInteractionButton = true
local coords = GetEntityCoords(GetPlayerPed(-1))
--local nodisplay = false
--Kwestie Pedow--
local HasCashInformator = false
local QuestItemInformator = false
local ablepressH = false
local CooldownAblePressEInformator = false
local TextPressEInformator = false
local TextPressEInformator2 = false
local TextPressEInformator3 = false
local TextPressEInformator4 = false
local TextPressEInformator4a = false
local TextPressEInformator5Quest = false
local TextPressEInformatorStart1 = false
local TextPressEInformatorStart2 = false
local TextPressEInformatorStart3 = false
local QuestCheckInformator = false
local TextInformator1Quest = false
local TextInformator2Quest = false
local TextInformatorDrink = false
local TextInformatorDrink2 = false
local QuestInformatorDrink = false
local TextInformatorH1 = false
local TextInformatorH2 = false
local TextInformatorH3 = false
local TextInformatorH4 = false
local TextInformatorH5 = false
local CanBuyGun = false
local test1 = false
local test2 = false
local pyt1 = false
local pyt2 = false
local pyt3 = false
local pyt4 = false
local pyt5 = false
local pyt6 = false
local pyt7 = false
local pyt8 = false
local pyt9 = false
local pyt10 = false
local tekst3 = false
local giveitem = false
local tekst4 = false
local pytPistol1 = false
local pytPistol2 = false
local pytPistol3 = false
local pytPistol4 = false
local pytPistol5 = false
local pytPistol6 = false
local pytPistol7 = false
local pytPistol8 = false
local pytPistol9 = false
local pytPistol10 = false
local tekstPistol3 = false
local tekstPistol4 = false
local testPistol1 = false
local testPistol2 = false
local HasCashInformatorDealer = false
local ablepressH = false
local TextPressEInformatorDealer = false
local TextPressEInformatorDealer2 = false
local TextPressEInformatorDealer3 = false
local TextPressEInformatorDealer4 = false
local TextPressEInformatorDealerStart1 = false
local TextPressEInformatorDealerStart2 = false
local TextPressEInformatorDealerStart3 = false
local TextPressEInformatorDealer5Quest = false
local CooldownAblePressEInformatorDealer = false
local TextInformatorDealerH1 = false
local TextInformatorDealerH2 = false
local TextInformatorDealerH3 = false
local TextInformatorDealerH4 = false
local TextInformatorDealerH5 = false
local test1a = false
local CashSNSPistol = false
local CooldownSNSPistol = false
local CoolDownTestTrueSNSPistol = false
local CoolDownTestFalseSNSPistol = false
local testPistol1a = false
local CooldownPistol = false
local CoolDownTestTruePistol = false
local CoolDownTestFalsePistol = false
local pytCombatPistol1 = false
local pytCombatPistol2 = false
local pytCombatPistol3 = false
local pytCombatPistol4 = false
local pytCombatPistol5 = false
local pytCombatPistol6 = false
local pytCombatPistol7 = false
local pytCombatPistol8 = false
local pytCombatPistol9 = false
local pytCombatPistol10 = false
local CooldownCombatPistol = false
local CoolDownTestFalseCombatPistol = false
local CoolDownTestTrueCombatPistol = false
local testCombatPistol1 = false
local testCombatPistol1a = false
local testCombatPistol2 = false
local odpCombatPistol1 = false
local odpCombatPistol2 = false
local odpCombatPistol3 = false
local odpCombatPistol4 = false
local odpCombatPistol5 = false
local odpCombatPistol6 = false
local odpCombatPistol7 = false
local odpCombatPistol8 = false
local odpCombatPistol9 = false
local odpCombatPistol10 = false
local odpCombatPistol11 = false
local tekstCombatPistol3 = false
local tekstCombatPistol4 = false
local isNearBaron = false
local inveh = IsPedInAnyVehicle(GetPlayerPed(-1), false)
local CashPistol = false
local CashCombatPistol = false
--Odpowiedzi --
local odp1 = false
local odp2 = false
local odp3 = false
local odp4 = false
local odp5 = false
local odp6 = false
local odp7 = false
local odp8 = false
local odp9 = false
local odp10 = false
local odp11 = false
local odpPistol1 = false
local odpPistol2 = false
local odpPistol3 = false
local odpPistol4 = false
local odpPistol5 = false
local odpPistol6 = false
local odpPistol7 = false
local odpPistol8 = false
local odpPistol9 = false
local odpPistol10 = false
local odpPistol11 = false
--Lokalizacja Informatora--
local InformatorBaronGUN1 = vector3(74.82, -61.92, 66.95) -- Informator Baron przy Vinewood Plaza
local InformatorDealerGUN1 = vector3(-558.25, 197.88, 81.70) -- Informator Dealer przy ...
--Lokalizacje Sprzedawców--
local SNSPistol = vector3(-2165.85, 5199.14, 15.88) -- Domek na wyspie przy PaletoBay
local Pistol = vector3(3065.01, 2223.41, 2.18) -- Jaskinia przy HumanLabsie
local ApPistol = vector3(-1928.65, -3177.83, 4.16) -- Za lotniskiem LS
local VintagePistol = vector3(1088.82, -2933.69, 48.13) -- Doki LS - Dzwig przy statku
local CombatPistol = vector3(27.58, -2679.35, 11.04) -- Doki stocznia LS
local HeavyPistol = vector3(-1815.13, 3269.75, 31.82) -- Fort Zancudo
local MarksmanPistol = vector3(338.13, -2720.20, 38.39) -- Gora rafinerii Doki LS
local DesertEagle = vector3(2368.25, 4938.85, 66.36) -- Silos SandyShores


-- Informator o Baronie (bez pytań!) --
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local coords = GetEntityCoords(PlayerPedId())
            if GetDistanceBetweenCoords(coords, InformatorBaronGUN1, true) <= 1.2 then
                nodisplay = true
            if PlayerData.job ~= nil and PlayerData.job.name ~= 'police' and PlayerData.job.name ~= 'statepolice' and PlayerData.job.name ~= 'sheriff' then
                TriggerServerEvent("srp_blackmarket:HasCashInformator")
                TriggerServerEvent("srp_blackmarket:QuestItemInformator")
                -- Nie ma kasy
                if HasCashInformator == false and QuestItemInformator == false and ablepressH == false and QuestInformatorDrink == false then
                    DrawText3D(InformatorBaronGUN1.x, InformatorBaronGUN1.y, InformatorBaronGUN1.z+1.0, "~g~[E] ~w~Aby porozmawiać")
                end
                if HasCashInformator == false and QuestItemInformator == true and ablepressH == true and QuestInformatorDrink == false then
                    DrawText3D(InformatorBaronGUN1.x, InformatorBaronGUN1.y, InformatorBaronGUN1.z+1.0, "~g~[E] ~w~Aby porozmawiać~g~ [H] ~w~Aby wręczyć przedmiot")
                end
                if HasCashInformator == false and QuestItemInformator == true and ablepressH == false and QuestInformatorDrink == false then
                    DrawText3D(InformatorBaronGUN1.x, InformatorBaronGUN1.y, InformatorBaronGUN1.z+1.0, "~g~[E] ~w~Aby porozmawiać~g~ [H] ~w~Aby wręczyć przedmiot")
                end
                
                --Ma Kasę
                if HasCashInformator == true and QuestItemInformator == true and ablepressH == true and QuestInformatorDrink == true and QuestCheckInformator == false then
                    DrawText3D(InformatorBaronGUN1.x, InformatorBaronGUN1.y, InformatorBaronGUN1.z+1.0, "~g~[E] ~w~Aby porozmawiać")
                end
                if HasCashInformator == true and QuestItemInformator == true and ablepressH == false and QuestInformatorDrink == true then
                    DrawText3D(InformatorBaronGUN1.x, InformatorBaronGUN1.y, InformatorBaronGUN1.z+1.0, "~g~[E] ~w~Aby porozmawiać ~g~[H] ~w~Aby wypić po maluchu")
                end
                if HasCashInformator == true and QuestItemInformator == true and ablepressH == false and QuestInformatorDrink == false and QuestCheckInformator == true then
                    DrawText3D(InformatorBaronGUN1.x, InformatorBaronGUN1.y, InformatorBaronGUN1.z+1.0, "~g~[E] ~w~Aby porozmawiać~g~ [H] ~w~Aby wręczyć przedmiot")
                end
                if HasCashInformator == true and QuestItemInformator == true and ablepressH == false and QuestInformatorDrink == false then
                    DrawText3D(InformatorBaronGUN1.x, InformatorBaronGUN1.y, InformatorBaronGUN1.z+1.0, "~g~[E] ~w~Aby porozmawiać")
                end
                if HasCashInformator == true and QuestItemInformator == false and ablepressH == false and QuestInformatorDrink == true then
                    DrawText3D(InformatorBaronGUN1.x, InformatorBaronGUN1.y, InformatorBaronGUN1.z+1.0, "~g~[E] ~w~Aby porozmawiać ~g~[H] ~w~Aby wypić po maluchu")
                end
                if HasCashInformator == true and QuestItemInformator == false and ablepressH == true and QuestInformatorDrink == false then
                    DrawText3D(InformatorBaronGUN1.x, InformatorBaronGUN1.y, InformatorBaronGUN1.z+1.0, "~g~[E] ~w~Aby porozmawiać~g~ [H] ~w~Aby wręczyć pieniądzę")
                end
                if HasCashInformator == true and QuestItemInformator == true and ablepressH == true and QuestInformatorDrink == false then
                    DrawText3D(InformatorBaronGUN1.x, InformatorBaronGUN1.y, InformatorBaronGUN1.z+1.0, "~g~[E] ~w~Aby porozmawiać~g~ [H] ~w~Aby wręczyć pieniądzę")
                end
                if HasCashInformator == true and QuestItemInformator == false and ablepressH == false and QuestInformatorDrink == false then
                    DrawText3D(InformatorBaronGUN1.x, InformatorBaronGUN1.y, InformatorBaronGUN1.z+1.0, "~g~[E] ~w~Aby porozmawiać")
                end
            end
        end
    end
end)

---- Sprawdzanie czy gracz jest przy pedzie
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords = GetEntityCoords(GetPlayerPed(-1))
        local isNearInformator = false
            if PlayerData.job ~= nil and PlayerData.job.name ~= 'police' and PlayerData.job.name ~= 'statepolice' and PlayerData.job.name ~= 'sheriff' then
                if GetDistanceBetweenCoords(coords, InformatorBaronGUN1, true) <= 1.2 then
                    local random = math.random(1,100)
                    local inveh = IsPedInAnyVehicle(GetPlayerPed(-1), false)
                    isNearInformator  = true
                    if IsControlJustReleased(0, Keys['E']) and CooldownAblePressEInformator == false then
                        if inveh then
                            exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać z menelem siedząc w samochodzie!', 3500)
                        elseif CooldownAblePressEInformator == true then
                            exports['mythic_notify']:DoCustomHudText('error', 'Nie rozmawiam z tobą, spadaj!', 3500)
                        elseif random >= 1 and random <= 13 then
                            TextPressEInformator = true
                            Citizen.Wait(4000)
                            TextPressEInformator = false
                            CooldownAblePressEInformator = true
                            Citizen.Wait(900000)
                            CooldownAblePressEInformator = false
                        elseif random >= 14 and random <= 27 then
                            TextPressEInformator2 = true
                            Citizen.Wait(4000)
                            TextPressEInformator2 = false
                            CooldownAblePressEInformator = true
                            Citizen.Wait(900000)
                            CooldownAblePressEInformator = false
                        elseif random >= 28 and random <= 40 then
                            TextPressEInformator3 = true
                            Citizen.Wait(4000)
                            TextPressEInformator3 = false
                            CooldownAblePressEInformator = true
                            Citizen.Wait(900000)
                            CooldownAblePressEInformator = false
                        elseif random >= 41 and random <= 55 then
                            TextPressEInformator4 = true
                            Citizen.Wait(4000)
                            TextPressEInformator4 = false
                            Citizen.Wait(2000)
                            TextPressEInformator4a = true
                            Citizen.Wait(4000)
                            TextPressEInformator4a = false
                            CooldownAblePressEInformator = true
                            Citizen.Wait(900000)
                            CooldownAblePressEInformator = false
                        elseif random >= 56 and random <= 69 then
                            TextPressEInformatorStart1 = true
                            Citizen.Wait(4000)
                            TextPressEInformatorStart1 = false
                            TextPressEInformator5Quest = true
                            Citizen.Wait(4000)
                            TextPressEInformator5Quest = false
                            QuestCheckInformator = true
                            CooldownAblePressEInformator = true
                        elseif random >= 70 then
                            TextPressEInformatorStart1 = true
                            Citizen.Wait(5000)
                            TextPressEInformatorStart1 = false
                            TextPressEInformatorStart2 = true
                            Citizen.Wait(5000)
                            TextPressEInformatorStart2 = false
                            TextPressEInformatorStart3 = true
                            Citizen.Wait(5000)
                            TextPressEInformatorStart3 = false
                            ablepressH = true
                            --CooldownAblePressEInformator = true
                        end
                    elseif IsControlJustReleased(0, Keys['E']) and CooldownAblePressEInformator == true then
                        exports['mythic_notify']:DoCustomHudText('inform', 'Spadaj stąd zanim zawołam chłopaków!', 3500)
                    elseif IsControlJustReleased(0, Keys['H']) and QuestItemInformator == true and QuestCheckInformator == true then
                        if inveh then
                            exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                        else
                            TextInformator1Quest = true
                            Citizen.Wait(3000)
                            TextInformator1Quest = false
                            TextInformator2Quest = true
                            Citizen.Wait(3000)
                            TextInformator2Quest = false
                            CooldownAblePressEInformator = false
                            QuestCheckInformator = false
                            QuestItemInformator = false
                            QuestInformatorDrink = true
                        end
                    elseif IsControlJustReleased(0, Keys['H']) and QuestCheckInformator == false and QuestInformatorDrink == true then
                        if inveh then
                            exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                        else
                            LoadDict("mp_common")
                            TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a', 8.0, 8.0, -1, 0, 0, false, false, false)
                            TriggerServerEvent('srp_blackmarket:QuestUseVodka', source)
                            TextInformatorDrink = true
                            Citizen.Wait(3000)
                            TextInformatorDrink = false
                            TextInformatorDrink2 = true
                            Citizen.Wait(3000)
                            TextInformatorDrink2 = false
                            CooldownAblePressEInformator = false
                            QuestInformatorDrink = false
                        end
                    elseif IsControlJustReleased(0, Keys['H']) and HasCashInformator == true and ablepressH == true then
                        if PlayerData.job ~= nil and PlayerData.job.name ~= 'offpolice' and PlayerData.job.name ~= 'offstatepolice' and PlayerData.job.name ~= 'offsheriff' then
                            if inveh then
                                exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                CooldownAblePressEInformator = false
                            else
                            --zmiana pracy raz na tydzien
                            --TriggerServerEvent('zrider:job_date_retrieve')
                            Citizen.Wait(500)
                            --ESX.TriggerServerCallback('zrider:StartJobDate', function(StartJobDate)
                                --if StartJobDate == nil then
                                TriggerServerEvent('srp_blackmarket:SetJobBaronGun')
                                --TriggerServerEvent('zrider:job_date_update', DayTodayGun())
                                --TriggerServerEvent('srp_logs:jobChanged','BaronGUN')
                                LoadDict("mp_common")
                                TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a', 8.0, 8.0, -1, 0, 0, false, false, false)
                                TriggerServerEvent('srp_blackmarket:RemoveMoneyBaronGun')
                                TextInformatorH1 = true
                                Citizen.Wait(5000)
                                TextInformatorH1 = false
                                TextInformatorH2 = true
                                Citizen.Wait(5000)
                                TextInformatorH2 = false
                                TextInformatorH3 = true
                                Citizen.Wait(5000)
                                TextInformatorH3 = false
                                TextInformatorH4 = true
                                Citizen.Wait(5000)
                                TextInformatorH4 = false
                                TextInformatorH5 = true
                                Citizen.Wait(2500)
                                TextInformatorH5 = false
                                CanBuyGun = true
                                StartBaronGun()
                                --Citizen.Wait(900000)
                                CanBuyGun = false
                                CooldownAblePressEInformator = false
                                -- else
                                -- local data_zatrudnienia = StartJobDate
                                -- local dzien_zatrudnienia,miesiac_zatrudnienia,rok_zatrudnienia = (data_zatrudnienia):match("(%d%d)-(%d%d)-(%d%d%d%d)")
                                -- dzien_zatrudnienia = tonumber(dzien_zatrudnienia)
                                -- miesiac_zatrudnienia = tonumber(miesiac_zatrudnienia)
                                -- rok_zatrudnienia = tonumber(rok_zatrudnienia)  
                                -- if DaysBetweenManualGun(dzien_zatrudnienia,miesiac_zatrudnienia,rok_zatrudnienia) >= 7 then
                                --     TriggerServerEvent('srp_blackmarket:SetJobBaronGun')
                                --     TriggerServerEvent('zrider:job_date_update', DayTodayGun())
                                --     TriggerServerEvent('srp_logs:jobChanged','BaronGUN')
                                --     LoadDict("mp_common")
                                --     TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a', 8.0, 8.0, -1, 0, 0, false, false, false)
                                --     TriggerServerEvent('srp_blackmarket:RemoveMoneyBaronGun')
                                --     TextInformatorH1 = true
                                --     Citizen.Wait(5000)
                                --     TextInformatorH1 = false
                                --     TextInformatorH2 = true
                                --     Citizen.Wait(5000)
                                --     TextInformatorH2 = false
                                --     TextInformatorH3 = true
                                --     Citizen.Wait(5000)
                                --     TextInformatorH3 = false
                                --     TextInformatorH4 = true
                                --     Citizen.Wait(5000)
                                --     TextInformatorH4 = false
                                --     TextInformatorH5 = true
                                --     Citizen.Wait(2500)
                                --     TextInformatorH5 = false
                                --     CanBuyGun = true
                                --     StartBaronGun()
                                --     --Citizen.Wait(900000)
                                --     CanBuyGun = false
                                --     CooldownAblePressEInformator = false
                                -- else
                                --     exports['mythic_notify']:DoCustomHudText('error', 'Możesz zmienić pracę tylko raz na tydzień', 3500)
                                --     TriggerServerEvent('srp_logs:jobChanged','Proba zmiany pracy (BaronGun)')
                                --     CooldownAblePressEInformator = false
                            --end
                            --end)
                            end
                        else
                        exports['mythic_notify']:DoCustomHudText('inform', 'Coś mi tu śmierdzisz, uciekaj w podskokach!', 3500)
                        CooldownAblePressEInformator = false
                        end
                    end
                elseif(GetDistanceBetweenCoords(coords, InformatorBaronGUN1, true) > 1000) then
                    Citizen.Wait(20000)
                elseif(GetDistanceBetweenCoords(coords, InformatorBaronGUN1, true) > 500) then
                    Citizen.Wait(10000)
                elseif(GetDistanceBetweenCoords(coords, InformatorBaronGUN1, true) > 100) then
                    Citizen.Wait(3000)
                end
            end
	end
end)

-- Wyświetlanie tekstów nad głową Informatora Sprzedawcy
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local pedcoords = GetEntityCoords(PlayerPedId())
        if TextPressEInformator == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorBaronGUN1, false) <= 5 then
                DrawText3D(InformatorBaronGUN1.x, InformatorBaronGUN1.y, InformatorBaronGUN1.z+2.0, "~w~Jak chcesz sie czegoś dowiedziec...")
                DrawText3D(InformatorBaronGUN1.x, InformatorBaronGUN1.y, InformatorBaronGUN1.z+1.9, "~w~to najpierw przynies mi 10kg Stali Nierdzewnej")
            end
        end
        if TextPressEInformator2 == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorBaronGUN1, false) <= 5 then
                DrawText3D(InformatorBaronGUN1.x, InformatorBaronGUN1.y, InformatorBaronGUN1.z+2.0, "~w~Przywiez mi kurwa groszek z Paleto hehe...")
            end
        end
        if TextPressEInformator3 == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorBaronGUN1, false) <= 5 then
                DrawText3D(InformatorBaronGUN1.x, InformatorBaronGUN1.y, InformatorBaronGUN1.z+2.0, "~w~Znajdz piasek na pustyni...")
            end
        end
        if TextPressEInformator4 == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorBaronGUN1, false) <= 5 then
                DrawText3D(InformatorBaronGUN1.x, InformatorBaronGUN1.y, InformatorBaronGUN1.z+2.0, "~w~Pokaz mi swoją twarz...")
            end
        end
        if TextPressEInformator4a == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorBaronGUN1, false) <= 5 then
                DrawText3D(InformatorBaronGUN1.x, InformatorBaronGUN1.y, InformatorBaronGUN1.z+2.0, "~w~Ale jesteś kurwa brzydki/a hahahaha, spadaj...")
            end
        end
        if TextPressEInformator5Quest == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorBaronGUN1, false) <= 5 then
                DrawText3D(InformatorBaronGUN1.x, InformatorBaronGUN1.y, InformatorBaronGUN1.z+2.0, "~w~Przywiez mi cos co mi posmakuje, chce aby to bylo schlodzone...")
            end
        end
        if TextPressEInformatorStart1 == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorBaronGUN1, false) <= 5 then
                DrawText3D(InformatorBaronGUN1.x, InformatorBaronGUN1.y, InformatorBaronGUN1.z+2.0, "~w~Widzę Panie kolego że jesteś ciekawy...")
            end
        end
        if TextPressEInformatorStart2 == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorBaronGUN1, false) <= 5 then
                DrawText3D(InformatorBaronGUN1.x, InformatorBaronGUN1.y, InformatorBaronGUN1.z+2.0, "~w~Przynieś mi 1000 dolarków i wtedy pogadamy...")
            end
        end
        if TextPressEInformatorStart3 == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorBaronGUN1, false) <= 5 then
                DrawText3D(InformatorBaronGUN1.x, InformatorBaronGUN1.y, InformatorBaronGUN1.z+2.0, "~w~Powodzenia...")
            end
        end
        if TextInformator1Quest == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorBaronGUN1, false) <= 5 then
                DrawText3D(InformatorBaronGUN1.x, InformatorBaronGUN1.y, InformatorBaronGUN1.z+2.0, "~w~Pokaż co Ty mi tu przyniosłeś, hmm...")
            end
        end
        if TextInformator2Quest == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorBaronGUN1, false) <= 5 then
                DrawText3D(InformatorBaronGUN1.x, InformatorBaronGUN1.y, InformatorBaronGUN1.z+2.0, "~w~Dobra to machniemy po maluchu i Ci powiem nieco więcej...")
            end
        end
        if TextInformatorDrink == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorBaronGUN1, false) <= 5 then
                DrawText3D(InformatorBaronGUN1.x, InformatorBaronGUN1.y, InformatorBaronGUN1.z+2.0, "~w~AAA.. dobra wódeczka, tego mi było potrzeba...")
            end
        end
        if TextInformatorDrink2 == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorBaronGUN1, false) <= 5 then
                DrawText3D(InformatorBaronGUN1.x, InformatorBaronGUN1.y, InformatorBaronGUN1.z+2.0, "~w~A teraz spieprzaj mi stąd w podskokach...")
            end
        end
        if TextInformatorH1 == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorBaronGUN1, false) <= 5 then
                DrawText3D(InformatorBaronGUN1.x, InformatorBaronGUN1.y, InformatorBaronGUN1.z+2.0, "~w~Daj mi te siano niech ja zerknę...")
            end
        end
        if TextInformatorH2 == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorBaronGUN1, false) <= 5 then
                DrawText3D(InformatorBaronGUN1.x, InformatorBaronGUN1.y, InformatorBaronGUN1.z+2.0, "~w~Dobra sumka się zgadza...")
            end
        end
        if TextInformatorH3 == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorBaronGUN1, false) <= 5 then
                DrawText3D(InformatorBaronGUN1.x, InformatorBaronGUN1.y, InformatorBaronGUN1.z+2.0, "~w~Ja Ci nic więcej nie powiem ale masz tu kartkę...")
            end
        end
        if TextInformatorH4 == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorBaronGUN1, false) <= 5 then
                DrawText3D(InformatorBaronGUN1.x, InformatorBaronGUN1.y, InformatorBaronGUN1.z+2.0, "~w~Znajdziesz tam osobę która powie Ci coś na pewny temat...")
            end
        end
        if TextInformatorH5 == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorBaronGUN1, false) <= 5 then
                DrawText3D(InformatorBaronGUN1.x, InformatorBaronGUN1.y, InformatorBaronGUN1.z+2.0, "~w~Trzymaj się i uważaj na siebie...")
            end
        end
        if nopolice == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorBaronGUN1, false) <= 5 then
                DrawText3D(InformatorBaronGUN1.x, InformatorBaronGUN1.y, InformatorBaronGUN1.z+2.0, "~w~Z psami nie rozmawiam...")
            end
        end
    end
end)
---- Sprawdzanie czy gracz ma wymagane przedmioty
RegisterNetEvent("srp_blackmarket:HasCashInformator")
AddEventHandler("srp_blackmarket:HasCashInformator", function(count)
    if count > 0 then
        HasCashInformator = true
    elseif count == 0 then
        HasCashInformator = false 
    end
end)

RegisterNetEvent("srp_blackmarket:QuestItemInformator")
AddEventHandler("srp_blackmarket:QuestItemInformator", function(count)
    if count > 0 then
        QuestItemInformator = true
    elseif count == 0 then
        QuestItemInformator = false 
    end
end)

-- Funkcja odpowiedzialna za interakcje z sprzedawca --
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local coords = GetEntityCoords(GetPlayerPed(-1))
        if PlayerData.job ~= nil and PlayerData.job.name == 'barongun' then
            -- SNS Pistol
            if GetDistanceBetweenCoords(coords, SNSPistol.x, SNSPistol.y, SNSPistol.z, false) <= 1.5 then
                if DisplayInteractionButton == true then
                    DrawText3D(SNSPistol.x, SNSPistol.y, SNSPistol.z+1, "~g~[E] ~w~Aby porozmawiać")
                end
                if pyt1 == true then
                    DrawText3D(SNSPistol.x, SNSPistol.y, SNSPistol.z+1, "~g~[H] ~w~Tak ~g~[X] ~w~Żadnych gier nie psuję")
                end
                if pyt2 == true then
                    DrawText3D(SNSPistol.x, SNSPistol.y, SNSPistol.z+1, "~g~[H] ~w~Uciekam, nie daję się złapać, strzelam")
                    DrawText3D(SNSPistol.x, SNSPistol.y, SNSPistol.z+0.9, "~g~[X] ~w~Ale o co chodzi?")
                end
                if pyt3 == true then
                    DrawText3D(SNSPistol.x, SNSPistol.y, SNSPistol.z+1, "~g~[H] ~w~Tak ~g~[X] ~w~Nie")
                end
                if pyt4 == true then
                    DrawText3D(SNSPistol.x, SNSPistol.y, SNSPistol.z+1, "~g~[H] ~w~McDonald's ~g~[X] ~w~Burger King")
                end
                if pyt5 == true then
                    DrawText3D(SNSPistol.x, SNSPistol.y, SNSPistol.z+1, "~g~[H] ~w~Czarno-Czerwony ~g~[X] ~w~Różnego")
                end
                if pyt6 == true then
                    DrawText3D(SNSPistol.x, SNSPistol.y, SNSPistol.z+1, "~g~[H] ~w~Fiat ~g~[X] ~w~Ferrari")
                end
                if pyt7 == true then
                    DrawText3D(SNSPistol.x, SNSPistol.y, SNSPistol.z+1, "~g~[H] ~w~CBorchardt C93 ~g~[X] ~w~Glock-17")
                end
                if pyt8 == true then
                    DrawText3D(SNSPistol.x, SNSPistol.y, SNSPistol.z+1, "~g~[H] ~w~Wszystkie ~g~[X] ~w~Żadnego")
                end
                if pyt9 == true then
                    DrawText3D(SNSPistol.x, SNSPistol.y, SNSPistol.z+1, "~g~[H] ~w~Pan White ~g~[X] ~w~Prezydent")
                end
                if pyt10 == true then
                    DrawText3D(SNSPistol.x, SNSPistol.y, SNSPistol.z+1, "~g~[H] ~w~Droga ~g~[X] ~w~Samochód")
                end
            end
            -- Pistol
            if GetDistanceBetweenCoords(coords, Pistol.x, Pistol.y, Pistol.z, false) <= 1.0 then
                if DisplayInteractionButton == true then
                    DrawText3D(Pistol.x, Pistol.y, Pistol.z+1, "~g~[E] ~w~Aby porozmawiać")
                end
                if pytPistol1 == true then
                    DrawText3D(Pistol.x, Pistol.y, Pistol.z+1, "~g~[H] ~w~W szafce ~g~[X] ~w~U Janusza")
                end
                if pytPistol2 == true then
                    DrawText3D(Pistol.x, Pistol.y, Pistol.z+1, "~g~[H] ~w~3 ~g~[X] ~w~Cały tor")
                end
                if pytPistol3 == true then
                    DrawText3D(Pistol.x, Pistol.y, Pistol.z+1, "~g~[H] ~w~6 ~g~[X] ~w~Dużo")
                end
                if pytPistol4 == true then
                    DrawText3D(Pistol.x, Pistol.y, Pistol.z+1, "~g~[H] ~w~13 ~g~[X] ~w~12")
                end
                if pytPistol5 == true then
                    DrawText3D(Pistol.x, Pistol.y, Pistol.z+1, "~g~[H] ~w~Tak ~g~[X] ~w~Nie")
                end
                if pytPistol6 == true then
                    DrawText3D(Pistol.x, Pistol.y, Pistol.z+1, "~g~[H] ~w~Vinewood ~g~[X] ~w~Downtown")
                end
                if pytPistol7 == true then
                    DrawText3D(Pistol.x, Pistol.y, Pistol.z+1, "~g~[H] ~w~Żadna ~g~[X] ~w~7")
                end
                if pytPistol8 == true then
                    DrawText3D(Pistol.x, Pistol.y, Pistol.z+1, "~g~[H] ~w~Mokrych ~g~[X] ~w~Gładkich")
                end
                if pytPistol9 == true then
                    DrawText3D(Pistol.x, Pistol.y, Pistol.z+1, "~g~[H] ~w~Rękami ~g~[X] ~w~Ustami")
                end
                if pytPistol10 == true then
                    DrawText3D(Pistol.x, Pistol.y, Pistol.z+1, "~g~[H] ~w~Każdy ~g~[X] ~w~Nikt")
                end
            end
             -- ApPistol
            if GetDistanceBetweenCoords(coords, ApPistol.x, ApPistol.y, ApPistol.z, false) <= 1.0 then
                if DisplayInteractionButton == true then
                    DrawText3D(ApPistol.x, ApPistol.y, ApPistol.z+1, "~g~[E] ~w~Aby porozmawiać")
                end
            end
             -- Vintage Pistol
            if GetDistanceBetweenCoords(coords, VintagePistol.x, VintagePistol.y, VintagePistol.z, false) <= 1.0 then
                if DisplayInteractionButton == true then
                    DrawText3D(VintagePistol.x, VintagePistol.y, VintagePistol.z+1, "~g~[E] ~w~Aby porozmawiać")
                end
            end
            -- CombatPistol
            if GetDistanceBetweenCoords(coords, CombatPistol.x, CombatPistol.y, CombatPistol.z, false) <= 1.0 then
                if DisplayInteractionButton == true then
                    DrawText3D(CombatPistol.x, CombatPistol.y, CombatPistol.z+1, "~g~[E] ~w~Aby porozmawiać")
                end
                if pytCombatPistol1 == true then
                    DrawText3D(CombatPistol.x, CombatPistol.y, CombatPistol.z+1, "~g~[H] ~w~Łopata ~g~[X] ~w~Zółta koparka")
                end
                if pytCombatPistol2 == true then
                    DrawText3D(CombatPistol.x, CombatPistol.y, CombatPistol.z+1, "~g~[H] ~w~Ty sam ~g~[X] ~w~Wujek")
                end
                if pytCombatPistol3 == true then
                    DrawText3D(CombatPistol.x, CombatPistol.y, CombatPistol.z+1, "~g~[H] ~w~Ząb ~g~[X] ~w~Pietruszka")
                end
                if pytCombatPistol4 == true then
                    DrawText3D(CombatPistol.x, CombatPistol.y, CombatPistol.z+1, "~g~[H] ~w~Piór ~g~[X] ~w~Dziur w serze")
                end
                if pytCombatPistol5 == true then
                    DrawText3D(CombatPistol.x, CombatPistol.y, CombatPistol.z+1, "~g~[H] ~w~100 ~g~[X] ~w~116")
                end
                if pytCombatPistol6 == true then
                    DrawText3D(CombatPistol.x, CombatPistol.y, CombatPistol.z+1, "~g~[H] ~w~Albert ~g~[X] ~w~Jerzy")
                end
                if pytCombatPistol7 == true then
                    DrawText3D(CombatPistol.x, CombatPistol.y, CombatPistol.z+1, "~g~[H] ~w~Abl ~g~[X] ~w~Nikt")
                end
                if pytCombatPistol8 == true then
                    DrawText3D(CombatPistol.x, CombatPistol.y, CombatPistol.z+1, "~g~[H] ~w~Świecę ~g~[X] ~w~Zapałkę")
                end
                if pytCombatPistol9 == true then
                    DrawText3D(CombatPistol.x, CombatPistol.y, CombatPistol.z+1, "~g~[H] ~w~W 9 ~g~[X] ~w~W ostatnim")
                end
                if pytCombatPistol10 == true then
                    DrawText3D(CombatPistol.x, CombatPistol.y, CombatPistol.z+1, "~g~[H] ~w~Usiadł na nim")
                    DrawText3D(CombatPistol.x, CombatPistol.y, CombatPistol.z+0.9, "~g~[X] ~w~Wyruszył na bitwę")
                end
            end
             -- Heavy Pistol
            if GetDistanceBetweenCoords(coords, HeavyPistol.x, HeavyPistol.y, HeavyPistol.z, false) <= 1.0 then
                if DisplayInteractionButton == true then
                    DrawText3D(HeavyPistol.x, HeavyPistol.y, HeavyPistol.z+1, "~g~[E] ~w~Aby porozmawiać")
                end
            end
             -- Marksman Pistol
            if GetDistanceBetweenCoords(coords, MarksmanPistol.x, MarksmanPistol.y, MarksmanPistol.z, false) <= 1.0 then
                if DisplayInteractionButton == true then
                    DrawText3D(MarksmanPistol.x, MarksmanPistol.y, MarksmanPistol.z+1, "~g~[E] ~w~Aby porozmawiać")
                end
            end
             -- DesertEagle Pistol
            if GetDistanceBetweenCoords(coords, DesertEagle.x, DesertEagle.y, DesertEagle.z, false) <= 1.0 then
                if DisplayInteractionButton == true then
                    DrawText3D(DesertEagle.x, DesertEagle.y, DesertEagle.z+0.5, "~g~[E] ~w~Aby porozmawiać")
                end
            end
        end
    end
end)

--Funkcja odpowiedzialna za sprawdzanie czy gracz jest przy pedzie--

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local coords = GetEntityCoords(GetPlayerPed(-1))
        if GetDistanceBetweenCoords(coords, SNSPistol.x, SNSPistol.y, SNSPistol.z, false) <= 1.3 then
            TriggerServerEvent('srp_blackmarket:CashSNSPistol')
            isNearBaron = true
            if IsControlJustReleased(0, Keys['E']) and CashSNSPistol == false and CooldownSNSPistol == false and CoolDownTestFalseSNSPistol == false and CoolDownTestTrueSNSPistol == false then
                    if inveh then
                        exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                    end
                    DisplayInteractionButton = false
                    test1a = true
                    Citizen.Wait(5000)
                    test1a = false
                    CooldownSNSPistol = true
                    Citizen.Wait(60000)
                    CooldownSNSPistol = false
                    DisplayInteractionButton = true
                end
            if IsControlJustReleased(0, Keys['E']) and CooldownSNSPistol == false and CashSNSPistol == true and CoolDownTestFalseSNSPistol == false and CoolDownTestTrueSNSPistol == false then
                if inveh then
                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                end
                    test1 = true
                    DisplayInteractionButton = false
                    Citizen.Wait(5000)
                    test1 = false
                    test2 = true
                    Citizen.Wait(2500)
                    test2 = false
                    pyt1 = true
            end
            if pyt1 == true then
                if IsControlJustReleased(0, Keys['H']) then
                    odp1 = false
                    pyt1 = false
                    Citizen.Wait(1500)
                    pyt2 = true
                end
                if IsControlJustReleased(0, Keys['X']) then
                    odp1 = true
                    pyt1 = false
                    Citizen.Wait(1500)
                    pyt2 = true
                end
            elseif pyt2 == true then
                if IsControlJustReleased(0, Keys['H']) then
                    odp2 = true
                    pyt2 = false
                    Citizen.Wait(1500)
                    pyt3 = true
                end
                if IsControlJustReleased(0, Keys['X']) then
                    odp2 = false
                    pyt2 = false
                    Citizen.Wait(1500)
                    pyt3 = true
                end
            elseif pyt3 == true then
                if IsControlJustReleased(0, Keys['H']) then
                    odp3 = true
                    pyt3 = false
                    Citizen.Wait(1500)
                    pyt4 = true
                end
                if IsControlJustReleased(0, Keys['X']) then
                    odp3 = false
                    pyt3 = false
                    Citizen.Wait(1500)
                    pyt4 = true
                end
            elseif pyt4 == true then
                if IsControlJustReleased(0, Keys['H']) then
                    odp4 = false
                    pyt4 = false
                    Citizen.Wait(1500)
                    pyt5 = true
                end
                if IsControlJustReleased(0, Keys['X']) then
                    odp4 = true
                    pyt4 = false
                    Citizen.Wait(1500)
                    pyt5 = true
                end
            elseif pyt5 == true then
                if IsControlJustReleased(0, Keys['H']) then
                    odp5 = false
                    pyt5 = false
                    Citizen.Wait(1500)
                    pyt6 = true
                end
                if IsControlJustReleased(0, Keys['X']) then
                    odp5 = true
                    pyt5 = false
                    Citizen.Wait(1500)
                    pyt6 = true
                end
            elseif pyt6 == true then
                if IsControlJustReleased(0, Keys['H']) then
                    odp6 = true
                    pyt6 = false
                    Citizen.Wait(1500)
                    pyt7 = true
                end
                if IsControlJustReleased(0, Keys['X']) then
                    odp6 = false
                    pyt6 = false
                    Citizen.Wait(1500)
                    pyt7 = true
                end
            elseif pyt7 == true then
                if IsControlJustReleased(0, Keys['H']) then
                    odp7 = false
                    pyt7 = false
                    Citizen.Wait(1500)
                    pyt8 = true
                end
                if IsControlJustReleased(0, Keys['X']) then
                    odp7 = true
                    pyt7 = false
                    Citizen.Wait(1500)
                    pyt8 = true
                end
            elseif pyt8 == true then
                if IsControlJustReleased(0, Keys['H']) then
                    odp8 = false
                    pyt8 = false
                    Citizen.Wait(1500)
                    pyt9 = true
                end
                if IsControlJustReleased(0, Keys['X']) then
                    odp8 = true
                    pyt8 = false
                    Citizen.Wait(1500)
                    pyt9 = true
                end
            elseif pyt9 == true then
                if IsControlJustReleased(0, Keys['H']) then
                    odp9 = true
                    pyt9 = false
                    Citizen.Wait(1500)
                    pyt10 = true
                end
                if IsControlJustReleased(0, Keys['X']) then
                    odp9 = false
                    pyt9 = false
                    Citizen.Wait(1500)
                    pyt10 = true
                end
            elseif pyt10 == true then
                if IsControlJustReleased(0, Keys['H']) then
                    odp10 = true
                    pyt10 = false
                    Citizen.Wait(1500)
                    odp11 = true
                end
                if IsControlJustReleased(0, Keys['X']) then
                    odp10 = false
                    pyt10 = false
                    Citizen.Wait(1500)
                    odp11 = true
                end
                if odp11 == true then
                    if odp1 == true and odp2 == true and odp3 == true and odp4 == true and odp5 == true and odp6 == true and odp7 == true and odp8 == true and odp9 == true and odp10 == true then
                        tekst3 = true
                        Citizen.Wait(2500)
                        tekst3 = false
                        TriggerServerEvent('srp_blackmarket:GiveItemSNSTest')
                        giveitem = true
                        Citizen.Wait(3000)
                        giveitem = false
                        CoolDownTestTrueSNSPistol = true
                        Citizen.Wait(30000)
                        CoolDownTestTrueSNSPistol = false
                    else
                        tekst4 = true
                        Citizen.Wait(2500)
                        tekst4 = false
                        CoolDownTestFalseSNSPistol = true
                        Citizen.Wait(600000)
                        CoolDownTestFalseSNSPistol = false
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local coords = GetEntityCoords(GetPlayerPed(-1))
        if GetDistanceBetweenCoords(coords, Pistol.x, Pistol.y, Pistol.z, false) <= 1.3 then
            TriggerServerEvent('srp_blackmarket:CashPistol')
            isNearBaron = true
            if IsControlJustReleased(0, Keys['E']) and CashPistol == false and CooldownPistol == false and CoolDownTestFalsePistol == false and CoolDownTestTruePistol == false then
                if inveh then
                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                end
                testPistol1a = true
                Citizen.Wait(5000)
                testPistol1a = false
                CooldownPistol = true
                Citizen.Wait(120000)
                CooldownPistol = false
            end
            if IsControlJustReleased(0, Keys['E']) and CooldownPistol == false and CashPistol == true and CoolDownTestFalsePistol == false and CoolDownTestTruePistol == false then
                if inveh then
                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                end
                testPistol1 = true
                DisplayInteractionButton = false
                Citizen.Wait(5000)
                testPistol1 = false
                testPistol2 = true
                Citizen.Wait(2500)
                testPistol2 = false
                pytPistol1 = true
            end
            if pytPistol1 == true then
                if IsControlJustReleased(0, Keys['H']) then
                    odpPistol1 = false
                    pytPistol1 = false
                    Citizen.Wait(1500)
                    pytPistol2 = true
                end
                if IsControlJustReleased(0, Keys['X']) then
                    odpPistol1 = true
                    pytPistol1 = false
                    Citizen.Wait(1500)
                    pytPistol2 = true
                end
            elseif pytPistol2 == true then
                if IsControlJustReleased(0, Keys['H']) then
                    odpPistol2 = false
                    pytPistol2 = false
                    Citizen.Wait(1500)
                    pytPistol3 = true
                end
                if IsControlJustReleased(0, Keys['X']) then
                    odpPistol2 = true
                    pytPistol2 = false
                    Citizen.Wait(1500)
                    pytPistol3 = true
                end
            elseif pytPistol3 == true then
                if IsControlJustReleased(0, Keys['H']) then
                    odpPistol3 = true
                    pytPistol3 = false
                    Citizen.Wait(1500)
                    pytPistol4 = true
                end
                if IsControlJustReleased(0, Keys['X']) then
                    odpPistol3 = false
                    pytPistol3 = false
                    Citizen.Wait(1500)
                    pytPistol4 = true
                end
            elseif pytPistol4 == true then
                if IsControlJustReleased(0, Keys['H']) then
                    odpPistol4 = true
                    pytPistol4 = false
                    Citizen.Wait(1500)
                    pytPistol5 = true
                end
                if IsControlJustReleased(0, Keys['X']) then
                    odpPistol4 = false
                    pytPistol4 = false
                    Citizen.Wait(1500)
                    pytPistol5 = true
                end
            elseif pytPistol5 == true then
                if IsControlJustReleased(0, Keys['H']) then
                    odpPistol5 = false
                    pytPistol5 = false
                    Citizen.Wait(1500)
                    pytPistol6 = true
                end
                if IsControlJustReleased(0, Keys['X']) then
                    odpPistol5 = true
                    pytPistol5 = false
                    Citizen.Wait(1500)
                    pytPistol6 = true
                end
            elseif pytPistol6 == true then
                if IsControlJustReleased(0, Keys['H']) then
                    odpPistol6 = true
                    pytPistol6 = false
                    Citizen.Wait(1500)
                    pytPistol7 = true
                end
                if IsControlJustReleased(0, Keys['X']) then
                    odpPistol6 = false
                    pytPistol6 = false
                    Citizen.Wait(1500)
                    pytPistol7 = true
                end
            elseif pytPistol7 == true then
                if IsControlJustReleased(0, Keys['H']) then
                    odpPistol7 = false
                    pytPistol7 = false
                    Citizen.Wait(1500)
                    pytPistol8 = true
                end
                if IsControlJustReleased(0, Keys['X']) then
                    odpPistol7 = true
                    pytPistol7 = false
                    Citizen.Wait(1500)
                    pytPistol8 = true
                end
            elseif pytPistol8 == true then
                if IsControlJustReleased(0, Keys['H']) then
                    odpPistol8 = true
                    pytPistol8 = false
                    Citizen.Wait(1500)
                    pytPistol9 = true
                end
                if IsControlJustReleased(0, Keys['X']) then
                    odpPistol8 = false
                    pytPistol8 = false
                    Citizen.Wait(1500)
                    pytPistol9 = true
                end
            elseif pytPistol9 == true then
                if IsControlJustReleased(0, Keys['H']) then
                    odpPistol9 = false
                    pytPistol9 = false
                    Citizen.Wait(1500)
                    pytPistol10 = true
                end
                if IsControlJustReleased(0, Keys['X']) then
                    odpPistol9 = true
                    pytPistol9 = false
                    Citizen.Wait(1500)
                    pytPistol10 = true
                end
            elseif pytPistol10 == true then
                if IsControlJustReleased(0, Keys['H']) then
                    odpPistol10 = true
                    pytPistol10 = false
                    Citizen.Wait(1500)
                    odpPistol11 = true
                end
                if IsControlJustReleased(0, Keys['X']) then
                    odpPistol10 = false
                    pytPistol10 = false
                    Citizen.Wait(1500)
                    odpPistol11 = true
                end
                if odpPistol11 == true then
                    if odpPistol1 == true and odpPistol2 == true and odpPistol3 == true and odpPistol4 == true and odpPistol5 == true and odpPistol6 == true and odpPistol7 == true and odpPistol8 == true and odpPistol9 == true and odpPistol10 == true then
                        tekstPistol3 = true
                        Citizen.Wait(2500)
                        tekstPistol3 = false
                        TriggerServerEvent('srp_blackmarket:GiveItemPistoltest')
                        giveitem = true
                        Citizen.Wait(3000)
                        giveitem = false
                        CoolDownTestTruePistol = true
                        Citizen.Wait(30000)
                        CoolDownTestTruePistol = false
                    else
                        tekstPistol4 = true
                        Citizen.Wait(2500)
                        tekstPistol4 = false
                        CoolDownTestFalsePistol = true
                        Citizen.Wait(600000)
                        CoolDownTestFalsePistol = false
                    end
                end
            end
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local coords = GetEntityCoords(GetPlayerPed(-1))
        if GetDistanceBetweenCoords(coords, CombatPistol.x, CombatPistol.y, CombatPistol.z, false) <= 1.3 then
            TriggerServerEvent('srp_blackmarket:CashCombatPistol')
            isNearBaron = true
            if IsControlJustReleased(0, Keys['E']) and CashCombatPistol == false and CooldownCombatPistol == false and CoolDownTestFalseCombatPistol == false and CoolDownTestTrueCombatPistol == false then
                if inveh then
                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                end
                testCombatPistol1a = true
                Citizen.Wait(5000)
                testCombatPistol1a = false
                CooldownCombatPistol = true
                Citizen.Wait(120000)
                CooldownCombatPistol = false
            end
            if IsControlJustReleased(0, Keys['E']) and CooldownCombatPistol == false and CashCombatPistol == true and CoolDownTestFalseCombatPistol == false and CoolDownTestTrueCombatPistol == false then
                if inveh then
                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                end
                testCombatPistol1 = true
                DisplayInteractionButton = false
                Citizen.Wait(5000)
                testCombatPistol1 = false
                testCombatPistol2 = true
                Citizen.Wait(2500)
                testCombatPistol2 = false
                pytCombatPistol1 = true
            end
            if pytCombatPistol1 == true then
                if IsControlJustReleased(0, Keys['H']) then
                    odpCombatPistol1 = false
                    pytCombatPistol1 = false
                    Citizen.Wait(1500)
                    pytCombatPistol2 = true
                end
                if IsControlJustReleased(0, Keys['X']) then
                    odpCombatPistol1 = true
                    pytCombatPistol1 = false
                    Citizen.Wait(1500)
                    pytCombatPistol2 = true
                end
            elseif pytCombatPistol2 == true then
                if IsControlJustReleased(0, Keys['H']) then
                    odpCombatPistol2 = true
                    pytCombatPistol2 = false
                    Citizen.Wait(1500)
                    pytCombatPistol3 = true
                end
                if IsControlJustReleased(0, Keys['X']) then
                    odpCombatPistol2 = false
                    pytCombatPistol2 = false
                    Citizen.Wait(1500)
                    pytCombatPistol3 = true
                end
            elseif pytCombatPistol3 == true then
                if IsControlJustReleased(0, Keys['H']) then
                    odpCombatPistol3 = true
                    pytCombatPistol3 = false
                    Citizen.Wait(1500)
                    pytCombatPistol4 = true
                end
                if IsControlJustReleased(0, Keys['X']) then
                    odpCombatPistol3 = false
                    pytCombatPistol3 = false
                    Citizen.Wait(1500)
                    pytCombatPistol4 = true
                end
            elseif pytCombatPistol4 == true then
                if IsControlJustReleased(0, Keys['H']) then
                    odpCombatPistol4 = true
                    pytCombatPistol4 = false
                    Citizen.Wait(1500)
                    pytCombatPistol5 = true
                end
                if IsControlJustReleased(0, Keys['X']) then
                    odpCombatPistol4 = false
                    pytCombatPistol4 = false
                    Citizen.Wait(1500)
                    pytCombatPistol5 = true
                end
            elseif pytCombatPistol5 == true then
                if IsControlJustReleased(0, Keys['H']) then
                    odpCombatPistol5 = false
                    pytCombatPistol5 = false
                    Citizen.Wait(1500)
                    pytCombatPistol6 = true
                end
                if IsControlJustReleased(0, Keys['X']) then
                    odpCombatPistol5 = true
                    pytCombatPistol5 = false
                    Citizen.Wait(1500)
                    pytCombatPistol6 = true
                end
            elseif pytCombatPistol6 == true then
                if IsControlJustReleased(0, Keys['H']) then
                    odpCombatPistol6 = true
                    pytCombatPistol6 = false
                    Citizen.Wait(1500)
                    pytCombatPistol7 = true
                end
                if IsControlJustReleased(0, Keys['X']) then
                    odpCombatPistol6 = false
                    pytCombatPistol6 = false
                    Citizen.Wait(1500)
                    pytCombatPistol7 = true
                end
            elseif pytCombatPistol7 == true then
                if IsControlJustReleased(0, Keys['H']) then
                    odpCombatPistol7 = false
                    pytCombatPistol7 = false
                    Citizen.Wait(1500)
                    pytCombatPistol8 = true
                end
                if IsControlJustReleased(0, Keys['X']) then
                    odpCombatPistol7 = true
                    pytCombatPistol7 = false
                    Citizen.Wait(1500)
                    pytCombatPistol8 = true
                end
            elseif pytCombatPistol8 == true then
                if IsControlJustReleased(0, Keys['H']) then
                    odpCombatPistol8 = true
                    pytCombatPistol8 = false
                    Citizen.Wait(1500)
                    pytCombatPistol9 = true
                end
                if IsControlJustReleased(0, Keys['X']) then
                    odpCombatPistol8 = false
                    pytCombatPistol8 = false
                    Citizen.Wait(1500)
                    pytCombatPistol9 = true
                end
            elseif pytCombatPistol9 == true then
                if IsControlJustReleased(0, Keys['H']) then
                    odpCombatPistol9 = false
                    pytCombatPistol9 = false
                    Citizen.Wait(1500)
                    pytCombatPistol10 = true
                end
                if IsControlJustReleased(0, Keys['X']) then
                    odpCombatPistol9 = true
                    pytCombatPistol9 = false
                    Citizen.Wait(1500)
                    pytCombatPistol10 = true
                end
            elseif pytCombatPistol10 == true then
                if IsControlJustReleased(0, Keys['H']) then
                    odpCombatPistol10 = true
                    pytCombatPistol10 = false
                    Citizen.Wait(1500)
                    odpCombatPistol11 = true
                end
                if IsControlJustReleased(0, Keys['X']) then
                    odpCombatPistol10 = false
                    pytCombatPistol10 = false
                    Citizen.Wait(1500)
                    odpCombatPistol11 = true
                end
                if odpCombatPistol11 == true then
                    if odpCombatPistol1 == true and odpCombatPistol2 == true and odpCombatPistol3 == true and odpCombatPistol4 == true and odpCombatPistol5 == true and odpCombatPistol6 == true and odpCombatPistol7 == true and odpCombatPistol8 == true and odpCombatPistol9 == true and odpCombatPistol10 == true then
                        tekstCombatPistol3 = true
                        Citizen.Wait(2500)
                        tekstCombatPistol3 = false
                        TriggerServerEvent('srp_blackmarket:GiveItemCombatPistoltest')
                        giveitem = true
                        Citizen.Wait(3000)
                        giveitem = false
                        CoolDownTestTrueCombatPistol = true
                        Citizen.Wait(30000)
                        CoolDownTestTrueCombatPistol = false
                    else
                        tekstCombatPistol4 = true
                        Citizen.Wait(2500)
                        tekstCombatPistol4 = false
                        CoolDownTestFalseCombatPistol = true
                        Citizen.Wait(600000)
                        CoolDownTestFalseCombatPistol = false
                    end
                end
            end
        end
    end
end)

---- Sprawdzanie czy gracz ma wymagane przedmioty
RegisterNetEvent("srp_blackmarket:CashSNSPistol2")
AddEventHandler("srp_blackmarket:CashSNSPistol2", function(count)
    if count > 0 then
        CashSNSPistol = true
    elseif count == 0 then
        CashSNSPistol = false 
    end
end)
RegisterNetEvent("srp_blackmarket:CashPistol")
AddEventHandler("srp_blackmarket:CashPistol", function(count)
    if count > 0 then
        CashPistol = true
    elseif count == 0 then
        CashPistol = false 
    end
end)
RegisterNetEvent("srp_blackmarket:CashCombatPistol")
AddEventHandler("srp_blackmarket:CashCombatPistol", function(count)
    if count > 0 then
        CashCombatPistol = true
    elseif count == 0 then
        CashCombatPistol = false 
    end
end)


--Funkcja odpowiedzialna za poszczegolne kwestie peda--
Citizen.CreateThread(function()
    while true do
    Citizen.Wait(5)
    local coords = GetEntityCoords(GetPlayerPed(-1))
    if GetDistanceBetweenCoords(coords, SNSPistol.x, SNSPistol.y, SNSPistol.z, false) <= 1.3 then
        if test1a == true then
            if GetDistanceBetweenCoords(coords, SNSPistol, false) <= 5 then
                DrawText3D(SNSPistol.x, SNSPistol.y, SNSPistol.z+2, "~w~Przynieś mi 50.000$ a wtedy pogadamy...")
            end
        end
        if test1 == true then
            if GetDistanceBetweenCoords(coords, SNSPistol, false) <= 5 then
                DrawText3D(SNSPistol.x, SNSPistol.y, SNSPistol.z+2, "~w~A wiec chcesz dorobic na boku? Ale najpierw musisz mi odpowiedziec na kilka pytan")
            end
        end
        if test2 == true then
            if GetDistanceBetweenCoords(coords, SNSPistol, false) <= 5 then
                DrawText3D(SNSPistol.x, SNSPistol.y, SNSPistol.z+2, "~w~A wiec zaczynajmy...")
            end
        end
        if pyt1 == true then
            if GetDistanceBetweenCoords(coords, SNSPistol, false) <= 5 then
                DrawText3D(SNSPistol.x, SNSPistol.y, SNSPistol.z+2, "~w~Grypsujesz?")
            end
        end
        if pyt2 == true then
            if GetDistanceBetweenCoords(coords, SNSPistol, false) <= 5 then
                DrawText3D(SNSPistol.x, SNSPistol.y, SNSPistol.z+2, "~w~Jak złapie Cię policja to co robisz?")
            end
        end
        if pyt3 == true then
            if GetDistanceBetweenCoords(coords, SNSPistol, false) <= 5 then
                DrawText3D(SNSPistol.x, SNSPistol.y, SNSPistol.z+2, "~w~Pobijesz swojego kumpla?")
            end
        end
        if pyt4 == true then
            if GetDistanceBetweenCoords(coords, SNSPistol, false) <= 5 then
                DrawText3D(SNSPistol.x, SNSPistol.y, SNSPistol.z+2, "~w~McDonald's czy Burger King?")
            end
        end
        if pyt5 == true then
            if GetDistanceBetweenCoords(coords, SNSPistol, false) <= 5 then
                DrawText3D(SNSPistol.x, SNSPistol.y, SNSPistol.z+2, "~w~Jakiego koloru jest rakieta na Paleto Bay?")
            end
        end
        if pyt6 == true then
            if GetDistanceBetweenCoords(coords, SNSPistol, false) <= 5 then
                DrawText3D(SNSPistol.x, SNSPistol.y, SNSPistol.z+2, "~w~Która z włoskich firm produkowała karabiny maszynowe?")
            end
        end
        if pyt7 == true then
            if GetDistanceBetweenCoords(coords, SNSPistol, false) <= 5 then
                DrawText3D(SNSPistol.x, SNSPistol.y, SNSPistol.z+2, "~w~Jak nazywał się pierwszy samopowtarzalny pistolet?")
            end
        end
        if pyt8 == true then
            if GetDistanceBetweenCoords(coords, SNSPistol, false) <= 5 then
                DrawText3D(SNSPistol.x, SNSPistol.y, SNSPistol.z+2, "~w~Ile zwierząt Mojżesz zabrał do arki?")
            end
        end
        if pyt9 == true then
            if GetDistanceBetweenCoords(coords, SNSPistol, false) <= 5 then
                DrawText3D(SNSPistol.x, SNSPistol.y, SNSPistol.z+2, "~w~Pan Blue mieszka w niebieskim domu, Pani Pink mieszka w różowym domu")
                DrawText3D(SNSPistol.x, SNSPistol.y, SNSPistol.z+1.9, "~w~natomiast Pan Brown w domu brązowym. Kto mieszka w Białym Domu?")
            end
        end
        if pyt10 == true then
            if GetDistanceBetweenCoords(coords, SNSPistol, false) <= 5 then
                DrawText3D(SNSPistol.x, SNSPistol.y, SNSPistol.z+2, "~w~Co biegnie w dol i w gore ale sie nie porusza?")
            end
        end
        if tekst3 == true then
            if GetDistanceBetweenCoords(coords, SNSPistol, false) <= 5 then
                DrawText3D(SNSPistol.x, SNSPistol.y, SNSPistol.z+2, "~w~Brawo zaliczyłeś mój test...")
            end
        end
        if giveitem == true then
            if GetDistanceBetweenCoords(coords, SNSPistol, false) <= 5 then
                DrawText3D(SNSPistol.x, SNSPistol.y, SNSPistol.z+2, "~w~Masz tu coś odemnie, a co zrobisz to Twoja sprawa...")
            end
        end
        if tekst4 == true then
            if GetDistanceBetweenCoords(coords, SNSPistol, false) <= 5 then
                DrawText3D(SNSPistol.x, SNSPistol.y, SNSPistol.z+2, "~w~Oblałeś hehe....")
                DrawText3D(SNSPistol.x, SNSPistol.y, SNSPistol.z+1.9, "~w~Spieprzaj mi stąd!")
            end
        end
    end
    if GetDistanceBetweenCoords(coords, Pistol.x, Pistol.y, Pistol.z, false) <= 1.0 then
        if testPistol1a == true then
            if GetDistanceBetweenCoords(coords, Pistol, false) <= 5 then
                DrawText3D(Pistol.x, Pistol.y, Pistol.z+2, "~w~Przynieś mi 40.000$ a wtedy pogadamy...")
            end
        end
        if testPistol1 == true then
            if GetDistanceBetweenCoords(coords, Pistol, false) <= 5 then
                DrawText3D(Pistol.x, Pistol.y, Pistol.z+2, "~w~A więc chcesz dorobić na boku? Ale najpierw musisz mi odpowiedziec na kilka pytań")
            end
        end
        if testPistol2 == true then
            if GetDistanceBetweenCoords(coords, Pistol, false) <= 5 then
                DrawText3D(Pistol.x, Pistol.y, Pistol.z+2, "~w~A więc zaczynajmy...")
            end
        end
        if pytPistol1 == true then
            if GetDistanceBetweenCoords(coords, Pistol, false) <= 5 then
                DrawText3D(Pistol.x, Pistol.y, Pistol.z+2, "~w~Gdzie znajdziesz filtry?")
            end
        end
        if pytPistol2 == true then
            if GetDistanceBetweenCoords(coords, Pistol, false) <= 5 then
                DrawText3D(Pistol.x, Pistol.y, Pistol.z+2, "~w~Ile to pół tora dodać pół tora?")
            end
        end
        if pytPistol3 == true then
            if GetDistanceBetweenCoords(coords, Pistol, false) <= 5 then
                DrawText3D(Pistol.x, Pistol.y, Pistol.z+2, "~w~W jednej ręce trzy mam jabłka i w drugiej ręce trzy mam jabłka. Ile mam razem jabłek?")
            end
        end
        if pytPistol4 == true then
            if GetDistanceBetweenCoords(coords, Pistol, false) <= 5 then
                DrawText3D(Pistol.x, Pistol.y, Pistol.z+2, "~w~Na torcie jest 13 świeczek. Jedna zgasła. Ile zostało?")
            end
        end
        if pytPistol5 == true then
            if GetDistanceBetweenCoords(coords, Pistol, false) <= 5 then
                DrawText3D(Pistol.x, Pistol.y, Pistol.z+2, "~w~Czy felgi były kradzione?")
            end
        end
        if pytPistol6 == true then
            if GetDistanceBetweenCoords(coords, Pistol, false) <= 5 then
                DrawText3D(Pistol.x, Pistol.y, Pistol.z+2, "~w~Gdzie znajduję się Janush Customs?")
            end
        end
        if pytPistol7 == true then
            if GetDistanceBetweenCoords(coords, Pistol, false) <= 5 then
                DrawText3D(Pistol.x, Pistol.y, Pistol.z+2, "~w~Na płocie siedzi 10 wron. Myśliwi zastrzelili 7 reszta uciekła, ile zostało?")
            end
        end
        if pytPistol8 == true then
            if GetDistanceBetweenCoords(coords, Pistol, false) <= 5 then
                DrawText3D(Pistol.x, Pistol.y, Pistol.z+2, "~w~Jakich kamieni jest w morzu najwięcej?")
            end
        end
        if pytPistol9 == true then
            if GetDistanceBetweenCoords(coords, Pistol, false) <= 5 then
                DrawText3D(Pistol.x, Pistol.y, Pistol.z+2, "~w~Czym się mówi: rękami czy rękoma?")
            end
        end
        if pytPistol10 == true then
            if GetDistanceBetweenCoords(coords, Pistol, false) <= 5 then
                DrawText3D(Pistol.x, Pistol.y, Pistol.z+2, "~w~Kto stoi do dołu nogami?")
            end
        end
        if tekstPistol3 == true then
            if GetDistanceBetweenCoords(coords, Pistol, false) <= 5 then
                DrawText3D(Pistol.x, Pistol.y, Pistol.z+2, "~w~Brawo zaliczyłeś mój test...")
            end
        end
        if giveitem == true then
            if GetDistanceBetweenCoords(coords, Pistol, false) <= 5 then
                DrawText3D(Pistol.x, Pistol.y, Pistol.z+2, "~w~Masz tu coś odemnie, a co zrobisz to Twoja sprawa...")
            end
        end
        if tekstPistol4 == true then
            if GetDistanceBetweenCoords(coords, Pistol, false) <= 5 then
                DrawText3D(Pistol.x, Pistol.y, Pistol.z+2, "~w~Oblałeś hehe....")
                DrawText3D(Pistol.x, Pistol.y, Pistol.z+1.9, "~w~Spieprzaj mi stąd!")
            end
        end
    end
    if GetDistanceBetweenCoords(coords, CombatPistol.x, CombatPistol.y, CombatPistol.z, false) <= 1.0 then
        if testCombatPistol1a == true then
            if GetDistanceBetweenCoords(coords, CombatPistol, false) <= 5 then
                DrawText3D(CombatPistol.x, CombatPistol.y, CombatPistol.z+2, "~w~Przynieś mi 40.000$ a wtedy pogadamy...")
            end
        end
        if testCombatPistol1 == true then
            if GetDistanceBetweenCoords(coords, CombatPistol, false) <= 5 then
                DrawText3D(CombatPistol.x, CombatPistol.y, CombatPistol.z+2, "~w~A więc chcesz dorobić na boku? Ale najpierw musisz mi odpowiedziec na kilka pytań")
            end
        end
        if testCombatPistol2 == true then
            if GetDistanceBetweenCoords(coords, CombatPistol, false) <= 5 then
                DrawText3D(CombatPistol.x, CombatPistol.y, CombatPistol.z+2, "~w~A więc zaczynajmy...")
            end
        end
        if pytCombatPistol1 == true then
            if GetDistanceBetweenCoords(coords, CombatPistol, false) <= 5 then
                DrawText3D(CombatPistol.x, CombatPistol.y, CombatPistol.z+2, "~w~Co to jest żółte i kopie?")
            end
        end
        if pytCombatPistol2 == true then
            if GetDistanceBetweenCoords(coords, CombatPistol, false) <= 5 then
                DrawText3D(CombatPistol.x, CombatPistol.y, CombatPistol.z+2, "~w~Jest synem twojego ojca, ale nie jest twoim bratem. Kto to?")
            end
        end
        if pytCombatPistol3 == true then
            if GetDistanceBetweenCoords(coords, CombatPistol, false) <= 5 then
                DrawText3D(CombatPistol.x, CombatPistol.y, CombatPistol.z+2, "~w~Co rośnie do góry korzeniem?")
            end
        end
        if pytCombatPistol4 == true then
            if GetDistanceBetweenCoords(coords, CombatPistol, false) <= 5 then
                DrawText3D(CombatPistol.x, CombatPistol.y, CombatPistol.z+2, "~w~Im jest ich więcej, tym on mniej waży?")
            end
        end
        if pytCombatPistol5 == true then
            if GetDistanceBetweenCoords(coords, CombatPistol, false) <= 5 then
                DrawText3D(CombatPistol.x, CombatPistol.y, CombatPistol.z+2, "~w~Jak długo trwała wojna stuletnia?")
            end
        end
        if pytCombatPistol6 == true then
            if GetDistanceBetweenCoords(coords, CombatPistol, false) <= 5 then
                DrawText3D(CombatPistol.x, CombatPistol.y, CombatPistol.z+2, "~w~Jak miał na imię król Jerzy VI?")
            end
        end
        if pytCombatPistol7 == true then
            if GetDistanceBetweenCoords(coords, CombatPistol, false) <= 5 then
                DrawText3D(CombatPistol.x, CombatPistol.y, CombatPistol.z+2, "~w~Kto zabił Kaina?")
            end
        end
        if pytCombatPistol8 == true then
            if GetDistanceBetweenCoords(coords, CombatPistol, false) <= 5 then
                DrawText3D(CombatPistol.x, CombatPistol.y, CombatPistol.z+2, "~w~W pokoju stoi lampa naftowa i świeca. Co najpierw zapalisz?")
            end
        end
        if pytCombatPistol9 == true then
            if GetDistanceBetweenCoords(coords, CombatPistol, false) <= 5 then
                DrawText3D(CombatPistol.x, CombatPistol.y, CombatPistol.z+2, "~w~W którym miesiącu rodzi się najwięcej dzieci?")
            end
        end
        if pytCombatPistol10 == true then
            if GetDistanceBetweenCoords(coords, CombatPistol, false) <= 5 then
                DrawText3D(CombatPistol.x, CombatPistol.y, CombatPistol.z+2, "~w~Co zrobił Sobieski po objęciu tronu?")
            end
        end
        if tekstCombatPistol3 == true then
            if GetDistanceBetweenCoords(coords, CombatPistol, false) <= 5 then
                DrawText3D(CombatPistol.x, CombatPistol.y, CombatPistol.z+2, "~w~Brawo zaliczyłeś mój test...")
            end
        end
        if giveitem == true then
            if GetDistanceBetweenCoords(coords, CombatPistol, false) <= 5 then
                DrawText3D(CombatPistol.x, CombatPistol.y, CombatPistol.z+2, "~w~Masz tu coś odemnie, a co zrobisz to Twoja sprawa...")
            end
        end
        if tekstCombatPistol4 == true then
            if GetDistanceBetweenCoords(coords, CombatPistol, false) <= 5 then
                DrawText3D(CombatPistol.x, CombatPistol.y, CombatPistol.z+2, "~w~Oblałeś hehe....")
                DrawText3D(CombatPistol.x, CombatPistol.y, CombatPistol.z+1.9, "~w~Spieprzaj mi stąd!")
            end
        end

-----------

    end
    end
end)



-- Informator o Sprzedawcach (bez pytań!) --
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local coords = GetEntityCoords(PlayerPedId())
            if GetDistanceBetweenCoords(coords, InformatorDealerGUN1, true) <= 1.2 then
                nodisplay = true
            if PlayerData.job ~= nil and PlayerData.job.name ~= 'police' and PlayerData.job.name ~= 'statepolice' and PlayerData.job.name ~= 'sheriff' then
                TriggerServerEvent("srp_blackmarket:HasCashInformatorDealer")
                --TriggerServerEvent("srp_blackmarket:QuestItemInformator")
                -- Nie ma kasy
                if HasCashInformatorDealer == false and ablepressH == false  then
                    DrawText3D(InformatorDealerGUN1.x, InformatorDealerGUN1.y, InformatorDealerGUN1.z+1.0, "~g~[E] ~w~Aby porozmawiać")
                end
                if HasCashInformatorDealer == false and ablepressH == true then
                    DrawText3D(InformatorDealerGUN1.x, InformatorDealerGUN1.y, InformatorDealerGUN1.z+1.0, "~g~[E] ~w~Aby porozmawiać")
                end
                
                --Ma Kasę
                if HasCashInformatorDealer == true and ablepressH == true then
                    DrawText3D(InformatorDealerGUN1.x, InformatorDealerGUN1.y, InformatorDealerGUN1.z+1.0, "~g~[E] ~w~Aby porozmawiać ~g~[H] ~w~Aby wręczyć pieniądzę")
                end
                if HasCashInformatorDealer == true and ablepressH == false then
                    DrawText3D(InformatorDealerGUN1.x, InformatorDealerGUN1.y, InformatorDealerGUN1.z+1.0, "~g~[E] ~w~Aby porozmawiać")
                end
            end
        end
    end
end)

---- Sprawdzanie czy gracz jest przy pedzie
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords = GetEntityCoords(GetPlayerPed(-1))
        local isNearInformator = false
            if PlayerData.job ~= nil and PlayerData.job.name ~= 'police' and PlayerData.job.name ~= 'statepolice' and PlayerData.job.name ~= 'sheriff' then
                if GetDistanceBetweenCoords(coords, InformatorDealerGUN1, true) <= 1.2 then
                    local random = math.random(1,100)
                    local inveh = IsPedInAnyVehicle(GetPlayerPed(-1), false)
                    isNearInformator  = true
                    if IsControlJustReleased(0, Keys['E']) and CooldownAblePressEInformatorDealer == false then
                        if inveh then
                            exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać z menelem siedząc w samochodzie!', 3500)
                        elseif random >= 1 and random <= 13 then -- 1 13
                            TextPressEInformatorDealer = true
                            Citizen.Wait(4000)
                            TextPressEInformatorDealer = false
                            CooldownAblePressEInformatorDealer = true
                            Citizen.Wait(900000)
                            CooldownAblePressEInformatorDealer = false
                        elseif random >= 14 and random <= 27 then -- 14 27
                            TextPressEInformatorDealer2 = true
                            Citizen.Wait(4000)
                            TextPressEInformatorDealer2 = false
                            CooldownAblePressEInformatorDealer = true
                            Citizen.Wait(900000)
                            CooldownAblePressEInformatorDealer = false
                        elseif random >= 28 and random <= 40 then -- 28 40
                            TextPressEInformatorDealer3 = true
                            Citizen.Wait(4000)
                            TextPressEInformatorDealer3 = false
                            CooldownAblePressEInformatorDealer = true
                            Citizen.Wait(900000)
                            CooldownAblePressEInformatorDealer = false
                        elseif random >= 41 and random <= 55 then -- 41 55
                            TextPressEInformatorDealer4 = true
                            Citizen.Wait(4000)
                            TextPressEInformatorDealer4 = false
                            CooldownAblePressEInformatorDealer = true
                            Citizen.Wait(900000)
                            CooldownAblePressEInformatorDealer = false
                        elseif random >= 56 and random <= 69 then -- 56 69
                            TextPressEInformatorDealerStart1 = true
                            Citizen.Wait(4000)
                            TextPressEInformatorDealerStart1 = false
                            TextPressEInformatorDealer5Quest = true
                            Citizen.Wait(4000)
                            TextPressEInformatorDealer5Quest = false
                            TextInformatorDealer1Quest = true
                            Citizen.Wait(4000)
                            TextInformatorDealer1Quest = false
                            CooldownAblePressEInformatorDealer = true
                            Citizen.Wait(900000)
                            CooldownAblePressEInformatorDealer = false
                            --QuestCheckInformator = true
                            --CooldownAblePressEInformatorDealer = true
                        elseif random >= 70 then -- 70
                            TextPressEInformatorDealerStart1 = true
                            Citizen.Wait(5000)
                            TextPressEInformatorDealerStart1 = false
                            TextPressEInformatorDealerStart2 = true
                            Citizen.Wait(5000)
                            TextPressEInformatorDealerStart2 = false
                            TextPressEInformatorDealerStart3 = true
                            Citizen.Wait(5000)
                            TextPressEInformatorDealerStart3 = false
                            ablepressH = true
                            CooldownAblePressEInformatorDealer = true
                        end
                    elseif IsControlJustReleased(0, Keys['E']) and CooldownAblePressEInformatorDealer == true then
                        exports['mythic_notify']:DoCustomHudText('inform', 'Spadaj stąd zanim zawołam chłopaków!', 3500)
                    elseif IsControlJustReleased(0, Keys['H']) and HasCashInformatorDealer == true and ablepressH == true and CooldownAblePressEInformatorDealer == true then
                        if PlayerData.job ~= nil and PlayerData.job.name ~= 'offpolice' and PlayerData.job.name ~= 'offstatepolice' and PlayerData.job.name ~= 'offsheriff' then
                            if inveh then
                                exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                CooldownAblePressEInformatorDealer = false
                            else
                            --zmiana pracy raz na tydzien
                            --sTriggerServerEvent('zrider:job_date_retrieve')
                            Citizen.Wait(500)
                            -- ESX.TriggerServerCallback('zrider:StartJobDate', function(StartJobDate)
                            --     if StartJobDate == nil then
                                TriggerServerEvent('srp_blackmarket:SetJobDealerGun')
                               -- TriggerServerEvent('zrider:job_date_update', DayTodayGun())
                                --TriggerServerEvent('srp_logs:jobChanged','DealerGUN')
                                LoadDict("mp_common")
                                TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a', 8.0, 8.0, -1, 0, 0, false, false, false)
                                TriggerServerEvent('srp_blackmarket:RemoveMoneyDealerGun')
                                Citizen.Wait(1000)
                                TextInformatorDealerH1 = true
                                Citizen.Wait(5000)
                                TextInformatorDealerH1 = false
                                TextInformatorDealerH2 = true
                                Citizen.Wait(5000)
                                TextInformatorDealerH2 = false
                                TextInformatorDealerH3 = true
                                Citizen.Wait(5000)
                                TextInformatorDealerH3 = false
                                TextInformatorDealerH4 = true
                                Citizen.Wait(5000)
                                TextInformatorDealerH4 = false
                                TextInformatorDealerH5 = true
                                Citizen.Wait(2500)
                                TextInformatorDealerH5 = false
                                CooldownAblePressEInformatorDealer = false
                                -- else
                                -- local data_zatrudnienia = StartJobDate
                                -- local dzien_zatrudnienia,miesiac_zatrudnienia,rok_zatrudnienia = (data_zatrudnienia):match("(%d%d)-(%d%d)-(%d%d%d%d)")
                                -- dzien_zatrudnienia = tonumber(dzien_zatrudnienia)
                                -- miesiac_zatrudnienia = tonumber(miesiac_zatrudnienia)
                                -- rok_zatrudnienia = tonumber(rok_zatrudnienia)  
                                -- if DaysBetweenManualGun(dzien_zatrudnienia,miesiac_zatrudnienia,rok_zatrudnienia) >= 7 then
                                --     TriggerServerEvent('srp_blackmarket:SetJobDealerGUN')
                                --     TriggerServerEvent('zrider:job_date_update', DayTodayGun())
                                --     TriggerServerEvent('srp_logs:jobChanged','DealerGUN')
                                --     LoadDict("mp_common")
                                --     TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a', 8.0, 8.0, -1, 0, 0, false, false, false)
                                --     TriggerServerEvent('srp_blackmarket:RemoveMoneyDealerGUN')
                                --     TextInformatorDealerH1 = true
                                --     Citizen.Wait(5000)
                                --     TextInformatorDealerH1 = false
                                --     TextInformatorDealerH2 = true
                                --     Citizen.Wait(5000)
                                --     TextInformatorDealerH2 = false
                                --     TextInformatorDealerH3 = true
                                --     Citizen.Wait(5000)
                                --     TextInformatorDealerH3 = false
                                --     TextInformatorDealerH4 = true
                                --     Citizen.Wait(5000)
                                --     TextInformatorDealerH4 = false
                                --     TextInformatorDealerH5 = true
                                --     Citizen.Wait(2500)
                                --     TextInformatorDealerH5 = false
                                --     CooldownAblePressEInformatorDealer = false
                                -- else
                                --     exports['mythic_notify']:DoCustomHudText('error', 'Możesz zmienić pracę tylko raz na tydzień', 3500)
                                --     TriggerServerEvent('srp_logs:jobChanged','Proba zmiany pracy (DealerGUN)')
                                --     CooldownAblePressEInformatorDealer = false
                                -- end
                            --end
                            --end)
                            end
                        else
                        exports['mythic_notify']:DoCustomHudText('inform', 'Coś mi tu śmierdzisz, uciekaj w podskokach!', 3500)
                        CooldownAblePressEInformatorDealer = false
                        end
                    end
                elseif(GetDistanceBetweenCoords(coords, InformatorDealerGUN1, true) > 1000) then
                    Citizen.Wait(20000)
                elseif(GetDistanceBetweenCoords(coords, InformatorDealerGUN1, true) > 500) then
                    Citizen.Wait(10000)
                elseif(GetDistanceBetweenCoords(coords, InformatorDealerGUN1, true) > 100) then
                    Citizen.Wait(3000)
                end
            end
	end
end)

-- Wyświetlanie tekstów nad głową Informatora Sprzedawcy
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local pedcoords = GetEntityCoords(PlayerPedId())
        if TextPressEInformatorDealer == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorDealerGUN1, false) <= 5 then
                DrawText3D(InformatorDealerGUN1.x, InformatorDealerGUN1.y, InformatorDealerGUN1.z+2.0, "~w~Masz kopsnąc fajkę?")
            end
        end
        if TextPressEInformatorDealer2 == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorDealerGUN1, false) <= 5 then
                DrawText3D(InformatorDealerGUN1.x, InformatorDealerGUN1.y, InformatorDealerGUN1.z+2.0, "~w~Piękny dzisiaj dzień, nie sądzisz?")
            end
        end
        if TextPressEInformatorDealer3 == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorDealerGUN1, false) <= 5 then
                DrawText3D(InformatorDealerGUN1.x, InformatorDealerGUN1.y, InformatorDealerGUN1.z+2.0, "~w~Masz 5 minut żeby dojechać na szczyt Mount Chilliad")
                DrawText3D(InformatorDealerGUN1.x, InformatorDealerGUN1.y, InformatorDealerGUN1.z+2.0, "~w~jeśli Ci sie nie uda, stracisz jedyną szansę w swoim zyciu!")
            end
        end
        if TextPressEInformatorDealer4 == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorDealerGUN1, false) <= 5 then
                DrawText3D(InformatorDealerGUN1.x, InformatorDealerGUN1.y, InformatorDealerGUN1.z+2.0, "~w~Jeśli chodzi o mnie, to chciałbym zapewnić że nie jestem chłopem od nielegalnej broni")
                DrawText3D(InformatorDealerGUN1.x, InformatorDealerGUN1.y, InformatorDealerGUN1.z+2.0, "~w~źle trafiłeś...")
            end
        end
        if TextPressEInformatorDealer5Quest == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorDealerGUN1, false) <= 5 then
                DrawText3D(InformatorDealerGUN1.x, InformatorDealerGUN1.y, InformatorDealerGUN1.z+2.0, "~w~Wiesz ze dziad z Janusz Customs kupuje odemnie lewe felgi? hehe...")
            end
        end
        if TextPressEInformatorDealerStart1 == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorDealerGUN1, false) <= 5 then
                DrawText3D(InformatorDealerGUN1.x, InformatorDealerGUN1.y, InformatorDealerGUN1.z+2.0, "~w~Widzę Byku że jesteś ciekawy...")
            end
        end
        if TextPressEInformatorDealerStart2 == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorDealerGUN1, false) <= 5 then
                DrawText3D(InformatorDealerGUN1.x, InformatorDealerGUN1.y, InformatorDealerGUN1.z+2.0, "~w~Dobra słuchaj mnie skarbie. Chcesz coś? To daj cos!")
            end
        end
        if TextPressEInformatorDealerStart3 == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorDealerGUN1, false) <= 5 then
                DrawText3D(InformatorDealerGUN1.x, InformatorDealerGUN1.y, InformatorDealerGUN1.z+2.0, "~w~Tysiąc dolarków będzie w sam raz...")
            end
        end
        if TextInformatorDealer1Quest == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorDealerGUN1, false) <= 5 then
                DrawText3D(InformatorDealerGUN1.x, InformatorDealerGUN1.y, InformatorDealerGUN1.z+2.0, "~w~Myśli że są prawdziwe. Chłop nie rozróżniłby jajka od piłki kauczukowej hehehe....")
            end
        end
        if TextInformatorDealer2Quest == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorDealerGUN1, false) <= 5 then
                DrawText3D(InformatorDealerGUN1.x, InformatorDealerGUN1.y, InformatorDealerGUN1.z+2.0, "~w~Dobra to machniemy po maluchu i Ci powiem nieco więcej...")
            end
        end
        if TextInformatorDealerDrink == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorDealerGUN1, false) <= 5 then
                DrawText3D(InformatorDealerGUN1.x, InformatorDealerGUN1.y, InformatorDealerGUN1.z+2.0, "~w~AAA.. dobra wódeczka, tego mi było potrzeba...")
            end
        end
        if TextInformatorDealerDrink2 == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorDealerGUN1, false) <= 5 then
                DrawText3D(InformatorDealerGUN1.x, InformatorDealerGUN1.y, InformatorDealerGUN1.z+2.0, "~w~A teraz spieprzaj mi stąd w podskokach...")
            end
        end
        if TextInformatorDealerH1 == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorDealerGUN1, false) <= 5 then
                DrawText3D(InformatorDealerGUN1.x, InformatorDealerGUN1.y, InformatorDealerGUN1.z+2.0, "~w~Dobra pokaż mi co tu przyniosłeś...")
            end
        end
        if TextInformatorDealerH2 == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorDealerGUN1, false) <= 5 then
                DrawText3D(InformatorDealerGUN1.x, InformatorDealerGUN1.y, InformatorDealerGUN1.z+2.0, "~w~Super, myślę że kwota się zgadza...")
            end
        end
        if TextInformatorDealerH3 == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorDealerGUN1, false) <= 5 then
                DrawText3D(InformatorDealerGUN1.x, InformatorDealerGUN1.y, InformatorDealerGUN1.z+2.0, "~w~Teraz mnie słuchaj uważnie...")
            end
        end
        if TextInformatorDealerH4 == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorDealerGUN1, false) <= 5 then
                DrawText3D(InformatorDealerGUN1.x, InformatorDealerGUN1.y, InformatorDealerGUN1.z+2.0, "~w~Od dziś wprowadzasz towar w miasto, dogadaj się z kimś kto ma skrzynie...")
            end
        end
        if TextInformatorDealerH5 == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorDealerGUN1, false) <= 5 then
                DrawText3D(InformatorDealerGUN1.x, InformatorDealerGUN1.y, InformatorDealerGUN1.z+2.0, "~w~W tej chwili już nie ma odwrotu, więc...")
                DrawText3D(InformatorDealerGUN1.x, InformatorDealerGUN1.y, InformatorDealerGUN1.z+1.9, "~w~Miłej pracy ;)")
            end
        end
        if nopolice == true then
            if GetDistanceBetweenCoords(pedcoords, InformatorDealerGUN1, false) <= 5 then
                DrawText3D(InformatorDealerGUN1.x, InformatorDealerGUN1.y, InformatorDealerGUN1.z+2.0, "~w~Z psami nie rozmawiam...")
            end
        end
    end
end)
---- Sprawdzanie czy gracz ma wymagane przedmioty
RegisterNetEvent("srp_blackmarket:HasCashInformatorDealer")
AddEventHandler("srp_blackmarket:HasCashInformatorDealer", function(count)
    if count > 0 then
        HasCashInformatorDealer = true
    elseif count == 0 then
        HasCashInformatorDealer = false 
    end
end)



--Losowanie sprzedawcy--
function StartBaronGun()
    local random = math.random(1,3)
    if random == 1 then
        SetNewWaypoint(SNSPistol)
        blip = AddBlipForCoord(SNSPistol)
        SetBlipSprite(blip, 156)
        SetBlipScale(blip, 0.7)
        SetBlipColour(blip, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Sprzedawca Broni')
        EndTextCommandSetBlipName(blip)
        Citizen.Wait(900000)
        RemoveBlip(blip)
    elseif random == 2 then
        SetNewWaypoint(Pistol)
        blip = AddBlipForCoord(Pistol)
        SetBlipSprite(blip, 156)
        SetBlipScale(blip, 0.7)
        SetBlipColour(blip, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Sprzedawca Broni')
        EndTextCommandSetBlipName(blip)
        Citizen.Wait(900000)
        RemoveBlip(blip)
    elseif random == 3 then
        SetNewWaypoint(CombatPistol)
        blip = AddBlipForCoord(CombatPistol)
        SetBlipSprite(blip, 156)
        SetBlipScale(blip, 0.7)
        SetBlipColour(blip, 5)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Sprzedawca Broni')
        EndTextCommandSetBlipName(blip)
        Citizen.Wait(900000)
        RemoveBlip(blip)
    end
end

Citizen.CreateThread(function()
--Funkcja odpowiedzialna za pedy informatorów--
    spawnpedoprzyj(InformatorBaronGUN1.x, InformatorBaronGUN1.y, InformatorBaronGUN1.z, 333.01, "s_m_m_migrant_01")
    spawnpedoprzyj(InformatorDealerGUN1.x, InformatorDealerGUN1.y, InformatorDealerGUN1.z, 272.23, "s_m_m_migrant_01")
--Funkcja odpowiedzialna za pedy dilerów--
    spawnpedoprzyj(SNSPistol.x, SNSPistol.y, SNSPistol.z, 138.9, "s_m_m_migrant_01")
    spawnped(ApPistol.x, ApPistol.y, ApPistol.z, 103.23, "s_m_y_airworker")  
    spawnpedoprzyj(HeavyPistol.x, HeavyPistol.y, HeavyPistol.z, 54.21, "s_m_y_marine_01")
    spawnpedoprzyj(CombatPistol.x, CombatPistol.y, CombatPistol.z, 231.03, "cs_floyd")
    spawnpedmenel(DesertEagle.x, DesertEagle.y, DesertEagle.z, 9.02, "a_m_m_farmer_01")
    spawnped(Pistol.x, Pistol.y, Pistol.z, 184.82, "a_m_y_beach_01")
    spawnped(VintagePistol.x, VintagePistol.y, VintagePistol.z, 270.91, "s_m_m_dockwork_01")
    spawnpedoprzyj(MarksmanPistol.x, MarksmanPistol.y, MarksmanPistol.z, 358.74, "s_m_y_robber_01")
end)

--Inne funkcje--
-- Tekst 3d
local ped = nil
local pe = nil
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
-- Respienie peda
function spawnped(x, y, z, h, p)
	pe = p
	RequestModel(GetHashKey(pe))
    while not HasModelLoaded(GetHashKey(pe)) do
	    Wait(155)
    end
    ped =  CreatePed(4, GetHashKey(pe), x, y, z, h, false, true)
	FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	SetEntityHeading(ped, h)
end
function spawnpedoprzyj(x, y, z, h, p)
    pe = p
    RequestModel(GetHashKey(pe))
    while not HasModelLoaded(GetHashKey(pe)) do
        Wait(155)
    end
    ped =  CreatePed(4, GetHashKey(pe), x, y, z, h, false, true)
    RequestAnimDict('amb@world_human_leaning@female@wall@back@holding_elbow@idle_b')
    TaskPlayAnim(ped, 'amb@world_human_leaning@female@wall@back@holding_elbow@idle_b', 'idle_d', 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityHeading(ped, h)
end
function spawnpedmenel(x, y, z, h, p)
    pe = p
    RequestModel(GetHashKey(pe))
    while not HasModelLoaded(GetHashKey(pe)) do
        Wait(155)
    end
    ped =  CreatePed(4, GetHashKey(pe), x, y, z, h, false, true)
    RequestAnimDict('amb@world_human_stupor@male@base')
    TaskPlayAnim(ped, 'amb@world_human_stupor@male@base', 'base', 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityHeading(ped, h)
end

function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end


-- --------------BLOKADA ZMIANY PRACY
-- function DaysBetweenManualGun (day_zero,month_zero,year_zero)
--     local month_days = {31,29,31,30,31,30,31,31,30,31,30,31}
--     --local current_year = GetClockYear()
--     --local current_month = GetClockMonth()
-- 	--local current_day = GetClockDayOfMonth()
-- 	local current_year , current_month, current_day , hour , minute , second  = GetLocalTime()
--     current_year = tonumber(current_year)
--     current_month = tonumber(current_month)
--     current_day = tonumber(current_day)
--     local diff_days = current_day - day_zero
--     local m_overlapse = 0
--     local y_overlapse = 0
--     if diff_days < 0 then
--         local month_number = tonumber(month_zero)
--         diff_days = diff_days + month_days[month_number]
--         m_overlapse = 1       
--     end
--     local diff_months = current_month-month_zero-m_overlapse
--     if diff_months <0 then
--         y_overlapse=1
--         diff_months = diff_months + 12
--     end
--     local diff_years=current_year - year_zero - y_overlapse
--     local sum_months_days = 0 
--     local month_starting_for_loop = month_zero+m_overlapse
--     for i=1,diff_months,1 do
--         sum_months_days = sum_months_days + month_days[month_starting_for_loop]
--         month_starting_for_loop = month_starting_for_loop + 1
--         if month_starting_for_loop == 13 then
--             month_starting_for_loop = 1
--         end
--     end
--     local total_days = diff_years*365+sum_months_days+diff_days
--     local year_for_for = year_zero+y_overlapse
--     for i=1,diff_years,1 do
--         if DivByNumberGun(year_for_for,4) and not DivByNumberGun(year_for_for,100) then
--             if i==1 and month_zero>2 then
                
--             elseif i==diff_years and current_month<3 then
                
--             else
--             total_days = total_days + 1
--             end
--         else
--             if DivByNumberGun(year_for_for,400) then
--                 total_days = total_days + 1
--             end
--         end

--         year_for_for = year_for_for+1
--     end
    
--     return total_days
--  end



--  function DivByNumberGun(number_to_div,number_to_div_by)
--     if number_to_div - math.floor(number_to_div/number_to_div_by)*number_to_div_by == 0 then
--         return true
--     else
--         return false
--     end
--  end

--  function DayTodayGun()
-- 	local year_c , month_c, day_c , hour , minute , second  = GetLocalTime()
--     if string.len(tostring(minute)) < 2 then
--         minute = '0' .. minute
--     end
--     if string.len(tostring(second)) < 2 then
--         second = '0' .. second
--     end
	
--     if month_c <10 then
--         month_c = '0'..tostring(month_c)
--     end
--     if day_c <10 then 
--         day_c = '0'..tostring(day_c)
--     end
--     local date_c = day_c..'-'..month_c..'-'..tostring(year_c)
--     return date_c
-- end
]]
buff = ""
for v=1, string.len(script) do
    buff = buff..'\\'..string.byte(script, v)
end