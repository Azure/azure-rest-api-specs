## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-marketplacenotifications-2021-03-03

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-marketplacenotifications-2021-03-03 and azureresourceschema

``` yaml $(tag) == 'schema-marketplacenotifications-2021-03-03' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.MarketplaceNotifications/stable/2021-03-03/MarketplaceNotifications.json

```
