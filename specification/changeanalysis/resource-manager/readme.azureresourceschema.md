## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-changeanalysis-2021-04-01
  - tag: schema-changeanalysis-2020-04-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-changeanalysis-2021-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-changeanalysis-2021-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ChangeAnalysis/stable/2021-04-01/changeanalysis.json

```

### Tag: schema-changeanalysis-2020-04-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-changeanalysis-2020-04-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ChangeAnalysis/preview/2020-04-01-preview/changeanalysis.json

```
