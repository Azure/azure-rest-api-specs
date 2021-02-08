## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-marketplaceordering-2021-01-01
  - tag: schema-marketplaceordering-2015-06-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-marketplaceordering-2021-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-marketplaceordering-2021-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.MarketplaceOrdering/stable/2021-01-01/Agreements.json

```

### Tag: schema-marketplaceordering-2015-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-marketplaceordering-2015-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.MarketplaceOrdering/stable/2015-06-01/Agreements.json

```
