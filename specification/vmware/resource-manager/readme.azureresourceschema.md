## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-avs-2020-03-20
  - tag: schema-avs-2019-08-09-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-avs-2020-03-20 and azureresourceschema

``` yaml $(tag) == 'schema-avs-2020-03-20' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AVS/stable/2020-03-20/vmware.json

```

### Tag: schema-avs-2019-08-09-preview and azureresourceschema

``` yaml $(tag) == 'schema-avs-2019-08-09-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AVS/preview/2019-08-09-preview/vmware.json

```
