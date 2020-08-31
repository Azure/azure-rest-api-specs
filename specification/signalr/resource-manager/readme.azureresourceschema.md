## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.SignalRService/preview/2020-07-01-preview/signalr.json
  - Microsoft.SignalRService/stable/2020-05-01/signalr.json
  - Microsoft.SignalRService/stable/2018-10-01/signalr.json
  - Microsoft.SignalRService/preview/2018-03-01-preview/signalr.json

```