-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2026. Jan 08. 21:02
-- Kiszolgáló verziója: 10.4.28-MariaDB
-- PHP verzió: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `natour_`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `ertekelesek`
--

CREATE TABLE `ertekelesek` (
  `id` int(11) NOT NULL,
  `felhasznalo_id` int(11) NOT NULL,
  `program_id` int(11) DEFAULT NULL,
  `nyitott_program_id` int(11) DEFAULT NULL,
  `ertekeles` int(11) DEFAULT NULL CHECK (`ertekeles` >= 1 and `ertekeles` <= 5),
  `megjegyzes` text DEFAULT NULL,
  `datum` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `ertekelesek`
--

INSERT INTO `ertekelesek` (`id`, `felhasznalo_id`, `program_id`, `nyitott_program_id`, `ertekeles`, `megjegyzes`, `datum`) VALUES
(1, 1, 1, NULL, 5, 'Nagyon jó volt a túravezető, mindent megmagyarázott!', '2024-05-16 16:30:00'),
(2, 3, 1, NULL, 4, 'Jó program, kicsit nehéz volt a végén.', '2024-05-17 18:15:00'),
(3, 1, 3, NULL, 5, 'Tökéletes családi program, a gyerekek is imádták!', '2024-05-18 12:45:00'),
(4, 5, 5, NULL, 3, 'A fényképezési lehetőségek korlátozottak voltak.', '2024-05-19 10:30:00'),
(5, 1, NULL, 1, 5, 'Ingyenes programra kiváló volt!', '2024-05-20 08:00:00'),
(6, 3, NULL, 3, 4, 'Jóga a természetben - felszabadító élmény.', '2024-05-21 14:45:00');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `felhasznalok`
--

CREATE TABLE `felhasznalok` (
  `id` int(11) NOT NULL,
  `felhasznalonev` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `jelszo` varchar(255) NOT NULL,
  `teljes_nev` varchar(100) DEFAULT NULL,
  `reg_datum` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `felhasznalok`
--

INSERT INTO `felhasznalok` (`id`, `felhasznalonev`, `email`, `jelszo`, `teljes_nev`, `reg_datum`) VALUES
(1, 'janos_turista', 'janos@email.hu', '$2b$10$1234567890abcdefghijklmnopqrstuv', 'Kovács János', '2024-01-15 09:30:00'),
(2, 'anna_vezeto', 'anna@tura.hu', '$2b$10$1234567890abcdefghijklmnopqrstuv', 'Nagy Anna', '2024-01-20 13:45:00'),
(3, 'gabor_wanderer', 'gabor@email.hu', '$2b$10$1234567890abcdefghijklmnopqrstuv', 'Szabó Gábor', '2024-02-05 08:15:00'),
(4, 'eva_hiker', 'eva@email.hu', '$2b$10$1234567890abcdefghijklmnopqrstuv', 'Tóth Éva', '2024-02-10 15:20:00'),
(5, 'admin', 'admin@turaportal.hu', '$2b$10$1234567890abcdefghijklmnopqrstuv', 'Adminisztrátor', '2024-01-01 07:00:00'),
(7, 'screenshot_teszt', 'screenshot@teszt.hu', 'jelszo123', 'Screenshot Teszt User', NULL),
(9, 'sequelize_teszt', 'sequelize@teszt.hu', 'jelszo123', 'Sequelize Screenshot', '2026-01-08 19:14:05');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `foglalasok`
--

CREATE TABLE `foglalasok` (
  `id` int(11) NOT NULL,
  `felhasznalo_id` int(11) NOT NULL,
  `program_id` int(11) NOT NULL,
  `foglalas_datum` timestamp NOT NULL DEFAULT current_timestamp(),
  `resztvevok_szama` int(11) DEFAULT 1,
  `statusz` varchar(20) DEFAULT 'fuggo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `foglalasok`
--

INSERT INTO `foglalasok` (`id`, `felhasznalo_id`, `program_id`, `foglalas_datum`, `resztvevok_szama`, `statusz`) VALUES
(1, 1, 1, '2024-05-10 12:30:00', 2, 'megerositett'),
(2, 1, 2, '2024-05-11 08:15:00', 1, 'fuggo'),
(3, 3, 1, '2024-05-12 07:45:00', 1, 'megerositett'),
(4, 3, 3, '2024-05-13 14:20:00', 3, 'megerositett'),
(5, 5, 4, '2024-05-14 09:00:00', 2, 'lemondott'),
(6, 1, 5, '2024-05-15 11:30:00', 1, 'megerositett');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `nyitott_programok`
--

CREATE TABLE `nyitott_programok` (
  `id` int(11) NOT NULL,
  `cim` varchar(200) NOT NULL,
  `leiras` text DEFAULT NULL,
  `helyszin` varchar(100) DEFAULT NULL,
  `datum` date NOT NULL,
  `idopont` time NOT NULL,
  `turavezeto_id` int(11) DEFAULT NULL,
  `aktiv` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `nyitott_programok`
--

INSERT INTO `nyitott_programok` (`id`, `cim`, `leiras`, `helyszin`, `datum`, `idopont`, `turavezeto_id`, `aktiv`) VALUES
(1, 'Budapesti sétatúra a várnegyedben', 'Fél napos sétatúra a történelmi belvárosban, magyarázattal.', 'Budapest', '2024-06-10', '15:00:00', 1, 1),
(2, 'Reggeli futókör a Margit-szigeten', 'Könnyű futás mindenki számára, edző vezetésével.', 'Budapest', '2024-06-12', '07:00:00', NULL, 1),
(3, 'Erdei jóga és meditáció', 'Friss levegőn, a természet közepén. Bringa matracot!', 'Normafa', '2024-06-18', '17:30:00', 2, 1),
(4, 'Csillagtúra a Zebegényi kilátónál', 'Sötétedés után csillagászati előadással.', 'Zebegény', '2024-07-20', '21:00:00', 1, 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `programok`
--

CREATE TABLE `programok` (
  `id` int(11) NOT NULL,
  `cim` varchar(200) NOT NULL,
  `leiras` text DEFAULT NULL,
  `helyszin` varchar(100) DEFAULT NULL,
  `datum` date NOT NULL,
  `idopont` time NOT NULL,
  `max_fo` int(11) NOT NULL DEFAULT 10,
  `jelenlegi_fo` int(11) DEFAULT 0,
  `ar` int(11) NOT NULL,
  `turavezeto_id` int(11) DEFAULT NULL,
  `aktiv` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `programok`
--

INSERT INTO `programok` (`id`, `cim`, `leiras`, `helyszin`, `datum`, `idopont`, `max_fo`, `jelenlegi_fo`, `ar`, `turavezeto_id`, `aktiv`) VALUES
(1, 'Kéktúra I. szakasz', 'A Kéktúra legszebb szakasza a Nagy-Hideg-hegytől a Nagy-Szénéig. Könnyű túra kezdőknek.', 'Budai-hegység', '2024-06-15', '09:00:00', 10, 3, 5000, 1, 1),
(2, 'Napfelkelte a Magas-Tátrában', 'Kora reggeli felkelés, majd felvonóval a Lomnic-csúcsra. Gyönyörű panoráma garantált!', 'Magas-Tátra', '2024-06-20', '05:00:00', 8, 1, 7500, 1, 1),
(3, 'Őszi erdei túra a Pilisben', 'Színes őszi erdőkben sétálunk, gombászkodunk. Családoknak is ajánlott.', 'Pilis', '2024-10-10', '10:00:00', 15, 3, 3000, 2, 1),
(4, 'Téli síalapozó', 'Téli kondicionálás, sítechnika gyakorlás a sípályán. Felszerelés biztosítva.', 'Matra', '2024-12-15', '08:30:00', 12, 0, 6000, 1, 1),
(5, 'Fényképezős túra a Balaton-felvidéken', 'Fotósoknak ajánlott, a legjobb naplemente pontokat fedezzük fel.', 'Balaton-felvidék', '2024-07-05', '16:00:00', 6, 1, 4500, 2, 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `program_kategoria`
--

CREATE TABLE `program_kategoria` (
  `id` int(11) NOT NULL,
  `program_id` int(11) NOT NULL,
  `kategoria_nev` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `program_kategoria`
--

INSERT INTO `program_kategoria` (`id`, `program_id`, `kategoria_nev`) VALUES
(1, 1, 'hegyi túra'),
(2, 1, 'kezdő túra'),
(3, 2, 'hegyi túra'),
(4, 2, 'napfelkelte'),
(5, 2, 'haladó'),
(6, 3, 'családos'),
(7, 3, 'őszi'),
(8, 3, 'természetjárás'),
(9, 4, 'téli sport'),
(10, 4, 'edzés'),
(11, 5, 'fotózás'),
(12, 5, 'naplemente'),
(13, 5, 'kulturális');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `turavezetok`
--

CREATE TABLE `turavezetok` (
  `id` int(11) NOT NULL,
  `nev` varchar(100) NOT NULL,
  `telefonszam` varchar(20) DEFAULT NULL,
  `minosites` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `turavezetok`
--

INSERT INTO `turavezetok` (`id`, `nev`, `telefonszam`, `minosites`) VALUES
(1, 'Nagy Anna', '+36 30 123 4567', '10+ év tapasztalat hegymászásban, mentőtanfolyam végzett'),
(2, 'Tóth Éva', '+36 20 987 6543', 'Természetjáró vezető, botanikus szakirányú végzettség');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `ertekelesek`
--
ALTER TABLE `ertekelesek`
  ADD PRIMARY KEY (`id`),
  ADD KEY `felhasznalo_id` (`felhasznalo_id`),
  ADD KEY `program_id` (`program_id`),
  ADD KEY `nyitott_program_id` (`nyitott_program_id`);

--
-- A tábla indexei `felhasznalok`
--
ALTER TABLE `felhasznalok`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `email_2` (`email`),
  ADD UNIQUE KEY `email_3` (`email`),
  ADD UNIQUE KEY `email_4` (`email`),
  ADD UNIQUE KEY `email_5` (`email`),
  ADD UNIQUE KEY `email_6` (`email`),
  ADD UNIQUE KEY `email_7` (`email`),
  ADD UNIQUE KEY `email_8` (`email`),
  ADD UNIQUE KEY `email_9` (`email`),
  ADD UNIQUE KEY `email_10` (`email`),
  ADD UNIQUE KEY `email_11` (`email`);

--
-- A tábla indexei `foglalasok`
--
ALTER TABLE `foglalasok`
  ADD PRIMARY KEY (`id`),
  ADD KEY `felhasznalo_id` (`felhasznalo_id`),
  ADD KEY `program_id` (`program_id`);

--
-- A tábla indexei `nyitott_programok`
--
ALTER TABLE `nyitott_programok`
  ADD PRIMARY KEY (`id`),
  ADD KEY `turavezeto_id` (`turavezeto_id`);

--
-- A tábla indexei `programok`
--
ALTER TABLE `programok`
  ADD PRIMARY KEY (`id`),
  ADD KEY `turavezeto_id` (`turavezeto_id`);

--
-- A tábla indexei `program_kategoria`
--
ALTER TABLE `program_kategoria`
  ADD PRIMARY KEY (`id`),
  ADD KEY `program_id` (`program_id`);

--
-- A tábla indexei `turavezetok`
--
ALTER TABLE `turavezetok`
  ADD PRIMARY KEY (`id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `ertekelesek`
--
ALTER TABLE `ertekelesek`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT a táblához `felhasznalok`
--
ALTER TABLE `felhasznalok`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT a táblához `foglalasok`
--
ALTER TABLE `foglalasok`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT a táblához `nyitott_programok`
--
ALTER TABLE `nyitott_programok`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `programok`
--
ALTER TABLE `programok`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT a táblához `program_kategoria`
--
ALTER TABLE `program_kategoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT a táblához `turavezetok`
--
ALTER TABLE `turavezetok`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `ertekelesek`
--
ALTER TABLE `ertekelesek`
  ADD CONSTRAINT `ertekelesek_ibfk_1` FOREIGN KEY (`felhasznalo_id`) REFERENCES `felhasznalok` (`id`),
  ADD CONSTRAINT `ertekelesek_ibfk_2` FOREIGN KEY (`program_id`) REFERENCES `programok` (`id`),
  ADD CONSTRAINT `ertekelesek_ibfk_3` FOREIGN KEY (`nyitott_program_id`) REFERENCES `nyitott_programok` (`id`);

--
-- Megkötések a táblához `foglalasok`
--
ALTER TABLE `foglalasok`
  ADD CONSTRAINT `foglalasok_ibfk_2` FOREIGN KEY (`program_id`) REFERENCES `programok` (`id`);

--
-- Megkötések a táblához `nyitott_programok`
--
ALTER TABLE `nyitott_programok`
  ADD CONSTRAINT `nyitott_programok_ibfk_1` FOREIGN KEY (`turavezeto_id`) REFERENCES `turavezetok` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Megkötések a táblához `programok`
--
ALTER TABLE `programok`
  ADD CONSTRAINT `programok_ibfk_1` FOREIGN KEY (`turavezeto_id`) REFERENCES `turavezetok` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Megkötések a táblához `program_kategoria`
--
ALTER TABLE `program_kategoria`
  ADD CONSTRAINT `program_kategoria_ibfk_1` FOREIGN KEY (`program_id`) REFERENCES `programok` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
