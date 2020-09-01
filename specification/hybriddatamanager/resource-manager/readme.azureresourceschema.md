## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-hybriddata-2019-06-01
  - tag: schema-hybriddata-2016-06-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-hybriddata-2019-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-hybriddata-2019-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.HybridData/stable/2019-06-01/hybriddata.json

```

### Tag: schema-hybriddata-2016-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-hybriddata-2016-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.HybridData/stable/2016-06-01/hybriddata.json

```
