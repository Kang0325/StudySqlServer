use sqldB;
go

declare cur_usertbl CURSOR GLOBAL
	for select userName, height from usertbl;

open cur_usertbl;

declare @userName nchar(8); -- ȸ���̸�
declare @height smallint; -- ȸ���� Ű ��� ����
declare @cnt int = 0; -- ȸ���� (���� ���)
declare @totalHeight int = 0; -- ȸ���� Ű �հ� ����

fetch next from cur_usertbl into @userName, @height; -- Ŀ�� �� �о @height ������ �Ҵ�

-- �ݺ��� ����
while @@FETCH_STATUS = 0
begin
	set @cnt += 1;
	set @totalHeight += @height;
	print concat('ȸ�� : ', @userName, ' Ű : ', @height);
	fetch next from cur_usertbl into @userName, @height;
end

print @totalheight;
print @cnt;
print concat('ȸ�� Ű ����� => ', @totalHeight / @cnt);

close cur_usertbl;
deallocate cur_usertbl;