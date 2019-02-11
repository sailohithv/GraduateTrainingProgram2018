- ProblemSet04, February 11, 2019
-- sai.lohith.vasireddi@accenture.com


1. Find the names of all students who are friends with someone named Gabriel.

select h1.id,h1.name from Highschooler h1 inner join Friend f on h1.ID=f.ID1 inner join highschooler h2 on f.ID2=h2.ID where h2.name='Gabriel';

1510|Jordan
1247|Alexis
1709|Cassandra
1782|Andrew
1501|Jessica


2. For every student who likes someone 2 or more grades younger than themselves, return that student's name and grade,
    and the name and grade of the student they like.

select h1.name,h1.grade,h2.name,h2.grade from Highschooler h1 join highschooler h2 join likes l on h1.id=l.id1 and h2.id=l.id2 where h1.grade-h2.grade>=2;

John|12|Haley|10


3. For every pair of students who both like each other, return the name and grade of both students. 
    Include each pair only once, with the two names in alphabetical order.

select h.name,h1.name from Highschooler h inner join likes l on h.id=l.id1 inner join highschooler h1 on h1.id=l.id2 inner join likes l1 on l1.id1=l.id2 and 
l.id1=l1.id2 and l1.id1>l.id1;

Gabriel|Cassandra
Jessica|Kyle


4. Find all students who do not appear in the Likes table (as a student who likes or is liked) and return their names and grades. 
   Sort by grade, then by name within each grade.

select name,grade from highschooler where id not in (select id2 from likes) and id not in (select id1 from likes);

Jordan|9
Tiffany|9
Logan|12


5. For every situation where student A likes student B, but we have no information about whom B likes 
   (that is, B does not appear as an ID1 in the Likes table), return A and B's names and grades.

select h.name,h.grade,h1.name,h1.grade from Highschooler h inner join (select ID1,ID2 from likes where ID2 not in(select ID1 from likes)) as A 
on h.ID=A.ID1 inner join Highschooler h1 on h1.ID=A.ID2;

Alexis|11|Kris|10
Brittany|10|Kris|10
Austin|11|Jordan|12
John|12|Haley|10

6. Find names and grades of students who only have friends in the same grade. Return the result sorted by grade, then by name within each grade. 

 select h.name,h.grade from Highschooler h where h.ID not in(select f.ID1 from Friend f inner join Highschooler h1 on h1.ID=f.ID2 and h.ID=f.ID1 where h.grade<>h1.grade);
Jordan|9
Haley|10
Kris|10
Brittany|10
Gabriel|11
John|12
Logan|12


7.For each student A who likes a student B where the two are not friends, find if they have a friend C in common (who can introduce them!). For all such trios, return the name and grade of A, B, and C. (1 point possible)

select h1.name,h2.name,h3.name from highschooler h1 inner join likes l1 on h1.id=l1.id1 inner join highschooler h2 on h2.id=l1.id2 inner join highschooler h3 on h3.id=f.id2 inner join friend f on l1.id1=f.id1 inner join friend f1 on l1.id2=f1.id1 where f.id2=f1.id2 and not exists(select f.id1 from friend f inner join friend f1 on f.id1=l1.id1 and f.id2=l1.id2);

Andrew|Cassandra|Gabriel
Austin|Jordan|Andrew
Austin|Jordan|Kyle


8.Find the difference between the number of students in the school and the number of different first names. 

select count(ID)-count(distinct name) from Highschooler;

2


9.Find the name and grade of all students who are liked by more than one other student.

select name,ID from Highschooler where ID in(select ID2 from Likes group by ID2  having count(ID2)>1);

Kris|1468
Cassandra|1709


10.For every situation where student A likes student B, but student B likes a different student C, return the names and grades of A, B, and C.

select h1.name,h1.grade,h2.name,h2.grade,h3.name,h3.grade from Highschooler h1 inner join likes l1 on h1.id=l1.id1 inner join highschooler h2 on h2.id=l1.id2 inner join highschooler h3 on h3.id=l2.id2 inner join likes l2 on l1.id1!=l2.id2 and l1.id2=l2.id1;

Andrew|10|Cassandra|9|Gabriel|9
Gabriel|11|Alexis|11|Kris|10


11.Find those students for whom all of their friends are in different grades from themselves. Return the students' names and grades.

select h.name,h.grade from Highschooler h where h.ID not in(select f.ID1 from Friend f inner join Highschooler h1 on h1.ID=f.ID2 and h.ID=f.ID1 where h.grade=h1.grade);

Austin|11


12.What is the average number of friends per student?

select round(avg(a)) from (select count(id2) as a,id1 from friend group by id1) ;

3.0


13.Find the number of students who are either friends with Cassandra or are friends of friends of Cassandra. Do not count Cassandra, even though technically she is a friend of a friend.

select a+b from (select count(distinct id2) as a from friend where id1 in (select ID2 from friend f where id1=(select id from highschooler where name='Cassandra')) and id2 not in (select id from highschooler where name='Cassandra')), (select count(id2)as b from friend  where id1=(select id from highschooler where name='Cassandra'));

7


14.Find the name and grade of the student(s) with the greatest number of friends.

select h.name,h.grade,id from highschooler h inner join Friend f on h.ID=f.ID1 group by f.ID2 having count(ID2)=(select max(a) from (select count(id2) as a from friend group by id1)) ;

Alexis|11|1247
Andrew|10|1782






























