use sqlDB;
go

create table xmlTbl (id int primary key identity, xmlcol xml);

insert into xmlTbl values ('Hello World');

select * from xmlTbl;

insert into xmlTBl values ('<html><body><p>Sample HTML</p></body></html>');
insert into xmlTBl values ('<html><body><p>Sample HTML</body></html>');