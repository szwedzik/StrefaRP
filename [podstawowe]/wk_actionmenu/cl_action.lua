--[[
 ___________________________________________________________________________________
|																					|
|							Code Edited by: Johnny2525								|
|						Mail: johnny2525.contact@gmail.com							|
|		Linked-In: https://www.linkedin.com/in/jakub-barwi%C5%84ski-09617b164/		|
|___________________________________________________________________________________|

--]]

--[[------------------------------------------------------------------------

	ActionMenu 
	Created by WolfKnight
	Additional help from lowheartrate, TheStonedTurtle, and Briglair. 

------------------------------------------------------------------------]]--

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	--ESX.UI.Menu.RegisterType('phone', OpenPhone, ClosePhone)
end)

-- Define the variable used to open/close the menu 
local menuEnabled = false 

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


function OpenAnimationsMenu()

	local title = nil
	local elements = {}
	
	for i=1, #Config.Animations, 1 do
		
		if Config.Animations[i].name == "festives" then

			title = Config.Animations[i].label

			for j=1, # Config.Animations[i].items, 1 do
				table.insert(elements, {label = Config.Animations[i].items[j].label, type = Config.Animations[i].items[j].type, value = Config.Animations[i].items[j].data})
			end

			break

		end

	end


	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'animations_sub',
		{
			title    = title,
			elements = elements,
			align = 'bottom'
		},
		function(data, menu)

			local type = data.current.type
			local lib  = data.current.value.lib
			local anim = data.current.value.anim

			if type == 'scenario' then
				startScenario(anim)
			else
				if type == 'attitude' then
					startAttitude(lib, anim)
				else
					startAnim(lib, anim)
				end
			end

		end,
		function(data, menu)
			menu.close()
		end
	)

end

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(0, Keys['F7']) and not isDead then
			OpenWalkingMenu()
		end
	end
end)

function OpenWalkingMenu()

	local title = nil
	local elements = {}
	
	for i=1, #Config.Animations, 1 do
		
		if Config.Animations[i].name == "attitudem" then

			title = Config.Animations[i].label

			for j=1, # Config.Animations[i].items, 1 do
				table.insert(elements, {label = Config.Animations[i].items[j].label, type = Config.Animations[i].items[j].type, value = Config.Animations[i].items[j].data})
			end

			break

		end

	end


	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'animations_sub',
		{
			title    = title,
			elements = elements
		},
		function(data, menu)

			local type = data.current.type
			local lib  = data.current.value.lib
			local anim = data.current.value.anim

			if type == 'scenario' then
				startScenario(anim)
			else
				if type == 'attitude' then
					startAttitude(lib, anim)
				else
					startAnim(lib, anim)
				end
			end

		end,
		function(data, menu)
			menu.close()
		end
	)

end

function OpenAnimationsSubMenu(menu)

	local title    = nil
	local elements = {}

	for i=1, #Config.Animations, 1 do
		
		if Config.Animations[i].name == menu then

			title = Config.Animations[i].label

			for j=1, # Config.Animations[i].items, 1 do
				table.insert(elements, {label = Config.Animations[i].items[j].label, type = Config.Animations[i].items[j].type, value = Config.Animations[i].items[j].data})
			end

			break

		end

	end

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'animations_sub',
		{
			title    = title,
			elements = elements
		},
		function(data, menu)

			local type = data.current.type
			local lib  = data.current.value.lib
			local anim = data.current.value.anim

			if type == 'scenario' then
				startScenario(anim)
			else
				if type == 'attitude' then
					startAttitude(lib, anim)
				else
					startAnim(lib, anim)
				end
			end

		end,
		function(data, menu)
			menu.close()
		end
	)

end

function startAttitude(lib, anim)
 	Citizen.CreateThread(function()
	
	    local playerPed = GetPlayerPed(-1)
	
	    RequestAnimSet(anim)
	      
	    while not HasAnimSetLoaded(anim) do
	        Citizen.Wait(0)
	    end
	    SetPedMovementClipset(playerPed, anim, true)
	end)
end

function startAnim(lib, anim)
 	
	Citizen.CreateThread(function()

	  RequestAnimDict(lib)
	  
	  while not HasAnimDictLoaded( lib) do
	    Citizen.Wait(0)
	  end

	  TaskPlayAnim(GetPlayerPed(-1), lib ,anim ,8.0, -8.0, -1, 0, 0, false, false, false )

	end)

end

function startScenario(anim)
  TaskStartScenarioInPlace(GetPlayerPed(-1), anim, 0, false)
end

-- function OpenAnimationsMenu()

	-- local elements = {}

	-- for i=1, #Config.Animations, 1 do
		-- table.insert(elements, {label = Config.Animations[i].label, value = Config.Animations[i].name})
	-- end


	-- ESX.UI.Menu.Open(
		-- 'default', GetCurrentResourceName(), 'animations',
		-- {
			-- title    = 'Animations',
			-- elements = elements
		-- },
		-- function(data, menu)
			-- OpenAnimationsSubMenu(data.current.value)
		-- end,
		-- function(data, menu)
			-- menu.close()
		-- end
	-- )

-- end

local function startPointing()
  
  local playerPed = GetPlayerPed(-1)

  RequestAnimDict("anim@mp_point")
  
  while not HasAnimDictLoaded("anim@mp_point") do
    Citizen.Wait(0)
  end
  
  SetPedCurrentWeaponVisible(playerPed, 0, 1, 1, 1)
  SetPedConfigFlag(playerPed, 36, 1)
  
  Citizen.InvokeNative(0x2D537BA194896636, playerPed, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
end

local function stopPointing()

    local playerPed = GetPlayerPed(-1)

    Citizen.InvokeNative(0xD01015C7316AE176, playerPed, "Stop")
   
    if not IsPedInjured(playerPed) then
      ClearPedSecondaryTask(playerPed)
    end

    if not IsPedInAnyVehicle(playerPed, 1) then
      SetPedCurrentWeaponVisible(playerPed, 1, 1, 1, 1)
    end

    SetPedConfigFlag(playerPed, 36, 0)
    
    ClearPedSecondaryTask(PlayerPedId())
end

--[[------------------------------------------------------------------------
	ActionMenu Toggle
	Calling this function will open or close the ActionMenu. 
------------------------------------------------------------------------]]--
function ToggleActionMenu()
	-- Make the menuEnabled variable not itself 
	-- e.g. not true = false, not false = true 
	
	local showlic = true
	
	menuEnabled = not menuEnabled

	if ( menuEnabled ) then 
		-- Focuses on the NUI, the second parameter toggles the 
		-- onscreen mouse cursor. 
		SetNuiFocus( true, true )

		-- Sends a message to the JavaScript side, telling it to 
		-- open the menu. 
		SendNUIMessage({
			showmenu = true,
			showlicense = showlic
		})
	else 
		-- Bring the focus back to the game
		SetNuiFocus( false )

		-- Sends a message to the JavaScript side, telling it to
		-- close the menu.
		SendNUIMessage({
			hidemenu = true 
		})
	end 
end 

--[[------------------------------------------------------------------------
	ActionMenu HTML Callbacks
	This will be called every single time the JavaScript side uses the
	sendData function. The name of the data-action is passed as the parameter
	variable data. 
------------------------------------------------------------------------]]--

RegisterNetEvent('actionmenu:openPhone')
AddEventHandler('actionmenu:openPhone', function()

	ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('phone', GetCurrentResourceName(), 'main')

end)
RegisterNUICallback( "zamknij", function( data, cb ) 
ToggleActionMenu()

	end)
RegisterNUICallback( "ButtonClick", function( data, cb ) 

	if ( data == "openphone" ) then 
		ToggleActionMenu()
		TriggerServerEvent("actionmenu:checkPhone")
		return 
		
	elseif ( data == "openinventory" ) then 
		ESX.ShowInventory()
	elseif ( data == "anims" ) then 
		OpenAnimationsMenu()
	elseif ( data == "walking" ) then 
		OpenWalkingMenu()
	elseif ( data == "buylicense" ) then 
		local myId = PlayerId()
		TriggerServerEvent('showid:buyLicense')
	elseif ( data == "showid") then
		TriggerServerEvent('showid:ShowId')
	elseif ( data == "showlicenses") then
		TriggerServerEvent('showid:ShowLicenses')
	elseif ( data == "exit" ) then 
		-- We toggle the ActionMenu and return here, otherwise the function 
		-- call below would be executed too, which would just open the menu again 
		ToggleActionMenu()
		return 
	end 

	-- This will only be called if any button other than the exit button is pressed
	ToggleActionMenu()
end )


--[[------------------------------------------------------------------------
	ActionMenu Control and Input Blocking 
	This is the main while loop that opens the ActionMenu on keypress. It 
	uses the input blocking found in the ES Banking resource, credits to 
	the authors.
------------------------------------------------------------------------]]--
Citizen.CreateThread( function()
	-- This is just in case the resources restarted whilst the NUI is focused. 
	SetNuiFocus( false )

	while true do 
		local playerPed = GetPlayerPed(-1)
		-- Control ID 20 is the 'Z' key by default 
		-- Use https://wiki.fivem.net/wiki/Controls to find a different key 
		if ( IsControlJustPressed( 1, 288 ) and not IsEntityDead(playerPed)  )  then 
			ToggleActionMenu()
		end 

	    if ( menuEnabled ) then
            local ped = GetPlayerPed( -1 )	

            DisableControlAction( 0, 1, true ) -- LookLeftRight
            DisableControlAction( 0, 2, true ) -- LookUpDown
            DisableControlAction( 0, 24, true ) -- Attack
            DisablePlayerFiring( ped, true ) -- Disable weapon firing
            DisableControlAction( 0, 142, true ) -- MeleeAttackAlternate
            DisableControlAction( 0, 106, true ) -- VehicleMouseControlOverride
        end

		Citizen.Wait( 0 )
	end 
end )

function chatPrint( msg )
	TriggerEvent( 'chatMessage', "ActionMenu", { 255, 255, 255 }, msg )
end 
