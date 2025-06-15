-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 15, 2025 at 03:03 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fyp`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL,
  `admin_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `admin_name`, `email`, `password`) VALUES
(1, 'abu', 'abu@gmail.com', '1234');

-- --------------------------------------------------------

--
-- Table structure for table `advisor`
--

CREATE TABLE `advisor` (
  `advisor_name` varchar(100) NOT NULL,
  `email` varchar(25) NOT NULL,
  `advisor_id` varchar(50) NOT NULL,
  `password` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `advisor`
--

INSERT INTO `advisor` (`advisor_name`, `email`, `advisor_id`, `password`) VALUES
('ammar', 'ammrif@gmail.com', 'AD0001', '12345'),
('sarah', 'sarah@gmail.com', 'AD0005', '1234'),
('mikhail', 'mkhlhssn@gmail.com', 'AD0111', '123'),
('farhad', 'farhad@gmail.com', 'AD1234', '12345');

-- --------------------------------------------------------

--
-- Table structure for table `advisor_student`
--

CREATE TABLE `advisor_student` (
  `id` int(11) NOT NULL,
  `advisor_id` varchar(50) DEFAULT NULL,
  `student_id` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `advisor_student`
--

INSERT INTO `advisor_student` (`id`, `advisor_id`, `student_id`) VALUES
(2, 'AD0001', 'DC0002'),
(3, 'AD1234', 'DC12345'),
(4, 'AD0001', 'DC98778'),
(5, 'AD0111', 'DC123456'),
(6, 'AD0111', 'DC98788');

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `id` int(11) NOT NULL,
  `student_name` varchar(100) NOT NULL,
  `student_id` varchar(50) NOT NULL,
  `advisor_id` varchar(50) NOT NULL,
  `advisor_name` varchar(100) NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` time NOT NULL,
  `status` enum('pending','done') DEFAULT 'pending',
  `notes` text DEFAULT NULL,
  `meeting_count` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`id`, `student_name`, `student_id`, `advisor_id`, `advisor_name`, `appointment_date`, `appointment_time`, `status`, `notes`, `meeting_count`) VALUES
(45, 'mikhail', 'DC0002', 'AD0001', 'ammar', '2025-01-13', '11:00:00', 'done', 'cina babi', 0),
(46, 'hakim', 'DC98778', 'AD0001', 'ammar', '2025-01-13', '11:00:00', 'done', 'test', 0),
(52, 'ammar', 'DC12345', 'AD1234', 'farhad', '2025-01-12', '03:26:00', 'done', 'test12', 0),
(53, 'haikal', 'DC123456', 'AD0111', 'mikhail', '2025-01-13', '10:00:00', 'done', 'test', 0),
(54, 'haikal', 'DC123456', 'AD0111', 'mikhail', '2025-01-14', '03:35:00', 'done', NULL, 0),
(55, 'haikal', 'DC123456', 'AD0111', 'mikhail', '2025-01-13', '15:40:00', 'done', NULL, 0),
(56, 'haikal', 'DC123456', 'AD0111', 'mikhail', '2025-01-14', '03:42:00', 'done', NULL, 0),
(57, 'haikal', 'DC123456', 'AD0111', 'mikhail', '2025-01-13', '04:42:00', 'done', NULL, 0),
(58, 'sarah', 'DC98788', 'AD0111', 'mikhail', '2025-01-14', '15:47:00', 'done', 'test', 0),
(59, 'sarah', 'DC98788', 'AD0111', 'mikhail', '2025-01-15', '13:52:00', 'pending', NULL, 0),
(60, 'haikal', 'DC123456', 'AD0111', 'mikhail', '2025-01-15', '01:51:00', 'pending', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `availability`
--

CREATE TABLE `availability` (
  `id` int(11) NOT NULL,
  `advisor_id` varchar(50) NOT NULL,
  `advisor_name` varchar(100) NOT NULL,
  `available_date` date NOT NULL,
  `available_time` time NOT NULL,
  `is_booked` tinyint(1) DEFAULT 0,
  `student_name` varchar(100) DEFAULT NULL,
  `student_id` varchar(50) DEFAULT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `availability`
--

INSERT INTO `availability` (`id`, `advisor_id`, `advisor_name`, `available_date`, `available_time`, `is_booked`, `student_name`, `student_id`, `notes`) VALUES
(41, 'AD0001', 'ammar', '2025-01-13', '11:00:00', 0, NULL, NULL, NULL),
(46, 'AD1234', 'farhad', '2025-01-12', '03:26:00', 1, NULL, NULL, NULL),
(52, 'AD0111', 'mikhail', '2025-01-14', '15:47:00', 1, NULL, NULL, NULL),
(53, 'AD0111', 'mikhail', '2025-01-15', '13:52:00', 1, NULL, NULL, NULL),
(54, 'AD0111', 'mikhail', '2025-01-15', '01:51:00', 1, NULL, NULL, NULL),
(56, 'AD0111', 'mikhail', '2025-01-23', '17:00:00', 0, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `meeting_progress`
--

CREATE TABLE `meeting_progress` (
  `id` int(11) NOT NULL,
  `student_id` varchar(50) NOT NULL,
  `student_name` varchar(100) NOT NULL,
  `advisor_id` varchar(50) NOT NULL,
  `meeting_count` int(11) DEFAULT 0,
  `semester` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `meeting_progress`
--

INSERT INTO `meeting_progress` (`id`, `student_id`, `student_name`, `advisor_id`, `meeting_count`, `semester`) VALUES
(2, 'DC123456', 'haikal', 'AD0111', 3, 'Spring 2025'),
(5, 'DC98788', 'sarah', 'AD0111', 1, 'Spring 2025');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `student_name` varchar(100) NOT NULL,
  `email` varchar(25) NOT NULL,
  `student_id` varchar(9) NOT NULL,
  `pass` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`student_name`, `email`, `student_id`, `pass`) VALUES
('mikhail', 'mkhlhssn@gmail.com', 'DC0002', '1234'),
('ammar', 'mkhlhssn@gmail.com', 'DC12345', '123456'),
('haikal', 'haikal@gmail.com', 'DC123456', '12345'),
('hakim', 'danyshq@gmail.com', 'DC98778', '1234'),
('sarah', 'sarah@gmail.com', 'DC98788', '12345');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `advisor`
--
ALTER TABLE `advisor`
  ADD PRIMARY KEY (`advisor_id`),
  ADD KEY `idx_advisor_id` (`advisor_id`),
  ADD KEY `idx_advisor_name` (`advisor_name`);

--
-- Indexes for table `advisor_student`
--
ALTER TABLE `advisor_student`
  ADD PRIMARY KEY (`id`),
  ADD KEY `advisor_id` (`advisor_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `availability`
--
ALTER TABLE `availability`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `student_id` (`student_id`),
  ADD KEY `advisor_id` (`advisor_id`),
  ADD KEY `advisor_name` (`advisor_name`);

--
-- Indexes for table `meeting_progress`
--
ALTER TABLE `meeting_progress`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_meeting` (`student_id`,`advisor_id`,`semester`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`student_id`),
  ADD UNIQUE KEY `student_id` (`student_id`),
  ADD UNIQUE KEY `student_name` (`student_name`),
  ADD UNIQUE KEY `student_id_2` (`student_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `advisor_student`
--
ALTER TABLE `advisor_student`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `availability`
--
ALTER TABLE `availability`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `meeting_progress`
--
ALTER TABLE `meeting_progress`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `advisor_student`
--
ALTER TABLE `advisor_student`
  ADD CONSTRAINT `advisor_student_ibfk_1` FOREIGN KEY (`advisor_id`) REFERENCES `advisor` (`advisor_id`),
  ADD CONSTRAINT `advisor_student_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`);

--
-- Constraints for table `availability`
--
ALTER TABLE `availability`
  ADD CONSTRAINT `availability_ibfk_1` FOREIGN KEY (`advisor_id`) REFERENCES `advisor` (`advisor_id`),
  ADD CONSTRAINT `availability_ibfk_2` FOREIGN KEY (`advisor_name`) REFERENCES `advisor` (`advisor_name`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
