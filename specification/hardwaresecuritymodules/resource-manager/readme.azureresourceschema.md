## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-hardwaresecuritymodules-2018-10-31-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-hardwaresecuritymodules-2018-10-31-preview and azureresourceschema

``` yaml $(tag) == 'schema-hardwaresecuritymodules-2018-10-31-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.HardwareSecurityModules/preview/2018-10-31-preview/dedicatedhsm.json

```
