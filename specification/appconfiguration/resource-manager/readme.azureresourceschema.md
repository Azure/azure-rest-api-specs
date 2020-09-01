## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-appconfiguration-2020-06-01
  - tag: schema-appconfiguration-2019-11-01-preview
  - tag: schema-appconfiguration-2019-10-01
  - tag: schema-appconfiguration-2019-02-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-appconfiguration-2020-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-appconfiguration-2020-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AppConfiguration/stable/2020-06-01/appconfiguration.json

```

### Tag: schema-appconfiguration-2019-11-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-appconfiguration-2019-11-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AppConfiguration/preview/2019-11-01-preview/appconfiguration.json

```

### Tag: schema-appconfiguration-2019-10-01 and azureresourceschema

``` yaml $(tag) == 'schema-appconfiguration-2019-10-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AppConfiguration/stable/2019-10-01/appconfiguration.json

```

### Tag: schema-appconfiguration-2019-02-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-appconfiguration-2019-02-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AppConfiguration/preview/2019-02-01-preview/appconfiguration.json

```
