declare @year int; -- �⵵ ����
set @year = 1980; -- �� 1980�� ����

if @year >= 1980
begin
	select * from usertbl where birthyear >= @year;
end
else
begin
	print '�˻��� �� �� �����ϴ�.';
end