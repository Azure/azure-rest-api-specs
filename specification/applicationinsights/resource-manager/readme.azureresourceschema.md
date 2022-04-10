## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.Insights/preview/2020-06-02-preview/livetoken_API.json
  - Microsoft.Insights/stable/2015-05-01/aiOperations_API.json
  - Microsoft.Insights/stable/2015-05-01/componentAnnotations_API.json
  - Microsoft.Insights/stable/2015-05-01/componentApiKeys_API.json
  - Microsoft.Insights/stable/2015-05-01/componentContinuousExport_API.json
  - Microsoft.Insights/stable/2015-05-01/componentFeaturesAndPricing_API.json
  - Microsoft.Insights/stable/2015-05-01/componentProactiveDetection_API.json
  - Microsoft.Insights/stable/2015-05-01/componentWorkItemConfigs_API.json
  - Microsoft.Insights/stable/2015-05-01/favorites_API.json
  - Microsoft.Insights/stable/2015-05-01/webTestLocations_API.json
  - Microsoft.Insights/stable/2015-05-01/webTests_API.json
  - Microsoft.Insights/stable/2015-05-01/analyticsItems_API.json
  - Microsoft.Insights/stable/2015-05-01/workbooks_API.json
  - Microsoft.Insights/stable/2015-05-01/myworkbooks_API.json
  - Microsoft.Insights/preview/2018-05-01-preview/components_API.json
  - Microsoft.Insights/preview/2020-03-01-preview/componentLinkedStorageAccounts_API.json
  - Microsoft.Insights/preview/2020-02-10-preview/WebTestResults_API.json
  - Microsoft.Insights/stable/2015-05-01/components_API.json
  - Microsoft.Insights/preview/2017-10-01/eaSubscriptionMigration_API.json
  - Microsoft.Insights/preview/2017-10-01/componentFeaturesAndPricing_API.json
  - Microsoft.Insights/preview/2018-06-17-preview/workbooks_API.json
  - Microsoft.Insights/preview/2019-10-17-preview/workbookTemplates_API.json
  - Microsoft.Insights/preview/2018-05-01-preview/componentProactiveDetection_API.json
  - Microsoft.Insights/preview/2019-09-01-preview/QueryPackQueries_API.json
  - Microsoft.Insights/preview/2019-09-01-preview/QueryPacks_API.json
  - Microsoft.Insights/preview/2020-02-02-preview/components_API.json

```