-- SELECT *
-- FROM specs;

-- SELECT 
-- 	movie_id,
-- 	film_title
-- FROM specs;

-- SELECT
-- 	COUNT(movie_id)
-- FROM specs;

-- SELECT
-- 	AVG(length_in_min)
-- FROM specs;


-- SELECT
-- 	mpaa_rating,
-- 	AVG(length_in_min)
-- FROM specs
-- GROUP BY mpaa_rating;

-- SELECT
-- 	MAX(length_in_min) AS longest_movie_min,
-- 	MIN(length_in_min) AS shortest_movie_min
-- FROM specs;


-- SELECT DISTINCT (domestic_distributor_id)
-- FROM specs;

-- SELECT *
-- FROM specs
-- WHERE domestic_distributor_id = 86124
-- AND mpaa_rating IN ('G', 'PG')
-- AND length_in_min BETWEEN 100 AND 120
-- AND film_title LIKE 'Frozen%';

-- SELECT 
-- 	movie_id,
-- 	film_title,
-- 	release_year, 
-- 	mpaa_rating
-- FROM specs
-- WHERE mpaa_rating IS NULL;

-- SELECT film_title,
-- 	length_in_min,
-- 	length_in_min/60.0  AS length_in_hrs
-- FROM specs;

SELECT 
	film_title,
	length_in_min,
	release_year
FROM specs
WHERE release_year = 2000
ORDER BY length_in_min
LIMIT 10;

SELECT * FROM rating;


