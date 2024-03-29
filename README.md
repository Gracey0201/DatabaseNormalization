# Database Normalization Assignment

## Part 1: Introduction
Database Normalization is a methodical strategy for arranging data within a database with the aim of minimizing repetition and enhancing data integrity.

### Purpose
This assignment is to guide through the process of creating and normalizing a relational database up to the first and second normal forms (1NF and 2NF) using PostgreSQL with the PostGIS extension.This can further be broken down as follow;
-To avoid duplicate data.
-To reduce the complexity of the database.
-To ensure relationships between tables are consistent.
-To make it easier to maintain and update the database.

*italic*.Grasping and putting into practice the principles of 1NF and 2NF is essential when crafting databases that are both efficient and dependable. Making sure every table follows forms of normalization steers clear of typical problems with data integrity and establish a strong base for one’s database systems.*italic*.

### Importance of 1NF
-Guarantees that each data element is easily accessible and can be queried efficiently.
-Avoids storing multiple values in a single cell, simplifying the data structure, and reducing complexity.

### Importance of 2NF
-Removes redundancy arising from data stored in tables with composite primary keys that don't necessitate all key components.
-Secures that each piece of information is singularly stored, diminishing the likelihood of inconsistencies.

### Code Block used for this assignment.
`CREATE EXTENSION postgis;`
_This including this query at the start of sql script helps to set up one’s database to work with spatial data through the PostGIS extension_.

`Create a Park_Info table
CREATE TABLE Parks_Info (    --  How to create a table
    ID SERIAL PRIMARY KEY,   -- SERIAL = datatype for unique ID (it indicates that it is being controlled the database)
    ParkName VARCHAR(255),   -- VARCHAR = datatype, useful for names, descriptions etc
    Facilities VARCHAR(255)  -- VARCHAR =  datatype, useful for names, descriptions etc
);`
_This query was used for creating a Park_Info table_.

`INSERT INTO Parks_Info (ParkName, Facilities) VALUES
('Central Park', 'Playground, Restroom, Picnic area'),
('Liberty Park', 'Restroom, Picnic area'),
('Riverside Park', 'Playground, Bike Path');`
_Query for manually inserting data into Parks_Info table_.

_The folowing queries are used to normalize to 1NF_
`CREATE TABLE Parks (        --  How to create a table
    ParkID INT PRIMARY KEY,  -- INTEGER, type o datatype (using INT the data doesnot generate automatically)
    ParkName VARCHAR(255)   -- VARCHAR =  datatype, useful for names, descriptions etc
);`
_Query to create parks table _.

`CREATE TABLE Facilities (           --  How to create a table
    FacilityID SERIAL PRIMARY KEY,  -- SERIAL = datatype for unique ID (It autogenerates)
    ParkID INT,                     -- INTEGER, type o datatype
    FacilityName VARCHAR(255),      -- VARCHAR =  datatype, useful for names, descriptions etc.
    FOREIGN KEY (ParkID) REFERENCES Parks(ParkID)
);`
_Query for creating Facilities table_.

`INSERT INTO Parks (ParkName)
SELECT DISTINCT ParkName FROM Parks_Info`
_Query for inserting data into Parks table (This autogenerates)_.

`INSERT INTO Parks (ParkID, ParkName) VALUES
(1, 'Central Park'),
(2, 'Liberty Park'),
(3, 'Riverside Park');`
_This is an alternative way of inserting data manually into Parks table_.

`SELECT DISTINCT ID, Facilities FROM Parks_Info;`
_Query for inserting data into Facilities table _.

`INSERT INTO Facilities (ParkID, FacilityName) VALUES
(1, 'Playground'),
(1, 'Restroom'),
(1, 'Pinic area'),
(2, 'Restroom'),
(2, 'Pinic area'),
(3, 'Playground'),
(3, 'Bike Path');`
_This is an alternative way of inserting data manually into Facilities table _.

_The folowing queries are used to advance 2NF_.
 `CREATE TABLE ParkFacilities (
    FacilityID SERIAL PRIMARY KEY,
    FacilityName VARCHAR(255)
);`
_This query is used to createa a ParkFacilities table_.

`INSERT INTO ParkFacilities (FacilityName)
SELECT DISTINCT FacilityName FROM Facilities`
_Query for inserting data into ParkFacilities Table_.

_Modify the ‘Facilities’ table to include a reference to ‘ParkFacilities_
`ALTER TABLE Facilities ADD COLUMN ParkFacilityID INT;`
_This query helps to add a new column ‘ParkFacilityID’ to link to ‘ParkFacilities’_.

_Update the ‘Facilities’ table to set the new ‘ParkFacilityID’ column_
`UPDATE Facilities
SET ParkFacilityID = (SELECT FacilityID FROM ParkFacilities WHERE FacilityName = Facilities.FacilityName);`
_This Query updates the Facilities table by adding a column called facilityID_.

_Cleanup redundant columns_
`ALTER TABLE Facilities DROP COLUMN FacilityName;;`
_This query changes the facilities table by dropping the FacilityName column_.


### Uploading Images
![This is the screenshot of Park_Info table](Images/Park_Info_Table.PNG)
![This is the screenshot of Parks table](Images/Parks_Table.PNG)
![This is the screenshot of facilities table](Images/Facility_Altered.PNG)
![This is the screenshot of Parkfacilites table](Images/ParkFacilities_Table.PNG)
![This is the screenshot of Facilites table](Images/Facilities_Table.PNG)

### Challenges Encountered
_I encountered some technical complexities, trying to get and write the right query, this is because understanding and implementing spatial concepts may be challenging especially for someone like me who is new to this domain_.
 
_Also, adhering to normalization rules, especially in the context of spatial tables, also presented some challenges to me, trying to ensure that each table satisfies the requirements of 1NF and 2NF added an additional layer of complexity to my work_.

### Solutions
_To over these challenges, I focused on understanding and solving one aspect of the assignment at a time, this made the overall task less overwhelming. Also the session with the professor on Monday during class was really helpful in putting me on the right track_.

_Most importantly, I did not hesitate to ask for help from the Teaching assistant, Kunal. He was really helpful in explaining things to me, he provided valuable insights to specific challenges that were stalling my work_.


## Conclusion
This assignment stresses on the significance of database normalization, especially focusing on achieving the first and second normal forms (1NF and 2NF) using PostgreSQL with the PostGIS extension. It also underscores the understanding of normalization concepts, reducing data redundancy, and enhancing data integrity. By applying normalization rules. Lastly, this exercise highlights the essence of structuring databases in a way that not only ensures data accuracy and consistency but also facilitates efficient spatial data management.





