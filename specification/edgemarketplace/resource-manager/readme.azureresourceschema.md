## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: package-2023-04-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: package-2023-04-01-preview and azureresourceschema

``` yaml $(tag) == '2023-04-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
