create table netflix

(  show_id VARCHAR(7),
	type   VARCHAR(10),
	title  VARCHAR(150),
	director  VARCHAR(208),
	casts    VARCHAR(1000),
	country VARCHAR(150),
	date_added  VARCHAR(50),
	release_year  INT,
	rating   VARCHAR(10),
	duration VARCHAR(15),
	listed_in  VARCHAR(100),
	description VARCHAR(250)
    );
	select*from netflix;
	select count(*) as total_content from netflix;
	select distinct type from netflix;
	select*from netflix;
	-- question 1 count the no of movies vs tvshows
	select type,count(*)as 
	total_content from netflix
	group by type;
	--2 question find the most commmon rating for movies and tv show
	
	
	--3 question list all movies released in 2020
	select*from netflix 
	where
	type ='Movie'
	and 
	release_year=2020;

	--4 question find the top 5 countries with most content in netflix
	select
	unnest(string_to_array(country,','))as 
	new_country,
	count(show_id)as total_content
	from netflix
	group by 1
	order by 2 desc
	limit 5;

	--5 question identify the longest movie 
	select*from netflix 
	where type='Movie'
	and 
	duration=(select max(duration)from netflix)
	--6 question find content added in last 5 years
	select*from
	netflix
	where
	To_date(date_added,'month DD,YYYY')>=current_date-interval'5 years'
	--7 question find all movies/tv shows directed by 'rajiv chilaka'
	select*from netflix
	where director ilike '%rajiv chilaka%'
	--8 question list all tv shows with more than 5 seasons
	select *from 
	netflix
	where type='TV Show'
	and
	split_part (duration,' ',1)::numeric>5;
	--9 question count the no of items in each genre
	select
	unnest(string_to_array(listed_in,','))as genre,
	count(show_id)as total_content
	from netflix
	group by 1
	--10 questionfind each year and the average
	--no.of content release by india on netflix return 
	--top 5 year with highest avg content release
	
	select
	 extract (year from TO_DATE(date_added,'month DD,YYYY'))
	as year,
	count(*)as yearly_content,
	round(
count(*)::numeric/(select count(*)from netflix where
country='India')::numeric*100,2)as avg_content_per_year
 from netflix
where country='India'
group by 1

--question 11 list all movies that are documentaries
select*from netflix
where listed_in ILIKE '%documentaries%'

--question 12 find all content without a director 

select*from netflix 
where 
director IS NULL

--question 13 

select*from netflix
where
casts ILIKE'%Salman Khan%'
AND
Release_year>extract(year from current_date)-10

--question  14

select
unnest(STRING_TO_ARRAY(casts,','))as actors,
count(*) as total_content
from netflix
where country ILIKE('%india')
group by 1
order by 2 desc
limit 10
	
--question 15

WITH new_table
As
(
select
*,
CASE
when
  description ILIKE'%KILL%'OR
  description ILIKE'%VIOLENCE%'THEN 'Bad_content'
  else 'Good_content'
  end category
  from netflix
)
select category,
count(*)as total_content
from new_table
group by 1
	
	