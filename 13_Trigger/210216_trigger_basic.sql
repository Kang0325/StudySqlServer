use sqlDB;
go

create or alter trigger trg_testtbl
on testtbl
after insert, delete, update -- ����, �����Ҷ� Ʈ���� �߻�
as
	print '��Ʈ���� �߻�';

insert into testtbl values ('BTS');
select * from testtbl where txt = '��������!';
update testtbl set txt = '��������!' where id = 6;
delete testtbl where id = 3;