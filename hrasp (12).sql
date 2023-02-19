-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 19, 2023 at 05:47 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hrasp`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `password` varchar(30) NOT NULL,
  `email` varchar(100) NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'applicant',
  `enabled` int(1) NOT NULL DEFAULT 1,
  `status` varchar(50) NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `password`, `email`, `type`, `enabled`, `status`) VALUES
(20, 'hrasp', 'hrasp@wvsu.edu.ph', 'admin', 1, 'pending'),
(102, '1234', 'emman199810@gmail.com', 'applicant', 1, 'active'),
(103, 'hrasp', 'jonalynegarde@gmail.com', 'panel', 1, 'pending'),
(104, 'hrasp', 'nonteachingpresident', 'committee-president', 1, 'pending'),
(105, 'hrasp', 'facultypresidentpanel', 'committee-president', 1, 'pending'),
(106, 'hrasp', 'member1', 'committee-member', 1, 'pending'),
(107, 'hrasp', 'member2', 'committee-member', 1, 'pending'),
(108, 'lynlyn', 'jovelyngarde09@gmail.com', 'applicant', 1, 'active'),
(109, 'hrasp', 'jenny', 'panel', 1, 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `applicants`
--

CREATE TABLE `applicants` (
  `account_id` int(11) NOT NULL,
  `firstname` varchar(30) NOT NULL,
  `middlename` varchar(30) NOT NULL,
  `lastname` varchar(30) NOT NULL,
  `gender` varchar(5) NOT NULL,
  `age` int(3) NOT NULL,
  `birthday` date NOT NULL,
  `contact` varchar(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `applicants`
--

INSERT INTO `applicants` (`account_id`, `firstname`, `middlename`, `lastname`, `gender`, `age`, `birthday`, `contact`) VALUES
(102, 'Emmanuel ', 'Despi', 'Katipunan', 'male', 24, '2007-02-24', '9162400105'),
(108, 'lyn', 'L', 'garde', 'Femal', 25, '2023-02-09', '09123456789');

-- --------------------------------------------------------

--
-- Table structure for table `applications`
--

CREATE TABLE `applications` (
  `id` int(9) NOT NULL,
  `applicant_id` int(9) NOT NULL,
  `job_id` int(9) NOT NULL,
  `letter` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`letter`)),
  `pds` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`pds`)),
  `tor` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`tor`)),
  `certificates` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`certificates`)),
  `status` varchar(20) NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `applications`
--

INSERT INTO `applications` (`id`, `applicant_id`, `job_id`, `letter`, `pds`, `tor`, `certificates`, `status`) VALUES
(56, 102, 103, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\Application-Letter.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\CIT-240-Open-Source-Programming-Unit-1.pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\IMG20220406104046.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\IMG20220406103603.jpg\",\"uploads\\\\applicant\\\\certs\\\\IMG20220406104022.jpg\",\"uploads\\\\applicant\\\\certs\\\\IMG20220406103848.jpg\"]}', 'for-evaluation'),
(57, 108, 103, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\PERSONAL DATA  6.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\PERSONAL DATA  6.pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\Hrasp101.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\Hrasp9.jpg\"]}', 'for-evaluation');

-- --------------------------------------------------------

--
-- Table structure for table `committees`
--

CREATE TABLE `committees` (
  `account_id` int(11) NOT NULL,
  `firstname` varchar(30) NOT NULL,
  `middlename` varchar(30) NOT NULL,
  `lastname` varchar(30) NOT NULL,
  `committee` varchar(30) NOT NULL,
  `position` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `committees`
--

INSERT INTO `committees` (`account_id`, `firstname`, `middlename`, `lastname`, `committee`, `position`) VALUES
(104, 'Non Teaching', 'President', 'Panel', 'Non Teaching', 'president'),
(105, 'faculty', 'president', 'panel', 'Teaching', 'president'),
(106, 'member1', 'panel', 'testl', 'All', 'member'),
(107, 'member2', 'panel2', 'test2', 'All', 'member');

-- --------------------------------------------------------

--
-- Table structure for table `evaluations`
--

CREATE TABLE `evaluations` (
  `id` varchar(100) NOT NULL,
  `application_id` int(10) NOT NULL,
  `evaluator` varchar(10) NOT NULL,
  `ratings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `total` int(2) DEFAULT NULL,
  `recommendation` varchar(50) DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `training` varchar(200) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `evaluations`
--

INSERT INTO `evaluations` (`id`, `application_id`, `evaluator`, `ratings`, `total`, `recommendation`, `date`, `training`, `remarks`) VALUES
('65fd631e-35eb-42ae-bee9-e4398b25d01e', 56, '105', '[{\"mainRate\":3,\"minRates\":[2,1,0]},{\"mainRate\":1,\"minRates\":[0,0,1,0]},{\"mainRate\":2.5,\"minRates\":[2.5,0]},{\"mainRate\":5,\"minRates\":[]}]', 12, 'Unfavorable', '2023-02-20 00:18:44', 'fgfgg', 'dsfds'),
('6cd26d3f-bc2c-4bf9-b969-fe6e74f223bf', 56, '103', '[{\"mainRate\":5,\"minRates\":[2,1,2]},{\"mainRate\":5,\"minRates\":[2,1,1,1]},{\"mainRate\":0,\"minRates\":[0,0]},{\"mainRate\":5,\"minRates\":[]}]', 15, 'Possible further consideration', '2023-02-20 00:16:11', 'dfdf', 'wewe'),
('8e7eff14-7d29-4675-a499-9246a8612e68', 57, '106', '[{\"mainRate\":5,\"minRates\":[2,1,2]},{\"mainRate\":6,\"minRates\":[2,1,2,1]},{\"mainRate\":4,\"minRates\":[2,2]},{\"mainRate\":5,\"minRates\":[]}]', 20, 'Definitely to be considered', '2023-02-20 00:14:14', 'fdfdf`', 'wawa'),
('9a7d9943-39d8-4f50-8805-c50ac551768c', 57, '105', '[{\"mainRate\":4.25,\"minRates\":[1.75,0.75,1.75]},{\"mainRate\":1.75,\"minRates\":[1,0.75,0,0]},{\"mainRate\":5,\"minRates\":[2.5,2.5]},{\"mainRate\":5,\"minRates\":[]}]', 16, 'Possible further consideration', '2023-02-20 00:19:08', 'dfsddsfdsf', 'wwwwwwdddd'),
('dcb4b2a6-51a5-4d28-b74e-b3eecc8791db', 56, '106', '[{\"mainRate\":4.75,\"minRates\":[2,1,1.75]},{\"mainRate\":5.25,\"minRates\":[2,1.25,0.75,1.25]},{\"mainRate\":5,\"minRates\":[2.5,2.5]},{\"mainRate\":4,\"minRates\":[]}]', 19, 'Definitely to be considered', '2023-02-20 00:08:58', 'Very experienced', 'Information Technology');

-- --------------------------------------------------------

--
-- Table structure for table `interview`
--

CREATE TABLE `interview` (
  `id` int(11) NOT NULL,
  `application_id` int(9) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `room_id` varchar(100) NOT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `interview`
--

INSERT INTO `interview` (`id`, `application_id`, `date`, `time`, `room_id`, `status`) VALUES
(31, 56, '2023-02-15', '21:39:00', '9e3f1eac-9010-4c6e-bd7a-97b134fdcd52', 'starting'),
(32, 57, '2023-02-18', '22:08:00', 'e0e2adf1-bdc3-4c4e-ae9d-0fdae7f45584', 'starting');

-- --------------------------------------------------------

--
-- Table structure for table `job_posts`
--

CREATE TABLE `job_posts` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `poster` varchar(100) DEFAULT NULL,
  `date` datetime NOT NULL,
  `num_persons` int(2) NOT NULL,
  `qualifications` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`qualifications`)),
  `status` varchar(10) NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `job_posts`
--

INSERT INTO `job_posts` (`id`, `title`, `description`, `poster`, `date`, `num_persons`, `qualifications`, `status`) VALUES
(103, 'Part-time Instructor', 'We need part time instructors that can teach java programming.', '103', '2023-02-15 12:25:03', 3, '{\"qualifications\":[\"Graduate of BSIT or any related courses\",\"Must be proficient in programming\"]}', 'approved'),
(105, 'Teaching', 'we are hiring for a teaching staff that is proficient in any programming language. ', '103', '2023-02-18 14:13:20', 2, '{\"qualifications\":[\"board passer\",\"must be proficient in any programming language\",\"with at least 2 years experience in teaching\"]}', 'approved');

-- --------------------------------------------------------

--
-- Table structure for table `panels`
--

CREATE TABLE `panels` (
  `account_id` int(11) NOT NULL,
  `departmentType` varchar(20) NOT NULL,
  `department` varchar(20) NOT NULL,
  `position` varchar(50) NOT NULL,
  `firstname` varchar(20) NOT NULL,
  `middlename` varchar(20) NOT NULL,
  `lastname` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `panels`
--

INSERT INTO `panels` (`account_id`, `departmentType`, `department`, `position`, `firstname`, `middlename`, `lastname`) VALUES
(103, 'Teaching', 'SICT', 'Director', 'Jonalyn', 'Estorque', 'Garde'),
(109, 'Teaching', 'COA', 'Director', 'Jenny', 'Bayl', 'Ryniel');

-- --------------------------------------------------------

--
-- Table structure for table `tokens`
--

CREATE TABLE `tokens` (
  `account_id` int(10) NOT NULL,
  `token` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `applicants`
--
ALTER TABLE `applicants`
  ADD PRIMARY KEY (`account_id`);

--
-- Indexes for table `applications`
--
ALTER TABLE `applications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `committees`
--
ALTER TABLE `committees`
  ADD PRIMARY KEY (`account_id`);

--
-- Indexes for table `evaluations`
--
ALTER TABLE `evaluations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `interview`
--
ALTER TABLE `interview`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `job_posts`
--
ALTER TABLE `job_posts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `panels`
--
ALTER TABLE `panels`
  ADD PRIMARY KEY (`account_id`);

--
-- Indexes for table `tokens`
--
ALTER TABLE `tokens`
  ADD UNIQUE KEY `account_id` (`account_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110;

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `applicants`
--
ALTER TABLE `applicants`
  MODIFY `account_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- AUTO_INCREMENT for table `applications`
--
ALTER TABLE `applications`
  MODIFY `id` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `interview`
--
ALTER TABLE `interview`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `job_posts`
--
ALTER TABLE `job_posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- AUTO_INCREMENT for table `panels`
--
ALTER TABLE `panels`
  MODIFY `account_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
