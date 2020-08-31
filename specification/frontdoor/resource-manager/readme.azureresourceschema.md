## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.Network/stable/2020-05-01/network.json
  - Microsoft.Network/stable/2019-11-01/networkexperiment.json
  - Microsoft.Network/stable/2020-05-01/frontdoor.json
  - Microsoft.Network/stable/2020-04-01/webapplicationfirewall.json
  - Microsoft.Network/stable/2020-04-01/network.json
  - Microsoft.Network/stable/2020-04-01/frontdoor.json
  - Microsoft.Network/stable/2020-01-01/network.json
  - Microsoft.Network/stable/2020-01-01/frontdoor.json
  - Microsoft.Network/stable/2019-10-01/webapplicationfirewall.json
  - Microsoft.Network/stable/2019-11-01/network.json
  - Microsoft.Network/stable/2019-05-01/frontdoor.json
  - Microsoft.Network/stable/2019-05-01/network.json
  - Microsoft.Network/stable/2019-03-01/webapplicationfirewall.json
  - Microsoft.Network/stable/2019-04-01/frontdoor.json
  - Microsoft.Network/stable/2019-04-01/network.json
  - Microsoft.Network/preview/2018-08-01-preview/frontdoor.json
  - Microsoft.Network/preview/2018-08-01-preview/network.json
  - Microsoft.Network/preview/2019-03-01-preview/webapplicationfirewall.json
  - Microsoft.Network/preview/2018-08-01-preview/webapplicationfirewall.json

```