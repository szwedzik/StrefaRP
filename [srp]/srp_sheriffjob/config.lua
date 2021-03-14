Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 27
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }

Config.EnablePlayerManagement2     = true

Config.EnableArmoryManagement2     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds2      = false -- turn this on if you want custom peds
Config.EnableLicenses             = true -- enable if you're using esx_license

Config.EnableHandcuffTimer2        = true -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer2              = 25 * 60000 -- 10 mins

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society

Config.MaxInService2               = -1
Config.Locale                     = 'pl'

Config.PoliceStations2 = {
	
	LSSD = {

		Blip = {
			Coords  = vector3(364.24, -1597.87, 36.95),
			Sprite  = 60,
			Display = 4,
			Scale   = 0.8,
			Name	= 'Biuro Szeryfa',
			Colour  = 3
		},

		Cloakrooms = {
			vector3(361.88, -1591.33, 28.31)
		},

		Armories = {
			vector3(365.54, -1583.40, 28.31)
		},

		Vehicles = {
			{
				Spawner = vector3(342.78, -1640.02, 23.78),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{ coords = vector3(351.32, -1640, 23.75), heading = 229.01, radius = 0.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(376.80, -1602.11, 36.95),
				InsideShop = vector3(477.0, -1106.4, 43.0),
				SpawnPoints = {
					{ coords = vector3(362.62, -1598.52, 37.34), heading = 139.34, radius = 0.0 }
				}
			}
		},

		BossActions = {
			vector3(365.11, -1590.37, 28.31)
		}

	},

	POL4 = {

		Blip = { 
			Coords  = vector3(1853.68, 3686.16, 34.27),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Name	= 'Los Santos Sheriff Department',
			Colour  = 3
		},

		Cloakrooms = {
			vector3(1856.16, 3692.76, 33.30)
		},

		Armories = {
			vector3(1843.15, 3688.99, 33.30)
		},

		Vehicles = {
			{
				Spawner = vector3(1867.54, 3691.07, 33.75),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{ coords = vector3(1863.48, 3699.23, 33.28), heading = 209.88, radius = 0.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(461.1, -981.5, -103.6),
				InsideShop = vector3(477.0, -1106.4, 43.0),
				SpawnPoints = {
					{ coords = vector3(449.5, -981.2, 43.6), heading = 92.6, radius = 10.0 }
				}
			}
		},

		BossActions = {
			vector3(1844.36, 3686.37, 33.30)
		}

	},

	POL5 = {

		Blip = { 
			Coords  = vector3(-445.85, 6013.83, 31.72),
			Sprite  = 60,
			Display = 4,
			Scale   = 0.8,
			Name	= 'Biuro Szeryfa',
			Colour  = 3
		},

		Cloakrooms = {
			vector3(-449.48, 6016.52, 31.8)
		},

		Armories = {
			vector3(-441.7,6012.55,31.8)
		},

		Vehicles = {
			{
				Spawner = vector3(-447.69, 6001.07, 31.69),
				InsideShop = vector3(-450.46,6011.48,31.72),
				SpawnPoints = {
					{ coords = vector3(-450.68, 5988.89, 30.92), heading = 43.79, radius = 6.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(461.1, -981.5, -103.6),
				InsideShop = vector3(477.0, -1106.4, 43.0),
				SpawnPoints = {
					{ coords = vector3(449.5, -981.2, 43.6), heading = 92.6, radius = 10.0 }
				}
			}
		},

		BossActions = {
			vector3(448.4, -973.2, -130.6)
		}

	}



}

Config.AuthorizedWeapons2 = {
	Shared = {
		{ weapon = 'WEAPON_CARBINERIFLE',  components = { nil, nil, nil, 0, 0, nil , 0 ,nil} , price = 0 },
		{ weapon = 'WEAPON_PISTOL', components = { nil, 0, 0, nil, 0}, price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', components = { nil, 0, 0, nil, 0}, price = 0 },
		{ weapon = 'WEAPON_SNSPISTOL', components = { nil, 0, 0, nil, nil}, price = 0 },
		{ weapon = 'WEAPON_HEAVYPISTOL', components = { nil, 0, 0, nil, 0}, price = 0 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	}
}

Config.Uniforms2 = {
	
	bullet_wear3 = {
		male = {
			['bproof_1'] = 12,  ['bproof_2'] = 2
		},
		female = {
			['bproof_1'] = 11,  ['bproof_2'] = 2
		}
	},
	gilet_wear = {
		male = {
			['bproof_1'] = 10,  ['bproof_1'] = 0
		},
		female = {
			['bproof_1'] = 36,  ['bproof_1'] = 1
		}
	},
	bullet_wear2 = {
		male = {
			['bproof_1'] = 12,  ['bproof_2'] = 3
		},
		female = {
			['bproof_1'] = 13,  ['bproof_2'] = 1
		}
	},
	handcuffs = {
		male = {
			['chain_1'] = 41,  ['chain_2'] = 0
		},
		female = {
			['chain_1'] = 25,  ['chain_2'] = 0
		}
	},
	no_handcuffs = {
		male = {
			['chain_1'] = 0,  ['chain_2'] = 0
		},
		female = {
			['chain_1'] = 0,  ['chain_2'] = 0
		}
	},
	szeryf_wear = {
		male = {
			['tshirt_1'] = 65, ['tshirt_2'] = 1,
			['torso_1'] = 156,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['pants_1'] = 48,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 0,
			['bproof_1'] = 14,  ['bproof_2'] = 0,
			['glasses_1'] = -1,	['arms'] = 1,
			['bags_1'] = 0, ['bags_2'] = 0
		},
		female = {
			['tshirt_1'] = 45,  ['tshirt_2'] = 1,
			['torso_1'] = 153,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['chain_1'] = 8, ['chain_2'] = 0,
			['pants_1'] = 41,   ['pants_2'] = 1,
			['shoes_1'] = 52,   ['shoes_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 0,
			['bproof_1'] = 16,  ['bproof_2'] = 0,
			['glasses_1'] = -1,	['arms'] = 3,
			['bags_1'] = 0, ['bags_2'] = 0
		}
	},

	szeryf2_wear = {
		male = {
			['tshirt_1'] = 15, ['tshirt_2'] = 0,
			['torso_1'] = 156,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['pants_1'] = 32,   ['pants_2'] = 2,
			['shoes_1'] = 33,   ['shoes_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['helmet_1'] = 17,  ['helmet_2'] = 2,
			['bproof_1'] = 26,  ['bproof_2'] = 1,
			['glasses_1'] = -1,	['arms'] = 17,
			['bags_1'] = 0, ['bags_2'] = 0
		},
		female = {
			['tshirt_1'] = 160,  ['tshirt_2'] = 0,
			['torso_1'] = 153,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['pants_1'] = 31,   ['pants_2'] = 2,
			['shoes_1'] = 9,   ['shoes_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['helmet_1'] = 17,  ['helmet_2'] = 2,
			['bproof_1'] = 28,  ['bproof_2'] = 1,
			['glasses_1'] = -1,	['arms'] = 3,
			['bag_1'] = 0, ['bag_2'] = 0
		}
	},

	szeryf3_wear = {
		male = {
			['tshirt_1'] = 15, ['tshirt_2'] = 0,
			['torso_1'] = 49,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['chain_1'] = 1, ['chain_2'] = 0,
			['pants_1'] = 31,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['mask_1'] = 56,  ['mask_2'] = 3,
			['helmet_1'] = 75,  ['helmet_2'] = 1,
			['bproof_1'] = 27,  ['bproof_2'] = 0,
			['glasses_1'] = -1,	['arms'] = 17,
			['bags_1'] = 0, ['bags_2'] = 0
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 42,   ['torso_2'] = 1,
			['decals_1'] = 4,   ['decals_2'] = 0,
			['chain_1'] = 1, ['chain_2'] = 0,
			['pants_1'] = 30,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['mask_1'] = 56,  ['mask_2'] = 3,
			['helmet_1'] = 74,  ['helmet_2'] = 1,
			['bproof_1'] = 29,  ['bproof_2'] = 0,
			['glasses_1'] = -1,	['arms'] = 17,
			['bags_1'] = 0, ['bags_2'] = 0
		}
	},

	szeryf4_wear = {
		male = {
			['tshirt_1'] = 38, ['tshirt_2'] = 0,
			['torso_1'] = 200,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 54,   ['shoes_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 0,
			['bproof_1'] = 2,  ['bproof_2'] = 0,
			['glasses_1'] = -1,	['arms'] = 1,
			['bags_1'] = 53, ['bags_2'] = 0
		},
		female = {
			['tshirt_1'] = 27,  ['tshirt_2'] = 0,
			['torso_1'] = 202,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['pants_1'] = 41,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 0,
			['bproof_1'] = 14,  ['bproof_2'] = 0,
			['glasses_1'] = -1,	['arms'] = 3,
			['bags_1'] = 53, ['bags_2'] = 0
		}
	},

	szeryf_kadet = {
		male = {
			['tshirt_1'] = 38, ['tshirt_2'] = 0,
			['torso_1'] = 200,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 54,   ['shoes_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 0,
			['bproof_1'] = 10,  ['bproof_2'] = 1,
			['glasses_1'] = -1,	['arms'] = 1,
			['bags_1'] = 53, ['bags_2'] = 0
		},
		female = {
			['tshirt_1'] = 27,  ['tshirt_2'] = 0,
			['torso_1'] = 202,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['pants_1'] = 41,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 0,
			['bproof_1'] = 10,  ['bproof_2'] = 1,
			['glasses_1'] = -1,	['arms'] = 3,
			['bags_1'] = 53, ['bags_2'] = 0
		}
	},

	szeryf5_wear = {
		male = {
			['tshirt_1'] = 38, ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 54,   ['shoes_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 0,
			['bproof_1'] = 13,  ['bproof_2'] = 0,
			['glasses_1'] = -1,	['arms'] = 2,
			['bags_1'] = 53, ['bags_2'] = 0
		},
		female = {
			['tshirt_1'] = 27,  ['tshirt_2'] = 0,
			['torso_1'] = 192,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['pants_1'] = 41,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 0,
			['bproof_1'] = 14,  ['bproof_2'] = 0,
			['glasses_1'] = -1,	['arms'] = 2,
			['bags_1'] = 53, ['bags_2'] = 0
		}
	},

	szeryf6_wear = {
		male = {
			['tshirt_1'] = 38, ['tshirt_2'] = 0,
			['torso_1'] = 94,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['chain_1'] = 1, ['chain_2'] = 0,
			['pants_1'] = 33,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['helmet_1'] = 10,  ['helmet_2'] = 0,
			['bproof_1'] = 13,  ['bproof_2'] = 0,
			['glasses_1'] = -1,	['arms'] = 0,
			['bags_1'] = 0, ['bags_2'] = 0
		},
		female = {
			['tshirt_1'] = 27,  ['tshirt_2'] = 1,
			['torso_1'] = 85,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['pants_1'] = 54,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['helmet_1'] = 10,  ['helmet_2'] = 0,
			['bproof_1'] = 14,  ['bproof_2'] = 0,
			['glasses_1'] = -1,	['arms'] = 14,
			['bags_1'] = 0, ['bags_2'] = 0
		}
	},

	szeryf7_wear = {
	male = {
		['tshirt_1'] = 28, ['tshirt_2'] = 0,
		['torso_1'] = 36,   ['torso_2'] = 4,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['chain_1'] = 6, ['chain_2'] = 0,
		['pants_1'] = 35,   ['pants_2'] = 0,
		['shoes_1'] = 54,   ['shoes_2'] = 0,
		['mask_1'] = 0,  ['mask_2'] = 0,
		['helmet_1'] = 13,  ['helmet_2'] = 0,
		['bproof_1'] = 23,  ['bproof_2'] = 1,
		['glasses_1'] = -1,	['arms'] = 6,
		['bags_1'] = 0, ['bags_2'] = 0
	},
	female = {
		['tshirt_1'] = 23,  ['tshirt_2'] = 0,
		['torso_1'] = 168,   ['torso_2'] = 4,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['chain_1'] = 6, ['chain_2'] = 0,
		['pants_1'] = 41,   ['pants_2'] = 3,
		['shoes_1'] = 52,   ['shoes_2'] = 0,
		['mask_1'] = 0,  ['mask_2'] = 0,
		['helmet_1'] = 13,  ['helmet_2'] = 0,
		['bproof_1'] = 25,  ['bproof_2'] = 1,
		['glasses_1'] = -1,	['arms'] = 7,
		['bags_1'] = 0, ['bags_2'] = 0
		}
	},

	szeryf8_wear = {
		male = {
			['tshirt_1'] = 65, ['tshirt_2'] = 1,
			['torso_1'] = 189,   ['torso_2'] = 7,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['shoes_1'] = 54,   ['shoes_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['helmet_1'] = 10,  ['helmet_2'] = 0,
			['bproof_1'] = 23,  ['bproof_2'] = 1,
			['glasses_1'] = -1,	['arms'] = 3,
			['bags_1'] = 0, ['bags_2'] = 0
		},
		female = {
			['tshirt_1'] = 45,  ['tshirt_2'] = 1,
			['torso_1'] = 191,   ['torso_2'] = 7,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['pants_1'] = 41,   ['pants_2'] = 1,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['shoes_1'] = 52,   ['shoes_2'] = 0,
			['helmet_1'] = 10,  ['helmet_2'] = 0,
			['bproof_1'] = 25,  ['bproof_2'] = 1,
			['glasses_1'] = -1,	['arms'] = 3,
			['bags_1'] = 0, ['bags_2'] = 0
		}
	}
}
