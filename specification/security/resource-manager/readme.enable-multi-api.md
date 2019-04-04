# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - Microsoft.Security/preview/2019-01-01-preview/regulatoryCompliance.json
  - Microsoft.Security/preview/2017-08-01-preview/pricings.json
  - Microsoft.Security/preview/2017-08-01-preview/securityContacts.json
  - Microsoft.Security/preview/2017-08-01-preview/workspaceSettings.json
  - Microsoft.Security/preview/2017-08-01-preview/autoProvisioningSettings.json
  - Microsoft.Security/preview/2017-08-01-preview/compliances.json
  - Microsoft.Security/preview/2017-08-01-preview/advancedThreatProtectionSettings.json
  - Microsoft.Security/preview/2017-08-01-preview/deviceSecurityGroups.json
  - Microsoft.Security/preview/2017-08-01-preview/settings.json
  - Microsoft.Security/preview/2017-08-01-preview/informationProtectionPolicies.json
  - Microsoft.Security/preview/2015-06-01-preview/operations.json
  - Microsoft.Security/preview/2015-06-01-preview/locations.json
  - Microsoft.Security/preview/2015-06-01-preview/tasks.json
  - Microsoft.Security/preview/2015-06-01-preview/alerts.json
  - Microsoft.Security/preview/2015-06-01-preview/discoveredSecuritySolutions.json
  - Microsoft.Security/preview/2015-06-01-preview/jitNetworkAccessPolicies.json
  - Microsoft.Security/preview/2015-06-01-preview/externalSecuritySolutions.json
  - Microsoft.Security/preview/2015-06-01-preview/topologies.json
  - Microsoft.Security/preview/2015-06-01-preview/allowedConnections.json
  - Microsoft.Security/preview/2015-06-01-preview/adaptiveNetworkHardenings.json
  - Microsoft.Security/stable/2018-06-01/pricings.json
  - Microsoft.Security/stable/2019-01-01/alerts.json
require: $(this-folder)/../../../../profiles/readme.md
```
