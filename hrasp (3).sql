-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 01, 2023 at 08:10 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

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
  `enabled` int(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `password`, `email`, `type`, `enabled`) VALUES
(20, 'hrasp', 'hrasp@wvsu.edu.ph', 'admin', 1),
(64, 'hrasp', 'lagon@wvsu.edu.ph', 'panel', 1),
(65, 'hrasp', 'pagara@wvsu.edu.ph', 'committee-president', 1),
(66, 'hrasp', 'castigador.ronald@wvsu.edu.ph', 'panel', 1),
(67, 'hrasp', 'canuto@wvsu.edu.ph', 'committee-president', 1),
(68, 'hrasp', 'castigador@wvsu.edu.ph', 'committee-member', 1),
(69, 'hrasp', 'dubouzet.bibiana@wvsu.edu.ph', 'panel', 1),
(70, 'hrasp', 'apologista@wvsu.edu.ph', 'committee-president', 1),
(71, 'hrasp', 'otayde.dinnajoy@wvsu.edu.ph', 'panel', 1),
(72, 'hrasp', 'otayde.dinnajoy@wvsu.edu.ph', 'panel', 0),
(73, 'hrasp', 'beso.mardy@wvsu.edu.ph', 'panel', 1),
(74, 'hrasp', 'cataluna.marinnette@wvsu.edu.ph', 'panel', 1),
(75, 'hrasp', 'armada.ivy@wvsu.du.ph', 'panel', 0),
(76, 'hrasp', 'orbino.vicente@wvsu.edu.ph', 'panel', 1),
(77, 'hrasp', 'triveles.lizel@wvsu.edu.ph', 'panel', 1),
(78, 'hrasp', 'penaflorida.hyacinth@wvsu.edu.ph', 'panel', 1),
(79, 'hrasp', 'delgado.albert@wvsu.edu.ph', 'panel', 1),
(81, '1234', 'gener.angelajane@wvsu.edu.ph', 'applicant', 1),
(82, '1234', 'camare.janen@wvsu.edu.ph', 'applicant', 1),
(83, '1234', 'bojadores.gieshamae@wvsu.edu.ph', 'applicant', 1),
(84, '1234', 'linghon.jhosanna@wvsu.edu.ph', 'applicant', 1),
(85, '1234', 'camarig.andreamae@wvsu.edu.ph', 'applicant', 1),
(86, '1234', 'lendanan.marian@wvsu.edu.ph', 'applicant', 1),
(87, '1234', 'plenago.jonie@wvsu.edu.ph', 'applicant', 1),
(88, '1234', 'amolar.tessa@wvsu.edu.ph', 'applicant', 1),
(89, '1234', 'sutito.ruby@wvsu.edu.ph', 'applicant', 1),
(90, '1234', 'jonalynegarde@gmail.com', 'applicant', 1);

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
  `contact` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `applicants`
--

INSERT INTO `applicants` (`account_id`, `firstname`, `middlename`, `lastname`, `gender`, `age`, `birthday`, `contact`) VALUES
(81, 'Angela Jane', 'Zambra', 'Gener', 'Femal', 21, '2023-04-29', '09091717743'),
(82, 'Janen', 'Caspillo', 'Camare', 'male', 1, '2022-10-21', '09091234561'),
(83, 'Giesha Mae ', 'Daguino', 'Bojadores', 'Femal', 23, '1998-02-14', '12345678901'),
(84, 'Jhosanna ', '', 'Linghon', 'Femal', 23, '2000-01-21', '53687946185'),
(85, 'Andrea Mae', '', 'Camarig', 'Femal', 21, '2001-12-25', '64852973846'),
(86, 'Marian ', '', 'Lendanan', 'Femal', 22, '2000-01-03', '97045387913'),
(87, 'Jonie ', '', 'Plenago', 'male', 22, '1999-02-14', '97054312864'),
(88, 'Tessa', '', 'Amolar', 'Femal', 23, '1999-03-31', '04976358946'),
(89, 'Ruby ', '', 'Sutito', 'Femal', 22, '2000-03-15', '94076851358'),
(90, 'Jowanna', 'Garda', 'Miranda', 'Femal', 22, '2000-02-10', '09988321456');

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
(35, 46, 48, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\application letter.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\Angelyd-pds..pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\tor.sample.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\ODF.png\",\"uploads\\\\applicant\\\\certs\\\\OIP.jpg\",\"uploads\\\\applicant\\\\certs\\\\OIP_002.jpg\"]}', 'to-interview'),
(36, 45, 49, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\application letter.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\Angela-pds..pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\tor.sample.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\ODF.png\",\"uploads\\\\applicant\\\\certs\\\\OIP.jpg\",\"uploads\\\\applicant\\\\certs\\\\OIP_002.jpg\"]}', 'to-interview'),
(37, 44, 50, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\application letter.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\janen-pds.pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\tor.sample.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\ODF.png\",\"uploads\\\\applicant\\\\certs\\\\OIP.jpg\",\"uploads\\\\applicant\\\\certs\\\\OIP_002.jpg\"]}', 'for-interview'),
(38, 43, 51, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\application letter.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\giesha-pds..pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\tor.sample.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\OIP_004.jpg\",\"uploads\\\\applicant\\\\certs\\\\OIP_005.jpg\",\"uploads\\\\applicant\\\\certs\\\\OIP_006.jpg\"]}', 'for-interview'),
(39, 42, 48, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\application letter.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\julius-pds..pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\tor.sample.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\th_007.jpg\",\"uploads\\\\applicant\\\\certs\\\\th_008.jpg\",\"uploads\\\\applicant\\\\certs\\\\th_009.jpg\"]}', 'for-interview'),
(40, 47, 49, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\application letter.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\novemarie-pds..pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\tor.sample.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\th_004.jpg\",\"uploads\\\\applicant\\\\certs\\\\th_005.jpg\",\"uploads\\\\applicant\\\\certs\\\\th_006.jpg\"]}', 'to-interview'),
(41, 48, 50, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\application letter.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\Emman-pds..pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\tor.sample.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\OIP_018.jpg\",\"uploads\\\\applicant\\\\certs\\\\OIP_019.jpg\",\"uploads\\\\applicant\\\\certs\\\\OIP_020.jpg\"]}', 'for-interview'),
(43, 81, 61, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\Ghant Chart emms THESIS GROUP.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\Ghant Chart emms THESIS GROUP.pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\Mga Bayaning Pilipino.png\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\Mga Bayaning Pilipino.png\"]}', 'for-interview'),
(44, 82, 56, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\FHE-SA-SOI-01-F09-signed.pdf\"]}', '{\"pds\":[]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\transcript 4.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\Blank diagram.png\"]}', 'for-interview'),
(45, 83, 58, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\IMG_20230120_091438.jpg\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\IMG_20230120_091604.jpg\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\images (3).jpeg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\images (3).jpeg\",\"uploads\\\\applicant\\\\certs\\\\images.jpeg\"]}', 'prequalification'),
(46, 84, 62, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\IMG_20230120_101436.jpg\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\IMG_20230120_091604.jpg\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\IMG_20230120_091604.jpg\",\"uploads\\\\applicant\\\\tor\\\\IMG_20230120_091600.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\IMG_20230120_091604.jpg\",\"uploads\\\\applicant\\\\certs\\\\IMG_20230120_091438.jpg\"]}', 'to-interview'),
(47, 85, 55, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\IMG_20230120_091438.jpg\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\IMG_20230120_091600.jpg\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\images (3).jpeg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\images.jpeg\"]}', 'prequalification'),
(48, 86, 60, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\IMG_20230114_212044.jpg\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\IMG_20230120_091600.jpg\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\IMG_20230120_091604.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\IMG_20230120_091604.jpg\",\"uploads\\\\applicant\\\\certs\\\\IMG_20230120_091438.jpg\"]}', 'prequalification'),
(49, 87, 59, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\IMG_20230120_091604.jpg\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\IMG_20230120_091438.jpg\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\images (3).jpeg\",\"uploads\\\\applicant\\\\tor\\\\images.jpeg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\IMG_20230120_091604.jpg\",\"uploads\\\\applicant\\\\certs\\\\IMG_20230120_091438.jpg\"]}', 'to-interview'),
(50, 88, 55, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\West-Visayas-State-University-Calinog-Campus-Calinog-Iloilo-School-of-Information-and-Communications-Technology_2.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\Plant-Nursery-Monitoring-Systemparaphrased (1).pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\images.jpeg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\images (3).jpeg\"]}', 'pending'),
(51, 89, 54, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\Certificate-for-Speaker.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\Certificate-for-Speaker.pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\IMG_20230120_101436.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\IMG_20230120_091604.jpg\"]}', 'to-interview'),
(52, 90, 58, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\wssm2016.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\wssm2016.pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\Screenshot (6).png\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\Screenshot (2).png\",\"uploads\\\\applicant\\\\certs\\\\Screenshot (3).png\",\"uploads\\\\applicant\\\\certs\\\\Screenshot (4).png\"]}', 'to-interview');

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
(70, 'Lucia', 'A', 'Apologista', 'All', 'member');

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
(27, 46, '2023-01-31', '00:10:00', '204585a2-3ee2-4aed-80ef-6caabbd47314', 'pending'),
(28, 52, '2023-01-31', '00:11:00', 'f92384f4-ea18-4abf-9434-6973cd019aba', 'starting');

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
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `applicants`
--
ALTER TABLE `applicants`
  MODIFY `account_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT for table `applications`
--
ALTER TABLE `applications`
  MODIFY `id` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `interview`
--
ALTER TABLE `interview`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

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
