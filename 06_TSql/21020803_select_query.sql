use sqlDB;
go

--이름이 김경호인 사람 조회
select * from userTBL
where userName = '김경호';

--1970년 이후 출생, 키 182이상인 사람 아이디, 이름만 조회
select userID, userName, height
from userTBL
where birthYear >=1970 and height>=182;

--1970년 이후 출생이거나 키가 182이상이거나 인 사람들 모두
select userID, userName, birthYear, height
from userTBL
where birthYear >=1970 or height>=182;

--키가 180~183인 사람 조회
select userID, userName, height
from userTBL
where height>=180 and height<=183;
--between ~ and
select userID, userName, height
from userTBL
where height between 180 and 183;

--지역이 경남, 전남, 경북
select userID, userName, addr
from userTBL
where addr = '경남' or addr = '전남' or addr = '경북';

select userID, userName, addr
from userTBL
where addr in ('경남', '전남', '경북');

--like
select userID, userName, addr
from userTBL
where userName like '김%';

--subquery
select userID, userName, height
from userTBL
where height >
	(select height from userTBL where userName = '김경호');

select userID, userName, height, addr
from userTBL
where height in
	(select height from userTBL where addr = '경남'); --170, 173

--order by 정렬
select userName, mDate
from userTBL
order by mDate desc; --asc 오름차순, desc 내림차순

select *
from userTBL
order by userID desc;

--distinct
select distinct addr
from userTBL;

select top(5) *
from userTBL
order by mDate desc;

--offset 앞선 갯수만큼 뛰어넘은 후 조회
select userID, userName, birthYear
from userTBL
order by birthYear
offset 4 rows;

--복사
select * into buyTbl2 from buyTbl;
select userID, prodName into buyTbl3 from buyTBL;

--group by
select userID, amount
from buyTbl
order by userID;

select userID, sum(amount) as '합계'
from buyTbl
group by userID;

--min, max
select min(height) as '작은 키'
from userTBL;

select max(height) as '큰 키'
from userTBL;
-------------------------------
select userID, userName, min(height) as '작은 키', max(height) as '큰 키'
from userTBL
group by userID, userName;

select userID, userName, height
from userTBL
where height = (select min(height) from userTBL)
or height = (select max(height) from userTBL)

--총 데이터 갯수
select count(*) as '회원 수' from userTBL; --10
select count(*) as '구매내역 수' from buyTBL; --12

--잘못된 필터링
select userID, sum(price * amount) as '아이디별 구매금액'
from buyTBL
group by userID
having sum(price * amount) > 1000
order by sum(price * amount) asc;

--rollup/cube
select num, groupName, sum(price * amount) as '구매금액',
		GROUPING_ID(groupName, num)
	from buyTBL
	group by rollup(groupName, num);

--userID, groupName 가지고 cube 다차원 합계
select userID, groupName, sum(price * amount) as '구매금액'
	from buyTBL
	group by cube(groupName, userID);

select userID, sum(price * amount) as '구매금액'
	from buyTBL
	group by rollup(userID);

select groupName, sum(price * amount) as '구매금액'
	from buyTBL
	group by rollup(groupName);

--without CTE
select userID, sum(price * amount) as 'total'
	from buyTbl
	group by userID
	order by sum(price * amount) desc;
--with CTE
with cte_tmp(userID, total)
as
(
	select userId, sum(price * amount) as 'total'
	from buyTbl
	group by userID
)
select * from cte_tmp order by total desc;