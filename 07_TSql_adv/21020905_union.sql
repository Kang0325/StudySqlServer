--union
select clubName, buildingNum from clubtbl
union
select stdName, region from stdtbl;

--union all
select clubName, buildingNum from clubtbl
union
select stdName, region from stdtbl;

--except
select clubName as bName, buildingNum as bLocation from clubtbl
except
select stdName, region from stdtbl;