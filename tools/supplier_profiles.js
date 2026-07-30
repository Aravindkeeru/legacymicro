module.exports = {
  FEEDS: [
    {
      feed_code: 'EMS_INVENTORY',
      supplier_code: 'EMS',
      filename_pattern: /EMS Fabienne\.xls/i,
      feed_type: 'INVENTORY',
      sheet_index: 0,
      header_row: 0,
      mapping: {
        mpn: 'Manufacturer Reference',
        manufacturer: 'Manufacturer',
        description: 'description ',
        quantity: 'Quantité dispo'
      },
      default_availability: 'NETWORK_AVAILABLE'
    },
    {
      feed_code: 'NEW_XS_INVENTORY',
      supplier_code: 'NEW_XS',
      filename_pattern: /New XS_EU OEM_low prices/i,
      feed_type: 'INVENTORY',
      sheet_index: 0,
      header_row: 0,
      mapping: {
        mpn: 'MPN',
        manufacturer: 'Manufacturer',
        description: 'Description',
        quantity: 'Qty',
        date_code: 'DC'
      },
      default_availability: 'NETWORK_AVAILABLE'
    },
    {
      feed_code: 'RA_INVENTORY',
      supplier_code: 'RA',
      filename_pattern: /RA Componenets/i,
      feed_type: 'INVENTORY',
      sheet_index: 0,
      header_row: 1, // Skip the title row
      mapping: {
        mpn: 'PART NUMBER',
        manufacturer: 'MAKE',
        description: 'ITEM DESCRIPTION',
        quantity: 'Stock Qty',
        uom: 'UOM'
      },
      default_availability: 'NETWORK_AVAILABLE'
    },
    {
      feed_code: 'AGS_INVENTORY',
      supplier_code: 'AGS',
      filename_pattern: /STOCK_AGS/i,
      feed_type: 'INVENTORY',
      sheet_index: 0,
      header_row: 0,
      mapping: {
        mpn: 'ItemName', // Actually holds MPN
        manufacturer: 'CF.Brand Name#',
        description: 'Description',
        quantity: 'Stock On Hand',
        date_code: 'CF.Year#'
      },
      default_availability: 'NETWORK_AVAILABLE'
    },
    {
      feed_code: 'XS_INVENTORY',
      supplier_code: 'XS',
      filename_pattern: /XS_03\.26\.26/i,
      feed_type: 'INVENTORY',
      sheet_index: 0,
      header_row: 0,
      mapping: {
        mpn: 'MPN',
        manufacturer: 'Manufacturer',
        description: 'Description',
        quantity: 'Qty',
        date_code: 'DC'
      },
      default_availability: 'NETWORK_AVAILABLE'
    },
    {
      feed_code: 'INDUS_INVENTORY',
      supplier_code: 'INDUS',
      filename_pattern: /INDUS/i,
      sheet_name_pattern: /Sheet1/i,
      feed_type: 'INVENTORY',
      header_row: 0,
      mapping: {
        mpn: 'MPN',
        manufacturer: 'Make',
        description: 'Descrition',
        quantity: 'Qty',
        uom: 'UOM',
        internal_reference: 'Raw Part'
      },
      default_availability: 'NETWORK_AVAILABLE'
    },
    {
      feed_code: 'INDUS_CROSS_REFERENCE',
      supplier_code: 'INDUS',
      filename_pattern: /INDUS/i,
      sheet_name_pattern: /Sheet2/i,
      feed_type: 'CROSS_REFERENCE',
      header_row: 0,
      mapping: {
        mpn: 'Mfr. Part No.',
        manufacturer: 'Make',
        description: 'Item Description',
        internal_reference: 'Item Code-MPN'
      }
    }
  ]
};
