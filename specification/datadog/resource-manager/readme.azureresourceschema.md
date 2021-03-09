## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-datadog-2021-03-01
  - tag: schema-datadog-2020-02-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-datadog-2021-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-datadog-2021-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Datadog/stable/2021-03-01/datadog.json

```

### Tag: schema-datadog-2020-02-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-datadog-2020-02-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Datadog/preview/2020-02-01-preview/datadog.json

```
