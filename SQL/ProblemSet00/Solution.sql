- ProblemSet00, December 5 2018
-- sai.lohith.vasireddi@accenture.com

/* <Question from the ProblemSet 00> */


CREATING DEPT TABLE

create table dept(dep_id varchar(3) primary key,depname varchar(20),depmanager varchar(20));


INSERTING VALUES INTO DEPT TABLE

insert into dept values("D01","HEALTH","TIM ARCHER");
insert into dept values("D02","COMMUNICATIONS","ADAM JUSTIN");
insert into dept values("D03","PRODUCT","BRUCE WILLS");
insert into dept values("D04","INSURANCE","ROBERT SWIFT");
insert into dept values("D05","FINANCE","NATASHA STEVENS");

CREATING TABLE EMPLOYEE

create table employee(e_id varchar(5) ,name varchar(20),dep_id varchar(5) references dept(dep_id),salary number,managerid varchar(5));


INSERTING VALUES

insert into employee values("A114","MARTIN TREDEAU","D01",54497,"A120");
insert into employee values("A116","ROBIN WAYNE","D02",20196,"A187");
insert into employee values("A178","BRUCE WILLS","D03",66861,"A298");
insert into employee values("A132","PAUL VINCENT","D01",94791,"A120");
insert into employee values("A198","TOM HANKS","D02",16879,"A187");
insert into employee values("A120","TIM ARCHER","D01",48834,"A298");
insert into employee values("A143","BRAD MICHAEL","D01",24488,"A120");
insert into employee values("A187","ADAM JUSTIN","D02",80543,"A298");
insert into employee values("A121","STUART WILLIAM","D02",78629,"A187");
insert into employee values("A187","ROBERT SWIFT","D04",27700,"A298");
insert into employee values("A176","EDWARD CANE","D01",89176,"A120");
insert into employee values("A142","TARA CUMMINGS","D04",99475,"A187");
insert into employee values("A130","VANESSA PARY","D04",28565,"A187");
insert into employee values("A128","ADAM WAYNE","D05",94324,"A165");
insert into employee values("A129","JOSEPH ANGELIN","D05",44280,"A165");
insert into employee values("A165","NATASHA STEVENS","D05",31377,"A298");
insert into employee values("A111","JOHN HELLEN","D01",15380,"A120");
insert into employee values("A194","HAROLLD STEVENS","D02",32166,"A187");
insert into employee values("A133","STEVE MICHELOS","D02",61215,"A187");
insert into employee values("A156","NICK MARTIN","D03",50174,"A178");


1)Select the Employee with the top three salaries

SELECT * FROM EMPLOYEE ORDER BY SALARY DESC LIMIT 3;

+------+---------------+--------+--------+-----------+
| e_id | name          | dep_id | salary | managerid |
+------+---------------+--------+--------+-----------+
| A142 | TARA CUMMINGS | D04    |  99475 | A187      |
| A132 | PAUL VINCENT  | D01    |  94791 | A120      |
| A128 | ADAM WAYNE    | D05    |  94324 | A165      |
+------+---------------+--------+--------+-----------+

2)Select the Employee with the least salary

SELECT * FROM EMPLOYEE ORDER BY SALARY LIMIT 1;

+------+-------------+--------+--------+-----------+
| e_id | name        | dep_id | salary | managerid |
+------+-------------+--------+--------+-----------+
| A111 | JOHN HELLEN | D01    |  15380 | A120      |
+------+-------------+--------+--------+-----------+

3)Select the Employee who does not have a manager in the department table

select * from Employee where managerid not in(select E_Id from Employee e);

+------+-----------------+--------+--------+-----------+
| e_id | name            | dep_id | salary | managerid |
+------+-----------------+--------+--------+-----------+
| A178 | BRUCE WILLS     | D03    |  66861 | A298      |
| A120 | TIM ARCHER      | D01    |  48834 | A298      |
| A187 | ADAM JUSTIN     | D02    |  80543 | A298      |
| A187 | ROBERT SWIFT    | D04    |  27700 | A298      |
| A165 | NATASHA STEVENS | D05    |  31377 | A298      |
+------+-----------------+--------+--------+-----------+

4)Select the Employee who is also a Manager

select name from Employee e join dept d on e.name=d.depmanager;

+-----------------+
| name            |
+-----------------+
| BRUCE WILLS     |
| TIM ARCHER      |
| ADAM JUSTIN     |
| ROBERT SWIFT    |
| NATASHA STEVENS |
+-----------------+

5)Select the Empolyee who is a Manager and has least salary

 select name from Employee e join dept d on e.name=d.depmanager order by salary limit 1;

+--------------+
| name         |
+--------------+
| ROBERT SWIFT |
+--------------+

6)Select the total number of Employees in Communications departments

select count(*) from employee e join dept d on e.dep_id=d.dep_id where depname="communications";

+----------+
| count(*) |
+----------+
|        6 |
+----------+

7)Select the Employee in Finance Department who has the top salary

select name,salary from employee e join dept d on e.dep_id=d.dep_id where depname="finance" order by salary desc limit 1;

+------------+--------+
| name       | salary |
+------------+--------+
| ADAM WAYNE |  94324 |
+------------+--------+

8)Select the Employee in product depatment who has the least salary

select name,salary from employee e join dept d on e.dep_id=d.dep_id where depname="product" order by salary limit 1;

+-------------+--------+
| name        | salary |
+-------------+--------+
| NICK MARTIN |  50174 |
+-------------+--------+

9)Select the count of Empolyees in Health with maximum salary

select count(name),salary from employee where salary=(select max(salary) from employee e join dept d on e.dep_id=d.dep_id where depname="health");

+-------------+--------+
| count(name) | salary |
+-------------+--------+
|           1 |  94791 |
+-------------+--------+

10)Select the Employees who report to Natasha Stevens

select * from employee e join dept d on e.dep_id=d.dep_id where depmanager="natasha stevens" and name not in ("natasha stevens");

+------+----------------+--------+--------+-----------+--------+---------+-----------------+
| e_id | name           | dep_id | salary | managerid | dep_id | depname | depmanager      |
+------+----------------+--------+--------+-----------+--------+---------+-----------------+
| A128 | ADAM WAYNE     | D05    |  94324 | A165      | D05    | FINANCE | NATASHA STEVENS |
| A129 | JOSEPH ANGELIN | D05    |  44280 | A165      | D05    | FINANCE | NATASHA STEVENS |
+------+----------------+--------+--------+-----------+--------+---------+-----------------+

11)Display the Employee name,Employee count,Dep name,Dept manager in the Health department

select e.name,d.depname,d.depmanager from employee e join dept d on e.dep_id=d.dep_id where depname="health";

+----------------+---------+------------+
| name           | depname | depmanager |
+----------------+---------+------------+
| MARTIN TREDEAU | HEALTH  | TIM ARCHER |
| PAUL VINCENT   | HEALTH  | TIM ARCHER |
| TIM ARCHER     | HEALTH  | TIM ARCHER |
| BRAD MICHAEL   | HEALTH  | TIM ARCHER |
| EDWARD CANE    | HEALTH  | TIM ARCHER |
| JOHN HELLEN    | HEALTH  | TIM ARCHER |
+----------------+---------+------------+

12)Display the Department id,Employee ids and Manager ids for the Communications department

select e.e_id,d.dep_id,e.managerid from employee e join dept d on e.dep_id=d.dep_id where depname="communications";

+------+--------+-----------+
| e_id | dep_id | managerid |
+------+--------+-----------+
| A116 | D02    | A187      |
| A198 | D02    | A187      |
| A187 | D02    | A298      |
| A121 | D02    | A187      |
| A194 | D02    | A187      |
| A133 | D02    | A187      |
+------+--------+-----------+

13)Select the Average Expenses for Each dept with Dept id and Dept name

select e.dep_id,d.depname,avg(salary) from Employee e join Dept d  where e.dep_id = d.dep_id group by(e.dep_id);

+--------+----------------+-------------+
| dep_id | depname        | avg(salary) |
+--------+----------------+-------------+
| D01    | HEALTH         |  54527.6667 |
| D02    | COMMUNICATIONS |  48271.3333 |
| D03    | PRODUCT        |  58517.5000 |
| D04    | INSURANCE      |  51913.3333 |
| D05    | FINANCE        |  56660.3333 |
+--------+----------------+-------------+

14)Select the total expense for the department finance

select e.dep_id,d.depname,sum(salary) from Employee e join Dept d on e.dep_id = d.dep_id where d.depname="finance";

+--------+---------+-------------+
| dep_id | depname | sum(salary) |
+--------+---------+-------------+
| D05    | FINANCE |      169981 |
+--------+---------+-------------+

15)Select the department which spends the least with Dept id and Dept manager name

select l.dep_id,l.depname,l.depmanager,l.total from(select e.dep_id as DEP_ID,d.depname as Depname,d.depmanager,sum(salary) as Total from employee e inner join dept d where d.dep_id=e.dep_id group by e.dep_id ) as l order by total limit 1;

+--------+---------+-------------+--------+
| dep_id | depname | depmanager  | total  |
+--------+---------+-------------+--------+
| D03    | PRODUCT | BRUCE WILLS | 117035 |
+--------+---------+-------------+--------+

16)Select the count of Employees in each department

select d.depname,count(*) from employee e join dept d on e.dep_id=d.dep_id group by d.depname;

+----------------+----------+
| depname        | count(*) |
+----------------+----------+
| COMMUNICATIONS |        6 |
| FINANCE        |        3 |
| HEALTH         |        6 |
| INSURANCE      |        3 |
| PRODUCT        |        2 |
+----------------+----------+

17)Select the count of Employees in each department having salary <10000

select d.depname,count(*) from employee e join dept d on e.dep_id=d.dep_id where salary <10000 group by d.depname;

Empty set

18)Select the total number of Employees in Dept id D04

select dep_id,count(*) from employee where dep_id="d04";

+--------+----------+
| dep_id | count(*) |
+--------+----------+
| D04    |        3 |
+--------+----------+

19)Select all department details of the Department with Maximum Employees

select t.dep_id,d.depname,t.cnt from (select dep_id, cnt , dense_rank() over(order by cnt desc) as ran from (select dep_id,count(*) as cnt from employee group by dep_id)) as t inner join dept d on t.dep_id=d.dep_id where ran=1;

D01|HEALTH|6
D02|COMMUNICATIONS|6

20)Select the Employees who has Tim Cook as their manager

select e.name from employee e join dept d on e.dep_id=d.dep_id where depmanager="tim cook";

empty set
