DROP TABLE Intrare_Ascensor        CASCADE CONSTRAINTS;
DROP TABLE Angajat_Ascensor        CASCADE CONSTRAINTS;
DROP TABLE Angajat_Eveniment       CASCADE CONSTRAINTS;
DROP TABLE Angajat_Cabana          CASCADE CONSTRAINTS;
DROP TABLE Angajat                 CASCADE CONSTRAINTS;
DROP TABLE Inchiriere              CASCADE CONSTRAINTS;
DROP TABLE Rezervare_Echipament    CASCADE CONSTRAINTS;
DROP TABLE Rezervare               CASCADE CONSTRAINTS;
DROP TABLE Rezervare_Camera        CASCADE CONSTRAINTS;
DROP TABLE Lectie_Schi             CASCADE CONSTRAINTS;
DROP TABLE Instructor              CASCADE CONSTRAINTS;
DROP TABLE Bilet                   CASCADE CONSTRAINTS;
DROP TABLE Eveniment               CASCADE CONSTRAINTS;
DROP TABLE Ascensor                CASCADE CONSTRAINTS;
DROP TABLE Abonament               CASCADE CONSTRAINTS;
DROP TABLE Schior                  CASCADE CONSTRAINTS;
DROP TABLE Echipament              CASCADE CONSTRAINTS;
DROP TABLE Tip_Calitate            CASCADE CONSTRAINTS;
DROP TABLE Camera                  CASCADE CONSTRAINTS;
DROP TABLE Cabana                  CASCADE CONSTRAINTS;
DROP TABLE Tip_Camera              CASCADE CONSTRAINTS;
DROP TABLE Partie                  CASCADE CONSTRAINTS;

-- =====================================================

DROP SEQUENCE seq_id_intrare;
DROP SEQUENCE seq_id_angajat_ascensor;
DROP SEQUENCE seq_id_angajat_eveniment;
DROP SEQUENCE seq_id_angajat_cabana;
DROP SEQUENCE seq_id_angajat;
DROP SEQUENCE seq_id_inchiriere;
DROP SEQUENCE seq_id_rezervare_echipament;
DROP SEQUENCE seq_id_rezervare;
DROP SEQUENCE seq_id_rezervare_camera;
DROP SEQUENCE seq_id_lectie;
DROP SEQUENCE seq_id_instructor;
DROP SEQUENCE seq_id_bilet;
DROP SEQUENCE seq_id_eveniment;
DROP SEQUENCE seq_id_ascensor;
DROP SEQUENCE seq_id_abonament;
DROP SEQUENCE seq_id_schior;
DROP SEQUENCE seq_id_echipament;
DROP SEQUENCE seq_id_tip_calitate;
DROP SEQUENCE seq_id_camera;
DROP SEQUENCE seq_id_cabana;
DROP SEQUENCE seq_id_tip_camera;
DROP SEQUENCE seq_id_partie;

--  Secvente de incrementare =====================================================

CREATE SEQUENCE seq_id_partie             START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_id_cabana             START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_id_camera             START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_id_tip_camera         START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_id_tip_calitate       START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_id_echipament         START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_id_schior             START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_id_abonament          START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_id_ascensor           START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_id_eveniment          START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_id_bilet              START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_id_instructor         START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_id_lectie             START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_id_rezervare_camera   START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_id_rezervare          START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_id_rezervare_echipament START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_id_inchiriere         START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_id_angajat            START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_id_angajat_cabana     START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_id_angajat_eveniment  START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_id_angajat_ascensor   START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_id_intrare            START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- Creearea Tabele =====================================================


CREATE TABLE Tip_Camera (
  id_tip_camera NUMBER DEFAULT seq_id_tip_camera.NEXTVAL PRIMARY KEY,
  denumire      VARCHAR2(50) NOT NULL,
  tarif_zi      DECIMAL(10,2) NOT NULL CHECK (tarif_zi > 0)
);

CREATE TABLE Ascensor (
  id_ascensor    NUMBER DEFAULT seq_id_ascensor.NEXTVAL PRIMARY KEY,
  denumire       VARCHAR2(100) NOT NULL,
  program_start  VARCHAR2(5) DEFAULT '07:30'
    CHECK (
      SUBSTR(program_start,3,1) = ':' 
      AND LENGTH(program_start) = 5
      AND TO_NUMBER(SUBSTR(program_start,1,2)) BETWEEN 0 AND 23
      AND TO_NUMBER(SUBSTR(program_start,4,2)) BETWEEN 0 AND 59
    ),
  program_end    VARCHAR2(5) DEFAULT '16:30'
    CHECK (
      SUBSTR(program_end,3,1) = ':' 
      AND LENGTH(program_end) = 5
      AND TO_NUMBER(SUBSTR(program_end,1,2)) BETWEEN 0 AND 23
      AND TO_NUMBER(SUBSTR(program_end,4,2)) BETWEEN 0 AND 59
    ),
  tip_ascensor   VARCHAR2(50),
  deschis        CHAR(1) DEFAULT 'N' CHECK (deschis IN ('Y','N'))
);


CREATE TABLE Partie (
  id_partie    NUMBER DEFAULT seq_id_partie.NEXTVAL PRIMARY KEY,
  denumire     VARCHAR2(100) NOT NULL,
  dificultate  VARCHAR2(50),
  lungime_km   NUMBER,
  desnivel_m   NUMBER,
  deschis      CHAR(1) DEFAULT 'N' CHECK (deschis IN ('Y','N')),
  id_ascensor         NUMBER NOT NULL,
  FOREIGN KEY (id_ascensor) REFERENCES Ascensor(id_ascensor)
);


CREATE TABLE Cabana (
  id_cabana   NUMBER DEFAULT seq_id_cabana.NEXTVAL PRIMARY KEY,
  nume        VARCHAR2(100) NOT NULL,
  locatie     VARCHAR2(255),
  id_partie   NUMBER NOT NULL,
  nr_camere   INTEGER NOT NULL CHECK (nr_camere >= 1),
  FOREIGN KEY (id_partie) REFERENCES Partie(id_partie)
);

CREATE TABLE Camera (
  id_camera       NUMBER DEFAULT seq_id_camera.NEXTVAL PRIMARY KEY,
  id_cabana       NUMBER NOT NULL,
  nr_paturi       INTEGER NOT NULL,
  capacitate_pers INTEGER,
  id_tip_camera   NUMBER NOT NULL,
  FOREIGN KEY (id_cabana)     REFERENCES Cabana(id_cabana),
  FOREIGN KEY (id_tip_camera) REFERENCES Tip_Camera(id_tip_camera)
);

CREATE TABLE Tip_Calitate (
  id_tip_calitate NUMBER DEFAULT seq_id_tip_calitate.NEXTVAL PRIMARY KEY,
  denumire        VARCHAR2(50) NOT NULL,
  garantie_ani    INTEGER DEFAULT 0 CHECK (garantie_ani >= 0)
);

CREATE TABLE Echipament (
  id_echipament   NUMBER DEFAULT seq_id_echipament.NEXTVAL PRIMARY KEY,
  id_tip_calitate NUMBER NOT NULL,
  denumire        VARCHAR2(100) NOT NULL,
  stoc_total      INTEGER NOT NULL CHECK (stoc_total >= 0),
  stoc_disponibil INTEGER NOT NULL CHECK (stoc_disponibil >= 0),
  FOREIGN KEY (id_tip_calitate) REFERENCES Tip_Calitate(id_tip_calitate)
);

CREATE TABLE Schior (
  id_schior        NUMBER DEFAULT seq_id_schior.NEXTVAL PRIMARY KEY,
  nume             VARCHAR2(100) NOT NULL,
  telefon          VARCHAR2(20),
  email            VARCHAR2(100) UNIQUE,
  nivel_experienta VARCHAR2(50),
  data_nasterii    DATE
);

ALTER TABLE Schior 
ADD CONSTRAINT nivel_experienta 
CHECK (nivel_experienta IN ('incepator', 'mediu', 'avansat'));





-- CREATE TABLE Schior (
--   id_schior        NUMBER DEFAULT seq_id_schior.NEXTVAL PRIMARY KEY,
--   nume             VARCHAR2(100) NOT NULL,
--   telefon          VARCHAR2(20),
--   email            VARCHAR2(100) UNIQUE,
--   nivel_experienta VARCHAR2(50),
--   data_nasterii    DATE,
--   CONSTRAINT nivel_experienta CHECK (nivel_experienta IN ('incepator', 'mediu', 'avansat'))
-- ); 

CREATE TABLE Abonament (
  id_abonament  NUMBER DEFAULT seq_id_abonament.NEXTVAL PRIMARY KEY,
  id_schior     NUMBER NOT NULL,
  data_emitere  DATE DEFAULT SYSDATE,
  data_expirare DATE,
  pret          DECIMAL(10,2) NOT NULL CHECK (pret > 0),
  FOREIGN KEY (id_schior) REFERENCES Schior(id_schior)
);



CREATE TABLE Eveniment (
  id_eveniment   NUMBER DEFAULT seq_id_eveniment.NEXTVAL PRIMARY KEY,
  nume           VARCHAR2(100) NOT NULL UNIQUE,
  data_eveniment DATE,
  id_cabana         NUMBER NOT NULL,
  FOREIGN KEY (id_cabana)  REFERENCES Cabana(id_cabana),
  capacitate_max INTEGER CHECK (capacitate_max >= 0)
);

CREATE TABLE Bilet (
  id_bilet       NUMBER DEFAULT seq_id_bilet.NEXTVAL PRIMARY KEY,
  id_schior      NUMBER NOT NULL,
  id_eveniment   NUMBER NOT NULL,
  data_emitere   DATE DEFAULT SYSDATE,
  pret           DECIMAL(10,2) NOT NULL CHECK (pret > 0),
  FOREIGN KEY (id_schior)    REFERENCES Schior(id_schior),
  FOREIGN KEY (id_eveniment) REFERENCES Eveniment(id_eveniment)
);

CREATE TABLE Instructor (
  id_instructor NUMBER DEFAULT seq_id_instructor.NEXTVAL PRIMARY KEY,
  nume          VARCHAR2(100) NOT NULL,
  specializare  VARCHAR2(100)
);

CREATE TABLE Lectie_Schi (
  id_lectie     NUMBER DEFAULT seq_id_lectie.NEXTVAL PRIMARY KEY,
  id_instructor NUMBER NOT NULL,
  id_schior     NUMBER NOT NULL,
  data_lectie   DATE,
  durata_ore    INTEGER CHECK (durata_ore > 0),
  FOREIGN KEY (id_instructor) REFERENCES Instructor(id_instructor),
  FOREIGN KEY (id_schior)     REFERENCES Schior(id_schior)
);

CREATE TABLE Rezervare_Camera (
  id_rezervare_camera NUMBER DEFAULT seq_id_rezervare_camera.NEXTVAL PRIMARY KEY,
  id_schior            NUMBER NOT NULL,
  data_sosire          DATE NOT NULL,
  durata_nopti         INTEGER NOT NULL CHECK (durata_nopti > 0),
  nr_camere            INTEGER NOT NULL CHECK (nr_camere > 0),
  tarif_total          DECIMAL(10,2) NOT NULL CHECK (tarif_total > 0),
  FOREIGN KEY (id_schior) REFERENCES Schior(id_schior)
);

CREATE TABLE Rezervare (
  id_rezervare         NUMBER DEFAULT seq_id_rezervare.NEXTVAL PRIMARY KEY,
  id_rezervare_camera  NUMBER NOT NULL,
  id_camera            NUMBER NOT NULL,
  data_sosire          DATE NOT NULL,
  durata_nopti         INTEGER NOT NULL CHECK (durata_nopti > 0),
  tarif_total          DECIMAL(10,2) NOT NULL CHECK (tarif_total > 0),
  FOREIGN KEY (id_rezervare_camera) REFERENCES Rezervare_Camera(id_rezervare_camera),
  FOREIGN KEY (id_camera)              REFERENCES Camera(id_camera)
);

CREATE TABLE Rezervare_Echipament (
  id_rezervare_echipament NUMBER DEFAULT seq_id_rezervare_echipament.NEXTVAL PRIMARY KEY,
  id_schior               NUMBER NOT NULL,
  data_inceput            DATE NOT NULL,
  data_final              DATE NOT NULL,
  numar_echipamente       INTEGER NOT NULL CHECK (numar_echipamente > 0),
  tarif_total             DECIMAL(10,2) NOT NULL CHECK (tarif_total > 0),
  FOREIGN KEY (id_schior) REFERENCES Schior(id_schior)
);

CREATE TABLE Inchiriere (
  id_inchiriere           NUMBER DEFAULT seq_id_inchiriere.NEXTVAL PRIMARY KEY,
  id_rezervare_echipament NUMBER NOT NULL,
  id_echipament           NUMBER NOT NULL,
  data_inceput            DATE NOT NULL,
  data_final              DATE NOT NULL,
  tarif_total             DECIMAL(10,2) NOT NULL CHECK (tarif_total > 0),
  observatii_optionale    VARCHAR2(255),
  FOREIGN KEY (id_rezervare_echipament) REFERENCES Rezervare_Echipament(id_rezervare_echipament),
  FOREIGN KEY (id_echipament)           REFERENCES Echipament(id_echipament)
);

CREATE TABLE Angajat (
  id_angajat NUMBER DEFAULT seq_id_angajat.NEXTVAL PRIMARY KEY,
  nume       VARCHAR2(100) NOT NULL,
  tip        VARCHAR2(50)
);

CREATE TABLE Angajat_Cabana (
  id_angajat_cabana NUMBER DEFAULT seq_id_angajat_cabana.NEXTVAL PRIMARY KEY,
  id_angajat        NUMBER NOT NULL,
  id_cabana         NUMBER NOT NULL,
  FOREIGN KEY (id_angajat) REFERENCES Angajat(id_angajat),
  FOREIGN KEY (id_cabana)  REFERENCES Cabana(id_cabana)
);

CREATE TABLE Angajat_Eveniment (
  id_angajat_eveniment NUMBER DEFAULT seq_id_angajat_eveniment.NEXTVAL PRIMARY KEY,
  id_angajat           NUMBER NOT NULL,
  id_eveniment         NUMBER NOT NULL,
  FOREIGN KEY (id_angajat)   REFERENCES Angajat(id_angajat),
  FOREIGN KEY (id_eveniment) REFERENCES Eveniment(id_eveniment)
);

CREATE TABLE Angajat_Ascensor (
  id_angajat_ascensor NUMBER DEFAULT seq_id_angajat_ascensor.NEXTVAL PRIMARY KEY,
  id_angajat          NUMBER NOT NULL,
  id_ascensor         NUMBER NOT NULL,
  FOREIGN KEY (id_angajat)  REFERENCES Angajat(id_angajat),
  FOREIGN KEY (id_ascensor) REFERENCES Ascensor(id_ascensor)
);

CREATE TABLE Intrare_Ascensor (
  id_intrare    NUMBER DEFAULT seq_id_intrare.NEXTVAL PRIMARY KEY,
  id_abonament  NUMBER NOT NULL,
  id_ascensor   NUMBER NOT NULL,
  data_intrare  DATE NOT NULL,
  FOREIGN KEY (id_abonament) REFERENCES Abonament(id_abonament),
  FOREIGN KEY (id_ascensor)  REFERENCES Ascensor(id_ascensor)
);


-- Inserari in Tabele =====================================================
 

INSERT INTO Tip_Camera (denumire, tarif_zi) VALUES ('Single', 120);
INSERT INTO Tip_Camera (denumire, tarif_zi) VALUES ('Double', 200);
INSERT INTO Tip_Camera (denumire, tarif_zi) VALUES ('Triple', 250);
INSERT INTO Tip_Camera (denumire, tarif_zi) VALUES ('Apartament', 350);
INSERT INTO Tip_Camera (denumire, tarif_zi) VALUES ('Family', 400);
INSERT INTO Tip_Camera (denumire, tarif_zi) VALUES ('Studio', 180);
INSERT INTO Tip_Camera (denumire, tarif_zi) VALUES ('Deluxe', 450);

INSERT INTO Tip_Calitate (denumire, garantie_ani) VALUES ('standard', 1);
INSERT INTO Tip_Calitate (denumire, garantie_ani) VALUES ('superior', 2);
INSERT INTO Tip_Calitate (denumire, garantie_ani) VALUES ('premium', 2);
INSERT INTO Tip_Calitate (denumire, garantie_ani) VALUES ('copii', 0);
INSERT INTO Tip_Calitate (denumire, garantie_ani) VALUES ('avansat', 3);
INSERT INTO Tip_Calitate (denumire, garantie_ani) VALUES ('junior', 1);

INSERT INTO Ascensor (denumire, program_start, program_end, tip_ascensor, deschis) VALUES ('Ascensor Nord', '07:30', '16:30', 'scaun', 'Y');
INSERT INTO Ascensor (denumire, program_start, program_end, tip_ascensor, deschis) VALUES ('Ascensor Sud', '07:30', '16:30', 'gondola', 'Y');
INSERT INTO Ascensor (denumire, program_start, program_end, tip_ascensor, deschis) VALUES ('Teleschi Valea', '07:30', '16:30', 'teleschi', 'N');
INSERT INTO Ascensor (denumire, program_start, program_end, tip_ascensor, deschis) VALUES ('Ascensor Central', '07:30', '16:30', 'scaun', 'Y');
INSERT INTO Ascensor (denumire, program_start, program_end, tip_ascensor, deschis) VALUES ('Gondola Junior', '07:30', '16:30', 'gondola', 'Y');
INSERT INTO Ascensor (denumire, program_start, program_end, tip_ascensor, deschis) VALUES ('Funicular Panorama', '07:30', '16:30', 'funicular', 'Y');

INSERT INTO Partie (denumire, dificultate, lungime_km, desnivel_m, deschis, id_ascensor) VALUES ('Pârtia Neagră', 'avansat', 2.5, 400, 'Y', 1);
INSERT INTO Partie (denumire, dificultate, lungime_km, desnivel_m, deschis, id_ascensor) VALUES ('Pârtia Albastră', 'incepator', 1.2, 150, 'Y', 2);
INSERT INTO Partie (denumire, dificultate, lungime_km, desnivel_m, deschis, id_ascensor) VALUES ('Pârtia Verde', 'incepator', 0.9, 100, 'N', 3);
INSERT INTO Partie (denumire, dificultate, lungime_km, desnivel_m, deschis, id_ascensor) VALUES ('Pârtia Lupului', 'intermediar', 2.0, 300, 'Y', 4);
INSERT INTO Partie (denumire, dificultate, lungime_km, desnivel_m, deschis, id_ascensor) VALUES ('Pârtia Copiilor', 'incepator', 0.5, 50, 'Y', 5);
INSERT INTO Partie (denumire, dificultate, lungime_km, desnivel_m, deschis, id_ascensor) VALUES ('Pârtia Panorama', 'avansat', 1.8, 250, 'Y', 6);

INSERT INTO Cabana (nume, locatie, id_partie, nr_camere) VALUES ('Cabana Alpin', 'Valea Prahovei', 1, 3);
INSERT INTO Cabana (nume, locatie, id_partie, nr_camere) VALUES ('Cabana Nordica', 'Valea Alba', 2, 4);
INSERT INTO Cabana (nume, locatie, id_partie, nr_camere) VALUES ('Cabana Junior', 'Valea Prahovei', 5, 5);
INSERT INTO Cabana (nume, locatie, id_partie, nr_camere) VALUES ('Cabana Lupului', 'Valea Verde', 4, 3);
INSERT INTO Cabana (nume, locatie, id_partie, nr_camere) VALUES ('Cabana Relax', 'Valea Verde', 3, 3);
INSERT INTO Cabana (nume, locatie, id_partie, nr_camere) VALUES ('Cabana Panorama', 'Valea Prahovei', 6, 6);

INSERT INTO Camera (id_cabana, nr_paturi, capacitate_pers, id_tip_camera) VALUES (1, 1, 1, 1);
INSERT INTO Camera (id_cabana, nr_paturi, capacitate_pers, id_tip_camera) VALUES (1, 3, 3, 3);
INSERT INTO Camera (id_cabana, nr_paturi, capacitate_pers, id_tip_camera) VALUES (1, 4, 4, 4);
INSERT INTO Camera (id_cabana, nr_paturi, capacitate_pers, id_tip_camera) VALUES (2, 2, 2, 2);
INSERT INTO Camera (id_cabana, nr_paturi, capacitate_pers, id_tip_camera) VALUES (2, 1, 2, 1);
INSERT INTO Camera (id_cabana, nr_paturi, capacitate_pers, id_tip_camera) VALUES (2, 3, 3, 3);
INSERT INTO Camera (id_cabana, nr_paturi, capacitate_pers, id_tip_camera) VALUES (2, 4, 4, 4);
INSERT INTO Camera (id_cabana, nr_paturi, capacitate_pers, id_tip_camera) VALUES (3, 1, 1, 1);
INSERT INTO Camera (id_cabana, nr_paturi, capacitate_pers, id_tip_camera) VALUES (3, 2, 2, 2);
INSERT INTO Camera (id_cabana, nr_paturi, capacitate_pers, id_tip_camera) VALUES (3, 3, 3, 3);
INSERT INTO Camera (id_cabana, nr_paturi, capacitate_pers, id_tip_camera) VALUES (3, 4, 4, 4);
INSERT INTO Camera (id_cabana, nr_paturi, capacitate_pers, id_tip_camera) VALUES (3, 4, 4, 5);
INSERT INTO Camera (id_cabana, nr_paturi, capacitate_pers, id_tip_camera) VALUES (4, 2, 3, 2);
INSERT INTO Camera (id_cabana, nr_paturi, capacitate_pers, id_tip_camera) VALUES (4, 4, 4, 4);
INSERT INTO Camera (id_cabana, nr_paturi, capacitate_pers, id_tip_camera) VALUES (4, 1, 2, 1);
INSERT INTO Camera (id_cabana, nr_paturi, capacitate_pers, id_tip_camera) VALUES (5, 2, 2, 2);
INSERT INTO Camera (id_cabana, nr_paturi, capacitate_pers, id_tip_camera) VALUES (5, 3, 3, 3);
INSERT INTO Camera (id_cabana, nr_paturi, capacitate_pers, id_tip_camera) VALUES (5, 4, 4, 5);
INSERT INTO Camera (id_cabana, nr_paturi, capacitate_pers, id_tip_camera) VALUES (6, 1, 1, 1);
INSERT INTO Camera (id_cabana, nr_paturi, capacitate_pers, id_tip_camera) VALUES (6, 2, 2, 2);

INSERT INTO Echipament (id_tip_calitate, denumire, stoc_total, stoc_disponibil) VALUES (1, 'Schiuri standard', 10, 7);
INSERT INTO Echipament (id_tip_calitate, denumire, stoc_total, stoc_disponibil) VALUES (2, 'Clăpari superior', 4, 2);
INSERT INTO Echipament (id_tip_calitate, denumire, stoc_total, stoc_disponibil) VALUES (3, 'Cască premium', 5, 4);
INSERT INTO Echipament (id_tip_calitate, denumire, stoc_total, stoc_disponibil) VALUES (4, 'Echipament copii', 12, 11);
INSERT INTO Echipament (id_tip_calitate, denumire, stoc_total, stoc_disponibil) VALUES (5, 'Bețe avansate', 7, 6);
INSERT INTO Echipament (id_tip_calitate, denumire, stoc_total, stoc_disponibil) VALUES (6, 'Schiuri junior', 5, 4);
INSERT INTO Echipament (id_tip_calitate, denumire, stoc_total, stoc_disponibil) VALUES (1, 'Clăpari standard', 6, 4);

INSERT INTO Schior (nume, telefon, email, nivel_experienta, data_nasterii) VALUES ('Popescu Ion', '0712345678', 'ion@exemplu.com', 'incepator', DATE '2001-02-15');
INSERT INTO Schior (nume, telefon, email, nivel_experienta, data_nasterii) VALUES ('Ionescu Maria', '0722233344', 'maria@exemplu.com', 'mediu', DATE '1995-06-10');
INSERT INTO Schior (nume, telefon, email, nivel_experienta, data_nasterii) VALUES ('Vasilescu Andrei', '0733123123', 'andrei@exemplu.com', 'avansat', DATE '1988-11-05');
INSERT INTO Schior (nume, telefon, email, nivel_experienta, data_nasterii) VALUES ('Dragomir Paul', '0744556677', 'paul@exemplu.com', 'incepator', DATE '2002-03-20');
INSERT INTO Schior (nume, telefon, email, nivel_experienta, data_nasterii) VALUES ('Stan Ana', '0755667788', 'ana@exemplu.com', 'mediu', DATE '1999-09-12');
INSERT INTO Schior (nume, telefon, email, nivel_experienta, data_nasterii) VALUES ('Matei Georgiana', '0721345678', 'georgiana@exemplu.com', 'incepator', DATE '2004-12-24');
INSERT INTO Schior (nume, telefon, email, nivel_experienta, data_nasterii) VALUES ('Baciu Rares', '0764123586', 'rares@exemplu.com', 'avansat', DATE '1997-05-07');
INSERT INTO Schior (nume, telefon, email, nivel_experienta, data_nasterii) VALUES ('Popa Elena', '0778234567', 'elena@exemplu.com', 'incepator', DATE '2003-08-30');
INSERT INTO Schior (nume, telefon, email, nivel_experienta, data_nasterii) VALUES ('Dumitrescu Radu', '0789345678', 'radu@exemplu.com', 'mediu', DATE '1996-04-18');


INSERT INTO Abonament (id_schior, data_emitere, data_expirare, pret) VALUES (1, DATE '2025-01-10', DATE '2025-01-20', 500);
INSERT INTO Abonament (id_schior, data_emitere, data_expirare, pret) VALUES (2, DATE '2025-01-15', DATE '2025-01-18', 200);
INSERT INTO Abonament (id_schior, data_emitere, data_expirare, pret) VALUES (3, DATE '2025-01-03', DATE '2025-02-28', 900);
INSERT INTO Abonament (id_schior, data_emitere, data_expirare, pret) VALUES (4, DATE '2025-01-20', DATE '2025-01-21', 300);
INSERT INTO Abonament (id_schior, data_emitere, data_expirare, pret) VALUES (5, DATE '2025-01-22', DATE '2025-02-01', 350);
INSERT INTO Abonament (id_schior, data_emitere, data_expirare, pret) VALUES (6, DATE '2025-01-28', DATE '2025-02-15', 250);
INSERT INTO Abonament (id_schior, data_emitere, data_expirare, pret) VALUES (7, DATE '2025-02-10', DATE '2025-02-21', 400);

INSERT INTO Eveniment (nume, data_eveniment, id_cabana, capacitate_max) VALUES ('Concurs copii', DATE '2025-02-05', 5, 40);
INSERT INTO Eveniment (nume, data_eveniment, id_cabana, capacitate_max) VALUES ('Apres-ski party', DATE '2025-01-25', 2, 60);
INSERT INTO Eveniment (nume, data_eveniment, id_cabana, capacitate_max) VALUES ('Seara gourmet', DATE '2025-01-30', 3, 30);
INSERT INTO Eveniment (nume, data_eveniment, id_cabana, capacitate_max) VALUES ('Lectii gratuite', DATE '2025-02-10', 3, 25);
INSERT INTO Eveniment (nume, data_eveniment, id_cabana, capacitate_max) VALUES ('Concurs avansati', DATE '2025-02-15', 5, 20);
INSERT INTO Eveniment (nume, data_eveniment, id_cabana, capacitate_max) VALUES ('Snowboard demo', DATE '2025-02-18', 6, 50);
INSERT INTO Eveniment (nume, data_eveniment, id_cabana, capacitate_max) VALUES ('Seara de film', DATE '2025-01-28', 4, 50);

INSERT INTO Instructor (nume, specializare) VALUES ('Gheorghe Mihai', 'freestyle');
INSERT INTO Instructor (nume, specializare) VALUES ('Dumitru Elena', 'alpin');
INSERT INTO Instructor (nume, specializare) VALUES ('Iacob Radu', 'snowboard');
INSERT INTO Instructor (nume, specializare) VALUES ('Sanda Mirela', 'copii');
INSERT INTO Instructor (nume, specializare) VALUES ('Popa Vlad', 'trasee dificile');
INSERT INTO Instructor (nume, specializare) VALUES ('Alexandru Luca', 'incepatori');

INSERT INTO Rezervare_Camera (id_schior, data_sosire, durata_nopti, nr_camere, tarif_total) VALUES (1, DATE '2025-01-12', 3, 2, 600);
INSERT INTO Rezervare_Camera (id_schior, data_sosire, durata_nopti, nr_camere, tarif_total) VALUES (2, DATE '2025-01-13', 4, 1, 800);
INSERT INTO Rezervare_Camera (id_schior, data_sosire, durata_nopti, nr_camere, tarif_total) VALUES (3, DATE '2025-01-15', 2, 3, 1200);
INSERT INTO Rezervare_Camera (id_schior, data_sosire, durata_nopti, nr_camere, tarif_total) VALUES (4, DATE '2025-01-20', 5, 1, 1250);
INSERT INTO Rezervare_Camera (id_schior, data_sosire, durata_nopti, nr_camere, tarif_total) VALUES (5, DATE '2025-01-22', 2, 2, 900);
INSERT INTO Rezervare_Camera (id_schior, data_sosire, durata_nopti, nr_camere, tarif_total) VALUES (6, DATE '2025-02-18', 2, 1, 300);

INSERT INTO Rezervare (id_rezervare_camera, id_camera, data_sosire, durata_nopti, tarif_total) VALUES (1, 1, DATE '2025-01-12', 3, 300);
INSERT INTO Rezervare (id_rezervare_camera, id_camera, data_sosire, durata_nopti, tarif_total) VALUES (1, 2, DATE '2025-01-12', 3, 300);
INSERT INTO Rezervare (id_rezervare_camera, id_camera, data_sosire, durata_nopti, tarif_total) VALUES (2, 3, DATE '2025-01-13', 4, 800);
INSERT INTO Rezervare (id_rezervare_camera, id_camera, data_sosire, durata_nopti, tarif_total) VALUES (3, 4, DATE '2025-01-15', 2, 400);
INSERT INTO Rezervare (id_rezervare_camera, id_camera, data_sosire, durata_nopti, tarif_total) VALUES (3, 5, DATE '2025-01-15', 2, 400);
INSERT INTO Rezervare (id_rezervare_camera, id_camera, data_sosire, durata_nopti, tarif_total) VALUES (3, 6, DATE '2025-01-15', 2, 400);
INSERT INTO Rezervare (id_rezervare_camera, id_camera, data_sosire, durata_nopti, tarif_total) VALUES (4, 7, DATE '2025-01-20', 5, 1250);
INSERT INTO Rezervare (id_rezervare_camera, id_camera, data_sosire, durata_nopti, tarif_total) VALUES (5, 8, DATE '2025-01-22', 2, 450);
INSERT INTO Rezervare (id_rezervare_camera, id_camera, data_sosire, durata_nopti, tarif_total) VALUES (5, 9, DATE '2025-01-22', 2, 450);
INSERT INTO Rezervare (id_rezervare_camera, id_camera, data_sosire, durata_nopti, tarif_total) VALUES (6, 10, DATE '2025-02-18', 2, 300);

INSERT INTO Rezervare_Echipament (id_schior, data_inceput, data_final, numar_echipamente, tarif_total) VALUES (1, DATE '2025-01-12', DATE '2025-01-14', 2, 200);
INSERT INTO Rezervare_Echipament (id_schior, data_inceput, data_final, numar_echipamente, tarif_total) VALUES (2, DATE '2025-01-13', DATE '2025-01-15', 1, 150);
INSERT INTO Rezervare_Echipament (id_schior, data_inceput, data_final, numar_echipamente, tarif_total) VALUES (3, DATE '2025-01-15', DATE '2025-01-18', 3, 270);
INSERT INTO Rezervare_Echipament (id_schior, data_inceput, data_final, numar_echipamente, tarif_total) VALUES (4, DATE '2025-01-20', DATE '2025-01-25', 2, 330);
INSERT INTO Rezervare_Echipament (id_schior, data_inceput, data_final, numar_echipamente, tarif_total) VALUES (5, DATE '2025-01-22', DATE '2025-01-24', 2, 200);
INSERT INTO Rezervare_Echipament (id_schior, data_inceput, data_final, numar_echipamente, tarif_total) VALUES (6, DATE '2025-02-20', DATE '2025-02-22', 1, 70);

INSERT INTO Inchiriere (id_rezervare_echipament, id_echipament, data_inceput, data_final, tarif_total, observatii_optionale) VALUES (1, 1, DATE '2025-01-12', DATE '2025-01-14', 110, 'Marime 42');
INSERT INTO Inchiriere (id_rezervare_echipament, id_echipament, data_inceput, data_final, tarif_total, observatii_optionale) VALUES (1, 7, DATE '2025-01-12', DATE '2025-01-14', 90, NULL);
INSERT INTO Inchiriere (id_rezervare_echipament, id_echipament, data_inceput, data_final, tarif_total, observatii_optionale) VALUES (2, 3, DATE '2025-01-13', DATE '2025-01-15', 150, 'Casca S');
INSERT INTO Inchiriere (id_rezervare_echipament, id_echipament, data_inceput, data_final, tarif_total, observatii_optionale) VALUES (3, 1, DATE '2025-01-15', DATE '2025-01-18', 90, 'Marime 44');
INSERT INTO Inchiriere (id_rezervare_echipament, id_echipament, data_inceput, data_final, tarif_total, observatii_optionale) VALUES (3, 2, DATE '2025-01-15', DATE '2025-01-18', 90, NULL);
INSERT INTO Inchiriere (id_rezervare_echipament, id_echipament, data_inceput, data_final, tarif_total, observatii_optionale) VALUES (3, 5, DATE '2025-01-15', DATE '2025-01-18', 90, 'Avansat');
INSERT INTO Inchiriere (id_rezervare_echipament, id_echipament, data_inceput, data_final, tarif_total, observatii_optionale) VALUES (4, 6, DATE '2025-01-20', DATE '2025-01-25', 160, 'Copil');
INSERT INTO Inchiriere (id_rezervare_echipament, id_echipament, data_inceput, data_final, tarif_total, observatii_optionale) VALUES (4, 7, DATE '2025-01-20', DATE '2025-01-25', 170, NULL);
INSERT INTO Inchiriere (id_rezervare_echipament, id_echipament, data_inceput, data_final, tarif_total, observatii_optionale) VALUES (5, 4, DATE '2025-01-22', DATE '2025-01-24', 100, 'Copil');
INSERT INTO Inchiriere (id_rezervare_echipament, id_echipament, data_inceput, data_final, tarif_total, observatii_optionale) VALUES (5, 3, DATE '2025-01-22', DATE '2025-01-24', 100, 'Casca M');
INSERT INTO Inchiriere (id_rezervare_echipament, id_echipament, data_inceput, data_final, tarif_total, observatii_optionale)  VALUES (6, 2, DATE '2025-02-20', DATE '2025-02-22', 70, NULL);

INSERT INTO Angajat (nume, tip) VALUES ('Enache Raluca', 'cabana');
INSERT INTO Angajat (nume, tip) VALUES ('Barbu George', 'cabana');
INSERT INTO Angajat (nume, tip) VALUES ('Ciobanu Mihai', 'cabana');
INSERT INTO Angajat (nume, tip) VALUES ('Badea Adriana', 'cabana');
INSERT INTO Angajat (nume, tip) VALUES ('Neagu Tudor', 'cabana');
INSERT INTO Angajat (nume, tip) VALUES ('Iacob Sorin', 'cabana');
INSERT INTO Angajat (nume, tip) VALUES ('Ilie Carmen', 'eveniment');
INSERT INTO Angajat (nume, tip) VALUES ('Dobre Simona', 'eveniment');
INSERT INTO Angajat (nume, tip) VALUES ('Petrescu Mihai', 'eveniment');
INSERT INTO Angajat (nume, tip) VALUES ('Popescu Mara', 'eveniment');
INSERT INTO Angajat (nume, tip) VALUES ('Andrei Vlad', 'eveniment');
INSERT INTO Angajat (nume, tip) VALUES ('Stan Cristina', 'eveniment');
INSERT INTO Angajat (nume, tip) VALUES ('Baciu Paul', 'ascensor');
INSERT INTO Angajat (nume, tip) VALUES ('Matei Elena', 'ascensor');
INSERT INTO Angajat (nume, tip) VALUES ('Vasilescu Emil', 'ascensor');
INSERT INTO Angajat (nume, tip) VALUES ('Munteanu Alex', 'ascensor');
INSERT INTO Angajat (nume, tip) VALUES ('Marin Raluca', 'ascensor');
INSERT INTO Angajat (nume, tip) VALUES ('Pop Vlad', 'ascensor');
INSERT INTO Angajat (nume, tip) VALUES ('Ionescu Andreea', 'eveniment');
INSERT INTO Angajat (nume, tip) VALUES ('Dumitrescu Radu', 'eveniment');
INSERT INTO Angajat (nume, tip) VALUES ('Popescu Maria', 'eveniment');

INSERT INTO Angajat_Eveniment (id_angajat, id_eveniment) VALUES (7, 1);
INSERT INTO Angajat_Eveniment (id_angajat, id_eveniment) VALUES (8, 2);
INSERT INTO Angajat_Eveniment (id_angajat, id_eveniment) VALUES (9, 3);
INSERT INTO Angajat_Eveniment (id_angajat, id_eveniment) VALUES (10, 4);
INSERT INTO Angajat_Eveniment (id_angajat, id_eveniment) VALUES (11, 5);
INSERT INTO Angajat_Eveniment (id_angajat, id_eveniment) VALUES (12, 6);
INSERT INTO Angajat_Eveniment (id_angajat, id_eveniment) VALUES (19, 7);
INSERT INTO Angajat_Eveniment (id_angajat, id_eveniment) VALUES (20, 1);
INSERT INTO Angajat_Eveniment (id_angajat, id_eveniment) VALUES (21, 7);


INSERT INTO Angajat_Ascensor (id_angajat, id_ascensor) VALUES (13, 1);
INSERT INTO Angajat_Ascensor (id_angajat, id_ascensor) VALUES (14, 2);
INSERT INTO Angajat_Ascensor (id_angajat, id_ascensor) VALUES (15, 3);
INSERT INTO Angajat_Ascensor (id_angajat, id_ascensor) VALUES (16, 4);
INSERT INTO Angajat_Ascensor (id_angajat, id_ascensor) VALUES (17, 5);
INSERT INTO Angajat_Ascensor (id_angajat, id_ascensor) VALUES (18, 6);

INSERT INTO Angajat_Cabana (id_angajat, id_cabana) VALUES (1, 1);
INSERT INTO Angajat_Cabana (id_angajat, id_cabana) VALUES (2, 2);
INSERT INTO Angajat_Cabana (id_angajat, id_cabana) VALUES (3, 3);
INSERT INTO Angajat_Cabana (id_angajat, id_cabana) VALUES (4, 4);
INSERT INTO Angajat_Cabana (id_angajat, id_cabana) VALUES (5, 5);
INSERT INTO Angajat_Cabana (id_angajat, id_cabana) VALUES (6, 6);

INSERT INTO Intrare_Ascensor (id_abonament, id_ascensor, data_intrare) VALUES (1, 1, TO_DATE('2025-01-11 08:00','YYYY-MM-DD HH24:MI'));
INSERT INTO Intrare_Ascensor (id_abonament, id_ascensor, data_intrare) VALUES (2, 2, TO_DATE('2025-01-16 09:00','YYYY-MM-DD HH24:MI'));
INSERT INTO Intrare_Ascensor (id_abonament, id_ascensor, data_intrare) VALUES (3, 3, TO_DATE('2025-02-02 10:15','YYYY-MM-DD HH24:MI'));
INSERT INTO Intrare_Ascensor (id_abonament, id_ascensor, data_intrare) VALUES (4, 4, TO_DATE('2025-01-21 11:40','YYYY-MM-DD HH24:MI'));
INSERT INTO Intrare_Ascensor (id_abonament, id_ascensor, data_intrare) VALUES (5, 5, TO_DATE('2025-01-23 14:00','YYYY-MM-DD HH24:MI'));
INSERT INTO Intrare_Ascensor (id_abonament, id_ascensor, data_intrare) VALUES (6, 6, TO_DATE('2025-01-29 08:30','YYYY-MM-DD HH24:MI'));
INSERT INTO Intrare_Ascensor (id_abonament, id_ascensor, data_intrare) VALUES (7, 1, TO_DATE('2025-02-12 12:10','YYYY-MM-DD HH24:MI'));
INSERT INTO Intrare_Ascensor (id_abonament, id_ascensor, data_intrare) VALUES (1, 2, TO_DATE('2025-01-12 13:00','YYYY-MM-DD HH24:MI'));
INSERT INTO Intrare_Ascensor (id_abonament, id_ascensor, data_intrare) VALUES (2, 3, TO_DATE('2025-01-17 13:55','YYYY-MM-DD HH24:MI'));
INSERT INTO Intrare_Ascensor (id_abonament, id_ascensor, data_intrare) VALUES (3, 4, TO_DATE('2025-02-04 15:20','YYYY-MM-DD HH24:MI'));
INSERT INTO Intrare_Ascensor (id_abonament, id_ascensor, data_intrare) VALUES (4, 5, TO_DATE('2025-01-22 10:25','YYYY-MM-DD HH24:MI'));
INSERT INTO Intrare_Ascensor (id_abonament, id_ascensor, data_intrare) VALUES (5, 6, TO_DATE('2025-01-25 11:45','YYYY-MM-DD HH24:MI'));

INSERT INTO Bilet (id_schior, id_eveniment, data_emitere, pret) VALUES (1, 1, DATE '2025-01-25', 100);
INSERT INTO Bilet (id_schior, id_eveniment, data_emitere, pret) VALUES (2, 2, DATE '2025-01-20', 150);
INSERT INTO Bilet (id_schior, id_eveniment, data_emitere, pret) VALUES (3, 3, DATE '2025-01-30', 120);
INSERT INTO Bilet (id_schior, id_eveniment, data_emitere, pret) VALUES (4, 4, DATE '2025-02-05', 80);
INSERT INTO Bilet (id_schior, id_eveniment, data_emitere, pret) VALUES (5, 5, DATE '2025-02-15', 90);
INSERT INTO Bilet (id_schior, id_eveniment, data_emitere, pret) VALUES (6, 6, DATE '2025-02-18', 70);
INSERT INTO Bilet (id_schior, id_eveniment, data_emitere, pret) VALUES (7, 1, DATE '2025-02-05', 95);
INSERT INTO Bilet (id_schior, id_eveniment, data_emitere, pret) VALUES (1, 3, DATE '2025-01-30', 120);
INSERT INTO Bilet (id_schior, id_eveniment, data_emitere, pret) VALUES (2, 5, DATE '2025-02-15', 90);
INSERT INTO Bilet (id_schior, id_eveniment, data_emitere, pret) VALUES (3, 2, DATE '2025-01-20', 150);

INSERT INTO Lectie_Schi (id_instructor, id_schior, data_lectie, durata_ore) VALUES (1, 1, TO_DATE('2025-01-12 10:00','YYYY-MM-DD HH24:MI'), 2);
INSERT INTO Lectie_Schi (id_instructor, id_schior, data_lectie, durata_ore) VALUES (2, 1, TO_DATE('2025-01-13 11:00','YYYY-MM-DD HH24:MI'), 2);
INSERT INTO Lectie_Schi (id_instructor, id_schior, data_lectie, durata_ore) VALUES (3, 3, TO_DATE('2025-01-15 12:00','YYYY-MM-DD HH24:MI'), 1);
INSERT INTO Lectie_Schi (id_instructor, id_schior, data_lectie, durata_ore) VALUES (4, 6, TO_DATE('2025-01-20 13:00','YYYY-MM-DD HH24:MI'), 2);
INSERT INTO Lectie_Schi (id_instructor, id_schior, data_lectie, durata_ore) VALUES (5, 5, TO_DATE('2025-01-22 14:00','YYYY-MM-DD HH24:MI'), 1);
INSERT INTO Lectie_Schi (id_instructor, id_schior, data_lectie, durata_ore) VALUES (3, 4, TO_DATE('2025-01-28 09:00','YYYY-MM-DD HH24:MI'), 2);
INSERT INTO Lectie_Schi (id_instructor, id_schior, data_lectie, durata_ore) VALUES (1, 1, TO_DATE('2025-02-05 10:00','YYYY-MM-DD HH24:MI'), 2);
INSERT INTO Lectie_Schi (id_instructor, id_schior, data_lectie, durata_ore) VALUES (4, 3, TO_DATE('2025-02-07 11:00','YYYY-MM-DD HH24:MI'), 1);
INSERT INTO Lectie_Schi (id_instructor, id_schior, data_lectie, durata_ore) VALUES (3, 4, TO_DATE('2025-02-10 12:00','YYYY-MM-DD HH24:MI'), 2);
INSERT INTO Lectie_Schi (id_instructor, id_schior, data_lectie, durata_ore) VALUES (4, 3, TO_DATE('2025-02-14 13:00','YYYY-MM-DD HH24:MI'), 1);
INSERT INTO Lectie_Schi (id_instructor, id_schior, data_lectie, durata_ore) VALUES (5, 1, TO_DATE('2025-02-17 15:00','YYYY-MM-DD HH24:MI'), 1);
INSERT INTO Lectie_Schi (id_instructor, id_schior, data_lectie, durata_ore) VALUES (4, 1, TO_DATE('2025-02-19 10:00','YYYY-MM-DD HH24:MI'), 2);

COMMIT;