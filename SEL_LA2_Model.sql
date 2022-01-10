-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : jeu. 25 nov. 2021 à 11:05
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
-- Base de données : `SEL_LA2`
--

-- --------------------------------------------------------

--
-- Structure de la table `categorie`
--

DROP TABLE IF EXISTS `categorie`;
CREATE TABLE `categorie` (
  `idCategorie` int NOT NULL,
  `description` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `competence`
--

DROP TABLE IF EXISTS `competence`;
CREATE TABLE `competence` (
  `idCompetence` int NOT NULL,
  `Description` varchar(100) DEFAULT NULL,
  `Categorie_idCategorie` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `competencemembre`
--

DROP TABLE IF EXISTS `competencemembre`;
CREATE TABLE `competencemembre` (
  `Competence_idCompetence` int NOT NULL,
  `Membre_CodeMembre` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `cotisation`
--

DROP TABLE IF EXISTS `cotisation`;
CREATE TABLE `cotisation` (
  `id` int NOT NULL,
  `DateDebut` datetime NOT NULL,
  `Prix` int NOT NULL,
  `DateFin` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `espacedonnees`
--

DROP TABLE IF EXISTS `espacedonnees`;
CREATE TABLE `espacedonnees` (
  `Contenu` varchar(255) DEFAULT NULL,
  `Membre_CodeMembre` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `membre`
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
  `CompteTemps` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `membre_has_cotisation`
--

DROP TABLE IF EXISTS `membre_has_cotisation`;
CREATE TABLE `membre_has_cotisation` (
  `Membre_CodeMembre` int NOT NULL,
  `DatePaiement` datetime DEFAULT NULL,
  `Id_Membre_has_Cotisationcol` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `proposition`
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
-- Structure de la table `transaction`
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
-- Index pour les tables déchargées
--

--
-- Index pour la table `categorie`
--
ALTER TABLE `categorie`
  ADD PRIMARY KEY (`idCategorie`);

--
-- Index pour la table `competence`
--
ALTER TABLE `competence`
  ADD PRIMARY KEY (`idCompetence`),
  ADD KEY `fk_Competence_Categorie1_idx` (`Categorie_idCategorie`);

--
-- Index pour la table `competencemembre`
--
ALTER TABLE `competencemembre`
  ADD PRIMARY KEY (`Competence_idCompetence`,`Membre_CodeMembre`),
  ADD KEY `fk_CompetenceMembre_Competence1_idx` (`Competence_idCompetence`),
  ADD KEY `fk_CompetenceMembre_Membre1_idx` (`Membre_CodeMembre`);

--
-- Index pour la table `cotisation`
--
ALTER TABLE `cotisation`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `espacedonnees`
--
ALTER TABLE `espacedonnees`
  ADD PRIMARY KEY (`Membre_CodeMembre`),
  ADD KEY `fk_EspaceDonnees_Membre1_idx` (`Membre_CodeMembre`);

--
-- Index pour la table `membre`
--
ALTER TABLE `membre`
  ADD PRIMARY KEY (`CodeMembre`);

--
-- Index pour la table `membre_has_cotisation`
--
ALTER TABLE `membre_has_cotisation`
  ADD PRIMARY KEY (`Id_Membre_has_Cotisationcol`),
  ADD KEY `fk_Membre_has_Cotisation_Membre1_idx` (`Membre_CodeMembre`);

--
-- Index pour la table `proposition`
--
ALTER TABLE `proposition`
  ADD PRIMARY KEY (`idProposition`,`Competence_idCompetence`),
  ADD KEY `fk_Proposition_Competence1_idx` (`Competence_idCompetence`),
  ADD KEY `fk_Proposition_Membre1_idx` (`Membre_CodeMembre`);

--
-- Index pour la table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`idTransaction`),
  ADD KEY `fk_Transaction_Membre1_idx` (`Membre_CodeMembre`),
  ADD KEY `fk_Transaction_Proposition1_idx` (`Proposition_idProposition`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `cotisation`
--
ALTER TABLE `cotisation`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

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
  ADD CONSTRAINT `fk_Membre_has_Cotisation_Membre1` FOREIGN KEY (`Membre_CodeMembre`) REFERENCES `membre` (`CodeMembre`);

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


