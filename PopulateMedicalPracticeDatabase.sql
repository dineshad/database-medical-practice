-- Bulk Insert data into Patient table from the given csv.
BULK INSERT Patient
FROM "/pathFromHome/TAFE/Database/assessmentDatabase/Part3/dataFiles/patient.csv"
WITH
(
FIRSTROW =2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n',
FORMAT = 'CSV'
)
GO
-- Bulk Insert data into Practitioner table from the given csv.
BULK INSERT Practitioner
FROM "/pathFromHome/TAFE/Database/assessmentDatabase/Part3/dataFiles/practitioner.csv"
WITH
(
FIRSTROW =2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n',
FORMAT = 'CSV'
);
GO
-- Bulk Insert data into PractitionerType table from the given csv.
BULK INSERT PractitionerType
FROM "/pathFromHome/TAFE/Database/assessmentDatabase/Part3/dataFiles/practitionertype.csv"
WITH
(
FIRSTROW =2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n',
FORMAT = 'CSV'
);
GO
-- Bulk Insert data into WeekDays table from the given csv.
BULK INSERT WeekDays
FROM "/pathFromHome/TAFE/Database/assessmentDatabase/Part3/dataFiles/weekday.csv"
WITH
(
FIRSTROW =2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n',
FORMAT = 'CSV'
);
GO
-- Bulk Insert data into TestType table from the given csv.
BULK INSERT TestType
FROM "/pathFromHome/TAFE/Database/assessmentDatabase/Part3/dataFiles/testtype.csv"
WITH
(
FIRSTROW =2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n',
FORMAT = 'CSV'
);
GO
-- Bulk Insert data into Appointment table from the given csv.
BULK INSERT Appointment
FROM "/pathFromHome/TAFE/Database/assessmentDatabase/Part3/dataFiles/appointment.csv"
WITH
(
FIRSTROW =2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n',
FORMAT = 'CSV'
);
GO
-- Bulk Insert data into PathTestReqs table from the given csv.
BULK INSERT PathTestReqs
FROM "/pathFromHome/TAFE/Database/assessmentDatabase/Part3/dataFiles/pathtestreqs.csv"
WITH
(
FIRSTROW =2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n',
FORMAT = 'CSV'
);
GO
-- Bulk Insert data into Availability table from the given csv.
BULK INSERT Availability
FROM "/pathFromHome/TAFE/Database/assessmentDatabase/Part3/dataFiles/availability.csv"
WITH
(
FIRSTROW =2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n',
FORMAT = 'CSV'
);
GO


