These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
# add any configuration here for all CLI languages
# refer to the faq.md for more details

cli:
  cli-name: codesigning
  test-scenario:
    - name: Create Code Signing Account
    - name: Get Code Signing Account
    - name: List Code Signing Accounts by Resource Group
    - name: List Code Signing Accounts by Subscription
    - name: Update Code Signing Account
    - name: Create Certificate Profile
    - name: Get Certificate Profile   
    - name: List Certificate Profiles
    - name: Delete Certificate Profile
    - name: Delete Code Signing Account
    - name: List Code Signing Account operations
    - name: Revoke certificate
```