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
            objectSchema: 'billingProfileCreationRequest'
            property: 'poNumber'
        set:
            name: 'purchase_order_number'
      - select: 'operationGroup'
        where: 
            operationGroup: 'availableBalances'
        set:
            name: 'available_credit_balance'
      - select: 'property'
        where:
            objectSchema: 'BillingProfileProperties'
            property: 'poNumber'
        set:
            name: 'purchase_order_number'
      - select: 'operationGroup'
        where:
          operationGroup: ^(?!^billingPeriod$)(?!^budget$)(?!^enrollmentAccounts$)(?!^invoices$)(?!^marketplace$)(?!^priceSheet$)(?!^reservationDetail$)(?!^reservationSummary$)(?!^usageAggregate$)(?!^usageDetail$).*$
        hidden: true
```
