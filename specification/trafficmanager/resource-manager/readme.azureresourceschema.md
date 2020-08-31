## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.Network/stable/2018-04-01/trafficmanager.json
  - Microsoft.Network/stable/2018-03-01/trafficmanager.json
  - Microsoft.Network/stable/2018-02-01/trafficmanager.json
  - Microsoft.Network/preview/2017-09-01-preview/trafficmanageranalytics.json
  - Microsoft.Network/stable/2017-05-01/trafficmanager.json
  - Microsoft.Network/stable/2017-03-01/trafficmanager.json
  - Microsoft.Network/stable/2015-11-01/trafficmanager.json

```