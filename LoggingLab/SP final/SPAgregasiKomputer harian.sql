ALTER procedure agregasikanTabelKomputer
	@targetTanggal date
as 
declare	@idUser int,@idKomputer int,@durasi float,@tanggal date
declare @n int
declare @baris int
declare @cUser int
declare @cKomputer int
DECLARE @tmp date SET @tmp = @targetTanggal
DECLARE @tmp1 datetime SET @tmp1 = @tmp

SELECT @tmp1


declare agg cursor
	for 
		select DISTINCT idUser,idKomputer
		from AgregasiKomputerPerEvent 
		WHERE DATEPART(day,start)=DATEPART(day,@tmp1) AND DATEPART(MONTH,start)=DATEPART(MONTH,@tmp1) AND DATEPART(YEAR,start)=DATEPART(YEAR,@tmp1)
open agg
fetch next from agg
	into 
		@cUser,@cKomputer
SELECT @cUser,@cKomputer
while(@@FETCH_STATUS=0)
	begin
--		DECLARE @tmp datetime SET @tmp = CAST(GETDATE() AS date)
	--	DECLARE @tmp1 datetime SET @tmp1 = @tmp
	SELECT @baris=baris,@n=COUNT(baris)
	FROM AgregasiKomputerHarian
	WHERE DATEPART(day,tanggal)=DATEPART(day,@tmp) AND DATEPART(MONTH,tanggal)=DATEPART(MONTH,@tmp) AND DATEPART(YEAR,tanggal)=DATEPART(YEAR,@tmp) AND idUser=@cUser AND idKomputer = @cKomputer
	GROUP BY baris
	SELECT @cUser,@cKomputer
	if(@n IS NULL)
	begin
		--DECLARE @tmp datetime SET @tmp = CAST(GETDATE() AS date)
		--DECLARE @tmp1 datetime SET @tmp1 = @tmp
		SELECT @idUser=idUser,@idKomputer=idKomputer,@durasi=SUM(durasi)
		FROM AgregasiKomputerPerEvent
		WHERE DATEPART(day,start)=DATEPART(day,@tmp1) AND DATEPART(MONTH,start)=DATEPART(MONTH,@tmp1) AND DATEPART(YEAR,start)=DATEPART(YEAR,@tmp1) AND idUser = @cUser AND idKomputer=@cKomputer
		GROUP BY idUser,idKomputer
		SET @tanggal=@tmp

		if(@idUser IS NOT NULL AND @idKomputer IS NOT NULL AND @durasi IS NOT NULL)
		BEGIN 
			EXEC insertIntoAgregasiKomputer @idUser,@idKomputer,@tanggal,@durasi
		END
	end
	else
	begin
		SELECT @idUser=idUser,@idKomputer=idKomputer,@durasi=SUM(durasi)
		FROM AgregasiKomputerPerEvent
		WHERE DATEPART(day,start)=DATEPART(day,@tmp1) AND DATEPART(MONTH,start)=DATEPART(MONTH,@tmp1) AND DATEPART(YEAR,start)=DATEPART(YEAR,@tmp1)  AND idUser = @cUser AND idKomputer=@cKomputer
		GROUP BY idUser,idKomputer
		SET @tanggal=@tmp
		
		update AgregasiKomputerHarian
		set idUser=@idUser,idKomputer=@idKomputer,tanggal =@tanggal,durasi=@durasi
		where baris=@baris
	end
	set @n=null
	fetch next from agg
			into @cUser,@cKomputer
	end

close agg
deallocate agg
