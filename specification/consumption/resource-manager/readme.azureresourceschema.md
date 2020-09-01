## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-consumption-2019-10-01
  - tag: schema-consumption-2019-06-01
  - tag: schema-consumption-2019-05-01-preview
  - tag: schema-consumption-2019-05-01
  - tag: schema-consumption-2019-04-01-preview
  - tag: schema-consumption-2019-01-01
  - tag: schema-consumption-2018-11-01-preview
  - tag: schema-consumption-2018-10-01
  - tag: schema-consumption-2018-08-31
  - tag: schema-consumption-2018-06-30
  - tag: schema-consumption-2018-05-31
  - tag: schema-consumption-2018-03-31
  - tag: schema-consumption-2018-01-31
  - tag: schema-consumption-2017-12-30-preview
  - tag: schema-consumption-2017-11-30
  - tag: schema-consumption-2017-04-24-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-consumption-2019-10-01 and azureresourceschema

``` yaml $(tag) == 'schema-consumption-2019-10-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Consumption/stable/2019-10-01/consumption.json

```

### Tag: schema-consumption-2019-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-consumption-2019-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Consumption/stable/2019-06-01/consumption.json

```

### Tag: schema-consumption-2019-05-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-consumption-2019-05-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Consumption/preview/2019-05-01-preview/consumption.json

```

### Tag: schema-consumption-2019-05-01 and azureresourceschema

``` yaml $(tag) == 'schema-consumption-2019-05-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Consumption/stable/2019-05-01/consumption.json

```

### Tag: schema-consumption-2019-04-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-consumption-2019-04-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Consumption/preview/2019-04-01-preview/consumption.json

```

### Tag: schema-consumption-2019-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-consumption-2019-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Consumption/stable/2019-01-01/consumption.json

```

### Tag: schema-consumption-2018-11-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-consumption-2018-11-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Consumption/preview/2018-11-01-preview/consumption.json

```

### Tag: schema-consumption-2018-10-01 and azureresourceschema

``` yaml $(tag) == 'schema-consumption-2018-10-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Consumption/stable/2018-10-01/consumption.json

```

### Tag: schema-consumption-2018-08-31 and azureresourceschema

``` yaml $(tag) == 'schema-consumption-2018-08-31' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Consumption/stable/2018-08-31/consumption.json

```

### Tag: schema-consumption-2018-06-30 and azureresourceschema

``` yaml $(tag) == 'schema-consumption-2018-06-30' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Consumption/stable/2018-06-30/consumption.json

```

### Tag: schema-consumption-2018-05-31 and azureresourceschema

``` yaml $(tag) == 'schema-consumption-2018-05-31' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Consumption/stable/2018-05-31/consumption.json

```

### Tag: schema-consumption-2018-03-31 and azureresourceschema

``` yaml $(tag) == 'schema-consumption-2018-03-31' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Consumption/stable/2018-03-31/consumption.json

```

### Tag: schema-consumption-2018-01-31 and azureresourceschema

``` yaml $(tag) == 'schema-consumption-2018-01-31' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Consumption/stable/2018-01-31/consumption.json

```

### Tag: schema-consumption-2017-12-30-preview and azureresourceschema

``` yaml $(tag) == 'schema-consumption-2017-12-30-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Consumption/preview/2017-12-30-preview/consumption.json

```

### Tag: schema-consumption-2017-11-30 and azureresourceschema

``` yaml $(tag) == 'schema-consumption-2017-11-30' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Consumption/stable/2017-11-30/consumption.json

```

### Tag: schema-consumption-2017-04-24-preview and azureresourceschema

``` yaml $(tag) == 'schema-consumption-2017-04-24-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Consumption/preview/2017-04-24-preview/consumption.json

```
