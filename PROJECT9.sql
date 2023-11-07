-- Ex1: Chuyển đổi kểu dữ liệu phù hợp
select * from sales_dataset_rfm_prj;
ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN ordernumber TYPE numeric
using ordernumber::numeric;

ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN quantityordered TYPE numeric
using quantityordered::numeric;

ALTER TABLE sales_dataset_rfm_prj 
ALTER COLUMN priceeach TYPE numeric 
using priceeach:: numeric;

ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN orderlinenumber TYPE numeric 
using orderlinenumber:: numeric;


ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN sales TYPE numeric using sales::numeric;

ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN sales TYPE varchar using sales::varchar; 

ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN msrp TYPE numeric using msrp::numeric;

ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN ORDERDATE TYPE TIMESTAMP using ORDERDATE::TIMESTAMP;

-- Ex2: Check NULL/BLANK (ORDERNUMBER,
--QUANTITYORDERED,
--PRICEEACH, ORDERLINENUMBER, SALES, ORDERDATE.
SELECT *FROM  sales_dataset_rfm_prj 
WHERE ORDERNUMBER IS NULL OR ORDERNUMBER= ' ';

SELECT *FROM  sales_dataset_rfm_prj 
WHERE QUANTITYORDERED IS NULL OR QUANTITYORDERED='';

SELECT *FROM  sales_dataset_rfm_prj 
WHERE PRICEEACH IS NULL OR PRICEEACH = '';

SELECT *FROM  sales_dataset_rfm_prj 
WHERE ORDERLINENUMBER IS NULL OR ORDERLINENUMBER = ''
  
SELECT* FROM  sales_dataset_rfm_prj 
WHERE SALES IS NULL OR SALES = '';

SELECT* FROM  sales_dataset_rfm_prj 
WHERE ORDERDATE IS NULL OR ORDERDATE = '';

-- EX3:Thêm cột CONTACTLASTNAME, CONTACTFIRSTNAME được tách ra từ
-- CONTACTFULLNAME 
--SELECT LEFT(contactfullname, (POSITION('-' IN contactfullname)-1))	AS CONTACTFIRSTNAME,
--RIGHT(contactfullname,(CHAR_LENGTH(contactfullname)- POSITION('-' IN contactfullname))) AS CONTACTLASTNAME
--FROM sales_dataset_rfm_prj; 

ALTER TABLE sales_dataset_rfm_prj
ADD COLUMN CONTACTFIRSTNAME varchar(30), 
ADD COLUMN CONTACTLASTNAME varchar(30);

UPDATE sales_dataset_rfm_prj
SET CONTACTFIRSTNAME=LEFT(contactfullname, (POSITION('-' IN contactfullname)-1))


UPDATE sales_dataset_rfm_prj
SET CONTACTLASTNAME=RIGHT(contactfullname,(CHAR_LENGTH(contactfullname)- POSITION('-' IN contactfullname)))


UPDATE sales_dataset_rfm_prj
SET CONTACTFIRSTNAME= INITCAP(contactfirstname);

UPDATE sales_dataset_rfm_prj
SET CONTACTLASTNAME=INITCAP(contactlastname);


SELECT*FROM sales_dataset_rfm_prj
--  EX4: Thêm cột QTR_ID, MONTH_ID, YEAR_ID lần lượt là
-- Qúy, tháng, năm được lấy ra từ ORDERDATE
SELECT 
EXTRACT(quarter FROM ORDERDATE) as QUY_ID,
EXTRACT(month FROM ORDERDATE) AS MONTH_ID, 
EXTRACT(year FROM ORDERDATE) AS YEAR_ID
FROM sales_dataset_rfm_prj;

ALTER TABLE sales_dataset_rfm_prj
ADD COLUMN QUY_ID numeric,
ADD COLUMN MONTH_ID numeric, 
ADD COLUMN YEAR_ID numeric;

UPDATE sales_dataset_rfm_prj
SET QUY_ID=EXTRACT(quarter FROM ORDERDATE);

UPDATE sales_dataset_rfm_prj
SET MONTH_ID= EXTRACT(day FROM ORDERDATE);

UPDATE sales_dataset_rfm_prj
SET YEAR_ID= EXTRACT(year FROM ORDERDATE);



-- EX5: Hãy tìm outlier (nếu có) cho cột QUANTITYORDERED 
-- và hãy chọn cách xử lý cho bản ghi đó (2 cách)
-- C1: DÙNG BOXLOT
SELECT* FROM sales_dataset_rfm_prj;

with twt_min_max_value AS (
SELECT Q1-1.5* IQR AS min_value, 
Q3+1.5*IQR AS max_value
FROM (
SELECT percentile_cont(0.25) WITHIN GROUP(ORDER BY quantityordered) AS Q1,
percentile_cont(0.75) WITHIN GROUP(ORDER BY quantityordered) AS Q3,
percentile_cont(0.75) WITHIN GROUP(ORDER BY quantityordered) -percentile_cont(0.25) 
WITHIN GROUP(ORDER BY quantityordered) AS IQR
FROM sales_dataset_rfm_prj
) as a
)

SELECT* FROM sales_dataset_rfm_prj
WHERE quantityordered < (SELECT min_value FROM twt_min_max_value)
OR quantityordered > (SELECT max_value FROM twt_min_max_value);

-- cách 2: sử dụng Z_SCORE=(quantityordered-avg)/stddev

WITH CTE AS (
  SELECT
    quantityordered,
    (SELECT AVG(quantityordered) FROM sales_dataset_rfm_prj) AS average,
    (SELECT STDDEV(quantityordered) FROM sales_dataset_rfm_prj) AS stddev
  FROM sales_dataset_rfm_prj
),
TWT_outlier AS (
  SELECT
    quantityordered,
    (quantityordered - average) / stddev AS z_score
  FROM CTE
  WHERE ABS((quantityordered - average) / stddev) > 3
)
SELECT * FROM TWT_outlier;

UPDATE sales_dataset_rfm_prj
SET quantityordered=(SELECT AVG(quantityordered) FROM sales_dataset_rfm_prj)
WHERE quantityordered IN (SELECT quantityordered FROM TWT_outlier); 

DELETE FROM sales_dataset_rfm_prj
WHERE quantityordered IN (SELECT quantityordered FROM TWT_outlier);

SELECT * INTO newtable 
FROM sales_dataset_rfm_prj;






