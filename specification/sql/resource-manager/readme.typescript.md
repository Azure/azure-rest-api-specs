## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-sql"
  output-folder: "$(typescript-sdks-folder)/sdk/sql/arm-sql"
  generate-metadata: true

directive:
- from: SqlVulnerabilityAssessmentScanResult.json
  where-operation: SqlVulnerabilityAssessmentScanResult_ListByScan
  transform: $.parameters[2]["x-ms-enum"].name = "SQLVulnerabilityAssessmentName"

- from: SqlVulnerabilityAssessmentScanResult.json
  where-operation: SqlVulnerabilityAssessmentScanResult_Get
  transform: $.parameters[2]["x-ms-enum"].name = "SQLVulnerabilityAssessmentName"

- from: DatabaseSqlVulnerabilityAssessmentScanResult.json
  where-operation: DatabaseSqlVulnerabilityAssessmentScanResult_ListByScan
  transform: $.parameters[3]["x-ms-enum"].name = "SQLVulnerabilityAssessmentName"

- from: DatabaseSqlVulnerabilityAssessmentScanResult.json
  where-operation: DatabaseSqlVulnerabilityAssessmentScanResult_Get
  transform: $.parameters[3]["x-ms-enum"].name = "SQLVulnerabilityAssessmentName"
```
