# --->GROUP BY
/* any column we selected must in -->
In the GROUP BY clause, or
Aggregated (SUM, AVG, MIN, MAX, etc.)*/

select * from employee_demographics;

select gender from employee_demographics
group by gender;

select gender from employee_demographics
where gender ='Male'
group by gender; # work sane as distinct


#aggregate function
select gender, count(*) from employee_demographics
group by gender;

select gender,avg(age) as average_age, max(age), min(age)parks_departmentsparks_departmentsemployee_demographics from employee_demographics
group by gender;

#counting employees bu department but excluding one dept
select occupation, count(*) from employee_salary
where occupation!='entrepreneur'
group by occupation;

#averege age of person who born after 1985
select avg(age),birth_date as year from employee_demographics
where extract(year from birth_date) >=1980
group by birth_date;

#no of people born per year only age >35
select date_format(birth_date,'%Y') as year, COUNT(*)
FROM employee_demographics
where age>35
group by birth_date;


###group-by with having

# 1 Departments with more than n employees
select occupation,count(*) as count
from employee_salary
group by occupation
having count(*) >=2;

#2 Departments where average salary > 75k
select occupation , avg(salary) 
from employee_salary
group by occupation
having avg(salary) >70000;

#3 Department with max salary is twicethe lowest salary
select occupation, max(salary) ,min(salary)
from employee_salary
group by occupation
having max(salary)=2 *(min(salary));

#4 String--function
/*
!!!LEFT(STR,N)
!!!RIGHT(STR,N)
!!!SUBSTR(STR,POS,LEN)
*/
select left(first_name,1) from employee_demographics;
select left(first_name,2) from employee_demographics;
select right(first_name,1) from employee_demographics;
select right(first_name,2) from employee_demographics;
select substr(first_name,1,3) from employee_demographics;
select substr(first_name,length(first_name)-3+1,3) from employee_demographics;

# 4 extracting the name with same first letter and counting
select left(first_name,1), count(*)
from employee_demographics
group by left(first_name,1)
having count(*) =2;

## both having and where
select occupation, avg(salary)
from employee_salary
where occupation like '%manager%'
group by occupation
having avg(salary) >55000;


###--- Order by

select first_name,salary
from employee_salary
order by salary asc;

select occupation, max(salary)
from employee_salary
group by occupation
order by max(salary) desc;

#Multiple-Columns
select first_name,occupation,salary
from employee_salary
order by occupation asc , salary desc;

#Order by with conditions

#1 Bring nurse occupation first <giving priority>
select occupation,salary
from employee_salary
order by
Case
when occupation='nurse' then 1
else 2
end,
occupation desc,
salary asc;
 
 #2 Salary Range Priority
 #Sort employees so that Salary > 70000 comes first, then 50000–70000, then <50000. 
 #Within each range, sort by Dept ascending.
  select salary, occupation
  from employee_salary
  order by
  case
  when salary>70000 then 1
  when salary between 50000 and 70000 then 2
  when salary <50000 then 3
  end,
  salary desc,
  occupation asc;