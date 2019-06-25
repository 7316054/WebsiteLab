ALTER PROCEDURE insertIntoEvent_roundRobin 
@aksi varchar(256),
@waktu datetime,
@idUser int,
@idKomputer int,
@idAplikasi int
AS
declare @baris as int
declare @max as int
SELECT @baris=value
FROM Config
WHERE keys='barisEvent'
SELECT @max=value
FROM Config
WHERE keys='sizeTableEventAgregasi'
if(@baris>@max)
begin
	set @baris=1
	update config
	set value=@baris
	where keys='barisEvent'

	update event
	set aksi=@aksi,waktu=@waktu,idUser=@idUser,idKomputer=@idKomputer,idApplikasi=@idAplikasi
	where baris=@baris

	set @baris=@baris+1
	select value=@baris
	from config
	where keys='barisEvent'

end
else
begin
	update event
	set aksi=@aksi,waktu=@waktu,idUser=@idUser,idKomputer=@idKomputer,idApplikasi=@idAplikasi
	where baris=@baris

	set @baris=@baris+1
	update config
	set value=@baris
	where keys='barisEvent'
end

EXEC insertIntoEvent_roundRobin

SELECT *
FROM Config

