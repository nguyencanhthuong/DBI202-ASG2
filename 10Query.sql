-- SELECT ra total use ORDER BY, INNER JOIN, HAVING, Sub-query
SELECT CourseID, sID , sum(tbl1.Weight/100 * Score) as total 
FROM
	(SELECT a.*, g.Score, g.sID FROM Assessment a
	INNER JOIN Grade g on a.AssID = g.AssID ) tbl1 
GROUP BY [sID], CourseID 
HAVING sum(tbl1.Weight/100 * Score) > 7 ORDER BY [sID]

-- Count number student.
SELECT Count(*) FROM Student
--A query that uses a sub-query in the WHERE clause to display student max age in all student
SELECT *
FROM Student st
WHERE DOB <= ALL (SELECT DOB FROM Student);

-- A query that uses partial matching in the WHERE clause FIND student [First Name] have characteristic 'V'
SELECT * FROM Student WHERE [First Name] LIKE 'V%'

-- A query that uses a self-JOIN to display student same city
SELECT  s2.Address,	s1.[First Name] + ' ' +s1.Last Name] as fullName,
s2.[First Name] + ' ' +s2.Last Name] as fullName
FROM Student s1 
INNER JOIN Student s2 ON s1.sID > s2.sID  AND s1.Address = s2.Address
-- update average
go
DECLARE @courseID varchar(10);
DECLARE @sID char(8);
DECLARE update_total_cursor CURSOR FOR
SELECT CourseID, sID FROM [View];
OPEN update_total_cursor;
FETCH NEXT FROM update_total_cursor INTO @courseiD, @sID
WHILE @@FETCH_STATUS = 0
BEGIN
	DECLARE @total float;
	SELECT @total = sum(tbl1.Weight/100 * Score)  FROM
	(SELECT a.*, g.Score, g.sID FROM Assessment a
	INNER JOIN Grade g on a.AssID = g.AssID ) tbl1 WHERE CourseID = @courseID and sid = @sid;
	UPDATE [View] SET Average = @TOTAL WHERE CourseID = @courseID and sid = @sid;
	FETCH NEXT FROM update_total_cursor INTO @courseID, @sid
END
CLOSE update_total_cursor;
DEALLOCATE update_total_cursor;

-- UPDATE STATUS
go
-- Hàm check điều kiện xem có điểm thành phần nào không đủ điều kiện không?. 
CREATE FUNCTION check_pass(@courseID varchar(10), @sID char(8)) 
RETURNS int
AS
BEGIN
	DECLARE @flag int;
	DECLARE @categoryID varchar(10);
	SET @flag = 0;
	DECLARE check_pass_cursor CURSOR FOR
	SELECT [sID],CourseID, CategoryID FROM 
	(
	SELECT g.sID, a.CourseID, c.CategoryID, AVG(Score) as sub_total, [Completion Criteria] FROM Grade g
	INNER JOIN Assessment a on g.AssID = a.AssID
	INNER JOIN [Category Details] cd on cd.CategoryDetailsID = a.CategoryDetailsID
	INNER JOIN Category c on c.CategoryID = cd.CategoryID  GROUP BY CourseID, sID, c.CategoryID, [Completion Criteria]
	) as tbl1 WHERE  CourseID = @courseID and [sID] = @sID ;
	OPEN check_pass_cursor;
	FETCH NEXT FROM check_pass_cursor INTO @sID, @courseID, @categoryID
	WHILE @@FETCH_STATUS = 0
		BEGIN
			DECLARE @score fLOAT;
			DECLARE @scoreMin FLOAT
			SELECT @score = sub_total , @scoreMin = [Completion Criteria] FROM 
			(
				SELECT g.sID, a.CourseID, c.CategoryID, AVG(Score) as sub_total, [Completion Criteria]
				FROM Grade g
				INNER JOIN Assessment a on g.AssID = a.AssID
				INNER JOIN [Category Details] cd on cd.CategoryDetailsID = a.CategoryDetailsID
				INNER JOIN Category c on c.CategoryID = cd.CategoryID
				GROUP BY CourseID, sID, c.CategoryID, [Completion Criteria] 
			) as tbl1 WHERE tbl1.CourseID = @courseID  AND  tbl1.[sID] = @sID AND  CategoryID = @categoryID 
			IF @score <= @scoreMin
				BEGIN
					set @flag = 1;
					break;
				END
			FETCH NEXT FROM check_pass_cursor INTO @courseID, @sid, @categoryID
		END
	CLOSE check_pass_cursor;
	DEALLOCATE check_pass_cursor;
	return @flag;
END

GO

-- Stored Procedure update status is passed or not passed.
CREATE PROC update_status_pass
	@courseID varchar(10),
	@sID char(8)
AS
BEGIN
	DECLARE @average1 FLOAT;
	SELECT @average1 = Average FROM [View] WHERE  CourseID = @courseID  and  [sID] = @sID ;
	IF @average1 > 5 AND dbo.check_pass(@courseID,@sID) = 0
	UPDATE [View] SET [Status] = 'PASSED' WHERE  CourseID = @courseID  and  [sID] = @sID ;
	ELSE
	UPDATE [View] SET [Status] = 'NOT PASSED' WHERE  CourseID = @courseID  and  [sID] = @sID ;
END

-- cusor update status while have average.
go
DECLARE @courseID varchar(10);
DECLARE @sID char(8);
DECLARE update_status_cursor1 CURSOR FOR
SELECT CourseID, [sID] FROM [View];
OPEN update_status_cursor1;
FETCH NEXT FROM update_status_cursor1 INTO @courseiD, @sID
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC update_status_pass @CourseID, @sID
	FETCH NEXT FROM update_status_cursor1 INTO @courseID, @sid
END
CLOSE update_status_cursor1;
DEALLOCATE update_status_cursor1;


--test
SELECT g.sID, a.CourseID, c.CategoryID, AVG(Score) as sub_total, [Completion Criteria] FROM Grade g
INNER JOIN Assessment a on g.AssID = a.AssID
INNER JOIN [Category Details] cd on cd.CategoryDetailsID = a.CategoryDetailsID
INNER JOIN Category c on c.CategoryID = cd.CategoryID  GROUP BY CourseID, sID, c.CategoryID, [Completion Criteria]
Having AVG(Score) >5
-- test
GO
-- procedure calculator sub_total
CREATE PROC select_sub_total
AS
BEGIN
	SELECT g.sID, a.CourseID, c.CategoryID, AVG(Score) as sub_total, [Completion Criteria] FROM Grade g
	INNER JOIN Assessment a on g.AssID = a.AssID
	INNER JOIN [Category Details] cd on cd.CategoryDetailsID = a.CategoryDetailsID
	INNER JOIN Category c on c.CategoryID = cd.CategoryID  GROUP BY CourseID, sID, c.CategoryID, [Completion Criteria]
END
GO

EXEC select_sub_total



-- TRIGGER WHILE INPUT DATA AVERAGE OR STATUS-- 
GO
Drop TRIGGER View_Average ON [View]
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