-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 25, 2021 at 09:59 PM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `Coolblogs`
--

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(50) NOT NULL,
  `title` text NOT NULL,
  `slug` varchar(25) NOT NULL,
  `content` text NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `img_name` varchar(20) NOT NULL,
  `tagline` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `slug`, `content`, `date`, `img_name`, `tagline`) VALUES
(1, 'Automate Your Instagram(Selenium) Part-1', 'first-post', 'Hello World! (cliche), Today I’ll share a fun project to Automate Your Instagram.\r\nPrerequisites:\r\nBasic Knowledge of Python.\r\nHave Selenium Installed (Tutorial=https://bit.ly/3lVKnYP)\r\n\r\nThis is one of the most useful scripts in my opinion for an Instagram page, let\'s suppose you open a coding page and you want to gather an audience of same interest to your page, Best way is to follow all followers of the top coding pages, which helps you to get noticed. You can also use the “names” list and use that in the loop with follow function to follow them.Sit back and watch the magic happening in front of your eyes!\r\nThis was Part 1 of Automating Your Instagram through selenium. Comment down below if you want another part where I automate\r\nRemoving Followers who aren\'t following you back.\r\nLike all Posts\r\nAutomatic comments on posts of specific hashtags\r\nGather Hashtags of famous pages to understand which Hashtag gets the best reach and much more!\r\n\r\nThat’s all, Now follow my steps!\r\nGithub Link: https://github.com/atharvjairath/Insta_bot_Selenium\r\nAfter You have completed the installation of Selenium and respected Browser driver (in my case Chrome), let\'s Start Coding Wohoooo!!!\r\nFirst, we will Import all the necessary packages and libraries.', '2021-03-26 02:08:54', 'Home3.jpg', 'Instagram Automation'),
(2, 'How to Study for Data-Structures and Algorithms Interviews at FAANG', 'second-post', 'I discarded this notion of the mythical engineer who can on a whim pass a tech interview and started to appreciate the reality of the situation, that tech interviews are like the SAT’s they give in school. It doesn’t matter that you spent four years learning all of the content in high school, you still need to prep if you want to ace the test. Just like with the SATs all of your past work and grades don’t contribute to the score. Your success depends entirely on how well you perform on the test.\r\nOnce I realized the truth, that everybody needs to study, it was enough motivation for me to put in the hard work since I realized that’s what my competition was doing. Through that motivation, I formed a process for studying that helped me pass every tech screen and on-site interview I did in 2019. I, a college dropout, passed technical screens for Stripe, Coinbase and Triplebyte. I passed screens and on-site interviews for Google, Amazon, Uber (again), Reddit, Squarespace and Braze. A 100% pass rate wasn’t expected and isn’t likely to continue to happen, but I believe focusing on the fundamentals helps approach that goal.\r\n', '2021-03-24 14:54:00', 'home3', 'Data Structures'),
(3, 'Build Simple Restful Api With Python and Flask Part 1', 'flask', 'I assumed that you have python 2.7 and pip installed on your computer. I have tested the code presented in this article on python 2.7, though it likely be okay on python 3.4 or newer.\r\na. Installing flask\r\nFlask is microframework for python. The “micro” in microframework means Flask aims to keep the core simple but extensible (http://flask.pocoo.org/docs/0.12/foreword/#what-does-micro-mean). You could installing flask with the following command:\r\n$ pip install Flask\r\nb. Prepare your IDE\r\nActually you could using all kind of text editor to build python app, but it would much easier if your are using IDE. Personally I prefer using Pycharm from jetbrains(https://www.jetbrains.com/pycharm/).\r\nc. Create “Hello World” in flask\r\nFirst you need to create your project folder, for this tutorial i will named it “flask_tutorial”. If you are using pycharm you could create project folder by choosing File and New Project from menus.\r\n', '2021-03-24 20:34:15', 'home2.jpg', 'Flask'),
(4, 'Five Years After The Higgs, What Else Has The LHC Found?', 'LHC', 'It’s now just over five years since the two major collaborations at the Large Hadron Collider — CMS and ATLAS — jointly announced the discovery of a new particle with never-before-seen properties: the Higgs boson. It was the first fundamental scalar particle ever discovered, the first particle with spin = 0, the first particle with a rest energy of 126 GeV, and the last predicted, missing particle from the Standard Model of particle physics. With the discovery of the Higgs boson, that Standard Model was finally completed. All the other particles and antiparticles had previously given way to direct detection, and with the Higgs, we’ve now found every particle that we can predict ought to exist. Yet there are a huge number of unsolved mysteries in physics, and over five years later, the LHC has shown us no new hints of what’s next. Here’s a recap of what the LHC has and hasn’t found, and what it means for what’s next.\r\n', '2021-03-26 02:27:50', 'lhc.jpg', 'Higgs Boson at the LHC');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
