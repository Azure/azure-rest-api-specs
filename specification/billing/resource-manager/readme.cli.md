<!-- region Generated -->
# Az.Aks
This directory contains the Cli common model for the Aks service.

> Metadata
``` yaml
# Migrated from Powershell's readme
title: Billing

cli:
    cli-directive:
      - select: 'property'
        where:
            objectSchema: 'billing_profile_creation_request'
            property: 'po_number'
        set:
            name: 'purchase_order_number'
      - select: 'operationGroup'
        where: 
            operationGroup: 'available_balances'
        set:
            name: 'available_credit_balance'
      - select: 'property'
        where:
            objectSchema: 'billing_profile'
            property: 'po_number'
        set:
            name: 'purchase_order_number'
      - select: 'operationGroup'
        where:
          operationGroup: ^(?!^billing_period$)(?!^budget$)(?!^enrollment_accounts$)(?!^invoices$)(?!^marketplace$)(?!^price_sheet$)(?!^reservation_detail$)(?!^reservation_summary$)(?!^usage_aggregate$)(?!^usage_detail$).*$
        hidden: true
```
