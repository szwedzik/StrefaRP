
ESX = nil


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('es:addCommand', 'e', function(source, args, user)
  local xPlayer = ESX.GetPlayerFromId(source)
  local xPJob = xPlayer.getJob()
  local zapalniczka = xPlayer.getInventoryItem("zapalniczka")
  local papieros = xPlayer.getInventoryItem("papierosy")
  TriggerClientEvent('esx_emotes:detachEntity', source)
  if args[1] == "o7" or args[1] == "salutuj" or args[1] == "salute" then
    TriggerClientEvent("esx_emotes:salute", xPlayer.source)
  elseif args[1] == "parasol" then
    TriggerClientEvent("esx_emotes:umbrella", xPlayer.source)
  --elseif args[1] == "kamera" then
   -- TriggerClientEvent("esx_emotes:cam", xPlayer.source)
  elseif args[1] == "notes" then
    TriggerClientEvent("esx_emotes:ticket", xPlayer.source)
  elseif args[1] == "facepalm" then
    TriggerClientEvent("esx_emotes:palm", xPlayer.source)
  elseif args[1] == "box" then
    TriggerClientEvent("esx_emotes:box", xPlayer.source)
  elseif args[1] == "fu" then
    TriggerClientEvent("esx_emotes:fu", xPlayer.source)
  elseif args[1] == "fu2" then
    TriggerClientEvent("esx_emotes:fu2", xPlayer.source)
  elseif args[1] == "siadaj" then
    TriggerClientEvent("esx_emotes:play", xPlayer.source, 1, "PROP_HUMAN_SEAT_CHAIR_UPRIGHT")
  elseif args[1] == "kawa" then
    -- TriggerClientEvent("esx_emotes:play", xPlayer.source, 0, "WORLD_HUMAN_AA_COFFEE")
    TriggerClientEvent("esx_emotes:kawa", source)
  elseif args[1] == "policjant" then
    TriggerClientEvent("esx_emotes:play", xPlayer.source, 0, "world_human_cop_idles")
  elseif args[1] == "ochroniarz" then
    TriggerClientEvent("esx_emotes:play", xPlayer.source, 0, "world_human_guard_stand")
  elseif args[1] == "party" then
    TriggerClientEvent("esx_emotes:play", xPlayer.source, 0, "WORLD_HUMAN_PARTYING")
  elseif args[1] == "medyk" then
    TriggerClientEvent("esx_emotes:play", xPlayer.source, 0, "CODE_HUMAN_MEDIC_KNEEL")
  elseif args[1] == "foto" then
    TriggerClientEvent("esx_emotes:play", xPlayer.source, 0, "WORLD_HUMAN_PAPARAZZI")
  elseif args[1] == "notatki" then
    TriggerClientEvent("esx_emotes:play", xPlayer.source, 0, "WORLD_HUMAN_CLIPBOARD")
  elseif args[1] == "panda" then
    TriggerClientEvent("esx_emotes:play", xPlayer.source, 0, "WORLD_HUMAN_BUM_FREEWAY")
  elseif args[1] == "statua" then
    TriggerClientEvent("esx_emotes:play", xPlayer.source, 0, "WORLD_HUMAN_HUMAN_STATUE")
  elseif args[1] == "oklaski" then
    TriggerClientEvent("esx_emotes:play", xPlayer.source, 0, "WORLD_HUMAN_CHEERING")
  elseif args[1] == "menel" then
    TriggerClientEvent("esx_emotes:play", xPlayer.source, 2, "WORLD_HUMAN_PICNIC")
  elseif args[1] == "oprzyj2" then
    TriggerClientEvent("esx_emotes:play", xPlayer.source, 0, "world_human_leaning")
  elseif args[1] == "lezenie" then
    TriggerClientEvent("esx_emotes:play", xPlayer.source, 2, "WORLD_HUMAN_SUNBATHE_BACK")
  elseif args[1] == "czyszczenie" then
    TriggerClientEvent("esx_emotes:play", xPlayer.source, 0, "world_human_maid_clean")
  elseif args[1] == "telefon" then
    TriggerClientEvent("esx_emotes:play", xPlayer.source, 0, "world_human_tourist_mobile")
  elseif args[1] == "mlotek" then
    TriggerClientEvent("esx_emotes:play", xPlayer.source, 0, "WORLD_HUMAN_HAMMERING")
  elseif args[1] == "filmuj" then
    TriggerClientEvent("esx_emotes:play", xPlayer.source, 0, "WORLD_HUMAN_MOBILE_FILM_SHOCKING")
  elseif args[1] == "jogging" then
    TriggerClientEvent("esx_emotes:play", xPlayer.source, 0, "WORLD_HUMAN_JOG_STANDING")
  elseif args[1] == "najebany" then
    TriggerClientEvent("esx_emotes:play", xPlayer.source, 0, "WORLD_HUMAN_BUM_SLUMPED")
  elseif args[1] == "mapa" then
    TriggerClientEvent("esx_emotes:play", xPlayer.source, 0, "WORLD_HUMAN_TOURIST_MAP")
  elseif args[1] == "narzedzia" then
    TriggerClientEvent("esx_emotes:toolbox", source)
  elseif args[1] == "narzedzia2" then
    TriggerClientEvent("esx_emotes:toolbox2", source)
  elseif args[1] == "narzedzia3" then
    TriggerClientEvent("esx_emotes:toolbox3", source)
  elseif args[1] == "bagaz" then
    TriggerClientEvent("esx_emotes:suitcase", source)
  elseif args[1] == "wiertarka" then
    TriggerClientEvent("esx_emotes:wiertarka", source)
  elseif args[1] == "klucz" then
    TriggerClientEvent("esx_emotes:klucz", source)
  elseif args[1] == "walizka" then
    TriggerClientEvent("esx_emotes:walizka", source)
  elseif args[1] == "walizka2" then
    TriggerClientEvent("esx_emotes:walizka2", source)
  elseif args[1] == "siku" then
    TriggerClientEvent("esx_emotes:siku", source)
  elseif args[1] == "modlitwa" then
    TriggerClientEvent("esx_emotes:modlitwa", source)
  elseif args[1] == "modlitwa2" then
    TriggerClientEvent("esx_emotes:modlitwa2", source)
  elseif args[1] == "oprzyj" then
  TriggerClientEvent("esx_emotes:oprzyj", source)
	elseif args[1] == "aku" then
    TriggerClientEvent("esx_emotes:aku", source)
	elseif args[1] == "drzwi" then
    TriggerClientEvent("esx_emotes:drzwi", source)
	elseif args[1] == "wydech" then
    TriggerClientEvent("esx_emotes:wydech", source)
	elseif args[1] == "pacholek" then
    TriggerClientEvent("esx_emotes:pacholek", source)
	elseif args[1] == "maska" then
    TriggerClientEvent("esx_emotes:maska", source)
	elseif args[1] == "pomoc" then
    TriggerClientEvent("esx_emotes:pomoc", source)
	elseif args[1] == "beczka" then
    TriggerClientEvent("esx_emotes:beczka", source)
	elseif args[1] == "metal" then
    TriggerClientEvent("esx_emotes:metal", source)
	elseif args[1] == "deska" then
    TriggerClientEvent("esx_emotes:deska", source)
	elseif args[1] == "fiolki" then
    TriggerClientEvent("esx_emotes:fiolki", source)
	elseif args[1] == "opona" then
    TriggerClientEvent("esx_emotes:opona", source)
	elseif args[1] == "zderzak" then
    TriggerClientEvent("esx_emotes:zderzak", source)
	elseif args[1] == "tarcza" then
    TriggerClientEvent("esx_emotes:tarcza", source)
	elseif args[1] == "taniec1" then
    TriggerClientEvent("esx_emotes:taniec1", source)
	elseif args[1] == "taniec2" then
    TriggerClientEvent("esx_emotes:taniec2", source)
	elseif args[1] == "taniec3" then
    TriggerClientEvent("esx_emotes:taniec3", source)
	elseif args[1] == "taniec4" then
    TriggerClientEvent("esx_emotes:taniec4", source)
	elseif args[1] == "taniec5" then
    TriggerClientEvent("esx_emotes:taniec5", source)
	elseif args[1] == "taniec6" then
    TriggerClientEvent("esx_emotes:taniec6", source)
	elseif args[1] == "taniec7" then
    TriggerClientEvent("esx_emotes:taniec7", source)
	elseif args[1] == "taniec8" then
    TriggerClientEvent("esx_emotes:taniec8", source)
	elseif args[1] == "taniec9" then
    TriggerClientEvent("esx_emotes:taniec9", source)
	elseif args[1] == "taniec10" then
    TriggerClientEvent("esx_emotes:taniec10", source)
	elseif args[1] == "taniec11" then
    TriggerClientEvent("esx_emotes:taniec11", source)
	elseif args[1] == "taniec12" then
    TriggerClientEvent("esx_emotes:taniec12", source)
	elseif args[1] == "taniec13" then
    TriggerClientEvent("esx_emotes:taniec13", source)
	elseif args[1] == "taniec14" then
    TriggerClientEvent("esx_emotes:taniec14", source)
	elseif args[1] == "taniec15" then
    TriggerClientEvent("esx_emotes:taniec15", source)
	elseif args[1] == "taniec16" then
    TriggerClientEvent("esx_emotes:taniec16", source)
	elseif args[1] == "taniec17" then
    TriggerClientEvent("esx_emotes:taniec17", source)
	elseif args[1] == "taniec18" then
    TriggerClientEvent("esx_emotes:taniec18", source)
	elseif args[1] == "taniec19" then
    TriggerClientEvent("esx_emotes:taniec19", source)
	elseif args[1] == "taniec20" then
    TriggerClientEvent("esx_emotes:taniec20", source)
	elseif args[1] == "taniec21" then
    TriggerClientEvent("esx_emotes:taniec21", source)
	elseif args[1] == "taniec22" then
    TriggerClientEvent("esx_emotes:taniec22", source)
	elseif args[1] == "taniec23" then
    TriggerClientEvent("esx_emotes:taniec23", source)
	elseif args[1] == "taniec24" then
    TriggerClientEvent("esx_emotes:taniec24", source)
	elseif args[1] == "taniec25" then
    TriggerClientEvent("esx_emotes:taniec25", source)
	elseif args[1] == "taniec26" then
    TriggerClientEvent("esx_emotes:taniec26", source)
	elseif args[1] == "taniec27" then
    TriggerClientEvent("esx_emotes:taniec27", source)
	elseif args[1] == "taniec28" then
    TriggerClientEvent("esx_emotes:taniec28", source)
	elseif args[1] == "taniec29" then
    TriggerClientEvent("esx_emotes:taniec29", source)
	elseif args[1] == "taniec30" then
    TriggerClientEvent("esx_emotes:taniec30", source)
	elseif args[1] == "taniec31" then
    TriggerClientEvent("esx_emotes:taniec31", source)
	elseif args[1] == "taniec32" then
    TriggerClientEvent("esx_emotes:taniec32", source)
	elseif args[1] == "taniec33" then
    TriggerClientEvent("esx_emotes:taniec33", source)
	elseif args[1] == "taniec34" then
    TriggerClientEvent("esx_emotes:taniec34", source)
	elseif args[1] == "taniec35" then
    TriggerClientEvent("esx_emotes:taniec35", source)
	elseif args[1] == "strach" then
    TriggerClientEvent("esx_emotes:strach", source)
	elseif args[1] == "wkrecanie" then
    TriggerClientEvent("esx_emotes:wkrecanie", source)
	elseif args[1] == "zul" then
    TriggerClientEvent("esx_emotes:zul", source)
	elseif args[1] == "pochyl" then
    TriggerClientEvent("esx_emotes:pochyl", source)
	elseif args[1] == "mechanik" then
    TriggerClientEvent("esx_emotes:mechanik", source)
	elseif args[1] == "szperanie" then
    TriggerClientEvent("esx_emotes:szperanie", source)
	elseif args[1] == "murek" then
    TriggerClientEvent("esx_emotes:murek", source)
		elseif args[1] == "buzi" then
    TriggerClientEvent("esx_emotes:buzi", source)
		elseif args[1] == "rozgrzewka" then
    TriggerClientEvent("esx_emotes:rozgrzewka", source)
		elseif args[1] == "tlumacz" then
    TriggerClientEvent("esx_emotes:tlumacz", source)
		elseif args[1] == "tam" then
    TriggerClientEvent("esx_emotes:tam", source)
		elseif args[1] == "podaj" then
    TriggerClientEvent("esx_emotes:podaj", source)
			elseif args[1] == "narka" then
    TriggerClientEvent("esx_emotes:narka", source)
			elseif args[1] == "spokoj" then
    TriggerClientEvent("esx_emotes:spokoj", source)
			elseif args[1] == "medytuj" then
    TriggerClientEvent("esx_emotes:medytuj", source)
			elseif args[1] == "wygrana" then
    TriggerClientEvent("esx_emotes:wygrana", source)
			elseif args[1] == "jaskolka" then
    TriggerClientEvent("esx_emotes:jaskolka", source)
	elseif args[1] == "dj2" then
    TriggerClientEvent("esx_emotes:dj2", source)
	elseif args[1] == "dj3" then
    TriggerClientEvent("esx_emotes:dj3", source)
	elseif args[1] == "zwariowany" then
    TriggerClientEvent("esx_emotes:zwariowany", source)
	elseif args[1] == "zwariowany2" then
    TriggerClientEvent("esx_emotes:zwariowany2", source)
	elseif args[1] == "zarowka" then
    TriggerClientEvent("esx_emotes:zarowka", source)
	elseif args[1] == "dlubanie" then
    TriggerClientEvent("esx_emotes:dlubanie", source)
	elseif args[1] == "dlubanie2" then
    TriggerClientEvent("esx_emotes:dlubanie2", source)
	elseif args[1] == "opieranie" then
    TriggerClientEvent("esx_emotes:opieranie", source)
	elseif args[1] == "opieranie2" then
    TriggerClientEvent("esx_emotes:opieranie2", source)
	elseif args[1] == "opieranie3" then
    TriggerClientEvent("esx_emotes:opieranie3", source)
	elseif args[1] == "opieranie4" then
    TriggerClientEvent("esx_emotes:opieranie4", source)
	elseif args[1] == "piesci" then
    TriggerClientEvent("esx_emotes:piesci", source)
	elseif args[1] == "siad" then
    TriggerClientEvent("esx_emotes:siad", source)
	elseif args[1] == "siad2" then
    TriggerClientEvent("esx_emotes:siad2", source)
	elseif args[1] == "tada" then
    TriggerClientEvent("esx_emotes:tada", source)
	elseif args[1] == "tada2" then
    TriggerClientEvent("esx_emotes:tada2", source)
	elseif args[1] == "wlala" then
    TriggerClientEvent("esx_emotes:wlala", source)
	elseif args[1] == "wlala2" then
    TriggerClientEvent("esx_emotes:wlala2", source)
	elseif args[1] == "kac" then
    TriggerClientEvent("esx_emotes:kac", source)
	elseif args[1] == "niestrzelaj" then
    TriggerClientEvent("esx_emotes:niestrzelaj", source)
	elseif args[1] == "bugi" then
    TriggerClientEvent("esx_emotes:bugi", source)
	elseif args[1] == "krolowa" then
    TriggerClientEvent("esx_emotes:krolowa", source)
	elseif args[1] == "sio" then
    TriggerClientEvent("esx_emotes:sio", source)
	elseif args[1] == "ruchanie" then
    TriggerClientEvent("esx_emotes:ruchanie", source)
	elseif args[1] == "ruchanie2" then
    TriggerClientEvent("esx_emotes:ruchanie2", source)
	elseif args[1] == "piano" then
    TriggerClientEvent("esx_emotes:piano", source)
	elseif args[1] == "piano2" then
    TriggerClientEvent("esx_emotes:piano2", source)
	elseif args[1] == "nice" then
    TriggerClientEvent("esx_emotes:nice", source)
	elseif args[1] == "pieniadze" then
    TriggerClientEvent("esx_emotes:pieniadze", source)
	elseif args[1] == "cicho" then
    TriggerClientEvent("esx_emotes:cicho", source)
	elseif args[1] == "otak" then
    TriggerClientEvent("esx_emotes:otak", source)
	elseif args[1] == "czekanie" then
    TriggerClientEvent("esx_emotes:czekanie", source)
	elseif args[1] == "czekanie2" then
    TriggerClientEvent("esx_emotes:czekanie2", source)
	elseif args[1] == "czekanie3" then
    TriggerClientEvent("esx_emotes:czekanie3", source)
	elseif args[1] == "czekanie4" then
    TriggerClientEvent("esx_emotes:czekanie4", source)
	elseif args[1] == "dojebalem" then
    TriggerClientEvent("esx_emotes:dojebalem", source)
	elseif args[1] == "dojebalem2" then
    TriggerClientEvent("esx_emotes:dojebalem2", source)
	elseif args[1] == "gitara" then
    TriggerClientEvent("esx_emotes:gitara", source)
	elseif args[1] == "gitara2" then
    TriggerClientEvent("esx_emotes:gitara2", source)
	elseif args[1] == "swietnie" then
    TriggerClientEvent("esx_emotes:swietnie", source)
	elseif args[1] == "swietnie2" then
    TriggerClientEvent("esx_emotes:swietnie2", source)
	elseif args[1] == "swietnie3" then
    TriggerClientEvent("esx_emotes:swietnie3", source)
	elseif args[1] == "swietnie4" then
    TriggerClientEvent("esx_emotes:swietnie4", source)
	elseif args[1] == "swietnie5" then
    TriggerClientEvent("esx_emotes:swietnie5", source)
	elseif args[1] == "idz" then
    TriggerClientEvent("esx_emotes:idz", source)
		elseif args[1] == "idz2" then
    TriggerClientEvent("esx_emotes:idz2", source)
		elseif args[1] == "czekanie4" then
    TriggerClientEvent("esx_emotes:czekanie4", source)
		elseif args[1] == "idz3" then
    TriggerClientEvent("esx_emotes:idz3", source)
		elseif args[1] == "idz4" then
    TriggerClientEvent("esx_emotes:idz4", source)
		elseif args[1] == "idz5" then
    TriggerClientEvent("esx_emotes:idz5", source)
	elseif args[1] == "sila" then
    TriggerClientEvent("esx_emotes:sila", source)
	elseif args[1] == "sila2" then
    TriggerClientEvent("esx_emotes:sila2", source)
	elseif args[1] == "hulk" then
    TriggerClientEvent("esx_emotes:hulk", source)
	elseif args[1] == "hulk2" then
    TriggerClientEvent("esx_emotes:hulk2", source)
	elseif args[1] == "hulk3" then
    TriggerClientEvent("esx_emotes:hulk3", source)
	elseif args[1] == "brawo" then
    TriggerClientEvent("esx_emotes:brawo", source)
	elseif args[1] == "racja" then
    TriggerClientEvent("esx_emotes:racja", source)
	elseif args[1] == "gleba" then
    TriggerClientEvent("esx_emotes:gleba", source)
	elseif args[1] == "rozwale" then
    TriggerClientEvent("esx_emotes:rozwale", source)
	elseif args[1] == "spierdalaj" then
    TriggerClientEvent("esx_emotes:spierdalaj", source)
	elseif args[1] == "spierdalaj2" then
    TriggerClientEvent("esx_emotes:spierdalaj2", source)
	elseif args[1] == "facepalm2" then
    TriggerClientEvent("esx_emotes:facepalm2", source)
	elseif args[1] == "lezenie2" then
    TriggerClientEvent("esx_emotes:lezenie2", source)
	elseif args[1] == "lezenie3" then
    TriggerClientEvent("esx_emotes:lezenie3", source)
	elseif args[1] == "lezenie4" then
    TriggerClientEvent("esx_emotes:lezenie4", source)
	elseif args[1] == "tam2" then
    TriggerClientEvent("esx_emotes:tam2", source)
	elseif args[1] == "naprawa2" then
    TriggerClientEvent("esx_emotes:naprawa2", source)
	elseif args[1] == "nana" then
    TriggerClientEvent("esx_emotes:nana", source)
	elseif args[1] == "nana2" then
    TriggerClientEvent("esx_emotes:nana2", source)
	elseif args[1] == "skok" then
    TriggerClientEvent("esx_emotes:skok", source)
	elseif args[1] == "skok2" then
    TriggerClientEvent("esx_emotes:skok2", source)
	elseif args[1] == "upadek" then
    TriggerClientEvent("esx_emotes:upadek", source)
	elseif args[1] == "cyce" then
    TriggerClientEvent("esx_emotes:cyce", source)
	elseif args[1] == "hej" then
    TriggerClientEvent("esx_emotes:hej", source)
	elseif args[1] == "udo" then
    TriggerClientEvent("esx_emotes:udo", source)
	elseif args[1] == "wynocha" then
    TriggerClientEvent("esx_emotes:wynocha", source)
	elseif args[1] == "zapraszam" then
    TriggerClientEvent("esx_emotes:zapraszam", source)
	elseif args[1] == "ocieranie" then
    TriggerClientEvent("esx_emotes:ocieranie", source)
	elseif args[1] == "ocieranie2" then
    TriggerClientEvent("esx_emotes:ocieranie2", source)
	elseif args[1] == "ocieranie3" then
    TriggerClientEvent("esx_emotes:ocieranie3", source)
	elseif args[1] == "tlumacz2" then
    TriggerClientEvent("esx_emotes:tlumacz2", source)
	elseif args[1] == "tlumacz3" then
    TriggerClientEvent("esx_emotes:tlumacz3", source)
	elseif args[1] == "buzi2" then
    TriggerClientEvent("esx_emotes:buzi2", source)
	elseif args[1] == "buzi3" then
    TriggerClientEvent("esx_emotes:buzi3", source)
	elseif args[1] == "szperanie2" then
    TriggerClientEvent("esx_emotes:szperanie2", source)
	elseif args[1] == "strach2" then
    TriggerClientEvent("esx_emotes:strach2", source)
	
	
	
	
  elseif args[1] == "fajka" then
    if zapalniczka.count == 0 then
      TriggerClientEvent('esx:showNotification', source, "Nie masz zapalniczki, nie odpalisz fajki.")
      return
    elseif papieros.count == 0 then
      TriggerClientEvent('esx:showNotification', source, "Co chcesz palić? Nie masz fajek.")
      return
    else
      xPlayer.removeInventoryItem("papierosy",1)
      TriggerClientEvent("esx_emotes:play", xPlayer.source, 0, "WORLD_HUMAN_SMOKING")
    end
  else
    TriggerClientEvent("esx_emotes:play", xPlayer.source, 0, args[1])
  end
  if args[1] == nil then
    TriggerClientEvent('chatMessage', source, "Popularne:", {200,0,0} , "/siadaj/fajka/kawan/narzedzia[1-3]/bagaz/walizka[1-2]/wiertarka/mapa/mlotek/notatki  \nPełną listę animacji znajdziesz na stronie miasta.")
  end
end)