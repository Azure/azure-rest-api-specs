## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

```yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: package-2020-11-01
```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: package-2020-11-01 and azureresourceschema

```yaml $(tag) == '2020-11-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```