## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-windowsesu-2019-09-16-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-windowsesu-2019-09-16-preview and azureresourceschema

``` yaml $(tag) == 'schema-windowsesu-2019-09-16-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.WindowsESU/preview/2019-09-16-preview/windowsesu.json

```
