## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-datalakeanalytics-2016-11-01
  - tag: schema-datalakeanalytics-2015-10-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-datalakeanalytics-2016-11-01 and azureresourceschema

``` yaml $(tag) == 'schema-datalakeanalytics-2016-11-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DataLakeAnalytics/stable/2016-11-01/account.json

```

### Tag: schema-datalakeanalytics-2015-10-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-datalakeanalytics-2015-10-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DataLakeAnalytics/preview/2015-10-01-preview/account.json

```
