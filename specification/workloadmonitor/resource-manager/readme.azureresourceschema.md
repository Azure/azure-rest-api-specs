## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-workloadmonitor-2018-08-31-preview
  - tag: schema-workloadmonitor-2020-01-13-preview
```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-workloadmonitor-2018-08-31-preview and azureresourceschema

``` yaml $(tag) == 'schema-workloadmonitor-2018-08-31-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.WorkloadMonitor/preview/2018-08-31-preview/Microsoft.WorkloadMonitor.json

```

### Tag: schema-workloadmonitor-2020-01-13-preview and azureresourceschema

``` yaml $(tag) == 'schema-workloadmonitor-2020-01-13-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.WorkloadMonitor/preview/2020-01-13-preview/Microsoft.WorkloadMonitor.json

```
