## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.Devices/preview/2020-07-10-preview/iothub.json
  - Microsoft.Devices/stable/2020-06-15/iothub.json
  - Microsoft.Devices/stable/2020-04-01/iothub.json
  - Microsoft.Devices/stable/2020-03-01/iothub.json
  - Microsoft.Devices/stable/2019-11-04/iothub.json
  - Microsoft.Devices/preview/2019-07-01-preview/iothub.json
  - Microsoft.Devices/stable/2019-03-22/iothub.json
  - Microsoft.Devices/preview/2019-03-22-preview/iothub.json
  - Microsoft.Devices/preview/2018-12-01-preview/iothub.json
  - Microsoft.Devices/stable/2018-04-01/iothub.json
  - Microsoft.Devices/stable/2018-01-22/iothub.json
  - Microsoft.Devices/stable/2017-07-01/iothub.json
  - Microsoft.Devices/stable/2017-01-19/iothub.json
  - Microsoft.Devices/stable/2016-02-03/iothub.json

```