## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-datashare-2019-11-01
  - tag: schema-datashare-2018-11-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-datashare-2019-11-01 and azureresourceschema

``` yaml $(tag) == 'schema-datashare-2019-11-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DataShare/stable/2019-11-01/DataShare.json

```

### Tag: schema-datashare-2018-11-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-datashare-2018-11-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DataShare/preview/2018-11-01-preview/DataShare.json

```
