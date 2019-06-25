ALTER PROCEDURE insertIntoAgregasiKomputer
	@idUser int,
	@idKomputer int,
	@tanggal date,
	@durasi float
AS
SET NOCOUNT ON
declare @baris as int
declare @max as int
SELECT @baris=value
FROM Config
WHERE keys='barisAgregasiKompHarian'
SELECT @max=value
FROM Config
WHERE keys='sizeTableEventAgregasi'

if(@baris>@max)
begin
	set @baris=1
	update config
	set value=@baris
	where keys='barisAgregasiKompHarian'

	update AgregasiKomputerHarian
	set idUser=@idUser,idKomputer=@idKomputer,tanggal =@tanggal,durasi=@durasi
	where baris=@baris

	set @baris=@baris+1
	select value=@baris
	from config
	where keys='barisAgregasiKompHarian'

end
else
begin
	update AgregasiKomputerHarian
	set idUser=@idUser,idKomputer=@idKomputer,tanggal =@tanggal,durasi=@durasi
	where baris=@baris

	set @baris=@baris+1
	update config
	set value=@baris
	where keys='barisAgregasiKompHarian'


end



