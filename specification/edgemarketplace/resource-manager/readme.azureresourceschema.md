## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: package-2023-04-01-preview
  - tag: package-2023-08-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: package-2023-04-01-preview and azureresourceschema

``` yaml $(tag) == '2023-04-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas```

### Tag: package-2023-08-01 and azureresourceschema

``` yaml $(tag) == '2023-08-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas