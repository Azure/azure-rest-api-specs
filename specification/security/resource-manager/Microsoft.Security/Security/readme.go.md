## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: security
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/security/armsecurity
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
modelerfour:
  lenient-model-deduplication: true
directive:
- from: swagger-document
  where: '$.paths.*[?(@.operationId.startsWith("Connectors_"))]'
  transform: >
    $["operationId"] = $["operationId"].replace("Connectors_", "AccountConnectors_");
- rename-model:
    from: SecurityOperator
    to: OperatorResource
- from: externalSecuritySolutions.json
  where: $.definitions['ExternalSecuritySolutionKind']
  transform: >
      $ = {
        "type": "string",
        "description": "The kind of the external solution",
        "enum": [
          "CEF",
          "ATA",
          "AAD"
        ],
        "x-ms-enum": {
          "name": "ExternalSecuritySolutionKind",
          "modelAsString": true,
          "values": [
            {
              "value": "CEF"
            },
            {
              "value": "ATA"
            },
            {
              "value": "AAD"
            }
          ]
        }
      };
- from: externalSecuritySolutions.json
  where: $.definitions['ExternalSecuritySolution']
  transform: >
      $.properties['kind'] = {
        "$ref": "#/definitions/ExternalSecuritySolutionKind"
      };
      $.allOf = [
        {
          "$ref": "./common/v1/types.json#/definitions/Resource"
        },
        {
          "$ref": "./common/v1/types.json#/definitions/Location"
        }
      ]
```

### Tag: package-combine-2026-04

These settings apply only when `--tag=package-combine-2026-04` is specified on the command line.

```yaml $(tag) == 'package-combine-2026-04'
input-file:
 - preview/2015-06-01-preview/locations.json
- preview/2015-06-01-preview/tasks.json
- preview/2017-08-01-preview/autoProvisioningSettings.json
- preview/2017-08-01-preview/compliances.json
- preview/2017-08-01-preview/informationProtectionPolicies.json
- preview/2017-08-01-preview/workspaceSettings.json
- preview/2019-01-01-preview/alertsSuppressionRules.json
- preview/2019-01-01-preview/regulatoryCompliance.json
- preview/2019-01-01-preview/subAssessments.json
- preview/2021-10-01-preview/mdeOnboardings.json
- preview/2022-01-01-preview/governanceAssignments.json
- preview/2022-01-01-preview/governanceRules.json
- preview/2022-07-01-preview/applications.json
- preview/2023-01-01-preview/securityOperators.json
- preview/2026-04-01-preview/sqlVulnerabilityAssessmentsBaselineRuleOperations.json
- preview/2026-04-01-preview/sqlVulnerabilityAssessmentsScanOperations.json
- preview/2026-04-01-preview/sqlVulnerabilityAssessmentsScanResultsOperations.json
- preview/2026-04-01-preview/sqlVulnerabilityAssessmentsSettingsOperations.json
- preview/2023-02-15-preview/sensitivitySettings.json
- preview/2023-05-01-preview/healthReports.json
- preview/2023-12-01-preview/automations.json
- preview/2024-08-01-preview/securityConnectors.json
- preview/2025-11-01-preview/securityConnectorsDevOps.json
- preview/2025-10-01-preview/operations.json
- preview/2025-10-01-preview/operationResults.json
- preview/2025-10-01-preview/operationStatuses.json
- stable/2025-05-04/assessmentMetadata.json
- stable/2025-05-04/assessments.json
- stable/2017-08-01/complianceResults.json
- stable/2019-01-01/advancedThreatProtectionSettings.json
- stable/2019-08-01/deviceSecurityGroups.json
- stable/2019-08-01/iotSecuritySolutionAnalytics.json
- stable/2019-08-01/iotSecuritySolutions.json
- stable/2020-01-01/allowedConnections.json
- stable/2020-01-01/discoveredSecuritySolutions.json
- stable/2020-01-01/externalSecuritySolutions.json
- stable/2020-01-01/jitNetworkAccessPolicies.json
- stable/2020-01-01/securitySolutions.json
- stable/2020-01-01/securitySolutionsReferenceData.json
- stable/2020-01-01/serverVulnerabilityAssessments.json
- stable/2020-01-01/topologies.json
- stable/2022-01-01/alerts.json
- stable/2022-05-01/settings.json
- stable/2023-05-01/ServerVulnerabilityAssessmentsSettings.json
- stable/2023-11-15/apiCollections.json
- stable/2024-01-01/pricings.json
- stable/2024-08-01/securityStandards.json
- stable/2024-08-01/standardAssignments.json
- stable/2024-08-01/customRecommendations.json
- preview/2021-08-01-preview/standards.json
- preview/2021-08-01-preview/assignments.json
- preview/2025-09-01-preview/defenderForStorageSettings.json
- stable/2026-01-01/privateLinks.json
- stable/2020-01-01/secureScore.json
```

### Common Go settings

```yaml $(go) && $(multiapi)
batch:
  - tag: package-composite-v1
  - tag: package-composite-v2
  - tag: package-composite-v3
```

### Tag: package-composite-v1 and go

These settings apply only when `--tag=package-composite-v1 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-composite-v1' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/v1.0/$(namespace)
```

### Tag: package-composite-v2 and go

These settings apply only when `--tag=package-composite-v2 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-composite-v2' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/v2.0/$(namespace)
```

### Tag: package-composite-v3 and go

These settings apply only when `--tag=package-composite-v3 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-composite-v3' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/v3.0/$(namespace)
```
