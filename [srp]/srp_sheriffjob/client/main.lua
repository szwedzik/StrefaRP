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
  
  local PlayerData = {}
  local HasAlreadyEnteredMarker = false
  local LastStation, LastPart, LastPartNum, LastEntity
  local CurrentAction = nil
  local CurrentActionMsg  = ''
  local CurrentActionData = {}
  local IsHandcuffed = false
  local HandcuffTimer2 = {}
  local DragStatus = {}
  DragStatus.IsDragged = false
  local hasAlreadyJoined = false
  local blipsCops = {}
  local isDead = false
  local CurrentTask = {}
  local playerInService = false
  local spawnedVehicles, isInShopMenu = {}, false
  local closestNpc = nil
  ESX                           = nil
  local searchPedDelay = 500
  
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
  
  function cleanPlayer(playerPed)
	  SetPedArmour(playerPed, 0)
	  ClearPedBloodDamage(playerPed)
	  ResetPedVisibleDamage(playerPed)
	  ClearPedLastWeaponDamage(playerPed)
	  ResetPedMovementClipset(playerPed, 0)
  end
  
  function setUniform(job, playerPed)
	  TriggerEvent('skinchanger:getSkin', function(skin)
		  if skin.sex == 0 then
			  if Config.Uniforms2[job].male ~= nil then
				  TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms2[job].male)
			  else
				  exports['mythic_notify']:DoCustomHudText('inform', 'Brak Ubrania', 3000)
				  --ESX.ShowNotification(_U('no_outfit'))
			  end
			  
			  if job == 'bullet_wear3'  then
				  SetPedArmour(playerPed, 50)
			  end
  
			  if job == 'szeryf3_wear'  then
				  SetPedArmour(playerPed, 100)
			  end
		  else
			  if Config.Uniforms2[job].female ~= nil then
				  TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms2[job].female)
			  else
				  exports['mythic_notify']:DoCustomHudText('inform', 'Brak Ubrania', 3000)
				  --ESX.ShowNotification(_U('no_outfit'))
			  end
  
			  if job == 'bullet_wear3'  then
				  SetPedArmour(playerPed, 50)
			  end
  
			  if job == 'szeryf3_wear'  then
				  SetPedArmour(playerPed, 100)
			  end
		  end
	  end)
  end
  
  function OpenCloakroomMenu()
  
	  local playerPed = PlayerPedId()
	  local grade = PlayerData.job.grade_name
  
	  local elements = {
		  { label = _U('citizen_wear'), value = 'citizen_wear' },
		  { label = '--------------SPECIALNE-----------------', value = 'JDKAPPA' },
		  { label = 'Kamizelka kuloodporna Sheriff', value = 'bullet_wear3' },
		  { label = 'Bojowy', value = 'szeryf3_wear'},
	  }
	  table.insert(elements, {label = '--------------------LSSD--------------------', value = 'xD'})
	  table.insert(elements, {label = 'Motor', value = 'szeryf2_wear'})
	  table.insert(elements, {label = 'Kurtka', value = 'szeryf_wear'})
	  table.insert(elements, {label = 'Mundur - długi rękaw', value = 'szeryf4_wear'})
	  table.insert(elements, {label = 'Mundur - krótki rękaw', value = 'szeryf5_wear'})
	  table.insert(elements, {label = 'Mundur - Kadet', value = 'szeryf_kadet'})
	  table.insert(elements, {label = 'Niebieska kurtka', value = 'szeryf7_wear'})
	  table.insert(elements, {label = 'Deszczówka', value = 'szeryf8_wear'})
	  table.insert(elements, {label = 'Swobodne', value = 'szeryf6_wear'})
	  
	  ESX.UI.Menu.CloseAll()
  
	  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom',
	  {
		  title    = _U('cloakroom'),
		  align    = 'top-left',
		  elements = elements
	  }, function(data, menu)
  
		  cleanPlayer(playerPed)
  
		  if data.current.value == 'citizen_wear' then
			  
			  if Config.EnableNonFreemodePeds2 then
				  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					  local isMale = skin.sex == 0
  
					  TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
						  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
							  TriggerEvent('skinchanger:loadSkin', skin)
							  TriggerEvent('esx:restoreLoadout')
						  end)
					  end)
  
				  end)
			  else
				  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					  TriggerEvent('skinchanger:loadSkin', skin)
				  end)
			  end
  
			  if Config.MaxInService2 ~= -1 then
  
				  ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
					  if isInService then
  
						  playerInService = false
  
						  local notification = {
							  title    = _U('service_anonunce'),
							  subject  = '',
							  msg      = _U('service_out_announce', GetPlayerName(PlayerId())),
							  iconType = 1
						  }
  
						  TriggerServerEvent('esx_service:notifyAllInService', notification, 'sheriff')
  
						  TriggerServerEvent('esx_service:disableService', 'sheriff')
						  TriggerClientEvent('esx_policejob:updateBlip')
						  exports['mythic_notify']:DoCustomHudText('inform', 'Opuszczasz służbę', 3000)
						  --ESX.ShowNotification(_U('service_out'))
					  end
				  end, 'sheriff')
			  end
  
		  elseif Config.MaxInService2 ~= -1 and data.current.value ~= 'citizen_wear' then
			  local serviceOk = 'waiting'
  
			  ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
				  if not isInService then
  
					  ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
						  if not canTakeService then
							  exports['mythic_notify']:DoCustomHudText('inform', 'Nie możesz wejść na służbę ze względu na dużą liczbę funkcjonariuszy', 3000)
							  --ESX.ShowNotification(_U('service_max', inServiceCount, maxInService))
						  else
  
							  serviceOk = true
							  playerInService = true
  
							  local notification = {
								  title    = _U('service_anonunce'),
								  subject  = '',
								  msg      = _U('service_in_announce', GetPlayerName(PlayerId())),
								  iconType = 1
							  }
	  
							  TriggerServerEvent('esx_service:notifyAllInService', notification, 'sheriff')
							  TriggerClientEvent('esx_policejob:updateBlip')
							  exports['mythic_notify']:DoCustomHudText('inform', 'Rozpoczynasz służbę', 3000)
							  --ESX.ShowNotification(_U('service_in'))
						  end
					  end, 'sheriff')
  
				  else
					  serviceOk = true
				  end
			  end, 'sheriff')
  
			  while type(serviceOk) == 'string' do
				  Citizen.Wait(5)
			  end
  
			  -- if we couldn't enter service don't let the player get changed
			  if not serviceOk then
				  return
			  end
		  elseif data.current.value == 'freemode_ped' then
			  local modelHash = ''
  
			  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				  if skin.sex == 0 then
					  modelHash = GetHashKey(data.current.maleModel)
				  else
					  modelHash = GetHashKey(data.current.femaleModel)
				  end
  
				  ESX.Streaming.RequestModel(modelHash, function()
					  SetPlayerModel(PlayerId(), modelHash)
					  SetModelAsNoLongerNeeded(modelHash)
  
					  TriggerEvent('esx:restoreLoadout')
				  end)
			  end)
		  else
			  setUniform(data.current.value, playerPed)
		  end
	  end, function(data, menu)
		  menu.close()
  
		  CurrentAction     = 'menu_cloakroom'
		  CurrentActionMsg  = _U('open_cloackroom')
		  CurrentActionData = {}
	  end)
  end
  
  function OpenArmoryMenu(station)
	  local elements = {
		  {label = _U('buy_weapons'), value = 'buy_weapons'}
	  }
  
	  if Config.EnableArmoryManagement2 then
		  -- table.insert(elements, {label = _U('get_weapon'),     value = 'get_weapon'})
		  table.insert(elements, {label = _U('put_weapon'),     value = 'put_weapon'})
		  -- table.insert(elements, {label = _U('remove_object'),  value = 'get_stock'})
		  table.insert(elements, {label = _U('deposit_object'), value = 'put_stock'})
		  table.insert(elements, {label = 'Weź przedmiot', value = 'get_item'})
	  end
  
	  ESX.UI.Menu.CloseAll()
  
	  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory',
	  {
		  title    = _U('armory'),
		  align    = 'top-left',
		  elements = elements
	  }, function(data, menu)
  
		  if data.current.value == 'get_weapon' then
			  OpenGetWeaponMenu()
		  elseif data.current.value == 'put_weapon' then
			  OpenPutWeaponMenu()
		  elseif data.current.value == 'buy_weapons' then
			  OpenBuyWeaponsMenu()
		  elseif data.current.value == 'put_stock' then
			  OpenPutStocksMenu()
		  elseif data.current.value == 'get_stock' then
			  OpenGetStocksMenu()
		  elseif data.current.value == 'get_item' then
			  OpenGetItemMenu()
		  end
  
	  end, function(data, menu)
		  menu.close()
  
		  CurrentAction     = 'menu_armory'
		  CurrentActionMsg  = _U('open_armory')
		  CurrentActionData = {station = station}
	  end)
  end
  
  function OpenVehicleSpawnerMenu(type, station, part, partNum)
	  local playerCoords = GetEntityCoords(PlayerPedId())
	  local extras = false
	  PlayerData = ESX.GetPlayerData()
	  local elements = {}
	  if type == 'car' then
		  table.insert(elements, { label = 'Crown Victoria ', value = 'victoriasheriff'}) -- Działa (inne liversy)
		  table.insert(elements, { label = 'Ford Mustang', value = 'mustangsheriff'})
		  table.insert(elements, { label = 'Chevrolet Tahoe', value = 'Tahoesheriff'})
		  table.insert(elements, { label = 'Dodge Charger', value = 'chargersheriff'})
		  table.insert(elements, { label = 'BMW 1200RT', value = '1200RTsheriff'})
		  table.insert(elements, { label = 'Ford Explorer', value = 'explorersheriff'})
		  table.insert(elements, { label = 'Chevrolet Silverado', value = 'SILV'})
		  table.insert(elements, { label = 'Dodge Charger 18', value = '18chargersheriff'})
	  elseif type == 'helicopter' then
		  table.insert(elements, { label = 'Maverick', value = 'vcpdmav21'})
		  --table.insert(elements, { label = 'Sea Sparrow', value = 'seasparrow'})
	  end
  
	  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle', {
		  title    = _U('garage_title'),
		  align    = 'top-left',
		  elements = elements
	  }, function(data, menu)
		  local model = data.current.value
		  ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'vehicle_extras', {
			  title = 'EXTRASY (tak/nie)'
		  }, function(data_extras, menu_extras)
			  if data_extras.value == 'tak' then
				  extras = false
			  else
				  extras = true
			  end
			  menu_extras.close()
			  ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'vehicle_liverys', {
				  title = 'LIVERYS (numer, min 1)'
			  }, function(data_liverys, menu_liverys)
				  local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint(station, part, partNum)
				  if foundSpawn then
					  local liverys = tonumber(data_liverys.value)
					  ESX.Game.SpawnVehicle(model, spawnPoint.coords, spawnPoint.heading, function(vehicle)
						  TaskWarpPedIntoVehicle(PlayerPedId(),  vehicle,  -1)
						  SetVehicleMaxMods(vehicle)
						  SetVehicleExtra(vehicle, 1, extras)
						  SetVehicleExtra(vehicle, 2, extras)
						  SetVehicleExtra(vehicle, 3, extras)
						  SetVehicleExtra(vehicle, 4, extras)
						  SetVehicleExtra(vehicle, 5, extras)
						  SetVehicleExtra(vehicle, 6, extras)
						  SetVehicleExtra(vehicle, 7, extras)
						  SetVehicleExtra(vehicle, 8, extras)
						  SetVehicleExtra(vehicle, 9, extras)
						  SetVehicleExtra(vehicle, 10, extras)
						  SetVehicleExtra(vehicle, 11, extras)
						  SetVehicleExtra(vehicle, 12, extras)
						  SetVehicleExtra(vehicle, 13, extras)
						  SetVehicleExtra(vehicle, 14, extras)
						  SetVehicleExtra(vehicle, 15, extras)
						  SetVehicleExtra(vehicle, 16, extras)
						  SetVehicleExtra(vehicle, 17, extras)
						  if GetVehicleLiveryCount(vehicle) ~= -1 then
							  SetVehicleLivery(vehicle, liverys)
						  end
						  local rand = math.random(1000,9999)
						  SetVehicleNumberPlateText(vehicle, "LSSD"..rand)
						  AddVehicleKeys(vehicle)
						  menu_liverys.close()
						  --logi
						  local Player = ESX.GetPlayerData()
						  local org = Player.job.name	
						  Citizen.Wait(100)
						  local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId()))))
							  if model == "NULL" then
								  model = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId())))
							  end
						  TriggerServerEvent('srp_logs:policeGarageLog',org,model,1)
					  end)
				  end
				  menu_liverys.close()
			  end, function(data_extras, menu_extras)
				  menu_liverys.close()
			  end)
			  
		  end, function(data_extras, menu_extras)
			  menu_extras.close()
		  end)
	  
	  end, function(data, menu)
		  menu.close()
	  end)
  end
  
  function SetVehicleMaxMods(vehicle)
  
	local props = {
	  modEngine       = 2,
	  modBrakes       = 2,
	  modTransmission = 2,
	  modSuspension   = 3,
	  modTurbo        = true,
	}
  
	ESX.Game.SetVehicleProperties(vehicle, props)
  
  end
  
  function AddVehicleKeys(vehicle)
	  local localVehPlateTest = GetVehicleNumberPlateText(vehicle)
	  if localVehPlateTest ~= nil then
		  local localVehPlate = string.lower(localVehPlateTest)
		  TriggerEvent('ls:newVehicle', localVehPlate, nil, nil)
	  end
  end
  
  function StoreNearbyVehicle(playerCoords)
	  local vehicles, vehiclePlates = ESX.Game.GetVehiclesInArea(playerCoords, 30.0), {}
  
	  if #vehicles > 0 then
		  for k,v in ipairs(vehicles) do
  
			  -- Make sure the vehicle we're saving is empty, or else it wont be deleted
			  if GetVehicleNumberOfPassengers(v) == 0 and IsVehicleSeatFree(v, -1) then
				  table.insert(vehiclePlates, {
					  vehicle = v,
					  plate = ESX.Math.Trim(GetVehicleNumberPlateText(v))
				  })
			  end
		  end
	  else
		  ESX.ShowNotification(_U('garage_store_nearby'))
		  return
	  end
  
	  ESX.TriggerServerCallback('srp_sheriffjob:storeNearbyVehicle', function(storeSuccess, foundNum)
		  if storeSuccess then
			  local vehicleId = vehiclePlates[foundNum]
			  local attempts = 0
			  ESX.Game.DeleteVehicle(vehicleId.vehicle)
			  IsBusy = true
  
			  Citizen.CreateThread(function()
				  while IsBusy do
					  Citizen.Wait(0)
					  drawLoadingText(_U('garage_storing'), 255, 255, 255, 255)
				  end
			  end)
  
			  -- Workaround for vehicle not deleting when other players are near it.
			  while DoesEntityExist(vehicleId.vehicle) do
				  Citizen.Wait(500)
				  attempts = attempts + 1
  
				  -- Give up
				  if attempts > 30 then
					  break
				  end
  
				  vehicles = ESX.Game.GetVehiclesInArea(playerCoords, 30.0)
				  if #vehicles > 0 then
					  for k,v in ipairs(vehicles) do
						  if ESX.Math.Trim(GetVehicleNumberPlateText(v)) == vehicleId.plate then
							  ESX.Game.DeleteVehicle(v)
							  break
						  end
					  end
				  end
			  end
  
			  IsBusy = false
			  ESX.ShowNotification(_U('garage_has_stored'))
		  else
			  ESX.ShowNotification(_U('garage_has_notstored'))
		  end
	  end, vehiclePlates)
  end
  
  function GetAvailableVehicleSpawnPoint(station, part, partNum)
	  local spawnPoints = Config.PoliceStations2[station][part][partNum].SpawnPoints
	  local found, foundSpawnPoint = false, nil
  
	  for i=1, #spawnPoints, 1 do
		  if ESX.Game.IsSpawnPointClear(spawnPoints[i].coords, spawnPoints[i].radius) then
			  found, foundSpawnPoint = true, spawnPoints[i]
			  break
		  end
	  end
  
	  if found then
		  return true, foundSpawnPoint
	  else
		  exports['mythic_notify']:DoCustomHudText('inform', 'Pojazd jest zablokowany', 3000)
		  --ESX.ShowNotification(_U('vehicle_blocked'))
		  return false
	  end
  end
  
  ---Usuwanie Pojazdów
  Citizen.CreateThread(function()
	  while true do
			  Citizen.Wait(0)
			  local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			  local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, 341.85, -1633.05, 22.80)
  ---
  			if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then 
			  if PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' and dist <= 20.0 then
				  DrawMarker(27, 341.85, -1633.05, 22.80, 0, 0, 0, 0, 0, 0, 1.50, 1.50, 3.00, 50, 50, 204, 100, 0, 0, 0, 0)
			  else
				  Citizen.Wait(1500)
			  end
			  
			  if PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' and dist <= 3.0 then
				  DrawText3D(341.85, -1633.05, 23.90, "~g~[E]~w~ Aby schować pojazd do garażu")
			  end
  --
			  if PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' and dist <= 3.0 then
				  if IsControlJustPressed(0, Keys['E']) then -- "E"
					  local playerPed = PlayerPedId()
					  if IsPedSittingInAnyVehicle(playerPed) then
						  local vehicle = GetVehiclePedIsIn(playerPed, false)
						  if GetPedInVehicleSeat(vehicle, -1) == playerPed then
							  exports['mythic_notify']:DoCustomHudText('inform', 'Pojazd został schowany do garażu', 3000)
							  --ESX.ShowNotification("Pojazd został schowany do ~y~garażu.")
							  --logi
							  local Player = ESX.GetPlayerData()
							  local org = Player.job.name	
							  Citizen.Wait(100)
							  local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId()))))
							  if model == "NULL" then
								  model = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId())))
							  end
							  TriggerServerEvent('srp_logs:policeGarageLog',org,model,0)
							  ESX.Game.DeleteVehicle(vehicle)
						  else
							  exports['mythic_notify']:DoCustomHudText('inform', 'Musisz być kierowcą aby schować pojazd', 3000)
							  --ESX.ShowNotification("Musisz być ~r~kierowcą ~w~aby schować pojazd.")
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
			  local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			  local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, 346.26, -1628.11, 22.80)
  ---
  			if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then 
			  if PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' and dist <= 20.0 then
				  DrawMarker(27, 346.26, -1628.11, 22.80, 0, 0, 0, 0, 0, 0, 1.50, 1.50, 3.00, 50, 50, 204, 100, 0, 0, 0, 0)
			  else
				  Citizen.Wait(1500)
			  end
			  
			  if PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' and dist <= 2.5 then
				  DrawText3D(346.26, -1628.11, 23.78, "~g~[E]~w~ Aby schować pojazd do garażu")
			  end
  --
			  if PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' and dist <= 2.5 then
				  if IsControlJustPressed(0, Keys['E']) then -- "E"
					  local playerPed = PlayerPedId()
					  if IsPedSittingInAnyVehicle(playerPed) then
						  local vehicle = GetVehiclePedIsIn(playerPed, false)
						  if GetPedInVehicleSeat(vehicle, -1) == playerPed then
							  exports['mythic_notify']:DoCustomHudText('inform', 'Pojazd został schowany do garażu', 3000)
							  --ESX.ShowNotification("Pojazd został schowany do ~y~garażu.")
							  --logi
							  local Player = ESX.GetPlayerData()
							  local org = Player.job.name	
							  Citizen.Wait(100)
							  local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId()))))
							  if model == "NULL" then
								  model = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId())))
							  end
							  TriggerServerEvent('srp_logs:policeGarageLog',org,model,0)
							  ESX.Game.DeleteVehicle(vehicle)
						  else
							  exports['mythic_notify']:DoCustomHudText('inform', 'Musisz być kierowcą aby schować pojazd', 3000)
							  --ESX.ShowNotification("Musisz być ~r~kierowcą ~w~aby schować pojazd.")
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
			  local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			  local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, 362.81, -1598.26, 35.95)
  ---
  			if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then 
			  if PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' and dist <= 20.0 then
				  DrawMarker(27, 362.81, -1598.26, 35.95, 0, 0, 0, 0, 0, 0, 4.00, 4.00, 5.00, 255, 0, 0, 200, 0, 0, 0, 0)
			  else
				  Citizen.Wait(1500)
			  end
			  
			  if PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' and dist <= 5.0 then
				  DrawText3D(362.81, -1598.26, 36.95, "~g~[E]~w~ Aby schować pojazd do garażu")
			  end
  --
			  if PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' and dist <= 5.0 then
				  if IsControlJustPressed(0, Keys['E']) then -- "E"
					  local playerPed = PlayerPedId()
					  if IsPedSittingInAnyVehicle(playerPed) then
						  local vehicle = GetVehiclePedIsIn(playerPed, false)
						  if GetPedInVehicleSeat(vehicle, -1) == playerPed then
							  exports['mythic_notify']:DoCustomHudText('inform', 'Pojazd został schowany do garażu', 3000)
							  --ESX.ShowNotification("Pojazd został schowany do ~y~garażu.")
							  --logi
							  local Player = ESX.GetPlayerData()
							  local org = Player.job.name	
							  Citizen.Wait(100)
							  local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId()))))
							  if model == "NULL" then
								  model = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId())))
							  end
							  TriggerServerEvent('srp_logs:policeGarageLog',org,model,0)
							  ESX.Game.DeleteVehicle(vehicle)
						  else
							  exports['mythic_notify']:DoCustomHudText('inform', 'Musisz być kierowcą aby schować pojazd', 3000)
							  --ESX.ShowNotification("Musisz być ~r~kierowcą ~w~aby schować pojazd.")
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
			  local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			  local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, 1850.86, 3708.34, 33.37)
  ---
  			if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then 
			  if PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' and dist <= 20.0 then
				  DrawMarker(27, 1850.86, 3708.34, 33.37-0.90 , 0, 0, 0, 0, 0, 0, 1.50, 1.50, 3.00, 50, 50, 204, 100, 0, 0, 0, 0)
			  else
				  Citizen.Wait(1500)
			  end
			  
			  if PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' and dist <= 3.0 then
				  DrawText3D(1850.86, 3708.34, 33.37, "~g~[E]~w~ Aby schować pojazd do garażu")
			  end
  --
			  if PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' and dist <= 3.0 then
				  if IsControlJustPressed(0, Keys['E']) then -- "E"
					  local playerPed = PlayerPedId()
					  if IsPedSittingInAnyVehicle(playerPed) then
						  local vehicle = GetVehiclePedIsIn(playerPed, false)
						  if GetPedInVehicleSeat(vehicle, -1) == playerPed then
							  exports['mythic_notify']:DoCustomHudText('inform', 'Pojazd został schowany do garażu', 3000)
							  --ESX.ShowNotification("Pojazd został schowany do ~y~garażu.")
							  --logi
							  local Player = ESX.GetPlayerData()
							  local org = Player.job.name	
							  Citizen.Wait(100)
							  local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId()))))
							  if model == "NULL" then
								  model = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId())))
							  end
							  TriggerServerEvent('srp_logs:policeGarageLog',org,model,0)
							  ESX.Game.DeleteVehicle(vehicle)
						  else
							  exports['mythic_notify']:DoCustomHudText('inform', 'Musisz być kierowcą aby schować pojazd', 3000)
							  --ESX.ShowNotification("Musisz być ~r~kierowcą ~w~aby schować pojazd.")
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
			  local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			  local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, -481.81, 6024.42 ,31.34)
  ---
  			if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then 
			  if PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' and dist <= 20.0 then
				  DrawMarker(27, -481.81,6024.42, 31.34-0.90, 0, 0, 0, 0, 0, 0, 1.50, 1.50, 3.00, 50, 50, 204, 100, 0, 0, 0, 0)
			  else
				  Citizen.Wait(1500)
			  end
			  
			  if PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' and dist <= 3.0 then
				  DrawText3D(-481.81, 6024.42 ,31.34, "~g~[E]~w~ Aby schować pojazd do garażu")
			  end
  --
			  if PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' and dist <= 3.0 then
				  if IsControlJustPressed(0, Keys['E']) then -- "E"
					  local playerPed = PlayerPedId()
					  if IsPedSittingInAnyVehicle(playerPed) then
						  local vehicle = GetVehiclePedIsIn(playerPed, false)
						  if GetPedInVehicleSeat(vehicle, -1) == playerPed then
							  exports['mythic_notify']:DoCustomHudText('inform', 'Pojazd został schowany do garażu', 3000)
							  --ESX.ShowNotification("Pojazd został schowany do ~y~garażu.")
							  --logi
							  local Player = ESX.GetPlayerData()
							  local org = Player.job.name	
							  Citizen.Wait(100)
							  local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId()))))
							  if model == "NULL" then
								  model = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId())))
							  end
							  TriggerServerEvent('srp_logs:policeGarageLog',org,model,0)
							  ESX.Game.DeleteVehicle(vehicle)
						  else
							  exports['mythic_notify']:DoCustomHudText('inform', 'Musisz być kierowcą aby schować pojazd', 3000)
							  --ESX.ShowNotification("Musisz być ~r~kierowcą ~w~aby schować pojazd.")
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
			  local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			  local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, -478.9, 6027.62, 31.34)
  ---
  			if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then 
			  if PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' and dist <= 20.0 then
				  DrawMarker(27, -478.9, 6027.62, 31.34-0.90, 0, 0, 0, 0, 0, 0, 1.50, 1.50, 3.00, 50, 50, 204, 100, 0, 0, 0, 0)
			  else
				  Citizen.Wait(1500)
			  end
			  
			  if PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' and dist <= 3.0 then
				  DrawText3D(-481.81, 6024.42 ,31.34, "~g~[E]~w~ Aby schować pojazd do garażu")
			  end
  --
			  if PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' and dist <= 3.0 then
				  if IsControlJustPressed(0, Keys['E']) then -- "E"
					  local playerPed = PlayerPedId()
					  if IsPedSittingInAnyVehicle(playerPed) then
						  local vehicle = GetVehiclePedIsIn(playerPed, false)
						  if GetPedInVehicleSeat(vehicle, -1) == playerPed then
							  exports['mythic_notify']:DoCustomHudText('inform', 'Pojazd został schowany do garażu', 3000)
							  --ESX.ShowNotification("Pojazd został schowany do ~y~garażu.")
							  --logi
							  local Player = ESX.GetPlayerData()
							  local org = Player.job.name	
							  Citizen.Wait(100)
							  local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId()))))
							  if model == "NULL" then
								  model = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId())))
							  end
							  TriggerServerEvent('srp_logs:policeGarageLog',org,model,0)
							  ESX.Game.DeleteVehicle(vehicle)
						  else
							  exports['mythic_notify']:DoCustomHudText('inform', 'Musisz być kierowcą aby schować pojazd', 3000)
							  --ESX.ShowNotification("Musisz być ~r~kierowcą ~w~aby schować pojazd.")
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
			  local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			  local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, -475.4, 5988.46, 31.8)
  ---
  			if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then 
			  if PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' and dist <= 20.0 then
				  DrawMarker(27, -475.4, 5988.46, 31.24-0.90, 0, 0, 0, 0, 0, 0, 1.50, 1.50, 3.00, 50, 50, 204, 100, 0, 0, 0, 0)
			  else
				  Citizen.Wait(1500)
			  end
			  
			  if PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' and dist <= 7.0 then
				  DrawText3D(-475.4, 5988.46, 32.5, "~g~[E]~w~ Aby schować pojazd do garażu")
			  end
  --
			  if PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' and dist <= 7.0 then
				  if IsControlJustPressed(0, Keys['E']) then -- "E"
					  local playerPed = PlayerPedId()
					  if IsPedSittingInAnyVehicle(playerPed) then
						  local vehicle = GetVehiclePedIsIn(playerPed, false)
						  if GetPedInVehicleSeat(vehicle, -1) == playerPed then
							  exports['mythic_notify']:DoCustomHudText('inform', 'Pojazd został schowany do garażu', 3000)
							  --ESX.ShowNotification("Pojazd został schowany do ~y~garażu.")
							  --logi
							  local Player = ESX.GetPlayerData()
							  local org = Player.job.name	
							  Citizen.Wait(100)
							  local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId()))))
							  if model == "NULL" then
								  model = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId())))
							  end
							  TriggerServerEvent('srp_logs:policeGarageLog',org,model,0)
							  ESX.Game.DeleteVehicle(vehicle)
						  else
							  exports['mythic_notify']:DoCustomHudText('inform', 'Musisz być kierowcą aby schować pojazd', 3000)
							  --ESX.ShowNotification("Musisz być ~r~kierowcą ~w~aby schować pojazd.")
						  end
					  end			
				  end
			  end
			end
	  end
  end)
  
  -----------Text3D
  function DrawText3D(x, y, z, text)
	  local onScreen,_x,_y=World3dToScreen2d(x, y, z)
	  local px,py,pz=table.unpack(GetGameplayCamCoords())
	  
	  SetTextScale(0.3, 0.3)
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
  
  function DeleteSpawnedVehicles()
	  while #spawnedVehicles > 0 do
		  local vehicle = spawnedVehicles[1]
		  ESX.Game.DeleteVehicle(vehicle)
		  table.remove(spawnedVehicles, 1)
	  end
  end
  
  function WaitForVehicleToLoad(modelHash)
	  modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))
  
	  if not HasModelLoaded(modelHash) then
		  RequestModel(modelHash)
  
		  while not HasModelLoaded(modelHash) do
			  Citizen.Wait(0)
  
			  DisableControlAction(0, Keys['TOP'], true)
			  DisableControlAction(0, Keys['DOWN'], true)
			  DisableControlAction(0, Keys['LEFT'], true)
			  DisableControlAction(0, Keys['RIGHT'], true)
			  DisableControlAction(0, 176, true) -- ENTER key
			  DisableControlAction(0, Keys['BACKSPACE'], true)
  
			  drawLoadingText(_U('vehicleshop_awaiting_model'), 255, 255, 255, 255)
		  end
	  end
  end
  
  function drawLoadingText(text, red, green, blue, alpha)
	  SetTextFont(4)
	  SetTextProportional(0)
	  SetTextScale(0.0, 0.5)
	  SetTextColour(red, green, blue, alpha)
	  SetTextDropShadow(0, 0, 0, 0, 255)
	  SetTextEdge(1, 0, 0, 0, 255)
	  SetTextDropShadow()
	  SetTextOutline()
	  SetTextCentre(true)
  
	  BeginTextCommandDisplayText("STRING")
	  AddTextComponentSubstringPlayerName(text)
	  EndTextCommandDisplayText(0.5, 0.5)
  end
  
  function OpenPoliceActionsMenu()
	  ESX.UI.Menu.CloseAll()
  
	  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'police_actions',
	  {
		  title    = 'SHERIFF',
		  align    = 'top-left',
		  elements = {
			  {label = _U('citizen_interaction'),	value = 'citizen_interaction'},
			  {label = _U('vehicle_interaction'),	value = 'vehicle_interaction'},
			  {label = _U('object_spawner'),		value = 'object_spawner'}
		  }
	  }, function(data, menu)
  
		  if data.current.value == 'citizen_interaction' then
			  local elements = {
				  {label = _U('search'),			value = 'body_search'},
				  {label = _U('handcuff'),		value = 'handcuff'},
				  {label = _U('drag'),			value = 'drag'},
				  {label = _U('put_in_vehicle'),	value = 'put_in_vehicle'},
				  {label = _U('out_the_vehicle'),	value = 'out_the_vehicle'},
				  {label = _U('license_check'),	value = 'license'},
				  {label = 'Test na ślady prochu',value = 'check_for_gunpowder'},
				  {label = 'Sprawdź ID', 			value = 'check_id'},
				  {label = 'Tablet',   			value = 'jail_menu'}
			  }
		  
			  ESX.UI.Menu.Open(
			  'default', GetCurrentResourceName(), 'citizen_interaction',
			  {
				  title    = _U('citizen_interaction'),
				  align    = 'top-left',
				  elements = elements
			  }, function(data2, menu2)
				  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				  local action = data2.current.value
				  local pos = GetEntityCoords(closestNpc)
				  local playerloc = GetEntityCoords(PlayerPedId())
				  if data2.current.value == 'jail_menu' then
					  SendNUIMessage({type = 'show'})
					  SetNuiFocus(true, true)
				  end
				  local distanceToPed = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, playerloc.x, playerloc.y, playerloc.z, true)
				  if closestPlayer ~= -1 and closestDistance <= 3.0 then
					  if action == 'body_search' then
						  if not IsPlayerDead(closestPlayer) then
							  TriggerServerEvent('esx_policejob:message', GetPlayerServerId(closestPlayer), _U('being_searched'))
							  OpenBodySearchMenu(closestPlayer)
							  TriggerEvent('esx_policejob:playAnim', 'anim@gangops@facility@servers@bodysearch@', 'player_search')
							  else
								  exports['mythic_notify']:DoCustomHudText('inform', 'Nie możesz przeszukać osoby która potrzebuje pomocy medycznej', 3000)
								  --ESX.ShowNotification("Nie możesz przeszukać osoby która potrzebuje pomocy medycznej")
						  end
					  elseif action == 'handcuff' then
						  TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, 'Cuff', 0.1)
						  TriggerServerEvent('esx_policejob:handcuff', GetPlayerServerId(closestPlayer))
						  PlayerData = ESX.GetPlayerData()
						  local org = PlayerData.job.name
						  TriggerServerEvent('srp_logs:handcuffLog',org, GetPlayerServerId(closestPlayer))
					  elseif action == 'drag' then
						  TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(closestPlayer))
					  elseif action == 'put_in_vehicle' then
						  TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
					  elseif action == 'out_the_vehicle' then
						  TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
					  elseif action == 'license' then
						  ShowPlayerLicense(closestPlayer)
					  elseif data2.current.value == 'check_id' then
						  TriggerServerEvent('showid:ShowIdPolice', GetPlayerServerId(closestPlayer))
					  elseif data2.current.value == 'check_for_gunpowder' then
						  TriggerServerEvent('gunshot:check', GetPlayerServerId(closestPlayer))
					  end
				  elseif closestNpc ~= nil and distanceToPed < 3.5 then
					  if action == 'body_search' then
						  TriggerEvent('esx_policejob:playAnim', 'anim@gangops@facility@servers@bodysearch@', 'player_search')
						  if searchPedDelay < 0 then
							  exports['mythic_notify']:DoCustomHudText('inform', 'Przeszukujesz osobę', 3000)
							  --ESX.ShowNotification('~y~Przeszukujesz osobę')
							  TriggerServerEvent('esx_policejob:bodySearchPed')
							  searchPedDelay = 500
						  else
							  exports['mythic_notify']:DoCustomHudText('inform', 'Ta osoba nic przy sobie nie miała', 3000)
							  --ESX.ShowNotification('~y~Ta osoba nic przy sobie nie miała')
						  end
					  elseif action == 'handcuff' then
						  TriggerServerEvent('esx_policejob:handcuffPed', PedToNet(closestNpc))
						  PlayerData = ESX.GetPlayerData()
						  local org = PlayerData.job.name
						  TriggerServerEvent('srp_logs:handcuffLog',org, 500)
						  TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'handcuff', 0.4)
					  elseif action == 'drag' then
						  TriggerServerEvent('esx_policejob:dragPed', PedToNet(closestNpc))
					  elseif action == 'put_in_vehicle' then
						  TriggerServerEvent('esx_policejob:putInVehiclePed', PedToNet(closestNpc))
					  elseif action == 'out_the_vehicle' then
						  TriggerServerEvent('esx_policejob:OutVehiclePed',PedToNet(closestNpc))
					  elseif action == 'license' then
						  exports['mythic_notify']:DoCustomHudText('inform', 'Ta osoba nie ma przy sobie żadnych licencji', 3000)
						  --ESX.ShowNotification('~r~Ta osoba nie ma przy sobie żadnych licencji')
					  elseif data2.current.value == 'check_id' then
						  exports['mythic_notify']:DoCustomHudText('inform', 'Ta osoba nie ma przy sobie dokumentów', 3000)
						  --ESX.ShowNotification('~r~Ta osoba nie ma przy sobie dokumentów')
					  elseif data2.current.value == 'check_for_gunpowder' then
						  exports['mythic_notify']:DoCustomHudText('inform', 'Ta osoba ma czyste ręcei', 3000)
						  --ESX.ShowNotification('~r~Ta osoba ma czyste ręce')
					  end
				  end
			  end, function(data2, menu2)
				  menu2.close()
			  end)
		  elseif data.current.value == 'vehicle_interaction' then
			  local elements  = {}
			  local playerPed = PlayerPedId()
			  local coords    = GetEntityCoords(playerPed)
			  local vehicle   = ESX.Game.GetVehicleInDirection()
			  
			  table.insert(elements, {label = _U('pick_lock'),	value = 'hijack_vehicle'})
			  table.insert(elements, {label = _U('impound'),		value = 'impound'})
  
			  ESX.UI.Menu.Open(
			  'default', GetCurrentResourceName(), 'vehicle_interaction',
			  {
				  title    = _U('vehicle_interaction'),
				  align    = 'top-left',
				  elements = elements
			  }, function(data2, menu2)
				  coords  = GetEntityCoords(playerPed)
				  vehicle = ESX.Game.GetVehicleInDirection()
				  action  = data2.current.value
				  
				  if DoesEntityExist(vehicle) then
					  local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
					  if action == 'hijack_vehicle' then
						  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
							  TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
							  exports['mythic_progbar']:Progress({
								  name = "firstaid_action",
								  duration = 10000,
								  label = "Otwieranie pojazdu...",
								  useWhileDead = false,
								  canCancel = false,
								  controlDisables = {
									  disableMovement = true,
									  disableCarMovement = true,
									  disableMouse = false,
									  disableCombat = true,
								  }
								  })
							  Citizen.Wait(10000)
							  ClearPedTasksImmediately(playerPed)
  
							  SetVehicleDoorsLocked(vehicle, 1)
							  SetVehicleDoorsLockedForAllPlayers(vehicle, false)
							  exports['mythic_notify']:DoCustomHudText('inform', 'Pojazd został otworzony', 3000)
							  --ESX.ShowNotification(_U('vehicle_unlocked'))
						  end
					  elseif action == 'impound' then
					  
						  -- is the script busy?
						  if CurrentTask.Busy then
							  return
						  end
  
						  ESX.ShowHelpNotification(_U('impound_prompt'))
						  
						  TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
						  
						  CurrentTask.Busy = true
						  CurrentTask.Task = ESX.SetTimeout(10000, function()
							  ClearPedTasks(playerPed)
							  ImpoundVehicle(vehicle)
							  Citizen.Wait(100) -- sleep the entire script to let stuff sink back to reality
						  end)
						  
						  -- keep track of that vehicle!
						  Citizen.CreateThread(function()
							  while CurrentTask.Busy do
								  Citizen.Wait(1000)
							  
								  vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
								  if not DoesEntityExist(vehicle) and CurrentTask.Busy then
									  exports['mythic_notify']:DoCustomHudText('inform', 'Zajęcie zostało anulowane, ponieważ pojazd przemieścił się', 3000)
									  --ESX.ShowNotification(_U('impound_canceled_moved'))
									  ESX.ClearTimeout(CurrentTask.Task)
									  ClearPedTasks(playerPed)
									  CurrentTask.Busy = false
									  break
								  end
							  end
						  end)
					  end
				  else
					  exports['mythic_notify']:DoCustomHudText('inform', 'Nie ma pojazdów w pobliżu', 3000)
					  --ESX.ShowNotification(_U('no_vehicles_nearby'))
				  end
  
			  end, function(data2, menu2)
				  menu2.close()
			  end)
  
		  elseif data.current.value == 'object_spawner' then
			  ESX.UI.Menu.Open(
			  'default', GetCurrentResourceName(), 'citizen_interaction',
			  {
				  title    = _U('traffic_interaction'),
				  align    = 'top-left',
				  elements = {
					  {label = _U('cone'),		value = 'prop_roadcone02a'},
					  {label = _U('barrier'),		value = 'prop_barrier_work05'},
					  {label = _U('spikestrips'),	value = 'p_ld_stinger_s'},
					  {label = _U('box'),			value = 'prop_boxpile_07d'},
					  {label = _U('cash'),		value = 'hei_prop_cash_crate_half_full'}
				  }
			  }, function(data2, menu2)
				  local model     = data2.current.value
				  local playerPed = PlayerPedId()
				  local coords    = GetEntityCoords(playerPed)
				  local forward   = GetEntityForwardVector(playerPed)
				  local x, y, z   = table.unpack(coords + forward * 1.0)
  
				  if model == 'prop_roadcone02a' then
					  z = z - 2.0
				  end
  
				  ESX.Game.SpawnObject(model, {
					  x = x,
					  y = y,
					  z = z
				  }, function(obj)
					  SetEntityHeading(obj, GetEntityHeading(playerPed))
					  PlaceObjectOnGroundProperly(obj)
				  end)
  
			  end, function(data2, menu2)
				  menu2.close()
			  end)
		  end
  
	  end, function(data, menu)
		  menu.close()
	  end)
  end
  
  function OpenBodySearchMenu(player)
	  TriggerEvent("esx_inventoryhud:openPlayerInventory", GetPlayerServerId(player), GetPlayerName(player))
  end
  --[[
  function OpenBodySearchMenu(player)
  
	  ESX.TriggerServerCallback('srp_sheriffjob:getOtherPlayerData', function(data)
  
		  local elements = {}
  
		  for i=1, #data.accounts, 1 do
  
			  if data.accounts[i].name == 'black_money' and data.accounts[i].money > 0 then
  
				  table.insert(elements, {
					  label    = _U('confiscate_dirty', ESX.Math.Round(data.accounts[i].money)),
					  value    = 'black_money',
					  itemType = 'item_account',
					  amount   = data.accounts[i].money
				  })
  
				  break
			  end
  
		  end
  
		  table.insert(elements, {label = _U('guns_label'), value = nil})
  
		  for i=1, #data.weapons, 1 do
			  table.insert(elements, {
				  label    = _U('confiscate_weapon', ESX.GetWeaponLabel(data.weapons[i].name), data.weapons[i].ammo),
				  value    = data.weapons[i].name,
				  itemType = 'item_weapon',
				  amount   = data.weapons[i].ammo
			  })
		  end
  
		  table.insert(elements, {label = _U('inventory_label'), value = nil})
  
		  for i=1, #data.inventory, 1 do
			  if data.inventory[i].count > 0 then
				  table.insert(elements, {
					  label    = _U('confiscate_inv', data.inventory[i].count, data.inventory[i].label),
					  value    = data.inventory[i].name,
					  itemType = 'item_standard',
					  amount   = data.inventory[i].count
				  })
			  end
		  end
  
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'body_search',
		  {
			  title    = _U('search'),
			  align    = 'top-left',
			  elements = elements,
		  },
		  function(data, menu)
  
			  local itemType = data.current.itemType
			  local itemName = data.current.value
			  local amount   = data.current.amount
  
			  if data.current.value ~= nil then
				  TriggerServerEvent('srp_sheriffjob:confiscatePlayerItem', GetPlayerServerId(player), itemType, itemName, amount)
				  OpenBodySearchMenu(player)
			  end
  
		  end, function(data, menu)
			  menu.close()
		  end)
  
	  end, GetPlayerServerId(player))
  
  end
  --]]
  
  function ShowPlayerLicense(player)
	  local elements = {}
	  local targetName
	  ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)
		  if data.licenses then
			  for i=1, #data.licenses, 1 do
				  if data.licenses[i].label and data.licenses[i].type then
					  table.insert(elements, {
						  label = data.licenses[i].label,
						  type = data.licenses[i].type
					  })
				  end
			  end
		  end
		  
		  if Config.EnableESXIdentity then
			  targetName = data.firstname .. ' ' .. data.lastname
		  else
			  targetName = data.name
		  end
		  
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_license',
		  {
			  title    = _U('license_revoke'),
			  align    = 'top-left',
			  elements = elements,
		  }, function(data, menu)
			  ESX.ShowNotification(_U('licence_you_revoked', data.current.label, targetName))
			  TriggerServerEvent('srp_sheriffjob:message', GetPlayerServerId(player), _U('license_revoked', data.current.label))
			  
			  TriggerServerEvent('esx_license:removeLicense', GetPlayerServerId(player), data.current.type)
			  
			  ESX.SetTimeout(300, function()
				  ShowPlayerLicense(player)
			  end)
		  end, function(data, menu)
			  menu.close()
		  end)
  
	  end, GetPlayerServerId(player))
  end
  
  function OpenGetWeaponMenu()
  
	  ESX.TriggerServerCallback('srp_sheriffjob:getArmoryWeapons', function(weapons)
		  local elements = {}
  
		  for i=1, #weapons, 1 do
			  if weapons[i].count > 0 then
				  table.insert(elements, {
					  label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name),
					  value = weapons[i].name
				  })
			  end
		  end
  
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_get_weapon',
		  {
			  title    = _U('get_weapon_menu'),
			  align    = 'top-left',
			  elements = elements
		  }, function(data, menu)
			  menu.close()
			  ESX.TriggerServerCallback('srp_sheriffjob:removeArmoryWeapon', function()
				  OpenGetWeaponMenu()
				  SetPedWeaponTintIndex(PlayerPedId(), data.current.value, 5)
			  end, data.current.value)
  
		  end, function(data, menu)
			  menu.close()
		  end)
	  end)
  
  end
  
  function OpenPutWeaponMenu()
	  local elements   = {}
	  local playerPed  = PlayerPedId()
	  local weaponList = ESX.GetWeaponList()
  
	  for i=1, #weaponList, 1 do
		  local weaponHash = GetHashKey(weaponList[i].name)
  
		  if HasPedGotWeapon(playerPed, weaponHash, false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
			  table.insert(elements, {
				  label = weaponList[i].label,
				  value = weaponList[i].name
			  })
		  end
	  end
  
	  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_put_weapon',
	  {
		  title    = _U('put_weapon_menu'),
		  align    = 'top-left',
		  elements = elements
	  }, function(data, menu)
  
		  menu.close()
		  local Player = ESX.GetPlayerData()
		  local org = Player.job.name	
		  local weapon_name = ESX.GetWeaponLabel(data.current.value)
		  TriggerServerEvent('srp_logs:policeArmoryLog',org,weapon_name,0)
		  ESX.TriggerServerCallback('srp_sheriffjob:addArmoryWeapon', function()
			  OpenPutWeaponMenu()
		  end, data.current.value, true)
  
	  end, function(data, menu)
		  menu.close()
	  end)
  end
  
  function OpenBuyWeaponsMenu()
  
	  local elements = {}
	  local playerPed = PlayerPedId()
	  PlayerData = ESX.GetPlayerData()
  
	  for k,v in ipairs(Config.AuthorizedWeapons2.Shared) do
		  local weaponNum, weapon = ESX.GetWeapon(v.weapon)
		  local components, label = {}
  
		  local hasWeapon = HasPedGotWeapon(playerPed, GetHashKey(v.weapon), false)
  
		  if v.components then
			  for i=1, #v.components do
				  if v.components[i] then
  
					  local component = weapon.components[i]
					  local hasComponent = HasPedGotWeaponComponent(playerPed, GetHashKey(v.weapon), component.hash)
					  if component.label ~= 'Powiększony magazynek' then
						  if hasComponent then
							  label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('armory_owned'))
						  else
							  if v.components[i] > 0 then
								  label = ('%s <span style="color:green;">%s</span>'):format(component.label, _U('armory_item', ESX.Math.GroupDigits(v.components[i])))
							  else
								  label = ('%s <span style="color:green;">%s</span>'):format(component.label, _U('armory_free'))
							  end
						  end
						  table.insert(components, {
							  label = label,
							  componentLabel = component.label,
							  hash = component.hash,
							  name = component.name,
							  price = v.components[i],
							  hasComponent = hasComponent,
							  componentNum = i
						  })
					  end
				  end
			  end
		  end
  
		  if hasWeapon and v.components then
			  label = ('%s <span style="color:green;">POSIADASZ</span>'):format(weapon.label)
		  elseif hasWeapon and not v.components then
			  label = ('%s <span style="color:green;">%s</span>'):format(weapon.label, _U('armory_owned'))
		  else
			  if v.price > 0 then
				  label = ('%s <span style="color:green;">%s</span>'):format(weapon.label, _U('armory_item', ESX.Math.GroupDigits(v.price)))
			  else
				  label = ('%s <span style="color:green;">%s</span>'):format(weapon.label, _U('armory_free'))
			  end
		  end
  
		  table.insert(elements, {
			  label = label,
			  weaponLabel = weapon.label,
			  name = weapon.name,
			  components = components,
			  price = v.price,
			  hasWeapon = hasWeapon
		  })
	  end
  
	  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_buy_weapons', {
		  title    = _U('armory_weapontitle'),
		  align    = 'top-left',
		  elements = elements
	  }, function(data, menu)
  
		  if data.current.hasWeapon then
			  if #data.current.components > 0 then
				  OpenWeaponComponentShop(data.current.components, data.current.name, menu)
			  end
		  else
			  local Player = ESX.GetPlayerData()
			  local org = Player.job.name	
			  local weapon_name = ESX.GetWeaponLabel(data.current.name)
			  TriggerServerEvent('srp_logs:policeArmoryLog',org,weapon_name,1)
			  ESX.TriggerServerCallback('srp_sheriffjob:buyWeapon', function(bought)
				  if bought then
					  SetPedWeaponTintIndex(PlayerPedId(), data.current.name, 5)
					  if data.current.price > 0 then
						  ESX.ShowNotification(_U('armory_bought', data.current.weaponLabel, ESX.Math.GroupDigits(data.current.price)))
					  end
  
					  menu.close()
  
					  OpenBuyWeaponsMenu()
				  else
					  exports['mythic_notify']:DoCustomHudText('inform', 'Nie możesz kupić tej broni', 3000)
					  --ESX.ShowNotification(_U('armory_money'))
				  end
			  end, data.current.name, 1)
		  end
  
	  end, function(data, menu)
		  menu.close()
	  end)
  
  end
  
  function OpenWeaponComponentShop(components, weaponName, parentShop)
	  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_buy_weapons_components', {
		  title    = _U('armory_componenttitle'),
		  align    = 'top-left',
		  elements = components
	  }, function(data, menu)
  
		  if data.current.hasComponent then
			  exports['mythic_notify']:DoCustomHudText('inform', 'Zakupiłeś dodatek do broni', 3000)
			  --ESX.ShowNotification(_U('armory_hascomponent'))
		  else
			  ESX.TriggerServerCallback('srp_sheriffjob:buyWeapon', function(bought)
				  if bought then
					  if data.current.price > 0 then
						  ESX.ShowNotification(_U('armory_bought', data.current.componentLabel, ESX.Math.GroupDigits(data.current.price)))
					  end
  
					  menu.close()
					  parentShop.close()
  
					  OpenBuyWeaponsMenu()
				  else
					  exports['mythic_notify']:DoCustomHudText('inform', 'Nie możesz kupić tej broni', 3000)
					  --ESX.ShowNotification(_U('armory_money'))
				  end
			  end, weaponName, 2, data.current.componentNum)
		  end
  
	  end, function(data, menu)
		  menu.close()
	  end)
  end
  
  function OpenGetStocksMenu()
  
	  ESX.TriggerServerCallback('srp_sheriffjob:getStockItems', function(items)
  
		  local elements = {}
  
		  if items[0] ~= nil then
			  for i=1, #items, 1 do
				  table.insert(elements, {
					  label = 'x' .. items[i].count .. ' ' .. items[i].label,
					  value = items[i].name
				  })
			  end
		  end
  
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu',
		  {
			  title    = _U('police_stock'),
			  align    = 'top-left',
			  elements = elements
		  }, function(data, menu)
  
			  local itemName = data.current.value
  
			  ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				  title = _U('quantity')
			  }, function(data2, menu2)
  
				  local count = tonumber(data2.value)
  
				  if count == nil then
					  exports['mythic_notify']:DoCustomHudText('inform', 'Nieprawidłowa ilość', 3000)
					  --ESX.ShowNotification(_U('quantity_invalid'))
				  else
					  menu2.close()
					  menu.close()
					  TriggerServerEvent('srp_sheriffjob:getStockItem', itemName, count)
  
					  Citizen.Wait(300)
					  OpenGetStocksMenu()
				  end
  
			  end, function(data2, menu2)
				  menu2.close()
			  end)
  
		  end, function(data, menu)
			  menu.close()
		  end)
  
	  end)
  
  end
  
  function OpenPutStocksMenu()
  
	  ESX.TriggerServerCallback('srp_sheriffjob:getPlayerInventory', function(inventory)
  
		  local elements = {}
  
		  for i=1, #inventory.items, 1 do
			  local item = inventory.items[i]
  
			  if item.count > 0 then
				  table.insert(elements, {
					  label = item.label .. ' x' .. item.count,
					  type = 'item_standard',
					  value = item.name
				  })
			  end
		  end
  
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu',
		  {
			  title    = _U('inventory'),
			  align    = 'top-left',
			  elements = elements
		  }, function(data, menu)
  
			  local itemName = data.current.value
  
			  ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				  title = _U('quantity')
			  }, function(data2, menu2)
  
				  local count = tonumber(data2.value)
  
				  if count == nil then
					  exports['mythic_notify']:DoCustomHudText('inform', 'Nieprawidłowa ilość', 3000)
					  --ESX.ShowNotification(_U('quantity_invalid'))
				  else
					  menu2.close()
					  menu.close()
					  TriggerServerEvent('srp_sheriffjob:putStockItems', itemName, count)
  
					  Citizen.Wait(300)
					  OpenPutStocksMenu()
				  end
  
			  end, function(data2, menu2)
				  menu2.close()
			  end)
  
		  end, function(data, menu)
			  menu.close()
		  end)
	  end)
  
  end
  
  function OpenGetItemMenu()
	  local elements = {
		  { label = 'Policyjny zestaw naprawczy', value = 'polfixkit' },
		  { label = 'Radio', value = 'radio' },
		  { label = 'Woda', value = 'water' }
	  }
	  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_get_weapon',
	  {
		  title    = _U('get_weapon_menu'),
		  align    = 'top-left',
		  elements = elements
	  }, function(data, menu)
		  menu.close()
		  local amount = 1
		  if data.current.label == 'Woda' then
			  amount = 10
		  end
		  TriggerServerEvent('srp_sheriffjob:get_item', data.current.label, data.current.value, amount)
	  end, function(data, menu)
		  menu.close()
	  end)
  end
  
  RegisterNetEvent('esx:setJob')
  AddEventHandler('esx:setJob', function(job)
	  PlayerData.job = job
	  
	  Citizen.Wait(5000)
	  TriggerServerEvent('srp_sheriffjob:forceBlip')
  end)
  
  AddEventHandler('srp_sheriffjob:hasEnteredMarker', function(station, part, partNum)
  
	  if part == 'Cloakroom' then
		  CurrentAction     = 'menu_cloakroom'
		  CurrentActionMsg  = _U('open_cloackroom')
		  CurrentActionData = {}
  
	  elseif part == 'Armory' then
  
		  CurrentAction     = 'menu_armory'
		  CurrentActionMsg  = _U('open_armory')
		  CurrentActionData = {station = station}
  
	  elseif part == 'Vehicles' then
  
		  CurrentAction     = 'menu_vehicle_spawner'
		  CurrentActionMsg  = _U('garage_prompt')
		  CurrentActionData = {station = station, part = part, partNum = partNum}
  
	  elseif part == 'Helicopters' then
  
		  CurrentAction     = 'Helicopters'
		  CurrentActionMsg  = _U('helicopter_prompt')
		  CurrentActionData = {station = station, part = part, partNum = partNum}
  
	  elseif part == 'BossActions' then
  
		  CurrentAction     = 'menu_boss_actions'
		  CurrentActionMsg  = _U('open_bossmenu')
		  CurrentActionData = {}
  
	  end
  
  end)
  
  AddEventHandler('srp_sheriffjob:hasExitedMarker', function(station, part, partNum)
	  if not isInShopMenu then
		  ESX.UI.Menu.CloseAll()
	  end
  
	  CurrentAction = nil
  end)
  
  AddEventHandler('srp_sheriffjob:hasEnteredEntityZone', function(entity)
	  local playerPed = PlayerPedId()
  
	  if PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' and IsPedOnFoot(playerPed) then
		  CurrentAction     = 'remove_entity'
		  CurrentActionMsg  = _U('remove_prop')
		  CurrentActionData = {entity = entity}
	  end
  
	  if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then
		  local playerPed = PlayerPedId()
		  local coords    = GetEntityCoords(playerPed)
  
		  if IsPedInAnyVehicle(playerPed, false) then
			  local vehicle = GetVehiclePedIsIn(playerPed)
  
			  for i=0, 7, 1 do
				  SetVehicleTyreBurst(vehicle, i, true, 1000)
			  end
		  end
	  end
  end)
  
  AddEventHandler('srp_sheriffjob:hasExitedEntityZone', function(entity)
	  if CurrentAction == 'remove_entity' then
		  CurrentAction = nil
	  end
  end)
  
  --[[RegisterNetEvent('esx_policejob:handcuff')
  AddEventHandler('esx_policejob:handcuff', function()
	  IsHandcuffed    = not IsHandcuffed
	  local playerPed = PlayerPedId()
	  if IsHandcuffed then
		  setUniform('handcuffs', PlayerPedId())
		  exports['mythic_notify']:DoCustomHudText('inform', 'Zostałeś zakuty', 3000)
		  --ESX.ShowNotification("~r~Zostałeś zakuty")
		  TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, "handcuff", 0.4)
		  Wait(3000)
	  else
		  setUniform('no_handcuffs', PlayerPedId())
		  --ESX.ShowNotification("~y~Zostałeś odkuty")
		  exports['mythic_notify']:DoCustomHudText('inform', 'Zostałeś odkuty', 3000)
		  TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, "handcuff", 0.4)
		  Wait(7000)
	  end
	  
	  Citizen.CreateThread(function()
		  if IsHandcuffed then
  
			  RequestAnimDict('mp_arresting')
			  while not HasAnimDictLoaded('mp_arresting') do
				  Citizen.Wait(100)
			  end
  
			  TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
  
			  SetEnableHandcuffs(playerPed, true)
			  DisablePlayerFiring(playerPed, true)
			  SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
			  SetPedCanPlayGestureAnims(playerPed, false)
			  FreezeEntityPosition(playerPed, true)
			  DisplayRadar(false)
  
			  if Config.EnableHandcuffTimer2 then
  
				  if HandcuffTimer2.Active then
					  ESX.ClearTimeout(HandcuffTimer2.Task)
				  end
  
				  StartHandcuffTimer2()
			  end
  
		  else
  
			  if Config.EnableHandcuffTimer2 and HandcuffTimer2.Active then
				  ESX.ClearTimeout(HandcuffTimer2.Task)
			  end
  
			  ClearPedSecondaryTask(playerPed)
			  SetEnableHandcuffs(playerPed, false)
			  DisablePlayerFiring(playerPed, false)
			  SetPedCanPlayGestureAnims(playerPed, true)
			  FreezeEntityPosition(playerPed, false)
			  DisplayRadar(true)
		  end
	  end
  end)]]
  
  RegisterNetEvent('srp_sheriffjob:unrestrain')
  AddEventHandler('srp_sheriffjob:unrestrain', function()
	  if IsHandcuffed then
		  local playerPed = PlayerPedId()
		  IsHandcuffed = false
		  ClearPedSecondaryTask(playerPed)
		  SetEnableHandcuffs(playerPed, false)
		  DisablePlayerFiring(playerPed, false)
		  SetPedCanPlayGestureAnims(playerPed, true)
		  FreezeEntityPosition(playerPed, false)
		  DisplayRadar(true)
		  if Config.EnableHandcuffTimer2 and HandcuffTimer2.Active then
			  ESX.ClearTimeout(HandcuffTimer2.Task)
		  end
	  end
  end)
  
  RegisterNetEvent('srp_sheriffjob:drag')
  AddEventHandler('srp_sheriffjob:drag', function(copID)
	  if not IsHandcuffed then
		  return
	  end
	  
	  DragStatus.IsDragged = not DragStatus.IsDragged
	  DragStatus.CopId     = tonumber(copID)
	  
	  if DragStatus.IsDragged then
		  exports['mythic_notify']:DoCustomHudText('inform', 'Jesteś eskortowany', 3000)
		  --ESX.ShowNotification('~r~Jesteś eskortowany')
	  else
		  exports['mythic_notify']:DoCustomHudText('inform', 'Nie jesteś już eskortowany', 3000)
		  --ESX.ShowNotification('~g~Nie jesteś już eskortowany')
	  end
  end)
  
  RegisterNetEvent('srp_sheriffjob:putInVehicle')
  AddEventHandler('srp_sheriffjob:putInVehicle', function()
	  local playerPed = PlayerPedId()
	  local coords = GetEntityCoords(playerPed)
  
	  if not IsHandcuffed then
		  return
	  end
  
	  if IsAnyVehicleNearPoint(coords, 5.0) then
		  local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)
  
		  if DoesEntityExist(vehicle) then
			  local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)
  
			  for i=maxSeats - 1, 0, -1 do
				  if IsVehicleSeatFree(vehicle, i) then
					  freeSeat = i
					  break
				  end
			  end
  
			  if freeSeat then
				  TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				  DragStatus.IsDragged = false
			  end
		  end
	  end
  end)
  
  RegisterNetEvent('srp_sheriffjob:OutVehicle')
  AddEventHandler('srp_sheriffjob:OutVehicle', function()
	  local playerPed = PlayerPedId()
  
	  if not IsPedSittingInAnyVehicle(playerPed) then
		  return
	  end
  
	  local vehicle = GetVehiclePedIsIn(playerPed, false)
	  TaskLeaveVehicle(playerPed, vehicle, 16)
  end)
  
  Citizen.CreateThread(function()
	  while true do
		  Citizen.Wait(1)
		  if IsHandcuffed then
			  if not IsEntityPlayingAnim(PlayerPedId(), 'mp_arresting', "idle", 3) then
				  RequestAnimDict('mp_arresting')
				  while not HasAnimDictLoaded('mp_arresting') do
					  Wait(1)
				  end
				  TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
			  end
			  DisableControlAction(0, 142, true) -- LPM
			  DisableControlAction(0, 24,  true) -- LPM
			  DisableControlAction(0, 92,  true) -- LPM (car)
			  DisableControlAction(0, 25,  true) -- PPM
			  DisableControlAction(0, 45,  true) -- R
			  DisableControlAction(0, 76,  true) -- SPACE
			  DisableControlAction(0, 102,  true) -- SPACE
			  DisableControlAction(0, 280,  true) -- L CTRL
			  DisableControlAction(0, 281,  true) -- L CTRL
			  DisableControlAction(0, 140, true) -- R
			  DisableControlAction(2, 24, true) -- LPM
			  DisableControlAction(2, 257, true) -- LPM
			  DisableControlAction(2, 25, true) -- PPM
			  DisableControlAction(2, 263, true) -- R
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
			  DisableControlAction(2, Keys["~"], true)
			  DisableControlAction(2, Keys["X"], true)
		  else
			  Citizen.Wait(500)
		  end
	  end
  end)
  
  -- Create blips
  Citizen.CreateThread(function()
  
	  for k,v in pairs(Config.PoliceStations2) do
		  local blip = AddBlipForCoord(v.Blip.Coords)
  
		  SetBlipSprite (blip, v.Blip.Sprite)
		  SetBlipDisplay(blip, v.Blip.Display)
		  SetBlipScale  (blip, v.Blip.Scale)
		  SetBlipColour (blip, v.Blip.Colour)
		  SetBlipAsShortRange(blip, true)
  
		  BeginTextCommandSetBlipName("STRING")
		  AddTextComponentString(v.Blip.Name)
		  EndTextCommandSetBlipName(blip)
	  end
  
  end)
  
  -- Display markers
  Citizen.CreateThread(function()
	  while true do
  
		  Citizen.Wait(0)
  
		  if PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' then
  
			  local playerPed = PlayerPedId()
			  local coords    = GetEntityCoords(playerPed)
			  local isInMarker, hasExited, letSleep = false, false, true
			  local currentStation, currentPart, currentPartNum
  
			  for k,v in pairs(Config.PoliceStations2) do
  
				  for i=1, #v.Cloakrooms, 1 do
					  local distance = GetDistanceBetweenCoords(coords, v.Cloakrooms[i], true)
  
					  if distance < Config.DrawDistance then
						  DrawMarker(27, v.Cloakrooms[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						  letSleep = false
					  end
  
					  if distance < Config.MarkerSize.x then
						  isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Cloakroom', i
					  end
				  end
  
				  for i=1, #v.Armories, 1 do
					  local distance = GetDistanceBetweenCoords(coords, v.Armories[i], true)
  
					  if distance < Config.DrawDistance then
						  DrawMarker(27, v.Armories[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						  letSleep = false
					  end
  
					  if distance < Config.MarkerSize.x then
						  isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Armory', i
					  end
				  end
  
				  for i=1, #v.Vehicles, 1 do
					  local distance = GetDistanceBetweenCoords(coords, v.Vehicles[i].Spawner, true)
  
					  if distance < Config.DrawDistance then
						  DrawMarker(36, v.Vehicles[i].Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						  letSleep = false
					  end
  
					  if distance < Config.MarkerSize.x then
						  isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Vehicles', i
					  end
				  end
  
				  for i=1, #v.Helicopters, 1 do
					  local distance =  GetDistanceBetweenCoords(coords, v.Helicopters[i].Spawner, true)
  
					  if distance < Config.DrawDistance then
						  DrawMarker(34, v.Helicopters[i].Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						  letSleep = false
					  end
  
					  if distance < Config.MarkerSize.x then
						  isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Helicopters', i
					  end
				  end
  
				  if Config.EnablePlayerManagement2 and PlayerData.job.grade_name == 'por3' or PlayerData.job.grade_name == 'kapitan1' or PlayerData.job.grade_name == 'kapitan2' or PlayerData.job.grade_name == 'kapitan3' or PlayerData.job.grade_name == 'szef1' or PlayerData.job.grade_name == 'szeryf' or PlayerData.job.grade_name == 'boss' then
					  for i=1, #v.BossActions, 1 do
						  local distance = GetDistanceBetweenCoords(coords, v.BossActions[i], true)
  
						  if distance < Config.DrawDistance then
							  DrawMarker(27, v.BossActions[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
							  letSleep = false
						  end
  
						  if distance < Config.MarkerSize.x then
							  isInMarker, currentStation, currentPart, currentPartNum = true, k, 'BossActions', i
						  end
					  end
				  end
			  end
  
			  if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
	  
				  if
					  (LastStation ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
					  (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
				  then
					  TriggerEvent('srp_sheriffjob:hasExitedMarker', LastStation, LastPart, LastPartNum)
					  hasExited = true
				  end
  
				  HasAlreadyEnteredMarker = true
				  LastStation             = currentStation
				  LastPart                = currentPart
				  LastPartNum             = currentPartNum
  
				  TriggerEvent('srp_sheriffjob:hasEnteredMarker', currentStation, currentPart, currentPartNum)
  
			  end
  
			  if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				  HasAlreadyEnteredMarker = false
				  TriggerEvent('srp_sheriffjob:hasExitedMarker', LastStation, LastPart, LastPartNum)
			  end
  
			  if letSleep then
				  Citizen.Wait(500)
			  end
  
		  else
			  Citizen.Wait(500)
		  end
	  end
  end)
  
  -- Enter / Exit entity zone events
  Citizen.CreateThread(function()
	  local trackedEntities = {
		  'prop_roadcone02a',
		  'prop_barrier_work05',
		  'p_ld_stinger_s',
		  'prop_boxpile_07d',
		  'hei_prop_cash_crate_half_full'
	  }
  
	  while true do
		  Citizen.Wait(500)
  
		  local playerPed = PlayerPedId()
		  local coords    = GetEntityCoords(playerPed)
  
		  local closestDistance = -1
		  local closestEntity   = nil
  
		  for i=1, #trackedEntities, 1 do
			  local object = GetClosestObjectOfType(coords, 3.0, GetHashKey(trackedEntities[i]), false, false, false)
  
			  if DoesEntityExist(object) then
				  local objCoords = GetEntityCoords(object)
				  local distance  = GetDistanceBetweenCoords(coords, objCoords, true)
  
				  if closestDistance == -1 or closestDistance > distance then
					  closestDistance = distance
					  closestEntity   = object
				  end
			  end
		  end
  
		  if closestDistance ~= -1 and closestDistance <= 3.0 then
			  if LastEntity ~= closestEntity then
				  TriggerEvent('srp_sheriffjob:hasEnteredEntityZone', closestEntity)
				  LastEntity = closestEntity
			  end
		  else
			  if LastEntity ~= nil then
				  TriggerEvent('srp_sheriffjob:hasExitedEntityZone', LastEntity)
				  LastEntity = nil
			  end
		  end
	  end
  end)
  
  -- Key Controls
  Citizen.CreateThread(function()
	  while true do
  
		  Citizen.Wait(10)
		  if IsControlJustPressed(0, Keys['E']) and IsControlPressed(0, Keys['LEFTSHIFT']) and PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' then
			  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			  if closestPlayer ~= -1 and closestDistance <= 2.0 then
				  TriggerServerEvent('esx_policejob:handcuff', GetPlayerServerId(closestPlayer))
				  TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, 'Cuff', 0.1)
				  PlayerData = ESX.GetPlayerData()
				  local org = PlayerData.job.name
				  TriggerServerEvent('srp_logs:handcuffLog',org, GetPlayerServerId(closestPlayer))
			  elseif closestNpc ~= nil then
				  local pos = GetEntityCoords(closestNpc)
				  local playerloc = GetEntityCoords(PlayerPedId())
				  local distanceToPed = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, playerloc.x, playerloc.y, playerloc.z, true)
				  if distanceToPed < 3.5 then
					  TriggerServerEvent('esx_policejob:handcuffPed', PedToNet(closestNpc))
					  PlayerData = ESX.GetPlayerData()
					  local org = PlayerData.job.name					
					  TriggerServerEvent('srp_logs:handcuffLog',org,500)
					  TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, 'Cuff', 0.1)
					  TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, "handcuff", 0.4)
					  closestNpc = nil
				  end
			  end
		  end
		  if IsControlJustPressed(0, Keys['X']) and IsControlPressed(0, Keys['LEFTSHIFT']) and PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' then
			  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			  if closestPlayer ~= -1 and closestDistance <= 2.0 then
				  TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(closestPlayer))
			  elseif closestNpc ~= nil then
				  local pos = GetEntityCoords(closestNpc)
				  local playerloc = GetEntityCoords(PlayerPedId())
				  local distanceToPed = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, playerloc.x, playerloc.y, playerloc.z, true)
				  if distanceToPed < 3.5 then
					  TriggerServerEvent('esx_policejob:dragPed', PedToNet(closestNpc))
					  closestNpc = nil
				  end
			  end
		  end
		  if IsControlJustPressed(0, Keys['[']) and IsControlPressed(0, Keys['LEFTSHIFT']) and PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' then
			  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			  if closestPlayer ~= -1 and closestDistance <= 2.0 then
				  TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
			  elseif closestNpc ~= nil then
				  local pos = GetEntityCoords(closestNpc)
				  local playerloc = GetEntityCoords(PlayerPedId())
				  local distanceToPed = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, playerloc.x, playerloc.y, playerloc.z, true)
				  if distanceToPed < 3.5 then
					  TriggerServerEvent('esx_policejob:putInVehiclePed', PedToNet(closestNpc))
					  closestNpc = nil
				  end
			  end
		  end
		  if IsControlJustPressed(0, Keys[']']) and IsControlPressed(0, Keys['LEFTSHIFT']) and PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' then
			  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			  if closestPlayer ~= -1 and closestDistance <= 2.0 then
				  TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
			  elseif closestNpc ~= nil then
				  local pos = GetEntityCoords(closestNpc)
				  local playerloc = GetEntityCoords(PlayerPedId())
				  local distanceToPed = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, playerloc.x, playerloc.y, playerloc.z, true)
				  if distanceToPed < 3.5 then
					  TriggerServerEvent('esx_policejob:OutVehiclePed', PedToNet(closestNpc))
					  closestNpc = nil
				  end
			  end
		  end	
		  if IsControlJustPressed(0, Keys['K']) and IsControlPressed(0, Keys['LEFTSHIFT']) and PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' then
			  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			  if closestPlayer ~= -1 and closestDistance <= 2.0 then
				  TriggerServerEvent('esx_sheriffjob:message', GetPlayerServerId(closestPlayer), _U('being_searched'))
				  OpenBodySearchMenu(closestPlayer)
				  TriggerEvent('esx_policejob:playAnim', 'anim@gangops@facility@servers@bodysearch@', 'player_search')
			  end
		  end	
		  if CurrentAction ~= nil then
			  ESX.ShowHelpNotification(CurrentActionMsg)
  
			  if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' then
				  
				  if CurrentAction == 'menu_cloakroom' then
					  OpenCloakroomMenu()
				  elseif CurrentAction == 'menu_armory' then
					  if Config.MaxInService2 == -1 then
						  OpenArmoryMenu(CurrentActionData.station)
					  elseif CurrentAction == 'delete_vehicle' then
						  local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
						  TriggerServerEvent('esx_society:putVehicleInGarage', 'sheriff', vehicleProps)
					  elseif playerInService then
						  OpenArmoryMenu(CurrentActionData.station)
					  else
						  exports['mythic_notify']:DoCustomHudText('inform', 'Nie rozpoczynasz służby! Najpierw musisz się przebrać', 3000)
						  --ESX.ShowNotification(_U('service_not'))
					  end
				  elseif CurrentAction == 'menu_vehicle_spawner' then
					  if Config.MaxInService2 == -1 then
						  OpenVehicleSpawnerMenu('car', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum)
					  elseif playerInService then
						  OpenVehicleSpawnerMenu('car', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum)
					  else
						  exports['mythic_notify']:DoCustomHudText('inform', 'Nie rozpoczynasz służby! Najpierw musisz się przebrać', 3000)
						  --ESX.ShowNotification(_U('service_not'))
					  end
				  elseif CurrentAction == 'Helicopters' then
					  if Config.MaxInService2 == -1 then
						  OpenVehicleSpawnerMenu('helicopter', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum)
					  elseif playerInService then
						  OpenVehicleSpawnerMenu('helicopter', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum)
					  else
						  exports['mythic_notify']:DoCustomHudText('inform', 'Nie rozpoczynasz służby! Najpierw musisz się przebrać', 3000)
						  --ESX.ShowNotification(_U('service_not'))
					  end
				  elseif CurrentAction == 'menu_boss_actions' then
					  ESX.UI.Menu.CloseAll()
					  TriggerEvent('esx_society:openBossMenu', 'sheriff', function(data, menu)
						  menu.close()
  
						  CurrentAction     = 'menu_boss_actions'
						  CurrentActionMsg  = _U('open_bossmenu')
						  CurrentActionData = {}
					  end, { wash = false }) -- disable washing money
				  elseif CurrentAction == 'remove_entity' then
					  DeleteEntity(CurrentActionData.entity)
				  end
				  
				  CurrentAction = nil
			  end
		  end -- CurrentAction end
		  
		  if IsControlJustReleased(0, Keys['F6']) and not isDead and PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'police_actions') then
			  if Config.MaxInService2 == -1 then
				  OpenPoliceActionsMenu()
			  elseif playerInService then
				  OpenPoliceActionsMenu()
			  else
				  exports['mythic_notify']:DoCustomHudText('inform', 'Nie rozpoczynasz służby! Najpierw musisz się przebrać', 3000)
				  --ESX.ShowNotification(_U('service_not'))
			  end
		  end
		  
		  if IsControlJustReleased(0, Keys['E']) and CurrentTask.Busy then
			  exports['mythic_notify']:DoCustomHudText('inform', 'Unieważniasz zajęcie', 3000)
			  --ESX.ShowNotification(_U('impound_canceled'))
			  ESX.ClearTimeout(CurrentTask.Task)
			  ClearPedTasks(PlayerPedId())
			  
			  CurrentTask.Busy = false
		  end
	  end
  end)
  
  Citizen.CreateThread(function()
	  while true do
		  Citizen.Wait(500)
		  searchPedDelay = searchPedDelay - 1
		  local handle, pedd = FindFirstPed()
		  local success
		  repeat
			  success, pedd = FindNextPed(handle)
			  local pos = GetEntityCoords(pedd)
			  local playerloc = GetEntityCoords(PlayerPedId())
			  local distanceToPed = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, playerloc.x, playerloc.y, playerloc.z, true)
			  if DoesEntityExist(pedd) and not IsPedDeadOrDying(pedd) and not IsPedInAnyVehicle(pedd) and GetPedType(pedd) ~= 28 and not IsPedDeadOrDying(PlayerPedId()) and not IsPedInAnyVehicle(PlayerPedId()) and distanceToPed <= 3.5 and pedd ~= PlayerPedId() and pedd ~= oldped and not IsPedAPlayer(pedd) and pedd ~= -1 and pedd ~= PlayerPedId() then
				  if distanceToPed <= 3.5 then
					  closestNpc = pedd
				  else
					  closestNpc = nil
				  end
			  end
		  until not success
		  EndFindPed(handle)	
	  end
  end)
  
  -- Create blip for colleagues
  function createBlip(id, data)
	  local ped = GetPlayerPed(id)
	  local blip = GetBlipFromEntity(ped)
	  if not DoesBlipExist(blip) then -- Add blip and create head display on player
		  blip = AddBlipForEntity(ped)
		  SetBlipSprite(blip, 1)
		  ShowHeadingIndicatorOnBlip(blip, true) -- Player Blip indicator
		  SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
		  SetBlipColour(blip, data.color)
		  BeginTextCommandSetBlipName("STRING")
		  AddTextComponentString(data.name)
		  EndTextCommandSetBlipName(blip)
		  SetBlipScale(blip, 1.0) -- set scale
		  SetBlipAsShortRange(blip, false)
		  
		  table.insert(blipsCops, blip) -- add blip to array so we can remove it later
	  end
  end
  
  Citizen.CreateThread(function()
	  local playerPed
	  local targetPed
  
	  while true do
		  Citizen.Wait(10)
  
		  if IsHandcuffed then
			  playerPed = PlayerPedId()
  
			  if DragStatus.IsDragged then
				  targetPed = GetPlayerPed(GetPlayerFromServerId(DragStatus.CopId))
  
				  -- undrag if target is in an vehicle
				  if IsPedSittingInAnyVehicle(targetPed) then
					  if IsPedDeadOrDying(playerPed, true) then
						  AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
					  else
						  DragStatus.IsDragged = false
						  DetachEntity(playerPed, true, false)
					  end
				  else
					  AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
				  end
  
				  if IsPedDeadOrDying(targetPed, true) then
					  DragStatus.IsDragged = false
					  DetachEntity(playerPed, true, false)
				  end
  
			  else
				  DetachEntity(playerPed, true, false)
			  end
		  else
			  Citizen.Wait(500)
		  end
	  end
  end)
  
  local pp = {}
  RegisterNetEvent('srp_sheriffjob:getOnlinePlayers')
  AddEventHandler('srp_sheriffjob:getOnlinePlayers', function(players)
	  pp = players
  end)
  
  --[[RegisterNetEvent('srp_sheriffjob:updateBlip')
  AddEventHandler('srp_sheriffjob:updateBlip', function()
	  TriggerEvent('srp_sheriffjob:getOnlinePlayers')
	  Wait(1000)
	  local players = pp
	  
	  -- Refresh all blips
	  for k, existingBlip in pairs(blipsCops) do
		  RemoveBlip(existingBlip)
	  end
	  
	  -- Clean the blip table
	  blipsCops = {}
  
	  -- Enable blip?
	  if Config.MaxInService ~= -1 and not playerInService then
		  return
	  end
  
	  if not Config.EnableJobBlip then
		  return
	  end
	  local data = {}
	  -- Is the player a cop? In that case show all the blips for other cops
	  if PlayerData.job ~= nil and PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' then
		  ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)
			  for i=1, #players, 1 do
				  if players[i].job.name == 'police' or players[i].job.name == 'ambulance' then
					  local id = GetPlayerFromServerId(players[i].source)
					  if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() and GetPlayerName(id) == players[i].name then
						  local jobb = players[i].job.name
						  if PlayerData.job.name == 'police' then
							  data = {
								  name = 'Funkcjonariusz - ' .. players[i].firstname .. ' ' .. players[i].lastname,
								  job = 'police',
								  color = 3
							  }
						  elseif PlayerData.job.name == 'ambulance' then
							  data = {
								  name = 'Medyk - ' .. players[i].firstname .. ' ' .. players[i].lastname,
								  job = 'ambulance',
								  color = 1
							  }
						  end
						  createBlip(id, data)
					  end
				  end
			  end
		  end)
	  end
  end)]]
  
  AddEventHandler('playerSpawned', function(spawn)
	  isDead = false
	  -- TriggerEvent('srp_sheriffjob:unrestrain')
	  
	  if not hasAlreadyJoined then
		  TriggerServerEvent('srp_sheriffjob:spawned')
	  end
	  hasAlreadyJoined = true
  end)
  
  AddEventHandler('esx:onPlayerDeath', function(data)
	  isDead = true
  end)
  
  AddEventHandler('onResourceStop', function(resource)
	  if resource == GetCurrentResourceName() then
		  TriggerEvent('srp_sheriffjob:unrestrain')
		  TriggerEvent('esx_phone:removeSpecialContact', 'sheriff')
  
		  if Config.MaxInService2 ~= -1 then
			  TriggerServerEvent('esx_service:disableService', 'sheriff')
		  end
  
		  if Config.EnableHandcuffTimer2 and HandcuffTimer2.Active then
			  ESX.ClearTimeout(HandcuffTimer2.Task)
		  end
	  end
  end)
  
  function StartHandcuffTimer2()
	  if Config.EnableHandcuffTimer2 and HandcuffTimer2.Active then
		  ESX.ClearTimeout(HandcuffTimer2.Task)
	  end
  
	  HandcuffTimer2.Active = true
  
	  HandcuffTimer2.Task = ESX.SetTimeout(Config.HandcuffTimer2, function()
		  exports['mythic_notify']:DoCustomHudText('inform', 'Czujesz, że twoje kajdanki powoli tracą przyczepność i znikają.', 3000)
		  --ESX.ShowNotification(_U('unrestrained_timer'))
		  TriggerEvent('srp_sheriffjob:unrestrain')
		  HandcuffTimer2.Active = false
	  end)
  end
  
  function ImpoundVehicle(vehicle)
	  --local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
	  ESX.Game.DeleteVehicle(vehicle) 
	  exports['mythic_notify']:DoCustomHudText('inform', 'Zajmujesz pojazd', 3000)
	  --ESX.ShowNotification(_U('impound_successful'))
	  CurrentTask.Busy = false
  end
  
  
  -- ADDONS
  local dragPed = false
  local handcuffPed = false
  local inVehiclePed = false
  local targetPed = nil
  local copDrag = nil
  Citizen.CreateThread(function()
	  while true do
		  Citizen.Wait(10)
		  if copDrag == GetPlayerServerId(PlayerId()) and dragPed and not IsPedSittingInAnyVehicle(targetPed) then
			  local coords = GetEntityCoords(PlayerPedId())
			  SetEntityCoords(targetPed, coords.x, coords.y + 1.0, coords.z - 1.0, 1, 0, 0, 1)
		  else
			  Wait(500)
		  end
	  end
  end)
  
  Citizen.CreateThread(function()
	  while true do
		  Citizen.Wait(1)
		  if handcuffPed then
			  if inVehiclePed then
				  dragPed = false
				  if not IsEntityPlayingAnim(targetPed, 'amb@world_vehicle_police_caridle_a', 'idle_a', 3) then
					  RequestAnimDict('amb@world_vehicle_police_caridle_a')
					  while not HasAnimDictLoaded('amb@world_vehicle_police_caridle_a') do
						  Wait(1)
					  end
					  TaskPlayAnim(targetPed, 'amb@world_vehicle_police_caridle_a', 'idle_a', 8.0, -8, -1, 15, 0, 0, 0, 0)
				  end
			  else
				  if not IsEntityPlayingAnim(targetPed, 'mp_arresting', "idle", 3) then
					  RequestAnimDict('mp_arresting')
					  while not HasAnimDictLoaded('mp_arresting') do
						  Wait(1)
					  end
					  TaskPlayAnim(targetPed, 'mp_arresting', 'idle', 8.0, -8, -1, 15, 0, 0, 0, 0)
				  end
			  end
		  else
			  Citizen.Wait(500)
		  end
	  end
  end)
  
  RegisterNetEvent('srp_sheriffjob:playAnimPed')
  AddEventHandler('srp_sheriffjob:playAnimPed', function(dict, anim, ped)
	  ped = NetToPed(ped)
	  targetPed = ped
	  RequestAnimDict(dict)
	  while not HasAnimDictLoaded(dict) do
		  Citizen.Wait(1)
	  end
	  TaskPlayAnim(ped, dict, anim, 1.0, -1.0, 20000, 0, 1, true, true, true)
  end)
  
  RegisterNetEvent('srp_sheriffjob:dragPed')
  AddEventHandler('srp_sheriffjob:dragPed', function(ped, id)
	  ped = NetToPed(ped)
	  targetPed = ped
	  if IsEntityPlayingAnim(targetPed, 'mp_arresting', "idle", 3) then
		  dragPed = not dragPed
		  copDrag = id
	  end
  end)
  
  
  RegisterNetEvent('srp_sheriffjob:putInVehiclePed')
  AddEventHandler('srp_sheriffjob:putInVehiclePed', function(ped)
	  ped = NetToPed(ped)
	  targetPed = ped
	  local coords = GetEntityCoords(ped)
	  if IsAnyVehicleNearPoint(coords, 5.0) then
		  local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)
		  if DoesEntityExist(vehicle) then
			  local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)
			  for i=maxSeats - 1, 0, -1 do
				  if IsVehicleSeatFree(vehicle, i) then
					  freeSeat = i
					  break
				  end
			  end
			  if freeSeat then
				  TaskWarpPedIntoVehicle(ped, vehicle, freeSeat)
				  dragPed = false
				  inVehiclePed = true
			  end
		  end
	  end
  end)
  
  --[[
  RegisterNetEvent('srp_sheriffjob:OutVehiclePed')
  AddEventHandler('srp_sheriffjob:OutVehiclePed', function(ped)
	  ped = NetToPed(ped)
	  targetPed = ped
	  if not IsPedSittingInAnyVehicle(ped) then
		  return
	  end
	  local vehicle = GetVehiclePedIsIn(ped, false)
	  inVehiclePed = false
	  TaskLeaveVehicle(ped, vehicle, 16)
	  TriggerServerEvent('esx_policejob:handcuffPed', PedToNet(ped))
	  TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, 'Cuff', 0.1)
  end)
  
  RegisterNetEvent('esx_policejob:handcuffPed')
  AddEventHandler('esx_policejob:handcuffPed', function(ped)
	  ped = NetToPed(ped)
	  targetPed = ped
	  if IsEntityPlayingAnim(targetPed, 'mp_arresting', "idle", 3) then
		  Wait(4000)
		  handcuffPed = false
	  else
		  handcuffPed = true
	  end
	  if handcuffPed then
		  RequestAnimDict('mp_arresting')
		  while not HasAnimDictLoaded('mp_arresting') do
			  Citizen.Wait(1)
		  end
		  TaskPlayAnim(targetPed, 'mp_arresting', 'idle', 8.0, -8, -1, 0, 0, 0, 0, 0)
		  SetEnableHandcuffs(targetPed, true)
		  DisablePlayerFiring(targetPed, true)
		  SetCurrentPedWeapon(targetPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
		  SetPedCanPlayGestureAnims(targetPed, false)
	  else
		  ClearPedSecondaryTask(targetPed)
		  SetEnableHandcuffs(targetPed, false)
		  DisablePlayerFiring(targetPed, false)
		  SetPedCanPlayGestureAnims(targetPed, true)
	  end
  end)
  
  RegisterNetEvent('srp_sheriffjob:openHandcuffsMenu')
  AddEventHandler('srp_sheriffjob:openHandcuffsMenu', function()
	  OpenHandcuffsMenu()
  end)
  ]]
  
  RegisterNetEvent('srp_sheriffjob:playAnim')
  AddEventHandler('srp_sheriffjob:playAnim', function(dict, anim)
	  RequestAnimDict(dict)
	  while not HasAnimDictLoaded(dict) do
		  Citizen.Wait(1)
	  end
	  TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, -8.0, 20000, 48, 0, false, false, false)
  end)
  

  function OpenHandcuffsMenu()
	  ESX.UI.Menu.CloseAll()
	  local elements = {
		  {label = _U('search'),			value = 'body_search'},
		  {label = _U('handcuff'),		value = 'handcuff'},
		  {label = _U('drag'),			value = 'drag'},
		  {label = _U('put_in_vehicle'),	value = 'put_in_vehicle'},
		  {label = _U('out_the_vehicle'),	value = 'out_the_vehicle'},
		  {label = 'Sprawdź ID', 			value = 'check_id'}
	  }
  
	  ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'citizen_interaction',
	  {
		  title    = _U('citizen_interaction'),
		  align    = 'top-left',
		  elements = elements
	  }, function(data2, menu2)
		  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		  local action = data2.current.value
		  local pos = GetEntityCoords(closestNpc)
		  local playerloc = GetEntityCoords(PlayerPedId())
		  local distanceToPed = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, playerloc.x, playerloc.y, playerloc.z, true)
		  if closestPlayer ~= -1 and closestDistance <= 3.0 then
			  if action == 'body_search' then
				  TriggerServerEvent('srp_sheriffjob:message', GetPlayerServerId(closestPlayer), _U('being_searched2'))
				  OpenBodySearchMenu(closestPlayer)
				  TriggerEvent('srp_sheriffjob:playAnim', 'anim@gangops@facility@servers@bodysearch@', 'player_search')
			  elseif action == 'handcuff' then
				  TriggerServerEvent('esx_policejob:handcuff', GetPlayerServerId(closestPlayer))
				  TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, 'Cuff', 0.1)
				  PlayerData = ESX.GetPlayerData()
				  local org = PlayerData.job.name
				  TriggerServerEvent('srp_logs:handcuffLog',org, GetPlayerServerId(closestPlayer))
			  elseif action == 'drag' then
				  TriggerServerEvent('srp_sheriffjob:drag', GetPlayerServerId(closestPlayer))
			  elseif action == 'put_in_vehicle' then
				  TriggerServerEvent('srp_sheriffjob:putInVehicle', GetPlayerServerId(closestPlayer))
			  elseif action == 'out_the_vehicle' then
				  TriggerServerEvent('srp_sheriffjob:OutVehicle', GetPlayerServerId(closestPlayer))
			  elseif action == 'license' then
				  ShowPlayerLicense(closestPlayer)
			  elseif data2.current.value == 'check_id' then
				  TriggerServerEvent('showid:ShowIdPolice', GetPlayerServerId(closestPlayer))
			  elseif data2.current.value == 'check_for_gunpowder' then
				  TriggerServerEvent('gunshot:check', GetPlayerServerId(player))
			  end
		  elseif closestNpc ~= nil and distanceToPed < 3.5 then
			  if action == 'body_search' then
				  TriggerEvent('srp_sheriffjob:playAnim', 'anim@gangops@facility@servers@bodysearch@', 'player_search')
				  if searchPedDelay < 0 then
					  exports['mythic_notify']:DoCustomHudText('inform', 'Przeszukujesz osobę', 3000)
					  --ESX.ShowNotification('~y~Przeszukujesz osobę')
					  TriggerServerEvent('srp_sheriffjob:bodySearchPed')
					  searchPedDelay = 500
				  else
					  exports['mythic_notify']:DoCustomHudText('inform', 'Ta osoba nic przy sobie nie miała', 3000)
					  --ESX.ShowNotification('~y~Ta osoba nic przy sobie nie miała')
				  end
			  elseif action == 'handcuff' then
				  PlayerData = ESX.GetPlayerData()
				  local org = PlayerData.job.name					
				  TriggerServerEvent('srp_logs:handcuffLog',org,500)
				  TriggerServerEvent('esx_policejob:handcuffPed', PedToNet(closestNpc))
				  TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'handcuff', 0.4)
			  elseif action == 'drag' then
				  TriggerServerEvent('srp_sheriffjob:dragPed', PedToNet(closestNpc))
			  elseif action == 'put_in_vehicle' then
				  TriggerServerEvent('srp_sheriffjob:putInVehiclePed', PedToNet(closestNpc))
			  elseif action == 'out_the_vehicle' then
				  TriggerServerEvent('srp_sheriffjob:OutVehiclePed',PedToNet(closestNpc))
			  elseif action == 'license' then
				  exports['mythic_notify']:DoCustomHudText('inform', 'Ta osoba nie ma przy sobie żadnych licencji', 3000)
				  --ESX.ShowNotification('~r~Ta osoba nie ma przy sobie żadnych licencji')
			  elseif data2.current.value == 'check_id' then
				  exports['mythic_notify']:DoCustomHudText('inform', 'Ta osoba nie ma przy sobie dokumentów', 3000)
				  --ESX.ShowNotification('~r~Ta osoba nie ma przy sobie dokumentów')
			  elseif data2.current.value == 'check_for_gunpowder' then
				  exports['mythic_notify']:DoCustomHudText('inform', 'Ta osoba ma czyste ręce', 3000)
				  --ESX.ShowNotification('~r~Ta osoba ma czyste ręce')
			  end
		  else
			  exports['mythic_notify']:DoCustomHudText('inform', 'Brak graczy w pobliżu', 3000)
			  --ESX.ShowNotification(_U('no_players_nearby'))
		  end
	  end, function(data2, menu2)
		  menu2.close()
	  end)
  end
  
  RegisterNUICallback('sendData', function(data, cb)
	  
	  local sentence = data.charge
	  local sentenced = data.playerId
	  local sentencespan
	  if data.jailTime == 0 or data.jailTime == nil or data.jailTime == '0' or data.jailTime == '' or data.jailTime == null then
		  TriggerServerEvent('esx_policejob:pay', data.money, data.playerId, data.charge, true)
		  sentencespan = 0
	  else
		  sentencespan = data.jailTime
		  TriggerServerEvent("esx_jail:sendToJail", data.playerId, tonumber(data.jailTime * 60) )
		  TriggerServerEvent('esx_policejob:pay', data.money, data.playerId, false)
		  TriggerServerEvent('esx_policejob:unrestrain', data.playerId)
	  end
	  
	  TriggerEvent('zrider:pass_jailData',sentence,sentenced,sentencespan)
	  SendNUIMessage({type = 'hide'})
	  SetNuiFocus(false, false)
  end)
  
  RegisterNUICallback('exit', function(data, cb)
	  SendNUIMessage({type = 'hide'})
	  SetNuiFocus(false, false)
  end)
  
  
  --[[RegisterCommand("ulecz",function(source, args)
	  if  PlayerData.job ~= nil and (PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'sheriff') then
		  TriggerServerEvent('esx_ambulancejob:revive', args[1])
	  end
  end, false)]]
  
  RegisterNetEvent('esx_phone:loaded')
  AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	  local specialContact = {
		  name       = 'Telefon Alarmowy',
		  number     = 'sheriff',
		  base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyJpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoV2luZG93cykiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NDFGQTJDRkI0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6NDFGQTJDRkM0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDo0MUZBMkNGOTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDo0MUZBMkNGQTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PoW66EYAAAjGSURBVHjapJcLcFTVGcd/u3cfSXaTLEk2j80TCI8ECI9ABCyoiBqhBVQqVG2ppVKBQqUVgUl5OU7HKqNOHUHU0oHamZZWoGkVS6cWAR2JPJuAQBPy2ISEvLN57+v2u2E33e4k6Ngz85+9d++95/zP9/h/39GpqsqiRYsIGz8QZAq28/8PRfC+4HT4fMXFxeiH+GC54NeCbYLLATLpYe/ECx4VnBTsF0wWhM6lXY8VbBE0Ch4IzLcpfDFD2P1TgrdC7nMCZLRxQ9AkiAkQCn77DcH3BC2COoFRkCSIG2JzLwqiQi0RSmCD4JXbmNKh0+kc/X19tLtc9Ll9sk9ZS1yoU71YIk3xsbEx8QaDEc2ttxmaJSKC1ggSKBK8MKwTFQVXRzs3WzpJGjmZgvxcMpMtWIwqsjztvSrlzjYul56jp+46qSmJmMwR+P3+4aZ8TtCprRkk0DvUW7JjmV6lsqoKW/pU1q9YQOE4Nxkx4ladE7zd8ivuVmJQfXZKW5dx5EwPRw4fxNx2g5SUVLw+33AkzoRaQDP9SkFu6OKqz0uF8yaz7vsOL6ycQVLkcSg/BlWNsjuFoKE1knqDSl5aNnmPLmThrE0UvXqQqvJPyMrMGorEHwQfEha57/3P7mXS684GFjy8kreLppPUuBXfyd/ibeoS2kb0mWPANhJdYjb61AxUvx5PdT3+4y+Tb3mTd19ZSebE+VTXVGNQlHAC7w4VhH8TbA36vKq6ilnzlvPSunHw6Trc7XpZ14AyfgYeyz18crGN1Alz6e3qwNNQSv4dZox1h/BW9+O7eIaEsVv41Y4XeHJDG83Nl4mLTwzGhJYtx0PzNTjOB9KMTlc7Nkcem39YAGU7cbeBKVLMPGMVf296nMd2VbBq1wmizHoqqm/wrS1/Zf0+N19YN2PIu1fcIda4Vk66Zx/rVi+jo9eIX9wZGGcFXUMR6BHUa76/2ezioYcXMtpyAl91DSaTfDxlJbtLprHm2ecpObqPuTPzSNV9yKz4a4zJSuLo71/j8Q17ON69EmXiPIlNMe6FoyzOqWPW/MU03Lw5EFcyKghTrNDh7+/vw545mcJcWbTiGKpRdGPMXbx90sGmDaux6sXk+kimjU+BjnMkx3kYP34cXrFuZ+3nrHi6iDMt92JITcPjk3R3naRwZhpuNSqoD93DKaFVU7j2dhcF8+YzNlpErbIBTVh8toVccbaysPB+4pMcuPw25kwSsau7BIlmHpy3guaOPtISYyi/UkaJM5Lpc5agq5Xkcl6gIHkmqaMn0dtylcjIyPThCNyhaXyfR2W0I1our0v6qBii07ih5rDtGSOxNVdk1y4R2SR8jR/g7hQD9l1jUeY/WLJB5m39AlZN4GZyIQ1fFJNsEgt0duBIc5GRkcZF53mNwIzhXPDgQPoZIkiMkbTxtstDMVnmFA4cOsbz2/aKjSQjev4Mp9ZAg+hIpFhB3EH5Yal16+X+Kq3dGfxkzRY+KauBjBzREvGN0kNCTARu94AejBLMHorAQ7cEQMGs2cXvkWshYLDi6e9l728O8P1XW6hKeB2yv42q18tjj+iFTGoSi+X9jJM9RTxS9E+OHT0krhNiZqlbqraoT7RAU5bBGrEknEBhgJks7KXbLS8qERI0ErVqF/Y4K6NHZfLZB+/wzJvncacvFd91oXO3o/O40MfZKJOKu/rne+mRQByXM4lYreb1tUnkizVVA/0SpfpbWaCNBeEE5gb/UH19NLqEgDF+oNDQWcn41Cj0EXFEWqzkOIyYekslFkThsvMxpIyE2hIc6lXGZ6cPyK7Nnk5OipixRdxgUESAYmhq68VsGgy5CYKCUAJTg0+izApXne3CJFmUTwg4L3FProFxU+6krqmXu3MskkhSD2av41jLdzlnfFrSdCZxyqfMnppN6ZUa7pwt0h3fiK9DCt4IO9e7YqisvI7VYgmNv7mhBKKD/9psNi5dOMv5ZjukjsLdr0ffWsyTi6eSlfcA+dmiVyOXs+/sHNZu3M6PdxzgVO9GmDSHsSNqmTz/R6y6Xxqma4fwaS5Mn85n1ZE0Vl3CHBER3lUNEhiURpPJRFdTOcVnpUJnPIhR7cZXfoH5UYc5+E4RzRH3sfSnl9m2dSMjE+Tz9msse+o5dr7UwcQ5T3HwlWUkNuzG3dKFSTbsNs7m/Y8vExOlC29UWkMJlAxKoRQMR3IC7x85zOn6fHS50+U/2Untx2R1voinu5no+DQmz7yPXmMKZnsu0wrm0Oe3YhOVHdm8A09dBQYhTv4T7C+xUPrZh8Qn2MMr4qcDSRfoirWgKAvtgOpv1JI8Zi77X15G7L+fxeOUOiUFxZiULD5fSlNzNM62W+k1yq5gjajGX/ZHvOIyxd+Fkj+P092rWP/si0Qr7VisMaEWuCiYonXFwbAUTWWPYLV245NITnGkUXnpI9butLJn2y6iba+hlp7C09qBcvoN7FYL9mhxo1/y/LoEXK8Pv6qIC8WbBY/xr9YlPLf9dZT+OqKTUwfmDBm/GOw7ws4FWpuUP2gJEZvKqmocuXPZuWYJMzKuSsH+SNwh3bo0p6hao6HeEqwYEZ2M6aKWd3PwTCy7du/D0F1DsmzE6/WGLr5LsDF4LggnYBacCOboQLHQ3FFfR58SR+HCR1iQH8ukhA5s5o5AYZMwUqOp74nl8xvRHDlRTsnxYpJsUjtsceHt2C8Fm0MPJrphTkZvBc4It9RKLOFx91Pf0Igu0k7W2MmkOewS2QYJUJVWVz9VNbXUVVwkyuAmKTFJayrDo/4Jwe/CT0aGYTrWVYEeUfsgXssMRcpyenraQJa0VX9O3ZU+Ma1fax4xGxUsUVFkOUbcama1hf+7+LmA9juHWshwmwOE1iMmCFYEzg1jtIm1BaxW6wCGGoFdewPfvyE4ertTiv4rHC73B855dwp2a23bbd4tC1hvhOCbX7b4VyUQKhxrtSOaYKngasizvwi0RmOS4O1QZf2yYfiaR+73AvhTQEVf+rpn9/8IMAChKDrDzfsdIQAAAABJRU5ErkJggg=='
	  }
  
	  TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
  end)
  
  AddEventHandler('esx_phone:cancelMessage', function(dispatchNumber)
	  if type(PlayerData.job.name) == 'string' and PlayerData.job.name == 'sheriff' and PlayerData.job.name == dispatchNumber then
		  if Config.MaxInService2 ~= -1 and not playerInService then
			  CancelEvent()
		  end
	  end
  end)