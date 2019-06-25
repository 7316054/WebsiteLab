ALTER PROCEDURE initialRoundRobin
as
SET NOCOUNT ON
declare @i int
set @i=1

declare @max as int
SELECT @max=value
FROM Config
WHERE keys='sizeTableEventAgregasi'

while(@i<@max+1)
begin
	insert into Event(baris) select @i
	insert into AgregasiKomputerHarian(baris) select @i
	insert into AgregasiApplikasiHarian(baris) select @i
	set @i=@i+1
end
