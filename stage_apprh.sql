-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: stage_apprh
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `anomalie_paie`
--

DROP TABLE IF EXISTS `anomalie_paie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anomalie_paie` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date_anomalie` date DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `statut` varchar(255) DEFAULT NULL,
  `type_anomalie` varchar(255) DEFAULT NULL,
  `employe_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKbglujf7qbduuo2rvvcbl8muic` (`employe_id`),
  CONSTRAINT `FKbglujf7qbduuo2rvvcbl8muic` FOREIGN KEY (`employe_id`) REFERENCES `employe` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `anomalie_paie`
--

LOCK TABLES `anomalie_paie` WRITE;
/*!40000 ALTER TABLE `anomalie_paie` DISABLE KEYS */;
INSERT INTO `anomalie_paie` VALUES (1,NULL,'','En attente','',1),(2,NULL,'test','En attente','',452);
/*!40000 ALTER TABLE `anomalie_paie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `anomalie_pointage`
--

DROP TABLE IF EXISTS `anomalie_pointage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anomalie_pointage` (
  `id` bigint NOT NULL,
  `date_demande` date DEFAULT NULL,
  `remarque` varchar(255) DEFAULT NULL,
  `statut` varchar(255) DEFAULT NULL,
  `type_anomalie` enum('ENTREE','SORTIE') DEFAULT NULL,
  `employe_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK12d69be0visqmdwqkkn0ofwjl` (`employe_id`),
  CONSTRAINT `FK12d69be0visqmdwqkkn0ofwjl` FOREIGN KEY (`employe_id`) REFERENCES `employe` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `anomalie_pointage`
--

LOCK TABLES `anomalie_pointage` WRITE;
/*!40000 ALTER TABLE `anomalie_pointage` DISABLE KEYS */;
INSERT INTO `anomalie_pointage` VALUES (1,'2026-07-08','j\'ai oublié le pointage d\'entrée je suis vraiment désolé ','Acceptée','ENTREE',466);
/*!40000 ALTER TABLE `anomalie_pointage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `anomalie_pointage_seq`
--

DROP TABLE IF EXISTS `anomalie_pointage_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anomalie_pointage_seq` (
  `next_val` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `anomalie_pointage_seq`
--

LOCK TABLES `anomalie_pointage_seq` WRITE;
/*!40000 ALTER TABLE `anomalie_pointage_seq` DISABLE KEYS */;
INSERT INTO `anomalie_pointage_seq` VALUES (51);
/*!40000 ALTER TABLE `anomalie_pointage_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `autorisation`
--

DROP TABLE IF EXISTS `autorisation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `autorisation` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `direction` varchar(255) DEFAULT NULL,
  `heure_debut` time(6) DEFAULT NULL,
  `heure_fin` time(6) DEFAULT NULL,
  `motif` varchar(255) DEFAULT NULL,
  `motif_refus` varchar(255) DEFAULT NULL,
  `statut` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `validation_chef_securite` varchar(255) DEFAULT NULL,
  `validation_responsable_hierarchique` varchar(255) DEFAULT NULL,
  `validation_responsablerh` varchar(255) DEFAULT NULL,
  `employe_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKjim3049anb7j1xu8b2xidtt8k` (`employe_id`),
  CONSTRAINT `FKjim3049anb7j1xu8b2xidtt8k` FOREIGN KEY (`employe_id`) REFERENCES `employe` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autorisation`
--

LOCK TABLES `autorisation` WRITE;
/*!40000 ALTER TABLE `autorisation` DISABLE KEYS */;
INSERT INTO `autorisation` VALUES (3,'2026-07-10','Entrée','00:27:00.000000',NULL,'anything',NULL,'Accepté','Heure','Accepté','Accepté','Accepté',362),(4,'2026-07-10','Entrée','00:27:00.000000',NULL,'anything',NULL,'Accepté','Heure','Accepté','Accepté','Accepté',362),(5,'2026-07-10','Entrée','00:27:00.000000',NULL,'anything',NULL,'Accepté','Heure','Accepté','Accepté','Accepté',362),(6,'2027-02-02','Entrée','10:10:00.000000',NULL,'anything',NULL,'Accepté','Heure','Accepté','Accepté','Accepté',2),(7,'2026-07-10','Entrée','13:48:00.000000',NULL,'anything',NULL,'Accepté','Heure','Accepté','Accepté','Accepté',38);
/*!40000 ALTER TABLE `autorisation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `avance_salaire`
--

DROP TABLE IF EXISTS `avance_salaire`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avance_salaire` (
  `id` bigint NOT NULL,
  `date_demande` date DEFAULT NULL,
  `matricule` varchar(255) DEFAULT NULL,
  `montant` double DEFAULT NULL,
  `remarque` varchar(255) DEFAULT NULL,
  `statut` varchar(255) DEFAULT NULL,
  `employe_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKaxd2m055u90ibyokeabca3df5` (`employe_id`),
  CONSTRAINT `FKaxd2m055u90ibyokeabca3df5` FOREIGN KEY (`employe_id`) REFERENCES `employe` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avance_salaire`
--

LOCK TABLES `avance_salaire` WRITE;
/*!40000 ALTER TABLE `avance_salaire` DISABLE KEYS */;
INSERT INTO `avance_salaire` VALUES (1,'2026-07-09',NULL,150,'need it ','Acceptée',362);
/*!40000 ALTER TABLE `avance_salaire` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `avance_salaire_seq`
--

DROP TABLE IF EXISTS `avance_salaire_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avance_salaire_seq` (
  `next_val` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avance_salaire_seq`
--

LOCK TABLES `avance_salaire_seq` WRITE;
/*!40000 ALTER TABLE `avance_salaire_seq` DISABLE KEYS */;
INSERT INTO `avance_salaire_seq` VALUES (51);
/*!40000 ALTER TABLE `avance_salaire_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conge`
--

DROP TABLE IF EXISTS `conge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conge` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date_debut` date DEFAULT NULL,
  `date_fin` date DEFAULT NULL,
  `motif_refus` varchar(255) DEFAULT NULL,
  `statut` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `validation_chef_securite` varchar(255) DEFAULT NULL,
  `validation_responsable_hierarchique` varchar(255) DEFAULT NULL,
  `validation_responsablerh` varchar(255) DEFAULT NULL,
  `employe_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKlqg9rybgeokq9ibtk7ymycjeq` (`employe_id`),
  CONSTRAINT `FKlqg9rybgeokq9ibtk7ymycjeq` FOREIGN KEY (`employe_id`) REFERENCES `employe` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conge`
--

LOCK TABLES `conge` WRITE;
/*!40000 ALTER TABLE `conge` DISABLE KEYS */;
INSERT INTO `conge` VALUES (9,NULL,NULL,NULL,'Accepté','',NULL,'Accepté','Accepté',25),(10,'2026-07-09','2026-07-19',NULL,'Accepté','maladie',NULL,'Accepté','Accepté',25),(12,'2026-07-10','2026-07-10',NULL,'Accepté','maladie',NULL,'Accepté','Accepté',362),(13,'2026-07-11','2026-07-15',NULL,'Accepté','maladie',NULL,'Accepté','Accepté',2),(14,'2026-07-10','2026-07-17',NULL,'En attente','maladie',NULL,'Accepté','En attente',38);
/*!40000 ALTER TABLE `conge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `demande_document`
--

DROP TABLE IF EXISTS `demande_document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `demande_document` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date_demande` date DEFAULT NULL,
  `remarque` varchar(255) DEFAULT NULL,
  `statut` varchar(255) DEFAULT NULL,
  `type_document` varchar(255) DEFAULT NULL,
  `employe_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKk7en0m3h6v29mfrumq4in9935` (`employe_id`),
  CONSTRAINT `FKk7en0m3h6v29mfrumq4in9935` FOREIGN KEY (`employe_id`) REFERENCES `employe` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `demande_document`
--

LOCK TABLES `demande_document` WRITE;
/*!40000 ALTER TABLE `demande_document` DISABLE KEYS */;
INSERT INTO `demande_document` VALUES (1,'2026-07-09',NULL,'Acceptée','Attestation de travail',466);
/*!40000 ALTER TABLE `demande_document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emission`
--

DROP TABLE IF EXISTS `emission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emission` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date_debut` date DEFAULT NULL,
  `date_fin` date DEFAULT NULL,
  `statut` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `employe_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK77tfsv532c30rhdoatyk1cyqv` (`employe_id`),
  CONSTRAINT `FK77tfsv532c30rhdoatyk1cyqv` FOREIGN KEY (`employe_id`) REFERENCES `employe` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emission`
--

LOCK TABLES `emission` WRITE;
/*!40000 ALTER TABLE `emission` DISABLE KEYS */;
INSERT INTO `emission` VALUES (1,NULL,NULL,'En attente','Voyage à l\'étranger',452);
/*!40000 ALTER TABLE `emission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employe`
--

DROP TABLE IF EXISTS `employe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employe` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `fullname` varchar(255) DEFAULT NULL,
  `matricule` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `zone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKsewfj92skjm3geoc0usfber43` (`matricule`)
) ENGINE=InnoDB AUTO_INCREMENT=477 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employe`
--

LOCK TABLES `employe` WRITE;
/*!40000 ALTER TABLE `employe` DISABLE KEYS */;
INSERT INTO `employe` VALUES (1,1,'Mohamed Sabri Chaarana','1','1','Validateur Supérieur Hiérarchique','Direction'),(2,1,'HEDYEOUI RIDHA','2','2','Validateur Supérieur Hiérarchique','Maintenance'),(3,1,'BEL HADJ JAMILA','7','NO_ACCOUNT','Employé','Norsystec'),(4,1,'KHELIFA SIHEM','9','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(5,1,'EL GHOUL NEDRA','12','NO_ACCOUNT','Employé','Norsystec'),(6,1,'AOUIDIDI NABIL','16','NO_ACCOUNT','Employé','Norsystec'),(7,1,'RABBOUHI AFEF','17','NO_ACCOUNT','Employé','Norsystec'),(8,1,'AYEDI HAJER','18','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(9,1,'MAJEBRI MOUNIRA','19','NO_ACCOUNT','Employé','Norsystec'),(10,1,'BELHADJ SAMIA','20','NO_ACCOUNT','Employé','Prod.Cable SET'),(11,1,'MAJDOUB ABDELMAJID','21','NO_ACCOUNT','Employé','Maintenance'),(12,1,'HALFEOUI SELMA','23','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(13,1,'REBEG HELA','24','NO_ACCOUNT','Employé','Prod.Cable SET'),(14,1,'BEN HNIA HAYET','26','NO_ACCOUNT','Employé','Norsystec'),(15,1,'KHELIFI AWATEF','28','NO_ACCOUNT','Employé','Norsystec'),(16,1,'KHELIFA OLFA','29','NO_ACCOUNT','Employé','Norsystec'),(17,1,'KHELIFI FATHIA','30','NO_ACCOUNT','Employé','Prod.Cable SET'),(18,1,'BEN NJIMA AICHA','31','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(19,1,'MEHRITHI SALAH','36','NO_ACCOUNT','EMPLOYE','Ressources Huamines'),(20,1,'BELHADJ FOLLA','42','NO_ACCOUNT','Employé','Prod.Cable SET'),(21,1,'BEN AMOR MONIA','47','NO_ACCOUNT','Employé','Norsystec'),(22,1,'KHELIFI MADIHA','51','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(23,1,'ELTAIEF MOUFIDA','53','NO_ACCOUNT','Employé','Norsystec'),(24,1,'ZALFENI AZIZA','56','NO_ACCOUNT','Employé','Norsystec'),(25,1,'NASR AHMED','58','58','Validateur Supérieur Hiérarchique','Prod. Cable WH-E'),(26,1,'RAOUEFI MONIA','60','NO_ACCOUNT','Employé','Norsystec'),(27,1,'KHELIFA NOUHA','65','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(28,1,'KHELIFI NEJIA','72','NO_ACCOUNT','Employé','Norsystec'),(29,1,'HAMDI KHADIJA','74','NO_ACCOUNT','Employé','Norsystec'),(30,1,'CHOUIGUI SAWSSEN','76','NO_ACCOUNT','Employé','Norsystec'),(31,1,'EL ARBI SAWSSEN','77','NO_ACCOUNT','Employé','Norsystec'),(32,1,'LTAIEF AMAL','83','NO_ACCOUNT','Employé','Norsystec'),(33,1,'CHOUIGUI AMIRA','84','NO_ACCOUNT','Employé','Norsystec'),(34,1,'KAZBOURI KHITEM','86','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(35,1,'BEN HNIA SONIA','87','NO_ACCOUNT','Employé','Norsystec'),(36,1,'BEN HNIA NAJEH','88','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(37,1,'BEN HNIA HALIMA','90','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(38,1,'MAJDOUB FRAJ','91','NO_ACCOUNT','Employé','Maintenance'),(39,1,'HAMDI RADHIA','95','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(40,1,'KHELIFA SONIA','100','NO_ACCOUNT','Employé','Norsystec'),(41,1,'ABDEOUI YOSRA','103','NO_ACCOUNT','Employé','Norsystec'),(42,1,'BOUKAMCHA SONIA','104','NO_ACCOUNT','Employé','Norsystec'),(43,1,'KESSEBI MADIHA','105','NO_ACCOUNT','Employé','Norsystec'),(44,1,'HRAIECH NORHEN','111','NO_ACCOUNT','Employé','Norsystec'),(45,1,'ERRAIED HADDA','112','NO_ACCOUNT','Employé','Norsystec'),(46,1,'Ines BAHLOUL','115','NO_ACCOUNT','Employé','Norsystec'),(47,1,'NAHERI MARWEN','118','NO_ACCOUNT','Employé','Logistique'),(48,1,'DHAYA IMEN','122','NO_ACCOUNT','Employé','Norsystec'),(49,1,'BOUZAABIA SALWA','128','NO_ACCOUNT','Employé','Norsystec'),(50,1,'RABBOUHI NAZIHA','129','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(51,1,'BOURAOUI FADOUA','136','NO_ACCOUNT','Employé','Norsystec'),(52,1,'ABID AYMEN','137','NO_ACCOUNT','Employé','Logistique'),(53,1,'AOUNI SIHEM','146','NO_ACCOUNT','Employé','Norsystec'),(54,1,'BEN SAAD AFIFA','150','NO_ACCOUNT','Employé','Norsystec'),(55,1,'AZIZI NOURA','152','NO_ACCOUNT','Employé','Norsystec'),(56,1,'HAMDI SANA','154','NO_ACCOUNT','Employé','Norsystec'),(57,1,'KHLIFA DHEKRA','157','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(58,1,'SAADLI MONIA','159','NO_ACCOUNT','Employé','Norsystec'),(59,1,'BEL HADJ EMNA','160','NO_ACCOUNT','Employé','Norsystec'),(60,1,'BEN HNIA SOUMAYA','161','NO_ACCOUNT','Employé','Norsystec'),(61,1,'AZIZI SIHEM','164','NO_ACCOUNT','Employé','Norsystec'),(62,1,'MESBEHI LAMIA','165','NO_ACCOUNT','Employé','Norsystec'),(63,1,'EJRIDI FOUZIA','171','NO_ACCOUNT','Employé','Norsystec'),(64,1,'CHALBIA FATMA','177','NO_ACCOUNT','Employé','Norsystec'),(65,1,'BOUZAABIA ASMA','179','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(66,1,'BEN FRADJ SAMIA','180','NO_ACCOUNT','Employé','Prod.Cable SET'),(67,1,'KHLIFA HANEN','187','NO_ACCOUNT','Employé','Prod.Cable SET'),(68,1,'AZZOUZ RADHIA','189','NO_ACCOUNT','Employé','Prod.Cable SET'),(69,1,'EL HOUIJ BESSA OUMAIMA','193','NO_ACCOUNT','Employé','Norsystec'),(70,1,'BEN KHLIFA NESRIN','194','NO_ACCOUNT','Employé','Norsystec'),(71,1,'ROMDHAN RIHAB','196','NO_ACCOUNT','Employé','Norsystec'),(72,1,'BRAHEM SAMIRA','197','NO_ACCOUNT','Employé','Prod.Cable SET'),(73,1,'BOUGEZZI LATIFA','198','NO_ACCOUNT','Employé','Norsystec'),(74,1,'AZZOUZ SOUHIR','199','NO_ACCOUNT','Employé','Prod.Cable SET'),(75,1,'BOUZAABIA HAJER','201','NO_ACCOUNT','Employé','Norsystec'),(76,1,'ABID MAHER','204','NO_ACCOUNT','Employé','Logistique'),(77,1,'KAHLOUL ASMA','208','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(78,1,'CHOUIGUI SIWAR','209','NO_ACCOUNT','Employé','Norsystec'),(79,1,'ZALFENI YAMINA','212','NO_ACCOUNT','Employé','Norsystec'),(80,1,'ABDELLAOUI SABRINE','215','NO_ACCOUNT','Employé','Norsystec'),(81,1,'DARBEL SAHAR','218','NO_ACCOUNT','Employé','Prod.Cable SET'),(82,1,'EL MANAA SLEMA AFEF','219','NO_ACCOUNT','Employé','Norsystec'),(83,1,'EL KHLIFI THOURAIA','221','NO_ACCOUNT','Employé','Norsystec'),(84,1,'BEN FRAJ INES','222','222','Validateur Supérieur Hiérarchique','Qualité'),(85,1,'HRAIECH HAIFA','223','NO_ACCOUNT','Employé','Norsystec'),(86,1,'BERRI HAIFA','225','NO_ACCOUNT','Employé','Norsystec'),(87,1,'ABID MAROUA','226','NO_ACCOUNT','Employé','Norsystec'),(88,1,'BOUMAIZA CHAIMA','227','NO_ACCOUNT','Employé','Norsystec'),(89,1,'BALHADJ BASMA','228','NO_ACCOUNT','Employé','Prod.Cable SET'),(90,1,'BEN FRADJ TAISIR','229','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(91,1,'BELHADJ HAIFA','302','NO_ACCOUNT','Employé','Prod.Cable SET'),(92,1,'KLII LAMIA','304','NO_ACCOUNT','Employé','Norsystec'),(93,1,'EKRAM BEN SAAD','307','NO_ACCOUNT','Employé','Norsystec'),(94,1,'KHLIFA YASMINE','311','NO_ACCOUNT','Employé','Qualité'),(95,1,'BEN ABDELGHANI WARDA','316','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(96,1,'HALFEOUI IMEN','323','NO_ACCOUNT','Employé','Norsystec'),(97,1,'CHOUIGUI DORSAF','324','NO_ACCOUNT','Employé','Prod.Cable SET'),(98,1,'KHLIFI AWATEF 2','326','NO_ACCOUNT','Employé','Norsystec'),(99,1,'KHLIFA SANA','328','NO_ACCOUNT','Employé','Prod.Cable SET'),(100,1,'HRAIECH CHOUROUK','330','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(101,1,'TOUMIA MAROUA','333','NO_ACCOUNT','Employé','Norsystec'),(102,1,'DHEKRA HRAIECH','335','NO_ACCOUNT','Employé','Norsystec'),(103,1,'GRIRA NEDIA','336','NO_ACCOUNT','Employé','Prod.Cable SET'),(104,1,'EL GHAMERI IMEN','338','NO_ACCOUNT','Employé','Norsystec'),(105,1,'ELWETI IMEN','339','NO_ACCOUNT','Employé','Norsystec'),(106,1,'SOUDENI LAZHAR','342','NO_ACCOUNT','Employé','Ressources Huamines'),(107,1,'BOUKARMA ECHTIOUI SIRINE','343','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(108,1,'HEDYEOUI SAID','344','NO_ACCOUNT','Employé','Ressources Huamines'),(109,1,'BELHADJ MILED SARRA','346','NO_ACCOUNT','Employé','Norsystec'),(110,1,'BILEL HAMDI','351','NO_ACCOUNT','Employé','Norsystec'),(111,1,'DHOUHA JARBOUA','352','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(112,1,'DORSAF ABDEOUI','353','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(113,1,'JIHEN EL MELKI','361','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(114,1,'SABRA AZIZI','362','NO_ACCOUNT','Employé','Prod.Cable SET'),(115,1,'HENI AZZOUZ','363','NO_ACCOUNT','Employé','Prod.Cable SET'),(116,1,'NAJOUA KHALFOUN','365','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(117,1,'NORHEN BEL HADJ','366','NO_ACCOUNT','Employé','Prod.Cable SET'),(118,1,'HAJER KALBOUSI','368','NO_ACCOUNT','Employé','Prod.Cable SET'),(119,1,'NOURHEN ABDEOUI','369','NO_ACCOUNT','Employé','Prod.Cable SET'),(120,1,'SABER ISSAOUI','370','NO_ACCOUNT','Employé','Logistique'),(121,1,'MAROUA REBBEG','371','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(122,1,'FATIMA ZEMZMI','374','NO_ACCOUNT','Employé','Prod.Cable SET'),(123,1,'JAMEL ZAARAOUI','377','NO_ACCOUNT','Employé','Maintenance'),(124,1,'SIHEM SAOUDI','378','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(125,1,'HIBA MDALLA','379','379','Employé','Qualité'),(126,1,'SAIDA HAMDI','380','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(127,1,'AWATEF SLAMA','381','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(128,1,'KHAOULA KHIARI','382','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(129,1,'TAYSIR KASEM','385','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(130,1,'AFEF BRINI','387','387','Validateur Supérieur Hiérarchique','Méthode'),(131,1,'FAHMI ABID','388','NO_ACCOUNT','Employé','Logistique'),(132,1,'MERIEM SOUIBGUI','391','NO_ACCOUNT','Employé','Prod.Cable SET'),(133,1,'MOUHAMED BEL HADJ','394','NO_ACCOUNT','Employé','Logistique'),(134,1,'AMIRA BEN HNIA','395','NO_ACCOUNT','Employé','Norsystec'),(135,1,'Fatma Hamdi','397','NO_ACCOUNT','Employé','Norsystec'),(136,1,'Sana Chaar','402','NO_ACCOUNT','Employé','Norsystec'),(137,1,'ZOUHOUR NASRI','405','NO_ACCOUNT','Employé','Norsystec'),(138,1,'DALANDA KHEDHER','407','NO_ACCOUNT','Employé','Norsystec'),(139,1,'HAJER AMMERI','408','NO_ACCOUNT','Employé','Norsystec'),(140,1,'MAROUA BEN NJIMA','411','NO_ACCOUNT','Employé','Norsystec'),(141,1,'SIHEM EL MHADHBI','412','NO_ACCOUNT','Employé','Norsystec'),(142,1,'SALMA BOUASKAR','415','NO_ACCOUNT','Employé','Norsystec'),(143,1,'ELHEM HOUIJ','418','NO_ACCOUNT','Employé','Norsystec'),(144,1,'SIRINE BEN ABDEL GHANI','420','NO_ACCOUNT','Employé','Norsystec'),(145,1,'HEDIL CHOUIGI','422','NO_ACCOUNT','Employé','Norsystec'),(146,1,'SAMEH ZALFENI','424','NO_ACCOUNT','Employé','Norsystec'),(147,1,'SABRIN ZAROUKI','430','NO_ACCOUNT','Employé','Prod.Cable SET'),(148,1,'CHAIMA BEN NJIMA','433','NO_ACCOUNT','Employé','Prod.Cable SET'),(149,1,'HOUDA BEN HNIA','437','NO_ACCOUNT','Employé','Norsystec'),(150,1,'KAWTHAR HADEJI','438','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(151,1,'AHLEM EL ANEBI','439','NO_ACCOUNT','Employé','Norsystec'),(152,1,'NESRIN HADEJI','441','NO_ACCOUNT','Employé','Norsystec'),(153,1,'SAMEH ELOURIMI','442','NO_ACCOUNT','Employé','Prod.Cable SET'),(154,1,'HANEN OUSIFI','445','NO_ACCOUNT','Employé','Prod.Cable SET'),(155,1,'MARIEM BEN HNIA','446','NO_ACCOUNT','Employé','Norsystec'),(156,1,'CHAHRAZED BELHADJ','447','NO_ACCOUNT','Employé','Norsystec'),(157,1,'OUMAIMA BEMRI','449','NO_ACCOUNT','Employé','Norsystec'),(158,1,'ATIKA ZALFENI','450','NO_ACCOUNT','Employé','Norsystec'),(159,1,'RIHAB EL KHLIFI','453','NO_ACCOUNT','Employé','Norsystec'),(160,1,'SALSABIL ESHILI','454','NO_ACCOUNT','Employé','Norsystec'),(161,1,'ROUA HEDIEOUI','457','NO_ACCOUNT','Employé','Norsystec'),(162,1,'AYMEN ELLOUETI','458','NO_ACCOUNT','Employé','Norsystec'),(163,1,'SAMIA BRAHEM','461','NO_ACCOUNT','Employé','Prod.Cable SET'),(164,1,'RANIA ESSEDIK','466','NO_ACCOUNT','Employé','Norsystec'),(165,1,'HNIA HAMDI','467','NO_ACCOUNT','Employé','Norsystec'),(166,1,'Ferjeni Bouallegue','468','NO_ACCOUNT','Employé','Norsystec'),(167,1,'SARRA EL BAGHDEDI','469','NO_ACCOUNT','Employé','Norsystec'),(168,1,'Houda Ben Njima','470','NO_ACCOUNT','Employé','Norsystec'),(169,1,'Yosra Nasri','472','NO_ACCOUNT','Employé','Norsystec'),(170,1,'INES BEN KHLIFA','474','NO_ACCOUNT','Employé','Norsystec'),(171,1,'HIBA HENI','475','NO_ACCOUNT','Employé','Norsystec'),(172,1,'WAFA ZID','479','NO_ACCOUNT','Employé','Prod.Cable SET'),(173,1,'WAJDI WECHTETI','482','NO_ACCOUNT','Employé','Norsystec'),(174,1,'CHAIMA HALFEOUI','485','NO_ACCOUNT','Employé','Norsystec'),(175,1,'NAJEH MALLAT','490','NO_ACCOUNT','Employé','Prod.Cable SET'),(176,1,'IKBEL MALLAT','494','NO_ACCOUNT','Employé','Norsystec'),(177,1,'Imen Mallat','499','NO_ACCOUNT','Employé','Norsystec'),(178,1,'Takoua Labeoui','501','NO_ACCOUNT','Employé','Norsystec'),(179,1,'Hanen Erezgui','502','NO_ACCOUNT','Employé','Norsystec'),(180,1,'Romdhana Zalfeni','506','NO_ACCOUNT','Employé','Norsystec'),(181,1,'FEIZA CHEBBI','516','NO_ACCOUNT','Employé','Qualité'),(182,1,'OUMAIMA ECHTIOUI','517','NO_ACCOUNT','Employé','Prod.Cable SET'),(183,1,'SAMAR HSIN','518','NO_ACCOUNT','Employé','Prod.Cable SET'),(184,1,'SAMIA MANSRI','519','NO_ACCOUNT','Employé','Norsystec'),(185,1,'Mounira Ammeri','525','NO_ACCOUNT','Employé','Ressources Huamines'),(186,1,'Wafa Toumia','527','NO_ACCOUNT','Employé','Norsystec'),(187,1,'Asma Ezneti','528','NO_ACCOUNT','Employé','Norsystec'),(188,1,'Rafika Edabbebi','529','NO_ACCOUNT','Employé','Norsystec'),(189,1,'Maram Hamda','538','NO_ACCOUNT','Employé','Norsystec'),(190,1,'Malek Ben Njima','539','NO_ACCOUNT','Employé','Norsystec'),(191,1,'Rim Barhoumi','544','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(192,1,'Emna ElHendeoui','547','NO_ACCOUNT','Employé','Prod.Cable SET'),(193,1,'Ibtissem Ifeoui','555','NO_ACCOUNT','Employé','Norsystec'),(194,1,'Ahmed Abid','558','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(195,1,'Imen Balghouthi','561','NO_ACCOUNT','Employé','Norsystec'),(196,1,'Latifa Saidi','566','NO_ACCOUNT','Employé','Norsystec'),(197,1,'Salwa Ben Hsin','570','NO_ACCOUNT','Employé','Norsystec'),(198,1,'Sabeh Mhamdi','573','NO_ACCOUNT','Employé','Norsystec'),(199,1,'Moez Bentiba','576','NO_ACCOUNT','Validateur Supérieur Hiérarchique','Norsystec'),(200,1,'Chirine Halfeoui','577','NO_ACCOUNT','Employé','Prod.Cable SET'),(201,1,'Saida Gessmi','582','NO_ACCOUNT','Employé','Norsystec'),(202,1,'Naima Ismain','583','NO_ACCOUNT','Employé','Norsystec'),(203,1,'Fatma Erbeihi','584','NO_ACCOUNT','Employé','Norsystec'),(204,1,'Islem Daouehi','594','NO_ACCOUNT','Employé','Norsystec'),(205,1,'Amal El Khlifi','595','NO_ACCOUNT','Employé','Norsystec'),(206,1,'Fouzia Hadeji','597','NO_ACCOUNT','Employé','Prod.Cable SET'),(207,1,'Mouna Kahloul','605','NO_ACCOUNT','Employé','Norsystec'),(208,1,'Souhir Grira','606','NO_ACCOUNT','Employé','Norsystec'),(209,1,'Yamina El Marzouki','607','NO_ACCOUNT','Employé','Prod.Cable SET'),(210,1,'Nesrin Zrega Elajmi','612','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(211,1,'Hanen Outai','614','NO_ACCOUNT','Employé','Prod.Cable SET'),(212,1,'Souad khedher','615','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(213,1,'Rim Bouallegue','617','NO_ACCOUNT','Employé','Prod.Cable SET'),(214,1,'Fathia Hamdi','618','NO_ACCOUNT','Employé','Norsystec'),(215,1,'chayma Khlifa','619','NO_ACCOUNT','Employé','Qualité'),(216,1,'Fatma Hamdi','624','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(217,1,'Rahma Sfaxi','633','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(218,1,'Zmorda Elhadj Sghaier','637','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(219,1,'Lobna Abbes','643','NO_ACCOUNT','Employé','Ressources Huamines'),(220,1,'Thouraya Ferjeoui','644','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(221,1,'Zaineb Elhnzouli','648','NO_ACCOUNT','Employé','Norsystec'),(222,1,'Fouzia Nasr','650','NO_ACCOUNT','Employé','Norsystec'),(223,1,'Nejma Gizeni','651','NO_ACCOUNT','Employé','Norsystec'),(224,1,'Jamila Elfakroun','656','NO_ACCOUNT','Employé','Prod.Cable SET'),(225,1,'Maroua Ayedi','657','NO_ACCOUNT','Employé','Norsystec'),(226,1,'Kawthar Elkrifi','659','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(227,1,'Mouna Bouraoui','667','NO_ACCOUNT','Employé','Prod.Cable SET'),(228,1,'Souhir Kahloun','668','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(229,1,'Rim Hadj Selem','673','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(230,1,'Latifa Hamdi','675','NO_ACCOUNT','Employé','Norsystec'),(231,1,'Haythem Said','684','684','Validateur Supérieur Hiérarchique','Prod.Cable SET'),(232,1,'Salwa Elsouli','688','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(233,1,'Rahma Hedyeoui','692','NO_ACCOUNT','Employé','Norsystec'),(234,1,'Ahlem Bouasker','695','NO_ACCOUNT','Employé','Prod.Cable SET'),(235,1,'Rami Ben Khlifa','697','NO_ACCOUNT','Employé','Norsystec'),(236,1,'Atef Harrabi','701','NO_ACCOUNT','Employé','Logistique'),(237,1,'Hanen Gassoumi','702','NO_ACCOUNT','Employé','Prod.Cable SET'),(238,1,'Rihab Kahloul','704','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(239,1,'Nedia Mnasri','705','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(240,1,'Saliha Azouzi','712','NO_ACCOUNT','Employé','Norsystec'),(241,1,'Najet Abbessi','713','NO_ACCOUNT','Employé','Norsystec'),(242,1,'Soumaya Khlifa','714','NO_ACCOUNT','Employé','Norsystec'),(243,1,'Chaima Dergech','715','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(244,1,'Chayma Bouzaienne','717','NO_ACCOUNT','Employé','Norsystec'),(245,1,'Ranim El Ghoul','718','NO_ACCOUNT','Employé','Norsystec'),(246,1,'Wiem Elhanzouli','720','NO_ACCOUNT','Employé','Norsystec'),(247,1,'Warda Ifeoui','721','NO_ACCOUNT','Employé','Norsystec'),(248,1,'Maysoun Ben Atya','725','NO_ACCOUNT','Employé','Norsystec'),(249,1,'Aymen Krifi','727','NO_ACCOUNT','Employé','Qualité'),(250,1,'Maher Badrouch','728','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(251,1,'Radhya Mesbehi','737','NO_ACCOUNT','Employé','Norsystec'),(252,1,'Ghofran Elhraiech','739','NO_ACCOUNT','Employé','Prod.Cable SET'),(253,1,'Zohra Ayed','746','NO_ACCOUNT','Employé','Prod.Cable SET'),(254,1,'Fatma Aouicheoui','750','NO_ACCOUNT','Employé','Prod.Cable SET'),(255,1,'wissal Chebi','751','NO_ACCOUNT','Employé','Norsystec'),(256,1,'Sawssen Addeli','755','NO_ACCOUNT','Employé','Norsystec'),(257,1,'Wissal Ben Njima','769','NO_ACCOUNT','Employé','Norsystec'),(258,1,'Mouhamed Zeidi','775','NO_ACCOUNT','Employé','Prod.Cable SET'),(259,1,'Monjia Saadli','776','NO_ACCOUNT','Employé','Norsystec'),(260,1,'Fedya Zalfeni','780','NO_ACCOUNT','Employé','Norsystec'),(261,1,'Wiem Zalfeni','792','NO_ACCOUNT','Employé','Norsystec'),(262,1,'Rabiaa Thleijia','795','NO_ACCOUNT','Employé','Norsystec'),(263,1,'Amira Amara','797','NO_ACCOUNT','Employé','Norsystec'),(264,1,'Soukaina Tiehi','809','NO_ACCOUNT','Employé','Norsystec'),(265,1,'Amal Mighri','810','NO_ACCOUNT','Employé','Norsystec'),(266,1,'Med Amin Ben Abdelghani','811','NO_ACCOUNT','Employé','Norsystec'),(267,1,'Atef Addeli','812','NO_ACCOUNT','Employé','Norsystec'),(268,1,'Rebeh Elghnoudi','814','NO_ACCOUNT','Employé','Norsystec'),(269,1,'Awatef Barhoumi','819','NO_ACCOUNT','Employé','Norsystec'),(270,1,'Rahma Taamallah','821','NO_ACCOUNT','Employé','Norsystec'),(271,1,'Chayma Abdelghani','829','NO_ACCOUNT','Employé','Norsystec'),(272,1,'Israa Essessi','830','NO_ACCOUNT','Employé','Prod.Cable SET'),(273,1,'Hajer Mtiraoui','833','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(274,1,'Rahma Elayari','839','NO_ACCOUNT','Employé','Norsystec'),(275,1,'Omar Karmous','842','NO_ACCOUNT','Employé','Norsystec'),(276,1,'Jihen Chmangui','849','NO_ACCOUNT','Employé','Norsystec'),(277,1,'Amira Barhoumi','850','NO_ACCOUNT','Employé','Norsystec'),(278,1,'Amal Farhani','851','NO_ACCOUNT','Employé','Norsystec'),(279,1,'Afef Elkhlifi','853','NO_ACCOUNT','Employé','Norsystec'),(280,1,'Samia Harrabi','854','NO_ACCOUNT','Employé','Prod.Cable SET'),(281,1,'Achraf Gessem','860','NO_ACCOUNT','Employé','Logistique'),(282,1,'Nawres Isseoui','861','NO_ACCOUNT','Employé','Prod.Cable SET'),(283,1,'Imen Abdellaoui','866','NO_ACCOUNT','Employé','Norsystec'),(284,1,'Abdelmonem Zaidi','871','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(285,1,'Saida Taam','873','NO_ACCOUNT','Employé','Prod.Cable SET'),(286,1,'Ala Abdeoui','879','NO_ACCOUNT','Employé','Prod.Cable SET'),(287,1,'Molka Hlel','883','NO_ACCOUNT','Employé','Norsystec'),(288,1,'Amina Essid','884','NO_ACCOUNT','Employé','Norsystec'),(289,1,'Sami Najleoui','885','NO_ACCOUNT','Employé','Maintenance'),(290,1,'Amira Enajleoui','886','NO_ACCOUNT','Employé','Norsystec'),(291,1,'Omar Edawdi','888','NO_ACCOUNT','Employé','Norsystec'),(292,1,'Asma Ezaliiti','889','NO_ACCOUNT','Employé','Norsystec'),(293,1,'Mouhamed Aziz Ameri','890','NO_ACCOUNT','Employé','Logistique'),(294,1,'Aida Enajleoui','891','NO_ACCOUNT','Employé','Norsystec'),(295,1,'Imed Zeidi','892','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(296,1,'Rihab Bougezzi','893','NO_ACCOUNT','Employé','Prod.Cable SET'),(297,1,'Maroua Mesbehi','894','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(298,1,'Soumaya Kechich','903','NO_ACCOUNT','Employé','Prod.Cable SET'),(299,1,'Samia Sbaii','905','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(300,1,'Rafika Balghouthi','912','NO_ACCOUNT','Employé','Norsystec'),(301,1,'Najoua Elousifi','915','NO_ACCOUNT','Employé','Norsystec'),(302,1,'Hayfa Boujlida','920','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(303,1,'Zahra Aiechi','922','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(304,1,'Rim Agoubi','923','NO_ACCOUNT','Employé','Prod.Cable SET'),(305,1,'Nahed Haddeji','926','NO_ACCOUNT','Employé','Prod.Cable SET'),(306,1,'Intissar Fdhily','929','NO_ACCOUNT','Employé','Prod.Cable SET'),(307,1,'Aya Khlifa','931','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(308,1,'Amir Elhaouem','933','NO_ACCOUNT','Employé','Logistique'),(309,1,'Bouthayna Ben hnia','935','NO_ACCOUNT','Employé','Prod.Cable SET'),(310,1,'Ichrak Elhattab','938','NO_ACCOUNT','Employé','Norsystec'),(311,1,'Aya Omezzin Bel hadj','939','NO_ACCOUNT','Employé','Norsystec'),(312,1,'Houda Hanzouli','945','NO_ACCOUNT','Employé','Norsystec'),(313,1,'Narjes Ayedi','948','NO_ACCOUNT','Employé','Prod.Cable SET'),(314,1,'Mariem Elkemti','950','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(315,1,'Amal Ifeoui','952','NO_ACCOUNT','Employé','Prod.Cable SET'),(316,1,'Mahmoud Azzouz','954','NO_ACCOUNT','Employé','Logistique'),(317,1,'Afef Debech','958','NO_ACCOUNT','Employé','Norsystec'),(318,1,'Jamila Ben Hsan','959','NO_ACCOUNT','Employé','Norsystec'),(319,1,'Sawssen Ben Hadj Mahmoud','961','NO_ACCOUNT','Employé','Prod.Cable SET'),(320,1,'Zaineb Tayen','964','NO_ACCOUNT','Employé','Norsystec'),(321,1,'Khouloud bouaskar','966','NO_ACCOUNT','Employé','Norsystec'),(322,1,'Manel Elouergmi','968','NO_ACCOUNT','Employé','Norsystec'),(323,1,'Senda Bouaskar','969','NO_ACCOUNT','Employé','Norsystec'),(324,1,'Gazi Baklouti','971','NO_ACCOUNT','Employé','Norsystec'),(325,1,'Henda Elhanzouli','972','NO_ACCOUNT','Employé','Norsystec'),(326,1,'Samah Dioueni','975','NO_ACCOUNT','Employé','Prod.Cable SET'),(327,1,'Abir Elothmani','978','NO_ACCOUNT','Employé','Prod.Cable SET'),(328,1,'Aiada Abdellaoui','980','NO_ACCOUNT','Employé','Norsystec'),(329,1,'Ikram Mesbehi','982','NO_ACCOUNT','Employé','Prod.Cable SET'),(330,1,'Med Ali Hraiech','984','NO_ACCOUNT','Employé','Norsystec'),(331,1,'Racha Selimi','985','NO_ACCOUNT','Employé','Norsystec'),(332,1,'Molka Ben Ahmed','988','NO_ACCOUNT','Employé','Norsystec'),(333,1,'Yosra Nasri','990','NO_ACCOUNT','Employé','Norsystec'),(334,1,'Helmi Bouzaabia','995','NO_ACCOUNT','Employé','Norsystec'),(335,1,'Monia Zneki','996','NO_ACCOUNT','Employé','Norsystec'),(336,1,'Majda Dhifellaoui','999','NO_ACCOUNT','Employé','Norsystec'),(337,1,'Radhia Ftiti','1001','NO_ACCOUNT','Employé','Norsystec'),(338,1,'Sawssen Zaibi','1006','NO_ACCOUNT','Employé','Norsystec'),(339,1,'Sahar Elsaadli','1011','NO_ACCOUNT','Employé','Prod.Cable SET'),(340,1,'Nermin Karmous','1015','NO_ACCOUNT','Employé','Norsystec'),(341,1,'Chiraz Elothmani','1018','NO_ACCOUNT','Employé','Norsystec'),(342,1,'Mouna Zaidi','1025','NO_ACCOUNT','Employé','Norsystec'),(343,1,'Sana Marzouki','1048','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(344,1,'Rakia Mbark','1049','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(345,1,'Samar Abdelghani','1055','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(346,1,'Amal Amaira','1063','NO_ACCOUNT','Employé','Prod.Cable SET'),(347,1,'Amal Hamdi','1068','NO_ACCOUNT','Employé','Norsystec'),(348,1,'Yosr Bouzaabia','1075','NO_ACCOUNT','Employé','Norsystec'),(349,1,'Faten Ali','1077','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(350,1,'ADEM BEN HMIDA','1083','NO_ACCOUNT','Employé','Logistique'),(351,1,'Samia Ksouda','1089','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(352,1,'Salma Mabrouki','1091','NO_ACCOUNT','Employé','Norsystec'),(353,1,'Elhem Abdellaoui','1093','NO_ACCOUNT','Employé','Norsystec'),(354,1,'Jamila Dhaouedi','1095','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(355,1,'Sana Souii','1111','NO_ACCOUNT','Employé','Prod.Cable SET'),(356,1,'Hayet BEN SAAD','1119','NO_ACCOUNT','Employé','Prod.Cable SET'),(357,1,'Hanin Labidi','1120','NO_ACCOUNT','Employé','Norsystec'),(358,1,'MAROUA MNED','1122','NO_ACCOUNT','Employé','Norsystec'),(359,1,'AMMAR HNAZLI','1124','NO_ACCOUNT','Employé','Norsystec'),(360,1,'YASSINE KHLIFA','1125','NO_ACCOUNT','Employé','Norsystec'),(361,1,'Ahlem Bannouri','1131','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(362,1,'Seifeddine Kmilete','1133','1133','Responsable RH','Ressources Huamines'),(363,1,'Asma Hbari','1139','NO_ACCOUNT','Employé','Norsystec'),(364,1,'Iselm Khobzi','1141','NO_ACCOUNT','Employé','Norsystec'),(365,1,'Sawssen Bouzaabia','1143','NO_ACCOUNT','Employé','Norsystec'),(366,1,'Houssemddine Bouasker','1152','NO_ACCOUNT','Employé','Prod.Cable SET'),(367,1,'Omezzine Ben Hmida','1157','NO_ACCOUNT','Employé','Prod.Cable SET'),(368,1,'Donia Karoui','1158','NO_ACCOUNT','Employé','Prod.Cable SET'),(369,1,'Omar Ben Chaabane','1161','NO_ACCOUNT','Employé','Norsystec'),(370,1,'Sameh Bouzaabia','1165','NO_ACCOUNT','Employé','Prod.Cable SET'),(371,1,'Jihene Bouzaabia','1166','NO_ACCOUNT','Employé','Norsystec'),(372,1,'Ons Ghribi','1167','NO_ACCOUNT','Employé','Prod.Cable SET'),(373,1,'Imen Ben Hafsia','1168','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(374,1,'Wafa Horchani','1171','NO_ACCOUNT','Employé','Norsystec'),(375,1,'Fattoum Yaacoubi','1173','NO_ACCOUNT','Employé','Norsystec'),(376,1,'Amel Chebli','1175','NO_ACCOUNT','Employé','Prod.Cable SET'),(377,1,'Mohamed Sayari','1176','NO_ACCOUNT','Employé','Maintenance'),(378,1,'Jawaher Frioui','1184','NO_ACCOUNT','Employé','Norsystec'),(379,1,'Mohamed Aziz Khlifa','1185','NO_ACCOUNT','Employé','Prod.Cable SET'),(380,1,'Hanadi Bouzaabia','1188','NO_ACCOUNT','Employé','Prod.Cable SET'),(381,1,'Rihab Yaacoubi','1189','NO_ACCOUNT','Employé','Prod.Cable SET'),(382,1,'Thouraya Henchiri','1190','NO_ACCOUNT','Employé','Prod.Cable SET'),(383,1,'Latifa Abdelghani','1192','NO_ACCOUNT','Employé','Norsystec'),(384,1,'Intissar Bouguezzi','1193','NO_ACCOUNT','Employé','Norsystec'),(385,1,'Hanen Abaidi','1194','NO_ACCOUNT','Employé','Norsystec'),(386,1,'Nassima Abdaoui','1195','NO_ACCOUNT','Employé','Norsystec'),(387,1,'chaima Abdaoui','1196','NO_ACCOUNT','Employé','Norsystec'),(388,1,'Fatma Mnissi','1197','NO_ACCOUNT','Employé','Norsystec'),(389,1,'Salma Khlifi','1202','NO_ACCOUNT','Employé','Prod.Cable SET'),(390,1,'Chaima Aini','1206','NO_ACCOUNT','Employé','Prod.Cable SET'),(391,1,'Arwa Zitouni','1207','NO_ACCOUNT','Employé','Prod.Cable SET'),(392,1,'Faiza Khlifi','1208','NO_ACCOUNT','Employé','Prod.Cable SET'),(393,1,'Marwa Ayed','1210','NO_ACCOUNT','Employé','Norsystec'),(394,1,'Souad Khlifi','1211','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(395,1,'Wissem Ghazouani','1213','NO_ACCOUNT','Employé','Ressources Huamines'),(396,1,'Imen Bouraoui','1224','NO_ACCOUNT','Employé','Prod.Cable SET'),(397,1,'Amal Bouzaabia','1229','NO_ACCOUNT','Employé','Prod.Cable SET'),(398,1,'Kawther Jaballah','1231','NO_ACCOUNT','Employé','Prod.Cable SET'),(399,1,'Mariem Baccouche','1232','NO_ACCOUNT','Employé','Prod.Cable SET'),(400,1,'Amani Fteiti','1233','NO_ACCOUNT','Employé','Norsystec'),(401,1,'Dhekra Khlifa','1236','NO_ACCOUNT','Employé','Norsystec'),(402,1,'Mariem Bouzaabia','1241','NO_ACCOUNT','Employé','Norsystec'),(403,1,'Rihab Baccouche','1243','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(404,1,'Takwa Zalfani','1246','NO_ACCOUNT','Employé','Norsystec'),(405,1,'Mariem Ben Njima','1247','NO_ACCOUNT','Employé','Norsystec'),(406,1,'Fatma Saoudi','1255','NO_ACCOUNT','Employé','Norsystec'),(407,1,'Nahida Kassebi','1256','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(408,1,'Seifeddine Abbadi','1258','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(409,1,'Souha Fhima','1261','NO_ACCOUNT','Employé','Logistique'),(410,1,'Mayssa Ben Ali','1262','NO_ACCOUNT','Employé','Logistique'),(411,1,'Anwar Ben Aicha','1264','NO_ACCOUNT','EMPLOYE','Direction'),(412,1,'Sami Ben Saad','1265','NO_ACCOUNT','Employé','Prod.Cable SET'),(413,1,'Oussama Khlifi','1267','NO_ACCOUNT','Employé','Prod.Cable SET'),(414,1,'Wiem Jouini','1269','NO_ACCOUNT','Employé','Prod.Cable SET'),(415,1,'Mariem Ben Hassen','1271','NO_ACCOUNT','Employé','Prod.Cable SET'),(416,1,'Samar Toumi','1272','NO_ACCOUNT','Employé','Prod.Cable SET'),(417,1,'Ines Yahyaoui','1273','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(418,1,'Sana Rebhi','1274','NO_ACCOUNT','Employé','Prod.Cable SET'),(419,1,'Chaima Guesem','1275','NO_ACCOUNT','Employé','Norsystec'),(420,1,'Sirine Ben Romdhane','1276','NO_ACCOUNT','Employé','Prod.Cable SET'),(421,1,'Haifa Bouraoui','1278','NO_ACCOUNT','Employé','Norsystec'),(422,1,'Seifeddine Salem','1280','NO_ACCOUNT','Employé','Norsystec'),(423,1,'Mohamed Houcine Azzouz','1281','NO_ACCOUNT','Employé','Norsystec'),(424,1,'Chaima Hassini','1282','NO_ACCOUNT','Employé','Norsystec'),(425,1,'Jihen Bouasker','1283','NO_ACCOUNT','Employé','Norsystec'),(426,1,'Lina Hamdi','1284','NO_ACCOUNT','Employé','Norsystec'),(427,1,'Maroua Chaabani','1286','NO_ACCOUNT','Employé','Norsystec'),(428,1,'Tayma Khlifa','1290','NO_ACCOUNT','Employé','Norsystec'),(429,1,'Amal Houas','1292','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(430,1,'Nadhem Hedyaoui','1293','NO_ACCOUNT','Employé','Prod.Cable SET'),(431,1,'Mohamed Mahmoud','1295','NO_ACCOUNT','Employé','Norsystec'),(432,1,'Mohamed Arif','1298','NO_ACCOUNT','Employé','Norsystec'),(433,1,'Fethi Hnazli','1299','NO_ACCOUNT','Employé','Norsystec'),(434,1,'Mohaned Ben Njima','1300','NO_ACCOUNT','Employé','Norsystec'),(435,1,'Nabil Sayhi','1301','NO_ACCOUNT','Employé','Norsystec'),(436,1,'Zohra Jaouadi','1302','NO_ACCOUNT','Employé','Ressources Huamines'),(437,1,'Raja Jeddi','1303','NO_ACCOUNT','Employé','Norsystec'),(438,1,'Syrine Bouattay','1305','NO_ACCOUNT','Employé','Méthode'),(439,1,'Chaima Allagui','1306','NO_ACCOUNT','Employé','Méthode'),(440,1,'Mariem Khabbacha','1309','NO_ACCOUNT','Employé','Qualité'),(441,1,'Ali Sghaier','1315','NO_ACCOUNT','Employé','Norsystec'),(442,1,'Ibtissem TLILI','1320','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(443,1,'Ramzi Kheder','1322','NO_ACCOUNT','Employé','Prod.Cable SET'),(444,1,'Samia Ezzi','1323','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(445,1,'Amal Hamdi','1324','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(446,1,'Henda Belgacem','1325','NO_ACCOUNT','Employé','Prod.Cable SET'),(447,1,'Bouthaina Hamdi','1327','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(448,1,'Rabiaa Khlifi','1328','NO_ACCOUNT','Employé','Norsystec'),(449,1,'Khalil Belghouthi','1373','NO_ACCOUNT','Employé','Logistique'),(450,1,'Houssemddine Lakhal','1376','1376','Validateur Supérieur Hiérarchique','Logistique'),(451,1,'Mohamed Bouraoui Trabelsi','1377','NO_ACCOUNT','Employé','Maintenance'),(452,1,'Makrem Selmi','1378','NO_ACCOUNT','Employé','Maintenance'),(453,1,'Rania Romdhane','1380','NO_ACCOUNT','Employé','Logistique'),(454,1,'Samah Haj Ali','1382','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(455,1,'Hanen Raisi','1383','NO_ACCOUNT','Employé','Prod.Cable SET'),(456,1,'Monia Abboud','1384','NO_ACCOUNT','Employé','Prod.Cable SET'),(457,1,'Kaisser Bouassida','1387','NO_ACCOUNT','Employé','Méthode'),(458,1,'Sami Sagaama','1388','NO_ACCOUNT','Employé','Méthode'),(459,1,'Marwa Bouzaabia','1389','NO_ACCOUNT','Employé','Prod.Cable SET'),(460,1,'Yosra Loussifi','1390','NO_ACCOUNT','Employé','Prod.Cable SET'),(461,1,'Ameni Amri','1391','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(462,1,'Radhia Ammar','1392','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(463,1,'Afef Aouichi','1393','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(464,1,'Hayet Chorfa','1394','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(465,1,'Hasna Bouyahya','1395','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(466,1,'Ridha Allouche','1396','1396','Sécurité','Ressources Huamines'),(467,1,'Wissemeddine KHAYATI','1399','NO_ACCOUNT','Employé','Logistique'),(468,1,'Sana Mhadhbi','1401','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(469,1,'Chaima Abdelghani','1402','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(470,1,'Maram Rached','1403','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(471,1,'Amina Bouraoui','1405','NO_ACCOUNT','Employé','Prod. Cable WH-E'),(472,1,'Yassine Znagui','1406','NO_ACCOUNT','Employé','Ressources Huamines'),(473,1,'Rabiaa Hamdi','1408','NO_ACCOUNT','Employé','Prod.Cable SET'),(474,1,'Khaled Achour','1409','NO_ACCOUNT','Employé','Qualité'),(475,1,'Karem Mahmoudi','1410','NO_ACCOUNT','Employé','Prod.Cable SET');
/*!40000 ALTER TABLE `employe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historique_anomalie`
--

DROP TABLE IF EXISTS `historique_anomalie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historique_anomalie` (
  `id` bigint NOT NULL,
  `commentaire` varchar(255) DEFAULT NULL,
  `date_validation` datetime(6) DEFAULT NULL,
  `statut` varchar(255) DEFAULT NULL,
  `valide_par` varchar(255) DEFAULT NULL,
  `anomalie_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK124m5ef5ymg5ljrmmjvolm4tc` (`anomalie_id`),
  CONSTRAINT `FK124m5ef5ymg5ljrmmjvolm4tc` FOREIGN KEY (`anomalie_id`) REFERENCES `anomalie_pointage` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historique_anomalie`
--

LOCK TABLES `historique_anomalie` WRITE;
/*!40000 ALTER TABLE `historique_anomalie` DISABLE KEYS */;
/*!40000 ALTER TABLE `historique_anomalie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historique_anomalie_seq`
--

DROP TABLE IF EXISTS `historique_anomalie_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historique_anomalie_seq` (
  `next_val` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historique_anomalie_seq`
--

LOCK TABLES `historique_anomalie_seq` WRITE;
/*!40000 ALTER TABLE `historique_anomalie_seq` DISABLE KEYS */;
INSERT INTO `historique_anomalie_seq` VALUES (1);
/*!40000 ALTER TABLE `historique_anomalie_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `infermerie`
--

DROP TABLE IF EXISTS `infermerie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `infermerie` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `motif` varchar(255) DEFAULT NULL,
  `statut` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `employe_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKfmmbcqhp6yne4uhf8t36qt8sc` (`employe_id`),
  CONSTRAINT `FKfmmbcqhp6yne4uhf8t36qt8sc` FOREIGN KEY (`employe_id`) REFERENCES `employe` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `infermerie`
--

LOCK TABLES `infermerie` WRITE;
/*!40000 ALTER TABLE `infermerie` DISABLE KEYS */;
/*!40000 ALTER TABLE `infermerie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interrogatoire`
--

DROP TABLE IF EXISTS `interrogatoire`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interrogatoire` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `date_conseil_discipline` date DEFAULT NULL,
  `date_debut_suspension` date DEFAULT NULL,
  `nombre_jours` int DEFAULT NULL,
  `punition_proposee` varchar(255) DEFAULT NULL,
  `reponse_employe` text,
  `sujet` varchar(255) DEFAULT NULL,
  `employe_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK51m3g3rgtu2bwjy2obdun2ls2` (`employe_id`),
  CONSTRAINT `FK51m3g3rgtu2bwjy2obdun2ls2` FOREIGN KEY (`employe_id`) REFERENCES `employe` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interrogatoire`
--

LOCK TABLES `interrogatoire` WRITE;
/*!40000 ALTER TABLE `interrogatoire` DISABLE KEYS */;
/*!40000 ALTER TABLE `interrogatoire` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-15 10:39:38
