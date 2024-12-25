use W3Resource


select * from SOCCER.player_mast
where age = (select top 1 * from (select distinct top 3 age from SOCCER.player_mast
order by age desc) as b order by age asc)

--case when 
select country_id, country_name,  case when region_id = 1 then 'One'
				when region_id = 2 then 'Two'
				when region_id = 3 then 'Three' 
				when region_id = 4 then 'Four' end AS Region_id from HR.Countries 


select country_id, country_name, IIF(region_id = 1, 'One',
								IIF(region_id=2,'Two',
								IIF(region_id=3,'Three',
								'Four'))) as region_id from HR.Countries


select region_id, country_name, country_id from HR.Countries
union all
select * , case when region_name = 'Europe' then 'EU'
                                when region_name = 'Americas' then 'AM'
								when region_name = 'Asia' then 'AS'
								when region_name = 'Middle East and Africa' then 'ME' end from  HR.Regions
								order by region_id
select * from HR.Regions


select * from HR.Countries 
order by case when country_name = 'Denmark' then 0 else 1 end, country_name desc



