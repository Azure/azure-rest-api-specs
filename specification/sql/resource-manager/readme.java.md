
### Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
modelerfour:
  lenient-model-deduplication: true
rename-model: SecurityAlertsPolicyState:SecurityAlertPolicyState
enable-sync-stack: false
directive:
  - from: SqlVulnerabilityAssessmentsSettings.json
    where-operation: SqlVulnerabilityAssessmentsSettings_CreateOrUpdate
    transform: >
      $.parameters[2]["x-ms-enum"].name= "SqlVulnerabilityAssessmentName"
  - from: SqlVulnerabilityAssessmentsSettings.json
    where-operation: SqlVulnerabilityAssessments_Delete
    transform: >
      $.parameters[2]["x-ms-enum"].name = "SqlVulnerabilityAssessmentName"
```
