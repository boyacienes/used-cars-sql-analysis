/*
===========================================================
USED CARS SQL ANALYSIS PROJECT
===========================================================

Dataset:
Audi, BMW, Mercedes

Topics:
- UNION ALL
- GROUP BY
- AVG / COUNT
- JOIN
- CASE WHEN
- Subqueries
- Window Functions
- ROW_NUMBER()
===========================================================
*/


/*
===========================================================
1. HANGİ MARKADAN KAÇ ADET ARAÇ VAR?
===========================================================
*/

SELECT
    'Audi' AS brand,
    COUNT(*) AS car_count
FROM audi

UNION ALL

SELECT
    'Ford' AS brand,
    COUNT(*) AS car_count
FROM ford

UNION ALL

SELECT
    'BMW' AS brand,
    COUNT(*) AS car_count
FROM bmw

UNION ALL

SELECT
    'Hyundai' AS brand,
    COUNT(*) AS car_count
FROM hyundi

UNION ALL

SELECT
    'Mercedes' AS brand,
    COUNT(*) AS car_count
FROM merc

UNION ALL

SELECT
    'Skoda' AS brand,
    COUNT(*) AS car_count
FROM skoda

UNION ALL

SELECT
    'Toyota' AS brand,
    COUNT(*) AS car_count
FROM toyota;


/*
===========================================================
2. AYNI MARKA İÇİNDE OTOMATİK VE MANUEL ARAÇLARIN
   ORTALAMA FİYAT FARKI NEDİR?
===========================================================
*/

-- Audi
SELECT
    transmission,
    AVG(price) AS average_price
FROM audi
GROUP BY transmission
ORDER BY average_price DESC;


-- BMW
SELECT
    transmission,
    AVG(price) AS average_price
FROM bmw
GROUP BY transmission
ORDER BY average_price DESC;


-- Ford
SELECT
    transmission,
    AVG(price) AS average_price
FROM ford
GROUP BY transmission
ORDER BY average_price DESC;


/*
===========================================================
3. MOTOR HACMİ İLE FİYAT ARASINDA NASIL BİR İLİŞKİ VAR?
   (Audi)
===========================================================
*/

SELECT
    engineSize,
    COUNT(*) AS car_count,
    AVG(price) AS average_price
FROM audi
GROUP BY engineSize
ORDER BY engineSize DESC;


/*
===========================================================
4. AYNI MOTOR HACMİNE SAHİP AUDI VE BMW ARAÇLARININ
   ORTALAMA FİYATLARINI KARŞILAŞTIR
===========================================================
*/

SELECT
    A.engineSize,
    A.audi_avg_price,
    B.bmw_avg_price
FROM
(
    SELECT
        engineSize,
        AVG(price) AS audi_avg_price
    FROM audi
    GROUP BY engineSize
) AS A

INNER JOIN
(
    SELECT
        engineSize,
        AVG(price) AS bmw_avg_price
    FROM bmw
    GROUP BY engineSize
) AS B
    ON A.engineSize = B.engineSize

ORDER BY A.engineSize;


/*
===========================================================
5. AYNI ÖZELLİKLERE SAHİP AUDI, BMW VE MERCEDES
   ARAÇLARINDAN HANGİSİNİN ORTALAMA FİYATI DAHA YÜKSEK?
   
   Karşılaştırılan özellikler:
   - Engine Size
   - Transmission
   - Year
===========================================================
*/

SELECT
    A.engineSize,
    A.transmission,
    A.year,
    A.avg_audi_price,
    B.avg_bmw_price,
    C.avg_mercedes_price,

    CASE
        WHEN A.avg_audi_price > B.avg_bmw_price
         AND A.avg_audi_price > C.avg_mercedes_price
            THEN 'AUDI PAHALI'

        WHEN B.avg_bmw_price > A.avg_audi_price
         AND B.avg_bmw_price > C.avg_mercedes_price
            THEN 'BMW PAHALI'

        WHEN C.avg_mercedes_price > A.avg_audi_price
         AND C.avg_mercedes_price > B.avg_bmw_price
            THEN 'MERCEDES PAHALI'

        ELSE 'ESIT'
    END AS which_brand_is_more_expensive

FROM
(
    SELECT
        transmission,
        year,
        engineSize,
        AVG(price) AS avg_audi_price
    FROM audi
    GROUP BY transmission, year, engineSize
) AS A

INNER JOIN
(
    SELECT
        transmission,
        year,
        engineSize,
        AVG(price) AS avg_bmw_price
    FROM bmw
    GROUP BY transmission, year, engineSize
) AS B
    ON A.engineSize = B.engineSize
   AND A.transmission = B.transmission
   AND A.year = B.year

INNER JOIN
(
    SELECT
        transmission,
        year,
        engineSize,
        AVG(price) AS avg_mercedes_price
    FROM merc
    GROUP BY transmission, year, engineSize
) AS C
    ON A.engineSize = C.engineSize
   AND A.transmission = C.transmission
   AND A.year = C.year;


/*
===========================================================
6. 2018 VE SONRASI OTOMATİK ARAÇLARDA,
   AYNI MOTOR HACMİNE SAHİP ARAÇLAR ARASINDA
   HANGİ MARKANIN ORTALAMA FİYATI DAHA YÜKSEK?
===========================================================
*/

SELECT
    A.engineSize,
    A.avg_audi_price,
    B.avg_bmw_price,
    C.avg_mercedes_price,

    CASE
        WHEN A.avg_audi_price > B.avg_bmw_price
         AND A.avg_audi_price > C.avg_mercedes_price
            THEN 'AUDI PAHALI'

        WHEN B.avg_bmw_price > A.avg_audi_price
         AND B.avg_bmw_price > C.avg_mercedes_price
            THEN 'BMW PAHALI'

        WHEN C.avg_mercedes_price > A.avg_audi_price
         AND C.avg_mercedes_price > B.avg_bmw_price
            THEN 'MERCEDES PAHALI'

        ELSE 'ESIT'
    END AS which_brand_is_more_expensive

FROM
(
    SELECT
        AVG(price) AS avg_audi_price,
        engineSize
    FROM audi
    WHERE year >= 2018
      AND transmission = 'automatic'
    GROUP BY engineSize
) AS A

INNER JOIN
(
    SELECT
        AVG(price) AS avg_bmw_price,
        engineSize
    FROM bmw
    WHERE year >= 2018
      AND transmission = 'automatic'
    GROUP BY engineSize
) AS B
    ON A.engineSize = B.engineSize

INNER JOIN
(
    SELECT
        AVG(price) AS avg_mercedes_price,
        engineSize
    FROM merc
    WHERE year >= 2018
      AND transmission = 'automatic'
    GROUP BY engineSize
) AS C
    ON A.engineSize = C.engineSize;


/*
===========================================================
7. HER MARKANIN EN PAHALI 3 ARABASINI BUL
===========================================================
*/

SELECT *
FROM
(
    SELECT
        brand,
        model,
        year,
        price,
        mileage,
        engineSize,

        ROW_NUMBER() OVER
        (
            PARTITION BY brand
            ORDER BY price DESC
        ) AS row_number

    FROM
    (
        SELECT
            'Audi' AS brand,
            model,
            year,
            price,
            mileage,
            engineSize
        FROM audi

        UNION ALL

        SELECT
            'BMW' AS brand,
            model,
            year,
            price,
            mileage,
            engineSize
        FROM bmw

        UNION ALL

        SELECT
            'Mercedes' AS brand,
            model,
            year,
            price,
            mileage,
            engineSize
        FROM merc
    ) AS all_cars
) AS ranked_cars

WHERE row_number <= 3

ORDER BY brand, price DESC;
