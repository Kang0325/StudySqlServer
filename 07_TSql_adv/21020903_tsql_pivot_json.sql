use sqlDB;
go

select row_number () over(order by height desc, userName asc) as 'Ű ū ����',
	   userName, addr, height
  from userTBL;
--�����, �̽±� ���� 2��
select rank () over(order by height desc) as 'Ű ū ����', 
	   userName, addr, height
  from userTBL;
--���� ���� ���X
select dense_rank () over(order by height desc) as 'Ű ū ����', 
	   userName, addr, height
  from userTBL;
--������ ����
select rank () over(partition by addr order by height desc) as 'Ű ū ����', 
	   userName, addr, height
  from userTBL;

--pivot
/*
create table pivotTBL
(
	userName nvarchar(10),
	season nvarchar(2),
	amount int
);

insert into pivotTBL values ('�����', '�ܿ�', 10),
							('������', '����', 15),
							('�����', '����', 25),
							('�����', '��', 3),
							('�����', '��', 37),
							('������', '�ܿ�', 40),
							('�����', '����', 14),
							('�����', '�ܿ�', 22),
							('������', '����', 64);
go
*/

insert into pivotTBL values ('���ð�', '����', 30);

select * from pivotTBL;

select * from pivotTBL
  pivot (sum(amount)
		 for season
		 in([��],[����],[����],[�ܿ�])) as resultPivot;

--json
select userID, userName, addr, height
  from userTBL
  where height>=180
  for json auto;