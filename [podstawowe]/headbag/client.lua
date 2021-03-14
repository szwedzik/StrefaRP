ESX = nil
local CoolDown = false
local CoolDownOff = false
local HaveBagOnHead = false
local brakworka = false
local cooldowntimebag = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function NajblizszyGracz() --This function send to server closestplayer

local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
local player = GetPlayerPed(-1)

if closestPlayer == -1 or closestDistance > 2.0 then 
  CoolDown = true
    exports['mythic_notify']:DoCustomHudText('inform', 'Brak osób w pobliżu', 3500)
    Cooldownbutton()
    CoolDown = false
else
  if not HaveBagOnHead then
    CoolDown = true
    TriggerServerEvent('headbag:sendclosest', GetPlayerServerId(closestPlayer))
    exports['mythic_notify']:DoCustomHudText('error', 'Założyłeś/aś worek na głowę', 3500)
    TriggerServerEvent('headbag:closest')
    brakworka = true
    Cooldownworek()
  else
    CoolDown = true
    exports['mythic_notify']:DoCustomHudText('inform', 'Ta osoba ma już worek na głowie!', 3500)
    Cooldownbutton()
    CoolDown = false
  end
end
end

function Cooldownbutton()
  local cooldowntime = math.random(2000,4000)
    Citizen.Wait(cooldowntime)
    CoolDown = false
end

function CooldownbuttonOff()
  local cooldowntime = math.random(2000,4000)
    Citizen.Wait(cooldowntime)
    CoolDownOff = false
end

function Cooldownworek()
  local cooldowntime = math.random(3000,5000)
    Citizen.Wait(cooldowntime)
    cooldowntimebag = false
end

RegisterNetEvent('headbag:naloz') --This event open menu
AddEventHandler('headbag:naloz', function()
    OpenBagMenu()
end)

RegisterNetEvent('headbag:nalozNa') --This event put head bag on nearest player
AddEventHandler('headbag:nalozNa', function(gracz)
    local playerPed = GetPlayerPed(-1)
    Worek = CreateObject(GetHashKey("prop_money_bag_01"), 0, 0, 0, true, true, true) -- Create head bag object!
    AttachEntityToEntity(Worek, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 12844), 0.2, 0.04, 0, 0, 270.0, 60.0, true, true, false, true, 1, true) -- Attach object to head
    SetNuiFocus(false,false)
    SendNUIMessage({type = 'openGeneral'})
    HaveBagOnHead = true
end)    

AddEventHandler('playerSpawned', function() --This event delete head bag when player is spawn again
DeleteEntity(Worek)
SetEntityAsNoLongerNeeded(Worek)
SendNUIMessage({type = 'closeAll'})
HaveBagOnHead = false
brakworka = false
end)

RegisterNetEvent('headbag:zdejmijc') --This event delete head bag from player head
AddEventHandler('headbag:zdejmijc', function(gracz)
    exports['mythic_notify']:DoCustomHudText('inform', 'Ktoś ściągnął Ci worek z głowy', 3500)
    DeleteEntity(Worek)
    SetEntityAsNoLongerNeeded(Worek)
    SendNUIMessage({type = 'closeAll'})
    HaveBagOnHead = false
end)

function OpenBagMenu() --This function is menu function

    local elements = {
          {label = 'Nałóż worek na główę', value = 'puton'},
          {label = 'Zdejmij worek z głowy', value = 'putoff'},
          
        }
  
    ESX.UI.Menu.CloseAll()
  
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'headbagging',
      {
        title    = 'Worek',
        align    = 'top-left',
        elements = elements
        },
  
            function(data2, menu2)
  
  
              local player, distance = ESX.Game.GetClosestPlayer()
  
              if distance ~= -1 and distance <= 2.0 then
  
                if data2.current.value == 'puton' then
                  if CoolDown == true then
                    exports['mythic_notify']:DoCustomHudText('inform', 'Akcja niemożliwa, odczekaj chwilę', 3500)
                  elseif CoolDown == false then
                    if brakworka == false then
                      if cooldowntimebag == false then
                        NajblizszyGracz()
                        Cooldownbutton()
                        CoolDown = false
                      elseif cooldowntimebag == true then
                        exports['mythic_notify']:DoCustomHudText('inform', 'Za szybko próbujesz założyć kolejny worek', 3500)
                      end
                    elseif brakworka == true then
                      exports['mythic_notify']:DoCustomHudText('inform', 'Założyłeś już worek jednej osobie...', 3500)
                    end
                  end
                end
  
                if data2.current.value == 'putoff' then
                  if CoolDownOff == true then
                    exports['mythic_notify']:DoCustomHudText('inform', 'Akcja niemożliwa, odczekaj chwilę', 3500)
                  elseif CoolDownOff == false then
                    if cooldowntimebag == false then
                      CoolDownOff = true
                      TriggerServerEvent('headbag:zdejmij')
                      exports['mythic_notify']:DoCustomHudText('error', 'Ściągnąłeś/aś worek z głowy', 3500)
                      brakworka = false
                      Cooldownworek()
                      CooldownbuttonOff()
                      CoolDownOff = false
                    elseif cooldowntimebag == true then
                      CoolDownOff = true
                      exports['mythic_notify']:DoCustomHudText('inform', 'Za szybko próbujesz zdjąć kolejny worek', 3500)
                      CooldownbuttonOff()
                      CoolDownOff = false
                    end
                  end
                end
              else
                exports['mythic_notify']:DoCustomHudText('inform', 'Brak osób w pobliżu', 3500)
              end
            end,
      function(data2, menu2)
        menu2.close()
      end
    )
  end

