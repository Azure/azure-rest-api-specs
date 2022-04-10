## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-avs-2020-07-17-preview
  - tag: schema-avs-2020-03-20

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.
### Tag: schema-avs-2020-07-17-preview and azureresourceschema

``` yaml $(tag) == 'schema-avs-2020-07-17-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AVS/preview/2020-07-17-preview/vmware.json

```

### Tag: schema-avs-2020-03-20 and azureresourceschema

``` yaml $(tag) == 'schema-avs-2020-03-20' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AVS/stable/2020-03-20/vmware.json

```
