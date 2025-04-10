-- 建立 Netflix 資料表
CREATE TABLE netflix (
    show_id VARCHAR(10),
    type VARCHAR(10),
    title VARCHAR(150),
    director VARCHAR(208),
    cast VARCHAR(1000),
    country VARCHAR(150),
    date_added VARCHAR(50),
    release_year INTEGER,
    rating VARCHAR(10),
    duration VARCHAR(15),
    listed_in VARCHAR(100),
    description VARCHAR(250)
);


-- 問題 1：計算電影和電視節目的數量
SELECT 
    types, 
    COUNT(*) AS total_content
FROM netflix
GROUP BY type;

-- 問題 2：找出電影和電視節目中最常見的評級
WITH rating_counts AS (
    SELECT 
        types, 
        rating, 
        COUNT(*) AS count,
        RANK() OVER (PARTITION BY types ORDER BY COUNT(*) DESC) AS ranking
    FROM Netflix
    GROUP BY types, rating
)
SELECT types, rating
FROM rating_counts
WHERE ranking = 1;

-- 問題 3：列出特定年份(2022)發布的所有電影
SELECT *
FROM netflix
WHERE types = 'Movie'
AND release_year = 2022;

-- 問題 4：找出Netflix上內容最多的前五個國家
    SELECT 
        TRIM(UNNEST(STRING_TO_ARRAY(country, ','))) AS country_name,
        COUNT(*) AS total_content
    FROM netflix
    GROUP BY country_name
	order by 2 desc
    LIMIT 5;

-- 問題 5：找出最長的電影
SELECT *
FROM netflix
WHERE types = 'Movie'
AND duration = (
    SELECT MAX(duration)
    FROM netflix
    WHERE types = 'Movie'
);

-- 問題 6：找出過去五年內添加的內容
SELECT *
FROM netflix
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years';

-- 問題 7：找出由導演Rajiv Chilaka執導的所有電影和電視節目
SELECT *
FROM netflix
WHERE director ILIKE '%Rajiv Chilaka%';

-- 問題 8：列出超過五季的所有電視節目
SELECT *
FROM netflix
WHERE types = 'TV Show'
AND CAST(SPLIT_PART(duration, ' ', 1) AS NUMERIC) > 5;

-- 問題 9：計算每個類型中的內容數量
SELECT 
    TRIM(UNNEST(STRING_TO_ARRAY(listed_in, ','))) AS genre, 
    COUNT(show_id) AS total_content
FROM netflix
GROUP BY 1
ORDER BY 2 DESC;

-- 問題 10：找出每年印度在Netflix上發布的內容平均數量，返回平均發布量最高的前五年
SELECT 
    EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY')) AS year,
    COUNT(show_id) AS content_count,
    ROUND(
        (COUNT(show_id)::NUMERIC / (SELECT COUNT(*) FROM Netflix WHERE country ILIKE '%India%')::NUMERIC) * 100,
        2
    ) AS percentage
FROM netflix
WHERE country ILIKE '%India%'
GROUP BY 1
ORDER BY 3 DESC
LIMIT 5;

-- 問題 11：列出所有紀錄片類型的電影
SELECT *
FROM netflix
WHERE listed_in ILIKE '%Documentaries%';

-- 問題 12：找出所有沒有導演的內容
SELECT *
FROM netflix
WHERE director IS NULL;

-- 問題 13：找出演員Salman Khan在過去10年中出演了多少部電影
SELECT *
FROM netflix
WHERE casts ilike '%Salman Khan%'
AND release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;

-- 問題 14：找出在印度製作的電影中出現次數最多的前10名演員
    SELECT 
        TRIM(UNNEST(STRING_TO_ARRAY(casts, ','))) AS actor,
        COUNT(*) AS total_content
    FROM Netflix
    WHERE country ILIKE '%India%'
    GROUP BY 1
    ORDER BY total_content DESC
    LIMIT 10;

-- 問題 15：根據描述字段中是否包含"kill"、"violence"等關鍵詞對內容進行分類
SELECT 
    category,
    COUNT(*) AS content_count
	FROM (
    SELECT 
        CASE 
            WHEN description ILIKE '%kill%' OR description ILIKE '%violence%' THEN 'Bad'
            ELSE 'Good'
        END AS category
    FROM netflix
) AS categorized_content
GROUP BY category;


     
 
