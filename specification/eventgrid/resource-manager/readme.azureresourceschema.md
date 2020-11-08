## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-eventgrid-2020-06-01
  - tag: schema-eventgrid-2020-04-01-preview
  - tag: schema-eventgrid-2020-01-01-preview
  - tag: schema-eventgrid-2019-06-01
  - tag: schema-eventgrid-2019-02-01-preview
  - tag: schema-eventgrid-2019-01-01
  - tag: schema-eventgrid-2018-09-15-preview
  - tag: schema-eventgrid-2018-05-01-preview
  - tag: schema-eventgrid-2018-01-01
  - tag: schema-eventgrid-2017-09-15-preview
  - tag: schema-eventgrid-2017-06-15-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-eventgrid-2020-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-eventgrid-2020-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.EventGrid/stable/2020-06-01/EventGrid.json

```

### Tag: schema-eventgrid-2020-04-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-eventgrid-2020-04-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.EventGrid/preview/2020-04-01-preview/EventGrid.json

```

### Tag: schema-eventgrid-2020-01-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-eventgrid-2020-01-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.EventGrid/preview/2020-01-01-preview/EventGrid.json

```

### Tag: schema-eventgrid-2019-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-eventgrid-2019-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.EventGrid/stable/2019-06-01/EventGrid.json

```

### Tag: schema-eventgrid-2019-02-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-eventgrid-2019-02-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.EventGrid/preview/2019-02-01-preview/EventGrid.json

```

### Tag: schema-eventgrid-2019-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-eventgrid-2019-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.EventGrid/stable/2019-01-01/EventGrid.json

```

### Tag: schema-eventgrid-2018-09-15-preview and azureresourceschema

``` yaml $(tag) == 'schema-eventgrid-2018-09-15-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.EventGrid/preview/2018-09-15-preview/EventGrid.json

```

### Tag: schema-eventgrid-2018-05-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-eventgrid-2018-05-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.EventGrid/preview/2018-05-01-preview/EventGrid.json

```

### Tag: schema-eventgrid-2018-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-eventgrid-2018-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.EventGrid/stable/2018-01-01/EventGrid.json

```

### Tag: schema-eventgrid-2017-09-15-preview and azureresourceschema

``` yaml $(tag) == 'schema-eventgrid-2017-09-15-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.EventGrid/preview/2017-09-15-preview/EventGrid.json

```

### Tag: schema-eventgrid-2017-06-15-preview and azureresourceschema

``` yaml $(tag) == 'schema-eventgrid-2017-06-15-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.EventGrid/preview/2017-06-15-preview/EventGrid.json

```
