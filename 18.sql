
SET TRANSACTION READ ONLY;

-- Prima citire prinde snapshot‐ul inițial
SELECT COUNT(*) AS cnt
  FROM Rezervare_Camera
 WHERE id_schior = 3;

-- Menținem tranzacţia deschisă şi facem alte SELECT-uri
SELECT tarif_total
  FROM Rezervare_Camera
 WHERE id_rezervare_camera = 1;

-- Revenim în sesiunea T1 şi refacem SELECT-urile
SELECT COUNT(*) AS cnt
  FROM Rezervare_Camera
 WHERE id_schior = 3;

COMMIT;


-- pornește implicit sub Read Committed
--  Prima citire ia valoarea comisă curentă
SELECT tarif_total
  FROM Rezervare_Camera
 WHERE id_rezervare_camera = 1;

-- modifică și COMMIT
UPDATE Rezervare_Camera
   SET tarif_total = 600
 WHERE id_rezervare_camera = 1;
COMMIT;

-- A doua citire reflectă noul tarif
SELECT tarif_total
  FROM Rezervare_Camera
 WHERE id_rezervare_camera = 1;

COMMIT;


--  pornește sub Serializabil
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- Primele SELECT-uri prind snapshot-ul inițial
SELECT COUNT(*) AS cnt
  FROM Rezervare_Camera
 WHERE id_schior = 3;

--  sub Read Committed, inserează și COMITĂ
INSERT INTO Rezervare_Camera
       (id_schior, data_sosire, durata_nopti, nr_camere, tarif_total)
VALUES (3, DATE '2025-07-01', 2, 1, 300);
COMMIT;

--  A doua citire în T1 folosește același snapshot
SELECT COUNT(*) AS cnt
  FROM Rezervare_Camera
 WHERE id_schior = 3;

COMMIT;
