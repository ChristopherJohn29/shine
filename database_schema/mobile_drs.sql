-- MySQL dump 10.13  Distrib 5.7.25, for Linux (x86_64)
--
-- Host: localhost    Database: mobile_drs
-- ------------------------------------------------------
-- Server version 5.7.25-0ubuntu0.16.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `home_health_care`
--

DROP TABLE IF EXISTS `home_health_care`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `home_health_care` (
  `hhc_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `hhc_name` varchar(45) DEFAULT NULL,
  `hhc_contact_name` varchar(45) DEFAULT NULL,
  `hhc_phoneNumber` varchar(45) DEFAULT NULL,
  `hhc_faxNumber` varchar(45) DEFAULT NULL,
  `hhc_email` varchar(45) DEFAULT NULL,
  `hhc_address` varchar(255) DEFAULT NULL,
  `hhc_dateCreated` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`hhc_id`),
  FULLTEXT KEY `hhc_contact_name` (`hhc_contact_name`)
) ENGINE=InnoDB AUTO_INCREMENT=341 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

CREATE TABLE `home_health_care_notes` ( `hhcn_id` INT NOT NULL AUTO_INCREMENT , `hhcn_notes` VARCHAR(2000) NOT NULL , `hhcn_date` DATE NOT NULL , `hhcn_userID` INT NOT NULL , `hhcn_hhcID` INT NOT NULL, `hhcn_archive` INT NULL, PRIMARY KEY (`hhcn_id`)) ENGINE = InnoDB;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient` (
  `patient_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `patient_name` varchar(90) DEFAULT NULL,
  `patient_gender` varchar(10) DEFAULT NULL,
  `patient_medicareNum` varchar(45) DEFAULT NULL,
  `patient_dateOfBirth` date DEFAULT NULL,
  `patient_phoneNum` varchar(45) DEFAULT NULL,
  `patient_address` varchar(255) DEFAULT NULL,
  `patient_hhcID` int(10) unsigned DEFAULT NULL,
  `patient_dateCreated` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `patient_caregiver_family` varchar(45) DEFAULT NULL,
  `patient_placeOfService` int(10) unsigned DEFAULT NULL,
  `patient_pharmacy` varchar(255) DEFAULT NULL,
  `patient_pharmacyPhone` varchar(45) DEFAULT NULL,
  `patient_drug_allergy` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`patient_id`),
  KEY `patient_hhcID_idx` (`patient_hhcID`),
  KEY `patient_placeOfService_idx` (`patient_placeOfService`),
  CONSTRAINT `patient_hhcID` FOREIGN KEY (`patient_hhcID`) REFERENCES `home_health_care` (`hhc_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_placeOfService` FOREIGN KEY (`patient_placeOfService`) REFERENCES `place_of_service` (`pos_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6512 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patient_CPO`
--

DROP TABLE IF EXISTS `patient_CPO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_CPO` (
  `ptcpo_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ptcpo_patientID` int(10) unsigned DEFAULT NULL,
  `ptcpo_period` varchar(45) DEFAULT NULL,
  `ptcpo_dateSigned` date DEFAULT NULL,
  `ptcpo_firstMonthCPO` varchar(45) DEFAULT NULL,
  `ptcpo_secondMonthCPO` varchar(45) DEFAULT NULL,
  `ptcpo_thirdMonthCPO` varchar(45) DEFAULT NULL,
  `ptcpo_dischargeDate` date DEFAULT NULL,
  `ptcpo_dateBilled` date DEFAULT NULL,
  `ptcpo_status` varchar(30) DEFAULT NULL,
  `ptcpo_dateCreated` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `ptcpo_archive` tinyint(1) DEFAULT NULL,
  `ptcpo_addedByUserID` int(10) unsigned DEFAULT NULL,
  `ptcpo_dateOfService` date DEFAULT NULL,
  PRIMARY KEY (`ptcpo_id`),
  KEY `ptcpo_patientID_idx` (`ptcpo_patientID`),
  CONSTRAINT `ptcpo_patientID` FOREIGN KEY (`ptcpo_patientID`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10248 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patient_communication_notes`
--

DROP TABLE IF EXISTS `patient_communication_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_communication_notes` (
  `ptcn_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ptcn_patientID` int(10) unsigned DEFAULT NULL,
  `ptcn_message` longtext,
  `ptcn_dateCreated` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `ptcn_archive` tinyint(1) DEFAULT NULL,
  `ptcn_category` enum('CPO','Medications','DME','Scheduling','Issues','HH Comm','485','Billing','Misc') DEFAULT NULL,
  `ptcn_notesFromUserID` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`ptcn_id`),
  KEY `ptcn_patientID_idx` (`ptcn_patientID`),
  CONSTRAINT `ptcn_patientID` FOREIGN KEY (`ptcn_patientID`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6963 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patient_transactions`
--

DROP TABLE IF EXISTS `patient_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_transactions` (
  `pt_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pt_tovID` int(10) unsigned DEFAULT NULL,
  `pt_patientID` int(10) unsigned DEFAULT NULL,
  `pt_providerID` int(10) unsigned DEFAULT NULL,
  `pt_dateOfService` date DEFAULT NULL,
  `pt_deductible` varchar(10) DEFAULT NULL,
  `pt_service_billed` varchar(10) DEFAULT NULL,
  `pt_aw_ippe_date` date DEFAULT NULL,
  `pt_aw_ippe_code` varchar(10) DEFAULT NULL,
  `pt_performed` tinyint(1) DEFAULT NULL,
  `pt_acp` tinyint(1) DEFAULT NULL,
  `pt_diabetes` tinyint(1) DEFAULT NULL,
  `pt_tobacco` tinyint(1) DEFAULT NULL,
  `pt_tcm` tinyint(1) DEFAULT NULL,
  `pt_others` varchar(45) DEFAULT NULL,
  `pt_icd10_codes` varchar(255) DEFAULT NULL,
  `pt_visitBilled` date DEFAULT NULL,
  `pt_dateRef` date DEFAULT NULL,
  `pt_dateRefEmailed` date DEFAULT NULL,
  `pt_notes` varchar(255) DEFAULT NULL,
  `pt_dateCreated` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `pt_mileage` varchar(45) DEFAULT NULL,
  `pt_aw_billed` date DEFAULT NULL,
  `pt_supervising_mdID` int(10) unsigned DEFAULT NULL,
  `pt_archive` tinyint(1) DEFAULT NULL,
  `pt_status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`pt_id`),
  KEY `pt_patientID_idx` (`pt_patientID`),
  KEY `pt_providerID_idx` (`pt_providerID`),
  KEY `pt_tovID_idx` (`pt_tovID`),
  KEY `pt_supervising_mdID` (`pt_supervising_mdID`),
  CONSTRAINT `pt_patientID` FOREIGN KEY (`pt_patientID`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `pt_providerID` FOREIGN KEY (`pt_providerID`) REFERENCES `provider` (`provider_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `pt_supervising_mdID` FOREIGN KEY (`pt_supervising_mdID`) REFERENCES `provider` (`provider_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `pt_tovID` FOREIGN KEY (`pt_tovID`) REFERENCES `type_of_visits` (`tov_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11840 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payroll_summary`
--

DROP TABLE IF EXISTS `payroll_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payroll_summary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provider_id` int(11) DEFAULT NULL,
  `from` varchar(20) NOT NULL,
  `to` varchar(20) NOT NULL,
  `mileage` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `permissions_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `permissions_name` varchar(255) DEFAULT NULL,
  `permissions_module` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`permissions_id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `place_of_service`
--

DROP TABLE IF EXISTS `place_of_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `place_of_service` (
  `pos_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pos_code` varchar(45) DEFAULT NULL,
  `pos_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`pos_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `provider`
--

DROP TABLE IF EXISTS `provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provider` (
  `provider_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `provider_firstname` varchar(45) DEFAULT NULL,
  `provider_lastname` varchar(45) DEFAULT NULL,
  `provider_contactNum` varchar(45) DEFAULT NULL,
  `provider_email` varchar(45) DEFAULT NULL,
  `provider_address` varchar(255) DEFAULT NULL,
  `provider_dateOfBirth` date DEFAULT NULL,
  `provider_languages` varchar(255) DEFAULT NULL,
  `provider_areas` varchar(255) DEFAULT NULL,
  `provider_npi` varchar(45) DEFAULT NULL,
  `provider_dea` varchar(45) DEFAULT NULL,
  `provider_license` varchar(45) DEFAULT NULL,
  `provider_dateCreated` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `provider_rate_initialVisit` varchar(10) DEFAULT NULL,
  `provider_rate_followUpVisit` varchar(10) DEFAULT NULL,
  `provider_rate_aw` varchar(10) DEFAULT NULL,
  `provider_rate_acp` varchar(10) DEFAULT NULL,
  `provider_rate_noShowPT` varchar(10) DEFAULT NULL,
  `provider_rate_mileage` varchar(10) DEFAULT NULL,
  `provider_gender` varchar(10) DEFAULT NULL,
  `provider_rate_initialVisit_TeleHealth` varchar(10) DEFAULT NULL,
  `provider_rate_followUpVisit_TeleHealth` mediumtext,
  `provider_supervising_MD` tinyint(1) NOT NULL,
  PRIMARY KEY (`provider_id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `provider_route_sheet`
--

DROP TABLE IF EXISTS `provider_route_sheet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provider_route_sheet` (
  `prs_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `prs_providerID` int(10) unsigned DEFAULT NULL,
  `prs_dateOfService` date DEFAULT NULL,
  `prs_dateCreated` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `prs_archive` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`prs_id`),
  KEY `prs_providerID_idx` (`prs_providerID`),
  CONSTRAINT `prs_providerID` FOREIGN KEY (`prs_providerID`) REFERENCES `provider` (`provider_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1650 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `provider_route_sheet_list`
--

DROP TABLE IF EXISTS `provider_route_sheet_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provider_route_sheet_list` (
  `prsl_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `prsl_prsID` int(10) unsigned DEFAULT NULL,
  `prsl_fromTime` time DEFAULT NULL,
  `prsl_toTime` time DEFAULT NULL,
  `prsl_tovID` int(10) unsigned DEFAULT NULL,
  `prsl_hhcID` int(10) unsigned DEFAULT NULL,
  `prsl_patientID` int(10) unsigned DEFAULT NULL,
  `prsl_notes` varchar(2000) DEFAULT NULL,
  `prsl_patientTransID` int(10) unsigned DEFAULT NULL,
  `prsl_dateRef` date DEFAULT NULL,
  PRIMARY KEY (`prsl_id`),
  KEY `prsl_prsID_idx` (`prsl_prsID`),
  KEY `prsl_tovID_idx` (`prsl_tovID`),
  KEY `prsl_hhcID_idx` (`prsl_hhcID`),
  KEY `prsl_patientID_idx` (`prsl_patientID`),
  KEY `prsl_patientTransID` (`prsl_patientTransID`),
  CONSTRAINT `prsl_hhcID` FOREIGN KEY (`prsl_hhcID`) REFERENCES `home_health_care` (`hhc_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `prsl_patientID` FOREIGN KEY (`prsl_patientID`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `prsl_prsID` FOREIGN KEY (`prsl_prsID`) REFERENCES `provider_route_sheet` (`prs_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `prsl_tovID` FOREIGN KEY (`prsl_tovID`) REFERENCES `type_of_visits` (`tov_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=18887 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `roles_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `roles_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`roles_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roles_permission`
--

DROP TABLE IF EXISTS `roles_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles_permission` (
  `rp_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rp_rolesID` int(10) unsigned DEFAULT NULL,
  `rp_permissionsID` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`rp_id`),
  KEY `rp_rolesID_idx` (`rp_rolesID`),
  KEY `rp_permissionsID_idx` (`rp_permissionsID`),
  CONSTRAINT `rp_permissionsID` FOREIGN KEY (`rp_permissionsID`) REFERENCES `permissions` (`permissions_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `rp_rolesID` FOREIGN KEY (`rp_rolesID`) REFERENCES `roles` (`roles_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=180 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scheduled_holidays`
--

DROP TABLE IF EXISTS `scheduled_holidays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduled_holidays` (
  `sh_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sh_description` varchar(255) DEFAULT NULL,
  `sh_date` varchar(45) DEFAULT NULL,
  `sh_archive` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`sh_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `type_of_visits`
--

DROP TABLE IF EXISTS `type_of_visits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `type_of_visits` (
  `tov_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tov_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`tov_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_firstname` varchar(45) DEFAULT NULL,
  `user_lastname` varchar(45) DEFAULT NULL,
  `user_email` varchar(45) DEFAULT NULL,
  `user_dateCreated` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `user_password` varchar(255) DEFAULT NULL,
  `user_roleID` int(10) unsigned DEFAULT NULL,
  `user_sessionID` varchar(255) DEFAULT NULL,
  `user_archive` TINYINT(1) NULL
  PRIMARY KEY (`user_id`),
  KEY `user_roleID_idx` (`user_roleID`),
  CONSTRAINT `user_roleID` FOREIGN KEY (`user_roleID`) REFERENCES `roles` (`roles_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_logs`
--

DROP TABLE IF EXISTS `user_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_logs` (
  `user_log_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_log_userID` int(10) unsigned DEFAULT NULL,
  `user_log_time` time DEFAULT NULL,
  `user_log_date` date DEFAULT NULL,
  `user_log_description` varchar(255) DEFAULT NULL,
  `user_log_link` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_log_id`),
  KEY `user_log_userID_idx` (`user_log_userID`),
  CONSTRAINT `user_log_userID` FOREIGN KEY (`user_log_userID`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=555608 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-25 11:54:09

