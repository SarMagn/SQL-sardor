use W3Resource

--Question 1

select * from Employee.employees


select * from Employee.employees
where salary > (
select salary from Employee.employees
where job_name = 'President'
)/2 and  job_name <> 'President'

--Question 2
select * from Movies.Movie
where mov_year < (select mov_year from Movies.Movie where mov_title like 'The Shawshank Redemption%')
			and mov_time > (select mov_time from Movies.Movie where mov_title like 'The Shawshank Redemption%')
			and mov_lang = 'English'

--Question 3 
select * from SOCCER.match_details

with cte as (
select * from SOCCER.match_details
where team_id = '1208')
select team_id , goal_score from cte
join SOCCER.match_details as m on m.goal_score > cte.count1


select team_id, sum(goal_score) as goals from SOCCER.match_details
group by team_id 
having sum(goal_score) > (select sum(goal_score) from SOCCER.match_details where team_id = '1208' group by team_id)
order by goals



select team_id, count(goal_score) from SOCCER.match_details
group by team_id

--Question 4 

select he.* from HR.Employees as he
join hr.Employees as he2 on he.manager_id = he2.employee_id and he.manager_id = 
							(select employee_id from HR.Employees where first_name ='Gerald' and last_name = 'Cambrault')

--Question 5 

select he.employee_id, first_name, last_name, job_id, manager_id, he.department_id, he1.employee_id,he1.department_id from HR.Employees as he, (select employee_id,department_id from HR.Employees) as he1
where he.manager_id = he1.employee_id and he.department_id = he1.department_id

--Question 6 
select he2.first_name + ' ' + he2.last_name  as Manager_name, SUM(he.salary) as Total_salary from HR.Employees as he
join  hr.Employees as he2 on he.manager_id = he2.employee_id 
group by he2.first_name, he2.last_name
ORDER by Total_salary desc



select * from HR.Employees as he
join  hr.Employees as he2 on he.manager_id = he2.employee_id 



