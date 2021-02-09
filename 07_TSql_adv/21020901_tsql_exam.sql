use sqlDB;

declare @myVar1 int;
declare @myVar2 smallint, @myVar3 decimal(5,2);
declare @myVar4 char(20);

set @myVar1=154234521;
set @myVar2=32450;
set @myVar3=3.14;
set @myVar4='가수 이름==>    ';

select @myVar1;
select @myVar2 + @myVar3;
select @myVar4, userName from userTBL where height >180;

declare @myVar5 tinyint; --255
set @myVar5=3;
select top(@myVar5) userName, height from userTbl order by height desc;

--형 변환함수
select convert(float, amount) from buyTbl;
select TRY_CONVERT(float, amount) as amount from buyTbl;
select avg(convert(float, amount)) as '평균구매개수' from buyTbl;

select price, amount, price/amount as [단가/수량] from buyTbl;

--
select parse('2021년 2월 9일' as date);
select try_parse('2021년 2월 39일' as date);

select parse('123.45' as decimal(5,2));
select try_parse('123.45' as float);

select cast('11' as int);

--스칼라함수(단일 리턴함수)
select GETDATE() as '현재 날짜';

select year(GETDATE()) as '금년';
select month(GETDATE()) as '이번 달';
select day(GETDATE()) as '오늘';

select abs(-100);

select round(3.1415,3);
select round(1234.5678,-1);

select cast((rand()*100) as int);

select iif(20>10,'참','거짓');

--문자열함수
select ascii('a'), ascii('A');
select char(98), char(66);
select unicode('나');
select nchar(45909);

--진짜진짜 많이쓰이는거
--문자열 결함
select concat('Microsoft ', 'SQL ', 'Server ', 2019);
--문자열 시작위치 리턴
select charindex('Server', 'SQL Server 2019');
--left, right
select left('SQL Server 2019',3), right('SQL Server 2019',4);
--substring
select SUBSTRING('Hello World!',7,5);
select SUBSTRING('안녕하세요, SQL서버입니다!', 11,2);
--len
select len('안녕하세요'), len('Hello World!');
--lower, upper
select lower('abcdeFG'), upper('abcdeFG');
--ltrim, rtrim
select len(LTRIM('  Hello World!   ')),
	   len(RTRIM('  Hello World!   ')),
	    len(TRIM('  Hello World!   '));

select replace('SQL Server 2016', '2016', '2019');

--진짜진짜진짜진짜진짜진짜진짜 많이 쓰는 함수
select format(getdate(),''); --기본
select format(getdate(),'dd/MM/yyyy');
select format(getdate(),'yyyy-MM-dd hh:mm:ss:ms');
select format(getdate(),'yyyy-MM-dd');
select format(getdate(),'hh:mm:ss');
select getdate();