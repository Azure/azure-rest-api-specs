## Java

These settings apply only when `--java` is specified on the command line.

``` yaml $(java)
modelerfour:
  lenient-model-deduplication: true
add-inner: AutoscaleProfile,ScaleRule,LocalizableString,DiagnosticSettingsCategoryResourceCollection
rename-model: MetricUnit:Unit
enable-sync-stack: false
directive:
  - from: activityLogAlerts_API.json
    where: '$.definitions'
    transform: >
      $.ActionGroup["x-ms-client-name"] = "ActivityLogAlertActionGroup";
      $.AlertRuleAllOfCondition["x-ms-client-name"] = "ActivityLogAlertAllOfCondition";
      $.AlertRuleAnyOfOrLeafCondition["x-ms-client-name"] = "ActivityLogAlertLeafCondition";
  - from: diagnosticsSettingsCategories_API.json
    where: '$.definitions.DiagnosticSettingsCategory.properties.categoryType'
    transform: >
      $["x-ms-enum"].modelAsString = false
  - from: azuremonitorworkspace.json
    where: '$.definitions.AlertSeverity'
    transform: >
      $["x-ms-enum"].name = "MonitorWorkspaceAlertSeverity"
```

### Tag: package-composite-v1

``` yaml $(java) && $(tag) == 'package-composite-v1'
input-file:
- Microsoft.Insights/stable/2022-10-01/autoscale_API.json
- Microsoft.Insights/stable/2015-04-01/operations_API.json
- Microsoft.Insights/stable/2016-03-01/alertRulesIncidents_API.json
- Microsoft.Insights/stable/2016-03-01/alertRules_API.json
- Microsoft.Insights/stable/2016-03-01/logProfiles_API.json
- Microsoft.Insights/preview/2021-05-01-preview/diagnosticsSettings_API.json
- Microsoft.Insights/preview/2021-05-01-preview/diagnosticsSettingsCategories_API.json
- Microsoft.Insights/stable/2022-06-01/actionGroups_API.json
- Microsoft.Insights/stable/2015-04-01/activityLogs_API.json
- Microsoft.Insights/stable/2015-04-01/eventCategories_API.json
- Microsoft.Insights/stable/2015-04-01/tenantActivityLogs_API.json
- Microsoft.Insights/stable/2018-01-01/metricDefinitions_API.json
- Microsoft.Insights/stable/2018-01-01/metrics_API.json
- Microsoft.Insights/stable/2019-03-01/metricBaselines_API.json
- Microsoft.Insights/stable/2018-03-01/metricAlert_API.json
- Microsoft.Insights/stable/2022-06-15/scheduledQueryRule_API.json
- Microsoft.Insights/preview/2017-12-01-preview/metricNamespaces_API.json
- Microsoft.Insights/preview/2018-11-27-preview/vmInsightsOnboarding_API.json
- Microsoft.Insights/preview/2021-07-01-preview/privateLinkScopes_API.json
- Microsoft.Insights/stable/2020-10-01/activityLogAlerts_API.json
- Microsoft.Insights/preview/2021-09-01-preview/dataCollectionEndpoints_API.json
- Microsoft.Insights/preview/2021-09-01-preview/dataCollectionRuleAssociations_API.json
- Microsoft.Insights/preview/2021-09-01-preview/dataCollectionRules_API.json
```
