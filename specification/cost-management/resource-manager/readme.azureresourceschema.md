## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-costmanagement-2020-06-01
  - tag: schema-costmanagement-2020-03-01-preview
  - tag: schema-costmanagement-2019-11-01
  - tag: schema-costmanagement-2019-10-01
  - tag: schema-costmanagement-2019-09-01
  - tag: schema-costmanagement-2019-04-01-preview
  - tag: schema-costmanagement-2019-03-01-preview
  - tag: schema-costmanagement-2019-01-01
  - tag: schema-costmanagement-2018-12-01-preview
  - tag: schema-costmanagement-2018-08-01-preview
  - tag: schema-costmanagement-2018-05-31

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-costmanagement-2020-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-costmanagement-2020-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.CostManagement/stable/2020-06-01/costmanagement.json

```

### Tag: schema-costmanagement-2020-03-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-costmanagement-2020-03-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.CostManagement/preview/2020-03-01-preview/costallocation.json

```

### Tag: schema-costmanagement-2019-11-01 and azureresourceschema

``` yaml $(tag) == 'schema-costmanagement-2019-11-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.CostManagement/stable/2019-11-01/costmanagement.json
  - Microsoft.CostManagement/stable/2019-11-01/costmanagement.exports.json

```

### Tag: schema-costmanagement-2019-10-01 and azureresourceschema

``` yaml $(tag) == 'schema-costmanagement-2019-10-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.CostManagement/stable/2019-10-01/costmanagement.json

```

### Tag: schema-costmanagement-2019-09-01 and azureresourceschema

``` yaml $(tag) == 'schema-costmanagement-2019-09-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.CostManagement/stable/2019-09-01/costmanagement.json

```

### Tag: schema-costmanagement-2019-04-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-costmanagement-2019-04-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.CostManagement/preview/2019-04-01-preview/costmanagement.json

```

### Tag: schema-costmanagement-2019-03-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-costmanagement-2019-03-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.CostManagement/preview/2019-03-01-preview/costmanagement.json

```

### Tag: schema-costmanagement-2019-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-costmanagement-2019-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.CostManagement/stable/2019-01-01/costmanagement.json

```

### Tag: schema-costmanagement-2018-12-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-costmanagement-2018-12-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.CostManagement/preview/2018-12-01-preview/costmanagement.json

```

### Tag: schema-costmanagement-2018-08-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-costmanagement-2018-08-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.CostManagement/preview/2018-08-01-preview/costmanagement.json

```

### Tag: schema-costmanagement-2018-05-31 and azureresourceschema

``` yaml $(tag) == 'schema-costmanagement-2018-05-31' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.CostManagement/stable/2018-05-31/costmanagement.json

```
