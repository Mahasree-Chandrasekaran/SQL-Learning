SELECT * FROM parks_and_recreation.employee_demographics;

Select first_name, last_name from employee_demographics;
Select first_name, last_name, 'active' as status from employee_demographics;

#Distinct
select  distinct gender from employee_demographics;
select distinct dept_id, salary from employee_salary;

#Concatenation
Select concat(first_name," ",last_name) as full_name from employee_demographics;
Select concat(first_name,' ',last_name,' ','works here ') as full_name from employee_demographics;

#Duplication
Select first_name, first_name from employee_demographics;

#Literal boolean
Select first_name, (gender='Female') as Status from employee_demographics;



