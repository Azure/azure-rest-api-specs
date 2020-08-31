## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.Billing/stable/2020-05-01/billing.json
  - Microsoft.Billing/preview/2018-03-01-preview/billingV2.json
  - Microsoft.Billing/preview/2019-10-01-preview/billing.json
  - Microsoft.Billing/preview/2018-11-01-preview/billing.json
  - Microsoft.Billing/preview/2018-03-01-preview/billing.json
  - Microsoft.Billing/preview/2017-04-24-preview/billing.json
  - Microsoft.Billing/preview/2017-02-27-preview/billing.json

```