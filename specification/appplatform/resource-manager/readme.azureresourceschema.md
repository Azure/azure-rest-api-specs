## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-appplatform-2021-03-03-preview
  - tag: schema-appplatform-2020-11-01-preview
  - tag: schema-appplatform-2020-07-01
  - tag: schema-appplatform-2019-05-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-appplatform-2021-03-03-preview and azureresourceschema

``` yaml $(tag) == 'schema-appplatform-2021-03-03-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AppPlatform/preview/2021-03-03-preview/appplatform.json

```

### Tag: schema-appplatform-2020-11-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-appplatform-2020-11-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AppPlatform/preview/2020-11-01-preview/appplatform.json

```

### Tag: schema-appplatform-2020-07-01 and azureresourceschema

``` yaml $(tag) == 'schema-appplatform-2020-07-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AppPlatform/stable/2020-07-01/appplatform.json

```

### Tag: schema-appplatform-2019-05-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-appplatform-2019-05-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AppPlatform/preview/2019-05-01-preview/appplatform.json

```
