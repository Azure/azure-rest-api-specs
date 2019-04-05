# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.Security/preview/2019-01-01-preview/regulatoryCompliance.json
  - $(this-folder)/Microsoft.Security/preview/2017-08-01-preview/pricings.json
  - $(this-folder)/Microsoft.Security/preview/2017-08-01-preview/securityContacts.json
  - $(this-folder)/Microsoft.Security/preview/2017-08-01-preview/workspaceSettings.json
  - $(this-folder)/Microsoft.Security/preview/2017-08-01-preview/autoProvisioningSettings.json
  - $(this-folder)/Microsoft.Security/preview/2017-08-01-preview/compliances.json
  - $(this-folder)/Microsoft.Security/preview/2017-08-01-preview/advancedThreatProtectionSettings.json
  - $(this-folder)/Microsoft.Security/preview/2017-08-01-preview/deviceSecurityGroups.json
  - $(this-folder)/Microsoft.Security/preview/2017-08-01-preview/settings.json
  - $(this-folder)/Microsoft.Security/preview/2017-08-01-preview/informationProtectionPolicies.json
  - $(this-folder)/Microsoft.Security/preview/2015-06-01-preview/operations.json
  - $(this-folder)/Microsoft.Security/preview/2015-06-01-preview/locations.json
  - $(this-folder)/Microsoft.Security/preview/2015-06-01-preview/tasks.json
  - $(this-folder)/Microsoft.Security/preview/2015-06-01-preview/alerts.json
  - $(this-folder)/Microsoft.Security/preview/2015-06-01-preview/discoveredSecuritySolutions.json
  - $(this-folder)/Microsoft.Security/preview/2015-06-01-preview/jitNetworkAccessPolicies.json
  - $(this-folder)/Microsoft.Security/preview/2015-06-01-preview/externalSecuritySolutions.json
  - $(this-folder)/Microsoft.Security/preview/2015-06-01-preview/topologies.json
  - $(this-folder)/Microsoft.Security/preview/2015-06-01-preview/allowedConnections.json
  - $(this-folder)/Microsoft.Security/preview/2015-06-01-preview/adaptiveNetworkHardenings.json
  - $(this-folder)/Microsoft.Security/stable/2018-06-01/pricings.json
  - $(this-folder)/Microsoft.Security/stable/2019-01-01/alerts.json
require: $(this-folder)/../../../../profiles/readme.md
```
