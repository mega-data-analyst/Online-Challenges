create database leetcode;

create table leetcode.products
(product_id int primary key,
low_fats enum('Y','N'),
recyclable enum('Y','N')
);

insert into leetcode.products values
(0,'Y','N'),
(1,'Y','Y'),
(2,'N','Y'),
(3,'Y','Y'),
(4,'N','N');

select * from leetcode.products;

# Question 1 - Write a solution to find the ids of products that are both low fat and recyclable.

select product_id from
leetcode.products
where low_fats = 'Y' and recyclable = 'Y';

#########################################################################################################################################################################

create table leetcode.customer
(id int primary key,
name varchar(50),
referee_id int);

insert into leetcode.customer values
(1,'Will',null),
(2,'Jane',null),
(3,'Alex',2),
(4,'Bill',null),
(5,'Zack',1),
(6,'Mark',2);

select * from leetcode.customer;

# Question 2 - Find the names of the customer that are not referred by the customer with id = 2.

select name from
leetcode.customer
where referee_id is null or referee_id <> 2;

#########################################################################################################################################################################

create table leetcode.world
(name varchar(50) primary key,
continent varchar(50),
area int,
population int,
gdp bigint);

insert into leetcode.world values
('Afghanistan','Asia',652230,25500100,20343000000),
('Albania','Europe',28748,2831741,12960000000),
('Algeria','Africa',2381741,37100000,188681000000),
('Andorra','Europe',468,78115,3712000000),
('Angola','Africa',1246700,20609294,100990000000);

select * from leetcode.world;

# Question 3- A country is big if:
# it has an area of at least three million (i.e., 3000000 km2), or
# it has a population of at least twenty-five million (i.e., 25000000).
# Write a solution to find the name, population, and area of the big countries.

select 
name,
population,
area
from leetcode.world
where area >= 3000000 or population >= 25000000;

#########################################################################################################################################################################

create table leetcode.Views
(article_id int,
author_id int,
viewer_id int,
view_date date);

insert into leetcode.Views values
(1,3,5,'2019-08-01'),
(1,3,6,'2019-08-02'),
(2,7,7,'2019-08-01'),
(2,7,6,'2019-08-02'),
(4,7,1,'2019-07-22'),
(3,4,4,'2019-07-21'),
(3,4,4,'2019-07-21');

select * from leetcode.Views;

# Question-4 Write a solution to find all the authors that viewed at least one of their own articles.
# Return the result table sorted by id in ascending order.

select distinct author_id as id
from leetcode.views
where author_id = viewer_id
order by id;

########################################################################################################################################################################

create table leetcode.tweets
(tweet_id int primary key,
content varchar(50));

insert into leetcode.tweets values
(1,'Vote for Biden'),
(2,'Let us make America great again!');

select * from leetcode.tweets;

# Question-5 Write a solution to find the IDs of the invalid tweets.
# The tweet is invalid if the number of characters used in the content of the tweet is strictly greater than 15.

select tweet_id
from leetcode.tweets
where length(content) > 15;

#########################################################################################################################################################################

create table leetcode.employees
(id int primary key,
name varchar(50));

create table leetcode.employeeUNI
(id int,
unique_id int,
foreign key(id) references employees(id));

insert into leetcode.employees values
(1,'Alice'),
(7,'Bob'),
(11,'Meir'),
(90,'Winston'),
(3,'Jonathan');

select * from leetcode.employees;

insert into leetcode.employeeUNI values
(3,1),
(11,2),
(90,3);

select * from leetcode.employeeUNI;

# Question-6 Write a solution to show the unique ID of each user, If a user does not have a unique ID replace just show null.

select
unique_id,
name
from leetcode.employees e left join leetcode.employeeUNI eu on e.id= eu.id
order by unique_id;

#########################################################################################################################################################################

create table leetcode.product
(product_id int primary key,
product_name varchar(50));

create table leetcode.sales
(sale_id int primary key,
product_id int,
year int,
quantity int,
price int,
foreign key(product_id) references product(product_id));

insert into leetcode.product values
(100,'Nokia'),
(200,'Apple'),
(300,'Samsung');

select * from leetcode.product;

insert into leetcode.sales values
(1,100,2008,10,5000),
(2,100,2009,12,5000),
(7,200,2011,15,9000);

select * from leetcode.sales;

# Question-7 Write a solution to report the product_name, year, and price for each sale_id in the Sales table.

select
product_name,
year,
price
from leetcode.sales s join leetcode.product p on s.product_id = p.product_id
order by year;

#########################################################################################################################################################################

create table leetcode.visits
(visit_id int primary key,
customer_id int);

create table leetcode.transactions
(transaction_id int primary key,
visit_id int,
amount int,
foreign key(visit_id) references visits(visit_id)
);

insert into leetcode.visits values
(1,23),
(2,9),
(4,30),
(5,54),
(6,96),
(7,54),
(8,54);

select * from leetcode.visits;

insert into leetcode.transactions values
(2,5,310),
(3,5,300),
(9,5,200),
(12,1,910),
(13,2,970);

select * from leetcode.transactions;

# Question-8 Write a solution to find the IDs of the users who visited without making any transactions and the number of times they made these types of visits.

select
customer_id,
count(customer_id) as count_no_trans
from leetcode.visits v left join leetcode.transactions t on v.visit_id = t.visit_id
where transaction_id is null
group by customer_id
order by count_no_trans desc;

#########################################################################################################################################################################

create table leetcode.weather
(id int primary key,
recordDate date,
temperature int);

insert into leetcode.weather values
(1,'2015-01-01',10),
(2,'2015-01-02',25),
(3,'2015-01-03',20),
(4,'2015-01-04',30);

select * from leetcode.weather;

# Question-9 Write a solution to find all dates' Id with higher temperatures compared to its previous dates (yesterday).

select w1.id
from leetcode.weather w1 join leetcode.weather w2 on
w1.recordDate = date_add(w2.recordDate,interval 1 day)
where w1.temperature > w2.temperature;

#########################################################################################################################################################################

create table leetcode.activity
(machine_id int,
process_id int,
activity_type enum('Start','End'),
timestamp float);

insert into leetcode.activity values
(0,0,'Start',0.712),
(0,0,'End',1.520),
(0,1,'Start',3.140),
(0,1,'End',4.120),
(1,0,'Start',0.550),
(1,0,'End',1.550),
(1,1,'Start',0.430),
(1,1,'End',1.420),
(2,0,'Start',4.100),
(2,0,'End',4.512),
(2,1,'Start',2.500),
(2,1,'End',5.000);

select * from leetcode.activity;

# Question-10 There is a factory website that has several machines each running the same number of processes. 
# Write a solution to find the average time each machine takes to complete a process.
# The time to complete a process is the 'end' timestamp minus the 'start' timestamp. 
# The average time is calculated by the total time to complete every process on the machine divided by the number of processes that were run.
# The resulting table should have the machine_id along with the average time as processing_time, which should be rounded to 3 decimal places.

select a.machine_id,
round(avg(a.timestamp - b.timestamp),3) as processing_time
from leetcode.activity a 
join leetcode.activity b 
on a.machine_id = b.machine_id
and a.process_id = b.process_id
and a.activity_type = 'End'
and b.activity_type = 'Start'
group by a.machine_id;

#########################################################################################################################################################################

create table leetcode.employee
(empID int primary key,
name varchar(50),
supervisor int,
salary int);

insert into leetcode.employee values
(3,'Brad',null,4000),
(1,'John',3,1000),
(2,'Dan',3,2000),
(4,'Thomas',3,4000);

select * from leetcode.employee;

create table leetcode.bonus
(empID int,
bonus int,
foreign key(empID) references employee(empID));

insert into leetcode.bonus values
(2,500),
(4,2000);

select * from leetcode.bonus;

# Question-11 Write a solution to report the name and bonus amount of each employee with a bonus less than 1000.

select e.name,
b.bonus
from leetcode.employee e left join leetcode.bonus b on e.empID = b.empID
where b.bonus < 1000 or b.bonus is null;

#########################################################################################################################################################################

create table leetcode.subjects
(subject_name varchar(50) primary key);

insert into leetcode.subjects values
('Math'),
('Physics'),
('Programming');

select * from leetcode.subjects;

create table leetcode.students
(student_id int primary key,
student_name varchar(50));

insert into leetcode.students values
(1,'Alice'),
(2,'Bob'),
(13,'John'),
(6,'Alex');

select * from leetcode.students;

create table leetcode.examinations
(student_id int,
subject_name varchar(50),
foreign key(student_id) references students(student_id),
foreign key(subject_name) references subjects(subject_name));

insert into leetcode.examinations values
(1,'Math'),(1,'Physics'),(1,'Programming'),(2,'Programming'),
(1,'Physics'),(1,'Math'),(13,'Math'),(13,'Programming'),
(13,'Physics'),(2,'Math'),(1,'Math');

select * from leetcode.examinations;

# Question-12 Write a solution to find the number of times each student attended each exam.

select 
s.student_id,
s.student_name,
su.subject_name,
count(e.student_id) as attended_exams
from leetcode.students s cross join leetcode.subjects su 
left join leetcode.examinations e on e.student_id = s.student_id and e.subject_name = su.subject_name
group by s.student_id,su.subject_name
order by s.student_id,su.subject_name; 

#########################################################################################################################################################################

create table leetcode.emp
(id int primary key,
name varchar(50),
department varchar(50),
managerID int);

insert into leetcode.emp values
(101,'John','A',null),(102,'Dan','A',101),(103,'James','A',101),(104,'Amy','A',101),(105,'Anne','A',101),(106,'Ron','B',101),
(111,'John','A',null),(112,'Dan','A',111),(113,'James','A',111),(114,'Amy','A',111),(115,'Anne','A',111),(116,'Ron','B',111);

select * from leetcode.emp;

# Question-13 Write a solution to find managers with at least five direct reports.

select e1.name
from leetcode.emp e1 join leetcode.emp e2 on e1.id = e2.managerID
group by e1.id
having count(*) >= 5;

#########################################################################################################################################################################

create table leetcode.signups
(user_id int primary key,
time_stamp datetime);

create table leetcode.confirmations
(user_id int,
time_stamp datetime,
action enum('Confirmed','Timeout'),
foreign key(user_id) references signups(user_id));

insert into leetcode.signups values
(3,'2020-03-21 10:16:13'),
(7,'2020-01-04 13:57:59'),
(2,'2020-07-29 23:09:44'),
(6,'2020-12-09 10:39:37');

select * from leetcode.signups;

insert into leetcode.confirmations values
(3,'2021-01-06 03:30:46','timeout'),
(3,'2021-07-14 14:00:00','timeout'),
(7,'2021-06-12 11:57:29','confirmed'),
(7,'2021-06-13 12:58:28','confirmed'),
(7,'2021-06-14 13:59:27','confirmed'),
(2,'2021-01-22 00:00:00','confirmed'),
(2,'2021-02-28 23:59:59','timeout');

select * from leetcode.confirmations;

# Question-14 The confirmation rate of a user is the number of 'confirmed' messages divided by the total number of requested confirmation messages.
# The confirmation rate of a user that did not request any confirmation messages is 0. Round the confirmation rate to two decimal places.
# Write a solution to find the confirmation rate of each user.


select s.user_id,
round(coalesce(count(case when action = 'confirmed' then 1 end)/count(c.time_stamp),0),2) as confirmation_rate
from leetcode.signups s left join leetcode.confirmations c on s.user_id=c.user_id
group by user_id
order by confirmation_rate;

#########################################################################################################################################################################

create table leetcode.cinema
(id int primary key,
movie varchar(50),
description varchar(50),
rating float);

insert into leetcode.cinema values
(1,'War','great 3D',8.9),
(2,'Science','fiction',8.5),
(3,'irish','boring',6.2),
(4,'Ice song','Fantacy',8.6),
(5,'House card','Interesting',9.1);

# Question-15 Write a solution to report the movies with an odd-numbered ID and a description that is not "boring".
# Return the result table ordered by rating in descending order.

select *
from leetcode.cinema
where id % 2 = 1
and description <> 'boring'
order by rating desc;

#########################################################################################################################################################################

create table leetcode.prices
(product_id int,
start_date date,
end_date date,
price int);

create table leetcode.unitsSold
(product_id int,
purchase_date date,
units int);

insert into leetcode.prices values
(1,'2019-02-17','2019-02-28',5),
(1,'2019-03-01','2019-03-22',20),
(2,'2019-02-01','2019-02-20',15),
(2,'2019-02-21','2019-03-31',30);

select * from leetcode.prices;

insert into leetcode.unitssold values
(1,'2019-02-25',100),
(1,'2019-03-01',15),
(2,'2019-02-10',200),
(2,'2019-03-22',30);

select * from leetcode.unitssold;

# Question-16 Write a solution to find the average selling price for each product. average_price should be rounded to 2 decimal places.

select p.product_id,
ifnull(round(sum(p.price*u.units)/sum(units),2),0) as average_price
from leetcode.prices p left join leetcode.unitssold u on p.product_id = u.product_id
and purchase_date between start_date and end_date
group by p.product_id;

#########################################################################################################################################################################

create table leetcode.empl
(employee_id int primary key,
name varchar(50),
experience_years int not null);

create table leetcode.project
(project_id int,
employee_id int,
foreign key(employee_id) references empl(employee_id));

insert into leetcode.empl values
(1,'Khaled',3),
(2,'Ali',2),
(3,'John',1),
(4,'Doe',2);

select * from leetcode.empl;

insert into leetcode.project values
(1,1),(1,2),(1,3),(2,1),(2,4);

select * from leetcode.project;

# Question-17 Write an SQL query that reports the average experience years of all the employees for each project, rounded to 2 digits.

select p.project_id,
round(avg(e.experience_years),2) as average_years
from leetcode.project p join leetcode.empl e on p.employee_id = e.employee_id
group by project_id
order by project_id;

#########################################################################################################################################################################

create table leetcode.users
(user_id int primary key,
user_name varchar(50));

create table leetcode.register
(contest_id int,
user_id int,
foreign key(user_id) references users(user_id));

insert into leetcode.users values
(6,'Alice'),
(2,'Bob'),
(7,'Alex');

select * from leetcode.users;

insert into leetcode.register values
(215,6),(209,2),(208,2),(210,6),
(208,6),(209,7),(209,6),(215,7),
(208,7),(210,2),(207,2),(210,7);

select * from leetcode.register;

# Question-18 Write a solution to find the percentage of the users registered in each contest rounded to two decimals.
# Return the result table ordered by percentage in descending order. In case of a tie, order it by contest_id in ascending order.

select r.contest_id,
round((count(u.user_id)/(select count(user_id) from leetcode.users))*100,2) as percentage 
from leetcode.users u join leetcode.register r on u.user_id = r.user_id
group by contest_id
order by percentage desc, contest_id ;

#########################################################################################################################################################################

create table leetcode.queries
(query_name varchar(50),
result varchar(50),
position int,
rating int);

insert into leetcode.queries values
('Dog','Golden Retriever',1,5),
('Dog','German Shepherd',2,5),
('Dog','Mule',200,1),
('Cat','Shirazi',5,2),
('Cat','Siamese',3,3),
('Cat','Sphynx',7,4);

select * from leetcode.queries;

# Question-19 We define query quality as:The average of the ratio between query rating and its position.
# We also define poor query percentage as:The percentage of all queries with rating less than 3.
# Write a solution to find each query_name, the quality and poor_query_percentage.
# Both quality and poor_query_percentage should be rounded to 2 decimal places.

select
query_name,
round(avg(rating/position),2) as quality,
round(sum(case when rating < 3 then 1 else 0 end)/count(query_name)*100 ,2)as poor_query_percentage
from leetcode.queries
where query_name is not null
group by query_name;

#########################################################################################################################################################################

create table leetcode.transaction
(id int primary key,
country varchar(50),
state enum('approved','declined'),
amount int,
trans_date date);

insert into leetcode.transaction values
(121,'US','approved',1000,'2018-12-18'),
(122,'US','declined',2000,'2018-12-19'),
(123,'US','approved',2000,'2019-01-01'),
(124,'DE','approved',2000,'2019-01-07');

select * from leetcode.transaction;

# Question-20 Write an SQL query to find for each month and country, the number of transactions and their total amount, 
# the number of approved transactions and their total amount.

select
date_format(trans_date,'%Y-%m') as month,
country,
count(state) as trans_count,
count(case when state = 'approved' then 1 end) as approved_count,
sum(amount) as trans_total_amount,
sum(case when state = 'approved' then amount else 0 end) as approved_total_amount
from leetcode.transaction
group by month,country;

########################################################################################################################################################################

create table leetcode.delivery
(delivery_id int unique,
customer_id int,
order_date date,
customer_pref_delivery_date date);

insert into leetcode.delivery values
(1,1,'2019-08-01','2019-08-02'),
(2,2,'2019-08-02','2019-08-02'),
(3,1,'2019-08-11','2019-08-12'),
(4,3,'2019-08-24','2019-08-24'),
(5,3,'2019-08-21','2019-08-22'),
(6,2,'2019-08-11','2019-08-13'),
(7,4,'2019-08-09','2019-08-09');

select * from leetcode.delivery;

# Question-21 If the customer's preferred delivery date is the same as the order date, then the order is called immediate; otherwise, it is called scheduled.
# The first order of a customer is the order with the earliest order date that the customer made. It is guaranteed that a customer has precisely one first order.
# Write a solution to find the percentage of immediate orders in the first orders of all customers, rounded to 2 decimal places.

	select round(sum(case when order_date = customer_pref_delivery_date then 1 else 0 end)
    /count(distinct customer_id) *100,2) as immediate_percentage 
	from leetcode.delivery
	where (customer_id,order_date) in (select customer_id,min(order_date) as order_date
	from leetcode.delivery
	group by customer_id);

#########################################################################################################################################################################

create table leetcode.activities
(player_id int, 
device_id int, 
event_date date, 
games_played int);

insert into leetcode.activities values
('1', '2', '2016-03-01', '5'),
('1', '2', '2016-03-02', '6'),
('2', '3', '2017-06-25', '1'),
('3', '1', '2016-03-02', '0'),
('3', '4', '2018-07-03', '5');

select * from leetcode.activities;

# Question-22 Write a solution to report the fraction of players that logged in again on the day after the day they first logged in, 
# rounded to 2 decimal places. In other words, you need to count the number of players that logged in for at least two consecutive days 
# starting from their first login date, then divide that number by the total number of players.

select 
round(count(*)/(select count(distinct player_id) from leetcode.activities),2) as fraction
from leetcode.activities 
where (player_id,date_sub(event_date,interval 1 day))
in (select player_id,min(event_date) as first_time_login from leetcode.activities group by player_id);

#########################################################################################################################################################################

create table leetcode.teacher
(teacher_id int,
subject_id int,
dept_id int);

insert into leetcode.teacher values
('1', '2', '3'),
('1', '2', '4'),
('1', '3', '3'),
('2', '1', '1'),
('2', '2', '1'),
('2', '3', '1'),
('2', '4', '1');

select * from leetcode.teacher;

# Question-23 Write a solution to calculate the number of unique subjects each teacher teaches in the university.

select
teacher_id,
count(distinct subject_id) as cnt
from leetcode.teacher
group by teacher_id;

#########################################################################################################################################################################

create table leetcode.act
(user_id int,
session_id int,
activity_date date,
activity_type ENUM('open_session', 'end_session', 'scroll_down', 'send_message'));

insert into leetcode.act values
('1', '1', '2019-07-20', 'open_session'),
('1', '1', '2019-07-20', 'scroll_down'),
('1', '1', '2019-07-20', 'end_session'),
('2', '4', '2019-07-20', 'open_session'),
('2', '4', '2019-07-21', 'send_message'),
('2', '4', '2019-07-21', 'end_session'),
('3', '2', '2019-07-21', 'open_session'),
('3', '2', '2019-07-21', 'send_message'),
('3', '2', '2019-07-21', 'end_session'),
('4', '3', '2019-06-25', 'open_session'),
('4', '3', '2019-06-25', 'end_session');

select * from leetcode.act;

# Question-24 Write a solution to find the daily active user count for a period of 30 days ending 2019-07-27 inclusively. 
# A user was active on someday if they made at least one activity on that day. 

select
activity_date as day,
count(distinct user_id) as active_users
from leetcode.act
where activity_date between "2019-06-28" and "2019-07-27"
group by day;

#########################################################################################################################################################################

create table leetcode.prod
(product_id int primary key,
product_name varchar(50));

create table leetcode.sale
 (sale_id int primary key, 
 product_id int, 
 year int, 
 quantity int, 
 price int,
 foreign key(product_id) references prod(product_id));
 
 insert into leetcode.prod values
 ('100', 'Nokia'),
 ('200', 'Apple'),
 ('300', 'Samsung');
 
select * from leetcode.prod;

insert into leetcode.sale values
('1', '100', '2008', '10', '5000'),
('2', '100', '2009', '12', '5000'),
('7', '200', '2011', '15', '9000');

select * from leetcode.sale;

# Question-25 Write a solution to select the product id, year, quantity, and price for the first year of every product sold.

select
product_id,
year as first_year,
quantity,
price
from leetcode.sale 
where (product_id,year) in 
(select
product_id,
min(year) as first_year
from leetcode.sale 
group by product_id);
 
##########################################################################################################################################################################

create table leetcode.courses
(student varchar(50),
 class varchar(50));
 
insert into leetcode.courses values
('A', 'Math'),
('B', 'English'),
('C', 'Math'),
('D', 'Biology'),
('E', 'Math'),
('F', 'Computer'),
('G', 'Math'),
('H', 'Math'),
('I', 'Math');

select * from leetcode.courses;

# Question-26 Write a solution to find all the classes that have at least five students.

select 
class 
from leetcode.courses
group by class
having count(student) >=5 ;

#########################################################################################################################################################################

create table leetcode.followers
(user_id int, 
follower_id int);

insert into leetcode.followers values
('0', '1'),
('1', '0'),
('2', '0'),
('2', '1');

select * from leetcode.followers;

# Question-27 Write a solution that will, for each user, return the number of followers.

select
distinct user_id,
count(follower_id) as followers_count
from leetcode.followers
group by user_id
order by user_id;

#########################################################################################################################################################################

create table leetcode.mynumbers
(num int);

insert into leetcode.mynumbers values
('8'),('8'),('3'),('3'),('1'),('4'),('5'),('6');

select * from leetcode.mynumbers;

# Question-28 A single number is a number that appeared only once in the MyNumbers table.
# Find the largest single number. If there is no single number, report null.

select 
max(num) as num
from leetcode.mynumbers
where num in 
(select num 
from leetcode.mynumbers 
group by num
having count(*) = 1);

##########################################################################################################################################################################

create table leetcode.produ
(product_key int primary key);

create table leetcode.customers
(customer_id int,
product_key int,
foreign key(product_key) references produ(product_key));

insert into leetcode.produ values
('5'),('6');

select * from leetcode.produ;

insert into leetcode.customers values
('1', '5'),('2', '6'),('3', '5'),('3', '6'),('1', '6');

select * from leetcode.customers;

# Question-29 Write a solution to report the customer ids from the Customer table that bought all the products in the Product table.

select customer_id
from leetcode.customers
group by customer_id
having count(distinct product_key) = 
(select 
count(product_key) 
from leetcode.produ);

#########################################################################################################################################################################

create table leetcode.emplo
(employee_id int,
name varchar(50),
reports_to int,
age int);

insert into leetcode.emplo values
('9', 'Hercy', null, '43'),
('6', 'Alice', '9', '41'),
('4', 'Bob', '9', '36'),
('2', 'Winston', null, '37');

select * from leetcode.emplo;

# Question-30 For this problem, we will consider a manager an employee who has at least 1 other employee reporting to them.
# Write a solution to report the ids and the names of all managers, the number of employees who report directly to them, 
# and the average age of the reports rounded to the nearest integer.
# Return the result table ordered by employee_id

select distinct e1.employee_id,
e1.name,
count(e2.reports_to) as reports_count,
round(avg(e2.age)) as average_age
from leetcode.emplo e1 join leetcode.emplo e2 on e1.employee_id = e2.reports_to
group by e1.employee_id,e1.name
order by e1.employee_id;

#########################################################################################################################################################################

create table leetcode.employ
(employee_id int,
department_id int,
primary_flag enum ('Y','N'));

insert into leetcode.employ values
('1', '1', 'N'),
('2', '1', 'Y'),
('2', '2', 'N'),
('3', '3', 'N'),
('4', '2', 'N'),
('4', '3', 'Y'),
('4', '4', 'N');

select * from leetcode.employ;

# Question-31 Employees can belong to multiple departments. When the employee joins other departments, they need to decide which department is their primary department.
# Note that when an employee belongs to only one department, their primary column is 'N'.
# Write a solution to report all the employees with their primary department. For employees who belong to one department, report their only department.

select employee_id,
department_id
from leetcode.employ
where primary_flag = 'Y'
union
select employee_id,
min(department_id) as department_id
from leetcode.employ
group by employee_id
having count(department_id) = 1;

#########################################################################################################################################################################

create table leetcode.triangle
(x int, y int, z int);

insert into leetcode.triangle values
('13', '15', '30'), ('10', '20', '15');

select * from leetcode.triangle;

# Question-32 Report for every three line segments whether they can form a triangle.Return the result table in any order.

select x,y,z,
case when (x+y) > z and (x+z) > y and (y+z) > x then "Yes" else "No" end as triangle
from leetcode.triangle;  
	
#########################################################################################################################################################################

create table leetcode.logs
(id int primary key auto_increment,
num varchar(50));

insert into leetcode.logs values
('1', '1'),('2', '1'),('3', '1'),('4', '2'),('5', '1'),('6', '2'),('7', '2');

select * from leetcode.logs;

# Question-33 Find all numbers that appear at least three times consecutively.

with cte as 
(select
num,
lead(num,1) over() num1,
lead(num,2) over() num2
from leetcode.logs)
select distinct num as ConsecutiveNums
from cte
where num = num1 and num=num2;

#########################################################################################################################################################################

create table leetcode.pro
(product_id int,
new_price int,
change_date date);

insert into leetcode.pro values
('1', '20', '2019-08-14'),
('2', '50', '2019-08-14'),
('1', '30', '2019-08-15'),
('1', '35', '2019-08-16'),
('2', '65', '2019-08-17'),
('3', '20', '2019-08-18');

select * from leetcode.pro;

# Question-34 Write a solution to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10. 

with cte as
(select *,
rank() over(partition by product_id order by change_date desc) as rnk
from leetcode.pro
where change_date <= '2019-08-16')
select product_id,
new_price as price 
from cte
where rnk = 1
union
select product_id,
10 as price 
from leetcode.pro
where product_id not in (select product_id from cte);

#########################################################################################################################################################################

create table leetcode.queue
(person_id int, 
person_name varchar(30), 
weight int, 
turn int);

insert into leetcode.queue values
('5', 'Alice', '250', '1'),
('4', 'Bob', '175', '5'),
('3', 'Alex', '350', '2'),
('6', 'John Cena', '400', '3'),
('1', 'Winston', '500', '6'),
('2', 'Marie', '200', '4');

select * from leetcode.queue;

# Question-35 There is a queue of people waiting to board a bus. However, the bus has a weight limit of 1000 kilograms, 
# so there may be some people who cannot board.
# Write a solution to find the person_name of the last person that can fit on the bus without exceeding the weight limit. 
# The test cases are generated such that the first person does not exceed the weight limit.

with cte as
(select *,
sum(weight) over(order by turn) as ttl_weight
from leetcode.queue)
select person_name
from leetcode.queue
where turn  = (select max(turn) from cte where ttl_weight <= 1000);

#########################################################################################################################################################################

create table leetcode.accounts
(account_id int primary key,
income int);

insert into leetcode.accounts values
('3', '108939'),
('2', '12747'),
('8', '87709'),
('6', '91796');

select * from leetcode.accounts;

# Question-36 Write a solution to calculate the number of bank accounts for each salary category. The salary categories are:
# "Low Salary": All the salaries strictly less than $20000.
# "Average Salary": All the salaries in the inclusive range [$20000, $50000].
# "High Salary": All the salaries strictly greater than $50000.
# The result table must contain all three categories. If there are no accounts in a category, return 0.

(select 'Low Salary' as Category,
(select count(*) from leetcode.accounts
where income < 20000) accounts_count)
union
(select 'Average Salary' as Category,
(select count(*) from leetcode.accounts
where income >= 20000 and income <= 50000) accounts_count)
union
(select 'High Salary' as Category,
(select count(*) from leetcode.accounts
where income > 50000) accounts_count);

#########################################################################################################################################################################

create table leetcode.emp1
(employee_id int,
name varchar(50),
manager_id int,
salary int);

insert into leetcode.emp1 values
(3,'Mila',9,60301),
(12,'Antonella',null,31000),
(13,'Emery',null,67084),
(1,'Kalel',11,21241),
(9,'Mikaela',null,50937),
(11,'Joziah',6,28485);

select * from leetcode.emp1;

# Question-37 Find the IDs of the employees whose salary is strictly less than $30000 and whose manager left the company. 
# When a manager leaves the company, their information is deleted from the Employees table, but the reports still have their manager_id set to the manager that left.
# Return the result table ordered by employee_id.

select employee_id
from leetcode.emp1 
where salary < 30000 and 
manager_id not in (select employee_id from leetcode.emp1)
order by employee_id;

#########################################################################################################################################################################

create table leetcode.seat
(id int primary key auto_increment,
student varchar(50));

insert into leetcode.seat values
(1,'Abbot'),
(2,'Doris'),
(3,'Emerson'),
(4,'Green'),
(5,'Jeames');

select * from leetcode.seat;

# Question-38 Write a solution to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped.
# Return the result table ordered by id in ascending order.

select case
when id = (select max(id) from leetcode.seat) and mod(id,2) = 1 then id
when mod(id,2) = 1 then id+1
else id-1 
end as id,
student
from leetcode.seat
order by id;

#########################################################################################################################################################################

create table leetcode.movies
(movie_id int primary key,
title varchar(50));

create table leetcode.user
(user_id int primary key,
name varchar(50));

create table leetcode.movierating
(movie_id int,
user_id int,
rating int,
created_at date,
foreign key(movie_id) references movies(movie_id),
foreign key(user_id) references user(user_id));

insert into leetcode.movies values
(1,'Avengers'),
(2,'Frozen 2'),
(3,'Joker');

select * from leetcode.movies;

insert into leetcode.user values
(1,'Daniel'),
(2,'Monica'),
(3,'Maria'),
(4,'James');

select * from leetcode.user;

insert into leetcode.movierating values
(1,1,3,'2020-01-12'),
(1,2,4,'2020-02-11'),
(1,3,2,'2020-02-12'),
(1,4,1,'2020-01-01'),
(2,1,5,'2020-02-17'),
(2,2,2,'2020-02-01'),
(2,3,2,'2020-03-01'),
(3,1,3,'2020-02-22'),
(3,2,4,'2020-02-25');

select * from leetcode.movierating;

# Question-39 Write a solution to:
# Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
# Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name.

(select 
name as results
from leetcode.user join leetcode.movierating using(user_id)
group by user_id
order by count(rating) desc,name
limit 1)
union all
(select 
title as results
from leetcode.movies join leetcode.movierating using(movie_id)
where month(created_at) = '2' and year(created_at) = '2020'
group by movie_id
order by avg(rating) desc,title
limit 1);

#########################################################################################################################################################################

create table leetcode.cust
(customer_id int,
name varchar(50),
visited_on date,
amount int);

insert into leetcode.cust values
(1,'Jhon','2019-01-01',100),
(2,'Daniel','2019-01-02',110),
(3,'Jade','2019-01-03',120),
(4,'Khaled','2019-01-04',130),
(5,'Winston','2019-01-05',110),
(6,'Elvis','2019-01-06',140),
(7,'Anna','2019-01-07',150),
(8,'Maria','2019-01-08',80),
(9,'Jaze','2019-01-09',110),
(1,'Jhon','2019-01-10',130),
(3,'Jade','2019-01-10',150);

select * from leetcode.cust;

# Question-40 You are the restaurant owner and you want to analyze a possible expansion (there will be at least one customer every day).
# Compute the moving average of how much the customer paid in a seven days window (i.e., current day + 6 days before). 
# average_amount should be rounded to two decimal places.
# Return the result table ordered by visited_on in ascending order.

with cte as
(select
visited_on,
sum(amount) as amt
from leetcode.cust
group by visited_on),
cte1 as
(select
visited_on,
amt,
sum(amt) over(order by visited_on rows between 6 preceding and current row) as amount,
round(avg(amt) over(order by visited_on rows between 6 preceding and current row),2) as average_amount,
row_number() over(order by visited_on) as rw
from cte)
select visited_on,
amount,
average_amount
from cte1
where rw > 6;

#########################################################################################################################################################################

create table leetcode.RequestAccepted
(requester_id int,
accepter_id int,
accept_date date);

insert into leetcode.RequestAccepted values
(1,2,'2016/06/03'),
(1,3,'2016/06/08'),
(2,3,'2016/06/08'),
(3,4,'2016/06/09');

select * from leetcode.RequestAccepted;

# Question- 41 Write a solution to find the people who have the most friends and the most friends number.
# The test cases are generated so that only one person has the most friends.

with cte as
(select
requester_id 
from leetcode.requestaccepted
union all
select
accepter_id
from leetcode.requestaccepted)
select 
requester_id as id,
count(*) as num 
from cte
group by requester_id
order by num desc
limit 1;

#########################################################################################################################################################################

create table leetcode.insurance
(pid int primary key,
tiv_2015 float,
tiv_2016 float,
lat float,
lon float);

insert into leetcode.insurance values
(1,10,5,10,10),
(2,20,20,20,20),
(3,10,30,20,20),
(4,10,40,40,40);

select * from leetcode.insurance;

# Question-42 Write a solution to report the sum of all total investment values in 2016 tiv_2016, for all policyholders who:
# have the same tiv_2015 value as one or more other policyholders, and
# are not located in the same city as any other policyholder (i.e., the (lat, lon) attribute pairs must be unique)
# Round tiv_2016 to two decimal places.

select
round(sum(tiv_2016),2) as tiv_2016
from leetcode.insurance
where tiv_2015 in
(select tiv_2015
from leetcode.insurance
group by tiv_2015
having count(*) > 1)
and
(lat,lon) in
(select lat,lon
from leetcode.insurance
group by lat,lon
having count(*) = 1);

########################################################################################################################################################################

create table leetcode.department
(id int primary key,
name varchar(50));

create table leetcode.emp2
(id int primary key,
name varchar(50),
salary int,
departmentId int,
foreign key(departmentId) references department(id));

insert into leetcode.department values
(1,'IT'),(2,'Sales');

select * from leetcode.department;

insert into leetcode.emp2 values
(1,'Joe',85000,1),
(2,'Henry',80000,2),
(3,'Sam',60000,2),
(4,'Max',90000,1),
(5,'Janet',69000,1),
(6,'Randy',85000,1),
(7,'Will',70000,1);

select * from leetcode.emp2;

# Question-43 A company's executives are interested in seeing who earns the most money in each of the company's departments. 
# A high earner in a department is an employee who has a salary in the top three unique salaries for that department.
# Write a solution to find the employees who are high earners in each of the departments.

with cte as
(select 
d.name as department,
e.name as employee,
e.salary as salary,
dense_rank() over(partition by d.name order by salary desc) as rnk
from leetcode.emp2 e join leetcode.department d on e.departmentId = d.id
order by department,salary desc)
select
department,
employee,
salary
from cte
where rnk <=3;

#########################################################################################################################################################################

create table leetcode.use
(user_id int primary key,
name varchar(50));

insert into leetcode.use values
(1,'aLice'),(2,'bOB');

select * from leetcode.use;

# Question- 44 Write a solution to fix the names so that only the first character is uppercase and the rest are lowercase.
# Return the result table ordered by user_id.

select user_id,
concat(upper(substr(name,1,1)),lower(substr(name,2))) as name
from leetcode.use
order by user_id;

#########################################################################################################################################################################

create table leetcode.patients
(patient_id int primary key,
patient_name varchar(50),
conditions varchar(50));

insert into leetcode.patients values
(1,'Daniel','YFEV COUGH'),
(2,'Alice',''),
(3,'Bob','DIAB100 MYOP'),
(4,'George','ACNE DIAB100'),
(5,'Alain','DIAB201');

select * from leetcode.patients;

# Question-45 Write a solution to find the patient_id, patient_name, and conditions of the patients who have Type I Diabetes. 
# Type I Diabetes always starts with DIAB1 prefix.

select
*
from leetcode.patients
where conditions like 'DIAB1%' or conditions like '% DIAB1%';

#########################################################################################################################################################################
create table leetcode.person
(id int primary key,
email varchar(50));

insert into leetcode.person values
(1,'john@example.com'),
(2,'bob@example.com'),
(3,'john@example.com');

select * from leetcode.person;

# Question-46 Write a solution to delete all duplicate emails, keeping only one unique email with the smallest id.
# For SQL users, please note that you are supposed to write a DELETE statement and not a SELECT one.

set sql_safe_updates = 0;

with cte as
(select
id,
email,
row_number() over(partition by email order by id) as rn
from leetcode.person)
delete from leetcode.person
where id not in 
(select id from cte where rn = 1)
;

select * from leetcode.person;

#########################################################################################################################################################################

create table leetcode.emp3
(id int,
salary int);

insert into leetcode.emp3 values
(1,100), (2,200), (3,300);

select * from leetcode.emp3;

# Question- 47 Write a solution to find the second highest salary from the Employee table. If there is no second highest salary, return null

select 
(select 
distinct salary 
from leetcode.emp3
order by salary desc
limit 1 offset 1)
as SecondHighestSalary;

#########################################################################################################################################################################

create table leetcode.activiti
(sell_date date,
product varchar(50));

insert into leetcode.activiti values
('2020-05-30','Headphone'),
('2020-06-01','Pencil'),
('2020-06-02','Mask'),
('2020-05-30','Basketball'),
('2020-06-01','Bible'),
('2020-06-02','Mask'),
('2020-05-30','T-Shirt');

select * from leetcode.activiti;

# Question-48 Write a solution to find for each date the number of different products sold and their names.
# The sold products names for each date should be sorted lexicographically.Return the result table ordered by sell_date.

select
sell_date,
count(distinct product) as num_sold,
group_concat(distinct product) as products
from leetcode.activiti
group by sell_date;

#########################################################################################################################################################################

create table leetcode.product1
(product_id int primary key,
product_name varchar(50),
product_category varchar(50));

create table leetcode.orders
(product_id int,
order_date date,
unit int,
foreign key(product_id) references product1(product_id));

insert into leetcode.product1 values
(1,'Leetcode Solutions','Book'),
(2,'Jewels of Stringology','Book'),
(3,'HP','Laptop'),
(4,'Lenovo','Laptop'),
(5,'Leetcode Kit','T-shirt');

select * from leetcode.product1;

insert into leetcode.orders values
(1,'2020-02-05',60),
(1,'2020-02-10',70),
(2,'2020-01-18',30),
(2,'2020-02-11',80),
(3,'2020-02-17',2),
(3,'2020-02-24',3),
(4,'2020-03-01',20),
(4,'2020-03-04',30),
(4,'2020-03-04',60),
(5,'2020-02-25',50),
(5,'2020-02-27',50),
(5,'2020-03-01',50);

select * from leetcode.orders;

# Question-49 Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.

select
product_name,
sum(unit) as unit
from leetcode.product1 join leetcode.orders using(product_id)
where month(order_date) = 2 and year(order_date) = 2020
group by product_name
having unit >= 100;

########################################################################################################################################################################

create table leetcode.user1
(user_id int,
name varchar(50),
mail varchar(50));

insert into leetcode.user1 values
 (1,'Winston','winston@leetcode.com'),
 (2,'Jonathan','jonathanisgreat'),
 (3,'Annabelle','bella-@leetcode.com'),
 (4,'Sally','sally.come@leetcode.com'),
 (5,'Marwan','quarz#2020@leetcode.com'),
 (6,'David','david69@gmail.com'),
 (7,'Shapiro','.shapo@leetcode.com');
 
select * from leetcode.user1;

# Question-50 Write a solution to find the users who have valid emails.A valid e-mail has a prefix name and a domain where:
# The prefix name is a string that may contain letters (upper or lower case), digits, underscore '_', period '.', and/or dash '-'. 
# The prefix name must start with a letter.
# The domain is '@leetcode.com'.

select * 
from leetcode.user1
where mail regexp '^[A-Za-z][A-Za-z0-9_\.\-]*@leetcode[.]com$' ;



