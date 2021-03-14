local Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["-"] = 84,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}

Config = {}

Config.CheckOwnership = false -- If true, Only owner of vehicle can store items in trunk.
Config.AllowPolice = true -- If true, police will be able to search players' trunks.

Config.Locale = "en"

Config.OpenKey = Keys["K"]

-- Limit, unit can be whatever you want. Originally grams (as average people can hold 25kg)
Config.Limit = 25000

-- Default weight for an item:
-- weight == 0 : The item do not affect character inventory weight
-- weight > 0 : The item cost place on inventory
-- weight < 0 : The item add place on inventory. Smart people will love it.
Config.DefaultWeight = 10

Config.localWeight = {
    -- Przedmioty używane (08.08.2019   04:41)
    cash = 1,
    headbag = 100,
    chocolate = 150,
    jumelles = 50,
    beer = 500,
    blackberry = 100,
    butlazgazem = 3000,
    grill = 500,
    phone = 100,
    blowpipe = 150,
    popcola = 330,
    gold = 5000,
    hamburger = 350,
    wine = 1000,
    grand_cru = 1000,
    vine = 1000,
    iron = 3000,
    keycard1 = 50,
    keycard2 = 50,
    keycard3 = 50,
    keycard4 = 50,
    keycard5 = 50,
    keycard6 = 50,
    keycard7 = 50,
    armored_vest = 5000,
    jewels = 200,
    vodka = 500,
    fixkit = 3000,
    polfixkit = 3000,
    alive_chicken = 5000,
    bandage = 50,
    burrito = 450,
    ciastkozwrozba = 50,
    diamond = 6000,
    dice = 20,
    drill = 1500,
    fish = 2500,
    fishingbait = 100,
    handcuffs = 100,
    hotdog = 200,
    kawa = 250,
    kebab = 550,
    packaged_chicken = 1000,
    packaged_cannabis = 1000,
    slaughtered_chicken = 3500,
    sajgonki = 150,
    sushi = 100,
    sprunk = 250,
    zapalniczka = 50,
    zdrapka = 5,
    czekoladahot = 250,
    bread = 350,
    water = 330,
    raisin = 200,
    clean_raisin = 200,
    clean_chicken = 5000,
    jus_raisin = 500,
    donut = 150,
    firstaid = 100,
    gauze = 50,
    medikit = 4000,
    medkit = 200,
    notepad = 50,
    papierosy = 10,
    radio = 100,
    rod = 700,
    weed_pooch = 1,
    -- Pistolety (08.08.2019   04:41)
    WEAPON_SNSPISTOL = 1000,
    WEAPON_PISTOL = 1500,
    WEAPON_COMBATPISTOL = 1500,
    WEAPON_HEAVYPISTOL = 2000,
    WEAPON_PISTOL50 = 2500,
    WEAPON_FLAREGUN = 1000,
    WEAPON_VINTAGEPISTOL = 1500,
    WEAPON_REVOLVER = 2500,
    -- SMG (08.08.2019   04:41)
    WEAPON_MINISMG = 2500,
    WEAPON_MICROSMG = 3000,
    WEAPON_SMG = 5000,
    WEAPON_ASSAULTSMG = 5500,
    -- Karabiny (08.08.2019   04:41)
    WEAPON_CARBINERIFLE = 8000,
    WEAPON_PUMPSHOTGUN = 12000,
    -- Broń Biała (08.08.2019   04:41)
    WEAPON_KNIFE = 200,
    WEAPON_NIGHTSTICK = 500,
    WEAPON_HAMMER = 600,
    WEAPON_BAT = 2000,
    WEAPON_GOLFCLUB = 1200,
    WEAPON_CROWBAR = 1500,
    WEAPON_STUNGUN = 250,
    WEAPON_BOTTLE = 100,
    WEAPON_DAGGER = 250,
    WEAPON_POOLCUE = 100,
    WEAPON_WRENCH = 1400,
    WEAPON_KNUCKLE = 400,
    WEAPON_HATCHET = 1300,
    WEAPON_BATTLEAXE = 1600,
    WEAPON_MACHETE = 700,
    WEAPON_SWITCHBLADE = 200,
    -- Broń Miotana (08.08.2019   04:41)
    WEAPON_SNOWBALL = 50,
    WEAPON_FLARE = 50,
    WEAPON_BALL = 100,
    WEAPON_PETROLCAN = 5000,
    WEAPON_FIREEXTINGUISHER = 5000
}

Config.VehicleLimit = {
    [0] = 15000, --Compact
    [1] = 30000, --Sedan
    [2] = 45000, --SUV
    [3] = 20000, --Coupes
    [4] = 20000, --Muscle
    [5] = 10000, --Sports Classics
    [6] = 5000, --Sports
    [7] = 5000, --Super
    [8] = 0, --Motorcycles
    [9] = 50000, --Off-road
    [10] = 80000, --Industrial
    [11] = 60000, --Utility
    [12] = 75000, --Vans
    [13] = 0, --Cycles
    [14] = 10000, --Boats
    [15] = 0, --Helicopters
    [16] = 0, --Planes
    [17] = 40000, --Service
    [18] = 35000, --Emergency
    [19] = 0, --Military
    [20] = 100000, --Commercial
    [21] = 0 --Trains
}

Config.VehiclePlate = {
    taxi = "TAXI",
    cop = "LSPD",
    ambulance = "EMS0",
    mecano = "MECA"
}
