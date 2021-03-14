Config              = {}
Config.DrawDistance = 100.0
Config.MaxDelivery	= 10
Config.TruckPrice	= 0
Config.Locale       = 'pl'
Config.BagPay       = 15

Config.Trucks = {
	"trash",
}

Config.Cloakroom = {
	CloakRoom = {
			Pos   = {x = -321.70, y = -1545.94, z = 30.08},
			Size  = {x = 1.5, y = 1.5, z = 1.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27
		},
}

Config.Zones = {
	VehicleSpawner = {
			Pos   = {x = -321.44, y = -1536.13, z = 26.90},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Color = {r = 0, g = 255, b = 255},
			Type  = 27
		},

	VehicleSpawnPoint = {
			Pos   = {x = -369.28, y = -1540.11, z = 26.79},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Type  = -1
		},
}
Config.DumpstersAvaialbe = {
	"prop_dumpster_01a",
	"prop_dumpster_02a",
	"prop_dumpster_02b",
	"prop_dumpster_3a",
	"prop_dumpster_4a",
	"prop_dumpster_4b",
	"prop_skip_01a",
	"prop_skip_02a",
	"prop_skip_06a",
	"prop_skip_05a",
	"prop_skip_03",
	"prop_skip_10a"
}


Config.Livraison = {
-------------------------------------------Los Santos
	-- fleeca --sprawdzone
	Delivery1LS = {
			Pos   = {x = 114.85, y = -1462.31, z = 28.50},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 100
		},
	-- strawberry - sprawdzone
	Delivery2LS = {
			Pos   = {x = -6.04, y = -1566.23, z = 28.50},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 150
		},
	-- Davis -- sprawdzone
	Delivery3LS = {
			Pos   = {x = -1.88, y = -1729.55, z = 28.60},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 170
		},
	-- PrincipalBank -- sprawdzone
	Delivery4LS = {
			Pos   = {x = 159.09, y = -1816.69, z = 27.01},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 140
		},
	-- route68e --sprawdzone
	Delivery5LS = {
			Pos   = {x = 358.94, y = -1805.07, z = 28.20},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 180
		},
	--strawberry za komendą -- sprawdzone
	Delivery6LS = {
			Pos   = {x = 481.36, y = -1274.82, z = 28.90},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 190
		},
	-- Przy melinie -- sprawdzane
	Delivery7LS = {
			Pos   = {x = 339.30, y = -1076.77, z = 28.90},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 200
		},
	--budowa -- sprawone
	Delivery8LS = {
			Pos   = {x = 25.74, y = -366.78, z = 38.70},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 130
		},
	-- Przy melinie -- sprawdzone
	Delivery9LS = {
			Pos   = {x = 342.78, y = -1036.47, z = 28.50},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 180
		},
	--Komenda LS - sprawdzone
	Delivery10LS = {
			Pos   = {x = 451.03, y = -933.74, z = 28.01},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 190
		},
------------------------------------------- 2nd Patrol 
	-- Palomino Noose HQ -- sprawdzone
	Delivery1BC = {
			Pos   = {x = -559.70, y = -707.26, z = 32.01},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 180
		},
	-- Sklep z ubraniami przy komendzie - sprawdzone
	Delivery2BC = {
			Pos   = {x = 165.48, y = -777.07, z = 30.90},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 5.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 170
		},
	-- Orchardville ave -- sprawdzone
	Delivery3BC = {
			Pos   = {x = 379.51, y = -903.31, z = 28.45},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 5.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 200
		},
	-- Za szpitalem -- sprawdzone
	Delivery4BC = {
			Pos   = {x = 443.96, y = -574.33, z = 27.30},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 120
		},

		-- Przy plaży -- sprawdzone
	Delivery5BC = {
		Pos   = {x = -1228.14, y = -1221.94, z = 6.30},
		Color = {r = 204, g = 204, b = 0},
		Size  = {x = 5.0, y = 5.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 27,
		Paye = 100
	},


	-- Fryzjer Hawick - sprawdzone
	Delivery6BC = {
			Pos   = {x = -27.57, y = -79.64, z = 58.70},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 130
		},
	-- Dutch London -- sprawdzone
	Delivery7BC = {
			Pos   = {x = -31.94, y = -93.43, z = 56.60},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 150
		},
	-- Autopia Pkwy -- sprawdzone
	Delivery8BC = {
			Pos   = {x = 283.10, y = -164.81, z = 59.50},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 130
		},
	-- parking przy Vinewood -- sprawdzone
	Delivery9BC = {
			Pos   = {x = 395.17, y = 289.40, z = 102.40},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 170
		},
	-- Exceptionalist Way -- sprawdzone
	Delivery10BC = {
			Pos   = {x = 219.75, y = 388.57, z = 106.25},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 200
		},
		-- Śmietnik przed komendą -- w trakcie robienia
--[[
	Delivery11BC = {
			Pos   = {x = TUX, y = TUY, z = TUZ},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 0
		},
]]	
	RetourCamion = {
			Pos   = {x = -317.07, y = -1539.65, z = 26.90},
			Color = {r = 0, g = 255, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 0, g = 255, b = 0},
			Type  = 27,
			Paye = 0
		},
	
	AnnulerMission = {
			Pos   = {x = -314.62, y = -1514.56, z = 26.90},
			Color = {r = 255, g = 0, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 255, g = 0, b = 0},
			Type  = 27,
			Paye = 0
		},
}
