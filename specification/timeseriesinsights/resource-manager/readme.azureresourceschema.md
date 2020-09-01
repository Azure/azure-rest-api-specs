## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.TimeSeriesInsights/stable/2020-05-15/timeseriesinsights.json
  - Microsoft.TimeSeriesInsights/preview/2018-08-15-preview/timeseriesinsights.json
  - Microsoft.TimeSeriesInsights/stable/2017-11-15/timeseriesinsights.json
  - Microsoft.TimeSeriesInsights/preview/2017-02-28-preview/timeseriesinsights.json

```