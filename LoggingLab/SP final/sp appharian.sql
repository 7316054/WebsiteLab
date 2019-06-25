ALTER procedure agregasikanApplikasiHarian
	@targetTanggal date
as
SET NOCOUNT ON
declare	@idUser int,@idApplikasi int,@durasi float,@tanggal date
declare @n int
declare @baris int
declare @cUser int
declare @cApplikasi int
DECLARE @tmp date SET @tmp = @targetTanggal
DECLARE @tmp1 datetime SET @tmp1 = @tmp

declare agg cursor
	for 
		select DISTINCT idUser,idApplikasi
		from AgregasiApplikasiPerEvent
		WHERE DATEPART(day,start)=DATEPART(day,@tmp1) AND DATEPART(MONTH,start)=DATEPART(MONTH,@tmp1) AND DATEPART(YEAR,start)=DATEPART(YEAR,@tmp1) AND idUser IS NOT NULL AND idApplikasi IS NOT null
open agg
fetch next from agg
	into 
		@cUser,@cApplikasi

while(@@FETCH_STATUS=0)
	begin
		--DECLARE @tmp datetime SET @tmp = CAST(GETDATE() AS date)
		--DECLARE @tmp1 datetime SET @tmp1 = @tmp
		SELECT @baris=baris,@n=COUNT(baris)
		FROM AgregasiApplikasiHarian
		WHERE DATEPART(day,tanggal)=DATEPART(day,@tmp) AND DATEPART(MONTH,tanggal)=DATEPART(MONTH,@tmp) AND DATEPART(YEAR,tanggal)=DATEPART(YEAR,@tmp) AND idUser=@cUser AND idApplikasi = @cApplikasi
		GROUP BY baris
	if(@n IS NULL)
	begin
		--DECLARE @tmp datetime SET @tmp = CAST(GETDATE() AS date)
		--DECLARE @tmp1 datetime SET @tmp1 = @tmp
		SELECT @idUser=idUser,@idApplikasi=idApplikasi,@durasi=SUM(durasi)
		FROM AgregasiApplikasiPerEvent
		WHERE DATEPART(day,start)=DATEPART(day,@tmp1) AND DATEPART(MONTH,start)=DATEPART(MONTH,@tmp1) AND DATEPART(YEAR,start)=DATEPART(YEAR,@tmp1)  AND idUser = @cUser AND idApplikasi=@cApplikasi
		GROUP BY idUser,idApplikasi
		SET @tanggal=@tmp

		IF(@idUser IS NOT NULL AND @idApplikasi IS NOT NULL AND @durasi IS NOT NULL)
		begin
			EXEC insertIntoAgregasiApp @idUser,@idApplikasi,@tanggal,@durasi
		end
	end
	else
	begin
		SELECT @idUser=idUser,@idApplikasi=idApplikasi,@durasi=SUM(durasi)
		FROM AgregasiApplikasiPerEvent
		WHERE DATEPART(day,start)=DATEPART(day,@tmp1) AND DATEPART(MONTH,start)=DATEPART(MONTH,@tmp1) AND DATEPART(YEAR,start)=DATEPART(YEAR,@tmp1)  AND idUser = @cUser AND idApplikasi=@cApplikasi
		GROUP BY idUser,idApplikasi
		SET @tanggal=@tmp
		
		update AgregasiApplikasiHarian
		set idUser=@idUser,idApplikasi=@idApplikasi,tanggal =@tanggal,durasi=@durasi
		where baris=@baris
	end
	SET @n = null
	fetch next from agg
			into @cUser,@cApplikasi
	end

close agg
deallocate agg
