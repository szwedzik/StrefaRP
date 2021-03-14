local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
ESX                           = nil
Citizen.CreateThread(function()

	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

end)

local treatment = false
local tekst = 60

local timer = false
local hospitalped = nil


local lozkocoords = vector3(350.55, -591.84, 44.02)
function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
	SetTextFont(4)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(2, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - width/2, y - height/2 + 0.005)
end
function loadAnimDict(dict)
  while (not HasAnimDictLoaded(dict)) do 
      RequestAnimDict(dict)
      Citizen.Wait(5)
  end
end

function Notify(text)
  SetNotificationTextEntry('STRING')
  AddTextComponentString(text)
  DrawNotification(false, false)
end

local UI = { 

	x =  0.000 ,
	y = -0.001 ,

}
function ShowInfo(text, state)
  SetTextComponentFormat("STRING")
  AddTextComponentString(text)DisplayHelpTextFromStringLabel(0, state, 0, -1)
end
Citizen.CreateThread(function()
  while true do  
    Citizen.Wait(0)
      if disablecontrols2 == true then
        drawTxt(UI.x + 0.9405, UI.y + 0.502, 1.0,0.98,0.5, "~w~[~r~Szpital~w~]~w~ zostało ".. tekst .. "~w~ sekund", 255, 255, 255, 255)
end
  end
end)
Citizen.CreateThread(function()
  while true do  
    Citizen.Wait(0)
      if disablecontrols == true then

        DisableControlAction(0, 142, true) -- MeleeAttackAlternate
        DisableControlAction(0, 24,  true) -- Shoot 
        DisableControlAction(0, 92,  true) -- Shoot in car
        DisableControlAction(0, 24,  true)
        DisableControlAction(0, 25,  true)
        DisableControlAction(0, 45,  true)
        DisableControlAction(0, 76,  true)
        DisableControlAction(0, 102,  true)
        DisableControlAction(0, 278,  true)
        DisableControlAction(0, 279,  true)
        DisableControlAction(0, 280,  true)
        DisableControlAction(0, 281,  true)
        DisableControlAction(0, 140, true) -- Attack
        DisableControlAction(0, 24, true) -- Attack
        DisableControlAction(0, 25, true) -- Attack
        DisableControlAction(2, 24, true) -- Attack
        DisableControlAction(2, 257, true) -- Attack 2
        DisableControlAction(2, 25, true) -- Aim
        DisableControlAction(2, 263, true) -- Melee Attack 1
        DisableControlAction(2, Keys['R'], true) -- Reload
        DisableControlAction(2, Keys['LEFTALT'], true)
        DisableControlAction(2, Keys['TOP'], true) -- Open phone (not needed?)
        DisableControlAction(2, Keys['Q'], true) -- Cover
        DisableControlAction(2, Keys['TAB'], true) -- Select Weapon
        DisableControlAction(2, Keys['F1'], true) -- Disable phone
        DisableControlAction(2, Keys['F2'], true) -- Inventory
        DisableControlAction(2, Keys['F3'], true) -- Animations
        DisableControlAction(2, Keys['F6'], true)
        DisableControlAction(2, Keys['F7'], true)
        DisableControlAction(2, Keys['F9'], true)
        DisableControlAction(2, Keys['F10'], true)
        DisableControlAction(2, Keys['Y'], true)
        DisableControlAction(0, Keys['A'], true)
        DisableControlAction(0, Keys['D'], true)
        DisableControlAction(2, Keys["~"], true) 
        DisableControlAction(2, Keys["X"], true)
        DisableControlAction(0, Keys["X"], true)  
        DisableControlAction(2, Keys["T"], true)
        DisableControlAction(0, Keys["T"], true) 
end
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)

	  if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 305.63, -596.06, 42.39, true) <= 20 then
        DrawMarker(27, 305.63, -596.06, 42.39, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.1001, 0, 155, 255, 200, 0, 0, 0, 0)
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 305.63, -596.06, 42.39, true) <= 2 then
          ShowInfo("Uzyj ~INPUT_VEH_HORN~ aby doktor pomogl Ci w powrocie do zdrowia (koszt ~g~5000$~w~)", 0)
          
         
          
          
          if (IsControlJustPressed(1,38)) and (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 305.63, -596.06, 42.39, true) <= 5)  then
            print(mozna)
            TriggerServerEvent('sprawdz:ambulans')
            
   
          end
          end
        end
      end

    end)

    RegisterNetEvent('smerfik:lekarz')
    AddEventHandler('smerfik:lekarz', function(source)
      DoScreenFadeOut(800)
      Citizen.Wait(2500)
      ESX.Game.Teleport(PlayerPedId(),lozkocoords)
      SetEntityHeading(PlayerPedId(), 158.49)
      FreezeEntityPosition(PlayerPedId(), true)
    
      DoScreenFadeIn(1800)
      local ad = "amb@world_human_sunbathe@female@back@idle_a"
      local player = GetPlayerPed( -1 )
        loadAnimDict( ad )
        TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 15, 0, 0, 0, 0 )
        Notify("Poczekaj na lekarza")
        disablecontrols = true
      ped()
TriggerEvent('zacznijliczenie:szpital')
disablecontrols2 = true
Citizen.Wait(60000)
      FreezeEntityPosition(playerPed, false)
      
        disablecontrols = false
        disablecontrols2 = false
        TriggerServerEvent('hospital:price')
ClearPedTasksImmediately(PlayerPedId())
        Notify("~h~Doktor ~w~Ci pomógł!")
       SetEntityHealth(PlayerPedId(), 200)
       FreezeEntityPosition(hospitalped, false)
       TaskPedSlideToCoord(hospitalped, 332.38, -577.16, 43.11, 28.404, 10)
       Citizen.Wait(15000)
       DeleteEntity(hospitalped)

    
end)
RegisterNetEvent('smerfik:zaduzomedykow')
AddEventHandler('smerfik:zaduzomedykow', function(source)
  Notify("Medycy są na służbie, doktor nie pomoże...")
end)


RegisterNetEvent('zacznijliczenie:szpital')
AddEventHandler('zacznijliczenie:szpital', function()
  tekst = 60
while tekst > -1 do
tekst = tekst - 1
Citizen.Wait(1000)

end
end)

function ped()
  RequestModel(GetHashKey("s_m_m_doctor_01"))
  while not HasModelLoaded(GetHashKey("s_m_m_doctor_01")) do
    Wait(1)
  end

   hospitalped =  CreatePed(4, 0xd47303ac, 332.38, -577.16, 43.11, 42.71, false, true)
    SetEntityHeading(hospitalped, 219.404)
    TaskPedSlideToCoord(hospitalped, 349.81, -590.45, 43.11, 219.404, 10)
    SetEntityInvincible(hospitalped, true)
    SetBlockingOfNonTemporaryEvents(hospitalped, true)
    Citizen.Wait(13000)

    FreezeEntityPosition(hospitalped, true)

end