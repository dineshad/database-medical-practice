-- List the the first name and last name of female patients 
-- who live in St Kilda or Lidcombe.
SELECT FirstName,LastName FROM Patient 
WHERE Gender LIKE 'female%' AND ( Suburb LIKE '%St Kilda%' OR Suburb LIKE '%Lidcombe%')
-- Caroline	Barrette
-- Wendy	Pilington
----------------------------------------------------------------------------------------------------------
-- List the first name, last name, state and Medicare Number 
-- of any patients who do not live in NSW.
SELECT FirstName,LastName,State FROM Patient
WHERE State <> 'NSW'
-- FirstName	LastName	State
-- Caroline	Barrette	VIC
------------------------------------------------------------------------------------------------------------
-- For patients who have had pathology test requests, 
-- list the practitioner's and patient's first and last names, 
-- the date and time that the pathology tests were ordered 
-- and the name of the pathology test.
SELECT p.FirstName AS PatientFirstName ,p.LastName AS PatientLastName ,
       pr.FirstName AS PractitionerFirstName, pr.LastName As PractitionerFirstName,
       ptr.DateOrdered, ptr.TimeOrdered, tt.TestName      
FROM Patient p,PathTestReqs ptr,Practitioner pr,TestType tt   
WHERE p.Patient_ID = ptr.Patient_Ref  
      AND ptr.Practitioner_Ref = pr.Practitioner_ID 
      AND ptr.Test_Ref = tt.Test_Code
-- PatientFirstName	PatientLastName	PractitionerFirstName	PractitionerFirstName	DateOrdered	TimeOrdered	TestName
-- Wendy	Pilington	Ludo	Vergenargen	2019-09-17	10:30:00	ABO
-- Joan	Wothers	Ludo	Vergenargen	2019-09-18	08:15:00	Radioallergosorbent Test
-- Mackenzie	Fleetwood	Anne	Funsworth	2019-09-18	10:30:00	ABO
-- Wendy	Pilington	Adam	Moody	2019-09-18	08:15:00	Paraneoplastic   
------------------------------------------------------------------------------------------------------------
-- List the Patient's first name, last name and the appointment date and time, 
-- for all appointments held on the 18/09/2019 by Dr Anne Funsworth.
SELECT p.FirstName AS PatientFirstName ,p.LastName AS PatientLastName, 
a.AppDate,a.AppStartTime
FROM Patient p, Appointment a,Practitioner pr
WHERE p.Patient_ID = a.Patient_Ref
AND a.Practitioner_Ref = pr.Practitioner_ID
AND a.AppDate= '2019-09-18' AND pr.Title='Dr' AND pr.FirstName = 'Anne' AND pr.LastName='Funsworth'
-- PatientFirstName	PatientLastName	AppDate	AppStartTime
-- Wendy	Pilington	2019-09-18	09:30:00
-- Mackenzie	Fleetwood	2019-09-18	10:00:00
-- Mackenzie	Fleetwood	2019-09-18	10:15:00
-- Mackenzie	Fleetwood	2019-09-18	10:30:00
-- Mackenzie	Fleetwood	2019-09-18	10:45:00
-- Mackenzie	Fleetwood	2019-09-18	11:00:00
-----------------------------------------------------------------------------------------------------
-- List each Patient's first name, last name, Medicare Number and their date of birth. 
-- Sort the list by date of birth, listing the youngest patients first.
SELECT p.FirstName AS PatientFirstName ,p.LastName AS PatientLastName,p.MedicareNumber,p.DateOfBirth
FROM Patient p ORDER BY p.DateOfBirth DESC
-- Adrian	Tamerkand	9863652527637332	2008-12-12
-- Terrence	Hill	6363525353535356	2005-10-04
-- Mackenzie	Fleetwood	7253418356478253	2000-03-12
-- Joan	Wothers	9484746125364765	1997-06-12
-- Wendy	Pilington	8483727616273838	1985-09-17
-- John	Ward	4738294848484838	1978-02-12
-- Mary	Brown	9356273321176546	1972-03-05
-- Phill	Greggan	6473645782345678	1971-08-31
-- Caroline	Barrette	1234565725463728	1965-04-04
-- Peter	Leons	1873652945578932	1962-07-08
-- Jane	Killingsworth	9365243640183640	1943-04-08
-----------------------------------------------------------------------------------------------------------
-- For each pathology test request, list the test code, the test name the date and time 
-- that the test was ordered. 
-- Sort the results by the date the test was ordered and then by the time that it was ordered.
SELECT ptr.Test_Ref AS TestCode,tt.TestName, ptr.DateOrdered, ptr.TimeOrdered
FROM PathTestReqs ptr, TestType tt
WHERE ptr.Test_Ref = tt.Test_Code
ORDER BY ptr.DateOrdered, ptr.TimeOrdered
-- TestCode	TestName	DateOrdered	TimeOrdered
-- HLYSN	ABO	2019-09-17	10:30:00
-- RAST	Radioallergosorbent Test	2019-09-18	08:15:00
-- IMISC	Paraneoplastic	2019-09-18	08:15:00
-- HLYSN	ABO	2019-09-18	10:30:00
---------------------------------------------------------------------------------------------
-- List the ID and date of birth of any patient 
-- who has not had an appointment and was born before 1950.
SELECT p.Patient_ID,p.DateOfBirth 
FROM  Patient p
WHERE p.Patient_ID NOT IN (SELECT a.Patient_Ref FROM Appointment a)
AND p.DateOfBirth < '1950-01-01'
-- Patient_ID	DateOfBirth
-- 10001	1943-04-08
------------------------------------------------------------------------------------------------------
-- List the patient ID, last name and date of birth of all male patients 
-- born between 1962 and 1973 (inclusive).
SELECT p.Patient_ID,p.LastName,p.DateOfBirth
FROM  Patient p
WHERE p.Gender LIKE '%male%'
AND p.DateOfBirth BETWEEN  '1962-01-01' AND '1973-12-31'
-- Patient_ID	LastName	DateOfBirth
-- 10002	Leons	1962-07-08
-- 10003	Greggan	1971-08-31
-- 10005	Brown	1972-03-05
-- 10009	Barrette	1965-04-04
--------------------------------------------------------------------------------------------------------
-- List the patient ID, first name and last name of any male patients 
-- who have had appointments with either Dr Huston or Dr Vergenargen.
SELECT p.Patient_ID,p.FirstName,p.LastName,pr.LastName AS PractionerLastname
FROM  Patient p,Practitioner pr 
WHERE p.Gender LIKE '%male%'
AND ( pr.LastName LIKE '%Huston%' OR pr.LastName LIKE '%Vergenargen%')
AND pr.Title = 'Dr'
-- Patient_ID	FirstName	LastName	PractionerLastname
-- 10000	Mackenzie	Fleetwood	Huston
-- 10001	Jane	Killingsworth	Huston
-- 10002	Peter	Leons	Huston
-- 10003	Phill	Greggan	Huston
-- 10004	John	Ward	Huston
-- 10005	Mary	Brown	Huston
-- 10006	Terrence	Hill	Huston
-- 10007	Adrian	Tamerkand	Huston
-- 10008	Joan	Wothers	Huston
-- 10009	Caroline	Barrette	Huston
-- 10010	Wendy	Pilington	Huston
-- 10000	Mackenzie	Fleetwood	Vergenargen
-- 10001	Jane	Killingsworth	Vergenargen
-- 10002	Peter	Leons	Vergenargen
-- 10003	Phill	Greggan	Vergenargen
-- 10004	John	Ward	Vergenargen
-- 10005	Mary	Brown	Vergenargen
-- 10006	Terrence	Hill	Vergenargen
-- 10007	Adrian	Tamerkand	Vergenargen
-- 10008	Joan	Wothers	Vergenargen
-- 10009	Caroline	Barrette	Vergenargen
-- 10010	Wendy	Pilington	Vergenargen
-----------------------------------------------------------------------------------------------------------
-- List the practitioner ID, first name, last name and practitioner type of each practitioner, 
-- and the number of days of the week that they're available.
SELECT a.Practitioner_Ref, pr.FirstName,pr.LastName,pr.PractitionerType_Ref,COUNT(a.WeekDayName_Ref) AS NumberOfDaysAvailable
FROM Practitioner pr,Availability a
WHERE pr.Practitioner_ID = a.Practitioner_Ref
GROUP BY a.Practitioner_Ref, pr.FirstName,pr.LastName,pr.PractitionerType_Ref
-- Practitioner_Ref	FirstName	LastName	PractitionerType_Ref	NumberOfDaysAvailable
-- 10000	Mark	Huston	Medical Practitioner (Doctor or GP)	3
-- 10001	Hilda	Brown	Registered nurse	2
-- 10002	Jennifer	Dunsworth	Registered nurse	2
-- 10003	Jason	Lithdon	nurse	3
-- 10004	Paula	Yates	Midwife	2
-- 10005	Ludo	Vergenargen	Medical Practitioner (Doctor or GP)	2
-- 10006	Anne	Funsworth	Psychologist	1
-- 10007	Leslie	Gray	Podiatrist	2
-- 10008	Adam	Moody	Medical practitioner (Doctor or GP)	3
----------------------------------------------------------------------------------------------------------
-- List the patient ID, first name, last name and the number of appointments 
-- for patients who have had at least three appointments.
SELECT p.Patient_ID,p.FirstName,p.LastName,COUNT(*) AS NumberOfAppointments
FROM Patient p, Appointment a
WHERE p.Patient_ID = a.Patient_Ref
GROUP BY p.Patient_ID,p.FirstName,p.LastName
HAVING COUNT(*) > 3
-- Patient_ID	FirstName	LastName	NumberOfAppointments
-- 10000	Mackenzie	Fleetwood	6
-- 10010	Wendy	Pilington	4
-----------------------------------------------------------------------------------------------------------
-- List the first name, last name, gender, and the number of days since 
-- the last appointment of each patient and the 23/09/2019.
SELECT p.FirstName,p.LastName,p.Gender, DATEDIFF(day,MAX(a.AppDate),'2019-09-23') AS DaysFromlastAppointmentTo23Oct2019
FROM Patient p,Appointment a
WHERE p.Patient_ID = a.Patient_Ref
GROUP BY a.Patient_Ref,p.FirstName,p.LastName,p.Gender
-- FirstName	LastName	Gender	DaysFromlastAppointmentTo23Oct2019
-- Mackenzie	Fleetwood	male               	5
-- Peter	Leons	male               	6
-- Phill	Greggan	male               	5
-- Mary	Brown	female             	5
-- Terrence	Hill	male               	5
-- Joan	Wothers	female             	5
-- Caroline	Barrette	female             	6
-- Wendy	Pilington	female             	5
---------------------------------------------------------------------------------------------------------------------------
-- For each practitioner, list their ID, first name, last name and the total number of hours 
-- worked each week at the Medical Practice. 
-- Assume a nine-hour working day and that practitioners work the full nine 
-- hours on each day that they're available.
SELECT pr.Practitioner_ID, pr.FirstName,pr.LastName, (9 * COUNT(a.WeekDayName_Ref)) AS HoursWorkedForWeek
FROM Practitioner pr,Availability a
WHERE pr.Practitioner_ID = a.Practitioner_Ref
GROUP BY pr.Practitioner_ID, pr.FirstName,pr.LastName
-- Practitioner_ID	FirstName	LastName	HoursWorkedForWeek
-- 10000	Mark	Huston	27
-- 10001	Hilda	Brown	18
-- 10002	Jennifer	Dunsworth	18
-- 10003	Jason	Lithdon	27
-- 10004	Paula	Yates	18
-- 10005	Ludo	Vergenargen	18
-- 10006	Anne	Funsworth	9
-- 10007	Leslie	Gray	18
-- 10008	Adam	Moody	27
-----------------------------------------------------------------------------------------------------------
-- List the full name and full address of each practitioner in the following format exactly.
-- Dr Mark P. Huston. 21 Fuller Street SUNSHINE, NSW 2343
-- Make sure you include the punctuation and the suburb in upper case.
SELECT pr.Title + SPACE(1) + pr.FirstName+ SPACE(1) + pr.MiddleInitial+ SPACE(1) + pr.LastName + '.' + SPACE(1)
+ pr.HouseUnitLotNum+ SPACE(1) + pr.Street+ SPACE(1)+UPPER(pr.Suburb) + ','+ SPACE(1)
 + pr.[State]+ SPACE(1) +  pr.PostCode AS PractitionerDetails
FROM Practitioner pr
-- PractitionerDetails
-- Dr Mark P Huston. 21 Fuller Street SUNSHINE, NSW 2343
-- Mrs Hilda D Brown. 32 Argyle Street BONNELS BAY, NSW 2264
-- Mrs Jennifer J Dunsworth. 45 Dora Street MORRISET, NSW 2264
-- Mr Jason D Lithdon. 43 Fowler Street CAMPERDOWN, NSW 2050
-- Ms Paula D Yates. 89 Tableton Road NEWTOWN, NSW 2051
-- Dr Ludo V Vergenargen. 27 Pembleton Place REDFERN, NSW 2049
-- Dr Anne D Funsworth. 4/89 Pacific Highway ST LEONARDS, NSW 2984
-- Mrs Leslie V Gray. 98 Dandaraga Road MIRRABOOKA, NSW 2264
-- Dr Adam J Moody. 35 Mullabinga Way BRIGHTWATERS, NSW 2264
-- Mr Leslie Y Gray. 3 Dorwington Place ENMORE, NSW 2048
----------------------------------------------------------------------------------------------------------
-- List the date of birth of the male practitioner named Leslie Gray 
-- in the following format exactly:Saturday, 11 March 1989
SELECT FORMAT (pr.DateOfBirth, 'D')
FROM Practitioner pr
WHERE pr.FirstName LIKE '%Leslie%' AND pr.LastName LIKE '%Gray%' AND pr.Gender='male'
-- (No column name)
-- Thursday, April 11, 1991
----------------------------------------------------------------------------------------------------------
-- List the patient id, first name, last name 
-- and date of birth of the fifth oldest patient(s).
DECLARE @N INT;
SET @N=5;
SELECT DISTINCT p.Patient_ID,p.FirstName,p.LastName,p.DateOfBirth
FROM Patient p
ORDER BY p.DateOfBirth DESC
OFFSET @N ROW
FETCH NEXT 1 ROW ONLY;
-- Patient_ID	FirstName	LastName	DateOfBirth
-- 10004	John	Ward	1978-02-12
-----------------------------------------------------------------------------------------------------------
-- Calculate and list the number of hours and minutes between Joan Wothers
-- ' 8:00 AM appointment on 17/09/2019 and Terrence Hill's 2:15 PM 
-- appointment on that same day with Dr Ludo Vergenargen. Format the result in the 
-- following format:5 hrs 35 mins 
SELECT CAST(DATEDIFF(minute,'2019/09/17 08:00','2019/09/17 14:15')/60 AS VARCHAR)
+ ' hrs ' + CAST(DATEDIFF(minute,'2019/09/17 08:00','2019/09/17 14:15')%60 AS VARCHAR)  + ' mins'
-- (No column name)
-- 6 hrs 15 mins
----------------------------------------------------------------------------------------------------------
-- List the age difference in years between the youngest patient and the oldest patient 
-- in the following format:The age difference between our oldest and our youngest patient is 76 years.
SELECT 'The age difference between our oldest and our youngest patient is ' 
+ CAST(DATEDIFF(year,MIN(p.DateOfBirth),MAX(p.DateOfBirth)) AS varchar)  + ' years.'
FROM Patient p
-- (No column name)
-- The age difference between our oldest and our youngest patient is 65years.

-- Following information was required to make estimations in Excel
SELECT MIN(p.DateOfBirth)
FROM Patient p
SELECT MAX(p.DateOfBirth)
FROM Patient p