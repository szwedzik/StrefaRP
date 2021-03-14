ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(5)

		TriggerEvent("esx:getSharedObject", function(library)
			ESX = library
		end)
    end

    if ESX.IsPlayerLoaded() then
		ESX.PlayerData = ESX.GetPlayerData()

		RefreshPed()
    end
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(response)
	ESX.PlayerData = response

	RefreshPed()
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(response)
	ESX.PlayerData["job"] = response
end)

Citizen.CreateThread(function()
	Citizen.Wait(100)

	while true do
		local sleepThread = 500

		if not Config.OnlyPolicemen or (Config.OnlyPolicemen and ESX.PlayerData["job"] and ESX.PlayerData["job"]["name"] == "police") then

			local ped = PlayerPedId()
			local pedCoords = GetEntityCoords(ped)

			local dstCheck = GetDistanceBetweenCoords(pedCoords, Config.Armory["x"], Config.Armory["y"], Config.Armory["z"], true)

			if dstCheck <= 5.0 then
				sleepThread = 5

				local text = "Zbrojownia"

				if dstCheck <= 0.5 then
					text = "[~g~E~s~] Zbrojownia"

					if IsControlJustPressed(0, 38) then
						OpenPoliceArmory()
					end
				end

				ESX.Game.Utils.DrawText3D(Config.Armory, text, 0.6)
			end
		end

		Citizen.Wait(sleepThread)
	end
end)

OpenPoliceArmory = function()
	PlaySoundFrontend(-1, 'BACK', 'HUD_AMMO_SHOP_SOUNDSET', false)

	local elements = {
		{ ["label"] = "Bronie", ["action"] = "weapon_storage" },
		{ ["label"] = "Wyjmij przedmiot", ["action"] = "get_item" },
		{ ["label"] = "Utylizuj", ["action"] = "put_stock" },
		{ ["label"] = "Dodatki do broni", ["action"] = "dodatki" }
	}

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "police_armory_menu",
		{
			title    = "Zbrojownia",
			align    = "center",
			elements = elements
		},
	function(data, menu)
		local action = data.current["action"]

		if action == "weapon_storage" then
			OpenWeaponStorage()
		elseif action == "get_item" then
			OpenGetItemMenu()
		elseif action == "put_stock" then
			OpenPutStocksMenu()
		elseif action == "dodatki" then
			OpenBuyWeaponsMenu()
		end	
	end, function(data, menu)
		PlaySoundFrontend(-1, 'BACK', 'HUD_AMMO_SHOP_SOUNDSET', false)

		menu.close()
	end, function(data, menu)
		PlaySoundFrontend(-1, 'NAV', 'HUD_AMMO_SHOP_SOUNDSET', false)
	end)
end

function OpenPutStocksMenu()
	ESX.TriggerServerCallback('esx_policejob:getPlayerInventory', function(inventory)
		local elements = {}
		local playerPed  = PlayerPedId()
		local weaponList = ESX.GetWeaponList()
	
		for i=1, #weaponList, 1 do
			local weaponHash = GetHashKey(weaponList[i].name)
			local weapon_for = weaponList[i]
			if HasPedGotWeapon(playerPed, weaponHash, false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
				table.insert(elements, {
					label = weapon_for.label,
					type = 'item_weapon',
					value = weapon_for.name,
					ammo = weapon_for.ammo
				})
			end
		end

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
			title    = "Zbrojownia",
			align    = "center",
			elements = elements
		}, 
		function(data, menu)
		local itemType = data.current.type
			if itemType == "item_standard" then
			
				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
					title = "ilość"
				}, function(data2, menu2)

					local count = tonumber(data2.value)

					if count == nil then
						ESX.ShowNotification("nieprawidłowa ilość")
					else
						menu2.close()
						menu.close()
						TriggerServerEvent('esx_policejob:putStockItems', data.current.value, count)

						Citizen.Wait(300)
						OpenPutStocksMenu()
					end
				end, function(data2, menu2)
					menu2.close()
				end)
			elseif itemType == "item_weapon" then
				local weaponHash = data.current.value
				menu.close()
				---TU WKLEIĆ NOWĄ ANIMKE

				local anim = nil 
				if weaponHash == string.upper("weapon_carbinerifle") or weaponHash == string.upper("weapon_pumpshotgun") then
					anim = "rifle"
				else
					anim = "pistol"
				end
				local Location = Config.Armory
				local PedLocation = Config.ArmoryPed
				local closestPed, closestPedDst = ESX.Game.GetClosestPed(PedLocation)
				
				

 		       if IsEntityPlayingAnim(closestPed, "mp_cop_armoury", "pistol_on_counter", 3) 
		        or IsEntityPlayingAnim(closestPed, "mp_cop_armoury", "rifle_on_counter", 3)
 		       or IsEntityPlayingAnim(closestPed, "mp_cop_armoury", "pistol_on_counter_cop", 3)
 		       or IsEntityPlayingAnim(closestPed, "mp_cop_armoury", "rifle_on_counter_cop", 3) then
					ESX.ShowNotification("Poczekaj na swoją kolej.")
					return
				end

				

  		      --PlayerPedId() --closestPed
				SetEntityCoords(closestPed, PedLocation["x"], PedLocation["y"], PedLocation["z"] - 0.985)
				SetEntityHeading(closestPed, PedLocation["h"])
		
				SetEntityCoords(PlayerPedId(), Location["x"], Location["y"], Location["z"] - 0.985)
				SetEntityHeading(PlayerPedId(), Location["h"])
        
				SetCurrentPedWeapon(closestPed, GetHashKey("weapon_unarmed"), true)
				--GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(weaponHash), 1, false, true)
				SetCurrentPedWeapon(PlayerPedId(), GetHashKey(weaponHash), true)
				local animLib = "mp_cop_armoury"

				LoadModels({ animLib })

				if DoesEntityExist(closestPed) and closestPedDst <= 5.0 then
					--TaskPlayAnim(closestPed, animLib,anim .."_on_counter", 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
					--Citizen.Wait(1400)
					------------------
					--TaskPlayAnim(PlayerPedId(), animLib,anim .."_on_counter_cop", 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
					--------------------
					TaskPlayAnimAdvanced(PlayerPedId(), animLib, anim .."_on_counter_cop", Location["x"], Location["y"], Location["z"], 0, 0, Location["h"], 1, 1, -1, 0, 0.270548515, 0, 0)
					--function Global.TaskPlayAnimAdvanced(ped, animDict, animName, posX, posY, posZ, rotX, rotY, rotZ, speed, speedMultiplier, duration, flag, animTime, p14, p15)
					--Citizen.Wait(2)
					--wartosc od ktorej zaczynam to 0.270548515
					--SetEntityAnimCurrentTime(PlayerPedId(), animLib, anim .."_on_counter_cop",tonumber(0.270548515))
					Citizen.Wait(2500)
					RemoveWeaponFromPed(GetPlayerPed(-1),GetHashKey(data.current.value))
					--Citizen.Wait(1)
					--SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_UNARMED"), true)
					--Citizen.Wait(10)
					--GiveWeaponToPed(closestPed, GetHashKey(weaponHash), 100, false, true)
					--SetCurrentPedWeapon(closestPed, GetHashKey(weaponHash), true)
			
					--Citizen.Wait(3100)
					--ClearPedTasks(closestPed)
					--TaskPlayAnim(closestPed, animLib, anim.."_on_counter_cop", 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
					--Citizen.Wait(1)
					--local jedno_wykonanie = true
					--local jedno_wykonanie_2 = true
					--local curr_anim_perc = 0.4
					--for i=1, 480, 1 do
					--	SetEntityAnimCurrentTime(closestPed, animLib, anim .."_on_counter_cop",tonumber(curr_anim_perc))
					--	local curr_anim_time = GetEntityAnimCurrentTime(closestPed, animLib, anim .."_on_counter_cop",tonumber)
					--	Citizen.Wait(1)
					--	curr_anim_perc = curr_anim_perc - 0.001529167
					--	if curr_anim_perc < 0.15 and jedno_wykonanie then
					--		SetCurrentPedWeapon(closestPed, GetHashKey("WEAPON_UNARMED"), true)
					--		jedno_wykonanie = false
					--		--StopAnimTask(closestPed, animLib, "rifle_on_counter_cop",1.0)
					--	end
				--
					---	if curr_anim_perc < 0.01 and jedno_wykonanie_2  then
					--		jedno_wykonanie_2 = false
					--		Citizen.Wait(1)
					--		StopAnimTask(closestPed, animLib,anim .. "_on_counter_cop",1)
					--		StopEntityAnim(closestPed, animLib,anim .. "_on_counter_cop",1)
					--		ClearPedTasksImmediately(closestPed)
					--	end
				--
					--end
				end

				UnloadModels()
				---KONIEC NOWEJ ANIMKI
				--SetCurrentPedWeapon(GetPlayerPed(-1),GetHashKey(data.current.value),true)
				--Citizen.Wait(900)
				
				local Player = ESX.GetPlayerData()
				local org = Player.job.name	
				local weapon_name = ESX.GetWeaponLabel(data.current.value)
				TriggerServerEvent('srp_logs:policeArmoryLog',org,weapon_name,0)
				OpenPutStocksMenu()				
			end

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
		title    = "Zbrojownia",
		align    = "center",
		elements = elements
	}, 
	function(data, menu)
		menu.close()
		local amount = 1
		if data.current.label == 'Woda' then
			amount = 10
		end
		TriggerServerEvent('esx_policejob:get_item', data.current.label, data.current.value, amount)
	end, function(data, menu)
		menu.close()
	end)
end

OpenWeaponStorage = function()
	PlaySoundFrontend(-1, 'BACK', 'HUD_AMMO_SHOP_SOUNDSET', false)

	local elements = {}

	local Location = Config.Armory
	local PedLocation = Config.ArmoryPed

	for i = 1, #Config.ArmoryWeapons, 1 do
		local weapon = Config.ArmoryWeapons[i]

		table.insert(elements, { ["label"] = ESX.GetWeaponLabel(weapon["hash"]), ["weapon"] = weapon })
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "police_armory_weapon_menu",
		{
			title    = "Zbrojownia",
			align    = "center",
			elements = elements
		},
	function(data, menu)
		local anim = data.current["weapon"]["type"]
		local weaponHash = data.current["weapon"]["hash"]

		ESX.UI.Menu.CloseAll()

		local closestPed, closestPedDst = ESX.Game.GetClosestPed(PedLocation)

		if (DoesEntityExist(closestPed) and closestPedDst >= 5.0) or IsPedAPlayer(closestPed) then
			RefreshPed(true) -- failsafe if the ped somehow dissapear.

			ESX.ShowNotification("Spróbuj ponownie.")

			return
		end

		if IsEntityPlayingAnim(closestPed, "mp_cop_armoury", "pistol_on_counter", 3) 
		or IsEntityPlayingAnim(closestPed, "mp_cop_armoury", "rifle_on_counter", 3)
		or IsEntityPlayingAnim(closestPed, "mp_cop_armoury", "pistol_on_counter_cop", 3)
		or IsEntityPlayingAnim(closestPed, "mp_cop_armoury", "rifle_on_counter_cop", 3) then
			ESX.ShowNotification("Poczekaj na swoją kolej.")
			return
		end

		if not NetworkHasControlOfEntity(closestPed) then
			NetworkRequestControlOfEntity(closestPed)

			Citizen.Wait(1000)
		end

		SetEntityCoords(closestPed, PedLocation["x"], PedLocation["y"], PedLocation["z"] - 0.985)
		SetEntityHeading(closestPed, PedLocation["h"])

		SetEntityCoords(PlayerPedId(), Location["x"], Location["y"], Location["z"] - 0.985)
		SetEntityHeading(PlayerPedId(), Location["h"])
		SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_unarmed"), true)

		local animLib = "mp_cop_armoury"

		LoadModels({ animLib })

		if DoesEntityExist(closestPed) and closestPedDst <= 5.0 then
			TaskPlayAnim(closestPed, animLib, anim .. "_on_counter_cop", 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)

			Citizen.Wait(1100)

			GiveWeaponToPed(closestPed, GetHashKey(weaponHash), 1, false, true)
			SetCurrentPedWeapon(closestPed, GetHashKey(weaponHash), true)

			TaskPlayAnim(PlayerPedId(), animLib, anim .. "_on_counter", 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)

			Citizen.Wait(3100)

			RemoveWeaponFromPed(closestPed, GetHashKey(weaponHash))

			Citizen.Wait(15)

			GiveWeaponToPed(PlayerPedId(), GetHashKey(weaponHash), Config.ReceiveAmmo, false, true)
			SetCurrentPedWeapon(PlayerPedId(), GetHashKey(weaponHash), true)

			ClearPedTasks(closestPed)

			TriggerServerEvent("qalle_policearmory:giveWeapon", weaponHash)
			local Player = ESX.GetPlayerData()
			local org = Player.job.name	
			local weapon_name = ESX.GetWeaponLabel(string.upper(weaponHash))
			TriggerServerEvent('srp_logs:policeArmoryLog',org,weapon_name,1)
		end

		UnloadModels()
	end, function(data, menu)
		PlaySoundFrontend(-1, 'BACK', 'HUD_AMMO_SHOP_SOUNDSET', false)

		menu.close()
	end, function(data, menu)
		PlaySoundFrontend(-1, 'NAV', 'HUD_AMMO_SHOP_SOUNDSET', false)
	end)
end

RefreshPed = function(spawn)
	local Location = Config.ArmoryPed

	ESX.TriggerServerCallback("qalle_policearmory:pedExists", function(Exists)
		if Exists and not spawn then
			return
		else
			LoadModels({ GetHashKey(Location["hash"]) })

			local pedId = CreatePed(5, Location["hash"], Location["x"], Location["y"], Location["z"] - 0.985, Location["h"], true)

			SetPedCombatAttributes(pedId, 46, true)                     
			SetPedFleeAttributes(pedId, 0, 0)                      
			SetBlockingOfNonTemporaryEvents(pedId, true)
			SetEntityAsMissionEntity(pedId, true, true)
			SetEntityInvincible(pedId, true)
			FreezeEntityPosition(pedId, true)
		end
	end)
end

local CachedModels = {}

LoadModels = function(models)
	for modelIndex = 1, #models do
		local model = models[modelIndex]

		table.insert(CachedModels, model)

		if IsModelValid(model) then
			while not HasModelLoaded(model) do
				RequestModel(model)
	
				Citizen.Wait(10)
			end
		else
			while not HasAnimDictLoaded(model) do
				RequestAnimDict(model)
	
				Citizen.Wait(10)
			end    
		end
	end
end

UnloadModels = function()
	for modelIndex = 1, #CachedModels do
		local model = CachedModels[modelIndex]

		if IsModelValid(model) then
			SetModelAsNoLongerNeeded(model)
		else
			RemoveAnimDict(model)   
		end

		table.remove(CachedModels, modelIndex)
	end
end

function OpenBuyWeaponsMenu()

	local elements = {}
	local playerPed = PlayerPedId()
	PlayerData = ESX.GetPlayerData()

	for k,v in ipairs(Config.ArmoryWeapons) do
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
			ESX.TriggerServerCallback('esx_policejob:buyWeapon', function(bought)
				if bought then
					SetPedWeaponTintIndex(PlayerPedId(), data.current.name, 5)
					if data.current.price > 0 then
						ESX.ShowNotification(_U('armory_bought', data.current.weaponLabel, ESX.Math.GroupDigits(data.current.price)))
					end

					menu.close()

					OpenWeaponStorage()
				else
					ESX.ShowNotification(_U('armory_money'))
				end
			end, data.current.name, 1)
		end

	end, function(data, menu)
		menu.close()
	end)

end


RegisterNetEvent('zrider:anim_test')
AddEventHandler('zrider:anim_test',function(weapon)
local AnimPedTest ={ ["x"] = 1387.97, ["y"] = -727.81, ["z"] = 67.19, ["h"] = 70.0, ["hash"] = "s_m_y_cop_01" }
local AnimTestWeaponHash = GetHashKey('weapon_carbinerifle')
local anim_test = 'rifle'
local Location = {["x"] = 1386.221539, ["y"] = -727.1736123, ["z"] = 67.19, ["h"] = 250.0 }

local closestPed, closestPedDst = ESX.Game.GetClosestPed(AnimPedTest)
		if (DoesEntityExist(closestPed) and closestPedDst >= 5.0) or IsPedAPlayer(closestPed) then
			PedRefresher(true) -- failsafe if the ped somehow dissapear.

			ESX.ShowNotification("Spróbuj ponownie.")

			return
		end

		if IsEntityPlayingAnim(closestPed, "mp_cop_armoury", "pistol_on_counter", 3) or IsEntityPlayingAnim(closestPed, "mp_cop_armoury", "rifle_on_counter", 3) then
			ESX.ShowNotification("Poczekaj na swoją kolej.")
			return
		end

		if not NetworkHasControlOfEntity(closestPed) then
			NetworkRequestControlOfEntity(closestPed)

			Citizen.Wait(1000)
		end

        --PlayerPedId() --closestPed
		SetEntityCoords(closestPed, AnimPedTest["x"], AnimPedTest["y"], AnimPedTest["z"] - 0.985)
		SetEntityHeading(closestPed, AnimPedTest["h"])
		
		SetEntityCoords(PlayerPedId(), Location["x"], Location["y"], Location["z"] - 0.985)
		SetEntityHeading(PlayerPedId(), Location["h"])
        
		SetCurrentPedWeapon(closestPed, GetHashKey("weapon_unarmed"), true)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), 1, false, true)
		SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), true)

		local animLib = "mp_cop_armoury"

		LoadModels({ animLib })

		if DoesEntityExist(closestPed) and closestPedDst <= 5.0 then
			TaskPlayAnim(closestPed, animLib, "rifle_on_counter", 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
			Citizen.Wait(1400)
			TaskPlayAnim(PlayerPedId(), animLib, "rifle_on_counter_cop", 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
			Citizen.Wait(2)
			--wartosc od ktorej zaczynam to 0.270548515
			SetEntityAnimCurrentTime(PlayerPedId(), animLib, "rifle_on_counter_cop",tonumber(0.270548515))
			Citizen.Wait(2500)
			SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_UNARMED"), true)
			Citizen.Wait(10)
			GiveWeaponToPed(closestPed, GetHashKey("WEAPON_CARBINERIFLE"), 100, false, true)
			SetCurrentPedWeapon(closestPed, GetHashKey("WEAPON_CARBINERIFLE"), true)
			
			Citizen.Wait(3100)
			ClearPedTasks(closestPed)
			TaskPlayAnim(closestPed, animLib, "rifle_on_counter_cop", 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
			Citizen.Wait(1)
			local jedno_wykonanie = true
			local jedno_wykonanie_2 = true
			local curr_anim_perc = 0.45
			for i=1, 480, 1 do
				SetEntityAnimCurrentTime(closestPed, animLib, "rifle_on_counter_cop",tonumber(curr_anim_perc))
				local curr_anim_time = GetEntityAnimCurrentTime(closestPed, animLib, "rifle_on_counter_cop",tonumber)
				Citizen.Trace('czas '..curr_anim_time)
				Citizen.Wait(1)
				curr_anim_perc = curr_anim_perc - 0.001529167
				if curr_anim_perc < 0.15 and jedno_wykonanie then
					SetCurrentPedWeapon(closestPed, GetHashKey("WEAPON_UNARMED"), true)
					jedno_wykonanie = false
					--StopAnimTask(closestPed, animLib, "rifle_on_counter_cop",1.0)
				end
				
				if curr_anim_perc < 0.01 and jedno_wykonanie_2  then
					jedno_wykonanie_2 = false
					Citizen.Trace("------------------ZATRZYMAJ--------------------")
					Citizen.Wait(1)
					StopAnimTask(closestPed, animLib, "rifle_on_counter_cop",1)
					StopEntityAnim(closestPed, animLib, "rifle_on_counter_cop",1)
					ClearPedTasksImmediately(closestPed)
				end
				
			end
		end

		UnloadModels()
	


end)

PedRefresher = function(spawn)
	local Location = { ["x"] = 1387.97, ["y"] = -727.81, ["z"] = 67.19, ["h"] = 70.0, ["hash"] = "s_m_y_cop_01" }

	ESX.TriggerServerCallback("zrider:testExist", function(Exists)
		if Exists and not spawn then
			return
		else
			LoadModels({ GetHashKey(Location["hash"]) })

			local pedId = CreatePed(5, Location["hash"], Location["x"], Location["y"], Location["z"] - 0.985, Location["h"], true)

			SetPedCombatAttributes(pedId, 46, true)                     
			SetPedFleeAttributes(pedId, 0, 0)                      
			SetBlockingOfNonTemporaryEvents(pedId, true)
			SetEntityAsMissionEntity(pedId, true, true)
			SetEntityInvincible(pedId, true)
			FreezeEntityPosition(pedId, true)
		end
	end)
end
