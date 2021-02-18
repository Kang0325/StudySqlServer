-- 1-1

select lower(Email) as Email, Mobile, names, addr
from membertbl
order by names desc;


-- 1-2

select Names, Author, ReleaseDate, price from bookstbl


-- 2-1

select top 10
	concat(right(names,2),', ',left(names,1)) as 변경이름,
	Levels,
	left(addr,2) as 도시,
	lower(email) as 이메일
from membertbl;


-- 2-2

select
Idx,
concat(N'제목 : ', Names) as Names,
concat(N'저자 > ', Author) as Author,
format(ReleaseDate, 'yyyy년 MM월 dd일') as '출판일',
ISBN,
Price
from bookstbl
order by Idx desc;


-- 3-1

select
b.Idx as 번호,
b.Division as '장르번호',
d.Names as '장르',
b.Names,
b.Author as '저자'
from bookstbl as b 
inner join divtbl as d
on b.Division = d.Division
where d.Names = '로맨스';


-- 3-2

select
m.Names,
m.Levels,
m.Addr,
r.rentalDate
from membertbl as m
left outer join rentaltbl as r
	on m.idx = r.memberIdx
where rentalDate is null;


-- 4-1

begin tran;

insert into divtbl
values ('I002','자기개발서');

select * from divtbl;

rollback;
commit;


-- 4-2

select * from membertbl
update membertbl set Addr='부산시 해운대구' where names='성명건';
update membertbl set Mobile='010-6683-7732' where names='성명건';


-- 5

select
d.names,
sum(b.price) as 총합계금액
from divtbl as d
inner join bookstbl as b
on d.Division = b.Division
group by d.Names with rollup;
