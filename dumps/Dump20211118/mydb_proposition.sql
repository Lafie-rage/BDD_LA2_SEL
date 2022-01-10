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

DELIMITER $$
USE sel_la2_monnaie$$
CREATE DEFINER=root@localhost PROCEDURE propositions()
BEGIN
declare i integer;
declare nombre_membre integer;
declare nombre_competences integer;
declare date_debut_proposition date;
declare membre_aleatoire integer;
declare competence_aleatoire integer;
declare nb_jours_proposition integer;
declare datefin date;
declare description_competence varchar(120);
declare ligne_aleatoire integer;
declare nb_competences integer;
select count() into nombre_membre from membre;
select count() into nombre_competences from competence;

set i=1;
boucleNbIteration : loop
    set membre_aleatoire=RAND()*(nombre_membre-1)+1;
    set date_debut_proposition=date_format(
        from_unixtime(
             rand() *
                (unix_timestamp('2021-01-01 16:00:00') - unix_timestamp(now())) +
                 unix_timestamp(now())
                      ), '%Y-%m-%d ');
    set nb_jours_proposition=RAND()(365-1)+1;
    select DATE_ADD(date_debut_proposition, INTERVAL nb_jours_proposition DAY) into datefin;
    select count() into nb_competences from competencemembre where Membre_CodeMembre=membre_aleatoire;
    if nb_competences>0 then 
    set ligne_aleatoire=RAND()*(nb_competences-1)+1;
    set ligne_aleatoire=ligne_aleatoire-1;
    SELECT Competence_idCompetence into competence_aleatoire from competencemembre Where Membre_CodeMembre=membre_aleatoire LIMIT 1 OFFSET ligne_aleatoire;
    select description into description_competence from competence where idCompetence=competence_aleatoire;
    insert into proposition values(i,competence_aleatoire,description_competence,date_debut_proposition,datefin,membre_aleatoire);
    end if;
    if i<12000 then
    set i=i+1;
    iterate boucleNbIteration;
    end if;
leave boucleNbIteration;
end loop;

END$$

DELIMITER ;
;

call propositions();

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
