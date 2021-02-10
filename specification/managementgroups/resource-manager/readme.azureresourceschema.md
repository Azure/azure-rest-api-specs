## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-management-2020-05-01
  - tag: schema-management-2020-02-01
  - tag: schema-management-2019-11-01
  - tag: schema-management-2018-03-01-preview
  - tag: schema-management-2018-01-01-preview
  - tag: schema-management-2017-11-01-preview
  - tag: schema-management-2017-08-31-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-management-2020-05-01 and azureresourceschema

``` yaml $(tag) == 'schema-management-2020-05-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Management/stable/2020-05-01/management.json

```

### Tag: schema-management-2020-02-01 and azureresourceschema

``` yaml $(tag) == 'schema-management-2020-02-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Management/stable/2020-02-01/management.json

```

### Tag: schema-management-2019-11-01 and azureresourceschema

``` yaml $(tag) == 'schema-management-2019-11-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Management/stable/2019-11-01/management.json

```

### Tag: schema-management-2018-03-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-management-2018-03-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Management/preview/2018-03-01-preview/management.json

```

### Tag: schema-management-2018-01-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-management-2018-01-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Management/preview/2018-01-01-preview/management.json

```

### Tag: schema-management-2017-11-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-management-2017-11-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Management/preview/2017-11-01-preview/management.json

```

### Tag: schema-management-2017-08-31-preview and azureresourceschema

``` yaml $(tag) == 'schema-management-2017-08-31-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Management/preview/2017-08-31-preview/management.json

```
