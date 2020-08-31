## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.WindowsIoT/stable/2019-06-01/WindowsIotServices.json
  - Microsoft.WindowsIoT/preview/2018-02-16-preview/WindowsIotServices.json

```