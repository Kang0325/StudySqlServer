-- ���� ȸ������ �ҷ����� �̸���
select memberid,membername,levels,mobile,email
  from membertbl
  where levels <> 's'
  order by levels asc, membername asc;

-- å����
select cateidx,bookname,author,interpreter,company,price
  from bookstbl
  order by price desc;

select * from catetbl;

-- �ý��� �Լ���� ����
select memberid,
	   mobile,
	   concat ( right(membername,2), ', ', left (membername,1) ) as '�̱����̸�',
	   case levels
			when 'a' then '���ȸ��'
			when 'b' then '�ǹ�ȸ��'
			when 'c' then '�����ȸ��'
			when 'd' then '���̾�ȸ��'
			when 's' then '������'
			else '��ȸ��'
	   end as 'ȸ������',
	   upper(email) as '�̸���'
from membertbl
where levels <> 's'
order by levels, membername;

-- ����� ���� ���� �Լ�
create or alter function dbo.ufn_getlevel (@levels char(1))
returns nvarchar(5)
as
begin
	declare @result nvarchar(5); -- ���,�ǹ�,�����,���̾�ȸ�� �� ����

	set @result = case @levels
					when 'a' then '���ȸ��'
					when 'b' then '�ǹ�ȸ��'
					when 'c' then '�����ȸ��'
					when 'd' then '���̾�ȸ��'
					when 's' then '������'
					else '��ȸ��'
				  end;
	return @result;
end
go

-- ����� ���� �Լ���� ����
select memberid,
	   mobile,
	   concat ( right(membername,2), ', ', left (membername,1) ) as '�̱����̸�',
	   dbo.ufn_getlevel(levels) as 'ȸ������',
	   upper(email) as '�̸���'
from membertbl
where levels <> 's'
order by levels, membername;

-- å ����, �ý��� �Լ�, ���� �Լ� ����
SELECT bookidx
      ,cateidx
      ,concat(N'å���� > ',bookname) as bookname
      ,author
      ,isnull(interpreter, '(���ھ���)') as '������'
      ,company
      ,format(releasedate, 'yyyy�� MM�� dd��') as '������'
      ,format(price, '#,#.00��') as '����'
  FROM bookstbl

-- å ���� ����
SELECT b.bookidx
      --b.cateidx
	  ,c.catename
      ,b.bookname
      ,b.author
      ,b.interpreter
      ,b.company
  FROM dbo.bookstbl as b
inner join catetbl as c
	on b.cateidx = c.cateidx;

-- �뿩�� å�� ���� ���� ����
SELECT r.rentalidx
      --,r.memberidx
      --,r.bookidx
	  ,m.membername
	  ,b.bookname
	  ,b.author
      ,format(r.rentaldt, 'yyyy-MM-dd') as '�뿩��'
      ,format(r.returndt, 'yyyy-MM-dd') as '�ݳ���'
      ,dbo.ufn_getstate(r.rentalstate) as '�뿩����'
  FROM dbo.rentaltbl as r
inner join bookstbl as b
	on r.bookidx = b.bookidx
inner join membertbl as m
	on r.memberidx = m.memberidx;

-- å�� �� ���� ȸ�� ��ȸ
SELECT r.rentalidx
      --,r.memberidx
      --,r.bookidx
	  ,m.membername
	  ,b.bookname
	  ,b.author
      ,format(r.rentaldt, 'yyyy-MM-dd') as '�뿩��'
      ,dbo.ufn_getstate(r.rentalstate) as '�뿩����'
  FROM dbo.rentaltbl as r
left outer join bookstbl as b
	on r.bookidx = b.bookidx
right outer join membertbl as m
	on r.memberidx = m.memberidx
where r.rentalidx is null;

-- �츮 å �뿩���� ���� �Ҽ� �帣
select c.cateidx,
	   c.catename,
	   b.bookname
  from catetbl as c
left outer join bookstbl as b
	on c.cateidx = b.cateidx;