<!-- region Generated -->
# Az.Billing
This directory contains the Cli common model for the Billing service.

> Metadata
``` yaml
# Migrated from Powershell's readme

extension-mode: preview

directive:
  - where:
      group: billing invoice-section
    set:
      group: billing invoice section

cli:
    cli-directive:
      # rename --billing-account-name to --account-name globally
      - where:
          param: billingAccountName
        name: account_name
      # shortnen the name in billing account command group
      - where:
          group: billingAccounts
          param: billingAccountName
        alias:
          - name
          - n
      # rename --billing-profile-name to --profile-name
      - where:
          param: billingProfileName
        name: profile_name
      - where:
          group: billingProfiles
          param: billingProfileName
        alias:
          - name
          - n
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
            name: 'balance'
      - where:
          operationGroup: BillingAccounts
        name: account
      # Shouldn't appear in accounts command group, the responses is not related to BollingAccount
      - where:
          group: BillingAccounts
          op: ListInvoiceSectionsByCreateSubscriptionPermission
        hidden: true
      - where:
          operationGroup: BillingProfiles
        name: profile
      - where:
          operationGroup: BillingSubscriptions
        name: subscription
      - where:
          operationGroup: BillingProperty
        name: property
      - select: 'property'
        where:
            objectSchema: 'BillingProfileProperties'
            property: 'poNumber'
        set:
            name: 'purchase_order_number'
      - select: 'operationGroup'
        where:
          operationGroup: BillingPeriods|EnrollmentAccounts|Agreements|BillingPermissions|BillingRoleAssignments|BillingRoleDefinitions|Instructions|Invoices|Address.*$
        hidden: true
      # customize for download command by manual for ungraceful implmentation by default
      - where:
          group: Invoices
          op: DownloadInvoice
        hidden: true
      - where:
          group: Invoices
          op: DownloadMultipleBillingProfileInvoices
        hidden: true
      - where:
          group: Invoices
          op: DownloadBillingSubscriptionInvoice
        hidden: true
      - where:
          group: Invoices
          op: DownloadMultipleBillingSubscriptionInvoices
        hidden: true
      # customize for series of get commands by manual for ungraceful implmentation by default
      - where:
          group: Invoices
          op: GetById
        hidden: true
      - where:
          group: Invoices
          op: GetBySubscriptionAndInvoiceId
        hidden: true
      # GetByBillingProfile and GetByCustomer will be implemented in manually customized show command
      - where:
          group: Policies
          op: GetByBillingProfile
        hidden: true
      - where:
          group: Policies
          op: GetByCustomer
        name: show
      - where:
          group: Policies
          op: UpdateCustomer
        hidden: true
      - where:
          operationGroup: Invoices
        set:
          groupExtensionMode: stable
          # extension-mode: stable
```
