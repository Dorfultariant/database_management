
--HW3b1
INSERT INTO AnimalSpecies VALUES(2, 'Tropical elephant', 'A', 35.5, 'tropical', 1, 3, 100.0);
INSERT INTO AnimalSpecies VALUES(3, 'Elephant', 'A', 35.5, ' temperate, tropical', 1, 3, 100.0);
/*Correct habitat*/
INSERT INTO Specimen VALUES(1007, 3, 101, 'Dumbo', '01/03/2016', 'F', 30.0, 100.0);
/*Incorrect habitat*/
INSERT INTO Specimen VALUES(1006, 2, 104, 'Dumbont', '01/03/2016', 'F', 30.0, 100.0);
--------------------------

--HW3b2
/*Temperature warning*/
UPDATE Habitat SET Temperature = 42 WHERE HID =104;
INSERT INTO Specimen VALUES(1008, 3, 104, 'Dumbo', '01/03/2016', 'F', 30.0, 100.0);
--------------------------

--HW3b3
/*Too high temperature when putting to habitat*/
UPDATE Habitat SET Temperature = 45 WHERE HID =103;
INSERT INTO Specimen VALUES(1009, 3, 103, 'Dumbo', '01/03/2016', 'F', 30.0, 100.0);
--------------------------


--HW3b4
/*Update habitat to "kill animals"*/
UPDATE Habitat SET Temperature = 45 WHERE HID =101;
--------------------------
