## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-testbase-2020-12-16-preview
  - tag: schema-testbase-2021-09-01-preview
  - tag: schema-testbase-2021-09-01
  - tag: schema-testbase-2021-12-01
  - tag: schema-testbase-2022-03-01-preview
  - tag: schema-testbase-2022-04-01-preview
  - tag: schema-testbase-2022-05-01-preview
  - tag: schema-testbase-2022-08-01-preview
  - tag: schema-testbase-2022-08-15-preview
  - tag: schema-testbase-2022-09-15-preview
  - tag: schema-testbase-2022-10-15-preview
  - tag: schema-testbase-2022-11-01-preview
  - tag: schema-testbase-2022-11-15-preview
  - tag: schema-testbase-2022-12-01-preview
  - tag: schema-testbase-2023-01-01-preview
  - tag: schema-testbase-2023-01-15-preview
  - tag: schema-testbase-2023-01-16-preview
  - tag: schema-testbase-2023-05-15-preview
  - tag: schema-testbase-2023-06-01-preview
  - tag: schema-testbase-2023-06-15-preview
  - tag: schema-testbase-2023-08-01-preview
  - tag: schema-testbase-2023-08-15-preview
  - tag: schema-testbase-2023-09-01-preview
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

### Tag: schema-testbase-2021-09-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-testbase-2021-09-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.TestBase/preview/2021-09-01-preview/testbase.json
```

### Tag: schema-testbase-2021-09-01 and azureresourceschema

``` yaml $(tag) == 'schema-testbase-2021-09-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
# all the input files in this apiVersion
input-file:
  - Microsoft.TestBase/stable/2021-09-01/testbase.json
```

### Tag: schema-testbase-2021-12-01 and azureresourceschema

``` yaml $(tag) == 'schema-testbase-2021-12-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
# all the input files in this apiVersion
input-file:
  - Microsoft.TestBase/stable/2021-12-01/testbase.json
```

### Tag: schema-testbase-2022-03-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-testbase-2022-03-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
# all the input files in this apiVersion
input-file:
  - Microsoft.TestBase/preview/2022-03-01-preview/testbase.json
```

### Tag: schema-testbase-2022-04-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-testbase-2022-04-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
# all the input files in this apiVersion
input-file:
  - Microsoft.TestBase/preview/2022-04-01-preview/testbase.json
```

### Tag: schema-testbase-2022-05-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-testbase-2022-05-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
# all the input files in this apiVersion
input-file:
  - Microsoft.TestBase/preview/2022-05-01-preview/testbase.json
```

### Tag: schema-testbase-2022-08-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-testbase-2022-08-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
# all the input files in this apiVersion
input-file:
  - Microsoft.TestBase/preview/2022-08-01-preview/testbase.json
```

### Tag: schema-testbase-2022-08-15-preview and azureresourceschema

``` yaml $(tag) == 'schema-testbase-2022-08-15-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
# all the input files in this apiVersion
input-file:
  - Microsoft.TestBase/preview/2022-08-15-preview/testbase.json
```

### Tag: schema-testbase-2022-09-15-preview and azureresourceschema

``` yaml $(tag) == 'schema-testbase-2022-09-15-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
# all the input files in this apiVersion
input-file:
  - Microsoft.TestBase/preview/2022-09-15-preview/testbase.json
```

### Tag: schema-testbase-2022-10-15-preview and azureresourceschema

``` yaml $(tag) == 'schema-testbase-2022-10-15-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
# all the input files in this apiVersion
input-file:
  - Microsoft.TestBase/preview/2022-10-15-preview/testbase.json
  - Microsoft.TestBase/preview/2022-10-15-preview/draftpackage.json
```

### Tag: schema-testbase-2022-11-01-preview and azureresourceschema
``` yaml $(tag) == 'schema-testbase-2022-11-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
# all the input files in this apiVersion
input-file:
  - Microsoft.TestBase/preview/2022-11-01-preview/testbase.json
```

### Tag: schema-testbase-2022-11-15-preview and azureresourceschema

``` yaml $(tag) == 'schema-testbase-2022-11-15-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
# all the input files in this apiVersion
input-file:
  - Microsoft.TestBase/preview/2022-11-15-preview/testbase.json
  - Microsoft.TestBase/preview/2022-11-15-preview/draftpackage.json
```

### Tag: schema-testbase-2022-12-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-testbase-2022-12-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
# all the input files in this apiVersion
input-file:
  - Microsoft.TestBase/preview/2022-12-01-preview/testbase.json
  - Microsoft.TestBase/preview/2022-12-01-preview/draftpackage.json
```

### Tag: schema-testbase-2023-01-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-testbase-2023-01-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
# all the input files in this apiVersion
input-file:
  - Microsoft.TestBase/preview/2023-01-01-preview/testbase.json
  - Microsoft.TestBase/preview/2023-01-01-preview/draftpackage.json
  - Microsoft.TestBase/preview/2023-01-01-preview/actionrequest.json
```

### Tag: schema-testbase-2023-01-15-preview and azureresourceschema

``` yaml $(tag) == 'schema-testbase-2023-01-15-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
# all the input files in this apiVersion
input-file:
  - Microsoft.TestBase/preview/2023-01-15-preview/testbase.json
  - Microsoft.TestBase/preview/2023-01-15-preview/draftpackage.json
  - Microsoft.TestBase/preview/2023-01-15-preview/testconfiguration.json
  - Microsoft.TestBase/preview/2023-01-15-preview/actionrequest.json
```

### Tag: schema-testbase-2023-01-16-preview and azureresourceschema

``` yaml $(tag) == 'schema-testbase-2023-01-16-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
# all the input files in this apiVersion
input-file:
  - Microsoft.TestBase/preview/2023-01-16-preview/testbase.json
  - Microsoft.TestBase/preview/2023-01-16-preview/draftpackage.json
  - Microsoft.TestBase/preview/2023-01-16-preview/actionrequest.json
```

### Tag: schema-testbase-2023-05-15-preview and azureresourceschema

``` yaml $(tag) == 'schema-testbase-2023-05-15-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
# all the input files in this apiVersion
input-file:
  - Microsoft.TestBase/preview/2023-05-15-preview/testbase.json
  - Microsoft.TestBase/preview/2023-05-15-preview/draftpackage.json
  - Microsoft.TestBase/preview/2023-05-15-preview/testconfiguration.json
  - Microsoft.TestBase/preview/2023-05-15-preview/actionrequest.json
  - Microsoft.TestBase/preview/2023-05-15-preview/customimage.json
```

### Tag: schema-testbase-2023-06-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-testbase-2023-06-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
# all the input files in this apiVersion
input-file:
  - Microsoft.TestBase/preview/2023-06-01-preview/testbase.json
  - Microsoft.TestBase/preview/2023-06-01-preview/draftpackage.json
  - Microsoft.TestBase/preview/2023-06-01-preview/actionrequest.json
```

### Tag: schema-testbase-2023-06-15-preview and azureresourceschema

``` yaml $(tag) == 'schema-testbase-2023-06-15-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
# all the input files in this apiVersion
input-file:
  - Microsoft.TestBase/preview/2023-06-15-preview/testbase.json
  - Microsoft.TestBase/preview/2023-06-15-preview/draftpackage.json
  - Microsoft.TestBase/preview/2023-06-15-preview/testconfiguration.json
  - Microsoft.TestBase/preview/2023-06-15-preview/actionrequest.json
  - Microsoft.TestBase/preview/2023-06-15-preview/customimage.json
```

### Tag: schema-testbase-2023-08-01-preview and azureresourceschema
``` yaml $(tag) == 'schema-testbase-2023-08-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
# all the input files in this apiVersion
input-file:
  - Microsoft.TestBase/preview/2023-08-01-preview/testbase.json
  - Microsoft.TestBase/preview/2023-08-01-preview/draftpackage.json
  - Microsoft.TestBase/preview/2023-08-01-preview/actionrequest.json
  - Microsoft.TestBase/preview/2023-08-01-preview/customimage.json
```

### Tag: schema-testbase-2023-08-15-preview and azureresourceschema

``` yaml $(tag) == 'schema-testbase-2023-08-15-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
# all the input files in this apiVersion
input-file:
  - Microsoft.TestBase/preview/2023-08-15-preview/testbase.json
  - Microsoft.TestBase/preview/2023-08-15-preview/chat.json
  - Microsoft.TestBase/preview/2023-08-15-preview/customimage.json
  - Microsoft.TestBase/preview/2023-08-15-preview/draftpackage.json
  - Microsoft.TestBase/preview/2023-08-15-preview/testconfiguration.json
  - Microsoft.TestBase/preview/2023-08-15-preview/actionrequest.json
  - Microsoft.TestBase/preview/2023-08-15-preview/credential.json
```

### Tag: schema-testbase-2023-09-01-preview and azureresourceschema
``` yaml $(tag) == 'schema-testbase-2023-09-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
# all the input files in this apiVersion
input-file:
  - Microsoft.TestBase/preview/2023-09-01-preview/testbase.json
  - Microsoft.TestBase/preview/2023-09-01-preview/draftpackage.json
  - Microsoft.TestBase/preview/2023-09-01-preview/actionrequest.json
  - Microsoft.TestBase/preview/2023-09-01-preview/customimage.json
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