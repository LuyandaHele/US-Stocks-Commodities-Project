-- Making a Copy of Stockdata To Clean Table
SELECT *
FROM us_stock_data;

CREATE TABLE stock_data_copy
LIKE us_stock_data;

INSERT INTO stock_data_copy
SELECT *
FROM us_stock_data;

-- stock_copy_data Data Cleaning
SELECT *
FROM stock_data_copy;

-- Checking For Duplicates : Double Checking Duplicates In the Index And Date Column
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY MyUnknownColumn,Date) As Duplicates_Number
FROM stock_data_copy;
-- Result : No Duplicates In Our Were Found

-- Standardizing Data : Renaming Columns, Appropiate Date Formatting,Trimming Spaces 

-- Renaming MyUnknownColumn To Record Index
ALTER TABLE stock_data_copy
RENAME COLUMN MyUnknownColumn TO Record_Index;
-- Result : Column Changed

-- Date Formatting : Changing all Date Formats That Are DD/MM/YYYY To DD-MM-YYYY
UPDATE stock_data_copy
SET Date = REPLACE(Date,'/','-')
WHERE Date LIKE '%/%';
-- Result : 'DD/MM/YYYY' Date Format Changed To 'DD-MM-YYY' Date Format 

-- TRIMMING DATE COLUMN 
SELECT Date,TRIM(Date)
FROM stock_data_copy;

UPDATE stock_data_copy
SET Date = TRIM(Date);
-- Result : Date Column Trimmed

-- Removing Columns 
-- Dropping Platinum_Vol. Column As There Is Mostly Blanks And Not Enough Data To Proceed With Data Exploration
ALTER TABLE stock_data_copy
DROP COLUMN Platinum_Vol;  -- Removed the trailing period










