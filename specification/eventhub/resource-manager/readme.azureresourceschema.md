## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.EventHub/stable/2017-04-01/AuthorizationRules.json
  - Microsoft.EventHub/stable/2017-04-01/CheckNameAvailability.json
  - Microsoft.EventHub/stable/2017-04-01/consumergroups.json
  - Microsoft.EventHub/stable/2017-04-01/disasterRecoveryConfigs.json
  - Microsoft.EventHub/stable/2017-04-01/eventhubs.json
  - Microsoft.EventHub/stable/2017-04-01/namespaces.json
  - Microsoft.EventHub/stable/2017-04-01/networkRuleSets.json
  - Microsoft.EventHub/stable/2017-04-01/operations.json
  - Microsoft.EventHub/stable/2017-04-01/sku.json
  - Microsoft.EventHub/stable/2015-08-01/EventHub.json
  - Microsoft.EventHub/stable/2014-09-01/EventHub.json
  - Microsoft.EventHub/preview/2018-01-01-preview/AvailableClusterRegions-preview.json
  - Microsoft.EventHub/preview/2018-01-01-preview/Clusters-preview.json
  - Microsoft.EventHub/preview/2018-01-01-preview/ipfilterrules-preview.json
  - Microsoft.EventHub/preview/2018-01-01-preview/namespaces-preview.json
  - Microsoft.EventHub/preview/2018-01-01-preview/quotaConfiguration-preview.json
  - Microsoft.EventHub/preview/2018-01-01-preview/virtualnetworkrules-preview.json
  - Microsoft.EventHub/preview/2018-01-01-preview/networkrulessets-preview.json

```