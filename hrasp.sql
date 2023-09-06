-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 06, 2023 at 03:24 PM
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
(20, 'hrasp', 'hrasp@wvsu.edu.ph', 'admin', 1, 'active'),
(115, 'hrasp', 'samsotto@gmail.com', 'committee-president', 1, 'active'),
(116, 'hrasp', 'madelynpadernal@gmail.com', 'committee-president', 1, 'active'),
(117, 'hrasp', 'theagener@gmail.com', 'committee-president', 1, 'active'),
(118, 'hrasp', 'paulcabayao@gmail.com', 'committee-member', 1, 'active'),
(119, 'hrasp', 'camuchristian@gmail.com', 'committee-member', 1, 'active'),
(120, 'hrasp', 'sanchezsteffie@gmail.com', 'committee-member', 1, 'active'),
(121, 'hrasp', 'lopezleona@gmail.com', 'panel', 1, 'active'),
(122, 'hrasp', 'amadanerisa@gmail.com', 'panel', 1, 'active'),
(123, 'hrasp', 'milbyamelia@gmail.com', 'panel', 1, 'active'),
(124, 'hrasp', 'penidairish@gmail.com', 'panel', 1, 'active'),
(125, 'Meow07!', 'fritzgerardccontreras@gmail.com', 'applicant', 1, 'declined'),
(126, 'Meow07!', 'fritzgerardccontreras@gmail.com', 'applicant', 1, 'active'),
(127, '1234', 'emman199810@gmail.com', 'applicant', 1, 'active'),
(128, 'JHOSANNA23', 'linghon.jhosanna@wvsu.edu.ph', 'applicant', 1, 'active'),
(129, '1234', 'gener.angelajean@wvsu.edu.ph', 'applicant', 1, 'active'),
(130, '1234', 'pamplona.kristinejean@wvsu.edu.ph', 'applicant', 1, 'active'),
(131, '1234', 'cabalfin.johnlevi@wvsu.edu.ph', 'applicant', 1, 'active'),
(132, '1234', 'delacruz.julius@gmail.com', 'applicant', 1, 'active'),
(133, '1234', 'guillergan.sandra@gmail.com', 'applicant', 1, 'active'),
(134, '1234', 'pacificar.angelyd@wvsu.edu.ph', 'applicant', 1, 'active'),
(135, '1234', 'beso.meldygrace@wvsu.edu.ph', 'applicant', 1, 'active'),
(136, '', 'emman@gmai.com', 'applicant', 1, 'pending'),
(137, '1234', 'jacob@gmail.com', 'applicant', 1, 'active'),
(138, '1234', 'samjelteo@gmail.com', 'applicant', 1, 'active'),
(139, '1234', 'pratiimmd@gmail.com', 'applicant', 1, 'active');

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
  `gender` varchar(6) NOT NULL,
  `age` int(3) DEFAULT NULL,
  `birthday` date NOT NULL,
  `contact` varchar(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `applicants`
--

INSERT INTO `applicants` (`account_id`, `firstname`, `middlename`, `lastname`, `gender`, `age`, `birthday`, `contact`) VALUES
(125, 'Fritz Gerard', 'Casiple', 'Contreras', 'male', 32, '1990-11-07', '09774029731'),
(126, 'Fritz Gerard', 'Casiple', 'Contreras', 'male', 18, '1997-11-11', '09774029731'),
(127, 'Emmanuel', 'Despi', 'Katipunan', 'male', 24, '1998-10-30', '+69162400105'),
(128, 'Jhosanna', 'Figueroa', 'Linghon', 'Female', 23, '1999-06-26', '09511362156'),
(129, 'Angela Jane', 'Zambra', 'Gener', 'Female', 21, '2001-04-29', '+63 985607661'),
(130, 'Kristine Jean', 'Moreno', 'Pamplona', 'male', 23, '2000-08-20', '+63 970126115'),
(131, 'John Levi', 'Langub', 'Cabalfin', 'male', 23, '2000-01-21', '+63 927362156'),
(132, 'Julius', 'Parcon', 'Dela cruz', 'male', 28, '1994-07-31', '+63 950007308'),
(133, 'Sandra', 'Linghon', 'Guillergan', 'Female', 30, '1992-10-26', '+63 927362156'),
(134, 'Angelyd', 'Camu', 'Pacificar', 'Female', 29, '0000-00-00', '+63 940001235'),
(135, 'Meldy Grace', 'Lasap', 'Beso', 'male', 22, '2000-12-03', '+63 956213498'),
(137, 'Jacob', 'Helsy', 'Urged', 'male', NULL, '2000-02-10', '9123456782'),
(138, 'Angelyd', 'Camu', 'Pacificar', 'Female', NULL, '1997-03-19', '9868575885'),
(139, 'Bryan', 'Casa', 'Cabigting', 'male', NULL, '2005-06-09', '9123456789');

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
(61, 125, 107, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\Plant Nursery Monitoring System.docx\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\Plant Nursery Monitoring System.docx\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\85f677cd4bd88e63dbd99b7c9fc41c6f.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\maxresdefault.jpg\"]}', 'for-evaluation'),
(62, 127, 107, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\PERSONAL DATA  6.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\Cover Letter For Job Application.pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\OIP_014.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\OIP_017.jpg\",\"uploads\\\\applicant\\\\certs\\\\OIP_018.jpg\"]}', 'for-evaluation'),
(63, 128, 107, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\personal data 1.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\PERSONAL DATA 2.pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\OIP_014.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\OIP_015.jpg\"]}', 'for-evaluation'),
(64, 129, 108, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\PERSONAL DATA 2.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\PERSONAL DATA 3.pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\OIP_017.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\OIP_018.jpg\"]}', 'for-evaluation'),
(65, 130, 107, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\PERSONAL DATA 5.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\personal data 7.pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\OIP_019.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\OIP_020.jpg\"]}', 'for-evaluation'),
(66, 131, 108, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\PESONAL DATA 4.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\PERSONAL DATA  6.pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\OIP_014.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\OIP_015.jpg\"]}', 'for-evaluation'),
(67, 132, 108, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\PERSONAL DATA  6.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\PERSONAL DATA 2.pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\OIP_018.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\OIP_020.jpg\"]}', 'for-interview'),
(68, 133, 108, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\PERSONAL DATA  6.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\PERSONAL DATA 5.pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\OIP_021.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\OIP_022.jpg\"]}', 'for-interview'),
(69, 134, 108, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\PERSONAL DATA 5.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\PERSONAL DATA 3.pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\OIP_015.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\OIP_018.jpg\"]}', 'pending'),
(70, 135, 107, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\PERSONAL DATA  6.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\PERSONAL DATA 3.pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\OIP_018.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\OIP_020.jpg\"]}', 'for-interview'),
(71, 138, 109, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\Finals -1.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\Finals -1.pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\20181227_141621.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\20181227_141621.jpg\",\"uploads\\\\applicant\\\\certs\\\\20181227_141628.jpg\",\"uploads\\\\applicant\\\\certs\\\\332714153_1404274053746231_6753778761401805910_n.jpg\"]}', 'for-interview'),
(72, 139, 107, '{\"letter\":[\"uploads\\\\applicant\\\\letters\\\\Cover Letter For Job Application.pdf\"]}', '{\"pds\":[\"uploads\\\\applicant\\\\pds\\\\PERSONAL DATA  6.pdf\"]}', '{\"tors\":[\"uploads\\\\applicant\\\\tor\\\\OIP.jpg\",\"uploads\\\\applicant\\\\tor\\\\OIP_002.jpg\",\"uploads\\\\applicant\\\\tor\\\\OIP_003.jpg\",\"uploads\\\\applicant\\\\tor\\\\OIP_004.jpg\"]}', '{\"certificates\":[\"uploads\\\\applicant\\\\certs\\\\OIP_003.jpg\"]}', 'for-evaluation');

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
(115, 'Sam', 'Tupaz', 'Sotto', 'Non Teaching', 'president'),
(116, 'Madelyn ', 'Lozada', 'Padernal', 'Teaching', 'president'),
(117, 'Thea', 'Camacho', 'Gener', 'All', 'president'),
(118, 'Paul', 'Camare', 'Cabayao', 'All', 'member'),
(119, 'Christian ', 'Plaza', 'Camu', 'All', 'member'),
(120, 'Steffie', 'Vera', 'Sanchez', 'All', 'member');

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
('122a2545-718b-4f24-83c8-d8768caf3fde', 62, '118', '[{\"mainRate\":5,\"minRates\":[2,1,2]},{\"mainRate\":5.25,\"minRates\":[2,1.25,1,1]},{\"mainRate\":5,\"minRates\":[2.5,2.5]},{\"mainRate\":5,\"minRates\":[]}]', 20, 'Possible further consideration', '2023-04-24 11:48:04', 'Nice', 'Computer Programming'),
('177c1c4a-8f96-4d93-b10c-b4e0f263bdee', 70, '118', NULL, NULL, NULL, '2023-04-24 11:52:33', NULL, NULL),
('1d3fcb84-ad86-4732-9914-ae1c85d73ec8', 63, '116', NULL, NULL, NULL, '2023-04-23 23:10:23', NULL, NULL),
('1db14aa2-3830-45ee-9728-f007a9d94282', 61, '116', '[{\"mainRate\":5,\"minRates\":[2,1,2]},{\"mainRate\":5.75,\"minRates\":[2,1.25,1.25,1.25]},{\"mainRate\":5,\"minRates\":[2.5,2.5]},{\"mainRate\":5,\"minRates\":[]}]', 21, '', '2023-03-09 10:30:45', 'nw', 'Information Technology'),
('5f8fc014-3cbb-4ffb-b80f-b1b0a26a3d53', 61, '118', '[{\"mainRate\":5,\"minRates\":[2,1,2]},{\"mainRate\":5,\"minRates\":[1.5,1.25,1,1.25]},{\"mainRate\":5,\"minRates\":[2.5,2.5]},{\"mainRate\":5,\"minRates\":[]}]', 20, 'Possible further consideration', '2023-04-23 21:25:54', 'Has a lot of professional experience', 'Education'),
('6d0935a7-c143-4d63-8daa-8859193ee0d0', 67, '118', '[{\"mainRate\":5,\"minRates\":[2,1,2]},{\"mainRate\":3.75,\"minRates\":[0,1.25,1.25,1.25]},{\"mainRate\":5,\"minRates\":[2.5,2.5]},{\"mainRate\":5,\"minRates\":[]}]', 19, 'Possible further consideration', '2023-04-24 11:54:01', 'has lot of experience', 'Business Administration'),
('c98c26da-2868-4881-a4c2-18d95f2412b1', 63, '118', '[{\"mainRate\":3.75,\"minRates\":[1.25,1,1.5]},{\"mainRate\":5,\"minRates\":[1.75,1.25,0.75,1.25]},{\"mainRate\":5,\"minRates\":[2.5,2.5]},{\"mainRate\":5,\"minRates\":[]}]', 19, 'Definitely to be considered', '2023-04-23 21:42:59', 'Wide knowledge in network technologies', 'Networking'),
('cf1c0a55-fadc-4293-89b8-7ce9d3d822fe', 64, '118', '[{\"mainRate\":4.75,\"minRates\":[2,1,1.75]},{\"mainRate\":5.25,\"minRates\":[2,1,1,1.25]},{\"mainRate\":3.25,\"minRates\":[1.5,1.75]},{\"mainRate\":0,\"minRates\":[]}]', 13, 'Possible further consideration', '2023-04-24 11:53:00', 'Fine', 'Hotel Management'),
('d5a1d80b-c57d-4828-9163-69accc058652', 65, '118', '[{\"mainRate\":4.5,\"minRates\":[2,0.5,2]},{\"mainRate\":5.25,\"minRates\":[1.5,1.25,1.25,1.25]},{\"mainRate\":4.5,\"minRates\":[2.5,2]},{\"mainRate\":0,\"minRates\":[]}]', 14, 'Possible further consideration', '2023-04-24 11:50:48', 'Very skilled in photoshop', 'Multimedia'),
('e0a03021-14f5-4e92-a5b0-589691537c35', 72, '116', '[{\"mainRate\":4.75,\"minRates\":[2,1,1.75]},{\"mainRate\":5.75,\"minRates\":[2,1.25,1.25,1.25]},{\"mainRate\":5,\"minRates\":[2.5,2.5]},{\"mainRate\":1,\"minRates\":[]}]', 17, 'Definitely to be considered', '2023-05-19 10:42:38', 'sdfsd', 'IT'),
('e1d4f02a-25d5-41e6-997b-ee0052a0e977', 61, '121', '[{\"mainRate\":4,\"minRates\":[1.5,1,1.5]},{\"mainRate\":5.75,\"minRates\":[2,1.25,1.25,1.25]},{\"mainRate\":4.75,\"minRates\":[2.5,2.25]},{\"mainRate\":5,\"minRates\":[]}]', 20, 'Definitely to be considered', '2023-04-23 22:04:28', 'Very Creative', 'Film Making');

-- --------------------------------------------------------

--
-- Table structure for table `favourites`
--

CREATE TABLE `favourites` (
  `favourite_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `panel_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `favourites`
--

INSERT INTO `favourites` (`favourite_id`, `application_id`, `panel_id`) VALUES
(30, 63, 121),
(31, 62, 121),
(37, 62, 118),
(38, 62, 118),
(40, 61, 20);

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
(36, 61, '2023-03-09', '10:07:00', 'ba9041b6-8d01-4462-9166-06c82a853f30', 'starting'),
(37, 63, '2023-04-13', '19:04:00', 'c4092cdf-f753-4c82-834c-96645c76cb84', 'starting'),
(40, 62, '2023-04-20', '13:20:00', 'ee6dd3b4-3ce7-4189-9d7c-9080df88a563', 'starting'),
(41, 65, '2023-04-20', '13:33:00', 'c489e07d-6d2d-4b5d-87b4-0c09317a60e6', 'starting'),
(42, 64, '2023-04-20', '13:33:00', '0c207de5-b5fb-4385-a2fc-adc5d6990771', 'starting'),
(43, 67, '2023-04-23', '01:54:00', '788e2b1d-5980-409c-9e8b-aabf3b447fdd', 'starting'),
(46, 66, '2023-05-19', '10:10:00', '4afc0cb1-0054-4663-a461-c07d66ac0976', 'starting'),
(47, 72, '2023-05-19', '10:35:00', '33e40696-f83c-4870-93c2-a0db5e181798', 'starting');

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
(107, 'Part Time Instructor', 'HIRING!!!\nWest Visayas State University Calinog Campus is in need of  Part Time Instructors for the following areas of specialization.', '121', '2023-03-08 16:33:02', 2, '{\"qualifications\":[\"A graduate of Bachelor of Science in Information Technology or allied courses\",\"Prefrerably NCII holder\",\"Preferably with teaching experience\"]}', 'approved'),
(108, 'Part Time Instructor', 'HIRING!!!\nWest Visayas State University Calinog Campus is in need a Two (2 ) Part Time Instructors.\nPlease see attached photos below for more details 👇👇⬇️\nFor queries and clarifications, you can email us at calinog.hr@wvsu.edu.ph', '122', '2023-03-08 16:42:21', 2, '{\"qualifications\":[\"A graduate of Bachelor of Business Administration or any allied courses\",\"Preferably NCII holder\",\"Preferably with teaching experience\"]}', 'approved'),
(109, 'ParT Time Instructor', 'West Visayas State University Calinog Campus is in need a ONE (1 ) Part Time Instructors.\nPlease see attached photos below for more details 👇👇⬇️\nFor queries and clarifications, you can email us at calinog.hr@wvsu.edu.ph', '123', '2023-03-08 16:46:37', 1, '{\"qualifications\":[\"A graduate of Bachelor of Science in Agriculture or any allied courses\",\"Preferably LET passer\",\"Preferably with teaching experience\"]}', 'approved'),
(110, 'Part Time Instructor', 'West Visayas State University Calinog Campus is in need a One (1 ) Part Time Instructors.\nPlease see attached photos below for more details 👇👇⬇️\nFor queries and clarifications, you can email us at calinog.hr@wvsu.edu.ph', '124', '2023-03-08 16:51:28', 1, '{\"qualifications\":[\"A graduate of Bachelor of Science in Secondary Education major in English or any allied courses\",\"Preferably LET passer\",\"Preferably with teaching experience\"]}', 'approved'),
(111, 'Part Time Instructor', 'West Visayas State University Calinog Campus is in need a One (1) Part Time Instructors.\nPlease see attached photos below for more details 👇👇⬇️\nFor queries and clarifications, you can email us at calinog.hr@wvsu.edu.ph', '124', '2023-03-08 16:54:28', 1, '{\"qualifications\":[\"A graduate of Bachelor of Science in Secondary Education major in Mathematics\",\"Preferably LET passer\",\"Preferably with teaching experience\"]}', 'approved'),
(112, 'Part Time Instructor', 'sdfgads ij', '121', '2023-05-19 02:47:18', 3, '{\"qualifications\":[\"asdfgasdg\",\"xdfgzdfg\",\"zsdfzfg\"]}', 'approved');

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
(121, 'Teaching', 'SICT', 'Director', 'Leona', 'Gill', 'Lopez'),
(122, 'Teaching', 'CBM', 'Director', 'Nerisa', 'Lopez', 'Amada'),
(123, 'Teaching', 'COA', 'Director', 'Amelia', 'Pento', 'Milby'),
(124, 'Teaching', 'COE', 'Director', 'Irish', 'Gojol', 'Penida');

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
  ADD PRIMARY KEY (`id`),
  ADD KEY `email` (`email`);

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `applicants`
--
ALTER TABLE `applicants`
  ADD PRIMARY KEY (`account_id`),
  ADD KEY `account_id` (`account_id`);

--
-- Indexes for table `applications`
--
ALTER TABLE `applications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `applicant_id` (`applicant_id`),
  ADD KEY `job_id` (`job_id`);

--
-- Indexes for table `committees`
--
ALTER TABLE `committees`
  ADD PRIMARY KEY (`account_id`),
  ADD KEY `account_id` (`account_id`);

--
-- Indexes for table `evaluations`
--
ALTER TABLE `evaluations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `application_id` (`application_id`),
  ADD KEY `evaluator` (`evaluator`);

--
-- Indexes for table `favourites`
--
ALTER TABLE `favourites`
  ADD PRIMARY KEY (`favourite_id`);

--
-- Indexes for table `interview`
--
ALTER TABLE `interview`
  ADD PRIMARY KEY (`id`),
  ADD KEY `application_id` (`application_id`);

--
-- Indexes for table `job_posts`
--
ALTER TABLE `job_posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `poster` (`poster`);

--
-- Indexes for table `panels`
--
ALTER TABLE `panels`
  ADD PRIMARY KEY (`account_id`),
  ADD KEY `account_id` (`account_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=140;

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `applicants`
--
ALTER TABLE `applicants`
  MODIFY `account_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=140;

--
-- AUTO_INCREMENT for table `applications`
--
ALTER TABLE `applications`
  MODIFY `id` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `favourites`
--
ALTER TABLE `favourites`
  MODIFY `favourite_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `interview`
--
ALTER TABLE `interview`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `job_posts`
--
ALTER TABLE `job_posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=113;

--
-- AUTO_INCREMENT for table `panels`
--
ALTER TABLE `panels`
  MODIFY `account_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=125;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `applicants`
--
ALTER TABLE `applicants`
  ADD CONSTRAINT `applicants_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `applications`
--
ALTER TABLE `applications`
  ADD CONSTRAINT `applications_ibfk_1` FOREIGN KEY (`applicant_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `applications_ibfk_2` FOREIGN KEY (`job_id`) REFERENCES `job_posts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `committees`
--
ALTER TABLE `committees`
  ADD CONSTRAINT `committees_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `evaluations`
--
ALTER TABLE `evaluations`
  ADD CONSTRAINT `evaluations_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `applications` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `interview`
--
ALTER TABLE `interview`
  ADD CONSTRAINT `interview_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `applications` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `panels`
--
ALTER TABLE `panels`
  ADD CONSTRAINT `panels_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
