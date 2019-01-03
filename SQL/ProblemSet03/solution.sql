- ProblemSet03, January 03 2019
-- sai.lohith.vasireddi@accenture.com

/* <Question from the ProblemSet 03> */





1. Find the titles of all movies directed by Steven Spielberg.

select title from movie where director="Steven Spielberg";

E.T.
Raiders of the Lost Ark

2. Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order.

select year from movie m join rating r on m.mid=r.mId where stars>=4;

1937
1937
1939
1981
1981
2009

3. Find the titles of all movies that have no ratings.

SELECT title FROM movie m LEFT JOIN rating r ON m.mid = r.mId WHERE r.mId IS NULL;

Star Wars
Titanic

4. Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NULL value for the date.

select name from reviewer r join rating rg on r.rid=rg.rID where rg.ratingDate is null;

Daniel Lewis
Chris Jackson

5. Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. 
   Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars.

select r.name,m.title,rg.stars,rg.ratingDate from movie m join reviewer r join rating  rg on m.mid=rg.mId and r.rid=rg.rId order by r.name,m.title,rg.stars;

Ashley White|E.T.|3|2011-01-02
Brittany Harris|Raiders of the Lost Ark|2|2011-01-30
Brittany Harris|Raiders of the Lost Ark|4|2011-01-12
Brittany Harris|The Sound of Music|2|2011-01-20
Chris Jackson|E.T.|2|2011-01-22
Chris Jackson|Raiders of the Lost Ark|4|
Chris Jackson|The Sound of Music|3|2011-01-27
Daniel Lewis|Snow White|4|
Elizabeth Thomas|Avatar|3|2011-01-15
Elizabeth Thomas|Snow White|5|2011-01-19
James Cameron|Avatar|5|2011-01-20
Mike Anderson|Gone with the Wind|3|2011-01-09
Sarah Martinez|Gone with the Wind|2|2011-01-22
Sarah Martinez|Gone with the Wind|4|2011-01-27

6. For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, return the reviewer's name and the title of the movie.

SELECT * FROM Reviewer rev
INNER JOIN Rating r1 on r1.rID = rev.rid 
INNER JOIN Rating r2 on r2.rID = rev.rid and r2.mID = r1.mID 
INNER JOIN Movie m on m.mID = r1.mID 
WHERE r2.ratingDate > r1.ratingDate and r2.stars > r1.stars ;

Sarah Martinez|Gone with the Wind

7. For each movie that has at least one rating, find the highest number of stars that movie received. Return the movie title and number of stars. Sort by movie title.

select title,stars from movie m inner join rating r on m.mID=r.mID group by m.mID having stars=max(stars) order by title;

Avatar|5
E.T.|3


8. For each movie, return the title and the 'rating spread', that is, the difference between highest and lowest ratings given to that movie. 
   Sort by rating spread from highest to lowest, then by movie title. 

select title,stars from movie m inner join rating r on m.mID=r.mID group by m.mID having stars=max(stars) order by title;

Sarah Martinez|Gone with the Wind


9. Find the difference between the average rating of movies released before 1980 and the average rating of movies released after 1980.
 (Make sure to calculate the average rating for each movie, then the average of those averages for movies before 1980 and movies after.
  Don't just calculate the overall average rating before and after 1980.)

 select distinct(m.title),avg(r.stars),m.year from movie m join rating r on m.mid=r.mID where year < 1980 group by m.title
 union all
 select distinct(m.title),avg(r.stars),m.year from movie m join rating r on m.mid=r.mID where year > 1980 group by m.title;

Gone with the Wind|3.0|1939
Snow White|4.5|1937
The Sound of Music|2.5|1965
Avatar|4.0|2009
E.T.|2.5|1982
Raiders of the Lost Ark|3.33333333333333|1981


10. Find the names of all reviewers who rated Gone with the Wind.

select distinct r.name from reviewer r join movie m join rating rg on m.mid=rg.mID and r.rid=rg.rID where m.title="Gone with the Wind";

Sarah Martinez
Mike Anderson


11. For any rating where the reviewer is the same as the director of the movie, return the reviewer name, movie title, and number of stars.

select r.name,m.title from reviewer r join movie m join rating rg on m.mid=rg.mID and r.rid=rg.rID where r.name in (select director from movie);

James Cameron|Avatar


12. Return all reviewer names and movie names together in a single list, alphabetized. (Sorting by the first name of the reviewer and first word in the title is fine;
    no need for special processing on last names or removing "The".)

select r.name,m.title from reviewer r join movie m join rating rg on m.mid=rg.mID and r.rid=rg.rID order by r.name,m.title;

Ashley White|E.T.
Brittany Harris|Raiders of the Lost Ark
Brittany Harris|Raiders of the Lost Ark
Brittany Harris|The Sound of Music
Chris Jackson|E.T.
Chris Jackson|Raiders of the Lost Ark
Chris Jackson|The Sound of Music
Daniel Lewis|Snow White
Elizabeth Thomas|Avatar
Elizabeth Thomas|Snow White
James Cameron|Avatar
Mike Anderson|Gone with the Wind
Sarah Martinez|Gone with the Wind
Sarah Martinez|Gone with the Wind


13. Find the titles of all movies not reviewed by Chris Jackson.

select r.name,m.title from reviewer r join movie m join rating rg on m.mid=rg.mID and r.rid=rg.rID where r.name!="Chris Jackson";

Sarah Martinez|Gone with the Wind
Sarah Martinez|Gone with the Wind
Daniel Lewis|Snow White
Brittany Harris|The Sound of Music
Brittany Harris|Raiders of the Lost Ark
Brittany Harris|Raiders of the Lost Ark
Mike Anderson|Gone with the Wind
Elizabeth Thomas|Snow White
Elizabeth Thomas|Avatar
James Cameron|Avatar
Ashley White|E.T.


14. For all pairs of reviewers such that both reviewers gave a rating to the same movie, return the names of both reviewers.
    Eliminate duplicates, don't pair reviewers with themselves, and include each pair only once. For each pair, return the names in the pair in alphabetical order.

select rev1.name,rev2.name from Rating r1 join Rating r2 on r1.mID=r2.mID  and r1.rID<>r2.rID 
join Reviewer rev1 on rev1.rID=r1.rID join Reviewer rev2 on rev2.rID=r2.riD where r1.rID<r2.rID group by rev1.name,rev2.name;

Brittany Harris|Chris Jackson
Chris Jackson|Ashley White
Daniel Lewis|Elizabeth Thomas
Elizabeth Thomas|James Cameron
Sarah Martinez|Mike Anderson


15. For each rating that is the lowest (fewest stars) currently in the database, return the reviewer name, movie title, and number of stars.

select distinct r.name,m.title,rg.stars from reviewer r join movie m join rating rg on m.mid=rg.mID and r.rid=rg.rID where rg.stars=(select min(stars) from rating);

Sarah Martinez|Gone with the Wind|2
Brittany Harris|The Sound of Music|2
Brittany Harris|Raiders of the Lost Ark|2
Chris Jackson|E.T.|2


16. List movie titles and average ratings, from highest-rated to lowest-rated. If two or more movies have the same average rating, list them in alphabetical order.

select distinct(m.title),avg(r.stars) from movie m join rating r on m.mid=r.mID group by m.title order by avg(r.stars) desc,m.title ;

Snow White|4.5
Avatar|4.0
Raiders of the Lost Ark|3.33333333333333
Gone with the Wind|3.0
E.T.|2.5
The Sound of Music|2.5


17. Find the names of all reviewers who have contributed three or more ratings. (As an extra challenge, try writing the query without HAVING or without COUNT.)

USING COUNT
select r.name from reviewer r join rating rg on r.rid=rg.rid group by rg.rid having count(rg.rid)>2;

Brittany Harris
Chris Jackson


18. Some directors directed more than one movie. For all such directors, return the titles of all movies directed by them, along with the director name.
 Sort by director name, then movie title.(As an extra challenge, try writing the query both with and without COUNT.)

select distinct m1.director,m1.title from movie m1 join movie m2 on m1.director=m2.director and m1.mid<>m2.mid order by m1.director,m1.title;

James Cameron|Avatar
James Cameron|Titanic
Steven Spielberg|E.T.
Steven Spielberg|Raiders of the Lost Ark


19. Find the movie(s) with the highest average rating. Return the movie title(s) and average rating. 
    (Hint: This query is more difficult to write in SQLite than other systems; you might think of it as finding the highest average rating and 
	then choosing the movie(s) with that average rating.)

select t1.t,max(t1.s) from (select distinct(m.title)as t,avg(r.stars)as s from movie m join rating r 
on m.mid=r.mID group by m.title order by avg(r.stars) desc,m.title)as t1 ;

Snow White|4.5


20. Find the movie(s) with the lowest average rating. Return the movie title(s) and average rating. 
   (Hint: This query may be more difficult to write in SQLite than other systems; 
    you might think of it as finding the lowest average rating and then choosing the movie(s) with that average rating.)

select t1.t,min(t1.s) from (select distinct(m.title)as t,avg(r.stars)as s from movie m join rating r on m.mid=r.mID group by m.title order by avg(r.stars) desc,m.title)as t1 ;

E.T.|2.5


21. For each director, return the director's name together with the title(s) of the movie(s) they directed that received the highest rating among all of their movies,
     and the value of that rating. Ignore movies whose director is NULL.

select  director,title,max(stars) from movie join rating r on r.mID=movie.mID where  director is not null group by  director having max(stars);

James Cameron|Avatar|5
Robert Wise|The Sound of Music|3
Steven Spielberg|Raiders of the Lost Ark|4
Victor Fleming|Gone with the Wind|4



