/*
create view uv_user177
as
	select * from userTbl where height >=177;
go
*/

create view uv_buyTBL
as
	select * from buyTBL where groupName = '전자';
go

select * from uv_buyTBL;
insert into uv_buyTbl values ('KKH', '기타', '악기', 4000, 1);

begin tran; --트랜잭션

delete from uv_buyTBL;

rollback; -- 원상태 복귀