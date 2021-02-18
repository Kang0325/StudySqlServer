create or alter view uv_nonerentalmemeber
as
		SELECT r.rentalidx
		  --,r.memberidx
		  ,m.membername
		  --,r.bookidx
		  --,b.cateidx
		  ,c.catename
		  ,b.bookname
		  ,b.author
		  ,format(r.rentaldt, 'yyyy-MM-dd') as '�뿩��'
		  ,format(r.returndt, 'yyyy-MM-dd') as '�ݳ���'
		  ,dbo.ufn_getstate(r.rentalstate) as '�뿩����'
	  FROM dbo.rentaltbl as r
	right outer join membertbl as m
	on r.memberidx = m.memberidx
	left outer join bookstbl as b
	on r.bookidx = b.bookidx
	left outer join catetbl as c
	on b.cateidx = c.cateidx

	where r.rentalidx is null;
go

-- ������ �Է�
insert into bookstbl
(
	cateidx,
	bookname,
	author,
	company,
	releasedate,
	isbn,
	price
)
values
(
	'N0002',
	'�������� ���� ����',
	'��ȳ�',
	'������',
	'2019-10-02',
	'9791135445705',
	12500
);

-- å ���̺� �� å ���� �� ����, ������� ����
begin tran;
update bookstbl
   set descriptions = '�θ�׷��� �극������ �ٽ� TF�� ����, ���¿� ����.',
	   regdate = '2021-02-18'
	where bookidx = 14;

rollback;
commit;

-- ī�װ� �Է�
begin tran;

insert into catetbl
values ('I0001','��ȭ/����'),('I0002','����/ó��'),('I0003','�ð�����');

select * from catetbl;

rollback;
commit;
-- ī�װ� ����
delete from catetbl where cateidx = 'I0003';

delete from catetbl where cateidx in ('i0002','i0001');