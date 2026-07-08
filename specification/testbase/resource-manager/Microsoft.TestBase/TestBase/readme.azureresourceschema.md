## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-testbase-2020-12-16-preview
  - tag: schema-testbase-2022-04-01-preview
  - tag: schema-testbase-2023-11-01-preview
```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-testbase-2020-12-16-preview and azureresourceschema

``` yaml $(tag) == 'schema-testbase-2020-12-16-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.TestBase/preview/2020-12-16-preview/testbase.json
```

### Tag: schema-testbase-2022-04-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-testbase-2022-04-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
# all the input files in this apiVersion
input-file:
  - Microsoft.TestBase/preview/2022-04-01-preview/testbase.json
```

### Tag: schema-testbase-2023-11-01-preview and azureresourceschema
``` yaml $(tag) == 'schema-testbase-2023-11-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
# all the input files in this apiVersion
input-file:
  - Microsoft.TestBase/preview/2023-11-01-preview/testbase.json
  - Microsoft.TestBase/preview/2023-11-01-preview/chat.json
  - Microsoft.TestBase/preview/2023-11-01-preview/draftpackage.json
  - Microsoft.TestBase/preview/2023-11-01-preview/actionrequest.json
  - Microsoft.TestBase/preview/2023-11-01-preview/customimage.json
  - Microsoft.TestBase/preview/2023-11-01-preview/credential.json
```