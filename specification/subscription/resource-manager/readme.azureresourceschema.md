## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.Subscription/stable/2016-06-01/subscriptions.json
  - Microsoft.Subscription/stable/2020-09-01/subscriptions.json
  - Microsoft.Subscription/stable/2020-01-01/subscriptions.json
  - Microsoft.Subscription/preview/2019-10-01-preview/subscriptions.json
  - Microsoft.Subscription/preview/2019-03-01-preview/subscriptions.json
  - Microsoft.Subscription/preview/2018-11-01-preview/subscriptions.json
  - Microsoft.Subscription/preview/2018-03-01-preview/subscriptions.json
  - Microsoft.Subscription/preview/2018-03-01-preview/operations.json
  - Microsoft.Subscription/preview/2017-11-01-preview/subscriptionDefinitions.json

```