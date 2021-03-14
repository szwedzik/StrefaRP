-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 27, 2019 at 12:20 PM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 7.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `test`
--

-- --------------------------------------------------------

--
-- Table structure for table `srp_businesses`
--

CREATE TABLE `srp_businesses` (
  `id` int(255) NOT NULL,
  `biztype` varchar(255) DEFAULT NULL COMMENT 'Typ biznesu (1/2/3)',
  `name` varchar(255) DEFAULT NULL,
  `owner` varchar(255) DEFAULT NULL,
  `price` varchar(255) DEFAULT NULL,
  `x` varchar(255) DEFAULT NULL,
  `y` varchar(255) DEFAULT NULL,
  `z` varchar(255) DEFAULT NULL,
  `interior` varchar(255) DEFAULT NULL,
  `marker` varchar(255) DEFAULT NULL,
  `owner_zone` varchar(255) DEFAULT NULL,
  `locker_zone` varchar(255) DEFAULT NULL,
  `garage_zone` varchar(255) DEFAULT NULL,
  `doors` int(255) NOT NULL DEFAULT '1' COMMENT 'Zamki w drzwiach (0 otwarte / 1 zamkniete)',
  `state` int(10) NOT NULL DEFAULT '0' COMMENT '0/1/2 (0 nikogo/1kupione/2wynajete)',
  `creation_date` datetime DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `modified_by` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `srp_businesses`
--

INSERT INTO `srp_businesses` (`id`, `biztype`, `name`, `owner`, `price`, `x`, `y`, `z`, `interior`, `marker`, `owner_zone`, `locker_zone`, `garage_zone`, `doors`, `state`, `creation_date`, `last_modified`, `modified_by`) VALUES
(1, NULL, 'Apartament', 'steam:11000010c93901b', '255000', '-115.94066619873047', '-605.058837890625', '36.280704498291016', '1', NULL, NULL, NULL, NULL, 0, 2, '2019-07-19 02:19:57', '2019-07-25 05:28:59', 'Ezi | StrefaRP.pl');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `srp_businesses`
--
ALTER TABLE `srp_businesses`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `srp_businesses`
--
ALTER TABLE `srp_businesses`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
