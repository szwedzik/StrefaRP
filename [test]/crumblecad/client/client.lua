local ESX = nil
local name = {}

---------------------------------------------------
--==================Threads======================--
---------------------------------------------------

Citizen.CreateThread(function()
    
    SetNuiFocus(false, false)
    SendNUIMessage(({type = 'closecad'})) --incase of script restarts
    
    while ESX == nil do
        TriggerEvent('esx:getSharedObject',function(obj) ESX = obj end)
        Citizen.Wait(250)
    end
    
    while not ESX.IsPlayerLoaded() do --This hangs for esx_kashacters
        Citizen.Wait(250)
    end
    
    local hang = true
    local coords = GetEntityCoords(PlayerPedId())
    
    while hang do   --This hangs for esx_identity
        Citizen.Wait(1000)
        local newCoords = GetEntityCoords(PlayerPedId())
        if GetDistanceBetweenCoords(coords, newCoords, false) > 5.0 then
            hang = false
        end
    end

    TriggerEvent('skinchanger:getSkin', function(skin) --send skin over incase old player not registered
        TriggerServerEvent('cadUser:Register', skin)
    end)


    
    if ESX.GetPlayerData(PlayerPedId()).job.name == 'police' then
        ESX.TriggerServerCallback('crumbleCad:getOfficerName', function(cb)
            if cb then
                while true do 
                    Citizen.Wait(0)
                    if IsControlJustReleased(0, 38) then
                        SetNuiFocus(true, true)
                        SendNUIMessage(({
                            type = 'opencad',
                            name = cb
                        }))
                    end
                end
            end
        end)
    end
end)

---------------------------------------------------
--===============NUI CALL BACKS==================--
---------------------------------------------------
RegisterNUICallback('closeCad',function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage(({type = 'closecad'}))
end)


---------------------------------------------------
--==========Start of citizen searches============--
---------------------------------------------------

RegisterNUICallback('citizenSearch',function(data, cb) --inital seaqrch for citizen
    
    ESX.TriggerServerCallback('crumbleCad:getCitizen', function(_info, _fines, _warrants)
        Citizen.Wait(100)
        
        if _info ~= false then
            SetNuiFocus(true, true)
            SendNUIMessage(
            ({
                type = 'citizenResult',
                info = _info
            }))
            
        elseif _info == false then
            
            SetNuiFocus(true, true)
            SendNUIMessage(
            
            ({
                type = 'citizenResult',
                info = nil
            }))
            
        end
        
    end, data)
end)

RegisterNUICallback('getFines', function(data) --pulls citizen fines
    
    ESX.TriggerServerCallback('crumbleCad:getFines', function(cb)
        
        if cb ~= false then
            SendNUIMessage(
            ({
                type = 'fineResult',
                info = cb
            }))
        else
            SendNUIMessage(
            ({
                type = 'fineResult',
                info = nil
            }))
        end
    end, data)
    
end)

RegisterNUICallback('getWarrants', function(data) --pulls citizen warrants
    
    ESX.TriggerServerCallback('crumbleCad:getWarrants', function(cb)
        
        if cb ~= false then
            SendNUIMessage(
            ({
                type = 'warrantResult',
                info = cb
            }))
        else
            SendNUIMessage(
            ({
                type = 'warrantResult',
                info = nil
            }))
        end
    end, data)
end)

RegisterNUICallback('citizenIncidents', function(data) --pulls citizen reports
    
    ESX.TriggerServerCallback('crumbleCad:GetCitizenIncidents', function(cb)
        
        if cb then
            SendNUIMessage(({
                type = 'citizenReports',
                info = cb
            }))
        else
            SendNUIMessage(({
                type = 'citizenReports',
                info = nil
            }))
        end
        
    end, data)
    
end)

RegisterNUICallback('getConvictions', function(data) --pulls citizen convictions
    
    ESX.TriggerServerCallback('crumbleCad:getConvictions', function(cb)
        if cb then
            SendNUIMessage(({
                type = 'citizenConvictions',
                info = cb
            }))
        else
            SendNUIMessage(({
                type = 'citizenConvictions',
                info = nil
            }))
        end
        
    end, data)
    
end)
---------------------------------------------------
--============End of citizen searches============--
---------------------------------------------------
---------------------------------------------------
--============Start of fine stuff================--
---------------------------------------------------

RegisterNUICallback('getFinePenal', function() --This pulls the penal code from the config when issuing fine
    SendNUIMessage(
    ({
        type = "updateFinePenal",
        info = Config.penalFines
    }))
end)

RegisterNUICallback('deleteFine', function(data) --obv delete fines
    
    ESX.TriggerServerCallback('crumbleCad:deleteFine', function(cb)
        if cb then
            SendNUIMessage(({
                type = 'fineDeleted',
                info = true
            }))
        else
            SendNUIMessage(({
                type = 'fineDeleted',
                info = false
            }))
        end
    end, data)
    
end)


RegisterNUICallback('submitFine', function(data) --Issues a fine
    
    ESX.TriggerServerCallback('crumbleCad:submitFine', function(cb)
        
        if cb then
            SendNUIMessage(
            ({
                type = "fineIssued",
                info = true
            }))
        else
            SendNUIMessage(
            ({
                type = "fineIssued",
                info = false
            }))
        end
    end, data)
    
end)
---------------------------------------------------
--============End of fine stuff==================--
---------------------------------------------------
---------------------------------------------------
--============Start of warrant stuff=============--
---------------------------------------------------
RegisterNUICallback('deleteWarrant', function(data) --deletes warrant from db
    
    ESX.TriggerServerCallback('crumbleCad:deleteWarrant', function(cb)
        
        if cb then
            SendNUIMessage(({
                type = 'warrantDeleted',
                info = true
            }))
        else
            SendNUIMessage(({
                type = 'warrantDeleted',
                info = false
            }))
        end
        
    end, data)
    
end)
---------------------------------------------------
--==============End of warrant stuff=============--
---------------------------------------------------
---------------------------------------------------
--============Start of report stuff==============--
---------------------------------------------------
RegisterNUICallback('submitReport', function(data) --adds report to db
    
    ESX.TriggerServerCallback('crumbleCad:submitReport', function(cb)
        
        if cb == true then
            SendNUIMessage(
            ({
                type = 'reportResult',
                success = true
            }))
        elseif cb == 'notFound' then
            SendNUIMessage(
            ({
                type = 'reportResult',
                success = cb
            }))
        else
            SendNUIMessage(
            ({
                type = 'reportResult',
                success = false
            }))
        end
        
    end,data)
    
end)

RegisterNUICallback('getReports', function() --pulls reports from db for view report page.
    
    ESX.TriggerServerCallback('crumbleCad:getReports', function(cb)
        if cb then
            SendNUIMessage(
            ({
                type = 'updateReport',
                info = cb
            }))
        else
            SendNUIMessage(
            ({
                type = 'updateReport',
                info = nil
            }))
        end
    end)
    
end)

RegisterNUICallback('deleteReport', function(data) --deletes reports from db
    
    ESX.TriggerServerCallback('crumbleCad:deleteReport', function(cb)
        if cb then 
            SendNUIMessage(
            ({
                type = 'reportDeleted',
                info = true
            }))
        else
            SendNUIMessage(
            ({
                type = 'reportDeleted',
                info = false
            }))
        end
    end, data)
end)

RegisterNUICallback('editReport', function(data) --updates reports if edited.
    
    ESX.TriggerServerCallback('crumbleCad:editReport', function(cb)
        if cb then
            SendNUIMessage(({
                type = 'reportUpdate',
                info = true
            }))
        else
            SendNUIMessage(({
                type = 'reportUpdate',
                info = false
            }))
        end
    end, data)
    
end)

---------------------------------------------------
--============End of report stuff================--
---------------------------------------------------
---------------------------------------------------
--============Start of vehicle stuff=============--
---------------------------------------------------
RegisterNUICallback('checkPlate', function(data) --checks if plate is in owned_vehicles and returns data
    
    ESX.TriggerServerCallback('crumbleCad:checkPlate', function(cb)
        if cb then
            
            local vehicleInfo = json.decode(cb.vehicle)
            local displaytext = GetDisplayNameFromVehicleModel(vehicleInfo.model)
            local vehicleName = GetLabelText(displaytext)
            local color
            
            for k,v in pairs(Config.colorNames) do
                if tonumber(vehicleInfo.color1) == tonumber(k) then
                    color = v
                    break
                end
            end
            
            SendNUIMessage(
            ({
                type = 'vehicleResult',
                info = cb,
                ownerName = vehicleInfo.ownerName,
                model = vehicleName,
                primaryColor = color,
            }))
        else
            SendNUIMessage(
            ({
                type = 'vehicleResult',
                info = false
            }))
        end
    end, data)
end)


---------------------------------------------------
--==================Events=======================--
---------------------------------------------------


---------------------------------------------------
--==================Functions====================--
---------------------------------------------------