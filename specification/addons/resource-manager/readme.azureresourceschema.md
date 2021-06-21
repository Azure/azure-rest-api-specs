## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-addons-2018-03-01
  - tag: schema-addons-2017-05-15

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-addons-2018-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-addons-2018-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Addons/preview/2018-03-01/addons-swagger.json

```

### Tag: schema-addons-2017-05-15 and azureresourceschema

``` yaml $(tag) == 'schema-addons-2017-05-15' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Addons/preview/2017-05-15/Addons.json

```
