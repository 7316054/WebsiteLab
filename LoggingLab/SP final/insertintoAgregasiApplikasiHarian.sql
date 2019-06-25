ALTER PROCEDURE insertIntoAgregasiApp
	@idUser int,
	@idAplikasi int,
	@tanggal date,
	@durasi float
AS
SET NOCOUNT ON
declare @baris as int
declare @max as int
SELECT @baris=value
FROM Config
WHERE keys='barisAgregasiAppHarian'
SELECT @max=value
FROM Config
WHERE keys='sizeTableEventAgregasi'

if(@baris>@max)
	begin
		set @baris=1
		update config
		set value=@baris
		where keys='barisAgregasiAppHarian'
		
		declare @temp int
		update AgregasiApplikasiHarian
		set idUser=@idUser,idApplikasi=@idAplikasi,tanggal=@tanggal,durasi=@durasi
		where baris=@baris

		set @baris=@baris+1
		select value=@baris
		from config
		where keys='barisAgregasiAppHarian'
	end
else
begin
	update AgregasiApplikasiHarian
	set idUser=@idUser,idApplikasi=@idAplikasi,tanggal=@tanggal,durasi=@durasi
	where baris=@baris

	set @baris=@baris+1
	update config
	set value=@baris
	where keys='barisAgregasiAppHarian'


end


