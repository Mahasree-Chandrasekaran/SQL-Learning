Select *from employee_demographics;
select* from employee_salary;

 #Where - ExactMatch
 Select * from employee_salary where first_name='Leslie';
 Select  *from employee_demographics where age=43;
 
 #Number Comparison
 Select * from employee_demographics where age >35;
 Select * from employee_demographics where birth_date < '1985-01-01';
 
#Multiple-AND
Select * from employee_salary where salary >=50000 and occupation ='Office Manager'; 
Select * from employee_demographics where gender='Male' and age>30;

#Condition-OR
Select * from employee_demographics where age =36 or age>36;
Select * from employee_demographics where gender='female' or age=36;
Select * from employee_salary where salary = 50000 or dept_id=3;

#IN, NOT IN, Between and not between operator
select * from employee_salary where occupation in ('entrepreneur','office manager');
Select * from employee_demographics where  gender not in ('female');
Select * from employee_demographics where age not in (36,61,40);
Select * from employee_demographics where age between 30 and 40;
SElect * from employee_demographics where birth_date not between '1987-01-01' and '1988-12-31';

#Like operator
Select * from employee_demographics where first_name like 'l%' or first_name like'A%' or last_name like 'l%';
#names exactly with onle one vowel with both firstname and lastname
Select concat(first_name,' ',last_name) as full_name from employee_demographics
where
concat(first_name,' ',last_name) like '%a%' or
concat(first_name,' ',last_name) like '%e%' or 
concat(first_name,' ',last_name) like '%i%' or
concat(first_name,' ',last_name) like '%o%' or
concat(first_name,' ',last_name) like '%u%' ;
Select * from employee_demographics where last_name like 'k____';
Select * from employee_demographics where last_name like '%e';
Select * from employee_demographics where first_name like'a__%';


/*regexp-pattern [Symbol	Meaning	Example
.	Any single character	^a. → matches “ab”, “ac”, “a1”
^	Start of string	^A → starts with A
$	End of string	n$ → ends with n
[]	Character set	[aeiou] → any vowel
[^]	Negation	[^aeiou] → anything not vowel
{n}	Exactly n repetitions	[aeiou]{2} → two vowels together
{n,}	At least n repetitions	[aeiou]{2,} → 2 or more vowels together */

#1 Names with any vowels
Select * from employee_demographics 
where concat(first_name,last_name)  regexp '[aeiou]' ;

#2 Names with exactly 2 consecutive vowels
Select * from employee_demographics
where concat(first_name, last_name) regexp '[aeiou]{2}';

#3 Names starting with vowel AND ending with consonant
select * from employee_demographics 
where concat(first_name,last_name) regexp '^[aeiou]' and 
concat(first_name,last_name) regexp '[^aeiou]$'; 
#or --> '.* 'similar to % where --> '.' for one character similar to  '_'
Select * from employee_demographics 
where concat(first_name,last_name) regexp '^[aeiou].*[^aeiou]$';

#3 Names with repeated letters anywhere (aa, bb, cc…) or(aaa,nnn,fff..)
Select *from employee_demographics 
where concat(first_name,last_name) regexp '(.)\\1{1}'; #for n times (.)1{n-1} 

# 4  emails ends with com or org or net
 Select * from employee_demographics
 where email regexp '\\.[com|org|net]$';
 
 #5 phone number format
Select * from employee_demographics 
where phone_number regexp '^[0-9]{4}-[0-9]{4}$';

#6 Exactly [five/six/seven] letters in first name
Select * from employee_demographics 
where first_name regexp '^.{3}$'; # '^.{n}$ '

/*where clause in birth-date
!!! Extract--> EXTRACT('part' FROM date) 
'part' can be YEAR,MONTH,DAY,HOUR,WEEK(weeknumber)
!!! DAYOFWEEK()--> DAYOFWEEK(date)
return 1 for sunday ,....to 7 forsaturday
!!! DAYNAME()---> DAYNAME(date)
return either monday,tuesday..to sunday
!!! MONTHNAME()-->MONTHNAME(birth_date)
return january,feburuary,..december
!!! LAST_DAY()-->Last_day(date)
returns last date of the particular month in that date
!!! DATE_FORMAT() -->DATE_FORMAT(birth_date, '%d-%M-%Y')
if d-->return daynumber if D-->returns sunday,monday
if m-->returns monthnumber  if M--> returns january, february

*/
#check whether birthdate falls on last of month
Select * from employee_demographics where birth_date =Last_day(birth_date);

#check whether people born on weekends
select * from employee_demographics 
where DAYOFWEEK ( birth_date) in (1,7) ;

# check whether the people born on last seven days[n] in a month
#logic  birthday < (total count of days in a month (30 or 31)) - seven days[n]
select * from employee_demographics
where extract(day from birth_date) > extract(day from(last_day(birth_date)-7));

#check people born on leap year
select * from employee_demographics
where extract(year from birth_date%400=0) or
 ((extract(year from birth_date)%4=0) and(extract(year from birth_date)%100 !=0));
 
 #date-format
 SELECT DATE_FORMAT(birth_date, '%d-%m-%y') AS pretty_date
FROM employee_demographics;
SELECT DATE_FORMAT(birth_date, '%D-%M-%Y-%W') AS pretty_date
FROM employee_demographics;
