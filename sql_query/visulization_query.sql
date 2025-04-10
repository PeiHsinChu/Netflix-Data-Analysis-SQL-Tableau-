--1. 按年份和類型統計內容數量
select extract(year from to_date(date_added, 'Month DD, YYYY')) as year, types,count(*)
from netflix
group by 1,2
order by 1,2 

--2.找出Netflix上全球的內容分布
SELECT country_name, COUNT(*) AS total_content
FROM (
    SELECT TRIM(UNNEST(STRING_TO_ARRAY(country, ','))) AS country_name
    FROM netflix
    WHERE country IS NOT NULL
) AS country_split
GROUP BY country_name
ORDER BY total_content DESC;

--3.找出內容分布（沿用剛剛第九題）
SELECT 
    TRIM(UNNEST(STRING_TO_ARRAY(listed_in, ','))) AS genre, 
    COUNT(show_id) AS content_count
FROM netflix
GROUP BY genre
ORDER BY content_count DESC


--4.找出電影和電視節目中評級分佈
    SELECT 
        types, 
        rating, 
        COUNT(*) AS count
    FROM netflix
    GROUP BY 1,2



