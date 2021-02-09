use sqlDB;
go

select row_number () over(order by height desc, userName asc) as '키 큰 순위',
	   userName, addr, height
  from userTBL;
--임재범, 이승기 공동 2위
select rank () over(order by height desc) as '키 큰 순위', 
	   userName, addr, height
  from userTBL;
--공동 순위 상관X
select dense_rank () over(order by height desc) as '키 큰 순위', 
	   userName, addr, height
  from userTBL;
--지역별 순위
select rank () over(partition by addr order by height desc) as '키 큰 순위', 
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

insert into pivotTBL values ('김범수', '겨울', 10),
							('윤종신', '여름', 15),
							('김범수', '가을', 25),
							('김범수', '봄', 3),
							('김범수', '봄', 37),
							('윤종신', '겨울', 40),
							('김범수', '여름', 14),
							('김범수', '겨울', 22),
							('윤종신', '여름', 64);
go
*/

insert into pivotTBL values ('성시경', '여름', 30);

select * from pivotTBL;

select * from pivotTBL
  pivot (sum(amount)
		 for season
		 in([봄],[여름],[가을],[겨울])) as resultPivot;

--json
select userID, userName, addr, height
  from userTBL
  where height>=180
  for json auto;