# Sales Order Labels - Field Mappings

## Table Migration
- **Old Table**: `cr91f_salesorder` + `cr91f_salesorderheader` (joined)
- **New Table**: `cr91f_salesorderlineitem`

## Field Mappings

| Original Field | New Field | Alias Used | Notes |
|---|---|---|---|
| `cr91f_salesorderid` | `cr91f_salesorderlineitemid` | `SalesOrderLineNumber` | Primary key changed |
| `cr91f_farmproductorderedname` | `cr91f_farmproductorderedname` | `FarmProductOrderedName` | No change |
| `cr91f_quantity` | `cr91f_quantityordered` | `Quantity` | Field renamed |
| `cr91f_orderuomname` | `cr91f_orderuomname` | `UOMOrdered` | No change |
| `cr91f_lotnumberoriginal` | `cr91f_lotnumberoriginal` | `LotNumberOriginal` | No change |
| `soh.cr91f_pickupdatetime` | `cr91f_pickupdate` | `PickUpDate` | From header to line item |
| `soh.cr91f_salesordernumber` | `cr91f_salesordernumbername` | N/A | Used in WHERE clause |

## Query Changes
- Removed JOIN to `cr91f_salesorderheader` - data now in line item table
- Changed WHERE clause to use `cr91f_salesordernumbername` instead of header table reference

## SSRS Field References
All original field references maintained through aliases - no SSRS changes needed.