## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.BotService/stable/2020-06-02/botservice.json
  - Microsoft.BotService/preview/2018-07-12/botservice.json
  - Microsoft.BotService/preview/2017-12-01/botservice.json

```