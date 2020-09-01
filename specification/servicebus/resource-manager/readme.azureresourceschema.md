## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.ServiceBus/preview/2018-01-01-preview/servicebus-preview.json
  - Microsoft.ServiceBus/stable/2017-04-01/servicebus.json
  - Microsoft.ServiceBus/stable/2015-08-01/servicebus.json

```