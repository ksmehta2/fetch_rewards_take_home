Create schema Fetch_Rewards;
Use Fetch_Rewards;

-- Which brand saw the most dollars spent in the month of June?
SELECT B.NAME FROM BRANDS B
INNER JOIN RECEIPT_ITEMS RI
ON B.BARCODE=RI.BARCODE
INNER JOIN RECEIPTS R
ON RI.REWARDS_RECEIPT_ID=R.ID
WHERE MONTH(R.PURCHASE_DATE)=6
GROUP BY B.NAME
ORDER BY SUM(RI.TOTAL_FINAL_PRICE) DESC
LIMIT 1;

-- Which user spent the most money in the month of August?
SELECT U.ID FROM USERS U
INNER JOIN RECEIPTS R
ON U.ID=R.USER_ID
WHERE MONTH(R.PURCHASE_DATE)=8
GROUP BY U.ID
ORDER BY SUM(R.TOTAL_SPENT) DESC
LIMIT 1;

-- What user bought the most expensive item?
SELECT U.ID FROM USERS U
INNER JOIN RECEIPTS R
ON U.ID=R.USER_ID
INNER JOIN RECEIPT_ITEMS RI
ON R.ID=RI.REWARDS_RECEIPT_ID
ORDER BY CAST((RI.TOTAL_FINAL_PRICE/RI.QUANTITY_PURCHASED) as DECIMAL(7,2)) DESC
limit 1;

-- What is the name of the most expensive item purchased?
SELECT RI.DESCRIPTION FROM RECEIPT_ITEMS RI
ORDER BY RI.TOTAL_FINAL_PRICE/RI.QUANTITY_PURCHASED DESC
LIMIT 1;

-- How many users scanned in each month?
SELECT MONTH(R.DATE_SCANNED),COUNT(DISTINCT R.USER_ID)
FROM RECEIPTS AS R
GROUP BY MONTH(R.DATE_SCANNED);

-- Points 3 and 4 can be combined to find both the outputs with the resultant query-

SELECT U.ID,RI.DESCRIPTION FROM USERS U
INNER JOIN RECEIPTS R
ON U.ID=R.USER_ID
INNER JOIN RECEIPT_ITEMS RI
ON R.ID=RI.REWARDS_RECEIPT_ID
ORDER BY CAST((RI.TOTAL_FINAL_PRICE/RI.QUANTITY_PURCHASED) as DECIMAL(7,2)) DESC
limit 1;
