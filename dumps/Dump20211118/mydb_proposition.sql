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
-- Table structure for table `proposition`
--

DROP TABLE IF EXISTS `proposition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proposition` (
  `idProposition` int NOT NULL,
  `Competence_idCompetence` int NOT NULL,
  `Description` varchar(100) DEFAULT NULL,
  `DateDebut` datetime DEFAULT NULL,
  `DateFin` datetime DEFAULT NULL,
  `Membre_CodeMembre` int NOT NULL,
  PRIMARY KEY (`idProposition`,`Competence_idCompetence`),
  KEY `fk_Proposition_Competence1_idx` (`Competence_idCompetence`),
  KEY `fk_Proposition_Membre1_idx` (`Membre_CodeMembre`),
  CONSTRAINT `fk_Proposition_Competence1` FOREIGN KEY (`Competence_idCompetence`) REFERENCES `competence` (`idCompetence`),
  CONSTRAINT `fk_Proposition_Membre1` FOREIGN KEY (`Membre_CodeMembre`) REFERENCES `membre` (`CodeMembre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proposition`
--

LOCK TABLES `proposition` WRITE;
/*!40000 ALTER TABLE `proposition` DISABLE KEYS */;
INSERT INTO `proposition` VALUES (1,1,'sortie cyclisme','2021-11-20 00:00:00','2021-12-02 00:00:00',1),(2,1,'sortie cyclisme','2021-11-10 00:00:00','2021-12-31 00:00:00',2),(3,5,'piano en groupe','2021-11-19 00:00:00','2022-02-27 00:00:00',1),(4,5,'piano en groupe','2021-11-19 00:00:00','2022-01-03 00:00:00',7),(5,5,'piano individuel','2021-11-19 00:00:00','2022-02-27 00:00:00',7),(6,5,'piano en groupe','2021-11-19 00:00:00','2022-02-27 00:00:00',1),(7,14,'part de welsh','2021-11-25 00:00:00','2021-11-26 00:00:00',1);
/*!40000 ALTER TABLE `proposition` ENABLE KEYS */;
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
