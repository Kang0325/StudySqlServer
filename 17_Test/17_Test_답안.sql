-- 1-1
select lower(email) as Email, Mobile, Names, Addr from membertbl
order by names desc;

-- 1-2
select Names, Author, ReleaseDate, Price from bookstbl;

-- 2-1
select concat(right(Names,2),', ',left(Names,1)) as '변경이름',
	   Levels, left(Addr,2) as '도시',
	   lower(Email) as email
  from membertbl;

-- 2-2
select Idx,
	   concat(N'제목 : ',Names) as Names,
	   concat(N'저자 > ', Author) as Author,
	   format(ReleaseDate, 'yyyy년 MM월 dd일') as '출판일',
	   ISBN,
	   format(Price, '#,#원') as '가격'
  from bookstbl
  order by idx desc;

-- 3-1
select b.Idx as '번호',
	   b.Division as '장르번호',
	   d.names as '장르',
	   b.Names as '책제목',
	   b.Author as '저자'
  from bookstbl as b
  inner join divtbl as d
  on b.division = d.division
  where b.Division = 'B002';

-- 3-1 다르게 푸는 방법 (서브쿼리)
select b.Idx as '번호',
	   b.Division as '장르번호',
	   --d.names as '장르',
	   (select names from divtbl where Division = b.Division) as '장르',
	   b.Names as '책제목',
	   b.Author as '저자'
  from bookstbl as b
  where b.Division = 'B002';

-- 3-2
select m.Names, m.Levels, m.Addr, r.rentalDate
  from membertbl as m
  left outer join rentaltbl as r
  on m.idx = r.memberIdx
  where r.rentalDate is null;

-- 3-2 다르게 푸는 방법 (서브쿼리)
select m.Names
	 , m.Levels
	 , m.Addr
	 , null as rentaldate
  from membertbl as m
  where m.idx not in (select memberidx from rentaltbl as r);

-- 4-1
insert into divtbl values ('I002', '자기개발서')

-- 4-2
begin tran

update membertbl set Addr='부산시 해운대구', Mobile='010-6683-7732' where names='성명건';

rollback;
commit;

-- 5
select d.Names,sum(b.Price) as '총합계금액'
  from bookstbl as b 
  inner join divtbl as d
  on b.Division = d.Division
  group by d.Names with rollup;

-- 5 다르게 풀기
select (select names from divtbl where division = a.division) as names, a.sum_price as '총합계금액'
			  from  (select Division, sum(Price) as sum_price
			 from bookstbl
			 group by Division) as a
union all
select null, sum(price)
from bookstbl;