ALTER procedure agregasikanApplikasiPerEvent
as
SET NOCOUNT ON
declare agg cursor
	for 
		select DISTINCT idUser
		from Event

declare @cUser int,@start datetime
declare @idEvent int,@idUser int ,@idAplikasi int,@jam datetime,@ac varchar(6)
declare @startChecker int
declare @finishChecker int
declare @durasi float
open agg
fetch next from agg
	into 
		@cUser

while(@@FETCH_STATUS=0)
	begin

	declare aggApp cursor
	for 
		select idEvent,idUser,idApplikasi,waktu,aksi
		from Event
		where idUser=@cUser AND idApplikasi IS NOT NULL AND waktu IS NOT NULL AND aksi IS NOT NULL
		order by waktu

	open aggApp

	fetch next from aggApp
		into 
			@idEvent,@idUser,@idAplikasi,@jam,@ac
		while(@@FETCH_STATUS=0)
		begin
		set @startChecker =0
		if(@ac IS NOT NULL)
		begin
			if(@ac='buka')
				begin
					SELECT
						@startChecker = COUNT(start)
					FROM
						AgregasiApplikasiPerEvent
					WHERE
						 idUser=@idUser  AND idApplikasi=@idAplikasi and start = @jam

					if(@startChecker=0)
					begin
						set @start = @jam
					end
					else
					begin
						fetch next from aggApp
						into 
						@idEvent,@idUser,@idAplikasi,@jam,@ac

					end
				end
			else if(@ac='tutup')
				begin
					SET @durasi = DATEDIFF(SECOND,@start,@jam)
					INSERT INTO AgregasiApplikasiPerEvent (idUser,idApplikasi,start,finish,durasi)
					VALUES (@idUser,@idAplikasi,@start,@jam,@durasi)
				end
			fetch next from aggApp
				into 
			@idEvent,@idUser,@idAplikasi,@jam,@ac
		end
		else
		begin
			fetch next from aggApp
				into 
			@idEvent,@idUser,@idAplikasi,@jam,@ac
		end
		end
	close aggApp
	deallocate aggApp
	fetch next from agg
			into @cUser
	end

close agg
deallocate agg


