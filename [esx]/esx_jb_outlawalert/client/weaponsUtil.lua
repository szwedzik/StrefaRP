
function IsWeaponPistol(playerPed)
	local selectedPedWeapon = GetSelectedPedWeapon(playerPed)
	return selectedPedWeapon == GetHashKey("WEAPON_PISTOL") 
			or selectedPedWeapon == GetHashKey("WEAPON_COMBATPISTOL") 
			or selectedPedWeapon == GetHashKey("WEAPON_HEAVYPISTOL") 
			or selectedPedWeapon == GetHashKey("WEAPON_PISTOL50") 
			or selectedPedWeapon == GetHashKey("WEAPON_SNSPISTOL") 
			or selectedPedWeapon == GetHashKey("WEAPON_FLAREGUN") 
			or selectedPedWeapon == GetHashKey("WEAPON_VINTAGEPISTOL") 
			or selectedPedWeapon == GetHashKey("WEAPON_MARKSMANPISTOL") 
			or selectedPedWeapon == GetHashKey("WEAPON_REVOLVER") 
			or selectedPedWeapon == GetHashKey("WEAPON_DOUBLEACTION");
end

function IsWeaponSMG(playerPed)
	local selectedPedWeapon = GetSelectedPedWeapon(playerPed)
	return selectedPedWeapon == GetHashKey("WEAPON_MICROSMG") 
			or selectedPedWeapon == GetHashKey("WEAPON_APPISTOL") 
			or selectedPedWeapon == GetHashKey("WEAPON_SMG") 
			or selectedPedWeapon == GetHashKey("WEAPON_ASSAULTSMG") 
			or selectedPedWeapon == GetHashKey("WEAPON_MG") 
			or selectedPedWeapon == GetHashKey("WEAPON_GUSENBERG") 
			or selectedPedWeapon == GetHashKey("WEAPON_COMBATPDW") 
			or selectedPedWeapon == GetHashKey("WEAPON_MACHINEPISTOL") 
			or selectedPedWeapon == GetHashKey("WEAPON_MINISMG");
end

function IsWeaponRifle(playerPed)
	local selectedPedWeapon = GetSelectedPedWeapon(playerPed)
	return selectedPedWeapon == GetHashKey("WEAPON_ASSAULTRIFLE") 
			or selectedPedWeapon == GetHashKey("WEAPON_CARBINERIFLE") 
			or selectedPedWeapon == GetHashKey("WEAPON_ADVANCEDRIFLE") 
			or selectedPedWeapon == GetHashKey("WEAPON_SPECIALCARBINE") 
			or selectedPedWeapon == GetHashKey("WEAPON_BULLPUPRIFLE") 
			or selectedPedWeapon == GetHashKey("WEAPON_COMPACTRIFLE") ;
end

function IsWeaponSniper(playerPed)
	local selectedPedWeapon = GetSelectedPedWeapon(playerPed)
	return selectedPedWeapon == GetHashKey("WEAPON_SNIPERRIFLE") 
			or selectedPedWeapon == GetHashKey("WEAPON_HEAVYSNIPER") 
			or selectedPedWeapon == GetHashKey("WEAPON_MARKSMANRIFLE");
end

function IsWeaponShotgun(playerPed)
	local selectedPedWeapon = GetSelectedPedWeapon(playerPed)
	return selectedPedWeapon == GetHashKey("WEAPON_PUMPSHOTGUN") 
			or selectedPedWeapon == GetHashKey("WEAPON_SAWNOFFSHOTGUN") 
			or selectedPedWeapon == GetHashKey("WEAPON_ASSAULTSHOTGUN") 
			or selectedPedWeapon == GetHashKey("WEAPON_BULLPUPSHOTGUN") 
			or selectedPedWeapon == GetHashKey("WEAPON_MUSKET") 
			or selectedPedWeapon == GetHashKey("WEAPON_HEAVYSHOTGUN") 
			or selectedPedWeapon == GetHashKey("WEAPON_DBSHOTGUN") 
			or selectedPedWeapon == GetHashKey("WEAPON_AUTOSHOTGUN");
end

function IsWeaponMelee(playerPed)
	local selectedPedWeapon = GetSelectedPedWeapon(playerPed)
	return selectedPedWeapon == GetHashKey("WEAPON_KNIFE") 
			or selectedPedWeapon == GetHashKey("WEAPON_NIGHTSTICK") 
			or selectedPedWeapon == GetHashKey("WEAPON_HAMMER") 
			or selectedPedWeapon == GetHashKey("WEAPON_BAT") 
			or selectedPedWeapon == GetHashKey("WEAPON_GOLFCLUB") 
			or selectedPedWeapon == GetHashKey("WEAPON_CROWBAR") 
			or selectedPedWeapon == GetHashKey("WEAPON_STUNGUN") 
			or selectedPedWeapon == GetHashKey("WEAPON_BOTTLE") 
			or selectedPedWeapon == GetHashKey("WEAPON_DAGGER") 
			or selectedPedWeapon == GetHashKey("WEAPON_POOLCUE") 
			or selectedPedWeapon == GetHashKey("WEAPON_WRENCH") 
			or selectedPedWeapon == GetHashKey("WEAPON_KNUCKLE") 
			or selectedPedWeapon == GetHashKey("WEAPON_HATCHET") 
			or selectedPedWeapon == GetHashKey("WEAPON_BATTLEAXE") 
			or selectedPedWeapon == GetHashKey("WEAPON_MACHETE") 
			or selectedPedWeapon == GetHashKey("WEAPON_SWITCHBLADE");
end

function IsWeaponHeavy(playerPed)
	local selectedPedWeapon = GetSelectedPedWeapon(playerPed)
	return selectedPedWeapon == GetHashKey("WEAPON_GRENADELAUNCHER") 
			or selectedPedWeapon == GetHashKey("WEAPON_RPG") 
			or selectedPedWeapon == GetHashKey("WEAPON_MINIGUN") 
			or selectedPedWeapon == GetHashKey("WEAPON_FIREWORK") 
			or selectedPedWeapon == GetHashKey("WEAPON_HOMINGLAUNCHER") 
			or selectedPedWeapon == GetHashKey("WEAPON_RAILGUN") 
			or selectedPedWeapon == GetHashKey("WEAPON_COMPACTLAUNCHER");
end

function IsWeaponRanged(playerPed)
	local selectedPedWeapon = GetSelectedPedWeapon(playerPed)
	return selectedPedWeapon == GetHashKey("WEAPON_GRENADE") 
			or selectedPedWeapon == GetHashKey("WEAPON_STICKYBOMB") 
			or selectedPedWeapon == GetHashKey("WEAPON_SMOKEGRENADE") 
			or selectedPedWeapon == GetHashKey("WEAPON_BZGAS") 
			or selectedPedWeapon == GetHashKey("WEAPON_MOLOTOV") 
			or selectedPedWeapon == GetHashKey("WEAPON_FIREEXTINGUISHER") 
			or selectedPedWeapon == GetHashKey("WEAPON_PETROLCAN") 
			or selectedPedWeapon == GetHashKey("WEAPON_BALL") 
			or selectedPedWeapon == GetHashKey("WEAPON_FLARE") 
			or selectedPedWeapon == GetHashKey("WEAPON_PROXMINE") 
			or selectedPedWeapon == GetHashKey("WEAPON_SNOWBALL") 
			or selectedPedWeapon == GetHashKey("WEAPON_PIPEBOMB");
end

--[[
	----------------Spis Broni----------------
--Pistolety
WEAPON_PISTOL = 0x1B06D571,453432689  -- Pistolet
WEAPON_COMBATPISTOL = 0x5EF9FEC4,1593441988 -- Pistolet Bojowy
WEAPON_HEAVYPISTOL = 0xD205520E,3523564046  -- Ciężki Pistolet
WEAPON_APPISTOL = 0x22D8FE39,584646201  -- Pistolet Automatyczny
WEAPON_PISTOL50 = 0x99AEEB3B,2578377531  -- Pistolet 50 (Deagle)
WEAPON_SNSPISTOL = 0xBFD21232,3218215474 -- Pukawka
WEAPON_FLAREGUN = 0x47757124,1198879012  -- Pistolet sygnałowy
WEAPON_VINTAGEPISTOL = 0x083839C4,137902532  -- Pistolet Vintage
WEAPON_MARKSMANPISTOL = 0xDC4DB296,3696079510  -- Pistolet Wyborowy
WEAPON_REVOLVER = 0xC1B3C3D1,3249783761  -- Ciężki Rewolwer

--SMG
WEAPON_MICROSMG = 0x13532244,324215364  -- Micro SMG
WEAPON_SMG = 0x2BE6766B,736523883  -- SMG
WEAPON_ASSAULTSMG = 0xEFE7E2DF,4024951519  -- Szturmowy SMG
WEAPON_MG = 0x9D07F764,2634544996  -- Karabin Maszynowy
WEAPON_COMBATMG = 0x7FD62962,2144741730  -- Bojowy Karabin Maszynowy
WEAPON_GUSENBERG = 0x61012683,1627465347  -- Gusenberg (SMG)
WEAPON_COMBATPDW = 0x0A3D4D34,171789620  -- PDW
WEAPON_MACHINEPISTOL = 0xDB1AA450,3675956304  -- Pistolet Maszynowy (tec)
WEAPON_MINISMG = 0xBD248B55,3173288789  -- Mini SMG

--Szturmowe (długie)
WEAPON_ASSAULTRIFLE = 0xBFEFFF6D,3220176749  -- Karabim Szturmowy
WEAPON_CARBINERIFLE = 0x83BF0278,2210333304  -- Karabinek
WEAPON_ADVANCEDRIFLE = 0xAF113F99,2937143193  -- Zaawansowany Karabin
WEAPON_SPECIALCARBINE = 0xC0A3098D,3231910285  -- Karabinek Specjalny
WEAPON_BULLPUPRIFLE = 0x7F229F94,2132975508  -- Karabin Bezkolbowy
WEAPON_COMPACTRIFLE = 0x624FE830,1649403952  -- Karabin Kompaktowy

--Karabiny snajperskie
WEAPON_SNIPERRIFLE = 0x05FC3C11,100416529  -- Karabin Snajperski
WEAPON_HEAVYSNIPER = 0x0C472FE2,205991906  -- Ciężki Karabin Snajperski
WEAPON_MARKSMANRIFLE = 0xC734385A,3342088282  -- Karabin Wyborowy

--Shotgun
WEAPON_PUMPSHOTGUN = 0x1D073A89,487013001  -- Shotgun
WEAPON_SAWNOFFSHOTGUN = 0x7846A318,2017895192  -- Shotgun krótki
WEAPON_ASSAULTSHOTGUN = 0xE284C527,3800352039  -- Strzelba sturmowa
WEAPON_BULLPUPSHOTGUN = 0x9D61E50F,2640438543  -- Strzelba bezkolbowa
WEAPON_MUSKET = 0xA89CB99E,2828843422  -- Muszkiet
WEAPON_HEAVYSHOTGUN = 0x3AABBBAA,984333226  -- Ciężka Strzelba
WEAPON_DBSHOTGUN = 0xEF951FBB,4019527611  -- Dwururka
WEAPON_AUTOSHOTGUN = 0x12E82D3D,317205821  -- Strzelba Automatyczna

--Broń biała
WEAPON_KNIFE = 0x99B507EA,2578778090  -- nóż
WEAPON_NIGHTSTICK = 0x678B81B1,1737195953  -- pałka policyjna
WEAPON_HAMMER = 0x4E875F73,1317494643  -- młotek
WEAPON_BAT = 0x958A4A8F,2508868239  -- kij bejzbolowy
WEAPON_GOLFCLUB = 0x440E4788,1141786504  -- kij golfowy
WEAPON_CROWBAR = 0x84BD7BFD,2227010557  -- łom
WEAPON_STUNGUN = 0x3656C8C1,911657153  -- Paralizator
WEAPON_BOTTLE = 0xF9E6AA4B,4192643659  -- Pęknięta Butelka
WEAPON_DAGGER = 0x92A27487,2460120199  -- Sztylet
WEAPON_POOLCUE = 0x94117305,2484171525  -- Kij Bilardowy
WEAPON_WRENCH = 0x19044EE0,419712736  -- Klucz Francuski
WEAPON_KNUCKLE = 0xD8DF3C3C,3638508604  -- Kastet
WEAPON_HATCHET = 0xF9DCBF2D,4191993645 -- Siekiera (toporek)
WEAPON_BATTLEAXE = 0xCD274149,3441901897  -- Topór Bitewny
WEAPON_MACHETE = 0xDD5DF8D9,3713923289  -- Maczeta
WEAPON_SWITCHBLADE = 0xDFE37640,3756226112  -- Scyzoryk (nóż rozkładany)

--Broń Ciężka
WEAPON_GRENADELAUNCHER = 0xA284510B,2726580491  -- Granatnik
WEAPON_RPG = 0xB1CA77B1,2982836145  -- Wyrzutnia rakiet (RPG)
WEAPON_MINIGUN = 0x42BF8A85,1119849093  -- MiniGun
WEAPON_FIREWORK = 0x7F7497E5,2138347493  -- Wyrzutnia Fajerwerków
WEAPON_HOMINGLAUNCHER = 0x63AB0442,1672152130  -- Wyrzutnia Namierzająca
WEAPON_RAILGUN = 0x6D544C99,1834241177  -- Railgun
WEAPON_COMPACTLAUNCHER = 0x0781FE4A,125959754  -- Granatnik Kompaktowy

--Broń Miotana
WEAPON_GRENADE = 0x93E220BD,2481070269  -- Granat
WEAPON_STICKYBOMB = 0x2C3731D9,741814745  -- Ładunek Przylepny
WEAPON_SMOKEGRENADE = 0xFDBC8A50,4256991824  -- Smoke
WEAPON_BZGAS = 0xA0973D5E,2694266206  -- Gaz Bojowy
WEAPON_MOLOTOV = 0x24B17070,615608432  -- Mołotow
WEAPON_FIREEXTINGUISHER = 0x060EC506,101631238  -- Gaśnica
WEAPON_PETROLCAN = 0x34A67B97,883325847  -- Kanister
WEAPON_BALL = 0x23C9F95C,600439132  -- Piłka
WEAPON_FLARE = 0x497FACC3,1233104067  -- Pistolet Sygnałowy (flara)
WEAPON_PROXMINE = 0xAB564B93,2874559379  -- Mina Zbliżeniowa
WEAPON_SNOWBALL = 0x787F0BB,126349499  -- Śnieżka
WEAPON_PIPEBOMB = 0xBA45E8B8,3125143736  -- Rurobomba

--NIE ZNANE w FiveM
WEAPON_UNARMED = 0xA2719263,2725352035
WEAPON_ANIMAL = 0xF9FBAEBE,4194021054
WEAPON_COUGAR = 0x08D4BE52,148160082
WEAPON_REMOTESNIPER = 0x33058E22,856002082
WEAPON_GRENADELAUNCHER_SMOKE = 0x4DD2DC56,1305664598
WEAPON_PASSENGER_ROCKET = 0x166218FF,375527679
WEAPON_AIRSTRIKE_ROCKET = 0x13579279,324506233
WEAPON_STINGER = 0x687652CE,1752584910
WEAPON_DIGISCANNER = 0xFDBADCED,4256881901  -- Skaner Częstotliwości
WEAPON_BRIEFCASE = 0x88C78EB7,2294779575
WEAPON_BRIEFCASE_02 = 0x01B79F17,28811031
WEAPON_VEHICLE_ROCKET = 0xBEFDC581,3204302209
WEAPON_BARBED_WIRE = 0x48E7B178,1223143800
WEAPON_DROWNING = 0xFF58C4FB,4284007675
WEAPON_DROWNING_IN_VEHICLE = 0x736F5990,1936677264
WEAPON_BLEEDING = 0x8B7333FB,2339582971
WEAPON_ELECTRIC_FENCE = 0x92BD4EBB,2461879995
WEAPON_EXPLOSION = 0x2024F4E8,539292904
WEAPON_FALL = 0xCDC174B0,3452007600
WEAPON_EXHAUSTION = 0x364A29EC,910830060
WEAPON_HIT_BY_WATER_CANNON = 0xCC34325E,3425972830
WEAPON_RAMMED_BY_CAR = 0x07FC7D7A,133987706
WEAPON_RUN_OVER_BY_CAR = 0xA36D413E,2741846334
WEAPON_HELI_CRASH = 0x145F1012,341774354
WEAPON_FIRE = 0xDF8E89EB,3750660587
WEAPON_GARBAGEBAG = 0xE232C28C,3794977420 -- Worek na śmieci ???
WEAPON_HANDCUFFS = 0xD04C944D,3494679629  -- Kajdanki ???
]]