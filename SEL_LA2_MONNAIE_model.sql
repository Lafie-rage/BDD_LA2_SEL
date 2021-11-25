-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : jeu. 25 nov. 2021 à 11:54
-- Version du serveur :  8.0.25-0ubuntu0.20.04.1
-- Version de PHP : 8.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `SEL_LA2_MONNAIE`
--
CREATE DATABASE IF NOT EXISTS `SEL_LA2_MONNAIE` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `SEL_LA2_MONNAIE`;

-- --------------------------------------------------------

--
-- Structure de la table `categorie`
--

DROP TABLE IF EXISTS `categorie`;
CREATE TABLE IF NOT EXISTS `categorie` (
  `idCategorie` int NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idCategorie`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `competence`
--

DROP TABLE IF EXISTS `competence`;
CREATE TABLE IF NOT EXISTS `competence` (
  `idCompetence` int NOT NULL,
  `Description` varchar(100) DEFAULT NULL,
  `Categorie_idCategorie` int NOT NULL,
  PRIMARY KEY (`idCompetence`),
  KEY `fk_Competence_Categorie1_idx` (`Categorie_idCategorie`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `competencemembre`
--

DROP TABLE IF EXISTS `competencemembre`;
CREATE TABLE IF NOT EXISTS `competencemembre` (
  `Competence_idCompetence` int NOT NULL,
  `Membre_CodeMembre` int NOT NULL,
  PRIMARY KEY (`Competence_idCompetence`,`Membre_CodeMembre`),
  KEY `fk_CompetenceMembre_Competence1_idx` (`Competence_idCompetence`),
  KEY `fk_CompetenceMembre_Membre1_idx` (`Membre_CodeMembre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `cotisation`
--

DROP TABLE IF EXISTS `cotisation`;
CREATE TABLE IF NOT EXISTS `cotisation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `DateDebut` datetime NOT NULL,
  `Prix` int NOT NULL,
  `DateFin` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `espacedonnees`
--

DROP TABLE IF EXISTS `espacedonnees`;
CREATE TABLE IF NOT EXISTS `espacedonnees` (
  `Contenu` varchar(255) DEFAULT NULL,
  `Membre_CodeMembre` int NOT NULL,
  PRIMARY KEY (`Membre_CodeMembre`),
  KEY `fk_EspaceDonnees_Membre1_idx` (`Membre_CodeMembre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `membre`
--

DROP TABLE IF EXISTS `membre`;
CREATE TABLE IF NOT EXISTS `membre` (
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
  `habitantParc` tinyint(1) NOT NULL,
  `particulier` tinyint(1) NOT NULL,
  `nom_de_commerce` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `solde_ecu` float NOT NULL,
  PRIMARY KEY (`CodeMembre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `membre_has_cotisation`
--

DROP TABLE IF EXISTS `membre_has_cotisation`;
CREATE TABLE IF NOT EXISTS `membre_has_cotisation` (
  `Membre_CodeMembre` int NOT NULL,
  `DatePaiement` datetime DEFAULT NULL,
  `Id_Membre_has_Cotisationcol` int NOT NULL,
  PRIMARY KEY (`Id_Membre_has_Cotisationcol`),
  KEY `FK_Membre_has_Cotisation_Membre_id` (`Membre_CodeMembre`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `operation`
--

DROP TABLE IF EXISTS `operation`;
CREATE TABLE IF NOT EXISTS `operation` (
  `idOperation` int NOT NULL AUTO_INCREMENT,
  `codeDebiteur` int NOT NULL,
  `codeCrediteur` int NOT NULL,
  `dateHeureOperation` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `montantEcu` float NOT NULL,
  PRIMARY KEY (`idOperation`),
  KEY `FK_Operation_debiteur_code` (`codeDebiteur`),
  KEY `FK_Operation_crediteur_code` (`codeCrediteur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `operationChange`
--

DROP TABLE IF EXISTS `operationChange`;
CREATE TABLE IF NOT EXISTS `operationChange` (
  `idChange` int NOT NULL AUTO_INCREMENT,
  `montant` float NOT NULL,
  `type` varchar(10) NOT NULL,
  `Membre_CodeMembre` int NOT NULL,
  `dateHeureChange` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `soldeCompte` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`idChange`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `proposition`
--

DROP TABLE IF EXISTS `proposition`;
CREATE TABLE IF NOT EXISTS `proposition` (
  `idProposition` int NOT NULL,
  `Competence_idCompetence` int NOT NULL,
  `Description` varchar(100) DEFAULT NULL,
  `DateDebut` datetime DEFAULT NULL,
  `DateFin` datetime DEFAULT NULL,
  `Membre_CodeMembre` int NOT NULL,
  PRIMARY KEY (`idProposition`,`Competence_idCompetence`),
  KEY `fk_Proposition_Competence1_idx` (`Competence_idCompetence`),
  KEY `fk_Proposition_Membre1_idx` (`Membre_CodeMembre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
CREATE TABLE IF NOT EXISTS `transaction` (
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
  KEY `fk_Transaction_Proposition1_idx` (`Proposition_idProposition`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `competence`
--
ALTER TABLE `competence`
  ADD CONSTRAINT `fk_Competence_Categorie1` FOREIGN KEY (`Categorie_idCategorie`) REFERENCES `categorie` (`idCategorie`);

--
-- Contraintes pour la table `competencemembre`
--
ALTER TABLE `competencemembre`
  ADD CONSTRAINT `fk_CompetenceMembre_Competence1` FOREIGN KEY (`Competence_idCompetence`) REFERENCES `competence` (`idCompetence`),
  ADD CONSTRAINT `fk_CompetenceMembre_Membre1` FOREIGN KEY (`Membre_CodeMembre`) REFERENCES `membre` (`CodeMembre`);

--
-- Contraintes pour la table `espacedonnees`
--
ALTER TABLE `espacedonnees`
  ADD CONSTRAINT `fk_EspaceDonnees_Membre1` FOREIGN KEY (`Membre_CodeMembre`) REFERENCES `membre` (`CodeMembre`);

--
-- Contraintes pour la table `membre_has_cotisation`
--
ALTER TABLE `membre_has_cotisation`
  ADD CONSTRAINT `FK_Membre_has_Cotisation_Membre` FOREIGN KEY (`Membre_CodeMembre`) REFERENCES `membre` (`CodeMembre`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `operation`
--
ALTER TABLE `operation`
  ADD CONSTRAINT `FK_Operation_crediteur_code` FOREIGN KEY (`codeCrediteur`) REFERENCES `membre` (`CodeMembre`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Operation_debiteur_code` FOREIGN KEY (`codeDebiteur`) REFERENCES `membre` (`CodeMembre`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `proposition`
--
ALTER TABLE `proposition`
  ADD CONSTRAINT `fk_Proposition_Competence1` FOREIGN KEY (`Competence_idCompetence`) REFERENCES `competence` (`idCompetence`),
  ADD CONSTRAINT `fk_Proposition_Membre1` FOREIGN KEY (`Membre_CodeMembre`) REFERENCES `membre` (`CodeMembre`);

--
-- Contraintes pour la table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `fk_Transaction_Membre1` FOREIGN KEY (`Membre_CodeMembre`) REFERENCES `membre` (`CodeMembre`),
  ADD CONSTRAINT `fk_Transaction_Proposition1` FOREIGN KEY (`Proposition_idProposition`) REFERENCES `proposition` (`idProposition`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
