/*
create view uv_user177
as
	select * from userTbl where height >=177;
go
*/

create view uv_buyTBL
as
	select * from buyTBL where groupName = '����';
go

select * from uv_buyTBL;
insert into uv_buyTbl values ('KKH', '��Ÿ', '�Ǳ�', 4000, 1);

begin tran; --Ʈ�����

delete from uv_buyTBL;

rollback; -- ������ ����