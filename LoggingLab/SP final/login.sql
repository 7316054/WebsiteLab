ALTER PROCEDURE spLogin
	@username varchar(20),
	@idKompuser int
AS
SET NOCOUNT ON
DECLARE @id int  
SELECT @id=idUser FROM UserLab WHERE username = @username  
DECLARE @tmp DATETIME SET @tmp = GETDATE() 

UPDATE Komputer
SET status = 1
WHERE idKomputer = @idKompUser

EXEC insertIntoEvent_roundRobin 'login',@tmp,@id,@idKompUser,NULL