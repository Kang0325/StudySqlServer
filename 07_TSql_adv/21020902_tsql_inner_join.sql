select * from userTBL;
select * from buyTBL;

select * from userTBL where userID = 'JYP';
select * from buyTBL where userID = 'JYP';

select * from buyTBL where userID = 'BBK';

--inner join
select u.userName, u.addr,
	concat(u.mobile1, '-', left(u.mobile2,4), '-', RIGHT(u.mobile2,4)) as mobile,
		   b.prodName, b.price, b.amount
	from buyTBL as b
	inner join userTBL as u
	on b.userID = u.userID
	where b.userID = 'JYP';