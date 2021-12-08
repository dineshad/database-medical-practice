--Create MedicalPractice database
--Create tables with  column names,types,sizes,required(not null) and primary key as per the given DB design.
--Add foreign key constraints and alternate keys as per the given DB design.

CREATE DATABASE MedicalPractice;
GO
USE MedicalPractice;
GO
-- Create Patient table.
CREATE TABLE Patient
(
    Patient_ID INT NOT NULL, 
    Title NVARCHAR(200),
    FirstName NVARCHAR(50) NOT NULL,
    MiddleInitial NCHAR(1),
    LastName NVARCHAR(50) NOT NULL,
    HouseUnitLotNum NVARCHAR(5) NOT NULL,
    Street NVARCHAR(50) NOT NULL,
    Suburb NVARCHAR(50) NOT NULL,
    State NVARCHAR(3) NOT NULL,
    PostCode NCHAR(4) NOT NULL,
    HomePhone NCHAR(10),
    MobilePhone NCHAR(10),
    MedicareNumber NCHAR(16),
    DateOfBirth DATE NOT NULL,
    Gender NCHAR(20) NOT NULL,
    CONSTRAINT Patient_Pk PRIMARY KEY (Patient_ID)
);
GO
-- Create Practitioner table.
CREATE TABLE Practitioner
(
    Practitioner_ID INT NOT NULL,
    MedicalRegistrationNumber NCHAR(11) NOT NULL,
    Title NVARCHAR(200),
    FirstName NVARCHAR(50) NOT NULL,
    MiddleInitial NCHAR(1),
    LastName NVARCHAR(50) NOT NULL,
    HouseUnitLotNum NVARCHAR(5) NOT NULL,
    Street NVARCHAR(50) NOT NULL,
    Suburb NVARCHAR(50) NOT NULL,
    State NVARCHAR(3) NOT NULL,
    PostCode NCHAR(4) NOT NULL,
    HomePhone NCHAR(8),
    MobilePhone NCHAR(10),
    MedicareNumber NCHAR(16),
    DateOfBirth DATE NOT NULL,
    Gender NCHAR(20) NOT NULL,
    PractitionerType_Ref NVARCHAR(50) NOT NULL,
    CONSTRAINT Practitioner_Pk PRIMARY KEY (Practitioner_ID)
)
GO
--Create Availability table. 
CREATE TABLE Availability (
    WeekDayName_Ref NVARCHAR(9) NOT NULL,
    Practitioner_Ref INT NOT NULL,
    CONSTRAINT Availability_pk PRIMARY KEY(WeekDayName_Ref,Practitioner_Ref)
)
GO
--Create WeekDays table.
CREATE TABLE WeekDays(
    WeekDayName NVARCHAR(9) NOT NULL,
   CONSTRAINT WeekDays_Pk PRIMARY KEY(WeekDayName)
)
GO
--Create PractitionerType table.
CREATE TABLE PractitionerType(
    PractitionerType NVARCHAR(50) NOT NULL 
    CONSTRAINT PractitionerType_Pk PRIMARY KEY(PractitionerType)
)
GO
--Create Appointment table.
CREATE TABLE Appointment(
    Practitioner_Ref INTEGER NOT NULL,
    AppDate DATE NOT NULL,
    AppStartTime TIME NOT NULL,
    Patient_Ref INTEGER NOT NULL
    CONSTRAINT Appointment_pk PRIMARY KEY (Practitioner_Ref,AppDate,AppStartTime)
)
--Create PathTestReqs table.
CREATE TABLE PathTestReqs(
    Practitioner_Ref INTEGER NOT NULL,
    DateOrdered DATE,
    TimeOrdered TIME,
    Patient_Ref INTEGER,
    Test_Ref NVARCHAR(20),
    CONSTRAINT PathTestReqs_pk PRIMARY KEY (Practitioner_Ref,DateOrdered,TimeOrdered)
)
GO
--Create TestType table.
CREATE TABLE TestType(
    Test_Code NVARCHAR(20) NOT NULL,
    TestName NVARCHAR(200) NOT NULL,
    Description NVARCHAR(500),
    CONSTRAINT TestType_Pk PRIMARY KEY (Test_Code)
)
GO
-----------------------------------------------Alter tables to add  foreign key contraints.------------------------------------------------------------------------
--PractitionerType_Ref column of Practitioner table refrences PractitionerType column of PractitionerType table.
ALTER TABLE Practitioner ADD CONSTRAINT Practitioner_Ref_PractitionerType 
FOREIGN KEY(PractitionerType_Ref) REFERENCES  PractitionerType(PractitionerType);
GO
-- WeekDayName_Ref column of Availability table references WeekDayName column  of WeekDays table.
ALTER TABLE Availability  ADD CONSTRAINT   Availability_Ref_WeekDays    
FOREIGN KEY(WeekDayName_Ref) REFERENCES WeekDays (WeekDayName);
GO
-- Practitioner_Ref column of  Availability table references  Practitioner_Id column of Practitioner table.
ALTER TABLE Availability  ADD CONSTRAINT   Availability_Ref_Practitioner    
FOREIGN KEY(Practitioner_Ref) REFERENCES Practitioner(Practitioner_Id);
GO
-- Practitioner_Ref column of Appointment table references Practitioner_Id column of Practitioner table.
ALTER TABLE Appointment  ADD CONSTRAINT   Appointment_Ref_Practitioner
FOREIGN KEY(Practitioner_Ref) REFERENCES Practitioner(Practitioner_Id);
GO
-- Patient_Ref column of Appointment table references Patient_Id column of Patient table.
ALTER TABLE Appointment  ADD CONSTRAINT   Appointment_Ref_Patient
FOREIGN KEY(Patient_Ref) REFERENCES Patient(Patient_Id);
GO
-- Practitioner_Ref column of PathTestReqs references Practitioner_Id column of Practitioner table.
ALTER TABLE PathTestReqs  ADD CONSTRAINT  PathTestReqs_Ref_Practitioner
FOREIGN KEY(Practitioner_Ref) REFERENCES Practitioner(Practitioner_Id);
GO
-- Patient_Ref  column of PathTestReqs references Patient_Id column of Patient table.
ALTER TABLE PathTestReqs  ADD CONSTRAINT  PathTestReqs_Ref_Patient
FOREIGN KEY(Patient_Ref) REFERENCES Patient(Patient_ID);
GO
-- Test_Ref column of PathTestReqs references Test_Code column of TestType table
ALTER TABLE PathTestReqs  ADD CONSTRAINT  PathTestReqst_Ref_TestType
FOREIGN KEY(Test_Ref) REFERENCES TestType(Test_Code);
GO
----------------------------Adding Alternate Keys as unique non-clustered indexes to the tables-----------------------------------------------
-- MedicalRegistrationNumber is an alternate key for Practitioner table.
CREATE UNIQUE NONCLUSTERED INDEX Practitioner_idx ON Practitioner(MedicalRegistrationNumber);
GO
-- Combination of Patient_Ref,AppDate,AppStartTime is an alternate key for Appointment table.
CREATE UNIQUE NONCLUSTERED INDEX Appointment_idx ON Appointment(Patient_Ref,AppDate,AppStartTime)




