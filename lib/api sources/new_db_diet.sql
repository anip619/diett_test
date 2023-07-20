-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 07, 2023 at 05:39 AM
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
-- Table structure for table `calculateBMI`
--

CREATE TABLE `calculateBMI` (
  `id_bmiauto` int(11) NOT NULL,
  `UserID` varchar(200) NOT NULL,
  `bmiID` varchar(200) NOT NULL,
  `bmiWeight` varchar(200) NOT NULL,
  `bmiHeight` varchar(200) NOT NULL,
  `bmiDate` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `calculateBMI`
--

INSERT INTO `calculateBMI` (`id_bmiauto`, `UserID`, `bmiID`, `bmiWeight`, `bmiHeight`, `bmiDate`) VALUES
(1, 'x646c374a3f97f', '646c37oikjuh8', '90', '173', '2023-05-23 06:30:44'),
(2, 'x646c374a3f97f', '646c73ba7c3b1', '100', '69', '2023-05-23 08:05:14'),
(3, '646c374a3f97f', '646c74bdd1a8f', '80', '173', '2023-05-23 08:09:33');

-- --------------------------------------------------------

--
-- Table structure for table `calculateBMR`
--

CREATE TABLE `calculateBMR` (
  `id_bmrauto` int(11) NOT NULL,
  `UserID` varchar(200) NOT NULL,
  `bmrID` varchar(200) NOT NULL,
  `bmrWeight` varchar(200) NOT NULL,
  `bmrHeight` varchar(200) NOT NULL,
  `bmrAge` varchar(200) NOT NULL,
  `bmrSex` varchar(200) NOT NULL,
  `bmrDate` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `calculateBMR`
--

INSERT INTO `calculateBMR` (`id_bmrauto`, `UserID`, `bmrID`, `bmrWeight`, `bmrHeight`, `bmrAge`, `bmrSex`, `bmrDate`) VALUES
(1, '646c374a3f97f', '646cba45afc2b', '90', '172', '21', '1', '2023-05-23 13:06:13'),
(2, '646c374a3f97f', '646cbba2b94a4', '100', '175', '32', '2', '2023-05-23 13:12:02');

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

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE `Users` (
  `user_idauto` int(11) NOT NULL,
  `UserID` varchar(200) NOT NULL,
  `Name` varchar(200) NOT NULL,
  `UserEmail` varchar(200) NOT NULL,
  `UserName` varchar(200) NOT NULL,
  `UserPassword` varchar(200) NOT NULL,
  `UserDatatype` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Users`
--

INSERT INTO `Users` (`user_idauto`, `UserID`, `Name`, `UserEmail`, `UserName`, `UserPassword`, `UserDatatype`) VALUES
(3, '646c374a3f97f', 'sulaiman bin jaafar', 'sulaimana@gmail.com', 'sulaiman', '0000000000', '1');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `calculateBMI`
--
ALTER TABLE `calculateBMI`
  ADD PRIMARY KEY (`id_bmiauto`);

--
-- Indexes for table `calculateBMR`
--
ALTER TABLE `calculateBMR`
  ADD PRIMARY KEY (`id_bmrauto`);

--
-- Indexes for table `Meal`
--
ALTER TABLE `Meal`
  ADD PRIMARY KEY (`meal_auto_id`);

--
-- Indexes for table `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`user_idauto`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `calculateBMI`
--
ALTER TABLE `calculateBMI`
  MODIFY `id_bmiauto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `calculateBMR`
--
ALTER TABLE `calculateBMR`
  MODIFY `id_bmrauto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Meal`
--
ALTER TABLE `Meal`
  MODIFY `meal_auto_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `Users`
--
ALTER TABLE `Users`
  MODIFY `user_idauto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
