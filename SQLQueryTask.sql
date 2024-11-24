INSERT INTO DEPARTMENT VALUES 
(3,'Sales',NULL,NULL),
(4,'Marketing',NULL,NULL),
(5,'Production',NULL,NULL),
(6,'Customer Service',NULL,NULL),
(7,'Engineering',NULL,NULL),
(8,'Training',NULL,NULL),
(9,'Entertainment',NULL,NULL),
(10,'PR',NULL,NULL)

INSERT INTO EMPLOYEE VALUES 
(103, 'Hassan', 'A', 'Ezz', '1985-08-22', '456 Oak St', 'M', 2500.00, 101, 9),
(104, 'Sara', 'M', 'Oraby', '1985-08-22', '456 Oak St', 'F', 2500.00, 103, 9),
(105, 'Omnia', 'A', 'Fathy', '1985-08-22', '456 Oak St', 'F', 2500.00, NULL, 8),
(106, 'Mohamed', 'L', 'Abdelrahamn', '1985-08-22', '456 Oak St', 'M', 2500.00, 101, 10),
(107, 'Rowida', 'M', 'Hassan', '1985-08-22', '456 Oak St', 'F', 2500.00, 104, 10),
(108, 'Kamel', 'R', 'Mohamed', '1985-08-22', '456 Oak St', 'M', 2500.00, NULL, 2),
(109, 'Asmaa', 'S', 'Mostafa', '1985-08-22', '456 Oak St', 'F', 2500.00, 106, 3),
(110, 'Ahmed', 'K', 'Doe', '1985-08-22', '456 Oak St', 'M', 2500.00, NULL, 3)

UPDATE DEPARTMENT SET MGRSSN = 103 WHERE DNUMBER=3;
UPDATE DEPARTMENT SET MGRSSN = 104 WHERE DNUMBER=4;
UPDATE DEPARTMENT SET MGRSSN = 105 WHERE DNUMBER=5;
UPDATE DEPARTMENT SET MGRSSN = 106 WHERE DNUMBER=6;
UPDATE DEPARTMENT SET MGRSSN = 107 WHERE DNUMBER=7;
UPDATE DEPARTMENT SET MGRSSN = 108 WHERE DNUMBER=8;
UPDATE DEPARTMENT SET MGRSSN = 109 WHERE DNUMBER=9;
UPDATE DEPARTMENT SET MGRSSN = 110 WHERE DNUMBER=10;


INSERT INTO PROJECT VALUES 
(203, 'Project C', 'Alex', 2),
(204, 'Project D', 'Cairo', 3),
(205, 'Project E', 'Alex', 4),
(206, 'Project F', 'Alex', 4),
(207, 'Project G', 'Aswan', 5),
(208, 'Project H', 'Luxur', 5),
(209, 'Project I', 'Mansoura', 6),
(210, 'Project J', 'Cairo', 6),
(211, 'Project K', 'Aswan', 7),
(212, 'Project L', 'Matrouh', 7)

INSERT INTO WORKS_ON VALUES 
(103, 203, 20), 
(104, 204, 10), 
(105, 205, 50), 
(106, 206, 60), 
(107, 207, 70), 
(108, 208, 30), 
(109, 209, 20), 
(109, 210, 20), 
(104, 201, 90), 
(107, 202, 100), 
(102, 203, 10), 
(110, 204, 15);

--1. Display the Department ID, Name, and the ID and Name of its Manager

SELECT 
    DEPARTMENT.DNUMBER AS Department_ID,
    DEPARTMENT.DNAME AS Department_Name,
    EMPLOYEE.SSN AS Manager_ID,
    CONCAT(EMPLOYEE.FNAME, ' ', EMPLOYEE.LNAME) AS Manager_Name
FROM DEPARTMENT
LEFT JOIN EMPLOYEE ON DEPARTMENT.MGRSSN = EMPLOYEE.SSN;

--2. Display the Name of the Departments and the Name of the Projects under its Control

SELECT 
    DEPARTMENT.DNAME AS Department_Name,
    PROJECT.PNAME AS Project_Name
FROM DEPARTMENT JOIN PROJECT ON DEPARTMENT.DNUMBER = PROJECT.DNUM;

--3. Display Full Data About All Dependents Associated with the Name of the Employee They Depend On

SELECT 
    DEPENDENT.*,
    CONCAT(EMPLOYEE.FNAME, ' ', EMPLOYEE.LNAME) AS Employee_Name
FROM DEPENDENT
LEFT JOIN EMPLOYEE ON DEPENDENT.ESSN = EMPLOYEE.SSN;

--4. Display the ID, Name, and Location of the Projects in Cairo or Alex City

SELECT 
    PNUMBER AS Project_ID,
    PNAME AS Project_Name,
    PLOCATION AS Project_Location
FROM PROJECT
WHERE PLOCATION IN ('Cairo', 'Alex');

--5. Display the Full Data of Projects with Names Starting with "A"

SELECT *
FROM PROJECT
WHERE PNAME LIKE 'A%';

--6. Display All Employees in Department 30 Whose Salary is Between 2000 and 3000 LE Monthly

SELECT *
FROM EMPLOYEE
WHERE DNO = 5 AND SALARY BETWEEN 2000 AND 3000;

--7. Retrieve the Names of All Employees in Department 10 Who Work ≥10 Hours Per Week on "AL Rabwah" Project

SELECT 
    CONCAT(EMPLOYEE.FNAME, ' ', EMPLOYEE.LNAME) AS Employee_Name
FROM EMPLOYEE
JOIN WORKS_ON ON EMPLOYEE.SSN = WORKS_ON.ESSN
JOIN PROJECT ON WORKS_ON.PNO = PROJECT.PNUMBER
WHERE EMPLOYEE.DNO = 10 AND WORKS_ON.HOURS >= 10 AND PROJECT.PNAME = 'Project B';

--8. Find the Names of Employees Directly Supervised by "Kamel Mohamed"

SELECT 
    CONCAT(EMPLOYEE.FNAME, ' ', EMPLOYEE.LNAME) AS Employee_Name
FROM EMPLOYEE
WHERE SUPERSSN = (SELECT SSN 
                  FROM EMPLOYEE 
                  WHERE FNAME = 'Kamel' AND LNAME = 'Mohamed');

--9. Retrieve Names of All Employees and the Projects They Are Working On, Sorted by Project Name

SELECT 
    CONCAT(EMPLOYEE.FNAME, ' ', EMPLOYEE.LNAME) AS Employee_Name,
    PROJECT.PNAME AS Project_Name
FROM WORKS_ON
JOIN EMPLOYEE ON WORKS_ON.ESSN = EMPLOYEE.SSN
JOIN PROJECT ON WORKS_ON.PNO = PROJECT.PNUMBER
ORDER BY PROJECT.PNAME;

--10. For Projects in Cairo, Retrieve the Project Number, Controlling Department Name, Department Manager Last Name, Address, and Birthdate

SELECT 
    PROJECT.PNUMBER AS Project_Number,
    DEPARTMENT.DNAME AS Department_Name,
    EMPLOYEE.LNAME AS Manager_Last_Name,
    EMPLOYEE.ADDRESS AS Manager_Address,
    EMPLOYEE.BDATE AS Manager_Birthdate
FROM PROJECT
JOIN DEPARTMENT ON PROJECT.DNUM = DEPARTMENT.DNUMBER
JOIN EMPLOYEE ON DEPARTMENT.MGRSSN = EMPLOYEE.SSN
WHERE PROJECT.PLOCATION = 'Cairo';

--11. Display All Data of the Managers

SELECT *
FROM EMPLOYEE
WHERE SSN IN (SELECT MGRSSN FROM DEPARTMENT);

--12. Display All Employee Data and the Data of Their Dependents, Even if They Have No Dependents

SELECT 
    EMPLOYEE.*,
    DEPENDENT.DEPENDENT_NAME,
    DEPENDENT.SEX AS Dependent_Sex,
    DEPENDENT.BDATE AS Dependent_Birthdate,
    DEPENDENT.RELATIONSHIP
FROM EMPLOYEE
LEFT JOIN DEPENDENT ON EMPLOYEE.SSN = DEPENDENT.ESSN;