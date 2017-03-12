SET search_path = PARTYDB;

DROP SCHEMA IF EXISTS PARTYDB CASCADE;
CREATE SCHEMA PARTYDB;


-- DROP DOMAIN IF EXISTS PARTYDB.SexType;
-- DROP TABLE IF EXISTS PARTYDB.Room;
-- DROP TABLE IF EXISTS PARTYDB.Hotel;
-- DROP TABLE IF EXISTS PARTYDB.Guest;
-- DROP TABLE IF EXISTS PARTYDB.Booking;


CREATE DOMAIN niveau as VARCHAR(10) check
(value in ('recreatif', 'competitif'));




CREATE TABLE IF NOT EXISTS PARTYDB.Employe(
		idEmploye		VARCHAR(10)		NOT NULL,
		prenom	  	VARCHAR(10)		NOT NULL,
		nom 	VARCHAR(10)			NOT NULL,
		role		VARCHAR(10)		NOT	NULL,
		PRIMARY KEY (idEmploye)
		);

CREATE TABLE IF NOT EXISTS PARTYDB.Joueur(
		idJoueur		VARCHAR(10)		NOT NULL,
		prenom	  	VARCHAR(10)		NOT NULL,
		nom VARCHAR(10)  NOT NULL,
		courriel 	VARCHAR(10)			NOT NULL,
		tel VARCHAR(10)  ,
		idEmploye VARCHAR(10) ,
		PRIMARY KEY (idJoueur),
		FOREIGN KEY (idEmploye) REFERENCES PARTYDB.Employe(idEmploye)
		);






CREATE TABLE IF NOT EXISTS PARTYDB.sport(
		idSport		VARCHAR(10)		NOT NULL,
		nom	  	VARCHAR(10)		NOT NULL,
		description	  	VARCHAR(10)		NOT NULL,
		PRIMARY KEY (idSport)
		);

CREATE TABLE IF NOT EXISTS PARTYDB.Ligue(
		idLigue		VARCHAR(10)		NOT NULL,
		sport	  	VARCHAR(10)		NOT NULL,
		difficulte 	niveau			NOT NULL,
		idSport VARCHAR(10)	NOT NULL,
		PRIMARY KEY (idLigue)
		FK: idSport REFERENCES PARTYDB.sport(idSport)
		);

CREATE TABLE IF NOT EXISTS PARTYDB.Saison(
idSaison		VARCHAR(10)		NOT NULL,
dateLimitePaiement		date	NOT NULL,
dateDebut 	date	 		NOT NULL,
dateFin		date			not NULL,
nbreMatch	integer		NOT NULL,
idLigue		VARCHAR(10) NOT NULL, 
PRIMARY KEY (idSaison),
FOREIGN KEY (idLigue) REFERENCES Ligue(idLigue)
);

CREATE TABLE IF NOT EXISTS PARTYDB.TournoiCharite(
		idTournoi		VARCHAR(10)		NOT NULL,
		oeuvre	  	VARCHAR(10)		NOT NULL,
		fonds 	integer(10)			NOT NULL,
		dateDebut		DATE		NOT	NULL,
		dateFin		date		NOT NULL,
		idSport VARCHAR(10),
		PRIMARY KEY (idTournoi),
		FOREIGN KEY (idsport) REFERENCES PARTYDB.sport(idSport) 
		);


CREATE TABLE IF NOT EXISTS  PARTYDB.Match (
		idMatch		VARCHAR(10)		NOT NULL,
		ddate 	DATE		NOT NULL,
		heure		time		NOT NULL,
		lieu	VARCHAR(10)		NOT NULL, 
		idSaison VARCHAR(10) NOT NULL,
		idTournoi VARCHAR(10) NOT NULL, 
		PRIMARY KEY (idMatch),
		FOREIGN KEY (idSaison) REFERENCES PARTYDB.Saison(idSaison),
		FOREIGN KEY (idTournoi) REFERENCES PARTYDB.TournoiCharite(idTournoi)
		);

CREATE TABLE IF NOT EXISTS PARTYDB.Arbitre(
		idArbitre		VARCHAR(10)		NOT NULL,
		idEmploye	  	VARCHAR(10)		NOT NULL,
		idMatch 	VARCHAR(10)			NOT NULL,

		PRIMARY KEY (idArbitre),
		FOREIGN KEY (idEmploye) REFERENCES PARTYDB.Employe(idEmploye),
		FOREIGN KEY (idMatch) REFERENCES PARTYDB.Match(idMatch) 
		);


CREATE TABLE IF NOT EXISTS PARTYDB.GerantEquipe(
		idgerantEqu		VARCHAR(10)		NOT NULL,
		idJoueur	  	VARCHAR(10)		NOT NULL,
		Diplome 	VARCHAR(10) NOT NULL,
		PRIMARY KEY (idgerantEqu),
		FOREIGN KEY (idJoueur) REFERENCES PARTYDB.Joueur(idJoueur)
		);



CREATE TABLE IF NOT EXISTS PARTYDB.Equipe(
		idEquipe		VARCHAR(10)		NOT NULL,
		nom	  	VARCHAR(10)		NOT NULL,
		idLigue	  	VARCHAR(10)		NOT NULL,
		idMatch	  	VARCHAR(10)		NOT NULL,
		idgerantEqu	  	VARCHAR(10)		NOT NULL,
		idTournoi	  	VARCHAR(10)		NOT NULL,
		datePaiement	 date		NOT NULL,
		derNumCarte Numeric(4) not NULL,
		maxJoueur integer NOT NULL,
		minJoueur integer NOT NULL,
		PRIMARY KEY (idEquipe),
		FOREIGN KEY (idLigue) REFERENCES PARTYDB.Ligue(idLigue),
		FOREIGN KEY (idMatch) REFERENCES PARTYDB.Match(idMatch),
		FOREIGN KEY (idgerantEqu) REFERENCES PARTYDB.GerantEquipe(idgerantEqu),
		FOREIGN KEY (idTournoi) REFERENCES PARTYDB.TournoiCharite(idTournoi)
		);


CREATE TABLE IF NOT EXISTS PARTYDB.JoueurEquipe(
		idEquipe VARCHAR(10) NOT NULL,
		idJoueur VARCHAR(10) NOT NULL,
		PRIMARY KEY (idJoueur, idEquipe),
		FOREIGN KEY (idEquipe) REFERENCES PARTYDB.Equipe(idEquipe),
		FOREIGN KEY (idJoueur) REFERENCES PARTYDB.Joueur(idJoueur)		
		);



CREATE TABLE IF NOT EXISTS PARTYDB.Commanditaire(
idCommandit VARCHAR(10) NOT NULL, 
nom VARCHAR(10)	NOT NULL,
tel VARCHAR(10)	NOT NULL,
contribution integer NOT NULL, 
idTournoi VARCHAR(10) not NULL, 
PRIMARY KEY (idCommandit),
FOREIGN KEY(idTournoi) REFERENCES PARTYDB.TournoiCharite(idTournoi));


	


CREATE TABLE IF NOT EXISTS PARTYDB.GestionnaireLigue(
		idgestionnaire		VARCHAR(10)		NOT NULL,
		tel	  	VARCHAR(10)		NOT NULL,
		idLigue VARCHAR(10)  NOT NULL,
		idEmploye 	VARCHAR(10)			NOT NULL,
		PRIMARY KEY (idgestionnaire),
		FOREIGN KEY (idLigue) REFERENCES PARTYDB.Ligue(idLigue),
		FOREIGN KEY (idEmploye) REFERENCES PARTYDB.Employe(idEmploye),
		);



CREATE TABLE IF NOT EXISTS PARTYDB.joueurSportPrefere(
		idJoueur		VARCHAR(10)		NOT NULL,
		idSport	  	VARCHAR(10)		NOT NULL,
		PRIMARY KEY (idJoueur, idSport),
		FOREIGN KEY (idJoueur) REFERENCES PARTYDB.Joueur(idJoueur),
		FOREIGN KEY (idSport) REFERENCES PARTYDB.sport(idSport)
		);




CREATE TABLE IF NOT EXISTS PARTYDB.ArbitreSportPrefere(
		idArbitre		VARCHAR(10)		NOT NULL,
		idSport	  	VARCHAR(10)		NOT NULL,
		PRIMARY KEY (idArbitre, idSport),
		FOREIGN KEY (idArbitre) REFERENCES PARTYDB.Arbitre(idArbitre),
		FOREIGN KEY (idSport) REFERENCES PARTYDB.sport(idSport)
		);
