SELECT *
FROM NashvilleHousing

/* Set standard date format */

ALTER TABLE NashvilleHousing
Add SaleDateNew Date;

UPDATE NashvilleHousing
SET SaleDateNew = CONVERT(Date, SaleDate)

/* Property Address*/

SELECT TableA.ParcelID, TableA.PropertyAddress, TableB.ParcelID, TableB.PropertyAddress, ISNULL(TableA.PropertyAddress, TableB.PropertyAddress)
FROM NashvilleHousing AS TableA JOIN NashvilleHousing AS TableB
      ON TableA.ParcelID = TableB.ParcelID
      AND TableA.UniqueID <> TableB.UniqueID
WHERE TableA.PropertyAddress is NULL

UPDATE TableA
SET PropertyAddress = ISNULL(TableA.PropertyAddress, TableB.PropertyAddress)
FROM NashvilleHousing AS TableA JOIN NashvilleHousing AS TableB
      ON TableA.ParcelID = TableB.ParcelID
      AND TableA.UniqueID <> TableB.UniqueID
WHERE TableA.PropertyAddress is NULL

/*Separate address into multiple coulmns*/

ALTER TABLE NashvilleHousing
ADD PropertySplitAddress Nvarchar(25);

UPDATE NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1)

ALTER TABLE NashvilleHousing
ADD PropertySplitCity Nvarchar(25);

UPDATE NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress))

/*Alternative Method*/
SELECT
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
FROM NashvilleHousing

ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress Nvarchar(255);

UPDATE NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE NashvilleHousing
ADD OwnerSplitCity Nvarchar(255);

UPDATE NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)

ALTER TABLE NashvilleHousing
Add OwnerSplitState Nvarchar(255);

UPDATE NashvilleHousing
ADD OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)

/*Change Y to Yes and N to No*/
SELECT
CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
     WHEN SoldAsVacant = 'N' THEN 'No'
     ELSE SoldAsVacant
     END
FROM NashvilleHousing

UPDATE NashvilleHousing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
                        WHEN SoldAsVacant = 'N' THEN 'No'
                        ELSE SoldAsVacant
                        END
                        
/*Remove duplicates*/

  
