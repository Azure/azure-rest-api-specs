## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.Relay/stable/2017-04-01/relay.json
  - Microsoft.Relay/stable/2016-07-01/relay.json
  - Microsoft.Relay/preview/2018-01-01-preview/Namespaces-preview.json
  - Microsoft.Relay/preview/2018-01-01-preview/NetworkRuleSets-preview.json
  - Microsoft.Relay/preview/2018-01-01-preview/PrivateEndpointConnection-preview.json
  - Microsoft.Relay/preview/2018-01-01-preview/PrivateLinkResources-preview.json

```