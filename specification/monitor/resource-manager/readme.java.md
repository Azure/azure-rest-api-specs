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
```