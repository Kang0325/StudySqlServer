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
		  ,format(r.rentaldt, 'yyyy-MM-dd') as '대여일'
		  ,format(r.returndt, 'yyyy-MM-dd') as '반납일'
		  ,dbo.ufn_getstate(r.rentalstate) as '대여상태'
	  FROM dbo.rentaltbl as r
	right outer join membertbl as m
	on r.memberidx = m.memberidx
	left outer join bookstbl as b
	on r.bookidx = b.bookidx
	left outer join catetbl as c
	on b.cateidx = c.cateidx

	where r.rentalidx is null;
go

-- 데이터 입력
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
	'순수하지 않은 감각',
	'요안나',
	'로코코',
	'2019-10-02',
	'9791135445705',
	12500
);

-- 책 테이블 위 책 정보 중 설명, 등록일자 수정
begin tran;
update bookstbl
   set descriptions = '부명그룹의 브레인이자 핵심 TF팀 리더, 강태욱 수석.',
	   regdate = '2021-02-18'
	where bookidx = 14;

rollback;
commit;

-- 카테고리 입력
begin tran;

insert into catetbl
values ('I0001','대화/협상'),('I0002','성공/처세'),('I0003','시간관리');

select * from catetbl;

rollback;
commit;
-- 카테고리 삭제
delete from catetbl where cateidx = 'I0003';

delete from catetbl where cateidx in ('i0002','i0001');