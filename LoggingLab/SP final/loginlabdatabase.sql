USE [LoginLab]
GO
/****** Object:  User [testtbd]    Script Date: 14/05/2019 16:40:06 ******/
CREATE USER [testtbd] FOR LOGIN [testtbd] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [testtbd]
GO
/****** Object:  Table [dbo].[AgregasiApplikasiBulanan]    Script Date: 14/05/2019 16:40:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AgregasiApplikasiBulanan](
	[idAp] [int] IDENTITY(1,1) NOT NULL,
	[idUser] [int] NULL,
	[idApplikasi] [int] NULL,
	[durasi] [float] NULL,
	[bulan] [int] NULL,
	[tahun] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AgregasiApplikasiHarian]    Script Date: 14/05/2019 16:40:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AgregasiApplikasiHarian](
	[idAp] [int] IDENTITY(1,1) NOT NULL,
	[idUser] [int] NULL,
	[idApplikasi] [int] NULL,
	[durasi] [float] NULL,
	[tanggal] [date] NULL,
	[baris] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AgregasiApplikasiPerEvent]    Script Date: 14/05/2019 16:40:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AgregasiApplikasiPerEvent](
	[idAp] [int] IDENTITY(1,1) NOT NULL,
	[idUser] [int] NULL,
	[idApplikasi] [int] NULL,
	[durasi] [float] NULL,
	[start] [datetime] NULL,
	[finish] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AgregasiKomputerBulanan]    Script Date: 14/05/2019 16:40:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AgregasiKomputerBulanan](
	[idAK] [int] IDENTITY(1,1) NOT NULL,
	[idUser] [int] NULL,
	[idKomputer] [int] NULL,
	[durasi] [float] NULL,
	[bulan] [int] NULL,
	[tahun] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AgregasiKomputerHarian]    Script Date: 14/05/2019 16:40:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AgregasiKomputerHarian](
	[idAk] [int] IDENTITY(1,1) NOT NULL,
	[idUser] [int] NULL,
	[idKomputer] [int] NULL,
	[durasi] [float] NULL,
	[tanggal] [date] NULL,
	[baris] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AgregasiKomputerPerEvent]    Script Date: 14/05/2019 16:40:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AgregasiKomputerPerEvent](
	[idAk] [int] IDENTITY(1,1) NOT NULL,
	[idUser] [int] NULL,
	[idKomputer] [int] NULL,
	[start] [datetime] NULL,
	[finish] [datetime] NULL,
	[durasi] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Applikasi]    Script Date: 14/05/2019 16:40:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Applikasi](
	[idApplikasi] [int] IDENTITY(1,1) NOT NULL,
	[namaApplikasi] [varchar](256) NULL,
	[directoyLogoApplikasi] [varchar](256) NULL,
PRIMARY KEY CLUSTERED 
(
	[idApplikasi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Config]    Script Date: 14/05/2019 16:40:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Config](
	[keys] [varchar](256) NULL,
	[value] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Event]    Script Date: 14/05/2019 16:40:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Event](
	[idEvent] [int] IDENTITY(1,1) NOT NULL,
	[aksi] [varchar](256) NULL,
	[waktu] [datetime] NULL,
	[idUser] [int] NULL,
	[idKomputer] [int] NULL,
	[idApplikasi] [int] NULL,
	[baris] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Komputer]    Script Date: 14/05/2019 16:40:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Komputer](
	[idKomputer] [int] IDENTITY(1,1) NOT NULL,
	[namaKomputer] [varchar](256) NULL,
	[status] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[idKomputer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserLab]    Script Date: 14/05/2019 16:40:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserLab](
	[idUser] [int] IDENTITY(1,1) NOT NULL,
	[role] [varchar](10) NULL,
	[username] [varchar](256) NULL,
	[password] [varchar](256) NULL,
	[nama] [varchar](256) NULL,
	[banned] [tinyint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[UserLab] ADD  CONSTRAINT [DF_UserLab_banned]  DEFAULT ((0)) FOR [banned]
GO
ALTER TABLE [dbo].[AgregasiApplikasiBulanan]  WITH CHECK ADD FOREIGN KEY([idApplikasi])
REFERENCES [dbo].[Applikasi] ([idApplikasi])
GO
ALTER TABLE [dbo].[AgregasiApplikasiBulanan]  WITH CHECK ADD FOREIGN KEY([idUser])
REFERENCES [dbo].[UserLab] ([idUser])
GO
ALTER TABLE [dbo].[AgregasiApplikasiHarian]  WITH CHECK ADD FOREIGN KEY([idApplikasi])
REFERENCES [dbo].[Applikasi] ([idApplikasi])
GO
ALTER TABLE [dbo].[AgregasiApplikasiHarian]  WITH CHECK ADD FOREIGN KEY([idUser])
REFERENCES [dbo].[UserLab] ([idUser])
GO
ALTER TABLE [dbo].[AgregasiApplikasiPerEvent]  WITH CHECK ADD FOREIGN KEY([idApplikasi])
REFERENCES [dbo].[Applikasi] ([idApplikasi])
GO
ALTER TABLE [dbo].[AgregasiApplikasiPerEvent]  WITH CHECK ADD FOREIGN KEY([idUser])
REFERENCES [dbo].[UserLab] ([idUser])
GO
ALTER TABLE [dbo].[AgregasiKomputerBulanan]  WITH CHECK ADD FOREIGN KEY([idKomputer])
REFERENCES [dbo].[Komputer] ([idKomputer])
GO
ALTER TABLE [dbo].[AgregasiKomputerBulanan]  WITH CHECK ADD FOREIGN KEY([idUser])
REFERENCES [dbo].[UserLab] ([idUser])
GO
ALTER TABLE [dbo].[AgregasiKomputerHarian]  WITH CHECK ADD FOREIGN KEY([idUser])
REFERENCES [dbo].[UserLab] ([idUser])
GO
ALTER TABLE [dbo].[AgregasiKomputerHarian]  WITH CHECK ADD FOREIGN KEY([idUser])
REFERENCES [dbo].[UserLab] ([idUser])
GO
ALTER TABLE [dbo].[AgregasiKomputerPerEvent]  WITH CHECK ADD FOREIGN KEY([idKomputer])
REFERENCES [dbo].[Komputer] ([idKomputer])
GO
ALTER TABLE [dbo].[AgregasiKomputerPerEvent]  WITH CHECK ADD FOREIGN KEY([idUser])
REFERENCES [dbo].[UserLab] ([idUser])
GO
ALTER TABLE [dbo].[Event]  WITH CHECK ADD FOREIGN KEY([idApplikasi])
REFERENCES [dbo].[Applikasi] ([idApplikasi])
GO
ALTER TABLE [dbo].[Event]  WITH CHECK ADD FOREIGN KEY([idKomputer])
REFERENCES [dbo].[Komputer] ([idKomputer])
GO
ALTER TABLE [dbo].[Event]  WITH CHECK ADD FOREIGN KEY([idUser])
REFERENCES [dbo].[UserLab] ([idUser])
GO
/****** Object:  StoredProcedure [dbo].[agregasikanApplikasi]    Script Date: 14/05/2019 16:40:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[agregasikanApplikasi]
as
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
						AgregasiApplikasiHarian
					WHERE
						start = @jam

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
					EXEC insertIntoAgregasiApp @idUser,@idAplikasi,@start,@jam,@durasi
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



GO
/****** Object:  StoredProcedure [dbo].[agregasikanApplikasiHarian]    Script Date: 14/05/2019 16:40:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[agregasikanApplikasiHarian]
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
GO
/****** Object:  StoredProcedure [dbo].[agregasikanApplikasiPerEvent]    Script Date: 14/05/2019 16:40:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[agregasikanApplikasiPerEvent]
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


GO
/****** Object:  StoredProcedure [dbo].[agregasikanTabelApplikasiBulanan]    Script Date: 14/05/2019 16:40:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[agregasikanTabelApplikasiBulanan]
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
GO
/****** Object:  StoredProcedure [dbo].[agregasikanTabelKomputer]    Script Date: 14/05/2019 16:40:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[agregasikanTabelKomputer]
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
GO
/****** Object:  StoredProcedure [dbo].[agregasikanTabelKomputerBulanan]    Script Date: 14/05/2019 16:40:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[agregasikanTabelKomputerBulanan]
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


GO
/****** Object:  StoredProcedure [dbo].[agregasikanTabelKomputerPerEvent]    Script Date: 14/05/2019 16:40:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[agregasikanTabelKomputerPerEvent]
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



GO
/****** Object:  StoredProcedure [dbo].[initialConfig]    Script Date: 14/05/2019 16:40:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[initialConfig]
as
insert into config select 'barisEvent',1
insert into config select 'sizeTableEventAgregasi',1000
insert into config select 'barisAgregasiAppHarian',1
insert into config select 'barisAgregasiKompHarian',1
GO
/****** Object:  StoredProcedure [dbo].[initialRoundRobin]    Script Date: 14/05/2019 16:40:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[initialRoundRobin]
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
GO
/****** Object:  StoredProcedure [dbo].[insertIntoAgregasiApp]    Script Date: 14/05/2019 16:40:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insertIntoAgregasiApp]
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


GO
/****** Object:  StoredProcedure [dbo].[insertIntoAgregasiKomputer]    Script Date: 14/05/2019 16:40:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insertIntoAgregasiKomputer]
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



GO
/****** Object:  StoredProcedure [dbo].[insertIntoEvent_roundRobin]    Script Date: 14/05/2019 16:40:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insertIntoEvent_roundRobin] 
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
GO
/****** Object:  StoredProcedure [dbo].[jamSibukLab]    Script Date: 14/05/2019 16:40:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[jamSibukLab]
	@targetTanggal date
as
SET NOCOUNT ON 
DECLARE @TblSibukKomputer table(
	idKomputer int,
	jam varchar(10),
	banyakLogin int
)
DECLARE @TblFinalSibukKomputer table(
	KomputerTersering int,
	jam varchar(10),
	banyakLogin int
)
DECLARE @TblSibukLab table(
	jam varchar(10),
	banyakLoginDiLab int
)
DECLARE @TblFinalSibukLab table(
	jam varchar(10),
	banyakLoginDiLab int
)
DECLARE @batas int
SET @batas = 2
DECLARE @batasBawah int
DECLARE @batasAtas int
DECLARE @iterator int
SET @batasBawah = 7
SET @batasAtas = 9
SET @iterator = 0
WHILE(@batasAtas<=17)
BEGIN
	INSERT INTO @TblSibukKomputer
	SELECT 
		idKomputer,CONCAT(@batasBawah,' - ',@batasAtas),COUNT(idKomputer)
	FROM
		AgregasiKomputerPerEvent
	WHERE
		DATEPART(DAY,start) = DATEPART(DAY,@targetTanggal) AND DATEPART(HOUR,start)<=@batasAtas AND DATEPART(HOUR,start)>=@batasBawah
	GROUP BY
		idKomputer

	INSERT INTO @TblSibukLab
	SELECT 
		CONCAT(@batasBawah,' - ',@batasAtas),COUNT(DATEPART(DAY,start))
	FROM
		AgregasiKomputerPerEvent
	WHERE
		DATEPART(DAY,start) = DATEPART(DAY,@targetTanggal) AND DATEPART(HOUR,start)<=@batasAtas AND DATEPART(HOUR,start)>=@batasBawah
	GROUP BY
		DATEPART(DAY,start)

	SET @batasBawah = @batasAtas
	SET @batasAtas = @batasAtas+@batas
END

SET @batasBawah = 7
SET @batasAtas = 9
WHILE(@batasAtas<=17)
BEGIN
	DECLARE @n int
	SELECT @n = COUNT(idKomputer)
	FROM @TblSibukKomputer
	WHERE jam=CONCAT(@batasBawah,' - ',@batasAtas)
	IF(@n>0)
	BEGIN
		INSERT INTO @TblFinalSibukKomputer
		SELECT TOP 1*
		FROM @TblSibukKomputer
		WHERE jam=CONCAT(@batasBawah,' - ',@batasAtas)
		ORDER BY banyakLogin desc

		INSERT INTO @TblFinalSibukLab
		SELECT TOP 1*
		FROM @TblSibukLab
		WHERE jam=CONCAT(@batasBawah,' - ',@batasAtas)

	END
	ELSE
	BEGIN
		INSERT INTO @TblFinalSibukKomputer
		SELECT 0,CONCAT(@batasBawah,' - ',@batasAtas),0

		INSERT INTO @TblFinalSibukLab
		SELECT CONCAT(@batasBawah,' - ',@batasAtas),0
	END
	SET @batasBawah = @batasAtas
	SET @batasAtas = @batasAtas+@batas
END

SELECT TOP 1 KomputerTersering,banyakLogin as 'LoginSebanyak',t2.jam,t2.banyakLoginDiLab
FROM @TblFinalSibukKomputer AS t1 JOIN @TblFinalSibukLab AS t2 ON t1.jam = t2.jam
ORDER BY banyakLoginDiLab desc

SELECT TOP 1 KomputerTersering,banyakLogin as 'LoginSebanyak',t2.jam,t2.banyakLoginDiLab
FROM @TblFinalSibukKomputer AS t1 JOIN @TblFinalSibukLab AS t2 ON t1.jam = t2.jam
ORDER BY banyakLoginDiLab ASC

SELECT *
FROM @TblFinalSibukLab

GO
/****** Object:  StoredProcedure [dbo].[spLogin]    Script Date: 14/05/2019 16:40:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spLogin]
	@username varchar(20),
	@idKompuser int
AS
SET NOCOUNT ON
DECLARE @id int  
SELECT @id=idUser FROM UserLab WHERE username = @username  
DECLARE @tmp DATETIME SET @tmp = GETDATE() 

UPDATE Komputer
SET status = 1
WHERE idKomputer = @idKompUser

EXEC insertIntoEvent_roundRobin 'login',@tmp,@id,@idKompUser,NULL
GO
/****** Object:  StoredProcedure [dbo].[spLogout]    Script Date: 14/05/2019 16:40:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spLogout]
	@idLogin int,
	@idKompUser int

AS
SET NOCOUNT ON
DECLARE @tmp DATETIME SET @tmp = GETDATE() 

UPDATE Komputer
SET status = 0
WHERE idKomputer = @idKompUser

EXEC insertIntoEvent_roundRobin 'logout',@tmp,@idLogin,@idKompUser,NULL


GO
