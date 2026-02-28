-- 1.	Give the name, release year, and worldwide gross of the lowest grossing movie.
--"Semi-Tough"	1977	37187139
SELECT
	specs.film_title, 
	specs.release_year,
	revenue.worldwide_gross
FROM specs
LEFT JOIN revenue
	USING (movie_id)
ORDER BY revenue.worldwide_gross;

---------------------------------------------------------------------------------------------------
-- 2.	What year has the highest average imdb rating? - 1991 with 7.45 rating

SELECT
	specs.release_year, 
	ROUND(AVG(rating.imdb_rating),2) AS avg_imdb_rating
FROM specs
LEFT JOIN rating
	ON specs.movie_id = rating.movie_id
GROUP BY specs.release_year
ORDER BY avg_imdb_rating DESC;

---------------------------------------------------------------------------------------------------
-- 3.	What is the highest grossing G-rated movie? Which company distributed it?
--"Toy Story 4"	"G"	1073394593	"Walt Disney "

SELECT
	s.film_title,
	s.mpaa_rating,
	r.worldwide_gross,
	d.company_name
FROM specs s 
LEFT JOIN distributors d
	ON s.domestic_distributor_id = d.distributor_id
LEFT JOIN revenue r
	USING (movie_id) 
WHERE s.mpaa_rating = 'G'
GROUP BY s.film_title, d.company_name, s.mpaa_rating, r.worldwide_gross
ORDER BY r.worldwide_gross DESC;

---------------------------------------------------------------------------------------------------
-- 4.	Write a query that returns, for each distributor in the distributors table,
--the distributor name and the number of movies associated with that distributor in the movies table.
--Your result set should include all of the distributors, whether or not they have any movies
--in the movies table.
SELECT 
	DISTINCT company_name -- To check how many distributors are there
FROM distributors;

SELECT
	d.company_name, COUNT(s.film_title) AS no_of_movies
FROM distributors d
LEFT JOIN specs s
	ON d.distributor_id = s.domestic_distributor_id
GROUP BY d.company_name
ORDER BY no_of_movies DESC;

---------------------------------------------------------------------------------------------------
-- 5.	Write a query that returns the five distributors with the highest average movie budget.

SELECT
	d.company_name, 
	ROUND(AVG(r.film_budget),2) AS avg_movie_budget 
FROM distributors d
INNER JOIN specs s
	ON d.distributor_id = s.domestic_distributor_id
INNER JOIN revenue r
	ON r.movie_id = s.movie_id
GROUP BY d.company_name
ORDER BY avg_movie_budget DESC
LIMIT 5;

---------------------------------------------------------------------------------------------------
-- 6.	How many movies in the dataset are distributed by a company which is not headquartered 
--in California? 2
--Which of these movies has the highest imdb rating?
-- "Dirty Dancing"	"Vestron Pictures"	7.0
SELECT
	COUNT(s.movie_id) AS no_of_movies,
	s.film_title,
	d.company_name,
	r.imdb_rating
FROM specs s
INNER JOIN distributors d
	ON d.distributor_id = s.domestic_distributor_id
INNER JOIN rating r
	ON r.movie_id = s.movie_id
WHERE d.headquarters NOT LIKE '%CA%'
GROUP BY d.company_name, r.imdb_rating, s.film_title
ORDER BY r.imdb_rating DESC;

---------------------------------------------------------------------------------------------------
-- 7.	Which have a higher average rating, movies which are over two hours long or movies which 
--are under two hours? - Movies over 2 hours have highest average rating.

SELECT
	CASE WHEN s.length_in_min > 120 THEN 'over'
		 WHEN s.length_in_min < 120 THEN 'under'
		 ELSE 'Not Available'
		 END AS duration,
		 COUNT(length_in_min) AS no_of_movies,
		 ROUND(AVG(r.imdb_rating),2) AS avg_rating
FROM specs s
LEFT JOIN rating r
	USING (movie_id)
GROUP BY duration
ORDER BY avg_rating DESC;
---------------------------------------------------------------------------------------------------
