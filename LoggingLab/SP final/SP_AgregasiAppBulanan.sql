ALTER procedure agregasikanTabelApplikasiBulanan
	@targetTanggal date
as 
SET NOCOUNT ON
declare	@idUser int,@idApplikasi int,@durasi float,@bulan int,@tahun int
declare @ctahun int
declare @cbulan int
declare @cUser int
declare @cApplikasi int
declare agg cursor
	for 
		select DISTINCT idUser,idApplikasi
		from AgregasiApplikasiHarian 
		WHERE DATEPART(MONTH,tanggal)=DATEPART(MONTH,@targetTanggal) AND DATEPART(YEAR,tanggal)=DATEPART(YEAR,@targetTanggal) AND idUser IS NOT NULL AND idApplikasi IS NOT null
open agg
fetch next from agg
	into 
		@cUser,@cApplikasi

while(@@FETCH_STATUS=0)
	begin
	SELECT @cbulan=bulan,@ctahun=tahun
	FROM AgregasiApplikasiBulanan
	WHERE bulan =DATEPART(MONTH,@targetTanggal) AND tahun=DATEPART(YEAR,@targetTanggal) AND idUser=@cUser AND idApplikasi = @cApplikasi

	if(@cbulan IS NULL AND @ctahun IS NULL)
	begin
		SELECT @idUser=idUser,@idApplikasi=idApplikasi,@durasi=SUM(durasi)
		FROM AgregasiApplikasiHarian
		WHERE DATEPART(MONTH,tanggal)=DATEPART(MONTH,@targetTanggal) AND DATEPART(YEAR,tanggal)=DATEPART(YEAR,@targetTanggal) AND idUser = @cUser AND idApplikasi=@cApplikasi
		GROUP BY idUser,idApplikasi
		SET @bulan=DATEPART(MONTH,@targetTanggal)
		SET @tahun =DATEPART(YEAR,@targetTanggal)
		if(@idUser IS NOT NULL AND @idApplikasi IS NOT NULL AND @durasi IS NOT NULL)
		BEGIN
			INSERT INTO AgregasiApplikasiBulanan(idUser,idApplikasi,durasi,bulan,tahun)
			VALUES (@idUser,@idApplikasi,@durasi,@bulan,@tahun)
		END
	end
	else
	begin
		SELECT @idUser=idUser,@idApplikasi=idApplikasi,@durasi=SUM(durasi)
		FROM AgregasiApplikasiHarian
		WHERE DATEPART(MONTH,tanggal)=DATEPART(MONTH,@targetTanggal) AND DATEPART(YEAR,tanggal)=DATEPART(YEAR,@targetTanggal) AND idUser = @cUser AND idApplikasi=@cApplikasi
		GROUP BY idUser,idApplikasi
		SET @bulan=DATEPART(MONTH,@targetTanggal)
		SET @tahun =DATEPART(YEAR,@targetTanggal)
		
		update AgregasiApplikasiBulanan
		set durasi=@durasi
		where bulan=@bulan AND @tahun = @tahun AND idUser=@idUser AND idApplikasi=@idApplikasi
	end
	
	SET @cbulan=null
	SET @ctahun=null
	fetch next from agg
			into @cUser,@cApplikasi
	end

close agg
deallocate agg
