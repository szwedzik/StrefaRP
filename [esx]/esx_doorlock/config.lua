Config = {}
Config.Locale = 'pl'

Config.DoorList = {

	--LA FUENTA

	[2] = { ["objName"] = "v_ilev_ra_door4r", ["x"]= 1395.919, ["y"]= 1140.704, ["z"]= 114.790, ["locked"]= false }, -- front right

	{
		objName = 'v_ilev_ra_door4l',
		objCoords  = {x= 1395.920, y= 1142.904,z= 114.700},
		locked = false,
		textCoords = {x = -400.98, y= -1609.42, z= 290.38},
		authorizedJobs = { 'cardealer' },
		distance = 3,
		size = 1
	},
	
	{
		objName = 'v_ilev_ra_door4r',
		objCoords  = {x= 1395.919, y= 1140.704,z= 114.700},
		locked = false,
		textCoords = {x = -400.98, y= -1609.42, z= 290.38},
		authorizedJobs = { 'cardealer' },
		distance = 3,
		size = 1
	},
	--SZERYF KOMENDA
	{
		objName = 'prop_facgate_07b',
		objCoords  = {x= 397.8851, y= -1607.386,z= 28.34166},
		locked = true,
		textCoords = {x = 400.98, y= -1609.42, z= 29.38},
		authorizedJobs = { 'police', 'statepolice', 'sheriff' ,'zwierzako'},
		distance = 15,
		size = 1
	},

	{
		objName = 'prop_fnclink_03gate5',
		objCoords  = {x= 391.8651, y= -1636.076,z= 29.97166},
		locked = true,
		textCoords = {x = 392.87, y= -1635.03, z= 29.38},
		authorizedJobs = { 'police', 'statepolice', 'sheriff' },
		distance = 3,
		size = 0.5
	},

	--State Police Brama TYŁ
	{
		objName = 'prop_facgate_07b',
		objCoords  = {x= 816.8351, y= -1324.682,z= 25.14321},
		locked = true,
		textCoords = {x = 816.8171, y= -1320.908, z= 26.43545},
		authorizedJobs = { 'police', 'statepolice', 'sheriff', 'zwierzako' },
		distance = 15,
		size = 1
	},

	--[[PillBox brama tył
	{
		objName = 'prop_facgate_07b',
		objCoords  = {x= 374.6731, y= -547.6681,z= 27.79563},
		locked = true,
		textCoords = {x = 374.6007, y= -543.8892, z= 29.2913},
		authorizedJobs = { 'ambulance' },
		distance = 15,
		size = 1
	},]]

	--
	-- Mission Row First Floor
	{
		objName = 'prop_facgate_07b',
		objCoords  = {x= 816.3604, y= -1324.608,z= 25.2},
		locked = true,
		textCoords = {x = 816.3604, y= -1324.608, z= 25.60},
		authorizedJobs = { 'police', 'statepolice', 'sheriff' }
	},

	-- {
	--     objName = "v_ilev_ph_gendoor004",
	--     objCoords = {x= 449.69815063477, y= -986.46911621094,z= 30.689594268799}, 
	--     locked= true,
	--     textCoords = { x=450.104,y=-986.388,z=31.739}, 
	-- 	distance = 1.2, 
	-- 	size = 1, 
	-- 	authorizedJobs = { 'police', 'statepolice', 'sheriff' }
	-- },

    -- Hospital - Left 1
    { 
		objName = "v_ilev_cor_doorglassb",
		objCoords = {x=252.688, y=-1361.462, z=24.68168}, 
		locked= true,
		textCoords = { x= 253.288, y= -1360.662, z= 24.68168}, 
		distance = 1.8, 
		size = 1, 
		authorizedJobs = { 'ambulance' }
	},
    -- Hospital - Left 2
    { 
		objName = "v_ilev_cor_doorglassa",
		objCoords = {x=254.3432, y=-1359.49, z=24.68168}, 
		locked= true,
		textCoords = { x=253.9432, y=-1360.10, z= 24.68168}, 
		distance = 1.8, 
		size = 1,
		authorizedJobs = { 'ambulance' }
	},
    -- Hospital - Right 1
    { 
		objName = "v_ilev_cor_doorglassb",
		objCoords = {x=265.7706, y=-1345.871, z=24.68168}, 
		locked= true,
		textCoords = { x=265.7706, y=-1345.471, z= 24.68168}, 
		distance = 1.8, 
		size = 1, 
		authorizedJobs = { 'ambulance' }
	},
    -- Hospital - Right 1
    { 
		objName = "v_ilev_cor_doorglassa",
		objCoords = {x=267.4241, y=-1343.9, z=24.68168}, 
		locked= true,textCoords = { x=267.2241, y=-1344.39, z= 24.68168}, 
		distance = 1.8, 
		size = 1, 
		authorizedJobs = { 'ambulance' }
	},
		--Nowy szpital prawe 1
	{ 
		objName = "v_ilev_cor_doorglassb",
		objCoords = {x=329.35, y=-585.32, z=43.33}, 
		locked= false,textCoords = {x=329.25, y=-585.42, z=43.33},
		distance = 1.4, 
		size = 1, 
		authorizedJobs = { 'ambulance' }
	},
		--Nowy szpital lewe 1
	{ 
		objName = "v_ilev_cor_doorglassb",
		objCoords = {x=330.13, y=-585.79, z=43.33}, 
		locked= false,textCoords = {x=330.13, y=-585.79, z=43.33}, 
		distance = 1.4, 
		size = 1, 
		authorizedJobs = { 'ambulance' }
	},
	--Nowy szpital sala 1
	{ 
		objName = "v_ilev_cor_doorglassb",
		objCoords = {x=329.10, y=-578.08, z=43.33}, 
		locked= false,textCoords = {x=329.10, y=-578.08, z=43.33}, 
		distance = 1.4, 
		size = 1, 
		authorizedJobs = { 'ambulance' }
	},
		--Nowy szpital sala 2
	{ 
		objName = "v_ilev_cor_doorglassb",
		objCoords = {x=329.54, y=-577.12, z=43.33}, 
		locked= false,textCoords = {x=329.54, y=-577.32, z=43.33}, 
		distance = 1.4, 
		size = 1, 
		authorizedJobs = { 'ambulance' }
	},

		--Nowy biuro 1
	{ 
		objName = "v_ilev_fib_door3",
		objCoords = {x= 342.98, y= -587.17, z= 43.46}, 
		locked= false,
		textCoords = {x= 341.85, y= -586.89, z= 43.46}, 
		distance = 1.4, 
		size = 1, 
		authorizedJobs = { 'ambulance' }
	},
		--Nowy biuro 2
	{
		objName = "v_ilev_fib_door3",
		objCoords = {x= 323.66, y= -587.16, z= 43.43}, 
		locked= false,
		textCoords = {x= 323.99, y= -586.23, z= 43.43}, 
		distance = 1.4, 
		size = 1, 
		authorizedJobs = { 'ambulance' }
	},
		
		--Nowy biuro 3
	{ 
		objName = "v_ilev_cor_firedoorwide",
		objCoords = {z= 338.25, y= -578.61, z= 43.33}, 
		locked= false,
		textCoords = {z= 338.25, y= -578.61, z= 43.33}, 
		distance = 1.4, 
		size = 1, 
		authorizedJobs = { 'ambulance' }
	},
	
		-- Entrance Doors
	{
		objName = 'v_ilev_ph_door01',
		objCoords  = {x = 434.747, y = -980.618, z = 30.839},
		textCoords = {x = 434.747, y = -981.50, z = 31.50},
		authorizedJobs = { 'police', 'statepolice', 'sheriff' },
		locked = false,
		distance = 2.5
	},

	{
		objName = 'v_ilev_ph_door002',
		objCoords  = {x = 434.747, y = -983.215, z = 30.839},
		textCoords = {x = 434.747, y = -982.50, z = 31.50},
		authorizedJobs = { 'police', 'statepolice', 'sheriff' },
		locked = false,
		distance = 2.5
	},

	--ZWIERZAK
	--
	--brama duża
	{
		objName = 'lr_prop_supermod_door_01',
		objCoords  = {x = -205.7, y = -1310.73, z = 31.29},
		textCoords = {x = -205.7, y = -1310.73, z = 32.18},
		authorizedJobs = { 'zwierzako' },
		locked = false,
		distance = 10
	},

	-- Rooftop
	{
		objName = 'v_ilev_gtdoor02',
		objCoords  = {x = 464.361, y = -984.678, z = 43.834},
		textCoords = {x = 464.361, y = -984.050, z = 44.834},
		authorizedJobs = { 'police', 'statepolice', 'sheriff' },
		locked = true
	},

	-- Hallway to roof
	{
		objName = 'v_ilev_arm_secdoor',
		objCoords  = {x = 461.286, y = -985.320, z = 30.839},
		textCoords = {x = 461.50, y = -986.00, z = 31.50},
		authorizedJobs = { 'police', 'statepolice', 'sheriff' },
		locked = true
	},

	-- -- Armory
	-- {
	-- 	objName = 'v_ilev_arm_secdoor',
	-- 	objCoords  = {x = 452.618, y = -982.702, z = 30.689},
	-- 	textCoords = {x = 453.079, y = -982.600, z = 31.739},
	-- 	authorizedJobs = { 'police', 'statepolice', 'sheriff' },
	-- 	locked = true
	-- },

	-- Captain Office
	{
		objName = 'v_ilev_ph_gendoor002',
		objCoords  = {x = 447.238, y = -980.630, z = 30.689},
		textCoords = {x = 447.200, y = -980.010, z = 31.739},
		authorizedJobs = { 'police', 'statepolice', 'sheriff' },
		locked = true
	},

	-- To downstairs (double doors)
	{
		objName = 'v_ilev_ph_gendoor005',
		objCoords  = {x = 443.97, y = -989.033, z = 30.6896},
		textCoords = {x = 444.020, y = -989.445, z = 31.739},
		authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
		locked = true,
		distance = 4
	},

	{
		objName = 'v_ilev_ph_gendoor005',
		objCoords  = {x = 445.37, y = -988.705, z = 30.6896},
		textCoords = {x = 445.350, y = -989.445, z = 31.739},
		authorizedJobs = { 'police', 'sheriff' ,'statepolice' },
		locked = true,
		distance = 4
	},

	-- 
	-- Mission Row Cells
	--

	-- Main Cells
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = 463.815, y = -992.686, z = 24.9149},
		textCoords = {x = 463.30, y = -992.686, z = 25.10},
		authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
		locked = true
	},

	-- Cell 1
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = 462.381, y= -993.651, z= 24.914},
		textCoords = {x = 461.806, y= -993.308, z= 25.064},
		authorizedJobs = { 'police', 'sheriff' ,'statepolice' },
		locked = true
	},

	-- Cell 2
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = 462.331, y= -998.152, z= 24.914},
		textCoords = {x = 461.806, y= -998.800, z= 25.064},
		authorizedJobs = { 'police', 'sheriff' ,'statepolice' },
		locked = true
	},

	-- Cell 3
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = 462.704, y = -1001.92, z = 24.9149},
		textCoords = {x = 461.806, y = -1002.450, z = 25.064},
		authorizedJobs = { 'police', 'sheriff' ,'statepolice' },
		locked = true
	},

	-- -- Cell 4
	-- {
	-- 	objName = 'v_ilev_ph_cellgate',
	-- 	objCoords  = {x = 465.925, y = -997.638, z = 25.063},
	-- 	textCoords = {x = 465.985, y = -998.638, z = 25.063},
	-- 	authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
	-- 	locked = true
	-- },

	-- -- Cell 5
	-- {
	-- 	objName = 'v_ilev_ph_cellgate',
	-- 	objCoords  = {x = 465.9198, y= -1001.333, z = 25.06443},
	-- 	textCoords = {x = 465.9198, y= -1002.333, z = 25.06443},
	-- 	authorizedJobs = { 'police', 'sheriff' ,'statepolice' },
	-- 	locked = true
	-- },

	-- -- Cell 6
	-- {
	-- 	objName = 'v_ilev_ph_cellgate',
	-- 	objCoords  = {x= 440.8802, y=-985.2081, z= 26.82781},
	-- 	textCoords = {x= 440.8802, y=-986.2081, z= 26.82781},
	-- 	authorizedJobs = { 'police', 'sheriff' ,'statepolice' },
	-- 	locked = true
	-- },

	-- -- Cell 7
	-- {
	-- 	objName = 'v_ilev_ph_cellgate',
	-- 	objCoords  = {x= 440.8946, y= -981.5637, z= 26.82781},
	-- 	textCoords = {x= 440.8946, y= -982.5637, z= 26.82781},
	-- 	authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
		
	-- 	locked = true
	-- },

	-- To Back
	{
		objName = 'v_ilev_gtdoor',
		objCoords  = {x = 463.478, y = -1003.538, z = 25.005},
		textCoords = {x = 464.00, y = -1003.50, z = 25.50},
		authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
		locked = true
	},

	--NOWY INTERIOR

	-- -- 1111
	-- {
	-- 	objName = 'v_ilev_ph_gendoor005',
	-- 	objCoords  = {x=454.3182, y=-981.461, z=26.82487},
	-- 	textCoords = {x=454.3182, y=-982.461, z=26.82487},
	-- 	authorizedJobs = { 'police', 'sheriff' ,'statepolice' },
	-- 	locked = false,
	-- 	distance = 2
	-- },

	-- -- 22222
	-- {
	-- 	objName = 'v_ilev_ph_gendoor005',
	-- 	objCoords  = { x=452.5199, y=-972.7687, z=26.82487},
	-- 	textCoords = { x=453.5199, y=-972.7687, z=26.82487},
	-- 	authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
	-- 	locked = true,
	-- 	distance = 3
	-- },


	--
	-- Mission Row Back
	--

	-- Back (double doors)
	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = 467.371, y = -1014.452, z = 26.536},
		textCoords = {x = 468.09, y = -1014.452, z = 27.1362},
		authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
		locked = true,
		distance = 4
	},

	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = 469.967, y = -1014.452, z = 26.536},
		textCoords = {x = 469.35, y = -1014.452, z = 27.136},
		authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
		locked = true,
		distance = 4
	},

	-- Back Gate
	{
		objName = 'hei_prop_station_gate',
		objCoords  = {x = 488.894, y = -1017.210, z = 27.146},
		textCoords = {x = 488.894, y = -1020.210, z = 30.00},
		authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
		locked = true,
		distance = 14,
		size = 2
	},

	-- Front Gate
	{
		objName = 'prop_fnclink_03gate5',
		objCoords  = {x= 423.62, y= -998.64,z= 30.71},
		locked = true,
		textCoords = {x = 423.50, y= -999.2, z= 31.00},
		authorizedJobs = { 'police', 'sheriff' ,'statepolice' },
		distance = 3,
		size = 0.5
	},
	{
		objName = 'prop_facgate_08',
		objCoords  = {x = 421.108, y= -1017.53, z = 30.96},
		textCoords = {x = 421.120, y = -1020.17, z = 29.19},
		authorizedJobs = { 'police', 'statepolice', 'sheriff','zwierzako' },
		locked = true,
		distance = 15,
		size = 3
	},

	{
		objName = 'prop_facgate_07b',
		objCoords  = {x = 397,8851, y= -1607,386, z = 28,34166},
		textCoords = {x = 401.09, y = -1609.36, z = 30.01},
		authorizedJobs = { 'police', 'statepolice', 'sheriff' ,'zwierzako'},
		locked = true,
		distance = 15,
		size = 3
	},

	--
	-- Sandy Shores
	--

	-- Entrance
	{
		objName = 'v_ilev_shrfdoor',
		objCoords  = {x = 1855.105, y = 3683.516, z = 34.266},
		textCoords = {x = 1855.105, y = 3683.516, z = 35.00},
		authorizedJobs = { 'police', 'statepolice', 'sheriff' },
		locked = false
	},
	-- Drzwi od pokoju przesłuchań
	{
		objName = 'v_ilev_ph_gendoor002',
		objCoords  = {x = 1846.799, y = 3683.336, z = 34.42923},
		textCoords = {x = 1847.100, y = 3682.500, z = 34.50},
		authorizedJobs = { 'police', 'statepolice', 'sheriff' },
		locked = true
	},
	-- Drzwi od szatni
	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = 1856.139, y = 3689.642, z = 34.41152},
		textCoords = {x = 1856.700, y = 3690.200, z = 34.50},
		authorizedJobs = { 'police', 'statepolice', 'sheriff' },
		locked = true
	},
	-- Drzwi od magazynu
	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = 1845.724, y = 3691.465, z = 34.43156},
		textCoords = {x = 1845.100, y = 3692.400, z = 34.40},
		authorizedJobs = { 'police', 'statepolice', 'sheriff' },
		locked = true
	},
	-- Cela
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = 1844.186, y = 3687.988, z = 30.61173},
		textCoords = {x = 1845.100, y = 3688.500, z = 30.70},
		authorizedJobs = { 'police', 'sheriff', 'statepolice' },
		locked = true
	},


	--
	-- Paleto Bay
	--

	-- Entrance (double doors)
	{
		objName = 'v_ilev_shrf2door',
		objCoords  = {x = -443.14, y = 6015.685, z = 31.716},
		textCoords = {x = -443.14, y = 6015.685, z = 32.00},
		authorizedJobs = { 'police', 'statepolice', 'sheriff' },
		locked = true,
		distance = 2.5
	},

	{
		objName = 'v_ilev_shrf2door',
		objCoords  = {x = -443.951, y = 6016.622, z = 31.716},
		textCoords = {x = -443.951, y = 6016.622, z = 32.00},
		authorizedJobs = { 'police', 'statepolice', 'sheriff' },
		locked = true,
		distance = 2.5
	},

	--
	-- Bolingbroke Penitentiary
	--

	-- Entrance (Two big gates)
	{
		objName = 'prop_gate_prison_01',
		objCoords  = {x = 1844.998, y = 2604.810, z = 44.638},
		textCoords = {x = 1844.998, y = 2608.50, z = 48.00},
		authorizedJobs = { 'police', 'statepolice', 'sheriff' },
		locked = true,
		distance = 12,
		size = 2
	},

	{
		objName = 'prop_gate_prison_01',
		objCoords  = {x = 1818.542, y = 2604.812, z = 44.611},
		textCoords = {x = 1818.542, y = 2608.40, z = 48.00},
		authorizedJobs = { 'police', 'statepolice', 'sheriff' },
		locked = true,
		distance = 12,
		size = 2
	},

	--
	-- Addons
	--

	-- -- 33333
	-- {
	-- 	objName = 'v_ilev_ph_gendoor005',
	-- 	objCoords  = {x=445.4764, y=-977.2424, z=26.82487},
	-- 	textCoords = {x=445.4764, y=-976.2424, z=26.82487},
	-- 	authorizedJobs = { 'police', 'statepolice', 'sheriff' },
	-- 	locked = true,
	-- 	distance = 3
	-- },
	
	-- -- 44444
	-- {
	-- 	objName = 'v_ilev_ph_gendoor005',
	-- 	objCoords  = {x=445.4935, y=-974.6362, z=26.82487},
	-- 	textCoords = {x=445.4935, y=-975.6362, z=26.82487},
	-- 	authorizedJobs = { 'police', 'statepolice', 'sheriff' },
	-- 	locked = true,
	-- 	distance = 3
	-- },

-- PillBox dół, drzwi interior
	{
		objName = 'v_ilev_cor_firedoor',
		objCoords  = {x=333.7885, y=-593.4055, z=28.80277},
		textCoords = {x=334.1, y=-592.72, z=29.3},
		authorizedJobs = { 'ambulance' },
		locked = true,
		distance = 3
	},
	{
		objName = 'v_ilev_cor_firedoor',
		objCoords = vector3(334.5754, -591.2445, 28.80277),
		textCoords = vector3(334.37, -591.79, 29.3),
		authorizedJobs = { 'ambulance' },
		locked = true,
		distance = 3
	},

	{
		objName = 'v_ilev_cor_firedoorwide',
		objCoords = vector3(337.2274, -584.0469, 28.81494),
		textCoords = vector3(337.5, -583.28, 29.3),
		authorizedJobs = { 'ambulance' },
		locked = true,
		distance = 3
	},

	{
		objName = 'v_ilev_cor_firedoor',
		objCoords = vector3(341.392, -572.5071, 28.81897),
		textCoords = vector3(341.64, -571.85, 29.3),
		authorizedJobs = { 'ambulance' },
		locked = true,
		distance = 3
	},

	{
		objName = 'v_ilev_cor_firedoor',
		objCoords = vector3(342.1784, -570.3473, 28.81897),
		textCoords = vector3(341.98, -571.01, 29.3),
		authorizedJobs = { 'ambulance' },
		locked = true,
		distance = 3
	},

	{
		objName = 'hei_prop_heist_cutscene_doorc_r',
		objCoords = vector3(321.0088, -559.9609, 28.88031),
		textCoords = vector3(320.44, -560.28, 29.3),
		authorizedJobs = { 'ambulance' },
		locked = true,
		distance = 3
	},
	{
		objName = 'hei_prop_heist_cutscene_doorc_r',
		objCoords = vector3(318.7677, -561.0198, 28.88031),
		textCoords = vector3(319.37, -560.71, 29.3),
		authorizedJobs = { 'ambulance' },
		locked = true,
		distance = 3
	},

	{
		objName = 'v_ilev_cor_firedoor',
		objCoords = vector3(345.0586, -567.9648, 28.82051),
		textCoords = vector3(345.66, -568.26, 29.3),
		authorizedJobs = { 'ambulance' },
		locked = true,
		distance = 3
	},
	{
		objName = 'v_ilev_cor_firedoor',
		objCoords = vector3(347.2267, -568.7333, 28.82051),
		textCoords = vector3(346.6, -568.48, 29.3),
		authorizedJobs = { 'ambulance' },
		locked = true,
		distance = 3
	},

	{
		objName = 'v_ilev_cor_firedoor',
		objCoords = vector3(346.8181, -572.0256, 28.7973),
		textCoords = vector3(346.58, -572.58, 29.3),
		authorizedJobs = { 'ambulance' },
		locked = true,
		distance = 3
	},
	{
		objName = 'v_ilev_cor_firedoor',
		objCoords = vector3(346.031, -574.1888, 28.7973),
		textCoords = vector3(346.26, -573.61, 29.3),
		authorizedJobs = { 'ambulance' },
		locked = true,
		distance = 3
	},---sheriiff interior wiezienie/office

	{
		objName = 'prop_ld_jail_door',
		objCoords  = {x = 2453.22, y = -837.37, z = -37.27},
		textCoords = {x = 2453.22, y = -837.37, z = -36.51},
		authorizedJobs = { 'police', 'statepolice', 'sheriff' },
		locked = true
	},
	{
		objName = 'prop_ld_jail_door',
		objCoords  = {x = 2447.49, y = -836.98, z = -37.27},
		textCoords = {x = 2447.49, y = -836.98, z = -36.51},
		authorizedJobs = { 'police', 'statepolice', 'sheriff' },
		locked = true
	},
	{
		objName = 'prop_ld_jail_door',
		objCoords  = {x = 2453.42, y = -832.02, z = -37.27},
		textCoords = {x = 2453.42, y = -832.02, z = -36.51},
		authorizedJobs = { 'police', 'statepolice', 'sheriff' },
		locked = true
	},


	----------------------------------------------------
	-----------
	-----
	--


	    --
    -- Mission Row First Floor
    --
 
    -- Entrance Doors
    {
        objName = 'v_ilev_ph_door01',
        objCoords  = {x = 434.747, y = -980.618, z = 30.839},
        textCoords = {x = 434.747, y = -981.50, z = 31.50},
        authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
        locked = false,
        distance = 2.5
    },
 
    {
        objName = 'v_ilev_ph_door002',
        objCoords  = {x = 434.747, y = -983.215, z = 30.839},
        textCoords = {x = 434.747, y = -982.50, z = 31.50},
        authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
        locked = false,
        distance = 2.5
    },
    
    -- To locker room & roof
    {
        objName = 'v_ilev_ph_gendoor004',
        objCoords  = {x = 449.698, y = -986.469, z = 30.689},
        textCoords = {x = 450.104, y = -986.388, z = 31.739},
        authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
        locked = true
    },
 
    -- Rooftop
    {
        objName = 'v_ilev_gtdoor02',
        objCoords  = {x = 464.361, y = -984.678, z = 43.834},
        textCoords = {x = 464.361, y = -984.050, z = 44.834},
        authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
        locked = true
    },
 
    -- Hallway to roof
    {
        objName = 'v_ilev_arm_secdoor',
        objCoords  = {x = 461.286, y = -985.320, z = 30.839},
        textCoords = {x = 461.50, y = -986.00, z = 31.50},
        authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
        locked = true
    },
 
    -- -- Captain Office
    -- {
    --     objName = 'v_ilev_ph_gendoor002',
    --     objCoords  = {x = 447.238, y = -980.630, z = 30.689},
    --     textCoords = {x = 447.200, y = -980.010, z = 31.739},
    --     authorizedJobs = { 'police' },
    --     locked = true
    -- },

 
    -- Back (double doors)
 
 
    -- Back Gate
    {
        objName = 'hei_prop_station_gate',
        objCoords  = {x = 488.894, y = -1017.210, z = 27.146},
        textCoords = {x = 488.894, y = -1020.210, z = 30.00},
        authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
        locked = true,
        distance = 14,
        size = 2
    },
-- Side Doors from parking
    {
        objName = 'v_ilev_gtdoor',
        objCoords  = {x = 446.21, y = -999.04, z = 30.7},
        textCoords = {x = 446.21, y = -999.04, z = 30.7},
        authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
        locked = true,
        distance = 2.5
    },
 
    {
        objName = 'v_ilev_gtdoor',
        objCoords  = {x = 445.56, y = -999.04, z = 30.7},
        textCoords = {x = 445.56, y = -999.04, z = 30.7},
        authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
        locked = true,
        distance = 2.5
    },
    -- To upstairs (double doors)
    {
        objName = 'v_ilev_ph_gendoor006',
        objCoords  = {x = 443.15, y = -992.80, z = 30.7},
        textCoords = {x = 443.15, y = -992.80, z = 30.7},
        authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
        locked = true,
        distance = 2
    },
 
    {
        objName = 'v_ilev_ph_gendoor006',
        objCoords  = {x = 443.15, y = -993.70, z = 30.7},
        textCoords = {x = 443.15, y = -993.70, z = 30.7},
        authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
        locked = true,
        distance = 2
    },
    -- Downstairs to processing (double doors)
    {
        objName = 'v_ilev_ph_gendoor003',
        objCoords  = {x = 446.20, y = -986.94, z = 26.7},
        textCoords = {x = 446.20, y = -986.94, z = 26.7},
        authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
        locked = true,
        distance = 2
    },
 
    {
        objName = 'v_ilev_ph_gendoor003',
        objCoords  = {x = 446.20, y = -986.00, z = 26.7},
        textCoords = {x = 446.20, y = -986.00, z = 26.7},
        authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
        locked = true,
        distance = 2
    },
    -- Downstairs to medical (double doors)
    {
        objName = 'v_ilev_ph_gendoor003',
        objCoords  = {x = 451.41, y = -983.91, z = 26.7},
        textCoords = {x = 451.41, y = -983.91, z = 26.7},
        authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
        locked = true,
        distance = 2
    },
 
    {
        objName = 'v_ilev_ph_gendoor003',
        objCoords  = {x = 452.70, y = -984.11, z = 26.7},
        textCoords = {x = 452.70, y = -984.11, z = 26.7},
        authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
        locked = true,
        distance = 2
    },
    -- Downstairs to storage (double doors)
    {
        objName = 'v_ilev_ph_gendoor003',
        objCoords  = {x = 465.49, y = -989.51, z = 24.91},
        textCoords = {x = 465.49, y = -989.51, z = 24.91},
        authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
        locked = true,
        distance = 2
    },
 
    {
        objName = 'v_ilev_ph_gendoor003',
        objCoords  = {x = 465.49, y = -990.56, z = 24.91},
        textCoords = {x = 465.49, y = -990.56, z = 24.91},
        authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
        locked = true,
        distance = 2
    },
    -- Downstairs to meeting (double doors)
    {
        objName = 'v_ilev_ph_gendoor003',
        objCoords  = {x = 469.88, y = -1010.98, z = 26.39},
        textCoords = {x = 469.88, y = -1010.98, z = 26.39},
        authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
        locked = true,
        distance = 2
    },
 
    {
        objName = 'v_ilev_ph_gendoor003',
        objCoords  = {x = 469.88, y = -1009.80, z = 26.39},
        textCoords = {x = 469.88, y = -1009.80, z = 26.39},
        authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
        locked = true,
        distance = 2
    },
    -- Upstairs to west balcony (double glassdoors)
    {
        objName = 'slb2k11_glassdoor',
        objCoords  = {x = 429.21, y = -995.55, z = 35.74},
        textCoords = {x = 429.21, y = -995.55, z = 35.74},
        authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
        locked = true,
        distance = 2
    },
 
    {
        objName = 'slb2k11_glassdoor',
        objCoords  = {x = 429.21, y = -994.64, z = 35.74},
        textCoords = {x = 429.21, y = -994.64, z = 35.74},
        authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
        locked = true,
        distance = 2
    },
    -- Dining to south balcony
    {
        objName = 'slb2k11_SECDOOR',
        objCoords  = {x = 463.51, y = -1011.35, z = 32.98},
        textCoords = {x = 463.51, y = -1011.35, z = 32.98},
        authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
        locked = true,
        distance = 2
    },
    -- To storage
    {
        objName = 'v_ilev_ph_gendoor006',
        objCoords  = {x = 471.15, y = -985.32, z = 24.91},
        textCoords = {x = 471.15, y = -985.32, z = 24.91},
        authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
        locked = true,
        distance = 2
    },
    -- To server
    {
        objName = 'v_ilev_ph_gendoor006',
        objCoords  = {x = 468.43, y = -978.15, z = 24.91},
        textCoords = {x = 468.43, y = -978.15, z = 24.91},
        authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
        locked = true,
        distance = 2
    },
    -- To laboratory
    {
        objName = 'v_ilev_ph_gendoor006',
        objCoords  = {x = 463.65, y = -981.33, z = 24.91},
        textCoords = {x = 463.65, y = -981.33, z = 24.91},
        authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
        locked = true,
        distance = 2
    },
    -- Cells
    {
        objName = 'v_ilev_gtdoor',
        objCoords  = {x = 467.93, y = -996.65, z = 24.91},
        textCoords = {x = 467.93, y = -996.65, z = 24.91},
        authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
        locked = true,
        distance = 2
    },
 
    {
        objName = 'v_ilev_gtdoor',
        objCoords  = {x = 472.25, y = -996.65, z = 24.91},
        textCoords = {x = 472.25, y = -996.65, z = 24.91},
        authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
        locked = true,
        distance = 2
    },
    
    {
        objName = 'v_ilev_gtdoor',
        objCoords  = {x = 476.51, y = -996.65, z = 24.91},
        textCoords = {x = 476.51, y = -996.65, z = 24.91},
        authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
        locked = true,
        distance = 2
    },
    
    {
        objName = 'v_ilev_gtdoor',
        objCoords  = {x = 480.71, y = -996.65, z = 24.91},
        textCoords = {x = 480.71, y = -996.65, z = 24.91},
        authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
        locked = true,
        distance = 2
    },
    -- Interrogations
    {
        objName = 'v_ilev_gtdoor',
        objCoords  = {x = 480.8, y = -1003.29, z = 24.91},
        textCoords = {x = 480.8, y = -1003.29, z = 24.91},
        authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
        locked = true,
        distance = 2
    },
 
    {
        objName = 'v_ilev_gtdoor',
        objCoords  = {x = 476.33, y = -1003.29, z = 24.91},
        textCoords = {x = 476.33, y = -1003.29, z = 24.91},
        authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
        locked = true,
        distance = 2
    },
    
    {
        objName = 'v_ilev_gtdoor',
        objCoords  = {x = 472.22, y = -1003.29, z = 24.91},
        textCoords = {x = 472.22, y = -1003.29, z = 24.91},
        authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
        locked = true,
        distance = 2
    },
        
    {
        objName = 'v_ilev_gtdoor',
        objCoords  = {x = 467.81, y = -1003.29, z = 24.91},
        textCoords = {x = 467.81, y = -1003.29, z = 24.91},
        authorizedJobs = { 'police' , 'sheriff' ,'statepolice'},
        locked = true,
        distance = 2
    },


}
