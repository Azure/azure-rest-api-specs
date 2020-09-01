## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.EventGrid/stable/2020-06-01/EventGrid.json
  - Microsoft.EventGrid/preview/2020-04-01-preview/EventGrid.json
  - Microsoft.EventGrid/preview/2020-01-01-preview/EventGrid.json
  - Microsoft.EventGrid/stable/2019-06-01/EventGrid.json
  - Microsoft.EventGrid/preview/2019-02-01-preview/EventGrid.json
  - Microsoft.EventGrid/stable/2019-01-01/EventGrid.json
  - Microsoft.EventGrid/preview/2018-09-15-preview/EventGrid.json
  - Microsoft.EventGrid/preview/2018-05-01-preview/EventGrid.json
  - Microsoft.EventGrid/stable/2018-01-01/EventGrid.json
  - Microsoft.EventGrid/preview/2017-09-15-preview/EventGrid.json
  - Microsoft.EventGrid/preview/2017-06-15-preview/EventGrid.json

```