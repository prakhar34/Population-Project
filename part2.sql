select * from  dataset1;
select * from  dataset2; 
 
 -- joining both tables
 -- total males and females
 select d.state, sum(d.males) total_males, sum(d.females) total_females from
 (select c.district, c.state, round(c.population/(c.sex_ratio+1),0) males, round((c.population*c.sex_ratio)/(c.sex_ratio+1),0) females from
 (select a.district, a.state, a.sex_ratio/1000 sex_ratio, b.population from dataset1 a
 inner join dataset2 b
 on a.district = b.district) c) d
 group by d.state;
 
 -- total literacy rate
 select c.state, sum(literate_people) , sum(illiterate_people) from
(select d.district, d.state, round(d.literacy_ratio*d.population,0) literate_people, round((1-d.literacy_ratio)* d.population,0) illiterate_people from
(select a.district, a.state, a.Literacy/100 literacy_ratio, b.population from dataset1 a
 inner join dataset2 b
 on a.district = b.district) d) c group by c.state;
 
 -- population in previous census
 
 select sum(m.previous_census_population) previous_census_population, sum(m.current_census_population) current_census_population from
 (select e.state, sum(e.previous_census_population) previous_census_population, sum(e.current_census_population) current_census_population from 
 (select d.district, d.state, round(d.population/(1+d.growth)) previous_census_population, d.population current_census_population from
 (select a.district , a.state, a.growth, b.population from dataset1 a
 inner join dataset2 b
 on a.district = b.district) d) e
 group by e.state)m;
 
 
 -- population vs area
 
 
 select (g.total_area/g.previous_census_population) as previous_census_population_vs_area, (g.total_area/current_census_population) 
 as current_census_population_vs_area 
 from
 (select q.*, r.total_area from(
 select '1' as keyy, n.* from
 (select sum(m.previous_census_population) previous_census_population, sum(m.current_census_population) current_census_population from
 (select e.state, sum(e.previous_census_population) previous_census_population, sum(e.current_census_population) current_census_population from 
 (select d.district, d.state, round(d.population/(1+d.growth)) previous_census_population, d.population current_census_population from
 (select a.district , a.state, a.growth, b.population from dataset1 a
 inner join dataset2 b
 on a.district = b.district) d) e
 group by e.state)m) n) q inner join(
 
 select '1' as keyy , z.* from
 (select sum(area_km2) total_area from dataset2) z) r on q.keyy=r.keyy) g;
 
 
 -- window functions
 
 -- output -> top 3 districts from each state with highest literacy rate
 select a.* from
 (select district, state, literacy, rank() over(partition by state order by literacy desc) rnk from dataset1) a
 where a.rnk in (1,2,3) order by state