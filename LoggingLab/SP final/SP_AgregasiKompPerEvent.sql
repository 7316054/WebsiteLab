ALTER procedure agregasikanTabelKomputerPerEvent
as
SET NOCOUNT ON
declare agg cursor
	for 
		select DISTINCT idUser
		from Event
declare @durasi float
declare @cUser int,@start datetime
declare @idEvent int,@idUser int ,@idKomputer int,@jam datetime,@ac varchar(6)
declare @startChecker int
declare @finishChecker int
open agg
fetch next from agg
	into 
		@cUser

while(@@FETCH_STATUS=0)
	begin

	declare aggKom cursor
	for 
		select idEvent,idUser,idKomputer,waktu,aksi
		from Event
		where idUser=@cUser AND idKomputer IS NOT NULL AND waktu IS NOT NULL AND aksi IS NOT NULL AND idApplikasi IS NULL
		order by waktu 

	open aggKom

	fetch next from aggKom
		into 
			@idEvent,@idUser,@idKomputer,@jam,@ac
		while(@@FETCH_STATUS=0)
		begin
		set @startChecker =0
		if(@ac IS NOT NULL)
		begin
			if(@ac='login')
				begin
					SELECT
						@startChecker = COUNT(start)
					FROM
						AgregasiKomputerPerEvent
					WHERE
						idKomputer=@idKomputer AND idUser=@idUser AND start = @jam 

					if(@startChecker=0)
					begin
						set @start = @jam
						SELECT @start
					end
					else
					begin
						fetch next from aggKom
						into 
						@idEvent,@idUser,@idKomputer,@jam,@ac
					end
				end
			else
				begin
					if(@start IS NOT null)
					begin
						SET @durasi = DATEDIFF(SECOND,@start,@jam)
						INSERT INTO AgregasiKomputerPerEvent(idUser,idKomputer,start,finish,durasi)
						VALUES (@idUser,@idKomputer,@start,@jam,@durasi)
					end
				end
			fetch next from aggKom
				into 
			@idEvent,@idUser,@idKomputer,@jam,@ac
		end
		else
		begin
			fetch next from aggKom
				into 
			@idEvent,@idUser,@idKomputer,@jam,@ac
		end
		end
	close aggKom
	deallocate aggKom
	fetch next from agg
			into @cUser
	end

close agg
deallocate agg



