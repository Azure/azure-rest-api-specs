## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-kusto-2020-06-14
  - tag: schema-kusto-2020-02-15
  - tag: schema-kusto-2019-11-09
  - tag: schema-kusto-2019-09-07
  - tag: schema-kusto-2019-05-15
  - tag: schema-kusto-2019-01-21
  - tag: schema-kusto-2018-09-07-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-kusto-2020-06-14 and azureresourceschema

``` yaml $(tag) == 'schema-kusto-2020-06-14' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Kusto/stable/2020-06-14/kusto.json

```

### Tag: schema-kusto-2020-02-15 and azureresourceschema

``` yaml $(tag) == 'schema-kusto-2020-02-15' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Kusto/stable/2020-02-15/kusto.json

```

### Tag: schema-kusto-2019-11-09 and azureresourceschema

``` yaml $(tag) == 'schema-kusto-2019-11-09' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Kusto/stable/2019-11-09/kusto.json

```

### Tag: schema-kusto-2019-09-07 and azureresourceschema

``` yaml $(tag) == 'schema-kusto-2019-09-07' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Kusto/stable/2019-09-07/kusto.json

```

### Tag: schema-kusto-2019-05-15 and azureresourceschema

``` yaml $(tag) == 'schema-kusto-2019-05-15' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Kusto/stable/2019-05-15/kusto.json

```

### Tag: schema-kusto-2019-01-21 and azureresourceschema

``` yaml $(tag) == 'schema-kusto-2019-01-21' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Kusto/stable/2019-01-21/kusto.json

```

### Tag: schema-kusto-2018-09-07-preview and azureresourceschema

``` yaml $(tag) == 'schema-kusto-2018-09-07-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Kusto/preview/2018-09-07-preview/kusto.json

```
