-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 20, 2023 at 06:58 AM
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
  `type` varchar(10) NOT NULL DEFAULT 'applicant',
  `enabled` int(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `password`, `email`, `type`, `enabled`) VALUES
(20, 'hrasp', 'hrasp@wvsu.edu.ph', 'admin', 1),
(21, 'jhosanna23', 'linghon.jhosanna@wvsu.edu.ph', 'applicant', 1),
(27, 'pacificar21', 'pacificar@gmail.com', 'applicant', 1),
(34, 'hrasp', 'ira@gmail.com', 'panel', 1),
(35, 'hrasp', 'json@gmail.com', 'panel', 0),
(36, 'hrasp', 'linghon.jhosanna@wvsu.edu.ph', 'panel', 1),
(37, 'hrasp', 'gener.angelajean@wvsu.edu.ph', 'panel', 1),
(38, 'hrasp', 'camare.janen@wvsu.edu.ph', 'panel', 1),
(39, 'hrasp', 'pacificar.angelyd@wvsu.edu.ph', 'panel', 0),
(40, 'hrasp', 'katipunan.emmanueljr@wvsu.edu.ph', 'panel', 0),
(41, 'hrasp', 'delacruz.julius@wvsu.edu.ph.', 'panel', 0),
(42, 'julius1998', 'delacruz.julius@gmail.com', 'applicant', 1),
(43, 'giesha2000', 'gieshamae.bojadores@gmail.com', 'applicant', 1),
(44, 'Janen2000', 'janen.camare@gmail.com', 'applicant', 1),
(45, 'angela20001', 'angelajean.gener@wvsu.edu.ph', 'applicant', 1),
(46, 'angelyd1994', 'angelyd.pacificar@wvsu.edu.ph', 'applicant', 1),
(47, 'novemarie2003', 'novemarie.linghon@wvsu.edu.ph', 'applicant', 1),
(48, 'emmanuel1234', 'emmanuel@gmail.com', 'applicant', 1),
(49, 'hrasp', 'bibiana@hrasp.com', 'panel', 1),
(50, 'hrasp', 'dinnajoy@hrasp.com', 'panel', 1),
(51, 'hrasp', 'mardy@hrasp.com', 'panel', 1),
(52, 'hrasp', 'grace@hrasp.com', 'panel', 1),
(53, 'hrasp', 'lizel@hrasp.com', 'panel', 1),
(54, 'hrasp', 'vicente@hrasp.com', 'panel', 1),
(55, 'hrasp', 'hyacinth@hrasp.com', 'panel', 1),
(56, 'hrasp', 'Ariel@hrasp.com', 'panel', 1);

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
(21, 'Jhosanna', 'Figueroa', 'Linghon', 'Femal', 23, '1999-07-26', '09511362156'),
(27, 'ANGELYD', 'CAMU', 'PACIFICAR', 'Femal', 29, '1993-03-21', '09101296011'),
(28, 'Sammy ', 'Padernal ', 'Pacificar', 'male', 32, '1990-02-16', '09101296012'),
(29, 'Mateo', 'Camu', 'Pacificar', 'male', 20, '2000-09-22', '09101296013'),
(42, 'Julius', 'Parcon', 'Dela cruz', 'male', 28, '0094-07-31', '09500078073'),
(43, 'Giesha Mae', 'Daguino', 'Bojadores', 'Femal', 22, '2000-12-09', '09386645265'),
(44, 'Janen', 'Caspillo', 'Camare', 'male', 0, '2000-04-10', '09482580382'),
(45, 'Angela Jean', 'Zambra', 'Gener', 'Femal', 22, '2001-02-04', '09091717754'),
(46, 'angelyd', 'Camu', 'Pacificar', 'Femal', 29, '1994-03-03', '09225621631'),
(47, 'Novemarie', 'Figueroa', 'Linghon', 'Femal', 19, '2003-11-04', '09268269924'),
(48, 'Emmauel', 'D', 'Katipunan', 'male', 23, '1999-02-03', '09101296012');

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
(39, 42, 48, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\application letter.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\julius-pds..pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\tor.sample.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\th_007.jpg\",\"uploads\\\\applicant\\\\certs\\\\th_008.jpg\",\"uploads\\\\applicant\\\\certs\\\\th_009.jpg\"]}', 'prequalification'),
(40, 47, 49, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\application letter.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\novemarie-pds..pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\tor.sample.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\th_004.jpg\",\"uploads\\\\applicant\\\\certs\\\\th_005.jpg\",\"uploads\\\\applicant\\\\certs\\\\th_006.jpg\"]}', 'to-interview'),
(41, 48, 50, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\application letter.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\Emman-pds..pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\tor.sample.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\OIP_018.jpg\",\"uploads\\\\applicant\\\\certs\\\\OIP_019.jpg\",\"uploads\\\\applicant\\\\certs\\\\OIP_020.jpg\"]}', 'for-interview');

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
(11, 24, '2023-01-17', '09:30:00'),
(14, 40, '2023-01-19', '15:16:00'),
(15, 35, '2023-01-21', '09:30:00'),
(16, 36, '2023-01-18', '17:50:00');

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
(48, 'SCHOOL FARMING COORDINATOR II', 'We Are Hiring!!!\nBe part of WVSU Calinog workforce!\nSCHOOL FARMING COORDINATOR II\n(Plantilla Item No.: WVSUB-SFC2-1-2002\nSalary Grade: SG 14\nMonthly Salary: Php. 32,321.00\nQUALIFICATION STANDARDS\nPlace of Assignment: WVSU Calinog Campus\nDEADLINE OF SUBMISSION\nInterested and qualified applicants should signify their interest in writing. Attach the following documents to the application letter and send to the address below not later than November 7, 2022.\nREQUIREMENTS\n• Fully accomplished Personal Data Sheet (PDS) with recent passport-sized picture (CS Form No. 212, Revised 2017) which can be downloaded at www.csc.gov.ph;\n• Performance rating in the present position for one (1) year (if applicable);\n• Photocopy of certificate of eligibility/rating/license; \n• Photocopy of Transcript of Records;\n• Certificates of training/seminar attended related to the position applied (for the last five (5) years preceding this publication); and,\n• Certificate of Employment/Service Records.\nQUALIFIED APPLICANTS are advised to hand in or send through courier/ email their application to:\nDR. ROSARIO CLARABEL C. CONTRERAS\nCampus Administrator\nBrgy. Simsiman, Calinog, Iloilo\ncalinog@wvsu.edu.ph\nAPPLICATIONS WITH INCOMPLETE DOCUMENTS SHALL NOT BE ENTERTAINED.', '38', '2023-01-17 18:18:40', 1, '{\"qualifications\":[\"BACHELOR’S DEGREE RELEVANT TO THE JOB\",\"4 hours relevant training\",\"1 year relevant experience\",\"Career service (Professional)\",\"Competency (If applicable): Agriculture graduate; experience/ skills in farm management both in crops and animals; good in communication skills; computer literate; knowledgeable in proposal making or feasibility study for income generation; knowledgeable in supervising and managing farm workers\"]}', 'approved'),
(49, 'Job-Order', 'We are hiring!!\nThe West Visayas State University Calinog Campus is in need of one (1) Job-Order to be assigned at the College of Business Management Laboratory and Mini Hotel.', '41', '2023-01-17 18:31:01', 1, '{\"qualifications\":[\"A graduate of any four (4) year course.\",\"Preferably with knowledge on MS Office Application.\"]}', 'approved'),
(50, 'Part Time Instructors', 'HIRING!!!\nWest Visayas State University Calinog Campus is in need of Two (2) Part Time Instructors for the following areas of specialization:\nPlease see attached photos below for more details ????????⬇️\nFor queries and clarifications, you can email us at calinog.hr@wvsu.edu.ph', '36', '2023-01-17 18:41:10', 2, '{\"qualifications\":[\"A graduate of Bachelor of Science in Information Technology or any allied course;\",\"Preferably NCII Holder\",\"Preferably with teaching experience\"]}', 'approved'),
(51, 'Job-Order', 'We need laboratory technician.', '36', '2023-01-17 19:14:14', 2, '{\"qualifications\":[\"Must have ncII in computer maintenance.\"]}', 'approved');

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
(26, 'Faculty', 'SICT', 'director', 'fgjcf', 'vzxcv', 'dbzbcxz'),
(30, 'Faculty', 'SICT', 'director', 'Janen', ' Caspillo', 'Camare'),
(31, 'Faculty Member', 'Administrative Staff', 'Faculty Staff', 'Andrea', 'aaa', 'Camarig'),
(32, 'Faculty', 'SICT', 'director', '', '', ''),
(33, 'Faculty Member', 'Administrative Staff', 'Faculty Staff', 'adf', 'asd', 'wertggg'),
(34, 'Teaching', 'COA', 'Head Staff', 'irah', 'gojol', 'gojol'),
(35, 'Faculty Member', 'COA', 'Director', 'Jayson', 'Kalibe', 'Kaalll'),
(36, 'Teaching', 'SICT', 'Director', 'Jhosanna', 'Figueroa', 'Linghon'),
(37, 'Teaching', 'COE', 'Director', 'Angela Jean', 'Zambra', 'Gener'),
(38, 'Administrative Staff', 'COA', 'Director', 'Janen', 'Caspillo', 'Camare'),
(39, 'Faculty Member', 'SICT', 'Head Staff', 'Angelyd', 'Camu', 'Pacificar'),
(40, 'Faculty Member', 'CBM', 'Director', 'Emmanuel', 'Despi', 'Katipunan Jr.'),
(41, 'Administrative Staff', 'CBM', 'Director', 'Julius', 'Parcon', 'Dela Cruz'),
(49, 'Administrative Staff', 'Registrar', 'Director', 'Bibiana', 'P', 'Dubouzet'),
(50, 'Administrative Staff', 'Library', 'Director', 'Dinna Joy', 'P', 'Otayde'),
(51, 'Administrative Staff', 'School Farm', 'Director', 'Mardy', 'B', 'Beso'),
(52, 'Administrative Staff', 'School Clinic', 'Director', 'Grace', 'C', 'Castigador'),
(53, 'Administrative Staff', 'Cleric', 'Director', 'Lizel', 'S', 'Triveles'),
(54, 'Administrative Staff', 'Security', 'Director', 'Vicente', 'C', 'Orbino'),
(55, 'Administrative Staff', 'Finance', 'Director', 'Hyacinth', 'M', 'Penaflorida'),
(56, 'Administrative Staff', 'Job Laborers', 'Director', 'Ariel', 'C', 'Deocades Jr.');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `applicants`
--
ALTER TABLE `applicants`
  MODIFY `account_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `applications`
--
ALTER TABLE `applications`
  MODIFY `id` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `interview`
--
ALTER TABLE `interview`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `job_posts`
--
ALTER TABLE `job_posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `panels`
--
ALTER TABLE `panels`
  MODIFY `account_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
