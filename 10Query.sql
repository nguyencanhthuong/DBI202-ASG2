-- A query that uses ORDER BY
Select * From Student Order By [First name]
-- A query that uses INNER JOINS
SELECT a.*, g.Score, g.sID FROM Assessment a
	INNER JOIN Grade g on a.AssID = g.AssID 
-- A query that uses aggregate functions
Select Max([Average]) as [Highest Mark] From [View]
--A query that uses the GROUP BY and HAVING clauses
SELECT g.sID, a.CourseID, c.CategoryID, AVG(Score) as sub_total, [Completion Criteria] FROM Grade g
INNER JOIN Assessment a on g.AssID = a.AssID
INNER JOIN [Category Details] cd on cd.CategoryDetailsID = a.CategoryDetailsID
INNER JOIN Category c on c.CategoryID = cd.CategoryID  GROUP BY CourseID, sID, c.CategoryID, [Completion Criteria]
Having AVG(Score) >5
-- A query that uses a sub-query as a relation
SELECT CourseID, sID , sum(tbl1.Weight/100 * Score) as total 
FROM
	(SELECT a.*, g.Score, g.sID FROM Assessment a
	INNER JOIN Grade g on a.AssID = g.AssID ) tbl1 
	GROUP BY [sID], CourseID 
-- A query that uses a sub-query in the WHERE clause
SELECT *
FROM Student 
WHERE DOB <= ALL (SELECT DOB FROM Student);
--A query that uses partial matching in the WHERE clause
SELECT * FROM Student WHERE [First Name] LIKE 'N%'
-- A query that uses a self-JOIN
Select * From Student s1 inner join Student s2 ON s1.Sid=s2.Sid
--I created that trigger to warn about adding, correcting, deleting, wrong data
Create TRIGGER View_Average ON [View]
AFTER INSERT, UPDATE
AS
DECLARE @AVG FLOAT;
DECLARE @courseID VARCHAR(10);
DECLARE @ses varchar(10)
DECLARE @sID char(8);
DECLARE @average FLOAT;
DECLARE @status VARCHAR(20);

SELECT @sID = sID, @courseID = CourseID, @ses = Semester,
		@average = Average, @status = [Status]  
FROM inserted;
SELECT @AVG = sum(tbl1.Weight/100 * Score) FROM
		(SELECT a.*, g.Score, g.sID FROM Assessment a
		    INNER JOIN Grade g on a.AssID = g.AssID  WHERE sID = @sID and CourseID = @courseID
			) as tbl1 group by sID, CourseID 
IF @AVG <> @average
BEGIN
	PRINT 'Conflict input data'
	ROLLBACK TRAN
END
ELSE IF (NOT @status = 'PASSED') AND (NOT @status = 'NOT PASSED')
BEGIN
	PRINT 'Status must be passed or not passed'
	ROLLBACK TRAN
END
ELSE IF (@AVG <= 5 AND @status = 'PASSED') OR (@AVG > 5 AND @status = 'NOT PASSED')
BEGIN
	PRINT 'Incorrect Status'
	ROLLBACK TRAN
END

UPDATE [View] SET Average = 6.5, [Status] = 'PASSED', Semester ='Fall21' WHERE sID = 'HE163745' AND CourseID = 'MAE101'

SELECT * FROM [View]

--Procedure : Average of component scores
Create PROC select_sub_total
AS
BEGIN
	SELECT g.sID, a.CourseID, c.CategoryID, AVG(Score) as sub_total, [Completion Criteria] FROM Grade g
	INNER JOIN Assessment a on g.AssID = a.AssID
	INNER JOIN [Category Details] cd on cd.CategoryDetailsID = a.CategoryDetailsID
	INNER JOIN Category c on c.CategoryID = cd.CategoryID  GROUP BY CourseID, sID, c.CategoryID, [Completion Criteria]
END
GO

EXEC select_sub_total
--Helps to find information faster
CREATE INDEX Stu_Name ON Student([Last Name], [First Name])
CREATE INDEX Lec_Name ON Lecturers([Last Name], [First Name])
SELECT * FROM Student WHERE [Last Name] = N'Thuong' AND [First Name] = 'Nguyen Canh'