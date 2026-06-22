USE PortfolioProject
GO

SELECT *
FROM dbo.NashVilleHousing

-------------------------------------------------------------------------------------------------
-- Looking at SaleDate and standardize date format

SELECT SaleDate, CONVERT(Date,SaleDate)
FROM dbo.NashVilleHousing

ALTER TABLE NashVilleHousing
ADD SaleDateConverted Date;

UPDATE NashVilleHousing
SET SaleDateConverted = CONVERT(Date,SaleDate)

SELECT SaleDateConverted
FROM dbo.NashVilleHousing

-------------------------------------------------------------------------------------------------
-- Populate Property Address Data

SELECT *
FROM dbo.NashVilleHousing
WHERE PropertyAddress is NULL

-- We found 29 null values on Property Address Data field
-- By observation, we concluded that ParcelID has always the same address despite distinct UniqueIDs, meaning we can have same address for diferent advertising
-- Therefore, it is possible to find the missing values

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM dbo.NashVilleHousing a
JOIN dbo.NashVilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM dbo.NashVilleHousing a
JOIN dbo.NashVilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

SELECT *
FROM dbo.NashVilleHousing
WHERE PropertyAddress is NULL

-- Results: No more null values on PropertAddress field.

-------------------------------------------------------------------------------------------------

-- Breaking out address into individual columns (Address, City)

SELECT PropertyAddress
FROM dbo.NashVilleHousing

SELECT
	SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) AS Address,
	SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) AS City
FROM 
	dbo.NashVilleHousing

ALTER TABLE dbo.NashVilleHousing
ADD PropertySplitAddress nvarchar(255), PropertySplitCity nvarchar(255)

SELECT *
FROM dbo.NashVilleHousing

UPDATE dbo.NashVilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) 

UPDATE dbo.NashVilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))


-- Working on the OwnerAddress field
SELECT 
	PARSENAME(REPLACE(OwnerAddress,',','.'),3),
	PARSENAME(REPLACE(OwnerAddress,',','.'),2),
	PARSENAME(REPLACE(OwnerAddress,',','.'),1)
FROM dbo.NashVilleHousing

ALTER TABLE dbo.NashVilleHousing
ADD OwnerSplitAddress nvarchar(255), OwnerSplitCity nvarchar(255), OwnerSplitState nvarchar(255)

UPDATE dbo.NashVilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',','.'),3)

UPDATE dbo.NashVilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',','.'),2)

UPDATE dbo.NashVilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',','.'),1)

-------------------------------------------------------------------------------------------------
-- Replacing 'Y' and 'N' by 'Yes' and 'No'

SELECT DISTINCT SoldAsVacant, COUNT(SoldasVacant) 
FROM dbo.NashVilleHousing
GROUP BY SoldAsVacant
ORDER BY 2



SELECT SoldAsVacant,
CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
	END
FROM dbo.NashVilleHousing



UPDATE dbo.NashVilleHousing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
						WHEN SoldAsVacant = 'N' THEN 'No'
						ELSE SoldAsVacant
						END
	

-------------------------------------------------------------------------------------------------
-- Remove Duplicates

WITH RowNumCTE AS(
SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY 
					ParcelID, 
					PropertyAddress,
					SalePrice,
					SaleDate,
					LegalReference
					ORDER BY
						UniqueID
						) row_num
FROM dbo.NashVilleHousing

)

DELETE
FROM RowNumCTE
WHERE row_num>1



WITH RowNumCTE AS(
SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY 
					ParcelID, 
					PropertyAddress,
					SalePrice,
					SaleDate,
					LegalReference
					ORDER BY
						UniqueID
						) row_num
FROM dbo.NashVilleHousing

)

SELECT *
FROM RowNumCTE
WHERE row_num>1


-------------------------------------------------------------------------------------------------
-- Delete Unused Columns

SELECT *
FROM dbo.NashVilleHousing

ALTER TABLE dbo.NashVilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

ALTER TABLE dbo.NashVilleHousing
DROP COLUMN SaleDate