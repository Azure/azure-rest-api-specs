## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.DesktopVirtualization/preview/2019-01-23-preview/desktopvirtualization.json
  - Microsoft.DesktopVirtualization/preview/2019-09-24-preview/desktopvirtualization.json
  - Microsoft.DesktopVirtualization/preview/2019-12-10-preview/desktopvirtualization.json

```