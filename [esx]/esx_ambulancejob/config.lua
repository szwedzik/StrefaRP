Config                            = {}

Config.DrawDistance               = 100.0

Config.Marker                     = { type = 27, x = 1.0, y = 1.0, z = 0.5, r = 0, g = 255, b = 0, a = 100, rotate = false }

Config.ReviveReward               = 0  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = true -- disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'pl'

local second = 1000
local minute = 60 * second

Config.EarlyRespawnTimer          = 10 * minute  -- Time til respawn is available
Config.BleedoutTimer              = 30 * minute -- Time til the player bleeds out

Config.EnablePlayerManagement     = true

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = false
Config.EarlyRespawnFineAmount     = 200

Config.RespawnPoint = { coords = vector3(358.07, -590.53, 28.79), heading = 250.50 }

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(299.5, -585.0, 43.2),
			sprite = 489,
			scale  = 1.5,
			color  = 1
		},

		Blip2 = {
			coords = vector3(1200.88, -1474.08, 34.86),
			sprite = 88,
			scale  = 1.0,
			color  = 1
		},

		AmbulanceActions = {
			{
				Spawner = vector3(335.44, -574.78, 42.33),
				Marker = { type = 27, x = 1.5, y = 1.5, z = 5.0, r = 0, g = 255, b = 0, a = 50, rotate = false }
			}
		},

		AmbulanceActionsDown = {
			{
				Spawner = vector3(335.89, -579.72, 27.80),
				Marker = { type = 27, x = 1.5, y = 1.5, z = 5.0, r = 0, g = 255, b = 0, a = 50, rotate = false }
			}
		},

		AmbulanceActionsS7 = {
			{
				Spawner = vector3(1209.07, -1480.81, 33.90),
				Marker = { type = 27, x = 1.0, y = 1.0, z = 5.0, r = 0, g = 255, b = 0, a = 50, rotate = false }
			}
		},

		BoatsActions = {
			{
				Spawner = vector3(-1183.87, -1774.28, 4.34),
				Marker = { type = 21, x = 1.0, y = 1.0, z = 1.0, r = 0, g = 255, b = 0, a = 50, rotate = true }
			}
		},

		Pharmacies = {
			{
				Spawner = vector3(326.69, -575.55, 42.32),
				Marker = { type = 27, x = 1.5, y = 1.5, z = 5.0, r = 100, g = 0, b = 255, a = 50, rotate = false }
			}
		},

		PharmaciesDown = {
			{
				Spawner = vector3(361.50, -570.58, 27.80),
				Marker = { type = 27, x = 1.5, y = 1.5, z = 5.0, r = 100, g = 0, b = 255, a = 50, rotate = false }
			}
		},

		PharmaciesS7 = {
			{
				Spawner = vector3(1194.66, -1479.12, 33.90),
				Marker = { type = 27, x = 1.0, y = 1.0, z = 5.0, r = 100, g = 0, b = 255, a = 50, rotate = false }
			}
		},

		ToolsS7 = {
			{
				Spawner = vector3(1207.18, -1478.38, 33.88),
				Marker = { type = 27, x = 1.0, y = 1.0, z = 5.0, r = 128, g = 0, b = 0, a = 50, rotate = false }
			}
		},

		DelHeli = {
			{
				Spawner = vector3(351.98, -588.12, 73.20),
				Marker = { type = 27, x = 10.5, y = 10.5, z = 5.0, r = 255, g = 0, b = 0, a = 50, rotate = false }
			}
		},

		DelVeh = {
			{
				Spawner = vector3(341.28, -559.67, 27.80),
				Marker = { type = 27, x = 2.5, y = 2.5, z = 5.0, r = 255, g = 0, b = 0, a = 50, rotate = false }
			}
		},

		DelVehS7 = {
			{
				Spawner = vector3(1228.97, -1465.25, 33.74),
				Marker = { type = 27, x = 2.5, y = 2.5, z = 5.0, r = 255, g = 0, b = 0, a = 50, rotate = false }
			}
		},

		Vehicles = {
			{
				Spawner = vector3(329.91, -556.91, 28.34),
				InsideShop = vector3(446.7, -1355.6, -200.5),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 0, g = 255, b = 0, a = 50, rotate = false },
				SpawnPoints = {
					{ coords = vector3(345.99, -556.48, 28.55), heading = 340, radius = 1.0 }
				}
			}
		},

		VehiclesS7 = {
			{
				Spawner = vector3(1191.63, -1474.54, 34.90),
				InsideShop = vector3(446.7, -1355.6, -200.5),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 0, g = 255, b = 0, a = 50, rotate = true },
				SpawnPoints = {
					{ coords = vector3(1204.80, -1468.60, 34.93), heading = 360, radius = 1.0 },
					{ coords = vector3(1200.66, -1468.60, 34.93), heading = 360, radius = 1.0 },
					{ coords = vector3(1196.65, -1468.60, 34.93), heading = 360, radius = 1.0 },
					{ coords = vector3(1196.65, -1479.67, 34.93), heading = 178, radius = 1.0 },
					{ coords = vector3(1200.66, -1479.67, 34.93), heading = 340, radius = 1.0 },
					{ coords = vector3(1204.80, -1479.67, 34.93), heading = 340, radius = 1.0 }
				}
			}
		},

		Boats = {
			{
				Spawner = vector3(-1178.97, -1781.27, 4.36), 
				InsideShop = vector3(446.7, -1355.6, -200.5),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 0, g = 255, b = 0, a = 50, rotate = true },
				SpawnPoints = {
					{ coords = vector3(-1152.23, -1838.89, 0.19), heading = 130, radius = 1.0 }
				}
			}
		},

		BoatsDel = {
			{
				Spawner = vector3(-1240.07, -1861.14, 1.13),
				Marker = { type = 27, x = 15.5, y = 15.5, z = 5.0, r = 255, g = 0, b = 0, a = 50, rotate = false }
			}
		},

		Helicopters = {
			{
				Spawner = vector3(340.88, -582.12, 73.76),
				InsideShop = vector3(305.6, -1419.7, 41.5),
				Marker = { type = 34, x = 1.0, y = 1.0, z = 1.0, r = 0, g = 255, b = 0, a = 50, rotate = true },
				SpawnPoints = {
					{ coords = vector3(352.14, -588.31, 73.76), heading = 68.0, radius = 10.0 }
				}
			}
		},
--[[
		FastTravels = {
			{
				From = vector3(294.7, -1448.1, 29.0),
				To = { coords = vector3(272.8, -1358.8, 23.5), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(275.3, -1361, 23.5),
				To = { coords = vector3(295.8, -1446.5, 28.9), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(247.3, -1371.5, 23.5),
				To = { coords = vector3(333.1, -1434.9, 45.5), heading = 138.6 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(335.5, -1432.0, 45.50),
				To = { coords = vector3(249.1, -1369.6, 23.5), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(234.5, -1373.7, 20.9),
				To = { coords = vector3(320.9, -1478.6, 28.8), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(317.9, -1476.1, 28.9),
				To = { coords = vector3(238.6, -1368.4, 23.5), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false }
			}
		},
]]
		FastTravelsPrompt = {
			{
				From = vector3(237.4, -1373.8, 26.0),
				To = { coords = vector3(251.9, -1363.3, 38.5), heading = 0.0 },
				Marker = { type = 27, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 50, rotate = false },
				Prompt = _U('fast_travel')
			},

			{
				From = vector3(256.5, -1357.7, 36.0),
				To = { coords = vector3(235.4, -1372.8, 26.3), heading = 0.0 },
				Marker = { type = 27, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 50, rotate = false },
				Prompt = _U('fast_travel')
			}
		}

	}
}

Config.AuthorizedVehicles = {

	ambulance = {
		{ model = 'ambulance', label = 'Ambulance Van', price = 5000}
	},

	doctor = {
		{ model = 'ambulance', label = 'Ambulance Van', price = 4500}
	},

	chief_doctor = {
		{ model = 'ambulance', label = 'Ambulance Van', price = 3000}
	},

	boss = {
		{ model = 'ambulance', label = 'Ambulance Van', price = 2000}
	}

}

Config.AuthorizedHelicopters = {

	ambulance = {},

	doctor = {
		{ model = 'buzzard2', label = 'Nagasaki Buzzard', price = 150000 }
	},

	chief_doctor = {
		{ model = 'buzzard2', label = 'Nagasaki Buzzard', price = 150000 },
		{ model = 'seasparrow', label = 'Sea Sparrow', price = 300000 }
	},

	boss = {
		{ model = 'buzzard2', label = 'Nagasaki Buzzard', price = 10000 },
		{ model = 'seasparrow', label = 'Sea Sparrow', price = 250000 }
	}

}

Config.Zones = {
VehicleSpawner = {
    Pos  = { x = 329.91, y = -556.91, z = 27.84 },
    Size = { x = 1.5, y = 1.5, z = 1.0 },
    Type = 27
  },

  VehicleSpawnPoint = {
    Pos  = { x = 345.99, y = -556.48, z = 28.55 },
	Size = { x = 1.5, y = 1.5, z = 1.0 },
    Type = -1
  },

  VehicleSpawnPointS7 = {
	Pos  = { x = 1200.71, y = -1493.60, z = 34.40 },
	Size = { x = 1.5, y = 1.5, z = 1.0 },
    Type = -1
  },

  BoatSpawnPoint = {
	  Pos = { x = -1152.3, y = -1839.21, z = 1.67 },
	  Size = { x = 1.5, y = 1.5, z = 1.0 },
	  Type = -1
  },

  HeliDeleter = {
    Pos  = { x = 358.03, y = -588.06, z = 73.26 },
    Size = { x = 3.0, y = 3.0, z = 1.0 },
    Type = 27
  },
  
  HelicopterSpawner = {
	  Pos  = { x = 352.03, y = -588.06, z = 73.26 },
	  Size = { x = 3.0, y = 3.0, z = 1.0 },
	  Type = 27
  }
}

Config.Weapons = {
	{ name = 'WEAPON_KNIFE', label = 'weapon_knife' },
	{ name = 'WEAPON_NIGHTSTICK', label = 'weapon_nightstick' },
	{ name = 'WEAPON_HAMMER', label = 'weapon_hammer' },
	{ name = 'WEAPON_BAT', label = 'weapon_bat' },
	{ name = 'WEAPON_GOLFCLUB', label = 'weapon_golfclub' },
	{ name = 'WEAPON_CROWBAR', label = 'weapon_crowbar' },
	{ name = 'WEAPON_PISTOL', label = 'weapon_pistol' },
	{ name = 'WEAPON_COMBATPISTOL', label = 'weapon_combatpistol' },
	{ name = 'WEAPON_APPISTOL', label = 'weapon_appistol' },
	{ name = 'WEAPON_PISTOL50', label = 'weapon_pistol50' },
	{ name = 'WEAPON_MICROSMG', label = 'weapon_microsmg' },
	{ name = 'WEAPON_SMG', label = 'weapon_smg' },
	{ name = 'WEAPON_ASSAULTSMG', label = 'weapon_assaultsmg' },
	{ name = 'WEAPON_ASSAULTRIFLE', label = 'weapon_assaultrifle' },
	{ name = 'WEAPON_CARBINERIFLE', label = 'weapon_carbinerifle' },
	{ name = 'WEAPON_ADVANCEDRIFLE', label = 'weapon_advancedrifle' },
	{ name = 'WEAPON_MG', label = 'weapon_mg' },
	{ name = 'WEAPON_COMBATMG', label = 'weapon_combatmg' },
	{ name = 'WEAPON_PUMPSHOTGUN', label = 'weapon_pumpshotgun' },
	{ name = 'WEAPON_SAWNOFFSHOTGUN', label = 'weapon_sawnoffshotgun' },
	{ name = 'WEAPON_ASSAULTSHOTGUN', label = 'weapon_assaultshotgun' },
	{ name = 'WEAPON_BULLPUPSHOTGUN', label = 'weapon_bullpupshotgun' },
	{ name = 'WEAPON_STUNGUN', label = 'weapon_stungun' },
	{ name = 'WEAPON_SNIPERRIFLE', label = 'weapon_sniperrifle' },
	{ name = 'WEAPON_HEAVYSNIPER', label = 'weapon_heavysniper' },
	{ name = 'WEAPON_REMOTESNIPER', label = 'weapon_remotesniper' },
	{ name = 'WEAPON_GRENADELAUNCHER', label = 'weapon_grenadelauncher' },
	{ name = 'WEAPON_RPG', label = 'weapon_rpg' },
	{ name = 'WEAPON_STINGER', label = 'weapon_stinger' },
	{ name = 'WEAPON_MINIGUN', label = 'weapon_minigun' },
	{ name = 'WEAPON_GRENADE', label = 'weapon_grenade' },
	{ name = 'WEAPON_STICKYBOMB', label = 'weapon_stickybomb' },
	{ name = 'WEAPON_SMOKEGRENADE', label = 'weapon_smokegrenade' },
	{ name = 'WEAPON_BZGAS', label = 'weapon_bzgas' },
	{ name = 'WEAPON_MOLOTOV', label = 'weapon_molotov' },
	{ name = 'WEAPON_FIREEXTINGUISHER', label = 'weapon_fireextinguisher' },
	{ name = 'WEAPON_PETROLCAN', label = 'weapon_petrolcan' },
	{ name = 'WEAPON_DIGISCANNER', label = 'weapon_digiscanner' },
	{ name = 'WEAPON_BALL', label = 'weapon_ball' },
	{ name = 'WEAPON_SNSPISTOL', label = 'weapon_snspistol' },
	{ name = 'WEAPON_BOTTLE', label = 'weapon_bottle' },
	{ name = 'WEAPON_GUSENBERG', label = 'weapon_gusenberg' },
	{ name = 'WEAPON_SPECIALCARBINE', label = 'weapon_specialcarbine' },
	{ name = 'WEAPON_HEAVYPISTOL', label = 'weapon_heavypistol' },
	{ name = 'WEAPON_BULLPUPRIFLE', label = 'weapon_bullpuprifle' },
	{ name = 'WEAPON_DAGGER', label = 'weapon_dagger' },
	{ name = 'WEAPON_VINTAGEPISTOL', label = 'weapon_vintagepistol' },
	{ name = 'WEAPON_FIREWORK', label = 'weapon_firework' },
	{ name = 'WEAPON_MUSKET', label = 'weapon_musket' },
	{ name = 'WEAPON_HEAVYSHOTGUN', label = 'weapon_heavyshotgun' },
	{ name = 'WEAPON_MARKSMANRIFLE', label = 'weapon_marksmanrifle' },
	{ name = 'WEAPON_HOMINGLAUNCHER', label = 'weapon_hominglauncher' },
	{ name = 'WEAPON_PROXMINE', label = 'weapon_proxmine' },
	{ name = 'WEAPON_SNOWBALL', label = 'weapon_snowball' },
	{ name = 'WEAPON_FLAREGUN', label = 'weapon_flaregun' },
	{ name = 'WEAPON_GARBAGEBAG', label = 'weapon_garbagebag' },
	{ name = 'WEAPON_HANDCUFFS', label = 'weapon_handcuffs' },
	{ name = 'WEAPON_COMBATPDW', label = 'weapon_combatpdw' },
	{ name = 'WEAPON_MARKSMANPISTOL', label = 'weapon_marksmanpistol' },
	{ name = 'WEAPON_KNUCKLE', label = 'weapon_knuckle' },
	{ name = 'WEAPON_HATCHET', label = 'weapon_hatchet' },
	{ name = 'WEAPON_RAILGUN', label = 'weapon_railgun' },
	{ name = 'WEAPON_MACHETE', label = 'weapon_machete' },
	{ name = 'WEAPON_MACHINEPISTOL', label = 'weapon_machinepistol' },
	{ name = 'WEAPON_SWITCHBLADE', label = 'weapon_switchblade' },
	{ name = 'WEAPON_REVOLVER', label = 'weapon_revolver' },
	{ name = 'WEAPON_DBSHOTGUN', label = 'weapon_dbshotgun' },
	{ name = 'WEAPON_COMPACTRIFLE', label = 'weapon_compactrifle' },
	{ name = 'WEAPON_AUTOSHOTGUN', label = 'weapon_autoshotgun' },
	{ name = 'WEAPON_BATTLEAXE', label = 'weapon_battleaxe' },
	{ name = 'WEAPON_COMPACTLAUNCHER', label = 'weapon_compactlauncher' },
	{ name = 'WEAPON_MINISMG', label = 'weapon_minismg' },
	{ name = 'WEAPON_PIPEBOMB', label = 'weapon_pipebomb' },
	{ name = 'WEAPON_POOLCUE', label = 'weapon_poolcue' },
	{ name = 'WEAPON_WRENCH', label = 'weapon_wrench' },
	{ name = 'WEAPON_FLASHLIGHT', label = 'weapon_flashlight' },
	{ name = 'GADGET_NIGHTVISION', label = 'gadget_nightvision' },
	{ name = 'GADGET_PARACHUTE', label = 'gadget_parachute' },
	{ name = 'WEAPON_FLARE', label = 'weapon_flare' }, 
	{ name = 'WEAPON_SNSPISTOL_MK2', label = 'weapon_snspistol_mk2' }, 
	{ name = 'WEAPON_REVOLVER_MK2', label = 'weapon_revolver_mk2' },  
	{ name = 'WEAPON_DOUBLEACTION', label = 'weapon_doubleaction' },    
	{ name = 'WEAPON_SPECIALCARBINE_MK2', label = 'weapon_specialcarabine_mk2' },  
	{ name = 'WEAPON_BULLPUPRIFLE_MK2', label = 'weapon_bullpruprifle_mk2' },   
	{ name = 'WEAPON_PUMPSHOTGUN_MK2', label = 'weapon_pumpshotgun_mk2' },
	{ name = 'WEAPON_MARKSMANRIFLE_MK2', label = 'weapon_marksmanrifle_mk2' },  
	{ name = 'WEAPON_ASSAULTRIFLE_MK2', label = 'weapon_assaultrifle_mk2' },
	{ name = 'WEAPON_CARBINERIFLE_MK2', label = 'weapon_carbinerifle_mk2' },  
	{ name = 'WEAPON_COMBATMG_MK2', label = 'weapon_combatmg_mk2' },   
	{ name = 'WEAPON_HEAVYSNIPER_MK2', label = 'weapon_heavysniper_mk2' },   
	{ name = 'WEAPON_PISTOL_MK2', label = 'weapon_pistol_mk2' },   
	{ name = 'WEAPON_SMG_MK2', label = 'weapon_smg_mk2' },
  }
