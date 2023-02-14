-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 14, 2023 at 08:40 PM
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
(64, 'hrasp', 'lagon@wvsu.edu.ph', 'panel', 1, 'pending'),
(65, 'hrasp', 'pagara@wvsu.edu.ph', 'committee-president', 1, 'pending'),
(66, 'hrasp', 'castigador.ronald@wvsu.edu.ph', 'panel', 1, 'pending'),
(67, 'hrasp', 'canuto@wvsu.edu.ph', 'committee-president', 1, 'pending'),
(68, 'hrasp', 'castigador@wvsu.edu.ph', 'committee-member', 1, 'pending'),
(69, 'hrasp', 'dubouzet.bibiana@wvsu.edu.ph', 'panel', 1, 'pending'),
(70, 'hrasp', 'apologista@wvsu.edu.ph', 'committee-president', 1, 'pending'),
(71, 'hrasp', 'otayde.dinnajoy@wvsu.edu.ph', 'panel', 1, 'pending'),
(72, 'hrasp', 'otayde.dinnajoy@wvsu.edu.ph', 'panel', 0, 'pending'),
(73, 'hrasp', 'beso.mardy@wvsu.edu.ph', 'panel', 1, 'pending'),
(74, 'hrasp', 'cataluna.marinnette@wvsu.edu.ph', 'panel', 1, 'pending'),
(75, 'hrasp', 'armada.ivy@wvsu.du.ph', 'panel', 0, 'pending'),
(76, 'hrasp', 'orbino.vicente@wvsu.edu.ph', 'panel', 1, 'pending'),
(77, 'hrasp', 'triveles.lizel@wvsu.edu.ph', 'panel', 1, 'pending'),
(78, 'hrasp', 'penaflorida.hyacinth@wvsu.edu.ph', 'panel', 1, 'pending'),
(79, 'hrasp', 'delgado.albert@wvsu.edu.ph', 'panel', 1, 'pending'),
(92, 'hrasp', 'angelyd@gmail.com', 'committee-member', 1, 'pending'),
(93, 'hrasp', 'giesha@gmail.com', 'committee-member', 1, 'pending'),
(95, '1234', 'linghon.jhosanna@wvsu.edu.ph', 'applicant', 1, 'deactivated');

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
(95, 'Jhosanna', 'Linghon', 'Linghon', 'Femal', 23, '1998-10-30', '9807603954');

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
(55, 95, 54, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\dfd sample.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\fss.pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\242407417_885452178756805_6774133062403706241_n.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\ERD.drawio.png\",\"uploads\\\\applicant\\\\certs\\\\ERD-OnlineOrder.drawio.png\",\"uploads\\\\applicant\\\\certs\\\\ERD-Page-1.drawio.png\"]}', 'for-evaluation');

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
(60, 'Dinna Joy ', 'P', 'Otayde', 'Non Teaching', 'president'),
(61, 'Rey', 'C', 'Canuto', 'Teaching', 'president'),
(62, 'zfdga', 'ojopij', 'jkjkl', 'All', 'member'),
(63, 'adsfd', 'adsfa', 'adg', 'All', 'member'),
(65, 'Dinna Joy', 'P', 'Pagara', 'Non Teaching', 'president'),
(67, 'Rey', 'C', 'Canuto', 'Teaching', 'president'),
(68, 'Ronald', 'L', 'Castigador', 'All', 'member'),
(70, 'Lucia', 'A', 'Apologista', 'All', 'member'),
(92, 'angelyd', 'camo', 'pacificar', 'All', 'member'),
(93, 'Giesha', 'Dagiuno', 'Bojadores', 'All', 'member');

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
('2210731b-9e76-4f67-bd5d-df8c4e4be16c', 51, '68', NULL, NULL, NULL, '2023-02-06 03:36:55', NULL, NULL),
('459064d3-1745-4a18-991a-9fd521b457f1', 52, '77', '[{\"mainRate\":0,\"minRates\":[0,0,0]},{\"mainRate\":0,\"minRates\":[0,0,0,0]},{\"mainRate\":0,\"minRates\":[0,0]},{\"mainRate\":0,\"minRates\":[]}]', 0, 'Definitely to be considered', '2023-02-07 01:50:11', 'fsdfdsa', 'dsfds'),
('6be7ec58-1fcd-471a-bfd7-cca07fc68e08', 46, '20', NULL, NULL, NULL, '2023-02-05 23:35:32', NULL, NULL),
('a20516c5-562b-4204-b981-24871bd79372', 51, '67', '[{\"mainRate\":2,\"minRates\":[2,0,0]},{\"mainRate\":0,\"minRates\":[0,0,0,0]},{\"mainRate\":0,\"minRates\":[0,0]},{\"mainRate\":0,\"minRates\":[]}]', 2, 'Definitely to be considered', '2023-02-06 09:44:42', 'dfsdfgdsg', 'dsdsad'),
('ab80ab24-a2e7-4ecb-aa2c-30a16d0fa946', 52, '64', NULL, NULL, NULL, '2023-02-05 23:51:52', NULL, NULL),
('c0dc5b9f-ab02-473e-ae88-cc6016366b3a', 49, '65', '[{\"mainRate\":5,\"minRates\":[2,1,2]},{\"mainRate\":5.75,\"minRates\":[2,1.25,1.25,1.25]},{\"mainRate\":4.75,\"minRates\":[2.25,2.5]},{\"mainRate\":5,\"minRates\":[]}]', 21, 'Possible further consideration', '2023-02-08 00:30:06', 'fffff', 'fsdafsadg'),
('c89aac99-5530-48e5-a54b-bc1a013d3eda', 51, '20', NULL, NULL, NULL, '2023-02-05 23:36:19', NULL, NULL),
('c9fff3bf-5afe-4310-bf63-903bc516cd28', 52, '68', '[{\"mainRate\":5,\"minRates\":[2,1,2]},{\"mainRate\":5.25,\"minRates\":[2,0.75,1.25,1.25]},{\"mainRate\":5,\"minRates\":[2.5,2.5]},{\"mainRate\":5,\"minRates\":[]}]', 20, 'Unfavorable', '2023-02-06 03:36:46', 'vcfdbfdbgv', 'fggzfg'),
('d7aa8175-1b6c-4e56-bb92-514797a05d20', 46, '68', '[{\"mainRate\":2,\"minRates\":[1.75,0.25,0]},{\"mainRate\":2.5,\"minRates\":[1.25,1.25,0,0]},{\"mainRate\":0,\"minRates\":[0,0]},{\"mainRate\":4,\"minRates\":[]},{\"mainRate\":0,\"minRates\":[0,0,0]},{\"mainRate\":0,\"minRates\":[0,0,0,0]},{\"mainRate\":0,\"minRates\":[0,0]},{\"mainRate\":0,\"minRates\":[]},{\"mainRate\":0,\"minRates\":[0,0,0]},{\"mainRate\":0,\"minRates\":[0,0,0,0]},{\"mainRate\":0,\"minRates\":[0,0]},{\"mainRate\":0,\"minRates\":[]}]', 9, 'Possible further consideration', '2023-02-06 03:35:48', 'dwwwwwwwwwwwwwww', 'ddddddddddd');

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
(22, 42, '2023-01-28', '21:00:00', 'dc1ac202-33fd-40b3-b019-91dd65896ef4', 'starting'),
(23, 51, '2023-01-28', '10:00:00', 'b9ba88c1-783b-492a-8f8c-27ed0d94e6e7', 'starting'),
(26, 49, '2023-01-31', '00:08:00', '28e3d49d-b6e0-4e0c-bd1a-275d60cc7868', 'starting'),
(27, 46, '2023-01-31', '00:10:00', '204585a2-3ee2-4aed-80ef-6caabbd47314', 'starting'),
(28, 52, '2023-01-31', '00:11:00', 'f92384f4-ea18-4abf-9434-6973cd019aba', 'starting'),
(29, 50, '2023-02-06', '09:30:00', 'cd192705-b819-40db-8244-5f6dfe46492b', 'pending'),
(30, 55, '2023-02-14', '18:35:00', '758807c9-1898-4d78-9ea1-54b56be17bb8', 'starting');

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
(54, 'Part Time Instructor', 'We need part time instructors', '64', '2023-01-21 04:54:37', 2, '{\"qualifications\":[\"At least graduate of 4 years IT related course\"]}', 'approved'),
(55, 'Administrative Aide', 'We need office assistant.', '66', '2023-01-21 04:57:57', 3, '{\"qualifications\":[\"Must be graduate of any related course.\"]}', 'approved'),
(56, 'assistant', 'at least collage graduate', '71', '2023-01-21 05:08:38', 1, '{\"qualifications\":[]}', 'approved'),
(58, 'assistant clerk', 'at least have a year experience', '77', '2023-01-21 05:17:52', 2, '{\"qualifications\":[\"college degree\"]}', 'approved'),
(59, 'security guard', 'with 1 year experience and have good background ', '76', '2023-01-21 05:23:39', 2, '{\"qualifications\":[\"atleast high school gradute\"]}', 'approved'),
(60, 'cashier', 'have a four year experience', '78', '2023-01-21 05:26:12', 1, '{\"qualifications\":[\"college graduate\"]}', 'approved'),
(61, 'clinic assistant', 'have knowldge about 1st aid', '74', '2023-01-21 05:31:39', 1, '{\"qualifications\":[\"college graduate\"]}', 'approved'),
(62, 'Job laborer', 'hard working', '79', '2023-01-21 05:37:58', 4, '{\"qualifications\":[\"high school level\"]}', 'approved');

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
(64, 'Teaching', 'SICT', 'Director', 'Rose May Cora', 'P', 'Lagon'),
(66, 'Non Teaching', 'Admin', 'Director', 'Ronald ', 'L. ', 'Castigador'),
(69, 'Non Teaching', 'Registrar', 'Director', 'Bibiana', 'P. ', 'Dubouzet'),
(71, 'Non Teaching', 'Library', 'Director', 'Dinna Joy', 'P. ', 'Otayde'),
(72, 'Non Teaching', 'Library', 'Director', 'Dinna Joy', 'P. ', 'Otayde'),
(73, 'Non Teaching', 'School Farm', 'Director', 'Mardy', 'B. ', 'Beso'),
(74, 'Non Teaching', 'School Clinic', 'Director', 'Marinnette ', 'E. ', 'Cataluna'),
(75, 'Non Teaching', 'Cleric', 'Director', 'Ivy', 'P.', 'Armada'),
(76, 'Non Teaching', 'Security', 'Director', 'Vicente ', 'C.', 'Orbino'),
(77, 'Non Teaching', 'Cleric', 'Director', 'Lizel ', 'S.', 'Triveles'),
(78, 'Non Teaching', 'Finance', 'Director', 'Hyacinth ', 'M.', 'Penaflorida'),
(79, 'Non Teaching', 'Job Laborers', 'Director', 'Albert', '', 'Delgado');

-- --------------------------------------------------------

--
-- Table structure for table `tokens`
--

CREATE TABLE `tokens` (
  `account_id` int(10) NOT NULL,
  `token` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tokens`
--

INSERT INTO `tokens` (`account_id`, `token`) VALUES
(95, 'BfNMKLFwceCZQogV_HJ40cCmtqkKV3oLSL0rkJ2Ybyk');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `applicants`
--
ALTER TABLE `applicants`
  MODIFY `account_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT for table `applications`
--
ALTER TABLE `applications`
  MODIFY `id` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `interview`
--
ALTER TABLE `interview`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `job_posts`
--
ALTER TABLE `job_posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `panels`
--
ALTER TABLE `panels`
  MODIFY `account_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
