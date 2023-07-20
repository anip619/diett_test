-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 07, 2023 at 05:55 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `diet`
--

-- --------------------------------------------------------

--
-- Table structure for table `Meal`
--

CREATE TABLE `Meal` (
  `meal_auto_id` int(11) NOT NULL,
  `mealID` varchar(200) NOT NULL,
  `mealTitle` varchar(200) NOT NULL,
  `CategoryID` varchar(200) NOT NULL,
  `pictureCode` varchar(200) NOT NULL,
  `Description` varchar(200) NOT NULL,
  `foodCalorie` varchar(200) NOT NULL,
  `UserID` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Meal`
--

INSERT INTO `Meal` (`meal_auto_id`, `mealID`, `mealTitle`, `CategoryID`, `pictureCode`, `Description`, `foodCalorie`, `UserID`) VALUES
(3, '647fec790f2c1', 'ccc', 'Breakfast', '647fec790f2dc-1686105209.jpg', 'dscds', '12', '646c374a3f97f'),
(4, '647fec9e9de38', 'ccc', 'Breakfast', '647fec9e9de40-1686105246.jpg', 'dscds', '12', '646c374a3f97f'),
(5, '647fecba44f4c', 'ccc', 'Lunch', '647fecba44f59-1686105274.jpg', 'dscds', '12', '646c374a3f97f'),
(6, '647fed2731266', 'ccc', 'Dinner', '647fed2731270-1686105383.jpg', 'dscds', '12', '646c374a3f97f'),
(7, '647fed48b421d', 'ccc', 'Hi-tea', '647fed48b422d-1686105416.jpg', 'dscds', '12', '646c374a3f97f');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Meal`
--
ALTER TABLE `Meal`
  ADD PRIMARY KEY (`meal_auto_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Meal`
--
ALTER TABLE `Meal`
  MODIFY `meal_auto_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
