CREATE EXTENSION postgis;

-- Query for creating a Park_Info table
Create a Park_Info table
CREATE TABLE Parks_Info (    --  How to create a table
    ID SERIAL PRIMARY KEY,   -- SERIAL = datatype for unique ID (it indicates that it is being controlled the database)
    ParkName VARCHAR(255),   -- VARCHAR = datatype, useful for names, descriptions etc
    Facilities VARCHAR(255)  -- VARCHAR =  datatype, useful for names, descriptions etc
);

-- Query for inserting data into Parks_Info table
INSERT INTO Parks_Info (ParkName, Facilities) VALUES
('Central Park', 'Playground, Restroom, Picnic area'),
('Liberty Park', 'Restroom, Picnic area'),
('Riverside Park', 'Playground, Bike Path');

-- Normalize to 1NF:
--Create a new table ‘Parks’ to store information about parks with a more normalized structure.
CREATE TABLE Parks (        --  How to create a table
    ParkID INT PRIMARY KEY, -- INTEGER, type o datatype (using INT the data doesnot generate automatically)
    ParkName VARCHAR(255)   -- VARCHAR =  datatype, useful for names, descriptions etc
);

--Create a 'Facilities' table to separately store facilities available in each park.
-- Query for creating Facilities table
CREATE TABLE Facilities (           --  How to create a table
    FacilityID SERIAL PRIMARY KEY,  -- SERIAL = datatype for unique ID (It autogenerates)
    ParkID INT,                     -- INTEGER, type o datatype
    FacilityName VARCHAR(255),      -- VARCHAR =  datatype, useful for names, descriptions etc.
    FOREIGN KEY (ParkID) REFERENCES Parks(ParkID)
);

--Insert data into the Parks table
-- Query for inserting data into Parks table (This autogenerates)
INSERT INTO Parks (ParkName)
SELECT DISTINCT ParkName FROM Parks_Info


-- Query for inserting data into Parks table 
--This is an alternative way of inserting data manually into Parks table
INSERT INTO Parks (ParkID, ParkName) VALUES
(1, 'Central Park'),
(2, 'Liberty Park'),
(3, 'Riverside Park');

--Insert Data Into the Facilities Table:
--Query for inserting data into Facilities table 
SELECT DISTINCT ID, Facilities FROM Parks_Info;

-- Query for inserting data into Facilities table 
--This is an alternative way of inserting data manually into Facilities table 
INSERT INTO Facilities (ParkID, FacilityName) VALUES
(1, 'Playground'),
(1, 'Restroom'),
(1, 'Pinic area'),
(2, 'Restroom'),
(2, 'Pinic area'),
(3, 'Playground'),
(3, 'Bike Path');
 
--Advancing to 2NF
--Create a 'ParkFacilities' table
--This query is used to createa a ParkFacilities table
CREATE TABLE ParkFacilities (
    FacilityID SERIAL PRIMARY KEY,
    FacilityName VARCHAR(255)
);

--Insert Data Into the ParkFacilities Table:
--Query for inserting data into ParkFacilities Table
INSERT INTO ParkFacilities (FacilityName)
SELECT DISTINCT FacilityName FROM Facilities



--Modify the ‘Facilities’ table to include a reference to ‘ParkFacilities’.
--This query helps to add a new column ‘ParkFacilityID’ to link to ‘ParkFacilities’.
ALTER TABLE Facilities ADD COLUMN ParkFacilityID INT;

--Update the ‘Facilities’ table to set the new ‘ParkFacilityID’ column.
--This query sets a foreign key on the ParkFacilityID column, with references ParkFacilities table but particularly the FacilityID column. 
ALTER TABLE Facilities
ADD CONSTRAINT fk_parkfacilityid FOREIGN KEY (ParkFacilityID) REFERENCES ParkFacilities(FacilityID);

--Removing redundant ‘FacilityName’ column from ‘Facilities’, since the relationship is maintained via ‘FacilityID’.
--Then, add a foreign key constraint to ‘Facilities’ to enforce the relationship between ‘Facilities’ and ‘ParkFacilities’.
--This Query updates the Facilities table by adding a column called facilityID
UPDATE Facilities
SET ParkFacilityID = (SELECT FacilityID FROM ParkFacilities WHERE FacilityName = Facilities.FacilityName);

-- Cleanup redundant columns
--This query changes the facilities table by dropping the FacilityName column
ALTER TABLE Facilities DROP COLUMN FacilityName;;

SHOW TABLES;
-- This query helps to reproduce the original data by including other data like the facilityName to the facilities table
SELECT	ParkName, FacilityName
FROM	Facilities AS fc
		INNER JOIN ParkFacilities AS pf ON fc.ParkFacilitiyID = pf.FacilityID
		INNER JOIN Parks AS pk ON fc.ParkID = pk.ParkID

