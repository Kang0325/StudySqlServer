-- 실제 회원정보 불러오기 이름순
select memberid,membername,levels,mobile,email
  from membertbl
  where levels <> 's'
  order by levels asc, membername asc;

-- 책정보
select cateidx,bookname,author,interpreter,company,price
  from bookstbl
  order by price desc;

select * from catetbl;

-- 시스템 함수사용 쿼리
select memberid,
	   mobile,
	   concat ( right(membername,2), ', ', left (membername,1) ) as '미국식이름',
	   case levels
			when 'a' then '골드회원'
			when 'b' then '실버회원'
			when 'c' then '브론즈회원'
			when 'd' then '아이언회원'
			when 's' then '관리자'
			else '비회원'
	   end as '회원레벨',
	   upper(email) as '이메일'
from membertbl
where levels <> 's'
order by levels, membername;

-- 사용자 레벨 리턴 함수
create or alter function dbo.ufn_getlevel (@levels char(1))
returns nvarchar(5)
as
begin
	declare @result nvarchar(5); -- 골드,실버,브론즈,아이언회원 등 변수

	set @result = case @levels
					when 'a' then '골드회원'
					when 'b' then '실버회원'
					when 'c' then '브론즈회원'
					when 'd' then '아이언회원'
					when 's' then '관리자'
					else '비회원'
				  end;
	return @result;
end
go

-- 사용자 정의 함수사용 쿼리
select memberid,
	   mobile,
	   concat ( right(membername,2), ', ', left (membername,1) ) as '미국식이름',
	   dbo.ufn_getlevel(levels) as '회원레벨',
	   upper(email) as '이메일'
from membertbl
where levels <> 's'
order by levels, membername;

-- 책 정보, 시스템 함수, 포맷 함수 쿼리
SELECT bookidx
      ,cateidx
      ,concat(N'책제목 > ',bookname) as bookname
      ,author
      ,isnull(interpreter, '(역자없음)') as '번역가'
      ,company
      ,format(releasedate, 'yyyy년 MM월 dd일') as '출판일'
      ,format(price, '#,#.00원') as '가격'
  FROM bookstbl

-- 책 정보 조인
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

-- 대여된 책의 정보 쿼리 조인
SELECT r.rentalidx
      --,r.memberidx
      --,r.bookidx
	  ,m.membername
	  ,b.bookname
	  ,b.author
      ,format(r.rentaldt, 'yyyy-MM-dd') as '대여일'
      ,format(r.returndt, 'yyyy-MM-dd') as '반납일'
      ,dbo.ufn_getstate(r.rentalstate) as '대여상태'
  FROM dbo.rentaltbl as r
inner join bookstbl as b
	on r.bookidx = b.bookidx
inner join membertbl as m
	on r.memberidx = m.memberidx;

-- 책을 안 빌린 회원 조회
SELECT r.rentalidx
      --,r.memberidx
      --,r.bookidx
	  ,m.membername
	  ,b.bookname
	  ,b.author
      ,format(r.rentaldt, 'yyyy-MM-dd') as '대여일'
      ,dbo.ufn_getstate(r.rentalstate) as '대여상태'
  FROM dbo.rentaltbl as r
left outer join bookstbl as b
	on r.bookidx = b.bookidx
right outer join membertbl as m
	on r.memberidx = m.memberidx
where r.rentalidx is null;

-- 우리 책 대여점에 없는 소설 장르
select c.cateidx,
	   c.catename,
	   b.bookname
  from catetbl as c
left outer join bookstbl as b
	on c.cateidx = b.cateidx;