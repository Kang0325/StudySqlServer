USE [sqlDB]
GO
/****** Object:  StoredProcedure [dbo].[usp_users]    Script Date: 2021-02-15 오후 2:12:03 ******/
create or alter procedure usp_users4
	@txtvalue nvarchar(20),
	@outvalue int output
as
	insert into testTBL values (@txtvalue);
	select @outvalue = IDENT_CURRENT('testTBL'); --testTBL 현재 identity값 리턴
go

declare @pout int;
exec usp_users4 '새로운 텍스트', @pout output;

print concat('현재 입력된 값은 ==> ', @pout);
select @pout as '현재값';