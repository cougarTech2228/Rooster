-- phpMyAdmin SQL Dump
-- version 4.5.4.1
-- http://www.phpmyadmin.net
--
-- Host: 10.132.1.182:3306
-- Generation Time: Feb 18, 2016 at 03:07 AM
-- Server version: 10.0.23-MariaDB-1~trusty-log
-- PHP Version: 5.5.9-1ubuntu4.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `Rooster`
--
CREATE DATABASE IF NOT EXISTS `Rooster` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `Rooster`;

-- --------------------------------------------------------

--
-- Table structure for table `audit`
--

CREATE TABLE `audit` (
  `id` int(11) NOT NULL COMMENT 'Relational ID',
  `time` datetime NOT NULL COMMENT 'Date of audit',
  `member_id` int(11) DEFAULT NULL COMMENT 'Action done by member id',
  `action_code` int(11) NOT NULL COMMENT 'Action code (Used for in-code reference and humanization)',
  `item_id` int(11) NOT NULL COMMENT 'Affecting item with ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Audit log table';

-- --------------------------------------------------------

--
-- Table structure for table `emails`
--

CREATE TABLE `emails` (
  `id` int(11) NOT NULL COMMENT 'Relational ID',
  `subject` varchar(79) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Email subject',
  `subteam_id` int(11) DEFAULT NULL COMMENT 'Email to subteam or null for all',
  `to_parents` tinyint(1) NOT NULL DEFAULT '0',
  `body_html` text COLLATE utf8mb4_unicode_ci COMMENT 'HTML body contents',
  `body_plain` text COLLATE utf8mb4_unicode_ci COMMENT 'Plain text body contents',
  `creation_time` datetime NOT NULL COMMENT 'Time created',
  `created_by_id` int(11) DEFAULT NULL COMMENT 'Member ID of creator',
  `last_updated_time` datetime NOT NULL COMMENT 'Last updated time',
  `last_updated_by_id` int(11) DEFAULT NULL COMMENT 'Last updated by member',
  `sent_time` datetime DEFAULT NULL COMMENT 'Time sent/to be sent',
  `sent_by_id` int(11) DEFAULT NULL COMMENT 'Member ID that sent it',
  `is_sent` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Is sent'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table used for storing email contents.';

-- --------------------------------------------------------

--
-- Table structure for table `email_read_by`
--

CREATE TABLE `email_read_by` (
  `id` int(11) NOT NULL COMMENT 'Relational ID',
  `email_id` int(11) NOT NULL COMMENT 'Email ID',
  `member_id` int(11) DEFAULT NULL COMMENT 'Member ID',
  `parent_id` int(11) DEFAULT NULL COMMENT 'Parent ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Email marked as read table.';

-- --------------------------------------------------------

--
-- Table structure for table `meetings`
--

CREATE TABLE `meetings` (
  `id` int(11) NOT NULL COMMENT 'Relational ID',
  `start_time` datetime NOT NULL COMMENT 'Start time of the meeting',
  `end_time` datetime NOT NULL COMMENT 'End time of the meeting',
  `description` text COLLATE utf8mb4_unicode_ci COMMENT 'Description for the meeting',
  `creation_time` datetime NOT NULL COMMENT 'Creation time of the meeting',
  `created_by_id` int(11) DEFAULT NULL COMMENT 'Member that created the meeting',
  `last_updated_time` datetime NOT NULL COMMENT 'Meeting last updated time',
  `last_updated_by_id` int(11) DEFAULT NULL COMMENT 'Meeting last updated by member'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `meeting_attendance`
--

CREATE TABLE `meeting_attendance` (
  `id` int(11) NOT NULL COMMENT 'Relational ID',
  `meeting_id` int(11) NOT NULL COMMENT 'Meeting ID',
  `member_id` int(11) NOT NULL COMMENT 'Member ID',
  `present` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Are they present?'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Meeting attendance table.';

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

CREATE TABLE `members` (
  `id` int(11) NOT NULL COMMENT 'Relational ID',
  `email` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Team member email',
  `first_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'First name',
  `last_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Last name',
  `birth_date` date DEFAULT NULL COMMENT 'DOB',
  `phone` int(15) NOT NULL COMMENT 'Phone number',
  `school_id` int(11) DEFAULT NULL COMMENT 'School ID',
  `grade` int(2) DEFAULT NULL COMMENT 'Grade',
  `subteam_id` int(11) DEFAULT NULL COMMENT 'Subteam ID',
  `address_1` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Address line one',
  `address_2` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Address line two',
  `city` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'City',
  `state` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'State',
  `zip` int(5) DEFAULT NULL COMMENT 'Zip code',
  `member_since` date NOT NULL COMMENT 'Member since date',
  `left_team_at` date DEFAULT NULL COMMENT 'Left team date',
  `password` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Hashed and salted password'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table is used for defining the members basic information.';

-- --------------------------------------------------------

--
-- Table structure for table `member_meta`
--

CREATE TABLE `member_meta` (
  `id` int(11) NOT NULL COMMENT 'ID for relation',
  `member_id` int(11) NOT NULL COMMENT 'ID of member.',
  `meta` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Meta information on members.';

-- --------------------------------------------------------

--
-- Table structure for table `parents`
--

CREATE TABLE `parents` (
  `id` int(11) NOT NULL COMMENT 'Relational ID',
  `member_id` int(11) NOT NULL COMMENT 'Member ID that the parent belongs to',
  `first_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'First name',
  `last_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Last name',
  `email` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Email',
  `phone` int(15) NOT NULL COMMENT 'Phone',
  `address_1` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Address line one',
  `address_2` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Address line two',
  `city` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'City',
  `state` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'State',
  `zip` int(5) DEFAULT NULL COMMENT 'Zip'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table for storing parent information.';

-- --------------------------------------------------------

--
-- Table structure for table `schools`
--

CREATE TABLE `schools` (
  `id` int(11) NOT NULL COMMENT 'School ID used for relations',
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Human name for the school',
  `address_1` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Address line one',
  `address_2` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Address line two',
  `city` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'City',
  `state` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'State',
  `zip` int(5) DEFAULT NULL COMMENT 'Zip',
  `phone` int(15) DEFAULT NULL COMMENT 'Phone number'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table used for creating school relations and information';

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL COMMENT 'Relational ID',
  `setting` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Setting name',
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Setting value'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subteams`
--

CREATE TABLE `subteams` (
  `id` int(11) NOT NULL COMMENT 'Subteam id used for relations.',
  `name` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Human readable team name',
  `privilege_level` int(11) NOT NULL COMMENT 'Privilege level in rooster',
  `parent_id` int(11) DEFAULT NULL COMMENT 'Parent subteam ID.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Subteam table used for permissions and assignments.';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audit`
--
ALTER TABLE `audit`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_id` (`member_id`);

--
-- Indexes for table `emails`
--
ALTER TABLE `emails`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subteam_id` (`subteam_id`),
  ADD KEY `created_by_id` (`created_by_id`),
  ADD KEY `last_updated_by_id` (`last_updated_by_id`),
  ADD KEY `sent_by_id` (`sent_by_id`),
  ADD KEY `subteam_id_2` (`subteam_id`);

--
-- Indexes for table `email_read_by`
--
ALTER TABLE `email_read_by`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `member_id` (`member_id`),
  ADD KEY `email_id` (`email_id`);

--
-- Indexes for table `meetings`
--
ALTER TABLE `meetings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by_id` (`created_by_id`),
  ADD KEY `last_updated_by_id` (`last_updated_by_id`);

--
-- Indexes for table `meeting_attendance`
--
ALTER TABLE `meeting_attendance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `meeting_id` (`meeting_id`),
  ADD KEY `member_id` (`member_id`);

--
-- Indexes for table `members`
--
ALTER TABLE `members`
  ADD PRIMARY KEY (`id`),
  ADD KEY `school` (`school_id`),
  ADD KEY `subteam` (`subteam_id`),
  ADD KEY `subteam_id` (`subteam_id`),
  ADD KEY `subteam_id_2` (`subteam_id`);

--
-- Indexes for table `member_meta`
--
ALTER TABLE `member_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_id` (`member_id`);

--
-- Indexes for table `parents`
--
ALTER TABLE `parents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_id` (`member_id`);

--
-- Indexes for table `schools`
--
ALTER TABLE `schools`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subteams`
--
ALTER TABLE `subteams`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parent` (`parent_id`),
  ADD KEY `parent_2` (`parent_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audit`
--
ALTER TABLE `audit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Relational ID';
--
-- AUTO_INCREMENT for table `emails`
--
ALTER TABLE `emails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Relational ID';
--
-- AUTO_INCREMENT for table `email_read_by`
--
ALTER TABLE `email_read_by`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Relational ID';
--
-- AUTO_INCREMENT for table `meetings`
--
ALTER TABLE `meetings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Relational ID';
--
-- AUTO_INCREMENT for table `meeting_attendance`
--
ALTER TABLE `meeting_attendance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Relational ID';
--
-- AUTO_INCREMENT for table `members`
--
ALTER TABLE `members`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Relational ID';
--
-- AUTO_INCREMENT for table `member_meta`
--
ALTER TABLE `member_meta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID for relation';
--
-- AUTO_INCREMENT for table `parents`
--
ALTER TABLE `parents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Relational ID';
--
-- AUTO_INCREMENT for table `schools`
--
ALTER TABLE `schools`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'School ID used for relations';
--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Relational ID';
--
-- AUTO_INCREMENT for table `subteams`
--
ALTER TABLE `subteams`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Subteam id used for relations.';
--
-- Constraints for dumped tables
--

--
-- Constraints for table `audit`
--
ALTER TABLE `audit`
  ADD CONSTRAINT `audit_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `emails`
--
ALTER TABLE `emails`
  ADD CONSTRAINT `emails_ibfk_1` FOREIGN KEY (`created_by_id`) REFERENCES `members` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `emails_ibfk_2` FOREIGN KEY (`last_updated_by_id`) REFERENCES `members` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `emails_ibfk_3` FOREIGN KEY (`sent_by_id`) REFERENCES `members` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `emails_ibfk_4` FOREIGN KEY (`subteam_id`) REFERENCES `subteams` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `email_read_by`
--
ALTER TABLE `email_read_by`
  ADD CONSTRAINT `email_read_by_ibfk_1` FOREIGN KEY (`email_id`) REFERENCES `emails` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `email_read_by_ibfk_2` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `email_read_by_ibfk_3` FOREIGN KEY (`parent_id`) REFERENCES `parents` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `meetings`
--
ALTER TABLE `meetings`
  ADD CONSTRAINT `meetings_ibfk_1` FOREIGN KEY (`created_by_id`) REFERENCES `members` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `meetings_ibfk_2` FOREIGN KEY (`last_updated_by_id`) REFERENCES `members` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `meeting_attendance`
--
ALTER TABLE `meeting_attendance`
  ADD CONSTRAINT `meeting_attendance_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `meeting_attendance_ibfk_2` FOREIGN KEY (`meeting_id`) REFERENCES `meetings` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `members`
--
ALTER TABLE `members`
  ADD CONSTRAINT `members_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `members_ibfk_2` FOREIGN KEY (`subteam_id`) REFERENCES `subteams` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `member_meta`
--
ALTER TABLE `member_meta`
  ADD CONSTRAINT `member_meta_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `parents`
--
ALTER TABLE `parents`
  ADD CONSTRAINT `parents_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `subteams`
--
ALTER TABLE `subteams`
  ADD CONSTRAINT `subteams_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `subteams` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
