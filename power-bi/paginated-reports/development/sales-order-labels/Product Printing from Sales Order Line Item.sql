SELECT 
    soli.cr91f_salesorderlineitemid as SalesOrderLineNumber,
    soli.cr91f_farmproductorderedname as FarmProductOrderedName,
    soli.cr91f_quantityordered as Quantity,
    soli.cr91f_orderuomname as UOMOrdered,
    soli.cr91f_lotnumberoriginal as LotNumberOriginal,
    soli.cr91f_pickupdate as PickUpDate,
    num.cr91f_value as LabelNumber
FROM cr91f_salesorderlineitem soli
INNER JOIN cr91f_number num
    ON num.cr91f_value <= soli.cr91f_quantityordered
WHERE soli.cr91f_salesordernumbername = @SalesOrderNumber
    AND soli.cr91f_quantityordered > 0
    AND num.cr91f_value <= @MaxLabels
ORDER BY soli.cr91f_salesorderlineitemid, num.cr91f_value