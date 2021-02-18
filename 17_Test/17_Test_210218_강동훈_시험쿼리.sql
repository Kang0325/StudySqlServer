-- 1-1

select lower(Email) as Email, Mobile, names, addr
from membertbl
order by names desc;


-- 1-2

select Names, Author, ReleaseDate, price from bookstbl


-- 2-1

select top 10
	concat(right(names,2),', ',left(names,1)) as �����̸�,
	Levels,
	left(addr,2) as ����,
	lower(email) as �̸���
from membertbl;


-- 2-2

select
Idx,
concat(N'���� : ', Names) as Names,
concat(N'���� > ', Author) as Author,
format(ReleaseDate, 'yyyy�� MM�� dd��') as '������',
ISBN,
Price
from bookstbl
order by Idx desc;


-- 3-1

select
b.Idx as ��ȣ,
b.Division as '�帣��ȣ',
d.Names as '�帣',
b.Names,
b.Author as '����'
from bookstbl as b 
inner join divtbl as d
on b.Division = d.Division
where d.Names = '�θǽ�';


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
values ('I002','�ڱⰳ�߼�');

select * from divtbl;

rollback;
commit;


-- 4-2

select * from membertbl
update membertbl set Addr='�λ�� �ؿ�뱸' where names='�����';
update membertbl set Mobile='010-6683-7732' where names='�����';


-- 5

select
d.names,
sum(b.price) as ���հ�ݾ�
from divtbl as d
inner join bookstbl as b
on d.Division = b.Division
group by d.Names with rollup;
