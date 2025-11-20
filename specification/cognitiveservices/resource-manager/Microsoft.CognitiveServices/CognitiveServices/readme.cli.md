## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  test-scenario:
    - name: /Accounts/put/Create Account Min
    - name: /Accounts/put/Create Account
      disabled: true
    - name: /Accounts/get/Get Usages
    - name: /Accounts/get/List SKUs
    - name: /Accounts/get/Get Account
    - name: /Accounts/get/List Accounts by Resource Group
    - name: /Accounts/get/List Accounts by Subscription
    - name: /ResourceSkus/get/Regenerate Keys
    - name: /Operations/get/Get Operations
    - name: /Accounts/post/Regenerate Keys
    - name: /Accounts/post/List Keys
    - name: /Accounts/patch/Update Account
      disabled: true
    - name: //post/Check SKU Availability
    - name: //post/Check SKU Availability
    - name: /Accounts/delete/Delete Account