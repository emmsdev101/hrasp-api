-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 16, 2022 at 11:59 AM
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
  `type` varchar(10) NOT NULL DEFAULT 'applicant'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `password`, `email`, `type`) VALUES
(2, '1234', 'emman199810@gmail.com', 'applicant'),
(4, 'lala', 'lala@gmail.com', 'applicant'),
(5, 'lala', 'lala@gmail.com', 'applicant'),
(6, 'hrasp', 'hrasp@wvsu.edu.ph', 'admin'),
(7, '1234', 'janen@gmail.com', 'applicant'),
(8, '1234', 'joaquin@gmail.com', 'applicant'),
(9, 'Jhosanna23', 'linghon.jhosanna@wvsu.edu.ph', 'applicant'),
(10, 'Jhosanna23', 'linghon.jhosanna@wvsu.edu.ph', 'applicant'),
(11, '', '', 'applicant'),
(12, '1234', 'gener@gmail.com', 'applicant'),
(13, '1234', 'bolivar@gmail.com', 'applicant'),
(14, '1234', 'estelloro@gmail.com', 'applicant'),
(15, '1234', 'camu@gmail.com', 'applicant'),
(16, '1234', 'samjelteo@gmail.com', 'applicant'),
(17, '1234', 'camare@gmail.com', 'applicant'),
(18, '1234', 'gener@gmail.com', 'applicant'),
(19, '1234', 'caspillo@gmail.com', 'applicant');

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
(2, 'emmanuel', 'faww', 'katipunan', 'male', 23, '1998-10-30', '12345678901'),
(4, 'wawa', 'wewe', 'lala', 'male', 33, '2222-10-21', '4343434343'),
(5, 'wawa', 'wewe', 'lala', 'male', 33, '2222-10-21', '4343434343'),
(7, 'Janen', 'Caspillo', 'Camare', 'Femal', 21, '2000-10-20', '32145676558'),
(8, 'Joaquin', 'Aroyo', 'Quinto', 'male', 22, '1997-09-02', '2213456754'),
(9, 'Jhosanna ', 'Figueroa', 'Linghon', 'Femal', 23, '0099-06-26', '09511362156'),
(10, 'Jhosanna ', 'Figueroa', 'Linghon', 'Femal', 23, '1999-06-26', '09511362156'),
(12, 'Angela', 'Zambra', 'Ganit', 'Femal', 32, '2022-12-13', '09123456'),
(13, 'RHEA', 'PACIFICAR', 'BOLIVAR', 'Femal', 23, '1999-07-21', '09101296011'),
(14, 'LEONIVIC', 'PACIFICAR', 'ESTELLORO', 'Femal', 33, '1989-03-16', '09101396011'),
(15, 'AMADO', 'GUIRIBA', 'CAMU', 'male', 52, '1970-09-13', '09101496011'),
(16, 'ANGELYD', 'CAMU', 'PACIFICAR', 'Femal', 29, '1993-03-21', '09101296011'),
(17, 'JANEN', 'CASPILLO', 'CAMARE', 'Femal', 22, '2000-06-06', '0910156011'),
(18, 'ANGELA', 'ZAMBRA', 'GENER', 'Femal', 22, '2000-06-06', '09101696011'),
(19, 'CJ', 'ZAMBRA', 'CASPILLO', 'male', 22, '2000-06-06', '09101696011');

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
(17, 12, 20, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\Cover Letter For Job Application.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\personal data 1.pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\OIP_003.jpg\",\"uploads\\\\applicant\\\\tor\\\\OIP_004.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\OIP.jpg\",\"uploads\\\\applicant\\\\certs\\\\OIP_002.jpg\",\"uploads\\\\applicant\\\\certs\\\\OIP_003.jpg\",\"uploads\\\\applicant\\\\certs\\\\OIP_004.jpg\"]}', 'pending'),
(18, 13, 22, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\sample1.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\PERSONAL DATA 2.pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\transcript 4.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\OIP.jpg\"]}', 'pending'),
(19, 14, 23, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\sample1.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\PERSONAL DATA 3.pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\transcript 4.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\OIP_004.jpg\"]}', 'pending'),
(20, 15, 24, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\sample1.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\PESONAL DATA 4.pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\transcript 4.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\th_011.jpg\"]}', 'pending'),
(21, 16, 18, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\sample1.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\personal data 1.pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\transcript 4.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\OIP_023.jpg\"]}', 'pending'),
(22, 17, 20, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\sample1.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\PERSONAL DATA 5.pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\transcript 4.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\th_003.jpg\"]}', 'pending'),
(23, 19, 21, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\sample1.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\personal data 7.pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\transcript 4.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\th.jpg\"]}', 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `interview`
--

CREATE TABLE `interview` (
  `id` int(11) NOT NULL,
  `application_id` int(9) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `interview`
--

INSERT INTO `interview` (`id`, `application_id`, `date`, `time`) VALUES
(3, 11, '2022-11-18', '16:36:00'),
(4, 11, '2022-11-18', '16:36:00'),
(5, 11, '2022-11-16', '18:38:00'),
(6, 11, '2022-11-16', '06:42:00'),
(7, 12, '2022-11-21', '17:51:00'),
(8, 13, '2022-11-20', '07:52:00'),
(9, 14, '2022-11-25', '11:29:00'),
(10, 16, '2022-11-09', '04:26:00');

-- --------------------------------------------------------

--
-- Table structure for table `job_posts`
--

CREATE TABLE `job_posts` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` varchar(3000) NOT NULL,
  `poster` varchar(100) DEFAULT NULL,
  `date` datetime NOT NULL,
  `jobtype` varchar(100) NOT NULL,
  `num_persons` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `job_posts`
--

INSERT INTO `job_posts` (`id`, `title`, `description`, `poster`, `date`, `jobtype`, `num_persons`) VALUES
(18, 'OSA Personnel', ' West Visayas State University Calinog Campos is need of one (1) Job - order personnel to be assigned at the Office of Student Affairs.', 'uploads\\admin\\images\\jobPosts\\HRMO.jpg', '2022-11-13 13:49:13', 'Administrative Staff', 1),
(20, 'Guidance Counselor III.', 'West Visayas State University Calinog Campus is in need of one (1) Guidance Counselor III.', 'uploads\\admin\\images\\jobPosts\\HRMO3.jpg', '2022-11-13 14:16:47', 'Faculty Member', 1),
(21, 'SCHOOL FARMING COORDINATOR II', 'We Are Hiring!!!\nBe part of WVSU Calinog workforce!\nSCHOOL FARMING COORDINATOR II', 'uploads\\admin\\images\\jobPosts\\HRMO4.jpg', '2022-11-13 14:35:08', 'Administrative Staff', 1),
(22, 'Admin Office Staff', 'We are hiring!!\nThe West Visayas State University Calinog Campus is in need of two (2) Job-Order to be assigned at the Campus Administrator\'s Office and School of Information & Communications Technology Office.', 'uploads\\admin\\images\\jobPosts\\hrmo6.jpg', '2022-11-13 14:49:41', 'Administrative Staff', 2),
(23, 'Staff', 'We are hiring!!\nThe West Visayas State University Calinog Campus is in need of 1 (one) Job-Order to be assigned in Audio Visual Center (AVC) & Public Affairs & Marketing Communications Office (PAMCO)', 'uploads\\admin\\images\\jobPosts\\hrmo7.jpg', '2022-11-13 14:52:42', 'Administrative Staff', 1),
(24, 'Staff', 'We are hiring!!\nThe West Visayas State University Calinog Campus is in need of 1 (one) Job-Order to be assigned in MIS/PACO', 'uploads\\admin\\images\\jobPosts\\hrmo8.jpg', '2022-11-13 14:55:59', 'Administrative Staff', 1);

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
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `applicants`
--
ALTER TABLE `applicants`
  MODIFY `account_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `applications`
--
ALTER TABLE `applications`
  MODIFY `id` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `interview`
--
ALTER TABLE `interview`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `job_posts`
--
ALTER TABLE `job_posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
