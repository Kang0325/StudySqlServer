/*
select * from stdTBL;
select * from clubTBL;
select * from clubRegTBL;
*/

--Stander SQL
select * from stdTBL as s
  inner join clubRegTBL as r
  on s.id= r.std_id
  inner join clubTBL as c
  on r.club_id = c.id;

--inner join 약식(SQL Server T-SQL)
select s.id, s.stdName, c.clubName, c.buildingNum
	from stdTBL as s,clubRegTBL as r,clubTBL as c
	where s.id = r.std_id
	and r.club_id = c.id;

--outer join (외부 조인)
select s.id, s.stdName, c.clubName, c.buildingNum from stdTBL as s
  left outer join clubRegTBL as r
  on s.id= r.std_id
  left outer join clubTBL as c
  on r.club_id = c.id;

--userTBL/buyTBL
select u.userName, u.addr, b.prodName, b.price
	from userTBL as u
	right outer join buyTBL as b
	on u.userID = b.userID;


--테이블 3개 outer join
select * 
  from StdTBl as s
  left outer join ClubRegTbl as r
    on s.id = r.std_id
  full outer join ClubTbl as c
    on r.club_id = c.id;

select * 
  from StdTBl as s
  left outer join ClubRegTbl as r
    on s.id = r.std_id;

select * 
  from ClubRegTbl as r
 right outer join ClubTbl as c
    on r.club_id = c.id;