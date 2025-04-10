# Netflix-Data-Analysis-SQL-Tableau-

 **專案目的**  
本專案旨在分析 Netflix 數據，透過 PostgreSQL 撰寫 SQL 查詢，並以 Tableau 視覺化呈現內容趨勢、類型分佈、內容分級與全球來源，作為資料分析作品集示範。

---

## 📂 資料集來源
- 資料名稱：Netflix Movies and TV Shows（Kaggle）  
- 資料筆數：8,807 筆記錄  
- 資料範圍：2008–2021 年新增內容  
- 主要欄位：title, type, director, cast, country, release_year, date_added, rating, duration, listed_in, description

---

## 使用技術
- PostgreSQL 15（撰寫 SQL 查詢與資料處理）
- Tableau Desktop（製作互動式視覺化圖表）

---

## 📊 分析主題與結果摘要

### 1. Netflix 內容成長趨勢
- 查詢邏輯：依照年份與內容類型（Movie / TV Show）統計新增數量
- 結果摘要：2011 年起內容新增量大幅上升，TV Show 類型明顯成長
- 商業洞察：顯示 Netflix 擴展內容庫策略轉向影集型式以提升觀看時長與用戶黏著度

### 2.全球內容來源分布
- 查詢邏輯：將 `country` 欄位多國值拆分後統計各國出現次數
- 結果摘要：美國、印度、英國為前三大來源國
- 商業洞察：Netflix 主力來自英語系市場

### 3. 類型（Genre）分佈分析
- 查詢邏輯：解析 `listed_in` 欄位，統計各節目分類出現次數
- 🔍 結果摘要：Drama、International Movies、Comedy 排名前三
- 💡 商業洞察：觀眾偏好劇情與國際類型內容，策略上可強化熱門分類的深度與推薦系統

### 4. 內容分級（Rating）分析
- 查詢邏輯：依內容類型與分級統計筆數
- 結果摘要：TV-MA 為最主要分級，代表成人向內容比例高
- 商業洞察：內容策略以成熟觀眾為主，輔以 TV-14 / PG-13 滿足家庭觀眾

---

## SQL 查詢程式碼

本專案查詢語法已整理於 [`[sql_query/visulization_query.sql](https://github.com/PeiHsinChu/Netflix-Data-Analysis-SQL-Tableau-/blob/f79323875eea116a144524ad4b011a40e26c1422/sql_query/visulization_query.sql)`](./sql/visualization_query.sql)。

每段 SQL 對應一張視覺化圖表，具體範例如下：
```sql
-- 年度內容成長趨勢
SELECT EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY')) AS year,
       types,
       COUNT(*)
FROM netflix
GROUP BY 1, 2
ORDER BY 1, 2;
```

---

## Tableau 視覺化結果

### 展示方式：

**方式 A：Tableau Public（推薦）**  
🔗 [查看互動式儀表板（Tableau Public）](https://public.tableau.com/your_dashboard_link)  
 **方式 B：GitHub 圖片展示**  
可將 Tableau 截圖上傳至 `images/` 資料夾，README 內嵌如下：
```markdown
![內容成長趨勢](images/netflix_growth.png)
```

---

## 📁 專案結構
```
netflix-sql-project/
├── data/
│   └── netflix_titles.csv
├── sql/
│   └── visualization_query.sql
├── images/
│   └── *.png（Tableau 圖表截圖）
├── README.md
```
