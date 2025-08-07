-- Complete Invoice/Packing Slip Query with Customer Master Data - NEW TABLE VERSION
SELECT 
    -- Line Item Details
    soli.cr91f_salesorderlineitemid as SalesOrderId,
    soli.cr91f_farmproductorderedname as FarmProductOrderedName,
    soli.cr91f_quantityordered as Quantity,
    soli.cr91f_orderuomname as OrderUomName,
    soli.cr91f_lotnumberoriginal as LotNumberOriginal,
    soli.cr91f_salesorderlinenumber as LineNumber,
    soli.cr91f_unitprice as UnitPrice,
    soli.cr91f_extendedprice as ExtendedPrice,
    soli.cr91f_customerlinenotes as LineNotes,
    
    -- Header Info (now from line item table)
    soli.cr91f_salesordernumbername as SalesOrderNumber,
    soli.cr91f_pickupdate as PickupDateTime,
    c.new_fullyqualifiedname as CustomerName,
    soli.cr91f_orderdate as OrderDate,
    soli.cr91f_ponumber as PoNumber,
    soli.cr91f_qbocustomerdisplayname as QboCustomerDisplayName,
    soli.cr91f_shippingmethod as ShippingMethodName,
    
    -- Customer Bill-To Information
    c.new_billaddrline1 AS BillAdd1,
    c.new_billaddrline2 AS BillAdd2,
    c.new_billaddrline3 AS BillAdd3,
    c.new_billaddrcity AS BillCity,
    c.new_billaddrcountrysubdivisioncode AS BillState,
    c.new_billaddrpostalcode AS BillPostalCode,
    c.new_billaddrcountry AS BillCountry,
    
    -- Customer Ship-To Information  
    c.new_shipaddrline1 AS ShipAdd1,
    c.new_shipaddrline2 AS ShipAdd2,
    c.new_shipaddrline3 AS ShipAdd3,
    c.new_shipaddrcity AS ShipCity,
    c.new_shipaddrcountrysubdivisioncode AS ShipState,
    c.new_shipaddrpostalcode AS ShipPostalCode,
    c.new_shipaddrcountry AS ShipCountry,
    c.new_shipaddrnote AS ShipAddressNote,
    
    -- Customer Contact Information
    c.new_primaryphonefreeform AS PrimaryPhone,
    c.new_alternatephonefreeform AS AlternatePhone,
    c.new_mobilephonefreeform AS MobilePhone,
    c.new_faxfreeform AS FaxNumber,
    c.new_primaryemailaddr AS EmailAddress,
    c.new_webaddruri AS Website,
    
    -- Customer Business Information
    c.new_displayname AS CustomerDisplayName,
    c.new_fullyqualifiedname AS CustomerFullName,
    c.new_printoncheckname AS CustomerPrintName,
    c.new_notes AS CustomerNotes,
    
    -- Customer Financial Information
    c.new_salestermref AS PaymentTerms,
    c.new_paymentmethodref AS PaymentMethod,
    c.new_taxablename AS IsTaxable,
    c.new_defaulttaxcoderef AS TaxCode,
    c.new_balance AS CustomerBalance
    
FROM cr91f_salesorderlineitem soli
LEFT JOIN new_qbocustomer c
    ON soli.cr91f_qbocustomerid = c.new_qbocustomeridentifier
    
WHERE 
    soli.cr91f_salesordernumbername = @SalesOrderNumber
    AND soli.cr91f_quantityordered > 0
    
ORDER BY 
    soli.cr91f_salesorderlineitemid