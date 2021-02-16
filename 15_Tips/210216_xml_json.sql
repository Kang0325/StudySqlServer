select u.userID, u.username, u.birthyear, u.addr, u.height, b.prodName, b.price from userTBl as u
inner join buytbl as b
on u.userID = b.userID
where height > 170
for json auto;