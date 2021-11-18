#  SEL et Monnaie Locale : PLSQL

Ce document sert de compte rendu au TP n°2 de Base de Données réaliser lors de l'année 2021-2022.  
Ce document permet de répondre aux questions et d'exposer nos choix et nos réalisation.

Les membre du groupe ayant réalisé ce TP se trouvent dans la partie "Contributeurs", la dernière partie de ce document.

# Documentation supplémentatire

Le projet possède également un ensemble de documentation qui se trouve [ici](https://drive.google.com/drive/folders/1HUtnfMiaElMgTJvxY6ZfwDOUtS7gWKOl?usp=sharing).

# Questions

## Question 1

### 1.1, 1.2 et 1.3

Nous avons fait le choix de créer une vue **ACIVE_MEMBER**, elle gérera donc la mise à jour de l'état des membres en fonction de la date de leur dernière cotisation autant dans le cas d'un nouveau payement que d'une vérification quotidienne.

Voici le script de création de la vue **ACTIVE_MEMBER**:
```sql
CREATE VIEW ACTIVE_MEMBER AS
SELECT CodeMembre FROM membre_has_cotisation
WHERE DATE_ADD(DatePaiement,INTERVAL 1 YEAR) > CURRENT_DATE();
```

### 1.4

Voici le trigger réalisé :
```sql
 CREATE TRIGGER init_time_counter BEFORE INSERT ON membre FOR EACH ROW SET NEW.CompteTemps = 10;
```

### 1.5

Voici le script d'ajout du trigger :

```sql
DELIMITER $$
CREATE PROCEDURE updateTransactionStatus(IN newStatus VARCHAR(45), IN transactionId INT)
BEGIN
	DECLARE newCompteTemps INT;
	DECLARE beneficiary INT;
    DECLARE propositionId INT;
    DECLARE author INT;
	CASE
		WHEN newStatus = "En cours" OR newStatus = "Prévu" OR newStatus = "Terminé" THEN
        	UPDATE transaction SET Etat = newStatus WHERE idTransaction = transactionId LIMIT 1;
    END CASE;
    IF newStatus = "Terminé" THEN
   		SELECT DureeEffective, Membre_CodeMembre, Proposition_idProposition INTO newCompteTemps, beneficiary, propositionId FROM transaction WHERE idTransaction = transactionId LIMIT 1;
    	SELECT Membre_CodeMembre INTO author FROM proposition WHERE idProposition = propositionId LIMIT 1;
    	UPDATE membre SET CompteTemps=CompteTemps+newCompteTemps WHERE CodeMembre = author LIMIT 1;
        UPDATE membre SET CompteTemps=CompteTemps-newCompteTemps WHERE CodeMembre = beneficiary LIMIT 1;
    END IF;
END;
$$
```

```sql
DELIMITER $$
CREATE TRIGGER MAJ_SOLDE
 AFTER
UPDATE ON transaction
FOR EACH ROW
BEGIN
	IF NEW.Etat="Termine" THEN
	UPDATE membre
    SET CompteTemps=CompteTemps+(select DureeEffective from transaction where NEW.Etat="Termine" AND OLD.Etat="en cours")
	WHERE CodeMembre=NEW.Membre_CodeMembre;
    UPDATE membre
    SET CompteTemps=CompteTemps-(select DureeEffective from transaction where NEW.Etat="Termine" AND OLD.Etat="en cours")
	WHERE CodeMembre=(select Membre_CodeMembre from proposition where idProposition=NEW.Proposition_idProposition);
    END IF;
END;
$$
```

# Question 2

### 2.1

Voici la fonction réalisée :

```sql
DELIMITER $$
CREATE FUNCTION `SERVICES_DURING_PERIOD`(`beginDate` DATE, `endDate` DATE)
RETURNS INT DETERMINISTIC
BEGIN
DECLARE hoursCounter INT;
IF beginDate < endDate THEN
SELECT SUM(DureeEffective) INTO hoursCounter FROM transaction WHERE DateRealisation IS NOT NULL AND DureeEffective IS NOT NULL AND(DateRealisation BETWEEN beginDate AND endDate);
ELSE
SELECT SUM(DureeEffective) INTO hoursCounter FROM transaction WHERE DateRealisation IS NOT NULL AND DureeEffective IS NOT NULL AND(DateRealisation BETWEEN endDate AND beginDate);
END IF;
return hoursCounter;
END;
$$
```


### 2.2


# Contributeurs

Réalisé par :
- Amandine Deraedt ([ama62nde](https://github.com/ama62nde))
- Corentin Destrez ([Lafie-rage](https://github.com/Lafie-rage))
