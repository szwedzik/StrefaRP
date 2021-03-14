--[[
Name: srp_whitelist
Author: Ezi - Ezi#0001
Version: v0.01.3612
Date: 21/06/2019 - 12:16
]]--

Config = {}
-- Wymaga streama aby grac na serwerze
Config.SteamOnly = true

-- Wyłącza Hardcap, powinno zostać na true... 
-- Inaczej kolejka przestanie działać
Config.DisableHardCap = true

-- Nada graczowi tymczasowy priorytet
-- Jeżeli się rozłączy i połączy powonie.
Config.GoldenWhenReconnect = true

-- Priorytet który otrzyma gracz przy ponownym łączeniu.
-- Dostępne wartości (1 - 100)
Config.GoldenReconnectLvl = 5

-- Jak długo ma się utrzymać priotytet dla gracza
-- przy ponownym łączeniu (czas podajemy w sekundach)
Config.GraceTime = 480

-- Antyspam przy łączeniu się z serwerem.
Config.AntiSpamTimer = math.random(1,15)

-- Tabela wiadomościu używana przez Whitelistę.
Config.Messages = {
    wlcheck = "[SRP] Sprawdzamy czy znajdujesz się na Whiteliscie...",
    nosteam = '[SRP] Nie wykryto działania Steam. Uruchom go i zrestartuj FiveM.',
    notwhitelisted = "[SRP] Nie znajdujesz się na Whiteliscie. Zaaplikuj na: https://aplikacje.strefarp.pl",
    antyspam = "[SPR] Trwa łączenie... Odczekaj %s sekund",
    pos = "[SRP] Jesteś %d/%d w kolejce \xF0\x9F\x95\x9C%s",
    error = "[SRP] Wystąpił błąd! Skontaktuj się z Administracja.",
}