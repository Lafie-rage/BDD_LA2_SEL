-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 02, 2021 at 10:15 PM
-- Server version: 8.0.27-0ubuntu0.20.04.1
-- PHP Version: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `SEL_LA2_Monnaie`
--
CREATE DATABASE IF NOT EXISTS `SEL_LA2_Monnaie` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `SEL_LA2_Monnaie`;

-- --------------------------------------------------------

--
-- Table structure for table `categorie`
--

DROP TABLE IF EXISTS `categorie`;
CREATE TABLE `categorie` (
  `idCategorie` int NOT NULL,
  `description` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `competence`
--

DROP TABLE IF EXISTS `competence`;
CREATE TABLE `competence` (
  `idCompetence` int NOT NULL,
  `Description` varchar(100) DEFAULT NULL,
  `Categorie_idCategorie` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `competencemembre`
--

DROP TABLE IF EXISTS `competencemembre`;
CREATE TABLE `competencemembre` (
  `Competence_idCompetence` int NOT NULL,
  `Membre_CodeMembre` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `cotisation`
--

DROP TABLE IF EXISTS `cotisation`;
CREATE TABLE `cotisation` (
  `DateDebut` datetime NOT NULL,
  `Prix` int NOT NULL,
  `DateFin` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `espacedonnees`
--

DROP TABLE IF EXISTS `espacedonnees`;
CREATE TABLE `espacedonnees` (
  `Contenu` varchar(255) DEFAULT NULL,
  `Membre_CodeMembre` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `membre`
--

DROP TABLE IF EXISTS `membre`;
CREATE TABLE `membre` (
  `CodeMembre` int NOT NULL,
  `Nom` varchar(100) DEFAULT NULL,
  `Prenom` varchar(100) DEFAULT NULL,
  `Rue` varchar(100) DEFAULT NULL,
  `Ville` varchar(100) DEFAULT NULL,
  `CodePostal` varchar(10) DEFAULT NULL,
  `DateNaissance` varchar(45) DEFAULT NULL,
  `Mail` varchar(100) DEFAULT NULL,
  `Telephone` varchar(15) DEFAULT NULL,
  `CompteTemps` int DEFAULT NULL,
  `habitantParc` tinyint(1) NOT NULL DEFAULT '0',
  `nom_de_commerce` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `solde_ecu` float NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `membre_has_cotisation`
--

DROP TABLE IF EXISTS `membre_has_cotisation`;
CREATE TABLE `membre_has_cotisation` (
  `Membre_CodeMembre` int NOT NULL,
  `DatePaiement` datetime DEFAULT NULL,
  `Id_Membre_has_Cotisationcol` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `operation`
--

DROP TABLE IF EXISTS `operation`;
CREATE TABLE `operation` (
  `idOperation` int NOT NULL,
  `codeDebiteur` int NOT NULL,
  `codeCrediteur` int NOT NULL,
  `dateHeureOperation` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `montantEcu` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `operationchange`
--

DROP TABLE IF EXISTS `operationchange`;
CREATE TABLE `operationchange` (
  `idChange` int NOT NULL,
  `montant` float NOT NULL,
  `type` varchar(10) NOT NULL,
  `Membre_CodeMembre` int NOT NULL,
  `dateHeureChange` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `soldeCompte` float NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `proposition`
--

DROP TABLE IF EXISTS `proposition`;
CREATE TABLE `proposition` (
  `idProposition` int NOT NULL,
  `Competence_idCompetence` int NOT NULL,
  `Description` varchar(100) DEFAULT NULL,
  `DateDebut` datetime DEFAULT NULL,
  `DateFin` datetime DEFAULT NULL,
  `Membre_CodeMembre` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
CREATE TABLE `transaction` (
  `idTransaction` int NOT NULL,
  `Membre_CodeMembre` int NOT NULL,
  `Etat` varchar(45) DEFAULT NULL,
  `Proposition_idProposition` int NOT NULL,
  `DureeInitiale` int DEFAULT NULL,
  `DureeEffective` int DEFAULT NULL,
  `DatePrevisionnelle` datetime DEFAULT NULL,
  `DateRealisation` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categorie`
--
ALTER TABLE `categorie`
  ADD PRIMARY KEY (`idCategorie`);

--
-- Indexes for table `competence`
--
ALTER TABLE `competence`
  ADD PRIMARY KEY (`idCompetence`),
  ADD KEY `fk_Competence_Categorie1_idx` (`Categorie_idCategorie`);

--
-- Indexes for table `competencemembre`
--
ALTER TABLE `competencemembre`
  ADD PRIMARY KEY (`Competence_idCompetence`,`Membre_CodeMembre`),
  ADD KEY `fk_CompetenceMembre_Competence1_idx` (`Competence_idCompetence`),
  ADD KEY `fk_CompetenceMembre_Membre1_idx` (`Membre_CodeMembre`);

--
-- Indexes for table `cotisation`
--
ALTER TABLE `cotisation`
  ADD PRIMARY KEY (`DateDebut`);

--
-- Indexes for table `espacedonnees`
--
ALTER TABLE `espacedonnees`
  ADD PRIMARY KEY (`Membre_CodeMembre`),
  ADD KEY `fk_EspaceDonnees_Membre1_idx` (`Membre_CodeMembre`);

--
-- Indexes for table `membre`
--
ALTER TABLE `membre`
  ADD PRIMARY KEY (`CodeMembre`);

--
-- Indexes for table `membre_has_cotisation`
--
ALTER TABLE `membre_has_cotisation`
  ADD PRIMARY KEY (`Id_Membre_has_Cotisationcol`),
  ADD KEY `FK_Membre_has_Cotisation_Membre_id` (`Membre_CodeMembre`) USING BTREE;

--
-- Indexes for table `operation`
--
ALTER TABLE `operation`
  ADD PRIMARY KEY (`idOperation`),
  ADD KEY `FK_Operation_debiteur_code` (`codeDebiteur`),
  ADD KEY `FK_Operation_crediteur_code` (`codeCrediteur`);

--
-- Indexes for table `operationchange`
--
ALTER TABLE `operationchange`
  ADD PRIMARY KEY (`idChange`),
  ADD KEY `fk_Operation_Change_Membre` (`Membre_CodeMembre`);

--
-- Indexes for table `proposition`
--
ALTER TABLE `proposition`
  ADD PRIMARY KEY (`idProposition`,`Competence_idCompetence`),
  ADD KEY `fk_Proposition_Competence1_idx` (`Competence_idCompetence`),
  ADD KEY `fk_Proposition_Membre1_idx` (`Membre_CodeMembre`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`idTransaction`),
  ADD KEY `fk_Transaction_Membre1_idx` (`Membre_CodeMembre`),
  ADD KEY `fk_Transaction_Proposition1_idx` (`Proposition_idProposition`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categorie`
--
ALTER TABLE `categorie`
  MODIFY `idCategorie` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `competence`
--
ALTER TABLE `competence`
  MODIFY `idCompetence` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `competencemembre`
--
ALTER TABLE `competencemembre`
  MODIFY `Competence_idCompetence` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `membre`
--
ALTER TABLE `membre`
  MODIFY `CodeMembre` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `operation`
--
ALTER TABLE `operation`
  MODIFY `idOperation` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `operationchange`
--
ALTER TABLE `operationchange`
  MODIFY `idChange` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `idTransaction` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `competence`
--
ALTER TABLE `competence`
  ADD CONSTRAINT `fk_Competence_Categorie1` FOREIGN KEY (`Categorie_idCategorie`) REFERENCES `categorie` (`idCategorie`);

--
-- Constraints for table `competencemembre`
--
ALTER TABLE `competencemembre`
  ADD CONSTRAINT `fk_CompetenceMembre_Competence1` FOREIGN KEY (`Competence_idCompetence`) REFERENCES `competence` (`idCompetence`),
  ADD CONSTRAINT `fk_CompetenceMembre_Membre1` FOREIGN KEY (`Membre_CodeMembre`) REFERENCES `membre` (`CodeMembre`);

--
-- Constraints for table `espacedonnees`
--
ALTER TABLE `espacedonnees`
  ADD CONSTRAINT `fk_EspaceDonnees_Membre1` FOREIGN KEY (`Membre_CodeMembre`) REFERENCES `membre` (`CodeMembre`);

--
-- Constraints for table `membre_has_cotisation`
--
ALTER TABLE `membre_has_cotisation`
  ADD CONSTRAINT `FK_Membre_has_Cotisation_Membre` FOREIGN KEY (`Membre_CodeMembre`) REFERENCES `membre` (`CodeMembre`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `operation`
--
ALTER TABLE `operation`
  ADD CONSTRAINT `FK_Operation_crediteur_code` FOREIGN KEY (`codeCrediteur`) REFERENCES `membre` (`CodeMembre`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Operation_debiteur_code` FOREIGN KEY (`codeDebiteur`) REFERENCES `membre` (`CodeMembre`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `operationchange`
--
ALTER TABLE `operationchange`
  ADD CONSTRAINT `fk_Operation_Change_Membre` FOREIGN KEY (`Membre_CodeMembre`) REFERENCES `membre` (`CodeMembre`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `proposition`
--
ALTER TABLE `proposition`
  ADD CONSTRAINT `fk_Proposition_Competence1` FOREIGN KEY (`Competence_idCompetence`) REFERENCES `competence` (`idCompetence`),
  ADD CONSTRAINT `fk_Proposition_Membre1` FOREIGN KEY (`Membre_CodeMembre`) REFERENCES `membre` (`CodeMembre`);

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `fk_Transaction_Membre1` FOREIGN KEY (`Membre_CodeMembre`) REFERENCES `membre` (`CodeMembre`),
  ADD CONSTRAINT `fk_Transaction_Proposition1` FOREIGN KEY (`Proposition_idProposition`) REFERENCES `proposition` (`idProposition`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
