-- select * from  dataset1;
 select * from  dataset2;
 SELECT 
     COUNT(*)
 FROM
     dataset1;
     
 SELECT COUNT(*) FROM dataset2;

-- dataset from Jharkhand and Bihar
 select * from dataset1 where state in ('Jharkhand' , 'Bihar');

-- population of India
 select sum(population) from dataset2;

-- average growth


 select avg(growth)*100 avg_growth from dataset1;

 select state, avg(growth)*100 avg_growth from dataset1 group by state;

 select state, round(avg(sex_ratio),0) avg_sex_ratio from dataset1 group by state order by avg_sex_ratio desc;

select state, round(avg(literacy),0) avg_literacy_ratio from dataset1
  group by state having round(avg(literacy),0)>90 order by avg_literacy_ratio desc;
  
 select state, avg(growth)*100 avg_growth from dataset1 group by state order by avg_growth desc limit 3;
select state, avg(growth)*100 avg_growth from dataset1 group by state order by avg_growth asc limit 3;

-- top and bottom 3 states in literacy rate

--	drop table if exists #topstates;
 CREATE table #topstates(
 state nvarchar(255),
   topstate float
 )
 insert into #topstates
 select state, round(avg(literacy),0) avg_literacy_ratio from dataset1
 group by state order by avg_literacy_ratio desc;
 select * from #topstates order by #topstates.topstate desc limit 3;
 
-- drop table if exists #bottomstates;
create table #bottomstates
( state nvarchar(255),
   bottomstate float
 )
 insert into #bottomstates
 select state, round(avg(literacy),0) avg_literacy_ratio from dataset1
 group by state order by avg_literacy_ratio desc;
 select * from #topstates order by #topstates.topstate asc limit 3;

-- union operator
select * from (
select * from #topstates order by #topstates.topstate desc limit 3) a

union

select * from(
select * from #bottomstates order by #bottomstates.bottomstate asc limit 3) b;


-- starting with letter a

select distinct state from dataset1 where lower(state) 'a%' or lower(state) like 'b%'
select distinct state from dataset1 where lower(state) 'a%' and lower(state) like '%a';