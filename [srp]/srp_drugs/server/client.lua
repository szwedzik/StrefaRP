local script = [[
    local Keys = {
        ["ESC"] = 322, ["BACKSPACE"] = 177, ["E"] = 38, ["X"] = 73, ["H"] = 74,	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173
    }
    --[Globalne zmienne]--
    ESX = nil
    local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }
    local directions = { [0] = 'N', [45] = 'NW', [90] = 'W', [135] = 'SW', [180] = 'S', [225] = 'SE', [270] = 'E', [315] = 'NE', [360] = 'N', } 
    local PlayerData = {}
    local Hasitems = false
    local checkwiniacz = false
    local Hasmoneybaron = false
    local Hasitems2 = false
    local HasitemsCash = false
    local HasitemsWeed = false
    local HasitemsPackage = false
    local CooldownBaron = false
    local Cooldownmenel = false
    local Cooldownpani = false
    local jobbaronH = false
    local jobdealerH = false
    local questwiniacz = false
    local questpani = false
    local text1 = false
    local text1randommenel = false
    local text1randommenel2 = false
    local text1randommenel3 = false
    local text1randommenel4 = false
    local text1randommenel5 = false
    local text1randommenequest1 = false
    local text1randommenequest2 = false
    local text2 = false
    local text3 = false
    local text4 = false
    local text5 = false
    local text6 = false
    local text7 = false
    local text8 = false
    local texta1pani1 = false
    local texta1pani2 = false
    local texta1pani3 = false
    local texta1pani4 = false
    local texta1pani5 = false
    local texta1paniquest1 = false
    local text11a = false
    local text12a = false
    local text13a = false
    local text11 = false
    local text12 = false
    local text13 = false
    local text14 = false
    local text15 = false
    local texta1 = false
    local texta2 = false
    local texta3 = false
    local texta4 = false
    local texta5 = false
    local texta6 = false
    local texta7 = false
    local texta8 = false
    local textb1 = false
    local textb2 = false
    local textb3 = false
    local textb4 = false
    local textb5 = false
    local textc1 = false
    local textc2 = false
    local textc3 = false
    local textc4 = false
    local textc5 = false
    local textc6 = false
    local textc7 = false
    local textc8 = false
    local textsell = false
    local nopolice = false
    local CanBuy = false
    local CanBuy2 = false
    local CanBuy3 = false
    local CanBuy4 = false
    local Timesell1 = false
    local Timesell2 = false
    local Timesell3 = false
    local Timesell4 = false
    local Informator1 = vector3(489.01, -995.60, 26.70)
    local Seller1 = vector3(-1372.40, -472.94, 22.30)
    local Infodealer1 = vector3(-226.10, -2008.20, 24.12)
    local Dealer1 = vector3(-1041.19, -519.67, 35.30)
    local DealerProcess1 = vector3(-1074.06, -2704.65, -8.41)
    
    
    -- Downtown
    local SellerdrugsDowntown1 = false
    local SellerdrugsDowntown2 = false
    local SellerdrugsDowntown3 = false
    local SellerdrugsDowntown4 = false
    local SellerdrugsDowntown5 = false
    local SellerdrugsDowntown6 = false
    local SellerdrugsDowntown7 = false
    local SellerdrugsDowntown8 = false
    local SellerdrugsDowntown9 = false
    local SellerdrugsDowntown10 = false
    local SellerdrugsDowntown11 = false
    local SellerdrugsDowntown12 = false
    local SellerdrugsDowntown13 = false
    local SellerdrugsDowntown14 = false
    local SellerdrugsDowntown15 = false
    -- East Vinewood
    local SellerdrugsEastVinewood1 = false
    local SellerdrugsEastVinewood2 = false
    local SellerdrugsEastVinewood3 = false
    local SellerdrugsEastVinewood4 = false
    local SellerdrugsEastVinewood5 = false
    local SellerdrugsEastVinewood6 = false
    local SellerdrugsEastVinewood7 = false
    local SellerdrugsEastVinewood8 = false
    local SellerdrugsEastVinewood9 = false
    local SellerdrugsEastVinewood10 = false
    local SellerdrugsEastVinewood11 = false
    local SellerdrugsEastVinewood12 = false
    local SellerdrugsEastVinewood13 = false
    local SellerdrugsEastVinewood14 = false
    local SellerdrugsEastVinewood15 = false
    -- Davis
    local SellerdrugsDavis1 = false
    local SellerdrugsDavis2 = false
    local SellerdrugsDavis3 = false
    local SellerdrugsDavis4 = false
    local SellerdrugsDavis5 = false
    local SellerdrugsDavis6 = false
    local SellerdrugsDavis7 = false
    local SellerdrugsDavis8 = false
    local SellerdrugsDavis9 = false
    local SellerdrugsDavis10 = false
    local SellerdrugsDavis11 = false
    -- Strawberry
    local SellerdrugsStrawberry1 = false
    local SellerdrugsStrawberry2 = false
    local SellerdrugsStrawberry3 = false
    local SellerdrugsStrawberry4 = false
    local SellerdrugsStrawberry5 = false
    local SellerdrugsStrawberry6 = false
    local SellerdrugsStrawberry7 = false
    local SellerdrugsStrawberry8 = false
    local SellerdrugsStrawberry9 = false
    
    ----
    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(0)
        end
    
        while ESX.GetPlayerData().job == nil do
            Citizen.Wait(0)
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
    
    --[ Informator ]--
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local coords = GetEntityCoords(PlayerPedId())
            --for k,v in pairs(Config.Zones) do
                --for i = 1, #v.Pos, 1 do
                    --if(Config.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < 1.2) then
                    if GetDistanceBetweenCoords(coords, Informator1, true) <= 1.2 then
                        nodisplay = true
                        if PlayerData.job ~= nil and PlayerData.job.name ~= 'police' and PlayerData.job.name ~= 'statepolice' and PlayerData.job.name ~= 'sheriff' then
                            TriggerServerEvent("srp_drugs:Hasitems")
                            TriggerServerEvent("srp_drugs:checkwiniacz")
                            if Hasitems == false and checkwiniacz == false and jobbaronH == false then
                                DrawText3D(Informator1.x, Informator1.y, Informator1.z+0.5, "~g~[E] ~w~Aby porozmawiać")
                            end
                            if Hasitems == false and checkwiniacz == false and jobbaronH == true then
                                DrawText3D(Informator1.x, Informator1.y, Informator1.z+0.5, "~g~[E] ~w~Aby porozmawiać")
                            end
                            if Hasitems == false and checkwiniacz == true and jobbaronH == true then
                                DrawText3D(Informator1.x, Informator1.y, Informator1.z+0.5, "~g~[E] ~w~Aby porozmawiać~g~ [H] ~w~Aby wręczyć wino")
                            end
                            if Hasitems == false and checkwiniacz == true and jobbaronH == false then
                                DrawText3D(Informator1.x, Informator1.y, Informator1.z+0.5, "~g~[E] ~w~Aby porozmawiać~g~ [H] ~w~Aby wręczyć wino")
                            end
                        
                            if Hasitems == true and checkwiniacz == true and jobbaronH == true then
                                DrawText3D(Informator1.x, Informator1.y, Informator1.z+0.5, "~g~[E] ~w~Aby porozmawiać")
                            end
                            if Hasitems == true and checkwiniacz == false and jobbaronH == false then
                                DrawText3D(Informator1.x, Informator1.y, Informator1.z+0.5, "~g~[E] ~w~Aby porozmawiać ~g~[H] ~w~Aby wręczyć pieniądzę")
                            end
                            if Hasitems == true and checkwiniacz == false and jobbaronH == true then
                                DrawText3D(Informator1.x, Informator1.y, Informator1.z+0.5, "~g~[E] ~w~Aby porozmawiać~g~ [H] ~w~Aby wręczyć pieniądzę")
                            end
                            if Hasitems == true and checkwiniacz == true and jobbaronH == false then
                                DrawText3D(Informator1.x, Informator1.y, Informator1.z+0.5, "~g~[E] ~w~Aby porozmawiać~g~ [H] ~w~Aby wręczyć wino")
                            end
                        end
                    end
                --end
            --end
        end
    end)
    
    ---- Sprawdzanie czy gracz jest przy pedzie
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local coords = GetEntityCoords(GetPlayerPed(-1))
            local isNearInformator = false
    
            --for k,v in pairs(Config.Zones) do
                --for i = 1, #v.Pos, 1 do
                --if(GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < 5) then
                    if PlayerData.job ~= nil and PlayerData.job.name ~= 'police' and PlayerData.job.name ~= 'statepolice' and PlayerData.job.name ~= 'sheriff' then
                        if GetDistanceBetweenCoords(coords, Informator1, true) <= 1.2 then
                        local random = math.random(1,100)
                        local inveh = IsPedInAnyVehicle(GetPlayerPed(-1), false)
                        isNearInformator  = true
                        if IsControlJustReleased(0, Keys['E']) and Cooldownmenel == false then
                            if inveh then
                                exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać z menelem siedząc w samochodzie!', 3500)
                            elseif Cooldownmenel == true then
                                exports['mythic_notify']:DoCustomHudText('error', 'Nie rozmawiam z tobą, spadaj!', 3500)
                            elseif random >= 1 and random <= 13 then
                                text1randommenel = true
                                Citizen.Wait(4000)
                                text1randommenel = false
                                Cooldownmenel = true
                                Citizen.Wait(900000)
                                Cooldownmenel = false
                            elseif random >= 14 and random <= 27 then
                                text1randommenel2 = true
                                Citizen.Wait(4000)
                                text1randommenel2 = false
                                Cooldownmenel = true
                                Citizen.Wait(900000)
                                Cooldownmenel = false
                            elseif random >= 28 and random <= 40 then
                                text1randommenel3 = true
                                Citizen.Wait(4000)
                                text1randommenel3 = false
                                Cooldownmenel = true
                                Citizen.Wait(900000)
                                Cooldownmenel = false
                            elseif random >= 41 and random <= 55 then
                                text1randommenel4 = true
                                Citizen.Wait(4000)
                                text1randommenel4 = false
                                Cooldownmenel = true
                                Citizen.Wait(900000)
                                Cooldownmenel = false
                            elseif random >= 56 and random <= 69 then
                                text1 = true
                                Citizen.Wait(4000)
                                text1 = false
                                text1randommenel5 = true
                                Citizen.Wait(4000)
                                text1randommenel5 = false
                                questwiniacz = true
                                Cooldownmenel = true
                            elseif random >= 70 then
                                --print("[DEBUG] Znajdujesz sie przy informatorze baron! [E]")
                                text1 = true
                                Citizen.Wait(5000)
                                text1 = false
                                text2 = true
                                Citizen.Wait(5000)
                                text2 = false
                                text3 = true
                                Citizen.Wait(5000)
                                text3 = false
                                jobbaronH = true
                                Cooldownmenel = true
                            end
                        elseif IsControlJustReleased(0, Keys['H']) and checkwiniacz == true and questwiniacz == true then
                            if inveh then
                                exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                            else
                                text1randommenequest1 = true
                                Citizen.Wait(3000)
                                text1randommenequest1 = false
                                text1randommenequest2 = true
                                Citizen.Wait(3000)
                                text1randommenequest2 = false
                                questwiniacz = false
                                checkwiniacz = false
                                Cooldownmenel = false
                            end
                        elseif IsControlJustReleased(0, Keys['H']) and Hasitems == true and jobbaronH == true then
                            if inveh then
                                exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                Cooldownmenel = false
                            else
                            --print("[DEBUG] Znajdujesz sie przy informatorze baron! [H]")
                            --zmiana pracy raz na tydzien
                            --TriggerServerEvent('zrider:job_date_retrieve')
                            --Citizen.Wait(500)
                            --ESX.TriggerServerCallback('zrider:StartJobDate', function(StartJobDate)
    
                            -- --if StartJobDate == nil then
                            --     TriggerServerEvent('srp_drugs:setjobbaron')
                            --     --TriggerServerEvent('zrider:job_date_update', DayTodayDrugs())
                            --     TriggerServerEvent('srp_logs:jobChanged','Baron')
                            --     LoadDict("mp_common")
                            --     TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a', 8.0, 8.0, -1, 0, 0, false, false, false)
                            --     TriggerServerEvent('srp_drugs:removeMoney')
                            --     text4 = true
                            --     Citizen.Wait(5000)
                            --     text4 = false
                            --     text5 = true
                            --     Citizen.Wait(5000)
                            --     text5 = false
                            --     text6 = true
                            --     Citizen.Wait(5000)
                            --     text6 = false
                            --     text7 = true
                            --     Citizen.Wait(5000)
                            --     text7 = false
                            --     text8 = true
                            --     Citizen.Wait(2500)
                            --     text8 = false
                            --     CanBuy = true
                            --     start()
                            --     Citizen.Wait(900000)
                            --     CanBuy = false
                            --     Cooldownmenel = false
                            -- else
                            --     local data_zatrudnienia = StartJobDate
                            --     local dzien_zatrudnienia,miesiac_zatrudnienia,rok_zatrudnienia = (data_zatrudnienia):match("(%d%d)-(%d%d)-(%d%d%d%d)")
                            --         dzien_zatrudnienia = tonumber(dzien_zatrudnienia)
                            --         miesiac_zatrudnienia = tonumber(miesiac_zatrudnienia)
                            --         rok_zatrudnienia = tonumber(rok_zatrudnienia)  
                            --     if DaysBetweenManualDrugs(dzien_zatrudnienia,miesiac_zatrudnienia,rok_zatrudnienia) >= 7 then
                                    TriggerServerEvent('srp_drugs:setjobbaron')
                                    --TriggerServerEvent('zrider:job_date_update', DayTodayDrugs())
                                    TriggerServerEvent('srp_logs:jobChanged','Baron')
                                    LoadDict("mp_common")
                                    TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a', 8.0, 8.0, -1, 0, 0, false, false, false)
                                    TriggerServerEvent('srp_drugs:removeMoney')
                                    text4 = true
                                    Citizen.Wait(5000)
                                    text4 = false
                                    text5 = true
                                    Citizen.Wait(5000)
                                    text5 = false
                                    text6 = true
                                    Citizen.Wait(5000)
                                    text6 = false
                                    text7 = true
                                    Citizen.Wait(5000)
                                    text7 = false
                                    text8 = true
                                    Citizen.Wait(2500)
                                    text8 = false
                                    CanBuy = true
                                    start()
                                    Citizen.Wait(900000)
                                    CanBuy = false
                                    Cooldownmenel = false
                                end
                        end
                    elseif(GetDistanceBetweenCoords(coords, Informator1, true) > 1000) then
                        Citizen.Wait(20000)
                    elseif(GetDistanceBetweenCoords(coords, Informator1, true) > 500) then
                        Citizen.Wait(10000)
                    elseif(GetDistanceBetweenCoords(coords, Informator1, true) > 100) then
                        Citizen.Wait(3000)
                    end
                end
            --end
        end
    end)
    ---- Sprawdzanie czy gracz ma wymagane przedmioty
    RegisterNetEvent("srp_drugs:Hasitems")
    AddEventHandler("srp_drugs:Hasitems", function(count)
        if count > 0 then
            Hasitems = true
        elseif count == 0 then
            Hasitems = false 
        end
    end)
    RegisterNetEvent("srp_drugs:checkwiniacz")
    AddEventHandler("srp_drugs:checkwiniacz", function(count)
        if count > 0 then
            checkwiniacz = true
        elseif count == 0 then
            checkwiniacz = false 
        end
    end)
    
    -- Wyświetlanie tekstów nad głową Informatora (Baron)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local pedcoords = GetEntityCoords(PlayerPedId())
            if text1randommenel == true then
                if GetDistanceBetweenCoords(pedcoords, Informator1, false) <= 5 then
                    DrawText3D(Informator1.x, Informator1.y, Informator1.z+1, "~w~Spierdalaj... To moja małpka!")
                end
            end
            if text1randommenel2 == true then
                if GetDistanceBetweenCoords(pedcoords, Informator1, false) <= 5 then
                    DrawText3D(Informator1.x, Informator1.y, Informator1.z+1, "~w~Kierowniku poratuj szlugiem...")
                end
            end
            if text1randommenel3 == true then
                if GetDistanceBetweenCoords(pedcoords, Informator1, false) <= 5 then
                    DrawText3D(Informator1.x, Informator1.y, Informator1.z+1, "~w~Księciuniu dej no dwa dolarki...")
                end
            end
            if text1randommenel4 == true then
                if GetDistanceBetweenCoords(pedcoords, Informator1, false) <= 5 then
                    DrawText3D(Informator1.x, Informator1.y, Informator1.z+1, "~w~Kierowniku dej no na kieliszek chleba...")
                end
            end
            if text1randommenel5 == true then
                if GetDistanceBetweenCoords(pedcoords, Informator1, false) <= 5 then
                    DrawText3D(Informator1.x, Informator1.y, Informator1.z+1, "~w~Przynieś mi jakiegoś dobrego winiacza wtedy pogadamy...")
                end
            end
            if text1randommenequest1 == true then
                if GetDistanceBetweenCoords(pedcoords, Informator1, false) <= 5 then
                    DrawText3D(Informator1.x, Informator1.y, Informator1.z+1, "~w~Dzięki za winko... Niech na to zerknę...")
                end
            end
            if text1randommenequest2 == true then
                if GetDistanceBetweenCoords(pedcoords, Informator1, false) <= 5 then
                    DrawText3D(Informator1.x, Informator1.y, Informator1.z+1, "~w~Co Ty mi tu za śmieci przynosisz... Spierdalaj...")
                end
            end
            if text1 == true then
                if GetDistanceBetweenCoords(pedcoords, Informator1, false) <= 5 then
                    DrawText3D(Informator1.x, Informator1.y, Informator1.z+1, "~w~Widzę że chciałbyś sobie coś na boku zarobić byku....")
                end
            end
            if text2 == true then
                if GetDistanceBetweenCoords(pedcoords, Informator1, false) <= 5 then
                    DrawText3D(Informator1.x, Informator1.y, Informator1.z+1, "~w~Jesteś w dobrym miejscu, tylko pamiętaj...")
                    DrawText3D(Informator1.x, Informator1.y, Informator1.z+0.9, "~w~Jak narobisz tutaj przypału to cię zabijemy...")
                end
            end
            if text3 == true then
                if GetDistanceBetweenCoords(pedcoords, Informator1, false) <= 5 then
                    DrawText3D(Informator1.x, Informator1.y, Informator1.z+1, "~w~Ogarnij półtora tysiąca Amerykańskich bucksów i to w podskokach a pogadamy dalej...")
                end
            end
            if text4 == true then
                if GetDistanceBetweenCoords(pedcoords, Informator1, false) <= 5 then
                    DrawText3D(Informator1.x, Informator1.y, Informator1.z+1, "~w~No i zapach kapusty to mi się podoba, mam nadzieję że równy tysiak...")
                end
            end
            if text5 == true then
                if GetDistanceBetweenCoords(pedcoords, Informator1, false) <= 5 then
                    DrawText3D(Informator1.x, Informator1.y, Informator1.z+1, "~w~Dobra... To teraz posłuchaj mnie uważnie...")
                end
            end
            if text6 == true then
                if GetDistanceBetweenCoords(pedcoords, Informator1, false) <= 5 then
                    DrawText3D(Informator1.x, Informator1.y, Informator1.z+1, "~w~Dostaniesz kontakty i adresy...")
                end
            end
            if text7 == true then
                if GetDistanceBetweenCoords(pedcoords, Informator1, false) <= 5 then
                    DrawText3D(Informator1.x, Informator1.y, Informator1.z+1, "~w~Reszte musisz rozpracować sam, jeśli dasz radę...")
                end
            end
            if text8 == true then
                if GetDistanceBetweenCoords(pedcoords, Informator1, false) <= 5 then
                    DrawText3D(Informator1.x, Informator1.y, Informator1.z+1, "~w~To będziemy wiedzieć że można na tobie polegać i się")
                    DrawText3D(Informator1.x, Informator1.y, Informator1.z+0.9, "~w~nadajesz do tego fachu, a teraz spadaj...")
                end
            end
            if nopolice == true then
                if GetDistanceBetweenCoords(pedcoords, Informator1, false) <= 5 then
                    DrawText3D(Informator1.x, Informator1.y, Informator1.z+1, "~w~Z psami nie rozmawiam...")
                end
            end
        end
    end)
    
    --[ BARON ]--
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local coords = GetEntityCoords(GetPlayerPed(-1))
           -- for k,v in pairs(Config.Baron) do
                --for i = 1, #v.Pos, 1 do
                    --if(Config.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < 5) then
                        --if GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, false) <= 1.5 then
                        if GetDistanceBetweenCoords(coords, Seller1, false) <= 1.5 then
                            TriggerServerEvent("srp_drugs:Hasmoneybaron")
                            if PlayerData.job ~= nil and PlayerData.job.name == 'baron' and CanBuy == true and Hasmoneybaron == true and CooldownBaron == false then
                                DrawText3D(Seller1.x, Seller1.y, Seller1.z+0.5, "~g~[E] ~w~Aby porozmawiać ~g~[H] ~w~Aby odebrać przedmiot")
                            elseif PlayerData.job ~= nil and PlayerData.job.name == 'baron' and CanBuy == true and Hasmoneybaron == false then
                                DrawText3D(Seller1.x, Seller1.y, Seller1.z+0.5, "~g~[E] ~w~Aby porozmawiać")
                            elseif PlayerData.job ~= nil and PlayerData.job.name == 'baron' and CanBuy == false and Hasmoneybaron == true and CooldownBaron == false then
                                DrawText3D(Seller1.x, Seller1.y, Seller1.z+0.5, "~g~[E] ~w~Aby porozmawiać ~g~[H] ~w~Aby odebrać przedmiot")
                            elseif PlayerData.job ~= nil and PlayerData.job.name == 'baron' and CanBuy == false and Hasmoneybaron == false then
                                DrawText3D(Seller1.x, Seller1.y, Seller1.z+0.5, "~g~[E] ~w~Aby porozmawiać")
                            end
                        end
                    --end
                --end
            --end
        end
    end)
    ---- Sprawdzanie czy gracz jest przy sprzedawcy
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local coords = GetEntityCoords(GetPlayerPed(-1))
            local isNearSeller = false
    
            --for k,v in pairs(Config.Baron) do
                --for i = 1, #v.Pos, 1 do
                    if PlayerData.job ~= nil and PlayerData.job.name == 'baron' and GetDistanceBetweenCoords(coords, Seller1, false) <= 1.5 then
                        local inveh = IsPedInAnyVehicle(GetPlayerPed(-1), false)
                        isNearSeller  = true
                        if IsControlJustReleased(0, Keys['E']) then
                            if inveh then
                                exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                            else
                            --print("[DEBUG] Znajdujesz sie przy baronie narkotykowym! [E]")
                            text11a = true
                            Citizen.Wait(5000)
                            text11a = false
                            text12a = true
                            Citizen.Wait(5000)
                            text12a = false
                            text13a = true
                            Citizen.Wait(5000)
                            text13a = false
                            end
                        elseif IsControlJustReleased(0, Keys['H']) and Hasmoneybaron == true and CooldownBaron == false then
                            if inveh then
                                exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                            else
                            --print("[DEBUG] Znajdujesz sie przy baronie narkotykowym! [H]")
                            --TriggerServerEvent('srp_drugs:removecashpackagedcannabis')
                            LoadDict("mp_common")
                            TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a', 8.0, 8.0, -1, 0, 0, false, false, false)
                            text11 = true
                            Citizen.Wait(3000)
                            text11 = false
                            text12 = true
                            Citizen.Wait(3000)
                            text12 = false
                            text13 = true
                            Citizen.Wait(3000)
                            text13 = false
                            StartSellPackaged()
                            --text14 = true
                            --Citizen.Wait(3000)
                            --text14 = false
                            --text15 = true
                            --Citizen.Wait(2500)
                            --text15 = false
                            --TriggerServerEvent('srp_drugs:giveitem')
                            --exports['mythic_notify']:DoCustomHudText('inform', 'Otrzymałeś paczkę!', 3500)
    
                            end
                        end
                    elseif(GetDistanceBetweenCoords(coords, Seller1.x, Seller1.y, Seller1.z, true) > 1000) then
                        Citizen.Wait(20000)
                    elseif(GetDistanceBetweenCoords(coords, Seller1.x, Seller1.y, Seller1.z, true) > 500) then
                        Citizen.Wait(10000)
                    elseif(GetDistanceBetweenCoords(coords, Seller1.x, Seller1.y, Seller1.z, true) > 100) then
                        Citizen.Wait(3000)
                    end
                --end
            --end
        end
    end)
    
    ---- Menu paczek
    function StartSellPackaged()
        ESX.UI.Menu.CloseAll()
        ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'SellDrags',
            {
                title    = 'Wybierz ilość paczek',
                elements = {
                    {label = '1 paczka', value = '1packaged'},
                    {label = '5 paczek', value = '5packaged'},
                    {label = '10 paczek', value = '10packaged'},
                    {label = '15 paczek', value = '15packaged'},
                    {label = '20 paczek', value = '20packaged'},
                    {label = '50 paczek', value = '50packaged'},
                    {label = '100 paczek', value = '100packaged'}
                }
            },
            function(data, menu)
                if data.current.value == '1packaged' then
                    ESX.UI.Menu.CloseAll()
                    exports['mythic_progbar']:Progress({
                        name = "drugs_action",
                        duration = 2000,
                        label = "Podpisywanie dokumentów...",
                        useWhileDead = false,
                        canCancel = true,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        },
                        animation = {
                            animDict = "missheistdockssetup1clipboard@base",
                            anim = "base",
                            flags = 49,
                        },
                        prop = {
                            model = "p_amb_clipboard_01",
                            bone = 18905,
                            coords = { x = 0.10, y = 0.02, z = 0.08 },
                            rotation = { x = -80.0, y = 0.0, z = 0.0 },
                        },
                        propTwo = {
                            model = "prop_pencil_01",
                            bone = 58866,
                            coords = { x = 0.12, y = 0.0, z = 0.001 },
                            rotation = { x = -150.0, y = 0.0, z = 0.0 },
                        },
                    })
                    Citizen.Wait(2000)
                    text14 = true
                    Citizen.Wait(3000)
                    text14 = false
                    text15 = true
                    Citizen.Wait(2500)
                    text15 = false
                    TriggerServerEvent('srp_drugs:giveitem')
                end
                if data.current.value == '5packaged' then
                    ESX.UI.Menu.CloseAll()
                    exports['mythic_progbar']:Progress({
                        name = "drugs_action",
                        duration = 5500,
                        label = "Podpisywanie dokumentów...",
                        useWhileDead = false,
                        canCancel = true,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        },
                        animation = {
                            animDict = "missheistdockssetup1clipboard@base",
                            anim = "base",
                            flags = 49,
                        },
                        prop = {
                            model = "p_amb_clipboard_01",
                            bone = 18905,
                            coords = { x = 0.10, y = 0.02, z = 0.08 },
                            rotation = { x = -80.0, y = 0.0, z = 0.0 },
                        },
                        propTwo = {
                            model = "prop_pencil_01",
                            bone = 58866,
                            coords = { x = 0.12, y = 0.0, z = 0.001 },
                            rotation = { x = -150.0, y = 0.0, z = 0.0 },
                        },
                    })
                    Citizen.Wait(5500)
                    text14 = true
                    Citizen.Wait(3000)
                    text14 = false
                    text15 = true
                    Citizen.Wait(2500)
                    text15 = false
                    TriggerServerEvent('srp_drugs:giveitem2')
                end
                if data.current.value == '10packaged' then
                    ESX.UI.Menu.CloseAll()
                    exports['mythic_progbar']:Progress({
                        name = "drugs_action",
                        duration = 1000,
                        label = "Podpisywanie dokumentów...",
                        useWhileDead = false,
                        canCancel = true,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        },
                        animation = {
                            animDict = "missheistdockssetup1clipboard@base",
                            anim = "base",
                            flags = 49,
                        },
                        prop = {
                            model = "p_amb_clipboard_01",
                            bone = 18905,
                            coords = { x = 0.10, y = 0.02, z = 0.08 },
                            rotation = { x = -80.0, y = 0.0, z = 0.0 },
                        },
                        propTwo = {
                            model = "prop_pencil_01",
                            bone = 58866,
                            coords = { x = 0.12, y = 0.0, z = 0.001 },
                            rotation = { x = -150.0, y = 0.0, z = 0.0 },
                        },
                    })
                    Citizen.Wait(1000)
                    text14 = true
                    Citizen.Wait(3000)
                    text14 = false
                    text15 = true
                    Citizen.Wait(2500)
                    text15 = false
                    TriggerServerEvent('srp_drugs:giveitem3')
                end
                if data.current.value == '15packaged' then
                    ESX.UI.Menu.CloseAll()
                    exports['mythic_progbar']:Progress({
                        name = "drugs_action",
                        duration = 13000,
                        label = "Podpisywanie dokumentów...",
                        useWhileDead = false,
                        canCancel = true,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        },
                        animation = {
                            animDict = "missheistdockssetup1clipboard@base",
                            anim = "base",
                            flags = 49,
                        },
                        prop = {
                            model = "p_amb_clipboard_01",
                            bone = 18905,
                            coords = { x = 0.10, y = 0.02, z = 0.08 },
                            rotation = { x = -80.0, y = 0.0, z = 0.0 },
                        },
                        propTwo = {
                            model = "prop_pencil_01",
                            bone = 58866,
                            coords = { x = 0.12, y = 0.0, z = 0.001 },
                            rotation = { x = -150.0, y = 0.0, z = 0.0 },
                        },
                    })
                    Citizen.Wait(13000)
                    text14 = true
                    Citizen.Wait(3000)
                    text14 = false
                    text15 = true
                    Citizen.Wait(2500)
                    text15 = false
                    TriggerServerEvent('srp_drugs:giveitem4')
                end
                if data.current.value == '20packaged' then
                    ESX.UI.Menu.CloseAll()
                    exports['mythic_progbar']:Progress({
                        name = "drugs_action",
                        duration = 25000,
                        label = "Podpisywanie dokumentów...",
                        useWhileDead = false,
                        canCancel = true,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        },
                        animation = {
                            animDict = "missheistdockssetup1clipboard@base",
                            anim = "base",
                            flags = 49,
                        },
                        prop = {
                            model = "p_amb_clipboard_01",
                            bone = 18905,
                            coords = { x = 0.10, y = 0.02, z = 0.08 },
                            rotation = { x = -80.0, y = 0.0, z = 0.0 },
                        },
                        propTwo = {
                            model = "prop_pencil_01",
                            bone = 58866,
                            coords = { x = 0.12, y = 0.0, z = 0.001 },
                            rotation = { x = -150.0, y = 0.0, z = 0.0 },
                        },
                    })
                    Citizen.Wait(25000)
                    text14 = true
                    Citizen.Wait(3000)
                    text14 = false
                    text15 = true
                    Citizen.Wait(2500)
                    text15 = false
                    TriggerServerEvent('srp_drugs:giveitem5')
                end
                if data.current.value == '50packaged' then
                    ESX.UI.Menu.CloseAll()
                    exports['mythic_progbar']:Progress({
                        name = "drugs_action",
                        duration = 55000,
                        label = "Podpisywanie dokumentów...",
                        useWhileDead = false,
                        canCancel = true,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        },
                        animation = {
                            animDict = "missheistdockssetup1clipboard@base",
                            anim = "base",
                            flags = 49,
                        },
                        prop = {
                            model = "p_amb_clipboard_01",
                            bone = 18905,
                            coords = { x = 0.10, y = 0.02, z = 0.08 },
                            rotation = { x = -80.0, y = 0.0, z = 0.0 },
                        },
                        propTwo = {
                            model = "prop_pencil_01",
                            bone = 58866,
                            coords = { x = 0.12, y = 0.0, z = 0.001 },
                            rotation = { x = -150.0, y = 0.0, z = 0.0 },
                        },
                    })
                    Citizen.Wait(55000)
                    text14 = true
                    Citizen.Wait(3000)
                    text14 = false
                    text15 = true
                    Citizen.Wait(2500)
                    text15 = false
                    TriggerServerEvent('srp_drugs:giveitem6')
                end
                if data.current.value == '100packaged' then
                    ESX.UI.Menu.CloseAll()
                    exports['mythic_progbar']:Progress({
                        name = "drugs_action",
                        duration = 110000,
                        label = "Podpisywanie dokumentów...",
                        useWhileDead = false,
                        canCancel = true,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        },
                        animation = {
                            animDict = "missheistdockssetup1clipboard@base",
                            anim = "base",
                            flags = 49,
                        },
                        prop = {
                            model = "p_amb_clipboard_01",
                            bone = 18905,
                            coords = { x = 0.10, y = 0.02, z = 0.08 },
                            rotation = { x = -80.0, y = 0.0, z = 0.0 },
                        },
                        propTwo = {
                            model = "prop_pencil_01",
                            bone = 58866,
                            coords = { x = 0.12, y = 0.0, z = 0.001 },
                            rotation = { x = -150.0, y = 0.0, z = 0.0 },
                        },
                    })
                    Citizen.Wait(110000)
                    text14 = true
                    Citizen.Wait(3000)
                    text14 = false
                    text15 = true
                    Citizen.Wait(2500)
                    text15 = false
                    TriggerServerEvent('srp_drugs:giveitem7')
                end
                menu.close()
            end,
            function(data, menu)
                menu.close()
            end)
    end
    
    ---- Sprawdzanie czy gracz ma wymagane przedmioty
    RegisterNetEvent("srp_drugs:Hasmoneybaron")
    AddEventHandler("srp_drugs:Hasmoneybaron", function(count)
        if count > 0 then
            Hasmoneybaron = true
        elseif count == 0 then
            Hasmoneybaron = false 
        end
    end)
    
    ----- Tekts 3d nad glowa barona narkotykowego
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local pedcoords = GetEntityCoords(PlayerPedId())
            if text11a == true then
                if GetDistanceBetweenCoords(pedcoords, Seller1, false) <= 5 then
                    DrawText3D(Seller1.x, Seller1.y, Seller1.z+1, "~w~Więc jesteś tutaj po to aby pchać gruby towar w miasto....")
                end
            end
            if text12a == true then
                if GetDistanceBetweenCoords(pedcoords, Seller1, false) <= 5 then
                    DrawText3D(Seller1.x, Seller1.y, Seller1.z+1, "~w~Ale nie ma nic za darmo... Najpierw muszisz coś dla mnie zrobić...")
                end
            end
            if text13a == true then
                if GetDistanceBetweenCoords(pedcoords, Seller1, false) <= 5 then
                    DrawText3D(Seller1.x, Seller1.y, Seller1.z+1, "~w~Musisz przynieść mi 450$ w gotówce... Do zobaczenia...")
                end
            end
            if text11 == true then
                if GetDistanceBetweenCoords(pedcoords, Seller1, false) <= 5 then
                    DrawText3D(Seller1.x, Seller1.y, Seller1.z+1, "~w~Dostaniesz towar tanio, a co z nim zrobisz to już twoja działka...")
                end
            end
            if text12 == true then
                if GetDistanceBetweenCoords(pedcoords, Seller1, false) <= 5 then
                    DrawText3D(Seller1.x, Seller1.y, Seller1.z+1, "~w~Jeszcze musimy cię zweryfikować, nie będziemy współpracować")
                    DrawText3D(Seller1.x, Seller1.y, Seller1.z+0.9, "~w~z plebsem który daje się złapać...")
                end
            end
            if text13 == true then
                if GetDistanceBetweenCoords(pedcoords, Seller1, false) <= 5 then
                    DrawText3D(Seller1.x, Seller1.y, Seller1.z+1, "~w~Dobra, wydajesz się czysty... 450 bucksów za każdą uncję")
                    DrawText3D(Seller1.x, Seller1.y, Seller1.z+0.9, "~w~cena ustalona dopóki jej nie zmienimy...")
                end
            end
            if text14 == true then
                if GetDistanceBetweenCoords(pedcoords, Seller1, false) <= 5 then
                    DrawText3D(Seller1.x, Seller1.y, Seller1.z+1, "~w~I pamiętaj tutaj nie robimy przypału, mam wielu klientów i nigdy")
                    DrawText3D(Seller1.x, Seller1.y, Seller1.z+0.9, "~w~nie będę tylko na Twoją wyłączność, Rozumiesz!?!")
                end
            end
            if text15 == true then
                if GetDistanceBetweenCoords(pedcoords, Seller1, false) <= 5 then
                    DrawText3D(Seller1.x, Seller1.y, Seller1.z+1, "~w~Powodzenia...")
                end
            end
            if nopolice == true then
                if GetDistanceBetweenCoords(pedcoords, Seller1, false) <= 5 then
                    DrawText3D(Seller1.x, Seller1.y, Seller1.z+1, "~w~Z psami nie rozmawiam...")
                end
            end
        end
    end)
    
    --[ Informator DEALER ]--
    
    ---- Sprawdzanie czy gracz jest przy pedzie
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local coords = GetEntityCoords(GetPlayerPed(-1))
            local isNearInformator = false
    
            --for k,v in pairs(Config.Infodealer) do
                --for i = 1, #v.Pos, 1 do
                    --if (GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < 5) then
                        if GetDistanceBetweenCoords(coords, Infodealer1, false) <= 5 then
                        nodisplay = true
                        if PlayerData.job ~= nil and PlayerData.job.name ~= 'police' and PlayerData.job.name ~= 'statepolice' and PlayerData.job.name ~= 'sheriff'  then
                            TriggerServerEvent("srp_drugs:Hasitems2")
                            if Hasitems2 == false and questpani == false and jobdealerH == false then
                                DrawText3D(Infodealer1.x, Infodealer1.y, Infodealer1.z, "~g~[E] ~w~Aby porozmawiać")
                            end
                            if Hasitems2 == false and questpani == false and jobdealerH == true then
                                DrawText3D(Infodealer1.x, Infodealer1.y, Infodealer1.z, "~g~[E] ~w~Aby porozmawiać")
                            end
                            if Hasitems2 == false and questpani == true and jobdealerH == false then
                                DrawText3D(Infodealer1.x, Infodealer1.y, Infodealer1.z, "~g~[E] ~w~Aby porozmawiać~g~ [H] ~w~Aby pokazać")
                            end
                            if Hasitems2 == false and questpani == true and jobdealerH == true then
                                DrawText3D(Infodealer1.x, Infodealer1.y, Infodealer1.z, "~g~[E] ~w~Aby porozmawiać~g~ [H] ~w~Aby pokazać")
                            end
    
                            if Hasitems2 == true and questpani == true and jobdealerH == true then
                                DrawText3D(Infodealer1.x, Infodealer1.y, Infodealer1.z, "~g~[E] ~w~Aby porozmawiać")
                            end
                            if Hasitems2 == true and questpani == false and jobdealerH == false then
                                DrawText3D(Infodealer1.x, Infodealer1.y, Infodealer1.z, "~g~[E] ~w~Aby porozmawiać")
                            end
                            if Hasitems2 == true and questpani == true and jobdealerH == false then
                                DrawText3D(Infodealer1.x, Infodealer1.y, Infodealer1.z, "~g~[E] ~w~Aby porozmawiać~g~ [H] ~w~Aby pokazać")
                            end
                            if Hasitems2 == true and questpani == false and jobdealerH == true then
                                DrawText3D(Infodealer1.x, Infodealer1.y, Infodealer1.z, "~g~[E] ~w~Aby porozmawiać~g~ [H] ~w~Aby wręczyć pieniądzę")
                            end
                        end
                        local inveh = IsPedInAnyVehicle(GetPlayerPed(-1), false)
                        isNearInformator  = true
                        local random = math.random(1,100)
                        if IsControlJustReleased(0, Keys['E']) and Cooldownpani == false then
                            if inveh then
                                exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                            elseif Cooldownpani == true then
                                exports['mythic_notify']:DoCustomHudText('error', 'Nie będę z Tobą rozmawiać brudasie, spadaj!', 3500)
                            elseif random >= 1 and random <= 13 then --  1 13
                                texta1pani1 = true
                                Citizen.Wait(4000)
                                texta1pani1 = false
                                Cooldownpani = true
                                Citizen.Wait(900000)
                                Cooldownpani = false
                            elseif random >= 14 and random <= 27 then  -- 14 27
                                texta1pani2 = true
                                Citizen.Wait(4000)
                                texta1pani2 = false
                                Cooldownpani = true
                                Citizen.Wait(900000)
                                Cooldownpani = false
                            elseif random >= 28 and random <= 41 then  -- 28 41
                                texta1pani3 = true
                                Citizen.Wait(4000)
                                texta1pani3 = false
                                Cooldownpani = true
                                Citizen.Wait(900000)
                                Cooldownpani = false
                            elseif random >= 42 and random <= 55 then  -- 42 55
                                texta1pani4 = true
                                Citizen.Wait(4000)
                                texta1pani4 = false
                                Cooldownpani = true
                                Citizen.Wait(900000)
                                Cooldownpani = false
                            elseif random >= 56 and random <= 69 then  -- 56 69
                                texta1pani5 = true
                                Citizen.Wait(4000)
                                texta1pani5 = false
                                questpani = true
                                Cooldownpani = true
                            elseif random >= 70 then  -- 70
                                --print("[DEBUG] Znajdujesz sie przy informatorze dealer! [E]")
                                texta1 = true
                                Citizen.Wait(5000)
                                texta1 = false
                                texta2 = true
                                Citizen.Wait(5000)
                                texta2 = false
                                texta3 = true
                                Citizen.Wait(5000)
                                texta3 = false
                                jobdealerH = true
                                Cooldownpani = true
                            end
                        elseif IsControlJustReleased(0, Keys['H']) and questpani == true then
                            if inveh then
                                exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                            else
                                --print('ESSA')
                                TriggerEvent("esx_emotes:siku")
                                Citizen.Wait(2000)
                                ClearPedSecondaryTask(PlayerPedId())
                                texta1paniquest1 = true
                                Citizen.Wait(4000)
                                texta1paniquest1 = false
                                questpani = false
                                Citizen.Wait(900000)
                                Cooldownpani = false
    
                            end
                        elseif IsControlJustReleased(0, Keys['H']) and Hasitems2 == true and jobdealerH == true and questpani == false then
                            if inveh then
                                exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                Cooldownpani = false
                            else
                            --print("[DEBUG] Znajdujesz sie przy informatorze dealer! [H]")
                            --zmiana pracy raz na tydzien
                            --TriggerServerEvent('zrider:job_date_retrieve')
                            Citizen.Wait(500)
                            --ESX.TriggerServerCallback('zrider:StartJobDate', function(StartJobDate)
                            --if StartJobDate == nil then
                                TriggerServerEvent('srp_drugs:setjobdealer')
                                --TriggerServerEvent('zrider:job_date_update', DayTodayDrugs())
                                TriggerServerEvent('srp_logs:jobChanged','Dealer')
                                LoadDict("mp_common")
                                TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a', 8.0, 8.0, -1, 0, 0, false, false, false)
                                TriggerServerEvent('srp_drugs:removeMoney2')
                                texta4 = true
                                Citizen.Wait(5000)
                                texta4 = false
                                texta5 = true
                                Citizen.Wait(5000)
                                texta5 = false
                                texta6 = true
                                Citizen.Wait(5000)
                                texta6 = false
                                texta7 = true
                                Citizen.Wait(5000)
                                texta7 = false
                                texta8 = true
                                Citizen.Wait(2500)
                                texta8 = false
                                CanBuy2 = true
                                start2()
                                Citizen.Wait(900000)
                                CanBuy2 = false
                                Cooldownpani = false
                            -- else
                            --     local data_zatrudnienia = StartJobDate
                            --     local dzien_zatrudnienia,miesiac_zatrudnienia,rok_zatrudnienia = (data_zatrudnienia):match("(%d%d)-(%d%d)-(%d%d%d%d)")
                            --         dzien_zatrudnienia = tonumber(dzien_zatrudnienia)
                            --         miesiac_zatrudnienia = tonumber(miesiac_zatrudnienia)
                            --         rok_zatrudnienia = tonumber(rok_zatrudnienia) 
                            --     if DaysBetweenManualDrugs(dzien_zatrudnienia,miesiac_zatrudnienia,rok_zatrudnienia) >= 7 then
                            --         TriggerServerEvent('srp_drugs:setjobdealer')
                            --         TriggerServerEvent('zrider:job_date_update', DayTodayDrugs())
                            --         TriggerServerEvent('srp_logs:jobChanged','Dealer')
                            --         LoadDict("mp_common")
                            --         TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a', 8.0, 8.0, -1, 0, 0, false, false, false)
                            --         TriggerServerEvent('srp_drugs:removeMoney2')
                            --         texta4 = true
                            --         Citizen.Wait(5000)
                            --         texta4 = false
                            --         texta5 = true
                            --         Citizen.Wait(5000)
                            --         texta5 = false
                            --         texta6 = true
                            --         Citizen.Wait(5000)
                            --         texta6 = false
                            --         texta7 = true
                            --         Citizen.Wait(5000)
                            --         texta7 = false
                            --         texta8 = true
                            --         Citizen.Wait(2500)
                            --         texta8 = false
                            --         CanBuy2 = true
                            --         start2()
                            --         Citizen.Wait(900000)
                            --         CanBuy2 = false
                            --         Cooldownpani = false
                            --     else
                            --         exports['mythic_notify']:DoCustomHudText('error', 'Możesz zmienić pracę tylko raz na tydzień', 3500)
                            --         TriggerServerEvent('srp_logs:jobChanged','Proba zmiany pracy (narko)')
                            --         Cooldownpani = false
                            --     end
                            
                            end
                        
                    elseif(GetDistanceBetweenCoords(coords, Infodealer1.x, Infodealer1.y, Infodealer1.z, true) > 1000) then
                        Citizen.Wait(20000)
                    elseif(GetDistanceBetweenCoords(coords, Infodealer1.x, Infodealer1.y, Infodealer1.z, true) > 500) then
                        Citizen.Wait(10000)
                    elseif(GetDistanceBetweenCoords(coords, Infodealer1.x, Infodealer1.y, Infodealer1.z, true) > 100) then
                        Citizen.Wait(3000)
                    end
                    end
                --end
            --end
        end
    end)
    ---- Sprawdzanie czy gracz ma wymagane przedmioty
    RegisterNetEvent("srp_drugs:Hasitems2")
    AddEventHandler("srp_drugs:Hasitems2", function(count)
        if count > 0 then
            Hasitems2 = true
        elseif count == 0 then
            Hasitems2 = false 
        end
    end)
    
    -- Wyświetlanie tekstów nad głową Informatora (Dealer)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local pedcoords = GetEntityCoords(PlayerPedId())
            if texta1pani1 == true then
                if GetDistanceBetweenCoords(pedcoords, Infodealer1, false) <= 5 then
                    DrawText3D(Infodealer1.x, Infodealer1.y, Infodealer1.z+0.6, "~w~Hej kotku, chcesz się zabawić...")
                end
            end
            if texta1pani2 == true then
                if GetDistanceBetweenCoords(pedcoords, Infodealer1, false) <= 5 then
                    DrawText3D(Infodealer1.x, Infodealer1.y, Infodealer1.z+0.6, "~w~Hej kotku, przychodzisz do mnie bez gumek?")
                end
            end
            if texta1pani3 == true then
                if GetDistanceBetweenCoords(pedcoords, Infodealer1, false) <= 5 then
                    DrawText3D(Infodealer1.x, Infodealer1.y, Infodealer1.z+0.6, "~w~Hej kotku, zrobisz mi dobrze?")
                end
            end
            if texta1pani4 == true then
                if GetDistanceBetweenCoords(pedcoords, Infodealer1, false) <= 5 then
                    DrawText3D(Infodealer1.x, Infodealer1.y, Infodealer1.z+0.6, "~w~To jak kotek weźmiesz mnie?")
                end
            end
            if texta1pani5 == true then
                if GetDistanceBetweenCoords(pedcoords, Infodealer1, false) <= 5 then
                    DrawText3D(Infodealer1.x, Infodealer1.y, Infodealer1.z+0.6, "~w~Chcesz się zabawić? No pokaż co tam masz...")
                end
            end
            if texta1paniquest1 == true then
                if GetDistanceBetweenCoords(pedcoords, Infodealer1, false) <= 5 then
                    DrawText3D(Infodealer1.x, Infodealer1.y, Infodealer1.z+0.6, "~w~Co Ty mi za fistaszka pokazujesz, spadaj stąd...")
                end
            end
            if texta1 == true then
                if GetDistanceBetweenCoords(pedcoords, Infodealer1, false) <= 5 then
                    DrawText3D(Infodealer1.x, Infodealer1.y, Infodealer1.z+0.6, "~w~Słyszałam że chcesz zarobić trochę na detalu?....")
                end
            end
            if texta2 == true then
                if GetDistanceBetweenCoords(pedcoords, Infodealer1, false) <= 5 then
                    DrawText3D(Infodealer1.x, Infodealer1.y, Infodealer1.z+0.6, "~w~Ale nie ma nic za darmo... Najpierw muszisz coś dla mnie zrobić...")
                end
            end
            if texta3 == true then
                if GetDistanceBetweenCoords(pedcoords, Infodealer1, false) <= 5 then
                    DrawText3D(Infodealer1.x, Infodealer1.y, Infodealer1.z+0.6, "~w~Przynieś mi 700$ w gotówce... Do zobaczenia kociaku...")
                end
            end
            if texta4 == true then
                if GetDistanceBetweenCoords(pedcoords, Infodealer1, false) <= 5 then
                    DrawText3D(Infodealer1.x, Infodealer1.y, Infodealer1.z+0.6, "~w~Dobra, mam nadzieję że suma się zgadza...")
                end
            end
            if texta5 == true then
                if GetDistanceBetweenCoords(pedcoords, Infodealer1, false) <= 5 then
                    DrawText3D(Infodealer1.x, Infodealer1.y, Infodealer1.z+0.6, "~w~Słuchaj misiek... Pojedziesz na miejsce które ci wskażę...")
                end
            end
            if texta6 == true then
                if GetDistanceBetweenCoords(pedcoords, Infodealer1, false) <= 5 then
                    DrawText3D(Infodealer1.x, Infodealer1.y, Infodealer1.z+0.6, "~w~Znajdziesz kolesia w budzie który powie Ci o tym coś więcej...")
                end
            end
            if texta7 == true then
                if GetDistanceBetweenCoords(pedcoords, Infodealer1, false) <= 5 then
                    DrawText3D(Infodealer1.x, Infodealer1.y, Infodealer1.z+0.6, "~w~Ale pamiętaj nigdy się nie widzieliśmy i nie wiesz kim ja jestem!")
                end
            end
            if texta8 == true then
                if GetDistanceBetweenCoords(pedcoords, Infodealer1, false) <= 5 then
                    DrawText3D(Infodealer1.x, Infodealer1.y, Infodealer1.z+0.6, "~w~Powodzenia... Mrauu...")
                end
            end
            if nopolice == true then
                if GetDistanceBetweenCoords(pedcoords, Infodealer1, false) <= 5 then
                    DrawText3D(Infodealer1.x, Infodealer1.y, Infodealer1.z+0.6, "~w~Z psami nie rozmawiam... Nie jestem kapusiem...")
                end
            end
        end
    end)
    
    
    
    
    --[ DEALER ]--
    
    ---- Sprawdzanie czy gracz jest przy sprzedawcy
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local coords = GetEntityCoords(GetPlayerPed(-1))
            local isNearSeller = false
    
            --for k,v in pairs(Config.Dealer) do
                --for i = 1, #v.Pos, 1 do
                    if PlayerData.job ~= nil and PlayerData.job.name == 'dealer' and GetDistanceBetweenCoords(coords, Dealer1, false) <= 5 then
                        --if  GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, false) <= 1.5 then
                            if PlayerData.job ~= nil and PlayerData.job.name == 'dealer' or CanBuy2 == true then
                                DrawText3D(Dealer1.x, Dealer1.y, Dealer1.z, "~g~[E] ~w~Aby porozmawiać")
                            end
                        local inveh = IsPedInAnyVehicle(GetPlayerPed(-1), false)
                        isNearSeller  = true
                        if IsControlJustReleased(0, Keys['E']) then
                            if inveh then
                                exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                            else
                            --print("[DEBUG] Znajdujesz sie przy dilerze narkotykowym! [E]")
                            textb1 = true
                            Citizen.Wait(5000)
                            textb1 = false
                            textb2 = true
                            Citizen.Wait(5000)
                            textb2 = false
                            textb3 = true
                            Citizen.Wait(5000)
                            textb3 = false
                            textb4 = true
                            Citizen.Wait(5000)
                            textb4 = false
                            textb5 = true
                            Citizen.Wait(2500)
                            textb5 = false
                            CanBuy3 = true
                            start3()
                            Citizen.Wait(900000)
                            CanBuy3 = false
                            end
                        end
                    elseif(GetDistanceBetweenCoords(coords, Dealer1.x, Dealer1.y, Dealer1.z, true) > 1000) then
                        Citizen.Wait(20000)
                    elseif(GetDistanceBetweenCoords(coords, Dealer1.x, Dealer1.y, Dealer1.z, true) > 500) then
                        Citizen.Wait(10000)
                    elseif(GetDistanceBetweenCoords(coords, Dealer1.x, Dealer1.y, Dealer1.z, true) > 100) then
                        Citizen.Wait(3000)
                    end
                --end
            --end
        end
    end)
    
    ----- Tekts 3d nad glowa dilera narkotykowego
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local pedcoords = GetEntityCoords(PlayerPedId())
            if textb1 == true then
                if GetDistanceBetweenCoords(pedcoords, Dealer1, false) <= 5 then
                    DrawText3D(Dealer1.x, Dealer1.y, Dealer1.z+1.7, "~w~A więc to Ty przyszedłeś po więcej informacji...")
                end
            end
            if textb2 == true then
                if GetDistanceBetweenCoords(pedcoords, Dealer1, false) <= 5 then
                    DrawText3D(Dealer1.x, Dealer1.y, Dealer1.z+1.7, "~w~Pokaż mi się, niech ja Ci się przyjrzę...")
                end
            end
            if textb3 == true then
                if GetDistanceBetweenCoords(pedcoords, Dealer1, false) <= 5 then
                    DrawText3D(Dealer1.x, Dealer1.y, Dealer1.z+1.7, "~w~Hmm... Coś mi tu śmierdzi ale niech stracę...")
                end
            end
            if textb4 == true then
                if GetDistanceBetweenCoords(pedcoords, Dealer1, false) <= 5 then
                    DrawText3D(Dealer1.x, Dealer1.y, Dealer1.z+1.7, "~w~Dostaniesz kontakty ale towar musisz załatwić sobie sam")
                    DrawText3D(Dealer1.x, Dealer1.y, Dealer1.z+1.6, "~w~Masz kartkę i spadaj stąd szybko jak nic nie kupujesz...")
                end
            end
            if textb5 == true then
                if GetDistanceBetweenCoords(pedcoords, Dealer1, false) <= 5 then
                    DrawText3D(Dealer1.x, Dealer1.y, Dealer1.z+1.7, "~w~Udaj się dyskretnie na podany adres...")
                    DrawText3D(Dealer1.x, Dealer1.y, Dealer1.z+1.6, "~w~Powodzenia...")
                end
            end
            if nopolice == true then
                if GetDistanceBetweenCoords(pedcoords, Dealer1, false) <= 5 then
                    DrawText3D(Dealer1.x, Dealer1.y, Dealer1.z+1.7, "~w~Z psami nie rozmawiam...")
                end
            end
        end
    end)
    
    --[ Przeróbka DEALER ]--
    
    ---- Sprawdzanie czy gracz jest przy pedzie
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local coords = GetEntityCoords(GetPlayerPed(-1))
            local isNearInformator = false
    
            --for k,v in pairs(Config.DealerProcess) do
                --for i = 1, #v.Pos, 1 do
                    if PlayerData.job ~= nil and PlayerData.job.name == 'dealer' and (GetDistanceBetweenCoords(coords, DealerProcess1, true) < 5) then
                        nodisplay = true
                        if GetDistanceBetweenCoords(coords, DealerProcess1, false) <= 2 then
                            TriggerServerEvent("srp_drugs:HasitemsCash")
                            TriggerServerEvent("srp_drugs:HasitemsPackage")
                            TriggerServerEvent("srp_drugs:HasitemsWeed")
                            if HasitemsCash == false and HasitemsWeed == false and HasitemsPackage == false then
                                DrawText3D(DealerProcess1.x, DealerProcess1.y, DealerProcess1.z, "~g~[E] ~w~Aby porozmawiać")
                            end
                            if HasitemsCash == true and HasitemsWeed == false and HasitemsPackage == true then
                                DrawText3D(DealerProcess1.x, DealerProcess1.y, DealerProcess1.z, "~g~[E] ~w~Aby porozmawiać ~g~[H] ~w~Aby wręczyć paczkę")
                            end
                            if HasitemsCash == true and HasitemsWeed == true and HasitemsPackage == false then
                                DrawText3D(DealerProcess1.x, DealerProcess1.y, DealerProcess1.z, "~g~[E] ~w~Aby porozmawiać ~g~[X] ~w~Informacje na temat sprzedaży")
                            end
                            if HasitemsCash == true and HasitemsWeed == false and HasitemsPackage == false then
                                DrawText3D(DealerProcess1.x, DealerProcess1.y, DealerProcess1.z, "~g~[E] ~w~Aby porozmawiać")
                            end
                            if HasitemsCash == false and HasitemsWeed == true and HasitemsPackage == false then
                                DrawText3D(DealerProcess1.x, DealerProcess1.y, DealerProcess1.z, "~g~[E] ~w~Aby porozmawiać ~g~[X] ~w~Informacje na temat sprzedaży")
                            end
                            if HasitemsCash == true and HasitemsWeed == true and HasitemsPackage == true then
                                DrawText3D(DealerProcess1.x, DealerProcess1.y, DealerProcess1.z, "~g~[E] ~w~Aby porozmawiać~g~ [H] ~w~Aby wręczyć paczkę ")
                                DrawText3D(DealerProcess1.x, DealerProcess1.y, DealerProcess1.z-0.10, "~g~[X] ~w~Informacje na temat sprzedaży")
                            end
                        end
                        local inveh = IsPedInAnyVehicle(GetPlayerPed(-1), false)
                        isNearInformator  = true
                        if IsControlJustReleased(0, Keys['E']) then
                            --print("[DEBUG] Znajdujesz sie przy dealerze! [E]")
                            if inveh then
                                exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                            else
                            textc1 = true
                            Citizen.Wait(5000)
                            textc1 = false
                            textc2 = true
                            Citizen.Wait(5000)
                            textc2 = false
                            textc3 = true
                            Citizen.Wait(5000)
                            textc3 = false
                            end
                        elseif IsControlJustReleased(0, Keys['H']) and HasitemsCash == true and HasitemsPackage == true then
                            if inveh then
                                exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                            else
                            --print("[DEBUG] Znajdujesz sie przy dealerze! [H]")
                            LoadDict("mp_common")
                            TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a', 8.0, 8.0, -1, 0, 0, false, false, false)
                            TriggerServerEvent('srp_drugs:removepackaged')
                            textc4 = true
                            Citizen.Wait(5000)
                            textc4 = false
                            textc5 = true
                            Citizen.Wait(5000)
                            textc5 = false
                            textc6 = true
                            Citizen.Wait(5000)
                            textc6 = false
                            textc7 = true
                            Citizen.Wait(5000)
                            textc7 = false
                            textc8 = true
                            Citizen.Wait(2500)
                            textc8 = false
                            CanBuy4 = true
                            TriggerServerEvent('srp_drugs:processingdrugs')
                            CanBuy4 = false
                            end
                        elseif IsControlJustReleased(0, Keys['X']) and HasitemsWeed == true then
                            if inveh then
                                exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                            else
                            --print("[DEBUG] Znajdujesz sie przy dealerze! [X]")
                            SellDrags()
                            end
                        end
                    elseif(GetDistanceBetweenCoords(coords, DealerProcess1.x, DealerProcess1.y, DealerProcess1.z, true) > 1000) then
                        Citizen.Wait(20000)
                    elseif(GetDistanceBetweenCoords(coords, DealerProcess1.x, DealerProcess1.y, DealerProcess1.z, true) > 500) then
                        Citizen.Wait(10000)
                    elseif(GetDistanceBetweenCoords(coords, DealerProcess1.x, DealerProcess1.y, DealerProcess1.z, true) > 100) then
                        Citizen.Wait(3000)
                    end
                --end
            --end
        end
    end)
    ---- Menu miejsc sprzedaży dragów
    function SellDrags()
        ESX.UI.Menu.CloseAll()
        ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'SellDrags',
            {
                title    = 'Wybierz miejsce sprzedaży',
                elements = {
                    {label = 'Downtown', value = 'downtown'},
                    {label = 'East Vinewood', value = 'eastvinewood'},
                    {label = 'Davis', value = 'davis'},
                    {label = 'Strawberry', value = 'strawberry'}
                }
            },
            function(data, menu)
                if data.current.value == 'downtown' then
                    --print("[DEBUG] DOWNTOWN")
                    exports['mythic_progbar']:Progress({
                        name = "drugs_action",
                        duration = 3500,
                        label = "Zapisywanie danych...",
                        useWhileDead = false,
                        canCancel = true,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        },
                        animation = {
                            animDict = "missheistdockssetup1clipboard@base",
                            anim = "base",
                            flags = 49,
                        },
                        prop = {
                            model = "p_amb_clipboard_01",
                            bone = 18905,
                            coords = { x = 0.10, y = 0.02, z = 0.08 },
                            rotation = { x = -80.0, y = 0.0, z = 0.0 },
                        },
                        propTwo = {
                            model = "prop_pencil_01",
                            bone = 58866,
                            coords = { x = 0.12, y = 0.0, z = 0.001 },
                            rotation = { x = -150.0, y = 0.0, z = 0.0 },
                        },
                    })
                    Citizen.Wait(3500)
                    --ESX.ShowNotification("Twoja dzielnica sprzedaży to ~r~Downtown~w~!")
                    exports['mythic_notify']:DoCustomHudText('inform', 'Twoja dzielnica sprzedaży to Downtown', 3500)
                    ESX.UI.Menu.CloseAll()
                    RemoveBlip(blip)
                    Timesell1 = true
                    StartSellDrugsDowntown()
                end
                if data.current.value == 'eastvinewood' then
                    --print("[DEBUG] EAST VINEWOOD")
                    exports['mythic_progbar']:Progress({
                        name = "drugs_action",
                        duration = 3500,
                        label = "Zapisywanie danych...",
                        useWhileDead = false,
                        canCancel = true,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        },
                        animation = {
                            animDict = "missheistdockssetup1clipboard@base",
                            anim = "base",
                            flags = 49,
                        },
                        prop = {
                            model = "p_amb_clipboard_01",
                            bone = 18905,
                            coords = { x = 0.10, y = 0.02, z = 0.08 },
                            rotation = { x = -80.0, y = 0.0, z = 0.0 },
                        },
                        propTwo = {
                            model = "prop_pencil_01",
                            bone = 58866,
                            coords = { x = 0.12, y = 0.0, z = 0.001 },
                            rotation = { x = -150.0, y = 0.0, z = 0.0 },
                        },
                    })
                    Citizen.Wait(3500)
                    --ESX.ShowNotification("Twoja dzielnica sprzedaży to ~r~East Vinewood~w~!")
                    exports['mythic_notify']:DoCustomHudText('inform', 'Twoja dzielnica sprzedaży to East Vinewood', 3500)
                    ESX.UI.Menu.CloseAll()
                    RemoveBlip(blip)
                    Timesell2 = true
                    StartSellDrugsEastVinewood()
                end	
                if data.current.value == 'davis' then
                    --print("[DEBUG] DAVIS")
                    exports['mythic_progbar']:Progress({
                        name = "drugs_action",
                        duration = 3500,
                        label = "Zapisywanie danych...",
                        useWhileDead = false,
                        canCancel = true,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        },
                        animation = {
                            animDict = "missheistdockssetup1clipboard@base",
                            anim = "base",
                            flags = 49,
                        },
                        prop = {
                            model = "p_amb_clipboard_01",
                            bone = 18905,
                            coords = { x = 0.10, y = 0.02, z = 0.08 },
                            rotation = { x = -80.0, y = 0.0, z = 0.0 },
                        },
                        propTwo = {
                            model = "prop_pencil_01",
                            bone = 58866,
                            coords = { x = 0.12, y = 0.0, z = 0.001 },
                            rotation = { x = -150.0, y = 0.0, z = 0.0 },
                        },
                    })
                    Citizen.Wait(3500)
                    --ESX.ShowNotification("Twoja dzielnica sprzedaży to ~r~Davis~w~!")
                    exports['mythic_notify']:DoCustomHudText('inform', 'Twoja dzielnica sprzedaży to Davis', 3500)
                    ESX.UI.Menu.CloseAll()
                    RemoveBlip(blip)
                    Timesell3 = true
                    StartSellDrugsDavis()
                end	
                if data.current.value == 'strawberry' then
                    --print("[DEBUG] STRAWBERRY")
                    exports['mythic_progbar']:Progress({
                        name = "drugs_action",
                        duration = 3500,
                        label = "Zapisywanie danych...",
                        useWhileDead = false,
                        canCancel = true,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        },
                        animation = {
                            animDict = "missheistdockssetup1clipboard@base",
                            anim = "base",
                            flags = 49,
                        },
                        prop = {
                            model = "p_amb_clipboard_01",
                            bone = 18905,
                            coords = { x = 0.10, y = 0.02, z = 0.08 },
                            rotation = { x = -80.0, y = 0.0, z = 0.0 },
                        },
                        propTwo = {
                            model = "prop_pencil_01",
                            bone = 58866,
                            coords = { x = 0.12, y = 0.0, z = 0.001 },
                            rotation = { x = -150.0, y = 0.0, z = 0.0 },
                        },
                    })
                    Citizen.Wait(3500)
                    --ESX.ShowNotification("Twoja dzielnica sprzedaży to ~r~Strawberry~w~!")
                    exports['mythic_notify']:DoCustomHudText('inform', 'Twoja dzielnica sprzedaży to Strawbberry', 3500)
                    ESX.UI.Menu.CloseAll()
                    RemoveBlip(blip)
                    Timesell4 = true
                    StartSellDrugsStrawberry()
                end	
                menu.close()
            end,
            function(data, menu)
                menu.close()
            end
        )
    end
    ---- Sprawdzanie czy gracz ma wymagane przedmioty
    RegisterNetEvent("srp_drugs:HasitemsCash")
    AddEventHandler("srp_drugs:HasitemsCash", function(count)
        if count > 0 then
            HasitemsCash = true
        elseif count == 0 then
            HasitemsCash = false 
        end
    end)
    
    ---- Sprawdzanie czy gracz ma wymagane przedmioty
    RegisterNetEvent("srp_drugs:HasitemsPackage")
    AddEventHandler("srp_drugs:HasitemsPackage", function(count)
        if count > 0 then
            HasitemsPackage = true
        elseif count == 0 then
            HasitemsPackage = false 
        end
    end)
    
    ----- sprawdzanie narko przy sobie
    RegisterNetEvent("srp_drugs:HasitemsWeed")
    AddEventHandler("srp_drugs:HasitemsWeed", function(count)
        if count > 0 then
            HasitemsWeed = true
        elseif count == 0 then
            HasitemsWeed = false 
        end
    end)
    
    -- Wyświetlanie tekstów nad głową Informatora (Dealer)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local pedcoords = GetEntityCoords(PlayerPedId())
            if textc1 == true then
                if GetDistanceBetweenCoords(pedcoords, DealerProcess1, false) <= 5 then
                    DrawText3D(DealerProcess1.x, DealerProcess1.y, DealerProcess1.z+1, "~w~A więc to Ty... Chcesz żebym to ja robił za Ciebię całą robotę...")
                end
            end
            if textc2 == true then
                if GetDistanceBetweenCoords(pedcoords, DealerProcess1, false) <= 5 then
                    DrawText3D(DealerProcess1.x, DealerProcess1.y, DealerProcess1.z+1, "~w~Nie ma nic za darmo.. Musisz przynieść mi 500 dolców i paczuszkę...")
                end
            end
            if textc3 == true then
                if GetDistanceBetweenCoords(pedcoords, DealerProcess1, false) <= 5 then
                    DrawText3D(DealerProcess1.x, DealerProcess1.y, DealerProcess1.z+1, "~w~Do zobaczenia...")
                end
            end
            if textc4 == true then
                if GetDistanceBetweenCoords(pedcoords, DealerProcess1, false) <= 5 then
                    DrawText3D(DealerProcess1.x, DealerProcess1.y, DealerProcess1.z+1, "~w~Mam nadzieję że suma się zgadza...")
                end
            end
            if textc5 == true then
                if GetDistanceBetweenCoords(pedcoords, DealerProcess1, false) <= 5 then
                    DrawText3D(DealerProcess1.x, DealerProcess1.y, DealerProcess1.z+1, "~w~Dobra... Zrobie to za Ciebię... Poczekaj Chwilę...")
                end
            end
            if textc6 == true then
                if GetDistanceBetweenCoords(pedcoords, DealerProcess1, false) <= 5 then
                    DrawText3D(DealerProcess1.x, DealerProcess1.y, DealerProcess1.z+1, "~w~Masz tu gotowe porcje...")
                end
            end
            if textc7 == true then
                if GetDistanceBetweenCoords(pedcoords, DealerProcess1, false) <= 5 then
                    DrawText3D(DealerProcess1.x, DealerProcess1.y, DealerProcess1.z+1, "~w~Ale pamiętaj nigdy się nie widzieliśmy i nie wiesz kim ja jestem!")
                end
            end
            if textc8 == true then
                if GetDistanceBetweenCoords(pedcoords, DealerProcess1, false) <= 5 then
                    DrawText3D(DealerProcess1.x, DealerProcess1.y, DealerProcess1.z+1, "~w~Myślę że do mnie jeszcze wrócisz...")
                end
            end
            if nopolice == true then
                if GetDistanceBetweenCoords(pedcoords, DealerProcess1, false) <= 5 then
                    DrawText3D(DealerProcess1.x, DealerProcess1.y, DealerProcess1.z+1, "~w~Z psami nie rozmawiam... Nie jestem kapusiem...")
                end
            end
        end
    end)
    --[ Sprzedaż Dragów ]--
    --- Downtown
    
    ---- Sprawdzanie czy gracz jest przy pedzie
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local coords = GetEntityCoords(GetPlayerPed(-1))
            local isNearInformator = false
    
            for k,v in pairs(Config.Selling1) do
                for i = 1, #v.Pos, 1 do
                    if PlayerData.job ~= nil and PlayerData.job.name == 'dealer' then
                        if(Config.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < 5) then
                        TriggerServerEvent("srp_drugs:HasitemsWeed")
                        if HasitemsWeed == true and Timesell1 == true and SellerdrugsDowntown1 == false and GetDistanceBetweenCoords(coords, -47.11, -784.43, 33.12, false) <= 1.5 then
                            DrawText3D(-47.11, -784.43, 33.12 , "~g~[E] ~w~Aby sprzedać")
                        end
                        if HasitemsWeed == true and Timesell1 == true and SellerdrugsDowntown2 == false and GetDistanceBetweenCoords(coords, -68.19, -707.34, 34.03, false) <= 1.5 then
                            DrawText3D(-68.19, -707.34, 34.03 , "~g~[E] ~w~Aby sprzedać")
                        end
                        if HasitemsWeed == true and Timesell1 == true and SellerdrugsDowntown3 == false and GetDistanceBetweenCoords(coords, -185.39, -759.18, 30.45, false) <= 1.5 then
                            DrawText3D(-185.39, -759.18, 30.45 , "~g~[E] ~w~Aby sprzedać")
                        end
                        if HasitemsWeed == true and Timesell1 == true and SellerdrugsDowntown4 == false and GetDistanceBetweenCoords(coords, 111.34, -887.78, 31.12, false) <= 1.5 then
                            DrawText3D(111.34, -887.78, 31.12 , "~g~[E] ~w~Aby sprzedać")
                        end
                        if HasitemsWeed == true and Timesell1 == true and SellerdrugsDowntown5 == false and GetDistanceBetweenCoords(coords, -92.78, -860.93, 26.69, false) <= 1.5 then
                            DrawText3D(-92.78, -860.93, 26.69 , "~g~[E] ~w~Aby sprzedać")
                        end
                        if HasitemsWeed == true and Timesell1 == true and SellerdrugsDowntown6 == false and GetDistanceBetweenCoords(coords, 38.07, -1026.87, 29.56, false) <= 1.5 then
                            DrawText3D(38.07, -1026.87, 29.56 , "~g~[E] ~w~Aby sprzedać")
                        end
                        if HasitemsWeed == true and Timesell1 == true and SellerdrugsDowntown7 == false and GetDistanceBetweenCoords(coords, -112.67, -989.89, 21.28, false) <= 1.5 then
                            DrawText3D(-112.67, -989.89, 21.28 , "~g~[E] ~w~Aby sprzedać")
                        end
                        if HasitemsWeed == true and Timesell1 == true and SellerdrugsDowntown8 == false and GetDistanceBetweenCoords(coords, 166.71, -1088.93, 29.19, false) <= 1.5 then
                            DrawText3D(166.71, -1088.93, 29.19 , "~g~[E] ~w~Aby sprzedać")
                        end
                        if HasitemsWeed == true and Timesell1 == true and SellerdrugsDowntown9 == false and GetDistanceBetweenCoords(coords, 259.78, -783.14, 30.51, false) <= 1.5 then
                            DrawText3D(259.78, -783.14, 30.51 , "~g~[E] ~w~Aby sprzedać")
                        end
                        if HasitemsWeed == true and Timesell1 == true and SellerdrugsDowntown10 == false and GetDistanceBetweenCoords(coords, 148.93, -674.94, 33.12, false) <= 1.5 then
                            DrawText3D(148.93, -674.94, 33.12 , "~g~[E] ~w~Aby sprzedać")
                        end
                        if HasitemsWeed == true and Timesell1 == true and SellerdrugsDowntown11 == false and GetDistanceBetweenCoords(coords, 120.01 ,-723.86 ,42.03, false) <= 1.5 then
                            DrawText3D(120.01 ,-723.86 ,42.03 , "~g~[E] ~w~Aby sprzedać")
                        end
                        if HasitemsWeed == true and Timesell1 == true and SellerdrugsDowntown12 == false and GetDistanceBetweenCoords(coords, 139.87, -613.79, 44.22, false) <= 1.5 then
                            DrawText3D(139.87, -613.79, 44.22 , "~g~[E] ~w~Aby sprzedać")
                        end
                        if HasitemsWeed == true and Timesell1 == true and SellerdrugsDowntown13 == false and GetDistanceBetweenCoords(coords, -88.59, -828.71, 35.44, false) <= 1.5 then
                            DrawText3D(-88.59, -828.71, 35.44 , "~g~[E] ~w~Aby sprzedać")
                        end
                        if HasitemsWeed == true and Timesell1 == true and SellerdrugsDowntown14 == false and GetDistanceBetweenCoords(coords, 2.93, -713.72, 32.48, false) <= 1.5 then
                            DrawText3D(2.93, -713.72, 32.48 , "~g~[E] ~w~Aby sprzedać")
                        end
                        if HasitemsWeed == true and Timesell1 == true and SellerdrugsDowntown15 == false and GetDistanceBetweenCoords(coords, -292.77, -957.64, 31.21, false) <= 1.5 then
                            DrawText3D(-292.77, -957.64, 31.21 , "~g~[E] ~w~Aby sprzedać")
                        end
                        
                        if HasitemsWeed == false and Timesell1 == false then
                            DrawText3D(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, "~w~Nie masz wystarczającej ilości narkotyków na sprzedaż")
                        end
                    end
                        if HasitemsWeed == true and Timesell1 == true and SellerdrugsDowntown1 == false and GetDistanceBetweenCoords(coords, -47.11, -784.43, 33.12, false) <= 1.5 then
                            local inveh = IsPedInAnyVehicle(GetPlayerPed(-1), false)
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsDowntown1 = true
                                SellerdrugsDowntown15 = false
                                Citizen.Wait(50)
                                RemoveBlip(blip)
                                StartSellDrugsDowntown2()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell1 == true and SellerdrugsDowntown2 == false and GetDistanceBetweenCoords(coords, -68.19, -707.34, 34.03, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                --LoadDict("mp_common")
                                --TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a', 8.0, 8.0, -1, 0, 0, false, false, false)
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsDowntown2 = true
                                RemoveBlip(blip)
                                StartSellDrugsDowntown3()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell1 == true and SellerdrugsDowntown3 == false and GetDistanceBetweenCoords(coords, -185.39, -759.18, 30.45, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                --LoadDict("mp_common")
                                ----TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a', 8.0, 8.0, -1, 0, 0, false, false, false)
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsDowntown3 = true
                                RemoveBlip(blip)
                                StartSellDrugsDowntown4()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell1 == true and SellerdrugsDowntown4 == false and GetDistanceBetweenCoords(coords, 111.34, -887.78, 31.12, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                --LoadDict("mp_common")
                                --TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a', 8.0, 8.0, -1, 0, 0, false, false, false)
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsDowntown4 = true
                                RemoveBlip(blip)
                                StartSellDrugsDowntown5()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell1 == true and SellerdrugsDowntown5 == false and GetDistanceBetweenCoords(coords, -92.78, -860.93, 26.69, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                --LoadDict("mp_common")
                                --TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a', 8.0, 8.0, -1, 0, 0, false, false, false)
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsDowntown5 = true
                                RemoveBlip(blip)
                                StartSellDrugsDowntown6()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell1 == true and SellerdrugsDowntown6 == false and GetDistanceBetweenCoords(coords, 38.07, -1026.87, 29.56, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                --LoadDict("mp_common")
                                --TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a', 8.0, 8.0, -1, 0, 0, false, false, false)
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsDowntown6 = true
                                RemoveBlip(blip)
                                StartSellDrugsDowntown7()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell1 == true and SellerdrugsDowntown7 == false and GetDistanceBetweenCoords(coords, -112.67, -989.89, 21.28, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                --LoadDict("mp_common")
                                --TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a', 8.0, 8.0, -1, 0, 0, false, false, false)
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsDowntown7 = true
                                RemoveBlip(blip)
                                StartSellDrugsDowntown8()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell1 == true and SellerdrugsDowntown8 == false and GetDistanceBetweenCoords(coords, 166.71, -1088.93, 29.19, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                --LoadDict("mp_common")
                                --TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a', 8.0, 8.0, -1, 0, 0, false, false, false)
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsDowntown8 = true
                                RemoveBlip(blip)
                                StartSellDrugsDowntown9()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell1 == true and SellerdrugsDowntown9 == false and GetDistanceBetweenCoords(coords, 259.78, -783.14, 30.51, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                --LoadDict("mp_common")
                                --TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a', 8.0, 8.0, -1, 0, 0, false, false, false)
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsDowntown9 = true
                                RemoveBlip(blip)
                                StartSellDrugsDowntown10()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell1 == true and SellerdrugsDowntown10 == false and GetDistanceBetweenCoords(coords, 148.93, -674.94, 33.12, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                --LoadDict("mp_common")
                                --TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a', 8.0, 8.0, -1, 0, 0, false, false, false)
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsDowntown10 = true
                                RemoveBlip(blip)
                                StartSellDrugsDowntown11()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell1 == true and SellerdrugsDowntown11 == false and GetDistanceBetweenCoords(coords, 120.01, -723.86, 42.03, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                --LoadDict("mp_common")
                                --TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a', 8.0, 8.0, -1, 0, 0, false, false, false)
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsDowntown11 = true
                                RemoveBlip(blip)
                                StartSellDrugsDowntown12()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell1 == true and SellerdrugsDowntown12 == false and GetDistanceBetweenCoords(coords, 139.87, -613.79, 44.22, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                --LoadDict("mp_common")
                                --TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a', 8.0, 8.0, -1, 0, 0, false, false, false)
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsDowntown12 = true
                                RemoveBlip(blip)
                                StartSellDrugsDowntown13()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell1 == true and SellerdrugsDowntown13 == false and GetDistanceBetweenCoords(coords, -88.59, -828.71, 35.44, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                --LoadDict("mp_common")
                                --TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a', 8.0, 8.0, -1, 0, 0, false, false, false)
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsDowntown13 = true
                                RemoveBlip(blip)
                                StartSellDrugsDowntown14()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell1 == true and SellerdrugsDowntown14 == false and GetDistanceBetweenCoords(coords, 2.93, -713.72, 32.48, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                --LoadDict("mp_common")
                                --TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a', 8.0, 8.0, -1, 0, 0, false, false, false)
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsDowntown14 = true
                                RemoveBlip(blip)
                                StartSellDrugsDowntown15()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell1 == true and SellerdrugsDowntown15 == false and GetDistanceBetweenCoords(coords, -292.77, -957.64, 31.21, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                --LoadDict("mp_common")
                                --TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a', 8.0, 8.0, -1, 0, 0, false, false, false)
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsDowntown15 = true
                                RemoveBlip(blip)
                                SellerdrugsDowntown1 = false
                                SellerdrugsDowntown2 = false
                                SellerdrugsDowntown3 = false
                                SellerdrugsDowntown4 = false
                                SellerdrugsDowntown5 = false
                                SellerdrugsDowntown6 = false
                                SellerdrugsDowntown7 = false
                                SellerdrugsDowntown8 = false
                                SellerdrugsDowntown9 = false
                                SellerdrugsDowntown10 = false
                                SellerdrugsDowntown11 = false
                                SellerdrugsDowntown12 = false
                                SellerdrugsDowntown13 = false
                                SellerdrugsDowntown14 = false
                                StartSellDrugsDowntown()
                            end
                            end
                        end
                    end
                end
            end
        end
    end)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local coords = GetEntityCoords(PlayerPedId())
            for k,v in pairs(Config.Selling1) do
                for i = 1, #v.Pos, 1 do
                    if textsell == true then
                        if (GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < 1.5) then
                            DrawText3D(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z+1, "~w~Dzięki za towar")
                        end
                    end
                end
            end
        end
    end)
    
    ---East Vinewood
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local coords = GetEntityCoords(GetPlayerPed(-1))
            for k,v in pairs(Config.Selling2) do
                for i = 1, #v.Pos, 1 do
                    if(Config.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < 5) then
                        nodisplay = true
                        if PlayerData.job ~= nil and PlayerData.job.name == 'dealer' then
                            TriggerServerEvent("srp_drugs:HasitemsWeed")
                            if HasitemsWeed == true and Timesell2 == true and SellerdrugsEastVinewood1 == false and GetDistanceBetweenCoords(coords, 1005.65, -114.78, 73.98, false) <= 1.5 then
                                DrawText3D(1005.65, -114.78, 73.98, "~g~[E] ~w~Aby sprzedać")
                            end
                            if HasitemsWeed == true and Timesell2 == true and SellerdrugsEastVinewood2 == false and GetDistanceBetweenCoords(coords, 871.61, -158.09, 78.34, false) <= 1.5 then
                                DrawText3D(871.61, -158.09, 78.34, "~g~[E] ~w~Aby sprzedać")
                            end
                            if HasitemsWeed == true and Timesell2 == true and SellerdrugsEastVinewood3 == false and GetDistanceBetweenCoords(coords, 895.38, -201.92, 71.98, false) <= 1.5 then
                                DrawText3D(895.38, -201.92, 71.98, "~g~[E] ~w~Aby sprzedać")
                            end
                            if HasitemsWeed == true and Timesell2 == true and SellerdrugsEastVinewood4 == false and GetDistanceBetweenCoords(coords, 927.05, -230.61, 70.31, false) <= 1.5 then
                                DrawText3D(927.05, -230.61, 70.31, "~g~[E] ~w~Aby sprzedać")
                            end
                            if HasitemsWeed == true and Timesell2 == true and SellerdrugsEastVinewood5 == false and GetDistanceBetweenCoords(coords, 937.31, -231.49, 69.19, false) <= 1.5 then
                                DrawText3D(937.31, -231.49, 69.19, "~g~[E] ~w~Aby sprzedać")
                            end
                            if HasitemsWeed == true and Timesell2 == true and SellerdrugsEastVinewood6 == false and GetDistanceBetweenCoords(coords, 1035.99, -145.92, 74.19, false) <= 1.5 then
                                DrawText3D(1035.99, -145.92, 74.19, "~g~[E] ~w~Aby sprzedać")
                            end
                            if HasitemsWeed == true and Timesell2 == true and SellerdrugsEastVinewood7 == false and GetDistanceBetweenCoords(coords, 1168.95, -291.71, 69.02, false) <= 1.5 then
                                DrawText3D(1168.95, -291.71, 69.02, "~g~[E] ~w~Aby sprzedać")
                            end
                            if HasitemsWeed == true and Timesell2 == true and SellerdrugsEastVinewood8 == false and GetDistanceBetweenCoords(coords, 1241.53, -417.28, 71.58, false) <= 1.5 then
                                DrawText3D(1241.53, -417.28, 71.58, "~g~[E] ~w~Aby sprzedać")
                            end
                            if HasitemsWeed == true and Timesell2 == true and SellerdrugsEastVinewood9 == false and GetDistanceBetweenCoords(coords, 1232.39, -455.25, 67.14, false) <= 1.5 then
                                DrawText3D(1232.39, -455.25, 67.14, "~g~[E] ~w~Aby sprzedać")
                            end
                            if HasitemsWeed == true and Timesell2 == true and SellerdrugsEastVinewood10 == false and GetDistanceBetweenCoords(coords, 1150.86, -437.91, 67.01, false) <= 1.5 then
                                DrawText3D(1150.86, -437.91, 67.01, "~g~[E] ~w~Aby sprzedać")
                            end
                            if HasitemsWeed == true and Timesell2 == true and SellerdrugsEastVinewood11 == false and GetDistanceBetweenCoords(coords, 1123.55, -390.07, 68.51, false) <= 1.5 then
                                DrawText3D(1123.55, -390.07, 68.51, "~g~[E] ~w~Aby sprzedać")
                            end
                            if HasitemsWeed == true and Timesell2 == true and SellerdrugsEastVinewood12 == false and GetDistanceBetweenCoords(coords, 1047.19, -454.78, 65.95, false) <= 1.5 then
                                DrawText3D(1047.19, -454.78, 65.95, "~g~[E] ~w~Aby sprzedać")
                            end
                            if HasitemsWeed == true and Timesell2 == true and SellerdrugsEastVinewood13 == false and GetDistanceBetweenCoords(coords, 706.66, -304.81, 59.25, false) <= 1.5 then
                                DrawText3D(706.66, -304.81, 59.25, "~g~[E] ~w~Aby sprzedać")
                            end
                            if HasitemsWeed == true and Timesell2 == true and SellerdrugsEastVinewood14 == false and GetDistanceBetweenCoords(coords, 1073.29, -260.58, 59.08, false) <= 1.5 then
                                DrawText3D(1073.29, -260.58, 59.08, "~g~[E] ~w~Aby sprzedać")
                            end
                            if HasitemsWeed == true and Timesell2 == true and SellerdrugsEastVinewood15 == false and GetDistanceBetweenCoords(coords, 1088.42, -271.24, 69.31, false) <= 1.5 then
                                DrawText3D(1088.42, -271.24, 69.31, "~g~[E] ~w~Aby sprzedać")
                            end
    
                            if HasitemsWeed == false and Timesell2 == false then
                                DrawText3D(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, "~w~Nie masz wystarczającej ilości narkotyków na sprzedaż")
                            end
                        end
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
    
            for k,v in pairs(Config.Selling2) do
                for i = 1, #v.Pos, 1 do
                    if PlayerData.job ~= nil and PlayerData.job.name == 'dealer' then
                        local inveh = IsPedInAnyVehicle(GetPlayerPed(-1), false)
                        if HasitemsWeed == true and Timesell2 == true and SellerdrugsEastVinewood1 == false and GetDistanceBetweenCoords(coords, 1005.65, -114.78, 73.98, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsEastVinewood1 = true
                                SellerdrugsEastVinewood15 = false
                                RemoveBlip(blip)
                                StartSellDrugsEastVinewood2()
                                end
                            end
                        end
    
                        if HasitemsWeed == true and Timesell2 == true and SellerdrugsEastVinewood2 == false and GetDistanceBetweenCoords(coords, 871.61, -158.09, 78.34, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsEastVinewood2 = true
                                RemoveBlip(blip)
                                StartSellDrugsEastVinewood3()
                                end
                            end
                        end
                        if HasitemsWeed == true and Timesell2 == true and SellerdrugsEastVinewood3 == false and GetDistanceBetweenCoords(coords, 895.38, -201.92, 71.98, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsEastVinewood3 = true
                                RemoveBlip(blip)
                                StartSellDrugsEastVinewood4()
                                end
                            end
                        end
                        if HasitemsWeed == true and Timesell2 == true and SellerdrugsEastVinewood4 == false and GetDistanceBetweenCoords(coords, 927.05, -230.61, 70.31, false) <= 1.5 then --
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsEastVinewood4 = true
                                RemoveBlip(blip)
                                StartSellDrugsEastVinewood5()
                                end
                            end
                        end
                        if HasitemsWeed == true and Timesell2 == true and SellerdrugsEastVinewood5 == false and GetDistanceBetweenCoords(coords, 937.31, -231.49, 69.19, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsEastVinewood5 = true
                                RemoveBlip(blip)
                                StartSellDrugsEastVinewood6()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell2 == true and SellerdrugsEastVinewood6 == false and GetDistanceBetweenCoords(coords, 1035.99, -145.92, 74.19, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsEastVinewood6 = true
                                RemoveBlip(blip)
                                StartSellDrugsEastVinewood7()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell2 == true and SellerdrugsEastVinewood7 == false and GetDistanceBetweenCoords(coords, 1168.95, -291.71, 69.02, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsEastVinewood7 = true
                                RemoveBlip(blip)
                                StartSellDrugsEastVinewood8()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell2 == true and SellerdrugsEastVinewood8 == false and GetDistanceBetweenCoords(coords, 1241.53, -417.28, 71.58, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsEastVinewood8 = true
                                RemoveBlip(blip)
                                StartSellDrugsEastVinewood9()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell2 == true and SellerdrugsEastVinewood9 == false and GetDistanceBetweenCoords(coords, 1232.39, -455.25, 67.14, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsEastVinewood9 = true
                                RemoveBlip(blip)
                                StartSellDrugsEastVinewood10()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell2 == true and SellerdrugsEastVinewood10 == false and GetDistanceBetweenCoords(coords, 1150.86, -437.91, 67.01, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsEastVinewood10 = true
                                RemoveBlip(blip)
                                StartSellDrugsEastVinewood11()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell2 == true and SellerdrugsEastVinewood11 == false and GetDistanceBetweenCoords(coords, 1123.55, -390.07, 68.51, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsEastVinewood11 = true
                                RemoveBlip(blip)
                                StartSellDrugsEastVinewood12()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell2 == true and SellerdrugsEastVinewood12 == false and GetDistanceBetweenCoords(coords, 1047.19, -454.78, 65.95, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsEastVinewood12 = true
                                RemoveBlip(blip)
                                StartSellDrugsEastVinewood13()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell2 == true and SellerdrugsEastVinewood13 == false and GetDistanceBetweenCoords(coords, 706.66, -304.81, 59.25, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsEastVinewood13 = true
                                RemoveBlip(blip)
                                StartSellDrugsEastVinewood14()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell2 == true and SellerdrugsEastVinewood14 == false and GetDistanceBetweenCoords(coords, 1073.29, -260.58, 59.08, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsEastVinewood14 = true
                                RemoveBlip(blip)
                                StartSellDrugsEastVinewood15()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell2 == true and SellerdrugsEastVinewood15 == false and GetDistanceBetweenCoords(coords, 1088.42, -271.24, 69.31, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsEastVinewood15 = true
                                RemoveBlip(blip)
                                SellerdrugsEastVinewood1 = false
                                SellerdrugsEastVinewood2 = false
                                SellerdrugsEastVinewood3 = false
                                SellerdrugsEastVinewood4 = false
                                SellerdrugsEastVinewood5 = false
                                SellerdrugsEastVinewood6 = false
                                SellerdrugsEastVinewood7 = false
                                SellerdrugsEastVinewood8 = false
                                SellerdrugsEastVinewood9 = false
                                SellerdrugsEastVinewood10 = false
                                SellerdrugsEastVinewood11 = false
                                SellerdrugsEastVinewood12 = false
                                SellerdrugsEastVinewood13 = false
                                SellerdrugsEastVinewood14 = false
                                StartSellDrugsEastVinewood()
                            end
                            end
                        end
                    end
                end
            end
        end
    end)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local coords = GetEntityCoords(PlayerPedId())
            for k,v in pairs(Config.Selling2) do
                for i = 1, #v.Pos, 1 do
                    if textsell == true then
                        if (GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < 1.5) then
                            DrawText3D(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z+1, "~w~Dzięki za towar")
                        end
                    end
                end
            end
        end
    end)
    
    --- Davis
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local coords = GetEntityCoords(GetPlayerPed(-1))
            for k,v in pairs(Config.Selling3) do
                for i = 1, #v.Pos, 1 do
                    if(Config.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < 5) then
                        nodisplay = true
                        if PlayerData.job ~= nil and PlayerData.job.name == 'dealer' then
                            TriggerServerEvent("srp_drugs:HasitemsWeed")
                            if HasitemsWeed == true and Timesell3 == true and SellerdrugsDavis1 == false and GetDistanceBetweenCoords(coords, 127.61, -1770.02, 29.42, false) <= 1.5 then
                                DrawText3D(127.61, -1770.02, 29.42, "~g~[E] ~w~Aby sprzedać")
                            end
                            if HasitemsWeed == true and Timesell3 == true and SellerdrugsDavis2 == false and GetDistanceBetweenCoords(coords, 103.66, -1715.92, 30.11, false) <= 1.5 then
                                DrawText3D(103.66, -1715.92, 30.11, "~g~[E] ~w~Aby sprzedać")
                            end
                            if HasitemsWeed == true and Timesell3 == true and SellerdrugsDavis3 == false and GetDistanceBetweenCoords(coords, 147.70, -1702.15, 29.29, false) <= 1.5 then
                                DrawText3D(147.70, -1702.15, 29.29, "~g~[E] ~w~Aby sprzedać")
                            end
                            if HasitemsWeed == true and Timesell3 == true and SellerdrugsDavis4 == false and GetDistanceBetweenCoords(coords, 180.73, -1706.59, 29.29, false) <= 1.5 then
                                DrawText3D(180.73, -1706.59, 29.29, "~g~[E] ~w~Aby sprzedać")
                            end
                            if HasitemsWeed == true and Timesell3 == true and SellerdrugsDavis5 == false and GetDistanceBetweenCoords(coords, 206.99, -1684.94, 29.60, false) <= 1.5 then
                                DrawText3D(206.99, -1684.94, 29.60, "~g~[E] ~w~Aby sprzedać")
                            end
                            if HasitemsWeed == true and Timesell3 == true and SellerdrugsDavis6 == false and GetDistanceBetweenCoords(coords, 225.30, -1760.85, 28.70, false) <= 1.5 then
                                DrawText3D(225.30, -1760.85, 28.70, "~g~[E] ~w~Aby sprzedać")
                            end
                            if HasitemsWeed == true and Timesell3 == true and SellerdrugsDavis7 == false and GetDistanceBetweenCoords(coords, 262.27, -1782.46, 27.11, false) <= 1.5 then
                                DrawText3D(262.27, -1782.46, 27.11, "~g~[E] ~w~Aby sprzedać")
                            end
                            if HasitemsWeed == true and Timesell3 == true and SellerdrugsDavis8 == false and GetDistanceBetweenCoords(coords, 254.10, -1849.77, 19.08, false) <= 1.5 then
                                DrawText3D(254.10, -1849.77, 19.08, "~g~[E] ~w~Aby sprzedać")
                            end
                            if HasitemsWeed == true and Timesell3 == true and SellerdrugsDavis9 == false and GetDistanceBetweenCoords(coords, 192.14, -1839.35, 28.07, false) <= 1.5 then
                                DrawText3D(192.14, -1839.35, 28.07, "~g~[E] ~w~Aby sprzedać")
                            end
                            if HasitemsWeed == true and Timesell3 == true and SellerdrugsDavis10 == false and GetDistanceBetweenCoords(coords, 142.89, -1973.58, 18.50, false) <= 1.5 then
                                DrawText3D(142.89, -1973.58, 18.50, "~g~[E] ~w~Aby sprzedać")
                            end
                            if HasitemsWeed == true and Timesell3 == true and SellerdrugsDavis11 == false and GetDistanceBetweenCoords(coords, 40.55, -1913.61, 21.95, false) <= 1.5 then
                                DrawText3D(40.55, -1913.61, 21.95, "~g~[E] ~w~Aby sprzedać")
                            end
    
                            if HasitemsWeed == false and Timesell3 == false then
                                DrawText3D(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, "~w~Nie masz wystarczającej ilości narkotyków na sprzedaż")
                            end
                        end
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
    
            for k,v in pairs(Config.Selling3) do
                for i = 1, #v.Pos, 1 do
                    if PlayerData.job ~= nil and PlayerData.job.name == 'dealer' then
                        local inveh = IsPedInAnyVehicle(GetPlayerPed(-1), false)
                        if HasitemsWeed == true and Timesell3 == true and SellerdrugsDavis1 == false and GetDistanceBetweenCoords(coords, 127.61, -1770.02, 29.42, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsDavis1 = true
                                SellerdrugsDavis11 = false
                                RemoveBlip(blip)
                                StartSellDrugsDavis2()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell3 == true and SellerdrugsDavis2 == false and GetDistanceBetweenCoords(coords, 103.66, -1715.92, 30.11, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsDavis2 = true
                                RemoveBlip(blip)
                                StartSellDrugsDavis3()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell3 == true and SellerdrugsDavis3 == false and GetDistanceBetweenCoords(coords, 147.70, -1702.15, 29.29, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsDavis3 = true
                                RemoveBlip(blip)
                                StartSellDrugsDavis4()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell3 == true and SellerdrugsDavis4 == false and GetDistanceBetweenCoords(coords, 180.73, -1706.59, 29.29, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsDavis4 = true
                                RemoveBlip(blip)
                                StartSellDrugsDavis5()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell3 == true and SellerdrugsDavis5 == false and GetDistanceBetweenCoords(coords, 206.99, -1684.94, 29.60, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsDavis5 = true
                                RemoveBlip(blip)
                                StartSellDrugsDavis6()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell3 == true and SellerdrugsDavis6 == false and GetDistanceBetweenCoords(coords, 225.30, -1760.85, 28.70, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsDavis6 = true
                                RemoveBlip(blip)
                                StartSellDrugsDavis7()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell3 == true and SellerdrugsDavis7 == false and GetDistanceBetweenCoords(coords, 262.27, -1782.46, 27.11, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsDavis7 = true
                                RemoveBlip(blip)
                                StartSellDrugsDavis8()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell3 == true and SellerdrugsDavis8 == false and GetDistanceBetweenCoords(coords, 254.10, -1849.77, 19.08, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsDavis8 = true
                                RemoveBlip(blip)
                                StartSellDrugsDavis9()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell3 == true and SellerdrugsDavis9 == false and GetDistanceBetweenCoords(coords, 192.14, -1839.35, 28.07, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsDavis9 = true
                                RemoveBlip(blip)
                                StartSellDrugsDavis10()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell3 == true and SellerdrugsDavis10 == false and GetDistanceBetweenCoords(coords, 142.89, -1973.58, 18.50, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsDavis10 = true
                                RemoveBlip(blip)
                                StartSellDrugsDavis11()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell3 == true and SellerdrugsDavis11 == false and GetDistanceBetweenCoords(coords, 40.55, -1913.61, 21.95, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsDavis11 = true
                                RemoveBlip(blip)
                                SellerdrugsDavis1 = false
                                SellerdrugsDavis2 = false
                                SellerdrugsDavis3 = false
                                SellerdrugsDavis4 = false
                                SellerdrugsDavis5 = false
                                SellerdrugsDavis6 = false
                                SellerdrugsDavis7 = false
                                SellerdrugsDavis8 = false
                                SellerdrugsDavis9 = false
                                SellerdrugsDavis10 = false
                                StartSellDrugsDavis()
                            end
                            end
                        end
                    end
                end
            end
        end
    end)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local coords = GetEntityCoords(PlayerPedId())
            for k,v in pairs(Config.Selling3) do
                for i = 1, #v.Pos, 1 do
                    if textsell == true then
                        if (GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < 1.5) then
                            DrawText3D(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z+1, "~w~Dzięki za towar")
                        end
                    end
                end
            end
        end
    end)
    
    --- Strawberry
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local coords = GetEntityCoords(GetPlayerPed(-1))
            for k,v in pairs(Config.Selling4) do
                for i = 1, #v.Pos, 1 do
                    if(Config.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < 5) then
                        nodisplay = true
                        if PlayerData.job ~= nil and PlayerData.job.name == 'dealer' then
                            TriggerServerEvent("srp_drugs:HasitemsWeed")
                            if HasitemsWeed == true and Timesell4 == true and SellerdrugsStrawberry1 == false and GetDistanceBetweenCoords(coords, 232.42, -1361.13, 27.65, false) <= 1.5 then
                                DrawText3D(232.42, -1361.13, 28.65, "~g~[E] ~w~Aby sprzedać")
                            end
                            if HasitemsWeed == true and Timesell4 == true and SellerdrugsStrawberry2 == false and GetDistanceBetweenCoords(coords, 294.58, -1252.02, 28.43, false) <= 1.5 then
                                DrawText3D(294.58, -1252.02, 29.43, "~g~[E] ~w~Aby sprzedać")
                            end
                            if HasitemsWeed == true and Timesell4 == true and SellerdrugsStrawberry3 == false and GetDistanceBetweenCoords(coords, 341.37, -1270.65, 31.09, false) <= 1.5 then
                                DrawText3D(341.37, -1270.65, 32.09, "~g~[E] ~w~Aby sprzedać")
                            end
                            if HasitemsWeed == true and Timesell4 == true and SellerdrugsStrawberry4 == false and GetDistanceBetweenCoords(coords, 406.47, -1348.03, 30.05, false) <= 1.5 then
                                DrawText3D(406.47, -1348.03, 31.05, "~g~[E] ~w~Aby sprzedać")
                            end
                            if HasitemsWeed == true and Timesell4 == true and SellerdrugsStrawberry5 == false and GetDistanceBetweenCoords(coords, 420.82, -1489.55, 28.29, false) <= 1.5 then
                                DrawText3D(420.82, -1489.55, 29.29, "~g~[E] ~w~Aby sprzedać")
                            end
                            if HasitemsWeed == true and Timesell4 == true and SellerdrugsStrawberry6 == false and GetDistanceBetweenCoords(coords, 485.67, -1477.01, 28.29, false) <= 1.5 then
                                DrawText3D(485.67, -1477.01, 29.29, "~g~[E] ~w~Aby sprzedać")
                            end
                            if HasitemsWeed == true and Timesell4 == true and SellerdrugsStrawberry7 == false and GetDistanceBetweenCoords(coords, 456.11, -1318.37, 28.32, false) <= 1.5 then
                                DrawText3D(456.11, -1318.37, 29.32, "~g~[E] ~w~Aby sprzedać")
                            end
                            if HasitemsWeed == true and Timesell4 == true and SellerdrugsStrawberry8 == false and GetDistanceBetweenCoords(coords, 184.45, -1513.69, 28.14, false) <= 1.5 then
                                DrawText3D(184.45, -1513.69, 29.14, "~g~[E] ~w~Aby sprzedać")
                            end
                            if HasitemsWeed == true and Timesell4 == true and SellerdrugsStrawberry9 == false and GetDistanceBetweenCoords(coords, 318.19, -1631.85, 31.53, false) <= 1.5 then
                                DrawText3D(318.19, -1631.85, 30.53, "~g~[E] ~w~Aby sprzedać")
                            end
    
    
                            if HasitemsWeed == false and Timesell4 == false then
                                DrawText3D(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, "~w~Nie masz wystarczającej ilości narkotyków na sprzedaż")
                            end
                        end
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
    
            for k,v in pairs(Config.Selling4) do
                for i = 1, #v.Pos, 1 do
                    if PlayerData.job ~= nil and PlayerData.job.name == 'dealer' then
                        local inveh = IsPedInAnyVehicle(GetPlayerPed(-1), false)
                        if HasitemsWeed == true and Timesell4 == true and SellerdrugsStrawberry1 == false and GetDistanceBetweenCoords(coords, 232.42, -1361.13, 27.65, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsStrawberry1 = true
                                SellerdrugsStrawberry9 = false
                                RemoveBlip(blip)
                                StartSellDrugsStrawberry2()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell4 == true and SellerdrugsStrawberry2 == false and GetDistanceBetweenCoords(coords, 294.58, -1252.02, 28.43, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsStrawberry2 = true
                                RemoveBlip(blip)
                                StartSellDrugsStrawberry3()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell4 == true and SellerdrugsStrawberry3 == false and GetDistanceBetweenCoords(coords, 341.37, -1270.65, 31.09, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsStrawberry3 = true
                                RemoveBlip(blip)
                                StartSellDrugsStrawberry4()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell4 == true and SellerdrugsStrawberry4 == false and GetDistanceBetweenCoords(coords, 406.47, -1348.03, 30.05, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsStrawberry4 = true
                                RemoveBlip(blip)
                                StartSellDrugsStrawberry5()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell4 == true and SellerdrugsStrawberry5 == false and GetDistanceBetweenCoords(coords, 420.82, -1489.55, 28.29, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsStrawberry5 = true
                                RemoveBlip(blip)
                                StartSellDrugsStrawberry6()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell4 == true and SellerdrugsStrawberry6 == false and GetDistanceBetweenCoords(coords, 485.67, -1477.01, 28.29, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsStrawberry6 = true
                                RemoveBlip(blip)
                                StartSellDrugsStrawberry7()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell4 == true and SellerdrugsStrawberry7 == false and GetDistanceBetweenCoords(coords, 456.11, -1318.37, 28.32, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsStrawberry7 = true
                                RemoveBlip(blip)
                                StartSellDrugsStrawberry8()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell4 == true and SellerdrugsStrawberry8 == false and GetDistanceBetweenCoords(coords, 184.45, -1513.69, 28.14, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsStrawberry8 = true
                                RemoveBlip(blip)
                                StartSellDrugsStrawberry9()
                            end
                            end
                        end
                        if HasitemsWeed == true and Timesell4 == true and SellerdrugsStrawberry9 == false and GetDistanceBetweenCoords(coords, 318.19, -1631.85, 31.53, false) <= 1.5 then
                            if IsControlJustReleased(0, Keys['E']) then
                                if inveh then
                                    exports['mythic_notify']:DoCustomHudText('error', 'Nie możesz rozmawiać siedząc w samochodzie!', 3500)
                                else
                                textsell = true
                                exports['mythic_progbar']:Progress({
                                    name = "selldrugs_pedprogbar",
                                    duration = 10000,
                                    label = "Sprzedaż Marihuany...",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "mp_common",
                                        anim = "givetake1_a",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "prop_paper_bag_small",
                                        bone = 57005,
                                        coords = { x = 0.10, y = 0.02, z = 0.00 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                })
                                Citizen.Wait(10000)
                                ClearPedTasks(GetPlayerPed(-1))
                                textsell = false
                                
                                TriggerServerEvent('srp_drugs:selldrugs')
                                SellerdrugsStrawberry9 = true
                                RemoveBlip(blip)
                                SellerdrugsStrawberry1 = false
                                SellerdrugsStrawberry2 = false
                                SellerdrugsStrawberry3 = false
                                SellerdrugsStrawberry4 = false
                                SellerdrugsStrawberry5 = false
                                SellerdrugsStrawberry6 = false
                                SellerdrugsStrawberry7 = false
                                SellerdrugsStrawberry8 = false
                                StartSellDrugsStrawberry()
                            end
                            end
                        end
                    end
                end
            end
        end
    end)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local coords = GetEntityCoords(PlayerPedId())
            for k,v in pairs(Config.Selling4) do
                for i = 1, #v.Pos, 1 do
                    if textsell == true then
                        if (GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < 1.5) then
                            DrawText3D(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z+1, "~w~Dzięki za towar")
                        end
                    end
                end
            end
        end
    end)
    
    
    ----------- Funkcja respienia peda
    local ped = nil
    local pe = nil
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
    function spawnpedsiadaj(x, y, z, h, p)
        pe = p
        RequestModel(GetHashKey(pe))
        while not HasModelLoaded(GetHashKey(pe)) do
            Wait(155)
        end
        ped =  CreatePed(4, GetHashKey(pe), x, y, z, h, false, true)
        RequestAnimDict('amb@world_human_sunbathe@female@front@idle_a')
        TaskPlayAnim(ped, 'amb@world_human_sunbathe@female@front@idle_a', 'idle_c', 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetEntityHeading(ped, h)
    end
    function spawnpedmurek(x, y, z, h, p)
        pe = p
        RequestModel(GetHashKey(pe))
        while not HasModelLoaded(GetHashKey(pe)) do
            Wait(155)
        end
        ped =  CreatePed(4, GetHashKey(pe), x, y, z, h, false, true)
        RequestAnimDict('anim@amb@board_room@diagram_blue--prints@')
        TaskPlayAnim(ped, 'anim@amb@board_room@diagram_blue--prints@', 'base_amy_skater_01', 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetEntityHeading(ped, h)
    end
    Citizen.CreateThread(function()
        ---- Informator Baron
        spawnpedmenel(Informator1.x, Informator1.y, Informator1.z, 274.19, "a_m_o_tramp_01")
        ---- Baron
        spawnpedmenel(Seller1.x, Seller1.y, Seller1.z, 352.89, "g_m_y_mexgang_01") 
        ---- Informator Dealer
        spawnpedsiadaj(Infodealer1.x, Infodealer1.y, Infodealer1.z, 83.19, "s_f_y_hooker_03") 
        ---- Dealer
        spawnpedmurek(Dealer1.x, Dealer1.y, Dealer1.z, 113.10, "csb_burgerdrug") 
        ---- Dealer przeróbka
        spawnpedmenel(DealerProcess1.x, DealerProcess1.y, DealerProcess1.z, 316.20, "ig_g")
    
       --Sprzedaż Dragów
    ------- Downtown
    local SellerDowntown1 = vector3(-47.11, -784.43, 32.12)
        spawnped(SellerDowntown1 .x, SellerDowntown1 .y, SellerDowntown1 .z, 338.34, "a_m_m_eastsa_02")
    local SellerDowntown2 = vector3(-68.19, -707.34, 33.03)
        spawnped(SellerDowntown2 .x, SellerDowntown2 .y, SellerDowntown2 .z, 161.58, "a_m_m_eastsa_02")
    local SellerDowntown3 = vector3(-185.39, -759.18, 29.45)
        spawnped(SellerDowntown3 .x, SellerDowntown3 .y, SellerDowntown3 .z, 168.59, "ig_car3guy1")
    local SellerDowntown4 = vector3(111.34, -887.78, 30.12)
        spawnped(SellerDowntown4 .x, SellerDowntown4 .y, SellerDowntown4 .z, 212.74, "ig_car3guy1")
    local SellerDowntown5 = vector3(-92.78, -860.93, 25.69)
        spawnped(SellerDowntown5 .x, SellerDowntown5 .y, SellerDowntown5 .z, 116.86, "s_m_y_dealer_01")
    local SellerDowntown6 = vector3(38.07, -1026.87, 28.56)
        spawnped(SellerDowntown6 .x, SellerDowntown6 .y, SellerDowntown6 .z, 92.65, "s_m_y_dealer_01")
    local SellerDowntown7 = vector3(-112.67, -989.89, 20.28)
        spawnped(SellerDowntown7 .x, SellerDowntown7 .y, SellerDowntown7 .z, 275.21, "s_m_y_dealer_01")
    local SellerDowntown8 = vector3(166.71, -1088.93, 28.19)
        spawnped(SellerDowntown8 .x, SellerDowntown8 .y, SellerDowntown8 .z, 310.58, "s_m_m_hairdress_01")
    local SellerDowntown9 = vector3(259.78, -783.14, 29.51)
        spawnped(SellerDowntown9 .x, SellerDowntown9 .y, SellerDowntown9 .z, 69.43, "s_m_m_hairdress_01")
    local SellerDowntown10 = vector3(148.93, -674.94, 32.12)
        spawnped(SellerDowntown10 .x, SellerDowntown10 .y, SellerDowntown10 .z, 202.13, "s_m_m_hairdress_01")
    local SellerDowntown11 = vector3(120.01, -723.86, 41.03)
        spawnped(SellerDowntown11 .x, SellerDowntown11 .y, SellerDowntown11 .z, 335.36, "a_m_m_indian_01")
    local SellerDowntown12 = vector3(139.87, -613.79, 43.22)
        spawnped(SellerDowntown12 .x, SellerDowntown12 .y, SellerDowntown12 .z, 74.60, "a_m_m_indian_01")
    local SellerDowntown13 = vector3(-88.59, -828.71, 34.44)
        spawnped(SellerDowntown13 .x, SellerDowntown13 .y, SellerDowntown13 .z, 143.92, "a_m_m_indian_01")
    local SellerDowntown14 = vector3(2.93, -713.72, 31.48)
        spawnped(SellerDowntown14 .x, SellerDowntown14 .y, SellerDowntown14 .z, 345.54, "ig_lamardavis")
    local SellerDowntown15 = vector3(-292.77, -957.64, 30.21)
        spawnped(SellerDowntown15 .x, SellerDowntown15 .y, SellerDowntown15 .z, 69.88, "ig_lamardavis")
    ------- East Vinewood
    local SellerEastVinewood1 = vector3(1005.65 ,-114.78 ,72.98)
        spawnped(SellerEastVinewood1 .x, SellerEastVinewood1 .y, SellerEastVinewood1 .z, 329.93, "a_m_m_eastsa_02")
    local SellerEastVinewood2 = vector3(871.61 ,-158.09 ,77.34)
        spawnped(SellerEastVinewood2 .x, SellerEastVinewood2 .y, SellerEastVinewood2 .z, 152.73, "a_m_m_eastsa_02")
    local SellerEastVinewood3 = vector3(895.38 ,-201.92 ,72.98)
        spawnped(SellerEastVinewood3 .x, SellerEastVinewood3 .y, SellerEastVinewood3 .z, 243.93, "a_m_m_eastsa_02")
    local SellerEastVinewood4 = vector3(927.05 , -230.6, 69.3)
        spawnped(SellerEastVinewood4 .x, SellerEastVinewood4 .y, SellerEastVinewood4 .z, 238.01, "ig_lamardavis")
    local SellerEastVinewood5 = vector3(937.31 , -231.49, 68.19)
        spawnped(SellerEastVinewood5 .x, SellerEastVinewood5 .y, SellerEastVinewood5 .z, 327.89, "ig_lamardavis")
    local SellerEastVinewood6 = vector3(1035.99 , -145.92, 73.19)
        spawnped(SellerEastVinewood6 .x, SellerEastVinewood6 .y, SellerEastVinewood6 .z, 50.11, "ig_lamardavis")
    local SellerEastVinewood7 = vector3(1168.95 , -291.71, 68.02)
        spawnped(SellerEastVinewood7 .x, SellerEastVinewood7 .y, SellerEastVinewood7 .z, 325.01, "a_m_m_indian_01")
    local SellerEastVinewood8 = vector3(1241.53 , -417.28, 70.58)
        spawnped(SellerEastVinewood8 .x, SellerEastVinewood8 .y, SellerEastVinewood8 .z, 349.83, "a_m_m_indian_01")
    local SellerEastVinewood9 = vector3(1232.39 , -455.25, 66.14)
        spawnped(SellerEastVinewood9 .x, SellerEastVinewood9 .y, SellerEastVinewood9 .z, 250.32, "a_m_m_indian_01")
    local SellerEastVinewood10 = vector3(1150.86, -437.91, 66.01)
        spawnped(SellerEastVinewood10 .x, SellerEastVinewood10 .y, SellerEastVinewood10 .z, 30.47, "a_m_m_eastsa_02")
    local SellerEastVinewood11 = vector3(1123.55 ,-390.07 ,67.51)
        spawnped(SellerEastVinewood11 .x, SellerEastVinewood11 .y, SellerEastVinewood11 .z, 247.76, "a_m_m_eastsa_02")
    local SellerEastVinewood12 = vector3(1047.19, -454.78, 64.95)
        spawnped(SellerEastVinewood12 .x, SellerEastVinewood12 .y, SellerEastVinewood12 .z, 115.14, "a_m_m_eastsa_02")
    local SellerEastVinewood13 = vector3(706.66 ,-304.81 ,58.25)
        spawnped(SellerEastVinewood13 .x, SellerEastVinewood13 .y, SellerEastVinewood13 .z, 5.98, "s_m_y_dealer_01")
    local SellerEastVinewood14 = vector3(1073.29, -260.58, 58.08)
        spawnped(SellerEastVinewood14 .x, SellerEastVinewood14 .y, SellerEastVinewood14 .z, 98.26, "s_m_y_dealer_01")
    local SellerEastVinewood15 = vector3(1088.42, -271.24, 68.31)
        spawnped(SellerEastVinewood15 .x, SellerEastVinewood15 .y, SellerEastVinewood15 .z, 150.86, "s_m_y_dealer_01")
    ---- Davis
    local SellerDavis1 = vector3(127.61, -1770.02, 28.42)
    local SellerDavis2 = vector3(103.66, -1715.92, 29.11)
    local SellerDavis3 = vector3(147.70, -1702.15, 28.29)
    local SellerDavis4 = vector3(180.73, -1706.59, 28.29)
    local SellerDavis5 = vector3(206.99, -1684.94, 28.60)
    local SellerDavis6 = vector3(225.30, -1760.85, 27.70)
    local SellerDavis7 = vector3(262.27, -1782.46, 26.11)
    local SellerDavis8 = vector3(254.10, -1849.77, 18.08)
    local SellerDavis9 = vector3(192.14, -1839.35, 27.07)
    local SellerDavis10 = vector3(142.89, -1973.58, 17.50)
    local SellerDavis11 = vector3(40.55, -1913.61, 20.95)
    local SellerDavis12 = vector3(111.49, -1799.86, 26.08)
    
    spawnped(SellerDavis1 .x, SellerDavis1 .y, SellerDavis1 .z, 86.80, "s_m_m_bouncer_01")
    spawnped(SellerDavis2 .x, SellerDavis2 .y, SellerDavis2 .z, 46.20, "csb_chef2")
    spawnped(SellerDavis3 .x, SellerDavis3 .y, SellerDavis3 .z, 88.10, "s_m_y_dealer_01")
    spawnped(SellerDavis4 .x, SellerDavis4 .y, SellerDavis4 .z, 270.01, "csb_denise_friend")
    spawnped(SellerDavis5 .x, SellerDavis5 .y, SellerDavis5 .z, 172.08, "g_m_y_famfor_01")
    spawnped(SellerDavis6 .x, SellerDavis6 .y, SellerDavis6 .z, 273.01, "a_m_m_hillbilly_02")
    spawnped(SellerDavis7 .x, SellerDavis7 .y, SellerDavis7 .z, 225.69, "a_f_y_juggalo_01")
    spawnped(SellerDavis8 .x, SellerDavis8 .y, SellerDavis8 .z, 347.01, "u_m_m_jesus_01")
    spawnped(SellerDavis9 .x, SellerDavis9 .y, SellerDavis9 .z, 165.10, "cs_lestercrest")
    spawnped(SellerDavis10 .x, SellerDavis10 .y, SellerDavis10 .z, 251.01, "g_m_y_pologoon_02")
    spawnped(SellerDavis11 .x, SellerDavis11 .y, SellerDavis11 .z, 358.01, "a_m_y_skater_01")
    spawnped(SellerDavis12 .x, SellerDavis12 .y, SellerDavis12 .z, 104.52, "a_m_y_vindouche_01")
    
    -----Strawberry
    local SellerStrawberry1 = vector3(232.43, -1361.13, 27.65)
        spawnped(SellerStrawberry1 .x, SellerStrawberry1 .y, SellerStrawberry1 .z, 53.76, "a_m_m_eastsa_02")
    local SellerStrawberry2 = vector3(294.58, -1252.02, 28.43)
        spawnped(SellerStrawberry2 .x, SellerStrawberry2 .y, SellerStrawberry2 .z, 2.29, "a_m_m_eastsa_02")
    local SellerStrawberry3 = vector3(341.37, -1270.65, 31.09)
        spawnped(SellerStrawberry3 .x, SellerStrawberry3 .y, SellerStrawberry3 .z, 89.65, "g_m_y_famfor_01")
    local SellerStrawberry4 = vector3(406.47, -1348.03, 30.05)
        spawnped(SellerStrawberry4 .x, SellerStrawberry4 .y, SellerStrawberry4 .z, 317.78, "a_m_y_skater_01")
    local SellerStrawberry5 = vector3(420.82, -1489.55, 28.29)
        spawnped(SellerStrawberry5 .x, SellerStrawberry5 .y, SellerStrawberry5 .z, 251.93, "g_m_y_famfor_01")
    local SellerStrawberry6 = vector3(485.67, -1477.01, 28.29)
        spawnped(SellerStrawberry6 .x, SellerStrawberry6 .y, SellerStrawberry6 .z, 209.88, "a_m_y_skater_01")
    local SellerStrawberry7 = vector3(456.11, -1318.37, 28.32)
        spawnped(SellerStrawberry7 .x, SellerStrawberry7 .y, SellerStrawberry7 .z, 336.69, "s_m_y_dealer_01")
    local SellerStrawberry8 = vector3(184.45, -1513.69, 28.14)
        spawnped(SellerStrawberry8 .x, SellerStrawberry8 .y, SellerStrawberry8 .z, 50.88, "s_m_y_dealer_01")
    local SellerStrawberry9 = vector3(318.19, -1631.85, 31.53)
        spawnped(SellerStrawberry9 .x, SellerStrawberry9 .y, SellerStrawberry9 .z, 51.73, "s_m_y_dealer_01")
    end)
    
    ---- Losowanie w ktorym miejscu zrespi sie ped
    function start()
        SetNewWaypoint(Seller1)
        blip = AddBlipForCoord(Seller1)
        SetBlipSprite(blip, 51)
        SetBlipScale(blip, 0.7)
        SetBlipColour(blip, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Baron narkotykowy')
        EndTextCommandSetBlipName(blip)
        Citizen.Wait(900000)
        RemoveBlip(blip)
    end
    
    function start2()
        SetNewWaypoint(Dealer1)
        blip = AddBlipForCoord(Dealer1)
        SetBlipSprite(blip, 140)
        SetBlipScale(blip, 0.7)
        SetBlipColour(blip, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Dealer narkotykowy')
        EndTextCommandSetBlipName(blip)
        Citizen.Wait(900000)
        RemoveBlip(blip)
    end
    
    function start3()
        SetNewWaypoint(DealerProcess1)
        blip = AddBlipForCoord(DealerProcess1)
        SetBlipSprite(blip, 140)
        SetBlipScale(blip, 0.7)
        SetBlipColour(blip, 3)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Dealer')
        EndTextCommandSetBlipName(blip)
        Citizen.Wait(900000)
        RemoveBlip(blip)
    end
    
    
    
    -- Downtown
    
    function StartSellDrugsDowntown()
        if SellerdrugsDowntown1 == false then
            RemoveBlip(blip)
            SetNewWaypoint(-47.11, -784.43, 33.12)
            blip = AddBlipForCoord(-47.11, -784.43, 33.12)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsDowntown1!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsDowntown2()
        if SellerdrugsDowntown2 == false then
            RemoveBlip(blip1)
            SetNewWaypoint(-68.19, -707.34, 34.03)
            blip = AddBlipForCoord(-68.19, -707.34, 34.03)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsDowntown2!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsDowntown3()
        if SellerdrugsDowntown3 == false then
            RemoveBlip(blip)
            SetNewWaypoint(-185.39, -759.18, 30.45)
            blip = AddBlipForCoord(-185.39, -759.18, 30.45)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsDowntown3!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    
    function StartSellDrugsDowntown4()
        if SellerdrugsDowntown4 == false then
            RemoveBlip(blip)
            SetNewWaypoint(111.34, -887.78, 31.12)
            blip = AddBlipForCoord(111.34, -887.78, 31.12)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsDowntown4!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsDowntown5()
        if SellerdrugsDowntown5 == false then
            RemoveBlip(blip)
            SetNewWaypoint(-92.78, -860.93, 26.69)
            blip = AddBlipForCoord(-92.78, -860.93, 26.69)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsDowntown5!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsDowntown6()
        if SellerdrugsDowntown6 == false then
            RemoveBlip(blip)
            SetNewWaypoint(38.07, -1026.87, 29.56)
            blip = AddBlipForCoord(38.07, -1026.87, 29.56)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsDowntown6!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsDowntown7()
        if SellerdrugsDowntown7 == false then
            RemoveBlip(blip)
            SetNewWaypoint(-112.67, -989.89, 21.28)
            blip = AddBlipForCoord(-112.67, -989.89, 21.28)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsDowntown7!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsDowntown8()
        if SellerdrugsDowntown8 == false then
            RemoveBlip(blip)
            SetNewWaypoint(166.71, -1088.93, 29.19)
            blip = AddBlipForCoord(166.71, -1088.93, 29.19)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsDowntown8!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsDowntown9()
        if SellerdrugsDowntown9 == false then
            RemoveBlip(blip)
            SetNewWaypoint(259.78, -783.14, 30.51)
            blip = AddBlipForCoord(259.78, -783.14, 30.51)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsDowntown9!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsDowntown10()
        if SellerdrugsDowntown10 == false then
            RemoveBlip(blip)
            SetNewWaypoint(148.93, -674.94, 33.12)
            blip = AddBlipForCoord(148.93, -674.94, 33.12)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsDowntown10!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsDowntown11()
        if SellerdrugsDowntown11 == false then
            RemoveBlip(blip)
            SetNewWaypoint(120.01, -723.86, 42.03)
            blip = AddBlipForCoord(120.01, -723.86, 42.03)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsDowntown11!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsDowntown12()
        if SellerdrugsDowntown12 == false then
            RemoveBlip(blip)
            SetNewWaypoint(139.87, -613.79, 44.22)
            blip = AddBlipForCoord(139.87, -613.79, 44.22)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsDowntown12!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsDowntown13()
        if SellerdrugsDowntown13 == false then
            RemoveBlip(blip)
            SetNewWaypoint(-88.59, -828.71, 35.44)
            blip = AddBlipForCoord(-88.59, -828.71, 35.44)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsDowntown13!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsDowntown14()
        if SellerdrugsDowntown14 == false then
            RemoveBlip(blip)
            SetNewWaypoint(2.93, -713.72, 32.48)
            blip = AddBlipForCoord(2.93, -713.72, 32.48)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsDowntown14!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsDowntown15()
        if SellerdrugsDowntown15 == false then
            RemoveBlip(blip)
            SetNewWaypoint(-292.77, -957.64, 31.21)
            blip = AddBlipForCoord(-292.77, -957.64, 31.21)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsDowntown15!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    
    -- East Vinewood
    function StartSellDrugsEastVinewood()
        if SellerdrugsEastVinewood1 == false then
        RemoveBlip(blip)
            SetNewWaypoint(1005.65 ,-114.78 ,73.98)
            blip = AddBlipForCoord(1005.65 ,-114.78 ,73.98)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsEastVinewood1!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsEastVinewood2()
        if SellerdrugsEastVinewood2 == false then
        RemoveBlip(blip1)
            SetNewWaypoint(871.61 ,-158.09 ,78.34)
            blip = AddBlipForCoord(871.61 ,-158.09 ,78.34)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsEastVinewood2!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsEastVinewood3()
        if SellerdrugsEastVinewood3 == false then
        RemoveBlip(blip)
            SetNewWaypoint(895.38 ,-201.92 ,71.98)
            blip = AddBlipForCoord(895.38 ,-201.92 ,71.98)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsEastVinewood3!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsEastVinewood4()
        if SellerdrugsEastVinewood4 == false then
        RemoveBlip(blip)
            SetNewWaypoint(927.05 , -230.6, 70.3)
            blip = AddBlipForCoord(927.05 , -230.6, 70.3)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsEastVinewood4!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsEastVinewood5()
        if SellerdrugsEastVinewood5 == false then
        RemoveBlip(blip)
            SetNewWaypoint(937.31 , -231.49, 69.19)
            blip = AddBlipForCoord(937.31 , -231.49, 69.19)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsEastVinewood5!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsEastVinewood6()
        if SellerdrugsEastVinewood6 == false then
        RemoveBlip(blip)
            SetNewWaypoint(1035.99 , -145.92, 74.19)
            blip = AddBlipForCoord(1035.99 , -145.92, 74.19)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsEastVinewood6!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsEastVinewood7()
        if SellerdrugsEastVinewood7 == false then
        RemoveBlip(blip)
            SetNewWaypoint(1168.95 , -291.71, 69.02)
            blip = AddBlipForCoord(1168.95 , -291.71, 69.02)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsEastVinewood7!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsEastVinewood8()
        if SellerdrugsEastVinewood8 == false then
        RemoveBlip(blip)
            SetNewWaypoint(1241.53 , -417.28, 71.58)
            blip = AddBlipForCoord(1241.53 , -417.28, 71.58)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsEastVinewood8!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsEastVinewood9()
        if SellerdrugsEastVinewood9 == false then
        RemoveBlip(blip)
            SetNewWaypoint(1232.39 , -455.25, 67.14)
            blip = AddBlipForCoord(1232.39 , -455.25, 67.14)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsEastVinewood9!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsEastVinewood10()
        if SellerdrugsEastVinewood10 == false then
        RemoveBlip(blip)
            SetNewWaypoint(1150.86, -437.91, 67.01)
            blip = AddBlipForCoord(1150.86, -437.91, 67.01)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsEastVinewood10!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsEastVinewood11()
        if SellerdrugsEastVinewood11 == false then
        RemoveBlip(blip)
            SetNewWaypoint(1123.55 ,-390.07 ,68.51)
            blip = AddBlipForCoord(1123.55 ,-390.07 ,68.51)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsEastVinewood11!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsEastVinewood12()
        if SellerdrugsEastVinewood12 == false then
        RemoveBlip(blip)
            SetNewWaypoint(1047.19, -454.78, 65.95)
            blip = AddBlipForCoord(1047.19, -454.78, 65.95)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsEastVinewood12!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsEastVinewood13()
        if SellerdrugsEastVinewood13 == false then
        RemoveBlip(blip)
            SetNewWaypoint(706.66 ,-304.81 ,59.25)
            blip = AddBlipForCoord(706.66 ,-304.81 ,59.25)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsEastVinewood13!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsEastVinewood14()
        if SellerdrugsEastVinewood14 == false then
        RemoveBlip(blip)
            SetNewWaypoint(1073.29, -260.58, 59.08)
            blip = AddBlipForCoord(1073.29, -260.58, 59.08)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsEastVinewood14!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsEastVinewood15()
        if SellerdrugsEastVinewood15 == false then
        RemoveBlip(blip)
            SetNewWaypoint(1088.42, -271.24, 69.31)
            blip = AddBlipForCoord(1088.42, -271.24, 69.31)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsEastVinewood15!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    
    -- Davis
    function StartSellDrugsDavis()
        if SellerdrugsDavis1 == false then
        RemoveBlip(blip)
            SetNewWaypoint(127.61, -1770.02, 29.42)
            blip = AddBlipForCoord(127.61, -1770.02, 29.42)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsDavis1!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsDavis2()
        if SellerdrugsDavis2 == false then
            RemoveBlip(blip)
            SetNewWaypoint(103.66, -1715.92, 30.11)
            blip = AddBlipForCoord(103.66, -1715.92, 30.11)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsDavis2!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsDavis3()
        if SellerdrugsDavis3 == false then
        RemoveBlip(blip)
            SetNewWaypoint(147.70, -1702.15, 29.29)
            blip = AddBlipForCoord(147.70, -1702.15, 29.29)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsDavis3!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsDavis4()
        if SellerdrugsDavis4 == false then
        RemoveBlip(blip)
            SetNewWaypoint(180.73, -1706.59, 29.29)
            blip = AddBlipForCoord(180.73, -1706.59, 29.29)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsDavis4!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsDavis5()
        if SellerdrugsDavis5 == false then
        RemoveBlip(blip)
            SetNewWaypoint(206.99, -1684.94, 29.60)
            blip = AddBlipForCoord(206.99, -1684.94, 29.60)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsDavis5!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsDavis6()
        if SellerdrugsDavis6 == false then
        RemoveBlip(blip)
            SetNewWaypoint(225.30, -1760.85, 28.70)
            blip = AddBlipForCoord(225.30, -1760.85, 28.70)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsDavis6!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsDavis7()
        if SellerdrugsDavis7 == false then
        RemoveBlip(blip)
            SetNewWaypoint(262.27, -1782.46, 27.11)
            blip = AddBlipForCoord(262.27, -1782.46, 27.11)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsDavis7!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsDavis8()
        if SellerdrugsDavis8 == false then
        RemoveBlip(blip)
            SetNewWaypoint(254.10, -1849.77, 19.08)
            blip = AddBlipForCoord(254.10, -1849.77, 19.08)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsDavis8!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsDavis9()
        if SellerdrugsDavis9 == false then
        RemoveBlip(blip)
            SetNewWaypoint(192.14, -1839.35, 28.07)
            blip = AddBlipForCoord(192.14, -1839.35, 28.07)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsDavis9!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsDavis10()
        if SellerdrugsDavis10 == false then
        RemoveBlip(blip)
            SetNewWaypoint(142.89, -1973.58, 18.50)
            blip = AddBlipForCoord(142.89, -1973.58, 18.50)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsDavis10!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsDavis11()
        if SellerdrugsDavis11 == false then
        RemoveBlip(blip)
            SetNewWaypoint(40.55, -1913.61, 21.95)
            blip = AddBlipForCoord(40.55, -1913.61, 21.95)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsDavis11!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    -- Strawberry
    function StartSellDrugsStrawberry()
        if SellerdrugsStrawberry1 == false then
            RemoveBlip(blip)
            SetNewWaypoint(232.42, -1361.13, 27.65)
            blip = AddBlipForCoord(232.42, -1361.13, 27.65)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsStrawberry1!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsStrawberry2()
        if SellerdrugsStrawberry2 == false then
            RemoveBlip(blip)
            SetNewWaypoint(294.58, -1252.02, 28.43)
            blip = AddBlipForCoord(294.58, -1252.02, 28.43)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsStrawberry2!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsStrawberry3()
        if SellerdrugsStrawberry3 == false then
            RemoveBlip(blip)
            SetNewWaypoint(341.37, -1270.65, 31.09)
            blip = AddBlipForCoord(341.37, -1270.65, 31.09)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsStrawberry3!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsStrawberry4()
        if SellerdrugsStrawberry4 == false then
            RemoveBlip(blip)
            SetNewWaypoint(406.47, -1348.03, 30.05)
            blip = AddBlipForCoord(406.47, -1348.03, 30.05)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsStrawberry4!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsStrawberry5()
        if SellerdrugsStrawberry5 == false then
            RemoveBlip(blip)
            SetNewWaypoint(420.82, -1489.55, 28.29)
            blip = AddBlipForCoord(420.82, -1489.55, 28.29)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsStrawberry5!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsStrawberry6()
        if SellerdrugsStrawberry6 == false then
            RemoveBlip(blip)
            SetNewWaypoint(485.67, -1477.01, 28.29)
            blip = AddBlipForCoord(485.67, -1477.01, 28.29)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsStrawberry6!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsStrawberry7()
        if SellerdrugsStrawberry7 == false then
            RemoveBlip(blip)
            SetNewWaypoint(456.11, -1318.37, 28.32)
            blip = AddBlipForCoord(456.11, -1318.37, 28.32)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsStrawberry7!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsStrawberry8()
        if SellerdrugsStrawberry8 == false then
            RemoveBlip(blip)
            SetNewWaypoint(184.45, -1513.69, 28.14)
            blip = AddBlipForCoord(184.45, -1513.69, 28.14)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsStrawberry8!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    function StartSellDrugsStrawberry9()
        if SellerdrugsStrawberry9 == false then
            RemoveBlip(blip)
            SetNewWaypoint(318.19, -1631.85, 31.53)
            blip = AddBlipForCoord(318.19, -1631.85, 31.53)
            --print("[DEBUG] Twój sprzedawca to SellerdrugsStrawberry9!")
            SetBlipSprite(blip, 500)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Klient')
            EndTextCommandSetBlipName(blip)
        end
    end
    
    
    --[Inne funkcje]--
    ---- Tekst 3D
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
    
    function LoadDict(dict)
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
              Citizen.Wait(10)
        end
    end
    
    --powiadamianie LSPD przy sprzedaży dla LSPD
    
    RegisterNetEvent('zrider:sellerTracker')
    AddEventHandler('zrider:sellerTracker', function()
        --koordynaty gracza
        --local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
        --local playerX = tonumber(string.format("%.2f", x))
        --local playerY = tonumber(string.format("%.2f", y))
        --local playerZ = tonumber(string.format("%.2f", z))
        --local street_hash = GetStreetNameAtCoord(x, y, z)
        --local street_name = GetStreetNameFromHashKey(street_hash)
        --Citizen.Trace('-------------------------------')
        --Citizen.Trace('X '..x..' Y '..y..' Z '..z)
        --TriggerServerEvent('zrider:infodlalspd',x,y,z,playerX,playerY,playerZ,street_name)
        local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
        local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
        local street1 = GetStreetNameFromHashKey(s1)
        local street2 = GetStreetNameFromHashKey(s2)
        local current_zone = zones[GetNameOfZone(plyPos.x, plyPos.y, plyPos.z)]
        for k,v in pairs(directions)do
            direction = GetEntityHeading(GetPlayerPed(-1))
            if(math.abs(direction - k) < 22.5)then
                direction = v
                break;
            end
        end
        DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 2)
        local playerPed = GetPlayerPed(-1)
        local coords    = GetEntityCoords(playerPed)
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
            local sex = nil
            if skin.sex == 0 then
                sex = "Mężczyzna"
            else
                sex = "Kobieta"
            end
            TriggerServerEvent('drugInProgressPos', plyPos.x, plyPos.y, plyPos.z)
            if s2 == 0 then
                TriggerServerEvent('drugInProgressS1', street1, sex, current_zone, direction)
            elseif s2 ~= 0 then
                TriggerServerEvent('drugInProgress', street1, street2, sex, current_zone, direction)
            end
        end)
    
    
    end)
    
    RegisterNetEvent('zrider:infodlalspd')
    AddEventHandler('zrider:infodlalspd', function(x,y,z,playerX,playerY,playerZ,street_name)
        local xLoc = tonumber(x)
        local yLoc = tonumber(y)
        local zLoc = tonumber(z)
        PlayerData = ESX.GetPlayerData()
        if PlayerData.job ~= nil then
            if PlayerData.job.name == 'police' or PlayerData.job.name == 'statepolice' or PlayerData.job.name == 'sheriff' then
            
                --exports['mythic_notify']:DoCustomHudText('inform', 'Doniesiono o sprzedaży narkotyków w okolicy '..street_name..'!', 3500)
                
                PlaySoundFrontend(-1, "HACKING_CLICK_GOOD", 0, 1)
                
                local blip = AddBlipForCoord(xLoc, yLoc, zLoc)
                SetBlipSprite(blip, 140)
                SetBlipScale(blip, 1)
                SetBlipColour(blip, 1)
                SetBlipAlpha(blip, 255)
                SetBlipHighDetail(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString('Sprzedaż narko')
                EndTextCommandSetBlipName(blip)
    
                local blip2 = AddBlipForRadius(xLoc,yLoc,zLoc,100)
                SetBlipAlpha(blip2,250)
                SetBlipSprite(blip2, 9)
                SetBlipColour(blip2,1)
                Citizen.Wait(15000)
                RemoveBlip(blip2)
                Citizen.Wait(25000)
                RemoveBlip(blip)
            end
        end
    end)
    
    -- function DaysBetweenManualDrugs (day_zero,month_zero,year_zero)
    --     local month_days = {31,29,31,30,31,30,31,31,30,31,30,31}
    --     --local current_year = GetClockYear()
    --     --local current_month = GetClockMonth()
    --     --local current_day = GetClockDayOfMonth()
    --     local current_year , current_month, current_day , hour , minute , second  = GetLocalTime()
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
    --         if DivByNumberDrugs(year_for_for,4) and not DivByNumberDrugs(year_for_for,100) then
    --             if i==1 and month_zero>2 then
                    
    --             elseif i==diff_years and current_month<3 then
                    
    --             else
    --             total_days = total_days + 1
    --             end
    --         else
    --             if DivByNumberDrugs(year_for_for,400) then
    --                 total_days = total_days + 1
    --             end
    --         end
    
    --         year_for_for = year_for_for+1
    --     end
        
    --     return total_days
    --  end
    
    
    
    --  function DivByNumberDrugs(number_to_div,number_to_div_by)
    --     if number_to_div - math.floor(number_to_div/number_to_div_by)*number_to_div_by == 0 then
    --         return true
    --     else
    --         return false
    --     end
    --  end
    
    --  function DayTodayDrugs()
    --     local year_c , month_c, day_c , hour , minute , second  = GetLocalTime()
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