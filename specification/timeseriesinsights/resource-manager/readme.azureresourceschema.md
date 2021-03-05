## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-timeseriesinsights-2020-05-15
  - tag: schema-timeseriesinsights-2018-08-15-preview
  - tag: schema-timeseriesinsights-2017-11-15
  - tag: schema-timeseriesinsights-2017-02-28-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-timeseriesinsights-2020-05-15 and azureresourceschema

``` yaml $(tag) == 'schema-timeseriesinsights-2020-05-15' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.TimeSeriesInsights/stable/2020-05-15/timeseriesinsights.json

```

### Tag: schema-timeseriesinsights-2018-08-15-preview and azureresourceschema

``` yaml $(tag) == 'schema-timeseriesinsights-2018-08-15-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.TimeSeriesInsights/preview/2018-08-15-preview/timeseriesinsights.json

```

### Tag: schema-timeseriesinsights-2017-11-15 and azureresourceschema

``` yaml $(tag) == 'schema-timeseriesinsights-2017-11-15' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.TimeSeriesInsights/stable/2017-11-15/timeseriesinsights.json

```

### Tag: schema-timeseriesinsights-2017-02-28-preview and azureresourceschema

``` yaml $(tag) == 'schema-timeseriesinsights-2017-02-28-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.TimeSeriesInsights/preview/2017-02-28-preview/timeseriesinsights.json

```
