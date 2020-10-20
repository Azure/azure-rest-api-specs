<!-- region Generated -->
# Az.Billing
This directory contains the Cli common model for the Billing service.

> Metadata
``` yaml
# Migrated from Powershell's readme

extension-mode: stable

directive:
  - where:
      group: billing invoice-section
    set:
      group: billing invoice section

cli:
    cli-directive:
      # rename --billing-profile-name to --profile-name
      - where:
          param: billingProfileName
        name: profile_name

 # -------- BillingAccounts --------
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
      - where:
          operationGroup: billingAccounts
        set:
          groupExtensionMode: preview
      - where:
          operationGroup: BillingAccounts
        name: account
      # Shouldn't appear in accounts command group, the responses is not related to BollingAccount
      - where:
          group: BillingAccounts
          op: ListInvoiceSectionsByCreateSubscriptionPermission
        hidden: true

# -------- BillingProfile --------
      - where:
          operationGroup: BillingProfiles
        set:
          groupExtensionMode: preview
      - where:
          operationGroup: BillingProfiles
        name: profile
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

# -------- Balance --------
      - where:
            group: 'availableBalances'
        set:
            name: 'balance'
      - where:
          group: availableBalances
        set:
          groupExtensionMode: preview

# -------- Customer --------
      - where:
          group: Customers
        set:
          groupExtensionMode: preview

# -------- Invoice --------
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

# -------- InvoiceSection --------
      - where:
          group: InvoiceSections
        set:
          groupExtensionMode: preview # bug, won't take effect

# -------- Policy -------
      - where:
          group: Policies
        set:
          groupExtensionMode: preview
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

# ------ Product ------
      - where:
          group: Products
        set:
          groupExtensionMode: preview

# ------ Subscription ------
      - where:
          group: BillingSubscriptions
        set:
          name: subscription
          groupExtensionMode: preview

# ------ Property ------
      - where:
          group: BillingProperty
        set:
          name: property
          groupExtensionMode: preview
      - select: 'property'
        where:
            objectSchema: 'BillingProfileProperties'
            property: 'poNumber'
        set:
            name: 'purchase_order_number'

# ------ Transaction ------
      - where:
          group: Transactions
        set:
          groupExtensionMode: preview


      - select: 'operationGroup'
        where:
          operationGroup: BillingPeriods|EnrollmentAccounts|Agreements|BillingPermissions|BillingRoleAssignments|BillingRoleDefinitions|Instructions|Address.*$
        hidden: true
```
