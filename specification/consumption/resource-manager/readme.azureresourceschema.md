## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.Consumption/stable/2019-10-01/consumption.json
  - Microsoft.Consumption/stable/2019-06-01/consumption.json
  - Microsoft.Consumption/stable/2019-05-01/consumption.json
  - Microsoft.Consumption/preview/2019-05-01-preview/consumption.json
  - Microsoft.Consumption/preview/2019-04-01-preview/consumption.json
  - Microsoft.Consumption/preview/2018-11-01-preview/consumption.json
  - Microsoft.Consumption/stable/2019-01-01/consumption.json
  - Microsoft.Consumption/stable/2017-11-30/consumption.json
  - Microsoft.Consumption/stable/2018-01-31/consumption.json
  - Microsoft.Consumption/stable/2018-03-31/consumption.json
  - Microsoft.Consumption/stable/2018-05-31/consumption.json
  - Microsoft.Consumption/stable/2018-06-30/consumption.json
  - Microsoft.Consumption/stable/2018-08-31/consumption.json
  - Microsoft.Consumption/stable/2018-10-01/consumption.json
  - Microsoft.Consumption/preview/2017-04-24-preview/consumption.json
  - Microsoft.Consumption/preview/2017-12-30-preview/consumption.json

```