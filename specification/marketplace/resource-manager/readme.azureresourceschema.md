## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-marketplace-2020-01-01
  - tag: schema-marketplace-2019-12-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-marketplace-2020-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-marketplace-2020-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Marketplace/stable/2020-01-01/Marketplace.json

```

### Tag: schema-marketplace-2019-12-01 and azureresourceschema

``` yaml $(tag) == 'schema-marketplace-2019-12-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Marketplace/stable/2019-12-01/Marketplace.json

```
