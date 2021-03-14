local showPlayerIds = false
local playerNamesDist = 15
local displayIDHeight = 1.5
local red = 255
local green = 255
local blue = 255

function DrawText3D(x,y,z, text) 
	if showPlayerIds then
		local onScreen,_x,_y=World3dToScreen2d(x,y,z)
		local px,py,pz=table.unpack(GetGameplayCamCoords())
		local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

		local scale = (1/dist)*4
		local fov = (1/GetGameplayCamFov())*100
		local scale = scale*fov
		
		if onScreen then
			SetTextScale(0.0*scale, 0.55*scale)
			SetTextFont(0)
			SetTextProportional(1)
			SetTextColour(red, green, blue, 150)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(2, 0, 0, 0, 200)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			SetTextCentre(1)
			AddTextComponentString(text)
			World3dToScreen2d(x,y,z, 0) --Added Here
			DrawText(_x,_y)
		end
	end
end

Citizen.CreateThread(function()
    while true do
		if IsControlJustPressed(1, 48) then
			showPlayerIds = true
		end
		if IsControlJustPressed(1, 73) then
			showPlayerIds = false
		end
        Citizen.Wait(10)
    end
end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(10)
		if showPlayerIds then
			for i=0,99 do
				N_0x31698aa80e0223f8(i)
			end
			for id = 0, 255 do
				if  NetworkIsPlayerActive(id) then
					ped = GetPlayerPed(id)
					blip = GetBlipFromEntity(ped) 
	 
					x1, y1, z1 = table.unpack( GetEntityCoords( GetPlayerPed( -1 ), true ) )
					x2, y2, z2 = table.unpack( GetEntityCoords( GetPlayerPed( id ), true ) )
					distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))

					if distance < playerNamesDist then
						if NetworkIsPlayerTalking(id) then
							red = 255
							green = 0
							blue = 0
							DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id))
						else
							red = 255
							green = 255
							blue = 255
							DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id))
						end
					end  
				end
			end
		else
			Citizen.Wait(200)
		end
	end
end)