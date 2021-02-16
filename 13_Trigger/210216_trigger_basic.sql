use sqlDB;
go

create or alter trigger trg_testtbl
on testtbl
after insert, delete, update -- 삭제, 수정할때 트리거 발생
as
	print '새트리거 발생';

insert into testtbl values ('BTS');
select * from testtbl where txt = '마마무뉴!';
update testtbl set txt = '마마무뉴!' where id = 6;
delete testtbl where id = 3;