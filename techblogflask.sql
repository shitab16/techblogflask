-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 16, 2021 at 06:03 AM
-- Server version: 8.0.24
-- PHP Version: 7.3.24-(to be removed in future macOS)

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `techblogflask`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int NOT NULL,
  `name` varchar(20) NOT NULL,
  `email` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone` varchar(15) NOT NULL,
  `message` varchar(100) NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `email`, `phone`, `message`, `date`) VALUES
(1, 'stabvsakjb', 'vksjqbjk', 'vjkcqkj', 'svkjbkjv', '2021-05-10 01:31:36'),
(2, 'test1', '', '', '', '2021-05-10 01:32:40'),
(3, 'test1', 'test1@test1', 'testest1', 'cdusgjsag', '2021-05-10 01:33:04'),
(4, 'jvbdasjh', 'jbvsah', 'jbvvqj,bcj,', 'jvbsjbvjhbjhbvjs', '2021-05-10 01:35:03'),
(5, 'bvmbamb', 'wdhbhmb', 'vwhbhj', 'verjwvhbjh', '2021-05-10 01:40:19'),
(6, 'qwjvhbas', 'vb', 'vfhjb', 'vbkuwh', '2021-05-10 01:41:40'),
(8, 'dfjvb', 'vb', 'vfkahkhk', 'hhhh', '2021-05-10 11:02:28'),
(9, 'dfjvb', 'vb', 'vfkahkhk', 'hhhh', '2021-05-10 11:03:06'),
(11, 'sdjh', 'ss', 'ssss', 'ssssss', '2021-05-10 11:03:28'),
(12, 'gs', 'f', 'fd', 'vid', '2021-05-10 11:04:35'),
(13, 'vhbb', 'jdsyg@safh', '732487', 'jgvjhbfdhjbv', '2021-05-10 13:05:48'),
(14, 'vhbb', 'jdsyg@safh', '732487', 'jgvjhbfdhjbv', '2021-05-10 13:18:57'),
(15, 'vhbb', 'jdsyg@safh', '732487', 'jgvjhbfdhjbv', '2021-05-10 13:19:08'),
(16, 'bsvmb', 'jhsabj@jvjhva.com', '3261676', 'vhdsbhsdd', '2021-05-10 13:22:37'),
(17, 'bsvmb', 'jhsabj@jvjhva.com', '3261676', 'vhdsbhsdd', '2021-05-10 13:23:26'),
(18, 'qkjvwkj', 'vrbm', 'vfjkbjb', 'kbewkj', '2021-05-10 13:24:51'),
(19, 'qkjvwkj', 'vrbm', 'vfjkbjb', 'kbewkj', '2021-05-10 13:27:08'),
(20, 'qkjvwkj', 'vrbm', 'vfjkbjb', 'kbewkj', '2021-05-10 13:36:52'),
(21, 'vjskn', 'vnkj', 'vfnk', 'kjvf', '2021-05-10 13:37:12'),
(22, 'vjskn', 'vnkj', 'vfnk', 'kjvf', '2021-05-10 13:38:58');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int NOT NULL,
  `title` varchar(100) NOT NULL,
  `tagline` varchar(500) NOT NULL,
  `slug` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `content` varchar(100) NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `tagline`, `slug`, `content`, `date`) VALUES
(1, 'first post', 'this is my first post', 'first-post', 'I hope this post section turns out nice', '2021-05-14 17:04:57'),
(2, 'second post', 'this is my second post', 'second-post', 'Second is not first and first in not second', '2021-05-15 21:25:49'),
(3, 'added via form', 'form', 'add-form', 'hvhsjbjsjgdscjhbvs bvf', '2021-05-15 20:15:42'),
(4, 'adding via dashboard', 'dashboard op', 'dash-add', 'adding  uhkhasdhauhuv', '2021-05-15 20:30:55'),
(5, 'kfwhgjk', 'sbdjbv', 'vfbdmb', 'dfbjsj', '2021-05-16 00:20:40'),
(7, 'djb', 'hkfvh ', 'SU-fvcj', 'vkj fdkhkhsvd. khvb km gjx', '2021-05-16 00:28:43'),
(8, 'jgsvj', 'ddd', 'dddd-dd', 'dash. sd  ajgj  skk ds hksd ', '2021-05-16 10:25:30');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`),
  ADD KEY `sno` (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
