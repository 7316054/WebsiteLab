ALTER PROCEDURE spLogout
	@idLogin int,
	@idKompUser int

AS
SET NOCOUNT ON
DECLARE @tmp DATETIME SET @tmp = GETDATE() 

UPDATE Komputer
SET status = 0
WHERE idKomputer = @idKompUser

EXEC insertIntoEvent_roundRobin 'logout',@tmp,@idLogin,@idKompUser,NULL


