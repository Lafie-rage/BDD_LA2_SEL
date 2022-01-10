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
-- Table structure for table `competencemembre`
--

DROP TABLE IF EXISTS `competencemembre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `competencemembre` (
  `Competence_idCompetence` int NOT NULL,
  `Membre_CodeMembre` int NOT NULL,
  PRIMARY KEY (`Competence_idCompetence`,`Membre_CodeMembre`),
  KEY `fk_CompetenceMembre_Competence1_idx` (`Competence_idCompetence`),
  KEY `fk_CompetenceMembre_Membre1_idx` (`Membre_CodeMembre`),
  CONSTRAINT `fk_CompetenceMembre_Competence1` FOREIGN KEY (`Competence_idCompetence`) REFERENCES `competence` (`idCompetence`),
  CONSTRAINT `fk_CompetenceMembre_Membre1` FOREIGN KEY (`Membre_CodeMembre`) REFERENCES `membre` (`CodeMembre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `competencemembre`
--

LOCK TABLES `competencemembre` WRITE;
/*!40000 ALTER TABLE `competencemembre` DISABLE KEYS */;

DELIMITER $$
USE sel_la2_monnaie$$
CREATE DEFINER=root@localhost PROCEDURE competencemembres()
BEGIN
declare i integer;
declare cle_exist integer;
declare nb_iteration integer;
declare nombre_competences integer;
declare competence_aleatoire integer;
declare nombre_membre integer;
declare j integer;
select count() into nombre_membre from membre;
select count() into nombre_competences from competence;
set i=1;
boucle_competence_membre : loop
    set nb_iteration = RAND()(6-1)+1;
    set nb_iteration = nb_iteration-2;
    set j=1;
    boucle_nb_competence : loop

        if j>nb_iteration then 
            leave boucle_nb_competence;
        end if;
        set competence_aleatoire = RAND()(nombre_competences-1)+1;
        select count(*) into cle_exist from competencemembre where Competence_idCompetence= competence_aleatoire and Membre_CodeMembre=i;
        if cle_exist=0 then
            insert into competencemembre values(competence_aleatoire,i);
        end if;
        set j=j+1;
        iterate boucle_nb_competence;
    end loop;
    if i < nombre_membre then
        set i=i+1;
        iterate boucle_competence_membre;
    end if;
    leave boucle_competence_membre;

end loop;
END$$

DELIMITER ;

call competencemembres();



/*!40000 ALTER TABLE `competencemembre` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-18 14:13:35
