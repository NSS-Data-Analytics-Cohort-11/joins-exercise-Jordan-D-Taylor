-- 1. Give the name, release year, and worldwide gross of the lowest grossing movie.

SELECT specs.film_title, specs.release_year, revenue.worldwide_gross
FROM specs
INNER JOIN revenue
	ON specs.movie_id = revenue.movie_id
ORDER BY revenue.worldwide_gross
LIMIT 1;

-- Answer: Semi-Tough, 1977, 37187139


-- 2. What year has the highest average imdb rating?

SELECT specs.release_year, AVG(rating.imdb_rating) AS imdb_avg_rating
FROM specs
INNER JOIN rating
	ON specs.movie_id = rating.movie_id
GROUP by specs.release_year
ORDER BY imdb_avg_rating DESC;

-- Answer: 1991


-- 3. What is the highest grossing G-rated movie? Which company distributed it?

SELECT revenue.worldwide_gross, specs.mpaa_rating, specs.film_title, distributors.company_name
FROM specs
INNER JOIN distributors
	ON specs.domestic_distributor_id = distributors.distributor_id
INNER JOIN revenue
	ON specs.movie_id = revenue.movie_id
WHERE specs.mpaa_rating IN ('G')
ORDER BY revenue.worldwide_gross DESC;

-- Answer: Toy Story 4, Walt Disney


-- 4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.

SELECT distributors.company_name, COUNT(specs.film_title) AS film_count
FROM distributors
LEFT JOIN specs
	ON distributors.distributor_id = specs.domestic_distributor_id
GROUP BY distributors.company_name;

-- Answer: see query


-- 5. Write a query that returns the five distributors with the highest average movie budget.

SELECT distributors.company_name, AVG(revenue.film_budget) AS avg_film_budget
FROM distributors
INNER JOIN specs
	ON distributors.distributor_id = specs.domestic_distributor_id
INNER JOIN revenue
	ON specs.movie_id = revenue.movie_id
GROUP BY distributors.company_name
ORDER BY avg_film_budget DESC
LIMIT 5;

-- Answer: see query

-- 6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?

SELECT COUNT(specs.*) AS film_count, distributors.headquarters
FROM specs
INNER JOIN distributors
	ON distributors.distributor_id = specs.domestic_distributor_id
GROUP BY distributors.headquarters
HAVING distributors.headquarters NOT LIKE('%CA%')

-- Answer: 2

-- 7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?

SELECT ROUND(AVG(rating.imdb_rating), 2) AS avg_rating,
CASE WHEN length_in_min > 120 THEN '>2 Hours'
	ELSE '< 120'
END AS lengthtext
FROM specs
INNER JOIN rating
ON specs.movie_id = rating.movie_id
GROUP BY lengthtext
ORDER BY avg_rating DESC;

-- Answer: Movies that are over 2 hours long