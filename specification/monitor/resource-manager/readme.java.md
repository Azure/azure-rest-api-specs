## Java

These settings apply only when `--java` is specified on the command line.

``` yaml $(java)
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