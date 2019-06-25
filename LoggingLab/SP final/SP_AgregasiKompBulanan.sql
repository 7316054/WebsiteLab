ALTER procedure agregasikanTabelKomputerBulanan
	@targetTanggal date
as 
SET NOCOUNT ON
declare	@idUser int,@idKomputer int,@durasi float,@bulan int,@tahun int
declare @ctahun int
declare @cbulan int
declare @cUser int
declare @cKomputer int
declare agg cursor
	for 
		select DISTINCT idUser,idKomputer
		from AgregasiKomputerHarian 
		WHERE DATEPART(MONTH,tanggal)=DATEPART(MONTH,@targetTanggal) AND DATEPART(YEAR,tanggal)=DATEPART(YEAR,@targetTanggal) AND idUser IS NOT NULL AND idKomputer IS NOT null
open agg
fetch next from agg
	into 
		@cUser,@cKomputer

while(@@FETCH_STATUS=0)
	begin
	SELECT @cbulan=bulan,@ctahun=tahun
	FROM AgregasiKomputerBulanan
	WHERE bulan =DATEPART(MONTH,@targetTanggal) AND tahun=DATEPART(YEAR,@targetTanggal) AND idUser=@cUser AND idKomputer = @cKomputer

	if(@cbulan IS NULL AND @ctahun IS NULL)
	begin
		SELECT @idUser=idUser,@idKomputer=idKomputer,@durasi=SUM(durasi)
		FROM AgregasiKomputerHarian
		WHERE DATEPART(MONTH,tanggal)=DATEPART(MONTH,@targetTanggal) AND DATEPART(YEAR,tanggal)=DATEPART(YEAR,@targetTanggal) AND idUser = @cUser AND idKomputer=@cKomputer
		GROUP BY idUser,idKomputer
		SET @bulan=DATEPART(MONTH,@targetTanggal)
		SET @tahun =DATEPART(YEAR,@targetTanggal)
		if(@idUser IS NOT NULL AND @idKomputer IS NOT NULL AND @durasi IS NOT NULL)
		BEGIN
			INSERT INTO AgregasiKomputerBulanan(idUser,idKomputer,durasi,bulan,tahun)
			VALUES (@idUser,@idKomputer,@durasi,@bulan,@tahun)
		END
	end
	else
	begin
		SELECT @idUser=idUser,@idKomputer=idKomputer,@durasi=SUM(durasi)
		FROM AgregasiKomputerHarian
		WHERE DATEPART(MONTH,tanggal)=DATEPART(MONTH,@targetTanggal) AND DATEPART(YEAR,tanggal)=DATEPART(YEAR,@targetTanggal) AND idUser = @cUser AND idKomputer=@cKomputer
		GROUP BY idUser,idKomputer
		SET @bulan=DATEPART(MONTH,@targetTanggal)
		SET @tahun =DATEPART(YEAR,@targetTanggal)
		
		update AgregasiKomputerBulanan
		set durasi=@durasi
		where bulan=@bulan AND @tahun = @tahun AND idUser=@idUser AND idKomputer=@idKomputer
	end
	SET @cbulan=null
	SET @ctahun=null
	fetch next from agg
			into @cUser,@cKomputer
	end

close agg
deallocate agg


