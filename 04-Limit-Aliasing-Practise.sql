Select * from employee_demographics;

#---- Limit
Select * from employee_demographics
limit 5;

select* from employee_demographics
order by age desc
limit 5;


#1 starting position and selecting exact position
#limit(n-1,1) for finding exact rank
select * from employee_salary
order by employee_id asc
limit 3,2;   # here the starting position is 3 (skip1-2-3) and it will limit 2 records

select * from employee_salary
order by salary asc
limit 0,1; # here it will starting position is 0 record(skip0) and it will limit upto 5 records


#2Limit with group by
select salary,count(*)
from employee_salary
group by salary
order by  salary asc
limit 5;

select salary, count(*)
from employee_salary
group by salary
order by salary asc
limit 2,8;

#Get top 3 salaries particular department
select * from employee_salary
where occupation='office manager'
order by salary asc
limit 3;


#select nth highest salary	using limit
#limit 1 offset (n-1) if we need n th rank same with //(n-1,1)//
select * from employee_salary
order by employee_id
limit 1 offset 4; #gives 5 th rank

select * from employee_salary
order by salary desc
limit 1 offset 2;

# --ALiasing
 select max(salary),occupation from employee_salary
 group by occupation;
  
# 1-where will not use alias
select count(*) as count,occupation as tr from employee_salary
where occupation="Office Manager"
group by tr
having count=2 ;#here tr doesn't work in "where" since where runs before select 
#whereas having runs after select clause\

# 2-order by use alias
select count(*) as count, occupation as department from employee_salary
group by department
order by count;

#3-group-by and having will not use alias
/*
THE SQL EXECUTION
1>>FROM
2>>WHERE
3>>GROUP BY
4>>HAVING
5>>SELECT
6>>ORDER BY
7>>LIMIT  
your alias is never used by GROUP BY at all.
It’s just replaced by the original expression.
""""Non-standard alias resolution with expression substitution""""
You write this:

SELECT salary * 12 AS annual_salary
FROM employee_salary
GROUP BY annual_salary;

--->> MySQL silently rewrites it internally to this:
SELECT salary * 12 AS annual_salary
FROM employee_salary
GROUP BY salary * 12;
*/
select salary*10 as sal
from employee_salary
group by sal;