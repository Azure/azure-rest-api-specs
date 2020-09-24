## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

```yaml
batch:
  - tag: schema-[[ServiceName]]-[[Version]]
```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-[[ServiceName]]-[[Version]] and azureresourceschema

```yaml
  output-folder: $(azureresourceschema-folder)/schemas

  # all the input files in this apiVersion
  input-file: 
    - [[ResourceProviderName]]/[[ReleaseState]]/[[Version]]/[[ServiceName]].json
```
