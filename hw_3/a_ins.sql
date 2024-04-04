--HW3a1
/*One male, one female*/
INSERT INTO Ancestry VALUES(1004, 1002);
INSERT INTO Ancestry VALUES(1004, 1003);
/*Younger parent*/
INSERT INTO Ancestry VALUES(1001, 1005);
--------------------------

--HW3a2
/*Update ancestry age */
UPDATE Specimen SET BirthDate='02/02/2015' WHERE EID = 1003;
--------------------------
