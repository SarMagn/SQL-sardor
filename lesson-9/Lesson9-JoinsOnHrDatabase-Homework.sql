

select * from HR.Departments
select * from HR.Employees

--first

select ee.first_name, ee.last_name, ee.department_id, dd.department_name from HR.Employees ee
join HR.Departments dd on ee.department_id = dd.department_id

--second 

select ee.first_name, ee.last_name, dd.department_name, ll.city, ll.state_province from HR.Employees as ee
join HR.Departments as dd on ee.department_id = dd.department_id
join HR.Locations as ll on dd.location_id = ll.location_id

-- third

select * from HR.Job_Grades
select * from HR.Employees

select first_name, last_name, salary, case when salary between 1000 and 2999 then 'A'
											when  salary between 3000 and 5999 then 'B'
											when salary between 6000 and 9999 then 'C'
											when salary between  10000 and 14999 then 'D'
											when salary between 15000 and 24999 then 'E'
											when salary between 25000 and 40000 then 'F'  end as Grade from HR.Employees

select ee.first_name, ee.last_name, salary, jj.grade_level from HR.Employees as ee
join HR.Job_Grades as jj on ee.salary between jj.lowest_sal and jj.highest_sal


--fourth

select ee.first_name, ee.last_name, dd.department_id, dd.department_name from HR.Employees as ee
join HR.Departments as dd on ee.department_id = dd.department_id
where ee.department_id in (80,40)

--fifth

select ee.first_name, ee.last_name, dd.department_name, ll.city, ll.state_province from HR.Employees as ee
join HR.Departments as dd on ee.department_id = dd.department_id
join HR.Locations as ll on dd.location_id = ll.location_id 
where ee.first_name like '%z%'

--sixth

select ee.first_name, ee.last_name, dd.department_id, dd.department_name from HR.Departments as dd
left join HR.Employees as ee on dd.department_id = ee.department_id

--seventh

select first_name, last_name, salary from HR.Employees
where salary <  (select salary from HR.Employees
where employee_id = 182)

--eighth

select * from HR.Employees
order by hire_date

select ee.first_name, ee2.first_name from HR.Employees as ee 
join HR.Employees as ee2 on ee.manager_id = ee2.employee_id


--ninth

select department_name, ll.city , ll.state_province
from HR.Departments as dd
join HR.Locations as ll on dd.location_id = ll.location_id


--tenth

select ee.first_name, ee.last_name, dd.department_id, dd.department_name from HR.Departments as dd
left join HR.Employees as ee on dd.department_id = ee.department_id
order by ee.first_name 

--eleventh

--select ee1.first_name, ee2.first_name, ee1.employee_id as ee1_empid, ee1.manager_id as ee1man_id, ee2.employee_id as ee2empid, ee2.manager_id as ee2managerid  from HR.Employees as ee1 
--join HR.Employees as ee2 on ee1.manager_id =ee2.employee_id 


select ee1.first_name as emp_name, ee2.first_name as manager_name from HR.Employees as ee1 
left join HR.Employees as ee2 on ee1.manager_id =ee2.employee_id 

--twelfth

select first_name, last_name, department_id from HR.Employees   
where department_id in (select  department_id from HR.Employees 
where last_name = 'Taylor')


select * from HR.Employees as ee
join HR.Employees as ee2 on ee.department_id = ee2.department_id and ee2.last_name = 'Taylor'


--thirteenth

select hjj.job_title, hd.department_name, ee.first_name + ' ' + ee.last_name as EMloyee_name, ee.hire_date from HR.Employees as ee
join HR.Employees as ee2 on ee.department_id = ee2.department_id 
join HR.Job_History as jh on ee.employee_id = jh.employee_id 
join HR.Jobs as hjj on jh.job_id = hjj.job_id
join HR.Departments as hd on ee.department_id = hd.department_id
where ee2.hire_date > '1993-01-01' or ee2.hire_date < '1997-08-31'


--fourteenth

select j.job_title, e.first_name + '  ' + e.last_name as EmployeeName, j.max_salary - e.salary as SalaryDifference  from HR.Employees as e
join HR.Jobs as j on e.job_id = j.job_id 


--fifteenth

select d.department_name, AVG(salary) as avgSalary, COUNT(employee_id) as CountofEmployee from HR.Employees as e
join HR.Departments  as d on e.department_id = d.department_id
group by d.department_name 

--sixteenth

select j.job_title, e.first_name + ' ' + e.last_name as Employee_name ,j.max_salary - e.salary as Difference from hr.Employees as e
join HR.Jobs as j on e.job_id = j.job_id 
where e.department_id = 80 

--seventeenth

select c.country_name, l.city,  d.department_name from HR.Countries as c
join HR.Locations as l on c.country_id = l.country_id
join HR.Departments as d on l.location_id = d.location_id	

--eighteenth

select d.department_name, e.first_name + ' ' + e.last_name as NameofManager from HR.Departments as d
join HR.Employees as e on d.manager_id = e.employee_id

--ninteenth

select j.job_title, AVG(salary) as avg from HR.Employees as e
join HR.Jobs as j on e.job_id = j.job_id
group by j.job_title

--twentieth

select e.employee_id, j.start_date, j.end_date, j.job_id, j.department_id from HR.Employees as e
join HR.Job_History as j on e.employee_id =  j.employee_id
where salary >= 12000

--twenty first 

--21 dan boshlab davom ettiraman kyn