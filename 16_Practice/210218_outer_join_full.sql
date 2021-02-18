-- outer join 쿼리
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