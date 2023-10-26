/* Create an ER diagram or draw a schema for the given database. 

Step 1 : Click on database, Select "Reverse Engineer"
Step 2 : Set parameters for connecting to DBMS,Click next.
Step 3 : It will connect to DBMS and fetch information, Cick next.
Step 4 : Select the database to Reverse Engineer, Eg MavenMovies or Ig.clone
Step 5 : Information will be retrieved ,Cick Next
Step 6 : Confirm objects to reverse engineer ,Execute and Finish   */


/* Question 2 - We want to reward the user who has been around the longest, Find the 5 oldest users. */

select  * from users;
select username ,min(created_at) as TOP5 from users group by username order by min(created_at)  limit 5;
select username,created_at from users order by created_at limit 5;

/* Question 3 To target inactive users in an email ad campaign, find the users who have never posted a photo. */ 

select  * from users;
select * from photos;
select username ,id as Inactive_User from users u where id not in (select distinct user_id from photos);

/* Question 4 Suppose you are running a contest to find out who got the most likes on a photo. Find out who won? */

select * from likes;
select * from users;
select * from photos;

 with most_liked as
 ( SELECT photo_id,(COUNT(photo_id)) FROM Likes l
 GROUP BY photo_id ORDER BY COUNT(photo_id) DESC limit 1)
select u.username, m.photo_id from users u
 join photos p on u.id =  p.user_id join Most_liked M on p.id= m.photo_id;
 
 
/* Question 5  The investors want to know how many times does the average user post */

select * from comments;
select * from photos;
select (select count(*) from photos) / (select count(*) from users) as Average_post_per_user;

/* Question - 6 A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags. */

select * from tags ;
select *  from photo_tags;

select tag_name,tag_id,count(tag_id) from photo_tags pt join tags t on pt.tag_id = t.id
 group by (tag_id) order by count(tag_id) desc limit 5;
 
/* Question 7 -To find out if there are bots, find users who have liked every single photo on the site. */
  
  select * from likes;
  select * from photos;
  select * from users;
 With Bot_id  as (select user_id from likes group by user_id having count(photo_id) = (select count(id) from photos))
select u.username, b.user_id from users u join bot_id b on u.id = b.user_id ;

 /* Question 8 -Find the users who have created instagramid in may and select top 5 newest joinees from it? */
 
 select * from users;
select username,id,created_at from users where monthname(created_at) = 'May'
group by id order by max(created_at) desc limit 5;


 /* Question  9 Can you help me find the users whose name starts with c and ends with any number 
and have posted the photos as well as liked the photos? */ 

select *from photos;
with table1 as(
select username,id from users where username regexp '^c.*[0-9]$'),
 table2 as (
select user_id from likes l join  photos p using(user_id))
select username,id from table1 t1 join table2 t2 on t1.id = t2.user_id group by username;

/* Question 10 Demonstrate the top 30 usernames to the company who have posted photos in the range of 3 to 5. */

 select * from users;
 select * from photos;
select username,id from users where id in(
select user_id  from photos group by user_id having count(user_id) between 3 and 5 order by count(user_id) desc ) limit 30;






 
 