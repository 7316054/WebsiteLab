ALTER PROCEDURE jamSibukLab
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

