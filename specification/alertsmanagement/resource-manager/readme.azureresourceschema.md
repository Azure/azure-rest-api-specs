## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.AlertsManagement/preview/2019-05-05-preview/ActionRules.json
  - Microsoft.AlertsManagement/preview/2019-05-05-preview/AlertsManagement.json
  - Microsoft.AlertsManagement/preview/2019-05-05-preview/SmartGroups.json
  - Microsoft.AlertsManagement/stable/2019-06-01/SmartDetectorAlertRulesApi.json
  - Microsoft.AlertsManagement/stable/2019-03-01/AlertsManagement.json
  - Microsoft.AlertsManagement/stable/2019-03-01/SmartDetectorAlertRulesApi.json
  - Microsoft.AlertsManagement/stable/2018-05-05/AlertsManagement.json
  - Microsoft.AlertsManagement/preview/2018-05-05-preview/AlertsManagement.json

```