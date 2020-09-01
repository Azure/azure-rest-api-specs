## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.Devices/preview/2017-08-21-preview/iotdps.json
  - Microsoft.Devices/stable/2017-11-15/iotdps.json
  - Microsoft.Devices/stable/2018-01-22/iotdps.json
  - Microsoft.Devices/stable/2020-01-01/iotdps.json

```