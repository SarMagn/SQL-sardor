use W3Resource

select * from INFORMATION_SCHEMA.TABLES
order by TABLE_NAME


--first 

select first_name + ' ' + last_name as Full_name, salary from HR.Employees
where salary <= 6000


--second


select first_name ,  last_name, department_id ,  salary from HR.Employees
where salary >= 8000

--third


select first_name ,  last_name, department_id  from HR.Employees
where last_name = 'McEwen'

--fourth

select * from HR.Employees
where department_id is null


--fifth

select * from HR.Departments 
where department_name = 'Marketing'

--sixth

select first_name + '  ' + last_name as full_name, hire_date, salary, department_id from hr.Employees
where first_name not like '%m%'

--seventh

select * from HR.Employees
where salary between 8000 and 12000 and hire_date < '2003-06-05' and department_id not in (40,120,70)


--eighth

select first_name + ' ' + last_name as FullName, salary from HR.Employees
where commission_pct < 0 

--ninth

select first_name + ' ' + last_name as FullName, salary , phone_number from HR.Employees
where salary between 9000 and 17000 

--tenth

select first_name, last_name, salary from HR.Employees
where first_name like '%m'

--eleventh

select first_name + ' ' + last_name as FullName, salary from HR.Employees
where salary between 7000 and 15000
order by fullName asc


--twelfth

select  first_name + ' ' + last_name as FullName, job_id,hire_date from HR.Employees
where hire_date between '2007-11-05' and '2009-07-05'

--thirteenth
select * from HR.Employees

select first_name + ' ' + last_name as FullName, department_id from HR.Employees
where department_id = 70 or department_id = 90

--fourteenth

select first_name + ' ' + last_name as FullName, salary, manager_id from HR.Employees
where manager_id <> 0 and manager_id is not null

--fifteenth
select * from HR.Employees


select * from HR.Employees
where hire_date < '2002-06-21'

--sixteenth

select first_name, last_name, email, salary, manager_id from HR.Employees
where manager_id in (120,130,145)

--seventeenth

select * from HR.Employees
where first_name like '%[D,S,N]%'
--where first_name like '%D%' or first_name like '%S%' or first_name like '%N%'
order by salary desc


--eighteenth

select first_name + ' ' + last_name as FullName, hire_date, commission_pct, email + ' - ' + phone_number as ContactDEtails, salary from HR.Employees
where salary > 11000 or phone_number like '______3%'
order by first_name desc

--Nineteenth

select first_name, last_name, department_id from HR.Employees
where first_name like '__s%'
  

--twentieth

select employee_id, first_name, job_id, department_id from HR.Employees
where department_id not in (50,30,80)


--Twenty-first

select employee_id, first_name, job_id, department_id from HR.Employees
where department_id in (30,40,90)

--Twenty-second



--Twenty-third


SELECT	* from HR.Employees

SELECT	job_id, count(employee_id) as count , SUM(salary) as sum, (MAX(salary) - MIN(salary)) as Difference from HR.Employees
group by job_id

--Twenty-fourth

SELECT	job_id  from HR.Employees
group by job_id
having COUNT(employee_id)>=2 

--Twenty-fifth

SELECT	country_id, COUNT(city) from HR.Locations
group by country_id

SELECT	* from HR.Locations

--Twenty-sixth


SELECT manager_id, COUNT(*) from HR.Employees
group by manager_id


--Twenty-seventh

select * from HR.Jobs
order by job_title desc


--Twenty-eighth
select * from HR.Jobs
select HE.first_name, HE.last_name,HE.hire_date   from HR.Employees as HE
left join HR.Jobs as hj on HE.job_id = hj.job_id
where hj.job_title = 'Sales Manager' or hj.job_title = 'Sales Representative'

--Twenty-ninth

select department_id ,AVG(salary) from HR.Employees
where commission_pct is not null 
group by department_id

--Thirtieth

select distinct department_id from HR.Employees
group by manager_id, department_id
having COUNT(manager_id) >= 4 

--thirty first

select department_id from HR.Employees
where commission_pct is not null
group by department_id
having COUNT(employee_id) >= 10

select * from HR.Employees

-- thirty second

select * from HR.Job_History

select Employee_id from HR.Job_History 
group by employee_id
having COUNT(employee_id) > 1


-- thirty third

select * from HR.Employees	
where commission_pct = 0 and salary between 7000 and 12000 and department_id = 50

-- thirty fourth

select job_id ,AVG(salary) from hr.Employees
group by job_id
having AVG(salary) > 8000

-- thirty fifth

select job_title, max_salary - min_salary as salary_difference from HR.Jobs
where max_salary between 12000 and 18000

-- thirty sixth

select * from HR.Employees
where first_name like 'D%' or last_name like 'D%'


-- thirty seventh 

select * from HR.Jobs
where min_salary > 9000


--thirty eighth

select * from HR.Employees
where hire_date > '1987-09-07'