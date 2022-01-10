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
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction` (
  `idTransaction` int NOT NULL,
  `Membre_CodeMembre` int NOT NULL,
  `Etat` varchar(45) DEFAULT NULL,
  `Proposition_idProposition` int NOT NULL,
  `DureeInitiale` int DEFAULT NULL,
  `DureeEffective` int DEFAULT NULL,
  `DatePrevisionnelle` datetime DEFAULT NULL,
  `DateRealisation` datetime DEFAULT NULL,
  PRIMARY KEY (`idTransaction`),
  KEY `fk_Transaction_Membre1_idx` (`Membre_CodeMembre`),
  KEY `fk_Transaction_Proposition1_idx` (`Proposition_idProposition`),
  CONSTRAINT `fk_Transaction_Membre1` FOREIGN KEY (`Membre_CodeMembre`) REFERENCES `membre` (`CodeMembre`),
  CONSTRAINT `fk_Transaction_Proposition1` FOREIGN KEY (`Proposition_idProposition`) REFERENCES `proposition` (`idProposition`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;



DELIMITER $$
USE `sel_la2_monnaie`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `transactions`()
BEGIN
declare i integer;
declare nb_utilisateur integer;
declare nb_proposition integer;
declare utilisateur_aleatoire integer;
declare proposition_aleatoire integer;
declare duree_initiale integer;
declare duree_effective integer;
declare date_previsionnelle date;
declare date_debut_prop date;
declare date_fin_prop date;
declare existe integer;
declare etat varchar(50);
set i=1;
select count(*) into nb_utilisateur from membre;
select count(*) into nb_proposition from proposition;

boucle : loop
    set utilisateur_aleatoire=RAND()*(nb_utilisateur-1)+1;
    set proposition_aleatoire=RAND()*(nb_proposition-1)+1;
    select count(*) into existe from proposition where idProposition=proposition_aleatoire;
    if existe <>0 then
        set duree_initiale=RAND()*(10-1)+1;
        set duree_effective=RAND()*(10-1)+1;
        select DateDebut,DateFin into date_debut_prop,date_fin_prop from proposition where idProposition=proposition_aleatoire;
        set date_previsionnelle=date_format(
            from_unixtime(
                 rand() *
                    (unix_timestamp(date_debut_prop) - unix_timestamp(date_fin_prop)) +
                     unix_timestamp(date_fin_prop)
                          ), '%Y-%m-%d ');
                          
         if date_previsionnelle<now() then
            set etat='termine';
         else if date_previsionnelle=now() then
            set etat='en cours';
            else set etat='planifiee';
            set duree_effective=null;
            end if;
         end if;
         insert into transaction values (i,utilisateur_aleatoire,etat,proposition_aleatoire,duree_initiale,duree_effective,date_previsionnelle,date_previsionnelle);
    end if;
    if i<12000 then 
        set i=i+1;
        iterate boucle;
    end if;
    leave boucle;
end loop;
END$$

DELIMITER ;
;

call transactionc();

/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
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
