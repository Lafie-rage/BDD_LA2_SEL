-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `membre_has_cotisation`
--

DROP TABLE IF EXISTS `membre_has_cotisation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `membre_has_cotisation` (
  `Membre_CodeMembre` int NOT NULL,
  `DatePaiement` datetime DEFAULT NULL,
  `Id_Membre_has_Cotisationcol` int NOT NULL,
  PRIMARY KEY (`Id_Membre_has_Cotisationcol`),
  KEY `fk_Membre_has_Cotisation_Membre1_idx` (`Membre_CodeMembre`),
  CONSTRAINT `fk_Membre_has_Cotisation_Membre1` FOREIGN KEY (`Membre_CodeMembre`) REFERENCES `membre` (`CodeMembre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membre_has_cotisation`
--

LOCK TABLES `membre_has_cotisation` WRITE;
/*!40000 ALTER TABLE `membre_has_cotisation` DISABLE KEYS */;
INSERT INTO `membre_has_cotisation` VALUES (1,'2021-06-23 00:00:00',1),(1,'2020-02-09 00:00:00',2),(2,'2021-09-12 00:00:00',3),(3,'2021-02-07 00:00:00',4),(3,'2018-11-01 00:00:00',5);
/*!40000 ALTER TABLE `membre_has_cotisation` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-18 14:13:36
