## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-desktopvirtualization-2019-12-10-preview
  - tag: schema-desktopvirtualization-2019-09-24-preview
  - tag: schema-desktopvirtualization-2019-01-23-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-desktopvirtualization-2019-12-10-preview and azureresourceschema

``` yaml $(tag) == 'schema-desktopvirtualization-2019-12-10-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DesktopVirtualization/preview/2019-12-10-preview/desktopvirtualization.json

```

### Tag: schema-desktopvirtualization-2019-09-24-preview and azureresourceschema

``` yaml $(tag) == 'schema-desktopvirtualization-2019-09-24-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DesktopVirtualization/preview/2019-09-24-preview/desktopvirtualization.json

```

### Tag: schema-desktopvirtualization-2019-01-23-preview and azureresourceschema

``` yaml $(tag) == 'schema-desktopvirtualization-2019-01-23-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DesktopVirtualization/preview/2019-01-23-preview/desktopvirtualization.json

```
