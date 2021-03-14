-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Czas generowania: 28 Lip 2019, 19:40
-- Wersja serwera: 8.0.16
-- Wersja PHP: 7.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `os`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `items`
--

CREATE TABLE `items` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `limit` int(11) NOT NULL DEFAULT '-1',
  `rare` int(11) NOT NULL DEFAULT '0',
  `can_remove` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Zrzut danych tabeli `items`
--

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
('alive_chicken', 'Zywy Kurczak', 6, 0, 1),
('armored_vest', 'Kamizelka Kuloodporna', 1, 0, 1),
('bandage', 'Bandaż', 15, 0, 1),
('beer', 'Piwo', 10, 0, 1),
('blackberry', 'Telefon', 10, 0, 1),
('blowpipe', 'Wytrych', 6, 0, 1),
('bread', 'Chleb', 20, 0, 1),
('burrito', 'Burrito z kurczakiem', 15, 0, 1),
('carokit', 'Kit carosserie', -1, 0, 1),
('carotool', 'CarTool', -1, 0, 1),
('ciastkozwrozba', 'Ciastko z wróżbą', 25, 0, 1),
('clean_chicken', 'Umyty Kurczak', 6, 0, 1),
('clean_raisin', 'Czyste Winogrono', 100, 0, 1),
('clothe', 'cloth', -1, 0, 1),
('coke_pooch', 'Kokaina', -1, 0, 1),
('copper', 'copper', -1, 0, 1),
('cutted_wood', 'cut wood', -1, 0, 1),
('czekoladahot', 'Gorąca czekolada', 10, 0, 1),
('diamond', 'diamond', -1, 0, 1),
('dice', 'Kość do gry', 10, 0, 1),
('donut', 'Pączek', 8, 0, 1),
('dopamine', 'Dopamina', 5, 0, 1),
('drill', 'Wiertło', 1, 0, 1),
('essence', 'gas', -1, 0, 1),
('fabric', 'fabric', -1, 0, 1),
('fentanyl', 'Fentanyl', 5, 0, 1),
('firstaid', 'Apteczka Pierwszej Pomocy', 10, 0, 1),
('fish', 'Ryba', 5, 0, 1),
('fishingbait', 'Przyneta', 100, 0, 1),
('fixkit', 'Zestaw naprawczy', 4, 0, 1),
('fixtool', 'FixTool', -1, 0, 1),
('gauze', 'Gaza', 15, 0, 1),
('gazbottle', 'Kanister', -1, 0, 1),
('gold', 'gold', -1, 0, 1),
('grand_cru', 'Butelka Dojrzałego Wina', -1, 0, 1),
('hamburger', 'Hamburger', 10, 0, 1),
('handcuffs', 'Kajdanki', 4, 0, 1),
('hotdog', 'Hotdog', 12, 0, 1),
('iron', 'iron', -1, 0, 1),
('jewels', 'Biżuteria', 50, 0, 1),
('jumelles', 'Lornetka', 2, 0, 1),
('jus_raisin', 'Sok Winogronowy', 20, 0, 1),
('kawa', 'Kawa', 10, 0, 1),
('kebab', 'Kebab', 10, 0, 1),
('keycard1', 'Karta magnetyczna', -1, 0, 1),
('keycard2', 'Karta magnetyczna', -1, 0, 1),
('keycard3', 'Karta magnetyczna', -1, 0, 1),
('keycard4', 'Karta magnetyczna', -1, 0, 1),
('keycard5', 'Karta magnetyczna', -1, 0, 1),
('keycard6', 'Karta magnetyczna', -1, 0, 1),
('keycard7', 'Karta magnetyczna', -1, 0, 1),
('medikit', 'Defibrylator', 10, 0, 1),
('medkit', 'Apteczka', 10, 0, 1),
('meth_pooch', 'Metamfetamina', -1, 0, 1),
('morphine', 'Morfina', 2, 0, 1),
('notepad', 'Notes', 1, 0, 1),
('opium_pooch', 'Opium', -1, 0, 1),
('packaged_cannabis', 'Paczka Marihuany', 5, 0, 1),
('packaged_chicken', 'Zapakowany Kurczak', 6, 0, 1),
('packaged_plank', 'packaged wood', -1, 0, 1),
('papierosy', 'Papierosy', 20, 0, 1),
('petrol', 'oil', -1, 0, 1),
('petrol_raffin', 'processed oil', -1, 0, 1),
('phone', 'Telefon', 5, 0, 1),
('polfixkit', 'Policyjny zestaw naprawczy', 5, 0, 1),
('popcola', 'Popcola', 10, 0, 1),
('radio', 'Radio', 1, 0, 1),
('raisin', 'Kisc Winogron', 100, 0, 1),
('relanium', 'Relanium', 5, 0, 1),
('rod', 'Wedka', 1, 0, 1),
('sajgonki', 'Sajgonki', 15, 0, 1),
('slaughtered_chicken', 'Zabity Kurczak', 6, 0, 1),
('sprunk', 'Sprunk', 10, 0, 1),
('stone', 'stone', -1, 0, 1),
('sushi', 'Sushi', 15, 0, 1),
('vine', 'Butelka Wina', 10, 0, 1),
('vodka', 'Wódka', 10, 0, 1),
('washed_stone', 'washed stone', -1, 0, 1),
('water', 'Woda', 20, 0, 1),
('weed_pooch', 'Marihuana', 56, 0, 1),
('whool', 'wool', -1, 0, 1),
('wine', 'Wino', 10, 0, 1),
('wood', 'wood', -1, 0, 1),
('zapalniczka', 'Zapalniczka', 2, 0, 1),
('zdrapka', 'Zdrapka', 10, 0, 1);

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`name`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
