# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.Insights/stable/2015-04-01/autoscale_API.json
  - $(this-folder)/Microsoft.Insights/stable/2015-04-01/operations_API.json
  - $(this-folder)/Microsoft.Insights/stable/2016-03-01/alertRulesIncidents_API.json
  - $(this-folder)/Microsoft.Insights/stable/2016-03-01/alertRules_API.json
  - $(this-folder)/Microsoft.Insights/stable/2016-03-01/logProfiles_API.json
  - $(this-folder)/Microsoft.Insights/preview/2017-05-01-preview/diagnosticsSettings_API.json
  - $(this-folder)/Microsoft.Insights/preview/2017-05-01-preview/diagnosticsSettingsCategories_API.json
  - $(this-folder)/Microsoft.Insights/stable/2019-03-01/actionGroups_API.json
  - $(this-folder)/Microsoft.Insights/stable/2017-04-01/activityLogAlerts_API.json
  - $(this-folder)/Microsoft.Insights/stable/2015-04-01/activityLogs_API.json
  - $(this-folder)/Microsoft.Insights/stable/2015-04-01/eventCategories_API.json
  - $(this-folder)/Microsoft.Insights/stable/2015-04-01/tenantActivityLogs_API.json
  - $(this-folder)/Microsoft.Insights/stable/2018-01-01/metricDefinitions_API.json
  - $(this-folder)/Microsoft.Insights/stable/2018-01-01/metrics_API.json
  - $(this-folder)/Microsoft.Insights/preview/2017-11-01-preview/baseline_API.json
  - $(this-folder)/Microsoft.Insights/preview/2017-11-01-preview/calculateBaseline_API.json
  - $(this-folder)/Microsoft.Insights/stable/2019-03-01/metricBaselines_API.json
  - $(this-folder)/Microsoft.Insights/stable/2018-03-01/metricAlert_API.json
  - $(this-folder)/Microsoft.Insights/stable/2018-04-16/scheduledQueryRule_API.json
  - $(this-folder)/Microsoft.Insights/preview/2017-12-01-preview/metricNamespaces_API.json
  - $(this-folder)/Microsoft.Insights/preview/2018-11-27-preview/vmInsightsOnboarding_API.json
  - $(this-folder)/Microsoft.Insights/stable/2018-09-01/actionGroups_API.json
  - $(this-folder)/Microsoft.Insights/stable/2018-03-01/actionGroups_API.json
  - $(this-folder)/Microsoft.Insights/stable/2017-04-01/actionGroups_API.json
  - $(this-folder)/Microsoft.Insights/preview/2017-05-01-preview/metricDefinitions_API.json
  - $(this-folder)/Microsoft.Insights/preview/2017-05-01-preview/metrics_API.json
  - $(this-folder)/Microsoft.Insights/stable/2016-03-01/metricDefinitions_API.json
  - $(this-folder)/Microsoft.Insights/stable/2016-09-01/metrics_API.json
  - $(this-folder)/Microsoft.Insights/stable/2016-09-01/serviceDiagnosticsSettings_API.json
require: $(this-folder)/../../../profiles/readme.md
```
