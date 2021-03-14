Config = {}

Config.CallNPCDuration = 15000 -- ile ma trwać delay NPC do zaalarmowania LSPD (szansa na obezwładnienie NPC)
Config.SearchNPCDistanceMin = 10.0 -- minimalny obszar poszukiwań NPC do zaalarmowania
Config.SearchNPCDistanceMax = 150.0 -- maksymalny obszar poszukiwań NPC do zaalarmowania
Config.ShiftCoordsMin = 10 -- przesunięcie minimalne koordynatów notyfikacji
Config.ShiftBlipRadius = 150.0 -- zasięg notyfikacji strzałów; ShiftBlipRadius / 2 = ShiftCoordsMax ; jeśli ShiftCoordsMax < ShiftCoordsMin -> ShiftCoordsMax = ShiftCoordsMin
Config.ShiftBlipRadiusMultiplier = 2.0 -- jeśli NPC nie ma w zasięgu to powiększamy obszar notyfikacji ShiftBlipRadius * ShiftBlipRadiusMultiplier
Config.WarnedNPCSpeed = 2.0 -- prędkość maksymalna z jaką może się poruszać zaalarmowany NPC
Config.ChanceToAlertCopsIfNPCMissing = 99 -- szansa na notyfikację jeśli NPC nie ma w zasięgu