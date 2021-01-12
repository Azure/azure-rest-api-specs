## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-managedidentity-2018-11-30
  - tag: schema-managedidentity-2015-08-31-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-managedidentity-2018-11-30 and azureresourceschema

``` yaml $(tag) == 'schema-managedidentity-2018-11-30' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ManagedIdentity/stable/2018-11-30/ManagedIdentity.json

```

### Tag: schema-managedidentity-2015-08-31-preview and azureresourceschema

``` yaml $(tag) == 'schema-managedidentity-2015-08-31-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ManagedIdentity/preview/2015-08-31-preview/ManagedIdentity.json

```
