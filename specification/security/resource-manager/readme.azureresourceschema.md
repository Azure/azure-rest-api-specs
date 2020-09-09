## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-security-2020-08-06-preview
  - tag: schema-security-2020-01-01-preview
  - tag: schema-security-2020-01-01
  - tag: schema-security-2019-08-01
  - tag: schema-security-2019-01-01-preview
  - tag: schema-security-2019-01-01
  - tag: schema-security-2018-06-01
  - tag: schema-security-2017-08-01-preview
  - tag: schema-security-2017-08-01
  - tag: schema-security-2015-06-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-security-2020-08-06-preview and azureresourceschema

``` yaml $(tag) == 'schema-security-2020-08-06-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Security/preview/2020-08-06-preview/iotDefenderSettings.json
  - Microsoft.Security/preview/2020-08-06-preview/iotSensors.json
  - $(this-folder)/Microsoft.Security/preview/2020-08-06-preview/iotDefenderSettings.json
  - $(this-folder)/Microsoft.Security/preview/2020-08-06-preview/iotSensors.json

```

### Tag: schema-security-2020-01-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-security-2020-01-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Security/preview/2020-01-01-preview/secureScore.json
  - Microsoft.Security/preview/2020-01-01-preview/connectors.json
  - $(this-folder)/Microsoft.Security/preview/2020-01-01-preview/secureScore.json
  - $(this-folder)/Microsoft.Security/preview/2020-01-01-preview/connectors.json
  - $(this-folder)/Microsoft.Security/preview/2020-01-01-preview/securityContacts.json

```

### Tag: schema-security-2020-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-security-2020-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Security/stable/2020-01-01/serverVulnerabilityAssessments.json
  - Microsoft.Security/stable/2020-01-01/assessmentMetadata.json
  - Microsoft.Security/stable/2020-01-01/assessments.json
  - Microsoft.Security/stable/2020-01-01/applicationWhitelistings.json
  - Microsoft.Security/stable/2020-01-01/adaptiveNetworkHardenings.json
  - Microsoft.Security/stable/2020-01-01/allowedConnections.json
  - Microsoft.Security/stable/2020-01-01/topologies.json
  - Microsoft.Security/stable/2020-01-01/alerts.json
  - Microsoft.Security/stable/2020-01-01/jitNetworkAccessPolicies.json
  - Microsoft.Security/stable/2020-01-01/discoveredSecuritySolutions.json
  - Microsoft.Security/stable/2020-01-01/securitySolutionsReferenceData.json
  - Microsoft.Security/stable/2020-01-01/externalSecuritySolutions.json
  - Microsoft.Security/stable/2020-01-01/SecuritySolutions.json
  - $(this-folder)/Microsoft.Security/stable/2020-01-01/serverVulnerabilityAssessments.json
  - $(this-folder)/Microsoft.Security/stable/2020-01-01/assessmentMetadata.json
  - $(this-folder)/Microsoft.Security/stable/2020-01-01/assessments.json
  - $(this-folder)/Microsoft.Security/stable/2020-01-01/applicationWhitelistings.json
  - $(this-folder)/Microsoft.Security/stable/2020-01-01/adaptiveNetworkHardenings.json
  - $(this-folder)/Microsoft.Security/stable/2020-01-01/allowedConnections.json
  - $(this-folder)/Microsoft.Security/stable/2020-01-01/topologies.json
  - $(this-folder)/Microsoft.Security/stable/2020-01-01/alerts.json
  - $(this-folder)/Microsoft.Security/stable/2020-01-01/jitNetworkAccessPolicies.json
  - $(this-folder)/Microsoft.Security/stable/2020-01-01/discoveredSecuritySolutions.json
  - $(this-folder)/Microsoft.Security/stable/2020-01-01/securitySolutionsReferenceData.json
  - $(this-folder)/Microsoft.Security/stable/2020-01-01/SecuritySolutions.json
  - $(this-folder)/Microsoft.Security/stable/2020-01-01/externalSecuritySolutions.json

```

### Tag: schema-security-2019-08-01 and azureresourceschema

``` yaml $(tag) == 'schema-security-2019-08-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Security/stable/2019-08-01/deviceSecurityGroups.json
  - Microsoft.Security/stable/2019-08-01/iotSecuritySolutions.json
  - Microsoft.Security/stable/2019-08-01/iotSecuritySolutionAnalytics.json
  - Microsoft.Security/stable/2019-08-01/iotAlertTypes.json
  - Microsoft.Security/stable/2019-08-01/iotAlerts.json
  - Microsoft.Security/stable/2019-08-01/iotRecommendationTypes.json
  - Microsoft.Security/stable/2019-08-01/iotRecommendations.json
  - $(this-folder)/Microsoft.Security/stable/2019-08-01/deviceSecurityGroups.json
  - $(this-folder)/Microsoft.Security/stable/2019-08-01/iotSecuritySolutions.json
  - $(this-folder)/Microsoft.Security/stable/2019-08-01/iotSecuritySolutionAnalytics.json
  - $(this-folder)/Microsoft.Security/stable/2019-08-01/iotAlertTypes.json
  - $(this-folder)/Microsoft.Security/stable/2019-08-01/iotAlerts.json
  - $(this-folder)/Microsoft.Security/stable/2019-08-01/iotRecommendationTypes.json
  - $(this-folder)/Microsoft.Security/stable/2019-08-01/iotRecommendations.json

```

### Tag: schema-security-2019-01-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-security-2019-01-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Security/preview/2019-01-01-preview/automations.json
  - Microsoft.Security/preview/2019-01-01-preview/subAssessments.json
  - Microsoft.Security/preview/2019-01-01-preview/regulatoryCompliance.json
  - Microsoft.Security/preview/2019-01-01-preview/alertsSuppressionRules.json
  - Microsoft.Security/preview/2019-01-01-preview/assessmentMetadata.json
  - Microsoft.Security/preview/2019-01-01-preview/assessments.json
  - $(this-folder)/Microsoft.Security/preview/2019-01-01-preview/automations.json
  - $(this-folder)/Microsoft.Security/preview/2019-01-01-preview/subAssessments.json
  - $(this-folder)/Microsoft.Security/preview/2019-01-01-preview/regulatoryCompliance.json
  - $(this-folder)/Microsoft.Security/preview/2019-01-01-preview/alertsSuppressionRules.json
  - $(this-folder)/Microsoft.Security/preview/2019-01-01-preview/assessmentMetadata.json
  - $(this-folder)/Microsoft.Security/preview/2019-01-01-preview/assessments.json

```

### Tag: schema-security-2019-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-security-2019-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Security/stable/2019-01-01/alerts.json
  - Microsoft.Security/stable/2019-01-01/settings.json
  - Microsoft.Security/stable/2019-01-01/advancedThreatProtectionSettings.json
  - $(this-folder)/Microsoft.Security/stable/2019-01-01/settings.json
  - $(this-folder)/Microsoft.Security/stable/2019-01-01/advancedThreatProtectionSettings.json

```

### Tag: schema-security-2018-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-security-2018-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Security/stable/2018-06-01/pricings.json
  - $(this-folder)/Microsoft.Security/stable/2018-06-01/pricings.json

```

### Tag: schema-security-2017-08-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-security-2017-08-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Security/preview/2017-08-01-preview/pricings.json
  - Microsoft.Security/preview/2017-08-01-preview/securityContacts.json
  - Microsoft.Security/preview/2017-08-01-preview/workspaceSettings.json
  - Microsoft.Security/preview/2017-08-01-preview/autoProvisioningSettings.json
  - Microsoft.Security/preview/2017-08-01-preview/compliances.json
  - Microsoft.Security/preview/2017-08-01-preview/advancedThreatProtectionSettings.json
  - Microsoft.Security/preview/2017-08-01-preview/deviceSecurityGroups.json
  - Microsoft.Security/preview/2017-08-01-preview/settings.json
  - Microsoft.Security/preview/2017-08-01-preview/informationProtectionPolicies.json
  - Microsoft.Security/preview/2017-08-01-preview/iotSecuritySolutions.json
  - Microsoft.Security/preview/2017-08-01-preview/iotSecuritySolutionAnalytics.json
  - $(this-folder)/Microsoft.Security/preview/2017-08-01-preview/pricings.json
  - $(this-folder)/Microsoft.Security/preview/2017-08-01-preview/securityContacts.json
  - $(this-folder)/Microsoft.Security/preview/2017-08-01-preview/workspaceSettings.json
  - $(this-folder)/Microsoft.Security/preview/2017-08-01-preview/autoProvisioningSettings.json
  - $(this-folder)/Microsoft.Security/preview/2017-08-01-preview/compliances.json
  - $(this-folder)/Microsoft.Security/preview/2017-08-01-preview/advancedThreatProtectionSettings.json
  - $(this-folder)/Microsoft.Security/preview/2017-08-01-preview/deviceSecurityGroups.json
  - $(this-folder)/Microsoft.Security/preview/2017-08-01-preview/settings.json
  - $(this-folder)/Microsoft.Security/preview/2017-08-01-preview/informationProtectionPolicies.json
  - $(this-folder)/Microsoft.Security/preview/2017-08-01-preview/iotSecuritySolutions.json
  - $(this-folder)/Microsoft.Security/preview/2017-08-01-preview/iotSecuritySolutionAnalytics.json

```

### Tag: schema-security-2017-08-01 and azureresourceschema

``` yaml $(tag) == 'schema-security-2017-08-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Security/stable/2017-08-01/complianceResults.json
  - $(this-folder)/Microsoft.Security/stable/2017-08-01/complianceResults.json

```

### Tag: schema-security-2015-06-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-security-2015-06-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
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
  - $(this-folder)/Microsoft.Security/preview/2015-06-01-preview/operations.json
  - $(this-folder)/Microsoft.Security/preview/2015-06-01-preview/locations.json
  - $(this-folder)/Microsoft.Security/preview/2015-06-01-preview/tasks.json
  - $(this-folder)/Microsoft.Security/preview/2015-06-01-preview/alerts.json
  - $(this-folder)/Microsoft.Security/preview/2015-06-01-preview/discoveredSecuritySolutions.json
  - $(this-folder)/Microsoft.Security/preview/2015-06-01-preview/jitNetworkAccessPolicies.json
  - $(this-folder)/Microsoft.Security/preview/2015-06-01-preview/applicationWhitelistings.json
  - $(this-folder)/Microsoft.Security/preview/2015-06-01-preview/externalSecuritySolutions.json
  - $(this-folder)/Microsoft.Security/preview/2015-06-01-preview/topologies.json
  - $(this-folder)/Microsoft.Security/preview/2015-06-01-preview/allowedConnections.json
  - $(this-folder)/Microsoft.Security/preview/2015-06-01-preview/adaptiveNetworkHardenings.json

```
