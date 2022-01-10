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
-- Table structure for table `cotisation`
--

DROP TABLE IF EXISTS `cotisation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cotisation` (
  `DateDebut` datetime NOT NULL,
  `Prix` int DEFAULT NULL,
  `DateFin` datetime DEFAULT NULL,
  PRIMARY KEY (`DateDebut`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cotisation`
--

LOCK TABLES `cotisation` WRITE;
/*!40000 ALTER TABLE `cotisation` DISABLE KEYS */;


DELIMITER $$
CREATE PROCEDURE addRandomMembershipTariff()
BEGIN
  DECLARE counter INT;
  DECLARE newTariff INT;
  DECLARE oldTariff INT;
  DECLARE newTariffBeginDate DATE;

  SET counter = 0;

  -- iterate through years since 2001
  yearLoop: LOOP
    SET counter = counter + 1;
    SET newTariff = NULL;
    IF counter < (YEAR(CURRENT_DATE()) - 2000) THEN
      -- Randomly determine weather or not a new membership tariff has been defined
      -- There is 1/5 chance
      IF RAND() * 5 > 3 THEN
        -- Retrieve current tariff
        SELECT Prix INTO oldTariff FROM cotisation WHERE dateFin IS NULL;

        -- Iterate while new tariff is equal to the old one
        tariffLoop: LOOP
          -- Randomly generate a new tariff between5 and 25
          SET newTariff = RAND()* (21) + 5;
          IF newTariff = oldTariff AND oldTariff IS NOT NULL THEN
            ITERATE tariffLoop;
          END IF;
        LEAVE tariffLoop;
        END LOOP tariffLoop;

          IF newTariff IS NOT NULL THEN

              -- 2000 + counter gives the year of the new tariff
              SET newTariffBeginDate = STR_TO_DATE(CONCAT('01,1,', (2000 + counter)),'%d,%m,%Y');

              -- Define old tariff end date
              UPDATE cotisation SET DateFin = DATE_SUB(newTariffBeginDate,INTERVAL 1 DAY) WHERE DateFin IS NULL;

              -- Insert the new tariff
              INSERT INTO cotisation(DateDebut, Prix) VALUES (
              newTariffBeginDate,
              newTariff
              );
          END IF;
      END IF;
      ITERATE yearLoop;
    END IF;
  LEAVE yearLoop;
  END LOOP yearLoop;
END
$$

/*!40000 ALTER TABLE `cotisation` ENABLE KEYS */;
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
