ALTER PROCEDURE initialConfig
as
insert into config select 'barisEvent',1
insert into config select 'sizeTableEventAgregasi',1000
insert into config select 'barisAgregasiAppHarian',1
insert into config select 'barisAgregasiKompHarian',1
