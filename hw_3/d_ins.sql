


--HW3d1
/*One male, one female*/
INSERT INTO Ancestry VALUES(1004, 1002);
INSERT INTO Ancestry VALUES(1004, 1003);
/*Two females*/
INSERT INTO Ancestry VALUES(1001, 1004);
INSERT INTO Ancestry VALUES(1001, 1002);
--------------------------

--HW3d2
/*Update male specimen to female or NULL*/
UPDATE Specimen SET Gender='F' WHERE EID = 1003;
--------------------------

--HW3d3
/*Update male specimen to female or NULL*/
UPDATE Specimen SET Gender=NULL WHERE EID = 1003;
--------------------------
