# Invoice/Packing Slip - Field Mappings

## Table Migration
- **Old Tables**: `cr91f_salesorder` + `cr91f_salesorderheader` (joined) + `new_qbocustomer`
- **New Tables**: `cr91f_salesorderlineitem` + `new_qbocustomer`

## Major Structural Changes
- **Eliminated JOIN** to `cr91f_salesorderheader` - all header data now embedded in line item table
- **Fixed customer JOIN** from GUID mismatch to proper field mapping
- **Denormalized structure** - header info now repeated in each line item row

## Line Item Field Mappings

| Original Field | New Field | Alias Used | Notes |
|---|---|---|---|
| `soli.cr91f_salesorderid` | `soli.cr91f_salesorderlineitemid` | `SalesOrderId` | Primary key changed |
| `soli.cr91f_farmproductorderedname` | `soli.cr91f_farmproductorderedname` | `FarmProductOrderedName` | No change |
| `soli.cr91f_quantity` | `soli.cr91f_quantityordered` | `Quantity` | Field renamed |
| `soli.cr91f_orderuomname` | `soli.cr91f_orderuomname` | `OrderUomName` | No change |
| `soli.cr91f_lotnumberoriginal` | `soli.cr91f_lotnumberoriginal` | `LotNumberOriginal` | No change |
| `soli.cr91f_salesordernumber` | `soli.cr91f_salesorderlinenumber` | `LineNumber` | Different purpose - line number vs order number |
| `soli.cr91f_unitprice` | `soli.cr91f_unitprice` | `UnitPrice` | No change |
| `soli.cr91f_extendedprice` | `soli.cr91f_extendedprice` | `ExtendedPrice` | No change |
| `soli.cr91f_notes` | `soli.cr91f_customerlinenotes` | `LineNotes` | Field renamed |

## Header Field Mappings (Previously from cr91f_salesorderheader)

| Original Field | New Field | Alias Used | Notes |
|---|---|---|---|
| `soh.cr91f_salesordernumber` | `soli.cr91f_salesordernumbername` | `SalesOrderNumber` | Now from line item table |
| `soh.cr91f_pickupdatetime` | `soli.cr91f_pickupdate` | `PickupDateTime` | Date field type may differ |
| `soh.cr91f_customername` | `c.new_fullyqualifiedname` | `CustomerName` | Now from customer table |
| `soh.cr91f_orderdate` | `soli.cr91f_orderdate` | `OrderDate` | Now from line item table |
| `soh.cr91f_ponumber` | `soli.cr91f_ponumber` | `PoNumber` | Now from line item table |
| `soh.cr91f_qbocustomerdisplayname` | `soli.cr91f_qbocustomerdisplayname` | `QboCustomerDisplayName` | Now from line item table |
| `soh.cr91f_shippingmethodname` | `soli.cr91f_shippingmethod` | `ShippingMethodName` | Now from line item table |

## Customer Field Mappings (No Changes)

| Field | Alias Used | Notes |
|---|---|---|
| `c.new_billaddrline1` | `BillAdd1` | Shortened for compatibility |
| `c.new_billaddrline2` | `BillAdd2` | Shortened for compatibility |
| `c.new_billaddrline3` | `BillAdd3` | Shortened for compatibility |
| `c.new_billaddrcity` | `BillCity` | No change |
| `c.new_billaddrcountrysubdivisioncode` | `BillState` | No change |
| `c.new_billaddrpostalcode` | `BillPostalCode` | No change |
| `c.new_billaddrcountry` | `BillCountry` | No change |
| `c.new_shipaddrline1` | `ShipAdd1` | Shortened for compatibility |
| `c.new_shipaddrline2` | `ShipAdd2` | Shortened for compatibility |
| `c.new_shipaddrline3` | `ShipAdd3` | Shortened for compatibility |
| `c.new_shipaddrcity` | `ShipCity` | No change |
| `c.new_shipaddrcountrysubdivisioncode` | `ShipState` | No change |
| `c.new_shipaddrpostalcode` | `ShipPostalCode` | No change |
| `c.new_shipaddrcountry` | `ShipCountry` | No change |
| `c.new_shipaddrnote` | `ShipAddressNote` | No change |
| `c.new_primaryphonefreeform` | `PrimaryPhone` | No change |
| `c.new_alternatephonefreeform` | `AlternatePhone` | No change |
| `c.new_mobilephonefreeform` | `MobilePhone` | No change |
| `c.new_faxfreeform` | `FaxNumber` | No change |
| `c.new_primaryemailaddr` | `EmailAddress` | No change |
| `c.new_webaddruri` | `Website` | No change |
| `c.new_displayname` | `CustomerDisplayName` | No change |
| `c.new_fullyqualifiedname` | `CustomerFullName` | No change |
| `c.new_printoncheckname` | `CustomerPrintName` | No change |
| `c.new_notes` | `CustomerNotes` | No change |
| `c.new_salestermref` | `PaymentTerms` | No change |
| `c.new_paymentmethodref` | `PaymentMethod` | No change |
| `c.new_taxablename` | `IsTaxable` | No change |
| `c.new_defaulttaxcoderef` | `TaxCode` | No change |
| `c.new_balance` | `CustomerBalance` | No change |

## Critical JOIN Fix
- **Old JOIN**: `ON soh.cr91f_qbocustomer = c.new_QBOCustomerId` (GUID to GUID)
- **New JOIN**: `ON soli.cr91f_qbocustomerid = c.new_qbocustomeridentifier` (Customer ID to Customer ID)

## Query Structure Changes
1. **Removed JOIN** to `cr91f_salesorderheader` entirely
2. **Single table source** for line items: `cr91f_salesorderlineitem`
3. **Maintained LEFT JOIN** to `new_qbocustomer` with corrected field mapping
4. **WHERE clause** now uses `soli.cr91f_salesordernumbername` instead of header table reference

## SSRS Expression Updates Required
- **Header/Footer expressions** require dataset scope: `=First(Fields!FieldName.Value, "SalesOrderData")`
- **Aggregate expressions** require dataset scope: `=Sum(Fields!ExtendedPrice.Value, "SalesOrderData")`
- **Field references** updated to use new aliases - most maintained backward compatibility

## Related Dataset Updates
- **LastInvoiceEntered dataset** should be updated from `cr91f_salesorderheader` to `cr91f_salesorderlineitem`

## Performance Considerations
- **Improved performance** expected due to elimination of JOIN operation
- **Data duplication** in result set due to denormalized structure (header data repeated per line item)
- **Same filtering efficiency** maintained with proper indexing on sales order number field