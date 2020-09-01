## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.Security/preview/2020-01-01-preview/secureScore.json
  - Microsoft.Security/preview/2020-01-01-preview/connectors.json
  - Microsoft.Security/preview/2019-01-01-preview/automations.json
  - Microsoft.Security/preview/2019-01-01-preview/subAssessments.json
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
  - Microsoft.Security/preview/2015-06-01-preview/applicationWhitelistings.json
  - Microsoft.Security/preview/2015-06-01-preview/externalSecuritySolutions.json
  - Microsoft.Security/preview/2015-06-01-preview/topologies.json
  - Microsoft.Security/preview/2015-06-01-preview/allowedConnections.json
  - Microsoft.Security/preview/2015-06-01-preview/adaptiveNetworkHardenings.json
  - Microsoft.Security/preview/2019-01-01-preview/alertsSuppressionRules.json
  - Microsoft.Security/stable/2018-06-01/pricings.json
  - Microsoft.Security/preview/2017-08-01-preview/iotSecuritySolutions.json
  - Microsoft.Security/preview/2017-08-01-preview/iotSecuritySolutionAnalytics.json
  - Microsoft.Security/stable/2019-01-01/alerts.json
  - Microsoft.Security/stable/2017-08-01/complianceResults.json
  - Microsoft.Security/stable/2019-01-01/settings.json
  - Microsoft.Security/stable/2019-01-01/advancedThreatProtectionSettings.json
  - Microsoft.Security/stable/2019-08-01/deviceSecurityGroups.json
  - Microsoft.Security/stable/2019-08-01/iotSecuritySolutions.json
  - Microsoft.Security/stable/2019-08-01/iotSecuritySolutionAnalytics.json
  - Microsoft.Security/stable/2019-08-01/iotAlertTypes.json
  - Microsoft.Security/stable/2019-08-01/iotAlerts.json
  - Microsoft.Security/stable/2019-08-01/iotRecommendationTypes.json
  - Microsoft.Security/stable/2019-08-01/iotRecommendations.json
  - Microsoft.Security/stable/2020-01-01/serverVulnerabilityAssessments.json
  - Microsoft.Security/stable/2020-01-01/assessmentMetadata.json
  - Microsoft.Security/stable/2020-01-01/assessments.json
  - Microsoft.Security/stable/2020-01-01/applicationWhitelistings.json
  - Microsoft.Security/stable/2020-01-01/adaptiveNetworkHardenings.json
  - Microsoft.Security/stable/2020-01-01/allowedConnections.json
  - Microsoft.Security/stable/2020-01-01/topologies.json
  - Microsoft.Security/stable/2020-01-01/jitNetworkAccessPolicies.json
  - Microsoft.Security/stable/2020-01-01/discoveredSecuritySolutions.json
  - Microsoft.Security/stable/2020-01-01/securitySolutionsReferenceData.json
  - Microsoft.Security/stable/2020-01-01/externalSecuritySolutions.json
  - Microsoft.Security/stable/2020-01-01/SecuritySolutions.json
  - Microsoft.Security/preview/2020-08-06-preview/iotDefenderSettings.json
  - Microsoft.Security/preview/2020-08-06-preview/iotSensors.json
  - Microsoft.Security/preview/2019-01-01-preview/assessmentMetadata.json
  - Microsoft.Security/preview/2019-01-01-preview/assessments.json

```