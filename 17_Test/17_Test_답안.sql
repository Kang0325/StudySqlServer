-- 1-1
select lower(email) as Email, Mobile, Names, Addr from membertbl
order by names desc;

-- 1-2
select Names, Author, ReleaseDate, Price from bookstbl;

-- 2-1
select concat(right(Names,2),', ',left(Names,1)) as '�����̸�',
	   Levels, left(Addr,2) as '����',
	   lower(Email) as email
  from membertbl;

-- 2-2
select Idx,
	   concat(N'���� : ',Names) as Names,
	   concat(N'���� > ', Author) as Author,
	   format(ReleaseDate, 'yyyy�� MM�� dd��') as '������',
	   ISBN,
	   format(Price, '#,#��') as '����'
  from bookstbl
  order by idx desc;

-- 3-1
select b.Idx as '��ȣ',
	   b.Division as '�帣��ȣ',
	   d.names as '�帣',
	   b.Names as 'å����',
	   b.Author as '����'
  from bookstbl as b
  inner join divtbl as d
  on b.division = d.division
  where b.Division = 'B002';

-- 3-1 �ٸ��� Ǫ�� ��� (��������)
select b.Idx as '��ȣ',
	   b.Division as '�帣��ȣ',
	   --d.names as '�帣',
	   (select names from divtbl where Division = b.Division) as '�帣',
	   b.Names as 'å����',
	   b.Author as '����'
  from bookstbl as b
  where b.Division = 'B002';

-- 3-2
select m.Names, m.Levels, m.Addr, r.rentalDate
  from membertbl as m
  left outer join rentaltbl as r
  on m.idx = r.memberIdx
  where r.rentalDate is null;

-- 3-2 �ٸ��� Ǫ�� ��� (��������)
select m.Names
	 , m.Levels
	 , m.Addr
	 , null as rentaldate
  from membertbl as m
  where m.idx not in (select memberidx from rentaltbl as r);

-- 4-1
insert into divtbl values ('I002', '�ڱⰳ�߼�')

-- 4-2
begin tran

update membertbl set Addr='�λ�� �ؿ�뱸', Mobile='010-6683-7732' where names='�����';

rollback;
commit;

-- 5
select d.Names,sum(b.Price) as '���հ�ݾ�'
  from bookstbl as b 
  inner join divtbl as d
  on b.Division = d.Division
  group by d.Names with rollup;

-- 5 �ٸ��� Ǯ��
select (select names from divtbl where division = a.division) as names, a.sum_price as '���հ�ݾ�'
			  from  (select Division, sum(Price) as sum_price
			 from bookstbl
			 group by Division) as a
union all
select null, sum(price)
from bookstbl;