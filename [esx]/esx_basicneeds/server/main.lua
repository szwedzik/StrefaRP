ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
-----------------------------------------------------------------------
-- Jedzenie

ESX.RegisterUsableItem('bread', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('bread', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 120000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	--TriggerClientEvent('esx:showNotification', source, _U('used_bread'))
end)

ESX.RegisterUsableItem('kanapka', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('kanapka', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	--TriggerClientEvent('esx:showNotification', source, _U('used_kanapka'))
end)

ESX.RegisterUsableItem('donut', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('donut', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 170000)
	TriggerClientEvent('esx_basicneeds:onEat', source,"prop_donut_01")
	TriggerClientEvent('esx_basicneeds:onDonut', source)
	--TriggerClientEvent('esx:showNotification', source, "Objadasz się donutem")
end)

ESX.RegisterUsableItem('ciasto', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)		
	xPlayer.removeInventoryItem('ciasto', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 1750000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	--TriggerClientEvent('esx:showNotification', source, 'Zjadasz pysznego ~g~makowca')
end)

ESX.RegisterUsableItem('sajgonki', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('sajgonki', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 275000)
	TriggerClientEvent('esx_basicneeds:onEat', source,"prop_donut_01")
	--TriggerClientEvent('esx:showNotification', source, "Zjadasz ~g~sajgonkę")
end)

ESX.RegisterUsableItem('noodle', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('noodle', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 225000)
	TriggerClientEvent('esx_basicneeds:onEat', source,"prop_donut_01")
	--TriggerClientEvent('esx:showNotification', source, "Zjadasz ~g~noodle")
end)

ESX.RegisterUsableItem('sushi', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('sushi', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 237500)
	TriggerClientEvent('esx_basicneeds:onEat', source,"prop_donut_01")
	--TriggerClientEvent('esx:showNotification', source, "Zjadasz ~g~sushi")
end)

ESX.RegisterUsableItem('burrito', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('burrito', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 321500)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	--TriggerClientEvent('esx:showNotification', source, "Zjadasz burrito")
end)

ESX.RegisterUsableItem('hotdog', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('hotdog', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 265125)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	--TriggerClientEvent('esx:showNotification', source, "Zjadasz hot-doga")
end)

ESX.RegisterUsableItem('lazania', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('lazania', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 285125)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	--TriggerClientEvent('esx:showNotification', source, "Zjadasz hot-doga")
end)

ESX.RegisterUsableItem('kebab', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('kebab', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 357250)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	--TriggerClientEvent('esx:showNotification', source, "Zjadasz kebaba")
end)

ESX.RegisterUsableItem('pizza', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('pizza', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 310250)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	--TriggerClientEvent('esx:showNotification', source, "Zjadasz kebaba")
end)

ESX.RegisterUsableItem('hamburger', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('hamburger', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 307250)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	--TriggerClientEvent('esx:showNotification', source, "Zjadasz hamburgera")
end)


ESX.RegisterUsableItem('salatka', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('salatka', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 267250)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	--TriggerClientEvent('esx:showNotification', source, "Zjadasz sałatkę")
end)

ESX.RegisterUsableItem('chocolate', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('chocolate', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 125250)
	TriggerClientEvent('esx_basicneeds:onEat', source)
end)

ESX.RegisterUsableItem('ciastkozwrozba', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('ciastkozwrozba', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 90000)
	TriggerClientEvent('esx_basicneeds:onEat', source,"prop_donut_01")
	--TriggerClientEvent('esx:showNotification', source, "Otwierasz i zjadasz ~g~ciasteczko z wróżbą")
	local msg = {
		'Spotkasz przystojnego bruneta wieczorową porą.',
		'Strzeż się zielonookiej blondynki, chce ci zaszkodzić.',
		'Nie wychodź z domu w czwartek, a unikniesz kłopotów.',
		'Zwróć uwagę na bliską ci osobę, pragnie twojego towarzystwa.',
		'Nie kombinuj tylko powiedz tej osobie, co do niej czujesz!',
		'Nie bój się, wszystko potoczy się po twojej myśli!',
		'Zdrada wisi w powietrzu!',
		'W tym roku czeka cię burzliwy romans.',
		'Zastanów się jeszcze i nie skacz od razu na głęboką wodę!',
		'Jutro włóż rano monetę pod wycieraczkę, zapewni ci sukces.',
		'Uśmiechnij się do nieznajomego, a zobaczysz co się stanie.',
		'Nie pracuj tyle, bo ucierpi na tym twoje zdrowie.',
		'Załóż czapkę, inaczej spędzisz 2 tygodnie w łóżku.',
		'Ktoś, kogo imię zaczyna się na literę M, bacznie cię obserwuje.',
		'Twój przyszły mąż będzie miał na imię Tomek.',
		'Osoba najbliżej twojej prawej strony jest ci życzliwa.',
		'Nie planuj niczego na sobotę! Czeka cię coś niespodziewanego!',
		'W tym roku będzie ślub. Twój własny.',
		'Oświadczyny nie są ci pisane.',
		'Śledzi cię seksowny brodacz :)',
		'Zrób test ciążowy!',
		'Twój sąsiad się w tobie zadurzył. Zrób coś z tym.',
		'Podskocz 3 razy, a napełnisz swoje życie atrakcyjnymi wydarzeniami.',
		'Pomaluj paznokcie na różowo - to przyniesie ci miły i radosny dzień.',
		'Nie daj się złamać, życie jest piękne.',
		'Dla ciebie tylko jedna rada - schowaj pieniądze w bezpieczne miejsce!',
		'Bądź miła/miły dla uroczego wąsacza.',
		'Pocałuj osobę najbliżej stojącą lub pierwszą napotkaną.',
		'Pozbądź się czarnej bluzki, a wszystko się ułoży!',
		'Ktoś chce cię zabić!',
		'Uciekaj z tąd!',
		'Ktoś ma cię na oku!',
		'Co masz zrobić dziś… zrób dziś.',
		'Dzisiaj jest twój dobry dzień.',
		'Nie ma rzeczy niemożliwych.',
		'Zawiąż sznurówki…:D',
		'UWAGA! Ktoś Cię obserwuje! :)',
		'Zawsze słuchaj swojego ciasteczka.',
		'Szczęście, którego szukasz, jest w drugim ciasteczku :)',
		'Oczekuj na miłą niespodziankę.',
		'Czeka cię wizyta u dentysty (jedz mniej lizaków!) :)',
		'Zostaniesz gwiazdą filmową!',
		'Ktoś bardzo cię lubi…',
		'Za kilka dni wypadnie ci ząb.',
		'Czeka cię wielka przygoda!',
		'Twoi rodzice bardzo cię kochają.',
		'Zaśpiewaj piosenkę.',
		'Opowiedz dowcip.',
		'Zrób 10 przysiadów (lub inne sportowe).',
		'Wymień 3 miasta na literę A (lub inną).',
		'Powiedz bez błędu łamaniec językowy, np. :„W czasie suszy szosa sucha”.',
		'Zachowuj się jak pies przez minutę',
		'Pokaż wszystkie swoje tatuaże',
		'Udawaj ninje',
		'Pocałuj każdego z osób obok ciebie',
		'Udawaj, że boli Cię gardło',
		'Usiądź na obu dłoniach przez minutę',
		'Zrób 10 pompek',
		'Dolicz do 40 bez przerwy na oddech',
		'Zaśpiewaj dowolną romantyczną piosenkę',
		'Przejdź się jak modelka po wybiegu',
		'Zatańcz tango z miotłą',
		'Przez minutę mów najniższym głosem jakim potrafisz',
		'Opisz swój najlepszy dzień w życiu.',
		'Dobierz się z kimś w parę. Spodziewacie się dziecka. Zagrajcie scenkę narodzin dziecka',
		'Ktoś musi ci dać wyzwanie',
		'Poliż klamkę',
		'Zapiej jak kogut',
		'Powiedz kawał',
		'Weź ślub na 5 minut. Niech ktoś wybierze Ci partnera.',
		'Powiedz szczerze osobie po Twojej lewej coś niewygodnego',
		'Wejdź pod stół i zachrumkaj jak świnka',
		'Siedź jak budda przez 3 minuty',
		'Na czworaka zachowuj się jak świnia przez 10 sekund',
		'Przytul osobę na przeciwko Ciebie',
		'Udawaj muchę',
		'Weź na barana osobę naprzeciwko',
		'Poliż ucho osobie naprzeciwko',
		'Przez 30 sekund udawaj, że grasz na gitarze',
		'Opowiedz suchara',
		'Udawaj odgłosy bolidów Formuły 1',
		'Przez 30s  posługuj się językiem obcym.',
		'Udawaj drzewo przez minutę',
		'Udawaj rewolwerowca z westeru',
		'Naśladuj jakąś osobę.',
		'Kręć się w lewo przez 30 sekund',
		'Udawaj, że jesteś kurczakiem przez minutę',
		'Udawaj, że grasz na perkusji',
		'Zatańcz breakdance’a',
		'Zatańcz jak robot',
		'Wykonuj szalony taniec przez minutę',
		'Włoż komuś palec do ucha',
		'Nie ruszaj się przez minutę',
		'Udawaj, że z przejęciem czytasz gazetę',
		'Zaśpiewaj swoją ulubioną piosenke',
		'Opowiedz coś śmiesznego',
	}
	TriggerClientEvent("sendProximityMessageMe3D", -1, source, 'Otwiera ciasteczko z wróżbą z opisem: ' .. msg[math.random(1, #msg)])
end)

-----------------------------------------------------------------------
-- Napoje

ESX.RegisterUsableItem('water', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('water', 1)
	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	--TriggerClientEvent('esx:showNotification', source, _U('used_water'))
end)

ESX.RegisterUsableItem('kawa', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('kawa', 1)
	TriggerClientEvent('esx_status:add', source, 'thirst', 215000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	--TriggerClientEvent('esx:showNotification', source, "Wypijasz kawę")
end)

ESX.RegisterUsableItem('sprunk', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('sprunk', 1)
	TriggerClientEvent('esx_status:add', source, 'thirst', 350000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	--TriggerClientEvent('esx:showNotification', source, "Wypijasz puszkę Sprunka")
end)

ESX.RegisterUsableItem('popcola', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)	
	xPlayer.removeInventoryItem('popcola', 1)
	TriggerClientEvent('esx_status:add', source, 'thirst', 350000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	--TriggerClientEvent('esx:showNotification', source, "Wypijasz puszkę Pop-coli")
end)


ESX.RegisterUsableItem('czekoladahot', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('czekoladahot', 1)
	TriggerClientEvent('esx_status:add', source, 'thirst', 285000)
	TriggerClientEvent('esx_basicneeds:onDrink', source,"prop_food_coffee")
	--TriggerClientEvent('esx:showNotification', source, "Popijasz gorącą czekoladę")
end)

-------------------------------------------------------------
-- Narkotyki

ESX.RegisterUsableItem('coke_pooch', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('coke_pooch', 1)
	TriggerClientEvent('esx_basicneeds:drug_effect', source, 'coke_pooch')
end)

ESX.RegisterUsableItem('weed_pooch', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('weed_pooch', 1)
	TriggerClientEvent('esx_basicneeds:drug_effect', source, 'weed_pooch')
end)

ESX.RegisterUsableItem('meth_pooch', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('meth_pooch', 1)
	TriggerClientEvent('esx_basicneeds:drug_effect', source, 'meth_pooch')
end)

ESX.RegisterUsableItem('lsd_pooch', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('lsd_pooch', 1)
	TriggerClientEvent('esx_basicneeds:drug_effect', source, 'lsd_pooch')
end)

ESX.RegisterUsableItem('heroina_pooch', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('heroina_pooch', 1)
	TriggerClientEvent('esx_basicneeds:drug_effect', source, 'heroina_pooch')
end)

ESX.RegisterUsableItem('armored_vest', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('armored_vest', 1)
	TriggerClientEvent('esx_basicneeds:onArmorUse', source)
end)

-------------------------------------------------------------------------
-- Inne

--KAMERA
ESX.RegisterUsableItem('movie_cam', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent("Cam:ToggleCam", source)
end)
--Mikrofon
ESX.RegisterUsableItem('hand_mic', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent("Mic:ToggleMic", source)
end)
--Mikrofon na patyku
ESX.RegisterUsableItem('boom_mic', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent("Mic:ToggleBMic", source)
end)

-------------------------------------------------------------------
-- Skrzynie z bronia
ESX.RegisterUsableItem('snscrate', function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	local xJob = xPlayer.getJob()
	if xJob.name == "dealergun" then
		xPlayer.removeInventoryItem('snscrate', 1)
		xPlayer.addInventoryItem('snscase', 10)
		TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Otworzyłeś skrzynię', lenght = 3000 })
	end
end)
ESX.RegisterUsableItem('pistolcrate', function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	local xJob = xPlayer.getJob()
	if xJob.name == "dealergun" then
		xPlayer.removeInventoryItem('pistolcrate', 1)
		xPlayer.addInventoryItem('pistolcase', 10)
		TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Otworzyłeś skrzynię', lenght = 3000 })
	end
end)
ESX.RegisterUsableItem('heavycrate', function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	local xJob = xPlayer.getJob()
	if xJob.name == "dealergun" then
		xPlayer.removeInventoryItem('heavycrate', 1)
		xPlayer.addInventoryItem('heavycase', 10)
		TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Otworzyłeś skrzynię', lenght = 3000 })
	end
end)
ESX.RegisterUsableItem('apcrate', function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	local xJob = xPlayer.getJob()
	if xJob.name == "dealergun" then
		xPlayer.removeInventoryItem('apcrate', 1)
		xPlayer.addInventoryItem('apcase', 10)
		TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Otworzyłeś skrzynię', lenght = 3000 })
	end
end)
ESX.RegisterUsableItem('deaglecrate', function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	local xJob = xPlayer.getJob()
	if xJob.name == "dealergun" then
		xPlayer.removeInventoryItem('deaglecrate', 1)
		xPlayer.addInventoryItem('deaglecase', 10)
		TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Otworzyłeś skrzynię', lenght = 3000 })
	end
end)
ESX.RegisterUsableItem('marksmancrate', function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	local xJob = xPlayer.getJob()
	if xJob.name == "dealergun" then
		xPlayer.removeInventoryItem('marksmancrate', 1)
		xPlayer.addInventoryItem('marksmancase', 10)
		TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Otworzyłeś skrzynię', lenght = 3000 })
	end
end)
ESX.RegisterUsableItem('vintagecrate', function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	local xJob = xPlayer.getJob()
	if xJob.name == "dealergun" then
		xPlayer.removeInventoryItem('vintagecrate', 1)
		xPlayer.addInventoryItem('vintagecase', 10)
		TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Otworzyłeś skrzynię', lenght = 3000 })
	end
end)
ESX.RegisterUsableItem('combatcrate', function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	local xJob = xPlayer.getJob()
	if xJob.name == "dealergun" then
		xPlayer.removeInventoryItem('combatcrate', 1)
		xPlayer.addInventoryItem('combatcase', 10)
		TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Otworzyłeś skrzynię', lenght = 3000 })
	end
end)
--Długie
ESX.RegisterUsableItem('uzicrate', function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	local xJob = xPlayer.getJob()
	if xJob.name == "dealergun" then
		xPlayer.removeInventoryItem('uzicrate', 1)
		xPlayer.addInventoryItem('uzicase', 10)
		TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Otworzyłeś skrzynię', lenght = 3000 })
	end
end)
ESX.RegisterUsableItem('teccrate', function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	local xJob = xPlayer.getJob()
	if xJob.name == "dealergun" then
		xPlayer.removeInventoryItem('teccrate', 1)
		xPlayer.addInventoryItem('teccrate', 10)
		TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Otworzyłeś skrzynię', lenght = 3000 })
	end
end)


-- Walizki z bronia
ESX.RegisterUsableItem('snscase', function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('snscase', 1)
		xPlayer.addWeapon('WEAPON_SNSPISTOL', 120)
		TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Otworzyłeś walizkę', lenght = 3000 })
end)
ESX.RegisterUsableItem('pistolcase', function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('pistolcase', 1)
		xPlayer.addWeapon('WEAPON_PISTOL', 120)
		TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Otworzyłeś walizkę', lenght = 3000 })
end)
ESX.RegisterUsableItem('heavycase', function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('heavycase', 1)
		xPlayer.addWeapon('WEAPON_HEAVYPISTOL', 120)
		TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Otworzyłeś walizkę', lenght = 3000 })
end)
ESX.RegisterUsableItem('apcase', function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('apcase', 1)
		xPlayer.addWeapon('WEAPON_APPISTOL', 120)
		TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Otworzyłeś walizkę', lenght = 3000 })
end)
ESX.RegisterUsableItem('deaglecase', function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('deaglecase', 1)
		xPlayer.addWeapon('WEAPON_PISTOL50', 120)
		TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Otworzyłeś walizkę', lenght = 3000 })
end)
ESX.RegisterUsableItem('marksmancase', function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('marksmancase', 1)
		xPlayer.addWeapon('WEAPON_MARKSMANPISTOL', 120)
		TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Otworzyłeś walizkę', lenght = 3000 })
end)
ESX.RegisterUsableItem('vintagecase', function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('vintagecase', 1)
		xPlayer.addWeapon('WEAPON_VINTAGEPISTOL', 120)
		TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Otworzyłeś walizkę', lenght = 3000 })
end)
ESX.RegisterUsableItem('combatcase', function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('combatcase', 1)
		xPlayer.addWeapon('WEAPON_COMBATPISTOL', 120)
		TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Otworzyłeś walizkę', lenght = 3000 })
end)
-- Długie
ESX.RegisterUsableItem('uzicase', function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('uzicase', 1)
		xPlayer.addWeapon('WEAPON_MICROSMG', 120)
		TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Otworzyłeś walizkę', lenght = 3000 })
end)
ESX.RegisterUsableItem('teccase', function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('teccase', 1)
		xPlayer.addWeapon('WEAPON_MACHINEPISTOL', 120)
		TriggerClientEvent('mythic_notify:client:SendJobAlert', source, { type = 'inform', text = 'Otworzyłeś walizkę', lenght = 3000 })
end)


------------ Sklepy
-- ButlaMAX
ESX.RegisterUsableItem('butlazgazem', function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('butlazgazem', 1)
	TriggerClientEvent('esx_basicneeds:butla', source)
end)


ESX.RegisterUsableItem('grill', function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('grill', 1)
	TriggerClientEvent('esx_basicneeds:grill', source)
end)

--[[
RegisterCommand("testgrill", function(source)
	TriggerClientEvent('esx_basicneeds:grill', source)
end, true)
]]