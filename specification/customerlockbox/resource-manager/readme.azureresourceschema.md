## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-customerlockbox-2018-02-28-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-customerlockbox-2018-02-28-preview and azureresourceschema

``` yaml $(tag) == 'schema-customerlockbox-2018-02-28-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.CustomerLockbox/preview/2018-02-28-preview/customerlockbox.json

```
