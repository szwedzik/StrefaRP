ESX               = nil

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

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(0, Keys['F10']) and not isDead then
			OpenFaceMenu()
		end
	end
end)

function OpenFaceMenu()
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'facemenu',
		{
			title    = 'Wybierz wyraz twarzy',
			elements = {
        {label = 'Normalny', value = 'normal'},

        {label = 'Auu!', value = 'smoking'},
        {label = 'Ból', value = 'pain1'},
        {label = 'Ból 2', value = 'pain2'},
        {label = 'Ból 3', value = 'pain3'},
        {label = 'Brak Słów', value = 'sulk'},
        {label = 'Coo?', value = 'stressed'},
        {label = 'Dumny', value = 'smug'},
        {label = 'Krzyczenie', value = 'burning'},
        {label = 'Krzywe Spojrzenie', value = 'aiming'},
        {label = 'Medytacja', value = 'knockout'},
        {label = 'Oczko', value = 'blowkiss'},
        {label = 'Płacz', value = 'coughing'},
        {label = 'Sen', value = 'sleeping'},
        {label = 'Strach', value = 'electrocuted'},
        {label = 'Szok', value = 'injured'},
        {label = 'Szok 2', value = 'shocked'},
        {label = 'Sztuczny uśmiech', value = 'drunk'},
        {label = 'Zadowolenie', value = 'happy'},
        {label = 'Zamknięte oczy', value = 'dead1'},
        {label = 'Zaskoczenie', value = 'dead2'},
        {label = 'Zdenerwowanie', value = 'effort'},
        {label = 'Ziewanie', value = 'die1'},
        {label = 'Złość', value = 'angry'},
        {label = 'Złość 2', value = 'drivefast'},
			}
		},
        function(data, menu)
            if data.current.value == 'blowkiss' then
              local ped = GetPlayerPed(-1)
                ESX.Streaming.RequestAnimDict('facials@gen_female@base')
                TaskPlayAnim(ped, 'facials@gen_female@base', 'blowkiss_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
                Citizen.Wait(1300)
                TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_normal_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
            end	
            if data.current.value == 'burning' then
              local ped = GetPlayerPed(-1)
              ESX.Streaming.RequestAnimDict('facials@gen_female@base')
              TaskPlayAnim(ped, 'facials@gen_female@base', 'burning_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
            end	
            if data.current.value == 'coughing' then
              local ped = GetPlayerPed(-1)
              ESX.Streaming.RequestAnimDict('facials@gen_female@base')
              TaskPlayAnim(ped, 'facials@gen_female@base', 'coughing_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
            end	
            if data.current.value == 'dead1' then
              local ped = GetPlayerPed(-1)
              ESX.Streaming.RequestAnimDict('facials@gen_female@base')
              TaskPlayAnim(ped, 'facials@gen_female@base', 'dead_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
            end	
            if data.current.value == 'dead2' then
              local ped = GetPlayerPed(-1)
              ESX.Streaming.RequestAnimDict('facials@gen_female@base')
              TaskPlayAnim(ped, 'facials@gen_female@base', 'dead_2', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
            end	
            if data.current.value == 'die1' then
              local ped = GetPlayerPed(-1)
              ESX.Streaming.RequestAnimDict('facials@gen_female@base')
              TaskPlayAnim(ped, 'facials@gen_female@base', 'die_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
              Citizen.Wait(1100)
              TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_normal_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
            end	
            if data.current.value == 'effort' then
              local ped = GetPlayerPed(-1)
              ESX.Streaming.RequestAnimDict('facials@gen_female@base')
              TaskPlayAnim(ped, 'facials@gen_female@base', 'effort_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
            end	
            if data.current.value == 'electrocuted' then
              local ped = GetPlayerPed(-1)
              ESX.Streaming.RequestAnimDict('facials@gen_female@base')
              TaskPlayAnim(ped, 'facials@gen_female@base', 'electrocuted_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
            end	
            if data.current.value == 'aiming' then
              local ped = GetPlayerPed(-1)
              ESX.Streaming.RequestAnimDict('facials@gen_female@base')
              TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_aiming_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
            end	
            if data.current.value == 'angry' then
              local ped = GetPlayerPed(-1)
              ESX.Streaming.RequestAnimDict('facials@gen_female@base')
              TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_angry_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
            end	
            if data.current.value == 'drivefast' then
              local ped = GetPlayerPed(-1)
              ESX.Streaming.RequestAnimDict('facials@gen_female@base')
              TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_drivefast_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
            end	
            if data.current.value == 'drunk' then
              local ped = GetPlayerPed(-1)
              ESX.Streaming.RequestAnimDict('facials@gen_female@base')
              TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_drunk_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
            end	
            if data.current.value == 'happy' then
              local ped = GetPlayerPed(-1)
              ESX.Streaming.RequestAnimDict('facials@gen_female@base')
              TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_happy_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
            end	
            if data.current.value == 'injured' then
              local ped = GetPlayerPed(-1)
              ESX.Streaming.RequestAnimDict('facials@gen_female@base')
              TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_injured_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
            end	
            if data.current.value == 'knockout' then
              local ped = GetPlayerPed(-1)
              ESX.Streaming.RequestAnimDict('facials@gen_female@base')
              TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_knockout_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
            end	
            if data.current.value == 'normal' then
              local ped = GetPlayerPed(-1)
              ESX.Streaming.RequestAnimDict('facials@gen_female@base')
              TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_normal_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
            end	
            if data.current.value == 'sleeping' then
              local ped = GetPlayerPed(-1)
              ESX.Streaming.RequestAnimDict('facials@gen_female@base')
              TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_sleeping_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
            end	
            if data.current.value == 'smug' then
              local ped = GetPlayerPed(-1)
              ESX.Streaming.RequestAnimDict('facials@gen_female@base')
              TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_smug_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
            end	
            if data.current.value == 'stressed' then
              local ped = GetPlayerPed(-1)
              ESX.Streaming.RequestAnimDict('facials@gen_female@base')
              TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_stressed_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
            end	
            if data.current.value == 'sulk' then
              local ped = GetPlayerPed(-1)
              ESX.Streaming.RequestAnimDict('facials@gen_female@base')
              TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_sulk_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
            end	
            if data.current.value == 'pain1' then
              local ped = GetPlayerPed(-1)
              ESX.Streaming.RequestAnimDict('facials@gen_female@base')
              TaskPlayAnim(ped, 'facials@gen_female@base', 'pain_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
              Citizen.Wait(3100)
              TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_normal_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
            end	
            if data.current.value == 'pain2' then
              local ped = GetPlayerPed(-1)
              ESX.Streaming.RequestAnimDict('facials@gen_female@base')
              TaskPlayAnim(ped, 'facials@gen_female@base', 'pain_2', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
              Citizen.Wait(1200)
              TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_normal_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
            end	
            if data.current.value == 'pain3' then
              local ped = GetPlayerPed(-1)
              ESX.Streaming.RequestAnimDict('facials@gen_female@base')
              TaskPlayAnim(ped, 'facials@gen_female@base', 'pain_3', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
              Citizen.Wait(1000)
              TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_normal_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
            end	
            if data.current.value == 'shocked' then
              local ped = GetPlayerPed(-1)
              ESX.Streaming.RequestAnimDict('facials@gen_female@base')
              TaskPlayAnim(ped, 'facials@gen_female@base', 'shocked_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
            end	
            if data.current.value == 'smoking' then
              local ped = GetPlayerPed(-1)
              ESX.Streaming.RequestAnimDict('facials@gen_female@base')
              TaskPlayAnim(ped, 'facials@gen_female@base', 'smoking_exhale_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
              Citizen.Wait(1200)
              TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_normal_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
            end	

            --menu.close()
		end,
		function(data, menu)
			menu.close()
		end)
end

--[[
RegisterCommand('f oczko', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'blowkiss_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
      Citizen.Wait(1300)
      TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_normal_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz2', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'burning_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz3', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'coughing_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz4', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'dead_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz5', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'dead_2', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz6', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'die_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz7', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'die_2', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz8', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'effort_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz9', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'electrocuted_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz10', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'melee_effort_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz11', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'melee_effort_2', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz12', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'melee_effort_3', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz13', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_aiming_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz14', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_angry_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz15', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_drivefast_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz16', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_drunk_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz17', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_excited_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz18', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_frustrated_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz19', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_happy_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz20', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_injured_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz21', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_knockout_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz22', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_normal_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz23', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_skydive_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz24', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_sleeping_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz25', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_smug_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz26', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_stressed_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz27', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_sulk_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz28', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'mood_talking_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz29', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'pain_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz30', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'pain_2', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz31', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'pain_3', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz32', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'pain_4', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz33', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'pain_5', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz34', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'pain_6', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz35', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'pose_normal_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz36', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'shocked_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz37', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'shocked_2', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz38', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'smoking_exhale_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz39', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'smoking_hold_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 

RegisterCommand('twarz40', function(source, args, rawCommand)
  local ped = GetPlayerPed(-1)
  ESX.Streaming.RequestAnimDict('facials@gen_female@base')
      TaskPlayAnim(ped, 'facials@gen_female@base', 'smoking_inhale_1', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
end) 
]]
--[[
blowkiss_1 -- oczko
burning_1  -- płomień (nie dodany)
coughing_1 -- kaszel
dead_1 -- śmierć (zombie)
dead_2 -- śmierć (zomie)
die_1  -- umieranie
die_2 -- umieranie
effort_1 -- wkurzenie
electrocuted_1 -- porażenie prądem
melee_effort_1 -- cios
melee_effort_2 -- cios
melee_effort_3 -- cios
mood_aiming_1 -- przymróżenie lewego oka
mood_angry_1 -- wkurzenie
mood_drivefast_1 -- ...
mood_drunk_1  -- wesoły(pijany)
mood_excited_1 -- zwykły wyraz
mood_frustrated_1 -- zwykły wyraz
mood_happy_1 -- szczęśliwy
mood_injured_1 -- zszokowany
mood_knockout_1 -- medytacja
mood_normal_1 -- normalny
mood_skydive_1
mood_sleeping_1
mood_smug_1 -- lekki uśmiech
mood_stressed_1 -- zażenowanie
mood_sulk_1 -- 
mood_talking_1
pain_1
pain_2
pain_3
pain_4
pain_5
pain_6
pose_normal_1
shocked_1
shocked_2
smoking_exhale_1
smoking_hold_1
smoking_inhale_1
]]