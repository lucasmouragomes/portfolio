SELECT company_name,
    COUNT(trip_id) AS trips_amount
FROM trips
    LEFT JOIN cabs ON trips.cab_id = cabs.cab_id
WHERE start_ts::date BETWEEN '2017-11-15' AND '2017-11-16'
GROUP BY company_name
ORDER BY trips_amount DESC;
SELECT company_name,
    COUNT(trip_id) AS trips_amount
FROM trips
    LEFT JOIN cabs ON trips.cab_id = cabs.cab_id
WHERE start_ts::date BETWEEN '2017-11-01' AND '2017-11-07'
    AND (
        company_name LIKE '%Yellow%'
        OR company_name like '%Blue%'
    )
GROUP BY company_name;
SELECT company,
    COUNT(company) AS trips_amount
FROM (
        SELECT COALESCE(
                CASE
                    WHEN company_name = 'Flash Cab' THEN company_name
                    ELSE NULL
                END,
                CASE
                    WHEN company_name = 'Taxi Affiliation Services' THEN company_name
                    ELSE NULL
                END,
                'Other'
            ) AS company
        FROM trips
            LEFT JOIN cabs ON trips.cab_id = cabs.cab_id
        WHERE start_ts::date BETWEEN '2017-11-01' AND '2017-11-07'
    ) AS SUBQ
GROUP BY company
ORDER BY trips_amount DESC;
SELECT neighborhood_id,
    name
FROM neighborhoods
WHERE name LIKE '%Hare'
    OR name LIKE 'Loop';
SELECT ts,
    CASE
        WHEN description LIKE '%rain%'
        OR description LIKE '%storm%' THEN 'Bad'
        ELSE 'Good'
    END AS weather_conditions
FROM weather_records;
SELECT start_ts,
    CASE
        WHEN description LIKE '%rain%'
        OR description LIKE '%storm%' THEN 'Bad'
        ELSE 'Good'
    END AS weather_conditions,
    duration_seconds
FROM (
        SELECT *
        FROM trips
            LEFT JOIN weather_records ON trips.start_ts = weather_records.ts
        WHERE EXTRACT(
                DOW
                FROM trips.start_ts
            ) = 6
    ) AS subq
WHERE pickup_location_id = 50
    AND dropoff_location_id = 63
    AND description IS NOT NULL
ORDER BY trip_id